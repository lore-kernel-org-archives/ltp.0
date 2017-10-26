From: Lei, Shaoting <leist.fnst@cn.fujitsu.com>
Date: Thu, 26 Oct 2017 02:19:04 +0000
Subject: [LTP] [PATCH] Specify $TMPDIR for rwtest01-04
In-Reply-To: <1508984107-24118-1-git-send-email-leist.fnst@cn.fujitsu.com>
References: <1508984107-24118-1-git-send-email-leist.fnst@cn.fujitsu.com>
Message-ID: <9A231BE5D02F5B4683229C96D4C5BF6601328D6084@G08CNEXMBPEKD01.g08.fujitsu.local>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In the code of runtest/ltplite we should specify $TMPDIR for rwtest01-04 just like runtest/fs.
Otherwise, on some platform the available block is zero.
For example:
   # df -P .
Filesystem      Size  Used Avail Use% Mounted on
rootfs             0     0     0    - /

It result in fail.

Signed-off-by: Shaoting Lei <leist.fnst@cn.fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 runtest/ltplite | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite index 5418495..978204c 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -1111,10 +1111,10 @@ gf27 growfiles -W gf27 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$
 #gf28 growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
 #gf29 growfiles -W gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$
 gf30 growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$
+rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 
+10%25000:$TMPDIR/rw-sync-$$
+rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 
+10%25000:$TMPDIR/rw-buffered-$$
+rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f 
+buffered -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
+rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync 
+-s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
 rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/tmp/rwtest01%f
 
 
--
2.7.4





