Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F58C71136
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750084992; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Kv/C26miKTSZj8tUha/XvHBtYWcFjUvFkCyzgDNQT6Q=;
 b=YXBu8A507fIKVwQdlzIgsb93BtXk2GMIY7mUrz1mwpiwMswMoVKoG06ix1aeQz+BwhwHr
 xuSgBGGkM8rIFP0/Adugay88YOcGC7yA/wYGPZEAfTNUsYcqTVwFDeVskETIgxU43qGNp2C
 iS8QAdZ/9QJpvmiWU1sTzCqCexlQAcQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA76B3CC0DC
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 16:43:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1FC43CC01F
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:42:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9A17A1A000BB
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:42:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750084969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhlHbuuA8EScKJdWaakogvk8vhnE3K3ggQTdLzAq7H8=;
 b=Cf6IYIhOusyvAIQDRHLZ0Doqp2L1A9VWuORvRe+UcuFuv9gVJcNnXnFxtEAPTTYq0HsaxD
 l+zKBcmlTAdywsiAg0L8Gu9K+JxoEAfg2Ku5LxvJamozi3zt3HoZEIdxrpQSlyJV/3VziM
 WQ3h74cQ6+kPllMdA+wAzQ0+H1bsS0s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-5w4jMbocNFSTVIFsqfm0rg-1; Mon,
 16 Jun 2025 10:42:47 -0400
X-MC-Unique: 5w4jMbocNFSTVIFsqfm0rg-1
X-Mimecast-MFC-AGG-ID: 5w4jMbocNFSTVIFsqfm0rg_1750084961
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E4F21955E79; Mon, 16 Jun 2025 14:42:41 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0CC518003FC; Mon, 16 Jun 2025 14:42:39 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 16 Jun 2025 22:42:34 +0800
Message-ID: <20250616144234.336032-1-liwang@redhat.com>
In-Reply-To: <20250612034229.310523-1-liwang@redhat.com>
References: <20250612034229.310523-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nZcpzGfEZMCdRORs1peqr0qF2bWRGF775xFsdUPKQt8_1750084961
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib: suppress early TDEBUG output before context
 initialization
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

After commit bf9589d5bd ("lib: move test infrastructure states into
a shared context structure"), each test began printing unexpected
TDEBUG messages like:

  tst_test.c:142: TDEBUG: mmap((nil), 4096, PROT_READ | PROT_WRITE(3), 1, 3, 0)
  tst_test.c:199: TDEBUG: mmap((nil), 4096, PROT_READ | PROT_WRITE(3), 1, 3, 0)

This happens because the logic in tst_res_():

  if (ttype == TDEBUG && context && !context->tdebug)

allows TDEBUG messages to be printed even the context is not yet initialized.
During early test setup (such as in SAFE_MMAP), the shared context may
not be initialized yet, causing debug logs to be emitted unintentionally.

This patch refines the suppression logic in tst_res_() by explicitly checking:
  - Whether `context` has been initialized
  - Whether current is the library test process (`lib_pid`)
  - Whether `tdebug` is enabled

This improves test log clarity and avoids misleading noise during test setup.

Follow-up: commit bf9589d5bd ("lib: move test infrastructure states into a shared context structure")
Signed-off-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 6fcd40030..495e022f7 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -476,8 +476,22 @@ void tst_res_(const char *file, const int lineno, int ttype,
 {
 	va_list va;
 
-	if (ttype == TDEBUG && context && !context->tdebug)
-		return;
+	/*
+	 * Suppress TDEBUG output in these cases:
+	 * 1. No context available (e.g., called before IPC initialization)
+	 * 2. Called from the library process, unless explicitly enabled
+	 * 3. Debug output is not enabled (context->tdebug == 0)
+	 */
+	if (ttype == TDEBUG) {
+		if (!context)
+			return;
+
+		if (context->lib_pid == getpid())
+			return;
+
+		if (!context->tdebug)
+			return;
+	}
 
 	va_start(va, fmt);
 	tst_vres_(file, lineno, ttype, fmt, va);
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
