Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB33EB64DD
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 09:15:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BA483C954B
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 11:15:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E59FE3C94B8
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 11:15:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 15F901000D5B
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 11:15:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E2C01F8B9;
 Fri, 21 Jul 2023 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689930922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHFJsUxiFpGnK1HpIdi80dSNzr226uOK6i6u+7kpxRI=;
 b=SocZYdfcWsMdbL9+kTDXAPAwFzGvCwCua4ejDMQTGkSDOxdKWPz9a1d9BxZ9uJsIKYrHrO
 9EB2X3IUbc8VLmHu8wBMpVxllM/1D2OL2ZrAtKDmu903+UsZWojKrr1IkT4Ub3V9QNE0Ih
 S+N2lC7ME5GqxAskbkOmxMLJpH71q0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689930922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHFJsUxiFpGnK1HpIdi80dSNzr226uOK6i6u+7kpxRI=;
 b=bHUewm1kT6ReKtNl7/gfpv5pb/f/d3G2e7H0nHmcjy/4J2qipBW1A3O7V3kWldLflaHq7Z
 jhwNa92Ip4AI/xDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57341134B0;
 Fri, 21 Jul 2023 09:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YIoVFKpMumRSawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 09:15:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Jul 2023 11:15:11 +0200
Message-Id: <20230721091515.1353371-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721091515.1353371-1-pvorel@suse.cz>
References: <20230721091515.1353371-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/5] tst_lockdown: Check other lockdown
 configuration
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

Originally we checked only CONFIG_EFI_SECURE_BOOT_LOCK_DOWN=y
(non-mainline patch from 2017 [1]. Various distros (older releases) use
other newer non-mainline patch [2] (originally from Fedora 32), which with
CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT=y forces lockdown, when in secure boot.

[1] https://lore.kernel.org/lkml/149141204578.30815.1929675368430800975.stgit@warthog.procyon.org.uk/
[2] https://lore.kernel.org/lkml/150842483945.7923.12778302394414653081.stgit@warthog.procyon.org.uk/

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_lockdown.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
index 26a57b6a1..4ce4736c3 100644
--- a/lib/tst_lockdown.c
+++ b/lib/tst_lockdown.c
@@ -50,11 +50,10 @@ int tst_lockdown_enabled(void)
 
 	if (access(PATH_LOCKDOWN, F_OK) != 0) {
 		char flag;
-
-		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN");
-
-		/* SecureBoot enabled could mean integrity lockdown */
-		if (flag == 'y' && tst_secureboot_enabled() > 0)
+		/* SecureBoot enabled could mean integrity lockdown (non-mainline version) */
+		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN")  == 'y';
+		flag |= tst_kconfig_get("CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT") == 'y';
+		if (flag && tst_secureboot_enabled() > 0)
 			return 1;
 
 		tst_res(TINFO, "Unable to determine system lockdown state");
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
