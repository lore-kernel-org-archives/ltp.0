From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Mar 2020 17:28:57 +0100
Subject: [LTP] [PATCH 1/2] lib: Add safe timerfd macros
In-Reply-To: <b42e93cb-b06d-538c-a5ff-1d110ed8ce74@suse.cz>
References: <20200304151201.19117-1-pvorel@suse.cz>
 <b42e93cb-b06d-538c-a5ff-1d110ed8ce74@suse.cz>
Message-ID: <20200304162857.GA30492@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Please split the following code off to a separate .c file:
OK, I'll do :). We had some discussions about it, I remember problems caused by
using lapi files in the library headers (tst_device.h), I'd consider ok having
just header tst_safe_timerfd.h unless it's loaded by library itself, but
somebody could do it later. And I also consider it as a cleaner solution
(hoping that linker will really drop unused symbols).

> > +#include <errno.h>
> > +#include "lapi/timerfd.h"
> > +#include "tst_test.h"
> > +
> > +#define TTYPE (errno == ENOTSUP ? TCONF : TBROK)
> > +
> > +static inline int safe_timerfd_create(const char *file, const int lineno,
> > +				      int clockid, int flags)
> > +{
> > +	int fd;
> > +

> Don't forget to clear errno when you're not using the TEST() macro.
Do you think it's necessary? I've noticed you clear errno here in original test,
but I'd expect errno is be set if (fd < 0).
But ok, it's done in some macros (tst_safe_macros.c, safe_macros.c)

> > +	if (tst_kvercmp(2, 6, 26) <= 0)
> > +		flags = 0;

> I think tst_brk(TCONF) would be better here. Or at least tst_res(TWARN),
> since resetting flags to 0 may render some tests useless.
Well, this is just to keep test working under 2.6.25 and .26. Obviously it
would not affect many users, but these would got broken these tests
timerfd01.c (all)
timerfd_settime01.c (3th and 4rd test)
timerfd_settime02.c (not sure whether this old version is really affected by
CVE-2017-10661)

break all tests). Agree that hiding it is not good.

> > +
> > +	rval = timerfd_settime(fd, flags, new_value, old_value);
> > +	if (rval < 0) {
> > +		tst_brk(TTYPE | TERRNO, "%s:%d: timerfd_settime() failed",
> > +			file, lineno);
> > +	}
> > +
> > +	return rval;
> > +}

> Split off up to here.
I guess you mean that macros should be kept in header (sure).

> > +
> > +#define SAFE_TIMERFD_CREATE(clockid, flags)\
> > +	safe_timerfd_create(__FILE__, __LINE__, (clockid), (flags))
> > +
> > +#define SAFE_TIMERFD_GETTIME(fd, curr_value)\
> > +	safe_timerfd_gettime(__FILE__, __LINE__, (fd), (curr_value))
> > +
> > +#define SAFE_TIMERFD_SETTIME(fd, flags, new_value, old_value)\
> > +	safe_timerfd_settime(__FILE__, __LINE__, (fd), (flags), (new_value), \
> > +						 (old_value))
> > +
> > +#endif /* SAFE_TIMERFD_H__ */

Kind regards,
Petr
