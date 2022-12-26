Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEEEC46467
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 02:07:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AA053CB8F1
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 03:07:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D94983CB8AC
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 03:07:24 +0100 (CET)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 62F141A0027B
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 03:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1672020444; x=1703556444;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tvSDdd6z2vQvT2VNjl9u4BHmu5/sO/+/jitvPqzQYVk=;
 b=DXewI4r+cTzWNXpLVVqKjXG7MLsuiT8W+DV2zbSmRG5h3AJgZSj/cVXA
 GpHKZ95rOfyDjP2AvCo+FwNMLgURcap379arH6EK9vr4Mt/c8I7yKsrjT
 xafRqPatLhqyG65za05aQZFyzXNSfpNM6MTvITiTvzO+LYCgOsOJ1nuqR
 EZ7dz9D08wl8AXgRNds0uabi6Eg40eylSYW2YmIbOS14ObwX//PFc9ZP8
 04fLvIPOVS1ZgGU/Rzp115rRVnJu0gIPL+zxgg1Iwm2NnJdtbDXw1cC9Q
 ZbzMktFVwCN5U+SQ/LtiCVtP7KOJfYS6Oez5+9rp3nLqryvxAO1vz0pD7 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="73189212"
X-IronPort-AV: E=Sophos;i="5.96,274,1665414000"; d="scan'208";a="73189212"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2022 11:07:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHvV/Xwo6QROi7M8Dn5oFfcyHRWfEVS/KbS2p28FfMdEqSF33MasoFb6G7hNlcF4RRSf0rBlDSJ/19hZDaXwBdUifD/KNnyWqyRe7arD69iuWwCR7XkTNTxuamd3MVenahwSsc3kdBOgk7zl/krBoIxLVmOmmEX5egXbYNCgUvwNENkUQX/M/QujHKxjfHFIs7gBHHG1g2tfdzA1OpO6Qw0NQnqlh0l3DbqJ+/kKmHqmxYEzndFcHzSaAYE7Mayd5kBOE/+xX/1vOEumwTPzSO/pI7mhxa+dZVVoIlU5HxA8yDQnOz4irBpMPgqDipBJRuGDhWbGRi5+VApENwa0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvSDdd6z2vQvT2VNjl9u4BHmu5/sO/+/jitvPqzQYVk=;
 b=mMpjNGJuQpoAxoI2eP4x1pYAu9wqxF8ZPfly5gE6vuqUl0R+hmbRYFZQqblKwZHXisVvqMturC0Pn4MsdgulU96erJuIZHwVxGG4xU92bl6yHFc+tJ76jrZbDcW7l7SCzZdiYXkzAlDbaFlcHt45A4dWiku5QuoeqrqUI87pUand8t+yIU1MjbQ3OaiVjL/k52MrSk6wC38W7GzGdw5t+r6DN/vL2C7/Fv3WFu1ow5XGMXfltjM/LGoR1r5LRV8t0+GqCwjeSLc0977PHcYpKeOhK/+Oj45fXh7rQojlsNoRYOiBIBMIk0G/urtOSTIHNRlJ/5z9hI5G8WdXl/G7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OSYPR01MB5509.jpnprd01.prod.outlook.com (2603:1096:604:92::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Mon, 26 Dec
 2022 02:07:17 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%7]) with mapi id 15.20.5944.016; Mon, 26 Dec 2022
 02:07:17 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Jan Stancek <jstancek@redhat.com>
Thread-Topic: [PATCH 1/2] tst_kvercmp: Add rhel9 support
Thread-Index: AQHZE3FfTjj0t9E89EWQ1VWDxwl6X652YfCAgAklwAA=
Date: Mon, 26 Dec 2022 02:07:17 +0000
Message-ID: <4de9831d-a76c-81eb-182d-569f4775f571@fujitsu.com>
References: <1671434187-2038-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAASaF6zD1dWaRHkpkQtXU1Q7EDZFfayJFSYsSMsd3SbY_H8sAQ@mail.gmail.com>
In-Reply-To: <CAASaF6zD1dWaRHkpkQtXU1Q7EDZFfayJFSYsSMsd3SbY_H8sAQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OSYPR01MB5509:EE_
x-ms-office365-filtering-correlation-id: 7a06fe15-e914-41e7-f323-08dae6e5e9f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 34Kl0QBA6U7V8BN8431nuZKebgEWopcSVsg6AQNlJYpLJxUcdDvLBkOjH5vl9j/X68GcQOtPCrlr+6WGMa7bM8/PP66RxjwEksdXTpe763yioArbIHByzD66spV05V6ZN+lX3uu0pFWfkeLHHtbYJqeVm72rfx7QjDwkw8gDB1aWmD4kDTjWS1g1wybEanuwKzQJAdbBBhtS2E1lQ6d4AZsn9JDI360iU6FpOREqzWJ3bX3AB6yzFon2is+wl3Q6pT6aiVCVLW8Lg3r0UbCdPAgU5ugxV35kxsNITt55UJopjlhnJd+sC9afnFNY117NY9iryPBuLQrY6TI0Fy7bheM3vc7ohfoYkzcQZhoiRqiypQWa8l4bFzrBm16xzGBTvexH9ldALE4L7fGuu/xjB4u60b/O3a6lPCFceeS27DyKBaYY5vUwX1VzN3717L4A7kLn5+VOnfoH2OeHqY0CHy8EVXzcEcct5Kq56BV338ksINXYGXodmQ5AOfxhRhn4UjVJxGbu9Hq9pQMMmjBBtkR1a5HdpNXzAwwfMz4FOIhvZk2oDRdgc0WiFhYdl5hqjpqhcCqHWXtYm7iyYjgcKWhSRqTPE4NHjmnfOKQLHl3MDhSqTkVpB8V688rVwPnFTg79Pmc8jHbP4eHsVHltshBUrY2YsiT2F3Wbjh8oFkc9gWSXopa7+qlZ9oYl7oR52OX14lf9t9zF0D6AOH4z/yV8D0jc2k9coC1+y/FHgYzIKIzJmBy6XRyFaf5jb4fpT31Kbcy9zAVjW6f1Qm1ByQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199015)(1590799012)(91956017)(1580799009)(31686004)(5660300002)(6512007)(26005)(186003)(4744005)(41300700001)(66476007)(66556008)(66446008)(8936002)(66946007)(76116006)(4326008)(8676002)(64756008)(36756003)(54906003)(85182001)(6916009)(2906002)(71200400001)(478600001)(6486002)(316002)(31696002)(86362001)(53546011)(6506007)(2616005)(38070700005)(83380400001)(82960400001)(38100700002)(122000001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWxlRlhQSE1jNi82VHEwMjU3RjQyQ0lHb2pQZWxER3l0UXNrNW1jT2Q2SWd6?=
 =?utf-8?B?UVNxSzMrSGI0TTM4U1BUTHJNTlIvZVQzbDRKdHlwbE9Ba0F0Wjd1dzhQYTkv?=
 =?utf-8?B?MENTVDZMTXY3RXpCS0lRY1VTeTlKTjk1SzBzM0NIRmY1Q2lZZnBKOTNJenhi?=
 =?utf-8?B?V3VaSEZWbDFDQ0JxTTgvMVJPVjBzUFY2WnlzWkdDODRiWU9vQ050QnpLUVov?=
 =?utf-8?B?NFJrWDJCSzlEUDBxVGg5TDRVSEpWeFpPMXNKM1I4YndFZEZWNlRoMVBEcSs4?=
 =?utf-8?B?czlGalFYcmJ6NVdRRjJYZlpaWVZ3cGo3Zm9kNTRZaElsNDBHbEtrSksycnFB?=
 =?utf-8?B?bUdIYW9OdXZYTzYrYzNGTG1zNEFrUzRvMzh4Z1RnQ0VYSHh3TEdjdFpidWZG?=
 =?utf-8?B?YXJrNjhYWUhHb1FJZEkvbkhGUzZEaTVENGJTNzJpZGxyZjBvcEZMdXNtMWpk?=
 =?utf-8?B?MjBKM2RmNGNFTXcwUm5DWG0wNWNsZnFZWHdPL2QrQWNuQkRDbmRSS3QxL3pZ?=
 =?utf-8?B?YUFacDVybFBmTms0Z2tKcFZUYzAzeHYyZEFvZnNPYUd3WVlmY242SmJwdFAv?=
 =?utf-8?B?UVpnQ0x4bFdrc0ZubFduUVZWQUIxV2x6c1pHcTVEcWJ0QURnWjl0aGZwT0VF?=
 =?utf-8?B?ZzdEaDlXYytBV21kd2VMMWFxUTNYOUhnZXFZc3BVNGlKaHFBa0VBcVVvM0Zx?=
 =?utf-8?B?UVJ0d0d1ZTlQVEdjd0NNbktrNVNPcGptY2JQSm4yWHluWGFvTUtIWk41N0hq?=
 =?utf-8?B?YXZlUndBUlVKbDhFVmlEL0plbTlsM2Y5QWFaRml2R3N0UEZadWhkUS9RYTZW?=
 =?utf-8?B?SnNLbkp1WVJaeGlUQXVRTUNVOU5GYS9GUzVwTDlINytNMWxvc1p5Umw5MnFZ?=
 =?utf-8?B?Z2h4cm9Rd216LzRGVy9ETUpaZ2NDTzB3QXRxVFI2UzRqbmxyQVRwNlh4bkdG?=
 =?utf-8?B?c3lvbnB6RmNpZ3dnN29mNDRTWHltSTQrMTZMem8xQTZMR3krSytPQkVzeTBa?=
 =?utf-8?B?cFpsMHFkZ1FDZlFpd0JlS0RkRTZsWDNHb3RtUUtHSEc2RXltbURCK1pEc0V5?=
 =?utf-8?B?RW52Qkk4eWNTRjIzVGNzV1c2VDcwbElQc1k2a3N6RUlVOE1EQ2Qyajh3aHpQ?=
 =?utf-8?B?Qk16UnFlRDJWM290NXhMWHlZL085SE1HWUk5VnRRczd3dk5ZWCsxaFdXVS91?=
 =?utf-8?B?cU1lckp4WGtxWE1LbTZDcFZaUGFuQnNaeFhQNU9DTFN6QzJEZ09SZ3NvbzQr?=
 =?utf-8?B?V016ZG9GR1QwVmIrQ2gyRVpQSm4xODkzTU5CYW9aOW85Slg0OXplS1dtc25w?=
 =?utf-8?B?VjNodTFOb0Z4N29YNkRVdTFqREE0Q0tuQ1Vlc1JPYUtNS2pQaWd6a25hY0xQ?=
 =?utf-8?B?Y0UrOVY2c0gyekZYQUxtQW51NU45UytLU09JZ3daakg4bmdkc0FnbFl2RDl1?=
 =?utf-8?B?ZUwraTc2MkZlK0dNenQwc3NCMjVWV25nZSt0YkduOTROanZlOUd0V3JhTEdw?=
 =?utf-8?B?eVJRRFhOaTZ2YTdOd0pieXY4SFRhNHNPN3owQVR5cjhZUzdob0RnYWYwaDlq?=
 =?utf-8?B?bzZ5ZXhHUWVtcmJHQ0J2dkhYWWpGdzNNekNyeW1peGQ3enIxQUFTc1pIZlMv?=
 =?utf-8?B?ZnZNTnpaNXl2K0RpR1VabEJxd29RRDhQeXBlbVZaanZPMzcwcmNqNmQ0Wng5?=
 =?utf-8?B?WnJEVDJMVFRsYWVTTkVOWmFaQVQ0QU5sNWRwMW9sQzFFdTVwWWJocDVJcUhp?=
 =?utf-8?B?QTlDMXNvV3ZWbjZpUWhxYXI3ODIzOUpBbkZLMWJjV2RaaXd6cWlBaERTR1A0?=
 =?utf-8?B?UWxYVGZaOXkzN1ViZUR5cElKRE4xbndpREpJd2FqN0w3M1RGdFQxeGNjamNN?=
 =?utf-8?B?dkU0QlpCK1NWSW9UMHZLMFgyZG50UE9YTm82OFRjQjNESzZiUnMzakRyRFBk?=
 =?utf-8?B?UUdhSTNBWWxlYko4L1VZYmZVbjg0UEVPcWxwdzhBWFFaMEJ3SEtCY0lkdDl1?=
 =?utf-8?B?dXh1T2dIUm00WmtlczhBdzdpZ3ZyS3lCN1BxenNNVmlkMEJrNlNlU1NpSWEy?=
 =?utf-8?B?TWt2WkFMN3dnc2RGZW1TcjNCbFRMUDEvZE95VDlHZlRLSWo1MFo2NmQ0S1NY?=
 =?utf-8?B?OVhxZDJTZ3BLd3o3MjhmK2dxeWlPN2dWMU9SaFRXZnlZZ2pneDVEKzNVQXVt?=
 =?utf-8?B?T3c9PQ==?=
Content-ID: <ED53E98B4F7F29438BC03B41ABF2D305@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a06fe15-e914-41e7-f323-08dae6e5e9f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2022 02:07:17.2946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Y/zNeF1FUe7hbmtDfILF9epBpvy5n3QIp22I9c4n1b1qvK0YQW1o0Na5FeZ2UUuTvtrgYJvlDGp+77JUFz1xbHN4zlYFVwtIpMzTcb6a3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5509
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_kvercmp: Add rhel9 support
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

HI Jan, Li


Sorry for the late reply, I came back after one week covid2019 sick,

Thanks for your review, merged!

Best Regards
Yang Xu


> On Mon, Dec 19, 2022 at 7:16 AM Yang Xu <xuyang2018.jy@fujitsu.com> wrote:
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> 
> For both:
> Acked-by: Jan Stancek <jstancek@redhat.com>
> 
>> ---
>>   lib/tst_kvercmp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
>> index a01b4332b..552920fac 100644
>> --- a/lib/tst_kvercmp.c
>> +++ b/lib/tst_kvercmp.c
>> @@ -140,6 +140,9 @@ const char *tst_kvcmp_distname(const char *kver)
>>          if (strstr(kver, ".el8"))
>>                  return "RHEL8";
>>
>> +       if (strstr(kver, ".el9"))
>> +               return "RHEL9";
>> +
>>          if (access(OSRELEASE_PATH, F_OK) != -1) {
>>                  SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s", distname);
>>
>> --
>> 2.31.1
>>
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
