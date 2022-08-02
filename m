Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF24C00140
	for <ltp@archiver.kernel.org>; Tue,  2 Aug 2022 14:13:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D31D3C927B
	for <ltp@archiver.kernel.org>; Tue,  2 Aug 2022 16:13:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87FF93C2824
 for <ltp@lists.linux.it>; Tue,  2 Aug 2022 16:13:31 +0200 (CEST)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30062.outbound.protection.outlook.com [40.107.3.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2EE37600822
 for <ltp@lists.linux.it>; Tue,  2 Aug 2022 16:13:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbYjwIbYPYUcuM9GfAezwMecrZj6abS345z+mWCnmrHj0/QlFbU4vjxT35Ypc+4o7dJzL9FVI3mhTG+evGtMw5PbN2FK4pAqQHSfs1VbFDrmE29CXMOQjB8z9+CGpWfIyIa3XqME4Vp0+DXkdTEA+fluzOlGUVgtwvfpmMzrwP9H8wMQSxraXnUOK4QGkpstsa1EiOB99dxciHYwKooe3Q4Yyb76o5NO6TYleBhoY41+ybibf+EZ9xSK4huLKr296Z2R8CfdoH4nXWUTYD5kbv+p8946bbdjSy863MUdDz+ugocuQ5aE1YDTe6dXSIf9og7ISS1Tsqa2c/M6vjafcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNJ2OBYlcHJAcnlcyLOysQu8HqU3F/97zimhbm0st4M=;
 b=H+h2YKobl1L8L/niE6jAmAiJ6cumUpb335Ft1pkSgtZ1VPfRJECfy76ux/dFNLvZm3uX8v4zgkMuQIbznNwUw6adCmmtZFF1YDflBDD1OjF4ExweNIrrKh8Cx3eidodT5POXAlhc2ZI0NcCB0LUDZc/LmA0QyOvcQMA+oRyIxqQbQqS+LAlaVTyE3gyLaqnOcBV/DIfg9Qsl5tZpv5ihzmyBQ3v+7VkImRjgb5sXoz+Cq9A+2OZ//Qyu0sHQx4Cahchk8A+6H2btfAJpl3+s5giajhqfbe4A3nQi1XpdWhSyDxM/wX5C+yHya/c/G63YJMR0CJowMhkYN42eRxt7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNJ2OBYlcHJAcnlcyLOysQu8HqU3F/97zimhbm0st4M=;
 b=xZi6udXHYohZLAHaJFy5bRpo3OAt897ohIGXVL+CNu56LiSjDM3P0rvEgj94+FfrqLp3gRd4UoN3ArdNELeZOKNNHdVjXGykVBkHXRLhOfGJ2aKWn3oTG/GNBg/tkHK/2ihz0mduzhbh4wOvQP96mj1FZ1mckD3LiLnhBGE/Z4YN9f5/a38tj7niw48MPCc0h+X83xrHzqAHeGTEtIqbsQNxvrUq+0HsfYFhWENGzP8K5cLvXTQKuovZ53b3PIJTLq31Zqohf16eofjQZoLuh/wyd6Mv89QAXZ7Bq9S1tzCDBlsyBQQSbwbV5mPjDa6bN3gx6hsAWbbBDmEalDveAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM6PR04MB4469.eurprd04.prod.outlook.com (2603:10a6:20b:22::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 14:13:27 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b%5]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 14:13:26 +0000
Message-ID: <d0cf0e1f-8e0c-127c-b613-ac8b3bd99ad6@suse.com>
Date: Tue, 2 Aug 2022 16:12:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220801151408.15947-1-andrea.cervesato@suse.com>
 <Yukh3EQSm57ak0o+@yuki>
In-Reply-To: <Yukh3EQSm57ak0o+@yuki>
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 716bb3a3-6380-463c-c93e-08da74912aa9
X-MS-TrafficTypeDiagnostic: AM6PR04MB4469:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eawA65Cj39FDUCMdk9BNj75ZNF7dnj1c7CSwwiD6ddhnQGnD8WcpvgSUBmi5LvspDMZGKgS11sRcB4R1rv+iQ7wz63IXfsq24pEaUf7Q1/hrf4zOJHSJQ+urE+EVsrw/sm385FY8myEmMAOMn0YKNsrsvav9z0U4e3J3BcFL819BRiejotmODuMEayqd0a9VBOTAcRn2G8upmdeRNLu97G7gyWm2gF41p2s+eZHASR6RJkRxqSctwg21veU44UFgnFTxqXeke318ERBjq9cIgHyibE78/qUO0urgyh36KqTGU7RKDOlxb+JpoqjgnGBMaxpQnJtsU4kzHPIhXjJUB6vCoR07wE23m36h6hpygkIgiaqWI3wvSmU6p3VTi1SH/KBgRc243W/zNqcPPEfoKIhi13AAPwWMkpmtNlxHfQbLREyl5VPm621nxsMNPssj+joREZo/gHszmNflKfdEYd9sRSa/X4VW2WZL+TarscSNZQM7AQAfF3ZzeY2i7SEtBSQOOmLvnpmOXpGwvJS7FkDWMGT5iz+aP0DZkJEA8X0KVkbQjORO2H4gtQKxJj+mdM7ffTumH9N1a0oBxdj1eJD24o+Bv3/c3DAlYdsxb2MOQeg5Ij/6f5jGDXPokQoKK/DWR+0zq2BnD22rsQqjU1nS8I/KXr0LZUPbLcpv0FKOsDjhR5UoliO1eIe/HHh4Jv4xKbntv4aJjLZCU99X04+9lN/tWbVJZKxOpvYKOwMq4U5VeQxrQ1vaM/+pnCAeo7tjFrqYvuaDECHnYpw1Yvmr4QRL+0XpHflIE8eHT21d8bsliMstX+R3U0kwHNAdwzFXLU8HThS14mOif9vA+rgSstzNPcVa4sP/NMEmva4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(38100700002)(44832011)(966005)(6486002)(6506007)(6666004)(6512007)(26005)(53546011)(66556008)(41300700001)(478600001)(66476007)(30864003)(31696002)(5660300002)(2906002)(86362001)(8676002)(83380400001)(36756003)(8936002)(4326008)(31686004)(6916009)(316002)(186003)(2616005)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHdqaWh0eFhEbGZpMGtQZFhZK0NJejE1U0wwbjcydWREaFVMdHNOZyt4ZlVW?=
 =?utf-8?B?MTJNSWNRek1FemVQU3d2ZjFRcXMvRGw4UktSS3E2Ky82cDlwaUl4c3ZtWWZV?=
 =?utf-8?B?TFN6UUdQOVIzNi9wSkxHa3o3NVdEczNDQm00T3VjdXJYczd3cEJXaHBzQlZs?=
 =?utf-8?B?OGw4ZkxiWDZZcm1TekVmZUtnRllBWWczQ2pmak4xZldwcVhUbEtCUGNTRndV?=
 =?utf-8?B?cGFJN1RsSU1NOEZjZ045by9pOTNGaERETXhBbjRrVlJjMkVldFNNT2FyT29k?=
 =?utf-8?B?OXdGNUdYRkFEbElCV3ZzakFlR0R1aE5Vc2h6dmIvNTN5UnMvdG8zc1BTWTAy?=
 =?utf-8?B?VjRBakQxVGgvaXUzdUJvUVlLdFpGaVR1WnFSZHJjK1M3eDZub1h0ckZDbU0w?=
 =?utf-8?B?cDRLN1ErK1lLY0FnOXNYUGlUYld0TDhxUmJ1TWpUam1XSWM3NmpXYWNoSGFn?=
 =?utf-8?B?L2tDTUp3QmRYVHlKKzhXYXRIQ015SVdSWUFTWW9md0ZzaVdtNGpvSHl2K0Nh?=
 =?utf-8?B?YUI0b0UzWWZzZ0pTNjljUXRvZWZXaWFLbS9wdmt0MXFPWU93cHZWT3NITHdp?=
 =?utf-8?B?bVZ0eHM4ZjkvS3k0cXV0cWlTVmxqaWFOa3pMYWdNK3FGR3FhTGZsdFZKV2Vq?=
 =?utf-8?B?YnRVaUpCcC9FQkozOUFFbVV4dFV1VkVrMkRPYkVKQWpyOUhqNWxENzl6ejk1?=
 =?utf-8?B?ZzBGdFUrVTJ3ZEVwRXVwMkFPRE91ek5ZcjhycWp0QkhFeHF1azhJV3k1ekNu?=
 =?utf-8?B?OWowZk4vT1ZqdDRqc05TVW9vOEVnNmd0QmJNVHRDdTMrYzFjVldFMjgwQWl2?=
 =?utf-8?B?NDFMeWJDajZFcCtQTWZaYTRodHFnTm9JQ3lNMU4zTG95czRCTVpUa0k5Nks5?=
 =?utf-8?B?eGNZQ1JpZ0orcUtpNnc1YVNDUnBWbDBETnlMRWlXaVBVUjRUUWlwdnhXQ3Jv?=
 =?utf-8?B?Z1V2TjE5dms4dDVCK2FpNHNNM2NwZi8xUHA2enR5ZXNvWkMwZS8rbHY3d05R?=
 =?utf-8?B?dXErdHpwK3YwMzNMQVk5ZlFJR1EraEc5cjVYVUIrYS80SXBUbzhFOXh1MlNF?=
 =?utf-8?B?b1AzYTJYdTVnU1h1WFkwRUZvdFMwbmREM2I2Q2hYQUt4M0xUS2dXeG10MS9Y?=
 =?utf-8?B?OCtqQ296bEJJUmxETVIyd0JZOXJZcTBlenRLOFNSaWhSOGQ4SldBME9XMG1S?=
 =?utf-8?B?Wko4YXRlakUrSkRILythQTZuWlhpVnhtOGNZVVB0YXZUcFV3cU9scElKQWh0?=
 =?utf-8?B?MFJzakplbExBTmVhZy94MHlJVmpKZklzSGkwR2NZVDBYeW5EdWhTdlZNQUk0?=
 =?utf-8?B?NmQ2VlBta0pXVFNRWmxyYzNvOE1kOTg1MlFNOXpUUFRtN2RUM01oUEh2WXhM?=
 =?utf-8?B?dFErNEtWREhqSnBYYmpJa1ZDTXlRT3B1UU9HUnlUVXh1RkhPMkZLazYyUUx5?=
 =?utf-8?B?TXVWYlFrQmo2ZDhyVUsrb3o1SVlKajFPT1cySFI2UlpiTVNHSUI3VW9hc0lX?=
 =?utf-8?B?TXBZOUUrNVNjYVJ5L2tCWlBVUjVlREFiU1NaN1pUOXVHTUo3ZncwdGs5dmFQ?=
 =?utf-8?B?R0VZRW9EL3hrRU5wWUZvUElwTHozd0VPU0JnamUwYmFJb0hCU2pjUUhZVSty?=
 =?utf-8?B?OXJqclIwNHNTUWR3bkFxdUR2ajNnRVZ1UnBzblpTdjllb3YvbndwWUpYK1VQ?=
 =?utf-8?B?STdBemdwcURla3ZPL2RvTmtDeGlPZFVra2NOak9GSHlaRnVKZmd4OUZ4ZGRY?=
 =?utf-8?B?azlBOEhCSFgyeEgwdHRlVXF1Wnl6eSthM0NYYzR2SFM4ZzZTTVZVTUZCZHI4?=
 =?utf-8?B?M3hLZng1b0htSHhiK1VkVGxraEQxbEsvMjV4QjFBcmEyVDBhc1BBdHVtUUpW?=
 =?utf-8?B?WHhMM0NFWll3emhzNFRRcFdQYTY3dUFhZEtvZ002MEJPMGMyM0xWUEdzMzJx?=
 =?utf-8?B?eHdITTFSSjQxMHRBQXJIKzlrSVJOQWplZUMya2RMK0dMYXViZGFQZzN5bWlI?=
 =?utf-8?B?RDErdWs1WTdhUnIySk5ZRjQ0OWlvTmg0R2Q2Ky80M0tvbExPQ3FPUktUKzhP?=
 =?utf-8?B?dTVZWXZldC9QUkM2c09rLzJodUNTM1ZGMFAvUXlXaHZOanl1b2V6aHIxOTBs?=
 =?utf-8?B?bTBQT0ZteTk5WUI0ZVRXU2s3bytMMDA4MXdOU0crWUp0cU9LWHF6eHNtQllS?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716bb3a3-6380-463c-c93e-08da74912aa9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 14:13:26.2758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81gNDl9tbVXqwOq3UnJss/eipSicWe9RADSxl8oDdymcO6us4ukloLhwnxVWkM+1ecAEm3RM8PaYMnoF8DkhJgYGZTCt1j/VPVMj2B4zXds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4469
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor aiocp using new LTP API
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

Hi Cyril!

On 8/2/22 15:08, Cyril Hrubis wrote:
> Hi!
>> diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
>> index d315353d0..d313fc04a 100644
>> --- a/testcases/kernel/io/ltp-aiodio/aiocp.c
>> +++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
>> @@ -1,189 +1,165 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - * version of copy command using async i/o
>> - * From:	Stephen Hemminger <shemminger@osdl.org>
>> - * Modified by Daniel McNeil <daniel@osdl.org> for testing aio.
>> - *	- added -a alignment
>> - *	- added -b blksize option
>> - *	_ added -s size	option
>> - *	- added -f open_flag option
>> - *	- added -w (no write) option (reads from source only)
>> - *	- added -n (num aio) option
>> - *	- added -z (zero dest) opton (writes zeros to dest only)
>> - *	- added -D delay_ms option
>> + * Copyright (c) 2004 Stephen Hemminger <shemminger@osdl.org>
>> + * Copyright (c) 2004 Daniel McNeil <daniel@osdl.org>
>> + * Copyright (c) 2004 Marty Ridgeway <mridge@us.ibm.com>
>> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>>    *
>> - * Copy file by using a async I/O state machine.
>> + * Copy file by using an async I/O state machine.
>>    * 1. Start read request
>>    * 2. When read completes turn it into a write request
>> - * 3. When write completes decrement counter and free resources
>> - *
>> - *
>> - * Usage: aiocp [-b blksize] -n [num_aio] [-w] [-z] [-s filesize]
>> - *		[-f DIRECT|TRUNC|CREAT|SYNC|LARGEFILE] src dest
>> + * 3. When write completes decrement counter and free up resources
> This does not render properly in asciidoc, you have to add empty line
> before the start of the list. Also I'm not a big fan of numbered lists
> so I would write this as:
>
> ...
> *
> * Copy file ....
> *
> * - Start ...
> * - When ...
> * - When ...
> */
>
> But at least please make sure to check that the html page rendered from
> the description actually renders reasonably and not as long single line.
>
>>    */
>>   
>>   #define _GNU_SOURCE
>>   
>> -#include <unistd.h>
>> -#include <stdio.h>
>> -#include <sys/types.h>
>> -#include <sys/stat.h>
>> -#include <sys/param.h>
>> -#include <fcntl.h>
>> -#include <errno.h>
>> -#include <stdlib.h>
>> -#include <mntent.h>
>> -#include <sys/select.h>
>> -#include <sys/mount.h>
>> -
>> -#include "config.h"
>> -#include "tst_res_flags.h"
>> +#include "tst_test.h"
>>   
>>   #ifdef HAVE_LIBAIO
>>   #include <libaio.h>
>> +#include <string.h>
>> +#include <limits.h>
>> +#include <sys/stat.h>
>> +#include "common.h"
>> +
>> +static char *str_aio_blksize;
>> +static char *str_filesize;
>> +static char *str_aionum;
>> +static char *str_oflag;
>> +
>> +static long long aio_blksize;
>> +static long long filesize;
>> +static long long alignment;
>> +static long long leftover;
>> +static int aionum;
>> +static int srcflags;
>> +static int dstflags;
>> +
>> +static int srcfd;
>> +static int dstfd;
>> +static long long busy;
>> +static long long tocopy;
>> +static struct iocb **iocb_free;
>> +static int iocb_free_count;
>> +
>> +#ifndef howmany
>> +# define howmany(x, y)  (((x) + ((y) - 1)) / (y))
>> +#endif
>>   
>> -#define AIO_BLKSIZE	(64*1024)
>> -#define AIO_MAXIO	32
>> -
>> -static int aio_blksize = AIO_BLKSIZE;
>> -static int aio_maxio = AIO_MAXIO;
>> -
>> -static int busy = 0;		// # of I/O's in flight
>> -static int tocopy = 0;		// # of blocks left to copy
>> -static int srcfd;		// source fd
>> -static int srcfd2;		// source fd - end of file non-sector
>> -static int dstfd = -1;		// destination file descriptor
>> -static int dstfd2 = -1;		// Handle end of file for non-sector size
>> -static const char *dstname = NULL;
>> -static const char *srcname = NULL;
>> -static int source_open_flag = O_RDONLY;	/* open flags on source file */
>> -static int dest_open_flag = O_WRONLY;	/* open flags on dest file */
>> -static int no_write;		/* do not write */
>> -static int zero;		/* write zero's only */
>> -
>> -static int debug;
>> -static int count_io_q_waits;	/* how many time io_queue_wait called */
>> -
>> -struct iocb **iocb_free;	/* array of pointers to iocb */
>> -int iocb_free_count;		/* current free count */
>> -int alignment = 512;		/* buffer alignment */
>> -
>> -struct timeval delay;		/* delay between i/o */
>> -
>> -static int dev_block_size_by_path(const char *path)
>> +static void fill_with_rand_data(int fd, long long size)
>>   {
>> -	FILE *f;
>> -	struct mntent *mnt;
>> -	size_t prefix_len, prefix_max = 0;
>> -	char dev_name[1024];
>> -	int fd, size;
>> -
>> -	if (!path)
>> -		return 0;
>> -
>> -	f = setmntent("/proc/mounts", "r");
>> -	if (!f) {
>> -		fprintf(stderr, "Failed to open /proc/mounts\n");
>> -		return 0;
>> -	}
>> -
>> -	while ((mnt = getmntent(f))) {
>> -		/* Skip pseudo fs */
>> -		if (mnt->mnt_fsname[0] != '/')
>> -			continue;
>> -
>> -		prefix_len = strlen(mnt->mnt_dir);
>> -
>> -		if (prefix_len > prefix_max &&
>> -		    !strncmp(path, mnt->mnt_dir, prefix_len)) {
>> -			prefix_max = prefix_len;
>> -			strncpy(dev_name, mnt->mnt_fsname, sizeof(dev_name));
>> -			dev_name[sizeof(dev_name)-1] = '\0';
>> +	int lower = 97;
>> +	int upper = 100;
> Why not just int lower = 'a'; int upper = 'd' ?
>
>> +	int bufsize = 256 * 1024;
>> +	char buf[bufsize];
>> +	long long i = 0;
>> +	int j;
>> +
>> +	srand(time(NULL));
>> +
>> +	while (i < size) {
>> +		for (j = 0; j < bufsize; j++) {
>> +			buf[j] = (rand() % (upper - lower + 1)) + lower;
>> +			i++;
>> +
>> +			if (i > size)
>> +				break;
>>   		}
>> -	}
>>   
>> -	endmntent(f);
>> -
>> -	if (!prefix_max) {
>> -		fprintf(stderr, "Path '%s' not found in /proc/mounts\n", path);
>> -		return 0;
>> -	}
>> -
>> -	printf("Path '%s' is on device '%s'\n", path, dev_name);
>> -
>> -	fd = open(dev_name, O_RDONLY);
>> -	if (!fd) {
>> -		fprintf(stderr, "open('%s'): %s\n", dev_name, strerror(errno));
>> -		return 0;
>> +		SAFE_WRITE(0, fd, buf, j);
>>   	}
>>   
>> -	if (ioctl(fd, BLKSSZGET, &size)) {
>> -		fprintf(stderr, "ioctl(BLKSSZGET): %s\n", strerror(errno));
>> -		close(fd);
>> -		return 0;
>> -	}
>> -
>> -	close(fd);
>> -	printf("'%s' has block size %i\n", dev_name, size);
>> -
>> -	return size;
>> +	SAFE_FSYNC(fd);
>>   }
>>   
>> -int init_iocb(int n, int iosize)
>> +static void async_init(void)
>>   {
>> -	void *buf;
>>   	int i;
>> +	char *buff;
>>   
>> -	if ((iocb_free = malloc(n * sizeof(struct iocb *))) == 0) {
>> -		return -1;
>> -	}
>> +	iocb_free = SAFE_MALLOC(aionum * sizeof(struct iocb *));
>> +	for (i = 0; i < aionum; i++) {
>> +		iocb_free[i] = SAFE_MALLOC(sizeof(struct iocb));
>> +		buff = SAFE_MEMALIGN(alignment, aio_blksize);
>>   
>> -	for (i = 0; i < n; i++) {
>> -		if (!
>> -		    (iocb_free[i] = malloc(sizeof(struct iocb))))
>> -			return -1;
>> -		if (posix_memalign(&buf, alignment, iosize))
>> -			return -1;
>> -		if (debug > 1) {
>> -			printf("buf allocated at 0x%p, align:%d\n",
>> -			       buf, alignment);
>> -		}
>> -		if (zero) {
>> -			/*
>> -			 * We are writing zero's to dstfd
>> -			 */
>> -			memset(buf, 0, iosize);
>> -		}
>> -		io_prep_pread(iocb_free[i], -1, buf, iosize, 0);
>> +		io_prep_pread(iocb_free[i], -1, buff, aio_blksize, 0);
>>   	}
>> +
>>   	iocb_free_count = i;
>> -	return 0;
>>   }
>>   
>>   static struct iocb *alloc_iocb(void)
>>   {
>>   	if (!iocb_free_count)
>>   		return 0;
>> +
>>   	return iocb_free[--iocb_free_count];
>>   }
>>   
>> -void free_iocb(struct iocb *io)
>> +static void free_iocb(struct iocb *io)
>>   {
>>   	iocb_free[iocb_free_count++] = io;
>>   }
>>   
>> +static void async_write_done(LTP_ATTRIBUTE_UNUSED io_context_t ctx, struct iocb *iocb, long res, long res2)
>> +{
>> +	int iosize = iocb->u.c.nbytes;
>> +
>> +	if (res != iosize)
>> +		tst_brk(TBROK, "Write missing bytes expect %d got %ld", iosize, res);
>> +
>> +	if (res2 != 0)
>> +		tst_brk(TBROK, "Write error: %s", tst_strerrno(-res2));
>> +
>> +	--busy;
>> +	--tocopy;
>> +
>> +	free_iocb(iocb);
>> +
>> +	if (dstflags & O_DIRECT)
>> +		SAFE_FSYNC(dstfd);
>> +}
>> +
>> +static void async_copy(io_context_t ctx, struct iocb *iocb, long res, long res2)
>> +{
>> +	int iosize = iocb->u.c.nbytes;
>> +	char *buf = iocb->u.c.buf;
>> +	off_t offset = iocb->u.c.offset;
>> +	int w;
>> +
>> +	if (res != iosize)
>> +		tst_brk(TBROK, "Read missing bytes expect %d got %ld", iosize, res);
>> +
>> +	if (res2 != 0)
>> +		tst_brk(TBROK, "Read error: %s", tst_strerrno(-res2));
>> +
>> +	io_prep_pwrite(iocb, dstfd, buf, iosize, offset);
>> +	io_set_callback(iocb, async_write_done);
>> +
>> +	w = io_submit(ctx, 1, &iocb);
>> +	if (w < 0)
>> +		tst_brk(TBROK, "io_submit error: %s", tst_strerrno(-w));
>> +}
>> +
>>   /*
>>    * io_wait_run() - wait for an io_event and then call the callback.
>>    */
>> -int io_wait_run(io_context_t ctx, struct timespec *to)
>> +static void io_wait_run(io_context_t ctx, struct timespec *to)
>>   {
>> -	struct io_event events[aio_maxio];
>> +	struct io_event events[aionum];
>>   	struct io_event *ep;
>> -	int ret, n;
>> +	int n;
>>   
>>   	/*
>>   	 * get up to aio_maxio events at a time.
>>   	 */
>> -	ret = n = io_getevents(ctx, 1, aio_maxio, events, to);
>> +	n = io_getevents(ctx, 1, aionum, events, to);
>> +	if (n < 0)
>> +		tst_brk(TBROK, "io_getevents() failed: %s", tst_strerrno(-n));
>>   
>>   	/*
>>   	 * Call the callback functions for each event.
>> @@ -192,416 +168,188 @@ int io_wait_run(io_context_t ctx, struct timespec *to)
>>   		io_callback_t cb = (io_callback_t) ep->data;
>>   		struct iocb *iocb = ep->obj;
>>   
>> -		if (debug > 1) {
>> -			fprintf(stderr, "ev:%p iocb:%p res:%ld res2:%ld\n",
>> -				ep, iocb, ep->res, ep->res2);
>> -		}
>>   		cb(ctx, iocb, ep->res, ep->res2);
>>   	}
>> -	return ret;
>>   }
>>   
>> -/* Fatal error handler */
>> -static void io_error(const char *func, int rc)
>> +static void async_run(io_context_t ctx, int fd, io_callback_t cb)
>>   {
>> -	if (rc == -ENOSYS)
>> -		fprintf(stderr, "AIO not in this kernel\n");
>> -	else if (rc < 0)
>> -		fprintf(stderr, "%s: %s\n", func, strerror(-rc));
>> -	else
>> -		fprintf(stderr, "%s: error %d\n", func, rc);
>> +	long long offset = 0;
>> +	int rc, i, n;
>> +	int iosize;
>> +	long long length;
>>   
>> -	if (dstfd > 0)
>> -		close(dstfd);
>> -	if (dstname && dest_open_flag & O_CREAT)
>> -		unlink(dstname);
>> -	exit(1);
>> -}
>> +	length = filesize - leftover;
>>   
>> -/*
>> - * Write complete callback.
>> - * Adjust counts and free resources
>> - */
>> -static void wr_done(io_context_t ctx, struct iocb *iocb, long res, long res2)
>> -{
>> -	if (res2 != 0) {
>> -		io_error("aio write", res2);
>> -	}
>> -	if (res != iocb->u.c.nbytes) {
>> -		fprintf(stderr, "write missed bytes expect %lu got %ld\n",
>> -			iocb->u.c.nbytes, res);
>> -		exit(1);
>> -	}
>> -	--tocopy;
>> -	--busy;
>> -	free_iocb(iocb);
>> -	if (debug)
>> -		write(2, "w", 1);
>> -}
>> +	tocopy = howmany(length, aio_blksize);
>> +	busy = 0;
>>   
>> -/*
>> - * Read complete callback.
>> - * Change read iocb into a write iocb and start it.
>> - */
>> -static void rd_done(io_context_t ctx, struct iocb *iocb, long res, long res2)
>> -{
>> -	/* library needs accessors to look at iocb? */
>> -	int iosize = iocb->u.c.nbytes;
>> -	char *buf = iocb->u.c.buf;
>> -	off_t offset = iocb->u.c.offset;
>> +	while (tocopy > 0) {
>> +		/* Submit as many reads in once as possible upto aio_maxio */
>> +		n = MIN(MIN((long long)aionum - busy, (long long)aionum),
>> +			howmany(length - offset, aio_blksize));
> I know that this has been in the original code, but something seems to
> be fishy here.
>
> First of all the MIN(aionum-busy, aionum), technically the aionum-busy
> cannot be bigger than aionum unless busy is negative which shouldn't
> really happen.
>
> And secondly the howmany(lenght - offset, aio_blksize) should be the
> same as the value of the tocopy variable.
>
> Also the howmany() macro seems to round up, which means that we will
> copy the whole file in this loop and there is no need for the leftover
> handling. Or do I miss something?

I think that check doesn't make much sense and we probably should stuck 
to "n = aionum - busy",
since that's the value we always need to allocate since became free in 
the previous loop iteration.

>> -	if (res2 != 0)
>> -		io_error("aio read", res2);
>> -	if (res != iosize) {
>> -		fprintf(stderr, "read missing bytes expect %lu got %ld\n",
>> -			iocb->u.c.nbytes, res);
>> -		exit(1);
>> -	}
>> +		if (n > 0) {
>> +			struct iocb *ioq[n];
>>   
>> -	/* turn read into write */
>> -	if (no_write) {
>> -		--tocopy;
>> -		--busy;
>> -		free_iocb(iocb);
>> -	} else {
>> -		int fd;
>> -		if (iocb->aio_fildes == srcfd)
>> -			fd = dstfd;
>> -		else
>> -			fd = dstfd2;
>> -		io_prep_pwrite(iocb, fd, buf, iosize, offset);
>> -		io_set_callback(iocb, wr_done);
>> -		if (1 != (res = io_submit(ctx, 1, &iocb)))
>> -			io_error("io_submit write", res);
>> -	}
>> -	if (debug)
>> -		write(2, "r", 1);
>> -	if (debug > 1)
>> -		printf("%d", iosize);
>> -}
>> +			for (i = 0; i < n; i++) {
>> +				struct iocb *io = alloc_iocb();
>>   
>> -static void usage(void)
>> -{
>> -	fprintf(stderr,
>> -		"Usage: aiocp [-a align] [-s size] [-b blksize] [-n num_io]"
>> -		" [-f open_flag] SOURCE DEST\n"
>> -		"This copies from SOURCE to DEST using AIO.\n\n"
>> -		"Usage: aiocp [options] -w SOURCE\n"
>> -		"This does sequential AIO reads (no writes).\n\n"
>> -		"Usage: aiocp [options] -z DEST\n"
>> -		"This does sequential AIO writes of zeros.\n");
>> -
>> -	exit(1);
>> -}
>> +				iosize = MIN(length - offset, aio_blksize);
>>   
>> -/*
>> - * Scale value by kilo, mega, or giga.
>> - */
>> -long long scale_by_kmg(long long value, char scale)
>> -{
>> -	switch (scale) {
>> -	case 'g':
>> -	case 'G':
>> -		value *= 1024;
>> -	case 'm':
>> -	case 'M':
>> -		value *= 1024;
>> -	case 'k':
>> -	case 'K':
>> -		value *= 1024;
>> -		break;
>> -	case '\0':
>> -		break;
>> -	default:
>> -		usage();
>> -		break;
>> -	}
>> -	return value;
>> -}
>> +				/* If we don't have any byte to write, exit */
>> +				if (iosize <= 0)
>> +					break;
>>   
>> -int main(int argc, char *const *argv)
>> -{
>> -	struct stat st;
>> -	off_t length = 0, offset = 0;
>> -	off_t leftover = 0;
>> -	io_context_t myctx;
>> -	int c;
>> -	extern char *optarg;
>> -	extern int optind, opterr, optopt;
>> -
>> -	while ((c = getopt(argc, argv, "a:b:df:n:s:wzD:")) != -1) {
>> -		char *endp;
>> -
>> -		switch (c) {
>> -		case 'a':	/* alignment of data buffer */
>> -			alignment = strtol(optarg, &endp, 0);
>> -			alignment = (long)scale_by_kmg((long long)alignment,
>> -						       *endp);
>> -			break;
>> -		case 'f':	/* use these open flags */
>> -			if (strcmp(optarg, "LARGEFILE") == 0 ||
>> -			    strcmp(optarg, "O_LARGEFILE") == 0) {
>> -				source_open_flag |= O_LARGEFILE;
>> -				dest_open_flag |= O_LARGEFILE;
>> -			} else if (strcmp(optarg, "TRUNC") == 0 ||
>> -				   strcmp(optarg, "O_TRUNC") == 0) {
>> -				dest_open_flag |= O_TRUNC;
>> -			} else if (strcmp(optarg, "SYNC") == 0 ||
>> -				   strcmp(optarg, "O_SYNC") == 0) {
>> -				dest_open_flag |= O_SYNC;
>> -			} else if (strcmp(optarg, "DIRECT") == 0 ||
>> -				   strcmp(optarg, "O_DIRECT") == 0) {
>> -				source_open_flag |= O_DIRECT;
>> -				dest_open_flag |= O_DIRECT;
>> -			} else if (strncmp(optarg, "CREAT", 5) == 0 ||
>> -				   strncmp(optarg, "O_CREAT", 5) == 0) {
>> -				dest_open_flag |= O_CREAT;
>> +				io_prep_pread(io, fd, io->u.c.buf, iosize, offset);
>> +				io_set_callback(io, cb);
>> +
>> +				ioq[i] = io;
>> +				offset += iosize;
>>   			}
>> -			break;
>> -		case 'd':
>> -			debug++;
>> -			break;
>> -		case 'D':
>> -			delay.tv_usec = atoi(optarg);
>> -			break;
>> -		case 'b':	/* block size */
>> -			aio_blksize = strtol(optarg, &endp, 0);
>> -			aio_blksize =
>> -			    (long)scale_by_kmg((long long)aio_blksize, *endp);
>> -			break;
>>   
>> -		case 'n':	/* num io */
>> -			aio_maxio = strtol(optarg, &endp, 0);
>> -			break;
>> -		case 's':	/* size to transfer */
>> -			length = strtoll(optarg, &endp, 0);
>> -			length = scale_by_kmg(length, *endp);
>> -			break;
>> -		case 'w':	/* no write */
>> -			no_write = 1;
>> -			break;
>> -		case 'z':	/* write zero's */
>> -			zero = 1;
>> -			break;
>> +			rc = io_submit(ctx, i, ioq);
>> +			if (rc < 0)
>> +				tst_brk(TBROK, "io_submit write error: %s", tst_strerrno(-rc));
>>   
>> -		default:
>> -			usage();
>> +			busy += n;
>>   		}
>> +
>> +		io_wait_run(ctx, 0);
>>   	}
>>   
>> -	argc -= optind;
>> -	argv += optind;
>> +	if (leftover) {
>> +		struct iocb *io = alloc_iocb();
>>   
>> -	if (argc < 1) {
>> -		usage();
>> -	}
>> -	if (!zero) {
>> -		if ((srcfd = open(srcname = *argv, source_open_flag)) < 0) {
>> -			perror(srcname);
>> -			exit(1);
>> -		}
>> -		argv++;
>> -		argc--;
>> -		if (fstat(srcfd, &st) < 0) {
>> -			perror("fstat");
>> -			exit(1);
>> -		}
>> -		if (length == 0)
>> -			length = st.st_size;
>> -	}
>> +		io_prep_pread(io, srcfd, io->u.c.buf, leftover, offset);
>> +		io_set_callback(io, cb);
>>   
>> -	if (!no_write) {
>> -		/*
>> -		 * We are either copying or writing zeros to dstname
>> -		 */
>> -		if (argc < 1) {
>> -			usage();
>> -		}
>> -		if ((dstfd = open(dstname = *argv, dest_open_flag, 0666)) < 0) {
>> -			perror(dstname);
>> -			exit(1);
>> -		}
>> -		if (zero) {
>> -			/*
>> -			 * get size of dest, if we are zeroing it.
>> -			 * TODO: handle devices.
>> -			 */
>> -			if (fstat(dstfd, &st) < 0) {
>> -				perror("fstat");
>> -				exit(1);
>> -			}
>> -			if (length == 0)
>> -				length = st.st_size;
>> -		}
>> +		rc = io_submit(ctx, 1, &io);
>> +		if (rc < 0)
>> +			tst_brk(TBROK, "io_submit write error: %s", tst_strerrno(-rc));
>> +
>> +		io_wait_run(ctx, 0);
>>   	}
>> -	/*
>> -	 * O_DIRECT cannot handle non-sector sizes
>> -	 */
>> -	if (dest_open_flag & O_DIRECT) {
>> -		int src_alignment = dev_block_size_by_path(srcname);
>> -		int dst_alignment = dev_block_size_by_path(dstname);
>> -
>> -		/*
>> -		 * Given we expect the block sizes to be multiple of 2 the
>> -		 * larger is always divideable by the smaller, so we only need
>> -		 * to care about maximum.
>> -		 */
>> -		if (src_alignment > dst_alignment)
>> -			dst_alignment = src_alignment;
>> -
>> -		if (alignment < dst_alignment) {
>> -			alignment = dst_alignment;
>> -			printf("Forcing aligment to %i\n", alignment);
>> -		}
>> +}
>>   
>> -		if (aio_blksize % alignment) {
>> -			printf("Block size is not multiple of drive block size\n");
>> -			printf("Skipping the test!\n");
>> -			exit(0);
>> -		}
>> +static void setup(void)
>> +{
>> +	struct stat sb;
>> +	int maxaio;
>>   
>> -		leftover = length % alignment;
>> -		if (leftover) {
>> -			int flag;
>> -
>> -			length -= leftover;
>> -			if (!zero) {
>> -				flag = source_open_flag & ~O_DIRECT;
>> -				srcfd2 = open(srcname, flag);
>> -				if (srcfd2 < 0) {
>> -					perror(srcname);
>> -					exit(1);
>> -				}
>> -			}
>> -			if (!no_write) {
>> -				flag = (O_SYNC | dest_open_flag) &
>> -				    ~(O_DIRECT | O_CREAT);
>> -				dstfd2 = open(dstname, flag);
>> -				if (dstfd2 < 0) {
>> -					perror(dstname);
>> -					exit(1);
>> -				}
>> -			}
>> +	aio_blksize = 64 * 1024;
>> +	filesize = 1 * 1024 * 1024;
>> +	aionum = 16;
>> +	srcflags = O_RDONLY;
>> +	dstflags = O_WRONLY;
> Can we just initialize the globals directly instead of here in the test
> setup()?
In the last ltp-aiodio tests, we decided to initialize global variables 
inside setup().
>> +	if (tst_parse_int(str_aionum, &aionum, 1, INT_MAX))
>> +		tst_brk(TBROK, "Invalid number of I/O '%s'", str_aionum);
>> +
>> +	SAFE_FILE_SCANF("/proc/sys/fs/aio-max-nr", "%d", &maxaio);
>> +	tst_res(TINFO, "Maximum AIO blocks: %d", maxaio);
>> +
>> +	if (aionum > maxaio)
>> +		tst_res(TCONF, "Number of async IO blocks passed the maximum (%d)", maxaio);
>> +
>> +	if (tst_parse_filesize(str_aio_blksize, &aio_blksize, 1, LLONG_MAX))
>> +		tst_brk(TBROK, "Invalid write blocks size '%s'", str_aio_blksize);
>> +
>> +	SAFE_STAT(".", &sb);
>> +	alignment = sb.st_blksize;
>> +
>> +	if (tst_parse_filesize(str_filesize, &filesize, 1, LLONG_MAX))
>> +		tst_brk(TBROK, "Invalid file size '%s'", str_filesize);
>> +
>> +	leftover = filesize % alignment;
>> +
>> +	if (str_oflag) {
>> +		if (strncmp(str_oflag, "SYNC", 4) == 0) {
>> +			dstflags |= O_SYNC;
>> +		} else if (strncmp(str_oflag, "DIRECT", 6) == 0) {
>> +			srcflags |= O_DIRECT;
>> +			dstflags |= O_DIRECT;
>>   		}
>>   	}
>> +}
>>   
>> -	/* initialize state machine */
>> -	memset(&myctx, 0, sizeof(myctx));
>> -	io_queue_init(aio_maxio, &myctx);
>> -	tocopy = howmany(length, aio_blksize);
>> +static void run(void)
>> +{
>> +	const char *srcname = "srcfile.bin";
>> +	const char *dstname = "dstfile.bin";
>> +	const int buffsize = 4096;
>> +	io_context_t myctx;
>> +	struct stat st;
>> +	char srcbuff[buffsize];
>> +	char dstbuff[buffsize];
>> +	int fail = 0;
>> +	int reads = 0;
>> +	int i, r;
>>   
>> -	if (init_iocb(aio_maxio, aio_blksize) < 0) {
>> -		fprintf(stderr, "Error allocating the i/o buffers\n");
>> -		exit(1);
>> -	}
>> +	srcfd = SAFE_OPEN(srcname, srcflags | O_RDWR | O_CREAT, 0666);
>>   
>> -	while (tocopy > 0) {
>> -		int i, rc;
>> -		/* Submit as many reads as once as possible upto aio_maxio */
>> -		int n = MIN(MIN(aio_maxio - busy, aio_maxio),
>> -			    howmany(length - offset, aio_blksize));
>> -		if (n > 0) {
>> -			struct iocb *ioq[n];
>> +	tst_res(TINFO, "Fill %s with random data", srcname);
>> +	fill_with_rand_data(srcfd, filesize);
> Shouldn't we run this once in the test setup? I guess there is no point
> in re-generating the file each time with -i 10 passed to the test.
>
>> -			for (i = 0; i < n; i++) {
>> -				struct iocb *io = alloc_iocb();
>> -				int iosize = MIN(length - offset, aio_blksize);
>> -
>> -				if (zero) {
>> -					/*
>> -					 * We are writing zero's to dstfd
>> -					 */
>> -					io_prep_pwrite(io, dstfd, io->u.c.buf,
>> -						       iosize, offset);
>> -					io_set_callback(io, wr_done);
>> -				} else {
>> -					io_prep_pread(io, srcfd, io->u.c.buf,
>> -						      iosize, offset);
>> -					io_set_callback(io, rd_done);
>> -				}
>> -				ioq[i] = io;
>> -				offset += iosize;
>> -			}
>> +	dstfd = SAFE_OPEN(dstname, dstflags | O_WRONLY | O_CREAT, 0666);
>>   
>> -			rc = io_submit(myctx, n, ioq);
>> -			if (rc < 0)
>> -				io_error("io_submit", rc);
>> +	tst_res(TINFO, "Copy %s -> %s", srcname, dstname);
>>   
>> -			busy += n;
>> -			if (debug > 1)
>> -				printf("io_submit(%d) busy:%d\n", n, busy);
>> -			if (delay.tv_usec) {
>> -				struct timeval t = delay;
>> -				(void)select(0, 0, 0, 0, &t);
>> -			}
>> -		}
>> +	memset(&myctx, 0, sizeof(myctx));
>> +	io_queue_init(aionum, &myctx);
>>   
>> -		/*
>> -		 * We have submitted all the i/o requests. Wait for at least one to complete
>> -		 * and call the callbacks.
>> -		 */
>> -		count_io_q_waits++;
>> -		rc = io_wait_run(myctx, 0);
>> -		if (rc < 0)
>> -			io_error("io_wait_run", rc);
>> +	async_init();
>> +	async_run(myctx, srcfd, async_copy);
>>   
>> -		if (debug > 1) {
>> -			printf("io_wait_run: rc == %d\n", rc);
>> -			printf("busy:%d aio_maxio:%d tocopy:%d\n",
>> -			       busy, aio_maxio, tocopy);
>> -		}
>> +	io_destroy(myctx);
>> +	SAFE_CLOSE(srcfd);
>> +	SAFE_CLOSE(dstfd);
>> +
>> +	/* check if file has been copied correctly */
>> +	tst_res(TINFO, "Comparing %s with %s", srcname, dstname);
>> +
>> +	SAFE_STAT(dstname, &st);
>> +	if (st.st_size != filesize) {
>> +		tst_res(TFAIL, "Expected destination file size %lld but it's %ld", filesize, st.st_size);
>> +		/* no need to compare files */
>> +		return;
>>   	}
>>   
>> -	if (leftover) {
>> -		/* non-sector size end of file */
>> -		struct iocb *io = alloc_iocb();
>> -		int rc;
>> -		if (zero) {
>> -			/*
>> -			 * We are writing zero's to dstfd2
>> -			 */
>> -			io_prep_pwrite(io, dstfd2, io->u.c.buf,
>> -				       leftover, offset);
>> -			io_set_callback(io, wr_done);
>> -		} else {
>> -			io_prep_pread(io, srcfd2, io->u.c.buf,
>> -				      leftover, offset);
>> -			io_set_callback(io, rd_done);
>> +	srcfd = SAFE_OPEN(srcname, srcflags | O_RDONLY, 0666);
>> +	dstfd = SAFE_OPEN(dstname, srcflags | O_RDONLY, 0666);
>> +
>> +	reads = howmany(filesize, buffsize);
>> +
>> +	for (i = 0; i < reads; i++) {
>> +		r = SAFE_READ(0, srcfd, srcbuff, buffsize);
>> +		SAFE_READ(0, dstfd, dstbuff, buffsize);
>> +		if (memcmp(srcbuff, dstbuff, r)) {
>> +			fail = 1;
>> +			break;
>>   		}
>> -		rc = io_submit(myctx, 1, &io);
>> -		if (rc < 0)
>> -			io_error("io_submit", rc);
>> -		count_io_q_waits++;
>> -		rc = io_wait_run(myctx, 0);
>> -		if (rc < 0)
>> -			io_error("io_wait_run", rc);
>>   	}
>>   
>> -	if (srcfd != -1)
>> -		close(srcfd);
>> -	if (dstfd != -1)
>> -		close(dstfd);
>> -	exit(0);
>> -}
>> +	SAFE_CLOSE(srcfd);
>> +	SAFE_CLOSE(dstfd);
>>   
>> -/*
>> - * Results look like:
>> - * [alanm@toolbox ~/MOT3]$ ../taio -d kernel-source-2.4.8-0.4g.ppc.rpm abc
>> - * rrrrrrrrrrrrrrrwwwrwrrwwrrwrwwrrwrwrwwrrwrwrrrrwwrwwwrrwrrrwwwwwwwwwwwwwwwww
>> - * rrrrrrrrrrrrrrwwwrrwrwrwrwrrwwwwwwwwwwwwwwrrrrrrrrrrrrrrrrrrwwwwrwrwwrwrwrwr
>> - * wrrrrrrrwwwwwwwwwwwwwrrrwrrrwrrwrwwwwwwwwwwrrrrwwrwrrrrrrrrrrrwwwwwwwwwwwrww
>> - * wwwrrrrrrrrwwrrrwwrwrwrwwwrrrrrrrwwwrrwwwrrwrwwwwwwwwrrrrrrrwwwrrrrrrrwwwwww
>> - * wwwwwwwrwrrrrrrrrwrrwrrwrrwrwrrrwrrrwrrrwrwwwwwwwwwwwwwwwwwwrrrwwwrrrrrrrrrr
>> - * rrwrrrrrrwrrwwwwwwwwwwwwwwwwrwwwrrwrwwrrrrrrrrrrrrrrrrrrrwwwwwwwwwwwwwwwwwww
>> - * rrrrrwrrwrwrwrrwrrrwwwwwwwwrrrrwrrrwrwwrwrrrwrrwrrrrwwwwwwwrwrwwwwrwwrrrwrrr
>> - * rrrwwwwwwwrrrrwwrrrrrrrrrrrrwrwrrrrwwwwwwwwwwwwwwrwrrrrwwwwrwrrrrwrwwwrrrwww
>> - * rwwrrrrrrrwrrrrrrrrrrrrwwwwrrrwwwrwrrwwwwwwwwwwwwwwwwwwwwwrrrrrrrwwwwwwwrw
>> - */
>> +	if (fail)
>> +		tst_res(TFAIL, "Files are not identical");
>> +	else
>> +		tst_res(TPASS, "Files are identical");
>> +}
>>   
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.needs_tmpdir = 1,
>> +	.options = (struct tst_option[]) {
>> +		{"b:", &str_aio_blksize, "Size of writing blocks (default 1K)"},
>> +		{"s:", &str_filesize, "Size of file (default 10M)"},
>> +		{"n:", &str_aionum, "Number of Async IO blocks (default 16)"},
>> +		{"f:", &str_oflag, "Open flag: SYNC | DIRECT (default O_CREAT only)"},
>> +		{},
>> +	},
>> +};
>>   #else
>> -int main(void)
>> -{
>> -	fprintf(stderr, "test requires libaio and it's development packages\n");
>> -	return TCONF;
>> -}
>> +TST_TEST_TCONF("test requires libaio and its development packages");
>>   #endif
>> -- 
>> 2.35.3
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
