Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B08EC433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 11:21:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E54B3CAEA3
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 13:21:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 916B43C7319
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 13:21:09 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 84DF41A00351
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 13:21:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apVJXM5IL17ZIcyVkPibSlVMUtUxoSbu7qROqbqb0GJ6wCoou3TVyPPjan9fnkmjN6+bOgCVb8WjZNq9nt15ES2oCWxKIm7zNdUiOOUOm6rE4FdEx7SoOBzonTI2iPsh6hoygtPUld8/UM3pRceEELZZWl7y71YUzkBkDgFXsACQqWLJura4n/sBkGSpA1rFQfYIXqjD6VN1ilpCcbxLU21Uh0w03P2c58E7zdGJ4FOO5thMedjMrb7ztGy2lVHGdLm5euzyysjj9+XRk1YGOMWrFgruY1KmPeYHQ17xaseYAbN2qzHrAdm/9ZzMl/V30uv/8CLZeBw5OVZSdp1S6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+fsl81vRi/n//Y33pWCUOoHfiqUNFk6T2XPbA8plXo=;
 b=N2SIeY9LsWYUtu7kKoletzJgp+zC8CR0m+akxJy62GpdCrhQ52Vgx/roSFs5ZxJ7z9GIW91wdTYmeqCgDTIyZfiwbitAbJO0qfG1zD+DpkgZByta9+V8GZW7mflBaYvzGr0w2SsisbLHlclhGFwkVlNV8LTcag/f72Dn0+/yWWVgPSy0H2p3Jqb3YpBD8CkwHny3VmP75bpxRq0fBL37WxDjVwoSi9Wb0IMK7IOYBH0Kud1IcUhD3VXXGuozuLq2WxRd6TifBQ7jPsxPcKezZHf4510QboxX5oec1t/70opnK0Gmw04mbO7fPZK+QRN5FqGa8K0oF4QB/k9LLiNKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+fsl81vRi/n//Y33pWCUOoHfiqUNFk6T2XPbA8plXo=;
 b=CqZ9wVl7yKBVJIjFXAGK7x2f5skEI3tT0aSvIxXOEa3+EcL+ptlRjJHL4vkKfD5gdz3E0v9NoPlTlFVmmmIWaKkTdorEgubJ/51+58pEv+GVhi9rwLdjm8l773ezLD7/QLayLdn7Vvbp5BHfjZmzAyAfAzSCNJJZ6WeydKYRNK38kVt48TGnQpzeCpPL849gNKpBF4W0BE7BVrDFjHD/pBKen40nrG2KM266o6ZvRmfU+SVPtjU1MCyOzUmvD9C4RjcVQkh8ncvnKjd1WET150nVYA5CnX+wd0gYf9zLkiKvgGlt33QNHTQQc9+0di90BQUHeDqoXsQrEmZ+DlW0Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DBAPR04MB7414.eurprd04.prod.outlook.com (2603:10a6:10:1a0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Tue, 11 Oct
 2022 11:21:07 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399%6]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 11:21:07 +0000
Message-ID: <f48d46d3-e4fc-f94d-db11-b45a5d94c7f9@suse.com>
Date: Tue, 11 Oct 2022 13:19:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20220722120501.28670-1-andrea.cervesato@suse.com>
 <20220722120501.28670-3-andrea.cervesato@suse.com> <87r11nw0qv.fsf@suse.de>
 <945eb0ee-b346-5729-3dda-4bff39bb52d9@suse.com> <87fsha2lge.fsf@suse.de>
 <87czay90fl.fsf@suse.de> <f072f40a-476d-f07c-a79f-d453a2436bc6@suse.com>
 <87edve7h2m.fsf@suse.de>
In-Reply-To: <87edve7h2m.fsf@suse.de>
X-ClientProxiedBy: AS8P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::31) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DBAPR04MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: afe00507-c8b2-48eb-ec08-08daab7ab0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIwL4cgHbF1WFXn5Zsbd15TGfMzJxokAXxhOCkUYoiROWkosO/CzNgmH9HRkpI0RyuxOW3Ccojt3A0fguePAwVvePr2+/I6c/IqJGMTHbZRQ+zaR9BhnDXsQQYqe+iCACxemboPIpYMumabrrsvGD2//PnJ6odPI7DxhCKdD3Ls2iB+LPW/a/h/MpkWppmVwcqYzo7xDI90SiZyvUfsmENA10IdqTfpEff1HNoyEUra7Ftz/GXK9zMsphvegb9677rZC+1NRsSkzGyQGz12P/wHftI7sEMZHAK9HDQymgvwdSLC8ovwvtwiChip527x15N6FvvqEiSHbpbdqEaWlbSvQBQJgdx8GyqG7qb/DHGvKmMwh8KBsyMZy391DN5PdKgmiRuWCnwwZhsUJvYi/x1v0Kf2vS9HLVTx+DKzFYu01dsrHL2QpVRpPqx1m6suVmrA4uy6R8I12I8ZOdpRvuZYn2RV3obLfQTDoUL7yMTq7BnV7Yz9Q5Qy9NNZgKVjDh9WenlcJ62uSC149RG5TieApRCbm9Ru4Il/FwX8Y2MJhuINOGWmowiUm1zl9XMC/ybpgPwmfC35h0esvq3cv9M0AkGNHfKrQeXYWT1SG9ZF5VwR4ph7p1VfHFEA7A/qaXysQpov8sOf/uRDaE4/Kk3+2+fEJVj6dj3n2P1F0Mlm30d6elAn8Yr3FIlK8eH7WQ9i9t3xu44bKV+B6p6zho+UKQ6rgox2LjMAA71yeHcCj3gypaiizZZ4ZsvyEEjCJWLy3Z2Vt9S2+p3eM5IDXOllKMonWRwb4OWYbd9r+jco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(366004)(396003)(376002)(346002)(39850400004)(136003)(451199015)(31696002)(86362001)(36756003)(31686004)(38100700002)(2906002)(186003)(5660300002)(44832011)(6666004)(6506007)(26005)(478600001)(6512007)(53546011)(2616005)(83380400001)(316002)(6486002)(6916009)(66946007)(66556008)(66476007)(8676002)(4326008)(41300700001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm5qYU5NOXRjZFMzRjA0Tm1iUzhWcDFvM1hHeXF4WVVZdEdGcWE5YUVvaVJI?=
 =?utf-8?B?cWJvZWJSc3BHRWJNTUd0ZWlrdXdyajFjUHRpY1pxSWlVVW00WE90QkNuV0J4?=
 =?utf-8?B?T0dFdDJrRU4xbHVGbVkvOFhuT2IwYnVNeGxta1B2N1dUMmpjQ0k0SVlLMXR1?=
 =?utf-8?B?QWZDZ1hyeTZYeHdsQ2F5OXdhU2wzWS91WE1BVDd6aHZFbjBXMUZGem5jTmJu?=
 =?utf-8?B?TUFnNUhqd0NvNlNRRVUwNFVXRTVlTzgrTDFGN21Ga2NWSHJNSjJ0eGR0amFp?=
 =?utf-8?B?ZURXa0hOTVNQNE1adC95c2VOcHRiRWo0aGp3Q0toNVBvcEcyWVpudVh1MFFw?=
 =?utf-8?B?R1NYVE9PRHd4Qi9meG5hdTdmckdPMjFXUHByYlE5WjZDbXlEUTNoMHg4bW9Y?=
 =?utf-8?B?bjJIeTJzdG1lUjAyazBqNjBEQ1ExTmN1dkFnZVVEQnZ4QStMREtQZXNwSTlY?=
 =?utf-8?B?bHZmVHdEM215aFlMRUI3aXdXajlPN3FIeFpuMFNWSEY3RWRLY1dsL3JjWlpz?=
 =?utf-8?B?RmFsdEtrbVB0Q3pqUUVPcnJkOVFZQjJiaVlSNlhNZUtwUTd5dFZ1RlFWWTJn?=
 =?utf-8?B?VlNwK1haK0xiZ21lSUErMGt2OWtabkMrWExrQTFyTW9oRVIvZU8wVzlUdUFt?=
 =?utf-8?B?SnQ4YktKOThBUjF0S2hJSnl5cDNvTGZTYlo0ZlNXV2czK05Uc01jMGhPK0ly?=
 =?utf-8?B?N2NDakQyN2liWXUvRDVxQ1F6WmlicWpCZ3JyZDBtV2g1TVowQTdQQXg2a1Zj?=
 =?utf-8?B?VFJaTGNvSnFEQTU0dlpDNk5ud3hBNUViSU5BK0U0dklNcHA0MVB3NlhsNFBO?=
 =?utf-8?B?ajFjM3U1KzhNTGZuNWhHaWhkdE9tY0I1dTFxL0gvSmJIbW5WVWhOd0NPL29j?=
 =?utf-8?B?dENFV0JEa090OUxvZkJTODEwMlhVcStsTVkrTTZvMDN0MVRPVGtXaCt1R0tS?=
 =?utf-8?B?MVBPWlVSUC9lcWQyUmtDVFVJWSsvNmF1bEVRTHdSd1k5VWVhQllCa3o4bzJh?=
 =?utf-8?B?U2dPK3VaNWNKS3hETnc0K1p3czN2N2JyeG14alA4SVl6MDBhODk2WllDTFg5?=
 =?utf-8?B?K2J5cTQyYVJBc2ZhN0E2MmpvbisrN01odCsxdzNHN0JFaUliWnBBVFEwVTNZ?=
 =?utf-8?B?RTNQbkNWemJXcWh2bm53MlVUN1lpYitkM3A1d05FZEJmQ2E2VnRWZzNqN1lm?=
 =?utf-8?B?ZzFwMmRsZjd3cTdhVW5Ldm0zdThKakMzeThOaXVCQi9uSThHUkJBZXM3QWMz?=
 =?utf-8?B?QzNoL3FlRVlLNzJuaXJoajJ3S0FmNmVodVErZWQvWE1KRjN5bFRDdDJ5N0NU?=
 =?utf-8?B?NDlmc0c2NVYwWUFIU01kSjJPc25DWS9RRDlNMkl1Umprem1zZjRvd0NGVXN2?=
 =?utf-8?B?R25MVEtpWTNBcTZ6QVJGZHhWRDhTQ0FXT2RMNnRpUFZRM3VGazh3cE01WnQ1?=
 =?utf-8?B?UjdodDhQM1huY2NhMFF5UzNKVDRrMC9UbFJDb3Y4ZTlSbXNHR25HK1UyVWcw?=
 =?utf-8?B?ZjNGOVk1WnpmaEhKMUlBN3NZaUszaGtVeWVocmI5R01leTkyMkhpcUxuNWVn?=
 =?utf-8?B?cjB2SndEVmxvWnpRaHVFQ05xMlRpKysvakVOTE4yOFNBRUJNbUNzQWt1YWpp?=
 =?utf-8?B?V08yL0d6NWNKZzYwamNIaks5clVjeHhTeEJXUUZKSzNGejdEc1REbHRtMVVm?=
 =?utf-8?B?aUdXYVkvT0locFhPcUdNQ25jeWF0N3ViRWlrODMxSmx5ZWluVWovaVFVVVd1?=
 =?utf-8?B?QVhMYVRyZVFBcWFuanQ2ZUNxaytuMUF3Y3VsMTVVdktaYncwWW5pakZMdHJV?=
 =?utf-8?B?UE5ES2lEVjQxYTJCS0lrbkk3RU1EK1Z1N21zeVQ4K1paWEtxbks5dkgzZThI?=
 =?utf-8?B?aVlXcndwUnJPem5JN0JoRThkYmJOUHJzQWtueGQ5eTJWL3VqLzJyaGdrVm5P?=
 =?utf-8?B?NnBDTVFVdTArYnpFS1N3TVp0SVZkcFNzbzlzVTNEMEt3aEYxK05vdzRkeFdn?=
 =?utf-8?B?OHFLQmJTUzNFRzE3dFA3SnNiL3lGZFZVVVJuWXZzMEVkSHBqYXdIOXduWGtE?=
 =?utf-8?B?QUhCN3FJYVN2bWNieGRjaElRdkpZYXRzVm12MmZFa3dzTU9TNTZTZGhtR1pU?=
 =?utf-8?Q?rOV1eyU0ypEzMpi+8Ie8wiBFr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe00507-c8b2-48eb-ec08-08daab7ab0fa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 11:21:07.0721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlFgDnKvrl7Vv3JUp0eMNQzDTTMjnRLghvMhZ6RNQZA26p0DT3vip0epbXTexSDFKI9rXJ2nhDh0B7b4TWBVlA7HyQ490PLMHicDzu3df9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7414
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/7] Refactor mqns_01 using new LTP API
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

Hi

On 10/11/22 12:49, Richard Palethorpe wrote:
> Hello,
>
> Andrea Cervesato <andrea.cervesato@suse.com> writes:
>
>> Hi
>>
>> Are we sure that we don't need this modification before adding
>> tst_clone? We can add the patch and then starting to think how to
>> replace tst_clone_quick with tst_clone in all tests.
> You're not the first person to use this argument. So it's actually
> important for precisely the reason you don't want to do it. The next
> person wont' want to do it either and we'll sleep walk into never
> replacing it.
>
> Meanwhile there are solid reasons why clone3 exists and why we should
> test it. That's possibly more important than the API conversion.
>
> BTW I could take over one of these patches and do the work on
> tst_clone? I'm pretty familiar with it.

I can take care to change all tst_quick_clone after pushing these 
patches, no problem.
If you have an example how to use tst_clone, please do so. I will repeat 
the same patter to all remaining tests. Thanks!

Andrea

>> Andrea
>>
>> On 10/11/22 11:17, Richard Palethorpe wrote:
>>> Hello,
>>>
>>> Richard Palethorpe <rpalethorpe@suse.de> writes:
>>>
>>>> Hello,
>>>>
>>>> Andrea Cervesato <andrea.cervesato@suse.com> writes:
>>>>
>>>>> Hi!
>>>>>
>>>>> On 8/11/22 11:53, Richard Palethorpe wrote:
>>>>>> Hello,
>>>>>>
>>>>>> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>>>>>>
>>>>>>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>>>>>>> ---
>>>>>>>     runtest/containers                         |   3 +-
>>>>>>>     testcases/kernel/containers/mqns/common.h  | 101 +++++++++++
>>>>>>>     testcases/kernel/containers/mqns/mqns_01.c | 193 +++++++--------------
>>>>>>>     3 files changed, 166 insertions(+), 131 deletions(-)
>>>>>>>     create mode 100644 testcases/kernel/containers/mqns/common.h
>>>>>>>
>>>>>>> diff --git a/runtest/containers b/runtest/containers
>>>>>>> index 2637b62fe..863a964ad 100644
>>>>>>> --- a/runtest/containers
>>>>>>> +++ b/runtest/containers
>>>>>>> @@ -16,7 +16,8 @@ pidns31 pidns31
>>>>>>>     pidns32 pidns32
>>>>>>>       mqns_01 mqns_01
>>>>>>> -mqns_01_clone mqns_01 -clone
>>>>>>> +mqns_01_clone mqns_01 -m clone
>>>>>>> +mqns_01_unshare mqns_01 -m unshare
>>>>>>>     mqns_02 mqns_02
>>>>>>>     mqns_02_clone mqns_02 -clone
>>>>>>>     mqns_03 mqns_03
>>>>>>> diff --git a/testcases/kernel/containers/mqns/common.h b/testcases/kernel/containers/mqns/common.h
>>>>>>> new file mode 100644
>>>>>>> index 000000000..92a77b566
>>>>>>> --- /dev/null
>>>>>>> +++ b/testcases/kernel/containers/mqns/common.h
>>>>>>> @@ -0,0 +1,101 @@
>>>>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>>>>> +/*
>>>>>>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>>>>>>> + */
>>>>>>> +
>>>>>>> +#ifndef MQNS_H
>>>>>>> +#define MQNS_H
>>>>>>> +
>>>>>>> +#include <stdlib.h>
>>>>>>> +#include "lapi/namespaces_constants.h"
>>>>>>> +#include "tst_test.h"
>>>>>>> +#include "tst_safe_posix_ipc.h"
>>>>>>> +
>>>>>>> +enum {
>>>>>>> +	T_CLONE,
>>>>>>> +	T_UNSHARE,
>>>>>>> +	T_NONE,
>>>>>>> +};
>>>>>>> +
>>>>>>> +static int dummy_child1(void *v)
>>>>>>> +{
>>>>>>> +	(void)v;
>>>>>>> +	return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline void check_newipc(void)
>>>>>>> +{
>>>>>>> +	int pid, status;
>>>>>>> +
>>>>>>> +	pid = ltp_clone_quick(CLONE_NEWIPC | SIGCHLD, dummy_child1,
>>>>>>>     NULL);
>>>>>> ltp_clone_quick is still part of the old API and only uses clone2. I
>>>>>> think it should be replaced with tst_clone. This may require extending
>>>>>> tst_clone. In fact we probably need a test variant to switch between the
>>>>>> clone2 and clone3 syscalls when using tst_clone.
>>>>>>
>>>>>> I'll leave it to you whether you want to try that and rebase this patch
>>>>>> set on it.
>>>>>>
>>>>> I see ltp_clone_quick as wrapper of ltp_clone, since it's using
>>>>> ltp_alloc_stack without calling it explicitly all the times before
>>>>> ltp_clone.
>>>> ltp_clone is also part of the old API. At some point we should remove
>>>> that.
>>> I'm marking this as changes requested. tst_clone should be made to
>>> support this scenario.
>>>
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
