Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MbBtS-00005l-K2
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 11:21:22 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbBtM-0000x2-11
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 11:21:22 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7CBKEA5009905
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Aug 2009 05:20:14 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7CBL6CF239480
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Aug 2009 05:21:06 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7CBL5FA002282
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Aug 2009 05:21:06 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40908120145h13955b1eyaa4abdd477612b6a@mail.gmail.com>
References: <20090811172957.7074.62874.sendpatchset@subratamodak.linux.ibm.com>
	<20090811173021.7074.87879.sendpatchset@subratamodak.linux.ibm.com>
	<364299f40908120145h13955b1eyaa4abdd477612b6a@mail.gmail.com>
Date: Wed, 12 Aug 2009 16:50:56 +0530
Message-Id: <1250076056.5373.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 02/05] Add Script which would actually do the job
	of	injecting faults
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
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, LTP Mailing List <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Paul Larson <paul.larson@ubuntu.com>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

On Wed, 2009-08-12 at 01:45 -0700, Garrett Cooper wrote: 
> On Tue, Aug 11, 2009 at 10:30 AM, Subrata
> Modak<subrata@linux.vnet.ibm.com> wrote:
> > Script which would actually do the job of injecting faults by changing various
> > parametrs available under /debug/fail*. This would be done dynamically during
> > LTP run, and, is capable of taking parameters from 0 to 100 to vary the
> > probability of Fault the user wants to inject in the running kernel.
> >
> > Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
> > ---
> >
> > diff -uprN ltp-full-20090731.orig/tools/insert_kernel_faults.sh ltp-full-20090731/tools/insert_kernel_faults.sh
> > --- ltp-full-20090731.orig/tools/insert_kernel_faults.sh        1970-01-01 05:30:00.000000000 +0530
> > +++ ltp-full-20090731/tools/insert_kernel_faults.sh     2009-08-11 18:44:45.000000000 +0530
> > @@ -0,0 +1,52 @@
> > +#!/bin/sh
> > +################################################################################
> > +##                                                                            ##
> > +## Copyright (c) International Business Machines  Corp., 2009                 ##
> > +##                                                                            ##
> > +## This program is free software;  you can redistribute it and/or modify      ##
> > +## it under the terms of the GNU General Public License as published by       ##
> > +## the Free Software Foundation; either version 2 of the License, or          ##
> > +## (at your option) any later version.                                        ##
> > +##                                                                            ##
> > +## This program is distributed in the hope that it will be useful, but        ##
> > +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> > +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> > +## for more details.                                                          ##
> > +##                                                                            ##
> > +## You should have received a copy of the GNU General Public License          ##
> > +## along with this program;  if not, write to the Free Software               ##
> > +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> > +##                                                                            ##
> > +################################################################################
> > +#                                                                            ##
> > +# File :        insert_kernel_faults.sh                                              ##
> > +#                                                                            ##
> > +# Usage:       insert_kernel_faults.sh <fault_percentage>                    ##
> > +#                                                                            ##
> > +# Description:  This is a simple script that inserts faults at various       ##
> > +#              subsystems of the kernel. Please refer to the ltp/README      ##
> > +#              for the various kernel CONFIG options needed to exploit       ##
> > +#              all those features                                            ##
> > +#                                                                            ##
> > +# Author:      Subrata Modak <subrata@linux.vnet.ibm.com>                    ##
> > +#                                                                            ##
> > +# History:      Aug 11 2009 - Created - Subrata Modak.                       ##
> > +################################################################################
> > +
> > +if [ -z $1 ]
> > +       then
> > +       #Check if Useage has been proper
> > +       echo "Usage: $0 <fault_percentage>"
> > +       exit 1
> > +fi
> > +
> > +#These are the types of Subsystems where fault will be injected
> > +#Make sure debugfs has been mounted
> > +for FAILTYPE in `echo fail_io_timeout fail_make_request fail_page_alloc failslab`
> > +do
> > +       echo $1 > /debug/$FAILTYPE/probability
> > +       echo 100 > /debug/$FAILTYPE/interval
> > +       echo -1 > /debug/$FAILTYPE/times
> > +       echo 0 > /debug/$FAILTYPE/space
> > +done
> 
>     Why ```for FAILTYPE in `echo list-of-values`'''? ```for FAILTYPE
> in list-of-values''' works just as well without the echo.

Oops. True. I will do that. Let me hear some more comments from people
and i will redo the patches again.

Regards--
Subrata

> Thanks,
> -Garrett


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
