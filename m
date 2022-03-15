Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EE6C433F5
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 12:25:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 777AD3C934F
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 13:25:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E0FC3C91F4
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:23:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D4C2860013B
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:23:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 82AF11F397;
 Tue, 15 Mar 2022 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647347035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8u2SiozJ8TIVCkAsTrPr6Wd3+Mg9abl+dleKRk/o2A=;
 b=RP3au3mxY4E7HqzrZAFK72VTKAh4vOObMVvRVysYmMQsduoKWD958tof9RlmnicwBWodK4
 I659+6E3BSBOUhM9CTSOV2dGoWYtj7M2VmI69ulJEQc3Wu4l4pP6WAzuxBUPvVX6MFfHwN
 1W5Pzy3aLngvEBzSedqlrN3h4gQdpnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647347035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8u2SiozJ8TIVCkAsTrPr6Wd3+Mg9abl+dleKRk/o2A=;
 b=I0cYi0/9bLkKBoeDtGfGbA1hCfglFha9XQkUgHAaeGsvehLmLJWWU9e5cSnMk04su5womu
 iDSYl0KcOQaTJDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5656513B59;
 Tue, 15 Mar 2022 12:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EHknE1uFMGJ3UAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 15 Mar 2022 12:23:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 15 Mar 2022 13:23:51 +0100
Message-Id: <20220315122351.8556-9-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315122351.8556-1-andrea.cervesato@suse.de>
References: <20220315122351.8556-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 8/8] Rewrite userns08.c using new LTP API
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 testcases/kernel/containers/userns/userns08.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index bde944f22..1180be494 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -17,6 +17,7 @@
  * by (the real) root. So on the second level we reset dumpable to 1.
  *
  */
+
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
@@ -30,16 +31,12 @@
 
 static pid_t clone_newuser(void)
 {
-	const struct tst_clone_args cargs = {
-		CLONE_NEWUSER,
-		SIGCHLD
-	};
+	const struct tst_clone_args cargs = { CLONE_NEWUSER, SIGCHLD };
 
 	return SAFE_CLONE(&cargs);
 }
 
-static void write_mapping(const pid_t proc_in_ns,
-			  const char *const id_mapping)
+static void write_mapping(const pid_t proc_in_ns, const char *const id_mapping)
 {
 	char proc_path[PATH_MAX];
 	int proc_dir;
@@ -61,11 +58,11 @@ static void write_mapping(const pid_t proc_in_ns,
 static void ns_level2(void)
 {
 	if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
-		tst_res(TINFO | TERRNO, "Failed to set dumpable flag");
+		tst_brk(TBROK | TTERRNO, "Failed to set dumpable flag");
+
 	TST_CHECKPOINT_WAKE_AND_WAIT(1);
 
-	TST_EXP_FAIL(open("restricted", O_WRONLY), EACCES,
-		     "Denied write access to ./restricted");
+	TST_EXP_FAIL(open("restricted", O_WRONLY), EACCES, "Denied write access to ./restricted");
 
 	exit(0);
 }
@@ -89,7 +86,6 @@ static void ns_level1(void)
 	write_mapping(level2_proc, map_over_5);
 
 	TST_CHECKPOINT_WAKE(1);
-	tst_reap_children();
 
 	exit(0);
 }
@@ -111,7 +107,6 @@ static void run(void)
 	write_mapping(level1_proc, "0 100000 1000");
 
 	TST_CHECKPOINT_WAKE(0);
-	tst_reap_children();
 }
 
 static void setup(void)
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
