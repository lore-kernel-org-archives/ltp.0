Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E71C43334
	for <ltp@archiver.kernel.org>; Fri, 15 Jul 2022 06:25:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B94983CAA89
	for <ltp@archiver.kernel.org>; Fri, 15 Jul 2022 08:25:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D76703CA9F7
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 08:25:28 +0200 (CEST)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 051BB10005BD
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 08:25:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657866327; x=1689402327; h=from:to:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=U4bliPRG00wDAIlOyhGA7ebR0FDIwabC4fvXw1cIgUA=;
 b=J/WTdxKajDC8VaDuODCrwimhqZXINxj+IoKG/C2SKXIXgAqZLSYmDWoy
 HSke0SPP6L1H8s6wszgZmE/M6O/G14ab/PMv1X1+0cx8kADlkBl6r552+
 Aqu0mtE62gTe+uW/Xmglo8oKyek+jQhBjj57XqDV4S3nzuZVG8+Nb9D3T
 AWEWgt5ERkzb6UVtkkFneUih9DjtyWAK95OLSHjJvk3rLYXrYbhW3sWPH
 ExALOSjTOMFP4bqw5BXaQjs790q4EwfOzuFGzvBX7VYBv0PCuqKeBkIrp
 jRj/IIWJE4SRz98pOT1wfq2SzxTZE2wbwYY6zSUCGVcG6W+6wqSUdNF+e g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="60483798"
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800"; d="scan'208";a="60483798"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2022 15:25:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtZANL6kDQfjWlwvosF3R9evr4TlZDwRMHKvWDOv+i0cF2/J/mKv3vaoZFP0H3EhMC1z5cLenXa/4TksvuvKZBFlCRunG+tj51R9ro91oISF7k/BRBpL99In3zlix8MJy0MNIXnwhOgD1kbclf68VUqBj8TF5naXS0HGVgg0dLyZtzRnrUgBAHhFTa1ZUtYNcUjCRBiyHLWR2BljZgIu3azpeksYcgTyX9VwZi+2hylvQ1PDQD8al9XBa2WuVoxvqTooISYniW8crUAMsg/MqlhOI+TJHNhrQACPCUvB1l9OGtSYN4qSYXNI/Ow6s4DHZNXI39LNRTektNpZIwt1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4bliPRG00wDAIlOyhGA7ebR0FDIwabC4fvXw1cIgUA=;
 b=MQbZQXBsCeA7Qpe9uxfbXIRo4736isFdcQIQHRrqh9Y23+0xux/olzGhf5aEJvJia3xrsclSI7f1Q80yCqtTNI0U/txXaY0rScpec+gNwRwLzzcqOhCMKmE+brB3A6gpiOQiYbbhYwhTpcKZ0IB/+v9KQ5U7fZy+kHd0N6RynNKcksgDtIP87s1MYAXu0EFuqUbAyARgOBOg8Jg/mTepnmktrOt798bylJ7idKVBdCPK2YzSQ8X3obGl4YOBTutDIRUoJPkBUDUrOs9yW2SATsSUF4V9mnbIpbGfZN95V6RybyvRrkR273nI6O65qH9VLl/uX6YPpnndlvJrj06tiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4bliPRG00wDAIlOyhGA7ebR0FDIwabC4fvXw1cIgUA=;
 b=Du8hh2EiuQrWT2ILzIhBrRc34cQd0fLq0F4Gu2Wu0ynPI5zCb0vargIiniNVWX36WNeeoPhl8LQBV0K07XBxlHXk3bG5N2lwLM3WL5YY8bFWQplFoSa1mMch4xcKQMCUznpmTdotZzQ7CMU8h3ABTbhMzTfRdEtwwQZU9csqpyU=
Received: from OS3PR01MB8586.jpnprd01.prod.outlook.com (2603:1096:604:19d::6)
 by TYAPR01MB3533.jpnprd01.prod.outlook.com (2603:1096:404:be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 06:25:21 +0000
Received: from OS3PR01MB8586.jpnprd01.prod.outlook.com
 ([fe80::576:dca1:ffc6:de00]) by OS3PR01MB8586.jpnprd01.prod.outlook.com
 ([fe80::576:dca1:ffc6:de00%4]) with mapi id 15.20.5438.015; Fri, 15 Jul 2022
 06:25:21 +0000
From: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH] mount03: Convert to new API
Thread-Index: AQHYmBOoqm5IaIDdEEayRx+hWUOXYw==
Date: Fri, 15 Jul 2022 06:25:21 +0000
Message-ID: <20220715062519.2480-1-chenhx.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59361c57-f52a-4382-efb9-08da662acb41
x-ms-traffictypediagnostic: TYAPR01MB3533:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJOx0h4SgRbOOXEQ4o+/S5iGxKsx9eHv+NArCgIGZjVJKNe/aVl0chb8r9kELzBUT9uJwx+AtZvTk2gveA2QbCpHSkCOISCR5XGFC3iTS2vVrY3lXdjiGM76wJTjSqy2LXwAXbTlf/OxfJGNUuhRtNorVfhjlZ5TK7e81V3lZP37eE7wRV48PFIQv4BrKZXPXTnZPVI1Fccqlyw/q8mKfrtessV6/0dru77NIUBNLxUxLCJrleovoQsS+0J8dJzvAoRldOsxnMPKhlDMBCPM1jrwghidiIx9nK3k8DZln81JkBx+avIQDaYnsvZp96q0ThcdEwPlq5iltMu4Jnf4kpIxq963OwoLUYB7p31Y28rlyKdbeqZf+3fB/UXA0WmneeDhX20yduYV1O34QCMrLeYQOS7+XLi9BJ5PqV/rwMvHvSnrFiSLDGW2qu2TGUPL2hB8mfv0SKhaHs/cm/pv4v7HF057pyOeSRwIZOAOX1/qiXriPG3n90nJo/HsUMOTd7SGQ5PyI9x9rRFKK+vl3IfizF4xRqUW9vJP3C62RsR64Axy/0PRP+DbLOfF8zn2XIOd0CVHDmkf/LYBqJHT34LMWbWv1I7MhYUvSx3sOzVnyQFDnJOnp4q2F7nODJPpRjpPQugQGZwB3uLGsnYWwOziMu7hyObwVeUQLEDl1XbHBm1lWySUJE0oEdztE9i3TuoKHJCkFiT4pR1JOhcliFeAy4Bc0xMtINgNtgPPM4JUIUb5z6A3aHw4lwn+WsC0oi5HJEp5X+Sz3fTVHZTHW0Utq5h3vLlWRcAOZ0vxOR8TTOD7nQdqHTC2ngj/XY3dyt8gDD7EYbiZx6sqwquuPQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB8586.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(64756008)(66476007)(66446008)(26005)(8676002)(71200400001)(6512007)(122000001)(66556008)(36756003)(76116006)(85182001)(66946007)(82960400001)(38070700005)(6916009)(91956017)(316002)(478600001)(38100700002)(30864003)(2906002)(6486002)(41300700001)(6506007)(5660300002)(83380400001)(2616005)(86362001)(1076003)(8936002)(186003)(2004002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Zy9ZYzVsajJGUEwxYnhVOGs0Y2VOSFR3MWI2ekluQnBSZjZrbjJXVlI2NWt2?=
 =?gb2312?B?QlM2QWt3TWpGbFE3UmlOcmFCbGtLcHV5V2hxay8rT0V1TkV3cGNleTlMTTkx?=
 =?gb2312?B?c2NsWFJkeFhPeWd3VWhNOEtIZS9UVXd6T1J2MUU3VDhER21IbnFCOHMvbU5y?=
 =?gb2312?B?OTlTYS9wVXVGZGxocmNmNDVuN1Q5R0hibGFQUDQrL3hMQWgreHpqdG5RdENQ?=
 =?gb2312?B?aXk0VTVuRFgxSlNHZzIycGg3TmFQL0xkckVvUE53NXRXUDFRVnVMMU45bzZl?=
 =?gb2312?B?TDhIbG0ycWFGSDJaLzJEeWM0RTZIOExEYzBhQVlTeHkzQ1F1bWpEQnI2STJa?=
 =?gb2312?B?Sk9yL2lwdWNLTWxORWorWXdqeXUrMm5jTmIwcUJ1L1o5MWRYOWlQb0pZc1U2?=
 =?gb2312?B?N0U4OE1jTVNyU3l3ZXphTnZOYmZNTFg5U0hvTkV4VVc3bmgwL0p0MlYrd2Ft?=
 =?gb2312?B?ZVcwOElscnhRbG9UWVp2cS95ZXRDN0c3a3cvdjYzT2xvNkF1M3A4TGFlMmR4?=
 =?gb2312?B?MkMyQWMwS2E5L0tEVkNCMk5ZYTUvLzVpMlF5RHJSZ1pQck9yV09ITnUwdWcy?=
 =?gb2312?B?VGl2MnlSaElLZm5EallhekU3Y2taNWlpUU1rMGhGb1lQK29BN0Z1YXF0eWx4?=
 =?gb2312?B?Z2lzMVozaGlNNEpYVWIzM1NkVklNaVRDeXN4T0Ixbk9JM045WlhPNjFzcXQ0?=
 =?gb2312?B?Q2pzZ3VENytIc1JDM0lDYkVzdmxCMkczSHZ5Y3VTTlozZDhrazBiMWdxSW5M?=
 =?gb2312?B?R3J1eHozOENWOE5iNE5ZMWFMT2krUTVnWWo2eko1S2YzTGlBT3ZXa3Vyb3pw?=
 =?gb2312?B?NkYveWhYM1JBcDR4STlxRU8zMW5oQTNnbVUxRzNMcE5hZnVaejJHVkdFeXdt?=
 =?gb2312?B?cmJtRzJqMUJtbTJsZFRDRW52SmxwS2xmaGt5ZnFJWUE4U0dUL2RRQWpwRGVI?=
 =?gb2312?B?c3JPcnFmQ1BxRkovYUVWWkVBNEh5bnFGK3h5T2Fzb2Vianh5N2pHKytrYzJy?=
 =?gb2312?B?dHprREd4R0s4NVdBM0h5cms1RGkvdUZMRGNMSVQ4UDFqWGhFY00xYm8xSk1K?=
 =?gb2312?B?YjJJS3psRFQ4RkhJMWdINEx3TWlJaUZFK1ZHekhxU1ZHYndvNXMvYms4c1Zy?=
 =?gb2312?B?NXN2aVI5YUk2U3VpZHBDQkRzcDlMYUwxQ1Y2elhCU25wSk96dWh0c25JVk5m?=
 =?gb2312?B?N0pyRVc2cllXb2dZOHVha0w3WDlQMy9sMVpiMmNYRkw4NVBSdS95aDNYYmVk?=
 =?gb2312?B?dEZvd1lPNEc1UXowRStHaE81dGt1L2tzeVlhRmQ1QkpyM2ZPZGZXbFZaN1Ri?=
 =?gb2312?B?N1VLcVBwcENMNzIvNnBEM0tlTTVOOWFSdmJtQlVGOU1zVFBzK0ljQ0hYYnRS?=
 =?gb2312?B?SlFDcXZXTXVnc0VWbmtGdlg3MjlPK2tlZTlIVHN2dWFXS1lSKzBqUDd3dFFB?=
 =?gb2312?B?ZUx6YUFpZyt4cVhDZWViZWtMREpEY2lYQ0Q3MkxWNGJISXY0dGs0SS9GVkxs?=
 =?gb2312?B?QzlvbWVjRHN6c1JycFlMWTBYUzNpSUpFdXdXM3k2ZWdXYWovakd4Tk5BTFhM?=
 =?gb2312?B?QndrdnJDUG9kckFtVlVZMUZYR2F1a21ZUmdEZzJYUUNlNWNtblRIQU9rMEt5?=
 =?gb2312?B?bkJPbGFGYUVJYm9VSDYvMzNhMlNDL0dtTU9WcUtPbHNiZzUwTG5RYnoxREho?=
 =?gb2312?B?a1F2bHJtblphUU5mTGdTKzRFdFczMWZzZldkRjhSS1FLeEtIRzVpV0syRTM0?=
 =?gb2312?B?anB1OFpOQzlwMHlYZWZXM3JNaWF0K1Z6bXBGQVJ0T0xTeGJVUkIxNWVydjFY?=
 =?gb2312?B?R1RkZGJXUTcrZDZ6b0RyY2ZNLzZJTllqdnBKcXp1dWRzV2hlaVdrMzlKaWNp?=
 =?gb2312?B?NG4vSXgzV0tOUm0vWEFGdXhoRithazM5d3VKWTFUZFQ3MW5lbS9hY2prTktG?=
 =?gb2312?B?WnoyYnVFZGxOYWU1ZEwwSmZRTFY4d21MQXRuVVRQQW5yUUF4MzJhVFNxaWZj?=
 =?gb2312?B?eGdTcE5na2FOaVlqc1VpUDVLaEJTVFErTzFtNHdIajVST2dnWkFOcFdmOTRG?=
 =?gb2312?B?TkxpZmlCRTZTdGVUdTNQZE9UR1NrOU1yUDMwbmVvZGk0dTN0MWFsa0dwdzJI?=
 =?gb2312?B?a0lkUWk1RjVTbXVwRkZaVGZiVGtndXlNdXE5R2QxRzZBNldZWUlRcTdzRWlM?=
 =?gb2312?B?WGc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8586.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59361c57-f52a-4382-efb9-08da662acb41
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 06:25:21.0633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Cq0K5Qv5eANrdyH1KodrQEn9VU+G9xbzDKwlJ5QDzjjXII2TDp0Mdim6As5urayXbUMeVysO75P0HwAHgpBTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3533
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mount03: Convert to new API
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
 testcases/kernel/syscalls/mount/mount03.c | 462 ++++++++--------------
 1 file changed, 175 insertions(+), 287 deletions(-)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 25f99bbfc..905fcbbac 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -1,136 +1,97 @@
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
 
-#include <sys/types.h>
-#include <sys/mount.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <assert.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <pwd.h>
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
 #define TEMP_FILE	"temp_file"
 #define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
-#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
-			 S_IXGRP|S_IROTH|S_IXOTH)
 #define SUID_MODE	(S_ISUID|S_IRUSR|S_IXUSR|S_IXGRP|S_IXOTH)
 
-static const char mntpoint[] = "mntpoint";
-static const char *device;
-static const char *fs_type;
-static int fildes;
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <linux/limits.h>
+#include <stdlib.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "tst_safe_file_ops.h"
+#include "lapi/mount.h"
 
+#define MNTPOINT        "mntpoint"
+#define FILE_PATH	MNTPOINT"/mount03_setuid_test"
+#define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
+
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
+static char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;
+
+static struct tcase {
+	char *name;
+	unsigned int flags;
+} tcases[] = {
+	TCASE_ENTRY(MS_RDONLY),
+	TCASE_ENTRY(MS_NODEV),
+	TCASE_ENTRY(MS_NOEXEC),
+	TCASE_ENTRY(MS_SYNCHRONOUS),
+	TCASE_ENTRY(MS_RDONLY),
+	TCASE_ENTRY(MS_NOSUID),
+	TCASE_ENTRY(MS_NOATIME),
 };
 
-int main(int argc, char *argv[])
+static int test_ms_nosuid(void)
 {
-	int lc, i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	int pid, status;
 
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; ++i) {
-
-			TEST(mount(device, mntpoint, fs_type, rwflags[i],
-				   NULL));
-
-			if (TEST_RETURN != 0) {
-				tst_resm(TFAIL | TTERRNO, "mount(2) failed");
-				continue;
-			}
-
-			/* Validate the rwflag */
-			if (test_rwflag(i, lc) == 1)
-				tst_resm(TFAIL, "mount(2) failed while"
-					 " validating %ld", rwflags[i]);
-			else
-				tst_resm(TPASS, "mount(2) passed with "
-					 "rwflag = %ld", rwflags[i]);
-
-			TEST(tst_umount(mntpoint));
-			if (TEST_RETURN != 0)
-				tst_brkm(TBROK | TTERRNO, cleanup,
-					 "umount(2) failed for %s", mntpoint);
+	switch (pid = SAFE_FORK()) {
+	case -1:
+		tst_brk(TFAIL | TERRNO, "fork failed");
+		break;
+	case 0:
+		SAFE_SETREUID(ltpuser->pw_uid, ltpuser->pw_uid);
+
+		execlp(file, basename(file), NULL);
+		exit(1);
+	default:
+		waitpid(pid, &status, 0);
+		if (WIFEXITED(status)) {
+			/* reset the setup_uid */
+			if (status)
+				return 0;
 		}
+		return 1;
 	}
-
-	cleanup();
-	tst_exit();
+	return 0;
 }
 
-/*
- * test_rwflag(int i, int cnt)
- * Validate the mount system call for rwflags.
- */
-int test_rwflag(int i, int cnt)
+static void test_rwflag(int i)
 {
-	int ret, fd, pid, status;
-	char nobody_uid[] = "nobody";
+	int ret;
 	time_t atime;
-	struct passwd *ltpuser;
 	struct stat file_stat;
 	char readbuf[20];
 
@@ -138,56 +99,42 @@ int test_rwflag(int i, int cnt)
 	case 0:
 		/* Validate MS_RDONLY flag of mount call */
 
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
+		snprintf(file, PATH_MAX, "%s/tmp", MNTPOINT);
+		TST_EXP_FAIL2(open(file, O_CREAT | O_RDWR, S_IRWXU),
+			      EROFS, "mount(2) passed with flag MS_RDONLY: "
+			      "open fail with EROFS as expected");
+
+		otfd = TST_RET;
+		break;
 	case 1:
 		/* Validate MS_NODEV flag of mount call */
 
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
+		snprintf(file, PATH_MAX, "%s/mynod_%d", MNTPOINT, getpid());
+		if (SAFE_MKNOD(file, S_IFBLK | 0777, 0) == 0) {
+			TST_EXP_FAIL2(open(file, O_RDWR, S_IRWXU),
+				      EACCES, "mount(2) passed with flag MS_NODEV: "
+				      "open fail with EACCES as expected");
+			otfd = TST_RET;
 		}
-		return 1;
+		SAFE_UNLINK(file);
+		break;
 	case 2:
 		/* Validate MS_NOEXEC flag of mount call */
 
-		snprintf(file, PATH_MAX, "%stmp1", path_name);
-		fd = open(file, O_CREAT | O_RDWR, S_IRWXU);
-		if (fd == -1) {
-			tst_resm(TWARN | TERRNO, "opening %s failed", file);
-		} else {
-			close(fd);
+		snprintf(file, PATH_MAX, "%s/tmp1", MNTPOINT);
+		TST_EXP_FD_SILENT(open(file, O_CREAT | O_RDWR, S_IRWXU),
+				  "opening %s failed", file);
+		otfd = TST_RET;
+		if (otfd >= 0) {
+			SAFE_CLOSE(otfd);
 			ret = execlp(file, basename(file), NULL);
-			if ((ret == -1) && (errno == EACCES))
-				return 0;
+			if ((ret == -1) && (errno == EACCES)) {
+				tst_res(TPASS, "mount(2) passed with flag MS_NOEXEC");
+				break;
+			}
 		}
-		return 1;
+		tst_brk(TFAIL | TERRNO, "mount(2) failed with flag MS_NOEXEC");
+		break;
 	case 3:
 		/*
 		 * Validate MS_SYNCHRONOUS flag of mount call.
@@ -197,193 +144,134 @@ int test_rwflag(int i, int cnt)
 		strcpy(write_buffer, "abcdefghijklmnopqrstuvwxyz");
 
 		/* Creat a temporary file under above directory */
-		snprintf(file, PATH_MAX, "%s%s", path_name, TEMP_FILE);
-		fildes = open(file, O_RDWR | O_CREAT, FILE_MODE);
-		if (fildes == -1) {
-			tst_resm(TWARN | TERRNO,
-				 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-				 file, FILE_MODE);
-			return 1;
-		}
+		snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TEMP_FILE);
+		TST_EXP_FD_SILENT(open(file, O_RDWR | O_CREAT, FILE_MODE),
+			   "open(%s, O_RDWR|O_CREAT, %#o) failed",
+			   file, FILE_MODE);
+		otfd = TST_RET;
 
 		/* Write the buffer data into file */
-		if (write(fildes, write_buffer, strlen(write_buffer)) !=
-		    (long)strlen(write_buffer)) {
-			tst_resm(TWARN | TERRNO, "writing to %s failed", file);
-			close(fildes);
-			return 1;
-		}
+		SAFE_WRITE(1, otfd, write_buffer, strlen(write_buffer));
 
 		/* Set the file ptr to b'nning of file */
-		if (lseek(fildes, 0, SEEK_SET) < 0) {
-			tst_resm(TWARN, "lseek() failed on %s, error="
-				 " %d", file, errno);
-			close(fildes);
-			return 1;
-		}
+		SAFE_LSEEK(otfd, 0, SEEK_SET);
 
 		/* Read the contents of file */
-		if (read(fildes, read_buffer, sizeof(read_buffer)) > 0) {
+		if (SAFE_READ(0, otfd, read_buffer, sizeof(read_buffer)) > 0) {
 			if (strcmp(read_buffer, write_buffer)) {
-				tst_resm(TWARN, "Data read from %s and written "
+				tst_brk(TFAIL, "Data read from %s and written "
 					 "mismatch", file);
-				close(fildes);
-				return 1;
 			} else {
-				close(fildes);
-				return 0;
+				SAFE_CLOSE(otfd);
+				tst_res(TPASS, "mount(2) passed with flag MS_SYNCHRONOUS");
+				break;
 			}
 		} else {
-			tst_resm(TWARN | TERRNO, "read() Fails on %s", file);
-			close(fildes);
-			return 1;
+			tst_brk(TFAIL | TERRNO, "read() Fails on %s", file);
 		}
-
+		break;
 	case 4:
 		/* Validate MS_REMOUNT flag of mount call */
 
-		TEST(mount(device, mntpoint, fs_type, MS_REMOUNT, NULL));
-		if (TEST_RETURN != 0) {
-			tst_resm(TWARN | TTERRNO, "mount(2) failed to remount");
-			return 1;
+		TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, MS_REMOUNT, NULL));
+		if (TST_RET != 0) {
+			tst_brk(TFAIL | TTERRNO, "mount(2) failed to remount");
 		} else {
-			snprintf(file, PATH_MAX, "%stmp2", path_name);
-			fd = open(file, O_CREAT | O_RDWR, S_IRWXU);
-			if (fd == -1) {
-				tst_resm(TWARN, "open(%s) on readonly "
+			snprintf(file, PATH_MAX, "%s/tmp2", MNTPOINT);
+			TEST(open(file, O_CREAT | O_RDWR, S_IRWXU));
+			otfd = TST_RET;
+			if (otfd == -1) {
+				tst_res(TFAIL, "open(%s) on readonly "
 					 "filesystem passed", file);
-				return 1;
-			} else {
-				close(fd);
-				return 0;
-			}
+			} else
+				tst_res(TPASS, "mount(2) passed with flag MS_REMOUNT");
 		}
+		break;
 	case 5:
 		/* Validate MS_NOSUID flag of mount call */
 
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
+		snprintf(file, PATH_MAX, "%s/mount03_setuid_test", MNTPOINT);
+		TEST(test_ms_nosuid());
+		if (TST_RET == 0)
+			tst_res(TPASS, "mount(2) passed with flag MS_NOSUID");
+		else
+			tst_res(TFAIL, "mount(2) failed with flag MS_NOSUID");
+		break;
 	case 6:
 		/* Validate MS_NOATIME flag of mount call */
 
-		snprintf(file, PATH_MAX, "%satime", path_name);
-		fd = open(file, O_CREAT | O_RDWR, S_IRWXU);
-		if (fd == -1) {
-			tst_resm(TWARN | TERRNO, "opening %s failed", file);
-			return 1;
-		}
+		snprintf(file, PATH_MAX, "%s/atime", MNTPOINT);
+		TST_EXP_FD_SILENT(open(file, O_CREAT | O_RDWR, S_IRWXU));
+		otfd = TST_RET;
 
-		if (write(fd, "TEST_MS_NOATIME", 15) != 15) {
-			tst_resm(TWARN | TERRNO, "write %s failed", file);
-			close(fd);
-			return 1;
-		}
+		SAFE_WRITE(1, otfd, "TEST_MS_NOATIME", 15);
 
-		if (fstat(fd, &file_stat) == -1) {
-			tst_resm(TWARN | TERRNO, "stat %s failed #1", file);
-			close(fd);
-			return 1;
-		}
+		SAFE_FSTAT(otfd, &file_stat);
 
 		atime = file_stat.st_atime;
 
 		sleep(1);
 
-		if (read(fd, readbuf, sizeof(readbuf)) == -1) {
-			tst_resm(TWARN | TERRNO, "read %s failed", file);
-			close(fd);
-			return 1;
-		}
+		SAFE_READ(0, otfd, readbuf, sizeof(readbuf));
 
-		if (fstat(fd, &file_stat) == -1) {
-			tst_resm(TWARN | TERRNO, "stat %s failed #2", file);
-			close(fd);
-			return 1;
-		}
-		close(fd);
+		SAFE_FSTAT(otfd, &file_stat);
 
 		if (file_stat.st_atime != atime) {
-			tst_resm(TWARN, "access time is updated");
-			return 1;
+			tst_res(TFAIL, "access time is updated");
+			break;
 		}
-		return 0;
+		tst_res(TPASS, "mount(2) passed with flag MS_NOATIME");
 	}
-	return 0;
 }
 
-static void setup(void)
+static void run(unsigned int n)
 {
-	char path[PATH_MAX];
-	struct stat file_stat;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	tst_tmpdir();
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
-
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
+	struct tcase *tc = &tcases[n];
 
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
+	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type,
+		   tc->flags, NULL));
+	test_rwflag(n);
 
-	SAFE_MKDIR(cleanup, mntpoint, DIR_MODE);
-
-	if (getcwd(path_name, sizeof(path_name)) == NULL)
-		tst_brkm(TBROK, cleanup, "getcwd failed");
-
-	if (chmod(path_name, DIR_MODE) != 0)
-		tst_brkm(TBROK, cleanup, "chmod(%s, %#o) failed",
-			 path_name, DIR_MODE);
-
-	strncpy(path, path_name, PATH_MAX);
-	snprintf(path_name, PATH_MAX, "%s/%s/", path, mntpoint);
+	if (otfd >= 0)
+		SAFE_CLOSE(otfd);
+	if (tst_is_mounted(MNTPOINT))
+		SAFE_UMOUNT(MNTPOINT);
+}
 
-	SAFE_MOUNT(cleanup, device, mntpoint, fs_type, 0, NULL);
-	TST_RESOURCE_COPY(cleanup, "mount03_setuid_test", path_name);
+static void cleanup(void)
+{
+	if (otfd > -1)
+		SAFE_CLOSE(otfd);
+}
 
-	snprintf(file, PATH_MAX, "%smount03_setuid_test", path_name);
-	SAFE_STAT(cleanup, file, &file_stat);
+static void setup(void)
+{
+	struct stat file_stat = {0};
 
+	ltpuser = getpwnam(nobody_uid);
+	if (ltpuser == NULL)
+		tst_res(TFAIL, "getpwnam failed");
+	snprintf(file, PATH_MAX, "%s/mount03_setuid_test", MNTPOINT);
+	SAFE_STAT(MNTPOINT, &file_stat);
 	if (file_stat.st_mode != SUID_MODE &&
-	    chmod(file, SUID_MODE) < 0)
-		tst_brkm(TBROK, cleanup,
-			 "setuid for setuid_test failed");
-	SAFE_UMOUNT(cleanup, mntpoint);
-
-	TEST_PAUSE;
+	    chmod(MNTPOINT, SUID_MODE) < 0)
+		tst_res(TFAIL, "setuid for setuid_test failed");
 }
 
-static void cleanup(void)
-{
-	if (device)
-		tst_release_device(device);
+static const char *const resource_files[] = {
+	"mount03_setuid_test",
+	NULL,
+};
 
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.format_device = 1,
+	.resource_files = resource_files,
+	.forks_child = 1,
+	.mntpoint = MNTPOINT,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
+};
-- 
2.31.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
