Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE99BE77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 14:12:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D3F13C2692
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 15:12:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63B3D3C2590
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:19 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 022721BC09C7
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 94EB821171
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6T3UNaDen1ILyuOfT0KGDJAAQ5slQgdii84e5YXsj34=;
 b=CxyQXPYBCjodYodjAUW52tHALnXeeOEhlUv/9ZZHTDugrAmCJMkR6pNMJR5ApbjOQRRuQM
 +TgSRdgdMhMVbkUWxbQg0JlhBG8lXtntkeqCIieNE34N/Z6QSupXF8bybS/+f8UwSZErxP
 K/6U1YSDAAMbd53ZmvoczbhvL/caAsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6T3UNaDen1ILyuOfT0KGDJAAQ5slQgdii84e5YXsj34=;
 b=87w16ST80supZ4WpW4a0JPIVB4UrClfPqOAHiYkpKT/zzQiqn4Qwqo7M7/xlHubLFEBuaa
 xzTgsG4ihAxv/fDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CxyQXPYB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=87w16ST8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6T3UNaDen1ILyuOfT0KGDJAAQ5slQgdii84e5YXsj34=;
 b=CxyQXPYBCjodYodjAUW52tHALnXeeOEhlUv/9ZZHTDugrAmCJMkR6pNMJR5ApbjOQRRuQM
 +TgSRdgdMhMVbkUWxbQg0JlhBG8lXtntkeqCIieNE34N/Z6QSupXF8bybS/+f8UwSZErxP
 K/6U1YSDAAMbd53ZmvoczbhvL/caAsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6T3UNaDen1ILyuOfT0KGDJAAQ5slQgdii84e5YXsj34=;
 b=87w16ST80supZ4WpW4a0JPIVB4UrClfPqOAHiYkpKT/zzQiqn4Qwqo7M7/xlHubLFEBuaa
 xzTgsG4ihAxv/fDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CB3D13A8B
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eAeSGwbZf2eVWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 14:11:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 09 Jan 2025 15:11:09 +0100
MIME-Version: 1.0
Message-Id: <20250109-fix_setsid_tests-v3-6-2ce60c904019@suse.com>
References: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
In-Reply-To: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736431876; l=2362;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=S04fYz+IkoQp58z6W3bEM79f2gd/tH9A0budUgW0thU=;
 b=Cwcc4hgIC5eMVkW9PkMPAGVdzonlvOKjug2BVAAmTV+KwlebngtmKmOFvH5gQv5TcBDj23dFv
 g8ALNj5WOmiDasP6kkPhtMpQv2RVt5qy5Kd04d7cOZEvfoufXWGfbbg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 94EB821171
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 06/12] Add ptem04 test
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

Verify that it's possible to open a pseudo-terminal via /dev/ptmx,
obtain a slave device and to check if it's possible to open it
multiple times.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/pty                     |  1 +
 testcases/kernel/pty/.gitignore |  1 +
 testcases/kernel/pty/ptem04.c   | 49 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/runtest/pty b/runtest/pty
index 329cc84cdc107ab8e814fea72a8088ea62d5ad25..63d927eca07aa3dbd312d5c5cc6b6681dbf3627d 100644
--- a/runtest/pty
+++ b/runtest/pty
@@ -9,5 +9,6 @@ pty07 pty07
 ptem01 ptem01
 ptem02 ptem02
 ptem03 ptem03
+ptem04 ptem04
 hangup01 hangup01
 
diff --git a/testcases/kernel/pty/.gitignore b/testcases/kernel/pty/.gitignore
index 61fec1ddae3ea39d20e97123e34888708050c25c..c9bb33664f9de55038f4638406841f403f1a86c4 100644
--- a/testcases/kernel/pty/.gitignore
+++ b/testcases/kernel/pty/.gitignore
@@ -2,6 +2,7 @@
 /ptem01
 /ptem02
 /ptem03
+/ptem04
 /pty01
 /pty02
 /pty03
diff --git a/testcases/kernel/pty/ptem04.c b/testcases/kernel/pty/ptem04.c
new file mode 100644
index 0000000000000000000000000000000000000000..675e6b816dc916e48508af19c1b9f45784accff7
--- /dev/null
+++ b/testcases/kernel/pty/ptem04.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2002
+ * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that it's possible to open a pseudo-terminal via /dev/ptmx, obtain a
+ * slave device and to check if it's possible to open it multiple times.
+ */
+
+#define _GNU_SOURCE
+
+#include "common.h"
+
+#define NUM_SLAVES 10
+
+static int masterfd = -1;
+
+static void run(void)
+{
+	int slavefd[NUM_SLAVES];
+
+	for (int i = 0; i < NUM_SLAVES; i++)
+		slavefd[i] = TST_EXP_FD(open_slave(masterfd));
+
+	for (int i = 0; i < NUM_SLAVES; i++)
+		SAFE_CLOSE(slavefd[i]);
+}
+
+static void setup(void)
+{
+	masterfd = open_master();
+}
+
+static void cleanup(void)
+{
+	if (masterfd != -1)
+		SAFE_CLOSE(masterfd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
