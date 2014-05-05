Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WhLps-0005qv-1a
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 16:33:48 +0000
Date: Mon, 5 May 2014 18:32:49 +0200
From: chrubis@suse.cz
Message-ID: <20140505163249.GD11256@rei>
References: <1396350731.10607.12.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1396350731.10607.12.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] readdir/readdir03.c: add new error number testes
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> --- /dev/null
> +++ b/testcases/kernel/syscalls/readdir/readdir03.c
> @@ -0,0 +1,151 @@
> +/*
> + * Copyright (c) 2014 Fujitsu Ltd.
> + * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> + *
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU Library General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + *
> + */
> +/*
> + * Test Description:
> + *  Verify that,
> + *   1. Creat a directory and open it, then delete the directory, ENOENT would
> + *	return.
> + *   2. File descriptor does not refer to a directory, ENOTDIR would return.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <limits.h>
> +#include <dirent.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +
> +char *TCID = "readdir03";
> +
> +#if !defined __x86_64__

Why is the test disabled on x86_64? What about other 64 bit
architectures?

> +#define TEST_DIR	"test_dir"
> +#define TEST_FILE	"test_file"
> +#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
> +			 S_IXGRP|S_IROTH|S_IXOTH)
> +
> +struct old_linux_dirent {
> +	long  d_ino;
> +	off_t d_off;
> +	unsigned short d_reclen;
> +	char  d_name[NAME_MAX+1];
> +};
> +
> +static unsigned int del_dir_fd, file_fd;
> +static struct old_linux_dirent dirp;
> +static void setup(void);
> +static void cleanup(void);
> +
> +static struct test_case_t {
> +	unsigned int *fd;
> +	struct old_linux_dirent *dirp;
> +	unsigned int count;
> +	int exp_errno;
> +} test_cases[] = {
> +	{&del_dir_fd, &dirp, sizeof(struct old_linux_dirent), ENOENT},
> +	{&file_fd, &dirp, sizeof(struct old_linux_dirent), ENOTDIR},
> +};
> +
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +static int exp_enos[] = { ENOENT, ENOTDIR, 0 };
> +static void readdir_verify(const struct test_case_t *);
> +
> +int main(int argc, char **argv)
> +{
> +	int i, lc;
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +		for (i = 0; i < TST_TOTAL; i++)
> +			readdir_verify(&test_cases[i]);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_EXP_ENOS(exp_enos);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	SAFE_MKDIR(cleanup, TEST_DIR, DIR_MODE);
> +	del_dir_fd = SAFE_OPEN(cleanup, TEST_DIR, O_RDONLY | O_DIRECTORY);
> +	if (rmdir(TEST_DIR) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "rmdir failed");
> +
> +	file_fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0777);
> +}
> +
> +static void readdir_verify(const struct test_case_t *test)
> +{
> +	TEST(syscall(__NR_readdir, *test->fd, test->dirp, test->count));

So you are using raw readdir() syscall (man 2 readdir) instead of the
glibc readdir() (man 3 readdir).

Are you aware that the rest of the readdir testcases use the glibc
readdir()?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
