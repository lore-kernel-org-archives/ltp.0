From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Feb 2016 14:32:32 +0100
Subject: [LTP] [PATCH v3 5/5] kernel/syscalls: add new test with 'open()
 + O_TMPFILE'
In-Reply-To: <1454069150-27889-6-git-send-email-alexey.kodanev@oracle.com>
References: <1454069150-27889-1-git-send-email-alexey.kodanev@oracle.com>
 <1454069150-27889-6-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160209133232.GA11823@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/fcntl.h"
> +
> +char *TCID = "open14";
> +int TST_TOTAL = 3;
> +static ssize_t size;
> +static char buf[1024];
> +static const ssize_t blocks_num = 4;
> +static struct stat st;
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
> +static void setup(void)
> +{
> +	tst_tmpdir();
> +
> +	size = sizeof(buf);
> +
> +	memset(buf, 1, size);
> +
> +	int fd = open(".", O_TMPFILE | O_RDWR, 0600);
> +
> +	if (fd == -1) {
> +		if (errno == EISDIR)
> +			tst_brkm(TCONF, cleanup, "O_TMPFILE not supported");
> +
> +		tst_brkm(TBROK | TERRNO, cleanup, "open() failed");
> +	}
> +
> +	SAFE_CLOSE(cleanup, fd);
> +}
> +
> +static void write_file(int fd)
> +{
> +	int i;
> +
> +	for (i = 0; i < blocks_num; ++i)
> +		SAFE_WRITE(cleanup, 1, fd, buf, size);
> +}
> +
> +void test01(void)
> +{
> +	int fd;
> +	char path[PATH_MAX], tmp[PATH_MAX];
> +
> +	tst_resm(TINFO, "creating a file with O_TMPFILE flag");
> +	fd = SAFE_OPEN(cleanup, ".", O_TMPFILE | O_RDWR, 0600);
> +
> +	tst_resm(TINFO, "writing data to the file");
> +	write_file(fd);
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
> +	tst_resm(TINFO, "looking for the file in '.'");
> +	if (!tst_dir_is_empty(cleanup, ".", 1))
> +		tst_brkm(TFAIL, cleanup, "found a file, this is not expected");
> +	tst_resm(TINFO, "file not found, OK");
> +
> +	snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
> +	SAFE_READLINK(cleanup, path, tmp, PATH_MAX);
> +
> +	tst_resm(TINFO, "renaming '%s' -> 'tmpfile'", tmp);
> +	SAFE_LINKAT(cleanup, AT_FDCWD, path, AT_FDCWD, "tmpfile",
> +		    AT_SYMLINK_FOLLOW);
> +
> +	if (tst_dir_is_empty(cleanup, ".", 1))
> +		tst_brkm(TFAIL, cleanup, "file not found");
> +
> +	SAFE_UNLINK(cleanup, "tmpfile");
> +	SAFE_CLOSE(cleanup, fd);
> +
> +	tst_resm(TPASS, "single file tests passed");
> +}
> +
> +static void read_file(int fd)
> +{
> +	int i;
> +	char tmp[size];
> +
> +	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
> +
> +	for (i = 0; i < blocks_num; ++i) {
> +		SAFE_READ(cleanup, 0, fd, tmp, size);
> +		if (memcmp(buf, tmp, size))
> +			tst_brkm(TFAIL, cleanup, "got unexepected data");
> +	}
> +}
> +
> +static void test02(void)
> +{
> +	const int files_num = 100;
> +	int i, fd[files_num];
> +	char path[PATH_MAX];
> +
> +	tst_resm(TINFO, "create files in multiple directories");
> +	for (i = 0; i < files_num; ++i) {
> +		snprintf(path, PATH_MAX, "tst02_%d", i);
> +		SAFE_MKDIR(cleanup, path, 0700);
> +		SAFE_CHDIR(cleanup, path);
> +
> +		fd[i] = SAFE_OPEN(cleanup, ".", O_TMPFILE | O_RDWR, 0600);
> +
> +		write_file(fd[i]);

We don't have to write the file here, if I'm not mistaken.

> +	}
> +
> +	tst_resm(TINFO, "removing test directories");
> +	for (i = files_num - 1; i >= 0; --i) {
> +		SAFE_CHDIR(cleanup, "..");
> +		snprintf(path, PATH_MAX, "tst02_%d", i);
> +		SAFE_RMDIR(cleanup, path);
> +	}
> +
> +	tst_resm(TINFO, "writing/reading temporary files");
> +	for (i = 0; i < files_num; ++i) {
> +		write_file(fd[i]);
> +		read_file(fd[i]);
> +	}
> +
> +	tst_resm(TINFO, "closing temporary files");
> +	for (i = 0; i < files_num; ++i)
> +		SAFE_CLOSE(cleanup, fd[i]);
> +
> +	tst_resm(TPASS, "multiple files tests passed");
> +}
> +
> +static void link_tmp_file(int fd)
> +{
> +	char path1[PATH_MAX], path2[PATH_MAX];
> +
> +	snprintf(path1, PATH_MAX,  "/proc/self/fd/%d", fd);
> +	snprintf(path2, PATH_MAX,  "tmpfile_%d", fd);
> +
> +	SAFE_LINKAT(cleanup, AT_FDCWD, path1, AT_FDCWD, path2,
> +		    AT_SYMLINK_FOLLOW);
> +}
> +
> +static const int tst_perm[] = { 0, 07777, 001, 0755, 0644, 0440 };
> +
> +static void test03(void)
> +{
> +	const int files_num = 100;
> +	int i, fd[files_num];
> +	char path[PATH_MAX];
> +	struct stat st;
> +	unsigned int j;
> +	mode_t mask = umask(0);
> +
> +	umask(mask);
> +
> +	tst_resm(TINFO, "create multiple directories, link files into them");
> +	tst_resm(TINFO, "and check file permissions");
> +	for (i = 0, j = 0; i < files_num; ++i) {
> +
> +		snprintf(path, PATH_MAX, "tst03_%d", i);
> +		SAFE_MKDIR(cleanup, path, 0700);
> +		SAFE_CHDIR(cleanup, path);
> +
> +		fd[i] = SAFE_OPEN(cleanup, ".", O_TMPFILE | O_RDWR,
> +				  tst_perm[j]);

You can just use i % ARRAY_SIZE(tst_perms) instead of the j variable.

> +
> +		write_file(fd[i]);
> +		read_file(fd[i]);
> +
> +		link_tmp_file(fd[i]);
> +
> +		snprintf(path, PATH_MAX, "tmpfile_%d", fd[i]);
> +
> +		SAFE_LSTAT(cleanup, path, &st);
> +
> +		mode_t exp_mode = tst_perm[j] & ~mask;
> +
> +		if ((st.st_mode & ~S_IFMT) != exp_mode) {
> +			tst_brkm(TFAIL, cleanup,
> +				"file mode read %o, but expected %o",
> +				st.st_mode & ~S_IFMT, exp_mode);
> +		}
> +
> +		if (++j >= ARRAY_SIZE(tst_perm))
> +			j = 0;
> +	}
> +
> +	tst_resm(TINFO, "remove files, directories");
> +	for (i = files_num - 1; i >= 0; --i) {
> +		snprintf(path, PATH_MAX, "tmpfile_%d", fd[i]);
> +		SAFE_UNLINK(cleanup, path);
> +		SAFE_CLOSE(cleanup, fd[i]);
> +
> +		SAFE_CHDIR(cleanup, "..");
> +
> +		snprintf(path, PATH_MAX, "tst03_%d", i);
> +		SAFE_RMDIR(cleanup, path);
> +	}
> +
> +	tst_resm(TPASS, "file permission tests passed");
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
> +		test02();
> +		test03();
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> diff --git a/testcases/kernel/syscalls/openat/openat03.c b/testcases/kernel/syscalls/openat/openat03.c
> new file mode 100644
> index 0000000..441c84b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/openat/openat03.c
> @@ -0,0 +1,263 @@
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
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/fcntl.h"
> +#include "openat.h"
> +
> +char *TCID = "openat03";
> +int TST_TOTAL = 3;
> +static ssize_t size;
> +static char buf[1024];
> +static const ssize_t blocks_num = 4;
> +static struct stat st;
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
> +static void setup(void)
> +{
> +	tst_tmpdir();
> +
> +	size = sizeof(buf);
> +
> +	memset(buf, 1, size);
> +
> +	int fd = openat(AT_FDCWD, ".", O_TMPFILE | O_RDWR, 0600);
> +
> +	if (fd == -1) {
> +		if (errno == EISDIR)
> +			tst_brkm(TCONF, cleanup, "O_TMPFILE not supported");
> +
> +		tst_brkm(TBROK | TERRNO, cleanup, "openat() failed");
> +	}
> +
> +	SAFE_CLOSE(cleanup, fd);
> +}
> +
> +static int tst_openat_tmp(int mode)
> +{
> +	int fd = openat(AT_FDCWD, ".", O_TMPFILE | O_RDWR, mode);
> +
> +	if (fd >= 0)
> +		return fd;
> +
> +	tst_brkm(TBROK | TERRNO, cleanup, "openat() failed");
> +}

Any identifier that starts with tst_ or TST_ is reserved for test
library. Can you rename it to something else (do_openat) or so that we
avoid possible future collision.

> +static void write_file(int fd)
> +{
> +	int i;
> +
> +	for (i = 0; i < blocks_num; ++i)
> +		SAFE_WRITE(cleanup, 1, fd, buf, size);
> +}
> +
> +void test01(void)
> +{
> +	int fd;
> +	char path[PATH_MAX], tmp[PATH_MAX];
> +
> +	tst_resm(TINFO, "creating a file with O_TMPFILE flag");
> +	fd = tst_openat_tmp(0600);
> +
> +	tst_resm(TINFO, "writing data to the file");
> +	write_file(fd);
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
> +	tst_resm(TINFO, "looking for the file in '.'");
> +	if (!tst_dir_is_empty(cleanup, ".", 1))
> +		tst_brkm(TFAIL, cleanup, "found a file, this is not expected");
> +	tst_resm(TINFO, "file not found, OK");
> +
> +	snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
> +	SAFE_READLINK(cleanup, path, tmp, PATH_MAX);
> +
> +	tst_resm(TINFO, "renaming '%s' -> 'tmpfile'", tmp);
> +	SAFE_LINKAT(cleanup, AT_FDCWD, path, AT_FDCWD, "tmpfile",
> +		    AT_SYMLINK_FOLLOW);
> +
> +	if (tst_dir_is_empty(cleanup, ".", 1))
> +		tst_brkm(TFAIL, cleanup, "file not found");
> +
> +	SAFE_UNLINK(cleanup, "tmpfile");
> +	SAFE_CLOSE(cleanup, fd);
> +
> +	tst_resm(TPASS, "single file tests passed");
> +}
> +
> +static void read_file(int fd)
> +{
> +	int i;
> +	char tmp[size];
> +
> +	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
> +
> +	for (i = 0; i < blocks_num; ++i) {
> +		SAFE_READ(cleanup, 0, fd, tmp, size);
> +		if (memcmp(buf, tmp, size))
> +			tst_brkm(TFAIL, cleanup, "got unexepected data");
> +	}
> +}
> +
> +static void test02(void)
> +{
> +	const int files_num = 100;
> +	int i, fd[files_num];
> +	char path[PATH_MAX];
> +
> +	tst_resm(TINFO, "create files in multiple directories");
> +	for (i = 0; i < files_num; ++i) {
> +		snprintf(path, PATH_MAX, "tst02_%d", i);
> +		SAFE_MKDIR(cleanup, path, 0700);
> +		SAFE_CHDIR(cleanup, path);
> +
> +		fd[i] = tst_openat_tmp(0600);
> +
> +		write_file(fd[i]);

Here as well.

> +	}
> +
> +	tst_resm(TINFO, "removing test directories");
> +	for (i = files_num - 1; i >= 0; --i) {
> +		SAFE_CHDIR(cleanup, "..");
> +		snprintf(path, PATH_MAX, "tst02_%d", i);
> +		SAFE_RMDIR(cleanup, path);
> +	}
> +
> +	tst_resm(TINFO, "writing/reading temporary files");
> +	for (i = 0; i < files_num; ++i) {
> +		write_file(fd[i]);
> +		read_file(fd[i]);
> +	}
> +
> +	tst_resm(TINFO, "closing temporary files");
> +	for (i = 0; i < files_num; ++i)
> +		SAFE_CLOSE(cleanup, fd[i]);
> +
> +	tst_resm(TPASS, "multiple files tests passed");
> +}
> +
> +static void link_tmp_file(int fd)
> +{
> +	char path1[PATH_MAX], path2[PATH_MAX];
> +
> +	snprintf(path1, PATH_MAX,  "/proc/self/fd/%d", fd);
> +	snprintf(path2, PATH_MAX,  "tmpfile_%d", fd);
> +
> +	SAFE_LINKAT(cleanup, AT_FDCWD, path1, AT_FDCWD, path2,
> +		    AT_SYMLINK_FOLLOW);
> +}
> +
> +static const int tst_perm[] = { 0, 07777, 001, 0755, 0644, 0440 };
> +
> +static void test03(void)
> +{
> +	const int files_num = 100;
> +	int i, fd[files_num];
> +	char path[PATH_MAX];
> +	struct stat st;
> +	unsigned int j;
> +	mode_t mask = umask(0);
> +
> +	umask(mask);
> +
> +	tst_resm(TINFO, "create multiple directories, link files into them");
> +	tst_resm(TINFO, "and check file permissions");
> +	for (i = 0, j = 0; i < files_num; ++i) {
> +
> +		snprintf(path, PATH_MAX, "tst03_%d", i);
> +		SAFE_MKDIR(cleanup, path, 0700);
> +		SAFE_CHDIR(cleanup, path);
> +
> +		fd[i] = tst_openat_tmp(tst_perm[j]);

Here as well.

> +		write_file(fd[i]);
> +		read_file(fd[i]);
> +
> +		link_tmp_file(fd[i]);
> +
> +		snprintf(path, PATH_MAX, "tmpfile_%d", fd[i]);
> +
> +		SAFE_LSTAT(cleanup, path, &st);
> +
> +		mode_t exp_mode = tst_perm[j] & ~mask;
> +
> +		if ((st.st_mode & ~S_IFMT) != exp_mode) {
> +			tst_brkm(TFAIL, cleanup,
> +				"file mode read %o, but expected %o",
> +				st.st_mode & ~S_IFMT, exp_mode);
> +		}
> +
> +		if (++j >= ARRAY_SIZE(tst_perm))
> +			j = 0;
> +	}
> +
> +	tst_resm(TINFO, "remove files, directories");
> +	for (i = files_num - 1; i >= 0; --i) {
> +		snprintf(path, PATH_MAX, "tmpfile_%d", fd[i]);
> +		SAFE_UNLINK(cleanup, path);
> +		SAFE_CLOSE(cleanup, fd[i]);
> +
> +		SAFE_CHDIR(cleanup, "..");
> +
> +		snprintf(path, PATH_MAX, "tst03_%d", i);
> +		SAFE_RMDIR(cleanup, path);
> +	}
> +
> +	tst_resm(TPASS, "file permission tests passed");
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
> +		test02();
> +		test03();
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}


The rest of the patchset looks good.

Acked with the minor issues I pointed out fixed.

-- 
Cyril Hrubis
chrubis@suse.cz
