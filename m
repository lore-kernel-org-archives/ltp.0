Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E256EC04FFE
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 19:48:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DC773C8868
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 21:48:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DE4F3C0326
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 21:48:24 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9272C20096D
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 21:48:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DDC9C1F749
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714420102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iVGe9HHRfqgwks8g7CwMb9/Omruf/jmOaswDuJQL6Pc=;
 b=buHlfJIOuRXjhnaOzNUXz/drkUIUm9hTkS9AncOWZS85mFHJmFCcA45G54PWhd7hy9uYrK
 9G398zlS0SmOwpeQDbXXt0uWbQHDYFvIvlNRnLEd7/Q4xWQnNrMjvYowU2oXFFJ6GzWOgH
 RedtHGcOuqWtlHkUtV3r1hBoYwbMTMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714420102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iVGe9HHRfqgwks8g7CwMb9/Omruf/jmOaswDuJQL6Pc=;
 b=yVXVNVI0A+Rpk5Yv5SVUJyvG9IOwnwGF3cjL6wIf+Jesqe04h3EVxjcVRTpFTtseMFHH4X
 t4OR9JqXS55WxXBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yTdrP2ZX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kpcWL52V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714420101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iVGe9HHRfqgwks8g7CwMb9/Omruf/jmOaswDuJQL6Pc=;
 b=yTdrP2ZXy0YWa4t5NFIN0FdTjqcZifZlrakf7liPRlyp8zHUO4F6TRmXyULj92Reb4ZvO+
 7nreJJ0MZnB9SrMAgkz/eJB9UBG1guqzeCBMb/r0GX7Ja++49df5aftYSw/blRlypG+cHN
 7y+l5OIkmnngcQsMIU+Y/PXlgk7FNB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714420101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iVGe9HHRfqgwks8g7CwMb9/Omruf/jmOaswDuJQL6Pc=;
 b=kpcWL52V5tx3LR2fCQW4xYHCcLtvxxTzVQf5cm8fOL1L4GqIl+Vuw16HKgFm+uUfiwuwn5
 k09rY+Qc+ryYRYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8CDC139DE
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 19:48:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gO/AMIX5L2b9bwAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 19:48:21 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 29 Apr 2024 21:48:20 +0200
Message-ID: <20240429194821.9112-1-akumar@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DDC9C1F749
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/mmap08: Use macro TST_EXP_FAIL_PTR_VOID()
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/mmap/mmap08.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap08.c b/testcases/kernel/syscalls/mmap/mmap08.c
index 5c9fd782c..befd73e14 100644
--- a/testcases/kernel/syscalls/mmap/mmap08.c
+++ b/testcases/kernel/syscalls/mmap/mmap08.c
@@ -27,16 +27,7 @@ static void setup(void)
 
 static void run(void)
 {
-	TESTPTR(mmap(NULL, page_sz, PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0));
-
-	if (TST_RET_PTR != MAP_FAILED) {
-		tst_res(TFAIL, "mmap() passed unexpectedly");
-		SAFE_MUNMAP(TST_RET_PTR, page_sz);
-	} else if (TST_ERR == EBADF) {
-		tst_res(TPASS, "mmap() failed with EBADF");
-	} else {
-		tst_res(TFAIL | TERRNO, "mmap() failed with an invalid errno");
-	}
+	TST_EXP_FAIL_PTR_VOID(mmap(NULL, page_sz, PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0), EBADF);
 }
 
 static void cleanup(void)
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
