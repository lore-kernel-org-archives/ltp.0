From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Nov 2016 16:04:39 +0100
Subject: [LTP] [PATCH] syscalls/getpriority01: exclude default priority
 check for PRIO_USER.
In-Reply-To: <5835368B.1080502@cn.fujitsu.com>
References: <1479362570-12526-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20161122085616.GB7048@rei.lan> <58341129.4000003@cn.fujitsu.com>
 <20161122093742.GD7048@rei.lan> <5835368B.1080502@cn.fujitsu.com>
Message-ID: <20161123150439.GM3346@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> It happens on Fedora20, RHEL5.11GA, RHEL6.8GA, RNEL7.3GA, testing returns
> >> -20 and -11 for PRIO_USER as root and nobody respectively.
> > 
> > Hmm, are you sure that this is not a bug? Since -20 is the highest
> > priority for a process, it does not make much sense to run all root
> > processes like that.
> 
> Yes, not all root processes are -20 on my system, but sorry, I am afraid
> it's not a bug, because man page says that the getpriority() call returns
> the highest priority (lowest numerical value) enjoyed by any of the
> specified processes, so if only there is one process is -20, the getpriority()
> will return -20.

Ah, my bad, sure we can't really say if there is a process that belongs
to the same user with priority lower than 0.

So what about we define a range in which the return value should be and
set it to 0 .. 0 for PRIO_PROCESS and PRIO_PGRP and to -20 .. 0 for
PRIO_USER?

-- 
Cyril Hrubis
chrubis@suse.cz
