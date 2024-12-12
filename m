Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E369E7717F
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 06:05:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08AA93E2B5F
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 07:05:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9BA53D5275
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 07:05:00 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ADB5B623ADE
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 07:04:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733983497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j05csIYYvMy/vXZKjXU865OfBd8p9hLMZv+EAVfykqY=;
 b=NcpTb0N4L/N99RjnNmVypqAyXVXRtT6mlY9trGmBZtk6lpNZg6QUJOLeHQfWI2ZTG0iMvz
 xjJc0Pd1hfavhMoTU3UAx4PcMUcphCxDeomDpDp15vZNRH+kt+aWMHmEB32Q5WMtlyRFHC
 JevBC67hL43jKtazPXfhohcYz6P23W8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-r2EG-6n5NgC7o8ASLWgG0w-1; Thu,
 12 Dec 2024 01:04:55 -0500
X-MC-Unique: r2EG-6n5NgC7o8ASLWgG0w-1
X-Mimecast-MFC-AGG-ID: r2EG-6n5NgC7o8ASLWgG0w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94C09195609D
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 06:04:54 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6000D300019F
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 06:04:52 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 12 Dec 2024 14:04:48 +0800
Message-ID: <20241212060448.204158-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yv94nAdx2u-Gn5TxsK76cj9oimopq7RU7o5QNgYzFeU_1733983494
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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

The method adjusts the max_runtime for test cases by multiplying
it by a factor (4x) if any slower kernel options are detected.
Debug kernel configurations (such as CONFIG_KASAN, CONFIG_PROVE_LOCKING, etc.)
are known to degrade performance, and this adjustment ensures
that tests do not fail prematurely due to timeouts.

As Cyril pointed out that a debug kernel will typically run
slower by a factor of N, and while determining the exact value
of N is challenging, so a reasonable upper bound is sufficient
for practical purposes.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_kconfig.h | 13 +++++++++++++
 lib/tst_kconfig.c     | 39 +++++++++++++++++++++++++++++++++++++++
 lib/tst_test.c        |  3 +++
 3 files changed, 55 insertions(+)

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index 23f807409..291c34b11 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -98,4 +98,17 @@ struct tst_kcmdline_var {
  */
 void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len);
 
+/*
+ * Check if any performance-degrading kernel configs are enabled.
+ *
+ * This function iterates over the list of slow kernel configuration options
+ * (`tst_slow_kconfigs`) and checks if any of them are enabled in the running kernel.
+ * These options are known to degrade system performance when enabled.
+ *
+ * Return:
+ * - 1 if at least one slow kernel config is enabled.
+ * - 0 if none of the slow kernel configs are enabled.
+ */
+int tst_has_slow_kconfig(void);
+
 #endif	/* TST_KCONFIG_H__ */
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 6d6b1da18..92c27cb35 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -631,3 +631,42 @@ void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len)
 
 	SAFE_FCLOSE(f);
 }
+
+/*
+ * List of kernel config options that may degrade performance when enabled.
+ */
+static struct tst_kconfig_var slow_kconfigs[] = {
+	TST_KCONFIG_INIT("CONFIG_PROVE_LOCKING"),
+	TST_KCONFIG_INIT("CONFIG_LOCKDEP"),
+	TST_KCONFIG_INIT("CONFIG_DEBUG_SPINLOCK"),
+	TST_KCONFIG_INIT("CONFIG_DEBUG_RT_MUTEXES"),
+	TST_KCONFIG_INIT("CONFIG_DEBUG_MUTEXES"),
+	TST_KCONFIG_INIT("CONFIG_DEBUG_PAGEALLOC"),
+	TST_KCONFIG_INIT("CONFIG_KASAN"),
+	TST_KCONFIG_INIT("CONFIG_SLUB_RCU_DEBUG"),
+	TST_KCONFIG_INIT("CONFIG_TRACE_IRQFLAGS"),
+	TST_KCONFIG_INIT("CONFIG_LATENCYTOP"),
+	TST_KCONFIG_INIT("CONFIG_DEBUG_NET"),
+	TST_KCONFIG_INIT("CONFIG_EXT4_DEBUG"),
+	TST_KCONFIG_INIT("CONFIG_QUOTA_DEBUG"),
+	TST_KCONFIG_INIT("CONFIG_FAULT_INJECTION"),
+	TST_KCONFIG_INIT("CONFIG_DEBUG_OBJECTS")
+};
+
+int tst_has_slow_kconfig(void)
+{
+	unsigned int i;
+
+	tst_kconfig_read(slow_kconfigs, ARRAY_SIZE(slow_kconfigs));
+
+	for (i = 0; i < ARRAY_SIZE(slow_kconfigs); i++) {
+		if (slow_kconfigs[i].choice == 'y') {
+			tst_res(TINFO,
+				"%s kernel option detected",
+				slow_kconfigs[i].id);
+			return 1;
+		}
+	}
+
+	return 0;
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8db554dea..f4e667240 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -555,6 +555,9 @@ static int multiply_runtime(int max_runtime)
 
 	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
 
+	if (tst_has_slow_kconfig())
+		max_runtime *= 4;
+
 	return max_runtime * runtime_mul;
 }
 
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
