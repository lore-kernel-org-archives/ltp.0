Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB4DC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783612098; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=8glW/jaGUH8j98FhjxUVc/8WL5a0rLZG5AXX+nASBb4=;
 b=RUB22DN27mUU8DSunJuws91bYO1ySlRpowCkWIFRqVL4hJjsiA9ep6j7MYf1cPLmkl45V
 wEt5PEUeFrwQI5uS63UfGcCQ4kdKmwDGK4Eq7IyAbcKNuHqyTbRk19fw30niZotjiUmFerd
 DlP5ynR1ESqGj0hLOeaQnnybh8jg390=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59F9C3E65AB
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 17:48:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A5473E28F1
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 17:40:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C0E88200043
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 17:40:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783611622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Gv6ET0AQ4XCcPBX3muvm/FzM2jBwzPoQ9fxGWSaQJg=;
 b=PS9lzgJyMKgUlUhVTXdYbWUqlFz7cahHNJA61KDgx2wMSSyfnwQM7tFM6MsYKG/2MMun7o
 4eIr4LJXvfJLq8iKtBGCS0D6A4UrypRjcv3ba/I/D+QZy0OpUkS0CBJtql2UFwv39PXYuu
 b1EEgxWCewQVv5FG9f9hGt7W8YACzzU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-NTvGCLJvPgmwKBVATFmG6g-1; Thu,
 09 Jul 2026 11:40:20 -0400
X-MC-Unique: NTvGCLJvPgmwKBVATFmG6g-1
X-Mimecast-MFC-AGG-ID: NTvGCLJvPgmwKBVATFmG6g_1783611619
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25A0E1956065
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:40:19 +0000 (UTC)
Received: from tdzik-thinkpadt14gen6.tpbc.com (unknown [10.44.49.228])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 785083000C01
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:40:18 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 17:40:04 +0200
Message-ID: <79d9ea8ebe3e77733d65fba85ef1940e6f263925.1783610933.git.tdzik@redhat.com>
In-Reply-To: <cover.1783610933.git.tdzik@redhat.com>
References: <cover.1783610933.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l4EiFHYIY0jtkHiE1D8ZJSgeyNFVT0kj5TfzY6s_XKw_1783611619
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 09 Jul 2026 17:47:41 +0200
Subject: [LTP] [PATCH 1/3] LTP/Lite test float_trigo core dumps due to
 free(): invalid pointer
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
From: Tomas Dzik via ltp <ltp@lists.linux.it>
Reply-To: Tomas Dzik <tdzik@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

If malloc() inside function read_file() fails and return value is
not checked, the current code runs free() on uninitialized pointer.

    Here is the log from failed run:
    ~==== float_trigo ====
    command: float_trigo -v
    float_trigo    0  TINFO  :  Using /tmp/LTP_floJSug25 as tmpdir (xfs
    filesystem)
    float_trigo    1  TPASS  :  Test passed
    float_trigo    0  TINFO  :  float_trigo: will run for 500 loops;
    using . as a data directory
    float_trigo    0  TINFO  :  float_trigo: will run 7 functions, 20
    threads per function
    float_trigo    0  TINFO  :  signal handler 140451533870784 started
    float_trigo    0  TINFO  :  Signal handler starts waiting...
    free(): invalid pointer

    Duration: 0.926

This fix initializes pointers where we actually core dumped (*din, *dex).

Signed-off-by: Tomas Dzik <tdzik@redhat.com>
---
 testcases/misc/math/float/thread_code.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/misc/math/float/thread_code.c b/testcases/misc/math/float/thread_code.c
index ca18cef1e..34a9578d4 100644
--- a/testcases/misc/math/float/thread_code.c
+++ b/testcases/misc/math/float/thread_code.c
@@ -278,7 +278,13 @@ void *thread_code(void *arg)
 {
 	TH_DATA *th_data = (TH_DATA *) arg;
 	size_t fsize, fsize2, fsize3;
-	double *din, *dex, *dex2 = NULL;
+	/*
+	 * If read_file() fails for whatever reason, these pointers might
+	 * stay uninitialized. Initialize them to NULL, because SAFE_FREE()
+	 * can handle it.
+	 */
+
+	double *din = NULL, *dex = NULL, *dex2 = NULL;
 	int imax, index;
 
 	fsize = read_file(th_data->th_func.din_fname, (void **)&din);
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
