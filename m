From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Apr 2020 14:29:08 +0200
Subject: [LTP] [PATCH v5 2/3] Add LVM support scripts
In-Reply-To: <20200414085934.8840-2-mdoucha@suse.cz>
References: <20200414085934.8840-1-mdoucha@suse.cz>
 <20200414085934.8840-2-mdoucha@suse.cz>
Message-ID: <20200414122908.GA6700@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> 
> Changes since v1:
> - rename generate_runfile.sh to generate_lvm_runfile.sh
> - update above commit message
> 
> Changes since v2:
> - fix filename in misc/lvm/Makefile
> 
> Changes since v3:
> - LVM volume size increased to 1GB
> - cleaned up some useless code in runfile template
> - test cases with `growfiles -L ...` limited to 768MB of disk space
> 
> Changes since v4:
> - rebase only
> 
>  testcases/misc/lvm/Makefile                | 29 ++++++++
>  testcases/misc/lvm/cleanup_lvm.sh          | 34 +++++++++
>  testcases/misc/lvm/datafiles/Makefile      | 19 +++++
>  testcases/misc/lvm/datafiles/runfile.tpl   | 36 ++++++++++
>  testcases/misc/lvm/generate_lvm_runfile.sh | 27 +++++++
>  testcases/misc/lvm/prepare_lvm.sh          | 83 ++++++++++++++++++++++
>  6 files changed, 228 insertions(+)
>  create mode 100644 testcases/misc/lvm/Makefile
>  create mode 100755 testcases/misc/lvm/cleanup_lvm.sh
>  create mode 100644 testcases/misc/lvm/datafiles/Makefile
>  create mode 100644 testcases/misc/lvm/datafiles/runfile.tpl
>  create mode 100755 testcases/misc/lvm/generate_lvm_runfile.sh
>  create mode 100755 testcases/misc/lvm/prepare_lvm.sh
> 
> diff --git a/testcases/misc/lvm/Makefile b/testcases/misc/lvm/Makefile
> new file mode 100644
> index 000000000..3dbc996c8
> --- /dev/null
> +++ b/testcases/misc/lvm/Makefile
> @@ -0,0 +1,29 @@
> +#
> +#    misc/lvm testcases Makefile.
> +#
> +#    Copyright (C) 2009, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Ngie Cooper, July 2009
> +#

Just use the SPDX here.

> +
> +top_srcdir		?= ../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +INSTALL_TARGETS		:= generate_lvm_runfile.sh prepare_lvm.sh cleanup_lvm.sh
> +
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/misc/lvm/cleanup_lvm.sh b/testcases/misc/lvm/cleanup_lvm.sh
> new file mode 100755
> index 000000000..e18efe2b0
> --- /dev/null
> +++ b/testcases/misc/lvm/cleanup_lvm.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
> +#
> +# Clean up LVM volume groups created by prepare_lvm.sh
> +
> +TST_TESTFUNC=cleanup_lvm
> +TST_NEEDS_ROOT=1
> +TST_NEEDS_CMDS="losetup umount vgremove"
> +. tst_test.sh
> +
> +LVM_TMPDIR="/tmp/ltp/growfiles"
> +LVM_IMGDIR="/tmp/ltp/imgfiles"
> +
> +cleanup_lvm()
> +{
> +	DEVLIST=`losetup -lnO NAME,BACK-FILE | grep "$LVM_IMGDIR" | cut -d ' ' -f 1`
> +
> +	for dir in "$LVM_TMPDIR/"*; do
> +		tst_umount $dir
> +	done
> +
> +	ROD vgremove -y ltp_test_vg1
> +	ROD vgremove -y ltp_test_vg2
> +
> +	for devname in $DEVLIST; do
> +		ROD tst_device release $devname
> +	done
> +
> +	rm -rf /tmp/ltp
> +	tst_res TPASS "LVM configuration for LTP removed successfully."
> +}
> +
> +tst_run
> diff --git a/testcases/misc/lvm/datafiles/Makefile b/testcases/misc/lvm/datafiles/Makefile
> new file mode 100644
> index 000000000..25455ccbf
> --- /dev/null
> +++ b/testcases/misc/lvm/datafiles/Makefile
> @@ -0,0 +1,19 @@
> +#
> +#    Copyright (C) 2020, Linux Test Project.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.

And here as well.

> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +INSTALL_DIR		:= testcases/data/lvm
> +INSTALL_TARGETS		:= runfile.tpl
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/misc/lvm/datafiles/runfile.tpl b/testcases/misc/lvm/datafiles/runfile.tpl
> new file mode 100644
> index 000000000..0c6080236
> --- /dev/null
> +++ b/testcases/misc/lvm/datafiles/runfile.tpl
> @@ -0,0 +1,36 @@
> +# Check the {fsname} filesystem
> +{fsname}_gf02 growfiles -W {fsname}_gf02 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -L 10 -B 805306368 -i 100 -I p -S 2 -u -f gf03_
> +{fsname}_gf03 growfiles -W {fsname}_gf03 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
> +{fsname}_gf04 growfiles -W {fsname}_gf04 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
> +{fsname}_gf05 growfiles -W {fsname}_gf05 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
> +{fsname}_gf16 growfiles -W {fsname}_gf16 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -i 0 -L 120 -B 805306368 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
> +{fsname}_gf17 growfiles -W {fsname}_gf17 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -i 0 -L 120 -B 805306368 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
> +{fsname}_gf18 growfiles -W {fsname}_gf18 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -i 0 -L 120 -B 805306368 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
> +{fsname}_gf19 growfiles -W {fsname}_gf19 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
> +{fsname}_gf12 mkfifo /tmp/ltp/growfiles/{fsname}/gffifo17; growfiles -W {fsname}_gf12 -b -e 1 -u -i 0 -L 30 -B 805306368 /tmp/ltp/growfiles/{fsname}/gffifo17
> +{fsname}_gf13 mkfifo /tmp/ltp/growfiles/{fsname}/gffifo18; growfiles -W {fsname}_gf13 -b -e 1 -u -i 0 -L 30 -B 805306368 -I r -r 1-4096 /tmp/ltp/growfiles/{fsname}/gffifo18
> +{fsname}_gf01 growfiles -W {fsname}_gf01 -b -e 1 -u -i 0 -L 20 -B 805306368 -w -C 1 -l -I r -T 10 /tmp/ltp/growfiles/{fsname}/glseek20 /tmp/ltp/growfiles/{fsname}/glseek20.2
> +{fsname}_gf06 growfiles -W {fsname}_gf06 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -B 805306368 -C 1 /tmp/ltp/growfiles/{fsname}/g_rand10 /tmp/ltp/growfiles/{fsname}/g_rand10.2
> +{fsname}_gf07 growfiles -W {fsname}_gf07 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -B 805306368 -C 1 -I p /tmp/ltp/growfiles/{fsname}/g_rand13 /tmp/ltp/growfiles/{fsname}/g_rand13.2
> +{fsname}_gf08 growfiles -W {fsname}_gf08 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -B 805306368 -C 1 /tmp/ltp/growfiles/{fsname}/g_rand11 /tmp/ltp/growfiles/{fsname}/g_rand11.2
> +{fsname}_gf09 growfiles -W {fsname}_gf09 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -B 805306368 -C 1 -I p /tmp/ltp/growfiles/{fsname}/g_rand12 /tmp/ltp/growfiles/{fsname}/g_rand12.2
> +{fsname}_gf10 growfiles -W {fsname}_gf10 -b -e 1 -u -r 1-5000 -i 0 -L 30 -B 805306368 -C 1 -I l /tmp/ltp/growfiles/{fsname}/g_lio14 /tmp/ltp/growfiles/{fsname}/g_lio14.2
> +{fsname}_gf11 growfiles -W {fsname}_gf11 -b -e 1 -u -r 1-5000 -i 0 -L 30 -B 805306368 -C 1 -I L /tmp/ltp/growfiles/{fsname}/g_lio15 /tmp/ltp/growfiles/{fsname}/g_lio15.2
> +{fsname}_gf14 growfiles -W {fsname}_gf14 -b -e 1 -u -i 0 -L 20 -B 805306368 -w -l -C 1 -T 10 /tmp/ltp/growfiles/{fsname}/glseek19 /tmp/ltp/growfiles/{fsname}/glseek19.2
> +{fsname}_gf15 growfiles -W {fsname}_gf15 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 -B 805306368 /tmp/ltp/growfiles/{fsname}/Lgfile1
> +{fsname}_gf20 growfiles -W {fsname}_gf20 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /tmp/ltp/growfiles/{fsname}/gfbigio-$$
> +{fsname}_gf21 growfiles -W {fsname}_gf21 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /tmp/ltp/growfiles/{fsname}/gf-bld-$$
> +{fsname}_gf22 growfiles -W {fsname}_gf22 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /tmp/ltp/growfiles/{fsname}/gf-bldf-$$
> +{fsname}_gf23 growfiles -W {fsname}_gf23 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /tmp/ltp/growfiles/{fsname}/gf-inf-$$
> +{fsname}_gf24 growfiles -W {fsname}_gf24 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /tmp/ltp/growfiles/{fsname}/gf-jbld-$$
> +{fsname}_gf25 growfiles -W {fsname}_gf25 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /tmp/ltp/growfiles/{fsname}/gf-large-gs-$$
> +{fsname}_gf26 growfiles -W {fsname}_gf26 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /tmp/ltp/growfiles/{fsname}/gfsmallio-$$
> +{fsname}_gf27 growfiles -W {fsname}_gf27 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /tmp/ltp/growfiles/{fsname}/gfsparse-1-$$
> +{fsname}_gf28 growfiles -W {fsname}_gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /tmp/ltp/growfiles/{fsname}/gfsparse-2-$$
> +{fsname}_gf29 growfiles -W {fsname}_gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -B 805306368 -C 1 -u /tmp/ltp/growfiles/{fsname}/gfsparse-3-$$
> +{fsname}_gf30 growfiles -W {fsname}_gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /tmp/ltp/growfiles/{fsname}/gf-sync-$$
> +{fsname}_rwtest01 rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/tmp/ltp/growfiles/{fsname}/rwtest01%f
> +{fsname}_rwtest02 rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/tmp/ltp/growfiles/{fsname}/rwtest02%f
> +{fsname}_rwtest03 rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/tmp/ltp/growfiles/{fsname}/rwtest03%f
> +{fsname}_rwtest04 rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/tmp/ltp/growfiles/{fsname}/rwtest04%f
> +{fsname}_rwtest05 rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/tmp/ltp/growfiles/{fsname}/rwtest05%f
> diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh

Hmm, where exactly is this called?

How is the template used?

> new file mode 100755
> index 000000000..b5e979e6b
> --- /dev/null
> +++ b/testcases/misc/lvm/generate_lvm_runfile.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
> +#
> +# Generate LTP runfile for LVM tests (runtest/lvm.local)
> +
> +TST_TESTFUNC=generate_runfile
> +TST_NEEDS_ROOT=1
> +TST_NEEDS_CMDS="sed"
> +. tst_test.sh
> +
> +generate_runfile()
> +{
> +	trap 'tst_brk TBROK "Cannot create LVM runfile"' ERR
> +	INFILE="$LTPROOT/testcases/data/lvm/runfile.tpl"
> +	OUTFILE="$LTPROOT/runtest/lvm.local"
> +	FS_LIST=`tst_supported_fs`
> +	echo -n "" >"$OUTFILE"
> +
> +	for fsname in $FS_LIST; do
> +		sed -e "s/{fsname}/$fsname/g" "$INFILE" >>"$OUTFILE"
> +	done
> +
> +	tst_res TPASS "Runfile $OUTFILE successfully created"
> +}
> +
> +tst_run
> diff --git a/testcases/misc/lvm/prepare_lvm.sh b/testcases/misc/lvm/prepare_lvm.sh
> new file mode 100755
> index 000000000..a9acd50e0
> --- /dev/null
> +++ b/testcases/misc/lvm/prepare_lvm.sh
> @@ -0,0 +1,83 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
> +#
> +# Create and mount LVM volume groups for lvm.local runfile
> +
> +TST_TESTFUNC=prepare_lvm
> +TST_NEEDS_ROOT=1
> +TST_NEEDS_CMDS="mount pvcreate vgcreate lvcreate"
> +. tst_test.sh
> +
> +LVM_TMPDIR="/tmp/ltp/growfiles"
> +LVM_IMGDIR="/tmp/ltp/imgfiles"

This should be based on $TMPDIR

> +error_check()
> +{
> +	if [ $? -ne 0 ]; then
> +		tst_brk TBROK "LVM setup failed"
> +	fi
> +}
> +
> +create_volume()
> +{
> +	fsname=$2
> +	ROD mkdir -p $fsname
> +
> +	# If the FS isn't supported, only create the mountpoint and exit
> +	if ! tst_supported_fs $fsname; then
> +		return
> +	fi
> +
> +	vgname=$1
> +	lvname="ltp_lv_$fsname"
> +	lvdev="/dev/$vgname/$lvname"
> +
> +	ROD lvcreate -L 1G $vgname -n "$lvname"
> +	tst_mkfs $fsname "$lvdev"
> +	ROD mount "$lvdev" $fsname
> +}
> +
> +prepare_mounts()
> +{
> +	FSNAME1=$1
> +	FSNAME2=$2
> +	shift 2
> +	LVM_DEV1=`tst_device acquire 1040 "$LVM_IMGDIR/lvm_pv1.img"`
> +	error_check
> +	LVM_DEV2=`ROD tst_device acquire 1040 "$LVM_IMGDIR/lvm_pv2.img"`
> +	error_check

This calls ROD but yet you do error_check, why?

Also ROD generates better error messages, why do we have to reinvent it
badly?

> +	# DEVSIZE=($# * 1GB / 2) + 16MB. The extra 16MB is for LVM physical
> +	# volume headers
> +	DEVSIZE=$(( $# * 512 + 16 ))
> +	LVM_DEV3=`tst_device acquire $DEVSIZE "$LVM_IMGDIR/lvm_pv3.img"`
> +	error_check
> +	LVM_DEV4=`tst_device acquire $DEVSIZE "$LVM_IMGDIR/lvm_pv4.img"`
> +	error_check
> +	ROD pvcreate $LVM_DEV1 $LVM_DEV2 $LVM_DEV3 $LVM_DEV4
> +	ROD vgcreate ltp_test_vg1 $LVM_DEV1 $LVM_DEV2
> +	ROD vgcreate ltp_test_vg2 $LVM_DEV3 $LVM_DEV4
> +
> +	for fsname in $FSNAME1 $FSNAME2; do
> +		create_volume ltp_test_vg1 $fsname
> +	done
> +
> +	for fsname in $@; do
> +		create_volume ltp_test_vg2 $fsname
> +	done
> +}
> +
> +prepare_lvm()
> +{
> +	FS_LIST=`tst_supported_fs | sort -u`
> +	ROD mkdir -p "$LVM_TMPDIR"
> +	ROD mkdir -p "$LVM_IMGDIR"
> +	chmod 777 "$LVM_TMPDIR"
> +	cd "$LVM_TMPDIR"
> +	error_check

Seriously here as well, just make use of ROD.

> +	prepare_mounts $FS_LIST
> +	tst_res TPASS "LVM mounts are ready"
> +}
> +
> +tst_run

Also I'm not sure that it's reasonable to write helper scripts as a
tests. These will fail horribly with -i parameters and so on. But I
guess that we don't have better solution now. We would need a stripped
down test library so that we can write these.

-- 
Cyril Hrubis
chrubis@suse.cz
