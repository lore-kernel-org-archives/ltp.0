Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67007C433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 14:33:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9124D3CA2E8
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 15:33:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CC023CA0F4
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 15:33:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 952EB200D09
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 15:33:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C2421F39D;
 Tue,  1 Mar 2022 14:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646145185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=knPK1b9Jxjzcw4T4rjKOjdFByNFzypfbS2TKF06qo3k=;
 b=FMZXA9Dew8p0+AxlQJMBMaZ5Rk2CCOyAQl76EemAYNvXITmVTQsO4CmonwjM08aLjJANAI
 tIOAXUcWy/T7rzrDtnlhOtn7doqAMp3ckk/y194YwJON9RRj9ydEVFJ6kkpf4crKb4owV/
 /zj/TWH32eoTUYw5eZGyIbzO+1eHUtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646145185;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=knPK1b9Jxjzcw4T4rjKOjdFByNFzypfbS2TKF06qo3k=;
 b=Y4WVwXvgn3fvfv9MOkyjzU43RG540aI73ImCkxk4sHWTvfe48hhTdkNmGbAtBq6HR/4NIM
 N0Wz1LTjw/sERgAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88A8113B67;
 Tue,  1 Mar 2022 14:33:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id taH5H6EuHmLDbAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 01 Mar 2022 14:33:05 +0000
Date: Tue, 1 Mar 2022 15:35:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Yh4vLRyB/5wQz+Pq@yuki>
References: <20220301091517.11142-1-andrea.cervesato@suse.de>
 <20220301091517.11142-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220301091517.11142-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/6] Rewrite mountns01 test using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with minor changes, thanks.

- changed the numbered list to simple list in the documentation
  as the three levels of different numbering looked a bit confusing

- changed the license to GPL-2.0 as the original was 2.0 only as well

- removed a few obvious comments, as long as the comment describes
  exactly what the next line does there is no value of keeping it

diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
index f2d67d17a..452fe1d10 100644
--- a/testcases/kernel/containers/mountns/mountns01.c
+++ b/testcases/kernel/containers/mountns/mountns01.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014 Red Hat, Inc.
  * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
@@ -12,21 +12,21 @@
  *
  * [Algorithm]
  *
- * . Creates directories "A", "B" and files "A/A", "B/B"
- * . Unshares mount namespace and makes it private (so mounts/umounts have no
+ * - Creates directories "A", "B" and files "A/A", "B/B"
+ * - Unshares mount namespace and makes it private (so mounts/umounts have no
  *   effect on a real system)
- * . Bind mounts directory "A" to "A"
- * . Makes directory "A" shared
- * . Clones a new child process with CLONE_NEWNS flag
- * . There are two test cases (where X is parent namespace and Y child namespace):
- * .. First test case
- * ... X: bind mounts "B" to "A"
- * ... Y: must see "A/B"
- * ... X: umounts "A"
- * .. Second test case
- * ... Y: bind mounts "B" to "A"
- * ... X: must see "A/B"
- * ... Y: umounts "A"
+ * - Bind mounts directory "A" to "A"
+ * - Makes directory "A" shared
+ * - Clones a new child process with CLONE_NEWNS flag
+ * - There are two test cases (where X is parent namespace and Y child namespace):
+ *  1. First test case
+ *   .. X: bind mounts "B" to "A"
+ *   .. Y: must see "A/B"
+ *   .. X: umounts "A"
+ *  2. Second test case
+ *   .. Y: bind mounts "B" to "A"
+ *   .. X: must see "A/B"
+ *   .. Y: umounts "A"
  */
 
 #include <sys/wait.h>
@@ -59,23 +59,18 @@ static void run(void)
 {
 	int ret;
 
-	/* unshares the mount ns */
 	SAFE_UNSHARE(CLONE_NEWNS);
 
 	/* makes sure parent mounts/umounts have no effect on a real system */
 	SAFE_MOUNT("none", "/", "none", MS_REC | MS_PRIVATE, NULL);
 
-	/* bind mounts DIRA to itself */
 	SAFE_MOUNT(DIRA, DIRA, "none", MS_BIND, NULL);
-
-	/* makes mount DIRA shared */
 	SAFE_MOUNT("none", DIRA, "none", MS_SHARED, NULL);
 
 	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
 	if (ret < 0)
 		tst_brk(TBROK, "clone failed");
 
-	/* bind mounts DIRB to DIRA making contents of DIRB visible in DIRA */
 	SAFE_MOUNT(DIRB, DIRA, "none", MS_BIND, NULL);
 
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
