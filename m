Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6E2C44529
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 08:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784622526; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=I27jiW61yVNjtC43onOeJgvtYXiiJZBQVAy5ivrioOQ=;
 b=P84yAx0T+fBp6ttam25coRWmoCISD2NfHxCx9/TBurtCAuRLGKIplfdsPS6M+i9KsbVCG
 TJqnTFhy2ervgFmel0piJcSNqRHBAxdA0+jqgBmmlVbjuTbU0vLrq4UkWYiaYWOrrgyGkJL
 DZpF4pa55VBhgLhyJbZGZOLswVpduzU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 944713E6249
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 10:28:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56B093E6200
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:28:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AFC7B1400BCC
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:28:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784622486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSJ1LKdl7jWstOeV1YbNePEmqGLbFEG7tYYFIdWlEFY=;
 b=OLZjdUnBSgPmLDh1KfH0k8AZK8JlAD7SqArcL85MT3J9Ud24OkG/sk/XXF2ZsZkFP24wTo
 x5dMZasLVh6rc/Nmf9yVTW66merJb3AaNy7HIWB/hO3BdK5+s1JE3ziI98D6zrCpyHlv0a
 gMU6wL5sTzZvzJUzbR4Y+6Qj0ncaKJM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-dQl2oboiNUqhmOC5XFEakg-1; Tue,
 21 Jul 2026 04:28:05 -0400
X-MC-Unique: dQl2oboiNUqhmOC5XFEakg-1
X-Mimecast-MFC-AGG-ID: dQl2oboiNUqhmOC5XFEakg_1784622484
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2501D1955F71
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 08:28:04 +0000 (UTC)
Received: from tdzik-thinkpadt14gen6.tpbc.csb (unknown [10.43.3.29])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 744A9195604D
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 08:28:03 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 21 Jul 2026 10:27:50 +0200
Message-ID: <c2a4d3fb4e65c526dc207aadf2e3f70fec46cc0d.1784183478.git.tdzik@redhat.com>
In-Reply-To: <cover.1784183478.git.tdzik@redhat.com>
References: <cover.1784183478.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NsEs2s5kWSbNDrPgk1xWnZfsZ9vUYFwcDtWtHlhJeDw_1784622484
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/3] LTP/Lite test float_trigo core dumps due to
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
Message-ID: <20260721082750.pULY1Q3XCukI7UKuonH1gL2SzyM2WO9EeiArwaJIDSM@z>

Function read_file() does not initialize *data on failure paths
(for example if malloc() fails) and caller ends up calling SAFE_FREE()
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
 testcases/misc/math/float/thread_code.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/misc/math/float/thread_code.c b/testcases/misc/math/float/thread_code.c
index ca18cef1e..6f3a463dd 100644
--- a/testcases/misc/math/float/thread_code.c
+++ b/testcases/misc/math/float/thread_code.c
@@ -278,7 +278,12 @@ void *thread_code(void *arg)
 {
 	TH_DATA *th_data = (TH_DATA *) arg;
 	size_t fsize, fsize2, fsize3;
-	double *din, *dex, *dex2 = NULL;
+	/*
+	 * If read_file() fails for whatever reason, these pointers might
+	 * stay uninitialized. Initialize them to NULL, because SAFE_FREE()
+	 * can handle it.
+	 */
+	double *din = NULL, *dex = NULL, *dex2 = NULL;
 	int imax, index;
 
 	fsize = read_file(th_data->th_func.din_fname, (void **)&din);
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
