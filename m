Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA24C44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 13:18:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7AAF3E62A9
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 15:18:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 831723E4E24
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 15:17:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B8A9F6000E1
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 15:17:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F0FEA3E02;
 Mon, 20 Jul 2026 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784553478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S7NvYy9bVQCO5I4e7RXiNGnV96vr29Kj9TMzrA54GGU=;
 b=VlV9ZdG/H2cTrc6ysG+Puwhn5FS/co6fggRyc0i5wultEpuce8pxUMUN5hjyKEUyMMU4qC
 I2zhpEd1XwwqoWV8/DPpiun5JpzLe5fJEU7Z24a0woYUUrg7QFYy3PNGYC99xWjCUd5Dbo
 /26KppUaoYyJx5NB+imt+z3RoiF8JJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784553478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S7NvYy9bVQCO5I4e7RXiNGnV96vr29Kj9TMzrA54GGU=;
 b=SkBJ0PlAvW+P7N9Nzd5whYHTti8qqvTZeKWaSIfR74OmREHYpUmo3/h4TdA7HbbR6twHsg
 Z5p2kKh3pbDoemBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784553476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S7NvYy9bVQCO5I4e7RXiNGnV96vr29Kj9TMzrA54GGU=;
 b=EoWgwnj8dEX7oVyt/9JM48P6HzsXlwOOzgWAh8VqqeVqJ2+aCFfSbIAiYlwWp29Go9SDYy
 C3o+yS3BMcPGIM0f4XnMjZpATYzE+QQ0zvsNWDVdficmhFamiEvS1YldQ4ftO4i8eRq0H8
 hczGufBq1T+TD9iUZ5g6qxNy32CDckM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784553476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S7NvYy9bVQCO5I4e7RXiNGnV96vr29Kj9TMzrA54GGU=;
 b=bb7D0Rn6Q8DduSIC+wvN8Z7Rs7MN8bluOHuoLzRTiRhyKUQDZ+3qZaKYBag6CO2HxJAMz/
 vpl9hY9koiH5YrDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D534A779AA;
 Mon, 20 Jul 2026 13:17:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iGRhMgQgXmpcCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 20 Jul 2026 13:17:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 20 Jul 2026 15:17:55 +0200
MIME-Version: 1.0
Message-Id: <20260720-fix_cve-2026-46331_enoent-v2-1-395819e74978@suse.com>
X-B4-Tracking: v=1; b=H4sIAAIgXmoC/42NTQ6DIBBGr2Jm3WkERbCr3qMxhuJQWRQasKSN8
 e5FT9Dle/l+VkgUHSW4VCtEyi654AvwUwVm1v5B6KbCwGve1ZJJtO4zmky4C2y7pmEj+UB+wf7
 ec9FOWkhFUPqvSCV8bN+GwrNLS4jf4yqz3f6zmhkyVKLlghSzVupreic6m/CEYdu2H3/6s8fBA
 AAA
X-Change-ID: 20260717-fix_cve-2026-46331_enoent-9b9254da578e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784553476; l=3755;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=zfSP1aeEwPh5RgGskeeLLLUQX+mbf3LIU+TQyqrFzIg=;
 b=mFvSJDoBrg6TyyXgxMaRV3z4eSL0lVBjfl5BhboBJ6BScN0pUdWsgfo+QjGGs+UqYlG/YOLT9
 cLQNV4scvFLC0+wyAvcXXIU+aOCcwUnf82WHQwcar/EhR7PBICaLCSx
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid, mitre.org:url,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cve-2026-46331: fix intermittent ENOENT failure
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
Changes in v2:
- explain why we use root
- use tst_modprobe()
- add more CONFIG_* requirements
- Link to v1: https://lore.kernel.org/20260717-fix_cve-2026-46331_enoent-v1-1-85425e81ff7a@suse.com
---
 testcases/cve/cve-2026-46331.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/testcases/cve/cve-2026-46331.c b/testcases/cve/cve-2026-46331.c
index c33d358396f21024d8a68e9cd5c4cae0a9339a9f..6af43afb7910dd72777c1433f75dc8efce33366e 100644
--- a/testcases/cve/cve-2026-46331.c
+++ b/testcases/cve/cve-2026-46331.c
@@ -32,12 +32,19 @@
  * - Reread the file through the same ``O_RDONLY`` descriptor and
  *   compare with the original pattern; any difference means the
  *   page cache was corrupted
+ *
+ * The test needs root to preload the qdisc, classifier and action
+ * modules, which cannot be autoloaded from the unprivileged user
+ * namespace, before dropping privileges to an unprivileged user.
  */
 
 #include <sys/sendfile.h>
+#include <sys/prctl.h>
+#include <pwd.h>
 #include <linux/rtnetlink.h>
 
 #include "tst_test.h"
+#include "tst_module.h"
 #include "tst_net.h"
 #include "tst_netdevice.h"
 #include "lapi/if_ether.h"
@@ -128,7 +135,25 @@ static int acc_fd = -1;
 static void setup(void)
 {
 	struct sockaddr_in addr;
-	int i;
+	struct passwd *pw;
+	static const char *const mods[] = {
+		"sch_ingress", "cls_matchall", "act_pedit"
+	};
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(mods); i++)
+		tst_modprobe(mods[i], NULL);
+
+	/* Drop privileges so the reproducer runs as an unprivileged user */
+	pw = SAFE_GETPWNAM("nobody");
+	SAFE_SETGID(pw->pw_gid);
+	SAFE_SETUID(pw->pw_uid);
+
+	/*
+	 * setuid() clears the dumpable flag, which makes the /proc/self
+	 * files owned by root and prevents tst_setup_netns() from writing the
+	 * uid/gid maps. Restore it so the user namespace can be set up.
+	 */
+	SAFE_PRCTL(PR_SET_DUMPABLE, 1, 0, 0, 0);
 
 	tst_setup_netns();
 	NETDEV_SET_STATE("lo", 1);
@@ -144,7 +169,7 @@ static void setup(void)
 	SAFE_BIND(listen_fd, (struct sockaddr *)&addr, sizeof(addr));
 	SAFE_LISTEN(listen_fd, 1);
 
-	for (i = 0; i < DATA_SIZE; i++)
+	for (unsigned int i = 0; i < DATA_SIZE; i++)
 		original[i] = (uint8_t)(i & 0xff);
 
 	memset(&pedit_sel_buf, 0, sizeof(pedit_sel_buf));
@@ -253,7 +278,12 @@ static struct tst_test test = {
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
base-commit: ab04cf4157defb7f21a3cbf3392dec758dab590a
change-id: 20260717-fix_cve-2026-46331_enoent-9b9254da578e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
