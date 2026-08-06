Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773B4C55ABF
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 07:08:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A090A3E2C9F
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 09:08:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FDE83C280E
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 09:07:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3C7FC1A00904
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 09:07:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 62CC63E02
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 07:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786000057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+iy9QILJBXierz1ijnAoiojuTGW/ndtKzcRMQ5otaI=;
 b=nmSfLNubUiASOH4OP8MYCfcpVN20kEtqOxxoYtaV+p0l0PE0xPgE46bOfQyEPXHHxO/3g2
 q0bMPu6o1YRZWpdtb4yHFOCBKPBawy3hxZpPQ8/LRmPSMup9tH4aEZZb4Uk+92biBLBFH1
 87UepM9FEMtbE7DexgLwEk7D0JSwBgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786000057;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+iy9QILJBXierz1ijnAoiojuTGW/ndtKzcRMQ5otaI=;
 b=ctkygHAehQVZtn73hQ0nUoedkv/wG/vw+Afrq86fpuAItYb5ZiB2UuBkAZ/SMsK7Vq9ZeU
 HzZhpDFird25tQCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VltQFW4X;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BxCC66Ly
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786000053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+iy9QILJBXierz1ijnAoiojuTGW/ndtKzcRMQ5otaI=;
 b=VltQFW4Xw/nHX3OIxSVuVhRazoNh2PhWWDpCqbOa2PA61VMMiWDIiA4pM4+rcTbHWI67bh
 rJ/DjyreR5S90FXJ7tPNUrTLc9As6ePPnzkP0u+k29dvBe1yC41Ht4/iWX+mWUG7rP4s/7
 z6XJEPBa2xWTetRwPOflFeZI8id3UYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786000053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+iy9QILJBXierz1ijnAoiojuTGW/ndtKzcRMQ5otaI=;
 b=BxCC66Lywm5BTtO9qJRt+gIEsltjHTlIhiADvzT+6k+LVEtYQ3bt7yp8TUj4PPx4T3DBPv
 hgvUZKEztLP59sDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 539C6779B6
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 07:07:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q/hkFLUydGqTHQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 07:07:33 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Aug 2026 09:06:25 +0200
Message-ID: <20260806070625.19475-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 62CC63E02
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap36: Fix compilation on alpine
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

Use int64_t instead of off64_t that is not defined on musl libc.

Fixes: ae1b3655ed5da (hugemmap36: Migrate the libhugetlbfs/testcases/truncate_above_4GB.c tess)
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
index b48a34f59..5f0d70a05 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
@@ -21,7 +21,7 @@
  */
 
 #define _GNU_SOURCE
-#define FOURGIG ((off64_t)0x100000000ULL)
+#define FOURGIG ((int64_t)0x100000000ULL)
 #define MNTPOINT "hugetlbfs/"
 
 #include <signal.h>
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
