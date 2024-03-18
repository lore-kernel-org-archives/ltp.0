Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A90C54E5D
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 14:55:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A8793D14C8
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 15:54:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1372C3CD512
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 15:54:43 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 381BF601B08
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 15:54:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7CEEE34B62;
 Mon, 18 Mar 2024 14:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710773681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M3113h6uA35yHO9pFyROgipC28U34tHOU9ZMqrCRDaI=;
 b=0VbNSulqcWIHiQR+GalfxZZqYGCVclrQzRdPNa19GNT/0XEQ6Ss2Gq/YwLHDGJ32fg53gJ
 BgkXyVREJ+1/TMBqVvUXbOvvSl6DQaEuXXH0TAsljoWobZGKZmgso8oR77NsWh/Z5RK6ny
 PQRku+qTUDyIDGlAcouuNbFak1b02NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710773681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M3113h6uA35yHO9pFyROgipC28U34tHOU9ZMqrCRDaI=;
 b=CaRsgH8Nz35OJRD072p/gWpBCKOLQbDAp6qWR1XXFPS/S5j9PuU0q3WQJxSiSx/fMxWlyO
 Zhz5Xq/DE2ZxpBDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710773679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M3113h6uA35yHO9pFyROgipC28U34tHOU9ZMqrCRDaI=;
 b=g8Zw1+Q4JqE1c8NN8Rn5xV1BtXeH8f6gOBy7ZTfqkoHxO4A4dxcsYzPWptkEwxSnQxrw5A
 7Aatt3Lm2dKAeZWRDhP2coQRemc+oxlc3JP3MVAiZrAwyFSCVJEVyUxytU+ozWfBzM4Txu
 xa5REC5f+WM5v5qgQYNfo8xWgUZk6Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710773679;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M3113h6uA35yHO9pFyROgipC28U34tHOU9ZMqrCRDaI=;
 b=OECThnJKgy6zpSgrVUVoCNiQNn36O7Ut0pmgXZX07NgzXoM0ix59kaRoYZ2royTB1AaRkk
 Fm4IoUsiBpJAENAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 649F4136A5;
 Mon, 18 Mar 2024 14:54:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9EHfF69V+GVfRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 18 Mar 2024 14:54:39 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 18 Mar 2024 15:54:36 +0100
Message-ID: <20240318145436.389825-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [4.01 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.00)[37.23%];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-0.69)[-0.692];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: Add missing inline
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

Fixes: b366afb64 ("Add SAFE_MPROTECT() macro")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Andrea, Cyril,

9120d8a22 ("safe_macros: turn functions with off_t parameter into static inline")
noted:

    Some functions used to implement safe macros have parameters
    of type off_t or structures containing off_t fields.

These functions (safe_mmap(), safe_stat(), safe_lstat(), ...) are
therefore below this comment:

/*
 * following functions are inline because the behaviour may depend on
 * -D_FILE_OFFSET_BITS=64 compile flag
 */

But IMHO that's not the case for safe_prot_to_str(), or am I missing
something? It does not use any struct, thus no off_t. And what about
safe_mprotect() (added in the same commit).

If I'm correct, I would prefer to move it (+ other functions added in
9120d8a22 to lib/tst_safe_macros.c and keep here only their signatures.

First, it document properly what depends on -D_FILE_OFFSET_BITS=64,
second, this approach to avoid static inline in headers started by
Martin Doucha is IMHO cleaner.

Kind regards,
Petr

 include/tst_safe_macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 7178a842d..463b0f7a9 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -271,7 +271,7 @@ int safe_getgroups(const char *file, const int lineno, int size, gid_t list[]);
 
 #define PROT_FLAG_STR(f) #f " | "
 
-static void safe_prot_to_str(const int prot, char *buf)
+static inline void safe_prot_to_str(const int prot, char *buf)
 {
 	char *ptr = buf;
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
