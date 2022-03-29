Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372C7C433F5
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 05:04:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB3B43C9C23
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 07:04:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 000743C279F
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 07:03:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 968C2200AC2
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 07:03:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648530237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sptwltsONWruAPWq9LDOKHjz1QQAyNWKh6M+V+9PjaU=;
 b=bHa+/CDupGbPBo1JwsjW6smTqhgyAnSmKSE4rskVSXfvB60AvjgVSEBS5mLgBzsIm4e/w5
 i5TKAmYJWEa4nJTuZKr+lCzjikBI/wEfAwENOlXZZv3ukOn7Motq7HwM6p6srhHwWdBVN8
 2wg89Jfto2svK5JuMP8yqJQN/j/oajQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-dE_EDbztPyGqKwokHZQSyw-1; Tue, 29 Mar 2022 01:03:55 -0400
X-MC-Unique: dE_EDbztPyGqKwokHZQSyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3633E3C14CDA;
 Tue, 29 Mar 2022 05:03:55 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40388141DC28;
 Tue, 29 Mar 2022 05:03:52 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 29 Mar 2022 13:03:51 +0800
Message-Id: <20220329050351.688432-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] clock_gettime04: set threshold based on the clock
 resolution
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Eirik Fuller <efuller@redhat.com>,
 Waiman Long <llong@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is to get rid of the intermittent failures in clock_gettime04,
which are likely caused by different clock tick rates on platforms.
Here give two thresholds (in milliseconds) for comparison, one for
COARSE clock and one for the rest.

Error log:
  clock_gettime04.c:163: TFAIL: CLOCK_REALTIME_COARSE(syscall with old kernel spec):
        Difference between successive readings greater than 5 ms (1): 10
  clock_gettime04.c:163: TFAIL: CLOCK_MONOTONIC_COARSE(vDSO with old kernel spec):
	Difference between successive readings greater than 5 ms (2): 10

From Waiman Long:
  That failure happens for CLOCK_REALTIME_COARSE which is a faster but less
  precise version of CLOCK_REALTIME. The time resolution is actually a clock
  tick. Since arm64 has a HZ rate of 100. That means each tick is 10ms. So a
  CLOCK_REALTIME_COARSE threshold of 5ms is probably not enough. I would say
  in the case of CLOCK_REALTIME_COARSE, we have to increase the threshold based
  on the clock tick rate of the system. This is more a test failure than is
  an inherent problem in the kernel.

Fixes #898

Reported-by: Eirik Fuller <efuller@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---

Notes:
    v1 --> v2
        * make use of clock_getres to get clock resolution
        * involve separate coarse_delta for COARSE clock
        * count delta as 'clock resolution + elapse (5ms)'

 .../syscalls/clock_gettime/clock_gettime04.c   | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
index a8d2c5b38..c279da79e 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
@@ -35,7 +35,7 @@ clockid_t clks[] = {
 };
 
 static gettime_t ptr_vdso_gettime, ptr_vdso_gettime64;
-static long long delta = 5;
+static long long delta, precise_delta, coarse_delta;
 
 static inline int do_vdso_gettime(gettime_t vdso, clockid_t clk_id, void *ts)
 {
@@ -92,9 +92,18 @@ static struct time64_variants variants[] = {
 
 static void setup(void)
 {
+	struct timespec res;
+
+	clock_getres(CLOCK_REALTIME, &res);
+	precise_delta = 5 + res.tv_nsec / 1000000;
+
+	clock_getres(CLOCK_REALTIME_COARSE, &res);
+	coarse_delta = 5 + res.tv_nsec / 1000000;
+
 	if (tst_is_virt(VIRT_ANY)) {
 		tst_res(TINFO, "Running in a virtual machine, multiply the delta by 10.");
-		delta *= 10;
+		precise_delta *= 10;
+		coarse_delta *= 10;
 	}
 
 	find_clock_gettime_vdso(&ptr_vdso_gettime, &ptr_vdso_gettime64);
@@ -108,6 +117,11 @@ static void run(unsigned int i)
 	int count = 10000, ret;
 	unsigned int j;
 
+	if (clks[i] == CLOCK_REALTIME_COARSE || clks[i] == CLOCK_MONOTONIC_COARSE)
+		delta = coarse_delta;
+	else
+		delta = precise_delta;
+
 	do {
 		for (j = 0; j < ARRAY_SIZE(variants); j++) {
 			/* Refresh time in start */
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
