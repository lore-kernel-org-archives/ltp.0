Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81FAC27C55
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 08:14:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2978F3D0A89
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 10:14:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 738363D0A74
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 10:13:46 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 013241A0C27A
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 10:13:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EAC7E1FB8A;
 Fri,  7 Jun 2024 08:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717748024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyGjTOVFto2u28+DbdN/7Hy/PSbpZgM3L2+AMotQGhw=;
 b=kZdHvanLg5EyOLgMBhBlcCD8K4utL12SxUr5d0b6tCJ8uznttuqSIGdcJaSUuQs5K7BhW0
 ItiEhtwsuP36B2xGhQTRUIzgU5vZAR1ZhqwRrIgxuWPhMeTefYAFD1RugmkqI20o1jHBxh
 VITiLHaqqNVjYOrG7Epsq2aYgUfEg2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717748024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyGjTOVFto2u28+DbdN/7Hy/PSbpZgM3L2+AMotQGhw=;
 b=butn8oSrOeoEzJCJZ6HKhkbCTRmlPWldH20SLe7DXVaJ3w3O9fPd8R4RaXRWfVUSW+s0gr
 ZEiyyhVN6nbbH2BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ut9HO7eo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3R562xUP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717748023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyGjTOVFto2u28+DbdN/7Hy/PSbpZgM3L2+AMotQGhw=;
 b=Ut9HO7eoCpFC0zlES6AlBiF4syzqcGlMiLrOSlGAWle22SILRXkOT0UzwOJDQuGTbRcvkZ
 LRB6KeRHdO5hKnVP3YlZv2gqu4lzVXKoBP3s3A/76fgISvC49eTcFdaa+LP3eBEhu9Jac4
 8P2WK6IMdaS0H84wJZVJ1uLm6yqXyRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717748023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyGjTOVFto2u28+DbdN/7Hy/PSbpZgM3L2+AMotQGhw=;
 b=3R562xUPmVT8nNJCBlxIa6uu2N6AerPcNIwjf1fCh8hYIVcHJj/k85MNQZzqhUcnvJ9K8q
 VCUd4JGZHl5P9pCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE5FC13A98;
 Fri,  7 Jun 2024 08:13:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wLxcMDfBYmbkBwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Jun 2024 08:13:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Jun 2024 10:13:15 +0200
MIME-Version: 1.0
Message-Id: <20240607-shutdown-v2-2-a09ce3290ee1@suse.com>
References: <20240607-shutdown-v2-0-a09ce3290ee1@suse.com>
In-Reply-To: <20240607-shutdown-v2-0-a09ce3290ee1@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3204;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=F181Ux3O86g7bw93EXHFLInGU3utYqA3HLTwPpSD1ho=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmYsE3pqV9vGGGYosctt+inq2kHlW9IM0uFJsyG
 N5+nCtZ0HKJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmLBNwAKCRDLzBqyILPm
 RtJnC/9EmDnHuUR5M3yCfCHv7+9mWR7VdwR3SjMZU35uTPTI51HTD90Fr3YPmz6zj3VP5rC7vUr
 iIc8JUYDWGik8y5XZXLjfTqGUUxGv+dG7rzRWlDcKR/iZ9Fn2WLT8BOj1URm0XAleupmrWChJ3f
 X3YbKs4axTceNTrDZHqQ2+zP0aw8jPbirOFBuNun35//ullmwh7eJg2mw6kJ5PPJnBXngtd63Cn
 wOLx+z67ptyGy9z3Dt/lt1JCAPGxwnjbbXpVKbiBftw0fWp7PA8XrAKYSnsvlHXksDuwJMEhZtC
 zUVVXp4M8mdSEIFfXvRz+6ORD0+BNrGSfF4SV6VGYwcqqUUjOBKb1NRvo0QbTfNYrEBC+PHZ+aA
 DAjhBR+VAwTe0raK87K7WmmBgao9UzRiCFhGGuLHHODcUGegje2VwT4sTgFXzPuP1xvf8ptGxZP
 3nTFirjQfmM8bIPpwvxCnXx7IpoNvpYBtSdME2ZeinjSnaCLLJ9nArrdjLqiOKQT1zV+8=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EAC7E1FB8A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] Add shutdown02 test
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

- EBADF sockfd is not a valid file descriptor
- EINVAL An invalid value was specified in how
- ENOTCONN The specified socket is not connected
- ENOTSOCK The file descriptor sockfd does not refer to a socket

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/shutdown/.gitignore   |  1 +
 testcases/kernel/syscalls/shutdown/shutdown02.c | 76 +++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

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
index 000000000..4aae8469f
--- /dev/null
+++ b/testcases/kernel/syscalls/shutdown/shutdown02.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies the following shutdown() errors:
+ *
+ * - EBADF sockfd is not a valid file descriptor
+ * - EINVAL An invalid value was specified in how
+ * - ENOTCONN The specified socket is not connected
+ * - ENOTSOCK The file descriptor sockfd does not refer to a socket
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
