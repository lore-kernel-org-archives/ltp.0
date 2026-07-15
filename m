Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EE3C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784108761; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=4bSSKT/vn10PpYmI2PsRrIaSq28ZqyP086pzpLK8P7U=;
 b=lq+1E0Z6rtVQMBlLWKvW7113s+EupjBM5B3HKgBJe0ZjUZmUOYDykzzgQw+cS+LZ37ao7
 9aK9mOpbebe/vZtjRLJdicZPSW14NdI/yd38hKfpcJ636TcycABr2kd8OpwvdS5g0J0+9Dr
 E1t2DmuPMm7irkP7R5wkOTtNkuX/xzg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 493EB3E5691
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:46:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 878173E5686
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:45:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F25A5600424
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:45:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784108717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1dbwqDozfa8PftpRdBwB1EQ1LAz9k/R4LaWxJ4A2RU4=;
 b=cDnbSaGfzTlmHvVnOKcHDp1XeFlsIjoYpBnCvXWd4eCi++64m6zcSsI3TBAyw4FYf9IWLE
 6I5NY2ujKFTKiQ8LPrNbe/SB0ICJ4flyT2jI1Ri4wsdP2ho/jZOD++VN3s6M0gg1ReXgaF
 1KSs6B4XwvqqeMGGaQrdTTsPKpzwpR8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-QP7e5ERsP5SIEz089h5DYg-1; Wed,
 15 Jul 2026 05:45:16 -0400
X-MC-Unique: QP7e5ERsP5SIEz089h5DYg-1
X-Mimecast-MFC-AGG-ID: QP7e5ERsP5SIEz089h5DYg_1784108715
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89570180059A
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:45:15 +0000 (UTC)
Received: from tdzik-thinkpadt14gen6.tpbc.csb (unknown [10.43.3.29])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED9E9180036E
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:45:14 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 15 Jul 2026 11:45:02 +0200
Message-ID: <158dabe0ae0768b71da55574ab6fdcbb06dff898.1784103831.git.tdzik@redhat.com>
In-Reply-To: <cover.1784103831.git.tdzik@redhat.com>
References: <cover.1784103831.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5uoAWFKlBgvnpR7JbmRlT-0X6VqWl0QykcyJNc-Eyt8_1784108715
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
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

Function read_file() does not initialize *data on failure paths
(for example if malloc() fails) and caller ens up calling SAFE_FREE()
on an uninitialized pointer.

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
