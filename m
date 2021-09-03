From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 3 Sep 2021 14:20:28 +0200
Subject: [LTP] [PATCH] syscalls/aarch64: Remove 32 bit only syscalls
In-Reply-To: <CAK8P3a3wOfFnN5UQ6MC0z+PtCSmMz_3NFmatAuD1Lb6jH7J+YA@mail.gmail.com>
References: <20210902093655.6104-1-lkml@jv-coder.de>
 <20210902094219.xy73hs5ccafkrysr@vireshk-i7>
 <CAK8P3a3jH=4gq7gg64E-L158d8QZCpPjEaKBZiEY+mE+jN61Fw@mail.gmail.com>
 <84a0c4aa-4faf-4271-36c4-5570f8c3a004@jv-coder.de>
 <YTG/MERCvZkBalov@pevik>
 <CAK8P3a3wOfFnN5UQ6MC0z+PtCSmMz_3NFmatAuD1Lb6jH7J+YA@mail.gmail.com>
Message-ID: <YTITDDicfJpDabDy@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On Fri, Sep 3, 2021 at 6:22 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi all,

> > > Hi Arnd,

> > > On 9/2/2021 8:32 PM, Arnd Bergmann wrote:

> > > > > > I am not 100% sure, how the syscall table for aarch64 is generated.
> > > > > > There are also compat version for some of the 32 bit only 64 bit syscalls,
> > > > > > but I think they are only available, when running an 32 bit arm application.
> > > > The syscall table for aarch64 is generated from the kernel's
> > > > include/uapi/asm-generic/unistd.h, which has a number of #ifdefs in
> > > > it. A lot of these are disabled on aarch64 since they refer to older or
> > > > 32-bit-only calls.

> > > > https://marcin.juszkiewicz.com.pl/download/tables/syscalls.html has a table
> > > > with the correct set of syscalls for each architecture, and scripts to generate
> > > > them from both the old asm-generic/unistd.h method (now only still used on
> > > > modern architectures) and the newer syscall.tbl format (used on older
> > > > architectures)
> > @Arnd: thanks a lot for this table and explanations! I would not expect this
> > kind of error in kernel sources.

> I don't see anything wrong in the kernel sources here, just a little misleading
> when read by a human rather than a compiler.

> > When I changed / reviewed syscall numbers for LTP, I usually compared with
> > kernel and musl sources. I never noticed change, but now I see for
> > clock_gettime64 it's in musl only for arm (arch/arm/bits/syscall.h.in), but in
> > kernel it's not only for arm, but also for arm64:
> > arm64/include/asm/unistd.h:30:#define __NR_compat_clock_gettime64       403

> This is a kernel-internal definition that is used to build the 32-bit VDSO. The
> file is not made available to user space applications.

Thanks for info!

> The file you need to look at for arm64 is include/uapi/asm-generic/unistd.h.
> As I said, that file has a lot of #ifdefs and other magic in it, but I suppose
> we could come up with a script to process it with /usr/bin/unifdef to only
> get the parts you are interested in. Ideally though we would just
> convert it into the modern machine-readable syscall.tbl format.

+1

Kind regards,
Petr

>         Arnd
