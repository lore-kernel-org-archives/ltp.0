Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F6EC433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 04:01:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C32D83C54EB
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 05:01:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACDF83C1B77
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 05:01:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8390E2003B0
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 05:01:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648180865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LYdEaPNu0xeuCAdMUC6gfn5OxJv5DcJkQLGbQWZip80=;
 b=OWXIaz5I9PwB4u8p7m4bt//MMIjcCSjgq2uAVga9xgnTkNMKWhdtIqwbHtd6SC74HCDKMN
 uflk0U350qTt5cu7JlXMQT2d22627g4YLC3EZON1sagQgX9MiqlYYDkpCCPhk57GhiFj22
 WVhxX2bJCGO6rKrhMPPXSBcZ4vYlb/M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-TW47Y8fAN6S-RhSH8cbLqA-1; Fri, 25 Mar 2022 00:01:03 -0400
X-MC-Unique: TW47Y8fAN6S-RhSH8cbLqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0CE63804518;
 Fri, 25 Mar 2022 04:01:02 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEA1840CF8EC;
 Fri, 25 Mar 2022 04:00:58 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 25 Mar 2022 12:00:57 +0800
Message-Id: <20220325040057.544211-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] clock_gettime04: set threshold based on the clock
 tick rate
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
Here set the threshold no less than each clock tick in millisecond:

	delta = 1000(ms)/ticks_number_per_sec + 5;

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
 testcases/kernel/syscalls/clock_gettime/clock_gettime04.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
index a8d2c5b38..cccbc9383 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
@@ -35,7 +35,7 @@ clockid_t clks[] = {
 };
 
 static gettime_t ptr_vdso_gettime, ptr_vdso_gettime64;
-static long long delta = 5;
+static long long delta;
 
 static inline int do_vdso_gettime(gettime_t vdso, clockid_t clk_id, void *ts)
 {
@@ -92,6 +92,7 @@ static struct time64_variants variants[] = {
 
 static void setup(void)
 {
+	delta = 1000/sysconf(_SC_CLK_TCK) + 5;
 	if (tst_is_virt(VIRT_ANY)) {
 		tst_res(TINFO, "Running in a virtual machine, multiply the delta by 10.");
 		delta *= 10;
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
