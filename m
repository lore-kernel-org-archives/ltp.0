Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <atrajeev@linux.vnet.ibm.com>) id 1RrjdU-00040S-4f
	for ltp-list@lists.sourceforge.net; Mon, 30 Jan 2012 05:18:36 +0000
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RrjdS-0000ZY-C5
	for ltp-list@lists.sourceforge.net; Mon, 30 Jan 2012 05:18:36 +0000
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <atrajeev@linux.vnet.ibm.com>;
	Mon, 30 Jan 2012 05:02:34 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	q0U5DCCr3420356
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jan 2012 16:13:13 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	q0U5Hxa4028110
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jan 2012 16:18:00 +1100
Message-ID: <4F262804.9020508@linux.vnet.ibm.com>
Date: Mon, 30 Jan 2012 10:47:56 +0530
From: Athira <atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] Filecaps tests not getting built along with ltp
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
To: yanegomi@gmail.com, ltp-list@lists.sourceforge.net

Hi Garrett,

There are two commits for filecaps test in ltp as below:

1.
http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp.git;a=commitdiff;h=4f71cae2e9c35b08626626aa9a5a063cb2972f64 

2.
http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp.git;a=commitdiff;h=183c6e447406baa67c4dc109c060bd019ed7e850 


I am not able to get filecpas tests built along with ltp applying these 
commits.

I didnt understand the change from "setcap" to "capset"
for AC_CHECK_PROG in the below diff in the first commit:
http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp.git;a=commitdiff;h=4f71cae2e9c35b08626626aa9a5a063cb2972f64 


diff --git a/m4/ltp-cap.m4 b/m4/ltp-cap.m4
index caa436f..ede30bb 100644 (file)
--- a/m4/ltp-cap.m4
+++ b/m4/ltp-cap.m4
@@ -27,8 +27,12 @@ AH_TEMPLATE(HAVE_LIBCAP,
  [Define to 1 if you have libcap-2 installed.])
  AC_CHECK_HEADERS(sys/capability.h,[
         LTP_CAPABILITY_SUPPORT=yes
-       AC_CHECK_LIB(cap,cap_compare,[AC_DEFINE(HAVE_LIBCAP) 
CAP_LIBS="-lcap"],
[CAP_LIBS=""])
-       AC_CHECK_PROG(HAVE_SETCAP,setcap,setcap,false)
-])]
-AC_SUBST(CAP_LIBS)
-)
+       AC_CHECK_LIB(cap,cap_compare,[AC_DEFINE(HAVE_LIBCAP) 
cap_libs="-lcap"])
+       AC_CHECK_PROG(HAVE_SETCAP,capset,[have_capset="yes"])
+])
+if test "x$have_capset" != xyes; then
+       have_capset=no
+fi
+AC_SUBST(CAP_LIBS,$cap_libs)
+AC_SUBST(HAVE_CAPSET,$have_capset)
+])


The program to set file capablities is "setcap",
whereas capset is to set the capabilities of thread.

The expansion of macro AC_CHECK_PROG:
Macro: AC_CHECK_PROG (variable, prog-to-check-for, value-if-found,
[value-if-not-found], [path], [reject])
     Check whether program prog-to-check-for exists in PATH. If it is 
found, set
variable to value-if-found, otherwise to value-if-not-found, if given.

There is no program "capset" in $PATH, instead setcap exists.
Was it a mistake? Would like to know the reason for that change.

Also in testcases/kernel/security/Makefile

--- a/testcases/kernel/security/Makefile
+++ b/testcases/kernel/security/Makefile
@@ -29,7 +29,7 @@ include       $(top_srcdir)/include/mk/env_pre.mk
  ifeq ($(strip $(CAP_LIBS)),)
  FILTER_OUT_DIRS                := cap_bound filecaps securebits
  endif
-ifneq ($(HAVE_SETCAP),yes)
+ifeq ($(strip $(SETCAP)),)
  FILTER_OUT_DIRS                += filecaps
  endif
  ifneq ($(HAVE_SECUREBITS),yes)


There is no variable named "SETCAP" in the configure script,
instead it is CAPSET, which comes from the macro:
"AC_CHECK_PROG(CAPSET,capset,capset)"
in m4/ltp-cap.m4.
So I feel the variable in Makefile should be CAPSET.

Because of this, the filecaps test is not getting built along with ltp.

I am able to get the filecaps test built along with ltp by making 
changes below,
running "autoconf" to create configure script and then built the ltp.

--- testcases/kernel/security/Makefile.org    2011-12-28 
14:48:44.376719618 +0530
+++ testcases/kernel/security/Makefile    2011-12-28 14:47:55.220811859 
+0530
@@ -29,7 +29,7 @@ include    $(top_srcdir)/include/mk/env_pre
  ifeq ($(strip $(CAP_LIBS)),)
  FILTER_OUT_DIRS        := cap_bound filecaps securebits
  endif
-ifeq ($(strip $(SETCAP)),)
+ifeq ($(strip $(CAPSET)),)
  FILTER_OUT_DIRS        += filecaps
  endif
  ifneq ($(HAVE_SECUREBITS),yes)


--- m4/ltp-cap.m4.org    2011-12-28 14:46:59.797917296 +0530
+++ m4/ltp-cap.m4    2011-12-28 14:47:17.353883733 +0530
@@ -29,7 +29,7 @@ AH_TEMPLATE(HAVE_LIBCAP,
  AC_CHECK_HEADERS([sys/capability.h],[capability_header_prefix="sys"])
  if test "x$capability_header_prefix" != x; then
      AC_CHECK_LIB(cap,cap_compare,[cap_libs="-lcap"])
-    AC_CHECK_PROG(CAPSET,capset,capset)
+    AC_CHECK_PROG(CAPSET,setcap,capset)
  fi
  if test "x$cap_libs" != x; then
      AC_DEFINE(HAVE_LIBCAP)


Please correct if I am wrong.

Thanks,
Athira Rajeev


------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
