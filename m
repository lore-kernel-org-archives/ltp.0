Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dmarlin@redhat.com>) id 1OlTvd-0007Am-GV
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 21:42:41 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlTvc-0006qD-ET
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 21:42:41 +0000
Message-ID: <4C6B0243.1070306@redhat.com>
Date: Tue, 17 Aug 2010 16:42:27 -0500
From: David Marlin <dmarlin@redhat.com>
MIME-Version: 1.0
References: <4C6AD62B.2010905@redhat.com>
	<AANLkTinp94tZRbNveZO3VzEQ_gOR1jFQadqVnvRR95ak@mail.gmail.com>
In-Reply-To: <AANLkTinp94tZRbNveZO3VzEQ_gOR1jFQadqVnvRR95ak@mail.gmail.com>
Subject: Re: [LTP] problems building lchown02.c for uClinux
Reply-To: dmarlin@redhat.com
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: LTP list <ltp-list@lists.sourceforge.net>


Mike Frysinger wrote:
> On Tue, Aug 17, 2010 at 2:34 PM, David Marlin wrote:
>> 'lchown02.c' does not build properly due to calls to mmap and
>> get_high_address (which references sbrk) when UCLINUX=1 is defined.
> 
> you'll need to clarify.  it builds fine for me, it just may not run
> correctly due to the assumptions of memory placement.

Thank you for the feedback.  I'm new to uClinux, so I'm only going on 
what I've read, but my understanding is that 'sbrk' is not supported in 
uClinux.  My information may be a bit dated, so a newer (better) 
reference would be welcome.

Much of the syscalls test code that is "#ifdef'd" out for UCLINUX=1 
involves skipping references (directly or indirectly) to sbrk. 
get_high_address is one of those references, where it directly calls sbrk:

   char *get_high_address(void)
   {
        return (char *)sbrk(0) + (4 * getpagesize());
   }

Most of the testcases skip the call to get_high_address when UCLINUX=1, 
so I was just following their example.

> for runtime issues, how about we change lib/get_high_address.c to
> return NULL for UCLINUX targets.  then in lchown.c, we can check for
> NULL and skip the test when we get that value.

I'm flexible, so any approach that works is ok with me.  I assume we'll 
need to locate all the tests that have been skipping get_high_address 
for uClinux and update them, as appropriate.  Will we also need to 
change the approach for tests that directly reference sbrk, for example,

   testcases/kernel/syscalls/stat/stat06.c
   testcases/kernel/syscalls/setgroups/setgroups04.c

> that leaves your ifdefing of -1 pointer address.  any sane nommu port
> should reject that address in the kernel.  if yours isnt, fix your
> kernel.

Again, I was just following the example of the existing LTP test code, i.e.,

   testcases/kernel/syscalls/lstat/lstat02.c

I can adjust to any approach that LTP follows. (I have not actually 
tried this test on our kernel yet, so it may just work)


Thank you,

d.marlin
==========


> -mike
> 
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by 
> 
> Make an app they can't live without
> Enter the BlackBerry Developer Challenge
> http://p.sf.net/sfu/RIM-dev2dev 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
