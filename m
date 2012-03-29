Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1SDC8n-0001N2-U0
	for ltp-list@lists.sourceforge.net; Thu, 29 Mar 2012 09:59:37 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SDC8i-0005Pz-FC
	for ltp-list@lists.sourceforge.net; Thu, 29 Mar 2012 09:59:37 +0000
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Thu, 29 Mar 2012 17:58:23 +0800
Message-Id: <1333015103-23342-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH] cron02: fix a bug of /etc/init.d/crond is nonexistent
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
To: caspar@casparzhang.com, gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

/etc/init.d/crond is nonexistent in fedora16, so should be replaced with
systemctl.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/commands/cron/cron02 |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/commands/cron/cron02 b/testcases/commands/cron/cron02
index 0c05c95..213fe02 100755
--- a/testcases/commands/cron/cron02
+++ b/testcases/commands/cron/cron02
@@ -52,12 +52,26 @@ do_setup(){
         }
         fi
 
+	# running under systemd?
+	if command -v systemctl >/dev/null 2>&1; then
+		HAVE_SYSTEMCTL=1
+	else
+		HAVE_SYSTEMCTL=0
+	fi
+
 	# restart cron daemon
 	# Red Hat uses crond, SuSE/Other uses cron.
 	if [ -x /etc/init.d/crond ]; then
 		/etc/init.d/crond restart
 	elif [ -x /etc/init.d/cron ]; then
 		/etc/init.d/cron restart
+	elif [ $HAVE_SYSTEMCTL == 1 ]; then
+		for crond in "crond" "cron"; do
+			if systemctl is-enabled $crond.service >/dev/null 2>&1; then
+				systemctl restart $crond.service
+				break
+			fi
+		done
 	else
 		echo "Could not determine cron init.d script."
 		exit 1
-- 
1.7.10.rc1


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
