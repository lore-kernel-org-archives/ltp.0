Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BFFC25B74
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 06:31:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 954E43D0398
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 08:31:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E4EF3CF26C
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:30:48 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DC75E1401130
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:30:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A31791FB63;
 Mon, 27 May 2024 06:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716791446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxcQKByJt3iLPnF+3p7gHDlxOkZG0acXqkohP2VN3iE=;
 b=ZpyLyY/1bruDd/NRnzij44cDAh9azHWJLFhlK2zRtTgUfzWsD5T6DEJlThEguDvIudeqzp
 VpgcutAyYlLw+mtlMkQ1ZcgdOyitLKIPdgt7bIRZyEv/lWM+K1YgaaX5RDiazuN6ZXh7Ku
 8G26S5klj5JU+HHs4FA/x5rVhiElRPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716791446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxcQKByJt3iLPnF+3p7gHDlxOkZG0acXqkohP2VN3iE=;
 b=TjAo0fPPSd8wSP6rX9Z5BaLeXardAO2hiF2vE3l7m96xkTgOoZY7JoWcQ0ImEsr1c2wOf0
 TS+0QCODIXdUNRCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ZpyLyY/1";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TjAo0fPP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716791446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxcQKByJt3iLPnF+3p7gHDlxOkZG0acXqkohP2VN3iE=;
 b=ZpyLyY/1bruDd/NRnzij44cDAh9azHWJLFhlK2zRtTgUfzWsD5T6DEJlThEguDvIudeqzp
 VpgcutAyYlLw+mtlMkQ1ZcgdOyitLKIPdgt7bIRZyEv/lWM+K1YgaaX5RDiazuN6ZXh7Ku
 8G26S5klj5JU+HHs4FA/x5rVhiElRPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716791446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxcQKByJt3iLPnF+3p7gHDlxOkZG0acXqkohP2VN3iE=;
 b=TjAo0fPPSd8wSP6rX9Z5BaLeXardAO2hiF2vE3l7m96xkTgOoZY7JoWcQ0ImEsr1c2wOf0
 TS+0QCODIXdUNRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7687C13A56;
 Mon, 27 May 2024 06:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YJbvGZYoVGbMUgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 27 May 2024 06:30:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 27 May 2024 08:30:17 +0200
MIME-Version: 1.0
Message-Id: <20240527-shutdown-v1-2-1feffca5e3df@suse.com>
References: <20240527-shutdown-v1-0-1feffca5e3df@suse.com>
In-Reply-To: <20240527-shutdown-v1-0-1feffca5e3df@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3197;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=4KfxnlsS8qVznkn9gdRYyyFxawTwYjDo72iSf+cpDaI=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmVCiVgbJuZosXczYB48KYjCxJMnmGC/Q/GT8vV
 on8/J36b6mJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZlQolQAKCRDLzBqyILPm
 RgvFC/9vvoNdo8jYQ3w1ouCziBBtkUQvYPJTrWZSnfcVOxAEEjIG8Qdmga4yEErgnm7wxKeam/8
 u0wxlQ+Wm6urhEz7SZ5m/ge4WXhNHbol9sWkyBWPFY6o01xT/JUqZhE/yt8KmY37nLjpbEG//4D
 aqmPFqfICQt8Uk6XV0eINkql4V/t+/dMi37at3t2O/lEYt4wa6l202xI5X7KAliSM8zs6LlEhow
 qQ5Of2Z7SZuhOsrRPTY8ecbA50kLl3PHHfXhaDIFeY/xOx3Tzmd+Dft4RzR5UMgiMlx5mMXda/a
 PEO4LyiWS0RCQedodu1T3mvBsYh4Xh2WkotQLGMoFio6sLJj+OdsN/KSdLb4UiwJLfW04f3rgJ3
 ndJ/OZU302bjArReBnJVWHWUWhj5uoUTIk4C8aGrCUX+0am8Tb8LCEnQ9l9DQtjdf9Q/8CfGXkU
 sXhXSRCATU/MOVigcedcj1k9qB+449yszoMEhiKl/LbSarcYZG+AQpG/99I06hYW+t7VM=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A31791FB63
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Add shutdown02 test
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

This test verifies the following shutdown() errors:
* EBADF sockfd is not a valid file descriptor
* EINVAL An invalid value was specified in how
* ENOTCONN The specified socket is not connected
* ENOTSOCK The file descriptor sockfd does not refer to a socket

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/shutdown/.gitignore   |  1 +
 testcases/kernel/syscalls/shutdown/shutdown02.c | 75 +++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index dc396415e..44a577db3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1466,6 +1466,7 @@ shmget05 shmget05
 shmget06 shmget06
 
 shutdown01 shutdown01
+shutdown02 shutdown02
 
 sigaction01 sigaction01
 sigaction02 sigaction02
diff --git a/testcases/kernel/syscalls/shutdown/.gitignore b/testcases/kernel/syscalls/shutdown/.gitignore
index 2df24d1ab..fd1ed807d 100644
--- a/testcases/kernel/syscalls/shutdown/.gitignore
+++ b/testcases/kernel/syscalls/shutdown/.gitignore
@@ -1 +1,2 @@
 shutdown01
+shutdown02
diff --git a/testcases/kernel/syscalls/shutdown/shutdown02.c b/testcases/kernel/syscalls/shutdown/shutdown02.c
new file mode 100644
index 000000000..385e27f40
--- /dev/null
+++ b/testcases/kernel/syscalls/shutdown/shutdown02.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies the following shutdown() errors:
+ * * EBADF sockfd is not a valid file descriptor
+ * * EINVAL An invalid value was specified in how
+ * * ENOTCONN The specified socket is not connected
+ * * ENOTSOCK The file descriptor sockfd does not refer to a socket
+ */
+
+#include "tst_test.h"
+
+static int file_desc = -1;
+static int valid_sock = -1;
+static int invalid_sock = -1;
+
+static struct sockaddr_in *server_addr;
+
+static struct tcase {
+	int *socket;
+	int flags;
+	int error;
+} tcases[] = {
+	{&invalid_sock, PF_INET, EBADF},
+	{&valid_sock,   -1,      EINVAL},
+	{&valid_sock,   PF_INET, ENOTCONN},
+	{&file_desc,    PF_INET, ENOTSOCK},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL(shutdown(*tc->socket, tc->flags), tc->error);
+}
+
+static void setup(void)
+{
+	file_desc = SAFE_OPEN("notasocket", O_CREAT, 0640);
+	valid_sock = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
+
+	server_addr->sin_family = AF_INET;
+	server_addr->sin_port = 0;
+	server_addr->sin_addr.s_addr = INADDR_ANY;
+
+	SAFE_BIND(valid_sock,
+		(struct sockaddr *)server_addr,
+		sizeof(struct sockaddr_in));
+}
+
+static void cleanup(void)
+{
+	if (valid_sock != -1)
+		SAFE_CLOSE(valid_sock);
+
+	if (file_desc != -1)
+		SAFE_CLOSE(file_desc);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&server_addr, .size = sizeof(struct sockaddr_in)},
+		{}
+	}
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
