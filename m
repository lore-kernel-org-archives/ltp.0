Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04F8C47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 10:01:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 922193CB75C
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 11:01:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC8593CB75C
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:00:22 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8BC5514098B0
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:00:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B1A5B1FB6F;
 Wed, 31 Jan 2024 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706695220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=st3ef76f+/HbO8AiZCj1NzXDh4pFePZWQ92Jnhn/SFU=;
 b=ppU89sl++Zsd3foJj6tpAv+LtA2aJy+vQy2zyVhl2L3BX6rshQliNS+hbVcsIiyswiEciy
 dZDFmiM+qJVJ8V0CPgzgXLAVdG2uplxWmvo6O/J06aYkN7rcPREBYAByhqTOd2tG76eFMz
 O2FXO3Ls7tcosOk0xLCiMqrLgopXB1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706695220;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=st3ef76f+/HbO8AiZCj1NzXDh4pFePZWQ92Jnhn/SFU=;
 b=ylzmFOt4rKZwdGaKOt3gzAC1Z87Wxw/XbMo4IT4Qm0gbfKwJMSTZwSZI22ns+aMV5ML3eU
 paq7laf5ClfKI0Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706695220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=st3ef76f+/HbO8AiZCj1NzXDh4pFePZWQ92Jnhn/SFU=;
 b=ppU89sl++Zsd3foJj6tpAv+LtA2aJy+vQy2zyVhl2L3BX6rshQliNS+hbVcsIiyswiEciy
 dZDFmiM+qJVJ8V0CPgzgXLAVdG2uplxWmvo6O/J06aYkN7rcPREBYAByhqTOd2tG76eFMz
 O2FXO3Ls7tcosOk0xLCiMqrLgopXB1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706695220;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=st3ef76f+/HbO8AiZCj1NzXDh4pFePZWQ92Jnhn/SFU=;
 b=ylzmFOt4rKZwdGaKOt3gzAC1Z87Wxw/XbMo4IT4Qm0gbfKwJMSTZwSZI22ns+aMV5ML3eU
 paq7laf5ClfKI0Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82A4F1347F;
 Wed, 31 Jan 2024 10:00:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kMRRHTQaumVPWAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 31 Jan 2024 10:00:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 11:00:18 +0100
Message-Id: <20240131100018.15767-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240131100018.15767-1-andrea.cervesato@suse.de>
References: <20240131100018.15767-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ppU89sl+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ylzmFOt4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: B1A5B1FB6F
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] Increase default appends operations in
 dio_append
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

This test is currently ending quite fast on regular systems, so we
increase the number of operations in order to have bigger chances to
find bugs.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/io/ltp-aiodio/dio_append.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index 057ae73d9..0ecb76e2f 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -33,7 +33,7 @@ static void setup(void)
 {
 	numchildren = 16;
 	writesize = 64 * 1024;
-	appends = 1000;
+	appends = 10000;
 
 	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
@@ -44,6 +44,9 @@ static void setup(void)
 	if (tst_parse_int(str_appends, &appends, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid number of appends '%s'", str_appends);
 
+	if (!tst_fs_has_free(".", appends, writesize))
+		tst_brk(TCONF, "Not enough space to run the test");
+
 	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 }
 
@@ -97,7 +100,7 @@ static struct tst_test test = {
 	.options = (struct tst_option[]) {
 		{"n:", &str_numchildren, "Number of processes (default 16)"},
 		{"w:", &str_writesize, "Write size for each append (default 64K)"},
-		{"c:", &str_appends, "Number of appends (default 1000)"},
+		{"c:", &str_appends, "Number of appends (default 10000)"},
 		{}
 	},
 	.skip_filesystems = (const char *[]) {
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
