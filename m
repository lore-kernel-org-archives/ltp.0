From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 3 Sep 2021 08:22:40 +0200
Subject: [LTP] [PATCH] syscalls/aarch64: Remove 32 bit only syscalls
In-Reply-To: <84a0c4aa-4faf-4271-36c4-5570f8c3a004@jv-coder.de>
References: <20210902093655.6104-1-lkml@jv-coder.de>
 <20210902094219.xy73hs5ccafkrysr@vireshk-i7>
 <CAK8P3a3jH=4gq7gg64E-L158d8QZCpPjEaKBZiEY+mE+jN61Fw@mail.gmail.com>
 <84a0c4aa-4faf-4271-36c4-5570f8c3a004@jv-coder.de>
Message-ID: <YTG/MERCvZkBalov@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> Hi Arnd,

> On 9/2/2021 8:32 PM, Arnd Bergmann wrote:

> > > > I am not 100% sure, how the syscall table for aarch64 is generated.
> > > > There are also compat version for some of the 32 bit only 64 bit syscalls,
> > > > but I think they are only available, when running an 32 bit arm application.
> > The syscall table for aarch64 is generated from the kernel's
> > include/uapi/asm-generic/unistd.h, which has a number of #ifdefs in
> > it. A lot of these are disabled on aarch64 since they refer to older or
> > 32-bit-only calls.

> > https://marcin.juszkiewicz.com.pl/download/tables/syscalls.html has a table
> > with the correct set of syscalls for each architecture, and scripts to generate
> > them from both the old asm-generic/unistd.h method (now only still used on
> > modern architectures) and the newer syscall.tbl format (used on older
> > architectures)
@Arnd: thanks a lot for this table and explanations! I would not expect this
kind of error in kernel sources.

When I changed / reviewed syscall numbers for LTP, I usually compared with
kernel and musl sources. I never noticed change, but now I see for
clock_gettime64 it's in musl only for arm (arch/arm/bits/syscall.h.in), but in
kernel it's not only for arm, but also for arm64:
arm64/include/asm/unistd.h:30:#define __NR_compat_clock_gettime64       403

Similarly timerfd_settime64 is for musl only for arm, in kernel for both.

All syscalls are *time64, that explains why they are only for 32bit.

> Thanks for this explanation, I already found this site, but wasn't sure if
> it is "correct".

> > It would be good to finally convert asm-generic/unistd.h to the new format
> > in order to automatically generate tables like the one used by ltp. In the
> > meantime, please double-check all architectures against Marcin's tables.
> > The same problem likely also exists elsewhere, e.g. for rv64.

> @all
> After Arnd's explanation, I guess this patch is correct and can be merged?
> Other architectures and the remaining syscalls should be checked as well.
> Maybe we can integrate Marcin's tool for extraction into ltp?
> See: https://github.com/hrw/syscalls-table
Sure.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Joerg
