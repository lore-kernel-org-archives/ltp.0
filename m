Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CC7C43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 04:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782966333; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=d0/BQ/NH+hhgtDHP/8yWJw78xZfCEldJjPDBBUZx0TY=;
 b=C9apUNlDArhGLBLPlB/dkAO5bPHIqz8kvIQrrvdXWd73QtSS1vD2XtxCJdSAt1cOwP0c5
 G1ITDB+yKe9rrufPydU/qDg40FZheenq/BlzJM0r+urT7KYzCTjPUpwK0XgIMVfc/Cjlnkw
 pG2hVpwmABokPS64LDk7VEa6EXnWJq4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B90703E1762
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 06:25:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8EE93E2256
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 06:25:10 +0200 (CEST)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0F1F31A008A6
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 06:25:09 +0200 (CEST)
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-37d4f23eb37so2451540a91.0
 for <ltp@lists.linux.it>; Wed, 01 Jul 2026 21:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782966308; x=1783571108; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5ympKi2+Ww64RkA6BqsHliPR4eUB/h52Iks1NTTBDhA=;
 b=WBM5EDvMwbTdCkGhc1/t0/JngxLX8EIZd493VSl45Py4+rdrAJ7Ts8f+78d2ElD69w
 9RUkh2JzMofMqfGt/Zr3peR2t5utWpJs/zkReSthPMXGD7SiMegvfN4wJRaPEwE4Dkj8
 bWwniNMkW5SLvqmHhwYw0IM5RXcjpg1/SvAzUb3XcB8jIJLxTjEygpHP5hhuzhOf8Gz3
 S6hAmRAuL4oYXOwGG9HH80Fat095jI6rhEw/RCTr19vGIW5iOnpKuntmyeEH9QLX5xW/
 Gkqd7yhy91+cfMKTrscyRCDcntcgvdoLQng1taN3uQ1Way9GndQVoenERcU2f2v7LKb1
 O7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782966308; x=1783571108;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5ympKi2+Ww64RkA6BqsHliPR4eUB/h52Iks1NTTBDhA=;
 b=Pci00wb4Xe0iYCEuz3F1cZladgEIR9jAGfWWCOnSbU2+E4VrhNJ5xTdCBH7tL9oVYi
 GfFU3rpP5S2IaO40tXXF5DlCC2oyPgDahcV6LIBdoDRMX6bn1iHFTHg8WmrzWfxNhu7e
 iXV+JBRSWRhQVJVUMAmU+/rLfE18B21AqZxtzRXqQi5FNIuorrac/QuE2t3PO1eiyvtL
 En0K4KlZa5mVEGn65lrcIRJuaSK4e3ODR6FkJpdMKcqlrPOLuhSXmCDiJ84tghXiyYZI
 kWp6MssgGeqrga4Eqmtnx54rvDfHYQrzsG0riC4lHdoQvmuF8m7ltVUD5yKpyFXgR4Ov
 lFyQ==
X-Gm-Message-State: AOJu0Yyc3afIhc4gKNGhtw8kh7dCt+TcqEfT2/gLU1xdOdj76PYZPdiK
 v2i4YvJFHnd/YpziS59lE8qYRdonuFo/VmExAxoWUkuE6KVO1M7uXT5uC56cLmN6j2qjh2xKwjR
 WMN0dDikAtGcdOOYD5ltpkw7BG12okOzvEZqwyw9N3LfeIK0RzYeEe6v5rvxB1buHO29CxyVwjC
 YMX/7MfaRLW9qJkCuV4Q9C6Qe3Hg==
X-Received: from pjqu11.prod.google.com ([2002:a17:90a:ae8b:b0:37d:8595:7a08])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:574d:b0:37f:b17e:133c
 with SMTP id 98e67ed59e1d1-380aa1d3e36mr4314656a91.25.1782966307767; Wed, 01
 Jul 2026 21:25:07 -0700 (PDT)
Date: Thu,  2 Jul 2026 04:25:05 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702042505.389515-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/lsm_list_modules02: Log unrecognized LSM IDs
 with TINFO instead of TBROK
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>, r.kothari@samsung.corp-partner.google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When running lsm_list_modules02 on systems with newer upstream kernels
containing newly introduced LSMs, or on vendor/OEM kernels with out-of-tree
security modules enabled, lsm_list_modules(ids, size, 0) returns valid LSM
IDs that might not yet be mapped in the hardcoded switch (ids[i]) table.

Currently, encountering any unrecognized LSM ID causes the test to immediately
terminate with tst_brk(TBROK, "Unsupported LSM: %lu", ids[i]). This prevents
testing of other well-known standard LSMs present on the system.

Downgrade the unrecognized LSM ID handling from TBROK to TINFO and continue
iterating over the remaining IDs. This improves test robustness across
various kernel configurations while maintaining rigorous verification for all
known standard LSM modules.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/lsm/lsm_list_modules02.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/lsm/lsm_list_modules02.c b/testcases/kernel/syscalls/lsm/lsm_list_modules02.c
index 91e5b7fa2..ede89ee73 100644
--- a/testcases/kernel/syscalls/lsm/lsm_list_modules02.c
+++ b/testcases/kernel/syscalls/lsm/lsm_list_modules02.c
@@ -95,8 +95,11 @@ static void run(void)
 			break;
 		}
 
-		if (!name)
-			tst_brk(TBROK, "Unsupported LSM: %lu", ids[i]);
+		if (!name) {
+			tst_res(TINFO, "Skipping unrecognized LSM ID: %lu",
+				(unsigned long)ids[i]);
+			continue;
+		}
 
 		for (counter = 0; counter < lsm_names_count; counter++) {
 			if (!strcmp(name, lsm_names[counter].name)) {
-- 
2.55.0.rc0.799.gd6f94ed593-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
