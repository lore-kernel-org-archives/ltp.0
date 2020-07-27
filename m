From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Jul 2020 11:31:56 +0200
Subject: [LTP] [blk] 6e6fcbc27e: ltp.fs_fill.fail
In-Reply-To: <20200726075511.GI1850@shao2-debian>
References: <20200726075511.GI1850@shao2-debian>
Message-ID: <20200727093156.GA29739@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> FYI, we noticed the following commit (built with gcc-9):

> commit: 6e6fcbc27e7788af54139c53537395d95560f2ef ("blk-mq: support batching dispatch in case of io")
> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-5.9/drivers


> in testcase: ltp
> with following parameters:

> 	disk: 1HDD
> 	fs: ext4
> 	test: fs-03

> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/


> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

...
> tst_test.c:1308: INFO: Testing on vfat
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> fs_fill.c:103: INFO: Running 10 writer threads
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
The only "error" I found is that fs_fill test timeouted on vfat. That might
indicate some problems. Note, for slow machines, there is LTP_TIMEOUT_MUL
https://github.com/linux-test-project/ltp/wiki/User-Guidelines#1-library-environment-variables

Some notes:
* The "diff" is about 445. It took me some time to realize that it's a
"diff" which reports some error, because LTP output is also after kernel config
log(output is still not clear).
* Log is huge: more than 7746 lines; ok, significant part 6275 lines is kernel config - if it's that huge,
it should be at the end.

> -------------- next part --------------
Maybe also have description (sometimes obvious sometimes not).


...
> # CONFIG_HYPERV_TESTING is not set
> # end of Kernel Testing and Coverage
> # end of Kernel hacking
> -------------- next part --------------
> #!/bin/sh

> export_top_env()
> {
> 	export suite='ltp'
> 	export testcase='ltp'
> 	export category='functional'
> 	export need_modules=true
> 	export need_memory='4G'
> 	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/vm-snb/ltp-1hdd-part2.yaml'
> 	export queue_cmdline_keys='branch
> commit
> queue_at_least_once'
> 	export queue='validate'
> 	export testbox='vm-snb-223'
> 	export tbox_group='vm-snb'
> 	export kconfig='x86_64-rhel-8.3'
> 	export nr_vm=64
> 	export submit_id='5f1b6220d3e994389b75f575'
> 	export job_file='/lkp/jobs/scheduled/vm-snb-223/ltp-1HDD-ext4-fs-03-debian-10.4-x86_64-20200603.cgz-6e6fcbc27e7788af54139c53537395d95560f2ef-20200725-14491-q8d1h6-26.yaml'
> 	export id='065bec73e2a4ca800d1cb6ad4c3c7827984bbf55'
> 	export queuer_version='/lkp-src'
> 	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
> 	export nr_cpu=8
> 	export memory='16G'
> 	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
> 	export swap_partitions='/dev/vdg'
> 	export need_kconfig='CONFIG_BLK_DEV_SD
It looks like this shell function should not be part of the mail.
Or at least not in the middle of kernel config (repeated several times).

> CONFIG_SCSI
> CONFIG_BLOCK=y
> CONFIG_SATA_AHCI

...
> extract_stats()
> {
> 	export stats_part_begin=
> 	export stats_part_end=

> 	$LKP_SRC/stats/wrapper ltp
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper meminfo

> 	$LKP_SRC/stats/wrapper time ltp.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }

> "$@"

That repeats till here.

Kind regards,
Petr
