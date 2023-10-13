Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CA7CDB482
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 07:09:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A1BB3CD3A4
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 09:09:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 848093C8767
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:08:50 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D991D100B7BA
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:08:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDt59TGtPuPyAUWyT0FUcNsh0XbdjhBVpJ+Wmnh0GQWRqFEdCTwFU3n1AaiyAYb4vXHJAlPrItjUEcfzy28z4qrElE8bEftD1vntSeaRjLotXDfRwEwhCVV4DL4aiSrKQkAQoGo7p0tb+vep1QOzVosU1P2GHjIvtnhgBCpQZ9jDOwZ57KiFxaE2Ec8ShLtpp4X+4oXv1+ndrKYTVNv9HctWPwRfMvsY18/RI/y0zmhEvDp1Ogh1p+sI+WxUISNT89Ak1V3koMZdmmOSkpgTkVptnGaYTXc00bzNtPsjq+Wz8H1iRPXvRQ9YLG1nzA/HfQqLUSjbwj+JRq2knMnkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbVRjeUrY11jUuskY2zVpppXL5IDaU5rMEIqwFZMqI8=;
 b=IzrChwBx6Im1Fu8a4U60Ku9SRXfS+iNP0L+qGNdZ3HaD9Gncfa+hi3CrxQkieouJWphGW7sZtXta3unWm17g/RsvPPlpETzf9ErgZ8FpPeoOi1a3B3e0zeRFMCbWS0cBBgBdwdbOBC8h9CM9QVMWCzYsAvbzvo8E9bXz/qKCGfpwShks1Ay0+aAsvdxga23MGKI8YiJNFqqcsat7rEKvo2FbLaOad3TeiEJoS55s3QSue4rIluDdi1MkW7lM/W8LUdlCRWSgCO068ipperVReSPRbocQVOmmB70s4AliMivNMk3yIvtBYhP3paKEldw8p23STp5Wfe9Eop8qHDYgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbVRjeUrY11jUuskY2zVpppXL5IDaU5rMEIqwFZMqI8=;
 b=QzT5tGjOInqjJUxLnV3m4ZgQ8HXOPV1a4cHoaTmKKKlQ6SzrPHAOIKxyw91Y5qHMQUsUYLlJS0BPSVtvBltb5I8K9NbY7uAz+fB+KZKvTC4t3wqDKHXPQBCJk+vlp5d16jeJDLHE3ExvOHpR4vfiYxIlzLmUq4cw27SGBExULt1PbIVDJ04qnvbAPrNnoyVXxAiGlNbaYXNG6dTrYbXv8zR5j1rHhKVrQbqEhu5QlvSRo6gWtdkrQ+K+OFQMOYWH8SPIRxrvgJaAZZ+nj0gKOXL+r67sbdnWXQeLouiC5k3izlCTjPaddSCVRHbtr/nVDgWyfpYp3kvD8d7VG2gQHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 07:08:46 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 07:08:46 +0000
Message-ID: <9a4988b5-c450-4180-8f0d-3e12994b3e74@suse.com>
Date: Fri, 13 Oct 2023 09:08:44 +0200
User-Agent: Mozilla Thunderbird
To: "Wang, Xin" <Xin.Wang@windriver.com>
References: <20231011025323.1558560-1-Xin.Wang@windriver.com>
 <ZSZhNWqK-MvqWHHA@yuki> <30ac1949-383f-435e-8cff-fbba05d7d011@suse.com>
 <CO1PR11MB4979F807935CE7F35073947695D2A@CO1PR11MB4979.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <CO1PR11MB4979F807935CE7F35073947695D2A@CO1PR11MB4979.namprd11.prod.outlook.com>
X-ClientProxiedBy: VI1PR0102CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::49) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DBBPR04MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6e4eb3-0b39-4518-83d5-08dbcbbb3dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5HbhPfISdWzosxUkq4UUWc2ob1Of1umoA6rTHTCJfOQt9J70uNSvNDHs5FRwKlWxBtAPFHNLex0fFlOxWJP948sibFWbHSO6lD2FJpnhZkEyMjj4YCM6oVf+TgJkk51+W1TbsTCoepQpiRy9Fdz53JUpimAQAwH5gvZQr/Vx0nBWnE9rRfRXe8fGvAVEJgKH96Ygvm2lEUz6q4M4v1/i8Us6Q3Cjp5Qpw8952H36BYTpKSiWgLQzjTebb4N+LzCHEoCllZNrFTqPZgvb3GHJtBwEY0iz3OzG/c0zxEqXQvdz5x5IknO/yy+Nsx+2PnpLOAb2gHk2ThhQ5FzknSsqdQZ9rjGtBA2I0mLUXJglAY9G1fzQVlxz4yakylJ3sK7yk7fJwgUNPwxAcKV37mGAnjiElWkNqjqksTafEqtlLSaBt/4WH9XIa+VNTHVsgKBvdZkLthSXhyNgktVC3NiCO328puI+OWm7M5FTUXLTGZYf6gmXcfafLsbjzQ1BkqxCPRV/RD9sxc/JzQoffSvwyoGQepKQqy0leDW71MlJUwS//iS1D1K6riqLIGwMrCb/sJQjJYsTixoFid61y9REnVDDdI6MHgbKMTXO99V9wyHVyaE6a2DP7wS42yKdA9KBTO8B6HJNZPY4ECfYSHlCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(44832011)(966005)(8936002)(8676002)(6512007)(5660300002)(6486002)(478600001)(38100700002)(41300700001)(6506007)(53546011)(26005)(2616005)(4326008)(316002)(66556008)(66476007)(6916009)(31686004)(66946007)(83380400001)(2906002)(36756003)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWo0MFFzYmxwRzQ0STdOaXFTQ3BmN0lOMkJMbVFEVzhGZFovM3dYQXh5UGFG?=
 =?utf-8?B?bkpLR0lGU2ZVb3F6VDh2OVc3MTRCd2xNVUVYM29nS0VacFI5cXFhSXQ5eVJS?=
 =?utf-8?B?cGFqNFdVcktjTmlkNFNNZjlhQnJRVmQzMDZZTDZmb28zYWViMVJCaDJ5bFRi?=
 =?utf-8?B?aS9MYnRiR0JTYi9YS2VldS95Ky9jSW9lbzlheEpJMUg0ZjVia2RIMksvaUFC?=
 =?utf-8?B?M0VQb3BDWmdkenVyMkdjL1lGWitMZTBpVlczaG1BdVRPV2Y5ZFFReVZoNTgv?=
 =?utf-8?B?ZzZuMVoxZVNvOHRpb2ptbTMxWlRQN2VMMmJyc3djMCtHeEN5WEd2Zy9MUTNF?=
 =?utf-8?B?N0t0U1dUSnNEVS9jZWEweDNwd3E5dzllWEpHcXhlUERWOHZ2Vk1jR3lZK2lp?=
 =?utf-8?B?SG1wanRZQXhlanhydjVVTFMxekpLSm9DeEpJYnJIRTBVeHR4bThraHJoemFG?=
 =?utf-8?B?K1BTR3BOSE5oQ0ZFdElValJQeWw1Y2ZMSVdrMFR5RWVVMDB1NHE0c3pWcWdG?=
 =?utf-8?B?SHpmd3o1cUNIT2hQeUo4d01pdU1pQURSR0lEVnJPUlZ3YUlMOVk5M1ZxY016?=
 =?utf-8?B?YjlwWXVJaW5zSE1lVXpDSGF5OTBucFB3TVNFTUdyL1UrcHNCY3FPT1AzY1R2?=
 =?utf-8?B?OTdVblgrMzJLc2hLNDBrM0xlRFc5Q2xUbTNOUjBQNWRUUk5RZU05OEp4YXND?=
 =?utf-8?B?UVE1WUllZ0VJajF5WlZLZzRGRHRsNUpHaDQ4ZnRQODFEd3hRdTRQSWdVV0ZZ?=
 =?utf-8?B?L0hHUXpiOGdsaXo5TjdDOSs2NnV5NldnVDBpdnFFTjRINmUyNFBQaGNoVThF?=
 =?utf-8?B?L2kxZW5wMWl5a2JZS1JvYmphRjVtYjJsWVZxZEpwbzJ2enlWczUzNzQvRFc2?=
 =?utf-8?B?MmNOMjBrU3RJUitvYmdXL1N2QnNFT1ZIUjVybnN2NVUrSmhVZ1dHL01hVE9t?=
 =?utf-8?B?V0trS29iaTFxMkpnOVc1UzJ5dTBwL1BsM2lMaHhNb0JSUHY4cmtFc2JRMGYv?=
 =?utf-8?B?OTN0N2szdFlXbXViR1M1cjFwd2ptYmowZFdYZ3NTKzJsTGliRTk5YTBaZ2xj?=
 =?utf-8?B?Q0h0bnNzbWpjTVJianNhcXAwOG9rZ1lXeWw2bWlBZm4yT25DL0hDZ1dPQjBU?=
 =?utf-8?B?SEsvalZDZDdCWS9yamZPeGFLY2tCL242TlZzWGh6MlphQTA5L3ZJbjRHYUp5?=
 =?utf-8?B?a3o5eVNNbW11TFBWbEh0UFpZU2IvZ24xVWYyTjdDOTlGQXJHbzU1VEVlSVN3?=
 =?utf-8?B?bEI2ekRVVzNzOGs0NCtJdDlmSGRQc0MvckdkcTZJbFo0UXl5YmVqQi9xWVpp?=
 =?utf-8?B?UlhyU2NlWFA2RG5tdUxCQW1NYnorOEk5ZDJYZ2s4TVY2dnBzRWZGMFJJRVo2?=
 =?utf-8?B?OWIzc0pQMjdwMklXbVowM0QxS1J6b2RoejlpT1hhdjZrMWFSaHZwbk5NcjQr?=
 =?utf-8?B?MUs1UkRNUXZsbEhuNFYrUHFFbFpFVHBWNm03bktNZVNaRFZqSTJRUWdjRXdB?=
 =?utf-8?B?ZC9YMDlvaWdaVC9McEFGZmlsTVpxbjFnanhJZi9IOFhNS3VuVlhSd2plQzdw?=
 =?utf-8?B?SXJudmtoUVlYZm9yeUo3ang0THNXSkMrV2Q5cUxIQjlKTkRtZSswa3RRa1o1?=
 =?utf-8?B?UUdHekVLSFdrSGc5d1IwSkNmZ2hVWkxQSFljVHNqQUhQeGtNdTVvcXhTUzJK?=
 =?utf-8?B?NlZPOCtheWdPOUlQSWJpTW51eDNBM1JFU1NKdG1FdjZFK1ZKd29pTnRUU0Jy?=
 =?utf-8?B?cG9na0JUVmo3c3p2ZlMyNWJMb0VaY3grcXVJbXhZYk9XQ1E5MEVaR0xPaXhr?=
 =?utf-8?B?TEFGQ1IzaEdhUzFYM1FZSGlacmNvVGhIZjRBUnhvd0h3WkhOcFdSWWlnNXNN?=
 =?utf-8?B?RWhncDdnY09XTFJ4T1RHRDRJZWZ4Y0hoVWd1TVdvbFYxS3liTnI3K1ZuTHFv?=
 =?utf-8?B?WnZBWWlQVUduRkZFY2xVUzRnMGExRGdnTklNQ1FVKzZlYm51VU9jVkUyRkM3?=
 =?utf-8?B?ZTBvbVlHZ0xOc2o2WlcvMm4zdTdZUEZoN3JwQjhLZ3NmNW1Ga2owcnY2c0Fn?=
 =?utf-8?B?NUMxTFJ3SlhRZjVON09hZVYvdG5aN1Z4ZE5tTWYwa0oybld6VGRINGw5dVph?=
 =?utf-8?B?RlNPMlZoaHVLN1o3Y3g2RTdnTng4MEcxZ1V0YXNXRjJSM0RBQlJsblEyT3Q3?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6e4eb3-0b39-4518-83d5-08dbcbbb3dbb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:08:45.9863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60L1WCcA5mkociM5J7Of5Dk0yd56eHEZmRMZr8LYOAshTJaoVeaLDn2tSlkChzg1Q0/Pkn+wklvyuq6n9mSwHSkxlqu5NRW9XsuW0925rt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] enable fsx-linux.c running on VxWorks user space
 and add measurement of execution time
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 10/13/23 09:05, Wang, Xin wrote:
> Hello,
>> Hi,
>>
>> On 10/11/23 10:47, Cyril Hrubis wrote:
>>> Hi!
>>>> I come from Wind River. We and our customers used fsx-linux for file
>>>> system testing on VxWorks user space and total execution time also
>>>> received more attention in the testing.  So I upstream the change of
>>>> VxWorks compatibility parts on this patch, wish to enlarge the test
>>>> support of fsx-linux.  There is a point need to explain, because
>>>> current VxWorks doesn't support CLOCK_MONOTONIC_RAW ,
>> CLOCK_MONOTONIC
>>>> is still used by VxWorks when calling clock_gettime.  When
>>>> CLOCK_MONOTONIC_RAW is support by VxWorks in the future, this part
>>>> will be removed.
>>> Actually Andrea started to clean up and rewrite the test so that it
>>> uses LTP API and he will send a patch soon, can you please send a new
>>> patch once that rewrite is finished?
>> My 2 cents: I would go the other way around, since I'm busy with different
>> things and it won't be available that soon.
> Thank you, I could wait for fsx-linux rewrite then send a new patch. Do you have a schedule for fsx-linux rewrite?
I can't give a schedule at the moment, because I'm busy with other 
things. It might take a few months, considering review process as well.
>>> A few comments below.
>>>
>>>> Signed-off-by: Xin.Wang@windriver.com
>>>> ---
>>>>    testcases/kernel/fs/fsx-linux/fsx-linux.c | 44 ++++++++++++++++++++---
>>>>    1 file changed, 40 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c
>>>> b/testcases/kernel/fs/fsx-linux/fsx-linux.c
>>>> index 64c27a0f5..2064fac16 100644
>>>> --- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
>>>> +++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
>>>> @@ -39,8 +39,10 @@
>>>>
>>>>    #include <sys/types.h>
>>>>    #include <sys/stat.h>
>>>> -#if defined(_UWIN) || defined(__linux__)
>>>> +#if defined(_UWIN) || defined(__linux__) || defined(__VXWORKS__) #if
>>>> +!defined(__VXWORKS__)
>>>>    #include <sys/param.h>
>>>> +#endif
>>>>    #include <limits.h>
>>>>    #include <time.h>
>>>>    #include <string.h>
>>>> @@ -849,7 +851,12 @@ void domapwrite(unsigned offset, unsigned size)
>>>>               gettimeofday(&t, NULL);
>>>>               prt("       %lu.%06lu memcpy done\n", t.tv_sec, t.tv_usec);
>>>>       }
>>>> -    if (msync(p, map_size, 0) != 0) {
>>>> +#ifdef MS_SYNC
>>>> +    if (msync(p, map_size, MS_SYNC) != 0) #else
>>>> +    if (msync(p, map_size, 0) != 0)
>>>> +#endif
>>> It would be better to define MS_SYNC to 0 on VXWORKS instead.
>>>
>>>> +    {
>>>>               prterr("domapwrite: msync");
>>>>               report_failure(203);
>>>>       }
>>>> @@ -1115,11 +1122,16 @@ int main(int argc, char **argv)
>>>>       int i, style, ch;
>>>>       char *endp;
>>>>       int dirpath = 0;
>>>> -
>>>> +    struct timespec time_start, time_end, time_diff;
>>>> +
>>>>       goodfile[0] = 0;
>>>>       logfile[0] = 0;
>>>>
>>>> +#if defined(__VXWORKS__)
>>>> +    page_size = (int)sysconf(_SC_PAGESIZE);
>>> We can just use sysconf() everywhere instead.
>>>
>>>> +#else
>>>>       page_size = getpagesize();
>>>> +#endif
>>>>       page_mask = page_size - 1;
>>>>
>>>>       setvbuf(stdout, NULL, _IOLBF, 0);       /* line buffered stdout */
>>>> @@ -1267,9 +1279,12 @@ int main(int argc, char **argv)
>>>>       signal(SIGUSR1, cleanup);
>>>>       signal(SIGUSR2, cleanup);
>>>>
>>>> +#if defined(__VXWORKS__)
>>>> +    srand(seed);
>>>> +#else
>>>>       initstate(seed, state, 256);
>>>>       setstate(state);
>>>> -
>>>> +#endif
>>>>       open_test_files(argv, argc);
>>>>
>>>>       strncat(goodfile, dirpath ? basename(fname) : fname, 256); @@
>>>> -1336,12 +1351,33 @@ int main(int argc, char **argv)
>>>>       } else
>>>>               check_trunc_hack();
>>>>
>>>> +#if defined(__VXWORKS__)
>>>> +    clock_gettime(CLOCK_MONOTONIC, &time_start); #else
>>>> +    clock_gettime(CLOCK_MONOTONIC_RAW, &time_start); #endif
>>> And here it would be cleaner to define the clock to use instead of
>>> ifdefing each clock_gettime call. I.e.:
>>>
>>> #if defined(__VXWORKS__)
>>> # define CLOCK_ID CLOCK_MONOTONIC
>>> #else
>>> # define CLOCK_ID CLOCK_MONOTONIC_RAW
>>> #endif
>>>
>>>>       while (numops == -1 || numops--)
>>>>               test();
>>>>
>>>>       close_test_files();
>>>> +#if defined(__VXWORKS__)
>>>> +    clock_gettime(CLOCK_MONOTONIC, &time_end); #else
>>>> +    clock_gettime(CLOCK_MONOTONIC_RAW, &time_end); #endif
>>>> +
>>>>       prt("All operations completed A-OK!\n");
>>>>
>>>> +    if (time_end.tv_nsec < time_start.tv_nsec) {
>>>> +            time_end.tv_nsec += 1000000000;
>>>> +            time_end.tv_sec -= 1;
>>>> +    }
>>>> +    time_diff.tv_sec = time_end.tv_sec - time_start.tv_sec;
>>>> +    time_diff.tv_nsec = time_end.tv_nsec - time_start.tv_nsec;
>>> LTP has functions for operations with timespec, here you should use
>>> tst_timespec_diff()
>>>
>>>> +    prt("Elapsed Test Time %lu.%09lu\n",
>>>> +        (unsigned long)time_diff.tv_sec, time_diff.tv_nsec);
>>>> +
>>>>       if (tf_buf)
>>>>               free(tf_buf);
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>>
>>>> --
>>>> Mailing list info: https://lists.linux.it/listinfo/ltp
>> The whole CLOCK_MONOTONIC_RAW problem is mostly related with test
>> logging messages, which is something we will get rid in the fsx-linux rewrite.
>>
>> Regards,
>> Andrea Cervesato
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp

Regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
