Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A525C6FD20
	for <ltp@archiver.kernel.org>; Tue, 21 Mar 2023 23:07:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90B823CE3BC
	for <ltp@archiver.kernel.org>; Wed, 22 Mar 2023 00:07:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34C613C5624
 for <ltp@lists.linux.it>; Wed, 22 Mar 2023 00:07:17 +0100 (CET)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 265C62009A0
 for <ltp@lists.linux.it>; Wed, 22 Mar 2023 00:07:17 +0100 (CET)
Received: by mail-pf1-x449.google.com with SMTP id
 16-20020a056a00071000b00627e9b4871eso4573257pfl.11
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 16:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679440035;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AaC5OxIwYuLKOnG5tpBa27XPELOc+MdvV/VA175rW6o=;
 b=i01xO7eUjgbzOe60FRIqi2P1VDnCb/2LMC97n5txFnUFnh6k5q8jordWlC9uvRQocE
 EwqsZNF2t9sMTF6L9CAeJENa2RvXZHBqpn0jLujmCl+9NRprpN4k1jujZj2ZaEh4bfd/
 jfsPaQupXcAowX+g4dGyE74N5cVDSR8EpZQXpxpVWVVuut+xjctcnCBLPSMYpMD4aczl
 p92feMbTOtrP3O6QxKQc8mGB8+ClKYj7JY1sbIxz4iiJGJFHgtEAnYRspBe4503HgegO
 VUXk1iE1LHFnZzQv4da6uXL1zMyM1qM90Q4j/pwZxzs+gGc9WFYOlAZu/Pfipmg1gTCS
 /i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679440035;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AaC5OxIwYuLKOnG5tpBa27XPELOc+MdvV/VA175rW6o=;
 b=iax+uHnXSBwn2G9E86VvinFSpdXCFudFS4RXx2S7hhT0TFM1MZsRt+Fgtu4ZQOA3U1
 TuqlSiTCkwZjR9Qp0Yk/nbqODHucwIWyrxs1X8n2ssXCsNMjguInzIl/eIF9vpv62+4M
 GKvR3o6dQTtfZbS1f7ki9Anfy572jj1Lyx8CRzDcVViaQAQCOszL3V/pzxghlZN2Hr6e
 DNFfLfNjMIuvEKXlDnt0rZ4Q/UdEW31D9q0aweVKznaSn4afBgzJamrzAQS/CImrij1y
 cMPC48NPr12IhMOjongEsRs0AfabFzgEYF3VuClCu8BgTS+YLDffnuaT1OskMhv7JI2u
 QeFw==
X-Gm-Message-State: AO0yUKVGibZd+TX9C6A7yU6yhM/k1DnqqZrc1K/mYzr18MeM+qEWUXTN
 dxTecBnN7mlzwsZEnIHQeA5OLR2kRG0FQ8cWb+ejXHcUaQpj+x7+bIV00F8Cnxh1eiUvML58jaj
 CTeKpUR3hSA/kZJHZtgRMgDyIY1s/yQfgk/A9e/Rgw4nGMjByUqroUBg6
X-Google-Smtp-Source: AK7set9R3CN9moLq4vSWMarg22WlKt8o6GK/YLJye3EH0wuSqM6HaZJIlWrpWVHstXpzlyXV6wXNGFkU8JU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:22c7:b0:626:2638:5a51 with SMTP id
 f7-20020a056a0022c700b0062626385a51mr868930pfj.5.1679440035222; Tue, 21 Mar
 2023 16:07:15 -0700 (PDT)
Date: Tue, 21 Mar 2023 23:07:06 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230321230706.2927611-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] hugemmap: use 64-bit types
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

Compiler throws -Wshift-count-overflow warning when compiling hugemmap13
and hugemmap14 as 32-bit. Resolve warning by using unsigned long long
that is always 64-bit.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap13.c   | 10 +++++-----
 .../kernel/mem/hugetlb/hugemmap/hugemmap14.c   | 18 +++++++++---------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
index 7235c55ac..f8c36640d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
@@ -24,7 +24,7 @@
 
 #include "hugetlb.h"
 
-#define FOURGB (1UL << 32)
+#define FOURGB (1ULL << 32)
 #define MNTPOINT "hugetlbfs/"
 static int  fd = -1;
 static unsigned long hpage_size;
@@ -33,16 +33,16 @@ static int page_size;
 static void run_test(void)
 {
 	void *p, *q = NULL;
-	unsigned long lowaddr;
-	unsigned long below_start;
-	unsigned long above_end;
+	unsigned long long lowaddr;
+	unsigned long long below_start;
+	unsigned long long above_end;
 
 	p = mmap((void *)FOURGB, hpage_size, PROT_READ|PROT_WRITE,
 		 MAP_SHARED | MAP_FIXED, fd, 0);
 	if (p == MAP_FAILED) {
 		/* slice 0 (high) spans from 4G-1T */
 		below_start = FOURGB;
-		above_end = 1024L*1024*1024*1024;
+		above_end = 1024ULL*1024*1024*1024;
 
 		if (range_is_mapped(below_start, above_end) == 1) {
 			tst_res(TINFO|TERRNO, "region 4G-IT is not free & "
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
index 13068e5b6..c54a746b3 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
@@ -24,30 +24,30 @@
 
 #include "hugetlb.h"
 
-#define FOURGB (1UL << 32)
+#define FOURGB (1ULL << 32)
 #define MNTPOINT "hugetlbfs/"
 static int  fd = -1;
-static unsigned long hpage_size;
+static unsigned long long hpage_size;
 static int page_size;
 
 static void run_test(void)
 {
 	void *p, *q = NULL, *r = NULL;
-	unsigned long lowaddr, highaddr;
-	unsigned long below_start;
-	unsigned long above_end;
+	unsigned long long lowaddr, highaddr;
+	unsigned long long below_start;
+	unsigned long long above_end;
 
 	/*
 	 * We use a low address right below 4GB so we can test for
 	 * off-by-one errors
 	 */
 	lowaddr = FOURGB - hpage_size;
-	tst_res(TINFO, "Mapping hugepage at %lx...", lowaddr);
+	tst_res(TINFO, "Mapping hugepage at %llx...", lowaddr);
 	p = mmap((void *)lowaddr, hpage_size, PROT_READ|PROT_WRITE,
 		 MAP_SHARED|MAP_FIXED, fd, 0);
 	if (p == MAP_FAILED) {
 		/* This is last low slice - 256M just before 4G */
-		below_start = FOURGB - 256L*1024*1024;
+		below_start = FOURGB - 256ULL*1024*1024;
 		above_end = FOURGB;
 
 		if (range_is_mapped(below_start, above_end) == 1) {
@@ -66,7 +66,7 @@ static void run_test(void)
 
 	/* Test for off by one errors */
 	highaddr = FOURGB;
-	tst_res(TINFO, "Mapping normal page at %lx...", highaddr);
+	tst_res(TINFO, "Mapping normal page at %llx...", highaddr);
 	q = mmap((void *)highaddr, page_size, PROT_READ|PROT_WRITE,
 		 MAP_SHARED|MAP_FIXED|MAP_ANONYMOUS, 0, 0);
 	if (q == MAP_FAILED) {
@@ -94,7 +94,7 @@ static void run_test(void)
 	 * greater.
 	 */
 	highaddr = ((lowaddr >> 28) + 128) << 28;
-	tst_res(TINFO, "Mapping normal page at %lx...", highaddr);
+	tst_res(TINFO, "Mapping normal page at %llx...", highaddr);
 	r = mmap((void *)highaddr, page_size, PROT_READ|PROT_WRITE,
 		 MAP_SHARED|MAP_FIXED|MAP_ANONYMOUS, 0, 0);
 	if (r == MAP_FAILED) {
-- 
2.40.0.rc1.284.g88254d51c5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
