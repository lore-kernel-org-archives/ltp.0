From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 30 Jan 2020 16:30:32 +0100
Subject: [LTP] [PATCH v3 3/3] Add LVM support scripts
In-Reply-To: <20200130144146.20846-1-mdoucha@suse.cz>
References: <20200130123641.15286-1-mdoucha@suse.cz>
 <20200130144146.20846-1-mdoucha@suse.cz>
Message-ID: <20200130153032.GA11344@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

thanks for fixing these scripts, they were waiting long for it :).

> Changes since v2:
> - fix filename in misc/lvm/Makefile
You can just use *.sh next time.

> +++ b/testcases/misc/lvm/cleanup_lvm.sh
Maybe we can move them to testcases/lvm, but that's tiny detail.

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
Can we use TST_NEEDS_TMPDIR=1 and relative paths?

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
...
> --- /dev/null
> +++ b/testcases/misc/lvm/datafiles/runfile.tpl
> @@ -0,0 +1,36 @@
> +# Check the {fsname} filesystem
> +{fsname}_gf02 growfiles -W {fsname}_gf02 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
> +{fsname}_gf03 growfiles -W {fsname}_gf03 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
> +{fsname}_gf04 growfiles -W {fsname}_gf04 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
> +{fsname}_gf05 growfiles -W {fsname}_gf05 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
> +{fsname}_gf16 growfiles -W {fsname}_gf16 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
> +{fsname}_gf17 growfiles -W {fsname}_gf17 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
> +{fsname}_gf18 growfiles -W {fsname}_gf18 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
> +{fsname}_gf19 growfiles -W {fsname}_gf19 -d /tmp/ltp/growfiles/{fsname} -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
> +{fsname}_gf12 mkfifo /tmp/ltp/growfiles/{fsname}/gffifo17; growfiles -W {fsname}_gf12 -b -e 1 -u -i 0 -L 30 /tmp/ltp/growfiles/{fsname}/gffifo17
> +{fsname}_gf13 mkfifo /tmp/ltp/growfiles/{fsname}/gffifo18; growfiles -W {fsname}_gf13 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /tmp/ltp/growfiles/{fsname}/gffifo18
> +{fsname}_gf01 growfiles -W {fsname}_gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /tmp/ltp/growfiles/{fsname}/glseek20 /tmp/ltp/growfiles/{fsname}/glseek20.2
> +{fsname}_gf06 growfiles -W {fsname}_gf06 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /tmp/ltp/growfiles/{fsname}/g_rand10 /tmp/ltp/growfiles/{fsname}/g_rand10.2
> +{fsname}_gf07 growfiles -W {fsname}_gf07 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /tmp/ltp/growfiles/{fsname}/g_rand13 /tmp/ltp/growfiles/{fsname}/g_rand13.2
> +{fsname}_gf08 growfiles -W {fsname}_gf08 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /tmp/ltp/growfiles/{fsname}/g_rand11 /tmp/ltp/growfiles/{fsname}/g_rand11.2
> +{fsname}_gf09 growfiles -W {fsname}_gf09 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /tmp/ltp/growfiles/{fsname}/g_rand12 /tmp/ltp/growfiles/{fsname}/g_rand12.2
> +{fsname}_gf10 growfiles -W {fsname}_gf10 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /tmp/ltp/growfiles/{fsname}/g_lio14 /tmp/ltp/growfiles/{fsname}/g_lio14.2
> +{fsname}_gf11 growfiles -W {fsname}_gf11 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /tmp/ltp/growfiles/{fsname}/g_lio15 /tmp/ltp/growfiles/{fsname}/g_lio15.2
> +{fsname}_gf14 growfiles -W {fsname}_gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /tmp/ltp/growfiles/{fsname}/glseek19 /tmp/ltp/growfiles/{fsname}/glseek19.2
> +{fsname}_gf15 growfiles -W {fsname}_gf15 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /tmp/ltp/growfiles/{fsname}/Lgfile1
> +{fsname}_gf20 growfiles -W {fsname}_gf20 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /tmp/ltp/growfiles/{fsname}/gfbigio-$$
> +{fsname}_gf21 growfiles -W {fsname}_gf21 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /tmp/ltp/growfiles/{fsname}/gf-bld-$$
> +{fsname}_gf22 growfiles -W {fsname}_gf22 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /tmp/ltp/growfiles/{fsname}/gf-bldf-$$
> +{fsname}_gf23 growfiles -W {fsname}_gf23 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /tmp/ltp/growfiles/{fsname}/gf-inf-$$
> +{fsname}_gf24 growfiles -W {fsname}_gf24 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /tmp/ltp/growfiles/{fsname}/gf-jbld-$$
> +{fsname}_gf25 growfiles -W {fsname}_gf25 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /tmp/ltp/growfiles/{fsname}/gf-large-gs-$$
> +{fsname}_gf26 growfiles -W {fsname}_gf26 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /tmp/ltp/growfiles/{fsname}/gfsmallio-$$
> +{fsname}_gf27 growfiles -W {fsname}_gf27 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /tmp/ltp/growfiles/{fsname}/gfsparse-1-$$
> +{fsname}_gf28 growfiles -W {fsname}_gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /tmp/ltp/growfiles/{fsname}/gfsparse-2-$$
> +{fsname}_gf29 growfiles -W {fsname}_gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /tmp/ltp/growfiles/{fsname}/gfsparse-3-$$
> +{fsname}_gf30 growfiles -W {fsname}_gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /tmp/ltp/growfiles/{fsname}/gf-sync-$$
> +{fsname}_rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/tmp/ltp/growfiles/{fsname}/rwtest01%f
> +{fsname}_rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/tmp/ltp/growfiles/{fsname}/rwtest02%f
> +{fsname}_rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/tmp/ltp/growfiles/{fsname}/rwtest03%f
> +{fsname}_rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/tmp/ltp/growfiles/{fsname}/rwtest04%f
> +{fsname}_rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/tmp/ltp/growfiles/{fsname}/rwtest05%f
BTW part of the cleanup it'd be nice to get rid of 'export LTPROOT;'

BTW I wonder whether we still need testscripts/ltpfslvm.sh testscripts/ltpfsnolvm.sh,
which use runtest/lvm.part1 and runtest/lvm.part1?


Kind regards,
Petr
