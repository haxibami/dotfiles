#!/bin/bash

# requirement: pdftoppm, pdftk, tesseract

if ! type "pdftoppm" > /dev/null 2>&1 || ! type "pdftk" > /dev/null 2>&1 || ! type "tesseract" > /dev/null 2>&1; then
  echo "Install pdftoppm, pdftk, and tesseract!"
  exit 1
fi

targetfile="$1"
targetname="${1%.pdf}"
lang="$2"
output="$3"

# convert to png image
mkdir "${targetname}.tmp"
# - png
pdftoppm -png "${targetfile}" "${targetname}.tmp/page"

# tesseract
# - png
find "./${targetname}.tmp" -type f -name "*.png" | sed 's/\.png$//' | xargs -P8 -n1 -I% tesseract %.png % -l ${lang} ${output}

# Unite
if [ ${output} = "pdf" ]; then
  pdftk "./${targetname}.tmp"/*.pdf cat output "${targetname}-ocr.pdf"
elif [ ${output} = "txt" ]; then
  cat "./${targetname}.tmp"/*.txt > "${targetname}-ocr.txt"
  sed -i -e 's/ //g' "${targetname}-ocr.txt"
fi

# Clear
rm -r "./${targetname}.tmp"
