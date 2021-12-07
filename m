Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98921C433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 10:29:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 020283C320E
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 11:29:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0D953C1836
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 11:29:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 221E11000A11
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 11:29:15 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2B6B121B40;
 Tue,  7 Dec 2021 10:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1638872955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JyHyo3csYxdPRblC/KH2VxmlKHQU4LxCPdWTTCsnby0=;
 b=UbYNN3gFTfTiGR7X0RQ8tdPLLW34Xbcz4YRN6YsbxFvo9z/SlmzGq9zVzTrjZ9+Nl1pTCr
 kyEOxqmq/q4Q6KYkosPtf4neKcOEOESJW9P3mfaY8sYERFoMuT09RFNlUbACY3DfDHKwk9
 T+bM4uWzpWPxpWQcj9k+jVLFf7uX5RY=
Received: from g78.suse.de (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 by relay2.suse.de (Postfix) with ESMTP id D1A5BA3B83;
 Tue,  7 Dec 2021 10:29:14 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  7 Dec 2021 10:29:02 +0000
Message-Id: <20211207102904.6011-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] doc: Add LTP-005: Array must be sentinel
 terminated
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---

V2:
* Don't allow {NULL, NULL}, {0}, etc.
* The above resulted in two errors
  being detected which are fixed in patch 3

 doc/rules.tsv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/rules.tsv b/doc/rules.tsv
index 2dfeca9f9..66dbdeccf 100644
--- a/doc/rules.tsv
+++ b/doc/rules.tsv
@@ -3,3 +3,4 @@ LTP-001	Library source files have tst_ prefix
 LTP-002	TST_RET and TST_ERR are never modified by test library functions
 LTP-003 Externally visible library symbols have the tst_ prefix
 LTP-004 Test executable symbols are marked static
+LTP-005 Array must terminate with a sentinel value (i.e. NULL or '{}')
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
