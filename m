Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AB3CCF2D6
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 12:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792413288; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=WudffehV4r6VVIR2xoYnf7cVtPQ5j7ISvy8zyOjLfTM=;
 b=C21QkekEiI3ZafGJ5quh0IS9hQCRNCHUuicvjlBAIM6Q4E+fhTWJGDZ3YCsKzVZEXN7Cd
 nuIYSWl+KQOmPkXUxFNM9yaXwcX3PIM2lXzNJke+TiLr7NhNnmMwp2zcPOUprmw78Oezyth
 UsKJE0OFvZSMmmUwYDZX109grww1qK8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5C7D3EA64E
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 14:34:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E39F23E9E12
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 14:34:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 20CE410007F7
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 14:34:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792413267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4EBv9P9nz6VtVQfMPCpQXZTgbPagCeORmVUL2qWaxiI=;
 b=ViMV4+QxcemIztvqc0g4hWtI7sCbhqTuJT/rQ9gfHLzo6butz1sjoGL7CypT5rmhCi5cX1
 YyzoEOrZBjH5l7OzWTmS2q3G0gRJWOuj6CyMsiFXVvtQ4NwPtPS3OFJuRHfUr2GlQ0tBxJ
 B/N9vGEOiljZOVbGJ8B6NSrYKnhpO/0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-MMl8ENKtP6GbpH-UMzvFqQ-1; Mon,
 19 Oct 2026 12:34:26 +0000
X-MC-Unique: MMl8ENKtP6GbpH-UMzvFqQ-1
X-Mimecast-MFC-AGG-ID: MMl8ENKtP6GbpH-UMzvFqQ_1792413265
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02BC91955E97
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:34:25 +0000 (UTC)
Received: from jstancek-thinkpadt14gen5.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C2871800446
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:34:23 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 19 Oct 2026 14:34:21 +0200
Message-ID: <07c4ad10a95faf9318de23aa0fceafac1bc44bd6.1792413241.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ihlldm9Z2WkDXoUYynEGokfBL64s5UjacnsG2-DdFw0_1792413265
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] float_exp_log: Fix ldexp exponents written by genldexp
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

genldexp stores the ldexp() exponents in a double array but writes
only sizeof(int) bytes of each element to ildexp_inp.ref. For a double
holding a small integer the low 32 bits of the IEEE-754 encoding are
zero, so on little-endian every exponent read back by the test is 0 and
ldexp(x, 0) == x is the only thing float_exp_log ever checks. On
big-endian the exponents are garbage from the high word instead.

Declare the exponent array as int so the intended 20000..1 exponents
are written and the ldexp threads exercise real scaling. Large exponents
overflow to inf for both the generated and computed value, which
check_error() already treats as equal.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/misc/math/float/exp_log/genldexp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/misc/math/float/exp_log/genldexp.c b/testcases/misc/math/float/exp_log/genldexp.c
index fc81c9efa648..98a28edec3e7 100644
--- a/testcases/misc/math/float/exp_log/genldexp.c
+++ b/testcases/misc/math/float/exp_log/genldexp.c
@@ -102,8 +102,8 @@ static int create_Result_file(void)
 
 static int create_Data_file(void)
 {
-	int i, nbVal;
-	double tabDD[20000], tabDI[20000], Inc;
+	int i, nbVal, tabDI[20000];
+	double tabDD[20000], Inc;
 	char *F_named, *F_namei;
 	int fp, fpi;
 
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
