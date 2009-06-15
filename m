Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MGHwG-0000r4-In
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:33:52 +0000
Received: from [32.97.110.150] (helo=e32.co.us.ibm.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGHvu-0004Hx-Sm
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:33:32 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5FJDbRU013131
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:13:37 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5FJHJOZ148954
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:17:20 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5FJHFLZ023524
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:17:16 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A30B95F.4090903@st.com>
References: <4A267148.8000700@st.com>
	<1244114998.4879.25.camel@subratamodak.linux.ibm.com>
	<4A30B95F.4090903@st.com>
Date: Tue, 16 Jun 2009 00:46:30 +0530
Message-Id: <1245093390.4871.50.camel@subratamodak.linux.ibm.com>
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

On Thu, 2009-06-11 at 09:59 +0200, Francesco RUNDO wrote:
> Hi Subrata,
> 
> please, replace on the LTP main the previous patch with ones attached.
> The attached patch add the right labels of ifdef.

Ok. I reverted the earlier one and applied this one. Please check the
CVS and let me know if everything is fine.

Regards--
Subrata

> 
> Sorry for that.
> 
> Thanks in advance.
> --
> Francesco Rundo
> 
> Subrata Modak wrote: 
> > On Wed, 2009-06-03 at 14:49 +0200, Francesco RUNDO wrote:
> >   
> > > This patch allows the cross-build of kernel/controllers (cgroups
> > > tests) testcase changing the policy to check the cgroups capability at
> > > build-time.
> > > Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
> > >     
> > 
> > Great if that helps your CROSS_COMPILE environment. Merged.
> > 
> > Regards--
> > Subrata
> > 
> >   
> > > ---
> > > ltp-full-20090430-cross/testcases/kernel/controllers/Makefile.orig  2009-05-26 15:37:35.140000000 +0200
> > > +++
> > > ltp-full-20090430-cross/testcases/kernel/controllers/Makefile       2009-05-28 13:36:36.669998000 +0200
> > > @@ -1,10 +1,26 @@
> > > +ifdef $(CROSS_COMPILE)
> > > +CHECK_CGROUP := $(shell test -f
> > > $(TARGET_DIR)/usr/include/linux/cgroupstats.h && echo 'cgroup')
> > > +else
> > >  CHECK_CGROUP := $(shell test -f /proc/cgroups && echo 'cgroup')
> > >  CHECK_CPUCTL := $(shell grep -w cpu /proc/cgroups 2>/dev/null|cut
> > > -f1)
> > >  CHECK_MEMCTL := $(shell grep -w memory /proc/cgroups 2>/dev/null|cut
> > > -f1)
> > >  CHECK_BLOCKIOCTL := $(shell grep -w blockio /proc/cgroups
> > > 2>/dev/null|cut -f1)
> > >  CHECK_FREEZER := $(shell grep -w freezer /proc/cgroups 2>/dev/null|
> > > cut -f1)
> > >  CHECK_CPUSETCTL = $(shell grep -w cpuset /proc/cgroups 2>/dev/null|
> > > cut -f1)
> > > +endif
> > > 
> > > +ifdef $(CROSS_COMPILE)
> > > +ifeq ($(CHECK_CGROUP),cgroup)
> > > +SUBDIRS += cgroup
> > > +SUBDIRS += cpuctl
> > > +SUBDIRS += memctl
> > > +SUBDIRS += io-throttle
> > > +SUBDIRS += freezer
> > > +SUBDIRS += cpuset
> > > +else
> > > +$(info "Kernel is not compiled with control cgroup support")
> > > +endif
> > > +else
> > >  ifeq ($(CHECK_CGROUP),cgroup)
> > >  SUBDIRS += cgroup
> > >  else
> > > @@ -36,6 +52,7 @@
> > >  else
> > >  $(info "Kernel is not compiled with cpuset resource controller
> > > support")
> > >  endif
> > > +endif
> > > 
> > >  # If at least one of the controllers is available then build
> > > libcontrollers.
> > >  ifneq ($(SUBDIRS),)
> > >     
> > 
> > 
> >   
> plain text document attachment
> (ltp-full-20090430-fix-cgroups-testcase.patch)
> This patch allows the cross-build of kernel/controllers (cgroups tests) testcase changing the policy to check the cgroups capability at build-time.
> Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
> --- ltp-full-20090430-cross/testcases/kernel/controllers/Makefile.orig	2009-05-26 15:37:35.140000000 +0200
> +++ ltp-full-20090430-cross/testcases/kernel/controllers/Makefile	2009-05-28 13:36:36.669998000 +0200
> @@ -1,10 +1,26 @@
> +ifdef CROSS_COMPILE
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
> +ifdef CROSS_COMPILE
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


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
