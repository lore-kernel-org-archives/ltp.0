Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ECBEDEC42
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 11:19:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 284613CB2A5
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 13:19:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEE633CB2A5
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 13:18:50 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 17A0F600635
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 13:18:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYfQh+hN9sk3GWV0gpMxA+0RvqNq9DuT30yg4ErjvV3YH2TS+rboXuH0UlclMjyJWf41M1KR9xgFWag47A5/4EIFEm6Zo9DvJLX5SyE6FviYcXFXh1yEC5q3RA5bRRHE9c1tFYJay+hoP2COBfO5qsQw4FxLqW2ghyQDLNOHfOe9eTWOToZOY/6Oo7KlwfUQOGbRhUKlBlPvjC1mYFz0kRqRyolX2PjGxXj3ztnaGGpoUcakXUMmtt/V1pNk3+SHgOxUTRjlQ2PXBvfTZMIJRt5Jv9blkQO2CtRZgifqJHO5HBgq/B4ZhoIRJoS4imxowLEIjri+LevHBMnWsztaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21dQsaoDSWU9V7637c5JJg57JpZTEJ2hRdxbPPGniPM=;
 b=G/CNXLBLilxVuEUTCtgDjXU8GtVTkFqRr2Rqq9omfRxS0Ni+abfizADxLkUMBg5OkMzG3NvM8rtsAfLqGHE+BPiXmzVtbINeCyJqcPRIqwtb7e/HxTShmENFCvffXHlBq7s+lz8ZIdp7Fu/ToMP+J5ii9SKGJ41EabV5d4Q5ZAsBRsMixXljTAhhMJE7pWtHJf/ovGqsr4u4W2T+06CvFI9wWDkxlTDnXJAiZsO9tPaeyUuWLLMFLH8A9ta5LkBSmUSH0yfQ3xzBNLxY/PeRx2OK9q2hivAs+1T9yNSkcAR5nV7Ljxtm0CpO/sqa2Z+dONK8FkA4I/pgHcSCmLKc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21dQsaoDSWU9V7637c5JJg57JpZTEJ2hRdxbPPGniPM=;
 b=U/kV+dKo+q+TNj2TaPlnPmuLu5SK1/T9+yK8Ttv+wcn5Rh4FA5tZGY+BD2YE4TCQGufb7hHiELi7WgGKmStbZslPBouUpiRte2gt6OF427EmOwVBw3dNvPcvDOCROKTD4PcOo1lHyoTdgTmuUuHxNpo58eqwFDoX7ptQn82Gc7e9bn6hlr3/Y4mqOus6O9qX/fTJEXtnCQdHMkKFmqLUtC2mG+yfttqRKgyXILVIurNBrkWz65KPYVG9jW8kExXlDS93ynIKhPn9To0lT3tEdKaUIMUhahgwapvwsXkJDBgAvrgmigl8RW+GagufORXXsZPbfZtU+5cg2RqkBYPz5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB8024.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 11:18:47 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 11:18:47 +0000
Message-ID: <e73de656-9075-42d5-8d0a-b6951c28d603@suse.com>
Date: Wed, 13 Sep 2023 13:18:45 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Avinesh Kumar <akumar@suse.de>, ltp@lists.linux.it
References: <20230913100803.13756-1-akumar@suse.de>
 <20230913100803.13756-2-akumar@suse.de>
In-Reply-To: <20230913100803.13756-2-akumar@suse.de>
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS8PR04MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 88479301-5f69-4577-e020-08dbb44b328d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sA/jxhPlSgJtyDRJS9Qa6Bo5HGBtZcZu3pOC9umNdqUQafkQy9fVI0XnvwY/b6rDcDYOkP/CtT5a1I1osuXUeeUgfmJpN4Q89CUQHuFRmXzgAlR4f8BpnAGD6sC0P+NRhlwoo3hur9mYKIW8+2FxKZnWwe40A6T6oZQ/qJqQ/8/57aUtrh0xSvoM9wjMm3ibG8rtbmwXndYnxqwuR+5lbqStn3N4v1btvaBszkfiqwjsgxnxjn24vMLOWFheU83hFYRxX3/PNrHBplZKia9OLUri9zu7wZupRjlCExPC1lDR9dU6gP0epq0XgM2zj3mloWJbNupkkpsDEaZciBb96DjTVWK8sRSnrlFGKbe7l7TOawzaRARAnOtjZlWFJO/28AfyZlz3EcSKqjLKDWVuqPUjOxMAgrTSbcu5MnwTQqpc9GAU2ai9ckv5KiATIeS2bL5KnRDOQkhuNeRf6YdfrRqRXQUqj4ykl5mGT9PFTOMkroDe1ArcQHaHM506g6+YXPzi5t40YIhV+GRxmdRJ2wKVFk6vY2g35tlAa8WKHGCGvizUVhn2EIhUeZoe+s2hfnlSFYZd/lRYOZqojUwnPYZjeBG1XNIbXHCkzWHeua0cyQ/4qglrsBZjMfr5VHfvxUW2ZB4I8nyU4L5rWpLhmMtXU9jykoUd58ztG7KxlHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(1800799009)(451199024)(186009)(38100700002)(6512007)(6486002)(6506007)(53546011)(2616005)(66946007)(86362001)(478600001)(31696002)(83380400001)(26005)(316002)(66556008)(2906002)(44832011)(5660300002)(41300700001)(8676002)(8936002)(36756003)(66476007)(30864003)(31686004)(2004002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE5YbnZUNkQwOHhRK2E0T0plNTAzdDZQZS9IQkw4QlVZcW9qVmxHemQzUHVD?=
 =?utf-8?B?SklnckVBN0I1ZHFoLzBpNFo4TDZRdnhaaEFzZ2VONEdBUDg0aXR1SlQxTHdT?=
 =?utf-8?B?R0NremFEUkVrUTNDejRyby9oL1lxOUhwa0Z5Si9RMDc2KzMxNGhEZEdwcEFK?=
 =?utf-8?B?VlJLNVhrcEpMRDF1NXVTU1JjMFdSNCtQenJRTzc0VlBtYUxGZmF6OS9xS0FM?=
 =?utf-8?B?SDVHSFBGTlRPR2pUYzBHZkc4TWZDbFBJWjhselc4UktNcUhvK3JSWm1idXJr?=
 =?utf-8?B?QnFNQTk0UkVVVXE1UkJCOWRwTUt4UnRTUGhDMTRDcWZkRjVwQmdjemVnSnhL?=
 =?utf-8?B?dFJHRzBDa1RGOW9XQkY0QVVSQWxpVzBvdFE4Ui8vOGQxbEJUTVBuY0FiOFcz?=
 =?utf-8?B?bkFaQkk2V2c0WHdRVTF1bVBXcWthemRmVVRWVFJaT2UzSThiZXM2Vzd2Nzhm?=
 =?utf-8?B?N0R4MGZSTXpZT2R5eExBZjA5QlpmWi9hb2p3aldLMUtydVJOd2h1bm9pNW1N?=
 =?utf-8?B?enI5bitQWWoyOW9wZUMyTkI4UU5sV1g1Nm55QWRyaldlS2lqYkpQckRhZzh3?=
 =?utf-8?B?M3pTeHNKTmFuazJNVHFFdkZJbWRPdDZRbFQyU2JETUNwcW82Z1FLb3p5bDlD?=
 =?utf-8?B?d3l4Qk50WXJ3VXQyeXZuSU9SMk50eDlaQlBQYUx0bTVIUGRnTmhDcVBxcmNB?=
 =?utf-8?B?UDlGbURkcDVab0ZPdlM5M2lOaVY1T1V0WFYrZEFqUjRjc1lic0EzWDF1K2Ix?=
 =?utf-8?B?aEZreEpsTWd6MDk5NmZJV05xQTF5M0tEYW9wazFqNVFoQ2dkbk95SnQ1dW1G?=
 =?utf-8?B?ampZZFZxOE85MmhFTmZiVXVkL1grWGIzeGM2YU5najFrUDdXR0FSd0dUYmdC?=
 =?utf-8?B?ME5yajRha1BGUVA3d2JkSEYxNHFWaUl2NmF5MGFOano0OGVFZGIzNWZONmZa?=
 =?utf-8?B?ejFsWXlZWjVuV3RFZTk3Mzd6N3pUTjRQKzJzb2pUbjBPWWRUWThzTmkwU2dR?=
 =?utf-8?B?bGg1N2cvQXZhYkxoNVI1VVpqRjh5d0RhNWNQTTJWcGZTejhta3ZOSllvQTdr?=
 =?utf-8?B?UzJYTFdhcWFZeHNpMmtJZXBuRzRjWnUvMklOVmtLUkd3M1FLVmRubjFZM241?=
 =?utf-8?B?UnI0dmcyTkp0UjVyNmdzOXZsTm1RUlZqSjRyQmVXekFTNXZGSStFZUJpQWdT?=
 =?utf-8?B?V01CNzlHQklpN3hmRGdiY3lOTXc1ODZrUUNicFowc1ErTjMzb3gzS0J4Nm9X?=
 =?utf-8?B?QU9hZlJMQm5vRUFBUGtHbjIvSlFrR2RnNk5mUk5DZ1ZFbWFFaDg3d0NaUDYv?=
 =?utf-8?B?UnBBWW5QTXlIMjFwRFBkU0pNSW04TDEzbmN2bEpqL1dkRVdhWFZ4TC9nU0t5?=
 =?utf-8?B?VlVtaW84U2w0My90US9BWUtHUlpjZlQ2QWdJaExRM1dyM00vMnNIUkowWHhz?=
 =?utf-8?B?OFhicHdjWGNZaWpTOFVadWZBZ3Y4ZTgxVFpWekZRR3djT3gxRGNTMmxIMTRG?=
 =?utf-8?B?d3o2S05Wb3c5TFNuN24vOGl0U0tjQTBmMG1CQWtLNGl4cnBnc3o5bjlNalFa?=
 =?utf-8?B?ak95cmxYWGJNL293NjRBOTNCWUErZmI1K0pyM3ZkVVVFczNhQTFNWjdwaW5o?=
 =?utf-8?B?VDJuYkZ3QktBa0ZiMThoV3ZQM1laZXBrcDR6K3NqU0QyUVNsOERsY0d4VnZ2?=
 =?utf-8?B?akZiekQzSUFCQ3d0a2loTGF4elVPQXk1YnFBL2tDeklSc1I1MHdSL3Zza1lx?=
 =?utf-8?B?TVNkcklNUDFtVE9abGM2Szh6RjBmaHY1UVJmL3ZCVFZ6ZytzRFhIMVUvdTI4?=
 =?utf-8?B?UmYrakc4WWZPZ1k4ZUNhM015ZXQweU55aU04b1pzQjVxSG1YcFVvbjFOL3Rp?=
 =?utf-8?B?NE81YjZOS1NjNUNXK0dlenNnejcvaXRNZEkyWDllT216WjhrMUVVbnJmSTFL?=
 =?utf-8?B?RjdFS1Zwcm1MNk11MDZraEF6WWdCZ3E2UHZ0VEpSMjlBdG1VQXJQS21ScTVS?=
 =?utf-8?B?THZHT1p4dWI2TWJMTTBhK0tpcUY0NGxYaFVJaUgxS3ArT0M3SUpFNHBQUi9C?=
 =?utf-8?B?MlJSMXpoaWt2SnNvT0R0anNVMEg3VXpjQzI3QWFjdVVlM1o0RVBQWk1Ba25r?=
 =?utf-8?B?Y09BbEVNSFJGd0dMaUVqNktuVTRmbUdsVXpGT1JzYndBbEtHSDJYQXdUeTdH?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88479301-5f69-4577-e020-08dbb44b328d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 11:18:46.9433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGVTncEdVOm+qfE0kNe4dvsi36f/KbE1Pg9sL8sdsiR7uyPh3DcCQqwBf1zkhNM9vb4ReFCbkyQ4sZKu4dQqowVjeJ+c71zCjdj06fOYqpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8024
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/munmap02: Refactor the test using
 new LTP API
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

munmap01 and munmap02 looks quite similar. The refactoring is good to 
me, but maybe we can merge them into a single test using 2 different 
test cases, where the first is mapping a certain portion of the file and 
the second an another.

Regards,
Andrea

On 9/13/23 12:08, Avinesh Kumar wrote:
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>   testcases/kernel/syscalls/munmap/munmap02.c | 297 ++++----------------
>   1 file changed, 55 insertions(+), 242 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/munmap/munmap02.c b/testcases/kernel/syscalls/munmap/munmap02.c
> index b43250512..7c7fb5b2c 100644
> --- a/testcases/kernel/syscalls/munmap/munmap02.c
> +++ b/testcases/kernel/syscalls/munmap/munmap02.c
> @@ -1,270 +1,83 @@
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
> + *  07/2001 Ported by Wayne Boyer
> + * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>    */
>   
> -/*
> - * Test Name: munmap02
> - *
> - * Test Description:
> - *  Verify that, munmap call will succeed to unmap a mapped file or
> - *  anonymous shared memory region from the calling process's address space
> - *  if the region specified by the address and the length is part or all of
> - *  the mapped region.
> - *
> - * Expected Result:
> - *  munmap call should succeed to unmap a part or all of mapped region of a
> - *  file or anonymous shared memory from the process's address space and it
> - *  returns with a value 0,
> - *  further reference to the unmapped region should result in a segmentation
> - *  fault (SIGSEGV).
> +/*\
> + * [Description]
>    *
> - * Algorithm:
> - *  Setup:
> - *   Setup signal handling.
> - *   Create temporary directory.
> - *   Pause for SIGUSR1 if option specified.
> - *
> - *  Test:
> - *   Loop if the proper options are given.
> - *   Execute system call
> - *   Check return code, if system call failed (return=-1)
> - *   	Log the errno and Issue a FAIL message.
> - *   Otherwise,
> - *   	Verify the Functionality of system call
> - *      if successful,
> - *      	Issue Functionality-Pass message.
> - *      Otherwise,
> - *		Issue Functionality-Fail message.
> - *  Cleanup:
> - *   Print errno log and/or timing stats if options given
> - *   Delete the temporary directory created.
> - *
> - * Usage:  <for command-line>
> - *  munmap01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -f   : Turn off functionality Testing.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -P x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS:
> - *  None.
> + * Verify that, munmap() call succeeds to unmap a mapped file region from
> + * the calling process's address space when the region being unmapped is
> + * only part of the total mapped region, and any attempt to access the
> + * unmapped memory region generates SIGSEGV signal.
>    */
> -#include <errno.h>
> -#include <unistd.h>
> -#include <fcntl.h>
> -#include <sys/stat.h>
> -#include <sys/mman.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -#define TEMPFILE	"mmapfile"
>   
> -char *TCID = "munmap02";
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
> +#include <setjmp.h>
>   
> +#define TEMPFILE "mmapfile"
> +static char *addr1, *addr2;
> +static int fd;
> +static volatile int sig_flag;
> +static sigjmp_buf env;
>   static size_t page_sz;
> -char *addr;			/* addr of memory mapped region */
> -int fildes;			/* file descriptor for tempfile */
> -unsigned int map_len;		/* length of the region to be mapped */
> +static unsigned int map_len;
>   
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> -void sig_handler();		/* signal catching function */
> -
> -#ifndef UCLINUX
> -
> -int main(int ac, char **av)
> +static void sig_handler(int sig)
>   {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		setup();
> -
> -		/*
> -		 * Call munmap to unmap the part of the mapped region of the
> -		 * temporary file from the address and length that is part of
> -		 * the mapped region.
> -		 */
> -		TEST(munmap(addr, map_len));
> -
> -		/* Check for the return value of munmap() */
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL, "munmap() fails, errno=%d : %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -			continue;
> -		}
> -		/*
> -		 * Check whether further reference is possible
> -		 * to the unmapped memory region by writing
> -		 * to the first byte of region with
> -		 * some arbitrary number.
> -		 */
> -		*addr = 50;
> -
> -		/* This message is printed if no SIGSEGV */
> -		tst_resm(TFAIL, "process succeeds to refer unmapped "
> -			 "memory region");
> -		cleanup();
> -
> +	if (sig == SIGSEGV) {
> +		sig_flag = 1;
> +		siglongjmp(env, 1);
>   	}
> -	tst_exit();
> -}
> -
> -#else
> -
> -int main(void)
> -{
> -	tst_resm(TINFO, "munmap02 test is not available on uClinux");
> -	tst_exit();
>   }
>   
> -#endif /* ifndef UCLINUX */
> -
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - * Setup signal handler to catch SIGSEGV.
> - * Get system page size, create a temporary file for reading/writing,
> - * write one byte data into it, map the open file for the specified
> - * map length.
> - */
> -void setup(void)
> +static void setup(void)
>   {
> +	SAFE_SIGNAL(SIGSEGV, sig_handler);
>   
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	/* call signal function to trap the signal generated */
> -	if (signal(SIGSEGV, sig_handler) == SIG_ERR) {
> -		tst_brkm(TBROK, cleanup, "signal fails to catch signal");
> -	}
> -
> -	TEST_PAUSE;
> -
> -	/* Get the system page size */
>   	page_sz = getpagesize();
> +	map_len = page_sz * 3;
>   
> -	/*
> -	 * Get the length of the open file to be mapped into process
> -	 * address space.
> -	 */
> -	map_len = 3 * page_sz;
> -
> -	tst_tmpdir();
> +	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
> +	SAFE_LSEEK(fd, map_len, SEEK_SET);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, "a", 1);
> +}
>   
> -	/* Creat a temporary file used for mapping */
> -	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
> -		tst_brkm(TBROK, cleanup, "open() on %s Failed, errno=%d : %s",
> -			 TEMPFILE, errno, strerror(errno));
> -	}
> +static void run(void)
> +{
> +	addr1 = SAFE_MMAP(NULL, map_len, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
>   
> -	/*
> -	 * move the file pointer to maplength position from the beginning
> -	 * of the file.
> -	 */
> -	SAFE_LSEEK(cleanup, fildes, map_len, SEEK_SET);
> +	addr2 = (char *)((long)addr1 + page_sz);
> +	map_len = page_sz * 2;
>   
> -	/* Write one byte into temporary file */
> -	if (write(fildes, "a", 1) != 1) {
> -		tst_brkm(TBROK, cleanup, "write() on %s Failed, errno=%d : %s",
> -			 TEMPFILE, errno, strerror(errno));
> -	}
> +	TST_EXP_PASS(munmap(addr2, map_len));
> +	if (TST_RET == -1)
> +		return;
>   
> -	/*
> -	 * map the open file 'TEMPFILE' from its beginning up to the maplength
> -	 * into the calling process's address space at the system choosen
> -	 * with read/write permissions to the the mapped region.
> -	 */
> -#ifdef UCLINUX
> -	/* mmap() doesn't support MAP_SHARED on uClinux */
> -	addr = mmap(0, map_len, PROT_READ | PROT_WRITE,
> -		    MAP_FILE | MAP_PRIVATE, fildes, 0);
> -#else
> -	addr = mmap(0, map_len, PROT_READ | PROT_WRITE,
> -		    MAP_FILE | MAP_SHARED, fildes, 0);
> -#endif
> +	if (sigsetjmp(env, 1) == 0)
> +		*addr2 = 50;
>   
> -	/* check for the return value of mmap system call */
> -	if (addr == (char *)MAP_FAILED) {
> -		tst_brkm(TBROK, cleanup, "mmap() Failed on %s, errno=%d : %s",
> -			 TEMPFILE, errno, strerror(errno));
> -	}
> +	if (sig_flag == 1)
> +		tst_res(TPASS, "Received SIGSEGV signal");
> +	else
> +		tst_res(TFAIL, "SIGSEGV signal not received");
>   
> -	/*
> -	 * increment the start address of the region at which the file is
> -	 * mapped to a maplength of 3 times the system page size by the value
> -	 * of system  page size and decrement the maplength value by the value
> -	 * of system page size.
> -	 */
> -	addr = (char *)((long)addr + page_sz);
> -	map_len = map_len - page_sz;
> +	SAFE_MUNMAP(addr1, page_sz);
> +	map_len = page_sz * 3;
> +	sig_flag = 0;
>   }
>   
> -/*
> - * void
> - * sig_handler() - signal catching function.
> - *   This function is used to trap the signal generated when tried to read or
> - *   write to the memory mapped region which is already detached from the
> - *   calling process address space.
> - *   this function is invoked when SIGSEGV generated and it calls test
> - *   cleanup function and exit the program.
> - */
> -void sig_handler(void)
> +static void cleanup(void)
>   {
> -	tst_resm(TPASS, "Functionality of munmap() successful");
> -
> -	/* Invoke test cleanup function and exit */
> -	cleanup();
> -
> -	tst_exit();
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
>   }
>   
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - *  Unmap the portion of the region of the file left unmapped.
> - *  Close the temporary file.
> - *  Remove the temporary directory.
> - */
> -void cleanup(void)
> -{
> -
> -	/*
> -	 * get the start address and length of the portion of
> -	 * the mapped region of the file.
> -	 */
> -	addr = (char *)((long)addr - page_sz);
> -	map_len = map_len - page_sz;
> -
> -	/* unmap the portion of the region of the file left unmapped */
> -	SAFE_MUNMAP(NULL, addr, map_len);
> -
> -	/* Close the temporary file */
> -	SAFE_CLOSE(NULL, fildes);
> -
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.needs_tmpdir = 1
> +};



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
