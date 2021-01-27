From: liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn>
Date: Wed, 27 Jan 2021 20:14:33 +0800
Subject: [LTP] [PATCH] Fix tst_pollute_memory() safety margin for huge
 systems
References: <20210127115606.28985-1-mdoucha@suse.cz>, 
 <YBFWrJoS1tVmWGFx@yuki.lan>
Message-ID: <2021012720143348660139@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

According my test,malloc amount greater than available memory,then invoke the oom-killer.
#man free  
Estimation of how much memory is available for starting new applications, without swapping.

    [root@liuxp mywork]# head /proc/meminfo
    MemTotal:       198101744 kB
    MemFree:        189303148 kB
    MemAvailable:   188566732 kB

Set safety margin to larger value, may be not sensible.

From: Cyril Hrubis
Date: 2021-01-27 20:03
To: Martin Doucha
CC: liuxp11; ltp
Subject: Re: [LTP] [PATCH] Fix tst_pollute_memory() safety margin for huge systems
Hi!
Actually I've been thinking about this one and since this is a strictly
best effort action I think we should be more aggressive about the safety
margin.
 
I also started to talk to kernel developers about this and generally
about tests that try to allocate maximal amount of memory without
triggering OOM since we have a few in the tree. I will send the results
of this discussion once I have any here as well.
 
-- 
Cyril Hrubis
chrubis@suse.cz
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210127/ddde8d39/attachment.htm>
