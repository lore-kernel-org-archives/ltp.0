Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A709C32793
	for <ltp@archiver.kernel.org>; Wed, 18 Jan 2023 13:35:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5D7A3CBBAF
	for <ltp@archiver.kernel.org>; Wed, 18 Jan 2023 14:35:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C12AD3C13C2
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 14:35:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 193CF1000A2E
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 14:35:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A67A5BEB1;
 Wed, 18 Jan 2023 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674048908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tflJJ5Clz2VtNI5NgGk4GdblraCFFbMTr0+CKZ9qeWw=;
 b=deBJ/6vQtAleXVaD9bnaunuOiRc0WmCZpyTuRRCtb+aIX2Vjdmtku9IbyNCEkzO7VW68tZ
 VBwg6h1O4BQdXCIW1Nc8HlpiP7TxpPX4Dpm7MxOFwA2CmLSCwyLozggCv5G7tlX+BK31XJ
 oqqO3JlokKhGAMslI+KrNrs8Yv7DcJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674048908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tflJJ5Clz2VtNI5NgGk4GdblraCFFbMTr0+CKZ9qeWw=;
 b=KEFKp7unjeViRNQUScA7yjfpypVzJOAO1waEKNjwKEmSzrnsHIUxfD6rqi2N38UL7Ir2LI
 7fdINBdsYCf18lCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81151139D2;
 Wed, 18 Jan 2023 13:35:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id t5bcHYz1x2OAQwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 18 Jan 2023 13:35:08 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Jan 2023 14:36:43 +0100
Message-Id: <20230118133643.11371-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/statvfs01: Correcly zero terminate the
 strings
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixes random failures caused by the fact that the stack is not
guaranteed to be zeroed.

Fixes: e305ac4a305f ("statvfs01: Convert to new LTP API")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Petr Vorel <pvorel@suse.cz>
CC: Richard Palethorpe <rpalethorpe@suse.com>
CC: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/statvfs/statvfs01.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c b/testcases/kernel/syscalls/statvfs/statvfs01.c
index dd14d6a0e..f17dc4cfa 100644
--- a/testcases/kernel/syscalls/statvfs/statvfs01.c
+++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
@@ -38,6 +38,9 @@ static void run(void)
 	memset(valid_fname, 'a', valid_len);
 	memset(toolong_fname, 'b', valid_len + 1);
 
+	valid_fname[valid_len] = 0;
+	toolong_fname[valid_len+1] = 0;
+
 	TST_EXP_FD(creat(valid_fname, 0444));
 	SAFE_CLOSE(TST_RET);
 
-- 
2.38.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
