Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B304C433FE
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 14:46:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41DAB3C9506
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 15:46:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFD7F3C06D2
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:45:54 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A30571000672
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:45:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1642171552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2x+4+sT86zKFrOet50pDAhwhV0HZHq6O3HG2w5g+/hs=;
 b=fRwH2sDs6ESYallywR0ZkY3JZQv24PjjfZfobAY/6DeeIESmWZlUO7TJdnw0RSw/lKT+UN
 sZPYFGNqZgNmLtmnn94FxhgC9mnaqsvRlPPZRjVggcR9DV0kDe5NsOjEiwEOapNqrxd+r2
 RsskN6v8eQNVohspxuZmXzh5vl9mrzU=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-3spdyLJzNBqHGDsADmyktQ-1; Fri, 14 Jan 2022 15:45:51 +0100
X-MC-Unique: 3spdyLJzNBqHGDsADmyktQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6SQcIjRaj/392TMUq42VmGk4jktBPaosepip1dYAEHM4WnZHArvj297uYaprp2sKlh8Ur7tdw2vqqvkNUj0VcGRUriThvmj2UsqdjM8tuO/pa6/7++34OLzx6SBMemupLqUVRnkmJ3sxBzgant201d6MQiXX2PMsS9gK/rtCGVnXaX/1YmXlEF/xPjj6jmvI7oYe3DwKTKA4Z17QPh8YaGRs7Z7DRhdKB/AsCTiNrOJbxYLB+J84FB4mO5m9fSM1qHcXQ1oDsaWlw/CzFcNywRQwKtITkEYZeig81o9WsZrOf7coItC+hifD/Td599uh/3TdN5r/95YrbgC2hxdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x+4+sT86zKFrOet50pDAhwhV0HZHq6O3HG2w5g+/hs=;
 b=adYZbStHcfgaH7RXYX5wqIJ0I4kugKItMwmZpFvUHWbVZ0twGEUNiWHOKcrcumPjmN4CoxDgQNGdaYbs9MtjtKarI78KlAn7JXEkcXZZxucf68vF8FsC29J4g9YGWULwqcBVJ0ukPfxSGKHsL5krraM9rp9hfOLt+Rl/OMPEl1sTrRfjqI/mPOVEgOXqNswB5DJpQO6BCWfpf6Om/0K05AvDCkruBt+qih9jrUATiV8ScbgmuHqRvPSKtYCJ2Qs97I3oP2AbzKjzVxTg2srmr23bSedx7p0uw9dV9vOAIOT+amaZTNB3kX+DU3CRyidI9aQI5c6vv8s8GZlFdoekSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VI1PR04MB4494.eurprd04.prod.outlook.com (2603:10a6:803:74::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 14 Jan
 2022 14:45:49 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::5881:fa38:8459:b97d]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::5881:fa38:8459:b97d%3]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 14:45:49 +0000
Message-ID: <6f0f1b9c-666f-a782-c7ca-7608724f17a0@suse.com>
Date: Fri, 14 Jan 2022 15:45:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: ltp@lists.linux.it
References: <20220114142527.2759-1-andrea.cervesato@suse.de>
In-Reply-To: <20220114142527.2759-1-andrea.cervesato@suse.de>
X-ClientProxiedBy: AM5PR1001CA0032.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::45) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76540aac-10e0-4685-0830-08d9d76c8df7
X-MS-TrafficTypeDiagnostic: VI1PR04MB4494:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB44947CF4B41C974635937E23F8549@VI1PR04MB4494.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATbls9ZykM98Ve/2JRAKMOZP7GLTW8GwAdgtoGLZDAc01JHGIj3rDKWsgAfd581Ntt3IVK5BCvB4nlZww3uZGj/kJZ3w3kCbZVIkvNBOxOJ/gx7b/D1U2Szk8MEMD+YfGIdrc7TXrMmlXBPA2me8FevVY++ZIBop7e+vPXJErxOSyjJb9NUxQVrWO0Ac6oEA4Zt9+raVOlV6PspR8cEoWmDQ79z7sVEIlNzzjaHxd9+L8vo1bxH5VStbwQI3lhMqhVlVkZXfvH23bcKBvPlxlBjNlmMOs8oq9mkhEUBOjErc4YZ8SF6j2ntDPggaCJSNTTuKnXV+QlMPnUcETWyxmEKrMAy95OIrohPpsaTRCqwAqQfttZOBTjkwjVIZF8qjGO+usD/QswAxp2JvGKumGcNg3bZbXN6AUk/RHzOxcztzPkPmvhu9TXlR+7PkDkjprWlGAaJEgsjrjQnib+74gzgSnkuBQcpJcx25x0tLsVGpPZPVHo2n0yuY0s/zCZOxe4lANbaBz8wa6X0KgF6sS6x+XuI+YidJMGAIO78dnf39larDGexnI7YUm2nAPYUAaouGOQxdOCmI/T/l9cLQGqzyHcMpTeYXZJdh7m/G4KOnzxuoWpPU+S2XsQ/HxNa7BXp4sHAZiqJTu1jJOMdjYAcmntGwUwjxxLziYeOF3hzN/yalxJ9BCG7BRfgYMul+h6LCqQJQj4e9FcBbzpK9P84o1T0rxEYWf6tfBfIZltI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6512007)(2906002)(86362001)(33964004)(26005)(36756003)(2616005)(6666004)(8936002)(316002)(8676002)(44832011)(30864003)(5660300002)(6916009)(66946007)(66476007)(38100700002)(186003)(6506007)(508600001)(53546011)(66556008)(31686004)(83380400001)(6486002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEVFV2l0Q2dQLzBSWHZoeklyNFgwWGhkSGlSTGwwWE5iOWlENUladmlTUll3?=
 =?utf-8?B?QlJVdmZUcTZSSGNQMkREK0ZtLzdVMHBRUkZObTFmWXpTUmNaY0lXak5wWkRK?=
 =?utf-8?B?Q2NEYWJjRzF0TlI5S3lJSkI2Q0RIdy9JTWtVU0ZUSEVKTmlMMzVVeXVIV3g0?=
 =?utf-8?B?VFphM0VmWDBneUppWlBlQkxVMml0SUprRnlQMGxSSDJ1enVvb25aOGt3empK?=
 =?utf-8?B?NStFV0t6SWZzQTFmVlJlTTJidVhYd2JYbC9yVXo2L1MwMFk3ZUdDd1F1WHFr?=
 =?utf-8?B?ellMRnB1Q29tdm1Tb0Y0MGFkNjNmRnVPMm5kZS9tYWNJUTBpYVlxWU1NMkYz?=
 =?utf-8?B?ZHYzWUdjMXBBamFDZi9aR3l3ejRHak1OdDdVZldYd3llWnliQ1EyZ0lBM3hh?=
 =?utf-8?B?U3NnZ0t5b285ZS9BRW8wWUFtR1BwSERIYkZmbEpHVUhjbVIvUzV4WWlzMFJv?=
 =?utf-8?B?YXkwaDFzOUZ2eXd0ZjdSaUJMclB4amszK3lPOFhVMDR2REMvOFM4RWRtYnJi?=
 =?utf-8?B?aEtTVUZJcEQyS3B1Tk1iWlQvdXVqK0RqSitxcG1WMWM4alBVUzB1MW5ZQTgv?=
 =?utf-8?B?V1hoTjNiZzJYOGg0NDFxSVkrNysrM01nOEg5MFdVQi9BcURoZUtZRUYzY25u?=
 =?utf-8?B?R2IxV28rZEdGNmxaUitEUjU2eElFRjJyb21FLzVOY1A2aVc3NVdjeWY4cjk0?=
 =?utf-8?B?bndvb3dlb3RKdzl6c0JXTzRNS09zc3JTQXJCOHlsNzBwM2h3RjlqaUdidTAw?=
 =?utf-8?B?M01RVGhqUm41SW0zNWp2dWN5U2w3dWJuTks5T1h2bG1Ja3E2cWdzNkhPRGJU?=
 =?utf-8?B?UGl3ZnpqcEVUVzF0M2JnaXlZVVFQMVd6SkttbHFBL0F3MUgrMUtUUWxTL3Bi?=
 =?utf-8?B?aCtCL0Fnclc2MnFqbWprUXVBZ1U2ZUxzL2h1aTZrL3FUamJrSnN3Lyt4NStO?=
 =?utf-8?B?WjlVdk9HQVdDYTJoMUQrbmpDUDhtUDZWSW43T0dNK2NIK3J4a1FBK2s5NFV4?=
 =?utf-8?B?aTUvTm1qNGoxdHE4QW5nVEpzUlhCcURSdyt5OGlYSkc5VnVkY2J0ZFhEN0t2?=
 =?utf-8?B?elhFay92eVJ6NVZTbUJmVFJlV3plR29nVzJnTDZTczArTXRxdTE0VGFseStJ?=
 =?utf-8?B?blpTZ3c4QjhUZ2REK3U1RkJPL0o1M3VoYXJZS25pQU11SWgxaVduSU9HYStv?=
 =?utf-8?B?Ry9aMGRpTkVFak5qcHZ6Nml4NkdGUGNCdEpLdjNWeC94ZURiYjBxdEdKL2Y5?=
 =?utf-8?B?MDZrR1pCVEZFOWN1aWFiWUZXT2hqSGVnYldxcFMwMHA4dUNQcWtGWVJKNjZi?=
 =?utf-8?B?RUgxWEZlTDN3VUh4ajdFV2hLbHdVYzdnQXhKaUkyV29uQ0hEY0dHaERCTGFi?=
 =?utf-8?B?b3dYbmp5MzZMNEtIYXlkR1FKL2ltQ3BJS1VndTlpOTA3RGdTbnliTWxOQVpK?=
 =?utf-8?B?ODgzTC9ic1lIQUQ1REd2YjBhVjRGQTdnYkJ3RzVoanZ6T0JmaWhEdkp2MC93?=
 =?utf-8?B?emdXYVV3SlJvL2RvejN3L3RJNk5hMWgvdVNLWFVEUDRVQ212Uzc0blhEcFJI?=
 =?utf-8?B?b0xyUFYxMTdxRE1OaFVZSjZ1MzU5Vnh4L2h6bHZ0djFzMW9CRWJLME9QRTdJ?=
 =?utf-8?B?bFcrOHhLQTVRZUNuZStTVlU0UmxHbURMOWpIQ0hqSWlXalU2eGw4QjRmSUtF?=
 =?utf-8?B?NjdmbktBR09hZE5zN3cyWVZjTXVvYXc0RXBBZXNwemFta0M4ajl2R2JCM05z?=
 =?utf-8?B?TDFiL25TVzc5UkRYQXpNUFNQRlB2NVBFRFFZYVNhZ0N6NXUzUjJidENyNWZh?=
 =?utf-8?B?ekUwZnNCUW15UUlDaEdGaEF3M2Z3ZVRpME1RNFRpWUVIbmdGRkdTcWF4QjE2?=
 =?utf-8?B?eUQ2ZjFRSXBLR3JmSmd3Mm04YXdlL2xrSW9OdUZRL0Y4MnFBWEJPMS9ZWHI2?=
 =?utf-8?B?OHYzUkhxSHV2T1VTeklFeitON013NVl1TUVnZ3dZQVlhZVNsckVoUWZnQlZh?=
 =?utf-8?B?dUR0RTJkcTZuK1h2MHYxS2Q3bkp5ck1ZcEdnQURldHZSVU84VCs4S2VBTDRj?=
 =?utf-8?B?QWxjNHUzVUhrYnBNa25hb25Dak5TeXVhdkRjN0lkN3VNL0ZBNDIwVUQrZTJh?=
 =?utf-8?B?VEJ4SitaU094N3BCbUY0NGt4V0tSMVpUMm1zeXJTV0tYanhQd2NHSFdtZGt5?=
 =?utf-8?B?R2c1MVAxNjRqaW5NK0c0NXBucDd3LytzcFhEM0pDSlpoK0J6cHRJZTBQZVJT?=
 =?utf-8?B?VW8xdWhFVkd6aXpnVWNsWmVUUEFRPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76540aac-10e0-4685-0830-08d9d76c8df7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 14:45:49.1146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50+XEzAt3qirkndli63lEzmbFWXf7ao5Uw/7BwvIrsGbIYEg5i4h1mCYPkTZBRiJY42Wk/1NWgG1x/kpXDWrBm9hdFIbGHx45+4pM4VCZhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4494
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add tst_dev_block_size utility
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
Content-Type: multipart/mixed; boundary="===============0141589117=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0141589117==
Content-Type: multipart/alternative;
 boundary="------------Za3tWcLPT3q7pAXOpXy9FJwV"
Content-Language: en-US

--------------Za3tWcLPT3q7pAXOpXy9FJwV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi! Please ignore this implementation, since it's not using fallback 
lapi/loop.h and it causes build issues with kernel < 4.13

On 1/14/22 15:25, Andrea Cervesato wrote:
> Added tst_dev_block_size function in tst_device.c and updated
> c-test-api.txt documentation.
>
> Signed-off-by: Andrea Cervesato<andrea.cervesato@suse.de>
> ---
>   doc/c-test-api.txt            | 11 ++++
>   include/tst_device.h          |  7 +++
>   lib/newlib_tests/tst_device.c | 95 +++++++++++++++++++++++++++--------
>   lib/tst_device.c              | 15 ++++++
>   4 files changed, 108 insertions(+), 20 deletions(-)
>
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 123d3f1fc..0cb391a0a 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -1034,6 +1034,17 @@ uint64_t tst_get_device_size(const char *dev_path);
>   This function gets size of the given block device, it checks the 'dev_path' is
>   valid first, if yes, return the size in MB, otherwise return -1.
>   
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +int tst_dev_block_size(const char *path);
> +-------------------------------------------------------------------------------
> +
> +This function returns the size of a single IO block for the specific `path`.
> +It finds the device where `path` is located and then uses `ioctl` to get a
> +single device block size.
> +
>   1.16 Formatting a device with a filesystem
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
> diff --git a/include/tst_device.h b/include/tst_device.h
> index 72c560c02..bf0fb5320 100644
> --- a/include/tst_device.h
> +++ b/include/tst_device.h
> @@ -112,4 +112,11 @@ void tst_purge_dir(const char *path);
>    */
>   void tst_find_backing_dev(const char *path, char *dev);
>   
> +/*
> + * Returns the size of a single IO block for the specific path
> + * @path   Path to find the block size
> + * @return Size of the block size
> + */
> +int tst_dev_block_size(const char *path);
> +
>   #endif	/* TST_DEVICE_H__ */
> diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
> index 0bee0a939..1f754e63d 100644
> --- a/lib/newlib_tests/tst_device.c
> +++ b/lib/newlib_tests/tst_device.c
> @@ -1,47 +1,102 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2016 Linux Test Project
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato<andrea.cervesato@suse.com>
>    */
> +#define _GNU_SOURCE
>   
>   #include <stdlib.h>
>   #include <sys/mount.h>
>   #include <stdint.h>
> +#include <stdio.h>
> +#include <linux/loop.h>
> +#include <time.h>
>   
>   #include "tst_test.h"
>   
> -static void do_test(void)
> +#define PAGESIZE 2048
> +#define DEV_MIN_SIZE 300
> +
> +static char *mntpoint;
> +static uint64_t ltp_dev_size;
> +
> +static void setup(void)
>   {
>   	int fd;
> -	const char *dev;
> -	char block_dev[100];
> -	uint64_t ltp_dev_size;
> +	int ret;
>   
> -	dev = tst_device->dev;
> -	if (!dev)
> -		tst_brk(TCONF, "Failed to acquire test device");
> +	ret = asprintf(&mntpoint, "%s/mnt", tst_get_tmpdir());
> +	if (ret < 0)
> +		tst_brk(TBROK, "asprintf failure");
>   
> -	SAFE_MKFS(dev, "ext2", NULL, NULL);
> +	while ((fd = SAFE_OPEN(tst_device->dev, O_RDONLY, 0666)) < 0)
> +		usleep(100);
>   
> -	fd = SAFE_OPEN(dev, O_RDONLY);
>   	SAFE_IOCTL(fd, BLKGETSIZE64, &ltp_dev_size);
> +	SAFE_IOCTL(fd, LOOP_SET_BLOCK_SIZE, PAGESIZE);
>   	SAFE_CLOSE(fd);
>   
> -	if (ltp_dev_size/1024/1024 == 300)
> -		tst_res(TPASS, "Got expected device size");
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
> +
> +	SAFE_MKDIR(mntpoint, 0777);
> +	SAFE_MOUNT(tst_device->dev, mntpoint, tst_device->fs_type, 0, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (tst_is_mounted(mntpoint))
> +		SAFE_UMOUNT(mntpoint);
> +}
> +
> +static void test_dev_min_size(void)
> +{
> +	uint64_t size;
> +
> +	size = ltp_dev_size / 1024 / 1024;
> +
> +	if (size == DEV_MIN_SIZE)
> +		tst_res(TPASS, "Got expected device size %lu", size);
> +	else
> +		tst_res(TFAIL, "Expected device size is %d but got %lu", DEV_MIN_SIZE, size);
> +}
> +
> +static void test_tst_find_backing_dev(void)
> +{
> +	char block_dev[100];
> +
> +	tst_find_backing_dev(mntpoint, block_dev);
> +
> +	if (!strcmp(tst_device->dev, block_dev))
> +		tst_res(TPASS, "%s belongs to %s block dev", mntpoint, block_dev);
>   	else
> -		tst_res(TFAIL, "Got unexpected device size");
> -
> -	tst_find_backing_dev("/boot", block_dev);
> -	tst_res(TPASS, "/boot belongs to %s block dev", block_dev);
> -	tst_find_backing_dev("/", block_dev);
> -	tst_res(TPASS, "/ belongs to %s block dev", block_dev);
> -	tst_find_backing_dev("/tmp", block_dev);
> -	tst_find_backing_dev("/boot/xuyang", block_dev);
> +		tst_res(TFAIL, "%s should belong to %s, but %s is returned", mntpoint, tst_device->dev, block_dev);
> +}
> +
> +static void test_tst_dev_block_size(void)
> +{
> +	int block_size;
> +
> +	block_size = tst_dev_block_size(mntpoint);
> +
> +	if (block_size == PAGESIZE)
> +		tst_res(TPASS, "%s has %d block size", mntpoint, block_size);
> +	else
> +		tst_res(TFAIL, "%s has %d block size, but expected is %i", mntpoint, block_size, PAGESIZE);
> +}
> +
> +static void do_test(void)
> +{
> +	test_dev_min_size();
> +	test_tst_find_backing_dev();
> +	test_tst_dev_block_size();
>   }
>   
>   static struct tst_test test = {
>   	.needs_root = 1,
>   	.needs_device = 1,
> -	.dev_min_size = 300,
> +	.needs_tmpdir = 1,
> +	.dev_min_size = DEV_MIN_SIZE,
>   	.test_all = do_test,
> +	.setup = setup,
> +	.cleanup = cleanup,
>   };
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 73e70d26e..1ef667fa0 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -547,3 +547,18 @@ void tst_find_backing_dev(const char *path, char *dev)
>   	if (S_ISBLK(buf.st_mode) != 1)
>   		tst_brkm(TCONF, NULL, "dev(%s) isn't a block dev", dev);
>   }
> +
> +int tst_dev_block_size(const char *path)
> +{
> +	int fd;
> +	int size;
> +	char dev_name[1024];
> +
> +	tst_find_backing_dev(path, dev_name);
> +
> +	fd = SAFE_OPEN(NULL, dev_name, O_RDONLY);
> +	SAFE_IOCTL(NULL, fd, BLKSSZGET, &size);
> +	SAFE_CLOSE(NULL, fd);
> +
> +	return size;
> +}
--------------Za3tWcLPT3q7pAXOpXy9FJwV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi! Please ignore this implementation, since it's
        not using fallback lapi/loop.h and it causes build issues with
        kernel &lt; 4.13</font><br>
    </p>
    <div class="moz-cite-prefix">On 1/14/22 15:25, Andrea Cervesato
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220114142527.2759-1-andrea.cervesato@suse.de">
      <pre class="moz-quote-pre" wrap="">Added tst_dev_block_size function in tst_device.c and updated
c-test-api.txt documentation.

Signed-off-by: Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.de">&lt;andrea.cervesato@suse.de&gt;</a>
---
 doc/c-test-api.txt            | 11 ++++
 include/tst_device.h          |  7 +++
 lib/newlib_tests/tst_device.c | 95 +++++++++++++++++++++++++++--------
 lib/tst_device.c              | 15 ++++++
 4 files changed, 108 insertions(+), 20 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 123d3f1fc..0cb391a0a 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -1034,6 +1034,17 @@ uint64_t tst_get_device_size(const char *dev_path);
 This function gets size of the given block device, it checks the 'dev_path' is
 valid first, if yes, return the size in MB, otherwise return -1.
 
+[source,c]
+-------------------------------------------------------------------------------
+#include &quot;tst_test.h&quot;
+
+int tst_dev_block_size(const char *path);
+-------------------------------------------------------------------------------
+
+This function returns the size of a single IO block for the specific `path`.
+It finds the device where `path` is located and then uses `ioctl` to get a
+single device block size.
+
 1.16 Formatting a device with a filesystem
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/tst_device.h b/include/tst_device.h
index 72c560c02..bf0fb5320 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -112,4 +112,11 @@ void tst_purge_dir(const char *path);
  */
 void tst_find_backing_dev(const char *path, char *dev);
 
+/*
+ * Returns the size of a single IO block for the specific path
+ * @path   Path to find the block size
+ * @return Size of the block size
+ */
+int tst_dev_block_size(const char *path);
+
 #endif	/* TST_DEVICE_H__ */
diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
index 0bee0a939..1f754e63d 100644
--- a/lib/newlib_tests/tst_device.c
+++ b/lib/newlib_tests/tst_device.c
@@ -1,47 +1,102 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>
  */
+#define _GNU_SOURCE
 
 #include &lt;stdlib.h&gt;
 #include &lt;sys/mount.h&gt;
 #include &lt;stdint.h&gt;
+#include &lt;stdio.h&gt;
+#include &lt;linux/loop.h&gt;
+#include &lt;time.h&gt;
 
 #include &quot;tst_test.h&quot;
 
-static void do_test(void)
+#define PAGESIZE 2048
+#define DEV_MIN_SIZE 300
+
+static char *mntpoint;
+static uint64_t ltp_dev_size;
+
+static void setup(void)
 {
 	int fd;
-	const char *dev;
-	char block_dev[100];
-	uint64_t ltp_dev_size;
+	int ret;
 
-	dev = tst_device-&gt;dev;
-	if (!dev)
-		tst_brk(TCONF, &quot;Failed to acquire test device&quot;);
+	ret = asprintf(&amp;mntpoint, &quot;%s/mnt&quot;, tst_get_tmpdir());
+	if (ret &lt; 0)
+		tst_brk(TBROK, &quot;asprintf failure&quot;);
 
-	SAFE_MKFS(dev, &quot;ext2&quot;, NULL, NULL);
+	while ((fd = SAFE_OPEN(tst_device-&gt;dev, O_RDONLY, 0666)) &lt; 0)
+		usleep(100);
 
-	fd = SAFE_OPEN(dev, O_RDONLY);
 	SAFE_IOCTL(fd, BLKGETSIZE64, &amp;ltp_dev_size);
+	SAFE_IOCTL(fd, LOOP_SET_BLOCK_SIZE, PAGESIZE);
 	SAFE_CLOSE(fd);
 
-	if (ltp_dev_size/1024/1024 == 300)
-		tst_res(TPASS, &quot;Got expected device size&quot;);
+	SAFE_MKFS(tst_device-&gt;dev, tst_device-&gt;fs_type, NULL, NULL);
+
+	SAFE_MKDIR(mntpoint, 0777);
+	SAFE_MOUNT(tst_device-&gt;dev, mntpoint, tst_device-&gt;fs_type, 0, 0);
+}
+
+static void cleanup(void)
+{
+	if (tst_is_mounted(mntpoint))
+		SAFE_UMOUNT(mntpoint);
+}
+
+static void test_dev_min_size(void)
+{
+	uint64_t size;
+
+	size = ltp_dev_size / 1024 / 1024;
+
+	if (size == DEV_MIN_SIZE)
+		tst_res(TPASS, &quot;Got expected device size %lu&quot;, size);
+	else
+		tst_res(TFAIL, &quot;Expected device size is %d but got %lu&quot;, DEV_MIN_SIZE, size);
+}
+
+static void test_tst_find_backing_dev(void)
+{
+	char block_dev[100];
+
+	tst_find_backing_dev(mntpoint, block_dev);
+
+	if (!strcmp(tst_device-&gt;dev, block_dev))
+		tst_res(TPASS, &quot;%s belongs to %s block dev&quot;, mntpoint, block_dev);
 	else
-		tst_res(TFAIL, &quot;Got unexpected device size&quot;);
-
-	tst_find_backing_dev(&quot;/boot&quot;, block_dev);
-	tst_res(TPASS, &quot;/boot belongs to %s block dev&quot;, block_dev);
-	tst_find_backing_dev(&quot;/&quot;, block_dev);
-	tst_res(TPASS, &quot;/ belongs to %s block dev&quot;, block_dev);
-	tst_find_backing_dev(&quot;/tmp&quot;, block_dev);
-	tst_find_backing_dev(&quot;/boot/xuyang&quot;, block_dev);
+		tst_res(TFAIL, &quot;%s should belong to %s, but %s is returned&quot;, mntpoint, tst_device-&gt;dev, block_dev);
+}
+
+static void test_tst_dev_block_size(void)
+{
+	int block_size;
+
+	block_size = tst_dev_block_size(mntpoint);
+
+	if (block_size == PAGESIZE)
+		tst_res(TPASS, &quot;%s has %d block size&quot;, mntpoint, block_size);
+	else
+		tst_res(TFAIL, &quot;%s has %d block size, but expected is %i&quot;, mntpoint, block_size, PAGESIZE);
+}
+
+static void do_test(void)
+{
+	test_dev_min_size();
+	test_tst_find_backing_dev();
+	test_tst_dev_block_size();
 }
 
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_device = 1,
-	.dev_min_size = 300,
+	.needs_tmpdir = 1,
+	.dev_min_size = DEV_MIN_SIZE,
 	.test_all = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
 };
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 73e70d26e..1ef667fa0 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -547,3 +547,18 @@ void tst_find_backing_dev(const char *path, char *dev)
 	if (S_ISBLK(buf.st_mode) != 1)
 		tst_brkm(TCONF, NULL, &quot;dev(%s) isn't a block dev&quot;, dev);
 }
+
+int tst_dev_block_size(const char *path)
+{
+	int fd;
+	int size;
+	char dev_name[1024];
+
+	tst_find_backing_dev(path, dev_name);
+
+	fd = SAFE_OPEN(NULL, dev_name, O_RDONLY);
+	SAFE_IOCTL(NULL, fd, BLKSSZGET, &amp;size);
+	SAFE_CLOSE(NULL, fd);
+
+	return size;
+}
</pre>
    </blockquote>
  </body>
</html>

--------------Za3tWcLPT3q7pAXOpXy9FJwV--


--===============0141589117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0141589117==--

