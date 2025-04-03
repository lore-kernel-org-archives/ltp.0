Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ED3C3600C
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 10:20:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 550213CB276
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 12:20:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BC173CB287
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 12:19:24 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 939FE140032F
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 12:19:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E7A01F390;
 Thu,  3 Apr 2025 10:19:19 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 214B31392A;
 Thu,  3 Apr 2025 10:19:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4PYIB6dg7mcUAgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Apr 2025 10:19:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  3 Apr 2025 12:19:12 +0200
Message-ID: <20250403101912.459507-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403101912.459507-1-pvorel@suse.cz>
References: <20250403101912.459507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4E7A01F390
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 2/2] runtest: Move ipc into syscalls
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

It's not worth to keep separate runtest file for 8 very quick tests.
syscalls-ipc would be obvious runtest to move, but it contains tests for
message queues, semaphores etc. Other IPC tests are in syscalls runtest,
therefore move tests there.

Remove test description (can be visible from help and the test output,
it was also below the test not above).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/ipc      | 28 ----------------------------
 runtest/syscalls |  9 +++++++++
 2 files changed, 9 insertions(+), 28 deletions(-)
 delete mode 100644 runtest/ipc

diff --git a/runtest/ipc b/runtest/ipc
deleted file mode 100644
index f5cdea1974..0000000000
--- a/runtest/ipc
+++ /dev/null
@@ -1,28 +0,0 @@
-#DESCRIPTION:Interprocess communication stress
-# These tests use tests/pipeio to put pipes (named or unnamed) through a workout
-#
-pipeio_1 pipeio -T pipeio_1 -c 5 -s 4090 -i 100 -b -f x80
-# spawns 5 children to write 100 chunks of 4090 bytes to a named pipe
-# using blocking I/O
-pipeio_2 pipeio -T pipeio_2 -c 5 -s 4090 -i 100 -f x80
-# spawns 5 children to write 100 chunks of 4090 bytes to a named pipe
-# using non-blocking I/O
-pipeio_3 pipeio -T pipeio_3 -c 5 -s 4090 -i 100 -u -b -f x80
-# spawns 5 children to write 100 chunks of 4090 bytes to an unnamed pipe
-# using blocking I/O
-pipeio_4 pipeio -T pipeio_4 -c 5 -s 4090 -i 100 -u -f x80
-# spawns 5 children to write 100 chunks of 4090 bytes to an unnamed pipe
-# using non-blocking I/O
-pipeio_5 pipeio -T pipeio_5 -c 5 -s 5000 -i 10 -b -f x80
-# spawns 5 children to write 10 chunks of 5000 bytes to a named pipe
-# using blocking I/O
-pipeio_6 pipeio -T pipeio_6 -c 5 -s 5000 -i 10 -b -u -f x80
-# spawns 5 children to write 10 chunks of 5000 bytes to an unnamed pipe
-# using blocking I/O
-pipeio_7 pipeio -T pipeio_7 -c 5 -s 5000 -i 10 -f x80
-# spawns 5 children to write 10 chunks of 5000 bytes to a named pipe
-# using non-blocking I/O
-pipeio_8 pipeio -T pipeio_8 -c 5 -s 5000 -i 10 -u -f x80
-# spawns 5 children to write 10 chunks of 5000 bytes to an unnamed pipe
-# using non-blocking I/O
-
diff --git a/runtest/syscalls b/runtest/syscalls
index 05b3e0d376..b911aba7b6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1047,6 +1047,15 @@ pipe2_01 pipe2_01
 pipe2_02 pipe2_02
 pipe2_04 pipe2_04
 
+pipeio_1 pipeio -T pipeio_1 -c 5 -s 4090 -i 100 -b -f x80
+pipeio_2 pipeio -T pipeio_2 -c 5 -s 4090 -i 100 -f x80
+pipeio_3 pipeio -T pipeio_3 -c 5 -s 4090 -i 100 -u -b -f x80
+pipeio_4 pipeio -T pipeio_4 -c 5 -s 4090 -i 100 -u -f x80
+pipeio_5 pipeio -T pipeio_5 -c 5 -s 5000 -i 10 -b -f x80
+pipeio_6 pipeio -T pipeio_6 -c 5 -s 5000 -i 10 -b -u -f x80
+pipeio_7 pipeio -T pipeio_7 -c 5 -s 5000 -i 10 -f x80
+pipeio_8 pipeio -T pipeio_8 -c 5 -s 5000 -i 10 -u -f x80
+
 pivot_root01 pivot_root01
 
 poll01 poll01
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
