From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 20 Jul 2017 16:31:38 +0200
Subject: [LTP] [PATCH v2 1/3] lib: Add personality fallback and SAFE
	macro
In-Reply-To: <20170719090831.2326-1-rpalethorpe@suse.com>
References: <20170719090831.2326-1-rpalethorpe@suse.com>
Message-ID: <87y3rjp4c5.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Looks like I missed some stuff here.

Richard Palethorpe writes:

> diff --git a/include/lapi/personality.h b/include/lapi/personality.h
> new file mode 100644
> index 000000000..1168d0744
> --- /dev/null
> +++ b/include/lapi/personality.h
> @@ -0,0 +1,48 @@
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
> +/* In the Linux kernel and glibc enums are (mostly) used for the constants,
> + * but in musl macros are used.
> + */
> +

Needs define PERSONALITY_H...

> +#include "config.h"
> +
> +#if defined(HAVE_SYS_PERSONALITY_H)
> +#include <sys/personality.h>
> +#elif defined(HAVE_LINUX_PERSONALITY_H)
> +#include <linux/personality.h>
> +#endif
> +
> +#ifndef HAVE_SYS_PERSONALITY_H
> +#include "linux_syscall_numbers.h"
> +
> +static int personality(unsigned long persona)
> +{
> +	return tst_syscall(__NR_personality, persona);
> +}
> +#endif
> +

Oops, linux_syscall_numbers.h is not available to the LTP library. I am
wondering if we can just add it to the include path?


-- 
Thank you,
Richard.
