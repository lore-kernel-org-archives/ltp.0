From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 24 Nov 2016 15:02:29 +0800
Subject: [LTP] [PATCH] syscalls/getpriority01: exclude default priority
 check for PRIO_USER.
In-Reply-To: <20161123150439.GM3346@rei.lan>
References: <1479362570-12526-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20161122085616.GB7048@rei.lan> <58341129.4000003@cn.fujitsu.com>
 <20161122093742.GD7048@rei.lan> <5835368B.1080502@cn.fujitsu.com>
 <20161123150439.GM3346@rei.lan>
Message-ID: <58369085.1000109@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 11/23/2016 11:04 PM, Cyril Hrubis wrote:
> Hi!
>>>> It happens on Fedora20, RHEL5.11GA, RHEL6.8GA, RNEL7.3GA, testing returns
>>>> -20 and -11 for PRIO_USER as root and nobody respectively.
>>>
>>> Hmm, are you sure that this is not a bug? Since -20 is the highest
>>> priority for a process, it does not make much sense to run all root
>>> processes like that.
>>
>> Yes, not all root processes are -20 on my system, but sorry, I am afraid
>> it's not a bug, because man page says that the getpriority() call returns
>> the highest priority (lowest numerical value) enjoyed by any of the
>> specified processes, so if only there is one process is -20, the getpriority()
>> will return -20.
> 
> Ah, my bad, sure we can't really say if there is a process that belongs
> to the same user with priority lower than 0.
> 
> So what about we define a range in which the return value should be and
> set it to 0 .. 0 for PRIO_PROCESS and PRIO_PGRP and to -20 .. 0 for
> PRIO_USER?

Sounds good, I will rewrite the patch, thanks.

Best Regards,
Guangwen Feng


