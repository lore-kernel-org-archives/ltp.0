Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CD8C27C4F
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 03:15:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEB243D11B0
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 05:15:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FF2D3D0B04
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 05:14:55 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3661B6007A7
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 05:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719458093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J2/KXYKyMcyAkBLzlkGirz93IpcZBhzU2kjdFaYDqlA=;
 b=XfL29Qc0rGhl5GLl8fDWkKNTgdk8Mitt1spP1cZWZQwi3iiCMCzRvAsNBFKHvLnDIeqDKl
 Ncg90mV99OryUYNqm/47cK/+kKiahKFxUoki1zHMpGA4dIj99Yor3MESd+XLp3OJzpFkMk
 W0KXrRK4A4HljcZT9yCeNUcbb43QOtQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-HIK5DgYVO_ai0xpZ_aTQrQ-1; Wed,
 26 Jun 2024 23:14:49 -0400
X-MC-Unique: HIK5DgYVO_ai0xpZ_aTQrQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 814AC195608C; Thu, 27 Jun 2024 03:14:48 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74A8B1956050; Thu, 27 Jun 2024 03:14:45 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it,
	chrubis@suse.cz
Date: Thu, 27 Jun 2024 11:14:40 +0800
Message-ID: <20240627031440.799114-1-liwang@redhat.com>
In-Reply-To: <CAEemH2fsBssjDyyozHnFt4T5y7LCWFEDqfN3nE7t3kyd19FjLg@mail.gmail.com>
References: <CAEemH2fsBssjDyyozHnFt4T5y7LCWFEDqfN3nE7t3kyd19FjLg@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] msgstress01: remove TWARN from runtime remaining
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To mask the issue where a warning is being treated as a failure in CI
logs, we modify the code to change the message type from TWARN to TCONF.

Additionally, we refine the condition under which the test reports as
PASS to ensure that it also accounts for the `stop` flag. This prevents
the test from incorrectly reporting success when it had to stop due to
runtime constraints.

This warning easily happens especaill on debug/slower kernel:

    msgstress01.c:217: TWARN: Out of runtime during forking...

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/ipc/msgstress/msgstress01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 8b1e9a8c0..9231a0b5f 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -214,7 +214,7 @@ static void run(void)
 			break;
 
 		if (!tst_remaining_runtime()) {
-			tst_res(TWARN, "Out of runtime during forking...");
+			tst_res(TCONF, "Out of runtime during forking...");
 			*stop = 1;
 			break;
 		}
@@ -242,7 +242,7 @@ static void run(void)
 	tst_reap_children();
 	remove_queues();
 
-	if (!(*fail))
+	if (!(*fail) && !(*stop))
 		tst_res(TPASS, "Test passed. All messages have been received");
 }
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
