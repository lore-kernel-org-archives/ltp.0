Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABD9C02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 10:49:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0EB43C19F9
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 11:49:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A007B3C130D
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 11:49:24 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A4A961021B
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 11:49:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1EC761F7B2;
 Mon, 20 Jan 2025 10:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737370163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JNpRm/Mbu4P2bE9GDlYRRYu9Qc6P24KCcaABaNWGcFg=;
 b=D164y3BtJHxOVQf4/U9R+Iz3qkZ7fd+mHAyPt7JiA5sEMEzLE5fafH1xyNWAm5RSHNW7nh
 2XSe7AE/QO1zJGHeihNuOjvVl2J7CfGnXCMwBSbZaCWixuNahl9FvUONlyuKRCcQAdNx+G
 cEsamffvR6PrPLP1wFF7k3h/Hv6CM2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737370163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JNpRm/Mbu4P2bE9GDlYRRYu9Qc6P24KCcaABaNWGcFg=;
 b=pS6/8v3SsPqAu8vP08MQ7BrMvqQGQqeh6SQy0ru06uNRvDNonuU2Fmh6Nu+IhkOrx7tBlo
 fQK8v0RwlEhM6KAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=D164y3Bt;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="pS6/8v3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737370163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JNpRm/Mbu4P2bE9GDlYRRYu9Qc6P24KCcaABaNWGcFg=;
 b=D164y3BtJHxOVQf4/U9R+Iz3qkZ7fd+mHAyPt7JiA5sEMEzLE5fafH1xyNWAm5RSHNW7nh
 2XSe7AE/QO1zJGHeihNuOjvVl2J7CfGnXCMwBSbZaCWixuNahl9FvUONlyuKRCcQAdNx+G
 cEsamffvR6PrPLP1wFF7k3h/Hv6CM2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737370163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JNpRm/Mbu4P2bE9GDlYRRYu9Qc6P24KCcaABaNWGcFg=;
 b=pS6/8v3SsPqAu8vP08MQ7BrMvqQGQqeh6SQy0ru06uNRvDNonuU2Fmh6Nu+IhkOrx7tBlo
 fQK8v0RwlEhM6KAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09487139CB;
 Mon, 20 Jan 2025 10:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iC/+ATMqjmcIJgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Mon, 20 Jan 2025 10:49:23 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Jan 2025 11:49:09 +0100
Message-ID: <20250120104911.39566-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1EC761F7B2
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cgroup_core02: Allocate child stack using mmap()
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
Acked-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---

Changes since v1: Added #define for stack size

I've also verified that the CVE is still reproducible on affected kernels
with this test fix.

 testcases/kernel/controllers/cgroup/cgroup_core02.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcases/kernel/controllers/cgroup/cgroup_core02.c
index 733e88ee7..b19bf2e58 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core02.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
@@ -32,6 +32,8 @@
 #include "tst_safe_file_at.h"
 #include "lapi/sched.h"
 
+#define STACK_SIZE 65536
+
 static struct tst_cg_group *cg_child_a, *cg_child_b;
 static uid_t nobody_uid;
 
@@ -51,7 +53,7 @@ static int lesser_ns_open_thread_fn(void *arg)
 static void test_lesser_ns_open(void)
 {
 	int i;
-	static char stack[65536];
+	char *stack;
 	pid_t pid;
 	int status;
 	struct lesser_ns_open_thread_arg targ = { .fds = {0}, .loops = -1};
@@ -63,14 +65,19 @@ static void test_lesser_ns_open(void)
 		SAFE_CG_PRINT(cg_child_a, "cgroup.procs", "0");
 		SAFE_CG_FCHOWN(cg_child_a, "cgroup.procs",  nobody_uid, -1);
 		SAFE_CG_FCHOWN(cg_child_b, "cgroup.procs",  nobody_uid, -1);
+		stack = SAFE_MMAP(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
 		pid  = ltp_clone(CLONE_NEWCGROUP | CLONE_FILES | CLONE_VM | SIGCHLD,
-					lesser_ns_open_thread_fn, &targ, 65536, stack);
+					lesser_ns_open_thread_fn, &targ, STACK_SIZE, stack);
+
 		if (pid < 0)  {
 			tst_res(TFAIL, "unexpected negative pid %d", pid);
 			exit(1);
 		}
 
 		SAFE_WAITPID(pid, &status, 0);
+		SAFE_MUNMAP(stack, STACK_SIZE);
+
 		for (i = 0; i < targ.loops; i++) {
 			if (targ.fds[i] < 1) {
 				tst_res(TFAIL, "unexpected negative fd %d", targ.fds[i]);
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
