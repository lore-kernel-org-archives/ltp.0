Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MiqgB-0001Lv-Hg
	for ltp-list@lists.sourceforge.net; Wed, 02 Sep 2009 14:19:19 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Miqg6-00059c-7k
	for ltp-list@lists.sourceforge.net; Wed, 02 Sep 2009 14:19:19 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n82EH4vl019977
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Sep 2009 08:17:04 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n82EJ6p7107780
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Sep 2009 08:19:07 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n82EJ6e1000592
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Sep 2009 08:19:06 -0600
Date: Wed, 2 Sep 2009 09:10:27 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090902141027.GA13905@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH 1/1] Containers: Pass a valid stack address to clone
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
To: Subrata Modak1 <subrata.modak@in.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Nathan T Lynch <natlynch@us.ibm.com>

Nathan's description:
Off-by-one error: the stack address passed to clone() must be
within the region allocated.

Fortunately most of the containers tests were using the common
helpers.

Also fix the libnetns helper to, like the libclone one, special-case
hppa and pass the bottom of the stack to clone2 for __ia64__ (as per
the libclone example and the clone2 manpage).  I don't know and can't
test whether it's right, but have to assume that one of the other was
wrong.

Reported-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Serge Hallyn <serge@us.ibm.com>
---
 testcases/kernel/containers/libclone/libclone.c    |    2 +-
 testcases/kernel/containers/libclone/libnetns.c    |    8 +++++---
 .../containers/sysvipc/check_ipcns_enabled.c       |    2 +-
 .../containers/utsname/check_utsns_enabled.c       |    2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/containers/libclone/libclone.c b/testcases/kernel/containers/libclone/libclone.c
index c97d94b..0fa5827 100644
--- a/testcases/kernel/containers/libclone/libclone.c
+++ b/testcases/kernel/containers/libclone/libclone.c
@@ -35,7 +35,7 @@ int do_clone(unsigned long clone_flags,
 #elif defined(__ia64__)
 	ret = clone2(fn1, stack, stack_size, clone_flags, arg1, NULL, NULL, NULL);
 #else
-	ret = clone(fn1, stack + stack_size, clone_flags, arg1);
+	ret = clone(fn1, stack + stack_size - 1, clone_flags, arg1);
 #endif
 
 	if (ret == -1) {
diff --git a/testcases/kernel/containers/libclone/libnetns.c b/testcases/kernel/containers/libclone/libnetns.c
index 821fec1..22461f8 100644
--- a/testcases/kernel/containers/libclone/libnetns.c
+++ b/testcases/kernel/containers/libclone/libnetns.c
@@ -72,7 +72,7 @@ int create_net_namespace(char *p1, char *c1)
 		perror("failled to malloc memory for stack...");
 		return -1;
 	}
-	childstack = stack + stack_size;
+	childstack = stack + stack_size - 1;
 
 	clone_flags |= CLONE_NEWNS;
 /* Enable other namespaces too optionally */
@@ -80,8 +80,10 @@ int create_net_namespace(char *p1, char *c1)
 	clone_flags |= CLONE_NEWPID;
 #endif
 
-#ifdef __ia64__
-	pid = clone2(child_fn, childstack, getpagesize(), clone_flags | SIGCHLD,
+#if defined(__hppa__)
+	ret = clone(child_fn, stack, clone_flags, c1);
+#elif defined(__ia64__)
+	pid = clone2(child_fn, stack, stack_size, clone_flags | SIGCHLD,
 						(void *)c1, NULL, NULL, NULL);
 #else
 	pid = clone(child_fn, childstack, clone_flags | SIGCHLD, (void *)c1);
diff --git a/testcases/kernel/containers/sysvipc/check_ipcns_enabled.c b/testcases/kernel/containers/sysvipc/check_ipcns_enabled.c
index 3d9b74a..9b2b7ba 100644
--- a/testcases/kernel/containers/sysvipc/check_ipcns_enabled.c
+++ b/testcases/kernel/containers/sysvipc/check_ipcns_enabled.c
@@ -37,7 +37,7 @@ int main()
                 return 2;
         }
 
-        childstack = stack + getpagesize();
+        childstack = stack + getpagesize() - 1;
 
 #ifdef __ia64__
         pid = clone2(dummy, childstack, getpagesize(), CLONE_NEWIPC, NULL, NULL, NULL, NULL);
diff --git a/testcases/kernel/containers/utsname/check_utsns_enabled.c b/testcases/kernel/containers/utsname/check_utsns_enabled.c
index 80b9f47..c35b24f 100644
--- a/testcases/kernel/containers/utsname/check_utsns_enabled.c
+++ b/testcases/kernel/containers/utsname/check_utsns_enabled.c
@@ -73,7 +73,7 @@ int main()
 		return 2;
 	}
 
-	childstack = stack + getpagesize();
+	childstack = stack + getpagesize() - 1;
 
 #ifdef __ia64__
 	pid = clone2(dummy, childstack, getpagesize(), CLONE_NEWUTS, NULL, NULL, NULL, NULL);
-- 
1.6.0.4


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
