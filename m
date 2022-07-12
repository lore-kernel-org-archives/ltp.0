Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C94C43334
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 17:39:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 999AA3CA84F
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 19:39:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 421873CA1C0
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 19:39:29 +0200 (CEST)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 32A761A0093C
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 19:39:29 +0200 (CEST)
Received: by mail-yb1-xb49.google.com with SMTP id
 w15-20020a25ac0f000000b0066e50e4a553so6548043ybi.16
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=FsTJw0x4NHNbuFbtvuRhOXklbPjN5zOLro3K8nF+Efc=;
 b=qIhpbuSVq7xPI2ikEh1C+1mHxi2fFNn1Sz5NeYEzuHMIDZ8IwR4zRwfq8WzFIONE1b
 ymdumAoWq2dBW2+dzn4eLxPA54MliDE6TFceICpQJ4vAd7140kEa1k7/Em7BAg7nmxEZ
 ldg9LqVFQTSHqKOJCAUoEdeTa4uqQO3Bo8mEw+2Mb6qVceb2QnOV9cz7P1NWtXfmR/7J
 Povebd6Ovw84qfTS62B0EJjRJN4M8DO9NyOMNL3k25+RmCXg7bP2z8h9UaUFSuW7o299
 G1Ql84AhE9WQhbSbvq79t8EVA2cug0NfqrSGdZ44jCjbzlkmqCVwdU9d8ijLXpbGx4oM
 2H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=FsTJw0x4NHNbuFbtvuRhOXklbPjN5zOLro3K8nF+Efc=;
 b=DRSWpJP139KDDmG4doCr74Rg5SjTtnTLhjwYn4wI8q8HIc0ANHQB9R7cpg3s/Oyn5X
 c+os9ZeoMkZeJZ2OHeUIwPSF9BFilx9nDL436Qh+BqYAtCVysgHeL4CYrHwSbTS5+aHV
 mXA0gJP5T6BHveKQ+Wg9YY4SykWLt51n0Gb5EXnbGZVYG1OAi7rc3eslBh9mzmEjKUUz
 7W2qx5gSobSH3awyoyvYE9LwtDsroriQRUPFozlP/phLlzetNGNhxKy7crQFeyJkVfDz
 x801uLVO9yv1AkxJALj5RSSqs7Sb05dJxaDm08XVO+qBgosIb9RS8qd3oN/qrUeOJNOz
 UK7w==
X-Gm-Message-State: AJIora+OpZCHjprjg/as+O+J/WGk7NpAGz16VEXkVGASbKkayAcMrWhC
 0hPvvll2hnpsU5sKHTFG6VzzjBGedFWRmz0i+XFK53gqoF0bKj51i8kOH4HFdgb4KLsREfTkW+j
 Sk3U4yvqrZLa5SF2BRNQEop+77svCovW3noqzAjR0I7XIoi7jrictnzDl
X-Google-Smtp-Source: AGRyM1sQj1hSpKUZozLCNY31kmMhqgUSWGys1h60vV2DPaHtZX+5shbubvqOQCLhJnib974Apy/BMn/UG2I=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4be])
 (user=edliaw job=sendgmr) by 2002:a25:e6ce:0:b0:66e:a7b6:e407 with
 SMTP id
 d197-20020a25e6ce000000b0066ea7b6e407mr24329586ybh.611.1657647567759; Tue, 12
 Jul 2022 10:39:27 -0700 (PDT)
Date: Tue, 12 Jul 2022 17:39:21 +0000
Message-Id: <20220712173921.2623135-1-edliaw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] syscalls/signal06: add volatile to loop variable
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

On Android compiled with clang, the loop variable will be optimized out
unless it is tagged with volatile.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/signal/signal06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/signal/signal06.c b/testcases/kernel/syscalls/signal/signal06.c
index 64f886ee3..b40ff3e40 100644
--- a/testcases/kernel/syscalls/signal/signal06.c
+++ b/testcases/kernel/syscalls/signal/signal06.c
@@ -65,7 +65,7 @@ char altstack[4096 * 10] __attribute__((aligned(4096)));
 
 void test(void)
 {
-	int loop = 0;
+	volatile int loop = 0;
 	int pid = getpid();
 
 	D = VALUE;
-- 
2.37.0.144.g8ac04bfd2-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
