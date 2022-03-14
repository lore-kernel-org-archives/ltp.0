Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365ABC433F5
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 13:07:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6169C3CA873
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 14:07:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D5283CA802
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 14:06:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CF863600795
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 14:06:58 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4918121900;
 Mon, 14 Mar 2022 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1647263218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1pUpllZQZ35ciURu9fNcKRwM7Yzu0LTu0DNc9669SzE=;
 b=IF0X+qJooSlebdbJ7MU5G4m524KbC3ytXYG+nKQPFVwNm9XkC4FNd5Tgx2lwP5ToyQdXKt
 8Je5BUjnnMfRs8SbkZnc8ae+2tubCpndzjdwsrmcAgt7fhhYdQumh3Y/RfOYh/gZdMMIzb
 cLvnKoSaStgohdIHbGHPV2912O7f2fQ=
Received: from g78.suse.de (unknown [10.163.24.182])
 by relay2.suse.de (Postfix) with ESMTP id 0B5EAA3B88;
 Mon, 14 Mar 2022 13:06:57 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 14 Mar 2022 13:06:30 +0000
Message-Id: <20220314130630.9378-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314130630.9378-1-rpalethorpe@suse.com>
References: <20220314130630.9378-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] LTP-005: Switch opts terminator to {}
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
 .../kernel/security/integrity/ima/src/ima_boot_aggregate.c      | 2 +-
 testcases/network/nfs/nfs_stress/nfs05_make_tree.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index 05c20e5ae..62468e0d1 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -125,7 +125,7 @@ static void do_test(void)
 static struct tst_option options[] = {
 	{"d", &debug, "Enable debug"},
 	{"f:", &file, "binary_bios_measurement file (required)\n"},
-	{NULL, NULL, NULL}
+	{}
 };
 
 static struct tst_test test = {
diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
index add55e156..fdc13bd5d 100644
--- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
+++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
@@ -63,7 +63,7 @@ static struct tst_option opts[] = {
 	{"t:", &t_arg, "Number of threads to generate, default: 8"},
 	{"d:", &d_arg, "Number of subdirs to generate, default: 100"},
 	{"f:", &f_arg, "Number of c files in each dir, default: 100"},
-	{NULL, NULL, NULL}
+	{}
 };
 
 static void run_targets(const char *dirname, char *cfile, pid_t tid)
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
