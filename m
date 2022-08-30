Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328A2ECAAA1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 13:50:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E2903CA6D0
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 15:50:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B7363CA695
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 15:50:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 89D8A140012E
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 15:50:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CA2A1FAA0
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661867408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8O4I/CCD8zaZQ8IGuMCNSSDIS7hfgRbujttoTb7nakk=;
 b=zjru8Zc5MTL7uxJV4HSrOTNmr6qTswX512j1tjJOapON106HjoEoQB9nHYTqMJDjyLiEnd
 QeBXLIKYrg0vmZo1dwPOX3g4GPXYViQLq4qHleeMYYTK4sSfLG0RGzlYuOtfLaHkkdF7jw
 WiS3Mb1fJjoqJO+7B2AtTYYUS9Cx3PA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661867408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8O4I/CCD8zaZQ8IGuMCNSSDIS7hfgRbujttoTb7nakk=;
 b=rOpKEZW6Qwq+TdQaNY3wTMFaEuhMx5DhrV5iIuwIsBMq2khDO3K0fza8JYgeUtVvyoSG1k
 tfvU/yWcm5zL9uCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79B5513B21
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 13:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8BTFHJAVDmOfDAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 13:50:08 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Aug 2022 15:50:00 +0200
Message-Id: <20220830135007.16818-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830135007.16818-1-mdoucha@suse.cz>
References: <20220830135007.16818-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 03/10] ksm: Add max_runtime to tests
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

ksm02, ksm04 and ksm05 take 10+ seconds to finish. Set max_runtime to avoid
random timeout issues.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/mem/ksm/ksm02.c | 1 +
 testcases/kernel/mem/ksm/ksm04.c | 1 +
 testcases/kernel/mem/ksm/ksm05.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 1cb7d8e73..1f5677425 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -110,6 +110,7 @@ static struct tst_test test = {
 	},
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
+	.max_runtime = 20,
 	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
 };
 
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 39c741876..f7dc5befc 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -112,6 +112,7 @@ static struct tst_test test = {
 	},
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
+	.max_runtime = 20,
 	.needs_cgroup_ctrls = (const char *const []){
 		"memory", "cpuset", NULL
 	},
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index 146a9a3b7..6f94c4a9c 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -88,6 +88,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test_all = test_ksm,
 	.min_kver = "2.6.32",
+	.max_runtime = 10,
 	.save_restore = (const struct tst_path_val[]) {
 		{"!/sys/kernel/mm/ksm/run", "1"},
 		{}
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
