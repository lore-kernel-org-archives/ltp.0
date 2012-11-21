Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1Tb7VO-00068Q-OE
	for ltp-list@lists.sourceforge.net; Wed, 21 Nov 2012 10:26:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tb7VN-0006r6-3J
	for ltp-list@lists.sourceforge.net; Wed, 21 Nov 2012 10:26:06 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id qALAPw24024124
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Nov 2012 18:25:58 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Wed, 21 Nov 2012 18:25:13 +0800
Message-Id: <1353493513-1288-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH] runnetnstest.sh: fix a fail of vsftpd is disabled
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

When vsftpd is disabled, runnetnstest.sh should start vsftpd first.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/kernel/containers/netns/runnetnstest.sh | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/testcases/kernel/containers/netns/runnetnstest.sh b/testcases/kernel/containers/netns/runnetnstest.sh
index d2a7fec..92a1cd6 100755
--- a/testcases/kernel/containers/netns/runnetnstest.sh
+++ b/testcases/kernel/containers/netns/runnetnstest.sh
@@ -106,6 +106,26 @@ echo
 #fi
 #echo
 
+flag=0
+# running under systemd?
+if command -v systemctl >/dev/null 2>&1; then
+	HAVE_SYSTEMCTL=1
+else
+	HAVE_SYSTEMCTL=0
+fi
+
+if [ $HAVE_SYSTEMCTL -eq 1 ]; then
+	systemctl status vsftpd.service > /dev/null 2>&1 || flag=$?
+	if [ $flag -ne 0 ]; then
+		systemctl start vsftpd.service > /dev/null 2>&1
+	fi
+else
+	service vsftpd status > /dev/null 2>&1 || flag=$?
+	if [ $flag -ne 0 ]; then
+		service vsftpd start > /dev/null 2>&1
+	fi
+fi
+
 par_chld_ftp
 rc=$?
 if [ $rc -ne 0 ]; then
@@ -115,5 +135,14 @@ if [ $rc -ne 0 ]; then
 else
    echo "par_chld_ftp: PASS"
 fi
+
+if [ $flag -ne 0 ]; then
+	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
+		systemctl stop vsftpd.service > /dev/null 2>&1
+	else
+		service vsftpd stop > /dev/null 2>&1
+	fi
+fi
+
 echo
 exit $exit_code
-- 
1.8.0


------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
