Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BBFC61DA4
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 09:50:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C9493CC5A3
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 10:50:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BADF23CB0B8
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 10:50:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E22B760047C
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 10:50:32 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1FF021FDD0;
 Tue, 14 Feb 2023 09:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676368232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7pHa9mWF68es/GGYvlC9w5XyS4gUlWwoF377PUc3uOg=;
 b=JtMzruREvhjomg5qCn2dcifk4vhDBPVk3TWHqYbnbATFJoaKoDQj602IcLIT/1hyhnEfgF
 JZlx/G7nByZ9NA/1MPjTmDF/oA31qXwi7FtPqr7lxHixxJzN20ywj30xzN9UCuVWG+8PlO
 YNWelLqR7lQmu0wvOUpZU1bUkw17weA=
Received: from g78.cable.virginm.net (unknown [10.163.28.198])
 by relay2.suse.de (Postfix) with ESMTP id DA2B12C141;
 Tue, 14 Feb 2023 09:50:31 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 14 Feb 2023 09:50:27 +0000
Message-Id: <20230214095027.9614-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/tst_safe_posix_ipc: Use %zu to format size_t
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Prevents compiler warning on 32bit

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_safe_posix_ipc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/tst_safe_posix_ipc.h b/include/tst_safe_posix_ipc.h
index 2d3d0928f..e7892f2af 100644
--- a/include/tst_safe_posix_ipc.h
+++ b/include/tst_safe_posix_ipc.h
@@ -121,7 +121,7 @@ static inline int safe_mq_send(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			"mq_send(%d,%s,%lu,%d) failed", mqdes, msg_ptr,
+			"mq_send(%d,%s,%zu,%d) failed", mqdes, msg_ptr,
 			msg_len, msg_prio);
 	}
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
