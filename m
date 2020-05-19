From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 May 2020 11:14:04 +0200
Subject: [LTP] [PATCH V3 00/17] Syscalls: Add support for time64 variants
In-Reply-To: <20200519085425.vajbfnt7uj7yjq5k@vireshk-i7>
References: <cover.1589789487.git.viresh.kumar@linaro.org>
 <CAK8P3a3aP5S_w_FFv=UvJRSRTjcoNVy_W6ycm4OTct-7Q_5_xg@mail.gmail.com>
 <20200518091253.qmvqo7xub7hpeovm@vireshk-i7>
 <CAK8P3a3_dGzoGPckBByySvLYGC3FyiCSwCdfzxG8xjJsY0oXrg@mail.gmail.com>
 <20200519085425.vajbfnt7uj7yjq5k@vireshk-i7>
Message-ID: <CAK8P3a1=VY7fw3NZuo_koRKDiOe1wsUpqBmhy6oJqLvOhtbBEA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 19, 2020 at 10:54 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-05-20, 11:21, Arnd Bergmann wrote:
> > On Mon, May 18, 2020 at 11:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > Ahh, if I understand correct you are only talking about the cases
> > > where the syscall is called directly without the libc wrapper, right ?
> > > We can't use timeval/timespec there anymore.
> >
> > Exactly.
>
> There weren't a lot of offenders I believe. I have fixed them and sent a
> patchset for that.
>
> > There are probably also ioctls with the same problem, but
> > I don't know which ioctl commands are actually tested by ltp.
> >
> > I would guess that the socket timestamps (both ioctl and
> > setsockopt based ones) do have some tests that need to be
> > updated.
>
> I tried to do some search based on:
>
> git grep "ioctl" `git grep -l tst_syscall`
> git grep "setsockopt" `git grep -l tst_syscall`
>
> but found nothing :(
>
> Do I need to look for something else ?

I just tried looking for socket timestamps using

git grep 'SO_TIMESTAMP\|SIOCGSTAMP\|SO_.*TIMEO'

but that also did not find any tests. I guess those interfaces are
currently not tested as part of LTP at all. Testing for setsockopt
only covers a very small subset of the system call.

Same for the SNDDRV_, PPP, PP?ETTIME, ioctls, which are
somewhat device specific. It might be good to test the snddrv
interfaces, but they probably have a separate testsuite somewhere
outside of LTP already.

I did find something for v4l2 (VIDIOC_QUERYBUF, VIDIOC_QBUF,
VIDIOC_DQBUF, VIDIOC_DQEVENT), but haven't looked at
what the tests do.

I also see tests for input_event in testcases/kernel/input/. These
seem fine as they include the kernel header for 'struct input_event',
which is the correct approach.

One other interface affected by the time64 changes is elf_prstatus
for core dumps. This is not a system call though, and it does
not have a test case either.

        Arnd
