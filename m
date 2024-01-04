Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87448C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 02:40:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30A1A3CD4CD
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 03:40:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD9CF3C8ADE
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 03:40:44 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A17201A0035F
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 03:40:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKMxXj3gifhbz7gpJMOOmAnpwXkSJHY/MaIFpr/M0YAtPYfV+EwIKMx0PJgbOO8njNk9kan5RR9KReshUFNS89barUKtuUaLmMwUTuk1Y4osba1zCtXfBZUdzh2Bn4ZxZ1vGuRRvTkFiRSYJMq1BMYookdL/tHYnLF5xWQg6ZTmGuH0fV7At9K9OKmxXB63ti8ziHZ/aVSLVN4jCJHoxo/8grgWaP+8ymPFOcZqN3je3zAVA8O1H8DM05FCPblA8/fYNXFhcF8O19sYwpYrg7iotStdGCuKvDic/IoMzv6f8crMB8bcrdeECQGZ8GTgnf3CTp2/DuLU1pVZkXgcxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4zHDGUhiocq6sSpKDmGPNmCxBYOpnTQu/7Qef1RXPs=;
 b=hGFrzYMVZ1PGPYc/jnf96yPXHoh+WliJrTSkFMTaPHoW4DqPaXSW5R2I0MvQtLH/ujLZMcqvGfJngBKRzCMh93ST7ulR6z/YZbwcMR+Y2JBVPL8cRCknfyKSHjWZ5XeKOIlZlhro12Y4yPutbqc1naRhp4GSLxH4X4uTvP2ulAGxRudcnOOrom52q9WbENRpn+zdv0jwGGU9bCKj26cLQXw/HFA4PpV6SrDOpLId66sjv1Q6s9gCe5lP3/VDsDRQUnxigzK7Dn8KKIKw/m6aut7bl8WKq0SYv7MiTxWqgknuuWPnjn/QaXSMziBIe3Mdt38GNbu/sYJPg2rgoCnTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4zHDGUhiocq6sSpKDmGPNmCxBYOpnTQu/7Qef1RXPs=;
 b=rl4P1BNXBH0o7LJt7nTFDAZh6R9sEsiBZG9G4wwFbGEpgYO/wKBTeNKECQo3BfOtCBQWNT6gBKlfHqRrNeqynAck+SYnQGguZ+G4YuBuWWJXFR5csXtjWW8U/nCJememvFioxoXrJpbiz+iIdIvmpPWnOiH8Jvr58FBcMOFOPNTMG55sg6PHI6ozWE0/Fdx6sIs5EK95uWMRBHuDzKlM0yfpApiqXzsl8o6cX56ufU7KaDJ2toPBeSB/hEMF2qm/t6sK3LN8T/7kOrRTTzT3hBtNKvrqCBn2FQ/+x2YFCoVXPHr9Y2xgc0Jybsqd2wr0BloCvWTDu5mhvMMZeMiZkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AM9PR04MB7570.eurprd04.prod.outlook.com (2603:10a6:20b:281::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 02:40:41 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 02:40:41 +0000
To: ltp@lists.linux.it
Date: Wed,  3 Jan 2024 21:40:23 -0500
Message-Id: <20240104024023.21357-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231222100611.12661-1-wegao@suse.com>
References: <20231222100611.12661-1-wegao@suse.com>
X-ClientProxiedBy: TY2PR0101CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::22) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AM9PR04MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 518a87fd-7ddf-41db-7f49-08dc0cce8a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rx/zqT66p3iHZSDKhCXYgiHH7XZGk1/2PzkbY5ZKPUrmpEc8YrlKjfnS+4E7aGpjHRifX2Di0GWfmGaNuegKa8VWsynPHvTavv9PwMVnCWKY7+Tov8HY1ejAs68OSSJZflq3ED4YrRriK674CznRjaAy3aDXXevCBOQEVs/SB5XdyQPpGXJM51B/O+gH5nduRc0IkC8xBwt1P2XBii0EK78K4pQsMA3plzXoaful5xlYvkDvmLS438dzOQJ3vVAdCuzg+TJuqdoVLlTt6mPRsew7U+2wGyjSTwGkgRhzb2OnpD7j0PCryoezkjEljtfWEkdJwdNt0hdWrqP5a6Lu6Ds81BoP+8YwF5/X6dzG/najDtGk2wDFO9aY+IE/ULYRxHdJcSvTO32TpcZhsZ3itR3rWpnwxYRo5G8yNPqr7UFdTQubs4eUOa72EVv2YMDr0GsBzbHV7wOmYhbnXMxGdWx3mJWg9rXllYzGaSWiO8ImVcpL9T2Hbs8DooniYBMKKdR5Ac2a7G9DM8aVs31qHm5wDVcNOSWEsQUfmcVlrqVZa6CVOTBcvLJ4811IW+UIWC4Q50WvVyCBPTbcbgkFZsHoMXe5KZG5AfU9BY4dk2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(136003)(366004)(396003)(346002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2616005)(107886003)(1076003)(26005)(83380400001)(41300700001)(5660300002)(6486002)(86362001)(36756003)(966005)(2906002)(478600001)(66946007)(316002)(4326008)(8936002)(8676002)(66476007)(66556008)(6512007)(6506007)(6916009)(6666004)(38100700002)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XhvRy7ZGnOkObEoLStdyb67BdfCixWiiq2YgysNumL6zoCHftSWfqvK8pOzu?=
 =?us-ascii?Q?si8DMjCIlcP5I+fmpbTVSrywPXmZZbwBqtPVw4vPC3ETFsnkSOG1kPH/FbmH?=
 =?us-ascii?Q?7HHYk/GqEukfxFv2If1fRRi8t2Wb+4pPt318odBPiIKGeyXxkJd2L+pneN6k?=
 =?us-ascii?Q?3G1ozV/BAi2PUOrjhLY3CzD7umybsVe+1YDWm/KEitryl181hVkjQpupCfTJ?=
 =?us-ascii?Q?KyNRhqDS21qaG7LhNwvElrlHPkTsBU2chErHTkZpoUl4zTcFtSOSvczjQ7cB?=
 =?us-ascii?Q?/OtFp1iwPWZrmtVPINvdcP5t5meDrInOa94tY+HpKnuia62Pj1/Vi+RmyW7X?=
 =?us-ascii?Q?zi/fT08l/i+fnH4M61uz6lYAlamQs+h1UZc80k1myPGmsyfGybFRQ5vQigpV?=
 =?us-ascii?Q?2G84ezwIyntWuA2A+ZItvbEqSDVzNDZX9SaSn2zeivXVoUz0KpTInFyplxqm?=
 =?us-ascii?Q?PlmvXn6rAFgcni3PSNv/JtOv106/vvb9S7T3XJCK/FTNDWjpTyswG6JkH4Nw?=
 =?us-ascii?Q?b1SQEu+yZ/VTirc3KspyiO8AP7mmGFFNF43+dclsULTDoibJpLbKQlKr/ijg?=
 =?us-ascii?Q?/fAQMYmVZR6HkyufC1CY6gHlg+0Qc9O0MyiAiFKPySN8CxbZRm3NsSzlxjNx?=
 =?us-ascii?Q?qATuAo+Y95Vf78K7ezg8CnYttgrF02R4BDmfuz+KBuNxaHtzKcM+simcTC+t?=
 =?us-ascii?Q?JK7Slbn6+GdEsgRyb6ycz2Yiwkx/a/RD4DbOp9DLKkt+DfF3xXxuG3DuAnvj?=
 =?us-ascii?Q?WY4OQVohj23Hmdi0H6ESQUj4vl2zFluZqWMYc42+YevL7hmI7aL7/16f8c/n?=
 =?us-ascii?Q?dO1r5JIZBOn7wMMitFPKCxGqkIicBwdKY8K+eP1uyG8SQTNfuNXgSQAdV7CQ?=
 =?us-ascii?Q?y1mIrZQJ6g2tFLHRJXoNiUnscDYbQJHe+h4l6KPT8JKhES085VnUB6cNNFpC?=
 =?us-ascii?Q?59QvSKwAS998JBNh6RVhFWPmVnv6RP5tUQFtiRl1UnNoW/ai3YZdUtmKzBIz?=
 =?us-ascii?Q?LKufBn+UbH0JUbI+3Bf4GlvxaBet6MTy+MUyNXLm5497fm4ibY3iTmXgm0L/?=
 =?us-ascii?Q?yJ+JL+R4tdR0LAavNRGBeJ7wEq8TQN7zK5aw7y7DK027DPEvLSQQ8UCGFkP0?=
 =?us-ascii?Q?bzSX1wRJImDNLwjG8GPA9sLZBp1Ah+7PsyZQIvbDW6y/6W306xu4vHiC75lh?=
 =?us-ascii?Q?kkpTn2CNXkKuVbVQdG1HuGlA+4RImExkmcNcToR6pkLg4MdkCXDcnpk/DiTr?=
 =?us-ascii?Q?4+HkHYEJ+jUlWnDSfurYIxAlJWvoYJwxr8n5rpIwl/UYo2+2dM1sLUZXNcuM?=
 =?us-ascii?Q?g2T5HuhgQMNFDxVe4lLrzqsIaMkFovgRQe6NorDi2I1Lld6MljIRW7B460RA?=
 =?us-ascii?Q?B4A+Ph1cCkyqCkoXbvOBZT3Ga0ySWQ9qPCl42HWe7yJzxBnzjyJwMeEw2lZV?=
 =?us-ascii?Q?95JGjaPEthX89ZUChI0O5v78cY5YqX3QXJ9UHIQBfIRqOafikj0JecpyZvNw?=
 =?us-ascii?Q?lxHPg3Qr0R+AoXFo7BJpxWR9Wx0/CWOS4OVUKQB8r/ImXI6oev82HwwXUeck?=
 =?us-ascii?Q?dY1Uz/FgUDnkxyMrTO8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518a87fd-7ddf-41db-7f49-08dc0cce8a06
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 02:40:41.5632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XWUUp2MmHisBdAyAhY45CNQwDNzrc90J/hX3Qoq3ceRHXZZ1J/5Blnx1LpdK8+c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7570
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] getcwd01: Implement .test_variants
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
 testcases/kernel/syscalls/getcwd/getcwd01.c | 101 ++++++++++++++++----
 1 file changed, 81 insertions(+), 20 deletions(-)

NOTE:
Postpond create TST_EXP_FAIL_PTR in this patch since i saw some change request on this area:
https://patchwork.ozlabs.org/project/ltp/patch/20240103115700.14585-1-chrubis@suse.cz/

Also this patch will be continue updated base Cyril's feedback on new proposal(pass the test 
both on EFAULT and child being killed by SIGSEGV)


diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index 218bf4ef2..e2df512e3 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd01.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
@@ -3,21 +3,34 @@
  * Copyright (c) International Business Machines Corp., 2001
  */
 
-/*
- * DESCRIPTION
+/*\
+ * [Description]
+ *
  * Testcase to test that getcwd(2) sets errno correctly.
- * 1) getcwd(2) fails if buf points to a bad address.
- * 2) getcwd(2) fails if the size is invalid.
- * 3) getcwd(2) fails if the size is set to 0.
- * 4) getcwd(2) fails if the size is set to 1.
- * 5) getcwd(2) fails if buf points to NULL and the size is set to 1.
+ *
+ * 1. getcwd(2) fails if buf points to a bad address.
+ * 2. getcwd(2) fails if the size is invalid.
+ * 3. getcwd(2) fails if the size is set to 0.
+ * 4. getcwd(2) fails if the size is set to 1.
+ * 5. getcwd(2) fails if buf points to NULL and the size is set to 1.
  *
  * Expected Result:
- * 1) getcwd(2) should return NULL and set errno to EFAULT.
- * 2) getcwd(2) should return NULL and set errno to EFAULT.
- * 3) getcwd(2) should return NULL and set errno to ERANGE.
- * 4) getcwd(2) should return NULL and set errno to ERANGE.
- * 5) getcwd(2) should return NULL and set errno to ERANGE.
+ *
+ * linux syscall
+ *
+ * 1. getcwd(2) should return NULL and set errno to EFAULT.
+ * 2. getcwd(2) should return NULL and set errno to EFAULT.
+ * 3. getcwd(2) should return NULL and set errno to ERANGE.
+ * 4. getcwd(2) should return NULL and set errno to ERANGE.
+ * 5. getcwd(2) should return NULL and set errno to ERANGE.
+ *
+ * glibc and uclibc{,-ng}.
+ *
+ * 1. getcwd(2) should return NULL and set errno to EFAULT.
+ * 2. getcwd(2) should return NULL and set errno to ENOMEM.
+ * 3. getcwd(2) should return NULL and set errno to EINVAL.
+ * 4. getcwd(2) should return NULL and set errno to ERANGE.
+ * 5. getcwd(2) should return NULL and set errno to ERANGE.
  */
 
 #include <errno.h>
@@ -32,23 +45,71 @@ static struct t_case {
 	char *buf;
 	size_t size;
 	int exp_err;
+	int exp_err_libc;
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
 
+static inline void check_getcwd(char *buf, size_t size, int exp_err)
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
 
-static void verify_getcwd(unsigned int n)
+	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
+
+}
+
+static inline void tst_getcwd(char *buf, size_t size, int exp_err, int exp_err_libc)
+{
+	if (tst_variant == 0)
+		TST_EXP_FAIL2(tst_syscall(__NR_getcwd, buf, size), exp_err);
+	else
+		check_getcwd(buf, size, exp_err_libc);
+}
+
+static void run(unsigned int n)
 {
 	struct t_case *tc = &tcases[n];
 
-	TST_EXP_FAIL2(tst_syscall(__NR_getcwd, tc->buf, tc->size), tc->exp_err);
+	/* https://github.com/linux-test-project/ltp/issues/1084 */
+#if !defined(__GLIBC__) && !defined(__ANDROID__)
+	if (tst_variant && !tc->buf) {
+		tst_res(TCONF, "NULL buffer test skipped on MUSL due different implementation");
+		return;
+	}
+#endif
+
+	tst_getcwd(tc->buf, tc->size, tc->exp_err, tc->exp_err_libc);
+}
+
+static void setup(void)
+{
+	if (tst_variant == 0)
+		tst_res(TINFO, "Testing getcwd with raw syscall");
+	else
+		tst_res(TINFO, "Testing getcwd with wrap syscall");
 }
 
 static struct tst_test test = {
+	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
-	.test = verify_getcwd
+	.test = run,
+	.test_variants = 2,
 };
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
