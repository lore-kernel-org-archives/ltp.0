From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Jan 2019 11:40:07 +0100
Subject: [LTP] [PATCH] syscalls/ustat: convert to new lib,
 use direct syscall
In-Reply-To: <20190129180617.GD14252@dell5510>
References: <20190129023714.191820-1-smuckle@google.com>
 <20190129180617.GD14252@dell5510>
Message-ID: <20190130104007.GA32120@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +++ b/include/lapi/ustat.h
> > @@ -0,0 +1,8 @@
> > +#include <sys/types.h>
> I'd put here at least
> //SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +struct ustat {
> > +	daddr_t f_tfree;
> > +	ino_t f_tinode;
> > +	char f_fname[6];
> > +	char f_fpack[6];
> > +};
> Thinking about it twice, wouldn't be better to include <sys/ustat.h> and detect
> with autotools whether struct ustat is defined and use this only if it's not
> defined? The same approach we use for struct statx?

And we do have the configure check for ustat.h in place so this should
be as easy as doing:

#ifdef HAVE_SYS_USTAT_H
# include <sys/ustat.h>
#else
struct ustat {
...
}
#endif

Also ideally this header should include guards, even if it's unlikely to
be included twice.

> > +++ b/testcases/kernel/syscalls/ustat/ustat01.c
> > @@ -1,21 +1,7 @@
> > +// SPDX-License-Identifier: GPL-2.0
> @Cyril: can we use GPL-2.0-or-later? Original was GPL only.

I would have kept it GPL-2.0 unless it's rewritten from scratch
completely.

-- 
Cyril Hrubis
chrubis@suse.cz
