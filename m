Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1Ov5Pp-00038U-2S
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 09:33:33 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ov5Pk-0001Ac-4g
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 09:33:32 +0000
Message-ID: <4C8DF2A2.2070301@bull.net>
Date: Mon, 13 Sep 2010 11:45:06 +0200
From: "Jacky.Malcles" <Jacky.Malcles@bull.net>
MIME-Version: 1.0
Subject: [LTP] ltp-aio-stress.part1 updating
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Garret,

according to your new scripts, locations ...$TMP ...
if you agree I suggest the following new version, I can test and prepare 
all the scenarios,
let me know,
thanks

--- ltp-aio-stress.part1.original    2010-09-13 10:55:54.000000000 +0200
+++ ltp-aio-stress.part1    2010-09-13 11:04:42.000000000 +0200
@@ -2,7 +2,7 @@
 #
 # aio-stress [-s size] [-r size] [-a size] [-d num] [-b num]
 #                 [-i num] [-t num] [-c num] [-C size] [-nxhlvOS ]
-#                 file1 [/test/aiodio/file2 ...]
+#                 file1 [$TMP/aiodio/file2 ...]
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
-ADS1003 aio-stress -I500  -o2 -S -r32  -t2  /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1004 aio-stress -I500  -o2 -S -r64   /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1005 aio-stress -I500  -o3 -S -r4    /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1006 aio-stress -I500  -o3 -S -r8   -t2  /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1007 aio-stress -I500  -o3 -S -r16  -t2  /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1008 aio-stress -I500  -o3 -S -r32  -t4  /test/aiodio/junkfile 
/test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4
-ADS1009 aio-stress -I500  -o3 -S -r64  -t4  /test/aiodio/junkfile 
/test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4
-ADS1010 aio-stress -I500  -o3 -S -r128 -t4  /test/aiodio/junkfile 
/test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4
-ADS1011 aio-stress -I500  -o3 -S -r256 -t8  /test/aiodio/junkfile 
/test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4 
/test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  
/test/aiodio/file8
-ADS1012 aio-stress -I500  -o3 -S -r512 -t8  /test/aiodio/junkfile 
/test/aiodio/file2 /test/aiodio/file3  /test/aiodio/file4 
/test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  
/test/aiodio/file8
-ADS1013 aio-stress -I500  -o2 -O -r4    -t8  /test/aiodio/junkfile 
/test/aiodio/file2 /test/aiodio/file3  /test/aiodio/file4 
/test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  
/test/aiodio/file8
-ADS1014 aio-stress -I500  -o2 -O -r8         /test/aiodio/file1 
/test/aiodio/file2
-ADS1015 aio-stress -I500  -o2 -O -r16        /test/aiodio/file1 
/test/aiodio/file2
-ADS1016 aio-stress -I500  -o2 -O -r32   -t2  /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1017 aio-stress -I500  -o2 -O -r64   -t2  /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1018 aio-stress -I500  -o3 -O -r4    -t2  /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1019 aio-stress -I500  -o3 -O -r8    -t2  /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1020 aio-stress -I500  -o3 -O -r16   -t2  /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1021 aio-stress -I500  -o3 -O -r32   -t4  /test/aiodio/junkfile 
/test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8
-ADS1022 aio-stress -I500  -o3 -O -r64   -t4  /test/aiodio/junkfile 
/test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8
-ADS1023 aio-stress -I500  -o3 -O -r128  -t4  /test/aiodio/junkfile 
/test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8
-ADS1024 aio-stress -I500  -o3 -O -r256  -t8  /test/aiodio/junkfile 
/test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8 
/test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  
/test/aiodio/file6
-ADS1025 aio-stress -I500  -o3 -O -r512  -t8  /test/aiodio/junkfile 
/test/aiodio/file2 /test/aiodio/file7  /test/aiodio/file8 
/test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  
/test/aiodio/file6
-ADS1026 aio-stress -I500  -o0 -S -r4    -t8  /test/aiodio/junkfile 
/test/aiodio/file2       /test/aiodio/file7  /test/aiodio/file8 
/test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  
/test/aiodio/file6
-ADS1027 aio-stress -I500  -o0 -S -r8           /test/aiodio/file2
-ADS1028 aio-stress -I500  -o0 -S -r16          /test/aiodio/file2
-ADS1029 aio-stress -I500  -o0 -S -r32   -t2    /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1030 aio-stress -I500  -o0 -S -r64   -t2    /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1031 aio-stress -I500  -o1 -S -r4    -t2    /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1032 aio-stress -I500  -o1 -S -r8    -t2    /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1033 aio-stress -I500  -o1 -S -r16   -t2    /test/aiodio/junkfile 
/test/aiodio/file2
-ADS1034 aio-stress -I500  -o1 -S -r32   -t4    /test/aiodio/junkfile 
/test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8
-ADS1035 aio-stress -I500  -o1 -S -r64   -t4    /test/aiodio/junkfile 
/test/aiodio/file2     /test/aiodio/file7  
/test/aiodio/file8                                                                               

-ADS1036 aio-stress -I500  -o1 -S -r128  -t4    /test/aiodio/junkfile 
/test/aiodio/file2     /test/aiodio/file7  
/test/aiodio/file8                                                                               

-ADS1037 aio-stress -I500  -o1 -S -r256  -t8  /test/aiodio/junkfile 
/test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8 
/test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  
/test/aiodio/file6
-ADS1038 aio-stress -I500  -o1 -S -r512  -t8  -x /test/aiodio/junkfile 
/test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8 
/test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  
/test/aiodio/file6
-ADS1039 aio-stress -I500  -o1 -O -r4    -t8  -x  /test/aiodio/junkfile 
/test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8 
/test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  
/test/aiodio/file6
-ADS1040 aio-stress -I500  -o1 -O -r8    -t2  -x /test/aiodio/junkfile 
/test/aiodio/file2        
-ADS1041 aio-stress -I500  -o1 -O -r16   -t2  -x  /test/aiodio/junkfile 
/test/aiodio/file2        
-ADS1042 aio-stress -I500  -o1 -O -r32   -t2   /test/aiodio/junkfile 
/test/aiodio/file2     
-ADS1043 aio-stress -I500  -o1 -O -r64   -t2   /test/aiodio/junkfile 
/test/aiodio/file2     
-ADS1044 aio-stress -I500  -o1 -O -r4    -t4   /test/aiodio/junkfile 
/test/aiodio/file2        /test/aiodio/file7  
/test/aiodio/file8                                                                               

-ADS1045 aio-stress -I500  -o1 -O -r8    -t4   /test/aiodio/junkfile 
/test/aiodio/file2     /test/aiodio/file7  
/test/aiodio/file8                                                                               

-ADS1046 aio-stress -I500  -o1 -O -r16   -t4   /test/aiodio/junkfile 
/test/aiodio/file2     /test/aiodio/file7  
/test/aiodio/file8                                                                               

-ADS1047 aio-stress -I500  -o1 -O -r32   -t8   /test/aiodio/junkfile 
/test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8 
/test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  
/test/aiodio/file6
-ADS1048 aio-stress -I500  -o1 -O -r64   -t8   /test/aiodio/junkfile 
/test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8 
/test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  
/test/aiodio/file6
-ADS1049 aio-stress -I500  -o1 -O -r128  -t8   /test/aiodio/junkfile 
/test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8 
/test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  
/test/aiodio/file6
-ADS1050 aio-stress -I500  -o1 -O -r256  -t2   /test/aiodio/junkfile 
/test/aiodio/file2
+ADS1000 aio-stress -I500  -o2 -S -r4   $TMP/aiodio/file1
+ADS1001 aio-stress -I500  -o2 -S -r8   $TMP/aiodio/file1
+ADS1002 aio-stress -I500  -o2 -S -r16  $TMP/aiodio/file1
+ADS1003 aio-stress -I500  -o2 -S -r32  -t2  $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1004 aio-stress -I500  -o2 -S -r64   $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1005 aio-stress -I500  -o3 -S -r4    $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1006 aio-stress -I500  -o3 -S -r8   -t2  $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1007 aio-stress -I500  -o3 -S -r16  -t2  $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1008 aio-stress -I500  -o3 -S -r32  -t4  $TMP/aiodio/junkfile 
$TMP/aiodio/file2  $TMP/aiodio/file3  $TMP/aiodio/file4
+ADS1009 aio-stress -I500  -o3 -S -r64  -t4  $TMP/aiodio/junkfile 
$TMP/aiodio/file2  $TMP/aiodio/file3  $TMP/aiodio/file4
+ADS1010 aio-stress -I500  -o3 -S -r128 -t4  $TMP/aiodio/junkfile 
$TMP/aiodio/file2  $TMP/aiodio/file3  $TMP/aiodio/file4
+ADS1011 aio-stress -I500  -o3 -S -r256 -t8  $TMP/aiodio/junkfile 
$TMP/aiodio/file2  $TMP/aiodio/file3  $TMP/aiodio/file4 
$TMP/aiodio/file5  $TMP/aiodio/file6 $TMP/aiodio/file7  $TMP/aiodio/file8
+ADS1012 aio-stress -I500  -o3 -S -r512 -t8  $TMP/aiodio/junkfile 
$TMP/aiodio/file2 $TMP/aiodio/file3  $TMP/aiodio/file4 
$TMP/aiodio/file5  $TMP/aiodio/file6 $TMP/aiodio/file7  $TMP/aiodio/file8
+ADS1013 aio-stress -I500  -o2 -O -r4    -t8  $TMP/aiodio/junkfile 
$TMP/aiodio/file2 $TMP/aiodio/file3  $TMP/aiodio/file4 
$TMP/aiodio/file5  $TMP/aiodio/file6 $TMP/aiodio/file7  $TMP/aiodio/file8
+ADS1014 aio-stress -I500  -o2 -O -r8         $TMP/aiodio/file1 
$TMP/aiodio/file2
+ADS1015 aio-stress -I500  -o2 -O -r16        $TMP/aiodio/file1 
$TMP/aiodio/file2
+ADS1016 aio-stress -I500  -o2 -O -r32   -t2  $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1017 aio-stress -I500  -o2 -O -r64   -t2  $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1018 aio-stress -I500  -o3 -O -r4    -t2  $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1019 aio-stress -I500  -o3 -O -r8    -t2  $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1020 aio-stress -I500  -o3 -O -r16   -t2  $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1021 aio-stress -I500  -o3 -O -r32   -t4  $TMP/aiodio/junkfile 
$TMP/aiodio/file2  $TMP/aiodio/file7  $TMP/aiodio/file8
+ADS1022 aio-stress -I500  -o3 -O -r64   -t4  $TMP/aiodio/junkfile 
$TMP/aiodio/file2  $TMP/aiodio/file7  $TMP/aiodio/file8
+ADS1023 aio-stress -I500  -o3 -O -r128  -t4  $TMP/aiodio/junkfile 
$TMP/aiodio/file2  $TMP/aiodio/file7  $TMP/aiodio/file8
+ADS1024 aio-stress -I500  -o3 -O -r256  -t8  $TMP/aiodio/junkfile 
$TMP/aiodio/file2  $TMP/aiodio/file7  $TMP/aiodio/file8 
$TMP/aiodio/file4  $TMP/aiodio/file3  $TMP/aiodio/file5  $TMP/aiodio/file6
+ADS1025 aio-stress -I500  -o3 -O -r512  -t8  $TMP/aiodio/junkfile 
$TMP/aiodio/file2 $TMP/aiodio/file7  $TMP/aiodio/file8 
$TMP/aiodio/file3  $TMP/aiodio/file4  $TMP/aiodio/file5  $TMP/aiodio/file6
+ADS1026 aio-stress -I500  -o0 -S -r4    -t8  $TMP/aiodio/junkfile 
$TMP/aiodio/file2       $TMP/aiodio/file7  $TMP/aiodio/file8 
$TMP/aiodio/file3  $TMP/aiodio/file4  $TMP/aiodio/file5  $TMP/aiodio/file6
+ADS1027 aio-stress -I500  -o0 -S -r8           $TMP/aiodio/file2
+ADS1028 aio-stress -I500  -o0 -S -r16          $TMP/aiodio/file2
+ADS1029 aio-stress -I500  -o0 -S -r32   -t2    $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1030 aio-stress -I500  -o0 -S -r64   -t2    $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1031 aio-stress -I500  -o1 -S -r4    -t2    $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1032 aio-stress -I500  -o1 -S -r8    -t2    $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1033 aio-stress -I500  -o1 -S -r16   -t2    $TMP/aiodio/junkfile 
$TMP/aiodio/file2
+ADS1034 aio-stress -I500  -o1 -S -r32   -t4    $TMP/aiodio/junkfile 
$TMP/aiodio/file2  $TMP/aiodio/file7  $TMP/aiodio/file8
+ADS1035 aio-stress -I500  -o1 -S -r64   -t4    $TMP/aiodio/junkfile 
$TMP/aiodio/file2     $TMP/aiodio/file7  
$TMP/aiodio/file8                                                                               

+ADS1036 aio-stress -I500  -o1 -S -r128  -t4    $TMP/aiodio/junkfile 
$TMP/aiodio/file2     $TMP/aiodio/file7  
$TMP/aiodio/file8                                                                               

+ADS1037 aio-stress -I500  -o1 -S -r256  -t8  $TMP/aiodio/junkfile 
$TMP/aiodio/file2     $TMP/aiodio/file7  $TMP/aiodio/file8 
$TMP/aiodio/file4  $TMP/aiodio/file3  $TMP/aiodio/file5  $TMP/aiodio/file6
+ADS1038 aio-stress -I500  -o1 -S -r512  -t8  -x $TMP/aiodio/junkfile 
$TMP/aiodio/file2  $TMP/aiodio/file7  $TMP/aiodio/file8 
$TMP/aiodio/file3  $TMP/aiodio/file4  $TMP/aiodio/file5  $TMP/aiodio/file6
+ADS1039 aio-stress -I500  -o1 -O -r4    -t8  -x  $TMP/aiodio/junkfile 
$TMP/aiodio/file2        $TMP/aiodio/file7  $TMP/aiodio/file8 
$TMP/aiodio/file3  $TMP/aiodio/file4  $TMP/aiodio/file5  $TMP/aiodio/file6
+ADS1040 aio-stress -I500  -o1 -O -r8    -t2  -x $TMP/aiodio/junkfile 
$TMP/aiodio/file2        
+ADS1041 aio-stress -I500  -o1 -O -r16   -t2  -x  $TMP/aiodio/junkfile 
$TMP/aiodio/file2        
+ADS1042 aio-stress -I500  -o1 -O -r32   -t2   $TMP/aiodio/junkfile 
$TMP/aiodio/file2     
+ADS1043 aio-stress -I500  -o1 -O -r64   -t2   $TMP/aiodio/junkfile 
$TMP/aiodio/file2     
+ADS1044 aio-stress -I500  -o1 -O -r4    -t4   $TMP/aiodio/junkfile 
$TMP/aiodio/file2        $TMP/aiodio/file7  
$TMP/aiodio/file8                                                                               

+ADS1045 aio-stress -I500  -o1 -O -r8    -t4   $TMP/aiodio/junkfile 
$TMP/aiodio/file2     $TMP/aiodio/file7  
$TMP/aiodio/file8                                                                               

+ADS1046 aio-stress -I500  -o1 -O -r16   -t4   $TMP/aiodio/junkfile 
$TMP/aiodio/file2     $TMP/aiodio/file7  
$TMP/aiodio/file8                                                                               

+ADS1047 aio-stress -I500  -o1 -O -r32   -t8   $TMP/aiodio/junkfile 
$TMP/aiodio/file2     $TMP/aiodio/file7  $TMP/aiodio/file8 
$TMP/aiodio/file4  $TMP/aiodio/file3  $TMP/aiodio/file5  $TMP/aiodio/file6
+ADS1048 aio-stress -I500  -o1 -O -r64   -t8   $TMP/aiodio/junkfile 
$TMP/aiodio/file2  $TMP/aiodio/file7  $TMP/aiodio/file8 
$TMP/aiodio/file3  $TMP/aiodio/file4  $TMP/aiodio/file5  $TMP/aiodio/file6
+ADS1049 aio-stress -I500  -o1 -O -r128  -t8   $TMP/aiodio/junkfile 
$TMP/aiodio/file2        $TMP/aiodio/file7  $TMP/aiodio/file8 
$TMP/aiodio/file3  $TMP/aiodio/file4  $TMP/aiodio/file5  $TMP/aiodio/file6
+ADS1050 aio-stress -I500  -o1 -O -r256  -t2   $TMP/aiodio/junkfile 
$TMP/aiodio/file2


-- 
 Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
 Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
 Tel : 04.76.29.73.14


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
