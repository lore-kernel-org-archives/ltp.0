Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8023EB64DD
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 09:16:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D7FF3C950F
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 11:16:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 804003C9481
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 11:15:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 282B01A00CAF
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 11:15:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 50CA2219F8;
 Fri, 21 Jul 2023 09:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689930923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X68fsnjPnSBiw4ognCFVZjIkP4xP0sNBUXZfwqyJJ3M=;
 b=jmiKv5x8ybw3nDry34VgoGkh9UtLBll2HhPE9ZnualLkHvamo+KVi+eSvMWCL7A4spiWNA
 hVMRg6Iird+D6Wzy47MMgf+q8IyCwQBh2He+agzggoGv86XWNC5JG9uAoaw9XjsDiHN/Sr
 m5nQFEKLyguER1v3AVFlDbyYzwiduhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689930923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X68fsnjPnSBiw4ognCFVZjIkP4xP0sNBUXZfwqyJJ3M=;
 b=fc1C6sDKI0dqwfvfRLqQakkEkdd20GW3qL2Hx7ZSvwocrosM4WBfKzD1ExyXYlOr6UT6/l
 19s1AnuU3lBR86BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F37F134B0;
 Fri, 21 Jul 2023 09:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wII+BqtMumRSawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 09:15:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Jul 2023 11:15:15 +0200
Message-Id: <20230721091515.1353371-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721091515.1353371-1-pvorel@suse.cz>
References: <20230721091515.1353371-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/5] doc/c-api: Document .skip_in_* flags
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

Reviewed-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/c-test-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 07c069ced..74871e6c8 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -2412,6 +2412,12 @@ static struct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
+1.41 Skipping test based on system state
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Test can be skipped on various conditions: on enabled SecureBoot
+('.skip_in_secureboot = 1'), lockdown ('.skip_in_lockdown = 1') or in 32-bit
+compat mode ('.skip_in_compat = 1').
+
 2. Common problems
 ------------------
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
