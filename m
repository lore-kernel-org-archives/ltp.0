Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AD9C3DA63
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 17:59:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ED903D1BEE
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 19:59:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1E6C3D1BF3
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:59:10 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4C42F2009A3
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:59:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1DC4C21C46;
 Tue, 23 Jul 2024 17:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721757549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wn4AUPCAINYbsjPHwo3Kzubjli8gEifZ3rcwEBGawAs=;
 b=CemunyZWEZdqPUbivbO+7liHr7iTIKUxVR4odF5IiVS2Sg3wYahvVN5xoTVhSqCHOP7AID
 eMAON0Dx/rmvijiSCzzCf4de7pNlJ3mCi9nE4E+9NqF2dH3lUvXg+LaVtMecHk9ahI5Oeg
 uJeHMA1OjryB2p08XXG0R1ubz2uEr78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721757549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wn4AUPCAINYbsjPHwo3Kzubjli8gEifZ3rcwEBGawAs=;
 b=vteC1fTRyJq6Uoi+HVUPMcNrwa+vVqsNzLzYdRAvxdJXjpDZjbZiEFg59ugBvUrtEhedfH
 KsHwHmQFcvZeHsAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CemunyZW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vteC1fTR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721757549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wn4AUPCAINYbsjPHwo3Kzubjli8gEifZ3rcwEBGawAs=;
 b=CemunyZWEZdqPUbivbO+7liHr7iTIKUxVR4odF5IiVS2Sg3wYahvVN5xoTVhSqCHOP7AID
 eMAON0Dx/rmvijiSCzzCf4de7pNlJ3mCi9nE4E+9NqF2dH3lUvXg+LaVtMecHk9ahI5Oeg
 uJeHMA1OjryB2p08XXG0R1ubz2uEr78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721757549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wn4AUPCAINYbsjPHwo3Kzubjli8gEifZ3rcwEBGawAs=;
 b=vteC1fTRyJq6Uoi+HVUPMcNrwa+vVqsNzLzYdRAvxdJXjpDZjbZiEFg59ugBvUrtEhedfH
 KsHwHmQFcvZeHsAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5F941377F;
 Tue, 23 Jul 2024 17:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4DrGMlTvn2aMEgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 17:58:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 17:41:05 +0200
MIME-Version: 1.0
Message-Id: <20240723-fchmodat2-v2-3-e658a98b113e@suse.com>
References: <20240723-fchmodat2-v2-0-e658a98b113e@suse.com>
In-Reply-To: <20240723-fchmodat2-v2-0-e658a98b113e@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=798;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=coG/Sr6m6VtDhSTp55MPcNGf3m9wsY63eAFVUcXpPYE=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn+9XkrYAcxs+cvr1roZ7WepVwea9lMLRZ1eVg
 EKELuhr+gKJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp/vVwAKCRDLzBqyILPm
 RuruC/9IMplNNuFbFmIuVhcePOaF0DzgdM5BzCq4MwsA0ISwf+nVx3LZ7o+AOcXLHv1pKHwX27N
 J8uILovmwG8eVw1bry69LAyd4FOvJS1AetJJtaSrCDawx2CRDLzRUvI2jAXPiLmeUU/w5MW31np
 aZPXUaSI2KdCMewCQLL1tsV8AU3JScWiGJRTLtT/45nr46Lfz/XiKJutR+tXmLaby7yhIHQLcNX
 eHxotaYklIZ941uNElMBEm1Sp26ZUMrL6dA+H5oxraLOmB0+gPksY8TV9LHHJI0OtcDVtcsuPCa
 ft+afDqfMx9ZkOexNnNtlgdtk684vqBdVoPO/qPoiF/2JvQJ6UMa2uVgESrWlFnAvTL9uIbC9bt
 T9v+OY7CVeYRYjptUrRz8KWAmhRRB/tZ/9unyYeNU77HNR7PEYP4yVmwgbowdwbzyZ7Mwy8eFGy
 zUwXjxhzpB+q5geo9EATf74YLXHbTtn5DadfQkrWCADe3THnOIm6QPpVOkw8EMpiBpNCM=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.31 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1DC4C21C46
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] Add fchmodat2 fallback definition
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/stat.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 3606c9eb0..5e289d3ca 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -229,4 +229,17 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_ATTR_VERITY	0x00100000
 #endif
 
+static inline int fchmodat2(
+	int dfd, const char *filename, mode_t mode, int flags)
+{
+	int ret;
+
+	ret = tst_syscall(__NR_fchmodat2, dfd, filename, mode, flags);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "%s(%d,%s,%d,%d) error",
+			__func__, dfd, filename, mode, flags);
+
+	return ret;
+}
+
 #endif /* LAPI_STAT_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
