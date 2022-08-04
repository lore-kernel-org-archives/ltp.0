Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2025BC19F29
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 00:07:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DDDA3C9422
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 02:07:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDE4B3C2730
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 02:06:50 +0200 (CEST)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 331AF1401146
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 02:06:50 +0200 (CEST)
Received: by mail-yb1-xb4a.google.com with SMTP id
 i194-20020a253bcb000000b00676d86fc5d7so9566953yba.9
 for <ltp@lists.linux.it>; Wed, 03 Aug 2022 17:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=/s7sWJVgJXKRGZujldSp/328dqIrj35uGka5nw7LCCA=;
 b=Prm1lz1wkyvC3iRVEz+7GerUA5oWIee8Trn6JiOHZS0IJeuXR6hhjp+IIlpVmyDUjp
 5aHd1dNO5nQ4rAGZet7ycbsF7nKHhM5xO+CFTUV78L+U+mY7+J25vc0oxtROqs8lzFgv
 i+IbpPQ+MS1tLBKHxjcqa63fvqsWue3/mgjAR8xvbcHWALqevzaoQpOxGibDowxnV6nn
 L58tiUqZAmrZhcD2fjlet/G9t0hR4Em9bSTXvQu9Bs9dvvsBJ18zhcIU8WfesZUsoMZQ
 fQqvuqPaWwEQARM6tvvbbtpiUZmC2ZP6fnzDc/pMe4eTVx7U+KyJoGbpeHLN0Z5Hb51I
 5CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=/s7sWJVgJXKRGZujldSp/328dqIrj35uGka5nw7LCCA=;
 b=HGYvm4GWxmGhANRq+JulJy/MO4PF4NoaBmPfKlxk6BjwXbjecKrnyRVe2qXlS+TlWr
 TLR7xtH+HOXB4DGprH44ETv0FOGEmFa68ZWtb6g4hyZQQP0EW1ibeFMAjp/2lY5fKryB
 rtLc/3RDqsefoWejvCcUcJD9mbOWr3WUM/iwjpBJFbvHBh/hY7uDdmUltWEUTW9P5hK3
 dOjyqMlV/9scwHnvUkhuguPjku2fK+bslWj1RPpRKQ+i8D7KfoOGlAFMyKWXbaz/EglW
 hUTtfAG8Xwfm1y8LZqy/kX6dNkmoRQRToAUCuW6E1lAMSacyr11I7+Ch/FyHprxaBJRh
 h+zg==
X-Gm-Message-State: ACgBeo3CfEr5hH9xvp0YHd3wA3zO66DMKHX5n5oheXeetUprpy7xywu5
 rPQT5ichlg7ODpI8La1gh1U48QmqbH9SXZVgSewxxlUCdNR2ay5Fsj7pTEfXKQQwdElCXJ2MDJC
 I5uvV0RVOWPz51uFx/n6i9VgrXtni8ppAT8F5jFDQloewumtTlLavJsJj
X-Google-Smtp-Source: AA6agR4vneJs5n/a5ksOmJUJOmMhmnc40zC/+Mmk7VsDJ41t/uL6C1vepwVezM3tD6YhOZ4zrUO2DCPKXVg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4be])
 (user=edliaw job=sendgmr) by 2002:a25:f309:0:b0:671:8725:7f22 with
 SMTP id
 c9-20020a25f309000000b0067187257f22mr22001407ybs.512.1659571608906; Wed, 03
 Aug 2022 17:06:48 -0700 (PDT)
Date: Thu,  4 Aug 2022 00:06:26 +0000
Message-Id: <20220804000626.1098734-1-edliaw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] syscalls/timerfd04: incorrect CLOCK_BOOTIME end
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

The end time was hardcoded to CLOCK_MONOTONIC and needs to be changed to
the clk_id of the test case.

Signed-off-by: Edward Liaw <edliaw@google.com>
Change-Id: I28c5b7d0132bf32cae6c50faa7d300ded42cc9f7
---
 testcases/kernel/syscalls/timerfd/timerfd04.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/timerfd/timerfd04.c b/testcases/kernel/syscalls/timerfd/timerfd04.c
index 4af91d6f8..eb7f98d5b 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd04.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd04.c
@@ -94,9 +94,9 @@ static void verify_timerfd(unsigned int n)
 
 	SAFE_WAIT(NULL);
 
-	if (tv->clock_gettime(CLOCK_MONOTONIC, tst_ts_get(&end))) {
+	if (tv->clock_gettime(tc->clk_id, tst_ts_get(&end))) {
 		tst_res(TFAIL | TERRNO, "clock_gettime(2) failed for clock %s",
-			tst_clock_name(CLOCK_MONOTONIC));
+			tst_clock_name(tc->clk_id));
 		return;
 	}
 
-- 
2.37.1.455.g008518b4e5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
