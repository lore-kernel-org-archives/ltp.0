Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0432C25B76
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 10:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717411038; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=QQjZB1kvxvEwFZQZOpuhS0Ug72oZ+USWXwL54RqhGcw=;
 b=bwyjC18mJnqRIbRZvtJPedxeoRWJzRH6t3LE1+uwu2tBqQVo1OnoA6nXFTNsha6sDlgn6
 x0MN311pi/yT6GjvSryh0PbsJHdGuPKNiQcTIciY2lI7HFd06c/Z+Wiuxz8FOL96TDiT8MZ
 bsR+G82v4iZNAs/eOPxBdHvnIRkhGGs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C7393D08EC
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 12:37:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06D7B3D08E3
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 12:36:26 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 108111401216
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 12:36:26 +0200 (CEST)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2e964acff1aso45598981fa.0
 for <ltp@lists.linux.it>; Mon, 03 Jun 2024 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717410985; x=1718015785; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQ4zfKTRDQBRqSU6vUxNFwBooRPvqYoQUVUwS8pd1qU=;
 b=BA+phRA6LZOdjhPkY9UEB8A6+r9j9alGTzlG13Re5AVrHAp9Knfu81FC8/+KPUzQvj
 2NRWwtiB15jfKYiT936PfcjegRH9r6qF4rbANQdG9fUyuf5uDEkHAvhmMlRU/wHWyiVs
 NsCJn8dWTeZrL/gTX7thw+dxHvKYu/CCp32IvJESIlDli/dX/duwnwH2oPMnFTxx/cpW
 YnOaCW790qqrJ8T4+sSb0EOShQpmo4Uy1yP9KAKplQobyNbl7qmUYCQpZjfJwDfslieS
 01MTuedwnjceVoP8axXjPrM34WbS/PdZ1C27Ss0LVeCf+VspvvRpCuqK4bM7sLfdH1bU
 4D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717410985; x=1718015785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQ4zfKTRDQBRqSU6vUxNFwBooRPvqYoQUVUwS8pd1qU=;
 b=qNhWlDPXaGm1BPUx2/Lsxu+Pvg0LOIAvTxQQP3wWCTV5MJW4tgMyOPO6HfWC50Eid3
 gEVQVcGkgXroD6GVkwrpqGV5q4IRT4m7HwOoWV2iHxChnsTBh9OEOMe47e82r9ke374Q
 MHswZAOM7OLqkLvUNbCWzL3w1XUo0NKDl/0fJvaem1TeQoPpZJ0bpxec+bqCA89xOJDw
 vC6Rohi2cv5WthzfZrd/d5RJ8suO+cnHommmYhHgIXT7Al/Exs6A4i0BVJH2hBVlN/1q
 i+FXX17R7lD+gSdvfM03EoUINRgtcB/blU7fwTHQAcmxaDHZTtTjdMA4zlveD2YRI6aF
 SMcw==
X-Gm-Message-State: AOJu0YwDsxbcSJ6Nr6huYHbhmdyJX7xEwnwvSM33FHoeADKlYvyIhKL8
 jGNUuUu+7x/K2+76hxa1wg2he1rm280WvagnTDQiKM0SfXQfsDOgP09n4rKe2OEJYILdM01Ffss
 =
X-Google-Smtp-Source: AGHT+IHiSOUStERMu2CJCeoI3UR0ntunHbUxfHbSZfJA2pOuwM3JfZDRyO6aviWV+hJtF3aYYsEz/g==
X-Received: by 2002:a05:651c:212:b0:2e9:870c:de1d with SMTP id
 38308e7fff4ca-2ea951e08d1mr57100381fa.39.1717410984957; 
 Mon, 03 Jun 2024 03:36:24 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c23b09b3e3sm1418202a91.49.2024.06.03.03.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 03:36:24 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  3 Jun 2024 06:35:53 -0400
Message-Id: <20240603103553.8318-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240603103553.8318-1-wegao@suse.com>
References: <20231201005902.15630-1-wegao@suse.com>
 <20240603103553.8318-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] ptrace06: Refactor the test using new LTP API
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
---
 testcases/kernel/syscalls/ptrace/ptrace06.c   | 326 ++++++++++--------
 .../kernel/syscalls/ptrace/ptrace06_child.c   |  16 +
 2 files changed, 202 insertions(+), 140 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace06_child.c

diff --git a/testcases/kernel/syscalls/ptrace/ptrace06.c b/testcases/kernel/syscalls/ptrace/ptrace06.c
index a1db3bab8..de9335355 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace06.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace06.c
@@ -1,29 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) 2008 Analog Devices Inc.
+ * Copyright (c) Linux Test Project, 2009-2022
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
  * check out-of-bound/unaligned addresses given to
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
 #define SIZEOF_USER 284
 #elif defined(__x86_64__)
@@ -32,168 +31,215 @@
 #define SIZEOF_USER 0x1000	/* just pick a big number */
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
 #endif
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
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
+#endif
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
+};
+
+static inline char *strptrace(int request)
+{
+	return strings[request];
+}
+
+static void child(void)
+{
 
-int main(int argc, char *argv[])
+	char path[512];
+
+	SAFE_PTRACE(PTRACE_TRACEME, 0, NULL, NULL);
+
+	if (tst_get_path("ptrace06_child", path, sizeof(path)))
+		tst_brk(TCONF, "Couldn't find ptrace06_child in $PATH");
+
+	TEST(execl(path, "ptrace06_child", "", NULL));
+	tst_brk(TFAIL | TTERRNO,
+			"Failed to execute execl01_child");
+	exit(0);
+}
+
+static void run(void)
 {
 	size_t i;
-	long ret;
-	int saved_errno;
+	int pid;
+	int status;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	pid = SAFE_FORK();
 
-	make_a_baby(argc, argv);
+	if (!pid)
+		child();
+
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
+		TEST(ptrace(tc->request, pid, (void *)tc->addr,
+					(void *)tc->data));
+		if (TST_RET != -1)
+			tst_brk(TFAIL | TERRNO,
 				 "ptrace(%s, ..., %li, %li) returned %li instead of -1",
 				 strptrace(tc->request), tc->addr, tc->data,
-				 ret);
-		else if (saved_errno != EIO && saved_errno != EFAULT)
-			tst_resm(TFAIL,
+				 TST_RET);
+		else if (TST_ERR != EIO && TST_ERR != EFAULT)
+			tst_brk(TFAIL | TERRNO,
 				 "ptrace(%s, ..., %li, %li) expected errno EIO or EFAULT; actual: %i (%s)",
 				 strptrace(tc->request), tc->addr, tc->data,
-				 saved_errno, strerror(saved_errno));
+				 TST_ERR, strerror(TST_ERR));
 		else
-			tst_resm(TPASS,
+			tst_res(TPASS,
 				 "ptrace(%s, ..., %li, %li) failed as expected",
 				 strptrace(tc->request), tc->addr, tc->data);
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
