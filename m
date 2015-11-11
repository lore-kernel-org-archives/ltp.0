From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Date: Wed, 11 Nov 2015 10:49:01 +0900
Subject: [LTP] [PATCH] runtest/ltp-aio-stress.partX: change /test/aiodio to
 TMPDIR
Message-ID: <56429E8D.6010609@jp.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


ltp-aio-stress.partX fails if /test/aiodio directory is not found.
/test/aiodio should be changed to $TMPDIR just like ltp-aiodio.partX.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 runtest/ltp-aio-stress.part1 |  104 +++++++++++++++++++++---------------------
 runtest/ltp-aio-stress.part2 |   22 ++++----
 2 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/runtest/ltp-aio-stress.part1 b/runtest/ltp-aio-stress.part1
index e6ce367..a770a40 100644
--- a/runtest/ltp-aio-stress.part1
+++ b/runtest/ltp-aio-stress.part1
@@ -2,7 +2,7 @@
 #
 # aio-stress [-s size] [-r size] [-a size] [-d num] [-b num]
 #                 [-i num] [-t num] [-c num] [-C size] [-nxhlvOS ]
-#                 file1 [/test/aiodio/file2 ...]
+#                 file1 [file2 ...]
 #       -a size in KB at which to align buffers
 #       -b max number of iocbs to give io_submit at once
 #       -c number of io contexts per file
@@ -26,54 +26,54 @@
 #       -x turn off thread stonewalling
 #       -h this message
 #
-ADS1000 aio-stress -I500  -o2 -S -r4   /test/aiodio/file1
-ADS1001 aio-stress -I500  -o2 -S -r8   /test/aiodio/file1
-ADS1002 aio-stress -I500  -o2 -S -r16  /test/aiodio/file1
-ADS1003 aio-stress -I500  -o2 -S -r32  -t2  /test/aiodio/junkfile /test/aiodio/file2
-ADS1004 aio-stress -I500  -o2 -S -r64   /test/aiodio/junkfile /test/aiodio/file2
-ADS1005 aio-stress -I500  -o3 -S -r4    /test/aiodio/junkfile /test/aiodio/file2
-ADS1006 aio-stress -I500  -o3 -S -r8   -t2  /test/aiodio/junkfile /test/aiodio/file2
-ADS1007 aio-stress -I500  -o3 -S -r16  -t2  /test/aiodio/junkfile /test/aiodio/file2
-ADS1008 aio-stress -I500  -o3 -S -r32  -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4
-ADS1009 aio-stress -I500  -o3 -S -r64  -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4
-ADS1010 aio-stress -I500  -o3 -S -r128 -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4
-ADS1011 aio-stress -I500  -o3 -S -r256 -t8  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4 /test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  /test/aiodio/file8
-ADS1012 aio-stress -I500  -o3 -S -r512 -t8  /test/aiodio/junkfile /test/aiodio/file2 /test/aiodio/file3  /test/aiodio/file4 /test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  /test/aiodio/file8
-ADS1013 aio-stress -I500  -o2 -O -r4    -t8  /test/aiodio/junkfile /test/aiodio/file2 /test/aiodio/file3  /test/aiodio/file4 /test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  /test/aiodio/file8
-ADS1014 aio-stress -I500  -o2 -O -r8         /test/aiodio/file1 /test/aiodio/file2
-ADS1015 aio-stress -I500  -o2 -O -r16        /test/aiodio/file1 /test/aiodio/file2
-ADS1016 aio-stress -I500  -o2 -O -r32   -t2  /test/aiodio/junkfile /test/aiodio/file2
-ADS1017 aio-stress -I500  -o2 -O -r64   -t2  /test/aiodio/junkfile /test/aiodio/file2
-ADS1018 aio-stress -I500  -o3 -O -r4    -t2  /test/aiodio/junkfile /test/aiodio/file2
-ADS1019 aio-stress -I500  -o3 -O -r8    -t2  /test/aiodio/junkfile /test/aiodio/file2
-ADS1020 aio-stress -I500  -o3 -O -r16   -t2  /test/aiodio/junkfile /test/aiodio/file2
-ADS1021 aio-stress -I500  -o3 -O -r32   -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8
-ADS1022 aio-stress -I500  -o3 -O -r64   -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8
-ADS1023 aio-stress -I500  -o3 -O -r128  -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8
-ADS1024 aio-stress -I500  -o3 -O -r256  -t8  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  /test/aiodio/file6
-ADS1025 aio-stress -I500  -o3 -O -r512  -t8  /test/aiodio/junkfile /test/aiodio/file2 /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
-ADS1026 aio-stress -I500  -o0 -S -r4    -t8  /test/aiodio/junkfile /test/aiodio/file2       /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
-ADS1027 aio-stress -I500  -o0 -S -r8           /test/aiodio/file2
-ADS1028 aio-stress -I500  -o0 -S -r16          /test/aiodio/file2
-ADS1029 aio-stress -I500  -o0 -S -r32   -t2    /test/aiodio/junkfile /test/aiodio/file2
-ADS1030 aio-stress -I500  -o0 -S -r64   -t2    /test/aiodio/junkfile /test/aiodio/file2
-ADS1031 aio-stress -I500  -o1 -S -r4    -t2    /test/aiodio/junkfile /test/aiodio/file2
-ADS1032 aio-stress -I500  -o1 -S -r8    -t2    /test/aiodio/junkfile /test/aiodio/file2
-ADS1033 aio-stress -I500  -o1 -S -r16   -t2    /test/aiodio/junkfile /test/aiodio/file2
-ADS1034 aio-stress -I500  -o1 -S -r32   -t4    /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8
-ADS1035 aio-stress -I500  -o1 -S -r64   -t4    /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8
-ADS1036 aio-stress -I500  -o1 -S -r128  -t4    /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8
-ADS1037 aio-stress -I500  -o1 -S -r256  -t8  /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  /test/aiodio/file6
-ADS1038 aio-stress -I500  -o1 -S -r512  -t8  -x /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
-ADS1039 aio-stress -I500  -o1 -O -r4    -t8  -x  /test/aiodio/junkfile /test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
-ADS1040 aio-stress -I500  -o1 -O -r8    -t2  -x /test/aiodio/junkfile /test/aiodio/file2
-ADS1041 aio-stress -I500  -o1 -O -r16   -t2  -x  /test/aiodio/junkfile /test/aiodio/file2
-ADS1042 aio-stress -I500  -o1 -O -r32   -t2   /test/aiodio/junkfile /test/aiodio/file2
-ADS1043 aio-stress -I500  -o1 -O -r64   -t2   /test/aiodio/junkfile /test/aiodio/file2
-ADS1044 aio-stress -I500  -o1 -O -r4    -t4   /test/aiodio/junkfile /test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8
-ADS1045 aio-stress -I500  -o1 -O -r8    -t4   /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8
-ADS1046 aio-stress -I500  -o1 -O -r16   -t4   /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8
-ADS1047 aio-stress -I500  -o1 -O -r32   -t8   /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  /test/aiodio/file6
-ADS1048 aio-stress -I500  -o1 -O -r64   -t8   /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
-ADS1049 aio-stress -I500  -o1 -O -r128  -t8   /test/aiodio/junkfile /test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
-ADS1050 aio-stress -I500  -o1 -O -r256  -t2   /test/aiodio/junkfile /test/aiodio/file2
+ADS1000 aio-stress -I500  -o2 -S -r4   $TMPDIR/file1
+ADS1001 aio-stress -I500  -o2 -S -r8   $TMPDIR/file1
+ADS1002 aio-stress -I500  -o2 -S -r16  $TMPDIR/file1
+ADS1003 aio-stress -I500  -o2 -S -r32  -t2  $TMPDIR/junkfile $TMPDIR/file2
+ADS1004 aio-stress -I500  -o2 -S -r64   $TMPDIR/junkfile $TMPDIR/file2
+ADS1005 aio-stress -I500  -o3 -S -r4    $TMPDIR/junkfile $TMPDIR/file2
+ADS1006 aio-stress -I500  -o3 -S -r8   -t2  $TMPDIR/junkfile $TMPDIR/file2
+ADS1007 aio-stress -I500  -o3 -S -r16  -t2  $TMPDIR/junkfile $TMPDIR/file2
+ADS1008 aio-stress -I500  -o3 -S -r32  -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file3  $TMPDIR/file4
+ADS1009 aio-stress -I500  -o3 -S -r64  -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file3  $TMPDIR/file4
+ADS1010 aio-stress -I500  -o3 -S -r128 -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file3  $TMPDIR/file4
+ADS1011 aio-stress -I500  -o3 -S -r256 -t8  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file3  $TMPDIR/file4 $TMPDIR/file5  $TMPDIR/file6 $TMPDIR/file7  $TMPDIR/file8
+ADS1012 aio-stress -I500  -o3 -S -r512 -t8  $TMPDIR/junkfile $TMPDIR/file2 $TMPDIR/file3  $TMPDIR/file4 $TMPDIR/file5  $TMPDIR/file6 $TMPDIR/file7  $TMPDIR/file8
+ADS1013 aio-stress -I500  -o2 -O -r4    -t8  $TMPDIR/junkfile $TMPDIR/file2 $TMPDIR/file3  $TMPDIR/file4 $TMPDIR/file5  $TMPDIR/file6 $TMPDIR/file7  $TMPDIR/file8
+ADS1014 aio-stress -I500  -o2 -O -r8         $TMPDIR/file1 $TMPDIR/file2
+ADS1015 aio-stress -I500  -o2 -O -r16        $TMPDIR/file1 $TMPDIR/file2
+ADS1016 aio-stress -I500  -o2 -O -r32   -t2  $TMPDIR/junkfile $TMPDIR/file2
+ADS1017 aio-stress -I500  -o2 -O -r64   -t2  $TMPDIR/junkfile $TMPDIR/file2
+ADS1018 aio-stress -I500  -o3 -O -r4    -t2  $TMPDIR/junkfile $TMPDIR/file2
+ADS1019 aio-stress -I500  -o3 -O -r8    -t2  $TMPDIR/junkfile $TMPDIR/file2
+ADS1020 aio-stress -I500  -o3 -O -r16   -t2  $TMPDIR/junkfile $TMPDIR/file2
+ADS1021 aio-stress -I500  -o3 -O -r32   -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8
+ADS1022 aio-stress -I500  -o3 -O -r64   -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8
+ADS1023 aio-stress -I500  -o3 -O -r128  -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8
+ADS1024 aio-stress -I500  -o3 -O -r256  -t8  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file4  $TMPDIR/file3  $TMPDIR/file5  $TMPDIR/file6
+ADS1025 aio-stress -I500  -o3 -O -r512  -t8  $TMPDIR/junkfile $TMPDIR/file2 $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
+ADS1026 aio-stress -I500  -o0 -S -r4    -t8  $TMPDIR/junkfile $TMPDIR/file2       $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
+ADS1027 aio-stress -I500  -o0 -S -r8           $TMPDIR/file2
+ADS1028 aio-stress -I500  -o0 -S -r16          $TMPDIR/file2
+ADS1029 aio-stress -I500  -o0 -S -r32   -t2    $TMPDIR/junkfile $TMPDIR/file2
+ADS1030 aio-stress -I500  -o0 -S -r64   -t2    $TMPDIR/junkfile $TMPDIR/file2
+ADS1031 aio-stress -I500  -o1 -S -r4    -t2    $TMPDIR/junkfile $TMPDIR/file2
+ADS1032 aio-stress -I500  -o1 -S -r8    -t2    $TMPDIR/junkfile $TMPDIR/file2
+ADS1033 aio-stress -I500  -o1 -S -r16   -t2    $TMPDIR/junkfile $TMPDIR/file2
+ADS1034 aio-stress -I500  -o1 -S -r32   -t4    $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8
+ADS1035 aio-stress -I500  -o1 -S -r64   -t4    $TMPDIR/junkfile $TMPDIR/file2     $TMPDIR/file7  $TMPDIR/file8
+ADS1036 aio-stress -I500  -o1 -S -r128  -t4    $TMPDIR/junkfile $TMPDIR/file2     $TMPDIR/file7  $TMPDIR/file8
+ADS1037 aio-stress -I500  -o1 -S -r256  -t8  $TMPDIR/junkfile $TMPDIR/file2     $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file4  $TMPDIR/file3  $TMPDIR/file5  $TMPDIR/file6
+ADS1038 aio-stress -I500  -o1 -S -r512  -t8  -x $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
+ADS1039 aio-stress -I500  -o1 -O -r4    -t8  -x  $TMPDIR/junkfile $TMPDIR/file2        $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
+ADS1040 aio-stress -I500  -o1 -O -r8    -t2  -x $TMPDIR/junkfile $TMPDIR/file2
+ADS1041 aio-stress -I500  -o1 -O -r16   -t2  -x  $TMPDIR/junkfile $TMPDIR/file2
+ADS1042 aio-stress -I500  -o1 -O -r32   -t2   $TMPDIR/junkfile $TMPDIR/file2
+ADS1043 aio-stress -I500  -o1 -O -r64   -t2   $TMPDIR/junkfile $TMPDIR/file2
+ADS1044 aio-stress -I500  -o1 -O -r4    -t4   $TMPDIR/junkfile $TMPDIR/file2        $TMPDIR/file7  $TMPDIR/file8
+ADS1045 aio-stress -I500  -o1 -O -r8    -t4   $TMPDIR/junkfile $TMPDIR/file2     $TMPDIR/file7  $TMPDIR/file8
+ADS1046 aio-stress -I500  -o1 -O -r16   -t4   $TMPDIR/junkfile $TMPDIR/file2     $TMPDIR/file7  $TMPDIR/file8
+ADS1047 aio-stress -I500  -o1 -O -r32   -t8   $TMPDIR/junkfile $TMPDIR/file2     $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file4  $TMPDIR/file3  $TMPDIR/file5  $TMPDIR/file6
+ADS1048 aio-stress -I500  -o1 -O -r64   -t8   $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
+ADS1049 aio-stress -I500  -o1 -O -r128  -t8   $TMPDIR/junkfile $TMPDIR/file2        $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
+ADS1050 aio-stress -I500  -o1 -O -r256  -t2   $TMPDIR/junkfile $TMPDIR/file2
diff --git a/runtest/ltp-aio-stress.part2 b/runtest/ltp-aio-stress.part2
index 92b501c..d72f538 100644
--- a/runtest/ltp-aio-stress.part2
+++ b/runtest/ltp-aio-stress.part2
@@ -2,7 +2,7 @@
 #
 # aio-stress [-s size] [-r size] [-a size] [-d num] [-b num]
 #                 [-i num] [-t num] [-c num] [-C size] [-nxhlvOS ]
-#                 file1 [/test/aiodio/file2 ...]
+#                 file1 [file2 ...]
 #       -a size in KB at which to align buffers
 #       -b max number of iocbs to give io_submit at once
 #       -c number of io contexts per file
@@ -26,13 +26,13 @@
 #       -x turn off thread stonewalling
 #       -h this message
 #
-ADS2001 aio-stress -I500  -o2 -S -r32  -t2  /test/aiodio/junkfile /test/aiodio2/file2
-ADS2002 aio-stress -I500  -o3 -S -r8   -t2  /test/aiodio/junkfile /test/aiodio2/file2
-ADS2003 aio-stress -I500  -o3 -S -r16  -t2  /test/aiodio/junkfile /test/aiodio2/file2
-ADS2004 aio-stress -I500  -o3 -S -r32  -t4  /test/aiodio/junkfile /test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
-ADS2005 aio-stress -I500  -o3 -S -r64  -t4  /test/aiodio/junkfile /test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
-ADS2006 aio-stress -I500  -o2 -O -r32  -t2  /test/aiodio/junkfile /test/aiodio2/file2
-ADS2007 aio-stress -I500  -o3 -O -r8   -t2  /test/aiodio/junkfile /test/aiodio2/file2
-ADS2008 aio-stress -I500  -o3 -O -r16  -t2  /test/aiodio/junkfile /test/aiodio2/file2
-ADS2009 aio-stress -I500  -o3 -O -r32  -t4  /test/aiodio/junkfile /test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
-ADS2010 aio-stress -I500  -o3 -O -r64  -t4  /test/aiodio/junkfile /test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
+ADS2001 aio-stress -I500  -o2 -S -r32  -t2  $TMPDIR/junkfile $TMPDIR2/file2
+ADS2002 aio-stress -I500  -o3 -S -r8   -t2  $TMPDIR/junkfile $TMPDIR2/file2
+ADS2003 aio-stress -I500  -o3 -S -r16  -t2  $TMPDIR/junkfile $TMPDIR2/file2
+ADS2004 aio-stress -I500  -o3 -S -r32  -t4  $TMPDIR/junkfile $TMPDIR2/file2 $TMPDIR/file3 $TMPDIR2/file4
+ADS2005 aio-stress -I500  -o3 -S -r64  -t4  $TMPDIR/junkfile $TMPDIR2/file2 $TMPDIR/file3 $TMPDIR2/file4
+ADS2006 aio-stress -I500  -o2 -O -r32  -t2  $TMPDIR/junkfile $TMPDIR2/file2
+ADS2007 aio-stress -I500  -o3 -O -r8   -t2  $TMPDIR/junkfile $TMPDIR2/file2
+ADS2008 aio-stress -I500  -o3 -O -r16  -t2  $TMPDIR/junkfile $TMPDIR2/file2
+ADS2009 aio-stress -I500  -o3 -O -r32  -t4  $TMPDIR/junkfile $TMPDIR2/file2 $TMPDIR/file3 $TMPDIR2/file4
+ADS2010 aio-stress -I500  -o3 -O -r64  -t4  $TMPDIR/junkfile $TMPDIR2/file2 $TMPDIR/file3 $TMPDIR2/file4
-- 
1.7.1
