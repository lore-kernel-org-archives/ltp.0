Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80C4C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 17:57:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C9A33D3864
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 19:57:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 447A83D3818
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:57:01 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A5490204B42
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:57:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F2DB21BEF;
 Wed, 10 Jul 2024 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LL3MUfjhU5KoBwQO1eFr+3tB6DL+se9OifpN+0svvkw=;
 b=yqhvXD70r4lk/skaL8X/YPhDRUj9rYynhUrY1Nu/j9+Wt2qeKoPf0404w+TAJK18Wt39rz
 20nVXhD6sSsC9pGjK9TDPdaBSfC6/r4ErcexRrKZx7mdhI2oPF+IPQIYaOXa9250opYR3N
 WvZaJQJ+NS9ax6gQsiqJSE1Ng6dFVs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LL3MUfjhU5KoBwQO1eFr+3tB6DL+se9OifpN+0svvkw=;
 b=gk6wvU8fa3PJRuzwPo42VuxNO0P7hPOCG8G/2B2TOGtMwz1GuKTwbQ4skAdFj1HtRKBhT9
 5jrHFFmK/8LVuDBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LL3MUfjhU5KoBwQO1eFr+3tB6DL+se9OifpN+0svvkw=;
 b=yqhvXD70r4lk/skaL8X/YPhDRUj9rYynhUrY1Nu/j9+Wt2qeKoPf0404w+TAJK18Wt39rz
 20nVXhD6sSsC9pGjK9TDPdaBSfC6/r4ErcexRrKZx7mdhI2oPF+IPQIYaOXa9250opYR3N
 WvZaJQJ+NS9ax6gQsiqJSE1Ng6dFVs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LL3MUfjhU5KoBwQO1eFr+3tB6DL+se9OifpN+0svvkw=;
 b=gk6wvU8fa3PJRuzwPo42VuxNO0P7hPOCG8G/2B2TOGtMwz1GuKTwbQ4skAdFj1HtRKBhT9
 5jrHFFmK/8LVuDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78D3013942;
 Wed, 10 Jul 2024 17:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YM4tHGvLjmaZegAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 17:56:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 19:56:42 +0200
MIME-Version: 1.0
Message-Id: <20240710-landlock-v2-4-478d8c2f6bab@suse.com>
References: <20240710-landlock-v2-0-478d8c2f6bab@suse.com>
In-Reply-To: <20240710-landlock-v2-0-478d8c2f6bab@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=763;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=4dBf0txYyHkxBTNlYjHZpRF7TwNuDuKi/1tKq5F+cQ4=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjsteVb5BhMOk18r60EqarBNDSMR2e5+9M3sc7
 ubu4Q2+KlCJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7LXgAKCRDLzBqyILPm
 RlmNDACSCcPdKSzd83odMf34t0rjWpY03ojsUSrg3iGXbdOKaJVxJWFWQtr/teafL6m5zfJ8Lp+
 4zRgngxi3EBJ9M9lvAGd+NERulWkwa41llzj2hGBBVUwUEo5U5Fed5AaSbtPn8wjydcXcYsbKS0
 9NTjUTTsNEq7G2pY8Y1ptqC30xIfOSGllTO69kFIeNGsrZmsVNfCGEK3q4hkc3aoX+MaG2kSyOB
 M+J6GS3Il4HwUmNd4HXk2/TsoubHsbSyw4QRRQ1cMCkVB4tSB61+CjfaLaRs9vCqZBtAr7/GV15
 GU8mtECn8Ct1jCN5p16naJ9tik0sOA/rdMYeHZWqzrbz5qe5JA4120Q6k+oSqia5LeZ9DDdFg+4
 m2vl+J+5YBo37OI/5Y6imBTRNoQv0kTp6xq2BmgxGjhRsKyF0w4pxHv5h7T87CSjOYykSxmymwv
 zy3aXLe8ZKRA/0cWwE/bfVSbZmnYjXuNh8LxezToblP4+wyxONKJV2s8ViPxSdprhHEqA=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/7] Add CAP_MKNOD fallback in lapi/capability.h
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
 include/lapi/capability.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 2b593797c..0f317d6d7 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -44,14 +44,18 @@
 # define CAP_SYS_TIME         25
 #endif
 
-#ifndef CAP_AUDIT_READ
-# define CAP_AUDIT_READ       37
-#endif
-
 #ifndef CAP_SYS_RESOURCE
 # define CAP_SYS_RESOURCE     24
 #endif
 
+#ifndef CAP_MKNOD
+# define CAP_MKNOD            27
+#endif
+
+#ifndef CAP_AUDIT_READ
+# define CAP_AUDIT_READ       37
+#endif
+
 #ifndef CAP_BPF
 # define CAP_BPF              39
 #endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
