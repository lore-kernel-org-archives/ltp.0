Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC77C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 09:59:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A13613E6861
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 11:59:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 367473E4EE3
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:58:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 051802001AC
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:58:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0166A7CA1D;
 Wed, 29 Jul 2026 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785319078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSfCZJ/OcaKL2tyKAj7PA4JQvJ7U5Oj9NLHfJOL9Bn0=;
 b=XT61nHvEh8HOaK5QaK3MmISAySOdeTsPYH0+PbivTvtNszqG6EO9BU7IVS90efy5gx0ei+
 4WQ+1gLkbuCSsxu+fCX5tqVC5gyWfRkWalg/NMrDGY8FkXTVDeP7XKhRlOSyQscchk3qSp
 CNfCNqXt7muw4L3wucwIRraj4a3Kjd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785319078;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSfCZJ/OcaKL2tyKAj7PA4JQvJ7U5Oj9NLHfJOL9Bn0=;
 b=PRsIuCmawWSGujcEPBxBJa3rHq0DCiYkDQ2zgKvmI2j6nC/+JIorCxqdkF9m0meVda0Pc8
 qGPeAaSftGW6mlDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=op7xrY56;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zstxqM5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785319074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSfCZJ/OcaKL2tyKAj7PA4JQvJ7U5Oj9NLHfJOL9Bn0=;
 b=op7xrY56Z7JHVE3GvJjiF9u12vQBfJ46DzeQloMa+P3ZhayvUSaY1YZhffn140aDfib/xB
 b7z76USXQNP6zEhkWhe6UkyjDY1IAK56qW10DQswN1y+od1UBPALr2JELS1tKCRd/2l/sD
 IByL1k3sWBoD/YJvFE1qc0o08x4jfUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785319074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSfCZJ/OcaKL2tyKAj7PA4JQvJ7U5Oj9NLHfJOL9Bn0=;
 b=zstxqM5BB8ZpZwPvwFY7BUIZbHNC5k9SucFnLnoA5JZu8wxhUwehytg6gUex9wwcksJVkB
 KZFHwOks8TJH9rAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC530779B7;
 Wed, 29 Jul 2026 09:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qElzLKHOaWrTJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Jul 2026 09:57:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 11:57:28 +0200
Message-ID: <20260729095730.29185-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729095730.29185-1-pvorel@suse.cz>
References: <20260729095730.29185-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0166A7CA1D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] execve04: Use .max_kver
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
Changes v1->v2:
* Fixed version 6.11 => 6.10

 testcases/kernel/syscalls/execve/execve04.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
index 35ec882a07..6f06a4a4cc 100644
--- a/testcases/kernel/syscalls/execve/execve04.c
+++ b/testcases/kernel/syscalls/execve/execve04.c
@@ -11,6 +11,9 @@
 /*\
  * Attempt to :manpage:`execve(2)` a file which is being opened by another process for
  * writing fails with ETXTBSY.
+ *
+ * NOTE: write to executed file is allowed since 6.11-rc1:
+ * 2a010c412853 ("fs: don't block i_writecount during exec")
  */
 
 #define _GNU_SOURCE
@@ -62,19 +65,10 @@ static void do_child(void)
 	exit(0);
 }
 
-static void setup(void)
-{
-	if ((tst_kvercmp(6, 11, 0)) >= 0) {
-		tst_brk(TCONF, "Skipping test, write to executed file is "
-			"allowed since 6.11-rc1.\n"
-			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
-	}
-}
-
 static struct tst_test test = {
-	.setup = setup,
 	.test_all = verify_execve,
 	.forks_child = 1,
+	.max_kver = "6.10",
 	.child_needs_reinit = 1,
 	.needs_checkpoints = 1,
 	.resource_files = (const char *const []) {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
