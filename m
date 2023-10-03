Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC3CE75428
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 06:52:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90D803CC575
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 08:52:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07E9C3CB9E8
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 08:52:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 538B91400E4E
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 08:52:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 495B521891
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 06:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696315961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nLKjFHtbk08XB9SIvUuIHXPd3DE5R88ebwY+7bnNWx4=;
 b=jAczsCK+Xda8c9+sPLdKCTKtpltw7/iSi0sKxefNiUwi/PKW4eW38K+auiXnLqxU25kLIB
 cw9CpwNrIbzntr4Oi0P+o/+hnkjGKVqFTX39sL1P9kmsnV3sWwg2Yxc7Y/FcMkk0pZlbgJ
 iAF0YM3akH1YW79pz4iI2OdOi8m/JvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696315961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nLKjFHtbk08XB9SIvUuIHXPd3DE5R88ebwY+7bnNWx4=;
 b=rNX24aDYazxBjcd8B5BXxkpqnNDreCeCs2BkIlWBto2CxkFHCUHlUV/+mza45q/IM42wxn
 2zRYXhWxKaRONGDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1414139F9
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 06:52:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /9NULDi6G2UICgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 03 Oct 2023 06:52:40 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue,  3 Oct 2023 12:22:37 +0530
Message-ID: <20231003065238.31896-1-akumar@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc: Correct the reference to kernel documentation
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 doc/build-system-guide.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/build-system-guide.txt b/doc/build-system-guide.txt
index e078fa7f7..95ba3b70e 100644
--- a/doc/build-system-guide.txt
+++ b/doc/build-system-guide.txt
@@ -112,7 +112,7 @@ the module because the file does not exists, the test is skipped.
 
 Note the 'ifneq($(KERNELRELEASE),)', the reason it's there is that the
 Makefile is executed twice, once by LTP build system and once by kernel
-kbuild, see 'Documentation/kbuild/modules.txt' in the Linux kernel tree for
+kbuild, see 'Documentation/kbuild/modules.rst' in the Linux kernel tree for
 details on external module build.
 
 Make Rules and Make Variables
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
