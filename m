Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VlYnA-00032o-MQ
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 06:40:08 +0000
Received: from mail-pd0-f176.google.com ([209.85.192.176])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VlYn9-0006S4-TF
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 06:40:08 +0000
Received: by mail-pd0-f176.google.com with SMTP id w10so9297878pde.35
	for <ltp-list@lists.sourceforge.net>;
	Tue, 26 Nov 2013 22:40:02 -0800 (PST)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Wed, 27 Nov 2013 14:37:52 +0800
Message-Id: <1385534272-32414-3-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1385534272-32414-1-git-send-email-vincent.hsu@linaro.org>
References: <1385534272-32414-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH V2 2/2] ltp-networking/iproute: fix iproute test
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

ip02: set original mtu size back. this test will modify mtu to 300.
ip05: if there is not only one route, using "head" command will get
      wrong result.

Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>
---
 testcases/network/iproute/ip_tests.sh |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
index ce4cabc..0416300 100755
--- a/testcases/network/iproute/ip_tests.sh
+++ b/testcases/network/iproute/ip_tests.sh
@@ -187,6 +187,8 @@ test01()

 	tst_resm TINFO "Test #1: changing mtu size of eth0:1 device."

+	MTUSZ_BAK=`ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://" \
+		| awk '{print $1}'`
 	ip link set eth0:1 mtu 300 >$LTPTMP/tst_ip.err 2>&1
 	if [ $RC -ne 0 ]
 	then
@@ -198,6 +200,8 @@ test01()
 		if [ $MTUSZ -eq 300 ]
 		then
 			tst_resm TPASS "Test #1: changing mtu size success"
+			ip link set eth0:1 mtu $MTUSZ_BAK \
+				>$LTPTMP/tst_ip.err 2>&1
 		else
 			tst_resm FAIL NULL \
 				"Test #1: MTU value not set to 300: ifconfig returned: $MTUSZ"
@@ -453,7 +457,8 @@ test05()
 		10.6.6.6 via 127.0.0.1 dev lo
 		EOF

-		ip route show | head -n1 >$LTPTMP/tst_ip.out 2>&1 || RC=$?
+		ip route show | grep "10.6.6.6 via 127.0.0.1 dev lo" \
+			>$LTPTMP/tst_ip.out 2>&1 || RC=$?
 		if [ $RC -ne 0 ]
 		then
 			tst_res TFAIL $LTPTMP/tst_ip.err \
--
1.7.9.5


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
