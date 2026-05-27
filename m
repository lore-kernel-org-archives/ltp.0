Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCF2CD5BDE
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 07:05:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D26D73C985B
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 09:05:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B421B3C5E23
 for <ltp@lists.linux.it>; Wed, 27 May 2026 08:41:03 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B7BCB1000958
 for <ltp@lists.linux.it>; Wed, 27 May 2026 08:41:02 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-3044857f09aso6956074eec.1
 for <ltp@lists.linux.it>; Tue, 26 May 2026 23:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779864061; x=1780468861; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtYRp58/Ww/6hFGbw0cMn5nwLGSTBpukG6R9+QO7N8o=;
 b=lepsNyFMsSlvGl9pXo76PTITqM02/ucDAccq5WgApGE0WwwVAu/mX7a6HyOBIG4DHg
 vTCHx4/pqwY1bssZ/4Re0mNU647xv3qCoj1nDUB+bjm4RBsQw6W4v5wE8/g3q5GIuz3L
 u6S4tchAXtIsFx7mLWes8VT1XTYOP60nXB+7hK4jJR10Yl+D22fCwH3O371gVLNvnvCG
 uXOOrdj1mylSLvIp3wA8z/GACrPrhzT8dlZJMkPZZIPaxct8tKbC0v/iQLqH6fY51Gsr
 7UdU2reCnOLeh83srmV6gNnYoy/WAnxmGI9YrXnwL69SyPtJi5SxLPvjO3ySHXRnyY/b
 d1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779864061; x=1780468861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YtYRp58/Ww/6hFGbw0cMn5nwLGSTBpukG6R9+QO7N8o=;
 b=L4JL5CBgQifFzJpvi4UvzO67hh2E4gsTMZuBOIybvHDsz8pg4snYD8Q8MXy12UHQeX
 dhMF9mASB98cU4DZQgujAIIFZNK4KSpsnmrd7L9GOq/7ne9j61U3tY27kUFPC4SQqcZX
 xH2YEpCRaeHqyfaDmgdjQCBFiwasWqNqpEeOvSQxRKGhtHutoHq5sxQ8Esf64bEDICdQ
 Oc76IiGBnCh9DfieVLXvNdeiw3AmSBjIGcCIGshrTHKxzi+W9uEBl1bibG1naCRhI27t
 9nn3A8/xmEATNCoeeAZUVS4pTeOHFuvVbzm9VJ5TILOqdQmlk70aQdFznaKXxbV3lYx2
 R86A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4Wxz0F3kzJq17OriOmJ1SSDa9q6N+EASl6mhG1QLirNxZ4UfFl9Cn7Uj2Xeu/QFObYM4=@lists.linux.it
X-Gm-Message-State: AOJu0Yz/QP2pY5LA/CsrEgheSoyaWxL5rcQeoOsIAQVzgyB/DNvv55tg
 KkHlZ62jQCZvsMStBGlqMQSdR0/Ivyav3Klj/nOMubSKvZQOKVUACuen
X-Gm-Gg: Acq92OEHHqW7UyO333rCteJ5ymVvo7FfuwmX9eWeaNx/oG4IfnIxqPmzBternjq9Kbt
 i6j5agFexZqKhsLvExkbfKEVjEBUQdKbiEhXrv8Y3e91ZJlSR49gkXDuZsX4MUVwnrYsz9Jmc0Y
 4V3KngNoSzOChvxWe+qL4pHvy0qHWxIf+AEAsmIgu1AvPyHLVGDAWtR0RouE45Clg3IQRQNJtep
 p+GWm+sUNZHnvAoR/i/vE7k9jL7Bh/PLYv88zrGJDAHL2ITPj7wiFn7vO5XnJAAJa9FbIjvA1yR
 ajNYRqlC+u4y5vo0mahy8BjRnszwg2m5Per8xaGJPnC1HyoNBTAk85ER14dMPWopk8BMnXu0J8W
 ERiYPRhAtcThpvSivQj8epk35OYdLAommXF1rQJwVDqcSQ3uznpUvCQoIUmZUx8t31IiFs1Ww9E
 b6QZMqVDvTIGKncnZ3Hns=
X-Received: by 2002:a05:7300:bb04:b0:2f2:c336:7736 with SMTP id
 5a478bee46e88-304490d8aebmr10159153eec.29.1779864060834; 
 Tue, 26 May 2026 23:41:00 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef4af0sm12126203eec.3.2026.05.26.23.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 23:41:00 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: amir73il@gmail.com,
	ltp@lists.linux.it
Date: Wed, 27 May 2026 14:40:41 +0800
Message-ID: <20260527064041.50443-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAOQ4uxgrLEJDskC8Ku8evT21un=AMnMgrKJwAN5ceUFDrJY=GA@mail.gmail.com>
References: <CAOQ4uxgrLEJDskC8Ku8evT21un=AMnMgrKJwAN5ceUFDrJY=GA@mail.gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 27 May 2026 09:04:52 +0200
Subject: [LTP] [PATCH] fanotify: prepare tests for thread pidfd reporting
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
Cc: jack@suse.cz, linux-kernel@vger.kernel.org,
 AnonymeMeow <anonymemeow@gmail.com>, repnop@google.com,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2026-05-25 12:04:32+02:00, Amir Goldstein wrote:
> On Sun, May 24, 2026 at 12:25 PM AnonymeMeow <anonymemeow@gmail.com> wrote:
> 
> > The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
> > exclusive because by the time the pidfd support was introduced to
> > fanotify, pidfds could only be created for thread group leaders. Now
> > that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
> > this restriction can be lifted.
> >
> > This patch allows listeners using FAN_REPORT_PIDFD | FAN_REPORT_TID
> > to receive the pidfd referring to the thread that triggered the
> > event.
> >
> > Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> 
> Regarding the legal standpoint, as far as I can tell, commit d4563201f33a0
> ("Documentation: simplify and clarify DCO contribution example language")
> explicitly allowed pseudonyms, so although unorthodox, this seems to be legit.
> 
> In any case, the contributing itself seems legit to me, so
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> But before merging this, AnonymeMeow, since it is your first contribution
> to the Linux kernel (right?) as well as a "I am not a robot" challenge
> I would like to first see that the tests have been dealt with.
> 
> The LTP test fanotify20 explicitly checks that this flag combination is not
> allowed. Need to discuss an acceptable solution with LTP developers -
> remove this check depending on kernel version or whatever they choose.
> 
> The LTP test fanotify21 tests the FAN_REPORT_PIDFD functionality.
> Please add two new variants for REPORT_TID:
>         .test_variants = 4,
> 
> #define TST_VARIANT_FD_ERROR (tst_variant & 1)
> #define TST_VARIANT_PIDFD_THREAD (tst_variant & 2)
> 
> The existing checks if (tst_variant) become if (TST_VARIANT_FD_ERROR)
> so bit 0 represents the FAN_REPORT_FD_ERROR variation.
> 
> in do_setup() need to use if (TST_VARIANT_PIDFD_THREAD)
> to add FAN_REPORT_TID and to use PIDFD_THREAD for pidfd.
> 
> Follow the footsteps of fd_error_unsupported to skip the
> TST_VARIANT_PIDFD_THREAD variants on kernels where the flag
> combination is not supported.
> 
> Good luck,
> Amir.

Thanks for the helpful and detailed guidance on how to extend the tests!
I've updated the test cases according to your suggestions.

After applying my previous patch, the LTP fanotify20 test needs to probe
whether the running kernel supports thread pidfd reporting. I didn't use
kernel version check because the LTP documentation notes that kernel
versions do not always correspond to a well-defined feature set due to
distribution backports, and recommends runtime feature checks. I probe
whether fanotify_init() succeeds with FAN_REPORT_PIDFD | FAN_REPORT_TID
as a workaround. The first test case uses exactly the same flags, but it
still verifies the return value and errno, so I am not sure whether this
should be considered duplicate logic. I also added one test case that
passes all relevant FAN_REPORT_* flags and verifies whether
fanotify_init() behaves as expected. The expected result depends on the
previous probe result.

Also, I added one test case and two test variants to LTP test
fanotify21. The new test case verifies that fanotify reports the correct
pidfd for the event generated by a child process or a worker thread
created by the main thread. This is especially useful for the thread
pidfd test variants, because it checks that the pidfd reported by
fanotify really refers to the event-generating thread rather than to
the thread-group leader. The two new test variants extend the existing
ones by adding the thread pidfd mode, as you suggested.

I ran all fanotify-related LTP tests on both a vanilla Linux 7.1-rc5
kernel and a Linux 7.1-rc5 kernel with my patch applied. Both kernels
passed all the tests. They were both built with the config file from the
official Arch Linux package repo. More specifically, both kernels passed
all three test cases in fanotify20, with no skips. The test cases expect
different results from the two kernels, which is the expected behavior.
For fanotify21, the patched kernel passed all test cases in all test
variants. On the unpatched kernel, all test cases passed for variants
without TST_VARIANT_PIDFD_THREAD, while all test cases in variants with
TST_VARIANT_PIDFD_THREAD were skipped, which is also the expected
behavior.

Again, thanks for the detailed guidance on this!

With Best Regards,
AnonymeMeow

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---
 testcases/kernel/syscalls/fanotify/Makefile   |   2 +-
 .../kernel/syscalls/fanotify/fanotify20.c     |  24 +-
 .../kernel/syscalls/fanotify/fanotify21.c     | 224 +++++++++++++-----
 3 files changed, 184 insertions(+), 66 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/Makefile b/testcases/kernel/syscalls/fanotify/Makefile
index 3628094ba..b20bb50e9 100644
--- a/testcases/kernel/syscalls/fanotify/Makefile
+++ b/testcases/kernel/syscalls/fanotify/Makefile
@@ -2,7 +2,7 @@
 #  Copyright (c) Jan Kara <jack@suse.cz>, 2013
 
 top_srcdir		?= ../../../..
-fanotify11: CFLAGS+=-pthread
+fanotify11 fanotify21: CFLAGS+=-pthread
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index b32ecf6aa..5d77b485c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -28,19 +28,27 @@
 #define FLAGS_DESC(x) .flags = x, .desc = #x
 
 static int fd;
+static int thread_pidfd_unsupported;
 
 static struct test_case_t {
 	unsigned int flags;
 	char *desc;
 	int exp_errno;
+	unsigned int needs_thread_pidfd;
 } test_cases[] = {
 	{
 		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID),
 		.exp_errno = EINVAL,
+		.needs_thread_pidfd = 1,
 	},
 	{
 		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME),
 	},
+	{
+		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID | FAN_REPORT_FID | FAN_REPORT_DFID_NAME),
+		.exp_errno = EINVAL,
+		.needs_thread_pidfd = 1,
+	},
 };
 
 static void do_setup(void)
@@ -51,17 +59,29 @@ static void do_setup(void)
 	 */
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_PIDFD,
 						    MOUNT_PATH);
+
+	/*
+	 * Check whether the kernel supports FAN_REPORT_PIDFD in combination
+	 * with FAN_REPORT_TID. Test cases with the needs_thread_pidfd field
+	 * set expect different errno values depending on whether this
+	 * combination is supported.
+	 */
+	thread_pidfd_unsupported = fanotify_init_flags_supported_on_fs(
+		FAN_REPORT_PIDFD | FAN_REPORT_TID, MOUNT_PATH);
 }
 
 static void do_test(unsigned int i)
 {
 	struct test_case_t *tc = &test_cases[i];
 
-	tst_res(TINFO, "Test %s on %s", tc->exp_errno ? "fail" : "pass",
+	int exp_errno = tc->needs_thread_pidfd && !thread_pidfd_unsupported ?
+		0 : tc->exp_errno;
+
+	tst_res(TINFO, "Test %s on %s", exp_errno ? "fail" : "pass",
 		tc->desc);
 
 	TST_EXP_FD_OR_FAIL(fd = fanotify_init(tc->flags, O_RDONLY),
-			   tc->exp_errno);
+			   exp_errno);
 
 	if (fd > 0)
 		SAFE_CLOSE(fd);
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 340fb0018..4629860da 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -20,9 +20,11 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/mount.h>
+#include <pthread.h>
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
 #include "tst_safe_macros.h"
+#include "tst_safe_pthread.h"
 #include "lapi/pidfd.h"
 
 #ifdef HAVE_SYS_FANOTIFY_H
@@ -42,7 +44,7 @@ struct pidfd_fdinfo_t {
 
 static struct test_case_t {
 	char *name;
-	int fork;
+	int trigger_in_child;
 	int want_pidfd_err;
 	int remount_ro;
 } test_cases[] = {
@@ -52,6 +54,12 @@ static struct test_case_t {
 		0,
 		0,
 	},
+	{
+		"return a valid pidfd for event created by child",
+		1,
+		0,
+		0,
+	},
 	{
 		"return invalid pidfd for event created by terminated child",
 		1,
@@ -68,16 +76,17 @@ static struct test_case_t {
 
 static int fanotify_fd;
 static char event_buf[BUF_SZ];
-static struct pidfd_fdinfo_t *self_pidfd_fdinfo;
+static struct pidfd_fdinfo_t expected_pidfd_fdinfo;
 
 static int fd_error_unsupported;
+static int thread_pidfd_unsupported;
+
+#define TST_VARIANT_FD_ERROR (tst_variant & 1)
+#define TST_VARIANT_PIDFD_THREAD (tst_variant & 2)
 
-static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
+static void read_pidfd_fdinfo(int pidfd, struct pidfd_fdinfo_t *pidfd_fdinfo)
 {
 	char *fdinfo_path;
-	struct pidfd_fdinfo_t *pidfd_fdinfo;
-
-	pidfd_fdinfo = SAFE_MALLOC(sizeof(struct pidfd_fdinfo_t));
 
 	SAFE_ASPRINTF(&fdinfo_path, "/proc/self/fdinfo/%d", pidfd);
 	SAFE_FILE_LINES_SCANF(fdinfo_path, "pos: %d", &pidfd_fdinfo->pos);
@@ -87,8 +96,6 @@ static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
 	SAFE_FILE_LINES_SCANF(fdinfo_path, "NSpid: %d", &pidfd_fdinfo->ns_pid);
 
 	free(fdinfo_path);
-
-	return pidfd_fdinfo;
 }
 
 static void generate_event(void)
@@ -100,30 +107,91 @@ static void generate_event(void)
 	SAFE_CLOSE(fd);
 }
 
-static void do_fork(void)
+static pid_t do_fork(int want_pidfd_err)
 {
-	int status;
+	int pidfd;
 	pid_t child;
 
 	child = SAFE_FORK();
 	if (child == 0) {
 		SAFE_CLOSE(fanotify_fd);
 		generate_event();
+		TST_CHECKPOINT_WAIT(0);
 		exit(EXIT_SUCCESS);
 	}
 
-	SAFE_WAITPID(child, &status, 0);
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
-		tst_brk(TBROK,
-			"child process terminated incorrectly");
+	pidfd = SAFE_PIDFD_OPEN(child, 0);
+	read_pidfd_fdinfo(pidfd, &expected_pidfd_fdinfo);
+	SAFE_CLOSE(pidfd);
+
+	if (want_pidfd_err) {
+		int status;
+		TST_CHECKPOINT_WAKE(0);
+		SAFE_WAITPID(child, &status, 0);
+		if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+			tst_brk(TBROK, "child process terminated incorrectly");
+		
+		return -1;
+	}
+
+	return child;
 }
 
-static void do_setup(void)
+static void *thread_generate_event(void *arg)
+{
+	*(int *)arg = SAFE_PIDFD_OPEN(gettid(), PIDFD_THREAD);
+	TST_CHECKPOINT_WAKE(0);
+
+	generate_event();
+	TST_CHECKPOINT_WAIT(0);
+	pthread_exit(0);
+}
+
+static pthread_t do_pthread_create(int want_pidfd_err)
 {
 	int pidfd;
+	pthread_t worker;
+
+	SAFE_PTHREAD_CREATE(&worker, NULL, thread_generate_event, &pidfd);
+
+	TST_CHECKPOINT_WAIT(0);
+	read_pidfd_fdinfo(pidfd, &expected_pidfd_fdinfo);
+
+	if (want_pidfd_err) {
+		int status;
+		struct pidfd_fdinfo_t thread_pidfd_fdinfo;
+		TST_CHECKPOINT_WAKE(0);
+		SAFE_PTHREAD_JOIN(worker, (void **)&status);
+		if (status != 0)
+			tst_brk(TBROK, "worker thread terminated incorrectly");
+
+		/*
+		 * Unlike waitpid(), pthread_join() only waits until the worker thread
+		 * has exited from the pthread point of view. The thread may still be
+		 * visible through its pidfd for a short time afterwards, and fanotify
+		 * creates the event pidfd when the event is read. Wait until the
+		 * worker pidfd fdinfo reports Pid: -1 before reading the event so
+		 * that fanotify reports ESRCH/FAN_NOPIDFD instead of a pidfd.
+		 */
+		do {
+			read_pidfd_fdinfo(pidfd, &thread_pidfd_fdinfo);
+		} while (thread_pidfd_fdinfo.pid != -1);
+
+		SAFE_CLOSE(pidfd);
+
+		return -1;
+	}
+
+	SAFE_CLOSE(pidfd);
+
+	return worker;
+}
+
+static void do_setup(void)
+{
 	int init_flags = FAN_REPORT_PIDFD;
 
-	if (tst_variant) {
+	if (TST_VARIANT_FD_ERROR) {
 		fanotify_fd = -1;
 		fd_error_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FD_ERROR, ".");
 		if (fd_error_unsupported)
@@ -131,6 +199,15 @@ static void do_setup(void)
 		init_flags |= FAN_REPORT_FD_ERROR;
 	}
 
+	if (TST_VARIANT_PIDFD_THREAD) {
+		fanotify_fd = -1;
+		thread_pidfd_unsupported = fanotify_init_flags_supported_on_fs(
+			FAN_REPORT_PIDFD | FAN_REPORT_TID, ".");
+		if (thread_pidfd_unsupported)
+			return;
+		init_flags |= FAN_REPORT_TID;
+	}
+
 	SAFE_TOUCH(TEST_FILE, 0666, NULL);
 
 	/*
@@ -144,15 +221,6 @@ static void do_setup(void)
 	fanotify_fd = SAFE_FANOTIFY_INIT(init_flags, O_RDWR);
 	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD,
 			   TEST_FILE);
-
-	pidfd = SAFE_PIDFD_OPEN(getpid(), 0);
-
-	self_pidfd_fdinfo = read_pidfd_fdinfo(pidfd);
-	if (self_pidfd_fdinfo == NULL) {
-		tst_brk(TBROK,
-			"pidfd=%d, failed to read pidfd fdinfo",
-			pidfd);
-	}
 }
 
 static void do_test(unsigned int num)
@@ -160,17 +228,29 @@ static void do_test(unsigned int num)
 	int i = 0, len;
 	struct test_case_t *tc = &test_cases[num];
 	int nopidfd_err = tc->want_pidfd_err ?
-			  (tst_variant ? -ESRCH : FAN_NOPIDFD) : 0;
-	int fd_err = (tc->remount_ro && tst_variant) ? -EROFS : 0;
+			  (TST_VARIANT_FD_ERROR ? -ESRCH : FAN_NOPIDFD) : 0;
+	int fd_err = (tc->remount_ro && TST_VARIANT_FD_ERROR) ? -EROFS : 0;
+	union {
+		pid_t pid;
+		pthread_t pthread_id;
+	} worker_id;
 
 	tst_res(TINFO, "Test #%d.%d: %s %s", num, tst_variant, tc->name,
-			tst_variant ? "(FAN_REPORT_FD_ERROR)" : "");
+		TST_VARIANT_FD_ERROR ? (TST_VARIANT_PIDFD_THREAD ?
+			"(FAN_REPORT_FD_ERROR, FAN_REPORT_TID)" : "(FAN_REPORT_FD_ERROR)") :
+			(TST_VARIANT_PIDFD_THREAD ? "(FAN_REPORT_TID)" : ""));
 
-	if (fd_error_unsupported && tst_variant) {
+	if (fd_error_unsupported && TST_VARIANT_FD_ERROR) {
 		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_FD_ERROR, fd_error_unsupported);
 		return;
 	}
 
+	if (thread_pidfd_unsupported && TST_VARIANT_PIDFD_THREAD) {
+		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_PIDFD | FAN_REPORT_TID,
+				thread_pidfd_unsupported);
+		return;
+	}
+
 	if (tc->remount_ro) {
 		/* SAFE_MOUNT fails to remount FUSE */
 		if (mount(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
@@ -182,14 +262,30 @@ static void do_test(unsigned int num)
 	}
 
 	/*
-	 * Generate the event in either self or a child process. Event
-	 * generation in a child process is done so that the FAN_NOPIDFD case
-	 * can be verified.
+	 * Generate the event either in the current task or in another task.
+	 * When trigger_in_child is set, the event can be generated by either
+	 * a child process or a worker thread depending on the test variant.
+	 * The want_pidfd_err field determines whether the event-generating
+	 * task is still valid when the event is read.
 	 */
-	if (tc->fork)
-		do_fork();
-	else
+	if (tc->trigger_in_child) {
+		if (TST_VARIANT_PIDFD_THREAD)
+			worker_id.pthread_id = do_pthread_create(tc->want_pidfd_err);
+		else
+			worker_id.pid = do_fork(tc->want_pidfd_err);
+	} else {
+		/*
+		 * Although the expected pid and the pid reported by fanotify are
+		 * the same in this case, pidfds created with and without PIDFD_THREAD
+		 * flag have different fdinfo flags. Use PIDFD_THREAD for the expected
+		 * pidfd fdinfo so that the fdinfo can be compared bitwise.
+		 */
+		int pidfd = SAFE_PIDFD_OPEN(gettid(), TST_VARIANT_PIDFD_THREAD ? PIDFD_THREAD : 0);
+		read_pidfd_fdinfo(pidfd, &expected_pidfd_fdinfo);
+		SAFE_CLOSE(pidfd);
+
 		generate_event();
+	}
 
 	/*
 	 * Read all of the queued events into the provided event
@@ -208,7 +304,7 @@ static void do_test(unsigned int num)
 	while (i < len) {
 		struct fanotify_event_metadata *event;
 		struct fanotify_event_info_pidfd *info;
-		struct pidfd_fdinfo_t *event_pidfd_fdinfo = NULL;
+		struct pidfd_fdinfo_t event_pidfd_fdinfo;
 
 		event = (struct fanotify_event_metadata *)&event_buf[i];
 		info = (struct fanotify_event_info_pidfd *)(event + 1);
@@ -288,39 +384,32 @@ static void do_test(unsigned int num)
 		 * No pidfd errors occurred, continue with verifying pidfd
 		 * fdinfo validity.
 		 */
-		event_pidfd_fdinfo = read_pidfd_fdinfo(info->pidfd);
-		if (event_pidfd_fdinfo == NULL) {
-			tst_brk(TBROK,
-				"reading fdinfo for pidfd: %d "
-				"describing pid: %u failed",
-				info->pidfd,
-				(unsigned int)event->pid);
-			goto next_event;
-		} else if (event_pidfd_fdinfo->pid != event->pid) {
+		read_pidfd_fdinfo(info->pidfd, &event_pidfd_fdinfo);
+		if (event_pidfd_fdinfo.pid != event->pid) {
 			tst_res(TFAIL,
 				"pidfd provided for incorrect pid "
 				"(expected pidfd for pid: %u, got pidfd for "
 				"pid: %u)",
 				(unsigned int)event->pid,
-				(unsigned int)event_pidfd_fdinfo->pid);
+				(unsigned int)event_pidfd_fdinfo.pid);
 			goto next_event;
-		} else if (memcmp(event_pidfd_fdinfo, self_pidfd_fdinfo,
+		} else if (memcmp(&event_pidfd_fdinfo, &expected_pidfd_fdinfo,
 				  sizeof(struct pidfd_fdinfo_t))) {
 			tst_res(TFAIL,
 				"pidfd fdinfo values for self and event differ "
 				"(expected pos: %d, flags: %x, mnt_id: %d, "
 				"pid: %d, ns_pid: %d, got pos: %d, "
 				"flags: %x, mnt_id: %d, pid: %d, ns_pid: %d",
-				self_pidfd_fdinfo->pos,
-				self_pidfd_fdinfo->flags,
-				self_pidfd_fdinfo->mnt_id,
-				self_pidfd_fdinfo->pid,
-				self_pidfd_fdinfo->ns_pid,
-				event_pidfd_fdinfo->pos,
-				event_pidfd_fdinfo->flags,
-				event_pidfd_fdinfo->mnt_id,
-				event_pidfd_fdinfo->pid,
-				event_pidfd_fdinfo->ns_pid);
+				expected_pidfd_fdinfo.pos,
+				expected_pidfd_fdinfo.flags,
+				expected_pidfd_fdinfo.mnt_id,
+				expected_pidfd_fdinfo.pid,
+				expected_pidfd_fdinfo.ns_pid,
+				event_pidfd_fdinfo.pos,
+				event_pidfd_fdinfo.flags,
+				event_pidfd_fdinfo.mnt_id,
+				event_pidfd_fdinfo.pid,
+				event_pidfd_fdinfo.ns_pid);
 			goto next_event;
 		} else {
 			tst_res(TPASS,
@@ -342,9 +431,20 @@ next_event:
 
 		if (info && info->pidfd >= 0)
 			SAFE_CLOSE(info->pidfd);
+	}
 
-		if (event_pidfd_fdinfo)
-			free(event_pidfd_fdinfo);
+	if (tc->trigger_in_child && !tc->want_pidfd_err) {
+		int status;
+		TST_CHECKPOINT_WAKE(0);
+		if (TST_VARIANT_PIDFD_THREAD) {
+			SAFE_PTHREAD_JOIN(worker_id.pthread_id, (void **)&status);
+			if (status != 0)
+				tst_brk(TBROK, "worker thread terminated incorrectly");
+		} else {
+			SAFE_WAITPID(worker_id.pid, &status, 0);
+			if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+				tst_brk(TBROK, "child process terminated incorrectly");
+		}
 	}
 }
 
@@ -352,19 +452,17 @@ static void do_cleanup(void)
 {
 	if (fanotify_fd >= 0)
 		SAFE_CLOSE(fanotify_fd);
-
-	if (self_pidfd_fdinfo)
-		free(self_pidfd_fdinfo);
 }
 
 static struct tst_test test = {
 	.setup = do_setup,
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
-	.test_variants = 2,
+	.test_variants = 4,
 	.cleanup = do_cleanup,
 	.all_filesystems = 1,
 	.needs_root = 1,
+	.needs_checkpoints = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
 	.forks_child = 1,
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
