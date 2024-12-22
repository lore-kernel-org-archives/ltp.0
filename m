Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4FEE77188
	for <ltp@archiver.kernel.org>; Sun, 22 Dec 2024 07:51:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7AEA3E57B1
	for <ltp@archiver.kernel.org>; Sun, 22 Dec 2024 08:51:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB6A83E281F
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 08:51:15 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C6046628588
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 08:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734853872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mal/KmyBSsjIUm65sym7CEhdFHsNV3wnJjmun/ktKeE=;
 b=KZXnh/fQ6K7V5Q89+GKB9lQ9GsfF7t5wMbWUwNenNoTUCyC2XigK2TNLg2rICke0aLfl6B
 uwftsoJmAowjefmkH/5PsxN4bz/CHsX18X1mizIit9ovZ6yajvN4NxRcTDygmtbIVJ+oeo
 tiR4H/OyaFMJE+vwnyu9uprUieXr45w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-oO_wcDodOOuKwTnHmCToQA-1; Sun,
 22 Dec 2024 02:51:10 -0500
X-MC-Unique: oO_wcDodOOuKwTnHmCToQA-1
X-Mimecast-MFC-AGG-ID: oO_wcDodOOuKwTnHmCToQA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 987471956086
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 07:51:09 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 415B91956052
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 07:51:07 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 22 Dec 2024 15:51:00 +0800
Message-ID: <20241222075102.14536-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 12apM-sQUybQ0pw2eR36HbXRPGogcXpdJ78KYx7yvWM_1734853870
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] tst_fuzzy_sync: refine code and comment
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

I just polished some things preventing me from understanding the
test logic. Hopefully, it makes things easier to read.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/newlib_tests/tst_fuzzy_sync01.c | 22 ++++++------
 lib/newlib_tests/tst_fuzzy_sync02.c | 53 ++++++++++++++++++++++++-----
 2 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
index d0748958c..d510bd2dd 100644
--- a/lib/newlib_tests/tst_fuzzy_sync01.c
+++ b/lib/newlib_tests/tst_fuzzy_sync01.c
@@ -10,7 +10,7 @@
  *
  * We make the simplifying assumptions that:
  * - Each thread contains a single contiguous critical section.
- * - The threads only interact through a single variable.
+ * - The threads only interact through a single variable(H: Hit).
  * - The various timings are constant except for variations introduced
  *   by the environment.
  *
@@ -50,9 +50,9 @@
  * range is required.
  *
  * When entering their critical sections, both threads increment the
- * 'c' counter variable atomically. They both also increment it when
- * leaving their critical sections. We record the value of 'c' when A
- * increments it. From the recorded values of 'c' we can deduce if the
+ * 'H' counter variable atomically. They both also increment it when
+ * leaving their critical sections. We record the value of 'H' when A
+ * increments it. From the recorded values of 'H' we can deduce if the
  * critical sections overlap and their ordering.
  *
  * 	Start (cs)	| End (ct)	| Ordering
@@ -90,7 +90,7 @@ struct race {
 	const struct window b;
 };
 
-static int c;
+static int H;
 static struct tst_fzsync_pair pair;
 
 static const struct race races[] = {
@@ -162,15 +162,15 @@ static void *worker(void *v)
 	const struct window b = races[i].b;
 
 	while (tst_fzsync_run_b(&pair)) {
-		if (tst_atomic_load(&c))
+		if (tst_atomic_load(&H))
 			tst_brk(TBROK, "Counter should now be zero");
 
 		tst_fzsync_start_race_b(&pair);
 		delay(b.critical_s);
 
-		tst_atomic_add_return(1, &c);
+		tst_atomic_add_return(1, &H);
 		delay(b.critical_t);
-		tst_atomic_add_return(1, &c);
+		tst_atomic_add_return(1, &H);
 
 		delay(b.return_t);
 		tst_fzsync_end_race_b(&pair);
@@ -192,9 +192,9 @@ static void run(unsigned int i)
 		tst_fzsync_start_race_a(&pair);
 		delay(a.critical_s);
 
-		cs = tst_atomic_add_return(1, &c);
+		cs = tst_atomic_add_return(1, &H);
 		delay(a.critical_t);
-		ct = tst_atomic_add_return(1, &c);
+		ct = tst_atomic_add_return(1, &H);
 
 		delay(a.return_t);
 		tst_fzsync_end_race_a(&pair);
@@ -206,7 +206,7 @@ static void run(unsigned int i)
 		else
 			critical++;
 
-		r = tst_atomic_add_return(-4, &c);
+		r = tst_atomic_add_return(-4, &H);
 		if (r)
 			tst_brk(TBROK, "cs = %d, ct = %d, r = %d", cs, ct, r);
 
diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
index afe4973b5..f95394371 100644
--- a/lib/newlib_tests/tst_fuzzy_sync02.c
+++ b/lib/newlib_tests/tst_fuzzy_sync02.c
@@ -11,7 +11,7 @@
  * We make the simplifying assumptions that:
  * - There is one data race we want to hit and one to avoid.
  * - Each thread contains two contiguous critical sections. One for each race.
- * - The threads only interact through two variables, one for each race.
+ * - The threads only interact through two variables(H: Hit, D: Avoid), one for each race.
  * - If we hit the race we want to avoid then it causes thread A to exit early.
  *
  * We don't consider more complicated dynamic interactions between the
@@ -63,14 +63,35 @@ struct race {
 	const struct window b;
 };
 
-static int c, d;
+static int H, D;
 static struct tst_fzsync_pair pair;
 
+/**
+ * Race 1:
+ *  Thread A:   |---(1)--|[1]|---(1)---|
+ *  Thread B:   |---(1)--|[1]|---(1)---|
+ *  ad (A):     |---(0)|[1]|(0)---|
+ *  bd (B):     |---(0)|[1]|(0)---|
+ *
+ * Race 2:
+ *  Thread A:   |------------------(30)------------------|[1]|---(1)---|
+ *  Thread B:   |---(1)--|[1]|---(1)---|
+ *  ad (A):     |---(0)|[1]|--(0)---|
+ *  bd (B):     |---(0)|[20]|--(0)---|
+ *
+ * Race 3:
+ *  Thread A:   |--------------------(40)--------------------|[1]|---(0)---|
+ *  Thread B:   |---(1)--|[1]|------------------(20)------------------|
+ *  ad (A):     |---(1)--|[10]|--(0)---|
+ *  bd (B):     |---(1)--|[10]|--(0)---|
+ */
 static const struct race races[] = {
 	{ .a =  { 1, 1, 1 }, .b =  { 1, 1, 1 },
 	  .ad = { 0, 1, 0 }, .bd = { 0, 1, 0 } },
+
 	{ .a =  { 30, 1, 1 }, .b =  { 1, 1,  1 },
 	  .ad = { 0,  1, 0 }, .bd = { 0, 20, 0 } },
+
 	{ .a =  { 40, 1,  0 }, .b =  { 1, 1,  20 },
 	  .ad = { 1,  10, 0 }, .bd = { 1, 10, 0 } },
 };
@@ -87,6 +108,20 @@ static void setup(void)
 	tst_fzsync_pair_init(&pair);
 }
 
+/**
+ * to_abs() - Convert relative time intervals to absolute time points
+ * @w: The input window structure containing relative time intervals
+ *
+ * This function converts relative time intervals (represented in the
+ * struct window) into absolute time points, where:
+ *
+ * - The start of the critical section is `critical_s`.
+ * - The end of the critical section is calculated as `critical_s + critical_t`.
+ * - The end of execution is calculated as `critical_s + critical_t + return_t`.
+ *
+ * Return:
+ * A new window structure (`wc`) with absolute time points.
+ */
 static struct window to_abs(const struct window w)
 {
 	const struct window wc = {
@@ -109,9 +144,9 @@ static void *worker(void *v)
 		tst_fzsync_start_race_b(&pair);
 		for (now = 0; now <= fin; now++) {
 			if (now == b.critical_s || now == b.critical_t)
-				tst_atomic_add_return(1, &c);
+				tst_atomic_add_return(1, &H);
 			if (now == bd.critical_s || now == bd.critical_t)
-				tst_atomic_add_return(1, &d);
+				tst_atomic_add_return(1, &D);
 
 			sched_yield();
 		}
@@ -132,19 +167,19 @@ static void run(unsigned int i)
 	SAFE_PTHREAD_CREATE(&pair.thread_b, 0, worker, &i);
 
 	while (tst_fzsync_run_a(&pair)) {
-		c = 0;
-		d = 0;
+		H = 0;
+		D = 0;
 		fin = a.return_t;
 
 		tst_fzsync_start_race_a(&pair);
 		for (now = 0; now <= fin; now++) {
 			if (now >= ad.critical_s &&
-			    now <= ad.critical_t && tst_atomic_load(&d) > 0)
+			    now <= ad.critical_t && tst_atomic_load(&D) > 0)
 				fin = ad.return_t;
 
 			if (now >= a.critical_s &&
-			    now <= a.critical_t && tst_atomic_load(&c) == 1) {
-				tst_atomic_add_return(1, &c);
+			    now <= a.critical_t && tst_atomic_load(&H) == 1) {
+				tst_atomic_add_return(1, &H);
 				critical++;
 			}
 
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
