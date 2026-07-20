Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D20DC4452A
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 14:32:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31A4A3E9056
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 16:32:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB71E3E9606
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:32:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 622B814002C8
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:32:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 11CA43E29;
 Mon, 20 Jul 2026 14:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784557913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RB9O6xcqdZbZLlUshoq4MrzTePxECEZO1U2nXbGjK/4=;
 b=l+SPp7qELvJaIKZkAduQP8DPU3V47zCEghIaJ1CD29ag3Z/DIIv+n0YIY3NNx1kTaIIq1M
 rrESWWhpL8r5TgL+wlrllWAymzYRODJn3eMwmKoylXf5dc1kj/fEB7xVQpLZsGGKLdQ3n5
 RUcuvU6H8EGeBcZP/oHQi3bYpz9ZWHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784557913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RB9O6xcqdZbZLlUshoq4MrzTePxECEZO1U2nXbGjK/4=;
 b=pdzXgbnYTPsgvnBo30aXW2YQGB/OTxGWRhzZnt0lzoGtQYusODUZDddJmZ6s4ODSbF4P/k
 ydKVzY8714JhoLCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784557913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RB9O6xcqdZbZLlUshoq4MrzTePxECEZO1U2nXbGjK/4=;
 b=l+SPp7qELvJaIKZkAduQP8DPU3V47zCEghIaJ1CD29ag3Z/DIIv+n0YIY3NNx1kTaIIq1M
 rrESWWhpL8r5TgL+wlrllWAymzYRODJn3eMwmKoylXf5dc1kj/fEB7xVQpLZsGGKLdQ3n5
 RUcuvU6H8EGeBcZP/oHQi3bYpz9ZWHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784557913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RB9O6xcqdZbZLlUshoq4MrzTePxECEZO1U2nXbGjK/4=;
 b=pdzXgbnYTPsgvnBo30aXW2YQGB/OTxGWRhzZnt0lzoGtQYusODUZDddJmZ6s4ODSbF4P/k
 ydKVzY8714JhoLCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA13E779AA;
 Mon, 20 Jul 2026 14:31:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AKtPN1gxXmrEUAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 20 Jul 2026 14:31:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 20 Jul 2026 16:31:52 +0200
MIME-Version: 1.0
Message-Id: <20260720-fix_cve-2026-46331_enoent-v3-2-9f216efdd661@suse.com>
References: <20260720-fix_cve-2026-46331_enoent-v3-0-9f216efdd661@suse.com>
In-Reply-To: <20260720-fix_cve-2026-46331_enoent-v3-0-9f216efdd661@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784557912; l=2820;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=trc+BcieqleWaHkMtbbDWFrHXF0/VR9T3JN/KaxVsSw=;
 b=wqyKbf0kuCTh1qF+183QTXg/K1qBBUjOOgQ0J/Lbu3fm/JVAm2hHKt1OHg6WUDtEhThMAeNLA
 zy1krhYhMssBBzzaSvzuZXe231MbwMyfddm5Qv5VP586fHJO+fw9Z4a
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] cve-2026-46331: fix intermittent ENOENT failure
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

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
