Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89D6C25B75
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 13:32:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 419A93D0187
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 15:32:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38F013CB744
 for <ltp@lists.linux.it>; Thu, 23 May 2024 15:32:21 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1973B600C7A
 for <ltp@lists.linux.it>; Thu, 23 May 2024 15:32:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE8E822790
 for <ltp@lists.linux.it>; Thu, 23 May 2024 13:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716471140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JFq3ODNl3H5H0B9fNRLCPUFEZjqtV26aZjigtkRT1YM=;
 b=rtRj536ZC+7dGHfzzTMBFNZ+gc0O/DPm/1/2LB+hRJb/HzJSofHcSPiwmh1fpaOx7DaEhz
 mSEwZTa6OBbLaRGWi1Bcwol+YgNM0wG7+smWsg6e3X+1m2LlmUJkgzwKyfKyZAMUuTgVC6
 N783THRu/zvQ688pqTbFqVcHsGaT1Ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716471140;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JFq3ODNl3H5H0B9fNRLCPUFEZjqtV26aZjigtkRT1YM=;
 b=YEVE07KwMCn5lcaKD/tMJSTP1jlLVqHLAz6L6zwohp3HS/oUzUx8NB+f8CmcYMI46692vk
 hkiAP6LmvQ52pzBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="oL5BP8/e";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a3Z7D2Cj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716471139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JFq3ODNl3H5H0B9fNRLCPUFEZjqtV26aZjigtkRT1YM=;
 b=oL5BP8/eMZ4SfAP7dn7+UqqexcxtqioP/A0t/c6BotkaPFlQzJKzsVkJy3xG3OIHvq59ZQ
 HeumphxpZAqZG1j1RyRlzaSNxu9ygIS3aabXGtZXToWOfZXi2tu0DvOQAmEwMUen1gRoqM
 7HRJtYKzU+98fjoeGYC06v0q1ex0Ans=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716471139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JFq3ODNl3H5H0B9fNRLCPUFEZjqtV26aZjigtkRT1YM=;
 b=a3Z7D2CjIWWPKrMMByDS3No94h11ulbHM8Zrlq97n3Y0C4W5aEKqbUTlGb1+SDGxPaS/6u
 hOCt+kILcNcpVoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDC6813A6C
 for <ltp@lists.linux.it>; Thu, 23 May 2024 13:32:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HQZGLWNFT2bmCQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 May 2024 13:32:19 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 May 2024 15:31:31 +0200
Message-ID: <20240523133132.13978-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240523133132.13978-1-chrubis@suse.cz>
References: <20240523133132.13978-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CE8E822790
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/msgstress01: Fix the stop logic
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

The stop flag didn't really work because:

- if queue is full msgsnd() will block in the kernel
- if queue is empty msgrcv() will block in the kernel

And if the other process from the reader-writer pair exits the queue
will be never changed and the test will get stuck and killed by watchdog
timer.

What we need to do is to use IPC_NOWAIT, retry manually (after short
usleep) and handle errors manually as well. In that case no processes
will sleep in kernel and setting the stop flag will actually stop the
test.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../syscalls/ipc/msgstress/msgstress01.c      | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 5c84957b3..62ffcf63b 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -101,8 +101,17 @@ static void writer(const int id, const int pos)
 	struct sysv_data *buff = &ipc_data[pos];
 	int iter = num_iterations;
 
-	while (--iter >= 0 && !(*stop))
-		SAFE_MSGSND(id, &buff->msg, 100, 0);
+	while (--iter >= 0 && !(*stop)) {
+		int size = msgsnd(id, &buff->msg, 100, IPC_NOWAIT);
+		if (size < 0) {
+			if (errno == EAGAIN) {
+				usleep(10);
+				continue;
+			}
+
+			tst_brk(TBROK | TERRNO, "msgsnd() failed");
+		}
+	}
 }
 
 static void reader(const int id, const int pos)
@@ -115,7 +124,15 @@ static void reader(const int id, const int pos)
 	while (--iter >= 0 && !(*stop)) {
 		memset(&msg_recv, 0, sizeof(struct sysv_msg));
 
-		size = SAFE_MSGRCV(id, &msg_recv, 100, MSGTYPE, 0);
+		size = msgrcv(id, &msg_recv, 100, MSGTYPE, IPC_NOWAIT);
+		if (size < 0) {
+			if (errno == ENOMSG) {
+				usleep(10);
+				continue;
+			}
+
+			tst_brk(TBROK | TERRNO, "msgrcv() failed");
+		}
 
 		if (msg_recv.type != buff->msg.type) {
 			tst_res(TFAIL, "Received the wrong message type");
-- 
2.43.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
