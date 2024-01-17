Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEF0C47258
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1705496036; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=AXQho8Etfn3+JcCSgqBaBOdcvlCnmiwVAY404lpxFwA=;
 b=GKnYC+1D85zuyA9bI0puuvkOTVFLfU6ZQFaYSuQQMXAIje6ZV+avbUDHQ3cTLNYg3vdoA
 RWQ4gH1V2wjF80s1UyKlIFjbUdnJESEPzrBfdgcVt1qdpC/bzZnCN0WF6c0gCk80ks7of9C
 LFHHT0EZsTCv61lgTgnPi1etQ8E9sIU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28C2C3CE316
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 13:53:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EC1E3CE308
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 13:52:58 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C11961182E4A
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 13:52:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M46JXuTD8FXFYeMRJcFYzY4N+XPcniaMZkBJtbSR0JuWHEKNELbDL0i/u2iuZ5msP1q579QtOwC7Aj7wJ/cR5rZ/sCXxwniCumt6b0nc7dqcqkpDTpNXTCY+iQ+xLR/M1/Fb2m11h7UJm0XPGsh1caqy90UUtsB+7E1n6ciXpr8s7NDxy/tKI4K/u5ACybUpK4zmbS7aOCcHzcfYe5fdk2UHAYwD5CVLxs40PN8c/EWpK5dmCSOLqCWuzO5OWalLHIr7kInu/2RU2JVsOiZObofMCnlU5EB7wOvmVMZrB+xxpCBbcMpcjQJgyNvdA62KLnLDEtLAYM3CtPOzbzj9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zknj/q3qzyafnZdJZfbzumKzdQlIsonQjZCXRbyUIFc=;
 b=ZJDpueD4MHJ/FucfmnkqaWrEARlrNEkXCejaY+OsTSmTHaXS3J6ai3wWmHi2Z88Z/h9vxYhOuUMvh0e06+hPefF1wxbQ9S2qAKjiVswlqht4C5DAJVgX8UH2jvnGH+SXsqMBCoJbIQT7NdI57oSbprouaT38SUSRjJI6Yayc/UQ2asd57iCtngDAxPisKjJTorEdK23cx04Lnp3ZxGiaN3d8b4lGn4OIFNUWcwnEO6IjMmPEJ0lNxBmZR22cAsmhk0DaqdoVHhYFR5PUk47WrDEFS4iXAi2IWTYS/oyAMVsV1I+DyPL9gvzYcw6egM/2Qc2Voj/Bb0zd5uaPzh9pdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zknj/q3qzyafnZdJZfbzumKzdQlIsonQjZCXRbyUIFc=;
 b=kMUwNFHCSHiBse1F957b2YlwL+Q+cLB9Eg1yaXIMET/Nvvo60l9xZ3ebI5dvwrIRvIUqvLLQlKylj8xODAFQSFMyxW5oiMBEjJ1A4nGuEuCqZdb6tk76B/yczIn3/QqzaIfaB2mgZtDsdEEk0fJrlRiXPl5pCWiGI3e5CxoW8EJWWoyFkUUvclENkoaN/aeV/AqNN4nNWetncEMPjE1anhmiGMAPyxKN1oTOLTUFCLZA9aSANibQIVdTRJIVNtPcG1cfPlswI3dNyNJaU2gHqjDkupmVsRKqRfR+Aqyt7ty+KDKvTQ5ydFp4sBseQeZuCxOC63Czt5djbDZp2ZiVLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Wed, 17 Jan
 2024 12:52:55 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 12:52:55 +0000
To: ltp@lists.linux.it
Date: Wed, 17 Jan 2024 07:52:27 -0500
Message-Id: <20240117125227.24700-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240117125227.24700-1-wegao@suse.com>
References: <20240117080446.9663-1-wegao@suse.com>
 <20240117125227.24700-1-wegao@suse.com>
X-ClientProxiedBy: TY2PR06CA0041.apcprd06.prod.outlook.com
 (2603:1096:404:2e::29) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 465396e4-6049-4617-b82a-08dc175b392b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoGzhmTnCR21K06SOZRv36ehPHbQvySEdbAIwB9tkWr8DUrgMhps+Qg+7B1rYO33fiTCS3vKtmasEbJgPrwCsPT7962bCZ2wHE/ysMhDw0e71wR6AeZWuHtlrS4QDI1lgCGkk2EjZb+4xlgb4i8ue2Elv0I56CSnMCaEYgyQ14RzsVt7HKd4kS9Dw/weAfWyiggQWoTZ4FhhGIUGIkT1ip0yrZEW4sqj4cwWw0GvQ86V5jXfHG/NF3MCXIeg1y32wUNqjcb8Pe1WI64gG4D/gRI95crm6h4hZLXtEzwP5vsO/da6GcP0aoWbIrmOUVt+xsgx5zTzliHfIVAACxFa3aSll+tA5w9E++i9ZMXrugbObvAfWcLTYKh1sZ9zsZIQP+wS4cb7WfxBkaNs+V4dAUnUa9YdO6sObt5aE20Rsyf0ELu2OvPWp62msz0LlidAqLCDgxMNzeP1chsqaqbCmNt6/z1bK+6pY8NwEp5eVUtQ3jxXSdHNx0kKAGpmu9wkAb0H3H21md5BylCaAJpLg6DD7148X2S3i1WDj1KLB4ho81OJBitjEmxEU6E/MbLBYE3eUoafVZJzQECf3ZwoJuI1N9CVl/S3lnrTZlMPdx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39850400004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(8936002)(4326008)(8676002)(5660300002)(2906002)(26005)(38100700002)(1076003)(107886003)(86362001)(2616005)(36756003)(6506007)(316002)(6666004)(6512007)(66946007)(66476007)(6916009)(66556008)(6486002)(41300700001)(966005)(478600001)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mKVnYLZUqmKCNRhsbMo1xXlH4/P3Ny/s1diRsXLpWxhGs4aIBRElFaLQC0re?=
 =?us-ascii?Q?qvv94xMQFl5AC2OZYf0psTqXPCifrpR+fPjhIXsP5TWtD8EtJ9vjqEstiIXz?=
 =?us-ascii?Q?Lejh7llE907d+58M/E8SBzcH4qBHMkzTnLeqa1IXtD+i4uofJ7wgOzSvOjWC?=
 =?us-ascii?Q?yHI72y+sdnUN6eMpnITX60S6aGnGsZWjMbMU3hiRbXg/PWyTMYbIWTwslUFr?=
 =?us-ascii?Q?vHb1ZeQnwzXW8C0ZlK5xaaYYKOIhMbIvIZmEoDxr1pyT00/zOi9/w/MH0T0W?=
 =?us-ascii?Q?oqj/PI2Jiah8K0vTn1BXzFPDHMam63RhmZuLxeOyT4wvmbQner2Qe0WgJkl1?=
 =?us-ascii?Q?Si/OpTc+GRsv9yRVM0aQsA8SkSGhyVVds54r1+9BP5aw1oRAdj9qehr7Sd8T?=
 =?us-ascii?Q?riI5KxjyFpOTcN0E8oHas44aFJoV2XAjUAiU4GmzO7SJyn7P56dGUJmPBshI?=
 =?us-ascii?Q?s2Rf80/Cde1NIvPToYjdDMHzz0UIGxWSBhXYkz0KXPXZdsT92sSfQcitFAvN?=
 =?us-ascii?Q?W6HAy9zKCLcmEVTJFVgfocFsXzT9IllzudFjGhSLflTcEI66nUKE9Z6YM78s?=
 =?us-ascii?Q?QuWYE66/WDhgTgaRmmq1Sd+FVqcapycg7v8Id3vUhIKiPOTQLpkixSocBovU?=
 =?us-ascii?Q?vMibRQqP3UhoemVxMQYZ5qZtUk4bslVxFk4ffXve7STNH77mqbYhca3XT7Us?=
 =?us-ascii?Q?1UQtmWkScq0KKQvaIKncCvbmMIJaXZLeZS4+kubaZ8/RlVMJdG4P0q8OEBJy?=
 =?us-ascii?Q?2L6w7d3Dqlh+gZair1NUeeqsV5ml5IqTHGTLSNXc2/+ON+gibHrmVpYCs/sN?=
 =?us-ascii?Q?I3B1wiXlZEcLJ8TNvi2n4X5Rxycem3uT13BbLQ14KdptG4wcjApoaDf2fh//?=
 =?us-ascii?Q?OPpBcYK7xuePYKI9/0TwHtPx5CulVIlGSMR0YKMzvO9eNYQuxHOCPiftjtH4?=
 =?us-ascii?Q?KjsJECU7XasXeoSUBErAqdKVHcZohEu9EKIXlxWSWw1sAuNG2XYKZshOOSqZ?=
 =?us-ascii?Q?UM4YalQ5Ef5eXrWioCq6SB7zn3H3QNkh6OQojQVp8TrVbH9BT4s7b5tcM5D3?=
 =?us-ascii?Q?3Uq1AOzPOuwtQlsdNjrUrWd00BXEIdcw4SjFO2c4U85QuA6F3zFALuuaK+e0?=
 =?us-ascii?Q?vAYpJASEhVK331O1fqhOo5PwJY/vFCs87muJEhgfdU/83c5H6pKO9eRcG3/b?=
 =?us-ascii?Q?8go+dbSm3sr7Z8AaKXPzGnZdus9KWzbAFTLA0fK+HiNeU49hMEE4NvHb/Jln?=
 =?us-ascii?Q?LbleMEwwKjBU9bfL9exEhZCwnnlBqBj/oBE+z3zd2ri+OeNlaQVCDdTqlZUc?=
 =?us-ascii?Q?grByiaEf79qr1DjlHehmyjBHkeSxjsP37rwEV+3gPON5UN+NaKbgdQY1kTvb?=
 =?us-ascii?Q?GifHfZqC4Vqih4E1rs5+JozBDaT1x7xDAv4U5Ng05oHnBdfD2LhxFbwHfxv0?=
 =?us-ascii?Q?ofldnJNlvlEBJxy16Jhy3y/5URCK+a5rbKo6Nzwlz0GR03vcovvo2El5TOKn?=
 =?us-ascii?Q?Oyl2OYZ5lQz4onB+mYqtFBr0KR/DwvtcKxUy1kjZv0ZkCVJkJpAqzX+f0SaF?=
 =?us-ascii?Q?ukocKa2JMs2bvPi/8iY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465396e4-6049-4617-b82a-08dc175b392b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 12:52:55.0163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahJVZKMJkjfVBTMeToXwAhLfrUS8zQjRpOGmrzm/rGfes+LkvJ74rGOv9BDDsN7K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] getcwd01: Implement .test_variants
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
 testcases/kernel/syscalls/getcwd/getcwd01.c | 80 +++++++++++++++------
 1 file changed, 60 insertions(+), 20 deletions(-)

NOTE: Cyril give solution for run the test in a child and pass
the test both on EFAULT and child being killed by SIGSEGV. But
currently i have no idea how to do it since no SIGSEGV will hapeen
if NULL buffer give to getcwd. This file just used for give a real
user case for TST_EXP_FAIL_PTR.


diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index 218bf4ef2..879c36206 100644
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
@@ -32,23 +45,50 @@ static struct t_case {
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
 
+static inline void tst_getcwd(char *buf, size_t size, int exp_err, int exp_err_libc)
+{
+
+	if (tst_variant == 0)
+		TST_EXP_FAIL2(tst_syscall(__NR_getcwd, buf, size), exp_err);
+	else
+		TST_EXP_FAIL_PTR(getcwd(buf, size), exp_err_libc);
+}
 
-static void verify_getcwd(unsigned int n)
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
