Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1MNmzm-0006fI-Bg
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 12:08:30 +0000
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129])
	by 3b2kzd1.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNmzi-0001aE-BJ
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 12:08:30 +0000
Message-ID: <4A51E253.200@st.com>
Date: Mon, 06 Jul 2009 13:38:59 +0200
From: Francesco RUNDO <francesco.rundo@st.com>
MIME-Version: 1.0
References: <4A51CEDC.6080605@linux.vnet.ibm.com>
In-Reply-To: <4A51CEDC.6080605@linux.vnet.ibm.com>
Content-Type: multipart/mixed; boundary="------------070003010109060207000203"
Subject: Re: [LTP] [PATCH] cgroups: conditionally enable building cgroup
	tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: gowrishankar <gomuthuk@linux.vnet.ibm.com>
Cc: ltp-list@lists.sf.net

This is a multi-part message in MIME format.
--------------070003010109060207000203
Content-Type: multipart/alternative;
	boundary="------------050104000708000209040507"


--------------050104000708000209040507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gowri,

I've already fixed the same issue you reported. I've tested it successfully.

Subrata has already merged my patch (please, find it in attachment).

Please, check it before to submit another patch.

Thanks
Regards
Francesco Rundo

gowrishankar wrote:

> Hi Subrata,
> Please accept the patch below.
>
> Thanks,
> Gowri
> ---
> cgroups: conditionally enable building cgroup tests
>
> controllers tests gets included into default ltp build if "/proc/cgroup"
> exists. It stops the ltp build in realtime kernel environment where 
> kernel
> is new and supports cgroups, but necessary file "linux/cgroupstats.h" 
> may not
> exist in the base OS (like RHEL5.3). So configure command enables the 
> build,
> but actual build fails, due to missing header file.
>
> Below patch proposes new symbol LTP_CHECK_CGROUPSTATS to check for 
> header file
> "linux/cgroupstats.h" and include controllers in the list of tests to 
> build.
>
> Tested the patch in non-RT as well as RT environment for the changes.
>
> Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
> Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
> ---
>
>------------------------------------------------------------------------
>
>Index: ltp-full-20090630/m4/ltp-cgroupstats.m4
>===================================================================
>--- /dev/null	1970-01-01 00:00:00.000000000 +0000
>+++ ltp-full-20090630/m4/ltp-cgroupstats.m4	2009-07-03 13:41:55.000000000 +0530
>@@ -0,0 +1,9 @@
>+dnl
>+dnl LTP_CHECK_CGROUPSTATS
>+dnl ----------------------------
>+dnl
>+AC_DEFUN([LTP_CHECK_CGROUPSTATS],
>+[dnl
>+AC_CHECK_HEADERS(linux/cgroupstats.h,[LTP_CHECK_CGROUPSTATS_HEADER=yes])
>+AC_SUBST(LTP_CHECK_CGROUPSTATS_HEADER)
>+])
>Index: ltp-full-20090630/configure.ac
>===================================================================
>--- ltp-full-20090630.orig/configure.ac	2009-07-03 13:59:48.000000000 +0530
>+++ ltp-full-20090630/configure.ac	2009-07-03 14:00:14.000000000 +0530
>@@ -21,5 +21,6 @@
> LTP_CHECK_SELINUX
> LTP_CHECK_CRYPTO
> LTP_CHECK_TASKSTATS
>+LTP_CHECK_CGROUPSTATS
> 
> AC_OUTPUT
>Index: ltp-full-20090630/testcases/kernel/Makefile
>===================================================================
>--- ltp-full-20090630.orig/testcases/kernel/Makefile	2009-07-03 14:01:25.000000000 +0530
>+++ ltp-full-20090630/testcases/kernel/Makefile	2009-07-03 14:02:42.000000000 +0530
>@@ -1,6 +1,12 @@
>-SUBDIRS = power_management numa containers controllers connectors include fs io ipc mem pty sched security syscalls timers
>+include ../../config.mk
>+
>+SUBDIRS = power_management numa containers connectors include fs io ipc mem pty sched security syscalls timers
> UCLINUX_SUBDIRS = include syscalls
> 
>+ifeq ($(LTP_CHECK_CGROUPSTATS_HEADER),yes)
>+	SUBDIRS+= controllers
>+endif
>+
> all:
> 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
> 
>  
>
>------------------------------------------------------------------------
>
>------------------------------------------------------------------------------
>  
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Ltp-list mailing list
>Ltp-list@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/ltp-list
>  
>

--------------050104000708000209040507
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Hi Gowri,<br>
<br>
I've already fixed the same issue you reported. I've tested it
successfully.<br>
<br>
Subrata has already merged my patch (please, find it in attachment).<br>
<br>
Please, check it before to submit another patch.<br>
<br>
Thanks<br>
Regards<br>
Francesco Rundo<br>
<br>
gowrishankar wrote:<br>
<blockquote type="cite" cite="mid4A51CEDC.6080605@linux.vnet.ibm.com">Hi
Subrata,
  <br>
Please accept the patch below.
  <br>
  <br>
Thanks,
  <br>
Gowri
  <br>
---
  <br>
cgroups: conditionally enable building cgroup tests
  <br>
  <br>
controllers tests gets included into default ltp build if
"/proc/cgroup"
  <br>
exists. It stops the ltp build in realtime kernel environment where
kernel
  <br>
is new and supports cgroups, but necessary file "linux/cgroupstats.h"
may not
  <br>
exist in the base OS (like RHEL5.3). So configure command enables the
build,
  <br>
but actual build fails, due to missing header file.
  <br>
  <br>
Below patch proposes new symbol LTP_CHECK_CGROUPSTATS to check for
header file
  <br>
"linux/cgroupstats.h" and include controllers in the list of tests to
build.
  <br>
  <br>
Tested the patch in non-RT as well as RT environment for the changes.
  <br>
  <br>
Signed-off-by: Gowrishankar <a class="moz-txt-link-rfc2396E" href="mailto:gowrishankar.m@in.ibm.com">&lt;gowrishankar.m@in.ibm.com&gt;</a>
  <br>
Tested-by: Gowrishankar <a class="moz-txt-link-rfc2396E" href="mailto:gowrishankar.m@in.ibm.com">&lt;gowrishankar.m@in.ibm.com&gt;</a>
  <br>
---
  <br>
  <br>
  <pre wrap="">
<hr width="90%" size="4">
Index: ltp-full-20090630/m4/ltp-cgroupstats.m4
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ ltp-full-20090630/m4/ltp-cgroupstats.m4	2009-07-03 13:41:55.000000000 +0530
@@ -0,0 +1,9 @@
+dnl
+dnl LTP_CHECK_CGROUPSTATS
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_CGROUPSTATS],
+[dnl
+AC_CHECK_HEADERS(linux/cgroupstats.h,[LTP_CHECK_CGROUPSTATS_HEADER=yes])
+AC_SUBST(LTP_CHECK_CGROUPSTATS_HEADER)
+])
Index: ltp-full-20090630/configure.ac
===================================================================
--- ltp-full-20090630.orig/configure.ac	2009-07-03 13:59:48.000000000 +0530
+++ ltp-full-20090630/configure.ac	2009-07-03 14:00:14.000000000 +0530
@@ -21,5 +21,6 @@
 LTP_CHECK_SELINUX
 LTP_CHECK_CRYPTO
 LTP_CHECK_TASKSTATS
+LTP_CHECK_CGROUPSTATS
 
 AC_OUTPUT
Index: ltp-full-20090630/testcases/kernel/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/Makefile	2009-07-03 14:01:25.000000000 +0530
+++ ltp-full-20090630/testcases/kernel/Makefile	2009-07-03 14:02:42.000000000 +0530
@@ -1,6 +1,12 @@
-SUBDIRS = power_management numa containers controllers connectors include fs io ipc mem pty sched security syscalls timers
+include ../../config.mk
+
+SUBDIRS = power_management numa containers connectors include fs io ipc mem pty sched security syscalls timers
 UCLINUX_SUBDIRS = include syscalls
 
+ifeq ($(LTP_CHECK_CGROUPSTATS_HEADER),yes)
+	SUBDIRS+= controllers
+endif
+
 all:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
 
  </pre>
  <pre wrap="">
<hr width="90%" size="4">
------------------------------------------------------------------------------
  </pre>
  <pre wrap="">
<hr width="90%" size="4">
_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
  </pre>
</blockquote>
</body>
</html>

--------------050104000708000209040507--

--------------070003010109060207000203
Content-Type: text/plain; name="ltp-full-20090430-fix-cgroups-testcase.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="ltp-full-20090430-fix-cgroups-testcase.patch"

This patch allows the cross-build of kernel/controllers (cgroups tests) testcase changing the policy to check the cgroups capability at build-time.
Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
--- ltp-full-20090430-cross/testcases/kernel/controllers/Makefile.orig	2009-05-26 15:37:35.140000000 +0200
+++ ltp-full-20090430-cross/testcases/kernel/controllers/Makefile	2009-05-28 13:36:36.669998000 +0200
@@ -1,10 +1,26 @@
+ifdef CROSS_COMPILE
+CHECK_CGROUP := $(shell test -f $(TARGET_DIR)/usr/include/linux/cgroupstats.h && echo 'cgroup')
+else
 CHECK_CGROUP := $(shell test -f /proc/cgroups && echo 'cgroup')
 CHECK_CPUCTL := $(shell grep -w cpu /proc/cgroups 2>/dev/null|cut -f1)
 CHECK_MEMCTL := $(shell grep -w memory /proc/cgroups 2>/dev/null|cut -f1)
 CHECK_BLOCKIOCTL := $(shell grep -w blockio /proc/cgroups 2>/dev/null|cut -f1)
 CHECK_FREEZER := $(shell grep -w freezer /proc/cgroups 2>/dev/null| cut -f1)
 CHECK_CPUSETCTL = $(shell grep -w cpuset /proc/cgroups 2>/dev/null|cut -f1)
+endif
 
+ifdef CROSS_COMPILE
+ifeq ($(CHECK_CGROUP),cgroup)
+SUBDIRS += cgroup
+SUBDIRS += cpuctl
+SUBDIRS += memctl
+SUBDIRS += io-throttle
+SUBDIRS += freezer
+SUBDIRS += cpuset
+else
+$(info "Kernel is not compiled with control cgroup support")
+endif
+else
 ifeq ($(CHECK_CGROUP),cgroup)
 SUBDIRS += cgroup
 else
@@ -36,6 +52,7 @@
 else
 $(info "Kernel is not compiled with cpuset resource controller support")
 endif
+endif
 
 # If at least one of the controllers is available then build libcontrollers.
 ifneq ($(SUBDIRS),)

--------------070003010109060207000203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--------------070003010109060207000203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070003010109060207000203--


