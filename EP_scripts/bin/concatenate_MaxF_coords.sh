#!/bin/bash
subjectlist=$1
subjectdir=$2
suffix=$3
encdir=$4
destinationdir=$5
ROI_list=$6
if [ ! -d $5 ]
then
mkdir -p $5/F1
mkdir $5/F2
fi

while read -r subject;
do
	dir1=$2/$subject$3/$4/positions_of_MaxFs
	dir2=$2/$subject$3/$4/positions_of_MaxF2s
	while read -r roi;
	do
		sed -n '2p' $dir1/mmcoords_"$roi".txt >> $5/F1/"$roi"_mmconcat.txt
		sed -n '2p' $dir2/mmcoords_"$roi".txt >> $5/F2/"$roi"_mmconcat.txt
	done < $6
done < $1
