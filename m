From: Liam Howlett <liam.howlett@oracle.com>
Date: Wed, 24 Feb 2021 21:35:32 +0000
Subject: [LTP] [PATCH 1/1] brk02: Add test for removing more than one VMA
In-Reply-To: <YCZYB2w+Il5F0TlI@pevik>
References: <20210209143702.2003038-1-Liam.Howlett@Oracle.com>
 <20210209143702.2003038-2-Liam.Howlett@Oracle.com> <YCZYB2w+Il5F0TlI@pevik>
Message-ID: <20210224213520.rfdk2hdslqua7a2c@revolver>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Petr,

Thank you for looking at this patch.


* Petr Vorel <pvorel@suse.cz> [210212 05:27]:
> Hi Liam,
> 
> thanks for your patch. Minor notes below.
> 
> > When brk expands, it attempts to expand a VMA.  This expansion will
> > succeed depending on the anonymous VMA chain and if the vma flags are
> > compatible.  This test expands brk() then calls mprotect to ensure the
> > next brk call will create a new VMA, then it calls brk a final time to
> > restore the first brk address.  The test is the final brk call which
> > will remove more than an entire VMA from the vm area.
> 
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  testcases/kernel/syscalls/brk/brk02.c | 49 +++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 testcases/kernel/syscalls/brk/brk02.c
> 
> > diff --git a/testcases/kernel/syscalls/brk/brk02.c b/testcases/kernel/syscalls/brk/brk02.c
> > new file mode 100644
> > index 000000000..834fe9f2f
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/brk/brk02.c
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2021 Liam R. Howlett <liam.howlett@oracle.com>
> > + *
> > + *  
> nit: blank line
Will do.

> > + *  Expand the brk by 2 pages to ensure there is a newly created VMA and not
> > + *  expanding the original due to multiple anon pages.  mprotect that new VMA
> > + *  then brk back to the original address therefore causing a munmap of at
> > + *  least one full VMA.
> > + */
> > +
> > +#include <unistd.h>
> > +#include <stdint.h>
> nit: Not sure if <stdint.h> is needed.

It is not, thank you.  I will fix it.

> 
> > +#include <sys/mman.h>
> > +
> > +#include "tst_test.h"
> > +
> > +void brk_down_vmas(void)
> > +{
> > +	void *brk_addr = sbrk(0);
> > +	unsigned long page_size = getpagesize();
> > +	void *addr = brk_addr + page_size;
> > +
> > +	if (brk(addr))
> > +		return;
> > +
> > +	addr += page_size;
> > +	if (brk(addr))
> > +		return;
> You need to add tst_ret(TFAIL, "failed due ..."); before each return otherwise
> you get error:
> tst_test.c:1080: TBROK: Test haven't reported results!

I believe you mean tst_res().  I will fix it.

> 
> > +
> > +	if (mprotect(addr - page_size, page_size,
> > +			PROT_READ|PROT_WRITE|PROT_EXEC))
> > +		return;
> > +
> > +	addr += page_size;
> > +	if (brk(addr))
> > +		return;
> > +
> > +	if (brk(brk_addr))
> > +		return;
> > +
> > +
> > +
> Please remove these blank lines.

Will do.

Thank you,
Liam

> > +	tst_res(TPASS, "munmap two VMAs of brk() passed.");
> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = brk_down_vmas,
> > +};
> 
> Kind regards,
> Petr
