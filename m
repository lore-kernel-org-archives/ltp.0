Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A185C433FE
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 17:15:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8108E3C9755
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 18:15:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E10003C4EC5
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 18:15:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1027A200332
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 18:15:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F9D9218B0;
 Thu, 27 Jan 2022 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643303700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=B9CXBXBzp/umFgbcBaLeTOPeu5JKuLmn+sb4/BOYJJw=;
 b=fNCuwQmw3nG2kxDPSxfER8TpwLOP0kZdkJva5BuxB0mmIa1huR3XQKNfrpGDLMEet+2scG
 +nJXhP+7FzxY7vCYRylNDmCBSBxVrIY+LMIDz6Sa2Tmaczy2Ya+SGB7HdEV4JeJfe/9Vbs
 FZ37V0k+hd7ark8IBbJvaOceLuGxp+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643303700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=B9CXBXBzp/umFgbcBaLeTOPeu5JKuLmn+sb4/BOYJJw=;
 b=05rg02vKvugR0hHfGLYN64Uzd69dDHKy+a0ZOxFDNZ9RA/rqhgkByGEy7qmJHUYZSv6Spy
 OH18zOabklOj9TBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D412813C25;
 Thu, 27 Jan 2022 17:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H/rYLxPT8mG4GQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 27 Jan 2022 17:14:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Jan 2022 18:14:55 +0100
Message-Id: <20220127171455.9809-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run at
 all
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

We count only tests which TCONF. In case tst_brk() some tests might be
skipped without even trying to run them), thus print them.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

probably quite confusing to have "skipped" and "not run".
Maybe rename s/skipped/cancelled/ and s/not run/skipped/ ?
Or just to increase cound of skipped?

E.g. instead of:

bind05.c:132: TCONF: socket(10, 2, 0) failed: EAFNOSUPPORT (97)

Summary:
passed   8
failed   0
broken   0
skipped  1
warnings 0
not run  5

have
bind05.c:132: TCONF: socket(10, 2, 0) failed: EAFNOSUPPORT (97)

Summary:
passed   8
failed   0
broken   0
skipped  6
warnings 0

Kind regards,
Petr

 lib/tst_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 844756fbd7..e5ea9e6165 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -811,6 +811,9 @@ static void do_exit(int ret)
 		fprintf(stderr, "broken   %d\n", results->broken);
 		fprintf(stderr, "skipped  %d\n", results->skipped);
 		fprintf(stderr, "warnings %d\n", results->warnings);
+		fprintf(stderr, "not run  %d\n", tst_test->tcnt -
+				results->passed - results->failed - results->broken -
+				results->skipped - results->warnings);
 	}
 
 	do_cleanup();
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
