Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mf7Vw-0002iL-5D
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:29:20 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mf7Vr-0004Ju-Bz
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:29:20 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7N7PSE7031393
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:25:28 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7N7T9xm132388
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:29:09 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7N7T9Oj019799
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:29:09 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40908201001q30e8859t85aa3cd38205872e@mail.gmail.com>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
	<20090820160741.30926.293.sendpatchset@localhost.localdomain>
	<364299f40908201001q30e8859t85aa3cd38205872e@mail.gmail.com>
Date: Sun, 23 Aug 2009 12:58:54 +0530
Message-Id: <1251012535.16822.35.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Patch for PM makefile for new testcases &
	fix	test_sched_smt integration issue
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, vaidy <svaidy@linux.vnet.ibm.com>, gautham <ego@in.ibm.com>

On Thu, 2009-08-20 at 10:01 -0700, Garrett Cooper wrote: 
> On Thu, Aug 20, 2009 at 9:07 AM, Poornima
> Nayak<mpnayak@linux.vnet.ibm.com> wrote:
> > Patch to integrate test_sched_smt and timer_migration testcase to LTP.
> > Also intergrates the new file get_sched_value to LTP.
> >
> > Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
> >
> > diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/Makefile ltp-full-20090731/testcases/kernel/power_management/Makefile
> > --- ltp-full-20090731_orig/testcases/kernel/power_management/Makefile   2009-08-20 19:59:11.000000000 +0530
> > +++ ltp-full-20090731/testcases/kernel/power_management/Makefile        2009-08-20 20:26:39.000000000 +0530
> > @@ -23,12 +23,16 @@ SUBDIRS :=
> >  all:
> >        @set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
> >        $(MAKE) check_kv_arch ;
> > +       $(MAKE) get_sched_values ;
> >
> > -check_kv_arch: check_kv_arch.c
> > +check_kv_arch: check_kv_arch.c
> > +       $(CC) -o $@ $< ../../../lib/tst_kvercmp.c -I../../../include
> > +get_sched_values: get_sched_values.c
> >        $(CC) -o $@ $< ../../../lib/tst_kvercmp.c -I../../../include
> >
> >  install:
> >        @set -e; ln -f check_kv_arch ../../bin/check_kv_arch; \
> > +       ln -f get_sched_values ../../bin/get_sched_values; \
> >        ln -f  change_freq.sh ../../bin/change_freq.sh; \
> >        ln -f  change_govr.sh ../../bin/change_govr.sh; \
> >        ln -f  check_cpufreq_sysfs_files.sh ../../bin/check_cpufreq_sysfs_files.sh; \
> > @@ -37,6 +41,8 @@ install:
> >        ln -f  pm_include.sh ../../bin/pm_include.sh; \
> >        ln -f  runpwtests.sh ../../bin/runpwtests.sh; \
> >        ln -f  test_sched_mc.sh ../../bin/test_sched_mc.sh; \
> > +       ln -f  test_sched_mc.sh ../../bin/test_sched_smt.sh; \
> > +       ln -f  test_sched_mc.sh ../../bin/test_timer_migration.sh; \
> >        ln -f  config_cpu_freq ../../bin/config_cpu_freq; \
> >        ln -f  config_cpu_idle ../../bin/config_cpu_idle; \
> >        ln -f  config_sched_mc ../../bin/config_sched_mc;
> > @@ -47,4 +53,4 @@ install:
> >  clean:
> >        @set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ; done
> >        rm -f check_kv_arch
> > -
> > +       rm -f get_sched_values
> 
> Please don't worry about this. It's handled in my makefile-infra-rework patch.

I checked this till the Makefile work gets in.

Regards--
Subrata

> Thanks,
> -Garrett
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
