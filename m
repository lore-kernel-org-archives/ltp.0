Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99374ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 13:44:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 390463CAC02
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 15:44:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43A193CABBF
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 15:43:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 74FEC601EA0
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 15:43:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A190C1FAA5
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663163014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSzNhQpvGx+wtoemG3pXIJPEyyI3Oyup9L/FR/N+MxM=;
 b=mYdVVNFr3AtfDHHmXxtZGMogexV+vmjW3j9wfifMasqnpGBQcc0Bmn8xLrD0VJfOGtFroZ
 IN6VGiungJGCyp8a/hSmAOFSaAr+vXvvnHgw/3rp7h3obAMdSOf7E4ZQn9XAPgZZS9BZ44
 PY43+k554XB2EYE7i/7tXgH9mIAIM+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663163014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSzNhQpvGx+wtoemG3pXIJPEyyI3Oyup9L/FR/N+MxM=;
 b=AxKxEVGQbU0rQcuvdnM3e2TT6ImviXMVqGnEeiS02U50x294ubLr6cndNGBii/L2cgr6cv
 lHpuCb8NddqRcbCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9065713494
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 13:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qLheIobaIWN1IgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 13:43:34 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 14 Sep 2022 15:43:32 +0200
Message-Id: <20220914134333.13562-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914134333.13562-1-mdoucha@suse.cz>
References: <20220914134333.13562-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] Make io_read() runtime-aware
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

Changes since v1: None

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
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
