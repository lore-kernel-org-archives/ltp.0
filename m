From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 May 2020 16:20:37 +0200
Subject: [LTP] [PATCH 3/5] syscalls: Don't use tst_syscall()
 unnecessarily
In-Reply-To: <20200520071948.qtuzbfesqvcnsizd@vireshk-i7>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <3f3b7d669d47ae701385b43deb8280a353dd231e.1589877853.git.viresh.kumar@linaro.org>
 <20200519122347.GC16008@yuki.lan>
 <CAK8P3a2PgjYyijH=VoNGhs_xk1VvFN6ZNvNM-W4TopWY6jJNbA@mail.gmail.com>
 <20200519134511.GD16008@yuki.lan>
 <20200520071948.qtuzbfesqvcnsizd@vireshk-i7>
Message-ID: <20200521142037.GC7833@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I guess that at the current time we do support distros that are at max
> > 10 years old, mostly because enterprise support cycles are about 10
> > years in lenght.
> > 
> > The issue here is that glibc needed -lrt passed to linker couple of
> > years ago and we wanted to avoid the need of linking everything with
> > -lrt, as calling the raw syscall was just easier fix.
> 
> To conclude the discussion, is this patch okay or not ? The reason why I am
> asking this is because this file still uses the old test framework and so can't
> include tst_timer.h, and so doesn't have access to struct __kernel_old_timespec.
> 
> What do you suggest I do here ?

Well if it was only about __kernel_old_timespec we could easily just
declare it locally in the file and be done with it.

But I guess that newer 32bit architectures will have only the 64 bit
syscall present, I think that somebody pointed out that this is the case
for 32bit RiscV. If that's true we will have to have a fallback for that
case as well.

-- 
Cyril Hrubis
chrubis@suse.cz
