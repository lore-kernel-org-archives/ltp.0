Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2359AC433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 09:28:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 441593C9EF5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 10:28:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AE193C9888
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 10:26:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 070256008C2
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 10:26:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F8892113A;
 Fri, 11 Feb 2022 09:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644571613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOoCZy/kNXQq3YBYjmP3dHc8D4Io1/zT0ltEvI4Hvl4=;
 b=j7ABSQkLy9xvQIEejkbJnWnHd+9So4650jH5uAwIhzG4NgWSRoDjhzQAIDBJ1CzLbdl67C
 n5w1n3zNbi0Gvn8JFeKFd3Gt6Rc+H6WmFBF8D82ER75XaJ4KaAMAvlz/GqrwXAbFXXAOCl
 yJSgyaJmF6NiWnZIdKCJCyuqF06RlAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644571613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOoCZy/kNXQq3YBYjmP3dHc8D4Io1/zT0ltEvI4Hvl4=;
 b=lF26RnER8wyNFuF7BkeNv7b24p8LyMHFVy4w4JD6Wgp8L0eivWteWcnYVBMtOyJoigOhSv
 xQm0hvl8xNpQQVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64C3E13BC3;
 Fri, 11 Feb 2022 09:26:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WOqSFt0rBmJ7EwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Feb 2022 09:26:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 11 Feb 2022 10:26:46 +0100
Message-Id: <20220211092646.23748-9-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211092646.23748-1-andrea.cervesato@suse.de>
References: <20220211092646.23748-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 8/8] Rewrite userns08.c using new LTP API
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
 testcases/kernel/containers/userns/userns08.c | 49 +++++++++----------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index c141b1aca..1935fcf11 100644
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
@@ -61,18 +58,19 @@ static void write_mapping(const pid_t proc_in_ns,
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
 
 static void ns_level1(void)
 {
-	const char *const map_over_5 = "0 0 1\n1 1 1\n2 2 1\n3 3 1\n4 4 1\n5 5 990";
+	const char *const map_over_5 =
+		"0 0 1\n1 1 1\n2 2 1\n3 3 1\n4 4 1\n5 5 990";
 	pid_t level2_proc;
 
 	TST_CHECKPOINT_WAIT(0);
@@ -89,7 +87,6 @@ static void ns_level1(void)
 	write_mapping(level2_proc, map_over_5);
 
 	TST_CHECKPOINT_WAKE(1);
-	tst_reap_children();
 
 	exit(0);
 }
@@ -111,7 +108,6 @@ static void run(void)
 	write_mapping(level1_proc, "0 100000 1000");
 
 	TST_CHECKPOINT_WAKE(0);
-	tst_reap_children();
 }
 
 static void setup(void)
@@ -130,17 +126,20 @@ static struct tst_test test = {
 	.needs_checkpoints = 1,
 	.needs_root = 1,
 	.forks_child = 1,
-	.needs_kconfigs = (const char *[]) {
-		"CONFIG_USER_NS",
-		NULL
-	},
-	.save_restore = (const char * const[]) {
-		"?/proc/sys/user/max_user_namespaces",
-		NULL,
-	},
-	.tags = (const struct tst_tag[]) {
-		{"linux-git", "d2f007dbe7e4"},
-		{"CVE", "CVE-2018-18955"},
-		{}
-	},
+	.needs_kconfigs =
+		(const char *[]){
+			"CONFIG_USER_NS",
+			NULL,
+		},
+	.save_restore =
+		(const char *const[]){
+			"?/proc/sys/user/max_user_namespaces",
+			NULL,
+		},
+	.tags =
+		(const struct tst_tag[]){
+			{ "linux-git", "d2f007dbe7e4" },
+			{ "CVE", "CVE-2018-18955" },
+			{},
+		},
 };
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
