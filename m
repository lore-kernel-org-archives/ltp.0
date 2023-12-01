Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C02C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 14:26:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8131D3CE9F4
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 15:26:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2F733CD4D4
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 15:26:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE0DA1BB99B5
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 15:26:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9AB3C1FD68
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701440792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YITKVD2p6Yl0HuIRhIM8gvN6Wffvyn8X83A9MMwyS5o=;
 b=VOuL/aWYLYh5Gq1HR7hDa5gYMVwRX+FkNLud0ZkzfEyVxCs04h9hN54mR6fbYEPMhiTzEx
 VPL6UiJ+AcMvce2NjLEZKzX3SJQf/yKcFh61YEnd77Qb/qc8uTs1m4/c+Nl7n+pj/bvOXc
 NLY8JFyhmaGvvAa/ws4idGn/cWyFS1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701440792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YITKVD2p6Yl0HuIRhIM8gvN6Wffvyn8X83A9MMwyS5o=;
 b=1bLyPTnUy6Ugr3ay3qqNuKwLPTXxKkILIfa/drbCn/OW5Oz6LRaAOjz5ydJRhCqj6xHXMO
 s3PqLHLWBFX2mKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AC561379A
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 14:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M7SSGxjtaWWLMAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 01 Dec 2023 14:26:32 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  1 Dec 2023 15:26:30 +0100
Message-ID: <20231201142631.17332-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [10.40 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_COUNT_THREE(0.00)[3]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_SPAM_LONG(3.45)[0.986]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 NEURAL_SPAM_SHORT(2.05)[0.684];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pty04: Check for ioctl(TIOCVHANGUP) support
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

TIOCVHANGUP support in 32bit compat mode ioctl() was added in kernel
v4.20. The syscall will fail on earlier kernels with ENOTTY.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/pty/pty04.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index 8c7b1bf92..204703253 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
@@ -93,6 +93,19 @@ static struct ldisc_info ldiscs[] = {
 
 static int ptmx = -1, pts = -1, sk = -1, mtu, no_check;
 
+static void setup(void)
+{
+	int fd = SAFE_OPEN("/dev/ptmx", O_RDWR);
+
+	TEST(ioctl(fd, TIOCVHANGUP));
+	SAFE_CLOSE(fd);
+
+	if (TST_RET && TST_ERR == ENOTTY)
+		tst_brk(TCONF | TTERRNO, "ioctl(TIOCVHANGUP) not supported");
+	else if (TST_RET)
+		tst_brk(TBROK | TTERRNO, "ioctl(TIOCVHANGUP) failed");
+}
+
 static int set_ldisc(int tty, const struct ldisc_info *ldisc)
 {
 	TEST(ioctl(tty, TIOCSETD, &ldisc->n));
@@ -467,6 +480,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.setup = setup,
 	.test = do_test,
 	.cleanup = cleanup,
 	.tcnt = 2,
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
