Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <galak@kernel.crashing.org>) id 1MZ70c-0004DO-I8
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 17:44:10 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZ70T-0004Yz-Dg
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 17:44:10 +0000
Message-Id: <D4B24F3A-3BF2-41BA-9626-2D13AC12B515@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <364299f40908061024l42cd1200n99e6e762a77c91d2@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Thu, 6 Aug 2009 12:43:45 -0500
References: <E69DB27D-E186-4934-AB69-C5EDB67A48AF@kernel.crashing.org>
	<1249494775.13131.18.camel@lucio-laptop>
	<3E7F2B7B-6BA8-4179-B973-5DA7F4D7618A@kernel.crashing.org>
	<364299f40908061024l42cd1200n99e6e762a77c91d2@mail.gmail.com>
Subject: Re: [LTP] top of tree fails to build on PPC fc11 box
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP <ltp-list@lists.sourceforge.net>


On Aug 6, 2009, at 12:24 PM, Garrett Cooper wrote:

> On Thu, Aug 6, 2009 at 9:07 AM, Kumar  
> Gala<galak@kernel.crashing.org> wrote:
>>
>> On Aug 5, 2009, at 12:52 PM, Lucio Correia wrote:
>>
>>> Hi Kumar,
>>>
>>> On Wed, 2009-07-29 at 13:33 -0500, Kumar Gala wrote:
>>>> I get the following compile error:
>>>>
>>>> make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/
>>>> fstat'
>>>> make[4]: Entering directory `/root/ltp/testcases/kernel/syscalls/
>>>> fstatat'
>>>> cc -Wall  -I../../include -g -Wall -I../../../../include -Wall -
>>>> DTST_USE_NEWER64_SYSCALL=1 -D_FILE_OFFSET_BITS=64   -c -o
>>>> fstatat01_64.o fstatat01.c
>>>> fstatat01.c:95:37: error: missing binary operator before token "5"
>>>> fstatat01.c: In function 'main':
>>>> fstatat01.c:126: error: expected ')' before numeric constant
>>>> make[4]: *** [fstatat01_64.o] Error 1
>>>> make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/
>>>> fstatat'
>>>> make[3]: *** [all] Error 2
>>>> make[3]: Leaving directory `/root/ltp/testcases/kernel/syscalls'
>>>> make[2]: *** [all] Error 2
>>>> make[2]: Leaving directory `/root/ltp/testcases/kernel'
>>>> make[1]: *** [all] Error 2
>>>> make[1]: Leaving directory `/root/ltp/testcases'
>>>> make: *** [all] Error 2
>>>
>>> This failure is being caused because .in files in kernel/includes  
>>> are
>>> wrong. The prefixes for the names (__NR_) and the plus signs were
>>> removed. I've noticed it in .in files for several architectures in  
>>> the
>>> latest LTP release (July 2009).
>>>
>>>
>>>
>>> This patch fixes bad updates to syscalls declarations for powerpc,
>>> that
>>> are causing build failures. This should be fixed for other archs
>>> accordingly.
>>>
>>> Signed-off-by Lucio Correia <luciojhc@br.ibm.com>
>>> <july2009-ppc-build-fix.patch>
>>
>> thanks.  This still doesn't address the fact that I can't even
>> configure ltp on fedora 10 or 11.
>>
>> see for more details:
>>
>> http://sourceforge.net/mailarchive/forum.php?thread_name=5D25ED72-13B4-4ED7-959C-4974F4DF2FCA%40kernel.crashing.org&forum_name=ltp-list
>
>    Ok. I have the time now so I'll install F11 amd64 and see what
> happens. Something leads me to think that the build toolchain is
> fubared, but that's just a hunch, as my copy of F10 (the last time I
> ran the build) worked.
> Thanks,
> -Garrett

interesting since I saw the same issues w/F10 amd64.

- k

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
