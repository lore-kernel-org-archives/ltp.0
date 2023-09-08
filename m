Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C38EE57E7
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 09:29:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 163683CB54B
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 11:29:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC8C03CB4F9
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 11:29:18 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DD70260142D
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 11:29:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AV4WcznEUKhZGqRsA/7Dkv4UpB6UQzTGEQ/mN3spV2hVtOLaWHWIYSRdaQLkB1v3byRMt0NNEZ/2pNtiIwtGNW8sfmyetaXq1g1zgI/+10lI5wwVHR+bd3EAYzjqdcPVCJIG0AjA5SW6egUt6WxN+ZXpLJa+zCqaPzluyzcvbm2FoLGm0Oo3pfYKlNw4cDjJiAtsnH0LrI9iBfmQpg5waOcK80NJMwP33oY0dKWyLcSi3d2pu5Id2JVI3DNBgNlkhsoq4sICgBNBlkuTKiuEOM6nS20SqP+NMkWywqfietgVuoEVMI3ebksWr4OASQMa5c6fZWKrQjOplhFc8r0ilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hfrafmzWBnunwaaWkHYqaxRq3CL/lk7G5tm//V5GLs=;
 b=kDkTzTodXEZcNOjDbWkGH3gw5H6iSCW7ZHbKq1vgGmIv0w+X+FuUjUe/vjcQ1K6DBnUN0/zifpEWsPOjNXA1j2ImJWhK+abiVW3isiX5JCuSVeo29Pa0OZRcf61Vc4ht4fNRmITRzOMHBgMebcayt7ndgUlweG4LkQHdF7+pABN2+he6F0jTGVqIG6RjWgDwpB+FcpcXqaWKd8SeeR0xOTowEPchMcQSlvovcrJFu/f6DBG78i63WYfiioguIIuVXKrAyy4keA0TrhtPYmQX/s8jV8CxPwEnVI5dOZjmtl2ZS7Ozq5nynu19R88I3zrhVYZRYXnGE4JvrzLyhZoJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hfrafmzWBnunwaaWkHYqaxRq3CL/lk7G5tm//V5GLs=;
 b=GvEnUW9b9/FhhEdTYCqwpLJE1R7I+6AUdc7U2GId9owPUnql7+TAni4Op6ckLoMyH7bT1pJaKETLgCFbZxMwNSLIs06PHLsepniTL/OSI2Pau0jsbEGRWzqMGxy1dUoKpY/ikRQQI6VIPJnZYrI/9UY967NqmF+XCy7TFpQzi6SXrnuBZguPDa//avF8Wbce6NV7ZNmE1q9h+kMKMlDejdGXdwFwHJThhontY34+EZVzBFffEhf5I5JtjL5dkJ35BBg32u1Svj2Gwl/ncZdNHtqMD2XKDVwGuqTmEfVjpU+IaWeIKvv+vbZBpSzGEUH/LCU5cHxHkmlM6LwWQ/3qOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Fri, 8 Sep
 2023 09:29:16 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6745.030; Fri, 8 Sep 2023
 09:29:16 +0000
Message-ID: <556d4831-16c6-4c83-b46f-ad7fbd90384a@suse.com>
Date: Fri, 8 Sep 2023 11:29:14 +0200
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20230905125950.14756-1-andrea.cervesato@suse.de>
Content-Language: en-US
In-Reply-To: <20230905125950.14756-1-andrea.cervesato@suse.de>
X-ClientProxiedBy: FR2P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::11) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PA4PR04MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 18877bef-9795-424e-033c-08dbb04e1208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kz7UmiqIlj8etn4vYaaRWw74oaVz6Ui7HM3sWzluGyWWdr7dEyFhuWMcFrBwLTmCbPAL8nsyxuRbvhcUKcql7qtA9hGFYf02vkWcgCOXStPh2/VPDrUIjLJH6mfjmto668sgdH8qBx9P7mkd2v0qkKBb3aJjo1iGtGxJDtq3LGrrGm1BMxj1z/UOsXXAenzOeP56veNImpbqIA4h8pRJELM3J5a61ttee3tjUeyFeAzF0kKj85cDuokabxbedWYl6EzuccoRD5zSxY/RgHHSwHKVsxNW25hpvQpU9tvBrXGzOmDeaZspG8wKmsL5PG1Y0jX6lqt9B1zK4o4im8GPPbR5Kd5NyPQtrBruKyiD45bmFzbKvkIOu4ANhelqzW2/iRoX2DBqtRLTKtyerjtsVU0ESZHPFrdh6ZhBn5BN2jkOLeiNn/gw3HPg2pEBPQPlWcHH8YaV/ITzpcGzjrrQUwM7k3Wr8l7YUtHEaCj0gTtDbJZ3ifcQJSQZRUKnklQI3+1OIaFSVU5aaJLgzfCM2vUTgwySYcfQb+u1aV+AK+/iXlQ3PFknvmJ3XkirmFxbYBS9pInonfKoFSL5OTPmpSV1c3k9lJOW5N74Kfmfd/Tty2m2Qk50UpY1jTWh/adWdRa5LyCVnimwSwM7mnAIPUNl1tF5K7aaTERuSGCIKpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(1800799009)(186009)(451199024)(2906002)(38100700002)(36756003)(31696002)(86362001)(2616005)(26005)(8676002)(8936002)(44832011)(5660300002)(66476007)(53546011)(41300700001)(66556008)(66946007)(6506007)(6512007)(316002)(6486002)(31686004)(478600001)(83380400001)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjdQQUtqSm9DMFRCdnU3R1JzM1ZXQStkK3lFMzl6RGRuaWU1YW10Zi9sRGhz?=
 =?utf-8?B?NFIyUUZaUG1neWhRWXErQmNTeTlXZ2JIMmZsTUNTY2VPZEFHR2J4TXhlbldM?=
 =?utf-8?B?NWloM2VWU0MxNlFTY2ZMbkRLMTJaSkRIa3NuVjlLbTM2RG5RZSs4T2R6d1NN?=
 =?utf-8?B?dm5VQW1FanBWbE90UGRwRWc0d1Yvb1REdEp5RngyQ2NhaTdQdnpDUGxkSkVs?=
 =?utf-8?B?cGhDbDhwQUZxODVtekdPVXJqam9SVHQzV044ejB2WEVsdDZXdkE4QnQwTDU4?=
 =?utf-8?B?UExMdmlKazBJQ0pWN0FJdmRwcjVGV2tmaUkwWTYwSStpQ0ZDbDhqVUw5alN1?=
 =?utf-8?B?cnJROWY2by9CcWluWnBGbHZiWUNBdFExSzdmSEFTRnNrSFQ0SlIwOXl0UjJF?=
 =?utf-8?B?ZEZGaUxJRGtnbkZWUzlQVmNaMXFDc0lkQ2NUTVp5YzdWR1ZUeS80Vzc1K1gr?=
 =?utf-8?B?TnA4Q1l2YUZTMGlLUjR6QlRFSURGbm1wdTkwT0pGU0NVMkdzNE5hZGVTS3Mw?=
 =?utf-8?B?WEVRK2M2c2FGNGt6TW9kamJhYU9xZ3dvMDFhU1ZDbWEwM2UyMUE5RFdZdHpC?=
 =?utf-8?B?R1ZIOVlNUmRCS0NTT0pQVUtuWTRvMUs3Z3VQSk9PTXFWenczN2hueDBxM0RO?=
 =?utf-8?B?Rks2NVdZN0g2Qmk4OEdtMU0wcWM0cFRNRTY1MldKb29UZ0IwWVllcVloaXlW?=
 =?utf-8?B?S0d0YncrM0paYlB4U0VJZ01RQzNXekE0VzFMNldEYUtHdFpjZlhFSFQ1R3pD?=
 =?utf-8?B?ek5ZZU9jSndRWHNPYUZPNzB1dWtEQUFFN0kwZ2M0dGRsNmxHZ3h3OTRteTk3?=
 =?utf-8?B?V3pBWTJFam5UQlZCU2t6ZzF2MWxHelJoeGhXKzlpSzRhOGlEekR4WXJqMk9C?=
 =?utf-8?B?c3V2TW1qWlJjTGNWZDVoaVpZQTd0aENCNlg3Z2I2STFlb1BvZGYreDJlaE9G?=
 =?utf-8?B?TmtqdTllWWxFT1pHTHZLNW52L2dlNS9FWW1URnFDbWxWcHY3Qlh5RW5kOGhV?=
 =?utf-8?B?blpJYVlYZFFrUmFLa3YzVElnME1OOVhtZUJ0dkxIUkFLTzR1dFJNa20rOHMv?=
 =?utf-8?B?OFE1WFVWNEZ4d1JVVmEvb0QwVHJ3OTZKTTQzMUJ1aHdzd3pDS3owY0VoRVN2?=
 =?utf-8?B?OXZ5aGhrQWJlNUxVZXBDemM0R2ZjVG5hWjV3UVZ6K040R1ZIRTBpVno1eksy?=
 =?utf-8?B?cGFEcFgxS1Fac3h3cXpvdUxKcTVpaktpTzFwL2tWWkpWNzF5aDRpbzhoK0Ns?=
 =?utf-8?B?OUx1SndwdHJic2hid01XZmEwRDRCMWtIZFNqcUhqSEdJeGNvTThsN3ZIbk9H?=
 =?utf-8?B?Zk5zOTdYb21vb1QzOGN6R3ZYcENNbFBLMGVEK3B1TExwcHhhNk9OeEE3d3cw?=
 =?utf-8?B?ZHkzN05WdFBXQ3FrWUR4M252Y2dvdm96eHpaNjdJOWhyYStYWHhTV2lYUzNR?=
 =?utf-8?B?UmZPczN3NGxXL24xb3FTdVZEQWt4MHdxMFFnYTdsYjI5QVpsRk03dW1HcG10?=
 =?utf-8?B?TWpZL1dSSWlMMWdWTGNQRXg2NlFBQ2VReTE5UGlSaDRvMVJ1Yi9wWFZUL05o?=
 =?utf-8?B?Wk9KaE0xZnFOZmVuYXA0M1RiUkQ4K2lUSEIzQXVYNVptcEV5Q3ljMVJ3ZHMy?=
 =?utf-8?B?aE9IYnB0UFRtY1lDL2h2VjI4WTh2REhlMm1MQytGTjJQMmpCeTZOU0pOTnEx?=
 =?utf-8?B?TTVBTHA4ZWVFZmRaK3hDdmdSeFZldGIwR2tobXdMQ0M3dFgxWlF6aVoySjd2?=
 =?utf-8?B?TWxFcURWTml0TGFMR2JOVC9jOElEdVRGekhXSytScGhEcXh1eFpFNml4bFcy?=
 =?utf-8?B?a3hvdkMwaVhYb3NZOEhkMlZjWTZISEhtWW1PSk82dWJIbU10eGoybjJRbjZ5?=
 =?utf-8?B?TU5HdVgvQUhUK29BQWtXbnR1M3JJbGlKN09XWnJKY3FsM2JYWjVQMXNrOWRK?=
 =?utf-8?B?dzlYdktMcS9vZ3VqblZsZlcxVVA5QW9YMmIzRHVVd2lIOHAzYXZ2QkcrQ3Av?=
 =?utf-8?B?NGtIa1F3cFNhVjJHNkQ2QkFKQitNcHgrUFZsVEp3RkFPUm5XM3doL1NJNzlh?=
 =?utf-8?B?a0Y1YjBuWE1FM2NhM3BGUVY4RzA0VmVONkVENjB3U2c4L3BSR0FYZnpqcVZM?=
 =?utf-8?B?cEVRMkFlbFZLYVRycVpaakF4Z2llQUtqL29ERnlELzlHdG9DaTFqOTRRTXhO?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18877bef-9795-424e-033c-08dbb04e1208
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 09:29:16.2278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTlodbP8UP0GMKbbhuKCPXQx3X/vdv5zTUR2eWlmJo3Z2+UGmGw3Qn3BXLfl+itEKerNIlr7mtTXd1wfy77VwJt8Io3Ic0NmGKlFRNUfYhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9247
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor fork11 test using new LTP API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

please ignore this patch and check "[PATCH v1] Merge fork06 and fork11 
into new test" instead.

Thanks,
Andrea Cervesato

On 9/5/23 14:59, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   testcases/kernel/syscalls/fork/fork11.c | 106 +++++-------------------
>   1 file changed, 23 insertions(+), 83 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fork/fork11.c b/testcases/kernel/syscalls/fork/fork11.c
> index 6afda3a33..de5840646 100644
> --- a/testcases/kernel/syscalls/fork/fork11.c
> +++ b/testcases/kernel/syscalls/fork/fork11.c
> @@ -1,97 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - *
> - *
> - * NAME
> - *	fork11.c
> - *
> - * DESCRIPTION
> - *	Test that parent gets a pid from each child when doing wait
> - *
> - * ALGORITHM
> - *	Fork NUMFORKS children that do nothing.
> - *
> - * USAGE
> - *	fork11
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> + * Copyright (c) International Business Machines  Corp., 2001
> + *     07/2001 Ported by Wayne Boyer
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +/*\
> + *[Description]
>    *
> - * RESTRICTIONS
> - *	None
> + * This test spawns multiple processes using fork() and it checks if wait()
> + * returns the right PID once they end up.
>    */
>   
> -#include <sys/types.h>
> -#include <sys/wait.h>
> -#include <stdio.h>
> -#include <errno.h>
> -#include "test.h"
> -
> -char *TCID = "fork11";
> -int TST_TOTAL = 1;
> -
> -static void setup(void);
> -static void cleanup(void);
> +#include "tst_test.h"
>   
>   #define NUMFORKS 100
>   
> -int main(int ac, char **av)
> +static void run(void)
>   {
> -	int i, pid, cpid, status;
> -	int fail = 0;
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	pid_t pid;
> +	int status;
>   
> -	setup();
> +	for (int i = 0; i < NUMFORKS; i++) {
> +		tst_res(TINFO, "Forking the %d process", i);
>   
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> +		pid = SAFE_FORK();
> +		if (!pid)
> +			return;
>   
> -		for (i = 0; i < NUMFORKS; i++) {
> -			pid = fork();
> -			if (pid == 0)
> -				exit(0);
> -
> -			if (pid > 0) {	/* parent */
> -				cpid = wait(&status);
> -				if (cpid != pid)
> -					fail++;
> -			} else {
> -				fail++;
> -				break;
> -			}
> -		}
> -		if (fail)
> -			tst_resm(TFAIL, "fork failed %d times", fail);
> -		else
> -			tst_resm(TPASS, "fork test passed, %d processes", i);
> +		TST_EXP_EQ_LI(SAFE_WAIT(&status), pid);
>   	}
> -
> -	cleanup();
> -	tst_exit();
>   }
>   
> -static void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> -}
> -
> -static void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
> +};



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
