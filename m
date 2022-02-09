Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE63C433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 08:39:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A0A83C9B6D
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 09:39:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67F7E3C23B0
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:39:43 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 512601400055
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:39:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1644395981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uxEwfeQy26gV44dz62hl9FVka56b7rp789LuE4C+9zY=;
 b=FhFTYLqsJ474Ovy03Eg3Yh0pbZltjOjnbjYnsO0PM9gWNH0Rr0zFtvOFrd86WJr3vTR+pF
 kWK0dAdjIh8o9mxPG/inBGTFZ/gxg349JVHz2jTxFqupqh1DoWD3ohXEIyJaKWUezexbba
 GcGTK27LI+oqnnNw/xK32AiIs64wo+k=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2051.outbound.protection.outlook.com [104.47.1.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-kOqu6SL-OJi9NzvLyroIRw-1; Wed, 09 Feb 2022 09:39:40 +0100
X-MC-Unique: kOqu6SL-OJi9NzvLyroIRw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+h8qyg/eM0WrZza8lORLz7HHXP9MHnQhzbcfRg6Wi86tgBWBD4I6YGBYGQc4gzaqrT4L1PvLKMYyQK/A2fKIH8HGntSOFkUHcCmVlmHEoBGfk4DW+JpU+HaXkBOVc7ux1NTnzmwpGvmvdXcSPr+3uenKhv35hW0OTYiEAqAMhmcG1a4LO2UlTJP+OiI1aUVByRStNZ4jyaUpTnyfSwVsgxKPzNGeAbw3leBCEJ9AEAYSxA0ZnQ2ujP7szM0W4LqunSTPnMwdwXMFctqi+xsRKHl0RXiY3KPc8Ur+n28MlqgURLqB920v7/YY0I6707b7iEM53JECgTZt9LM4DpxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxEwfeQy26gV44dz62hl9FVka56b7rp789LuE4C+9zY=;
 b=T8qKIZIXCP42DQujEQ38S+oUjbmCV67hFd1fyLbtAqdMeQoH7N0c7jeyzZd+hEhgWuyf2dlmg0xvNs43v0kHo+KyfyIKIWCy54hw3UOwtvLGtDIy80SF59HBlHunjP/X+pk4oYKyqvFWFsGA5dEdtdUPaCSVBLYfXo0DbgPYjzrT68RbPsGlpS8oNo/LmrBUNgQSar8+0vF0R2MCBPTQDM3qH6+ORg6PCRqxT6fb48f4jhZCZJeuUb3bKOLIy2MfZd8RecPQXfdw4jKMwjPFyuYfPUzRY2+pQt0aZurwdDWd2si1FJig21FiJHP3uTsixQE6invb4fu4seTGcyywAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Wed, 9 Feb
 2022 08:39:39 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::69ee:ea32:8cf8:2e02]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::69ee:ea32:8cf8:2e02%4]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 08:39:39 +0000
Message-ID: <3980d9c5-6d05-5974-8bab-ae52c2e96307@suse.com>
Date: Wed, 9 Feb 2022 09:39:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20220207144148.27033-1-andrea.cervesato@suse.de>
 <20220207144148.27033-2-andrea.cervesato@suse.de> <YgJPeBY+B1H9aq80@yuki>
In-Reply-To: <YgJPeBY+B1H9aq80@yuki>
X-ClientProxiedBy: AS8PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::26) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dcb1a19-a182-4206-4a1d-08d9eba7b578
X-MS-TrafficTypeDiagnostic: AM7PR04MB6821:EE_
X-Microsoft-Antispam-PRVS: <AM7PR04MB6821AF1BE893E3E1D05E0EEDF82E9@AM7PR04MB6821.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCTawVWhNu0Tsex6OpHlYrGOlwEHiHyvApJf9KuMgwtY91SG82nSQBt3grefsBXcxj6L3GvVUzEKs3em0kedhdjquyoGSsQwQ1gdwkIFmJeptOHGt9LFNU1r9OMF84ZpULdsaDFLq1/QLA88aiBjy2fpwajFPL8XRZqT+hUx7wsqUr85+rFjiPbCmi6oJc94Epyn/B08sKHpPuJi+fNtxwL59kqYSwk2moYd7ZoIJSiYupfbrrVCINHaVGN0CrqC5z+ihEntkFs3jT5PSVL21+v3yUzsJAuyJ+R/76z37F7twp6AKGvmQ6wbKT9EKXZfKHwJCAI5ZwewkxpSc30lW3s9dqNbUFxMcf6iA3W5b441hQUMM8w0bJku4kL2KPODLLR2QFhQlpHnVMCUGFFINnz1aK1V3Nur/TzuzcLz1hkJs9j7VfFZfFnkh5FMiA35S5Tz7LCqEfQdgqxXhMzD5Wl8Pyw+h5fFBYjeo42b0kCBItWx8eA++Mq0jUrbOiTcgGWXggAgNPN/fmzLe/KH7f0Kt2bPF1IgBW3vaFtwfZhrddMzkNm7lP/xfAJLPD27fJrhioWHYXLQqIztxNjxbVsW1+xAkHOb6jr2sMEVVWwzgXQPAt3ya6rZsRpfr/JJQZ+QBlZf6ilhBIaTt6tf8EGhB9T0eVnwQiw9bA+cAdLk/ppz2bfCbguHGH4jzbBO/3I1EVBc6yaF2cEUxXFHh3a2h+RPvzFWZKpPbGM3chM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(26005)(5660300002)(31686004)(186003)(44832011)(6666004)(83380400001)(38100700002)(6512007)(53546011)(508600001)(6486002)(316002)(31696002)(66556008)(86362001)(110136005)(66476007)(4326008)(66946007)(2906002)(36756003)(8936002)(8676002)(33964004)(2616005)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGY2b1k4ZkJVZU1HR1VRaCs4ZXNZaFpkajJzMi8zSGo1K3hUU1RWMGlNaEpr?=
 =?utf-8?B?emgvYnFXTXVFOVZVVlJpcnQ3eUZtd2F4eVZSb25pOGR3UklhS0k1djVWbmht?=
 =?utf-8?B?Z1p5QlU2Wko1VmVDTFkxOWNSWnIyUEM1ZEg0V3dOOUFlT3Fubmx4R3NLOFpi?=
 =?utf-8?B?S2JZanpwNUpmd3lnOHd2ZklBZHBoc2xwSGs3bzJVMnVrL2NLUk5mY0t4dUhh?=
 =?utf-8?B?UjNMMkMrc05RNnV0dHBDV0pCN08wK1M2UE52NEdBb3RtalRxWHZIQmZJUytJ?=
 =?utf-8?B?RFgrazlRRkZTT2ovUkM2MXZ1MWFPVlp4cEU1QjQxTWcvREhDNTdhRnlnVHh6?=
 =?utf-8?B?YkFHUjZRNGFVMTNJWkxodmRzam9jRHJiMEdFT01qL0d2aStLRk1yZHB6Q2lE?=
 =?utf-8?B?K202MU9BMzZveldWWG1uQmVWbnVmazJqbHI5Z0t0am5RQ0RveUY4Z2U1cVMw?=
 =?utf-8?B?S0FkWVpOOEE4MDNhclNmcWZ4bDdpNzhjQnBIc0QvYkRmbnFhdnh3TU53QnV2?=
 =?utf-8?B?ZmFTUTY5NUMzeFVvNzI3Tnl3MWZkWVpVdUt6b1Z6ZHhzWXZvM1QrVWFGQlly?=
 =?utf-8?B?amtNWEh0bGFHN1pQeTlHL0x3OHZlT2hMakxYejR3ZWZ3R1BWaDRtcUFaKzBn?=
 =?utf-8?B?RmZrcjJEQi9ic2VYWWNXN1JIY21iMHNkK3habEZuU05vanJPMTZZWEh3Yjhk?=
 =?utf-8?B?L1c4TE9aK2lEcjUza1pxdGxlTm5pR1pHZWdZTllMUkUvQVZOMnhHa2tJTExy?=
 =?utf-8?B?OUh5VklsOER0S1czUmx3aDY0aThESXVNWUFXQ1Z5ZVAvaFBnU2h4dE5qL2VU?=
 =?utf-8?B?bWM3YkZWT1JOSWdYZTc2Sk1NdXZ3dHF3TURDUFgyVkFkVjJvci9nbldwMlFv?=
 =?utf-8?B?MjFmL1hNa0JBTlpKTnJXb2YyOW5CUkI2TzdmbWlkRTdKOGVSU0dWMTF5eW5W?=
 =?utf-8?B?NUJvTzkrWStjcWkrWXNoRldCMDA0citORlBnWnFic2xGSDh2cW1vZmM4alhO?=
 =?utf-8?B?Ym9abTdCSkNyNmlhcEJiUlV0Wi9ZSUNoYzRtUjdBNTdOKzQvaUNTK2lEZEdj?=
 =?utf-8?B?bWh4Wkt1Nm1YSEVBYlBCNllUZCthc3lid1NabTdkWGZQWmJpem1Ob1BaNWNT?=
 =?utf-8?B?YnVFVVM4eGREUXR0dGpoSkRDc2xUTEFteFRRNXdna3E0VTdZa1BQalFPcThY?=
 =?utf-8?B?UnpaVlZCQmw1a3VKVzNvRTF1UTVjK3Z5Uk91UkZjVWo0ZkN4WDhtNGUvcE44?=
 =?utf-8?B?UzVhdnpDeG9XUUFYaDczVmw4TzJqaU1SN0NDQkZKWThNZ25HRXNXRDFtOG0v?=
 =?utf-8?B?YlE5WHZNYjJMRTg3U0tnZDBWSXpZZEZYRnk3VGlLbU8vR3YwYkpMQmJQOExY?=
 =?utf-8?B?ZS8vVkVFNWtaeGxvYmJ4V2IvVkt2M2NhblAzdVpqb0ZpZERlZnM4VUVHcW1O?=
 =?utf-8?B?VU1rbS83dHZLODRvVGJoTWt0RmtPMzEwZUFVcGR2azVENkUrZlhBdU8rdElz?=
 =?utf-8?B?RXQ0WndYUndxc3pUakhwTnRDSjRFWjNPdHgwb0I4OFJxWnNLWi84Qm1KWGdr?=
 =?utf-8?B?L29CNjZYUnBBRk9ubHUwRWVmYm5JRUowdzJhWW9oeTdpRms4S0l1QUJWMGxi?=
 =?utf-8?B?d3FWaXI4S2dRTmlSdHZDeW5FVEdhdWtPNjNNYTNTUURUK3dQRkF3cFVTQ3Bk?=
 =?utf-8?B?NTFuUzFsYmlrMlFweWpBNHUyeXdRTlpoVzBOeXM3YlFLcW9xTTBUcVo3Z0Ey?=
 =?utf-8?B?aXJzazhIbHJKWlpCSkZyWnJyK1Znb3ZNTVhEZ0ViQWhEanA4WFFnWEJnZWRY?=
 =?utf-8?B?OEV6M2xjWmdXUEw1Y0twYXNsaW5PVTF4K1JiOWxOR0NQd2wvL3JiU3U0dEJh?=
 =?utf-8?B?UTMyOGdpMUZxaENueXZvQVVhM0JFY0UxOUl3dEZPY0FtcSt1amZ3SStieW5X?=
 =?utf-8?B?dVpUMEw1d0dwL0t1enZxRVFBSzRtVVNFQVlmNmx3NkZZRkJjUUJyUmNaazlq?=
 =?utf-8?B?RTQrNDcza21HeG5LYkZOMWp5OVhHWUQxVVh2OCszc3NpMndlYVVPVTlub0Ex?=
 =?utf-8?B?QVM1czRWSWJCSDBXTFZsMGpMT1ltKzM5Qzd2Yk4zeUNzeEtiMlJMWTZ5ZEcx?=
 =?utf-8?B?ZFlONmY0RERIZnNOS2JPUlQxcEY4VUFFbnM3WHlXSHpVNzYwcmpibUd5bTlR?=
 =?utf-8?B?UXZWcWVyRFZIaUNua0Q4enI2SFliRXJZMkpxZmZQSHNmQytMTU1IOTFPMTcr?=
 =?utf-8?B?TmI3TDdWMlZZRHNRc05GNnRWRHhnPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcb1a19-a182-4206-4a1d-08d9eba7b578
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:39:39.0479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8u8KrdbXPLf4yUw4B0NFPJlwla7kW+KqvDkLKox3tIcXk23osYJGVl05/+Q+rHXFjydgOPzetOUQu+4wqSq5Of+oV1pt9WpruGmBFuJyWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6821
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] Add TST_THREAD_STATE_WAIT macro
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
Content-Type: multipart/mixed; boundary="===============2135326033=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2135326033==
Content-Type: multipart/alternative;
 boundary="------------TWnHtTPkYE0ASiwfkPJZoL8z"
Content-Language: en-US

--------------TWnHtTPkYE0ASiwfkPJZoL8z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

On 2/8/22 12:09, Cyril Hrubis wrote:
> Hi!
>> The TST_THREAD_STATE_WAIT macro can be used to wait and check for
>> pthread state changes.
>>
>> Signed-off-by: Andrea Cervesato<andrea.cervesato@suse.de>
>> ---
>>   include/tst_test.h         |  1 +
>>   include/tst_thread_state.h | 33 +++++++++++++++++++++++++++++++++
>>   lib/tst_thread_state.c     | 37 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 71 insertions(+)
>>   create mode 100644 include/tst_thread_state.h
>>   create mode 100644 lib/tst_thread_state.c
>>
>> diff --git a/include/tst_test.h b/include/tst_test.h
>> index 450ddf086..79067f3bf 100644
>> --- a/include/tst_test.h
>> +++ b/include/tst_test.h
>> @@ -27,6 +27,7 @@
>>   #include "tst_cmd.h"
>>   #include "tst_cpu.h"
>>   #include "tst_process_state.h"
>> +#include "tst_thread_state.h"
>>   #include "tst_atomic.h"
>>   #include "tst_kvercmp.h"
>>   #include "tst_kernel.h"
>> diff --git a/include/tst_thread_state.h b/include/tst_thread_state.h
>> new file mode 100644
>> index 000000000..4d6a345b8
>> --- /dev/null
>> +++ b/include/tst_thread_state.h
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato<andrea.cervesato@suse.com>
>> + */
>> +
>> +/*
>> + * These functions helps you wait till a thread with given tpid changes state.
>> + */
>> +
>> +#ifndef TST_THREAD_STATE__
>> +#define TST_THREAD_STATE__
>> +
>> +#include <unistd.h>
>> +
>> +/*
>> + * Waits for thread state change.
>> + *
>> + * The state is one of the following:
>> + *
>> + * R - running
>> + * S - sleeping
>> + * D - disk sleep
>> + * T - stopped
>> + * t - tracing stopped
>> + * Z - zombie
>> + * X - dead
>> + */
>> +#define TST_THREAD_STATE_WAIT(tid, state, msec_timeout) \
>> +	tst_thread_state_wait((tid), (state), (msec_timeout))
>> +
>> +int tst_thread_state_wait(pid_t tid, const char state, unsigned int msec_timeout);
>> +
>> +#endif /* TST_THREAD_STATE__ */
>> diff --git a/lib/tst_thread_state.c b/lib/tst_thread_state.c
>> new file mode 100644
>> index 000000000..f5580c39e
>> --- /dev/null
>> +++ b/lib/tst_thread_state.c
>> @@ -0,0 +1,37 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato<andrea.cervesato@suse.com>
>> + */
>> +
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +
>> +#include "tst_safe_file_ops.h"
>> +#include "tst_thread_state.h"
>> +
>> +int tst_thread_state_wait(pid_t tid, const char state, unsigned int msec_timeout)
>> +{
>> +	char proc_path[128], cur_state;
>> +	unsigned int msecs = 0;
>> +
>> +	snprintf(proc_path, sizeof(proc_path), "/proc/self/task/%i/stat", tid);
>> +
>> +	for (;;) {
>> +		SAFE_FILE_SCANF(proc_path, "%*i %*s %c", &cur_state);
>> +
>> +		if (state == cur_state)
>> +			break;
>> +
>> +		usleep(1000);
>> +		msecs += 1;
>> +
>> +		if (msec_timeout && msecs >= msec_timeout) {
>> +			errno = ETIMEDOUT;
>> +			return -1;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> Maybe we can just put this code into the existing tst_process_state.h
> header and C source.
The tst_safe_process_state.c implementation is currently using old API 
and it's importing "test.h" . If we want to add TST_THREAD_STATE_WAIT 
into tst_process_state.h then we also need to rewrite process state 
headers/implementation files in order to support both old and new API.
>
> And we should add some documentaion about the function into the
> doc/c-test-api.txt as well.
>
> Other than that it looks good.

--------------TWnHtTPkYE0ASiwfkPJZoL8z
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi!</font><br>
    </p>
    <div class="moz-cite-prefix">On 2/8/22 12:09, Cyril Hrubis wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YgJPeBY+B1H9aq80@yuki">
      <pre class="moz-quote-pre" wrap="">Hi!
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">The TST_THREAD_STATE_WAIT macro can be used to wait and check for
pthread state changes.

Signed-off-by: Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.de">&lt;andrea.cervesato@suse.de&gt;</a>
---
 include/tst_test.h         |  1 +
 include/tst_thread_state.h | 33 +++++++++++++++++++++++++++++++++
 lib/tst_thread_state.c     | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 include/tst_thread_state.h
 create mode 100644 lib/tst_thread_state.c

diff --git a/include/tst_test.h b/include/tst_test.h
index 450ddf086..79067f3bf 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -27,6 +27,7 @@
 #include &quot;tst_cmd.h&quot;
 #include &quot;tst_cpu.h&quot;
 #include &quot;tst_process_state.h&quot;
+#include &quot;tst_thread_state.h&quot;
 #include &quot;tst_atomic.h&quot;
 #include &quot;tst_kvercmp.h&quot;
 #include &quot;tst_kernel.h&quot;
diff --git a/include/tst_thread_state.h b/include/tst_thread_state.h
new file mode 100644
index 000000000..4d6a345b8
--- /dev/null
+++ b/include/tst_thread_state.h
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>
+ */
+
+/*
+ * These functions helps you wait till a thread with given tpid changes state.
+ */
+
+#ifndef TST_THREAD_STATE__
+#define TST_THREAD_STATE__
+
+#include &lt;unistd.h&gt;
+
+/*
+ * Waits for thread state change.
+ *
+ * The state is one of the following:
+ *
+ * R - running
+ * S - sleeping
+ * D - disk sleep
+ * T - stopped
+ * t - tracing stopped
+ * Z - zombie
+ * X - dead
+ */
+#define TST_THREAD_STATE_WAIT(tid, state, msec_timeout) \
+	tst_thread_state_wait((tid), (state), (msec_timeout))
+
+int tst_thread_state_wait(pid_t tid, const char state, unsigned int msec_timeout);
+
+#endif /* TST_THREAD_STATE__ */
diff --git a/lib/tst_thread_state.c b/lib/tst_thread_state.c
new file mode 100644
index 000000000..f5580c39e
--- /dev/null
+++ b/lib/tst_thread_state.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>
+ */
+
+#include &lt;stdio.h&gt;
+#include &lt;unistd.h&gt;
+#include &lt;string.h&gt;
+#include &lt;errno.h&gt;
+
+#include &quot;tst_safe_file_ops.h&quot;
+#include &quot;tst_thread_state.h&quot;
+
+int tst_thread_state_wait(pid_t tid, const char state, unsigned int msec_timeout)
+{
+	char proc_path[128], cur_state;
+	unsigned int msecs = 0;
+
+	snprintf(proc_path, sizeof(proc_path), &quot;/proc/self/task/%i/stat&quot;, tid);
+
+	for (;;) {
+		SAFE_FILE_SCANF(proc_path, &quot;%*i %*s %c&quot;, &amp;cur_state);
+
+		if (state == cur_state)
+			break;
+
+		usleep(1000);
+		msecs += 1;
+
+		if (msec_timeout &amp;&amp; msecs &gt;= msec_timeout) {
+			errno = ETIMEDOUT;
+			return -1;
+		}
+	}
+
+	return 0;
+}
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Maybe we can just put this code into the existing tst_process_state.h
header and C source.</pre>
    </blockquote>
    The tst_safe_process_state.c implementation is currently using old
    API and it's importing &quot;test.h&quot; . If we want to add
    TST_THREAD_STATE_WAIT into tst_process_state.h then we also need to
    rewrite process state headers/implementation files in order to
    support both old and new API.<br>
    <blockquote type="cite" cite="mid:YgJPeBY+B1H9aq80@yuki">
      <pre class="moz-quote-pre" wrap="">

And we should add some documentaion about the function into the
doc/c-test-api.txt as well.

Other than that it looks good.
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------TWnHtTPkYE0ASiwfkPJZoL8z--


--===============2135326033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2135326033==--

