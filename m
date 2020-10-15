From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 15 Oct 2020 21:06:20 +0200
Subject: [LTP] [RFC PATCH 1/1] lapi: Add sysinfo.h to fix build with
 MUSL libc
In-Reply-To: <20201014143317.GC13224@yuki.lan>
References: <20201001231256.6930-1-petr.vorel@gmail.com>
 <20201014143317.GC13224@yuki.lan>
Message-ID: <20201015190620.GA9408@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

thanks for your review!

...
> > +++ b/include/lapi/sysinfo.h
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2020 Petr Vorel <petr.vorel@gmail.com>
> > + */
> > +
> > +#ifndef SYSINFO_H__
> > +
> > +/*
> > + * Don't use <sys/sysinfo.h> as it breaks build MUSL toolchain.
> > + * Use <linux/sysinfo.h> instead.
> > + *
> > + * Some kernel UAPI headers do indirect <linux/sysinfo.h> include:
> > + * <linux/netlink.h> or others -> <linux/kernel.h> -> <linux/sysinfo.h>
> > + *
> > + * This indirect include causes on MUSL redefinition of struct sysinfo when
> > + * included both <sys/sysinfo.h> and some of UAPI headers:
> > + */
> > +#include <linux/sysinfo.h>
> > +
> > +#define SYSINFO_H__
> > +
> > +#endif /* SYSINFO_H__ */

> Well the #define SYSINFO_H__ usually goes right after the #ifndef on the
> top.
+1. It'd be in v2 if needed.
I've added this patch already to buildroot, but if kernel patch get accepted,
it'd be kept only temporarily (I think they don't have patches for musl based
toolchains, otherwise they'd take Alpine's patch by now. But they instead drop
support for these toolchains in packages which don't upstream the solution.

> Apart from that it looks like the kernel patch has been ignored. I guess
> that you should try to push it a bit more before we give up and apply
> workarounds...
Tried next version, let's see.
https://lore.kernel.org/linux-api/20201015190013.8901-1-petr.vorel@gmail.com/

Kind regards,
Petr
