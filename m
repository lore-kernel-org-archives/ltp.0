Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB5AC43334
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 11:16:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A1463CA00A
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 13:16:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0454C3C04EF
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 13:16:30 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 38C56200332
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 13:16:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTvA9p5uunV2LoQMbre5m4G7Ng8mRfDFJtvScXcDgxEUbQOIGp6/pd3I7jcz0GrMiKFm2YeWCh0qIgQUvHbqJLr6hQsUZtKXeVMfD5T3DOHdHzXRY0/drCOyLEjQnY6/4xNgOL0J6FRA7KGaWkM6eeDXA3iON59eO2SPu88Cc3w5DsYxiPsoe5cvDYi2OF/qGeZzp8KEeQxh7RElV4hQIhqtcVPc1zyfFG9kRFRT2b2U7z2iAsfeK98BOZOG/mwfsSo8+orvGZ9/pr51+mVVY/ubjPScSdc7Io7p4D9A6a8CJlwkuQv2G2Fat1xIhFvCBM6i6zvXJMU24UHv9Sh9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0KXQjQ84+F4gEKpl9rzzJ6xaApCkRLffyduaSqgEsU=;
 b=AzqqC1C0VETfAKsueUwjnAEzVJA/Jkc6s+RJH3oCzSKFkKD6WD1L2Hh73aFhCc2+DWIQtMlp90C7F1WEfh1ocHtzpepp0JjvGMiBDzHynYGdV5tAT4sYdffEQZBba64pOofiC85skoBBMfVH64mAx1fE3xyGRdD/Mgp2esCTXB9IwRL/uMUkDBedXQplPJ0nubxgJ9XQR/lBs79ThzidvVQaLWo8I0AMthyrPEyLvcH+WGemfhjxTduVnXYj+HdQ0ZJnN6wO17QYkNfDOwkZe+QT5OMxLgqq6YEFoRJ6ZW7nXcrlYqnfDLBWeFCOpeeW/tEvMzYgQJUWZiN3fCovVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0KXQjQ84+F4gEKpl9rzzJ6xaApCkRLffyduaSqgEsU=;
 b=EEVuRhaEm/XSy0vEQkZnkbLEmY3XEgkcEr7DFw0nmdJ2HeZmCKGODTdu9X2npgfe//vZ57qqNaREnYDCj1M77jOBaVX5Y4wu6GKrK2LnEZ0z7WgkA9GP4UdwkU34OvdSEz94Kyd0V+5qcBPPOCVHMFlquQFiUkQRznouRFtv2mHmZN4dj33SoyItrzeVVpqmXFlJ/xusLBuIABaFsIKmp2oCH48F/yfvP2oDUQiywRqDkORmqD7ncOJX25VKxDz22Q/m8LLh0O4Zt9hNlPxhlGkiD9rLmHru+LBuLRVb5jSJyQC8PDcur9F6k4FkKE/4u5RC1OJt1FYHQGr5zxyySQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM0PR04MB5457.eurprd04.prod.outlook.com (2603:10a6:208:115::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Tue, 26 Jul
 2022 11:16:26 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b%5]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 11:16:26 +0000
Message-ID: <fb6c9172-e6f7-ba33-22fb-b4afae66478a@suse.com>
Date: Tue, 26 Jul 2022 13:15:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220616144207.30530-1-andrea.cervesato@suse.com>
 <YrMmFt9nD2WVrki/@yuki>
In-Reply-To: <YrMmFt9nD2WVrki/@yuki>
X-ClientProxiedBy: AS9PR06CA0523.eurprd06.prod.outlook.com
 (2603:10a6:20b:49d::24) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7325b53-3ca4-4fcc-bcdc-08da6ef847d1
X-MS-TrafficTypeDiagnostic: AM0PR04MB5457:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AG24ZhFtyk4UZFOz/+/PDgq3XoVp05nYZzCgr7Y7sW9gFJqRtxRdNApXhZ2lgGFR12gaOV31GR4OVqt+pg2bIHEYsX4EEBe1moqCXQBe5QXGypmFVyw2+Pk+NGvKXnnLi5GRK0+IAvUhA1fZzFaquDROSI/J1Iq3E40QVpa1rAPTz9y9TDTUBGTR36LIPmXgOpQ7f6jyUm5pzLiC+kKvLy0mSxAd0wEeo3G68U2w4xVTjy6MxxDgpgKnBAzkNpEzX3RbxmxMnzLbDuCRBYTpOEv5U8mki5rktgGsm4IDkVhx1YmVUQZInOxxyUlrsbmOq+9I0z0pY20SDcBM6U83JwSdtNSHS5QrVMtJnBBgaMsjzyutaLfA4tKVB6nrRB8+WaPQ6f/pVS92P745z93dHqz5GN8LSXyxNOH5/hSi4HzkH2qQLpBS4nt/FH5k8E1boRheGW5Knf8IUawaZ03aPiC33ebc2D+dpB99bQKe1T8ubnvHT4VT8urkU0g/s7eQMDaAErviaT2/t/oVqalhcjV2UF9pPVyjrEWMoMPtXYttHz3gDDYXLnLCucoPUW/T9ZaIPPmCvpnHJqkUwHXagstt7GVbccBnoCtcIX1m7wi8AvyhodA3o/fZLdEtHUzQmLN1Nab2UlQfTLX4uv7rxK8HgA2Xqoq7380/5yYWmPdNPKx2sznkDIv/sfrR8q+84TATgZHuDttoN9ohARP5jxeN75w8fq3NbYx69I1I+pwRF7MjPxjMRfgN/gkBJU2/JIXiI8y3Xmqu6qWylyMmo6y01mzjpgtfkMcWEdo2D0QaDZ7ImqCKAg0eJr8phFwHYD1kkQygOZQr4gH+buokw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(346002)(366004)(39860400002)(396003)(376002)(136003)(186003)(38100700002)(4326008)(66556008)(8676002)(66946007)(66476007)(31686004)(316002)(6916009)(36756003)(6506007)(6512007)(6486002)(478600001)(31696002)(86362001)(41300700001)(6666004)(26005)(53546011)(2906002)(83380400001)(2616005)(5660300002)(30864003)(8936002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnRMZkgxRmJRTHFLNkRNRFpTek5lampWNjhLUy9oSzVYSVZFVTBweTZYczFv?=
 =?utf-8?B?SGlQZ05ITGZmc05Rcm80TG1wTnJEVkwrcUxGWjRiQ3ZHMlFFdGoxQzVTWjhy?=
 =?utf-8?B?dnNPWEJYS2o0ZFExYmNTczgrZkJFbE50SHEvd2VrM211TWhrVXhsVTNBRU1y?=
 =?utf-8?B?VDZCOFRKYUFwY1RIcyszb1hTNkJza05POTdZSVVtRENkRWJrbHlaRFAvQUp0?=
 =?utf-8?B?Tmo4NmdjdDN1REVzdmhqY1lQdHFzbFFFS0JEb1pscFduOHRTdTQ5WmRna3RQ?=
 =?utf-8?B?Z2dKWHNqM1lmSmJHMzFHOXRGZTdzSVFUZWNTVU4yZXRzelgvOHZONGF2ams0?=
 =?utf-8?B?ZFV0S1Rtc29Tc3dRMm9aUXNvempFVTRDaFpuUUZGU0hxTUlDVDMxSjRRSEUy?=
 =?utf-8?B?U2loUHNBSmtldTJPcm4rMzhQVmp5M0FBM1ZoK2lxc0Q5RTFuU0ZOcFlmSy94?=
 =?utf-8?B?dkUvaGZSaitwNjlzRzhpS1B0T1FZVi9PMjdKQy9RVHkwaDZVN0JYNk5ndTVG?=
 =?utf-8?B?RHFRZm1IOCtzV3huUTZRVUw2OWZJMWd0ems4cjZadHFXam1rQUFZaklHZVY2?=
 =?utf-8?B?bnQxc2JGQnpyTFFEYlJWYTNnZER5VzlaaUMxemhwWGpHS0JoQzR4aEl0MUVl?=
 =?utf-8?B?R3hnWXBKVXErczFBNmhXcWlkM3U5NnRjcmlvQUtobksrRk15YUoxWFZBVFc3?=
 =?utf-8?B?Wnd1MGM3Qm92bUFDUlo4cy96ZFF3L005QUNDRnlCSDhHVVhkVHFpWlpwaEtK?=
 =?utf-8?B?YWNXZ3ZyK2NHNDlROHFtald0YitZU0RURVFER1pPVEw3VXVxbFVxS2JTS3gy?=
 =?utf-8?B?MC9jOHFtVFZuR1VyS1JGcEp1NFh0NTlIdTIzOVQ5bW9CcVd4b3MzcmVOdFFj?=
 =?utf-8?B?SXlCQ2NTUHNYOUpjNlJTbDhnU2RCWUVDNmFsM1BCN29jOWkzMm1lOXVJK09D?=
 =?utf-8?B?RjRQWnZGSGtOc1UwVDZqQVBiOFkxZ3laK3dzbm1JeDg3WFdhVExRU0hDVkw0?=
 =?utf-8?B?QWMwSTVjNmxwS1Q1RmVKVTMyNHU4WklmbTJHT3NIazNFc2Jsckx1ckRpYWtX?=
 =?utf-8?B?UFFOUUlhWXRtNVcybHJBNFJOT09XdldYb3ViL2lJSzJVY2wvbTJ0TVkwbzkv?=
 =?utf-8?B?cERJa2FqVXpkSitPaVFrNXFoT2NxdWg1S3pCY3hTd2w0WlVyKzNLbHBpTE1X?=
 =?utf-8?B?dE53bVR4SnJRRnE0NDdhZEgwOUw0d2xWdFlNT3hucXQzZnN5Kzl0V0s5U2Fv?=
 =?utf-8?B?K0NDVUxoZW8yS2FoUlpxVGhWQ3QzY3lWSTNucmJjWmlYOGl3VEI4anUyVzdo?=
 =?utf-8?B?RkFGeUhURWpQRFdnZWlRczQxeEVqR3NSc2ZJYnVvTStFVXpKejZIUEJRbWxM?=
 =?utf-8?B?QU5EeU52ZGpUdWVLUzRXV09URStVSVlvTXlBTnRkUmJDT2xEYTY5T0J2Q2pn?=
 =?utf-8?B?YjU4djM0bFY2c2lIRjdySGJYaEJXenhKallSVk5MNDcvL0czYW1GMEFRL1Vz?=
 =?utf-8?B?bUYrTkkxU2Z2MjRTKzFkZHJ3MmIwcWQ5c3YxanBTMUlIaXRNdTJDZjQ4WGIy?=
 =?utf-8?B?VVVrR1hQMGtNS1VYejhUKzlnemkzYWVVYUVpcmpteEFEYVVyaUt5V2hKOXZ1?=
 =?utf-8?B?bEUrL1ozTWhycENaNEVuQXY0eDF6dVU5NG1IQlhvMlc1M2tqKy9SVGw3ZE04?=
 =?utf-8?B?M1lFLysvNytQYkREWmtJeitOajEzYy91WFVGbVdYRWJ5TWVORTlwRVZST2M1?=
 =?utf-8?B?eklDd0VOM0pUSXV1TEl6dlA3Y01nN3N6NU1BcEUrbXNyRUtBYUozU1c4NlpB?=
 =?utf-8?B?VE5WTkxPcnlVUXFJMFR3eE1YcjRsMVZuK2tURW4vVTR4OHZWWER3alNUWXl3?=
 =?utf-8?B?QmdzSnl1bGV4K0FCc3BWT2JlSlJkZHZhZUk2cmpDcEJPWldRa1RCWTBTbFlG?=
 =?utf-8?B?NGVXV1JxdXQvelhuN3cwSXZrZkxpdDl6NVdPamJ4WmtRZTlxUGR6QzVZMkg0?=
 =?utf-8?B?UWQ4RFkvS2tYWkZIVnYyOTBnVUhGekRLVEZma24xM3lrbUp4VUNOdDJIMWJs?=
 =?utf-8?B?WUZ3MlBOUDhDamM4dVg0VnFSM0YrNkM2TWh1akdzeW5iZDhxOHMwdDhyMDN6?=
 =?utf-8?B?Y01EUHg5SmhxRVovSnlYOERDRWlzQnFTVjZRdDF3Yk41akJjZlhmK1B0M0tG?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7325b53-3ca4-4fcc-bcdc-08da6ef847d1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 11:16:26.4093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+l+BERK7drKZpWjJOWVX+kOD4a2F78N4LeXiryoVivIduB/mWn/kHD8TxlRiBI0RZp1s3aDn17HzJzVl0OcqBw8EX/dZ8Y/qthpwUXN8jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5457
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor aiocp using new LTP API
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

On 6/22/22 16:24, Cyril Hrubis wrote:
> Hi!
>> diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
>> index d315353d0..9113716cd 100644
>> --- a/testcases/kernel/io/ltp-aiodio/aiocp.c
>> +++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
>> @@ -1,607 +1,280 @@
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
>> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
> Looks like the license and copyrights were cut by a mistake from this
> file in 2005, piecing it together from the git log it should look like:
>
> // SPDX-License-Identifier: GPL-2.0-or-later
> /*
>   * Copyright (c) 2004 Stephen Hemminger <shemminger@osdl.org>
>   * Copyright (c) 2004 Daniel McNeil <daniel@osdl.org>
>   * Copyright (c) 2004 Marty Ridgeway <mridge@us.ibm.com>
>   * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>   */
>
>
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
>> +#include <sys/param.h>
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
>> +static int aionum;
>> +static int srcflags;
>> +static int dstflags;
>> +
>> +static int srcfd;
>> +static int dstfd;
>> +static long long busy;
>> +static long long tocopy;
>> +static struct iocb **iocb_free;
>> +
>> +static void fill_with_rand_data(int fd, long long size)
>> +{
>> +	int lower = 97;
>> +	int upper = 100;
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
>> +		}
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
>> +		SAFE_WRITE(0, fd, buf, j);
>> +	}
>>   
>> -static int debug;
>> -static int count_io_q_waits;	/* how many time io_queue_wait called */
>> +	SAFE_FSYNC(fd);
>> +}
>>   
>> -struct iocb **iocb_free;	/* array of pointers to iocb */
>> -int iocb_free_count;		/* current free count */
>> -int alignment = 512;		/* buffer alignment */
>> +static void async_init(void)
>> +{
>> +	int i;
>> +	char *buff;
>>   
>> -struct timeval delay;		/* delay between i/o */
>> +	iocb_free = SAFE_MALLOC(aionum * sizeof(struct iocb *));
>> +	for (i = 0; i < aionum; i++) {
>> +		iocb_free[i] = SAFE_MALLOC(sizeof(struct iocb));
>> +		buff = SAFE_MEMALIGN(alignment, aio_blksize);
>>   
>> -static int dev_block_size_by_path(const char *path)
> Just FYI this is actually the only correct way how to get the O_DIRECT
> block size, we have to get the device and then call the BLKSZGET
> ioctl(). This code has to be put into the test library and reused in all
> O_DIRECT tests in a followup patch.
>
>> -{
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
>> +		io_prep_pread(iocb_free[i], -1, buff, aio_blksize, 0);
>>   	}
>> +}
>>   
>> -	while ((mnt = getmntent(f))) {
>> -		/* Skip pseudo fs */
>> -		if (mnt->mnt_fsname[0] != '/')
>> -			continue;
>> +static void async_write_done(LTP_ATTRIBUTE_UNUSED io_context_t ctx, struct iocb *iocb, long res, long res2)
>> +{
>> +	int iosize = iocb->u.c.nbytes;
>>   
>> -		prefix_len = strlen(mnt->mnt_dir);
>> +	if (res != iosize)
>> +		tst_brk(TBROK, "Write missing bytes expect %d got %ld", iosize, res);
>>   
>> -		if (prefix_len > prefix_max &&
>> -		    !strncmp(path, mnt->mnt_dir, prefix_len)) {
>> -			prefix_max = prefix_len;
>> -			strncpy(dev_name, mnt->mnt_fsname, sizeof(dev_name));
>> -			dev_name[sizeof(dev_name)-1] = '\0';
>> -		}
>> -	}
>> +	if (res2 != 0)
>> +		tst_brk(TBROK, "Write error: %s", tst_strerrno(-res2));
>>   
>> -	endmntent(f);
>> +	--busy;
>> +	--tocopy;
>>   
>> -	if (!prefix_max) {
>> -		fprintf(stderr, "Path '%s' not found in /proc/mounts\n", path);
>> -		return 0;
>> -	}
>> +	if (dstflags & O_DIRECT)
>> +		SAFE_FSYNC(dstfd);
>> +}
>>   
>> -	printf("Path '%s' is on device '%s'\n", path, dev_name);
>> +static void async_copy(io_context_t ctx, struct iocb *iocb, long res, long res2)
>> +{
>> +	int iosize = iocb->u.c.nbytes;
>> +	char *buf = iocb->u.c.buf;
>> +	off_t offset = iocb->u.c.offset;
>> +	int w;
>>   
>> -	fd = open(dev_name, O_RDONLY);
>> -	if (!fd) {
>> -		fprintf(stderr, "open('%s'): %s\n", dev_name, strerror(errno));
>> -		return 0;
>> -	}
>> +	if (res != iosize)
>> +		tst_brk(TBROK, "Read missing bytes expect %d got %ld", iosize, res);
>>   
>> -	if (ioctl(fd, BLKSSZGET, &size)) {
>> -		fprintf(stderr, "ioctl(BLKSSZGET): %s\n", strerror(errno));
>> -		close(fd);
>> -		return 0;
>> -	}
>> +	if (res2 != 0)
>> +		tst_brk(TBROK, "Read error: %s", tst_strerrno(-res2));
>>   
>> -	close(fd);
>> -	printf("'%s' has block size %i\n", dev_name, size);
>> +	io_prep_pwrite(iocb, dstfd, buf, iosize, offset);
>> +	io_set_callback(iocb, async_write_done);
>>   
>> -	return size;
>> +	w = io_submit(ctx, 1, &iocb);
>> +	if (w < 0)
>> +		tst_brk(TBROK, "io_submit error: %s", tst_strerrno(-w));
>>   }
>>   
>> -int init_iocb(int n, int iosize)
>> +static void async_run(io_context_t ctx, int fd, io_callback_t cb)
>>   {
>> -	void *buf;
>> -	int i;
>> +	long long offset = 0;
>> +	int w, i, n;
>> +	int iosize;
>>   
>> -	if ((iocb_free = malloc(n * sizeof(struct iocb *))) == 0) {
>> -		return -1;
>> -	}
>> +	tocopy = howmany(filesize, aio_blksize);
>> +	busy = 0;
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
>> -	}
>> -	iocb_free_count = i;
>> -	return 0;
>> -}
>> +	while (tocopy > 0) {
>> +		/* Submit as many reads as once as possible up to aionum */
>> +		n = MIN(aionum - busy, aionum);
>> +		if (n > 0) {
>> +			for (i = 0; i < n; i++) {
>> +				struct iocb *io = iocb_free[i];
>>   
>> -static struct iocb *alloc_iocb(void)
>> -{
>> -	if (!iocb_free_count)
>> -		return 0;
>> -	return iocb_free[--iocb_free_count];
>> -}
>> +				iosize = MIN(filesize - offset, aio_blksize);
>>   
>> -void free_iocb(struct iocb *io)
>> -{
>> -	iocb_free[iocb_free_count++] = io;
>> -}
> This part was important as well. The I/O requests are not guaranteed to
> be processed orderly so we stored the pointers of the finished iocb
> structures in the async_write_done() function by calling this function
> so that we can reuse them later.
>
> I guess that it would be cleaner to rename the functions to something as
> put_iocb() and get_iocb() since they do not allcate anything but they
> have to stay.
Do we really need that? iocb_free buffer is always initialized and we 
can still use it all.
> +				/* If we don't have any byte to write, exit */
> +				if (iosize <= 0)
> +					break;
>   
> -/*
> - * io_wait_run() - wait for an io_event and then call the callback.
> - */
> -int io_wait_run(io_context_t ctx, struct timespec *to)
> -{
> -	struct io_event events[aio_maxio];
> -	struct io_event *ep;
> -	int ret, n;
> -
> -	/*
> -	 * get up to aio_maxio events at a time.
> -	 */
> -	ret = n = io_getevents(ctx, 1, aio_maxio, events, to);
> -
> -	/*
> -	 * Call the callback functions for each event.
> -	 */
> -	for (ep = events; n-- > 0; ep++) {
> -		io_callback_t cb = (io_callback_t) ep->data;
> -		struct iocb *iocb = ep->obj;
> -
> -		if (debug > 1) {
> -			fprintf(stderr, "ev:%p iocb:%p res:%ld res2:%ld\n",
> -				ep, iocb, ep->res, ep->res2);
> +				io_prep_pread(io, fd, io->u.c.buf, iosize, offset);
> +				io_set_callback(io, cb);
> +
> +				offset += iosize;
> +			}
> +
> +			w = io_submit(ctx, i, iocb_free);
> +			if (w < 0)
> +				tst_brk(TBROK, "io_submit write error: %s", tst_strerrno(-w));
> +
> +			busy += n;
>   		}
> -		cb(ctx, iocb, ep->res, ep->res2);
> +
> +		io_queue_run(ctx);
>   	}
> -	return ret;
>   }
>   
> -/* Fatal error handler */
> -static void io_error(const char *func, int rc)
> +static void setup(void)
>   {
> -	if (rc == -ENOSYS)
> -		fprintf(stderr, "AIO not in this kernel\n");
> -	else if (rc < 0)
> -		fprintf(stderr, "%s: %s\n", func, strerror(-rc));
> -	else
> -		fprintf(stderr, "%s: error %d\n", func, rc);
> +	struct stat sb;
> +	int maxaio;
>   
> -	if (dstfd > 0)
> -		close(dstfd);
> -	if (dstname && dest_open_flag & O_CREAT)
> -		unlink(dstname);
> -	exit(1);
> -}
> +	aio_blksize = 64 * 1024;
> +	filesize = 1 * 1024 * 1024;
> +	aionum = 16;
> +	srcflags = O_RDONLY;
> +	dstflags = O_WRONLY;
>   
> -/*
> - * Write complete callback.
> - * Adjust counts and free resources
> - */
> -static void wr_done(io_context_t ctx, struct iocb *iocb, long res, long res2)
> -{
> -	if (res2 != 0) {
> -		io_error("aio write", res2);
> -	}
> -	if (res != iocb->u.c.nbytes) {
> -		fprintf(stderr, "write missed bytes expect %lu got %ld\n",
> -			iocb->u.c.nbytes, res);
> -		exit(1);
> -	}
> -	--tocopy;
> -	--busy;
> -	free_iocb(iocb);
> -	if (debug)
> -		write(2, "w", 1);
> -}
> +	if (tst_parse_int(str_aionum, &aionum, 1, INT_MAX))
> +		tst_brk(TBROK, "Invalid number of I/O '%s'", str_aionum);
>   
> -/*
> - * Read complete callback.
> - * Change read iocb into a write iocb and start it.
> - */
> -static void rd_done(io_context_t ctx, struct iocb *iocb, long res, long res2)
> -{
> -	/* library needs accessors to look at iocb? */
> -	int iosize = iocb->u.c.nbytes;
> -	char *buf = iocb->u.c.buf;
> -	off_t offset = iocb->u.c.offset;
> +	SAFE_FILE_SCANF("/proc/sys/fs/aio-max-nr", "%d", &maxaio);
> +	tst_res(TINFO, "Maximum AIO blocks: %d", maxaio);
>   
> -	if (res2 != 0)
> -		io_error("aio read", res2);
> -	if (res != iosize) {
> -		fprintf(stderr, "read missing bytes expect %lu got %ld\n",
> -			iocb->u.c.nbytes, res);
> -		exit(1);
> -	}
> +	if (aionum > maxaio)
> +		tst_res(TCONF, "Number of async IO blocks passed the maximum (%d)", maxaio);
>   
> -	/* turn read into write */
> -	if (no_write) {
> -		--tocopy;
> -		--busy;
> -		free_iocb(iocb);
> -	} else {
> -		int fd;
> -		if (iocb->aio_fildes == srcfd)
> -			fd = dstfd;
> -		else
> -			fd = dstfd2;
> -		io_prep_pwrite(iocb, fd, buf, iosize, offset);
> -		io_set_callback(iocb, wr_done);
> -		if (1 != (res = io_submit(ctx, 1, &iocb)))
> -			io_error("io_submit write", res);
> -	}
> -	if (debug)
> -		write(2, "r", 1);
> -	if (debug > 1)
> -		printf("%d", iosize);
> -}
> +	if (tst_parse_filesize(str_aio_blksize, &aio_blksize, 1, LLONG_MAX))
> +		tst_brk(TBROK, "Invalid write blocks size '%s'", str_aio_blksize);
>   
> -static void usage(void)
> -{
> -	fprintf(stderr,
> -		"Usage: aiocp [-a align] [-s size] [-b blksize] [-n num_io]"
> -		" [-f open_flag] SOURCE DEST\n"
> -		"This copies from SOURCE to DEST using AIO.\n\n"
> -		"Usage: aiocp [options] -w SOURCE\n"
> -		"This does sequential AIO reads (no writes).\n\n"
> -		"Usage: aiocp [options] -z DEST\n"
> -		"This does sequential AIO writes of zeros.\n");
> -
> -	exit(1);
> -}
> +	SAFE_STAT(".", &sb);
> +	alignment = sb.st_blksize;
>   
> -/*
> - * Scale value by kilo, mega, or giga.
> - */
> -long long scale_by_kmg(long long value, char scale)
> -{
> -	switch (scale) {
> -	case 'g':
> -	case 'G':
> -		value *= 1024;
> -	case 'm':
> -	case 'M':
> -		value *= 1024;
> -	case 'k':
> -	case 'K':
> -		value *= 1024;
> -		break;
> -	case '\0':
> -		break;
> -	default:
> -		usage();
> -		break;
> +	if (tst_parse_filesize(str_filesize, &filesize, 1, LLONG_MAX))
> +		tst_brk(TBROK, "Invalid file size '%s'", str_filesize);
> +
> +	if (str_oflag) {
> +		if (strncmp(str_oflag, "SYNC", 4) == 0) {
> +			dstflags |= O_SYNC;
> +		} else if (strncmp(str_oflag, "DIRECT", 6) == 0) {
> +			srcflags |= O_DIRECT;
> +			dstflags |= O_DIRECT;
> +		}
>   	}
> -	return value;
>   }
>   
> -int main(int argc, char *const *argv)
> +static void run(void)
>   {
> -	struct stat st;
> -	off_t length = 0, offset = 0;
> -	off_t leftover = 0;
> +	const char *srcname = "srcfile.bin";
> +	const char *dstname = "dstfile.bin";
> +	const int buffsize = 4096;
>   	io_context_t myctx;
> -	int c;
> -	extern char *optarg;
> -	extern int optind, opterr, optopt;
> -
> -	while ((c = getopt(argc, argv, "a:b:df:n:s:wzD:")) != -1) {
> -		char *endp;
> -
> -		switch (c) {
> -		case 'a':	/* alignment of data buffer */
> -			alignment = strtol(optarg, &endp, 0);
> -			alignment = (long)scale_by_kmg((long long)alignment,
> -						       *endp);
> -			break;
> -		case 'f':	/* use these open flags */
> -			if (strcmp(optarg, "LARGEFILE") == 0 ||
> -			    strcmp(optarg, "O_LARGEFILE") == 0) {
> -				source_open_flag |= O_LARGEFILE;
> -				dest_open_flag |= O_LARGEFILE;
> -			} else if (strcmp(optarg, "TRUNC") == 0 ||
> -				   strcmp(optarg, "O_TRUNC") == 0) {
> -				dest_open_flag |= O_TRUNC;
> -			} else if (strcmp(optarg, "SYNC") == 0 ||
> -				   strcmp(optarg, "O_SYNC") == 0) {
> -				dest_open_flag |= O_SYNC;
> -			} else if (strcmp(optarg, "DIRECT") == 0 ||
> -				   strcmp(optarg, "O_DIRECT") == 0) {
> -				source_open_flag |= O_DIRECT;
> -				dest_open_flag |= O_DIRECT;
> -			} else if (strncmp(optarg, "CREAT", 5) == 0 ||
> -				   strncmp(optarg, "O_CREAT", 5) == 0) {
> -				dest_open_flag |= O_CREAT;
> -			}
> -			break;
> -		case 'd':
> -			debug++;
> -			break;
> -		case 'D':
> -			delay.tv_usec = atoi(optarg);
> -			break;
> -		case 'b':	/* block size */
> -			aio_blksize = strtol(optarg, &endp, 0);
> -			aio_blksize =
> -			    (long)scale_by_kmg((long long)aio_blksize, *endp);
> -			break;
> +	struct stat st;
> +	char srcbuff[buffsize];
> +	char dstbuff[buffsize];
> +	int fail = 0;
> +	int reads = 0;
> +	int i, r;
>   
> -		case 'n':	/* num io */
> -			aio_maxio = strtol(optarg, &endp, 0);
> -			break;
> -		case 's':	/* size to transfer */
> -			length = strtoll(optarg, &endp, 0);
> -			length = scale_by_kmg(length, *endp);
> -			break;
> -		case 'w':	/* no write */
> -			no_write = 1;
> -			break;
> -		case 'z':	/* write zero's */
> -			zero = 1;
> -			break;
> +	srcfd = SAFE_OPEN(srcname, srcflags | O_RDWR | O_CREAT, 0666);
>   
> -		default:
> -			usage();
> -		}
> -	}
> +	tst_res(TINFO, "Fill %s with random data", srcname);
> +	fill_with_rand_data(srcfd, filesize);
>   
> -	argc -= optind;
> -	argv += optind;
> +	dstfd = SAFE_OPEN(dstname, dstflags | O_WRONLY | O_CREAT, 0666);
>   
> -	if (argc < 1) {
> -		usage();
> -	}
> -	if (!zero) {
> -		if ((srcfd = open(srcname = *argv, source_open_flag)) < 0) {
> -			perror(srcname);
> -			exit(1);
> -		}
> -		argv++;
> -		argc--;
> -		if (fstat(srcfd, &st) < 0) {
> -			perror("fstat");
> -			exit(1);
> -		}
> -		if (length == 0)
> -			length = st.st_size;
> -	}
> +	tst_res(TINFO, "Copy %s -> %s", srcname, dstname);
>   
> -	if (!no_write) {
> -		/*
> -		 * We are either copying or writing zeros to dstname
> -		 */
> -		if (argc < 1) {
> -			usage();
> -		}
> -		if ((dstfd = open(dstname = *argv, dest_open_flag, 0666)) < 0) {
> -			perror(dstname);
> -			exit(1);
> -		}
> -		if (zero) {
> -			/*
> -			 * get size of dest, if we are zeroing it.
> -			 * TODO: handle devices.
> -			 */
> -			if (fstat(dstfd, &st) < 0) {
> -				perror("fstat");
> -				exit(1);
> -			}
> -			if (length == 0)
> -				length = st.st_size;
> -		}
> -	}
> -	/*
> -	 * O_DIRECT cannot handle non-sector sizes
> -	 */
> -	if (dest_open_flag & O_DIRECT) {
> -		int src_alignment = dev_block_size_by_path(srcname);
> -		int dst_alignment = dev_block_size_by_path(dstname);
> -
> -		/*
> -		 * Given we expect the block sizes to be multiple of 2 the
> -		 * larger is always divideable by the smaller, so we only need
> -		 * to care about maximum.
> -		 */
> -		if (src_alignment > dst_alignment)
> -			dst_alignment = src_alignment;
> -
> -		if (alignment < dst_alignment) {
> -			alignment = dst_alignment;
> -			printf("Forcing aligment to %i\n", alignment);
> -		}
> +	memset(&myctx, 0, sizeof(myctx));
> +	io_queue_init(aionum, &myctx);
>   
> -		if (aio_blksize % alignment) {
> -			printf("Block size is not multiple of drive block size\n");
> -			printf("Skipping the test!\n");
> -			exit(0);
> -		}
> +	async_init();
> +	async_run(myctx, srcfd, async_copy);
>   
> -		leftover = length % alignment;
> -		if (leftover) {
> -			int flag;
> -
> -			length -= leftover;
> -			if (!zero) {
> -				flag = source_open_flag & ~O_DIRECT;
> -				srcfd2 = open(srcname, flag);
> -				if (srcfd2 < 0) {
> -					perror(srcname);
> -					exit(1);
> -				}
> -			}
> -			if (!no_write) {
> -				flag = (O_SYNC | dest_open_flag) &
> -				    ~(O_DIRECT | O_CREAT);
> -				dstfd2 = open(dstname, flag);
> -				if (dstfd2 < 0) {
> -					perror(dstname);
> -					exit(1);
> -				}
> -			}
> -		}
> -	}
> +	io_destroy(myctx);
> +	SAFE_CLOSE(srcfd);
> +	SAFE_CLOSE(dstfd);
>   
> -	/* initialize state machine */
> -	memset(&myctx, 0, sizeof(myctx));
> -	io_queue_init(aio_maxio, &myctx);
> -	tocopy = howmany(length, aio_blksize);
> +	/* check if file has been copied correctly */
> +	tst_res(TINFO, "Comparing %s with %s", srcname, dstname);
>   
> -	if (init_iocb(aio_maxio, aio_blksize) < 0) {
> -		fprintf(stderr, "Error allocating the i/o buffers\n");
> -		exit(1);
> +	SAFE_STAT(dstname, &st);
> +	if (st.st_size != filesize) {
> +		tst_res(TFAIL, "Expected destination file size %lld but it's %ld", filesize, st.st_size);
> +		/* no need to compare files */
> +		return;
>   	}
>   
> -	while (tocopy > 0) {
> -		int i, rc;
> -		/* Submit as many reads as once as possible upto aio_maxio */
> -		int n = MIN(MIN(aio_maxio - busy, aio_maxio),
> -			    howmany(length - offset, aio_blksize));
> -		if (n > 0) {
> -			struct iocb *ioq[n];
> +	srcfd = SAFE_OPEN(srcname, srcflags | O_RDONLY, 0666);
> +	dstfd = SAFE_OPEN(dstname, srcflags | O_RDONLY, 0666);
>   
> -			for (i = 0; i < n; i++) {
> -				struct iocb *io = alloc_iocb();
> -				int iosize = MIN(length - offset, aio_blksize);
> -
> -				if (zero) {
> -					/*
> -					 * We are writing zero's to dstfd
> -					 */
> -					io_prep_pwrite(io, dstfd, io->u.c.buf,
> -						       iosize, offset);
> -					io_set_callback(io, wr_done);
> -				} else {
> -					io_prep_pread(io, srcfd, io->u.c.buf,
> -						      iosize, offset);
> -					io_set_callback(io, rd_done);
> -				}
> -				ioq[i] = io;
> -				offset += iosize;
> -			}
> -
> -			rc = io_submit(myctx, n, ioq);
> -			if (rc < 0)
> -				io_error("io_submit", rc);
> -
> -			busy += n;
> -			if (debug > 1)
> -				printf("io_submit(%d) busy:%d\n", n, busy);
> -			if (delay.tv_usec) {
> -				struct timeval t = delay;
> -				(void)select(0, 0, 0, 0, &t);
> -			}
> -		}
> +	reads = howmany(filesize, buffsize);
>   
> -		/*
> -		 * We have submitted all the i/o requests. Wait for at least one to complete
> -		 * and call the callbacks.
> -		 */
> -		count_io_q_waits++;
> -		rc = io_wait_run(myctx, 0);
> -		if (rc < 0)
> -			io_error("io_wait_run", rc);
> -
> -		if (debug > 1) {
> -			printf("io_wait_run: rc == %d\n", rc);
> -			printf("busy:%d aio_maxio:%d tocopy:%d\n",
> -			       busy, aio_maxio, tocopy);
> +	for (i = 0; i < reads; i++) {
> +		r = SAFE_READ(0, srcfd, srcbuff, buffsize);
> +		SAFE_READ(0, dstfd, dstbuff, buffsize);
> +		if (memcmp(srcbuff, dstbuff, r)) {
> +			fail = 1;
> +			break;
>   		}
>   	}
>   
> -	if (leftover) {
> -		/* non-sector size end of file */
> -		struct iocb *io = alloc_iocb();
> -		int rc;
> -		if (zero) {
> -			/*
> -			 * We are writing zero's to dstfd2
> -			 */
> -			io_prep_pwrite(io, dstfd2, io->u.c.buf,
> -				       leftover, offset);
> -			io_set_callback(io, wr_done);
> -		} else {
> -			io_prep_pread(io, srcfd2, io->u.c.buf,
> -				      leftover, offset);
> -			io_set_callback(io, rd_done);
> -		}
> -		rc = io_submit(myctx, 1, &io);
> -		if (rc < 0)
> -			io_error("io_submit", rc);
> -		count_io_q_waits++;
> -		rc = io_wait_run(myctx, 0);
> -		if (rc < 0)
> -			io_error("io_wait_run", rc);
> -	}
> This was there for a reason. The problem is that O_DIRECT is limited so
> that the memory buffer must be properly aligned but at the same time the
> size must be multiple of the aligment too. Given that we now create the
> file we may as well we may as well round the size in the setup so that
> we don't have to handle the leftovers like this.
>
> At the same time we have to make sure the aio_blksize was multiple of
> the alignment and TCONF in the setup if that is not the case.
Since our main target is to test aio callbacks, the leftover handling is 
not really useful and it adds more complexity to the test. Maybe we can 
round the size to align with blocks and inform user that it has been 
rounded to the next available size.
>> +	SAFE_CLOSE(srcfd);
>> +	SAFE_CLOSE(dstfd);
>>   
>> -	if (srcfd != -1)
>> -		close(srcfd);
>> -	if (dstfd != -1)
>> -		close(dstfd);
>> -	exit(0);
>> +	if (fail)
>> +		tst_res(TFAIL, "Files are not identical");
>> +	else
>> +		tst_res(TPASS, "Files are identical");
>>   }
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
>> -
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.needs_tmpdir = 1,
>> +	.options = (struct tst_option[]) {
>> +		{"b:", &str_aio_blksize, "-b\t Size of writing blocks (default 1K)"},
>> +		{"s:", &str_filesize, "-s\t Size of file (default 10M)"},
>> +		{"n:", &str_aionum, "-n\t Number of Async IO blocks (default 16)"},
>> +		{"f:", &str_oflag, "-f\t Open flag: SYNC | DIRECT (default O_CREAT only)"},
>> +		{},
>> +	},
>> +};
> I wonder if there is a value in adding optional source and destination
> options so that we can pass a files to the test as we did previously,
> but maybe we do not need that.
>
We don't need that and it was there because aiocp was a cp utility more 
than a test.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
