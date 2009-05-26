Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M8xdI-0005k0-6a
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2009 14:28:00 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M8xdF-0002Hg-UH
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2009 14:28:00 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <d51f89b0905250453q62395300la1dfddc20bdb0af5@mail.gmail.com>
References: <7B7EF7F090B9804A830ACC82F2CDE95DD01ED4@insardxms01.ap.sony.com>
	<d51f89b0905250453q62395300la1dfddc20bdb0af5@mail.gmail.com>
Date: Tue, 26 May 2009 17:52:39 +0530
Message-Id: <1243340559.6293.20.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] patch for timer_create04 and clock_gettime03 issue.
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
To: rohit verma <rohit.170309@gmail.com>
Cc: ltp-list@lists.sf.net

On Mon, 2009-05-25 at 17:23 +0530, rohit verma wrote: 
> Hi,
> 
> In reference to the issue with timer_create04 and clock_gettime03 for
> the kernel version 2.6.29 which was reported in the link:
> 
> http://www.nabble.com/timer_create-p22376043.html, PFA the patch for
> fixing the issue.
> 
> Detail on the issue: A new clockid 'CLOCK_MONOTONIC_RAW' was added
> since the kernel 2.6.28
> (http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.28). This
> addition caused the above testcases to fail. Now, 5 clock ID's are
> present in kernel ver 2.6.28 and later.
> 
> Please check the same....
> 
> Regards,
> Rohit

Thanks.

Regards--
Subrata



------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
