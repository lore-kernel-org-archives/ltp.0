Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5749F104BECF
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 10:24:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEC843E27A0
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 11:24:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 612C03C772E
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 07:26:16 +0100 (CET)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 02E8F1A00145
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 07:26:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1772691966;
 bh=BX6MuomIKDeZ7C4myQSkBUV4hPPvyO4XC0Npus/GYH8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=FfiyxWr5M1v2XkZwC65yVx2wBobwLJKnblh+olDlds4bHqK63Tuwur/LzfN7ePSjc
 1LsC8k2t22Q8K0XhagN7hgzEAKimpSqinLN3xHE37hAHm0HZUtG/PwIZ4aPJUv45mH
 MN3WePam+G5lHiNDA32yj9+3wklIBIlP5R1J5GZ8=
X-QQ-mid: esmtpsz20t1772691961t230dfb98
X-QQ-Originating-IP: aD8kE4LuokGlPoXh+IbaZ1c/bBSS8m6pFnpGhNcZwvI=
Received: from localhost.localdomain ( [1.85.7.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 05 Mar 2026 14:25:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2770148520827407047
EX-QQ-RecipientCnt: 2
From: =?UTF-8?q?=E6=88=90=E6=B8=AD=E6=BB=A8?= <chengweibin@uniontech.com>
To: ltp@lists.linux.it
Date: Thu,  5 Mar 2026 14:23:47 +0800
Message-Id: <20260305062347.449223-1-chengweibin@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OI1LVMnyggUVDrjJLfz4DJzE1jOAd4d3GaC8dDqtQEl2/m0WmGFS3HAg
 lVV0Y0oYtbipER6tNOP1n/l4Fe6rkYHSlg3Tao+hYn5Gzx8BeHIREuwaSofWq2AVbrDsdEm
 EbsTy+oscLUVJBSJmeVf39G5Ujh+H9byBq1SmmnX2ZvklJGFyl1PHYFncac7OMELocv8Kkl
 kDUNR7i+lZ5sv5WqKmGODaIavti9JSt6Dl+VwM6ow3CqYzXxDhOaBiZKQqNV+5MrE4XvvWk
 UIJxcSXIJdMiIUlZzqU2z6MsW0SQjSNSGvNVBkqz3pYh36Y2TMgE5uXx+gskc2atalhmfN5
 GaBfdNPXMnqCQwn0G80x1S/JYYscddm/+X2em3wB56Baf99bvbVAXAYrt4i+9zOq5vFqhrg
 Bwv0b371KfcTo+yIqSHNyw8lx3AB0j1N+hs6ncRDz5X9xjDRrx5/reESVgs+Pi8i2rw5QeH
 LQcLlBhuYkKHBqZ6o+0JzPJKqGxzFHhHCFX03wi4A5ZRadXdP+HKpHawhVRjyAoEkRhJrWx
 MGfmnbT4eKaTVCsMeK95MBLjWjNpIdUb93Qbn2zXNm5Wm0GSe90bwA3YMobtKb9gErO7ZF1
 Yc59vD+YDlbWK2kcYKjVgBXliUeHaCD3eXDWBaiSXqvDIPU/TT8nW6VdC6r74HtYh6QzPY+
 QqUrS5QriDi4GT4A8WSdR4tyReahyhG6MO8vjFyu+s2gCXBi7SQx6kbQ+eULUw9qwrtzZI9
 GL5G5+ge5q7YEVel/ktRHVEKqTzYsQ7rbqZV4xw/2eQGUCpEu0jB9S3pdUjN4iFlVaDiEhp
 P03//Rd7+IpASY6toubjleFmlwOGVacQ+ej8N7rtri/z/ezxeDopLcknpa7OFwS5w60vn0u
 SsFoo/5UosJjX1Q38P24z0GDxUUaHgAgZ3SuIOMq5dauIMwCJ0pnENSb55FqEo++1sG6m2c
 Suh6z9ygx5/yr0ZRSQNFj+iFuOj0EHBls2CEHk7Qm+Z1dF7Rj2q3OPb6L1rpt3zTth80=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 11 Mar 2026 11:23:55 +0100
Subject: [LTP] [PATCH v1] Change the fd validity check to < 0
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
Cc: =?UTF-8?q?=E6=88=90=E6=B8=AD=E6=BB=A8?= <chengweibin@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

---
 testcases/kernel/controllers/cgroup/cgroup_core02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcases/kernel/controllers/cgroup/cgroup_core02.c
index aba387197..a5c8c9684 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core02.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
@@ -77,8 +77,8 @@ static void test_lesser_ns_open(void)
 		SAFE_MUNMAP(stack, STACK_SIZE);
 
 		for (i = 0; i < targ.loops; i++) {
-			if (targ.fds[i] < 1) {
-				tst_res(TFAIL, "unexpected negative fd %d", targ.fds[i]);
+			if (targ.fds[i] < 0) {
+				tst_res(TFAIL, "unexpected invalid fd %d", targ.fds[i]);
 				exit(1);
 			}
 
-- 
2.20.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
