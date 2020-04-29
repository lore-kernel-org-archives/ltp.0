From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 29 Apr 2020 06:42:46 -0700
Subject: [LTP] [PATCH] Define __NR_futex to be __NR_futex_time64 on
 riscv32
In-Reply-To: <20200429131624.GB10236@dell5510>
References: <20200429033511.1848449-1-raj.khem@gmail.com>
 <20200429131624.GB10236@dell5510>
Message-ID: <CAMKF1srKzdh=VnoxDyumQHo25-ZWREcRPkyJ+V5tW4vZdiMuZA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 29, 2020 at 6:16 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Khem,
>
> > RISCV glibc has decided to use 64bit time_t from get go unlike
> > other 32bit architecture therefore aliasing __NR_futex to
> > __NR_futex_time64 helps avoid the below errors on rv32
>
> > tst_checkpoint.c:99:17: error: use of undeclared identifier 'SYS_futex'
>
> Thanks for your fix.
>
> BTW, out of curiosity, is Risc-v 32 bit merged into glibc master?

Not yet but its almost finalised and should be merged before 2.32 hopefully

>
> I found a patch from Alistair Francis from January, which implements what you claim:
> https://sourceware.org/legacy-ml/libc-alpha/2020-01/msg00205.html
> ...
> +/* RV32 and RV64 both use 64-bit time_t */
> +#define __TIMESIZE     64
> diff --git a/sysdeps/unix/sysv/linux/riscv/bits/typesizes.h b/sysdeps/unix/sysv/linux/riscv/bits/typesizes.h
> ...
>

right

> (part of https://patches-gcc.linaro.org/project/glibc/list/?series=21554
> patchset) but it hasn't been merged yet to master.

Its being reviewed

>
> + There is older patchset from Zong Li, not yet merged.
> https://patches-gcc.linaro.org/cover/12952/
>

above patches are newer versions of this one.

> > Signed-off-by: Khem Raj <raj.khem@gmail.com>
> > ---
> >  lib/tst_checkpoint.c                        | 4 ++++
> >  testcases/kernel/syscalls/clone/clone08.c   | 4 ++++
> >  testcases/kernel/syscalls/futex/futextest.h | 4 ++++
> >  3 files changed, 12 insertions(+)
>
> > diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
> > index 5e5b11496c..0388e9db2f 100644
> > --- a/lib/tst_checkpoint.c
> > +++ b/lib/tst_checkpoint.c
> > @@ -21,6 +21,10 @@
> >   * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> >   */
>
> > +#if !defined(__NR_futex) && defined(__riscv) && __riscv_xlen == 32
> > +# define __NR_futex __NR_futex_time64
> > +#endif
>
> I guess this should go to include/lapi/futex.h, so we don't repeat ourselves.
> (and clone08.c needs to include it, others already do).
>

OK makes sense, will send v2 ?

> ...
>
> Kind regards,
> Petr
