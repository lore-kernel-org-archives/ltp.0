From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Jun 2020 11:31:38 +0200
Subject: [LTP] [PATCH v1] Add mincore() test for anonymous mappings
In-Reply-To: <20200629154821.13349-1-shwetha@zilogic.com>
References: <20200629154821.13349-1-shwetha@zilogic.com>
Message-ID: <20200630093138.GA2684@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/mincore/mincore03.c b/testcases/kernel/syscalls/mincore/mincore03.c
> new file mode 100644
> index 000000000..53b05e57c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mincore/mincore03.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2020
> + * Email: code@zilogic.com
> + */
> +
> +/*
> + * mincore03
> + * Testcase 1 : Tests mincore result for anonymous mapping
> + * Memory is mapped as anonymous.
> + * Mapped memory is not touched.
> + * Mincore is executed.
> + * Number of pages in cache is counted and compared to expected number of pages

This describes what the test does but that can be easily seen from the
code. Rather it should explain why we are doing this. E.g. somethign as:

* Test that anonymous pages that haven't been faulted yet are reported as
  not resident by mincore()

> + * Testcase 2 : Tests mincore result for pages mapped but not cached yet
> + * Memory is mapped as anonymous.
> + * Mapped memory is touched.
> + * Mincore is executed.
> + * Number of pages in cache is counted and compared to expected number of pages

Here as well.

> + */
> +
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include "tst_test.h"
> +
> +#define NUM_PAGES 3
> +
> +static struct tcase {
> +	bool mlock;
> +	int expected_pages;
> +} tcases[] = {
> +	{ false, 0 },
> +	{ true, NUM_PAGES },
> +};
> +
> +static int size;
> +static void *ptr;
> +
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP(ptr, size);
> +}

We unmap the mapping in the main loop so we should do this only if we
exitted the test_mincore() prematurely. Maybe we should do:

	if (ptr)
		SAFE_MUNMAP(ptr, size);

And set the ptr to NULL in the test_mincore() right after we have
unmapped it.

> +static void test_mincore(unsigned int test_nr)
> +{
> +	const struct tcase *tc = &tcases[test_nr];
> +	unsigned char vec[NUM_PAGES];
> +	int locked_pages;
> +	int count, mincore_ret;
> +	int result, page_size;
> +
> +	page_size = getpagesize();

I guess that we can do this once in the test setup.

> +	size = page_size * NUM_PAGES;
> +	ptr = SAFE_MMAP(NULL, size,  PROT_WRITE | PROT_READ, MAP_PRIVATE |  MAP_ANONYMOUS, 0, 0);
> +	if (tc->mlock == true)

Just do if (tc->mlock)

> +		SAFE_MLOCK(ptr, size);
> +	
   ^
Trailing whitespace.

You can use the checkpatch.pl from Linux kernel git repostory to check
for minor mistakes like these before sending a patch.

> +	mincore_ret = mincore(ptr, size, vec);
> +	if (mincore_ret == -1)
> +		tst_brk(TBROK | TERRNO, "mincore failed");
> +	locked_pages = 0;
> +	for (count = 0; count < NUM_PAGES; count++)
> +		if (vec[count] & 1)
> +			locked_pages++;
> +	
> +	if (locked_pages == tc->expected_pages)
> +		result = TPASS;
> +	else
> +		result = TFAIL;
> +	tst_res(result, "no of pages in memory : %d no of pages expected in memory : %d",
> +		locked_pages, tc->expected_pages);

Can we please print different messages for PASS/FAIL here? This message
as it is is a bit confusing.

> +	if (tc->mlock == true)

Here as well just if (tc->mlock)

> +		SAFE_MUNLOCK(ptr, size);
> +	SAFE_MUNMAP(ptr, size);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.cleanup = cleanup,
> +	.test = test_mincore,
> +};
> -- 
> 2.20.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
