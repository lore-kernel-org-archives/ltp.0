Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00406C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 07:56:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 936963E26B6
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 09:56:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27DF83E2699
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:55:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9762D1A00A5E
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:55:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 31BC876396;
 Fri, 10 Jul 2026 07:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783670155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sfqPtw4WNChf2XL99vtcP1tVWWCF8E4IIxs/NaOGX1A=;
 b=HO5o6w+YgbQIMqEingic3aXUnWqKGgmW7SF9rr4oONTy7QHAPk9xdvnfzTg36R5qEtECa5
 pI4xxw2GLOD88bN1OUsbldo48qOGir56Ff68xNIjDtnFWCb9R0qAIjE5y9IWlELdWIdTl7
 TvcH0DeCAaqQzLnn8V2AbhUnx4VddWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783670155;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sfqPtw4WNChf2XL99vtcP1tVWWCF8E4IIxs/NaOGX1A=;
 b=PBvjfnbFQVCFdmFABK6O8PcydnX/2D0QB5yhixU3WtJobfckDwwxsBLho4N0BfPJvHKuaA
 5Dtqd8L4Qf74gFAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783670155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sfqPtw4WNChf2XL99vtcP1tVWWCF8E4IIxs/NaOGX1A=;
 b=HO5o6w+YgbQIMqEingic3aXUnWqKGgmW7SF9rr4oONTy7QHAPk9xdvnfzTg36R5qEtECa5
 pI4xxw2GLOD88bN1OUsbldo48qOGir56Ff68xNIjDtnFWCb9R0qAIjE5y9IWlELdWIdTl7
 TvcH0DeCAaqQzLnn8V2AbhUnx4VddWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783670155;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sfqPtw4WNChf2XL99vtcP1tVWWCF8E4IIxs/NaOGX1A=;
 b=PBvjfnbFQVCFdmFABK6O8PcydnX/2D0QB5yhixU3WtJobfckDwwxsBLho4N0BfPJvHKuaA
 5Dtqd8L4Qf74gFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8BE4779BE;
 Fri, 10 Jul 2026 07:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S496MoqlUGo9QQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 07:55:54 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 09:55:48 +0200
Message-ID: <20260710075548.1167519-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_test.sh: Remove LTP_ERR string from error
 message
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

It's not an error, but it can be confusing for a reviewer.

Fixes: c4b0907760 ("lib/tst_test.sh: add TST_RTNL_CHK() helper function")
Reported-by: Avinesh Kumar <avinesh.kumar@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8701bb3903..b3e7e29bbf 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -274,6 +274,7 @@ TST_RTNL_CHK()
 	local msg match
 
 	echo "$output" | grep -q "LTP_ERR" || return 0
+	output=$(echo "$output" | sed 's/LTP_ERR$//')
 
 	for msg in "$msg1" "$msg2" "$msg3" "$msg4"; do
 		match=$(echo "$output" | grep "$msg") && \
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
