From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Mar 2017 13:17:56 +0100
Subject: [LTP] [PATCH v2 5/6] syscalls: added memfd_create dir and
 memfd_create/memfd_create01.c
In-Reply-To: <1488822340-29259-6-git-send-email-jracek@redhat.com>
References: <1488822340-29259-1-git-send-email-jracek@redhat.com>
 <1488822340-29259-6-git-send-email-jracek@redhat.com>
Message-ID: <20170307121756.GC1261@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * Do few basic sealing tests to see whether setting/retrieving seals works.
> + */
> +static void test_basic(int fd)
> +{
> +	/* add basic seals */
> +	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
> +	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_SHRINK |
> +			F_SEAL_WRITE));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SHRINK |
> +			F_SEAL_WRITE));
> +
> +	/* add them again */
> +	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_SHRINK |
> +			F_SEAL_WRITE));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SHRINK |
> +			F_SEAL_WRITE));
> +
> +	/* add more seals and seal against sealing */
> +	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_GROW | F_SEAL_SEAL));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SHRINK |
> +			F_SEAL_GROW |
> +			F_SEAL_WRITE |
> +			F_SEAL_SEAL));
> +
> +	/* verify that sealing no longer works */
> +	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_GROW));
> +	CHECK_RESULT(mfd_fail_add_seals(fd, 0));
> +
> +	tst_res(TPASS, "%s", __func__);
> +}
> +
> +/*
> + * Verify that no sealing is possible when memfd is created without
> + * MFD_ALLOW_SEALING flag.
> + */
> +static void test_no_sealing_without_flag(int fd)
> +{
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SEAL));
> +	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_SHRINK |
> +			F_SEAL_GROW |
> +			F_SEAL_WRITE));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SEAL));
> +
> +	tst_res(TPASS, "%s", __func__);
> +}
> +
> +/*
> + * Test SEAL_WRITE
> + * Test whether SEAL_WRITE actually prevents modifications.
> + */
> +static void test_seal_write(int fd)
> +{
> +	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
> +	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_WRITE));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE));
> +
> +	CHECK_RESULT(mfd_assert_read(fd));
> +	CHECK_RESULT(mfd_fail_write(fd));
> +	CHECK_RESULT(mfd_assert_shrink(fd));
> +	CHECK_RESULT(mfd_assert_grow(fd));
> +	CHECK_RESULT(mfd_fail_grow_write(fd));
> +
> +	tst_res(TPASS, "%s", __func__);
> +}
> +
> +/*
> + * Test SEAL_SHRINK
> + * Test whether SEAL_SHRINK actually prevents shrinking
> + */
> +static void test_seal_shrink(int fd)
> +{
> +	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
> +	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_SHRINK));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SHRINK));
> +
> +	CHECK_RESULT(mfd_assert_read(fd));
> +	CHECK_RESULT(mfd_assert_write(fd));
> +	CHECK_RESULT(mfd_fail_shrink(fd));
> +	CHECK_RESULT(mfd_assert_grow(fd));
> +	CHECK_RESULT(mfd_assert_grow_write(fd));
> +
> +	tst_res(TPASS, "%s", __func__);
> +}
> +
> +/*
> + * Test SEAL_GROW
> + * Test whether SEAL_GROW actually prevents growing
> + */
> +static void test_seal_grow(int fd)
> +{
> +	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
> +	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_GROW));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_GROW));
> +
> +	CHECK_RESULT(mfd_assert_read(fd));
> +	CHECK_RESULT(mfd_assert_write(fd));
> +	CHECK_RESULT(mfd_assert_shrink(fd));
> +	CHECK_RESULT(mfd_fail_grow(fd));
> +	CHECK_RESULT(mfd_fail_grow_write(fd));
> +
> +	tst_res(TPASS, "%s", __func__);
> +}
> +
> +/*
> + * Test SEAL_SHRINK | SEAL_GROW
> + * Test whether SEAL_SHRINK | SEAL_GROW actually prevents resizing
> + */
> +static void test_seal_resize(int fd)
> +{
> +	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
> +	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_SHRINK | F_SEAL_GROW));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SHRINK | F_SEAL_GROW));
> +
> +	CHECK_RESULT(mfd_assert_read(fd));
> +	CHECK_RESULT(mfd_assert_write(fd));
> +	CHECK_RESULT(mfd_fail_shrink(fd));
> +	CHECK_RESULT(mfd_fail_grow(fd));
> +	CHECK_RESULT(mfd_fail_grow_write(fd));
> +
> +	tst_res(TPASS, "%s", __func__);
> +}
> +
> +/*
> + * Test sharing via dup()
> + * Test that seals are shared between dupped FDs and they're all equal.
> + */
> +static void test_share_dup(int fd)
> +{
> +	int fd2;
> +
> +	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
> +
> +	fd2 = SAFE_DUP(fd);
> +	CHECK_RESULT(mfd_assert_has_seals(fd2, 0));
> +
> +	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_WRITE));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE));
> +	CHECK_RESULT(mfd_assert_has_seals(fd2, F_SEAL_WRITE));
> +
> +	CHECK_RESULT(mfd_assert_add_seals(fd2, F_SEAL_SHRINK));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK));
> +	CHECK_RESULT(mfd_assert_has_seals(fd2, F_SEAL_WRITE | F_SEAL_SHRINK));
> +
> +	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_SEAL));
> +	CHECK_RESULT(mfd_assert_has_seals(fd,
> +		F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_SEAL));
> +	CHECK_RESULT(mfd_assert_has_seals(fd2,
> +		F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_SEAL));
> +
> +	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_GROW));
> +	CHECK_RESULT(mfd_fail_add_seals(fd2, F_SEAL_GROW));
> +	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_SEAL));
> +	CHECK_RESULT(mfd_fail_add_seals(fd2, F_SEAL_SEAL));
> +
> +	SAFE_CLOSE(fd2);
> +
> +	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_GROW));
> +
> +	tst_res(TPASS, "%s", __func__);
> +}
> +
> +/*
> + * Test sealing with active mmap()s
> + * Modifying seals is only allowed if no other mmap() refs exist.
> + */
> +static void test_share_mmap(int fd)
> +{
> +	void *p;
> +
> +	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
> +
> +	/* shared/writable ref prevents sealing WRITE, but allows others */
> +	p = SAFE_MMAP(NULL,
> +			MFD_DEF_SIZE,
> +			PROT_READ | PROT_WRITE,
> +			MAP_SHARED,
> +			fd,
> +			0);
> +	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_WRITE));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
> +	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_SHRINK));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SHRINK));
> +	SAFE_MUNMAP(p, MFD_DEF_SIZE);
> +
> +	/* readable ref allows sealing */
> +	p = SAFE_MMAP(NULL,
> +			MFD_DEF_SIZE,
> +			PROT_READ,
> +			MAP_PRIVATE,
> +			fd,
> +			0);
> +	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_WRITE));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK));
> +	SAFE_MUNMAP(p, MFD_DEF_SIZE);
> +
> +	tst_res(TPASS, "%s", __func__);
> +}
> +
> +/*
> + * Test sealing with open(/proc/self/fd/%d)
> + * Via /proc we can get access to a separate file-context for the same memfd.
> + * This is *not* like dup(), but like a real separate open(). Make sure the
> + * semantics are as expected and we correctly check for RDONLY / WRONLY / RDWR.
> + */
> +static void test_share_open(int fd)
> +{
> +	int fd2;
> +
> +	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
> +
> +	fd2 = CHECK_RESULT(mfd_assert_open(fd, O_RDWR, 0));
> +	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_WRITE));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE));
> +	CHECK_RESULT(mfd_assert_has_seals(fd2, F_SEAL_WRITE));
> +
> +	CHECK_RESULT(mfd_assert_add_seals(fd2, F_SEAL_SHRINK));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK));
> +	CHECK_RESULT(mfd_assert_has_seals(fd2, F_SEAL_WRITE | F_SEAL_SHRINK));
> +
> +	SAFE_CLOSE(fd);
> +	fd = CHECK_RESULT(mfd_assert_open(fd2, O_RDONLY, 0));
> +
> +	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_SEAL));
> +	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK));
> +	CHECK_RESULT(mfd_assert_has_seals(fd2, F_SEAL_WRITE | F_SEAL_SHRINK));
> +
> +	SAFE_CLOSE(fd2);
> +
> +	tst_res(TPASS, "%s", __func__);
> +}
> +
> +static const struct tcase {
> +	int flags;
> +	void (*func)(int fd);
> +} tcases[] = {
> +	{MFD_ALLOW_SEALING, &test_basic},
> +	{0,                 &test_no_sealing_without_flag},
> +
> +	{MFD_ALLOW_SEALING, &test_seal_write},
> +	{MFD_ALLOW_SEALING, &test_seal_shrink},
> +	{MFD_ALLOW_SEALING, &test_seal_grow},
> +	{MFD_ALLOW_SEALING, &test_seal_resize},
> +
> +	{MFD_ALLOW_SEALING, &test_share_dup},
> +	{MFD_ALLOW_SEALING, &test_share_mmap},
> +	{MFD_ALLOW_SEALING, &test_share_open},
> +};
> +
> +static void verify_memfd_create(unsigned int n)
> +{
> +	const struct tcase *tc;
> +
> +	tc = &tcases[n];
> +
> +	TEST(mfd_assert_new(TCID, MFD_DEF_SIZE, tc->flags));
> +	if (TEST_RETURN < 0)
> +		tst_brk(TBROK | TERRNO, "memfd_create() failed unexpectedly");
> +
> +	tc->func(TEST_RETURN);
> +
> +	if (TEST_RETURN > 0)
> +		SAFE_CLOSE(TEST_RETURN);
> +}
> +
> +static void setup(void)
> +{
> +	ASSERT_HAVE_MEMFD_CREATE();
> +}
> +
> +static struct tst_test test = {
> +	.tid = "memfd_create01",
> +	.test = verify_memfd_create,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +};
> diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.h b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
> new file mode 100644
> index 0000000..f07cc8c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
> @@ -0,0 +1,525 @@
> +/*
> + * Copyright (C) 2017  Red Hat, Inc.
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
> + */
> +
> +#ifndef MEMFD_TEST_COMMON
> +#define MEMFD_TEST_COMMON
> +
> +#include <sys/types.h>
> +#include <sys/syscall.h>
> +#include <sys/uio.h>
> +#include <lapi/fallocate.h>
> +#include <lapi/fcntl.h>
> +#include <lapi/memfd.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include <tst_test.h>
> +
> +#include "linux_syscall_numbers.h"
> +
> +#define MFD_DEF_SIZE 8192
> +#define STACK_SIZE 65536
> +
> +enum assert_retval {
> +	ALL_OK,
> +	MEMFD_FAIL,
> +	MEMFD_MISMATCH,
> +	FTRUNCATE_FAIL,
> +	FCNTL_FAIL,
> +	GET_SEALS_MISMATCH,
> +	ADD_SEALS_FAIL,
> +	ADD_SEALS_MISMATCH,
> +	FSTAT_FAIL,
> +	FILE_SIZE_MISMATCH,
> +	OPEN_MISMATCH,
> +	OPEN_FAIL,
> +	MPROTECT_FAIL,
> +	FALLOCATE_PUNCH_FAIL,
> +	WRITE_FAIL,
> +	WRITE_MISMATCH,
> +	MUNMAP_FAIL,
> +	MMAP_FAIL,
> +	MMAP_MISMATCH,
> +	MMAP_MPROT_MISMATCH,
> +	FALLOCATE_PUNCH_MISMATCH,
> +	FTRUNCATE_SHRINK_MISMATCH,
> +	FALLOCATE_ALLOC_FAIL,
> +	FTRUNCATE_GROW_MISMATCH,
> +	FALLOCATE_ALLOC_MISMATCH,
> +	PWRITE_FAIL,
> +	PWRITE_MISMATCH,
> +	READ_FAIL,
> +	READ_MISMATCH,
> +	CLOSE_FAIL,
> +};
> +
> +const char *err_msg[] = {
> +	"all OK",
> +	"memfd_create() failed",
> +	"memfd_create() succeeded, but failure expected",
> +	"ftruncate() failed",
> +	"fcntl() failed",
> +	"GET_SEALS() returned unexpected value",
> +	"ADD_SEALS() failed",
> +	"ADD_SEALS() didn't fail as expected",
> +	"fstat() failed",
> +	"wrong file size",
> +	"open() didn't fail as expected",
> +	"open() failed",
> +	"mprotect() failed",
> +	"fallocate(PUNCH_HOLE) failed",
> +	"write() failed",
> +	"write() didn't fail as expected",
> +	"munmap() failed",
> +	"mmap() failed",
> +	"mmap() didn't fail as expected",
> +	"mmap()+mprotect() didn't fail as expected",
> +	"fallocate(PUNCH_HOLE) didn't fail as expected",
> +	"ftruncate(SHRINK) didn't fail as expected",
> +	"fallocate(ALLOC) failed",
> +	"ftruncate(GROW) didn't fail as expected",
> +	"fallocate(ALLOC) didn't fail as expected",
> +	"pwrite() failed",
> +	"pwrite() didn't fail as expected",
> +	"read() failed",
> +	"read() didn't fail as expected",
> +	"close() failed",
> +};
> +
> +#define STRINGIFY(A) #A
> +
> +#define CHECK_RESULT(func2call) ({ \
> +	int result; \
> +	result = func2call; \
> +	if (result < ALL_OK) \
> +		tst_brk(TFAIL, "%s: %s", STRINGIFY(func2call), \
> +			err_msg[-result]); \
> +	else \
> +		tst_res(TPASS, "%s", STRINGIFY(func2call)); \
> +	result; \
> +})
> +
> +#define ASSERT_HAVE_MEMFD_CREATE() do { \
> +	int r; \
> +	r = mfd_assert_new("dummy_call", 0, 0); \
> +	if (r < 0) \
> +		tst_brk(TCONF, "memfd_create does not exist on your system."); \
> +		SAFE_CLOSE(r); \
                ^
		The indentation here is confusing.

> +	} while (0)
> +
> +static int sys_memfd_create(const char *name,
> +		unsigned int flags)
> +{
> +	return syscall(__NR_memfd_create, name, flags);
> +}
> +
> +static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
> +{
> +	int fd, r;
> +
> +	fd = sys_memfd_create(name, flags);
> +	if (fd < 0)
> +		return -MEMFD_FAIL;
> +
> +	r = ftruncate(fd, sz);
> +	if (r < 0)
> +		return -FTRUNCATE_FAIL;
> +
> +	return fd;
> +}

This indirection (returning error number and matching it agains table is
confusing as well).

I wonder if we should do this similarily to safe macros, i.e. doing
something as:

#define SAFE_MFD_NEW(name, sz, flags) \
        safe_mfd_new(__FILE__, __LINE__, name, flags);

static int safe_mfd_new(const char *filename, const char lineno,
                        const char *name, unsigned int flags)
{
	int fd;

	if (sys_memfd_create(name, flags)) {
		tst_brk(TBROK | TERRNO,
		        "%s:%i: memfd_create(%s,%u) failed",
			file, lineno, name, flags);
	}

	return fd;
}

Then we could do something as:

	int fd;

	fd = SAFE_MFD_NEW("foo", 0);
	SAFE_FTRUNCATE(fd, sz);

In the main test function, which seems to be much clearer code to me.

> +static int mfd_fail_new(const char *name, unsigned int flags)
> +{
> +	int fd;
> +
> +	fd = sys_memfd_create(name, flags);
> +	if (fd >= 0) {
> +		close(fd);
> +		return -MEMFD_MISMATCH;
> +	}
> +
> +	return fd;
> +}
> +
> +static int mfd_assert_get_seals(int fd)
> +{
> +	int r;
> +
> +	r = fcntl(fd, F_GET_SEALS);
> +	if (r < 0)
> +		return -FCNTL_FAIL;
> +
> +	return r;
> +}

This could be just replaced with SAFE_FCNTL() in the test code.

> +static int mfd_assert_has_seals(int fd, int seals)
> +{
> +	int s;
> +
> +	s = mfd_assert_get_seals(fd);
> +	if (s < 0)
> +		return s;
> +
> +	if (s != seals)
> +		return -GET_SEALS_MISMATCH;
> +
> +	return ALL_OK;
> +}

This as well, you can even just do:

	int s;

	s = SAFE_FCNTL(fd, F_GET_SEALS);

	if (seals != s) {
		tst_res(TFAIL, "Unexpected seals %i, expected %i",
		         seals, s);
	}

> +static int mfd_assert_add_seals(int fd, int seals)
> +{
> +	int r;
> +
> +	r = mfd_assert_get_seals(fd);
> +	if (r < 0)
> +		return r;
> +
> +	r = fcntl(fd, F_ADD_SEALS, seals);
> +	if (r < 0)
> +		return -ADD_SEALS_FAIL;
> +
> +	return ALL_OK;
> +}

Again this is just one SAFE_FCNTL();

> +static int mfd_fail_add_seals(int fd, int seals)
> +{
> +	int r;
> +	int s;
> +
> +	r = fcntl(fd, F_GET_SEALS);
> +	if (r < 0)
> +		s = 0;
> +	else
> +		s = r;

This does not make any sense, is the s variable used for anything at
all?

> +	r = fcntl(fd, F_ADD_SEALS, seals);
> +	if (r >= 0)
> +		return -ADD_SEALS_MISMATCH;
> +
> +	return ALL_OK;
> +}

And we can so something as:

#define FAIL_ADD_SEALS(fd, seals) \
        fail_add_seals(__FILE__, __LINE__, fd, seals)

static void fail_add_seals(const char *file, const int lineno,
                           int fd, int seals)
{
	if (fcntl(fd, F_ADD_SEALS, seals) >= 0) {
		tst_res(TFAIL,
		        "%s:%i: fcntl(%i, F_ADD_SEALS, %i) passed unexpectedly",
			file, lineno, fd, seals);
	} else {
		tst_res(TPASS, "%s:%i: fcntl(%i, F_ADD_SEALS, %i) failed",
		        file, lineno, fd, seals);
	}
}

For the negative testcases.

> +static int mfd_assert_size(int fd, size_t size)
> +{
> +	struct stat st;
> +	int r;
> +
> +	r = fstat(fd, &st);
> +	if (r < 0)
> +		return -FSTAT_FAIL;
> +	else if (st.st_size != (long)size)
> +		return -FILE_SIZE_MISMATCH;
> +
> +	return ALL_OK;
> +}

We have SAFE_FSTAT() as well. etc.

-- 
Cyril Hrubis
chrubis@suse.cz
