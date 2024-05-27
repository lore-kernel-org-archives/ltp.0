Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069F6C25B79
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 06:31:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17AAD3D02FD
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 08:31:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC9BF3CF26C
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:30:48 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E6D5D1A004AB
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:30:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 660801FB62;
 Mon, 27 May 2024 06:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716791446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8B4GFTOLGuW4YPysIQPH4rpasjHILqmAKehlWUAtZI=;
 b=eCYf8uFdNRZMu1OoIyC0KFPewgS0511Cku7hj1ZiA2Tk7WkXLzRUTeP1+MyygeNt1hxIcJ
 SokLTxH6Hfc0PJEJ4phC2grTXcz1zx4FbOHOOIOnMds88QNbk/ftOJpb39LmrQ9IyGvRHb
 CVAYdRbNDKksIky9LPJe9Hj/MgOXHKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716791446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8B4GFTOLGuW4YPysIQPH4rpasjHILqmAKehlWUAtZI=;
 b=DLYSzuw6TanLwmq0L7Bz/tnYQ9XLCAHrAdfQwM1oo5wj9xHHuUhQcvtKXcBeWjOMMeN5Y0
 ytLnukF2fICPLFCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716791446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8B4GFTOLGuW4YPysIQPH4rpasjHILqmAKehlWUAtZI=;
 b=eCYf8uFdNRZMu1OoIyC0KFPewgS0511Cku7hj1ZiA2Tk7WkXLzRUTeP1+MyygeNt1hxIcJ
 SokLTxH6Hfc0PJEJ4phC2grTXcz1zx4FbOHOOIOnMds88QNbk/ftOJpb39LmrQ9IyGvRHb
 CVAYdRbNDKksIky9LPJe9Hj/MgOXHKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716791446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8B4GFTOLGuW4YPysIQPH4rpasjHILqmAKehlWUAtZI=;
 b=DLYSzuw6TanLwmq0L7Bz/tnYQ9XLCAHrAdfQwM1oo5wj9xHHuUhQcvtKXcBeWjOMMeN5Y0
 ytLnukF2fICPLFCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3675813A6C;
 Mon, 27 May 2024 06:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4FxjCpYoVGbMUgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 27 May 2024 06:30:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 27 May 2024 08:30:16 +0200
MIME-Version: 1.0
Message-Id: <20240527-shutdown-v1-1-1feffca5e3df@suse.com>
References: <20240527-shutdown-v1-0-1feffca5e3df@suse.com>
In-Reply-To: <20240527-shutdown-v1-0-1feffca5e3df@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5055;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=WDNug0ux2WnzwjRsFNKHA7NyBFNUO93eLtWf/EhZ6oo=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmVCiVDHcxAQZUZ1Xwh8xN0QixzPtueTLIIFVUl
 e+Jee+ZgRWJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZlQolQAKCRDLzBqyILPm
 RlNVDACvKJag+KXw8WmNCjez4lLIzUoIPcXufznPrTHDP9VcmSj0GE9ugNOnkyDGdkFB+8AyChg
 PF81lmw8+RrkoareS5oo/5oTzrhQCz91eF3Cr5A1tH7teFPgJVjtL3T3ibusUb4w7kaH0G3Jeic
 riayJGB6mR9in2psXBJmxzxPFWlT9Jc51w3PLp/BN4ZgWMtYpm4Q/FheBH7JcHiURo+bZkMyk6i
 MhKh3J2X3uIhounsPkQ2rc1PPGrQqkzs7kRYsYmGAHRJtfX6w9P6FEVqwF3tpcPy7khpYTteJT8
 R62rS+Zt2+wU+6F/tM7Uf8pC6fpnDPLvyFOKgz7fi3Ku9KUhmjNFEePubz3i0cX3JkQ4aKIFYa7
 Q0eh/w0xdL1PiMJT0ehzwTtT20BStr8z+2wkUR9ozuOMn/qVGrNniLZO8EFMvEqY9a4NHo9SeMI
 CIIMCbjb+EHrZ3dsBFNtonZsYT295dLi01zEYkSYEwBRJ7CtKhAD/O4/PPlzPmN37lbDo=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Add shutdown01 test
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
* SHUT_RD should enable send() ops but disable recv() ops
* SHUT_WR should enable recv() ops but disable send() ops
* SHUT_RDWR should disable both recv() and send() ops

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |   2 +
 testcases/kernel/syscalls/shutdown/.gitignore   |   1 +
 testcases/kernel/syscalls/shutdown/Makefile     |   7 ++
 testcases/kernel/syscalls/shutdown/shutdown01.c | 136 ++++++++++++++++++++++++
 4 files changed, 146 insertions(+)

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
index 000000000..b68b14ae8
--- /dev/null
+++ b/testcases/kernel/syscalls/shutdown/shutdown01.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies the following shutdown() functionalities:
+ * * SHUT_RD should enable send() ops but disable recv() ops
+ * * SHUT_WR should enable recv() ops but disable send() ops
+ * * SHUT_RDWR should disable both recv() and send() ops
+ */
+
+#include "tst_test.h"
+
+#define MSGSIZE 4
+#define SOCKETFILE "socket"
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
+static void test_shutdown_recv(void)
+{
+	int client_sock;
+	char buff[MSGSIZE] = {0};
+
+	client_sock = start_test();
+
+	tst_res(TINFO, "Testing SHUT_RD flag");
+
+	TST_EXP_PASS(shutdown(client_sock, SHUT_RD));
+	TST_EXP_EQ_LI(recv(client_sock, buff, MSGSIZE, 0), 0);
+	TST_EXP_EQ_LI(send(client_sock, buff, MSGSIZE, 0), MSGSIZE);
+
+	SAFE_CLOSE(client_sock);
+	TST_CHECKPOINT_WAKE(0);
+}
+
+static void test_shutdown_send(void)
+{
+	int client_sock;
+	char buff[MSGSIZE] = {0};
+
+	client_sock = start_test();
+
+	tst_res(TINFO, "Testing SHUT_WR flag");
+
+	TST_EXP_PASS(shutdown(client_sock, SHUT_WR));
+	TST_EXP_FAIL(recv(client_sock, buff, MSGSIZE, MSG_DONTWAIT), EWOULDBLOCK);
+	TST_EXP_FAIL(send(client_sock, buff, MSGSIZE, MSG_NOSIGNAL), EPIPE);
+
+	SAFE_CLOSE(client_sock);
+	TST_CHECKPOINT_WAKE(0);
+}
+
+static void test_shutdown_both(void)
+{
+	int client_sock;
+	char buff[MSGSIZE] = {0};
+
+	client_sock = start_test();
+
+	tst_res(TINFO, "Testing SHUT_RDWR flag");
+
+	TST_EXP_PASS(shutdown(client_sock, SHUT_RDWR));
+	TST_EXP_EQ_LI(recv(client_sock, buff, MSGSIZE, 0), 0);
+	TST_EXP_FAIL(send(client_sock, buff, MSGSIZE, MSG_NOSIGNAL), EPIPE);
+
+	SAFE_CLOSE(client_sock);
+	TST_CHECKPOINT_WAKE(0);
+}
+
+static void run(void)
+{
+	test_shutdown_recv();
+	test_shutdown_send();
+	test_shutdown_both();
+}
+
+static void setup(void)
+{
+	sock_addr->sun_family = AF_UNIX;
+	memcpy(sock_addr->sun_path, SOCKETFILE, sizeof(SOCKETFILE));
+}
+
+static struct tst_test test = {
+	.test_all = run,
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
