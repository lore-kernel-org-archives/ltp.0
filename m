Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E872106B518
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 12:22:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18CFA3E2FFB
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 13:22:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDF303E143F
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 13:22:32 +0100 (CET)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 556162003B7
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 13:22:32 +0100 (CET)
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-35a1f549e7eso2940805a91.0
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774441351; x=1775046151; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cchd8EY3LQZrecvPfqdSCw1FSJxa+On/v7sif/CBCMA=;
 b=a1YcgR+tkuITu8XHzrj+q0ZT2wJ9Rg1NsoukdTMrnVKSOFYtxqubNbhIx9dI5OmUnS
 wcukoCi/JB+0dL3ebrQjohp/zGZAP+LGOuayAhXUX4P3Jb7Z1epYYGYtI9z/zgrq7xZ1
 Du/fTCM2nYgIBA9cmvkIE5MtI5+uA5Zhp6YWYiNl0DjKZAuReNkOH+D/69mN7XnMDyrL
 klvDjZks8pWL29sTRbqLzfujWU1+EXBTbZJkZeQ7GbhUuF4WyGm8TyoRlcQwAG/gAMhf
 fyTTnKrfBU2P5CpFYkgeAddxIYxjOnBUvnB14G6khdssto3xVPwMc7V/e7lAoyHkzQ/E
 NEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774441351; x=1775046151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cchd8EY3LQZrecvPfqdSCw1FSJxa+On/v7sif/CBCMA=;
 b=kctYtPf/sNXXk3dNdkUUm+WfmahyqWEBjCvAuAuNECi9xBSoYyqAteuG6Y5CKjRJ8B
 0Ik7YLQ/oKNPLCNCINjPZTLepHRg3CDnCS03w6fMzH2UFR8psaHK//pmhTLDSZTuHx14
 yRYMj4uzHVUGUByXGhRDa8QMvdtrsW64V9JnXV7O4ytmPACJxf5UjWbnBubL+k04Iuel
 DA26ecUGQ35zzyKxXVBBF8w/x9gZmWZ2fdEALLkXW8X+fyM1bxB7bsBZ2hs3M3nvdU1d
 DtMihz9mdrNSLTBpDSZvGI+noPLdtHO2Dt97utAUklzrL0mkZySRqUcg+lRiTEMLtNsg
 Zjqg==
X-Gm-Message-State: AOJu0YxizLhBPi+mbJ7cCp1frP5w+MnucxcLoiUlbhKfsUPgwN1NORUq
 lXsJvwozN12EtQyftLPLlJ0IpCb2nVv//WI8WBo29Vsq5Sj2K+N50ZkWKD5uhc0lOQ==
X-Gm-Gg: ATEYQzwgZqLNpI0eWPzRhlibMV2X8dZe4qOrNJln8jzRMoI6hVFqjeSdQTcg1ab3rTA
 yPQr2C9gaievzBK6q+V30+OpAz3N07KP98rJhCMIwMpQuQS/8bJEK/f8JgsMBRXOtGHDsrODAd5
 gSBkzUkppcfNyP9SoGDbR8+Mgo+efeF+/z1xtdUN3qlcgLH4lRPY5vpFKG/45x+Biktp2c+wPja
 5l6QLajz5YrasU5MU+f7qYpAHJF0Ub4tTAEwCDVxeTO0dCJP++avtzEc9Z+63gykfws/DNfuiHp
 0qzpifx3aALiDDYQS2pCd22nFetN/hs4FVjtRH+GP5Xm2B1m6miGndHJ1rntkMHQxvY39GsRu7R
 y3SQ8TnjSScpBWja/INytjE760XarU4WcCZAWPvz0lVeR4LEFajnzKpc3VAw8J9dWrCjXKMs2Yp
 Ks5Aso86nsb/wUu2EcsZFHdUveutOViJneMwFEcmjG301V
X-Received: by 2002:a17:90b:2dd2:b0:35c:854:d1d0 with SMTP id
 98e67ed59e1d1-35c0dd94e96mr3029293a91.26.1774441350643; 
 Wed, 25 Mar 2026 05:22:30 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c0dd77c57sm831731a91.5.2026.03.25.05.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 05:22:30 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Wed, 25 Mar 2026 21:22:05 +0900
Message-ID: <20260325122207.1967-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69c0e189.050a0220.8a4b1.49b0@mx.google.com>
References: <69c0e189.050a0220.8a4b1.49b0@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] open: fix cleanup condition and use snprintf
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Replace sprintf() with snprintf() for safer string handling.

The cleanup logic checked '!first' to decide whether to close file
descriptors. Since file descriptor 0 is valid, this may incorrectly
skip cleanup and leak descriptors.

Also initialize "first" to -1 and set the fds array to -1 after
allocation. Skip such entries in cleanup() to avoid calling SAFE_CLOSE()
on invalid file descriptors.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/open/open04.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/kernel/syscalls/open/open04.c
index 7573af1c8..3457024fc 100644
--- a/testcases/kernel/syscalls/open/open04.c
+++ b/testcases/kernel/syscalls/open/open04.c
@@ -15,7 +15,8 @@

 #define FNAME "open04"

-static int fds_limit, first, i;
+static int fds_limit;
+static int first = -1;
 static int *fds;
 static char fname[20];

@@ -29,10 +30,11 @@ static void setup(void)
 	first = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0777);

 	fds = SAFE_MALLOC(sizeof(int) * (fds_limit - first));
+	memset(fds, -1, sizeof(int) * (fds_limit - first));
 	fds[0] = first;

-	for (i = first + 1; i < fds_limit; i++) {
-		sprintf(fname, FNAME ".%d", i);
+	for (int i = first + 1; i < fds_limit; i++) {
+		snprintf(fname, sizeof(fname), FNAME ".%d", i);
 		fd = open(fname, O_RDWR | O_CREAT, 0777);
 		if (fd == -1) {
 			if (errno != EMFILE)
@@ -46,20 +48,22 @@ static void setup(void)

 static void run(void)
 {
-	sprintf(fname, FNAME ".%d", fds_limit);
+	snprintf(fname, sizeof(fname), FNAME ".%d", fds_limit);
 	TST_EXP_FAIL2(open(fname, O_RDWR | O_CREAT, 0777), EMFILE);
 }

 static void cleanup(void)
 {
-	if (!first || !fds)
-		return;
+	if (first >= 0) {
+		int limit = fds_limit - first;

-	for (i = first; i < fds_limit; i++)
-		SAFE_CLOSE(fds[i - first]);
+		for (int i = 0; i < limit; i++) {
+			if (fds[i] != -1)
+				SAFE_CLOSE(fds[i]);
+		}
+	}

-	if (fds)
-		free(fds);
+	free(fds);
 }

 static struct tst_test test = {
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
