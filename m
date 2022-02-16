Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C142C433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 13:22:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C5FA3CA089
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 14:22:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 355153C9299
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 14:22:12 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D116F200FF8
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 14:22:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1645017729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NzEkiGpFYr3PMGXhogzdgUuJRvw2IZxWeyDFiAYZq00=;
 b=ASaYl/5xUHOso7MW9mQazqODA+NKBODR6rNXmRKaRNvwz4A8B3YWZM8d5GkcUfMvSFLIPv
 meGUPsjvDBzufZZlrU1EDV9S6QYcpV1CgYNmeddoVmuXUeYG8FJ62vAm5nyDGXxYwl5w3R
 PRGspo/BlegFypm4NMPwOuyxxBqgSB8=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-kGP6uUaNOvipBfXQmBka-w-1; Wed, 16 Feb 2022 14:22:08 +0100
X-MC-Unique: kGP6uUaNOvipBfXQmBka-w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBZr04drgp25ry6eeTO8e0TNC1xaFeesNt4qCQYKPzrTRhVOX4JRWfxUtlKdBLNEjzCTVvwrc9/jSR6Meynod1cd2kqNLXSqxJLH0vFVs7a/F8mECLJGD+7h/qllIqDNZfMG3yiE5CNyfHJnNjIyWrj9fIj7l1F/aEYgZpAtadGqmonkMh4mrL7x27nP14LAdbYeqSmnZ4JtjiLMy+Ed6aoE7iWCVSfIRIRFs/AUnG56jgtvLf97Yt225ybKcQd9ds3V38EPv623uGgCIC3JQQnFmkcIKKV3Yj9MMs/S4zOqkjJLDXsIWlXqccQnJEhSvQ2cgaNRril6OZ4Wc57Jgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzEkiGpFYr3PMGXhogzdgUuJRvw2IZxWeyDFiAYZq00=;
 b=BxD8KxLseTW1JNsLPEkv5uRg3mN+UC9Ki2OmtlnEgR+Ki2PevfZZE89NCyIXV9QlAVefFwX0Hg23ULeNSdNb7BT5lYhb1mAkEz4t1Kxh7AD78JqFOpYco733pzgrHZgZi51kCQa8fYTTBXq07Lwm/l+CG5LjMviBXc6GFDDD+36Z/nm7UJh2P2M1EM2gVMFYsIa98xxjBI+RC5WPt5u0hK3w4OG9k3ovIwknXab1KBYU4cyR7qo+ZqPmnVmeKGf7xcxmkZjbIlBTLkGmKGT5iOrBCLUTZJm4eVt/TCI9wC8A4xyE89Qx2IBhL2dW0LqHsyHbGhul+sKbTgxhPudOcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com (2603:10a6:208:18e::20)
 by VI1PR04MB7151.eurprd04.prod.outlook.com (2603:10a6:800:129::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Wed, 16 Feb
 2022 13:22:06 +0000
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::6d8a:aa54:e2dc:5dfd]) by AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::6d8a:aa54:e2dc:5dfd%6]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 13:22:06 +0000
Message-ID: <22249dc0-f931-ce58-809c-fed48bb892e4@suse.com>
Date: Wed, 16 Feb 2022 14:22:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20220216131900.21454-1-andrea.cervesato@suse.de>
In-Reply-To: <20220216131900.21454-1-andrea.cervesato@suse.de>
X-ClientProxiedBy: AS9PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::15) To AM0PR04MB6788.eurprd04.prod.outlook.com
 (2603:10a6:208:18e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec927797-0680-4ea1-d477-08d9f14f53a6
X-MS-TrafficTypeDiagnostic: VI1PR04MB7151:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB71511C32C3F5AFC299F24422F8359@VI1PR04MB7151.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1wz315CXq1WW9oVzsxC8bF8sAHdJ4svxO51jA7tqhnWXU62SYh8Gr3cR5U+We8mIRiNCBNOZt73RYcZuOAnheoCnH951UicoTrxjD4nnB6C2bOG3pF4NX9IKyMsAVfQAU3KVHQgOMTkdFupFlhNT2uxA0a6TSGFjizRulb+z8tcgNmRYJM6Ny+0acIjR22aYmnQlKPg0UywS12C+Ctcxoh3SAOtrUTu7E8/UsTV0FiNGxaMs0aeKKB4mOg9zZBdNXXjpl0mYQT+tiq+0azAq/iIoSxI5LoUthL6YnXDw9Ye6OypJAW6Ym7hue7FkOCVI/u74PTLrDUdcNbdUoKWBB1CW8G1OhJgrfvx51yA5ckATCIN63ZaVB8lROyCtgRok72BoxVeWGzai3+UCXklOvcpKL4ceRjcgoi8Bgraug8j06wvNDjSvXq0fIE/NxE95hrZEuAeRc/4FbDmaEywuZrVt2NIDhsKSL1RF5s/KtuNNxI7QZNgrpKTnJR8xRUOGzn9ukIl9XwDjZSL/2UrQz3ct1S64/EZuWNDPViDGY2uOD0zZeobkpR7UrX0jAq1clF/Dkl6k+WWhjPiWQNrTH+w8TTanp2TEs/KF3mANL4O3OpSjCxPJENf2e4MjcUHP42Gj6QOOYnGib/NOv9tirVjTWU3U5/Y3K2b0jvdvQDZeMV59ighsrrtv1APvLX/78n920n1Sadger4xT2AzVsjf+FRwltZWzFvo7IrdKFvbjmrQhpsLxBlMjbsQ7TLB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6788.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(66476007)(6486002)(5660300002)(33964004)(44832011)(36756003)(6506007)(30864003)(66556008)(31686004)(8676002)(83380400001)(66946007)(53546011)(186003)(31696002)(8936002)(38100700002)(2906002)(86362001)(316002)(508600001)(26005)(6512007)(2616005)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzQ2SVVuSWZWT3NtSys0bDUyeWd3QndvVCs3M1VmMm9yb1M3cW5WUXV1TFNo?=
 =?utf-8?B?MjFLVXJ1T1NqU1MrUFR5ZVU2QmZjMUVmeE52bERYK3BxaFl1d0hseENZcHNi?=
 =?utf-8?B?WnhBNTdoMEpMVUZTS29JTUd6WlJJa21GZWVDcnQ3YVY0UFBIQmxzYVhpUUhw?=
 =?utf-8?B?eGxUWXFEazVTWW90bTZBMWs4K2czN2lNWGdiSGcxY3o4azFVWTM4bmo3VVky?=
 =?utf-8?B?dHhFWGRNUG52TnRUU3Rrd2tVdTVhdEN1akl4MVpMMTR2aFVGOTIyaFdyWFMy?=
 =?utf-8?B?K0I1djlIRkwvL3MxS2REdmRUK3RhTW1xdmJPRC9CYm8xZ3NQWCtSbVo3dlBC?=
 =?utf-8?B?Vy84b3lxeHdwakVZcWp2ZjF3Y0NFR3M1OHViVFNFdFltVnJpVkppOTduaDRj?=
 =?utf-8?B?dEZSM3htUFJwNDFsS25xV1daaTN2cTVLYVovS2JLTmVPYkV6eGx0S29MclZs?=
 =?utf-8?B?eUt3ZUh6Zm15TkY4N0czSyt3MmZqOWtxUDZzczlRQVp5TkFHQjRxbjIyc3Fr?=
 =?utf-8?B?bkRIV3c0dFEwSlgycXdOb2hGN1ZUOFN3TWE2cUo0N0JYbm9TSGpscXQrZFpM?=
 =?utf-8?B?TlZUaVh4dUliQWkwRVdBQkprREp3Y2tvTnkwZjVyYjRlc0lvWEI2RjFtcUV2?=
 =?utf-8?B?UUxTRGtCQ0lSV3Q5emxrR05Vb2dIOHVkY3grZlJCY3BPQ2tzY0dhS1N3Y29B?=
 =?utf-8?B?SlhrODloQkxYaXI3MTZ3MlcrOFpMTmNGbFpKc3ErQWRCMWRoQU54anM2bVZt?=
 =?utf-8?B?UnJ5Rm1VM0pocXozL2xvY1kyaVdOUi9HUFc3b0p5Y1lEZDJNZHlLSlB1RTVw?=
 =?utf-8?B?a21CeG9MT2N1U0NZVmVzZ3h1NFpHT29sU3Qyd280OHJGSFdqazR2dmpPNUJk?=
 =?utf-8?B?KzVjQjdxSnF1YXJVZk5DeUVsbXRhU2hWVHhrSEIzZDdXYzBWWnhMV3lRVTBi?=
 =?utf-8?B?alNlZm9wMDJiYjlYL1ZBQkhoc0dZUC9mNW8wSUhCL0pGblZ4RDBVQmlQS3Ew?=
 =?utf-8?B?dmt5cEdkb3Mrb1ZaL2w2M0JBVGZ0d0dIdUpRMWNiY1RCblU3cEErMlo2NzZu?=
 =?utf-8?B?OGtXTHlnTzBveGRvdkVMMldjN2Z5bUJ0QWdZS01tQzl3cmdvNWQwSm9tSWtl?=
 =?utf-8?B?MzRvOXIxNGoxTnhnZWJtYzBTUWE5a3RvNTZWYmRodGdoOVdPNkZrbWRIbkZT?=
 =?utf-8?B?WmUyV1pBbHBCYWJVdEtaVmpITGVSU0RnaC9XZUxHb2VhbWZKb3JXRnNUbjJ2?=
 =?utf-8?B?VFJPSGFXTHZZL1ZEK3VPRjRNZ09QVTZ3Q0RFY3VjdXZ2WG1EbldTRGJPMWZP?=
 =?utf-8?B?VThBUld5M0dncG5NWTRwY0hZbVJvNFZRdnNiOFYzc29KYWdFTCtOU3daZndS?=
 =?utf-8?B?cVZiSHp2WFhhTEYyTW5xVG1WUHBXRzFFVzRPR09Ja3BDQkRjUCtJRng1UUYy?=
 =?utf-8?B?aExWQVJOT1F6dTBYNEdHeEE0MzZoNkZCb3hiZXVuUUxnd1JoeTFZWGFUVzF3?=
 =?utf-8?B?U1BMVUU5YnQrdWd3UDJnckc4bEMxU2NTMm5pZm5PZld2dVhBYnRuMWRFNjRU?=
 =?utf-8?B?Y05neWlrdDlWL2Y5UGJQVmtqZ1NGR2JxR2wwcWR5c1ptQTBmVHlVSVBWK0Fv?=
 =?utf-8?B?MyswK1p2UCtjNFVvcGZYY1dtamwwSXc1UW9JWTZaTC9WeVJNR0xweTQrMHRw?=
 =?utf-8?B?K1RtRVZ2ODR2RUJVbmVuT24vcHo3WXUvK2lNdHUyQVNOc0JHTHNEcXhSNU96?=
 =?utf-8?B?elhPSUhLYWU4NUc0WmJBejF3ZmFRRDJVOCtGVHN4VU55YjJZRlhSS0pRMmlX?=
 =?utf-8?B?Q3dGNVVNUjhEUVk4TFduemRLMkFwUWlCQ1pzdmNNRWZjUFIzK0xTSFk1SnhY?=
 =?utf-8?B?WjUweVhEL3dtSUNrbzM1ckxFZTJLSGRkSlROUW00dFNOcE16dDBQd0xHaVUw?=
 =?utf-8?B?KzNKWUJQTUZNbU5uT01udVIxeVliSGVnZTduRmNzOE40U0J2bFBNcEpmdDZq?=
 =?utf-8?B?OWU1cjR6QjNVbFlaMWp1STV5cWNRNGVNMFRFWkRKekFMRVBXRWtYSzVNL2tX?=
 =?utf-8?B?emZRa0plVWJITHZlU0hrV3VxdnlPQVJZWjZMWkhab2s2VG1IT29xbW1COHdw?=
 =?utf-8?B?NGw1Z3BnQmR1VlNTdEFxMjZVK0swYjc1ZkNZTjVXRnBVOUtRb3hLc3pZbm0z?=
 =?utf-8?B?cjFUY2F0c0N3WG82eDBVK3poWVlyQ3hJa3VvNk0vQzJad1dQMlBBeHZvbVly?=
 =?utf-8?B?UzhkWSs0Y21LV01EbEpUTmlNWk9BPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec927797-0680-4ea1-d477-08d9f14f53a6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6788.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 13:22:05.9038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjiQ/wuEY4XjnBrvBdQORs1CC2s8fkkYRLJKYImB399gb1L+/2/xuyAL+10ozu7J18GsQfseeoBUEnPmUOmWiHaFgYqTuyhsdXQmmS8VQeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7151
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactoring setpgid03.c test using new LTP API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: multipart/mixed; boundary="===============0201161755=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0201161755==
Content-Type: multipart/alternative;
 boundary="------------adiO6n0qtdVaokGgSHerW3bW"
Content-Language: en-US

--------------adiO6n0qtdVaokGgSHerW3bW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I sent this patch by accident. Please, don't consider it

On 2/16/22 14:19, Andrea Cervesato wrote:
> Removed TST_CHECKPOINT_INIT and replaced it with the .needs_checkpoints
> LTP test feature. Simplified source code.
>
> Signed-off-by: Andrea Cervesato<andrea.cervesato@suse.de>
> ---
> In v2 we have more LTP API style test
>
>   testcases/kernel/syscalls/setpgid/setpgid03.c | 165 ++++--------------
>   .../kernel/syscalls/setpgid/setpgid03_child.c |  28 +--
>   2 files changed, 42 insertions(+), 151 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
> index 51e0eeb24..2ffa34088 100644
> --- a/testcases/kernel/syscalls/setpgid/setpgid03.c
> +++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
> @@ -1,24 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) International Business Machines  Corp., 2001
>    * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
>    * Copyright (c) 2014 Cyril Hrubis<chrubis@suse.cz>
> - *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato<andrea.cervesato@suse.com>
>    */
>   
> -/*
> +/*\
> + * [Description]
> + *
>    * Test to check the error and trivial conditions in setpgid system call
>    *
>    * EPERM   -  The calling process, process specified by pid and the target
> @@ -28,136 +18,53 @@
>    *            has performed exec()
>    */
>   
> -#include <sys/wait.h>
> -#include <limits.h>
> -#include <signal.h>
> -#include <errno.h>
> -#include <sys/param.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
>   #include <unistd.h>
> -#include "test.h"
> +#include <sys/wait.h>
> +#include "tst_test.h"
>   
>   #define TEST_APP "setpgid03_child"
>   
> -char *TCID = "setpgid03";
> -int TST_TOTAL = 1;
> -
> -static void do_child(void);
> -static void setup(void);
> -static void cleanup(void);
> -
> -int main(int ac, char **av)
> +static void do_child(void)
>   {
> -	int child_pid;
> -	int status;
> -	int rval;
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -#ifdef UCLINUX
> -	maybe_run_child(&do_child, "");
> -#endif
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/* Child is in new session we are not alowed to change pgid */
> -		if ((child_pid = FORK_OR_VFORK()) == -1)
> -			tst_brkm(TBROK, cleanup, "fork() failed");
> -
> -		if (child_pid == 0) {
> -#ifdef UCLINUX
> -			if (self_exec(av[0], "") < 0)
> -				tst_brkm(TBROK, cleanup, "self_exec failed");
> -#else
> -			do_child();
> -#endif
> -		}
> -
> -		TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
> -		rval = setpgid(child_pid, getppid());
> -		if (rval == -1 && errno == EPERM) {
> -			tst_resm(TPASS, "setpgid failed with EPERM");
> -		} else {
> -			tst_resm(TFAIL,
> -				"retval %d, errno %d, expected errno %d",
> -				rval, errno, EPERM);
> -		}
> -		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
> -
> -		if (wait(&status) < 0)
> -			tst_resm(TFAIL | TERRNO, "wait() for child 1 failed");
> -
> -		if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
> -			tst_resm(TFAIL, "child 1 failed with status %d",
> -				WEXITSTATUS(status));
> -
> -		/* Child after exec() we are no longer allowed to set pgid */
> -		if ((child_pid = FORK_OR_VFORK()) == -1)
> -			tst_resm(TFAIL, "Fork failed");
> -
> -		if (child_pid == 0) {
> -			if (execlp(TEST_APP, TEST_APP, NULL) < 0)
> -				perror("exec failed");
> -
> -			exit(127);
> -		}
> -
> -		TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
> -		rval = setpgid(child_pid, getppid());
> -		if (rval == -1 && errno == EACCES) {
> -			tst_resm(TPASS, "setpgid failed with EACCES");
> -		} else {
> -			tst_resm(TFAIL,
> -				"retval %d, errno %d, expected errno %d",
> -				rval, errno, EACCES);
> -		}
> -		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
> -
> -		if (wait(&status) < 0)
> -			tst_resm(TFAIL | TERRNO, "wait() for child 2 failed");
> -
> -		if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
> -			tst_resm(TFAIL, "child 2 failed with status %d",
> -				WEXITSTATUS(status));
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	SAFE_SETSID();
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>   }
>   
> -static void do_child(void)
> +static void run(void)
>   {
> -	if (setsid() < 0) {
> -		printf("CHILD: setsid() failed, errno: %d\n", errno);
> -		exit(2);
> +	pid_t child_pid;
> +	int status;
> +
> +	child_pid = SAFE_FORK();
> +	if (!child_pid) {
> +		do_child();
> +		return;
>   	}
>   
> -	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
> +	TST_CHECKPOINT_WAIT(0);
>   
> -	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
> +	TST_EXP_FAIL(setpgid(child_pid, getppid()), EPERM);
>   
> -	exit(0);
> -}
> +	TST_CHECKPOINT_WAKE(0);
>   
> -static void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	SAFE_WAIT(&status);
>   
> -	tst_tmpdir();
> +	/* child after exec() we are no longer allowed to set pgid */
> +	child_pid = SAFE_FORK();
> +	if (!child_pid)
> +		SAFE_EXECLP(TEST_APP, TEST_APP, NULL);
>   
> -	TST_CHECKPOINT_INIT(tst_rmdir);
> +	TST_CHECKPOINT_WAIT(0);
>   
> -	umask(0);
> +	TST_EXP_FAIL(setpgid(child_pid, getppid()), EACCES);
>   
> -	TEST_PAUSE;
> -}
> +	TST_CHECKPOINT_WAKE(0);
>   
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> +	SAFE_WAIT(&status);
>   }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +};
> diff --git a/testcases/kernel/syscalls/setpgid/setpgid03_child.c b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
> index 2657422a6..fdb22f24d 100644
> --- a/testcases/kernel/syscalls/setpgid/setpgid03_child.c
> +++ b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
> @@ -1,32 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of
> - * the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software Foundation,
> - * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato<andrea.cervesato@suse.com>
>    */
>   
> -#include "test.h"
> -
> -char *TCID = "setpgid03_child";
> -
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
>   
>   int main(void)
>   {
> -	TST_CHECKPOINT_INIT(NULL);
> -
> -	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
> -	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
> +	tst_reinit();
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>   
>   	return 0;
>   }
--------------adiO6n0qtdVaokGgSHerW3bW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi,</font></p>
    <p><font size="4">I sent this patch by accident. Please, don't
        consider it</font><br>
    </p>
    <div class="moz-cite-prefix">On 2/16/22 14:19, Andrea Cervesato
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220216131900.21454-1-andrea.cervesato@suse.de">
      <pre class="moz-quote-pre" wrap="">Removed TST_CHECKPOINT_INIT and replaced it with the .needs_checkpoints
LTP test feature. Simplified source code.

Signed-off-by: Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.de">&lt;andrea.cervesato@suse.de&gt;</a>
---
In v2 we have more LTP API style test

 testcases/kernel/syscalls/setpgid/setpgid03.c | 165 ++++--------------
 .../kernel/syscalls/setpgid/setpgid03_child.c |  28 +--
 2 files changed, 42 insertions(+), 151 deletions(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
index 51e0eeb24..2ffa34088 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
@@ -1,24 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  * Copyright (c) 2014 Cyril Hrubis <a class="moz-txt-link-rfc2396E" href="mailto:chrubis@suse.cz">&lt;chrubis@suse.cz&gt;</a>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>
  */
 
-/*
+/*\
+ * [Description]
+ *
  * Test to check the error and trivial conditions in setpgid system call
  *
  * EPERM   -  The calling process, process specified by pid and the target
@@ -28,136 +18,53 @@
  *            has performed exec()
  */
 
-#include &lt;sys/wait.h&gt;
-#include &lt;limits.h&gt;
-#include &lt;signal.h&gt;
-#include &lt;errno.h&gt;
-#include &lt;sys/param.h&gt;
-#include &lt;sys/types.h&gt;
-#include &lt;sys/stat.h&gt;
 #include &lt;unistd.h&gt;
-#include &quot;test.h&quot;
+#include &lt;sys/wait.h&gt;
+#include &quot;tst_test.h&quot;
 
 #define TEST_APP &quot;setpgid03_child&quot;
 
-char *TCID = &quot;setpgid03&quot;;
-int TST_TOTAL = 1;
-
-static void do_child(void);
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void do_child(void)
 {
-	int child_pid;
-	int status;
-	int rval;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&amp;do_child, &quot;&quot;);
-#endif
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/* Child is in new session we are not alowed to change pgid */
-		if ((child_pid = FORK_OR_VFORK()) == -1)
-			tst_brkm(TBROK, cleanup, &quot;fork() failed&quot;);
-
-		if (child_pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(av[0], &quot;&quot;) &lt; 0)
-				tst_brkm(TBROK, cleanup, &quot;self_exec failed&quot;);
-#else
-			do_child();
-#endif
-		}
-
-		TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
-		rval = setpgid(child_pid, getppid());
-		if (rval == -1 &amp;&amp; errno == EPERM) {
-			tst_resm(TPASS, &quot;setpgid failed with EPERM&quot;);
-		} else {
-			tst_resm(TFAIL,
-				&quot;retval %d, errno %d, expected errno %d&quot;,
-				rval, errno, EPERM);
-		}
-		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
-
-		if (wait(&amp;status) &lt; 0)
-			tst_resm(TFAIL | TERRNO, &quot;wait() for child 1 failed&quot;);
-
-		if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
-			tst_resm(TFAIL, &quot;child 1 failed with status %d&quot;,
-				WEXITSTATUS(status));
-
-		/* Child after exec() we are no longer allowed to set pgid */
-		if ((child_pid = FORK_OR_VFORK()) == -1)
-			tst_resm(TFAIL, &quot;Fork failed&quot;);
-
-		if (child_pid == 0) {
-			if (execlp(TEST_APP, TEST_APP, NULL) &lt; 0)
-				perror(&quot;exec failed&quot;);
-
-			exit(127);
-		}
-
-		TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
-		rval = setpgid(child_pid, getppid());
-		if (rval == -1 &amp;&amp; errno == EACCES) {
-			tst_resm(TPASS, &quot;setpgid failed with EACCES&quot;);
-		} else {
-			tst_resm(TFAIL,
-				&quot;retval %d, errno %d, expected errno %d&quot;,
-				rval, errno, EACCES);
-		}
-		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
-
-		if (wait(&amp;status) &lt; 0)
-			tst_resm(TFAIL | TERRNO, &quot;wait() for child 2 failed&quot;);
-
-		if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
-			tst_resm(TFAIL, &quot;child 2 failed with status %d&quot;,
-				WEXITSTATUS(status));
-	}
-
-	cleanup();
-	tst_exit();
+	SAFE_SETSID();
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 }
 
-static void do_child(void)
+static void run(void)
 {
-	if (setsid() &lt; 0) {
-		printf(&quot;CHILD: setsid() failed, errno: %d\n&quot;, errno);
-		exit(2);
+	pid_t child_pid;
+	int status;
+
+	child_pid = SAFE_FORK();
+	if (!child_pid) {
+		do_child();
+		return;
 	}
 
-	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
+	TST_CHECKPOINT_WAIT(0);
 
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	TST_EXP_FAIL(setpgid(child_pid, getppid()), EPERM);
 
-	exit(0);
-}
+	TST_CHECKPOINT_WAKE(0);
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	SAFE_WAIT(&amp;status);
 
-	tst_tmpdir();
+	/* child after exec() we are no longer allowed to set pgid */
+	child_pid = SAFE_FORK();
+	if (!child_pid)
+		SAFE_EXECLP(TEST_APP, TEST_APP, NULL);
 
-	TST_CHECKPOINT_INIT(tst_rmdir);
+	TST_CHECKPOINT_WAIT(0);
 
-	umask(0);
+	TST_EXP_FAIL(setpgid(child_pid, getppid()), EACCES);
 
-	TEST_PAUSE;
-}
+	TST_CHECKPOINT_WAKE(0);
 
-static void cleanup(void)
-{
-	tst_rmdir();
+	SAFE_WAIT(&amp;status);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
diff --git a/testcases/kernel/syscalls/setpgid/setpgid03_child.c b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
index 2657422a6..fdb22f24d 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03_child.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
@@ -1,32 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>
  */
 
-#include &quot;test.h&quot;
-
-char *TCID = &quot;setpgid03_child&quot;;
-
+#define TST_NO_DEFAULT_MAIN
+#include &quot;tst_test.h&quot;
 
 int main(void)
 {
-	TST_CHECKPOINT_INIT(NULL);
-
-	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	tst_reinit();
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	return 0;
 }
</pre>
    </blockquote>
  </body>
</html>

--------------adiO6n0qtdVaokGgSHerW3bW--


--===============0201161755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0201161755==--

