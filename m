Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1D1C6FD1D
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 13:02:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2FD63CD504
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 14:02:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22D873CAD42
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 14:02:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E46F600875
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 14:02:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 95A031F893;
 Tue, 14 Mar 2023 13:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678798956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=r12+VZO/PzJqAd8+rmmEQCOBncwG4duTRTwfIunGdEk=;
 b=Tecpl8u0ky1DFtjRHd9CehJg3g3zfdJDYIZaWC+kgyXYdRnO8quUxwpZQ6i7wh/2DToYPO
 bUWiOggAIpxsSP0ASLb0NDlg07zHFIlXcM4wASf3CXIDCJawQ9WyH4mNoGh8itP5Rms7xw
 88FX9sVeveQBOpDvoomQAGJFtyjPBKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678798956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=r12+VZO/PzJqAd8+rmmEQCOBncwG4duTRTwfIunGdEk=;
 b=A83T2WqMxaUEdnZ7vnUQ4NHHwbTjTfWFn3L7Lw8svmMLLozvMA2QwWl2B1u/O7Bhaite3d
 W70gorRf1wZC7qAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7507E13A1B;
 Tue, 14 Mar 2023 13:02:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ehgcG2xwEGQwagAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 14 Mar 2023 13:02:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 14 Mar 2023 14:00:27 +0100
Message-Id: <20230314130027.24108-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Rewrite eventfd01 using new LTP API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Splitted eventfd01 test into multiple test files using new LTP API.
Now we have 5 more tests.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Use TST_EXP_FD for fd check
Check CONFIG_EVENTFD for each test
Description adjustments

 runtest/syscalls                              |   5 +
 testcases/kernel/syscalls/eventfd/.gitignore  |   5 +
 testcases/kernel/syscalls/eventfd/eventfd01.c | 745 +-----------------
 testcases/kernel/syscalls/eventfd/eventfd02.c |  50 ++
 testcases/kernel/syscalls/eventfd/eventfd03.c |  54 ++
 testcases/kernel/syscalls/eventfd/eventfd04.c |  57 ++
 testcases/kernel/syscalls/eventfd/eventfd05.c |  44 ++
 testcases/kernel/syscalls/eventfd/eventfd06.c | 171 ++++
 8 files changed, 412 insertions(+), 719 deletions(-)
 create mode 100644 testcases/kernel/syscalls/eventfd/eventfd02.c
 create mode 100644 testcases/kernel/syscalls/eventfd/eventfd03.c
 create mode 100644 testcases/kernel/syscalls/eventfd/eventfd04.c
 create mode 100644 testcases/kernel/syscalls/eventfd/eventfd05.c
 create mode 100644 testcases/kernel/syscalls/eventfd/eventfd06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9c76d7fe3..2179f8d5b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -182,6 +182,11 @@ epoll_pwait04 epoll_pwait04
 epoll_pwait05 epoll_pwait05
 
 eventfd01 eventfd01
+eventfd02 eventfd02
+eventfd03 eventfd03
+eventfd04 eventfd04
+eventfd05 eventfd05
+eventfd06 eventfd06
 
 eventfd2_01 eventfd2_01
 eventfd2_02 eventfd2_02
diff --git a/testcases/kernel/syscalls/eventfd/.gitignore b/testcases/kernel/syscalls/eventfd/.gitignore
index db45c67cf..4f577370c 100644
--- a/testcases/kernel/syscalls/eventfd/.gitignore
+++ b/testcases/kernel/syscalls/eventfd/.gitignore
@@ -1 +1,6 @@
 /eventfd01
+/eventfd02
+/eventfd03
+/eventfd04
+/eventfd05
+/eventfd06
diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
index 9b60434a2..8f83378da 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd01.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
@@ -1,738 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) 2008 Vijay Kumar B. <vijaykumar@bravegnu.org>
- *   Copyright (c) Linux Test Project, 2008-2022
- *
- *   Based on testcases/kernel/syscalls/waitpid/waitpid01.c
- *   Original copyright message:
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
 /*
- * NAME
- *	eventfd01.c
- *
- * DESCRIPTION
- *      Test cases for eventfd syscall.
- *
- * USAGE:  <for command-line>
- *      eventfd01 [-c n] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -i n : Execute test n times.
- *              -I x : Execute test for x seconds.
- *              -P x : Pause for x seconds between iterations.
+ * [Description]
  *
- * History
- *	07/2008 Vijay Kumar
- *		Initial Version.
- *
- * Restrictions
- *	None
- */
-
-#include "config.h"
-
-#include <sys/types.h>
-#include <sys/select.h>
-#include <sys/wait.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <inttypes.h>
-#include <poll.h>
-#include <signal.h>
-#include <stdint.h>
-#include <string.h>
-#include <unistd.h>
-
-#include "test.h"
-#define CLEANUP cleanup
-#include "lapi/syscalls.h"
-
-TCID_DEFINE(eventfd01);
-int TST_TOTAL = 15;
-
-#ifdef HAVE_LIBAIO
-#include <libaio.h>
-
-static void setup(void);
-
-static int myeventfd(unsigned int initval, int flags)
-{
-	/* eventfd2 uses FLAGS but eventfd doesn't take FLAGS. */
-	return tst_syscall(__NR_eventfd, initval);
-}
-
-/*
- * clear_counter() - clears the counter by performing a dummy read
- * @fd: the eventfd
+ * Verify read operation for eventfd fail with:
  *
- * RETURNS:
- * 0 on success, and -1 on failure
+ * - EAGAIN when counter is zero on non blocking fd
+ * - EINVAL when buffer size is less than 8 bytes
  */
-static int clear_counter(int fd)
-{
-	uint64_t dummy;
-	int ret;
 
-	ret = read(fd, &dummy, sizeof(dummy));
-	if (ret == -1) {
-		if (errno != EAGAIN) {
-			tst_resm(TINFO | TERRNO, "error clearing counter");
-			return -1;
-		}
-	}
+#include <stdlib.h>
+#include <sys/eventfd.h>
+#include "tst_test.h"
 
-	return 0;
-}
+#define EVENT_COUNT 10
 
-/*
- * set_counter() - sets the count to specified value
- * @fd: the eventfd
- * @val: the value to be set
- *
- * Clears the counter and sets the counter to @val.
- *
- * RETURNS:
- * 0 on success, -1 on failure
- */
-static int set_counter(int fd, uint64_t val)
+static void run(void)
 {
-	int ret;
-
-	ret = clear_counter(fd);
-	if (ret == -1)
-		return -1;
-
-	ret = write(fd, &val, sizeof(val));
-	if (ret == -1) {
-		tst_resm(TINFO | TERRNO, "error setting counter value");
-		return -1;
-	}
-
-	return 0;
-}
-
-/*
- * Test whether the current value of the counter matches @required.
- */
-static void read_test(int fd, uint64_t required)
-{
-	int ret;
-	uint64_t val;
-
-	ret = read(fd, &val, sizeof(val));
-	if (ret == -1) {
-		tst_resm(TBROK | TERRNO, "error reading eventfd");
-		return;
-	}
-
-	if (val == required)
-		tst_resm(TPASS, "counter value matches required");
-	else
-		tst_resm(TFAIL, "counter value mismatch: "
-			 "required: %" PRIu64 ", got: %" PRIu64, required, val);
-}
-
-/*
- * Test whether read returns with error EAGAIN when counter is at 0.
- */
-static void read_eagain_test(int fd)
-{
-	int ret;
-	uint64_t val;
-
-	ret = clear_counter(fd);
-	if (ret == -1) {
-		tst_resm(TBROK, "error clearing counter");
-		return;
-	}
-
-	ret = read(fd, &val, sizeof(val));
-	if (ret == -1) {
-		if (errno == EAGAIN)
-			tst_resm(TPASS, "read failed with EAGAIN as expected");
-		else
-			tst_resm(TFAIL | TERRNO, "read failed (wanted EAGAIN)");
-	} else
-		tst_resm(TFAIL, "read returned with %d", ret);
-}
-
-/*
- * Test whether writing to counter works.
- */
-static void write_test(int fd)
-{
-	int ret;
-	uint64_t val;
-
-	val = 12;
-
-	ret = set_counter(fd, val);
-	if (ret == -1) {
-		tst_resm(TBROK, "error setting counter value to %" PRIu64, val);
-		return;
-	}
-
-	read_test(fd, val);
-}
-
-/*
- * Test whether write returns with error EAGAIN when counter is at
- * (UINT64_MAX - 1).
- */
-static void write_eagain_test(int fd)
-{
-	int ret;
+	int fd;
 	uint64_t val;
-
-	ret = set_counter(fd, UINT64_MAX - 1);
-	if (ret == -1) {
-		tst_resm(TBROK, "error setting counter value to UINT64_MAX-1");
-		return;
-	}
-
-	val = 1;
-	ret = write(fd, &val, sizeof(val));
-	if (ret == -1) {
-		if (errno == EAGAIN)
-			tst_resm(TPASS, "write failed with EAGAIN as expected");
-		else
-			tst_resm(TFAIL, "write failed (wanted EAGAIN)");
-	} else
-		tst_resm(TFAIL, "write returned with %d", ret);
-}
-
-/*
- * Test whether read returns with error EINVAL, if buffer size is less
- * than 8 bytes.
- */
-static void read_einval_test(int fd)
-{
-	uint32_t invalid;
-	int ret;
-
-	ret = read(fd, &invalid, sizeof(invalid));
-	if (ret == -1) {
-		if (errno == EINVAL)
-			tst_resm(TPASS, "read failed with EINVAL as expected");
-		else
-			tst_resm(TFAIL | TERRNO, "read failed (wanted EINVAL)");
-	} else
-		tst_resm(TFAIL, "read returned with %d", ret);
-}
-
-/*
- * Test whether write returns with error EINVAL, if buffer size is
- * less than 8 bytes.
- */
-static void write_einval_test(int fd)
-{
 	uint32_t invalid;
-	int ret;
-
-	ret = write(fd, &invalid, sizeof(invalid));
-	if (ret == -1) {
-		if (errno == EINVAL)
-			tst_resm(TPASS, "write failed with EINVAL as expected");
-		else
-			tst_resm(TFAIL | TERRNO,
-				 "write failed (wanted EINVAL)");
-	} else
-		tst_resm(TFAIL, "write returned with %d", ret);
-}
-
-/*
- * Test wheter write returns with error EINVAL, when the written value
- * is 0xFFFFFFFFFFFFFFFF.
- */
-static void write_einval2_test(int fd)
-{
-	int ret;
-	uint64_t val;
-
-	ret = clear_counter(fd);
-	if (ret == -1) {
-		tst_resm(TBROK, "error clearing counter");
-		return;
-	}
-
-	val = 0xffffffffffffffffLL;
-	ret = write(fd, &val, sizeof(val));
-	if (ret == -1) {
-		if (errno == EINVAL)
-			tst_resm(TPASS, "write failed with EINVAL as expected");
-		else
-			tst_resm(TFAIL | TERRNO,
-				 "write failed (wanted EINVAL)");
-	} else {
-		tst_resm(TFAIL, "write returned with %d", ret);
-	}
-}
-
-/*
- * Test whether readfd is set by select when counter value is
- * non-zero.
- */
-static void readfd_set_test(int fd)
-{
-	int ret;
-	fd_set readfds;
-	struct timeval timeout = { 0, 0 };
-	uint64_t non_zero = 10;
-
-	FD_ZERO(&readfds);
-	FD_SET(fd, &readfds);
-
-	ret = set_counter(fd, non_zero);
-	if (ret == -1) {
-		tst_resm(TBROK, "error setting counter value to %" PRIu64,
-			 non_zero);
-		return;
-	}
-
-	ret = select(fd + 1, &readfds, NULL, NULL, &timeout);
-	if (ret == -1) {
-		/* EINTR cannot occur, since we don't block. */
-		tst_resm(TBROK | TERRNO, "select() failed");
-		return;
-	}
-
-	if (FD_ISSET(fd, &readfds))
-		tst_resm(TPASS, "fd is set in readfds");
-	else
-		tst_resm(TFAIL, "fd is not set in readfds");
-}
-
-/*
- * Test whether readfd is not set by select when counter value is
- * zero.
- */
-static void readfd_not_set_test(int fd)
-{
-	int ret;
-	fd_set readfds;
-	struct timeval timeout = { 0, 0 };
-
-	FD_ZERO(&readfds);
-	FD_SET(fd, &readfds);
-
-	ret = clear_counter(fd);
-	if (ret == -1) {
-		tst_resm(TBROK, "error clearing counter");
-		return;
-	}
-
-	ret = select(fd + 1, &readfds, NULL, NULL, &timeout);
-	if (ret == -1) {
-		/* EINTR cannot occur, since we don't block. */
-		tst_resm(TBROK | TERRNO, "select() failed");
-		return;
-	}
-
-	if (!FD_ISSET(fd, &readfds))
-		tst_resm(TPASS, "fd is not set in readfds");
-	else
-		tst_resm(TFAIL, "fd is set in readfds");
-}
-
-/*
- * Test whether writefd is set by select when counter value is not the
- * maximum counter value.
- */
-static void writefd_set_test(int fd)
-{
-	int ret;
-	fd_set writefds;
-	struct timeval timeout = { 0, 0 };
-	uint64_t non_max = 10;
-
-	FD_ZERO(&writefds);
-	FD_SET(fd, &writefds);
-
-	ret = set_counter(fd, non_max);
-	if (ret == -1) {
-		tst_resm(TBROK, "error setting counter value to %" PRIu64,
-			 non_max);
-		return;
-	}
-
-	ret = select(fd + 1, NULL, &writefds, NULL, &timeout);
-	if (ret == -1) {
-		/* EINTR cannot occur, since we don't block. */
-		tst_resm(TBROK | TERRNO, "select: error getting fd status");
-		return;
-	}
-
-	if (FD_ISSET(fd, &writefds))
-		tst_resm(TPASS, "fd is set in writefds");
-	else
-		tst_resm(TFAIL, "fd is not set in writefds");
-}
-
-/*
- * Test whether writefd is not set by select when counter value is at
- * (UINT64_MAX - 1).
- */
-static void writefd_not_set_test(int fd)
-{
-	int ret;
-	fd_set writefds;
-	struct timeval timeout = { 0, 0 };
-
-	FD_ZERO(&writefds);
-	FD_SET(fd, &writefds);
-
-	ret = set_counter(fd, UINT64_MAX - 1);
-	if (ret == -1) {
-		tst_resm(TBROK, "error setting counter value to UINT64_MAX-1");
-		return;
-	}
-
-	ret = select(fd + 1, NULL, &writefds, NULL, &timeout);
-	if (ret == -1) {
-		/* EINTR cannot occur, since we don't block. */
-		tst_resm(TBROK | TERRNO, "select: error getting fd status");
-		return;
-	}
-
-	if (!FD_ISSET(fd, &writefds))
-		tst_resm(TPASS, "fd is not set in writefds");
-	else
-		tst_resm(TFAIL, "fd is set in writefds");
-}
-
-/*
- * Test whether counter update in child is reflected in the parent.
- */
-static void child_inherit_test(int fd)
-{
-	uint64_t val;
-	pid_t cpid;
-	int ret;
-	int status;
-	uint64_t to_parent = 0xdeadbeef;
-	uint64_t dummy;
-
-	cpid = fork();
-	if (cpid == -1)
-		tst_resm(TBROK | TERRNO, "fork failed");
-	else if (cpid != 0) {
-		ret = wait(&status);
-		if (ret == -1) {
-			tst_resm(TBROK, "error getting child exit status");
-			return;
-		}
-
-		if (WEXITSTATUS(status) == 1) {
-			tst_resm(TBROK, "counter value write not "
-				 "successful in child");
-			return;
-		}
 
-		ret = read(fd, &val, sizeof(val));
-		if (ret == -1) {
-			tst_resm(TBROK | TERRNO, "error reading eventfd");
-			return;
-		}
+	fd = eventfd(EVENT_COUNT, EFD_NONBLOCK);
+	TST_EXP_FD(fd);
 
-		if (val == to_parent)
-			tst_resm(TPASS, "counter value write from "
-				 "child successful");
-		else
-			tst_resm(TFAIL, "counter value write in child "
-				 "failed");
-	} else {
-		/* Child */
-		ret = read(fd, &dummy, sizeof(dummy));
-		if (ret == -1 && errno != EAGAIN) {
-			tst_resm(TWARN | TERRNO, "error clearing counter");
-			exit(1);
-		}
+	SAFE_READ(0, fd, &val, sizeof(val));
+	TST_EXP_EQ_LI(val, EVENT_COUNT);
 
-		ret = write(fd, &to_parent, sizeof(to_parent));
-		if (ret == -1) {
-			tst_resm(TWARN | TERRNO, "error writing eventfd");
-			exit(1);
-		}
+	TST_EXP_FAIL(read(fd, &val, sizeof(val)), EAGAIN);
+	TST_EXP_FAIL(read(fd, &invalid, sizeof(invalid)), EINVAL);
 
-		exit(0);
-	}
+	SAFE_CLOSE(fd);
 }
 
-#ifdef HAVE_IO_SET_EVENTFD
-/*
- * Test whether counter overflow is detected and handled correctly.
- *
- * It is not possible to directly overflow the counter using the
- * write() syscall. Overflows occur when the counter is incremented
- * from kernel space, in an irq context, when it is not possible to
- * block the calling thread of execution.
- *
- * The AIO subsystem internally uses eventfd mechanism for
- * notification of completion of read or write requests. In this test
- * we trigger a counter overflow, by setting the counter value to the
- * max possible value initially. When the AIO subsystem notifies
- * through the eventfd counter, the counter overflows.
- *
- * NOTE: If the the counter starts from an initial value of 0, it will
- * take decades for an overflow to occur. But since we set the initial
- * value to the max possible counter value, we are able to cause it to
- * overflow with a single increment.
- *
- * When the counter overflows, the following are tested
- *   1. Check whether POLLERR event occurs in poll() for the eventfd.
- *   2. Check whether readfd_set/writefd_set is set in select() for the
-        eventfd.
- *   3. The counter value is UINT64_MAX.
- */
-static int trigger_eventfd_overflow(int evfd, int *fd, io_context_t * ctx)
-{
-	int ret;
-	struct iocb iocb;
-	struct iocb *iocbap[1];
-	struct io_event ioev;
-	static char buf[4 * 1024];
-
-	*ctx = 0;
-	ret = io_setup(16, ctx);
-	if (ret < 0) {
-		errno = -ret;
-		if (errno == ENOSYS) {
-			tst_brkm(TCONF | TERRNO, cleanup,
-				 "io_setup(): AIO not supported by kernel");
-		}
-
-		tst_resm(TINFO | TERRNO, "io_setup error");
-		return -1;
-	}
-
-	*fd = open("testfile", O_RDWR | O_CREAT, 0644);
-	if (*fd == -1) {
-		tst_resm(TINFO | TERRNO, "open(testfile) failed");
-		goto err_io_destroy;
-	}
-
-	ret = set_counter(evfd, UINT64_MAX - 1);
-	if (ret == -1) {
-		tst_resm(TINFO, "error setting counter to UINT64_MAX-1");
-		goto err_close_file;
-	}
-
-	io_prep_pwrite(&iocb, *fd, buf, sizeof(buf), 0);
-	io_set_eventfd(&iocb, evfd);
-
-	iocbap[0] = &iocb;
-	ret = io_submit(*ctx, 1, iocbap);
-	if (ret < 0) {
-		errno = -ret;
-		tst_resm(TINFO | TERRNO, "error submitting iocb");
-		goto err_close_file;
-	}
-
-	ret = io_getevents(*ctx, 1, 1, &ioev, NULL);
-	if (ret < 0) {
-		errno = -ret;
-		tst_resm(TINFO | TERRNO, "error waiting for event");
-		goto err_close_file;
-	}
-
-	return 0;
-
-err_close_file:
-	close(*fd);
-
-err_io_destroy:
-	io_destroy(*ctx);
-
-	return -1;
-}
-
-static void cleanup_overflow(int fd, io_context_t ctx)
-{
-	close(fd);
-	io_destroy(ctx);
-}
-
-static void overflow_select_test(int evfd)
-{
-	struct timeval timeout = { 10, 0 };
-	fd_set readfds;
-	int fd;
-	io_context_t ctx;
-	int ret;
-
-	ret = trigger_eventfd_overflow(evfd, &fd, &ctx);
-	if (ret == -1) {
-		tst_resm(TBROK, "error triggering eventfd overflow");
-		return;
-	}
-
-	FD_ZERO(&readfds);
-	FD_SET(evfd, &readfds);
-	ret = select(evfd + 1, &readfds, NULL, NULL, &timeout);
-	if (ret == -1)
-		tst_resm(TBROK | TERRNO,
-			 "error getting evfd status with select");
-	else {
-		if (FD_ISSET(evfd, &readfds))
-			tst_resm(TPASS, "read fd set as expected");
-		else
-			tst_resm(TFAIL, "read fd not set");
-	}
-	cleanup_overflow(fd, ctx);
-}
-
-static void overflow_poll_test(int evfd)
-{
-	struct pollfd pollfd;
-	int fd;
-	io_context_t ctx;
-	int ret;
-
-	ret = trigger_eventfd_overflow(evfd, &fd, &ctx);
-	if (ret == -1) {
-		tst_resm(TBROK, "error triggering eventfd overflow");
-		return;
-	}
-
-	pollfd.fd = evfd;
-	pollfd.events = POLLIN;
-	pollfd.revents = 0;
-	ret = poll(&pollfd, 1, 10000);
-	if (ret == -1)
-		tst_resm(TBROK | TERRNO, "error getting evfd status with poll");
-	else {
-		if (pollfd.revents & POLLERR)
-			tst_resm(TPASS, "POLLERR occurred as expected");
-		else
-			tst_resm(TFAIL, "POLLERR did not occur");
-	}
-	cleanup_overflow(fd, ctx);
-}
-
-static void overflow_read_test(int evfd)
-{
-	uint64_t count;
-	io_context_t ctx;
-	int fd;
-	int ret;
-
-	ret = trigger_eventfd_overflow(evfd, &fd, &ctx);
-	if (ret == -1) {
-		tst_resm(TBROK, "error triggering eventfd overflow");
-		return;
-	}
-
-	ret = read(evfd, &count, sizeof(count));
-	if (ret == -1)
-		tst_resm(TBROK | TERRNO, "error reading eventfd");
-	else {
-
-		if (count == UINT64_MAX)
-			tst_resm(TPASS, "overflow occurred as expected");
-		else
-			tst_resm(TFAIL, "overflow did not occur");
-	}
-	cleanup_overflow(fd, ctx);
-}
-#else
-static void overflow_select_test(int evfd)
-{
-	tst_resm(TCONF, "eventfd support is not available in AIO subsystem");
-}
-
-static void overflow_poll_test(int evfd)
-{
-	tst_resm(TCONF, "eventfd support is not available in AIO subsystem");
-}
-
-static void overflow_read_test(int evfd)
-{
-	tst_resm(TCONF, "eventfd support is not available in AIO subsystem");
-}
-#endif
-
-int main(int argc, char **argv)
-{
-	int lc;
-	int fd;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int ret;
-		uint64_t einit = 10;
-
-		tst_count = 0;
-
-		fd = myeventfd(einit, 0);
-		if (fd == -1)
-			tst_brkm(TBROK | TERRNO, CLEANUP,
-				 "error creating eventfd");
-
-		ret = fcntl(fd, F_SETFL, O_NONBLOCK);
-		if (ret == -1)
-			tst_brkm(TBROK | TERRNO, CLEANUP,
-				 "error setting non-block mode");
-
-		read_test(fd, einit);
-		read_eagain_test(fd);
-		write_test(fd);
-		write_eagain_test(fd);
-		read_einval_test(fd);
-		write_einval_test(fd);
-		write_einval2_test(fd);
-		readfd_set_test(fd);
-		readfd_not_set_test(fd);
-		writefd_set_test(fd);
-		writefd_not_set_test(fd);
-		child_inherit_test(fd);
-		overflow_select_test(fd);
-		overflow_poll_test(fd);
-		overflow_read_test(fd);
-
-		close(fd);
-	}
-
-	cleanup();
-
-	tst_exit();
-}
-
-static void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
-#else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
-}
-#endif
+static struct tst_test test = {
+	.test_all = run,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_EVENTFD",
+		NULL
+	},
+};
diff --git a/testcases/kernel/syscalls/eventfd/eventfd02.c b/testcases/kernel/syscalls/eventfd/eventfd02.c
new file mode 100644
index 000000000..cf980fb96
--- /dev/null
+++ b/testcases/kernel/syscalls/eventfd/eventfd02.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+/*\
+ * [Description]
+ *
+ * Verify write operation for eventfd fail with:
+ *
+ * - EAGAIN when counter is zero on non blocking fd
+ * - EINVAL when buffer size is less than 8 bytes, or if an attempt is made to
+ *	write the value 0xffffffffffffffff
+ */
+
+#include <stdlib.h>
+#include <sys/eventfd.h>
+#include "tst_test.h"
+
+static void run(void)
+{
+	int fd;
+	uint64_t val = 12;
+	uint64_t buf;
+	uint32_t invalid;
+
+	fd = eventfd(0, EFD_NONBLOCK);
+	TST_EXP_FD(fd);
+
+	SAFE_WRITE(0, fd, &val, sizeof(val));
+	SAFE_READ(0, fd, &buf, sizeof(buf));
+	TST_EXP_EQ_LI(buf, val);
+
+	val = UINT64_MAX - 1;
+	SAFE_WRITE(0, fd, &val, sizeof(val));
+	TST_EXP_FAIL(write(fd, &val, sizeof(val)), EAGAIN);
+	TST_EXP_FAIL(write(fd, &invalid, sizeof(invalid)), EINVAL);
+
+	val = 0xffffffffffffffffLL;
+	TST_EXP_FAIL(write(fd, &val, sizeof(val)), EINVAL);
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_EVENTFD",
+		NULL
+	},
+};
diff --git a/testcases/kernel/syscalls/eventfd/eventfd03.c b/testcases/kernel/syscalls/eventfd/eventfd03.c
new file mode 100644
index 000000000..4b331c2ec
--- /dev/null
+++ b/testcases/kernel/syscalls/eventfd/eventfd03.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+/*\
+ * [Description]
+ *
+ * Test whether readfd is set by select() when eventfd() counter value is
+ * non-zero, then check if readfd is not set when eventfd() counter value is
+ * zero.
+ */
+
+#include <stdlib.h>
+#include <sys/eventfd.h>
+#include "tst_test.h"
+
+static void run(void)
+{
+	int fd;
+	uint64_t val;
+	fd_set readfds;
+	uint64_t non_zero = 10;
+	struct timeval timeout = { 0, 0 };
+
+	fd = eventfd(0, EFD_NONBLOCK);
+	TST_EXP_FD(fd);
+
+	FD_ZERO(&readfds);
+	FD_SET(fd, &readfds);
+
+	SAFE_WRITE(0, fd, &non_zero, sizeof(non_zero));
+	TEST(select(fd + 1, &readfds, NULL, NULL, &timeout));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "select");
+
+	TST_EXP_EQ_LI(FD_ISSET(fd, &readfds), 1);
+
+	SAFE_READ(0, fd, &val, sizeof(val));
+	TEST(select(fd + 1, &readfds, NULL, NULL, &timeout));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "select");
+
+	TST_EXP_EQ_LI(FD_ISSET(fd, &readfds), 0);
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_EVENTFD",
+		NULL
+	},
+};
diff --git a/testcases/kernel/syscalls/eventfd/eventfd04.c b/testcases/kernel/syscalls/eventfd/eventfd04.c
new file mode 100644
index 000000000..cf822f02c
--- /dev/null
+++ b/testcases/kernel/syscalls/eventfd/eventfd04.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+/*\
+ * [Description]
+ *
+ * Test whether writefd is set by select() when eventfd() counter value is
+ * not the maximum value, then check if writefd is not set when eventfd()
+ * counter value is maximum value.
+ */
+
+#include <stdlib.h>
+#include <sys/eventfd.h>
+#include "tst_test.h"
+
+static void run(void)
+{
+	int fd;
+	fd_set writefds;
+	uint64_t val;
+	uint64_t non_max = 10;
+	uint64_t max = UINT64_MAX - 1;
+	struct timeval timeout = { 0, 0 };
+
+	fd = eventfd(0, EFD_NONBLOCK);
+	TST_EXP_FD(fd);
+
+	FD_ZERO(&writefds);
+	FD_SET(fd, &writefds);
+
+	SAFE_WRITE(0, fd, &non_max, sizeof(non_max));
+	TEST(select(fd + 1, NULL, &writefds, NULL, &timeout));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "select");
+
+	TST_EXP_EQ_LI(FD_ISSET(fd, &writefds), 1);
+
+	SAFE_READ(0, fd, &val, sizeof(val));
+	SAFE_WRITE(0, fd, &max, sizeof(max));
+
+	TEST(select(fd + 1, NULL, &writefds, NULL, &timeout));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "select");
+
+	TST_EXP_EQ_LI(FD_ISSET(fd, &writefds), 0);
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_EVENTFD",
+		NULL
+	},
+};
diff --git a/testcases/kernel/syscalls/eventfd/eventfd05.c b/testcases/kernel/syscalls/eventfd/eventfd05.c
new file mode 100644
index 000000000..20a3598cf
--- /dev/null
+++ b/testcases/kernel/syscalls/eventfd/eventfd05.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+/*\
+ * [Description]
+ *
+ * Test whether eventfd() counter update in child is reflected in the parent.
+ */
+
+#include <stdlib.h>
+#include <sys/eventfd.h>
+#include "tst_test.h"
+
+static void run(void)
+{
+	int fd;
+	uint64_t val;
+	uint64_t to_parent = 0xdeadbeef;
+
+	fd = eventfd(0, EFD_NONBLOCK);
+	TST_EXP_FD(fd);
+
+	if (!SAFE_FORK()) {
+		SAFE_WRITE(0, fd, &to_parent, sizeof(to_parent));
+		exit(0);
+	}
+
+	tst_reap_children();
+
+	SAFE_READ(0, fd, &val, sizeof(val));
+	TST_EXP_EQ_LI(val, to_parent);
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_EVENTFD",
+		NULL
+	},
+};
diff --git a/testcases/kernel/syscalls/eventfd/eventfd06.c b/testcases/kernel/syscalls/eventfd/eventfd06.c
new file mode 100644
index 000000000..505d31756
--- /dev/null
+++ b/testcases/kernel/syscalls/eventfd/eventfd06.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+/*\
+ * [Description]
+ *
+ * Test whether counter overflow is detected and handled correctly.
+ *
+ * It is not possible to directly overflow the counter using the
+ * write() syscall. Overflows occur when the counter is incremented
+ * from kernel space, in an irq context, when it is not possible to
+ * block the calling thread of execution.
+ *
+ * The AIO subsystem internally uses eventfd mechanism for
+ * notification of completion of read or write requests. In this test
+ * we trigger a counter overflow, by setting the counter value to the
+ * max possible value initially. When the AIO subsystem notifies
+ * through the eventfd counter, the counter overflows.
+ *
+ * NOTE: If the counter starts from an initial value of 0, it will
+ * take decades for an overflow to occur. But since we set the initial
+ * value to the max possible counter value, we are able to cause it to
+ * overflow with a single increment.
+ *
+ * When the counter overflows, the following are tested
+ *	1. Check whether POLLERR event occurs in poll() for the eventfd.
+ *	2. Check whether readfd_set/writefd_set is set in select() for the
+ *		eventfd.
+ *	3. The counter value is UINT64_MAX.
+ */
+
+#include "tst_test.h"
+
+#ifdef HAVE_LIBAIO
+#ifdef HAVE_IO_SET_EVENTFD
+
+#include <poll.h>
+#include <libaio.h>
+#include <stdlib.h>
+#include <sys/eventfd.h>
+
+#define MAXEVENTS 16
+#define BUFSIZE 1024
+
+static int fd;
+static int evfd;
+static io_context_t ctx;
+
+static void async_write(void)
+{
+	struct iocb iocb;
+	struct iocb *iocbap[1];
+	struct io_event ioev;
+	static char buf[BUFSIZE];
+
+	memset(buf, 1, BUFSIZE);
+
+	io_prep_pwrite(&iocb, fd, buf, sizeof(buf), 0);
+	io_set_eventfd(&iocb, evfd);
+
+	iocbap[0] = &iocb;
+	TEST(io_submit(ctx, 1, iocbap));
+	if (TST_RET < 0)
+		tst_brk(TBROK, "io_submit() failed: %s", tst_strerrno(-TST_RET));
+
+	TEST(io_getevents(ctx, 1, 1, &ioev, NULL));
+	if (TST_RET < 0)
+		tst_brk(TBROK, "io_getevents() failed: %s", tst_strerrno(-TST_RET));
+}
+
+static void clear_counter(void)
+{
+	uint64_t val;
+	uint64_t max =  UINT64_MAX - 1;
+
+	TEST(read(evfd, &val, sizeof(val)));
+	if (TST_RET == -1 && TST_ERR != EAGAIN)
+		tst_brk(TBROK | TERRNO, "read");
+
+	SAFE_WRITE(0, evfd, &max, sizeof(max));
+}
+
+static void test_select(void)
+{
+	fd_set readfds;
+	uint64_t count;
+	struct timeval timeout = { 10, 0 };
+
+	clear_counter();
+	async_write();
+
+	FD_ZERO(&readfds);
+	FD_SET(fd, &readfds);
+
+	tst_res(TINFO, "Checking if select() detects counter overflow");
+
+	TEST(select(fd + 1, NULL, &readfds, NULL, &timeout));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "select");
+
+	TST_EXP_EQ_LI(FD_ISSET(fd, &readfds), 1);
+
+	SAFE_READ(0, evfd, &count, sizeof(count));
+	TST_EXP_EQ_LI(count, UINT64_MAX);
+}
+
+static void test_poll(void)
+{
+	uint64_t count;
+	struct pollfd pollfd;
+
+	clear_counter();
+	async_write();
+
+	pollfd.fd = evfd;
+	pollfd.events = POLLIN;
+	pollfd.revents = 0;
+
+	tst_res(TINFO, "Checking if poll() detects counter overflow");
+
+	TEST(poll(&pollfd, 1, 10000));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "poll");
+
+	TST_EXP_EQ_LI(pollfd.revents & POLLERR, POLLERR);
+
+	SAFE_READ(0, evfd, &count, sizeof(count));
+	TST_EXP_EQ_LI(count, UINT64_MAX);
+}
+
+static void setup(void)
+{
+	TEST(io_setup(MAXEVENTS, &ctx));
+	if (TST_RET < 0)
+		tst_brk(TBROK, "io_setup() failed: %s", tst_strerrno(-TST_RET));
+
+	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0644);
+	evfd = eventfd(0, EFD_NONBLOCK);
+	TST_EXP_FD(evfd);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(evfd);
+	io_destroy(ctx);
+}
+
+static void run(void)
+{
+	test_select();
+	test_poll();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_EVENTFD",
+		NULL
+	},
+};
+
+#else /* HAVE_IO_SET_EVENTFD */
+TST_TEST_TCONF("eventfd support is not available in AIO subsystem");
+#endif
+#else /* HAVE_LIBAIO */
+TST_TEST_TCONF("libaio is not available");
+#endif
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
