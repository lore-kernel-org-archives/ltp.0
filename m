From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri,  9 Aug 2019 14:19:57 +0800
Subject: [LTP] [PATCH ltp 2/5] runtest: rename gf*** and rwtest{1..5} in
 lvm.part{1, 2} and scsi_debug.part1
In-Reply-To: <20190809062000.8671-1-yixin.zhang@intel.com>
References: <20190809062000.8671-1-yixin.zhang@intel.com>
Message-ID: <20190809062000.8671-2-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are lots tests with duplicated name gf*** and rwtest0{1..5} in the
3 runtest file but they are testing different fs. Rename them to
distingulish.

1. Change gf*** to gf***_lvm/gf***_scsi
2. Chagne rwtest** to rwtest{1..8}**_lvm/rwtest{1..8}**_scsi, which the
   code 1..8 is the code for the target filesystem

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 runtest/lvm.part1        | 420 +++++++++++++++++++--------------------
 runtest/lvm.part2        | 140 ++++++-------
 runtest/scsi_debug.part1 | 280 +++++++++++++-------------
 3 files changed, 420 insertions(+), 420 deletions(-)

diff --git a/runtest/lvm.part1 b/runtest/lvm.part1
index b2e9c0551..78230ed82 100644
--- a/runtest/lvm.part1
+++ b/runtest/lvm.part1
@@ -1,217 +1,217 @@
 #DESCRIPTION:lvm filesystem tests
 # Check the MSDOS filesystem
-gf102 growfiles -W gf102 -d /test/growfiles/msdos -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf103 growfiles -W gf103 -d /test/growfiles/msdos -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-gf104 growfiles -W gf104 -d /test/growfiles/msdos -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-gf105 growfiles -W gf105 -d /test/growfiles/msdos -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf116 growfiles -W gf116 -d /test/growfiles/msdos -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf117 growfiles -W gf117 -d /test/growfiles/msdos -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf118 growfiles -W gf118 -d /test/growfiles/msdos -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
-gf119 growfiles -W gf119 -d /test/growfiles/msdos -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf112 mkfifo /test/growfiles/msdos/gffifo17; growfiles -W gf112 -b -e 1 -u -i 0 -L 30 /test/growfiles/msdos/gffifo17
-gf113 mkfifo /test/growfiles/msdos/gffifo18; growfiles -W gf113 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/msdos/gffifo18
-gf101 growfiles -W gf101 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/msdos/glseek20 /test/growfiles/msdos/glseek20.2
-gf106 growfiles -W gf106 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/msdos/g_rand10 /test/growfiles/msdos/g_rand10.2
-gf107 growfiles -W gf107 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/msdos/g_rand13 /test/growfiles/msdos/g_rand13.2
-gf108 growfiles -W gf108 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/msdos/g_rand11 /test/growfiles/msdos/g_rand11.2
-gf109 growfiles -W gf109 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/msdos/g_rand12 /test/growfiles/msdos/g_rand12.2
-gf110 growfiles -W gf110 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/msdos/g_lio14 /test/growfiles/msdos/g_lio14.2
-gf111 growfiles -W gf111 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/msdos/g_lio15 /test/growfiles/msdos/g_lio15.2
-gf114 growfiles -W gf114 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/msdos/glseek19 /test/growfiles/msdos/glseek19.2
-gf115 growfiles -W gf115 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/msdos/Lgfile1
-gf120 growfiles -W gf120 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/msdos/gfbigio-$$
-gf121 growfiles -W gf121 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/msdos/gf-bld-$$
-gf122 growfiles -W gf122 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/msdos/gf-bldf-$$
-gf123 growfiles -W gf123 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/msdos/gf-inf-$$
-gf124 growfiles -W gf124 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/msdos/gf-jbld-$$
-gf125 growfiles -W gf125 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/msdos/gf-large-gs-$$
-gf126 growfiles -W gf126 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/msdos/gfsmallio-$$
-gf127 growfiles -W gf127 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/msdos/gfsparse-1-$$
-gf128 growfiles -W gf128 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/msdos/gfsparse-2-$$
-gf129 growfiles -W gf129 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/msdos/gfsparse-3-$$
-gf130 growfiles -W gf130 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/msdos/gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/msdos/rwtest01%f
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/msdos/rwtest02%f
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/msdos/rwtest03%f
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/msdos/rwtest04%f
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/msdos/rwtest05%f
+gf102_lvm growfiles -W gf102 -d /test/growfiles/msdos -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
+gf103_lvm growfiles -W gf103 -d /test/growfiles/msdos -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
+gf104_lvm growfiles -W gf104 -d /test/growfiles/msdos -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
+gf105_lvm growfiles -W gf105 -d /test/growfiles/msdos -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
+gf116_lvm growfiles -W gf116 -d /test/growfiles/msdos -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
+gf117_lvm growfiles -W gf117 -d /test/growfiles/msdos -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
+gf118_lvm growfiles -W gf118 -d /test/growfiles/msdos -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
+gf119_lvm growfiles -W gf119 -d /test/growfiles/msdos -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
+gf112_lvm mkfifo /test/growfiles/msdos/gffifo17; growfiles -W gf112 -b -e 1 -u -i 0 -L 30 /test/growfiles/msdos/gffifo17
+gf113_lvm mkfifo /test/growfiles/msdos/gffifo18; growfiles -W gf113 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/msdos/gffifo18
+gf101_lvm growfiles -W gf101 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/msdos/glseek20 /test/growfiles/msdos/glseek20.2
+gf106_lvm growfiles -W gf106 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/msdos/g_rand10 /test/growfiles/msdos/g_rand10.2
+gf107_lvm growfiles -W gf107 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/msdos/g_rand13 /test/growfiles/msdos/g_rand13.2
+gf108_lvm growfiles -W gf108 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/msdos/g_rand11 /test/growfiles/msdos/g_rand11.2
+gf109_lvm growfiles -W gf109 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/msdos/g_rand12 /test/growfiles/msdos/g_rand12.2
+gf110_lvm growfiles -W gf110 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/msdos/g_lio14 /test/growfiles/msdos/g_lio14.2
+gf111_lvm growfiles -W gf111 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/msdos/g_lio15 /test/growfiles/msdos/g_lio15.2
+gf114_lvm growfiles -W gf114 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/msdos/glseek19 /test/growfiles/msdos/glseek19.2
+gf115_lvm growfiles -W gf115 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/msdos/Lgfile1
+gf120_lvm growfiles -W gf120 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/msdos/gfbigio-$$
+gf121_lvm growfiles -W gf121 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/msdos/gf-bld-$$
+gf122_lvm growfiles -W gf122 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/msdos/gf-bldf-$$
+gf123_lvm growfiles -W gf123 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/msdos/gf-inf-$$
+gf124_lvm growfiles -W gf124 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/msdos/gf-jbld-$$
+gf125_lvm growfiles -W gf125 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/msdos/gf-large-gs-$$
+gf126_lvm growfiles -W gf126 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/msdos/gfsmallio-$$
+gf127_lvm growfiles -W gf127 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/msdos/gfsparse-1-$$
+gf128_lvm growfiles -W gf128 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/msdos/gfsparse-2-$$
+gf129_lvm growfiles -W gf129 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/msdos/gfsparse-3-$$
+gf130_lvm growfiles -W gf130 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/msdos/gf-sync-$$
+rwtest101_lvm export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/msdos/rwtest01%f
+rwtest102_lvm export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/msdos/rwtest02%f
+rwtest103_lvm export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/msdos/rwtest03%f
+rwtest104_lvm export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/msdos/rwtest04%f
+rwtest105_lvm export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/msdos/rwtest05%f
 # Check the Reiserfs filesystem
-gf202 growfiles -W gf202 -d /test/growfiles/reiser -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf203 growfiles -W gf203 -d /test/growfiles/reiser -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-gf204 growfiles -W gf204 -d /test/growfiles/reiser -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-gf205 growfiles -W gf205 -d /test/growfiles/reiser -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf216 growfiles -W gf216 -d /test/growfiles/reiser -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf217 growfiles -W gf217 -d /test/growfiles/reiser -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf218 growfiles -W gf218 -d /test/growfiles/reiser -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
-gf219 growfiles -W gf219 -d /test/growfiles/reiser -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf212 mkfifo /test/growfiles/reiser/gffifo17; growfiles -W gf212 -b -e 1 -u -i 0 -L 30 /test/growfiles/reiser/gffifo17
-gf213 mkfifo /test/growfiles/reiser/gffifo18; growfiles -W gf213 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/reiser/gffifo18
-gf201 growfiles -W gf201 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/reiser/glseek20 /test/growfiles/reiser/glseek20.2
-gf206 growfiles -W gf206 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/reiser/g_rand10 /test/growfiles/reiser/g_rand10.2
-gf207 growfiles -W gf207 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/reiser/g_rand13 /test/growfiles/reiser/g_rand13.2
-gf208 growfiles -W gf208 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/reiser/g_rand11 /test/growfiles/reiser/g_rand11.2
-gf209 growfiles -W gf209 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/reiser/g_rand12 /test/growfiles/reiser/g_rand12.2
-gf210 growfiles -W gf210 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/reiser/g_lio14 /test/growfiles/reiser/g_lio14.2
-gf211 growfiles -W gf211 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/reiser/g_lio15 /test/growfiles/reiser/g_lio15.2
-gf214 growfiles -W gf214 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/reiser/glseek19 /test/growfiles/reiser/glseek19.2
-gf215 growfiles -W gf215 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/reiser/Lgfile1
-gf220 growfiles -W gf220 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/reiser/gfbigio-$$
-gf221 growfiles -W gf221 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/reiser/gf-bld-$$
-gf222 growfiles -W gf222 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/reiser/gf-bldf-$$
-gf223 growfiles -W gf223 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/reiser/gf-inf-$$
-gf224 growfiles -W gf224 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/reiser/gf-jbld-$$
-gf225 growfiles -W gf225 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/reiser/gf-large-gs-$$
-gf226 growfiles -W gf226 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/reiser/gfsmallio-$$
-gf227 growfiles -W gf227 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/reiser/gfsparse-1-$$
-gf228 growfiles -W gf228 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/reiser/gfsparse-2-$$
-gf229 growfiles -W gf229 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/reiser/gfsparse-3-$$
-gf230 growfiles -W gf230 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/reiser/gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/reiser/rwtest06%f
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/reiser/rwtest07%f
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/reiser/rwtest08%f
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/reiser/rwtest09%f
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/reiser/rwtest10%f
+gf202_lvm growfiles -W gf202 -d /test/growfiles/reiser -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
+gf203_lvm growfiles -W gf203 -d /test/growfiles/reiser -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
+gf204_lvm growfiles -W gf204 -d /test/growfiles/reiser -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
+gf205_lvm growfiles -W gf205 -d /test/growfiles/reiser -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
+gf216_lvm growfiles -W gf216 -d /test/growfiles/reiser -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
+gf217_lvm growfiles -W gf217 -d /test/growfiles/reiser -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
+gf218_lvm growfiles -W gf218 -d /test/growfiles/reiser -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
+gf219_lvm growfiles -W gf219 -d /test/growfiles/reiser -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
+gf212_lvm mkfifo /test/growfiles/reiser/gffifo17; growfiles -W gf212 -b -e 1 -u -i 0 -L 30 /test/growfiles/reiser/gffifo17
+gf213_lvm mkfifo /test/growfiles/reiser/gffifo18; growfiles -W gf213 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/reiser/gffifo18
+gf201_lvm growfiles -W gf201 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/reiser/glseek20 /test/growfiles/reiser/glseek20.2
+gf206_lvm growfiles -W gf206 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/reiser/g_rand10 /test/growfiles/reiser/g_rand10.2
+gf207_lvm growfiles -W gf207 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/reiser/g_rand13 /test/growfiles/reiser/g_rand13.2
+gf208_lvm growfiles -W gf208 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/reiser/g_rand11 /test/growfiles/reiser/g_rand11.2
+gf209_lvm growfiles -W gf209 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/reiser/g_rand12 /test/growfiles/reiser/g_rand12.2
+gf210_lvm growfiles -W gf210 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/reiser/g_lio14 /test/growfiles/reiser/g_lio14.2
+gf211_lvm growfiles -W gf211 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/reiser/g_lio15 /test/growfiles/reiser/g_lio15.2
+gf214_lvm growfiles -W gf214 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/reiser/glseek19 /test/growfiles/reiser/glseek19.2
+gf215_lvm growfiles -W gf215 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/reiser/Lgfile1
+gf220_lvm growfiles -W gf220 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/reiser/gfbigio-$$
+gf221_lvm growfiles -W gf221 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/reiser/gf-bld-$$
+gf222_lvm growfiles -W gf222 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/reiser/gf-bldf-$$
+gf223_lvm growfiles -W gf223 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/reiser/gf-inf-$$
+gf224_lvm growfiles -W gf224 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/reiser/gf-jbld-$$
+gf225_lvm growfiles -W gf225 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/reiser/gf-large-gs-$$
+gf226_lvm growfiles -W gf226 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/reiser/gfsmallio-$$
+gf227_lvm growfiles -W gf227 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/reiser/gfsparse-1-$$
+gf228_lvm growfiles -W gf228 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/reiser/gfsparse-2-$$
+gf229_lvm growfiles -W gf229 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/reiser/gfsparse-3-$$
+gf230_lvm growfiles -W gf230 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/reiser/gf-sync-$$
+rwtest201_lvm export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/reiser/rwtest06%f
+rwtest202_lvm export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/reiser/rwtest07%f
+rwtest203_lvm export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/reiser/rwtest08%f
+rwtest204_lvm export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/reiser/rwtest09%f
+rwtest205_lvm export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/reiser/rwtest10%f
 # Check the EXT2 filesystem
-gf302 growfiles -W gf302 -d /test/growfiles/ext2 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf303 growfiles -W gf303 -d /test/growfiles/ext2 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-gf304 growfiles -W gf304 -d /test/growfiles/ext2 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-gf305 growfiles -W gf305 -d /test/growfiles/ext2 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf316 growfiles -W gf316 -d /test/growfiles/ext2 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf317 growfiles -W gf317 -d /test/growfiles/ext2 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf318 growfiles -W gf318 -d /test/growfiles/ext2 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
-gf319 growfiles -W gf319 -d /test/growfiles/ext2 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf312 mkfifo /test/growfiles/ext2/gffifo17; growfiles -W gf312 -d /test/growfiles/ext2 -b -e 1 -u -i 0 -L 30 /test/growfiles/ext2/gffifo17
-gf313 mkfifo /test/growfiles/ext2/gffifo18; growfiles -W gf313 -d /test/growfiles/ext2 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/ext2/gffifo18
-gf301 growfiles -W gf301 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/ext2/glseek20 /test/growfiles/ext2/glseek20.2
-gf306 growfiles -W gf306 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/ext2/g_rand10 /test/growfiles/ext2/g_rand10.2
-gf307 growfiles -W gf307 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/ext2/g_rand13 /test/growfiles/ext2/g_rand13.2
-gf308 growfiles -W gf308 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/ext2/g_rand11 /test/growfiles/ext2/g_rand11.2
-gf309 growfiles -W gf309 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/ext2/g_rand12 /test/growfiles/ext2/g_rand12.2
-gf310 growfiles -W gf310 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/ext2/g_lio14 /test/growfiles/ext2/g_lio14.2
-gf311 growfiles -W gf311 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/ext2/g_lio15 /test/growfiles/ext2/g_lio15.2
-gf314 growfiles -W gf314 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/ext2/glseek19 /test/growfiles/ext2/glseek19.2
-gf315 growfiles -W gf315 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/ext2/Lgfile1
-gf320 growfiles -W gf320 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/ext2/gfbigio-$$
-gf321 growfiles -W gf321 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/ext2/gf-bld-$$
-gf322 growfiles -W gf322 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/ext2/gf-bldf-$$
-gf323 growfiles -W gf323 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/ext2/gf-inf-$$
-gf324 growfiles -W gf324 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/ext2/gf-jbld-$$
-gf325 growfiles -W gf325 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/ext2/gf-large-gs-$$
-gf326 growfiles -W gf326 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/ext2/gfsmallio-$$
-gf327 growfiles -W gf327 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/ext2/gfsparse-1-$$
-gf328 growfiles -W gf328 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/ext2/gfsparse-2-$$
-gf329 growfiles -W gf329 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/ext2/gfsparse-3-$$
-gf330 growfiles -W gf330 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/ext2/gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/ext2/rwtest11%f
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/ext2/rwtest12%f
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/ext2/rwtest13%f
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/ext2/rwtest14%f
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/ext2/rwtest15%f
+gf302_lvm growfiles -W gf302 -d /test/growfiles/ext2 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
+gf303_lvm growfiles -W gf303 -d /test/growfiles/ext2 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
+gf304_lvm growfiles -W gf304 -d /test/growfiles/ext2 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
+gf305_lvm growfiles -W gf305 -d /test/growfiles/ext2 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
+gf316_lvm growfiles -W gf316 -d /test/growfiles/ext2 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
+gf317_lvm growfiles -W gf317 -d /test/growfiles/ext2 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
+gf318_lvm growfiles -W gf318 -d /test/growfiles/ext2 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
+gf319_lvm growfiles -W gf319 -d /test/growfiles/ext2 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
+gf312_lvm mkfifo /test/growfiles/ext2/gffifo17; growfiles -W gf312 -d /test/growfiles/ext2 -b -e 1 -u -i 0 -L 30 /test/growfiles/ext2/gffifo17
+gf313_lvm mkfifo /test/growfiles/ext2/gffifo18; growfiles -W gf313 -d /test/growfiles/ext2 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/ext2/gffifo18
+gf301_lvm growfiles -W gf301 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/ext2/glseek20 /test/growfiles/ext2/glseek20.2
+gf306_lvm growfiles -W gf306 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/ext2/g_rand10 /test/growfiles/ext2/g_rand10.2
+gf307_lvm growfiles -W gf307 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/ext2/g_rand13 /test/growfiles/ext2/g_rand13.2
+gf308_lvm growfiles -W gf308 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/ext2/g_rand11 /test/growfiles/ext2/g_rand11.2
+gf309_lvm growfiles -W gf309 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/ext2/g_rand12 /test/growfiles/ext2/g_rand12.2
+gf310_lvm growfiles -W gf310 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/ext2/g_lio14 /test/growfiles/ext2/g_lio14.2
+gf311_lvm growfiles -W gf311 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/ext2/g_lio15 /test/growfiles/ext2/g_lio15.2
+gf314_lvm growfiles -W gf314 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/ext2/glseek19 /test/growfiles/ext2/glseek19.2
+gf315_lvm growfiles -W gf315 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/ext2/Lgfile1
+gf320_lvm growfiles -W gf320 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/ext2/gfbigio-$$
+gf321_lvm growfiles -W gf321 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/ext2/gf-bld-$$
+gf322_lvm growfiles -W gf322 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/ext2/gf-bldf-$$
+gf323_lvm growfiles -W gf323 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/ext2/gf-inf-$$
+gf324_lvm growfiles -W gf324 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/ext2/gf-jbld-$$
+gf325_lvm growfiles -W gf325 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/ext2/gf-large-gs-$$
+gf326_lvm growfiles -W gf326 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/ext2/gfsmallio-$$
+gf327_lvm growfiles -W gf327 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/ext2/gfsparse-1-$$
+gf328_lvm growfiles -W gf328 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/ext2/gfsparse-2-$$
+gf329_lvm growfiles -W gf329 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/ext2/gfsparse-3-$$
+gf330_lvm growfiles -W gf330 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/ext2/gf-sync-$$
+rwtest301_lvm export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/ext2/rwtest11%f
+rwtest302_lvm export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/ext2/rwtest12%f
+rwtest303_lvm export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/ext2/rwtest13%f
+rwtest304_lvm export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/ext2/rwtest14%f
+rwtest305_lvm export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/ext2/rwtest15%f
 # Check an NFS filesystem
-gf402 growfiles -W gf402 -d /test/growfiles/nfs -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf403 growfiles -W gf403 -d /test/growfiles/nfs -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-gf404 growfiles -W gf404 -d /test/growfiles/nfs -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-gf405 growfiles -W gf405 -d /test/growfiles/nfs -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf416 growfiles -W gf416 -d /test/growfiles/nfs -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf417 growfiles -W gf417 -d /test/growfiles/nfs -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf418 growfiles -W gf418 -d /test/growfiles/nfs -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
-gf419 growfiles -W gf419 -d /test/growfiles/nfs -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf412 mkfifo /test/growfiles/nfs/gffifo17; growfiles -W gf412 -b -e 1 -u -i 0 -L 30 /test/growfiles/nfs/gffifo17
-gf413 mkfifo /test/growfiles/nfs/gffifo18; growfiles -W gf413 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/nfs/gffifo18
-gf401 growfiles -W gf401 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/nfs/glseek20 /test/growfiles/nfs/glseek20.2
-gf406 growfiles -W gf406 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/nfs/g_rand10 /test/growfiles/nfs/g_rand10.2
-gf407 growfiles -W gf407 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/nfs/g_rand13 /test/growfiles/nfs/g_rand13.2
-gf408 growfiles -W gf408 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/nfs/g_rand11 /test/growfiles/nfs/g_rand11.2
-gf409 growfiles -W gf409 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/nfs/g_rand12 /test/growfiles/nfs/g_rand12.2
-gf410 growfiles -W gf410 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/nfs/g_lio14 /test/growfiles/nfs/g_lio14.2
-gf411 growfiles -W gf411 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/nfs/g_lio15 /test/growfiles/nfs/g_lio15.2
-gf414 growfiles -W gf414 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/nfs/glseek19 /test/growfiles/nfs/glseek19.2
-gf415 growfiles -W gf415 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/nfs/Lgfile1
-gf420 growfiles -W gf420 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/nfs/gfbigio-$$
-gf421 growfiles -W gf421 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/nfs/gf-bld-$$
-gf422 growfiles -W gf422 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/nfs/gf-bldf-$$
-gf423 growfiles -W gf423 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/nfs/gf-inf-$$
-gf424 growfiles -W gf424 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/nfs/gf-jbld-$$
-gf425 growfiles -W gf425 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/nfs/gf-large-gs-$$
-gf426 growfiles -W gf426 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/nfs/gfsmallio-$$
-gf427 growfiles -W gf427 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/nfs/gfsparse-1-$$
-gf428 growfiles -W gf428 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/nfs/gfsparse-2-$$
-gf429 growfiles -W gf429 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/nfs/gfsparse-3-$$
-gf430 growfiles -W gf430 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/nfs/gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/nfs/rwtest16%f
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/nfs/rwtest17%f
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/nfs/rwtest18%f
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/nfs/rwtest19%f
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/nfs/rwtest20%f
+gf402_lvm growfiles -W gf402 -d /test/growfiles/nfs -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
+gf403_lvm growfiles -W gf403 -d /test/growfiles/nfs -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
+gf404_lvm growfiles -W gf404 -d /test/growfiles/nfs -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
+gf405_lvm growfiles -W gf405 -d /test/growfiles/nfs -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
+gf416_lvm growfiles -W gf416 -d /test/growfiles/nfs -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
+gf417_lvm growfiles -W gf417 -d /test/growfiles/nfs -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
+gf418_lvm growfiles -W gf418 -d /test/growfiles/nfs -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
+gf419_lvm growfiles -W gf419 -d /test/growfiles/nfs -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
+gf412_lvm mkfifo /test/growfiles/nfs/gffifo17; growfiles -W gf412 -b -e 1 -u -i 0 -L 30 /test/growfiles/nfs/gffifo17
+gf413_lvm mkfifo /test/growfiles/nfs/gffifo18; growfiles -W gf413 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/nfs/gffifo18
+gf401_lvm growfiles -W gf401 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/nfs/glseek20 /test/growfiles/nfs/glseek20.2
+gf406_lvm growfiles -W gf406 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/nfs/g_rand10 /test/growfiles/nfs/g_rand10.2
+gf407_lvm growfiles -W gf407 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/nfs/g_rand13 /test/growfiles/nfs/g_rand13.2
+gf408_lvm growfiles -W gf408 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/nfs/g_rand11 /test/growfiles/nfs/g_rand11.2
+gf409_lvm growfiles -W gf409 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/nfs/g_rand12 /test/growfiles/nfs/g_rand12.2
+gf410_lvm growfiles -W gf410 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/nfs/g_lio14 /test/growfiles/nfs/g_lio14.2
+gf411_lvm growfiles -W gf411 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/nfs/g_lio15 /test/growfiles/nfs/g_lio15.2
+gf414_lvm growfiles -W gf414 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/nfs/glseek19 /test/growfiles/nfs/glseek19.2
+gf415_lvm growfiles -W gf415 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/nfs/Lgfile1
+gf420_lvm growfiles -W gf420 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/nfs/gfbigio-$$
+gf421_lvm growfiles -W gf421 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/nfs/gf-bld-$$
+gf422_lvm growfiles -W gf422 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/nfs/gf-bldf-$$
+gf423_lvm growfiles -W gf423 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/nfs/gf-inf-$$
+gf424_lvm growfiles -W gf424 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/nfs/gf-jbld-$$
+gf425_lvm growfiles -W gf425 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/nfs/gf-large-gs-$$
+gf426_lvm growfiles -W gf426 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/nfs/gfsmallio-$$
+gf427_lvm growfiles -W gf427 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/nfs/gfsparse-1-$$
+gf428_lvm growfiles -W gf428 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/nfs/gfsparse-2-$$
+gf429_lvm growfiles -W gf429 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/nfs/gfsparse-3-$$
+gf430_lvm growfiles -W gf428 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/nfs/gf-sync-$$
+rwtest401_lvm export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/nfs/rwtest16%f
+rwtest402_lvm export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/nfs/rwtest17%f
+rwtest403_lvm export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/nfs/rwtest18%f
+rwtest404_lvm export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/nfs/rwtest19%f
+rwtest405_lvm export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/nfs/rwtest20%f
 # Check a Ram Disk filesystem
-gf502 growfiles -W gf502 -d /test/growfiles/ramdisk -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf503 growfiles -W gf503 -d /test/growfiles/ramdisk -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-gf504 growfiles -W gf504 -d /test/growfiles/ramdisk -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-gf505 growfiles -W gf505 -d /test/growfiles/ramdisk -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf516 growfiles -W gf516 -d /test/growfiles/ramdisk -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf517 growfiles -W gf517 -d /test/growfiles/ramdisk -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf518 growfiles -W gf518 -d /test/growfiles/ramdisk -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
-gf519 growfiles -W gf519 -d /test/growfiles/ramdisk -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf512 mkfifo /test/growfiles/ramdisk/gffifo17; growfiles -W gf512 -b -e 1 -u -i 0 -L 30 /test/growfiles/ramdisk/gffifo17
-gf513 mkfifo /test/growfiles/ramdisk/gffifo18; growfiles -W gf513 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/ramdisk/gffifo18
-gf501 growfiles -W gf501 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/ramdisk/glseek20 /test/growfiles/ramdisk/glseek20.2
-gf506 growfiles -W gf506 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/ramdisk/g_rand10 /test/growfiles/ramdisk/g_rand10.2
-gf507 growfiles -W gf507 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/ramdisk/g_rand13 /test/growfiles/ramdisk/g_rand13.2
-gf508 growfiles -W gf508 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/ramdisk/g_rand11 /test/growfiles/ramdisk/g_rand11.2
-gf509 growfiles -W gf509 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/ramdisk/g_rand12 /test/growfiles/ramdisk/g_rand12.2
-gf510 growfiles -W gf510 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/ramdisk/g_lio14 /test/growfiles/ramdisk/g_lio14.2
-gf511 growfiles -W gf511 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/ramdisk/g_lio15 /test/growfiles/ramdisk/g_lio15.2
-gf514 growfiles -W gf514 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/ramdisk/glseek19 /test/growfiles/ramdisk/glseek19.2
-gf515 growfiles -W gf515 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/ramdisk/Lgfile1
-gf520 growfiles -W gf520 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/ramdisk/gfbigio-$$
-gf521 growfiles -W gf521 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/ramdisk/gf-bld-$$
-gf522 growfiles -W gf522 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/ramdisk/gf-bldf-$$
-gf523 growfiles -W gf523 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/ramdisk/gf-inf-$$
-gf524 growfiles -W gf524 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/ramdisk/gf-jbld-$$
-gf525 growfiles -W gf525 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/ramdisk/gf-large-gs-$$
-gf526 growfiles -W gf526 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/ramdisk/gfsmallio-$$
-gf527 growfiles -W gf527 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/ramdisk/gfsparse-1-$$
-gf528 growfiles -W gf528 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/ramdisk/gfsparse-2-$$
-gf529 growfiles -W gf529 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/ramdisk/gfsparse-3-$$
-gf530 growfiles -W gf530 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/ramdisk/gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/ramdisk/rwtest21%f
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/ramdisk/rwtest22%f
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/ramdisk/rwtest23%f
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/ramdisk/rwtest24%f
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/ramdisk/rwtest25%f
+gf502_lvm growfiles -W gf502 -d /test/growfiles/ramdisk -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
+gf503_lvm growfiles -W gf503 -d /test/growfiles/ramdisk -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
+gf504_lvm growfiles -W gf504 -d /test/growfiles/ramdisk -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
+gf505_lvm growfiles -W gf505 -d /test/growfiles/ramdisk -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
+gf516_lvm growfiles -W gf516 -d /test/growfiles/ramdisk -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
+gf517_lvm growfiles -W gf517 -d /test/growfiles/ramdisk -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
+gf518_lvm growfiles -W gf518 -d /test/growfiles/ramdisk -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
+gf519_lvm growfiles -W gf519 -d /test/growfiles/ramdisk -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
+gf512_lvm mkfifo /test/growfiles/ramdisk/gffifo17; growfiles -W gf512 -b -e 1 -u -i 0 -L 30 /test/growfiles/ramdisk/gffifo17
+gf513_lvm mkfifo /test/growfiles/ramdisk/gffifo18; growfiles -W gf513 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/ramdisk/gffifo18
+gf501_lvm growfiles -W gf501 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/ramdisk/glseek20 /test/growfiles/ramdisk/glseek20.2
+gf506_lvm growfiles -W gf506 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/ramdisk/g_rand10 /test/growfiles/ramdisk/g_rand10.2
+gf507_lvm growfiles -W gf507 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/ramdisk/g_rand13 /test/growfiles/ramdisk/g_rand13.2
+gf508_lvm growfiles -W gf508 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/ramdisk/g_rand11 /test/growfiles/ramdisk/g_rand11.2
+gf509_lvm growfiles -W gf509 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/ramdisk/g_rand12 /test/growfiles/ramdisk/g_rand12.2
+gf510_lvm growfiles -W gf510 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/ramdisk/g_lio14 /test/growfiles/ramdisk/g_lio14.2
+gf511_lvm growfiles -W gf511 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/ramdisk/g_lio15 /test/growfiles/ramdisk/g_lio15.2
+gf514_lvm growfiles -W gf514 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/ramdisk/glseek19 /test/growfiles/ramdisk/glseek19.2
+gf515_lvm growfiles -W gf515 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/ramdisk/Lgfile1
+gf520_lvm growfiles -W gf520 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/ramdisk/gfbigio-$$
+gf521_lvm growfiles -W gf521 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/ramdisk/gf-bld-$$
+gf522_lvm growfiles -W gf522 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/ramdisk/gf-bldf-$$
+gf523_lvm growfiles -W gf523 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/ramdisk/gf-inf-$$
+gf524_lvm growfiles -W gf524 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/ramdisk/gf-jbld-$$
+gf525_lvm growfiles -W gf525 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/ramdisk/gf-large-gs-$$
+gf526_lvm growfiles -W gf526 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/ramdisk/gfsmallio-$$
+gf527_lvm growfiles -W gf527 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/ramdisk/gfsparse-1-$$
+gf528_lvm growfiles -W gf528 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/ramdisk/gfsparse-2-$$
+gf529_lvm growfiles -W gf529 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/ramdisk/gfsparse-3-$$
+gf530_lvm growfiles -W gf530 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/ramdisk/gf-sync-$$
+rwtest501_lvm export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/ramdisk/rwtest21%f
+rwtest502_lvm export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/ramdisk/rwtest22%f
+rwtest503_lvm export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/ramdisk/rwtest23%f
+rwtest504_lvm export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/ramdisk/rwtest24%f
+rwtest505_lvm export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/ramdisk/rwtest25%f
 # Check the MINIX filesystem
-gf602 growfiles -W gf602 -d /test/growfiles/minix -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf603 growfiles -W gf603 -d /test/growfiles/minix -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-gf604 growfiles -W gf604 -d /test/growfiles/minix -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-gf605 growfiles -W gf605 -d /test/growfiles/minix -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf616 growfiles -W gf616 -d /test/growfiles/minix -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf617 growfiles -W gf617 -d /test/growfiles/minix -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf618 growfiles -W gf618 -d /test/growfiles/minix -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
-gf619 growfiles -W gf619 -d /test/growfiles/minix -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf612 mkfifo /test/growfiles/minix/gffifo17; growfiles -W gf612 -b -e 1 -u -i 0 -L 30 /test/growfiles/minix/gffifo17
-gf613 mkfifo /test/growfiles/minix/gffifo18; growfiles -W gf613 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/minix/gffifo18
-gf601 growfiles -W gf601 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/minix/glseek20 /test/growfiles/minix/glseek20.2
-gf606 growfiles -W gf606 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/minix/g_rand10 /test/growfiles/minix/g_rand10.2
-gf607 growfiles -W gf607 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/minix/g_rand13 /test/growfiles/minix/g_rand13.2
-gf608 growfiles -W gf608 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/minix/g_rand11 /test/growfiles/minix/g_rand11.2
-gf609 growfiles -W gf609 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/minix/g_rand12 /test/growfiles/minix/g_rand12.2
-gf610 growfiles -W gf610 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/minix/g_lio14 /test/growfiles/minix/g_lio14.2
-gf611 growfiles -W gf611 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/minix/g_lio15 /test/growfiles/minix/g_lio15.2
-gf614 growfiles -W gf614 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/minix/glseek19 /test/growfiles/minix/glseek19.2
-gf615 growfiles -W gf615 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/minix/Lgfile1
-gf620 growfiles -W gf620 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/minix/gfbigio-$$
-gf621 growfiles -W gf621 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/minix/gf-bld-$$
-gf622 growfiles -W gf622 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/minix/gf-bldf-$$
-gf623 growfiles -W gf623 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/minix/gf-inf-$$
-gf624 growfiles -W gf624 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/minix/gf-jbld-$$
-gf625 growfiles -W gf625 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/minix/gf-large-gs-$$
-gf626 growfiles -W gf626 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/minix/gfsmallio-$$
-gf627 growfiles -W gf627 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/minix/gfsparse-1-$$
-gf628 growfiles -W gf628 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/minix/gfsparse-2-$$
-gf629 growfiles -W gf629 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/minix/gfsparse-3-$$
-gf630 growfiles -W gf630 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/minix/gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/minix/rwtest26%f
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/minix/rwtest27%f
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/minix/rwtest28%f
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/minix/rwtest29%f
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/minix/rwtest30%f
+gf602_lvm growfiles -W gf602 -d /test/growfiles/minix -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
+gf603_lvm growfiles -W gf603 -d /test/growfiles/minix -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
+gf604_lvm growfiles -W gf604 -d /test/growfiles/minix -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
+gf605_lvm growfiles -W gf605 -d /test/growfiles/minix -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
+gf616_lvm growfiles -W gf616 -d /test/growfiles/minix -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
+gf617_lvm growfiles -W gf617 -d /test/growfiles/minix -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
+gf618_lvm growfiles -W gf618 -d /test/growfiles/minix -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
+gf619_lvm growfiles -W gf619 -d /test/growfiles/minix -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
+gf612_lvm mkfifo /test/growfiles/minix/gffifo17; growfiles -W gf612 -b -e 1 -u -i 0 -L 30 /test/growfiles/minix/gffifo17
+gf613_lvm mkfifo /test/growfiles/minix/gffifo18; growfiles -W gf613 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/minix/gffifo18
+gf601_lvm growfiles -W gf601 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/minix/glseek20 /test/growfiles/minix/glseek20.2
+gf606_lvm growfiles -W gf606 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/minix/g_rand10 /test/growfiles/minix/g_rand10.2
+gf607_lvm growfiles -W gf607 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/minix/g_rand13 /test/growfiles/minix/g_rand13.2
+gf608_lvm growfiles -W gf608 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/minix/g_rand11 /test/growfiles/minix/g_rand11.2
+gf609_lvm growfiles -W gf609 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/minix/g_rand12 /test/growfiles/minix/g_rand12.2
+gf610_lvm growfiles -W gf610 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/minix/g_lio14 /test/growfiles/minix/g_lio14.2
+gf611_lvm growfiles -W gf611 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/minix/g_lio15 /test/growfiles/minix/g_lio15.2
+gf614_lvm growfiles -W gf614 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/minix/glseek19 /test/growfiles/minix/glseek19.2
+gf615_lvm growfiles -W gf615 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/minix/Lgfile1
+gf620_lvm growfiles -W gf620 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/minix/gfbigio-$$
+gf621_lvm growfiles -W gf621 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/minix/gf-bld-$$
+gf622_lvm growfiles -W gf622 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/minix/gf-bldf-$$
+gf623_lvm growfiles -W gf623 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/minix/gf-inf-$$
+gf624_lvm growfiles -W gf624 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/minix/gf-jbld-$$
+gf625_lvm growfiles -W gf625 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/minix/gf-large-gs-$$
+gf626_lvm growfiles -W gf626 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/minix/gfsmallio-$$
+gf627_lvm growfiles -W gf627 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/minix/gfsparse-1-$$
+gf628_lvm growfiles -W gf628 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/minix/gfsparse-2-$$
+gf629_lvm growfiles -W gf629 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/minix/gfsparse-3-$$
+gf630_lvm growfiles -W gf630 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/minix/gf-sync-$$
+rwtest601_lvm export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/minix/rwtest26%f
+rwtest602_lvm export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/minix/rwtest27%f
+rwtest603_lvm export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/minix/rwtest28%f
+rwtest604_lvm export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/minix/rwtest29%f
+rwtest605_lvm export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/minix/rwtest30%f
diff --git a/runtest/lvm.part2 b/runtest/lvm.part2
index f0dbf3277..911cb11d7 100644
--- a/runtest/lvm.part2
+++ b/runtest/lvm.part2
@@ -1,72 +1,72 @@
 # Check the EXT3 filesystem
-gf702 growfiles -W gf702 -d /test/growfiles/ext3 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf703 growfiles -W gf703 -d /test/growfiles/ext3 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-gf704 growfiles -W gf704 -d /test/growfiles/ext3 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-gf705 growfiles -W gf705 -d /test/growfiles/ext3 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf716 growfiles -W gf716 -d /test/growfiles/ext3 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf717 growfiles -W gf717 -d /test/growfiles/ext3 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf718 growfiles -W gf718 -d /test/growfiles/ext3 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
-gf719 growfiles -W gf719 -d /test/growfiles/ext3 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf712 mkfifo gffifo17; growfiles -W gf712 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 30 gffifo17
-gf713 mkfifo gffifo18; growfiles -W gf713 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18
-gf701 growfiles -W gf701 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
-gf706 growfiles -W gf706 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand10 g_rand10.2
-gf707 growfiles -W gf707 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_rand13 g_rand13.2
-gf708 growfiles -W gf708 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand11 g_rand11.2
-gf709 growfiles -W gf709 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_rand12 g_rand12.2
-gf710 growfiles -W gf710 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2
-gf711 growfiles -W gf711 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2
-gf714 growfiles -W gf714 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
-gf715 growfiles -W gf715 -d /test/growfiles/ext3 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
-gf720 growfiles -W gf720 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$
-gf721 growfiles -W gf721 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$
-gf722 growfiles -W gf722 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$
-gf723 growfiles -W gf723 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$
-gf724 growfiles -W gf724 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$
-gf725 growfiles -W gf725 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$
-gf726 growfiles -W gf726 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$
-gf727 growfiles -W gf727 -d /test/growfiles/ext3 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$
-gf728 growfiles -W gf728 -d /test/growfiles/ext3 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
-gf729 growfiles -W gf729 -d /test/growfiles/ext3 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$
-gf730 growfiles -W gf730 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/ext3/rwtest11%f
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/ext3/rwtest12%f
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/ext3/rwtest13%f
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/ext3/rwtest14%f
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/ext3/rwtest15%f
+gf702_lvm growfiles -W gf702 -d /test/growfiles/ext3 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
+gf703_lvm growfiles -W gf703 -d /test/growfiles/ext3 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
+gf704_lvm growfiles -W gf704 -d /test/growfiles/ext3 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
+gf705_lvm growfiles -W gf705 -d /test/growfiles/ext3 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
+gf716_lvm growfiles -W gf716 -d /test/growfiles/ext3 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
+gf717_lvm growfiles -W gf717 -d /test/growfiles/ext3 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
+gf718_lvm growfiles -W gf718 -d /test/growfiles/ext3 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
+gf719_lvm growfiles -W gf719 -d /test/growfiles/ext3 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
+gf712_lvm mkfifo gffifo17; growfiles -W gf712 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 30 gffifo17
+gf713_lvm mkfifo gffifo18; growfiles -W gf713 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18
+gf701_lvm growfiles -W gf701 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
+gf706_lvm growfiles -W gf706 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand10 g_rand10.2
+gf707_lvm growfiles -W gf707 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_rand13 g_rand13.2
+gf708_lvm growfiles -W gf708 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand11 g_rand11.2
+gf709_lvm growfiles -W gf709 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_rand12 g_rand12.2
+gf710_lvm growfiles -W gf710 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2
+gf711_lvm growfiles -W gf711 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2
+gf714_lvm growfiles -W gf714 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
+gf715_lvm growfiles -W gf715 -d /test/growfiles/ext3 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
+gf720_lvm growfiles -W gf720 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$
+gf721_lvm growfiles -W gf721 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$
+gf722_lvm growfiles -W gf722 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$
+gf723_lvm growfiles -W gf723 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$
+gf724_lvm growfiles -W gf724 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$
+gf725_lvm growfiles -W gf725 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$
+gf726_lvm growfiles -W gf726 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$
+gf727_lvm growfiles -W gf727 -d /test/growfiles/ext3 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$
+gf728_lvm growfiles -W gf728 -d /test/growfiles/ext3 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
+gf729_lvm growfiles -W gf729 -d /test/growfiles/ext3 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$
+gf730_lvm growfiles -W gf730 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$
+rwtest701_lvm export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/ext3/rwtest11%f
+rwtest702_lvm export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/ext3/rwtest12%f
+rwtest703_lvm export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/ext3/rwtest13%f
+rwtest704_lvm export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/ext3/rwtest14%f
+rwtest705_lvm export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/ext3/rwtest15%f
 # Check the JFS filesystem
-gf802 growfiles -W gf802 -d /test/growfiles/jfs -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf803 growfiles -W gf803 -d /test/growfiles/jfs -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-gf804 growfiles -W gf804 -d /test/growfiles/jfs -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-gf805 growfiles -W gf805 -d /test/growfiles/jfs -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf816 growfiles -W gf816 -d /test/growfiles/jfs -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf817 growfiles -W gf817 -d /test/growfiles/jfs -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf818 growfiles -W gf818 -d /test/growfiles/jfs -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
-gf819 growfiles -W gf819 -d /test/growfiles/jfs -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf812 mkfifo /test/growfiles/jfs/gffifo17; growfiles -W gf812 -b -e 1 -u -i 0 -L 30 /test/growfiles/jfs/gffifo17
-gf813 mkfifo /test/growfiles/jfs/gffifo18; growfiles -W gf813 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/jfs/gffifo18
-gf801 growfiles -W gf801 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/jfs/glseek20 /test/growfiles/jfs/glseek20.2
-gf806 growfiles -W gf806 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/jfs/g_rand10 /test/growfiles/jfs/g_rand10.2
-gf807 growfiles -W gf807 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/jfs/g_rand13 /test/growfiles/jfs/g_rand13.2
-gf808 growfiles -W gf808 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/jfs/g_rand11 /test/growfiles/jfs/g_rand11.2
-gf809 growfiles -W gf809 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/jfs/g_rand12 /test/growfiles/jfs/g_rand12.2
-gf810 growfiles -W gf810 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/jfs/g_lio14 /test/growfiles/jfs/g_lio14.2
-gf811 growfiles -W gf811 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/jfs/g_lio15 /test/growfiles/jfs/g_lio15.2
-gf814 growfiles -W gf814 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/jfs/glseek19 /test/growfiles/jfs/glseek19.2
-gf815 growfiles -W gf815 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/jfs/Lgfile1
-gf820 growfiles -W gf820 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/jfs/gfbigio-$$
-gf821 growfiles -W gf821 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/jfs/gf-bld-$$
-gf822 growfiles -W gf822 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/jfs/gf-bldf-$$
-gf823 growfiles -W gf823 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/jfs/gf-inf-$$
-gf824 growfiles -W gf824 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/jfs/gf-jbld-$$
-gf825 growfiles -W gf825 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/jfs/gf-large-gs-$$
-gf826 growfiles -W gf826 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/jfs/gfsmallio-$$
-gf827 growfiles -W gf827 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/jfs/gfsparse-1-$$
-gf828 growfiles -W gf828 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/jfs/gfsparse-2-$$
-gf829 growfiles -W gf829 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/jfs/gfsparse-3-$$
-gf830 growfiles -W gf830 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/jfs/gf-sync-$$
-rwtest11 export LTPROOT; rwtest -N rwtest11 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/jfs/rwtest11%f
-rwtest12 export LTPROOT; rwtest -N rwtest12 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/jfs/rwtest12%f
-rwtest13 export LTPROOT; rwtest -N rwtest13 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/jfs/rwtest13%f
-rwtest14 export LTPROOT; rwtest -N rwtest14 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/jfs/rwtest14%f
-rwtest15 export LTPROOT; rwtest -N rwtest15 -c -q -i 50 -T 64b 500b:/test/growfiles/jfs/rwtest15%f
+gf802_lvm growfiles -W gf802 -d /test/growfiles/jfs -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
+gf803_lvm growfiles -W gf803 -d /test/growfiles/jfs -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
+gf804_lvm growfiles -W gf804 -d /test/growfiles/jfs -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
+gf805_lvm growfiles -W gf805 -d /test/growfiles/jfs -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
+gf816_lvm growfiles -W gf816 -d /test/growfiles/jfs -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
+gf817_lvm growfiles -W gf817 -d /test/growfiles/jfs -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
+gf818_lvm growfiles -W gf818 -d /test/growfiles/jfs -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
+gf819_lvm growfiles -W gf819 -d /test/growfiles/jfs -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
+gf812_lvm mkfifo /test/growfiles/jfs/gffifo17; growfiles -W gf812 -b -e 1 -u -i 0 -L 30 /test/growfiles/jfs/gffifo17
+gf813_lvm mkfifo /test/growfiles/jfs/gffifo18; growfiles -W gf813 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 /test/growfiles/jfs/gffifo18
+gf801_lvm growfiles -W gf801 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 /test/growfiles/jfs/glseek20 /test/growfiles/jfs/glseek20.2
+gf806_lvm growfiles -W gf806 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 /test/growfiles/jfs/g_rand10 /test/growfiles/jfs/g_rand10.2
+gf807_lvm growfiles -W gf807 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p /test/growfiles/jfs/g_rand13 /test/growfiles/jfs/g_rand13.2
+gf808_lvm growfiles -W gf808 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 /test/growfiles/jfs/g_rand11 /test/growfiles/jfs/g_rand11.2
+gf809_lvm growfiles -W gf809 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p /test/growfiles/jfs/g_rand12 /test/growfiles/jfs/g_rand12.2
+gf810_lvm growfiles -W gf810 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l /test/growfiles/jfs/g_lio14 /test/growfiles/jfs/g_lio14.2
+gf811_lvm growfiles -W gf811 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L /test/growfiles/jfs/g_lio15 /test/growfiles/jfs/g_lio15.2
+gf814_lvm growfiles -W gf814 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 /test/growfiles/jfs/glseek19 /test/growfiles/jfs/glseek19.2
+gf815_lvm growfiles -W gf815 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 /test/growfiles/jfs/Lgfile1
+gf820_lvm growfiles -W gf820 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 /test/growfiles/jfs/gfbigio-$$
+gf821_lvm growfiles -W gf821 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/jfs/gf-bld-$$
+gf822_lvm growfiles -W gf822 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 /test/growfiles/jfs/gf-bldf-$$
+gf823_lvm growfiles -W gf823 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 /test/growfiles/jfs/gf-inf-$$
+gf824_lvm growfiles -W gf824 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 /test/growfiles/jfs/gf-jbld-$$
+gf825_lvm growfiles -W gf825 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 /test/growfiles/jfs/gf-large-gs-$$
+gf826_lvm growfiles -W gf826 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 /test/growfiles/jfs/gfsmallio-$$
+gf827_lvm growfiles -W gf827 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u /test/growfiles/jfs/gfsparse-1-$$
+gf828_lvm growfiles -W gf828 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u /test/growfiles/jfs/gfsparse-2-$$
+gf829_lvm growfiles -W gf829 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u /test/growfiles/jfs/gfsparse-3-$$
+gf830_lvm growfiles -W gf830 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 /test/growfiles/jfs/gf-sync-$$
+rwtest811_lvm export LTPROOT; rwtest -N rwtest11 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/jfs/rwtest11%f
+rwtest812_lvm export LTPROOT; rwtest -N rwtest12 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/jfs/rwtest12%f
+rwtest813_lvm export LTPROOT; rwtest -N rwtest13 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/jfs/rwtest13%f
+rwtest814_lvm export LTPROOT; rwtest -N rwtest14 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/jfs/rwtest14%f
+rwtest815_lvm export LTPROOT; rwtest -N rwtest15 -c -q -i 50 -T 64b 500b:/test/growfiles/jfs/rwtest15%f
diff --git a/runtest/scsi_debug.part1 b/runtest/scsi_debug.part1
index ce1470288..40d509974 100644
--- a/runtest/scsi_debug.part1
+++ b/runtest/scsi_debug.part1
@@ -1,145 +1,145 @@
 #DESCRIPTION:scsi_debug filesystem tests
 # Check the Reiserfs filesystem
-gf201 growfiles -W gf201 -d /test/growfiles/reiser -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
-gf202 growfiles -W gf202 -d /test/growfiles/reiser -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf203 growfiles -W gf203 -d /test/growfiles/reiser -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-gf204 growfiles -W gf204 -d /test/growfiles/reiser -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-gf205 growfiles -W gf205 -d /test/growfiles/reiser -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf206 growfiles -W gf206 -d /test/growfiles/reiser -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand10 g_rand10.2
-gf207 growfiles -W gf207 -d /test/growfiles/reiser -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_rand13 g_rand13.2
-gf208 growfiles -W gf208 -d /test/growfiles/reiser -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand11 g_rand11.2
-gf209 growfiles -W gf209 -d /test/growfiles/reiser -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_rand12 g_rand12.2
-gf210 growfiles -W gf210 -d /test/growfiles/reiser -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2
-gf211 growfiles -W gf211 -d /test/growfiles/reiser -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2
-gf212 mkfifo gffifo17; growfiles -W gf212 -d /test/growfiles/reiser -b -e 1 -u -i 0 -L 30 gffifo17
-gf213 mkfifo gffifo18; growfiles -W gf213 -d /test/growfiles/reiser -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18
-gf214 growfiles -W gf214 -d /test/growfiles/reiser -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
-gf215 growfiles -W gf215 -d /test/growfiles/reiser -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
-gf216 growfiles -W gf216 -d /test/growfiles/reiser -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf217 growfiles -W gf217 -d /test/growfiles/reiser -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf218 growfiles -W gf218 -d /test/growfiles/reiser -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
-gf219 growfiles -W gf219 -d /test/growfiles/reiser -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf220 growfiles -W gf220 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$
-gf221 growfiles -W gf221 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$
-gf222 growfiles -W gf222 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$
-gf223 growfiles -W gf223 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$
-gf224 growfiles -W gf224 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$
-gf225 growfiles -W gf225 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$
-gf226 growfiles -W gf226 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$
-gf227 growfiles -W gf227 -d /test/growfiles/reiser -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$
-gf228 growfiles -W gf228 -d /test/growfiles/reiser -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
-gf229 growfiles -W gf229 -d /test/growfiles/reiser -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$
-gf230 growfiles -W gf230 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/reiser/rwtest06%f
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/reiser/rwtest07%f
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/reiser/rwtest08%f
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/reiser/rwtest09%f
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/reiser/rwtest10%f
+gf201_scsi growfiles -W gf201 -d /test/growfiles/reiser -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
+gf202_scsi growfiles -W gf202 -d /test/growfiles/reiser -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
+gf203_scsi growfiles -W gf203 -d /test/growfiles/reiser -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
+gf204_scsi growfiles -W gf204 -d /test/growfiles/reiser -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
+gf205_scsi growfiles -W gf205 -d /test/growfiles/reiser -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
+gf206_scsi growfiles -W gf206 -d /test/growfiles/reiser -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand10 g_rand10.2
+gf207_scsi growfiles -W gf207 -d /test/growfiles/reiser -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_rand13 g_rand13.2
+gf208_scsi growfiles -W gf208 -d /test/growfiles/reiser -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand11 g_rand11.2
+gf209_scsi growfiles -W gf209 -d /test/growfiles/reiser -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_rand12 g_rand12.2
+gf210_scsi growfiles -W gf210 -d /test/growfiles/reiser -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2
+gf211_scsi growfiles -W gf211 -d /test/growfiles/reiser -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2
+gf212_scsi mkfifo gffifo17; growfiles -W gf212 -d /test/growfiles/reiser -b -e 1 -u -i 0 -L 30 gffifo17
+gf213_scsi mkfifo gffifo18; growfiles -W gf213 -d /test/growfiles/reiser -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18
+gf214_scsi growfiles -W gf214 -d /test/growfiles/reiser -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
+gf215_scsi growfiles -W gf215 -d /test/growfiles/reiser -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
+gf216_scsi growfiles -W gf216 -d /test/growfiles/reiser -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
+gf217_scsi growfiles -W gf217 -d /test/growfiles/reiser -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
+gf218_scsi growfiles -W gf218 -d /test/growfiles/reiser -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
+gf219_scsi growfiles -W gf219 -d /test/growfiles/reiser -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
+gf220_scsi growfiles -W gf220 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$
+gf221_scsi growfiles -W gf221 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$
+gf222_scsi growfiles -W gf222 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$
+gf223_scsi growfiles -W gf223 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$
+gf224_scsi growfiles -W gf224 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$
+gf225_scsi growfiles -W gf225 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$
+gf226_scsi growfiles -W gf226 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$
+gf227_scsi growfiles -W gf227 -d /test/growfiles/reiser -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$
+gf228_scsi growfiles -W gf228 -d /test/growfiles/reiser -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
+gf229_scsi growfiles -W gf229 -d /test/growfiles/reiser -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$
+gf230_scsi growfiles -W gf230 -d /test/growfiles/reiser -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$
+rwtest201_scsi export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/reiser/rwtest06%f
+rwtest202_scsi export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/reiser/rwtest07%f
+rwtest203_scsi export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/reiser/rwtest08%f
+rwtest204_scsi export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/reiser/rwtest09%f
+rwtest205_scsi export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/reiser/rwtest10%f
 # Check the EXT2 filesystem
-gf301 growfiles -W gf301 -d /test/growfiles/ext2 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
-gf302 growfiles -W gf302 -d /test/growfiles/ext2 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf303 growfiles -W gf303 -d /test/growfiles/ext2 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-gf304 growfiles -W gf304 -d /test/growfiles/ext2 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-gf305 growfiles -W gf305 -d /test/growfiles/ext2 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf306 growfiles -W gf306 -d /test/growfiles/ext2 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand10 g_rand10.2
-gf307 growfiles -W gf307 -d /test/growfiles/ext2 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_rand13 g_rand13.2
-gf308 growfiles -W gf308 -d /test/growfiles/ext2 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand11 g_rand11.2
-gf309 growfiles -W gf309 -d /test/growfiles/ext2 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_rand12 g_rand12.2
-gf310 growfiles -W gf310 -d /test/growfiles/ext2 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2
-gf311 growfiles -W gf311 -d /test/growfiles/ext2 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2
-gf312 mkfifo gffifo17; growfiles -W gf312 -d /test/growfiles/ext2 -b -e 1 -u -i 0 -L 30 gffifo17
-gf313 mkfifo gffifo18; growfiles -W gf313 -d /test/growfiles/ext2 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18
-gf314 growfiles -W gf314 -d /test/growfiles/ext2 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
-gf315 growfiles -W gf315 -d /test/growfiles/ext2 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
-gf316 growfiles -W gf316 -d /test/growfiles/ext2 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf317 growfiles -W gf317 -d /test/growfiles/ext2 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf318 growfiles -W gf318 -d /test/growfiles/ext2 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
-gf319 growfiles -W gf319 -d /test/growfiles/ext2 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf320 growfiles -W gf320 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$
-gf321 growfiles -W gf321 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$
-gf322 growfiles -W gf322 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$
-gf323 growfiles -W gf323 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$
-gf324 growfiles -W gf324 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$
-gf325 growfiles -W gf325 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$
-gf326 growfiles -W gf326 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$
-gf327 growfiles -W gf327 -d /test/growfiles/ext2 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$
-gf328 growfiles -W gf328 -d /test/growfiles/ext2 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
-gf329 growfiles -W gf329 -d /test/growfiles/ext2 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$
-gf330 growfiles -W gf330 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/ext2/rwtest11%f
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/ext2/rwtest12%f
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/ext2/rwtest13%f
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/ext2/rwtest14%f
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/ext2/rwtest15%f
+gf301_scsi growfiles -W gf301 -d /test/growfiles/ext2 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
+gf302_scsi growfiles -W gf302 -d /test/growfiles/ext2 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
+gf303_scsi growfiles -W gf303 -d /test/growfiles/ext2 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
+gf304_scsi growfiles -W gf304 -d /test/growfiles/ext2 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
+gf305_scsi growfiles -W gf305 -d /test/growfiles/ext2 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
+gf306_scsi growfiles -W gf306 -d /test/growfiles/ext2 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand10 g_rand10.2
+gf307_scsi growfiles -W gf307 -d /test/growfiles/ext2 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_rand13 g_rand13.2
+gf308_scsi growfiles -W gf308 -d /test/growfiles/ext2 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand11 g_rand11.2
+gf309_scsi growfiles -W gf309 -d /test/growfiles/ext2 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_rand12 g_rand12.2
+gf310_scsi growfiles -W gf310 -d /test/growfiles/ext2 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2
+gf311_scsi growfiles -W gf311 -d /test/growfiles/ext2 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2
+gf312_scsi mkfifo gffifo17; growfiles -W gf312 -d /test/growfiles/ext2 -b -e 1 -u -i 0 -L 30 gffifo17
+gf313_scsi mkfifo gffifo18; growfiles -W gf313 -d /test/growfiles/ext2 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18
+gf314_scsi growfiles -W gf314 -d /test/growfiles/ext2 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
+gf315_scsi growfiles -W gf315 -d /test/growfiles/ext2 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
+gf316_scsi growfiles -W gf316 -d /test/growfiles/ext2 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
+gf317_scsi growfiles -W gf317 -d /test/growfiles/ext2 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
+gf318_scsi growfiles -W gf318 -d /test/growfiles/ext2 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
+gf319_scsi growfiles -W gf319 -d /test/growfiles/ext2 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
+gf320_scsi growfiles -W gf320 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$
+gf321_scsi growfiles -W gf321 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$
+gf322_scsi growfiles -W gf322 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$
+gf323_scsi growfiles -W gf323 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$
+gf324_scsi growfiles -W gf324 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$
+gf325_scsi growfiles -W gf325 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$
+gf326_scsi growfiles -W gf326 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$
+gf327_scsi growfiles -W gf327 -d /test/growfiles/ext2 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$
+gf328_scsi growfiles -W gf328 -d /test/growfiles/ext2 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
+gf329_scsi growfiles -W gf329 -d /test/growfiles/ext2 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$
+gf330_scsi growfiles -W gf330 -d /test/growfiles/ext2 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$
+rwtest301_scsi export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/ext2/rwtest11%f
+rwtest302_scsi export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/ext2/rwtest12%f
+rwtest303_scsi export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/ext2/rwtest13%f
+rwtest304_scsi export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/ext2/rwtest14%f
+rwtest305_scsi export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/ext2/rwtest15%f
 # Check the EXT3 filesystem
-gf701 growfiles -W gf701 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
-gf702 growfiles -W gf702 -d /test/growfiles/ext3 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf703 growfiles -W gf703 -d /test/growfiles/ext3 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-gf704 growfiles -W gf704 -d /test/growfiles/ext3 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-gf705 growfiles -W gf705 -d /test/growfiles/ext3 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf706 growfiles -W gf706 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand10 g_rand10.2
-gf707 growfiles -W gf707 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_rand13 g_rand13.2
-gf708 growfiles -W gf708 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand11 g_rand11.2
-gf709 growfiles -W gf709 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_rand12 g_rand12.2
-gf710 growfiles -W gf710 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2
-gf711 growfiles -W gf711 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2
-gf712 mkfifo gffifo17; growfiles -W gf712 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 30 gffifo17
-gf713 mkfifo gffifo18; growfiles -W gf713 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18
-gf714 growfiles -W gf714 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
-gf715 growfiles -W gf715 -d /test/growfiles/ext3 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
-gf716 growfiles -W gf716 -d /test/growfiles/ext3 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf717 growfiles -W gf717 -d /test/growfiles/ext3 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf718 growfiles -W gf718 -d /test/growfiles/ext3 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
-gf719 growfiles -W gf719 -d /test/growfiles/ext3 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf720 growfiles -W gf720 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$
-gf721 growfiles -W gf721 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$
-gf722 growfiles -W gf722 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$
-gf723 growfiles -W gf723 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$
-gf724 growfiles -W gf724 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$
-gf725 growfiles -W gf725 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$
-gf726 growfiles -W gf726 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$
-gf727 growfiles -W gf727 -d /test/growfiles/ext3 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$
-gf728 growfiles -W gf728 -d /test/growfiles/ext3 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
-gf729 growfiles -W gf729 -d /test/growfiles/ext3 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$
-gf730 growfiles -W gf730 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/ext3/rwtest11%f
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/ext3/rwtest12%f
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/ext3/rwtest13%f
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/ext3/rwtest14%f
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/ext3/rwtest15%f
+gf701_scsi growfiles -W gf701 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
+gf702_scsi growfiles -W gf702 -d /test/growfiles/ext3 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
+gf703_scsi growfiles -W gf703 -d /test/growfiles/ext3 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
+gf704_scsi growfiles -W gf704 -d /test/growfiles/ext3 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
+gf705_scsi growfiles -W gf705 -d /test/growfiles/ext3 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
+gf706_scsi growfiles -W gf706 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand10 g_rand10.2
+gf707_scsi growfiles -W gf707 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_rand13 g_rand13.2
+gf708_scsi growfiles -W gf708 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand11 g_rand11.2
+gf709_scsi growfiles -W gf709 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_rand12 g_rand12.2
+gf710_scsi growfiles -W gf710 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2
+gf711_scsi growfiles -W gf711 -d /test/growfiles/ext3 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2
+gf712_scsi mkfifo gffifo17; growfiles -W gf712 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 30 gffifo17
+gf713_scsi mkfifo gffifo18; growfiles -W gf713 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18
+gf714_scsi growfiles -W gf714 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
+gf715_scsi growfiles -W gf715 -d /test/growfiles/ext3 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
+gf716_scsi growfiles -W gf716 -d /test/growfiles/ext3 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
+gf717_scsi growfiles -W gf717 -d /test/growfiles/ext3 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
+gf718_scsi growfiles -W gf718 -d /test/growfiles/ext3 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
+gf719_scsi growfiles -W gf719 -d /test/growfiles/ext3 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
+gf720_scsi growfiles -W gf720 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$
+gf721_scsi growfiles -W gf721 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$
+gf722_scsi growfiles -W gf722 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$
+gf723_scsi growfiles -W gf723 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$
+gf724_scsi growfiles -W gf724 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$
+gf725_scsi growfiles -W gf725 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$
+gf726_scsi growfiles -W gf726 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$
+gf727_scsi growfiles -W gf727 -d /test/growfiles/ext3 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$
+gf728_scsi growfiles -W gf728 -d /test/growfiles/ext3 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
+gf729_scsi growfiles -W gf729 -d /test/growfiles/ext3 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$
+gf730_scsi growfiles -W gf730 -d /test/growfiles/ext3 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$
+rwtest701_scsi export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/ext3/rwtest11%f
+rwtest702_scsi export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/ext3/rwtest12%f
+rwtest703_scsi export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/ext3/rwtest13%f
+rwtest704_scsi export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/ext3/rwtest14%f
+rwtest705_scsi export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/ext3/rwtest15%f
 # Check the MSDOS filesystem
-gf101 growfiles -W gf101 -d /test/growfiles/msdos -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
-gf102 growfiles -W gf102 -d /test/growfiles/msdos -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-gf103 growfiles -W gf103 -d /test/growfiles/msdos -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
-gf104 growfiles -W gf104 -d /test/growfiles/msdos -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
-gf105 growfiles -W gf105 -d /test/growfiles/msdos -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
-gf106 growfiles -W gf106 -d /test/growfiles/msdos -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand10 g_rand10.2
-gf107 growfiles -W gf107 -d /test/growfiles/msdos -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_rand13 g_rand13.2
-gf108 growfiles -W gf108 -d /test/growfiles/msdos -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand11 g_rand11.2
-gf109 growfiles -W gf109 -d /test/growfiles/msdos -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_rand12 g_rand12.2
-gf110 growfiles -W gf110 -d /test/growfiles/msdos -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2
-gf111 growfiles -W gf111 -d /test/growfiles/msdos -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2
-gf112 mkfifo gffifo17; growfiles -W gf112 -d /test/growfiles/msdos -b -e 1 -u -i 0 -L 30 gffifo17
-gf113 mkfifo gffifo18; growfiles -W gf113 -d /test/growfiles/msdos -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18
-gf114 growfiles -W gf114 -d /test/growfiles/msdos -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
-gf115 growfiles -W gf115 -d /test/growfiles/msdos -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
-gf116 growfiles -W gf116 -d /test/growfiles/msdos -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
-gf117 growfiles -W gf117 -d /test/growfiles/msdos -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
-gf118 growfiles -W gf118 -d /test/growfiles/msdos -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
-gf119 growfiles -W gf119 -d /test/growfiles/msdos -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
-gf120 growfiles -W gf120 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$
-gf121 growfiles -W gf121 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$
-gf122 growfiles -W gf122 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$
-gf123 growfiles -W gf123 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$
-gf124 growfiles -W gf124 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$
-gf125 growfiles -W gf125 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$
-gf126 growfiles -W gf126 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$
-gf127 growfiles -W gf127 -d /test/growfiles/msdos -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$
-gf128 growfiles -W gf128 -d /test/growfiles/msdos -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
-gf129 growfiles -W gf129 -d /test/growfiles/msdos -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$
-gf130 growfiles -W gf130 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/msdos/rwtest01%f
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/msdos/rwtest02%f
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/msdos/rwtest03%f
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/msdos/rwtest04%f
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/msdos/rwtest05%f
+gf101_scsi growfiles -W gf101 -d /test/growfiles/msdos -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
+gf102_scsi growfiles -W gf102 -d /test/growfiles/msdos -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
+gf103_scsi growfiles -W gf103 -d /test/growfiles/msdos -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
+gf104_scsi growfiles -W gf104 -d /test/growfiles/msdos -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
+gf105_scsi growfiles -W gf105 -d /test/growfiles/msdos -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
+gf106_scsi growfiles -W gf106 -d /test/growfiles/msdos -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand10 g_rand10.2
+gf107_scsi growfiles -W gf107 -d /test/growfiles/msdos -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_rand13 g_rand13.2
+gf108_scsi growfiles -W gf108 -d /test/growfiles/msdos -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand11 g_rand11.2
+gf109_scsi growfiles -W gf109 -d /test/growfiles/msdos -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_rand12 g_rand12.2
+gf110_scsi growfiles -W gf110 -d /test/growfiles/msdos -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2
+gf111_scsi growfiles -W gf111 -d /test/growfiles/msdos -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2
+gf112_scsi mkfifo gffifo17; growfiles -W gf112 -d /test/growfiles/msdos -b -e 1 -u -i 0 -L 30 gffifo17
+gf113_scsi mkfifo gffifo18; growfiles -W gf113 -d /test/growfiles/msdos -b -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18
+gf114_scsi growfiles -W gf114 -d /test/growfiles/msdos -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
+gf115_scsi growfiles -W gf115 -d /test/growfiles/msdos -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
+gf116_scsi growfiles -W gf116 -d /test/growfiles/msdos -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
+gf117_scsi growfiles -W gf117 -d /test/growfiles/msdos -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
+gf118_scsi growfiles -W gf118 -d /test/growfiles/msdos -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
+gf119_scsi growfiles -W gf119 -d /test/growfiles/msdos -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_
+gf120_scsi growfiles -W gf120 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$
+gf121_scsi growfiles -W gf121 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$
+gf122_scsi growfiles -W gf122 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$
+gf123_scsi growfiles -W gf123 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$
+gf124_scsi growfiles -W gf124 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$
+gf125_scsi growfiles -W gf125 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$
+gf126_scsi growfiles -W gf126 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$
+gf127_scsi growfiles -W gf127 -d /test/growfiles/msdos -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$
+gf128_scsi growfiles -W gf128 -d /test/growfiles/msdos -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
+gf129_scsi growfiles -W gf129 -d /test/growfiles/msdos -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$
+gf130_scsi growfiles -W gf130 -d /test/growfiles/msdos -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$
+rwtest101_scsi export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:/test/growfiles/msdos/rwtest01%f
+rwtest102_scsi export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:/test/growfiles/msdos/rwtest02%f
+rwtest103_scsi export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:/test/growfiles/msdos/rwtest03%f
+rwtest104_scsi export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/msdos/rwtest04%f
+rwtest105_scsi export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/msdos/rwtest05%f
-- 
2.17.1

