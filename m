Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A99CCD184
	for <ltp@archiver.kernel.org>; Sun, 12 Oct 2025 19:40:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33EA43CEA5F
	for <ltp@archiver.kernel.org>; Sun, 12 Oct 2025 21:40:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F33A33CEAD4
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 21:40:19 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1A073600832
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 21:40:19 +0200 (CEST)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b50645ecfbbso724172966b.1
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760298018; x=1760902818; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcxBEHimDaBmMnfVs7Iw4D6Er9HCfvdKKz3QZr/lgYA=;
 b=D+VkCuga7EtOLmFqNuSrMsgAJr3Do8XNacZB/xnAlP3NMSGZwKk7N0nS0Ko2ygly6E
 KPAZtxMdZpf32BbKANZD14NbtoMu8jY7U4Y92SCIFsddPKrxsN+gEaL2h7mU04bDNYhe
 2fH8WVL35e2yCh1uOuErsHgRl/6G9YbFP78n6dJsd/F6svJ6iHtVhu6xNUw/6cNVuA5l
 IHsR9RbhsCSYRs8N7MwOh0tYs94p5RFbHIgV6Z9/H2LERtj4EuVQrOFwBPu+31kulj54
 yZBldE5OFK/LU2+r9K5BOb6pF+AqprWGOPGw7VPMoXdDmtR9ovT6ff7hfrfqgqqzLpNE
 4/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760298018; x=1760902818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fcxBEHimDaBmMnfVs7Iw4D6Er9HCfvdKKz3QZr/lgYA=;
 b=DVE7QRYjVb1S2eX+tTHP22GvyijwMv1LJce6Z8jOIE7/zZTw60DqL2ATJBTwwe7U18
 d1pdkKkuCrsyaUBVtR0L4BNBTQv0/4yLjfNxujN+oLsPzn+yzCXtGyhrgiIHSBRjv2Ti
 3j/JPGlr1iZK0RaCT9p6AdBpbdUA9k9T7IB1Fvpe1CImtHQI/NwVp47wA9VwOhH44urc
 QwQXBvDF0JYUSFO4lk+9wzaUqNY5Wprl0V03YVXFqL265B5kvVlmP2n41TtqbN1GRX1N
 X5IN/nwC/lzo9of8W1+v8q6CY7+dEHfOF4LK2s7Mr430KD6t1pbRFJmeWzQ9GDPUmXQ6
 iJxA==
X-Gm-Message-State: AOJu0Yw9G+GVwtP43j4evOkSnVqyRYMCcc3PJ9PV44p2poPRj7QhA4vd
 Zb4FPUPCltLRJ5lJwQvvnPbo1TDasBPl4APanEiQr+SRKlpEFO21936wD8F6HOzs
X-Gm-Gg: ASbGnctPP8jnEcjD3xj6e/UnnuuDHDVEkAD1oRAd6tmWQY1FqYMKWkCoP7QfQ5+JbsW
 b1wS6KW8QHJsBp9sKwA3D9ykeViKixHO1hh4VBnps/MCHwumnFcmOQphYfE88drNlV9EncAcE0J
 frNg+CRHdf2jpS7oMh+v7K5KgYkV3/c4ThAWoTFEn7VlEPtxu4cosmY/fasstTDPhExBDCqVXKe
 QIVWgLhkLgCOKc3Db9F2xUDkMwZHnmS0HtrH43rXMvmMxF0ztRyJzKPky0HIV9iHe22I9hL0bWh
 Wfzbwk0PtZNmwezmbNP+SWisFFgcBaeyAJMngXG/FGEoGlL6nt+i0cERBdPh1Slg0iiH7h4uNkL
 V+9QoHP6fCfI08hZG+PTHybSpwPAuFvXy05wCOfBMnD9/
X-Google-Smtp-Source: AGHT+IF+YoP4DB0rIwtkg/6bC0XUoLtD9OtAQKbh31afAUQd/HvPL2ZAk3OJDB4+iNwA5QqWHFl0NA==
X-Received: by 2002:a17:906:7949:b0:b41:2fd0:2dd4 with SMTP id
 a640c23a62f3a-b50ac5d0923mr1912396866b.61.1760298018345; 
 Sun, 12 Oct 2025 12:40:18 -0700 (PDT)
Received: from x230 (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d8c12a8esm769901666b.42.2025.10.12.12.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Oct 2025 12:40:18 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 12 Oct 2025 21:40:06 +0200
Message-ID: <20251012194007.370008-2-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012194007.370008-1-petr.vorel@gmail.com>
References: <20251012194007.370008-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] m4: mprotect04: Replace __builtin___clear_cache
 with __clear_cache
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
Cc: Hui Min Mina Chou <minachou@andestech.com>, Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

__clear_cache() should be quite common now and we already use it in
hugemmap15.c. Convert autotools m4 check to detect it.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 configure.ac                                  |  2 +-
 m4/ltp-builtin_clear_cache.m4                 | 19 ------------------
 m4/ltp-clear_cache.m4                         | 20 +++++++++++++++++++
 .../kernel/syscalls/mprotect/mprotect04.c     |  7 +++----
 4 files changed, 24 insertions(+), 24 deletions(-)
 delete mode 100644 m4/ltp-builtin_clear_cache.m4
 create mode 100644 m4/ltp-clear_cache.m4

diff --git a/configure.ac b/configure.ac
index 0480f46ca2..461fa2b577 100644
--- a/configure.ac
+++ b/configure.ac
@@ -393,9 +393,9 @@ AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./g
 # NOTE: don't create custom functions for simple checks, put them into this file
 LTP_CHECK_ACL_SUPPORT
 LTP_CHECK_ATOMIC_MEMORY_MODEL
-LTP_CHECK_BUILTIN_CLEAR_CACHE
 LTP_CHECK_CAPABILITY_SUPPORT
 LTP_CHECK_CC_WARN_OLDSTYLE
+LTP_CHECK_CLEAR_CACHE
 LTP_CHECK_CRYPTO
 LTP_CHECK_FORTIFY_SOURCE
 LTP_CHECK_KERNEL_DEVEL
diff --git a/m4/ltp-builtin_clear_cache.m4 b/m4/ltp-builtin_clear_cache.m4
deleted file mode 100644
index 86e1cfc914..0000000000
--- a/m4/ltp-builtin_clear_cache.m4
+++ /dev/null
@@ -1,19 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) Linux Test Project, 2016
-
-AC_DEFUN([LTP_CHECK_BUILTIN_CLEAR_CACHE],[
-	AC_MSG_CHECKING([for __builtin___clear_cache])
-	AC_LINK_IFELSE([AC_LANG_SOURCE([[
-int main(void) {
-	char arr[16];
-	__builtin___clear_cache(arr, arr + sizeof(arr));
-        return 0;
-}]])],[has_bcc="yes"])
-
-if test "x$has_bcc" = xyes; then
-	AC_DEFINE(HAVE_BUILTIN_CLEAR_CACHE,1,[Define to 1 if you have __builtin___clear_cache])
-	AC_MSG_RESULT(yes)
-else
-	AC_MSG_RESULT(no)
-fi
-])
diff --git a/m4/ltp-clear_cache.m4 b/m4/ltp-clear_cache.m4
new file mode 100644
index 0000000000..99c6a1b653
--- /dev/null
+++ b/m4/ltp-clear_cache.m4
@@ -0,0 +1,20 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) Linux Test Project, 2016
+dnl Copyright (c) Linux Test Project, 2025
+
+AC_DEFUN([LTP_CHECK_CLEAR_CACHE],[
+	AC_MSG_CHECKING([for __clear_cache])
+	AC_LINK_IFELSE([AC_LANG_SOURCE([[
+int main(void) {
+	char arr[16];
+	__clear_cache(arr, arr + sizeof(arr));
+        return 0;
+}]])],[has_clear_cache="yes"])
+
+if test "x$has_clear_cache" = xyes; then
+	AC_DEFINE(HAVE_CLEAR_CACHE, 1, [Define to 1 if you have __clear_cache])
+	AC_MSG_RESULT(yes)
+else
+	AC_MSG_RESULT(no)
+fi
+])
diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index 6c7f6bd017..fa4d3be4ba 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -152,11 +152,10 @@ static int page_present(void *p)
 
 static void clear_cache(void *start, int len)
 {
-#if HAVE_BUILTIN_CLEAR_CACHE == 1
-	__builtin___clear_cache(start, start + len);
+#ifdef HAVE_CLEAR_CACHE
+	__clear_cache(start, start + len);
 #else
-	tst_brkm(TCONF, cleanup,
-		"compiler doesn't have __builtin___clear_cache()");
+	tst_brkm(TCONF, cleanup, "compiler doesn't have __clear_cache()");
 #endif
 }
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
