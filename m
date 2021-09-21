Return-Path: <SRS0=nxZL=OL=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE02C433FE
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 11:33:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FA261166
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 11:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92FA261166
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4B943CA2BF
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 13:33:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F0D23C861B
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 13:33:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CBC006001E0
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 13:33:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16342220F8
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632223998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YId7VXBHXDZXQU/DF1CRV5+w3uqwVPuCFj9SyfrvxGw=;
 b=muv+9BsUW/uS9qBXMdrp6lX08KtwxITnBwDTBEGB23R5UypV2gsPCvYK/lItMpoMf6ZjCP
 3fRAA7gO9xQttUZkBDLxDYZGJ9QwVUVKKo+iWgCeKvoyKQsO8JqRAWoGTvWRXtd3rYNI8f
 inBbt2vDSY8jR8V0BygUfOitUMHKHdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632223998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YId7VXBHXDZXQU/DF1CRV5+w3uqwVPuCFj9SyfrvxGw=;
 b=39jyGx0EOXBEEDE+ifUc5S9oNrMbQyEDdXlulnrXuPjvQIRHxpnNbxClCVq5QPqKrITgYy
 DsIFFyZ6NilFH+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0261313BC2
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 11:33:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CPMPO/3CSWFYAQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 11:33:17 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Sep 2021 13:33:17 +0200
Message-Id: <20210921113317.16756-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921113317.16756-1-mdoucha@suse.cz>
References: <20210921113317.16756-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/init_module02: Rewrite lockdown skips
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

Different kernels may return different module signature validation errors
for null-param and invalid_param test cases. Skip both test cases when
the kernel is in lockdown.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../syscalls/init_module/init_module02.c      | 33 +++++++++----------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
index dac99a4da..ad6569a06 100644
--- a/testcases/kernel/syscalls/init_module/init_module02.c
+++ b/testcases/kernel/syscalls/init_module/init_module02.c
@@ -34,16 +34,16 @@ static struct tcase {
 	unsigned long *size;
 	const char *param;
 	int cap;
+	int skip_in_lockdown;
 	int exp_errno;
-	int lockdown_errno;
 } tcases[] = {
-	{"NULL-buffer", &null_buf, &size, "", 0, EFAULT, EFAULT},
-	{"faulty-buffer", &faulty_buf, &size, "", 0, EFAULT, EFAULT},
-	{"null-param", &buf, &size, NULL, 0, EFAULT, EPERM},
-	{"zero-size", &buf, &zero_size, "", 0, ENOEXEC, ENOEXEC},
-	{"invalid_param", &buf, &size, "status=invalid", 0, EINVAL, EPERM},
-	{"no-perm", &buf, &size, "", 1, EPERM, EPERM},
-	{"module-exists", &buf, &size, "", 0, EEXIST, EPERM},
+	{"NULL-buffer", &null_buf, &size, "", 0, 0, EFAULT},
+	{"faulty-buffer", &faulty_buf, &size, "", 0, 0, EFAULT},
+	{"null-param", &buf, &size, NULL, 0, 1, EFAULT},
+	{"zero-size", &buf, &zero_size, "", 0, 0, ENOEXEC},
+	{"invalid_param", &buf, &size, "status=invalid", 0, 1, EINVAL},
+	{"no-perm", &buf, &size, "", 1, 0, EPERM},
+	{"module-exists", &buf, &size, "", 0, 1, EEXIST},
 };
 
 static void setup(void)
@@ -67,23 +67,20 @@ static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
+	if (tc->skip_in_lockdown && kernel_lockdown) {
+		tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
+		return;
+	}
+
 	if (tc->cap)
 		tst_cap_action(&cap_drop);
 
 	/* Insert module twice */
-	if (tc->exp_errno == EEXIST) {
-		if (kernel_lockdown) {
-			tst_res(TCONF, "Kernel is locked down, skipping %s",
-				tc->name);
-			return;
-		}
-
+	if (tc->exp_errno == EEXIST)
 		tst_module_load(MODULE_NAME, NULL);
-	}
 
 	TST_EXP_FAIL(init_module(*tc->buf, *tc->size, tc->param),
-		     kernel_lockdown ? tc->lockdown_errno : tc->exp_errno,
-		     "TestName: %s", tc->name);
+		tc->exp_errno, "TestName: %s", tc->name);
 
 	if (tc->exp_errno == EEXIST)
 		tst_module_unload(MODULE_NAME);
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
