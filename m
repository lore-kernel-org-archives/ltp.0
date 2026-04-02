Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBFAD39418
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:17:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AD5E3E2A16
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:17:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBF723E2F43
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 762D2601B05
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 971275BDB1
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=diLZQuuWtHIYV7T8lxkHyMfdEY45pXSYrSaXgzOLBY4=;
 b=zyUGwmE6ULeY4pKmdorTe1yimtIrUpp6SZZR/S7jvvO5VOItF0p8S4J+EuQmOmUlgmfApK
 OxCYfDkOJ8cniRkm+wjYU2udC42Fb2HbRA/4YWAcQruKTY2Lvkdko4kwhATCZBKhhClN8A
 SHdJrUme6mjh/iaZHp1oxxkBvTVVVZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=diLZQuuWtHIYV7T8lxkHyMfdEY45pXSYrSaXgzOLBY4=;
 b=K+GBPUVnnHuEarBHoG6HIcmwnf3vHImvJYvHo5FQrgQLh1PpUr6VTf6I4mHjiQnxbw1hLX
 4IKUGUG1fs1witDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=diLZQuuWtHIYV7T8lxkHyMfdEY45pXSYrSaXgzOLBY4=;
 b=qxsS6zRHgy2EqIHYobziiwLBYi/NNbzf66aMpjot4l0TngooqC1hPbSa+hPUQdpfWPx4Kg
 HVFIdM/ACOJ5SWmMbdcaq0AX+63IqQd6DImGLLZrxe3VcefGgXClT7KZGQLJ+r2skaVbo9
 1OmQltaheECUyEO1fqvszbxwMuxyBqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=diLZQuuWtHIYV7T8lxkHyMfdEY45pXSYrSaXgzOLBY4=;
 b=cdgvfYksWuN1kEGYOX0pCsjFUUF1ghY2ZarZRGeNguk7BaBie5+siAqkK1QOKRENgdHPA7
 az4Q2F/IrzHRvhDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 891314A0B1
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I/+JIJNdzmnBDgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:14:11 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:48 +0200
Message-ID: <20260402121356.31266-10-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402121356.31266-1-chrubis@suse.cz>
References: <20260402121356.31266-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 09/17] tests: madvise11: Switch from needs_drivers to
 needs_kconfigs
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise11.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 73d2d4294..97d2b851e 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -417,10 +417,6 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_drivers = (const char *const []) {
-		HW_MODULE,
-		NULL
-	},
 	.needs_cmds = (struct tst_cmd[]) {
 		{.cmd = "modprobe"},
 		{.cmd = "rmmod"},
@@ -428,6 +424,7 @@ static struct tst_test test = {
 	},
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_MEMORY_FAILURE=y",
+		"CONFIG_HWPOISON_INJECT",
 		NULL
 	},
 	.runtime = 30,
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
