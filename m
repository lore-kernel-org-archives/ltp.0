Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mf7WA-0002jR-G8
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:29:34 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mf7W4-00027N-75
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:29:34 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7N7RcUQ008417
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:27:38 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7N7TMgW227260
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:29:22 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7N7TMbp018213
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:29:22 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40908200957x659a4113y19b97cc6cb60d5c0@mail.gmail.com>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
	<20090820160809.30926.5725.sendpatchset@localhost.localdomain>
	<364299f40908200957x659a4113y19b97cc6cb60d5c0@mail.gmail.com>
Date: Sun, 23 Aug 2009 12:59:02 +0530
Message-Id: <1251012542.16822.37.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] New testcase to test timer_migration interface
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
To: Garrett Cooper <yanegomi@gmail.com>, Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, vaidy <svaidy@linux.vnet.ibm.com>, gautham <ego@in.ibm.com>, arun@linux.vnet.ibm.com

On Thu, 2009-08-20 at 09:57 -0700, Garrett Cooper wrote: 
> On Thu, Aug 20, 2009 at 9:08 AM, Poornima
> Nayak<mpnayak@linux.vnet.ibm.com> wrote:
> > This is the new tescase to test timer migration interface.
> >
> > Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
> >
> > diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/test_timer_migration.sh ltp-full-20090731/testcases/kernel/power_management/test_timer_migration.sh
> > --- ltp-full-20090731_orig/testcases/kernel/power_management/test_timer_migration.sh    1970-01-01 05:30:00.000000000 +0530
> > +++ ltp-full-20090731/testcases/kernel/power_management/test_timer_migration.sh 2009-08-20 20:49:48.000000000 +0530
> > @@ -0,0 +1,22 @@
> > +#!/bin/bash
> > +
> > +. pm_include.sh
> > +
> > +valid_input="0 1"
> > +invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
> > +200000000000000000000000000000000000000000000000000000000000000000000000000000
> > +ox324 -0xfffffffffffffffffffff"
> > +test_file="/proc/sys/kernel/timer_migration"
> > +if [ ! -f ${test_file} ] ; then
> > +       echo "MISSING_FILE: missing file ${test_file}"
> > +       exit $MISSING_FILE
> > +fi
> > +
> > +RC=0
> > +echo "${0}: ---Valid test cases---"
> > +check_input "${valid_input}" valid $test_file
> > +RC=$?
> > +echo "${0}: ---Invalid test cases---"
> > +check_input "${invalid_input}" invalid $test_file
> > +RC=$(( RC | $? ))
> > +exit $RC
> 
> 1. Please replace
> 
> ${0}
> 
> with:
> 
> ${0##*}
> 
> 2. Wouldn't it make more sense to say `exit $(( RC | $? )'?
> 

Poornima,

Can you also please address them in a new patch ?

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
