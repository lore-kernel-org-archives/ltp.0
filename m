From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Jul 2019 12:52:36 +0200
Subject: [LTP] [PATCH v3] syscalls/mbind0{2,3,4}: Add basic mbind tests
In-Reply-To: <CAEemH2d2+X=qOvfb-B9r-CKTvOmC=0kuDGqci0XLFc3bM9U_fA@mail.gmail.com>
References: <20190723115937.27247-1-chrubis@suse.cz>
 <CAEemH2d2+X=qOvfb-B9r-CKTvOmC=0kuDGqci0XLFc3bM9U_fA@mail.gmail.com>
Message-ID: <20190724105236.GB17426@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +#include "tst_test.h"
> > +#include "tst_numa.h"
> > +
> > +#ifdef HAVE_NUMA_H
> 
> HAVE_NUMA_V2 is needed here, to avoid hitting cross-compilation failures.
>     https://travis-ci.com/wangli5665/ltp/builds/120315507

Ah, sorry, I've forgotten about these. I will fix that.

> In case you missed some comments from Petr, plz see:
>     http://lists.linux.it/pipermail/ltp/2019-June/012226.html
>     http://lists.linux.it/pipermail/ltp/2019-June/012227.html
>
> > +
> > +       TEST(mbind(ptr, size, mode, bm->maskp, bm->size + 1, MPOL_MF_STRICT));
> > +
> 
> Maybe we also need to move the tst_numa_unmap/numa_free_nodemask to
> here, in case of the mbind02 hit fail and return early.

Sure will do.

> Besides these tiny issues, patch v3 looks good to me.

Should I send a v4 or can I push the patch with your ack with these two
issues fixed?

-- 
Cyril Hrubis
chrubis@suse.cz
