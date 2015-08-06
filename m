Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZNLvT-0000bk-Un
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2015 14:13:43 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZNLvR-0004vS-CE
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2015 14:13:43 +0000
Date: Thu, 6 Aug 2015 16:13:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150806141316.GA19339@rei.suse.de>
References: <1437654435-16682-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1437654435-16682-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] fcntl/fcntl32.c: add new test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Add new testcase to verify that a write lease may be placed
> on a file only if there are no other open file descriptors
> for the file.
> 
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> ---
>  runtest/ltplite                           |   1 +
>  runtest/syscalls                          |   2 +
>  testcases/kernel/syscalls/.gitignore      |   2 +
>  testcases/kernel/syscalls/fcntl/fcntl32.c | 129 ++++++++++++++++++++++++++++++
>  4 files changed, 134 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fcntl/fcntl32.c
> 
> diff --git a/runtest/ltplite b/runtest/ltplite
> index 3bc681c..8ce0daa 100644
> --- a/runtest/ltplite
> +++ b/runtest/ltplite
> @@ -225,6 +225,7 @@ fcntl26 fcntl26
>  fcntl29 fcntl29
>  fcntl30 fcntl30
>  fcntl31 fcntl31
> +fcntl32 fcntl32
>  
>  fdatasync01 fdatasync01
>  fdatasync02 fdatasync02
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 70d4945..0d14528 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -258,6 +258,8 @@ fcntl30 fcntl30
>  fcntl30_64 fcntl30_64
>  fcntl31 fcntl31
>  fcntl31_64 fcntl31_64
> +fcntl32 fcntl32
> +fcntl32_64 fcntl32_64
>  
>  fdatasync01 fdatasync01
>  fdatasync02 fdatasync02
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index 172aeec..13c7a79 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -221,6 +221,8 @@
>  /fcntl/fcntl30_64
>  /fcntl/fcntl31
>  /fcntl/fcntl31_64
> +/fcntl/fcntl32
> +/fcntl/fcntl32_64
>  /fdatasync/fdatasync01
>  /fdatasync/fdatasync02
>  /flock/flock01
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl32.c b/testcases/kernel/syscalls/fcntl/fcntl32.c
> new file mode 100644
> index 0000000..46e316f
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fcntl/fcntl32.c
> @@ -0,0 +1,129 @@
> +/*
> + * Copyright (c) 2015 Fujitsu Ltd.
> + * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License
> + * alone with this program.
> + */
> +
> +/*
> + * DESCRIPTION
> + *  Basic test for fcntl(2) using F_SETLEASE & F_WRLCK argument.
> + *  "A write lease may be placed on a file only if there are
> + *  no other open file descriptors for the file."
> + */
> +
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "tst_fs_type.h"
> +
> +static void setup(void);
> +static void fcntl_verify(int);
> +static void cleanup(void);
> +
> +#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID)
> +
> +int fd1;
> +int fd2;

static

> +static struct test_case_t {
> +	int fd1_flag;
> +	int fd2_flag;
> +} test_cases[] = {
> +	{O_RDONLY, O_RDONLY},
> +	{O_RDONLY, O_WRONLY},
> +	{O_RDONLY, O_RDWR},
> +	{O_WRONLY, O_RDONLY},
> +	{O_WRONLY, O_WRONLY},
> +	{O_WRONLY, O_RDWR},
> +	{O_RDWR, O_RDONLY},
> +	{O_RDWR, O_WRONLY},
> +	{O_RDWR, O_RDWR},
> +};
> +
> +char *TCID = "fcntl32";
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int tc;
> +	long type;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	switch ((type = tst_fs_type(cleanup, "."))) {
> +	case TST_NFS_MAGIC:
> +	case TST_RAMFS_MAGIC:
> +	case TST_TMPFS_MAGIC:
> +		tst_brkm(TCONF, cleanup,
> +			"Cannot do fcntl on a file on %s filesystem",
                                   ^
				   fcntl(..., F_SETLEASE, ...)

		Otherwise this is quite missleading.

> +			tst_fs_type_name(type));
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (tc = 0; tc < TST_TOTAL; tc++)
> +			fcntl_verify(tc);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	SAFE_TOUCH(cleanup, "file", FILE_MODE, NULL);
> +}
> +
> +static void fcntl_verify(int i)
> +{
> +	fd1 = SAFE_OPEN(cleanup, "file", test_cases[i].fd1_flag);
> +	fd2 = SAFE_OPEN(cleanup, "file", test_cases[i].fd2_flag);
> +
> +	TEST(fcntl(fd1, F_SETLEASE, F_WRLCK));
> +
> +	SAFE_CLOSE(cleanup, fd1);
> +	fd1 = 0;
> +	SAFE_CLOSE(cleanup, fd2);
> +	fd2 = 0;
> +
> +	if (TEST_RETURN != -1) {
> +		tst_resm(TFAIL, "fcntl(2) succeeded unexpectedly");

                                 ^
				 fcntl(..., F_SETLEASE, F_WRLCK)

> +		return;
> +	}

Hmm do we care about specific errno here?

I would expect EBUSY or EAGAIN.

> +	tst_resm(TPASS | TTERRNO, "fcntl(2) failed as expected");
                                       ^
				       here as well
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd1 > 0 && close(fd1))
> +		tst_resm(TWARN | TTERRNO, "Failed to close file");
> +
> +	if (fd2 > 0 && close(fd2))
> +		tst_resm(TWARN | TTERRNO, "Failed to close file");
> +
> +	tst_rmdir();
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
