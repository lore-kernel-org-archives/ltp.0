Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1Ou1Ac-00012N-PD
	for ltp-list@lists.sourceforge.net; Fri, 10 Sep 2010 10:49:26 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ou1AX-0000m2-2H
	for ltp-list@lists.sourceforge.net; Fri, 10 Sep 2010 10:49:26 +0000
Message-ID: <4C8A0FEC.4010108@bull.net>
Date: Fri, 10 Sep 2010 13:01:00 +0200
From: "Jacky.Malcles" <Jacky.Malcles@bull.net>
MIME-Version: 1.0
Subject: [LTP] ltp-aiodio.part3 is the last scenario around aio which is not
 working properly
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

Hi Garet,

I checked, running them, all the scenarios related to aio and there is 
now only ltp-aiodio.part3 that does not work properly;
so, if you agree, I suggest the following patch, this allows us to have 
a set of working testcases while waiting for a cleaner solution,
many thanks,

--- runtest/ltp-aiodio.part3.original    2010-09-10 09:04:17.000000000 +0200
+++ runtest/ltp-aiodio.part3    2010-09-10 11:17:17.000000000 +0200
@@ -1,51 +1,51 @@
 #           fname:  this filename is Required (no default)
 #
 #
-FSX032 fsx-linux -d  -l 500000 -r 4096 -t 4096 -w 4096 -N 10000 
$TMPDIR/aiodio.$$/junkfile
-FSX033 fsx-linux -d  -l 500000 -r 4096 -t 2048 -w 2048 -N 10000 
$TMPDIR/aiodio.$$/junkfile
-FSX034 fsx-linux -d  -l 500000 -r 4096 -N 10000 $TMPDIR/aiodio.$$/junkfile
-FSX035 fsx-linux -d  -N 10000 $TMPDIR/aiodio.$$/junkfile
-FSX036 fsx-linux -d  -N 10000 $TMPDIR/aiodio.$$/junkfile
-FSX037 fsx-linux -d  -N 10000 $TMPDIR/aiodio.$$/junkfile
-FSX038 fsx-linux -d  -N 10000 $TMPDIR/aiodio.$$/junkfile
-FSX039 fsx-linux -d  -N 10000 $TMPDIR/aiodio.$$/junkfile
-FSX040 fsx-linux -N 10000 -o 1024 $TMPDIR/aiodio.$$/junkfile
-FSX041 fsx-linux -N 10000 -o 2048 $TMPDIR/aiodio.$$/junkfile
-FSX042 fsx-linux -N 10000 -o 4096 $TMPDIR/aiodio.$$/junkfile
-FSX043 fsx-linux -N 10000 -o 8192 $TMPDIR/aiodio.$$/junkfile
-FSX044 fsx-linux -N 10000 -o 16384 $TMPDIR/aiodio.$$/junkfile
-FSX045 fsx-linux -N 10000 -o 32768 $TMPDIR/aiodio.$$/junkfile
-FSX046 fsx-linux -N 10000 -o 128000 $TMPDIR/aiodio.$$/junkfile
-FSX047 fsx-linux -N 10000 -o 1024 $TMPDIR/aiodio.$$/junkfile
-FSX048 fsx-linux -N 10000 -o 2048 $TMPDIR/aiodio.$$/junkfile
-FSX049 fsx-linux -N 10000 -o 4096 $TMPDIR/aiodio.$$/junkfile
-FSX050 fsx-linux -N 10000 -o 8192 $TMPDIR/aiodio.$$/junkfile
-FSX051 fsx-linux -N 10000 -o 16384 $TMPDIR/aiodio.$$/junkfile
-FSX052 fsx-linux -N 10000 -o 32768 $TMPDIR/aiodio.$$/junkfile
-FSX053 fsx-linux -N 10000 -o 128000 $TMPDIR/aiodio.$$/junkfile
-FSX054 fsx-linux -N 10000  -o 1024 -l 500000 -r 4096 -t 4096 -w 4096 
$TMPDIR/aiodio.$$/junkfile
-FSX055 fsx-linux -N 10000  -o 2048 -l 500000 -r 4096 -t 2048 -w 2048 
$TMPDIR/aiodio.$$/junkfile
-FSX056 fsx-linux -N 10000  -o 4096 -l 500000 -r 4096 -t 4096 -w 4096 
$TMPDIR/aiodio.$$/junkfile
-FSX057 fsx-linux -N 10000  -o 8192 -l 500000 -r 4096 -t 2048 -w 2048 
$TMPDIR/aiodio.$$/junkfile
-FSX058 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096 
$TMPDIR/aiodio.$$/junkfile
-FSX059 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048 
$TMPDIR/aiodio.$$/junkfile
-FSX060 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
$TMPDIR/aiodio.$$/junkfile
-FSX061 fsx-linux -N 10000 -o 32768 
$TMPDIR/aiodio.$$/junkfile                                         
-FSX062 fsx-linux -N 10000 -o 128000 
$TMPDIR/aiodio.$$/junkfile                                        
-FSX063 fsx-linux -N 10000  -o 1024  -l 500000 -r 4096 -t 4096 -w 4096 
$TMPDIR/aiodio.$$/junkfile  
-FSX064 fsx-linux -N 10000  -o 2048 -l 500000 -r 4096 -t 2048 -w 2048 
$TMPDIR/aiodio.$$/junkfile  
-FSX065 fsx-linux -N 10000  -o 4096 -l 500000 -r 4096 -t 4096 -w 4096 
$TMPDIR/aiodio.$$/junkfile  
-FSX066 fsx-linux -N 10000  -o 8192  -l 500000 -r 4096 -t 2048 -w 2048 
$TMPDIR/aiodio.$$/junkfile   
-FSX067 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096 
$TMPDIR/aiodio.$$/junkfile  
-FSX068 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048 
$TMPDIR/aiodio.$$/junkfile  
-FSX069 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
$TMPDIR/aiodio.$$/junkfile 
-FSX070 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
$TMPDIR/aiodio.$$/junkfile  
-FSX071 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096   
$TMPDIR/aiodio.$$/junkfile1
-FSX072 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048   
$TMPDIR/aiodio.$$/junkfile2
-FSX073 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
$TMPDIR/aiodio.$$/junkfile3
-FSX074 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096   
$TMPDIR/aiodio.$$/junkfile4
-FSX075 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048   
$TMPDIR/aiodio.$$/junkfile5
-FSX076 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
$TMPDIR/aiodio.$$/junkfile6
-FSX077 fsx-linux -N 10000   $TMPDIR/aiodio.$$/junkfile7
-FSX078 fsx-linux -N 100000  $TMPDIR/aiodio.$$/junkfile8
-FSX079 fsx-linux -N 100000  $TMPDIR/aiodio.$$/junkfile9
+FSX032 fsx-linux -d  -l 500000 -r 4096 -t 4096 -w 4096 -N 10000 
/test/aiodio/junkfile
+FSX033 fsx-linux -d  -l 500000 -r 4096 -t 2048 -w 2048 -N 10000 
/test/aiodio/junkfile
+FSX034 fsx-linux -d  -l 500000 -r 4096 -N 10000 /test/aiodio/junkfile
+FSX035 fsx-linux -d  -N 10000 /test/aiodio/junkfile
+FSX036 fsx-linux -d  -N 10000 /test/aiodio/junkfile
+FSX037 fsx-linux -d  -N 10000 /test/aiodio/junkfile
+FSX038 fsx-linux -d  -N 10000 /test/aiodio/junkfile
+FSX039 fsx-linux -d  -N 10000 /test/aiodio/junkfile
+FSX040 fsx-linux -N 10000 -o 1024 /test/aiodio/junkfile
+FSX041 fsx-linux -N 10000 -o 2048 /test/aiodio/junkfile
+FSX042 fsx-linux -N 10000 -o 4096 /test/aiodio/junkfile
+FSX043 fsx-linux -N 10000 -o 8192 /test/aiodio/junkfile
+FSX044 fsx-linux -N 10000 -o 16384 /test/aiodio/junkfile
+FSX045 fsx-linux -N 10000 -o 32768 /test/aiodio/junkfile
+FSX046 fsx-linux -N 10000 -o 128000 /test/aiodio/junkfile
+FSX047 fsx-linux -N 10000 -o 1024 /test/aiodio/junkfile
+FSX048 fsx-linux -N 10000 -o 2048 /test/aiodio/junkfile
+FSX049 fsx-linux -N 10000 -o 4096 /test/aiodio/junkfile
+FSX050 fsx-linux -N 10000 -o 8192 /test/aiodio/junkfile
+FSX051 fsx-linux -N 10000 -o 16384 /test/aiodio/junkfile
+FSX052 fsx-linux -N 10000 -o 32768 /test/aiodio/junkfile
+FSX053 fsx-linux -N 10000 -o 128000 /test/aiodio/junkfile
+FSX054 fsx-linux -N 10000  -o 1024 -l 500000 -r 4096 -t 4096 -w 4096 
/test/aiodio/junkfile
+FSX055 fsx-linux -N 10000  -o 2048 -l 500000 -r 4096 -t 2048 -w 2048 
/test/aiodio/junkfile
+FSX056 fsx-linux -N 10000  -o 4096 -l 500000 -r 4096 -t 4096 -w 4096 
/test/aiodio/junkfile
+FSX057 fsx-linux -N 10000  -o 8192 -l 500000 -r 4096 -t 2048 -w 2048 
/test/aiodio/junkfile
+FSX058 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096 
/test/aiodio/junkfile
+FSX059 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048 
/test/aiodio/junkfile
+FSX060 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
/test/aiodio/junkfile
+FSX061 fsx-linux -N 10000 -o 32768 
/test/aiodio/junkfile                                         
+FSX062 fsx-linux -N 10000 -o 128000 
/test/aiodio/junkfile                                        
+FSX063 fsx-linux -N 10000  -o 1024  -l 500000 -r 4096 -t 4096 -w 4096 
/test/aiodio/junkfile  
+FSX064 fsx-linux -N 10000  -o 2048 -l 500000 -r 4096 -t 2048 -w 2048 
/test/aiodio/junkfile  
+FSX065 fsx-linux -N 10000  -o 4096 -l 500000 -r 4096 -t 4096 -w 4096 
/test/aiodio/junkfile  
+FSX066 fsx-linux -N 10000  -o 8192  -l 500000 -r 4096 -t 2048 -w 2048 
/test/aiodio/junkfile   
+FSX067 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096 
/test/aiodio/junkfile  
+FSX068 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048 
/test/aiodio/junkfile  
+FSX069 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
/test/aiodio/junkfile 
+FSX070 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
/test/aiodio/junkfile  
+FSX071 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096   
/test/aiodio/junkfile1
+FSX072 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048   
/test/aiodio/junkfile2
+FSX073 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
/test/aiodio/junkfile3
+FSX074 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096   
/test/aiodio/junkfile4
+FSX075 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048   
/test/aiodio/junkfile5
+FSX076 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
/test/aiodio/junkfile6
+FSX077 fsx-linux -N 10000   /test/aiodio/junkfile7
+FSX078 fsx-linux -N 100000  /test/aiodio/junkfile8
+FSX079 fsx-linux -N 100000  /test/aiodio/junkfile9

-- 
 Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
 Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
 Tel : 04.76.29.73.14


------------------------------------------------------------------------------
Automate Storage Tiering Simply
Optimize IT performance and efficiency through flexible, powerful, 
automated storage tiering capabilities. View this brief to learn how
you can reduce costs and improve performance. 
http://p.sf.net/sfu/dell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
