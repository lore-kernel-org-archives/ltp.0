Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C58FC3DA7F
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 06:36:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D49A3D1E83
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 08:36:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F232E3D1BC0
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 08:36:29 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 06EEB600A89
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 08:36:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722839787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Klm9AwF1hGcnj3qrUNXp9IEoMuEEBFpLHXurlslo6HM=;
 b=fW0Rh3cPWjKJ5QjL54osoWomk83eX/DdFFC+ee79sbZXdp9CoM8SJxE9aiRj/exioWnBTO
 ufPX4pG0jeuQa3xo8SbLuqyGMDT9NS3ZyB4b5tqxoQfZdEbMxaIu6dOrFVyZfu6O6qHf9Y
 CrhXrURfi8XGoQ7GHZ0FRmIvb3UZ5u0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-Y6-FMfYxMPq2Uypf_UNhqA-1; Mon,
 05 Aug 2024 02:36:25 -0400
X-MC-Unique: Y6-FMfYxMPq2Uypf_UNhqA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A53AC19560B1
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 06:36:24 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3F2D1955D44; Mon,  5 Aug 2024 06:36:22 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  5 Aug 2024 14:36:16 +0800
Message-ID: <20240805063616.12572-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getrusage03: Forcing context switches to update
 resource usage
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
Cc: Scott Weaver <scweaver@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Our CI sporadically complains that this test grandchild's MAXRSS did not reach
the expected 300MB size.

    12 getrusage03.c:86: TFAIL: child.children = 258048, expected 307200

As the ru_maxrss value is generally updated at certain intervals or under
specific conditions, such as page faults or context switches. There may be
delay between the completion of memset() and the update of ru_maxrss.

To address this issue, we create a function to force context switches by
calling sched_yield() multiple times. This approach helps to ensure that
the system has the opportunity to update the ru_maxrss value more promptly.

Reproted-by: Scott Weaver <scweaver@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/getrusage/getrusage03.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.h b/testcases/kernel/syscalls/getrusage/getrusage03.h
index 8bee0b9e5..58a98b430 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.h
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.h
@@ -6,10 +6,19 @@
 #ifndef LTP_GETRUSAGE03_H
 #define LTP_GETRUSAGE03_H
 
+#include <sched.h>
 #include "tst_test.h"
 
 #define DELTA_MAX 20480
 
+static void force_context_switches(int iterations)
+{
+	tst_res(TINFO, "Forcing context switch %d times", iterations);
+
+	for (int i = 0; i < iterations; i++)
+		sched_yield();
+}
+
 static void consume_mb(int consume_nr)
 {
 	void *ptr;
@@ -22,6 +31,8 @@ static void consume_mb(int consume_nr)
 	ptr = SAFE_MALLOC(size);
 	memset(ptr, 0, size);
 
+	force_context_switches(10);
+
 	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmSwap: %lu", &vmswap_size);
 	if (vmswap_size > 0)
 		tst_brk(TBROK, "VmSwap is not zero");
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
