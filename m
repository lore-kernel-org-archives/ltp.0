Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6356A606A31A
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O3HCYy9X
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 970E83E98C5
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 18:49:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25A2E3E5B8D
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 18:49:22 +0100 (CET)
Received: from mail-dy2-x0a.google.com (mail-dy2-x0a.google.com
 [IPv6:2607:f8b0:4864:36::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5335B10007C3
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 18:49:21 +0100 (CET)
Received: by mail-dy2-x0a.google.com with SMTP id
 5a478bee46e88-33e5ae86ff2so1013244eec.0
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793296159; x=1793900959; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ln9h95COh+dKENlOI1wGS5xr92jymKdKA0g3KaCC54g=;
 b=O3HCYy9XJ6oWj2Lh413I+EPAMlh1Co44c9VQBs/1OKD5ZMkQHFSzfXzopVJ3GQc/z2
 o/3MmY9gaad4YkCetC3DqgrWfPldfpXB8bCjMpmNZr6Qj6QPZpda0t9+KmiPA3uKDbI6
 Rk6c7Z9PfBZA9JhrK389aUxNkPwkmkw8GBXvS6viN62noFdD0jFpfqraFaTeZ/IJ7shn
 f+iZHLy/ili1rRnFhfOnGo/ZDBZELqAkMugpo8nYcfi5TsUQmU5iisCWAl9VVwNUU83O
 ZpNzjhgVaHF7qjOVERWtSG2Y3wuPQ2YqGjzLAWr2NUNG/+lx6NETv/KdgjxRldAJaH2o
 ItQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793296159; x=1793900959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ln9h95COh+dKENlOI1wGS5xr92jymKdKA0g3KaCC54g=;
 b=RIpL0OdqUZfn0/Ms1nD5PjZvESRW2NXeAy2NgOP7PIKsH52mxMgxIay94F17uQvesi
 KtfK08KpwQXH1vMb7M7PNvuGNuEfrgFnEKQZOz/MRolQcUa+xlbAw0yfHhbgjeFjMIGi
 RXrDMVTPZAfscoiSlUVgHN1+LeBDfLsVDViDnobkQg+97qqvPmWjgcch+3mrA5I8W3mE
 qft3JNYGUz98N3eonuUzvsuJ6WlymzDSvWEI+g70nc50Wk+Bp3WqSY7NdmSwA1M8nIv4
 24NjfdDYA8etbk8zJUsKtSk8zIF0nglvkRvRf4VWfvGuAKHmfVbZPs+KWkDqUl+OExfi
 E2wg==
X-Gm-Message-State: AFq9FYKwPc0ChNagl0Xbl8dVIGAWZlScnbDA1yIccKFhwOowV/SRBg9a
 zmYKl9oS0E6S5E8dJL1etzslARSzfGmG92lzC7KW0eIOkRKLCfz0mbYTUJgSKmP7MnI=
X-Gm-Gg: AYBFou10T2m/XtQNZYfTm3trHBA7ewfSoYzP+mBf1RHc2jpdm7XgCKfLRFqV0GLqKET
 wyl//u2bvqlmVONqQ7Sk0rbVr+LZCV3sOz5Kh9E3sWB9Cl7s47sSCkC8UolbWyLEgBvovrUexL5
 3kKS4w0DiGms06cVNXLEO99dea/TJw7SsMfxnQZ/B+lEZAYMJ21ziGFDOa8afnZSolNvWe3yWv8
 zSh6y6Q90sfzEV9zpc5zci22magK3++Mp0nfcDc2EBdT9toaJBEINjrz8gtV2mFtd6svX4i9j9E
 4QPARjLKVLJUSVHlA3iCizag565CoFhNVzs2lhqhkc2755+Hbf7LRJ06fI6G0mVgiF1AeKaFwx5
 68rZNRABkZDMWK33x1xEUV6sgGrfLVgA0OMqjptyV5Pv4ah2nm6EFdcWPHpwdcjK/+jf9V9CaNZ
 jsyWBorG5+jvO3lyiHp909FC8RGgrxAjK8yYWNlXynmV5YTG8XVaWnbJef13l3BFAIFoGJnTeLH
 4aPCkDGgl8xr24XaF5+/S3wKTeeME+tR35hR1rNN5khazuIDSCIhhMwWZU4qMbpXXHqxwpyPDI5
 MutOcpX9vpsNBd7rjOPkHS7RkvSedk1MCraJmz7zmKKRDg208nH7BXYZFg==
X-Received: by 2002:a05:693c:880c:10b0:35c:cd26:3066 with SMTP id
 5a478bee46e88-36a424655bcmr123374eec.41.1793296159346; 
 Thu, 29 Oct 2026 10:49:19 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42902649sm127504eec.11.2026.10.29.10.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:49:18 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 29 Oct 2026 17:49:07 +0000
Message-ID: <20261029174907.98721-1-dennylin0707@gmail.com>
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] inotify13: check rename cookie pairing after
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
Changes in v3:
- Check event fields separately, starting with the mask, and report specific
  TFAIL diagnostics with actual and expected values. Log correct events
  with TINFO only.
- Report missing and extra events directly instead of using a generic
  failure flag.
- Use delete_entry() for both cleanup paths, as suggested by Amir.
- Use a file/directory test-case table and derive the test count from it.
- Clarify the operation sequence and affected-kernel history, the truncated
  payload diagnostic, and both cookie relations in the success message.
- Handle an empty nonblocking queue as missing events rather than TBROK.

Built with GCC 13.3.0 and checked with LTP checkpatch and sparse. On ARM64
QEMU, the test reports 0 pass / 2 fail on the baseline kernel and 2 pass /
0 fail with either kernel fix. With -i 20, the results are 0 pass / 40
fail before the fix and 40 pass / 0 fail afterwards.

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/inotify/.gitignore  |   1 +
 testcases/kernel/syscalls/inotify/inotify13.c | 217 ++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 testcases/kernel/syscalls/inotify/inotify13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2bdb4a9a2b4801d03d93efea686124530f5ce2d5..e578bd92d7e7ded5c0ca2f95dc87fce814d733cc 100644
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
index f6e5c546ac4032766cee9f16b3689be5d0302d37..b597ea63f493b2da2a58017d3eb7b16a7b033fc5 100644
--- a/testcases/kernel/syscalls/inotify/.gitignore
+++ b/testcases/kernel/syscalls/inotify/.gitignore
@@ -10,3 +10,4 @@
 /inotify10
 /inotify11
 /inotify12
+/inotify13
diff --git a/testcases/kernel/syscalls/inotify/inotify13.c b/testcases/kernel/syscalls/inotify/inotify13.c
new file mode 100644
index 0000000000000000000000000000000000000000..2ea5b5d4aeff9b368e5fa79ec18207035567a34b
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify13.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Hungyu Lin <dennylin0707@gmail.com>
+ */
+
+/*\
+ * Verify that two IN_MOVED_FROM events that differ only in their rename
+ * cookie are not coalesced.
+ *
+ * inotify(7) allows coalescing only of events with identical wd, mask,
+ * cookie and name. A regression introduced in v2.6.31 dropped the cookie
+ * comparison. On affected kernels, the second IN_MOVED_FROM is coalesced
+ * into the first, leaving the following IN_MOVED_TO without a matching
+ * IN_MOVED_FROM cookie.
+ *
+ * With source/ and target/ watched for IN_MOVE, and without reading the queue:
+ *
+ * 1. Move source/entry to unwatched/ (IN_MOVED_FROM, cookie A).
+ * 2. Recreate source/entry.
+ * 3. Move source/entry to target/ (IN_MOVED_FROM and IN_MOVED_TO, cookie B).
+ *
+ * All three events must be queued, with A != B. IN_CREATE is not watched, so
+ * the two IN_MOVED_FROM events are adjacent; the queue is not read in between,
+ * because only the last unread event can be merged with a new one. Both a
+ * regular file and a directory are tested.
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
+#define UNWATCHED "unwatched/entry"
+#define TARGET "target/entry"
+
+struct event_t {
+	const char *name;
+	unsigned int mask;
+	int wd;
+};
+
+static struct tcase {
+	const char *type;
+	unsigned int isdir;
+} tcases[] = {
+	{ "file", 0 },
+	{ "directory", IN_ISDIR },
+};
+
+static int fd_notify = -1;
+
+static void create_entry(unsigned int isdir, const char *path)
+{
+	if (isdir)
+		SAFE_MKDIR(path, 0700);
+	else
+		SAFE_TOUCH(path, 0600, NULL);
+}
+
+static void delete_entry(unsigned int isdir, const char *path)
+{
+	if (isdir)
+		SAFE_RMDIR(path);
+	else
+		SAFE_UNLINK(path);
+}
+
+static void verify_inotify(unsigned int n)
+{
+	const char *type = tcases[n].type;
+	unsigned int isdir = tcases[n].isdir;
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
+	int wd_source, wd_target;
+
+	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
+	wd_source = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "source", IN_MOVE);
+	wd_target = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "target", IN_MOVE);
+
+	event_set[0].wd = wd_source;
+	event_set[1].wd = wd_source;
+	event_set[2].wd = wd_target;
+
+	create_entry(isdir, SOURCE);
+	SAFE_RENAME(SOURCE, UNWATCHED);
+	create_entry(isdir, SOURCE);
+	SAFE_RENAME(SOURCE, TARGET);
+
+	len = SAFE_READ(SAFE_READ_ANY_EAGAIN, fd_notify, buf.data, sizeof(buf.data));
+	SAFE_CLOSE(fd_notify);
+
+	/* Reuse these paths for the next case and for -i iterations. */
+	delete_entry(isdir, UNWATCHED);
+	delete_entry(isdir, TARGET);
+
+	while (pos < len) {
+		if (len - pos < sizeof(*event))
+			tst_brk(TBROK, "%s: event %u has %zu header bytes (expected at least %zu)",
+				type, count, len - pos, sizeof(*event));
+
+		event = (struct inotify_event *)(buf.data + pos);
+		if (event->len > len - pos - sizeof(*event))
+			tst_brk(TBROK, "%s: event %u claims %u name bytes but only %zu are left in the buffer, wd=%d mask=%#x cookie=%u",
+				type, count, event->len, len - pos - sizeof(*event),
+				event->wd, event->mask, event->cookie);
+
+		if (count >= ARRAY_SIZE(event_set)) {
+			tst_res(TFAIL, "%s: unexpected extra event %u: got wd=%d mask=%#x cookie=%u len=%u name=\"%.*s\", expected no event after %zu events",
+				type, count, event->wd,
+				event->mask, event->cookie, event->len,
+				(int)event->len, event->name, ARRAY_SIZE(event_set));
+			return;
+		}
+
+		expected = &event_set[count];
+		if (event->mask != expected->mask) {
+			tst_res(TFAIL, "%s: event %u has wrong mask: got wd=%d mask=%#x cookie=%u name=\"%.*s\", expected wd=%d mask=%#x name=\"%s\"",
+				type, count, event->wd, event->mask, event->cookie,
+				(int)event->len, event->name, expected->wd,
+				expected->mask, expected->name);
+			return;
+		}
+
+		if (event->wd != expected->wd) {
+			tst_res(TFAIL, "%s: event %u has wrong wd: got wd=%d mask=%#x cookie=%u name=\"%.*s\", expected wd=%d mask=%#x name=\"%s\"",
+				type, count, event->wd, event->mask, event->cookie,
+				(int)event->len, event->name, expected->wd,
+				expected->mask, expected->name);
+			return;
+		}
+
+		if (event->len < strlen(expected->name) + 1 ||
+		    strncmp(expected->name, event->name, event->len)) {
+			tst_res(TFAIL, "%s: event %u has wrong name: got wd=%d mask=%#x cookie=%u len=%u name=\"%.*s\", expected wd=%d mask=%#x name=\"%s\"",
+				type, count, event->wd, event->mask, event->cookie,
+				event->len, (int)event->len, event->name,
+				expected->wd, expected->mask, expected->name);
+			return;
+		}
+
+		cookies[count] = event->cookie;
+		tst_res(TINFO, "%s: event %u: wd=%d mask=%#x cookie=%u len=%u name=\"%.*s\"",
+			type, count, event->wd, event->mask, event->cookie,
+			event->len, (int)event->len, event->name);
+		count++;
+		pos += sizeof(*event) + event->len;
+	}
+
+	for (i = count; i < ARRAY_SIZE(event_set); i++) {
+		expected = &event_set[i];
+		tst_res(TFAIL, "%s: missing event %u: got no event, expected wd=%d mask=%#x name=\"%s\"",
+			type, i, expected->wd, expected->mask, expected->name);
+	}
+
+	if (count < ARRAY_SIZE(event_set))
+		return;
+
+	if (cookies[0] == cookies[1]) {
+		tst_res(TFAIL, "%s: expected different FROM cookies for wd=%d mask=%#x name=\"%s\", got first=%u second=%u",
+			type, event_set[0].wd, event_set[0].mask,
+			event_set[0].name, cookies[0], cookies[1]);
+		return;
+	}
+
+	if (cookies[1] != cookies[2]) {
+		tst_res(TFAIL, "%s: expected matching rename cookies: FROM wd=%d mask=%#x name=\"%s\" cookie=%u, TO wd=%d mask=%#x name=\"%s\" cookie=%u",
+			type, event_set[1].wd, event_set[1].mask,
+			event_set[1].name, cookies[1], event_set[2].wd,
+			event_set[2].mask, event_set[2].name, cookies[2]);
+		return;
+	}
+
+	tst_res(TPASS, "%s: FROM cookies %u and %u differ, TO cookie %u matches the second",
+		type, cookies[0], cookies[1], cookies[2]);
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
+	.tcnt = ARRAY_SIZE(tcases),
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
