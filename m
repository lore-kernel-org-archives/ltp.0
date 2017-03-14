From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Mar 2017 13:38:50 +0100
Subject: [LTP] [PATCH v3 5/6] syscalls: added memfd_create dir and
 memfd_create/memfd_create01.c
In-Reply-To: <1488995056-7705-6-git-send-email-jracek@redhat.com>
References: <1488995056-7705-1-git-send-email-jracek@redhat.com>
 <1488995056-7705-6-git-send-email-jracek@redhat.com>
Message-ID: <20170314123850.GB4939@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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
> + /*
> +  *  Based on Linux/tools/testing/selftests/memfd/memfd_test.c
> +  *  by David Herrmann <dh.herrmann@gmail.com>
> +  *
> +  *  24/02/2017   Port to LTP    <jracek@redhat.com>
> +  */
> +
> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "memfd_create_common.h"
> +
> +/*
> + * Do few basic sealing tests to see whether setting/retrieving seals works.
> + */
> +static void test_basic(int fd)
> +{
> +	/* add basic seals */
> +	SAFE_MFD_HAS_SEALS(fd, 0);
> +	SAFE_MFD_ADD_SEALS(fd, F_SEAL_SHRINK | F_SEAL_WRITE);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_SHRINK | F_SEAL_WRITE);
> +
> +	/* add them again */
> +	SAFE_MFD_ADD_SEALS(fd, F_SEAL_SHRINK | F_SEAL_WRITE);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_SHRINK | F_SEAL_WRITE);
> +
> +	/* add more seals and seal against sealing */
> +	SAFE_MFD_ADD_SEALS(fd, F_SEAL_GROW | F_SEAL_SEAL);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_SHRINK | F_SEAL_GROW |
> +		F_SEAL_WRITE | F_SEAL_SEAL);
> +
> +	/* verify that sealing no longer works */
> +	SAFE_MFD_FAIL_ADD_SEALS(fd, F_SEAL_GROW);
> +	SAFE_MFD_FAIL_ADD_SEALS(fd, 0);
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
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_SEAL);
> +	SAFE_MFD_FAIL_ADD_SEALS(fd, F_SEAL_SHRINK | F_SEAL_GROW | F_SEAL_WRITE);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_SEAL);
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
> +	SAFE_MFD_HAS_SEALS(fd, 0);
> +	SAFE_MFD_ADD_SEALS(fd, F_SEAL_WRITE);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_WRITE);
> +
> +	SAFE_MFD_READ(fd);
> +	SAFE_MFD_FAIL_WRITE(fd);
> +	SAFE_MFD_SHRINK(fd);
> +	SAFE_MFD_GROW(fd);
> +	SAFE_MFD_FAIL_GROW_WRITE(fd);
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
> +	SAFE_MFD_HAS_SEALS(fd, 0);
> +	SAFE_MFD_ADD_SEALS(fd, F_SEAL_SHRINK);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_SHRINK);
> +
> +	SAFE_MFD_READ(fd);
> +	SAFE_MFD_WRITE(fd);
> +	SAFE_MFD_FAIL_SHRINK(fd);
> +	SAFE_MFD_GROW(fd);
> +	SAFE_MFD_GROW_WRITE(fd);
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
> +	SAFE_MFD_HAS_SEALS(fd, 0);
> +	SAFE_MFD_ADD_SEALS(fd, F_SEAL_GROW);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_GROW);
> +
> +	SAFE_MFD_READ(fd);
> +	SAFE_MFD_WRITE(fd);
> +	SAFE_MFD_SHRINK(fd);
> +	SAFE_MFD_FAIL_GROW(fd);
> +	SAFE_MFD_FAIL_GROW_WRITE(fd);
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
> +	SAFE_MFD_HAS_SEALS(fd, 0);
> +	SAFE_MFD_ADD_SEALS(fd, F_SEAL_SHRINK | F_SEAL_GROW);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_SHRINK | F_SEAL_GROW);
> +
> +	SAFE_MFD_READ(fd);
> +	SAFE_MFD_WRITE(fd);
> +	SAFE_MFD_FAIL_SHRINK(fd);
> +	SAFE_MFD_FAIL_GROW(fd);
> +	SAFE_MFD_FAIL_GROW_WRITE(fd);
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
> +	SAFE_MFD_HAS_SEALS(fd, 0);
> +
> +	fd2 = SAFE_DUP(fd);
> +	SAFE_MFD_HAS_SEALS(fd2, 0);
> +
> +	SAFE_MFD_ADD_SEALS(fd, F_SEAL_WRITE);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_WRITE);
> +	SAFE_MFD_HAS_SEALS(fd2, F_SEAL_WRITE);
> +
> +	SAFE_MFD_ADD_SEALS(fd2, F_SEAL_SHRINK);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_WRITE | F_SEAL_SHRINK);
> +	SAFE_MFD_HAS_SEALS(fd2, F_SEAL_WRITE | F_SEAL_SHRINK);
> +
> +	SAFE_MFD_ADD_SEALS(fd, F_SEAL_SEAL);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_SEAL);
> +	SAFE_MFD_HAS_SEALS(fd2, F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_SEAL);
> +
> +	SAFE_MFD_FAIL_ADD_SEALS(fd, F_SEAL_GROW);
> +	SAFE_MFD_FAIL_ADD_SEALS(fd2, F_SEAL_GROW);
> +	SAFE_MFD_FAIL_ADD_SEALS(fd, F_SEAL_SEAL);
> +	SAFE_MFD_FAIL_ADD_SEALS(fd2, F_SEAL_SEAL);
> +
> +	SAFE_CLOSE(fd2);
> +
> +	SAFE_MFD_FAIL_ADD_SEALS(fd, F_SEAL_GROW);
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
> +	SAFE_MFD_HAS_SEALS(fd, 0);
> +
> +	/* shared/writable ref prevents sealing WRITE, but allows others */
> +	p = SAFE_MMAP(NULL, MFD_DEF_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
> +			fd, 0);
> +
> +	SAFE_MFD_FAIL_ADD_SEALS(fd, F_SEAL_WRITE);
> +	SAFE_MFD_HAS_SEALS(fd, 0);
> +	SAFE_MFD_ADD_SEALS(fd, F_SEAL_SHRINK);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_SHRINK);
> +	SAFE_MUNMAP(p, MFD_DEF_SIZE);
> +
> +	/* readable ref allows sealing */
> +	p = SAFE_MMAP(NULL, MFD_DEF_SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
> +	SAFE_MFD_ADD_SEALS(fd, F_SEAL_WRITE);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_WRITE | F_SEAL_SHRINK);
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
> +	SAFE_MFD_HAS_SEALS(fd, 0);
> +
> +	fd2 = SAFE_MFD_OPEN(fd, O_RDWR, 0);
> +	SAFE_MFD_ADD_SEALS(fd, F_SEAL_WRITE);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_WRITE);
> +	SAFE_MFD_HAS_SEALS(fd2, F_SEAL_WRITE);
> +
> +	SAFE_MFD_ADD_SEALS(fd2, F_SEAL_SHRINK);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_WRITE | F_SEAL_SHRINK);
> +	SAFE_MFD_HAS_SEALS(fd2, F_SEAL_WRITE | F_SEAL_SHRINK);
> +
> +	SAFE_CLOSE(fd);
> +	fd = SAFE_MFD_OPEN(fd2, O_RDONLY, 0);
> +
> +	SAFE_MFD_FAIL_ADD_SEALS(fd, F_SEAL_SEAL);
> +	SAFE_MFD_HAS_SEALS(fd, F_SEAL_WRITE | F_SEAL_SHRINK);
> +	SAFE_MFD_HAS_SEALS(fd2, F_SEAL_WRITE | F_SEAL_SHRINK);
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
> +	int fd;
> +	const struct tcase *tc;
> +
> +	tc = &tcases[n];
> +
> +	fd = SAFE_MFD_NEW(TCID, MFD_DEF_SIZE, tc->flags);
> +
> +	tc->func(fd);
> +
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);

There is no way that the fd is not valid here, since the SAFE_MFD_NEW()
exits the test with tst_brk(). So we can drop the if (fd > 0) check here
and just call SAFE_CLOSE(fd);

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
> index 0000000..2c34f87
> --- /dev/null
> +++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
> @@ -0,0 +1,323 @@
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
> +static int sys_memfd_create(const char *name, unsigned int flags)
> +{
> +	return syscall(__NR_memfd_create, name, flags);

We should call tst_syscall() here, that aborts the test with TCONF if
__NR_memfd_create is not defined.

> +}
> +
> +#define SAFE_MFD_NEW(name, sz, flags) \
> +	safe_mfd_new(__FILE__, __LINE__, name, (sz), (flags))
> +
> +static int safe_mfd_new(const char *filename, const int lineno,
> +		const char *name, loff_t sz, int flags)
> +{
> +	int fd;
> +
> +	fd = sys_memfd_create(name, flags);
> +	if (fd < 0)
> +		tst_brk(TBROK | TERRNO, "sys_memfd_create(%s, %d) failed",
> +				name, flags);
> +
> +	safe_ftruncate(filename, lineno, fd, sz);
> +
> +	return fd;
> +}
> +
> +#define ASSERT_HAVE_MEMFD_CREATE() \
> +	do { \
> +		int r; \
> +		r = safe_mfd_new(__FILE__, __LINE__, "dummy_call", 0, 0); \

This is broken now, you either have to check errno in safe_mfd_new() and
tst_brk() with TCONF when the syscall is not implemented or not enabled
in kernel .config. Whitch is usually EINVAL for older kernel that does
not know this syscall and ENOSYS for new enough kernels that does not
have it enabled, but that should be checked.

Or we should just call the sys_memfd_create() here and check the errno
and decide to end the test with TBROK/TCONF accordingly.

> +		SAFE_CLOSE(r); \
> +	} while (0)
> +
> +#define SAFE_MFD_FAIL_NEW(name, flags) \
> +	do { \
> +		int fd; \
> +		fd = sys_memfd_create(name, (flags)); \
> +		if (fd >= 0) { \
> +			safe_close(__FILE__, __LINE__, NULL, fd); \
> +			tst_brk(TBROK | TERRNO, \
> +				"memfd_create(%s, %d) should have failed", \
> +				name, (flags)); \
> +		} \
> +	} while (0)
> +
> +#define SAFE_MMAP_FAIL(addr, length, prot, flags, fd, offset) \
> +	safe_mmap_fail(__FILE__, __LINE__, (addr), (length), (prot), \
> +			(flags), (fd), (offset))
> +
> +void safe_mmap_fail(const char *file, const int lineno, void *addr,
> +		size_t length, int prot, int flags, int fd, off_t offset)
> +{
> +	if (mmap(addr, length, prot,  flags, fd, offset) != MAP_FAILED)
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +				"mmap() didn't fail as expected");
> +}

What about we prefix the test assertions with check_ rather than safe_
and produce PASS/FAIL messages there. Here we can do something as:


void check_mmap_fail(...)
{
	if (mmap(addr, length, prot, flags, fd, offset) != MAP_FAILED) {
		tst_res_(TFAIL, file, lineno,
			 "mmap(%p, %zu, %i, %i, %i, %zi) passed unexpectedly",
			 addr, lenght, prot, flags, fd, offset);
		return;
	}

	tst_res_(TPASS | TERRNO, file, lineno,
		 "mmap(%p, %zu, %i, %i, %i, %zi) failed as expected",
		 addr, lenght, prot, flags, fd, offset);
}

> +#define SAFE_MFD_GET_SEALS(fd) \
> +	SAFE_FCNTL((fd), F_GET_SEALS)
> +
> +#define SAFE_MFD_HAS_SEALS(fd, seals) \
> +	do { \
> +		if (SAFE_MFD_GET_SEALS(fd) != (seals)) \
> +		tst_brk(TBROK | TERRNO, \
> +			"fcntl(%d, F_GET_SEALS) returned unexpected value", \
> +				fd); \
> +	} while (0)

This should be named CHECK_MFD_HAS_SEALS() as well and produce
PASS/FAIL.

> +#define SAFE_MFD_ADD_SEALS(fd, seals) \
> +	SAFE_FCNTL(fd, F_ADD_SEALS, (seals))
> +
> +#define SAFE_MFD_FAIL_ADD_SEALS(fd, seals) \
> +	do { \
> +		if (fcntl(fd, F_ADD_SEALS, (seals)) >= 0) \
> +		tst_brk(TBROK | TERRNO, \
> +			"fcntl(%d, F_ADD_SEALS) didn't fail as expected", \
> +					fd); \
> +	} while (0)

This should be CHECK_MFD_FAIL_ADD_SEALS() and we should produce
PASS/FAIL. And the FAIL should be most likely passed to tst_brk()
since otherwise we will continued with the test with unexpected state of
the MFD object. So something as:

...
{
	if (fcntl(fd, F_ADD_SEALS, (seals)) >= 0)
		tst_brk(TFAIL | TERRNO, ...);

	tst_res(TPASS | TERRNO,
		"fcntl(%d, F_ADD_SEALS) failed as expected",
		fd);
}

> +#define SAFE_MFD_SIZE(fd, size) \
> +	safe_mfd_size(__FILE__, __LINE__, fd, (size))
> +
> +static void safe_mfd_size(const char *filename, const int lineno,
> +		int fd, size_t size)
> +{
> +	struct stat st;
> +
> +	safe_fstat(filename, lineno, fd, &st);
> +
> +	if (st.st_size != (long)size)
> +		tst_brk(TBROK | TERRNO, "unexpected fstat() file size");
> +}
> +
> +#define SAFE_MFD_OPEN(fd, flags, mode) \
> +	safe_mfd_open(__FILE__, __LINE__, fd, (flags), (mode))
> +
> +static int safe_mfd_open(const char *filename, const int lineno, int fd,
> +		int flags, mode_t mode)
> +{
> +	char buf[512];
> +
> +	sprintf(buf, "/proc/self/fd/%d", fd);
> +
> +	return safe_open(filename, lineno, NULL, buf, flags, mode);
> +}
> +
> +#define SAFE_MFD_FAIL_OPEN(fd, flags, mode) \
> +	do { \
> +		char buf[512]; \
> +		sprintf(buf, "/proc/self/fd/%d", fd); \
> +		if (open(buf, (flags), (mode)) >= 0) \
> +		tst_brk(TBROK, "open() didn't fail as expected"); \
> +	} while (0)

This one as well.

> +#define SAFE_MFD_READ(fd) \
> +	safe_mfd_read(__FILE__, __LINE__, fd)
> +
> +static void safe_mfd_read(const char *filename, const int lineno, int fd)
> +{
> +	char buf[16];
> +	void *p;
> +
> +	safe_read(filename, lineno, NULL, 1, fd, buf, sizeof(buf));
> +
> +	/* verify PROT_READ *is* allowed */
> +	p = safe_mmap(filename, lineno, NULL, MFD_DEF_SIZE,
> +			PROT_READ, MAP_PRIVATE, fd, 0);
> +
> +	safe_munmap(filename, lineno, NULL, p, MFD_DEF_SIZE);
> +
> +	/* verify MAP_PRIVATE is *always* allowed (even writable) */
> +	p = safe_mmap(filename, lineno, NULL, MFD_DEF_SIZE,
> +			PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> +
> +	safe_munmap(filename, lineno, NULL, p, MFD_DEF_SIZE);
> +}

This one as well, this should be called something as CHECK_MFD_READABLE()
and produce three PASS/FAIL messages.

> +#define SAFE_MFD_WRITE(fd) \
> +	safe_mfd_write(__FILE__, __LINE__, fd)
> +
> +static void safe_mfd_write(const char *filename, const int lineno, int fd)
> +{
> +	void *p;
> +	int r;
> +
> +	/* verify write() succeeds */
> +	safe_write(filename, lineno, NULL, 1, fd, "\0\0\0\0", 4);
> +
> +	/* verify PROT_READ | PROT_WRITE is allowed */
> +	p = safe_mmap(filename, lineno, NULL, MFD_DEF_SIZE,
> +			PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +	*(char *)p = 0;
> +	safe_munmap(filename, lineno, NULL, p, MFD_DEF_SIZE);
> +
> +	/* verify PROT_WRITE is allowed */
> +	p = safe_mmap(filename, lineno, NULL, MFD_DEF_SIZE,
> +			PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +	*(char *)p = 0;
> +	safe_munmap(filename, lineno, NULL, p, MFD_DEF_SIZE);
> +
> +	/* verify PROT_READ with MAP_SHARED is allowed and a following
> +	 * mprotect(PROT_WRITE) allows writing
> +	 */
> +	p = safe_mmap(filename, lineno, NULL, MFD_DEF_SIZE,
> +			PROT_READ, MAP_SHARED, fd, 0);
> +
> +	r = mprotect(p, MFD_DEF_SIZE, PROT_READ | PROT_WRITE);
> +	if (r < 0)
> +		tst_brk(TBROK | TERRNO, "mprotect() failed");
> +
> +	*(char *)p = 0;
> +	safe_munmap(filename, lineno, NULL, p, MFD_DEF_SIZE);
> +
> +	/* verify PUNCH_HOLE works */
> +	r = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +			0, MFD_DEF_SIZE);
> +	if (r < 0)
> +		tst_brk(TBROK | TERRNO, "fallocate(PUNCH_HOLE) failed");
> +}

This one as well, CHECK_MFD_WRITEABLE()

> +#define SAFE_MFD_FAIL_WRITE(fd) \
> +	safe_mfd_fail_write(__FILE__, __LINE__, fd)
> +
> +static void safe_mfd_fail_write(const char *filename, const int lineno, int fd)
> +{
> +	ssize_t l;
> +	void *p;
> +	int r;
> +
> +	/* verify write() fails */
> +	l = write(fd, "data", 4);
> +	if (l != -EPERM)
> +		tst_brk(TBROK | TERRNO, "write() didn't fail as expected");
> +
> +	/* verify PROT_READ | PROT_WRITE is not allowed */
> +	safe_mmap_fail(filename, lineno, NULL, MFD_DEF_SIZE,
> +			PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +	/* verify PROT_WRITE is not allowed */
> +	safe_mmap_fail(filename, lineno, NULL, MFD_DEF_SIZE,
> +			PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +	/* Verify PROT_READ with MAP_SHARED with a following mprotect is not
> +	 * allowed. Note that for r/w the kernel already prevents the mmap.
> +	 */
> +	p = mmap(NULL, MFD_DEF_SIZE, PROT_READ,
> +			MAP_SHARED, fd, 0);
> +	if (p != MAP_FAILED) {
> +		if (mprotect(p, MFD_DEF_SIZE, PROT_READ | PROT_WRITE) >= 0)
> +			tst_brk(TBROK | TERRNO,
> +				"mmap()+mprotect() didn't fail as expected");
> +	}
> +
> +	/* verify PUNCH_HOLE fails */
> +	r = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +			0, MFD_DEF_SIZE);
> +	if (r >= 0)
> +		tst_brk(TBROK | TERRNO,
> +			"fallocate(PUNCH_HOLE) didn't fail as expected");
> +}

This one as well, CHECK_MFD_NON_WRITEABLE() or something similar.

> +#define SAFE_MFD_SHRINK(fd) \
> +	safe_mfd_shrink(__FILE__, __LINE__, fd)
> +
> +static void safe_mfd_shrink(const char *filename, const int lineno, int fd)
> +{
> +	int fd2;
> +
> +	safe_ftruncate(filename, lineno, fd, MFD_DEF_SIZE / 2);
> +	safe_mfd_size(filename, lineno, fd, MFD_DEF_SIZE / 2);
> +
> +	fd2 = safe_mfd_open(filename, lineno, fd,
> +			O_RDWR | O_CREAT | O_TRUNC, 0600);
> +	safe_close(filename, lineno, NULL, fd2);
> +
> +	safe_mfd_size(filename, lineno, fd, 0);
> +}
> +
> +#define SAFE_MFD_FAIL_SHRINK(fd) \
> +	do { \
> +		if (ftruncate(fd, MFD_DEF_SIZE / 2) >= 0) \
> +		tst_brk(TBROK | TERRNO, \
> +				"ftruncate(SHRINK) didn't fail as expected"); \
> +		SAFE_MFD_FAIL_OPEN(fd, O_RDWR | O_CREAT | O_TRUNC, 0600); \
> +	} while (0)

CHECK_MFD_SHRINKABLE() and CHECK_MFD_NON_SHRINKABLE() here.

> +#define SAFE_MFD_GROW(fd) \
> +	safe_mfd_grow(__FILE__, __LINE__, fd)
> +
> +static void safe_mfd_grow(const char *filename, const int lineno, int fd)
> +{
> +	safe_ftruncate(filename, lineno, fd, MFD_DEF_SIZE * 2);
> +	safe_mfd_size(filename, lineno, fd, MFD_DEF_SIZE * 2);
> +
> +	if (fallocate(fd, 0, 0, MFD_DEF_SIZE * 4) < 0)
> +		tst_brk(TBROK | TERRNO, "fallocate(ALLOC) failed");
> +
> +	safe_mfd_size(filename, lineno, fd, MFD_DEF_SIZE * 4);
> +}
> +
> +#define SAFE_MFD_FAIL_GROW(fd) \
> +	do { \
> +		if (ftruncate(fd, MFD_DEF_SIZE * 2) >= 0) \
> +		tst_brk(TBROK | TERRNO, \
> +				"ftruncate(GROW) didn't fail as expected"); \
> +		if (fallocate(fd, 0, 0, MFD_DEF_SIZE * 4) >= 0) \
> +		tst_brk(TBROK | TERRNO, \
> +				"ftruncate(ALLOC) didn't fail as expected"); \
> +	} while (0)

and here, GROWABLE and NON_GROWABLE.

> +#define SAFE_MFD_GROW_WRITE(fd) \
> +	do {\
> +		char buf[MFD_DEF_SIZE * 8]; \
> +		if (pwrite(fd, buf, sizeof(buf), 0) != sizeof(buf)) \
> +		tst_brk(TBROK | TERRNO, "pwrite() failed"); \
> +		safe_mfd_size(__FILE__, __LINE__, fd, MFD_DEF_SIZE * 8); \
> +	} while (0)
> +
> +#define SAFE_MFD_FAIL_GROW_WRITE(fd) \
> +	do { \
> +		char buf[MFD_DEF_SIZE * 8]; \
> +		if (pwrite(fd, buf, sizeof(buf), 0) == sizeof(buf)) \
> +		tst_brk(TBROK, "pwrite() didn't fail as expected"); \
> +	} while (0)
> +
> +#endif

Hmm, GROWABLE_BY_WRITE() and NON_GROWABLE_BY_WRITE() or something like
that.

-- 
Cyril Hrubis
chrubis@suse.cz
