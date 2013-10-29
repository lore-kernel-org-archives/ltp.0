Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VbHep-00081Q-Tx
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:21:03 +0000
Received: from mail-oa0-f54.google.com ([209.85.219.54])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VbHep-00065Z-8f
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:21:03 +0000
Received: by mail-oa0-f54.google.com with SMTP id o20so636248oag.13
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Oct 2013 15:20:57 -0700 (PDT)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Tue, 29 Oct 2013 15:20:40 -0700
Message-Id: <1383085243-5833-7-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 6/9] ltp-networking/iproute: ip02: set original
	mtu size back. this test will set mtu to 300. ip05: if there
	is nott only one route using "head" command will get wrong result.
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
Cc: linaro-networking@linaro.org

---
 testcases/network/iproute/ip_tests.sh |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
index ce4cabc..49b2886 100755
--- a/testcases/network/iproute/ip_tests.sh
+++ b/testcases/network/iproute/ip_tests.sh
@@ -187,6 +187,7 @@ test01()

 	tst_resm TINFO "Test #1: changing mtu size of eth0:1 device."

+	MTUSZ_BAK=`ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://" | awk '{print $1}'`
 	ip link set eth0:1 mtu 300 >$LTPTMP/tst_ip.err 2>&1
 	if [ $RC -ne 0 ]
 	then
@@ -198,6 +199,7 @@ test01()
 		if [ $MTUSZ -eq 300 ]
 		then
 			tst_resm TPASS "Test #1: changing mtu size success"
+	        ip link set eth0:1 mtu $MTUSZ_BAK >$LTPTMP/tst_ip.err 2>&1
 		else
 			tst_resm FAIL NULL \
 				"Test #1: MTU value not set to 300: ifconfig returned: $MTUSZ"
@@ -453,7 +455,9 @@ test05()
 		10.6.6.6 via 127.0.0.1 dev lo
 		EOF

-		ip route show | head -n1 >$LTPTMP/tst_ip.out 2>&1 || RC=$?
+		ip route show >$LTPTMP/tst_ip.out.tmp
+        grep "10.6.6.6 via 127.0.0.1 dev lo" $LTPTMP/tst_ip.out.tmp \
+            >$LTPTMP/tst_ip.out 2>&1 || RC=$?
 		if [ $RC -ne 0 ]
 		then
 			tst_res TFAIL $LTPTMP/tst_ip.err \
--
1.7.9.5


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
