From: kewal <kewal@zilogic.com>
Date: Fri, 13 Jul 2018 06:27:25 -0000
Subject: [LTP] [PATCH v1] Test madvise with advise value'MADV_WIPEONFORK'
References: <1531324792-16559-1-git-send-email-kewal@zilogic.com>
 <2eef9639-8704-a736-5193-e7ef3074516e@redhat.com>
Message-ID: <04128a41ce9c82069cbadfd812c2a0a0.squirrel@pike.zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi Jan,

As per your below comment,
> -drop madvise11, errno tests can be added to existing madvise02

we found that in madvise02, the below structure uses mapped address which
is mapped with the flag value as "MAP_SHARED" but as per my test cases we
have to vary the flag value with "MAP_SHARED | MAP_ANONYMOUS" &
"MAP_PRIVATE".

I didn't found a way to add our testcases in madvise02.

>static struct tcase {
>	int advice;
>	char *name;
>	char **addr;
>	int exp_errno;
>	int skip;
>} tcases[] = {
>	{MADV_NORMAL,      "MADV_NORMAL",      &nonalign, EINVAL, 0},
>	{1212,             "MADV_NORMAL",      &file1,    EINVAL, 0},
>	{MADV_REMOVE,      "MADV_REMOVE",      &file1,    EINVAL, 0},
>	{MADV_DONTNEED,    "MADV_DONTNEED",    &file1,    EINVAL, 1},
>	{MADV_MERGEABLE,   "MADV_MERGEABLE",   &file1,    EINVAL, 0},
>	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", &file1,    EINVAL, 0},
>	{MADV_NORMAL,      "MADV_NORMAL",      &file2,    ENOMEM, 0},
>	{MADV_WILLNEED,    "MADV_WILLNEED",    &file2,    ENOMEM, 0},
>	{MADV_WILLNEED,    "MADV_WILLNEED",    &tmp_addr,  EBADF, 0},
>	{MADV_FREE,        "MADV_FREE",        &file1,    EINVAL, 0},
>	{MADV_WIPEONFORK,  "MADV_WIPEONFORK",  &file1,    EINVAL, 0},
>};


> file1 = SAFE_MMAP(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
> file2 = SAFE_MMAP(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);

We will go through the rest of the comments and update with v2.

Regards,
Kewal Ukunde

> On 07/11/2018 05:59 PM, kewal wrote:
>>
>> * madvise10.c :- Present the child process with zero-filled memory in
>>   this range after a fork(2).
>>
>>   Test-Case 1 : madvise with 'MADV_WIPEONFORK'
>>   Test-Case 2 : madvise with 'MADV_WIPEONFORK' as size 'ZERO'
>>
>> * madvise11.c:- The MADV_WIPEONFORK operation can be applied only to
>>   private anonymous pages.
>>
>>   Test-Case 1 : mmap with 'MAP_SHARED | MAP_ANONYMOUS'
>>   Test-Case 2 : mmap with 'MAP_PRIVATE'
>>
>> * madvise12.c:- Within the child created by fork(2), the MADV_WIPEONFORK
>>   setting remains in place on the specified address range.
>>
>>   Test-Case 1: 'MADV_WIPEONFORK' on Grand child
>>
>> * madvise13.c:- MADV_KEEPONFORK Undo the effect of an earlier
>> MADV_WIPEONFORK
>>
>>   Test-Case 1 : Undo 'MADV_WIPEONFORK' by 'MADV_KEEPONFORK'
>
> Hi,
>
> These tests seem to have lot of common code. We should simplify
> that by a header/include or combining some of them together.
>
> I'm thinking:
> - drop madvise11, errno tests can be added to existing madvise02
> - combine the rest together, see my attached example
>
> Other comments are below/inline:
>
>>
>> Signed-off-by: Subash Ganesan <subash@zilogic.com>
>> Signed-off-by: Kewal Ukunde <kewal@zilogic.com>
>> ---
>>  runtest/syscalls                              |   4 +
>
> New tests should be added also to respective .gitignore
>
>>  testcases/kernel/syscalls/madvise/madvise10.c | 179
>> ++++++++++++++++++++++++++
>>  testcases/kernel/syscalls/madvise/madvise11.c | 132 +++++++++++++++++++
>>  testcases/kernel/syscalls/madvise/madvise12.c | 171
>> ++++++++++++++++++++++++
>>  testcases/kernel/syscalls/madvise/madvise13.c | 162
>> +++++++++++++++++++++++
>>  5 files changed, 648 insertions(+)
>>  create mode 100644 testcases/kernel/syscalls/madvise/madvise10.c
>>  create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c
>>  create mode 100644 testcases/kernel/syscalls/madvise/madvise12.c
>>  create mode 100644 testcases/kernel/syscalls/madvise/madvise13.c
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index a9afecf57..a95c47c3a 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -773,6 +773,10 @@ madvise06 madvise06
>>  madvise07 madvise07
>>  madvise08 madvise08
>>  madvise09 madvise09
>> +madvise10 madvise10
>> +madvise11 madvise11
>> +madvise12 madvise12
>> +madvise13 madvise13
>>
>>  newuname01 newuname01
>>
>> diff --git a/testcases/kernel/syscalls/madvise/madvise10.c
>> b/testcases/kernel/syscalls/madvise/madvise10.c
>> new file mode 100644
>> index 000000000..1cf3097b0
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/madvise/madvise10.c
>> @@ -0,0 +1,179 @@
>> +// SPDX-License-Identifier: GPL-2.0 or later
>> +/*
>> + *  Copyright (c) Zilogic Systems Pvt. Ltd., 2007
>
> 2018
>
>> + *  Email : code@zilogic.com
>> + *
>> + * This program is free software;  you can redistribute it and/or
>> modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> + * the GNU General Public License for more details.
>> + */
>> +
>> +/*
>> + * test cases for madvise(2) system call, advise value as
>> "MADV_WIPEONFORK".
>> + *
>> + * DESCRIPTION :
>> + * Present the child process with zero-filled memory in this
>> + * range after a fork(2).
>> + * The MADV_WIPEONFORK operation can be applied only to
>> + * private anonymous pages.
>> + *
>> + * Test-Case 1 : madvise with "MADV_WIPEONFORK"
>> + * flow :	Map memory area as private anonymous page.
>> + *		Mark memory area as wipe-on-fork.
>> + *		On fork, child process memory should be zeroed.
>> + *
>> + * Test-Case 2 : madvise with "MADV_WIPEONFORK" as size "ZERO"
>> + * flow :	Map memory area as private anonymous page.
>> + *		Mark memory area as wipe-on-fork, with length zero.
>> + *		On fork, child process memory should be accessible.
>> + **/
>> +
>> +#include <stdio.h>
>> +#include <signal.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <stdlib.h>
>> +#include <fcntl.h>
>> +#include <sys/mman.h>
>> +#include <error.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <unistd.h>
>> +#include <sys/types.h>
>> +#include <sys/wait.h>
>> +#include <stdlib.h>
>> +
>> +#include "lapi/mmap.h"
>> +#include "tst_test.h"
>> +#include "tst_safe_macros.h"
>> +
>> +#define TEST_FILE "test_file.txt"
>
> Why do you need a file when you're mapping as ANONYMOUS?
>
>> +#define MAP_SIZE (4 * 1024)
>> +
>> +static int test_file_fd;
>> +
>> +static const struct test_case {
>> +	int size;
>> +	int advise;
>> +	char *advise_name;
>> +	int expect;
>> +} tcases[] = {
>> +	{.size = MAP_SIZE,
>> +	 .advise = MADV_WIPEONFORK,
>> +	 .advise_name = "MADV_WIPEONFORK",
>> +	 .expect = 0},
>> +
>> +	{.size = 0,
>> +	.advise = MADV_WIPEONFORK,
>> +	.advise_name = "MADV_WIPEONFORK",
>> +	.expect = 1}
>> +};
>> +
>> +static void assert_equal(int status, const struct test_case *tc)
>> +{
>> +	if (status == tc->expect)
>> +		tst_res(TPASS, "In child data %d : madvise(%s)",
>> +				tc->expect, tc->advise_name);
>> +	else
>> +		tst_res(TFAIL, "In child data %d : madvise(%s)",
>> +				tc->expect, tc->advise_name);
>> +}
>
> Let's compare the whole area, not just first byte.
>
>> +
>> +static void safe_wait_status(int *status)
>> +{
>> +	SAFE_WAIT(status);
>> +
>> +	if (!WIFEXITED(*status)) {
>> +		if (WTERMSIG(*status) == SIGSEGV)
>> +			tst_res(TFAIL, "Invalid access : SIGSEGV");
>> +		else
>> +			tst_res(TFAIL, "Abnormal termination");
>> +	} else {
>> +		*status = WEXITSTATUS(*status);
>> +	}
>> +}
>
> You can use tst_res(TPASS/TFAIL,...) in child processes. Then you
> can avoid passing values over exit status and use tst_reap_children(),
> which does the same check.
>
>> +
>> +static void spawn_child(char *map_addr)
>> +{
>> +	pid_t pid;
>> +
>> +	pid = SAFE_FORK();
>> +
>> +	if (!pid)
>> +		exit(*map_addr);
>
> As mentioned earlier, let's check entire area.
>
>> +}
>> +
>> +static int set_advice(char *map_addr, const struct test_case *tc)
>> +{
>> +	TEST(madvise(map_addr, tc->size, tc->advise));
>> +
>> +	if (TEST_RETURN == -1) {
>> +		tst_res(TINFO, "failed  :madvise(%p, %d, %s)",
>> +				map_addr, tc->size, tc->advise_name);
>
> Why not TFAIL|TTERRNO?
>
>> +		return 1;
>> +	}
>> +
>> +	tst_res(TINFO, "success :madvise(%p, %d, %s)",
>> +			map_addr, tc->size, tc->advise_name);
>> +
>> +	return 0;
>> +}
>> +
>> +static void mem_map(char **map_addr)
>> +{
>> +	*map_addr = SAFE_MMAP(NULL, MAP_SIZE,
>> +			     PROT_READ | PROT_WRITE,
>> +			     MAP_PRIVATE | MAP_ANON,
>
> MAP_ANON is deprecated, please use MAP_ANONYMOUS.
>
>> +			     test_file_fd, 0);
>
> What is the purpose of having this file?
>
>> +
>> +	tst_res(TINFO, "mmap(NULL, %d, PROT_READ | PROT_WRITE, %s, %d, 0)",
>> +		MAP_SIZE, "MAP_PRIVATE | MAP_ANON", test_file_fd);
>> +}
>> +
>> +static void test_madvise(unsigned int test_nr)
>> +{
>> +	const struct test_case *tc = &tcases[test_nr];
>> +	char *map_addr;
>> +	int status;
>> +
>> +	mem_map(&map_addr);
>> +	memset(map_addr, 1, MAP_SIZE);
>> +
>> +	if (set_advice(map_addr, tc)) {
>> +		tst_res(TFAIL, "madvise failed");
>
> Please, print also errno code.
>
>> +	} else {
>> +		spawn_child(map_addr);
>> +		safe_wait_status(&status);
>> +		assert_equal(status, tc);
>> +	}
>> +
>> +	SAFE_MUNMAP(map_addr, MAP_SIZE);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	SAFE_CLOSE(test_file_fd);
>> +	SAFE_UNLINK(TEST_FILE);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	test_file_fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0777);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.needs_root = 1,
>
> Is root really needed?
>
>> +	.forks_child = 1,
>> +	.needs_tmpdir = 1,
>> +	.test = test_madvise,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.min_kver = "4.14",
>> +};
>
> Similar comments apply to other tests, which share code above.
>
> Regards,
> Jan
>
>


