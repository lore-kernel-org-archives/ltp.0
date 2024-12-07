Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC59E7717B
	for <ltp@archiver.kernel.org>; Sat,  7 Dec 2024 08:58:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F22E93E53C9
	for <ltp@archiver.kernel.org>; Sat,  7 Dec 2024 09:58:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF4723E2DA2
 for <ltp@lists.linux.it>; Sat,  7 Dec 2024 09:58:08 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B38A1667B58
 for <ltp@lists.linux.it>; Sat,  7 Dec 2024 09:58:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733561884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QJ/uimkARRvebfdZLFGUQdVvQIreZwLHSryCDtjswDg=;
 b=JPXukj2cUReX8CGpLaoXRaGtoWcvwSInpwCELYBM25YgVxlxUDiWRDdPaxdmLR6LV78uTn
 JVg081VR2qUj4MhaxaDzpsknfE5tl3TL5hhfeE08lv7grdFygEg4fafCnsrPaB9L7x3iuY
 evOHqVS7CVJERIej82ppW+RRE/hdaus=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-eZInuqT9NOiGiMYzTlHPxg-1; Sat,
 07 Dec 2024 03:58:03 -0500
X-MC-Unique: eZInuqT9NOiGiMYzTlHPxg-1
X-Mimecast-MFC-AGG-ID: eZInuqT9NOiGiMYzTlHPxg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4A361955F39; Sat,  7 Dec 2024 08:58:01 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB7A4300019E; Sat,  7 Dec 2024 08:57:59 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sat,  7 Dec 2024 16:57:54 +0800
Message-ID: <20241207085754.159597-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zsDNbmz51sPiXExc1fd_Xu8AsJyA_UjvuOOL39yOJ3w_1733561882
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [Patch V2] lib: multiply the max_runtime if detect kernel
 debug options
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
it by a factor (4x) if any debug kernel options are detected.
Debug kernel configurations (such as CONFIG_KASAN, CONFIG_PROVE_LOCKING, etc.)
are known to degrade performance, and this adjustment ensures
that tests do not fail prematurely due to timeouts.

As Cyril pointed out that a debug kernel will typically run
slower by a factor of N, and while determining the exact value
of N is challenging, so a reasonable upper bound is sufficient
for practical purposes.

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    Hi, @Cyril, @Petr, I have no openSUSE and Ubuntu at my hands, could you
    help check if the debug configures are useful to the other two platforms?
    Or, should we add any more options there? Thanks.

 include/tst_kconfig.h | 24 ++++++++++++++++++++++++
 lib/tst_kconfig.c     | 14 ++++++++++++++
 lib/tst_test.c        |  3 +++
 3 files changed, 41 insertions(+)

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index 23f807409..18856df87 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -98,4 +98,28 @@ struct tst_kcmdline_var {
  */
 void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len);
 
+/*
+ * List of debug-kernel config options that may degrade performance when enabled.
+ */
+static const char * const tst_kconf_debug_options[][2] = {
+	{"CONFIG_PROVE_LOCKING=y", NULL},
+	{"CONFIG_LOCKDEP=y", NULL},
+	{"CONFIG_DEBUG_SPINLOCK=y", NULL},
+	{"CONFIG_DEBUG_RT_MUTEXES=y", NULL},
+	{"CONFIG_DEBUG_MUTEXES=y", NULL},
+	{"CONFIG_DEBUG_PAGEALLOC=y", NULL},
+	{"CONFIG_KASAN=y", NULL},
+	{"CONFIG_SLUB_RCU_DEBUG=y", NULL},
+	{"CONFIG_TRACE_IRQFLAGS=y", NULL},
+	{"CONFIG_LATENCYTOP=y", NULL},
+	{"CONFIG_DEBUG_NET=y", NULL},
+	{"CONFIG_EXT4_DEBUG=y", NULL},
+	{"CONFIG_QUOTA_DEBUG=y", NULL},
+	{"CONFIG_FAULT_INJECTION=y", NULL},
+	{"CONFIG_DEBUG_OBJECTS=y", NULL},
+	{NULL, NULL}
+};
+
+int tst_any_kconfig_debug_enabled(void);
+
 #endif	/* TST_KCONFIG_H__ */
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 6d6b1da18..a99147a62 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -631,3 +631,17 @@ void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len)
 
 	SAFE_FCLOSE(f);
 }
+
+int tst_any_kconfig_debug_enabled(void)
+{
+	int i;
+
+	for (i = 0; tst_kconf_debug_options[i][0] != NULL; i++) {
+		if(!tst_kconfig_check(tst_kconf_debug_options[i])) {
+			tst_res(TINFO, "Detected kernel debug options. Likely running on a debug kernel");
+			return 1;
+		}
+	}
+
+	return 0;
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8db554dea..00ac8f4f3 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -555,6 +555,9 @@ static int multiply_runtime(int max_runtime)
 
 	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
 
+	if (tst_any_kconfig_debug_enabled())
+		max_runtime *= 4;
+
 	return max_runtime * runtime_mul;
 }
 
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
