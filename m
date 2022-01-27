Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B65C433F5
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 10:09:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F05A3C9742
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 11:09:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40E573C4EC5
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 11:09:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AFE8010004BA
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 11:09:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643278147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=un+GoNilKIpqgSKjIvdZuG+Xof8noeAt3A3TMVh7nSY=;
 b=ABa844vJjBprJX9Iup24+Exg+o1hUPdyFvVcnQmFdgXT4TkeT4IW7WAbt7jLelz8ea9OXC
 VtJz4VRN9uaLsvpXJXDvSR4uvDC7Z7PyNx7UZNo9qcnCu8+gJK6/julDS89WXah7uCcETZ
 2hO6FQPN15YhBmAqciwiG0yUOHVRreM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-48S26v33NvKXYayF5LtTXQ-1; Thu, 27 Jan 2022 05:09:04 -0500
X-MC-Unique: 48S26v33NvKXYayF5LtTXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 777DB1083F61
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:09:03 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.192.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F222F7B6E4
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:09:02 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 27 Jan 2022 11:09:00 +0100
Message-Id: <e5f8d6b684e4ee5733768442a7378c94fc963632.1643278075.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] clock_gettime03: multiply the timediff if test in VM
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

Similar to 59e73f295dc7 ("clock_gettime04: multiply the
timediff if test in VM"), extend tolerance for this test too.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/clock_gettime/clock_gettime03.c    | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
index 83e97d90726d..f185977d36df 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
@@ -37,6 +37,7 @@ static struct tcase {
 
 static struct tst_ts now, then, parent_then;
 static int parent_ns;
+static long long delta = 10;
 
 static struct time64_variants variants[] = {
 	{ .clock_gettime = libc_clock_gettime, .ts_type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
@@ -70,7 +71,7 @@ static void child(struct time64_variants *tv, struct tcase *tc)
 
 	diff = tst_ts_diff_ms(then, now);
 
-	if (diff - tc->off * 1000 > 10) {
+	if (diff - tc->off * 1000 > delta) {
 		tst_res(TFAIL, "Wrong offset (%s) read %llims",
 		        tst_clock_name(tc->clk_id), diff);
 	} else {
@@ -80,7 +81,7 @@ static void child(struct time64_variants *tv, struct tcase *tc)
 
 	diff = tst_ts_diff_ms(parent_then, now);
 
-	if (diff > 10) {
+	if (diff > delta) {
 		tst_res(TFAIL, "Wrong offset (%s) read %llims",
 		        tst_clock_name(tc->clk_id), diff);
 	} else {
@@ -113,6 +114,11 @@ static void setup(void)
 {
 	struct time64_variants *tv = &variants[tst_variant];
 
+	if (tst_is_virt(VIRT_ANY)) {
+		tst_res(TINFO, "Running in a VM, multiply the delta by 10.");
+		delta *= 10;
+	}
+
 	now.type = then.type = parent_then.type = tv->ts_type;
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 	parent_ns = SAFE_OPEN("/proc/self/ns/time_for_children", O_RDONLY);
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
