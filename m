Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD52D1266E
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 09:35:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 116A03D1F1D
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 10:35:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6876C3D1BF4
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 10:34:32 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DB65C142AA6F
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 10:34:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5DBD121CB5
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 09:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730799269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rX+3FX6p2L5EzNTS6LcQE2s063+JhhP78mdN+sxQdw=;
 b=r33KN/RUjJYVecREvYxC9+Sy9t5maVs6hsE+e9YQmvMzczI8iKmy1DlTJia99KKgWFR14+
 iHbSgY5X98JhxVJ8w5AqpWJS2L5FhLwGIA4ApeakUtXaqJ2R4+Jw1i/rcEncAIZ4bg8UXM
 ffud+6eEVqj7zIehqfnRZe3bJDdEZAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730799269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rX+3FX6p2L5EzNTS6LcQE2s063+JhhP78mdN+sxQdw=;
 b=eDPC1IlSMeyOUIJSvJenOdClmslWK4BpRN0v54YBknlz+SNLnjtNNj0O69Q6QgCzCAW6c/
 8ro1AkMaGtQBVwCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="r33KN/RU";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eDPC1IlS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730799269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rX+3FX6p2L5EzNTS6LcQE2s063+JhhP78mdN+sxQdw=;
 b=r33KN/RUjJYVecREvYxC9+Sy9t5maVs6hsE+e9YQmvMzczI8iKmy1DlTJia99KKgWFR14+
 iHbSgY5X98JhxVJ8w5AqpWJS2L5FhLwGIA4ApeakUtXaqJ2R4+Jw1i/rcEncAIZ4bg8UXM
 ffud+6eEVqj7zIehqfnRZe3bJDdEZAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730799269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rX+3FX6p2L5EzNTS6LcQE2s063+JhhP78mdN+sxQdw=;
 b=eDPC1IlSMeyOUIJSvJenOdClmslWK4BpRN0v54YBknlz+SNLnjtNNj0O69Q6QgCzCAW6c/
 8ro1AkMaGtQBVwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 260731394A
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 09:34:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qETeAqXmKWeAPwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 09:34:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 05 Nov 2024 10:34:27 +0100
MIME-Version: 1.0
Message-Id: <20241105-landlock_network-v2-3-d58791487919@suse.com>
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
In-Reply-To: <20241105-landlock_network-v2-0-d58791487919@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730799267; l=7307;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=APGj9KTDQlhJDDDUwl/LYRNryenyerCOFoNPbAoi62E=;
 b=AoBGhUg2MydKfgl+OP/11uvf6Awsqf5jdzlz0KHcZNbFnUD0uwXFbJZz9xnOtbNXrr5aixO/j
 kTvGFNtJT5BCW02b3NZscc0Cewnlfk7hpR0wtvUNo2OSy+/v8VBQRzC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 5DBD121CB5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] Add landlock08 test
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

Verify the landlock support for bind()/connect() syscalls in IPV4
and IPV6 protocols. In particular, check that bind() is assigning
the address only on the TCP port enforced by
LANDLOCK_ACCESS_NET_BIND_TCP and check that connect() is connecting
only to a specific TCP port enforced by
LANDLOCK_ACCESS_NET_CONNECT_TCP.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/landlock/.gitignore   |   1 +
 testcases/kernel/syscalls/landlock/landlock08.c | 208 ++++++++++++++++++++++++
 3 files changed, 210 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 7dc308fa88486b9ace80ef0d906201dd407dcf3e..5fd62617df1a116b1d94c57ff30f74693320a2ab 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -708,6 +708,7 @@ landlock04 landlock04
 landlock05 landlock05
 landlock06 landlock06
 landlock07 landlock07
+landlock08 landlock08
 
 lchown01 lchown01
 lchown01_16 lchown01_16
diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
index db11bff2fe245d462e5b7e5691a9eb2ee2305aab..fc7317394948c4ac20cd14c3cd7ba7a47282b2bf 100644
--- a/testcases/kernel/syscalls/landlock/.gitignore
+++ b/testcases/kernel/syscalls/landlock/.gitignore
@@ -6,3 +6,4 @@ landlock04
 landlock05
 landlock06
 landlock07
+landlock08
diff --git a/testcases/kernel/syscalls/landlock/landlock08.c b/testcases/kernel/syscalls/landlock/landlock08.c
new file mode 100644
index 0000000000000000000000000000000000000000..7bc3f0f8d81730659a66c268fdad1981ae90aea6
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock08.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify the landlock support for bind()/connect() syscalls in IPV4 and IPV6
+ * protocols. In particular, check that bind() is assigning the address only on
+ * the TCP port enforced by LANDLOCK_ACCESS_NET_BIND_TCP and check that
+ * connect() is connecting only to a specific TCP port enforced by
+ * LANDLOCK_ACCESS_NET_CONNECT_TCP.
+ *
+ * [Algorithm]
+ *
+ * Repeat the following procedure for IPV4 and IPV6:
+ *
+ * - create a socket on PORT1, bind() it and check if it passes
+ * - enforce the current sandbox with LANDLOCK_ACCESS_NET_BIND_TCP on PORT1
+ * - create a socket on PORT1, bind() it and check if it passes
+ * - create a socket on PORT2, bind() it and check if it fails
+ *
+ * - create a server listening on PORT1
+ * - create a socket on PORT1, connect() to it and check if it passes
+ * - enforce the current sandbox with LANDLOCK_ACCESS_NET_CONNECT_TCP on PORT1
+ * - create a socket on PORT1, connect() to it and check if it passes
+ * - create a socket on PORT2, connect() to it and check if it fails
+ */
+
+#include "landlock_common.h"
+
+#define ADDRESS_PORT 0x7c90
+
+static int variants[] = {
+	AF_INET,
+	AF_INET6,
+};
+
+static struct tst_landlock_ruleset_attr_abi4 *ruleset_attr;
+static struct landlock_net_port_attr *net_port_attr;
+static in_port_t *server_port;
+
+static void create_server(const int addr_family)
+{
+	struct socket_data socket;
+	struct sockaddr *addr = NULL;
+
+	create_socket(&socket, addr_family, 0);
+	getsocket_addr(&socket, addr_family, &addr);
+
+	SAFE_BIND(socket.fd, addr, socket.address_size);
+	SAFE_LISTEN(socket.fd, 1);
+
+	*server_port = getsocket_port(&socket, addr_family);
+
+	tst_res(TDEBUG, "Server listening on port %u", *server_port);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	SAFE_CLOSE(socket.fd);
+}
+
+static void test_bind(const int addr_family, const in_port_t port,
+	const int exp_err)
+{
+	struct socket_data socket;
+	struct sockaddr *addr = NULL;
+
+	create_socket(&socket, addr_family, port);
+	getsocket_addr(&socket, addr_family, &addr);
+
+	if (exp_err) {
+		TST_EXP_FAIL(
+			bind(socket.fd, addr, socket.address_size),
+			exp_err, "bind() access on port %u", port);
+	} else {
+		TST_EXP_PASS(
+			bind(socket.fd, addr, socket.address_size),
+			"bind() access on port %u", port);
+	}
+
+	SAFE_CLOSE(socket.fd);
+}
+
+static void test_connect(const int addr_family, const in_port_t port,
+	const int exp_err)
+{
+	struct socket_data socket;
+	struct sockaddr *addr = NULL;
+
+	create_socket(&socket, addr_family, port);
+	getsocket_addr(&socket, addr_family, &addr);
+
+	if (exp_err) {
+		TST_EXP_FAIL(
+			connect(socket.fd, addr, socket.address_size),
+			exp_err, "connect() on port %u", port);
+	} else {
+		TST_EXP_PASS(
+			connect(socket.fd, addr, socket.address_size),
+			"connect() on port %u", port);
+	}
+
+	SAFE_CLOSE(socket.fd);
+}
+
+static void run(void)
+{
+	int addr_family = variants[tst_variant];
+
+	tst_res(TINFO, "Using %s protocol",
+		addr_family == AF_INET ? "IPV4" : "IPV6");
+
+	if (!SAFE_FORK()) {
+		create_server(addr_family);
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+
+	/* verify bind() syscall accessibility */
+	if (!SAFE_FORK()) {
+		ruleset_attr->handled_access_net =
+			LANDLOCK_ACCESS_NET_BIND_TCP;
+
+		test_bind(addr_family, ADDRESS_PORT, 0);
+
+		tst_res(TINFO, "Enable bind() access only for port %u",
+			ADDRESS_PORT);
+
+		apply_landlock_net_layer(
+			ruleset_attr,
+			sizeof(struct tst_landlock_ruleset_attr_abi4),
+			net_port_attr,
+			ADDRESS_PORT,
+			LANDLOCK_ACCESS_NET_BIND_TCP);
+
+		test_bind(addr_family, ADDRESS_PORT, 0);
+		test_bind(addr_family, ADDRESS_PORT + 0x80, EACCES);
+
+		exit(0);
+	}
+
+	/* verify connect() syscall accessibility */
+	if (!SAFE_FORK()) {
+		ruleset_attr->handled_access_net =
+			LANDLOCK_ACCESS_NET_CONNECT_TCP;
+
+		test_connect(addr_family, *server_port, 0);
+
+		tst_res(TINFO, "Enable connect() access only on port %u",
+			*server_port);
+
+		apply_landlock_net_layer(
+			ruleset_attr,
+			sizeof(struct tst_landlock_ruleset_attr_abi4),
+			net_port_attr,
+			*server_port,
+			LANDLOCK_ACCESS_NET_CONNECT_TCP);
+
+		test_connect(addr_family, *server_port, 0);
+		test_connect(addr_family, *server_port + 0x80, EACCES);
+
+		TST_CHECKPOINT_WAKE(0);
+
+		exit(0);
+	}
+}
+
+static void setup(void)
+{
+	if (verify_landlock_is_enabled() < 4)
+		tst_brk(TCONF, "Landlock network is not supported");
+
+	server_port = SAFE_MMAP(NULL, sizeof(in_port_t), PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (server_port)
+		SAFE_MUNMAP(server_port, sizeof(in_port_t));
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.forks_child = 1,
+	.test_variants = ARRAY_SIZE(variants),
+	.bufs = (struct tst_buffers[]) {
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr_abi4)},
+		{&net_port_attr, .size = sizeof(struct landlock_net_port_attr)},
+		{},
+	},
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
+		TST_CAP(TST_CAP_REQ, CAP_NET_BIND_SERVICE),
+		{}
+	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_INET=y",
+		NULL
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
