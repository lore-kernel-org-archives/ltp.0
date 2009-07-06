Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MNhr7-00074U-Hv
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 06:39:13 +0000
Received: from mail-fx0-f208.google.com ([209.85.220.208])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNhr3-0007um-K8
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 06:39:13 +0000
Received: by fxm4 with SMTP id 4so2539078fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Sun, 05 Jul 2009 23:39:07 -0700 (PDT)
Message-ID: <4A519A70.50801@petalogix.com>
Date: Mon, 06 Jul 2009 08:32:16 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4A4DFB77.1080700@petalogix.com> <200907031702.52612.arnd@arndb.de>
In-Reply-To: <200907031702.52612.arnd@arndb.de>
Subject: Re: [LTP] mmap syscall problem
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: LTP <ltp-list@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, John Williams <john.williams@petalogix.com>

Arnd Bergmann wrote:
> On Friday 03 July 2009, Michal Simek wrote:
>
>   
>> I am trying to solve problem with mmap syscall on Microblaze which I have.
>> I am running mmap01 test program from LTP. In attachment is hacked
>> version and inline version is below too.
>>     
>
> Does this happen on microblaze-mmu or microblaze-nommu, or both?
> The mmap code for the two is very different.
>   
For MMU code.

> What file system is backing the temporary file?
>   
I tested it on nfs and initramfs.
The behavior on both has the same symptoms but on initramfs is program
much faster
which is presumtive.

If I run that test, 10times or more and see the output. For example
first 4 tests failed the rest
passed. I look at cpu internals and from syscalls/context switch I see
that that 4 tests which failed
are not interrupted. The rest is interrupted and that tests passed. I
have accurate log for it if you want to see that behavior.
Interruption caused that "anything" in kernel give a time to finish any
work which caused that mmap
memory is consistent.
This behavior is seen in my previous email that depends on time when is
listing called.
Is there any part of kernel which should take care about it?

Thanks for any suggestion.


> For -nommu, there are a number of ristrictions from
> Documentation/nommu-mmap.txt, in particular, MAP_FIXED is
> forbidden, as is PROT_WRITE with regular files. 
>   
This test can'b be run on noMMU.


Michal



>  
>   
>> Arnd: Anyway maybe worth to move sys_mmap2 to any generic location. What
>> do you think?
>>     
>
> Yes, that would be good. I actually have a patch for that somewhere in
> my playground repository, but it build-breaks some architectures in the
> current state. I'm planning to fix that (and do the same for execve
> and maybe some of the other remaining arch specific syscalls) at some
> point.
>
> 	Arnd <><
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
