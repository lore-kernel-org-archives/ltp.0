Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1SFb6a-0004iY-Gn
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 01:03:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SFb6Z-0004fr-83
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 01:03:16 +0000
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Thu, 5 Apr 2012 09:02:06 +0800
Message-Id: <1333587726-8962-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH] at_deny01: fix a bug of /etc/init.d/atd is nonexistent
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
To: yanegomi@gmail.com, gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

/etc/init.d/atd is nonexistent in fedora16, so should use systemctl.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/commands/at/at_allow01 |   13 ++++++++++++-
 testcases/commands/at/at_deny01  |   13 ++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/at/at_allow01 b/testcases/commands/at/at_allow01
index b08a2d9..5ada6a6 100755
--- a/testcases/commands/at/at_allow01
+++ b/testcases/commands/at/at_allow01
@@ -80,8 +80,19 @@ do_setup()
 		exit 1
 	fi
 
+	# running under systemd?
+	if command -v systemctl >/dev/null 2>&1; then
+		HAVE_SYSTEMCTL=true
+	else
+		HAVE_SYSTEMCTL=false
+	fi
+
 	# Restart atd daemon.
-	/etc/init.d/atd restart
+	if $HAVE_SYSTEMCTL; then
+		systemctl restart atd.service
+	else
+		/etc/init.d/atd restart
+	fi
 }
 
 #-----------------------------------------------------------------------
diff --git a/testcases/commands/at/at_deny01 b/testcases/commands/at/at_deny01
index 9f9f433..b43ea34 100755
--- a/testcases/commands/at/at_deny01
+++ b/testcases/commands/at/at_deny01
@@ -86,8 +86,19 @@ do_setup()
 		exit 1
 	fi
 
+	# running under systemd?
+	if command -v systemctl >/dev/null 2>&1; then
+		HAVE_SYSTEMCTL=true
+	else
+		HAVE_SYSTEMCTL=false
+	fi
+
 	# Restart atd daemon.
-	/etc/init.d/atd restart
+	if $HAVE_SYSTEMCTL; then
+		systemctl restart atd.service
+	else
+		/etc/init.d/atd restart
+	fi
 }
 
 #-----------------------------------------------------------------------
-- 
1.7.10.rc3


------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
