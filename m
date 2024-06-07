Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C9EC27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 08:14:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17EEB3D0A7D
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 10:14:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A40A13D0A74
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 10:13:46 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DA00014052EF
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 10:13:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C698121B50;
 Fri,  7 Jun 2024 08:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717748023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cwiIHLPVz8oDjUCOekd2wDyzb9V8/tcc2T9FC5Bllg=;
 b=y0AZ/T5Mpn5qSL3FShUyZjj70w/e71mk2CNbrOWG2Ar5k6NOO3rxiDTJ8qm4nUOWlbNo0K
 WCyamHI7DxULVi3xGhlQLkLKy79y87RwKxHx5v9k+mRJGjFysZhKd8ZeV22k1gXiSlloPq
 xZatgk3y+NjGnNO51qZpTLTK7muttRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717748023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cwiIHLPVz8oDjUCOekd2wDyzb9V8/tcc2T9FC5Bllg=;
 b=Y14WgQ89Z7QUSsn6rQhNOAMQFxyPZePx6I5FNG2bJzoBodPE98u6kh6qiU460+CyY824O7
 3LC4rZuJbbJq0EBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717748023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cwiIHLPVz8oDjUCOekd2wDyzb9V8/tcc2T9FC5Bllg=;
 b=y0AZ/T5Mpn5qSL3FShUyZjj70w/e71mk2CNbrOWG2Ar5k6NOO3rxiDTJ8qm4nUOWlbNo0K
 WCyamHI7DxULVi3xGhlQLkLKy79y87RwKxHx5v9k+mRJGjFysZhKd8ZeV22k1gXiSlloPq
 xZatgk3y+NjGnNO51qZpTLTK7muttRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717748023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cwiIHLPVz8oDjUCOekd2wDyzb9V8/tcc2T9FC5Bllg=;
 b=Y14WgQ89Z7QUSsn6rQhNOAMQFxyPZePx6I5FNG2bJzoBodPE98u6kh6qiU460+CyY824O7
 3LC4rZuJbbJq0EBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4BF213A42;
 Fri,  7 Jun 2024 08:13:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6GZEJjfBYmbkBwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Jun 2024 08:13:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Jun 2024 10:13:14 +0200
MIME-Version: 1.0
Message-Id: <20240607-shutdown-v2-1-a09ce3290ee1@suse.com>
References: <20240607-shutdown-v2-0-a09ce3290ee1@suse.com>
In-Reply-To: <20240607-shutdown-v2-0-a09ce3290ee1@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4751;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=Ssqn1oi95YeMZQwDrZh87r3tu11nzY1yvwopB3PJkgE=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmYsE3QliTCUstIpSUCKxMSSiIhy3W9lPUA9zvP
 Z9WFC5LDY+JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmLBNwAKCRDLzBqyILPm
 RtzkDACsKhu0wnJyZMSwX9YPwXZTgwiB2hcAL2mdQ+ZzswdaeHRt8BiRSBRxV26DyIUKlnScZ5b
 NINTy7jwj0+qBS21jH2PwWKeBJhn5DtXH90LHFljRPN9tqBUVhEOi9YrhqN73l0Cwz2ZIqiU8Xk
 7U7L9bpunf+i/Wi/z3fRfH6W0M0EiW3SmpW26Cquhx58rIIEctEtwGe3vchtCTDqSWSPU37+8fN
 A65EmnmH/LPB8zVrkjyxqzXIWZv0H8AYLvcLscKZpKxl1/h40hTXbZh8UqRpdm6ELrEGi3ChCff
 KqSbRXS1e6iKjyRqtvNJgiJIXD9nsf5GP0U+KiH8crl05rk5v1mmEnTMUjbHHrGdK3lfJaFHAM8
 QljvbjDWkb5pgrn9yAljH1OSXSCkcM1shQqIOKfEA22k0BYEat1o1H1Ii9CBVqKDCsRnIvJ6Rpl
 nIVDRlYP1taeUnMM1+937MBvUvT3AzL5tcKuNVHoZBP6na9IIcMc9MhUHuhtN+FEYZ9vY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] Add shutdown01 test
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

This test verifies the following shutdown() functionalities:

- SHUT_RD should enable send() ops but disable recv() ops
- SHUT_WR should enable recv() ops but disable send() ops
- SHUT_RDWR should disable both recv() and send() ops

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |   2 +
 testcases/kernel/syscalls/shutdown/.gitignore   |   1 +
 testcases/kernel/syscalls/shutdown/Makefile     |   7 ++
 testcases/kernel/syscalls/shutdown/shutdown01.c | 121 ++++++++++++++++++++++++
 4 files changed, 131 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index cf06ee563..dc396415e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1465,6 +1465,8 @@ shmget04 shmget04
 shmget05 shmget05
 shmget06 shmget06
 
+shutdown01 shutdown01
+
 sigaction01 sigaction01
 sigaction02 sigaction02
 
diff --git a/testcases/kernel/syscalls/shutdown/.gitignore b/testcases/kernel/syscalls/shutdown/.gitignore
new file mode 100644
index 000000000..2df24d1ab
--- /dev/null
+++ b/testcases/kernel/syscalls/shutdown/.gitignore
@@ -0,0 +1 @@
+shutdown01
diff --git a/testcases/kernel/syscalls/shutdown/Makefile b/testcases/kernel/syscalls/shutdown/Makefile
new file mode 100644
index 000000000..8cf1b9024
--- /dev/null
+++ b/testcases/kernel/syscalls/shutdown/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/shutdown/shutdown01.c b/testcases/kernel/syscalls/shutdown/shutdown01.c
new file mode 100644
index 000000000..ba3853d9c
--- /dev/null
+++ b/testcases/kernel/syscalls/shutdown/shutdown01.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies the following shutdown() functionalities:
+ *
+ * - SHUT_RD should enable send() ops but disable recv() ops
+ * - SHUT_WR should enable recv() ops but disable send() ops
+ * - SHUT_RDWR should disable both recv() and send() ops
+ */
+
+#include "tst_test.h"
+#include "tst_safe_net.h"
+
+#define MSGSIZE 4
+#define SOCKETFILE "socket"
+
+static struct tcase {
+	int shutdown_op;
+	int recv_flag;
+	int recv_err;
+	int send_flag;
+	int send_err;
+	char *flag_str;
+} tcases[] = {
+	{SHUT_RD, 0, 0, 0, 0, "SHUT_RD"},
+	{SHUT_WR, MSG_DONTWAIT, EWOULDBLOCK, MSG_NOSIGNAL, EPIPE, "SHUT_WR"},
+	{SHUT_RDWR, 0, 0, MSG_NOSIGNAL, EPIPE, "SHUT_RDWR"}
+};
+
+static struct sockaddr_un *sock_addr;
+
+static void run_server(void)
+{
+	int server_sock;
+
+	server_sock = SAFE_SOCKET(sock_addr->sun_family, SOCK_STREAM, 0);
+
+	SAFE_BIND(server_sock,
+		(struct sockaddr *)sock_addr,
+		sizeof(struct sockaddr_un));
+	SAFE_LISTEN(server_sock, 10);
+
+	tst_res(TINFO, "Running server on socket file");
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	SAFE_CLOSE(server_sock);
+	SAFE_UNLINK(SOCKETFILE);
+}
+
+static int start_test(void)
+{
+	int client_sock;
+
+	if (!SAFE_FORK()) {
+		run_server();
+		_exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+
+	tst_res(TINFO, "Connecting to the server");
+
+	client_sock = SAFE_SOCKET(sock_addr->sun_family, SOCK_STREAM, 0);
+	SAFE_CONNECT(client_sock,
+		(struct sockaddr *)sock_addr,
+		sizeof(struct sockaddr_un));
+
+	return client_sock;
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int client_sock;
+	char buff[MSGSIZE] = {0};
+
+	client_sock = start_test();
+
+	tst_res(TINFO, "Testing %s flag", tc->flag_str);
+
+	TST_EXP_PASS(shutdown(client_sock, tc->shutdown_op));
+
+	if (!tc->recv_err)
+		SAFE_RECV(0, client_sock, buff, MSGSIZE, tc->recv_flag);
+	else
+		TST_EXP_FAIL(recv(client_sock, buff, MSGSIZE, tc->recv_flag), tc->recv_err);
+
+	if (!tc->send_err)
+		SAFE_SEND(MSGSIZE, client_sock, buff, MSGSIZE, tc->send_flag);
+	else
+		TST_EXP_FAIL(send(client_sock, buff, MSGSIZE, tc->send_flag), tc->send_err);
+
+	SAFE_CLOSE(client_sock);
+	TST_CHECKPOINT_WAKE(0);
+
+}
+
+static void setup(void)
+{
+	sock_addr->sun_family = AF_UNIX;
+	memcpy(sock_addr->sun_path, SOCKETFILE, sizeof(SOCKETFILE));
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&sock_addr, .size = sizeof(struct sockaddr_un)},
+		{}
+	}
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
