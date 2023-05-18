Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA52C77B7A
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 06:01:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30EB63CD434
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 08:01:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 678B03CB289
 for <ltp@lists.linux.it>; Thu, 18 May 2023 08:00:57 +0200 (CEST)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D2ED21A009BA
 for <ltp@lists.linux.it>; Thu, 18 May 2023 08:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684389655; x=1715925655;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=zhV8rITsUjMFVPEUZr9LabRD+XmYnwrKYnGgQ6/hNkw=;
 b=PPKHGUL7TyWR9AG/yqvjZduqF//jauHCGsYFjmAN27E79VFgViB4saJb
 rum4qN0li913mpHMs3POpOKzGGIFK7yqIqlSbXzp0cpu7usizSjTul/5x
 X5EHVbxViNNT6k7YLVoN4Up8rZHSzceVlTp/jW6/yqo8neqwjAUbHhO/K
 aSDa9BEGBHrhs+QADElj5/TLJxns+/8iHx2LLchFCxGg24T6loYtN2Dq1
 2X//wkXIuojhl04hgEgqH+0jD7YMJcXRbRmV9gZmAkxFJYsBvf7Hagwzo
 jBc509hIbtD61GVJCG+/VGtx5m16oD2x59IiqzA4ByVJGQbQ7ogLwGiqq w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="84755753"
X-IronPort-AV: E=Sophos;i="5.99,284,1677510000"; d="scan'208";a="84755753"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 15:00:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArHcRXDuVMzrANztgD/dwCB0K1tvBa7xSFXd/PHtTJO4V/hpy4j69kZo/E75LEowSqQOzqQS9KjzeieSz13rGzNPW6Bv9gYn6K5n3rkZhupWICazFNl9aQxG2Pp/JaYJ2eH3hca4y96Ni03A4GLA32RJmY3KvXwx3IVmBXhVD3tucLD8BdhgX1xgGEhBXeBLYoqV+NuxBepqgMsSek8OwBIaBYynZdzmZnZo06Zan5Gelagsjj5j4PTXG6HvPLUZIJz6Ec//VKomFMYLoUYeW2lZUsPA0mUrPpop1MkyZQFdOVX0YhiVmyVo1MXNoyi6tNLzp7Xy7+J6jm5ilE11Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhV8rITsUjMFVPEUZr9LabRD+XmYnwrKYnGgQ6/hNkw=;
 b=VU09ds84Vx+lg13A3ykjcDlPsIEq1szBx5d6tDNFtELxwdtbDf2DxSsI5qFk1srVGNshx+nfkD1+Ol163sKOjyK/QISfadNzzds+UqE76GaB03n5WylwffIniNInTqTbwN0CGHcAtKf9xFztx8osA06MHwv5gggMnvxR4+aeWZi95I5+7hhd9VnOBW9PaXaME/p95z+TIaF8tJMgr5VAajHfa1WrdKq9IzMjZbAxNyZw44lBDGMF167x8ffnOLTNJA2IYscs5jEwTWhxiL3WisLVEXDxElKRSTy1Zd+0Bk5ytrTLVymIvmH/1qN9UyaxqWhjCT2EFgBHVoiMz0zWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TY1PR01MB10659.jpnprd01.prod.outlook.com (2603:1096:400:326::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Thu, 18 May
 2023 06:00:49 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1%3]) with mapi id 15.20.6387.030; Thu, 18 May 2023
 06:00:49 +0000
From: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v6 1/6] include/lapi: Move AT_* related macros to
 fcntl header
Thread-Index: AQHZhvyUJXIjZRnl1kCB7quBcgvZsq9fjjMA
Date: Thu, 18 May 2023 06:00:49 +0000
Message-ID: <2481a69d-7bc6-1644-79ef-821313abb4f5@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|TY1PR01MB10659:EE_
x-ms-office365-filtering-correlation-id: 8e874b72-9118-4dcb-c117-08db57653b11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9se2baPdwXSTuoUiaWAhfcAHOV/igTCHIElPpHiXcc4BdtyNJOnIkX63EGbjz6cM5DUZ6tCrIkgcFNwjX8OkcdXeTqstsaVEyzlaxN75K9wdiohIwM0XNi9Zy19I5cqieEGvYdHxE8+tz7WxjxHZlU5rNJJwRJEdOb7FydZ8zHZ0g74sKf5R2Gvy4socUtmnrc0dN6/w/fixUtr1di/+dyHA3MQmRHog/f/rFzXVe1ZUvP7Odr4kTBaf7Civxr13SGp0q5iXXaID7elgnCB0rM6DlcoTOuOrLOQc+FjZZSfERONtRS0vlPH+EQtpTXEvSST8ntb6mMYXPVF+dsaSqKYfCNNTcHEQ11LBznYaWSm57K4Gwcm8mSc+BpPoFnukokirz6MKifTNvFyi2stNQ/HlfJWDRoF1Eqde8IpFUlxaAYEyaOSfEQkLAlIY3BNR4sMBT30TF1B3fmKcZWpGiyOwpMJGLCgAsNPcr4BnH5LBFcIgvXtleBpunTxHk2MpD0N5RhjyN9z4JTMmdWh6s+eTAdFgm4atwQQb5q4lOa8oNAj4ogfKkDmQKijTf7CcYTKV7rHFNmwJJ0sRtywFDo9CGdo3nGzVuGlLmHwKFFD22Hp0cfmlL21rXjWZEWm0Pge/JM2at1S5XAq5p4hnvh1p/kcCk2krZxxTHD1aaVvLhDY4OzEkrmHTMoSGAIL+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB9499.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(1590799018)(5660300002)(8936002)(8676002)(83380400001)(2616005)(2906002)(122000001)(186003)(38100700002)(36756003)(82960400001)(86362001)(38070700005)(31696002)(478600001)(26005)(53546011)(6506007)(110136005)(71200400001)(316002)(6512007)(85182001)(66476007)(76116006)(66556008)(64756008)(91956017)(66946007)(66446008)(6486002)(31686004)(41300700001)(1580799015)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0wrYndUUGRnaVpvKzA3SmVlbW9QT3JNQlM5Q29FbUZHTC9aQWpxbXM4Um10?=
 =?utf-8?B?MjNtb2JuZkd2NWV4WE9rTEFVVVh3b1AxN2JmMlZCS2UvREIrOElBTHB0aG1n?=
 =?utf-8?B?b2JXWVNOQSt0WldWL1o5TE1yVkxxa0RiN0RnT1UvRWk1Q29oYUtpdHd6anAw?=
 =?utf-8?B?U3NhV0Jlb1N4emZLcWdMbnRZeGkwQXdXWlNyc0RLTklCT3VoMVV2S1dyQlZ6?=
 =?utf-8?B?RC9MSkRmSExrd0lpT3dzQVZnOEF0b1ZSNDdONXNIOFVzcmV2VWEzNXo4eS92?=
 =?utf-8?B?N084ZjNpTy8rOHdmMEZVMHNSQkI5THhNZGl5c0VnV3plUHJRUTBVRk1KZVE2?=
 =?utf-8?B?T3JkakxBc0dQcm1ocmcxRmxOaDREaTdIODVnYU9yUFZSSGhzVXdWaE4zamph?=
 =?utf-8?B?cC9DWjJsbHlRaW9EQTFuUHNFQnh0OGFVSnVUL2tjV0k2QVg1dGFEVDUzNnpE?=
 =?utf-8?B?WTZWV1ptcmZIaE1Qa1phb2RMMkN2bncraCtsa0ZjUmxBdGhneGJPUTNRbnFa?=
 =?utf-8?B?Y0R4MnlFOUlqa2VZZGlkSy82YllrNWt4OUIzaUloSW11WnREL1F5VjRMaCtX?=
 =?utf-8?B?RU85bjNnRTYrc2t2a0lOOFkxSythelZ3R2orNTAwZ3JwcDNUdjI0ZjZORzM1?=
 =?utf-8?B?ZVh3TUpHdEdRZzhtUlB2bTUvT3k2djltZHhSWGo4RHNjekRWVGJBZHc2UGtz?=
 =?utf-8?B?Ym9CK0U0ZEhobnZyeWVlR0dIalF5Zk9hYXNtbFRkNTBia1p5WHREY01oZEgr?=
 =?utf-8?B?RUNaTlhycVVoTjVMWmxTY2NhK1AzTmQwYlQvdXFsMEd2UTZ3Yk1BSnk4d2hs?=
 =?utf-8?B?UnZ0WWQyWWFhY1p5dHVxQ2R1MUFvU0xITVpBYzZKMVRnQXFQaFU5OTczSGJl?=
 =?utf-8?B?MVZ5Ymg1MVVnbHRjZ0lyQ1U2ZUJBYWtOOW84TXUwaWNaUVFzZkxaeWFaa0h2?=
 =?utf-8?B?ZjJLd3l6NFUrWTQrWklqQXBzWGExL2JyTjhxZ09haldqZEswUUZCSFpCQWpD?=
 =?utf-8?B?SG9hZDVzMUVrbHRxWHJUbFV5ZzV6WnRBZ256NXlXY0pvV2FhNTBrNDZXSERU?=
 =?utf-8?B?SWF2QmdxdXJ6ZFVSUStzd3NtUng1cEtZeUdzOHZGU2NlSTUyV2lldjUwY0hW?=
 =?utf-8?B?OGR1MlVaVFNkKzBoRmZacHFPdTg5THBEMXhQK3ZGTWFuZVNyeTNrcFU5Z0xH?=
 =?utf-8?B?WUtIZWt3V29jWGwxMmIxK1VhbHdlZ01MTkVOVlk2WUIvRkpybCtFbkhLTmhN?=
 =?utf-8?B?T0hkYnJUamFvYm9uZ2xpQk5UNkxEZWV5YUtzei85bFFndmlhSWNkOFBzdkhx?=
 =?utf-8?B?cjdlK1IvamI1RElUZ1piM2syblExZ0lSSzFubHU1am1hMVo0SHFHSTRrZnRj?=
 =?utf-8?B?YTc5aVNqYTZIRDZWVWhVa0hOdEtZOXlMV3hMSkZMaUk5UWxnTXp4YXExVnUw?=
 =?utf-8?B?UG1RTi8yalh5UWc5QWk5OXNqekg2VGVyamtodlJqL2RVV1hHS3A0cFlCT0hm?=
 =?utf-8?B?U3NhTkc0WmZuQlpLYlFZd21GbkZXZUhUOWFqUUhYVWo0TGdYRGtiVzB5cjFt?=
 =?utf-8?B?RmtmeDJlNzZacVYrT2xDb3I2OTZtdVMrWitKdG4wUkRDcjFoQ0J3blVJMVBu?=
 =?utf-8?B?ZXZIVFBhcnRpZjI5dmcvNERvaXgwRTJJTktHVW4zazM0SmhUTW52VVFKMzIy?=
 =?utf-8?B?RVJHazF6Y1U5NldqYktaaTFFa3g2TXdmMWF4ZUtuTjJKbFNYWHBxR2RoKzFi?=
 =?utf-8?B?ei9ZT0ZxMlNTWWJwcURWeGVlKzgyZFppRjFZMkI5QkVuRnBrOFVnL2dlNHNX?=
 =?utf-8?B?eVpsUmNWMnBiS2NPTHhFVFBRUmxIV2tnWDN2VU5ZNExmKzNEYXE4c2thUnZT?=
 =?utf-8?B?RFhVVE4xMVFDSjhYYXdHbk0rVHBPNXZzZ3FWMWRDL3NramxDejJGbUJRRFVj?=
 =?utf-8?B?SGQ5dDVpSjN3Nkx1emIwTzY0b2dneXdnZURSSncvanljdUNXYy9BVjFnZ0FR?=
 =?utf-8?B?K25SQytwNGY4TGJiUllMSnhZT29xZnR2MjVxcmwxWktxc3dzQkhsYjBBbDJP?=
 =?utf-8?B?VHNWNzdEdFIxOXlvTGtoTU1RS24yaUtSY1I4RFVUNjdtS0dIQTdMOHhhSmJn?=
 =?utf-8?B?cUJabVRpb3ZpUGI5QkJoNXpOUVQ5VWRZMW5raVIwMXdBbVQwTFl1dW1Qd2Mv?=
 =?utf-8?B?bHc9PQ==?=
Content-ID: <3202736DFEC9BA418ACD8756DAA4DB9C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oF4JvNaLtBIFr1Wi+1MEFHYKWrXzejDy2Bt50V3mcu1EggQGoPPJjGdxhHIX6hoPo+0Wt4GwWzAtpGxmqYSNMpJMhe9axNZFrMEfO5vFsxSqnDSxxe7w/Q2/oK8+qwzqfw4XWmvSvX362gx0wU8ux2PgFdZlnV20F7CvmalMaA2sZe5C2iUShw77EuiM8WCN2yp/jieBw7iNYUZrsVSAtEPp0KzeYEQi3U1sO+xE6uLpLdBC6TuTkKJSODTHfTcO+/T9Dl/xUDltUi6v179pF2soLI/GGw3GyRY1Ye26lT1MdN7VpvGWIL/ScqnEN8zMV0nhYySRkG3HWEPRjVbynI2AOTmq4ZmB5SfIZE6qqctZDs8hVWJxQBfFJcwi0rdgi0KWjV3iNwONQsy/yTOPFFd/XM+f0wXg5cv9SqKWJ6QGrKvShlCOAivfYYG4LriEqxJGTAV2jCqqLf62eCCk3BqEQ2WlWJU1A3CZDSC3jyVoy2aIqXjwxS6mRVEtjvUw883uhxeTKriTj5r4sPQIL4hbejTGGB4WyGJU7VF1DGpaM7UKXSM7oeheKCVthlxjARrg2msCTLn5PF5ckmyZA9IBjgCXYl7aUjqSR5MGO93CHgJZXr++SjMlGdiCsBgyeO6gEf+Bzx9csHVKvYQENYoQHSf3dm/097O0us6bAFAdTASgYtE1WKx8RX2tx9VFQSq6Yqm4q8qOHemyWCT2UVF0QnvwSohGgYks9zZ2TON9wPZGyB1H60YEpxT0Vt6SRhXUIwetnmE8cWoq4BE/SA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e874b72-9118-4dcb-c117-08db57653b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 06:00:49.6815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msLbxd16Qam7L1ttDjQ7DNYduvGjuXsLAVRDBltbJoGTvPJ0VAW+6SpTIqAV7gLCkfDneuRCZOVdNMPF4oQSlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10659
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/6] include/lapi: Move AT_* related macros to
 fcntl header
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

On 2023/5/15 15:11, Yang Xu wrote:
> These AT* macro is belong to fcntl.h instead of stat.h.
> So move them.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   include/lapi/fcntl.h                          | 32 +++++++++++++----
>   include/lapi/stat.h                           | 36 -------------------
>   .../syscalls/mount_setattr/mount_setattr01.c  |  2 +-
>   testcases/kernel/syscalls/statx/statx01.c     |  1 +
>   testcases/kernel/syscalls/statx/statx02.c     |  1 +
>   testcases/kernel/syscalls/statx/statx05.c     |  1 +
>   testcases/kernel/syscalls/statx/statx07.c     |  1 +
>   testcases/kernel/syscalls/statx/statx08.c     |  1 +
>   testcases/kernel/syscalls/statx/statx09.c     |  1 +
>   9 files changed, 33 insertions(+), 43 deletions(-)
> 
> diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
> index f17220737..8fc92c521 100644
> --- a/include/lapi/fcntl.h
> +++ b/include/lapi/fcntl.h
> @@ -87,20 +87,40 @@
>   # define AT_FDCWD -100
>   #endif
>   
> +#ifndef AT_SYMLINK_NOFOLLOW
> +# define AT_SYMLINK_NOFOLLOW 	0x100
> +#endif
> +
> +#ifndef AT_REMOVEDIR
> +# define AT_REMOVEDIR 		0x200
> +#endif
> +
>   #ifndef AT_SYMLINK_FOLLOW
> -# define AT_SYMLINK_FOLLOW 0x400
> +# define AT_SYMLINK_FOLLOW	0x400
>   #endif
>   
> -#ifndef AT_SYMLINK_NOFOLLOW
> -# define AT_SYMLINK_NOFOLLOW 0x100
> +#ifndef AT_NO_AUTOMOUNT
> +# define AT_NO_AUTOMOUNT	0x800
>   #endif
>   
>   #ifndef AT_EMPTY_PATH
> -# define AT_EMPTY_PATH 0x1000
> +# define AT_EMPTY_PATH		0x1000
>   #endif
>   
> -#ifndef AT_REMOVEDIR
> -# define AT_REMOVEDIR 0x200
> +#ifndef AT_STATX_SYNC_AS_STAT
> +# define AT_STATX_SYNC_AS_STAT	0x0000
> +#endif
> +
> +#ifndef AT_STATX_FORCE_SYNC
> +# define AT_STATX_FORCE_SYNC	0x2000
> +#endif
> +
> +#ifndef AT_STATX_DONT_SYNC
> +# define AT_STATX_DONT_SYNC	0x4000
> +#endif
> +
> +#ifndef AT_STATX_SYNC_TYPE
> +# define AT_STATX_SYNC_TYPE	0x6000
>   #endif
>   
>   #ifndef O_NOATIME
> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index ce1f2b678..590ccd111 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -227,40 +227,4 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>   # define STATX_ATTR_VERITY	0x00100000
>   #endif
>   
> -#ifndef AT_SYMLINK_NOFOLLOW
> -# define AT_SYMLINK_NOFOLLOW	0x100
> -#endif
> -
> -#ifndef AT_REMOVEDIR
> -# define AT_REMOVEDIR		0x200
> -#endif
> -
> -#ifndef AT_SYMLINK_FOLLOW
> -# define AT_SYMLINK_FOLLOW	0x400
> -#endif
> -
> -#ifndef AT_NO_AUTOMOUNT
> -# define AT_NO_AUTOMOUNT	0x800
> -#endif
> -
> -#ifndef AT_EMPTY_PATH
> -# define AT_EMPTY_PATH		0x1000
> -#endif
> -
> -#ifndef AT_STATX_SYNC_TYPE
> -# define AT_STATX_SYNC_TYPE	0x6000
> -#endif
> -
> -#ifndef AT_STATX_SYNC_AS_STAT
> -# define AT_STATX_SYNC_AS_STAT	0x0000
> -#endif
> -
> -#ifndef AT_STATX_FORCE_SYNC
> -# define AT_STATX_FORCE_SYNC	0x2000
> -#endif
> -
> -#ifndef AT_STATX_DONT_SYNC
> -# define AT_STATX_DONT_SYNC	0x4000
> -#endif
> -
>   #endif /* LAPI_STAT_H__ */
> diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
> index 83746b878..616ec5341 100644
> --- a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
> +++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
> @@ -32,7 +32,7 @@
>   #include <sys/statvfs.h>
>   #include "tst_test.h"
>   #include "lapi/fsmount.h"
> -#include "lapi/stat.h"
> +#include "lapi/fcntl.h"Hi Xu

It seems unnecessary here because "lapi/fsmount.h" has included 
"lapi/fcntl.h".

>   
>   #define MNTPOINT        "mntpoint"
>   #define OT_MNTPOINT     "ot_mntpoint"
> diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
> index 68f56549f..f9c2748d2 100644
> --- a/testcases/kernel/syscalls/statx/statx01.c
> +++ b/testcases/kernel/syscalls/statx/statx01.c
> @@ -33,6 +33,7 @@
>   #include "tst_test.h"
>   #include "tst_safe_macros.h"
>   #include "lapi/stat.h"
> +#include "lapi/fcntl.h"
>   #include "tst_safe_stdio.h"
>   #include <string.h>
>   #include <inttypes.h>
> diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
> index a8e868d7a..5ed80894d 100644
> --- a/testcases/kernel/syscalls/statx/statx02.c
> +++ b/testcases/kernel/syscalls/statx/statx02.c
> @@ -28,6 +28,7 @@
>   #include "tst_test.h"
>   #include "tst_safe_macros.h"
>   #include "lapi/stat.h"
> +#include "lapi/fcntl.h"
>   
>   #define TESTFILE "test_temp"
>   #define LINK_FILE "test_temp_ln"

I hope we can add "lapi/fcntl.h" for all statx tests because AT_FDCWD 
macro which may not be defined is used by all tests.

> diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
> index f62dadd5c..9781b3e70 100644
> --- a/testcases/kernel/syscalls/statx/statx05.c
> +++ b/testcases/kernel/syscalls/statx/statx05.c
> @@ -27,6 +27,7 @@
>   #include "tst_test.h"
>   #include "lapi/fs.h"
>   #include "lapi/stat.h"
> +#include "lapi/fcntl.h"
>   
>   #define MNTPOINT "mnt_point"
>   #define TESTDIR_FLAGGED MNTPOINT"/test_dir1"
> diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
> index b13c11f72..f688b1b0f 100644
> --- a/testcases/kernel/syscalls/statx/statx07.c
> +++ b/testcases/kernel/syscalls/statx/statx07.c
> @@ -39,6 +39,7 @@
>   #include <sys/mount.h>
>   #include "tst_test.h"
>   #include "lapi/stat.h"
> +#include "lapi/fcntl.h"
>   
>   #define MODE(X) (X & (~S_IFMT))
>   #define FLAG_NAME(x) .flag = x, .flag_name = #x
> diff --git a/testcases/kernel/syscalls/statx/statx08.c b/testcases/kernel/syscalls/statx/statx08.c
> index 10b1ca460..64b36986d 100644
> --- a/testcases/kernel/syscalls/statx/statx08.c
> +++ b/testcases/kernel/syscalls/statx/statx08.c
> @@ -26,6 +26,7 @@
>   #include "lapi/fs.h"
>   #include <stdlib.h>
>   #include "lapi/stat.h"
> +#include "lapi/fcntl.h"
>   
>   #define MOUNT_POINT "mntpoint"
>   #define TESTDIR_FLAGGED MOUNT_POINT"/test_dir1"
> diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
> index aea329e08..c03d2c91e 100644
> --- a/testcases/kernel/syscalls/statx/statx09.c
> +++ b/testcases/kernel/syscalls/statx/statx09.c
> @@ -24,6 +24,7 @@
>   #include "lapi/fs.h"
>   #include "lapi/fsverity.h"
>   #include "lapi/stat.h"
> +#include "lapi/fcntl.h"
>   #include <inttypes.h>
>   
>   #define MNTPOINT "mnt_point"

Other than that looks good to me.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
