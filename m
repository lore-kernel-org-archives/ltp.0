Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2071C433F5
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 10:42:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7F2D3C954C
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 11:42:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B40FE3C8C6D
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 11:42:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C828860148C
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 11:42:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C8C11F3BC;
 Fri, 14 Jan 2022 10:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642156959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VPDDT5bsQZwfyAvd3Mjxc42AX5rRhhpwb5YmSuzB98M=;
 b=qxMqkZYe9IizuJSiIbl5UDmRVf8SrklbQPCgAwIGDo3k0eBoujMlLgTWk8CZR5jcF6b+B7
 ds7I1rfh/0u7Dh3rPt8NJlN6X1Zil9czDk4F37+jK8ikim5av6+zvlBbwalaxMH6ze2OwD
 Xb26CdM/fKMx0BB3rJ/02FsDEMsZC7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642156959;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VPDDT5bsQZwfyAvd3Mjxc42AX5rRhhpwb5YmSuzB98M=;
 b=xGMSNaOYwTzuG1Zt44wD+zwAoAOyevhQFHL5j3DRXmIxWceEfdre9ewpzI8X3l7OkazyLX
 LNP0al/4HrxKpECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10FFA13BFD;
 Fri, 14 Jan 2022 10:42:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id a6P1AZ5T4WE5NQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 10:42:38 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 14 Jan 2022 11:42:31 +0100
Message-Id: <20220114104231.28338-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ci/wiki-mirror: Don't check path
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

Because it's checked only from latest commit,
thus wiki does not get updated when doc change is in the latest commit
of the patchset.

Reported-by: Yang Xu <xuyang2018.jy@fujitsu.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/wiki-mirror.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/.github/workflows/wiki-mirror.yml b/.github/workflows/wiki-mirror.yml
index d138f8f226..302667255b 100644
--- a/.github/workflows/wiki-mirror.yml
+++ b/.github/workflows/wiki-mirror.yml
@@ -7,8 +7,6 @@ on:
   push:
     branches:
       - master
-    paths:
-      - 'doc/**'
 
 jobs:
   mirror:
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
