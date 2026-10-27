Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E786606A31C
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O5OORHcH
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88F293E5DDE
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 16:26:19 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6856A3CFD4D
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 20:20:21 +0100 (CET)
Received: from mail-dl2-x07.google.com (mail-dl2-x07.google.com
 [IPv6:2607:f8b0:4864:38::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9F1411A00936
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 20:20:20 +0100 (CET)
Received: by mail-dl2-x07.google.com with SMTP id
 a92af1059eb24-13985f8229aso110656c88.1
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793128819; x=1793733619; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HEI1beLFEji6JPrC/ny5Nsu6fz42d2/T2/6Fj2LaCcY=;
 b=O5OORHcHky9xaeohzTEQbOPg15WYC/VW0aQdjdXKlPGLBZyo11bDjYVT2rUBa9ce+w
 2pm4IYGdj+xNO9DLsyExIFsVm7lzOXK1xL4mVm3xpnK3ua3YBd+idB77iC8foYi/NRpG
 Z2Pwv6bRoPDXkyZTF1xvuE3LqNTVqOTmrhKirq6L35Uwwk/8ncSQpegdl5EHYnb61adU
 wcAQeda22b0M4NZS3o5rgkPzbD1DN4TXhy6AOS3TnMNxPkfboPndwtRLtE/CaEr0kjlm
 VEtgRTWsmVIINAs29GYbEXzV+UVbzrWpE9RNxqMn+xOi166OJa3Hiz9W55AwAXdDmN6i
 Y33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793128819; x=1793733619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HEI1beLFEji6JPrC/ny5Nsu6fz42d2/T2/6Fj2LaCcY=;
 b=s0Ht+/PdnRV1D1Tb43SEJPLjJDFU97pXVOHcockAyH4bz9TsszCUwIYzKELiiyeUcd
 uO3wRFoAJYVl0o2ZVLyJgbplcV5S0TZNJGw/uvjByJiXFBkH5G4HQfAYfTkL5s/jMizc
 2G40n/duQiwtPdQVsB3gMujFpCJKxB2XdWIODqsMszTFwzcDHUcNVQr8EeB59GWJMrhy
 YhFGIqADrVgM974OIvYGtqwrIV5YSp16Sc2oliRcB5zVF3e2KFHALeYyAyTtGOwu8nEy
 A1IaHXlNI/qGC7YrSBGzZgQcx4wg43u7KIt78oXhVCRT84aTwTm3NPQUA9B+4LaEhmRm
 xl+Q==
X-Gm-Message-State: AFq9FYILitoge/sYHTUiXHDn6n6uC0McEMwnMgDQ+CoP97r4TqLANMNV
 2AGnHiq8hve7FmBr1MGSREPDZSdon934/+awGdGLjfE5/uVby6ypXq6TIhAY96pG
X-Gm-Gg: AYBFou3ifGac8DvFDIoUjPMhTzmHpdXiCZWsCCi5NeLtn9EDyo5OYlPTljB1QErcebs
 awaA0l00UEq/lxdDDotu0RR7ac5HSHWjmXWb/mipHFKBIn8OgO1fYDsiXTl+YMlb42ZJoZmY3fU
 qKqNmbREvGDPRHcflo283TYDGhitbUtpTdWHeOu+mlA5V1YuYrI2hndN5+dxY4nKPwxw/P7VK0z
 Y5qbgcCnysXHohNZzwjT09JL0R/tVuhLOcOITE1JvpHMj5giOA4qbrWqvCpEYlehS7uOcVbfH9j
 6KHPG6oKRXGkvvY9++Vstygbnm9yc+C0bx5TLB4Dza2Oubyh2OTqAG+QPK2tgKYrVK8jh9dUFon
 r60T3Dj0uWctJ57j6fZqyUMRPtkqLIjkoLfHsbbx10PnhUU1Tf3yrnalonZ8cd4spXKgaAEi9N5
 woFfUg4FiA9R0YNLuZLPTAeShAmtN7rq/hjtRFAm/WyQ82PyGZlMdPp4N5ZoSjG8vPdIEds8Y+f
 DcsCoQ8oaPVYbED39XwHbIbSx7pMPQSVPX3ILDyT/s8/N2ZNPkEY1uyHEYwF7ke2xTYeXm9q3H+
 7flgADY=
X-Received: by 2002:a05:701b:4309:b0:145:287:ce91 with SMTP id
 a92af1059eb24-1a6cc90e851mr255380c88.14.1793128818705; 
 Tue, 27 Oct 2026 12:20:18 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a6da729ec9sm203115c88.20.2026.10.27.12.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:20:18 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 27 Oct 2026 19:19:55 +0000
Message-ID: <20261027191956.5015-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 29 Oct 2026 16:26:03 +0100
Subject: [LTP] [PATCH] inotify13: check rename cookie pairing after adjacent
 moves
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: linux-fsdevel@vger.kernel.org, dennylin0707@gmail.com, amir73il@gmail.com,
 jack@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Queue an unpaired IN_MOVED_FROM event, followed by an IN_MOVED_FROM and
IN_MOVED_TO pair with the same source watch descriptor and name as the
first event. Watch only IN_MOVE so creation of the replacement entry
does not separate the two IN_MOVED_FROM events in the queue.

Affected kernels coalesce the second IN_MOVED_FROM into the first,
leaving the IN_MOVED_TO cookie without a matching IN_MOVED_FROM cookie.
Check that all three events are retained, the two moves have distinct
cookies, and the second IN_MOVED_FROM matches the IN_MOVED_TO cookie.
Cover both regular files and directories.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/inotify/.gitignore  |   1 +
 testcases/kernel/syscalls/inotify/inotify13.c | 147 ++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 testcases/kernel/syscalls/inotify/inotify13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2bdb4a9..e578bd9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -677,6 +677,7 @@ inotify09 inotify09
 inotify10 inotify10
 inotify11 inotify11
 inotify12 inotify12
+inotify13 inotify13
 
 fanotify01 fanotify01
 fanotify02 fanotify02
diff --git a/testcases/kernel/syscalls/inotify/.gitignore b/testcases/kernel/syscalls/inotify/.gitignore
index f6e5c54..b597ea6 100644
--- a/testcases/kernel/syscalls/inotify/.gitignore
+++ b/testcases/kernel/syscalls/inotify/.gitignore
@@ -10,3 +10,4 @@
 /inotify10
 /inotify11
 /inotify12
+/inotify13
diff --git a/testcases/kernel/syscalls/inotify/inotify13.c b/testcases/kernel/syscalls/inotify/inotify13.c
new file mode 100644
index 0000000..4b172ba
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify13.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Hungyu Lin <dennylin0707@gmail.com>
+ */
+
+/*\
+ * Verify that coalescing does not lose an IN_MOVED_FROM event needed to
+ * match a later IN_MOVED_TO event by its rename cookie.
+ *
+ * Move an entry from a watched directory to an unwatched directory, recreate
+ * it under the same name, then move it to another watched directory. Watch
+ * only move events so the two IN_MOVED_FROM events are adjacent in the queue.
+ * Their cookies must differ, and the second must match the IN_MOVED_TO cookie.
+ * Test both regular files and directories without reading between renames.
+ */
+
+#include "config.h"
+#include <fcntl.h>
+#include <string.h>
+#include "tst_test.h"
+#include "inotify.h"
+
+#ifdef HAVE_SYS_INOTIFY_H
+#include <sys/inotify.h>
+
+#define SOURCE "source/entry"
+#define SAVED "unwatched/entry"
+#define TARGET "target/entry"
+
+static int fd_notify = -1;
+
+static void create_entry(int directory)
+{
+	if (directory)
+		SAFE_MKDIR(SOURCE, 0700);
+	else
+		SAFE_TOUCH(SOURCE, 0600, NULL);
+}
+
+static void verify_inotify(unsigned int directory)
+{
+	union {
+		struct inotify_event align;
+		char data[4096];
+	} buf;
+	struct inotify_event *event, *events[3];
+	unsigned int count = 0;
+	size_t pos = 0, len;
+	unsigned int from = IN_MOVED_FROM, to = IN_MOVED_TO;
+	int wd_source, wd_target;
+	const char *type = directory ? "directory" : "file";
+
+	if (directory) {
+		from |= IN_ISDIR;
+		to |= IN_ISDIR;
+	}
+
+	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
+	wd_source = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "source", IN_MOVE);
+	wd_target = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "target", IN_MOVE);
+
+	create_entry(directory);
+	SAFE_RENAME(SOURCE, SAVED);
+	create_entry(directory);
+	SAFE_RENAME(SOURCE, TARGET);
+
+	len = SAFE_READ(SAFE_READ_ANY, fd_notify, buf.data, sizeof(buf.data));
+	SAFE_CLOSE(fd_notify);
+	fd_notify = -1;
+
+	if (directory) {
+		SAFE_RMDIR(SAVED);
+		SAFE_RMDIR(TARGET);
+	} else {
+		SAFE_UNLINK(SAVED);
+		SAFE_UNLINK(TARGET);
+	}
+
+	while (pos < len) {
+		if (len - pos < sizeof(*event))
+			tst_brk(TBROK, "Incomplete inotify event");
+
+		event = (struct inotify_event *)(buf.data + pos);
+		if (event->len > len - pos - sizeof(*event))
+			tst_brk(TBROK, "Incomplete inotify event name");
+
+		tst_res(TINFO, "%s: wd=%d mask=%#x cookie=%u name=%.*s",
+			type, event->wd, event->mask, event->cookie,
+			(int)event->len, event->name);
+		if (event->len < sizeof("entry") ||
+		    memcmp(event->name, "entry", sizeof("entry"))) {
+			tst_res(TFAIL, "%s: unexpected rename event name", type);
+			return;
+		}
+		if (count < ARRAY_SIZE(events))
+			events[count] = event;
+		count++;
+		pos += sizeof(*event) + event->len;
+	}
+
+	if (count != ARRAY_SIZE(events)) {
+		tst_res(TFAIL, "%s: expected two FROM events and one TO, got %u",
+			type, count);
+		return;
+	}
+
+	if (events[0]->wd != wd_source || events[0]->mask != from ||
+	    events[1]->wd != wd_source || events[1]->mask != from ||
+	    events[2]->wd != wd_target || events[2]->mask != to) {
+		tst_res(TFAIL, "%s: unexpected rename event sequence", type);
+		return;
+	}
+
+	if (events[0]->cookie == events[1]->cookie ||
+	    events[1]->cookie != events[2]->cookie) {
+		tst_res(TFAIL, "%s: rename cookies do not identify the later pair",
+			type);
+		return;
+	}
+
+	tst_res(TPASS, "%s: second FROM cookie matches the TO cookie", type);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR("source", 0700);
+	SAFE_MKDIR("unwatched", 0700);
+	SAFE_MKDIR("target", 0700);
+}
+
+static void cleanup(void)
+{
+	if (fd_notify >= 0)
+		SAFE_CLOSE(fd_notify);
+}
+
+static struct tst_test test = {
+	.test = verify_inotify,
+	.tcnt = 2,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
+
+#else
+TST_TEST_TCONF("system doesn't have required inotify support");
+#endif
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
