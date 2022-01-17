Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3113AC433F5
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 09:08:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D10D3C95FA
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 10:07:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F94B3C31A2
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 10:07:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 219BE10009E7
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 10:07:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 817E021126;
 Mon, 17 Jan 2022 09:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642410468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CWFhmGcKaNgCLFD9k3+xAZ2DWmBdOkf8MPLW15eMxU8=;
 b=EsFOQaxDvcdnvQhqLzZ01olMccJBYdob6DWti5BUW75APWIqGtHCAX0LKd2FJ4TiHotJ3q
 lX0m55tKnw6zQxWr2EE5mtBR8UgvEsP/B33s9JyUMTW2IWKhGOv83hFRMJQZNHQ6UrIQNd
 rGAL3HNii8C4jC+wiKGn04RVCu46s8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642410468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CWFhmGcKaNgCLFD9k3+xAZ2DWmBdOkf8MPLW15eMxU8=;
 b=nssJOO1jAzTibpTqi6uWxOBuw8P5SGq6tRwWKJlta11r1rRpA24ENZUe1i3wzZyIrxRuHb
 tUz5SpmnYeKmrCCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50B5D13AE2;
 Mon, 17 Jan 2022 09:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Od/cEOQx5WFkMAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 17 Jan 2022 09:07:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 17 Jan 2022 10:07:44 +0100
Message-Id: <20220117090744.30354-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED][PATCH] ci/wiki-mirror: Fix triggering CI
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

Matching github.repository instead of
github.event.pull_request.head.repo.full_name is what is required for
our workflow pushing directly to git (we very rarely use pull requests,
and not for big changes which includes doc changes).

This also revert 820cfe539b as it didn't fix the problem.

Fixes: 760fdf3a8f ("ci: Don't run wiki mirror on LTP forks")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Xu,

FYI ba99b81708 ("doc: Fix typo missing s in .all_filesystems")
verified it's working:

https://github.com/linux-test-project/ltp/actions/runs/1707090366

Kind regards,
Petr

 .github/workflows/wiki-mirror.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/wiki-mirror.yml b/.github/workflows/wiki-mirror.yml
index 302667255b..36c7d8311e 100644
--- a/.github/workflows/wiki-mirror.yml
+++ b/.github/workflows/wiki-mirror.yml
@@ -11,7 +11,7 @@ on:
 jobs:
   mirror:
     runs-on: ubuntu-latest
-    if: ${{ github.event.pull_request.head.repo.full_name == 'linux-test-project/ltp' }}
+    if: ${{ github.repository == 'linux-test-project/ltp' }}
     steps:
       - name: Checkout LTP
         uses: actions/checkout@v2
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
