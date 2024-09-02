#!/bin/bash

for file in *.abi.*; do
	# 删除文件名中的 .abi 字符串
	new_file="${file/.abi/}"

	# 重命名文件
	mv "$file" "$new_file"
done
