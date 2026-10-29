Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1C5606A31C
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmeqBWjE
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63D883E9A04
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 22:07:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC6003E5DDE
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 22:07:16 +0100 (CET)
Received: from mail-dl2-x07.google.com (mail-dl2-x07.google.com
 [IPv6:2607:f8b0:4864:38::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3BCF6200AF4
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 22:07:16 +0100 (CET)
Received: by mail-dl2-x07.google.com with SMTP id
 a92af1059eb24-14345ae29c5so963c88.1
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793308034; x=1793912834; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0tz6UJO2BZhACEYM6ZFE2ekJAZW1YAXReqMb1KC2X0Y=;
 b=lmeqBWjEzRMxCPhE3NIFDTxN48ow2uQhtszU/WFpwZRwHLrFaUctBPnt+Zu+5YE2fK
 SVztXM5IYtKWeZqJnHmG3GEB4ct7oiD21teYwTZH6CncbnbL6WkoUAiEM4ly2r3/1ghK
 dtRSz4gD2KloJHx3CUHMk/bgC9peeZI58d/DbDPkVSs9+fq10iAwt/YqVFGCChv9j7k+
 raa2EG2hR2fsENxLMuo1XTaVBKlzwGssb0LAwQ7OQSyyOMa0NNNoVvu2XnDu7poSPmt0
 l6CeyXkHbFKpivkGMdD0OdN5xMvQZS4Iybi4TwEyI/bxGQf3jY9ajZOJQePz4OLTL8fW
 3rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793308034; x=1793912834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0tz6UJO2BZhACEYM6ZFE2ekJAZW1YAXReqMb1KC2X0Y=;
 b=Jbxyu2dkv+ZZYvRQrZXB5Lv2bCSD5lhuIl5dCdBkIfGo9Wvl6PwrliIU1ZERDivs7a
 ctqOhaVlqRQL/CdMe8wBu8+JcN6wmXHXRjglqsZqOl9k83nZw1SYj07m2fzQ/JUrgtNP
 d1ztaSr9an9Z2/s1UNopd/Wdr7a9HGkC9tZULYn87v5ISCejjqQ9e74JRmfidUTB7zPi
 o8/TiYClgMfKm8Ct78ogEF9n/sz6jt0jya9E/83XC7pHiMQ2xTHg2HC2QFmRXygRzNIn
 ky6XosMYCuwhkLnd3Vg+4KNMIYzWSc51Gh7YvfazqoIMnLhKb4QsAo/M084Mr1iIXxAW
 +pEQ==
X-Gm-Message-State: AFq9FYKliCjFMA5McUYlSsZ2IirxzNIPsCjLGLCL8GvZ/7u9X+GPb3dd
 wWdOPRTcqiSNBjfRb/3zTFxR7/d6sQ3esXHeFPWRWAKmbKf2D1TQ78A7pv4+vqd8J44=
X-Gm-Gg: AYBFou1q8KnTkJ0BmQDdMoCDkRHeVh8mUntDX5lXmJ7R+zrYwJTHhsNMWL7+20lE2Dr
 AAmEj0ACAQEVaz0MlcAbU6GQa4ZN+UH1At90qtZKe0JKwUZAto1DAcml09A/QpD+7tvFC7AaS5a
 UalS8Li9BQAT4E79YZI40oiT7ZSp3BYCyJR89tiGEXcPwelXBnyM2GOerBgCfL2wEeoOzKXCQYG
 pQJLbxrSBhOYViZwVFcoUODfs7fWrKKfieieqFKkEfToksdzasAo8kvZv2V+YoStMB125zCuTFL
 87g36BJ1nADLMgwF1qPA1c02MaMaTfDZFUzNlhRB+F23rXCKuzqYVqQGWmatpqAoF/WX+iOqXEP
 Y6jTXcsf6z2xFsnxfVwnZR2uABwrPkcBquyeDQ1Y5USXwwCdOr+k3kTJKX4X7Tk/JhLY1p/I4fU
 PElH2yLCZTHcHS/xRDFD/WkagN3IkCtaaKZYH1rc2W0bC+z2eI65eu3BW6n0A6mRpKgNJueuLsQ
 3a2KERmC3dF5rT53aEAmDFVGgkes48ZWUfKA1sDmYHXpg5/1BLuwDZPqXo8aPPRKMfNuvfWItIm
 UIq0MSu6ylVbWHVaRxyENfRypeDRGbLisrV9e0XkNMZSLEVSZCrhcTok
X-Received: by 2002:a05:7022:3c04:b0:1a9:c52f:655c with SMTP id
 a92af1059eb24-1ac5c555f7cmr258090c88.36.1793308034303; 
 Thu, 29 Oct 2026 14:07:14 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1abcd6f1sm1089981c88.20.2026.10.29.14.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 14:07:13 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 29 Oct 2026 21:07:01 +0000
Message-ID: <20261029210701.80050-1-dennylin0707@gmail.com>
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] inotify13: check rename cookie pairing after
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
Changes in v4:
- Put expected values immediately after the mismatched fields, following
  the existing per-field diagnostic format.
- Use the existing "got unnecessary event" and "didn't get event" wording.
- Keep event context for extra events and mask, watch descriptor and
  filename mismatches. Omit it from the two cookie-failure messages,
  since it is already present in TINFO, as confirmed by Amir.

Built with GCC 13.3.0 and checked with LTP checkpatch and sparse. On ARM64
QEMU, the test reports 0 pass / 2 fail on the baseline kernel and 2 pass /
0 fail with the kernel fix. Local diagnostic controls also exercise both
cookie failures and verify the preceding TINFO and concise TFAIL output.
The controls are kept outside this patch.

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/inotify/.gitignore  |   1 +
 testcases/kernel/syscalls/inotify/inotify13.c | 211 ++++++++++++++++++++++++++
 3 files changed, 213 insertions(+)
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
index 0000000000000000000000000000000000000000..9ee660e041435d16b63097ba8e2f86515d6bac57
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify13.c
@@ -0,0 +1,211 @@
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
+			tst_res(TFAIL, "%s: got unnecessary event %u: mask=%#x wd=%d cookie=%u len=%u name=\"%.*s\"",
+				type, count, event->mask, event->wd, event->cookie,
+				event->len, (int)event->len, event->name);
+			return;
+		}
+
+		expected = &event_set[count];
+		if (event->mask != expected->mask) {
+			tst_res(TFAIL, "%s: got event %u: mask=%#x (expected %#x) wd=%d cookie=%u name=\"%.*s\"",
+				type, count, event->mask, expected->mask, event->wd,
+				event->cookie, (int)event->len, event->name);
+			return;
+		}
+
+		if (event->wd != expected->wd) {
+			tst_res(TFAIL, "%s: got event %u: mask=%#x wd=%d (expected %d) cookie=%u name=\"%.*s\"",
+				type, count, event->mask, event->wd, expected->wd,
+				event->cookie, (int)event->len, event->name);
+			return;
+		}
+
+		if (event->len < strlen(expected->name) + 1 ||
+		    strncmp(expected->name, event->name, event->len)) {
+			tst_res(TFAIL, "%s: got event %u: mask=%#x wd=%d cookie=%u len=%u name=\"%.*s\" (expected \"%s\")",
+				type, count, event->mask, event->wd, event->cookie,
+				event->len, (int)event->len, event->name,
+				expected->name);
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
+		tst_res(TFAIL, "%s: didn't get event %u: mask=%#x wd=%d name=\"%s\"",
+			type, i, expected->mask, expected->wd, expected->name);
+	}
+
+	if (count < ARRAY_SIZE(event_set))
+		return;
+
+	if (cookies[0] == cookies[1]) {
+		tst_res(TFAIL, "%s: got second FROM cookie=%u (expected != %u)",
+			type, cookies[1], cookies[0]);
+		return;
+	}
+
+	if (cookies[1] != cookies[2]) {
+		tst_res(TFAIL, "%s: got TO cookie=%u (expected %u from second FROM)",
+			type, cookies[2], cookies[1]);
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
