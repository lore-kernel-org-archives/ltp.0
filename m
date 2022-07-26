Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A641EC433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 07:02:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 030143C9FE8
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 09:02:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48BFE3C87C9
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 09:02:15 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 002B11400459
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 09:02:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1658818935; x=1690354935;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=meHwPrAlXvVFJ48G5X0XgRD4lYr5q51Rn67KkOgPIXU=;
 b=oAi0Q5FDVEqf9Ryrl3HM8xVrczBsqKIw1nrG8FikjtwB178jr8eSgxSE
 8MEt27abf+NeYO9uoH78HwLLpmc4VVFtCCyUmJAyvz13tBPavxwX0J9oi
 g2QEy+VjK3u1Wqj+uStleCYt/MESVkZFpQRQMnfic815Fd0485Q7eAH7M
 0+Rz654Z1R4Tw88gsEXZhPOQfye1R1QHNrzVIeGyoY+Krb/+pdBzI5Hlg
 oE49N4LLi5FmzdR/r0OvHB5Q72cyb8VFONSnT2rADA5UgQZ+9EUchdjbC
 IBKAwSPmES2a1Gl2Wau5z75iTySoVyfHlOBxP8TMn3BMWvQ/KEfaVai8a A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="61186660"
X-IronPort-AV: E=Sophos;i="5.93,193,1654527600"; d="scan'208";a="61186660"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2022 16:02:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt5RIaikH6/QRWYl1oZjp8DYPHvebfhK2mMY8Cufux918zStQZFwC3YL9hml62KBgIUVJPygRPA6hqnoMHcypyCulLN7LKugyKm0pUpSpk7IaKzd6zU5T8UwuO+XjskUHTuMO4Y+F6y14fX7QnEwloFOMqL0eRPk3o5CNlnURJrOeVMHsyZPKpREzwzXEOc4SjHY1MZEGsmZ4KAcWoWH6E+R+gG2UfNpyLdqmEsJz3vnVxIccYKoCt42zo63QVuhcuY5U2YdI51fQ/tt2Wsg1Hsk207bD7uhgC8rpdMg78j7IWDFHe+OShuj7nQPxN7dL8koASr7+7y5Qllwp//iUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meHwPrAlXvVFJ48G5X0XgRD4lYr5q51Rn67KkOgPIXU=;
 b=fsUJSJZO2uZz2fCEySicCuo3V4BW6wwwHgvhjzQABAhwukEZ24rxBy3Qs+n5omRlO3yphQQvajZ9M97zOGmjdS6VJ8xoe5eTYfh2pla8c84V6jIZoYxat4ktQPgCbx46c+TLhMD02aygkjGobAX2t1wIlExRQHYMUGKSQWBCAg6fldZig2aXljJIOs2zSXDEB8Iym1qGf1X2wvEWrjCjbGw0S44mgs5PFkPxJPWT2DRCuZcE5WXZHyWOjPEyKpEiEuv2VKxlSfW2lVfNaV7sXq5hfMP7AY/9aSwN16EnPhBRbuV4GXT/UdkdBupQN30pL4Q26ZoI7zph9D1JZvEoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB8586.jpnprd01.prod.outlook.com (2603:1096:604:19d::6)
 by TYCPR01MB8157.jpnprd01.prod.outlook.com (2603:1096:400:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 07:02:08 +0000
Received: from OS3PR01MB8586.jpnprd01.prod.outlook.com
 ([fe80::576:dca1:ffc6:de00]) by OS3PR01MB8586.jpnprd01.prod.outlook.com
 ([fe80::576:dca1:ffc6:de00%5]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 07:02:08 +0000
From: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v2] mount03:  Convert to new API
Thread-Index: AQHYoL2f/2h4GwwTQEiDpDxZoOiwTg==
Date: Tue, 26 Jul 2022 07:02:08 +0000
Message-ID: <20220726070206.266-1-chenhx.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca4e4b71-5fac-4342-cefd-08da6ed4c18c
x-ms-traffictypediagnostic: TYCPR01MB8157:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X6sgmv70IoHXiZ2fOIjMB/BWZvF9SYZ6BxsrFdVYKslY+irUgKjKuESFGpfp+4VNJbJQt+Q+oiz5Luif00GoytO32EMBXFf0BqFW+oAoMgMqOOWwnSykzfpCMuUmQEUwPfuvZO5Fx5IfH575xIP2Oe8Rhmcci+eq0982DQ7Y8cI43T5ovIui3pOfdE4w+i6WIxBmCydteyN6RTbOGMnB0moQMcCe4DPdj3vXL4lv88Ni+Q/VujGnPZlenTRd3NVmBSJVuuYkwDDDymmfksuJ6RlRzTEPlajVi6O5Nc3ZFHuTrQwerNfM+OtZJf2D7uUWimRTjAeia2Clt8qCVlTRErEKzCoJ9vDA35bZbnCUoR0Kru8KEjifQannpBS5FJEUI7tvQ4QFbtacVbVnoSdBfcn2uXw190+OGXwaXTooU7DgC2Bs2bBEKra7eInOEHPU2FouGO36a5NLfXyhebyIuo1MsrsDRrRfjtiy5ZC1WY2/4XNbeOjrtYv2LAFI2HDS9P/5T6seixo83aU30/CyL4420WRxKe4zZA1O99KxGR0TgeJCEEoGBcHYLpyUpo2ebCW9KOZgPV1DlZ8aDCmVLlgmO53yk5NbFoPRzOcIEhHDgzZeDm4crfBTZ0rJ0MeHGnoeKOFGJUqwmPbWRYT2L3doxrM2sMdI8Z1CER+9KZpKNKQoCa20BsHaVy8I2OQu/8vroaCdu/Ma2/13HtkQLMnq1rEMJq+PrCET7Pr171jJbPTXT4IFk2mX83L6k8YVaCIo3mzHgLprTmxvZJzbyGWL/NqOIdQntOPuBNxXbnJ0uy9tdUTBSbuiH42eaonD3Uv2Azv5DXHrp+e8SUvwWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB8586.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(91956017)(66446008)(66476007)(122000001)(66556008)(4326008)(8676002)(66946007)(76116006)(64756008)(478600001)(2616005)(6486002)(71200400001)(26005)(6512007)(6506007)(41300700001)(83380400001)(316002)(186003)(1076003)(6916009)(86362001)(36756003)(85182001)(38070700005)(82960400001)(8936002)(38100700002)(5660300002)(2906002)(30864003)(2004002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WVdPVUdmQzJUVlhMOUFLUCtKbDFEdjZ2K1BkSUM3NjRDdWhRRDV6TTRNelhJ?=
 =?gb2312?B?TWRNdlI1eFpJYkk0YUhJUENVVHN2UzJ2VEY0c2ViOHJpR3RocG9qVEdSaS95?=
 =?gb2312?B?NTd6MWV2VUNpcVowb2NDbWltRmVUNnVIL3hia3ozRmhoSldKY3E4bEZ6Tlg3?=
 =?gb2312?B?RWhzTW83elF0R1JYTms2akJyMi9iVEpyWndrT1RQTGd6NTNTUjVtVnh0TDBP?=
 =?gb2312?B?cGRKQzU4NmFzYVhiVWVpaFplNWJvdlZCejlVaDUxQUxNeWtzU1p0L1BzS1B2?=
 =?gb2312?B?QllnZE5OTGpjQ0JFc2dlTnNZQ05KY3NXckVkY3pXdm5YK09pS09hQVdxenRI?=
 =?gb2312?B?TE5RVDhSS0hpUldjaXd3KzVNUHRBN2x6Sm8vVkFaOThHMVk0VUxVanVzMk5w?=
 =?gb2312?B?N21ReVJJK1ovYU8zdHRZd2t3VUhNN2NLZ1JXMkw0cnI3V1dwSU9NVk5mcVpv?=
 =?gb2312?B?ZVBoT25lSFh3azJqNElzSFNyNng0NjJkekJONkhadjF0WEZyK01DTnB0L0kw?=
 =?gb2312?B?bDFvTXQ0NVV2WmdKY21uTFpTLzMvdDR6ODJVTXVXaEtyMkJ5Um1OeWUreDFz?=
 =?gb2312?B?d2FGbDBTMUJ2cnJHNDQ0NXpySjgyYmJrR2JQVGduUXIweXVLaERPeTVaWlBx?=
 =?gb2312?B?eE4xQmJlVmFsYm1IWmJZZi85OTNKeFBVdVF3SXZ2WnBrM1ViRGorcG5OMWVX?=
 =?gb2312?B?U1F3ZmgxUmJGTlJEWXFRSEJpaDM3alprQ1hWRFBZaVpBaFVFbXk0SkxxUWpN?=
 =?gb2312?B?OHVDU1dDRS9EVTdkVE9EQzU0SXN6TVlheitZMUJXa2o5YVU4RnRDdk5zeEFU?=
 =?gb2312?B?akdvSjBhUnptWmEyd2pOaHZXckhlY0NNVjUvWkdxeDZJV3A3cWswQWZwUmRh?=
 =?gb2312?B?TUlKR2tJNzZSNllFTTBabmpNYXVhd2w1T2FnNTlDNGhEeHBlR2FScmpGNDNk?=
 =?gb2312?B?bVB0NjZsQ3pYc3h0RWtCdDBlVzJzdy9RUG1qMVNZcHdQRXRRR0Q2WjV6Q21p?=
 =?gb2312?B?NWplUlhFeHhjczRKdFRGMUhpTVpmbnBQNWNhem1YelVhN2ltVjZzV0w4Uzdj?=
 =?gb2312?B?VTJaMk8rdDhpN0tZQ3FGMHFGanZ2SnB4QTBhczdqR3pMVGd5L2NzQUhFUjZQ?=
 =?gb2312?B?bC8vVFNBRjZJcWJnclVTY3IxazNWY3RjejlrV2lJVHFMaXhGWldmVlkzSEN3?=
 =?gb2312?B?WHB5Tk1ocTdEeldxUWVKcGVybUQyTG9ybWF2a0RQRlRIMm9IUkEvMzVSUkN6?=
 =?gb2312?B?VFFUeldVbFUwTWdGUVJ1SW9UL0xCZG1zcEFGZktWVDY1VDdHbkF4U1RRUVZQ?=
 =?gb2312?B?S1Z6dHJKYTRpUTZIbEhlRUREZjN4SFhsQlJxSWdMTzBSQzlGUkFhOGRtQmVo?=
 =?gb2312?B?RDlDWHhGc2FvT0kxUGI4QzlHYjFINWpmL1l3ZExvd0c1K01FVzVJL1JVWVBj?=
 =?gb2312?B?b0FLT2lmVTB5dzBPSmhuMTJiQU1ldTJaYzJqY0p1bkE2Q1Q0TkhjU1pJNmhL?=
 =?gb2312?B?RnFwQ0x6WGZtRjhwei9DbHBvUHBwZjl4WmlMbVE1SnpYdHc0VThralpBdklv?=
 =?gb2312?B?WndoTTRRNzJMV2lxQ0ZCZ2JINTl3UFFvU2JOT3ppSVBMYmU4Zy9EVVQ4SzAz?=
 =?gb2312?B?Z09oVTkwMkYrd0NvTHRzYVQ3cTNyNmg0NnIvNTRxcVY1M25iOU1HYzlUd2ky?=
 =?gb2312?B?TFVyallIa2JIcEtweU5lbWJpcUNGR2Y5bk03ZmJiSEdPTXAxY1U1RmlyYVk4?=
 =?gb2312?B?K0JZb01OZGR2cHVoOHEvSmVYV1ZrZldlWUtmdDErZEdJUWVoNER1dnRJa25t?=
 =?gb2312?B?TjZBMVB2aVBOSS92cG90dC9lVllTLzNDaUQyU210QloyUFNmdU5hU0VwaFJW?=
 =?gb2312?B?MDZ1MWQzeXRCS1FCNWQ3MjJESXBVWnAzUzg3MGxjOER6WkdVem10dzU0emdS?=
 =?gb2312?B?Sm1Bcm9xVWc3YTVWVzREMzIvM3BjUk9BbncrSHpoOXdPTkttWjB1anNiVnhn?=
 =?gb2312?B?MGlkeWx2VVZtSFF1aXhGN0RKVlBnNXlSSytoamRQODRxcDFRSDdDMEtCSmU4?=
 =?gb2312?B?QnJVamM2NFlvMUROckUyWm9QM2VMZjNlcHpvKzhEaUp4WE9NSzlaTjBGbUEw?=
 =?gb2312?B?Y1RyY3dvSmI4Tkd1VWZIUVdiY2d3azZmcExUWkxnb2RsdTBLZjZHL200cXYx?=
 =?gb2312?B?Tnc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8586.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4e4b71-5fac-4342-cefd-08da6ed4c18c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 07:02:08.5230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGHB7VkxbUu3mK0qR7LoXX4UuZ5aw9aZ7RDvl5Q9CMdl/Mb/KCmKOyTR9AY4GES44JbzGj+i4wrwBs3+gbpr1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8157
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mount03:  Convert to new API
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

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
v2:
  use octal permissions
  remove long switch of test_rwflag
  skip vfat, exfat and ntfs

 testcases/kernel/syscalls/mount/mount03.c | 560 +++++++++-------------
 1 file changed, 231 insertions(+), 329 deletions(-)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 25f99bbfc..e6395c592 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -1,389 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2022
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 
-/*
- * DESCRIPTION
- *	Check for basic mount(2) system call flags.
+/*\
+ * [Description]
+ *
+ * Check for basic mount(2) system call flags.
  *
- *	Verify that mount(2) syscall passes for each flag setting and validate
- *	the flags
- *	1) MS_RDONLY - mount read-only.
- *	2) MS_NODEV - disallow access to device special files.
- *	3) MS_NOEXEC - disallow program execution.
- *	4) MS_SYNCHRONOUS - writes are synced at once.
- *	5) MS_REMOUNT - alter flags of a mounted FS.
- *	6) MS_NOSUID - ignore suid and sgid bits.
- *	7) MS_NOATIME - do not update access times.
+ * Verify that mount(2) syscall passes for each flag setting and validate
+ * the flags
+ *
+ * - MS_RDONLY - mount read-only.
+ * - MS_NODEV - disallow access to device special files.
+ * - MS_NOEXEC - disallow program execution.
+ * - MS_SYNCHRONOUS - writes are synced at once.
+ * - MS_REMOUNT - alter flags of a mounted FS.
+ * - MS_NOSUID - ignore suid and sgid bits.
+ * - MS_NOATIME - do not update access times.
  */
 
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
 
+#define TEMP_FILE	"temp_file"
+#define FILE_MODE	0644
+#define SUID_MODE	0511
+
+#include <stdio.h>
 #include <sys/types.h>
-#include <sys/mount.h>
-#include <sys/stat.h>
 #include <sys/wait.h>
-#include <assert.h>
-#include <errno.h>
-#include <fcntl.h>
+#include <linux/limits.h>
+#include <stdlib.h>
 #include <pwd.h>
-#include <unistd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void cleanup(void);
-static int test_rwflag(int, int);
-
-char *TCID = "mount03";
-int TST_TOTAL = 7;
-
-#define TEMP_FILE	"temp_file"
-#define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
-#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
-			 S_IXGRP|S_IROTH|S_IXOTH)
-#define SUID_MODE	(S_ISUID|S_IRUSR|S_IXUSR|S_IXGRP|S_IXOTH)
-
-static const char mntpoint[] = "mntpoint";
-static const char *device;
-static const char *fs_type;
-static int fildes;
+#include "tst_test.h"
+#include "tst_safe_file_ops.h"
+#include "lapi/mount.h"
+
+#define MNTPOINT        "mntpoint"
+#define TESTBIN	"mount03_setuid_test"
+#define TCASE_ENTRY(_flags, _do_test)    \
+	{                                \
+		.name = "Flag " #_flags, \
+		.flags = _flags,         \
+		.do_test = _do_test      \
+	}
 
+static int otfd;
 static char write_buffer[BUFSIZ];
 static char read_buffer[BUFSIZ];
-static char path_name[PATH_MAX];
 static char file[PATH_MAX];
-
-long rwflags[] = {
-	MS_RDONLY,
-	MS_NODEV,
-	MS_NOEXEC,
-	MS_SYNCHRONOUS,
-	MS_RDONLY,
-	MS_NOSUID,
-	MS_NOATIME,
+static uid_t nobody_uid;
+static gid_t nobody_gid;
+
+static void test_ms_nosuid(void);
+static void test_ms_rdonly(void);
+static void test_ms_nodev(void);
+static void test_noexec(void);
+static void test_ms_synchronous(void);
+static void test_ms_remount(void);
+static void test_ms_noatime(void);
+
+static struct tcase {
+	char *name;
+	unsigned int flags;
+	void (*do_test)(void);
+} tcases[] = {
+	TCASE_ENTRY(MS_RDONLY, test_ms_rdonly),
+	TCASE_ENTRY(MS_NODEV, test_ms_nodev),
+	TCASE_ENTRY(MS_NOEXEC, test_noexec),
+	TCASE_ENTRY(MS_SYNCHRONOUS, test_ms_synchronous),
+	TCASE_ENTRY(MS_RDONLY, test_ms_remount),
+	TCASE_ENTRY(MS_NOSUID, test_ms_nosuid),
+	TCASE_ENTRY(MS_NOATIME, test_ms_noatime),
 };
 
-int main(int argc, char *argv[])
+static void test_ms_rdonly(void)
 {
-	int lc, i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
+	/* Validate MS_RDONLY flag of mount call */
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	snprintf(file, PATH_MAX, "%s/tmp", MNTPOINT);
+	TST_EXP_FAIL2(open(file,  O_CREAT | O_RDWR, 0700),
+		      EROFS, "mount(2) passed with flag MS_RDONLY: "
+		      "open fail with EROFS as expected");
 
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; ++i) {
+	otfd = TST_RET;
+}
 
-			TEST(mount(device, mntpoint, fs_type, rwflags[i],
-				   NULL));
+static void test_ms_nosuid(void)
+{
+	/* Validate MS_NOSUID flag of mount call */
 
-			if (TEST_RETURN != 0) {
-				tst_resm(TFAIL | TTERRNO, "mount(2) failed");
-				continue;
-			}
+	pid_t pid;
+	int status;
 
-			/* Validate the rwflag */
-			if (test_rwflag(i, lc) == 1)
-				tst_resm(TFAIL, "mount(2) failed while"
-					 " validating %ld", rwflags[i]);
-			else
-				tst_resm(TPASS, "mount(2) passed with "
-					 "rwflag = %ld", rwflags[i]);
+	pid = SAFE_FORK();
 
-			TEST(tst_umount(mntpoint));
-			if (TEST_RETURN != 0)
-				tst_brkm(TBROK | TTERRNO, cleanup,
-					 "umount(2) failed for %s", mntpoint);
-		}
+	if (!pid) {
+		SAFE_SETREUID(nobody_uid, nobody_gid);
+		SAFE_EXECLP(TESTBIN, TESTBIN, NULL);
 	}
 
-	cleanup();
-	tst_exit();
+	waitpid(pid, &status, 0);
+	if (WIFEXITED(status)) {
+		/* reset the setup_uid */
+		if (status)
+			tst_res(TPASS, "mount(2) passed with flag MS_NOSUID");
+	} else {
+		tst_res(TFAIL, "mount(2) failed with flag MS_NOSUID");
+	}
 }
 
-/*
- * test_rwflag(int i, int cnt)
- * Validate the mount system call for rwflags.
- */
-int test_rwflag(int i, int cnt)
+static void test_ms_nodev(void)
 {
-	int ret, fd, pid, status;
-	char nobody_uid[] = "nobody";
-	time_t atime;
-	struct passwd *ltpuser;
-	struct stat file_stat;
-	char readbuf[20];
-
-	switch (i) {
-	case 0:
-		/* Validate MS_RDONLY flag of mount call */
-
-		snprintf(file, PATH_MAX, "%stmp", path_name);
-		fd = open(file, O_CREAT | O_RDWR, S_IRWXU);
-		if (fd == -1) {
-			if (errno == EROFS) {
-				return 0;
-			} else {
-				tst_resm(TWARN | TERRNO,
-					 "open didn't fail with EROFS");
-				return 1;
-			}
-		}
-		close(fd);
-		return 1;
-	case 1:
-		/* Validate MS_NODEV flag of mount call */
-
-		snprintf(file, PATH_MAX, "%smynod_%d_%d", path_name, getpid(),
-			 cnt);
-		if (mknod(file, S_IFBLK | 0777, 0) == 0) {
-			fd = open(file, O_RDWR, S_IRWXU);
-			if (fd == -1) {
-				if (errno == EACCES) {
-					return 0;
-				} else {
-					tst_resm(TWARN | TERRNO,
-						 "open didn't fail with EACCES");
-					return 1;
-				}
-			}
-			close(fd);
-		} else {
-			tst_resm(TWARN | TERRNO, "mknod(2) failed to create %s",
-				 file);
-			return 1;
-		}
-		return 1;
-	case 2:
-		/* Validate MS_NOEXEC flag of mount call */
-
-		snprintf(file, PATH_MAX, "%stmp1", path_name);
-		fd = open(file, O_CREAT | O_RDWR, S_IRWXU);
-		if (fd == -1) {
-			tst_resm(TWARN | TERRNO, "opening %s failed", file);
-		} else {
-			close(fd);
-			ret = execlp(file, basename(file), NULL);
-			if ((ret == -1) && (errno == EACCES))
-				return 0;
-		}
-		return 1;
-	case 3:
-		/*
-		 * Validate MS_SYNCHRONOUS flag of mount call.
-		 * Copy some data into data buffer.
-		 */
-
-		strcpy(write_buffer, "abcdefghijklmnopqrstuvwxyz");
-
-		/* Creat a temporary file under above directory */
-		snprintf(file, PATH_MAX, "%s%s", path_name, TEMP_FILE);
-		fildes = open(file, O_RDWR | O_CREAT, FILE_MODE);
-		if (fildes == -1) {
-			tst_resm(TWARN | TERRNO,
-				 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-				 file, FILE_MODE);
-			return 1;
-		}
-
-		/* Write the buffer data into file */
-		if (write(fildes, write_buffer, strlen(write_buffer)) !=
-		    (long)strlen(write_buffer)) {
-			tst_resm(TWARN | TERRNO, "writing to %s failed", file);
-			close(fildes);
-			return 1;
-		}
-
-		/* Set the file ptr to b'nning of file */
-		if (lseek(fildes, 0, SEEK_SET) < 0) {
-			tst_resm(TWARN, "lseek() failed on %s, error="
-				 " %d", file, errno);
-			close(fildes);
-			return 1;
-		}
+	/* Validate MS_NODEV flag of mount call */
+
+	snprintf(file, PATH_MAX, "%s/mynod_%d", MNTPOINT, getpid());
+	if (SAFE_MKNOD(file, S_IFBLK | 0777, 0) == 0) {
+		TST_EXP_FAIL2(open(file, O_RDWR, 0700),
+			      EACCES, "mount(2) passed with flag MS_NODEV: "
+			      "open fail with EACCES as expected");
+		otfd = TST_RET;
+	}
+	SAFE_UNLINK(file);
+}
 
-		/* Read the contents of file */
-		if (read(fildes, read_buffer, sizeof(read_buffer)) > 0) {
-			if (strcmp(read_buffer, write_buffer)) {
-				tst_resm(TWARN, "Data read from %s and written "
-					 "mismatch", file);
-				close(fildes);
-				return 1;
-			} else {
-				close(fildes);
-				return 0;
-			}
-		} else {
-			tst_resm(TWARN | TERRNO, "read() Fails on %s", file);
-			close(fildes);
-			return 1;
+static void test_noexec(void)
+{
+	/* Validate MS_NOEXEC flag of mount call */
+	int ret;
+
+	snprintf(file, PATH_MAX, "%s/tmp1", MNTPOINT);
+	TST_EXP_FD_SILENT(open(file, O_CREAT | O_RDWR, 0700),
+			  "opening %s failed", file);
+	otfd = TST_RET;
+	if (otfd >= 0) {
+		SAFE_CLOSE(otfd);
+		ret = execlp(file, basename(file), NULL);
+		if ((ret == -1) && (errno == EACCES)) {
+			tst_res(TPASS, "mount(2) passed with flag MS_NOEXEC");
+			return;
 		}
+	}
+	tst_brk(TFAIL | TERRNO, "mount(2) failed with flag MS_NOEXEC");
+}
 
-	case 4:
-		/* Validate MS_REMOUNT flag of mount call */
-
-		TEST(mount(device, mntpoint, fs_type, MS_REMOUNT, NULL));
-		if (TEST_RETURN != 0) {
-			tst_resm(TWARN | TTERRNO, "mount(2) failed to remount");
-			return 1;
+static void test_ms_synchronous(void)
+{
+	/*
+	 * Validate MS_SYNCHRONOUS flag of mount call.
+	 * Copy some data into data buffer.
+	 */
+
+	strcpy(write_buffer, "abcdefghijklmnopqrstuvwxyz");
+
+	/* Creat a temporary file under above directory */
+	snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TEMP_FILE);
+	TST_EXP_FD_SILENT(open(file, O_RDWR | O_CREAT, FILE_MODE),
+			  "open(%s, O_RDWR|O_CREAT, %#o) failed",
+			  file, FILE_MODE);
+	otfd = TST_RET;
+
+	/* Write the buffer data into file */
+	SAFE_WRITE(1, otfd, write_buffer, strlen(write_buffer));
+
+	/* Set the file ptr to b'nning of file */
+	SAFE_LSEEK(otfd, 0, SEEK_SET);
+
+	/* Read the contents of file */
+	if (SAFE_READ(0, otfd, read_buffer, sizeof(read_buffer)) > 0) {
+		if (strcmp(read_buffer, write_buffer)) {
+			tst_brk(TFAIL, "Data read from %s and written "
+				"mismatch", file);
 		} else {
-			snprintf(file, PATH_MAX, "%stmp2", path_name);
-			fd = open(file, O_CREAT | O_RDWR, S_IRWXU);
-			if (fd == -1) {
-				tst_resm(TWARN, "open(%s) on readonly "
-					 "filesystem passed", file);
-				return 1;
-			} else {
-				close(fd);
-				return 0;
-			}
-		}
-	case 5:
-		/* Validate MS_NOSUID flag of mount call */
-
-		snprintf(file, PATH_MAX, "%smount03_setuid_test", path_name);
-
-		pid = fork();
-		switch (pid) {
-		case -1:
-			tst_resm(TBROK | TERRNO, "fork failed");
-			return 1;
-		case 0:
-			ltpuser = getpwnam(nobody_uid);
-			if (setreuid(ltpuser->pw_uid, ltpuser->pw_uid) == -1)
-				tst_resm(TWARN | TERRNO,
-					 "seteuid() failed to change euid to %d",
-					 ltpuser->pw_uid);
-
-			execlp(file, basename(file), NULL);
-			exit(1);
-		default:
-			waitpid(pid, &status, 0);
-			if (WIFEXITED(status)) {
-				/* reset the setup_uid */
-				if (status)
-					return 0;
-			}
-			return 1;
-		}
-	case 6:
-		/* Validate MS_NOATIME flag of mount call */
-
-		snprintf(file, PATH_MAX, "%satime", path_name);
-		fd = open(file, O_CREAT | O_RDWR, S_IRWXU);
-		if (fd == -1) {
-			tst_resm(TWARN | TERRNO, "opening %s failed", file);
-			return 1;
-		}
-
-		if (write(fd, "TEST_MS_NOATIME", 15) != 15) {
-			tst_resm(TWARN | TERRNO, "write %s failed", file);
-			close(fd);
-			return 1;
-		}
-
-		if (fstat(fd, &file_stat) == -1) {
-			tst_resm(TWARN | TERRNO, "stat %s failed #1", file);
-			close(fd);
-			return 1;
-		}
-
-		atime = file_stat.st_atime;
-
-		sleep(1);
-
-		if (read(fd, readbuf, sizeof(readbuf)) == -1) {
-			tst_resm(TWARN | TERRNO, "read %s failed", file);
-			close(fd);
-			return 1;
+			SAFE_CLOSE(otfd);
+			tst_res(TPASS, "mount(2) passed with flag MS_SYNCHRONOUS");
+			return;
 		}
+	} else {
+		tst_brk(TFAIL | TERRNO, "read() Fails on %s", file);
+	}
+}
 
-		if (fstat(fd, &file_stat) == -1) {
-			tst_resm(TWARN | TERRNO, "stat %s failed #2", file);
-			close(fd);
-			return 1;
-		}
-		close(fd);
-
-		if (file_stat.st_atime != atime) {
-			tst_resm(TWARN, "access time is updated");
-			return 1;
-		}
-		return 0;
+static void test_ms_remount(void)
+{
+	/* Validate MS_REMOUNT flag of mount call */
+
+	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, MS_REMOUNT, NULL));
+	if (TST_RET != 0) {
+		tst_brk(TFAIL | TTERRNO, "mount(2) failed to remount");
+	} else {
+		snprintf(file, PATH_MAX, "%s/tmp2", MNTPOINT);
+		TEST(open(file, O_CREAT | O_RDWR, 0700));
+		otfd = TST_RET;
+		if (otfd == -1) {
+			tst_res(TFAIL, "open(%s) on readonly "
+				"filesystem passed", file);
+		} else
+			tst_res(TPASS, "mount(2) passed with flag MS_REMOUNT");
 	}
-	return 0;
 }
 
-static void setup(void)
+static void test_ms_noatime(void)
 {
-	char path[PATH_MAX];
+	/* Validate MS_NOATIME flag of mount call */
+	time_t atime;
 	struct stat file_stat;
+	char readbuf[20];
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	tst_tmpdir();
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	snprintf(file, PATH_MAX, "%s/atime", MNTPOINT);
+	TST_EXP_FD_SILENT(open(file, O_CREAT | O_RDWR, 0700));
+	otfd = TST_RET;
 
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
+	SAFE_WRITE(1, otfd, "TEST_MS_NOATIME", 15);
 
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
+	SAFE_FSTAT(otfd, &file_stat);
 
-	SAFE_MKDIR(cleanup, mntpoint, DIR_MODE);
+	atime = file_stat.st_atime;
 
-	if (getcwd(path_name, sizeof(path_name)) == NULL)
-		tst_brkm(TBROK, cleanup, "getcwd failed");
+	sleep(1);
 
-	if (chmod(path_name, DIR_MODE) != 0)
-		tst_brkm(TBROK, cleanup, "chmod(%s, %#o) failed",
-			 path_name, DIR_MODE);
+	SAFE_READ(0, otfd, readbuf, sizeof(readbuf));
 
-	strncpy(path, path_name, PATH_MAX);
-	snprintf(path_name, PATH_MAX, "%s/%s/", path, mntpoint);
+	SAFE_FSTAT(otfd, &file_stat);
 
-	SAFE_MOUNT(cleanup, device, mntpoint, fs_type, 0, NULL);
-	TST_RESOURCE_COPY(cleanup, "mount03_setuid_test", path_name);
+	if (file_stat.st_atime != atime) {
+		tst_res(TFAIL, "access time is updated");
+		return;
+	}
+	tst_res(TPASS, "mount(2) passed with flag MS_NOATIME");
+}
 
-	snprintf(file, PATH_MAX, "%smount03_setuid_test", path_name);
-	SAFE_STAT(cleanup, file, &file_stat);
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
 
-	if (file_stat.st_mode != SUID_MODE &&
-	    chmod(file, SUID_MODE) < 0)
-		tst_brkm(TBROK, cleanup,
-			 "setuid for setuid_test failed");
-	SAFE_UMOUNT(cleanup, mntpoint);
+	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type,
+		   tc->flags, NULL));
+	if (tc->do_test)
+		tc->do_test();
 
-	TEST_PAUSE;
+	if (otfd >= 0)
+		SAFE_CLOSE(otfd);
+	if (tst_is_mounted(MNTPOINT))
+		SAFE_UMOUNT(MNTPOINT);
 }
 
 static void cleanup(void)
 {
-	if (device)
-		tst_release_device(device);
+	if (otfd > -1)
+		SAFE_CLOSE(otfd);
+}
+
+static void setup(void)
+{
+	struct stat file_stat = {0};
+	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
 
-	tst_rmdir();
+	nobody_uid = ltpuser->pw_uid;
+	nobody_gid = ltpuser->pw_gid;
+	snprintf(file, PATH_MAX, "%s/mount03_setuid_test", MNTPOINT);
+	SAFE_STAT(MNTPOINT, &file_stat);
+	if (file_stat.st_mode != SUID_MODE &&
+	    chmod(MNTPOINT, SUID_MODE) < 0)
+		tst_brk(TBROK, "setuid for setuid_test failed");
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.format_device = 1,
+	.resource_files = (const char *const[]) {
+		"mount03_setuid_test",
+		NULL,
+	},
+	.forks_child = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []){
+		"exfat",
+		"vfat",
+		"ntfs",
+		NULL
+	},
+};
-- 
2.31.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
