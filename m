From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 16 Nov 2020 10:03:35 -0800
Subject: [LTP] [PATCH] Define SYS_futex on 32bit arches using 64-bit
 time_t
In-Reply-To: <20201116170320.GC152616@pevik>
References: <20201116003345.3261577-1-raj.khem@gmail.com>
 <20201116070857.GB81864@pevik>
 <CAMKF1sqjVMexm38VVt=grmL-K63=hyfA-0aoNyi=53TyFVXJ0w@mail.gmail.com>
 <20201116170320.GC152616@pevik>
Message-ID: <CAMKF1srem0H=hkjkD_Yb1qzyygbbosB06y9x6=g+PasASQrqRQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Nov 16, 2020 at 9:03 AM Petr Vorel <petr.vorel@gmail.com> wrote:
>
> Hi Khem,
>
> > On Sun, Nov 15, 2020 at 11:08 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > > Hi Khem,
>
> > > > Newer 32bit arches like RISCV32 and ARC are using 64bit time_t
> > > > from get go unlike other 32bit architecture therefore aliasing
> > > __NR_futex to
> > > > __NR_futex_time64 helps avoid the below errors
>
> > > > tst_checkpoint.c:99:17: error: use of undeclared identifier 'SYS_futex'
>
> > > Thanks for your fix.
>
> > > I wonder if this could be defined just in include/lapi/futex.h and this:
>
>
> > > https://github.com/pevik/ltp/commit/a20107ab47554798e0de0347dd4d7259f01675af
>
>
> > It could be but it did not work everywhere when I tried it I guess this
> > header has to be included in all needed placed
>
> Sure, but that's done :)
>
> You put the changes into 3 files:
> lib/tst_checkpoint.c
> testcases/kernel/syscalls/clone/clone08.c
> testcases/kernel/syscalls/futex/futextest.h
>
> Check the affected files:
>
> I put changes into include/lapi/futex.h
> and load it in
> testcases/kernel/syscalls/clone/clone08.c
>
> The other two (testcases/kernel/syscalls/clone/clone08.c
> testcases/kernel/syscalls/futex/futextest.h) already include lapi/futex.h.
>
> Are you sure it's failing when you try my patchset?
>

I tested https://github.com/pevik/ltp/commit/a20107ab47554798e0de0347dd4d7259f01675af
and it works fine. So please use this one.

> Kind regards,
> Petr
