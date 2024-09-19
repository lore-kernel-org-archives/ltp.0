Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36101CE8D75
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 10:23:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDAE83C2FAB
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 12:23:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A7993C2F5B
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:23:19 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 846DF601151
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:23:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CA975208AE
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726741397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CM2mBO1j9IRh1tM2LzMpkkNfTlmbPkUBc0HhvpliX6g=;
 b=f6Xy7z6DKn7xgzdM9d3DWuNfISfZWC2zBacYqKz26nL0ghSfv2AzeFHtUtwkKLiFYYvpKA
 BbvmtUhOzG0HMPfNVL2itGPGXOSedgJaWurkgpnOGtd7ZZJ7IpRqGTmBwZ5qx7eYx4Y+ZT
 oXfPF3vZu/3DG52omxmx5M6nCBcEGsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726741397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CM2mBO1j9IRh1tM2LzMpkkNfTlmbPkUBc0HhvpliX6g=;
 b=v/FP+NFcV1i2vJc4DLWkeKfvo8s4/y8/j8DrI+t4FrHHwluBDAXZUpuw+udOFES0GeH8hp
 B3NcziKq01bkrNAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726741397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CM2mBO1j9IRh1tM2LzMpkkNfTlmbPkUBc0HhvpliX6g=;
 b=f6Xy7z6DKn7xgzdM9d3DWuNfISfZWC2zBacYqKz26nL0ghSfv2AzeFHtUtwkKLiFYYvpKA
 BbvmtUhOzG0HMPfNVL2itGPGXOSedgJaWurkgpnOGtd7ZZJ7IpRqGTmBwZ5qx7eYx4Y+ZT
 oXfPF3vZu/3DG52omxmx5M6nCBcEGsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726741397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CM2mBO1j9IRh1tM2LzMpkkNfTlmbPkUBc0HhvpliX6g=;
 b=v/FP+NFcV1i2vJc4DLWkeKfvo8s4/y8/j8DrI+t4FrHHwluBDAXZUpuw+udOFES0GeH8hp
 B3NcziKq01bkrNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B452A13AAA
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wD6VKpX762ZkBAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 19 Sep 2024 12:23:08 +0200
MIME-Version: 1.0
Message-Id: <20240919-landlock_network-v1-2-9c997f03bd0a@suse.com>
References: <20240919-landlock_network-v1-0-9c997f03bd0a@suse.com>
In-Reply-To: <20240919-landlock_network-v1-0-9c997f03bd0a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726741397; l=3965;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=dlAHOYK/cKldhqwY5Xd2a25OafLUA4+oegT1EtyhDqM=;
 b=O5wL1RLbrRvM8+0MrG9TNz61kxJmKwYyTVSOSd5LLsUdRmaNfxmdpskUyDHt1FzVZRJGyzb45
 4GFIpHZXkaAC+tnbbHnwuZF+mydgS5XnTsDtBLGA2gtDrnGlFcP6OOw
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] Network helpers in landlock suite common functions
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
 testcases/kernel/syscalls/landlock/landlock05.c    |  4 +--
 testcases/kernel/syscalls/landlock/landlock06.c    |  2 +-
 .../kernel/syscalls/landlock/landlock_common.h     | 39 ++++++++++++++++++++--
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock05.c b/testcases/kernel/syscalls/landlock/landlock05.c
index 4efe19eb5..f0afad11a 100644
--- a/testcases/kernel/syscalls/landlock/landlock05.c
+++ b/testcases/kernel/syscalls/landlock/landlock05.c
@@ -70,13 +70,13 @@ static void setup(void)
 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
 		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr), 0);
 
-	apply_landlock_rule(
+	apply_landlock_fs_rule(
 		path_beneath_attr,
 		ruleset_fd,
 		LANDLOCK_ACCESS_FS_REFER,
 		DIR1);
 
-	apply_landlock_rule(
+	apply_landlock_fs_rule(
 		path_beneath_attr,
 		ruleset_fd,
 		LANDLOCK_ACCESS_FS_REFER,
diff --git a/testcases/kernel/syscalls/landlock/landlock06.c b/testcases/kernel/syscalls/landlock/landlock06.c
index 39e0856e3..f04df2ff1 100644
--- a/testcases/kernel/syscalls/landlock/landlock06.c
+++ b/testcases/kernel/syscalls/landlock/landlock06.c
@@ -59,7 +59,7 @@ static void setup(void)
 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
 		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr), 0);
 
-	apply_landlock_layer(
+	apply_landlock_fs_layer(
 		ruleset_attr,
 		path_beneath_attr,
 		MNTPOINT,
diff --git a/testcases/kernel/syscalls/landlock/landlock_common.h b/testcases/kernel/syscalls/landlock/landlock_common.h
index c0bf88e4c..a955340bf 100644
--- a/testcases/kernel/syscalls/landlock/landlock_common.h
+++ b/testcases/kernel/syscalls/landlock/landlock_common.h
@@ -33,7 +33,7 @@ static inline int verify_landlock_is_enabled(void)
 	return abi;
 }
 
-static inline void apply_landlock_rule(
+static inline void apply_landlock_fs_rule(
 	struct landlock_path_beneath_attr *path_beneath_attr,
 	const int ruleset_fd,
 	const int access,
@@ -51,13 +51,29 @@ static inline void apply_landlock_rule(
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
 	SAFE_LANDLOCK_RESTRICT_SELF(ruleset_fd, 0);
 }
 
-static inline void apply_landlock_layer(
+static inline void apply_landlock_fs_layer(
 	struct tst_landlock_ruleset_attr *ruleset_attr,
 	struct landlock_path_beneath_attr *path_beneath_attr,
 	const char *path,
@@ -68,7 +84,24 @@ static inline void apply_landlock_layer(
 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
 		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr), 0);
 
-	apply_landlock_rule(path_beneath_attr, ruleset_fd, access, path);
+	apply_landlock_fs_rule(path_beneath_attr, ruleset_fd, access, path);
+	enforce_ruleset(ruleset_fd);
+
+	SAFE_CLOSE(ruleset_fd);
+}
+
+static inline void apply_landlock_net_layer(
+	struct tst_landlock_ruleset_attr *ruleset_attr,
+	struct landlock_net_port_attr *net_port_attr,
+	const uint64_t port,
+	const uint64_t access)
+{
+	int ruleset_fd;
+
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
+		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr), 0);
+
+	apply_landlock_net_rule(net_port_attr, ruleset_fd, port, access);
 	enforce_ruleset(ruleset_fd);
 
 	SAFE_CLOSE(ruleset_fd);

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
