Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VblW6-00062A-8u
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 06:14:02 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VblW4-0005fV-Ej
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 06:14:02 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9V6Dsh9000575
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 06:13:54 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9V6DruC005884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 06:13:54 GMT
Received: from abhmt107.oracle.com (abhmt107.oracle.com [141.146.116.59])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9V6DrZB005878
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 06:13:53 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Thu, 31 Oct 2013 14:13:38 +0800
Message-Id: <1383200018-1207-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH] iptables_tests.sh: nat table can have 4 chains
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

It is considered by iptables_tests.sh a failure When nat table chain count is
not 3, while recent kernels can have 4 built-in chains in nat table, namely
PREROUTING, OUTPUT, POSTROUTING and INPUT.
---
 testcases/network/iptables/iptables_tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/iptables/iptables_tests.sh b/testcases/network/iptables/iptables_tests.sh
index 028d54e..77ee29b 100755
--- a/testcases/network/iptables/iptables_tests.sh
+++ b/testcases/network/iptables/iptables_tests.sh
@@ -165,7 +165,7 @@ test01()
 		return $RC
 	else
 		chaincnt=$(grep -c Chain $LTPTMP/tst_iptables.out)
-		if [ $chaincnt -ne 3 ]; then
+		if [ $chaincnt -ne 3 ] && [ $chaincnt -ne 4 ]; then
 			tst_res TFAIL $LTPTMP/tst_iptables.out \
 				"$TCID: $cmd failed to list rules. Reason:"
 			return $chaincnt
-- 
1.8.4


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
