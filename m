From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Mar 2017 12:58:22 +0100
Subject: [LTP] [PATCH v3 2/3] lib: SAFE_MQ_OPEN() macro
In-Reply-To: <20170308000308.8274-2-pvorel@suse.cz>
References: <20170308000308.8274-1-pvorel@suse.cz>
 <20170308000308.8274-2-pvorel@suse.cz>
Message-ID: <20170308115821.GA30298@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Hmm, is there a reason why this is signed by both your private and suse
address?

> ---
>  include/old/safe_posix_ipc.h | 33 +++++++++++++++++++++++++++++++++
>  include/safe_posix_ipc_fn.h  | 31 +++++++++++++++++++++++++++++++
>  include/tst_safe_posix_ipc.h | 33 +++++++++++++++++++++++++++++++++
>  lib/safe_posix_ipc.c         | 41 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 138 insertions(+)
>  create mode 100644 include/old/safe_posix_ipc.h
>  create mode 100644 include/safe_posix_ipc_fn.h
>  create mode 100644 include/tst_safe_posix_ipc.h
>  create mode 100644 lib/safe_posix_ipc.c
> 
> diff --git a/include/old/safe_posix_ipc.h b/include/old/safe_posix_ipc.h
> new file mode 100644
> index 000000000..7e7f736c2
> --- /dev/null
> +++ b/include/old/safe_posix_ipc.h
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright (C) 2017 Petr Vorel pvorel@suse.cz
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#ifndef SAFE_POSIX_IPC_H__
> +#define SAFE_POSIX_IPC_H__
> +
> +#include "safe_posix_ipc_fn.h"
> +
> +#define SAFE_MQ_OPEN(pathname, oflags, cleanup_fn, ...) \
> +	safe_mq_open(__FILE__, __LINE__, (cleanup_fn), (pathname), (oflags), \
> +	    ##__VA_ARGS__)
> +
> +#endif /* SAFE_POSIX_IPC_H__ */
> diff --git a/include/safe_posix_ipc_fn.h b/include/safe_posix_ipc_fn.h
> new file mode 100644
> index 000000000..97b0f013b


Generally adding any new functionality into the old test library is
frowned upon. So unless there is a very good reason to do so do not add
anything there.

> --- /dev/null
> +++ b/include/safe_posix_ipc_fn.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright (C) 2017 Petr Vorel pvorel@suse.cz
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +
> +#ifndef SAFE_POSIX_IPC_FN_H__
> +#define SAFE_POSIX_IPC_FN_H__
> +
> +int safe_mq_open(const char *file, const int lineno, void (*cleanup_fn) (void),
> +              const char *pathname, int oflags, ...);
> +
> +#endif /* SAFE_POSIX_IPC_FN_H__ */
> diff --git a/include/tst_safe_posix_ipc.h b/include/tst_safe_posix_ipc.h
> new file mode 100644
> index 000000000..51204f5ae
> --- /dev/null
> +++ b/include/tst_safe_posix_ipc.h
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright (C) 2017 Petr Vorel pvorel@suse.cz
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#ifndef TST_SAFE_POSIX_IPC_H__
> +#define TST_SAFE_POSIX_IPC_H__
> +
> +#include "safe_posix_ipc_fn.h"
> +
> +#define SAFE_MQ_OPEN(pathname, oflags, ...) \
> +	safe_mq_open(__FILE__, __LINE__, NULL, (pathname), (oflags), \
> +	    ##__VA_ARGS__)
> +
> +#endif /* TST_SAFE_POSIX_IPC_H__ */

And there is no reason to split the header into two if we do not add
anything to the old library. So this header should contain both the
macro and the function declaration.

> diff --git a/lib/safe_posix_ipc.c b/lib/safe_posix_ipc.c
> new file mode 100644
> index 000000000..cb797b7f3
> --- /dev/null
> +++ b/lib/safe_posix_ipc.c
> @@ -0,0 +1,41 @@
> +#include <mqueue.h>
> +#include <stdarg.h>
> +
> +#include "test.h"
> +#include "safe_posix_ipc.h"
> +
> +int safe_mq_open(const char *file, const int lineno, void (*cleanup_fn) (void),
> +              const char *pathname, int oflags, ...)
> +{
> +	va_list ap;
> +	int rval;
> +	mode_t mode;
> +	struct mq_attr *attr;
> +
> +	mode = 0;
> +	attr = NULL;
> +
> +	va_start(ap, oflags);
> +
> +	/* Android's NDK's mode_t is smaller than an int, which results in
> +	 * SIGILL here when passing the mode_t type.
> +	 */
> +#ifndef ANDROID
> +	mode = va_arg(ap, mode_t);
> +#else
> +	mode = va_arg(ap, int);
> +#endif
> +
> +	attr = va_arg(ap, struct mq_attr *);
> +
> +	va_end(ap);
> +
> +	rval = mq_open(pathname, oflags, mode, attr);
> +	if (rval == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			 "%s:%d: mq_open(%s,%d,0%o,%p) failed",
> +			 file, lineno, pathname, oflags, mode, attr);
> +	}
> +
> +	return rval;
> +}

And unless we really want this code do be used from old library it
should use the tst_brk() interface and the cleanup function pointer
parameter should be removed.

-- 
Cyril Hrubis
chrubis@suse.cz
