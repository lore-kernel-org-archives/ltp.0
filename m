Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BF9C4332F
	for <ltp@archiver.kernel.org>; Tue,  7 Nov 2023 18:41:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3285F3CE84C
	for <ltp@archiver.kernel.org>; Tue,  7 Nov 2023 19:41:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1AF43CC6C1
 for <ltp@lists.linux.it>; Tue,  7 Nov 2023 19:41:21 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D3D54600AAA
 for <ltp@lists.linux.it>; Tue,  7 Nov 2023 19:41:20 +0100 (CET)
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-da3b6438170so6019383276.1
 for <ltp@lists.linux.it>; Tue, 07 Nov 2023 10:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699382479; x=1699987279; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CW+9pEJYp0UpZG4DFf3RhYygmFxrJ9tJKhFTtuXeA08=;
 b=wvH9nClhlgW9B3rzWNhr8y6gT+BXJYtypmzgv/3LoOVOMDEQ+tgjDP1dN5mWn+CpMi
 QFbtRo2gPhWTEpOnQtiqzDoXzmgoOTAxGJ9ZmSVKGcmfgR83M/ZTna+ZxqisLP+Z8E7c
 m5gkqM/TmF5Wz9XAGJ+dQrpvfazMF62nkwHFtq4bkOTdiRokStKaPqg5+xN5dXfz2qQH
 MtH2QqpBjS8+HjlM49sfDiTB95u6KkiIRbhfkJU6apRXXSUYySdYyixeVWYLud+pcEUt
 n3Wmno2kUwK/BVS3H/lESz2u5/T/cUVelvNPkLlkkd7UlfRLsGbUr79D1BCFUgrDmsBk
 YYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699382479; x=1699987279;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CW+9pEJYp0UpZG4DFf3RhYygmFxrJ9tJKhFTtuXeA08=;
 b=sCWza9zo6tO6DFs7yNFaLQGTMM1q5d8WevLls90JQYBLB/J8xa4s5hM+UXzF2MRY7e
 riDuJ2dAYOWC0CqZFL3KluX0VAgR5qRXT1tzq4himaHEIP1RvFFCqmtduWcdkrURfuyD
 eT6tqEy21eIEQilgFkHOrJsJszY4wsE6nRqezutge/LFm2M7Jfswv6l9pt5Euorfv6Vj
 yWb39I1b6Bszkt/Dg4tKhaRc6uPFoboXbzkqzrtGtf9IpAXdzUUAYR/vWAMP83pNSbZ0
 lXe0L9HO/Enmmz3C8lJQTWlHSZ2xiKAJtlsAFbXmaa2qfjnEXiIQkRYbfbCv+xuIYDGu
 5cUg==
X-Gm-Message-State: AOJu0YwsEIOkW2PZWr6b00rz6mqklTHvUwpkBCue3Aoruqt2gPAVH18a
 +fq+Cc8+V/1IMR2XAxy5/+RvnbNkaxbZMN77QIojesN0Cdty3rxGG5yTD/0DQiGOh0DyFMVsg/Z
 Ka4tg82AZJndWGChLI1QfGC9WY98r7F0RhcM1vKfxJycPUPaRKfXFLMTC
X-Google-Smtp-Source: AGHT+IHGwjrFl1nmT3J0T73dn4W+UaHEy5tP6dqQjV9vA27XZsr0mMRzFCloUL4efW22xpQuP358j+Z1BY0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:cb02:0:b0:d89:dd12:163d with SMTP id
 b2-20020a25cb02000000b00d89dd12163dmr620794ybg.1.1699382479028; Tue, 07 Nov
 2023 10:41:19 -0800 (PST)
Date: Tue,  7 Nov 2023 18:41:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107184113.2627463-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] madvise11: Allow test to skip if MADV_SOFT_OFFLINE
 is not supported
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

madvise11 will exit with TFAIL if CONFIG_MEMORY_FAILURE is not
configured.  Require it to be set instead.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/madvise/madvise11.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 74caadc44..7a12abf20 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -426,6 +426,10 @@ static struct tst_test test = {
 		"rmmod",
 		NULL
 	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_MEMORY_FAILURE=y",
+		NULL
+	},
 	.max_runtime = 30,
 	.needs_checkpoints = 1,
 	.setup = setup,
-- 
2.42.0.869.gea05f2083d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
