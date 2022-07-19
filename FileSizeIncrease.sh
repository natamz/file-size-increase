#!/bin/sh

if [ $# -ne 2 ]; then
  echo "Argument error."
  sleep 3
  exit 1
fi

input_file=$1
size=$2

if [ ! -e $input_file ]; then
  echo "File not exists."
  sleep 3
  exit 1
fi

temp_file=temp.dat

frac=$(expr $size - $(stat --printf="%s" $input_file))

if [ $frac -lt 0 ]; then
  echo "Low file size."
  sleep 3
  exit 1
fi

dd if=/dev/zero of=$temp_file bs=1 count=$frac

output_file="${input_file%.*}-${size}.${input_file##*.}"
cat $input_file $temp_file >$output_file

rm $temp_file

echo 'completed.'
sleep 3
