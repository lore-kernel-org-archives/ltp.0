Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AEDCE8D72
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 10:24:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FA163C2F83
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 12:24:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBA833C2F63
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:23:20 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9BCC61A001DC
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:23:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 041323386F
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726741398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RuLRbZn2L1KkSntnycnISoY+Hh6WL+MYnOnQ+niqFok=;
 b=fgZo+40hqH16516C/nFlTVAX6m/6gZtgNiZJzcRwhdaki0jaqE7QgOd0xw6hc/EClXDnPc
 VQS4Khbt1ymPlXjEqRJ7A1A6wLWfCVzlASfdPPBfs6rb350DcWSc/5wuX6j+VGJz1rf7FO
 SnrfOyiPADZujzQ3+9fbrPT3/V6Gic0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726741398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RuLRbZn2L1KkSntnycnISoY+Hh6WL+MYnOnQ+niqFok=;
 b=wldFnWEbQ5qhGdZYu6TGKGNbS3hrpeB3p/PQc1UfI+HXC3oxmro/YNc/a4FQQA6a6vMPAF
 egz8EH+qRx3pXiBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fgZo+40h;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wldFnWEb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726741398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RuLRbZn2L1KkSntnycnISoY+Hh6WL+MYnOnQ+niqFok=;
 b=fgZo+40hqH16516C/nFlTVAX6m/6gZtgNiZJzcRwhdaki0jaqE7QgOd0xw6hc/EClXDnPc
 VQS4Khbt1ymPlXjEqRJ7A1A6wLWfCVzlASfdPPBfs6rb350DcWSc/5wuX6j+VGJz1rf7FO
 SnrfOyiPADZujzQ3+9fbrPT3/V6Gic0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726741398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RuLRbZn2L1KkSntnycnISoY+Hh6WL+MYnOnQ+niqFok=;
 b=wldFnWEbQ5qhGdZYu6TGKGNbS3hrpeB3p/PQc1UfI+HXC3oxmro/YNc/a4FQQA6a6vMPAF
 egz8EH+qRx3pXiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E507F13AAA
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qIeANpX762ZkBAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 19 Sep 2024 12:23:10 +0200
MIME-Version: 1.0
Message-Id: <20240919-landlock_network-v1-4-9c997f03bd0a@suse.com>
References: <20240919-landlock_network-v1-0-9c997f03bd0a@suse.com>
In-Reply-To: <20240919-landlock_network-v1-0-9c997f03bd0a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726741397; l=10470;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=dI6GjRvtrEobo3ARlulect4g8l1Q0313rxHDaOnnj9I=;
 b=AH8BbjEO/KLm/8L/kMPFskJeQOTjGg8UXZJ+RjZ2izSY+0y312exBn42J4ff54yPWS/oM3jgI
 15cTEW92KVaAU09uvfRQrCKFVi59IfvagsjW1NCEiua9nW2Gi4hpkAi
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 041323386F
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] Add landlock08 test
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
 include/lapi/capability.h                          |   4 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/landlock/.gitignore      |   1 +
 testcases/kernel/syscalls/landlock/landlock08.c    | 199 +++++++++++++++++++++
 .../kernel/syscalls/landlock/landlock_common.h     |  93 +++++++++-
 5 files changed, 297 insertions(+), 1 deletion(-)

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 0f317d6d7..14d2d3c12 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -20,6 +20,10 @@
 # endif
 #endif
 
+#ifndef CAP_NET_BIND_SERVICE
+# define CAP_NET_BIND_SERVICE 10
+#endif
+
 #ifndef CAP_NET_RAW
 # define CAP_NET_RAW          13
 #endif
diff --git a/runtest/syscalls b/runtest/syscalls
index 02e721df9..e1e9765c7 100644
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
index db11bff2f..fc7317394 100644
--- a/testcases/kernel/syscalls/landlock/.gitignore
+++ b/testcases/kernel/syscalls/landlock/.gitignore
@@ -6,3 +6,4 @@ landlock04
 landlock05
 landlock06
 landlock07
+landlock08
diff --git a/testcases/kernel/syscalls/landlock/landlock08.c b/testcases/kernel/syscalls/landlock/landlock08.c
new file mode 100644
index 000000000..c886971dc
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock08.c
@@ -0,0 +1,199 @@
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
+static struct tst_landlock_ruleset_attr *ruleset_attr;
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
+		ruleset_attr->data.handled_access_net =
+			LANDLOCK_ACCESS_NET_BIND_TCP;
+
+		test_bind(addr_family, ADDRESS_PORT, 0);
+
+		tst_res(TINFO, "Enable bind() access only for port %u",
+			ADDRESS_PORT);
+
+		apply_landlock_net_layer(ruleset_attr, net_port_attr,
+			ADDRESS_PORT, LANDLOCK_ACCESS_NET_BIND_TCP);
+
+		test_bind(addr_family, ADDRESS_PORT, 0);
+		test_bind(addr_family, ADDRESS_PORT + 0x80, EACCES);
+
+		exit(0);
+	}
+
+	/* verify connect() syscall accessibility */
+	if (!SAFE_FORK()) {
+		ruleset_attr->data.handled_access_net =
+			LANDLOCK_ACCESS_NET_CONNECT_TCP;
+
+		test_connect(addr_family, *server_port, 0);
+
+		tst_res(TINFO, "Enable connect() access only on port %u",
+			*server_port);
+
+		apply_landlock_net_layer(ruleset_attr, net_port_attr,
+			*server_port, LANDLOCK_ACCESS_NET_CONNECT_TCP);
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
+	verify_landlock_is_enabled();
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
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr)},
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
diff --git a/testcases/kernel/syscalls/landlock/landlock_common.h b/testcases/kernel/syscalls/landlock/landlock_common.h
index a955340bf..db500deb8 100644
--- a/testcases/kernel/syscalls/landlock/landlock_common.h
+++ b/testcases/kernel/syscalls/landlock/landlock_common.h
@@ -11,6 +11,16 @@
 #include "lapi/fcntl.h"
 #include "lapi/landlock.h"
 
+#define IPV4_ADDRESS "127.0.0.1"
+#define IPV6_ADDRESS "::1"
+
+struct socket_data {
+	struct sockaddr_in addr_ipv4;
+	struct sockaddr_in6 addr_ipv6;
+	size_t address_size;
+	int fd;
+};
+
 static inline int verify_landlock_is_enabled(void)
 {
 	int abi;
@@ -93,7 +103,7 @@ static inline void apply_landlock_fs_layer(
 static inline void apply_landlock_net_layer(
 	struct tst_landlock_ruleset_attr *ruleset_attr,
 	struct landlock_net_port_attr *net_port_attr,
-	const uint64_t port,
+	const in_port_t port,
 	const uint64_t access)
 {
 	int ruleset_fd;
@@ -107,4 +117,85 @@ static inline void apply_landlock_net_layer(
 	SAFE_CLOSE(ruleset_fd);
 }
 
+static inline in_port_t getsocket_port(struct socket_data *socket,
+	const int addr_family)
+{
+	struct sockaddr_in addr_ipv4;
+	struct sockaddr_in6 addr_ipv6;
+	socklen_t len;
+	in_port_t port = 0;
+
+	switch (addr_family) {
+	case AF_INET:
+		len = sizeof(addr_ipv4);
+		memset(&addr_ipv4, 0, len);
+
+		SAFE_GETSOCKNAME(socket->fd, (struct sockaddr *)&addr_ipv4, &len);
+		port = ntohs(addr_ipv4.sin_port);
+		break;
+	case AF_INET6:
+		len = sizeof(addr_ipv6);
+		memset(&addr_ipv6, 0, len);
+
+		SAFE_GETSOCKNAME(socket->fd, (struct sockaddr *)&addr_ipv6, &len);
+		port = ntohs(addr_ipv6.sin6_port);
+		break;
+	default:
+		tst_brk(TBROK, "Unsupported protocol");
+		break;
+	};
+
+	return port;
+}
+
+static inline void create_socket(struct socket_data *socket,
+	const int addr_family, const in_port_t port)
+{
+	memset(socket, 0, sizeof(struct socket_data));
+
+	switch (addr_family) {
+	case AF_INET:
+		if (!port) {
+			tst_init_sockaddr_inet_bin(&socket->addr_ipv4,
+				INADDR_ANY, 0);
+		} else {
+			tst_init_sockaddr_inet(&socket->addr_ipv4,
+				IPV4_ADDRESS, port);
+		}
+
+		socket->address_size = sizeof(struct sockaddr_in);
+		break;
+	case AF_INET6:
+		if (!port) {
+			tst_init_sockaddr_inet6_bin(&socket->addr_ipv6,
+				&in6addr_any, 0);
+		} else {
+			tst_init_sockaddr_inet6(&socket->addr_ipv6,
+				IPV6_ADDRESS, port);
+		}
+
+		socket->address_size = sizeof(struct sockaddr_in6);
+		break;
+	default:
+		tst_brk(TBROK, "Unsupported protocol");
+		return;
+	};
+
+	socket->fd = SAFE_SOCKET(addr_family, SOCK_STREAM | SOCK_CLOEXEC, 0);
+}
+
+static inline void getsocket_addr(struct socket_data *socket,
+	const int addr_family, struct sockaddr **addr)
+{
+	switch (addr_family) {
+	case AF_INET:
+		*addr = (struct sockaddr *)&socket->addr_ipv4;
+		break;
+	case AF_INET6:
+		*addr = (struct sockaddr *)&socket->addr_ipv6;
+		break;
+	default:
+		break;
+	};
+}
 #endif /* LANDLOCK_COMMON_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
