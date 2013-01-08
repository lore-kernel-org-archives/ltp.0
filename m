Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jshao@redhat.com>) id 1TsSYe-0003rQ-5t
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 06:21:08 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TsSYc-0001ZD-RS
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 06:21:08 +0000
Date: Tue, 8 Jan 2013 14:20:47 +0800
From: monson <monson@station.monson>
Message-ID: <20130108062047.GB32247@station.monson>
References: <1357616084-1705-1-git-send-email-jshao@redhat.com>
	<20130108054041.GA32247@station.monson>
	<50EBB4A4.8040103@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50EBB4A4.8040103@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] containers: delete redundant newline in tst_resm()
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
To: ltp-list@lists.sourceforge.net

Hi Wanlong,

Is there any maitainer still taking care of the containers part? Different namespace
test cases are in different style and the code is messy. I checked the git log and found
it seems like be abandoned.

Regards,
monson

On Tue, Jan 08, 2013 at 01:54:44PM +0800, Wanlong Gao wrote:
> On 01/08/2013 01:40 PM, monson wrote:
> > Note:
> >
> > Some comment lines are modified because there are spaces around tab inside
> > and my editor automaticly fixed it by the way.
> >
> > If it's not acceptable, I would work out another patch without those fixs.
>
> It's OK. Applied, thank you.
>
> Wanlong Gao
>
> >
> > monson
>
>
> ------------------------------------------------------------------------------
> Master SQL Server Development, Administration, T-SQL, SSAS, SSIS, SSRS
> and more. Get SQL Server skills now (including 2012) with LearnDevNow -
> 200+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
> SALE $99.99 this month only - learn more at:
> http://p.sf.net/sfu/learnmore_122512
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

--
Monson Shao
Kernel QA

#29 @NAY - Beijing, China - GMT+08:00
IRC: monson (#kernel-qe, #eng-china)
Internal:  83 88384
External: +86 10 6260 8384

------------------------------------------------------------------------------
Master SQL Server Development, Administration, T-SQL, SSAS, SSIS, SSRS
and more. Get SQL Server skills now (including 2012) with LearnDevNow -
200+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only - learn more at:
http://p.sf.net/sfu/learnmore_122512
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
