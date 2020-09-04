From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Sep 2020 15:30:01 +0200
Subject: [LTP] [PATCH] syscall/ptrace08: Simplify the test.
In-Reply-To: <20200904132121.GE4768@mussarela>
References: <20200904115817.8024-1-chrubis@suse.cz>
 <20200904132121.GE4768@mussarela>
Message-ID: <20200904133001.GA9091@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is failing on our 4.4 and 4.15 kernels, though they passed with the
> previous test and have commit f67b15037a7a applied.
> 
> So, this is dependent on some other behavior/commit that has changed. It passes
> on 5.4, for example. I'll try to investigate further.

We are looking at it now in SUSE, looks like the initial fix to the
kernel postponed the check to the write to the dr7 that enabled the
breakpoint, so when the dr0 wasn't enabled you could write anything
there.

Also looks like somehow the EINVAL is not propagated into the POKEUSER
call to the dr7 as it should have been.

-- 
Cyril Hrubis
chrubis@suse.cz
