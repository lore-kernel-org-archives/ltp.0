Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <arnd@arndb.de>) id 1MNjDF-0005au-CU
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 08:06:09 +0000
Received: from moutng.kundenserver.de ([212.227.126.188])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNjDA-0006JM-Dw
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 08:06:08 +0000
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 6 Jul 2009 10:05:35 +0200
References: <4A4DFB77.1080700@petalogix.com> <200907031702.52612.arnd@arndb.de>
	<4A519A70.50801@petalogix.com>
In-Reply-To: <4A519A70.50801@petalogix.com>
MIME-Version: 1.0
Message-Id: <200907061005.36094.arnd@arndb.de>
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
Cc: LTP <ltp-list@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, John Williams <john.williams@petalogix.com>

On Monday 06 July 2009, Michal Simek wrote:
> > Does this happen on microblaze-mmu or microblaze-nommu, or both?
> > The mmap code for the two is very different.
> >   
> For MMU code.

Could this be a cache-aliasing problem? If your cache is 'virtually-indexed'
(most architectures are 'physically-indexed'), the kernel may have written
into different parts of the D-cache than what the user space is reading
from. If you have a write-through cache, that can explain why you only
see the stale data at the beginning of the page -- the cache controller
is still busy writing back the data when you start reading it from
DRAM through the cache alias.

If this is your problem, then you need to implement flush_dcache_page()
and other functions that maintain cache consistency. See
Documentation/cachetlb.txt and http://www.linuxjournal.com/article/7105

	Arnd <><

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
