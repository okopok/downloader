#!/usr/bin/env bash

print_help()
{
  echo ""
  echo "All values are separated from the options with a space"
  echo "-s --src: откуда берём файлы"
  echo "-d --dest: куда складываем"
  echo "-l --log: куда складываем логи"
}

print_error()
{
  local RED='\033[31m'
  local NC='\033[0m' # No Color
  echo ""
  echo -e "${RED}ERROR: $1${NC}" >&2
  print_help
  exit 1
}

while :; do
    case $1 in
        -s|--src)
            if [ -n "$2" ]; then
                srcPath=${srcPrefix}/$2
                shift
            else
              print_error "$1 requires a non-empty option argument."
            fi
            ;;
        -d|--dest)

            if [ -n "$2" ]; then
                destPath=$2
                shift
            else
                print_error "$1 requires a non-empty option argument."
            fi
            ;;
        -l|--log)

            if [ -n "$2" ]; then
                logDir=$2
                shift
            else
                print_error "$1 requires a non-empty option argument."
            fi
            ;;
        -h|--help)
            print_help
            exit 0
          ;;
        --)
            shift
            break
            ;;
        -?*)
            print_error "Unknown option: $1"
            ;;
        *)               # Default case: If no more options then break out of the loop.
            break
    esac

    shift
done


if [[ -z "${srcPath}" ]] || [[ -z "${destPath}" ]] || [[ -z "${logDir}" ]]; then
    print_error "Required --src and --dest and --log parameters"
fi
