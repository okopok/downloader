#!/usr/bin/env bash

# readonly lockfile=/tmp/wgetsync;

PROJECT_PATH=`cd "$(dirname "$0")/"; pwd` # double quotes for paths that contain spaces etc...

source ${PROJECT_PATH}/config.sh


# function __myExit ()
# {
# 	if [[ $(pgrep wget | wc -l) -eq 0 ]]; then
# 		rm -rf ${lockfile}
# 	fi;
# }

# запускается при завершении скрипта
# trap '__myExit' EXIT

set -x;

function myWget() {
	local pathFrom=$1
	local pathTo=$2;
	local mycutDirs=$3
	local mylogFile=$4
	wget --show-progress --cut-dirs=${mycutDirs} --retry-connrefused -b -np -nH -c -l0 -m -a${mylogFile} --directory-prefix=${pathTo} ${pathFrom}
}

# if ! [[ -f ${lockfile} ]]; then
if [[ ${isRunning} -eq 0 ]]; then
	# touch ${lockfile}

	echo "синхронизирую ${srcPath} >> ${destPath}";
	myWget ${srcPath} ${destPath} ${cutDirs} ${logFile}

	# echo "синхронизирую Series";
	# myWget ${srcPathSeries} ${destPathSeries} ${cutDirs} ${logFile}

	# rm -rf ${lockfile}
else
	echo "Запущен другой процесс wget"
	pgrep -l wget;
fi;

set +x;
