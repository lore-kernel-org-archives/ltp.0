Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC83C433F5
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 14:40:27 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7B561BFA
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 14:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC7B561BFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5988B3C819C
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 15:40:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D37E3C071A
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 15:40:12 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 48C961A0099D
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 15:40:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1636987210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ypO0QTe95Y4ZGHxN08UYw+BErisJMboaHpdbC7OHuBk=;
 b=eavmlohVtxKbQj5G5iQFmLKTo/5JWUGwpZEWR89WSWbDhiwLYWkVlsRZjNNaC5bLgKrjLd
 0PzWFrXaS0taKOjAM6g8KDvMsmcLWzXJoQ8eYjpD4xIcHLnBetZJCZlzS16rtRN4KHnX12
 8XMjF12egUj+J2wfPYj9KCkPZxqzFFE=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-dgQl9rorMqmo2MYUpBaWHQ-1; Mon, 15 Nov 2021 15:40:09 +0100
X-MC-Unique: dgQl9rorMqmo2MYUpBaWHQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbGd/i6hNWL949tyaT6z8YMztRlNbDwxqLFxGRjjgPHwKTMmSSUOVIUEtJqjvZ3x5SCJqI5qlVK8lpcTpvHHvJjQSPAHEopmcuxZ860DFvkY/jFkuD0JxWZ9shElb87UvVWnrjzzvL9wjj7U5J5Ak/qwMAAQI6N2nxIxNh5P/pNfhlo94wvk9Xc10NP8Fvt4mpMCjLnBh34MeIMz5UTG/BMNZsWebeHKnkG0uEvF7nKQyWCU2EF+/cHJ/zVy1nuifkSZ78SDGFgK/N5SeTOU/c2AwS+E5QApW+Pih2UNR48//6xhyKmTYifsChPsvqBKyGeO4s5g+FvshI+84dZizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypO0QTe95Y4ZGHxN08UYw+BErisJMboaHpdbC7OHuBk=;
 b=NqXoPotCPOn/mCzVDOJgJdYjswkM3ZUdD4L13c80NbYyOMWHzxDWS0zPC0vhLD+dCSpFNyPywgDU8K+Faev3x6v6ERBpyLXiySzu/qBfeGo9PY+4SBVpTdOi05xGl7WvBy4kSEav/wAzPLoGh4O3faTdrMJ/UWLwCDq8vSNXTTEI4nmJqFbMKINB2w3gZcPuWdWqml+I9hiCw7fY4HsBnT07+ruXNh/BpCYfvGaBDktl3TBgE1FaXoBbygX+Ge+QxIH3zmImEgjpKj8F9bcq/fqcwKO4yZamCdTjsLysUkVcm6JSRPAoZATcIFB/TL2jzljj++pv64IwCvwAqM3T1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM9PR04MB8666.eurprd04.prod.outlook.com (2603:10a6:20b:43d::21)
 by AS4PR04MB9268.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Mon, 15 Nov
 2021 14:40:08 +0000
Received: from AM9PR04MB8666.eurprd04.prod.outlook.com
 ([fe80::7dd3:352c:e8a5:1a8c]) by AM9PR04MB8666.eurprd04.prod.outlook.com
 ([fe80::7dd3:352c:e8a5:1a8c%7]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 14:40:07 +0000
Message-ID: <4eb40296-0486-40e9-9986-b47ec1275bd5@suse.com>
Date: Mon, 15 Nov 2021 15:40:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To: ltp@lists.linux.it
References: <20211115133412.25194-1-acervesato@suse.de>
In-Reply-To: <20211115133412.25194-1-acervesato@suse.de>
X-ClientProxiedBy: AS9PR06CA0365.eurprd06.prod.outlook.com
 (2603:10a6:20b:460::17) To AM9PR04MB8666.eurprd04.prod.outlook.com
 (2603:10a6:20b:43d::21)
MIME-Version: 1.0
Received: from [192.168.1.29] (151.81.112.250) by
 AS9PR06CA0365.eurprd06.prod.outlook.com (2603:10a6:20b:460::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend
 Transport; Mon, 15 Nov 2021 14:40:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b9bbc2f-915a-45b8-b465-08d9a845d1cc
X-MS-TrafficTypeDiagnostic: AS4PR04MB9268:
X-Microsoft-Antispam-PRVS: <AS4PR04MB92683169188F23AFEF22634DF8989@AS4PR04MB9268.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHq68leYegOvODP1jXmD3OFLZM6ZYOXibipQGiQOWyQad5Nx4K9V+XcmzIkOTOstaw1q61UeMxga2hpKv/4e75Z8029WTcZOrhPTTkGpcB8uLVm0N22/rmhN+Php5X3/gak7HbE8mBHqXMFU9OJpfhlb+F7ijOqVMSFRiaWJeO/qtwBC/9MIJvtV//VCX5dB+I98n/wClgMrLO+/AJEwYQJ97jnFl62YnBdoSzF6mmy7u7EoRu1Dvlzbz77REYgzwi/slsjfhpc9+apqYyui1brDib16qIrarjhZkM9CUu/NhzneDD6HJRVSy2I2/5g3PkoI5V+mbewRIz2E/CSFUI8l/hxzrKktbgmX08XhiMvlzr21n2pZrLFpmyRuXhgLN1eHMwc+tWyC2jGIWIjC4PNc2NWqvPiZG2WjqJ/In7bqfWW/R0a8d9aRgD3+jC3/plQ4GUekSyb1/J6ZbbcgCdo6FUo2uCkwCPMxjx/oDPs8fDr+OVnT6cmeP8PdNXAmetSNvWfeltoM3fLixpg/omq/byLqqjCqS4i/PxsS24KfyAeKxqYrtcZCpKHc2xuqckvUUHOvDg8VkwpmBWIulprb6MzZHI5Mb6As3LwctOkhfQtEWBFuLaz6IBoV/6G9zYrKUeDxus5t5nECGxcoPoyIGU3NDUI6yElH4Oa4QQnyTP0zGfKlcIXurxL7YbQ0zqrqCH944jr3nRDr8vSvDU0NZWdbYTaBhOCsIAf3iKSO4t4HfC5rXyj3kXPulm02
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8666.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(86362001)(508600001)(5660300002)(2616005)(8936002)(8676002)(6916009)(36756003)(33964004)(53546011)(83380400001)(38100700002)(186003)(44832011)(2906002)(66476007)(66556008)(66946007)(31696002)(6486002)(30864003)(16576012)(31686004)(316002)(956004)(26005)(2004002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0E3QldMbXZZZFVpd1VIVWtoVm9NN0NNWFR4aGZITHBKMTR4akJuTFZaWmZZ?=
 =?utf-8?B?aFErMC9vWS9ETUM1MXRxdzZzSWVNSURHTDV1VzFhdW1WTTdrK3ZSUUJIeGdX?=
 =?utf-8?B?Y3BoTmFqc1VSSE1FZ3Nzekhqb1g2bkY0dy9JMnZLQnhhOWprY0ZTbmJsa0lS?=
 =?utf-8?B?ejZHOXFmWE5rWHNRRGJvazhpendTY3I4VGpMN0RpYU0wbEJEV0FCRjMxNFM5?=
 =?utf-8?B?Y0NHM2hHT0tUZjRmYlFKUHJzYU1tdldacTJGMzkxNVhYUHBrSHhTcFhNSVJ5?=
 =?utf-8?B?a3F2endtQjhMaVg4WHpBY2xGNm1uT0lLRDl4THZCRngybExRUHE3VkhkbTVC?=
 =?utf-8?B?N28zdncya0xhbWpiU2hjekh1RkpzUHVTU0tFbGk3cVNheEd1djBnR1NnR2tZ?=
 =?utf-8?B?ZUl0N1pYMmdKVVZITVRHV3k5WDZHWlJ2OU5zNUxuNmQ5YlR5a3d1STdFT1c1?=
 =?utf-8?B?ZmJGczFSUGRHWGZWWnNaUUJjWW8xaG9mVi8wT1dBcnMrNDcwK1RDVENDOFlz?=
 =?utf-8?B?bVlpci96VXY0Y3pLNGdod0YxK2NVb2RZSkFQaUk2cWZ5MlR5dXVmRGNEU2dS?=
 =?utf-8?B?ejBpMENDVFJKQzRTeDFicU5Mdms0K2loWDFIT0FGSmdLdzVKZElyNmVpZXdu?=
 =?utf-8?B?L2gxOEZzcUN2djEwZmxsbG9aTjdLbnlsL0ZieHZ3VUNEazAvT3FocE1zOTky?=
 =?utf-8?B?NkNzQW5mY3FrYmt3WllORlJNN2xUL0ZzKzdGUUc4N0FkdEdmYkswL1ZUU1Jk?=
 =?utf-8?B?ZWQ0UFo2Nmtac0cvWkRicHNmM1dZUVB0UnJrMVJxai9Hd1ZVSGZWN0U5TUdT?=
 =?utf-8?B?enNESmdDb2JMWEIwL0IyNEJYbThuSG1BcGt3ZVAweEZ6cUE3S2J3c3pwV0Vt?=
 =?utf-8?B?RzBZTHkxWFp0eXc1QTlXTm5uWWdPMWJmS2RnbVhiU3dQQ0tGK1BBTldnck1J?=
 =?utf-8?B?YTZaY1ovZlVlOTQzbE1COTRRRnNYOStkWG5IMzFya3JwUkNMaXBURHVJSzZa?=
 =?utf-8?B?ZHRKTHZ0eGhEUi9NNG1YNHI1QkRPM1BGN1l4Y2V2VkwrSy9DZThtcG5aQ2N6?=
 =?utf-8?B?NWM3K3BJZ1h3cjY3V05OeVA5VDJ6R203R2gvNWZuL1pPM0pkWnhqSldidUFJ?=
 =?utf-8?B?VlZSTzVWQU50eFN1ckFFNlJ3L0ZyQXpSeWJRZGpFQWRZM0VsL002SmRJb2lN?=
 =?utf-8?B?dUJIWlJuRnlWNkJhY0ExVGQ3MitFV3N1ZnVLQjFKZ2toMFFEdjB6eWg2bHZY?=
 =?utf-8?B?RzgyejNIeVpkeWk4b2pwdVZ0NnI1dEkzV3ord0FGRitHUjhCMW5SOGp0K2g1?=
 =?utf-8?B?czFxL1g0N2pxWHRXdGpZTVFpZEI4MjZ0ZGU0d3VHVTZoc0tGSTBZR2VNb3ZW?=
 =?utf-8?B?RHQ1dndkNE8wOXZLdWhpM0xlNkpQamExTnNqUDdaTjJ6NFAybGxmTWptS0hB?=
 =?utf-8?B?enpDU1JkTWg2ajVjdGt4SmxMR1Q4ZmhHWjJSNHJjYWRtaXpMaHpseVNXdnFS?=
 =?utf-8?B?NisxemVCeW1iRVJEOE1JdktJalpjdm5DOWM4ZTg4QldBYUg3bmNrS1NKb1dP?=
 =?utf-8?B?aytRV21TdTAydmIwSEl6NHkvSXlXOTAvNFBLMWYyY01PWG9kVy9SWS96MFN4?=
 =?utf-8?B?akUwSjFvNEVENURnTWRrZDkxaEdzZ09OeGtIS3FpdUM4R0dhOVYya0VDeno3?=
 =?utf-8?B?RHk1Z25nZXVpdDdpYWRUOU8wK3E0b3BjWHR1ZVFlQTd2SCtnYnZIZlNGZ2NT?=
 =?utf-8?B?ZFJueFIzMC8vZHp1VWxxVy9qek1PRXVUSU5OVlY1YmNXU1lqT2lUTWdvdmRT?=
 =?utf-8?B?SmdIQkxKSWE3TjlQSTFKY0dwN1F4TWpuR1pxRkJGRE1xZVBBODhjdFZhVFpZ?=
 =?utf-8?B?SXk3SUUvNnNqSzQrRExUYTgzVTJOUFc2ZnU2b0pBSGpyWDh4QWUrR2hUZVRm?=
 =?utf-8?B?M1RrY3RRU1RXQmZEdmcxcExQcmtoQWo4ZElVY0NjVWhPVjBoUjNyODdsV1FZ?=
 =?utf-8?B?eUdtUjVIbnlaek5Sa2VkRDF1MlR3bjJEWlkyNlllWnA1OXFZM3h2NjdNWkFk?=
 =?utf-8?B?ckpiSTk1QWJUZFd4OFRFZDlzenN4cXRhZGVNNUlBdXJGTXprbm91d3VteFNs?=
 =?utf-8?B?RzJDNHZhYjM0Z1V5RndSTXZYQjR5N1F5blZybWhBTzA4QWpjanRDcG5SYTJ1?=
 =?utf-8?B?bmpldFRiYlBRSndiL0gyVmt4SVo3cUN3VmZxcHpQZE03TU5MZGFrQzF1OVhr?=
 =?utf-8?B?ZURJVEx0WWpqaFFHZEQrRVJuSWxnPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9bbc2f-915a-45b8-b465-08d9a845d1cc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 14:40:07.7033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krOfv0q4a7I4t1UcdeIszwrc3rgEm9NOn9TcaX9LIF36jI+Cz0HqjwjWa+2obnLq7pJMVNuUfXBpsDtkr5gtph5ppTMOefMTMJyAE5bAmpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9268
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] dio_truncate.c test refactory with LTP API
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
Content-Type: multipart/mixed; boundary="===============0603874770=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0603874770==
Content-Type: multipart/alternative;
 boundary="------------fUdHjCou5fPNmGQ6PCVoK5vI"
Content-Language: en-US

--------------fUdHjCou5fPNmGQ6PCVoK5vI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

please ignore this patch since it has been sent by accident: it's the 
v1. I sent the correct v2 patch in the next email.

Andrea

On 11/15/21 14:34, Andrea Cervesato wrote:
> From: Andrea Cervesato<andrea.cervesato@suse.com>
>
> ---
>   testcases/kernel/io/ltp-aiodio/dio_truncate.c | 206 +++++++-----------
>   1 file changed, 79 insertions(+), 127 deletions(-)
>
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
> index 27cf01525..9c8da539e 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
> @@ -1,7 +1,7 @@
> -
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - * Copyright (c) 2004 Daniel McNeil<daniel@osdl.org>
> - *               2004 Open Source Development Lab
> + * Copyright (c) 2021 Andrea Cervesato<andrea.cervesato@suse.com>
> + *			   2021 SUSE Enterprise Linux
>    *   This program is free software;  you can redistribute it and/or modify
>    *   it under the terms of the GNU General Public License as published by
>    *   the Free Software Foundation; either version 2 of the License, or
> @@ -19,159 +19,111 @@
>    * Module: .c
>    */
>   
> -/*
> - * Change History:
> - *
> - * 2/2004  Marty Ridgeway (mridge@us.ibm.com) Changes to adapt to LTP
> - *
> - */
>   #define _GNU_SOURCE
>   
>   #include <stdlib.h>
> +#include <stdio.h>
> +#include <sys/stat.h>
>   #include <sys/types.h>
> -#include <signal.h>
> -#include <errno.h>
>   #include <fcntl.h>
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <memory.h>
> -#include <string.h>
> -#include <limits.h>
> -
> -#include "test.h"
> +#include "tst_test.h"
>   
> -#define NUM_CHILDREN 8
> +static char *FILENAME = "file.bin";
> +static long FILESIZE = 64 * 1024;
> +static int STARTING_CHARS = 10;
>   
> -char *check_zero(unsigned char *buf, int size)
> -{
> -	unsigned char *p;
> -
> -	p = buf;
> -
> -	while (size > 0) {
> -		if (*buf != 0) {
> -			fprintf(stderr,
> -				"non zero buffer at buf[%d] => 0x%02x,%02x,%02x,%02x\n",
> -				buf - p, (unsigned int)buf[0],
> -				size > 1 ? (unsigned int)buf[1] : 0,
> -				size > 2 ? (unsigned int)buf[2] : 0,
> -				size > 3 ? (unsigned int)buf[3] : 0);
> -			fprintf(stderr, "buf %p, p %p\n", buf, p);
> -			return buf;
> -		}
> -		buf++;
> -		size--;
> -	}
> -	return 0;		/* all zeros */
> -}
> -
> -int dio_read(char *filename)
> +int dio_append(const char *path, char pattern, size_t bs, size_t bcount)
>   {
>   	int fd;
> -	int r;
> -	void *bufptr = NULL;
>   
> -	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
> -	if (TEST_RETURN) {
> -		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
> +	fd = SAFE_OPEN(path, O_CREAT|O_WRONLY|O_DIRECT, 0666);
> +
> +	if (tst_fill_fd(fd, pattern, bs, bcount)) {
> +		SAFE_CLOSE(fd);
>   		return -1;
>   	}
>   
> -	while ((fd = open(filename, O_DIRECT | O_RDONLY)) < 0) {
> -	}
> -	fprintf(stderr, "dio_truncate: child reading file\n");
> -	while (1) {
> -		off_t offset;
> -		char *bufoff;
> -
> -		/* read the file, checking for zeros */
> -		offset = lseek(fd, SEEK_SET, 0);
> -		do {
> -			r = read(fd, bufptr, 64 * 1024);
> -			if (r > 0) {
> -				if ((bufoff = check_zero(bufptr, r))) {
> -					fprintf(stderr,
> -						"non-zero read at offset %p\n",
> -						offset + bufoff);
> -					exit(1);
> -				}
> -				offset += r;
> -			}
> -		} while (r > 0);
> -	}
> +	SAFE_CLOSE(fd);
> +
>   	return 0;
>   }
>   
> -void dio_append(char *filename, int fill)
> +int dio_get_zeros(const char *path, size_t bs)
>   {
> -	int fd;
> +	int i = 0;
> +	int fd = 0;
> +	int zeros = 0;
>   	void *bufptr = NULL;
> -	int i;
> -	int w;
>   
> -	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
> +	fd = SAFE_OPEN(path, O_RDONLY|O_DIRECT, 0666);
>   
> -	if (fd < 0) {
> -		perror("cannot create file");
> -		return;
> -	}
> +	bufptr = SAFE_MALLOC(bs * sizeof(void));
> +	SAFE_READ(0, fd, bufptr, bs);
>   
> -	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
> -	if (TEST_RETURN) {
> -		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
> -		close(fd);
> -		return;
> +	for (i = 0; i < (int)bs; i++) {
> +		if (*(char *)bufptr == 0)
> +			zeros++;
> +		bufptr++;
>   	}
>   
> -	memset(bufptr, fill, 64 * 1024);
> +	SAFE_CLOSE(fd);
>   
> -	for (i = 0; i < 1000; i++) {
> -		if ((w = write(fd, bufptr, 64 * 1024)) != 64 * 1024) {
> -			fprintf(stderr, "write %d returned %d\n", i, w);
> -		}
> -	}
> -	close(fd);
> +	return zeros;
>   }
>   
> -int main(void)
> +off_t getsize(const char *filename)
>   {
> -	char filename[PATH_MAX];
> -	int pid[NUM_CHILDREN];
> -	int num_children = 1;
> -	int i;
> -
> -	snprintf(filename, sizeof(filename), "%s/aiodio/file",
> -		 getenv("TMP") ? getenv("TMP") : "/tmp");
> -
> -	for (i = 0; i < num_children; i++) {
> -		if ((pid[i] = fork()) == 0) {
> -			/* child */
> -			return dio_read(filename);
> -		} else if (pid[i] < 0) {
> -			/* error */
> -			perror("fork error");
> -			break;
> -		} else {
> -			/* Parent */
> -			continue;
> -		}
> -	}
> +	struct stat st;
>   
> -	/*
> -	 * Parent creates a zero file using DIO.
> -	 * Truncates it to zero
> -	 * Create another file with '0xaa'
> -	 */
> -	for (i = 0; i < 100; i++) {
> -		dio_append(filename, 0);
> -		truncate(filename, 0);
> -		dio_append("junkfile", 0xaa);
> -		truncate("junkfile", 0);
> -	}
> +	if (SAFE_STAT(filename, &st) == 0)
> +		return st.st_size;
> +
> +	return -1;
> +}
> +
> +static void run(void)
> +{
> +	int charnum = 0;
> +	long empty_ch = FILESIZE - STARTING_CHARS;
> +
> +	tst_res(TINFO, "Create %s filled with %d chars", FILENAME, STARTING_CHARS);
> +	dio_append(FILENAME, 'a', STARTING_CHARS, 1);
>   
> -	for (i = 0; i < num_children; i++) {
> -		kill(pid[i], SIGTERM);
> +	/* Truncate to a bigger file and check if it's filled with empty chars */
> +	tst_res(TINFO, "Truncate to %ld", FILESIZE);
> +	TST_EXP_POSITIVE(truncate(FILENAME, FILESIZE), "truncate(%s, %lu)", FILENAME, FILESIZE);
> +	if (!TST_PASS)
> +		return;
> +
> +	TEST(getsize(FILENAME));
> +
> +	if (TST_RET == FILESIZE) {
> +		tst_res(TPASS, "Truncated file has %ld length", TST_RET);
> +
> +		charnum = dio_get_zeros(FILENAME, FILESIZE);
> +
> +		if (charnum == empty_ch)
> +			tst_res(TPASS, "Truncated file provides %ld empty chars at the end", empty_ch);
> +		else
> +			tst_res(TFAIL, "Truncated file isn't filled with %i chars", charnum);
> +	} else {
> +		tst_res(TFAIL, "Truncated file doesn't have %ld length but %ld", FILESIZE, TST_RET);
>   	}
>   
> -	return 0;
> +	/* Truncate to zero: file must be empty */
> +	tst_res(TINFO, "Truncate to zero");
> +	TST_EXP_POSITIVE(truncate(FILENAME, 0), "truncate(%s, 0)", FILENAME);
> +	if (!TST_PASS)
> +		return;
> +
> +	TEST(getsize(FILENAME));
> +	if (TST_RET == 0)
> +		tst_res(TPASS, "Truncated file has zero length");
> +	else
> +		tst_res(TFAIL, "Truncated file doesn't have zero length");
>   }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +};
--------------fUdHjCou5fPNmGQ6PCVoK5vI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi all,</font></p>
    <p><font size="4">please ignore this patch since it has been sent by
        accident: it's the v1. I sent the correct v2 patch in the next
        email.<br>
      </font></p>
    <p><font size="4">Andrea<br>
      </font></p>
    <div class="moz-cite-prefix">On 11/15/21 14:34, Andrea Cervesato
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211115133412.25194-1-acervesato@suse.de">
      <pre class="moz-quote-pre" wrap="">From: Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>

---
 testcases/kernel/io/ltp-aiodio/dio_truncate.c | 206 +++++++-----------
 1 file changed, 79 insertions(+), 127 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 27cf01525..9c8da539e 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -1,7 +1,7 @@
-
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2004 Daniel McNeil <a class="moz-txt-link-rfc2396E" href="mailto:daniel@osdl.org">&lt;daniel@osdl.org&gt;</a>
- *               2004 Open Source Development Lab
+ * Copyright (c) 2021 Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>
+ *			   2021 SUSE Enterprise Linux
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -19,159 +19,111 @@
  * Module: .c
  */
 
-/*
- * Change History:
- *
- * 2/2004  Marty Ridgeway (<a class="moz-txt-link-abbreviated" href="mailto:mridge@us.ibm.com">mridge@us.ibm.com</a>) Changes to adapt to LTP
- *
- */
 #define _GNU_SOURCE
 
 #include &lt;stdlib.h&gt;
+#include &lt;stdio.h&gt;
+#include &lt;sys/stat.h&gt;
 #include &lt;sys/types.h&gt;
-#include &lt;signal.h&gt;
-#include &lt;errno.h&gt;
 #include &lt;fcntl.h&gt;
-#include &lt;stdio.h&gt;
-#include &lt;unistd.h&gt;
-#include &lt;memory.h&gt;
-#include &lt;string.h&gt;
-#include &lt;limits.h&gt;
-
-#include &quot;test.h&quot;
+#include &quot;tst_test.h&quot;
 
-#define NUM_CHILDREN 8
+static char *FILENAME = &quot;file.bin&quot;;
+static long FILESIZE = 64 * 1024;
+static int STARTING_CHARS = 10;
 
-char *check_zero(unsigned char *buf, int size)
-{
-	unsigned char *p;
-
-	p = buf;
-
-	while (size &gt; 0) {
-		if (*buf != 0) {
-			fprintf(stderr,
-				&quot;non zero buffer at buf[%d] =&gt; 0x%02x,%02x,%02x,%02x\n&quot;,
-				buf - p, (unsigned int)buf[0],
-				size &gt; 1 ? (unsigned int)buf[1] : 0,
-				size &gt; 2 ? (unsigned int)buf[2] : 0,
-				size &gt; 3 ? (unsigned int)buf[3] : 0);
-			fprintf(stderr, &quot;buf %p, p %p\n&quot;, buf, p);
-			return buf;
-		}
-		buf++;
-		size--;
-	}
-	return 0;		/* all zeros */
-}
-
-int dio_read(char *filename)
+int dio_append(const char *path, char pattern, size_t bs, size_t bcount)
 {
 	int fd;
-	int r;
-	void *bufptr = NULL;
 
-	TEST(posix_memalign(&amp;bufptr, 4096, 64 * 1024));
-	if (TEST_RETURN) {
-		tst_resm(TBROK | TRERRNO, &quot;cannot malloc aligned memory&quot;);
+	fd = SAFE_OPEN(path, O_CREAT|O_WRONLY|O_DIRECT, 0666);
+
+	if (tst_fill_fd(fd, pattern, bs, bcount)) {
+		SAFE_CLOSE(fd);
 		return -1;
 	}
 
-	while ((fd = open(filename, O_DIRECT | O_RDONLY)) &lt; 0) {
-	}
-	fprintf(stderr, &quot;dio_truncate: child reading file\n&quot;);
-	while (1) {
-		off_t offset;
-		char *bufoff;
-
-		/* read the file, checking for zeros */
-		offset = lseek(fd, SEEK_SET, 0);
-		do {
-			r = read(fd, bufptr, 64 * 1024);
-			if (r &gt; 0) {
-				if ((bufoff = check_zero(bufptr, r))) {
-					fprintf(stderr,
-						&quot;non-zero read at offset %p\n&quot;,
-						offset + bufoff);
-					exit(1);
-				}
-				offset += r;
-			}
-		} while (r &gt; 0);
-	}
+	SAFE_CLOSE(fd);
+
 	return 0;
 }
 
-void dio_append(char *filename, int fill)
+int dio_get_zeros(const char *path, size_t bs)
 {
-	int fd;
+	int i = 0;
+	int fd = 0;
+	int zeros = 0;
 	void *bufptr = NULL;
-	int i;
-	int w;
 
-	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
+	fd = SAFE_OPEN(path, O_RDONLY|O_DIRECT, 0666);
 
-	if (fd &lt; 0) {
-		perror(&quot;cannot create file&quot;);
-		return;
-	}
+	bufptr = SAFE_MALLOC(bs * sizeof(void));
+	SAFE_READ(0, fd, bufptr, bs);
 
-	TEST(posix_memalign(&amp;bufptr, 4096, 64 * 1024));
-	if (TEST_RETURN) {
-		tst_resm(TBROK | TRERRNO, &quot;cannot malloc aligned memory&quot;);
-		close(fd);
-		return;
+	for (i = 0; i &lt; (int)bs; i++) {
+		if (*(char *)bufptr == 0)
+			zeros++;
+		bufptr++;
 	}
 
-	memset(bufptr, fill, 64 * 1024);
+	SAFE_CLOSE(fd);
 
-	for (i = 0; i &lt; 1000; i++) {
-		if ((w = write(fd, bufptr, 64 * 1024)) != 64 * 1024) {
-			fprintf(stderr, &quot;write %d returned %d\n&quot;, i, w);
-		}
-	}
-	close(fd);
+	return zeros;
 }
 
-int main(void)
+off_t getsize(const char *filename)
 {
-	char filename[PATH_MAX];
-	int pid[NUM_CHILDREN];
-	int num_children = 1;
-	int i;
-
-	snprintf(filename, sizeof(filename), &quot;%s/aiodio/file&quot;,
-		 getenv(&quot;TMP&quot;) ? getenv(&quot;TMP&quot;) : &quot;/tmp&quot;);
-
-	for (i = 0; i &lt; num_children; i++) {
-		if ((pid[i] = fork()) == 0) {
-			/* child */
-			return dio_read(filename);
-		} else if (pid[i] &lt; 0) {
-			/* error */
-			perror(&quot;fork error&quot;);
-			break;
-		} else {
-			/* Parent */
-			continue;
-		}
-	}
+	struct stat st;
 
-	/*
-	 * Parent creates a zero file using DIO.
-	 * Truncates it to zero
-	 * Create another file with '0xaa'
-	 */
-	for (i = 0; i &lt; 100; i++) {
-		dio_append(filename, 0);
-		truncate(filename, 0);
-		dio_append(&quot;junkfile&quot;, 0xaa);
-		truncate(&quot;junkfile&quot;, 0);
-	}
+	if (SAFE_STAT(filename, &amp;st) == 0)
+		return st.st_size;
+
+	return -1;
+}
+
+static void run(void)
+{
+	int charnum = 0;
+	long empty_ch = FILESIZE - STARTING_CHARS;
+
+	tst_res(TINFO, &quot;Create %s filled with %d chars&quot;, FILENAME, STARTING_CHARS);
+	dio_append(FILENAME, 'a', STARTING_CHARS, 1);
 
-	for (i = 0; i &lt; num_children; i++) {
-		kill(pid[i], SIGTERM);
+	/* Truncate to a bigger file and check if it's filled with empty chars */
+	tst_res(TINFO, &quot;Truncate to %ld&quot;, FILESIZE);
+	TST_EXP_POSITIVE(truncate(FILENAME, FILESIZE), &quot;truncate(%s, %lu)&quot;, FILENAME, FILESIZE);
+	if (!TST_PASS)
+		return;
+
+	TEST(getsize(FILENAME));
+
+	if (TST_RET == FILESIZE) {
+		tst_res(TPASS, &quot;Truncated file has %ld length&quot;, TST_RET);
+
+		charnum = dio_get_zeros(FILENAME, FILESIZE);
+
+		if (charnum == empty_ch)
+			tst_res(TPASS, &quot;Truncated file provides %ld empty chars at the end&quot;, empty_ch);
+		else
+			tst_res(TFAIL, &quot;Truncated file isn't filled with %i chars&quot;, charnum);
+	} else {
+		tst_res(TFAIL, &quot;Truncated file doesn't have %ld length but %ld&quot;, FILESIZE, TST_RET);
 	}
 
-	return 0;
+	/* Truncate to zero: file must be empty */
+	tst_res(TINFO, &quot;Truncate to zero&quot;);
+	TST_EXP_POSITIVE(truncate(FILENAME, 0), &quot;truncate(%s, 0)&quot;, FILENAME);
+	if (!TST_PASS)
+		return;
+
+	TEST(getsize(FILENAME));
+	if (TST_RET == 0)
+		tst_res(TPASS, &quot;Truncated file has zero length&quot;);
+	else
+		tst_res(TFAIL, &quot;Truncated file doesn't have zero length&quot;);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = run,
+};
</pre>
    </blockquote>
  </body>
</html>
--------------fUdHjCou5fPNmGQ6PCVoK5vI--


--===============0603874770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0603874770==--

