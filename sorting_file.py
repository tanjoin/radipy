import os
import sys
import shutil
from difflib import SequenceMatcher
from difflib import get_close_matches


def get_archives_and_video_music():
    # アーカイブにあるディレクトリ名を取得
    archives = [name for name in os.listdir(
        "output3") if os.path.isdir(os.path.join("output3", name))]

    # ディレクトリ内のmp4を列挙
    video_and_music = []
    for file in os.listdir():
        base, ext = os.path.splitext(file)
        if ext == '.mp4':
            video_and_music.append(file)
        elif ext == '.mkv':
            video_and_music.append(file)
        elif ext == '.m4a':
            video_and_music.append(file)
    return archives, video_and_music


def get_dir_name(keyword, video_list) -> str:
    result = get_close_matches(keyword, video_list, n=3, cutoff=0.7)
    if len(result) == 0:
        return None, None
    dir_names = []
    for v in result:
        matches = SequenceMatcher(None, keyword, v).get_matching_blocks()
        max_str = ""
        for match in matches:
            dirname = keyword[match.a:match.a + match.size]
            if len(max_str) < len(dirname):
                max_str = dirname
        dir_names.append(max_str.removesuffix('-'))
    dir_names2 = list(filter(lambda x: x.startswith('.') is False, dir_names))
    dir_names2 = list(filter(lambda x: x.startswith('-') is False, dir_names2))
    if len(dir_names2) == 0:
        return None, None
    return [x for x in dir_names2 if x == min(dir_names2, key=len)][0], result


def get_partial_match(keyword, video_list):
    result = []
    for v in video_list:
        if keyword in v:
            result.append(v)
    return keyword, result


def move_archives(keyword, video_list, func):
    title, results = func(keyword, video_list)
    if title is None:
        return
    if results is None:
        return
    if len(results) == 0:
        return
    if func == get_partial_match:
        print('-> {} is found.'.format(keyword))
    dir_path = 'output3/{}'.format(title.replace('.mp4', '').replace('.m4a', ''))
    os.makedirs(dir_path, exist_ok=True)
    for v in results:
        try:
            print(shutil.move(v, dir_path))
        except Exception as e:
            print(e)


archives, video_and_music = get_archives_and_video_music()


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


if len(video_and_music) == 0:
    print('{}video not found.{}'.format(bcolors.WARNING, bcolors.ENDC))
    sys.exit()

print('-> {}'.format(video_and_music[0]))

for archive in archives:
    move_archives(archive, video_and_music, get_partial_match)
    move_archives(archive, video_and_music, get_dir_name)

if (os.path.exists(video_and_music[0])):
    move_archives(video_and_music[0], video_and_music, get_dir_name)
else:
    print('{}{} is alrady archived.{}'.format(
        bcolors.OKCYAN, video_and_music[0], bcolors.ENDC))
