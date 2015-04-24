Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1YlZFU-0003T6-4V
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 08:46:12 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YlZFP-0005h3-Gh
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 08:46:11 +0000
From: Cui Bixuan <cuibixuan@huawei.com>
Date: Fri, 24 Apr 2015 08:45:44 +0000
Message-ID: <1429865144-3141-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] ftp/ftp02: case failed when vsftpd is not running
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
Cc: , huawei.com.lijinyue@huawei.com, zhuyanpeng@huawei.com.zhanyongming

Before the test, checking if vsftpd is running will be better.
Otherwise some cases which test vsftpd will passed even vsftpd is
not running and others will failed.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/network/tcp_cmds/ftp/ftp_setup |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp_setup b/testcases/network/tcp_cmds/ftp/ftp_setup
index 73d0aac..5145e66 100644
--- a/testcases/network/tcp_cmds/ftp/ftp_setup
+++ b/testcases/network/tcp_cmds/ftp/ftp_setup
@@ -35,6 +35,12 @@ do_setup()
 		tst_brkm TBROK "vsftpd.conf not found."
 	fi
 
+	# check if vsftpd is running
+        netstat -pl |grep vsftpd > /dev/null 2>&1
+        if [ $? -ne 0 ]; then
+                tst_brkm TCONF "vsftpd is not running."
+        fi
+
 	LOCAL_ENABLE=$(awk -F= '/^local_enable=/ {print $2}' "$VSFTP_CONF")
 	if [ "$LOCAL_ENABLE" != "YES" ]; then
 		LOCAL_ENABLE="NO"
-- 
1.6.0.2


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
