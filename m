Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E2DC7618E
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 08:33:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 683AD3CB306
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 10:33:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3035B3CB306
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 10:33:25 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F3AC4100093A
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 10:33:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJZ4KlS2wPcv/r6qKCwDrd2qPtoCeiNSU8LjxESY4WkTInxvjV8Y3EKjRko7fB4FK7XW5UqLFUhgBkq/Ak//DYSj55ZVPuuVTw8ef6EaF12CknQOnuKC4w6nVPCDzZeRwnbFLW55f8EwT18IyCNB0tEw1LW10Ge/TiNZQdG9UWc5hWIzBPpOtZWADBlnmeOS56LuThNtPttZG2f/p4Vluaz53xObYc018domfKKqeR+zwTPFmC90+i7dYMLxrPXrfdOgx0Lzv4hsNdsVEtVcChVft2C5fvcuN+KdlqsnfyGnQs157X3AIgwBhmwK5j0413sT7vEpw79FV8/QiM/5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+TL6JFsy/OU3TAF38m6K6Ooc9RZY8zH/mu5gzj5PS0=;
 b=HesahN5ZbQD396CpfiSLP8WAQr9VVw2Mef+Iv8UPvIMM/2Gvi8yfWPyoYTv12egiM/846TekmuTNFjKqoWnohleNSZ7aUXOs8LT2OqyPCPEbs3dTr47QA8RsEIRYCs9uvOqtfVXfF0QC0MnHBtrOmNrf+ZvNEjBEHMiICwy3vweDy3MTxIaGewYsLGk5dPpew7U7huwI4gelrOrRrohlAW18pagdv7ZbvaWBx6wE76By9mvFfM3iEtbWmTSSbvdzEFNXy1v1m2CM81vrXCIJATfFMb1UYHoRWOS58kxj4jctZ39jcd+PpPR/TJXTuVMxRC15kfaKwo9jhZT/JNUvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+TL6JFsy/OU3TAF38m6K6Ooc9RZY8zH/mu5gzj5PS0=;
 b=bZG8ArdQdmYKsSfxhiOsIHM7hAKQT1gPjl6LNEHX09FieMgJC6Xb26gIeQQL1LN2MG75/j4MW75Pvy1rxeLIsHiiIP6F88RLmAWYIE2+8cpfs9DRDHu6eiH4a6FW8VBlS68FzYC9yC0s6AtSA+L1F39Gbr/VqCIjJJwGkWiMHNG1v+jq0alDOMvaTzZABp0iYBEYQHxzWK+jnGN+RKD1jCsJBmK1TRDv27SVxqyz8ojHma055oDMZJoI4er3GzOCPZmfL4/AM2LSCUynVbV+RQbLBFkzJrY+1J8T2DyYpzAg9GB/lRJ8feo2XxhYg7UmZ5GS+5F4RkpmQVWAgBa//g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAWPR04MB9815.eurprd04.prod.outlook.com (2603:10a6:102:381::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 08:33:22 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::54ce:4ff6:8295:1c06]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::54ce:4ff6:8295:1c06%3]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 08:33:21 +0000
Message-ID: <827cbeda-719f-885c-f230-b6e2e248665f@suse.com>
Date: Wed, 26 Apr 2023 10:31:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230426074950.8807-1-andrea.cervesato@suse.de>
 <ZEjgPy7kJbUG4r1W@rei>
Content-Language: en-US
In-Reply-To: <ZEjgPy7kJbUG4r1W@rei>
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAWPR04MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: 41618f47-b7e6-49e6-726a-08db4630e477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itNYtQzNrBl7CLO+JP/VpYxgX1Q6Dw8cJJNsSnAOtbfhhZdugpv2+pthGihY0XljbANDM9M//5bDPCcRb2gf1V5uId0UFMCTd2QVbkVdZHrxxDH4BreQf7L1Pf595Hc6tC78NOvPJYY4sPjUVoaGschmNwVV91QC9FUlyvjeQqTw9fT/pQfUCpggQrID1dg4Yuii7IGJF6c2KmRVUKysA+XYAh5SGLuesw4jJoU3+DKXCi2tv2d86GWYEP4epmMuQFs9wGYq+VKr7jtbDLuvlWA7ZANDudfcnjsVRqYdcVplZnE4OkKxhht+3V1DScTwXWz8SerEWUydryPXw0UpLzsLYc4KEWAUPG3Tu3M/rV8tXuipTRU+orJBY3t5hyDZOiUM/yI4DwRUE9mJkqNEdAGytDBxqVeHIShDpGRi5QEOmH42XPqBvcicrHP5nagqBelUoSa4Mf4J/GBsGmbBkBFQBuOR5PPcM90PyZyPYb1bMoIm6Uu82WIA8py+HPMlF9X9DM40tPaMNdEJct+wOthOwZVXL/sAxZycfVThBI6Wvdjieq4cZTOfJPkOoJAPUptmNCdv/crOrQXBhLt4+RiOx0Q+SKOL2eQPUXygyUFAYCLZdzNWHbGVQmDa/YDajE84ZgLbCc9QUFdpdjvBVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(31686004)(966005)(2906002)(6486002)(83380400001)(36756003)(86362001)(31696002)(66556008)(8936002)(66476007)(66946007)(316002)(478600001)(26005)(6666004)(2616005)(6512007)(6506007)(41300700001)(186003)(53546011)(4326008)(38100700002)(44832011)(110136005)(8676002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3FJaldmZ1NJdjRXS1hNMU9OTUVTbTkvSEJwYWFYelo4a2FNd2FqWHdTT0pv?=
 =?utf-8?B?dWFwL3BVMUxFUTFuZzJCd01LWmhqUUZqVGNjdCtGbWZiNS9CRGpNWktYWmU4?=
 =?utf-8?B?WC93aE5MRUZYYVBxRkFHSXBzSGdubHdKZ1RaOHcrQ1dIdUN5TmN1UGxzQkJw?=
 =?utf-8?B?M2tub0RuMVowWFRXL1VVU1lodURKcmVrWTJsKzlnRXpQOHZPS2xUVzdZcTZw?=
 =?utf-8?B?OVNiMDhMRmF6cXpVZ0xudjdldHZLRk9KUXpIMnd3eitDc08vczJ3c1NQOGxJ?=
 =?utf-8?B?WVVZZHh3dE9Na2xhRENXd2ViRFY4L3JpL0xtbmtXeTJ0NDBxTDlmODlvaGty?=
 =?utf-8?B?Nm5PTUwwY1dhTFYwcXMvcDZ5ckJ2VXVWcCtGVFp0YUw3V2F1Mjh1N0luQlds?=
 =?utf-8?B?RndaK2pxcGJiZ1djVCswWFZSVVNOa2FWWll1R0JVOTRxazQ3YVJna2prM21G?=
 =?utf-8?B?cGwvcDl5VXlPbDdvVmo0ek5HTk1RYm5teFpiVmxUUGhLNkhkTzkvanNiNktY?=
 =?utf-8?B?aE1DRjZOVnRGdWNuT0hyRGgzcWEybVJ5ajFJcWdvLzQvdFJkZnhPTlpiYmcr?=
 =?utf-8?B?WjVQeHlYVFNVMVFBT21uOXZCVzUxOGlBSVBwMXNKS082WjdFU0tHYlR2bmpo?=
 =?utf-8?B?WTArS3lDTFd5cVl5bGtrdkJrWERDWkFXRnBOWEJjR1dqZ2MxQnR1QmdkcnRZ?=
 =?utf-8?B?MndKVjBRR3d2U05nZnJCY05nbmMzOG5MbW1JcjhiYThzaTMvU2tnbzlVejlI?=
 =?utf-8?B?SElKQ1MzNFZEb3hLcG51eS9JUm1nNFJxVWx6R0s4Ymgwc2IzbWg0ZUxUVUF6?=
 =?utf-8?B?ZkMzN0c4aE8xSHNFMFBPUmJNK2tHbXJDVlBaUnZvcDVudXQvdVdHa1FrVGFO?=
 =?utf-8?B?YkhIY09QRUJ5M2FlTHlBaHFBd1pqMDhZUEh0a0JDRmk5dytIbFJIWEhIbU1Q?=
 =?utf-8?B?M0cvbEJ6MVhGOTdQdFlZcVpKSUNpSUFRY3JEeS9NZHZQNmF1c2FxcWxFbHI2?=
 =?utf-8?B?VUZPaE5sbEViVHh4TVJRaUlNc1hUblVtbnQvckFFN2szQTZjNFJzZXBIdjVa?=
 =?utf-8?B?dFNodFc1Tmh1WXVheFR2YjJ4dWxvczgzd0JjQUlXVXdsRUpjMDBYRnhkSi8x?=
 =?utf-8?B?UjNNOWp6czZZMkErMm91cGFJREtuQitUcndGTmtaQzVhTTJOWGFNTFJVbHFR?=
 =?utf-8?B?dWFadURyS1IvSzlSVVp3U2liTGhadFpZZURQVEh4TEhjTkRHRzkyM2UvK0l3?=
 =?utf-8?B?TWEzNEVheVN5NWI5ZnFheDJCeTRMRzRmck9qUWdmU29YeG1yVlRoNmFTc3ZD?=
 =?utf-8?B?SmcrS1NRMVdUeEhROTVDbWpaTEpQb3RYNHpTbklYQnhFekczR2hPUVZJRVNv?=
 =?utf-8?B?c0F2VkRMcTBCelN5TFo0cnVkbTNJcFRiM2hjUStvNnRuRFJGdmcwNVRTUFY1?=
 =?utf-8?B?NXFLd05BVzdtOTlpTjUyZnpjWXpYTmdmemNTcllWZHdySFZFTFdNbVpFSytB?=
 =?utf-8?B?M2k5RzVZR2Z4My9jNXN4bU43dE5FclhyRHBJaVB0eUlwYy9aYTdaa0tuU3Bz?=
 =?utf-8?B?UVE3UERreE5hNlUwelZISm1rY1RKNGNxZ1oyVXVkV2ZXUCtyTGNjTzJ2dGh1?=
 =?utf-8?B?NjczcEdDL0NkRnB1ZkhFc0lNdkd5YWxkRFRTanhlSFlUbWw0Tlp6cW5kZEhx?=
 =?utf-8?B?ZnA1ZG1NalNpSUdsVVdwQUE0ZGNVb0xmTWFMcGNmMWVNazJXdDcvb0l6NUs3?=
 =?utf-8?B?Y2dvaVV4R2U5YmNTYzl3Y1p0dVV6TExWMDM5L0JENHV4Mm40RE9lSkh1KzZ2?=
 =?utf-8?B?azM1N1ZvUURNRDVEdVRnUml0WHZiNDNCT0dFQVRKbjNWMDZra0hKelhxczAz?=
 =?utf-8?B?U2tWYjBZOUErcGMyWDVIdHhuMGkvNUVtNXNCaCthZmFOQnM2TDRmNkZudUYz?=
 =?utf-8?B?ME5RRCt5VlhHeHRXenlrRis5UTUzenZaV3ZxckZ4TDlnNHZQSXl2MU1WTDVP?=
 =?utf-8?B?YmNIZmRFdWtKUGloelR5T0wzd0EvVUJCVFhOc212N0grYWFVeUJBeVRhMXNi?=
 =?utf-8?B?NE9aNlViWndtSU0ySHV0NmpVWDkrVnpPdkpVb3ArZEYxdjd3RnhKRVhuWlpB?=
 =?utf-8?B?MFNjUGdvWnJnbllMcWNJYW1NZlh0em1GM2g0bW90elhKVUZiZFJuVmh4Q1FE?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41618f47-b7e6-49e6-726a-08db4630e477
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 08:33:21.5861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehyJQE9oisyayUnv8TSWxefo//VTmvfwYUg/05TGI2wZ0EOKzJiePGB4xbCUTRvTuJxA34UXPN3YWSvBkpO/21T7HgFa6HZSPZjTBS01lEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9815
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Support return value in TST_* macros
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

Hi Cyril,

On 4/26/23 10:26, Cyril Hrubis wrote:
> Hi!
>>   include/tst_test_macros.h | 69 +++++++++++++++++++++++++++------------
>>   1 file changed, 48 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
>> index 231c04951..acc2d1bff 100644
>> --- a/include/tst_test_macros.h
>> +++ b/include/tst_test_macros.h
>> @@ -74,45 +74,60 @@ extern void *TST_RET_PTR;
>>   	} while (0)
>>   
>>   #define TST_EXP_POSITIVE(SCALL, ...)                                           \
>> -	do {                                                                   \
>> +	({                                                                     \
>>   		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
>>   		                                                               \
>>   		if (TST_PASS) {                                                \
>>   			TST_MSGP_(TPASS, " returned %ld",                      \
>>   			          TST_RET, #SCALL, ##__VA_ARGS__);             \
>>   		}                                                              \
>> -	} while (0)
>> +		                                                               \
>> +		TST_RET;                                                       \
>> +	})
>>   
>> -#define TST_EXP_FD_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
>> +#define TST_EXP_FD_SILENT(SCALL, ...)                                          \
>> +	({                                                                     \
>> +		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
>> +		TST_RET;                                                       \
>> +	})
> It would prbably be easier to change the TST_EXP_POSITIVE_ to return a
> value instead of changing all the macros that expand to
> TST_EXP_POSITIVE_.
The reason is that I didn't want to handle every "break". To return 
TST_RET after TST_EXP_POSITIVE_ seemed like a cleaner option.
>
>>   #define TST_EXP_FD(SCALL, ...)                                                 \
>> -	do {                                                                   \
>> +	({                                                                     \
>>   		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
>>   		                                                               \
>>   		if (TST_PASS)                                                  \
>>   			TST_MSGP_(TPASS, " returned fd %ld", TST_RET,          \
>>   				#SCALL, ##__VA_ARGS__);                        \
>> -	} while (0)
>> +		                                                               \
>> +		TST_RET;                                                       \
>> +	})
>>   
>> -#define TST_EXP_FD_OR_FAIL(SCALL, ERRNO, ...)                                    \
>> -	do {                                                                   \
>> +#define TST_EXP_FD_OR_FAIL(SCALL, ERRNO, ...)                                  \
>> +	({                                                                     \
>>   		if (ERRNO)                                                     \
>>   			TST_EXP_FAIL(SCALL, ERRNO, ##__VA_ARGS__);             \
>>   		else                                                           \
>>   			TST_EXP_FD(SCALL, ##__VA_ARGS__);                      \
>>   		                                                               \
>> -	} while (0)
>> +		TST_RET;                                                       \
>> +	})
>>   
>> -#define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
>> +#define TST_EXP_PID_SILENT(SCALL, ...)                                         \
>> +	({                                                                     \
>> +		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
>> +		TST_RET;                                                       \
>> +	})
>>   
>>   #define TST_EXP_PID(SCALL, ...)                                                \
>> -	do {                                                                   \
>> +	({                                                                     \
>>   		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
>>   									       \
>>   		if (TST_PASS)                                                  \
>>   			TST_MSGP_(TPASS, " returned pid %ld", TST_RET,         \
>>   				#SCALL, ##__VA_ARGS__);                        \
>> -	} while (0)
>> +		                                                               \
>> +		TST_RET;                                                       \
>> +	})
>>   
>>   #define TST_EXP_VAL_SILENT_(SCALL, VAL, SSCALL, ...)                           \
>>   	do {                                                                   \
>> @@ -128,18 +143,20 @@ extern void *TST_RET_PTR;
>>   		                                                               \
>>   		TST_PASS = 1;                                                  \
>>   		                                                               \
>> +		TST_RET;                                                       \
>>   	} while (0)
>>   
>>   #define TST_EXP_VAL_SILENT(SCALL, VAL, ...) TST_EXP_VAL_SILENT_(SCALL, VAL, #SCALL, ##__VA_ARGS__)
>>   
>>   #define TST_EXP_VAL(SCALL, VAL, ...)                                           \
>> -	do {                                                                   \
>> +	({                                                                     \
>>   		TST_EXP_VAL_SILENT_(SCALL, VAL, #SCALL, ##__VA_ARGS__);        \
>>   		                                                               \
>>   		if (TST_PASS)                                                  \
>>   			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
>> -			                                                       \
>> -	} while(0)
>> +		                                                               \
>> +		TST_RET;                                                       \
>> +	})
>>   
>>   #define TST_EXP_PASS_SILENT_(SCALL, SSCALL, ...)                               \
>>   	do {                                                                   \
>> @@ -163,15 +180,21 @@ extern void *TST_RET_PTR;
>>                                                                                  \
>>   	} while (0)
>>   
>> -#define TST_EXP_PASS_SILENT(SCALL, ...) TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__)
>> +#define TST_EXP_PASS_SILENT(SCALL, ...)                                        \
>> +	({                                                                     \
>> +		TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__);            \
>> +		TST_RET;                                                       \
>> +	})
> Do we really need an return value from EXP_PASS and EXP_FAIL?
>
> If TST_EXP_PASS_* does not break the test the return value was 0, if
> TST_EXP_FAIL_* does not break the test, the return value was -1
Makes sense.
>>   #define TST_EXP_PASS(SCALL, ...)                                               \
>> -	do {                                                                   \
>> +	({                                                                     \
>>   		TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__);            \
>>   		                                                               \
>>   		if (TST_PASS)                                                  \
>>   			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
>> -	} while (0)                                                            \
>> +		                                                               \
>> +		TST_RET;                                                       \
>> +	})
>>   
>>   #define TST_EXP_FAIL_SILENT_(PASS_COND, SCALL, SSCALL, ERRNO, ...)             \
>>   	do {                                                                   \
>> @@ -200,20 +223,24 @@ extern void *TST_RET_PTR;
>>   	} while (0)
>>   
>>   #define TST_EXP_FAIL(SCALL, ERRNO, ...)                                        \
>> -	do {                                                                   \
>> +	({                                                                     \
>>   		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL,              \
>>   			ERRNO, ##__VA_ARGS__);                                 \
>>   		if (TST_PASS)                                                  \
>>   			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
>> -	} while (0)
>> +		                                                               \
>> +		TST_RET;                                                       \
>> +	})
>>   
>>   #define TST_EXP_FAIL2(SCALL, ERRNO, ...)                                       \
>> -	do {                                                                   \
>> +	({                                                                     \
>>   		TST_EXP_FAIL_SILENT_(TST_RET >= 0, SCALL, #SCALL,              \
>>   			ERRNO, ##__VA_ARGS__);                                 \
>>   		if (TST_PASS)                                                  \
>>   			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
>> -	} while (0)
>> +		                                                               \
>> +		TST_RET;                                                       \
>> +	})
>>   
>>   #define TST_EXP_FAIL_SILENT(SCALL, ERRNO, ...) \
>>   	TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
>> -- 
>> 2.35.3
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
