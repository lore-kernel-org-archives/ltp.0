Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A81AC43217
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 14:41:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13E193C14B2
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 15:41:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D32483C92B9
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 15:40:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7D071600288
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 15:40:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E98431F3B9;
 Tue, 25 Jan 2022 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643121649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGiS7lQvESsMmNo/Rib9XGx7icYBVydRvM9uxVm2umU=;
 b=kmT/oQw2v6Nlac9slqFH34KIyVNALj882+9eDcbAqvRlrL5y/COq5eUrCMp49MoP6GzbOf
 J12nqC9Juz2HxbA5i6wqnmqPj40U3I++KntyNIaVnnQLecgXEEYysPG2Ge5j62HxBELUX2
 8Dw0sa+Qhe3sPj/sDcEHZxv6vc1mD3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643121649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGiS7lQvESsMmNo/Rib9XGx7icYBVydRvM9uxVm2umU=;
 b=K5JanBGR0DmAeuMpynm1MIPWsHKkpTLuXOf9WoXDCr7uoVboFP0+gruBvBgtqIgYt/sV3u
 JCNkZTTAgtMQpTBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C167113DEB;
 Tue, 25 Jan 2022 14:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ACGiLfEL8GGFdAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Jan 2022 14:40:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Jan 2022 15:40:43 +0100
Message-Id: <20220125144043.31798-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125144043.31798-1-pvorel@suse.cz>
References: <20220125144043.31798-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] sched_get_priority_max01: Add missing policies
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

+ improve doc wording and update copyright.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
* code is the same, only copyright and doc updated

 .../sched_get_priority_max01.c                      | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
index f6fe1add9c..b9a58a46a4 100644
--- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
+++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  * Copyright (c) 2021 sujiaxun <sujiaxun@uniontech.com>
+ * Copyright (c) Linux Test Project, 2009-2022
  */
 
 /*\
@@ -10,9 +11,11 @@
  * Basic test for the sched_get_priority_max(2) system call.
  *
  * Obtain different maximum priority for different schedulling policies and
- * compare them with expected value.
+ * compare them with the expected value.
  */
 
+#define _GNU_SOURCE
+
 #include <sched.h>
 #include "tst_test.h"
 #include "lapi/syscalls.h"
@@ -24,14 +27,16 @@ static struct test_case {
 	int policy;
 	int retval;
 } tcases[] = {
-	{POLICY_DESC(SCHED_OTHER), 0},
+	{POLICY_DESC(SCHED_BATCH), 0},
+	{POLICY_DESC(SCHED_DEADLINE), 0},
 	{POLICY_DESC(SCHED_FIFO), 99},
-	{POLICY_DESC(SCHED_RR), 99}
+	{POLICY_DESC(SCHED_IDLE), 0},
+	{POLICY_DESC(SCHED_OTHER), 0},
+	{POLICY_DESC(SCHED_RR), 99},
 };
 
 static void run_test(unsigned int nr)
 {
-
 	struct test_case *tc = &tcases[nr];
 
 	TST_EXP_VAL(tst_syscall(__NR_sched_get_priority_max, tc->policy),
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
