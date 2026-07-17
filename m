Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6ACC44516
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 13:21:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62A3B3E72B0
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 15:21:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC0443E21A7
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 15:21:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1B6CC1000237
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 15:21:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 767AE3E44;
 Fri, 17 Jul 2026 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784294483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CccPlEggL+m118qluozfHQHGy6vydXkEKYYwV0Dpe6M=;
 b=iOyGz7/xSEzlakgXllNx95IQKqPPRIyeuyioRkhoCmKhY6gbfWHjOyVeypij80gLttcbqV
 bERT1kj8VoOZ+oFp/JVSokWFa/u2IdbpwYHQvVVaS3pjisWuPQ81+OdISj0ZWOhlm68BOc
 6h1ej31yo3HPk+CZh+iQcVeclrVZCiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784294483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CccPlEggL+m118qluozfHQHGy6vydXkEKYYwV0Dpe6M=;
 b=B2fFRC77CxzGXmfImCxCLPANR6Y9iv1SQf0oq4yAWwp96M1ZY8FrWg+l1LAPGECYVw8aOs
 77R0RDDwNuCPMdDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784294483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CccPlEggL+m118qluozfHQHGy6vydXkEKYYwV0Dpe6M=;
 b=iOyGz7/xSEzlakgXllNx95IQKqPPRIyeuyioRkhoCmKhY6gbfWHjOyVeypij80gLttcbqV
 bERT1kj8VoOZ+oFp/JVSokWFa/u2IdbpwYHQvVVaS3pjisWuPQ81+OdISj0ZWOhlm68BOc
 6h1ej31yo3HPk+CZh+iQcVeclrVZCiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784294483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CccPlEggL+m118qluozfHQHGy6vydXkEKYYwV0Dpe6M=;
 b=B2fFRC77CxzGXmfImCxCLPANR6Y9iv1SQf0oq4yAWwp96M1ZY8FrWg+l1LAPGECYVw8aOs
 77R0RDDwNuCPMdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58F0B779AA;
 Fri, 17 Jul 2026 13:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lbv6E1MsWmqTXgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 17 Jul 2026 13:21:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 17 Jul 2026 15:21:15 +0200
MIME-Version: 1.0
Message-Id: <20260717-fix_cve-2026-46331_enoent-v1-1-85425e81ff7a@suse.com>
X-B4-Tracking: v=1; b=H4sIAEosWmoC/x2MSQqAMBAEvyJzdsDEJepXRMSl1blESUQE8e9Gj
 9VU100eTuCpjm5yOMXLZgOoOKJx7e0Clikw6UQXiVGGZ7m68QR/A2dFmqoOdoM9uBoqnWdTn5s
 SFP67Q5D/dtM+zwuHVTdCawAAAA==
X-Change-ID: 20260717-fix_cve-2026-46331_enoent-9b9254da578e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784294483; l=2923;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=z4HbUdm0jCwOTwi4/4oWW9uwth2wC2HHY8dBR6Q1XDw=;
 b=USA3NxC1Rne1rOCVq/8Dc/Z8Ng53klrCku48iWYwVE0h0M9MU48qW4i/OAo8Lv+5HnMaEUfli
 kdG+NQeGPTuBZYYi33GYLgDGb/w+7OfaSkAvcJtGQdbjolwFnXTc3PI
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve-2026-46331: fix intermittent ENOENT failure
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

The required qdisc, classifier and action modules cannot be
autoloaded from the unprivileged user namespace, so arming the
traffic filter sometimes failed with ENOENT.

Preload the modules as root before dropping privileges and entering
the network namespace.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:755: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1872: TINFO: Overall timeout per run is 0h 02m 00s
cve-2026-46331.c:200: TBROK: Failed to modify traffic filter: ENOENT

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=899ee91156e5

HINT: You _MAY_ be vulnerable to CVE(s):

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2026-46331
---
 testcases/cve/cve-2026-46331.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/testcases/cve/cve-2026-46331.c b/testcases/cve/cve-2026-46331.c
index c33d358396f21024d8a68e9cd5c4cae0a9339a9f..dd19860e1d35152547e933850d7b8c91281240c4 100644
--- a/testcases/cve/cve-2026-46331.c
+++ b/testcases/cve/cve-2026-46331.c
@@ -35,6 +35,8 @@
  */
 
 #include <sys/sendfile.h>
+#include <sys/prctl.h>
+#include <pwd.h>
 #include <linux/rtnetlink.h>
 
 #include "tst_test.h"
@@ -128,7 +130,31 @@ static int acc_fd = -1;
 static void setup(void)
 {
 	struct sockaddr_in addr;
-	int i;
+	struct passwd *pw;
+	static const char *const mods[] = {
+		"sch_ingress", "cls_matchall", "act_pedit"
+	};
+	static const char *cmd[] = {"modprobe", NULL, NULL};
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(mods); i++) {
+		cmd[1] = mods[i];
+
+		if (tst_cmd(cmd, NULL, "/dev/null", TST_CMD_PASS_RETVAL))
+			tst_brk(TCONF, "kernel module %s is not available", mods[i]);
+	}
+
+	/* Drop privileges so the reproducer runs as an unprivileged user */
+	pw = SAFE_GETPWNAM("nobody");
+	SAFE_SETGID(pw->pw_gid);
+	SAFE_SETUID(pw->pw_uid);
+
+	/*
+	 * setuid() clears the dumpable flag, which makes /proc/self/*
+	 * owned by root and prevents tst_setup_netns() from writing the
+	 * uid/gid maps. Restore it so the user namespace can be set up.
+	 */
+	SAFE_PRCTL(PR_SET_DUMPABLE, 1, 0, 0, 0);
 
 	tst_setup_netns();
 	NETDEV_SET_STATE("lo", 1);
@@ -253,7 +279,12 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "modprobe"},
+		{}
+	},
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",

---
base-commit: a67fe5f7b20492ff6ee7f4b1776a7579d4b3859b
change-id: 20260717-fix_cve-2026-46331_enoent-9b9254da578e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
