Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6387DC197BF
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 18:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740682177; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=oU6e8HAzJ0RySktrf7Ka/icqSrQVJ6ZFlVR4mtOu/64=;
 b=SB7BfoyDoI8HeWP6tjb3ULFfmg3lzsKW6WWD95R3FNVxAsFEHYJ6jv1uhWbQ2i5eO6Oyf
 F121HO9ioNYfdLr+aptc+6CjEsXLVVomab6IIeXcPaxIMI/UqVwUROY7tjN8FWxz/sROIwN
 LhPW4r5JfM0irq+d+hTpguw0sI3EOSE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A5EF3C9E35
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 19:49:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98FFE3C9CA9
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 19:49:16 +0100 (CET)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 15D1C656FC9
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 19:49:16 +0100 (CET)
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2fc518f0564so2923780a91.2
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 10:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740682154; x=1741286954; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hfpMHficPWrAzmqPn/uU3GSK8Z7WKtGRF7GafZQXVK0=;
 b=hy6l2eKVEk7MY6PkbKFrXIxq7Lmkbaqi20Fa2hkvbX1Fto7ZFSShFju1J9qhqvhV/R
 gVfpHqdbrNywr0/T/cUDiwy6jgzZj3hUJT1aaLoFrynFXP4H78/6WPtTWiAx0LrXGXh5
 3h6dO3MZfsl1J5QuJCHOZAyrvXsFG/M3fYnELRa5HyreAmQBoU2ZDqp2OUWvJbQgoKUX
 Ma/74pS+sfMsZlXkbSyfIsWEj7lkCd3QQV8zofJn9zdxttzaFFF4h4lUlQAoTKtXuH4M
 57m/QzTBkFFzIM4bqAkQM93l8I4sqZ4uiLO2uOMIFkqweST6C+gCvvuu06PGvoZW6zlF
 b8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740682154; x=1741286954;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hfpMHficPWrAzmqPn/uU3GSK8Z7WKtGRF7GafZQXVK0=;
 b=w27h8gxZlDWbl+3xNY3u7DCXkZYsBItR//jEM0YqlyckDq0AYC4BHamqA5I7IinsO4
 DXbyCON98KH5s/bCDxkRwJPjiroA4DREX9HsHqwr84WC7K1IbdD5Ehk6wsJvwStMZe6M
 izFN7GchSmwgP5YttvCQJ8aCNNxU2r7n0DBjfJYN03OVXp/udS5/aFf6kuLRVSLaAIxx
 hmz0zFAAvpFc9Ez5ZDtZNMOmGfwF+aKKfEV7uK95n1okZTms9mNgjaaLdoPzZtNtHYNi
 IOLDDuFwfSpSPhY+KwZqRHqkjYDh23Z4s6zOVg70J+9M7qQ0aRSn7FHn2aVGQLk2bZe+
 YeBA==
X-Gm-Message-State: AOJu0YzuP3UTlwYQz7AHOE2R2KQpFi4knmCcmW1URqFgfNEd7p9b+Cvw
 awrZCQQNLlO82BW2+0UgeUolNeNLIbi9iqlpEhoP0EiDRWUgP1x3Ldt9BFqU4rm1U+4FXnJ63A3
 FxQQ34gqrW8pnaJj2fKC9v7bJ7crvbz1yVR4VAi+n7lR6NPeX3cPLtdYPgupsZUiZ1/JXRhTjht
 60mJZTePb3BRFHcvfzKPcSEYqsLys=
X-Google-Smtp-Source: AGHT+IFX+eMRG1U0jeQHiDNRbvysveuC0iz7z3is+s+AzguPnb39FjXHNt2dUL4KeGvb/RGIX1ugZx4/kys=
X-Received: from pjbsf12.prod.google.com ([2002:a17:90b:51cc:b0:2e9:38ea:ca0f])
 (user=edliaw job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3ec4:b0:2ee:f80c:6889
 with SMTP id 98e67ed59e1d1-2febabe1e9amr648594a91.33.1740682154442; Thu, 27
 Feb 2025 10:49:14 -0800 (PST)
Date: Thu, 27 Feb 2025 18:49:07 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227184907.392133-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] perf_event_open02: set process as RT during Setup
 stage
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
Cc: "kuan-ying.zhu" <kuan-ying.zhu@mediatek.com>, kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: "kuan-ying.zhu" <kuan-ying.zhu@mediatek.com>

Move the action of set the task RT from the Verify stage to the Setup
stage. Avoid potential risks of task migration due to scheduler policy.

Signed-off-by: kuan-ying.zhu <kuan-ying.zhu@mediatek.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../syscalls/perf_event_open/perf_event_open02.c    | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 7306ecf51..7b3305a52 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -198,6 +198,12 @@ static void setup(void)
 {
 	int i;
 	struct perf_event_attr tsk_event, hw_event;
+	struct sched_param sparam = {.sched_priority = 1};
+
+	if (sched_setscheduler(0, SCHED_FIFO, &sparam)) {
+		tst_brk(TBROK | TERRNO,
+			"sched_setscheduler(0, SCHED_FIFO, ...) failed");
+	}
 
 	for (i = 0; i < MAX_CTRS; i++) {
 		hwfd[i] = -1;
@@ -271,12 +277,7 @@ static void verify(void)
 	unsigned long long vtsum = 0, vhsum = 0;
 	int i;
 	double ratio;
-	struct sched_param sparam = {.sched_priority = 1};
-
-	if (sched_setscheduler(0, SCHED_FIFO, &sparam)) {
-		tst_brk(TBROK | TERRNO,
-			"sched_setscheduler(0, SCHED_FIFO, ...) failed");
-	}
+	struct sched_param sparam = {.sched_priority = 0};
 
 	all_counters_set(PR_TASK_PERF_EVENTS_ENABLE);
 	do_work(8);
-- 
2.48.1.711.g2feabab25a-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
