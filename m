Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F70BC71153
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 11:20:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78FDF3CB8D6
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 13:20:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CE483CB821
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 13:20:43 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 05958100098E
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 13:20:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRFe6cyrvnIAea7PNc31Bek+FQ/7eo9krRqSofXcwlVv2hjEw8yl1Vp/TThN2Y0IFwmwKeIaMOX5hc/rbAv43Th9oMZCi7bv5A90TXILU570JGZxf6nFgzc9ReU9SGpUygsjlLJ8YVF5ksmGe80HSlc5P9RyqB2fGLwi1FlfDzq14ttY/u7zKdwVMr1NnK4zHZuNFTj2aKlysXO1FvY8TKwcY0pdDDR1exe5odOkFMEdrJWBqzJT+oJ9PSq5TlGutaO4F6evZbW6uITOpcjtVyQcn4ux4mE0QCjtH0mDLxK46kFHdo+MjLbrGkymz7SGu+8J1q1ya3c6YHNlSqswIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAKtGiBBOV/ZTXsCBDpbMLG/A1ztLh6AStU5tqtE11s=;
 b=kjqQJf5i55PDpJfT8VX13mauA+r7iCSS7Qn/TdMOPnYWd2qYk/jbwuNgNseRRiAzAAH3Hmg1iLdCDEfBYaZVui3OJ7cL4Yy4FHCEqwxsu5WQa/uMvDIvsJCXza5d+KfepWHp6UMtLNlsZXt9zXTIK1wJ1etkWy37xgFPCO3mp/FpUC2AHwcP6x2cytdUlnyR8AMXjldUOJ9c1cKQAupKTiKGM27w6Cy9+JZIrxJuBqB/FC28oGEk8avN1k3/13HEdrrtX3A6ASNrFQEaCUT/NS/ebuUmA3aTr8Lwip+jb9v7de83l9DOc2qnho18cB5DJZBdK5MyNalfvGGfCOLjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAKtGiBBOV/ZTXsCBDpbMLG/A1ztLh6AStU5tqtE11s=;
 b=NSnYam+CkdlamtfK9XvuBZwteYLuRDC8RutGv8UflAszmB65i5vkcDncRpX+NqNVmBrssj36p0Av3Zis0SpeFtNFOJxnr+TfnRLeZlvFhA1Iwxj4uywA0lqN1n5kO+Q5Bhh4coiPS+r2w/0Yqk7FrO/w6vRwQ0bTJA/wbAIjl+ZVO/2z1A9pNa72seo2ezSRkq7yLvGMW0/4pYxCSbK/Ghy8voqJ8BbmSWuevdOByGZhHo+XuWBeu2PhkxSFtX/FCYgHuoA/7RyGtUCYbawmW09V3qpy/3KOz5ydjbuvRtREH2g61P1SYb3SgmIZ8Koy7DAHD12RKYQbunk28eKoQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DB9PR04MB9645.eurprd04.prod.outlook.com (2603:10a6:10:309::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 11:20:40 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 11:20:39 +0000
Message-ID: <984b4789-6064-452f-8894-b0385232089c@suse.com>
Date: Mon, 4 Sep 2023 13:20:34 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
References: <20230904110028.23393-1-andrea.cervesato@suse.de>
In-Reply-To: <20230904110028.23393-1-andrea.cervesato@suse.de>
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DB9PR04MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 377184ae-702f-4a5b-1428-08dbad38f82e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/CzP70ULBuzbaLcoAz1c0L35PmLzpcngHQyJbjNvVrtUWPe6t/XH+IclU+gnEn/lSrsTk+eAfUqBSfw+IM8aqtHJrv/VpIK03wdCtP/+Xc7gqFgCd93ptC4etTmldrNY+Ef9yi4PXoq0PqR5uKtnczAM9pQEIJaYy4ghsuItXSlhaiovAd+0emnWFbvz2ALFWDoCCgCGDECXkq2CeNX/my5YQtgp+7x1+gxSIHVZXNICwhABjDRlpIFHmUuUs26OFp9fhzay/5bpOmUWKNl+UFJ9w43Fwic4Bi6+t5+LZSn/iYT9Aabd6MK72Jl5YcQ8Nx2hcjq/emPSYOkrGFozbjkUv5AU5aKqOxCSJTviTX5XoFpgYzhGIawUuRlWmmDQzvQvgIRrvEo+hinE/x6cCZx362E5s2Y666J1izzfZSZo3N5Qbi807f45YfrzNv/gzPD3kOXqFXO5TAIAqaKECV63cFKp1IhacqYsows/YF226KwFu3tRBD0QqpT4joWnEFhPk+8B9thmccEc/3z603ZzWGnLZa3IMEHiInHjzZDUVuBUjjh9dvqSpPIaSUmRVDLWwH0Bf4A01f0+dCr62THPS/FBhrbilTj7+a1V4naSCvAAO8FpPnRdK9fflsENaDw9OTp49SJXbnU5vyx6XuA50dSIIUyuO9oNbG4Wl0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(186009)(1800799009)(451199024)(6486002)(53546011)(6506007)(41300700001)(6512007)(2906002)(36756003)(316002)(31696002)(38100700002)(86362001)(6916009)(66476007)(478600001)(66556008)(66946007)(6666004)(8676002)(8936002)(44832011)(26005)(31686004)(83380400001)(5660300002)(2616005)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHVUdDFWeDBnTW0rOWtrU1J4QndXbThkTjJrZ0YxY1o3STJsaVpBMzRtMnlV?=
 =?utf-8?B?ZWpHZDUybERUdU1ZTng0RXpEcHUwTG83aDJKSmE0ZlRvNkU4TEJ4aWxLL2Z5?=
 =?utf-8?B?dW9uWlBaa1ZyZTR4VjhmMXZ4eUtGMlFDRVd5VDlkenVBNE9KazZqdUZoLzdr?=
 =?utf-8?B?aWlidlJLQ2IyaHQrR0c5UjhTRExCV3hHVEZHL3o4THc5aVUxTWQrNDhSbHZ5?=
 =?utf-8?B?K1VvdGNOUVoydmlpdituNi9MaUplOGFGak16bzJZc0RBSGM5RVh4bUNCRHBy?=
 =?utf-8?B?cWw5ZWo0WExGSDIzQW8wUVV5U1lOSHhTSzhlamZ2eHpKQk9QUVJvaFovR2Jq?=
 =?utf-8?B?QlBxY0l0QjJTV0lxTHFoaktZbkRiUmIzTm1aRVgzdElFTk45cTRqUzV5SnhJ?=
 =?utf-8?B?Wmt4bm12SW5HTFpYMGRYLzZJajEwZFFRc2JLbU9HZGlrWGwvQ1NuZFZ5V1ZU?=
 =?utf-8?B?RThFbis3SjdEeXRSTTRlTC8xbWczelV1djdxV2t5clc0dVVqbklJUXdhSnpR?=
 =?utf-8?B?bHR2TzJ0UzE5b0M4ZzBXUkJObWhsVFpLSlJNWDRoTlRxN2Y0bE9JWldzTGxs?=
 =?utf-8?B?ZnhreHpGQnNYeFF5RnUwZERTNDR1eGQxSkdGV2RMUUsxenlHc1M3dmd5VHhJ?=
 =?utf-8?B?OXVld3RJK2ZQWVRiYU9LM0crdzRmV1NLZVpSdE9NblNla2lSMlNVQnpMZDA3?=
 =?utf-8?B?OXBBRUp2Y0FrZUFyRU9hNXdIZTk1TDB3djNHbWRaWWc0YVV0MFFXdDNpemhv?=
 =?utf-8?B?VVJMUmFkQlQzTVgwN2lGZEFMenpCT0IzT3M5TURvR0VmeUw5QmcwM2xuZEFO?=
 =?utf-8?B?WTJXVStOLzJiZEt4Q2V3OFRva1FJbzcycWV3THJMQWQrYzhzZHVranh0eklt?=
 =?utf-8?B?bENzalVkd2lsTkZmWHozQ2UyZ2V3TUFaQkNpRVM0SnUrbXZ6RU1yUERkc3l2?=
 =?utf-8?B?R2JlaXh0SjY4UW9adXZXczlZdWRNT3VuU3phN0YyRzA2S3NpczBqWlhZYVZX?=
 =?utf-8?B?ZkIrc21sTHkwWTV1VzdYU1ozZHdtZ0tnQS9FaENSelZkMWphYk1obmZobkt1?=
 =?utf-8?B?TFB6emJEWExRN1d4VUlpRnlTdzNaZ2xrUlNzRnpTbmlYdDZ5cTE4VExENm52?=
 =?utf-8?B?dGx5ZUY3MnlxSmdNWkRXblFQaDlGdjBCRms3TERaOTdsSGkzUVZ5U3FqZkw3?=
 =?utf-8?B?MzRIL1Rsbjhjc0g4N1ZMaml2YURkRWN0THVTci9hUDVUenBUbE1hQy9STHZl?=
 =?utf-8?B?S0ZhY1VHNkZzdmdkTHAvcXQvU0EyWXVJUjcyT1dWMVpjbzJmemdsWW1OR0l0?=
 =?utf-8?B?L2FtMGZvVG9nckVhQlBXeGd6WkhzS3o3alkvT0lSQVd6Q2FoYzNOKyt1dWJn?=
 =?utf-8?B?WFY4N2RtTVVpOU9YcFYrSVpqdCtyTXFBcGV6SlQ2czdxaGJDK1ZMTWU4NEor?=
 =?utf-8?B?cVJCOGVpWU9FTFZsUkNYL0ZZU09OdTBJaW9PUVZESkNGcllhdkdXUUpNazhL?=
 =?utf-8?B?Z1M5YVludWVzZ0tTcFNmQkx3WmxPRk1OY2hRRmlXUlpuUW9oR0ZiY2pKK0xM?=
 =?utf-8?B?cE1kUXJMUFV5NndaK1N2MmF4L3gxdGM4Zk5EREhZVGNzMGkvY2tkUitHMW9T?=
 =?utf-8?B?VktrZm1OeVVreG4yNFBjWkM4V3JwY0JDWGluOFJJcHZzZ0VzdDBhOEs0OUhL?=
 =?utf-8?B?WXp1ME9kc2dRUXlFQnF6dDFWYmN6ZVlXR2owd0Jmd0tLOEhpRXZDTTFFMk0r?=
 =?utf-8?B?RkgvUmNsNVgvd0RlUjVES3BLNmpoTWdqVEl2RlMxeUJTSWZZUXprZU42OGVB?=
 =?utf-8?B?VWZQQ2huc1VKVXk5b0RwbWJwdmhzMEU2OUxuQ3pTM1lzSUhhK2hqcGJZTTE2?=
 =?utf-8?B?bktYNXBqMEVDcGpmYXRiRTlWR2wvVWFlcVovUEhDVTEyZjFzdmo4eU41Z1Fo?=
 =?utf-8?B?ZGZnQ0czK01CQi9naC8zM0YwRDhkSlFEOEVhYXRiVk11QjFrcHhDZ1JrUkty?=
 =?utf-8?B?WUEyR1FkRHEwelhnWUZHYUpqUmhXLzh4RVZ3SWRZbWl4NjR1eHFRSHgwRDZW?=
 =?utf-8?B?VS9xRkFoTmlMT2JPYndvSko0UVNjcVEvMVVvNm1DV2lodTRsSHBwMXZHc016?=
 =?utf-8?B?cGtEU2FsQ3N2OG5nOGk5QzVaME9XRzl2T0ZoYzdRZm9ySWJxTDNvLzNvbVkz?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377184ae-702f-4a5b-1428-08dbad38f82e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 11:20:39.7994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnfnn+E/CALUr2Yw6fNfjkzuGL7D6OzEVEiWwxzjO/po7sA4iW932gslu43lRXXGlbCJj2/iLVx00Nc9h/7fIdaODadvoAHyS07Gku5giT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9645
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor timer_getoverrun test using new LTP
 API
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

please consider v2 instead that also checks for glibc.


On 9/4/23 13:00, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   .../kernel/syscalls/timer_getoverrun/Makefile |   2 +
>   .../timer_getoverrun/timer_getoverrun01.c     | 106 +++++-------------
>   2 files changed, 32 insertions(+), 76 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/timer_getoverrun/Makefile b/testcases/kernel/syscalls/timer_getoverrun/Makefile
> index 1273a4e9c..58376e379 100644
> --- a/testcases/kernel/syscalls/timer_getoverrun/Makefile
> +++ b/testcases/kernel/syscalls/timer_getoverrun/Makefile
> @@ -5,4 +5,6 @@ top_srcdir		?= ../../../..
>   
>   include $(top_srcdir)/include/mk/testcases.mk
>   
> +LDLIBS			:= -lrt $(LDLIBS)
> +
>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
> index aa9881f27..cb221268d 100644
> --- a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
> +++ b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
> @@ -1,88 +1,42 @@
> -/******************************************************************************
> - * Copyright (c) Crackerjack Project., 2007                                   *
> - * Porting from Crackerjack to LTP is done by:                                *
> - *              Manas Kumar Nayak <maknayak@in.ibm.com>                       *
> - * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>                          *
> - *                                                                            *
> - * This program is free software;  you can redistribute it and/or modify      *
> - * it under the terms of the GNU General Public License as published by       *
> - * the Free Software Foundation; either version 2 of the License, or          *
> - * (at your option) any later version.                                        *
> - *                                                                            *
> - * This program is distributed in the hope that it will be useful,            *
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of            *
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  *
> - * the GNU General Public License for more details.                           *
> - *                                                                            *
> - * You should have received a copy of the GNU General Public License          *
> - * along with this program;  if not, write to the Free Software Foundation,   *
> - * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
> - *                                                                            *
> - ******************************************************************************/
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) International Business Machines Corp., 2001
> + * Porting from Crackerjack to LTP is done by:
> + *              Manas Kumar Nayak <maknayak@in.ibm.com>
> + *
> + * Copyright (c) Linux Test Project, 2009-2023
> + * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test checks base timer_getoverrun() functionality.
> + */
>   
> -#include <stdio.h>
> -#include <errno.h>
> -#include <time.h>
>   #include <signal.h>
> -#include <sys/syscall.h>
> -
> -#include "test.h"
> +#include "tst_test.h"
> +#include "tst_safe_clocks.h"
>   #include "lapi/syscalls.h"
>   
> -char *TCID = "timer_getoverrun01";
> -int TST_TOTAL = 1;
> -
> -static void cleanup(void)
> -{
> -
> -	tst_rmdir();
> -}
> -
> -static void setup(void)
> +static void run(void)
>   {
> -	TEST_PAUSE;
> -	tst_tmpdir();
> -}
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int timer;
> +	timer_t timer;
>   	struct sigevent ev;
>   
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
>   	ev.sigev_value = (union sigval) 0;
> -	ev.sigev_signo = SIGALRM;
>   	ev.sigev_notify = SIGEV_SIGNAL;
> -	TEST(tst_syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &timer));
> -
> -	if (TEST_RETURN != 0)
> -		tst_brkm(TBROK | TTERRNO, cleanup, "Failed to create timer");
> -
> -	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> -		tst_count = 0;
> -
> -		TEST(tst_syscall(__NR_timer_getoverrun, timer));
> -		if (TEST_RETURN == 0) {
> -			tst_resm(TPASS,
> -			         "timer_getoverrun(CLOCK_REALTIME) Passed");
> -		} else {
> -			tst_resm(TFAIL | TTERRNO,
> -			         "timer_getoverrun(CLOCK_REALTIME) Failed");
> -		}
> +	ev.sigev_signo = SIGALRM;
>   
> -		TEST(tst_syscall(__NR_timer_getoverrun, -1));
> -		if (TEST_RETURN == -1 && TEST_ERRNO == EINVAL) {
> -			tst_resm(TPASS,	"timer_gettime(-1) Failed: EINVAL");
> -		} else {
> -			tst_resm(TFAIL | TTERRNO,
> -			         "timer_gettime(-1) = %li", TEST_RETURN);
> -		}
> -	}
> +	TEST(tst_syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &timer));
> +	if (TST_RET)
> +		tst_brk(TBROK | TERRNO, "timer_create() error");
>   
> -	cleanup();
> -	tst_exit();
> +	TST_EXP_POSITIVE(tst_syscall(__NR_timer_getoverrun, timer));
> +	TST_EXP_FAIL(tst_syscall(__NR_timer_getoverrun, -1), EINVAL);
>   }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +};

Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
