Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1O4Aqv-0003WZ-8B
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 10:38:49 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O4Aqu-0001Vj-0W
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 10:38:49 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3KAXe8c018127
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Apr 2010 06:33:40 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3KAcdq1160650
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Apr 2010 06:38:40 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3KAcddl025310
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Apr 2010 06:38:39 -0400
Date: Tue, 20 Apr 2010 16:08:25 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100420103825.GA4118@linux.vnet.ibm.com>
References: <20100219123501.19085.64668.sendpatchset@subratamodak.linux.ibm.com>
	<1706047941.560391271757613100.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1706047941.560391271757613100.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] Fix MSGCTL10() to avoid un-necessary cluttering
 of whole system with all PIDs
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
To: Caspar ZHANG <czhang@redhat.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Tue, Apr 20, 2010 at 06:00:13AM -0400, Caspar ZHANG wrote:
> 
> 
> ----- "Subrata Modak" <subrata@linux.vnet.ibm.com> wrote:
> 
> > Hi,
> > 
> > msgctl10() un-necessarily eats up all the PIDs of the system leading
> > to
> > system becoming un-responsive. The changed no.s would better do the
> > job.
> 
> Hi, I see this patch is not included in ltp-full-20100331, will it be 
> accepted in the future? 

Thanks for testing this patch. can you put your Acked-By / Tested-By ?

After that it will be included in master branch immediately.

-Rishi
> 
> I tested msgctl10 testcase on RHEL5(2.6.18) and RHEL6(>2.6.31),
> Since /proc/sys/kernel/msgmni has increased from 10 (RHEL5) to 
> thousands (RHEL6), the testing time will be several hours long.
> Applied this patch, the testing time can be lowed down to minutes.
> 
> Thanks,
> Caspar
> 
> > 
> > Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>
> > ---
> > 
> > ---
> > ltp-full-20100131/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c.orig
> > 2010-02-19 17:59:23.000000000 +0530
> > +++ ltp-full-20100131/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
> > 2010-02-19 18:01:13.000000000 +0530
> > @@ -65,12 +65,8 @@ extern int Tst_count;		/* Test Case coun
> >  
> >  int exp_enos[] = { 0 };		/* List must end with 0 */
> >  
> > -#ifndef CONFIG_COLDFIRE
> > -#define MAXNPROCS	1000000	/* This value is set to an arbitrary high
> > limit. */
> > -#else
> > -#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
> > -#endif
> > -#define MAXNREPS	100000
> > +#define MAXNPROCS	10000 	/*These should be sufficient*/
> > +#define MAXNREPS	10000	/*Else they srewup the system
> > un-necessarily*/
> >  #define FAIL		1
> >  #define PASS		0
> >  
> > 
> > ---
> > Regards--
> > Subrata
> > 
> > 
> > ------------------------------------------------------------------------------
> > Download Intel&#174; Parallel Studio Eval
> > Try the new software tools for yourself. Speed compiling, find bugs
> > proactively, and fine-tune applications for parallel performance.
> > See why Intel Parallel Studio got high marks during beta.
> > http://p.sf.net/sfu/intel-sw-dev
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> -- 
> /---------------------------------------\
> | Name: Caspar Zhang                    |
> | Team: Kernel-QE                       |
> | IRC: czhang @ #kernel-qe, #eng-china  |
> | Phone: +86-10-6260-8150               |
> | Cellphone: +86-1381-073-0090          |
> \---------------------------------------/
> 
> 
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
