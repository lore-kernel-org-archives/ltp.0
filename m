Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E394C636CD
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 17:06:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 985E83CC076
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 18:06:19 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63EB73C2730
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 18:06:06 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe12::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4536C1A0117C
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 18:06:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0VWQZavO0vqv4fziw6GtznVItfcznnotLF4YZVcJLNl0UAzz7sIhdNbY+2FAsMxRFGEIIk7pNTK8STqKJI2RGp8MJJNhTvuvIiyNAEIvJzF0UarlMNEcfXRBq1nT1fUkDIcjRav7rPbg+h9wn5LvR3y075p15J8aC6ZCynNvIS6DHVwF9N0RfHQSfu3acaDUaBS9DQcuaaEUMZkzEe9CtuZYsiGw2HUMVBJ4G7t8b6F5mLZVC8Ufmmw94Zw4RkKOm/NN5UzlnqmSBorCMsAmPqhUZ39VKkpCjP3fnUomXb8BMZzb8jSTq76GMgtl5ewIDxgd7YI4X46GiaguZ2ivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ys5l9v0jRmp0altBXEx9iL9A+7eODi3//rMxUzRfso=;
 b=GPFctCAakYgcPcz8UxFHMFarnGw7vbJ1OSr+4qPd9iIZk5XqPuG0cZE0HiNvqXqRecQgWqTOSAAL2WosQIYAyVHTdfA/fBkWlyQm1w8SZqq4l+wfwd7lsz9aj4+kwuQ0XaH3aeixYLKKmAznWaDo0Pqch4LXvzmnAKwAcg8645V46Lbqvg/+T7YJvhIuR2Twi0wgCSaeArKZChsn8H7mR1X74MP2n8FVhMa7+qLshnor9N9kzUdAiMIfQlDZ7SMuNIVdUAwKe3JQmvcqLXR0EmBDJ7owYKiRF0hpeOTSpaLBZCkxSjkIjO9gmRGdFmb90V+qbKfAHcbmqyZuF6HKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ys5l9v0jRmp0altBXEx9iL9A+7eODi3//rMxUzRfso=;
 b=PSefCZV2HzzJpBeqiiISWG5p09CyZnTRfJBhJ7kFv2DZa6dcSIq1VRQbfdPKEKpGjdbsGE5DNfzK/FH1z1gNPf5/UQgjeMssA7JtBbpKOeugMiceMvph5L1p0GuzRVGVCjkfy5aZuy6SZH31CAFApyHmXtK+vJNnJg8oa1H/XNe2HSKW1SwbBMqP1lBrTzldBaBsP3zVSGmwVMnrvL4hgzVg07cVPN5UHSGWEPU2GaoDsS4+FkH8kpcBIyTVtGG0LTe2rVeToxcd29JpRTh7RhijqPuJv5TeYkwg0TFpSRbYHhnN4Z7tnol8VMZaZfRH1iwS1C5Uv6ExfL6creSnCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DB8PR04MB7081.eurprd04.prod.outlook.com (2603:10a6:10:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 17:06:00 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 17:05:59 +0000
Message-ID: <24075ed9-cf80-00ce-54cd-893fa72948d5@suse.com>
Date: Fri, 10 Feb 2023 18:03:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20230125100043.32349-1-andrea.cervesato@suse.com>
 <20230125100043.32349-3-andrea.cervesato@suse.com> <87357frsbm.fsf@suse.de>
In-Reply-To: <87357frsbm.fsf@suse.de>
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DB8PR04MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 62758f1a-bb86-494a-ed97-08db0b8914e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q65bwVsirRHBdkn1TxComDKb/XIOt1dwGmzSFWV1HYGwqFc3+7pmnRTzuea4DTDIICiMMNVFyybqXdOJz2Gftz3bCsTNQTP+ks0IUuhHaJkmjBK+5tKDkSF8Co6CY426Z7zghsYLzWwSQj9Wcbr04NrTjdwzBpXxQn4C0w5RHrVAPoT09GYlSTNHaK9HiPeKsW3O+3HjriP/L87QVb70uNoZ+0wiVS1FLkGb0nzxZ+FChC+Y8IQUDgEx21I3KbYdEy4V+7b94cGmXubKIFhN2lCtc2ZSIxhmr1fz5sOZ+LILrChI1bejp6R+kut4wV+OUKFdWdbsXLmY34ewwucce34ndsqUtiSTOguth23dVJaE68QCit6TfCHIodG4yCr3Xafs2UVMwRMEJfo9epW7snR4oyYzO2W9aO6NHZzUty0gbNLLMB5Yo+RueMlUvM69HYPiMZm/N/ZfzATDaYtWQ1HujGweKk3WOFyM51ZY51s0chXg9kQO40kpJncxp22YCusuiqU99WQYHtDEvEbWpIecU/v85Ze467fVVfphshmaSCNd69V/kOeVGpzzj2AaFFHabSM0GRi0wVN63nN5ZzdTsqpa7uWblDMLiY2OI46v5Yxzt21XwDRjksCmI+yZP4EX07zIkFrLAyF0sH3wbZNYPee35AxhQUFjv73bKF/TdE1tzRz65Si4p7GrEy5Cwy7Ca/1xBCLThS/JveNP0DTqv1qMbt9tPMOIvYnCrBTHt7kXnLEWOyqvHrgnvpMBtch7BjCYb9RzIOUTv28drg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199018)(31686004)(4326008)(6916009)(66476007)(66556008)(8676002)(316002)(66946007)(36756003)(31696002)(86362001)(478600001)(6666004)(6506007)(53546011)(26005)(6512007)(186003)(2616005)(41300700001)(8936002)(6486002)(2906002)(38100700002)(44832011)(83380400001)(30864003)(5660300002)(2004002)(43740500002)(45980500001)(473944003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW9rMHhWUUwrNDR6MGFqalpGSlgrU0RUUHE1TzNGd3RoR3J0VkxzaGFMZ2M4?=
 =?utf-8?B?MXh6THpWL0VCRDY1NngzS1VQNy9VZHdzVGFYOU9aUGFISFNHcW5jMVZOeWNy?=
 =?utf-8?B?bFQ4bmVabDgvRm9jV09YWWs1bS8zR00wUjBmM2svRWl2KzM4ajNaeGdwMTNy?=
 =?utf-8?B?enpNaFVpUmxTUzdNSVdoV055aDJLK2FpNk5wODZrbFFBdmd6VTg5ZzFFTmxB?=
 =?utf-8?B?bFJ6cTZHNEhXV2J4QjFuVGNSSldKY2tvdFZRdGZNdDljMk1peEZLa0Z6SWZJ?=
 =?utf-8?B?ZDFXMDdub3RoRzFmdHFNVFNKVCs5NmtKMVJmMGpxYUxEcGVCeVNNZDRWYzVa?=
 =?utf-8?B?U21kODYwVFJMVTJUWUc1OHhlRWsyd3FXM2NHaVN3Uis1SWo5QWhuR2R6a2xj?=
 =?utf-8?B?YVEwUHhiNW9VTGZEZzY2amN5ait2T09OTnFqeTA1b0xWclNWT2Z5dVlRQkIr?=
 =?utf-8?B?WnpKMHFGMnAwNFg4YmpwMFlnYndGZDk3WGx3MWNpMnlHQnJZeHNYR1pFTW5E?=
 =?utf-8?B?RFNsc0FUYkh4TFRNVVlYR0ZtbWczWklWZW0yai9GRzhvWlE0VjhTSUV2RzBT?=
 =?utf-8?B?b25jL3cvRmJwZHhEZ3hhczFpT1lodnRPMUk3dVJUa1llRHBKUjVJdFNzeTc1?=
 =?utf-8?B?QkZsUVltK2R6ZDJiZTRmblh1Q1l2TUpnOC9PZmpjbVJBT3h3K1pmSmxqa1Ba?=
 =?utf-8?B?RjVMZmUzZjdEY3JsVGQ5M2UySitxdzhVMkhYeE1jWGhaSHVhU3AxenlsZUJZ?=
 =?utf-8?B?RlhKOHBrNkFUdzBaYzg1R0d6SXBVbm5NNXdCZlZWcUY0TzBxVkJONWJDeFdx?=
 =?utf-8?B?MCtIZi8wcStWYjBnMHNnbHltNEM4NHk2b1VUSWREeHlyeG80cXBqaWs4TndW?=
 =?utf-8?B?dm1KZVdJbHBISnJiZHlySDFnVEdOcXpNN241TFp1OHZqb1JmKzJic2lOMXNN?=
 =?utf-8?B?T2g3d3JmUVRBdCtvd1IvK1RxOXQ0YVpPY2drWDdKY1Yyemh5TGxvbVhSeG5L?=
 =?utf-8?B?VlFVMEgyb3pEdTd4STNQelFmbnNEUjhYQjR0eHV1b2k2d2F5VDg4K293aGgy?=
 =?utf-8?B?M3BZY1NMSjRwcDZuUmt2bVBIZURWTHpXWGYwQlRsM3pUb3pZT1hNZUoyTzNh?=
 =?utf-8?B?eEo5Y3RmYXAzL0crUUNHcXQ2TVFEbXV3YnJXaXpuTCtBN0Z0UmhJWlVZbTNM?=
 =?utf-8?B?QVVvN2ZjbjlMR0xVaWFkalh5KzR4cU5ZWXh2UTZpM0YrTU9vSlJuUGdMTURC?=
 =?utf-8?B?RUZnVU40T3RLTkY5L0pYVDU2ZjZybityZzZLQk5wTktjR2hoeU1SS2hUcGhK?=
 =?utf-8?B?S1VEcCtENzlEUmNrWmJpUDBhZ280bVVQMko3UDNiTXNDM1Q0SmRmWGRXaFgr?=
 =?utf-8?B?a2pneHNrMUhIMVVZM1FJMmpGOVR6akh2SElKeGwxcS9IUzRNTkdtVnJlU1R2?=
 =?utf-8?B?VzhCckJIaGdoMGFuSHlyaGp4T3pJVXIyREw2RE90RzJsUE9MYjlvU3FCTStV?=
 =?utf-8?B?YkEvTGRkWUFBdmJaN1l1T0xIQmcwU3drNzhHT29BRXVpdmtYR2VOT3NtMmdJ?=
 =?utf-8?B?cnlOai9NZXFieVgvZlhBakVPdWtFNDcwR1EzMzkwQ3RIRzZwd3BzNVBYeDM1?=
 =?utf-8?B?RTlxWHo3bjVOcUp1a3c1NkFaRGM3cUZHTU1keTQ5aVJtOHN1MzJpd3FOeE0z?=
 =?utf-8?B?QU9adWI4UnJxQzlPMnJLamQ2YUs1eDZiTVJBTFN1aVFoaSthamdlLzMzR2ZH?=
 =?utf-8?B?dzY2Si8zb2MyUDB6Q0hrSTBGdSt5UWZZdjNFeUtTQUhXZVl0R2pNT3dxSVJD?=
 =?utf-8?B?dkhFbWN1MVEyQVpiekJzZ1EyblhRQXFSMGxEK0svM2tuZ1IxY0VLaU5ORTBF?=
 =?utf-8?B?NXp4MWplckYrQ0NjNS82THNRNy8wQnFIUnBjdk9EZ2F1cjY1c3VqckE1SEVM?=
 =?utf-8?B?SnFLdGZKSUR2WW15ZWMvSnVsZlhlc2tFVGVFcVpXRTZBMWxzb0o0VHQ2VDRs?=
 =?utf-8?B?bERqWjh4RDdQa0FJbXY4eWVDb0hWRVJObFhHRTNHUEc1TzhMdzBuUmFtWlBx?=
 =?utf-8?B?TEQ3dEdjakhvQS9xZ3hZeklaZWZBeUZXNDl1aEZkajkxSExRNktzd016cFVr?=
 =?utf-8?B?bWJ2aGVlZjBTUThWdkQwRmVobVJmbE5COUhRaUZxdDNXUkFRM1NnNjBYVXFv?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62758f1a-bb86-494a-ed97-08db0b8914e2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 17:05:59.5491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkoLTfWjkAYan/2hkvEsvpLH7FTUzIrszhKS6anT0tdZJKXO+gVEPzf062FNl8XW5LdYit4DazpAwXAkO++xOfyqpyiFKY87HWenchPsEjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7081
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] Rewrite utsname testing suite
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

Hi!

On 2/9/23 11:11, Richard Palethorpe wrote:
> Hello,
>
> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>
>> Deleted utstest.c and created the following new tests:
>> - utsname01
>> - utsname02
>> - utsname03
>> - utsname04
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>> removed root requirement from utsname01
>> removed default value from -m option in utsname0[34]
>>
>>   runtest/containers                            |   7 +
>>   .../kernel/containers/utsname/.gitignore      |   5 +-
>>   testcases/kernel/containers/utsname/Makefile  |  23 +-
>>   .../containers/utsname/runutstests_noltp.sh   |  41 --
>>   testcases/kernel/containers/utsname/utsname.h | 116 ++++++
>>   .../kernel/containers/utsname/utsname01.c     |  71 ++++
>>   .../kernel/containers/utsname/utsname02.c     |  96 +++++
>>   .../kernel/containers/utsname/utsname03.c     | 110 ++++++
>>   .../kernel/containers/utsname/utsname04.c     |  66 ++++
>>   testcases/kernel/containers/utsname/utstest.c |
>>   353 ------------------
> Deleted utstest but...
>
>
>>   10 files changed, 473 insertions(+), 415 deletions(-)
>>   delete mode 100755 testcases/kernel/containers/utsname/runutstests_noltp.sh
>>   create mode 100644 testcases/kernel/containers/utsname/utsname.h
>>   create mode 100644 testcases/kernel/containers/utsname/utsname01.c
>>   create mode 100644 testcases/kernel/containers/utsname/utsname02.c
>>   create mode 100644 testcases/kernel/containers/utsname/utsname03.c
>>   create mode 100644 testcases/kernel/containers/utsname/utsname04.c
>>   delete mode 100644 testcases/kernel/containers/utsname/utstest.c
>>
>> diff --git a/runtest/containers b/runtest/containers
>> index 2637b62fe..36d9378af 100644
>> --- a/runtest/containers
>> +++ b/runtest/containers
>> @@ -73,6 +73,13 @@ utstest_clone_3 utstest clone 3
>>   utstest_clone_4 utstest clone 4
>>   utstest_clone_5 utstest clone 5
> it is still called in the runtest.
>
>>   
>> +utsname01 utsname01
>> +utsname02 utsname02
>> +utsname03_clone utsname03 -m clone
>> +utsname03_unshare utsname03 -m unshare
>> +utsname04_clone utsname04 -m clone
>> +utsname04_unshare utsname04 -m unshare
>> +
>>   mountns01 mountns01
>>   mountns02 mountns02
>>   mountns03 mountns03
>> diff --git a/testcases/kernel/containers/utsname/.gitignore b/testcases/kernel/containers/utsname/.gitignore
>> index 0e1f41dc8..945ed280e 100644
>> --- a/testcases/kernel/containers/utsname/.gitignore
>> +++ b/testcases/kernel/containers/utsname/.gitignore
>> @@ -1 +1,4 @@
>> -/utstest
>> +/utsname01
>> +/utsname02
>> +/utsname03
>> +/utsname04
>> diff --git a/testcases/kernel/containers/utsname/Makefile b/testcases/kernel/containers/utsname/Makefile
>> index 5efcbf648..9c0158c01 100644
>> --- a/testcases/kernel/containers/utsname/Makefile
>> +++ b/testcases/kernel/containers/utsname/Makefile
>> @@ -1,28 +1,11 @@
>> -################################################################################
>> -##                                                                            ##
>> -## Copyright (c) International Business Machines  Corp., 2007                 ##
>> -##                                                                            ##
>> -## This program is free software;  you can redistribute it and#or modify      ##
>> -## it under the terms of the GNU General Public License as published by       ##
>> -## the Free Software Foundation; either version 2 of the License, or          ##
>> -## (at your option) any later version.                                        ##
>> -##                                                                            ##
>> -## This program is distributed in the hope that it will be useful, but        ##
>> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
>> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
>> -## for more details.                                                          ##
>> -##                                                                            ##
>> -## You should have received a copy of the GNU General Public License          ##
>> -## along with this program;  if not, write to the Free Software               ##
>> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
>> -##                                                                            ##
>> -################################################################################
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>>   
>>   top_srcdir		?= ../../../..
>>   
>>   include $(top_srcdir)/include/mk/testcases.mk
>>   include $(abs_srcdir)/../Makefile.inc
>>   
>> -LDLIBS			:= -lclone -lpthread -lrt $(LDLIBS)
>> +LDLIBS			:= -lclone $(LDLIBS)
>>   
>>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/kernel/containers/utsname/runutstests_noltp.sh b/testcases/kernel/containers/utsname/runutstests_noltp.sh
>> deleted file mode 100755
>> index 43cb7e26b..000000000
>> --- a/testcases/kernel/containers/utsname/runutstests_noltp.sh
>> +++ /dev/null
>> @@ -1,41 +0,0 @@
>> -#!/bin/sh
>> -################################################################################
>> -##                                                                            ##
>> -## Copyright (c) International Business Machines  Corp., 2007                 ##
>> -##                                                                            ##
>> -## This program is free software;  you can redistribute it and#or modify      ##
>> -## it under the terms of the GNU General Public License as published by       ##
>> -## the Free Software Foundation; either version 2 of the License, or          ##
>> -## (at your option) any later version.                                        ##
>> -##                                                                            ##
>> -## This program is distributed in the hope that it will be useful, but        ##
>> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
>> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
>> -## for more details.                                                          ##
>> -##                                                                            ##
>> -## You should have received a copy of the GNU General Public License          ##
>> -## along with this program;  if not, write to the Free Software               ##
>> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
>> -##                                                                            ##
>> -################################################################################
>> -
>> -oldhostname=`hostname`
>> -exit_code=0
>> -echo "unshare tests"
>> -for i in `seq 1 5`; do
>> -	echo "test $i (unshare)"
>> -	./utstest_noltp unshare $i
>> -	if [ $? -ne 0 ]; then
>> -		exit_code=$?
>> -	fi
>> -done
>> -echo "clone tests"
>> -for i in `seq 1 5`; do
>> -	echo "test $i (clone)"
>> -	./utstest_noltp clone $i
>> -	if [ $? -ne 0 ]; then
>> -		exit_code=$?
>> -	fi
>> -done
>> -hostname "$oldhostname"
>> -exit $exit_code
>> diff --git a/testcases/kernel/containers/utsname/utsname.h b/testcases/kernel/containers/utsname/utsname.h
>> new file mode 100644
>> index 000000000..74d0ec3ac
>> --- /dev/null
>> +++ b/testcases/kernel/containers/utsname/utsname.h
>> @@ -0,0 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +#ifndef UTSTEST_H
>> +#define UTSTEST_H
>> +
>> +#include <stdlib.h>
>> +#include "tst_test.h"
>> +#include "lapi/syscalls.h"
>> +#include "lapi/sched.h"
>> +
>> +enum {
>> +	T_CLONE,
>> +	T_UNSHARE,
>> +	T_NONE,
>> +};
>> +
>> +static int dummy_child(LTP_ATTRIBUTE_UNUSED void *v)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void check_newuts(void)
>> +{
>> +	int pid, status;
>> +
>> +	pid = ltp_clone_quick(CLONE_NEWUTS | SIGCHLD, dummy_child, NULL);
>> +	if (pid < 0)
>> +		tst_brk(TCONF | TERRNO, "CLONE_NEWIPC not supported");
> s/CLONE_NEWIPC/CLONE_NEWUTS/
>
>> +
>> +	SAFE_WAITPID(pid, &status, 0);
> I think you can use tst_clone and then remove dummy_child. Also you can
> use tst_reap_children
>
> Something like
>
> pid = tst_clone((tst_clone_args *)&{ CLONE_NEWUTS, SIGCHLD });
> if (!pid)
>     exit(0);
>
> if (pid < 0 && errno == EINVAL)
>     tst_brk(TCONF ...)
>
> if (pid < 0)
>     tst_brk(TBROK ...)
>
> Note that we expect EINVAL if it's not supported and there are other
> possible errors.

Actually I'm surprised it even work, since children in setup() are bad 
habit.
Perhaps, since the first kernel supporting CLONE_NEWUTS is 2.6.19, the 
check can be removed from tests.

>> +}
>> +
>> +static inline int get_clone_unshare_enum(const char *str_op)
>> +{
>> +	int use_clone;
>> +
>> +	use_clone = T_NONE;
>> +
>> +	if (!str_op || !strcmp(str_op, "none"))
>> +		use_clone = T_NONE;
>> +	else if (!strcmp(str_op, "clone"))
>> +		use_clone = T_CLONE;
>> +	else if (!strcmp(str_op, "unshare"))
>> +		use_clone = T_UNSHARE;
>> +	else
>> +		tst_brk(TBROK, "Test execution mode <clone|unshare|none>");
>> +
>> +	return use_clone;
>> +}
>> +
>> +static inline pid_t clone_test(unsigned long clone_flags, int (*fn1)(void *arg), void *arg1)
>> +{
>> +	pid_t pid;
>> +
>> +	pid = ltp_clone_quick(clone_flags | SIGCHLD, fn1, arg1);
>> +	if (pid < 0)
>> +		tst_brk(TBROK | TERRNO, "ltp_clone_quick error");
>> +
>> +	return pid;
>> +}
>> +
>> +static inline pid_t unshare_test(unsigned long clone_flags, int (*fn1)(void *arg), void *arg1)
>> +{
>> +	pid_t pid;
>> +
>> +	pid = SAFE_FORK();
>> +	if (!pid) {
>> +		SAFE_UNSHARE(clone_flags);
>> +
>> +		fn1(arg1);
>> +		exit(0);
>> +	}
>> +
>> +	return pid;
>> +}
>> +
>> +static inline pid_t plain_test(int (*fn1)(void *arg), void *arg1)
>> +{
>> +	pid_t pid;
>> +
>> +	pid = SAFE_FORK();
>> +	if (!pid) {
>> +		fn1(arg1);
>> +		exit(0);
>> +	}
>> +
>> +	return pid;
>> +}
>> +
>> +static inline pid_t clone_unshare_test(int use_clone, unsigned long clone_flags,
>> +			       int (*fn1)(void *arg), void *arg1)
>> +{
>> +	pid_t pid = -1;
>> +
>> +	switch (use_clone) {
>> +	case T_NONE:
>> +		pid = plain_test(fn1, arg1);
>> +	break;
>> +	case T_CLONE:
>> +		pid = clone_test(clone_flags, fn1, arg1);
>> +	break;
>> +	case T_UNSHARE:
>> +		pid = unshare_test(clone_flags, fn1, arg1);
>> +	break;
>> +	default:
>> +		tst_brk(TBROK, "%s: bad use_clone option: %d", __func__, use_clone);
>> +	break;
>> +	}
>> +
>> +	return pid;
>> +}
> We do not need function pointers here. The ltp_clone_quick can be
> replaced with tst_clone and we return the PID without exiting the child.
>
> So then the tests can be written inline which makes the control flow
> and syntax easier to follow (IMO).
>
>> +
>> +#endif
>> diff --git a/testcases/kernel/containers/utsname/utsname01.c b/testcases/kernel/containers/utsname/utsname01.c
>> new file mode 100644
>> index 000000000..b5144709a
>> --- /dev/null
>> +++ b/testcases/kernel/containers/utsname/utsname01.c
>> @@ -0,0 +1,71 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Clone two plain processes and check if both read the same hostname.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include "tst_test.h"
>> +#include "utsname.h"
>> +
>> +static char *hostname1;
>> +static char *hostname2;
>> +
>> +static int child1_run(LTP_ATTRIBUTE_UNUSED void *vtest)
>> +{
>> +	SAFE_GETHOSTNAME(hostname1, HOST_NAME_MAX);
>> +
>> +	return 0;
>> +}
>> +
>> +static int child2_run(LTP_ATTRIBUTE_UNUSED void *vtest)
>> +{
>> +	SAFE_GETHOSTNAME(hostname2, HOST_NAME_MAX);
>> +
>> +	return 0;
>> +}
>> +
>> +static void run(void)
>> +{
>> +	int status1, status2;
>> +	pid_t pid1, pid2;
>> +
>> +	memset(hostname1, 0, HOST_NAME_MAX);
>> +	memset(hostname2, 0, HOST_NAME_MAX);
>> +
>> +	pid1 = clone_unshare_test(T_NONE, 0, child1_run, NULL);
>> +	pid2 = clone_unshare_test(T_NONE, 0, child2_run, NULL);
>> +
>> +	SAFE_WAITPID(pid1, &status1, 0);
>> +	SAFE_WAITPID(pid2, &status2, 0);
>> +
>> +	if (WIFSIGNALED(status1) || WIFSIGNALED(status2))
>> +		return;
> If either process is signaled then we exit without returning a test
> result. This will create a more confusing log in case of an error.
>
> Unless I am missing something I think all of these waitpids can be
> replaced with a call to tst_reap_children.
>
> That's assuming we just want to know the children exited successfully?
>
>> +
>> +	TST_EXP_PASS(strcmp(hostname1, hostname2));
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	hostname1 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>> +	hostname2 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX,
>> PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> Byte and char are both specified as 8-bits so sizeof(char) is always one.
>
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	SAFE_MUNMAP(hostname1, HOST_NAME_MAX);
>> +	SAFE_MUNMAP(hostname2, HOST_NAME_MAX);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.forks_child = 1,
>> +};
>> diff --git a/testcases/kernel/containers/utsname/utsname02.c b/testcases/kernel/containers/utsname/utsname02.c
>> new file mode 100644
>> index 000000000..5f8bbe836
>> --- /dev/null
>> +++ b/testcases/kernel/containers/utsname/utsname02.c
>> @@ -0,0 +1,96 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Clone two plain processes, change hostname in the first one then check if
>> + * hostaname has changed inside the second one as well.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include "tst_test.h"
>> +#include "utsname.h"
>> +
>> +#define HOSTNAME "LTP_HOSTNAME"
>> +
>> +static char *hostname1;
>> +static char *hostname2;
>> +static char originalhost[HOST_NAME_MAX];
>> +
>> +static void reset_hostname(void)
>> +{
>> +	SAFE_SETHOSTNAME(originalhost, strlen(originalhost));
>> +}
>> +
>> +static int child1_run(LTP_ATTRIBUTE_UNUSED void *vtest)
>> +{
>> +	SAFE_SETHOSTNAME(HOSTNAME, strlen(HOSTNAME));
>> +	SAFE_GETHOSTNAME(hostname1, HOST_NAME_MAX);
>> +
>> +	TST_CHECKPOINT_WAKE(0);
>> +
>> +	return 0;
>> +}
>> +
>> +static int child2_run(LTP_ATTRIBUTE_UNUSED void *vtest)
>> +{
>> +	TST_CHECKPOINT_WAIT(0);
>> +
>> +	SAFE_GETHOSTNAME(hostname2, HOST_NAME_MAX);
>> +
>> +	return 0;
>> +}
>> +
>> +static void run(void)
>> +{
>> +	pid_t pid1, pid2;
>> +	int status1, status2;
>> +
>> +	memset(hostname1, 0, HOST_NAME_MAX);
>> +	memset(hostname2, 0, HOST_NAME_MAX);
>> +
>> +	pid1 = clone_unshare_test(T_NONE, 0, child1_run, NULL);
>> +	pid2 = clone_unshare_test(T_NONE, 0, child2_run, NULL);
>> +
>> +	SAFE_WAITPID(pid1, &status1, 0);
>> +	SAFE_WAITPID(pid2, &status2, 0);
>> +
>> +	if (WIFSIGNALED(status1) || WIFSIGNALED(status2))
>> +		return;
> again tst_reap_children
>
>> +
>> +	TST_EXP_PASS(strcmp(hostname1, HOSTNAME));
>> +	TST_EXP_PASS(strcmp(hostname2, HOSTNAME));
>> +
>> +	reset_hostname();
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	hostname1 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>> +	hostname2 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>> +
>> +	memset(originalhost, 0, HOST_NAME_MAX);
>> +
>> +	SAFE_GETHOSTNAME(originalhost, HOST_NAME_MAX);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	SAFE_MUNMAP(hostname1, HOST_NAME_MAX);
>> +	SAFE_MUNMAP(hostname2, HOST_NAME_MAX);
>> +
>> +	reset_hostname();
> What happens if SAFE_GETHOSTNAME(originalhost...) fails? Same question
> for if mmap fails?
>
>  From past experience of debugging, we don't want to try any cleanup that
> will definitely result in more error messages.
A shared memory is needed during tests, since we try to communicate 
between processes and I have no ways to remove it. Ideas?
>
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.needs_checkpoints = 1,
>> +};
>> diff --git a/testcases/kernel/containers/utsname/utsname03.c b/testcases/kernel/containers/utsname/utsname03.c
>> new file mode 100644
>> index 000000000..b90020c88
>> --- /dev/null
>> +++ b/testcases/kernel/containers/utsname/utsname03.c
>> @@ -0,0 +1,110 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) International Business Machines Corp., 2007
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Clone two processes using CLONE_NEWUTS, change hostname from the first
>> + * container and check if hostname didn't change inside the second one.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include "tst_test.h"
>> +#include "utsname.h"
>> +
>> +#define HOSTNAME "LTP_HOSTNAME"
>> +
>> +static char *str_op;
>> +static int use_clone;
>> +static char *hostname1;
>> +static char *hostname2;
>> +static char originalhost[HOST_NAME_MAX];
>> +
>> +static void reset_hostname(void)
>> +{
>> +	SAFE_SETHOSTNAME(originalhost, strlen(originalhost));
>> +}
>> +
>> +static int child1_run(LTP_ATTRIBUTE_UNUSED void *vtest)
>> +{
>> +	SAFE_SETHOSTNAME(HOSTNAME, strlen(HOSTNAME));
>> +	SAFE_GETHOSTNAME(hostname1, HOST_NAME_MAX);
>> +
>> +	TST_CHECKPOINT_WAKE(0);
>> +
>> +	return 0;
>> +}
>> +
>> +static int child2_run(LTP_ATTRIBUTE_UNUSED void *vtest)
>> +{
>> +	TST_CHECKPOINT_WAIT(0);
>> +
>> +	SAFE_GETHOSTNAME(hostname2, HOST_NAME_MAX);
>> +
>> +	return 0;
>> +}
>> +
>> +static void run(void)
>> +{
>> +	pid_t pid1, pid2;
>> +	int status1, status2;
>> +
>> +	memset(hostname1, 0, HOST_NAME_MAX);
>> +	memset(hostname2, 0, HOST_NAME_MAX);
>> +
>> +	pid1 = clone_unshare_test(use_clone, CLONE_NEWUTS, child1_run, NULL);
>> +	pid2 = clone_unshare_test(use_clone, CLONE_NEWUTS, child2_run, NULL);
>> +
>> +	SAFE_WAITPID(pid1, &status1, 0);
>> +	SAFE_WAITPID(pid2, &status2, 0);
>> +
>> +	if (WIFSIGNALED(status1) || WIFSIGNALED(status2))
>> +		return;
>> +
>> +	TST_EXP_PASS(strcmp(hostname1, HOSTNAME));
>> +	TST_EXP_PASS(strcmp(hostname2, originalhost));
>> +
>> +	reset_hostname();
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	use_clone = get_clone_unshare_enum(str_op);
>> +
>> +	if (use_clone != T_CLONE && use_clone != T_UNSHARE)
>> +		tst_brk(TCONF, "Only clone and unshare clone are supported");
>> +
>> +	check_newuts();
>> +
>> +	hostname1 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>> +	hostname2 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>> +
>> +	memset(originalhost, 0, HOST_NAME_MAX);
>> +
>> +	SAFE_GETHOSTNAME(originalhost, HOST_NAME_MAX);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	SAFE_MUNMAP(hostname1, HOST_NAME_MAX);
>> +	SAFE_MUNMAP(hostname2, HOST_NAME_MAX);
>> +
>> +	reset_hostname();
>> +}
> Mostly the same comments again for this test I guess.
>
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.needs_checkpoints = 1,
>> +	.options = (struct tst_option[]) {
>> +		{ "m:", &str_op, "Test execution mode <clone|unshare>" },
>> +		{},
>> +	},
>> +};
>> diff --git a/testcases/kernel/containers/utsname/utsname04.c b/testcases/kernel/containers/utsname/utsname04.c
>> new file mode 100644
>> index 000000000..42fd65d04
>> --- /dev/null
>> +++ b/testcases/kernel/containers/utsname/utsname04.c
>> @@ -0,0 +1,66 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Drop root privileges, create a container with CLONE_NEWUTS and verify that
>> + * we receive a permission error.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include "tst_test.h"
>> +#include "utsname.h"
>> +
>> +static char *str_op;
>> +static int use_clone;
>> +
>> +static int child1_run(LTP_ATTRIBUTE_UNUSED void *vtest)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void run(void)
>> +{
>> +	void *stack;
>> +	size_t stack_size = getpagesize() * 6;
>> +
>> +	stack = ltp_alloc_stack(stack_size);
>> +	if (stack == NULL)
>> +		tst_brk(TBROK, "Can't allocate stack");
> I don't think we need to allocate a stack for CLONE_NEWUTS.
>
>> +
>> +	tst_res(TINFO, "Dropping root privileges");
>> +
>> +	SAFE_SETRESUID(1000, 1000, 1000);
> Usually we get a UID using SAFE_GETPWNAM("nobody"). IIRC CAP_SYS_ADMIN
> can be given to a user other than root (0).
>
>> +
>> +	tst_res(TINFO, "clone() with CLONE_NEWUTS");
>> +
>> +	ltp_clone(CLONE_NEWUTS, child1_run, NULL, stack_size, stack);
> This should be easily converted to tst_clone and we can remove child1_run.
>
>> +
>> +	TST_EXP_PASS(errno == EPERM);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	use_clone = get_clone_unshare_enum(str_op);
>> +
>> +	if (use_clone != T_CLONE && use_clone != T_UNSHARE)
>> +		tst_brk(TCONF, "Only clone and unshare clone are supported");
>> +
>> +	check_newuts();
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.needs_checkpoints = 1,
>> +	.options = (struct tst_option[]) {
>> +		{ "m:", &str_op, "Test execution mode <clone|unshare>" },
>> +		{},
>> +	},
>> +};
>> diff --git a/testcases/kernel/containers/utsname/utstest.c b/testcases/kernel/containers/utsname/utstest.c
>> deleted file mode 100644
>> index 9ad19b6b2..000000000
>> --- a/testcases/kernel/containers/utsname/utstest.c
>> +++ /dev/null
>> @@ -1,353 +0,0 @@
>> -/*
>> -* Copyright (c) International Business Machines Corp., 2007
>> -* This program is free software; you can redistribute it and/or modify
>> -* it under the terms of the GNU General Public License as published by
>> -* the Free Software Foundation; either version 2 of the License, or
>> -* (at your option) any later version.
>> -*
>> -* This program is distributed in the hope that it will be useful,
>> -* but WITHOUT ANY WARRANTY; without even the implied warranty of
>> -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
>> -* the GNU General Public License for more details.
>> -* You should have received a copy of the GNU General Public License
>> -* along with this program; if not, write to the Free Software
>> -* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> -*
>> -***************************************************************************
>> - * Copyright 2007 IBM
>> - * Author: Serge Hallyn <serue@us.ibm.com>
>> - *
>> - * test1:
>> -	P1: A=gethostname
>> -	P2: B=gethostname
>> -	Ensure(A==B)
>> -
>> - * test2:
>> -	P1: sethostname(A);
>> -	P2: (wait); B=gethostname
>> -	Ensure (A==B)
>> -
>> - * test3:
>> -	P1: A=gethostname; unshare(utsname); sethostname(newname); C=gethostname
>> -	P2: B=gethostname; (wait); (wait); D=gethostname
>> -	Ensure (A==B && A==D && C!=D)
>> -
>> - * test4:
>> -	P1: A=gethostname; unshare(utsname); (wait); C=gethostname
>> -	P2: B=gethostname; (wait); sethostname(newname); D=gethostname
>> -	Ensure (A==B && A==C && C!=D)
>> -
>> - * test5:
>> -	P1: drop_privs(); unshare(utsname); (wait); C=gethostname
>> -	P2: (wait); sethostname(B); D=gethostname
>> -	Ensure (B==C==D) and state is ok.
>> - *
>> - */
>> -
>> -#define _GNU_SOURCE 1
>> -#include <sys/wait.h>
>> -#include <assert.h>
>> -#include <stdio.h>
>> -#include <stdlib.h>
>> -#include <unistd.h>
>> -#include <string.h>
>> -#include <errno.h>
>> -#include "libclone.h"
>> -#include "test.h"
>> -#include "safe_macros.h"
>> -
>> -char *TCID = "uts_namespace";
>> -int TST_TOTAL = 1;
>> -
>> -static int dummy_child(void *v)
>> -{
>> -	(void) v;
>> -	return 0;
>> -}
>> -
>> -static void check_newuts(void)
>> -{
>> -	int pid, status;
>> -
>> -	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWUTS, dummy_child, NULL);
>> -	if (pid == -1)
>> -		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWUTS not supported");
>> -
>> -	SAFE_WAIT(NULL, &status);
>> -}
>> -
>> -int drop_root(void)
>> -{
>> -	int ret;
>> -	ret = setresuid(1000, 1000, 1000);
>> -	if (ret) {
>> -		perror("setresuid");
>> -		exit(4);
>> -	}
>> -	return 1;
>> -}
>> -
>> -#define HLEN 100
>> -#define NAME1 "serge1"
>> -#define NAME2 "serge2"
>> -
>> -int p1fd[2], p2fd[2];
>> -static char oldhost[HLEN];
>> -pid_t cpid;
>> -
>> -void picknewhostname(char *orig, char *new)
>> -{
>> -	memset(new, 0, HLEN);
>> -	if (strcmp(orig, NAME1) == 0)
>> -		strcpy(new, NAME2);
>> -	else
>> -		strcpy(new, NAME1);
>> -}
>> -
>> -void zeroize(char *s)
>> -{
>> -	memset(s, 0, HLEN);
>> -}
>> -
>> -char *tsttype;
>> -int P1(void *vtest)
>> -{
>> -	char hostname[HLEN], newhostname[HLEN], rhostname[HLEN];
>> -	int err;
>> -	int len;
>> -	int testnum;
>> -
>> -	testnum = atoi((char *)vtest);
>> -
>> -	close(p1fd[1]);
>> -	close(p2fd[0]);
>> -
>> -	switch (testnum) {
>> -	case 1:
>> -		gethostname(hostname, HLEN);
>> -		zeroize(rhostname);
>> -		len = read(p1fd[0], rhostname, HLEN);
>> -		if (strcmp(hostname, rhostname) == 0) {
>> -			tst_resm(TPASS, "test 1 (%s): success", tsttype);
>> -			tst_exit();
>> -		}
>> -		tst_brkm(TFAIL, NULL,
>> -			 "test 1 (%s): hostname 1 %s, hostname 2 %s",
>> -			 tsttype, hostname, rhostname);
>> -	case 2:
>> -		gethostname(hostname, HLEN);
>> -		picknewhostname(hostname, newhostname);
>> -		err = sethostname(newhostname, strlen(newhostname));
>> -		write(p2fd[1], "1", 1);
>> -		if (err == -1) {
>> -			tst_brkm(TFAIL, NULL,
>> -				 "test 2 (%s): failed to sethostname",
>> -				 tsttype);
>> -		}
>> -		zeroize(rhostname);
>> -		len = read(p1fd[0], rhostname, HLEN);
>> -		if (strcmp(newhostname, rhostname) == 0) {
>> -			tst_resm(TPASS, "test 2 (%s): success", tsttype);
>> -			tst_exit();
>> -		}
>> -		tst_brkm(TFAIL, NULL,
>> -			 "test 2 (%s) hostname 1 %s, hostname 2 %s",
>> -			 tsttype, newhostname, rhostname);
>> -	case 3:
>> -		gethostname(hostname, HLEN);
>> -		picknewhostname(hostname, newhostname);
>> -		err = sethostname(newhostname, strlen(newhostname));
>> -		write(p2fd[1], "1", 1);
>> -		if (err == -1) {
>> -			tst_brkm(TFAIL, NULL,
>> -				 "test 3 (%s): failed to sethostname",
>> -				 tsttype);
>> -		}
>> -
>> -		zeroize(rhostname);
>> -		len = read(p1fd[0], rhostname, HLEN);
>> -		if (strcmp(newhostname, rhostname) == 0) {
>> -			tst_brkm(TFAIL,
>> -				 NULL,
>> -				 "test 3 (%s): hostname 1 %s, hostname 2 %s, these should have been different",
>> -				 tsttype, newhostname, rhostname);
>> -		}
>> -		if (strcmp(hostname, rhostname) == 0) {
>> -			tst_resm(TPASS, "test 3 (%s): success", tsttype);
>> -			tst_exit();
>> -		}
>> -		tst_brkm(TFAIL,
>> -			 NULL,
>> -			 "test 3 (%s): hostname 1 %s, hostname 2 %s, should have been same",
>> -			 tsttype, hostname, rhostname);
>> -
>> -	case 4:
>> -		gethostname(hostname, HLEN);
>> -		write(p2fd[1], "1", 1);	/* tell p2 to go ahead and sethostname */
>> -		zeroize(rhostname);
>> -		len = read(p1fd[0], rhostname, HLEN);
>> -		gethostname(newhostname, HLEN);
>> -		if (strcmp(hostname, newhostname) != 0) {
>> -			tst_brkm(TFAIL,
>> -				 NULL,
>> -				 "test 4 (%s): hostname 1 %s, hostname 2 %s, should be same",
>> -				 tsttype, hostname, newhostname);
>> -		}
>> -		if (strcmp(hostname, rhostname) == 0) {
>> -			tst_brkm(TFAIL,
>> -				 NULL,
>> -				 "test 4 (%s): hostname 1 %s, hostname 2 %s, should be different",
>> -				 tsttype, hostname, rhostname);
>> -		}
>> -		tst_resm(TPASS, "test 4 (%s): successful", tsttype);
>> -		tst_exit();
>> -	case 5:
>> -		write(p2fd[1], "1", 1);	/* tell p2 to go ahead and sethostname */
>> -		zeroize(rhostname);
>> -		len = read(p1fd[0], rhostname, HLEN);
>> -		gethostname(newhostname, HLEN);
>> -		if (strcmp(rhostname, newhostname) != 0) {
>> -			tst_brkm(TFAIL,
>> -				 NULL,
>> -				 "test 5 (%s): hostnames %s and %s should be same",
>> -				 tsttype, rhostname, newhostname);
>> -		}
>> -		tst_resm(TPASS, "test 5 (%s): successful", tsttype);
>> -		tst_exit();
>> -	default:
>> -		break;
>> -	}
>> -	tst_exit();
>> -}
>> -
>> -int P2(void *vtest)
>> -{
>> -	char hostname[HLEN], newhostname[HLEN];
>> -	int len;
>> -	int testnum;
>> -
>> -	testnum = atoi((char *)vtest);
>> -
>> -	close(p1fd[0]);
>> -	close(p2fd[1]);
>> -
>> -	switch (testnum) {
>> -	case 1:
>> -		gethostname(hostname, HLEN);
>> -		write(p1fd[1], hostname, strlen(hostname));
>> -		break;
>> -	case 2:
>> -	case 3:
>> -		len = 0;
>> -		while (!len) {
>> -			len = read(p2fd[0], hostname, 1);
>> -		}
>> -		gethostname(hostname, HLEN);
>> -		write(p1fd[1], hostname, strlen(hostname));
>> -		break;
>> -	case 4:
>> -	case 5:
>> -		len = 0;
>> -		while (!len) {
>> -			len = read(p2fd[0], hostname, 1);
>> -		}
>> -		if (hostname[0] == '0') {
>> -			tst_resm(TPASS, "P2: P1 claims error");
>> -			return 0;
>> -		}
>> -		gethostname(hostname, HLEN);
>> -		picknewhostname(hostname, newhostname);
>> -		sethostname(newhostname, strlen(newhostname));
>> -		write(p1fd[1], newhostname, strlen(newhostname));
>> -		break;
>> -	default:
>> -		tst_resm(TFAIL, "undefined test: %d", testnum);
>> -		break;
>> -	}
>> -	return 0;
>> -}
>> -
>> -static void setup(void)
>> -{
>> -	gethostname(oldhost, HLEN);
>> -	tst_require_root();
>> -	check_newuts();
>> -}
>> -
>> -static void cleanup(void)
>> -{
>> -	sethostname(oldhost, strlen(oldhost));
>> -}
>> -
>> -#define UNSHARESTR "unshare"
>> -#define CLONESTR "clone"
>> -int main(int argc, char *argv[])
>> -{
>> -	int r, pid, use_clone = T_UNSHARE;
>> -	int testnum;
>> -	void *vtest;
>> -
>> -	setup();
>> -	if (argc != 3) {
>> -		tst_resm(TFAIL, "Usage: %s <clone|unshare> <testnum>",
>> -			 argv[0]);
>> -		tst_resm(TFAIL,
>> -			 " where clone or unshare specifies unshare method,");
>> -		tst_resm(TFAIL, " and testnum is between 1 and 5 inclusive");
>> -		exit(2);
>> -	}
>> -	if (pipe(p1fd) == -1) {
>> -		perror("pipe");
>> -		exit(EXIT_FAILURE);
>> -	}
>> -	if (pipe(p2fd) == -1) {
>> -		perror("pipe");
>> -		exit(EXIT_FAILURE);
>> -	}
>> -
>> -	tsttype = UNSHARESTR;
>> -	if (strcmp(argv[1], "clone") == 0) {
>> -		use_clone = T_CLONE;
>> -		tsttype = CLONESTR;
>> -	}
>> -
>> -	testnum = atoi(argv[2]);
>> -
>> -	vtest = (void *)argv[2];
>> -	switch (testnum) {
>> -	case 1:
>> -	case 2:
>> -		r = do_clone_unshare_tests(T_NONE, 0, P1, vtest, P2, vtest);
>> -		break;
>> -	case 3:
>> -	case 4:
>> -		r = do_clone_unshare_tests(use_clone, CLONE_NEWUTS,
>> -					   P1, vtest, P2, vtest);
>> -		break;
>> -	case 5:
>> -		pid = fork();
>> -		if (pid == -1) {
>> -			perror("fork");
>> -			exit(2);
>> -		}
>> -		if (pid == 0) {
>> -			if (!drop_root()) {
>> -				tst_brkm(TFAIL, NULL, "failed to drop root.");
>> -			}
>> -			r = do_clone_unshare_test(use_clone, CLONE_NEWUTS,
>> -						  P1, vtest);
>> -			write(p2fd[1], "0", 1);	/* don't let p2 hang */
>> -			exit(0);
>> -		} else {
>> -			P2(vtest);
>> -		}
>> -		break;
>> -	default:
>> -		tst_resm(TFAIL,
>> -			 "testnum should be between 1 and 5 inclusive.");
>> -		break;
>> -	}
>> -
>> -	cleanup();
>> -	tst_exit();
>> -}
>> -- 
>> 2.35.3
>
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
