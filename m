From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Apr 2020 15:34:01 +0200
Subject: [LTP] [PATCH] Define __NR_futex to be __NR_futex_time64 on
 riscv32
In-Reply-To: <20200429131624.GB10236@dell5510>
References: <20200429033511.1848449-1-raj.khem@gmail.com>
 <20200429131624.GB10236@dell5510>
Message-ID: <20200429133401.GA3854@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Khem,

> > +#if !defined(__NR_futex) && defined(__riscv) && __riscv_xlen == 32
> > +# define __NR_futex __NR_futex_time64
> > +#endif

> I guess this should go to include/lapi/futex.h, so we don't repeat ourselves.
> (and clone08.c needs to include it, others already do).

I've noticed that we still don't have risc-v support in include/lapi/syscalls/.
IMHO adding it would be better, than fixing just one missing __NR numbers.

Kind regards,
Petr
