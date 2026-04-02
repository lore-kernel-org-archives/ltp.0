Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F44D39418
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:17:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FF083E2F43
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:17:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A3CB3E2F43
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B1D8F1A00269
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2F494D333
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H6FSSqEtqJORvWuqjCQvwHyAD52EOQ8RsEV0eL7ZBgg=;
 b=B5Co+hy/Zuxu4UmQM02zawaQ3wj+Bk/kmfOwisWVgmYNLFOfsUXbv5dNG6Bd5AKjBGJ7Zc
 qp4VwkuSHl5bkhsfgWJZ3jseYnmHwB/L1YRmUj2w7ZmyzM3YwtIa7FBekxPlzaf9qOIDlx
 mgEoUdI3fGNjHAMxmGsXXFDdw81Rzf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H6FSSqEtqJORvWuqjCQvwHyAD52EOQ8RsEV0eL7ZBgg=;
 b=vDNcpaPGJyw6HBFQa/UbmLDkvTmyHM2kxo/0LyyYSGbVL14wennufT2j5iBYEeui0XTnk3
 1hahIOHBkDzirjDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="B5Co+hy/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vDNcpaPG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H6FSSqEtqJORvWuqjCQvwHyAD52EOQ8RsEV0eL7ZBgg=;
 b=B5Co+hy/Zuxu4UmQM02zawaQ3wj+Bk/kmfOwisWVgmYNLFOfsUXbv5dNG6Bd5AKjBGJ7Zc
 qp4VwkuSHl5bkhsfgWJZ3jseYnmHwB/L1YRmUj2w7ZmyzM3YwtIa7FBekxPlzaf9qOIDlx
 mgEoUdI3fGNjHAMxmGsXXFDdw81Rzf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H6FSSqEtqJORvWuqjCQvwHyAD52EOQ8RsEV0eL7ZBgg=;
 b=vDNcpaPGJyw6HBFQa/UbmLDkvTmyHM2kxo/0LyyYSGbVL14wennufT2j5iBYEeui0XTnk3
 1hahIOHBkDzirjDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4D8D4A0B0
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vxqgL5RdzmnODgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:14:12 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:51 +0200
Message-ID: <20260402121356.31266-13-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402121356.31266-1-chrubis@suse.cz>
References: <20260402121356.31266-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:mid, suse.cz:email]
X-Rspamd-Queue-Id: D2F494D333
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 12/17] cve: tcindex01: Switch from needs_drivers to
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
 testcases/cve/tcindex01.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
index 370d7de49..478d75055 100644
--- a/testcases/cve/tcindex01.c
+++ b/testcases/cve/tcindex01.c
@@ -145,16 +145,13 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		"CONFIG_NET_SCH_HTB",
 		"CONFIG_NET_CLS_TCINDEX",
+		"CONFIG_DUMMY",
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
-	.needs_drivers = (const char *const []) {
-		"dummy",
-		NULL
-	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "8c710f75256b"},
 		{"CVE", "2023-1829"},
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
