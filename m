Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D62C4332F
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 13:28:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 375F23CCE9C
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 14:28:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E11AE3CCE37
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 14:28:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 334A8613333
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 14:28:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5637C1FA57;
 Fri, 18 Nov 2022 13:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668778110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmGaGy7KxOpGsf1teuuLCi8tXNk3WCfQtinl44fRLtQ=;
 b=T2goBAazV/nHomPiL25DNJrRAUN1c5dwL+kDqmxO86NU6k6w31nBf0Zk9VnUAG061a6dfC
 /Ky7MWHbALq2DTa0oQlWe2VJuGtFQduRPORriX6XKYA6yfJdi8zrK0P+Z8mmT/sY02MFj5
 o6+MQLsxAVpJBd2NdcDeNcIRAEusu4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668778110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmGaGy7KxOpGsf1teuuLCi8tXNk3WCfQtinl44fRLtQ=;
 b=V6K5kNdITllqLDV0d87jQYb8MO3f30NnGxMeAvDRXgrjib5bMIZ0na1G8+RcyFeJonV2Ve
 6sRpK5C2jZXupVDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BD9D13A66;
 Fri, 18 Nov 2022 13:28:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BndUDX6Id2O3KAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 18 Nov 2022 13:28:30 +0000
Date: Fri, 18 Nov 2022 14:29:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: David Hildenbrand <david@redhat.com>
Message-ID: <Y3eI0Q5BTE12+4zO@yuki>
References: <20221117121409.179210-1-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221117121409.179210-1-david@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] security/dirtyc0w_shmem: Add new test for
 CVE-2022-2590
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/runtest/cve b/runtest/cve
> index 9ab6dc282..fd0305aa3 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -73,5 +73,6 @@ cve-2021-22555 setsockopt08 -i 100
>  cve-2021-26708 vsock01
>  cve-2021-22600 setsockopt09
>  cve-2022-0847 dirtypipe
> +cve-2022-2590 dirtyc0w_shmem
>  # Tests below may cause kernel memory leak
>  cve-2020-25704 perf_event_open03
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3dc6fa397..ae37a1192 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1036,6 +1036,7 @@ process_vm_writev02 process_vm_writev02
>  
>  prot_hsymlinks prot_hsymlinks
>  dirtyc0w dirtyc0w
> +dirtyc0w_shmem dirtyc0w_shmem
>  dirtypipe dirtypipe
>  
>  pselect01 pselect01
> diff --git a/testcases/kernel/security/dirtyc0w_shmem/.gitignore b/testcases/kernel/security/dirtyc0w_shmem/.gitignore
> new file mode 100644
> index 000000000..291c3de69
> --- /dev/null
> +++ b/testcases/kernel/security/dirtyc0w_shmem/.gitignore
> @@ -0,0 +1,2 @@
> +dirtyc0w_shmem
> +dirtyc0w_shmem_child
> diff --git a/testcases/kernel/security/dirtyc0w_shmem/Makefile b/testcases/kernel/security/dirtyc0w_shmem/Makefile
> new file mode 100644
> index 000000000..a3bad2a83
> --- /dev/null
> +++ b/testcases/kernel/security/dirtyc0w_shmem/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2016 Linux Test Project
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +dirtyc0w_shmem_child: CFLAGS+=-pthread
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
> new file mode 100644
> index 000000000..e098c777a
> --- /dev/null
> +++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 Red Hat, Inc.
> + */
> +
> +/*
> + * CVE-2022-2590
> + *
> + * This is a regression test for a write race that allows unprivileged programs
> + * to change readonly files located on tmpfs/shmem on the system.
> + *
> + * Fixed by:
> + *
> + *   commit 5535be3099717646781ce1540cf725965d680e7b
> + *   Author: David Hildenbrand <david@redhat.com>
> + *   Date:   Tue Aug 9 22:56:40 2022 +0200
> + *
> + *   mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW
> + */

This is not a proper documentation comment. We do have a system in place
that picks up ascii-doc formatted documentation comments and builds a
documentation based on that.

The documentation comment has to start with:

/*\
 * [Description]
 *


Also the CVE and kernel commit are picked from tags when documentation
is build, so they do not need to be part of the documentation comment.

> +#include "config.h"
> +
> +#include <pthread.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <pwd.h>
> +
> +#include "tst_test.h"
> +
> +#define TMP_DIR "tmp_dirtyc0w_shmem"
> +#define TEST_FILE TMP_DIR"/testfile"
> +#define STR "this is not a test\n"
> +
> +static uid_t nobody_uid;
> +static gid_t nobody_gid;
> +static bool child_early_exit;

Anything that is changed from signal handler should be volatile
otherwise it may end up optimized out.

> +static void sighandler(int sig)
> +{
> +	if (sig == SIGCHLD) {
> +		child_early_exit = true;
> +		return;
> +	}
> +
> +	_exit(0);
> +}
> +
> +static void setup(void)
> +{
> +	struct passwd *pw;
> +
> +	umask(0);
> +
> +	pw = SAFE_GETPWNAM("nobody");
> +
> +	nobody_uid = pw->pw_uid;
> +	nobody_gid = pw->pw_gid;
> +
> +	SAFE_MKDIR(TMP_DIR, 0664);
> +	SAFE_MOUNT(TMP_DIR, TMP_DIR, "tmpfs", 0, NULL);
> +}
> +
> +static void dirtyc0w_shmem_test(void)
> +{
> +	bool failed = false;
> +	int fd, pid;
> +	char c;
> +
> +	fd = SAFE_OPEN(TEST_FILE, O_WRONLY|O_CREAT|O_EXCL, 0444);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, STR, sizeof(STR)-1);
> +	SAFE_CLOSE(fd);

SAFE_FILE_PRINTF() ?

> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		SAFE_SETGID(nobody_gid);
> +		SAFE_SETUID(nobody_uid);
> +		SAFE_EXECLP("dirtyc0w_shmem_child", "dirtyc0w_shmem_child", NULL);
> +	}
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	SAFE_SIGNAL(SIGCHLD, sighandler);
> +	do {
> +		usleep(100000);
> +
> +		SAFE_FILE_SCANF(TEST_FILE, "%c", &c);
> +
> +		if (c != 't') {
> +			failed = true;
> +			break;
> +		}
> +	} while (tst_remaining_runtime() && !child_early_exit);
> +	SAFE_SIGNAL(SIGCHLD, SIG_DFL);
> +
> +	SAFE_KILL(pid, SIGUSR1);
> +	tst_reap_children();
> +	SAFE_UNLINK(TEST_FILE);
> +
> +	if (child_early_exit)
> +		tst_res(TINFO, "Early child process exit");

This will potentionally trigger library detection for buggy tests. A
test has to report a result in all situations.

I suppose that this will only happen if child process did exit with
TBROK or TCONF. If that is the case it should be fine.

> +	else if (failed)
> +		tst_res(TFAIL, "Bug reproduced!");
> +	else
> +		tst_res(TPASS, "Bug not reproduced");
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_UMOUNT(TMP_DIR);
> +}
> +
> +static struct tst_test test = {
> +	.needs_checkpoints = 1,
> +	.forks_child = 1,
> +	.needs_root = 1,

We are missing .needs_tmpdir flag here, otherwise the test will create
the the TMPDIR in PWD which may fail in certain setups.

> +	.max_runtime = 120,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = dirtyc0w_shmem_test,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "5535be309971"},
> +		{"CVE", "2022-2590"},
> +		{}
> +	}
> +};
> diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> new file mode 100644
> index 000000000..cb2e9df0c
> --- /dev/null
> +++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 Red Hat, Inc.
> + *  Based on original reproducer: https://seclists.org/oss-sec/2022/q3/128
> + */
> +
> +#include "config.h"
> +
> +#include <fcntl.h>
> +#include <pthread.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <pwd.h>
> +#include <poll.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <sys/ioctl.h>
> +
> +#ifdef HAVE_LINUX_USERFAULTFD_H
> +#include <linux/userfaultfd.h>
> +#endif
> +
> +#ifdef UFFD_FEATURE_MINOR_SHMEM
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "tst_safe_pthread.h"
> +#include "lapi/syscalls.h"
> +
> +#define TMP_DIR "tmp_dirtyc0w_shmem"
> +#define TEST_FILE TMP_DIR"/testfile"
> +
> +static char *str = "m00000000000000000";
> +static void *map;
> +static int mem_fd;
> +static int uffd;
> +static size_t page_size;
> +
> +static void *stress_thread_fn(void *arg)
> +{
> +	while (1)
> +		/* Don't optimize the busy loop out. */
> +		asm volatile("" : "+r" (arg));
> +
> +	return NULL;
> +}
> +
> +static void *discard_thread_fn(void *arg)
> +{
> +	(void)arg;
> +
> +	while (1) {
> +		char tmp;
> +
> +		/*
> +		 * Zap that page first, such that we can trigger a new
> +		 * minor fault.
> +		 */
> +		madvise(map, page_size, MADV_DONTNEED);
> +		/*
> +		 * Touch the page to trigger a UFFD minor fault. The uffd
> +		 * thread will resolve the minor fault via a UFFDIO_CONTINUE.
> +		 */
> +		tmp = *((char *)map);
> +		/* Don't optimize the read out. */
> +		asm volatile("" : "+r" (tmp));
> +	}
> +
> +	return NULL;
> +}
> +
> +static void *write_thread_fn(void *arg)
> +{
> +	(void)arg;
> +
> +	while (1)
> +		/*
> +		 * Ignore any errors -- errors mean that pwrite() would
> +		 * have to trigger a uffd fault and sleep, which the GUP
> +		 * variant doesn't support, so it fails with an I/O errror.
> +		 *
> +		 * Once we retry and are lucky to already find the placed
> +		 * page via UFFDIO_CONTINUE (from the other threads), we get
> +		 * no error.
> +		 */
> +		pwrite(mem_fd, str, strlen(str), (uintptr_t) map);
> +
> +	return NULL;
> +}
> +
> +static void *uffd_thread_fn(void *arg)
> +{
> +	static struct uffd_msg msg;
> +	struct uffdio_continue uffdio;
> +	struct uffdio_range uffdio_wake;
> +
> +	(void)arg;
> +
> +	while (1) {
> +		struct pollfd pollfd;
> +		int nready, nread;
> +
> +		pollfd.fd = uffd;
> +		pollfd.events = POLLIN;
> +		nready = poll(&pollfd, 1, -1);
> +		if (nready < 0)
> +			tst_brk(TBROK | TERRNO, "Error on poll");
> +
> +		nread = read(uffd, &msg, sizeof(msg));
> +		if (nread <= 0)
> +			continue;
> +
> +		uffdio.range.start = (unsigned long) map;
> +		uffdio.range.len = page_size;
> +		uffdio.mode = 0;
> +		if (ioctl(uffd, UFFDIO_CONTINUE, &uffdio) < 0) {
> +			if (errno == EEXIST) {
> +				uffdio_wake.start = (unsigned long) map;
> +				uffdio_wake.len = 4096;
> +				SAFE_IOCTL(uffd, UFFDIO_WAKE, &uffdio_wake);
> +			}
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static void setup_uffd(void)
> +{
> +	struct uffdio_register uffdio_register;
> +	struct uffdio_api uffdio_api;
> +	int flags = O_CLOEXEC | O_NONBLOCK;
> +
> +retry:
> +	TEST(tst_syscall(__NR_userfaultfd, flags));
> +	if (TST_RET < 0) {
> +		if (TST_ERR == EPERM) {
> +			if (!(flags & UFFD_USER_MODE_ONLY)) {
> +				flags |= UFFD_USER_MODE_ONLY;
> +				goto retry;
> +			}
> +		}
> +		tst_brk(TBROK | TTERRNO,
> +			"Could not create userfault file descriptor");
> +	}
> +	uffd = TST_RET;
> +
> +	uffdio_api.api = UFFD_API;
> +	uffdio_api.features = UFFD_FEATURE_MINOR_SHMEM;
> +	TEST(ioctl(uffd, UFFDIO_API, &uffdio_api));
> +	if (TST_RET < 0) {
> +		if (TST_ERR == EINVAL) {
> +			tst_brk(TCONF,
> +				"System does not have userfaultfd minor fault support for shmem");
> +		}
> +		tst_brk(TBROK | TTERRNO,
> +			"Could not create userfault file descriptor");
> +	}
> +
> +	uffdio_register.range.start = (unsigned long) map;
> +	uffdio_register.range.len = page_size;
> +	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
> +	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
> +}
> +
> +static void sighandler(int sig)
> +{
> +	(void) sig;
> +
> +	_exit(0);
> +}
> +
> +int main(void)
> +{
> +	pthread_t thread1, thread2, thread3, *stress_threads;
> +	int fd, i, num_cpus;
> +	struct stat st;
> +
> +	tst_reinit();
> +
> +	SAFE_SIGNAL(SIGUSR1, sighandler);
> +
> +	page_size = getpagesize();
> +	num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +
> +	/* Create some threads that stress all CPUs to make the race easier to reproduce. */
> +	stress_threads = malloc(sizeof(*stress_threads) * num_cpus * 2);
> +	for (i = 0; i < num_cpus * 2; i++)
> +		pthread_create(stress_threads + i, NULL, stress_thread_fn, NULL);
> +
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	fd = SAFE_OPEN(TEST_FILE, O_RDONLY);
> +	SAFE_FSTAT(fd, &st);
> +
> +	/*
> +	 * We need a read-only private mapping of the file. Ordinary write-access
> +	 * via the page tables is impossible, however, we can still perform a
> +	 * write access that bypasses missing PROT_WRITE permissions using ptrace
> +	 * (/proc/self/mem). Such a write access is supposed to properly replace
> +	 * the pagecache page by a private copy first (break COW), such that we are
> +	 * never able to modify the pagecache page.
> +	 *
> +	 * We want the following sequence to trigger. Assuming the pagecache page is
> +	 * mapped R/O already (e.g., due to previous action from Thread 1):
> +	 * Thread 2: pwrite() [start]
> +	 *  -> Trigger write fault, replace mapped page by anonymous page
> +	 *  -> COW was broken, remember FOLL_COW
> +	 * Thread 1: madvise(map, 4096, MADV_DONTNEED);
> +	 *  -> Discard anonymous page
> +	 * Thread 1: tmp += *((int *)map);
> +	 *  -> Trigger a minor uffd fault
> +	 * Thread 3: ioctl(uffd, UFFDIO_CONTINUE
> +	 *  -> Resolve minor uffd fault via UFFDIO_CONTINUE
> +	 *  -> Map shared page R/O but set it dirty
> +	 * Thread 2: pwrite() [continue]
> +	 *  -> Find R/O mapped page that's dirty and FOLL_COW being set
> +	 *  -> Modify shared page R/O because we don't break COW (again)
> +	 */
> +	map = SAFE_MMAP(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	mem_fd = SAFE_OPEN("/proc/self/mem", O_RDWR);
> +
> +	setup_uffd();
> +
> +	SAFE_PTHREAD_CREATE(&thread1, NULL, discard_thread_fn, NULL);
> +	SAFE_PTHREAD_CREATE(&thread2, NULL, write_thread_fn, NULL);
> +	SAFE_PTHREAD_CREATE(&thread3, NULL, uffd_thread_fn, NULL);
> +
> +	pause();
> +
> +	return 0;
> +}
> +#else /* UFFD_FEATURE_MINOR_SHMEM */
> +#include "tst_test.h"
> +TST_TEST_TCONF("System does not have userfaultfd minor fault support for shmem");
> +#endif /* UFFD_FEATURE_MINOR_SHMEM */
> -- 
> 2.38.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
