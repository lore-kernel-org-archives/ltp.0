Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA41C43334
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 08:03:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 663473C94FD
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 10:03:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41FFC3C954A
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:02:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B3B8B1400E13
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:02:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0899321C09;
 Thu, 23 Jun 2022 08:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655971354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ins6M8IlnpUlQA938KhQZLbtjkqdAjGJHIyP+rRvvFs=;
 b=fFSjE3KDyCK37JAtdwD95JOPCAI7vV+XMVJmAsyb4XyupQlEiMKQETJT7E4Yqt5Z0rp6rd
 o502vk9DU96aSFPzUJdp0h32VKE0o3xbAapeZrItQQzjHPGvq82Vpi0WPAJBHC3LAEWjrQ
 zJXuBe9PAnyNpSEuaL62d5rhZMemFUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655971354;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ins6M8IlnpUlQA938KhQZLbtjkqdAjGJHIyP+rRvvFs=;
 b=wrMG8zzutw8sYACAytzresLIOOa8gPAuEpc0IhcPSExqon4wDBtOr3QGjmi1nnn43lwAnH
 0oHRi+xiDQHSIsAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BA05133A6;
 Thu, 23 Jun 2022 08:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W/xSGxketGKAdgAAMHmgww
 (envelope-from <akumar@suse.de>); Thu, 23 Jun 2022 08:02:33 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 23 Jun 2022 13:32:12 +0530
Message-Id: <20220623080215.24186-4-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623080215.24186-1-akumar@suse.de>
References: <20220623080215.24186-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/6] utime03.c: Remove unnecessary header includes
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
 testcases/kernel/syscalls/utime/utime03.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index 2358fd70b..052846df3 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -18,10 +18,8 @@
  * - The user ID of the process has write access to the file.
  */
 
-#include <sys/types.h>
 #include <pwd.h>
 #include <utime.h>
-#include <sys/stat.h>
 #include <time.h>
 
 #include "tst_test.h"
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
