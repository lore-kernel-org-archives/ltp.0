Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MYNsJ-0004ja-MH
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 17:32:35 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYNsD-00078j-Mq
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 17:32:35 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n74HR8Ij016333
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 11:27:08 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n74HWNMg176092
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 11:32:23 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n74HWGXP023016
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 11:32:21 -0600
Date: Tue, 4 Aug 2009 12:32:19 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090804173219.GB3698@us.ibm.com>
References: <4A76D6DD.4020401@petalogix.com>
	<20090803151449.GA29794@us.ibm.com>
	<1249387690.15587.34.camel@subratamodak.linux.ibm.com>
	<4A785468.6020803@petalogix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A785468.6020803@petalogix.com>
Subject: Re: [LTP] clone01 -c 10 on x86
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
To: Michal Simek <michal.simek@petalogix.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Quoting Michal Simek (michal.simek@petalogix.com):
> Subrata Modak wrote:
> > On Mon, 2009-08-03 at 10:14 -0500, Serge E. Hallyn wrote: 
> >   
> >> Quoting Michal Simek (michal.simek@petalogix.com):
> >>     
> >>> Hi All,
> >>>
> >>> can you please to run clone01 syscall test on any x86 machine? I am
> >>> getting fault there when I run it 10 times for example.
> >>> The same problem I have on Microblaze.
> >>>
> >>>  ./clone01  -c 10
> >>> clone01     1  TPASS  :  clone() returned 22738
> >>> clone01     1  TPASS  :  clone() returned 22740
> >>> clone01     1  TPASS  :  clone() returned 22742
> >>> clone01     1  TPASS  :  clone() returned 22748
> >>> clone01     1  TPASS  :  clone() returned 22750
> >>> clone01     1  TPASS  :  clone() returned 22752
> >>> clone01     1  TPASS  :  clone() returned 22754
> >>> clone01     1  TFAIL  :  clone() returned 134919589, errno = 22755
> >>> [monstr@monstr clone]$ clone01     1  TPASS  :  clone() returned 22744
> >>> clone01     1  TPASS  :  clone() returned 22746
> >>>
> >>> Thanks,
> >>> Michal
> >>>       
> >> All right I don't have the patiente to wade through the parse_opts
> >> and usc_lib crap, but this is not a clone failure.  What appears to
> >> be happening is setup() at the top of clone01.c is calling
> >> lib/parse_opts.c:usc_global_setup_hook(), with STD_COPIES set to the
> >> count option you passed in.  That forks of 10 copies of the test.
> >> I don't know what happens with the actual loop then, but the reason
> >> you get the error for the last clone test is that one of those
> >> forked copies of clone01 (*not* one of the cloned children) exits,
> >> and wait() catches that one.  That is why wait() returned 22744,
> >> which isn't any of the cloned children.
> >>
> >> So one stupid way of fixing this without dealing with the convoluted
> >> setup junk would be to change the waitpid chunk of the code like so:
> >>     
> >
> > Yes, it fixes the issue.
> >   
> Yes, but as Serge wrote above his patch just cover different fault not
> solve it.

Although that depends on what we think the fault really is.  The reason
we were getting fail messages was that children were exiting which we
were (wrongly) not expecting.  Now, I don't understand why setup()
forks off N tasks, and it would probably be best to not do that.  But
in the end so long as we ignore when those tasks are reaped, it really
doesn't matter that there were extra children.  We are testing that clone(2)
succeeded now, which is what we really care about.

-serge

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
