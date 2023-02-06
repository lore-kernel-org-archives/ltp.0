Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164E0C05027
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 06:10:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C9973CC24D
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 07:10:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CBF53C2A67
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 07:10:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C73E3200385
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 07:10:05 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B1653EDDB;
 Mon,  6 Feb 2023 06:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675663805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aKoCSlwOmwwI0EaIXK4IwxVnMpR+ka6eUpdP7TK5VSU=;
 b=ZBINMr/7KtlsQJDcDIF6PHx5L7TZ4tqxUMDNxYDtMZvtMlz7Do3uyuu7GmVebIhh6L4QwX
 s+F1VLh8W2jjIgjbXiWuP25Zv1FlZwVPBKHARaX0hPQuzYqSvOVSy+a3K4WX+kpxJdCpbg
 5RC5lX9CWK/VfONY+89w1g5JBkFtAzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675663805;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aKoCSlwOmwwI0EaIXK4IwxVnMpR+ka6eUpdP7TK5VSU=;
 b=UE5gQEz4aogEVsrNLu75bD9JuP3q3Q3Y/aRVAy7l6VpKTxBUjYqGjWQMgjG+6bium1NOhp
 DwU3+ukTgcd0BIDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0AA91390C;
 Mon,  6 Feb 2023 06:10:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AZKSNbyZ4GN0NgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Feb 2023 06:10:04 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Feb 2023 07:10:01 +0100
Message-Id: <20230206061001.13164-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: Allow zero iterations (-i0)
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

-i0 is helpful to test if setup and cleanup are working.
We suggest that in maintainer-patch-review-checklist.txt.

Fixes: 4c0465f217 ("lib: Replace atoi/atof with SAFE_STRTOL/SAFE_STRTOF")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 23d21c8255..04d6b13bfc 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -678,7 +678,7 @@ static void parse_opts(int argc, char *argv[])
 			print_test_tags();
 			exit(0);
 		case 'i':
-			iterations = SAFE_STRTOL(optarg, 1, INT_MAX);
+			iterations = SAFE_STRTOL(optarg, 0, INT_MAX);
 		break;
 		case 'I':
 			if (tst_test->max_runtime > 0)
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
