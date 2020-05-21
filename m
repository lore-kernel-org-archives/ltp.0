From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 May 2020 16:29:42 +0200
Subject: [LTP] [PATCH 0/5] syscalls: Add tests to verify the _time_high
 fields
In-Reply-To: <20200521142510.GD7833@yuki.lan>
References: <cover.1590057824.git.viresh.kumar@linaro.org>
 <CAK8P3a2N-J5LoNPHa7hjRPcOR0ytNfZQ678pFuCJaJJHGYS--A@mail.gmail.com>
 <20200521142510.GD7833@yuki.lan>
Message-ID: <20200521142942.GF7833@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The known bugs we had here were actually on 64-bit machines running
> > compat 32-bit user space. You should be able to test this on most
> > 64-bit distros using the compat libraries and building ltp against the
> > 32-bit version (not sure what the best way is to configure that, but it
> > should not be hard).
> 
> We run LTP compiled with -m32 in our automation in SUSE precisely
> because of these reasons. Not sure if somebody else does that.

In addition to a normal runs. And we also run syscalls with various
kernel debugging enabled, I guess we have one flavor with SLUB_DEBUG
etc.

-- 
Cyril Hrubis
chrubis@suse.cz
