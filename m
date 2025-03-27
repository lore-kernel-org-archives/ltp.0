Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5209FC3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 11:08:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3C193C9E14
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 12:08:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0B293C19F4
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:08:02 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 496AB200061
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:08:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E001A1F453;
 Thu, 27 Mar 2025 11:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743073680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qjq8nCELohDRFu9WxD29GQ3MUcWWo2qzFk3j31pwR9A=;
 b=g1zaXYq7D7bf9WcqRm8vU5KlPhRQ/ROF596CBOs2aFOZHYaS9XpEq244xdAn1JLkYV4fiE
 DwOErrUAIrGPed1ivhDJabXukFjTt/qmKAX11MBduAlxqFcJQrVFGBznu1OBh+q2QUAfpi
 iVdYdfasUd0yYgL1NdqVIi+CRrVRXFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743073680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qjq8nCELohDRFu9WxD29GQ3MUcWWo2qzFk3j31pwR9A=;
 b=177bWMQkotaNRhQnrQwKwMzBqGpOflEYLMpmCg0UK/K0+lGjJIZMvkGPX7wbtu+gHeEzZN
 cx0w5CTJYxE4JkAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743073680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qjq8nCELohDRFu9WxD29GQ3MUcWWo2qzFk3j31pwR9A=;
 b=g1zaXYq7D7bf9WcqRm8vU5KlPhRQ/ROF596CBOs2aFOZHYaS9XpEq244xdAn1JLkYV4fiE
 DwOErrUAIrGPed1ivhDJabXukFjTt/qmKAX11MBduAlxqFcJQrVFGBznu1OBh+q2QUAfpi
 iVdYdfasUd0yYgL1NdqVIi+CRrVRXFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743073680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qjq8nCELohDRFu9WxD29GQ3MUcWWo2qzFk3j31pwR9A=;
 b=177bWMQkotaNRhQnrQwKwMzBqGpOflEYLMpmCg0UK/K0+lGjJIZMvkGPX7wbtu+gHeEzZN
 cx0w5CTJYxE4JkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5DF513A41;
 Thu, 27 Mar 2025 11:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2LCTLpAx5WfnIQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Mar 2025 11:08:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Mar 2025 12:08:00 +0100
MIME-Version: 1.0
Message-Id: <20250327-landlock_unix_socket-v1-3-584653f66d9c@suse.com>
References: <20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com>
In-Reply-To: <20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743073680; l=5150;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=WYN1Cjweaqk42cGh46rIVrI1n+otb2aTtXfdPXx/Uro=;
 b=/mnlOpnxHniAk9XM2p4Lkn/ZOTspPPXJaqPPIlWsgf0AMCRiDyRwGRCWiNYj2PdVvt12tImc9
 lIoVZoqTWs2DwcMVaG5e30T9O+gDx6jDPFIXZRc3ovwUjwCwrscAQ72
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] landlock: add landlock09 test
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

Create landlock09 test in order to verify that sandboxed processes
enforced with LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET rule can't
connect to any UNIX socket from non-sandboxed processes.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/landlock/.gitignore      |   1 +
 testcases/kernel/syscalls/landlock/landlock09.c    | 132 +++++++++++++++++++++
 .../kernel/syscalls/landlock/landlock_common.h     |  11 ++
 3 files changed, 144 insertions(+)

diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
index fc7317394948c4ac20cd14c3cd7ba7a47282b2bf..cda8d871e051ec88abba4634a2bcda4b10470d9f 100644
--- a/testcases/kernel/syscalls/landlock/.gitignore
+++ b/testcases/kernel/syscalls/landlock/.gitignore
@@ -7,3 +7,4 @@ landlock05
 landlock06
 landlock07
 landlock08
+landlock09
diff --git a/testcases/kernel/syscalls/landlock/landlock09.c b/testcases/kernel/syscalls/landlock/landlock09.c
new file mode 100644
index 0000000000000000000000000000000000000000..7e5b5183953d3255cd24c09b12461993aee8482c
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock09.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that landlock's LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET rule reject any
+ * connect() coming from a client on a different server domain, but accept any
+ * connection.
+ */
+
+#include "tst_test.h"
+#include "landlock_common.h"
+
+#define SOCKET_NAME "test.sock"
+#define ABSTRACT_SOCKET_NAME "\0"SOCKET_NAME
+#define SOCKET_LENGTH (offsetof(struct sockaddr_un, sun_path) + strlen(SOCKET_NAME) + 1)
+
+enum {
+	DOMAIN_CLIENT = 0,
+	DOMAIN_SERVER,
+	DOMAIN_BOTH,
+	DOMAIN_LENGTH,
+};
+
+static struct tst_landlock_ruleset_attr_abi6 *ruleset_attr;
+
+static void scoped_sandbox(const char *from)
+{
+	tst_res(TINFO, "Enforcing rule LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET on %s", from);
+
+	ruleset_attr->scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
+	apply_landlock_scoped_layer(ruleset_attr, sizeof(*ruleset_attr));
+}
+
+static void run_client(void)
+{
+	if (tst_variant == DOMAIN_CLIENT)
+		scoped_sandbox("client");
+
+	int sendsock;
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+		.sun_path = ABSTRACT_SOCKET_NAME,
+	};
+
+	TST_CHECKPOINT_WAIT(0);
+
+	tst_res(TINFO, "Connecting to UNIX socket");
+
+	sendsock = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
+
+	if (tst_variant != DOMAIN_CLIENT)
+		TST_EXP_PASS(connect(sendsock, (struct sockaddr *)&addr, SOCKET_LENGTH));
+	else
+		TST_EXP_FAIL(connect(sendsock, (struct sockaddr *)&addr, SOCKET_LENGTH), EPERM);
+
+	SAFE_CLOSE(sendsock);
+
+	TST_CHECKPOINT_WAKE(0);
+}
+
+static void run_server(void)
+{
+	if (tst_variant == DOMAIN_SERVER)
+		scoped_sandbox("server");
+
+	int recvsock;
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+		.sun_path = ABSTRACT_SOCKET_NAME,
+	};
+
+	recvsock = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
+
+	SAFE_BIND(recvsock, (struct sockaddr *)&addr, SOCKET_LENGTH);
+	SAFE_LISTEN(recvsock, 5);
+
+	tst_res(TINFO, "Listening on UNIX socket");
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	SAFE_CLOSE(recvsock);
+}
+
+static void run(void)
+{
+	/* isolate test inside a process so we won't stack too many
+	 * layers (-E2BIG) when there are multiple test's iterations
+	 */
+	if (SAFE_FORK())
+		return;
+
+	if (tst_variant == DOMAIN_BOTH)
+		scoped_sandbox("server and client");
+
+	if (!SAFE_FORK()) {
+		run_client();
+		exit(0);
+	}
+
+	run_server();
+
+	tst_reap_children();
+}
+
+static void setup(void)
+{
+	int abi;
+
+	abi = verify_landlock_is_enabled();
+	if (abi < 6)
+		tst_brk(TCONF, "LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET is unsupported on ABI < 6");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.needs_checkpoints = 1,
+	.test_variants = DOMAIN_LENGTH,
+	.bufs = (struct tst_buffers []) {
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr_abi6)},
+		{},
+	},
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
+		{}
+	},
+};
diff --git a/testcases/kernel/syscalls/landlock/landlock_common.h b/testcases/kernel/syscalls/landlock/landlock_common.h
index 4aa11b7d2ad46915cd1ce1592bdaa2fb6ad77628..8857745d6f1c1c30fc914924b8d0da381b36059f 100644
--- a/testcases/kernel/syscalls/landlock/landlock_common.h
+++ b/testcases/kernel/syscalls/landlock/landlock_common.h
@@ -115,6 +115,17 @@ static inline void apply_landlock_net_layer(
 	SAFE_CLOSE(ruleset_fd);
 }
 
+static inline void apply_landlock_scoped_layer(
+	void *ruleset_attr, size_t attr_size)
+{
+	int ruleset_fd;
+
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(ruleset_attr, attr_size, 0);
+	enforce_ruleset(ruleset_fd);
+
+	SAFE_CLOSE(ruleset_fd);
+}
+
 static inline in_port_t getsocket_port(struct socket_data *socket,
 	const int addr_family)
 {

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
