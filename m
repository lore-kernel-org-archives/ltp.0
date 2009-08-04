Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MYIpc-0001Kv-Ev
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:09:28 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYIpU-0000W6-Kl
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:09:28 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n74C8jH7000612
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 08:08:45 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n74C9FIS245020
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 08:09:15 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n74C9E4P016797
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 08:09:15 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A76F76B.9070704@petalogix.com>
References: <200907301305.n6UD5G7F023361@e32.co.us.ibm.com>
	<1249298406.7460.25.camel@subratamodak.linux.ibm.com>
	<4A76F76B.9070704@petalogix.com>
Date: Tue, 04 Aug 2009 17:38:46 +0530
Message-Id: <1249387726.15587.40.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Make the test result codes a real bitfield again
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
To: michal.simek@petalogix.com
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>, Jiri Palecek <jpalecek@web.de>

On Mon, 2009-08-03 at 16:42 +0200, Michal Simek wrote: 
> Hi Mike and Subrata,
> > Mike,
> >
> > You would need to see this.
> >   
> Jiri is right. I sent one email about some minutes ago (but not solution).
> Please ignore my email and add this change. I tested it and works.

Thanks. Did it.

Regards--
Subrata

> 
> BTW: I haven't seen that Mike's patches on mailing list.
> 
> Thanks,
> Michal
> 
> > Regards--
> > Subrata
> >
> > On Thu, 2009-07-30 at 11:57 +0200, Jiri Palecek wrote: 
> >   
> >> Hello,
> >>
> >> the commit "extend the test result to a bit field so we can extend the output further" from July 20th unfortunately changes the code, that was previously a bitfield, to a non-bitfield. This causes FAILED tests to return erroneously 0.
> >>
> >> This patch changes the test result codes to be individual bits in the bitfield (effectively reverting  a small part of aforementioned patch).
> >>
> >> Regards
> >>     Jiri Palecek
> >>
> >> ---
> >>  include/test.h |   12 ++++++------
> >>  1 files changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/include/test.h b/include/test.h
> >> index 5c325b3..4d9803a 100644
> >> --- a/include/test.h
> >> +++ b/include/test.h
> >> @@ -44,15 +44,15 @@
> >>
> >>  #include "compiler.h"
> >>
> >> -/* Use low 4 bits to encode test type */
> >> -#define TTYPE_MASK 0xf
> >> +/* Use low 6 bits to encode test type */
> >> +#define TTYPE_MASK 0x3f
> >>  #define TPASS      0    /* Test passed flag */
> >>  #define TFAIL      1    /* Test failed flag */
> >>  #define TBROK      2    /* Test broken flag */
> >> -#define TWARN      3    /* Test warning flag */
> >> -#define TRETR      4    /* Test retire flag */
> >> -#define TINFO      5    /* Test information flag */
> >> -#define TCONF      6    /* Test not appropriate for configuration flag */
> >> +#define TWARN      4    /* Test warning flag */
> >> +#define TRETR      8    /* Test retire flag */
> >> +#define TINFO      16   /* Test information flag */
> >> +#define TCONF      32   /* Test not appropriate for configuration flag */
> >>  #define TTYPE_RESULT(ttype) ((ttype) & TTYPE_MASK)
> >>
> >>  #define TERRNO     0x100   /* Append errno information to output */
> >>     
> >
> >
> > ------------------------------------------------------------------------------
> > Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> > trial. Simplify your report design, integration and deployment - and focus on 
> > what you do best, core application coding. Discover what's new with 
> > Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> >   
> 
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
