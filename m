Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231A6D44D4F
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 11:14:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A9CB3D318C
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 12:14:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECD393CBEF3
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 12:13:28 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 62AAE2009AB
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 12:13:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5BB821B75;
 Wed,  6 Nov 2024 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730891607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zfUkyGXqoiuLMb8PDG5orxJGhDcGt1u86g+6eEJBEw=;
 b=JbU0DEFqkY0YQihaH2ujdTU/5hvD26aNaM6nJqABEW8JlCye/ukFhPyyph4wZz6EDvp/Fw
 KpXm8kXKhlC+tlGjnZqtYF9m+bpRYy5XEmGSzlY7v3hw2ZhY/BgHsYeFtmqS2NHocm4nNd
 1QRRdbO10dadYtyQ8Kc6Fpjt0SvFfeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730891607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zfUkyGXqoiuLMb8PDG5orxJGhDcGt1u86g+6eEJBEw=;
 b=p0Q2aC9WbQJQDNH1ehF576h0KY49Uuo3QFhHhFPsM1uEGhrmFTGOMiffvn71Lb/88jNedC
 YFnI3g8UF1V1n/CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JbU0DEFq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p0Q2aC9W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730891607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zfUkyGXqoiuLMb8PDG5orxJGhDcGt1u86g+6eEJBEw=;
 b=JbU0DEFqkY0YQihaH2ujdTU/5hvD26aNaM6nJqABEW8JlCye/ukFhPyyph4wZz6EDvp/Fw
 KpXm8kXKhlC+tlGjnZqtYF9m+bpRYy5XEmGSzlY7v3hw2ZhY/BgHsYeFtmqS2NHocm4nNd
 1QRRdbO10dadYtyQ8Kc6Fpjt0SvFfeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730891607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zfUkyGXqoiuLMb8PDG5orxJGhDcGt1u86g+6eEJBEw=;
 b=p0Q2aC9WbQJQDNH1ehF576h0KY49Uuo3QFhHhFPsM1uEGhrmFTGOMiffvn71Lb/88jNedC
 YFnI3g8UF1V1n/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7BDD13A3B;
 Wed,  6 Nov 2024 11:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4EsIK1dPK2eFdQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 06 Nov 2024 11:13:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 06 Nov 2024 12:13:18 +0100
MIME-Version: 1.0
Message-Id: <20241106-landlock_network-v3-4-855b14df63c6@suse.com>
References: <20241106-landlock_network-v3-0-855b14df63c6@suse.com>
In-Reply-To: <20241106-landlock_network-v3-0-855b14df63c6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730891606; l=5813;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=RweA8gvUc8/AyfYDOwJRmZt3oIQQLfVBR4NqA0rs5Yg=;
 b=c2pLsie61+eMNql3Ti0/3rLNheKA3yA7D0rf7yxWxavljyGp8odPdDOYwrl12ytL8zHuPNtyF
 2i3vXwa4vj6DMA1DL2GsgX6EcBgu0ciDHB1+mGlin44cjVpsh/ZeBe/
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: D5BB821B75
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/4] Add error coverage for landlock network support
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

Add two more errors checks inside the landlock02 which is testing
landlock_add_rule syscall. In particular, test now verifies when the
syscall is raising EINVAL due to invalid network attributes.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/landlock/landlock02.c | 93 +++++++++++++++++++------
 1 file changed, 72 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock02.c b/testcases/kernel/syscalls/landlock/landlock02.c
index 8566d407f6d17ab367695125f07d0a80cf4130e5..e1e3228b54f3fdb10774cb333ccc5646c7c4e37b 100644
--- a/testcases/kernel/syscalls/landlock/landlock02.c
+++ b/testcases/kernel/syscalls/landlock/landlock02.c
@@ -20,93 +20,142 @@
 
 #include "landlock_common.h"
 
-static struct tst_landlock_ruleset_attr_abi1 *ruleset_attr;
+static struct tst_landlock_ruleset_attr_abi1 *attr_abi1;
+static struct tst_landlock_ruleset_attr_abi4 *attr_abi4;
 static struct landlock_path_beneath_attr *path_beneath_attr;
 static struct landlock_path_beneath_attr *rule_null;
+static struct landlock_net_port_attr *net_port_attr;
 static int ruleset_fd;
 static int invalid_fd = -1;
+static int abi_current;
 
 static struct tcase {
 	int *fd;
-	enum landlock_rule_type rule_type;
-	struct landlock_path_beneath_attr **attr;
+	int rule_type;
+	struct landlock_path_beneath_attr **path_attr;
+	struct landlock_net_port_attr **net_attr;
 	int access;
 	int parent_fd;
+	int net_port;
 	uint32_t flags;
 	int exp_errno;
+	int abi_ver;
 	char *msg;
 } tcases[] = {
 	{
 		.fd = &ruleset_fd,
-		.attr = &path_beneath_attr,
+		.path_attr = &path_beneath_attr,
 		.access = LANDLOCK_ACCESS_FS_EXECUTE,
 		.flags = 1,
 		.exp_errno = EINVAL,
+		.abi_ver = 1,
 		.msg = "Invalid flags"
 	},
 	{
 		.fd = &ruleset_fd,
-		.attr = &path_beneath_attr,
+		.path_attr = &path_beneath_attr,
 		.access = LANDLOCK_ACCESS_FS_EXECUTE,
 		.exp_errno = EINVAL,
+		.abi_ver = 1,
 		.msg = "Invalid rule type"
 	},
 	{
 		.fd = &ruleset_fd,
 		.rule_type = LANDLOCK_RULE_PATH_BENEATH,
-		.attr = &path_beneath_attr,
+		.path_attr = &path_beneath_attr,
 		.exp_errno = ENOMSG,
+		.abi_ver = 1,
 		.msg = "Empty accesses"
 	},
 	{
 		.fd = &invalid_fd,
-		.attr = &path_beneath_attr,
+		.path_attr = &path_beneath_attr,
 		.access = LANDLOCK_ACCESS_FS_EXECUTE,
 		.exp_errno = EBADF,
+		.abi_ver = 1,
 		.msg = "Invalid file descriptor"
 	},
 	{
 		.fd = &ruleset_fd,
 		.rule_type = LANDLOCK_RULE_PATH_BENEATH,
-		.attr = &path_beneath_attr,
+		.path_attr = &path_beneath_attr,
 		.access = LANDLOCK_ACCESS_FS_EXECUTE,
 		.parent_fd = -1,
 		.exp_errno = EBADF,
+		.abi_ver = 1,
 		.msg = "Invalid parent fd"
 	},
 	{
 		.fd = &ruleset_fd,
 		.rule_type = LANDLOCK_RULE_PATH_BENEATH,
-		.attr = &rule_null,
+		.path_attr = &rule_null,
 		.exp_errno = EFAULT,
+		.abi_ver = 1,
 		.msg = "Invalid rule attr"
 	},
+	{
+		.fd = &ruleset_fd,
+		.rule_type = LANDLOCK_RULE_NET_PORT,
+		.net_attr = &net_port_attr,
+		.access = LANDLOCK_ACCESS_FS_EXECUTE,
+		.net_port = 448,
+		.exp_errno = EINVAL,
+		.abi_ver = 4,
+		.msg = "Invalid access rule for network type"
+	},
+	{
+		.fd = &ruleset_fd,
+		.rule_type = LANDLOCK_RULE_NET_PORT,
+		.net_attr = &net_port_attr,
+		.access = LANDLOCK_ACCESS_NET_BIND_TCP,
+		.net_port = INT16_MAX + 1,
+		.exp_errno = EINVAL,
+		.abi_ver = 4,
+		.msg = "Socket port greater than 65535"
+	},
 };
 
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
+	void *attr = NULL;
 
-	if (*tc->attr) {
-		(*tc->attr)->allowed_access = tc->access;
-		(*tc->attr)->parent_fd = tc->parent_fd;
+	if (tc->abi_ver > abi_current) {
+		tst_res(TCONF, "Minimum ABI required: %d", tc->abi_ver);
+		return;
+	}
+
+	if (tc->path_attr && *tc->path_attr) {
+		(*tc->path_attr)->allowed_access = tc->access;
+		(*tc->path_attr)->parent_fd = tc->parent_fd;
+
+		attr = *tc->path_attr;
+	} else if (tc->net_attr && *tc->net_attr) {
+		(*tc->net_attr)->allowed_access = tc->access;
+		(*tc->net_attr)->port = tc->net_port;
+
+		attr = *tc->net_attr;
 	}
 
 	TST_EXP_FAIL(tst_syscall(__NR_landlock_add_rule,
-		*tc->fd, tc->rule_type, *tc->attr, tc->flags),
-		tc->exp_errno,
-		"%s",
-		tc->msg);
+		*tc->fd, tc->rule_type, attr, tc->flags),
+		tc->exp_errno, "%s", tc->msg);
 }
 
 static void setup(void)
 {
-	verify_landlock_is_enabled();
+	abi_current = verify_landlock_is_enabled();
 
-	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
+	attr_abi1->handled_access_fs =
+		attr_abi4->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
 
-	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
-		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
+	if (abi_current < 4) {
+		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
+			attr_abi1, sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
+	} else {
+		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
+			attr_abi4, sizeof(struct tst_landlock_ruleset_attr_abi4), 0));
+	}
 }
 
 static void cleanup(void)
@@ -122,8 +171,10 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr_abi1)},
+		{&attr_abi1, .size = sizeof(struct tst_landlock_ruleset_attr_abi1)},
+		{&attr_abi4, .size = sizeof(struct tst_landlock_ruleset_attr_abi4)},
 		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
+		{&net_port_attr, .size = sizeof(struct landlock_net_port_attr)},
 		{},
 	},
 	.caps = (struct tst_cap []) {

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
