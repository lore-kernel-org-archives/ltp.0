Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF75C7EE25
	for <ltp@archiver.kernel.org>; Wed,  7 Jun 2023 12:37:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 096E63CC9AF
	for <ltp@archiver.kernel.org>; Wed,  7 Jun 2023 14:37:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4206A3CA0BA
 for <ltp@lists.linux.it>; Wed,  7 Jun 2023 14:37:01 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B06FD600BB5
 for <ltp@lists.linux.it>; Wed,  7 Jun 2023 14:37:00 +0200 (CEST)
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-75d4a4cf24aso402775585a.1
 for <ltp@lists.linux.it>; Wed, 07 Jun 2023 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686141419; x=1688733419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zek13B09uUSNSqpt+aEITUic0aTGgenqBMU1jPaZuWU=;
 b=ZOiyS8Q7tfr88dukyy3i70Ih2GImb5I4nwHOj69FnZ/LrytB0H1aq8T83h1nSGTL25
 c6eAu9nOg1BVGqG3S1bcXf5RkzY1ygtq2WbPYkCANPM2aAY48cLkC6z0E9zSyA/cHdda
 ym638Nlg0mllKTelMEVYWQMDE2Bge2XRzlkA45DBX2TK+flJkJ57sVxf93tRkJRCsqnr
 F8fXPbiK895BEAsMhJOj7dYkXkNyrG8yC3f9vB7m3wFCHRK7eWlKB7l0oBy59g9u8Lsp
 xtdRd55OsswTqamKsNCvKS3TJMn8hfgSNLegkYL73cKBvWreBRl1BUXtnxKCZqlnSyDz
 06gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686141419; x=1688733419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zek13B09uUSNSqpt+aEITUic0aTGgenqBMU1jPaZuWU=;
 b=R/bfsBW7K8fmDkNKrNNqnjfJogIzKRNxBTUhf97WbNhYGCYy/UKEuaEVAlb0JIX3k5
 479vyySYgqDb+A2RdeqIqz4hss+pWdrOUlNFoPrKEIeesJrKJvv/iaAIwQviuxJD4/Zy
 mDEs3NJtAxWZcTTvoIIf/57eamixsXiX79VplNFr2pRILBUiy1f9A1seVKMELlUvNgUw
 5MSTYJD2WwfVqiywyTR/cspofjJe2BQbiUE5hkJkPhC9vWCy4g59Y2+PUFwhAbpZIH7K
 9bgkK0yPMdsDkFxlqxYMcpEHzVM5hqmpq0P2wzKim1k9sJq1oPaXoOueKoZSFTY2MnGy
 0Wvg==
X-Gm-Message-State: AC+VfDxPOoIRWIZgMTgfL7sSTf8qDayADFmjEdcDfkbmuqradhd+OCes
 VyF577TulyW9iP+uOXen9BKNElSHYBs=
X-Google-Smtp-Source: ACHHUZ5m2i6k1Y92kxalyUXruP8Oa3x15flYk6TbyLkAQY0HemT0DymN2+TeABgW8YJFcNNcI7dOow==
X-Received: by 2002:a05:620a:2856:b0:75b:23a0:d9f6 with SMTP id
 h22-20020a05620a285600b0075b23a0d9f6mr1738825qkp.76.1686141419155; 
 Wed, 07 Jun 2023 05:36:59 -0700 (PDT)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a0cf4d4000000b00606750abaf9sm6081438qvm.136.2023.06.07.05.36.58
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 05:36:58 -0700 (PDT)
From: Murphy Zhou <jencce.kernel@gmail.com>
To: ltp@lists.linux.it
Date: Wed,  7 Jun 2023 20:36:53 +0800
Message-Id: <20230607123653.3897079-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] safe_mount: safe_umount: print debug info about
 the operation
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Make the source and the target to mount/umount visible. It's
good for debugging.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 lib/safe_macros.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index af6dd0716..6add92f06 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -898,7 +898,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	       const void *data)
 {
 	int rval = -1;
+	char mpath[PATH_MAX];
 
+	if (!realpath(target, mpath))
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"realpath(%s, s) failed", target);
+
+	tst_resm_(file, lineno, TINFO,
+		"Mounting %s to %s fstyp=%s flags=%lx",
+		source, mpath, filesystemtype, mountflags);
 	/*
 	 * Don't try using the kernel's NTFS driver when mounting NTFS, since
 	 * the kernel's NTFS driver doesn't have proper write support.
@@ -948,6 +956,13 @@ int safe_umount(const char *file, const int lineno, void (*cleanup_fn)(void),
 		const char *target)
 {
 	int rval;
+	char mpath[PATH_MAX];
+
+	if (!realpath(target, mpath))
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"realpath(%s, s) failed", target);
+
+	tst_resm_(file, lineno, TINFO, "Umounting %s", mpath);
 
 	rval = tst_umount(target);
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
