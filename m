Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xiaofeng_yan2006@126.com>) id 1ZClsI-0004uM-8j
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2015 09:42:42 +0000
Received: from m50-111.126.com ([123.125.50.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZClsE-00040m-MM
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2015 09:42:42 +0000
From: Changsheng Liu <liuchangsheng@inspur.com>
Date: Wed,  8 Jul 2015 17:42:23 +0800
Message-Id: <1436348543-6759-1-git-send-email-liuchangsheng@inspur.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] netns,
	when test ipv6 the parent and child can not ping each other
	successfully
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
Cc: wunan@inspur.com

After the cmd "ping6 -I",
we add "sleep 1" then parent and child can ping each other successfully

Signed-off-by: xiaofeng.yan <yanxiaofeng@inspur.com>
Signed-off-by: Changsheng Liu <liuchangsheng@inspur.com>
---
 testcases/kernel/containers/netns/netns_childipv6.sh | 1 +
 testcases/kernel/containers/netns/netns_paripv6.sh   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/netns/netns_childipv6.sh b/testcases/kernel/containers/netns/netns_childipv6.sh
index f41dcc2..04a8e08 100755
--- a/testcases/kernel/containers/netns/netns_childipv6.sh
+++ b/testcases/kernel/containers/netns/netns_childipv6.sh
@@ -83,6 +83,7 @@ status=0
 
     # checking if parent ns responding
     ping6 -I $vnet1 -qc 2 $parIPv6 >/dev/null 2>&1
+    sleep 1
            if [ $? = 0 ] ; then
                tst_resm TINFO "IPv6: Pinging Parent from Child: PASS"
             else
diff --git a/testcases/kernel/containers/netns/netns_paripv6.sh b/testcases/kernel/containers/netns/netns_paripv6.sh
index 6d2f48d..9efd0aa 100755
--- a/testcases/kernel/containers/netns/netns_paripv6.sh
+++ b/testcases/kernel/containers/netns/netns_paripv6.sh
@@ -89,7 +89,7 @@ status=0
         tst_brkm TBROK "timeout reached!"
     fi
     ping6 -I $vnet0 -qc 2 $childIPv6 >/dev/null 2>&1
-
+    sleep 1
     if [ $? = 0 ] ; then
        tst_resm TINFO "IPv6: Pinging child from parent: PASS"
        status=0
-- 
1.9.1



------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
