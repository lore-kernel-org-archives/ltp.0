Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03016EE4993
	for <ltp@archiver.kernel.org>; Tue, 22 Aug 2023 09:46:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A231F3CC6F0
	for <ltp@archiver.kernel.org>; Tue, 22 Aug 2023 11:46:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59B513CC6D4
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 11:46:04 +0200 (CEST)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DDA721000459
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 11:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1692697563; x=1724233563;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eKfF3E9ilSQi7573hanortBFtHx/3830mdLgVsDhvjU=;
 b=X8OavwWLsvOfaB89JUn1mi7iL9TxeI2Z3VwI7Z5gEQLwaJ00IYKEEono
 trJwtM01kYZixm64ScjttyJfapU0ssGhBSlntWuiOlGzac1yf5EdXZJqT
 9uKVZRX833v7XztwZieFzsfd58hpJVCb56o5EoXYV05lhdT8FgXxzg6kt
 KEw0ST/N8MhtBw8AARs0f8Axc9Dx9jhu+Lx9ot2Djv2m9UDwy/uZA8zxR
 sVrG/dD/a1EWfgT/BkMtLZL/ejFJnsDkrkZMBeidaHXHdgreucgrtFx/X
 Zk8gE0wguZIJdpdNN5wMVvc7vJt9IFM3bHR0Ls1FQXiZkc5AsrvgcACS4 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="92844213"
X-IronPort-AV: E=Sophos;i="6.01,192,1684767600"; d="scan'208";a="92844213"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 18:46:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHDaVoKXrFg1fCedA7hQSOBaV1H4hHHNZnvnSoxGvSObb0zEA/9vzRS3hosdMVsRbH2x2A+1XOyeGuYiOFPJ7zm8AsDXRrGhed55BWZXYQo3Cc/rY+ZDU0uH7BVQozbb8u7esZFWi1UMnq7wBafIF+nKRqKDQAGK4Jq+JO4uBbX2iFiqWDzZUapV9q9G94NKzofWoqBo/zi0z2OMUl1m3LjzBTADg/7IV7CKFp4lBXXSIcWZcFpddW0crrAfTq2MCI3hUNotj5Mn0NLRatvjk7kM10wTsjOuDTRanIVhm2LYkqSx+KnhJlHWITgeoEIa9AChafrfCjzTQm4BqNAXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKfF3E9ilSQi7573hanortBFtHx/3830mdLgVsDhvjU=;
 b=IkqbQ7RaniEoOri8LKyuZhK9qQpG0hug0bkaFWZmuXFb8LFwvwHOqIK+lnKzvhgWYblG7LZbfv7uWJVO1taTjfCYe5JLpxLYKnExnkbspoUST2Xrtxd8DLSUIf5+4OHRU0rW5Ugy6oee6zXhJI7piLEQv3rdCw8xWRtuLGLIbTN3eMt558NZARpwWASn9dorFvDr+UQUUbawz4L9HR8t1TPiLJWDpKsrIOjSkjkRRjzhH8o2G1F3KDV5ztMrnWteQQx2p1mKubB/hEVFih52WhOdLL922Z7fkJFSFoT/ryk+k2+/6TD2ypoJ97qB2bsH0JrLIM0jquA52wojOLMCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by TYWPR01MB10603.jpnprd01.prod.outlook.com (2603:1096:400:2fc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 09:45:56 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::3776:b0fb:c837:7c84]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::3776:b0fb:c837:7c84%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 09:45:56 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 1/2] syscalls/faccessat201: Add new testcase
Thread-Index: AQHZx1J5rubceNCG9k2O3QJGDTifVK/jpm4AgBKFzwA=
Date: Tue, 22 Aug 2023 09:45:56 +0000
Message-ID: <ae0cb8d7-7191-f2b2-4bc4-eac2cc463037@fujitsu.com>
References: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1691208482-5464-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZNT6GkZ05CrGk5pV@yuki>
In-Reply-To: <ZNT6GkZ05CrGk5pV@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|TYWPR01MB10603:EE_
x-ms-office365-filtering-correlation-id: c43b6c7e-3489-4594-3691-08dba2f4952d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OoUJDh/atg4SrgIzxTWPDNtC0bVbuXlP/RlNVXF/aibS8KxOgPqYtORpcBI1ZU3vuiiJhlAtv7agxhTJH7HCgKckT6kHLWmfjcwJ/TCw0TduRSihMhGJJ1NIOjIHV8wXQ52Da8R1MfEpufv7CHQ0gwpZyoqnpjA8yVNPzE+bRQDDQP/4GPe8kShWsJt839bhP/O/XhFvVb16U9zHcXC/YvjYbfg9BClzSwuiSGmO/jaLrggm9qBQhGaV/PPdW5ZkRCvH8tjFF9Piin/j/dp+9H/G3seqr78wnOXQM2mVWUPIhyjda3mVSFaAGfN92VMMg3cySi4O8kR74JX/CLqK+/wCXn9pNXe77RGnTne3Z08Vnd0RXazadtUgXc0ToH7h8XkaTBSRO7585wzYHP6LKwTwhbSCkE9/bd80BGxSrglmAhyaq8+poZVggE2dr0f1Lj+T+agv9BBU9vC183OkpJjZjjDdps1iiRi3n8Nu7pjCgolfKYKZ9VIyC6VTRG12vz/SrD9+/kJ50tEXFLtfchZQlWZgNilD2JcXzlyMjCzWCnn22SDrGxHpLlNpzMguZzZo1zlc4cM2uVVLadUip+NNLKdhyJ4KlqqDai9yu8K8RtyddnzagibPjmEgGWont2qk8UfvLHZBXSDZ7z6WwA95rF/3Xq2hHrOQaGnQOHBVQxEa6wf/Rg3+Lc9AF5xk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(1800799009)(186009)(1590799021)(451199024)(6486002)(71200400001)(6506007)(38100700002)(6512007)(122000001)(1580799018)(38070700005)(82960400001)(31696002)(83380400001)(85182001)(36756003)(26005)(41300700001)(2616005)(66556008)(2906002)(6916009)(316002)(66946007)(66446008)(66476007)(91956017)(76116006)(86362001)(5660300002)(64756008)(478600001)(8676002)(8936002)(4326008)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVlsRmllWUM2UUhic295MVlwYSt6ZTIzWngwUVAzdjc1TWJCc2RKUk8wbzc4?=
 =?utf-8?B?YW9ob3lnMzZYWENILzF1ODdPNnN1ZUMwWmd5NHVIaGhVeXRxRE9LbE9IaHVQ?=
 =?utf-8?B?SzRxcXBXYXJZekprR3NnUzFZUnM2ckMvN28yNXc5OU45SkRXZnVGOVAyK0xr?=
 =?utf-8?B?bUdxdGJXV0hkcUNWVVdFVVBpZXVSS1lHeW8wZ3Q5ejFDZjRva1Z5bzZGRkxB?=
 =?utf-8?B?ZXVPVlpBYmx0amNlZU1IaENlOW9FaldoblVwc3NocVh5aDVibUl2akpKMGhL?=
 =?utf-8?B?Z2ErZ0YyaloxZVlLU0djUkR2eFo3UjlhQkM1YU1qSVNUT3NBSmFvVmIxME9J?=
 =?utf-8?B?S0pvVG52NUIxWkRKOE1WOFk0N1B2dGtqNUJLeDNiVWFLQmFBaGtlR3h5ZGlp?=
 =?utf-8?B?NHZNK0lxMXNVeVNLMEZIN09USTlYNjlVL2Q3TDZ2ejlrZ1FaQ25XVnh0STZE?=
 =?utf-8?B?aEZDK1M3L1htd0p4alFZMGNNRVUzWGV4dEVrNjFlcmt4UUMxMFhBRUxwUE0x?=
 =?utf-8?B?bG4ydlFYYXZPN1hEaXJUWE5FZ0dxRG0zWDdCN0d4R3MyM3lVSVVWTUZ0d0hy?=
 =?utf-8?B?Z1FRMFdKck9jN0VjSGlOOGhQM0FHbjJBTThLQlQvaFM4aXJFUUk4VllML3B5?=
 =?utf-8?B?VVJxb25BalVDaWRvaWlLL0tCZ2RabHNrNUc5Ti9WTVpld1RoaVhMZjdZWmJt?=
 =?utf-8?B?N1hlNTl6S1dVeVhobVJzNW1WV2dRVjdEcXp1RC81aDhpRHhUQW82cGI3S1dy?=
 =?utf-8?B?UXI0cWl4WmtuZ2dCQzB5NGU3VkV5amRiZ0piNGh0MFRZZTdsSSsxZHV6UG9H?=
 =?utf-8?B?MEZpUVI0cDBOeUxVSXZFUHc2dWdhNUZ5QkJlejMrbXRBZm1YN3JaQy85MDR1?=
 =?utf-8?B?aEhOOERkTndKNGd6UEY2Si9YaTRaZ281MjdOM0hmLzNIQklTSkhMRktlOG1N?=
 =?utf-8?B?d0xFbURmQ3JDNzF2ZHRUcFFrOU1aNXVWNUhRZlNmUjkwalhaN0tpTEdtVERy?=
 =?utf-8?B?RWl3UUk4TTNtb2RrLzl1L1NWMFlIcjN1aDJjd3hWTXNwTEJkb2FqVTlMenZo?=
 =?utf-8?B?ampVZnFrVmVRbDJ6VXdlN0c1SWlDaHZqdlFBVTBBTzlTc1cxWXRvd1JDdm9U?=
 =?utf-8?B?a2NyMGgvNEp6VU5wRXp4Z25zTFVQam9mcERTSUpRVlFuVkZWazM1TmtTUGww?=
 =?utf-8?B?VnNmZy96TE4vcU40OHl2aWRHczRKRC9NOHBOZ2NDL01jcXdTZ1YzTkxoQnBw?=
 =?utf-8?B?ajJWbUZsM3VQN1VOejdLb0ExMmllYjU1MHFETmU2VEdGdjVBek1FQzU2WWVS?=
 =?utf-8?B?MU5vc296QXdpblFyaGtTQjlyMlA3MW5wWThYWUlMYU5jbk5xVSsrMHBuRk1x?=
 =?utf-8?B?QUFDWU9LTGp6Qi9MeUpqeG9QOHIzMFRneTdieWg5ZStmbTFLdXJrMWZtVXdh?=
 =?utf-8?B?ajlMUVlSRi9jT3l0M1pMenFBbUJJU09GcU9aL2J0eWYwZEx6d09zdE1xMjZ1?=
 =?utf-8?B?ZUJqYUF5OEZ2RVdkZW1PZWc5c0d0QWcxbkFFUXZpOEEzaDZySTBnWHhjM2VM?=
 =?utf-8?B?RnJva3ZpbWgxaGxBOHRoWXdyZlk1em84NTdZWmd2VW9LeEVvMk5FRjZpOE5U?=
 =?utf-8?B?VlFsL0hudFRpdXJLSU5LemhFUUdWWnJUcXExUWJTZmg0MlB1VFZOWHhsem9J?=
 =?utf-8?B?N05XR3Y3dVVocENVODdnOWNrWG8rSUhmdWZ6aW0zRGgwYnBjb20vTEVvVVpU?=
 =?utf-8?B?ZG9teFEyWHFjSVRYYkM0QkhzakJXZUJOdnQrVm9mbkpKR1hDbmJrdXVhdCtx?=
 =?utf-8?B?QU8zV012R3hhZGFyd3YwTnJyeXRWcWc1VXpYWURqYmNQL0JuOG5QSFpVcnkw?=
 =?utf-8?B?Wk1Pem9PblpreEJnbFJMa1NPZHZRSG5kYkpRZXhjT2dsbnRBaUpKVlBGT2cx?=
 =?utf-8?B?anJQYjBxSzZHd1ZmcU1RTElYSFhRRmdMQy95TmJvQU9hdUE5ajBWQnNxVXZl?=
 =?utf-8?B?RUszTWpoeXpYTVByU2toUUlMbjZPcHQ1Sis4NmpMVG42b1NRbnpaZmR2MVhu?=
 =?utf-8?B?T28wNjY5dUJUMzZ4WGR5eDM3VjlEanUrbHlsVTA0RGFiN0NEUHJBS3U5UHVh?=
 =?utf-8?B?NERwRFhLd0ZlMDlDaGMzU2ZLakJJc2pzY1V0bysrL2JsQkhVaGdoNlVpOUJH?=
 =?utf-8?B?T3c9PQ==?=
Content-ID: <92F1B5AEE977B840A1CB460A829417D7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lUu7zd9IkCaCz2HwnR/kqTo43kfI98t+LvWWiIV1a01RLC+2YgldAHIIJSPESKVRloucH4/VB8Mw2LRTp9YrNTNNizdBrGuuDePjMHouRvJNosMoBLTECL0A8fXXBLVXHTbiUiBvPBOZ/YE3DLn93vT/7AWU9wNcU7yewK6RAlIPAtJ1nsvVt9aHLUyzXYXHRwoFt9vwlhFHxtFnKykBJb63CkdDZ30aU3cQjhXVAaMppA8BQqDrvBOsdhJFyZP0gHtYtTwqYdzF9GOiiknR+bE5QiShhPIysihMaGitx//HC4Ow/6dLFZivL6DigwAMM8RLrqgF+uGqTyAHemIOYF8HoVV/GCMNFRqbGaglpEmEl31GfBTlNPcDJBj/WWiNxr7tiL4iphVUqgDVu0IXLlqV6emkvnaw/bwJrFQcI4dm+slDX5Z6TaXrkFer/sVAlMYy6RCt09mDhzIzgiVKnY6JZCgpAAEPkqf8ltBBaeIOnwiZJqLpzxKUSyqR8iS1io18oloSzTncP2Hb6170R2L+8pGscEGmvzmSSyE/EdWc7DZGGHxUvDnRyUtPodhQvSC5vv1g6oXMefX2QFp1RmFarmC4WBfxHdTHmSbfSvs3yeKGz0hZy9rHG/GQYjDf3K2KIEsEOpxRWNP+kLUtmTPtx3/iI6C6n1wdQyPF605JeIKTjqz9L4OMP6gKdfvVkNHY8mX6tbWuj/Cnzyi7pf4cHZS4ahejg1T/fxhlBI5kfstluoYId99uY4lW2L01i0+rpPYrW2hnUDnPP3rovLilRHSlYC5Yx7cWNxUdOrs=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43b6c7e-3489-4594-3691-08dba2f4952d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 09:45:56.1278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1P1cOWNpaVnAB3RcGsop5Qg98r3AUZ6Bm8KMLo0tHvls4GqlyBwmGeybb6gB8kyvZXDITaw7c52W2YJbxLjLndT0EjRBgD5GDEC8GOBhE7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10603
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/faccessat201: Add new testcase
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
>> diff --git a/include/lapi/faccessat2.h b/include/lapi/faccessat2.h
>> new file mode 100644
>> index 000000000..e8b27d6b1
>> --- /dev/null
>> +++ b/include/lapi/faccessat2.h
>> @@ -0,0 +1,20 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +#ifndef LAPI_FACCESSAT2_H__
>> +#define LAPI_FACCESSAT2_H__
>> +
>> +#include "tst_test.h"
>> +#include "lapi/syscalls.h"
>> +
>> +#ifndef HAVE_FACCESSAT2
>> +int faccessat2(int dirfd, const char *pathname, int mode, int flags)
>> +{
>> +	return tst_syscall(__NR_faccessat2, dirfd, pathname, mode, flags);
>> +}
>> +#endif
>> +
>> +#endif /* LAPI_FACCESSAT2_H__ */
> This one needs the configure check, and I would call the header just
> faccessat.h.
i will update it.
>> diff --git a/testcases/kernel/syscalls/faccessat2/faccessat201.c b/testcases/kernel/syscalls/faccessat2/faccessat201.c
>> new file mode 100644
>> index 000000000..658d1dd81
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/faccessat2/faccessat201.c
>> @@ -0,0 +1,115 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Check the basic functionality of faccessat2().
>> + *
>> + * Minimum Linux version required is v5.8.
>> + */
>> +
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <pwd.h>
>> +
>> +#include "tst_test.h"
>> +#include "lapi/syscalls.h"
>> +#include "lapi/faccessat2.h"
>> +
>> +#define TESTUSER	"nobody"
>> +#define TESTDIR		"faccessat2dir"
>> +#define TESTFILE	"faccessat2file"
>> +#define	RELPATH		"faccessat2dir/faccessat2file"
>> +#define TESTSYMLINK	"faccessat2symlink"
> There is a mix of tabs and spaces in this part that should be cleaned
> up.
My mistake, I will correct it.
>> +static int dir_fd = -1, bad_fd = -1;
>> +static int atcwd_fd = AT_FDCWD;
>> +static char *filepaths[4];
>> +static char abs_path[128];
>> +static struct passwd *ltpuser;
>> +
>> +static struct tcase {
>> +	int *fd;
>> +	char **filename;
>> +	int flags;
>> +	int exp_errno;
>> +} tcases[] = {
>> +	{&dir_fd, &filepaths[0], 0, 0},
>> +	{&bad_fd, &filepaths[1], 0, 0},
>> +	{&atcwd_fd, &filepaths[2], 0, 0},
>> +	{&dir_fd, &filepaths[0], AT_EACCESS, 0},
>> +	{&bad_fd, &filepaths[1], AT_EACCESS, 0},
>> +	{&atcwd_fd, &filepaths[2], AT_EACCESS, 0},
>> +	{&dir_fd, &filepaths[0], AT_EACCESS, EACCES},
>> +	{&bad_fd, &filepaths[1], AT_EACCESS, EACCES},
>> +	{&atcwd_fd, &filepaths[2], AT_EACCESS, EACCES},
>> +	{&atcwd_fd, &filepaths[3], AT_SYMLINK_NOFOLLOW, 0},
>> +};
>> +
>> +static void verify_faccessat2(unsigned int i)
>> +{
>> +	struct tcase *tc = &tcases[i];
>> +
>> +	if (tc->exp_errno == EACCES) {
>> +		if (SAFE_FORK() == 0) {
>> +			SAFE_SETUID(ltpuser->pw_uid);
>> +			TST_EXP_FAIL(faccessat2(*tc->fd, *tc->filename, R_OK, tc->flags),
>> +				    tc->exp_errno, "faccessat2(%d, %s, R_OK, %d) as %s",
>> +				    *tc->fd, *tc->filename, tc->flags, TESTUSER);
>> +		}
>> +
>> +		tst_reap_children();
> I would just put the EACCESS tests to a separate testcase, which would
> make the test more straightforward and easier to read.
ok.
>> +	} else {
>> +		TST_EXP_PASS(faccessat2(*tc->fd, *tc->filename, R_OK, tc->flags),
>> +			     "faccessat2(%d, %s, R_OK, %d) as root",
>> +			     *tc->fd, *tc->filename, tc->flags);
>> +	}
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	char *tmpdir_path = tst_get_tmpdir();
>> +
>> +	sprintf(abs_path, "%s/%s", tmpdir_path, RELPATH);
>> +	free(tmpdir_path);
>> +
>> +	SAFE_MKDIR(TESTDIR, 0666);
>> +	dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
>> +	SAFE_TOUCH(abs_path, 0444, NULL);
>> +	SAFE_SYMLINK(abs_path, TESTSYMLINK);
>> +
>> +	filepaths[0] = TESTFILE;
>> +	filepaths[1] = abs_path;
>> +	filepaths[2] = RELPATH;
>> +	filepaths[3] = TESTSYMLINK;
>> +
>> +	ltpuser = SAFE_GETPWNAM(TESTUSER);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (dir_fd > 0)
>> +		SAFE_CLOSE(dir_fd);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test = verify_faccessat2,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.bufs = (struct tst_buffers []) {
>> +		{&filepaths[0], .size = sizeof(*filepaths[0])},
>> +		{&filepaths[1], .size = sizeof(*filepaths[1])},
>> +		{&filepaths[2], .size = sizeof(*filepaths[2])},
>> +		{&filepaths[3], .size = sizeof(*filepaths[3])},
>> +		{&ltpuser, .size = sizeof(ltpuser)},
> Why do we allocate anything here when we replace the pointers in the
> test setup anyways?
>
> If anything it would make sense to allocate the buffers in the test
> setup instead of using static strings there. Also filepath[x] way less
> readable than actually giving the variables proper names such as
> abs_path.
>
> I guess that we can as well add a helper to the buffer library such as:
>
> diff --git a/include/tst_buffers.h b/include/tst_buffers.h
> index d19ac8cf0..a12d70a62 100644
> --- a/include/tst_buffers.h
> +++ b/include/tst_buffers.h
> @@ -46,6 +46,11 @@ char *tst_strdup(const char *str);
>    */
>   void *tst_alloc(size_t size);
>   
> +/*
> + * Strdup into a guarded buffer.
> + */
> +char *tst_strdup(const char *str);
> +
>   /*
>    * Allocates iovec structure including the buffers.
>    *
> diff --git a/lib/tst_buffers.c b/lib/tst_buffers.c
> index b8b597a12..4488f458e 100644
> --- a/lib/tst_buffers.c
> +++ b/lib/tst_buffers.c
> @@ -76,6 +76,13 @@ void *tst_alloc(size_t size)
>          return ret + map->buf_shift;
>   }
>   
> +char *tst_strup(const char *str)
> +{
> +       char *ret = tst_alloc(strlen(str) + 1);
> +
> +       return strcpy(ret, str);
> +}
> +
>   static int count_iovec(int *sizes)
>   {
>          int ret = 0;
>
>
> And slightly more complicated would be addition of tst_aprintf() that
> would printf into buffer allocated by tst_alloc(). I will send a patch
> that adds this tomorrow.
>
> Once that is done we can use these in the test setup such as:
>
> static char *abs_path;
> static char *testfile;
>
> static struct tcase {
>       int *fd;
>       char **filename;
>       int flags;
>       int exp_errno;
> } tcases[] = {
>       {..., &abs_path, ...},
>       {..., &testfile, ...},
> }
>
> static void setup(void)
> {
> 	...
>
> 	testfile = tst_strdup(TESTFILE);
> 	abs_path = tst_aprintf(abs_path, "%s/%s", tmpdir_path, TESTFILE);
>
> 	...
> }
>
> Which allocates the exact sized guarded buffers so that the canaries are
> exaclty after end of the data, not at the end of the rather large
> buffer.
>
> We can't pre-allocate buffers in the tst_test structure for data whose
> size is not known in advance, which is the case for the tmpdir_path.
I have overlooked these issues and will make modifications based on your 
suggestions.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
