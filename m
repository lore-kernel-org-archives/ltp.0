Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEB9ECAAD8
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 13:07:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 132B43CAD22
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 15:07:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DFA83CACF5
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 15:06:49 +0200 (CEST)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20080.outbound.protection.outlook.com [40.107.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 46D331000BD4
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 15:06:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZSKlLCrJGg1HVM6Ddck0EVp1hrV4I9ixfW3V4jWFEVHVYWAZY7k46JqQEYPy69Def9cLGUiBQ3POnUq5NtohdlzkvRqyrS0GNvpm6doaT94dkZXqXTnwTTTIHWMLydiX9Sdr0AVa7jERAvXz0cgmSfts5WlT6MGoaN7/hp8CbhW5jCHlj0fcSygVTxYybhug7zs/0m0xDAe2T36Pf3+P6wzzAwKcQO35277hG4Y97Zyib8YeqWqilIlap50fY7KPX7CVhT0Vx23dSQ8e5ftQaOWq3rgxluby9VxHWa8/Pi89tCyCgNcjfPuWwXrbRGXpIDuRGl6vNexfDO6QmVzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm9jCQgpOodXvUsAsyTUyG0//Fah4hgz1/7WQxatGKI=;
 b=Rdm75ifhA3ys06jd4ihj0I2o5l4Dd0zDyi5dj59Umj9lpkIdala4RLNfqfT+5Q8EfyaSVXaEs0PwZlmrx/iEPjTZK1OmA59wymr8MQducwnR2keOs/+ReJDVyPRNTLZYCGeIa1tRXuLa11YXsxOETZTsmXrWzK72FRuSHnrBBr2NxntBEwOv0ho2JS9B4kcjUybWtJQmY1r5HXS9b9YwT850DEiwkg687+2rXf8JdJH3crxCgWdOMFs+yH94cj/IqpzoMQcsQVmdqzIdooMhgmRGRT+IDtD/I1WNbS/jKldHCexMwsOwCKXQcm7MrpgOnXqCXMS9UvtBnKvzKEd5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xm9jCQgpOodXvUsAsyTUyG0//Fah4hgz1/7WQxatGKI=;
 b=ToosAmC9102pqWr69TGF2yTmURrX7qojndzc9A5VlLqV9UMTjJJsagoB3/yRD2MD9TI8GOronNr4+87Ypwr5DO3Rob49z6SrZbCAjspUnf30K5mub9WiDudnX69okJH/sUjoNflgglw+/38UTKwO2ltRxqZ/OFdXRr1m53N6LiUsC5y/W7JAmVh1lZSV8faGDXzkTHEIX0ZasbvO4dVm7k8h6lSJ9mF9foGTxBZyPawJgJSF9Lxn6AkwWczTvaUW41Npis94H0LevdKQMX7FyISJ7gO5ike0HhRwHJn+5O98MYg0hlfF0f9MeTsqSGzmnyDQa+Ncr+CRBS4sCZ/3AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS4PR04MB9552.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Tue, 20 Sep
 2022 13:06:45 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::41c2:c368:6f78:7518]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::41c2:c368:6f78:7518%8]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 13:06:45 +0000
Message-ID: <6128754d-a2c2-f325-56eb-21693fc8fcd4@suse.com>
Date: Tue, 20 Sep 2022 15:05:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Jan Stancek <jstancek@redhat.com>
References: <6bac7035adc2cfc8ab3800fe1d2d03223ec57ff5.1663662348.git.jstancek@redhat.com>
 <6c5b161bc3bcf753cbda92954ca3f47cb268c68f.1663665637.git.jstancek@redhat.com>
 <6470a099-8b3a-ca9f-f521-181a33b5a28a@suse.com>
 <CAASaF6wFc0z+cec6y2T0ygWKY==LwkFv21CT2VG0Waqk+0SSkw@mail.gmail.com>
In-Reply-To: <CAASaF6wFc0z+cec6y2T0ygWKY==LwkFv21CT2VG0Waqk+0SSkw@mail.gmail.com>
X-ClientProxiedBy: AS9PR06CA0154.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::28) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS4PR04MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9d8aeb-caf6-43ce-9cda-08da9b08f855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GcZCKWjx0SXfWW6eVym+26X24QEBkIQrcZignAuG7YDXONEkyt7GTzKlLCV29XIpkydXR1vnfd3ml5B8ktag6HGOREoA8PUiLO04rxiyFJPmdO6zYUK43H8eG6dcrOsgqbgwcY7JdJHA+gRjCDR8nJICipzGhqPkMDtA1QTeXeBHCOcTBxRDlPwonRKVyQm0XV379L0ZqjiIzWQsqCn/NXUAKUeYeyiB6rqJ/qoZy7oeILSDUNfMmB0o46ntO/6n6eHFAr1OFdkwfvs7OmzQUy1Xz9va7awW9MWezUKlCfK5PoNsChM3DqHEPAMl68BMi7k3HYbHc+WrFklbHodt8GE7cru8BJU4vZAJusgibJMAVm43KmYgyl19dtvh6N2qchb9r+OZO9LfR+aex8Cq5OEynAlvtN8hVJrdXC4ZV91pV5gWl+CE48E9yrofPOsUcEPJz1OQXaKVow56o1mec4cUt8J43CP+z5b+rTYLu+m23KYsmHg5hz9G+81bbJNl+vA6XM//2fRXgZEKvY7UnCy2TRh3zfOImjTcgWIFEIQlZu2VxErg1NKhFTqzZpKB7LHQtXjBW0DdCRSntGxYl9aaPbCzqUCvh40+29iwsZNMZw64vVyaKvDz+HeR7K23FtSqLf6RfKZyigYjkPK2ONLioUKo5KCdqnTWJ60aU9AgDVZVBV2/bq9tXswTe+nZfHwHjx6ts8m4Val8Gj87K3kJztid6yZRSJQJjTD5+knuxwnKWgqy6cQSxH99qLz/8dsQlhwv88jh5dxTJ+PCtbU9LDrsaJUPE7rL1PHb53Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199015)(316002)(6916009)(31686004)(478600001)(6512007)(66476007)(26005)(8936002)(53546011)(31696002)(6486002)(4326008)(2906002)(5660300002)(66946007)(6666004)(66556008)(2616005)(8676002)(6506007)(44832011)(86362001)(38100700002)(41300700001)(83380400001)(186003)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzhheXdib08vL0MrL3lnZU1EUzAzbGxjNGdWTnF3RFRmSG5kK2xEUHRLSW1o?=
 =?utf-8?B?UmI0SGhKWXlMVVpzRG9jcGlNY3R6eFAxNUREYm1hOGxxN3hqSnNCTk80NFha?=
 =?utf-8?B?eXArWUR2WU1Qd2pZbnQyWTNZUG5sUnZUM1UvTXMxRGFoMzJoeE9jRTQ4YjBK?=
 =?utf-8?B?NlFEa1M5c014NnZMWGwzcmpnVk8yeVVmclhLL0lZdDZrbFhJejI2Rk9IYlZ4?=
 =?utf-8?B?NlhmSi92emg5Ukk2Sk1PZURCUjhBdStkdEJ3ZG1sYnpOeGFzcm9wN3Rmdmxy?=
 =?utf-8?B?ODZZV01IajNOQUE1R3VRdkJlUElVTjg3V1RRWk1lakJQYkhQK1B1Q1JvUEdJ?=
 =?utf-8?B?Y1djOVlaQ2tlbXdlRUt0S05HVFdFSEpxUHl1Z25WWnFjQXNEcUZWTENhK2Qv?=
 =?utf-8?B?TE1qT3cxbVl1dFNPKy9CdUpTOU1zYkI0UjRVaHgzdk5OQXpmN3J1M1hCcmZ1?=
 =?utf-8?B?RU8xVE1HY0Q0ajVBSGVoS3JlRk4rc3ZucHN1MUo4UWFIZTg5UU9UQ2FSUk10?=
 =?utf-8?B?Qnl2ZVNxS01IcUlUcjhxV1NwTGdPOHRISFRZWnN0VW52Y2UycFhLMnJ2ejN5?=
 =?utf-8?B?YzlLRkFvNXpRcnNocUswbmFlaVFmTWNFSGs5cGlObEJqMENINEJPdFhrcm5D?=
 =?utf-8?B?NVduQzc0WEFMRm1VTkYxcnJrbWIvNUhyMWp2eVdQbnhKOGRObFhaT1ExbitO?=
 =?utf-8?B?M3M4MTBHWHcxZExwREFNbE9KVXptQlU1ZUJvWHVxUjZXVVhuVkIvU1Z5Y25I?=
 =?utf-8?B?ZFNqYXZLMkJtV1lYWHYzcWRtSFFmcnlYTjlNSHZOV0V0Y1pYNUY4NmVCNnp4?=
 =?utf-8?B?cm8rZld2Nk1VdUJYY3pBV252bGl4VDNqb0lXZVgwRlRTNCtsWlZRNytKb2R3?=
 =?utf-8?B?Nmdkb25Wd3VSVk1nQ05qRU1lVXlZbVpBRjVSQXk5RlV1U0xyOW5KR2ttUzZH?=
 =?utf-8?B?OGNCTU5neVJZWithSzFBQzVLQVdLQmtvZnBmamRmVUdQc3FvTmxWUHBkbU9p?=
 =?utf-8?B?WExGWkUrR3RjSjZFSXJ1dkJMVC9yYnFobVJGUjR3MHl5SzlRMkQ3UVhDNmwz?=
 =?utf-8?B?emVJajYzaEYxaS9HUnE4cm9PV2c1Mkx3WHZkZEFub2JrYkFpMnJQRW1aa0dB?=
 =?utf-8?B?bk5scWY5Sm15clNOd1pwZlBObkxWMDVpNmRtWmd0V2UrUTZLVGFERHhnVnFU?=
 =?utf-8?B?UXFhYzMzd2liVFIyUEpubFJDbDJxNWFPSFdXMkE4VDRyM3FpMFFBQ1A4RFNL?=
 =?utf-8?B?VlRoQ2JDL3k2aHdmajNyZW1oM1gxNG9KUWtGaFEyV2g5N3lrbkJjcXlQR3VL?=
 =?utf-8?B?MlJ0S0NUWTNWbk9NTmhVbjZ3bUN0bU0weUtYajBubnJ5WjdNUUcvRjFOdVBi?=
 =?utf-8?B?b1JZSFYzRDBodGphYUpxSXZDRDFBR1BNWjJuTUNGYTBqYndtTm9iZW9BQ0Fu?=
 =?utf-8?B?Qm1jMFR4Sy9DNW54Ry9tcmJkRlUvQ0c5czRmSTFVRHpzQ2pYNWNMYjYzdGhh?=
 =?utf-8?B?bTRBZlpiTWI4RmxIdmZKdGd4WWxmVGZ0cSsxcys3Y2o4c3NqY3hzQ1N5cElq?=
 =?utf-8?B?UmorV2ZJUU5CL1BYVUxCSEZ2N1h6VUxHanRJTDdHSFM3Rk84dU9Ha0haZUIw?=
 =?utf-8?B?ZXZDbU5obzkzUHgyQ3ZCYmwxK1h5M3AybnFqb21YWlJlUEloRjNCQ0cwaXV1?=
 =?utf-8?B?U29tbDd3cm1CVUFjTHdjb00rYUQ5K0R5dldJOTZ6VTE2ejJTQmg1TjhuMXpN?=
 =?utf-8?B?SDk5OEFTb3Z5eEF0ZzdLR3dOL2s3U2lxTXVtQ3c3TjJPZTM5TXZtTDdFL21v?=
 =?utf-8?B?eE81eXVSTElrZGpJc0xQTHBEdDNTd3lZcVRORXIxZlR5S1BkM2lobDZLU0pa?=
 =?utf-8?B?RURQSncvS1dFNjJBSGNoQVVWY0lXTUVoRkgyYkEvYWxSa2h3VlhPaXRlUVc4?=
 =?utf-8?B?cHp0cjlTUmE0ZkZOK0ZEN3J5WjM4eTJtV1VaSWw4ZXVITUZ5bXMrYXI1SGNS?=
 =?utf-8?B?dlJObjhLdFgzelRIQ3VEVExxNENtd2t2U3c2VVV6TW9CZm8vcTFWd1hZYi80?=
 =?utf-8?B?OUxwTE1TV0Fqc2pJY0JTV3RUcXhyME1pNGppRTNPN2QxTFJzbTlVa3lSVytt?=
 =?utf-8?Q?Cc6EPU5M1AKn8ygA301dcA1OF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9d8aeb-caf6-43ce-9cda-08da9b08f855
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 13:06:45.6156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALk4/pSxIpl0gysAZcr2D/ven5YhCFGi+WeZrZBCAwIZGTBp1VwCZboMPxPI3Y9COE4U8CJGu3s3p5yM4P7Kahbw2pxCDa5W5MQIuIFiLEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9552
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/futex_waitv0[23]: replace
 TST_THREAD_STATE_WAIT with repeated wake
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

On 9/20/22 14:44, Jan Stancek wrote:
> On Tue, Sep 20, 2022 at 11:55 AM Andrea Cervesato
> <andrea.cervesato@suse.com> wrote:
>> Hi!
>>
>> On 9/20/22 11:21, Jan Stancek wrote:
>>> TST_THREAD_STATE_WAIT isn't reliable to tell that it's safe to
>>> call futex_wake(). futex_wake() can be called prematurely and
>>> return 0, which leaves other thread timing out.
>>>
>>> Replace it with repeated futex_wake() until it fails or wakes at least 1 waiter.
>>> Also extend timeout to 5 seconds to avoid false positives from systems with
>>> high steal time (e.g. overloaded s390x host).
>>>
>>> For futex_waitv03 this replaces while loop with TST_RETRY_FUNC.
>>>
>>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>>> ---
>>>    .../kernel/syscalls/futex/futex_waitv02.c     | 21 ++++++-------------
>>>    .../kernel/syscalls/futex/futex_waitv03.c     | 12 +++--------
>>>    testcases/kernel/syscalls/futex/futextest.h   | 15 +++++++++++++
>>>    3 files changed, 24 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/futex/futex_waitv02.c b/testcases/kernel/syscalls/futex/futex_waitv02.c
>>> index 0a0e2b62075c..ccea5eb5e745 100644
>>> --- a/testcases/kernel/syscalls/futex/futex_waitv02.c
>>> +++ b/testcases/kernel/syscalls/futex/futex_waitv02.c
>>> @@ -50,19 +50,13 @@ static void setup(void)
>>>        }
>>>    }
>>>
>>> -static void *threaded(void *arg)
>>> +static void *threaded(LTP_ATTRIBUTE_UNUSED void *arg)
>>>    {
>>>        struct futex_test_variants tv = futex_variant();
>>> -     int tid = *(int *)arg;
>>>
>>> -     TST_THREAD_STATE_WAIT(tid, 'S', 0);
>>> -
>>> -     TEST(futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
>>> -                     1, FUTEX_PRIVATE_FLAG));
>>> -     if (TST_RET < 0) {
>>> -             tst_brk(TBROK | TTERRNO,
>>> -                     "futex_wake private returned: %ld", TST_RET);
>>> -     }
>>> +     TST_RETRY_FUNC(futex_wake(tv.fntype,
>>> +             (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
>>> +             1, FUTEX_PRIVATE_FLAG), futex_waked_someone);
>> Correct way of using TST_RETRY_FUNC is the following:
>>
>>       ret = TST_RETRY_FUNC(futex_wake(tv.fntype, (void
>> *)(uintptr_t)waitv[numfutex - 1].uaddr, 1, FUTEX_PRIVATE_FLAG),
>> TST_RETVAL_GE0);
>>
>>       if (ret < 0)
>>           tst_brk(TBROK | TTERRNO, "futex_wake private returned: %ld", ret);
> This has couple problems:
> TST_RETVAL_GE0 aborts retry on futex_wake returning 0.
> It won't report a failure (-1), followed by successful call later.
> And if the failure (-1) is persistent, it would waste time retrying.

I see your point. Ok, so LGTM even without TST_RETRY_FUNC, so we can 
allign to futex_waitv03 test.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.de>

>>>        return NULL;
>>>    }
>>> @@ -70,16 +64,13 @@ static void *threaded(void *arg)
>>>    static void run(void)
>>>    {
>>>        struct timespec to;
>>> -     int tid;
>>>        pthread_t t;
>>>
>>> -     tid = tst_syscall(__NR_gettid);
>>> -
>>> -     SAFE_PTHREAD_CREATE(&t, NULL, threaded, (void *)&tid);
>>> +     SAFE_PTHREAD_CREATE(&t, NULL, threaded, NULL);
>>>
>>>        /* setting absolute timeout for futex2 */
>>>        SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &to);
>>> -     to.tv_sec++;
>>> +     to.tv_sec += 5;
>>>
>>>        TEST(futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC));
>>>        if (TST_RET < 0) {
>>> diff --git a/testcases/kernel/syscalls/futex/futex_waitv03.c b/testcases/kernel/syscalls/futex/futex_waitv03.c
>>> index ee79728474ee..c674f52d8d4c 100644
>>> --- a/testcases/kernel/syscalls/futex/futex_waitv03.c
>>> +++ b/testcases/kernel/syscalls/futex/futex_waitv03.c
>>> @@ -74,15 +74,9 @@ static void *threaded(LTP_ATTRIBUTE_UNUSED void *arg)
>>>    {
>>>        struct futex_test_variants tv = futex_variant();
>>>
>>> -     do {
>>> -             TEST(futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
>>> -                     1, 0));
>>> -             if (TST_RET < 0) {
>>> -                     tst_brk(TBROK | TTERRNO,
>>> -                             "futex_wake private returned: %ld", TST_RET);
>>> -             }
>>> -             usleep(1000);
>>> -     } while (TST_RET < 1);
>>> +     TST_RETRY_FUNC(futex_wake(tv.fntype,
>>> +             (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
>>> +             1, 0), futex_waked_someone);
>>>
>>>        return NULL;
>>>    }
>>> diff --git a/testcases/kernel/syscalls/futex/futextest.h b/testcases/kernel/syscalls/futex/futextest.h
>>> index fd10885f3205..515b5102d4fc 100644
>>> --- a/testcases/kernel/syscalls/futex/futextest.h
>>> +++ b/testcases/kernel/syscalls/futex/futextest.h
>>> @@ -277,4 +277,19 @@ futex_set(futex_t *uaddr, u_int32_t newval)
>>>        return newval;
>>>    }
>>>
>>> +/**
>>> + * futex_waked_someone() - ECHCK func for TST_RETRY_FUNC
>>> + * @ret:     return value of futex_wake
>>> + *
>>> + * Return value drives TST_RETRY_FUNC macro.
>>> + */
>>> +static inline int
>>> +futex_waked_someone(int ret)
>>> +{
>>> +     if (ret < 0)
>>> +             tst_brk(TBROK | TERRNO, "futex_wake returned: %d", ret);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>>    #endif /* _FUTEXTEST_H */
>> --
>>
>> Regards,
>> Andrea Cervesato
>>
--

Regards,
Andrea Cervesato



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
