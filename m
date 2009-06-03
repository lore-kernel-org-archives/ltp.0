Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1MBpuF-0008Ls-1H
	for ltp-list@lists.sourceforge.net; Wed, 03 Jun 2009 12:49:23 +0000
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145])
	by 1b2kzd1.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MBpuB-0000pN-09
	for ltp-list@lists.sourceforge.net; Wed, 03 Jun 2009 12:49:22 +0000
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 12360DB04
	for <ltp-list@lists.sourceforge.net>;
	Wed,  3 Jun 2009 12:49:15 +0000 (GMT)
Received: from mail2.ctn.st.com (mail2.ctn.st.com [164.130.116.137])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA2AE4C2B9
	for <ltp-list@lists.sourceforge.net>;
	Wed,  3 Jun 2009 12:49:14 +0000 (GMT)
Message-ID: <4A267148.8000700@st.com>
Date: Wed, 03 Jun 2009 14:49:12 +0200
From: Francesco RUNDO <francesco.rundo@st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000106000008000503020603"
Subject: [LTP] kernel/controllers/ testcase and CGROUPS support
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
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000106000008000503020603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I'd like to submit a request to change the method to check if CGROUPS 
support is enabled and available or not.

I'm referring to the kernel/controllers/xxx testcase. I'm using the 
LTP-full-20090430 cross-compiled for SH based arch with a kernel 2.6.23

The used/released  method placed inside kernel/controllers/Makefile,  
tries to understand if the cgroups (and others related...) support has 
been enabled in the current kernel, performing a check in the root 
filesystem under "/proc". It makes something like that:

CHECK_CGROUP := $(shell test -f /proc/cgroups && echo 'cgroup')

Now, in the context of LTP built for i386, the above check works fine.

But what happen if LTP is cross-built ?

Unfortunately, the "/proc" entry checked by the above Makefile rule, is 
the ones placed in the host and not the "/proc" of the  target root 
filesysetm (in my case SH based target). This is wrong!

Moreover,  "/proc" is an entry which makes sense at runtime while it is 
useless at built time so the above check is "always" not applicable in 
case of LTP is built for other arch different from i386.

In order to cover the scenario in which LTP is cross-built, I've patched 
the Makefile , replacing the above rule with the following ones:

ifdef $(CROSS_COMPILE)
CHECK_CGROUP := $(shell test -f 
$(TARGET_DIR)/usr/include/linux/cgroupstats.h && echo 'cgroup')
else
 CHECK_CGROUP := $(shell test -f /proc/cgroups && echo 'cgroup')
 CHECK_CPUCTL := $(shell grep -w cpu /proc/cgroups 2>/dev/null|cut -f1)
 CHECK_MEMCTL := $(shell grep -w memory /proc/cgroups 2>/dev/null|cut -f1)
 CHECK_BLOCKIOCTL := $(shell grep -w blockio /proc/cgroups 
2>/dev/null|cut -f1)
 CHECK_FREEZER := $(shell grep -w freezer /proc/cgroups 2>/dev/null| cut 
-f1)
 CHECK_CPUSETCTL = $(shell grep -w cpuset /proc/cgroups 2>/dev/null|cut -f1)
endif
 
ifdef $(CROSS_COMPILE)
   ifeq ($(CHECK_CGROUP),cgroup)
      SUBDIRS += cgroup
      SUBDIRS += cpuctl
      SUBDIRS += memctl
      SUBDIRS += io-throttle
      SUBDIRS += freezer
      SUBDIRS += cpuset
  else
      $(info "Kernel is not compiled with control cgroup support")
  endif
else
   ifeq ($(CHECK_CGROUP),cgroup)
        SUBDIRS += cgroup
   else
   ..............................................(the same rules placed 
in the original released Makefile).

The above checked header file "cgroupstats.h" is placed in the target 
rootfs.  If the cgroups support is available (and enabled...likely ;-) 
the above header is placed in the target rootfs. 

In that way, in case of cross-compilation (the env CROSS_COMPILE was 
defined) the check will be done in the header file instead of  /proc.

The env TARGET_DIR works like a "--prefix" fixing the path of the 
cross-target rootfs.

Of course, If you have another checks/methods which can be done to 
understand -at build time- if cgroups support is available and/or 
enabled -for target platform-, please feel free to post a comment to LTP.

Anyway, I'll attach the patch I've applied in our system.

Advices and feedbacks are welcome!

Regards
Francesco Rundo



--------------000106000008000503020603
Content-Type: text/plain; name="ltp-full-20090430-fix-cgroups-testcase.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="ltp-full-20090430-fix-cgroups-testcase.patch"

This patch allows the cross-build of kernel/controllers (cgroups tests) testcase changing the policy to check the cgroups capability at build-time.
Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
--- ltp-full-20090430-cross/testcases/kernel/controllers/Makefile.orig	2009-05-26 15:37:35.140000000 +0200
+++ ltp-full-20090430-cross/testcases/kernel/controllers/Makefile	2009-05-28 13:36:36.669998000 +0200
@@ -1,10 +1,26 @@
+ifdef $(CROSS_COMPILE)
+CHECK_CGROUP := $(shell test -f $(TARGET_DIR)/usr/include/linux/cgroupstats.h && echo 'cgroup')
+else
 CHECK_CGROUP := $(shell test -f /proc/cgroups && echo 'cgroup')
 CHECK_CPUCTL := $(shell grep -w cpu /proc/cgroups 2>/dev/null|cut -f1)
 CHECK_MEMCTL := $(shell grep -w memory /proc/cgroups 2>/dev/null|cut -f1)
 CHECK_BLOCKIOCTL := $(shell grep -w blockio /proc/cgroups 2>/dev/null|cut -f1)
 CHECK_FREEZER := $(shell grep -w freezer /proc/cgroups 2>/dev/null| cut -f1)
 CHECK_CPUSETCTL = $(shell grep -w cpuset /proc/cgroups 2>/dev/null|cut -f1)
+endif
 
+ifdef $(CROSS_COMPILE)
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

--------------000106000008000503020603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
--------------000106000008000503020603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------000106000008000503020603--


