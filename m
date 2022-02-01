Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2993C433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 09:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77D9B3C988B
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 10:45:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACD113C97F7
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 10:44:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2F591600842
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 10:44:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 70A881F383;
 Tue,  1 Feb 2022 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643708695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9aJDIu8fkLEWQVIKwPpKe+NDEpKjkhdqWeU8RsjYRQA=;
 b=ftG4ZgE0VCxu66Kd8/0Z3a1how+8XvlnmfuA5cOMJwC1o6dtQDUo7QYPv1Tf85x9wvFn2X
 mFWW8tvZpKdY5b8CDE+Fwe5IMLQFOafF01wtmsLwGwH9xis3H6wDoMR9Dxk83tWPutxgRU
 z6slzFqMsGtCv1WQNAiF0cXiyr7koTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643708695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9aJDIu8fkLEWQVIKwPpKe+NDEpKjkhdqWeU8RsjYRQA=;
 b=PptFCJatfbo+AdbZuoKgi3FuXuTDz3Cfr0MOSXpaiSPvvlRJ4eER9FxZlyBL0JRZks5LwZ
 vP56LnFyfJZciOAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30F8813CF0;
 Tue,  1 Feb 2022 09:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id byAaBhcB+WFieAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 01 Feb 2022 09:44:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  1 Feb 2022 10:44:51 +0100
Message-Id: <20220201094451.7651-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ci: Remove CentOS 8
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

It EOL in 12/2021 and CI is failing due removed repo:

CentOS Linux 8 - AppStream                      232  B/s |  38  B     00:00
Error: Failed to download metadata for repo 'appstream': Cannot prepare internal mirrorlist: No URLs in mirrorlist

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/ci.yml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 99fcde1c02..c268ba41c7 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -104,11 +104,6 @@ jobs:
               CC: gcc
               METADATA: asciidoc-pdf
 
-          - container: "centos:latest"
-            env:
-              CC: gcc
-              METADATA: asciidoctor
-
     container:
       image: ${{ matrix.container }}
       env: ${{ matrix.env }}
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
