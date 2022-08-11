Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB0DC19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 11:14:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B7883C95DC
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 13:14:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3525F3C0294
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:14:10 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140081.outbound.protection.outlook.com [40.107.14.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 039176006CA
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:14:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnpcpLt3nA2rcIneksY0HoBx7V8MH2sFLLX4rAJsD0MbKDv2UCepOQSTyPA6Oyu5RP1ODkbfAnO+JuejLFxVRqml7Oft1282a7wfpRw7lQ9oJzr5izyRj0dWD1AlLj33RC7ibaOxMc1Uw5aVJtQSdvcsBrQkqjsuo8caiRY22Gd1+CoMR1nhiLty9lNmX+ynVM16CH6N59Pak1VV3S7amquJMsDiamcX2RWkGqbgPpGKTBD2OBWT3SiZsvjCap2viDMntZpK4hbVhq/D4LvCQjCe+s/UXxIfyiskZfU0xKhuicwtOgPP3XNUb6d4nYYWNHo0+llQIPEJJi99va5YtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNereVHsWQWQIYn2YIDveU1n92rp0lJGhG7l9aSB0Z4=;
 b=iikgKx3C7dlL9FBn+r/Dw4kp3HFUTWT5wgmPqu9d8k4WMR1U0OYXDUFXN/iOsBEdMeOHIssjOJP2HXNDsqfufdRtZ8SoZl9igQlXU5R3KOV/bbRQnd159fYrsK78cGjzDqWh1axJpfZ1Y8V3zAJu/tJQtRKv0Jb3WtHaJOdUC/XJ+PJY8GT8qT64ZyxvCfsK051tmHaJyUH+POc+tK0Cssf1pSVPFaMO32v3G6YjPiA7vjsHv+6SPu1ZCysGP8Eb5GvU8cZEMNX+VQ5HCTpytOFJJxCO6dvElPlDCg/4sRTwAnS2rwt3blIqGI/SjjDaL4wUOwGJc51ByL1fUQUpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNereVHsWQWQIYn2YIDveU1n92rp0lJGhG7l9aSB0Z4=;
 b=vRlIl4qo26UkzLjuhYdUTG+ODp5wFojt7FQYW0A9v+sDjfMYbu0F0Z6Vz1STvGnMrOwd14HGvXoYoLtGYTg3Ak08ivp8EXWb6IMZJPIl3Znq9pAZwnavsI3sQ1R3Mln7rRiJE0Xo8J5Z39xM5KSlJ5l21EjgoVCKbMrWIGERrNSQPPu+hyIGtJy0k51C3dKjuOjM42tN4hR1W9TUgJF0qvT9y0Z/lLs3ri/yNj0ocySpzRc3/PqVSnrk49G5L85vGt2MLgycsz+/+k9pB4td/2Tn3EmjOGPq8n153o35akORJ55sEbUGVEI7zYGncO19PvIRRdqe6vuXqiRb6WraAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VI1PR04MB7054.eurprd04.prod.outlook.com (2603:10a6:800:12d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 11:14:07 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b%6]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 11:14:07 +0000
Message-ID: <945eb0ee-b346-5729-3dda-4bff39bb52d9@suse.com>
Date: Thu, 11 Aug 2022 13:13:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20220722120501.28670-1-andrea.cervesato@suse.com>
 <20220722120501.28670-3-andrea.cervesato@suse.com> <87r11nw0qv.fsf@suse.de>
In-Reply-To: <87r11nw0qv.fsf@suse.de>
X-ClientProxiedBy: AS8PR04CA0199.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::24) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59f653fa-8154-4598-1539-08da7b8a9b75
X-MS-TrafficTypeDiagnostic: VI1PR04MB7054:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZIpuVq2DIMzV9JPZRbnUu+yoMzI4+DArr3fwlhFH4vACBtimQqxP9uFzUPpFAAQ0G9MXiq6H5k+DYnKxml2rUDRe1VuB3gfnWr1k/PniVBodXfddHvHIFKVgDsVurA8bWaj+XzKaHOpkpR+xLOj50ZFf7seetnjamUb6qrKa0kfqK26P/mmvQ+8ssY/UaD/kZ2VksCt53B/RScsy6qR20IhVeO5dykX2iRsY3eJWVkc1eWHgO057gF9199HWwU0aKvM4XaiaYpXOwwiNMu5rJAqUn4anWvjAhjlV/bE3kBDsnSmsmL8yIAHJz1fTu/U2e0vxa2oy8DMNBe9pMT7QimMl5BaPnjo+vXz4aLJH5nCmK+Cvp/C1/qTSbC0B/hsXVAr1NR19JfLOkzh7W7jdNAQ6hSahPV4H95JiUYjPAmYlgrzAvkinmqBRX/CmURJu7pky1IQnfa2afPGu2F4QzpxJue4+qgL0OYBUS4EQwowTI3Bqvf6X4ttABGoAbQLKmd6X383/fd/8tWPzkPyvNqXT9wVZpwbTdF5FKZbfxPU1tfTssJT9D7QCX6J6bjMjg8lfUzAk45tzigljrpxl/D85SRqvd3Y8GDFjdaXAeQHzyyYHWC+sTPO0N85aeK9IBj2adXSKmDw+DYYVlXDr4WLYDJcgdtBU8yUKhs5a1eS+4PcV53yck1hMZqVBr3LvVsdLKsJ06OlQsh3VKwTZId5jeRyXKuFqv+1LzMmmeiFul9O/EUpDdHTiBntUGWngm4hUyvbfhBEEuqsyItS+zKQtyQQ0/+CTS+4Liymgx02L/YFUKSjen1CLILnMmkv+yWjr/zR6F7ZxLczq1dr3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(376002)(136003)(39860400002)(396003)(366004)(346002)(86362001)(31696002)(38100700002)(66946007)(8676002)(66556008)(66476007)(4326008)(2906002)(316002)(6916009)(44832011)(8936002)(5660300002)(6512007)(6666004)(6506007)(26005)(53546011)(2616005)(83380400001)(186003)(41300700001)(6486002)(478600001)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU5ZMElzemtDdjJlMHZjbVdhOVhMTC9FVHdmRXpleE5UM0YrTUhwbmRlUm9Z?=
 =?utf-8?B?MHdXd0xBUGtHdHp6ZDQzK2NXM3M4UmFPdlM1TjVpT2dScXlaZXlYSTYzSWJI?=
 =?utf-8?B?K3Byb24vSTRwK2YxMURhSnNGVnI2bFVza1hNZTJFSXRRQlFrb1pLblVscVhs?=
 =?utf-8?B?SHMyTUUzdEJFTUxtVnh1aFl0dGI2NnFDN1dtcGR6YjRDWXdsZndIeC84NHF0?=
 =?utf-8?B?WXRyWmdyUVpraWs0WWNQQmZJY2QvRXFVQm1lRUlkRUdLaHd1emRtckNKU3B4?=
 =?utf-8?B?WnlkMTBWa1V6RllEb3BOYjBLcmFEZWJ1ZXdabUN5SG9pa0QyOUZnK3c2S2s4?=
 =?utf-8?B?MGwvb2lMWCtPalhueDZoeHJRbngzSlBycURNcTVuVHhDcmdrTTNRN01zQUFs?=
 =?utf-8?B?cmVva1hhZDVPZG9pbHBZZmpSTzI0Y0VsY2NVenRsamxmcFAvQTkwQU0waWVT?=
 =?utf-8?B?UjBzZ1c1WWh0R2NHMHZPZzArQWRzRERmUzUxeEd3U055TlhGS3JZdUhIdm5W?=
 =?utf-8?B?K3JGZzZ6Z1lFVEM4WnJNRWJUTDJpbFhvbzBycEZPUjd0Q3RhaHNpRnZ6ZjdF?=
 =?utf-8?B?MkZoZGRFRTM0WVFiaEk1TVR4VjhDR0RRRjFwU2VDRXRPOG1wbEpWM3hjbkt0?=
 =?utf-8?B?NkZybHJZRjNNVjZzWVYwNWFoN2orWkJKbFBXTjZ0bExIZHlBSWM5RXRmaVdE?=
 =?utf-8?B?a2czQzRGQ3E1S1U4ajdHSThMdnhKZHJHdml2UUxzbUdBWFdqY0dXUHdPRnl4?=
 =?utf-8?B?dERuaFFVTlB6eU43aFBsL2k3TE1ja2d5U1UvYjd6K3kzZUdIaElFdGhFZHAw?=
 =?utf-8?B?ek9vR3YyQ2NkNk16QW9UaVQrVVcvc0RMNGpHZDFQb3hqYS9STG9LN2RhNFdG?=
 =?utf-8?B?UVBpa0ZiTjR3NGVNUUVjQzZPQ0l2ZEdJYjE3cDJTTDV1b3BXaVJjNHl0TEND?=
 =?utf-8?B?OUUvZWExTFpnOWRHdE5FY2ttakFKaGdCS01ibDlBM3lPbG9IMy9weVRSTnJO?=
 =?utf-8?B?bHdMSFVYT2pIMk0yRkdRWDNlaXYwVlg0c1F6OG1GdkoybVRXOWNkc3BFcUJJ?=
 =?utf-8?B?cFZoazZkNEZTNThRbEpvalc4SWtld2d0aDdaSERFYW5FYjAwbWlzUFhieVRu?=
 =?utf-8?B?aFFsams3WkxXSkRxUElNaE1wS3krOUMwTWdVbjY4eDRPOU94Z0EvVnhLMmpP?=
 =?utf-8?B?QUl5dWVYd3EwalN5MURtZDJZdzBndWdWV0xzMGdYYWE3cGszRGxKVTZCY09a?=
 =?utf-8?B?SkFxaTFiSkx1emlOWVFUWEt5eTJZUmNzbWFVWDlUZEVPOGkwUzg2T1JDTUMw?=
 =?utf-8?B?ZmhUaEpiMGVpcXNVQ0x1WTJvWlhmMFRnZ1VjMFQ3MXZoM1NpRUwxbDZ6VUlM?=
 =?utf-8?B?TVpnYVFzUTBzamNMOXRCdkRLU0JQdWJueVdJRWVpRlJOQVRnbmV1YmJ6U2Zq?=
 =?utf-8?B?c01DYjRSOWVkTzcvajBOUFFlYVRUc1E0Qy81UnA0STBOdUszaWt3T1ZIZVpP?=
 =?utf-8?B?b2wwSVVudDd5b0NXMVlYcDZXZHdlRU0zQzBvSGI1RGF3TkJHUWJaaVJuYWVx?=
 =?utf-8?B?ejlmL3l1YXJnQkZlYkJ4bS9xOXM2aHhXK0g0SlowNjBDcGIvTTlPT0NLbVpt?=
 =?utf-8?B?SXlyOVc4c0s2SmczOG5KQ3pFMGVlUkQzTk5OMWVqYkVzazBUTEl4TGdiOGhx?=
 =?utf-8?B?MlZmYVdOYWVZQUliK0I5dUpVV1lUY1drMXdZVXVMQVB5OWp5QXpZQXhubHVY?=
 =?utf-8?B?dDhJbndSZEdjQkgrWjdzdnJUaXhISWQ2aGlpRDRxTGV2NXkwK0xrSTRlRy92?=
 =?utf-8?B?L3Y3SnFiY0lJTFdvK05jQkh4cWtiOWV6VmtId1ZNUCtnaUNkVi9IVDdzaWVs?=
 =?utf-8?B?YVIvMVpINktqV1FNRUMyTldmTTJiS3Z2Vld6V3RmazM0UDMvTkdRYWlyYnpJ?=
 =?utf-8?B?VzZvcXI4YUxmWFQyd2hUZWhpdVpsaEdDMUs2UXFVN2xZckxDYWNjSDFPVFBp?=
 =?utf-8?B?OG5oWDZSSWtpMXBIMXZXdDR2aDd1MUdNOGlLRXhnaGhYUUkwbFVoQkcrTTdD?=
 =?utf-8?B?SENFekdvU3hyV0hxSDNUckI1T3EyWTdoT3RLakt0UThEZWRrMjJQakxkaUtw?=
 =?utf-8?Q?09Sjq/51LRg+LsgyWv/rR5C7U?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f653fa-8154-4598-1539-08da7b8a9b75
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 11:14:07.1597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kv+V1KQAuWe7Z10iEwGBTGxboZuE7/Oa41tdsNkaoeujrKBJZzWH+438Emf9oyjH8KjfgcWw2PJnn/L+dwqdNBxarao+RikbL2Phas30fPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7054
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/7] Refactor mqns_01 using new LTP API
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

On 8/11/22 11:53, Richard Palethorpe wrote:
> Hello,
>
> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   runtest/containers                         |   3 +-
>>   testcases/kernel/containers/mqns/common.h  | 101 +++++++++++
>>   testcases/kernel/containers/mqns/mqns_01.c | 193 +++++++--------------
>>   3 files changed, 166 insertions(+), 131 deletions(-)
>>   create mode 100644 testcases/kernel/containers/mqns/common.h
>>
>> diff --git a/runtest/containers b/runtest/containers
>> index 2637b62fe..863a964ad 100644
>> --- a/runtest/containers
>> +++ b/runtest/containers
>> @@ -16,7 +16,8 @@ pidns31 pidns31
>>   pidns32 pidns32
>>   
>>   mqns_01 mqns_01
>> -mqns_01_clone mqns_01 -clone
>> +mqns_01_clone mqns_01 -m clone
>> +mqns_01_unshare mqns_01 -m unshare
>>   mqns_02 mqns_02
>>   mqns_02_clone mqns_02 -clone
>>   mqns_03 mqns_03
>> diff --git a/testcases/kernel/containers/mqns/common.h b/testcases/kernel/containers/mqns/common.h
>> new file mode 100644
>> index 000000000..92a77b566
>> --- /dev/null
>> +++ b/testcases/kernel/containers/mqns/common.h
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +#ifndef MQNS_H
>> +#define MQNS_H
>> +
>> +#include <stdlib.h>
>> +#include "lapi/namespaces_constants.h"
>> +#include "tst_test.h"
>> +#include "tst_safe_posix_ipc.h"
>> +
>> +enum {
>> +	T_CLONE,
>> +	T_UNSHARE,
>> +	T_NONE,
>> +};
>> +
>> +static int dummy_child1(void *v)
>> +{
>> +	(void)v;
>> +	return 0;
>> +}
>> +
>> +static inline void check_newipc(void)
>> +{
>> +	int pid, status;
>> +
>> +	pid = ltp_clone_quick(CLONE_NEWIPC | SIGCHLD, dummy_child1,
>>   NULL);
> ltp_clone_quick is still part of the old API and only uses clone2. I
> think it should be replaced with tst_clone. This may require extending
> tst_clone. In fact we probably need a test variant to switch between the
> clone2 and clone3 syscalls when using tst_clone.
>
> I'll leave it to you whether you want to try that and rebase this patch
> set on it.
>
I see ltp_clone_quick as wrapper of ltp_clone, since it's using
ltp_alloc_stack without calling it explicitly all the times before 
ltp_clone.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
