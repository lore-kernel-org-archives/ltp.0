Return-Path: <SRS0=nxZL=OL=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D35C433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 10:31:05 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D6E61038
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 10:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31D6E61038
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C92173CA2D7
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 12:31:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CCB33C1AE4
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 12:30:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2942B100117E
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 12:30:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 39F5D220E8
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 10:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632220251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/UlvhqoocZp9K2TT8F+Lqq07KCJeVYriyTA8q7UlfJQ=;
 b=mnD9e1LvrwK8fpt2CdYUMYo6XH85JNzvLGucE5FOrlOcH+9SGKICwd6U1R95lJsy4c4Zsq
 JmgT17Zvtxf/0hqdvsjV+rjPYE3TlD+DDidP8JeEXWLRnVYfmfanoPYYI6T98Q/4XjiTaU
 VZRKWufAkVz2Uhf0G6aMO3aY0VYE/Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632220251;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/UlvhqoocZp9K2TT8F+Lqq07KCJeVYriyTA8q7UlfJQ=;
 b=E4dudLjqDNBPnIEFp9ifQroMNyaqdoap+OihRvo0Pp1/kvnSc0aEG3LlScN6ojEykmQ1Hj
 GxtHRRRNmeVFkBCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2867313BBF
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 10:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QgxuCFu0SWHLXgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 10:30:51 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Sep 2021 12:30:50 +0200
Message-Id: <20210921103050.12942-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/finit_module02: Rewrite lockdown skips
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
for null-param and invalid-param test cases. Skip both test cases when
the kernel is in lockdown.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../syscalls/finit_module/finit_module02.c    | 44 +++++++++----------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index 503c8e994..0d2bf917e 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -38,6 +38,7 @@ struct tcase {
 	int flags;
 	int cap;
 	int exp_errno;
+	int skip_in_lockdown;
 	void (*fix_errno)(struct tcase *tc);
 };
 
@@ -65,24 +66,21 @@ static void dir_setup(struct tcase *tc)
 		tc->exp_errno = EINVAL;
 }
 
-static void lockdown_setup(struct tcase *tc)
-{
-	if (kernel_lockdown)
-		tc->exp_errno = EPERM;
-}
-
 static struct tcase tcases[] = {
-	{"invalid-fd", &fd_invalid, "", O_RDONLY | O_CLOEXEC, 0, 0, 0, bad_fd_setup},
-	{"zero-fd", &fd_zero, "", O_RDONLY | O_CLOEXEC, 0, 0, EINVAL, NULL},
-	{"null-param", &fd, NULL, O_RDONLY | O_CLOEXEC, 0, 0, EFAULT,
-		lockdown_setup},
+	{"invalid-fd", &fd_invalid, "", O_RDONLY | O_CLOEXEC, 0, 0, 0, 0,
+		bad_fd_setup},
+	{"zero-fd", &fd_zero, "", O_RDONLY | O_CLOEXEC, 0, 0, EINVAL, 0, NULL},
+	{"null-param", &fd, NULL, O_RDONLY | O_CLOEXEC, 0, 0, EFAULT, 1, NULL},
 	{"invalid-param", &fd, "status=invalid", O_RDONLY | O_CLOEXEC, 0, 0,
-		EINVAL, lockdown_setup},
-	{"invalid-flags", &fd, "", O_RDONLY | O_CLOEXEC, -1, 0, EINVAL, NULL},
-	{"no-perm", &fd, "", O_RDONLY | O_CLOEXEC, 0, 1, EPERM, NULL},
-	{"module-exists", &fd, "", O_RDONLY | O_CLOEXEC, 0, 0, EEXIST, NULL},
-	{"file-not-readable", &fd, "", O_WRONLY | O_CLOEXEC, 0, 0, 0, wo_file_setup},
-	{"directory", &fd_dir, "", O_RDONLY | O_CLOEXEC, 0, 0, 0, dir_setup},
+		EINVAL, 1, NULL},
+	{"invalid-flags", &fd, "", O_RDONLY | O_CLOEXEC, -1, 0, EINVAL, 0,
+		NULL},
+	{"no-perm", &fd, "", O_RDONLY | O_CLOEXEC, 0, 1, EPERM, 0, NULL},
+	{"module-exists", &fd, "", O_RDONLY | O_CLOEXEC, 0, 0, EEXIST, 1,
+		NULL},
+	{"file-not-readable", &fd, "", O_WRONLY | O_CLOEXEC, 0, 0, 0, 0,
+		wo_file_setup},
+	{"directory", &fd_dir, "", O_RDONLY | O_CLOEXEC, 0, 0, 0, 0, dir_setup},
 };
 
 static void setup(void)
@@ -112,21 +110,19 @@ static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
+	if (tc->skip_in_lockdown && kernel_lockdown) {
+		tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
+		return;
+	}
+
 	fd = SAFE_OPEN(mod_path, tc->open_flags);
 
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
 
 	TST_EXP_FAIL(finit_module(*tc->fd, tc->param, tc->flags), tc->exp_errno,
 		     "TestName: %s", tc->name);
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
