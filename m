From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Mar 2019 17:16:02 +0100
Subject: [LTP] [PATCH v1] Test ioctl syscall for NS_GET_* requests
In-Reply-To: <20190224202942.21740-1-email@gmail.com>
References: <20190224202942.21740-1-email@gmail.com>
Message-ID: <20190304161602.GB15696@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> new file mode 100644
> index 000000000..68baafb48
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> @@ -0,0 +1,87 @@
> +/*
> + * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
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

We started to use SPDX identifiers instead of this, so this whole text
should be replaced with:

// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
 */

> +/*
> + * Test ioctl_ns with NS_GET_PARENT request.
> + *
> + * Child process has a new pid namespace, which should make the call fail
> + * with EPERM error.
> + *
> + */
> +#define _GNU_SOURCE
> +
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/wait.h>

I guess that we don't need the stdio.h include and possibly others.

> +#include <sched.h>
> +#include "tst_test.h"
> +
> +#ifndef NS_GET_PARENT
> +#define NSIO	0xb7
> +#define NS_GET_PARENT   _IO(NSIO, 0x2)
> +#endif

This should be put into a header so that it's not defined in each test,
ideal place would be the include/lapi/ directory in LTP tree.

> +static void test_ns_get_parent(void)
> +{
> +	int fd, parent_fd;
> +	char my_namespace[20];
> +
> +	sprintf(my_namespace, "/proc/self/ns/pid");

We should check in the test setup that this file is present, i.e. do
access(..., F_OK); and exit the test with TCONF if not (which would mean
that the kernel was compiled without namespaces).

Also why do we print the path to the buffer first, can't we just pass it
to the SAFE_OPEN()?

> +	fd = SAFE_OPEN(my_namespace, O_RDONLY);
> +	parent_fd = ioctl(fd, NS_GET_PARENT);
> +	if (parent_fd == -1) {
> +		if (errno == EPERM)
> +			tst_res(TPASS, "NS_GET_PARENT fails with EPERM");
> +		else
> +			tst_res(TFAIL, "unexpected error %u", errno);

We never print errno with %u. You can just bit or the TERRNO flag to the
TFAIL one to get it printed automatically and in human-readable form.

> +		exit(0);
> +	} else {
> +		SAFE_CLOSE(parent_fd);
> +	}
> +	SAFE_CLOSE(fd);
> +	exit(-1);
> +}
> +
> +static void run(void)
> +{
> +	int res = unshare(CLONE_NEWPID);
> +
> +	if (res == -1) {
> +		tst_res(TCONF, "unshare syscall error");

Only failures caused by lack of kernel support should yield TCONF here.

I guess that we may map the errno == EINVAL to TCONF here, the rest
should map to TBROK. Also you should print errno here with TCONF |
TERRNO.

And ideally we should add SAFE_UNSHARE() into include/tst_safe_macros.h.

> +		exit(-1);
> +	}
> +
> +	pid_t pid = SAFE_FORK();
> +
> +	if (pid == 0)
> +		test_ns_get_parent();
> +	else {
> +		int status;
> +
> +		wait(&status);
> +		if (status < 0)
> +			tst_res(TFAIL, "call to ioctl succeded");

There is no need to propagate results from the child, you call
tst_res() there after all.

We can as well just do exit(0) in the child and be done with the test,
the child will be waited for in the test library.

> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
> +	.min_kver = "4.9",

We are likely missing .needs_root here, or does the test run fine
under unpriviledged user?

> +};
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns02.c b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
> new file mode 100644
> index 000000000..7feacd626
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
> @@ -0,0 +1,63 @@
> +/*
> + * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
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
> +/*
> + * Test ioctl_ns with NS_GET_PARENT request.
> + *
> + * Tries to get namespace parent for UTS namespace.

This description should include what is expected to happen, i.e. we
expected EINVAL and why so.

> + */
> +#define _GNU_SOURCE
> +
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +#include <sched.h>
> +#include "tst_test.h"
> +
> +#ifndef NS_GET_PARENT
> +#define NSIO	0xb7
> +#define NS_GET_PARENT   _IO(NSIO, 0x2)
> +#endif
> +
> +static void run(void)
> +{
> +	int fd, parent_fd;
> +	char my_namespace[20];
> +
> +	sprintf(my_namespace, "/proc/self/ns/uts");
> +	fd = SAFE_OPEN(my_namespace, O_RDONLY);
> +	parent_fd = ioctl(fd, NS_GET_PARENT);
> +	if (parent_fd == -1) {
> +		if (errno == EINVAL)
> +			tst_res(TPASS, "NS_GET_PARENT fails with EINVAL");
> +		else
> +			tst_res(TFAIL, "unexpected error %u", errno);
> +	} else {
> +		tst_res(TFAIL, "call to ioctl succeded");
> +		SAFE_CLOSE(parent_fd);
> +	}
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.min_kver = "4.9",
> +};

All the comments from the previous test apply here as well.

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns03.c b/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
> new file mode 100644
> index 000000000..3d4e92872
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
> @@ -0,0 +1,63 @@
> +/*
> + * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
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
> +/*
> + * Test ioctl_ns with NS_GET_PARENT request.
> + *
> + * Tries to get parent of initial namespace.

Again a bit more verbose description wouldn't harm.

> + */
> +#define _GNU_SOURCE
> +
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +#include <sched.h>
> +#include "tst_test.h"
> +
> +#ifndef NS_GET_PARENT
> +#define NSIO	0xb7
> +#define NS_GET_PARENT   _IO(NSIO, 0x2)
> +#endif
> +
> +static void run(void)
> +{
> +	int fd, parent_fd;
> +	char my_namespace[20];
> +
> +	sprintf(my_namespace, "/proc/self/ns/pid");
> +	fd = SAFE_OPEN(my_namespace, O_RDONLY);
> +	parent_fd = ioctl(fd, NS_GET_PARENT);
> +	if (parent_fd == -1) {
> +		if (errno == EPERM)
> +			tst_res(TPASS, "NS_GET_PARENT of initial user fails");
> +		else
> +			tst_res(TFAIL, "unexpected error %u", errno);
> +	} else {
> +		tst_res(TFAIL, "call to ioctl succeded");
> +		SAFE_CLOSE(parent_fd);
> +	}
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.min_kver = "4.9",
> +};

Also this is very similar to the first test, maybe it would make more
sense to merge these two into one test and run the run function twice,
once from the initial namespace and once after the unshare call.

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns04.c b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
> new file mode 100644
> index 000000000..c61360611
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
> @@ -0,0 +1,65 @@
> +/*
> + * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
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
> +/*
> + * Test ioctl_ns with NS_GET_OWNER_UID request.
> + *
> + * Fails attempting request for UTS namespace.

Here as well, better explanation.

> + */
> +#define _GNU_SOURCE
> +
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +#include <sched.h>
> +#include "tst_test.h"
> +
> +#ifndef NS_GET_OWNER_UID
> +#define NSIO    0xb7
> +#define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> +#endif
> +
> +static void run(void)
> +{
> +	int fd, owner_fd;
> +	char my_namespace[20];
> +
> +	sprintf(my_namespace, "/proc/self/ns/uts");
> +	fd = SAFE_OPEN(my_namespace, O_RDONLY);
> +	uid_t uid;
> +
> +	owner_fd = ioctl(fd, NS_GET_OWNER_UID, &uid);
> +	if (owner_fd == -1) {
> +		if (errno == EINVAL)
> +			tst_res(TPASS, "NS_GET_OWNER_UID fails, UTS namespace");
> +		else
> +			tst_res(TFAIL, "unexpected error %u", errno);
> +	} else {
> +		tst_res(TFAIL, "call to ioctl succeded");
> +		SAFE_CLOSE(owner_fd);
> +	}
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.min_kver = "4.11",
> +};

The rest of the comments apply here as well.

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
> new file mode 100644
> index 000000000..987012394
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
> @@ -0,0 +1,63 @@
> +/*
> + * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
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
> +/*
> + * Test ioctl_ns with NS_GET_USERNS request.
> + *
> + * Fails attempting request for out of scope namespace.

Here as well, slightly better description.

> + */
> +#define _GNU_SOURCE
> +
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +#include <sched.h>
> +#include "tst_test.h"
> +
> +#ifndef NS_GET_USERNS
> +#define NSIO    0xb7
> +#define NS_GET_USERNS	   _IO(NSIO, 0x1)
> +#endif
> +
> +static void run(void)
> +{
> +	int fd, parent_fd;
> +	char my_namespace[20];
> +
> +	sprintf(my_namespace, "/proc/self/ns/user");
> +	fd = SAFE_OPEN(my_namespace, O_RDONLY);
> +	parent_fd = ioctl(fd, NS_GET_USERNS);
> +	if (parent_fd == -1) {
> +		if (errno == EPERM)
> +			tst_res(TPASS, "NS_GET_USERNS fails with EPERM");
> +		else
> +			tst_res(TFAIL, "unexpected error %u", errno);
> +	} else {
> +		tst_res(TFAIL, "call to ioctl succeded");
> +		SAFE_CLOSE(parent_fd);
> +	}
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.min_kver = "4.9",
> +};

And the rest of the comments apply as well.

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
> new file mode 100644
> index 000000000..9a0eb93f6
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
> @@ -0,0 +1,83 @@
> +/*
> + * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
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
> +/*
> + * Test ioctl_ns with NS_GET_PARENT request.
> + *
> + * Child process should have a new namespace.

You should elaborate here _what_ we are testing here. It's not clear
what the test does based on this sentence. Especially you should
describe why we decided to check this based on inodes of the file
descriptors.

> + */
> +#define _GNU_SOURCE
> +
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sched.h>
> +#include <sys/stat.h>
> +#include "tst_test.h"
> +
> +#ifndef NS_GET_PARENT
> +#define NSIO	0xb7
> +#define NS_GET_PARENT   _IO(NSIO, 0x2)
> +#endif
> +
> +static void run(void)
> +{
> +	int res = unshare(CLONE_NEWPID);
> +
> +	if (res < 0) {
> +		tst_res(TCONF, "unshare error");
> +		exit(0);
> +	}
> +	pid_t pid = SAFE_FORK();
> +
> +	if (pid == 0) {
> +		exit(0);
> +	} else {

There is no point in running the rest of the code in the else branch as
the main branch calls exit(0);

> +		char my_namespace[20], child_namespace[20];
> +
> +		sprintf(my_namespace, "/proc/self/ns/pid");

Again no need to print the constant string into a buffer.

> +		sprintf(child_namespace, "/proc/%i/ns/pid", pid);
> +		int my_fd, child_fd, parent_fd;
> +
> +		my_fd = SAFE_OPEN(my_namespace, O_RDONLY);
> +		child_fd = SAFE_OPEN(child_namespace, O_RDONLY);
> +		parent_fd = ioctl(child_fd, NS_GET_PARENT);

Use SAFE_IOCTL() here.

> +		struct stat my_stat, child_stat, parent_stat;
> +
> +		fstat(my_fd, &my_stat);
> +		fstat(child_fd, &child_stat);
> +		fstat(parent_fd, &parent_stat);

And SAFE_FSTAT() here.

> +		if (my_stat.st_ino != parent_stat.st_ino)
> +			tst_res(TFAIL, "parents have different inodes");
> +		else if (parent_stat.st_ino == child_stat.st_ino)
> +			tst_res(TFAIL, "child and parent have same inode");
> +		else
> +			tst_res(TPASS, "child and parent are consistent");
> +
> +		SAFE_CLOSE(my_fd);
> +		SAFE_CLOSE(child_fd);
> +		SAFE_CLOSE(parent_fd);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
> +	.min_kver = "4.9",
> +};
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns07.c b/testcases/kernel/syscalls/ioctl/ioctl_ns07.c
> new file mode 100644
> index 000000000..a743bb1c8
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns07.c
> @@ -0,0 +1,83 @@
> +/*
> + * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
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
> +/*
> + * Test ioctl_ns with NS_GET_USERNS request.
> + *
> + * Child process should have a new namespace.

Here as well.

> + */
> +#define _GNU_SOURCE
> +
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sched.h>
> +#include <sys/stat.h>
> +#include "tst_test.h"
> +
> +#ifndef NS_GET_USERNS
> +#define NSIO	0xb7
> +#define NS_GET_USERNS   _IO(NSIO, 0x1)
> +#endif
> +
> +#define STACK_SIZE (1024 * 1024)
> +
> +static char child_stack[STACK_SIZE];
> +
> +static int child(void *arg)
> +{
> +	return 0;
> +}
> +
> +static void run(void)
> +{
> +	pid_t pid = ltp_clone(CLONE_NEWUSER, &child, 0,
> +		STACK_SIZE, child_stack);
> +
> +	char my_namespace[20], child_namespace[20];
> +
> +	sprintf(my_namespace, "/proc/self/ns/user");
> +	sprintf(child_namespace, "/proc/%i/ns/user", pid);
> +	int my_fd, child_fd, parent_fd;
> +
> +	my_fd = SAFE_OPEN(my_namespace, O_RDONLY);
> +	child_fd = SAFE_OPEN(child_namespace, O_RDONLY);

Isn't this racy? What happens if the child() function returns before we
happen to open this file?

> +	parent_fd = ioctl(child_fd, NS_GET_USERNS);
> +
> +	struct stat my_stat, child_stat, parent_stat;
> +
> +	fstat(my_fd, &my_stat);
> +	fstat(child_fd, &child_stat);
> +	fstat(parent_fd, &parent_stat);
> +	if (my_stat.st_ino != parent_stat.st_ino)
> +		tst_res(TFAIL, "parents have different inodes");
> +	else if (parent_stat.st_ino == child_stat.st_ino)
> +		tst_res(TFAIL, "child and parent have same inode");
> +	else
> +		tst_res(TPASS, "child and parent are consistent");
> +	SAFE_CLOSE(my_fd);
> +	SAFE_CLOSE(parent_fd);
> +	SAFE_CLOSE(child_fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
> +	.min_kver = "4.9",
> +};

The rest of the comments apply as well.

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns08.c b/testcases/kernel/syscalls/ioctl/ioctl_ns08.c
> new file mode 100644
> index 000000000..dcb2f11f4
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns08.c
> @@ -0,0 +1,72 @@
> +/*
> + * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
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
> +/*
> + * Test ioctl_ns with NS_GET_* request for file descriptors
> + * that aren't namespaces.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +#include <sched.h>
> +#include "tst_test.h"
> +
> +#ifndef NS_GET_USERNS
> +#define NSIO	0xb7
> +#define NS_GET_USERNS	   _IO(NSIO, 0x1)
> +#define NS_GET_PARENT	   _IO(NSIO, 0x2)
> +#define NS_GET_NSTYPE	   _IO(NSIO, 0x3)
> +#define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> +#endif
> +
> +static int requests[] = {NS_GET_PARENT, NS_GET_USERNS,
> +	NS_GET_OWNER_UID, NS_GET_NSTYPE};
> +
> +static void test_request(unsigned int n)
> +{
> +	int request = requests[n];
> +	int fd, ns_fd;
> +
> +	char *path = tst_get_tmpdir();

This leaks memory, also there is no need to pass the global path to
SAFE_OPEN below, it should work just fine with "." because the test PWD
is set to the temporary directory before this function is executed.

> +	fd = SAFE_OPEN(path, O_RDONLY);
> +	ns_fd = ioctl(fd, request);
> +	if (ns_fd == -1) {
> +		if (errno == ENOTTY)
> +			tst_res(TPASS, "request failed with ENOTTY");
> +		else
> +			tst_res(TFAIL, "unexpected error %u", errno);

Here as well use the TERRNO flag.

> +	} else {
> +		tst_res(TFAIL, "request succes for invalid fd");
> +		SAFE_CLOSE(ns_fd);
> +	}
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(requests),
> +	.test = test_request,
> +	.needs_tmpdir = 1,
> +	.min_kver = "4.11",
> +};

Generally these tests looks good, but needs a few adjustments.

-- 
Cyril Hrubis
chrubis@suse.cz
