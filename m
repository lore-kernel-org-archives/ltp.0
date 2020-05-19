From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 19 May 2020 14:24:25 +0530
Subject: [LTP] [PATCH V3 00/17] Syscalls: Add support for time64 variants
In-Reply-To: <CAK8P3a3_dGzoGPckBByySvLYGC3FyiCSwCdfzxG8xjJsY0oXrg@mail.gmail.com>
References: <cover.1589789487.git.viresh.kumar@linaro.org>
 <CAK8P3a3aP5S_w_FFv=UvJRSRTjcoNVy_W6ycm4OTct-7Q_5_xg@mail.gmail.com>
 <20200518091253.qmvqo7xub7hpeovm@vireshk-i7>
 <CAK8P3a3_dGzoGPckBByySvLYGC3FyiCSwCdfzxG8xjJsY0oXrg@mail.gmail.com>
Message-ID: <20200519085425.vajbfnt7uj7yjq5k@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18-05-20, 11:21, Arnd Bergmann wrote:
> On Mon, May 18, 2020 at 11:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Ahh, if I understand correct you are only talking about the cases
> > where the syscall is called directly without the libc wrapper, right ?
> > We can't use timeval/timespec there anymore.
> 
> Exactly.

There weren't a lot of offenders I believe. I have fixed them and sent a
patchset for that.

> There are probably also ioctls with the same problem, but
> I don't know which ioctl commands are actually tested by ltp.
> 
> I would guess that the socket timestamps (both ioctl and
> setsockopt based ones) do have some tests that need to be
> updated.

I tried to do some search based on:

git grep "ioctl" `git grep -l tst_syscall`
git grep "setsockopt" `git grep -l tst_syscall`

but found nothing :(

Do I need to look for something else ?

-- 
viresh
