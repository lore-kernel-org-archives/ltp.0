Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <arnd@arndb.de>) id 1MNplr-0007Lg-Hi
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:06:19 +0000
Received: from moutng.kundenserver.de ([212.227.126.171])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNplq-0004sC-8m
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:06:19 +0000
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 6 Jul 2009 17:05:50 +0200
References: <4A4DFB77.1080700@petalogix.com> <200907061616.12220.arnd@arndb.de>
	<4A520DA6.2040107@petalogix.com>
In-Reply-To: <4A520DA6.2040107@petalogix.com>
MIME-Version: 1.0
Message-Id: <200907061705.50308.arnd@arndb.de>
Subject: Re: [LTP] mmap syscall problem
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
Cc: LTP <ltp-list@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, John Williams <john.williams@petalogix.com>

On Monday 06 July 2009, Michal Simek wrote:
> >       *p1 = 0xaa; *p2 = 0x55;
> >   
> I closed fd too.
>     close(fd);
> >       return *p1; /* returns 0xaa if broken, 0x55 if correct */
> > }

If you close the fd between the assignment and reading
from the pointer again, the test case becomes invalid because of
timing. Closing the fd before the '*p1 = 0xaa' should be fine,
but unnecessary.

I also realized that you might need to mark the pointers
as 'volatile' so that the compiler has to do the operations
in order.

> >   
> # ls -la existing-4k-file
> -rw-rw-r--    1 monstr   monstr       4096 Jul  6  2009 existing-4k-file
> 
> # ./test-arnd
> # echo $?
> 85

Ok, so inside a single task, this does not happen.

> # dd if=existing-4k-file of=/dev/console count=1 2>/dev/null
> U#
> 
> in file is first char U (0x55) which is IMO correct.

Right, though that was not part of the test, I'd expect this in
the file even if the return value was broken.

	Arnd <><

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
