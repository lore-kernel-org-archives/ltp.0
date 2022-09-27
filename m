Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CD6C54EE9
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 16:14:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54E963C8904
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 18:14:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C6753C67D6
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6D0C6600293
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:21 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C33521F8A6;
 Tue, 27 Sep 2022 16:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1664295260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3TX8XZ3AV+MhGwrpenWey2hHRYTnvWKaHNtamChkoek=;
 b=mEta0ag4J744HvFvYH/PuqSBDER/BG05RnVLGzsPaLBtQlILfLgAo1PR6btsWvrupFkgDZ
 ArQHQLhWE1UWRhIoCE2yJ/B5j6SulFl/cin1tQZ7U/NVoZHNRjQNPLGNfuwlMwV75eZLGx
 ndUOZ4IXOtYTOlFlNARk+xCXRK9WyiA=
Received: from g78.suse.de (unknown [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id 3D1E02C16B;
 Tue, 27 Sep 2022 16:14:20 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 27 Sep 2022 17:14:05 +0100
Message-Id: <20220927161408.23743-4-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220927161408.23743-1-rpalethorpe@suse.com>
References: <20220927161408.23743-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/6] api/state_machine: Add validating state machines
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Allows creating state machines where the state transitions are
validated. Also one can assert which states a line of code expects to
be executed in.

This is useful for verifying implicit or explicit state machines used
to process I/O events or data.

When a state violation is found a trace of previous state transitions
is printed.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_state_machine.h | 50 +++++++++++++++++++
 lib/tst_state_machine.c     | 98 +++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100644 include/tst_state_machine.h
 create mode 100644 lib/tst_state_machine.c

diff --git a/include/tst_state_machine.h b/include/tst_state_machine.h
new file mode 100644
index 000000000..2e86535c6
--- /dev/null
+++ b/include/tst_state_machine.h
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
+ */
+
+#include "inttypes.h"
+
+#ifndef TST_STATE_MACHINE_H
+#define TST_STATE_MACHINE_H
+
+#define TST_STATE_ANY (~(uint64_t)0)
+
+struct tst_state_matrix {
+	char *names[64];
+	uint64_t states[64];
+};
+
+struct tst_state_trace {
+	const char *file;
+	int line;
+	unsigned from;
+	unsigned to;
+};
+
+struct tst_state_mach {
+	const struct tst_state_matrix *mat;
+
+	unsigned top;
+	struct tst_state_trace ring[8];
+};
+
+#define TST_STATE_SET(mach, to) \
+	tst_state_set(__FILE__, __LINE__, mach, to)
+
+void tst_state_set(const char *const file, const int lineno,
+		  struct tst_state_mach *mach, unsigned to);
+
+#define TST_STATE_EXP(mach, mask) \
+	tst_state_exp(__FILE__, __LINE__, mach, mask)
+
+void tst_state_exp(const char *const file, const int lineno,
+		   struct tst_state_mach *mach, uint64_t mask);
+
+#define TST_STATE_GET(mach, mask) \
+	tst_state_get(__FILE__, __LINE__, mach, mask)
+
+unsigned tst_state_get(const char *const file, const int lineno,
+		       struct tst_state_mach *mach, uint64_t mask);
+
+#endif
diff --git a/lib/tst_state_machine.c b/lib/tst_state_machine.c
new file mode 100644
index 000000000..cb8ed79c4
--- /dev/null
+++ b/lib/tst_state_machine.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
+ */
+
+#define _GNU_SOURCE
+#define TST_NO_DEFAULT_MAIN
+
+#include <unistd.h>
+#include "stdio.h"
+
+#include "tst_test.h"
+#include "tst_state_machine.h"
+
+static const char *state_trace(struct tst_state_mach *mach)
+{
+	static char buf[4096];
+	char *const *const names = mach->mat->names;
+	size_t off = 1;
+	unsigned c = 0, i;
+
+	buf[0] = '\n';
+
+	for (i = mach->top; c < 8; c++) {
+		const struct tst_state_trace *t = mach->ring + i;
+
+		if (!t->file)
+			break;
+
+		if (off >= sizeof(buf))
+			break;
+
+		off += snprintf(buf + off,
+				sizeof(buf) - off - 1,
+				"\t%s:%d %s (%u) -> %s (%u)\n",
+				t->file, t->line,
+				names[t->from], t->from,
+				names[t->to], t->to);
+
+		if (!i)
+			i = 7;
+		else
+			i--;
+	}
+
+	return buf;
+}
+
+static void state_trace_set(const char *const file, const int lineno,
+			    struct tst_state_trace *trace, unsigned from, unsigned to)
+{
+	trace->file = file;
+	trace->line = lineno;
+	trace->from = from;
+	trace->to = to;
+}
+
+void tst_state_set(const char *const file, const int lineno,
+		   struct tst_state_mach *mach, unsigned to)
+{
+	char *const *const names = mach->mat->names;
+	const unsigned cur = mach->ring[mach->top].to;
+
+	if (cur > 63)
+		tst_brk_(file, lineno, TBROK, "Attempting to transition from an invalid state: %u: %s", cur, state_trace(mach));
+
+	if (to > 63)
+		tst_brk_(file, lineno, TBROK, "Attempting to transition to invalid state: %u: %s", to, state_trace(mach));
+
+	if (!(mach->mat->states[cur] & (1 << to)))
+		tst_brk_(file, lineno, TBROK, "Invalid transition: %s (%u) -> %s (%u): %s", names[cur], cur, names[to], to, state_trace(mach));
+
+	if (++(mach->top) == 8)
+		mach->top = 0;
+
+	state_trace_set(file, lineno, &mach->ring[mach->top], cur, to);
+}
+
+unsigned tst_state_get(const char *const file, const int lineno,
+		       struct tst_state_mach *mach, uint64_t mask)
+{
+	char *const *const names = mach->mat->names;
+	const unsigned cur = mach->ring[mach->top].to;
+
+	if (mask & (1 << cur))
+		return cur;
+
+	tst_brk_(file, lineno, TBROK, "Should not reach here while in state: %s (%u): %s",
+		 names[cur], cur, state_trace(mach));
+
+	return cur;
+}
+
+void tst_state_exp(const char *const file, const int lineno,
+		   struct tst_state_mach *mach, uint64_t mask)
+{
+	tst_state_get(file, lineno, mach, mask);
+}
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
