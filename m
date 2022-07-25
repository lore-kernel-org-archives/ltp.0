Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB71C43334
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 10:07:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7C4E3C94FB
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 12:07:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A35D13C941D
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 12:06:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 21D6A6005F6
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 12:06:48 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C8B6B1FE9F;
 Mon, 25 Jul 2022 10:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1658743607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3heZ3cZkfbyIzAQN8p0YipcAOBZCvSBuVDecFi5xywU=;
 b=nBQduX3oyRzA6e0RaV4SnTElvpuBntA6qyvsBafQ3xOJPWOE1f8UYgz+wrieh77HP2mXCY
 Yt5YFYN310Wt9zQUXrbTlFwDQw0auIlNfKHCVnSd8kzXal1SJiHFk6+MlVrEI+hJUh4uug
 h6/AbIx6R384I4dhQXnKyIUR2qRxIC0=
Received: from g78.suse.de (unknown [10.163.24.226])
 by relay2.suse.de (Postfix) with ESMTP id 900B62C14F;
 Mon, 25 Jul 2022 10:06:47 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 25 Jul 2022 11:06:41 +0100
Message-Id: <20220725100641.11625-4-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220725100641.11625-1-rpalethorpe@suse.com>
References: <20220725100641.11625-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] read_all: Prevent FNM_EXTMATCH redefinition
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/fs/read_all/read_all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index c36203846..266678ea7 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -30,6 +30,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
+#include <fnmatch.h>
 #include <lapi/fnmatch.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -39,7 +40,6 @@
 #include <unistd.h>
 #include <string.h>
 #include <limits.h>
-#include <fnmatch.h>
 #include <semaphore.h>
 #include <ctype.h>
 #include <pwd.h>
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
