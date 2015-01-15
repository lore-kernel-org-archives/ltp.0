Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YBjPf-0002MX-4u
	for ltp-list@lists.sourceforge.net; Thu, 15 Jan 2015 12:20:35 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YBjPd-0005KR-2s
	for ltp-list@lists.sourceforge.net; Thu, 15 Jan 2015 12:20:35 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t0FCKQRN010609
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Jan 2015 12:20:27 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	t0FCKPKH013274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Jan 2015 12:20:26 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0FCKPOj007964
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Jan 2015 12:20:25 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 15 Jan 2015 15:22:37 +0300
Message-Id: <1421324561-6680-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] lib/test_net.sh: fix 'tst_rhost_run -s' when errors
	occur
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Don't redirect stderr to /dev/null, print it in TBROK message.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index ec3366b..310d3d1 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -45,7 +45,10 @@ tst_rhost_run()
 			post_cmd=" > /dev/null 2>&1 &"
 			out="1> /dev/null"
 		;;
-		s) safe=1 ;;
+		s)
+			safe=1
+			post_cmd=' || echo TERR'
+		;;
 		c) cmd=$OPTARG ;;
 		u) user=$OPTARG ;;
 		*)
@@ -62,14 +65,14 @@ tst_rhost_run()
 	local ret=
 	if [ -n "$TST_USE_SSH" ]; then
 		output=`ssh -n -q $user@$RHOST "sh -c \
-			'$pre_cmd $cmd $post_cmd'" $out 2> /dev/null`
+			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'TERR'`
 	else
 		output=`rsh -n -l $user $RHOST "sh -c \
-			'$pre_cmd $cmd $post_cmd'" $out 2> /dev/null`
+			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'TERR'`
 	fi
-	ret=$?
-	[ "$ret" -ne 0 -a "$safe" -eq 1 ] && \
-		tst_brkm TBROK "failed to run '$cmd' on '$RHOST'"
+	echo "$output" | grep -q 'TERR$'
+	[ $? -eq 0 -a "$safe" -eq 1 ] && \
+		tst_brkm TBROK "failed to run '$cmd' on '$RHOST': '$output'"
 
 	[ -z "$out" -a -n "$output" ] && echo "$output"
 
-- 
1.7.1


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
