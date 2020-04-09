From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Apr 2020 11:30:22 +0800
Subject: [LTP] [PATCH v2 2/2] Add new test for pipe2 with/without
 O_NONBLOCK mode.
In-Reply-To: <20200408211700.7958-3-laniel_francis@privacyrequired.com>
References: <208a947b-a64a-0962-b3de-0756f1cc1c92@cn.fujitsu.com>
 <20200408211700.7958-3-laniel_francis@privacyrequired.com>
Message-ID: <63ad5770-b2e4-2b85-1755-ff804eb14ad5@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi laniel

> From: Francis Laniel <laniel_francis@privacyrequired.com>
> 
> The new test (pipe2_03.c) checks the following:
> 1. Create a pipe with O_NONBLOCK.
> 2. Check that this flag is set.
> 3. Check that pipe size is 16 * PAGE_SIZE.
> 4. Reduce pipe size to PAGE_SIZE.
> 5. Write buffer bigger than page size and see that second write fails.
> 6. Set pipe's flags to default.
> 7. Fork and do a write in the child, its state must be 'S' and is checked from
> the father.
> ---
>   testcases/kernel/syscalls/pipe2/.gitignore |   1 +
>   testcases/kernel/syscalls/pipe2/pipe2_03.c | 128 +++++++++++++++++++++
We should add pipe2_03 into runtest/syscalls file, so we can use runltp 
command to run this case when make install.  Also see Contribution 
Checklist in ltp/doc/test-writing-guidelines.txt

4. Test Contribution Checklist
------------------------------

1. Test compiles and runs fine (check with -i 10 too)
2. Checkpatch does not report any errors
3. The runtest entires are in place
4. Test files are added into corresponding .gitignore files
5. Patches apply over the latest git

>   2 files changed, 129 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/pipe2/pipe2_03.c
> 
> diff --git a/testcases/kernel/syscalls/pipe2/.gitignore b/testcases/kernel/syscalls/pipe2/.gitignore
> index cd38bb309..01d980dba 100644
> --- a/testcases/kernel/syscalls/pipe2/.gitignore
> +++ b/testcases/kernel/syscalls/pipe2/.gitignore
> @@ -1,2 +1,3 @@
>   /pipe2_01
>   /pipe2_02
> +/pipe2_03
> diff --git a/testcases/kernel/syscalls/pipe2/pipe2_03.c b/testcases/kernel/syscalls/pipe2/pipe2_03.c
> new file mode 100644
> index 000000000..c2b182e02
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pipe2/pipe2_03.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Francis Laniel. All rights reserved.
> + * Author: Francis Laniel <laniel_francis@privacyrequired.com>
> + *
> + * Test Description:
> + * This Program tests getting and setting the pipe size.
> + * It also tests what happen when you write to a full pipe depending on whether
> + * O_NONBLOCK is set or not.
> + */
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <features.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <assert.h>
> +#include <sys/select.h>
> +
> +#include "lapi/fcntl.h"
> +#include "tst_test.h"
> +
> +#define PAGE_NR 16
> +#define SECONDS 3
> +#define MICROSECONDS 0
The two variables is useless.
> +
> +static int fds[2];
> +static long page_size;
> +
> +static void setup(void)
> +{
> +	/*
> +	 * Create the pipe with O_NONBLOCK.
> +	 */
> +	SAFE_PIPE2(fds, O_NONBLOCK);
> +
> +	/*
> +	 * Get the system page size.
> +	 */
> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> +}
> +
> +static void test_pipe2(void)
> +{
> +	long flags;
> +	long pipe_size;
> +
> +	char *buf;
> +
> +	pid_t pid;
> +	int status;
> +
> +	flags = SAFE_FCNTL(fds[0], F_GETFL);
> +
> +	if (!(flags & O_NONBLOCK))
> +		tst_res(TFAIL, "O_NONBLOCK flag must be set.");
> +
> +	pipe_size = SAFE_FCNTL(fds[0], F_GETPIPE_SZ);
> +
> +	if (pipe_size != page_size * PAGE_NR)
> +		tst_res(TFAIL, "Default pipe page is 16 * 4096 = 65536B.");
I guess we can remove this check. We can not ensure kernel will keep 
default pipe size is equal to 16 pagesize in future. We only ensure this 
pipe is full is ok. We can fill this pipe in setup parse.
> +
> +	/*
> +	 * A pipe has two file descriptors.
> +	 * But in the kernel these two file descriptors point to the same pipe.
> +	 * So setting size from first file handle set size for the pipe.
> +	 */
> +	SAFE_FCNTL(fds[0], F_SETPIPE_SZ, 0);
> +
> +	/*
> +	 * So getting size from the second file descriptor return the size of
> +	 * the pipe which was changed before with first file descriptor.
> +	 */
> +	pipe_size = SAFE_FCNTL(fds[1], F_GETPIPE_SZ);
> +
> +	if (pipe_size != page_size)
> +		tst_res(TFAIL, "Pipe size (%ld) must be page size (%ld)",
> +			pipe_size, page_size);
> +
> +	buf = alloca(page_size);
> +
> +	SAFE_WRITE(1, fds[1], buf, page_size);
> +
> +	/*
> +	 * This write should return -1 because pipe is already full.
> +	 */
> +	if (write(fds[1], buf, page_size) != -1)
> +		tst_res(TFAIL | TERRNO, "write() succeeded and should not");
> +
> +	SAFE_FCNTL(fds[1], F_SETFL, flags & ~O_NONBLOCK);
> +
> +	flags = SAFE_FCNTL(fds[1], F_GETFL);
> +
> +	if (flags & O_NONBLOCK)
> +		tst_res(TFAIL, "O_NONBLOCK flag must not be set.");
> +
> +	pid = SAFE_FORK();
> +
> +	/*
> +	 * Since writes are now blocking the child must wait forever on this
> +	 * write.
> +	 */
> +	if (!pid)
> +		SAFE_WRITE(1, fds[1], buf, page_size);
> +
> +	if (TST_PROCESS_STATE_WAIT(pid, 'S', 1000))
> +		tst_res(TFAIL, "Child must be stopped.");
> +	else
> +		tst_res(TPASS, "Child is stopped.");
> +
> +	SAFE_KILL(pid, SIGKILL);
> +
> +	SAFE_WAIT(&status);
> +}
> +
> +static void cleanup(void)
> +{
> +	for (int i = 0; i < 2; i++)
> +		if (fds[i] > 0)
> +			SAFE_CLOSE(fds[i]);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = test_pipe2,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +};
> \ No newline at end of file
> 


