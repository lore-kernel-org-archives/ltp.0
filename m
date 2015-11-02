From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Nov 2015 16:28:07 +0100
Subject: [LTP] [PATCH] commands/mkfs: Added new testcase to test mkfs(8)
 command.
In-Reply-To: <1446032247-18207-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1446032247-18207-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20151102152807.GC28478@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> +#!/bin/sh
> +#
> +# Copyright (c) 2015 Fujitsu Ltd.
> +# Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> +# the GNU General Public License for more details.
> +#
> +# Test mkfs command with some basic options.
> +#
> +
> +TCID=mkfs01
> +TST_TOTAL=5
> +. test.sh
> +
> +setup()
> +{
> +	tst_require_root
> +
> +	tst_check_cmds blkid df
> +
> +	if [ -n "$FS_TYPE" ]; then
> +		tst_check_cmds mkfs.${FS_TYPE}
> +	fi
> +
> +	tst_tmpdir
> +
> +	TST_CLEANUP="cleanup"
> +
> +	ROD_SILENT mkdir -p mntpoint
> +}
> +
> +cleanup()
> +{
> +	tst_release_device
> +
> +	tst_rmdir
> +}
> +
> +mkfs_mount()
> +{
> +	mount ${TST_DEVICE} mntpoint
> +	local ret=$?
> +	if [ $ret -eq 32 ]; then
> +		tst_brkm TCONF "Cannot mount ${FS_TYPE}, missing driver?"
> +	fi
> +
> +	if [ $ret -ne 0 ]; then
> +		tst_brkm TBROK "Failed to mount device: mount exit = $ret"
> +	fi
> +}
> +
> +mkfs_umount()
> +{
> +	grep -q ${TST_DEVICE} /proc/self/mounts
                                 ^
                            Why not just /proc/mounts?

> +	if [ $? -eq 0 ]; then
> +		umount ${TST_DEVICE}
> +		if [ $? -ne 0 ];then
> +			tst_resm TWARN "'umount ${TST_DEVICE}' failed"
> +		fi
> +	else
> +		tst_resm TINFO "${TST_DEVICE} is not mounted"
> +	fi
> +}
> +
> +usage()
> +{
> +	cat << EOF
> +	usage: $0 [-f <ext2|ext3|ext4|vfat|...>]
> +
> +	OPTIONS
> +		-f	Specify the type of filesystem to be built. If not
> +			specified, the default filesystem type (currently ext2)
> +			is used.
> +		-h	Display help text and exit.
> +
> +EOF
> +	tst_brkm TCONF "Display help text or unknown options"
                 ^
		I would rather make this TWARN, because when runtest entries
                became corrupted somehow the test would start reporting TCONF
                And that may end up being undetected for quite some time.

> +}
> +
> +mkfs_verify()
> +{
> +	if [ -z "$1" ]; then
> +		blkid | grep "$2" | grep -q "ext2"
> +	else
> +		blkid | grep "$2" | grep -q "$1"
> +	fi

You can actually pass the device to blkid as a parameter instead of grepping it
in the output.

> +}
> +
> +mkfs_check()
> +{
> +	mkfs_mount
> +	local blocknum=`df -aT | grep "$1" | awk '{print $3}'`

You can pass the mount point to the df instead of greping the device.

> +	mkfs_umount
> +
> +	if [ $blocknum -gt "$2" ]; then
> +		return 1
> +	fi

So the size we get as $2 is in kB and df -T reports 1k blocks shouldn't these
be equal, or are there any reserved block in play?

> +}
> +
> +mkfs_test()
> +{
> +	local mkfs_op=$1
> +	local fs_type=$2
> +	local fs_op=$3
> +	local device=$4
> +	local size=$5
> +
> +	if [ -n "$fs_type" ]; then
> +		mkfs_op="-t"

Why are you adding the flags by the tiniest bits?

Why don't you rather do:

	mkfs_op="-t $fs_type"

Which is far more logical.

> +	fi
> +
> +	if [ "$fs_type" = "xfs" ] || [ "$fs_type" = "btrfs" ]; then
> +		fs_op+=" -f"

This is bashism. You have to do fs_op="$fs_op -f" instead.

> +	fi
> +
> +	local mkfs_cmd="mkfs $mkfs_op $fs_type $fs_op $device $size"
> +	mkfs_cmd=`echo "$mkfs_cmd" | sed 's/\s\+/ /g'`

This is just cosmetic, isn't it? I would just omit it.

> +	echo ${fs_op} | grep -q "\-c"
> +	if [ $? -eq 0 ] && [ "$fs_type" = "ntfs" ]; then
> +		tst_resm TCONF "'${mkfs_cmd}' not supported."
> +		return 32

		This is fairly misleading. It would be better to use return 0
                in case when you just need to exit the function. Because returning
                different values and ingoring them later is misleading.

> +	fi
> +
> +	if [ -n "$size" ]; then
> +		if [ "$fs_type" = "xfs" ] || [ "$fs_type" = "btrfs" ]; then
> +			tst_resm TCONF "'${mkfs_cmd}' not supported."
> +			return 32

                        Here as well.

> +		fi
> +	fi
> +
> +	${mkfs_cmd} >temp 2>&1
> +	if [ $? -ne 0 ]; then
> +		grep -q -E "unknown option | invalid option" temp
> +		if [ $? -eq 0 ]; then
> +			tst_resm TCONF "'${mkfs_cmd}' not supported."
> +			return 32
> +		else
> +			tst_resm TFAIL "'${mkfs_cmd}' failed."
> +			cat temp
> +			return 1
> +		fi
> +	fi
> +
> +	if [ -n "$device" ]; then
> +		mkfs_verify "$fs_type" "$device"
> +		if [ $? -ne 0 ]; then
> +			tst_resm TFAIL "'${mkfs_cmd}' failed, not expected."
> +			return 1
> +		fi

We should name the function better, mkfs_verify_type() comes to mind.

> +	fi
> +
> +	if [ -n "$size" ]; then
> +		mkfs_check "$device" "$size"
> +		if [ $? -ne 0 ]; then
> +			tst_resm TFAIL "'${mkfs_cmd}' failed, not expected."
> +			return 1
> +		fi
> +	fi

Here as well, mkfs_verify_size would be better.

> +	tst_resm TPASS "'${mkfs_cmd}' passed."
> +}
> +
> +test1()
> +{
> +	tst_acquire_device
> +
> +	mkfs_test "$MKFS_OP" "$FS_TYPE" "$FS_OP" "$TST_DEVICE"
> +
> +	tst_release_device
> +}
> +
> +test2()
> +{
> +	tst_acquire_device
> +
> +	mkfs_test "$MKFS_OP" "$FS_TYPE" "$FS_OP" "$TST_DEVICE" "10000"

Can you just pass empty string when it should be empty instead of passing empty
global variable?

It's more confusing than it could be this way.

> +	tst_release_device
> +}
> +
> +test3()
> +{
> +	tst_acquire_device
> +
> +	mkfs_test "$MKFS_OP" "$FS_TYPE" "-c" "$TST_DEVICE"
> +
> +	tst_release_device
> +}

Why don't we acquire device once in the setup and release it in the cleanup?

> +test4()
> +{
> +	mkfs_test "-V"
> +}
> +
> +test5()
> +{
> +	mkfs_test "-h"
> +}
> +
> +MKFS_OP=""
> +FS_TYPE=""
> +FS_OP=""
> +
> +if [ $# -ne 0 ]; then
> +	while getopts f:h OPTION; do
> +		case $OPTION in
> +		f)
> +			FS_TYPE=$OPTARG;;
> +		h)
> +			usage;;
> +		?)
> +			usage;;
> +		esac
> +	done
> +
> +	if [ -z "$FS_TYPE" ]; then
> +		usage
> +	fi
> +fi

Eh, why just not:

while getopts f:h OPTION; do
        case $OPTION in
        f)
                FS_TYPE=$OPTARG;;
        h)
                usage;;
        ?)
                usage;;
        esac
done

> +setup
> +for i in $(seq 1 ${TST_TOTAL})
> +do
> +	test$i
> +done
> +
> +tst_exit
> -- 
> 1.8.4.2
> 
> 
> -- 
> Mailing list info: http://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
