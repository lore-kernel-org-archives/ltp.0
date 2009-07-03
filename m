Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <arnd@arndb.de>) id 1MMkIH-00026x-SE
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 15:03:17 +0000
Received: from moutng.kundenserver.de ([212.227.126.187])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMkI6-0004z2-Gr
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 15:03:12 +0000
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 3 Jul 2009 17:02:52 +0200
References: <4A4DFB77.1080700@petalogix.com>
In-Reply-To: <4A4DFB77.1080700@petalogix.com>
MIME-Version: 1.0
Message-Id: <200907031702.52612.arnd@arndb.de>
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

On Friday 03 July 2009, Michal Simek wrote:

> I am trying to solve problem with mmap syscall on Microblaze which I have.
> I am running mmap01 test program from LTP. In attachment is hacked
> version and inline version is below too.

Does this happen on microblaze-mmu or microblaze-nommu, or both?
The mmap code for the two is very different.

What file system is backing the temporary file?

For -nommu, there are a number of ristrictions from
Documentation/nommu-mmap.txt, in particular, MAP_FIXED is
forbidden, as is PROT_WRITE with regular files. 
 
> Arnd: Anyway maybe worth to move sys_mmap2 to any generic location. What
> do you think?

Yes, that would be good. I actually have a patch for that somewhere in
my playground repository, but it build-breaks some architectures in the
current state. I'm planning to fix that (and do the same for execve
and maybe some of the other remaining arch specific syscalls) at some
point.

	Arnd <><

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
