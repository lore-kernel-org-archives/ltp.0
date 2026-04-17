Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094CAF8E4B0
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 06:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776408840; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=JKX97YeunBt3Hnct3jWq14WnomPIxxk0Cg6Nu3jZeg8=;
 b=eypNdzK+6zbgHXJGXSuBZcrvS8xpDFWwMWM0VIaWEJY+on3wvDmXKAFegvjJFEvGw80KD
 4ktCyTxG/cZB7y/YtdekeJule6E3maMJCCibnExuRc8wYy09I6WX+032v5l4v7dpjOjOYxk
 QtBT0k5EuT3jRoH3QPufW91+gnOrhi0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54D513E2921
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 08:54:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3DF23CD0E6
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 08:53:37 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DF065100046B
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 08:53:35 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso267211f8f.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776408815; x=1777013615; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5jLkrzgCD3ZQTiAYqly7nV4nA7M4+Q2jUT5nZUe1LU=;
 b=S6rArJislHyOhs2tGTnD3fCyFU1RHiSmS7Tci0t6TKKB6vgIXfuA+m8UtVsNdN4qXm
 xfqg8aa0L0XcB6zvEiNDLYiDC+plYRAW83Dhh4em8CE70tHZQFjL4KzmfJB1nuqWRd6m
 Qu6BZp6f75Qas1oyyp4vG8iBEKcBuBzEKGpO+LNuCh5Tc/KMUWAuMth+YAIGnGi2SWKu
 7qouA7gLkf8qJgsccoIHTNwZ3jDRmVuz7OmjHeWxfgS/Oz81ExH2BBttZUUPlerahd1B
 9i73SjYwA6Ishw4DZBOuQ6ZXA6V4MSojYjU0Zh5HeLauNAeZIJlcZKKyiNifBPeKFX1I
 LhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776408815; x=1777013615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l5jLkrzgCD3ZQTiAYqly7nV4nA7M4+Q2jUT5nZUe1LU=;
 b=iD50+lJNy59gZ3e75D7aJijRHTsfTUFfURI1xC4/Yhl9jerIIv/cF76XObuWeMREd2
 AJXKxhgJut0RitYsoaa5T02Db7oVu22GBJs0WoN22+QkcL1PbTXI2RC5VxTNtMmBgvzB
 cb+kAB8uF+W4PVx2wMpZ6lRAXOtZ8P41pwcZZ4coRQVnh77eiPkGCYosQex12HaURc/y
 gWSh0EXQHUql2wQj1Z+LvJ876WN2fsGjnKAZNnLfywFUiuQ3iXtOvUeUmn2H/2fpv1qY
 br6XsP7qxjEIvKYevTyRXqoItoVOQzVogkT3ufM0V3qMo5EkBYf/bw8Mdu+woYstxZaM
 4dXg==
X-Gm-Message-State: AOJu0YxG9pHPDmR+S57VKTx8q11BlasWAR+snemiw2s+VuLcuIOLQbWN
 whs6LhbKQSX2JeHfdWIGgd4mKMMNd4VSdQxzvCZHo6d47lcDuRgMVklFqHqvbKe9lZT0dBn7XFl
 e+sBe9Q==
X-Gm-Gg: AeBDiet9D/3wRW+sH7xqVke1e9lphyeUuhF17+zA5mTKT6N2F/DvOByAPbMDw+K7wg+
 NirRXb+/yPqmVxvFQXmE1QJ3I9PHjEIILbi8gpMYOXqWcA+e0qxw0/UJk5d9VvY8eDTrhIXEUfo
 fvCXvcFYGm2r07UUcjiXr7td7iQJXhDpxj5ziwRAXJ4sK69eParnUoLriqhGu3U0Uzi9775UEbV
 cHeBvVTfHZ+QGI0k5dlIYezQ1YVte98+Q938Yrzt3pJIZhwtCW+ltEqd/qXm75pyHfd20u8a9ad
 xUBXjsOcFRwqdfwhKQT8Vjdo1t1MWjYXHZve4p2rQjyXjHBnorP+pOK+Gc7x49FwM9Ba8o+ld9Y
 79XPNFl+668mCkVyMMrKvFsoTXGqbqXd0nrdd2qyHGxnJclRtUyhZdEku7RUprbW/h1zbeHujCx
 Gr1Ybwn1AZV4PXi8AAbOGl8A==
X-Received: by 2002:a05:6000:18a5:b0:43c:ff58:35c3 with SMTP id
 ffacd0b85a97d-43fe3dc818fmr2275622f8f.10.1776408814974; 
 Thu, 16 Apr 2026 23:53:34 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43fe4cb1176sm2254141f8f.3.2026.04.16.23.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 23:53:34 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 17 Apr 2026 06:53:25 +0000
Message-ID: <20260417065332.23663-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410023201.18119-1-wegao@suse.com>
References: <20260410023201.18119-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] mremap07.c: New test for mremap() with
 MREMAP_DONTUNMAP
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test verifies the mremap() syscall with the MREMAP_DONTUNMAP flag.
It uses userfaultfd to verify that accessing the old memory region
correctly triggers a page fault after the mapping has been moved.

MREMAP_DONTUNMAP behavior with userfaultfd was not covered by existing
mremap tests. This test provides coverage for the feature requested in
the linked issue.

Fixes: https://github.com/linux-test-project/ltp/issues/1168
Signed-off-by: Wei Gao <wegao@suse.com>
---
v6->v7:
- Update commit description
- Update year of copyright

 configure.ac                                |   1 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/mremap/.gitignore |   1 +
 testcases/kernel/syscalls/mremap/Makefile   |   1 +
 testcases/kernel/syscalls/mremap/mremap07.c | 158 ++++++++++++++++++++
 5 files changed, 162 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mremap/mremap07.c

diff --git a/configure.ac b/configure.ac
index 812f17d8b..211aaa8ad 100644
--- a/configure.ac
+++ b/configure.ac
@@ -46,6 +46,7 @@ AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
 AC_CHECK_DECLS([NFTA_CHAIN_ID, NFTA_VERDICT_CHAIN_ID],,,[#include <linux/netfilter/nf_tables.h>])
 AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
 AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
+AC_CHECK_DECLS([MREMAP_DONTUNMAP],,,[#include <linux/mman.h>])
 
 AC_CHECK_HEADERS_ONCE([ \
     aio.h \
diff --git a/runtest/syscalls b/runtest/syscalls
index d72fceb5e..b9a9ce5fe 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -927,6 +927,7 @@ mremap03 mremap03
 mremap04 mremap04
 mremap05 mremap05
 mremap06 mremap06
+mremap07 mremap07
 
 mseal01 mseal01
 mseal02 mseal02
diff --git a/testcases/kernel/syscalls/mremap/.gitignore b/testcases/kernel/syscalls/mremap/.gitignore
index ec15a19cd..292899e03 100644
--- a/testcases/kernel/syscalls/mremap/.gitignore
+++ b/testcases/kernel/syscalls/mremap/.gitignore
@@ -4,3 +4,4 @@
 /mremap04
 /mremap05
 /mremap06
+/mremap07
diff --git a/testcases/kernel/syscalls/mremap/Makefile b/testcases/kernel/syscalls/mremap/Makefile
index 9f5aca9ec..8811b887e 100644
--- a/testcases/kernel/syscalls/mremap/Makefile
+++ b/testcases/kernel/syscalls/mremap/Makefile
@@ -8,5 +8,6 @@ LTPLIBS = ipc
 include $(top_srcdir)/include/mk/testcases.mk
 
 mremap04: LTPLDLIBS  = -lltpipc
+mremap07: LDLIBS  += -lpthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mremap/mremap07.c b/testcases/kernel/syscalls/mremap/mremap07.c
new file mode 100644
index 000000000..102136322
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/mremap07.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * LTP test case for mremap() with MREMAP_DONTUNMAP and userfaultfd.
+ *
+ * Test mremap() with MREMAP_DONTUNMAP and verify that accessing the
+ * old memory region triggers a page fault, which is then correctly
+ * handled by a userfaultfd handler.
+ */
+
+#define _GNU_SOURCE
+#include <poll.h>
+#include <pthread.h>
+#include <linux/mman.h>
+
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "lapi/userfaultfd.h"
+#include "config.h"
+
+#if HAVE_DECL_MREMAP_DONTUNMAP
+
+static int page_size;
+static int uffd = -1;
+static char *fault_addr;
+static char *new_remap_addr;
+
+static const char *test_string = "Hello, world! This is a test string that fills up a page.";
+
+static void *fault_handler_thread(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	struct uffd_msg msg;
+	struct uffdio_copy uffdio_copy;
+
+	TST_CHECKPOINT_WAIT(0);
+
+	struct pollfd pollfd;
+
+	pollfd.fd = uffd;
+	pollfd.events = POLLIN;
+
+	int nready = poll(&pollfd, 1, -1);
+
+	if (nready == -1)
+		tst_brk(TBROK | TERRNO, "poll() failed");
+
+	if (nready == 0)
+		tst_brk(TBROK, "poll() timed out unexpectedly");
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event != UFFD_EVENT_PAGEFAULT)
+		tst_brk(TBROK, "Received unexpected UFFD_EVENT: %d", msg.event);
+
+	if ((char *)msg.arg.pagefault.address != fault_addr)
+		tst_brk(TBROK, "Page fault on unexpected address: %p", (void *)msg.arg.pagefault.address);
+
+	tst_res(TINFO, "Userfaultfd handler caught a page fault at %p", (void *)msg.arg.pagefault.address);
+
+	uffdio_copy.src = (unsigned long)new_remap_addr;
+	uffdio_copy.dst = (unsigned long)fault_addr;
+	uffdio_copy.len = page_size;
+	uffdio_copy.mode = 0;
+	uffdio_copy.copy = 0;
+
+	SAFE_IOCTL(uffd, UFFDIO_COPY, &uffdio_copy);
+	tst_res(TPASS, "Userfaultfd handler successfully handled the fault");
+
+	return NULL;
+}
+
+static void setup(void)
+{
+	page_size = getpagesize();
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, true);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	fault_addr = SAFE_MMAP(NULL, page_size,
+		PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	tst_res(TINFO, "Original mapping created at %p", (void *)fault_addr);
+
+	strcpy(fault_addr, "ABCD");
+
+	uffdio_register.range.start = (unsigned long)fault_addr;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+}
+
+static void cleanup(void)
+{
+	if (new_remap_addr && new_remap_addr != MAP_FAILED)
+		SAFE_MUNMAP(new_remap_addr, page_size);
+
+	if (fault_addr && fault_addr != MAP_FAILED)
+		SAFE_MUNMAP(fault_addr, page_size);
+
+	if (uffd != -1)
+		SAFE_CLOSE(uffd);
+}
+
+static void run(void)
+{
+	pthread_t handler_thread;
+
+	SAFE_PTHREAD_CREATE(&handler_thread, NULL,
+		fault_handler_thread, NULL);
+
+	new_remap_addr = mremap(fault_addr, page_size, page_size,
+		MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
+
+	if (new_remap_addr == MAP_FAILED)
+		tst_brk(TBROK | TERRNO, "mremap failed");
+
+	tst_res(TINFO, "New mapping created at %p", (void *)new_remap_addr);
+
+	strcpy(new_remap_addr, test_string);
+
+	TST_CHECKPOINT_WAKE(0);
+
+	tst_res(TINFO, "Main thread accessing old address %p to trigger fault",
+			(void *)fault_addr);
+
+	(void)*(volatile char *)fault_addr;
+
+	SAFE_PTHREAD_JOIN(handler_thread, NULL);
+
+	TST_EXP_EQ_STR(fault_addr, test_string);
+
+	SAFE_MUNMAP(new_remap_addr, page_size);
+	new_remap_addr = NULL;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_checkpoints = 1,
+	.cleanup = cleanup,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USERFAULTFD=y",
+		NULL,
+	},
+	.min_kver = "5.7",
+};
+
+#else
+TST_TEST_TCONF("Missing MREMAP_DONTUNMAP in <linux/mman.h>");
+#endif
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
