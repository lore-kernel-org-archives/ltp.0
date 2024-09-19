Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A976CE8D72
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 10:24:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 630D83C035C
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 12:24:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 849183C2F61
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:23:20 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A257E6233C6
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:23:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A53133870
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726741398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oSETjH3Hs6JOfN+tUbHc+Ftxt0xg6qlwuw3MQnCPMhA=;
 b=S72qy5gsteWb9cKCnCY94U7MtgmV0dH/13MTyEbTTz42EoXmBENM5N1FJLGRrryLUwhyhL
 JcKM9XwyUs5SJXziuSJ8HY96nE100weJYNi0vXqsoLT5ODznDw3BrDt/B890SGLZsLjFWU
 2I5bqJBfJ4mqqkhFp15Dl5OlNnAur/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726741398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oSETjH3Hs6JOfN+tUbHc+Ftxt0xg6qlwuw3MQnCPMhA=;
 b=L6CLKsaEiRJSqO1vJfAJTe617e4pmfQYAX27B0VqUbVYWfidsFbWBnhpgKDvc6BFc03n4Z
 Jxdg7norTVPWY6BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726741398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oSETjH3Hs6JOfN+tUbHc+Ftxt0xg6qlwuw3MQnCPMhA=;
 b=S72qy5gsteWb9cKCnCY94U7MtgmV0dH/13MTyEbTTz42EoXmBENM5N1FJLGRrryLUwhyhL
 JcKM9XwyUs5SJXziuSJ8HY96nE100weJYNi0vXqsoLT5ODznDw3BrDt/B890SGLZsLjFWU
 2I5bqJBfJ4mqqkhFp15Dl5OlNnAur/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726741398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oSETjH3Hs6JOfN+tUbHc+Ftxt0xg6qlwuw3MQnCPMhA=;
 b=L6CLKsaEiRJSqO1vJfAJTe617e4pmfQYAX27B0VqUbVYWfidsFbWBnhpgKDvc6BFc03n4Z
 Jxdg7norTVPWY6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0929E13A5F
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eBLKAJb762ZkBAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 19 Sep 2024 12:23:11 +0200
MIME-Version: 1.0
Message-Id: <20240919-landlock_network-v1-5-9c997f03bd0a@suse.com>
References: <20240919-landlock_network-v1-0-9c997f03bd0a@suse.com>
In-Reply-To: <20240919-landlock_network-v1-0-9c997f03bd0a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726741397; l=4683;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=ew34/z/LvkKePwM8dR19EMXZzoiwbvP3/7WzKwC2+ZM=;
 b=TcxsVAvQySsEfXVBOkuVYW2Ch3ahVZ3QGLpx1K7rqk8rXHZZ9EIEsIq+bsxlpcDcY0RKA0e0m
 akoa4WxUrYzB4kUs7rdrlPqb6lyqMaHYtDDYsh6bISdzzJNav4Z7ACd
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] Add error coverage for landlock network support
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/landlock/landlock02.c | 71 +++++++++++++++++++------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock02.c b/testcases/kernel/syscalls/landlock/landlock02.c
index bdef57b55..56ed9c00c 100644
--- a/testcases/kernel/syscalls/landlock/landlock02.c
+++ b/testcases/kernel/syscalls/landlock/landlock02.c
@@ -23,22 +23,26 @@
 static struct tst_landlock_ruleset_attr *ruleset_attr;
 static struct landlock_path_beneath_attr *path_beneath_attr;
 static struct landlock_path_beneath_attr *rule_null;
+static struct landlock_net_port_attr *net_port_attr;
 static int ruleset_fd;
 static int invalid_fd = -1;
 
 static struct tcase {
 	int *fd;
 	int rule_type;
-	struct landlock_path_beneath_attr **attr;
+	struct landlock_path_beneath_attr **path_attr;
+	struct landlock_net_port_attr **net_attr;
 	int access;
 	int parent_fd;
+	int net_port;
 	uint32_t flags;
 	int exp_errno;
 	char *msg;
 } tcases[] = {
 	{
 		.fd = &ruleset_fd,
-		.attr = &path_beneath_attr,
+		.path_attr = &path_beneath_attr,
+		.net_attr = NULL,
 		.access = LANDLOCK_ACCESS_FS_EXECUTE,
 		.flags = 1,
 		.exp_errno = EINVAL,
@@ -46,7 +50,8 @@ static struct tcase {
 	},
 	{
 		.fd = &ruleset_fd,
-		.attr = &path_beneath_attr,
+		.path_attr = &path_beneath_attr,
+		.net_attr = NULL,
 		.access = LANDLOCK_ACCESS_FS_EXECUTE,
 		.exp_errno = EINVAL,
 		.msg = "Invalid rule type"
@@ -54,13 +59,15 @@ static struct tcase {
 	{
 		.fd = &ruleset_fd,
 		.rule_type = LANDLOCK_RULE_PATH_BENEATH,
-		.attr = &path_beneath_attr,
+		.path_attr = &path_beneath_attr,
+		.net_attr = NULL,
 		.exp_errno = ENOMSG,
 		.msg = "Empty accesses"
 	},
 	{
 		.fd = &invalid_fd,
-		.attr = &path_beneath_attr,
+		.path_attr = &path_beneath_attr,
+		.net_attr = NULL,
 		.access = LANDLOCK_ACCESS_FS_EXECUTE,
 		.exp_errno = EBADF,
 		.msg = "Invalid file descriptor"
@@ -68,7 +75,8 @@ static struct tcase {
 	{
 		.fd = &ruleset_fd,
 		.rule_type = LANDLOCK_RULE_PATH_BENEATH,
-		.attr = &path_beneath_attr,
+		.path_attr = &path_beneath_attr,
+		.net_attr = NULL,
 		.access = LANDLOCK_ACCESS_FS_EXECUTE,
 		.parent_fd = -1,
 		.exp_errno = EBADF,
@@ -77,26 +85,56 @@ static struct tcase {
 	{
 		.fd = &ruleset_fd,
 		.rule_type = LANDLOCK_RULE_PATH_BENEATH,
-		.attr = &rule_null,
+		.path_attr = &rule_null,
+		.net_attr = NULL,
 		.exp_errno = EFAULT,
 		.msg = "Invalid rule attr"
 	},
+	{
+		.fd = &ruleset_fd,
+		.rule_type = LANDLOCK_RULE_NET_PORT,
+		.path_attr = NULL,
+		.net_attr = &net_port_attr,
+		.access = LANDLOCK_ACCESS_FS_EXECUTE,
+		.net_port = 448,
+		.exp_errno = EINVAL,
+		.msg = "Invalid access rule for network type"
+	},
+	{
+		.fd = &ruleset_fd,
+		.rule_type = LANDLOCK_RULE_NET_PORT,
+		.path_attr = NULL,
+		.net_attr = &net_port_attr,
+		.access = LANDLOCK_ACCESS_NET_BIND_TCP,
+		.net_port = INT16_MAX + 1,
+		.exp_errno = EINVAL,
+		.msg = "Socket port greater than 65535"
+	},
 };
 
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	if (*tc->attr) {
-		(*tc->attr)->allowed_access = tc->access;
-		(*tc->attr)->parent_fd = tc->parent_fd;
-	}
+	if (tc->path_attr) {
+		if (*tc->path_attr) {
+			(*tc->path_attr)->allowed_access = tc->access;
+			(*tc->path_attr)->parent_fd = tc->parent_fd;
+		}
+
+		TST_EXP_FAIL(tst_syscall(__NR_landlock_add_rule,
+			*tc->fd, tc->rule_type, *tc->path_attr, tc->flags),
+			tc->exp_errno, "%s", tc->msg);
+	} else if (tc->net_attr) {
+		if (*tc->net_attr) {
+			(*tc->net_attr)->allowed_access = tc->access;
+			(*tc->net_attr)->port = tc->net_port;
+		}
 
-	TST_EXP_FAIL(tst_syscall(__NR_landlock_add_rule,
-			*tc->fd, tc->rule_type, *tc->attr, tc->flags),
-		tc->exp_errno,
-		"%s",
-		tc->msg);
+		TST_EXP_FAIL(tst_syscall(__NR_landlock_add_rule,
+			*tc->fd, tc->rule_type, *tc->net_attr, tc->flags),
+			tc->exp_errno, "%s", tc->msg);
+	}
 }
 
 static void setup(void)
@@ -124,6 +162,7 @@ static struct tst_test test = {
 	.bufs = (struct tst_buffers []) {
 		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr)},
 		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
+		{&net_port_attr, .size = sizeof(struct landlock_net_port_attr)},
 		{},
 	},
 	.caps = (struct tst_cap []) {

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
