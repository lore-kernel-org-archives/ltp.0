Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3ECC02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 11:37:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24C7C3C7C0F
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 12:37:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 075E53C7BCF
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:36:06 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7849E6182D6
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:36:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1B8E1F79E
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737027365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxLEv3NKu/QrfFpkjBt7RvHl+KmhNBWVw7YJ9lwC6qM=;
 b=WQHLfsUIfHbugTnHathSrMtPfvPiPrmXswsCdU26fhAlFRgf0AownGQEU0brCwglp0P40u
 ZsLVkPFPC/CE+N9V5Ks38yskbjHqWMOHWgCxKsxSk+8R16VwY5S4njDKJBcUZRPkxJTbL/
 1HIfcbthSwVEAqrMOiZ/EQLtYGKKFR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737027365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxLEv3NKu/QrfFpkjBt7RvHl+KmhNBWVw7YJ9lwC6qM=;
 b=Gtcm/VKzdyxb1d+4aH5NpfjyiNnfWHKGUaHaiMKc/fOIHAg3cdB3PKybqURjn6GDyQ1TAS
 gnHfTdjfZkwbn7Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WZNJPABr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A4hBszUk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737027364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxLEv3NKu/QrfFpkjBt7RvHl+KmhNBWVw7YJ9lwC6qM=;
 b=WZNJPABrH0jYOTrnSgcqqaE7sCdTWaUUrMi/TjXFD2urkurPRrsqC+MRSTcODY2As6rz1A
 z5e9Q0OvcKJ284Q8nBGn/iaACGYVRZEx0Ou1i2EZwtSx7XD08izBsrpBhAdDXV+hc+Sskg
 eLZEjkp0XMfJsLpVMIee6nkgsSODX3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737027364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxLEv3NKu/QrfFpkjBt7RvHl+KmhNBWVw7YJ9lwC6qM=;
 b=A4hBszUkY6fkxuhvwa/AvWrYTbNmNdlR0eeuMOFhRIAN6geA+zA9V6CPK4d1wuXg7aL+k3
 xeiM29S49AolJ4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D452A13332
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:36:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WCI1MiTviGdrOgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:36:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Jan 2025 12:36:07 +0100
MIME-Version: 1.0
Message-Id: <20250116-fix_setsid_tests-v4-8-910f062a7235@suse.com>
References: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
In-Reply-To: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737027362; l=2436;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=uNroMNPjV1vM17IAwYAxU9btOI4reVZ8o/Pqrs4ZZng=;
 b=yOkdpG19KZiIpA0waHPQkjrY9eqm6mSjQBol1uauTRfZoRIazW9vGYUStODOaCQzAQQBPDf9M
 I5ZqyRWBofECdfsVSdkEqQoPDZ4AlwPu2acGJtCqyONatcHFov/xsA1
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: F1B8E1F79E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.cz:email];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 08/12] Add ptem06 test
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
