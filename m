Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E222C77B7D
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 06:24:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 103553CDC1E
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 08:24:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C02E3CB289
 for <ltp@lists.linux.it>; Thu, 18 May 2023 08:24:17 +0200 (CEST)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0412F2009F6
 for <ltp@lists.linux.it>; Thu, 18 May 2023 08:24:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684391057; x=1715927057;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=Ua5QOmfihhf0iZFbqYbxObSiWFFQdIZds8YWAwodrak=;
 b=JCrf8ODJJwgCByrDGG6DgB5SV+Gf9YdQSO8x8tFdDYgRGNKzCd6odYzD
 FyIbK3GvOZFQq3DNQfp60p0vPFOSr0zR8TwJDEzupLqrfX9pEW5PnMIkP
 jaUkAfB9HRCKetIEbe24W7YiIM5RmcR3MBzO08nRd/J0J36kxKD2d03IV
 p+bhk1tIb3FcbSvdMUBRpcf4F8xfdxfBH4RgAEXSvFsSIfu0Gj/sAvH7T
 S3Dj6Btrbs3bs6ufOhQClEM//jzGN9mowrPzstBEiGbFg3Plhw4p4Pdkh
 m65yzNWRqcHJYcEyLiJftJpAld/cEWgzG0syWofiVQ6bjnFukrB1eWYqJ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="84562867"
X-IronPort-AV: E=Sophos;i="5.99,284,1677510000"; d="scan'208";a="84562867"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 15:24:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dT4JmjeEaZfKEVPzPbcXq5PFWWRSJ9dx0+WBqo/d01OUmYcOLz/kiE9fpeKlhNyruiF76USN6eRvsuEJJKUv/QgIKdILFihTDh9fupGVIuAL1L40r3592VT8dWSJ/YCupplJBpShEtudONID+ElEoGtl83p8mEVIb1kZrDy+K7XMuCi5KJiTekovhj8hen5HiQTTpHiiLnBtTg58y2EWtIJeDyH3LbBQUC2t6GLQ8jBHPhV7h94WILv5tKHWeGkMY1qalGy5KMU/SXFl+NnEBSY4Wadkx0NG3SC8P/pw48bVPTiIrofx+ZfXzRXVFZq2oDFjvB7NSIxAwYE8sHXjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua5QOmfihhf0iZFbqYbxObSiWFFQdIZds8YWAwodrak=;
 b=g6j+0LJaXbHN//NvHAlMYbQT2HcH9Qhb7ya+flIi6qZ4FvMRga83VQTlxI8TnDN7a/W0hC3yw+UrtMSMSxSw3LFMlIr00+qOF6w6Tp5EoyO95U10HC44j6kNB+o0RurAuhkCJgjWRYQFApi5Dknn6a1FusleezBzCx1OpV7I6l3K67CjCRi3JKkTrU2XdnVQ0Gd2SYv/ndfKa+EHbjXLmcsk9azEm/cfs2KAszstl9bFZw+hjLOdu+GPn8JygWRUzj0t/IOr9hyZ2fdpPCUPxSexwEqqYMHhFyZyK9RH2yS/WiejyiXctcjcHUomRfvNVYtPrBp2fN9miPt6suWnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYTPR01MB11002.jpnprd01.prod.outlook.com (2603:1096:400:39d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 06:24:11 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1%3]) with mapi id 15.20.6387.030; Thu, 18 May 2023
 06:24:11 +0000
From: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v6 3/6] lapi/stat.h: Simplify definition
Thread-Index: AQHZhvyN9HBN8RBmUU6emtepDUVH969flL0A
Date: Thu, 18 May 2023 06:24:11 +0000
Message-ID: <0524e67f-fbc1-0fc0-4465-3eb52a196b90@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1684134680-6190-3-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1684134680-6190-3-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|TYTPR01MB11002:EE_
x-ms-office365-filtering-correlation-id: 7278735b-e727-4687-af72-08db57687eb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fj1o1HiIbGxlVHNWQfe3Wx7xOm5LwE0FyfoHE05Q59ShjVzU1gOQj9r6/xfOAAyIGM0HEFnl/9U9EefFrQcuUf0ThCGTNhjzvdrSDVetlZSHxiiLZw8eN4uZ02FxKcc3Dr+zd2BqVr6npYwrWswt4LyBLDQyUDsPqN/FebeWKeS0Te7q/MWumR6uxqctkdFwdgxYw0H431GCWRP0y9yAHjK28ttI3NR9XSXMR7Z0DcFwPGDP5B4uvM8cNqFbOEQMYrsOsu6Zma3gv0IczS+ozJg+pDSnJbhBUUWuBiPRfukorCkwvyDzfuARkOsjeIiLm5Z0jcwsqVPX5eA2ecTIIZo1agT4joV1o5S7zW8gnssHy5LNPPMbEAWlo6AGY/CWJmLqmv8k58h19CW+XMH6TPJ6y4TTVPa08gVm9UnXlq7IFlUelK7H5LpTOon7VaBJXzABvpC6KYWzMXhgwx6zi3QbJzY5FypOkcT24lJ0bbXukNQgJWUuWJ6TXvPUpNJVW4kcdY0Xl9eyImQIRcUw9LIcQvsfrAiskbFuBbJFvn5aiSRcB5R+V202tfpD4IeamDHixTMPKjVznpcFsnXYe4P63CiYSipPf9VBGKXjdLvY8ZXeYJFOcbsewidYeNwhdQZdE+/cL3RZw2sEbbDIiMzYFzARgdivqf06w25HCTEU3+JhALu2pwLbFyun17vX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB9499.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(1590799018)(451199021)(31686004)(2906002)(1580799015)(5660300002)(83380400001)(110136005)(8936002)(41300700001)(6486002)(8676002)(76116006)(66476007)(66446008)(478600001)(66556008)(64756008)(66946007)(36756003)(91956017)(85182001)(71200400001)(316002)(2616005)(26005)(6506007)(122000001)(31696002)(53546011)(86362001)(82960400001)(6512007)(186003)(38070700005)(38100700002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0M3TGJKbklMWGlITE1jUnAyc2QvR3FWNVNuQTFCU3puMGZtOEFOMERWbFpP?=
 =?utf-8?B?UFdONElEZ2RkMVhQN0FFek9DTVUxcHVFL3JSN0ZBaVk3eXNranFTdnpNbXpj?=
 =?utf-8?B?UFlveDFzUkpTRGFDTlc5dEVaSm04VkFra00wME15Y2kwNEJ1eHVrUUoyQkxw?=
 =?utf-8?B?QSszcGtyMHpyOGErRG5ubk5UK1RoT1laenVTbkJGSlhHN2VnM0l4bFRuZVNu?=
 =?utf-8?B?MWhXeHM3eUhZZnBscEd6TlpvVWlqK3lkaWRwajFKWUg5bllyMjI3UUpNSUJm?=
 =?utf-8?B?cW1JTjV2Y1VaQzBSMDhOZnFTbEd6WUZncGh1SFZCQnZwdHl4Nkh6aDA1VUI3?=
 =?utf-8?B?Nk5rVktqMnlIaEpNempsV2twWGZJZ3JveVRTcVB3T1BmVHRnME1Cd0F1VXFx?=
 =?utf-8?B?Vm1qcjZXSThjZFBGZ1NSc2tVTUVKV0QzTk1Lc2ZKL3Q3Zkk0ZVo1ODlLZ1F1?=
 =?utf-8?B?QW9tL3RGekZUZE9FbmVVZFBudHY1ZzVnK2JENzN1dmVEVDBOWkM5aC9GWHZT?=
 =?utf-8?B?NlIyRS9kYm56Y20vSFFqSENOV2p1YXJDNjdJS2F6ZDgyZHJlUGJ2TVl0S01X?=
 =?utf-8?B?MEJFOUh0cGpVa3czTlA5Rit4czNnV0hiQzNUVnBtcmVYWUZBbWpZMjVjWkt1?=
 =?utf-8?B?ZVdZZllZRDJ0dUpJazVRaDQ3VTh3OWduZ2JoT0tPYkxzWXhiUWwzTm14S1M5?=
 =?utf-8?B?YmhwSk5JNkdqQW9jMkV3cDljVnNsYzBHcWlmcSs2Tmp6Unc3Rm92S1BMNjcx?=
 =?utf-8?B?dWN6cUxxTEE3bkwxbUtpSFE0S0JmMnRlUzBIS0w2V0Z4R0lTdnFaQ01TbDUz?=
 =?utf-8?B?RWNCNUFYYjNvUmd2WmFhUFBpY25KakpTZU1oa2V6RUZFVDY2NHhHdkdEdnAv?=
 =?utf-8?B?TitiaDlNa09jTXF4eXZ3c1JjRm1HcmU0TS9wb010UVIvYThudnJETWlnTGJh?=
 =?utf-8?B?RitkUjdudE1Yc1VLL21DVFJTYUtIajE0aWE4ZzdoeHdIay9hRHIrZ0pGM0dp?=
 =?utf-8?B?V3prcyt2MlZ4Uk1ZRGxvSGFMNVpta24yZ3M4TTNSTms4WjhJUWgzaVlubloy?=
 =?utf-8?B?blBBSlg5UTFtM29SK1ZxMU4wWWNoMG5XRUU2ZjJzOHk4NUZIWGkxQzUwYWRw?=
 =?utf-8?B?ak11U2R5enlqcU4wMkNSY0kxU0tCNUU1NUt6dVdqMVBrL3dVR3JZMlgrd0hp?=
 =?utf-8?B?QjkySUtmTFhJYy9HMXYzQ2NOT2ttNFNLMHlzcmtTQmpid1d6c1E4bU9pSktD?=
 =?utf-8?B?L1pCakVJcXllaW5lNzJtRkZETjd4YVFSR3JrQXM5NmxRekhCSnEwdCtZa2RD?=
 =?utf-8?B?Ymo0OWsyczhlS0FZUmZFa2NHd3hSMU9EU0ZnQ3pmODh5ZGFFK1hreEpESzdD?=
 =?utf-8?B?U1ExWkY0TW4rTVY0QzZId1pHZ21xSXNiZlc2OTFIWkZSTWQvaGlXQVAybEth?=
 =?utf-8?B?TVhoQkczaFBua3FoMzltN1NwMXpDbWVBN0UxRVpuck4wUWsvS05iYW8vbjFp?=
 =?utf-8?B?TVpHb2xvMnBrUUlaamxzRVlJSGtZM2hxZ3NvT1FScDlqdGNNMVU1QkdXTEU1?=
 =?utf-8?B?cjhIa3FJNXJ4UDhWYlZTNGpiMnJjWGd0c1cvUXlsem9Yb2kzRTVUNzNpTTlw?=
 =?utf-8?B?cThQZGxhYW9CSUI2VjVYU3UyT09CWm1CMGRXbFdDcVp0MHFwMndZZDhKL3gv?=
 =?utf-8?B?SXM3VjVaM25pdGM5YlJLdW84ek92aUVBV21mQWFFeWp5bUc4MkU2NE1hNVVu?=
 =?utf-8?B?QXRsajNERzZSMzlFdmlvZWUrM3huV2ZreVJGelNtUHBFKzhHYXBmdG9wRFI2?=
 =?utf-8?B?WVBWNHNCeThwK1ByQ3VhNnZibi9xMGJKOG9BVmhHVHVrUkJQa1hnaWRMbXd1?=
 =?utf-8?B?WkhCREpTc2VLc3ZybFdyekg0UGFjT0NWU1AvaFJ6MExHTTFLOEpJNmVrZ0NN?=
 =?utf-8?B?RXFWSjdWY01HS3ZoWXNYWmQrcHFIT1NZRllnMlFXVzJqcmdjNnppSU5CNjg4?=
 =?utf-8?B?T1dabitqd2VxekpQVnZPS2dyOEIrTC9nTWtrVEVuNjFGZHA0cW5FaDZhbW5G?=
 =?utf-8?B?c05VMktyR1YzK1hyQlFZa2dWNGtXZ0xiUnFTRERTNGg2THN2YU4xaXV4UU92?=
 =?utf-8?B?T0x1Yk9ORmdXTU9PbHgxbmViZlM3K3NqU2F3dG1YMTJvN0ZTSkFldWZoZGd1?=
 =?utf-8?B?U1E9PQ==?=
Content-ID: <3BD43C2878F28C4AA8ED0D361BE82072@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LiSHTUlLDsmtxNr/Q5Zjv/+AwqDh3j6dtqqn4WxEsnvxzPyBJyh1DumW+SD4dkOUhIZy8Qzlsjv1SN1Sl1ixgdlhG4zwAjLaQv2awqPdkNGZq8u4BHiRXlMVhaMfzc/uVUZXqY6v9GVMEQpBDTuUBk0jNwMHk7we3tDFQ8FxRGo2/7xTO/Ax/7hM78QNUdeltKfxr3O7RNX83KFfidsKb0ay7D+9wRUI+cs8xU8XAu0tjW8jtNYV+1X5RtJzzycg9UzvU0d9VOsCYqNLpKno7aYBTYsYGjiFA1F379JBwkKZKw7/7aenBZQbwKPnC3tV8KMMsyF6JcEpwXzTGpbR9f6PLJnpNIu7+lb87l4lox9v7ncrAJIulT/qyYRLH9nfzfB9RWTSJals21xSm1mVBfjkSldHoHpdvIUhnmObhr+Ak3l7DUteGgyGn7QGnpZMkBdyqIwxktywpMZteGAPQAJoW2+8x0haQTXPbMuv7dS6ZtAhtwdRhW1DjgrLlKP4WCr6TsM367yU/+0Pzm1joZEzBCHha4vm3KFqSBkS2x/9p2Gv6uw6Co278PsLogSrs8j/S6TOFvUio9k6kR/eXvNayznZOfnegoDzkzHa5abDlLfJbZemH2WvepT0mpY6zZvhO0tOw0M9aqofCbS6VlqPVRT/Ti0tQKa30jTzuzGd1r8JNYcXncIWVf9qhLs5lF6T4A8VFagEACkVEzpYawyLoZR8UaS+Vf0tp7xgMXd7s71ybYcvIo084PZfyomD3QSe2b7A03Yt3a8JRKbFPg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7278735b-e727-4687-af72-08db57687eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 06:24:11.6490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wu9795lkTQv0aO6RpWUFxxgDy8PQeOVCpDYcuhc7001ekGl7yj+PQ9siqhDpa8H58WW7iU5RNZHcr3b3s47LSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11002
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 3/6] lapi/stat.h: Simplify definition
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

Hi Xu

LGTM.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang

On 2023/5/15 15:11, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   include/lapi/stat.h | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index 6ed4b6637..e247c2159 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -11,6 +11,8 @@
>   #include <stdint.h>
>   #include <unistd.h>
>   #include "lapi/syscalls.h"
> +#include <sys/stat.h>
> +
>   /*
>    * Timestamp structure for the timestamps in struct statx.
>    *
> @@ -21,9 +23,7 @@
>    *
>    * __reserved is held in case we need a yet finer resolution.
>    */
> -#if defined(HAVE_STRUCT_STATX_TIMESTAMP)
> -#include <sys/stat.h>
> -#else
> +#ifndef HAVE_STRUCT_STATX_TIMESTAMP
>   struct statx_timestamp {
>   	int64_t tv_sec;
>   	uint32_t tv_nsec;
> @@ -67,9 +67,7 @@ struct statx_timestamp {
>    * will have values installed for compatibility purposes so that stat() and
>    * co. can be emulated in userspace.
>    */
> -#if defined(HAVE_STRUCT_STATX)
> -#include <sys/stat.h>
> -#else
> +#ifndef HAVE_STRUCT_STATX
>   struct statx {
>   	/* 0x00 */
>   	uint32_t	stx_mask;
> @@ -106,8 +104,7 @@ struct statx {
>   };
>   #endif
>   
> -#if !defined(HAVE_STATX)
> -
> +#ifndef HAVE_STATX
>   /*
>    * statx: wrapper function of statx
>    *

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
