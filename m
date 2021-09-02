From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 2 Sep 2021 18:32:20 +0000
Subject: [LTP] [PATCH] syscalls/aarch64: Remove 32 bit only syscalls
In-Reply-To: <20210902094219.xy73hs5ccafkrysr@vireshk-i7>
References: <20210902093655.6104-1-lkml@jv-coder.de>
 <20210902094219.xy73hs5ccafkrysr@vireshk-i7>
Message-ID: <CAK8P3a3jH=4gq7gg64E-L158d8QZCpPjEaKBZiEY+mE+jN61Fw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 2, 2021 at 9:42 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> +Arnd
>
> On 02-09-21, 11:36, Joerg Vehlow wrote:
> > From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> >
> > These syscalls are not available in 64 bit builds of linux.
> > See: <linux>/include/uapi/asm-generic/unistd.h
> >
> > With the syscall defined, the test clock_gettim04 fails with
> > ../../../../include/tst_timer.h:216: TCONF: syscall(403) __NR_clock_gettime64 not supported
> >
> > Fixes: 59d278d61ed90117607f389326e0816a14dbf53c ("lapi/syscalls: Update syscall numbers")
> > Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> > ---
> >
> > I am not 100% sure, how the syscall table for aarch64 is generated.
> > There are also compat version for some of the 32 bit only 64 bit syscalls,
> > but I think they are only available, when running an 32 bit arm application.

The syscall table for aarch64 is generated from the kernel's
include/uapi/asm-generic/unistd.h, which has a number of #ifdefs in
it. A lot of these are disabled on aarch64 since they refer to older or
32-bit-only calls.

https://marcin.juszkiewicz.com.pl/download/tables/syscalls.html has a table
with the correct set of syscalls for each architecture, and scripts to generate
them from both the old asm-generic/unistd.h method (now only still used on
modern architectures) and the newer syscall.tbl format (used on older
architectures)

It would be good to finally convert asm-generic/unistd.h to the new format
in order to automatically generate tables like the one used by ltp. In the
meantime, please double-check all architectures against Marcin's tables.
The same problem likely also exists elsewhere, e.g. for rv64.

        Arnd
