Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8122CC00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 10:10:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDE633CA1B8
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 12:10:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F9CF3CA15B
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 12:09:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1659D1A006F1
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 12:09:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C4A635BCEE;
 Thu, 18 Aug 2022 10:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660817391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C/j0+q+ZoxnzhMXXxHi3CKdCKJ2vDCwVk5MiDahtu70=;
 b=HJLZv5Ha3qQXzuvWtfjNvDxTim06utjgNZTmtqclv8Lt4zHPnjfmmJnpI+vKpL7SGmBAA9
 fMdOm2TXjn/tdFeCMLF5AZhjMvS4i7NurLsovHEy34JYMF5wyV/Y6YVOagOQHicTDYhvBR
 RxmxaznMyd9VQCXVh3MQZDiCGROMMHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660817391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C/j0+q+ZoxnzhMXXxHi3CKdCKJ2vDCwVk5MiDahtu70=;
 b=eXUPhzKIotKURvXPcnTweUa8qvqv4//J2eKWrPjyDZ/MsDjZR6BoODoh0x6mazEn3mOa8H
 u07Hvd0KeANRrAAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 325E8139B7;
 Thu, 18 Aug 2022 10:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0BwFCe8P/mIBDAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 18 Aug 2022 10:09:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 18 Aug 2022 12:09:45 +0200
Message-Id: <20220818100945.7935-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818100945.7935-1-pvorel@suse.cz>
References: <20220818100945.7935-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] lib/tests: Increase .dev_min_size
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

New LTP default for device size was increased to 300MB in previous
commit, which is the same as for test of .dev_min_size. Therefore
increase test of .dev_min_size to 310MB.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/tst_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
index 8ac1d14cc..87cec3961 100644
--- a/lib/newlib_tests/tst_device.c
+++ b/lib/newlib_tests/tst_device.c
@@ -15,7 +15,7 @@
 #include "tst_test.h"
 
 #define DEVBLOCKSIZE 2048
-#define DEV_MIN_SIZE 300
+#define DEV_MIN_SIZE 310
 
 static char *mntpoint;
 static uint64_t ltp_dev_size;
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
