Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C094C433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 15:17:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 666683C6FD5
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 16:17:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05AF73C6FD8
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 16:16:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 978AF2009F0
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 16:16:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B81951F381
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646839012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eSAcUrTFzU0SIkWpui22dZYdp8Afs/NTw0gu6HdOSg0=;
 b=AV8728hE0l9g91FUDoqan4YGpI6+dIT4m78pNA/pcNzE/6FYH4uCheRlqspUZ8f81bl/m2
 f/Fa5nrXEcwudq/JSj1juBIfJMqpKCAHQDuBKKBRsP/J6EiIt/lnn+284UsyPJzS24C6NZ
 cH58fbwkhDgJ0R9CtXdp61miME8iBb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646839012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eSAcUrTFzU0SIkWpui22dZYdp8Afs/NTw0gu6HdOSg0=;
 b=Ga8Gitiupr2J2po/rNWZMu4tfxLwpistwJIDwDGYm5TYKLPxwXDcXPBTeF+CHKXoXbQ2ZA
 GnsibEee0h9Eg+BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99C1713D7C
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 15:16:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +APtI+TEKGL6VwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 09 Mar 2022 15:16:52 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  9 Mar 2022 16:19:11 +0100
Message-Id: <20220309151911.27164-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] [PATCH] syscalls/getcontext01: Increase the test
 coverage
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

Acutally use the structure initialized by the getcontext to jump back in
the process execution flow.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/getcontext/getcontext01.c  | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/getcontext/getcontext01.c b/testcases/kernel/syscalls/getcontext/getcontext01.c
index 7176a9035..5896c3800 100644
--- a/testcases/kernel/syscalls/getcontext/getcontext01.c
+++ b/testcases/kernel/syscalls/getcontext/getcontext01.c
@@ -8,7 +8,9 @@
 /*\
  * [Description]
  *
- * Test getting user context functionality.
+ * Basic test for getcontext().
+ *
+ * Calls a getcontext() then jumps back with a setcontext().
  */
 
 #include "config.h"
@@ -18,11 +20,23 @@
 
 #include <ucontext.h>
 
+static volatile int flag;
+
 static void run(void)
 {
 	ucontext_t ptr;
 
-	TST_EXP_PASS(getcontext(&ptr));
+	flag = 0;
+
+	TST_EXP_PASS(getcontext(&ptr), "getcontext() flag=%i", flag);
+
+	if (flag)
+		return;
+
+	flag = 1;
+	setcontext(&ptr);
+
+	tst_res(TFAIL, "setcontext() did return");
 }
 
 static struct tst_test test = {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
