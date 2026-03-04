Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B3CEDEC04
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 03:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772595669; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=gp09zXfffnA7xH3YjVfwIVkVeopOvO9Hh6xQECm6B/Q=;
 b=JA32XO8Q0vPdE1DKCZ/OOy2O86X2HXV8IH741xHAia22PvdA398zDHi2WO75pXHBGQ20q
 j2TLkJK7HK4aq+s0GP4kGF0nRLd41jdjYtWs1ufJJON+hGZ0gnqJtOO2YMG+tfLyRPLXQkq
 V2kco9weZ9HvKaHexeA3fAa7UimUKSA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B2CF3D6F74
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 04:41:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D2783CAF08
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 04:40:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 966C61000453
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 04:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772595643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mriX03uU5llSYenKrB7o/uRDty95r+ySWZQycywc7TA=;
 b=Jlq3g0qEpUlpYzdRlDu1uDNCf1Kax2OZ3WRD2VIrdYLoROAeXWPFQgyaUPJs2dymB9VhGb
 e/gufkLTCvvK8YqJZgchq10qjjbArO15Hy4mnuEC6QSAOY4ndVdLkAn7m6woYbYY9n5nKm
 PIgv8u+blPZgL2XGwT/xohR7MLcEU7g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-qHCaKzriM_i1QpBBwAbTIA-1; Tue,
 03 Mar 2026 22:40:41 -0500
X-MC-Unique: qHCaKzriM_i1QpBBwAbTIA-1
X-Mimecast-MFC-AGG-ID: qHCaKzriM_i1QpBBwAbTIA_1772595640
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94D141800365
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 03:40:40 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.173])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68AE8195608E
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 03:40:38 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed,  4 Mar 2026 11:40:33 +0800
Message-ID: <20260304034034.59303-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BdgGd3jtIZ7LjG3k1hxwP00WAoTVFJRa3_I4vDgUPJo_1772595640
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] lib: Extend -D flag to support multiple debug
 levels
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch extends the LTP debugging framework by introducing multiple
levels of verbosity for the '-D' command line option. Instead of a simple
on/off toggle, it now allows developers to specify whether they want debug
output exclusively from the test process, or from both the test and library
processes.

The supported debug levels are:
  -D1 (-D): Enable debug logs for the test process only
  -D2     : Enable verbose debug logs for both the test and library processes

Suppress all debug logs if no '-D' flag passed (by default behavoir).

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    v2 --> v3:
    	* do not print "Enabling debug info" for -D0
    	* drop the -D0 support becase it's the default behavor.

 doc/developers/debugging.rst |  7 +++++++
 lib/tst_test.c               | 27 ++++++++++++++++-----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/doc/developers/debugging.rst b/doc/developers/debugging.rst
index 181e5b096..dcb287bb6 100644
--- a/doc/developers/debugging.rst
+++ b/doc/developers/debugging.rst
@@ -12,6 +12,13 @@ The LTP framework supports ``TDEBUG`` flag test debug messages. These
 messages can be enabled using the ``-D`` parameter or setting ``LTP_ENABLE_DEBUG=1``
 environment variable (see :doc:`../users/setup_tests`).
 
+The ``-D`` parameter also supports the following verbosity levels:
+
+  ``-D1`` (or ``-D``): Enable debug logs for the test process only.
+  ``-D2``: Enable verbose debug logs for both the test and library processes.
+
+Suppress all debug logs if no '-D' flag passed (by default behavoir).
+
 Tracing and debugging syscalls
 ------------------------------
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 239494b6f..e01c14638 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -83,7 +83,7 @@ struct context {
 	tst_atomic_t abort_flag;
 	uint32_t mntpoint_mounted:1;
 	uint32_t ovl_mounted:1;
-	uint32_t tdebug:1;
+	uint32_t tdebug;
 };
 
 struct results {
@@ -216,8 +216,7 @@ void tst_reinit(void)
 	tst_futexes = ipc->futexes;
 	tst_max_futexes = (size - offsetof(struct ipc_region, futexes)) / sizeof(futex_t);
 
-	if (context->tdebug)
-		tst_res(TINFO, "Restored metadata for PID %d", getpid());
+	tst_res(TDEBUG, "Restored metadata for PID %d", getpid());
 }
 
 extern char **environ;
@@ -490,19 +489,20 @@ void tst_res_(const char *file, const int lineno, int ttype,
 	va_list va;
 
 	/*
-	 * Suppress TDEBUG output in these cases:
+	 * Control TDEBUG output in these cases:
 	 * 1. No context available (e.g., called before IPC initialization)
-	 * 2. Called from the library process, unless explicitly enabled
-	 * 3. Debug output is not enabled (context->tdebug == 0)
+	 * 2. Debug output is completely disabled (default: context->tdebug == 0).
+	 * 3. Debug output is only for test process (context->tdebug == 1).
+	 * 4. Debug output is enabled for both test and lib processes (context->tdebug == 2).
 	 */
 	if (ttype == TDEBUG) {
 		if (!context)
 			return;
 
-		if (context->lib_pid == getpid())
+		if (context->tdebug == 0)
 			return;
 
-		if (!context->tdebug)
+		if (context->tdebug == 1 && context->lib_pid == getpid())
 			return;
 	}
 
@@ -657,7 +657,7 @@ static struct option {
 	{"h",  "-h       Prints this help"},
 	{"i:", "-i n     Execute test n times"},
 	{"I:", "-I x     Execute test for n seconds"},
-	{"D",  "-D       Prints debug information"},
+	{"D::", "-D[1,2]  Prints debug information"},
 	{"V",  "-V       Prints LTP version"},
 };
 
@@ -825,8 +825,13 @@ static void parse_opts(int argc, char *argv[])
 			tst_brk(TBROK, "Invalid option");
 		break;
 		case 'D':
-			tst_res(TINFO, "Enabling debug info");
-			context->tdebug = 1;
+			if (optarg)
+				context->tdebug = SAFE_STRTOL(optarg, 1, 2);
+			else
+				context->tdebug = 1;
+
+			if (context->tdebug)
+				tst_res(TINFO, "Enabling debug info (level %d)", context->tdebug);
 		break;
 		case 'h':
 			print_help();
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
