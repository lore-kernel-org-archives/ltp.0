Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <segher@kernel.crashing.org>) id 1MplT4-0007Mi-LF
	for Ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 16:10:22 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MplT0-0001mu-Aj
	for Ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 16:10:22 +0000
In-Reply-To: <alpine.LRH.2.00.0909211539520.16077@vixen.sonytel.be>
References: <alpine.LRH.2.00.0909211539520.16077@vixen.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v753.1)
Message-Id: <87FFD936-384D-4A04-AD6D-90BBDD3DAD18@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 21 Sep 2009 18:10:32 +0200
Subject: Re: [LTP] mmapstress03 weirdness? (fwd)
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Test Project <Ltp-list@lists.sourceforge.net>

>         if (mmap((caddr_t)(1UL << (POINTER_SIZE  - 1)) - pagesize,
>                 (size_t)((1UL << (POINTER_SIZE - 1)) - pagesize),
>                 PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_FIXED| 
> MAP_SHARED, 0, 0)
>                 != (caddr_t)-1)

> With 32-bit userland, this boils down to:
>
> | mmap addr 0x7fff0000 size 0x7fff0000
> | mmap returned 0x7fff0000
>
> i.e. mmap() succeeds,

Yes, on a powerpc64 kernel, every 32-bit userspace process has 4GB
available (well, except the lowest few pages).  The process text sits
normally at 1M and the shared libs around 256M.

> but (1) the test expects it to fail, so the test returns
> TFAIL,

That's a bug in the test then.

> but (2) ltp-pan still reports that the tests passed?

Sounds like another bug.

> In addition, sometimes mmapstress03 fails due to SEGV. I created a  
> small test
> program that just does the above mmap(), and depending on the  
> distro and what
> else I print later it crashes with a SEGV, too. Probably this  
> happens because
> the mmap() did succeed, and corrupted some existing mappings,

It probably killed the stack, which sits all the way up near 4G.

> JFYI, with 64-bit userland, this boils down to:
>
> | mmap addr 0x7fffffffffff0000 size 0x7fffffffffff0000
> | mmap returned 0xffffffffffffffff
>
> i.e. mmap() fails as expected, and the test succeeds.

It tries to map space that is reserved for the kernel (c000...)

> Does all of this sound OK?

Seems to me everything works fine, except the tests themselves.


Segher


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
