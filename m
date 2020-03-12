From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Mar 2020 11:11:28 +0100
Subject: [LTP] [PATCH V5 04/10] syscalls/fsopen: New tests
In-Reply-To: <20200312100316.7w67e5salel3dfue@vireshk-i7>
References: <cover.1582779464.git.viresh.kumar@linaro.org>
 <495a95969c63d67868b82d2b15bd663f19780d0e.1582779464.git.viresh.kumar@linaro.org>
 <20200306131046.GC3375@rei.lan>
 <20200311072502.hpj5bycslu6ygk74@vireshk-i7>
 <20200312081153.GA16928@dell5510>
 <20200312100316.7w67e5salel3dfue@vireshk-i7>
Message-ID: <20200312101127.GA3803@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > > I gues sthat the SAFE_UMOUNT() should be inside of the if here and in
> > > > the rest of the testcases.
> > 
> > > Petr had a similar comment earlier and here is my explanation to it.
> > 
> > > There should always be a unmount() in response to a successful call to
> > > mount() APIs. What if, because of some other bugs in the kernel or
> > > testsuite, tst_is_mounted() returns 0? We should still do the
> > > unmount() part as the mount() API didn't return an error.
> > But IMHO if device is not mounted we get TBROK due EINVAL in safe_umount().
> 
> But why won't move_mount() fail if device isn't mounted ? Why do we
> need the tst_is_mounted() helper at all ? Just to catch a case where
> move_mount() is buggy and doesn't report the failure properly, right ?
> In case of that bug, isn't it possible that move_mount() allocates
> some resources which must be freed with a call to umount()
> nevertheless ?

We can't really clean things up when something in kernel is misbehaving.
If there is a bug we enter the wast lands of undefined behavior where
anything is possible and any attempt to restore the system in a defined
state is doomed to fail anyways.

So in the end I do not care here as long as we clean up properly when
things work as expected, so either way is fine. It only looks a bit
strange when we attempt to umount things that are possibly not mounted.

-- 
Cyril Hrubis
chrubis@suse.cz
