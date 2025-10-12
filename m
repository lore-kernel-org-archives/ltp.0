Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5986ACCD184
	for <ltp@archiver.kernel.org>; Sun, 12 Oct 2025 19:50:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F02C03CEB43
	for <ltp@archiver.kernel.org>; Sun, 12 Oct 2025 21:50:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9EE93CE88E
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 21:49:54 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1A96E600825
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 21:49:54 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b00a9989633so652922966b.0
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760298593; x=1760903393; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EEX5tjRqUMJCq0nC1MVMI++imKjP3bVOft+21sJOTc=;
 b=hQmrvtQOdtc3cMTiRn3DagG5oD5q8Fp5327lemU68P+Tnl9OAEtrrnVHLVoub+y2E+
 X9tDBpnpHr5Vi9EVAQV2OmrDfmtrSTVag4nvd+FN3K6IOckbrZG3HoZwFbZKhx9Ngo1G
 BFDEhXNHEb2gETMazbcGD3t0pLqym9M2oQObx5O0++SuwPzwg7aovKMk/eoAu8bn8UAD
 xLxQj9Oa0bglZSB2pwsIFHV0O6OIpNtDqmwwDgyblXev0eWdfA++hB4KWgX78ZFz/yif
 /RXSGZsF5gfxG5gz3+HAwRqRYSUED/2Qow7dsO/FeFqRnpm/045I1s1fY7RXkUkw6NmN
 D+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760298593; x=1760903393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/EEX5tjRqUMJCq0nC1MVMI++imKjP3bVOft+21sJOTc=;
 b=eKBUzE5nuj0/UTII6njZjfrMY3zgjFV3Ln57jBPyQjUV8DIUrX2bQIUEEy/flIRnEJ
 Us8mA63RRIT0qLWIZC2R3439xqU12r4VGg3AgQeEDYQS1fsVhGK3WdI+gdj2hB4dY2XP
 zLJCpRaZt4UnehCnokDXDZETbVJzUAkCCJxB9wjqD5mY5geLDxVnAYsTWW0Pi7TYT0Zz
 gPtJSwOFpsue4d2hK3fSr5GwkbNW8GdXex7UIFcoKkygYt+f6TlNuqC69n7S0+kNtksm
 x7MwJXFFpalbZojNKHZ4oFxFq0MwW1axhxQuA0g1Sxiu8sIDupsHHfoLsNqLmTG4fmi6
 VHEg==
X-Gm-Message-State: AOJu0YzD49h8D5+UV2p2fkeBgJeUYCUTgirzeRJN3JEFJLX0JACpUFM+
 k3M3fHXXdyyNzvlGZ9klyHfXExHS9eQLOeQ7SDjGlLFAVqh/EY9xURxXUVC+K2Bn
X-Gm-Gg: ASbGncv3tMolaKxP8FxUz69svGPG8VEE082CdPxYlC/hkpfQJ/Aeosc42BdfdjL5qgS
 6tg3T0OZumH/nzCIOTCBtK1qyhyWSgN6ao+YhEfdQOgIX4/Fl1RWMX6nAz5S8A+k8p0wdQ3q102
 8THdsj0gfbKp3wNpZuVcyD6SAroyJAeu3cYMoCeyWn/gmcFXgraAEb2fIQouMBhqcXdUXOOvPYD
 IyGypz2y/jEb0CawlLEjUGJOLl5IdPu3YA17x1tS5FDIWQR+kjnLdJnXkJCyzL5jUCy5XZxh+Oy
 aWKU5nIT5+u1W13ePKA5CvECclriqyuhIJYTuDSE43C6NkHag3PJ7SUdeVk4L04X3S1XGCXpbH1
 8AZn6vZslewBTx/x6KzmjK5bE/OSOpSiRy++2dgTnu8KymV0/a4MQYn8=
X-Google-Smtp-Source: AGHT+IGzz/qkW7ug4qmEwjPCqn330LoAN7q2DK57jhOhWXmSQFKcVxVQeKTj3kWWOCzwDg2PFRutWA==
X-Received: by 2002:a17:906:6a16:b0:b23:20e7:b480 with SMTP id
 a640c23a62f3a-b50bedbf4f1mr2363029466b.18.1760298593388; 
 Sun, 12 Oct 2025 12:49:53 -0700 (PDT)
Received: from x230 (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d5cad938sm767759466b.2.2025.10.12.12.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Oct 2025 12:49:53 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 12 Oct 2025 21:49:45 +0200
Message-ID: <20251012194946.370905-2-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012194946.370905-1-petr.vorel@gmail.com>
References: <20251012194946.370905-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] m4: mprotect04: Replace
 __builtin___clear_cache with __clear_cache
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
Same as v1.

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
