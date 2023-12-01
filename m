Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90E5C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 03:15:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F37543CF626
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 04:15:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D67113CC705
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 04:15:27 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DD26A602A01
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 04:15:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgwTXNe2IIVw4liW+bgBKIhfpuEsAE4q3D2Okoy5bRGisacJ4rTt+NOu7/Qy54DuCw7om+oyPDs00T1gqNaIZrPWiB4fzPzKHRTh6UucoUoU1aGKhRwlEeBSLajxtX6GT1k532D/V6IWtyxnz4kGYwzaisfdFYQD744r4VnaKlsoi9hCARHtmYnfwgbpleqwhKUDOvzlRb2XAQRbuTJyKciOJ49kW7kMFHuUkmDboTwGaGL6XUnT2uXVEopKJJ6KKtqTphXNyXtTwKPI12YmHlIbuihVHpcq+/1bp1jvhQpkCZCw2AqtWCtYgE15nEnOJO/fMrBb3Nj4pP6pjXy52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0O5l3bf5sa6TvltfdDnrHH/ARYtmHF0yy8nLi/eRKE=;
 b=Pkx3NeXTXg2OssZGWBgPZKp1hUvR0hl75/QeQyWawF8IH8qfKl6ofm5dwB9PL1tzG8fCJyZEuck+X+S21nAFA9wKqDFaYxTeSPkWJSFDTwK4YvcfeoLR9O8po2uJBppBhYeqsQMr/yxz9euOFG3mpQsEZfKwv6H37B2ViQUDa1jYyiQqEIMt6s6c8wLqhlWv2LavW4EeGytfHAgSKRZGt+4f2Y1TIb8m2cS+A2VuWR5nw5z7G3VWMniW3UOaSfEWLDMjowzskuWLmaUctDPdoVG6K7Op2arzAHhFTYpZspGynWQD3yUhAF5bxpi8ITRnyhPdfF3fwFt6yTDfV9HpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0O5l3bf5sa6TvltfdDnrHH/ARYtmHF0yy8nLi/eRKE=;
 b=wZ1HfwCTPoDPhc/8CmbYspNoLBVFMdrczWEPSwC9b804nEl5F5dpxRPKih/VdIUX9KD96+6YN4MQHvHKMPOIr+NZQXZ+crvnvsvaAklnsxDWtsWC9ECo7SCoKKwciPBtlcugGYCT/gXFCLB/5BLMLe2AEHoXUvQkZwWe5a2NG+0XxtlByVE0hAAgrR1I4xViBv4e2N/hlpiIieIvRxFQ4wY0O/6ZMgWkxVWFBYYtzcASUijf8jcVldfheKkHiZR2LSIcf/WticbEVYkbCw7u+IQDtrFzRzvaJBQgoFcCyYbgVg7cCs3B6UmLVVsYhLbKpNdfJ+2nr32bknF9YqL66Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Fri, 1 Dec
 2023 03:15:24 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 03:15:24 +0000
To: ltp@lists.linux.it
Date: Thu, 30 Nov 2023 22:15:12 -0500
Message-Id: <20231201031512.27513-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230929004518.29632-1-wegao@suse.com>
References: <20230929004518.29632-1-wegao@suse.com>
X-ClientProxiedBy: VI1PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:803:64::25) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: d600f76f-e83c-4631-fdaf-08dbf21bc223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UK5+JCp2GhHMc+GaBEFvsKlQvoO8qiEtKMDYNK63zYD5PYtYIBbdeBTvueJifwKH5bYz+X6I5depZJZ/bTWtuIPNYwYrzCsibAi98gcBh9N/b1yM89eweWP/DWGGBuXXppSc6eD/yQhE3spK9hvBOmzpoXZ87dHXuFcNNHvA6PW8tb32wfom1ddAzF1v7rBnma+q5VsrhhRvf5DrLLSibVDzqjtyeJfyzq4oWxQa+AC0eE0Tvtw4qfGcwi4Dh3+/tH9w7Ym1hpsraUy2K5TyZHle0e0baj7PvtwfZ1jzVKMBrxTegBVFtlxw0c7VGYQLZy7w/o23VurDUMb2CRdnuBTZeLyvELS4VOheVGOuLoSF4I9Z7BvG+4OjuQ1AOI4bFEjgca+nazGqthKDwCIVTFTv7U9S+w0ofZoo54uJSTQ4LQEtLvSwuk6+T3hEQBr51BSzZW6i+bBUfkwD5u7+4NMm4fczSGIAU/PdHKRZb5wkWFBE8ASozdSa/tH1i0dCgJnDDJPrRBJVfa8j7Zxta/EJXpBiBR36sS6su1qFs48Lw+hmg6xk2mslPK4TQbJp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(83380400001)(6506007)(26005)(1076003)(6666004)(6512007)(2616005)(107886003)(6486002)(8936002)(5660300002)(8676002)(41300700001)(2906002)(508600001)(4326008)(66556008)(316002)(66946007)(6916009)(66476007)(36756003)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FFNpCvO6WKln3sojCAdHrL6Ip5gXdLHMfNOuzO6W+jHutFwM+lv0vF4Qex3+?=
 =?us-ascii?Q?Bv4TobxzAd198sJCz29qf+Q8sZIOdhQX80oCwky8KESWQ+Eyr7N5UZTu1/oj?=
 =?us-ascii?Q?KZ+ryRNGz/oniOjk2MznM/8JUVvMZ3Abm0kNgfTDJxROMb9VdqxTs8VfdMgJ?=
 =?us-ascii?Q?xWPv3I1gi5LlXlM27rBOXu0e5pdKT1AhCW2xQxK/Z1NoLVKB3ASiXdgJmH67?=
 =?us-ascii?Q?XwyeQB6B0wiIzk493Y6KiMzOF5OT0TrTXW+RyTAgU9WU8OSqtctIWO36idl4?=
 =?us-ascii?Q?Cg4RxyU35qljJ5RURfyYlHKAwiVpVcYp0JnUdX164elN1ot/NM3nUXiRnjhz?=
 =?us-ascii?Q?I2d1NGhVCL5nFnYtlDKuery0DVTkeoaenC5Hh+h5PdAB6BmTMUk7Nzv0GHTO?=
 =?us-ascii?Q?VaSvjA95AZf0izay/oiYbFSJYUSLjc9vhymXWMQYR00TgYHrJYTewqwqfb+5?=
 =?us-ascii?Q?orxu3V/zwIXFketzYbjTLT95ArkOpNdMMRP0ioXyj8prJ5T7V1xmveZAN5oW?=
 =?us-ascii?Q?KQCb1rCl0JboSJ+TynDxBXPPRRqa+vXLIHZPZCnwVTtKGl4XDirqu1cCyhWP?=
 =?us-ascii?Q?soHpYTp6MWdcQHT2FIvfkSmoARqtnF517L9M0AziOqpRtfwCLHf615BXR2i1?=
 =?us-ascii?Q?mbieHXgQvaKKh9SsXgEV4JOxax6cQgd+eiUKVGrf+DlLY5qisAI1mqXH6jmk?=
 =?us-ascii?Q?qh72gMffJTVhkItb76BIv1ItVOdEG/aa9ZFYMydo3ie9AZF0gy4cQBCoRn96?=
 =?us-ascii?Q?su2idwBJvhoWYIdlW4HHDDJHOM2tbVvcL8/+oaRD0Lf5n6fMHmV34KBU445P?=
 =?us-ascii?Q?O3cqM3gG6zKEauIWJ1//T8KPTw+ri77e5KmkS4uJWc4aAqZvb+0syQqfZfsb?=
 =?us-ascii?Q?14OLP6S15RdbpD6SOcZcvGbMRfb/opYRwH4dZeHmLEdcpjCOdTNUi8JZmwpp?=
 =?us-ascii?Q?TU2/ONLxn/TsiTC6QHM7tGcll7JxyXRRX3ekbsQ9pFD+/6aF6rN5by5bW2Wp?=
 =?us-ascii?Q?/ZdpA+iY+kWdCwyvK9UobgQT8JnyNY0LXp/v4GEKXg4M+2iaU6LOV+cT9qu1?=
 =?us-ascii?Q?E35fZp0XvUeoi/6rjfBgvOdjC0jFf1nCVkZRPtykzG2KkHxcUyKwAtk6dIQB?=
 =?us-ascii?Q?OIk5Uj8Owhqpx4ayCdrDIQdRm4sjXGurt4WGxhwZiwc6tqVOyvKqDCKTWpAN?=
 =?us-ascii?Q?HoyIKIHNTKhRauPhZs4ygMy5MorZAVDjOaEX3YEyXlGzRwdofL7d5JobqhZn?=
 =?us-ascii?Q?J/mbkCa/CHQBQTVuCgQ5ZEP9wtJTV133qbSpSALOvEyJ0alloci+Fs1bEdrU?=
 =?us-ascii?Q?ovib35LYobzz32uT2opBajsd42mcnQuX2Y/7/b1Er1vZMl6bipf+UuiN6CsR?=
 =?us-ascii?Q?xCa0SEQMkH0QqSdSKk+lJ8LV8CCN02ct5Kb+Ead+7qda4I0mtS26j6/JzQd5?=
 =?us-ascii?Q?qEhjsbMW0gCUmyh6f/kRrH3hA1A+h4Wq09kbid9eh50iOBNI+nqA7qvoDWOt?=
 =?us-ascii?Q?Thy2TLAnY0blZvqVDGQVCpcX+QR3cDzULia6Ee2bMOOzaQu4p5CDdZSvRpDj?=
 =?us-ascii?Q?GZCNXMhulsLlflhRPH4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d600f76f-e83c-4631-fdaf-08dbf21bc223
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 03:15:24.1231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM8itEjMLuVmSBF/xMjVOzV4WLnGm+E3u7jopSBZlJk/kvtsGnuBTSfZnlUMiihF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] getcwd01: Use syscall directly check invalid
 argument
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

Fixes: #1084

User space wrap getcwd with different implementation, for example
glibc will directly input parameter into kernel in normal situation
but uclibc-ng and musl will malloc buffer when buffer is NULL, so for
uclibc and musl the parameter size will be ignored. Use system call
directly check invalid argument can be a solution.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/getcwd/getcwd01.c | 27 ++++++---------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index 65d827873..ac35383a4 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd01.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
@@ -14,8 +14,8 @@
  *
  * Expected Result:
  * 1) getcwd(2) should return NULL and set errno to EFAULT.
- * 2) getcwd(2) should return NULL and set errno to ENOMEM.
- * 3) getcwd(2) should return NULL and set errno to EINVAL.
+ * 2) getcwd(2) should return NULL and set errno to EFAULT.
+ * 3) getcwd(2) should return NULL and set errno to ERANGE.
  * 4) getcwd(2) should return NULL and set errno to ERANGE.
  * 5) getcwd(2) should return NULL and set errno to ERANGE.
  *
@@ -24,6 +24,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <limits.h>
+#include "lapi/syscalls.h"
 #include "tst_test.h"
 
 static char buffer[5];
@@ -34,32 +35,18 @@ static struct t_case {
 	int exp_err;
 } tcases[] = {
 	{(void *)-1, PATH_MAX, EFAULT},
-	{NULL, (size_t)-1, ENOMEM},
-	{buffer, 0, EINVAL},
+	{NULL, (size_t)-1, EFAULT},
+	{buffer, 0, ERANGE},
 	{buffer, 1, ERANGE},
 	{NULL, 1, ERANGE}
 };
 
+
 static void verify_getcwd(unsigned int n)
 {
 	struct t_case *tc = &tcases[n];
-	char *res;
-
-	errno = 0;
-	res = getcwd(tc->buf, tc->size);
-	TST_ERR = errno;
-	if (res) {
-		tst_res(TFAIL, "getcwd() succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR != tc->exp_err) {
-		tst_res(TFAIL | TTERRNO, "getcwd() failed unexpectedly, expected %s",
-			tst_strerrno(tc->exp_err));
-		return;
-	}
 
-	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
+	TST_EXP_FAIL2(syscall(__NR_getcwd, tc->buf, tc->size), tc->exp_err);
 }
 
 static struct tst_test test = {
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
