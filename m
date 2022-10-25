Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF3AC04A95
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 12:19:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A87193CA50F
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 14:19:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 530503CA3F9
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 14:19:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A79481A0065A
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 14:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666700354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyLutXJxXvbqpK+NTHMTUJB6oLz09zt4hu6GbarYpU8=;
 b=efXyS5BsoOqycLeI+DRGH7hIr9MVtZwsePFjmiNTQ9QHCD7PbECPz/Tbm+NBiJLOf5TZ/t
 6IUqCjSkomWW6WVFdz7b7oEHII9ba6SVxIzW6juztxs2/VmwaM7TiPtlTaE1+z+QUPgw2V
 obDsWe4kwktp24A1b+JQOBl+/TvzSYo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-h1cCCFLRNVKPykPeVamqnw-1; Tue, 25 Oct 2022 08:19:09 -0400
X-MC-Unique: h1cCCFLRNVKPykPeVamqnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EDE3101E157
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 12:19:03 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44D7CC15BB5
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 12:18:59 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 25 Oct 2022 20:18:53 +0800
Message-Id: <20221025121853.3590372-2-liwang@redhat.com>
In-Reply-To: <20221025121853.3590372-1-liwang@redhat.com>
References: <20221025121853.3590372-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] getitimer01: add checking for nonzero timer
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

By default a new process disabled the timer and getitimer()
returned zero value. But we also need to check if the timer
is correct when reset to nonzero.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/syscalls/getitimer/getitimer01.c   | 59 +++++++++++++++----
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/getitimer/getitimer01.c b/testcases/kernel/syscalls/getitimer/getitimer01.c
index 5ecfac55c..41903db07 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer01.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer01.c
@@ -13,24 +13,57 @@
 
 #include "tst_test.h"
 
-static int itimer_name[] = {
-	ITIMER_REAL,
-	ITIMER_VIRTUAL,
-	ITIMER_PROF,
+static struct itimerval *value;
+
+static struct tcase {
+	int which;
+	char *des;
+} tcases[] = {
+	{ITIMER_REAL,    "ITIMER_REAL"},
+	{ITIMER_VIRTUAL, "ITIMER_VIRTUAL"},
+	{ITIMER_PROF,    "ITIMER_PROF"},
 };
 
-static void run(void)
+static void set_setitimer_value(int sec, int usec)
 {
-	long unsigned int i;
-	struct itimerval value;
+	value->it_value.tv_sec = sec;
+	value->it_value.tv_usec = usec;
+	value->it_interval.tv_sec = sec;
+	value->it_interval.tv_usec = usec;
+}
 
-	for (i = 0; i < ARRAY_SIZE(itimer_name); i++) {
-		TST_EXP_PASS(getitimer(itimer_name[i], &value));
-		TST_EXP_EQ_LI(value.it_value.tv_sec, 0);
-		TST_EXP_EQ_LI(value.it_value.tv_usec, 0);
-	}
+static void verify_getitimer(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	tst_res(TINFO, "tc->which = %s", tc->des);
+	TST_EXP_PASS(getitimer(tc->which, value));
+
+	TST_EXP_EQ_LI(value->it_value.tv_sec, 0);
+	TST_EXP_EQ_LI(value->it_value.tv_usec, 0);
+	TST_EXP_EQ_LI(value->it_interval.tv_sec, 0);
+	TST_EXP_EQ_LI(value->it_interval.tv_usec, 0);
+
+	set_setitimer_value(100, 100);
+	TST_EXP_PASS_SILENT(setitimer(tc->which, value, NULL));
+
+	set_setitimer_value(0, 0);
+	TST_EXP_PASS(getitimer(tc->which, value));
+
+	TST_EXP_EQ_LI(value->it_interval.tv_sec, 100);
+	TST_EXP_EQ_LI(value->it_interval.tv_usec, 100);
+
+	if (value->it_value.tv_sec + value->it_value.tv_usec/1000000 <= 100)
+		tst_res(TPASS, "timer value is within the expected range");
+	else
+		tst_res(TFAIL, "timer value is not within the expected range");
 }
 
 static struct tst_test test = {
-	.test_all = run
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_getitimer,
+	.bufs = (struct tst_buffers[]) {
+		{&value,  .size = sizeof(struct itimerval)},
+		{}
+	}
 };
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
