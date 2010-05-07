Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OAGOj-0006tR-UR
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 05:46:53 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OAGOj-0003mW-0Z
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 05:46:53 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o475eUcI004512
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 23:40:30 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o475kln8076464
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 23:46:47 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o475kktj023085
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 23:46:47 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <q2o364299f41005061101h53710323s534939b9bf0d7087@mail.gmail.com>
References: <4BE28B24.1070801@cn.fujitsu.com>
	<q2o364299f41005061101h53710323s534939b9bf0d7087@mail.gmail.com>
Date: Fri, 07 May 2010 11:16:42 +0530
Message-Id: <1273211202.6042.0.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] eventfd01: should to check ret
	in	overflow_poll_test()
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Thu, 2010-05-06 at 11:01 -0700, Garrett Cooper wrote:
> On Thu, May 6, 2010 at 2:25 AM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> > We should to check the return value of trigger_eventfd_overflow()
> > in overflow_poll_test().
> >
> > Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
> > ---
> > diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
> > index 83eb86e..ce55746 100644
> > --- a/testcases/kernel/syscalls/eventfd/eventfd01.c
> > +++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
> > @@ -602,7 +602,7 @@ static void overflow_poll_test(int evfd)
> >        int ret;
> >
> >        ret = trigger_eventfd_overflow(evfd, &fd, &ctx);
> > -       if (fd == -1) {
> > +       if (ret == -1) {
> >                tst_resm(TBROK, "error triggering eventfd overflow");
> >                return;
> >        }
> 
> Acked-by: Garrett Cooper <yanegomi@gmail.com>

Thanks. Just checked in.

Regards--
Subrata



------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
