From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 12 Jan 2017 09:40:35 -0500 (EST)
Subject: [LTP] [PATCH 1/4] lib: Add tst_kernel_bits()
In-Reply-To: <1484227419-16955-1-git-send-email-chrubis@suse.cz>
References: <1484227419-16955-1-git-send-email-chrubis@suse.cz>
Message-ID: <1457322111.1910057.1484232035660.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> This function returns 32 or 64 depending on if we are running on 32bit
> or 64bit kernel. This is detected from uname.machine string which seems
> to be good enough heuristic and even if that fails we can always add a
> special cases to the tst_kernel_bits() function.

ACK, though I keep thinking if there isn't something in /proc
or /sys we could query and guess kernel bits from that.

Regards,
Jan

> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_kernel.h | 26 ++++++++++++++++++++++++++
>  include/tst_test.h   |  1 +
>  lib/tst_kernel.c     | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
>  create mode 100644 include/tst_kernel.h
>  create mode 100644 lib/tst_kernel.c
> 
> diff --git a/include/tst_kernel.h b/include/tst_kernel.h
> new file mode 100644
> index 0000000..5d5c04c
> --- /dev/null
> +++ b/include/tst_kernel.h
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
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
> +#ifndef TST_KERNEL_H__
> +#define TST_KERNEL_H__
> +
> +/*
> + * Returns 32 if we are running on 32bit kernel and 64 if on 64bit kernel.
> + */
> +int tst_kernel_bits(void);
> +
> +#endif	/* TST_KERNEL_H__ */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 1492ff5..7ff33b2 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -33,6 +33,7 @@
>  #include "tst_atomic.h"
>  #include "tst_kvercmp.h"
>  #include "tst_clone.h"
> +#include "tst_kernel.h"
>  
>  /*
>   * Reports testcase result.
> diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
> new file mode 100644
> index 0000000..7a53002
> --- /dev/null
> +++ b/lib/tst_kernel.c
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
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
> +#include <sys/utsname.h>
> +#include "test.h"
> +#include "tst_kernel.h"
> +
> +int tst_kernel_bits(void)
> +{
> +	struct utsname buf;
> +	int kernel_bits;
> +
> +	if (uname(&buf))
> +		tst_brkm(TBROK | TERRNO, NULL, "uname()");
> +
> +	kernel_bits = strstr(buf.machine, "64") ? 64 : 32;
> +
> +	tst_resm(TINFO, "uname.machine=%s kernel is %ibit",
> +	         buf.machine, kernel_bits);
> +
> +	return kernel_bits;
> +}
> --
> 2.7.3
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
