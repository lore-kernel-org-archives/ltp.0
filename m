Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E019C433EF
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 06:48:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E8BE3C9291
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 07:48:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32C3B3C6AAF
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 07:48:07 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BB736600F33
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 07:48:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641797286; x=1673333286;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mT+qIHjfeOcH5b6teSVGSy5dj0SMTuVy8LPHEKXgQK0=;
 b=S8AuEm/ypE4eBql0lTC3jRMN12rnF6bhG6JwJQE5rm9wAL4P+1H9e2xg
 R4xcxHUxHZcDsDunK3TnNuC6SZlZczvSEDvbNPKcNG4eUxFDpcYKEn294
 mv2/RcczMG7wJHh+9j63d67QKeZsWlD3X2G1BUR5hzvgrjdmQJ6fQaT4V
 gBwzg4yOTPUcYxA61aV+tVHsBy+LzPa0bHWjPrlSTf6179TKy+CiJIUr0
 9H/vvf7bPi3lukbH0Dh7Hm+xIsUxVZ0LEe0VqW0Jvko1FkR/CxStgBzxQ
 K7M8wS2GRhF/hj1dvSg88FrACy7LdhmlxAJhhivoGr9+iXXxnH2VGCVxr A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="48235813"
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000"; d="scan'208";a="48235813"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2022 15:48:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkXTCYblqA98zpTXkp8hThFNXytqr+g7pOrCSxT3HYmec+jnMbO9ncYV0CijySysc3GxUEVhOqp5LnNyqd0j1bF3yxWvyDVGXDiKCLu9XuT3TyM3NDe5D/GgVM2YSc3ao6/jn3B/gwNb0965UcPA1gj5hGEjiGNAwvpVRW7kwUlzauBRnIcKj8KggSqJGqoCssz6tiPECrbHadmcALzTZRoGyrV9Hw34r7CNExXWOYVmu9ykcgpwnqvoXc2W3pTFGks3yo+KK5MxEuRP2hZFRuqIp+u7kXQbjHB8ScgkVHbi9KuuTuw2Vosi3tC7mCzYbUK2H6rnSay/wzWLkQdA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mT+qIHjfeOcH5b6teSVGSy5dj0SMTuVy8LPHEKXgQK0=;
 b=fOL0TGuvpG8npPgvNtzXuKeza03nDmyRHpqcOzGXLHKHh1supCaXjxQ8G5CB3HbDYaaEN2E4MRmPXscZIXv37XGbrModFh2y66iOc2nGo3Ke8SmNFsjAoNd/hheze0yKLIoDSaunPOSaPC5bEN+XQYq95KNd2L9kbhyDf9jdLt+Dk8w5c9C/lWai2rkIlPnYeQb9E3slCV6qTnJLj1CB+suoYyP8mTJNtE375oAYiSclYB+X5ohvVBrT/tR0x8z18Osl2+kU+XuoRzVtZHE0mcVkr0alv37BsjYydp9I3eMyX2iiEg8hqI2T4pFKa6QdK1yOFOMr1O/8JgRF3C4YPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mT+qIHjfeOcH5b6teSVGSy5dj0SMTuVy8LPHEKXgQK0=;
 b=JQ/9YKbwIX/tEX7ipmZMfziJX6BKgoyAkl2fFTpV8atKQAIDuuGAKtq0uyIOdyza9i9OoCcC2cL4FEDILpvPJdAwcoPDf5MLgrljwUfSd9pPZNHq19XEfmyY/IF71YjMsbJ59pE53HNHSUFuOoGm5pTD/7H/OuP2+gCf0IUUv2Q=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB2320.jpnprd01.prod.outlook.com (2603:1096:404:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 06:48:00 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 06:48:00 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v4 5/6] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
Thread-Index: AQHX7/Lm7zfTqdcjzkiV0fTdw8fQBqxX3LqAgAQfnQA=
Date: Mon, 10 Jan 2022 06:48:00 +0000
Message-ID: <61DBD6D0.1000104@fujitsu.com>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639380414-24390-5-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdhhTeot7Z9861B0@yuki>
In-Reply-To: <YdhhTeot7Z9861B0@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54f49193-a169-4ad0-d1ca-08d9d405249f
x-ms-traffictypediagnostic: TYAPR01MB2320:EE_
x-microsoft-antispam-prvs: <TYAPR01MB2320F6C680264980AE87E675FD509@TYAPR01MB2320.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYKpycVEWvh67kMkdbIMLruteYY+JjPEQ7vz8AAOlVvVbUkNaj1Mdi3V2+ygHDf1UKaOqF876LL7UsAjeTFclU8eJm/cIO897Efe7eL4nwswu5m7eggaxZefT7hOZg0LlGrwMgr+LMJDGBEYcQqB7sFjeMRaIm5IqDeA+4+kmOP/uWplc4UOgChbCu3d4p1RZObUlUav32JoELobv1bX7znq5hB1K3T/O+cpA9eLu3F6OTrMj9H+VnL/XNJESZwMxmmmXVraH3LbrWoAHfMvr1dUUW1L2ZpH4wzQHGxh5z9X5vmcv5zd3kv9HuA57Jv8rRTINPzzN77x0+KldfZkfhsopQGUEJL93NLjs+8ofLqE7BHNfkbsCuAwiUqX92+XZ9rndnKB/huaJWo//qB+3AwxQjKM/BjnpFZnXQ/Ghivzugwa5T3yq7pqZaXhbWs2wutlF+msrbA/wrCq126SiGy1zwAr7UyYY7ygb+1RJ0DTFBiTv20F2d3OdRmGMJkr+XPIuomtKXZhYxumKMzUm7W5F8XjXorUN8+s2sIIWxDwFQnAG67VS27kpWMyN3UIuBVSCb0hK5Os3xzeLIjA5y5iNZNSi/3udvW79wHfIXoPy8CvJ5XeFyaJ2Yiq1hfxUj5o4biOO4yzX4WiLYjoBwf4RdGv4BHWG8RLqHooletXKNz/AdZ3jOwUeDPQ/mobb9+n0M+mYpw21E+vEPCjlpKsgbIF1w7SQf3CvJH5683hbO5r0ljrzXUb/r3RrntE9kYKAf+HPgGvPH5rWsSUic49DCYMkq5OwOtiNrpOgMU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(85182001)(8936002)(6486002)(316002)(15650500001)(66946007)(6512007)(87266011)(26005)(66446008)(66556008)(64756008)(71200400001)(66476007)(122000001)(6506007)(6916009)(5660300002)(86362001)(508600001)(91956017)(76116006)(186003)(966005)(38100700002)(36756003)(2616005)(8676002)(2906002)(38070700005)(82960400001)(83380400001)(4326008)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OFdEeGJhYU90VXFMQjZVRWVMdGRRbWZlQXZvNXVpNXV2eDJqRzg3YTk2bGds?=
 =?gb2312?B?VEJNNjd3aDdUL1BSR0p4NzkvaHR3OFNaRUhsSlNweWNTY0tMUi9BbitJTjB6?=
 =?gb2312?B?RXVxbzM5ZkRmVFhNMVBIanl4QVF0SUhXR2ROZjd2UkRzR2xIK1B3a3NPalBp?=
 =?gb2312?B?SU1SZ0hvUjVVYXRxeEJ2MHRQcm5JczlmQ1VLQXdwamR4QVhzVE1oUmtTUDZJ?=
 =?gb2312?B?ZFEwUExVRThEV292alNYQUFyT1BRM0pZcG83Yy83TmFsMVo4bWxEMEFrRlhO?=
 =?gb2312?B?ZW1kQlBSOVRKNDNUR20rV2JtYm1pWm9kVU5maFFoWXN3WXNMTUxGc1BIZVJn?=
 =?gb2312?B?N2ZYNkZldVV4Q29JMWNwd1Nlby85WWlKQjF3OWVaU2N6RWNFZEhQZWI2a0Mr?=
 =?gb2312?B?c0JNS2ZiZW45bk5relNIVVZtRm9XeENJTW1UT2hJaVlId0I5emhYYXViZmZS?=
 =?gb2312?B?U05uUWlqWlBYQmpmem8rejc4Vmw0U0VqQnlCZXVFK3d1ZkVFdUFUNm1tVGFl?=
 =?gb2312?B?R09waVVSSlhNdFhkcVBHOVFoS3QvZWoxMEY4akluajM0ODZIQVZMeHFqbnha?=
 =?gb2312?B?S3JhMzI1NnBMUHJqbzhsSFpubXpzTjdKdDZNNThreVNPbUlrakUzREs2bUI4?=
 =?gb2312?B?UXRac0lVQjU1SE5KRGpjaVBGMEtjWWtORUNvVG0zSDdkdjJxNnB3K0ViYzIv?=
 =?gb2312?B?VzcvTm44MTc5MU1zU21sbGl3MUdWd1RiYllxMHFmSDU3K0l1dXQ3T0lDcWUx?=
 =?gb2312?B?bWNQWlZ2cXpVU2UwMFc2dVUwdUZCZjlZRVBlc0ZiNGdRbU43Tks3Umwrb21E?=
 =?gb2312?B?RGUxNDk1RkkxbTZaRlh2OVBiMm5WNVNOSHh1anMvVUpKb1VvenBTRG5kWDB0?=
 =?gb2312?B?VnhkMlBSdFRvR0d6Tm1OcDhBQ29FMDZNL0c3SS9ZZ1RHRDhNNG5EWU82YzI3?=
 =?gb2312?B?TlJ4WkVvU2VUbWlKWHhsVkUwZjR6WXBsZ09SNlZjT1dMWCtudkFGbVM2d1p6?=
 =?gb2312?B?WFdqc1htVlBoZTFocEdYeWRsODhuckEwTFhzVERacmZnQkx2WjlTZ0szeVdG?=
 =?gb2312?B?T0R4b1hDSWh0eEh3OEFiVysxSVJCZ2hiSEdOQ25Wdnc4eGFWbzhhMk00RXZT?=
 =?gb2312?B?ZkE2Z01WeHNNallXeUVueERWR3ZoczhIcmd1SEVDQmg1ZEdQai9Jc3d6d1pB?=
 =?gb2312?B?WkxHbllWOHR4aGliN0xYd2dGV1BIYmNubnhKL05YZmJHNFJKM3paa2Q5UHRl?=
 =?gb2312?B?a0d3UDdUOW1zNmNkVWxJUUlFWTY2U0tXUVg2bXMvMVhMMFliS0dPY21KWkpI?=
 =?gb2312?B?SWFYOVRjc2ZEVzIwd0EyejB6V0NYTWVlTlhoTzJWTGJ3R0xvM1M2U0hXUTRj?=
 =?gb2312?B?MlZvSEtBN3dOVlJtL3F5a1Jkc2hDaG8zZ3NkSTBqQ3dKYVA3T0FjZmJ4Qm5D?=
 =?gb2312?B?RmxESG1qYXFnZ05YRGh5UXhnNUlzT0xaOWthWWFwWnNiMTB5S2MwdlNobURo?=
 =?gb2312?B?Nk9OTWhFbGdDODVZZkpKOFhEYnZhWXc3OTZaL3k5MGhHaWxsR0xNTThsQWVI?=
 =?gb2312?B?bmZqby9ib3FvdmUvdTJHUnhLU1ZpODdNUHM0YjFPeXRLdzlpbTkwWVFUMWx1?=
 =?gb2312?B?S3RRN0ZhSnVtVmFoVHUyNGhXNW9oSlU2anh0NXpQbEY1N2dnVVJObzMrcXBT?=
 =?gb2312?B?Zml6QkdoNEowRWRFYmJRUlJaNW9QQUttVGE4MkJWU3VvVUxPYUNQTHhheUsr?=
 =?gb2312?B?VS8rbzlQTVBMdGtQYlYxUVJVaVdGaWVWQzlUeWowRGdYMTE4VE03K2w2K29W?=
 =?gb2312?B?NzVXY3hpQUVuLzlQRGFSTWlNUFJUTFlIUVRYOE1takJpV1ljODNOWSt6eWtQ?=
 =?gb2312?B?UUxhWk96dHoyTjFYY0xwTU5Cd0l2VFF5TW56cS9udks0NmFaWnVPRjBQNkxy?=
 =?gb2312?B?eVJZeHUzcWp0ekRscFQxWW1jS3BEQXB0WERYN1NLanczb2RpZFgwMkx0NHcr?=
 =?gb2312?B?NHNWNFVrNnB3SndMTGN6UnNzdjNkekdyQUJpR21haGU1R2VXeVEzNnNxUXlX?=
 =?gb2312?B?aTJHWmZ6czZDYWRzMWRHWmxyUUVXZWVzd1p2NnZRYmJKNm9OY2tDM2V5TUYv?=
 =?gb2312?B?S3VXWWNmYXlnQWFiaklCZjc1bm5hVVdPMlpNZStLMDk3N0lKNnFLeGJTTUFh?=
 =?gb2312?B?TCtwWG9HRVFocXJlRnJjb3hhYmdLVXMzZ3pISjZlU1Uzc0x0dE1OWDdMbmNM?=
 =?gb2312?Q?rf7sLe3rHN1v4t7/LLFXPfIU/z8X8HXaqkCNj4idUA=3D?=
Content-ID: <2615B0315EA30B4CAB285DE4B4E693D6@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f49193-a169-4ad0-d1ca-08d9d405249f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 06:48:00.3545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQ6Npo7voAg1viMfkMonjMJRI4UUzbgo63oH6XuXvp66qRfA/3snCB9ok9bfMn1VMoQPCmeX7VHCmJoPbpds1pm8vG8tp2VnlbeMN3EPWNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2320
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 5/6] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
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

Hi Cyril
> Hi!
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c b/testcases/kernel/syscalls/quotactl/quotactl09.c
>> new file mode 100644
>> index 000000000..c7c485077
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
>> @@ -0,0 +1,180 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Tests basic error handling of the quotactl syscall without visible quota files
>> + * (use quotactl and quotactl_fd syscall):
>> + *
>> + * - EFAULT when addr or special is invalid
>> + * - EINVAL when cmd or type is invalid
>> + * - ENOTBLK when special is not a block device
>> + * - ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the range
>> + *   allowed by the quota format
>> + * - EPERM when the caller lacked the required privilege (CAP_SYS_ADMIN) for the
>> + *   specified operation
>> + *
>> + * Minimum e2fsprogs version required is 1.43.
>> + */
>> +
>> +#include<errno.h>
>> +#include<sys/quota.h>
>> +#include "tst_test.h"
>> +#include "tst_capability.h"
>> +#include "quotactl_syscall_var.h"
>> +
>> +#define OPTION_INVALID 999
>> +
>> +static int32_t fmt_id = QFMT_VFS_V1;
>> +static int test_id, mount_flag;
>> +static int getnextquota_nsup;
>> +
>> +static struct if_nextdqblk res_ndq;
>> +
>> +static struct dqblk set_dqmax = {
>> +	.dqb_bsoftlimit = 0x7fffffffffffffffLL,  /* 2^63-1 */
>> +	.dqb_valid = QIF_BLIMITS
>> +};
>> +
>> +static struct tst_cap dropadmin = {
>> +	.action = TST_CAP_DROP,
>> +	.id = CAP_SYS_ADMIN,
>> +	.name = "CAP_SYS_ADMIN",
>> +};
>> +
>> +static struct tst_cap needadmin = {
>> +	.action = TST_CAP_REQ,
>> +	.id = CAP_SYS_ADMIN,
>> +	.name = "CAP_SYS_ADMIN",
>> +};
>> +
>> +static struct tcase {
>> +	int cmd;
>> +	int *id;
>> +	void *addr;
>> +	int exp_err;
>> +	int on_flag;
>> +} tcases[] = {
>> +	{QCMD(Q_SETQUOTA, USRQUOTA),&fmt_id, NULL, EFAULT, 1},
>> +	{QCMD(OPTION_INVALID, USRQUOTA),&fmt_id, NULL, EINVAL, 0},
>> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, NULL, ENOTBLK, 0},
>> +	{QCMD(Q_SETQUOTA, USRQUOTA),&test_id,&set_dqmax, ERANGE, 1},
>> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, NULL, EPERM, 0},
>> +};
>> +
>> +static void verify_quotactl(unsigned int n)
>> +{
>> +	struct tcase *tc =&tcases[n];
>> +	int quota_on = 0;
>> +	int drop_flag = 0;
>> +
>> +	if (tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA)&&  getnextquota_nsup) {
>> +		tst_res(TCONF, "current system doesn't support Q_GETNEXTQUOTA");
>> +		return;
>> +	}
>> +
>> +	if (tc->on_flag) {
>> +		TEST(do_quotactl(fd, QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
>> +			fmt_id, NULL));
>> +		if (TST_RET == -1)
>> +			tst_brk(TBROK,
>> +				"quotactl with Q_QUOTAON returned %ld", TST_RET);
>> +		quota_on = 1;
>> +	}
>> +
>> +	if (tc->exp_err == EPERM) {
>> +		tst_cap_action(&dropadmin);
>> +		drop_flag = 1;
>> +	}
>> +
>> +	if (tst_variant) {
>> +		if (tc->exp_err == ENOTBLK) {
>> +			tst_res(TCONF, "quotactl_fd() doesn't have this error, skip");
>> +			return;
>> +		}
>> +	}
>> +	if (tc->exp_err == ENOTBLK)
>> +		TEST(do_quotactl(fd, tc->cmd, "/dev/null", *tc->id, tc->addr));
>> +	else
>> +		TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
>
> How does this work for the tst_variant == 1? We still do pass the fd
> pointing to device right?
Yes, but for tst_variant ==1 ,we don't use dev.
>
> Actually one way to simplify the whole patchset would be to open() and
> close() the device in each do_quotactl() call in the case that
> tst_variant == 1. We wouldn't have to pass the file descriptor to the
> function and everything will just work fine.
I don't think so, it needs to open/close fd each time. IMO, the argument 
cost is less than open/close files.

Best Regards
Yang Xu
>
>> +	if (TST_RET == -1) {
>> +		if (tc->exp_err == TST_ERR) {
>> +			tst_res(TPASS | TTERRNO, "quotactl failed as expected");
>> +		} else {
>> +			tst_res(TFAIL | TTERRNO,
>> +				"quotactl failed unexpectedly; expected %s, but got",
>> +				tst_strerrno(tc->exp_err));
>> +		}
>> +	} else {
>> +		tst_res(TFAIL, "quotactl returned wrong value: %ld", TST_RET);
>> +	}
>
> Use TST_EXP_FAIL() in new testcases please.
>
>> +	if (quota_on) {
>> +		TEST(do_quotactl(fd, QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
>> +			fmt_id, NULL));
>> +		if (TST_RET == -1)
>> +			tst_brk(TBROK,
>> +				"quotactl with Q_QUOTAOFF returned %ld", TST_RET);
>> +		quota_on = 0;
>> +	}
>> +
>> +	if (drop_flag) {
>> +		tst_cap_action(&needadmin);
>> +		drop_flag = 0;
>> +	}
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	unsigned int i;
>> +	const char *const fs_opts[] = { "-O quota", NULL};
>> +
>> +	quotactl_info();
>> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
>> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>> +	mount_flag = 1;
>> +
>> +	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
>> +	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
>> +		test_id, (void *)&res_ndq));
>> +	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
>> +		getnextquota_nsup = 1;
>> +
>> +	for (i = 0; i<  ARRAY_SIZE(tcases); i++) {
>> +		if (!tcases[i].addr)
>> +			tcases[i].addr = tst_get_bad_addr(NULL);
>> +	}
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (fd>  -1)
>> +		SAFE_CLOSE(fd);
>> +	if (mount_flag&&  tst_umount(MNTPOINT))
>> +		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_kconfigs = (const char *[]) {
>> +		"CONFIG_QFMT_V2",
>> +		NULL
>> +	},
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.test = verify_quotactl,
>> +	.dev_fs_type = "ext4",
>> +	.mntpoint = MNTPOINT,
>> +	.needs_device = 1,
>> +	.needs_root = 1,
>> +	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
>> +	.needs_cmds = (const char *[]) {
>> +		"mkfs.ext4>= 1.43.0",
>> +		NULL
>> +	}
>> +};
>> --
>> 2.23.0
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
