Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1Ov8pF-0006uC-Tz
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 13:12:01 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ov8p6-0003QR-MB
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 13:12:01 +0000
Message-ID: <4C8E25D2.10100@bull.net>
Date: Mon, 13 Sep 2010 15:23:30 +0200
From: "Jacky.Malcles" <Jacky.Malcles@bull.net>
MIME-Version: 1.0
Subject: [LTP] ltp-aiodio.part1 updated
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

ltp-aiodio.part1 updated and tested:
# tail -f ltpaiodio1.logfile
AD137                          PASS       0   
AD007                          PASS       0   

-----------------------------------------------
Total Tests: 214
Total Failures: 0
.............................


--- ltp-aiodio.part1.original    2010-09-13 12:40:12.000000000 +0200
+++ ltp-aiodio.part1    2010-09-13 10:39:54.000000000 +0200
@@ -1,216 +1,216 @@
 #DESCRIPTION:ltp A-sync IO and Direct IO tests
 #
-AD001 time aiocp -b 1k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD002 time aiocp -b 1k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD003 time aiocp -b 1k -n 1 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD004 time aiocp -b 1k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD005 time aiocp -b 1k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD006 time aiocp -b 1k -n 2 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD007 time aiocp -b 1k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD008 time aiocp -b 1k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD009 time aiocp -b 1k -n 4 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD010 time aiocp -b 1k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD012 time aiocp -b 1k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD013 time aiocp -b 1k -n 8 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD014 time aiocp -b 1k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD015 time aiocp -b 1k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD016 time aiocp -b 1k -n 16 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD017 time aiocp -b 1k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD018 time aiocp -b 1k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD019 time aiocp -b 1k -n 32 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD020 time aiocp -b 1k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD021 time aiocp -b 1k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD022 time aiocp -b 1k -n 64 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD023 time aiocp -b 2k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD024 time aiocp -b 2k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD025 time aiocp -b 2k -n 1 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD026 time aiocp -b 2k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD027 time aiocp -b 2k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD028 time aiocp -b 2k -n 2 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD029 time aiocp -b 2k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD030 time aiocp -b 2k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD031 time aiocp -b 2k -n 4 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD032 time aiocp -b 2k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD033 time aiocp -b 2k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD034 time aiocp -b 2k -n 8 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD035 time aiocp -b 2k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD036 time aiocp -b 2k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD037 time aiocp -b 2k -n 16 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD038 time aiocp -b 2k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD039 time aiocp -b 2k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD040 time aiocp -b 2k -n 32 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD041 time aiocp -b 2k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD042 time aiocp -b 2k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD043 time aiocp -b 2k -n 64 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD044 time aiocp -b 4k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD045 time aiocp -b 4k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD046 time aiocp -b 4k -n 1 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD047 time aiocp -b 4k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD048 time aiocp -b 4k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD049 time aiocp -b 4k -n 2 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD050 time aiocp -b 4k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD051 time aiocp -b 4k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD052 time aiocp -b 4k -n 4 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD053 time aiocp -b 4k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD054 time aiocp -b 4k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD055 time aiocp -b 4k -n 8 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD056 time aiocp -b 4k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD057 time aiocp -b 4k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD058 time aiocp -b 4k -n 16 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD059 time aiocp -b 4k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD060 time aiocp -b 4k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD061 time aiocp -b 4k -n 32 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD062 time aiocp -b 4k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD063 time aiocp -b 4k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD064 time aiocp -b 41k -n 64 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD065 time aiocp -b 8k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD066 time aiocp -b 8k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD067 time aiocp -b 8k -n 1 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD068 time aiocp -b 8k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD069 time aiocp -b 8k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD070 time aiocp -b 8k -n 2 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD071 time aiocp -b 8k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD072 time aiocp -b 8k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD073 time aiocp -b 8k -n 4 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD074 time aiocp -b 8k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD075 time aiocp -b 8k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD076 time aiocp -b 8k -n 8 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD077 time aiocp -b 8k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD078 time aiocp -b 8k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD079 time aiocp -b 8k -n 16 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD080 time aiocp -b 8k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD081 time aiocp -b 8k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD082 time aiocp -b 8k -n 32 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD083 time aiocp -b 8k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD084 time aiocp -b 8k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD085 time aiocp -b 8k -n 64 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD086 time aiocp -b 16k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD087 time aiocp -b 16k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD088 time aiocp -b 16k -n 1 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD089 time aiocp -b 16k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD090 time aiocp -b 16k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD091 time aiocp -b 16k -n 2 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD092 time aiocp -b 16k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD093 time aiocp -b 16k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD094 time aiocp -b 16k -n 4 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD095 time aiocp -b 16k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD096 time aiocp -b 16k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD097 time aiocp -b 16k -n 8 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD098 time aiocp -b 16k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD099 time aiocp -b 16k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD101 time aiocp -b 16k -n 16 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD102 time aiocp -b 16k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD103 time aiocp -b 16k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD104 time aiocp -b 16k -n 32 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD105 time aiocp -b 16k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD106 time aiocp -b 16k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD107 time aiocp -b 16k -n 64 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD108 time aiocp -b 32k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD109 time aiocp -b 32k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD110 time aiocp -b 32k -n 1 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD112 time aiocp -b 32k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD113 time aiocp -b 32k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD114 time aiocp -b 32k -n 2 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD115 time aiocp -b 32k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD116 time aiocp -b 32k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD117 time aiocp -b 32k -n 4 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD118 time aiocp -b 32k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD119 time aiocp -b 32k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD120 time aiocp -b 32k -n 8 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD121 time aiocp -b 32k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD122 time aiocp -b 32k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD123 time aiocp -b 32k -n 16 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD124 time aiocp -b 32k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD125 time aiocp -b 32k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD126 time aiocp -b 32k -n 32 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD127 time aiocp -b 32k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD128 time aiocp -b 32k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD129 time aiocp -b 32k -n 64 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD130 time aiocp -b 64k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD131 time aiocp -b 64k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD132 time aiocp -b 64k -n 1 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD133 time aiocp -b 64k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD134 time aiocp -b 64k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD135 time aiocp -b 64k -n 2 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD136 time aiocp -b 64k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD137 time aiocp -b 64k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD138 time aiocp -b 64k -n 4 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD139 time aiocp -b 64k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD140 time aiocp -b 64k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD141 time aiocp -b 64k -n 8 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD142 time aiocp -b 64k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD143 time aiocp -b 64k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD144 time aiocp -b 64k -n 16 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD145 time aiocp -b 64k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD146 time aiocp -b 64k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD147 time aiocp -b 64k -n 32 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD148 time aiocp -b 64k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD149 time aiocp -b 64k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD150 time aiocp -b 64k -n 64 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD151 time aiocp -b 128k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD152 time aiocp -b 128k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD153 time aiocp -b 128k -n 1 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD154 time aiocp -b 128k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD155 time aiocp -b 128k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD156 time aiocp -b 128k -n 2 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD157 time aiocp -b 128k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD158 time aiocp -b 128k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD159 time aiocp -b 128k -n 4 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD160 time aiocp -b 128k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD161 time aiocp -b 128k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD162 time aiocp -b 12k -n 8 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD163 time aiocp -b 128k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD164 time aiocp -b 128k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD165 time aiocp -b 128k -n 16 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD166 time aiocp -b 128k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD167 time aiocp -b 128k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD168 time aiocp -b 128k -n 32 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD169 time aiocp -b 128k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD170 time aiocp -b 128k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD171 time aiocp -b 128k -n 64 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD172 time aiocp -b 256k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD173 time aiocp -b 256k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD174 time aiocp -b 256k -n 1 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD175 time aiocp -b 256k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD176 time aiocp -b 256k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD177 time aiocp -b 256k -n 2 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD178 time aiocp -b 256k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD179 time aiocp -b 256k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD180 time aiocp -b 256k -n 4 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD181 time aiocp -b 256k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD182 time aiocp -b 256k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD183 time aiocp -b 256k -n 8 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD184 time aiocp -b 256k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD185 time aiocp -b 256k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD186 time aiocp -b 256k -n 16 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD187 time aiocp -b 256k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD188 time aiocp -b 256k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD189 time aiocp -b 256k -n 32 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD190 time aiocp -b 256k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD191 time aiocp -b 256k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD192 time aiocp -b 256k -n 64 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD193 time aiocp -b 512k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD194 time aiocp -b 512k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD195 time aiocp -b 512k -n 1 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD196 time aiocp -b 512k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD197 time aiocp -b 512k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD198 time aiocp -b 512k -n 2 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD199 time aiocp -b 512k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD200 time aiocp -b 512k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD201 time aiocp -b 512k -n 4 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD202 time aiocp -b 512k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD203 time aiocp -b 512k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD204 time aiocp -b 512k -n 8 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD205 time aiocp -b 512k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD206 time aiocp -b 512k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD207 time aiocp -b 512k -n 16 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD208 time aiocp -b 512k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD209 time aiocp -b 512k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD210 time aiocp -b 512k -n 32 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD211 time aiocp -b 512k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD212 time aiocp -b 512k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile 
$TMPDIR/aiodio.$$/ff2
-AD213 time aiocp -b 512k -n 64 -f DIRECT -f SYNC 
$TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD301 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMPDIR/aiodio.$$/fff 
$TMPDIR/aiodio.$$/junkdir/fff
-AD302 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMPDIR/aiodio.$$/ff1 
$TMPDIR/aiodio.$$/junkdir/ff1
-AD303 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMPDIR/aiodio.$$/ff2 
$TMPDIR/aiodio.$$/junkdir/ff2
-AD304 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMPDIR/aiodio.$$/ff3 
$TMPDIR/aiodio.$$/junkdir/ff3
+AD001 aiocp -b 1k -n 1 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD002 aiocp -b 1k -n 1 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD003 aiocp -b 1k -n 1 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD004 aiocp -b 1k -n 2 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD005 aiocp -b 1k -n 2 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD006 aiocp -b 1k -n 2 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD007 aiocp -b 1k -n 4 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD008 aiocp -b 1k -n 4 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD009 aiocp -b 1k -n 4 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD010 aiocp -b 1k -n 8 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD012 aiocp -b 1k -n 8 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD013 aiocp -b 1k -n 8 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD014 aiocp -b 1k -n 16 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD015 aiocp -b 1k -n 16 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD016 aiocp -b 1k -n 16 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD017 aiocp -b 1k -n 32 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD018 aiocp -b 1k -n 32 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD019 aiocp -b 1k -n 32 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD020 aiocp -b 1k -n 64 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD021 aiocp -b 1k -n 64 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD022 aiocp -b 1k -n 64 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD023 aiocp -b 2k -n 1 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD024 aiocp -b 2k -n 1 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD025 aiocp -b 2k -n 1 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD026 aiocp -b 2k -n 2 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD027 aiocp -b 2k -n 2 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD028 aiocp -b 2k -n 2 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD029 aiocp -b 2k -n 4 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD030 aiocp -b 2k -n 4 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD031 aiocp -b 2k -n 4 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD032 aiocp -b 2k -n 8 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD033 aiocp -b 2k -n 8 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD034 aiocp -b 2k -n 8 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD035 aiocp -b 2k -n 16 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD036 aiocp -b 2k -n 16 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD037 aiocp -b 2k -n 16 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD038 aiocp -b 2k -n 32 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD039 aiocp -b 2k -n 32 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD040 aiocp -b 2k -n 32 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD041 aiocp -b 2k -n 64 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD042 aiocp -b 2k -n 64 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD043 aiocp -b 2k -n 64 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD044 aiocp -b 4k -n 1 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD045 aiocp -b 4k -n 1 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD046 aiocp -b 4k -n 1 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD047 aiocp -b 4k -n 2 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD048 aiocp -b 4k -n 2 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD049 aiocp -b 4k -n 2 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD050 aiocp -b 4k -n 4 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD051 aiocp -b 4k -n 4 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD052 aiocp -b 4k -n 4 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD053 aiocp -b 4k -n 8 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD054 aiocp -b 4k -n 8 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD055 aiocp -b 4k -n 8 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD056 aiocp -b 4k -n 16 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD057 aiocp -b 4k -n 16 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD058 aiocp -b 4k -n 16 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD059 aiocp -b 4k -n 32 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD060 aiocp -b 4k -n 32 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD061 aiocp -b 4k -n 32 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD062 aiocp -b 4k -n 64 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD063 aiocp -b 4k -n 64 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD064 aiocp -b 41k -n 64 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD065 aiocp -b 8k -n 1 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD066 aiocp -b 8k -n 1 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD067 aiocp -b 8k -n 1 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD068 aiocp -b 8k -n 2 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD069 aiocp -b 8k -n 2 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD070 aiocp -b 8k -n 2 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD071 aiocp -b 8k -n 4 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD072 aiocp -b 8k -n 4 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD073 aiocp -b 8k -n 4 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD074 aiocp -b 8k -n 8 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD075 aiocp -b 8k -n 8 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD076 aiocp -b 8k -n 8 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD077 aiocp -b 8k -n 16 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD078 aiocp -b 8k -n 16 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD079 aiocp -b 8k -n 16 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD080 aiocp -b 8k -n 32 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD081 aiocp -b 8k -n 32 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD082 aiocp -b 8k -n 32 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD083 aiocp -b 8k -n 64 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD084 aiocp -b 8k -n 64 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD085 aiocp -b 8k -n 64 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD086 aiocp -b 16k -n 1 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD087 aiocp -b 16k -n 1 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD088 aiocp -b 16k -n 1 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD089 aiocp -b 16k -n 2 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD090 aiocp -b 16k -n 2 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD091 aiocp -b 16k -n 2 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD092 aiocp -b 16k -n 4 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD093 aiocp -b 16k -n 4 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD094 aiocp -b 16k -n 4 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD095 aiocp -b 16k -n 8 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD096 aiocp -b 16k -n 8 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD097 aiocp -b 16k -n 8 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD098 aiocp -b 16k -n 16 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD099 aiocp -b 16k -n 16 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD101 aiocp -b 16k -n 16 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD102 aiocp -b 16k -n 32 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD103 aiocp -b 16k -n 32 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD104 aiocp -b 16k -n 32 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD105 aiocp -b 16k -n 64 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD106 aiocp -b 16k -n 64 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD107 aiocp -b 16k -n 64 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD108 aiocp -b 32k -n 1 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD109 aiocp -b 32k -n 1 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD110 aiocp -b 32k -n 1 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD112 aiocp -b 32k -n 2 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD113 aiocp -b 32k -n 2 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD114 aiocp -b 32k -n 2 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD115 aiocp -b 32k -n 4 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD116 aiocp -b 32k -n 4 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD117 aiocp -b 32k -n 4 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD118 aiocp -b 32k -n 8 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD119 aiocp -b 32k -n 8 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD120 aiocp -b 32k -n 8 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD121 aiocp -b 32k -n 16 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD122 aiocp -b 32k -n 16 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD123 aiocp -b 32k -n 16 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD124 aiocp -b 32k -n 32 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD125 aiocp -b 32k -n 32 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD126 aiocp -b 32k -n 32 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD127 aiocp -b 32k -n 64 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD128 aiocp -b 32k -n 64 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD129 aiocp -b 32k -n 64 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD130 aiocp -b 64k -n 1 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD131 aiocp -b 64k -n 1 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD132 aiocp -b 64k -n 1 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD133 aiocp -b 64k -n 2 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD134 aiocp -b 64k -n 2 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD135 aiocp -b 64k -n 2 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD136 aiocp -b 64k -n 4 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD137 aiocp -b 64k -n 4 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD138 aiocp -b 64k -n 4 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD139 aiocp -b 64k -n 8 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD140 aiocp -b 64k -n 8 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD141 aiocp -b 64k -n 8 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD142 aiocp -b 64k -n 16 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD143 aiocp -b 64k -n 16 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD144 aiocp -b 64k -n 16 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD145 aiocp -b 64k -n 32 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD146 aiocp -b 64k -n 32 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD147 aiocp -b 64k -n 32 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD148 aiocp -b 64k -n 64 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD149 aiocp -b 64k -n 64 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD150 aiocp -b 64k -n 64 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD151 aiocp -b 128k -n 1 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD152 aiocp -b 128k -n 1 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD153 aiocp -b 128k -n 1 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD154 aiocp -b 128k -n 2 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD155 aiocp -b 128k -n 2 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD156 aiocp -b 128k -n 2 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD157 aiocp -b 128k -n 4 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD158 aiocp -b 128k -n 4 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD159 aiocp -b 128k -n 4 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD160 aiocp -b 128k -n 8 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD161 aiocp -b 128k -n 8 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD162 aiocp -b 12k -n 8 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD163 aiocp -b 128k -n 16 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD164 aiocp -b 128k -n 16 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD165 aiocp -b 128k -n 16 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD166 aiocp -b 128k -n 32 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD167 aiocp -b 128k -n 32 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD168 aiocp -b 128k -n 32 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD169 aiocp -b 128k -n 64 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD170 aiocp -b 128k -n 64 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD171 aiocp -b 128k -n 64 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD172 aiocp -b 256k -n 1 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD173 aiocp -b 256k -n 1 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD174 aiocp -b 256k -n 1 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD175 aiocp -b 256k -n 2 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD176 aiocp -b 256k -n 2 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD177 aiocp -b 256k -n 2 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD178 aiocp -b 256k -n 4 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD179 aiocp -b 256k -n 4 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD180 aiocp -b 256k -n 4 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD181 aiocp -b 256k -n 8 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD182 aiocp -b 256k -n 8 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD183 aiocp -b 256k -n 8 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD184 aiocp -b 256k -n 16 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD185 aiocp -b 256k -n 16 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD186 aiocp -b 256k -n 16 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD187 aiocp -b 256k -n 32 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD188 aiocp -b 256k -n 32 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD189 aiocp -b 256k -n 32 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD190 aiocp -b 256k -n 64 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD191 aiocp -b 256k -n 64 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD192 aiocp -b 256k -n 64 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD193 aiocp -b 512k -n 1 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD194 aiocp -b 512k -n 1 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD195 aiocp -b 512k -n 1 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD196 aiocp -b 512k -n 2 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD197 aiocp -b 512k -n 2 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD198 aiocp -b 512k -n 2 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD199 aiocp -b 512k -n 4 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD200 aiocp -b 512k -n 4 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD201 aiocp -b 512k -n 4 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD202 aiocp -b 512k -n 8 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD203 aiocp -b 512k -n 8 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD204 aiocp -b 512k -n 8 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD205 aiocp -b 512k -n 16 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD206 aiocp -b 512k -n 16 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD207 aiocp -b 512k -n 16 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD208 aiocp -b 512k -n 32 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD209 aiocp -b 512k -n 32 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD210 aiocp -b 512k -n 32 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD211 aiocp -b 512k -n 64 -f DIRECT $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD212 aiocp -b 512k -n 64 -f SYNC $TMP/aiodio/junkfile $TMP/aiodio/ff2
+AD213 aiocp -b 512k -n 64 -f DIRECT -f SYNC $TMP/aiodio/junkfile 
$TMP/aiodio/ff2
+AD301 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMP/aiodio/fff 
$TMP/aiodio/junkdir/fff
+AD302 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMP/aiodio/ff1 
$TMP/aiodio/junkdir/ff1
+AD303 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMP/aiodio/ff2 
$TMP/aiodio/junkdir/ff2
+AD304 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMP/aiodio/ff3 
$TMP/aiodio/junkdir/ff3


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
