Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04400C3DA59
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 14:30:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 971F63D1BE7
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 16:30:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7D613D0BC9
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 16:29:26 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3B4E9601400
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 16:29:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A1C621BB1;
 Mon, 22 Jul 2024 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721658565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l096ivDghQE0tjwZMlVJ9zBIef6OTR4H412lcYeZCSs=;
 b=w9jE8OMo/JHDYQ4BQpRMFdqoP8SAc8iga2ZuBCR+Rtwcozs0cHylzUR26HTIk4uBpTbIv3
 QiaaucsnbXJ5QF/G37I14SXd9onYuZPpP4KZzt2Srhr290YmE5AU59a1xWIvYlYTCTJx4o
 NmBGbgNkr5yqUT/Y0ADG1H1DJIBIGng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721658565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l096ivDghQE0tjwZMlVJ9zBIef6OTR4H412lcYeZCSs=;
 b=kSUhHlRuf5czjiiNh9I/BeleVKQL5Fg3oeCc1IPBuMEVyYx8oiBEk05ThMJYDWhsuIfP0H
 j8VZ4V+VHSvrLjDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w9jE8OMo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kSUhHlRu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721658565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l096ivDghQE0tjwZMlVJ9zBIef6OTR4H412lcYeZCSs=;
 b=w9jE8OMo/JHDYQ4BQpRMFdqoP8SAc8iga2ZuBCR+Rtwcozs0cHylzUR26HTIk4uBpTbIv3
 QiaaucsnbXJ5QF/G37I14SXd9onYuZPpP4KZzt2Srhr290YmE5AU59a1xWIvYlYTCTJx4o
 NmBGbgNkr5yqUT/Y0ADG1H1DJIBIGng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721658565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l096ivDghQE0tjwZMlVJ9zBIef6OTR4H412lcYeZCSs=;
 b=kSUhHlRuf5czjiiNh9I/BeleVKQL5Fg3oeCc1IPBuMEVyYx8oiBEk05ThMJYDWhsuIfP0H
 j8VZ4V+VHSvrLjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C4A2136A9;
 Mon, 22 Jul 2024 14:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uGP9BMVsnmazSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 22 Jul 2024 14:29:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 22 Jul 2024 16:28:44 +0200
MIME-Version: 1.0
Message-Id: <20240722-cachestat-v3-5-a0386f7cdaaa@suse.com>
References: <20240722-cachestat-v3-0-a0386f7cdaaa@suse.com>
In-Reply-To: <20240722-cachestat-v3-0-a0386f7cdaaa@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=UMbXZ66TkrbxH1wHz02kyAue2T5gN+71SHqJibR5aGY=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmnmyv0tuiObZlpUxZcBUUpOQ2WMDnKDCnxvlYp
 8Kkm7m3YGyJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp5srwAKCRDLzBqyILPm
 RnePC/9F+SjoFLb3cTIVdNfJgiyEFKleZ/a2WNnJ0VU7s06FyMJ05GXEGLmoLRmmAcj7jg66nmq
 pwl38GAK0OX75EU7lA4ZNfduaiQg9v/09IbKRSjXd0pEFYzMnaFeZ/1A43acFU7xtLE98gLUH0C
 tUvns9uM7xqo6M/EG72BeBYiKNxAo34qMEdje8E4P8EBTqOm0gObkZ6cFNNES0DInaJx+lbVmIS
 zN/zz2Z6BCq3Tmx2Ql+Gw3x4T3hgYu1I1PEyx4I5zTO5olHDCMzij6zdSid0OjD2pi7jLMDuKop
 f44ITNuAMEDJtyrb/etX13nbnKBa6cI84dYL2QGypYesc8uZuSD7Y7VHK3+10xQXUQA1oKukZdE
 To8U/NcD0+kkV+7YTssfuoBDNJwPugQ68QyOpKm5+tJbf5dGbeMaNB+0nIh9A4Qu70syAGUyJOn
 mp7/YNIgWWi5gC8slZkpELT+wpNcq6h1h7YZTXAdWUpNj3X4Mivl/pn/ekUyntqscpnDY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3A1C621BB1
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/5] Add cachestat04 test
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

This test verifies cachestat() for all possible file descriptors,
checking that returned statistics are always zero, unless file
descriptor is unsupported and EBADF is raised.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/cachestat/.gitignore    |  1 +
 testcases/kernel/syscalls/cachestat/cachestat04.c | 58 +++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 8a297429b..9b041b03d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -65,6 +65,7 @@ cacheflush01 cacheflush01
 cachestat01 cachestat01
 cachestat02 cachestat02
 cachestat03 cachestat03
+cachestat04 cachestat04
 
 chdir01 chdir01
 chdir01A symlink01 -T chdir01
diff --git a/testcases/kernel/syscalls/cachestat/.gitignore b/testcases/kernel/syscalls/cachestat/.gitignore
index 6cfa3fa10..a3611a533 100644
--- a/testcases/kernel/syscalls/cachestat/.gitignore
+++ b/testcases/kernel/syscalls/cachestat/.gitignore
@@ -1,3 +1,4 @@
 cachestat01
 cachestat02
 cachestat03
+cachestat04
diff --git a/testcases/kernel/syscalls/cachestat/cachestat04.c b/testcases/kernel/syscalls/cachestat/cachestat04.c
new file mode 100644
index 000000000..0913dd57a
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/cachestat04.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies cachestat() for all the possible file descriptors,
+ * checking that cache statistics are always zero, except for unsupported file
+ * descriptors which cause EBADF to be raised.
+ */
+
+#include "tst_test.h"
+#include "lapi/mman.h"
+
+#define MNTPOINT "mnt"
+
+static struct cachestat *cs;
+static struct cachestat_range *cs_range;
+
+static void check_cachestat(struct tst_fd *fd_in)
+{
+	int ret;
+
+	ret = cachestat(fd_in->fd, cs_range, cs, 0);
+	if (ret == -1) {
+		TST_EXP_EQ_LI(errno, EBADF);
+		return;
+	}
+
+	TST_EXP_EQ_LI(cs->nr_cache, 0);
+	TST_EXP_EQ_LI(cs->nr_dirty, 0);
+	TST_EXP_EQ_LI(cs->nr_writeback, 0);
+	TST_EXP_EQ_LI(cs->nr_evicted, 0);
+	TST_EXP_EQ_LI(cs->nr_recently_evicted, 0);
+}
+
+static void run(void)
+{
+	TST_FD_FOREACH(fd) {
+		tst_res(TINFO, "%s -> ...", tst_fd_desc(&fd));
+		check_cachestat(&fd);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "6.5",
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.bufs = (struct tst_buffers []) {
+		{&cs, .size = sizeof(struct cachestat)},
+		{&cs_range, .size = sizeof(struct cachestat_range)},
+		{}
+	},
+};
+

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
