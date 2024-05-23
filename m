Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91188C25B75
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 13:33:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 918263D0177
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 15:33:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47D363D0187
 for <ltp@lists.linux.it>; Thu, 23 May 2024 15:32:26 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 83C261000C22
 for <ltp@lists.linux.it>; Thu, 23 May 2024 15:32:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C42D2278F
 for <ltp@lists.linux.it>; Thu, 23 May 2024 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716471144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YkOw4uYj6BPVg5WtGppHoHDR8H7AdP1NAksQtSXgiY=;
 b=3b4xgbh3c4+rLa2PBZOGYIemuhQhEThMlXnZmm4cL+6b5AOu0DgkjFdo9/+i0yFm8QVAF2
 jVYL77X1wEvWmxh0LJvybG93xAaOPawxHSTOYZinkYLrXMfxBfDsxhn2my6BrTN2CL1szN
 GDvV8boobm7rfOVGhQVZOVSufCwBibA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716471144;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YkOw4uYj6BPVg5WtGppHoHDR8H7AdP1NAksQtSXgiY=;
 b=FDRaQrTozptzxCwmuzPKiEQ3x8B7j9eZj76AyX9N+EWKe+ilU8QT1VZYC5bzblcKnL62Gi
 CSkBWUgkSCCnI0DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3b4xgbh3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FDRaQrTo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716471144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YkOw4uYj6BPVg5WtGppHoHDR8H7AdP1NAksQtSXgiY=;
 b=3b4xgbh3c4+rLa2PBZOGYIemuhQhEThMlXnZmm4cL+6b5AOu0DgkjFdo9/+i0yFm8QVAF2
 jVYL77X1wEvWmxh0LJvybG93xAaOPawxHSTOYZinkYLrXMfxBfDsxhn2my6BrTN2CL1szN
 GDvV8boobm7rfOVGhQVZOVSufCwBibA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716471144;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YkOw4uYj6BPVg5WtGppHoHDR8H7AdP1NAksQtSXgiY=;
 b=FDRaQrTozptzxCwmuzPKiEQ3x8B7j9eZj76AyX9N+EWKe+ilU8QT1VZYC5bzblcKnL62Gi
 CSkBWUgkSCCnI0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2998C13A6C
 for <ltp@lists.linux.it>; Thu, 23 May 2024 13:32:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 684tCWhFT2ZcCwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 May 2024 13:32:24 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 May 2024 15:31:32 +0200
Message-ID: <20240523133132.13978-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240523133132.13978-1-chrubis@suse.cz>
References: <20240523133132.13978-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3C42D2278F
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
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/msgstress01: Fix timeouts
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

Make the test exit if runtime has been exhausted before we finished the
requested amount of iterations.

For that to happen we let the main test process to loop while checking
the runtime and set the stop flag if runtime was exhausted. We also need
to separte the stop and fail flag and add counter for finished children.

Also if we exhaust our runtime during the initial fork phase we print a
warning, since we hardly did a meaningful testing in that case.

The changes can be tested with -I parameter, e.g. -I 5 should trigger
the TWARN message and you should be able to get the test to stop in the
message sending phase with larger -I value.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../syscalls/ipc/msgstress/msgstress01.c      | 53 ++++++++++++++++---
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 62ffcf63b..fb1d4263d 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -50,6 +50,9 @@ static char *str_num_iterations;
 static int num_messages = 1000;
 static int num_iterations = MAXNREPS;
 static volatile int *stop;
+static volatile int *fail;
+static int *finished;
+static int *flags;
 
 static int get_used_sysvipc(void)
 {
@@ -77,6 +80,10 @@ static void reset_messages(void)
 
 	for (int i = 0; i < num_messages; i++)
 		ipc_data[i].id = -1;
+
+	*stop = 0;
+	*fail = 0;
+	*finished = 0;
 }
 
 static int create_message(const int id)
@@ -112,6 +119,8 @@ static void writer(const int id, const int pos)
 			tst_brk(TBROK | TERRNO, "msgsnd() failed");
 		}
 	}
+
+	tst_atomic_inc(finished);
 }
 
 static void reader(const int id, const int pos)
@@ -138,6 +147,7 @@ static void reader(const int id, const int pos)
 			tst_res(TFAIL, "Received the wrong message type");
 
 			*stop = 1;
+			*fail = 1;
 			return;
 		}
 
@@ -145,6 +155,7 @@ static void reader(const int id, const int pos)
 			tst_res(TFAIL, "Received the wrong message data length");
 
 			*stop = 1;
+			*fail = 1;
 			return;
 		}
 
@@ -155,6 +166,7 @@ static void reader(const int id, const int pos)
 					buff->msg.data.pbytes[i]);
 
 				*stop = 1;
+				*fail = 1;
 				return;
 			}
 		}
@@ -163,6 +175,8 @@ static void reader(const int id, const int pos)
 		tst_res(TDEBUG, "msg_recv.type = %ld", msg_recv.type);
 		tst_res(TDEBUG, "msg_recv.data.len = %d", msg_recv.data.len);
 	}
+
+	tst_atomic_inc(finished);
 }
 
 static void remove_queues(void)
@@ -196,12 +210,37 @@ static void run(void)
 
 		if (*stop)
 			break;
+
+		if (!tst_remaining_runtime()) {
+			tst_res(TWARN, "Out of runtime during forking...");
+			*stop = 1;
+			break;
+		}
+	}
+
+	if (!(*stop))
+		tst_res(TINFO, "All processes running.");
+
+	for (;;) {
+		if (tst_atomic_load(finished) == 2 * num_messages)
+			break;
+
+		if (*stop)
+			break;
+
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "Out of runtime, stopping processes...");
+			*stop = 1;
+			break;
+		}
+
+		sleep(1);
 	}
 
 	tst_reap_children();
 	remove_queues();
 
-	if (!(*stop))
+	if (!(*fail))
 		tst_res(TPASS, "Test passed. All messages have been received");
 }
 
@@ -242,14 +281,16 @@ static void setup(void)
 		MAP_SHARED | MAP_ANONYMOUS,
 		-1, 0);
 
-	stop = SAFE_MMAP(
+	flags = SAFE_MMAP(
 		NULL,
-		sizeof(int),
+		sizeof(int) * 3,
 		PROT_READ | PROT_WRITE,
 		MAP_SHARED | MAP_ANONYMOUS,
 		-1, 0);
 
-	reset_messages();
+	stop = &flags[0];
+	fail = &flags[1];
+	finished = &flags[2];
 }
 
 static void cleanup(void)
@@ -260,7 +301,7 @@ static void cleanup(void)
 	remove_queues();
 
 	SAFE_MUNMAP(ipc_data, sizeof(struct sysv_data) * num_messages);
-	SAFE_MUNMAP((void *)stop, sizeof(int));
+	SAFE_MUNMAP(flags, sizeof(int) * 3);
 }
 
 static struct tst_test test = {
@@ -271,7 +312,7 @@ static struct tst_test test = {
 	.max_runtime = 180,
 	.options = (struct tst_option[]) {
 		{"n:", &str_num_messages, "Number of messages to send (default: 1000)"},
-		{"l:", &str_num_iterations, "Number iterations per message (default: 10000)"},
+		{"l:", &str_num_iterations, "Number iterations per message (default: " TST_TO_STR(MAXNREPS) ")"},
 		{},
 	},
 };
-- 
2.43.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
