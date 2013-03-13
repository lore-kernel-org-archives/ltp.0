Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1UFmIy-000546-3v
	for ltp-list@lists.sourceforge.net; Wed, 13 Mar 2013 14:05:20 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UFmIs-0001xh-Tu
	for ltp-list@lists.sourceforge.net; Wed, 13 Mar 2013 14:05:20 +0000
From: Markos Chandras <markos.chandras@gmail.com>
Date: Wed, 13 Mar 2013 14:04:54 +0000
Message-ID: <1363183494-20392-1-git-send-email-markos.chandras@gmail.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] ltp: Add support for Imagination Technologies Meta
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

From: Markos Chandras <markos.chandras@imgtec.com>

This patch adds support for Imagination's Meta architecture.
The Meta Linux kernel port will be included in the Linux Kernel
v3.9. The Meta stack grows upwards so we need to add the appropriate
__metag__ macro to the ltp_clone function.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 lib/cloner.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/cloner.c b/lib/cloner.c
index 3835184..fa18731 100644
--- a/lib/cloner.c
+++ b/lib/cloner.c
@@ -54,7 +54,7 @@ ltp_clone(unsigned long clone_flags, int (*fn) (void *arg), void *arg,
 {
 	int ret;
 
-#if defined(__hppa__)
+#if defined(__hppa__) || (__metag__)
 	ret = clone(fn, stack, clone_flags, arg);
 #elif defined(__ia64__)
 	ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL, NULL);
-- 
1.7.1



------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
