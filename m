Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10FCC433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 16:38:02 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC6660EFF
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 16:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6EC6660EFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA4673C9271
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 18:37:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7342D3C1D85
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 18:37:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8ACBC1A00114
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 18:37:48 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B72BD1FDA0;
 Mon, 13 Sep 2021 16:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1631551067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IoUS6hrHtgdaofOxDzXndrHcW3UaHeXF4NGnlRgwfRg=;
 b=kE3hGYgvVFN2w0x4ooH2DG5n80FJkHCUPlARjx5sxGMLQVcpLAS3YDEJJ/ySMfZCuo/61n
 1sIXxY0b493kPry68LaF+ZW4QYNbEqAE9gW1sb1gn3c5UXujDJYYlyf/RedjZnJk6ai90H
 YWPfv9PDIemQyH8mXSndJChE3npNY5E=
Received: from blezhepekov.udp.ovpn1.nue.suse.de (unknown [10.163.30.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 84BF6A3B81;
 Mon, 13 Sep 2021 16:37:47 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 13 Sep 2021 19:37:43 +0300
Message-ID: <20210913163745.28108-1-bogdan.lezhepekov@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/3] realtime:hrtimer-prio: fix misleading help
 message
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
From: Bogdan Lezhepekov via ltp <ltp@lists.linux.it>
Reply-To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210913163743.ib3WwXwZzw8TZIAvZQffeA5nWWJu-H7SsiBg0OCQ148@z>

The argument "-m" had been removed years ago, but the help
message mistakenly offered to set "maximum timer
latency in microseconds".

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/hrtimer-prio/hrtimer-prio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c b/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c
index 4ae49a713..cbc2343f6 100644
--- a/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c
+++ b/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c
@@ -76,9 +76,6 @@ void usage(void)
 	printf
 	    ("  -f#	   #:rt fifo priority of busy threads (1,98), defaults to %d\n",
 	     DEF_MED_PRIO);
-	printf
-	    ("  -m#	   #:maximum timer latency in microseconds, defaults to %d\n",
-	     DEF_CRITERIA);
 }
 
 int parse_args(int c, char *v)
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
