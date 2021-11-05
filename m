Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E237C433EF
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 14:31:42 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2B161244
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 14:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE2B161244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B0383C75DE
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 15:31:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D08FC3C737B
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 15:31:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EF7A5200939
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 15:31:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0EF8C217BA;
 Fri,  5 Nov 2021 14:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636122689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ej8sssfRDEfbkCFqxNO1h1qmUfF+M8a01QklNo4DC6Q=;
 b=Cq3fBmMvc2HdFwWsGffHzSTBB/laRtyorPCXaEZdDVmai7e7VN/AxlGWmnZAgK8ejC5xE5
 0UiI5R84gTuFoaun8blbEAMENdBA8SCAp0fz1Jx3xSW7AlU52AlP8qwq706r5lmNh6NVuj
 cyteVCVLU010bP0Z8cK/l0ne+YvpE6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636122689;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ej8sssfRDEfbkCFqxNO1h1qmUfF+M8a01QklNo4DC6Q=;
 b=oN1UVYmJfSK98/ZMNeDI4WAxLu1VI+L2BdR5ZXd3nQxEQh+Fr6BqrxjcMUwrEiGIr1BdNs
 FI/UKDX1gQcfJdDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB9D71400B;
 Fri,  5 Nov 2021 14:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id s+TNM0BAhWEOCgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 Nov 2021 14:31:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  5 Nov 2021 15:31:25 +0100
Message-Id: <20211105143125.7858-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] CI: Remove Tumbleweed
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

Tumbleweed suffers with common timeouts during installing packages.

https://github.com/linux-test-project/ltp/runs/4102121237?check_suite_focus=true
2021-11-04T07:12:04.5788989Z (110/114) Installing: pcre2-devel-10.38-1.1.x86_64 [.........done]
2021-11-04T13:10:22.9205133Z (111/114) Installing: clang13-13.0.0-1.2.x86_64 [.
2021-11-04T13:10:22.9326559Z ##[error]The operation was canceled.
2021-11-04T13:10:22.9383287Z Stop and remove container: 3dab012d9d14480da05fc921cd0c0124_opensusetumbleweed_b0089d

While keeping restarting after some time usually helps, it's not useful
to have CI with false positives thus removed until problem gets
permanently fixed. But keep seccomp workaround introduced in 0aa9ebd30
for other distros with newest glibc.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/ci.yml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 55d8f5eb5..3a0cc7d94 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -76,11 +76,6 @@ jobs:
               CC: clang
               METADATA: asciidoc-pdf
 
-          - container: "opensuse/tumbleweed"
-            env:
-              CC: gcc
-              METADATA: asciidoctor
-
           - container: "opensuse/leap"
             env:
               CC: gcc
-- 
2.33.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
