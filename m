Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E56C6FD1D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 09:30:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 071D83CD4A2
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 10:30:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEE813CACBC
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 10:30:02 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B47F11000A4F
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 10:30:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1vrvbEG203h7riwT0vWrYYYm9AIUWp/jgh0eTzOzOWYZs0+r3ljb7kjGvd7w84dLlTEMMOBCiKSREGH58dH3H6M43UcPwEtdej7w1at9SBkcNx8HkHc6h4jfvJWdMJhpaNfK0zqNolV55AwHCm0nh10BRxf/+wkEfxTM3GyTpuedoULFH9fOhtiKKnrwG6GUqAqfCNTb393VCbuLgA2UE/OId0p+dhZbYxgUBJOyOL9bfH65+P/8rfV2JKdxYb0nnFM/upn6LWRAgsh781XGD2JrE81bl9FO5tVNpvWDEW/NqCdfdVuDPGclGlN8QvAwkQtYAjKS/JaxeSYUrXHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7Jy7vCiaoOuGlPjvmV0PiyeJAEAfxy4RzXpC0M8uVc=;
 b=dVsP+TSNEui1EnBsnnx7GU3HjWZD3vBDN82VbH7sPoOXxkv7XDk0QivsJrxE1iN3WiPVUmqahjp5Kyi6xEBEV02EEuBRDrdnalolLkkjjs4nwVtJkO2udQ864eoWtc1lDSTfDaW0grbTS6bwwsk9PZjgmP43neRuEvb2/1cfWbqENgehuDVJMlXuCxHKPKbL5tvxgxk6wYFtN1vZ7rMCbTVO2sE+D/TgaQXuz/k5dnZtPrY7l6SzGcJNLe9Tr8FePHjwYEFluCbOyP+dMV1PDB5xcH7jL2XFVeazf298mRI5yC+a3yDo+iXHLTvs0oU6OCMwQIZ3TWXp6Skkg2NTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7Jy7vCiaoOuGlPjvmV0PiyeJAEAfxy4RzXpC0M8uVc=;
 b=zdzNtqdanKgw8P9GnyJxQTDsKCbVda99Z34NakUqdD7xN9T3HA9AVDqGAMl3INuTa9N+aeELmPK1WwJpcZdATnm852vh75AUF3MMi5qjA4N0KuU1lcomTcXl+IJOXzocIlhzmB73g0NM/N61DEchHzjv116YEAzY7sw67uIHQJbhfsIYMYsWHdjBY5qvnyMjD0jjLXSmZ33sfsM4Nb+Km3jB4w8Neb5U6cCmZYKjZw0ks4/1cORUu/RUxK8MjfcTlbLt0CL9/582/L8PlhV35Mzu0GPN9CfrZiGM3XmuipPj0bHWo7MQbbxVwW7udl3uon5Yv8ve6hitmbqS+mFvOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 09:30:00 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca%8]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 09:30:00 +0000
Message-ID: <f559fa8c-ab22-9a7d-3b07-8f31048420e1@suse.com>
Date: Wed, 15 Mar 2023 10:27:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230314130027.24108-1-andrea.cervesato@suse.de>
 <ZBCnQeVxNOPDCc+1@yuki>
In-Reply-To: <ZBCnQeVxNOPDCc+1@yuki>
X-ClientProxiedBy: FR0P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::14) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS8PR04MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6d7b57-072d-42cf-2b2c-08db2537d917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JsnjWaeqZ8PbY2AvR6ILXhUgAVmqsk8KjbCQEAMNxAbb2hU6sINosKkdxdqAJeMdYDPooP6mUPfc+bMt7hHfUj0/dBX8GJfn41shtAPXe9S69dwj7ksj1+SwaglOhc3TEWDR43jfBtlfDb/i9YFHIbpTAvmAV1pdH6Vm5ymny3A/nayN0U5yQaBNHC3TopISuNWaf5tlFWcxetMsO835nzbciG9DivGKQL5R1EhDC5QV4nr1iW799MG6iBgIzpgL1E565FqIm4X5b8m1ZVcWaA/eRAYkEqoBSpDMC40W8kC0lLXnvpIL9JsAdsxck8YtPg8XYuZirlJQSDh7G9CnDpMDBJlMV1Fps8taK73rCMM6lGhuwxD7aczBkx6CGaU8QnBKGMiUTOb0xLtCavcWFguJDcDzdC84wJtQpMw87pzjbaBUxleidP1M2pDMjTTZ1DNPvBJUx3mbwwids8YWgpnmozc6al6X6+HG9Rg5TgxU7j1W9W+lU9saQNUSlarrg3vW29t1QH5z/NgaicxBN1uViRt2GecynIXLdLsX+evJmWPmq7qkZrFQs0fw7JNe8ia48ZswFzYjFAAg18TOWKmQHoNbU88Pkgy/AufkMUahpvLI513tKBLKktvXXJXLBnAJ0bA9YMHbOORWcahwZu7sWkgvHDkUL6D36XOKiiJcnMzoc5YkiPnPH0xU+q2IctmdP3iaGmBVY1dg4hwKSRmMHlYlE8k7adwlOTb00OsTBmLjbSN9OQ8Wt2ameNyW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(110136005)(478600001)(6486002)(2616005)(53546011)(26005)(36756003)(186003)(6666004)(316002)(6506007)(6512007)(41300700001)(38100700002)(5660300002)(31696002)(86362001)(8936002)(31686004)(44832011)(83380400001)(2906002)(66476007)(66556008)(66946007)(4326008)(8676002)(2004002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bC9sOHdNL0hZR09LbU4yYWRCbldqZXJZQ09qaktXdTlZQXBuZy9uQTVjQ0FK?=
 =?utf-8?B?d0RaUHowM2Q3T1IwUUJ6UGUydFM2RGsyNEhHVTFuR2lHRGdkT1JTY1o0Wjh6?=
 =?utf-8?B?U3JkKzlQMisrVlZqanFlMlZ0TWUwUmF3cDEweGs1T1JSVWV4MzdTem01czUz?=
 =?utf-8?B?cU9CVDlYN2Z3aXFaL3Rkcnc2aTJvU3pIWkZwMWFBR0wxRld6N2Rua1prWjFs?=
 =?utf-8?B?VEFSMFhWcFdSSGRVNmFPNXhLSzVQT2JZTVUwMDNRb3Q3UUNFR2hDTHRISmt6?=
 =?utf-8?B?Z0tvTUMyTVZhYlI1QjJXWTd5RWFremdNY3lML0ZQbzg3WE40ZUVGR0NIbmJG?=
 =?utf-8?B?aTQ0Vlh3Zm9VSXg4eDhKZ0xnUmNnNHRxakVMbW5uRU9JUkM5b21DcmhBb05R?=
 =?utf-8?B?bUwzekIwR2RRQWF4cXNQZzBRK2U4TGgxMTNmMmtXcTJYM1BwWDBWOWwwaGxp?=
 =?utf-8?B?N1lUMkl2MC9ZQXc4U0ZzQjZHT05lajQweXFEdm1mdmFrWVJVVm1ZUklnR3dv?=
 =?utf-8?B?NjEyd1dZN0JlaVE2bWZHNitkU3JLUThOLzAram5mT0xnc3hLcmx3akxhYnd1?=
 =?utf-8?B?N1c4aStpRHhnVFN0K1Jwem9lK05vOVBXdHZqSEViUkR1YTFPelFwQm52ejZv?=
 =?utf-8?B?OGtHd1lrOERQM2h4NXZCRVAvdmlLcVVIUmZpRXVYVk1ra0hRRldoVXZ6MEpy?=
 =?utf-8?B?S3pZaFB2cXlmby9GQjdlZEhPNWVBQ2N1SUNONVlPRjFxVHpJSzZwczlOazR3?=
 =?utf-8?B?RGlMREgwdXBNOWxqZHhRNVVRbmxKWFhUUFYzd0UrcG1wTGQxakI4enZSRVpJ?=
 =?utf-8?B?cWFLS0Rod1FNaEhIdWlBU0FMRzdUa0JNWmVtQnZ6d1QyTllrQk1mS3NtMWth?=
 =?utf-8?B?Q0gxL3QvaXcrRGFpTzRUeUdpR1NWOEtjTWg4V0hkNnZiVjhpclZNbHlZNXlY?=
 =?utf-8?B?UFpwWkg1QWgySEJIVTdYUUMxSEtkakF3RlJ5RENqdExWdE9tQ3dHNklraXBm?=
 =?utf-8?B?ZkNtUklxSEQraWk3alJSS3l6M2hEWnVmdnFpNXpIUk1UYU1oODdyck5TR0Nx?=
 =?utf-8?B?bVo2K05YS3JGMGNtRllzVG8rL09uS25IYjlWTXdwOVMzVVBhbm00N2dURWRh?=
 =?utf-8?B?WXBkdnBwVDZjaUNUbUQyRDRwRHRvKy80Q1RmMTlpV01YVktHSUFEVVQzWGxX?=
 =?utf-8?B?QnhrNEhaQUJlMDBNakFWNGFYbG9udStkajgwdlA1ZGY1NmFwUG80L0ROV09Z?=
 =?utf-8?B?Zmk1aFFMdTliVHNzQmtPRWt2UjVFOXpyaFBYWXpVbDluRmQrbVRaMUhLK3dF?=
 =?utf-8?B?YUc5eUh2dFUvQXlNUU4vbUdCRmZGekR1ZDZDUjZVb2J1aCt1V1FRblhLZWty?=
 =?utf-8?B?WEVJenRHNjFRUXFrbkRkbnhKNW5PMFdiazVKWkFoUHhwbmZCVURBTFVOY2pY?=
 =?utf-8?B?dWFGaWFCTmsxMWw3ZUtiNHdlZ2VhZCtrekx2R01uaFViR0tUSVBnQXgvRk9s?=
 =?utf-8?B?N3B6cTlIY3dWTUI5elExUDZ6d1hCQ2RWYjBwaG10Mlo2VmljaUJLZ1M1WElO?=
 =?utf-8?B?VmUwc3YvaVNCMDc3YmZPRXoyZUlZZUE5c2k1b3VSVUNscW9uSTU1akhldzV5?=
 =?utf-8?B?L28yQ3dBb01jSkRSUnBQbVFYem9ydGJIa2N6MTFab2lUMU1tZFBxcExUS09K?=
 =?utf-8?B?YjN1aTJSK0tmYTI0SkQ5ZG5CallHQkdPcmdLd01FU1NGeVJZV1ZvTHBNcmlz?=
 =?utf-8?B?dDh3VTE3WGxuZUVYeWJqRnVqc2xXTWZiLzhHeVJkNlAzenl2MUMrQ1BpTGxx?=
 =?utf-8?B?TVhNNzdCTmpmclJZbEo3aHZXWXh2N2F5YUVZNE5ONktoVXBzYlF5U1NYZ21J?=
 =?utf-8?B?bStRK2lYSGFZeHBNYktZak40S1RDVEVrWnBuVVg1aVkwbE5kK2pOOHpIWDB3?=
 =?utf-8?B?cHgwWG5vMVpmZUtwMnhQQzQxOEVQOThGcC9TMXJhR29sUnVTdzZzeVR4S0Zt?=
 =?utf-8?B?alFhb2V6UTFTK2NJd016YXkxTkJwQWxkSzlFUzRkc2Exc3lQaFk4SE85a3hH?=
 =?utf-8?B?ZVcwVWV2dWh5MHFYMWNDTzN4ZnV3Wkd5dVBwb1o1Nmp0VjV3bzV0VS9vbHV0?=
 =?utf-8?B?d2lIa2taWVU5dDRiTkhIbUllazUvSk5ML1FPeDZGT1pqVHFoaDgvTnB3U2ZL?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6d7b57-072d-42cf-2b2c-08db2537d917
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 09:30:00.0847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySJMviKUeamx9ddfX2tyVvmRbJgM6d4zjbzPfBslLONG9aAvNBMsx8xRBpWqr7dJSBNZluPWa3Ubu5DtrSwDKfZRgAnqSde+rPPOu6Ju/Os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8216
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite eventfd01 using new LTP API
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

On 3/14/23 17:56, Cyril Hrubis wrote:
> Hi!
>> Splitted eventfd01 test into multiple test files using new LTP API.
>    ^
>    Split
>
>> Now we have 5 more tests.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>> Use TST_EXP_FD for fd check
>> Check CONFIG_EVENTFD for each test
>> Description adjustments
>>
>>   runtest/syscalls                              |   5 +
>>   testcases/kernel/syscalls/eventfd/.gitignore  |   5 +
>>   testcases/kernel/syscalls/eventfd/eventfd01.c | 745 +-----------------
>>   testcases/kernel/syscalls/eventfd/eventfd02.c |  50 ++
>>   testcases/kernel/syscalls/eventfd/eventfd03.c |  54 ++
>>   testcases/kernel/syscalls/eventfd/eventfd04.c |  57 ++
>>   testcases/kernel/syscalls/eventfd/eventfd05.c |  44 ++
>>   testcases/kernel/syscalls/eventfd/eventfd06.c | 171 ++++
>>   8 files changed, 412 insertions(+), 719 deletions(-)
>>   create mode 100644 testcases/kernel/syscalls/eventfd/eventfd02.c
>>   create mode 100644 testcases/kernel/syscalls/eventfd/eventfd03.c
>>   create mode 100644 testcases/kernel/syscalls/eventfd/eventfd04.c
>>   create mode 100644 testcases/kernel/syscalls/eventfd/eventfd05.c
>>   create mode 100644 testcases/kernel/syscalls/eventfd/eventfd06.c
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 9c76d7fe3..2179f8d5b 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -182,6 +182,11 @@ epoll_pwait04 epoll_pwait04
>>   epoll_pwait05 epoll_pwait05
>>   
>>   eventfd01 eventfd01
>> +eventfd02 eventfd02
>> +eventfd03 eventfd03
>> +eventfd04 eventfd04
>> +eventfd05 eventfd05
>> +eventfd06 eventfd06
>>   
>>   eventfd2_01 eventfd2_01
>>   eventfd2_02 eventfd2_02
>> diff --git a/testcases/kernel/syscalls/eventfd/.gitignore b/testcases/kernel/syscalls/eventfd/.gitignore
>> index db45c67cf..4f577370c 100644
>> --- a/testcases/kernel/syscalls/eventfd/.gitignore
>> +++ b/testcases/kernel/syscalls/eventfd/.gitignore
>> @@ -1 +1,6 @@
>>   /eventfd01
>> +/eventfd02
>> +/eventfd03
>> +/eventfd04
>> +/eventfd05
>> +/eventfd06
>> diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
>> index 9b60434a2..8f83378da 100644
>> --- a/testcases/kernel/syscalls/eventfd/eventfd01.c
>> +++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
>> @@ -1,738 +1,45 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - *   Copyright (c) 2008 Vijay Kumar B. <vijaykumar@bravegnu.org>
>> - *   Copyright (c) Linux Test Project, 2008-2022
>> - *
>> - *   Based on testcases/kernel/syscalls/waitpid/waitpid01.c
>> - *   Original copyright message:
>> - *
>> - *   Copyright (c) International Business Machines  Corp., 2001
> I suppose that we should retain these copyrights as well, since the new
> tests are mostly cleaned up code from the original test.
>
>> - *   This program is free software;  you can redistribute it and/or modify
>> - *   it under the terms of the GNU General Public License as published by
>> - *   the Free Software Foundation; either version 2 of the License, or
>> - *   (at your option) any later version.
>> - *
>> - *   This program is distributed in the hope that it will be useful,
>> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> - *   the GNU General Public License for more details.
>> - *
>> - *   You should have received a copy of the GNU General Public License
>> - *   along with this program;  if not, write to the Free Software
>> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>>    */
>>   
>>   /*
>      ^
> Should be /*\
>
>> - * NAME
>> - *	eventfd01.c
>> - *
>> - * DESCRIPTION
>> - *      Test cases for eventfd syscall.
>> - *
>> - * USAGE:  <for command-line>
>> - *      eventfd01 [-c n] [-i n] [-I x] [-P x] [-t]
>> - *      where,  -c n : Run n copies concurrently.
>> - *              -i n : Execute test n times.
>> - *              -I x : Execute test for x seconds.
>> - *              -P x : Pause for x seconds between iterations.
>> + * [Description]
>>    *
>> - * History
>> - *	07/2008 Vijay Kumar
>> - *		Initial Version.
>> - *
>> - * Restrictions
>> - *	None
>> - */
> ...
>
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/eventfd/eventfd02.c
>> @@ -0,0 +1,50 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +/*\
>> + * [Description]
>> + *
>> + * Verify write operation for eventfd fail with:
>> + *
>> + * - EAGAIN when counter is zero on non blocking fd
>> + * - EINVAL when buffer size is less than 8 bytes, or if an attempt is made to
>> + *	write the value 0xffffffffffffffff
>> + */
>> +
>> +#include <stdlib.h>
>> +#include <sys/eventfd.h>
>> +#include "tst_test.h"
>> +
>> +static void run(void)
>> +{
>> +	int fd;
>> +	uint64_t val = 12;
>> +	uint64_t buf;
>> +	uint32_t invalid;
>> +
>> +	fd = eventfd(0, EFD_NONBLOCK);
>> +	TST_EXP_FD(fd);
> This produces rather cryptic message:
>
> eventfd02.c:27: TPASS: fd returned fd 3
>
> You are supposed to pass the syscall to the TST_EXP_FD() as:
>
> 	TST_EXP_FD(eventfd(0, EFD_NONBLOCK));
> 	fd = TST_RET;
>
> I suppose that we can as well redesing subset of the TST_EXP_*() macros
> so that they return a value with:
>
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index 231c04951..091209558 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -86,13 +86,14 @@ extern void *TST_RET_PTR;
>   #define TST_EXP_FD_SILENT(SCALL, ...)  TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
>
>   #define TST_EXP_FD(SCALL, ...)                                                 \
> -       do {                                                                   \
> +       ({                                                                     \
>                  TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
>                                                                                 \
>                  if (TST_PASS)                                                  \
>                          TST_MSGP_(TPASS, " returned fd %ld", TST_RET,          \
>                                  #SCALL, ##__VA_ARGS__);                        \
> -       } while (0)
> +               TST_RET;                                                       \
> +       })
>
>
> Then we can write more simple:
>
> 	fd = TST_EXP_FD(eventfd(0, EFD_NONBLOCK));
I agree with this. Should we send this patch?
>
>> +	SAFE_WRITE(0, fd, &val, sizeof(val));
>> +	SAFE_READ(0, fd, &buf, sizeof(buf));
>> +	TST_EXP_EQ_LI(buf, val);
>> +
>> +	val = UINT64_MAX - 1;
>> +	SAFE_WRITE(0, fd, &val, sizeof(val));
>> +	TST_EXP_FAIL(write(fd, &val, sizeof(val)), EAGAIN);
>> +	TST_EXP_FAIL(write(fd, &invalid, sizeof(invalid)), EINVAL);
>> +
>> +	val = 0xffffffffffffffffLL;
>> +	TST_EXP_FAIL(write(fd, &val, sizeof(val)), EINVAL);
>> +
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.needs_kconfigs = (const char *[]) {
>> +		"CONFIG_EVENTFD",
>> +		NULL
>> +	},
>> +};
> ...
>
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +/*\
>> + * [Description]
>> + *
>> + * Test whether counter overflow is detected and handled correctly.
>> + *
>> + * It is not possible to directly overflow the counter using the
>> + * write() syscall. Overflows occur when the counter is incremented
>> + * from kernel space, in an irq context, when it is not possible to
>> + * block the calling thread of execution.
>> + *
>> + * The AIO subsystem internally uses eventfd mechanism for
>> + * notification of completion of read or write requests. In this test
>> + * we trigger a counter overflow, by setting the counter value to the
>> + * max possible value initially. When the AIO subsystem notifies
>> + * through the eventfd counter, the counter overflows.
>> + *
>> + * NOTE: If the counter starts from an initial value of 0, it will
>> + * take decades for an overflow to occur. But since we set the initial
>> + * value to the max possible counter value, we are able to cause it to
>> + * overflow with a single increment.
>> + *
>> + * When the counter overflows, the following are tested
>> + *	1. Check whether POLLERR event occurs in poll() for the eventfd.
>> + *	2. Check whether readfd_set/writefd_set is set in select() for the
>> + *		eventfd.
>> + *	3. The counter value is UINT64_MAX.
>> + */
> This does not render reasonably, the list does not render as a list at
> all, and I would drop the NOTE: as well.
>
> The list should look like:
>
> * When the counter overflows, the following is tested:
> *
> * - POLLERR event occurs in poll() for the eventfd
> * - readfd_set/writefd_set is set in select() for the eventfd
> * - the counter value is UINT64_MAX
> */
>
>> +	TEST(io_setup(MAXEVENTS, &ctx));
>> +	if (TST_RET < 0)
>> +		tst_brk(TBROK, "io_setup() failed: %s", tst_strerrno(-TST_RET));
>> +
>> +	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0644);
>> +	evfd = eventfd(0, EFD_NONBLOCK);
>> +	TST_EXP_FD(evfd);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	SAFE_CLOSE(evfd);
>> +	io_destroy(ctx);
>> +}
>> +
>> +static void run(void)
>> +{
>> +	test_select();
>> +	test_poll();
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_tmpdir = 1,
>> +	.needs_kconfigs = (const char *[]) {
>> +		"CONFIG_EVENTFD",
>> +		NULL
>> +	},
>> +};
>> +
>> +#else /* HAVE_IO_SET_EVENTFD */
>> +TST_TEST_TCONF("eventfd support is not available in AIO subsystem");
>> +#endif
>> +#else /* HAVE_LIBAIO */
>> +TST_TEST_TCONF("libaio is not available");
>> +#endif



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
