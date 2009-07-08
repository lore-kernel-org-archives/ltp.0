Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MOaYE-0000Il-FK
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 17:03:22 +0000
Received: from mail-fx0-f208.google.com ([209.85.220.208])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOaY8-0006aF-2T
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 17:03:22 +0000
Received: by fxm4 with SMTP id 4so4357701fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jul 2009 10:03:15 -0700 (PDT)
Message-ID: <4A54D14F.9090101@petalogix.com>
Date: Wed, 08 Jul 2009 19:03:11 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] mmap hw behavior
Reply-To: michal.simek@petalogix.com
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
To: Linux Kernel list <linux-kernel@vger.kernel.org>, lkml <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>, Paul Mundt <lethal@linux-sh.org>, LTP <ltp-list@lists.sourceforge.net>

Hi All,

I wrote one email about my problem with mmap on Microblaze. (Especially
mmap01 ltp test)
I need to know how mmap should work with MMU or what the correct steps are.

When I open temp file in application is the kernel create file descriptor table and kernel take
care about setup tlb which are needed. Application get back just file descriptor.

When I call calloc it is called brk kernel syscall and is created one tlb for this place. 
Brk allocate more memory than is requested by calloc. Application got pointer to that memory place.


When I call mmap for that open file with pointer to calloc place (first parameter, + length zero)
it should be one tlb invalidation for calloc and new tlb which connect open file. 
We check it and we don't have any tlb invalidation that's why I think that kernel do different thigs.
Or is it there any copying? Or anything different?

Thanks for clarification,
Michal

-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


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
