Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C6FC433EF
	for <ltp@archiver.kernel.org>; Mon,  3 Jan 2022 15:13:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 101883C8FCF
	for <ltp@archiver.kernel.org>; Mon,  3 Jan 2022 16:13:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82BA03C62E6
 for <ltp@lists.linux.it>; Mon,  3 Jan 2022 16:13:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F12621A0014C
 for <ltp@lists.linux.it>; Mon,  3 Jan 2022 16:13:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 55C1C1F386;
 Mon,  3 Jan 2022 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641222816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4rDeQEr2Pt4rIJyDl0jl9LiJQh57x4L+yyUC2iB0Cw=;
 b=qLrlcYM04p8B1DmzAnblQ+AwRRMciQbnUYCD/GgIoOpoPMbO2ArvP8cFJxf2vkXs00fe91
 88sbGg/entxOBrkhL5j6c1eNWbc97m1kvHJzwHGNMtoG/SCnBjMMldMqtB6HhAg7iqu6Q8
 Te8/6gDbRSh6xC+mjHNWLpYsCqVSb1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641222816;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4rDeQEr2Pt4rIJyDl0jl9LiJQh57x4L+yyUC2iB0Cw=;
 b=khxyIfSBomxUh5wPzOWiBs84n8xdihwv1b63Mwt8hzXvscbL+IB960F0jaaY0tWuRqNTRG
 E+qdSNu9XxnxzfCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 280E813AED;
 Mon,  3 Jan 2022 15:13:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CJ7tB6AS02EtbQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 03 Jan 2022 15:13:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  3 Jan 2022 16:13:32 +0100
Message-Id: <20220103151332.1989-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220103151332.1989-1-pvorel@suse.cz>
References: <20220103151332.1989-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] ustat0{1,
 2}: Mark failure on Btrfs with known-fail tag
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

ustat() has been always broken on Btrfs and it's unlikely to be fixed
due ustat() being deprecated (glibc doesn't expose this system call
anymore).

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/ustat/ustat01.c | 4 ++++
 testcases/kernel/syscalls/ustat/ustat02.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
index 0252858beb..e314649e8d 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -44,6 +44,10 @@ static void setup(void)
 static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
+	.tags = (const struct tst_tag[]) {
+		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs"},
+		{}
+	}
 };
 #else
 TST_TEST_TCONF("testing ustat requires <sys/ustat.h> or <linux/types.h>");
diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index d08446eaa1..67d2918f83 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -63,6 +63,10 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.tcnt = ARRAY_SIZE(tc),
+	.tags = (const struct tst_tag[]) {
+		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs"},
+		{}
+	}
 };
 #else
 TST_TEST_TCONF("testing ustat requires <sys/ustat.h> or <linux/types.h>");
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
