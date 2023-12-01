Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BF3C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 00:59:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4D663CF640
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 01:59:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE5523CF63D
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 01:59:32 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E1348200ACF
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 01:59:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6xiHbKPbIsUCSu5NdgZraDk/vq8lGwxZGW4TPFIgXqOfToDcVLeqvxNZTkenvRePqK9xruWUMAxLqoArbkyNK1q46PpTgSHkHauQhyKVnsh6jcwHwrTAaM0A6SQRF076VOeZYAbZYTiwlBnOewhyxhvgdk9DFgxaJv7/KvuVxQ0c/lOwrVmSdcAKzpiCf6qPvuQ7gsF7KA+52b0r5cC0KTfnDrFItg6amOiUiWxxsT6UHKdR0mAWHE+mzsG5/03hx5pPMVx+xhjjeEraDsT+/ZT2nU0CasQWTXdUvDjyjYyE36uN8lJGRT/rwSEJTwl343iVmnnqp8akxyvZ3lnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5opbQHbShAr2QXXsaUz0/pc69thCLmWFJJsp1saUZcE=;
 b=PxFPMvIwK7XR+jAbNVNoTiOAIC/mqt2wfWQ0T7KOVPdwYgiOkloaLPOZLvMySgMpGF1T+7DUv8VUarn9cHgW/8rEua19j3IIBjpqgiOp4tGEostHkNw9EsWtrBtMWdDxoVlIusSdJj8PM2lVuJHyTiJ+Zf9TPP/USNjSl1+ujmyeKZtOusU7VEZNZFD2ecbnUC5Ld4oYBI3bfzPlO6iChkXd3LPKDFAz+Ue2b2SBDFjZ81xO4yOo85d6SzyxsMYzJJTXl8tYx8DJ6BK5jfgXRxoPgbwK+O/clnYtsN8q1Imw6vucG7lur/YZVuv7vsbuyjqOov257VNoP98WzsGeBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5opbQHbShAr2QXXsaUz0/pc69thCLmWFJJsp1saUZcE=;
 b=hFKaiGHoxo2qb9hm+amMKpUBiTJywNXgj/B8xfsKXfBetGU955wzd9IRRUDqEHB5zO6jdoNerzqC6kyjNKZJk+qiErgU8qOVkKeN6EL5GXzM/7ip39YCJIpfF6H06BGs308eS5v/FCufDdzlRjp70SqA2wXA2wUkANjXQs61saO/SRkZCFZwdo/s2KTID70d8v96WJ2huinEXcpV1eBx9TNBnkoo9XA/DOt/IvVRCL9YP5nqF3GAyFajJ1Yyrjz3MsXSfKNqQvYl6nhKI3oiguAUl9y7vmhfVyysA0QM3bGcs1j+Iuh9MlGtApLDhuBucxNlYwMBDvKUd4G+nBz/ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AS8PR04MB8183.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.15; Fri, 1 Dec
 2023 00:59:30 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 00:59:30 +0000
To: ltp@lists.linux.it
Date: Thu, 30 Nov 2023 19:59:02 -0500
Message-Id: <20231201005902.15630-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231201005902.15630-1-wegao@suse.com>
References: <20230925112245.30701-1-wegao@suse.com>
 <20231201005902.15630-1-wegao@suse.com>
X-ClientProxiedBy: VI1PR02CA0053.eurprd02.prod.outlook.com
 (2603:10a6:802:14::24) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AS8PR04MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c9b984-b132-4908-5e4e-08dbf208c61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckxVBn6EDfh+cfiVAu90zszdHt4W9uz4f9f30xNHt5A7xhNOft1uwuCU86CyHFBak7RsFHUCG9CWUE7WtlJVd7mNE/EPAbslJKYK+x0R/qXh5rtG3G4f87I8tOWpAjAGyZhZwDeFKqaF1zsVLre1nL4nSXdoOE1cqHT7BzsimjGkdXnrgmI2mD6MqTyAYArp2Miz8JgC+jZr3vtGYgik5lWuHY6nEheHiz/3sjOnw7DoP8lw5cfYsWCye/VoGcf7M56r8J8Oa8Dt1lPDu5fOIlFQD3mzgsuED+wjLSR6lkXGqeXaGqmrNt20Y8o+std9Au48w7JyaWoW8v2zSQkar4IHxAvvLxMOWPy7gpoO0xj3i4KXu9gMXM8CD5nzibkOHQ/JZ6GKlYiEa8Yh9CcmPkC0HtA1p8CRvSj0j6FwMiUCJqmlrzrlIOIX4ix8t7DKXl9LarUg6szcphcruhOhXICzqtoX99xmaGjlqYS+oP17K5pyki0Rp9hv760MsWTgDwfX0i2uszsJe/uOPnGCOgLgNMlewR4X+/cVBFDD8c3oTq5UleJOve6ctl1mO9KN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(26005)(2616005)(107886003)(1076003)(86362001)(36756003)(38100700002)(30864003)(5660300002)(6512007)(6506007)(6666004)(508600001)(4326008)(66946007)(6916009)(66476007)(66556008)(8676002)(8936002)(316002)(2906002)(41300700001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qXc4lcsXTks1lVldqxM4FRLA05vp2PsaioT/bbehjyywWlWlMZ4oodv+vdbI?=
 =?us-ascii?Q?lNbdTPJLV9qHwh7Ob/jNGuHfYA/XXWodpaI7WdLmo+uAu8TvvEY0u50ZCjAu?=
 =?us-ascii?Q?eaaD/ss19wQfygD475z0IgAayYHVgVthDhh228DyZa1mMnefWa0/5zwquUKx?=
 =?us-ascii?Q?b/TWq16cy7VNbxAnJ/CzsI2c1agr6Z+oQIOHDgtVIlYumkORyy8i7pbiuOem?=
 =?us-ascii?Q?5tIexg9fkeRPDdn+HCc/25aKwlxVVODxUbq/FZ9LPcGWmLwmwub537A2A+IN?=
 =?us-ascii?Q?P51dqpw6LVCF9EmpaBXTgxHffXHGPGKJbq6/i31wxn6vrs7NImlu5X/ZyVd3?=
 =?us-ascii?Q?v4o/Arz+rRtrqPcgNT+nPXe0d7+x89mOzl7LVeA4nCqHqF5+fZoaM01srXv+?=
 =?us-ascii?Q?mnugWgkfeexMn3JDIu/uhbZDFUwFYuVuNPxOFAh8EySmP4KeOkGYGz48ioue?=
 =?us-ascii?Q?OTHWDErAAzWzxGOgPf2R+GUSe2Bi0ZxfW9Qvn1JTKHhZESy2Jjsl2Vzaj4JN?=
 =?us-ascii?Q?xsmhMqy13X5t6QM2XtS/oHSV+LWcp+AOTBxEeuNYgy87+SqIaP5/Xq9V8di5?=
 =?us-ascii?Q?Uh0eDeOnXH3WQzmCbnyD9bPe7yy1BiHRWcvfPZadSgT4jRi0npYsB0Lx1Y32?=
 =?us-ascii?Q?P46+UolETdoWmLM719O7ZaAnUYpQMNfKTMl8vvoOovcTKybeFMcjW/KH3ZrU?=
 =?us-ascii?Q?nzkvK2HuTkVEQ2XiQ7653hV0rjLJuh+ON4UoAw+vAAdYSVVQmKCJMtxMdkqN?=
 =?us-ascii?Q?R16QBy9vRZD+EVRTO2nxbHsLJnroeL+aVfezbwOeCG0GbnWYMEH684vWvcph?=
 =?us-ascii?Q?SxbInSOw1z8ibTOXMx4LcV0ueYnEsexoCU15rgwtuUHqeR5ZL8Trwt6jgFZd?=
 =?us-ascii?Q?aLFRr9Jr0QENzfrjz09mUDr+uiS+6Fp5XRbqe3teeNMOSdAsRhSuCs89Mb+w?=
 =?us-ascii?Q?aYTm8K/bSw3j1gxwkyMNcEzQLbnM6KR50ddDfaKrsU16JonPkmB3DOMxossm?=
 =?us-ascii?Q?TePo+EA0hYqwPOrHG2qJsJGCCC+cOnEu88fvCwIyRGFEnYYNLFmSQhTgC+LW?=
 =?us-ascii?Q?S6vZbVqTOC7dD4P83sjpGAK4jPsyyjPbIM3qIm7fx6YamSDuY7LkCKQnQy0X?=
 =?us-ascii?Q?BbrcpJCgwwJIBMbmAOBbS4SK7BydMKLtyFqAjzXkJfChTszVg4lEK6dte6nV?=
 =?us-ascii?Q?VXgfkxw40x71YH+huVI/z7dzBwZABtzF+hH0XwbVXi/VBp9PVSO4am3cJX5e?=
 =?us-ascii?Q?edjmYGWgpoPLWmosTsIDSXuTqj+D11gR1kv+EWv9uc5r91G6irE0V/9VC+Gq?=
 =?us-ascii?Q?TQr/V9zfgJ287b5QvTNrhDnLnJdgaLoAoUXc9zHCsSTP7urtG9ecXYVTynRl?=
 =?us-ascii?Q?GzwiVkXh6QK6wiT6rOvAR1dLYHatQSW/VYlYpt+zcHtN4GhLE76MfTpOvJqJ?=
 =?us-ascii?Q?QbCWufhk9eJxOXpZ9iehVaB3F+7OaGGQaIygYkmgcnbmnDQWTVFyXPnkZTz3?=
 =?us-ascii?Q?znT9fAGc7Ix5+fUmQbFmgN1Xh1BR+WOYEYe3YkVTQK0s0FK4+jElNmuBkW9A?=
 =?us-ascii?Q?8F9cIXXWllpqVWqhMck=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c9b984-b132-4908-5e4e-08dbf208c61a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:59:30.3793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bCSOaLUH0lWNzjA+JAKFxLbJMfZyFrZx0Q/f8wBNi3tTR88SoKfruNJslsII+ZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8183
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] ptrace06: Refactor the test using new LTP API
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
 testcases/kernel/syscalls/ptrace/ptrace06.c   | 326 ++++++++++--------
 .../kernel/syscalls/ptrace/ptrace06_child.c   |  16 +
 2 files changed, 202 insertions(+), 140 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace06_child.c

diff --git a/testcases/kernel/syscalls/ptrace/ptrace06.c b/testcases/kernel/syscalls/ptrace/ptrace06.c
index a1db3bab8..225d9d466 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace06.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace06.c
@@ -1,29 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) 2008 Analog Devices Inc.
+ * Copyright (c) Linux Test Project, 2009-2022
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
  * check out-of-bound/unaligned addresses given to
+ *
  *  - {PEEK,POKE}{DATA,TEXT,USER}
  *  - {GET,SET}{,FG}REGS
  *  - {GET,SET}SIGINFO
- *
- * Copyright (c) 2008 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later
  */
 
-#define _GNU_SOURCE
-
-#include <errno.h>
-#include <stdbool.h>
-#include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
 #include <sys/ptrace.h>
-
-#include "test.h"
-#include "spawn_ptrace_child.h"
+#include "tst_test.h"
 
 /* this should be sizeof(struct user), but that info is only found
  * in the kernel asm/user.h which is not exported to userspace.
  */
+
 #if defined(__i386__)
 #define SIZEOF_USER 284
 #elif defined(__x86_64__)
@@ -32,168 +31,215 @@
 #define SIZEOF_USER 0x1000	/* just pick a big number */
 #endif
 
-char *TCID = "ptrace06";
-
-struct test_case_t {
+static struct test_case_t {
 	int request;
 	long addr;
 	long data;
 } test_cases[] = {
-	{
-	PTRACE_PEEKDATA,.addr = 0}, {
-	PTRACE_PEEKDATA,.addr = 1}, {
-	PTRACE_PEEKDATA,.addr = 2}, {
-	PTRACE_PEEKDATA,.addr = 3}, {
-	PTRACE_PEEKDATA,.addr = -1}, {
-	PTRACE_PEEKDATA,.addr = -2}, {
-	PTRACE_PEEKDATA,.addr = -3}, {
-	PTRACE_PEEKDATA,.addr = -4}, {
-	PTRACE_PEEKTEXT,.addr = 0}, {
-	PTRACE_PEEKTEXT,.addr = 1}, {
-	PTRACE_PEEKTEXT,.addr = 2}, {
-	PTRACE_PEEKTEXT,.addr = 3}, {
-	PTRACE_PEEKTEXT,.addr = -1}, {
-	PTRACE_PEEKTEXT,.addr = -2}, {
-	PTRACE_PEEKTEXT,.addr = -3}, {
-	PTRACE_PEEKTEXT,.addr = -4}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 1}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 2}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 3}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 4}, {
-	PTRACE_PEEKUSER,.addr = -1}, {
-	PTRACE_PEEKUSER,.addr = -2}, {
-	PTRACE_PEEKUSER,.addr = -3}, {
-	PTRACE_PEEKUSER,.addr = -4}, {
-	PTRACE_POKEDATA,.addr = 0}, {
-	PTRACE_POKEDATA,.addr = 1}, {
-	PTRACE_POKEDATA,.addr = 2}, {
-	PTRACE_POKEDATA,.addr = 3}, {
-	PTRACE_POKEDATA,.addr = -1}, {
-	PTRACE_POKEDATA,.addr = -2}, {
-	PTRACE_POKEDATA,.addr = -3}, {
-	PTRACE_POKEDATA,.addr = -4}, {
-	PTRACE_POKETEXT,.addr = 0}, {
-	PTRACE_POKETEXT,.addr = 1}, {
-	PTRACE_POKETEXT,.addr = 2}, {
-	PTRACE_POKETEXT,.addr = 3}, {
-	PTRACE_POKETEXT,.addr = -1}, {
-	PTRACE_POKETEXT,.addr = -2}, {
-	PTRACE_POKETEXT,.addr = -3}, {
-	PTRACE_POKETEXT,.addr = -4}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 1}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 2}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 3}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 4}, {
-	PTRACE_POKEUSER,.addr = -1}, {
-	PTRACE_POKEUSER,.addr = -2}, {
-	PTRACE_POKEUSER,.addr = -3}, {
-	PTRACE_POKEUSER,.addr = -4},
+	{PTRACE_PEEKDATA, .addr = 0},
+	{PTRACE_PEEKDATA, .addr = 1},
+	{PTRACE_PEEKDATA, .addr = 2},
+	{PTRACE_PEEKDATA, .addr = 3},
+	{PTRACE_PEEKDATA, .addr = -1},
+	{PTRACE_PEEKDATA, .addr = -2},
+	{PTRACE_PEEKDATA, .addr = -3},
+	{PTRACE_PEEKDATA, .addr = -4},
+	{PTRACE_PEEKTEXT, .addr = 0},
+	{PTRACE_PEEKTEXT, .addr = 1},
+	{PTRACE_PEEKTEXT, .addr = 2},
+	{PTRACE_PEEKTEXT, .addr = 3},
+	{PTRACE_PEEKTEXT, .addr = -1},
+	{PTRACE_PEEKTEXT, .addr = -2},
+	{PTRACE_PEEKTEXT, .addr = -3},
+	{PTRACE_PEEKTEXT, .addr = -4},
+	{PTRACE_PEEKUSER, .addr = SIZEOF_USER + 1},
+	{PTRACE_PEEKUSER, .addr = SIZEOF_USER + 2},
+	{PTRACE_PEEKUSER, .addr = SIZEOF_USER + 3},
+	{PTRACE_PEEKUSER, .addr = SIZEOF_USER + 4},
+	{PTRACE_PEEKUSER, .addr = -1},
+	{PTRACE_PEEKUSER, .addr = -2},
+	{PTRACE_PEEKUSER, .addr = -3},
+	{PTRACE_PEEKUSER, .addr = -4},
+	{PTRACE_POKEDATA, .addr = 0},
+	{PTRACE_POKEDATA, .addr = 1},
+	{PTRACE_POKEDATA, .addr = 2},
+	{PTRACE_POKEDATA, .addr = 3},
+	{PTRACE_POKEDATA, .addr = -1},
+	{PTRACE_POKEDATA, .addr = -2},
+	{PTRACE_POKEDATA, .addr = -3},
+	{PTRACE_POKEDATA, .addr = -4},
+	{PTRACE_POKETEXT, .addr = 0},
+	{PTRACE_POKETEXT, .addr = 1},
+	{PTRACE_POKETEXT, .addr = 2},
+	{PTRACE_POKETEXT, .addr = 3},
+	{PTRACE_POKETEXT, .addr = -1},
+	{PTRACE_POKETEXT, .addr = -2},
+	{PTRACE_POKETEXT, .addr = -3},
+	{PTRACE_POKETEXT, .addr = -4},
+	{PTRACE_POKEUSER, .addr = SIZEOF_USER + 1},
+	{PTRACE_POKEUSER, .addr = SIZEOF_USER + 2},
+	{PTRACE_POKEUSER, .addr = SIZEOF_USER + 3},
+	{PTRACE_POKEUSER, .addr = SIZEOF_USER + 4},
+	{PTRACE_POKEUSER, .addr = -1},
+	{PTRACE_POKEUSER, .addr = -2},
+	{PTRACE_POKEUSER, .addr = -3},
+	{PTRACE_POKEUSER, .addr = -4},
 #ifdef PTRACE_GETREGS
-	{
-	PTRACE_GETREGS,.data = 0}, {
-	PTRACE_GETREGS,.data = 1}, {
-	PTRACE_GETREGS,.data = 2}, {
-	PTRACE_GETREGS,.data = 3}, {
-	PTRACE_GETREGS,.data = -1}, {
-	PTRACE_GETREGS,.data = -2}, {
-	PTRACE_GETREGS,.data = -3}, {
-	PTRACE_GETREGS,.data = -4},
+	{PTRACE_GETREGS, .data = 0},
+	{PTRACE_GETREGS, .data = 1},
+	{PTRACE_GETREGS, .data = 2},
+	{PTRACE_GETREGS, .data = 3},
+	{PTRACE_GETREGS, .data = -1},
+	{PTRACE_GETREGS, .data = -2},
+	{PTRACE_GETREGS, .data = -3},
+	{PTRACE_GETREGS, .data = -4},
 #endif
 #ifdef PTRACE_GETFGREGS
-	{
-	PTRACE_GETFGREGS,.data = 0}, {
-	PTRACE_GETFGREGS,.data = 1}, {
-	PTRACE_GETFGREGS,.data = 2}, {
-	PTRACE_GETFGREGS,.data = 3}, {
-	PTRACE_GETFGREGS,.data = -1}, {
-	PTRACE_GETFGREGS,.data = -2}, {
-	PTRACE_GETFGREGS,.data = -3}, {
-	PTRACE_GETFGREGS,.data = -4},
+	{PTRACE_GETFGREGS, .data = 0},
+	{PTRACE_GETFGREGS, .data = 1},
+	{PTRACE_GETFGREGS, .data = 2},
+	{PTRACE_GETFGREGS, .data = 3},
+	{PTRACE_GETFGREGS, .data = -1},
+	{PTRACE_GETFGREGS, .data = -2},
+	{PTRACE_GETFGREGS, .data = -3},
+	{PTRACE_GETFGREGS, .data = -4},
 #endif
 #ifdef PTRACE_SETREGS
-	{
-	PTRACE_SETREGS,.data = 0}, {
-	PTRACE_SETREGS,.data = 1}, {
-	PTRACE_SETREGS,.data = 2}, {
-	PTRACE_SETREGS,.data = 3}, {
-	PTRACE_SETREGS,.data = -1}, {
-	PTRACE_SETREGS,.data = -2}, {
-	PTRACE_SETREGS,.data = -3}, {
-	PTRACE_SETREGS,.data = -4},
+	{PTRACE_SETREGS, .data = 0},
+	{PTRACE_SETREGS, .data = 1},
+	{PTRACE_SETREGS, .data = 2},
+	{PTRACE_SETREGS, .data = 3},
+	{PTRACE_SETREGS, .data = -1},
+	{PTRACE_SETREGS, .data = -2},
+	{PTRACE_SETREGS, .data = -3},
+	{PTRACE_SETREGS, .data = -4},
 #endif
 #ifdef PTRACE_SETFGREGS
-	{
-	PTRACE_SETFGREGS,.data = 0}, {
-	PTRACE_SETFGREGS,.data = 1}, {
-	PTRACE_SETFGREGS,.data = 2}, {
-	PTRACE_SETFGREGS,.data = 3}, {
-	PTRACE_SETFGREGS,.data = -1}, {
-	PTRACE_SETFGREGS,.data = -2}, {
-	PTRACE_SETFGREGS,.data = -3}, {
-	PTRACE_SETFGREGS,.data = -4},
+	{PTRACE_SETFGREGS, .data = 0},
+	{PTRACE_SETFGREGS, .data = 1},
+	{PTRACE_SETFGREGS, .data = 2},
+	{PTRACE_SETFGREGS, .data = 3},
+	{PTRACE_SETFGREGS, .data = -1},
+	{PTRACE_SETFGREGS, .data = -2},
+	{PTRACE_SETFGREGS, .data = -3},
+	{PTRACE_SETFGREGS, .data = -4},
 #endif
 #if HAVE_DECL_PTRACE_GETSIGINFO
-	{
-	PTRACE_GETSIGINFO,.data = 0}, {
-	PTRACE_GETSIGINFO,.data = 1}, {
-	PTRACE_GETSIGINFO,.data = 2}, {
-	PTRACE_GETSIGINFO,.data = 3}, {
-	PTRACE_GETSIGINFO,.data = -1}, {
-	PTRACE_GETSIGINFO,.data = -2}, {
-	PTRACE_GETSIGINFO,.data = -3}, {
-	PTRACE_GETSIGINFO,.data = -4},
+	{PTRACE_GETSIGINFO, .data = 0},
+	{PTRACE_GETSIGINFO, .data = 1},
+	{PTRACE_GETSIGINFO, .data = 2},
+	{PTRACE_GETSIGINFO, .data = 3},
+	{PTRACE_GETSIGINFO, .data = -1},
+	{PTRACE_GETSIGINFO, .data = -2},
+	{PTRACE_GETSIGINFO, .data = -3},
+	{PTRACE_GETSIGINFO, .data = -4},
 #endif
 #if HAVE_DECL_PTRACE_SETSIGINFO
-	{
-	PTRACE_SETSIGINFO,.data = 0}, {
-	PTRACE_SETSIGINFO,.data = 1}, {
-	PTRACE_SETSIGINFO,.data = 2}, {
-	PTRACE_SETSIGINFO,.data = 3}, {
-	PTRACE_SETSIGINFO,.data = -1}, {
-	PTRACE_SETSIGINFO,.data = -2}, {
-	PTRACE_SETSIGINFO,.data = -3}, {
-	PTRACE_SETSIGINFO,.data = -4},
+	{PTRACE_SETSIGINFO, .data = 0},
+	{PTRACE_SETSIGINFO, .data = 1},
+	{PTRACE_SETSIGINFO, .data = 2},
+	{PTRACE_SETSIGINFO, .data = 3},
+	{PTRACE_SETSIGINFO, .data = -1},
+	{PTRACE_SETSIGINFO, .data = -2},
+	{PTRACE_SETSIGINFO, .data = -3},
+	{PTRACE_SETSIGINFO, .data = -4},
 #endif
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
+#define SPT(x) [PTRACE_##x] = #x,
+static char *strings[] = {
+	SPT(TRACEME)
+	SPT(PEEKTEXT)
+	SPT(PEEKDATA)
+	SPT(PEEKUSER)
+	SPT(POKETEXT)
+	SPT(POKEDATA)
+	SPT(POKEUSER)
+#ifdef PTRACE_GETREGS
+	SPT(GETREGS)
+#endif
+#ifdef PTRACE_SETREGS
+	SPT(SETREGS)
+#endif
+#ifdef PTRACE_GETSIGINFO
+	SPT(GETSIGINFO)
+#endif
+#ifdef PTRACE_SETSIGINFO
+	SPT(SETSIGINFO)
+#endif
+#ifdef PTRACE_GETFGREGS
+	SPT(GETFGREGS)
+#endif
+#ifdef PTRACE_SETFGREGS
+	SPT(SETFGREGS)
+#endif
+	SPT(KILL)
+	SPT(SINGLESTEP)
+};
+
+static inline char *strptrace(int request)
+{
+	return strings[request];
+}
+
+static void child(void)
+{
 
-int main(int argc, char *argv[])
+	char path[512];
+
+	SAFE_PTRACE(PTRACE_TRACEME, 0, NULL, NULL);
+
+	if (tst_get_path("ptrace06_child", path, sizeof(path)))
+		tst_brk(TCONF, "Couldn't find ptrace06_child in $PATH");
+
+	TEST(execl(path, "ptrace06_child", "", NULL));
+	tst_brk(TFAIL | TTERRNO,
+			"Failed to execute execl01_child");
+	exit(0);
+}
+
+static void run(void)
 {
 	size_t i;
-	long ret;
-	int saved_errno;
+	int pid;
+	int status;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	pid = SAFE_FORK();
 
-	make_a_baby(argc, argv);
+	if (!pid)
+		child();
+
+	SAFE_WAIT(&status);
+
+	if (!WIFSTOPPED(status))
+		tst_brk(TBROK, "child %d was not stopped", pid);
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
 		struct test_case_t *tc = &test_cases[i];
 
-		errno = 0;
-		ret =
-		    ptrace(tc->request, pid, (void *)tc->addr,
-			   (void *)tc->data);
-		saved_errno = errno;
-		if (ret != -1)
-			tst_resm(TFAIL,
+		TEST(ptrace(tc->request, pid, (void *)tc->addr,
+					(void *)tc->data));
+		if (TST_RET != -1)
+			tst_brk(TFAIL | TERRNO,
 				 "ptrace(%s, ..., %li, %li) returned %li instead of -1",
 				 strptrace(tc->request), tc->addr, tc->data,
-				 ret);
-		else if (saved_errno != EIO && saved_errno != EFAULT)
-			tst_resm(TFAIL,
+				 TST_RET);
+		else if (TST_ERR != EIO && TST_ERR != EFAULT)
+			tst_brk(TFAIL | TERRNO,
 				 "ptrace(%s, ..., %li, %li) expected errno EIO or EFAULT; actual: %i (%s)",
 				 strptrace(tc->request), tc->addr, tc->data,
-				 saved_errno, strerror(saved_errno));
+				 TST_ERR, strerror(TST_ERR));
 		else
-			tst_resm(TPASS,
+			tst_res(TPASS,
 				 "ptrace(%s, ..., %li, %li) failed as expected",
 				 strptrace(tc->request), tc->addr, tc->data);
 	}
 
-	/* hopefully this worked */
-	ptrace(PTRACE_KILL, pid, NULL, NULL);
+	SAFE_PTRACE(PTRACE_CONT, pid, NULL, NULL);
 
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/ptrace/ptrace06_child.c b/testcases/kernel/syscalls/ptrace/ptrace06_child.c
new file mode 100644
index 000000000..350b0e8df
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace06_child.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Linux Test Project
+ * Copyright (C) 2015 Cyril Hrubis chrubis@suse.cz
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+int main(int argc, char *argv[])
+{
+
+	tst_res(TPASS, "%s executed", argv[0]);
+
+	return 0;
+}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
