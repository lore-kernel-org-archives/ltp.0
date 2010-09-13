Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1Ov8M6-0004tt-5X
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 12:41:54 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ov8Lw-0006Fy-BJ
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 12:41:54 +0000
Message-ID: <4C8E1EC2.1060803@bull.net>
Date: Mon, 13 Sep 2010 14:53:22 +0200
From: "Jacky.Malcles" <Jacky.Malcles@bull.net>
MIME-Version: 1.0
Subject: [LTP] ltp-aio-stress.part2 modified (and tested)
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
 changed and tested according to your entries:

--- ltp-aio-stress.part2.original    2010-09-13 11:12:54.000000000 +0200
+++ ltp-aio-stress.part2    2010-09-13 11:14:07.000000000 +0200
@@ -2,7 +2,7 @@
 #
 # aio-stress [-s size] [-r size] [-a size] [-d num] [-b num]
 #                 [-i num] [-t num] [-c num] [-C size] [-nxhlvOS ]
-#                 file1 [/test/aiodio/file2 ...]
+#                 file1 [$TMP/aiodio/file2 ...]
 #       -a size in KB at which to align buffers
 #       -b max number of iocbs to give io_submit at once
 #       -c number of io contexts per file
@@ -26,13 +26,13 @@
 #       -x turn off thread stonewalling
 #       -h this message
 #
-ADS2001 aio-stress -I500  -o2 -S -r32  -t2  /test/aiodio/junkfile 
/test/aiodio2/file2
-ADS2002 aio-stress -I500  -o3 -S -r8   -t2  /test/aiodio/junkfile 
/test/aiodio2/file2
-ADS2003 aio-stress -I500  -o3 -S -r16  -t2  /test/aiodio/junkfile 
/test/aiodio2/file2
-ADS2004 aio-stress -I500  -o3 -S -r32  -t4  /test/aiodio/junkfile 
/test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
-ADS2005 aio-stress -I500  -o3 -S -r64  -t4  /test/aiodio/junkfile 
/test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
-ADS2006 aio-stress -I500  -o2 -O -r32  -t2  /test/aiodio/junkfile 
/test/aiodio2/file2
-ADS2007 aio-stress -I500  -o3 -O -r8   -t2  /test/aiodio/junkfile 
/test/aiodio2/file2
-ADS2008 aio-stress -I500  -o3 -O -r16  -t2  /test/aiodio/junkfile 
/test/aiodio2/file2
-ADS2009 aio-stress -I500  -o3 -O -r32  -t4  /test/aiodio/junkfile 
/test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
-ADS2010 aio-stress -I500  -o3 -O -r64  -t4  /test/aiodio/junkfile 
/test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
+ADS2001 aio-stress -I500  -o2 -S -r32  -t2  $TMP/aiodio/junkfile 
$TMP/aiodio2/file2
+ADS2002 aio-stress -I500  -o3 -S -r8   -t2  $TMP/aiodio/junkfile 
$TMP/aiodio2/file2
+ADS2003 aio-stress -I500  -o3 -S -r16  -t2  $TMP/aiodio/junkfile 
$TMP/aiodio2/file2
+ADS2004 aio-stress -I500  -o3 -S -r32  -t4  $TMP/aiodio/junkfile 
$TMP/aiodio2/file2 $TMP/aiodio/file3 $TMP/aiodio2/file4
+ADS2005 aio-stress -I500  -o3 -S -r64  -t4  $TMP/aiodio/junkfile 
$TMP/aiodio2/file2 $TMP/aiodio/file3 $TMP/aiodio2/file4
+ADS2006 aio-stress -I500  -o2 -O -r32  -t2  $TMP/aiodio/junkfile 
$TMP/aiodio2/file2
+ADS2007 aio-stress -I500  -o3 -O -r8   -t2  $TMP/aiodio/junkfile 
$TMP/aiodio2/file2
+ADS2008 aio-stress -I500  -o3 -O -r16  -t2  $TMP/aiodio/junkfile 
$TMP/aiodio2/file2
+ADS2009 aio-stress -I500  -o3 -O -r32  -t4  $TMP/aiodio/junkfile 
$TMP/aiodio2/file2 $TMP/aiodio/file3 $TMP/aiodio2/file4
+ADS2010 aio-stress -I500  -o3 -O -r64  -t4  $TMP/aiodio/junkfile 
$TMP/aiodio2/file2 $TMP/aiodio/file3 $TMP/aiodio2/file4


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
