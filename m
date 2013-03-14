Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1UGBTK-0007I0-0a
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:57:42 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UGBTI-0003dD-8T
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:57:41 +0000
From: Markos Chandras <markos.chandras@gmail.com>
Date: Thu, 14 Mar 2013 16:55:51 +0000
Message-ID: <1363280151-10623-1-git-send-email-markos.chandras@gmail.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] ltp: Add support for Imagination Technologies Meta
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
__metag__ macro to the ltp_clone function. Also fix the #if/def
macro for s390x.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 lib/cloner.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/cloner.c b/lib/cloner.c
index 3835184..a68ff1e 100644
--- a/lib/cloner.c
+++ b/lib/cloner.c
@@ -31,7 +31,7 @@
 
 #undef clone			/* we want to use clone() */
 
-#if defined (__s390__) || (__s390x__)
+#if defined (__s390__) || defined(__s390x__)
 #define clone __clone
 extern int __clone(int (void *), void *, int, void *);
 #elif defined(__ia64__)
@@ -54,7 +54,7 @@ ltp_clone(unsigned long clone_flags, int (*fn) (void *arg), void *arg,
 {
 	int ret;
 
-#if defined(__hppa__)
+#if defined(__hppa__) || defined(__metag__)
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
