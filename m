Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E69C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 14:16:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CCB43E733D
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 16:16:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F6453E0DA4
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 16:16:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5F30D600435
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 16:16:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FD1D75896;
 Tue, 30 Jun 2026 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782828968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=irx5exiARD/Ceq1Ro24+v/hLNUZa8xux71ywt2Oh0qg=;
 b=yX8PS1b7x1WLJ9eN3RAQlrYlJ/FzyVnXFeDEil0dIRqmaN1+DRfQMLUBvlWB2ubb1s4PQ3
 N6XQiE5JjDyw+a33IikQAI+jOpsr7QVgebGw7p3IFb7rzxeTTkuRc11deDAKXo58M1+sN3
 QA6R30/LI8WyOJR313II6rZlPiOji9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782828968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=irx5exiARD/Ceq1Ro24+v/hLNUZa8xux71ywt2Oh0qg=;
 b=g26ik5dWgT9FlGC5SEGOURBwj/k4cGyA8CRDo45Tzbxpt+CtPHwuWGoGDOzgTw+nnQgk8U
 yUcZN92dSPVJvZBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yX8PS1b7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g26ik5dW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782828968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=irx5exiARD/Ceq1Ro24+v/hLNUZa8xux71ywt2Oh0qg=;
 b=yX8PS1b7x1WLJ9eN3RAQlrYlJ/FzyVnXFeDEil0dIRqmaN1+DRfQMLUBvlWB2ubb1s4PQ3
 N6XQiE5JjDyw+a33IikQAI+jOpsr7QVgebGw7p3IFb7rzxeTTkuRc11deDAKXo58M1+sN3
 QA6R30/LI8WyOJR313II6rZlPiOji9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782828968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=irx5exiARD/Ceq1Ro24+v/hLNUZa8xux71ywt2Oh0qg=;
 b=g26ik5dWgT9FlGC5SEGOURBwj/k4cGyA8CRDo45Tzbxpt+CtPHwuWGoGDOzgTw+nnQgk8U
 yUcZN92dSPVJvZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55CC9779A8;
 Tue, 30 Jun 2026 14:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V49kE6jPQ2qhcgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 30 Jun 2026 14:16:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 30 Jun 2026 16:16:08 +0200
MIME-Version: 1.0
Message-Id: <20260630-landlock_udp-v1-1-21a740209f70@suse.com>
X-B4-Tracking: v=1; b=H4sIAKfPQ2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM2MD3ZzEvJSc/OTs+NKUAl2jlCRj0ySTFBPjZCMloJaCotS0zAqwcdG
 xtbUAruQ8gF4AAAA=
X-Change-ID: 20260630-landlock_udp-2db35b4d43c2
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782828968; l=10481;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=q46227k40XaRHeR7a9hgvKxsu7Ur++iJg5hKd11eOk4=;
 b=57VxEMTuGzQk3esEPJMyQbfhohEmgQSGA+dJ5J6+9fRP1CKzPNYYYn4a1CrYXXEJrSV/QGAU/
 mi7ZF5nxWrCBbYsBzYCuwvkTTQloe9UbZwBFBwc0h1mQmVDRCyf7vpF
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6FD1D75896
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] landlock08: add UDP bind/connect test variants
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

Extend the network test to cover the LANDLOCK_ACCESS_NET_BIND_UDP and
LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP access rights introduced with
Landlock ABI v10, alongside the existing TCP rights.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/landlock.h                            |   8 ++
 testcases/kernel/syscalls/landlock/landlock08.c    | 128 ++++++++++++++-------
 .../kernel/syscalls/landlock/landlock_common.h     |   4 +-
 3 files changed, 95 insertions(+), 45 deletions(-)

diff --git a/include/lapi/landlock.h b/include/lapi/landlock.h
index e579500ec26cdc0a568620bc35386f3d2b68952e..54039b3404dd9d717630f0f560e055064acfbe91 100644
--- a/include/lapi/landlock.h
+++ b/include/lapi/landlock.h
@@ -129,6 +129,14 @@ struct landlock_net_port_attr {
 # define LANDLOCK_ACCESS_NET_CONNECT_TCP	(1ULL << 1)
 #endif
 
+#ifndef LANDLOCK_ACCESS_NET_BIND_UDP
+# define LANDLOCK_ACCESS_NET_BIND_UDP		(1ULL << 2)
+#endif
+
+#ifndef LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP
+# define LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP	(1ULL << 3)
+#endif
+
 #ifndef LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
 # define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
 #endif
diff --git a/testcases/kernel/syscalls/landlock/landlock08.c b/testcases/kernel/syscalls/landlock/landlock08.c
index 7e7d8470bf49662416f7c83a444876575b29fb16..2012937133658b1315924150db661bf6efb861a4 100644
--- a/testcases/kernel/syscalls/landlock/landlock08.c
+++ b/testcases/kernel/syscalls/landlock/landlock08.c
@@ -5,67 +5,103 @@
 
 /*\
  * Verify the landlock support for bind()/connect() syscalls in IPV4 and IPV6
- * protocols. In particular, check that bind() is assigning the address only on
- * the TCP port enforced by LANDLOCK_ACCESS_NET_BIND_TCP and check that
- * connect() is connecting only to a specific TCP port enforced by
- * LANDLOCK_ACCESS_NET_CONNECT_TCP.
+ * protocols, using both TCP and UDP. In particular, check that bind() is
+ * assigning the address only on the port enforced by
+ * LANDLOCK_ACCESS_NET_BIND_TCP / LANDLOCK_ACCESS_NET_BIND_UDP and check that
+ * connect() is connecting only to a specific port enforced by
+ * LANDLOCK_ACCESS_NET_CONNECT_TCP / LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP.
+ *
+ * TCP rules are available since Landlock ABI v4, while UDP rules are available
+ * since Landlock ABI v10.
  *
  * [Algorithm]
  *
- * Repeat the following procedure for IPV4 and IPV6:
+ * Repeat the following procedure for {TCP, UDP} x {IPV4, IPV6}:
  *
  * - create a socket on PORT1, bind() it and check if it passes
- * - enforce the current sandbox with LANDLOCK_ACCESS_NET_BIND_TCP on PORT1
+ * - enforce the current sandbox with the BIND access right on PORT1
  * - create a socket on PORT1, bind() it and check if it passes
  * - create a socket on PORT2, bind() it and check if it fails
  *
  * - create a server listening on PORT1
  * - create a socket on PORT1, connect() to it and check if it passes
- * - enforce the current sandbox with LANDLOCK_ACCESS_NET_CONNECT_TCP on PORT1
+ * - enforce the current sandbox with the CONNECT access right on PORT1
  * - create a socket on PORT1, connect() to it and check if it passes
  * - create a socket on PORT2, connect() to it and check if it fails
  */
 
 #include "landlock_common.h"
 
-static int variants[] = {
-	AF_INET,
-	AF_INET6,
+static struct tcase {
+	int family;
+	int type;
+	uint64_t bind_access;
+	uint64_t connect_access;
+	int min_abi;
+	const char *desc;
+} variants[] = {
+	{
+		AF_INET, SOCK_STREAM,
+		LANDLOCK_ACCESS_NET_BIND_TCP,
+		LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		4, "TCP/IPV4"
+	},
+	{
+		AF_INET6, SOCK_STREAM,
+		LANDLOCK_ACCESS_NET_BIND_TCP,
+		LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		4, "TCP/IPV6"
+	},
+	{
+		AF_INET, SOCK_DGRAM,
+		LANDLOCK_ACCESS_NET_BIND_UDP,
+		LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+		10, "UDP/IPV4"
+	},
+	{
+		AF_INET6, SOCK_DGRAM,
+		LANDLOCK_ACCESS_NET_BIND_UDP,
+		LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+		10, "UDP/IPV6"
+	},
 };
 
 static struct tst_landlock_ruleset_attr_abi4 *ruleset_attr;
 static struct landlock_net_port_attr *net_port_attr;
 static in_port_t *server_port;
 static int addr_port;
+static int landlock_abi;
 
-static void create_server(const int addr_family)
+static void create_server(const struct tcase *tc)
 {
 	struct socket_data socket;
 	struct sockaddr *addr = NULL;
 
-	create_socket(&socket, addr_family, 0);
-	getsocket_addr(&socket, addr_family, &addr);
+	create_socket(&socket, tc->family, 0, tc->type);
+	getsocket_addr(&socket, tc->family, &addr);
 
 	SAFE_BIND(socket.fd, addr, socket.address_size);
-	SAFE_LISTEN(socket.fd, 1);
 
-	*server_port = getsocket_port(&socket, addr_family);
+	if (tc->type == SOCK_STREAM)
+		SAFE_LISTEN(socket.fd, 1);
 
-	tst_res(TDEBUG, "Server listening on port %u", *server_port);
+	*server_port = getsocket_port(&socket, tc->family);
+
+	tst_res(TDEBUG, "Server bound on port %u", *server_port);
 
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	SAFE_CLOSE(socket.fd);
 }
 
-static void test_bind(const int addr_family, const in_port_t port,
+static void test_bind(const struct tcase *tc, const in_port_t port,
 	const int exp_err)
 {
 	struct socket_data socket;
 	struct sockaddr *addr = NULL;
 
-	create_socket(&socket, addr_family, port);
-	getsocket_addr(&socket, addr_family, &addr);
+	create_socket(&socket, tc->family, port, tc->type);
+	getsocket_addr(&socket, tc->family, &addr);
 
 	if (exp_err) {
 		TST_EXP_FAIL(
@@ -80,14 +116,14 @@ static void test_bind(const int addr_family, const in_port_t port,
 	SAFE_CLOSE(socket.fd);
 }
 
-static void test_connect(const int addr_family, const in_port_t port,
+static void test_connect(const struct tcase *tc, const in_port_t port,
 	const int exp_err)
 {
 	struct socket_data socket;
 	struct sockaddr *addr = NULL;
 
-	create_socket(&socket, addr_family, port);
-	getsocket_addr(&socket, addr_family, &addr);
+	create_socket(&socket, tc->family, port, tc->type);
+	getsocket_addr(&socket, tc->family, &addr);
 
 	if (exp_err) {
 		TST_EXP_FAIL(
@@ -102,13 +138,14 @@ static void test_connect(const int addr_family, const in_port_t port,
 	SAFE_CLOSE(socket.fd);
 }
 
-static int check_ipv6_support(void)
+static int check_family_support(const struct tcase *tc)
 {
 	int fd;
 
-	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	fd = socket(tc->family, tc->type, 0);
 	if (fd == -1 && errno == EAFNOSUPPORT) {
-		tst_res(TCONF, "IPv6 not supported in kernel");
+		tst_res(TCONF, "%s address family not supported in kernel",
+			tc->family == AF_INET ? "IPV4" : "IPV6");
 		return 0;
 	}
 	if (fd != -1)
@@ -118,15 +155,21 @@ static int check_ipv6_support(void)
 
 static void run(void)
 {
-	int addr_family = variants[tst_variant];
+	struct tcase *tc = &variants[tst_variant];
+
+	tst_res(TINFO, "Using %s protocol", tc->desc);
+
+	if (landlock_abi < tc->min_abi) {
+		tst_res(TCONF, "%s rules require Landlock ABI v%d",
+			tc->desc, tc->min_abi);
+		return;
+	}
 
-	tst_res(TINFO, "Using %s protocol",
-		addr_family == AF_INET ? "IPV4" : "IPV6");
-	if (addr_family == AF_INET6 && !check_ipv6_support())
+	if (!check_family_support(tc))
 		return;
 
 	if (!SAFE_FORK()) {
-		create_server(addr_family);
+		create_server(tc);
 		exit(0);
 	}
 
@@ -134,10 +177,9 @@ static void run(void)
 
 	/* verify bind() syscall accessibility */
 	if (!SAFE_FORK()) {
-		ruleset_attr->handled_access_net =
-			LANDLOCK_ACCESS_NET_BIND_TCP;
+		ruleset_attr->handled_access_net = tc->bind_access;
 
-		test_bind(addr_family, addr_port, 0);
+		test_bind(tc, addr_port, 0);
 
 		tst_res(TINFO, "Enable bind() access only for port %u",
 			addr_port);
@@ -147,20 +189,19 @@ static void run(void)
 			sizeof(struct tst_landlock_ruleset_attr_abi4),
 			net_port_attr,
 			addr_port,
-			LANDLOCK_ACCESS_NET_BIND_TCP);
+			tc->bind_access);
 
-		test_bind(addr_family, addr_port, 0);
-		test_bind(addr_family, addr_port + 0x80, EACCES);
+		test_bind(tc, addr_port, 0);
+		test_bind(tc, addr_port + 0x80, EACCES);
 
 		exit(0);
 	}
 
 	/* verify connect() syscall accessibility */
 	if (!SAFE_FORK()) {
-		ruleset_attr->handled_access_net =
-			LANDLOCK_ACCESS_NET_CONNECT_TCP;
+		ruleset_attr->handled_access_net = tc->connect_access;
 
-		test_connect(addr_family, *server_port, 0);
+		test_connect(tc, *server_port, 0);
 
 		tst_res(TINFO, "Enable connect() access only on port %u",
 			*server_port);
@@ -170,10 +211,10 @@ static void run(void)
 			sizeof(struct tst_landlock_ruleset_attr_abi4),
 			net_port_attr,
 			*server_port,
-			LANDLOCK_ACCESS_NET_CONNECT_TCP);
+			tc->connect_access);
 
-		test_connect(addr_family, *server_port, 0);
-		test_connect(addr_family, *server_port + 0x80, EACCES);
+		test_connect(tc, *server_port, 0);
+		test_connect(tc, *server_port + 0x80, EACCES);
 
 		TST_CHECKPOINT_WAKE(0);
 
@@ -183,7 +224,8 @@ static void run(void)
 
 static void setup(void)
 {
-	if (verify_landlock_is_enabled() < 4)
+	landlock_abi = verify_landlock_is_enabled();
+	if (landlock_abi < 4)
 		tst_brk(TCONF, "Landlock network is not supported");
 
 	addr_port = TST_GET_UNUSED_PORT(AF_INET, SOCK_STREAM);
diff --git a/testcases/kernel/syscalls/landlock/landlock_common.h b/testcases/kernel/syscalls/landlock/landlock_common.h
index 8857745d6f1c1c30fc914924b8d0da381b36059f..51e57477049003b7e65c13e64303479bfae41224 100644
--- a/testcases/kernel/syscalls/landlock/landlock_common.h
+++ b/testcases/kernel/syscalls/landlock/landlock_common.h
@@ -158,7 +158,7 @@ static inline in_port_t getsocket_port(struct socket_data *socket,
 }
 
 static inline void create_socket(struct socket_data *socket,
-	const int addr_family, const in_port_t port)
+	const int addr_family, const in_port_t port, const int sock_type)
 {
 	memset(socket, 0, sizeof(struct socket_data));
 
@@ -190,7 +190,7 @@ static inline void create_socket(struct socket_data *socket,
 		return;
 	};
 
-	socket->fd = SAFE_SOCKET(addr_family, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	socket->fd = SAFE_SOCKET(addr_family, sock_type | SOCK_CLOEXEC, 0);
 }
 
 static inline void getsocket_addr(struct socket_data *socket,

---
base-commit: 01d0eecd694cab3b95db1394e327bdd40974493e
change-id: 20260630-landlock_udp-2db35b4d43c2

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
