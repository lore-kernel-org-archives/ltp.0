Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC43C61DA3
	for <ltp@archiver.kernel.org>; Wed, 22 Feb 2023 01:16:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35E003CBD00
	for <ltp@archiver.kernel.org>; Wed, 22 Feb 2023 02:16:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2064B3CBC76
 for <ltp@lists.linux.it>; Wed, 22 Feb 2023 02:16:42 +0100 (CET)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4BA3A14004E3
 for <ltp@lists.linux.it>; Wed, 22 Feb 2023 02:16:42 +0100 (CET)
Received: by mail-pj1-x1049.google.com with SMTP id
 m11-20020a17090ab78b00b002373d0c6bddso368307pjr.0
 for <ltp@lists.linux.it>; Tue, 21 Feb 2023 17:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1677028600;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nPBDzU4dv8jt6wBIQDxW1JqgYvOc0sP9QCPLAGyqxME=;
 b=SGUUsdjIARrj3ggON/0zqmNTIXdbjNaK/CuEjpoqvKjkGkjSQadnowCtME0x3Q7DYx
 AhKJgu1Gqc9OhssRiApGkvxgwchhJOhVHedxd5tVYJ5nImiFWT5GecZQUkEaIATJ3dgr
 eGPYLBt2hLdACl4xRntESu3QSYABLgjsXAtM8PA7r0GHa3AeGkWdFvmOnjv2+0GDzaxU
 hdQKWNptRv8RsW7iYVJvBKfqBBZ3badzDjPALmbGdyQ5WjLKzFIdlZCYOMzUhM4wxlgK
 GM7z8Tz3BUa72NLHuKCNj67PGrWILuovWCyvJOrjdawElKZ6ND3/Rs188jokHbmJWo/a
 lTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677028600;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nPBDzU4dv8jt6wBIQDxW1JqgYvOc0sP9QCPLAGyqxME=;
 b=EgMXpg5O9fpEeHzuunwtlB7RYNE4+CG2BWIchNgWhcW6TQizRIVMysi5XBU4Y3Zugo
 IuDR3Zdie/OpPemVkaxYpRUUhOD/Z31/tuh1NQVp1xoJ8mj5/sG2xeDj7IULG2J/JAjK
 ULsav/3jEXyvrN7sMOVa3oGHAWCz70z6daAM/0E3pXPvq16CCtEj/P6PMYLpojwfxzhd
 8DBPd1q/FbeFbAIxpt+TORyIjtVnwb7YMcOg9iciYiGeYwFQkDHcsTc3ro30oiXlHcKX
 SJCdiG0YrgEyHvZMnTMi65U+p5L/YIqDWifpKGoyfUP3RGHXCt3ZjJwtXMcdz88kfgCN
 yu2Q==
X-Gm-Message-State: AO0yUKUmvgQepOF9T8noQ+ofh8CzfQ2MVqtPv/c+KRyMWdJdAfamuD2x
 P8u+m+SBSm30jPCEO3Hu0OCYEsbt2tR5uoEG5tJl5ywWsvnCTn74svhf/sIjJEAAsx/DwSjxSbC
 qz5nUJWRWfExsjZeSS84HI7lM2vamJsiyWkvD4q73cNp31RMz8YBEeMZU
X-Google-Smtp-Source: AK7set9zB8suJXkYv1ne9q70zPNIqvLnqDsPDYpsTuexlOj/0ITKSrU3lFVDZh4So5lTo5hdGrrjuFEwcyk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:ef94:b0:19c:a7e5:281f with SMTP id
 iz20-20020a170902ef9400b0019ca7e5281fmr108904plb.23.1677028600053; Tue, 21
 Feb 2023 17:16:40 -0800 (PST)
Date: Wed, 22 Feb 2023 01:16:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230222011635.1567189-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] syscall01: use 32bit syscalls if available
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

With CONFIG_UID16 disabled on x86, this test will fail to find the 16bit
syscalls for getuid and getgid.  Instead, use the 32bit calls if they
exist to match the behavior of glibc.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/syscall/syscall01.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/syscall/syscall01.c b/testcases/kernel/syscalls/syscall/syscall01.c
index 167e6ee86..76e793221 100644
--- a/testcases/kernel/syscalls/syscall/syscall01.c
+++ b/testcases/kernel/syscalls/syscall/syscall01.c
@@ -37,7 +37,11 @@ static void verify_getuid(void)
 	uid_t u1, u2;
 
 	u1 = getuid();
+#ifdef SYS_getuid32
+	u2 = syscall(SYS_getuid32);
+#else
 	u2 = syscall(SYS_getuid);
+#endif
 
 	if (u1 == u2) {
 		tst_res(TPASS, "getuid() == syscall(SYS_getuid)");
@@ -52,7 +56,11 @@ static void verify_getgid(void)
 	gid_t g1, g2;
 
 	g1 = getgid();
+#ifdef SYS_getgid32
+	g2 = syscall(SYS_getgid32);
+#else
 	g2 = syscall(SYS_getgid);
+#endif
 
 	if (g1 == g2) {
 		tst_res(TPASS, "getgid() == syscall(SYS_getgid)");
-- 
2.39.2.637.g21b0678d19-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
