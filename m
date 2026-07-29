Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4B3C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 09:19:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B19B3E4D48
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 11:19:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96B4D3E4B10
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:17:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AEE751400997
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:17:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 289AE3E06;
 Wed, 29 Jul 2026 09:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785316658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSCaY8ZYodtEmp6+IFaTnmJjtpBgyZARmaYBiI2ZYiM=;
 b=Zi1NlqjHehyI6iqFrlro1mVxRlAUih5K0DaEz0tIt6tuTeQBt+xcDtGo70TCpvedo4Tc8z
 FSUlqf9zep8mLoG5TXJ/QnIU6f/UYw+MF6QlCnokGaonOBP6N23vobk56wwFoANM1C0YQ2
 vmjzpmppr3gQWg1icFu65zS12TrQrn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785316658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSCaY8ZYodtEmp6+IFaTnmJjtpBgyZARmaYBiI2ZYiM=;
 b=JhPzQGwROyF/jNFsNuYsJunjvBqhG8iFzzlQtCnjVGp5X5b1VItKz5TbUxxhBp70IGyXJO
 cZ6RBPjgxZcWPCAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PGJp2iNc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=G5aKmkgK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785316654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSCaY8ZYodtEmp6+IFaTnmJjtpBgyZARmaYBiI2ZYiM=;
 b=PGJp2iNcWuiPlUTETGco2MrlMcmKezS2VoyHd2DKpYvJ/1aK/AObLJ27/WwJgDw5hBidKd
 +r4DDsLmSrIMdJPIeUAi08BEaXpbAEvZc8NaoZ2yRSK7yEAfYgnL0bWKctqDFHpWNot0ra
 eCiHOO5RIXlkdsJok9DAFp17T3Fpejs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785316654;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSCaY8ZYodtEmp6+IFaTnmJjtpBgyZARmaYBiI2ZYiM=;
 b=G5aKmkgKpo/l8DQ5lL659WdLGZg0DtOAwRC1EpK4l1LGOu/VEXMJ4DNr32N5oeMeTNLdSD
 v0Oo94d98Le7ZmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F057779BF;
 Wed, 29 Jul 2026 09:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mOfBHSnFaWpYfgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Jul 2026 09:17:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 11:17:17 +0200
Message-ID: <20260729091717.23042-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729091717.23042-1-pvorel@suse.cz>
References: <20260729091717.23042-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 289AE3E06
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[suse.cz,suse.com,gmail.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] fanotify20: Skip on v7.2
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
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

fanotify_init() used to reject FAN_REPORT_PIDFD combined with
FAN_REPORT_TID with EINVAL. Since Linux v7.2, fanotify supports
reporting pidfds for thread IDs, so this combination is expected to
succeed.

The test that these flag combinations are allowed:
                FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID),
		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_FID |
			   FAN_REPORT_DFID_NAME),

Because the above flag combinations are already "tested" by the tests
that use them and we don't have any tests that >= 5.10 has support for
FAN_MARK_FILESYSTEM etc just simply skip the test on v7.2.

Reported-by: AnonymeMeow <anonymemeow@gmail.com>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Replacement of:
https://patchwork.ozlabs.org/project/ltp/patch/20260616210448.12175-2-anonymemeow@gmail.com/
based on
https://lore.kernel.org/ltp/CAOQ4uxhnrH3=XsCBhuO3oYtS=pZcRjkAchtrVwtnfJzBVmpNfQ@mail.gmail.com/

 testcases/kernel/syscalls/fanotify/fanotify20.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index b32ecf6aa3..dfcf194755 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -15,6 +15,9 @@
  *
  * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
  * af579beb666a ("fanotify: add pidfd support to the fanotify API").
+ *
+ * NOTE: since v7.2, fanotify supports reporting pidfds for thread IDs => skip
+ * the test.
  */
 
 #define _GNU_SOURCE
@@ -75,6 +78,7 @@ static void do_cleanup(void)
 
 static struct tst_test test = {
 	.setup = do_setup,
+	.max_kver = "7.2",
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
 	.cleanup = do_cleanup,
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
