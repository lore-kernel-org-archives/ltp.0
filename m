Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dave.kleikamp@oracle.com>) id 1VBsdc-0001A1-Ku
	for ltp-list@lists.sourceforge.net; Tue, 20 Aug 2013 20:34:48 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VBsdb-0005s8-Sv
	for ltp-list@lists.sourceforge.net; Tue, 20 Aug 2013 20:34:48 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r7KKYfcC027917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Aug 2013 20:34:42 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7KKYeeW025388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Aug 2013 20:34:41 GMT
Received: from abhmt118.oracle.com (abhmt118.oracle.com [141.146.116.70])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7KKYeHj011364
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Aug 2013 20:34:40 GMT
Message-ID: <5213D2DF.20802@oracle.com>
Date: Tue, 20 Aug 2013 15:34:39 -0500
From: Dave Kleikamp <dave.kleikamp@oracle.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] ltp: handle missing online file
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
To: ltp-list@lists.sourceforge.net

gather_node_cpus() fails if the /sys/devices/system/node/nodeX/cpuX/online
file is missing for any cpu other than cpu0. The absence of the online file
should not be treated as a failure, but as an indication that the cpu is
not hot-pluggable and cannot be taken offline.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 9bc926e..99243a6 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -786,16 +786,14 @@ static void gather_node_cpus(char *cpus, long nd)
 		if (path_exist(path, nd, i)) {
 			snprintf(path1, BUFSIZ, "%s/online", path);
 			/*
-			 * No cpu0/online knob, as it can't support to
-			 * on/offline cpu0, so if the 'nd' node contains
-			 * cpu0, it should skip to check cpu0/online's value.
+			 * if there is no online knob, then the cpu cannot
+			 * be taken offline
 			 */
-			if (i == 0)
-				goto next;
-			SAFE_FILE_SCANF(cleanup, path1, "%ld", &online);
-			if (online == 0)
-				continue;
-next:
+			if (path_exist(path1)) {
+				SAFE_FILE_SCANF(cleanup, path1, "%ld", &online);
+				if (online == 0)
+					continue;
+			}
 			sprintf(buf, "%d,", i);
 			strcat(cpus, buf);
 		}

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
