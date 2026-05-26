Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188E8CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 08:35:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4704F3E525E
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 10:35:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BF463E525B
 for <ltp@lists.linux.it>; Tue, 26 May 2026 10:34:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 28A3D10006CD
 for <ltp@lists.linux.it>; Tue, 26 May 2026 10:34:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 34D9975D62
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779784454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7J8Qe6DSmzpRX8nl0nboMOFArUI/7aIES0nIsgZMsU=;
 b=dVdWgyQaWL7/12HCIyz5tzKOPR4p/pmWRIMGT22c/jMY4sHewqpr6pRytUJL6dQz9GLNzF
 6Xkofgt/V1K1Gf1PccxoSdizOrNdLseInhlfrjE9xIi03DTuuiUX2lFEsyts6XoCTQEgDW
 zox5CxFnb9F6e9qo6UfZAQ/hco8Gil8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779784454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7J8Qe6DSmzpRX8nl0nboMOFArUI/7aIES0nIsgZMsU=;
 b=dcpa+ye/Gu4m5LIJ2raFG875dJaDGtdsbI9qDfP1W9a/q6ILiK6S3ZxrH56hXFQnWu4OhR
 JQzZ3lN8rHEOL+CQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dVdWgyQa;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="dcpa+ye/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779784454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7J8Qe6DSmzpRX8nl0nboMOFArUI/7aIES0nIsgZMsU=;
 b=dVdWgyQaWL7/12HCIyz5tzKOPR4p/pmWRIMGT22c/jMY4sHewqpr6pRytUJL6dQz9GLNzF
 6Xkofgt/V1K1Gf1PccxoSdizOrNdLseInhlfrjE9xIi03DTuuiUX2lFEsyts6XoCTQEgDW
 zox5CxFnb9F6e9qo6UfZAQ/hco8Gil8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779784454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7J8Qe6DSmzpRX8nl0nboMOFArUI/7aIES0nIsgZMsU=;
 b=dcpa+ye/Gu4m5LIJ2raFG875dJaDGtdsbI9qDfP1W9a/q6ILiK6S3ZxrH56hXFQnWu4OhR
 JQzZ3lN8rHEOL+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 217125A0F7
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:34:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uc4+BwZbFWo9SwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:34:14 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 10:34:06 +0200
Message-ID: <20260526083406.357092-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526083406.357092-1-chrubis@suse.cz>
References: <20260526083406.357092-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 34D9975D62
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/inotify{07,
 08}: Fix TBROK on older kernels
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

When kernel fails to generate events the read returns EAGAIN and since
we switched to SAFE_READ() the tests now TBROK when kernel does not
generate events. Fix this by passing the newly introduced
SAFE_READ_ANY_EAGAIN flag to the SAFE_READ().

Fixes: deda021818a4 ('inotify: modernize with SAFE_ wrappers')
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify07.c | 2 +-
 testcases/kernel/syscalls/inotify/inotify08.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index b4000f353..9cadbf656 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -88,7 +88,7 @@ void verify_inotify(void)
 	strcpy(event_set[test_cnt].name, FILE_NAME);
 	test_cnt++;
 
-	int len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	int len = SAFE_READ(SAFE_READ_ANY_EAGAIN, fd_notify, event_buf, EVENT_BUF_LEN);
 
 	int i = 0, test_num = 0;
 	while (i < len) {
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index e0837cac3..23d3c5a65 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -86,7 +86,7 @@ void verify_inotify(void)
 	SAFE_TOUCH(OVL_LOWER"/"FILE_NAME, 0644, NULL);
 	SAFE_TOUCH(OVL_UPPER"/"FILE_NAME, 0644, NULL);
 
-	int len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	int len = SAFE_READ(SAFE_READ_ANY_EAGAIN, fd_notify, event_buf, EVENT_BUF_LEN);
 
 	int i = 0, test_num = 0;
 	while (i < len) {
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
