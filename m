Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DCCE77188
	for <ltp@archiver.kernel.org>; Sun, 22 Dec 2024 07:52:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95D8E3E55F0
	for <ltp@archiver.kernel.org>; Sun, 22 Dec 2024 08:52:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 653853E57B6
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 08:51:22 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 839E763F3BD
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 08:51:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734853879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vqXLhVxqMQBm+fy9e9gp6AhXIYu6ko0OFk8cncUN+g8=;
 b=JOG0Wq3jJCXN8LrfVmy0y22mz6Ua57bk42jqug50/Ls97wG7OKTZjWzuYoQWNWMrxME4u5
 1b592wN1MS/yCbJxajkuokybtgVVx/I+TlM0W9Pcipr9VmhyBrak/lpQvJmMWKjqcqWKTi
 tzcJsPJgx1/PTPy2wCYy8R1Yt1HMtNg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-yXp2VQ0uMZqYXRg_JrnnEg-1; Sun,
 22 Dec 2024 02:51:12 -0500
X-MC-Unique: yXp2VQ0uMZqYXRg_JrnnEg-1
X-Mimecast-MFC-AGG-ID: yXp2VQ0uMZqYXRg_JrnnEg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7923195608B
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 07:51:11 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7596A1956052
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 07:51:09 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 22 Dec 2024 15:51:01 +0800
Message-ID: <20241222075102.14536-2-liwang@redhat.com>
In-Reply-To: <20241222075102.14536-1-liwang@redhat.com>
References: <20241222075102.14536-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gQW9rQzXtjGsX5xhJ0gXn-oBLDJNyLoCURuXizUUSCM_1734853872
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] tst_fuzzy_sync: ingnore test result if loop
 termination occurs
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

This patch updates the behavior of tst_fuzzy_sync tests to address
scenarios where test results may be unreliable due to resource constraints.

Specifically, if pair->exit is set (indicating exceeded loop termination),
the test result is ignored, and a TCONF status is returned. This ensures
invalid results are not falsely reported as failures or successes.

  tst_fuzzy_sync.h:654: TINFO: Exceeded execution loops, requesting exit
  /lib/newlib_tests/tst_fuzzy_sync02.c:164: TFAIL: 2| =:15

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/newlib_tests/tst_fuzzy_sync01.c | 21 +++++++++++++++++++++
 lib/newlib_tests/tst_fuzzy_sync02.c | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
index d510bd2dd..c8c195859 100644
--- a/lib/newlib_tests/tst_fuzzy_sync01.c
+++ b/lib/newlib_tests/tst_fuzzy_sync01.c
@@ -212,10 +212,31 @@ static void run(unsigned int i)
 
 		if (critical > 100) {
 			tst_fzsync_pair_cleanup(&pair);
+			tst_atomic_store(0, &pair.exit);
 			break;
 		}
 	}
 
+	/*
+	 * If `pair->exit` is true, the test may fail to meet expected
+	 * results due to resource constraints in shared CI environments
+	 * (e.g., GitHub Actions). Limited control over CPU allocation
+	 * can cause delays or interruptions in CPU time slices due to
+	 * contention with other jobs.
+	 *
+	 * Binding the test to a single CPU core (e.g., via `taskset -c 0`)
+	 * can worsen this by increasing contention, leading to performance
+	 * degradation and premature loop termination.
+	 *
+	 * To ensure valid and reliable results in scenarios (e.g., HW, VM, CI),
+	 * it is best to ingore test result when loop termination occurs,
+	 * avoiding unnecessary false postive.
+	 */
+	if (pair.exit) {
+		tst_res(TCONF, "Test may not be able to generate a valid result");
+		return;
+	}
+
 	tst_res(critical > 50 ? TPASS : TFAIL,
 		"acs:%-2d act:%-2d art:%-2d | =:%-4d -:%-4d +:%-4d",
 		a.critical_s, a.critical_t, a.return_t,
diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
index f95394371..ad19a675e 100644
--- a/lib/newlib_tests/tst_fuzzy_sync02.c
+++ b/lib/newlib_tests/tst_fuzzy_sync02.c
@@ -192,10 +192,31 @@ static void run(unsigned int i)
 
 		if (critical > 100) {
 			tst_fzsync_pair_cleanup(&pair);
+			tst_atomic_store(0, &pair.exit);
 			break;
 		}
 	}
 
+	/*
+	 * If `pair->exit` is true, the test may fail to meet expected
+	 * results due to resource constraints in shared CI environments
+	 * (e.g., GitHub Actions). Limited control over CPU allocation
+	 * can cause delays or interruptions in CPU time slices due to
+	 * contention with other jobs.
+	 *
+	 * Binding the test to a single CPU core (e.g., via `taskset -c 0`)
+	 * can worsen this by increasing contention, leading to performance
+	 * degradation and premature loop termination.
+	 *
+	 * To ensure valid and reliable results in scenarios (e.g., HW, VM, CI),
+	 * it is best to ingore test result when loop termination occurs,
+	 * avoiding unnecessary false postive.
+	 */
+	if (pair.exit) {
+		tst_res(TCONF, "Test may not be able to generate a valid result");
+		return;
+	}
+
 	tst_res(critical > 50 ? TPASS : TFAIL, "%d| =:%-4d", i, critical);
 }
 
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
