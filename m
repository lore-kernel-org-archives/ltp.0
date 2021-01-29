From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 16:22:33 +0100
Subject: [LTP] [PATCH] quota_remount_test01: update to new API
In-Reply-To: <20210128171052.6025-1-kory.maincent@bootlin.com>
References: <20210128171052.6025-1-kory.maincent@bootlin.com>
Message-ID: <YBQoOX2FLtig8rYQ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory,

> Update to new API
> Add test on quota_v2 driver to avoid the above error:
>   quotaon: Quota format not supported in kernel.
+1

...
> +TST_NEEDS_CMDS="quotacheck quotaon mkfs.ext3"
TST_NEEDS_CMDS="dd mkfs.ext3 mount quota quotacheck quotaon sed tail"
sed and tail are a bit paranoic but it helps to run everywhere.

> +TST_NEEDS_DRIVERS="quota_v2"
> +TST_NEEDS_TMPDIR=1
> +TST_SETUP=do_setup
> +TST_CLEANUP=do_clean
> +TST_TESTFUNC=do_test

TST_NEEDS_ROOT=1
mount requires root.

...
> +do_setup()
> +{
> +	if tst_kvcmp -lt "2.6.25"; then
> +	        tst_res TCONF "Remounting with quotas enabled is not supported!"
> +	        tst_brk TCONF "You should have kernel 2.6.26 and above running....."
Please when using TCONF, use it only once (tst_brk TCONF "test require 2.6.26")
But new API has TST_MIN_KVER="2.6.26" which is better for this test, tst_kvcmp
is needed for some special cases (skipping only single test etc).

> +	fi
> +
> +	if [ ! -d /proc/sys/fs/quota ]; then
> +	        tst_brk TCONF "Quota not supported in kernel!"
> +	        exit 0
> +	fi
> +	MNTDIR=$TMPDIR/mnt
> +	IMAGE=ltp-$$-fs-image
> +	dd if=/dev/zero of=$IMAGE bs=4096 count=8000 2>/dev/null
> +	mkfs.ext3 -q -F -b 4096 $IMAGE
> +	mkdir $MNTDIR
> +}

> +do_clean()
>  {
>  	umount 2>/dev/null $MNTDIR
>  	rm 2>/dev/null $IMAGE

Cleanup should use tst_umount, removing file is not necessary.
And there should be guarded with flag to try umount only when mounted:

do_clean()
{
	[ "$mounted" ] || return
	tst_umount $MNTDIR
}

And in do_test():

ROD mount -t ext3 -o loop,usrquota,grpquota $IMAGE $MNTDIR
mounted=1

> +do_test()
> +{
> +	EXPECT_PASS mount -t ext3 -o loop,usrquota,grpquota $IMAGE $MNTDIR
> +	tst_res TINFO "Successfully mounted the File System"
Here I'd use just ROD instead of EXPECT_PASS. ROD is used on preparation
commands, on failure ($? -ne 0) prints the command and quit testing,
which is required here (there is no point to continue if mount fails.
If this were subject of testing EXPECT_PASS_BRK could be used
(EXPECT_PASS just TFAIL, but continue testing).

But I'd use ROD for most of the commands, IMHO only $BLOCKS -eq $NEWBLOCKS check
is the test case. Or am I wrong?

tst_res TINFO messages are definitely useless (regardless whether ROD or
EXPECT_PASS* is used) + we don't use that camel case.

NOTE mount is here and not in setup to allow running test more than once
with -iN (N is a positive number).

	ROD mount -t ext3 -o loop,usrquota,grpquota $IMAGE $MNTDIR
	mounted=1

> +
> +	# some distros (CentOS 6.x, for example) doesn't permit creating
> +	# of quota files in a directory with SELinux file_t type
> +	if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
> +		chcon -t tmp_t $MNTDIR || tst_brk TFAIL "Could not change SELinux file type"
Not sure if "Could not change SELinux file type" is bug or configuration issue.
I'd personally consider it as config issue and use TCONF here. But maybe I'm
wrong.

> +		tst_res TINFO "Successfully changed SELinux file type"
> +	fi
> +
> +	EXPECT_PASS quotacheck -cug $MNTDIR
> +	tst_res TINFO "Successfully Created Quota Files"
> +
> +	EXPECT_PASS quotaon -ug $MNTDIR
> +	tst_res TINFO "Successfully Turned on Quota"
> +
> +	EXPECT_PASS echo "blah" />$MNTDIR/file
> +	tst_res TINFO "Successfully wrote to the filesystem"
> +
> +	# Get current quota usage
> +	BLOCKS=`quota  -f $MNTDIR -v -w | tail -n 1 | sed -e 's/ *[^ ]* *\([0-9]*\) .*/\1/'`
> +	EXPECT_PASS mount -o remount,ro $MNTDIR
> +	tst_res TINFO "Successfully Remounted Read-Only FS"
> +
> +	EXPECT_PASS mount -o remount,rw $MNTDIR
> +	tst_res TINFO "Successfully Remounted Read-Write FS"
> +
> +	rm $MNTDIR/file
> +	# Get quota usage after removing the file
> +	NEWBLOCKS=`quota  -f $MNTDIR -v -w | tail -n 1 | sed -e 's/ *[^ ]* *\([0-9]*\) .*/\1/'`
> +	# Has quota usage changed properly?
> +	if [ $BLOCKS -eq $NEWBLOCKS ]; then
> +	   tst_brk TWARN "Usage did not change after remount"
I consider this as an error.

On one of my VM I see
Error relocating /usr/bin/quota: reallocarray: symbol not found
quota_remount_test01 1 TWARN: usage did not change after remount
=> obviously quota needs some fix here :).

> +	fi
> +	tst_res TINFO "Usage successfully Changed after Remount"
> +	tst_res TPASS "Quota on Remount Successfull"
> +}
...

I suggest to merge this (adapting test for more runs, using ROD, adding
get_blocks(), ...).
Just waiting Jan and Li for info about SELinux.

Kind regards,
Petr

#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (c) Jan Kara <jack@suse.cz>, 2008
# Copyright (c) International Business Machines  Corp., 2009
# Copyright (c) K?ry Maincent <kory.maincent@bootlin.com> 2021
# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>

TST_NEEDS_CMDS="dd mkfs.ext3 mount quota quotacheck quotaon sed tail"
TST_NEEDS_DRIVERS="quota_v2"
TST_NEEDS_ROOT=1
TST_NEEDS_TMPDIR=1
TST_SETUP=do_setup
TST_CLEANUP=do_clean
TST_TESTFUNC=do_test
TST_MIN_KVER="2.6.26"

. tst_test.sh

do_setup()
{
	if [ ! -d /proc/sys/fs/quota ]; then
		tst_brk TCONF "quota not supported in kernel"
	fi

	MNTDIR="mnt.$$"
	IMAGE="ltp-$$-fs-image"
	ROD dd if=/dev/zero of=$IMAGE bs=4096 count=8000 2>/dev/null
	ROD mkfs.ext3 -q -F -b 4096 $IMAGE
	mkdir $MNTDIR
}

do_clean()
{
	[ "$mounted" ] || return
	tst_umount $MNTDIR
	mounted=
}

get_blocks()
{
	quota -f $MNTDIR -v -w | tail -n 1 | sed -e 's/ *[^ ]* *\([0-9]*\) .*/\1/'
}

do_test()
{
	tst_res TINFO "testing quota on remount"

	local blocks newblocks

	ROD mount -t ext3 -o loop,usrquota,grpquota $IMAGE $MNTDIR
	mounted=1

	# some distros (CentOS 6.x, for example) doesn't permit creating
	# of quota files in a directory with SELinux file_t type
	if tst_selinux_enabled &&
		tst_cmd_available chcon && ! chcon -t tmp_t $MNTDIR; then
			tst_brk TCONF "could not change SELinux file type"
	fi

	ROD quotacheck -cug $MNTDIR
	ROD quotaon -ug $MNTDIR
	ROD echo "blah" />$MNTDIR/file

	blocks=$(get_blocks)
	ROD mount -o remount,ro $MNTDIR
	ROD mount -o remount,rw $MNTDIR

	ROD rm $MNTDIR/file
	newblocks=$(get_blocks)

	if [ $blocks -eq $newblocks ]; then
	   tst_brk TFAIL "usage did not change after remount"
	fi

	tst_res TPASS "quota on remount passed"

	do_clean
}

tst_run
