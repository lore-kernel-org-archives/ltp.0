From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 29 Aug 2016 14:36:29 +0200
Subject: [LTP] [PATCH] syscalls/fallocate04: Fix on Btrfs
In-Reply-To: <57C42798.3010008@oracle.com>
References: <20160825165354.GA13281@rei> <57C02561.8000608@oracle.com>
 <57C03126.1020609@oracle.com> <20160829094436.GA30021@rei.lan>
 <57C42798.3010008@oracle.com>
Message-ID: <20160829123628.GC30021@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I understand that the size might be larger and we are allocating in 
> chunks for
> that reason. But here we have "cache" that equals the size of 
> allocation...  it just looks suspicious.

I know that this feels like an workaround, but I've been told that it's
OK. My guess is that it has something to do with the COW, it looks like
the whole write is done to a different set of blocks in this case and
that the preallocated blocks are discarded later when Btrfs figures out
that we do not need these. But that is just a guess, I'm not Btrfs
expert and I do not want to spend a week trying to figure out what
exactly is going on here. If you know somebody who can explain this
better, I would be glad to hear it.

> It's true, it doesn't matter if we have plenty of space and if we are 
> testing writes that shouldn't return ENOSPC.

That is the reason why I proposed this patch.

> > Another interesting testcase would be doing the same on the LTP loopback
> > device that would be filled up after the file has been preallocated.
> > That would likely force different codepath in the FS since there would
> > be no avaialable free space left...
> 
> On btrfs it will be hard to do, I mean filling free space :)

We can write to file(s) in a loop until we get ENOSPC, that should be as
close to real out-of-free-space situation as possible.

-- 
Cyril Hrubis
chrubis@suse.cz
