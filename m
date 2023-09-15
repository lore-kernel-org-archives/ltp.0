Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0847EEE6457
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 14:10:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 606163CE680
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 16:10:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35EC93CB154
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 16:10:17 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C122714098AA
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 16:10:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yziv1iQmabS6F5wwZP1SMQXc6UrI++kFwWudMAxsrLjEmTEan53wu7Vmuc7DpEWPHDwyYvCL5bxepzAjVVcDQba9JWd6ZjPRattAKPoKLv+xEdw/ssLYxCgK3si/r5M44MNommQVWcSj3pWuGbFvkGyh/LyZZ8qazlqB0qQAIQigA8ARZ/h1qAm7j/bPWLPT3PM2d2DZmOC/QZg9K3xjydKxvBIePL97WPnv0wGWl9KoU2Wyy00jq7QOELi62fDBveTroJmeTmJ6udPRaufFMZp7cIHV+rS62cOaZl8pQZFMkEJ4GsWu48t8N8QBIm7NaAZSUpV+1IYYcFgOxMIZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=353vORfaluqDi8uNPPMHHhL+io1oq3IN7PjXIvEXlf4=;
 b=egk6tNH9vdmwNA95RPoXQ56Rh8ypb9dMuxiR/3cFZGP76eA36uuHXDyIVzoHdmy7xNEXSjS7hFATdb1SK+pEJL4RJfpTWyreozJp76Df3z7/5kdSzzR3KM3VJkSrEy1owfXFnMqEW3BSbEUN25EnShG9XAtzDRKLDs/i7p66fhIs3gApeshexcSchdHpuaVrSMpbbX/X2CUDyCU3dBaw677ZEW690Ytz2glXD2YxgiVvdEcSg8RTSPa9VZisj/MEm3gxY6UgXGnfzUzZ/I75iJZIWEF4BJQ5IgDiFErJC/KTvoze70xFkWuoGDtH3eeBIKcT6udRtn8ffug14yKHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=353vORfaluqDi8uNPPMHHhL+io1oq3IN7PjXIvEXlf4=;
 b=HetdfgMkFU/CKmqJgl8vqdhgh7kxwKW4JUB4a38X7EoR+t3885M61n81Nmr+DCGoKJVtziJiCkrkfky9UpVJ63VxdsN2Tf4lnJtRwqfGpNc7ggZVuJzdRzPr8MNByv/MzgbYl5vZGhMvDQTMb/M5dR1tSeU2jBvAHRdGSrZCjcUCsb4nVjsf3xqJoHTI/+2H7jUQXYLSFscjq+hZwwIziAg4MbJRmoqK8uzbMuTCsj1jQManog0zphzTW+VXYHmy/ZD9qNWC4TVfyCZmfBueTjC3/rJTlIg62sxTSvd8fFNllhTUnoY/o1LDMCHuV6hUEwC8SOAHHHvyYioVNZ4G2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM8PR04MB7907.eurprd04.prod.outlook.com (2603:10a6:20b:237::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 14:10:13 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 14:10:13 +0000
Message-ID: <d67de760-ba11-4b28-9959-5ba0ebb1771a@suse.com>
Date: Fri, 15 Sep 2023 16:10:11 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20230915114503.30942-1-mkittler@suse.de>
In-Reply-To: <20230915114503.30942-1-mkittler@suse.de>
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM8PR04MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b28c09-de15-4a45-801f-08dbb5f57aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7vyQ1AZYbBZYY5fAzUezsXGqoMDYFr7MeaN432Fc+HGlb0pYavjHoO2pcu+h7xF9xiyELfPIrptsHUd4RZdhiL3784vbz7yjuJMOhTyjoHiEccADsK415/duVYlNBUY2GRqjYOcjdFSuRDqpYdUemYZF3+0616a1KkheZXG4tkvWjG0Bcw3yUfKAaYzRtY7PgqmrzEZiqupfEiqR/N/zyPVjiB0xw7i7Nq6l0vBAGPLopSfr73vF87L50+3A/GchhYiVRwkF3pwfIn1MLL3Xhnt6/xzobsIYjCVCr8lPfzFUAuv+E5YaJ1rfh2xC2FnoejbGcmSTk7eVcy7PfXrdtVNdqhDixqrooOZs53G2L6OIRYfvGzvYZb2q5OmYottXMH+VNBIfvorI7/dD7FrypF8r3SKgjSzTbpkOrcOuQo9T8hQCUjuaePa8HnEreeE5/R1iLhj+MeV1CLuYSvUwPNahShNnOpvzoJoVK89FK4rS2ycdRqYOJe1XZZgBwGdOhaGFGrjAtjTm3c7hoXIHVjhYvn/qnnH+qXHCzVq9wkKAwDsZvoOCLeB+b3nYxXiZW0T3nurNShqM6fJQkap/ttHWhf92j5KZPC1h6eU/PuCXEg97OZg1qLUyf2OtK8elSyEu+nvTG6KCljT47sA6Bgu2Ta11mLqTbzSOGq8lP4dNthQug1lcTaVsAWA6GCs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(396003)(376002)(39860400002)(186009)(451199024)(1800799009)(44832011)(26005)(41300700001)(6916009)(316002)(66476007)(66946007)(66556008)(2906002)(478600001)(966005)(5660300002)(8936002)(8676002)(31686004)(6486002)(6506007)(53546011)(6512007)(36756003)(2616005)(83380400001)(38100700002)(31696002)(86362001)(2004002)(81973001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckJqM2J3L2J2c0NiSWo4KzdrQlE1Y1VJcFlHdDVCZ0dIb0drNmRNdTBrRmty?=
 =?utf-8?B?WXFpUFJjZWQyMkdrSENJTVloRW1XTXd4Zm12K3BKVEdZQUZuY1ZidldiZDdI?=
 =?utf-8?B?WkRLYU04MTBTZXZvVG1JMVdjNW1Nelp0SVpaTGhPWlIwcEtlTVJPTm00bWZz?=
 =?utf-8?B?c3pQc2ZMOE5VTXU2L2o1aktBcDhuSmk4bkNLTThZcDRRZTJIaTZRbTd4c3dn?=
 =?utf-8?B?clNDbFpudlFSUTdoTlpwQUw1KzhKSEdvRWdROW5WRnkxeFdFelpRNlB5UEVK?=
 =?utf-8?B?SlR6TldkRDd6VWdGUU03N0VOaGZPVm5IcUh0QXJHTXJBSHNYeloyRUNsS0hr?=
 =?utf-8?B?dnkvRVJuNzJubFR2M044M1A1VTJQbVlwdUEya2RGREV0a0VCVnR2UWR2SHBT?=
 =?utf-8?B?VGhycTdPWGNJbkdFZFE2eVAzZjRMeWlHZU9kUkpxTjhkWTlIV010Z1NGdmxY?=
 =?utf-8?B?QUVaNWpyWk05K2RZMTVGV001RnBmUjRHSGgzQU82YlF5ZGRkci9tTzdnbE5m?=
 =?utf-8?B?dTJ3enlXRGRwUmFEVm5VNDlQaXFPY1hWWlp3ZVpadDVncHJPSjZabTNuWFlQ?=
 =?utf-8?B?aHRKTXo1alpyMGNsSE5mU3dxWDBZWFFubmVSVDA5d0wvNzlTSU5KOFNhNlc2?=
 =?utf-8?B?Z29GejRtQUFkQWtTcVVSdEVQWWJ0b3VGWUVqWFM3bjBqZUVyZUUzRjE0TXEw?=
 =?utf-8?B?SWJCK0VGZVNwM3RwL1V3d1lNd2J4TWpwcEloQUZtZ1JEcXlZT1N0Smo1LzJm?=
 =?utf-8?B?K0M0NUlhNExyZkVYRWRhV0Nra3o5eGVvNHU2OWdnR0pNTTRKTjFVL3g0OUtS?=
 =?utf-8?B?MTlUdlJGcEx0Uk5NNjJrNmFLWkdSdkxIeXVYSkJJY1Y4NzFycEE1ODR5a29v?=
 =?utf-8?B?ZHVoNUQ4d1ZMeUpMNmRSQ3dDYmR6ampZUitOY3J2M29mUVorVjdWczN4Smw3?=
 =?utf-8?B?ZU91L2V2cVYrbHI5RnFhdFAwNjJDdkVsY255NmdvYkpEYVYxWk91WlQxQ2Z3?=
 =?utf-8?B?TFpybHZoYnNlSHRDdzc4SDlrQ2JCM28yQVNKbUp2S3lFNysvVzVYM0NzdnJm?=
 =?utf-8?B?RDVQdEgvOWQvZFFIUTZYWlVxTDVrYXVyczNra3QyaDBEb2MrUzR2azFVNnBN?=
 =?utf-8?B?RENmekM1d1UvZ2szNXJVbmtaVU1xTEhnZ1hRMDNWVzJMUm9MaElmM3JLcnNV?=
 =?utf-8?B?TVJ5OGRaMmpyZy9zOXFJbUt4Mm12bXVXVTNlUSs4VUdZcjdlVFpUSGY4Ulkw?=
 =?utf-8?B?VXNKQ2ZTUTQrcW5ONldxRnV1WTNBcEN2M0tUODRVcU5kZTZhVkFOSS9pVnd4?=
 =?utf-8?B?Tkkwc0dWSERQQVlia29XbW1kYmdJb3FUNTRYci9FaDlia0NPUUp6OWdyV2lr?=
 =?utf-8?B?b0hvVDZmTkpZbVlwakx4ZWVlam1Sei9qdU9DZFl6b2lzRWwzak03anhLWEpE?=
 =?utf-8?B?VVpNT1Y0Q0hqWTYzZDJyTnFIcmtkZWw2eWl6VWMrZFUxV3psTjRqVDlqUmE3?=
 =?utf-8?B?UExpVW1NWVpMNkF3TmsvSFA4ejBYQjFCdC9zeW1iUTRKcUNGZHpra1Q5aVFY?=
 =?utf-8?B?OVpHQlNldlNldWlzR1JMOUNkamNsWTYzUXczUTBadEdoSUJqWkpJa3orVFJN?=
 =?utf-8?B?aVpKcnVSYnVSckZhZWMrUzN1SGFseG11WGtHS3VZakdOVDhabzRaSWRQejNT?=
 =?utf-8?B?MUxKVzkzK2srSXB1WjlYSzNKT2VXb3cwc2czdVNMRnNtNG5sc3JsWW9Ld3lI?=
 =?utf-8?B?TStOMkZsbjY1TE9LUUJ0WEU1K01Jckd0OHpTRXBFeHRRdnRtNWwrZGY1V1NX?=
 =?utf-8?B?Z3lzRVBjQldzYUFSVEptNlAraUQ3ekdycXpuNjVqNGZzKzJOSnJVQVFjMkdL?=
 =?utf-8?B?RCtvQlA1Sm13UGhKV0FzZDYzdDdKd0tDVk5hOUNSV0lqcmEzYnBOd1ExdXZN?=
 =?utf-8?B?akFERFZvblppaUQ4b3E2blpyL28rb3JGMHRwVXFiL3NMMEhBbm54VkU3WDk2?=
 =?utf-8?B?MitISktVenJ4MUw4dkF6Q1J5YnBUTWNvTk9MQVVVZlJaRXVSeDEyWjhuVzNv?=
 =?utf-8?B?YlFFWmdvbTRISDJRSFRKNVVieXNMaWFLa2U2dDBwbGNqT0grY3VTZW1HVVRZ?=
 =?utf-8?B?OTdKUU9nS2MxQ3krTzE3UFBjek5DYm1iUkk3b25JUndldXFwdEVCeHpKV040?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b28c09-de15-4a45-801f-08dbb5f57aa6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 14:10:13.3539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwXomKNJJthmsxTE2W+gd0kr+5dc1Qk1BV6+chYVL7NWokUA7xuKGrLq50Nvh8+bSW4W7/Pz8xbprJKuvt2hbbCwu3ZSiCmsIUwU7Sevo6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7907
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Port `getxattr01.c` to new test API
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

Hi Marius!

On 9/15/23 13:45, Marius Kittler wrote:
> * Utilize `all_filesystems = 1`-mechanism to test on various file
>    systems instead of relying on the temporary directory's file system
>    to support xattr (which it probably does not as it is commonly a
>    tmpfs)
> * Improve error handling
> * Simplify code and description
> * Related issue: https://github.com/linux-test-project/ltp/issues/583
>
> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>   .../kernel/syscalls/getxattr/getxattr01.c     | 219 ++++++++----------
>   1 file changed, 94 insertions(+), 125 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c b/testcases/kernel/syscalls/getxattr/getxattr01.c
> index cec802a33..e9d5874d9 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr01.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
> @@ -1,38 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (C) 2011  Red Hat, Inc.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it
> - * is free of the rightful claim of any third person regarding
> - * infringement or the like.  Any license provided herein, whether
> - * implied or otherwise, applies only to this software file.  Patent
> - * licenses, if any, provided herein do not apply to combinations of
> - * this program with other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
> + * Copyright (c) 2023 Marius Kittler <mkittler@suse.de>
>    */
>   
> -/*
> - * Basic tests for getxattr(2) and make sure getxattr(2) handles error
> - * conditions correctly.
> +/*\
> + * [Description]
>    *
> - * There are 4 test cases:
> + * Basic tests for getxattr(2), there are 3 test cases:
>    * 1. Get an non-existing attribute,
> - *    getxattr(2) should return -1 and set errno to ENODATA
> + *    getxattr(2) should return -1 and set errno to ENODATA.
>    * 2. Buffer size is smaller than attribute value size,
> - *    getxattr(2) should return -1 and set errno to ERANGE
> - * 3. Get attribute, getxattr(2) should succeed
> - * 4. Verify the attribute got by getxattr(2) is same as the value we set
> + *    getxattr(2) should return -1 and set errno to ERANGE.
> + * 3. getxattr(2) should succeed and return the same value we set
> + *    before.
You can use '-' instead of numbers here. That will be automatically seen 
as a list by asciidoc.
>    */
>   
>   #include "config.h"
> @@ -47,138 +28,126 @@
We can get rid from most of the includes, since tst_test.h more often 
have them already. I would suggest to remove them all and add only what 
it's needed for compile.
>   #ifdef HAVE_SYS_XATTR_H
>   # include <sys/xattr.h>
>   #endif
> -#include "test.h"
> -#include "safe_macros.h"
>   
> -char *TCID = "getxattr01";
> +#include "tst_test.h"
> +#include "tst_test_macros.h"
>   
> -#ifdef HAVE_SYS_XATTR_H
> +#define MNTPOINT "mntpoint"
>   #define XATTR_TEST_KEY "user.testkey"
>   #define XATTR_TEST_VALUE "this is a test value"
>   #define XATTR_TEST_VALUE_SIZE 20
>   #define BUFFSIZE 64
>   
> -static void setup(void);
> -static void cleanup(void);
> -
> -char filename[BUFSIZ];
> +static char filename[BUFSIZ];
> +static char *workdir;
>   
>   struct test_case {
>   	char *fname;
>   	char *key;
> -	char *value;
> +	char value[BUFFSIZE];
>   	size_t size;
>   	int exp_err;
> -};
> -struct test_case tc[] = {
> -	{			/* case 00, get non-existing attribute */
> +} tcases[] = {
> +	{ /* case 00, get non-existing attribute */
>   	 .fname = filename,
>   	 .key = "user.nosuchkey",
> -	 .value = NULL,
> +	 .value = {0},
>   	 .size = BUFFSIZE - 1,
>   	 .exp_err = ENODATA,
> -	 },
> -	{			/* case 01, small value buffer */
> +	},
> +	{ /* case 01, small value buffer */
>   	 .fname = filename,
>   	 .key = XATTR_TEST_KEY,
> -	 .value = NULL,
> +	 .value = {0},
>   	 .size = 1,
>   	 .exp_err = ERANGE,
> -	 },
> -	{			/* case 02, get existing attribute */
> +	},
> +	{ /* case 02, get existing attribute */
>   	 .fname = filename,
>   	 .key = XATTR_TEST_KEY,
> -	 .value = NULL,
> +	 .value = {0},
>   	 .size = BUFFSIZE - 1,
>   	 .exp_err = 0,
> -	 },
> +	},
>   };
>   
> -int TST_TOTAL = sizeof(tc) / sizeof(tc[0]) + 1;
> -
> -int main(int argc, char *argv[])
> +static void run(unsigned int i)
>   {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		for (i = 0; i < (int)ARRAY_SIZE(tc); i++) {
> -			TEST(getxattr(tc[i].fname, tc[i].key, tc[i].value,
> -				      tc[i].size));
> -
> -			if (TEST_ERRNO == tc[i].exp_err) {
> -				tst_resm(TPASS | TTERRNO, "expected behavior");
> -			} else {
> -				tst_resm(TFAIL | TTERRNO, "unexpected behavior"
> -					 "- expected errno %d - Got",
> -					 tc[i].exp_err);
> -			}
> -		}
> -
> -		if (TEST_RETURN != XATTR_TEST_VALUE_SIZE) {
> -			tst_resm(TFAIL,
> -				 "getxattr() returned wrong size %ld expected %d",
> -				 TEST_RETURN, XATTR_TEST_VALUE_SIZE);
> -			continue;
> +#ifdef HAVE_SYS_XATTR_H

We usually check for headers only once at the beginning of the file, 
just after includes, then use:

#else
TST_TEST_TCONF("System doesn't have <sys/xattr.h>");
#endif

Check fgetxattr01.c source code to get the example.

> +	SAFE_CHDIR(workdir);
> +
> +	/* create test file and set xattr */
> +	struct test_case *tc = &tcases[i];
> +	snprintf(tc->fname, BUFSIZ, "getxattr01testfile-%u", i);
> +	int fd = SAFE_CREAT(tc->fname, 0644);
> +	SAFE_CLOSE(fd);
> +	TEST(setxattr(tc->fname, XATTR_TEST_KEY, XATTR_TEST_VALUE,
> +				  strlen(XATTR_TEST_VALUE), XATTR_CREATE));
Here you can use TST_EXP_PASS instead of TEST
> +	if (TST_RET < 0) {
> +		if (TST_ERR == ENOTSUP) {
> +			tst_res(TCONF, "no xattr support in file system");
> +			return;
>   		}
> -
> -		if (memcmp(tc[i - 1].value, XATTR_TEST_VALUE, XATTR_TEST_VALUE_SIZE))
> -			tst_resm(TFAIL, "Wrong value, expect \"%s\" got \"%s\"",
> -				 XATTR_TEST_VALUE, tc[i - 1].value);
> -		else
> -			tst_resm(TPASS, "Got the right value");
> +		tst_res(TFAIL | TTERRNO, "unexpected setxattr() return code");
> +		return;
>   	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void setup(void)
> -{
> -	int fd;
> -	unsigned int i;
> -
> -	tst_require_root();
> -
> -	tst_tmpdir();
> -
> -	/* Create test file and setup initial xattr */
> -	snprintf(filename, BUFSIZ, "getxattr01testfile");
> -	fd = SAFE_CREAT(cleanup, filename, 0644);
> -	close(fd);
> -	if (setxattr(filename, XATTR_TEST_KEY, XATTR_TEST_VALUE,
> -		     strlen(XATTR_TEST_VALUE), XATTR_CREATE) == -1) {
> -		if (errno == ENOTSUP) {
> -			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
> -				 "mount without user_xattr option");
> -		}
> +	tst_res(TPASS | TTERRNO, "expected setxattr() return code");
> +
> +	/* read xattr back */
> +	TEST(getxattr(tc->fname, tc->key, tc->value, tc->size));
> +	if (TST_ERR == tc->exp_err) {
> +		tst_res(TPASS | TTERRNO, "expected getxattr() return code");
> +	} else {
> +		tst_res(TFAIL | TTERRNO, "unexpected getxattr() return code"
> +				" - expected errno %d", tc->exp_err);
>   	}
Also here you can use TST_EXP_PASS instead of TEST
>   
> -	/* Prepare test cases */
> -	for (i = 0; i < ARRAY_SIZE(tc); i++) {
> -		tc[i].value = malloc(BUFFSIZE);
> -		if (tc[i].value == NULL) {
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -				 "Cannot allocate memory");
> -		}
> +	/* verify the value for non-error test cases */
> +	if (tc->exp_err) {
> +		return;
>   	}
> -
> -	TEST_PAUSE;
> +	if (TST_RET != XATTR_TEST_VALUE_SIZE) {
Here you can use TST_EXP_EQ_LI
> +		tst_res(TFAIL,
> +				"getxattr() returned wrong size %ld expected %d",
> +				TST_RET, XATTR_TEST_VALUE_SIZE);
> +		return;
> +	}
> +	if (memcmp(tc->value, XATTR_TEST_VALUE, XATTR_TEST_VALUE_SIZE))
> +		tst_res(TFAIL, "wrong value, expected \"%s\" got \"%s\"",
> +				XATTR_TEST_VALUE, tc->value);
> +	else
> +		tst_res(TPASS, "right value");
> +#endif
>   }
>   
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> -#else /* HAVE_SYS_XATTR_H */
> -int main(int argc, char *argv[])
> +static void setup(void)
>   {
> -	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
> +#ifdef HAVE_SYS_XATTR_H
> +	char *cwd = SAFE_GETCWD(NULL, 0);
> +	workdir = SAFE_MALLOC(strlen(cwd) + strlen(MNTPOINT) + 2);
> +	sprintf(workdir, "%s/%s", cwd, MNTPOINT);
> +	free(cwd);
Here you can just SAFE_TOUCH the file if you aim to create one.
> +#else
> +	tst_brk(TCONF, "<sys/xattr.h> does not exist.");
> +#endif
>   }
> +
> +static struct tst_test test = {
> +#ifdef HAVE_SYS_XATTR_H
> +	.all_filesystems = 1,
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.mount_device = 1,
> +	.skip_filesystems = (const char *const []) {
> +			"exfat",
> +			"tmpfs",
> +			"ramfs",
> +			"nfs",
> +			"vfat",
> +			NULL
> +	},
>   #endif
> +	.setup = setup,
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases)
> +};

In your case, to understand LTP API a bit better, I would take 
fxgetattr01 as reference, more or less.

Always remember to run "make check-<name of my test>" before sending any 
patches, so you can be 100% the code has no text format issues.

Same comments apply to getxattr02 more or less.

Best regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
