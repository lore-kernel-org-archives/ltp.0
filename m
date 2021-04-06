From: Eric Dumazet <edumazet@google.com>
Date: Tue, 6 Apr 2021 09:09:32 +0200
Subject: [LTP] [tcp] 4ecc1baf36: ltp.proc01.fail
In-Reply-To: <20210406063924.GC7352@xsang-OptiPlex-9020>
References: <20210406063924.GC7352@xsang-OptiPlex-9020>
Message-ID: <CANn89iL+Df9hDAkt7fPH3Dc-2CDvuLWdUAOuZB77QMNWYu_yMw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 6, 2021 at 8:41 AM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 4ecc1baf362c5df2dcabe242511e38ee28486545 ("tcp: convert elligible sysctls to u8")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>

I think this has been fixed with commit
d24f511b04b8b159b705ec32a3b8782667d1b06a ("tcp: fix tcp_min_tso_segs sysctl")

Thanks

>
> proc01      0  TINFO  :  /proc/sys/fs/binfmt_misc/register: is write-only.
> proc01      1  TFAIL  :  proc01.c:402: read failed: /proc/sys/net/ipv4/tcp_min_tso_segs: errno=EINVAL(22): Invalid argument

...

> proc01      2  TFAIL  :  proc01.c:471: readproc() failed with 1 errors.
> <<<execution_status>>>
> initiation_status="ok"
> duration=2 termination_type=exited termination_id=1 corefile=no
> cutime=13 cstime=233
> Oliver Sang
>
