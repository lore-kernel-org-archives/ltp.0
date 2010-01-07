Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NSgvN-0005Vn-K1
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 01:12:29 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSgvH-0001e0-Ez
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 01:12:29 +0000
Message-ID: <4B4534EB.5020306@web.de>
Date: Thu, 07 Jan 2010 02:12:11 +0100
From: Jiri Palecek <jpalecek@web.de>
MIME-Version: 1.0
References: <4B421480.1040400@petalogix.com>	<20100104164954.GB26962@us.ibm.com>	<4B4226E9.6000309@petalogix.com>
	<20100104174925.GA1208@us.ibm.com> <4B43E1CD.2050609@web.de>
	<4B4462DD.8010807@petalogix.com>
In-Reply-To: <4B4462DD.8010807@petalogix.com>
Subject: Re: [LTP] clone tests fails
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
Cc: vapier@gentoo.org, ltp-list@lists.sourceforge.net

Michal Simek napsal(a):
> Jiri Palecek wrote:
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
>>>>>>
>>>>>> My question is why you add -1 in lib/cloner.c:65
>>>>>>
>>>>>> + ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
>>>>>> + clone_flags, arg);
>>>>>>
>>>>>> In previous code in clone testcases was nothing like this.
>>>>>> What reason have you had to add it?
>>>>>
>>>>> Because the same thing was done in lots of places all over the
>>>>> testsuite (and done wrong). This consolidates them all.
>>>>
>>>>
>>>> I don't have anything against consolidation. I just want to know why
>>>> there is that -1 which weren't in any clone testcases. Nothing more
>>>> nothing less.
>>>
>>> ooooh. Because if we've done stack = malloc(stack_size), then
>>> stack+stack_size is 1 above the the top of stack.
>>
>> If the value of the parameter is the stack pointer of the created
>> thread, it shouldn't matter - the address should never be used (read
>> or written).
>>
>> Michal, I suspect the failures you see are somehow related to
>> alignment (that your architecture doesn't like odd addresses). Is that
>> right? Under x86, the address gets aligned (so some of the space is
>> unused).
>
> yes, alignment is problem. I need to subtract at least -4.
>
> As you can see below I am getting fault in kernel about task_size exceed.
>
> # ./clone01
> kernel task_size exceed, 0xffffffff, 0xc0000000
> Oops: Exception in kernel mode, sig: 11
> Registers dump: mode=1
> r1=CDC3FF50, r2=00000000, r3=000008A1, r4=FFFFFFFF
> r5=00000000, r6=00000800, r7=CDC3FF68, r8=00000028
> r9=481804AC, r10=00000000, r11=000045AA, r12=C00011C4
> r13=00000000, r14=6B6B6B6B, r15=C00083F8, r16=6B6B6B6B
> r17=6B6B6B6B, r18=00000000, r19=FFFFFFFF, r20=100074C8
> r21=00000000, r22=100073CC, r23=00000000, r24=00000000
> r25=1000C050, r26=00000001, r27=10005310, r28=10001060
> r29=00000000, r30=00000000, r31=CDD4C358, rPC=C00011DC
> msr=000045AA, ear=FFFFFFFF, esr=000000B2, fsr=10005310
> clone01 1 TPASS : clone() returned 66

I do not understand this dump fully, but couldn't it be just that your arch 
needs the 4 bytes of memory above what you pass as stack top (task_size exceeded 
should mean you accessed some address outside userspace)? Could you please test 
this by trying to run the tests with stack_size%4 != 0 (eg. pass PAGE_SIZE+1 to 
ltp_clone, subtract 1 in ltp_clone and so on).

Regards
     Jiri Palecek

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
