Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F571C77B75
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 09:17:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67E013CD417
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 11:17:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81EDA3CB25D
 for <ltp@lists.linux.it>; Fri, 19 May 2023 11:17:01 +0200 (CEST)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 69968600453
 for <ltp@lists.linux.it>; Fri, 19 May 2023 11:16:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684487820; x=1716023820;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=suphZL478BpdOhwK5w90euvB6Rck92XbFjqmk5uTy5k=;
 b=FNBpaRtI5s+Tz7b9iTcMmE1VkuZcvVI7inlUqxLNjxi0po9m9uA9Veev
 M2b1N59teDYfFLCDa+6DVQ2Wvr2z6DcfUS2UmidEAKYTf+dPMSqMC/N6V
 sdwf/AF7ZoFPMuVG2PynqUxrZ9W5u/VsgWtnWY0rmMbCUvm0+4ZvwFcT1
 WuHptH1YkrvSyhB0Zot/MckJueTq0eOGCmDRtccEmoiNMZdsEc/pzX70k
 qR/D8zyrQU7USO0vmbpDPYIDn33pgsvSCJRBdSA4Hcn4ob5fq7ophup9M
 dkpRgMKe46XEbIAVEas/4S313wbay/CLexwP1U+0mSQaprcJyIyndbUHg g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="84861960"
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; d="scan'208";a="84861960"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 18:16:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6rnapGbSBmIpRUUJ3129keQdTH75I4d59jGaBq3MQzUiIbYJRFea+6vcsTiPzo+TfseiB0Ea4coNk4eEysQmatMEn9zZFRGvHua6g1nGItAtkTsql0g2mlDX3DgJHSfxrhlH68ckTDnFF1ZxdaQ+9YHqgk3yIWfWWAiBNVQ3g/w5MSC+xs2BcOEdhvhU4SGXaFJlBgQHygHQQSb62XJPRNWVXJSEawJ6Am+mn7VvAfQrcLxixdMqISvUDI11ZoEJoIiiimkIlFR+H0u9rDJIq1gftQ8vgOT6mX9ITwsJTxAuvkY6HsgjbXNwmzGex0XaowyKH5In020yv1NjpJ38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suphZL478BpdOhwK5w90euvB6Rck92XbFjqmk5uTy5k=;
 b=NvLC69wVDahfRu4UQN9O+vnR0O9CQFQ9eCZNkmPg238EtoCq6rqIVtRIBdKBYiij7l5N2Wrah4NWwOVDqLRlF3wK/nBKItirJc96lzNN1LInNu/Y/LnpKaOTky81W/pByr9YHN9CKmoOwuE53fEFB1oxZONtHAXWgtzseHkdWXDb0ZmmfbAbAjSRIzJr5ll43jKy0LUH4yQexg8488KWMYsLibposH5fU1pmM+AllSxFCOtx1dOwUhNBZLIFbkLbU71sVYmaXc2KiS4xlY4izcAlnvlg3fE7CmY6YGnfaEZaEcrPOa/zWjs5d4Dcpl2gF54GrDlxGwBuGYWwXRk4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYCPR01MB5632.jpnprd01.prod.outlook.com (2603:1096:400:47::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20; Fri, 19 May
 2023 09:16:55 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 09:16:55 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Jeff Layton <jlayton@kernel.org>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] syscalls/statx06: use a fine-grained timestamp for
 the second time fetch
Thread-Index: AQHZiXxwKvEB8nl7G0yt1lrE0eduG69hUlIA
Date: Fri, 19 May 2023 09:16:55 +0000
Message-ID: <68340cb2-87e1-ff17-2db8-5610beba761b@fujitsu.com>
References: <20230518113216.126233-1-jlayton@kernel.org>
In-Reply-To: <20230518113216.126233-1-jlayton@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYCPR01MB5632:EE_
x-ms-office365-filtering-correlation-id: 385efa89-1853-4bd3-0ca7-08db5849ca4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qh5/lbmN7C6DDqdJj+YVwRF4EYffHGsGFCngj96PUK1ey4P6Au5pZs2EfLGcZW6+PMduFdeKbVjwYgGOtCoOA1I/QpJ98SSMgbKTH1Od1pTNCKSZPFEljdJCMtO8Oi3xX9E0BOE6a+3LRi/+9y6i0eN5WVSy3OJXczKAVgFjCvyixlSYfVaMe2CBjcyzN34AcqA7U36qqIiEvnBeuOESyLn7Gj1K4g2N9F1hjqcmj9kEyhgK1m/PYyXNBu57cYwLN4QW9oG3VcF5hcknnXtDBLtrXeCw9J7kuoDs4paVEkdTroQnGKQMYCxNvL6Lw+Auwvj9WXupHjzZjdmqV6a7W6xbNMDLLnrUSJO5Djl5/4XnJbivCxyDuXCEFHotM28zSi9gq2Zh0kajjTmYscWWYayatr6tpO5DbQImuJnuqmM4NOAOD5/oidfIDb4LJed63N16LLB5WeoWB3xF8ViLq2fB0/u8+OwGVY4sTGxFRM03+8lYKnJvBxMVOoumfopUPrBG9uBFxM+9NAbxUs/fp8Whoq9UFy96ZZhiRdqoyTMwZCh6vAIHEMVF87CnwarqvI1dzj6qBgwK9S+XbtvpiC6OfCtjjjSe7UH0A8U5fewWFESjiX3e/NNJwDLv9Bw9d2EGbyQxHXiBQMIYSx8MkA9NzmVv/h80E7l72FQGFcjgjdnBq8MKQLEzNlWkGm2C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(1590799018)(451199021)(31686004)(8676002)(66446008)(64756008)(31696002)(86362001)(41300700001)(8936002)(122000001)(82960400001)(316002)(38100700002)(91956017)(66946007)(66476007)(38070700005)(110136005)(85182001)(2906002)(478600001)(83380400001)(2616005)(36756003)(66556008)(1580799015)(26005)(6486002)(6512007)(6506007)(71200400001)(76116006)(5660300002)(186003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTVGaUtHRlEvU0ljTmthTVZ0dnVxaG1kMnVBbW5PNnVTV1B4M0dRSjNjZ011?=
 =?utf-8?B?UVJ0SVg4VlREL2pta1BPLzZBK0ZsV21Qdlc0cU1scTNhakp2NXNNK3A0WEht?=
 =?utf-8?B?Q0pqTmtZVnRiZmhTQS91eSs3aDN6d2RIckpOb05Kc0ViRk9HciswdmF5Yy9F?=
 =?utf-8?B?TTB0K2dHbGx0ekdON3VMVGlYMU9maFdLNENKNkxKZVQwaVhoV0x3RHViTGpH?=
 =?utf-8?B?TWNQZmVHWDFMQjk1QmVrZXJWdXRGK21oWVRmcThPajUwRlZ0VzRqZ2dOMkZJ?=
 =?utf-8?B?UVlhbmlpbU9TTkRnRTNPMHpWYVJvWFlCQmg4ZHNYc0IxTXlGdjhXZTFtbDFJ?=
 =?utf-8?B?S2o5QlorbVB2d09HVXZwWE9ONUNmSElWVWJyQXVpaVM3akhmdWRkVC9CbVRW?=
 =?utf-8?B?MVljdlNDMVV0ZWwxdVhsT2N1WEY3VmZxM1JxKzhzZk5WckVFQ2VNYjM2dFIx?=
 =?utf-8?B?dy9tZDJuY3lFa0xMR1FnaG9vN2FOMzIrai9OTm5FTWxXRWNTbCtESXE0LzhX?=
 =?utf-8?B?Z2FhUENJbElwNDgwOFhtRXJGV21vTGhtTHc2UHhWK3hvRzF2TjVXN3J4Nnps?=
 =?utf-8?B?YzJobW5FUDFBTzN1VTlNRFFPSW0wQ3Jjc3huK0NTdzYwWUxwVGI5U3IrdmZn?=
 =?utf-8?B?YUJxdjZzUStmSXFqeWx5d2ZVSlIvRGtxdkxZNHI0OTU4L1pDdDNBbkluY2Y3?=
 =?utf-8?B?QmlrTm16SWNyOVpMSm81MXFhc0hEQ1ZNQlNQU0FPbDJzN3dwY3I2NllrQ3B2?=
 =?utf-8?B?Q3dKalpTMEtRdEpXdkpnVGxpUGR6Y3hFeFJOUlY4dVdlaHpJdTExbXkzNFdo?=
 =?utf-8?B?VWNKaE9nTmMyTzhkclJha1ZCM2V1MXNiZWRxWmc3QU9sR0lOR2JkVFFkK1JV?=
 =?utf-8?B?ZnNGeFhaWVV2WEJFdWMwd1JyWW56NkZRdHRYbkxGaVV4UHZOb2k4ci93U2F1?=
 =?utf-8?B?SjJRa1N5bXBCNWlWckVDR0hVZUhuVkMxcDc4MVpmKzY0VEJqRmh0RUZ5OWhn?=
 =?utf-8?B?VVJMVHl1UUtzMDJPUEc5N3VoU0xBeEo2SmRWVStTcmxyNlFwZ3htSHliTzc0?=
 =?utf-8?B?clhZR09zbEZXWnd4aU0wLzZSRGVLcnYxTGtPVUYvOFNqWHo2SC8ydXdvVXJz?=
 =?utf-8?B?Z3RPSmt1YTdVVDdBVlhmLzhWZVBFMmp6MERKUjRiQ0wvRXZIRUFOMjdhWHBC?=
 =?utf-8?B?UTdzU3hUNlpqQ0o0SmFUUVVZWUxtaUZMU0NoeHl1WVZaY3E2aDcwaThYTVNm?=
 =?utf-8?B?ZUQ3aXJOSzk2VnVTbHlHNUVGdXV4ZmRVN2h4cENqbVFlbjhuWGJrejc1alRl?=
 =?utf-8?B?ZDdURm5KeWhMWW9xck5aRkZYLzBvUVBsc0JnK1B3d3p5Q1ZMRVYzelFORlp0?=
 =?utf-8?B?MWkrS09UZSs3SnJ6L1VlY1RpTjNjTzNCdHJzMmF3RSt1QnEyOFpPbEVtaFpQ?=
 =?utf-8?B?aWhmUFJJWFV3RzQ3Tm1OYVdWV1hyMTliaW5BUDRSVWdFejRwNXNhVFQ3dFZm?=
 =?utf-8?B?SjVQQ2tuWDNRUzhLNXpsUllTK0hJWDlRVXowLzFOYlZJa2FBTUNQNjNWZkJI?=
 =?utf-8?B?OVNNN24vMmhkTmMxVE5QYU9ZSVl2algrbjFDelZmVE5DM3JZSjJWQVpmRy9w?=
 =?utf-8?B?Mzlzb000OHNWcG44TkJ1bncvS09MTFViTTF2ZU9IV0JpbDdSN2hkOEs2K3Qx?=
 =?utf-8?B?QkhnU0tPOXRFNFpMU1hEOFFnWGRYRTlsa05FYWNCYVlXV2E3SkpaQmRCVzZJ?=
 =?utf-8?B?cHBlRmhYWDB6M25YZFFmcWlwTzVyczdQb3E3UGJUZnFoVEZkNWtFSU0xN1A4?=
 =?utf-8?B?ZEZMaXozbXhDYWh3Wkdvb0VTbENEN2h3YWZZNE1TWU5IcWVyTTRXRTZId0FS?=
 =?utf-8?B?SjFIQlZyck1MWnpmVjc4d0R3Vzh5ZWRjY1o1QVpPQzd5anZqc0dVK3dVeFh1?=
 =?utf-8?B?UG9aODAvTitiYkwvTnhWekkrSUp2a3J6YkxVYno1L3pWb25naDhMWUlQVFkr?=
 =?utf-8?B?K1FxUXFIVWhCWS96VHppOS9pQlBLckpDZTBNRlFsVk8vRVhTeTBZcE1TWFJT?=
 =?utf-8?B?UWJ2S2Fxb0pMM0ZQVXNGUUZ4Z0xJZFo5UURCVnN0anZLWkdnVlVERlV5RFBq?=
 =?utf-8?B?QnZ4WDN2eDdwUFhJNDN4d01lNjBwcWZ5S1BzVVhZakxnaCtOS05UWDF3VkJZ?=
 =?utf-8?B?Wnc9PQ==?=
Content-ID: <07B39D5EBA79A84586E765DDA8F9EEDA@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: whbaww/X7iiPFUDsI7jSU6EDApylDp1j9PvFOHwJXXG6cnJehRwjh3h6sF5C280bvXaC2K7ymUiPKKL0xH8nzJMHWq6Jon5YMQbnp8j5HC7mN+777MxDyHh6k2EDPQYVQdLqLNWDrlf+swQPREdDSkAWACeUxsOQE92dh1ZBT5VzeTEwOsA91oQEmlrfmLwbjAvFgpqPzSWsSpS5XFPYgKRdUO4un4Y4/suvPOYL2PVxVshqKMEqh0fxfq48ZR+SfZBEA5qMO/Xr0vtuLm7CasX/MK90D738/2xJhh4I1+QnBssgOe2OoS/I3LeqQtqSWH8Yf5B0H6+N5tmhwHiTW/31EJVDoA7nYXimtfm2EFFFlIwppWBzvVlbSJlKRqPYdbhh+ojdV+9Rt4n7qHIy2faUzkD9B7oRfQUah/i/+WFY3cxsVAzOQkkcQL4iZBR3i65D1JFJjRquSk1RZuadW2wlbHVopgJWzcGZQNPh9iKGdotfnb9K+c/jBW/fmUuR+WZsFRDbYlR0CT/Gfbz0vr6+VoT1uPDUIYHke4jjBXH7LCS8Dg1nhsXQGhLGkbmdTlGdabyfCF8Q5ia6pUPMccbi/dzc4HmmN5svDeDmNEtE3X6nYTrQsuGqUxAmto9M9AjLGy26PIGJES3o77+CadtD+wyXBFvqWWuvkas/IHk+ScQ+2M18R8aqB4B2e1q49uiYI828d0zoSNViAYiDcsKwm4XDXkH4UPmeF4AduAe+8QMwDMp53BjMs2s8f8yjca34/W7+1Ib2UoEO7ppWaBZddtUAee6UxMVkMK3LJyI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385efa89-1853-4bd3-0ca7-08db5849ca4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 09:16:55.2706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7ApIF6+N4q6tiIFCU9cXB93sy5JlXZ+8y35wEuFWbqf+3aRSOCw6OOgm61cax/IqOWPb/S5n/U6K3uro4MmdD4o/bCOJou4Ta/utq2yRt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5632
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx06: use a fine-grained timestamp
 for the second time fetch
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



on 2023/05/18 19:32, Jeff Layton wrote:
> I have a patchset in progress to change the kernel to sometimes use
> fine-grained timestamps for the mtime/ctime. With this, the statx06 test
> sometimes fails.
> 
> Change the test to grab a fine-grained timestamp for the "after" value,
> which fixes the issue.

Now, it is not a right time to review this patch,  I prefer to review 
this when your kernel patchset is merged into linux master or 
linux-next. Then we can add a comment or a kernel commit id to explain 
this..

Best Regard
Yang Xu

> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   testcases/kernel/syscalls/statx/statx06.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
> index ce82b905bebd..fa75982b0901 100644
> --- a/testcases/kernel/syscalls/statx/statx06.c
> +++ b/testcases/kernel/syscalls/statx/statx06.c
> @@ -109,7 +109,7 @@ static void test_statx(unsigned int test_nr)
>   	clock_wait_tick();
>   	tc->operation();
>   	clock_wait_tick();
> -	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
> +	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &after_time);
>   
>   	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_ALL, &buff));
>   	if (TST_RET != 0) {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
