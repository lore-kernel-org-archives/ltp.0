Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A46C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 09:18:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D3BD3E62F0
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 11:18:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF4BC3E62A1
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:17:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A9FC600746
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:17:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44E013E31;
 Wed, 29 Jul 2026 09:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785316653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIQU+ujYIwHpwKEVIvnS1rubaexYGCygAtOPYUCcgew=;
 b=U445aus0ztntW799XLPM6ZS8CIt5jL0qmA7mIBLPXXe9zwYo+F9ntxRKMWcOjTNFM9ukiW
 iloMnBj9loOke/0CrsojkSPznXBvntG00HiZRnXiswKIljoaGreoicHfCw/Dng3p1IL7w8
 66+kWSmkUoRO/X1gwnTKnGgZN84xMG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785316653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIQU+ujYIwHpwKEVIvnS1rubaexYGCygAtOPYUCcgew=;
 b=z1CtAiVn2FZovwhr7jFhtao8G6CRsIj7wEryLVG3hXMkjm1Es36XWH+L5vLqCeM94XB507
 cbVmds4TBm5h/+Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1kmz9VGn;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KVUcVWFO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785316649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIQU+ujYIwHpwKEVIvnS1rubaexYGCygAtOPYUCcgew=;
 b=1kmz9VGnfIAMOb0kCAdx9KNg93FIbNFl0vNk4+VZDo290Ro7CwBN1c4o5bs3LcBspYD95/
 cUTO8VxfVCjB6MFy5q/GKOHTxhL9Vgu2b2htmrLeK5JfhLNUg+yWZswUTKODypYlpPovBW
 ukU+d9t4UlW7e9V3+cCsRed2MdbzTmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785316649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIQU+ujYIwHpwKEVIvnS1rubaexYGCygAtOPYUCcgew=;
 b=KVUcVWFOtQ1MokWd/77uhsNz9VHdATo7alDkVeFYfwM/mn30FSo8YxyCxsHGygKqOR0Cu2
 iYfRAZ3U4wmzD6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10643779B9;
 Wed, 29 Jul 2026 09:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sD5GAinFaWpYfgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Jul 2026 09:17:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 11:17:15 +0200
Message-ID: <20260729091717.23042-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729091717.23042-1-pvorel@suse.cz>
References: <20260729091717.23042-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 44E013E31
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] execve04: Use .max_kver
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
 testcases/kernel/syscalls/execve/execve04.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
index 35ec882a07..75f1131937 100644
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
+	.max_kver = "6.11",
 	.child_needs_reinit = 1,
 	.needs_checkpoints = 1,
 	.resource_files = (const char *const []) {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
