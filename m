Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1OvP4t-00072I-6D
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 06:33:15 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OvP4n-0005CK-Lc
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 06:33:15 +0000
Message-ID: <4C8F19DF.6020403@bull.net>
Date: Tue, 14 Sep 2010 08:44:47 +0200
From: "Jacky.Malcles" <Jacky.Malcles@bull.net>
MIME-Version: 1.0
Subject: [LTP] ltp-aiodio.part3 scenario updated
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

Hi Garret,

according to your last ltp-aiodio.sh script from git I have updtated and 
tested this scenario,
it works fine:
tail -f ltpaiodio3.logfile
FSX069                         PASS       0   
FSX057                         PASS       0   

-----------------------------------------------
Total Tests: 48
Total Failures: 0

many thanks,

--- ltp-aiodio.part3.original    2010-09-13 12:45:24.000000000 +0200
+++ ltp-aiodio.part3    2010-09-13 12:47:22.000000000 +0200
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
$TMP/aiodio/junkfile
+FSX033 fsx-linux -d  -l 500000 -r 4096 -t 2048 -w 2048 -N 10000 
$TMP/aiodio/junkfile
+FSX034 fsx-linux -d  -l 500000 -r 4096 -N 10000 $TMP/aiodio/junkfile
+FSX035 fsx-linux -d  -N 10000 $TMP/aiodio/junkfile
+FSX036 fsx-linux -d  -N 10000 $TMP/aiodio/junkfile
+FSX037 fsx-linux -d  -N 10000 $TMP/aiodio/junkfile
+FSX038 fsx-linux -d  -N 10000 $TMP/aiodio/junkfile
+FSX039 fsx-linux -d  -N 10000 $TMP/aiodio/junkfile
+FSX040 fsx-linux -N 10000 -o 1024 $TMP/aiodio/junkfile
+FSX041 fsx-linux -N 10000 -o 2048 $TMP/aiodio/junkfile
+FSX042 fsx-linux -N 10000 -o 4096 $TMP/aiodio/junkfile
+FSX043 fsx-linux -N 10000 -o 8192 $TMP/aiodio/junkfile
+FSX044 fsx-linux -N 10000 -o 16384 $TMP/aiodio/junkfile
+FSX045 fsx-linux -N 10000 -o 32768 $TMP/aiodio/junkfile
+FSX046 fsx-linux -N 10000 -o 128000 $TMP/aiodio/junkfile
+FSX047 fsx-linux -N 10000 -o 1024 $TMP/aiodio/junkfile
+FSX048 fsx-linux -N 10000 -o 2048 $TMP/aiodio/junkfile
+FSX049 fsx-linux -N 10000 -o 4096 $TMP/aiodio/junkfile
+FSX050 fsx-linux -N 10000 -o 8192 $TMP/aiodio/junkfile
+FSX051 fsx-linux -N 10000 -o 16384 $TMP/aiodio/junkfile
+FSX052 fsx-linux -N 10000 -o 32768 $TMP/aiodio/junkfile
+FSX053 fsx-linux -N 10000 -o 128000 $TMP/aiodio/junkfile
+FSX054 fsx-linux -N 10000  -o 1024 -l 500000 -r 4096 -t 4096 -w 4096 
$TMP/aiodio/junkfile
+FSX055 fsx-linux -N 10000  -o 2048 -l 500000 -r 4096 -t 2048 -w 2048 
$TMP/aiodio/junkfile
+FSX056 fsx-linux -N 10000  -o 4096 -l 500000 -r 4096 -t 4096 -w 4096 
$TMP/aiodio/junkfile
+FSX057 fsx-linux -N 10000  -o 8192 -l 500000 -r 4096 -t 2048 -w 2048 
$TMP/aiodio/junkfile
+FSX058 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096 
$TMP/aiodio/junkfile
+FSX059 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048 
$TMP/aiodio/junkfile
+FSX060 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
$TMP/aiodio/junkfile
+FSX061 fsx-linux -N 10000 -o 32768 
$TMP/aiodio/junkfile                                         
+FSX062 fsx-linux -N 10000 -o 128000 
$TMP/aiodio/junkfile                                        
+FSX063 fsx-linux -N 10000  -o 1024  -l 500000 -r 4096 -t 4096 -w 4096 
$TMP/aiodio/junkfile  
+FSX064 fsx-linux -N 10000  -o 2048 -l 500000 -r 4096 -t 2048 -w 2048 
$TMP/aiodio/junkfile  
+FSX065 fsx-linux -N 10000  -o 4096 -l 500000 -r 4096 -t 4096 -w 4096 
$TMP/aiodio/junkfile  
+FSX066 fsx-linux -N 10000  -o 8192  -l 500000 -r 4096 -t 2048 -w 2048 
$TMP/aiodio/junkfile   
+FSX067 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096 
$TMP/aiodio/junkfile  
+FSX068 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048 
$TMP/aiodio/junkfile  
+FSX069 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
$TMP/aiodio/junkfile 
+FSX070 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
$TMP/aiodio/junkfile  
+FSX071 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096   
$TMP/aiodio/junkfile1
+FSX072 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048   
$TMP/aiodio/junkfile2
+FSX073 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
$TMP/aiodio/junkfile3
+FSX074 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096   
$TMP/aiodio/junkfile4
+FSX075 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048   
$TMP/aiodio/junkfile5
+FSX076 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096 
$TMP/aiodio/junkfile6
+FSX077 fsx-linux -N 10000   $TMP/aiodio/junkfile7
+FSX078 fsx-linux -N 100000  $TMP/aiodio/junkfile8
+FSX079 fsx-linux -N 100000  $TMP/aiodio/junkfile9


-- 
 Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
 Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
 Tel : 04.76.29.73.14


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
