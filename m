Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E244C4452A
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 14:09:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 928493E7B88
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 16:09:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02EAC3C2802
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:09:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5E6D0200242
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:09:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE03A79FB6
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784556565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nFlVaMROujWzEdGb96LCK293AErmhhC2dVzaLdblcAc=;
 b=3ZZmzheATMSfZnuGjK4ljuiCtZVJQfpp3gILoA9pPwXNie18m0sXyFFg2rnCtJFGO3n2cm
 lBxtsAQr2vIeAtsfV8QqMtsfEQpclvDNHCRWZyk/14w8Imf6Q6loQB7GZwIkOZXO34Mntb
 YjIYKJ3LcO6BZ/0cbhD1tiQmLF0MvHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784556565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nFlVaMROujWzEdGb96LCK293AErmhhC2dVzaLdblcAc=;
 b=nJLgGjd1MTjQ4iQGlPUaOHA16Uml/CtqtqNuGW78iu1nEzrA8SpQFVwK7aatkpIIu5rm0V
 D3AzKvM7SYjUA/BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784556565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nFlVaMROujWzEdGb96LCK293AErmhhC2dVzaLdblcAc=;
 b=3ZZmzheATMSfZnuGjK4ljuiCtZVJQfpp3gILoA9pPwXNie18m0sXyFFg2rnCtJFGO3n2cm
 lBxtsAQr2vIeAtsfV8QqMtsfEQpclvDNHCRWZyk/14w8Imf6Q6loQB7GZwIkOZXO34Mntb
 YjIYKJ3LcO6BZ/0cbhD1tiQmLF0MvHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784556565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nFlVaMROujWzEdGb96LCK293AErmhhC2dVzaLdblcAc=;
 b=nJLgGjd1MTjQ4iQGlPUaOHA16Uml/CtqtqNuGW78iu1nEzrA8SpQFVwK7aatkpIIu5rm0V
 D3AzKvM7SYjUA/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94C3E779AA
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 14:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K/N+IxUsXmrWOQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 14:09:25 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Jul 2026 16:09:22 +0200
Message-ID: <20260720140925.86664-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 suse.cz:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setsockopt10: Bind test sockets to any free port
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

The setsockopt10 test currently binds two test sockets to hardcoded port
numbers. This can result in errors due to the ports being already in use.
Bind the sockets to any free ports instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Bug reproducibility verified on affected kernel v5.14. I've also tested
that running multiple iterations of the test works correctly.

 .../kernel/syscalls/setsockopt/setsockopt10.c | 34 ++++++++++++++-----
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt10.c b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
index f955f4e83..76c977d2e 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt10.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
@@ -77,8 +77,8 @@ static int tcp0_sk, tcp1_sk, tcp2_sk, tcp3_sk;
 
 static void setup(void)
 {
-	tst_init_sockaddr_inet(&tcp0_addr, "127.0.0.1", 0x7c90);
-	tst_init_sockaddr_inet(&tcp1_addr, "127.0.0.1", 0x7c91);
+	tst_init_sockaddr_inet(&tcp0_addr, "127.0.0.1", 0);
+	tst_init_sockaddr_inet(&tcp1_addr, "127.0.0.1", 0);
 }
 
 static void cleanup(void)
@@ -95,9 +95,13 @@ static void cleanup(void)
 
 static void child(void)
 {
+	struct sockaddr_storage sockaddr;
+	socklen_t addrlen;
+
+	addrlen = tst_get_connect_address(tcp1_sk, &sockaddr);
+	SAFE_CLOSE(tcp1_sk);
+
 	tst_res(TINFO, "child: Listen for tcp1 connection");
-	tcp0_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
-	SAFE_BIND(tcp0_sk, (struct sockaddr *)&tcp0_addr, sizeof(tcp0_addr));
 	SAFE_LISTEN(tcp0_sk, 1);
 	TST_CHECKPOINT_WAKE(0);
 
@@ -110,7 +114,7 @@ static void child(void)
 	TST_CHECKPOINT_WAIT(2);
 
 	tst_res(TINFO, "child: connect for tcp2 connection");
-	TEST(connect(tcp3_sk, (struct sockaddr *)&tcp1_addr, sizeof(tcp1_addr)));
+	TEST(connect(tcp3_sk, (struct sockaddr *)&sockaddr, addrlen));
 
 	if (TST_RET == -1) {
 		tst_res(TINFO | TTERRNO, "child: could not connect to tcp1");
@@ -122,18 +126,27 @@ static void child(void)
 
 static void run(void)
 {
-	const pid_t child_pid = SAFE_FORK();
+	struct sockaddr_storage sockaddr;
+	socklen_t addrlen;
+	pid_t child_pid;
+
+	tcp0_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+	tcp1_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(tcp0_sk, (struct sockaddr *)&tcp0_addr, sizeof(tcp0_addr));
+	SAFE_BIND(tcp1_sk, (struct sockaddr *)&tcp1_addr, sizeof(tcp1_addr));
+	child_pid = SAFE_FORK();
 
 	if (child_pid == 0) {
 		child();
 		return;
 	}
 
-	tcp1_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+	addrlen = tst_get_connect_address(tcp0_sk, &sockaddr);
+	SAFE_CLOSE(tcp0_sk);
 	TST_CHECKPOINT_WAIT(0);
 
 	tst_res(TINFO, "parent: Connect for tcp0 connection");
-	SAFE_CONNECT(tcp1_sk, (struct sockaddr *)&tcp0_addr, sizeof(tcp0_addr));
+	SAFE_CONNECT(tcp1_sk, (struct sockaddr *)&sockaddr, addrlen);
 	TEST(setsockopt(tcp1_sk, SOL_TCP, TCP_ULP, "tls", 3));
 
 	if (TST_RET == -1 && TST_ERR == ENOENT)
@@ -145,6 +158,7 @@ static void run(void)
 	TST_CHECKPOINT_WAKE(1);
 
 	tst_res(TINFO, "parent: Disconnect by setting unspec address");
+	addrlen = tst_get_connect_address(tcp1_sk, &sockaddr);
 	TEST(connect(tcp1_sk, &unspec_addr, sizeof(unspec_addr)));
 	if (TST_RET == -1) {
 		if (TST_ERR == EOPNOTSUPP)
@@ -155,7 +169,9 @@ static void run(void)
 		tst_reap_children();
 		return;
 	}
-	SAFE_BIND(tcp1_sk, (struct sockaddr *)&tcp1_addr, sizeof(tcp1_addr));
+
+	/* Rebind the same port as before */
+	SAFE_BIND(tcp1_sk, (struct sockaddr *)&sockaddr, addrlen);
 
 	TEST(listen(tcp1_sk, 1));
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
