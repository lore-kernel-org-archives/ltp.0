Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6BDE7716A
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 06:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734416276; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=jbp/jDOnReZtPAkLM6aRnnlRhazesQnGt4Bu0/drkP0=;
 b=Gr22DTF4DLw80YRV97joL9h7rbt7kMO27MlXEHs5wqAD8qfZ0xNpiSRDB3I7RKgM0rzYs
 mfazm1cdI1tl0znI9lctMXVN9E2wSrNa9axbVHGd6tfJy+vDsrphciRNFNdRaVKPSGxiJGY
 cXqwHbBYqeD3Tc4w4XWjOEOtfurP/o8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 135643E29B0
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 07:17:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98DC13E29B4
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 07:17:00 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BAB701430CED
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 07:16:59 +0100 (CET)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa5f1909d6fso826619166b.3
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 22:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734416218; x=1735021018; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPR8XYD+KtOe6RlLwGHcqHRAn0mNjTUeo3X/uMdGX9E=;
 b=g2w+wXOesx3TkwZEl7InJArN9ePRysVYGMkEaRnLVYzKEMdiTNFMvwtI2zfSF3Y/gt
 dVp6NSvRMl9rmRYwKfsd29614sWI5aIdWNj7acGyh8qasyyzjZDkJNkgJZwijswU3mFo
 md4ZFHf0jnSLlCXznAxQ3UVe9EOBDsmJ3AhSMKjCaWXJfghGRhvqr5DDllozwjVmBOMw
 dDbOa2ngxzxdTuUfy/e1rpyNgstUcufbeWhMr6wCfC2i0VPp3VMYqnQ0SPEQfi00XzdF
 JtUrDI07eSFXz6e1p+/LvTdy0Z9D1zyJIHvkIS56uhLOpeKDkpZoKaHOUrBfiUdRWNp1
 8xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734416218; x=1735021018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPR8XYD+KtOe6RlLwGHcqHRAn0mNjTUeo3X/uMdGX9E=;
 b=fYzqh3RuCmKfYqWN5OGvnhTAm/fomla5t4sW1MNJsWFQhuWL4QkQ+8tPirxrFG0Htl
 zTlARh28/HlfVpS1/gpqHeFAJTJUzlf1sR+sDfqk2A1ffRTwF2XifK7raQr3YsikOgCy
 SAsrPbIs1nsqkyv5YA2Vw8l+pPk9sBADBZ89M160ZWI1y8175wYQYjRnLuiUUnatfZdO
 ZaamY7jNWNI6xydqUWDp7zNBxqMtlm+Wx/E0ziHadKvW1zWAJA744TtghBmJfn8yByC4
 Fft9fmt5uAh9kAXKZWPFvnXm08OnEm1JAFuFzLnSgLDBx9HX4mp02IZ0Y1mhUiquxPlj
 uuMg==
X-Gm-Message-State: AOJu0Yww7sDScxZ7V9GTkNU/VwdscCWdZ6N0eJOXNObNytd/brjU41wl
 hL27QeDyeJxNS6oczvLTwRSEoCW6fH4Rwcngwkk5OzHhU18wKuUeTbE9DbgZZiuKB7NaYBX8ow0
 =
X-Gm-Gg: ASbGnct+MqqsYskVgiVYczu6ChksLmnJdsvceqwTxgfF3qS9sS4EtiAtqY3JdCcGmJ7
 5fCruOsc5tabCi3s20KUH1SJZTM03TI2wskIF6L2nRQOhQYGvUthZeCWMvj/nIhJoN5KAeJSu5k
 TP8M54QlFfdg5Fj2WIbXF/z+uwsnj+vAJhdBrsvAsSRT9RB/cIhhBzjoqS6b0h2qSIq2bt6lrN7
 A5e02i+nCwzW2mvejAcJFd328UULbupBH2oDO/x22ppBA==
X-Google-Smtp-Source: AGHT+IFuZBnD2misfFgIpgpdnaxL/OcaN3q7YP+PbvgZ6NbeHNlWOOaCiHKs4/APeufmfS5wRIuGcg==
X-Received: by 2002:a17:907:7f8a:b0:aa6:7ec4:8bac with SMTP id
 a640c23a62f3a-aab7795ff10mr1838273566b.17.1734416218430; 
 Mon, 16 Dec 2024 22:16:58 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab9638ec32sm402843266b.151.2024.12.16.22.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 22:16:58 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 17 Dec 2024 01:16:36 -0500
Message-Id: <20241217061636.16366-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241217061636.16366-1-wegao@suse.com>
References: <20240603103553.8318-1-wegao@suse.com>
 <20241217061636.16366-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] ptrace06: Refactor the test using new LTP API
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
 testcases/kernel/syscalls/ptrace/ptrace06.c   | 325 ++++++++++--------
 .../kernel/syscalls/ptrace/ptrace06_child.c   |  16 +
 2 files changed, 194 insertions(+), 147 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace06_child.c

diff --git a/testcases/kernel/syscalls/ptrace/ptrace06.c b/testcases/kernel/syscalls/ptrace/ptrace06.c
index a1db3bab8..e112803bf 100644
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
@@ -32,168 +31,200 @@
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
 
-int main(int argc, char *argv[])
+static inline char *strptrace(int request)
+{
+	return strings[request];
+}
+
+static void child(void)
+{
+
+	char path[512];
+
+	SAFE_PTRACE(PTRACE_TRACEME, 0, NULL, NULL);
+	raise(SIGSTOP);
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
+	int exp_errnos[] = {EIO, EFAULT};
 
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
+					 strptrace(tc->request), tc->addr, tc->data);
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
