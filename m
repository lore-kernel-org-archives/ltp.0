Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C87C433FE
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 12:34:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5A263C80B0
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 13:34:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83B6F3C012D
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 13:34:21 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CC2481400C5B
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 13:34:15 +0100 (CET)
X-QQ-mid: bizesmtp75t1646915647tiq9dml8
Received: from localhost.localdomain ( [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 10 Mar 2022 20:33:58 +0800 (CST)
X-QQ-SSF: 01400000002000C0I000B00A0000000
X-QQ-FEAT: F3yR32iATbgXTrR1JwMJzXXgcfsjojdgYTnNVgsN6rjnqKgV/CTMHUJaV3EJz
 wZot1INozXdpEf3o+/RioBYXwYrL3vQpxdV1tD0cM79pX0PXMnN9z2x39dW+OnFzbPadqFU
 Egv/ZE8u/dcmV1F/pCPNOe7UNVO8IfvJ654veIMaTr7d+H81EDpaXB/89Tq8bIThwvZICDp
 8A+y1J/CbRBGauHJDPEyx/PAcUQlIL9+wmqsdaIj1gNlFJ/E+IY/5U0AHJWQITuGbnEidvt
 75xCOJXytVkHN5qjAOPN1vCGSOHIDn4nxEwaEaKDQ+Tu8vjGWDMxPB6CjykwF0PS9QOwen/
 a3gxKvdnu95TG6hY7qFG4QMcqyXGQ==
X-QQ-GoodBg: 2
From: Lianjie Zhang <zhanglianjie@uniontech.com>
To: ltp@lists.linux.it
Date: Thu, 10 Mar 2022 20:33:55 +0800
Message-Id: <20220310123355.26596-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/clock_settime03: Fix testcases have been
 waiting, timeout failure
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

From: zhanglianjie <zhanglianjie@uniontech.com>

If the system enables auto-synchronization time configuration,
this test case will wait until the timeout. Therefore,
the automatic synchronization time configuration of the system needs to be turned off in the setup phase.

message:
tst_test.c:1457: TINFO: Timeout per run is 0h 05m 00s
clock_settime03.c:35: TINFO: Testing variant: syscall with old kernel spec
tst_test.c:1506: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1507: TBROK: Test killed! (timeout?)

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime03.c b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
index f196a257c..ce0e7b4c4 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime03.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
@@ -31,6 +31,7 @@ static struct time64_variants variants[] = {
 static void setup(void)
 {
 	struct time64_variants *tv = &variants[tst_variant];
+	int ret;

 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	start.type = end.type = its.type = tv->ts_type;
@@ -40,6 +41,10 @@ static void setup(void)
 	    sizeof(start.ts.kern_old_ts.tv_sec) == 4) {
 		tst_brk(TCONF, "Not Y2038 safe to run test");
 	}
+
+	ret = tst_system("timedatectl set-ntp false");
+	if (ret)
+		tst_res(TINFO, "failed to timedatectl set-ntp");
 }

 static void run(void)
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
