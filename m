From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Aug 2017 15:32:30 +0200
Subject: [LTP] [PATCH v3 1/3] lib: Add personality fallback and SAFE
	macro
In-Reply-To: <20170801132701.16317-1-rpalethorpe@suse.com>
References: <20170801132701.16317-1-rpalethorpe@suse.com>
Message-ID: <20170804133230.GA7915@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifndef HAVE_SYS_PERSONALITY_H
> +#include "lapi/syscalls.h"
> +
> +static int personality(unsigned long persona)
> +{
> +	return tst_syscall(__NR_personality, persona);
> +}
> +#endif

Do we really need fallback personality() syscall? We do have tests that
call personality() syscall in LTP tree since forever and I do not
recall any problems.

All that should be needed here are plain old fallback definitions for
the few constants that may not be present on older distros.

I guess that UNAME26 would need it since that one is not present in the
sys/personality header. PER_LINUX should be defined for years as well as
READ_IMPLIES_EXEC.

> +#if !(HAVE_DECL_UNAME26 == 1 || defined(UNAME26))
> +#define UNAME26 0x0020000
> +#endif
> +
> +#if !(HAVE_DECL_READ_IMPLIES_EXEC == 1 || defined(READ_IMPLIES_EXEC))
> +#define READ_IMPLIES_EXEC 0x0400000
> +#endif
> +
> +#if !(HAVE_DECL_PER_LINUX == 1 || defined(PER_LINUX))
> +#define PER_LINUX 0
> +#endif
> +
> +#endif	/* PERSONALITY_H */
> diff --git a/include/tst_personality.h b/include/tst_personality.h
> new file mode 100644
> index 000000000..ff61f4607
> --- /dev/null
> +++ b/include/tst_personality.h
> @@ -0,0 +1,28 @@
> +/*
> + * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef TST_PERSONALITY__
> +#define TST_PERSONALITY__
> +
> +#include "lapi/personality.h"
> +
> +int tst_personality(const char *filename, unsigned int lineno,
> +		    unsigned long persona);
         ^
	This should be called safe_personality() for consistency
	reasons.

And we may as well put it into the tst_safe_macros.h and safe_macros.c,
there is no good reason to keep it in a separate file as far as I can
tell.


-- 
Cyril Hrubis
chrubis@suse.cz
