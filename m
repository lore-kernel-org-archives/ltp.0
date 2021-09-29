Return-Path: <SRS0=fXc4=OT=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6493CC433EF
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:59:28 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9AF6108F
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A9AF6108F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 939483C819D
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 10:59:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AD763C17A1
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 10:59:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E1B046008C7
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 10:59:13 +0200 (CEST)
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5481622525;
 Wed, 29 Sep 2021 08:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1632905953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvVxPg0AIhJCK8UX7BYnKmW0jxwoqtTsxgRsqy1EDxo=;
 b=fEYxbeQU4S7inNyzWGBPRmIC8PvSidLG//YbV2eOgy1TjT6cDwjq6tCThO6re0CjeQy5K4
 Z9MME0oBC7Ky3r+tgGu90R5atyxkxHTzXiU9+9SO+EzB7UjZ+WTvOXUt4mOcIh8/Ctkzgk
 ut39bGBnefyRZ8fs94h8j6D68Vm1aeo=
Received: from g78.suse.de (unknown [10.163.24.38])
 by relay1.suse.de (Postfix) with ESMTP id 1DA0025D8B;
 Wed, 29 Sep 2021 08:59:13 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 29 Sep 2021 09:59:10 +0100
Message-Id: <20210929085910.23073-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929085910.23073-1-rpalethorpe@suse.com>
References: <20210929085910.23073-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] clock_nanosleep01: Add space to make make-check
 happy
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 7dc5a043d..d7b14fd94 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -200,7 +200,7 @@ static void do_test(unsigned int i)
 		}
 
 		if (remain_ms > expect_ms) {
-			tst_res(TFAIL| TTERRNO,
+			tst_res(TFAIL | TTERRNO,
 				"remaining time > requested time (%lld > %lld)",
 				remain_ms, expect_ms);
 			return;
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
