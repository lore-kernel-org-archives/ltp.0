From: Jakub =?unknown-8bit?q?Ra=C4=8Dek?= <jracek@redhat.com>
Date: Tue, 28 Feb 2017 17:23:43 +0100
Subject: [LTP] [PATCH 3/3] Added port of memfd_create testsuite
In-Reply-To: <20170228155922.GC13574@rei.lan>
References: <1488283196-11397-1-git-send-email-jracek@redhat.com>
 <1488283196-11397-4-git-send-email-jracek@redhat.com>
 <20170228155922.GC13574@rei.lan>
Message-ID: <3a75b8d1-751d-308f-b0bf-bb8611db58c7@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

thank you for info. I'll fix it all up as you suggested.


On 02/28/2017 04:59 PM, Cyril Hrubis wrote:
>> +++ b/testcases/kernel/syscalls/memfd_create/Makefile
>> @@ -0,0 +1,23 @@
>> +#
>> +# Copyright (C) 2017  Red Hat, Inc.
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of version 2 of the GNU General Public
>> +# License as published by the Free Software Foundation.
> Here as well v2+
>
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> +#
>> +# Further, this software is distributed without any warranty that it
>> +# is free of the rightful claim of any third person regarding
>> +# infringement or the like.  Any license provided herein, whether
>> +# implied or otherwise, applies only to this software file.  Patent
>> +# licenses, if any, provided herein do not apply to combinations of
>> +# this program with other software, or any other product whatsoever.
>> +#
>> +
>> +top_srcdir		?= ../../../..
>> +
>> +include $(top_srcdir)/include/mk/testcases.mk
>> +
>> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/kernel/syscalls/memfd_create/fallocate.h b/testcases/kernel/syscalls/memfd_create/fallocate.h
> This file should have been moved into lapi/ (in a separate patch),
> keeping several copies of code in source tree is very bad habit.
OK. I already see a few other tests as candidates for cleanup (link 
against lapi/).
>> diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create01.c b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
>> new file mode 100644
>> index 0000000..368f07a
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
>> @@ -0,0 +1,465 @@
>> +/*
>> + * Copyright (C) 2017  Red Hat, Inc.
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of version 2 of the GNU General Public
>> + * License as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it would be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> + *
>> + * Further, this software is distributed without any warranty that it
>> + * is free of the rightful claim of any third person regarding
>> + * infringement or the like.  Any license provided herein, whether
>> + * implied or otherwise, applies only to this software file.  Patent
>> + * licenses, if any, provided herein do not apply to combinations of
>> + * this program with other software, or any other product whatsoever.
>> + */
>> +
>> + /*
>> +  *  Based on Linux/tools/testing/selftests/memfd/memfd_test.c
>> +  *  by David Herrmann <dh.herrmann@gmail.com>
>> +  *
>> +  *  24/02/2017   Port to LTP    <jracek@redhat.com>
>> +  */
>> +
>> + #ifndef _GNU_SOURCE
>> + #define _GNU_SOURCE
>> + #endif
> We can drop the ifndef here.
>
>> +#include <sys/wait.h>
>> +#include <signal.h>
>> +#include <sched.h>
>> +
>> +#include "tst_test.h"
>> +#include "memfd_create_common.h"
>> +
>> +static int idle_thread_fn(void *arg)
>> +{
>> +	sigset_t set;
>> +	int sig;
>> +
>> +	/* dummy waiter; SIGTERM terminates us anyway */
>> +	sigemptyset(&set);
>> +	sigaddset(&set, SIGTERM);
>> +	sigwait(&set, &sig);
>> +
>> +	return 0;
>> +}
>> +
>> +static pid_t spawn_idle_thread(unsigned int flags)
>> +{
>> +	uint8_t *stack;
>> +	pid_t pid;
>> +
>> +	stack = SAFE_MALLOC(STACK_SIZE);
>> +
>> +	pid = ltp_clone(SIGCHLD | flags,
>> +			idle_thread_fn,
>> +			NULL,
>> +			STACK_SIZE,
>> +			stack);
>> +
>> +	if (pid < 0)
>> +		tst_brk(TBROK | TERRNO, "clone() failed");
>> +
>> +	return pid;
>> +}
>> +
>> +static void join_idle_thread(pid_t pid)
>> +{
>> +	kill(pid, SIGTERM);
>> +	waitpid(pid, NULL, 0);
>> +}
> Why do we use bare clone() here instead of linking the test with
> pthreads?
The idea was to keep test as close to original as possible for easy 
maintenance.
>> +/*
>> + * Test memfd_create() syscall
>> + * Verify syscall-argument validation, including name checks, flag validation
>> + * and more.
>> + */
>> +static void test_create(void)
>> +{
>> +	char buf[2048];
>> +	int fd;
>> +
>> +	/* test NULL name */
>> +	mfd_fail_new(NULL, 0);
>> +
>> +	/* test over-long name (not zero-terminated) */
>> +	memset(buf, 0xff, sizeof(buf));
>> +	mfd_fail_new(buf, 0);
>> +
>> +	/* test over-long zero-terminated name */
>> +	memset(buf, 0xff, sizeof(buf));
>> +	buf[sizeof(buf) - 1] = 0;
>> +	mfd_fail_new(buf, 0);
>> +
>> +	/* verify "" is a valid name */
>> +	fd = mfd_assert_new("", 0, 0);
>> +	SAFE_CLOSE(fd);
>> +
>> +	/* verify invalid O_* open flags */
>> +	mfd_fail_new("", 0x0100);
>> +	mfd_fail_new("", ~MFD_CLOEXEC);
>> +	mfd_fail_new("", ~MFD_ALLOW_SEALING);
>> +	mfd_fail_new("", ~0);
>> +	mfd_fail_new("", 0x80000000U);
>> +
>> +	/* verify MFD_CLOEXEC is allowed */
>> +	fd = mfd_assert_new("", 0, MFD_CLOEXEC);
>> +	SAFE_CLOSE(fd);
>> +
>> +	/* verify MFD_ALLOW_SEALING is allowed */
>> +	fd = mfd_assert_new("", 0, MFD_ALLOW_SEALING);
>> +	SAFE_CLOSE(fd);
>> +
>> +	/* verify MFD_ALLOW_SEALING | MFD_CLOEXEC is allowed */
>> +	fd = mfd_assert_new("", 0, MFD_ALLOW_SEALING | MFD_CLOEXEC);
>> +	SAFE_CLOSE(fd);
>> +}
> This pretty much goes against a few policies we have in LTP. The problem
> is that the mfd_assert_new() and mfd_fail_new() functions obscure the
> file and line of the source code that is printed along with test
> failures.
>
> The usuall way how to deal with these in LTP is to create an array of
> structures that describes the parameters passed to the call which is
> then use in a loop fed to a function that does the test.
>
> Also, we tend not to test everything in a one test file, since that
> obscures coverage. Ideally the tests_create() fucntion would be
> one testcase, the test_basic() second one, etc.
>
Mostly the same reason. I understand that LTP policies take precedence. 
I'll fix/split that as well.
>> +/*
>> + * Test basic sealing
>> + * A very basic sealing test to see whether setting/retrieving seals works.
>> + */
>> +static void test_basic(void)
>> +{
>> +	int fd;
>> +
>> +	fd = mfd_assert_new("kern_memfd_basic",
>> +			MFD_DEF_SIZE,
>> +			MFD_CLOEXEC | MFD_ALLOW_SEALING);
>> +
>> +	/* add basic seals */
>> +	mfd_assert_has_seals(fd, 0);
>> +	mfd_assert_add_seals(fd, F_SEAL_SHRINK |
>> +			F_SEAL_WRITE);
>> +	mfd_assert_has_seals(fd, F_SEAL_SHRINK |
>> +			F_SEAL_WRITE);
>> +
>> +	/* add them again */
>> +	mfd_assert_add_seals(fd, F_SEAL_SHRINK |
>> +			F_SEAL_WRITE);
>> +	mfd_assert_has_seals(fd, F_SEAL_SHRINK |
>> +			F_SEAL_WRITE);
>> +
>> +	/* add more seals and seal against sealing */
>> +	mfd_assert_add_seals(fd, F_SEAL_GROW | F_SEAL_SEAL);
>> +	mfd_assert_has_seals(fd, F_SEAL_SHRINK |
>> +			F_SEAL_GROW |
>> +			F_SEAL_WRITE |
>> +			F_SEAL_SEAL);
>> +
>> +	/* verify that sealing no longer works */
>> +	mfd_fail_add_seals(fd, F_SEAL_GROW);
>> +	mfd_fail_add_seals(fd, 0);
>> +
>> +	SAFE_CLOSE(fd);
>> +
>> +	/* verify sealing does not work without MFD_ALLOW_SEALING */
>> +	fd = mfd_assert_new("kern_memfd_basic",
>> +			MFD_DEF_SIZE,
>> +			MFD_CLOEXEC);
>> +	mfd_assert_has_seals(fd, F_SEAL_SEAL);
>> +	mfd_fail_add_seals(fd, F_SEAL_SHRINK |
>> +			F_SEAL_GROW |
>> +			F_SEAL_WRITE);
>> +	mfd_assert_has_seals(fd, F_SEAL_SEAL);
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +/*
>> + * Test SEAL_WRITE
>> + * Test whether SEAL_WRITE actually prevents modifications.
>> + */
>> +static void test_seal_write(void)
>> +{
>> +	int fd;
>> +
>> +	fd = mfd_assert_new("kern_memfd_seal_write",
>> +			MFD_DEF_SIZE,
>> +			MFD_CLOEXEC | MFD_ALLOW_SEALING);
>> +	mfd_assert_has_seals(fd, 0);
>> +	mfd_assert_add_seals(fd, F_SEAL_WRITE);
>> +	mfd_assert_has_seals(fd, F_SEAL_WRITE);
>> +
>> +	mfd_assert_read(fd);
>> +	mfd_fail_write(fd);
>> +	mfd_assert_shrink(fd);
>> +	mfd_assert_grow(fd);
>> +	mfd_fail_grow_write(fd);
>> +
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +/*
>> + * Test SEAL_SHRINK
>> + * Test whether SEAL_SHRINK actually prevents shrinking
>> + */
>> +static void test_seal_shrink(void)
>> +{
>> +	int fd;
>> +
>> +	fd = mfd_assert_new("kern_memfd_seal_shrink",
>> +			MFD_DEF_SIZE,
>> +			MFD_CLOEXEC | MFD_ALLOW_SEALING);
>> +	mfd_assert_has_seals(fd, 0);
>> +	mfd_assert_add_seals(fd, F_SEAL_SHRINK);
>> +	mfd_assert_has_seals(fd, F_SEAL_SHRINK);
>> +
>> +	mfd_assert_read(fd);
>> +	mfd_assert_write(fd);
>> +	mfd_fail_shrink(fd);
>> +	mfd_assert_grow(fd);
>> +	mfd_assert_grow_write(fd);
>> +
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +/*
>> + * Test SEAL_GROW
>> + * Test whether SEAL_GROW actually prevents growing
>> + */
>> +static void test_seal_grow(void)
>> +{
>> +	int fd;
>> +
>> +	fd = mfd_assert_new("kern_memfd_seal_grow",
>> +			MFD_DEF_SIZE,
>> +			MFD_CLOEXEC | MFD_ALLOW_SEALING);
>> +	mfd_assert_has_seals(fd, 0);
>> +	mfd_assert_add_seals(fd, F_SEAL_GROW);
>> +	mfd_assert_has_seals(fd, F_SEAL_GROW);
>> +
>> +	mfd_assert_read(fd);
>> +	mfd_assert_write(fd);
>> +	mfd_assert_shrink(fd);
>> +	mfd_fail_grow(fd);
>> +	mfd_fail_grow_write(fd);
>> +
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +/*
>> + * Test SEAL_SHRINK | SEAL_GROW
>> + * Test whether SEAL_SHRINK | SEAL_GROW actually prevents resizing
>> + */
>> +static void test_seal_resize(void)
>> +{
>> +	int fd;
>> +
>> +	fd = mfd_assert_new("kern_memfd_seal_resize",
>> +			MFD_DEF_SIZE,
>> +			MFD_CLOEXEC | MFD_ALLOW_SEALING);
>> +	mfd_assert_has_seals(fd, 0);
>> +	mfd_assert_add_seals(fd, F_SEAL_SHRINK | F_SEAL_GROW);
>> +	mfd_assert_has_seals(fd, F_SEAL_SHRINK | F_SEAL_GROW);
>> +
>> +	mfd_assert_read(fd);
>> +	mfd_assert_write(fd);
>> +	mfd_fail_shrink(fd);
>> +	mfd_fail_grow(fd);
>> +	mfd_fail_grow_write(fd);
>> +
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +/*
>> + * Test sharing via dup()
>> + * Test that seals are shared between dupped FDs and they're all equal.
>> + */
>> +static void test_share_dup(void)
>> +{
>> +	int fd, fd2;
>> +
>> +	fd = mfd_assert_new("kern_memfd_share_dup",
>> +			MFD_DEF_SIZE,
>> +			MFD_CLOEXEC | MFD_ALLOW_SEALING);
>> +	mfd_assert_has_seals(fd, 0);
>> +
>> +	fd2 = mfd_assert_dup(fd);
>> +	mfd_assert_has_seals(fd2, 0);
>> +
>> +	mfd_assert_add_seals(fd, F_SEAL_WRITE);
>> +	mfd_assert_has_seals(fd, F_SEAL_WRITE);
>> +	mfd_assert_has_seals(fd2, F_SEAL_WRITE);
>> +
>> +	mfd_assert_add_seals(fd2, F_SEAL_SHRINK);
>> +	mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK);
>> +	mfd_assert_has_seals(fd2, F_SEAL_WRITE | F_SEAL_SHRINK);
>> +
>> +	mfd_assert_add_seals(fd, F_SEAL_SEAL);
>> +	mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_SEAL);
>> +	mfd_assert_has_seals(fd2, F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_SEAL);
>> +
>> +	mfd_fail_add_seals(fd, F_SEAL_GROW);
>> +	mfd_fail_add_seals(fd2, F_SEAL_GROW);
>> +	mfd_fail_add_seals(fd, F_SEAL_SEAL);
>> +	mfd_fail_add_seals(fd2, F_SEAL_SEAL);
>> +
>> +	SAFE_CLOSE(fd2);
>> +
>> +	mfd_fail_add_seals(fd, F_SEAL_GROW);
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +/*
>> + * Test sealing with active mmap()s
>> + * Modifying seals is only allowed if no other mmap() refs exist.
>> + */
>> +static void test_share_mmap(void)
>> +{
>> +	int fd;
>> +	void *p;
>> +
>> +	fd = mfd_assert_new("kern_memfd_share_mmap",
>> +			MFD_DEF_SIZE,
>> +			MFD_CLOEXEC | MFD_ALLOW_SEALING);
>> +	mfd_assert_has_seals(fd, 0);
>> +
>> +	/* shared/writable ref prevents sealing WRITE, but allows others */
>> +	p = mfd_assert_mmap_shared(fd);
>> +	mfd_fail_add_seals(fd, F_SEAL_WRITE);
>> +	mfd_assert_has_seals(fd, 0);
>> +	mfd_assert_add_seals(fd, F_SEAL_SHRINK);
>> +	mfd_assert_has_seals(fd, F_SEAL_SHRINK);
>> +	munmap(p, MFD_DEF_SIZE);
>> +
>> +	/* readable ref allows sealing */
>> +	p = mfd_assert_mmap_private(fd);
>> +	mfd_assert_add_seals(fd, F_SEAL_WRITE);
>> +	mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK);
>> +	munmap(p, MFD_DEF_SIZE);
>> +
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +/*
>> + * Test sealing with open(/proc/self/fd/%d)
>> + * Via /proc we can get access to a separate file-context for the same memfd.
>> + * This is *not* like dup(), but like a real separate open(). Make sure the
>> + * semantics are as expected and we correctly check for RDONLY / WRONLY / RDWR.
>> + */
>> +static void test_share_open(void)
>> +{
>> +	int fd, fd2;
>> +
>> +	fd = mfd_assert_new("kern_memfd_share_open",
>> +			getpagesize(),
>> +			MFD_CLOEXEC | MFD_ALLOW_SEALING);
>> +	mfd_assert_has_seals(fd, 0);
>> +
>> +	fd2 = mfd_assert_open(fd, O_RDWR, 0);
>> +	mfd_assert_add_seals(fd, F_SEAL_WRITE);
>> +	mfd_assert_has_seals(fd, F_SEAL_WRITE);
>> +	mfd_assert_has_seals(fd2, F_SEAL_WRITE);
>> +
>> +	mfd_assert_add_seals(fd2, F_SEAL_SHRINK);
>> +	mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK);
>> +	mfd_assert_has_seals(fd2, F_SEAL_WRITE | F_SEAL_SHRINK);
>> +
>> +	SAFE_CLOSE(fd);
>> +	fd = mfd_assert_open(fd2, O_RDONLY, 0);
>> +
>> +	mfd_fail_add_seals(fd, F_SEAL_SEAL);
>> +	mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK);
>> +	mfd_assert_has_seals(fd2, F_SEAL_WRITE | F_SEAL_SHRINK);
>> +
>> +	SAFE_CLOSE(fd2);
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +/*
>> + * Test sharing via fork()
>> + * Test whether seal-modifications work as expected with forked childs.
>> + */
>> +static void test_share_fork(void)
>> +{
>> +	int fd;
>> +	pid_t pid;
>> +
>> +	fd = mfd_assert_new("kern_memfd_share_fork",
>> +			MFD_DEF_SIZE,
>> +			MFD_CLOEXEC | MFD_ALLOW_SEALING);
>> +	mfd_assert_has_seals(fd, 0);
>> +
>> +	pid = spawn_idle_thread(0);
>> +
>> +	mfd_assert_add_seals(fd, F_SEAL_SEAL);
>> +	mfd_assert_has_seals(fd, F_SEAL_SEAL);
>> +
>> +	mfd_fail_add_seals(fd, F_SEAL_WRITE);
>> +	mfd_assert_has_seals(fd, F_SEAL_SEAL);
>> +
>> +	join_idle_thread(pid);
>> +
>> +	mfd_fail_add_seals(fd, F_SEAL_WRITE);
>> +	mfd_assert_has_seals(fd, F_SEAL_SEAL);
>> +
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +
>> +static void cleanup(void)
>> +{
>> +}
> Eh, do not declare empty cleanup, you don't have to set it in the test
> structure if there is none.
>
>> +static void setup(void)
>> +{
>> +	TEST(sys_memfd_create("dummy_call", 0));
>> +	if (TEST_RETURN < 0)
>> +		tst_brk(TCONF, "memfd_create does not exist on your system.");
> No need to use the TEST() macro if you are no interested in storing
> errno value as well. Just do plain and old:
>
> 	int ret = sys_memfd_create("dummy_call", 0);
> 	if (ret < 0)
> 		...
>
>
>> +	SAFE_CLOSE(TEST_RETURN);
>> +}
>> +
>> +static void verify_memfd_create(void)
>> +{
>> +	pid_t pid;
>> +
>> +	tst_res(TINFO, "memfd: CREATE");
>> +	test_create();
>> +	tst_res(TINFO, "memfd: BASIC");
>> +	test_basic();
>> +
>> +	tst_res(TINFO, "memfd: SEAL-WRITE");
>> +	test_seal_write();
>> +	tst_res(TINFO, "memfd: SEAL-SHRINK");
>> +	test_seal_shrink();
>> +	tst_res(TINFO, "memfd: SEAL-GROW");
>> +	test_seal_grow();
>> +	tst_res(TINFO, "memfd: SEAL-RESIZE");
>> +	test_seal_resize();
>> +
>> +	tst_res(TINFO, "memfd: SHARE-DUP");
>> +	test_share_dup();
>> +	tst_res(TINFO, "memfd: SHARE-MMAP");
>> +	test_share_mmap();
>> +	tst_res(TINFO, "memfd: SHARE-OPEN");
>> +	test_share_open();
>> +	tst_res(TINFO, "memfd: SHARE-FORK");
>> +	test_share_fork();
>> +
>> +	/* Run test-suite in a multi-threaded environment with a shared
>> +	 * file-table.
>> +	 */
>> +	pid = spawn_idle_thread(CLONE_FILES | CLONE_FS | CLONE_VM);
>> +	tst_res(TINFO, "memfd: SHARE-DUP (shared file-table)");
>> +	test_share_dup();
>> +	tst_res(TINFO, "memfd: SHARE-MMAP (shared file-table)");
>> +	test_share_mmap();
>> +	tst_res(TINFO, "memfd: SHARE-OPEN (shared file-table)");
>> +	test_share_open();
>> +	tst_res(TINFO, "memfd: SHARE-FORK (shared file-table)");
>> +	test_share_fork();
>> +	join_idle_thread(pid);
> As I said, this should be split into at least five tests.
>
>> +	tst_res(TPASS, "memfd: DONE");
> And printing one PASS per this number of this testcases is also frowned
> upon. Ideally each assertion should generate PASS or FAIL.
>
>> +}
>> +
>> +static struct tst_test test = {
>> +	.tid = "memfd_create01",
>> +	.test_all = verify_memfd_create,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +};
>> diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.h b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
>> new file mode 100644
>> index 0000000..18c55e7
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
>> @@ -0,0 +1,424 @@
>> +/*
>> + * Copyright (C) 2017  Red Hat, Inc.
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of version 2 of the GNU General Public
>> + * License as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it would be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> + *
>> + * Further, this software is distributed without any warranty that it
>> + * is free of the rightful claim of any third person regarding
>> + * infringement or the like.  Any license provided herein, whether
>> + * implied or otherwise, applies only to this software file.  Patent
>> + * licenses, if any, provided herein do not apply to combinations of
>> + * this program with other software, or any other product whatsoever.
>> + */
>> +
>> +#ifndef MEMFD_TEST_COMMON2
>> +#define MEMFD_TEST_COMMON2
>> +
>> +#include <sys/types.h>
>> +#include <sys/syscall.h>
>> +#include <sys/uio.h>
>> +#include <lapi/fcntl.h>
>> +#include <lapi/memfd_create.h>
>> +#include <errno.h>
>> +#include <string.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +
>> +#define TST_NO_DEFAULT_MAIN
>> +#include <tst_test.h>
>> +
>> +#include "fallocate.h"
>> +#include "linux_syscall_numbers.h"
>> +
>> +#define MFD_DEF_SIZE 8192
>> +#define STACK_SIZE 65536
>> +
>> +static int sys_memfd_create(const char *name,
>> +		unsigned int flags)
>> +{
>> +	return syscall(__NR_memfd_create, name, flags);
>> +}
>> +
>> +static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
>> +{
>> +	int fd;
>> +
>> +	fd = sys_memfd_create(name, flags);
>> +	if (fd < 0) {
>> +		tst_brk(TFAIL | TERRNO, "memfd_create(\"%s\", %u) failed",
>> +				name, flags);
>> +	}
>> +
>> +	SAFE_FTRUNCATE(fd, sz);
>> +
>> +	return fd;
>> +}
>> +
>> +static void mfd_fail_new(const char *name, unsigned int flags)
>> +{
>> +	int r;
>> +
>> +	r = sys_memfd_create(name, flags);
>> +	if (r >= 0) {
>> +		tst_brk(TFAIL | TERRNO,
>> +			"memfd_create(\"%s\", %u) succeeded, but failure expected",
>> +			name, flags);
>> +		SAFE_CLOSE(TEST_RETURN);
>> +	}
>> +}
>> +
>> +static unsigned int mfd_assert_get_seals(int fd)
>> +{
>> +	int r;
>> +
>> +	r = SAFE_FCNTL(fd, F_GET_SEALS);
>> +
>> +	return (unsigned int)r;
>> +}
>> +
>> +static void mfd_assert_has_seals(int fd, unsigned int seals)
>> +{
>> +	unsigned int s;
>> +
>> +	s = mfd_assert_get_seals(fd);
>> +	if (s != seals)
>> +		tst_brk(TBROK | TERRNO,
>> +			"%u != %u = GET_SEALS(%d)", seals, s, fd);
>> +}
>> +
>> +static void mfd_assert_add_seals(int fd, unsigned int seals)
>> +{
>> +	mfd_assert_get_seals(fd);
>> +	SAFE_FCNTL(fd, F_ADD_SEALS, seals);
>> +}
>> +
>> +static void mfd_fail_add_seals(int fd, unsigned int seals)
>> +{
>> +	int r;
>> +	unsigned int s;
>> +
>> +	r = fcntl(fd, F_GET_SEALS);
>> +	if (r < 0)
>> +		s = 0;
>> +	else
>> +		s = (unsigned int)r;
>> +
>> +	r = fcntl(fd, F_ADD_SEALS, seals);
>> +	if (r >= 0)
>> +		tst_brk(TBROK | TERRNO,
>> +				"ADD_SEALS(%d, %u -> %u) didn't fail as expected",
>> +				fd, s, seals);
>> +}
>> +
>> +static void mfd_assert_size(int fd, size_t size)
>> +{
>> +	struct stat st;
>> +	int r;
>> +
>> +	r = fstat(fd, &st);
>> +	if (r < 0)
>> +		tst_brk(TBROK | TERRNO, "fstat(%d) failed", fd);
>> +	else if (st.st_size != (long)size)
>> +		tst_brk(TBROK | TERRNO,
>> +			"wrong file size %lld, but expected %lld",
>> +			(long long)st.st_size, (long long)size);
>> +}
>> +
>> +static int mfd_assert_dup(int fd)
>> +{
>> +	int r;
>> +
>> +	r = SAFE_DUP(fd);
>> +
>> +	return r;
>> +}
>> +
>> +static void *mfd_assert_mmap_shared(int fd)
>> +{
>> +	void *p;
>> +
>> +	p = SAFE_MMAP(NULL,
>> +			MFD_DEF_SIZE,
>> +			PROT_READ | PROT_WRITE,
>> +			MAP_SHARED,
>> +			fd,
>> +			0);
>> +
>> +	return p;
>> +}
>> +
>> +static void *mfd_assert_mmap_private(int fd)
>> +{
>> +	void *p;
>> +
>> +	p = SAFE_MMAP(NULL,
>> +			MFD_DEF_SIZE,
>> +			PROT_READ,
>> +			MAP_PRIVATE,
>> +			fd,
>> +			0);
>> +
>> +	return p;
>> +}
>> +
>> +static int mfd_assert_open(int fd, int flags, mode_t mode)
>> +{
>> +	char buf[512];
>> +	int r;
>> +
>> +	sprintf(buf, "/proc/self/fd/%d", fd);
>> +
>> +	r = SAFE_OPEN(buf, flags, mode);
>> +
>> +	return r;
>> +}
>> +
>> +static void mfd_fail_open(int fd, int flags, mode_t mode)
>> +{
>> +	char buf[512];
>> +	int r;
>> +
>> +	sprintf(buf, "/proc/self/fd/%d", fd);
>> +	r = open(buf, flags, mode);
>> +	if (r >= 0)
>> +		tst_brk(TBROK | TERRNO,
>> +			"open(%s) didn't fail as expected", buf);
>> +}
>> +
>> +static void mfd_assert_read(int fd)
>> +{
>> +	char buf[16];
>> +	void *p;
>> +
>> +	SAFE_READ(1, fd, buf, sizeof(buf));
>> +
>> +	/* verify PROT_READ *is* allowed */
>> +	p = SAFE_MMAP(NULL,
>> +			MFD_DEF_SIZE,
>> +			PROT_READ,
>> +			MAP_PRIVATE,
>> +			fd,
>> +			0);
>> +
>> +	SAFE_MUNMAP(p, MFD_DEF_SIZE);
>> +
>> +	/* verify MAP_PRIVATE is *always* allowed (even writable) */
>> +	p = SAFE_MMAP(NULL,
>> +			MFD_DEF_SIZE,
>> +			PROT_READ | PROT_WRITE,
>> +			MAP_PRIVATE,
>> +			fd,
>> +			0);
>> +
>> +	SAFE_MUNMAP(p, MFD_DEF_SIZE);
>> +}
>> +
>> +static void mfd_assert_write(int fd)
>> +{
>> +	void *p;
>> +	int r;
>> +
>> +	/* verify write() succeeds */
>> +	SAFE_WRITE(1, fd, "\0\0\0\0", 4);
>> +
>> +	/* verify PROT_READ | PROT_WRITE is allowed */
>> +	p = SAFE_MMAP(NULL,
>> +			MFD_DEF_SIZE,
>> +			PROT_READ | PROT_WRITE,
>> +			MAP_SHARED,
>> +			fd,
>> +			0);
>> +
>> +	*(char *)p = 0;
>> +	SAFE_MUNMAP(p, MFD_DEF_SIZE);
>> +
>> +	/* verify PROT_WRITE is allowed */
>> +	p = SAFE_MMAP(NULL,
>> +			MFD_DEF_SIZE,
>> +			PROT_WRITE,
>> +			MAP_SHARED,
>> +			fd,
>> +			0);
>> +
>> +	*(char *)p = 0;
>> +	SAFE_MUNMAP(p, MFD_DEF_SIZE);
>> +
>> +	/* verify PROT_READ with MAP_SHARED is allowed and a following
>> +	 * mprotect(PROT_WRITE) allows writing
>> +	 */
>> +	p = SAFE_MMAP(NULL,
>> +			MFD_DEF_SIZE,
>> +			PROT_READ,
>> +			MAP_SHARED,
>> +			fd,
>> +			0);
>> +
>> +	r = mprotect(p, MFD_DEF_SIZE, PROT_READ | PROT_WRITE);
>> +	if (r < 0)
>> +		tst_brk(TBROK | TERRNO, "mprotect() failed");
>> +
>> +	*(char *)p = 0;
>> +	SAFE_MUNMAP(p, MFD_DEF_SIZE);
>> +
>> +	/* verify PUNCH_HOLE works */
>> +	r = fallocate(fd,
>> +			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>> +			0,
>> +			MFD_DEF_SIZE);
>> +	if (r < 0)
>> +		tst_brk(TBROK | TERRNO, "fallocate(PUNCH_HOLE) failed");
>> +}
>> +
>> +static void mfd_fail_write(int fd)
>> +{
>> +	ssize_t l;
>> +	void *p;
>> +	int r;
>> +
>> +	/* verify write() fails */
>> +	l = write(fd, "data", 4);
>> +	if (l != -EPERM)
>> +		tst_brk(TBROK | TERRNO,
>> +			"expected EPERM on write(), but got %d", (int)l);
>> +
>> +	/* verify PROT_READ | PROT_WRITE is not allowed */
>> +	p = mmap(NULL,
>> +			MFD_DEF_SIZE,
>> +			PROT_READ | PROT_WRITE,
>> +			MAP_SHARED,
>> +			fd,
>> +			0);
>> +	if (p != MAP_FAILED)
>> +		tst_brk(TBROK | TERRNO, "mmap() didn't fail as expected");
>> +
>> +	/* verify PROT_WRITE is not allowed */
>> +	p = mmap(NULL,
>> +			MFD_DEF_SIZE,
>> +			PROT_WRITE,
>> +			MAP_SHARED,
>> +			fd,
>> +			0);
>> +	if (p != MAP_FAILED)
>> +		tst_brk(TBROK | TERRNO, "mmap() didn't fail as expected");
>> +
>> +	/* Verify PROT_READ with MAP_SHARED with a following mprotect is not
>> +	 * allowed. Note that for r/w the kernel already prevents the mmap.
>> +	 */
>> +	p = mmap(NULL,
>> +			MFD_DEF_SIZE,
>> +			PROT_READ,
>> +			MAP_SHARED,
>> +			fd,
>> +			0);
>> +	if (p != MAP_FAILED) {
>> +		r = mprotect(p, MFD_DEF_SIZE, PROT_READ | PROT_WRITE);
>> +		if (r >= 0)
>> +			tst_brk(TBROK | TERRNO,
>> +				"mmap()+mprotect() didn't fail as expected");
>> +	}
>> +
>> +	/* verify PUNCH_HOLE fails */
>> +	r = fallocate(fd,
>> +			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>> +			0,
>> +			MFD_DEF_SIZE);
>> +	if (r >= 0)
>> +		tst_brk(TBROK | TERRNO,
>> +			"fallocate(PUNCH_HOLE) didn't fail as expected");
>> +}
>> +
>> +static void mfd_assert_shrink(int fd)
>> +{
>> +	int fd2;
>> +
>> +	SAFE_FTRUNCATE(fd, MFD_DEF_SIZE / 2);
>> +
>> +	mfd_assert_size(fd, MFD_DEF_SIZE / 2);
>> +
>> +	fd2 = mfd_assert_open(fd,
>> +			O_RDWR | O_CREAT | O_TRUNC,
>> +			0600);
>> +	SAFE_CLOSE(fd2);
>> +
>> +	mfd_assert_size(fd, 0);
>> +}
>> +
>> +static void mfd_fail_shrink(int fd)
>> +{
>> +	int r;
>> +
>> +	r = ftruncate(fd, MFD_DEF_SIZE / 2);
>> +	if (r >= 0)
>> +		tst_brk(TBROK | TERRNO,
>> +			"ftruncate(SHRINK) didn't fail as expected");
>> +
>> +	mfd_fail_open(fd,
>> +			O_RDWR | O_CREAT | O_TRUNC,
>> +			0600);
>> +}
>> +
>> +static void mfd_assert_grow(int fd)
>> +{
>> +	int r;
>> +
>> +	SAFE_FTRUNCATE(fd, MFD_DEF_SIZE * 2);
>> +
>> +	mfd_assert_size(fd, MFD_DEF_SIZE * 2);
>> +
>> +	r = fallocate(fd,
>> +			0,
>> +			0,
>> +			MFD_DEF_SIZE * 4);
>> +	if (r < 0)
>> +		tst_brk(TBROK | TERRNO, "fallocate(ALLOC) failed");
>> +
>> +	mfd_assert_size(fd, MFD_DEF_SIZE * 4);
>> +}
>> +
>> +static void mfd_fail_grow(int fd)
>> +{
>> +	int r;
>> +
>> +	r = ftruncate(fd, MFD_DEF_SIZE * 2);
>> +	if (r >= 0)
>> +		tst_brk(TBROK | TERRNO,
>> +			"ftruncate(GROW) didn't fail as expected");
>> +
>> +	r = fallocate(fd,
>> +			0,
>> +			0,
>> +			MFD_DEF_SIZE * 4);
>> +	if (r >= 0)
>> +		tst_brk(TBROK | TERRNO,
>> +			"fallocate(ALLOC) didn't fail as expected");
>> +}
>> +
>> +static void mfd_assert_grow_write(int fd)
>> +{
>> +	static char buf[MFD_DEF_SIZE * 8];
>> +	ssize_t l;
>> +
>> +	l = pwrite(fd, buf, sizeof(buf), 0);
>> +	if (l != sizeof(buf))
>> +		tst_brk(TBROK | TERRNO, "pwrite() failed");
>> +
>> +	mfd_assert_size(fd, MFD_DEF_SIZE * 8);
>> +}
>> +
>> +static void mfd_fail_grow_write(int fd)
>> +{
>> +	static char buf[MFD_DEF_SIZE * 8];
>> +	ssize_t l;
>> +
>> +	l = pwrite(fd, buf, sizeof(buf), 0);
>> +	if (l == sizeof(buf))
>> +		tst_brk(TBROK | TERRNO, "pwrite() didn't fail as expected");
>> +}
>> +
>> +#endif
>> -- 
>> 1.8.3.1
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
