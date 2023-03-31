Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BD2C76196
	for <ltp@archiver.kernel.org>; Fri, 31 Mar 2023 12:57:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0E0F3CD0BA
	for <ltp@archiver.kernel.org>; Fri, 31 Mar 2023 14:57:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84F623CC94C
 for <ltp@lists.linux.it>; Fri, 31 Mar 2023 14:56:54 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0AC5B10004B9
 for <ltp@lists.linux.it>; Fri, 31 Mar 2023 14:56:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1680267412; x=1711803412;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SU/9P9uiYmPFTWa4C4UGt3/qfxZ+dAc0BMRb7XnjWsM=;
 b=zJZI2SFeNncUcGURfyikkzlYaGxGiYOKiC1SMq8mLqTD37xYUtXRHX6O
 5ObGUTMsIYX9PoiJ6s6wBWRoEKGJWvT588VKYivpS0xSleQPbYdncex2L
 bw6MxYLejx3EGSdEiXBbg5C6prjMlNmDSZ4EA20QpwGnN4DkYeoRM/xrg
 9lMK28rnMLVnTJ0mUoOaJ3ET/NNyyxrK8JHgCeG4KyVYiTP4MiD6CJBmL
 IrJFGFsEQCH+eW+dxxjYKGjvYsx18/Im/kyb8fQC433a8N8PcKgOK3bnP
 OObEIVXWVl+jd64I3Kv2KbFBoWx4hbzF/y+dJtXc2ZygjLGK13yfOYjFH g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="80872385"
X-IronPort-AV: E=Sophos;i="5.98,307,1673881200"; d="scan'208";a="80872385"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2023 21:56:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8sqzamhB7AwfUK6AyeEUr8JuVxgFncqEYkaYNrrSfn2ATiqrP/oayuAe74tbkOvxhUK76yDv8PDyqpK1Vp30XrDS8e6wVg3yreVlfOw9P8wu0SW8/G/61nbdJ25fSmKaS/XY0czNToyUJxiLurB9xybPiiQorzta6YZ4Kx84ZWmrYRqyuRTr6KiQyTARk3ejLg/YNHU5BGHBXf97Hr6HK4a49iqDFByK1Qvvh6NJcYZBpdHkkev6DF2cKAZ8BT7nWJngZlZn30dj0Zjuret+0Jy15sCAxCuTJF5L+CfyuSYTUtEd8GEH+X4ArQIZoum4hzwTJ6Ee3bEKJ2srUgSYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU/9P9uiYmPFTWa4C4UGt3/qfxZ+dAc0BMRb7XnjWsM=;
 b=hFo7CsC+mR9Z0N/AAMi1nqt2pS5r/V5O3x7WQav5+s/dBVF6nuLLJylNaM+7Tnt3ZZ3hvB42jsIf+MEocsV7uLmK8WV5V4/jIMyro0GGkeizazM8ltE3HPuLBgszz3laPaoP3hPVQ5B8aRCCyoDxMzhxYSexHVy6qE5tMhpYUOr1XRR6RSruhzcxCz8Z/ttd23A0X5PAsZwBsUWd2QQlBxPa/tKp8CqUjX1Ml7jBQVVe8sSPT2eCh9R9P3y7QQojOAhePxySGWBdkwTUT22H03TYSGHkQe5001NaBeVr7t8rTvZeCGfmsByelfO5VyfdyjWn8g4yQwtbrht9nsELVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYCPR01MB9523.jpnprd01.prod.outlook.com (2603:1096:400:193::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 12:56:48 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd%7]) with mapi id 15.20.6254.023; Fri, 31 Mar 2023
 12:56:47 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [PATCH 2/3] syscalls/statx10: Add basic test for STATX_DIOALIGN
Thread-Index: AQHZYuDt7kGs9kVmFk61sskzHerwEa8TiLSAgAFSCQA=
Date: Fri, 31 Mar 2023 12:56:47 +0000
Message-ID: <a9a441b0-1774-a15c-14ec-b155bfe88152@fujitsu.com>
References: <1680164569-12114-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680164569-12114-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230330164653.GA881@sol.localdomain>
In-Reply-To: <20230330164653.GA881@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYCPR01MB9523:EE_
x-ms-office365-filtering-correlation-id: da02b3b3-e4f3-4153-9133-08db31e76380
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E9d8mZWTnAGAUj1YpXiA/IXgW+CKL6PJY+oahGRG2nuVG7om745rGlvzm20IRqsgHfCDRvw2SJBji9ww06exPitQij1qNobWijGOBSw4H0x3UbHquq9tsA6HO9Ve2YUOHn6tEMIkBjBV2Uay6QqrW3anSRuzNPJW15tLVSl2e7OqxGJ9+hCyvOfryc/eEDeg1AKani2yOsDTLujDaZFBAxaGZmkhAWmXAHX2ymtnAq8fS1xytiZehCwVB5Q8r8AeH/1dEgXMiv6EaBwP9C3v83uVnGHUSOHq58d4Z84Et/XZ41cI9ZLqSkeykYw7FYLttRu3vFS/pnMkupOGkCc+FtlaadzLGzbiSvjG77oErgCHTPA+cM06rG/k0dBJi3oBY/Z3a6Eu+gjfUKZ4e8/Mo1Sp0Z/vxWmjuiT231Xm9LRBcPn1SGMIX6xxAbpzsk4P7fnkWAKxLOKwVddphMq0ycjRgmiKueGtzx0Op4/Qy7GyU+u5uy0wh3JX9KkM1m93b8Yas83hAfe2a8N62kErsXAff5JnIdEDmJnc2XEAdcz5cmsA8XTw4GpJ/ZSVNn02ozcbo6ioMlKYknFlyt7GZDI6R0sUM1M531D9rpjjm1btdWDBd/vOQILMR19VyAc+ZxRiD7K53rL8L2Dfhf90mNRmSQo6+//6SARVcM5y3qA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(1590799018)(451199021)(2616005)(316002)(478600001)(31686004)(6506007)(6512007)(26005)(8676002)(66946007)(6916009)(186003)(4326008)(76116006)(83380400001)(6486002)(966005)(71200400001)(64756008)(91956017)(66476007)(66556008)(66446008)(5660300002)(41300700001)(8936002)(122000001)(38100700002)(2906002)(1580799015)(82960400001)(38070700005)(36756003)(85182001)(31696002)(86362001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFhsTUlJVlRqNjkwczM2V0pRUzBZMElCWGlDaUNFWllRS2hjNndSRVJ6cU5r?=
 =?utf-8?B?cm1rY0p3bi9NaGJucWhPSHVsSTNPeG54NGJvZDJHcDREODFsZUZ4N0l0Z0JS?=
 =?utf-8?B?b2k1cjV2enFpOFZueFI3K001RndhODlMdkhKRWNzTTN1eEZLVlJ3UG5IbUFZ?=
 =?utf-8?B?dldXYnN6dWVWdU9sU2ZSUDFSYmZFdHZuWmlLT1pnZWNSNEJpZ3hsSDc3ZjAx?=
 =?utf-8?B?RE50R3BvWjNKM2JLMzZTZkhTemhjRmdxMFFQbzFLeExBd3VycXhCKzBCN1dT?=
 =?utf-8?B?TzdyL2pCVWlMV01JVzN4V2p3bFRYNTV0V2JDZXFEYVQ2bTVndm8wYm9hNkF1?=
 =?utf-8?B?dHhQMG9RdnFQMjM2UnRUYk1vdEwxQ00yWFJ6OENkQjJURmFMTjNUOVV6SHFJ?=
 =?utf-8?B?VFVaa3RHNzVwR3NSekZnYkQwMmRId3FZMnhYdHVNcUxkOFljTFJRVWtDcXk5?=
 =?utf-8?B?UnU3WXR6dmpTU3cvdXBEZ0JUWldwY1FHMi8xWXBIUmlVakJEdjJ4cWN6RkNC?=
 =?utf-8?B?VHpBMTdQRDVuVzJXR3llUmoxdmpoZU0rRjMrZitRbEFiL3BLVjR4YUxlVmFD?=
 =?utf-8?B?dDh5S3I3Y09PSHVOeGpieEc0UDZwQWE0SVFjWlNvb0pHYkpobVd2aTZWMDVM?=
 =?utf-8?B?dUViVHFCTit5TytxVG1zWXltRHpLL3pkVzFlWUJtWlVpQnF3WXRVUnlOYUJ6?=
 =?utf-8?B?NlB5MEYrS3piZ1NHRVE5dFUzZ1NwUHhhZXc1ZFpGQWZGNkp5QTV6WVQxZExE?=
 =?utf-8?B?eVVwSUcyak9YbnBoZEZ4TnN4ektWTE5TazFqN29jQno1czlJZ3VkSmF0elE0?=
 =?utf-8?B?ZVF2aG9sanVQa3hKR1p6VE0vclVzTVIxaUQ3SXhjVzIycHRjam5RRlNaZFll?=
 =?utf-8?B?T3hjY3pJL3Q4MHYzTGQveVZnREtzbXVBeHFBT1o1SndJN1Y5SDAvWitneUJE?=
 =?utf-8?B?SllvSUNJcWlES3lESE1IcTJKWTVJT3dqay8rMFJOTFFUMVpSRlJSTkpDdEsv?=
 =?utf-8?B?RU52Vm5MZmlMNHo5Z0xwSlpMRVNGaDZadC8vdjMzZEJHaFByc2JhaVc0SDE0?=
 =?utf-8?B?ajR5SU5Ma1p1WWJQdzZVVkNvVGpGS0thQlFhQ2VXRXlITXdxa0srYTNZYUF5?=
 =?utf-8?B?QWxHbjZFc0NPdFdOQVhPZ0V1Z3JFNnJCNXBWalJnM1ViVEhraE1BRHJoRFcw?=
 =?utf-8?B?cTM0RUIwZStkdHBwMkxSZDVQbTZJRmVXOHhLWlA5eUhjYVNiaUNpR2VsSENQ?=
 =?utf-8?B?WUpNWkJpb1ZMUkNCY1N1TmJtUU51R0NjbkxlODRGb2w3d0g1ZkE5THA0WG1w?=
 =?utf-8?B?aG00ejJ5NVZiN0lWOUN4TVNWam1DTVBVakwrQjdud2Q2VktJVjNwOXFoT2F4?=
 =?utf-8?B?bTRsbTJIellzRGFrMHNmQU0zbzF5c2pZNlVOdnl5Q0pvZS9CUGJtbUVENHdS?=
 =?utf-8?B?aE1nNEtibTlwL3dpK284OU00MlNYVDhTQjVzZHl3K0FleUpLMnYwa2RNRy9j?=
 =?utf-8?B?RTd0LzBjd2xrZlkza3hlL1RlZVVvWEkvNHp5Z2s4RG0yQjFobFNuYVE1Q3M5?=
 =?utf-8?B?c2dLdlpMaWJlMUloTWg4ZU1qVS9xT1AzdkxUNHlNUEc1YnhwOHNyUS9Bdy9M?=
 =?utf-8?B?ZGwvcUxlWXJ5YWcvTmYyalpVeWZPLzVrTzBidStteU9LQmY2OURmQlprMHI5?=
 =?utf-8?B?MG5wY0ZqemR6dkFjZjlaNFlRWEEzVHhGcHBpNnBNZjdJallwejJpenV6RG8y?=
 =?utf-8?B?V0l1VVgyRnlHOTVOY05oR0NZZ0pwUUJUNmhtTTdZclpSdGdJaTQvV3JJS3Zo?=
 =?utf-8?B?UXZ3TG40K0JyUWI2TDM2NlVBT3haQWZLVlNPdm0yNHdBVkZDV0h6cnFKQzNo?=
 =?utf-8?B?eDVMRStnWGgzRkg2RzMvM2RXMXBuNEtCaDNhM2ZtRlJYb0lMMFZ4NFlSVXo4?=
 =?utf-8?B?U1QzdXlJUHZQUko0Mm1xQjI2T3hZWHVGd0hvYytPNjNKZWRFcTdBQktWaG92?=
 =?utf-8?B?Yk1tQjd4UTJ0SkFYajlEb0F3WlVBcENhZVRPYVhKdko1UHRqNGhUZVhxMUww?=
 =?utf-8?B?Ukd3UEVoa0xBN1pqTlo3SldURHNYWG16UW1rT1hDUlBNQ2djTzRJQjZOeks1?=
 =?utf-8?B?REdtd2ZQb1F6ZnN3MDVJakNJczlkdW95QkJqZWgyamZXZEhLaFdKUXgvelRy?=
 =?utf-8?B?L0E9PQ==?=
Content-ID: <9CC2CEE2F1703B46ACDCA08DC102BA56@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Kd6drC6rXTVKUemR8SVBPIBRvRELbAPKP3ONwUa/RN2fSyXQCr82/t0waFkiDNGeCtiUeaKKeemDhzD2jia0KH5a6FVn4clCuiofpLPPatXJNba3lJQ2Qf5AW4Q4MFBhwF6+uNmXJh7ezXaNLv+4zJS4WucDLEP+6WeG2lhslpQERBT+O85HZDWYexSJE3qz9Zo5eKBFrlotvkRRk+1MhwJZgJno66YvnFk9SWHzHzWi9P3QfALdoH2FlAj/uKLGakw9TPmD/E5t+6NNtLKV6bTFIr3RB8JDCWyucfJGJoTq8/FfSPv+YlouvzL6j3KrnyJJFGBZ4C3kWtR3NKIwtxDSCt3tYdLO56K4/doYix8eMxFJQRb44ReAONQdvLipZZ0le1OG6rhv/8deNqANWZyv190is9wxGDJ7ByYj6HcHjukRMZXSmWn56ZhJKTB23NHWUH8kn96csmK5+WarUL5R8j6QyZzuzhjjnUXKuoraQl/yJP7F20QHfytQ9EpUrY/tiQ9wcvOpQ/2krPI+cO4AxZY9fnmNM4ht2wGedrkr4wzGPrhkdIkEzZW8451ygbgjkuV9d4Ny+c9ATcNFep5r2MWOicPmyRLO0nKzoMaPNDXuqoTdd6PP0Y5FIRoDuwvSnRAEiMkvvlgeOl0U3P+8NEVJsvtlKHehHG9N+J1USOwZJJ/Q+eOdb+rNgfXfu7ceWw0NwISl3at59WVWuVoJ8NsI9h9lNGR6D/Lq8G2KcDlBnmuZLIFBgO0UJ3lOGx/D6tvyK6/Tjq8A0ydYaMoNQ4gbWuZsRJ4kA62t2iQ=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da02b3b3-e4f3-4153-9133-08db31e76380
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 12:56:47.9494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XK1Qqx0FfrurmG3GCdUrmUttJSWIKKDqQVb0DOZJ0Ve8YVEbKsTqhQdN8s4eY2dfFLDeAtlm5Dj+OLmCW8qNC+gTWxhnzeWL7suzzqbtZi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9523
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/statx10: Add basic test for
 STATX_DIOALIGN
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

Hi Eric

> Hi Yang,
> 
> On Thu, Mar 30, 2023 at 04:22:48PM +0800, Yang Xu wrote:
>> diff --git a/testcases/kernel/syscalls/statx/statx10.c b/testcases/kernel/syscalls/statx/statx10.c
>> new file mode 100644
>> index 000000000..7a2c92ad2
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/statx/statx10.c
>> @@ -0,0 +1,81 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * It is a basic test for STATX_DIOALIGN mask.
>> + *
>> + * - STATX_DIOALIGN   Want stx_dio_mem_align and stx_dio_offset_align value
>> + *
>> + * Minimum Linux version required is v6.1.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <sys/types.h>
>> +#include <unistd.h>
>> +#include <fcntl.h>
>> +#include <stdlib.h>
>> +#include <stdbool.h>
>> +#include "tst_test.h"
>> +#include "lapi/stat.h"
>> +
>> +#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN
>> +#define MNTPOINT "mnt_point"
>> +#define TESTFILE "testfile"
>> +
>> +static int fd = -1;
>> +
>> +static void verify_statx(void)
>> +{
>> +	struct statx buf;
>> +
>> +	memset(&buf, 0, sizeof(buf));
>> +	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE, 0, STATX_DIOALIGN, &buf),
>> +		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", TESTFILE);
>> +
>> +	if (!(buf.stx_mask & STATX_DIOALIGN)) {
>> +		tst_res(TCONF, "STATX_DIOALIGN is not supported until linux 6.1");
>> +		return;
>> +	}
>> +
>> +	if (buf.stx_dio_mem_align != 0)
>> +		tst_res(TPASS, "stx_dio_mem_align:%u", buf.stx_dio_mem_align);
>> +	else
>> +		tst_res(TFAIL, "don't get stx_dio_mem_align on supported dio fs");
>> +
>> +	if (buf.stx_dio_offset_align != 0)
>> +		tst_res(TPASS, "stx_dio_offset_align:%u", buf.stx_dio_offset_align);
>> +	else
>> +		tst_res(TFAIL, "don't get stx_dio_offset_align on supported dio fs");
>> +}
> 
> Thanks for writing a test for STATX_DIOALIGN!
> 
> However, the above code isn't actually a valid test, since stx_dio_mem_align and
> stx_dio_offset_align will be 0 if the file doesn't support DIO.  This is
> documented in the statx(2) manual page. 

  I have reported TCONF in setup when fail to open a file with O_DIRECT.

> Filesystems aren't guaranteed to
> support DIO, if they do, they aren't guaranteed to support it on all files.

In this case, I only test a regular file.

> 
> I think you might be assuming that STATX_DIOALIGN won't be set in stx_mask if
> DIO is unsupported on the file.  That's not quite correct.  If STATX_DIOALIGN is
> not set, that just means the filesystem doesn't support STATX_DIOALIGN.  In that
> case, DIO might or might not be supported on the file.  The filesystem just
> isn't making a statement one way or the other.

I just assume that for a filesystem that supported DIO. if I use statx 
with STATX_DIOALIGN mask, then I can get this mask for regular file  and 
also get dio related info on new kernel. For old kernel, it should not 
be get.

> 
> I gave some thoughts on possible tests for STATX_DIOALIGN here:
> https://lore.kernel.org/fstests/Y7fU4pRA+LHhsMKj@sol.localdomain/
> Can you take a look at that?

When I wrote this case, I have seen this email(I am also active in 
xfstests community). I got this idea that test nonzero fields for 
stx_dio_mem_align from your email with Boyang Xue.

Best Regards
Yang Xu
> 
> Thanks,
> 
> - Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
