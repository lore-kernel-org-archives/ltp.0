Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1Tfmpw-00082K-3p
	for ltp-list@lists.sourceforge.net; Tue, 04 Dec 2012 07:22:36 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tfmpq-0006vm-JS
	for ltp-list@lists.sourceforge.net; Tue, 04 Dec 2012 07:22:36 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id qB47MXna017391
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Dec 2012 15:22:33 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Tue, 4 Dec 2012 15:21:53 +0800
Message-Id: <1354605716-4747-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH 1/4] cmdlib.sh: Add four functions of controlling
	daemon
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

Add four functions of controlling daemon:
  - start_daemon
  - stop_daemon
  - status_daemon
  - restart_daemon

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/lib/cmdlib.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/testcases/lib/cmdlib.sh b/testcases/lib/cmdlib.sh
index 6aeb10f..b7eee1a 100644
--- a/testcases/lib/cmdlib.sh
+++ b/testcases/lib/cmdlib.sh
@@ -150,3 +150,46 @@ is_root()
 TCID=${TCID:=}
 [ -z "$TCID" ] && TCID=${0##*/}
 TC=$(echo "$TCID" | awk '{ sub( /[0-9]+$/,""); print; }')
+
+# running under systemd?
+if command -v systemctl >/dev/null 2>&1; then
+	HAVE_SYSTEMCTL=1
+else
+	HAVE_SYSTEMCTL=0
+fi
+
+start_daemon()
+{
+	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
+		systemctl start $1.service > /dev/null 2>&1
+	else
+		service $1 start > /dev/null 2>&1
+	fi
+}
+
+stop_daemon()
+{
+	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
+		systemctl stop $1.service > /dev/null 2>&1
+	else
+		service $1 stop > /dev/null 2>&1
+	fi
+}
+
+status_daemon()
+{
+	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
+		systemctl status $1.service > /dev/null 2>&1
+	else
+		service $1 status > /dev/null 2>&1
+	fi
+}
+
+restart_daemon()
+{
+	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
+		systemctl start $1.service > /dev/null 2>&1
+	else
+		service $1 start > /dev/null 2>&1
+	fi
+}
-- 
1.8.0


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
