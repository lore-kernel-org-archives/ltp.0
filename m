Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB6DC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 12:50:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0B4C3CA5FC
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 14:50:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF5153C0677
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 14:50:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2C3492009A2
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 14:50:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C74E0210FD;
 Wed, 27 Apr 2022 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651063807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QUWituPwZhKYCBWdP/tbOTlYGGeHi5vkmqZlZzJPaN8=;
 b=y+/2fKPbOBea5c8VCgkAqapRQvdfAlPcNxratVwISjNOdtgqHwGfeNxEzUx5ObjZcmMhGY
 oUIM81FR5KEcZF9/v1KgrdWgvk9XV/3+u7QX0Dexm8MbPpnEy7xG2IK8FZ3ZQADr/7IbAs
 15yPB3ibBZFuBKZseY4vjTogChRl9vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651063807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QUWituPwZhKYCBWdP/tbOTlYGGeHi5vkmqZlZzJPaN8=;
 b=jPak1CDHlyKqTXI9PxFvPUS9/xPbMTcOlJIkx9DwG3Hn+4RbcKJm6xzyPXcDVbEqIyvLzS
 pB77Zi9ZtwOKoJDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DF1A1323E;
 Wed, 27 Apr 2022 12:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YONKIf87aWK5RgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Apr 2022 12:50:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 Apr 2022 14:50:01 +0200
Message-Id: <20220427125003.20815-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220427125003.20815-1-pvorel@suse.cz>
References: <20220427125003.20815-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/5] doc: Update library API doc
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

about conditional expansion for TST_{SETUP,CLEANUP}.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v2->v3:
* reword

 doc/library-api-writing-guidelines.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/library-api-writing-guidelines.txt b/doc/library-api-writing-guidelines.txt
index e75c838a1..08468f2fc 100644
--- a/doc/library-api-writing-guidelines.txt
+++ b/doc/library-api-writing-guidelines.txt
@@ -61,3 +61,24 @@ API source code is in 'tst_test.sh', 'tst_security.sh' and 'tst_net.sh'
 
 Changes in the shell API should not introduce uncommon dependencies
 (use basic commands installed everywhere by default).
+
+3.1 Shell libraries
+~~~~~~~~~~~~~~~~~~~
+
+Aside from shell API libraries in 'testcases/lib', it's worth putting
+common code for a group of tests into a shell library. The filename
+should end with '_lib.sh' and the library should load 'tst_test.sh' or
+'tst_net.sh'.
+
+Shell libraries should have conditional expansion for 'TST_SETUP' or 'TST_CLEANUP',
+to avoid surprises when test specific setup/cleanup function is redefined by
+shell library.
+
+[source,sh]
+-------------------------------------------------------------------------------
+# ipsec_lib.sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+TST_SETUP=${TST_SETUP:-ipsec_lib_setup}
+. tst_test.sh
+...
+-------------------------------------------------------------------------------
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
