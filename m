Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884F6EB64DA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 11:01:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AD653CD7BE
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 13:01:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F5883C9733
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 13:00:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC79F200A09
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 13:00:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B65B1FE7E;
 Wed, 19 Jul 2023 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689764456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNvEMaWKLoZIWsKGbjfTkwd/O5SjtfLcIBx7eRmTXo0=;
 b=rWzq1lmUZGkb1gp8HYTgvQEL6X0eYCQW9plKmp0hWsri5qSYY34yRJ4BtjuZCNgPHUYfXC
 pTmYOr7LrItyhDo0YpvOujU//8PuMbEWP8IRwE81sKSJx0QGMnQgNfcHLXd+QrzDCszH5g
 QJJi+HKKQYoxy22RpncsWebadip3Dko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689764456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNvEMaWKLoZIWsKGbjfTkwd/O5SjtfLcIBx7eRmTXo0=;
 b=n5dVZNJt+zfTNFm43keQXHmATm5DaxquCOcYPAK8XFN6jiGUtf8KwJeyNdMc8Czl2zSe5O
 4Wk6XpJ5P/kB8HBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F1321361C;
 Wed, 19 Jul 2023 11:00:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mLdfBWjCt2RtUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jul 2023 11:00:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Jul 2023 13:00:49 +0200
Message-Id: <20230719110051.1237775-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719110051.1237775-1-pvorel@suse.cz>
References: <20230719110051.1237775-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] lib/C-API: Add option -V to print LTP version
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

It can be useful for troubleshooting reported issues.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 04da456c6..456d3d1e6 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -34,6 +34,7 @@
 #include "old_resource.h"
 #include "old_device.h"
 #include "old_tmpdir.h"
+#include "ltp-version.h"
 
 /*
  * Hack to get TCID defined in newlib tests
@@ -509,6 +510,7 @@ static struct option {
 	{"h",  "-h       Prints this help"},
 	{"i:", "-i n     Execute test n times"},
 	{"I:", "-I x     Execute test for n seconds"},
+	{"V",  "-V       Prints LTP version"},
 	{"C:", "-C ARG   Run child process with ARG arguments (used internally)"},
 };
 
@@ -686,6 +688,10 @@ static void parse_opts(int argc, char *argv[])
 			else
 				duration = SAFE_STRTOF(optarg, 0.1, HUGE_VALF);
 		break;
+		case 'V':
+			fprintf(stderr, "LTP version: " LTP_VERSION "\n");
+			exit(0);
+		break;
 		case 'C':
 #ifdef UCLINUX
 			child_args = optarg;
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
