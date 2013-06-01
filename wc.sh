#!/bin/bash
 
pages_requested=10
characters_per_page=2400

# This can be set absolute or relative to script
file_path='chapters/'

# file type of the files you want to count on
file_type='.md'

files=$(find $file_path*$file_type -type f -maxdepth 1 \( ! -iname ".*" \))
 
function countcompare {
  images=`grep -c '.png' $1`
	chars=`wc -c $1 | awk '{split($0,array," ")} END{print array[1]}'`
	chars_with_images=$((chars+images*700))
	chars_required=$(($pages_requested * $characters_per_page))
	chars_to_go=$(($chars_required - $chars_with_images))
	percentage_done=$(echo "scale=2; $chars_with_images / $chars_required * 100" | bc)
	
	echo $percentage_done'% done of' $1
	echo $chars_with_images of $chars_required
	echo $(($images*700)) from $images images
	echo $chars_to_go 'to go'
	echo ''
}
 
echo '# # # # # # # # # # # # # # # # # # # # # # # # #'
 
for file in ${files[@]}
do
	countcompare $file
done
