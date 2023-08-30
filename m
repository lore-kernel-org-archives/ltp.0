Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773A2C6FA8F
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 11:42:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C5FF3CC020
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 13:42:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3696C3C6D29
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 13:41:51 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0023E6006D5
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 13:41:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsFDf5XENM4gWrJldJQiRiM77PLZL3YEsaEpifV1SC/RkTR5JKLWb9ARnpHbPOgwSmFoMJP/UJPYZK+nhHHq88DuXgaFSf+OcIYe3JofWFD9PNoK5HXmU6jQ1E3p/y/8YBx44UKcGgXfLwMjHI2COWP0I2YFe8GeNyquup5fWfI5izBkGX0AYe+bsX7zhq2gnayH5CuChp47ZLF1iChqlZG/j9tJ+1/4Dh/nVrTLUm5RAtW3Krqc7foUXQXuN3w3DcUirS7X+rOSXgJAJXZ9N6fb4cBpK030x145GQcrIp4XxXHaSLM6iKmZ5gx+WVzvfsPONOdYwHUVjEJdchM8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PmNCaDIMp6jF0GjMDIB+lW2txoToNLQDajkXhUVaJ0=;
 b=AL/vuoVYHzj7D0c2fOTidmduH6O/2WttBOxyfOacZowHXg20vXgoxQX/sdlX9Cv1mWPsmSQiqEOMdo8/hhy/9p5PZH2sxRHQb+8cDlAIHPCpdGGhrIUcg1dlokLf9LSIJvNcqUTAaL38eOTWCzeEb0LkAlGUDgPGDxFPqjhur0+LPSqo3bQEJqQbS9Z1u0LFNGpnd2KmBAyFKPdlDzGCxI+HNkaBFcb5B2zIAdGOs8lv7QJUlIVEqDAustPGkqeqylqVbTdBXXh556Ft/mB6TXZgAzgjp9W/MFilOtMXLI1mrKfII2JKty0G5BG6moG1lD8x+cdlphtwmHExBkVf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PmNCaDIMp6jF0GjMDIB+lW2txoToNLQDajkXhUVaJ0=;
 b=CMzlL7eqcyc8wzb5aAtgkIqu3YuDu9i1byrWYbkYQpxOWdnhuP7IV3aaXZ8pk2Ig2yM6DI7qWLMQ3xFv5aM3Eqz4OtuHyfEJTctUso9AUp28O5ejvONVF15Ge5WIuAmkVnmIKjaV8QGrkOxq+Jlmy0YZD2hPa0AjBEcNlxcVPWpSx2eguObb1in3qgrlq11BNNHORJrn0fvKFkqnpbuHz1qzxH0TZI98vocQUO0uCjqJq+98WJ9/U7QED1pDJy6WOwvcAlEsUZf7Ig24V8NJbnJyecWB6CSZ/n4L9s14IGeL+ek6unXfeHOvTNMUft2BHNIo4TEWffpHbX/W5NGs1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB7559.eurprd04.prod.outlook.com (2603:10a6:20b:295::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Wed, 30 Aug
 2023 11:41:48 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6678.031; Wed, 30 Aug 2023
 11:41:48 +0000
Message-ID: <69d95cfd-b3ba-4071-965b-1fc3ab2793be@suse.com>
Date: Wed, 30 Aug 2023 13:41:41 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20230829110049.20896-1-wegao@suse.com>
 <20230829111846.30961-1-wegao@suse.com>
In-Reply-To: <20230829111846.30961-1-wegao@suse.com>
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS8PR04MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 94996d5b-9b7d-4840-8a22-08dba94e183a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gz0J5tuT74ttPDqLDH4MbO6FnuM7aaXUMEI28W+iHeDvKBB/bApXBFfBpfIoyhnxYz8GxRJGsNq6Uld4dWiJDXX9NJvvp+QlOtTUJtrb8WualWalwvnb5N4KulPvGOqh3IHqkHAaVhuoGMvlfvLDp2Unk8uLdCm/suOYPQC0lEyB3HliH/z/H5aNRaG9nv6YE0VefTins1HREqCZMhkqUUXGOXxddSBTXJo4GRlnEQf1sf/JGVqC4Rm2OVoPgKywredCmUb8zxpkMcclfidWe6B+TONLRABkqrKv4nM/hSN9m+lFRHGdUaQgawWWPGf7LC1mIA/PptfQxGcDGHMNABN0OHuNlR21jlaJlzjLcjBsZN6zFtCdImFkIC/o6bTAx5cd9g2fg9qGPX86LFAw82uO3ku4bxpqaAcvEOJbU2fJrMGKwpp8NyHnyMFVhAGyjw+Vnd7SKZLhJ2WV7Ei9TT6H6jxgJ6JcrWLHGn1XM/gV+lqkqAUw4gaxMmduTEJiI50xrmHiUioaQbuxka1yGQ22Fs3S198puJ/yUOuB437p7FmyETC2rbpZyiNz1scCO1jsE6mLI3unJyBpENIq77MUsWyKX8MUu1gSwBIngBPu+bPDlOqbXasXrMwpf5bavzq5a322yspferc16DVUGRPoW/il9y/9a4n74q3JQ4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(53546011)(478600001)(31686004)(6506007)(66556008)(66946007)(66476007)(6486002)(6916009)(316002)(38100700002)(41300700001)(6512007)(8676002)(5660300002)(44832011)(36756003)(83380400001)(2906002)(31696002)(2616005)(86362001)(26005)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1J2V3h1Vms3a2g1VUVucGZBZUJqQXVlcFdxZVFxTTdsMzNTRUlhVWFVc0Nt?=
 =?utf-8?B?d2dLclRlSjlnMlpWTm0yemVyLzVUVkhWN01JeWRwSDdORTlDS241T2FXUnFJ?=
 =?utf-8?B?MWNKZWlkUlg1V1lLOEVQWDc1WVZqU1JLZHdjbVBoZDZHNFdMSzYwNkJUS2hS?=
 =?utf-8?B?dEpINmJiaGtrYTdGQ20xbFNGV0FWWFNRQzM5d1B1aGhnZFhHcmpHTzVMcTFj?=
 =?utf-8?B?eXVzQllMaHI2NmNuR3QwdVplcDRIU084bFBrdDVWRDJxRGxweVNFSnVlT0Nr?=
 =?utf-8?B?NVByQ2tYbUFxNGt5eXk1d1NQczBWaU9FTVUyRkUwQlJBd2gzdTlXcmpxQVpO?=
 =?utf-8?B?bnFYNlpKTVgzcHluZUhHSEpvYWEwOE55dWRWYVdHSi9WVndjbjVHVHVvTUlI?=
 =?utf-8?B?L21KM2pkZlFBSzVSRXZPUFVKdDFZa0JPSVhTQnpRd2c3TkU0L3VPNStqaXUw?=
 =?utf-8?B?QVY5c1FVRDFUdllldncxMHdyOHl2OFVpeEVjT1pGTnN5aHgxaHVrWG8xeWtn?=
 =?utf-8?B?L0tKQUtjSTBsdVRRN0RoZ0ZYWFB2TVdqQ2ZReUw4QWFoT2JPNHRiVG9NZFJy?=
 =?utf-8?B?RHZxazZSMCs5cUh2VGt3bDErSHh0b1Fud09PNjVXVldMNzRTdGdjMmx0YURq?=
 =?utf-8?B?SmFTcmVhWE1pYWhURDNSZmVxeWxMQ0F6N25lMkFvZ1FTcm1KdzBxSy9HUWZO?=
 =?utf-8?B?SkxJMmhoMXc4RUhpTmVVeVRLSkgwVHp4TUszNUhBY1J3UExhRFpZTStxeUxI?=
 =?utf-8?B?VDF3TWt2MnFNTHk1SnZjWWtRMnp2Z25TYUIvRmN6VVRUTGJvMm9LQjBnNlJS?=
 =?utf-8?B?bGVUMmlTdUN2bFZBWGUxQ1o5Zy9Bekp1ZE4vTWtmS3NxZjhMZFZkS0lwT3Jo?=
 =?utf-8?B?VXBuN2xzWndXSG5wbjNwOW53WjZuSnlsNHZydE1XazVnMmRvVG5oU0hjVU1l?=
 =?utf-8?B?OWpQRTFBVDBXSlFFL0FiZVNmdXpYMElnTG5BMzVvOFBrYkJMaUVic0JtTUU3?=
 =?utf-8?B?bDFWTDhER0Z3QXFySm9hemdxWVNITDM3YTdLMHYzRDBsSkdVRmNRNXRVYXo5?=
 =?utf-8?B?YTBQNGRNajRqV3ZCeEVIYk1lRDJDUnZWMGozT3dwdStuMmVGL29kSnMrSTk3?=
 =?utf-8?B?ZExIU3J6Z0xwWURiN0dsSXNDTzZuRDR0S2JxUkxYVzU4dWxnOWlnQVVwZ0JL?=
 =?utf-8?B?WVFJWUFyVkpkSU1UbURFK0tNVEp5aGlvcGtidzg0aXhKV1lXYS9MRUZtZEdK?=
 =?utf-8?B?L1lTRFk2alc2M1JzR1RLbCtla052WDFDeURGOXJiTk9QcSt4ZEw0emh3cUtE?=
 =?utf-8?B?T1Y2MXlNRDBBOFFlZGl3Ni9tUnlTTXBhNEpqbkdzcjYrZCt6Nng3bXNzUXMy?=
 =?utf-8?B?d0x5b1FZNFR4MlhBT1o2NzNoK3JYeEl3b3pvMDVEc3VNM2NmdGdHRFEzR09P?=
 =?utf-8?B?UFUrMXZWQ013UFN4Y08vQ1QrYUVHTWl1ajBFMXVJUkVEUUtLVDB6NUlSS0lz?=
 =?utf-8?B?WXltUXFXLzN1VThTRzBmTncrUks2UGtOQ1FwQVREVnJqZmJBblR6dFdWMlJi?=
 =?utf-8?B?RjVjSmcyMjUzczRHdnloeHg2NUlBM3g4MWZyZnlHRnkvTVFVQVQrc3V5T3VJ?=
 =?utf-8?B?L00zbjI4aGtxZDArbks5STRjNW5xQXY5ZFFMOFh6UEZ1bUk3cER4ZU5xUjlX?=
 =?utf-8?B?aGJVR0xMTkpSaU5USGN3YVRBSXV5MUcrSWZoNkNNamdiTEN2SDNnK21Kakdt?=
 =?utf-8?B?b2JucitObVcrM1RnRzBvTlZ2SXROOE0zdGtFWVozZGt6Vml3QTdtVWhvQyt1?=
 =?utf-8?B?SGdVRk5aL2MvaGQ3UmFZV21JMk1DdmlOMmFpa3MyOFNMYXZIL1R2aHo0SUxS?=
 =?utf-8?B?SXFYb2dPS1MwZHNobjRjaDVDUWVTNmM0T05HTUtyandSbjJVeDJsT0w2enlO?=
 =?utf-8?B?Mm5HRXVDSk5icEVLUTZuM0Q5em16V3RrbVpwdm1VaEVwRWcrQW43NTZxSkdD?=
 =?utf-8?B?MEhSTmpKR2hEQnREOHZvVm5veUIvdXpoVFpwNm1zY3FtVnVmRDN6SHRTek1Z?=
 =?utf-8?B?UjRzNUp3TnBxb0wrL08xSzNMQVVZMTduV0RlREZxV01OM0xMdFVUZHdHSFBs?=
 =?utf-8?B?UElqQmk4ZU5Sd1I4Y3NJdFNqRlo1ZHpFM1JKREFNZy91aXhYRWMvT012Z1Fo?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94996d5b-9b7d-4840-8a22-08dba94e183a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 11:41:48.3790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8zdN688/p1bPEq9Z4M/4ZECiQP5leu99fFO6tkE/ghbiIXRseATVZH2dPlZws5egLVsi0KacaZ75HQyZvDzAdzR+xCEjNl1kEQdDw60Lvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7559
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [v7,2/2] semop04: Refactor with new API
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

Hi!

On 8/29/23 13:18, Wei Gao via ltp wrote:
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   testcases/kernel/syscalls/ipc/semop/semop04.c | 158 +++++-------------
>   1 file changed, 42 insertions(+), 116 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop04.c b/testcases/kernel/syscalls/ipc/semop/semop04.c
> index 582624d60..96f4b8fb8 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop04.c
> +++ b/testcases/kernel/syscalls/ipc/semop/semop04.c
> @@ -1,164 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *
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
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (C) 2003-2023 Linux Test Project, Inc.
> + * Author: 2001 Paul Larson <plars@us.ibm.com>
> + * Modified: 2001 Manoj Iyer <manjo@ausin.ibm.com>
>    */
>   
> -/*
> - *  FILE        : sem01.c
> - *  DESCRIPTION : Creates a semaphore and two processes.  The processes
> - *                each go through a loop where they semdown, delay for a
> - *                random amount of time, and semup, so they will almost
> - *                always be fighting for control of the semaphore.
> - *  HISTORY:
> - *    01/15/2001 Paul Larson (plars@us.ibm.com)
> - *      -written
> - *    11/09/2001 Manoj Iyer (manjo@ausin.ibm.com)
> - *    Modified.
> - *    - Removed compiler warnings.
> - *      added exit to the end of function main()
> +/*\
> + * [Description]
>    *
> + * Creates a semaphore and two processes.  The processes
> + * each go through a loop where they semdown, delay for a
> + * random amount of time, and semup, so they will almost
> + * always be fighting for control of the semaphore.
>    */
>   
>   #include <unistd.h>
>   #include <stdlib.h>
>   #include <stdio.h>
> -#include <errno.h>
>   #include <sys/types.h>
> -#include <sys/wait.h>
>   #include <sys/ipc.h>
>   #include "lapi/sem.h"
> +#include "tst_test.h"
> +#include "tst_safe_sysv_ipc.h"
>   
> -int verbose = 0;
> -int loops = 100;
> -int errors = 0;
> +#define LOOPS 1000
>   
> -int semup(int semid)
> +static void semup(int semid)
>   {
>   	struct sembuf semops;
> +
>   	semops.sem_num = 0;
>   	semops.sem_op = 1;
>   	semops.sem_flg = SEM_UNDO;
> -	if (semop(semid, &semops, 1) == -1) {
> -		perror("semup");
> -		errors++;
> -		return 1;
> -	}
> -	return 0;
> +
> +	SAFE_SEMOP(semid, &semops, 1);
>   }
>   
> -int semdown(int semid)
> +static void semdown(int semid)
>   {
>   	struct sembuf semops;
> +
>   	semops.sem_num = 0;
>   	semops.sem_op = -1;
>   	semops.sem_flg = SEM_UNDO;
> -	if (semop(semid, &semops, 1) == -1) {
> -		perror("semdown");
> -		errors++;
> -		return 1;
> -	}
> -	return 0;
> -}
>   
> -void delayloop()
> -{
> -	int delay;
> -	delay = 1 + ((100.0 * rand()) / RAND_MAX);
> -	if (verbose)
> -		printf("in delay function for %d microseconds\n", delay);
> -	usleep(delay);
> +	SAFE_SEMOP(semid, &semops, 1);
>   }
>   
> -void mainloop(int semid)
> +static void mainloop(int semid)
>   {
>   	int i;
> -	for (i = 0; i < loops; i++) {
> -		if (semdown(semid)) {
> -			printf("semdown failed\n");
> -		}
> -		if (verbose)
> -			printf("sem is down\n");
> -		delayloop();
> -		if (semup(semid)) {
> -			printf("semup failed\n");
> -		}
> -		if (verbose)
> -			printf("sem is up\n");
> +
> +	for (i = 0; i < LOOPS; i++) {
> +		semdown(semid);
> +		usleep(1 + ((100.0 * rand()) / RAND_MAX));
> +		semup(semid);
>   	}
>   }
>   
> -int main(int argc, char *argv[])
> +static void run(void)
>   {
> -	int semid, opt;
> +	int semid;
>   	union semun semunion;
> -	extern char *optarg;
>   	pid_t pid;
> -	int chstat;
> -
> -	while ((opt = getopt(argc, argv, "l:vh")) != EOF) {
> -		switch ((char)opt) {
> -		case 'l':
> -			loops = atoi(optarg);
> -			break;
> -		case 'v':
> -			verbose = 1;
> -			break;
> -		case 'h':
> -		default:
> -			printf("Usage: -l loops [-v]\n");
> -			exit(1);
> -		}
> -	}
>   
>   	/* set up the semaphore */
> -	if ((semid = semget((key_t) 9142, 1, 0666 | IPC_CREAT)) < 0) {
> -		printf("error in semget()\n");
> -		exit(-1);
> -	}
> +	semid = SAFE_SEMGET((key_t) 9142, 1, 0666 | IPC_CREAT);
> +
>   	semunion.val = 1;
> -	if (semctl(semid, 0, SETVAL, semunion) == -1) {
> -		printf("error in semctl\n");
> -	}
>   
> -	if ((pid = fork()) < 0) {
> -		printf("fork error\n");
> -		exit(-1);
> -	}
> +	SAFE_SEMCTL(semid, 0, SETVAL, semunion);
> +
> +	pid = SAFE_FORK();
> +
>   	if (pid) {
> -		/* parent */
>   		srand(pid);
I'm wondering if this is an error from the previous test as well. We are 
using mainloop() function that is using rand() inside both child and 
parent. So srand() should be called before parent and child, in order to 
have random seed initialized for both of them. I would also use 
srand(time(0)).
>   		mainloop(semid);
> -		waitpid(pid, &chstat, 0);
> -		if (!WIFEXITED(chstat)) {
> -			printf("child exited with status\n");
> -			exit(-1);
> -		}
> -		if (semctl(semid, 0, IPC_RMID, semunion) == -1) {
> -			printf("error in semctl\n");
> -		}
> -		if (errors) {
> -			printf("FAIL: there were %d errors\n", errors);
> -		} else {
> -			printf("PASS: error count is 0\n");
> -		}
> -		exit(errors);
> +		tst_reap_children();
> +		TST_EXP_POSITIVE(semctl(semid, 0, IPC_RMID, semunion));
>   	} else {
> -		/* child */
>   		mainloop(semid);
>   	}
> -	exit(0);
>   }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
> +};

Thank you,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
