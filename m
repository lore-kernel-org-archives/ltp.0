Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MWlg5-000811-Da
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 06:33:17 +0000
Received: from rv-out-0708.google.com ([209.85.198.241])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWlg0-0003NT-K4
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 06:33:17 +0000
Received: by rv-out-0708.google.com with SMTP id c5so54603rvf.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Jul 2009 23:33:07 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 30 Jul 2009 23:33:07 -0700
Message-ID: <364299f40907302333s61742580m5dba94b0a2e7afa5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Fix digsig so it passes -Wshadow
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
To: LTP list <ltp-list@lists.sourceforge.net>

clone(2) is externally defined in sched.h, and as such
testcases/kernel/security/digsig/writeexec/libwritetest.c fails to
compile with -Wall due to a shadowed declaration.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: writeexec/libwritetest.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/digsig/writeexec/libwritetest.c,v
retrieving revision 1.1
diff -u -r1.1 libwritetest.c
--- writeexec/libwritetest.c	1 Nov 2005 16:09:43 -0000	1.1
+++ writeexec/libwritetest.c	31 Jul 2009 06:30:49 -0000
@@ -9,8 +9,6 @@
 #include <dlfcn.h>
 #include <wait.h>

-int clone(int (*fn)(void *), void *child_stack, int flags, void *arg);
-
 int writer(void *data)
 {
 	int fd;

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
