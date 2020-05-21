From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 May 2020 16:25:10 +0200
Subject: [LTP] [PATCH 0/5] syscalls: Add tests to verify the _time_high
 fields
In-Reply-To: <CAK8P3a2N-J5LoNPHa7hjRPcOR0ytNfZQ678pFuCJaJJHGYS--A@mail.gmail.com>
References: <cover.1590057824.git.viresh.kumar@linaro.org>
 <CAK8P3a2N-J5LoNPHa7hjRPcOR0ytNfZQ678pFuCJaJJHGYS--A@mail.gmail.com>
Message-ID: <20200521142510.GD7833@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This patchset adds a new test to three syscalls to verify that the
> > extended fields, _time_high, are cleared by the kernel. This was
> > suggested by Arnd.
> >
> > I did run them, but on a 64 bit machine. Please see if you can check
> > that they work properly on 32 bit machines, where we really want to test
> > them. This is rebased over ltp master.
> >
> > Cyril, This conflicts a bit with my other time64 syscall tests, I will
> > rebase one of these, after you apply any of these first :)
> 
> The known bugs we had here were actually on 64-bit machines running
> compat 32-bit user space. You should be able to test this on most
> 64-bit distros using the compat libraries and building ltp against the
> 32-bit version (not sure what the best way is to configure that, but it
> should not be hard).

We run LTP compiled with -m32 in our automation in SUSE precisely
because of these reasons. Not sure if somebody else does that.

-- 
Cyril Hrubis
chrubis@suse.cz
