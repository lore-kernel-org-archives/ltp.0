From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 20 Feb 2020 14:42:55 -0500 (EST)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E21-2d636a1=2Ecki_=28stable=29?=
In-Reply-To: <cki.C7F44073DC.K13BODGQAA@redhat.com>
References: <cki.C7F44073DC.K13BODGQAA@redhat.com>
Message-ID: <1011809226.8353012.1582227775821.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> Hello,
> 
> We ran automated tests on a recent commit from this kernel tree:
> 
>        Kernel repo:
>        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>             Commit: 2d636a1263be - Linux 5.4.21
> 
> The results of these automated tests are provided below.
> 
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>              Tests: FAILED
> 
> All kernel binaries, config files, and logs are available for download here:
> 
>   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/02/19/446693
> 
> One or more kernel tests failed:
> 
>     ppc64le:
>      ? LTP

This is warning from preadv203, because it failed to clear loop device.
Kernel reports an I/O error:

[ 2338.786854] blk_update_request: I/O error, dev loop0, sector 512 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0

tst_test.c:1278: INFO: Testing on ext3
tst_mkfs.c:89: INFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
mke2fs 1.45.5 (07-Jan-2020)
tst_test.c:1215: INFO: Timeout per run is 0h 05m 00s
preadv203.c:143: INFO: Number of full_reads 425, short reads 10, zero len reads 0, EAGAIN(s) 100
preadv203.c:180: INFO: Number of writes 300
preadv203.c:194: INFO: Cache dropped 1 times
preadv203.c:223: PASS: Got some EAGAIN
tst_test.c:1278: INFO: Testing on ext4
tst_device.c:348: WARN: Failed to clear 512k block on /dev/loop0
tst_mkfs.c:87: BROK: tst_clear_device() failed

Summary:
passed   2
failed   0
skipped  0
warnings 1

but I haven't been able to reliably reproduce it so far.

