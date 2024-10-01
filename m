Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22689CEACD5
	for <ltp@archiver.kernel.org>; Tue,  1 Oct 2024 15:20:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87C543C5974
	for <ltp@archiver.kernel.org>; Tue,  1 Oct 2024 17:20:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED1F93C57A3
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 17:20:20 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E56021000B26
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 17:20:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E74B121998
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727796019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PRy98IpTrMC7zy9PMiFI3RRmtBEb/bKoyPdcSA5IFlM=;
 b=ausnuF/NhQiV+JOHaXZotc1eEGD8/unXo3B+TCAEXVY/7qaQEY8KgmIm0VJQi8BNIj18SN
 hQQa+GYbVUIGrxI0uRnextjsIMHBxw/JkbKq/Cx1OgfS3cxWFsmGVkF/KhmEkL0BfWFJqC
 3qRoG2kU6EPMR7PzGJ4qtw3AaV5iL2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727796019;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PRy98IpTrMC7zy9PMiFI3RRmtBEb/bKoyPdcSA5IFlM=;
 b=25pm5QcmUVWTp+ZYBkGEBnHDA+5/xiNkDhvyn0dQwi9q67miM+D8gsnT2CGh2Ztd/iFY3a
 TfXVIvG8MNYIdJDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Jp4wJrlY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=E0tSX01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727796018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PRy98IpTrMC7zy9PMiFI3RRmtBEb/bKoyPdcSA5IFlM=;
 b=Jp4wJrlYqptDRYLup638hgOS7cTS18jHxVw+GWHg9P1PT4K+EuyGYRPMqi3kZeG5AcTBCw
 fR9XTRiVYNv0RrHbM8EAGKqOt9VuzdS+ghrBVjETOvV/uo1SJ22Ofxhn79pmeLYkwBW7r+
 kb2ofGyj5KYe2/Ime+pIGKRBwGvRGsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727796018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PRy98IpTrMC7zy9PMiFI3RRmtBEb/bKoyPdcSA5IFlM=;
 b=E0tSX01eU1h9aYRcSaKpx+EiuV7bU2wnk2KRXJ8lBc4KyaS65y095vYxnLjWgn12XtMep+
 dJ+POh71LU37hyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7CB113A73
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 15:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gzJXMzIT/GYXMgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 01 Oct 2024 15:20:18 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  1 Oct 2024 17:19:18 +0200
Message-ID: <20241001151918.12097-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: E74B121998
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/tst_test.c: Make use of the run_tcase_on_fs()
 return value
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

When the support for per-testcase FS parameters was added the
code that prepares a device along with the fork_testrun() call was put
into a run_tcase_on_fs() function. However by a mistake the return value
from this function wasn't used properly.

The difference is that the test library did exit the whole test if a
single filesystem iteration reported TBROK or an invalid return value.

Without this patch the library carries on even if there was a fatal
problem reported.

Fixes: cce6188916b9 ('lib: tst_test: Add per filesystem mkfs and mount opts')
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index d226157e0..ae3fc4084 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1832,7 +1832,7 @@ static int run_tcases_per_fs(void)
 		if (!fs)
 			continue;
 
-		run_tcase_on_fs(fs, filesystems[i]);
+		ret = run_tcase_on_fs(fs, filesystems[i]);
 
 		if (ret == TCONF)
 			continue;
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
