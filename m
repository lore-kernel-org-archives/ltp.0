Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111B7C7115B
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750404634; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=yQYr1bvbpJdkV6Nx/nq4WdB4N8tXuHoVhbktZfb2hqk=;
 b=kB4LymzDrHn0WyfAonZB+PX18/15Jrc19AB569ldNNYwop9uL/UX2kMkF3g+mXmYptUas
 HPTXtMj+VC7w1Hny3XqUEYbKliFWfRS9lntLsjl+hZoTmu+LryH6Wzi1AEaaRX2WaQG/Ns4
 srGLHTYDXapTRGH+wuXgH/Onbv6BFnE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C0D03CC835
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 09:30:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F20383C535B
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 09:30:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 107E2600ADD
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 09:30:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750404608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3nezDlWk7q06Slm82A9cD9UYzUdIK1gKyal8OHN/sbA=;
 b=gq96bFlinWxxQ6QqJvRRSEJQz7JnFIJiX+SgmA+sJgOkLBxvrSLYGmb5K0pF4FoutelkWr
 Uk/L1sAXyzFCZIiy9oDKjVjfzAl3QhizjWmPspsdCqyF54murj09/iM+T4PWs6+O8sGW5l
 IBVfWfBXCpA+tb2VIlDRLTuAMh8vsOk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-AYoipFXnN2-pgiBZNn46RQ-1; Fri,
 20 Jun 2025 03:30:05 -0400
X-MC-Unique: AYoipFXnN2-pgiBZNn46RQ-1
X-Mimecast-MFC-AGG-ID: AYoipFXnN2-pgiBZNn46RQ_1750404605
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5A8219560AA
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 07:30:04 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.218])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C885195609D; Fri, 20 Jun 2025 07:30:02 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 20 Jun 2025 15:30:00 +0800
Message-ID: <20250620073000.514444-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0-oKL1hVIbB4pTdnFgaahot36RMiG8_KrlvVkxIhI3g_1750404605
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: ensure multiply_runtime() returns at least 1
 second
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

This patch introduces support for fractional `LTP_RUNTIME_MUL` values
in the range (0, 1], allowing fine-grained control over test runtimes.
For example, setting `LTP_RUNTIME_MUL=0.1` can reduce a 300s test
to just 30s, which helps fit CI execution within 40 minutes.

To avoid skipping tests with low `.runtime` (e.g. nice05 with `.runtime=3`),
this patch also modifies `multiply_runtime()` to always return at least 1.
This ensures that even after floating-point multiplication, a test is never
silently skipped due to runtime being rounded to zero.

Follow-up: a6a369c5ee ("lib: redefine the overall timeout logic of test")
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Ian Wienand <iwienand@redhat.com>
---
 lib/tst_test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 495e022f7..467299e37 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -626,11 +626,14 @@ static void parse_mul(float *mul, const char *env_name, float min, float max)
 
 static int multiply_runtime(unsigned int runtime)
 {
+	int adj;
 	static float runtime_mul = -1;
 
 	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
 
-	return runtime * runtime_mul;
+	adj = runtime * runtime_mul;
+
+	return adj > 0 ? adj : 1;
 }
 
 static struct option {
@@ -662,7 +665,7 @@ static void print_help(void)
 	fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
 	fprintf(stderr, "LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist.\n");
 	fprintf(stderr, "LTP_TIMEOUT_MUL          Timeout multiplier (must be a number >=1)\n");
-	fprintf(stderr, "LTP_RUNTIME_MUL          Runtime multiplier (must be a number >=1)\n");
+	fprintf(stderr, "LTP_RUNTIME_MUL          Runtime multiplier (must be a number > 0)\n");
 	fprintf(stderr, "LTP_VIRT_OVERRIDE        Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
 	fprintf(stderr, "TMPDIR                   Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
 	fprintf(stderr, "\n");
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
