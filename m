Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F5EC4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 15:56:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E39F3CFE72
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 17:56:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FA4F3CE2B0
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 17:55:39 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 162FE60012A
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 17:55:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D7F621A45;
 Thu, 25 Apr 2024 15:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714060538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yo9Tf6SBN4YKow7PA8fXa3ApOwhivMt8em98/0ZGMCQ=;
 b=R3ffTZ4cDYyKJljc+QXprSr+u6fX06mGPj8wZX1dFjTRCACFhOSqs4SGHB3LVhvWhCRcwR
 7qPJumtG4FR2z7EYRvIzEY2wnj/69TFQ5VCbywOpgvmZ6lMK1310BXuTyW4TI8cQkHgq75
 lQA8IKoIDrovaTvFdQOx2/KHvcOTksQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714060538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yo9Tf6SBN4YKow7PA8fXa3ApOwhivMt8em98/0ZGMCQ=;
 b=xPDFI91iru+KegyTKfkho/SN9GRrqAqo3XZE01IDw2tYGIKs10q+4M4Lko/PoUb9PjqlS7
 EIK4yb3mm11zQLDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714060538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yo9Tf6SBN4YKow7PA8fXa3ApOwhivMt8em98/0ZGMCQ=;
 b=R3ffTZ4cDYyKJljc+QXprSr+u6fX06mGPj8wZX1dFjTRCACFhOSqs4SGHB3LVhvWhCRcwR
 7qPJumtG4FR2z7EYRvIzEY2wnj/69TFQ5VCbywOpgvmZ6lMK1310BXuTyW4TI8cQkHgq75
 lQA8IKoIDrovaTvFdQOx2/KHvcOTksQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714060538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yo9Tf6SBN4YKow7PA8fXa3ApOwhivMt8em98/0ZGMCQ=;
 b=xPDFI91iru+KegyTKfkho/SN9GRrqAqo3XZE01IDw2tYGIKs10q+4M4Lko/PoUb9PjqlS7
 EIK4yb3mm11zQLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F039D139A9;
 Thu, 25 Apr 2024 15:55:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YJnqOfl8KmZoGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Apr 2024 15:55:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 25 Apr 2024 17:55:31 +0200
Message-ID: <20240425155533.295195-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240425155533.295195-1-pvorel@suse.cz>
References: <20240425155533.295195-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] lapi/fs: Replace loff_t with long long
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

loff_t in tst_max_lfs_filesize() would require define _GNU_SOURCE.
Replace with long long to avoid this.

This fixes build error on musl (alpine):

    In file included from unlink09.c:18:
    ../../../../include/lapi/fs.h:58:15: error: unknown type name 'loff_t'
       58 | static inline loff_t tst_max_lfs_filesize(void)

Fixes: 2cf78f47a ("unlink: Add error tests for EPERM and EROFS")
Suggested-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v2->v3
* Use just long long instead of define _GNU_SOURCE (Jan)

Later I move this out of LAPI header, but now let's fix the CI.

Kind regards,
Petr

 include/lapi/fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index c19ee821d..635979b02 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -55,13 +55,13 @@
  * 64 bit: macro taken from kernel from include/linux/fs.h
  * 32 bit: own implementation
  */
-static inline loff_t tst_max_lfs_filesize(void)
+static inline long long tst_max_lfs_filesize(void)
 {
 #ifdef TST_ABI64
-	return (loff_t)LLONG_MAX;
+	return LLONG_MAX;
 #else
         long page_size = getpagesize();
-        loff_t ret = ULONG_MAX;
+        long long ret = ULONG_MAX;
 
         while (page_size >>= 1)
                 ret <<= 1;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
