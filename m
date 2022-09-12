Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62933ECAAD5
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 10:20:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B37273CAACA
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 12:20:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A85D3CAAA7
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 12:19:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 80CB5200761
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 12:19:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D081222B2A;
 Mon, 12 Sep 2022 10:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662977992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ou/ZFcGAfwb1shReolhkxgvd4nWgOUpv06n8/pzSUiE=;
 b=euEi9p5Kw4XJjtLH6KxDgjheoHZWw414gFdsaLOOD6trV4uC0WMbpzm73mUkoolrFYuYzd
 uFkDWEB07EP8MeOlIOMexUgZk+Gvipo+QOtol2EALld6sAK4bXeSAIfHL9+U+uWJKCYLn5
 rxWasyWhffE30PC9FNKbUuTdcG+DQfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662977992;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ou/ZFcGAfwb1shReolhkxgvd4nWgOUpv06n8/pzSUiE=;
 b=3lYFzVGzSoILtf+TWcSJpync1TqhT/rw/NdMvuyPOvQ6PiV6cfK4+5LCdQpHAsD1+LsVaV
 TX5Szn9ehMd+PoAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95995139C8;
 Mon, 12 Sep 2022 10:19:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id N+/AIsgHH2OxWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Sep 2022 10:19:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 12 Sep 2022 12:19:48 +0200
Message-Id: <20220912101948.4425-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc/user-guide: LTP_RUNTIME_MUL is only for C API
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

Not yet implemented in shell API.
+ fix indent.

Fixes: 0f72d519a ("Introduce a concept of max runtime")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/user-guide.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index 0dc0c958e..fdd74ca41 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -27,8 +27,8 @@ For running LTP network tests see `testcases/network/README.md`.
                           Variable is also used in shell tests, but ceiled to int.
 | 'LTP_RUNTIME_MUL'     | Multiplies maximal test iteration runtime. Tests
                           that run for more than a second or two are capped on
-			  runtime. You can scale the default runtime both up
-			  and down with this multiplier.
+                          runtime. You can scale the default runtime both up
+                          and down with this multiplier. NOTE: only for C API.
 | 'LTP_VIRT_OVERRIDE'   | Overrides virtual machine detection in the test
                           library. Setting it to empty string tell the library
                           that system is not a virtual machine. Other possible
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
