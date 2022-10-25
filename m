Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E4BC38A2D
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 12:19:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B58603CA441
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 14:19:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 575F63C0134
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 14:19:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C61E86002EC
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 14:19:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666700349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4gjALZ7jpKfCj7hC7PxTU5WNQtTjMTdyebbq+UlSKbA=;
 b=WRAPgWvOJFJ1DYxCFA1O6ThtuHO8pwfzXhw8WGPJ5Ii8VKbvlHT0wwDsFpUyU62MR+DfIT
 wfxb3/PVo9pdgo1tAFrn+g1KoUAtyQSHPK1HT8F3tafO+QgL0d2P3+O5fDiFquij9sKcb5
 wsOz9z/bcMjiYwfD3Z5O/qrubshkZkM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-fdTUj_8XMEOLK4PEKnq5wA-1; Tue, 25 Oct 2022 08:19:07 -0400
X-MC-Unique: fdTUj_8XMEOLK4PEKnq5wA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96082833AEF
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 12:19:01 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7C18C15BAB
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 12:18:57 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 25 Oct 2022 20:18:52 +0800
Message-Id: <20221025121853.3590372-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] setitimer01: add interval timer test
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

First, split checking the return ovalue from testing the
signal is delivered. The benefit is that we could use a
long timeout value for verifying.

Second, add an interval timer test by handling the signal
at least 10 times. After that recover the signal behavior
to default and do deliver-signal checking.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/syscalls/setitimer/setitimer01.c   | 56 ++++++++++++-------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
index f04cb5a69..a59a9af1b 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -18,9 +18,11 @@
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
-#define USEC1	10000
-#define USEC2	20000
+#define SEC1	300
+#define SEC2	600
+#define USEC	100
 
+static volatile unsigned long sigcnt;
 static struct itimerval *value, *ovalue;
 
 static struct tcase {
@@ -38,17 +40,17 @@ static int sys_setitimer(int which, void *new_value, void *old_value)
 	return tst_syscall(__NR_setitimer, which, new_value, old_value);
 }
 
-static void set_setitimer_value(int usec, int o_usec)
+static void sig_routine(int signo LTP_ATTRIBUTE_UNUSED)
 {
-	value->it_value.tv_sec = 0;
-	value->it_value.tv_usec = usec;
-	value->it_interval.tv_sec = 0;
-	value->it_interval.tv_usec = 0;
+	sigcnt++;
+}
 
-	ovalue->it_value.tv_sec = o_usec;
-	ovalue->it_value.tv_usec = o_usec;
-	ovalue->it_interval.tv_sec = 0;
-	ovalue->it_interval.tv_usec = 0;
+static void set_setitimer_value(int sec, int usec)
+{
+	value->it_value.tv_sec = sec;
+	value->it_value.tv_usec = usec;
+	value->it_interval.tv_sec = sec;
+	value->it_interval.tv_usec = usec;
 }
 
 static void verify_setitimer(unsigned int i)
@@ -57,23 +59,37 @@ static void verify_setitimer(unsigned int i)
 	int status;
 	struct tcase *tc = &tcases[i];
 
-	pid = SAFE_FORK();
+	tst_res(TINFO, "tc->which = %s", tc->des);
 
-	if (pid == 0) {
-		tst_res(TINFO, "tc->which = %s", tc->des);
+	set_setitimer_value(SEC1, USEC);
+	TST_EXP_PASS_SILENT(sys_setitimer(tc->which, value, NULL));
+
+	set_setitimer_value(SEC2, USEC);
+	TST_EXP_PASS_SILENT(sys_setitimer(tc->which, value, ovalue));
 
+	TST_EXP_EQ_LI(ovalue->it_interval.tv_sec, SEC1);
+	TST_EXP_EQ_LI(ovalue->it_interval.tv_usec, USEC);
+
+	if (ovalue->it_value.tv_sec + ovalue->it_value.tv_usec/1000000 <= SEC1)
+		tst_res(TPASS, "old timer value is within the expected range");
+	else
+		tst_res(TFAIL, "old timer value is not within the expected range");
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
 		tst_no_corefile(0);
 
-		set_setitimer_value(USEC1, 0);
+		SAFE_SIGNAL(tc->signo, sig_routine);
+
+		set_setitimer_value(0, USEC);
 		TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
 
-		set_setitimer_value(USEC2, USEC2);
-		TST_EXP_PASS(sys_setitimer(tc->which, value, ovalue));
+		while (sigcnt <= 10UL)
+			;
 
-		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec >= USEC2)
-			tst_brk(TFAIL, "old timer value is not within the expected range");
+		SAFE_SIGNAL(tc->signo, SIG_DFL);
 
-		for (;;)
+		while (1)
 			;
 	}
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
