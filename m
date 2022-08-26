Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460FBECAAD2
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 06:33:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8F9B3CA475
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 08:33:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2D4D3CA3C0
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 08:33:39 +0200 (CEST)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 38F2010007C1
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 08:33:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1661495619; x=1693031619;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=n1ITnpK2FTtyYgUpwCEgQnXcZmxiiEfBOAF27NnxtSY=;
 b=dE5BgnOmM+Qh7rqize2BuBCTefuHNVElNdRFj/qPyYizyRAppIC+AvRd
 dY9kFJOQDoaQKf6FOmvwSydATLWRmjf6Zi6SE4NcdzwyFQa+bDhBljQzC
 Scp2gWD+dD/pGMRSrrxyhIQtsmB5otKH4Cd9pywtjQ2GijnlbwrlAHGbZ
 hrMsVrU78AslwQsvS4sSsSpu6cKcqlswb9Ui2Ya0poI9Zpu1kzIcHObOX
 hduP6CdB6qBiedzp1qr1SLql20kQfKojegrRLsCGvQ4cCqZnR/BzylG9k
 0S2ZjgkyhAfuT/EAEiAWTUhGevzlDQxt1hTRGmPsZhUPBc+RMLm6+eG6B A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="63383582"
X-IronPort-AV: E=Sophos;i="5.93,264,1654527600"; d="scan'208";a="63383582"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2022 15:33:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVFEsK6J99s16Xuh0h2yMCRCAr8sgqS1kNhRBnBoc3sK8WM2jkwN7/MYe88CF03rfoYw6SMWoteSJcP98GYFUDToqWXzxof102n2b5UG4xQypoo0QbULpx+RYjM+2VkFnCjsXQICywRjgbjHr3YKNp8mIPUmoQNUmO+6NU2k+vmtSDgLGmB8GJ/csnoCjTmh08cyn2Z2bgtCZy0vJPMTwBxn2K2GJZ+Q0KgStQ/inT82JxaXfszqJfEDCfAUrq/NAcCD9vsSj0cNLmF/v6ATU16L28JpAhwRGC7r2KUgz+5ACblrzQ4WUZw1G2K8FqqYxYIHG2W4391E78o4K+PxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1ITnpK2FTtyYgUpwCEgQnXcZmxiiEfBOAF27NnxtSY=;
 b=H2juig1LZ98LoVFEVvaWMrATHm/J0yareI4h4MSbhHzNp3uUupbCye+DtgeVWLSXqBD01b9REgEo3dLg6efVneJeTpuXFF+AFyJi3KRxFHnsJokjIJ9iuRDznlL64ZRwO3D5lr52+PGxR4C/XCzlebGMnfhgdlzEPXScflMhTKtJUn7NOsB8iIyhGu9Xhg1mPYMtL/yE5GplqwqJecU62jPT1K4CBKFy1OlZlpXQwDzYKCiCM007PelgTWV3hNAWBoJL79m3Utb1RbqDwAytGJkoQwhhVEvf3XbivkR00lIMMeBqRx8J1Xqk/SvlZamPlMWWXi5lDN+IwC97W95ZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB6509.jpnprd01.prod.outlook.com (2603:1096:400:93::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 06:33:32 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5546.022; Fri, 26 Aug 2022
 06:33:32 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH v4 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
Thread-Index: AQHYuPfKGQVcjViHoU66z98aCNLwwa3ArqkAgAAb5oA=
Date: Fri, 26 Aug 2022 06:33:31 +0000
Message-ID: <b9938f68-83be-327a-b29e-8cabc37e0882@fujitsu.com>
References: <871qt42tev.fsf@suse.de>
 <1661486365-2361-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1661486365-2361-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <87o7w71rcj.fsf@suse.de>
In-Reply-To: <87o7w71rcj.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2c342e5-529b-4a9e-14f2-08da872ce534
x-ms-traffictypediagnostic: TYCPR01MB6509:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8m9XSzynX9fOaa2aFHeKvnCBZC5CbpO8OEz+FjkZ378rYEpfvMRByN3FyUDwGk5tOEs/dwdidEhN2uVdSomBOenFsXMFKjVY5f5sx+kGrJnBzqAy6qegLpU1lq5wD8U/GNT5HnzXeEkftSc5Fa9tuHuRcsAJcwkMBBCMjPQ/Y+fZ1srEZ/1O9FIR/pK1+jOm3HwnQg8TlKP2K5VMgXSKocTTRrSMQFJK6tdCT/+QvvbioLfhoQo6IgSLP6Q79g0GfD/+OmpEXADrADWfvLPIYag1QMrHLvdk+bAXqixv6WeHR7Z4PaWR1befUKj/GIgI90DwMmoVgdfDcC74in9xhO31likClC/mCeos8ecx2pFTH5eMeguRfO18hNLksaOeB0ODH7ABtzWsfyKJKyfh6EqJEQWflo3D0i/51B+NuSj5ZPbHEGrvw/EwZzB076qmukkfPy9cV2I2njOdMmVW6uG+UhsqpX6gjZicpe84Kx/zkSWG8djH5jFu+iq4m2IxY4cXVOnj8Tg1tX/TCQAOl91H4JOnLC152fAh3u1FO+kmY6zNhewys0l+ql/4L/bCBxzikY1/VQu5J93VgIpr7S+fnA7mS7xKLke6nTvETH3xYP+Flc1+Dp6uhL/IqafS28PPkfdGddiY0Gl2Os3m4yYF1kDv8rA+K6S42//Q34TcAmgMFC5rMu5Q926OjhSCvbZ19ckZMmKFsjbaJsC3P/O+wQOZ+vbQRTos6LAR0UxsyBMiBMQiqnoVDNQHT/Mwl1uvWUFrQrnrUlmxsQq6wnPzFA5yJOpZgYneCWxjuMeUkERUYch5CdvB640zevCw/tT0+xPuUSNMUJ2Q/y9sOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(1590799006)(6512007)(26005)(186003)(1580799003)(82960400001)(31696002)(86362001)(38070700005)(478600001)(122000001)(6486002)(85182001)(38100700002)(2616005)(8676002)(4744005)(66446008)(76116006)(66476007)(31686004)(64756008)(66946007)(66556008)(91956017)(4326008)(5660300002)(8936002)(41300700001)(36756003)(2906002)(6506007)(316002)(6916009)(71200400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVJCREFWK0JXckVZb1NJZ1JWRVRWMnEyeW1UcHVDUWwyRGNadTJxUFRRMjBQ?=
 =?utf-8?B?M1dvUXBBNDgxcWpqc3Y5Y0tkVEF6czV1VjU5UzE1bVd4WmsxcGhOQjhYV0U1?=
 =?utf-8?B?TVRoelNJZnNBSmJIbGp6VThwOVRJNDcyUnRYaGsrUzBLZTRqQU82elJLTmZU?=
 =?utf-8?B?allNZmRqczdKSllndFZGcHFDazQ0TzZtUnNpS0lYTHFkNk5pMTVoQ1RLK1lP?=
 =?utf-8?B?TTJRSDExeTg3VFZOQkFyZjZ3OFcrcnpjRmZQMnRLOEFlN1lSSlBlUnVlR3NO?=
 =?utf-8?B?bzM2WUFlKzNxbW1TRnBZUHp6UVhCOVdLdlNUOWhGOWx4OEJRei9lMndxRjVV?=
 =?utf-8?B?Rk1lcTMrQ3FxdlJDYU42RTBHTkVEaUdmcHlqL28zb0FBZHNydG9WM1JPbW1o?=
 =?utf-8?B?NGdqdTRJT2hINU9ka29xdVNiaytyeDBJL3p3amg1WW1ZQzhESnNrZ1lNTUxx?=
 =?utf-8?B?Nis2emZ5dC9KZndzRmhuTXdKY1NaOGYxdDVKSjNYdXBJOUxlTlI3YUF2ejJ0?=
 =?utf-8?B?dDQ3NFgzNzhKV1BoNndTamszOFgyOGxpcFgvNWpXRDZySWxTcTFiM3RtaWVG?=
 =?utf-8?B?U3F3NFFSb0FBb0tEK0FqcVVKckMyTkRoTUs3TE9HcThzcFJPVkZpck9DSkFh?=
 =?utf-8?B?Tm82R1FQeURxaW53YmRxN1pXUnVxWGpWa3ZMMkwrVGo3Nmp1R2h1N1ZGc1Y0?=
 =?utf-8?B?QVM5SUdjSGgwR2NFZVZPSEFyTFZxdlJ2SW5aeG0vWEEzZFJadHJURnViTzdN?=
 =?utf-8?B?eUduTGVDbFh2MHI2UkZzU0dWeVZsWHZpaExOcDJnUm9pS3haZlFGNHkxQVVB?=
 =?utf-8?B?SGF5dzBGVU1jY1BFRXgzaXRnWk1WZmFXY2dRRHJOZW5RUE5QQ1RFZkhhaWZP?=
 =?utf-8?B?VjBFVWExR1YwRUw5Yk1NREtEY0pZak5tS3owU3JtS28yci9RRkZrdnZ2Z3N2?=
 =?utf-8?B?dXdvN2gvN09SV2ZRWFBRTEI0N1B1NDJYM0laRnV2RHZ1TVQyTVRxYmlkanVH?=
 =?utf-8?B?dzFCZStvTEI3bGt6SXNvTTVDaUd0WDVpQlhaWFdPcFQvT05sdDM1VkFPaVNJ?=
 =?utf-8?B?VDFzVDM1N0N5SkNvdnJLTFk5RjZtalU2QVVITjdOM2N1ZThNbGhaU2tWOXB3?=
 =?utf-8?B?b2VFQTM2a1dRMTVkVFYxRXIzekxFOEc2QjN1VUNKbElMcmptM2VDa1pJTE1v?=
 =?utf-8?B?R1hvL0xQNER3K1g4NXhCOTlJQUNiVDdjU29Ob1ZOcEFpZGdWVXg5ZExUdlRj?=
 =?utf-8?B?RVZOSjFrNjJlakZoN3Y0blB2bzhIaTBHWFBMSVArMHZ5RzJYNXl5b25BZERn?=
 =?utf-8?B?aitUM0lxQysvZkpoV2Z6VVA1c0pPTGtaSmxSZlFGUGxLSDZJMUV0eXExRXVm?=
 =?utf-8?B?ODA4RkFzVDJQVythR1FtUHFhMkE2b3doQnhZZGZiUTJYU1p2ZlZNTEc0MlJr?=
 =?utf-8?B?QU9sejNyYlJYMWhIRWhWVVR1TkdtSFl2ZmxJOFZyYi9ISFdncWdRL0lhUnJn?=
 =?utf-8?B?NE5wSUhNWlpzY05qRVFrS3E5YVJOc2laTWM2MGp5djJGUS9sWEl2TkgrWkhU?=
 =?utf-8?B?L0NHTEQ3N2I3RVo5RFR1OFd1ZEc5QlpLMXlCR1lOdGlkdDFXS1MxQ0syM0VT?=
 =?utf-8?B?T2Z3S3BXaWJWR2hNbEVtYnRKckFObXZ6aVFyYTNMQWxweHJtYjh4SUhER0Ur?=
 =?utf-8?B?NVdNZ1A3bGpvOGsrN3VIZ25aRnBqSzFmTG5FaXNrVWpCOE9OSEdTTzVaL1Jv?=
 =?utf-8?B?eW1vQTVSQnVHL29TVEszS0pjYmc4NzJOMU5rZGs5eFNEdXRMRFhDM2cwazR2?=
 =?utf-8?B?ZUFsZkZFdmRWT2lPY05IVVdEQ1Q4ek01Z0NsRE4yYXBER1FPK2piKy9oNzFQ?=
 =?utf-8?B?Vlo4VFJQL3l1ZFJwU0hzZ1FyRDA3OUFQWExwSEFjRy82ZFFUVWxYWEFud1FO?=
 =?utf-8?B?a1BlUnFLUXUrUklKb1BaLzVEZjIrNkllK05kRHdXaDB5cXd0TVBRKzlYRXZN?=
 =?utf-8?B?djZ3TVd0Ykpib0FnY2xRYmwxNzkzTXFRVUNhOEVuaUYxQUUycXVvVDcwT3Jh?=
 =?utf-8?B?dEQ5dWJJK1BpOTJrbUVndmhyNUFFbUtmcDdvbURxd2QvYWh1clE0U08rS1E5?=
 =?utf-8?B?ejhzRStwZkwyOHlwS1hXQjNHMitxd0YxN3BVMEJDc0VuMEkxYnUrWlRzd1ow?=
 =?utf-8?B?QWc9PQ==?=
Content-ID: <1F11877773E0444E9812268451529AF8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c342e5-529b-4a9e-14f2-08da872ce534
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 06:33:31.9740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orzIUbHH7VDB/g9UHaqqdhxFqAl6GfFiyNsXsMJP+j+37Ay3zpfRY39LVCUEAWZqkQoyt1yO0mKaGB1bN8rCG0Vb/rcAWpdJkZQd6GD/wns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6509
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
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

Hi Richard

> Hello,
> 
> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
> 
>> safe_cg_open is used to open the sub controller's file ie cgroup.procs
>> and returns the opened fd number. The opened fd array is stored in
>> fds argument.
>>
>> safe_cg_fchown is used to use fchownat to change file's uid and gid.
>>
>> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   include/tst_cgroup.h | 21 +++++++++++++++++++++
>>   lib/tst_cgroup.c     | 41 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 62 insertions(+)
>>
>> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
>> index d06847cc6..db959380f 100644
>> --- a/include/tst_cgroup.h
>> +++ b/include/tst_cgroup.h
>> @@ -89,6 +89,9 @@ enum tst_cg_ver {
>>   	TST_CG_V2 = 2,
>>   };
>>   
>> +/* This value is equal to ROOTS_MAX in tst_cgroup.c. */
>> +#define TST_CG_ROOTS_MAX 32
> 
> Thanks, pushed with small change to this comment. Because
> TST_CG_ROOTS_MAX is actually greater than ROOTS_MAX.

Oh, yes, good catch.

Best Regards
Yang Xu
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
