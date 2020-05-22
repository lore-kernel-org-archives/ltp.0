From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 22 May 2020 14:38:08 +0530
Subject: [LTP] [PATCH 0/5] syscalls: Add tests to verify the _time_high
 fields
In-Reply-To: <20200521142510.GD7833@yuki.lan>
References: <cover.1590057824.git.viresh.kumar@linaro.org>
 <CAK8P3a2N-J5LoNPHa7hjRPcOR0ytNfZQ678pFuCJaJJHGYS--A@mail.gmail.com>
 <20200521142510.GD7833@yuki.lan>
Message-ID: <20200522090808.uobmfe4rw7qfmqf4@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 21-05-20, 16:25, Cyril Hrubis wrote:
> Hi!
> > > This patchset adds a new test to three syscalls to verify that the
> > > extended fields, _time_high, are cleared by the kernel. This was
> > > suggested by Arnd.
> > >
> > > I did run them, but on a 64 bit machine. Please see if you can check
> > > that they work properly on 32 bit machines, where we really want to test
> > > them. This is rebased over ltp master.
> > >
> > > Cyril, This conflicts a bit with my other time64 syscall tests, I will
> > > rebase one of these, after you apply any of these first :)
> > 
> > The known bugs we had here were actually on 64-bit machines running
> > compat 32-bit user space. You should be able to test this on most
> > 64-bit distros using the compat libraries and building ltp against the
> > 32-bit version (not sure what the best way is to configure that, but it
> > should not be hard).
> 
> We run LTP compiled with -m32 in our automation in SUSE precisely
> because of these reasons. Not sure if somebody else does that.

Okay, I tested LTP with:

LDFLAGS=-m32 CFLAGS=-m32 ./configure

and the time-high fields got cleared on my x86 machine with 5.5 kernel.

-- 
viresh
