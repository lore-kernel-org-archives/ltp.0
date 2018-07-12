From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 12 Jul 2018 12:27:25 +0200
Subject: [LTP] [PATCH v1] Test madvise with advise value
	'MADV_WIPEONFORK'
In-Reply-To: <1531324792-16559-1-git-send-email-kewal@zilogic.com>
References: <1531324792-16559-1-git-send-email-kewal@zilogic.com>
Message-ID: <2eef9639-8704-a736-5193-e7ef3074516e@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/11/2018 05:59 PM, kewal wrote:
> 
> * madvise10.c :- Present the child process with zero-filled memory in
>   this range after a fork(2).
> 
>   Test-Case 1 : madvise with 'MADV_WIPEONFORK'
>   Test-Case 2 : madvise with 'MADV_WIPEONFORK' as size 'ZERO'
> 
> * madvise11.c:- The MADV_WIPEONFORK operation can be applied only to
>   private anonymous pages.
> 
>   Test-Case 1 : mmap with 'MAP_SHARED | MAP_ANONYMOUS'
>   Test-Case 2 : mmap with 'MAP_PRIVATE'
> 
> * madvise12.c:- Within the child created by fork(2), the MADV_WIPEONFORK
>   setting remains in place on the specified address range.
> 
>   Test-Case 1: 'MADV_WIPEONFORK' on Grand child
> 
> * madvise13.c:- MADV_KEEPONFORK Undo the effect of an earlier MADV_WIPEONFORK
> 
>   Test-Case 1 : Undo 'MADV_WIPEONFORK' by 'MADV_KEEPONFORK'

Hi,

These tests seem to have lot of common code. We should simplify
that by a header/include or combining some of them together.

I'm thinking:
- drop madvise11, errno tests can be added to existing madvise02
- combine the rest together, see my attached example

Other comments are below/inline:

> 
> Signed-off-by: Subash Ganesan <subash@zilogic.com>
> Signed-off-by: Kewal Ukunde <kewal@zilogic.com>
> ---
>  runtest/syscalls                              |   4 +

New tests should be added also to respective .gitignore

>  testcases/kernel/syscalls/madvise/madvise10.c | 179 ++++++++++++++++++++++++++
>  testcases/kernel/syscalls/madvise/madvise11.c | 132 +++++++++++++++++++
>  testcases/kernel/syscalls/madvise/madvise12.c | 171 ++++++++++++++++++++++++
>  testcases/kernel/syscalls/madvise/madvise13.c | 162 +++++++++++++++++++++++
>  5 files changed, 648 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/madvise/madvise10.c
>  create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c
>  create mode 100644 testcases/kernel/syscalls/madvise/madvise12.c
>  create mode 100644 testcases/kernel/syscalls/madvise/madvise13.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a9afecf57..a95c47c3a 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -773,6 +773,10 @@ madvise06 madvise06
>  madvise07 madvise07
>  madvise08 madvise08
>  madvise09 madvise09
> +madvise10 madvise10
> +madvise11 madvise11
> +madvise12 madvise12
> +madvise13 madvise13
>  
>  newuname01 newuname01
>  
> diff --git a/testcases/kernel/syscalls/madvise/madvise10.c b/testcases/kernel/syscalls/madvise/madvise10.c
> new file mode 100644
> index 000000000..1cf3097b0
> --- /dev/null
> +++ b/testcases/kernel/syscalls/madvise/madvise10.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0 or later
> +/*
> + *  Copyright (c) Zilogic Systems Pvt. Ltd., 2007

2018

> + *  Email : code@zilogic.com
> + *
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
> + */
> +
> +/*
> + * test cases for madvise(2) system call, advise value as "MADV_WIPEONFORK".
> + *
> + * DESCRIPTION :
> + * Present the child process with zero-filled memory in this
> + * range after a fork(2).
> + * The MADV_WIPEONFORK operation can be applied only to
> + * private anonymous pages.
> + *
> + * Test-Case 1 : madvise with "MADV_WIPEONFORK"
> + * flow :	Map memory area as private anonymous page.
> + *		Mark memory area as wipe-on-fork.
> + *		On fork, child process memory should be zeroed.
> + *
> + * Test-Case 2 : madvise with "MADV_WIPEONFORK" as size "ZERO"
> + * flow :	Map memory area as private anonymous page.
> + *		Mark memory area as wipe-on-fork, with length zero.
> + *		On fork, child process memory should be accessible.
> + **/
> +
> +#include <stdio.h>
> +#include <signal.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <sys/mman.h>
> +#include <error.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <stdlib.h>
> +
> +#include "lapi/mmap.h"
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +
> +#define TEST_FILE "test_file.txt"

Why do you need a file when you're mapping as ANONYMOUS?

> +#define MAP_SIZE (4 * 1024)
> +
> +static int test_file_fd;
> +
> +static const struct test_case {
> +	int size;
> +	int advise;
> +	char *advise_name;
> +	int expect;
> +} tcases[] = {
> +	{.size = MAP_SIZE,
> +	 .advise = MADV_WIPEONFORK,
> +	 .advise_name = "MADV_WIPEONFORK",
> +	 .expect = 0},
> +
> +	{.size = 0,
> +	.advise = MADV_WIPEONFORK,
> +	.advise_name = "MADV_WIPEONFORK",
> +	.expect = 1}
> +};
> +
> +static void assert_equal(int status, const struct test_case *tc)
> +{
> +	if (status == tc->expect)
> +		tst_res(TPASS, "In child data %d : madvise(%s)",
> +				tc->expect, tc->advise_name);
> +	else
> +		tst_res(TFAIL, "In child data %d : madvise(%s)",
> +				tc->expect, tc->advise_name);
> +}

Let's compare the whole area, not just first byte.

> +
> +static void safe_wait_status(int *status)
> +{
> +	SAFE_WAIT(status);
> +
> +	if (!WIFEXITED(*status)) {
> +		if (WTERMSIG(*status) == SIGSEGV)
> +			tst_res(TFAIL, "Invalid access : SIGSEGV");
> +		else
> +			tst_res(TFAIL, "Abnormal termination");
> +	} else {
> +		*status = WEXITSTATUS(*status);
> +	}
> +}

You can use tst_res(TPASS/TFAIL,...) in child processes. Then you
can avoid passing values over exit status and use tst_reap_children(),
which does the same check.

> +
> +static void spawn_child(char *map_addr)
> +{
> +	pid_t pid;
> +
> +	pid = SAFE_FORK();
> +
> +	if (!pid)
> +		exit(*map_addr);

As mentioned earlier, let's check entire area.

> +}
> +
> +static int set_advice(char *map_addr, const struct test_case *tc)
> +{
> +	TEST(madvise(map_addr, tc->size, tc->advise));
> +
> +	if (TEST_RETURN == -1) {
> +		tst_res(TINFO, "failed  :madvise(%p, %d, %s)",
> +				map_addr, tc->size, tc->advise_name);

Why not TFAIL|TTERRNO?

> +		return 1;
> +	}
> +
> +	tst_res(TINFO, "success :madvise(%p, %d, %s)",
> +			map_addr, tc->size, tc->advise_name);
> +
> +	return 0;
> +}
> +
> +static void mem_map(char **map_addr)
> +{
> +	*map_addr = SAFE_MMAP(NULL, MAP_SIZE,
> +			     PROT_READ | PROT_WRITE,
> +			     MAP_PRIVATE | MAP_ANON,

MAP_ANON is deprecated, please use MAP_ANONYMOUS.

> +			     test_file_fd, 0);

What is the purpose of having this file?

> +
> +	tst_res(TINFO, "mmap(NULL, %d, PROT_READ | PROT_WRITE, %s, %d, 0)",
> +		MAP_SIZE, "MAP_PRIVATE | MAP_ANON", test_file_fd);
> +}
> +
> +static void test_madvise(unsigned int test_nr)
> +{
> +	const struct test_case *tc = &tcases[test_nr];
> +	char *map_addr;
> +	int status;
> +
> +	mem_map(&map_addr);
> +	memset(map_addr, 1, MAP_SIZE);
> +
> +	if (set_advice(map_addr, tc)) {
> +		tst_res(TFAIL, "madvise failed");

Please, print also errno code.

> +	} else {
> +		spawn_child(map_addr);
> +		safe_wait_status(&status);
> +		assert_equal(status, tc);
> +	}
> +
> +	SAFE_MUNMAP(map_addr, MAP_SIZE);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_CLOSE(test_file_fd);
> +	SAFE_UNLINK(TEST_FILE);
> +}
> +
> +static void setup(void)
> +{
> +	test_file_fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0777);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_root = 1,

Is root really needed?

> +	.forks_child = 1,
> +	.needs_tmpdir = 1,
> +	.test = test_madvise,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "4.14",
> +};

Similar comments apply to other tests, which share code above.

Regards,
Jan

-------------- next part --------------
#include <errno.h>
#include <stdio.h>
#include <stdio.h>
#include <sys/mman.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#include "lapi/mmap.h"
#include "tst_test.h"
#include "tst_safe_macros.h"

#define MAP_SIZE (4 * 1024)

static unsigned char pattern[MAP_SIZE];
static unsigned char zero[MAP_SIZE];

static void cmp_area(unsigned char *p, unsigned char *expected, unsigned int size)
{
	unsigned int i;

	for (i = 0; i < size; i++) {
		if (p[i] != expected[i]) {
			tst_res(TFAIL, "area %p [%d] != expected[%d],"
				" 0x%02x != 0x%02x", p, i, i, p[i], expected[i]);
			break;
		}
	}
	tst_res(TPASS, "(pid %d) area %p matches expected pattern", getpid(), p);
}

static void *mem_map(void)
{
	unsigned char *p;

	p = SAFE_MMAP(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, 
		MAP_PRIVATE | MAP_ANON, -1, 0);

	memcpy(p, pattern, MAP_SIZE);

	return p;
}

static int set_advice(unsigned char *p, int length, int advice)
{
	TEST(madvise(p, length, advice));

	if (TEST_RETURN == -1) {
		tst_res(TFAIL|TTERRNO, "madvise(%p, %d, 0x%x)",
			p, length, advice);
		return 1;
	}

	return 0;
}

static void test_wipe(int zero_length, int undo_wipe)
{
	unsigned char *map_addr;
	pid_t pid;
	int wipe_length = MAP_SIZE;
	unsigned char *expected = zero;

	if (zero_length)
		wipe_length = 0;

	if (zero_length || undo_wipe)
		expected = pattern;

	tst_res(TINFO, "WIPEONFORK zero_length: %d, undo_wipe: %d",
		zero_length, undo_wipe);
	map_addr = mem_map();
	set_advice(map_addr, wipe_length, MADV_WIPEONFORK);

	if (undo_wipe)
		set_advice(map_addr, wipe_length, MADV_KEEPONFORK);

	pid = SAFE_FORK();
	if (!pid) {
		cmp_area(map_addr, expected, MAP_SIZE);

		/* run same check for grandchild */
		pid = SAFE_FORK();
		if (!pid) {
			cmp_area(map_addr, expected, MAP_SIZE);
			exit(0);
		}
		exit(0);
	}

	tst_reap_children();
	SAFE_MUNMAP(map_addr, MAP_SIZE);
}

static void test_all(void)
{
	int zero_length, undo_wipe;

	for (zero_length = 0; zero_length < 2; zero_length++)
		for (undo_wipe = 0; undo_wipe < 2; undo_wipe++)
			test_wipe(zero_length, undo_wipe);
}

static void setup(void)
{
	unsigned int i;

	for (i = 0; i < MAP_SIZE; i++)
		pattern[i] = i % 0xfe;
}

static struct tst_test test = {
	.test_all = test_all,
	.forks_child = 1,
	.setup = setup,
	.min_kver = "4.14",
};
