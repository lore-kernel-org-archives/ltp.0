Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EECC433FE
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 18:22:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 547253CAC01
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 20:22:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 618B13CADFD
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:28 +0200 (CEST)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DB0C46009F3
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:27 +0200 (CEST)
Received: by mail-pg1-x54a.google.com with SMTP id
 j63-20020a638042000000b00454d34199fcso1779413pgd.0
 for <ltp@lists.linux.it>; Tue, 04 Oct 2022 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date;
 bh=rEC7fZaVwbKLTCVK2ZmrGhGtlDjKS8MDTV9IgJAn7LY=;
 b=Pxe1OUG1dQdQNWeEhgCZD0tuHtuMcM5uV1AitYssy4vHFNqePoMJWL9U+qvjMIEVGx
 Xr+5nhBp9AjQyb53gEhnH47J7Ws/h2oS7U/y2LfMfYwamlaVPItcQKgZ/YlJ0lB1HTmi
 41ITKzeYqun99hpBR4vnRg84w0bkLLsgIgdE8Z6i3TFHTqJ00zHtLiBiz3rcZ0hdpPS+
 rd8mioaSKbHuyeXFEhpyzyGZnmTlDFNgV1Bz7JMZQbAlSplXfgZqK5R81WcCKOWjpC78
 PFOvGRzoNJG1hUVpNREbQN/vTTAQxCZikNubguxdK//MTjLap5ltP4W3i0WGQmP1VFm0
 ur+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=rEC7fZaVwbKLTCVK2ZmrGhGtlDjKS8MDTV9IgJAn7LY=;
 b=MwO3qZgupz6S7RVBTI7f9lwOF2emmgRjB4eHwLmejMCmotkDHbcPcSJ0gHFMv7jBNG
 T2PrUVA01u/eZVF0fHdFZmcctnEVaBaMtj1130E5mDH+wDWQB/AzEZXJsrPe9uO1zazW
 yuyKJBcUGamqVtrrt1Ozh1K9DLqmMXQQSY8u3IeTIi3/jIH0gYI+kJkwgEDZ4A7bj/e4
 We7po8Sl2alIEa1KbTkheFCb9ngDYJpqN5kvsUie0o0NyaqNlO557Ad8FOJKTW+Xdplm
 om52Mqj6Q4hlay/mYWvXlNB8xEPumlNj+DeGObxBGZNJ5MBdOLFKYMegFqGgXph/u2Qk
 lAcg==
X-Gm-Message-State: ACrzQf3fPkiCd1dz8gk72Lvt+8YrcqnM4DidiFYtBrgFhyMIsFf+2P3s
 Es6TT+6MeDln6Pp4bXdGpDCWDiL12XXLXgqc6vB3dwBv/aflqk6alApCrneFuo3ANM5uLW1Qcj2
 XJvZlQsMRjrZD4vqM/F09neuVAdWuNC7O40oUZDu+M+7UuQwyCttbtc1Z
X-Google-Smtp-Source: AMsMyM6kdLIxDGzBOI/yOG239svMz8zE8AmfpupBMxS4wYe5orYHqawBDHFiKHF3xVsdUu5hCBd/s/bk3wE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:181:b0:178:703f:689f with SMTP id
 z1-20020a170903018100b00178703f689fmr27701666plg.129.1664907686348; Tue, 04
 Oct 2022 11:21:26 -0700 (PDT)
Date: Tue,  4 Oct 2022 18:20:38 +0000
In-Reply-To: <20221004182040.1859774-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221004182040.1859774-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221004182040.1859774-8-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 7/9] mmapstress01: use SAFE_FORK
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
 testcases/kernel/mem/mmapstress/mmapstress01.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 7e8226700..99ab0d64e 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -227,12 +227,7 @@ static void run(void)
 	 *  Fork off mmap children.
 	 */
 	for (procno = 0; procno < nprocs; procno++) {
-		switch (pid = fork()) {
-
-		case -1:
-			tst_brk(TFAIL, "fork error");
-			break;
-
+		switch (pid = SAFE_FORK()) {
 		case 0:
 			child_mapper(TEST_FILE, (unsigned int)procno, (unsigned int)nprocs);
 			exit(0);
@@ -273,10 +268,8 @@ static void run(void)
 				tst_brk(TFAIL, "unknown child pid %d, <x%x>",
 					pid, wait_stat);
 
-			if ((pid = fork()) == -1) {
-				pidarray[i] = 0;
-				tst_brk(TFAIL, "fork error");
-			} else if (pid == 0) {	/* child */
+			pid = SAFE_FORK();
+			if (pid == 0) {	/* child */
 				child_mapper(TEST_FILE, (unsigned int)i, (unsigned int)nprocs);
 				exit(0);
 			} else {
@@ -485,4 +478,5 @@ static struct tst_test test = {
 	.options = options,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
+	.forks_child = 1,
 };
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
