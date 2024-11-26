Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEF3D3B7CC
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 10:05:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA4293DB069
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 11:05:12 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CFCB3C0574
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 11:04:56 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A3BB62EB2E
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 11:04:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732615494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=puYOAdnKTBtIu6o0J8wBuvNKde6kk2xk+w9i+zKxz+Y=;
 b=GbxikAsghCFd7fHwrOkpdCggTUuy1u33KWUo7dVZ0n5wVR6Bej5S4sCKVt5st4pHh5zgwL
 4YB8jGUIQCua8vpjaOx/blX5Mz3YH9V+yiYnUTFQrubTcVlIJJfH9u/sEKSuTa2nMyxCCo
 b0x2KGL1LiC6l+dM5EaZrIa/pIjhrDU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-mA4JAsAFMQWap-V95UtzXg-1; Tue,
 26 Nov 2024 05:04:50 -0500
X-MC-Unique: mA4JAsAFMQWap-V95UtzXg-1
X-Mimecast-MFC-AGG-ID: mA4JAsAFMQWap-V95UtzXg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F41751955EE8; Tue, 26 Nov 2024 10:04:49 +0000 (UTC)
Received: from thoundrobot.redhat.com (unknown [10.72.112.151])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFC791956054; Tue, 26 Nov 2024 10:04:47 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 26 Nov 2024 18:04:45 +0800
Message-ID: <20241126100445.17133-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gCUwY0h6uZajP4KWoS0oX5-Xpefp_Hew-9Kyw76YkXk_1732615490
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH] starvation: set a baseline for maximum runtime
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
Cc: Philip Auld <pauld@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The commit ec14f4572 ("sched: starvation: Autocallibrate the timeout")
introduced a runtime calibration mechanism to dynamically adjust test
timeouts based on CPU speed.

While this works well for slower systems like microcontrollers or ARM
boards, it struggles to determine appropriate runtimes for modern CPUs,
especially when debugging kernels with significant overhead.

This patch introduces a baseline runtime (max_runtime = 600 seconds) to
ensure the test does not timeout prematurely, even on modern CPUs or
debug kernels. The calibrated runtime is compared against this baseline,
and the greater value is used as the test timeout.

This change reduces the likelihood of timeouts while maintaining flexibility
for slower systems.

Error log on debug-kernel:
  ...
  starvation.c:98: TINFO: Setting affinity to CPU 0
  starvation.c:52: TINFO: CPU did 120000000 loops in 52717us
  tst_test.c:1727: TINFO: Updating max runtime to 0h 00m 52s
  tst_test.c:1719: TINFO: Timeout per run is 0h 06m 16s
  starvation.c:148: TFAIL: Scheduller starvation reproduced.
  ...

From Philip Auld:

  "The test sends a large number of signals as fast as possible. On the
  non-debug kernel both signal generation and signal deliver take 1usec
  in my traces (maybe actually less in real time but the timestamp has
  usec granularity).
  But on the debug kernel these signal events take ~21usecs. A significant
  increase and given the large number of them this leads the starvation
  test to falsely report starvation when in fact it is just taking
  a lot longer.

  In both debug and non-debug the kernel is doing the same thing. Both
  tasks are running as expected. It's just the timing is not working for
  the debug case.

  Probably should waive this as expected failure on the debug variants."

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Philip Auld <pauld@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/sched/cfs-scheduler/starvation.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index e707e0865..d57052d1d 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -108,6 +108,7 @@ static void setup(void)
 	else
 		timeout = callibrate() / 1000;
 
+	timeout = MAX(timeout, test.max_runtime);
 	tst_set_max_runtime(timeout);
 }
 
@@ -161,5 +162,6 @@ static struct tst_test test = {
 		{"t:", &str_timeout, "Max timeout (default 240s)"},
 		{}
 	},
+	.max_runtime = 600,
 	.needs_checkpoints = 1,
 };
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
