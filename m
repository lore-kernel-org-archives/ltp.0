Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VbHer-0006av-CH
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:21:05 +0000
Received: from mail-oa0-f52.google.com ([209.85.219.52])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VbHeq-0006tK-N5
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:21:05 +0000
Received: by mail-oa0-f52.google.com with SMTP id j1so636349oag.11
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Oct 2013 15:20:59 -0700 (PDT)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Tue, 29 Oct 2013 15:20:41 -0700
Message-Id: <1383085243-5833-8-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 7/9] ltp-networking/iptables: "iptables -L -t
	nat" lists 4 chains not 3 chains on Ubuntu 12.04
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
 testcases/network/iptables/iptables_tests.sh |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/testcases/network/iptables/iptables_tests.sh b/testcases/network/iptables/iptables_tests.sh
index 028d54e..641f327 100755
--- a/testcases/network/iptables/iptables_tests.sh
+++ b/testcases/network/iptables/iptables_tests.sh
@@ -165,13 +165,21 @@ test01()
 		return $RC
 	else
 		chaincnt=$(grep -c Chain $LTPTMP/tst_iptables.out)
-		if [ $chaincnt -ne 3 ]; then
-			tst_res TFAIL $LTPTMP/tst_iptables.out \
-				"$TCID: $cmd failed to list rules. Reason:"
-			return $chaincnt
-		else
-			tst_resm TINFO "$TCID: $cmd lists rules."
-		fi
+            # for debian or ubuntu
+            if [ -f /etc/debian_version ]; then
+                if [ $chaincnt -ne 4 ]; then
+                    tst_res TFAIL $LTPTMP/tst_iptables.out \
+                        "$TCID: $cmd failed to list rules. Reason:"
+                        return $chaincnt
+                fi
+            else
+                if [ $chaincnt -ne 3 ]; then
+                    tst_res TFAIL $LTPTMP/tst_iptables.out \
+                        "$TCID: $cmd failed to list rules. Reason:"
+                        return $chaincnt
+                fi
+            fi
+            tst_resm TINFO "$TCID: $cmd lists rules."
 	fi

 	local cmd="iptables -L -t mangle"
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
