Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MC9El-0006Cr-DM
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2009 09:27:51 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MC9Ef-000588-So
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2009 09:27:51 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n549NYsT027519
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Jun 2009 03:23:34 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n549RjcT261772
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Jun 2009 03:27:45 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n549RjOx029679
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Jun 2009 03:27:45 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A267148.8000700@st.com>
References: <4A267148.8000700@st.com>
Date: Thu, 04 Jun 2009 14:57:39 +0530
Message-Id: <1244107659.4879.13.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] kernel/controllers/ testcase and CGROUPS support
Reply-To: subrata@linux.vnet.ibm.com
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
To: Francesco RUNDO <francesco.rundo@st.com>
Cc: ltp-list@lists.sourceforge.net

I will look into this.

Regards--
Subrata

On Wed, 2009-06-03 at 14:49 +0200, Francesco RUNDO wrote: 
> Hi All,
> 
> I'd like to submit a request to change the method to check if CGROUPS 
> support is enabled and available or not.
> 
> I'm referring to the kernel/controllers/xxx testcase. I'm using the 
> LTP-full-20090430 cross-compiled for SH based arch with a kernel 2.6.23
> 
> The used/released  method placed inside kernel/controllers/Makefile,  
> tries to understand if the cgroups (and others related...) support has 
> been enabled in the current kernel, performing a check in the root 
> filesystem under "/proc". It makes something like that:
> 
> CHECK_CGROUP := $(shell test -f /proc/cgroups && echo 'cgroup')
> 
> Now, in the context of LTP built for i386, the above check works fine.
> 
> But what happen if LTP is cross-built ?
> 
> Unfortunately, the "/proc" entry checked by the above Makefile rule, is 
> the ones placed in the host and not the "/proc" of the  target root 
> filesysetm (in my case SH based target). This is wrong!
> 
> Moreover,  "/proc" is an entry which makes sense at runtime while it is 
> useless at built time so the above check is "always" not applicable in 
> case of LTP is built for other arch different from i386.
> 
> In order to cover the scenario in which LTP is cross-built, I've patched 
> the Makefile , replacing the above rule with the following ones:
> 
> ifdef $(CROSS_COMPILE)
> CHECK_CGROUP := $(shell test -f 
> $(TARGET_DIR)/usr/include/linux/cgroupstats.h && echo 'cgroup')
> else
>  CHECK_CGROUP := $(shell test -f /proc/cgroups && echo 'cgroup')
>  CHECK_CPUCTL := $(shell grep -w cpu /proc/cgroups 2>/dev/null|cut -f1)
>  CHECK_MEMCTL := $(shell grep -w memory /proc/cgroups 2>/dev/null|cut -f1)
>  CHECK_BLOCKIOCTL := $(shell grep -w blockio /proc/cgroups 
> 2>/dev/null|cut -f1)
>  CHECK_FREEZER := $(shell grep -w freezer /proc/cgroups 2>/dev/null| cut 
> -f1)
>  CHECK_CPUSETCTL = $(shell grep -w cpuset /proc/cgroups 2>/dev/null|cut -f1)
> endif
> 
> ifdef $(CROSS_COMPILE)
>    ifeq ($(CHECK_CGROUP),cgroup)
>       SUBDIRS += cgroup
>       SUBDIRS += cpuctl
>       SUBDIRS += memctl
>       SUBDIRS += io-throttle
>       SUBDIRS += freezer
>       SUBDIRS += cpuset
>   else
>       $(info "Kernel is not compiled with control cgroup support")
>   endif
> else
>    ifeq ($(CHECK_CGROUP),cgroup)
>         SUBDIRS += cgroup
>    else
>    ..............................................(the same rules placed 
> in the original released Makefile).
> 
> The above checked header file "cgroupstats.h" is placed in the target 
> rootfs.  If the cgroups support is available (and enabled...likely ;-) 
> the above header is placed in the target rootfs. 
> 
> In that way, in case of cross-compilation (the env CROSS_COMPILE was 
> defined) the check will be done in the header file instead of  /proc.
> 
> The env TARGET_DIR works like a "--prefix" fixing the path of the 
> cross-target rootfs.
> 
> Of course, If you have another checks/methods which can be done to 
> understand -at build time- if cgroups support is available and/or 
> enabled -for target platform-, please feel free to post a comment to LTP.
> 
> Anyway, I'll attach the patch I've applied in our system.
> 
> Advices and feedbacks are welcome!
> 
> Regards
> Francesco Rundo
> 
> 
> plain text document attachment
> (ltp-full-20090430-fix-cgroups-testcase.patch)
> This patch allows the cross-build of kernel/controllers (cgroups tests) testcase changing the policy to check the cgroups capability at build-time.
> Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
> --- ltp-full-20090430-cross/testcases/kernel/controllers/Makefile.orig	2009-05-26 15:37:35.140000000 +0200
> +++ ltp-full-20090430-cross/testcases/kernel/controllers/Makefile	2009-05-28 13:36:36.669998000 +0200
> @@ -1,10 +1,26 @@
> +ifdef $(CROSS_COMPILE)
> +CHECK_CGROUP := $(shell test -f $(TARGET_DIR)/usr/include/linux/cgroupstats.h && echo 'cgroup')
> +else
>  CHECK_CGROUP := $(shell test -f /proc/cgroups && echo 'cgroup')
>  CHECK_CPUCTL := $(shell grep -w cpu /proc/cgroups 2>/dev/null|cut -f1)
>  CHECK_MEMCTL := $(shell grep -w memory /proc/cgroups 2>/dev/null|cut -f1)
>  CHECK_BLOCKIOCTL := $(shell grep -w blockio /proc/cgroups 2>/dev/null|cut -f1)
>  CHECK_FREEZER := $(shell grep -w freezer /proc/cgroups 2>/dev/null| cut -f1)
>  CHECK_CPUSETCTL = $(shell grep -w cpuset /proc/cgroups 2>/dev/null|cut -f1)
> +endif
> 
> +ifdef $(CROSS_COMPILE)
> +ifeq ($(CHECK_CGROUP),cgroup)
> +SUBDIRS += cgroup
> +SUBDIRS += cpuctl
> +SUBDIRS += memctl
> +SUBDIRS += io-throttle
> +SUBDIRS += freezer
> +SUBDIRS += cpuset
> +else
> +$(info "Kernel is not compiled with control cgroup support")
> +endif
> +else
>  ifeq ($(CHECK_CGROUP),cgroup)
>  SUBDIRS += cgroup
>  else
> @@ -36,6 +52,7 @@
>  else
>  $(info "Kernel is not compiled with cpuset resource controller support")
>  endif
> +endif
> 
>  # If at least one of the controllers is available then build libcontrollers.
>  ifneq ($(SUBDIRS),)
> ------------------------------------------------------------------------------
> OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
> looking to deploy the next generation of Solaris that includes the latest 
> innovations from Sun and the OpenSource community. Download a copy and 
> enjoy capabilities such as Networking, Storage and Virtualization. 
> Go to: http://p.sf.net/sfu/opensolaris-get
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
