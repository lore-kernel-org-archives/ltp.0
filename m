Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCD6D3941A
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:19:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C32D43E2F46
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:19:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D1D23E2F46
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A65D51A00CCE
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 18AF65BDC8
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wl9AUEb96pe0NCHypm4Z7xNHHfIseK6RpwZzLS3gaxc=;
 b=2oE1wASiyGS1GbHWPXltyXLebMhSM5IYhxeyCE7b49DW/RTjsTdhd+7E2bW+gibXerzNjL
 aPhUC/oh9VBxaO8odDW9wLFIvSTUkLYm8RJtPvV0KA4uO4fgjnJLzSCOQvA9qwprxRJfsp
 LsXwQETcy5jJDjpOkOHDbmGRcKOGef0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wl9AUEb96pe0NCHypm4Z7xNHHfIseK6RpwZzLS3gaxc=;
 b=I/TlX0CEZ5w2YTWhqtjP0NJZZ/5KrSmOnEi3cVFu18k/0QItenrZ89W02dfAtHepMbII6Z
 YPhvyMEEwWM8CAAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wl9AUEb96pe0NCHypm4Z7xNHHfIseK6RpwZzLS3gaxc=;
 b=2oE1wASiyGS1GbHWPXltyXLebMhSM5IYhxeyCE7b49DW/RTjsTdhd+7E2bW+gibXerzNjL
 aPhUC/oh9VBxaO8odDW9wLFIvSTUkLYm8RJtPvV0KA4uO4fgjnJLzSCOQvA9qwprxRJfsp
 LsXwQETcy5jJDjpOkOHDbmGRcKOGef0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wl9AUEb96pe0NCHypm4Z7xNHHfIseK6RpwZzLS3gaxc=;
 b=I/TlX0CEZ5w2YTWhqtjP0NJZZ/5KrSmOnEi3cVFu18k/0QItenrZ89W02dfAtHepMbII6Z
 YPhvyMEEwWM8CAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 091094A0B0
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y2hcAZpdzmnfDgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:14:18 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:54 +0200
Message-ID: <20260402121356.31266-16-chrubis@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 15/17] sctp: Switch from needs_drivers to
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
 utils/sctp/func_tests/test_1_to_1_initmsg_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/sctp/func_tests/test_1_to_1_initmsg_connect.c b/utils/sctp/func_tests/test_1_to_1_initmsg_connect.c
index 98013cd30..c9c3c1c30 100644
--- a/utils/sctp/func_tests/test_1_to_1_initmsg_connect.c
+++ b/utils/sctp/func_tests/test_1_to_1_initmsg_connect.c
@@ -110,8 +110,8 @@ static void test_sctp(unsigned int n)
 static struct tst_test test = {
 	.test = test_sctp,
 	.tcnt = ARRAY_SIZE(testcase_list),
-	.needs_drivers = (const char *[]) {
-		"sctp",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_IP_SCTP",
 		NULL
 	},
 };
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
