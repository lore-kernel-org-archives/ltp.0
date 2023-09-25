Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F01ECE7A95
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 15:25:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D39B3CF2C4
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 17:25:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE9E53CE241
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:24:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BA5D560090A
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:24:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 039802184E;
 Mon, 25 Sep 2023 15:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695655493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c00FJZA82iSyc0AkO2g24ZxHFdedxledax3xUJYku5c=;
 b=H8M9cr4XbBdftw0pz7b1AGs/kqEuu99/Ylxt0O4L3dAtD3TNNkFv3dyqji0AV+2xGOKHZu
 qZEKa2q13qsSCV9iLra8vytnEiHuRO3pyORLnxgrUCitbq8o4Tuz/nzl6nCE45DCxFuU4C
 eeWrAW53gWlZvhDWM6nqGvpeoHqNGBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695655493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c00FJZA82iSyc0AkO2g24ZxHFdedxledax3xUJYku5c=;
 b=CVkXmLrqp9n8ln2PEwTLZGeXGrQCawd21vOrLlkMXgDjPe7V3N8RerHI9OIRlWIx3DTGW/
 5bMYK+7BJ3NFDjCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1B9413580;
 Mon, 25 Sep 2023 15:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KJk4MkSmEWURVQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Sep 2023 15:24:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Sep 2023 17:24:50 +0200
Message-Id: <20230925152450.89228-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc: Document musl-git
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
A follow up for musl-git related patchset
https://patchwork.ozlabs.org/project/ltp/list/?series=374767&state=*

 doc/c-test-api.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 0fe8ed41d..dab811564 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -2369,13 +2369,14 @@ NOTE: We don't track all backports to stable kernel but just those which are
       stable branch specific (unique), i.e. no commit in mainline. Example of
       commits: c4a23c852e80, cac68d12c531.
 
-Glibc git commit in a regression test for a glibc bug:
+Glibc and musl git commits in a regression test for glibc and musl bugs:
 [source,c]
 -------------------------------------------------------------------------------
 struct tst_test test = {
 	...
 	.tags = (const struct tst_tag[]) {
 		{"glibc-git", "574500a108be"},
+		{"musl-git", "fa4a8abd06a4"},
 		{}
 	}
 };
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
