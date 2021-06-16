From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Jun 2021 08:51:30 +0200
Subject: [LTP] [PATCH v2] syscalls/mallinfo2_01: Add a basic test for
 mallinfo2 when setting 2G size
In-Reply-To: <1622713444-21197-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YKzX7FPWGGROn6kR@pevik>
 <1622713444-21197-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <YMmfcvWc+d6wkfX9@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

...
> +++ b/testcases/kernel/syscalls/mallinfo/mallinfo_common.h
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> + * Copyright (C) 2020 Free Software Foundation, Inc.
>   * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
>   * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>   */
> @@ -28,4 +29,22 @@ static inline void print_mallinfo(const char *msg, struct mallinfo *m)
>  }
>  #endif

> +#ifdef HAVE_MALLINFO2
> +static inline void print_mallinfo2(const char *msg, struct mallinfo2 *m)
> +{
> +	tst_res(TINFO, "%s...", msg);
nit: I'd remove "..." and add extra space before #define (readability)
And also change it on previously added print_mallinfo().

> +#define P2(f) tst_res(TINFO, "%s: %ld", #f, m->f)
> +	P2(arena);
> +	P2(ordblks);
> +	P2(smblks);
> +	P2(hblks);
> +	P2(hblkhd);
> +	P2(usmblks);
> +	P2(fsmblks);
> +	P2(uordblks);
> +	P2(fordblks);
> +	P2(keepcost);
> +}
> +#endif

...
> +++ b/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [DESCRIPTION]
> + *
> + * Basic mallinfo2() test.
> + *
> + * Test members of struct mallinfo2() whether overflow when setting 2G size.
* Test hblkhd member of struct mallinfo2 whether overflow when setting 2G size.

> + */
> +
> +#include "mallinfo_common.h"
> +#include "tst_safe_macros.h"
> +
> +#ifdef HAVE_MALLINFO2
> +
> +void test_mallinfo2(void)
> +{
> +	struct mallinfo2 info;
> +	char *buf;
> +	size_t size = 2UL * 1024UL * 1024UL * 1024UL;
> +
> +	buf = malloc(size);
> +	if (!buf) {
> +		tst_res(TCONF, "Current system can not malloc 2G space, skip it");
> +		return;
> +	}
Here could be just:
	if (!buf)
		tst_brk(TCONF, "Current system can not malloc 2G space, skip it");

> +	info = mallinfo2();
> +	if (info.hblkhd < size) {
> +		print_mallinfo2("Test malloc 2G", &info);
> +		tst_brk(TFAIL, "The member of struct mallinfo2 overflow?");
You don't free buf here.

Maybe something like:

	if (info.hblkhd < size) {
		print_mallinfo2("Test malloc 2G", &info);
		tst_res(TFAIL, "hblkhd member of struct mallinfo2 overflow?");
	} else {
		tst_res(TPASS, "hblkhd member of struct mallinfo2 doesn't overflow");
	}

	free(buf);

If you're ok with it, no need to repost, I'll change it before merge.

Kind regards,
Petr
