From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Nov 2019 16:32:45 +0100
Subject: [LTP] [PATCH] memcg_lib/memcg_process: Better synchronization
 of signal USR1
In-Reply-To: <2e5756af-d7ef-7919-da6b-46e7fbf3cb66@jv-coder.de>
References: <20191106073621.58738-1-lkml@jv-coder.de>
 <365bdf26-4e52-2159-17cd-52f2fb22e7fd@jv-coder.de>
 <20191125132957.GC8703@rei.lan>
 <2e5756af-d7ef-7919-da6b-46e7fbf3cb66@jv-coder.de>
Message-ID: <20191125153245.GA15129@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> Actually this does not work like this, because some of the
> >> tests trigger the oom killer and TEST_CHECKPOINT_WAIT calling
> >> tst_checkpoint uses ROD. Is it ok to directly call
> >>
> >> tst_checkpoint wait 10000 "1"
> >>
> >> and ignore the result here?
> > Wouldn't that delay the test for too long?
> >
> > The default timeout for checkpoints is probably too big.
> >
> > This problem is quite tricky to get right I guess. Maybe we can watch
> > /proc/[pid]/statm for increase data + stack memory.
> The timeout is specified on the command line (the 10000) in ms.

Ah, sorry I was blind.

> We run the test with timeout=1000 now and it works fine. It is simpler 
> than thinking about any
> other synchronization technique. The additonal wait adds less than 30 
> for all tests, that use memcg_process.

30 what? seconds? That is unfortunatelly not acceptable.

Actually having a closer look at the code there is a loop that checks
every 100ms if:

1) the process is still alive
2) if there was increase in usage_in_bytes in the corresponding cgroup

So what is wrong with the original code?

-- 
Cyril Hrubis
chrubis@suse.cz
