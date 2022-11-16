Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BD8C433FE
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 12:27:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD02F3CD052
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 13:27:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38E983CA330
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 13:26:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5BC151400159
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 13:26:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668601610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=osPN8uP0aa+p+Vb3pMl6dugTsPLcOjNReEUgYU2UIDs=;
 b=Iy+MaIExH0duMhyNocl29IqRsg0YyJlYlP9WdPvWn/jexb1SroxHTsMGCRqIrlk3Dq/z1I
 Ih6b8/G12MpTaR4HzJiyAb8lLjQNAzkk1XbY5U4fsCxD06gErJcRFJ5LLya3ibDpEVi1FF
 CsAQ51g75A2H9c1ut1HvVFF3qOM3uLY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-77eW49QWMRCh-wHoMq1dJQ-1; Wed, 16 Nov 2022 07:26:49 -0500
X-MC-Unique: 77eW49QWMRCh-wHoMq1dJQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D6F83C0F66C;
 Wed, 16 Nov 2022 12:26:49 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B77D40C6F75;
 Wed, 16 Nov 2022 12:26:47 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 16 Nov 2022 20:26:45 +0800
Message-Id: <20221116122646.4085688-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] setitimer01: add interval timer test
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

Split checking the return ovalue from testing the signal is
delivered, so that we could use two time value for verifying.

Also, adding interval timer test by handling the signal at
least 10 times. After that recover the signal behavior to
default and do deliver-signal checking.

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    v1 --> v2
    	* use prime number in set_setitimer_value
    	* print the time at the begining and end of test
    	* sperately compare result for tv_sec elapse or not
    	* print more info when TFAIL

 .../kernel/syscalls/setitimer/setitimer01.c   | 85 ++++++++++++++-----
 1 file changed, 62 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
index 1f631d457..d12abe904 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -21,9 +21,12 @@
 #include "lapi/syscalls.h"
 #include "tst_safe_clocks.h"
 
+static struct timeval tv;
 static struct itimerval *value, *ovalue;
+static volatile unsigned long sigcnt;
 static long time_step;
-static long time_count;
+static long time_sec;
+static long time_usec;
 
 static struct tcase {
 	int which;
@@ -40,17 +43,17 @@ static int sys_setitimer(int which, void *new_value, void *old_value)
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
@@ -60,22 +63,31 @@ static void verify_setitimer(unsigned int i)
 	long margin;
 	struct tcase *tc = &tcases[i];
 
+	tst_res(TINFO, "tc->which = %s", tc->des);
+
+	if (tc->which == ITIMER_REAL) {
+		if (gettimeofday(&tv, NULL) == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday(&tv1, NULL) failed");
+		else
+			tst_res(TINFO, "Test begin time: %ld.%lds", tv.tv_sec, tv.tv_usec);
+	}
+
 	pid = SAFE_FORK();
 
 	if (pid == 0) {
-		tst_res(TINFO, "tc->which = %s", tc->des);
-
 		tst_no_corefile(0);
 
-		set_setitimer_value(time_count, 0);
+		set_setitimer_value(time_sec, time_usec);
 		TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
 
-		set_setitimer_value(5 * time_step, 7 * time_step);
+		set_setitimer_value(5 * time_sec, 7 * time_usec);
 		TST_EXP_PASS(sys_setitimer(tc->which, value, ovalue));
 
-		tst_res(TINFO, "tv_sec=%ld, tv_usec=%ld",
-			ovalue->it_value.tv_sec,
-			ovalue->it_value.tv_usec);
+		TST_EXP_EQ_LI(ovalue->it_interval.tv_sec, time_sec);
+		TST_EXP_EQ_LI(ovalue->it_interval.tv_usec, time_usec);
+
+		tst_res(TINFO, "ovalue->it_value.tv_sec=%ld, ovalue->it_value.tv_usec=%ld",
+			ovalue->it_value.tv_sec, ovalue->it_value.tv_usec);
 
 		/*
 		 * ITIMER_VIRTUAL and ITIMER_PROF timers always expire a
@@ -84,10 +96,29 @@ static void verify_setitimer(unsigned int i)
 		 */
 		margin = tc->which == ITIMER_REAL ? 0 : time_step;
 
-		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > time_count + margin)
-			tst_res(TFAIL, "Ending counters are out of range");
+		if (ovalue->it_value.tv_sec == time_sec) {
+			if (ovalue->it_value.tv_usec < 0 ||
+					ovalue->it_value.tv_usec > time_usec + margin)
+				tst_res(TFAIL, "ovalue->it_value.tv_usec is out of range: %ld",
+					ovalue->it_value.tv_usec);
+		} else {
+			if (ovalue->it_value.tv_sec < 0 ||
+					ovalue->it_value.tv_sec > time_sec)
+				tst_res(TFAIL, "ovalue->it_value.tv_sec is out of range: %ld",
+					ovalue->it_value.tv_sec);
+		}
+
+		SAFE_SIGNAL(tc->signo, sig_routine);
+
+		set_setitimer_value(0, time_usec);
+		TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
 
-		for (;;)
+		while (sigcnt <= 10UL)
+			;
+
+		SAFE_SIGNAL(tc->signo, SIG_DFL);
+
+		while (1)
 			;
 	}
 
@@ -97,6 +128,13 @@ static void verify_setitimer(unsigned int i)
 		tst_res(TPASS, "Child received signal: %s", tst_strsig(tc->signo));
 	else
 		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
+
+	if (tc->which == ITIMER_REAL) {
+		if (gettimeofday(&tv, NULL) == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday(&tv1, NULL) failed");
+		else
+			tst_res(TINFO, "Test end time: %ld.%lds", tv.tv_sec, tv.tv_usec);
+	}
 }
 
 static void setup(void)
@@ -114,10 +152,11 @@ static void setup(void)
 	if (time_step <= 0)
 		time_step = 1000;
 
-	time_count = 3 * time_step;
+	tst_res(TINFO, "clock low-resolution: %luns, time step: %luus",
+		time_res.tv_nsec, time_step);
 
-	tst_res(TINFO, "low-resolution: %luns, time step: %luus, time count: %luus",
-		time_res.tv_nsec, time_step, time_count);
+	time_sec  = 9 + time_step / 1000;
+	time_usec = 3 * time_step;
 }
 
 static struct tst_test test = {
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
