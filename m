Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2327610ED67C
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 14:03:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA7F63D0EF6
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 15:03:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F4713C9D7D
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 15:03:38 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 13E16600931
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 15:03:38 +0100 (CET)
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2b0c30b517aso7675075ad.3
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774620216; x=1775225016; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UjTYF6LKYAlN40yyvc1arnmsH3RA1D0DccsM+x3aZPE=;
 b=QDzHExWnF5QYnw0XSbmCUA+TBwLTMwvSJsU2JCEmxH43gtXHQJoifIsrW16q8kWiRw
 suHprm6BjTMKXGxTvyMBzNEAL0g/lsTikLk+aalH5y6WoaoVFXbb+jz9Gr2wiX1y58Z8
 Nt8Yojq5I4VfxJYEjBcwwT0jm42DwA7/sRKSMhRYri5oiGb+vwIWOjF3wpPaE7UUvBK6
 9LPz5zSpW+2fnO+L9+9LM/FoIYVibC3UDCbFZG9QYz6S59Tqlhkes1orS4Y2rOY5lB7l
 32ocjp/4zAC8gede953w56x9lHSILU5nQ1A2Djkg3jHLe0k7ewXCIpEGH6nWhPO29G64
 tYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774620216; x=1775225016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UjTYF6LKYAlN40yyvc1arnmsH3RA1D0DccsM+x3aZPE=;
 b=ijFlfLnG+0gIZ5FdA0nyvqN9hj6p36CqRQLdg/5P2Qjcw4vKyVEfum2Hn9NRmfewtx
 ez+d4UP/rhd/sPPagmg2FUZrOvoAGzMqT208/iKDr6NEx3e/LvZImFJIU8jUiIEnJcct
 EN+VhHAT5UH04F2LxmcI3ds8M2D+d7SYpxmrUN98RDkHL+nwfsStPcijRJ5n28/HRURO
 HbI2tUIRhnEPfEjbsx1jQvyTtKVXlOkete9hdn/1fo+MHiQw15mF7AF4gbL67YJ9C+Hh
 bee3YKdbE+vos8yyPMJjclaWmawUEZpfcvf6m3RyV4pQWbQCV5HPQ48MLRhyeemA2MXx
 WThA==
X-Gm-Message-State: AOJu0Ywo1qYO6mR6lcUSoDD3fEjZau5KEcXrAZIhqsivOhVqyLZrFHw1
 PqRrdcMMtLpdpbwzleJzTDGJILRp87WgXVEbjuLttXLNID/ApvmJFmQlw7Nu6b/0Uw==
X-Gm-Gg: ATEYQzyOzyjUgTpnDqqPebsiyej+pIUHFw3dN1/eGvIgqrPJHOIoVZV+UBlh41gJQzW
 gIUxBlYQbKeQ6lbyBQRhxgNxQgw1nHxN1hhZUkiVdYZvqogsOVlY1if3tQWZpADUtD1pWkILa0R
 q/h8avkNstDV3Vrmm4eIDfiwkiRqdU+9FkkW7OBpAF4S7HtkYwYwx1xofC8yi76G8I3Xcm2wUTW
 iwc1Cm3pO+o+scxRX1D7aBPYu+3EAaEEL2cVlgCkQdLc6Bza7JAoorQzkUFl7GttmyGujtQZ1IU
 0Bbm5og4SJkXsyOi3W4bAqvlnQeR4mStfM3XAipF/fX5L6ckB319RXxSZZk92Hqqc01xsqO6ZG5
 KanNKC8xbpkX6sPYvF8D1YToxPlIVC8BLAucArB1waAEbBcBrVGPW8xctSPoCC/GRlsvMLwWrvY
 fT4R6R79t0uI0Mgg+GlK+8UhbFTFwoY9ZzdQ18p8ul/A==
X-Received: by 2002:a17:902:d584:b0:2ae:572a:9f19 with SMTP id
 d9443c01a7336-2b0cdcb9f86mr28829275ad.21.1774620216258; 
 Fri, 27 Mar 2026 07:03:36 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc76f184sm62962985ad.9.2026.03.27.07.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 07:03:35 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Fri, 27 Mar 2026 23:03:08 +0900
Message-ID: <20260327140310.2306-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69c403b7.050a0220.1389b1.789b@mx.google.com>
References: <69c403b7.050a0220.1389b1.789b@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] open: fix cleanup condition and use snprintf
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
 testcases/kernel/syscalls/open/open04.c | 26 ++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/kernel/syscalls/open/open04.c
index 7573af1c8..6ec18cbfa 100644
--- a/testcases/kernel/syscalls/open/open04.c
+++ b/testcases/kernel/syscalls/open/open04.c
@@ -15,9 +15,10 @@

 #define FNAME "open04"

-static int fds_limit, first, i;
+static int fds_limit;
+static int first = -1;
 static int *fds;
-static char fname[20];
+static char fname[PATH_MAX];

 static void setup(void)
 {
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
+	if (first >= 0 && fds) {
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
