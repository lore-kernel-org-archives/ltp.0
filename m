Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ratbert.chuang@gmail.com>) id 1QUWJy-0008Mb-AB
	for ltp-list@lists.sourceforge.net; Thu, 09 Jun 2011 03:54:14 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QUWJx-0008NM-Aw
	for ltp-list@lists.sourceforge.net; Thu, 09 Jun 2011 03:54:14 +0000
Received: by pvc30 with SMTP id 30so744452pvc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jun 2011 20:54:07 -0700 (PDT)
From: Po-Yu Chuang <ratbert.chuang@gmail.com>
Date: Thu,  9 Jun 2011 11:53:58 +0800
Message-Id: <1307591638-1662-1-git-send-email-ratbert.chuang@gmail.com>
Subject: [LTP] [PATCH] acl_test01: fix incorrect failure losetup.1
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
Cc: Po-Yu Chuang <ratbert@faraday-tech.com>

From: Po-Yu Chuang <ratbert@faraday-tech.com>

The LOOP_DEV empty checking was incorrect.

Use `command` for command substitution.

Also move the assignment out of condition expression. Bash 3.2.9 and
Busybox 1.17.3 ash do not seem to support this kind of usage.

Signed-off-by: Po-Yu Chuang <ratbert@faraday-tech.com>
---
 testcases/kernel/fs/acls/acl_test01 |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
index 7901002..7f883c6 100755
--- a/testcases/kernel/fs/acls/acl_test01
+++ b/testcases/kernel/fs/acls/acl_test01
@@ -125,7 +125,8 @@ else
 
 	# Avoid hardcoded loopback device values (-f tries to find the first
 	# available loopback device name)!
-	if ! (LOOP_DEV=$(losetup -f) && [ "x$LOOP_DEV" = x ]); then
+	LOOP_DEV=`losetup -f`
+	if [ "x$LOOP_DEV" = x ]; then
 		tst_resm TCONF "[ losetup.1 ] Failed to find an available loopback device -- is the required support compiled in your kernel?"
 		exit 0
 	fi
-- 
1.6.3.3


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
