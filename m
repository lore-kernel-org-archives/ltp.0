Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759E4C64EC4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 10:34:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB1B33CBF3B
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 11:34:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB0E33CB801
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 11:33:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3B3C51000D4A
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 11:33:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 117FA21E21;
 Thu,  9 Mar 2023 10:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678358031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=P0kBfU21Xi+45olUdfbk/Bk/oDlzslGFMI/AHYmraWQ=;
 b=3FbYjSeikzffCPn5PY5LtIFW1u0GjidfhVoaA7hp5RhybZHmI8qj3z/gR/Wu14WpeRSmNk
 DGonjQXxqAQl9X20xQGx49tHotowVGSiAKraQMVS3TScuLy+162U3twK3Rjsf8n+H3bJDb
 BfDdrtwn3oVulbCmje/jpyY6INQzK3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678358031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=P0kBfU21Xi+45olUdfbk/Bk/oDlzslGFMI/AHYmraWQ=;
 b=hsG7ZsBj7M94j79iq36m1JWAwNiOo8nynjynCcxOu+rLJ7qDGwrBLj2W/4gxDn4fZvV6t5
 8coYZjwu1DY1GTBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CBA013A10;
 Thu,  9 Mar 2023 10:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TABhIg62CWRlMQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Mar 2023 10:33:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Mar 2023 11:33:46 +0100
Message-Id: <20230309103346.5574-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] endian_switch01.c: Remove useless
 TST_NO_DEFAULT_MAIN
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

TST_NO_DEFAULT_MAIN must be defined before including tst_test.h.
Therefore test could have been compiled although there was no main() defined.

Fixes: 68fb61225 ("endian_switch01: rewrite to newlib")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/switch/endian_switch01.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/syscalls/switch/endian_switch01.c b/testcases/kernel/syscalls/switch/endian_switch01.c
index bee35184a..eae193fc1 100644
--- a/testcases/kernel/syscalls/switch/endian_switch01.c
+++ b/testcases/kernel/syscalls/switch/endian_switch01.c
@@ -24,8 +24,6 @@
 # define PPC_FEATURE_TRUE_LE              0x00000002
 # endif
 
-# define TST_NO_DEFAULT_MAIN
-
 /*
  * Make minimal call to 0x1ebe. If we get ENOSYS then syscall is not
  * available, likely because of:
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
