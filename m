From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 23 Nov 2016 14:26:19 +0800
Subject: [LTP] [PATCH] syscalls/getpriority01: exclude default priority
 check for PRIO_USER.
In-Reply-To: <20161122093742.GD7048@rei.lan>
References: <1479362570-12526-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20161122085616.GB7048@rei.lan> <58341129.4000003@cn.fujitsu.com>
 <20161122093742.GD7048@rei.lan>
Message-ID: <5835368B.1080502@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 11/22/2016 05:37 PM, Cyril Hrubis wrote:
> Hi!
>>>> The current user priority is various when testing,
>>>> we should not check it as default value.
>>>
>>> What system does this happen on? It should probably be mentioned in the
>>> commit message.
>>
>> It happens on Fedora20, RHEL5.11GA, RHEL6.8GA, RNEL7.3GA, testing returns
>> -20 and -11 for PRIO_USER as root and nobody respectively.
> 
> Hmm, are you sure that this is not a bug? Since -20 is the highest
> priority for a process, it does not make much sense to run all root
> processes like that.

Yes, not all root processes are -20 on my system, but sorry, I am afraid
it's not a bug, because man page says that the getpriority() call returns
the highest priority (lowest numerical value) enjoyed by any of the
specified processes, so if only there is one process is -20, the getpriority()
will return -20.

Best Regards,
Guangwen Feng

> 
> Also the nice value gets inherited via fork, so it may be that if you
> are connecting to the machine via ssh the ssh process gets priority so
> that the machine stays responsive even under load, which is inherited by
> the shell and then inherited by the test. But even then the -20 sounds
> a bit too much.
> 


