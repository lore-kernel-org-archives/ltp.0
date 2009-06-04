Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MCB97-0002qF-F8
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2009 11:30:09 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MCB90-0002ke-RJ
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2009 11:30:04 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n54BPLiY013177
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Jun 2009 07:25:21 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n54BU2Dl257872
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Jun 2009 07:30:02 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n54BU2aA017095
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Jun 2009 07:30:02 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A267148.8000700@st.com>
References: <4A267148.8000700@st.com>
Date: Thu, 04 Jun 2009 16:59:57 +0530
Message-Id: <1244114998.4879.25.camel@subratamodak.linux.ibm.com>
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

On Wed, 2009-06-03 at 14:49 +0200, Francesco RUNDO wrote:
> This patch allows the cross-build of kernel/controllers (cgroups
> tests) testcase changing the policy to check the cgroups capability at
> build-time.
> Signed-off-by: Francesco Rundo <francesco.rundo@st.com>

Great if that helps your CROSS_COMPILE environment. Merged.

Regards--
Subrata

> ---
> ltp-full-20090430-cross/testcases/kernel/controllers/Makefile.orig  2009-05-26 15:37:35.140000000 +0200
> +++
> ltp-full-20090430-cross/testcases/kernel/controllers/Makefile       2009-05-28 13:36:36.669998000 +0200
> @@ -1,10 +1,26 @@
> +ifdef $(CROSS_COMPILE)
> +CHECK_CGROUP := $(shell test -f
> $(TARGET_DIR)/usr/include/linux/cgroupstats.h && echo 'cgroup')
> +else
>  CHECK_CGROUP := $(shell test -f /proc/cgroups && echo 'cgroup')
>  CHECK_CPUCTL := $(shell grep -w cpu /proc/cgroups 2>/dev/null|cut
> -f1)
>  CHECK_MEMCTL := $(shell grep -w memory /proc/cgroups 2>/dev/null|cut
> -f1)
>  CHECK_BLOCKIOCTL := $(shell grep -w blockio /proc/cgroups
> 2>/dev/null|cut -f1)
>  CHECK_FREEZER := $(shell grep -w freezer /proc/cgroups 2>/dev/null|
> cut -f1)
>  CHECK_CPUSETCTL = $(shell grep -w cpuset /proc/cgroups 2>/dev/null|
> cut -f1)
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
>  $(info "Kernel is not compiled with cpuset resource controller
> support")
>  endif
> +endif
> 
>  # If at least one of the controllers is available then build
> libcontrollers.
>  ifneq ($(SUBDIRS),)


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
