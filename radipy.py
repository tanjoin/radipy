import base64
import datetime
import subprocess
import sys
import threading
import time
from pathlib import Path
from xml.etree import ElementTree as ET

import click
import requests
from prettytable import PrettyTable

DATE = datetime.datetime.strftime(datetime.datetime.now(), '%Y-%m-%d-%H')
TMP_PATH = Path('./tmp').resolve()
if not TMP_PATH.exists():
    print('Create tmp dir. path: {}'.format(str(TMP_PATH)))
    TMP_PATH.mkdir(parents=True)

OUTPUT_PATH = Path('./output').resolve()
if not OUTPUT_PATH.exists():
    print('Create output dir. path: {}'.format(str(OUTPUT_PATH)))
    TMP_PATH.mkdir(parents=True)

PLAYERFILE_PATH = Path(TMP_PATH, 'player.{}.swf'.format(DATE))
KEYFILE_PATH = Path(TMP_PATH, 'authkey.{}.jpg'.format(DATE))
PLAYLISTFILE_PATH = Path(TMP_PATH, 'playlist.{}.m3u8'.format(DATE))


# http://stackoverflow.com/questions/4995733/how-to-create-a-spinning-command-line-cursor-using-pythonのパクリ
class Spinner:
    busy = False
    delay = 0.5

    @staticmethod
    def spinning_cursor():
        while 1:
            for cursor in '|/-\\':
                yield cursor

    def __init__(self, delay=None):
        self.spinner_generator = self.spinning_cursor()
        if delay and float(delay):
            self.delay = delay

    def spinner_task(self):
        while self.busy:
            sys.stdout.write(next(self.spinner_generator))
            sys.stdout.flush()
            time.sleep(self.delay)
            sys.stdout.write('\b')
            sys.stdout.flush()

    def start(self):
        self.busy = True
        threading.Thread(target=self.spinner_task).start()

    def stop(self):
        self.busy = False
        time.sleep(self.delay)


class Response(object):
    def __init__(self, *args, **kwargs):
        for k, v in kwargs.items():
            self.__setattr__(k, v)


class Radipy(object):
    player_url = 'http://radiko.jp/apps/js/flash/myplayer-release.swf'
    fms1_url = 'https://radiko.jp/v2/api/auth1_fms'
    fms2_url = 'https://radiko.jp/v2/api/auth2_fms'
    LANG = 'ja_JP.utf8'
    auth_response = Response()
    auth_success_response = Response()

    def __init__(self, station_id, ft):
        self.station_id = station_id
        self.ft = ft
        self.partialkey = ''
        self.stream_url = ''
        self.area_id = ''
        self.title = ''

    @staticmethod
    def clear():
        subprocess.call('rm -v {}/*.jpg'.format(TMP_PATH, shell=True))
        subprocess.call('rm -v {}/*.swf'.format(TMP_PATH, shell=True))

    def authenticate(self):
        self._get_playerfile()
        self._get_keyfile()
        self._get_auth1()
        self._generate_partialkey()
        self._get_auth2()
        print('-' * 20)
        print('authentication success.')

    def get_channels(self):
        self.authenticate()
        self._get_area_id()
        self._get_area_channels()

    def get_programs(self, dt=datetime.datetime.now()):
        self.authenticate()
        self._get_area_id()
        date = datetime.datetime.strftime(dt, '%Y%m%d')
        datetime_api_url = 'http://radiko.jp/v3/program/date/{}/{}.xml'.format(date[:8], self.area_id)
        res = requests.get(url=datetime_api_url)
        channels_xml = res.content
        tree = ET.fromstring(channels_xml)
        station = tree.find('.//station[@id="{}"]'.format(self.station_id))
        progs = station.findall('.//prog')
        for prog in progs:
            title = prog.find('.//title').text
            ft = prog.attrib['ft']
            print(ft, title)

    def create(self):
        self.authenticate()
        self._get_area_id()
        self._get_stream_url()
        spinner = Spinner()
        print("Now Downloading...")
        spinner.start()
        if self._create_aac():
            print('finish!!')
        else:
            print('failed!!')
        spinner.stop()

    def _get_playerfile(self):
        if PLAYERFILE_PATH.exists():
            print('playerFile already exists.')
        else:
            print('create playerFile...')
            res = requests.get(self.player_url)
            if res.status_code == 200:
                with PLAYERFILE_PATH.open('wb') as file:
                    file.write(res.content)
            if not PLAYERFILE_PATH.exists():
                print('playerfile is not created.')
                exit()

    def _get_keyfile(self):
        if KEYFILE_PATH.exists():
            print('keyfile already exists.')
        else:
            print('create KeyFile...')
            subprocess.call('swfextract -b 12 {} -o {}'.format(PLAYERFILE_PATH, KEYFILE_PATH), shell=True)
            if not KEYFILE_PATH.exists():
                print('keyfile is not created. confirm swfextract is installed.')
                exit()

    def _get_auth1(self):
        print('access auth1_fms...')
        headers = {
            'Host': 'radiko.jp',
            'pragma': 'no-cache',
            'X-Radiko-App': 'pc_ts',
            'X-Radiko-App-Version': '4.0.0',
            'X-Radiko-User': 'test-stream',
            'X-Radiko-Device': 'pc'
        }
        res = requests.post(url=self.fms1_url, headers=headers)
        self.auth_response.body = res.text
        self.auth_response.headers = res.headers
        self.auth_response.authtoken = self.auth_response.headers['x-radiko-authtoken']
        self.auth_response.offset = int(self.auth_response.headers['x-radiko-keyoffset'])
        self.auth_response.length = int(self.auth_response.headers['x-radiko-keylength'])

    def _generate_partialkey(self):
        print('generate particleKey...')
        with KEYFILE_PATH.open('rb+') as file:
            file.seek(self.auth_response.offset)
            data = file.read(self.auth_response.length)
            self.partialkey = base64.b64encode(data)

    def _get_auth2(self):
        print('access auth2_fms...')
        headers ={
          'pragma': 'no-cache',
          'X-Radiko-App': 'pc_ts',
          'X-Radiko-App-Version': '4.0.0',
          'X-Radiko-User': 'test-stream',
          'X-Radiko-Device': 'pc',
          'X-Radiko-Authtoken': self.auth_response.authtoken,
          'X-Radiko-Partialkey': self.partialkey,
        }
        res = requests.post(url=self.fms2_url, headers=headers)
        self.auth_success_response.body = res.text
        self.auth_success_response.headers = res.headers

    def _get_area_id(self):
        area = self.auth_success_response.body.strip().split(',')
        self.area_id = area[0]
        print('area_id: {}'.format(self.area_id))

    def _get_area_channels(self):
        area_api_url = "http://radiko.jp/v3/station/list/{}.xml".format(self.area_id)
        res = requests.get(url=area_api_url)
        channels_xml = res.content
        tree = ET.fromstring(channels_xml)
        stations = tree.findall('.//station')
        table = PrettyTable(['id', '名前'])
        table.align['station_id'] = 'l'
        table.align['station_name'] = 'l'
        table.padding_width = 2
        for station in stations:
            row = []
            for child in station.iter():
                if child.tag in ('id', 'name'):
                    row.append(child.text)
            table.add_row(row)
        print(table)

    def _get_stream_url(self):
        try:
            datetime_api_url = 'http://radiko.jp/v3/program/date/{}/{}.xml'.format(self.ft[:8], self.area_id)
            res = requests.get(url=datetime_api_url)
            channels_xml = res.content
            tree = ET.fromstring(channels_xml)
            station = tree.find('.//station[@id="{}"]'.format(self.station_id))
            prog = station.find('.//prog[@ft="{}"]'.format(self.ft))
            to = prog.attrib['to']

        # 日を跨いでいる場合は前の日の番組表を探す
        except AttributeError:
            pre_date = datetime.datetime.strptime(self.ft[:8], '%Y%m%d') - datetime.timedelta(days=1)
            datetime_api_url = 'http://radiko.jp/v3/program/date/{}/{}.xml'.format(pre_date.strftime('%Y%m%d'), self.area_id)
            res = requests.get(url=datetime_api_url)
            channels_xml = res.content
            tree = ET.fromstring(channels_xml)
            station = tree.find('.//station[@id="{}"]'.format(self.station_id))
            prog = station.find('.//prog[@ft="{}"]'.format(self.ft))
            to = prog.attrib['to']

        self.title = prog.find('.//title').text.replace(' ', '_').replace('　', '_')
        table = PrettyTable(['title'])
        table.add_row([self.title])
        table.padding_width = 2
        print(table)
        self.stream_url = 'https://radiko.jp/v2/api/ts/playlist.m3u8?l=15&station_id={}&ft={}&to={}'.format(
            self.station_id,
            self.ft,
            to
        )

    def _create_aac(self):
        try:
            program_dir = Path(OUTPUT_PATH, self.title)
            if not program_dir.exists():
                print('create program dir: {}'.format(program_dir))
                program_dir.mkdir()
            aac_file = Path(program_dir, '{}_{}.aac'.format(self.title, self.ft[:8]))
            cmd = ('ffmpeg '
                   '-loglevel fatal '
                   '-n -headers "X-Radiko-AuthToken: {}" '
                   '-i "{}" '
                   '-vn -acodec copy "{}"'.format(
                    self.auth_response.authtoken,
                    self.stream_url,
                    aac_file
                    ))
            subprocess.call(cmd, shell=True)
            print('create aac file: {}'.format(aac_file))
            return True
        except Exception:
            return False


@click.command(help='Radipy is CLI radiko Downloader written by python3.')
@click.option('-a', '--area', is_flag=True, help='print station id & name in your area')
@click.option('-ls', is_flag=True, help='print program titles & start time. using with -id option')
@click.option('-dt', type=click.DateTime(), help='print program titles & start time. using with -ls, -id option')
@click.option('-id', type=str, help='set station id')
@click.option('-ft', type=str, help='set start datetime str formated by yyyyMMddHHmm e.g. 201804171830')
@click.option('--clear', is_flag=True, help='clear authkey and player in tmp dir')
def main(area, id, ft, ls, clear, dt):
    if clear:
        Radipy.clear()
    elif area:
        radipy = Radipy(0, 0)
        radipy.get_channels()
    elif id and ft:
        radipy = Radipy(station_id=id, ft=ft)
        radipy.create()
    elif id and ls and dt:
        radipy = Radipy(station_id=id, ft=0)
        radipy.get_programs(dt=dt)
    elif id and ls:
        radipy = Radipy(station_id=id, ft=0)
        radipy.get_programs()


if __name__ == '__main__':
    main()
