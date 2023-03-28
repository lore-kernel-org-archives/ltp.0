Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21939C6FD18
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 13:19:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0A6E3CCB96
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 15:19:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2266C3CCAFA
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 15:18:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 118EA1A010F7
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 15:18:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9217B1FD68
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680009504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QjPekt6oXeCXc6SJnNUBL7ube77lkqJ01+nTp7zlNc=;
 b=qiiFLi0jw7QihgbV1MnrU6C6mcjWedJA3pcWm1o+MIK7/NCaVqNjZPv2gOWnp3QLGpx0A1
 XInsTujo6BZgNABkqJb/btOi4Gtu7ANdqUxy99HYnBhaPK+rgP7Rx5gvdrf22Ka9o8iafJ
 malHaZk0f6v1yqSKIe24SQHQvvTGVF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680009504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QjPekt6oXeCXc6SJnNUBL7ube77lkqJ01+nTp7zlNc=;
 b=3JBDEZ7gZIFWOynIdTq3twnVE/Utm8Ru89KR0lpOU5pqGUHv5PQeXkGE49NDHja8gBX5yt
 4MvbfRf6P3gTZdBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B3341390D
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gRO7HCDpImQUUQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:18:24 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 Mar 2023 15:19:32 +0200
Message-Id: <20230328131935.21945-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328131935.21945-1-chrubis@suse.cz>
References: <20230328131935.21945-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] lib: include tst_device.h in tst_device.c
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

+ Fix broken function prototype

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_device.h | 2 +-
 lib/tst_device.c     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 39545fab0..36258f436 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -49,7 +49,7 @@ int tst_clear_device(const char *dev);
  * free loopdev). If path is non-NULL, it will be filled with free loopdev path.
  *
  */
-int tst_find_free_loopdev(const char *path, size_t path_len);
+int tst_find_free_loopdev(char *path, size_t path_len);
 
 /*
  * Attaches a file to a loop device.
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 892e0b2e6..0cdd8985e 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -38,6 +38,7 @@
 #include "lapi/syscalls.h"
 #include "test.h"
 #include "safe_macros.h"
+#include "tst_device.h"
 
 #ifndef LOOP_CTL_GET_FREE
 # define LOOP_CTL_GET_FREE 0x4C82
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
