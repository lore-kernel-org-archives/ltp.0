Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D69C02185
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 14:49:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B89023C7B2E
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 15:49:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 477F93C1FE9
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 15:48:59 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BC8EC1B61509
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 15:48:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E542F21172
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737125338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JTua8AfqFKXd/aioF2SfE4vLBmPtIsmMagHJ8MXw6TQ=;
 b=HMVcdWeGkKCbSQtEmVwPI+L+EDWPkp1/gjZshBkZKc5IJpEmjDhMeab2gnRFuod34Ike9w
 Xdqxwg7GBYlK9tp+OumyLKQJa+v5cKViIS1kGD4ekI13g401MEHN/hMWv2UYqAVo7N8WVK
 8B8juRDD2A6hQhrM1wOG8N6ExV8iWRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737125338;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JTua8AfqFKXd/aioF2SfE4vLBmPtIsmMagHJ8MXw6TQ=;
 b=V9pRLI/mh33TwkZ8zkDdj4sZ6cd7mgaqEuytPTSSWnEbaliToH+/9zFlxTDZ7icjVC3O2H
 KaS8HkNCwLdw2VDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737125337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JTua8AfqFKXd/aioF2SfE4vLBmPtIsmMagHJ8MXw6TQ=;
 b=v0RopRn5/DClqKD6+l1CuHz0xdvRFHuYcfUauT51NafExRIQb7I3AqgIuo38luVkTKh4ND
 mOpI49wNuQXMymGXoYCHiM5Plr1h3ivqK2aI2qmYjVWMMvfxtjhvL3S3u5EMwfpN0kBnhx
 gASUugKw37xE4oXg2iIEWctsSfobbDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737125337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JTua8AfqFKXd/aioF2SfE4vLBmPtIsmMagHJ8MXw6TQ=;
 b=mlw+L+/avNK+aMX2700kbGiYgrxLfXepdp5WqvyhxSlFDu14Gz6cQ/GGphspH/yWjBBIjr
 kyLD/yTMSej7TWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D19BD13332
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DyToMtltimeHYwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:48:57 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Jan 2025 15:48:43 +0100
Message-ID: <20250117144855.50127-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cgroup_core02: Allocate child stack using mmap()
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

Some architectures like arm64 have strict requirements for stack alignment.
Statically allocated buffer may result in one of the test processes
getting killed by SIGBUS. Allocate child stack using mmap() to ensure
the requirements are met.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/controllers/cgroup/cgroup_core02.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcases/kernel/controllers/cgroup/cgroup_core02.c
index 733e88ee7..e0b96ecf4 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core02.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
@@ -51,7 +51,7 @@ static int lesser_ns_open_thread_fn(void *arg)
 static void test_lesser_ns_open(void)
 {
 	int i;
-	static char stack[65536];
+	char *stack;
 	pid_t pid;
 	int status;
 	struct lesser_ns_open_thread_arg targ = { .fds = {0}, .loops = -1};
@@ -63,14 +63,19 @@ static void test_lesser_ns_open(void)
 		SAFE_CG_PRINT(cg_child_a, "cgroup.procs", "0");
 		SAFE_CG_FCHOWN(cg_child_a, "cgroup.procs",  nobody_uid, -1);
 		SAFE_CG_FCHOWN(cg_child_b, "cgroup.procs",  nobody_uid, -1);
+		stack = SAFE_MMAP(NULL, 65536, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
 		pid  = ltp_clone(CLONE_NEWCGROUP | CLONE_FILES | CLONE_VM | SIGCHLD,
 					lesser_ns_open_thread_fn, &targ, 65536, stack);
+
 		if (pid < 0)  {
 			tst_res(TFAIL, "unexpected negative pid %d", pid);
 			exit(1);
 		}
 
 		SAFE_WAITPID(pid, &status, 0);
+		SAFE_MUNMAP(stack, 65536);
+
 		for (i = 0; i < targ.loops; i++) {
 			if (targ.fds[i] < 1) {
 				tst_res(TFAIL, "unexpected negative fd %d", targ.fds[i]);
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
