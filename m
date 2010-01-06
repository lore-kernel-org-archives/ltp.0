Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1NST0b-0004VQ-H6
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 10:20:57 +0000
Received: from fg-out-1718.google.com ([72.14.220.153])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NST0Y-0007sY-S9
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 10:20:57 +0000
Received: by fg-out-1718.google.com with SMTP id e12so606812fga.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 06 Jan 2010 02:20:44 -0800 (PST)
Message-ID: <4B4463AD.8050806@petalogix.com>
Date: Wed, 06 Jan 2010 11:19:25 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4B421480.1040400@petalogix.com>
	<20100104164954.GB26962@us.ibm.com>
	<4B4226E9.6000309@petalogix.com>
	<20100104174925.GA1208@us.ibm.com> <4B43E1CD.2050609@web.de>
	<20100106032644.GB8157@us.ibm.com>
In-Reply-To: <20100106032644.GB8157@us.ibm.com>
Subject: Re: [LTP] clone tests fails
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Jiri Palecek <jpalecek@web.de>, Nathan T Lynch <natlynch@us.ibm.com>, vapier@gentoo.org, ltp-list@lists.sourceforge.net

Serge E. Hallyn wrote:
> Quoting Jiri Palecek (jpalecek@web.de):
>> Serge E. Hallyn napsal(a):
>>> Quoting Michal Simek (michal.simek@petalogix.com):
>>>> Serge E. Hallyn wrote:
>>>>> Quoting Michal Simek (michal.simek@petalogix.com):
>>>>>> Hi Mike,
>>>>>>
>>>>>> I have one question about one your big patch
>>>>>>
>>>>>> http://git.kernel.org/?p=linux/kernel/git/galak/ltp.git;a=commitdiff;h=391dc18fe3271fbf2ca1864a5299f091c31e0018
>>>>>>
>>>>>> My question is why you add -1 in lib/cloner.c:65
>>>>>>
>>>>>> +       ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
>>>>>> +                       clone_flags, arg);
>>>>>>
>>>>>> In previous code in clone testcases was nothing like this.
>>>>>> What reason have you had to add it?
>>>>> Because the same thing was done in lots of places all over the
>>>>> testsuite (and done wrong).  This consolidates them all.
>>>>
>>>> I don't have anything against consolidation. I just want to know why
>>>> there is that -1 which weren't in any clone testcases. Nothing more
>>>> nothing less.
>>> ooooh.  Because if we've done stack = malloc(stack_size), then
>>> stack+stack_size is 1 above the the top of stack.
>> If the value of the parameter is the stack pointer of the created
>> thread, it shouldn't matter - the address should never be used (read
>> or written).
>>
>> Michal, I suspect the failures you see are somehow related to
>> alignment (that your architecture doesn't like odd addresses). Is
>> that right? Under x86, the address gets aligned (so some of the
>> space is unused).
>>
>> Perhaps both of these behaviors should be tested by LTP?
> 
> Gah, yes, Nathan had mentioned arches where this matters (including
> some power?).  Nathan, did you have a generic fix for this in
> userspace?  Should always be safe to do
> 	(stack + stack_size - 1) & ~0xf
> ?

(long)(stack + stack_size - 1) & ~0x3

0x3 is enough - just clear last 2 bits.
I am not sure about long type - maybe need long long or long double.

Mike's solution not work for me.

Thanks,
Michal






> 
> -serge


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
