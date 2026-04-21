Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2245F8FA72
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 13:07:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 417FF3E2D90
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 15:07:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 883EF3C5376
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 15:07:23 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0EA711400E13
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 15:07:23 +0200 (CEST)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c7973bbc16dso2788387a12.0
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776776841; x=1777381641; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=C0tEyMyD0c+WG7JTQjecXVFNbDhrNUABg5rWe30XZKg=;
 b=ncXmgiRsC65IXr/Po0R/21gN5X4d2ZcO2LUl2R5i/jlnOWW4zmvefuLPz6GXlEc9jF
 D8q7aEhPnYAqHEVwXQAUoz+yN7RBYH2+L0cyTbywz6lVonJZNt3lS31ojdgOkonIkcsE
 zB/Pgf0DfYZ5+bPP/kz2VxF3/vmFOQs3luRXaUCXrvRnj1xR6BkYfBowcAgMEpEpxnxP
 5zURE0NAiK8ZNYwejWzPo/WL9gRgVcQG47FPI/3pGjTMbeDDSEO+A1w2Iu2BAtgvKfGP
 r/ChRn0LkSGh3jlyHSn+XjUA9OcfXRyHeusjwuGIPvU4RI42aGrFYkwvPkm12MmSOCDI
 2wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776841; x=1777381641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C0tEyMyD0c+WG7JTQjecXVFNbDhrNUABg5rWe30XZKg=;
 b=KZC06iTN10YSUreruybyoIX4wDNZei9ul5d5i0CUzw5jtOE7KnZz7vBbtNhUWjiwfN
 ZRCF6EuLv3BDy9fysG4Js6li1ecU+zSlO6qSluk2MVxbahfbfNBP+uewk8HNldsgZW+G
 JPsVM0U0Y2nA5jxvAHsp3NoaErb/sFxMlr+TBOG2vOYvOJsiIR2fp46bBjeuOsZ0K/p+
 yeW/6KmuzLZx8oD9lxX6lBeR+96ue5II0Ix7R5OxbtAewArB3O6uZibcx2u+RZOlCJqz
 89lKY9WdWEE0AdZkePyiVSg3VVXmtpC+sxBOuUZEz/DuVbzIfY54lHu77JPZz/7yBEQ/
 8rUg==
X-Gm-Message-State: AOJu0YwIod4Ih87fP6fxihRUaYO3cXY0oS3V1Zlj0RQDl5CwEbZhySLW
 6U55/FAfXGeGgeeStJWv7XWBGCYRAe5ZIRtI4+ojdjr5Eh5rFieHWTYA776rrgi8nsqZ
X-Gm-Gg: AeBDiesuTKfIKX2x8xLHPLwhy6cEWpTaI5Uk4JQ55Q+FHhTT2aAtldbSUW5NZU3ggNU
 MYfLJZTc6c9W3He0pLi24rZ5/p5SXOMd8inh6KE2aj3M+8m2f6ZYQzq+bCQT+DHF56zf+L9piTc
 LswjZ6AE/v7zfOclOSP90lkSUaEBOcD0g1jdHQI9ltMdOG6i8JowWvzxHu4TpiW/xLrZupuZ2kA
 z0RG7/U7DG4s4o4CjSZah7lJXlrQ6gJ3JX1kCG1UKFWAS09C+fQHRlIX6lj+4tWXfsj/0DRx99e
 eiQRQ1Jl6IMFaTb+dcrmhrZutzfwVG3l9I8B0d1nnJCURlw0yMtY5xsz3VLAe/s28IGOTBTa0QG
 RE+sixLd4QBLcPl7pjpi/wwv04cTs7H55+80KGftWJbHmVwHKpQwBG0+MvxOjmGLHLgRPfnTi1D
 xqVX3x5RJsnNgCgfIbzaKTF/bL6v+Bs6Gx
X-Received: by 2002:a05:6a20:7f90:b0:3a2:e089:ae5a with SMTP id
 adf61e73a8af0-3a2e089b366mr5122156637.20.1776776841199; 
 Tue, 21 Apr 2026 06:07:21 -0700 (PDT)
Received: from thoundrobot ([43.154.64.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ea02ef7sm12790026b3a.25.2026.04.21.06.07.19
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 06:07:20 -0700 (PDT)
From: Li Wang <wangli.ahau@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 21 Apr 2026 21:07:06 +0800
Message-ID: <20260421130706.14254-1-wangli.ahau@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/tst_kconfig: rename runtime_check to
 config_runtime_map
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

Rename struct 'runtime_check' to 'config_runtime_map' and
array 'runtime_checks' to 'config_runtime_maps' to better
reflect their purpose of mapping kconfig options to runtime
checks.

Rename function runtime_check to kconfig_runtime_check for
consistency with kconfig_module_check().

Follow-up: d7d6512e89 ("lib: tst_kconfig: Add module presence checks")
Signed-off-by: Li Wang <wangli.ahau@gmail.com>
---

Notes:
    Hi Cyril,
    
        It seems you forgot to add this modification at the top of
        the patchset. So I made it for the name consistency.

 lib/tst_kconfig.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index f4d4a8679..44eacc7c2 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -112,10 +112,10 @@ static void close_kconfig(FILE *fp)
 		fclose(fp);
 }
 
-static struct runtime_check {
+static struct config_runtime_map {
 	const char *config;
 	bool (*runtime_check)(void);
-} runtime_checks[] = {
+} config_runtime_maps[] = {
 	{"CONFIG_USER_NS", tst_user_ns_enabled},
 	{"CONFIG_NET_NS", tst_net_ns_enabled},
 	{"CONFIG_PID_NS", tst_pid_ns_enabled},
@@ -124,17 +124,17 @@ static struct runtime_check {
 	{}
 };
 
-static void runtime_check(struct tst_kconfig_var *var)
+static void kconfig_runtime_check(struct tst_kconfig_var *var)
 {
 	size_t i;
 
-	for (i = 0; runtime_checks[i].config; i++) {
-		if (strcmp(runtime_checks[i].config, var->id))
+	for (i = 0; config_runtime_maps[i].config; i++) {
+		if (strcmp(config_runtime_maps[i].config, var->id))
 			continue;
 
 		tst_res(TDEBUG, "Running runtime check for '%s'", var->id);
 
-		if (!runtime_checks[i].runtime_check()) {
+		if (!config_runtime_maps[i].runtime_check()) {
 			tst_res(TINFO,
 				"%s=%c present but disabled at runtime",
 				var->id, var->choice);
@@ -257,11 +257,11 @@ out:
 			switch (val[0]) {
 			case 'y':
 				vars[i].choice = 'y';
-				runtime_check(&vars[i]);
+				kconfig_runtime_check(&vars[i]);
 				return 1;
 			case 'm':
 				vars[i].choice = 'm';
-				runtime_check(&vars[i]);
+				kconfig_runtime_check(&vars[i]);
 				kconfig_module_check(&vars[i]);
 				return 1;
 			}
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
