Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0321ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 10:06:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 199393CAABD
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 12:06:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9E4E3CAAA7
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 12:06:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0CBC0600152
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 12:06:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F89922062;
 Mon, 12 Sep 2022 10:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662977167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sWNMmCZPpdxh1xNGN4E1Uf2OlU1pH/1zApe3Xtjo6GU=;
 b=gq3rkA1brW9FO6TI1a99wNT9Y1D5HjDX/479ygB1qqTdaRWTPTaGDBwkfsi9AjJf57s1Ly
 9mKyDa+jY0pzhwQ5SzDrj1ExrXvk2KBMI5QOBQOzWzanaJVtIia9pulBrZqBhMH8eYAc0Q
 QePnldlFL3KSDdcrwVtUQOmfcCDBEuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662977167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sWNMmCZPpdxh1xNGN4E1Uf2OlU1pH/1zApe3Xtjo6GU=;
 b=NcwcELY4/S2A39o/nvoH3nDpzz4lBXZOAN9QsPQ1/bgIvRz2ohfFxIth/koCJSipxR4Wbz
 L399gkOP4zj+upBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DE82139C8;
 Mon, 12 Sep 2022 10:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bGzbAY8EH2NqVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Sep 2022 10:06:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 12 Sep 2022 12:06:03 +0200
Message-Id: <20220912100603.1551-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_test.sh: Print Summary into stderr
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

To follow the pattern in C API, where it was changed in
8f560e5dc ("lib: Print everything to stderr").

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: applied on the top of patchset "v5 shell: df01.sh:
$TST_ALL_FILESYSTEMS (.all_filesystems)"

https://lore.kernel.org/ltp/20220909141840.18327-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/list/?series=317639&state=*

Kind regards,
Petr

 testcases/lib/tst_test.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index de4599625..84f29af5b 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -69,13 +69,15 @@ _tst_do_exit()
 		_tst_check_security_modules
 	fi
 
-	echo
-	echo "Summary:"
-	echo "passed   $TST_PASS"
-	echo "failed   $TST_FAIL"
-	echo "broken   $TST_BROK"
-	echo "skipped  $TST_CONF"
-	echo "warnings $TST_WARN"
+	cat >&2 << EOF
+
+Summary:
+passed   $TST_PASS
+failed   $TST_FAIL
+broken   $TST_BROK
+skipped  $TST_CONF
+warnings $TST_WARN
+EOF
 
 	exit $ret
 }
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
