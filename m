Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NSZWZ-00080W-6c
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 17:18:23 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSZWV-00067A-V3
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 17:18:22 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o06H61L0021501
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Jan 2010 12:06:01 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o06HICsY1925288
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Jan 2010 12:18:12 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o06HICaJ002026
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Jan 2010 15:18:12 -0200
Date: Wed, 6 Jan 2010 11:18:12 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100106171812.GA15444@us.ibm.com>
References: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [LTP] regression:  selinux testsuite broken since October
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list@lists.sourceforge.net, James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> It seems the Makefile rewrite last October broke the selinux testsuite.
> Is it unreasonable to expect that someone who rewrote the Makefile would
> actually try running the testsuite?
> 
> Please, revert the changes or fix them.
> 
> See testcases/kernel/security/selinux-testsuite/README for the
> instructions.

Seems I have a part in breakage as well.  Here are patches to get the
execshare_parent to compile.

Now to get the policy to compile...

--- ltp-full-20091231.orig/testcases/kernel/security/selinux-testsuite/tests/execshare/selinux_execshare_parent.c	2009-11-03 15:07:35.000000000 -0500
+++ ltp-full-20091231/testcases/kernel/security/selinux-testsuite/tests/execshare/selinux_execshare_parent.c	2010-01-06 11:58:47.000000000 -0500
@@ -18,9 +18,12 @@
 #include <selinux/selinux.h>
 #include <selinux/context.h>
 #include <sched.h>
+#include <test.h>
 
-int clone_fn(char **argv)
+int clone_fn(void *in)
 {
+	char **argv = (char **) in;
+
 	execv(argv[3], argv+3);
 	perror(argv[3]);
 	return -1;
@@ -73,7 +76,7 @@ int main(int argc, char **argv)
 		fprintf(stderr, "%s:  unable to set exec context to %s\n", argv[0], context_s);
 		exit(-1);
 	}
-	pid = ltp_clone_quick(cloneflags | SIGCHLD, child_fn, argv);
+	pid = ltp_clone_quick(cloneflags | SIGCHLD, clone_fn, argv);
 	if (pid < 0) {
 		perror("clone");
 		exit(-1);

--- ltp-full-20091231.orig/testcases/kernel/security/selinux-testsuite/tests/execshare/Makefile	2009-10-09 13:55:51.000000000 -0400
+++ ltp-full-20091231/testcases/kernel/security/selinux-testsuite/tests/execshare/Makefile	2010-01-06 11:53:53.000000000 -0500
@@ -25,6 +25,6 @@ top_srcdir              ?= ../../../../.
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS			+= -lselinux
+LDLIBS			+= -lselinux -lltp
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
