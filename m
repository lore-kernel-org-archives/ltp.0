Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6EEE7719A
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 14:14:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01EDA3C2619
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 15:14:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5825C3C185A
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:20 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA27261E265
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1EFD21172
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxLEv3NKu/QrfFpkjBt7RvHl+KmhNBWVw7YJ9lwC6qM=;
 b=LnMwkVEMmBZbaY2xMNCGi0FgQlu6NcszDpnfMybaobcfNPMUBbMu4tuSbsUsWKkp3++ME7
 vTGKEyj+wqAQ7X6GvLm55qY/OzkF3iHaYbM6jiL8t7L/4xMnQ2HPK7jOhKaDh2jIpZGkA5
 IX/laNbVsolRlH0DHozAZYpKGuHX2ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxLEv3NKu/QrfFpkjBt7RvHl+KmhNBWVw7YJ9lwC6qM=;
 b=VHPTsyHPnWh46uHss1QMeN5v8C1LjzhA8J99D/Kt6Qt6lGKzgjA3JbfpH1eJ5dbwXZy72g
 GTRWnU0hk8sW3uDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxLEv3NKu/QrfFpkjBt7RvHl+KmhNBWVw7YJ9lwC6qM=;
 b=LnMwkVEMmBZbaY2xMNCGi0FgQlu6NcszDpnfMybaobcfNPMUBbMu4tuSbsUsWKkp3++ME7
 vTGKEyj+wqAQ7X6GvLm55qY/OzkF3iHaYbM6jiL8t7L/4xMnQ2HPK7jOhKaDh2jIpZGkA5
 IX/laNbVsolRlH0DHozAZYpKGuHX2ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxLEv3NKu/QrfFpkjBt7RvHl+KmhNBWVw7YJ9lwC6qM=;
 b=VHPTsyHPnWh46uHss1QMeN5v8C1LjzhA8J99D/Kt6Qt6lGKzgjA3JbfpH1eJ5dbwXZy72g
 GTRWnU0hk8sW3uDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD54113A8B
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0JZsLAbZf2eVWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 14:11:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 09 Jan 2025 15:11:11 +0100
MIME-Version: 1.0
Message-Id: <20250109-fix_setsid_tests-v3-8-2ce60c904019@suse.com>
References: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
In-Reply-To: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736431876; l=2436;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=uNroMNPjV1vM17IAwYAxU9btOI4reVZ8o/Pqrs4ZZng=;
 b=XEa+BGKpR+cv5MDaIn7vQ2KHtf+I1olF0wJE5UXKRdFA+voqxbVbJsZv/khXXfuMLxC0a8Rru
 fYks0jK8X0uB/XXLpzs++ZiNInz3hDg7eEYM1HcoB7Yfs5Y592Y6uaz
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 08/12] Add ptem06 test
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
to obtain a slave device and to set baudrate to B0 (which means hang
up).

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/pty                     |  1 +
 testcases/kernel/pty/.gitignore |  1 +
 testcases/kernel/pty/ptem06.c   | 52 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/runtest/pty b/runtest/pty
index deb04c3f5725647a32f457eaed638eb7071ab4db..6343da391ba17627abaf09aa5a23509e4f745556 100644
--- a/runtest/pty
+++ b/runtest/pty
@@ -11,5 +11,6 @@ ptem02 ptem02
 ptem03 ptem03
 ptem04 ptem04
 ptem05 ptem05
+ptem06 ptem06
 hangup01 hangup01
 
diff --git a/testcases/kernel/pty/.gitignore b/testcases/kernel/pty/.gitignore
index ef5751907cad087f5e33132b52a374b52ee7905a..630d7fcf7b0e0adfbc21b793fa456d6c5f5e4ad9 100644
--- a/testcases/kernel/pty/.gitignore
+++ b/testcases/kernel/pty/.gitignore
@@ -4,6 +4,7 @@
 /ptem03
 /ptem04
 /ptem05
+/ptem06
 /pty01
 /pty02
 /pty03
diff --git a/testcases/kernel/pty/ptem06.c b/testcases/kernel/pty/ptem06.c
new file mode 100644
index 0000000000000000000000000000000000000000..810b7c1d6a774290baf24c12cedccb85242367c4
--- /dev/null
+++ b/testcases/kernel/pty/ptem06.c
@@ -0,0 +1,52 @@
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
+ * Verify that it's possible to open a pseudo-terminal via /dev/ptmx, to obtain
+ * a slave device and to set baudrate to B0 (which means hang up).
+ */
+
+#define _GNU_SOURCE
+
+#include <termios.h>
+#include "common.h"
+
+static int masterfd = -1;
+
+static void run(void)
+{
+	int slavefd;
+	struct termios termios;
+
+	slavefd = open_slave(masterfd);
+
+	TST_EXP_PASS(ioctl(slavefd, TCGETS, &termios));
+	termios.c_cflag &= ~CBAUD;
+	termios.c_cflag |= B0 & CBAUD;
+	TST_EXP_PASS(ioctl(slavefd, TCSETS, &termios));
+
+	SAFE_CLOSE(slavefd);
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
