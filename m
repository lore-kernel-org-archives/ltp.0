From: Li Wang <liwang@redhat.com>
Date: Mon, 2 Nov 2020 15:41:10 +0800
Subject: [LTP] [PATCH] syscalls/ptrace08: Add another linux tag
In-Reply-To: <1604298483-18563-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1604298483-18563-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2dLV3g7P4+FwuBaL06UDt3Ae_k+6JCQMJ_221AGqCRDNQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Nov 2, 2020 at 2:28 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

> Since "syscall/ptrace08: Simplify the test", on older kernels we check
> that the
> POKEUSER to dr7 that enables the breakpoint fails properly after the dr0
> has been
> set to an address in the kernel range.
>
> on centos7.8GA, it can expose a failure as below:
> tst_test.c:1250: TINFO: Timeout per run is 0h 05m 00s
> tst_kernel.c:79: TINFO: uname.machine=x86_64 kernel is 64bit
> ptrace08.c:90: TINFO: Trying address 0xffff800000000000
> ptrace08.c:120: TPASS: ptrace() breakpoint with kernel addr failed: EINVAL
> (22)
> ptrace08.c:129: TINFO: 0xffff800000000000
> ptrace08.c:90: TINFO: Trying address 0xffffffffffffffff
> ptrace08.c:116: TFAIL: ptrace() breakpoint with kernel addr succeeded
> ptrace08.c:129: TINFO: 0xffffffffffffffff
> ptrace08.c:90: TINFO: Trying address 0xffffbfffffffffff
> ptrace08.c:120: TPASS: ptrace() breakpoint with kernel addr failed: EINVAL
> (22)
> ptrace08.c:129: TINFO: 0xffffbfffffffffff
>
> It fails because x86 hw_breakpoint code can't parse this
> 0xffffffffffffffff kernel
> address on x86_64 platform.
>
> arch/x86/kernel/hw_breakpoint.c
>  int arch_check_bp_in_kernelspace(struct perf_event *bp)
>         return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
>
> TASK_SIZE is small and value will overflow if we use 0xffffffffffffffff
> address
> (va is unsigned long and len is unsigned int).
>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>

Patch applied. Thanks!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201102/16d7fbbd/attachment.htm>
