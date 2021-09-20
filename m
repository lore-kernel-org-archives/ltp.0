Return-Path: <SRS0=cJ4o=OK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CDEC433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 13:14:35 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3EC60F26
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 13:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C3EC60F26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C9963C8F7D
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 15:14:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EC973C19F3
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 15:14:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9984D1400F89
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 15:14:22 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D11AB22067;
 Mon, 20 Sep 2021 13:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1632143661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tgdRXD7Ahh3IyXeQpPS/nLIxAClTe9Yh/eVzdy2Tke0=;
 b=bcI07B5oIEjE9BtwYE3FlwDcNAKOmBLl3NFSeTCAZjDRUW/uW/9m3w6V8TuKy8T4wj6qEu
 VzSNCGGEbAE5JVmqofv3ALXJ346CQtA+UEP/8iSkaQEbjftQJwlDheeXJ/4tmy6Dcz3R76
 MSRPFFfgnYscZUR7BDJ0tahfU0yR1FI=
Received: from g78.suse.de (unknown [10.163.24.38])
 by relay2.suse.de (Postfix) with ESMTP id 8AD46A3B98;
 Mon, 20 Sep 2021 13:14:21 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 20 Sep 2021 14:14:12 +0100
Message-Id: <20210920131412.26186-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] io_pgetevents02: Pass the union member of tst_ts
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Currently we pass the whole tst_ts struct. The kernel expects the
union part of this struct.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---

Note that because bad_addr is (void *) the whole ternary expression
becomes (void *). The tc->timeout is then also implicitly cast to
void.

 testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
index af71e17fe..d763e150f 100644
--- a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
@@ -93,11 +93,8 @@ static void run(unsigned int n)
 {
 	struct time64_variants *tv = &variants[tst_variant];
 	struct tcase *tc = &tcases[n];
-	struct timespec *to;
-	sigset_t *sigmask;
-
-	sigmask = tc->sigmask ? tc->sigmask : bad_addr;
-	to = tc->timeout ? tc->timeout : bad_addr;
+	void *const to = tc->timeout ? tst_ts_get(tc->timeout) : bad_addr;
+	sigset_t *const sigmask = tc->sigmask ? tc->sigmask : bad_addr;
 
 	TEST(tv->io_pgetevents(*tc->ctx, tc->min_nr, tc->max_nr, tc->events, to,
 			       sigmask));
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
