From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 4 Mar 2020 16:56:31 +0100
Subject: [LTP] [PATCH 1/2] lib: Add safe timerfd macros
In-Reply-To: <20200304151201.19117-1-pvorel@suse.cz>
References: <20200304151201.19117-1-pvorel@suse.cz>
Message-ID: <b42e93cb-b06d-538c-a5ff-1d110ed8ce74@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello

On 04. 03. 20 16:12, Petr Vorel wrote:
> SAFE_TIMERFD_CREATE(), SAFE_TIMERFD_GETTIME() and SAFE_TIMERFD_SETTIME()
> 
> Added only to new C API.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> NOTE: ENOSYS is handled by ltp_syscall in lapi/timerfd.h.
> + I wonder include/tst_safe_timerfd.h and lapi/timerfd.h shouldn't be
> merged into single file.
> 
> Kind regards,
> Petr
> 
>  include/tst_safe_timerfd.h | 73 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 include/tst_safe_timerfd.h
> 
> diff --git a/include/tst_safe_timerfd.h b/include/tst_safe_timerfd.h
> new file mode 100644
> index 000000000..4019527d6
> --- /dev/null
> +++ b/include/tst_safe_timerfd.h
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> + */
> +
> +#ifndef TST_SAFE_TIMERFD_H__
> +#define TST_SAFE_TIMERFD_H__
> +

Please split the following code off to a separate .c file:

> +#include <errno.h>
> +#include "lapi/timerfd.h"
> +#include "tst_test.h"
> +
> +#define TTYPE (errno == ENOTSUP ? TCONF : TBROK)
> +
> +static inline int safe_timerfd_create(const char *file, const int lineno,
> +				      int clockid, int flags)
> +{
> +	int fd;
> +

Don't forget to clear errno when you're not using the TEST() macro.

> +	fd = timerfd_create(clockid, flags);
> +
> +	if (fd < 0) {
> +		tst_brk(TTYPE | TERRNO, "%s:%d: timerfd_create() failed",
> +			file, lineno);
> +	}
> +
> +	return fd;
> +}
> +
> +static inline int safe_timerfd_gettime(const char *file, const int lineno,
> +				int fd, struct itimerspec *curr_value)
> +{
> +	int rval;
> +

Same here.

> +	rval = timerfd_gettime(fd, curr_value);
> +	if (rval < 0) {
> +		tst_brk(TTYPE | TERRNO, "%s:%d: timerfd_gettime() failed",
> +			file, lineno);
> +	}
> +
> +	return rval;
> +}
> +
> +static inline int safe_timerfd_settime(const char *file, const int lineno,
> +				int fd, int flags,
> +				const struct itimerspec *new_value,
> +				struct itimerspec *old_value)
> +{
> +	int rval;
> +

And here-ish.

> +	if (tst_kvercmp(2, 6, 26) <= 0)
> +		flags = 0;

I think tst_brk(TCONF) would be better here. Or at least tst_res(TWARN),
since resetting flags to 0 may render some tests useless.

> +
> +	rval = timerfd_settime(fd, flags, new_value, old_value);
> +	if (rval < 0) {
> +		tst_brk(TTYPE | TERRNO, "%s:%d: timerfd_settime() failed",
> +			file, lineno);
> +	}
> +
> +	return rval;
> +}

Split off up to here.

> +
> +#define SAFE_TIMERFD_CREATE(clockid, flags)\
> +	safe_timerfd_create(__FILE__, __LINE__, (clockid), (flags))
> +
> +#define SAFE_TIMERFD_GETTIME(fd, curr_value)\
> +	safe_timerfd_gettime(__FILE__, __LINE__, (fd), (curr_value))
> +
> +#define SAFE_TIMERFD_SETTIME(fd, flags, new_value, old_value)\
> +	safe_timerfd_settime(__FILE__, __LINE__, (fd), (flags), (new_value), \
> +						 (old_value))
> +
> +#endif /* SAFE_TIMERFD_H__ */
> 


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
