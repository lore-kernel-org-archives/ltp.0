Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78B5C98302
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 16:10:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 846A13E1691
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 18:10:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5193C3E6D67
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 18:09:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 14E561A0043E
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 18:09:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3403F21AC5;
 Tue, 22 Sep 2026 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790093361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OB789ZdiAavgJl4ISVdlGaYZPcPe3bVY7YpFfskhNCc=;
 b=CI9yeufGoeFtZFBqaiRR/E49o7NQ8jVQ29KCcP45m9B/Pt7aDdgzRrvWlz8C9IHZzNk7s0
 S29wvR0Zx6gysM7EdT5mdeBM4spATOQnj4KhPfwq9I+u6QaHhjoFtp4WIZi+t6APkgXxl1
 crpbUfkSGZkRcQrBFwFUCMomhbzrgZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790093361;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OB789ZdiAavgJl4ISVdlGaYZPcPe3bVY7YpFfskhNCc=;
 b=MjoL1c0ac0XI8wU9z1SWcYYXpXHulCr/dz5/MXxQtBi9OPxbXleZjneo7rI/jpHzWnGsw+
 XLQ3s18ARgJaNpAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790093357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OB789ZdiAavgJl4ISVdlGaYZPcPe3bVY7YpFfskhNCc=;
 b=w8Yd4oQkjrfqZZD2TlssXloZ45ftP8zE1dIBwg+Lr52TUajEMWVJVTfSManVn1MCMby19V
 NPEFwGn6aaiwQLkPOqgagyKEznqjz+xOnjqwzEl7ClzOgPPNDWfN6d9g8cVNSidWu7VAXy
 JISK24o1Q/Ar5vK8zp4ijWgVwzgKJZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790093357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OB789ZdiAavgJl4ISVdlGaYZPcPe3bVY7YpFfskhNCc=;
 b=bGoilRMt9fRSk1uflC9yrWgWO8m2y360SZO+RagZ2gBDDCoCS7OkUimul2NnOBl1LWLhsC
 +BG3af7mcBWaHCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A769D13A69;
 Tue, 22 Sep 2026 16:09:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u3mALCuosmouJgAAD6G6ig:T4
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 16:09:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Sep 2026 18:09:10 +0200
Message-ID: <20260922160911.2271754-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922160911.2271754-1-pvorel@suse.cz>
References: <20260922160911.2271754-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 R_RATELIMIT(0.00)[to_ip_from(RLtzdurrd6usbijy4f5nozqpqy)];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] m4/ltp-keyutils.m4: Remove struct
 keyctl_dh_params.priv check
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

It was supposed to be used in keyctl25.c and other tests, but not needed
any more.

Follow-up: ee02118e9f ("lapi/keyctl.h: Add fallback definitions for extended ops")
Fixes: ee02118e9f ("lapi/keyctl.h: Add fallback definitions for extended ops")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 m4/ltp-keyutils.m4 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/m4/ltp-keyutils.m4 b/m4/ltp-keyutils.m4
index 35bad783e5..4a6b23dbce 100644
--- a/m4/ltp-keyutils.m4
+++ b/m4/ltp-keyutils.m4
@@ -12,6 +12,4 @@ AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
 	AC_CHECK_TYPES([struct keyctl_dh_params, struct keyctl_kdf_params,
 			struct keyctl_pkey_query, struct keyctl_pkey_params],,,
 			[#include <linux/keyctl.h>])
-
-	AC_CHECK_MEMBERS([struct keyctl_dh_params.priv],,,[#include <linux/keyctl.h>])
 ])
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
