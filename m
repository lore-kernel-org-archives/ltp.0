Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ABCFA373D
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 11:26:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37F633CAD0F
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 12:26:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 220003CA408
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 12:26:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4955E1000793
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 12:26:28 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E20921F90C;
 Tue,  1 Nov 2022 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1667301987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cxom05lUxGgKBZ5HJlcqMLO+I4thg4OfYCxj315KqNI=;
 b=AOtykGQ239zPZWyuoVM6dXUJqcLKtq67oaML7sMS4M1W9ZFfgZQMSNL2AdHRfk7uljsR6G
 HwITyTTR9eZna0IDWY2hu7rcwRb+bhRmme7Rdxd2nwd+yHfE6Nl6W0l6SH+wqf5tchxEDa
 SJzEAVYoM98yJXci7lATqcJc20v+b5k=
Received: from localhost.localdomain (unknown [10.163.28.198])
 by relay2.suse.de (Postfix) with ESMTP id 227642C141;
 Tue,  1 Nov 2022 11:26:26 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  1 Nov 2022 11:26:21 +0000
Message-Id: <20221101112621.20031-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pidns12: Avoid write in sig handler
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

It is best to avoid doing any kind of unecessary work in a signal
handler.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/containers/pidns/pidns12.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
index 65e2a0836..0e6b17142 100644
--- a/testcases/kernel/containers/pidns/pidns12.c
+++ b/testcases/kernel/containers/pidns/pidns12.c
@@ -18,9 +18,11 @@
 #include "tst_test.h"
 #include "lapi/namespaces_constants.h"
 
+static volatile pid_t sig_pid = -1;
+
 static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
 {
-	TST_EXP_EQ_LI(si->si_pid, 0);
+	sig_pid = si->si_pid;
 }
 
 static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
@@ -38,6 +40,8 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
+	TST_EXP_EQ_LI(sig_pid, 0);
+
 	return 0;
 }
 
-- 
2.38.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
