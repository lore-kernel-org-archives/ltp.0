Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dmarlin@redhat.com>) id 1OlWHi-0005sS-Mx
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 00:13:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlWHh-0003yh-Lt
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 00:13:38 +0000
Message-ID: <4C6B25A8.806@redhat.com>
Date: Tue, 17 Aug 2010 19:13:28 -0500
From: David Marlin <dmarlin@redhat.com>
MIME-Version: 1.0
References: <4C6AD62B.2010905@redhat.com>	<AANLkTinp94tZRbNveZO3VzEQ_gOR1jFQadqVnvRR95ak@mail.gmail.com>	<4C6B0243.1070306@redhat.com>
	<AANLkTi=S7Y_GW6uZeBgbfUrxFQ5oCRiXAOkWxahmgjCC@mail.gmail.com>
In-Reply-To: <AANLkTi=S7Y_GW6uZeBgbfUrxFQ5oCRiXAOkWxahmgjCC@mail.gmail.com>
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
> On Tue, Aug 17, 2010 at 5:42 PM, David Marlin wrote:
>> Mike Frysinger wrote:
>>> On Tue, Aug 17, 2010 at 2:34 PM, David Marlin wrote:
>>>> 'lchown02.c' does not build properly due to calls to mmap and
>>>> get_high_address (which references sbrk) when UCLINUX=1 is defined.
>>> you'll need to clarify.  it builds fine for me, it just may not run
>>> correctly due to the assumptions of memory placement.
>> Thank you for the feedback.  I'm new to uClinux, so I'm only going on what
>> I've read, but my understanding is that 'sbrk' is not supported in uClinux.
> 
> it depends on how you use it.  sbrk(0) should always work since you're
> only querying the current size.  sbrk(1+) might work depending on the
> current memory layout, but it isnt reliable, so it's recommended
> people dont use it when possible on nommu.  technically speaking, it
> can even fail under mmu systems, it's just highly unlikely with newly
> started processes.
> 
> the lib/get_high_address.c usage is valid since it does sbrk(0), but
> overall the function is useless since it is assuming that a few pages
> after the end of the sbrk() region is unallocated memory.  on nommu
> systems, it could easily be valid (either the same process or a
> different one or the kernel).
> 
> so on nommu/linux, this function should be avoided due to its design
> flaws, not because any of the unctions it calls do not work.

Thank you for the excellent explanation.

	:

>> Most of the testcases skip the call to get_high_address when UCLINUX=1, so I
>> was just following their example.
> 
> i like to look forward and start down a better path rather than
> continue to hedge overgrown crap ;)

Understood.

When creating patches I typically look to the existing sources for 
examples.  This is because I assume that 1) the current code has already 
been reviewed and accepted, 2) the people who wrote it know more about 
what they were trying to accomplish and how they wanted it to work than 
I do, and 3) consistency in the code and coding style tend to make 
maintenance easier.

I understand that over time code may become a bit dated and require some 
redesign/updates, but being new to these bits of code I defer to the 
experts for that.

There appear to be three primary ways tests are being handled in LTP for 
uClinux now:
1) "filter" the test directory (FILTER_OUT_DIRS in the Makefile)
     e.g., testcases/kernel/syscalls/Makefile
2) skip the entire 'main' test, and display "not available in uCLinux"
     e.g., testcases/kernel/syscalls/mremap/mremap03.c
3) skip only parts of the test
     e.g., testcases/kernel/syscalls/stat/stat06.c

There may be other ways that I have not noticed (yet).

I think the question is, do we want to continue using these approaches, 
or try to standardize on one or two (possibly new) approaches, with some 
guidelines on when to use each?

I am willing to help with any modifications, but I don't have enough 
experience with uClinux (or LTP development) to determine the best 
approach(es) or rules for use.  Once guidelines are established I can 
help update the code (submit patches).  As a 'user' of LTP, my goal is 
just to be able to set UCLINUX=1, build, install, and run the tests on a 
system running uClinux.   :-)


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
