#!/usr/bin/env bash

# откуда качаем
readonly srcPrefix=ftp://molo:iqt6GeU57@wzrist.iseedfast.com:/downloads/manual
readonly cutDirs=3

# что синхронизируем
srcPath=${srcPrefix}

# куда синхронизируем
destPath=$HOME

readonly isRunning=$(pgrep wget | wc -l)

source ${PROJECT_PATH}/arguments.sh

readonly TODAY_DIR=`date +%Y.%m.%d`

logDir=${logDir}/${TODAY_DIR}

# создаём архивную папку, если надо и двигаем лог в архив
moveFile=1;
if [[ ! -d ${logDir} ]]; then
  moveFile=0;
  if ( mkdir -p ${logDir}; ); then
	# папку создали, двигаем файл
	moveFile=1;
  fi
fi

readonly logFile=${logDir}/wgetsync.log
