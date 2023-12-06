Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD94C4167B
	for <ltp@archiver.kernel.org>; Wed,  6 Dec 2023 10:53:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E25343CBDCE
	for <ltp@archiver.kernel.org>; Wed,  6 Dec 2023 11:53:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C3F13C8880
 for <ltp@lists.linux.it>; Wed,  6 Dec 2023 11:53:31 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe12::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2562F14060B0
 for <ltp@lists.linux.it>; Wed,  6 Dec 2023 11:53:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU4+3nr4uXJANz8zfU5mFXLOsNJM3vqHns5+rvBh5wGL2EuC+bv8VMwK+RkKFk7SNq52V3kAs8CcIbn1Xgijt3pkxxgGT+H4vBH0MoqmQVBhXpdU+GxwPdK7KnmZEl4tTpOPZ3xUbcJwApxmejVyumMnKUewR3DDSo8dM5kwSBaM4qTgVYQb4Dq9Sdzc3SG1zwN6vIUHyMuNNoqBpNOWqWcwqg2NdXTVsLYQ036A7zL7PMwitjAx5rmBWPvIE8vNtYsekTFBn6CA1ntPOzvliqybeoB/4a5loV/Mi+c2YzIe66xDTAYLdvXAd6xMJNhhKN7y8b2gzyF5i6sK8wJzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0+xMgo9BunpbYiqpCPucyp3Bk/JgdjBw5lUT8r226Q=;
 b=Zj7wjKNjIru5qPBgo0Q58rFb9FUmg8Yj2V69MBM9qTrgJLji/S/ViopuVETiwP+96qW5/bXb8l9DX5GtE8pVE3h79ggiwOO/gxeP4rYj9anPuUO16fJfs1uA0x3OM+cGCZkriazwGludLAx9dH4aYCDMNxs8oHodHEyno1QW3vSnH/C4gedByMEldGCMSMG+H64Lkh/3UBD3eQSZSutgA1br9XTar3hm7bFZu9uJNNTlrjGhMy7jza+9Mto/v5LSVRJ5rOrtyGYmDGnRS/2HrMcpmgESo9xEPw0G4jDVEF1+/ekkWeF21X3D/eHf9a7Y999+yJlxL0/htscpGr/VFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0+xMgo9BunpbYiqpCPucyp3Bk/JgdjBw5lUT8r226Q=;
 b=FGERdxasRnFE9NTwt4oTeBbWxcDa5WaNfZOakJ/fu/XXtprlC1OXmnAotzfY6ebiUggO0VaZaXKMwPhvK7DVn6UzRiG0h6YijxB31b08yMdIbzCUPgJT9NcJ+LSPvFdqVNVzyf49IlYJrBt53PyFvHvnCipqoTyCY51uubMkVF67e62TuiyLPoGrpPXb4GR8Z8CkWyXdZnEAU4QFqwPkELGCFNy3dHxLapgtyN2IMtNLofqQrgWblyvDPmIRgC05bekvURhlcN+o1uJDzM2vHbItUDLI+my7AGcF9RLU/jQgwrbN3ldqV0vAw65hbjZ5WKpFeegPIQlrFsjt/0JwDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DBBPR04MB7721.eurprd04.prod.outlook.com (2603:10a6:10:1f6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 10:53:28 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 10:53:28 +0000
To: ltp@lists.linux.it
Date: Wed,  6 Dec 2023 05:53:18 -0500
Message-Id: <20231206105318.11832-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
X-ClientProxiedBy: VE1PR08CA0030.eurprd08.prod.outlook.com
 (2603:10a6:803:104::43) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DBBPR04MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c84a89-cafc-407a-e19a-08dbf64993e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHw4ilICWT2dStb8hkhaUc8tx1MaexMm/v3DcVwhCa8BztRDSKi6Wr1D1KEe9NkpOj6s25n//pB9pjapnJY1ASBTfN1iChPtsQUGtwQYfkeXeh2PLT5hxU+VTXFlNUHZ5UXkV4ypA0FDtrB5AXtUC2ub9qVowjcOEis++nl3X4uC/b1RJUsfSGJuMMA6pNuF9HQINN40tabzQtzNAppz7mWKKS5nkY+Z91A8EQv2T89kFgZGn/pJm36vjmvcPXqIH8v/mRnURQBZoHJQk1nhbC/hA95TrclTDxR8Biq+r62MWhG4ItQbASzMPP4UA0H5zexoBzu9vf+rFHQvOOFga7eoh5vix+JDiqVFntjR+GN/1DFJTwK8bFaG77rlfcYDemHWsgX65o6HT4UgM1RpgdL3cNKHj/macY1w4EhZ590X8mEG7yxb58/yNn/xqeyl7BG7xygYuZWpiUXHtc6KwIoqxdOd8JRwW8Ma0mKjgvF8SgemZS41W6u+w0WaM0Gs3redDxE6pE873lrnlByJzOeXLuiw1mXCF6uqHRP3UKzlk2QYED+uzScKuDEOd/+gtygoLX14Yx0uhFVOOvp0r6gMVi/zlUCBRyRzMUaD2Ew=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(38100700002)(41300700001)(2906002)(5660300002)(86362001)(36756003)(6486002)(1076003)(107886003)(26005)(2616005)(4326008)(6506007)(508600001)(66556008)(66476007)(66946007)(6916009)(8936002)(6666004)(316002)(83380400001)(8676002)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jh4kXUcgZD3oLH2IHMg1k0hIhjgSLTyD27A/Nx+D7C6A9IafB/1WS5QdJsGb?=
 =?us-ascii?Q?/kq3PbWTLBHoZ5V9I95dpSrPBbOLdGSqq4AY8jdfBNYFmv4/+xbTeALhvUPt?=
 =?us-ascii?Q?Zk2f6Nc2nbdahJhkz9xWJ6zMhhSD6tgqgeDHEMzxTdGLzk1ktRi0XMaKgTV2?=
 =?us-ascii?Q?qsOkv+B/kwFN4kSWXQEyzJYXdm58vn4Mqf8yQKOmr7vfBFN56a0KqoNeXI0Q?=
 =?us-ascii?Q?Mx+bXFgR2jf7UhuiEE/6C3qSoZlEu04OGsOtrCGpi26tKfH6u2J04MIFqC30?=
 =?us-ascii?Q?zOrgS7sSnuLtGMlWRDsaMaLnfq09K5X5m9chDlKGjJTzm15tMX9MzAaQn692?=
 =?us-ascii?Q?nTs5V3RrLXYV6pkIhVGhmYMxuiY6eeW4XRCFybR0IOFj7skWhkKUN620N5Lb?=
 =?us-ascii?Q?74EXm1RejhQjFgvUX3o7tADuoSMIjPgoFbOaDkPrD9wHJG1uBnVKW1RM3/Sg?=
 =?us-ascii?Q?wq4DQPVYdhvQVVMFKCo38f5Wqu8Xh7MJCZM2Tnfx+NZRmSR749s7Nxo4E7sY?=
 =?us-ascii?Q?D8lrJwV2pTqUGwiiBvii0KcKwFCb5EvqCcEJ0zTxiAcNkw8ZdEiymvJok/Ig?=
 =?us-ascii?Q?rSWp7ldcgA9ne0knMPZsESZcPeBCHDRLVKjvaE/UOMsnZVQzDHzVHJevtxgr?=
 =?us-ascii?Q?wRiGmObEIg8SBjC5Ru/vEETqUQjoMaSFl3A9BIv8BP2hIDX4sQnTO1KQmSN5?=
 =?us-ascii?Q?/ykipmsoSDe/JoPcxW0RrPM33Wy60EwZR1oB4NqluDE2Jy2bG8BAegbO+Vjk?=
 =?us-ascii?Q?Ex4QHTttSz7t8Gkwwcoz6P8EMKuLgposJvfgVVEhaY/BvXzPKpR/mNpNkmDK?=
 =?us-ascii?Q?WJpoNS7djk5Swk+pOaMXfWeI3HPhH+lZQLy5T3tFkytsFyBRTtA8jNK7hGJp?=
 =?us-ascii?Q?UFXMAFmuz4ZQl2nJT+Ww0WINb6XNOrvOBvuyDHs0x//YlAjjEeurBzZ6sboN?=
 =?us-ascii?Q?6XaWxHIM/7hQ59P5/6MzPw2Q/iLPCJY1ln4fvXIN3BZ1y5XI1cLeRhN6OZi/?=
 =?us-ascii?Q?dwdsv3FgE7nEJdY9aWSDO3hqCMzfUSnsETmfenFZHF46lKUtcoe4H7Xz6UQR?=
 =?us-ascii?Q?zyR8HcQ7giXwi4bU6wltBKDBG6dCBrDaK6jVDdaLvSmdzUoDwoK+1ZWnqEZg?=
 =?us-ascii?Q?inPUrbkhVBksP3Mg13uUM0/XHQNvJQNiJyp7eLmrlLG4GjCnFhlQ+jTlc3pL?=
 =?us-ascii?Q?dvwC1IKv2D9BOjHkjbJrY1LUvtQ4bPi1L3WZ1bjTZBpvgjd7KO4jVELK4w/Q?=
 =?us-ascii?Q?oKLQ5IRwmpzR4pSoK3i2uAuum6f7vZdVKqEW1Lrya0/C31EXqmG/RaS4Nt/f?=
 =?us-ascii?Q?TDTwORShH3ZGwa5wgFzGVYI1u0cBUOvPLVQ6w2RjpywlQHKmam7ox2ts2WqM?=
 =?us-ascii?Q?RkjDF/i1P5zzCbJyWfEPdWYArSrZRZDB1hH6dBE+ZuI10p3NSjfz3lMbmkEc?=
 =?us-ascii?Q?J/9E86BTWdBUGTXP8XrO6ve2B30FEjyYUJDGQ7LHkN71B+zkp5LX3Qp9PZZm?=
 =?us-ascii?Q?cNMrVB34ptFXOcw7duRdTrpsHIy4CJRydvcb935zD6BBbUM0StJasO1HMYZR?=
 =?us-ascii?Q?nlg7+iL7CmGPZt1W0g4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c84a89-cafc-407a-e19a-08dbf64993e2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 10:53:28.1236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5jMX0MIRq3SABQKuxicOtEwOdefwO695fxndcezYTEfaOYqfApNsVyDvUZQLuXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7721
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] getcwd01: Implement .test_variants
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
 testcases/kernel/syscalls/getcwd/getcwd01.c | 81 ++++++++++++++-------
 1 file changed, 55 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index 218bf4ef2..e62254deb 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd01.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
@@ -1,23 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines Corp., 2001
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
  */
 
 /*
  * DESCRIPTION
- * Testcase to test that getcwd(2) sets errno correctly.
- * 1) getcwd(2) fails if buf points to a bad address.
- * 2) getcwd(2) fails if the size is invalid.
- * 3) getcwd(2) fails if the size is set to 0.
- * 4) getcwd(2) fails if the size is set to 1.
- * 5) getcwd(2) fails if buf points to NULL and the size is set to 1.
- *
- * Expected Result:
- * 1) getcwd(2) should return NULL and set errno to EFAULT.
- * 2) getcwd(2) should return NULL and set errno to EFAULT.
- * 3) getcwd(2) should return NULL and set errno to ERANGE.
- * 4) getcwd(2) should return NULL and set errno to ERANGE.
- * 5) getcwd(2) should return NULL and set errno to ERANGE.
+ * Testcase to test that getcwd() sets errno correctly.
  */
 
 #include <errno.h>
@@ -27,28 +16,68 @@
 #include "lapi/syscalls.h"
 
 static char buffer[5];
-
-static struct t_case {
+struct getcwd_variants {
+	void (*getcwd)(char *buf, size_t size, int exp_err);
 	char *buf;
 	size_t size;
 	int exp_err;
-} tcases[] = {
-	{(void *)-1, PATH_MAX, EFAULT},
-	{NULL, (size_t)-1, EFAULT},
-	{buffer, 0, ERANGE},
-	{buffer, 1, ERANGE},
-	{NULL, 1, ERANGE}
 };
 
+static void verify_getcwd_raw_syscall(char *buf, size_t size, int exp_err);
+static void verify_getcwd(char *buf, size_t size, int exp_err);
+
+static struct getcwd_variants variants[] = {
+#ifdef __GLIBC__
+	{ .getcwd = verify_getcwd, .buf = NULL, .size = (size_t)-1, .exp_err = ENOMEM},
+	{ .getcwd = verify_getcwd, .buf = NULL, .size = 1, .exp_err = ERANGE},
+#endif
+	{ .getcwd = verify_getcwd, .buf = (void *)-1, .size = PATH_MAX, .exp_err = EFAULT},
+	{ .getcwd = verify_getcwd, .buf = buffer, .size = 0, .exp_err = EINVAL},
+	{ .getcwd = verify_getcwd, .buf = buffer, .size = 1, .exp_err = ERANGE},
+	{ .getcwd = verify_getcwd_raw_syscall, .buf = buffer, .size = 0, .exp_err = ERANGE},
+	{ .getcwd = verify_getcwd_raw_syscall, .buf = (void *)-1, .size = PATH_MAX, .exp_err = EFAULT},
+	{ .getcwd = verify_getcwd_raw_syscall, .buf = NULL, .size = (size_t)-1, .exp_err = EFAULT},
+	{ .getcwd = verify_getcwd_raw_syscall, .buf = buffer, .size = 0, .exp_err = ERANGE},
+	{ .getcwd = verify_getcwd_raw_syscall, .buf = buffer, .size = 1, .exp_err = ERANGE},
+	{ .getcwd = verify_getcwd_raw_syscall, .buf = NULL, .size = 1, .exp_err = ERANGE},
+};
+
+static void verify_getcwd(char *buf, size_t size, int exp_err)
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
+
+}
+
+static void verify_getcwd_raw_syscall(char *buf, size_t size, int exp_err)
+{
+
+	TST_EXP_FAIL2(tst_syscall(__NR_getcwd, buf, size), exp_err);
+}
 
-static void verify_getcwd(unsigned int n)
+static void verify(void)
 {
-	struct t_case *tc = &tcases[n];
+	struct getcwd_variants *tv = &variants[tst_variant];
 
-	TST_EXP_FAIL2(tst_syscall(__NR_getcwd, tc->buf, tc->size), tc->exp_err);
+	tv->getcwd(tv->buf, tv->size, tv->exp_err);
 }
 
 static struct tst_test test = {
-	.tcnt = ARRAY_SIZE(tcases),
-	.test = verify_getcwd
+	.test_variants = ARRAY_SIZE(variants),
+	.test_all = verify,
 };
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
