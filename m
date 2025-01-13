Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588F8E7719E
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 08:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736756279; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=X1t5fjr67z3bB6zJpKqGlCWUCLMRhlyMKxXZItToYKE=;
 b=bGhuRoTzWwnkOqJ4QIPjMxRauD+BRQqejMEekqnZn8fOijjzzQupNvkbd16BCPFmmlxkk
 MNTBzS5dhX+yQLztZ8zczUFUM6U+uW7clm3dwjOax831+ptcYnCIk+tTk5I0Lx2veo7IfOI
 qwzlOny7F6rbIsnWakJsTLnD1iIl0j8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E14023C770C
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 09:17:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C6E93C7709
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 09:17:03 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 82232100C682
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 09:17:02 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso28076525e9.0
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 00:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736756222; x=1737361022; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFrGMmc/nru1R9UJbAhfdaahlP/akbndbvCKUX7TXJM=;
 b=LdHytU2jrimUXZnn/ybBExUolHiJR+rM8PG0Z1bYndi17TtBOgiVWtFOTB+4I/DFvS
 gUcFVoWHdzf0MmJVpFMMMx7tPzFjVVuBbM72JTS4rjtyyrd2TWYzmFS6ld5WsokExN9Y
 x0l0MtRQfyvUuHi/w4U/bzUDGvzHLgr/DiBKB7z9jr8rAqaT54UL80gM8AqTyQoTQ6Wa
 DW6p5KMIql1o0HdsNk7fxHqg8l0YpCvHRn8tdcb7ue4ffwO5I6QJjirjQ4D0e5YQ6KKs
 /dA0hBjhxn+KAVsNGLcAR6Ih61cdY+pmj2xOTZqHXeIJXjPKI67Fjor2N8WhHdvuMvT6
 rZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736756222; x=1737361022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFrGMmc/nru1R9UJbAhfdaahlP/akbndbvCKUX7TXJM=;
 b=XRGQAYE99qE37PFDwHdhVafnFynsh9ctKlBhMC/ZdE6URoaTDdn/y3IYoMbltSj+ZN
 P/I6sylaDlCShqWdY1936O+1tnK8REc2JIC2jw89BcrFmU6SCqpO4surKlYNBiASQ/TH
 MMu373N9DP13BEyAuC9wGKuM/mL1yY0RjPVjlId8XvZ20siHoOTvg9pLj7h6cVco4HFe
 Yrx7yNfdhpSqhFy7ivQ0oLui4fg1IxvOvi80YOu4A10hfl2UqXmhWsPMeKasBPxptfNI
 9WvREregnHgxIoUjh4h7RP1LEexwRnxQXKnrxlDql+0dsKY+hVPDzk3ZzfL1CHjC+fJs
 cPDw==
X-Gm-Message-State: AOJu0YyLHCMHVxWbOiJOsaVwydNuZCUhlZPjCZNoQNrLQ3xSpFSEVMy3
 tCf/rsxxJUOPyAw2Y3KNxJeLncuTM7MwAsF1Zk5xAyqkyIRy5JhOmducbv7mw0QhQuZZrAf7kNv
 QKw==
X-Gm-Gg: ASbGncurS0wx8MAa1E0AJrd2HUpl+LYkPeVxoQEJsxMxZqV2iMwArB7iVapoFKQJ7lQ
 mC/gPQa8ncCKTxNmdg1SBIaSRGdeBSz3Qvlbz3j1tSLZiNHA8x5ce8BbaeGZs2gAKwEGnx+PC7Y
 dBMiYd8SUK7qtuH435TeKqjzK5aXsY6qwCiUNWSc7CybL/Zkry5JU7lLKBOak8EqwU0PpR0Tdcj
 53AkPgQsB2+0JM8nUt8L8Pc7FF3bOU8NwwXUQAvr2tHzA==
X-Google-Smtp-Source: AGHT+IF8ymAduw7eZDBKU0EpLH67AQa9JHijr6mrNI78GVtUZx4WyQ/TDuSNSltIU47QUGdplbMdqQ==
X-Received: by 2002:a05:600c:a08b:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-436e26dda73mr147577415e9.24.1736756221744; 
 Mon, 13 Jan 2025 00:17:01 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e8bea5sm169585215e9.31.2025.01.13.00.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 00:17:01 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 13 Jan 2025 03:16:22 -0500
Message-Id: <20250113081622.28942-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250113081622.28942-1-wegao@suse.com>
References: <20241217061636.16366-1-wegao@suse.com>
 <20250113081622.28942-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/2] ptrace06: Refactor the test using new LTP API
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

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/ptrace/ptrace06.c   | 325 ++++++++++--------
 .../kernel/syscalls/ptrace/ptrace06_child.c   |  16 +
 2 files changed, 190 insertions(+), 151 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace06_child.c

diff --git a/testcases/kernel/syscalls/ptrace/ptrace06.c b/testcases/kernel/syscalls/ptrace/ptrace06.c
index a1db3bab8..b760ab89d 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace06.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace06.c
@@ -1,199 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * check out-of-bound/unaligned addresses given to
+ * Copyright (c) 2008 Analog Devices Inc.
+ * Copyright (c) Linux Test Project, 2009-2022
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Check out-of-bound/unaligned addresses given to
+ *
  *  - {PEEK,POKE}{DATA,TEXT,USER}
  *  - {GET,SET}{,FG}REGS
  *  - {GET,SET}SIGINFO
- *
- * Copyright (c) 2008 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later
  */
 
-#define _GNU_SOURCE
-
-#include <errno.h>
-#include <stdbool.h>
-#include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
 #include <sys/ptrace.h>
-
-#include "test.h"
-#include "spawn_ptrace_child.h"
+#include "tst_test.h"
 
 /* this should be sizeof(struct user), but that info is only found
  * in the kernel asm/user.h which is not exported to userspace.
  */
+
 #if defined(__i386__)
-#define SIZEOF_USER 284
+# define SIZEOF_USER 284
 #elif defined(__x86_64__)
-#define SIZEOF_USER 928
+# define SIZEOF_USER 928
 #else
-#define SIZEOF_USER 0x1000	/* just pick a big number */
+# define SIZEOF_USER 0x1000	/* just pick a big number */
 #endif
 
-char *TCID = "ptrace06";
-
-struct test_case_t {
+static struct test_case_t {
 	int request;
 	long addr;
 	long data;
 } test_cases[] = {
-	{
-	PTRACE_PEEKDATA,.addr = 0}, {
-	PTRACE_PEEKDATA,.addr = 1}, {
-	PTRACE_PEEKDATA,.addr = 2}, {
-	PTRACE_PEEKDATA,.addr = 3}, {
-	PTRACE_PEEKDATA,.addr = -1}, {
-	PTRACE_PEEKDATA,.addr = -2}, {
-	PTRACE_PEEKDATA,.addr = -3}, {
-	PTRACE_PEEKDATA,.addr = -4}, {
-	PTRACE_PEEKTEXT,.addr = 0}, {
-	PTRACE_PEEKTEXT,.addr = 1}, {
-	PTRACE_PEEKTEXT,.addr = 2}, {
-	PTRACE_PEEKTEXT,.addr = 3}, {
-	PTRACE_PEEKTEXT,.addr = -1}, {
-	PTRACE_PEEKTEXT,.addr = -2}, {
-	PTRACE_PEEKTEXT,.addr = -3}, {
-	PTRACE_PEEKTEXT,.addr = -4}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 1}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 2}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 3}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 4}, {
-	PTRACE_PEEKUSER,.addr = -1}, {
-	PTRACE_PEEKUSER,.addr = -2}, {
-	PTRACE_PEEKUSER,.addr = -3}, {
-	PTRACE_PEEKUSER,.addr = -4}, {
-	PTRACE_POKEDATA,.addr = 0}, {
-	PTRACE_POKEDATA,.addr = 1}, {
-	PTRACE_POKEDATA,.addr = 2}, {
-	PTRACE_POKEDATA,.addr = 3}, {
-	PTRACE_POKEDATA,.addr = -1}, {
-	PTRACE_POKEDATA,.addr = -2}, {
-	PTRACE_POKEDATA,.addr = -3}, {
-	PTRACE_POKEDATA,.addr = -4}, {
-	PTRACE_POKETEXT,.addr = 0}, {
-	PTRACE_POKETEXT,.addr = 1}, {
-	PTRACE_POKETEXT,.addr = 2}, {
-	PTRACE_POKETEXT,.addr = 3}, {
-	PTRACE_POKETEXT,.addr = -1}, {
-	PTRACE_POKETEXT,.addr = -2}, {
-	PTRACE_POKETEXT,.addr = -3}, {
-	PTRACE_POKETEXT,.addr = -4}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 1}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 2}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 3}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 4}, {
-	PTRACE_POKEUSER,.addr = -1}, {
-	PTRACE_POKEUSER,.addr = -2}, {
-	PTRACE_POKEUSER,.addr = -3}, {
-	PTRACE_POKEUSER,.addr = -4},
+	{PTRACE_PEEKDATA, .addr = 0},
+	{PTRACE_PEEKDATA, .addr = 1},
+	{PTRACE_PEEKDATA, .addr = 2},
+	{PTRACE_PEEKDATA, .addr = 3},
+	{PTRACE_PEEKDATA, .addr = -1},
+	{PTRACE_PEEKDATA, .addr = -2},
+	{PTRACE_PEEKDATA, .addr = -3},
+	{PTRACE_PEEKDATA, .addr = -4},
+	{PTRACE_PEEKTEXT, .addr = 0},
+	{PTRACE_PEEKTEXT, .addr = 1},
+	{PTRACE_PEEKTEXT, .addr = 2},
+	{PTRACE_PEEKTEXT, .addr = 3},
+	{PTRACE_PEEKTEXT, .addr = -1},
+	{PTRACE_PEEKTEXT, .addr = -2},
+	{PTRACE_PEEKTEXT, .addr = -3},
+	{PTRACE_PEEKTEXT, .addr = -4},
+	{PTRACE_PEEKUSER, .addr = SIZEOF_USER + 1},
+	{PTRACE_PEEKUSER, .addr = SIZEOF_USER + 2},
+	{PTRACE_PEEKUSER, .addr = SIZEOF_USER + 3},
+	{PTRACE_PEEKUSER, .addr = SIZEOF_USER + 4},
+	{PTRACE_PEEKUSER, .addr = -1},
+	{PTRACE_PEEKUSER, .addr = -2},
+	{PTRACE_PEEKUSER, .addr = -3},
+	{PTRACE_PEEKUSER, .addr = -4},
+	{PTRACE_POKEDATA, .addr = 0},
+	{PTRACE_POKEDATA, .addr = 1},
+	{PTRACE_POKEDATA, .addr = 2},
+	{PTRACE_POKEDATA, .addr = 3},
+	{PTRACE_POKEDATA, .addr = -1},
+	{PTRACE_POKEDATA, .addr = -2},
+	{PTRACE_POKEDATA, .addr = -3},
+	{PTRACE_POKEDATA, .addr = -4},
+	{PTRACE_POKETEXT, .addr = 0},
+	{PTRACE_POKETEXT, .addr = 1},
+	{PTRACE_POKETEXT, .addr = 2},
+	{PTRACE_POKETEXT, .addr = 3},
+	{PTRACE_POKETEXT, .addr = -1},
+	{PTRACE_POKETEXT, .addr = -2},
+	{PTRACE_POKETEXT, .addr = -3},
+	{PTRACE_POKETEXT, .addr = -4},
+	{PTRACE_POKEUSER, .addr = SIZEOF_USER + 1},
+	{PTRACE_POKEUSER, .addr = SIZEOF_USER + 2},
+	{PTRACE_POKEUSER, .addr = SIZEOF_USER + 3},
+	{PTRACE_POKEUSER, .addr = SIZEOF_USER + 4},
+	{PTRACE_POKEUSER, .addr = -1},
+	{PTRACE_POKEUSER, .addr = -2},
+	{PTRACE_POKEUSER, .addr = -3},
+	{PTRACE_POKEUSER, .addr = -4},
 #ifdef PTRACE_GETREGS
-	{
-	PTRACE_GETREGS,.data = 0}, {
-	PTRACE_GETREGS,.data = 1}, {
-	PTRACE_GETREGS,.data = 2}, {
-	PTRACE_GETREGS,.data = 3}, {
-	PTRACE_GETREGS,.data = -1}, {
-	PTRACE_GETREGS,.data = -2}, {
-	PTRACE_GETREGS,.data = -3}, {
-	PTRACE_GETREGS,.data = -4},
+	{PTRACE_GETREGS, .data = 0},
+	{PTRACE_GETREGS, .data = 1},
+	{PTRACE_GETREGS, .data = 2},
+	{PTRACE_GETREGS, .data = 3},
+	{PTRACE_GETREGS, .data = -1},
+	{PTRACE_GETREGS, .data = -2},
+	{PTRACE_GETREGS, .data = -3},
+	{PTRACE_GETREGS, .data = -4},
 #endif
 #ifdef PTRACE_GETFGREGS
-	{
-	PTRACE_GETFGREGS,.data = 0}, {
-	PTRACE_GETFGREGS,.data = 1}, {
-	PTRACE_GETFGREGS,.data = 2}, {
-	PTRACE_GETFGREGS,.data = 3}, {
-	PTRACE_GETFGREGS,.data = -1}, {
-	PTRACE_GETFGREGS,.data = -2}, {
-	PTRACE_GETFGREGS,.data = -3}, {
-	PTRACE_GETFGREGS,.data = -4},
+	{PTRACE_GETFGREGS, .data = 0},
+	{PTRACE_GETFGREGS, .data = 1},
+	{PTRACE_GETFGREGS, .data = 2},
+	{PTRACE_GETFGREGS, .data = 3},
+	{PTRACE_GETFGREGS, .data = -1},
+	{PTRACE_GETFGREGS, .data = -2},
+	{PTRACE_GETFGREGS, .data = -3},
+	{PTRACE_GETFGREGS, .data = -4},
 #endif
 #ifdef PTRACE_SETREGS
-	{
-	PTRACE_SETREGS,.data = 0}, {
-	PTRACE_SETREGS,.data = 1}, {
-	PTRACE_SETREGS,.data = 2}, {
-	PTRACE_SETREGS,.data = 3}, {
-	PTRACE_SETREGS,.data = -1}, {
-	PTRACE_SETREGS,.data = -2}, {
-	PTRACE_SETREGS,.data = -3}, {
-	PTRACE_SETREGS,.data = -4},
+	{PTRACE_SETREGS, .data = 0},
+	{PTRACE_SETREGS, .data = 1},
+	{PTRACE_SETREGS, .data = 2},
+	{PTRACE_SETREGS, .data = 3},
+	{PTRACE_SETREGS, .data = -1},
+	{PTRACE_SETREGS, .data = -2},
+	{PTRACE_SETREGS, .data = -3},
+	{PTRACE_SETREGS, .data = -4},
 #endif
 #ifdef PTRACE_SETFGREGS
-	{
-	PTRACE_SETFGREGS,.data = 0}, {
-	PTRACE_SETFGREGS,.data = 1}, {
-	PTRACE_SETFGREGS,.data = 2}, {
-	PTRACE_SETFGREGS,.data = 3}, {
-	PTRACE_SETFGREGS,.data = -1}, {
-	PTRACE_SETFGREGS,.data = -2}, {
-	PTRACE_SETFGREGS,.data = -3}, {
-	PTRACE_SETFGREGS,.data = -4},
+	{PTRACE_SETFGREGS, .data = 0},
+	{PTRACE_SETFGREGS, .data = 1},
+	{PTRACE_SETFGREGS, .data = 2},
+	{PTRACE_SETFGREGS, .data = 3},
+	{PTRACE_SETFGREGS, .data = -1},
+	{PTRACE_SETFGREGS, .data = -2},
+	{PTRACE_SETFGREGS, .data = -3},
+	{PTRACE_SETFGREGS, .data = -4},
 #endif
 #if HAVE_DECL_PTRACE_GETSIGINFO
-	{
-	PTRACE_GETSIGINFO,.data = 0}, {
-	PTRACE_GETSIGINFO,.data = 1}, {
-	PTRACE_GETSIGINFO,.data = 2}, {
-	PTRACE_GETSIGINFO,.data = 3}, {
-	PTRACE_GETSIGINFO,.data = -1}, {
-	PTRACE_GETSIGINFO,.data = -2}, {
-	PTRACE_GETSIGINFO,.data = -3}, {
-	PTRACE_GETSIGINFO,.data = -4},
+	{PTRACE_GETSIGINFO, .data = 0},
+	{PTRACE_GETSIGINFO, .data = 1},
+	{PTRACE_GETSIGINFO, .data = 2},
+	{PTRACE_GETSIGINFO, .data = 3},
+	{PTRACE_GETSIGINFO, .data = -1},
+	{PTRACE_GETSIGINFO, .data = -2},
+	{PTRACE_GETSIGINFO, .data = -3},
+	{PTRACE_GETSIGINFO, .data = -4},
 #endif
 #if HAVE_DECL_PTRACE_SETSIGINFO
-	{
-	PTRACE_SETSIGINFO,.data = 0}, {
-	PTRACE_SETSIGINFO,.data = 1}, {
-	PTRACE_SETSIGINFO,.data = 2}, {
-	PTRACE_SETSIGINFO,.data = 3}, {
-	PTRACE_SETSIGINFO,.data = -1}, {
-	PTRACE_SETSIGINFO,.data = -2}, {
-	PTRACE_SETSIGINFO,.data = -3}, {
-	PTRACE_SETSIGINFO,.data = -4},
+	{PTRACE_SETSIGINFO, .data = 0},
+	{PTRACE_SETSIGINFO, .data = 1},
+	{PTRACE_SETSIGINFO, .data = 2},
+	{PTRACE_SETSIGINFO, .data = 3},
+	{PTRACE_SETSIGINFO, .data = -1},
+	{PTRACE_SETSIGINFO, .data = -2},
+	{PTRACE_SETSIGINFO, .data = -3},
+	{PTRACE_SETSIGINFO, .data = -4},
+#endif
+};
+
+#define SPT(x)[PTRACE_##x] = #x,
+static char *strings[] = {
+	SPT(TRACEME)
+	SPT(PEEKTEXT)
+	SPT(PEEKDATA)
+	SPT(PEEKUSER)
+	SPT(POKETEXT)
+	SPT(POKEDATA)
+	SPT(POKEUSER)
+#ifdef PTRACE_GETREGS
+	SPT(GETREGS)
+#endif
+#ifdef PTRACE_SETREGS
+	SPT(SETREGS)
+#endif
+#ifdef PTRACE_GETSIGINFO
+	SPT(GETSIGINFO)
 #endif
+#ifdef PTRACE_SETSIGINFO
+	SPT(SETSIGINFO)
+#endif
+#ifdef PTRACE_GETFGREGS
+	SPT(GETFGREGS)
+#endif
+#ifdef PTRACE_SETFGREGS
+	SPT(SETFGREGS)
+#endif
+	SPT(KILL)
+	SPT(SINGLESTEP)
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
+static void child(void)
+{
+	SAFE_PTRACE(PTRACE_TRACEME, 0, NULL, NULL);
+	raise(SIGSTOP);
+	exit(0);
+}
 
-int main(int argc, char *argv[])
+static void run(void)
 {
 	size_t i;
-	long ret;
-	int saved_errno;
+	int pid;
+	int status;
+	int exp_errnos[] = {EIO, EFAULT};
+
+	pid = SAFE_FORK();
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	if (!pid)
+		child();
 
-	make_a_baby(argc, argv);
+	SAFE_WAIT(&status);
+
+	if (!WIFSTOPPED(status))
+		tst_brk(TBROK, "child %d was not stopped", pid);
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
 		struct test_case_t *tc = &test_cases[i];
 
-		errno = 0;
-		ret =
-		    ptrace(tc->request, pid, (void *)tc->addr,
-			   (void *)tc->data);
-		saved_errno = errno;
-		if (ret != -1)
-			tst_resm(TFAIL,
-				 "ptrace(%s, ..., %li, %li) returned %li instead of -1",
-				 strptrace(tc->request), tc->addr, tc->data,
-				 ret);
-		else if (saved_errno != EIO && saved_errno != EFAULT)
-			tst_resm(TFAIL,
-				 "ptrace(%s, ..., %li, %li) expected errno EIO or EFAULT; actual: %i (%s)",
-				 strptrace(tc->request), tc->addr, tc->data,
-				 saved_errno, strerror(saved_errno));
-		else
-			tst_resm(TPASS,
-				 "ptrace(%s, ..., %li, %li) failed as expected",
-				 strptrace(tc->request), tc->addr, tc->data);
+		TEST(ptrace(tc->request, pid, (void *)tc->addr,
+					(void *)tc->data));
+		TST_EXP_FAIL_ARR(ptrace(tc->request, pid, (void *)tc->addr,
+					(void *)tc->data), exp_errnos, ARRAY_SIZE(exp_errnos),
+					"ptrace(%s, ..., %li, %li) failed as expected",
+					 strings[tc->request], tc->addr, tc->data);
 	}
 
-	/* hopefully this worked */
-	ptrace(PTRACE_KILL, pid, NULL, NULL);
+	SAFE_PTRACE(PTRACE_CONT, pid, NULL, NULL);
 
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/ptrace/ptrace06_child.c b/testcases/kernel/syscalls/ptrace/ptrace06_child.c
new file mode 100644
index 000000000..350b0e8df
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace06_child.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Linux Test Project
+ * Copyright (C) 2015 Cyril Hrubis chrubis@suse.cz
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+int main(int argc, char *argv[])
+{
+
+	tst_res(TPASS, "%s executed", argv[0]);
+
+	return 0;
+}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
