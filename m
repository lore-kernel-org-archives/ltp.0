Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614E9C433F5
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 15:07:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9D013C6F27
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 16:07:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EAC73C0345
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 16:07:27 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 905336017E9
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 16:07:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1638284845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PrzZppBKRhdJN/FmV1hFPvWIG1AdTiRRj6ftkyu4/gc=;
 b=Hqy5gxBYdLo6UQU2anfZsP+Yf9gvMqe88kUjggyBG0XxtUmZBpQoWBUrm9/GsblNU+EDZ4
 NPYqnhG1lGjweu2mtR4htlf9/gyoN+EipL4iXAj151ORV3im1RPMIlE+k+250b8c8gBo3+
 CU4v+6sHZByVB4rNrMOG9pMl6aWMdYw=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-b6VnHx2COwC7WYY2zo0Ceg-1; Tue, 30 Nov 2021 16:07:24 +0100
X-MC-Unique: b6VnHx2COwC7WYY2zo0Ceg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi8LXbq2azi+UwTIsFRdhtNWUjATWAGlkMGtAn17vhSVlQLaGcaEoP2blSMbU3FESAo3YluRyS7krv5tXjLx5hBxkIPuj0Q3HXwAOmm8ZMp1CIzCUcl5L12rY+B7OQS21o0p74gv5l/3mcqBKaPsUEd8PhSbYXQp9FONm4AxtLgqgMgT1tmnQyVzldTTxLP96mI9BIg0ASm+wjcsniySjHnlnUKBefiBYZzg+UaoRgiH0O2GND/ZeYZMA2p8C7l9IVnmH5GwTkWnbpBiyTOckIEFftiJqLaT2m2p+oV279zZ36V1/VD9KYwaaXhPzO3qjLYXurrSWcuwutiHNwUvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrzZppBKRhdJN/FmV1hFPvWIG1AdTiRRj6ftkyu4/gc=;
 b=XT2ahQogDrX9qMva+evu8nbkI7bIyj4lz2ashnYi0IO3kT+BS8YhbDJk68ARgpwhYRdNfEA8qlXbSc6RsAtwSPOMc9HrCEmsq9x13SBLsYQBu0GsxdDgR39/1RDnHqHw3dqpuLYhf6h1+X+If2+0yW7+/szd+CxXIdpD2JnzEOEtO64R4glTylWeW3+iFxdyxsTljwp5NgV86omtOwyemIWR854JbBwpSrytEXPrEp2PP8u8ov1cM2Bsar2bUgpEazo64hFeajdRjKxXT6n2NMZot38iaVqkNfrPqWT46yqNFeX1HUmdZYx+mbnQjIDsJPAVPrKXq7RzPjn526LyXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM9PR04MB8666.eurprd04.prod.outlook.com (2603:10a6:20b:43d::21)
 by AM9PR04MB9014.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 15:07:23 +0000
Received: from AM9PR04MB8666.eurprd04.prod.outlook.com
 ([fe80::7dd3:352c:e8a5:1a8c]) by AM9PR04MB8666.eurprd04.prod.outlook.com
 ([fe80::7dd3:352c:e8a5:1a8c%9]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 15:07:21 +0000
Message-ID: <cb0be05b-05f8-9fd0-feef-214a403d956e@suse.com>
Date: Tue, 30 Nov 2021 16:07:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To: ltp@lists.linux.it
References: <20211130145206.32124-1-andrea.cervesato@suse.com>
In-Reply-To: <20211130145206.32124-1-andrea.cervesato@suse.com>
X-ClientProxiedBy: AS9PR06CA0215.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::22) To AM9PR04MB8666.eurprd04.prod.outlook.com
 (2603:10a6:20b:43d::21)
MIME-Version: 1.0
Received: from [192.168.1.29] (151.81.112.250) by
 AS9PR06CA0215.eurprd06.prod.outlook.com (2603:10a6:20b:45e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Tue, 30 Nov 2021 15:07:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7290784f-c63f-4f54-23e2-08d9b4131c09
X-MS-TrafficTypeDiagnostic: AM9PR04MB9014:
X-Microsoft-Antispam-PRVS: <AM9PR04MB90141F6674DC6C8AEAAE40B0F8679@AM9PR04MB9014.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9h/C2O1bIMrtYQ65goq0cimLr6FintsF9/NYBy+GwK2HUHs/ZOISFUY+nY5/kUwSUnjsv6B7+DHL8VeuOu5rfHxKaQ/bpb80VRez7buSkMNJjI0U2TRzb/kY3165e2ZKJk4Ke0/HgVwonrZSkH33vkwPNlvyu3WHq/pY6do6vqtOB9dcmnECertwnWoc2TUv5Egf3tG8e1JiYtK+XbRpL9NqMWGp/jfQo+vuVIod8vDAPzf22MSY0QBfJXWvpF6sAXFKw1IfDUnKk1T2CdiaUPSMRsuFEFtCoiQdrJqOzdRroTw9xYAGKEGC592VF5t8zVCudvCSH1vzIA/rU//BmaC21KsaBNCgusW3Dl8s9cPZrtg+3rRa6KfllwPBt/YOb5Vcj78D65VnZPDsZ2f5/VPn/J6tsBw8c8Td2xX3SkLY817flm6AVavte9H76L8SqFQVzT1i/eaQSO9IMfdvtL0M2EhEdDS4T6SJwU8Le5bJ4P9yDHullyOpkdmnZ83B271m3vpC5LBCY9yGPtKTeAHqJjCumd3SjOQiffWhGdfpFpl3FeS7eh5C986ZcOpOft5x5EnG9PuuMZDvmfkenOPP3ewPSj6PUnsISs7qHX3Mar+BbAITSr//GdM72Oh4nYtd4+z9/0z2sIJzRTX1Rn9JBqU8F0oq4Sdmstt+VhVMQ6pv6j9TO6HbT+DgAvmV90RiV7WB90SGm4BymeDpTcmhBjIpkDPMVUvtDHJky9raDS12lmRhfuW2LhU/AbaR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8666.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(36756003)(5660300002)(26005)(2616005)(16576012)(38100700002)(956004)(53546011)(6486002)(30864003)(8676002)(186003)(6916009)(86362001)(33964004)(66946007)(66556008)(2906002)(66476007)(31686004)(31696002)(44832011)(8936002)(316002)(83380400001)(508600001)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGpSK1NnZTV6NmkrdFlBTFVVdmFKeDIzTEhPTkdFNThWWEk3c0ZhdExvcEdU?=
 =?utf-8?B?STE2Um9XL3psM0dEenNQRnJBMkxjQmdJbDlqcGlQUTlyd3N4elArbFVNMmox?=
 =?utf-8?B?ci9JMHViTDcwUVRMZWpFbE1FUDc5WENsZWtSRjNTamZJOGx4dWJIaFdhcG5M?=
 =?utf-8?B?aVBUV2xGb1hzYS83Y3BQeXZhenVKYVRJT25Bc004T3VSUEl1bm5YZ0lKSXV4?=
 =?utf-8?B?bDR4L3owWG43NzBITk9MR1B1ZDBMNlRRMnIxdEdOak1UV1BwRzNRWWZUTzN1?=
 =?utf-8?B?Sjl5QXZib0thK3J4ZHlHRlZyZFByQzAzVG0yTE5WdkVTNkhZdVJrZ1Mrbyts?=
 =?utf-8?B?c2ZiUTJnMWhHcU4rR1VOcXpDV2JIR1IrOXRkVmdOSVVRVlZ3eHdUcVhnVzdj?=
 =?utf-8?B?OHhvb0JWblVkanRWUC9WRThSckFCSXZrWnFaczdiWGpkWFNKVk5rLzRpNWpC?=
 =?utf-8?B?T1hocG00dEtteWFCWkVSRlBmN2pxMUY3NjRhd3RzUHlnb0h1dFNCejV5L0J0?=
 =?utf-8?B?eTVLQkszb2kyd0x4dndHNEFHUk9VNGIveFA5bnYxdDlHY2F3dC9jN0xmTUx1?=
 =?utf-8?B?U3NCVmFoRnJ1VlpLc0pGL3kyK0ppVHJTbXJ2ZXpLZFZaZHNvMDBTd1NIekE3?=
 =?utf-8?B?c05UOWhXZUptZlFEb2c0RXBlTVNCN1N4emx4R01ld1pIcXhlZnRnR3R2T05U?=
 =?utf-8?B?N3krNTFBZzBOaCtsM2pxaUR4VVpKMVdlaTloT1pyVTNDeU91c3ZQaHRHUVA0?=
 =?utf-8?B?aFlDRXdTaFhBd2hucW95WjhDZ0tOZHo2U1p0cXJESkhacVM0U2RwNTYrakYw?=
 =?utf-8?B?Mi9JcWZHR3JKQW5iZlRtSXpwUEZnQ3NGemNTZ2VSSUlPSGVZN08rd3lZVlZT?=
 =?utf-8?B?cFV6VWhnb2IzMEU0ZjJHK2pLTTRMRzY5MkVCUGJvK2c5MzQ3MGU4TlgycENL?=
 =?utf-8?B?cnpRd2FqbnhGZ21oc0JyREdKUlNuK1R6WUZhOU16VWI0bmZkVDBHb3M3V2c3?=
 =?utf-8?B?N0JiekZGaUZnVGRzamNIR3k0ZDIwQ2tIRVNFNG1sWUgwZ2xtdWZNalhXTUYv?=
 =?utf-8?B?a1RDQ3hCK29JQUsxaWp2YW83OEc2eEFJcFVxNURoWVhPU0NGZVRFMmhoSFRT?=
 =?utf-8?B?UlB3STBCQ2MwdlNzcHpoSjRobkVOVGo0U3dEQTdVNnM3MXFPRzRGQTFxSno2?=
 =?utf-8?B?Z0VIcTZRVnA0KzFRNGVKcjY5SlRISDNPRE1hbG9sYURUZXF0enhnQmd2Uldj?=
 =?utf-8?B?VUtQZjh0a1RpN1ZLc2dZK1BtdXd6dTYzU2pQWGpIZWNqNDBxZUpVM3RIRUhy?=
 =?utf-8?B?VkVKTCtXTWxLbkpacTZSTXZxUlJBN0JzR2hwNVFlcTNpTUpWVno2NVNFWEJy?=
 =?utf-8?B?MVplWmoxdU9ScG4vSWxLaTk5NVQrZi9kZEhadTdobC9yeWcrN0V0WGx1NSs1?=
 =?utf-8?B?RURhQ1REN1BZRXBJYW54SGU4QzllY3RRbFJVaDcxYi85ZWpPZHNNS3ZGS3hI?=
 =?utf-8?B?cFBMMnVSWkQ3MitMZEtidG1YNFNmM2ZSMjMwQVpoZmYyZElyUkV3bEl0YSs1?=
 =?utf-8?B?Zjc0TUdCcGtJOGtPOGFzTDdTRjRxS0xuMnk0ZEY2VGhJcFc0SlFXazNNN1lZ?=
 =?utf-8?B?RXZ3elo2RzVoVnVZc1grNkEvL1BsdHFxUjlIRndma2F3S0FpdTBxNlJteHU1?=
 =?utf-8?B?YjJaNVVWUm1QbktQZWZOZmQ0L0theDlYaDRsSGxqeTZlclBNbVd1NDZSLytY?=
 =?utf-8?B?VzV2eHN6aEl4cWRma2RZOXFyQitDNDVkbVJTQXlpb2VxbGk1dTg3SjZGbE1y?=
 =?utf-8?B?N1FjYUpySHVMQ0pLY3hldDZBUndLaVQ4aWtzeEFvQnY4YWQ3bitlVVJkWjVZ?=
 =?utf-8?B?c2ViWlVrNzRUT2hwbUZxSFBIZjk1dzl4NkdwUG04NnhPYjZnK0dIZzZZZFlW?=
 =?utf-8?B?SzU5Y2pFV3E0YXZIaUVJTUozUXl4SWRHVGxPOUZxNDZqUEM3NkZLSkNLZ2tn?=
 =?utf-8?B?QnpsLzFrc21iOEQ3Z1NUN2daL1lCU05mV3ZoR09GWmFJa0MzSmFTYVFDWUM1?=
 =?utf-8?B?YVFqK1gvRkV1R2M2VU9rWGtaRWNtVFlmbHc0NmtNL3V5WTVKK2ZmM3g0MmNo?=
 =?utf-8?B?bzByaGtSYWhPQzVZczdPL2pUQTBNNW4zUnBjeGJWSzlWTnVZOWNqRFgyOVdF?=
 =?utf-8?B?cjZRd0M0c2xPUlpHZnhVelV1QkJTY0w2RjFpMng5ODRXNlNqcTlOMTlJZWVQ?=
 =?utf-8?B?bmI4MGlUQlJoaVJDZzFGQ2tsaWlnPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7290784f-c63f-4f54-23e2-08d9b4131c09
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 15:07:21.8739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWZUJu3TApZJitFSSZQXF0aylOy6TQyH4lI9hnOKZJeHSbDUtqHsOEg35/Q32X7cPEdwxs1z8WfRQr+WbAibj+er5bdd4LwbIiWcZS4jRQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9014
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactoring dio_append.c test using LTP API
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
Content-Type: multipart/mixed; boundary="===============0417633903=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0417633903==
Content-Type: multipart/alternative;
 boundary="------------aXQx0I6lqXq5yu0ixTC1fLAj"
Content-Language: en-US

--------------aXQx0I6lqXq5yu0ixTC1fLAj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

there's an bug in the patch that I'm going to fix in v2

Andrea

On 11/30/21 15:52, Andrea Cervesato wrote:
> Signed-off-by: Andrea Cervesato<andrea.cervesato@suse.com>
> ---
>   testcases/kernel/io/ltp-aiodio/dio_append.c | 174 ++++++++------------
>   1 file changed, 71 insertions(+), 103 deletions(-)
>
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
> index b1b4dc039..d6999064d 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_append.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
> @@ -1,143 +1,111 @@
> -
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2004 Daniel McNeil<daniel@osdl.org>
> - *               2004 Open Source Development Lab
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
> - * Module: .c
> + *				 2004 Open Source Development Lab
> + *				 2004  Marty Ridgeway<mridge@us.ibm.com>
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato<andrea.cervesato@suse.com>
>    */
>   
> -/*
> - * Change History:
> - *
> - * 2/2004  Marty Ridgeway (mridge@us.ibm.com) Changes to adapt to LTP
> +/*\
> + * [Description]
>    *
> + * Append zeroed data to a file using O_DIRECT while other processes are doing
> + * buffered reads and check if the buffer reads always see zero.
>    */
> -/*
> - * dio_append - append zeroed data to a file using O_DIRECT while
> - *	a 2nd process is doing buffered reads and check if the buffer
> - *	reads always see zero.
> - */
> +
>   #define _GNU_SOURCE
>   
>   #include <stdlib.h>
> -#include <sys/types.h>
> -#include <signal.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <stdio.h>
>   #include <unistd.h>
> -#include <memory.h>
> -#include <limits.h>
> +#include <fcntl.h>
> +#include "tst_test.h"
> +#include "common.h"
>   
> -#include "test.h"
> -#define NUM_CHILDREN 8
> +#define NUM_CHILDREN 16
> +#define FILE_SIZE (64 * 1024)
>   
> -#include "common_checkzero.h"
> +static int *run_child;
>   
> -int read_eof(char *filename)
> +static void read_eof(const char *filename, size_t bs)
>   {
>   	int fd;
> -	int i;
>   	int r;
> -	char buf[4096];
> +	char *bufptr;
>   
> -	while ((fd = open(filename, O_RDONLY)) < 0) {
> -		sleep(1);	/* wait for file to be created */
> -	}
> +	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
> +
> +	while ((fd = open(filename, O_RDONLY, 0666)) < 0)
> +		usleep(100);
>   
> -	for (i = 0; i < 1000000; i++) {
> +	tst_res(TINFO, "child %i reading file", getpid());
> +	while (*run_child) {
>   		off_t offset;
>   		char *bufoff;
>   
> -		offset = lseek(fd, SEEK_END, 0);
> -		r = read(fd, buf, 4096);
> -		if (r > 0) {
> -			if ((bufoff = check_zero(buf, r))) {
> -				fprintf(stderr, "non-zero read at offset %p\n",
> -					offset + bufoff);
> -				exit(1);
> +		offset = SAFE_LSEEK(fd, 0, SEEK_SET);
> +		do {
> +			r = read(fd, bufptr, bs);
> +			if (r > 0) {
> +				bufoff = check_zero(bufptr, r);
> +				if (bufoff) {
> +					tst_res(TINFO, "non-zero read at offset %zu",
> +						offset + (bufoff - bufptr));
> +					free(bufptr);
> +					SAFE_CLOSE(fd);
> +					return;
> +				}
> +				offset += r;
>   			}
> -		}
> +		} while (r > 0);
>   	}
> -	return 0;
> +
> +	free(bufptr);
> +	SAFE_CLOSE(fd);
>   }
>   
> -void dio_append(char *filename)
> +static void setup(void)
>   {
> -	int fd;
> -	void *bufptr = NULL;
> -	int i;
> -	int w;
> -
> -	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
> -
> -	if (fd < 0) {
> -		perror("cannot create file");
> -		return;
> -	}
> -
> -	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
> -	if (TEST_RETURN) {
> -		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
> -		close(fd);
> -		return;
> -	}
> +	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +}
>   
> -	memset(bufptr, 0, 64 * 1024);
> -	for (i = 0; i < 1000; i++) {
> -		if ((w = write(fd, bufptr, 64 * 1024)) != 64 * 1024) {
> -			fprintf(stderr, "write %d returned %d\n", i, w);
> -		}
> -	}
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP(run_child, sizeof(int));
>   }
>   
> -int main(void)
> +static void run(void)
>   {
> -	char filename[PATH_MAX];
> -	int pid[NUM_CHILDREN];
> -	int num_children = 1;
> +	char *filename = "file";
> +	int filesize = FILE_SIZE;
> +	int num_children = NUM_CHILDREN;
> +	int status;
>   	int i;
>   
> -	snprintf(filename, sizeof(filename), "%s/aiodio/file",
> -		 getenv("TMP") ? getenv("TMP") : "/tmp");
> -
> -	printf("Begin dio_append test...\n");
> +	*run_child = 1;
>   
>   	for (i = 0; i < num_children; i++) {
> -		if ((pid[i] = fork()) == 0) {
> -			/* child */
> -			return read_eof(filename);
> -		} else if (pid[i] < 0) {
> -			/* error */
> -			perror("fork error");
> -			break;
> -		} else {
> -			/* Parent */
> -			continue;
> +		if (!SAFE_FORK()) {
> +			read_eof(filename, filesize);
> +			return;
>   		}
>   	}
>   
> -	/*
> -	 * Parent appends to end of file using direct i/o
> -	 */
> +	tst_res(TINFO, "parent append to file");
>   
> -	dio_append(filename);
> +	io_append(filename, 0, O_DIRECT | O_WRONLY | O_CREAT, filesize, 1000);
>   
> -	for (i = 0; i < num_children; i++) {
> -		kill(pid[i], SIGTERM);
> -	}
> -	return 0;
> +	if (SAFE_WAITPID(-1, &status, WNOHANG))
> +		tst_res(TFAIL, "Non zero bytes read");
> +	else
> +		tst_res(TPASS, "All bytes read were zeroed");
> +
> +	*run_child = 0;
>   }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +};
--------------aXQx0I6lqXq5yu0ixTC1fLAj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi,</font></p>
    <p><font size="4">there's an bug in the patch that I'm going to fix
        in v2</font></p>
    <p><font size="4">Andrea</font><br>
    </p>
    <div class="moz-cite-prefix">On 11/30/21 15:52, Andrea Cervesato
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211130145206.32124-1-andrea.cervesato@suse.com">
      <pre class="moz-quote-pre" wrap="">Signed-off-by: Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>
---
 testcases/kernel/io/ltp-aiodio/dio_append.c | 174 ++++++++------------
 1 file changed, 71 insertions(+), 103 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index b1b4dc039..d6999064d 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -1,143 +1,111 @@
-
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2004 Daniel McNeil <a class="moz-txt-link-rfc2396E" href="mailto:daniel@osdl.org">&lt;daniel@osdl.org&gt;</a>
- *               2004 Open Source Development Lab
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * Module: .c
+ *				 2004 Open Source Development Lab
+ *				 2004  Marty Ridgeway <a class="moz-txt-link-rfc2396E" href="mailto:mridge@us.ibm.com">&lt;mridge@us.ibm.com&gt;</a>
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>
  */
 
-/*
- * Change History:
- *
- * 2/2004  Marty Ridgeway (<a class="moz-txt-link-abbreviated" href="mailto:mridge@us.ibm.com">mridge@us.ibm.com</a>) Changes to adapt to LTP
+/*\
+ * [Description]
  *
+ * Append zeroed data to a file using O_DIRECT while other processes are doing
+ * buffered reads and check if the buffer reads always see zero.
  */
-/*
- * dio_append - append zeroed data to a file using O_DIRECT while
- *	a 2nd process is doing buffered reads and check if the buffer
- *	reads always see zero.
- */
+
 #define _GNU_SOURCE
 
 #include &lt;stdlib.h&gt;
-#include &lt;sys/types.h&gt;
-#include &lt;signal.h&gt;
-#include &lt;errno.h&gt;
-#include &lt;fcntl.h&gt;
-#include &lt;stdio.h&gt;
 #include &lt;unistd.h&gt;
-#include &lt;memory.h&gt;
-#include &lt;limits.h&gt;
+#include &lt;fcntl.h&gt;
+#include &quot;tst_test.h&quot;
+#include &quot;common.h&quot;
 
-#include &quot;test.h&quot;
-#define NUM_CHILDREN 8
+#define NUM_CHILDREN 16
+#define FILE_SIZE (64 * 1024)
 
-#include &quot;common_checkzero.h&quot;
+static int *run_child;
 
-int read_eof(char *filename)
+static void read_eof(const char *filename, size_t bs)
 {
 	int fd;
-	int i;
 	int r;
-	char buf[4096];
+	char *bufptr;
 
-	while ((fd = open(filename, O_RDONLY)) &lt; 0) {
-		sleep(1);	/* wait for file to be created */
-	}
+	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
+
+	while ((fd = open(filename, O_RDONLY, 0666)) &lt; 0)
+		usleep(100);
 
-	for (i = 0; i &lt; 1000000; i++) {
+	tst_res(TINFO, &quot;child %i reading file&quot;, getpid());
+	while (*run_child) {
 		off_t offset;
 		char *bufoff;
 
-		offset = lseek(fd, SEEK_END, 0);
-		r = read(fd, buf, 4096);
-		if (r &gt; 0) {
-			if ((bufoff = check_zero(buf, r))) {
-				fprintf(stderr, &quot;non-zero read at offset %p\n&quot;,
-					offset + bufoff);
-				exit(1);
+		offset = SAFE_LSEEK(fd, 0, SEEK_SET);
+		do {
+			r = read(fd, bufptr, bs);
+			if (r &gt; 0) {
+				bufoff = check_zero(bufptr, r);
+				if (bufoff) {
+					tst_res(TINFO, &quot;non-zero read at offset %zu&quot;,
+						offset + (bufoff - bufptr));
+					free(bufptr);
+					SAFE_CLOSE(fd);
+					return;
+				}
+				offset += r;
 			}
-		}
+		} while (r &gt; 0);
 	}
-	return 0;
+
+	free(bufptr);
+	SAFE_CLOSE(fd);
 }
 
-void dio_append(char *filename)
+static void setup(void)
 {
-	int fd;
-	void *bufptr = NULL;
-	int i;
-	int w;
-
-	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
-
-	if (fd &lt; 0) {
-		perror(&quot;cannot create file&quot;);
-		return;
-	}
-
-	TEST(posix_memalign(&amp;bufptr, 4096, 64 * 1024));
-	if (TEST_RETURN) {
-		tst_resm(TBROK | TRERRNO, &quot;cannot malloc aligned memory&quot;);
-		close(fd);
-		return;
-	}
+	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
 
-	memset(bufptr, 0, 64 * 1024);
-	for (i = 0; i &lt; 1000; i++) {
-		if ((w = write(fd, bufptr, 64 * 1024)) != 64 * 1024) {
-			fprintf(stderr, &quot;write %d returned %d\n&quot;, i, w);
-		}
-	}
+static void cleanup(void)
+{
+	SAFE_MUNMAP(run_child, sizeof(int));
 }
 
-int main(void)
+static void run(void)
 {
-	char filename[PATH_MAX];
-	int pid[NUM_CHILDREN];
-	int num_children = 1;
+	char *filename = &quot;file&quot;;
+	int filesize = FILE_SIZE;
+	int num_children = NUM_CHILDREN;
+	int status;
 	int i;
 
-	snprintf(filename, sizeof(filename), &quot;%s/aiodio/file&quot;,
-		 getenv(&quot;TMP&quot;) ? getenv(&quot;TMP&quot;) : &quot;/tmp&quot;);
-
-	printf(&quot;Begin dio_append test...\n&quot;);
+	*run_child = 1;
 
 	for (i = 0; i &lt; num_children; i++) {
-		if ((pid[i] = fork()) == 0) {
-			/* child */
-			return read_eof(filename);
-		} else if (pid[i] &lt; 0) {
-			/* error */
-			perror(&quot;fork error&quot;);
-			break;
-		} else {
-			/* Parent */
-			continue;
+		if (!SAFE_FORK()) {
+			read_eof(filename, filesize);
+			return;
 		}
 	}
 
-	/*
-	 * Parent appends to end of file using direct i/o
-	 */
+	tst_res(TINFO, &quot;parent append to file&quot;);
 
-	dio_append(filename);
+	io_append(filename, 0, O_DIRECT | O_WRONLY | O_CREAT, filesize, 1000);
 
-	for (i = 0; i &lt; num_children; i++) {
-		kill(pid[i], SIGTERM);
-	}
-	return 0;
+	if (SAFE_WAITPID(-1, &amp;status, WNOHANG))
+		tst_res(TFAIL, &quot;Non zero bytes read&quot;);
+	else
+		tst_res(TPASS, &quot;All bytes read were zeroed&quot;);
+
+	*run_child = 0;
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};
</pre>
    </blockquote>
  </body>
</html>
--------------aXQx0I6lqXq5yu0ixTC1fLAj--


--===============0417633903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0417633903==--

