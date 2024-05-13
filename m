Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D696C25B10
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 13:07:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7BA53CF11A
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 15:07:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D60D43C70AC
 for <ltp@lists.linux.it>; Mon, 13 May 2024 15:07:39 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 34C1D600194
 for <ltp@lists.linux.it>; Mon, 13 May 2024 15:07:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0BBC347EE
 for <ltp@lists.linux.it>; Mon, 13 May 2024 13:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715605657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ak6uRses05p4WCazHfsKR5Il5SI57HznALiYdCWS/rc=;
 b=OS0UXicA++CQFwKgvzAfpDTQPW+ChpnKOYzrTRwdiCsakbIPSMbUt2Y+8cdxGQKy7VoIhY
 Ik1Sf2U7mkXh6DdggVycYENA6ZlY/uId5nZkzVjmKNzroPhnsGtU1GmKC5Kb5m4n5voHx5
 wsk6lLuD2x+2x9/+WCJ4xM9PFhahAJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715605657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ak6uRses05p4WCazHfsKR5Il5SI57HznALiYdCWS/rc=;
 b=1lqArI7RYKD76H4xc5Ad8/2KfA3SLDVZxASuhe2HKwVOrJY7218bdzVWyu9327zMUKdgzw
 tpkcBjJeiN+Z70DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OS0UXicA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1lqArI7R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715605657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ak6uRses05p4WCazHfsKR5Il5SI57HznALiYdCWS/rc=;
 b=OS0UXicA++CQFwKgvzAfpDTQPW+ChpnKOYzrTRwdiCsakbIPSMbUt2Y+8cdxGQKy7VoIhY
 Ik1Sf2U7mkXh6DdggVycYENA6ZlY/uId5nZkzVjmKNzroPhnsGtU1GmKC5Kb5m4n5voHx5
 wsk6lLuD2x+2x9/+WCJ4xM9PFhahAJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715605657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ak6uRses05p4WCazHfsKR5Il5SI57HznALiYdCWS/rc=;
 b=1lqArI7RYKD76H4xc5Ad8/2KfA3SLDVZxASuhe2HKwVOrJY7218bdzVWyu9327zMUKdgzw
 tpkcBjJeiN+Z70DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E56E613A52
 for <ltp@lists.linux.it>; Mon, 13 May 2024 13:07:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wPrnN5gQQmYcBAAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 13 May 2024 13:07:36 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 13 May 2024 15:07:35 +0200
Message-ID: <20240513130736.10906-1-akumar@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507165347.GB157588@pevik>
References: <20240507165347.GB157588@pevik>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F0BBC347EE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/mmap06: use macro TST_EXP_FAIL_PTR_VOID()
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
 testcases/kernel/syscalls/mmap/mmap06.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap06.c b/testcases/kernel/syscalls/mmap/mmap06.c
index 615743fa7..c825abf9e 100644
--- a/testcases/kernel/syscalls/mmap/mmap06.c
+++ b/testcases/kernel/syscalls/mmap/mmap06.c
@@ -56,15 +56,10 @@ static void run(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
 
-	TESTPTR(mmap(NULL, tc->length, tc->prot, tc->flags, fd, 0));
+	TST_EXP_FAIL_PTR_VOID(mmap(NULL, tc->length, tc->prot, tc->flags, fd, 0), tc->exp_errno);
 
 	if (TST_RET_PTR != MAP_FAILED) {
-		tst_res(TFAIL, "mmap() was successful unexpectedly");
-		SAFE_MUNMAP(TST_RET_PTR, MMAPSIZE);
-	} else if (TST_ERR == tc->exp_errno) {
-		tst_res(TPASS | TERRNO, "mmap() failed with");
-	} else {
-		tst_res(TFAIL | TERRNO, "mmap() failed unexpectedly");
+		SAFE_MUNMAP(TST_RET_PTR, page_sz);
 	}
 }
 
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
