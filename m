Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020A6C433EF
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 01:51:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 778583C8C74
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 02:51:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 613963C1810
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 02:51:15 +0100 (CET)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E44F61000985
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 02:51:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638323474; x=1669859474;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ysOsps3i9hwvIkZC5ST+efIfWx3p2quFUp8mJUrxFCg=;
 b=Qg4YisVtKEA+znOYsOWWjtMnhqzaoE4dUd8yI8xFiepJgh7XwNNMdw5a
 OoYT0KiHJWmJ9ZF3S+Xh2mnNK4mXqqIJSJijUsHRA6VBjCBg3EOA5gSCj
 TURPUw23VnKQ3mA2ZBSegIesFBoCPaJ+bUH4X9Sm5SbD/09qz/Dws8iqo
 8hmidrx2VGRxr2RsTinhGp9cioFkELbBzdk/LKn7I29P0FkktZ5adbDgs
 4PODtJ7UgyVgEwqmtt+VRpTGONPBRI6LzhNVDFFK9kLzYTA+Hc1tXIauQ
 PKriM9gH5yw8pHpTTfJqc9kWWiDKgCIr3jfXnPyQ5K99c11lLVzMhrjLz A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="44865880"
X-IronPort-AV: E=Sophos;i="5.87,277,1631545200"; d="scan'208";a="44865880"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2021 10:51:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8iWeJrDtGVXVLhAOO+mdMFAa3hmSbPJ+vuidcpY4wmFbyHArovAzFKl3n4Yms3ZyodZelnV5W5iaRlc/s1bmGrAlEcK5K+bLMyLDJp4wUBJ1YRkjwVoe44UqJ8IV2GBQ6ASEp2gccX8F33gpwm/APKuOvZVNTKLkGDI28R6YZDgyWUk4oWD/50dPK3UAQ/N6iruKwbb7NlZWpb2kA7VkUCvxAG+g+CLNmgp5grnJYI9NBEa5Ou7iGVCIAG1BW62squ+umMSednCphvDMNtLyVTRZKVMXusn+lh9HBYBoyhBmJ8Vi0tHCa8kuyYJVXl9T+5ZFixrDJiZ8YD22VQkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysOsps3i9hwvIkZC5ST+efIfWx3p2quFUp8mJUrxFCg=;
 b=h2U+cqYF+pd1yGehVfpdJxPIwOMM9dpiYk2hbq3jG9KTAQbppTlOB/4Jf8nzUHAJnsQJczkHAZ1/TPIqLz5KZstU2k2oTKUSFXisO1aRB29x3Yiou8dkqnZHu8gnVUaxrcl4X7udu4/xJF797b0RxHVeQqn/Niu/46o3q5Yj9tl+hALtALAPY/5mhINAf5pFk9D/VhpD16VJUAHOvq240MaZioUWIZlEZwfLDCwpR7Gmb5mg7bz+uKzwecAHngy2N+PKJHXcOPdfjzDWnpiaNJUNZkZ3oV5Jqw6pLqcUEQYQpPLyo0EBKOpSGoousM9DeyWVkqgTC16xUVfVXNUzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysOsps3i9hwvIkZC5ST+efIfWx3p2quFUp8mJUrxFCg=;
 b=QRZ912TAGF7g022mUFGbGRErbaWXSVC3JAUjb/KlVifHTwzeeeDiV4JrztPLXp1zkwAaTZB5ZSeXFgvI1mSHRSr9EUSVo8smxo3dhXgAZkW6MV4zzyewx+Muj++mOg9dwdfeftU9+OAkkVM8TXyHwKpI0SY233r++5AqI2wDzf4=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB2940.jpnprd01.prod.outlook.com (2603:1096:404:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 1 Dec
 2021 01:51:07 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 01:51:07 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 2/2] syscalls/statx: Add docparse formatting
Thread-Index: AQHX5bmQ9UVjxgMXOECt/z4wUe3nUqwcOY4AgACm5wA=
Date: Wed, 1 Dec 2021 01:51:07 +0000
Message-ID: <61A6D520.2000400@fujitsu.com>
References: <YaSYuLV+XPW/pQ5/@yuki>
 <1638256273-5208-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1638256273-5208-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YaZJHmY0hkfz491s@yuki>
In-Reply-To: <YaZJHmY0hkfz491s@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddd66f7b-ec99-4925-7c28-08d9b46d0ad1
x-ms-traffictypediagnostic: TY2PR01MB2940:
x-microsoft-antispam-prvs: <TY2PR01MB294000CE32718DCE6CFE5361FD689@TY2PR01MB2940.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +uxFkxdxkjl35a5JYaAZHWQWnryoNdrNbIjXQSKemoukJoqS1Y1RTFiHZzghmOV+rqX6UqQte+dYBXzjfLyqa5nV2/o9hirKcMJ6Lm9nT7GehGsm5ihWY/tCtQTdBEMIsNuI8qiXzhPlTjHU4nTHZfHYv+hnZgc2gsB+unHgRBAM1Sbt0Aauwdvtgw+FNLzPqSdRbARV8/+yda4jyUxWLek7QHF2KGtIZ8cuoB7zDbYDGKl/2EYAi0d4rq6N28ckra6IyKrOZ2bnEdkrwvpHtFj0i73esZmOLTSVNvBwRRK8VU5dqbagUN2ZbhNR40CzvXjwU6KwdoaCo0V9K7Z1fN5yM7wzMIBLaMgfgz4MW6Jmru1wlGESBAkepBTHDUBF9kq41Qw45kzK/BB6G+++ypOKnc24liLP/uVqnjUp/b/HrStObpwx7xr/ConN//XzzKgc5SOEQBBCk1xMQSykLHpaB1M7N232vvGaG9CTGAT5/1Ic0zNYGEPu2i5W2rnS5W9iEU5To58wKN5hNbdDva0jqDGoJMWxL9PUOIYbwwmMcSZO81rPvfgdgjfFML7ZVIBAZm03F+DLA0XAKXSWwKvHDIy4P1cA4FMf4JwSqsWZMgy2sxBSE/CETzBeMag7lYe/TM+xrqkOcITnhvLK/O+bLo8FTEtFevml+OckvuWix/MR1acvGA0+moX9wdrEsJkSNOKzyhDPviM7G1SJ3nJ9qatOET00qPJaBSK5JbASiQrO6j14JVQLgBlJVvlqGzbSTGhOmBdHrNGP0i9bxhB8RcQ2eyHodCfSKbZ+4yQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(30864003)(82960400001)(36756003)(91956017)(6506007)(85182001)(316002)(6486002)(66556008)(33656002)(66476007)(186003)(66946007)(64756008)(76116006)(38070700005)(26005)(5660300002)(71200400001)(66446008)(6916009)(4326008)(8676002)(508600001)(38100700002)(2616005)(6512007)(2906002)(86362001)(87266011)(966005)(8936002)(83380400001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZzBwY0taTC9WK09sa3JLallYU1owazZDM0xhSHJXRkZUakJzVGpIWkJwaWNy?=
 =?gb2312?B?L1ByY0lvMW16aGZaT3hhOURCb25BNmZYcUpsaSs2M0NwRmxmekV6emw3MDAz?=
 =?gb2312?B?NmU5OWsxcHNXVjBGRWt5T3c5bUVKWjFTREMzQ2xGMkNGTWd6T3VpTWJ2VVc5?=
 =?gb2312?B?d2dCeDU3eXNYbTlrdmYxSkpFS2lFS1J5cURSTDRwMXJmUzNBc2ZESmI1bHpt?=
 =?gb2312?B?N3pSUHg5VHBOMzNVdkdsYWhuWFdDcTY3MWpWZFBkb0NTZlY4Z0tpbmFRRUkr?=
 =?gb2312?B?amJEOUNiRG9yS1JkWGp5b2o3TUVDT0lBenZwVmlUYzRobGxLUW1UbEF6RUxa?=
 =?gb2312?B?azI1QjZEM3ZTRW5ZU1N1QUhpdGEvZ0w0VC9RMmdqdE9rd00yUEVzemZMY0w1?=
 =?gb2312?B?QXRaUjl1STVhOEpFVm5jSEQ3NSs1c1RCWG9iVURITGZ3cTR5TTUyaURpNUx5?=
 =?gb2312?B?bE9qOG9PSmFVTFNTMHdodEk1OUpUM3VwelVJN1BmTVNIUkluL0lHdTl0TGhK?=
 =?gb2312?B?U3JsdXRCbHluaWhZR29PRWZRMmx4SlNMN08raUpEakE1THc4aXIyQkt3dmkv?=
 =?gb2312?B?T0lVRFJKdmF0Vk93a1d5SGdINzNsTklRYW9HdWF6MUpmZDhMZlVHd3o2UUtJ?=
 =?gb2312?B?SlMzWElrSWpiQ0pYV1UvVXF6cVNUZjFoOC95WVpHQklhY3ZnVmY2NC9LNkp1?=
 =?gb2312?B?VEFNVkZYUm9nRUI2UzlEQzZaRC9sTHc5WmZ4ZDhCM2tzbWxjZmx1UWVrdzZ1?=
 =?gb2312?B?R083M2taQ3lGTHU4MEJSMkFYMG01Q2t4cUhjVTlzMyt6emJlZkVlRG1RbnZK?=
 =?gb2312?B?ejRjVm1TMDVXdFNUOUltSkN0VWw0VjdGakVkb0o0d1JDWFNSQXFad3poN3Iw?=
 =?gb2312?B?dkhPdHBuSXZwRFl1cHRkVzVtSzNzenlrQTJlUWc3Q0IvU3laN2FiQzlVbzR4?=
 =?gb2312?B?NEhoMllzVncwbzgyZnJRTE00Q25DbU4rNzFPR1V2S0ZkQXltbElMWUw3WTNU?=
 =?gb2312?B?L2d3MVY2Z05EYjEvWVNzOHROY0h3VUpISzFuNUs0a1VLUFZqdjRpUHRpVUxQ?=
 =?gb2312?B?cllIUi9IbWdVMzlheCtIaGM3YnlyWWRicW5vVDdaelhVa0F2MjMvWVZhb3do?=
 =?gb2312?B?R3l4Qzd4bDNmSVZ6UkZhVjZyRUUwRzFjUHUxK2kveExNVnBCT0VFL25vZ0VK?=
 =?gb2312?B?ODZIaXRjVmpWV3BINno0dDZsaEFnVzdiNGh5M29oZFAwV1FDSlBqWmV4RG82?=
 =?gb2312?B?dzJlZHhNUmt0TjBmRlRob1pnVzZQWHk0ZnVWdVhEMjhCU2hkMlUzTm9xeFZk?=
 =?gb2312?B?TkYvMWROSEJWbGVMS0Qwc1B1V01EcGJENXk5SXpWWC8xYWR2TTFNM1ZDem5Z?=
 =?gb2312?B?K2Z4S1I2dVNqRklaY3JJQ0hvUkpVQ3FMZFNlcXM0WVpOeTRmQUFxZUVTZVlp?=
 =?gb2312?B?c1MxdXBPWXdLSnc1Q3k4YlR1b25DcmdpRGRVYVFNU0N0bWZlaC9Cd0Q2OGhn?=
 =?gb2312?B?SENVbmpyRlM1alNJbmVrZDZGbzJIRmtWUThrQmhDY0hYNjIrb2h5dlpmZ1hq?=
 =?gb2312?B?cXRjbFpuOUZrVFFQLzJ2aXBlMmxBbW9iVU1YTTE3VlFhdlI1YkpUUzUrNWRT?=
 =?gb2312?B?Rms3TTJTWUlYMFJuSEJ4cnR4Znlwd2daQ3hFMkc3R1l4QXVpajFhc1R1anZ5?=
 =?gb2312?B?dnFUWnNXZFMxL291SVQyV0h4dHlvWE9OdkFMcHQrS1dNMVp6cUdNYmRGOXlx?=
 =?gb2312?B?dSt3MWRxcGdqS1JSZDZ1RTdXYjhkTUxZOWVQVVFVMzhXQjF4dFhJa3ZVb1c4?=
 =?gb2312?B?MjROY1RQN3hkbVdKaVJzdEhqdFdGc1M1eG4vVE0yZGE1cERhMDd3UlhmcWJt?=
 =?gb2312?B?RThpZmVDaEkxMW1XbzU2akFYYnFWS3lES1B1UStsaklhazI0OGVHRGNTV0VG?=
 =?gb2312?B?V1ZTVFhmMUwwNUxQUG1JTXMxSnFzUi9QQUhGZERHSVFhR1VOKzFvb2JtbDl0?=
 =?gb2312?B?VnU4Vlo0S0FsREFtRGkza2dRY2VOcjNKejVtYlg4bTdnc1hZdmJtNTBwdjFv?=
 =?gb2312?B?UFVJd2krYWd6MmpjbHpYcmFFTklXN3c1RE10ZnB6a1IrTURFNHdyK2FZNkdq?=
 =?gb2312?B?dHhWL0lBQ2wwejRTVFJVTFE3b1N1TGlJb1RwYzVoU3BWT0ZoRjVReTMySUJB?=
 =?gb2312?B?QTVCTW5rL3BNUzUzMVQ1eWV5TmgzOURScVZxZkcwK000Nk5UUk5wTW1uRG5G?=
 =?gb2312?Q?naf+hoDRm1XZqeB4aVIblnq3VZtbXZByursTt0EW+c=3D?=
Content-ID: <E33594FFD6EE3A4FA1C54B5C0AAA26C8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd66f7b-ec99-4925-7c28-08d9b46d0ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 01:51:07.4197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nAVduor82xUCFqkYiVYWGoeMC7RHPFmWJ2L7ggxByVbDVSwFCUE6x2U2HqrJ0r02FaOQqg9bIdYN2iTXFrce10VNoLg9k+7a7rLKlMswHFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2940
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/statx: Add docparse formatting
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

HI Cyril
> On Tue, Nov 30, 2021 at 03:11:13PM +0800, Yang Xu wrote:
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/statx/statx01.c | 31 +++++++++------------
>>   testcases/kernel/syscalls/statx/statx02.c | 12 +++++----
>>   testcases/kernel/syscalls/statx/statx03.c | 26 +++++++-----------
>>   testcases/kernel/syscalls/statx/statx05.c |  8 +++---
>>   testcases/kernel/syscalls/statx/statx06.c | 33 +++++++----------------
>>   testcases/kernel/syscalls/statx/statx07.c | 21 ++++++++-------
>>   6 files changed, 53 insertions(+), 78 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
>> index 524acd273..b52bb2988 100644
>> --- a/testcases/kernel/syscalls/statx/statx01.c
>> +++ b/testcases/kernel/syscalls/statx/statx01.c
>> @@ -4,35 +4,28 @@
>>    * Email: code@zilogic.com
>>    */
>>
>> -/*
>> - * Test statx
>> +/*\
>> + * [Description]
>>    *
>>    * This code tests the functionality of statx system call.
>>    *
>>    * TESTCASE 1:
>
> Can we drop the TESTCASE 1: here and TESTCASE 2: below?
I have dropped them.
>
> The rendered documentation looks better without these two.
>
>>    * The metadata for normal file are tested against predefined values:
>                                                          ^
> 							expected?
>
> predefined sounds strange a bit strange.

Yes.
>
>> - * 1) gid
>> - * 2) uid
>> - * 3) mode
>> - * 4) blocks
>> - * 5) size
>> - * 6) nlink
>> - * 7) mnt_id
>>    *
>> - * A file is created and metadata values are set with
>> - * predefined values.
>> - * Then the values obtained using statx is checked against
>> - * the predefined values.
>> + * - gid
>> + * - uid
>> + * - mode
>> + * - blocks
>> + * - size
>> + * - nlink
>> + * - mnt_id
>>    *
>>    * TESTCASE 2:
>>    * The metadata for device file are tested against predefined values:
>> - * 1) MAJOR number
>> - * 2) MINOR number
>>    *
>> - * A device file is created seperately using mknod(must be a root user).
>> - * The major number and minor number are set while creation.
>> - * Major and minor numbers obtained using statx is checked against
>> - * predefined values.
>> + * - MAJOR number
>> + * - MINOR number
>> + *
>>    * Minimum kernel version required is 4.11.
>
> We do have min_kver in the tst_test structure and it's in the parsed
> metadata as well, so I wouldn't repeat it here.
OK. I also removed them in statx04.c and statx08.c.

Since this patch is a simple docparase formattting fix, I will add your 
reviewed-by and then push the two patches directly.

the difference as below:
diff --git a/testcases/kernel/syscalls/statx/statx01.c 
b/testcases/kernel/syscalls/statx/statx01.c
index 6d20f8ff9..98e1dfcda 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -9,8 +9,7 @@
   *
   * This code tests the functionality of statx system call.
   *
- * TESTCASE 1:
- * The metadata for normal file are tested against predefined values:
+ * The metadata for normal file are tested against expected values:
   *
   * - gid
   * - uid
@@ -20,13 +19,10 @@
   * - nlink
   * - mnt_id
   *
- * TESTCASE 2:
- * The metadata for device file are tested against predefined values:
+ * The metadata for device file are tested against expected values:
   *
   * - MAJOR number
   * - MINOR number
- *
- * Minimum kernel version required is 4.11.
   */

  #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/statx/statx02.c 
b/testcases/kernel/syscalls/statx/statx02.c
index 88a819daf..c96859f44 100644
--- a/testcases/kernel/syscalls/statx/statx02.c
+++ b/testcases/kernel/syscalls/statx/statx02.c
@@ -20,8 +20,6 @@
   * To check symlink no follow flag, the linkname is statxed.
   * To ensure that link is not dereferenced, obtained inode is compared
   * with test file inode.
- *
- * Minimum kernel version required is 4.11.
   */

  #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/statx/statx03.c 
b/testcases/kernel/syscalls/statx/statx03.c
index de2fe4d38..b88809063 100644
--- a/testcases/kernel/syscalls/statx/statx03.c
+++ b/testcases/kernel/syscalls/statx/statx03.c
@@ -15,8 +15,6 @@
   * - ENOENT - No such file or directory
   * - ENOTDIR - Not a directory
   * - ENAMETOOLONG - Filename too long
- *
- * Minimum Kernel version required is 4.11.
   */

  #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/statx/statx04.c 
b/testcases/kernel/syscalls/statx/statx04.c
index f66b04f70..a3ca436f5 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -47,8 +47,6 @@
   *  Date:   Fri Mar 31 18:32:03 2017 +0100
   *
   *  xfs: report crtime and attribute flags to statx
- *
- * Minimum kernel version required is 4.11.
   */

  #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/statx/statx05.c 
b/testcases/kernel/syscalls/statx/statx05.c
index 446102329..a3184e7e3 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -7,10 +7,8 @@
  /*\
   * [Description]
   *
- * Test statx syscall with STATX_ATTR_ENCRYPTED flag
- *
- * - STATX_ATTR_ENCRYPTEDL: A key is required for the file to be 
encrypted by
- *                          the filesystem.
+ * Test statx syscall with STATX_ATTR_ENCRYPTED flag, setting a key is 
required
+ * for the file to be encrypted by the filesystem.
   *
   * e4crypt is used to set the encrypt flag (currently supported only 
by ext4).
   *
@@ -18,7 +16,6 @@
   * First directory has all flags set.
   * Second directory has no flags set.
   *
- * Minimum kernel version required is 4.11.
   * Minimum e2fsprogs version required is 1.43.
   */

diff --git a/testcases/kernel/syscalls/statx/statx07.c 
b/testcases/kernel/syscalls/statx/statx07.c
index 28df758ec..89de0c487 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -17,12 +17,10 @@
   * A test file is created in server folder and statx is being
   * done in client folder.
   *
- * TESTCASE 1:
   * BY AT_STATX_SYNC_AS_STAT getting predefined mode value.
   * Then, by using AT_STATX_FORCE_SYNC getting new updated vaue
   * from server file changes.
   *
- * TESTCASE 2:
   * BY AT_STATX_SYNC_AS_STAT getting predefined mode value.
   * AT_STATX_FORCE_SYNC is called to create cache data of the file.
   * Then, by using DONT_SYNC_FILE getting old cached data in client folder,
@@ -35,8 +33,6 @@
   *  Date:   Thu Jan 4 17:46:09 2018 -0500
   *
   *  Support statx() mask and query flags parameters
- *
- * Hence we skip the test on anything older than 4.16.
   */

  #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/statx/statx08.c 
b/testcases/kernel/syscalls/statx/statx08.c
index e0dbab28f..10b1ca460 100644
--- a/testcases/kernel/syscalls/statx/statx08.c
+++ b/testcases/kernel/syscalls/statx/statx08.c
@@ -19,8 +19,6 @@
   *
   * Two directories are tested.
   * First directory has all flags set. Second directory has no flags set.
- *
- * Minimum kernel version required is 4.11.
   */

  #define _GNU_SOURCE


>
>>    */
>>
>> diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
>> index 63133a3b7..56577599c 100644
>> --- a/testcases/kernel/syscalls/statx/statx02.c
>> +++ b/testcases/kernel/syscalls/statx/statx02.c
>> @@ -4,12 +4,13 @@
>>    * Email: code@zilogic.com
>>    */
>>
>> -/*
>> - * Test statx
>> +/*\
>> + * [Description]
>> + *
>> + * This code tests the following flags with statx syscall:
>>    *
>> - * This code tests the following flags:
>> - * 1) AT_EMPTY_PATH
>> - * 2) AT_SYMLINK_NOFOLLOW
>> + * - AT_EMPTY_PATH
>> + * - AT_SYMLINK_NOFOLLOW
>>    *
>>    * A test file and a link for it is created.
>>    *
>> @@ -19,6 +20,7 @@
>>    * To check symlink no follow flag, the linkname is statxed.
>>    * To ensure that link is not dereferenced, obtained inode is compared
>>    * with test file inode.
>> + *
>>    * Minimum kernel version required is 4.11.
>
> Here as well no need to repeat the minimal kernel version.
>
>>    */
>>
>> diff --git a/testcases/kernel/syscalls/statx/statx03.c b/testcases/kernel/syscalls/statx/statx03.c
>> index c72d7fead..de2fe4d38 100644
>> --- a/testcases/kernel/syscalls/statx/statx03.c
>> +++ b/testcases/kernel/syscalls/statx/statx03.c
>> @@ -4,25 +4,17 @@
>>    * Email: code@zilogic.com
>>    */
>>
>> -/*
>> - * Test statx
>> +/*\
>> + * [Description]
>>    *
>> - * This code tests if expected error values are returned for specific cases by
>> - * statx.
>> - * The error cases are simulated and the return value is checked against
>> - * expected error number value.
>> - * The following error values are tested:
>> - * 1) EBADF - Bad file descriptor
>> - * 2) EFAULT - Bad address
>> - * 3) EINVAL - Invalid argument
>> - * 4) ENOENT - No such file or directory
>> - * 5) ENOTDIR - Not a directory
>> - * 6) ENAMETOOLONG - Filename too long
>> + * Test basic error handling of statx syscall:
>>    *
>> - * Error scenario is simulated for each listed flag by passing
>> - * respective arguments.
>> - * The obtained error flag is checked against the expected
>> - * flag value for that scenario.
>> + * - EBADF - Bad file descriptor
>> + * - EFAULT - Bad address
>> + * - EINVAL - Invalid argument
>> + * - ENOENT - No such file or directory
>> + * - ENOTDIR - Not a directory
>> + * - ENAMETOOLONG - Filename too long
>>    *
>>    * Minimum Kernel version required is 4.11.
>
> Here as well.
>
>>    */
>> diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
>> index 81a5bcbf2..83c6c3ab5 100644
>> --- a/testcases/kernel/syscalls/statx/statx05.c
>> +++ b/testcases/kernel/syscalls/statx/statx05.c
>> @@ -4,10 +4,12 @@
>>    * Email: code@zilogic.com
>>    */
>>
>> -/*
>> - * Test statx
>> +/*\
>> + * [Description]
>> + *
>> + * Test statx syscall with STATX_ATTR_ENCRYPTED flag
>>    *
>> - * 1) STATX_ATTR_ENCRYPTED - A key is required for the file to be encrypted by
>> + * - STATX_ATTR_ENCRYPTEDL: A key is required for the file to be encrypted by
>>    *                          the filesystem.
>
> The list with single entry looks strange here. I would rewrite it as:
>
> Test statx syscall with STATX_ATTR_ENCRYPTED flag, if set a key is
> required for the file to be encrypted by the filesystem.
>
>>    * e4crypt is used to set the encrypt flag (currently supported only by ext4).
>
> And here as well, no need to repeat the minimal kernel version.
>
>> diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
>> index 0469d66c5..4a0685a65 100644
>> --- a/testcases/kernel/syscalls/statx/statx06.c
>> +++ b/testcases/kernel/syscalls/statx/statx06.c
>> @@ -1,36 +1,21 @@
>>   // SPDX-License-Identifier: GPL-2.0 or later
>>   /*
>> - *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
>> - *  Email : code@zilogic.com
>> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
>> + * Email : code@zilogic.com
>>    */
>>
>> -/*
>> - * DESCRIPTION :
>> +/*\
>> + * [Description]
>>    *
>> - * Test-Case 1 : Testing btime
>> - * flow :       The time before and after the execution of the create
>> - *              system call is noted.
>> - *		It is checked whether the birth time returned by statx lies in
>> - *              this range.
>> + * Test the following file timestamps of statx syscall:
>>    *
>> - * Test-Case 2 : Testing mtime
>> - * flow :       The time before and after the execution of the write
>> - *              system call is noted.
>> - *              It is checked whether the modification time returned
>> - *              by statx lies in this range.
>> + * - btime - The time before and after the execution of the create system call is noted.
>>    *
>> - * Test-Case 3 : Testing atime
>> - * flow :       The time before and after the execution of the read
>> - *              system call is noted.
>> - *              It is checked whether the access time returned by statx lies in
>> - *              this range.
>> + * - mtime - The time before and after the execution of the write system call is noted.
>>    *
>> - * Test-Case 4 : Testing ctime
>> - * flow :	The time before and after the execution of the chmod
>> - *              system call is noted.
>> - *              It is checked whether the status change time returned by statx
>> - *              lies in this range.
>> + * - atime - The time before and after the execution of the read system call is noted.
>>    *
>> + * - ctime - The time before and after the execution of the chmod system call is noted.
>>    */
>>
>>   #define _GNU_SOURCE
>> diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
>> index ec1cdd190..e7045edaa 100644
>> --- a/testcases/kernel/syscalls/statx/statx07.c
>> +++ b/testcases/kernel/syscalls/statx/statx07.c
>> @@ -1,15 +1,16 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
>> - *  Email : code@zilogic.com
>> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
>> + * Email : code@zilogic.com
>>    */
>>
>> -/*
>> - * Test statx
>> +/*\
>> + * [Description]
>>    *
>>    * This code tests the following flags:
>> - * 1) AT_STATX_FORCE_SYNC
>> - * 2) AT_STATX_DONT_SYNC
>> + *
>> + * - AT_STATX_FORCE_SYNC
>> + * - AT_STATX_DONT_SYNC
>>    *
>>    * By exportfs cmd creating NFS setup.
>>    *
>> @@ -29,11 +30,11 @@
>>    *
>>    * The support for SYNC flags was implemented in NFS in:
>>    *
>> - * commit 9ccee940bd5b766b6dab6c1a80908b9490a4850d
>> - * Author: Trond Myklebust<trond.myklebust@primarydata.com>
>> - * Date:   Thu Jan 4 17:46:09 2018 -0500
>> + *  commit 9ccee940bd5b766b6dab6c1a80908b9490a4850d
>> + *  Author: Trond Myklebust<trond.myklebust@primarydata.com>
>> + *  Date:   Thu Jan 4 17:46:09 2018 -0500
>>    *
>> - *     Support statx() mask and query flags parameters
>> + *  Support statx() mask and query flags parameters
>>    *
>>    * Hence we skip the test on anything older than 4.16.
>
> Here as well, no need to repeat the minimal kernel version.
>
>> */
>> --
>> 2.23.0
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
