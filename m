Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D886C41535
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 10:06:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9BDE3CEF1A
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 11:06:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2E903C99BE
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 11:06:24 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9958F6012D2
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 11:06:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTnSGokGG3eUx0sjksCYs8KMyE9hocLJEkHqQ+KgW7fMGFbwZ2FlPNn6TzRzfhQi83AQw+tGVBZkm0hYh9Q5zCyNsN2X4HxlNhVX8WOU4pGuBO6TdZfooGBCC7Jel9DYCq2CIwHb2A92lAqUBUJBmwjy4x4BYVQ2JB1KknK/N8fIqvk2swGOPNk00qGXPBqlO+kH0WWXMEi+pCazZs2JywKSOIsLs0vLxlMG6oDa0hY453wHNTQZlhg8tQbSRsBYkhNSg5JVQ0nxHxjXtUHg1taPIIi58iqYNa9rxGqQN1zFo57bY1Js0+CN7xuBCOmTvPeShMTb7B9SwHn2aU2BsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ+OYJjRxumJEJ46Lz2jimMJW9tWC3OqKZ9J6Fvw6vY=;
 b=KSgR8t0N9RImi7N2NE/Xa9BUQYmeifQtieNHNuKgK7HKxtT6II0x1NdfJ5ZkJXXpcc2HIA1PG7rPfca/Jm9SjuNY0h5VFIevis2U8XgqU6tfqeVC3TmRGQVPS2dmr7As9E68kTg/V35BF+NSBdUp9yMFcTslVMk09Kph+Jsl3ILW6mPJGTLTE//chhuT4yexQd6RnkFUg02MGMqG4Jh/T5sgCX2sEJHghodFdq/IR7YbEsORYStQmfyzG77LMusMTtYufkMwQnkrZ26IsEoPAIbJimu8yJB3mVsvyJdesS7n/PkzqQO5+itGBsXJ5WZQadSEP1/KELx/DTKQMw4azg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ+OYJjRxumJEJ46Lz2jimMJW9tWC3OqKZ9J6Fvw6vY=;
 b=eMBgacQRbu8RAAfZufZMavPJWu8mhX/qK3CxZngm03oOmtqvonc7fOR2RCom7DsbBFj8GUhB8RgXbNbCPpD9ynirBXhq+zSKE7uFtvmD5y2upnD/fKscyJwKa396XhAH7mbree05E+wPhDEjidmXjJVcE/HQX5vgNJdJF3WCsPYYwOKZsgF8G7F0MSifdfc2462BxchTAp58Y52cbxvH3+sip+ks9WEvXz0//Q36J2uoZzi7eFzzFHazatG4vCU5+8tbGNAfLDVuzOqNBA9khGowfPqwZMJxOMIbzO4bt75gquVUqFZy3Cn93xL701umNfWJJANb6ZZGb+VImMO5HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Fri, 22 Dec
 2023 10:06:20 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 10:06:20 +0000
To: ltp@lists.linux.it
Date: Fri, 22 Dec 2023 05:06:11 -0500
Message-Id: <20231222100611.12661-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231206105318.11832-1-wegao@suse.com>
References: <20231206105318.11832-1-wegao@suse.com>
X-ClientProxiedBy: TYCP301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::10) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fe8757-8531-4043-19c3-08dc02d5a522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4nQkt5RN0EJ+CUOu+4MdFKAn3QnIkHk99CImdkteKcTHrQz/5kMaZ7UrJsnC667/Jx13us3pQfvxR2etaKwSAJXi3Vaf8NGMgrfFiu85YY4GzCVrINJafkpXi9ZtuXEwy1+MuPwfuz7TvhNymNZF+oX4khm6+WqVJ25iWKJkcm3Gj7NhqT9/ypgJbYKF/74nWnm9AMnLf6mcEjZj/oLPbwRpref0AOSFC/Y3Oc6rWgyWxhngYyIDhj9MVAvqQz4cyNFOL33Iuof3LeHD0X3ViNjIkrHk7gSJr3kiwbfYq1RN3Bdk1tLiMG1AWY6TSA6BDKb7rU3kbvCh00YyxiLyRazkghyZZ42zL+7DnIoFOkow6QK0TWl+7tif39ule/p54e/VQlIUCa61tSQxFiu4cVCH6TjjwBgjNQHmy17nZXitIgIxg6SLKnH8NRjYO0wUdR4VSZ2b1TwkPQ2zOxv1AmcOGECit9RjH1WWYVGK2g+giQmILLOW5qirzASq0kzBBAf1I2hQk+UAL1oknzIVzGg7jM+cUuHdheI1a4xV4JwHSyAKtMei4jHsJlUzLJqN2vS5SHW8RVCYwvwT0v9aU0i5ZTQ4C79W3KxYcdG/7GOZjBOA1GH7ngt+h9VZgCr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(39840400004)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(8936002)(8676002)(5660300002)(66946007)(66476007)(66556008)(6916009)(316002)(1076003)(107886003)(2616005)(26005)(83380400001)(6486002)(38100700002)(478600001)(4326008)(36756003)(2906002)(6506007)(6512007)(6666004)(41300700001)(86362001)(142923001)(2004002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dAYZuToDYTMykjUT9Gy2/iSWuGXyXfV3Z0yUg54+87vN2L7GXp25aNXqRxB1?=
 =?us-ascii?Q?pd5qqaBNo2QziEsd03WTLekXEH9zPQCwd1kD7N9oQU7sUwQ6G8qgKgPbYrPb?=
 =?us-ascii?Q?uKNjv2Klc2LtYpRceVfylaGKKAYIND6hHuII287B7NcZSQB86wJuzpYgccgR?=
 =?us-ascii?Q?AL3LYIoPWH0nYafxTRIgULOm/jQMiG+iVpmfxDyNrpkP/+hsIrx9nYat6/7O?=
 =?us-ascii?Q?k2eUnWMPRYTanoHhtYkeqDMdNxhHBYiFruW1zvZSxOUCIJZtcma3vK1wFvwC?=
 =?us-ascii?Q?kTaVh32m60OfCzhQEprTQm0xSXPf406zBCyAHEJIQB3ZB87Fa56oqMzQvn3t?=
 =?us-ascii?Q?/0wboBm8t062tilVZQH/k4zv93zASZ50K9aBavO9ET9GD4468YMWPsqnDgJI?=
 =?us-ascii?Q?DYd+jVQSEObJ7Vrjwwy44G9hXSNu7066WJt2R608Z5plPvg/cqdNCR6AjF0S?=
 =?us-ascii?Q?cVPJ++kugRKHgOP4WkmeZG7f9q2ez0emOTCajSYCND98tyQMo6inYr7vpRe6?=
 =?us-ascii?Q?8YbhVia1e2xkNIYZ4b0UQGS1uujA52QXXeN4wZkfElv3g3yRRdAB39miFUiV?=
 =?us-ascii?Q?LdCNmKvkMo5IhorFMhDr3Y3QRuL78xSoT2IVWLqGTZD2QcqzMYUP9UnI3H6k?=
 =?us-ascii?Q?eot9RnuHuST9d2JlpqZ6ZjYgIfPJrtkdTLBS2CN6efdy5uRVHtFFKWGNuAPu?=
 =?us-ascii?Q?lKouOOymEf/dr71Sv2gv0IdYOwRfzor73b27VEeuIX0+k0/Abh4RmIGZvDpw?=
 =?us-ascii?Q?IXVJFS3Rq+1INCYPBPJ5HHbxkz1oCRmJ/mkiAc1D9OrKRIGEe4Bo5Hw7FvrI?=
 =?us-ascii?Q?gM1B2zn5nHGYDbOu0YRJv8ZJvZnQZa7QEOUyd47r9C7fbNu/S1S8MFkzN0Ua?=
 =?us-ascii?Q?Qlj2U/DRdakx/nNsr9JrCAXbmEG2t8SW55LU1zhOHxepocKN+Qk50Hlt4ubF?=
 =?us-ascii?Q?/5yp/KEc9e0Aq0/abs6I3vE05k91DHWQrvUCIYUu/qAySIi80S9vtCDutb53?=
 =?us-ascii?Q?/zaoQl26GKMb/PMIANXEKEVL9oT5sTacXoDdl2p0h7vHi6MeD0csz8Etj1WX?=
 =?us-ascii?Q?rtwUPQn5JgWuFnw5uwddYW1ZXsLlLH2uqXc0qqoMD0L1QZJLSgag7eXdX5iz?=
 =?us-ascii?Q?Yq6iwvFfad4bL0YBDo8VTwQ7qn+/KqnYfd5Maenu738vdqv27GFHnpjHRTcv?=
 =?us-ascii?Q?Dr1QAcmmlKzDkEtcXOW9iefbwJ+A7iR/dG7tYpPYJP8vkYSyqqcSuqURkyKB?=
 =?us-ascii?Q?rlCF6elhfiZFsajefr5AzY7oDcQi2mNJxmk7QTL5/amU5KHlh5bPVLexl/Jv?=
 =?us-ascii?Q?jgS4TgVBihgoi4i5Evy724xghSBA020GrnSgJpXP9O0OVy3ZeFyGffBnoFQG?=
 =?us-ascii?Q?d7oCuH5Kiy5NywuR7v/bjzsimLQeWmWfa75lRfIiSSBBki+tuhz0uoMWIY8G?=
 =?us-ascii?Q?TrN74GyQVSohu086vj4Hy85aFCEXQYFOXKjVPfmvu8K/HDfhbAhzEA0h1IEa?=
 =?us-ascii?Q?EeZjJoOPz9w+o0ZNl/Ctk6EnwpC5QfL5PViyCrMUnRBRMO9J7EAAzgybP6fu?=
 =?us-ascii?Q?cZ7cD70Na5XCjLXQXJw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fe8757-8531-4043-19c3-08dc02d5a522
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 10:06:20.4585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Gp2bNT2Y3bMw4T1Cs7mlTK7Q6qGUT+cLgzQl7L6dgKoNYgQPhMP865iojQRzuO1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] getcwd01: Implement .test_variants
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/getcwd/getcwd.h   | 80 +++++++++++++++++++++
 testcases/kernel/syscalls/getcwd/getcwd01.c | 35 ++++++---
 2 files changed, 105 insertions(+), 10 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getcwd/getcwd.h

diff --git a/testcases/kernel/syscalls/getcwd/getcwd.h b/testcases/kernel/syscalls/getcwd/getcwd.h
new file mode 100644
index 000000000..91f229904
--- /dev/null
+++ b/testcases/kernel/syscalls/getcwd/getcwd.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifndef GETCWD_H
+#define GETCWD_H
+
+#include <stdint.h>
+#include "config.h"
+#include "lapi/syscalls.h"
+
+static inline void
+check_getcwd(char *buf, size_t size, int exp_err)
+{
+	char *res;
+
+	errno = 0;
+	res = getcwd(buf, size);
+	TST_ERR = errno;
+	if (res) {
+		tst_res(TFAIL, "getcwd() succeeded unexpectedly");
+		return;
+	}
+
+	if (TST_ERR != exp_err) {
+		tst_res(TFAIL | TTERRNO, "getcwd() failed unexpectedly, expected %s",
+				tst_strerrno(exp_err));
+		return;
+	}
+
+	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
+}
+
+static inline void
+tst_getcwd(char *buf, size_t size, int exp_err, int exp_err2)
+{
+	switch (tst_variant) {
+	case 0:
+		TST_EXP_FAIL2(tst_syscall(__NR_getcwd, buf, size), exp_err);
+		break;
+	case 1:
+#ifdef __GLIBC__
+		check_getcwd(buf, size, exp_err2);
+#endif
+		break;
+	}
+}
+
+static inline void
+getcwd_info(void)
+{
+	switch (tst_variant) {
+	case 0:
+		tst_res(TINFO, "Testing getcwd with raw syscall");
+		break;
+	case 1:
+		tst_res(TINFO, "Testing getcwd with wrap syscall");
+		break;
+	}
+}
+
+#define TEST_VARIANTS 2
+
+#endif /* GETCWD_H */
diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index 218bf4ef2..6decb961f 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd01.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
@@ -13,18 +13,26 @@
  * 5) getcwd(2) fails if buf points to NULL and the size is set to 1.
  *
  * Expected Result:
+ * linux syscall
  * 1) getcwd(2) should return NULL and set errno to EFAULT.
  * 2) getcwd(2) should return NULL and set errno to EFAULT.
  * 3) getcwd(2) should return NULL and set errno to ERANGE.
  * 4) getcwd(2) should return NULL and set errno to ERANGE.
  * 5) getcwd(2) should return NULL and set errno to ERANGE.
+ *
+ * glibc
+ * 1) getcwd(2) should return NULL and set errno to EFAULT.
+ * 2) getcwd(2) should return NULL and set errno to ENOMEM.
+ * 3) getcwd(2) should return NULL and set errno to EINVAL.
+ * 4) getcwd(2) should return NULL and set errno to ERANGE.
+ * 5) getcwd(2) should return NULL and set errno to ERANGE.
  */
 
 #include <errno.h>
 #include <unistd.h>
 #include <limits.h>
 #include "tst_test.h"
-#include "lapi/syscalls.h"
+#include "getcwd.h"
 
 static char buffer[5];
 
@@ -32,23 +40,30 @@ static struct t_case {
 	char *buf;
 	size_t size;
 	int exp_err;
+	int exp_err2;
 } tcases[] = {
-	{(void *)-1, PATH_MAX, EFAULT},
-	{NULL, (size_t)-1, EFAULT},
-	{buffer, 0, ERANGE},
-	{buffer, 1, ERANGE},
-	{NULL, 1, ERANGE}
+	{(void *)-1, PATH_MAX, EFAULT, EFAULT},
+	{NULL, (size_t)-1, EFAULT, ENOMEM},
+	{buffer, 0, ERANGE, EINVAL},
+	{buffer, 1, ERANGE, ERANGE},
+	{NULL, 1, ERANGE, ERANGE},
 };
 
-
-static void verify_getcwd(unsigned int n)
+static void run(unsigned int n)
 {
 	struct t_case *tc = &tcases[n];
 
-	TST_EXP_FAIL2(tst_syscall(__NR_getcwd, tc->buf, tc->size), tc->exp_err);
+	tst_getcwd(tc->buf, tc->size, tc->exp_err, tc->exp_err2);
+}
+
+static void setup(void)
+{
+	getcwd_info();
 }
 
 static struct tst_test test = {
+	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
-	.test = verify_getcwd
+	.test = run,
+	.test_variants = TEST_VARIANTS,
 };
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
