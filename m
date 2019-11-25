From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Nov 2019 14:29:57 +0100
Subject: [LTP] [PATCH] memcg_lib/memcg_process: Better synchronization
 of signal USR1
In-Reply-To: <365bdf26-4e52-2159-17cd-52f2fb22e7fd@jv-coder.de>
References: <20191106073621.58738-1-lkml@jv-coder.de>
 <365bdf26-4e52-2159-17cd-52f2fb22e7fd@jv-coder.de>
Message-ID: <20191125132957.GC8703@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Actually this does not work like this, because some of the
> tests trigger the oom killer and TEST_CHECKPOINT_WAIT calling
> tst_checkpoint uses ROD. Is it ok to directly call
> 
> tst_checkpoint wait 10000 "1"
> 
> and ignore the result here?

Wouldn't that delay the test for too long?

The default timeout for checkpoints is probably too big.

This problem is quite tricky to get right I guess. Maybe we can watch
/proc/[pid]/statm for increase data + stack memory.

> BTW: Is there no such thing like TST_CHECKPOINT in the new
> shell test library?

It does not seem to be there, but these shell functions are just
wrappers that do check the tst_checkpoint return value, which would be
fairly easy to add.

-- 
Cyril Hrubis
chrubis@suse.cz
