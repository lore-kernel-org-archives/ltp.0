Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC0EC46467
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 14:17:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A144B3CCB3F
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 15:17:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 597473CB57E
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 15:17:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58360600728
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 15:17:12 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 091E976FF6;
 Tue, 10 Jan 2023 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1673360232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3NAAoel3+QA6fVZrwByiKJaGRZU3gBWKHNTaVOToJP4=;
 b=uFGSMm+JXOJNPNW9aheovOUn4qrFaKHc/dSFKIM7mYSm0HVON4fbHZmcYfVtmzuG5gqhoC
 cALUTKeel5kwt2iw2J3MDyVe6F9MwlXuD+n7x1/OAFmjnj1w1m+c50L+GGcy5SEL6ht/NN
 wrFfEFl1PKEmUHyP7peC79gtwtRdEs8=
Received: from g78.cable.virginm.net (unknown [10.163.17.14])
 by relay2.suse.de (Postfix) with ESMTP id 27D302C141;
 Tue, 10 Jan 2023 14:17:10 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 10 Jan 2023 14:16:15 +0000
Message-Id: <20230110141616.1449-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscall: System call numbers are word sized
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

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/syscalls/regen.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
index 97027e2f3..217595f34 100755
--- a/include/lapi/syscalls/regen.sh
+++ b/include/lapi/syscalls/regen.sh
@@ -38,12 +38,12 @@ cat << EOF > "${output_pid}"
 #ifdef TST_TEST_H__
 #define TST_SYSCALL_BRK__(NR, SNR) ({ \\
 	tst_brk(TCONF, \\
-		"syscall(%d) " SNR " not supported on your arch", NR); \\
+		"syscall(%ld) " SNR " not supported on your arch", NR); \\
 })
 #else
 #define TST_SYSCALL_BRK__(NR, SNR) ({ \\
 	tst_brkm(TCONF, CLEANUP, \\
-		"syscall(%d) " SNR " not supported on your arch", NR); \\
+		"syscall(%ld) " SNR " not supported on your arch", NR); \\
 })
 #endif
 
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
