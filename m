Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1Vgnne-0004LH-6n
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 03:40:58 +0000
Received: from mail-pb0-f44.google.com ([209.85.160.44])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Vgnnd-0002sk-Ap
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 03:40:58 +0000
Received: by mail-pb0-f44.google.com with SMTP id rp16so1407206pbb.3
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Nov 2013 19:40:51 -0800 (PST)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Thu, 14 Nov 2013 11:38:39 +0800
Message-Id: <1384400319-30776-8-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
References: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 8/8] ltp-networking/iproute: fix iproute test
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

ip02: set original mtu size back. this test will set mtu to 300.
ip05: if there is not only one route, using "head" command will get
      wrong result.

Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>
---
 testcases/network/iproute/ip_tests.sh |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
index ce4cabc..e16f6c4 100755
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
+			ip link set eth0:1 mtu $MTUSZ_BAK >$LTPTMP/tst_ip.err 2>&1
 		else
 			tst_resm FAIL NULL \
 				"Test #1: MTU value not set to 300: ifconfig returned: $MTUSZ"
@@ -453,7 +455,8 @@ test05()
 		10.6.6.6 via 127.0.0.1 dev lo
 		EOF

-		ip route show | head -n1 >$LTPTMP/tst_ip.out 2>&1 || RC=$?
+		ip route show | grep "10.6.6.6 via 127.0.0.1 dev lo" \
+		>$LTPTMP/tst_ip.out 2>&1 || RC=$?
 		if [ $RC -ne 0 ]
 		then
 			tst_res TFAIL $LTPTMP/tst_ip.err \
--
1.7.9.5


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
