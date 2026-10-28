Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FED606A320
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YuL8/ykI
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C4B23E98D8
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 16:26:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55F663E9A5D
 for <ltp@lists.linux.it>; Wed, 28 Oct 2026 06:15:44 +0100 (CET)
Received: from mail-dy2-x0b.google.com (mail-dy2-x0b.google.com
 [IPv6:2607:f8b0:4864:36::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 795D76009D8
 for <ltp@lists.linux.it>; Wed, 28 Oct 2026 06:15:43 +0100 (CET)
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-3535a54c09bso447190eec.0
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 22:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793164542; x=1793769342; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Yj2icuvOpo7K2PUVpGV+n/piexMtVazEmDnEiQ20ik=;
 b=YuL8/ykIGGoTAs3Resv74nQHhfPNmUXCJt0/HKjmF8rM0BXV8hUs9+xPYBi0zP7oKW
 lmajftTLSrcDm9YYEZwHIKq6FZrOEnY/7Wm/K+tAs/KBe4B9+9i8y1waTimv3nJ+7QjU
 05Qmj8d+ncXL1O0anoXAIQVtyWyJSr/lWfCLT3gBmhJL2vRGuxyDzg1x7YSJFOGXKdkp
 LvP8mI2myTHRC0tYST4Br3p3IF0VJnXdQRnWF9gmX4aFJn9EIoVvZ4fht/CBbZ7tiSP1
 eLx9/tHzijqSTEPUstgz9KnDuSfCmwkGy5HtSkkQxT5vTpY+CB5GyWvNBxUrkbDgWIqo
 nwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793164542; x=1793769342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Yj2icuvOpo7K2PUVpGV+n/piexMtVazEmDnEiQ20ik=;
 b=21vo1gHpzjjT5innqWYv6X5Tn+8aPGUzpGyurxibVbc6V56+S/UlA6AYJ5iZx/Swrp
 u1qK7Qig9rXo9fdCf7opaG2Q8hDHS1RPh2amnJrjsaNSiJmSoTP94PEp5/Ip/rSMow8y
 YPlsHrNp7J0A170RB8QuPUf5/FbmlG1tmvUUTPxfuhstU073AgF/fR35SKVU5qATepu1
 H/XhnNTIOjDR1z/9VkKMZ4EA7lV8Dinxdnlm1CToUe2k40m7vz5c7p4xs/YEX8HwxuGY
 sQpbkPd3aIBRMJaJuq7QAVv0tx+JMpj9jYAMVqs2Ml1OPE2t+odJxkncYiJZReWzTSni
 E7Pg==
X-Gm-Message-State: AFq9FYJjMQLKt8vfzpmJc/pHQ6hQSSRWCCWeXq7QUWhIKC6Dxka71egp
 J9tDYnHTu0n+zXaWItOuMtQwwMk+KGvc7FQk4HyJ0pA0+OOB2seQQphr2gHeBsFQ
X-Gm-Gg: AYBFou25B+HlutV4MtwaDtPvrRzIA5AYZHBNTnhn57xgnn+J5HC9wy2636bmIKUVkiE
 r4v+ibVeznxoCnzjuElITg5miRvlBxqUYOsoyqKUEXKLPLikP/pFZOCzoU7Tnqc39ec2PkPlKza
 eXwoxK+J51ys4+FpCgUymzNgFrqc9LXYti4z+NgScxrw123WSccsPcDdWiBc3PNdkFuuZ0S//qx
 DNVBnXlS4VAlxGEmZiIf2DPakqmqaYByI23gI655h7v3xM+sA16Rd5rar5RZyChJBbbMG7/eqx3
 uKbFOo1ZuAUo2RSUphEo5UZB6bJmplgWgmXhebkz5iPBgzsJPsnjX/8+0HltB5DaM/NX4YmNKgK
 tSVM/5J4mERY+6NMeyUrFwdebcyFaA1UB+yCTp4GUZ3js+GYu4XvFw9Y7g7ILVomP110WXCXiDM
 JYqPA+rBwSfMlAtOTudXSYmLQM7d03+FeynDXaFChbWN/XpNmgzjd11ylhNqlEaQvtuA0oWyQDe
 9IMmc/FoG91j1OElXn8Ho3oM5ThquDMHSJuuWUH9OoAwQOGapguFiapuXgWwJ4VRrsVjbpax6AH
 kkkurcJi+/Eo7CMW9rL3NO4ZhxOeA5q59DQzkRNAdaMA6WsGKENNlAi7
X-Received: by 2002:a05:7301:52c8:b0:361:306f:c32a with SMTP id
 5a478bee46e88-36a2036d1ffmr2152593eec.11.1793164541601; 
 Tue, 27 Oct 2026 22:15:41 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a239644efsm3579812eec.23.2026.10.27.22.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 22:15:41 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 28 Oct 2026 05:15:18 +0000
Message-ID: <20261028051518.22982-1-dennylin0707@gmail.com>
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 29 Oct 2026 16:26:03 +0100
Subject: [LTP] [PATCH v2] inotify13: check rename cookie pairing after
 adjacent moves
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
 testcases/kernel/syscalls/inotify/inotify13.c | 176 ++++++++++++++++++
 3 files changed, 178 insertions(+)
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
index 0000000..5b28e8d
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify13.c
@@ -0,0 +1,176 @@
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
+struct event_t {
+	const char *name;
+	unsigned int mask;
+	int wd;
+};
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
+	const char *type = directory ? "directory" : "file";
+	unsigned int isdir = directory ? IN_ISDIR : 0;
+	struct event_t event_set[] = {
+		{ "entry", IN_MOVED_FROM | isdir, 0 },
+		{ "entry", IN_MOVED_FROM | isdir, 0 },
+		{ "entry", IN_MOVED_TO | isdir, 0 },
+	};
+	union {
+		struct inotify_event align;
+		char data[4096];
+	} buf;
+	struct inotify_event *event;
+	const struct event_t *expected;
+	unsigned int cookies[ARRAY_SIZE(event_set)] = { 0 };
+	unsigned int count = 0, i;
+	size_t pos = 0, len;
+	int wd_source, wd_target, failed = 0;
+
+	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
+	wd_source = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "source", IN_MOVE);
+	wd_target = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "target", IN_MOVE);
+
+	event_set[0].wd = wd_source;
+	event_set[1].wd = wd_source;
+	event_set[2].wd = wd_target;
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
+	/* Reuse these paths for the next case and for -i iterations. */
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
+			tst_brk(TBROK, "Incomplete inotify event at offset %zu", pos);
+
+		event = (struct inotify_event *)(buf.data + pos);
+		if (event->len > len - pos - sizeof(*event))
+			tst_brk(TBROK, "Incomplete inotify event name at offset %zu", pos);
+
+		if (count >= ARRAY_SIZE(event_set)) {
+			tst_res(TINFO, "%s: unexpected event %u: wd=%d mask=%#x cookie=%u len=%u name=\"%.*s\"",
+				type, count, event->wd, event->mask, event->cookie,
+				event->len, (int)event->len, event->name);
+			failed = 1;
+		} else {
+			expected = &event_set[count];
+			cookies[count] = event->cookie;
+			tst_res(TINFO, "%s: event %u: wd=%d (expected %d) mask=%#x (expected %#x) cookie=%u len=%u name=\"%.*s\" (expected \"%s\")",
+				type, count, event->wd, expected->wd,
+				event->mask, expected->mask, event->cookie,
+				event->len, (int)event->len, event->name,
+				expected->name);
+			if (event->wd != expected->wd ||
+			    event->mask != expected->mask ||
+			    event->len < strlen(expected->name) + 1 ||
+			    memcmp(event->name, expected->name,
+				   strlen(expected->name) + 1))
+				failed = 1;
+		}
+		count++;
+		pos += sizeof(*event) + event->len;
+	}
+
+	for (i = count; i < ARRAY_SIZE(event_set); i++) {
+		expected = &event_set[i];
+		tst_res(TINFO, "%s: missing event %u: expected wd=%d mask=%#x name=\"%s\"", type, i, expected->wd,
+			expected->mask, expected->name);
+		failed = 1;
+	}
+
+	if (failed) {
+		tst_res(TFAIL, "%s: unexpected rename event sequence (%u events, expected %zu)",
+			type, count, ARRAY_SIZE(event_set));
+		return;
+	}
+
+	if (cookies[0] == cookies[1]) {
+		tst_res(TFAIL, "%s: both FROM cookies are %u (expected different cookies)",
+			type, cookies[0]);
+		return;
+	}
+
+	if (cookies[1] != cookies[2]) {
+		tst_res(TFAIL, "%s: second FROM cookie=%u, TO cookie=%u (expected equal cookies)",
+			type, cookies[1], cookies[2]);
+		return;
+	}
+
+	tst_res(TPASS, "%s: second FROM cookie=%u matches TO cookie=%u",
+		type, cookies[1], cookies[2]);
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
