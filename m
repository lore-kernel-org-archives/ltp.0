Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD27FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 08:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777366316; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=VvnLxThSNnd32T15R9vJILUZ+GQMdAnZ3J67AyAeN+Q=;
 b=Z8rvG6YuRVUYmxxE3fQ3v+KHGNETwVF8xM105CmTPPOr6WK1cpzNxuTyngvjFgnbm3myk
 RuYoStkn8RtY6Y3Q+XKehv3GcnXZs8oDoMT/4i/fR0H2VMOQziXAn6D7UznBz8cO+9Plyro
 rC9GMr1pyF92LsEhB8H92itPOE/FaSs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8CD53E49E0
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 10:51:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 572403E2542
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:51:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A3B9F600B49
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777366288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/RHUsHxatNrN8jGUiwY4DrPSMRmv5gRYo2RRpdUiyiE=;
 b=aOyfx+IgIMPc3YE3G9B2ACuagQ+RexhGsmXd1IJHua4PT59yo5vPix5ogAH95b69W2260e
 2+1B6vBBKEJpYmjd4EMDm88D3fB7PTVh74XEaVBtkgBCwGMlGSlsyezx830SguXytV+2sO
 AoLFkH9M1oCqYiHoyQn4YzuYpUw2NJo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-BP5bvC1KPT6ACIbLcOFjnQ-1; Tue, 28 Apr 2026 04:51:27 -0400
X-MC-Unique: BP5bvC1KPT6ACIbLcOFjnQ-1
X-Mimecast-MFC-AGG-ID: BP5bvC1KPT6ACIbLcOFjnQ_1777366286
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50faf575af4so64179811cf.0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 01:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777366286; x=1777971086;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/RHUsHxatNrN8jGUiwY4DrPSMRmv5gRYo2RRpdUiyiE=;
 b=TVNY9ZwGrdT2lxHTEwp9zO1SawOiMl8bDh/Kk/Nmyvha3hydc+DgnxPD2VmS8BUkFK
 dI7oePrTlyxVKm1PglBU7Q1gnSLZagu8QTOPPrDMH5gg+esZZbhsNLiNPLJRdQZKuFKj
 kAPEynVR/220VuePb7xknnHkOArODMRFH8O/bMXexqk3QboikKYLJ+9ze6uFWFoqsA8C
 Rh7MDoYl3kJ3BQPW1E1EgcHnyddOL122gfPvAhNIAPn5xiqgLhT7kEh97OGf7rOl7ofd
 H8hEDlD9H48up+AzXBHPOcWY3YNuY0MvtfdC3TW3W7LVYObL2TKnq4ou/THrOvu59WMW
 iKdA==
X-Gm-Message-State: AOJu0YyZuvrd+QM94rR4KaTz4H/fU5EuHfPF7g83QmsQ493ZKBTsF+5B
 59VY+2lhIe9fJqUl8ZjPdHDAerUv5nHkKfLRi2DdGVLOCQbd4JF3NI5ORXR2Z4LeW5QTUiZd9mc
 maXFgVIR2r9fTzgdvoBKbyDepfToj9sMm6ysZDYWMuxpthMxdF+nR
X-Gm-Gg: AeBDietjxGVA4E7IOQlOKKbE1SO0PUdaLrqORAi1i5ib6vqQHykwrRDzDaB0G8IO/V8
 TnggmFl1oXFpMOVJQIh5YRSlO5KZKUyQBGUsszHWBhQPXhEeSu7YS4XeezgFPu6ubX5UPa5COAU
 4QAkcIOZJdMcpCCFnDeg4+7i3gq5AeFeVnksgtws4M/QxYZEuuMxlyqoGn/HlEvKu7+vgjfYB4L
 2NvCZ5j/ixywP3aYynAFc+i34X+mYLY2XGSnS2qx/6ahKumliK7hvkN8kX1smLAIk6DyjdEFRUX
 xZ1W0nSqxM1S5+569+DiNkqKwbT39AB4ZiKb/69NVZ/sXGuVeFDPVIzj17rj4SJ6b3l4hF7ivOp
 TgwcYoi4APNp0ISJCxYwPn2CnC92+lGUk4PmLB3P9s6kN
X-Received: by 2002:a05:622a:4c87:b0:50d:a6a0:8f09 with SMTP id
 d75a77b69052e-5100e1a188cmr31403451cf.39.1777366286148; 
 Tue, 28 Apr 2026 01:51:26 -0700 (PDT)
X-Received: by 2002:a05:622a:4c87:b0:50d:a6a0:8f09 with SMTP id
 d75a77b69052e-5100e1a188cmr31403111cf.39.1777366285508; 
 Tue, 28 Apr 2026 01:51:25 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5100da76364sm12998481cf.11.2026.04.28.01.51.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Apr 2026 01:51:24 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:51:21 +0200
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260428085121.qeeka7axie3rervl@lida.tpb.lab.eng.brq.redhat.com>
References: <20260423144431.ozcixhmhki3aeigw@lida.tpb.lab.eng.brq.redhat.com>
 <69f0714b.050a0220.16df6e.a14d@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <69f0714b.050a0220.16df6e.a14d@mx.google.com>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I7_IIK3b5dtfm0RG2pFPjG2Jtx9Xfm2IBKJzSU95pbw_1777366286
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers]   [PATCH] Make userfaultfd0{1, 3,
 4} LTP tests valgrind compatible
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: valgrind-developers@lists.sourceforge.net,
 Martin Cermak via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On  Tue  2026-04-28  08:35 , Andrea Cervesato via Valgrind-developers wrote:
> Hi Martin,
> 
> please re-send the new patch version so we can review it properly :-)


Hi Andrea,

the patch is below.  It adds 6 new tests.  New tests are easy to
text-diff against their originals.  The only difference is that
new tests use fork() or clone() instead of threads to handle the
page fault.  Please review:


From 693f3015d39b39e2c263aac57c183e3e4cf7df4d Mon Sep 17 00:00:00 2001
From: Martin Cermak <mcermak@redhat.com>
Date: Thu, 23 Apr 2026 15:51:10 +0200
Subject: [PATCH] Provide Valgrind-compatible userfaultfd tests

The userfaultfd tests use threads.  Threads are executed serially
in Valgrind, but parallelism is important for userfaultfd tests.
When a page fault happens in parent thread, kernel stops it, and
waits for the handler thread to handle the page fault. That said,
userfaultfd tests 01 - 06 stall in Valgrind.

This update comes with second set of userfaultfd tests 07 - 12.
These additional tests use fork() or clone(), thus a separate
process instead of threads.  Support for clone() is also limited
in Valgrind. For that reason only tests 07, 09 and 10 are "Valgrind
compatible".  But it's a test coverage improvement.

Valgrind can filter LTP tests on the per test binary basis.  That's
why this update adds separate tests 07 - 12.

Assisted-by: Anthropic Claude
Reviewed-by: Martin Cermak <mcermak@redhat.com>

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 05b322c1c..b33de6657 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -121,6 +121,14 @@ static inline int getcpu(unsigned *cpu, unsigned *node)
 # define CLONE_FS	0x00000200
 #endif
 
+#ifndef CLONE_FILES
+# define CLONE_FILES	0x00000400
+#endif
+
+#ifndef CLONE_SIGHAND
+# define CLONE_SIGHAND	0x00000800
+#endif
+
 #ifndef CLONE_PIDFD
 # define CLONE_PIDFD	0x00001000
 #endif
diff --git a/testcases/kernel/syscalls/userfaultfd/.gitignore b/testcases/kernel/syscalls/userfaultfd/.gitignore
index bc32fdf3b..59d28c6f3 100644
--- a/testcases/kernel/syscalls/userfaultfd/.gitignore
+++ b/testcases/kernel/syscalls/userfaultfd/.gitignore
@@ -4,3 +4,9 @@
 /userfaultfd04
 /userfaultfd05
 /userfaultfd06
+/userfaultfd07
+/userfaultfd08
+/userfaultfd09
+/userfaultfd10
+/userfaultfd11
+/userfaultfd12
diff --git a/testcases/kernel/syscalls/userfaultfd/Makefile b/testcases/kernel/syscalls/userfaultfd/Makefile
index 3252e47df..e4ed56b4b 100644
--- a/testcases/kernel/syscalls/userfaultfd/Makefile
+++ b/testcases/kernel/syscalls/userfaultfd/Makefile
@@ -17,3 +17,6 @@ userfaultfd03: CFLAGS += -pthread
 userfaultfd04: CFLAGS += -pthread
 userfaultfd05: CFLAGS += -pthread
 userfaultfd06: CFLAGS += -pthread
+# Tests 07-12: Valgrind-compatible variants using fork/clone
+# Tests 07, 09, 10: fork-based (no pthread needed)
+# Tests 08, 11, 12: clone-based (no pthread needed)
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
new file mode 100644
index 000000000..bebf0e921
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different process (using fork instead of threads for Valgrind compatibility).
+ */
+
+#include <poll.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/userfaultfd.h"
+
+#define BEFORE_5_11 1
+#define AFTER_5_11 2
+#define DESC(x) .flags = x, .desc = #x
+
+static struct tcase {
+	int flags;
+	const char *desc;
+	int kver;
+} tcases[] = {
+	{ DESC(O_CLOEXEC | O_NONBLOCK) },
+	{ DESC(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY),  .kver = AFTER_5_11, },
+};
+
+static int page_size;
+static char *page;
+static void *copy_page;
+static int uffd;
+static int kver;
+
+static void setup(void)
+{
+	if (tst_kvercmp(5, 11, 0) >= 0)
+		kver = AFTER_5_11;
+	else
+		kver = BEFORE_5_11;
+}
+
+static void set_pages(void)
+{
+	page_size = sysconf(_SC_PAGE_SIZE);
+	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	copy_page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void reset_pages(void)
+{
+	SAFE_MUNMAP(page, page_size);
+	SAFE_MUNMAP(copy_page, page_size);
+}
+
+static void *pagefault_handler(void)
+{
+	static struct uffd_msg msg;
+	struct uffdio_copy uffdio_copy = {};
+
+	struct pollfd pollfd;
+	int nready;
+
+	pollfd.fd = uffd;
+	pollfd.events = POLLIN;
+	nready = poll(&pollfd, 1, -1);
+	if (nready == -1)
+		tst_brk(TBROK | TERRNO, "Error on poll");
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event != UFFD_EVENT_PAGEFAULT)
+		tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	memset(copy_page, 'X', page_size);
+
+	uffdio_copy.src = (unsigned long) copy_page;
+
+	uffdio_copy.dst = (unsigned long) msg.arg.pagefault.address
+			& ~(page_size - 1);
+	uffdio_copy.len = page_size;
+	SAFE_IOCTL(uffd, UFFDIO_COPY, &uffdio_copy);
+
+	close(uffd);
+	return NULL;
+}
+
+static void run(unsigned int i)
+{
+	pid_t pid;
+	struct uffdio_api uffdio_api = {};
+	struct uffdio_register uffdio_register;
+	struct tcase *tc = &tcases[i];
+
+	if (tc->kver == AFTER_5_11 && kver == BEFORE_5_11)
+		tst_brk(TCONF, "%s requires kernel >= 5.11", tc->desc);
+
+	set_pages();
+
+	uffd = SAFE_USERFAULTFD(tc->flags, false);
+
+	uffdio_api.api = UFFD_API;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	uffdio_register.range.start = (unsigned long) page;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		pagefault_handler();
+		_exit(0);
+	}
+
+	char c = page[0xf];
+
+	if (c == 'X')
+		tst_res(TPASS, "Pagefault handled!");
+	else
+		tst_res(TFAIL, "Pagefault not handled!");
+
+	SAFE_WAITPID(pid, NULL, 0);
+	reset_pages();
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c
new file mode 100644
index 000000000..f6bde86cc
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different process (using clone with CLONE_VM instead of threads
+ * for Valgrind compatibility) using UFFDIO_MOVE.
+ */
+
+#include "config.h"
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_clone.h"
+#include "lapi/sched.h"
+#include "lapi/userfaultfd.h"
+
+#define CHILD_STACK_SIZE (1024 * 1024)
+
+static int page_size;
+static char *page;
+static void *move_page;
+static int uffd;
+static void *child_stack;
+
+static void set_pages(void)
+{
+	page_size = sysconf(_SC_PAGE_SIZE);
+	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	move_page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void reset_pages(void)
+{
+	SAFE_MUNMAP(page, page_size);
+	/*
+	 * After UFFDIO_MOVE, move_page is invalid and should not be unmapped.
+	 * The kernel has already removed the mapping during the move operation.
+	 */
+}
+
+static int pagefault_handler(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	struct uffd_msg msg;
+	struct uffdio_move uffdio_move = {};
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event != UFFD_EVENT_PAGEFAULT)
+		tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	memset(move_page, 'X', page_size);
+
+	uffdio_move.src = (unsigned long) move_page;
+
+	uffdio_move.dst = (unsigned long) msg.arg.pagefault.address
+			& ~(page_size - 1);
+	uffdio_move.len = page_size;
+	SAFE_IOCTL(uffd, UFFDIO_MOVE, &uffdio_move);
+
+	close(uffd);
+	return 0;
+}
+
+static void run(void)
+{
+	pid_t pid;
+	struct uffdio_api uffdio_api = {};
+	struct uffdio_register uffdio_register;
+
+	set_pages();
+
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC, false);
+
+	uffdio_api.api = UFFD_API;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	uffdio_register.range.start = (unsigned long) page;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	pid = ltp_clone(CLONE_VM | CLONE_FILES | CLONE_FS | CLONE_SIGHAND | SIGCHLD,
+			pagefault_handler, NULL, CHILD_STACK_SIZE, child_stack);
+	if (pid == -1)
+		tst_brk(TBROK | TERRNO, "ltp_clone failed");
+
+	char c = page[0xf];
+
+	if (c == 'X')
+		tst_res(TPASS, "Pagefault handled via UFFDIO_MOVE");
+	else
+		tst_res(TFAIL, "Pagefault not handled via UFFDIO_MOVE");
+
+	SAFE_WAITPID(pid, NULL, 0);
+	reset_pages();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "6.8",
+	.forks_child = 1,
+	.bufs = (struct tst_buffers []) {
+		{&child_stack, .size = CHILD_STACK_SIZE},
+		{},
+	},
+};
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd09.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd09.c
new file mode 100644
index 000000000..e1190a4ce
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd09.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different process (using fork instead of threads for Valgrind compatibility)
+ * using /dev/userfaultfd instead of syscall, using USERFAULTFD_IOC_NEW ioctl to create
+ * the uffd & UFFDIO_COPY.
+ */
+
+#include "config.h"
+#include <poll.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/userfaultfd.h"
+
+static int page_size;
+static char *page;
+static void *copy_page;
+static int uffd;
+
+static void setup(void)
+{
+	if (access("/dev/userfaultfd", F_OK) != 0) {
+		int res = (tst_kvercmp(6, 1, 0) < 0) ? TCONF : TBROK;
+
+		tst_brk(res, "/dev/userfaultfd not found");
+	}
+}
+
+static int open_userfaultfd(int flags)
+{
+	int fd, fd2;
+
+	fd = SAFE_OPEN("/dev/userfaultfd", O_RDWR);
+
+	fd2 = SAFE_IOCTL(fd, USERFAULTFD_IOC_NEW, flags);
+
+	SAFE_CLOSE(fd);
+
+	return fd2;
+}
+
+static void set_pages(void)
+{
+	page_size = sysconf(_SC_PAGE_SIZE);
+	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	copy_page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void reset_pages(void)
+{
+	SAFE_MUNMAP(page, page_size);
+	SAFE_MUNMAP(copy_page, page_size);
+}
+
+static void *pagefault_handler(void)
+{
+	static struct uffd_msg msg;
+	struct uffdio_copy uffdio_copy = {};
+
+	struct pollfd pollfd;
+	int nready;
+
+	pollfd.fd = uffd;
+	pollfd.events = POLLIN;
+	nready = poll(&pollfd, 1, -1);
+	if (nready == -1)
+		tst_brk(TBROK | TERRNO, "Error on poll");
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event != UFFD_EVENT_PAGEFAULT)
+		tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	memset(copy_page, 'X', page_size);
+
+	uffdio_copy.src = (unsigned long) copy_page;
+
+	uffdio_copy.dst = (unsigned long) msg.arg.pagefault.address
+			& ~(page_size - 1);
+	uffdio_copy.len = page_size;
+	SAFE_IOCTL(uffd, UFFDIO_COPY, &uffdio_copy);
+
+	close(uffd);
+	return NULL;
+}
+
+static void run(void)
+{
+	pid_t pid;
+	struct uffdio_api uffdio_api = {};
+	struct uffdio_register uffdio_register;
+
+	set_pages();
+
+	uffd = open_userfaultfd(O_CLOEXEC | O_NONBLOCK);
+
+	uffdio_api.api = UFFD_API;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	uffdio_register.range.start = (unsigned long) page;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		pagefault_handler();
+		_exit(0);
+	}
+
+	char c = page[0xf];
+
+	if (c == 'X')
+		tst_res(TPASS, "Pagefault handled via /dev/userfaultfd");
+	else
+		tst_res(TFAIL, "Pagefault not handled via /dev/userfaultfd");
+
+	SAFE_WAITPID(pid, NULL, 0);
+	reset_pages();
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.test_all = run,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USERFAULTFD=y",
+		NULL
+	},
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd10.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd10.c
new file mode 100644
index 000000000..8e9bd0b0c
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd10.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different process (using fork instead of threads for Valgrind compatibility)
+ * using UFFDIO_ZEROPAGE.
+ */
+
+#include "config.h"
+#include <poll.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/userfaultfd.h"
+
+static int page_size;
+static char *page;
+static int uffd;
+
+static void set_pages(void)
+{
+	page_size = sysconf(_SC_PAGE_SIZE);
+	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void reset_pages(void)
+{
+	SAFE_MUNMAP(page, page_size);
+}
+
+static void *pagefault_handler(void)
+{
+	static struct uffd_msg msg;
+	struct uffdio_zeropage uffdio_zeropage = {};
+
+	struct pollfd pollfd;
+	int nready;
+
+	pollfd.fd = uffd;
+	pollfd.events = POLLIN;
+	nready = poll(&pollfd, 1, -1);
+	if (nready == -1)
+		tst_brk(TBROK | TERRNO, "Error on poll");
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event != UFFD_EVENT_PAGEFAULT)
+		tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	uffdio_zeropage.range.start	= msg.arg.pagefault.address
+					& ~(page_size - 1);
+	uffdio_zeropage.range.len	= page_size;
+
+	SAFE_IOCTL(uffd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
+
+	close(uffd);
+	return NULL;
+}
+
+static void run(void)
+{
+	pid_t pid;
+	struct uffdio_api uffdio_api = {};
+	struct uffdio_register uffdio_register;
+
+	set_pages();
+
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+
+	uffdio_api.api = UFFD_API;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	uffdio_register.range.start = (unsigned long) page;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		pagefault_handler();
+		_exit(0);
+	}
+
+	for (int i = 0; i < page_size; i++) {
+		if (page[i] != 0) {
+			tst_res(TFAIL, "page[%d]=0x%x not zero", i, page[i]);
+			return;
+		}
+	}
+
+	tst_res(TPASS, "Pagefault handled with UFFDIO_ZEROPAGE");
+
+	SAFE_WAITPID(pid, NULL, 0);
+	reset_pages();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd11.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd11.c
new file mode 100644
index 000000000..52590d117
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd11.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different process (using clone with CLONE_VM instead of threads
+ * for Valgrind compatibility) testing UFFDIO_WRITEPROTECT_MODE_WP.
+ */
+
+#include "config.h"
+#include <poll.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/sched.h"
+#include "lapi/userfaultfd.h"
+
+static int page_size;
+static char *page;
+static int uffd;
+static volatile int wp_fault_seen;
+
+static void set_pages(void)
+{
+	page_size = sysconf(_SC_PAGE_SIZE);
+	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	memset(page, 0, page_size);
+}
+
+static void reset_pages(void)
+{
+	SAFE_MUNMAP(page, page_size);
+}
+
+static void pagefault_handler(void)
+{
+	struct uffd_msg msg;
+	struct uffdio_writeprotect uffdio_writeprotect = {};
+
+	struct pollfd pollfd;
+	int nready;
+
+	pollfd.fd = uffd;
+	pollfd.events = POLLIN;
+	nready = poll(&pollfd, 1, -1);
+	if (nready == -1)
+		tst_brk(TBROK | TERRNO, "Error on poll");
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event != UFFD_EVENT_PAGEFAULT)
+		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	if (!(msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) ||
+	    !(msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)) {
+		tst_brk(TFAIL,
+			"Expected WP+WRITE fault but flags=%lx",
+			(unsigned long)msg.arg.pagefault.flags);
+	}
+
+	/* While the WP fault is pending, the write must NOT be visible. */
+	if (page[0xf] != 0)
+		tst_brk(TFAIL,
+			"Write became visible while page was write-protected!");
+
+	wp_fault_seen = 1;
+
+	/* Resolve the fault by clearing WP so the writer can resume. */
+	uffdio_writeprotect.range.start	= msg.arg.pagefault.address & ~(page_size - 1);
+	uffdio_writeprotect.range.len	= page_size;
+
+	SAFE_IOCTL(uffd, UFFDIO_WRITEPROTECT, &uffdio_writeprotect);
+
+	close(uffd);
+}
+
+static void run(void)
+{
+	const struct tst_clone_args clone_args = {
+		.flags = CLONE_VM | CLONE_FILES | CLONE_FS | CLONE_SIGHAND,
+		.exit_signal = SIGCHLD,
+	};
+	pid_t pid;
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+	struct uffdio_writeprotect uffdio_writeprotect;
+
+	set_pages();
+
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	uffdio_register.range.start = (unsigned long) page;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	uffdio_writeprotect.range.start	= (unsigned long)page;
+	uffdio_writeprotect.range.len	= page_size;
+	uffdio_writeprotect.mode	= UFFDIO_WRITEPROTECT_MODE_WP;
+
+	SAFE_IOCTL(uffd, UFFDIO_WRITEPROTECT, &uffdio_writeprotect);
+
+	pid = SAFE_CLONE(&clone_args);
+	if (!pid) {
+		pagefault_handler();
+		_exit(0);
+	}
+
+	/* Try to write */
+	page[0xf] = 'W';
+
+	SAFE_WAITPID(pid, NULL, 0);
+	reset_pages();
+
+	if (wp_fault_seen)
+		tst_res(TPASS, "WRITEPROTECT pagefault handled!");
+	else
+		tst_res(TFAIL, "No WRITEPROTECT pagefault observed");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "5.7",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_HAVE_ARCH_USERFAULTFD_WP=y",
+		NULL
+	},
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd12.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd12.c
new file mode 100644
index 000000000..3fd4e3652
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd12.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different process (using clone with CLONE_VM instead of threads
+ * for Valgrind compatibility) testing UFFDIO_POISON.
+ */
+
+#include "config.h"
+#include <poll.h>
+#include <setjmp.h>
+#include <signal.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_clone.h"
+#include "lapi/sched.h"
+#include "lapi/userfaultfd.h"
+
+#define CHILD_STACK_SIZE (1024 * 1024)
+
+static int page_size;
+static char *page;
+static int uffd;
+static int poison_fault_seen;
+static volatile int sigbus_seen;
+static sigjmp_buf jmpbuf;
+static void *child_stack;
+
+static void sigbus_handler(int sig)
+{
+	if (sig == SIGBUS) {
+		sigbus_seen = 1;
+		siglongjmp(jmpbuf, 1);
+	}
+}
+
+static void setup(void)
+{
+	struct sigaction sa = {};
+
+	sa.sa_handler = sigbus_handler;
+	sigemptyset(&sa.sa_mask);
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+}
+
+static void set_pages(void)
+{
+	page_size = sysconf(_SC_PAGE_SIZE);
+	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void reset_pages(void)
+{
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page = NULL;
+	}
+}
+
+static int pagefault_handler(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	struct uffd_msg msg;
+	struct uffdio_poison uffdio_poison = {};
+	struct pollfd pollfd;
+	int nready;
+
+	pollfd.fd = uffd;
+	pollfd.events = POLLIN;
+	nready = poll(&pollfd, 1, -1);
+	if (nready == -1)
+		tst_brk(TBROK | TERRNO, "Error on poll");
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event != UFFD_EVENT_PAGEFAULT)
+		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	tst_atomic_store(1, &poison_fault_seen);
+
+	/* Poison the page that triggered the fault */
+	uffdio_poison.range.start = msg.arg.pagefault.address & ~(page_size - 1);
+	uffdio_poison.range.len = page_size;
+
+	SAFE_IOCTL(uffd, UFFDIO_POISON, &uffdio_poison);
+
+	close(uffd);
+	return 0;
+}
+
+static void run(void)
+{
+	pid_t pid;
+	struct uffdio_api uffdio_api = {};
+	struct uffdio_register uffdio_register;
+	char dummy;
+
+	poison_fault_seen = 0;
+	sigbus_seen = 0;
+	set_pages();
+
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = UFFD_FEATURE_POISON;
+
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
+		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
+
+	uffdio_register.range.start = (unsigned long) page;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	pid = ltp_clone(CLONE_VM | CLONE_FILES | CLONE_FS | CLONE_SIGHAND | SIGCHLD,
+			pagefault_handler, NULL, CHILD_STACK_SIZE, child_stack);
+	if (pid == -1)
+		tst_brk(TBROK | TERRNO, "ltp_clone failed");
+
+	/* Try to read from the page: should trigger fault, get poisoned, then SIGBUS */
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		LTP_VAR_USED(dummy) = page[0];
+	}
+
+	SAFE_WAITPID(pid, NULL, 0);
+	reset_pages();
+
+	int poisoned = tst_atomic_load(&poison_fault_seen);
+
+	if (poisoned && sigbus_seen)
+		tst_res(TPASS, "POISON successfully triggered SIGBUS");
+	else if (poisoned && !sigbus_seen)
+		tst_res(TFAIL, "POISON fault seen but no SIGBUS received");
+	else if (!poisoned && sigbus_seen)
+		tst_res(TFAIL, "SIGBUS received but no poison fault seen");
+	else
+		tst_res(TFAIL, "No poison fault or SIGBUS observed");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = reset_pages,
+	.forks_child = 1,
+	.bufs = (struct tst_buffers []) {
+		{&child_stack, .size = CHILD_STACK_SIZE},
+		{},
+	},
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
