Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4311FC05027
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 11:36:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B2863CBE39
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 12:36:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57AEE3CB190
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 12:36:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CA477600485
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 12:36:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BE8C21FE8B;
 Fri, 17 Feb 2023 11:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676633761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nMLXucLj8yQZa9arS4i1/sFX+tCOyB2008YAFGWbeC4=;
 b=XzgBTJXqYvwTYXaseejC8HDhLZPNqjlg1WltIgj2xFVc0l6u9Pl5O1OPVvzVVnLo7vYlAr
 2QpUsjB6zmdnHZ+Rz0PDVcgFj8s5iPT4fuyNg9m0sn7spYnHR8BJu5UgXlE4/Ek0ZRjge/
 iYLyt7Baxg4NJzGio31PTrX/Dx6YwP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676633761;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nMLXucLj8yQZa9arS4i1/sFX+tCOyB2008YAFGWbeC4=;
 b=Qk84/Wi+Ynjgc4nRLGpNAdrwisMgnxdd2VlvpWV8NVhJYpSG5GVIoaG77kYpcy7cTDLdWR
 CMrWRs6nU+faTvDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 912B0138E3;
 Fri, 17 Feb 2023 11:36:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h8ZrIaFm72NHTgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Feb 2023 11:36:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Feb 2023 12:35:57 +0100
Message-Id: <20230217113557.8786-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED][PATCH 1/1] tst_net.sh: Check new API variables
 only for new API
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

It does not make sense to check these variables when legacy API is used.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 16f6b57e3d..39c4674022 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -953,21 +953,21 @@ tst_default_max_pkt()
 
 [ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
 
-if [ "$TST_PARSE_ARGS_CALLER" = "$TST_PARSE_ARGS" ]; then
-	tst_res_ TWARN "TST_PARSE_ARGS_CALLER same as TST_PARSE_ARGS, unset it ($TST_PARSE_ARGS)"
-	unset TST_PARSE_ARGS_CALLER
-fi
-if [ "$TST_SETUP_CALLER" = "$TST_SETUP" ]; then
-	tst_res_ TWARN "TST_SETUP_CALLER same as TST_SETUP, unset it ($TST_SETUP)"
-	unset TST_SETUP_CALLER
-fi
-if [ "$TST_USAGE_CALLER" = "$TST_USAGE" ]; then
-	tst_res_ TWARN "TST_USAGE_CALLER same as TST_USAGE, unset it ($TST_USAGE)"
-	unset TST_USAGE_CALLER
-fi
-
 if [ -n "$TST_USE_LEGACY_API" ]; then
 	tst_net_read_opts "$@"
+else
+	if [ "$TST_PARSE_ARGS_CALLER" = "$TST_PARSE_ARGS" ]; then
+		tst_res_ TWARN "TST_PARSE_ARGS_CALLER same as TST_PARSE_ARGS, unset it ($TST_PARSE_ARGS)"
+		unset TST_PARSE_ARGS_CALLER
+	fi
+	if [ "$TST_SETUP_CALLER" = "$TST_SETUP" ]; then
+		tst_res_ TWARN "TST_SETUP_CALLER same as TST_SETUP, unset it ($TST_SETUP)"
+		unset TST_SETUP_CALLER
+	fi
+	if [ "$TST_USAGE_CALLER" = "$TST_USAGE" ]; then
+		tst_res_ TWARN "TST_USAGE_CALLER same as TST_USAGE, unset it ($TST_USAGE)"
+		unset TST_USAGE_CALLER
+	fi
 fi
 
 # detect IPv6 support on lhost for tests which don't use test links
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
