Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713E1C433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 15:04:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EC883C93D1
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 16:04:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 489DE3C0EA4
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 16:04:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 55F491000ED3
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 16:04:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6009321123;
 Wed, 16 Mar 2022 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647443073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aHTCEfiMj6KyAtc1C2N7f+v+mOSFGbSpGRPJs8XZoSQ=;
 b=kQ0Q83w2GAc25XZk24/nKvjTDJvp6zrI+sZu+Dw0FWmJ/fVE0KA7Gy2uvjPe1SbiOTjg/j
 GSyFMKq78Md+g51xrBwVMqD4wG0MzN0XH7ELQ9fYkrkFMgjLLe9fPdzAfQinzSlWAa8fpi
 iWz8PP4IOZbhcYiobJRUvFEH44+TCoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647443073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aHTCEfiMj6KyAtc1C2N7f+v+mOSFGbSpGRPJs8XZoSQ=;
 b=1jKbYMslJJo0Fd55l0H3YyWBZEO6GqTxifKZ3VoOyzV5pgHqhVLb9z2UhRde8yoKf9+dwr
 ii3J/M5KRuuEnMDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1472A139BD;
 Wed, 16 Mar 2022 15:04:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 23nnAIH8MWJcHQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 16 Mar 2022 15:04:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Mar 2022 16:04:29 +0100
Message-Id: <20220316150429.2873-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 1/1] ci: Ubuntu xenial -> bionic
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

Ubuntu 16.04 LTS xenial EOL was in 2021-04.
Replace it with 18.04 LTS bionic (EOL 2023-04).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

according to distrowatch.com xenial EOL was in 2021-04 [1].
Looking into Ubuntu docs, Xenial is in Extended Security Maintenance
(ESM) phase. That explain why repos are still available.
Do we want to move on to bionic (or even focal)?

Kind regards,
Petr

[1] https://distrowatch.com/table.php?distribution=ubuntu
[2] https://ubuntu.com/about/release-cycle

 .github/workflows/ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index c268ba41c7..fe28e4d055 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -99,7 +99,7 @@ jobs:
               METADATA: asciidoctor
               TREE: out
 
-          - container: "ubuntu:xenial"
+          - container: "ubuntu:bionic"
             env:
               CC: gcc
               METADATA: asciidoc-pdf
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
