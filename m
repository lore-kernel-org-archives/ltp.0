Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8215DC25B08
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 09:34:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D06793C9C23
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 11:34:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9F733C9850
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 11:34:14 +0200 (CEST)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4353B100099A
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 11:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660728854; x=1692264854;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=vTcmag8aNgJ2YijByGSDuSb0oL11MX0xXluWePfsWzc=;
 b=cmslyJ2/jLLUboIzjqx9P6lfhLU9l3EibD8lV4envkZJcy4c1Ldyl1ps
 9f3GM8x4pKzlCndqYCqhQcL4zjsR1FTnSRBZ4bjyFhIR1FniaP7aieYAl
 IimugcqgP4UZgFJaU7Vx1ngrN09XUNbD6SRL6DXVs3J06vXjFyIhE1P81
 7jezbPEpjhCXFDop0BQ74sSWh5NPKMtR7vU5g+q2n1xOxQHpdW9gPepVr
 XyqcSwDZMYUpE6P5H2QhauFj2ULlhyDpUAEXYUgWY3YtvEPNDQ1KYpSof
 f8XEFQutjdF/r5jCQZ1pQAfxo92A+4+FLf5ChsYtm2ettfeuWJv5LEEjt A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="63259277"
X-IronPort-AV: E=Sophos;i="5.93,242,1654527600"; d="scan'208";a="63259277"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2022 18:34:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoWPqBI5e4pZSZKJzSVWSrhNgnTaaOPfcBTHtySgPapo1xwXHIv6ZlM/Is188CeWtwB4wARceWFlcDwrDak0agweH48cOvkd8L6dqcUZaZWcY9bz2Ix3kQTJtjXpZCbz/BycpzBQ/6BdjkfIOqIzL7NNwxWskha8U/Kxu6QLIUqbf5pZnn0H7vY7Az7mPjzWiSKLfTSaJnc9rlxhqzX2vGzzS2GhibwDTgJhIWkksJMcQNbgbZCmYO6NH6dm7Ooo0rodIKbpJncPJX1OL812txFDTSad/nMJ6hGk6lSetiUjjqijfaOB3t62XyDu7C1M7c8MTCpSk77lLbuhZjsAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTcmag8aNgJ2YijByGSDuSb0oL11MX0xXluWePfsWzc=;
 b=Vy1O9QHWYjgSv/D+v84ktfavKaguYtyIXFiICU2eyXrV9v4nUvcP/25gxvUjhiFQquS79KRDJnkE3oJ6rWmVPtjTU+6KYMxzVGAfYIqzGthL7+1dLHO2IzeBfec/dX8lrFulZJCc6pXVDzVL+QC+QfbhqfQ/sdIItCHtIYnMpWiMWBm6ZJLp24lRUmigUIlPoBMgrru/13mVbxle2sOL6lWaxBVBCs+XOvMNlGoURTiBi6vIQWZDXTa0P6XqehO/KuJuYVeO9vgaM0/w389Sc47xdh3heswYjWnnYn/JlBn87Epmw9kRTb0g3LI9lfIvAlYrAgD5MweRQGYhKAm0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB10061.jpnprd01.prod.outlook.com (2603:1096:400:1de::9)
 by TYCPR01MB8867.jpnprd01.prod.outlook.com (2603:1096:400:18a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 17 Aug
 2022 09:34:09 +0000
Received: from TY3PR01MB10061.jpnprd01.prod.outlook.com
 ([fe80::6df6:c041:39a8:5702]) by TY3PR01MB10061.jpnprd01.prod.outlook.com
 ([fe80::6df6:c041:39a8:5702%6]) with mapi id 15.20.5504.028; Wed, 17 Aug 2022
 09:34:09 +0000
From: "liaohj.jy@fujitsu.com" <liaohj.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH] syscalls/openat01: Convert into new api
Thread-Index: AQHYshYiwpXy5qriXUi5+MpdAF2NMq2y1NKA
Date: Wed, 17 Aug 2022 09:34:09 +0000
Message-ID: <c6a5b7f4-9089-f50b-85de-f6609b739ceb@fujitsu.com>
References: <1660726077-3383-1-git-send-email-liaohj.jy@fujitsu.com>
In-Reply-To: <1660726077-3383-1-git-send-email-liaohj.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54a11a61-57e3-4b55-9d76-08da8033a34b
x-ms-traffictypediagnostic: TYCPR01MB8867:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30hr2H1sBMTKEzJBz00bLMXzU25yvUC5IkUEJn58bFr4TIJpbHN8V+5O1iXxHEnktI9g5hSvF2SkYEqf3zFV6jiHBbvFHH9egOTWMcGtpAy40HLpxkTEUh4xC9ECPJ45jeCBiZSt/owlbuhhDNjnJ+rik2KV+oFLwx8shn59TyxHLac8anZ34M3ZFR7uMfoolbi1YGeZP8JwnNewgFqn3z+WUICu+mM7C8oDwGXyqHQ9paCgZTxFyoLuG+6DEGVBf31AKwq+pVu2tuGvpIJZucHo/fD4RW98qdzQAul+xLHJaDXdSqU/YCGiuweMvbfdRDlHq4kO/Uga/l92xHKne8/j4weQgo8+66owgPq6yz7YLR+DTJsQiNMRCiwdH/V4ygZmdgH1YaYTQ+3EE7w86PmNVuxXoFvv8zLK+9v+S3AD4yw+S080vir9LSrUbZzF8mGLx3T/Q2C0ijylOrI5SHZb0vtC6nzd1NxsNDEmN0Ju60DxUISoiR8RUQUlLBTfRU7dqe8VxX2eLUE3TcwOXf8V3Ezr7blnFwXF1W6l6LdO3uL/Q85ZUdd40UPdZuHRLJ/4LiRJ1rjLcxGe/1Ack2DOR2ZI65WqJOyUzVy5nK6Pd3rthyd2NpbKJ999vYEcwXpJIah8OTkd1ZpgTEB41938wEmSU5vukd7kmuim2Y9ZVrDPsLlYbuXHkOxkFrgYdffU4fSDPbhUc+M4sree0tFcvbEjdS/Oo9QXS8pIVxEJxV30xZLmhFVQJrFVU+cROrB0Vyeo9kljZbA+yyxIGRCE3BoFhVPicC7tiH5T0xegnf70B3UJlhR5pp6BHlfjjOKJ8NL3qgf0awYmFVnG6+iufQl7RIdmjBAt2dyzBrP0qGAmxQA06mJOgSmg9FdO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB10061.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(26005)(82960400001)(6512007)(122000001)(38100700002)(6486002)(71200400001)(8936002)(478600001)(31696002)(6506007)(86362001)(38070700005)(5660300002)(66556008)(66946007)(85182001)(76116006)(91956017)(66476007)(2906002)(66446008)(83380400001)(8676002)(64756008)(31686004)(41300700001)(186003)(316002)(36756003)(2616005)(1580799003)(6916009)(2004002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjJ3d0M0R01mWURLbmpBd1hZQnlPdk9ONDVVZVJQUnV3Q0E3WExSUEtOUE1N?=
 =?utf-8?B?Y3VFMGVBMkZFaURJUDNRTHBFYTkyVmV6eFlSMDlIeFNBSnA2em83ZDhOYnAw?=
 =?utf-8?B?eTlNcmZBUlJTUWZWRi9yd2g5dmp0cjZMb2crREgwQzVrWk9obUpnNEFxM0JT?=
 =?utf-8?B?aTIycFIvMGFHdGJwenExK2I2MStVYWhGM3lFVVdKZkkzeEZmbG9NS09jWHd4?=
 =?utf-8?B?OUYzRHd2SG5VK0kyT1ZMallzMFZvNVB2SjE0S1pVdFZTeW50VTVuREJDcVJx?=
 =?utf-8?B?Vk9iVXAzcVI2OCtRanQyV1BtZU5Vei9tckFGc2FUdDZsczZqUnYyR1k5Sm10?=
 =?utf-8?B?Ui91M013VUo5WjhrMDNjMjJpZUsxaTFTanBRaWlBVi9TNDZRVkhJY2hlbVlR?=
 =?utf-8?B?WVAxYlR3c0xLcHpJY21OTmVtOUlhd2k0bjhMVUJjdEtuV3g1UFdzVUoxdnJy?=
 =?utf-8?B?aUpid2ZKTWtGVFZVNVI2dWZuZ2w5dFdKWGg0c1FZbzVKaEFhNG9OaElPVGdl?=
 =?utf-8?B?SXAzUGxyaGFxR1BvNURTdWZkS3lJZEJLMzVieHV5SUR6Q3hTaUFFN2FIZjRG?=
 =?utf-8?B?cU1teEsxUDlRMHFQbUpXRzdBT0M5cEQ1K0Q2WTBaQ1JuZW9VR3lUcVNuYk1O?=
 =?utf-8?B?cEoxSVZXQTZBTU5XOEthL3V4UG1qaE1LazQ4K1ZwSHVpU3hWb29PcnpOdW9Y?=
 =?utf-8?B?WlFlc2hGSk43V3NoZzdWY0xjY1lLMmxoNjZ4R1QrRHJLdGR5cGEvSDdrb3hS?=
 =?utf-8?B?Y1RaR3paYXZjVUd2cEhCbDg5eUlwR2E1K3BMemZ5blRXOUlBT0kvZmVuWE9Z?=
 =?utf-8?B?UTRkYjl6UlhNTDArZXRUaHMyR3YwYjhJRUpoUUY1ci9tMEF0em91ekhObHNK?=
 =?utf-8?B?THVlOWZISDY3QlJNS214V3UvSVkrZzRlcENRVkpkZmVRUFFQbE1GUXZZY3la?=
 =?utf-8?B?NTZoeHl1N05MM0NEcG55blJ5T3pNOXFJR080TlRad0Z1N1JsZ3BINjQwM1c0?=
 =?utf-8?B?engyR1lmUTdLelo3SXdNYStQSzRmS3QxRlRjak9UR0wxbk1Rcjhtbk1iZlRB?=
 =?utf-8?B?Y2w2M1pBTmJPejl2Z3JrQ0FhWUVPVmxCY3paTVdGa1I3VkltdnFPNzJvblRL?=
 =?utf-8?B?MGI5Z2FyMFNSRExTV0xlY0FmcmM4dVVRMW02bUMxcWpiQkZUbGJOKzFsZEhN?=
 =?utf-8?B?SmZnMHNHdmNaVURvTWtYWUtFNWc5SlBFMHZsRUpncFNBeis1a1VGRVhZUmFG?=
 =?utf-8?B?RkszY0ZSZTN4MC9xSy8zL2hTdi9QZHZuMDV6b0ZjRDV3ZG1aOHhwU1llQndY?=
 =?utf-8?B?bFVUUmErYVFScWNhMGZHeTM3YS9NNTFBSjhqZzNSajFaTmo2U2prVmN3NXhT?=
 =?utf-8?B?NnNpMVIvS1pDMFB6VThoV1NMbnJKOHByOVd6bTFOYVIySmhHb0k1djErR21j?=
 =?utf-8?B?dDl1UmNFTzk5UEZuN25VU05adzJmME9rWlBQNlpEWS9OQVBoRnB4WWUxcjlz?=
 =?utf-8?B?ZTdLN0NmVDI4WERVZlErWWlMcnZ1WXhmNFFNMlVmcElSa2FUeXZSQzBWOUVr?=
 =?utf-8?B?QUl2UHZmUE8vS202TVZWSDF5T3RwKzQ3RC8rdm1KZTVQczNYbjg1c2l6WFNZ?=
 =?utf-8?B?dU54azZsYmkrU1p3bXhqTVY5SmRxQ01NOHFFUlpSUGk2d0kvVVVSOEF4Q0FO?=
 =?utf-8?B?STlKWTdWSGN0YjVIYTZTUTg2ekY0a1U3ckpMUU5SSFhUaVZiRS9CZW1GZ3o0?=
 =?utf-8?B?SXI4d1lVZVN2WFNla3NQV0JUVlJKYTcxazhjdmhJSTlqZDNlQ3I2UDlDSlE4?=
 =?utf-8?B?T3dtWTBoNjRZdkhReFpGcEVRQVgzcHZGNGpuVzNWR0t2R25zNHFTY2tCbm1D?=
 =?utf-8?B?Y1hOc1lsdisrL3FNa0l6YW1ySW9La2F4MjlzRzd0UktSczRoYktPeGR4a0xS?=
 =?utf-8?B?a1RPMTJUTk13L1JsVzFTanppMnVSK1M4UmVOdDJVYWxKS3FiNWlwcGtrNkh6?=
 =?utf-8?B?Nnl0ZHpYMEYzejBnWDBWRTN0TnhaSDR2ZVRBR3ppMnAycnFxaWlVTFhhazF5?=
 =?utf-8?B?aGF5blY5SXU0bzVBbHNSQUhxWXRrYXpnRUtydjdiT2hGK3RwMklPdEtoZUJl?=
 =?utf-8?B?UWpvWmlRbTZQaHp1TDJxOHdqKzY5R0pPNjMwaml4d2ZhZHBzd3JZK3NZcmJ0?=
 =?utf-8?B?V1E9PQ==?=
Content-ID: <B2BC8123F49229499E6B67DCE60DB469@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mL/Kc5jPRqpFkpU6QXTrCcHF+vvcasxQMlwL7psyiuvB929cSZCc4hJyCzST4zmlIeT1Nm26GLhpyqH6nGw8Ksok9JPtP9t8CuZYRk8aWxRAPvfSAU6ridJeA5X3IoT2yn2d+oPMYRWU+KvXtESmkvRbyRLRpRonkIthhLQbckG8JLu8xHeyhpNqYKfu6LoSjWIaBgVrk06woXldLfs3xCZR8jQrEMjxDqHZVBnAT4lHm7JL2Yx1s1wrJ+us2D94UjvFcZz3JWuGEAklVnQw65veo8dMPTaORxaRkaX8g9bkF59g/NH41YzI07IXkTedF7hmh/vqIgzRkvJXJSWTw2ckoi5invN6/TbjgZ5Mxewqr3HPCgFrTcuzasVLRlIi3k9mklyN7aMClRodreRpoEWYLH/Jj7/JL4qAcc1jXdX5A9QxLhE1Ah71gIEsI6nTtAEHWTx96A3l9dguNk6W5P6rHqB0Hhj1k+wHrchc7E6OY9qxZS8fWLBpXD5V1RvKDzj/sNHAsfUU+3buHOM4EMiWjNiXlyYImg9I3MNecGQL5f0+SkvOOdxMdm7QdFJnh6xXWNojPRFf4m1mTJ+lyGQH8ZR8JXa1kEOv9ZjMSjeFiwNXA4fvfrIBCWKnFIGOF0R36s4sFRCHhQ4zvLlccEYAVbBrUn52aIzoRdkcNnotSIy0Rw85NvcJPqXTwLa53spHXk2AjXm075Q58lcMyg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10061.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a11a61-57e3-4b55-9d76-08da8033a34b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 09:34:09.7050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMJ4KbxiN5m5BrE5KEuNBkwoaMHHtjTU9u5JbKQyn/KHx+V3KCqERMD9ZPkkSTNtDu9qZhYmJxu1BGMwcgGRUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8867
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/openat01: Convert into new api
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All

Sorry for this noise.


Best Regards
Huangjie

> From: Huangjie Liao <liaohj.jy@fujitsu.com>
> 
> Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
> ---
>   testcases/kernel/syscalls/openat/openat01.c | 145 ++++++++++------------------
>   1 file changed, 51 insertions(+), 94 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/openat/openat01.c b/testcases/kernel/syscalls/openat/openat01.c
> index daed419..25b3f83 100644
> --- a/testcases/kernel/syscalls/openat/openat01.c
> +++ b/testcases/kernel/syscalls/openat/openat01.c
> @@ -1,55 +1,30 @@
> -/******************************************************************************
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. ALL Rights Reserved.
> + * Author: Huangjie Liao <liaohj.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
>    *
> - * Copyright (c) International Business Machines  Corp., 2006
> - *  Author: Yi Yang <yyangcdl@cn.ibm.com>
> - * Copyright (c) Cyril Hrubis 2014 <chrubis@suse.cz>
> - *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software Foundation,
> - * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - *
> - * DESCRIPTION
> - *  This test case will verify basic function of openat
> - *  added by kernel 2.6.16 or up.
> - *
> - *****************************************************************************/
> -
> + * This test case will verify basic function of openat
> + */
>   #define _GNU_SOURCE
> -
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <stdlib.h>
>   #include <errno.h>
>   #include <string.h>
> -#include <signal.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/fcntl.h"
> -#include "openat.h"
> -
> -static void setup(void);
> -static void cleanup(void);
> +#include <stdio.h>
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>   
> -char *TCID = "openat01";
> +#define TEST_FILE "test_file"
> +#define TEST_DIR "test_dir/"
>   
>   static int dir_fd, fd;
>   static int fd_invalid = 100;
>   static int fd_atcwd = AT_FDCWD;
> -
> -#define TEST_FILE "test_file"
> -#define TEST_DIR "test_dir/"
> -
>   static char glob_path[256];
>   
>   static struct test_case {
> @@ -65,80 +40,62 @@ static struct test_case {
>   	{&fd_atcwd, TEST_DIR TEST_FILE, 0, 0}
>   };
>   
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -
> -static void verify_openat(struct test_case *test)
> +static void verify_openat(unsigned int n)
>   {
> -	TEST(openat(*test->dir_fd, test->pathname, O_RDWR, 0600));
> -
> -	if ((test->exp_ret == -1 && TEST_RETURN != -1) ||
> -	    (test->exp_ret == 0 && TEST_RETURN < 0)) {
> -		tst_resm(TFAIL | TTERRNO,
> -		         "openat() returned %ldl, expected %d",
> -			 TEST_RETURN, test->exp_ret);
> +	struct test_case *tc = &test_cases[n];
> +
> +	TEST(openat(*tc->dir_fd, tc->pathname, O_RDWR, 0600));
> +	
> +	if ((tc->exp_ret == -1 && TST_RET != -1) ||
> +	    (tc->exp_ret == 0 && TST_RET < 0)) {
> +		tst_res(TFAIL | TTERRNO,
> +		         "openat() returned %ld, expected %d",
> +			 TST_RET, tc->exp_ret);
>   		return;
>   	}
> +	
> +	if (TST_RET > 0)
> +		SAFE_CLOSE(TST_RET);
>   
> -	if (TEST_RETURN > 0)
> -		SAFE_CLOSE(cleanup, TEST_RETURN);
> -
> -	if (TEST_ERRNO != test->exp_errno) {
> -		tst_resm(TFAIL | TTERRNO,
> +	if (TST_ERR != tc->exp_errno) {
> +		tst_res(TFAIL | TTERRNO,
>   		         "openat() returned wrong errno, expected %s(%d)",
> -			 tst_strerrno(test->exp_errno), test->exp_errno);
> +			 tst_strerrno(tc->exp_errno), tc->exp_errno);
>   		return;
>   	}
>   
> -	tst_resm(TPASS | TTERRNO, "openat() returned %ld", TEST_RETURN);
> -}
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; i++)
> -			verify_openat(test_cases + i);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	if (tc->exp_ret)
> +		tst_res(TPASS | TTERRNO, "openat failed as expected");
> +	else
> +		tst_res(TPASS, "openat succeeded as expected");
>   }
>   
>   static void setup(void)
>   {
>   	char *tmpdir;
>   
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	tst_tmpdir();
> -
> -	SAFE_MKDIR(cleanup, TEST_DIR, 0700);
> -	dir_fd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
> -	fd = SAFE_OPEN(cleanup, TEST_DIR TEST_FILE, O_CREAT | O_RDWR, 0600);
> +	SAFE_MKDIR(TEST_DIR, 0700);
> +	dir_fd = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
> +	fd = SAFE_OPEN(TEST_DIR TEST_FILE, O_CREAT | O_RDWR, 0600);
>   
>   	tmpdir = tst_get_tmpdir();
>   	snprintf(glob_path, sizeof(glob_path), "%s/" TEST_DIR TEST_FILE,
> -	         tmpdir);
> +				tmpdir);
>   	free(tmpdir);
> -
> -	TEST_PAUSE;
>   }
>   
>   static void cleanup(void)
>   {
> -	if (fd > 0 && close(fd))
> -		tst_resm(TWARN | TERRNO, "close(fd) failed");
> -
> -	if (dir_fd > 0 && close(dir_fd))
> -		tst_resm(TWARN | TERRNO, "close(dir_fd) failed");
> -
> -	tst_rmdir();
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +	if (dir_fd > 0)
> +		SAFE_CLOSE(dir_fd);
>   }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = verify_openat,
> +	.tcnt = ARRAY_SIZE(test_cases),
> +	.needs_tmpdir = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
