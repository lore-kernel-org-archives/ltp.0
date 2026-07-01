Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07AAC43458
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 08:13:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C7813E4A87
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 10:13:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63C0A3E4A85
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 10:13:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5BACB6002F8
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 10:13:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 79EB375F81;
 Wed,  1 Jul 2026 08:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782893608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3kyq3XRi8mkFRCyy/Ig+4tWimQat00nlbbO86DUfHzM=;
 b=OjySfN4FJC4qlEKXz2O3bjUQmPrNE4WL/2T3/5s1iN+vJl4orrAgA43MXqIg1dTedn7ps0
 kWdtoRl5q4LGgyB+F9T+OjLAns90rODVRLE+HZj1IT3FPfSq28GDAoIZVPymUvVVY/LQZu
 JbBtjy2ZNE3GHuNHrok/h2bRJ14B6+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782893608;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3kyq3XRi8mkFRCyy/Ig+4tWimQat00nlbbO86DUfHzM=;
 b=UV93IoKKKfPxqID/wRPUPBUcQZ+cmF5ugiG2Q0gOGLLQ/acilbFFbgdiJLOBZWerROdkVR
 ssY4WtKQX2S+gXCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782893607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3kyq3XRi8mkFRCyy/Ig+4tWimQat00nlbbO86DUfHzM=;
 b=0nizZiVdaOk28Rm35goazySKrUUDEzh9yMZdiF0ux9PY1dopplKbj8prlVgRrzdzCNgTO7
 KHyTDs2+lGI1FP5HqsUfBtkgAB5adJ4eF0soJ7CI5/ComtIObUusCb4jJVA5/x/rmnIH5f
 ZzO1NbrVdjksEFtImaoGjplTKE30FyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782893607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3kyq3XRi8mkFRCyy/Ig+4tWimQat00nlbbO86DUfHzM=;
 b=5LZFtelvoI0fCbtE6ejh+T7BO+c7SiEK/USJZ9GlP2tm5SSJSzsb/d21P19ln4ElaUNDLG
 K/7X4nrPvCgDPGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57CA3779AC;
 Wed,  1 Jul 2026 08:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id C9aTEyfMRGrvQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 01 Jul 2026 08:13:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 01 Jul 2026 10:13:26 +0200
MIME-Version: 1.0
Message-Id: <20260701-landlock_udp-v2-1-b1a2c71be093@suse.com>
X-B4-Tracking: v=1; b=H4sIACXMRGoC/3XMQQ7CIBCF4as0sxYDQ22jq97DNIYCtRMrNGCJp
 uHuYvcu/5e8b4NoA9kIl2qDYBNF8q4EHirQk3J3y8iUBuTY8EZyNitnZq8ft9UsDM0gT0Ntaqk
 RymUJdqT3zl370hPFlw+fXU/it/6BkmCCoVBtzZGfx5Z3cY32qP0T+pzzF/5UdTOnAAAA
X-Change-ID: 20260630-landlock_udp-2db35b4d43c2
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782893607; l=14248;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=NfOLOK8Ibmi9BM+YCqlsdHWqD3CLs5jcH/eRoRGr26E=;
 b=amMBaYJc3waW5fYfIPOH8f8hyQVhmHLZ4CkLOBZ+0UH00n6/LnWSb78eiP67IA8u0GhyD4qHR
 7DLhRULTYc0CZ3wBQ2Y3ThzgxIoiyMchT6IPZw1CHUnY6XdYJw7ebdc
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] landlock08: add UDP bind/connect test variants
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
Landlock ABI v10, alongside the existing TCP rights. This is a feature
that has been introduced by kernel v7.2.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Implements: https://github.com/linux-test-project/ltp/issues/1333
---
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.2.0-rc1-virtme/build/.config'
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_lanTTaBbd as tmpdir (overlayfs filesystem)
tst_test.c:2047: TINFO: LTP version: 20260529-74-gb52526661
tst_test.c:2050: TINFO: Tested kernel: 7.2.0-rc1-virtme #8 SMP PREEMPT_DYNAMIC Wed Jul  1 10:11:58 CEST 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.2.0-rc1-virtme/build/.config'
tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s
landlock_common.h:41: TINFO: Landlock ABI v10
landlock08.c:160: TINFO: Using TCP/IPv4 protocol
landlock08.c:111: TPASS: bind() access on port 40839 passed
landlock08.c:186: TINFO: Enable bind() access only for port 40839
landlock08.c:111: TPASS: bind() access on port 40839 passed
landlock08.c:107: TPASS: bind() access on port 40967 : EACCES (13)
landlock08.c:133: TPASS: connect() on port 34419 passed
landlock08.c:208: TINFO: Enable connect() access only on port 34419
landlock08.c:133: TPASS: connect() on port 34419 passed
landlock08.c:129: TPASS: connect() on port 34547 : EACCES (13)
landlock_common.h:41: TINFO: Landlock ABI v10
landlock08.c:160: TINFO: Using TCP/IPv6 protocol
landlock08.c:111: TPASS: bind() access on port 47521 passed
landlock08.c:186: TINFO: Enable bind() access only for port 47521
landlock08.c:111: TPASS: bind() access on port 47521 passed
landlock08.c:107: TPASS: bind() access on port 47649 : EACCES (13)
landlock08.c:133: TPASS: connect() on port 47551 passed
landlock08.c:208: TINFO: Enable connect() access only on port 47551
landlock08.c:133: TPASS: connect() on port 47551 passed
landlock08.c:129: TPASS: connect() on port 47679 : EACCES (13)
landlock_common.h:41: TINFO: Landlock ABI v10
landlock08.c:160: TINFO: Using UDP/IPv4 protocol
landlock08.c:111: TPASS: bind() access on port 42426 passed
landlock08.c:186: TINFO: Enable bind() access only for port 42426
landlock08.c:111: TPASS: bind() access on port 42426 passed
landlock08.c:107: TPASS: bind() access on port 42554 : EACCES (13)
landlock08.c:133: TPASS: connect() on port 55245 passed
landlock08.c:208: TINFO: Enable connect() access only on port 55245
landlock08.c:133: TPASS: connect() on port 55245 passed
landlock08.c:129: TPASS: connect() on port 55373 : EACCES (13)
landlock_common.h:41: TINFO: Landlock ABI v10
landlock08.c:160: TINFO: Using UDP/IPv6 protocol
landlock08.c:111: TPASS: bind() access on port 14797 passed
landlock08.c:186: TINFO: Enable bind() access only for port 14797
landlock08.c:111: TPASS: bind() access on port 14797 passed
landlock08.c:107: TPASS: bind() access on port 14925 : EACCES (13)
landlock08.c:133: TPASS: connect() on port 55987 passed
landlock08.c:208: TINFO: Enable connect() access only on port 55987
landlock08.c:133: TPASS: connect() on port 55987 passed
landlock08.c:129: TPASS: connect() on port 56115 : EACCES (13)

Summary:
passed   24
failed   0
broken   0
skipped  0
warnings 0
---
Changes in v2:
- port acquisition per variant has been moved into run()
- better description
- IPV -> IPv
- mention kernel v7.2 in the commit message
- Link to v1: https://lore.kernel.org/r/20260630-landlock_udp-v1-1-21a740209f70@suse.com
---
 include/lapi/landlock.h                            |   8 ++
 testcases/kernel/syscalls/landlock/landlock08.c    | 136 ++++++++++++++-------
 .../kernel/syscalls/landlock/landlock_common.h     |   4 +-
 3 files changed, 99 insertions(+), 49 deletions(-)

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
index 7e7d8470bf49662416f7c83a444876575b29fb16..c0de99d7244410f9bc41f276c0f6990f7cb69810 100644
--- a/testcases/kernel/syscalls/landlock/landlock08.c
+++ b/testcases/kernel/syscalls/landlock/landlock08.c
@@ -4,68 +4,104 @@
  */
 
 /*\
- * Verify the landlock support for bind()/connect() syscalls in IPV4 and IPV6
- * protocols. In particular, check that bind() is assigning the address only on
- * the TCP port enforced by LANDLOCK_ACCESS_NET_BIND_TCP and check that
- * connect() is connecting only to a specific TCP port enforced by
- * LANDLOCK_ACCESS_NET_CONNECT_TCP.
+ * Verify the landlock support for bind()/connect() syscalls in IPv4 and IPv6
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
+ * Repeat the following procedure for {TCP, UDP} x {IPv4, IPv6}:
  *
  * - create a socket on PORT1, bind() it and check if it passes
- * - enforce the current sandbox with LANDLOCK_ACCESS_NET_BIND_TCP on PORT1
+ * - enforce the current sandbox with the BIND access right on PORT1
  * - create a socket on PORT1, bind() it and check if it passes
  * - create a socket on PORT2, bind() it and check if it fails
  *
- * - create a server listening on PORT1
+ * - create a server on PORT1 (listening for TCP, bound for UDP)
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
+		4, "TCP/IPv4"
+	},
+	{
+		AF_INET6, SOCK_STREAM,
+		LANDLOCK_ACCESS_NET_BIND_TCP,
+		LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		4, "TCP/IPv6"
+	},
+	{
+		AF_INET, SOCK_DGRAM,
+		LANDLOCK_ACCESS_NET_BIND_UDP,
+		LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+		10, "UDP/IPv4"
+	},
+	{
+		AF_INET6, SOCK_DGRAM,
+		LANDLOCK_ACCESS_NET_BIND_UDP,
+		LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+		10, "UDP/IPv6"
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
+
+	*server_port = getsocket_port(&socket, tc->family);
 
-	tst_res(TDEBUG, "Server listening on port %u", *server_port);
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
+			tc->family == AF_INET ? "IPv4" : "IPv6");
 		return 0;
 	}
 	if (fd != -1)
@@ -118,15 +155,23 @@ static int check_ipv6_support(void)
 
 static void run(void)
 {
-	int addr_family = variants[tst_variant];
+	struct tcase *tc = &variants[tst_variant];
 
-	tst_res(TINFO, "Using %s protocol",
-		addr_family == AF_INET ? "IPV4" : "IPV6");
-	if (addr_family == AF_INET6 && !check_ipv6_support())
+	tst_res(TINFO, "Using %s protocol", tc->desc);
+
+	addr_port = TST_GET_UNUSED_PORT(tc->family, tc->type);
+
+	if (landlock_abi < tc->min_abi) {
+		tst_res(TCONF, "%s rules require Landlock ABI v%d",
+			tc->desc, tc->min_abi);
+		return;
+	}
+
+	if (!check_family_support(tc))
 		return;
 
 	if (!SAFE_FORK()) {
-		create_server(addr_family);
+		create_server(tc);
 		exit(0);
 	}
 
@@ -134,10 +179,9 @@ static void run(void)
 
 	/* verify bind() syscall accessibility */
 	if (!SAFE_FORK()) {
-		ruleset_attr->handled_access_net =
-			LANDLOCK_ACCESS_NET_BIND_TCP;
+		ruleset_attr->handled_access_net = tc->bind_access;
 
-		test_bind(addr_family, addr_port, 0);
+		test_bind(tc, addr_port, 0);
 
 		tst_res(TINFO, "Enable bind() access only for port %u",
 			addr_port);
@@ -147,20 +191,19 @@ static void run(void)
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
@@ -170,10 +213,10 @@ static void run(void)
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
 
@@ -183,11 +226,10 @@ static void run(void)
 
 static void setup(void)
 {
-	if (verify_landlock_is_enabled() < 4)
+	landlock_abi = verify_landlock_is_enabled();
+	if (landlock_abi < 4)
 		tst_brk(TCONF, "Landlock network is not supported");
 
-	addr_port = TST_GET_UNUSED_PORT(AF_INET, SOCK_STREAM);
-
 	server_port = SAFE_MMAP(NULL, sizeof(in_port_t), PROT_READ | PROT_WRITE,
 		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 }
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
