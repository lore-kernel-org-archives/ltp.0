Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ow8kf-0001up-2g
	for ltp-list@lists.sourceforge.net; Thu, 16 Sep 2010 07:19:25 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ow8ke-0002Nh-A2
	for ltp-list@lists.sourceforge.net; Thu, 16 Sep 2010 07:19:25 +0000
Received: by pzk37 with SMTP id 37so335569pzk.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 16 Sep 2010 00:19:18 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1081)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <AANLkTikYoJgSuX1e_=bUe2HHv68nT4so7vc0FEAZ8DDU@mail.gmail.com>
Date: Thu, 16 Sep 2010 00:19:16 -0700
Message-Id: <B7D4B536-ECC3-4367-B154-CD90019F3B4D@gmail.com>
References: <20100902144720.GA16059@saboteur.suse.cz>
	<1283789797.4947.18.camel@subratamodak.linux.ibm.com>
	<4C851BAD.9080207@linux.vnet.ibm.com>
	<1284020387.29634.4.camel@subratamodak.linux.ibm.com>
	<4C88F433.80301@linux.vnet.ibm.com>
	<1284443154.5001.8.camel@subratamodak.linux.ibm.com>
	<AANLkTikYoJgSuX1e_=bUe2HHv68nT4so7vc0FEAZ8DDU@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix realtime atomic_add() inline asm
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
To: Darren Hart <darren@dvhart.com>
Cc: ltp-list@lists.sourceforge.net, gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

On Sep 14, 2010, at 6:30 PM, Darren Hart wrote:

> For what it's worth, I think the bug that Cyril found just further
> supports Gowri's patch to get rid of the asm altogether and go with
> the glibc built-ins. This keeps all these sorts of low-level details
> in one place and avoids duplication. My two cents.
> 
> --
> Darren Hart
> 
> On Mon, Sep 13, 2010 at 10:45 PM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
>> On Thu, 2010-09-09 at 20:20 +0530, gowrishankar wrote:
>>> Hi Cyril,
>>> Do you wish to ack my patch ?
>> 
>> Cyril,
>> 
>> Waiting for your endorsement/rejection !!
>> 
>> Regards--
>> Subrata
>> 
>>> 
>>> Thanks,
>>> Gowrishankar
>>> 
>>> On Thursday 09 September 2010 01:49 PM, Subrata Modak wrote:
>>>> Can both of you agree to send a single patch ?
>>>> 
>>>> Regards--
>>>> Subrata
>>>> 
>>>> On Mon, 2010-09-06 at 22:19 +0530, gowrishankar wrote:
>>>> 
>>>>> On Monday 06 September 2010 09:46 PM, Subrata Modak wrote:
>>>>> 
>>>>>> Darren/Gowri,
>>>>>> 
>>>>>> Are you aware of this patch ? Can you please provide your comments ?
>>>>>> 
>>>>>> 
>>>>>> 
>>>>> Subrata/Cyril,
>>>>> Apologies that I tagged this mail, but somehow forgot to reply
>>>>> immediately.
>>>>> 
>>>>> I had already prepared a patch (before Cyril shared his part) to make
>>>>> atomic_add much more maintenance free and sharing with you guys now.
>>>>> Please find it attached.
>>>>> 
>>>>> Thanks,
>>>>> Gowrishankar
>>>>> 
>>>>> 
>>>>>> Regards--
>>>>>> Subrata
>>>>>> 
>>>>>> On Thu, 2010-09-02 at 16:47 +0200, Cyril Hrubis wrote:
>>>>>> 
>>>>>> 
>>>>>>> Hi!
>>>>>>> The atomic_add() assembler for x86 is missing hint for gcc that value of
>>>>>>> v->counter is being modified by xaddl instruction and as this variable
>>>>>>> is changed only from this asm runtime, some combination of gcc
>>>>>>> optimalizations allows for this value to be placed in binary .rodata
>>>>>>> section resulting in realtime tests segfaulting when trying to do
>>>>>>> atomic_add(). It's reproducible on SLES11 (gcc 4.3.2) with -O2.
>>>>>>> 
>>>>>>> Patch attached.
>>>>>>> 
>>>>>>> Signed-off-by: Cyril Hrubis chrubis@suse.cz

	Agreed. In this particular case (IMO) LTP doesn't need to reimplement the atomic functions, because it's probably less tested and more buggy than the glibc equivalents.
	I'm [almost] always in favor of removing unnecessary duplication. This is one of the cases that I fully support.
Thanks,
-Garrett


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
