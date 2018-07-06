From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri,  6 Jul 2018 16:49:28 +0800
Subject: [LTP] [PATCH ltp] runtest/{ltplite,
	stress.part1}: update commands for gf01-30/rwtest01-05
Message-ID: <20180706084928.6017-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

gf01-30/rwtest01-05 are orignal defined in runtest file 'fs', and they
are updated multiple times in file 'fs' but missed in 'ltplite'/'stress.part1'.
So this patch copy all updates to the tests in 'ltplite'/'stress.part1'.

Ref:
c9dd96e6b2f811dbad119c3558d90cb7dfc3919b
95e8b61433efcefb83699aaf859e92ad2b576373
606e544932248858f65c7ab3061f77c542c07cfe

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 runtest/ltplite      | 71 ++++++++++++++++++++++++++--------------------------
 runtest/stress.part1 | 70 +++++++++++++++++++++++++--------------------------
 2 files changed, 70 insertions(+), 71 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite
index 5a7819ca8..33cf04f46 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -1068,40 +1068,39 @@ ptem01 ptem01
 hangup01 hangup01
 
 #DESCRIPTION:Filesystem stress tests
-gf01 growfiles -W gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
-gf02 growfiles -W gf02 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf03 growfiles -W gf03 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-#gf04 growfiles -W gf04 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-#gf05 growfiles -W gf05 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf06 growfiles -W gf06 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand10 g_rand10.2
-gf07 growfiles -W gf07 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_rand13 g_rand13.2
-#gf08 growfiles -W gf08 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand11 g_rand11.2
-#gf09 growfiles -W gf09 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_rand12 g_rand12.2
-gf10 growfiles -W gf10 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2
-gf11 growfiles -W gf11 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2
-gf12 mkfifo gffifo17; growfiles -b -W gf12 -e 1 -u -i 0 -L 30 gffifo17
-gf13 mkfifo gffifo18; growfiles -b -W gf13 -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18
-gf14 growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
-gf15 growfiles -W gf15 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
-#gf16 growfiles -W gf16 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf17 growfiles -W gf17 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf18 growfiles -W gf18 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -l -S 2 -f Lgf04_
-gf19 growfiles -W gf19 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf20 growfiles -W gf20 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$
-#gf21 growfiles -W gf21 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$
-#gf22 growfiles -W gf22 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$
-gf23 growfiles -W gf23 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$
-gf24 growfiles -W gf24 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$
-gf25 growfiles -W gf25 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$
-gf26 growfiles -W gf26 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$
-gf27 growfiles -W gf27 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$
-#gf28 growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
-#gf29 growfiles -W gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$
-gf30 growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/tmp/rwtest01%f
-
+gf01 growfiles -W gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 -f glseek20 -S 2 -d $TMPDIR
+gf02 growfiles -W gf02 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_ -d $TMPDIR
+gf03 growfiles -W gf03 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_ -d $TMPDIR
+#gf04 growfiles -W gf04 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_ -d $TMPDIR
+#gf05 growfiles -W gf05 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_ -d $TMPDIR
+gf06 growfiles -W gf06 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -f g_rand10 -S 2 -d $TMPDIR
+gf07 growfiles -W gf07 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p -f g_rand13 -S 2 -d $TMPDIR
+#gf08 growfiles -W gf08 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -f g_rand11 -S 2 -d $TMPDIR
+#gf09 growfiles -W gf09 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p -f g_rand12 -S 2 -d $TMPDIR
+gf10 growfiles -W gf10 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l -f g_lio14 -S 2 -d $TMPDIR
+gf11 growfiles -W gf11 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L -f g_lio15 -S 2 -d $TMPDIR
+gf12 mkfifo $TMPDIR/gffifo17; growfiles -b -W gf12 -e 1 -u -i 0 -L 30 $TMPDIR/gffifo17
+gf13 mkfifo $TMPDIR/gffifo18; growfiles -b -W gf13 -e 1 -u -i 0 -L 30 -I r -r 1-4096 $TMPDIR/gffifo18
+gf14 growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 -f glseek19 -S 2 -d $TMPDIR
+gf15 growfiles -W gf15 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 -f Lgfile1 -d $TMPDIR
+#gf16 growfiles -W gf16 -b -e 1 -i 0 -L 120 -u -g 4090 -T 101 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_ -d $TMPDIR
+gf17 growfiles -W gf17 -b -e 1 -i 0 -L 120 -u -g 5000 -T 101 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_ -d $TMPDIR
+gf18 growfiles -W gf18 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -l -S 2 -f Lgf04_ -d $TMPDIR
+gf19 growfiles -W gf19 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_ -d $TMPDIR
+gf20 growfiles -W gf20 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 -f gfbigio-$$ -d $TMPDIR
+#gf21 growfiles -W gf21 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 -f gf-bld-$$ -d $TMPDIR
+#gf22 growfiles -W gf22 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 -f gf-bldf-$$ -d $TMPDIR
+gf23 growfiles -W gf23 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 -f gf-inf-$$ -d $TMPDIR
+gf24 growfiles -W gf24 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -f gf-jbld-$$ -d $TMPDIR
+gf25 growfiles -W gf25 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 -f gf-large-gs-$$ -d $TMPDIR
+gf26 growfiles -W gf26 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 -f gfsmallio-$$ -d $TMPDIR
+gf27 growfiles -W gf27 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u -f gfsparse-1-$$ -d $TMPDIR
+#gf28 growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u -f gfsparse-2-$$ -d $TMPDIR
+#gf29 growfiles -W gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u -f gfsparse-3-$$ -d $TMPDIR
+gf30 growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 -f gf-sync-$$ -d $TMPDIR
+rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:$TMPDIR/rw-sync-$$
+rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:$TMPDIR/rw-buffered-$$
+rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
+rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
+rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:$TMPDIR/rwtest01%f
 
diff --git a/runtest/stress.part1 b/runtest/stress.part1
index 423d25e38..45aba49d4 100644
--- a/runtest/stress.part1
+++ b/runtest/stress.part1
@@ -117,41 +117,41 @@ dio28 diotest6 -b 8192 -o 1024000 -i 1000 -v 200
 #dio46 diotest5 -b 65536 -i 1000 -o 104857600 -f $DEV1
 #dio47 diotest6 -b 65536 -i 1000 -o 104857600 -f $DEV1
 
-gf01 growfiles -W gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
-gf02 growfiles -W gf02 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf03 growfiles -W gf03 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-gf04 growfiles -W gf04 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-gf05 growfiles -W gf05 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf06 growfiles -W gf06 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand10 g_rand10.2
-gf07 growfiles -W gf07 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_rand13 g_rand13.2
-gf08 growfiles -W gf08 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand11 g_rand11.2
-gf09 growfiles -W gf09 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_rand12 g_rand12.2
-gf10 growfiles -W gf10 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2
-gf11 growfiles -W gf11 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2
-gf12 mkfifo gffifo17; growfiles -W gf12 -b -e 1 -u -i 0 -L 30 gffifo17
-gf13 mkfifo gffifo18; growfiles -W gf13 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18
-gf14 growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
-gf15 growfiles -W gf15 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
-gf16 growfiles -W gf16 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf17 growfiles -W gf17 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf18 growfiles -W gf18 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -l -S 2 -f Lgf04_
-gf19 growfiles -W gf19 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf20 growfiles -W gf20 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$
-gf21 growfiles -W gf21 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$
-gf22 growfiles -W gf22 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$
-gf23 growfiles -W gf23 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$
-gf24 growfiles -W gf24 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$
-gf25 growfiles -W gf25 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$
-gf26 growfiles -W gf26 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$
-gf27 growfiles -W gf27 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$
-gf28 growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
-gf29 growfiles -W gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$
-gf30 growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/tmp/rwtest01%f
+gf01 growfiles -W gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 -f glseek20 -S 2 -d $TMPDIR
+gf02 growfiles -W gf02 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_ -d $TMPDIR
+gf03 growfiles -W gf03 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_ -d $TMPDIR
+gf04 growfiles -W gf04 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_ -d $TMPDIR
+gf05 growfiles -W gf05 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_ -d $TMPDIR
+gf06 growfiles -W gf06 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -f g_rand10 -S 2 -d $TMPDIR
+gf07 growfiles -W gf07 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p -f g_rand13 -S 2 -d $TMPDIR
+gf08 growfiles -W gf08 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -f g_rand11 -S 2 -d $TMPDIR
+gf09 growfiles -W gf09 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p -f g_rand12 -S 2 -d $TMPDIR
+gf10 growfiles -W gf10 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l -f g_lio14 -S 2 -d $TMPDIR
+gf11 growfiles -W gf11 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L -f g_lio15 -S 2 -d $TMPDIR
+gf12 mkfifo $TMPDIR/gffifo17; growfiles -b -W gf12 -e 1 -u -i 0 -L 30 $TMPDIR/gffifo17
+gf13 mkfifo $TMPDIR/gffifo18; growfiles -b -W gf13 -e 1 -u -i 0 -L 30 -I r -r 1-4096 $TMPDIR/gffifo18
+gf14 growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 -f glseek19 -S 2 -d $TMPDIR
+gf15 growfiles -W gf15 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 -f Lgfile1 -d $TMPDIR
+gf16 growfiles -W gf16 -b -e 1 -i 0 -L 120 -u -g 4090 -T 101 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_ -d $TMPDIR
+gf17 growfiles -W gf17 -b -e 1 -i 0 -L 120 -u -g 5000 -T 101 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_ -d $TMPDIR
+gf18 growfiles -W gf18 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -l -S 2 -f Lgf04_ -d $TMPDIR
+gf19 growfiles -W gf19 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_ -d $TMPDIR
+gf20 growfiles -W gf20 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 -f gfbigio-$$ -d $TMPDIR
+gf21 growfiles -W gf21 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 -f gf-bld-$$ -d $TMPDIR
+gf22 growfiles -W gf22 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 -f gf-bldf-$$ -d $TMPDIR
+gf23 growfiles -W gf23 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 -f gf-inf-$$ -d $TMPDIR
+gf24 growfiles -W gf24 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -f gf-jbld-$$ -d $TMPDIR
+gf25 growfiles -W gf25 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 -f gf-large-gs-$$ -d $TMPDIR
+gf26 growfiles -W gf26 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 -f gfsmallio-$$ -d $TMPDIR
+gf27 growfiles -W gf27 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u -f gfsparse-1-$$ -d $TMPDIR
+gf28 growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u -f gfsparse-2-$$ -d $TMPDIR
+gf29 growfiles -W gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u -f gfsparse-3-$$ -d $TMPDIR
+gf30 growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 -f gf-sync-$$ -d $TMPDIR
+rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:$TMPDIR/rw-sync-$$
+rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:$TMPDIR/rw-buffered-$$
+rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
+rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
+rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:$TMPDIR/rwtest01%f
 
 #must be run as root
 #iogen01 iogen -i 120s -s read,write 500b:doio.f1.$$ 1000b:doio.f2.$$ | doio -akv -n 2
-- 
2.14.1

