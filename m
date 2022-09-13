Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4490DC54EE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 15:19:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A46A3CABAD
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 17:19:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FD3B3CAAD5
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 17:19:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3C6DF200C2D
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 17:19:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E42934BE9
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663082348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/pLo+rtNII3y0B71GKlt5W76F+hNLznOH2GGhoWapA=;
 b=LCWkaUvPPz4eFO7RvO5strhAsGQn1A7bpVRkqDinLyToh+Cd+bKEXtyJIFKGpReV8Z/u/m
 p1kqq/uUT6MsIp5WMn6lDwx7wnfmkAAuM24VpbiDcMjQ/z64Au5tw8xrCQR4++i0gsFsgQ
 I7Z3UUDtKmVGrI0N9rUqG88uCZe3A88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663082348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/pLo+rtNII3y0B71GKlt5W76F+hNLznOH2GGhoWapA=;
 b=E5GnOJKi7Y+LCFBIA5jy6QGI+ZymU2Q14gb2Ee+kcFMnk2zBHyvZej/92GZ7UHBpDiVNm3
 wYGHlJwQMyF/xIAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EF9F139B3
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 15:19:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gGOjCmyfIGPtUQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 15:19:08 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 13 Sep 2022 17:19:06 +0200
Message-Id: <20220913151907.26763-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220913151907.26763-1-mdoucha@suse.cz>
References: <20220913151907.26763-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] Make io_read() runtime-aware
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

Running dio_sparse with too many children can cause test timeouts
due to severe system overload. Make the children runtime aware and
switch to exit code validation.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/io/ltp-aiodio/aiodio_sparse.c | 9 +++------
 testcases/kernel/io/ltp-aiodio/common.h        | 2 +-
 testcases/kernel/io/ltp-aiodio/dio_sparse.c    | 8 ++------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
index 88aec7952..595c76226 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
@@ -188,7 +188,6 @@ static void cleanup(void)
 static void run(void)
 {
 	char *filename = "file.bin";
-	int status;
 	int i, pid;
 
 	*run_child = 1;
@@ -222,12 +221,10 @@ static void run(void)
 		}
 	}
 
-	if (SAFE_WAITPID(-1, &status, WNOHANG))
-		tst_res(TFAIL, "Non zero bytes read");
-	else
-		tst_res(TPASS, "All bytes read were zeroed");
-
 	*run_child = 0;
+
+	if (!tst_validate_children(numchildren))
+		tst_res(TPASS, "All bytes read were zeroed");
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
index d9cbd8611..68465dc54 100644
--- a/testcases/kernel/io/ltp-aiodio/common.h
+++ b/testcases/kernel/io/ltp-aiodio/common.h
@@ -85,7 +85,7 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
 				offset += r;
 			}
 
-			if (!*run_child)
+			if (!*run_child || !tst_remaining_runtime())
 				goto exit;
 		}
 	}
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index b08d2ea1e..1b5834ed4 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -96,7 +96,6 @@ static void cleanup(void)
 static void run(void)
 {
 	char *filename = "dio_sparse";
-	int status;
 	int fd;
 	int i;
 
@@ -113,13 +112,10 @@ static void run(void)
 	}
 
 	dio_sparse(fd, alignment, filesize, writesize, offset);
+	*run_child = 0;
 
-	if (SAFE_WAITPID(-1, &status, WNOHANG))
-		tst_res(TFAIL, "Non zero bytes read");
-	else
+	if (!tst_validate_children(numchildren))
 		tst_res(TPASS, "All bytes read were zeroed");
-
-	*run_child = 0;
 }
 
 static struct tst_test test = {
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
