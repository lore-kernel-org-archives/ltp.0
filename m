Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BEDC54EE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 06:14:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C4B93CAB10
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 08:14:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E85E3CAAA6
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 08:13:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D48581000CEA
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 08:13:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D82C95BDC0;
 Tue, 13 Sep 2022 06:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663049631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=S8voNOZaeqZ86F3rU/5MgYHJbS/JAq/tPOkv1HAyGx4=;
 b=IFL1NE/oI9U/c2QAneOroo8+8j7JurwCnYIsbeLNqX0rGkRZBqQLuP5EfTqNDwa2TXIkiG
 AZAmSTVRMSrxNpY42YWwijx6TF7onV6I01kylWjD191+p5zpvhNb03O1ucdgHCJkjBQBHI
 wpNtD26Ghm2dHxUhUW5v7moqBvKjJoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663049631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=S8voNOZaeqZ86F3rU/5MgYHJbS/JAq/tPOkv1HAyGx4=;
 b=E9re7sqF/L5qSbBFFcPGju7OPobRivaBLploJE32M5v0ptnVPrWiAEYy/ZFVugJma3uGH5
 3aLT7HSApERnAsCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E82E139B3;
 Tue, 13 Sep 2022 06:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Kq0rJZ8fIGM4ZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Sep 2022 06:13:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 13 Sep 2022 08:13:47 +0200
Message-Id: <20220913061347.32738-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] doc/user-guide: LTP_RUNTIME_MUL is only for C
 API
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* reword to "Not yet implemented in shell API" (Cyril)

 doc/user-guide.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index 0dc0c958e..656df3118 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -27,8 +27,9 @@ For running LTP network tests see `testcases/network/README.md`.
                           Variable is also used in shell tests, but ceiled to int.
 | 'LTP_RUNTIME_MUL'     | Multiplies maximal test iteration runtime. Tests
                           that run for more than a second or two are capped on
-			  runtime. You can scale the default runtime both up
-			  and down with this multiplier.
+                          runtime. You can scale the default runtime both up
+                          and down with this multiplier. NOTE: Not yet implemented
+                          in shell API.
 | 'LTP_VIRT_OVERRIDE'   | Overrides virtual machine detection in the test
                           library. Setting it to empty string tell the library
                           that system is not a virtual machine. Other possible
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
