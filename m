Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <galak@kernel.crashing.org>) id 1MacnT-0000A0-0U
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 21:52:51 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MacnO-0000g9-M1
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 21:52:50 +0000
Message-Id: <9723E7E2-ABB6-40C0-AE3E-AD42B6A57705@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <364299f40908100840w329abda8q178a3b8ace628bfe@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Mon, 10 Aug 2009 16:52:26 -0500
References: <1842FA33-8C6C-4BE1-8FB4-B8836F1C8F6E@kernel.crashing.org>
	<364299f40908061017g44fd05ecv9c6454ebf04badb4@mail.gmail.com>
	<2A1B6719-9C0B-4271-8A81-1730F79F5E33@kernel.crashing.org>
	<1249892416.5187.10.camel@subratamodak.linux.ibm.com>
	<364299f40908100840w329abda8q178a3b8ace628bfe@mail.gmail.com>
Subject: Re: [LTP] RANLIB not set?
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


On Aug 10, 2009, at 10:40 AM, Garrett Cooper wrote:

> On Mon, Aug 10, 2009 at 1:20 AM, Subrata
> Modak<subrata@linux.vnet.ibm.com> wrote:
>> On Fri, 2009-08-07 at 08:14 -0500, Kumar Gala wrote:
>>> On Aug 6, 2009, at 12:17 PM, Garrett Cooper wrote:
>>>
>>>> On Thu, Aug 6, 2009 at 9:18 AM, Kumar
>>>> Gala<galak@kernel.crashing.org> wrote:
>>>>> I'm seeing this on fedora 11 on ppc64:
>>>>>
>>>>> make[3]: Leaving directory `/root/ltp/testcases/network/ipv6'
>>>>> make[3]: Entering directory `/root/ltp/testcases/network/lib6'
>>>>> cc -Wall  -I../../../include -g -D_GNU_SOURCE   -c -o runcc.o  
>>>>> runcc.c
>>>>> ar cr runcc.a runcc.o
>>>>> runcc.a
>>>>> make[3]: runcc.a: Command not found
>>>>> make[3]: *** [runcc.a] Error 127
>>>>> make[3]: Leaving directory `/root/ltp/testcases/network/lib6'
>>>>> make[2]: *** [all] Error 2
>>>>> make[2]: Leaving directory `/root/ltp/testcases/network'
>>>>> make[1]: *** [all] Error 2
>>>>> make[1]: Leaving directory `/root/ltp/testcases'
>>>>> make: *** [all] Error 2
>>>>>
>>>>> - k
>>>>
>>>>    Make sure to export CROSS_COMPILER=1 at the top-level make, or
>>>> define RANLIB=$(CROSS_COMPILE)ranlib, where $(CROSS_COMPILE) is the
>>>> prefix for your compiler set, e.g. $(CROSS_COMPILE)gcc.
>>>>    One of the many things that will be fixed in a more kosher  
>>>> manner
>>>> in the next couple months.
>>>> Thanks,
>>>> -Garrett
>>>
>>> I see you committed a change to the lib6/Makefile for ranlib.  I
>>> believe we need a similar patch to the toplevel Makefile since it
>>> exports RANLIB:
>>>
>>
>> True. But, can you create a patch from LTPROOT, as, the below fails  
>> to
>> apply:
>>
>> patching file Makefile
>> Hunk #1 FAILED at 9.
>> 1 out of 1 hunk FAILED -- saving rejects to file Makefile.rej
>>
>> Regards--
>> Subrata
>>
>>> diff --git a/Makefile b/Makefile
>>> index 953eddf..9f8056a 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -9,6 +9,8 @@ AR=$(CROSS_COMPILER)ar
>>>   RANLIB=$(CROSS_COMPILER)ranlib
>>>   endif
>>>
>>> +RANLIB         ?= ranlib
>>> +
>
> Hi Kumar,
>    The suggestion you made (noble as it may have been) is completely
> useless as you're not exporting the variable in the Makefile (and thus
> the value goes out of scope when you drop into the lower level
> Makefiles). Please see this link for more details:
> http://www.gnu.org/software/make/manual/make.html#Variables_002fRecursion

But we are exporting it..

ifdef CROSS_COMPILE
CROSS_COMPILER = $(CROSS_COMPILE)
endif
ifdef CROSS_COMPILER
CC=$(CROSS_COMPILER)gcc
AR=$(CROSS_COMPILER)ar
RANLIB=$(CROSS_COMPILER)ranlib
endif

...

export CFLAGS += -Wall $(CROSS_CFLAGS)
export CC AR RANLIB CPPFLAGS LDFLAGS HAS_NUMA

>    All in all, please be patient... give me another 2 weeks and I'll
> have a better solution (the new Makefile infrastructure) back in HEAD.
> I just did the quick fix because it was gating any building off of

Just reporting what I'm seeing and trying to help.  I'll look forward  
to trying out the new Makefile infrastructure.

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
