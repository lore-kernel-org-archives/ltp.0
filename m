Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B17C52D71
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 09:55:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB2813D20B8
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 11:55:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFD5A3D1F4C
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 11:55:15 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 03F0F208E07
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 11:55:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0AABD21D57;
 Fri,  9 Aug 2024 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723197311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=u34pKH+Qd+OheqSaoMWocoabJXRnBvDe2H7qNWzhilc=;
 b=n3arLDbQJ0JtlYPatQtNPQF4PEpzGSVsf3qonqzfcARMqQOYuek7c4vhj9bybkR8nX/Sl2
 t8zxlCkInE8oueOWj9AHaAs3IVVIUUrSLcDxHgxZAQZSXm2a+6qumESI7ceYSV+yMKGbo8
 I56GIZWbUm6mOWqDXEvOww2VAqB/Zk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723197311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=u34pKH+Qd+OheqSaoMWocoabJXRnBvDe2H7qNWzhilc=;
 b=02ja24CYinfJfs/hnSq7Ln8IDnugXAlqIasDHp6n21bFjUsh0+l3jyzuakKe3GbAAWtvWD
 WV6CzxV/DD/cAKBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YP3XRftF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KFCqviXp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723197310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=u34pKH+Qd+OheqSaoMWocoabJXRnBvDe2H7qNWzhilc=;
 b=YP3XRftFJKG0DnQD1yjqwdCroDQB0w8nVUmqLrjFipOVhdPRr9KJfkqYozD1NeXpmcbji0
 EjSMmugplMpcK/YI0L3Gx/xbxbxKoUcq0yHS5wYeuNKz4VPTT82c/WjMdfM2yJwFmjOglj
 lz8nUNFecZNOAO0cmNzpQGhxLA19S/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723197310;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=u34pKH+Qd+OheqSaoMWocoabJXRnBvDe2H7qNWzhilc=;
 b=KFCqviXpTGNqZDXyhfhjwXEOtjv5ETV6peA3Rgslnc7urisUBJOMwK7/IIU4cq1OJkMvJF
 TAgxHVuzhIj/6mBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4C3B1379A;
 Fri,  9 Aug 2024 09:55:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6MYsLn3ntWYIPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 Aug 2024 09:55:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  9 Aug 2024 11:55:05 +0200
Message-ID: <20240809095505.352377-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0AABD21D57
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] pkey01: Fix TBROK due missing results
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

PKEY_DISABLE_EXECUTE is ppc64le specific test. Due messages being
TINFO test on other archs fails:

    tst_test.c:1498: TBROK: Test 2 haven't reported results!

Changing messages to TCONF. Also exit loop on !execute_supported TCONF
(no need to have 30x TCONF with the same error message, because we have
PKEY_DISABLE_EXECUTE last). The other TCONF (on MAP_HUGETLB) must be
repeated.

Fixes: d2b8a476c2 ("pkey01: Adding test for PKEY_DISABLE_EXECUTE")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Li, all,

if you don't like PKEY_DISABLE_EXECUTE having to be the last, we can
just have 30x TCONF (just to change both TINFO to TCONF). Whatever you prefer.

Kind regards,
Petr

 testcases/kernel/syscalls/pkeys/pkey01.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index e5db2c253c..a4b73c4056 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -51,7 +51,7 @@ static struct tcase {
 } tcases[] = {
 	{PERM_NAME(PKEY_DISABLE_ACCESS)},
 	{PERM_NAME(PKEY_DISABLE_WRITE)},
-	{PERM_NAME(PKEY_DISABLE_EXECUTE)},
+	{PERM_NAME(PKEY_DISABLE_EXECUTE)} /* keep it the last */
 };
 
 static void setup(void)
@@ -155,7 +155,7 @@ static size_t function_size(void (*func)(void))
 	return (size_t)(end - start + 1);
 }
 
-static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
+static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
 {
 	pid_t pid;
 	char *buffer;
@@ -165,13 +165,13 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
 	size_t func_size = 0;
 
 	if (!execute_supported && (tc->access_rights == PKEY_DISABLE_EXECUTE)) {
-		tst_res(TINFO, "skip PKEY_DISABLE_EXECUTE test");
-		return;
+		tst_res(TCONF, "skip PKEY_DISABLE_EXECUTE test");
+		return 1;
 	}
 
 	if (!tst_hugepages && (mpa->flags & MAP_HUGETLB)) {
-		tst_res(TINFO, "Skip test on (%s) buffer", flag_to_str(mpa->flags));
-		return;
+		tst_res(TCONF, "Skip test on (%s) buffer", flag_to_str(mpa->flags));
+		return 0;
 	}
 
 	if (fd == 0)
@@ -253,6 +253,8 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
 
 	if (pkey_free(pkey) == -1)
 		tst_brk(TBROK | TERRNO, "pkey_free failed");
+
+	return 0;
 }
 
 static void verify_pkey(unsigned int i)
@@ -265,7 +267,8 @@ static void verify_pkey(unsigned int i)
 	for (j = 0; j < ARRAY_SIZE(mmap_params); j++) {
 		mpa = &mmap_params[j];
 
-		pkey_test(tc, mpa);
+		if (pkey_test(tc, mpa))
+			break;
 	}
 }
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
