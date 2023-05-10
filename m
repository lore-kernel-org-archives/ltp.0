Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3DCC77B7C
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 09:49:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F65C3CD676
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 11:49:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD5C33C994F
 for <ltp@lists.linux.it>; Wed, 10 May 2023 11:48:50 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AA39C600949
 for <ltp@lists.linux.it>; Wed, 10 May 2023 11:48:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc9xwJ8LO6+TPLNcScybkyG7uQX1NIqrZAEDu9AY0YEmgffnhMGHHxSmoXenqwJwFYQvpI4q7P7xLVt+1kwfCIkIGbMOySUbyi5mWXyxRfpXk6RC9L26Kgdp6+fUD6R+2qFCHaa+E8hNT4QRzYCcCkpE+p3KCM2Y6CASosseoCo4JenntOV6L3PVICuM7oPAacqWCoFPoqt11xBZYk67/rwGAZ++EDVcvnBZT8LEON1c1xv5Dl+cVXFxHOoDNjXup2s2000FX6+lM0V8Dlk5AZRkqSzQkHRl2CoQBCVQBUGvZP4QXf1JtyoI9GhZw3SsYJAP8wUdjjKPPPK6Lb6KOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGGE1FHBjz3iKGPSVMHhjW5EYctWnayhpeGg2O+9U50=;
 b=gTEcPCm/qunWhpGq7lUjRtQ6EZa2qZz03BvrfK+uCIS4A6DX+mzeOzcxrk8n4QPsBUWUdHzkHRtmatL2swQ/kykY1O3MtExVPEXoGYk97MRVlPQ7ar4svacff2DpCs8HE5nGJrWqpfULYlNxeOYoVTggDRK9Mx+j8+p+BYW6X5T7x93mWQceITspuGzHWqb9DKm8RnP35AHSUXZkKlwqlNqPMyxWRAPpW6sDjcCop5WD/PLoV2Wb1UOCCvDvbuM2gEck7Z+hNYEEbxJvZaUvXJS2oUSsBbth6ZU56w0FwMtUr+qSDXoaDGVpdB6c1wkIBwsrKl+AEFnCbYovcogvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGGE1FHBjz3iKGPSVMHhjW5EYctWnayhpeGg2O+9U50=;
 b=hHBrjp39TK4W04ggAnEFweqe0Zj2ASJmHZowxXP+YHOaah/oETAoO6nI+Ocb4gs33burrrNDNoWlcmlspZ+ZBeHUDZPI+DeYC1DDm8K+zFlleWbJUiPwUIshVZ3XNFNSy+jW6DEvL6I3WARcgGcT5EfTBut2nicpYcg6avLmjRr787cjAMkRN5HwJsKZX1HquBnAjlThOBHOfWhP6kOGaIlPSyr1GYOJN7OmehV4zD2VKwdlHeemR+2UrOf67dP+Zule8t+bFSFGkvJEU29SDrKxmDyX3Xxs2+9SIX2cUg1biiDzRW9QubjpOGvGrTYHvFQ0DsHUodrHCzYn6yTpSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 09:48:46 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::54ce:4ff6:8295:1c06]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::54ce:4ff6:8295:1c06%4]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 09:48:46 +0000
Message-ID: <673bbf70-a00d-2a19-ce4b-b28b7633844a@suse.com>
Date: Wed, 10 May 2023 11:46:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230307124708.27280-1-andrea.cervesato@suse.de>
 <20230307124708.27280-2-andrea.cervesato@suse.de>
 <20230323103207.GG405493@pevik>
In-Reply-To: <20230323103207.GG405493@pevik>
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 5237dd3f-3b4d-42b6-7a01-08db513bbf60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpP/RgwXOkgNHH2AHp5rdrTZscZHm/VuG+02PQXlCPdC8YF8vtwLYyxc50i9BSlqx7XApUbnFIhwhnRwLopauVsrdh4Kkentmr1yvQ+jy/Yqu9z+vrur0qORLv53wqZEIxbuJU4ieIVfTf90HWS6XvxdeWGRhTir05zJgP2c31Xder1hKaPQBX3vGq+kbOQwVB6tRAJA4aDMC948bg9vhG2uPaPEppZ9i8gwGaCNcy7N2wfuJwDCCgWBKc35kNTc3o7XTNRsuumH8zLjcEJTrGhsXGABa86P1WJ38xG8cRCSRHetEso6hL6rZA7mqx4RACOmkH04uu4xaT6qr2PjKebOh4uNi+3Ad/s53uIuWh0i4F327QBrBqNGv8xf02PU/QFqdT+1pNm04G7SvHosvFTNj5VyGasfaOyPh4e2lm1UyoVE3r4o4V0PNouMldeusknMUI/wp6LnmLDiQumMZp6eHWHQha2sNYzEgOAX5SHxElWcRTnWozFIC5F6OrLBtRGtCnne7lN3XC/7PJ1CXJcwddAS3KdS2YYxROVmWVN2b/vEdDF6dJqVpfP6nlHvOjLHimeEXQtssPQpbIFM7bBCY6lbI1NaLF10AtnwYvSAFoUK8GTbVb7Z/IC6CIU2wmkvh2Xbz4VymGSoA3pWBoQ5U84eOg9h3fGmpXK7PM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(66476007)(86362001)(36756003)(4326008)(31696002)(6666004)(110136005)(316002)(66946007)(66556008)(478600001)(6486002)(44832011)(2906002)(8676002)(8936002)(5660300002)(41300700001)(38100700002)(186003)(2616005)(6506007)(6512007)(53546011)(26005)(83380400001)(31686004)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eS9RUzAzVUlwc2owNlI1WkFsL1BBeEtRVWhzeEppU0ZIbmc1Mmt5b1NHYXFD?=
 =?utf-8?B?UjhNL013K05adS9hZWkxS1BKMUhVbXZlUVJHcnZkQWhaQmE0V0s4MHUwSnRz?=
 =?utf-8?B?NjlZYTRFWnhUczdEM0dvMWxadklIVUU0UnFIVEhPMjVCdFEvTGtJTmRURTZ3?=
 =?utf-8?B?NEFEa2Y0Z2ZoVFhPY2RGMDhEM0FZY0pJNWJpWDFJaEhPSjZtbG55SDVqVUEz?=
 =?utf-8?B?L1ZuckNhblJqREIvNU5rMEtwdjZwSWdVR0k5alo0aTV2VGcvV3ZzZld6TmN1?=
 =?utf-8?B?LzRoRlllbTUzNjd5MjVsRzRnN0tUTXQ5dU5LTG82TmZ3ODR3eENxWGVVWlBj?=
 =?utf-8?B?K1dPVDdKMTJ3Y0RJdCtDZWVyUnJ1MFh6cTN1ZmppT2M4ZFV4SXp2czV1cGZP?=
 =?utf-8?B?YUdHUk51WTFOZXZqVjBpaFFSK3ZyREx1bDBTWERvOUlnQ0xXUFprVEtpc0dG?=
 =?utf-8?B?c0ltZFpnSnBjU0M1YmR2VGxJVnRTOW5VQ0llc1RzcDkzVktFYUVsNGRraGlS?=
 =?utf-8?B?VEsrRVFSWTlTYXBVR1kzVE85NkI2T1M1SkM4N3RxemJRRGdVblFuMDF5cGVl?=
 =?utf-8?B?aTlEY3lVejdlWnNSeGROdjI2emtKcE5pZXpIOVdXMmttME9XZTdnNHdkRzBt?=
 =?utf-8?B?TFozYWJpQWV2OG5nTC9DUVFZUmNLZDZlZGZPTVBTd0ZVSXBQTDFNYmU4VEpo?=
 =?utf-8?B?YmIrcW5nTTh6LzB3RFp2ZEFORUVXNSt6YlZXblhtTWZmUGhvczFFb3BhREZm?=
 =?utf-8?B?bHY5OU5JWVcvQkVJb1Nid0NLOTlybW8zYWJsZWFaQUFVRi92eXExR05wM3pz?=
 =?utf-8?B?ejQzTE5KdURBeVJEazdrbmhGaGduV1lra29iUG5Zby9hdEZJanJQZGI2L0d2?=
 =?utf-8?B?bWhycnlnclYxWDdzQml3b1c2MkNHNk9GVnNIS1ZJSnZ1bzZNMGJ2Z0ZsNGhv?=
 =?utf-8?B?S29xZjZLNko3aExRTzlMdmRwUFdvWWxHdTBLVTJqbWl6VC96NjNUazRJeDlI?=
 =?utf-8?B?UmpVbkg3UUFMUXZtZS9QMlMvZjZTV3BwZy9CRVhheWVFZ255TmEzOEtadlRQ?=
 =?utf-8?B?Mk8vV2xacUFQckVwblRDbVl2WW9UVnMwM0l0UVU3ZWhlQ05UMlZBbE9UMm5B?=
 =?utf-8?B?Ri8vbFJlZ2JHa2lZMkQ3R3hGVkVQTXdwZUpsV0lRakhxclpHbzV4N1RuWHBU?=
 =?utf-8?B?RHJHQWx5Wm1EZXUwakwvSXlTRWYvaGtRUmlCSHJuNVRQSGd0Rzl2byswdkht?=
 =?utf-8?B?eTFTL3cxVWdxalFyZkVZZHI3T1VIeUJJSk1TbDFvcVFNSVdOdU1QVGs4UEs2?=
 =?utf-8?B?MUNoWThLN2JHT0lmc09UL1Qra1JlZ2wxZGlnbERYMGVxQUFpOUF5SmphUy9i?=
 =?utf-8?B?SDliNWI2YUFxdzZNSHZYSXZoeUlsNXZEalhsNUVwcUhXY0Flbi9aYVdnanps?=
 =?utf-8?B?RkRZVUREbG1CZDNzdDVQWDNrVnJvV0V6azI1K2l2YXFTSjRTRkMxSkhEOTVn?=
 =?utf-8?B?M0hpQ1V2VklsLzEwMVg4VTVObE5RbUtTU2diWjJqeko4Y2dwMjJMN3A3MHNG?=
 =?utf-8?B?TU5NMUJ2RmtuWENnNHJOa01Lbk50SEV5Vm9FU2FCTVFpbE9TYlk4VW4zRldZ?=
 =?utf-8?B?K3plMWdSRm84RWE0SXo2bEdpeWFPR0ZyRThiN1VWN1lmdmZuUTdXN0d2eXp2?=
 =?utf-8?B?enpiMVhGcTRPcGgrZ0IzTksvemtPTnBuYWJGQU5oMDlUR3F2OEo0dGRCOWpN?=
 =?utf-8?B?WDdueVNseWlBQk5YRmMvNUxYeUhpY1pUK0lBMFdoSFFsYy9aUDk2aW9LT0Rp?=
 =?utf-8?B?NmlkUFlUODZrc0J4d1VXWkIySGVUdlk3Yk1uREZWM1RJSXNadkJ6WGdoK1Iv?=
 =?utf-8?B?eGJiWWdJaUF4eWozRC9XdE1peEd5TE81aG5sVG1STzhlWU5Ia3N2UUJwSVdG?=
 =?utf-8?B?ejlvY2sxR0hiUEcyYlBRZHd3NjBGSmQ2ai84Y2w5UlY5NDFJY3pBMWM1RkxR?=
 =?utf-8?B?MFpvQnBaS1hXTlhUK3B0QzRCN0NUOFA1Q3J5dW9LSXFUNFpxMjdhUis0MWx6?=
 =?utf-8?B?UXhQMFBxSk5KbTJWRzNiZ2Y2c21HNytGY0c5STRBMUI0SFlhbVErY0lZcXJy?=
 =?utf-8?B?blhGemROSm80aWZGK25weGdXczZKeXN5NFFyUG0xSlVnUndaYXMrZk8wREVk?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5237dd3f-3b4d-42b6-7a01-08db513bbf60
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 09:48:46.0792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1hLpgeKrNNGYjFCd3nndZ+beBf86HHNn5WGGpGbrzjZJjyOVBbF82fa/FSmnx6Uc6q2nLfQoTXYZk+x16pPjO3qIm8oWEbbsAs+J5Ys9Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/6] Refactor mqns_01 using new LTP API
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 3/23/23 11:32, Petr Vorel wrote:
> Hi Andrea,
>
>> diff --git a/runtest/containers b/runtest/containers
>> index 23f394579..5e1b53bfa 100644
>> --- a/runtest/containers
>> +++ b/runtest/containers
>> @@ -16,7 +16,8 @@ pidns31 pidns31
>>   pidns32 pidns32
>>   mqns_01 mqns_01
>> -mqns_01_clone mqns_01 -clone
>> +mqns_01_clone mqns_01 -m clone
> I'd be for renaming these testcases to rename the underscore (e.g. from
> mqns_01.c to mqns01.c). But this can be done any time later.
There are so many tests without convention. We should create it before 
changing this test specifically.
>
>> +mqns_01_unshare mqns_01 -m unshare
>>   mqns_02 mqns_02
>>   mqns_02_clone mqns_02 -clone
>>   mqns_03 mqns_03
>> diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
>> index 1d109e020..61e586c14 100644
>> --- a/testcases/kernel/containers/mqns/mqns_01.c
>> +++ b/testcases/kernel/containers/mqns/mqns_01.c
>> @@ -1,148 +1,82 @@
>> +// SPDX-License-Identifier: GPL-2.0
> It should be GPL-2.0-or-later
>
> I'm going to fix it before merge.
>
>>   /*
>> -* Copyright (c) International Business Machines Corp., 2009
>> -* Copyright (c) Nadia Derbey, 2009
>> -* This program is free software; you can redistribute it and/or modify
>> -* it under the terms of the GNU General Public License as published by
>> -* the Free Software Foundation; either version 2 of the License, or
>> -* (at your option) any later version.
>> -*
>> -* Check mqns isolation: father mqns cannot be accessed from newinstance
>> -*
>> -* Mount mqueue fs
>> -* Create a posix mq -->mq1
>> -* unshare
>> -* In unshared process:
>> -*    Mount newinstance mqueuefs
>> -*    Check that mq1 is not readable from new ns
>> + * Copyright (c) International Business Machines Corp., 2009
>> + * Copyright (c) Nadia Derbey, 2009 <Nadia.Derbey@bull.net>
>> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> -***************************************************************************/
>> +/*\
>> + * [Description]
>> + *
>> + * Create a mqueue inside the parent and check if it can be accessed from
> maybe:
> Create a mqueue inside the parent and verify it cannot be accessed from
> the child namespace.
>
>> + * the child namespace.
>> + */
>> -#ifndef _GNU_SOURCE
>> -#define _GNU_SOURCE
>> -#endif
>> -#include <sys/wait.h>
>> -#include <errno.h>
>> -#include <stdio.h>
>> -#include <stdlib.h>
>> -#include <string.h>
>> -#include <unistd.h>
>> -#include "mqns.h"
>> -#include "mqns_helper.h"
>> +#include "tst_test.h"
>> +#include "lapi/sched.h"
>> +#include "tst_safe_posix_ipc.h"
>> -char *TCID = "posixmq_namespace_01";
>> -int TST_TOTAL = 1;
>> +#define MQNAME "/MQ1"
>> -int p1[2];
>> -int p2[2];
>> +static mqd_t mqd;
>> +static char *str_op;
>> -int check_mqueue(void *vtest)
>> +static void run(void)
>>   {
>> -	char buf[30];
>> -	mqd_t mqd;
>> +	const struct tst_clone_args clone_args = { CLONE_NEWIPC, SIGCHLD };
>> -	(void) vtest;
>> +	tst_res(TINFO, "Checking namespaces isolation from parent to child");
>> -	close(p1[1]);
>> -	close(p2[0]);
>> +	if (str_op && !strcmp(str_op, "clone")) {
>> +		tst_res(TINFO, "Spawning isolated process");
>> -	if (read(p1[0], buf, strlen("go") + 1) < 0) {
>> -		printf("read(p1[0], ...) failed: %s\n", strerror(errno));
>> -		exit(1);
>> -	}
>> -	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
>> -	if (mqd == -1) {
>> -		if (write(p2[1], "notfnd", strlen("notfnd") + 1) < 0) {
>> -			perror("write(p2[1], ...) failed");
>> -			exit(1);
>> +		if (!SAFE_CLONE(&clone_args)) {
>> +			TST_EXP_FAIL(mq_open(MQNAME, O_RDONLY), ENOENT);
>> +			return;
>> +		}
>> +	} else if (str_op && !strcmp(str_op, "unshare")) {
>> +		tst_res(TINFO, "Spawning unshared process");
>> +
>> +		if (!SAFE_FORK()) {
>> +			SAFE_UNSHARE(CLONE_NEWIPC);
>> +			TST_EXP_FAIL(mq_open(MQNAME, O_RDONLY), ENOENT);
>> +			return;
>>   		}
>>   	} else {
>> -		if (write(p2[1], "exists", strlen("exists") + 1) < 0) {
>> -			perror("write(p2[1], \"exists\", 7) failed");
>> -			exit(1);
>> -		} else if (mq_close(mqd) < 0) {
>> -			perror("mq_close(mqd) failed");
>> -			exit(1);
>> +		tst_res(TINFO, "Spawning plain process");
>> +
>> +		if (!SAFE_FORK()) {
>> +			TST_EXP_POSITIVE(mq_open(MQNAME, O_RDONLY));
>> +			return;
>>   		}
>>   	}
>> -
>> -	exit(0);
>>   }
>>   static void setup(void)
>>   {
>> -	tst_require_root();
>> -	check_mqns();
>> +	mqd = SAFE_MQ_OPEN(MQNAME, O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
>>   }
>> -int main(int argc, char *argv[])
>> +static void cleanup(void)
>>   {
>> -	int r;
>> -	mqd_t mqd;
>> -	char buf[30];
>> -	int use_clone = T_UNSHARE;
>> -
>> -	setup();
>> -
>> -	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
>> -		tst_resm(TINFO,
>> -			 "Testing posix mq namespaces through clone(2).");
>> -		use_clone = T_CLONE;
>> -	} else
>> -		tst_resm(TINFO,
>> -			 "Testing posix mq namespaces through unshare(2).");
>> -
>> -	if (pipe(p1) == -1 || pipe(p2) == -1) {
>> -		tst_brkm(TBROK | TERRNO, NULL, "pipe failed");
>> -	}
>> -
>> -	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
>> -		0777, NULL);
>> -	if (mqd == -1) {
>> -		perror("mq_open");
>> -		tst_brkm(TFAIL, NULL, "mq_open failed");
>> +	if (mqd != -1) {
>> +		SAFE_MQ_CLOSE(mqd);
>> +		SAFE_MQ_UNLINK(MQNAME);
>>   	}
>> -
>> -	tst_resm(TINFO, "Checking namespaces isolation from parent to child");
>> -	/* fire off the test */
>> -	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
>> -	if (r < 0) {
>> -		tst_resm(TFAIL, "failed clone/unshare");
>> -		mq_close(mqd);
>> -		tst_syscall(__NR_mq_unlink, NOSLASH_MQ1);
>> -		tst_exit();
>> -	}
>> -
>> -	close(p1[0]);
>> -	close(p2[1]);
>> -	if (write(p1[1], "go", strlen("go") + 1) < 0)
>> -		tst_resm(TBROK | TERRNO, "write(p1[1], \"go\", ...) failed");
> The old version actually communicate between parent and child proces over pipe
> (p1, p2 arrays). Is it all of these useless? I wonder myself what have POSIX
> message queues together with pipes.
pipes were used because LTP didn't support tests result from children.
> I'm sorry if I overlook discussion about it in the past (looked at various
> versions; it'd be worth to mention changes like this in the commit message).
>
> Kind regards,
> Petr
>
>> -	else if (read(p2[0], buf, 7) < 0)
>> -		tst_resm(TBROK | TERRNO, "read(p2[0], buf, ...) failed");
>> -	else {
>> -		if (!strcmp(buf, "exists")) {
>> -			tst_resm(TFAIL, "child process found mqueue");
>> -		} else if (!strcmp(buf, "notfnd")) {
>> -			tst_resm(TPASS, "child process didn't find mqueue");
>> -		} else {
>> -			tst_resm(TFAIL, "UNKNOWN RESULT");
>> -		}
>> -	}
>> -
>> -	/* destroy the mqueue */
>> -	if (mq_close(mqd) == -1) {
>> -		tst_brkm(TBROK | TERRNO, NULL, "mq_close failed");
>> -	}
>> -	tst_syscall(__NR_mq_unlink, NOSLASH_MQ1);
>> -
>> -	tst_exit();
>>   }
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.options = (struct tst_option[]) {
>> +		{ "m:", &str_op, "Child process isolation <clone|unshare>" },
>> +		{},
>> +	},
>> +	.needs_kconfigs = (const char *[]) {
>> +		"CONFIG_USER_NS",
>> +		NULL
>> +	},
>> +};

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
