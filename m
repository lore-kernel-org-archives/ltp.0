From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Jan 2021 20:17:27 +0530
Subject: [LTP] [PATCH] tst_pollute_memory(): Set minimal safety margin
 to 64MB
In-Reply-To: <YAbT62ecN/lq12cT@yuki.lan>
References: <20210118163240.29558-1-mdoucha@suse.cz>
 <YAbT62ecN/lq12cT@yuki.lan>
Message-ID: <CA+G9fYv_6tiMrF38jLPYK=C6D+LNBndun1XuGQJiOK60LhYRyA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 19 Jan 2021 at 18:12, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> >       SAFE_SYSINFO(&info);
> > -     safety = 4096 * SAFE_SYSCONF(_SC_PAGESIZE) / info.mem_unit;
> > +     safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 64 * 1024 * 1024);
> > +     safety /= info.mem_unit;
>
> I guess that this is safe enough for the release, since it will only
> increase the safety margin.
>
> Naresh can you please test this patch ASAP?

I have applied your patch and rebuilt completely and retested
ioctl_sg01 test case in a loop on three different devices.

1 PASS out of 20 runs with overcommit_memory 0 on x86_64.
1 PASS out of 20 runs with overcommit_memory 1 on x86_64.

Which means 19 times the test case triggered oom-killer and the test was broken.

- Naresh
