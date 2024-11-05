Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB03D1266E
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 09:35:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8A993D1F2D
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 10:35:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F7D83D1F10
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 10:34:32 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9273E222FBB
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 10:34:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 020011FE1A
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 09:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730799269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmFx+ZoGKaF8JcZ0SEs7vMOYAGoAp4of9O1OLpWp3Ww=;
 b=OgJN3dTFrK4LTs5/jxflPIshRmF0wHYdQk9oMWXRS47CvbXOpnsLxrffGDkFvhEEDwL1XY
 vAUGCdqlXE5AApopvuRozAkIsDC9e3e9dgloyDI62H1ebOKQIft32qyvcgF7Qwz9nvyLj8
 N2qemAqV46URG9xTypLrrKwoU/Mile0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730799269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmFx+ZoGKaF8JcZ0SEs7vMOYAGoAp4of9O1OLpWp3Ww=;
 b=q3C0TN1hRDXFoFfRq+1IoHWCgW7E4oaFCYZU9/SPo4BIcPPBzK5A3up02ct0qBrrsHUeyu
 EeK+fwo/JkCcZuBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730799269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmFx+ZoGKaF8JcZ0SEs7vMOYAGoAp4of9O1OLpWp3Ww=;
 b=OgJN3dTFrK4LTs5/jxflPIshRmF0wHYdQk9oMWXRS47CvbXOpnsLxrffGDkFvhEEDwL1XY
 vAUGCdqlXE5AApopvuRozAkIsDC9e3e9dgloyDI62H1ebOKQIft32qyvcgF7Qwz9nvyLj8
 N2qemAqV46URG9xTypLrrKwoU/Mile0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730799269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmFx+ZoGKaF8JcZ0SEs7vMOYAGoAp4of9O1OLpWp3Ww=;
 b=q3C0TN1hRDXFoFfRq+1IoHWCgW7E4oaFCYZU9/SPo4BIcPPBzK5A3up02ct0qBrrsHUeyu
 EeK+fwo/JkCcZuBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4BC01394A
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 09:34:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cNucJqTmKWeAPwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 09:34:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 05 Nov 2024 10:34:26 +0100
MIME-Version: 1.0
Message-Id: <20241105-landlock_network-v2-2-d58791487919@suse.com>
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
In-Reply-To: <20241105-landlock_network-v2-0-d58791487919@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730799267; l=4182;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=bb0mNcabNfgo6eO8im6I/sIqAGiaCsEwkXF0hpOJhQE=;
 b=hwc7pmH/AeiiKx7CUkQmFiJDmlUCRodWvF/bQOd0V6sYLNQ2BuaI36K4tMSVqEkev6r4U8rlR
 rqKWW55zXr1Dvs88Z75QhjeIe2ZbdmnFlcaULKIB7t+kqnqvR/6IFnp
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] Network helpers in landlock suite common
 functions
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

Landlock suite helpers functions don't support network features. This
patch adds apply_landlock_net_layer() helper that can be used to apply a
network landlock rule in the current sandbox.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../kernel/syscalls/landlock/landlock_common.h     | 124 +++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/testcases/kernel/syscalls/landlock/landlock_common.h b/testcases/kernel/syscalls/landlock/landlock_common.h
index f3096f4bf15f155f2a00b39c461d0805a76306e5..d55f2a2576968a89fbeca6bb2a56c6c2700729fa 100644
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
@@ -51,6 +61,22 @@ static inline void apply_landlock_fs_rule(
 	SAFE_CLOSE(path_beneath_attr->parent_fd);
 }
 
+static inline void apply_landlock_net_rule(
+	struct landlock_net_port_attr *net_attr,
+	const int ruleset_fd,
+	const uint64_t port,
+	const uint64_t access)
+{
+	net_attr->port = port;
+	net_attr->allowed_access = access;
+
+	SAFE_LANDLOCK_ADD_RULE(
+		ruleset_fd,
+		LANDLOCK_RULE_NET_PORT,
+		net_attr,
+		0);
+}
+
 static inline void enforce_ruleset(const int ruleset_fd)
 {
 	SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
@@ -72,4 +98,102 @@ static inline void apply_landlock_fs_layer(
 
 	SAFE_CLOSE(ruleset_fd);
 }
+
+static inline void apply_landlock_net_layer(
+	void *ruleset_attr, size_t attr_size,
+	struct landlock_net_port_attr *net_port_attr,
+	const in_port_t port,
+	const uint64_t access)
+{
+	int ruleset_fd;
+
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(ruleset_attr, attr_size, 0);
+
+	apply_landlock_net_rule(net_port_attr, ruleset_fd, port, access);
+	enforce_ruleset(ruleset_fd);
+
+	SAFE_CLOSE(ruleset_fd);
+}
+
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
