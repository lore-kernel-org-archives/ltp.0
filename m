Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9612BECAAA1
	for <ltp@archiver.kernel.org>; Fri, 28 Oct 2022 08:44:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E13833CA96D
	for <ltp@archiver.kernel.org>; Fri, 28 Oct 2022 10:44:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B8353CA863
 for <ltp@lists.linux.it>; Fri, 28 Oct 2022 10:44:25 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E05C01A01162
 for <ltp@lists.linux.it>; Fri, 28 Oct 2022 10:44:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5P17zDIMqcI8gizMDHMJtrT/1mKA2cPQ3Bf5A+Vvrn1cuOPDcnHwbq/nkCTjKpkaCcSt9jo+LA9DcMw2Krpk8jqvqiBCknaBt+9iatYbPK2VLjMnOl8x9So9tenDt16hMAXEtT7dXEZ4+Nz22LYrpn0ihuKQQNhDnEx/bMYvnmJOfHXB8u47kNh2XLGHiqKxLG4hFWhRYimGVPeixVXopjgAVQaQausjdt1TfyB3TIFaXpQJzVwoMCNpjs8NTWlaJqvFKWFIUTIibVtziMXy1Q1C/x6mFqO1uv0RKWGkmAHmXJHv1YQoGpvx7TRKoKD20qc2gRTfW4eItrW3H95Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAkdDg6YbgHKuR03b6VysgmI9vpAMfTwzym1NIU5M20=;
 b=MiuroEcquByBoNSgcVcUHE3gf4oIAhJs8TzmOi0QlOc4RuObT7JKMu1il++RDnbfvEZNjcvTHCVInMMMnljlpRJBn+h/B2fq8KoCO8lV12pypRnGhgPX66GGDyj6ydEO3WhEWHLV4VHYaMoIBgxB2D2qMwY5FKNc8NjyMkACbBBkpvj2KG1Ut3AqG/KMfKNGDV+QhhFPRv4TbG4mMbY4trL8QF7Z6n6Yn13G1oQhcr0X4R8rOF5ArEb/VSIG3vrD8kdAnKUeimsAqatM3S1aAXxNv7JvxCe5dYe/AnTxCz5uz45tAYOtgmVhCFr8iKMhmggouc0c+Zw7mR19mt9RIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAkdDg6YbgHKuR03b6VysgmI9vpAMfTwzym1NIU5M20=;
 b=x+qbiXu+JQP0IzPV0hjvLZVm7AIjDTP/iYI5NYe8N3impfaXlDkbvrDEXjsjh/oQibhY3reanwAhVXbyOU6MtIqOmtR5LPpVct13UvJt6vq9RI3SdAeCok9i1odocCy+9jNLXXlIvG3l3SOdakztlSpAlkm8uZAx0AvW6WB0U/NnZu5AhzEE6dOlvIvNs6LakKjvGhtX7Mip/ORduUDoCJJOMfKSUzjCZIaLHujHQTy2RXiSJwlsBV+gZYZbIMH7+hv5eJmAcNXwl52s1sYGaOa1FY79k23x0BhFPzW6zlY2pJe6Os8kX2s8zQ0cjQAhIbVyo32H7xwlojCOO4PxSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM9PR04MB8780.eurprd04.prod.outlook.com (2603:10a6:20b:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 08:44:23 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257%4]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 08:44:23 +0000
Message-ID: <1249c30a-6d02-1e2d-4706-ea58b2495d6e@suse.com>
Date: Fri, 28 Oct 2022 10:43:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: rpalethorpe@suse.de
References: <20221010145243.3133-1-andrea.cervesato@suse.com>
 <87h6zyvm7w.fsf@suse.de>
Content-Language: en-US
In-Reply-To: <87h6zyvm7w.fsf@suse.de>
X-ClientProxiedBy: FR3P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::19) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM9PR04MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: bce51dc2-b69e-4b78-bc8e-08dab8c09cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bpk9ABt8xaHfb1aVQGuVB8duc/CQw4ZzliX3K/+d5tITyw19GM9O3iOoAeVXvvnpT6tdKujKTs/o6OZALs0bnUDGV/9Kv0AG7Uh1jcETDFTmVn9Z1UfzWdITfjLS22a0KvvQldrzxbtZmL4cvRjf4u0RhBky0H8scgcFOVJiPkUJ/yYE45+mOzsF8dPVv5/1+yGPNrAboG3Vdsmas9VArTkwGPBWi2D9IYHjhmt93qwfv/yy5kwEy02bh9xJyxxJaoeCT22rUQ+uGg/em/6gJlqGyQoogFdrtnp/QmIOLWhYls1Xy7kUVcthCc+dAyKjhUrR7AfhcqFqylyWROkU0NpxWuhGSxifmaVhCkRkWjeN69wwstL7PLkwID6iVqS8abTz8k5vTfZ4kGHeImZlP79DpVRq/9QlQToe22b7pz/Yc2q2UsEVtN9ZcSOUN9h/3dRfTI/WjVDYhkjAL6jYcKQje7rl5E0OeM7mdbvBeiZjXSm7K4jno4QWZtAQ1Ak64IAeMxk62evMUZ4BH4ge0qHclwBZCvmGfkdklgufoZrvsYTlkgO2hG5HsVJy1Ym/AR65Tel3Lb8kUtQbnDcmjmGaDYAlOhCzAu9V4tCEb+Uh+gSUCIRo86De6SwycqT7y23cCX2P07+JDlKjAhFdJETVwD8vVwuMwq3rgpJqALWVXpGO7B+ZaUsfsqnPus3fJDZPiTv0e5smVihEK7WNV+k5TPyibloJogqchz/oOsumZeexNaz41naKxmTnmRr7Q0cJZNL0xM0E2izb/vAl2OlRF03u3UJ4W17GUtb7S6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(8936002)(186003)(4326008)(31696002)(83380400001)(86362001)(38100700002)(5660300002)(44832011)(2906002)(8676002)(66946007)(41300700001)(6666004)(6916009)(6506007)(66476007)(26005)(53546011)(36756003)(6486002)(2616005)(6512007)(478600001)(316002)(66556008)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWV6b2RoSzVwL1l0cUZDVFRGSHY0ZFQyY3RyTXlIQmxEQ0VqZ3RXWDhENTJx?=
 =?utf-8?B?SDNiT3hVMTBQMTJYSDZVeUdnZmJiQmJNUlN5aHg5UjBEeDBkNmI5c2ZtRXRU?=
 =?utf-8?B?SVRkUzlodEJoa3hjTFIvN3JvTkkvcEtjWU5TSkdmbkVqMHVON2xCZDJueVFD?=
 =?utf-8?B?V2hVWmNreHNPUURTNEVZdk9OUGhablNDTStMMU43U0J1WVdTN1B5cGlTMmF0?=
 =?utf-8?B?T2VZNURZT1JjK24rbUN5ZXZUYXZEM0dmZ1p1Z1NUWkF2Tjk5TWFRVW9abDRr?=
 =?utf-8?B?aFd6Um5ZS3VVblZMMUR3V25GeS83NU9hbXFvY1hxMGQxU2ViOUp0WEdwbkhk?=
 =?utf-8?B?RHNOSnd1Z3I2UjIvZnF2L3hJWG1wS3cvSnNNQzJseGcrTE5TejI5bGFhUnha?=
 =?utf-8?B?V3l4dW4yaHlwblZCZ2YrcHpESGpYOTk4U1Fzb3d0V3dnYThIeFBzK0NQT3Vx?=
 =?utf-8?B?SzQ1Rll5eFUvalFhTGs4OHJGd0syOWFXaWtHaWV0TzhlczlEcERYOEV6eGRm?=
 =?utf-8?B?T3RFTHFURmJGQkFlS1BPZ2tHMTFZM1pmL09nV2xlN2MxcU81K21DMGU3Zjd5?=
 =?utf-8?B?S2JtQzB3VmtpbU5HV1NEdG5idWhHVjAzaUdFa3NYS25RK0ZsMlRLOWRDNzZr?=
 =?utf-8?B?TnlTRXZTRFJ6YVNhSlJRRnpaOU9tS0VFclYwMVRSS25YbG8wTEI3MnpjNStq?=
 =?utf-8?B?dEcvRnFDeUNEL2s2QlpMTDZQbE5WYW82VW93RjAyNUVac1hwQzBZclVUcFJN?=
 =?utf-8?B?anB1Y1RMd1dTKzl6VFRRbHd0UE5oS1lFODdYZ0R2TUZKNzRiK2laNEx4Yk93?=
 =?utf-8?B?VjVtY3NrOUN6OExSdmJTalFuaU1zNHNQSkp6WkpOd3A3RktqMkNLd2lESU8r?=
 =?utf-8?B?U2tURzRjd2ZKWFMveWNNSjhkc0hOV3hQbGlGMXhZK0M2RTQyRTN4alFhWkc1?=
 =?utf-8?B?ekhMSnc2MjhXRkNMZkxabmhxME5ZV3o2ZkZxdG1LYVFiQVpjeXEyaVFkQUxq?=
 =?utf-8?B?U080MENVenZOUURWMkNEaGJ4blI0aDRid3JWelJ2QWloUmFxK0xDYmVMYzJU?=
 =?utf-8?B?dm5JT0Z5R29zWjJhVldaRWtiVkdPNXZ5ajNjNC9NZVRibVRLSDI2Sk1mK0Zv?=
 =?utf-8?B?ZWIrbURFd3ZKanloMGxJT1ovK2RVQ29VYVYyRzhnRDN2dFlEbjJPTFE3ejNI?=
 =?utf-8?B?Ukw2SnFWZWplOFJYVFRhRXppN0lMMWJGcEEyYnZqaHluN1cvRXpuUjNaNmVM?=
 =?utf-8?B?by93ZjI5N3FrSmErMlEvclVaWW9vSGEyYUJPdkR3M1drenI5cG05Sjd1TWxx?=
 =?utf-8?B?eUhiWngyckh1MTlJVnNuNEFEOTZhdjlXYnBRc0wzVVFGVjM5UHlMRnpydTdI?=
 =?utf-8?B?cGhoR1BPWkl5amQwQThHaGNuR1ViNHluVm1hZGFRMUQyanNTWU5oT3RUeGlp?=
 =?utf-8?B?MjQxSW16dnprMmFiTkJsSkxGbzlJYW91amd3bzBmNjUya3Z5OEc5VXhPRDhi?=
 =?utf-8?B?QUp2eHRFUk1MUmJpNHRsZUdSRTZib0xJa3gxUjA5UTNCcCtsbTM3Y2xLZUNv?=
 =?utf-8?B?MWJ2TVVBeWNwNEJIUUd5aWVKNnFkcnhMS2ZKWlErT1Urd2NlNTBweitmOWZY?=
 =?utf-8?B?QkUxSjJRcXZ5anpjLzMvaGNxOGtUc0tXSXBKTks2WWRpQzk5Mm9tN2U5NDZF?=
 =?utf-8?B?SlkwM0dxKzRITjgwYW9QeDhNVHRzY1FtQUEwZzk4dnN1SlQybHFFN2toYWhw?=
 =?utf-8?B?NktQQmIzS3J0VU5MQ0U1RTZjNmRjOG42emQzUUYvYWZrV3ZZZUx1bHRLRnV2?=
 =?utf-8?B?UHZBWVlyWUFld2w2M1VTMHFFZ1Jnd2N6YUlMTFZkcmV2TTJaVXByR0dTTWFJ?=
 =?utf-8?B?TVkvc1JlQjBtWU5YdXZMaG83V1pXOXVOOVNiZlgralBFS2ZTM1hDcm5hMHhK?=
 =?utf-8?B?U3FXZHV4T0w2ZVQzOFUzRXJwZVhCRU56THdvbThubjF0a2lwbm14OVM5SkNL?=
 =?utf-8?B?YktaM2k0a1RsOVVCR3RPOWhoUWlBRFVGQ1FtQ2FmMTE5ZHpPcVhZS0VRMzVQ?=
 =?utf-8?B?V0lmNTUrS1hDQzV1bldldzNXU0RJSW9GQTdmQnplQk9IanE5bGdKV1hWbFBH?=
 =?utf-8?B?OHVTVS9pOEgvUUt2RGY4VWJKT0NUWTVmSi82QU9GaVBMQnMrNno5dGtOM3Nj?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce51dc2-b69e-4b78-bc8e-08dab8c09cb5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 08:44:22.9983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDIMj+/oFzO5avESt4J9bl/Bu/DIOw6QpHR6eeAcK3tl0zE78Cp0CTJnAcDFWDpnA5iY4H6ipsLAzmhpIOJyHmwDRzm4iPolVt997knCXTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8780
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add epoll_wait07 test
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

Hi,

On 10/20/22 11:27, Richard Palethorpe wrote:
> Hello,
>
> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>
>> This test verifies EPOLLONESHOT functionality.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
>>   .../kernel/syscalls/epoll_wait/epoll_wait07.c | 86 +++++++++++++++++++
>>   2 files changed, 87 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
>>
>> diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
>> index 8c5ed7c5c..66ac18ae2 100644
>> --- a/testcases/kernel/syscalls/epoll_wait/.gitignore
>> +++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
>> @@ -4,3 +4,4 @@ epoll_wait03
>>   epoll_wait04
>>   epoll_wait05
>>   epoll_wait06
>> +epoll_wait07
>> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
>> new file mode 100644
>> index 000000000..760ab6c10
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
>> @@ -0,0 +1,86 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Verify that EPOLLONESHOT is correctly handled by epoll_wait.
>> + * We open a channel, write on it multiple times and we verify that EPOLLOUT
>> + * has been received only once.
> Without EPOLLONESHOT or EPOLLET, EPOLLOUT will fire constantly on a pipe
> who's buffer is not full. Writing to it will have no effect unless you
> listen on the other end for EPOLLIN.
>
> So in this test you don't need to write to the pipe unless I am
> mistaken.
>
I see there's not a real difference between EPOLLIN or EPOLLOUT in this 
case. We can listen to EPOLLIN, write to pipe stdin buffer once and call 
epoll_wait two times. The result will be the same, since EPOLLIN event 
has been triggered only once. We have many options, I choose the one 
which forces two EPOLLOUT events, but the same can be done with EPOLLIN 
in this case.

To check, you can remove EPOLLONESHOT flag and run test without it.

>> + */
>> +
>> +#include <poll.h>
>> +#include <sys/epoll.h>
>> +#include "tst_test.h"
>> +
>> +#define WRITE_SIZE 2048
>> +
>> +static int fds[2];
>> +static int epfd;
>> +
>> +static void cleanup(void)
>> +{
>> +	if (epfd > 0)
>> +		SAFE_CLOSE(epfd);
>> +
>> +	if (fds[0] > 0)
>> +		SAFE_CLOSE(fds[0]);
>> +
>> +	if (fds[1] > 0)
>> +		SAFE_CLOSE(fds[1]);
>> +}
>> +
>> +static void run(void)
>> +{
>> +	int res;
>> +	char buff[WRITE_SIZE];
>> +	struct epoll_event evt_receive;
>> +	struct epoll_event evt_request;
>> +
>> +	SAFE_PIPE(fds);
>> +
>> +	evt_request.events = EPOLLOUT | EPOLLONESHOT;
>> +	evt_request.data.fd = fds[1];
>> +
>> +	epfd = epoll_create(2);
>> +	if (epfd == -1)
>> +		tst_brk(TBROK | TERRNO, "fail to create epoll
>> instance");
> Same as other test, please use the SAFE_EPOLL_* functions I just merged.
>
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
