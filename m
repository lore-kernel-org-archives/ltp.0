Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F84C4332F
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 18:43:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 652983CAE16
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 20:43:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9D753CAE19
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 20:42:40 +0200 (CEST)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 12143200906
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 20:42:39 +0200 (CEST)
Received: by mail-pg1-x54a.google.com with SMTP id
 i22-20020a63e456000000b0043c096be700so1569619pgk.1
 for <ltp@lists.linux.it>; Thu, 06 Oct 2022 11:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fs/g4ceviddRj94qRr3GTCXfkosY6eqByvK6X+g3Ngw=;
 b=aJeV9rtLnRCV69WKFypvEzzkqqmRVauRae9yGAnUKonNtfaehILmlooce8E9z7fIpI
 PZeGG1vi9FysGOwSd7CIIyY/3lvPeeqnz6he5sjccTjo/8Eg628LsR8nQ3veputLT73s
 H6VBWsoBLdQDdy01kXYB3fZwieVZs/gDcgAz6X+7XSJdZSSThElmtk2RwxVgSaG4ahsT
 tH9S6GghHB1eXQtskKVetKNpg39AVo52W4aymjr40fWwQqGNB03clgceuCw4ogxQvEf8
 b1zCKJZRgGMNMbCEHn6ry0XJX0TVgsBvPnhG7hNjmNqGS0fiBDyfEEb+WD2UcwnMEIg3
 MMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fs/g4ceviddRj94qRr3GTCXfkosY6eqByvK6X+g3Ngw=;
 b=ZzbzUpqfkixdPmm/GxM55s1MiEOtb8IwuwK4tmd6dkUzFAFuGbuD8jgRXGYqiCes+x
 EPnh+KUXZZcjco7IvPYue3pFc38/xlWX2fFSs2lLjgq6WTIQVWNOZVtNC3VNX5GeMmNU
 RBwoEd59bMm+PTTolLuIO04s5hsTmhEcWJ8jW/1jsGkQAlaBRCk9+CfeVj5B6ccySvnE
 j71wbAPkJxGJzyD1q6w0ot9FD+scfYiAFE4aIgXNAhJ9tYLuw+CW7QtL5jzcrduojK4C
 jw2p5zerhBvRlpLpCQZoaOSJV1E7S48WWzI/Q6EDcafZcHmjMNeGOAqrZp37jixe8CGv
 aAkg==
X-Gm-Message-State: ACrzQf1EJXYOc9AH+84f+u7utblPkll1ju3JjXd/qXi7c+WUsi/EWLrG
 d/kJBl+iK47uyxg8S9JoTkklrJMC7Zzok53VCptq1nQ5uQXeqmkJkVEF09RTRrIRQmP70tJMThg
 F60vL1Z2gzfEtK/IKSF1p7Qnl4X+TxuKJ9wKE2aHZQ1T+i62cfKvUtd/y
X-Google-Smtp-Source: AMsMyM7lzpth3GMsGBumzpurp9JUQLPDMihQS6TbOFoZUJznj3KAwzhZ4m7TPHkaEnk3c22LsGpPbpFGdV0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:5807:0:b0:459:a31a:80c2 with SMTP id
 g7-20020a655807000000b00459a31a80c2mr1029153pgr.27.1665081757410; Thu, 06 Oct
 2022 11:42:37 -0700 (PDT)
Date: Thu,  6 Oct 2022 18:42:27 +0000
In-Reply-To: <20221006184228.3281392-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221006184228.3281392-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006184228.3281392-4-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/4] mmapstress01: return TBROK for unexpected
 failures and TERRNO if syscall fails
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/mem/mmapstress/mmapstress01.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 67a2b747d..9a18587cf 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -155,7 +155,7 @@ static void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 	fd = SAFE_OPEN(file, O_RDWR);
 
 	if (statbuf.st_size - sparseoffset > UINT_MAX)
-		tst_brk(TFAIL, "size_t overflow when setting up map");
+		tst_brk(TBROK, "size_t overflow when setting up map");
 	mapsize = (size_t) (statbuf.st_size - sparseoffset);
 	mappages = roundup(mapsize, pagesize) / pagesize;
 	offset = sparseoffset;
@@ -212,7 +212,7 @@ static void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 		paddr = maddr + (randpage * pagesize);	/* page address */
 		if (msync(paddr, (mappages - randpage) * pagesize,
 			  MS_SYNC) == -1)
-			tst_brk(TFAIL, "msync failed");
+			tst_brk(TBROK | TERRNO, "msync failed");
 	}
 	SAFE_MUNMAP(maddr, mapsize);
 	exit(0);
@@ -237,7 +237,7 @@ static void fileokay(char *file, unsigned char *expbuf)
 	SAFE_LSEEK(fd, sparseoffset, SEEK_SET);
 
 	if (statbuf.st_size - sparseoffset > UINT_MAX)
-		tst_brk(TFAIL, "size_t overflow when setting up map");
+		tst_brk(TBROK, "size_t overflow when setting up map");
 	mapsize = (size_t) (statbuf.st_size - sparseoffset);
 
 	mappages = roundup(mapsize, pagesize) / pagesize;
@@ -383,13 +383,13 @@ static void run(void)
 			 */
 			if (!WIFEXITED(wait_stat)
 			    || WEXITSTATUS(wait_stat) != 0)
-				tst_brk(TFAIL, "child exit with err <x%x>",
+				tst_brk(TBROK, "child exit with err <x%x>",
 					wait_stat);
 			for (i = 0; i < nprocs; i++)
 				if (pid == pidarray[i])
 					break;
 			if (i == nprocs)
-				tst_brk(TFAIL, "unknown child pid %d, <x%x>",
+				tst_brk(TBROK, "unknown child pid %d, <x%x>",
 					pid, wait_stat);
 
 			pid = SAFE_FORK();
@@ -406,7 +406,8 @@ static void run(void)
 			 *  error...
 			 */
 			if (errno != EINTR || !finished)
-				tst_brk(TFAIL, "unexpected wait error");
+				tst_brk(TBROK | TERRNO,
+					"unexpected wait error");
 		}
 		SAFE_SIGPROCMASK(SIG_UNBLOCK, &set_mask, NULL);
 	}
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
