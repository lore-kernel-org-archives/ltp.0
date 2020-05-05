From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 May 2020 14:15:29 +0200
Subject: [LTP] [PATCH] Define __NR_futex to be __NR_futex_time64 on
 riscv32
In-Reply-To: <CAMKF1srKzdh=VnoxDyumQHo25-ZWREcRPkyJ+V5tW4vZdiMuZA@mail.gmail.com>
References: <20200429033511.1848449-1-raj.khem@gmail.com>
 <20200429131624.GB10236@dell5510>
 <CAMKF1srKzdh=VnoxDyumQHo25-ZWREcRPkyJ+V5tW4vZdiMuZA@mail.gmail.com>
Message-ID: <20200505121529.GA6299@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Khem,

sorry for a delay.
> > > RISCV glibc has decided to use 64bit time_t from get go unlike
> > > other 32bit architecture therefore aliasing __NR_futex to
> > > __NR_futex_time64 helps avoid the below errors on rv32

> > > tst_checkpoint.c:99:17: error: use of undeclared identifier 'SYS_futex'

> > Thanks for your fix.

> > BTW, out of curiosity, is Risc-v 32 bit merged into glibc master?

> Not yet but its almost finalised and should be merged before 2.32 hopefully
Nice!

> > I guess this should go to include/lapi/futex.h, so we don't repeat ourselves.
> > (and clone08.c needs to include it, others already do).


> OK makes sense, will send v2 ?
Yes please.

Kind regards,
Petr
