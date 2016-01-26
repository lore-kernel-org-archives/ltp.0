From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jan 2016 17:24:43 +0100
Subject: [LTP] [PATCH] kernel/syscalls: add new test with 'open() +
 O_TMPFILE'
In-Reply-To: <1451471611-17666-1-git-send-email-alexey.kodanev@oracle.com>
References: <1451471611-17666-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160126162442.GA21691@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +
> +#ifndef O_TMPFILE
> +#define O_TMPFILE	(020000000 | O_DIRECTORY)
> +#endif

This should better be added to include/lapi/fcntl.h so that we do not
have to add it to each test that needs it.

> +char *TCID = "open14";
> +int TST_TOTAL = 1;
> +static char *test_dir;
> +static ssize_t size;
> +static const ssize_t blocks_num = 4;
> +static char *buf;
> +static struct stat st;
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +	free(test_dir);
> +	free(buf);
> +}
> +
> +static void setup(void)
> +{
> +	tst_tmpdir();
> +	test_dir = tst_get_tmpdir();
> +
> +	SAFE_STAT(cleanup, test_dir, &st);
> +	size = st.st_blksize;

Any reason why we cannot use relative path to the test directory, which
sould be "." while the test runs?

> +	buf = SAFE_MALLOC(cleanup, size);
> +	memset(buf, 1, size);
> +}
> +
> +static int dir_not_empty(void)
> +{
> +	struct dirent *entry;
> +	DIR *dir = SAFE_OPENDIR(cleanup, test_dir);
> +	int ret = 0;
> +
> +	while ((entry = SAFE_READDIR(cleanup, dir)) != NULL) {
> +		const char *file = entry->d_name;
> +
> +		if (!strcmp(file, "..") || !strcmp(file, "."))
> +			continue;
> +
> +		tst_resm(TINFO, "found a file: %s", file);
> +		ret = 1;
> +		break;
> +	}
> +
> +	SAFE_CLOSEDIR(cleanup, dir);
> +	return ret;
> +}
> +
> +void test01(void)
> +{
> +	int fd, i;
> +
> +	char path[PATH_MAX], tmp[PATH_MAX];
> +
> +	tst_resm(TINFO, "creating a file with O_TMPFILE flag");
> +
> +	TEST(open(test_dir, O_TMPFILE | O_WRONLY | O_SYNC));
> +	fd = TEST_RETURN;
> +	if (fd == -1) {
> +		if (TEST_ERRNO == EISDIR) {
> +			tst_brkm(TCONF, cleanup,
> +				"O_TMPFILE not supported");
> +		}

Hmm, looks to me like the TEST() macro just complicates the code here.
It would work just the same if we did fd = open(...) instead and use
errno instead of TEST_ERRNO.

> +		tst_resm(TFAIL | TERRNO, "open() failed");
                                 ^
				 This should be TTERRNO in case we use
				 TEST() macro. Well both would work in
				 this case since but we should stick to
				 TTERRNO if TEST() has been used.
> +		return;
> +	}
> +
> +	tst_resm(TINFO, "writing data to the file");
> +	for (i = 0; i < blocks_num; ++i)
> +		SAFE_WRITE(cleanup, 0, fd, buf, size);

Hmm, getting size from fstat() seems like an overkill to me. We do not
need to choose optimal transfer size since the difference in speed with
constant buffer (be it 1024 or something else) would not be noticeable
in this case.

Also we should pass 1 as len_strict to the SAFE_WRITE() here.

> +	SAFE_FSTAT(cleanup, fd, &st);
> +	tst_resm(TINFO, "file size is '%zu'", st.st_size);
> +
> +	if (st.st_size != blocks_num * size) {
> +		tst_resm(TFAIL, "not expected size: '%zu' != '%zu'",
> +			 st.st_size, blocks_num * size);
> +		SAFE_CLOSE(cleanup, fd);
> +		return;
> +	}
> +
> +	tst_resm(TINFO, "looking for the file in '%s'", test_dir);
> +	if (dir_not_empty())
> +		tst_brkm(TBROK, cleanup, "found a file, this is not expected");
> +	tst_resm(TINFO, "file not found, OK");
> +
> +	snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
> +	if (readlink(path, tmp, PATH_MAX) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "readlink() failed");
> +
> +	tst_resm(TINFO, "renaming '%s' -> '%s/tmpfile'",
> +		 tmp, test_dir);
> +	if (linkat(AT_FDCWD, path, AT_FDCWD, "tmpfile", AT_SYMLINK_FOLLOW))
> +		tst_brkm(TBROK | TERRNO, cleanup, "linkat() failed");

We may add SAFE_LINKAT().

> +	if (!dir_not_empty())
> +		tst_brkm(TBROK, cleanup, "file not found");
> +
> +	SAFE_UNLINK(cleanup, "tmpfile");
> +	SAFE_CLOSE(cleanup, fd);
> +
> +	tst_resm(TPASS, "test succeeded");
> +}
> +
> +int main(int ac, char *av[])
> +{
> +	int lc;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +		tst_count = 0;
> +		test01();
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> diff --git a/testcases/kernel/syscalls/openat/openat03.c b/testcases/kernel/syscalls/openat/openat03.c
> new file mode 100644
> index 0000000..d81989e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/openat/openat03.c
> @@ -0,0 +1,154 @@
> +/*
> + * Copyright (c) 2015-2016 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + *
> + * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "openat.h"
> +
> +#ifndef O_TMPFILE
> +#define O_TMPFILE	(020000000 | O_DIRECTORY)
> +#endif
> +
> +char *TCID = "openat03";
> +int TST_TOTAL = 1;
> +static char *test_dir;
> +static ssize_t size;
> +static const ssize_t blocks_num = 4;
> +static char *buf;
> +static struct stat st;
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +	free(test_dir);
> +	free(buf);
> +}
> +
> +static void setup(void)
> +{
> +	tst_tmpdir();
> +	test_dir = tst_get_tmpdir();
> +
> +	SAFE_STAT(cleanup, test_dir, &st);
> +	size = st.st_blksize;
> +
> +	buf = SAFE_MALLOC(cleanup, size);
> +	memset(buf, 1, size);
> +}
> +
> +static int dir_not_empty(void)
> +{
> +	struct dirent *entry;
> +	DIR *dir = SAFE_OPENDIR(cleanup, test_dir);
> +	int ret = 0;
> +
> +	while ((entry = SAFE_READDIR(cleanup, dir)) != NULL) {
> +		const char *file = entry->d_name;
> +
> +		if (!strcmp(file, "..") || !strcmp(file, "."))
> +			continue;
> +
> +		tst_resm(TINFO, "found a file: %s", file);
> +		ret = 1;
> +		break;
> +	}
> +
> +	SAFE_CLOSEDIR(cleanup, dir);
> +	return ret;
> +}

Maybe we should add this function to a library, since it's used at two
places allready.

> +void test01(void)
> +{
> +	int fd, i;
> +
> +	char path[PATH_MAX], tmp[PATH_MAX];
> +
> +	tst_resm(TINFO, "creating a file with O_TMPFILE flag");
> +
> +	TEST(openat(AT_FDCWD, test_dir, O_TMPFILE | O_WRONLY | O_SYNC));
> +	fd = TEST_RETURN;
> +	if (fd == -1) {
> +		if (TEST_ERRNO == EISDIR) {
> +			tst_brkm(TCONF, cleanup,
> +				"O_TMPFILE not supported");
> +		}
> +		tst_resm(TFAIL | TERRNO, "openat() failed");
> +		return;
> +	}
> +
> +	tst_resm(TINFO, "writing data to the file");
> +	for (i = 0; i < blocks_num; ++i)
> +		SAFE_WRITE(cleanup, 0, fd, buf, size);
> +
> +	SAFE_FSTAT(cleanup, fd, &st);
> +	tst_resm(TINFO, "file size is '%zu'", st.st_size);
> +
> +	if (st.st_size != blocks_num * size) {
> +		tst_resm(TFAIL, "not expected size: '%zu' != '%zu'",
> +			 st.st_size, blocks_num * size);
> +		SAFE_CLOSE(cleanup, fd);
> +		return;
> +	}
> +
> +	tst_resm(TINFO, "looking for the file in '%s'", test_dir);
> +	if (dir_not_empty())
> +		tst_brkm(TBROK, cleanup, "found a file, this is not expected");
> +	tst_resm(TINFO, "file not found, OK");
> +
> +	snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
> +	if (readlink(path, tmp, PATH_MAX) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "readlink() failed");
> +
> +	tst_resm(TINFO, "renaming '%s' -> '%s/tmpfile'",
> +		 tmp, test_dir);
> +	if (linkat(AT_FDCWD, path, AT_FDCWD, "tmpfile", AT_SYMLINK_FOLLOW))
> +		tst_brkm(TBROK | TERRNO, cleanup, "linkat() failed");
> +
> +	if (!dir_not_empty())
> +		tst_brkm(TBROK, cleanup, "file not found");
> +
> +	SAFE_UNLINK(cleanup, "tmpfile");
> +	SAFE_CLOSE(cleanup, fd);
> +
> +	tst_resm(TPASS, "test succeeded");
> +}
> +
> +int main(int ac, char *av[])
> +{
> +	int lc;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +		tst_count = 0;
> +		test01();
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}

The same comments applies to this test as well.

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
