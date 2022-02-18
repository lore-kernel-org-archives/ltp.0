Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC95C433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 02:15:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A3153CA0A9
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 03:14:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88AB93C574A
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 03:14:50 +0100 (CET)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 60C7560220E
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 03:14:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1645150486; x=1676686486;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Rc732/cjPf9MnFjOB4yRpJQK3Z9QLozkJ+qO8Vf6eJY=;
 b=yCN8xXcQCGt47P8YJzcqPYMV9IXrS5xEFBdz9aazlVnDCiVHSehhMkyG
 oIwL2F/KY0AJfAZbkQvrm60hZF+uioANUuU9r/691OrsBZk76BZMPVaIl
 ZTRSVIf5GhHAjYDwSRBk/H3PqQznJVv3ozGSvBVgQ6ZXr7H7Zo2JAZRs0
 +MNhRcBsAEBpZUpF+Tf4CMrz9mqVgnHSEciDM1e4vhOV17QnOG4GRZM+Y
 k1RwhEToKzG4Z+faMAZOOPI9103IDid8UExlueie1rGi56fOwMVOTg+Ct
 gyXmbbUYMepmb6trIqaBa/zuDbCf4U/5zf9P7XKwBmh1Hn95+xROmixWw A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="50006192"
X-IronPort-AV: E=Sophos;i="5.88,377,1635174000"; d="scan'208";a="50006192"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2022 11:14:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW4sZalGUdyNzSrVc5isCW45t7EVxfDnsP5kEsRAgrLGUI5gAswcVvy/aQJGwtsU8l9dw7N+JGoQ87gHD3WAUPXCKNyxSwGbnS92aq4LiXlGR4YqHHeXmFiguCScZu0oQkJyxEayO0YifQcjtVddA2/HLyafi4etmPPDtR+rmN/zvhZk0IU37D6NgP6hphG/C6wJAz7lddKJ1Ma59XfPDzq+Ka8JXnVWvFxr8cQ23dn6in9BvcDj4/fzfz3ij/Om7LVkmY0hw+vVTynnGiWl4qtcisXcuLFYiRS20LFTpWfRMCZNJtDT9q9WGGhhFg6Sdm9Cg5LEOmwu4jiPCGMtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rc732/cjPf9MnFjOB4yRpJQK3Z9QLozkJ+qO8Vf6eJY=;
 b=FRf/R+aH752j6PLcLlOmfb6n7KiBgK65Lj0O1XQAGELbPQ98VXD3FbJ/0nWe0grZuvFS+LrjLqOXNCbkxb+ewfNr6ESXNNJ2BlPD5EaEWFPhg7PQ15DICPKimTzlnie7GPK+sLxZndIkFIOBG4ztZfEQtSkAEPjN58o9g7ReuYtCv4mxB3AYsBWaFZp320qKTwLSzkplSAXmUq1xptVxXJO5K0XJyEz5v95gcLUpKuQP36r7AEEXASLsx/+xPkM4SK4u2sjzTPCh4nTob+M1Ig2y0ciTIhDikJFBn+RT8rxMKVg0sKgLZjeWjElkQqbYuSeqN/RDCEfZ1ppRMltLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc732/cjPf9MnFjOB4yRpJQK3Z9QLozkJ+qO8Vf6eJY=;
 b=QZ8Jmy4+CysIXQR0yQpWSumTf+VjneE341ZN6IvNkhQbEoJR2pJag9+ciPk9Rlvy6p8Q6bwocqFgn+rt+kBAGsteyidOo0wbRGroo+mhVlRaYhcBmHQTtoSJH6pNjM3IF6Y6HZFdPIdJ0fx5+PiOOgoA/cpznilIIyNYgmp9yG0=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB2706.jpnprd01.prod.outlook.com (2603:1096:603:3f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 02:14:40 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 02:14:40 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 3/5] pidfd_getfd.h: add fallback
Thread-Index: AQHYIxynn9867dZTwE6QitUJJuKc6KyWN1YAgAJdM4A=
Date: Fri, 18 Feb 2022 02:14:40 +0000
Message-ID: <620F0139.8080703@fujitsu.com>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg0FjFPfTOXxUbWx@pevik>
In-Reply-To: <Yg0FjFPfTOXxUbWx@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22a1cc42-4d49-47f7-47d2-08d9f2846bc1
x-ms-traffictypediagnostic: OSAPR01MB2706:EE_
x-microsoft-antispam-prvs: <OSAPR01MB270684B0F9BCDE50C5140E60FD379@OSAPR01MB2706.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FfNzJMaTtdBY3dBtbBustlRu7rD5liBjEkn2/bMhq/KNVYFzemJjIPOsVJbC3XdrUdHU5yuAi6qhl3lLtVs6ahadyhXikr3d60O/eLoFghpEub7/YnLhHsgRBBzpVJuIC8dEwiA+/ZCG+awkmLQipXsxDDNyU3gY55Bb6vkLpkw03yMcpf8hpzExCpoPUSWQAmK3QV82NG21NupBpB/7Nj8lY222K74vrHjkBY2bb29SjVgqJaYHBzjfPrvZkDf4C7KyJzHfVnKWGtylhyNyjUhlyza9ZR0VbNKPOL7/HUTvVLAoA+AZiKMGLIkCe6viAWmbvpg5bcI+lbQ5L1oGMQ/a2GiPX9EbXhwDUrK0VJhAhM9Qw+XMqqMBjhS9xh6Z2Bke9P4Uk+lEVcrz45oAKSyjqRm5h+WHXwUzleCKaEdbTm5+FZYeZGJ5GMPOi1aTjXxRfovn8SOMTpeAUvB3TW0kTTmBHNHly881gkGuVSRiBeTro/TxYGuDjJ6S5yv+ZOWB5V30nKBnT3nVCpNOMWTHVDhpVag0fH1Fj5T7OX9hJJSeeD7YqKQBT3dzYFxL9pLW2Fv/w8tASDz8fm4nDERi/JOTHNT85Lztk2XIF6MZPrUPxcV3cuO1fPFJeFLuQGNZ7LWGrVOIno+J6cbZsDcLnoARKDRHL8g7DjjtjlWYlOnXaylxUAiDNLypsJWWVoiNOlRoTLW7DtU9DyMxcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(4326008)(66446008)(91956017)(66476007)(316002)(76116006)(6916009)(64756008)(66556008)(5660300002)(8936002)(38070700005)(8676002)(33656002)(85182001)(36756003)(6506007)(38100700002)(82960400001)(122000001)(6512007)(87266011)(2616005)(2906002)(6486002)(508600001)(71200400001)(86362001)(83380400001)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MmhQUlErSzVvcmRuVUs4QXhrTjkyb3NBWXgyb29aSlI5bTBtV0lGK1FLRTA1?=
 =?gb2312?B?TmlQTVkzcXNCcnJmOXA1T2pJaXRzT3NDd1dSUHBWbVZreUlLN2F2Vm1rQzR0?=
 =?gb2312?B?OXlqR3ltaExYakxXOEtJTVdCWWJoK2Y3dzh4RSt3NmE0US9ZRHQwZXdwNlFH?=
 =?gb2312?B?Z2taTG5xUHE3U29NNE5IZFM1WnhualVqYm5Kd3RqampQWHhjc2NVZXU5Qyt6?=
 =?gb2312?B?RUtRTlVuLzBGc3NRc3JqbXpJZHd5TkpMTXUwczNyNFZqTFdERUt1SHAremdG?=
 =?gb2312?B?azJLcU1ZdmxKcGhycWF6QW1mZXF5V3d6bG83ODhxMkI2ak1KYXIrL2FFWUxB?=
 =?gb2312?B?Z2pkVUQrYzJLdm9ZWnR6bWtIYzlENStCR3pyZnV2Q2txKytlRUVJcFY2K0FY?=
 =?gb2312?B?c0VCSktZQXNRWFk0bUg1bzkxNHJrdWJvbUJySzh5K1FWbGh4QTh2Z3Y2RURn?=
 =?gb2312?B?SjAvTFFPeHl3WE5OeE1EZUxhdytNenBzVnZPbE5CNEs1b0lHQjRaME5pZzAz?=
 =?gb2312?B?N0IyZWM0RG5uQ2grWjE0dVBYSVQwNkVjWHJpak81UEFnUGIxeVkvZEF3ZGpo?=
 =?gb2312?B?bTUxZFlwbXdqU010N0R1ejA0SmZxb1V5VXBQbW1qTUJHdEdiNGNvbllKL0Uy?=
 =?gb2312?B?YVBhZ2VlS1dpRkZZUnNqT2svNmpUUGNRM1JTNXdqaDZXanQvbm9mQ1pDbjg1?=
 =?gb2312?B?V1I4c0lYN3VocitHeHdWYnpkcDZOYXY0dmRQRDA4Q3oreFFnU1FqZis0V3Yw?=
 =?gb2312?B?Ulc3THJ1eC81S0RlK3JZYWoyM2RLRVJXVzZ2cDNTUjVXVWE4MkhXRXRxT0Vy?=
 =?gb2312?B?VGRnK2E0MUtVVERCWDdSZzZkb3FuWFdVNVJYWXI5Y0s0SitIOTVJdFRoM1Bj?=
 =?gb2312?B?V3Nsa20vTSt2K21rK2xYRzFocVhjNHB0ek92a2tOc3NrbFA2cVNNY0I3RllO?=
 =?gb2312?B?eVpxa2hKNTZ1WDY5NHhvTHB0SHMrbDBwRjVIZCtoRUt3dWVwbE1Xa1FRZWVw?=
 =?gb2312?B?RlFQK1dFWjBuS0RYUU40ODBlV21BVmxiaU1wb3dNMS9BajE5bXg2Sk9GTUw0?=
 =?gb2312?B?c3FwVXZDKzN3dXg4VC9XdEhLNS9yL3NUbERlbVorTXhjYUJVYXVBYnRmY29w?=
 =?gb2312?B?VUpMbmFxMGpqUTJ3bENNV1puUU9pTGlTYmd5QUM5d3Fxc3BqQWJ6ZDlXSzV1?=
 =?gb2312?B?MzRuRlNSUlhiSXluVmxMN1dnbkYxWU5vSjVrTUt5RS9EbEFLMWlQdE1mbEta?=
 =?gb2312?B?S1FlSUx0MlFESTYvUHVIUE84bHRyR2VEOWlQSFBSVzNWSitJdlNSZ0V4Ym9n?=
 =?gb2312?B?b3Z3cGhrTFBZUytjK3JyVGZrOFVDbGtiWVFQZnhaOXFDRlR0a1J6ZnlvSFpp?=
 =?gb2312?B?TGF4U1N0emJLYXF0UkJzYURGTkh6MlAyOGpiMGFBOXcwVy90dzhmWm9HZ0RJ?=
 =?gb2312?B?Wjcxbk80am1rWklka29MVmd1QjZoRldvNzNPcC8vSmJkc2JObEdaWWQ2S0Rs?=
 =?gb2312?B?SittYTR6UWZzNUFkTXc2Kyt0Rm84Zm5WWkNuVEpKQnNObXJvVlZlWmVZMTFU?=
 =?gb2312?B?dEtHK3ZDUEUwS3diTSsxYkJkYWdxa2kzRHE2bmZDcVlKYytRaGEyVm9OSmhL?=
 =?gb2312?B?T1BSYm9FUDJLMDZJQVNlWG1vNCtxQWVDWXhKTmU4VjZCc1lNY1dkbHY4U2hp?=
 =?gb2312?B?cGdiYjhkQ1NEZkpwN2ViTTczdnp5cEdWTjdWMlVqUlhIclRmWTU0dEV4Qkt4?=
 =?gb2312?B?YWdOaWxCVXpUaVpqc2hrK1hUeEo2MHdWUW40UnRaWkVXYWRVVmE0U2Y0NlVw?=
 =?gb2312?B?QkdKMVFKVGNlWnZkOVREZEk4MFVITmtKVXp6U2REa0Y4NXNqZzRBZGI5WDdr?=
 =?gb2312?B?Rno1UlpFUDBmK1d2VTByTU5MTktqYTlNdjk3bzRNbVNOTXErT3JBNU1Pb0RW?=
 =?gb2312?B?NHZTVm83ZGtlWkc4clZ0VVp6cGNZY1JBQTBHNnBpTWNkbTVoSW1JeVFWelBE?=
 =?gb2312?B?M0NlYWZYOUdCdlNQendBTGJGNGk3RVFtNVM5Ums2Nk9pY3dHTHdHSUhpdVFO?=
 =?gb2312?B?b3RMNEpPWWdOWm1yaXlBMVVCbEdvK3c0U3Bjbkp3aXFZM2pNN0xTbWJTNG44?=
 =?gb2312?B?MWk3N1FoMEJhbCtGWEdMRUJzdHNmaURaRUl2cFUraFRNTjR4TDA5QzgrUkta?=
 =?gb2312?B?ZW1kMlZjdzBBM3JpejNIdmc4SE9nY2dPWXZuTlNSbHZUbnJmcjAyREdWbG84?=
 =?gb2312?Q?v93/SrgDmW6+kfHXWu0TsOCcOZn5yWHJF1HAQ1yBIw=3D?=
Content-ID: <26F51AEB2EA2BE41B541179D2DB2BAE7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a1cc42-4d49-47f7-47d2-08d9f2846bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 02:14:40.6757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WuZbfrc7rj4PlAe3A640z4+b9UsxzKzWKIAI7v09gbCgWFTYwREhg9JWctvbY48QySHOeQYybW08PpoHa6ulLVEWhUG1eEua69I/5YfoYqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2706
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] pidfd_getfd.h: add fallback
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

Hi Petr
> Hi Xu,
>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   configure.ac               |  1 +
>>   include/lapi/pidfd_getfd.h | 26 ++++++++++++++++++++++++++
>>   2 files changed, 27 insertions(+)
>>   create mode 100644 include/lapi/pidfd_getfd.h
>
>> diff --git a/configure.ac b/configure.ac
>> index 8d2c5b1c4..49499704e 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -115,6 +115,7 @@ AC_CHECK_FUNCS_ONCE([ \
>>       open_tree \
>>       openat \
>>       openat2 \
>> +    pidfd_getfd \
>>       pidfd_open \
>>       pidfd_send_signal \
>>       pkey_mprotect \
>> diff --git a/include/lapi/pidfd_getfd.h b/include/lapi/pidfd_getfd.h
>> new file mode 100644
>> index 000000000..1f488a518
>> --- /dev/null
>> +++ b/include/lapi/pidfd_getfd.h
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +#ifndef LAPI_PIDFD_GETFD_H__
>> +#define LAPI_PIDFD_GETFD_H__
>> +
>> +#include "lapi/syscalls.h"
>> +#include "config.h"
> nit: IMHO it's better to always put config.h at the first place.

Will do.

Best Regards
Yang Xu
>
> Otherwise LGTM.
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
> Kind regards,
> Petr
>
>> +
>> +static inline void pidfd_getfd_supported(void)
>> +{
>> +	/* allow the tests to fail early */
>> +	tst_syscall(__NR_pidfd_getfd);
>> +}
>> +
>> +#ifndef HAVE_PIDFD_GETFD
>> +static inline int pidfd_getfd(int pidfd, int targetfd, unsigned int flags)
>> +{
>> +	return tst_syscall(__NR_pidfd_getfd, pidfd, targetfd, flags);
>> +}
>> +#endif
>> +
>> +#endif /* LAPI_PIDFD_GETFD_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
