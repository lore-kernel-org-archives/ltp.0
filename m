Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanpai.chen@gmail.com>) id 1QcAct-0002vT-H8
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 06:21:23 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QcAcs-0004uP-H1
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 06:21:23 +0000
Received: by ywa12 with SMTP id 12so1017741ywa.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jun 2011 23:21:17 -0700 (PDT)
From: Andrew Chen <yanpai.chen@gmail.com>
Date: Thu, 30 Jun 2011 14:19:41 +0800
Message-Id: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
Subject: [LTP] [PATCH 1/7] testcases: fs_bind: fix hanging of testscript
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
Cc: ypchen@faraday-tech.com

From: Andrew Chen <ypchen@faraday-tech.com>

Busybox's xargs doesn't recongize the --max-args option. Use -n instead.

Signed-off-by: Andrew Chen <ypchen@faraday-tech.com>
---
 ltp-full-20101031/testscripts/test_fs_bind.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ltp-full-20101031/testscripts/test_fs_bind.sh b/ltp-full-20101031/testscripts/test_fs_bind.sh
index 9ab533a..6b986dc 100755
--- a/ltp-full-20101031/testscripts/test_fs_bind.sh
+++ b/ltp-full-20101031/testscripts/test_fs_bind.sh
@@ -318,7 +318,7 @@ restore_mounts()
 	# new mounts around and will never remove mounts outside the test
 	# directory
 	( while grep_mounts ; do
-		grep_mounts | awk '{print $3}' | xargs -r --max-args=1 umount -l
+		grep_mounts | awk '{print $3}' | xargs -r -n 1 umount -l
 	done ) >& /dev/null
 
 	# mount list and exit with 0
-- 
1.6.5


------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
