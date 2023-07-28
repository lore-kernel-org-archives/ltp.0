Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2683EC001DE
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 13:22:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1FD83CDBD8
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 15:22:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A10B33CD732
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 15:21:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1E06620004B
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 15:21:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F2341F8B0;
 Fri, 28 Jul 2023 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690550484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iMGCJsTc8CN83i2GbAAzqYGmVWFsX82L8JjN8mBOBk=;
 b=v9TxCqkkBL1wz/D+x+nI70vwyYysX1JzJrazP3WTxZAXC9tK4lumkeb/yLxK33BYau/gO/
 QD+Gi8L27UalP37WwBcc1YF+rRR3bGiEX7b9iquf2UotgxotQ27R5OhCD6xyK3YT1J3hND
 U8zNpF8nfUmqvaOXvaDJnhdJui2eqVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690550484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iMGCJsTc8CN83i2GbAAzqYGmVWFsX82L8JjN8mBOBk=;
 b=Xc3DeV9p2VhgArejiCq/nh/yPQAWyK+ryu6G0LjFs5AIncOf69BiB50jKQMSheLxyPxQcs
 0ffguK1Elv+KZRAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36FDB133F7;
 Fri, 28 Jul 2023 13:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CIoCDNTAw2RKBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Jul 2023 13:21:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Jul 2023 15:21:17 +0200
Message-ID: <20230728132120.17322-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728132120.17322-1-pvorel@suse.cz>
References: <20230728132120.17322-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] doc/shell-API: Document TST_SKIP_IN_{LOCKDOWN,
 SECUREBOOT}=1
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/shell-test-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index dde170644..4cf630dab 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -821,3 +821,8 @@ TST_NEEDS_KCONFIGS="CONFIG_EXT4_FS, CONFIG_QUOTACTL=y"
 
 . tst_test.sh
 -------------------------------------------------------------------------------
+
+1.8 Skipping test based on system state
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Test can be skipped on various conditions: on enabled SecureBoot
+('TST_SKIP_IN_SECUREBOOT=1'), lockdown ('TST_SKIP_IN_LOCKDOWN=1').
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
