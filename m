Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UcaxN-0003YI-3J
	for ltp-list@lists.sourceforge.net; Wed, 15 May 2013 12:37:21 +0000
Date: Wed, 15 May 2013 14:38:26 +0200
From: chrubis@suse.cz
Message-ID: <20130515123826.GA22782@rei>
References: <1368610801-25821-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1368610801-25821-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] New core test of cgroups and extended attributes
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
> @@ -0,0 +1,343 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * Test checks following preconditions:
> + * since Linux kernel 3.7 it is possible to set extended attributes
> + * to cgroup files.
> + */
> +
> +#include <sys/stat.h>
> +#include <sys/mount.h>
> +#include <sys/types.h>
> +#include <sys/xattr.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <dirent.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +
> +char *TCID = "cgroup_xattr";
> +
> +static const char cgrp_point[]	= "/sys/fs/cgroup";
> +static const char cgrp_name[]	= "cgrp_test";
> +static const char subdir_name[]	= "test";
> +
> +struct tst_key {
> +	const char *name;
> +	int good;
> +};
> +
> +/* only security.* & trusted.* is valid key names */
                                  ^ are
> +static const struct tst_key tkeys[] = {
> +	{ .name = "trusted.test",	.good = 1,	},
> +	{ .name = "security.",		.good = 1,	},
> +	{ .name = "user.",		.good = 0,	},
> +	{ .name = "system.",		.good = 0,	},
> +};
> +
> +#define VALUE_SIZE	8
> +
> +/*
> + * values that can be written to xattr keys,
> + * their can be anything
      ^ their value?
> + */
> +struct tst_val {
> +	char buf[VALUE_SIZE];
> +	size_t size;
> +};
> +
> +/* cleanup flags */
> +static int cgrp_mounted;
> +static int subdir_created;
> +
> +/* test options */
> +static int skip_cleanup;
> +static int verbose;
> +static const option_t options[] = {
> +	{"s", &skip_cleanup, NULL},
> +	{"v", &verbose, NULL},
> +	{NULL, NULL, NULL}
> +};
> +
> +/* save to change back in the end */
> +static char start_work_dir[PATH_MAX];
> +
> +static void help(void);
> +static void setup(int argc, char *argv[]);
> +static void test_run(void);
> +static void cleanup(void);
> +
> +static int set_xattrs(const char *file, const struct tst_val *val);
> +static char *get_xattr(const char *file, const char *key_name, size_t *size);
> +static int get_xattrs(const char *file, const struct tst_val *val);
> +/*
> + * set or get xattr recursively
> + *
> + * @path: start directory
> + * @id: start char to fill in value
> + * @xattr_operation: can be set_xattrs() or get_xattrs()
> + */
> +static int cgrp_files_walking(const char *path, char *id,
> +	int (*xattr_operation)(const char *, const struct tst_val *));
> +static char *get_hex_value(const char *value, size_t size);
> +static void fill_test_value(char *id, struct tst_val *val);
> +
> +
> +int main(int argc, char *argv[])
> +{
> +	setup(argc, argv);
> +
> +	test_run();
> +
> +	cleanup();
> +
> +	tst_exit();
> +}
> +
> +static void help(void)
> +{
> +	printf("  -s      Skip cleanup\n");
> +	printf("  -v      Verbose\n");
> +}
> +
> +void setup(int argc, char *argv[])
> +{
> +	char *msg;
> +	msg = parse_opts(argc, argv, options, help);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	tst_require_root(NULL);
> +
> +	if (access("/proc/cgroups", F_OK) == -1)
> +		tst_brkm(TCONF, cleanup, "Kernel doesn't support for cgroups");
> +
> +	if (tst_kvercmp(3, 7, 0) < 0) {
> +		tst_brkm(TCONF, cleanup,
> +			"Test must be run with kernel 3.7 or newer");
> +	}
> +
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	/* mount all available subsystems (cpu, cpuset, memory, ...) */
> +	if (mount(cgrp_name, cgrp_point, "cgroup", 0, "xattr") == -1)
> +		tst_brkm(TBROK, cleanup, "Can't mount: %s", cgrp_point);

Here we mount cgroups under /sys/fs/cgroup which later causes problems
as you need to switch to another directory to unmount.

I'm not that much familiar with cgroups, is mounting it to /sys/
required or is it customary? Wouldn't that interfere with rest of the
system?

What about calling tst_tmpdir(), creating a directory to mount the
cgroups there and then simply doing chdir to test temporary directory
before the unmount. Would that work?

> +	cgrp_mounted = 1;
> +
> +	/* save current working directory */
> +	SAFE_GETCWD(cleanup, start_work_dir, PATH_MAX);
> +	SAFE_CHDIR(cleanup, cgrp_point);
> +
> +	/* create new hierarchy */
> +	SAFE_MKDIR(cleanup, subdir_name, 0755);
> +	subdir_created = 1;
> +}
> +
> +static void test_run()

void in params is missing

> +{
> +	char id;
> +	/* set xattr to each file in cgroup fs */
> +	id = 0;
> +	int set_res = cgrp_files_walking(cgrp_point, &id, set_xattrs);

Here you are passing pointer to the value, modify it by the function but
never use the resulting value.

> +	/* get & check xattr from each file in cgroup fs */
> +	id = 0;
> +	int get_res = cgrp_files_walking(cgrp_point, &id, get_xattrs);
> +
> +	/* final results */
> +	tst_resm(TINFO, "All test-cases have been completed, summary:");
> +	tst_resm(TINFO, "Set tests result: %s", (set_res) ? "FAIL" : "PASS");
> +	tst_resm(TINFO, "Get tests result: %s", (get_res) ? "FAIL" : "PASS");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (skip_cleanup)
> +		return;
> +
> +	fflush(stdout);

What is this fflush() for?

> +	if (subdir_created) {
> +		SAFE_CHDIR(NULL, cgrp_point);
> +		if (rmdir(subdir_name) == -1) {
> +			tst_brkm(TBROK, NULL, "Can't remove dir, error: %s",
> +				strerror(errno));
> +		}
> +	}
> +
> +	if (strlen(start_work_dir) > 0)
> +		SAFE_CHDIR(NULL, start_work_dir);
> +
> +	if (cgrp_mounted) {
> +		if (umount(cgrp_point) == -1)
> +			tst_brkm(TBROK, NULL, "Can't unmount: %s", cgrp_point);
> +	}
> +
> +	TEST_CLEANUP;
> +}
> +
> +static int set_xattrs(const char *file, const struct tst_val *val)
> +{
> +	int i, res;
> +	res = 0;
> +	for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
> +		int good = setxattr(file, tkeys[i].name,
> +			(const void *)val->buf, val->size, 0) != -1;
> +
> +		int fail = good != tkeys[i].good;
> +		res |= fail;
> +
> +		tst_resm((fail) ? TFAIL : TPASS,
> +			"Expect: %s set xattr key '%s' to file '%s'",
> +			(tkeys[i].good) ? "can" : "can't",
> +			tkeys[i].name, file);
> +
> +		if (verbose && tkeys[i].good) {
> +			char *rval = get_hex_value(val->buf, val->size);
> +			tst_resm(TINFO, "value =%s", rval);
> +			free(rval);
> +		}
> +	}
> +	return res;
> +}
> +
> +static char *get_xattr(const char *file, const char *key_name, size_t *size)
> +{
> +	char *xval = NULL;
> +	/* get value size */
> +	ssize_t xval_size = getxattr(file, key_name, (void *)xval, 0);
	
	Pass NULL here, instead of the xval initialized to NULL.

> +	if (xval_size == -1)
> +		return NULL;
> +
> +	xval = SAFE_MALLOC(cleanup, xval_size);
> +
> +	if (getxattr(file, key_name, (void *)xval, xval_size) == -1) {
> +		free(xval);
> +		return NULL;
> +	}
> +	*size = xval_size;
> +	return xval;
> +}
> +
> +static int get_xattrs(const char *file, const struct tst_val *val)
> +{
> +	int i, fail, res;
> +	res = 0;
> +	for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
> +		size_t xval_size = 0;
> +		char *xval;
> +
> +		xval = get_xattr(file, tkeys[i].name, &xval_size);
> +		fail = (xval == NULL && tkeys[i].good);
> +		res |= fail;
> +
> +		tst_resm((fail) ? TFAIL : TPASS,
> +			"Expect: %s read xattr %s of file '%s'",
> +			(xval == NULL) ? "can't" : "can", tkeys[i].name, file);
> +		if (xval == NULL)
> +			continue;
> +
> +		if (fail) {
> +			free(xval);
> +			continue;
> +		}
> +
> +		fail |= val->size != xval_size ||
> +			strncmp(val->buf, xval, val->size) != 0;
> +		res |= fail;
> +
> +		tst_resm((fail) ? TFAIL : TPASS, "Expect: values equal");
> +
> +		if (verbose && fail) {
> +			char *rval = get_hex_value(xval, xval_size);
> +			tst_resm(TINFO, "Read xattr value:%s", rval);
> +			free(rval);
> +			char *cval = get_hex_value(val->buf, val->size);
> +			tst_resm(TINFO, "Expected   value:%s", cval);
> +			free(cval);
> +		}
> +		free(xval);
> +	}
> +	return res;
> +}
> +
> +static int cgrp_files_walking(const char *path, char *id,
> +	int (*xattr_operation)(const char *, const struct tst_val *))
> +{
> +	int res = 0;
> +	struct dirent *entry;
> +	DIR *dir;
> +	dir = opendir(path);
> +	SAFE_CHDIR(cleanup, path);
> +	tst_resm(TINFO, "In dir %s", path);
> +	errno = 0;
> +	while ((entry = readdir(dir)) != NULL) {
> +		const char *file = entry->d_name;
> +		/* skip current and up directories */
> +		if (!strcmp(file, "..") || !strcmp(file, "."))
> +			continue;
> +
> +		struct stat stat_buf;
> +		TEST(lstat(file, &stat_buf));
> +		if (TEST_RETURN != -1 && S_ISDIR(stat_buf.st_mode)) {
> +			/* proceed to subdir */
> +			res |= cgrp_files_walking(file, id, xattr_operation);
> +			/* change directory back */
> +			SAFE_CHDIR(cleanup, "..");
> +			tst_resm(TINFO, "In dir %s", path);
> +		}
> +		struct tst_val val;
> +		fill_test_value(id, &val);
> +		res |= xattr_operation(file, &val);
> +		errno = 0;
> +	}
> +	if (errno && !entry)
> +		tst_brkm(TWARN, cleanup, "%s", strerror(errno));

Use TERRNO and also describe the warning more verbosely.

> +	if (closedir(dir) == -1)
> +		tst_brkm(TWARN, cleanup, "Failed to close dir '%s'", path);
> +
> +	return res;
> +}
> +
> +static char *get_hex_value(const char *value, size_t size)
> +{
> +	const size_t symb_num = 5; /* space + 0xXX*/
> +	char *buf = SAFE_MALLOC(cleanup, size * symb_num + 1);
> +	size_t i;
> +	for (i = 0; i < size; ++i) {
> +		sprintf(buf + i * symb_num, " 0x%02X",
> +			(unsigned char) *(value++));
> +	}
> +	return buf;
> +}

This function is too ugly. You should rather do something like
print_xattr() that would both preprare the string and call the
tst_resm() so that you don't need to pass allocated buffers around.

void print_xattr(const char *msg, const char *val, size_t size)
{
	char buf[size + sybm_num + 1];
	...

	tst_resm(TINFO, "%s%s", msg, buf);
}

Or we can create a tst_xxx function to print a buffer of bytes, I guess
that there are more cases where such function could be used. But that
would require a little more work to desing the interface right.

> +static void fill_test_value(char *id, struct tst_val *val)
> +{
> +	int i;
> +	for (i = 0; i < VALUE_SIZE; ++i)
> +		val->buf[i] = *id;

What about using memset()?

> +	val->size = VALUE_SIZE;
> +	++(*id);

This is quite cryptic, why aren't you modifying the id in the loop that
calls this function?

What about just defining the id in the walk functions and incrementing
it each time fill_test_value() was called?

> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
