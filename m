Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F957C433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 15:02:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B58D6103B
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 15:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B58D6103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D20A63C9247
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 17:02:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB2733C1D8B
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 17:02:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AFE2D1A00FB8
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 17:02:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A9A141FDFE
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 15:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631631719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fcxa6xkok6yCmf6dlR8kLdNjXBbO+JyMy+kQ6NqJZHc=;
 b=NEVZql4IsAyoi26kbM2YJhbMH9ZJqOFyOL6JaugZ3/Fc7O2h/NkJjhu9EKGl5lSanfO4O6
 83eks2guv/ZT+2f6TUj3/jj0LhcZPJrcpJUfIbzB7Shm4R2GP4as3yBK6DU+76t+Rv58IU
 N8P55OINbmLTevmGrne/JkdPWkuEoag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631631719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fcxa6xkok6yCmf6dlR8kLdNjXBbO+JyMy+kQ6NqJZHc=;
 b=iyRKkVTp4oLCOU7qWpOjIAB1Kyav1ZzlmY5Xs/GTP8S6VrFAL+38R9ygPUJ/SrLy9wq/VS
 gVtqe3n1CneKmkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 938E213C15
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 15:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XiAHI2e5QGFBCAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 15:01:59 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 Sep 2021 17:02:20 +0200
Message-ID: <20210914150220.2467-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: tst_virt: Add option to override virt detection
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
Message-ID: <20210914150220.dtkZWuvPhn-WBVe72xThQqUVLrVoHyJR0dyfgYjLsJ4@z>

There seems to be cases where systemd-detect-virt does not detect
virtualization correctly. To work around this bugs this commit adds a
a support for LTP_VIRT_OVERRIDE environment variable that if set is used
instead of the output from the systemd-detect-virt command.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_virt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index d23d7f564..0fda20a17 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -100,8 +100,18 @@ static int is_ibmz(int virt_type)
 static int try_systemd_detect_virt(void)
 {
 	FILE *f;
-	char virt_type[64];
+	char virt_buf[64];
 	int ret;
+	char *virt_type = getenv("LTP_VIRT_OVERRIDE");
+
+	if (virt_type) {
+		if (!strcmp("", virt_type))
+			return 0;
+
+		goto cmp;
+	}
+
+	virt_type = virt_buf;
 
 	/* See tst_cmd.c */
 	void *old_handler = signal(SIGCHLD, SIG_DFL);
@@ -129,6 +139,7 @@ static int try_systemd_detect_virt(void)
 	if (ret)
 		return 0;
 
+cmp:
 	if (!strncmp("kvm", virt_type, 3))
 		return VIRT_KVM;
 
-- 
2.26.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
