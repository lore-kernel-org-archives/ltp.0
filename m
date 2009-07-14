Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <arnd@arndb.de>) id 1MQl66-0007E0-Q3
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 16:43:18 +0000
Received: from moutng.kundenserver.de ([212.227.126.177])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQl5x-0007RS-Ub
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 16:43:18 +0000
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Jul 2009 18:43:05 +0200
References: <4A5C8068.6020203@monstr.eu> <200907141652.59049.arnd@arndb.de>
	<4A5CAEFF.9080206@monstr.eu>
In-Reply-To: <4A5CAEFF.9080206@monstr.eu>
MIME-Version: 1.0
Message-Id: <200907141843.05629.arnd@arndb.de>
Subject: Re: [LTP] access_ok macor
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
To: monstr@monstr.eu
Cc: LTP <ltp-list@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Tuesday 14 July 2009, Michal Simek wrote:
> Arnd Bergmann wrote:

> >>  r29=00000000, r30=00000000, r31=CE9759A4, rPC=C000123C
> >>  msr=800045AE, ear=00000001, esr=000000B2, fsr=000080D0
> >> Segmentation fault
> >>
> > 
> > I guess then you should check if 0xc000123c is in your
> > exception table, or why it is not.
> 
> on that address is load instruction for unaligned exception because addr is odd number
> that's why is called unaligned exception handler and from this function
> is called load instruction which failed. :-(
> 
> Currently this make more sense why that tests failed. If that pointers are
> even number exception is not taken and exception sure don't have fixup for it because
> this is generic code. :-(
> 
> That's the problem because we are looking for regs->pc but this point to unaligned exception
> handler.

Ok, that makes a lot of sense.

The solution then is to handle fixups from the unaligned exception handler
if you come from the kernel. That should fix the three text cases.

I don't fully understand your exception handling there, but I think you
also need to add code checking for __range_ok() to your unaligned handler,
to prevent malicious user space code from accessing the kernel through
unaligned pointers.

	Arnd <><

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
