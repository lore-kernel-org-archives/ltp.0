Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A03C61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:06:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A1A53E588C
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:06:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC94C3E93AB
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1FC9C200BA9
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7DC481F7F9;
 Wed,  2 Sep 2026 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJS9P/h9xh2elksAlKP0Y3B6wWeiRLMmSAR55qjiwms=;
 b=Y2Qfpe2dkdDbT0xxX3hFHQ+sLnjoaLL4DYCeM1BeXFI8SeC3ZU/FW5bNHzYAAPmpfaum0y
 EYnO+I2ynMhQ61/lXn2yhb3fV03nz47wKC87kmhk1eMO2rhCLiblIiQ5WfhzpCVHtceryE
 UOXrALcPu4QHIWszb+VG6xboisndG4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJS9P/h9xh2elksAlKP0Y3B6wWeiRLMmSAR55qjiwms=;
 b=v0Or0dvwgZpO7y0QXMh4zWECFKY2bg06Y1+HRIb8ojRQkeEX/LvoIR3dX95RDp1zYQEjNr
 Lr2Pu+LVU2MarMDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJS9P/h9xh2elksAlKP0Y3B6wWeiRLMmSAR55qjiwms=;
 b=tr54G7m56j6Ix5jBphuzuzlBgFU/3S8lvNA+HYIKGl6a9ectcxEsymthNEdOxuVwZWslKL
 VgHjfHimtCItoz0/uS6zm6jwbWBtqjo6l7ESlHPgGSBwaNvcNPg1XAzar8YQFu0C5B0nPr
 +4oCRM5RBZwjtYywiPQhHB9m88qj6UE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJS9P/h9xh2elksAlKP0Y3B6wWeiRLMmSAR55qjiwms=;
 b=Wy1fXw+F1C8ay0Vf5uwabdzYBbcYbXLhvybSqnWsSBEzHz8wU098xqKgPdLUq4pZN/qi5H
 TqIPCa4zJvfuklAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E77571397D;
 Wed,  2 Sep 2026 11:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UI6kNrcCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:26 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-11-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=2299;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=FXUJ4fL0RSqLZSy0bfMx65qehuajc481hZyXGruJ/AA=;
 b=uqLqMV/V6T/MWY94YqFwdYF0yDMWPHajhEUAaOD8m4VdYTTcjPZ3JRfFnBEmR1YgO3YOBN8hZ
 crdwreMcFNnB5y/GsrFudsJR/1fjcuNmlb5TfhNU1iVgVdlKSRD2WOT
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 11/33] keyctl19: Test KEYCTL_MOVE with same source and
 destination
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

Test KEYCTL_MOVE when the source keyring equals the destination
keyring: verify the operation succeeds as a no-op and the key
remains linked in the keyring.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl19.c | 43 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 895dd0fc4..1935bee31 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -736,6 +736,7 @@ keyctl15 keyctl15
 keyctl16 keyctl16
 keyctl17 keyctl17
 keyctl18 keyctl18
+keyctl19 keyctl19
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 808cd2d23..f32107923 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -16,3 +16,4 @@
 /keyctl16
 /keyctl17
 /keyctl18
+/keyctl19
diff --git a/testcases/kernel/syscalls/keyctl/keyctl19.c b/testcases/kernel/syscalls/keyctl/keyctl19.c
new file mode 100644
index 000000000..389ad7603
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl19.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_MOVE`` of :manpage:`keyctl(2)` with same source and destination.
+ *
+ * [Algorithm]
+ *
+ * - move a key where the source keyring equals the destination keyring,
+ *   verify it is a successful no-op
+ */
+
+#include "keyctl_common.h"
+
+#define RING_DESC	"ltpkeyctl19"
+#define KEY_DESC	"k"
+#define PAYLOAD		"payload"
+
+static key_serial_t ring;
+static key_serial_t key;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	ring = new_ring(RING_DESC);
+	key = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring);
+}
+
+static void run(void)
+{
+	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key, ring, ring, 0));
+
+	TST_EXP_EQ_LI(search_ring(ring, "user", KEY_DESC), key);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "5.3",
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
