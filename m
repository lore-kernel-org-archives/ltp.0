Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B181C88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:05:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 315943E8C45
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:05:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C9B53E7FAA
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 64EE51A000A2
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 389491F394;
 Wed, 16 Sep 2026 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWF4YxrRtoFwUJDL53/wPKWTF3jFs04lIUU+/P/S5iw=;
 b=WATZ/Z601s7Ce42jz9VLYb/zoo4x1v1wKx7YADiCUlkzB/ie8T1+Gn6O45YCIZDPeI2Yi7
 4tzNa89dXwL9h2VyA33bbwyes6cnGUGY/c9TSqnVLBQWsy/lkxTlEWpKuLBMHniSJIky4j
 CgBOXuq8zo+pxI4TnZATvfhPUCNhEHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWF4YxrRtoFwUJDL53/wPKWTF3jFs04lIUU+/P/S5iw=;
 b=U4ORoNavombqMlL6YzXZAep7JKsZJM8TC+0kqlCQAUCiE2nhquic4tkh9UkGRZWesfi+Z9
 SJUKKHNsUVz9zPBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VurOSz2U;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VNPJRhDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWF4YxrRtoFwUJDL53/wPKWTF3jFs04lIUU+/P/S5iw=;
 b=VurOSz2UfwaMPS+epWs8R4kLwen+1VDTCTd8g6udqIiJZUbmRfG6tj3whLk+Pwm5YEkoEM
 HAEj3X84YA2Q1jFQlo7RZ9hAY3x2iJ5jjB+89QAFtH1NXtgHdz5ldNIFCv4KKCaL8WsGMS
 MWYMAyY+IT0KxuvQ+LoHMyDf97Kkehc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWF4YxrRtoFwUJDL53/wPKWTF3jFs04lIUU+/P/S5iw=;
 b=VNPJRhDFzUWiaSMhOOMpbWzP1tccdK+SB+8zcDR5JMIDOM8iUqKfM98xWzTF/2hsici4go
 zILs4dA/HB7qiXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAD4E1374A;
 Wed, 16 Sep 2026 14:04:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T4
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:10 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:29 +0200
Message-ID: <20260916140402.1797325-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 389491F394
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 03/36] tree: keyctl: Use SAFE_ADD_KEY()
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/cve/cve-2016-7042.c                      |  4 +---
 testcases/kernel/syscalls/add_key/add_key03.c      |  9 ++-------
 testcases/kernel/syscalls/add_key/add_key04.c      | 14 ++++----------
 testcases/kernel/syscalls/keyctl/keyctl02.c        |  8 ++------
 testcases/kernel/syscalls/keyctl/keyctl03.c        |  4 +---
 testcases/kernel/syscalls/keyctl/keyctl06.c        |  6 ++----
 .../kernel/syscalls/request_key/request_key01.c    |  4 +---
 .../kernel/syscalls/request_key/request_key02.c    |  4 +---
 testcases/kernel/watchqueue/common.h               |  4 +---
 9 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/testcases/cve/cve-2016-7042.c b/testcases/cve/cve-2016-7042.c
index 24915ad441..0556789d61 100644
--- a/testcases/cve/cve-2016-7042.c
+++ b/testcases/cve/cve-2016-7042.c
@@ -25,9 +25,7 @@ static void do_test(void)
 {
 	char buf[BUFSIZ];
 
-	key = add_key("user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
-	if (key == -1)
-		tst_brk(TBROK, "Failed to add key");
+	key = SAFE_ADD_KEY("user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
 
 	if (keyctl(KEYCTL_UPDATE, key, "b", 1))
 		tst_brk(TBROK, "Failed to update key");
diff --git a/testcases/kernel/syscalls/add_key/add_key03.c b/testcases/kernel/syscalls/add_key/add_key03.c
index fe2406fcc2..4b0e49127e 100644
--- a/testcases/kernel/syscalls/add_key/add_key03.c
+++ b/testcases/kernel/syscalls/add_key/add_key03.c
@@ -24,13 +24,8 @@
 
 static key_serial_t create_keyring(const char *description)
 {
-	TEST(add_key("keyring", description, NULL, 0,
-		     KEY_SPEC_PROCESS_KEYRING));
-	if (TST_RET < 0) {
-		tst_brk(TBROK | TTERRNO,
-			"unable to create keyring '%s'", description);
-	}
-	return TST_RET;
+	return SAFE_ADD_KEY("keyring", description, NULL, 0,
+		     KEY_SPEC_PROCESS_KEYRING);
 }
 
 static key_serial_t get_keyring_id(key_serial_t special_id)
diff --git a/testcases/kernel/syscalls/add_key/add_key04.c b/testcases/kernel/syscalls/add_key/add_key04.c
index 3fbb52479b..ff0895efd1 100644
--- a/testcases/kernel/syscalls/add_key/add_key04.c
+++ b/testcases/kernel/syscalls/add_key/add_key04.c
@@ -50,18 +50,12 @@ static void do_test(void)
 
 		for (i = 0; i < ASSOC_ARRAY_FAN_OUT; i++) {
 			sprintf(description, "keyring%d", i);
-			TEST(add_key("keyring", description, NULL, 0,
-				     KEY_SPEC_SESSION_KEYRING));
-			if (TST_RET < 0) {
-				tst_brk(TBROK | TTERRNO,
-					"unable to create keyring %d", i);
-			}
+			SAFE_ADD_KEY("keyring", description, NULL, 0,
+				     KEY_SPEC_SESSION_KEYRING);
 		}
 
-		TEST(add_key("user", "userkey", payload, sizeof(PAYLOAD),
-			     KEY_SPEC_SESSION_KEYRING));
-		if (TST_RET < 0)
-			tst_brk(TBROK | TTERRNO, "unable to create user key");
+		SAFE_ADD_KEY("user", "userkey", payload, sizeof(PAYLOAD),
+			     KEY_SPEC_SESSION_KEYRING);
 
 		exit(0);
 	}
diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index 306181c44a..964dfad316 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -61,10 +61,8 @@ static void do_test(void)
 	pthread_t pth[4];
 
 	for (i = 0; i < LOOPS; i++) {
-		key = add_key("user", "ltptestkey", "foo", 3,
+		key = SAFE_ADD_KEY("user", "ltptestkey", "foo", 3,
 			KEY_SPEC_PROCESS_KEYRING);
-		if (key == -1)
-			tst_brk(TBROK | TERRNO, "Failed to add key");
 
 		SAFE_PTHREAD_CREATE(&pth[0], NULL, do_read,
 			(void *)(unsigned long)key);
@@ -103,10 +101,8 @@ static void do_test(void)
 	 *
 	 * We create extra key here, to remove reference to last revoked key.
 	 */
-	key_inv = add_key("user", "ltptestkey", "foo", 3,
+	key_inv = SAFE_ADD_KEY("user", "ltptestkey", "foo", 3,
 		KEY_SPEC_PROCESS_KEYRING);
-	if (key_inv == -1)
-		tst_brk(TBROK | TERRNO, "Failed to add key");
 
 	/*
 	 * If we have invalidate, we can drop extra key immediately as well,
diff --git a/testcases/kernel/syscalls/keyctl/keyctl03.c b/testcases/kernel/syscalls/keyctl/keyctl03.c
index 676dddcd0b..d5339cb43d 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl03.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl03.c
@@ -20,9 +20,7 @@ static void do_test(void)
 {
 	key_serial_t key;
 
-	key = add_key("user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
-	if (key == -1)
-		tst_brk(TBROK, "Failed to add key");
+	key = SAFE_ADD_KEY("user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
 
 	request_key("keyring", "foo", "bar", KEY_SPEC_THREAD_KEYRING);
 
diff --git a/testcases/kernel/syscalls/keyctl/keyctl06.c b/testcases/kernel/syscalls/keyctl/keyctl06.c
index b3c61b9d15..e3fdbcb841 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl06.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl06.c
@@ -21,10 +21,8 @@
 
 static void add_test_key(const char *description)
 {
-	TEST(add_key("user", description, "payload", 7,
-		     KEY_SPEC_PROCESS_KEYRING));
-	if (TST_RET < 0)
-		tst_brk(TBROK | TTERRNO, "Failed to add test key");
+	SAFE_ADD_KEY("user", description, "payload", 7,
+		     KEY_SPEC_PROCESS_KEYRING);
 }
 
 static void do_test(void)
diff --git a/testcases/kernel/syscalls/request_key/request_key01.c b/testcases/kernel/syscalls/request_key/request_key01.c
index 97121533da..0aa5fd85f7 100644
--- a/testcases/kernel/syscalls/request_key/request_key01.c
+++ b/testcases/kernel/syscalls/request_key/request_key01.c
@@ -35,9 +35,7 @@ static void verify_request_key(void)
 
 static void setup(void)
 {
-	key = add_key("keyring", "ltp", NULL, 0, KEY_SPEC_THREAD_KEYRING);
-	if (key == -1)
-		tst_brk(TBROK | TERRNO, "add_key() failed");
+	key = SAFE_ADD_KEY("keyring", "ltp", NULL, 0, KEY_SPEC_THREAD_KEYRING);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/request_key/request_key02.c b/testcases/kernel/syscalls/request_key/request_key02.c
index 2d35aceeee..d7e0664e68 100644
--- a/testcases/kernel/syscalls/request_key/request_key02.c
+++ b/testcases/kernel/syscalls/request_key/request_key02.c
@@ -48,9 +48,7 @@ static int init_key(char *name, int cmd)
 	int n;
 	int sec = 1;
 
-	n = add_key("keyring", name, NULL, 0, KEY_SPEC_THREAD_KEYRING);
-	if (n == -1)
-		tst_brk(TBROK | TERRNO, "add_key() failed");
+	n = SAFE_ADD_KEY("keyring", name, NULL, 0, KEY_SPEC_THREAD_KEYRING);
 
 	if (cmd == KEYCTL_REVOKE) {
 		if (keyctl(cmd, n) == -1)
diff --git a/testcases/kernel/watchqueue/common.h b/testcases/kernel/watchqueue/common.h
index 0921dce9a6..639dd4a7cd 100644
--- a/testcases/kernel/watchqueue/common.h
+++ b/testcases/kernel/watchqueue/common.h
@@ -81,9 +81,7 @@ static inline key_serial_t wqueue_add_key(int fd)
 {
 	key_serial_t key;
 
-	key = add_key("user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
-	if (key == -1)
-		tst_brk(TBROK, "add_key error: %s", tst_strerrno(errno));
+	key = SAFE_ADD_KEY("user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
 
 	SAFE_KEYCTL(KEYCTL_WATCH_KEY, key, fd, 0x01, 0);
 	SAFE_KEYCTL(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, 0x02, 0);
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
