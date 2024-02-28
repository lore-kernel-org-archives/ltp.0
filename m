Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88F9C54E41
	for <ltp@archiver.kernel.org>; Wed, 28 Feb 2024 08:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709108133; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6uilhpOn4yuLYZNd2G/11Nww22F6he7z6JSlxEsONM0=;
 b=H4y9CJcAwykabvKK6NJMX2/HfrfW2ErmjHva3JFhvxihoFdrIH+O0B6BLbD5PK+Avhnxi
 +HfljqkDR5UYatg243vAEmI+1y9Wgo+2SvqYWN4jKG3kd2FEHNhhx1peC7z5sWhWN/+LX97
 rX6Af2OqTqJozgl7ZdT2Yx/77ldFor4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAC2B3CEE25
	for <ltp@archiver.kernel.org>; Wed, 28 Feb 2024 09:15:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A0D03C1848
 for <ltp@lists.linux.it>; Wed, 28 Feb 2024 09:15:11 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.159.83;
 helo=esa6.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BA1D9600045
 for <ltp@lists.linux.it>; Wed, 28 Feb 2024 09:15:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1709108110; x=1740644110;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=X3Jgldf7t9OxmjTkn9OwE7vzBRzboBdv98pOU+E92lw=;
 b=WF1241rBx2GbAciysG0kMpvGce+iWwwG0LixB6VvnvMEvQDSoAMXgizh
 iK53z6nnQsH6ijNW+BdB2i3rJi89JU0N79vZhhif5u0V2D2f0S9h8qrx+
 oLK1nwR4LSGagP8Us7JoYBzRixumLJnadVw5AGx0N7w8lTbhJuzw5Gqh6
 bAyYitJaiZgeJFFe93xKF0xjTsEGLCHW7/IrNHq0e6oPrAsxV/LAGcwTu
 J/skgtMdDNate3QcmHRFssBfLWVZY+vBItavEVhav1xTEqmTL4Z/2mz8+
 JtSFQF7uVuRGwV/mr2IAGCwv5OedQWCl3JBgIdp4IJ5jKN1Fmku5OG8Oa g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="112472572"
X-IronPort-AV: E=Sophos;i="6.06,190,1705330800"; d="scan'208";a="112472572"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 17:15:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxLNHQdmBQmLQQ1R/YUclQWg2QF3pqB11x3SXa+GEQXSqqwFhwgbS3c+8R7l6gkRrs2M55hCl7g3THvhSN+4kP3OekN2dpSW3bKvtloPXT8qnOyJgVQOgMO4tCDF8FFKW6HRtN9dAfki4ZtDjZEOCA+o9OFfBPYANnE7xAGH4bykKxCmgBQ4vmOlrMC/fkbL/DuDzxKO2A/fjSlMv3UYz9TdLR7JX5E8jn75V9oXWJW+ftjQGuY6mW/Cn4duEffJBMHQ3ncsC5d7Wyz9lj/nRU4GcSb01+m5cf0/sQTwMaXcbp265f5RJ4e6//9azC3vIqAeo+P2BLeXy0nm3nMi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3Jgldf7t9OxmjTkn9OwE7vzBRzboBdv98pOU+E92lw=;
 b=Gb2TBJ+Msoj/rEHZdxQF6wM1sI/nN8Zy0HMnC0wGJoMNSyX92U1Svz2ARy23meIME0VThKpuvEQBeSknc6pIMYHSXx6VCG00ZtL04URkgJufQa5LCSo4INf08agrFXOP9FnHrn2AUGfao9BwCXd7+okO/gGouJ+pcbBVmzCS/XsIJp/fybXMJa4JN0rAIpAhL2XpJm6b2rDTmSh7VvfcVDYRiYUEz+i0H3+8eoVGiDFiA3hLHX0EOBu7NhSFWZQty6qM+YfTTWuj0X6tR2cm9fKABY6B8ktlEi0Y25aJxB/3KGtrGlIHogG04Zwrm8/9U2DE5VMb0s1YrfYkAKSKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYXPR01MB1584.jpnprd01.prod.outlook.com (2603:1096:403:d::21)
 by TYAPR01MB6185.jpnprd01.prod.outlook.com (2603:1096:402:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 08:15:05 +0000
Received: from TYXPR01MB1584.jpnprd01.prod.outlook.com
 ([fe80::c9eb:72b8:f662:c9fd]) by TYXPR01MB1584.jpnprd01.prod.outlook.com
 ([fe80::c9eb:72b8:f662:c9fd%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 08:15:05 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v5 6/7] syscalls/swapon03: Simply this case
Thread-Index: AQHaaLteOabgSV1rdUWpNDEIaCqsvrEfXMuAgAAOM4A=
Date: Wed, 28 Feb 2024 08:15:05 +0000
Message-ID: <965fe6c7-118f-4c76-b7f8-a83308cdd54c@fujitsu.com>
References: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
 <20240226135336.19733-6-xuyang2018.jy@fujitsu.com>
 <20240228072413.GB1581418@pevik>
In-Reply-To: <20240228072413.GB1581418@pevik>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1584:EE_|TYAPR01MB6185:EE_
x-ms-office365-filtering-correlation-id: b9859032-bd72-4994-5485-08dc38355eba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z+wEYciuIjaip2aa7c0KWSNBi/4Wjm9GCE6Inw7ga3HkXPIIf07iU6D2wGixBT8YdttVmnZzkRAWYPXZkgENn60lqfmxAfCk+E1LojtJ5jbJpbnTRWGzGOQAewM4PlGIzbF567snNDsT3ntB0RIGPe5gNEAEloT45rNaSI0FMPS6mkJwOtLE652Lj713L/bjNKyHJWh3GO9GBNkGeeD7ENnMbdusfXlfh/Tnl4mRNoEDlO+p+L4bOQVCErDhAbVVNTGFopApiGGJUwBuw4Zh7cOr5B/CYtTGFYiKuYrw61QLV0JuZUR95I0LNiJMWQopZ7CiaU8VA3UG/5Lo0B8iRfNYMRqUWx9gIMlc+Ri/oe/15QQt0tqoXVcxvuvovN6TVAggXwzdcX7/c+R+AlGRbm9RVeQY3hxP1VFOxdLrfAxQjV8JCCoCKobSpQARWvdtf85qIK8gBkMZjIvTME7h3Va4W/RhQSUWK+YKFusul9nI2DZKqtG1dL5ht4su9Fhbke6WsWPVuwpsmNH86ApHDfh+KMod68Tzf+P7tOLNCzffKvR5YfbCNANd/es+3xq+8t+W+wgoEYT0ItHGXzh/2dgHzOb50IcX7g/vPAbHPHhMo8qXJk0e2BG77XessVliQe1NN25Tsk0uAQ3v27d/BBwc6e4A4BBx+vyhMVBQOPXuTWxysoCK4N6TqA3m6kq+iG6ceFsNpL2P62pYj1bQPjOFOp7riNZGdziS8aQhYW0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYXPR01MB1584.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1580799018)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1Vjb3g3UmFjbko2YTkxeTR4QUtIbGtlRjEzY0grTy9GTXFCRjFxNXV0aVR1?=
 =?utf-8?B?WFJSMWprN1RjWFNkM3BZY1kvb0x5L0QvWDEyRDZGSlA1S1RVSUhUNmJiNU5l?=
 =?utf-8?B?cHhEa2dpeXZUMmNRVlB2U2ZuUG4vZ1U1VEw3cHIxa08zc3o5ZklNVkNObTFr?=
 =?utf-8?B?TEY1WUo3enRjWE1NSmxKNlF4VVF4THl5aTgrdG0vS2VSbGM4dldUamlLWW40?=
 =?utf-8?B?Lzl3MkV4RmJhNytQWG1nLzhUSUFVZCtrWTVMallMTG81Tmx6cnZkanJsZzE2?=
 =?utf-8?B?TnNxOVpheXRvMHYzUlhqMno3V2MyU3Bib1E3b1p2bytDLzJVcmw4ZjVlb3VC?=
 =?utf-8?B?TVY4aVFaVUVKcXR4a3pKVysxZTV4eUZaMFF4YXZSRFhVb1M0OHQ0VHZBTHcv?=
 =?utf-8?B?cGw1OWJGTjZxZHczWUdJd2lTei96SnYyQVJWN2UrUGtKN3FsUVVlakhCYUZq?=
 =?utf-8?B?NERxbm96Y0JMT1U4Y2Q0QVBYdlVTNmx2elJmMzhXdk9HY0RDU25XcW1aTVp4?=
 =?utf-8?B?dVB2ZzJrMkZQNzZzdXB5d0UvSnJweWxjMVd4ekRlc3pSWFhpSUx0QmMrR3RI?=
 =?utf-8?B?dTlxZ3JOMnRtRnF0VHRSK25vZDhKbVBoUlh2ZGJtc2VZTldnV2JPSy8zTlAx?=
 =?utf-8?B?VENlRUdHSlNWNERGWC9WamNodjRCU3pOM0ZvZE1USXNaTmxLNnRmVHA4ejJw?=
 =?utf-8?B?aS9ldjlsOHAxeFk2Uk1YQWRBQU8xaWV5ZFlTdUxTakRKYzNlTndNN0huZnZr?=
 =?utf-8?B?MmlEbGthZ28xZkdDSFdlbnQ1SUNoL0l5SzAxTm95cWJpanNQMm1ZTlFZb1dG?=
 =?utf-8?B?SXJyV2pFS0JETCtHdzFacW5Id0loK0hrQ21HMDg5a0lmVSswT0pzVDNyS3RU?=
 =?utf-8?B?VjFiY2xBa0NkL2JZd25hYkJPN2RjT3JrckQxeXYycGo5bVNJWDhXN1BmeEN2?=
 =?utf-8?B?UTA3eEdtMyt1Ymo4NGFjVU1SUDY4WXNNaHJuaHdyUWNFWkU2MHJVeUVnd0Vx?=
 =?utf-8?B?bHdBaHdmNkVzM3gweForZm5FczExVWpMWmZzcnhPeXg1eU5tWWJjN3dSTVJy?=
 =?utf-8?B?SXZ2ZDdSSTlWSjdGa0tVSzRKZ3FnQVgxOUl3UzdnUW1Ja0NnUEdYamdUcGds?=
 =?utf-8?B?dHN2VUcwbWFPZnhzTUJwMVVWMVpEeVdHV1Vpd2lnR3REZE1NM2srcWpaeFJv?=
 =?utf-8?B?STNCMjB6MlRNTlBJTE5TajU2dkErNFZSQ0VOUlhBMXoyR0w1Q3cxeWtiR2ZV?=
 =?utf-8?B?bVBJUFFiWGJmbmRsUkkwc1NrRWlsMzVDQlRFWjNtRzAxbGhFaHcyWG81NGlQ?=
 =?utf-8?B?VXA1NU03eUtSUkNMb01PQzJDbzJYWVdJcmxGUjBPcHNUV284cGFuZldVL25a?=
 =?utf-8?B?R0YvYUNrcXV4bHRWQjRTYlVCVW5sK0tqeFd4THNtbWRNZVdTVlVoVGErenVT?=
 =?utf-8?B?YUx6NXhGRDBjd1pOYnRqVzF4SHdpdWlXbmhSQ25JdTYwRUlxRVZRVjgvRGY3?=
 =?utf-8?B?alFKZmxvaFJUUkNpbk94dHdYakNrRXgrTGdlNWFENlUvY0hpL1E4bEplelZN?=
 =?utf-8?B?NWdxbVl4RUpXN1RUMzV6cHk2UWZ4VW5tZmhKSGoxN2NkL0pMQzMwd2JmYUtN?=
 =?utf-8?B?MzZNWDl3Rkp0em5QWXo1ZlQ2dEg4Z3JQNWVqOXE3bXQ5dlRUY1l1SVpkS25u?=
 =?utf-8?B?TDhPVUJGUDFjUGg5d1lVVEtpcFZDQnJHN2lMNDY0TzZiYVd0R2pGSnFpL3k1?=
 =?utf-8?B?alRFRlRIcE1oRTdESnlRUlBVc1VBZUM2c2QwKzZ6RGx1MzdiU2dyWVVVTFBB?=
 =?utf-8?B?dkNFNmFkcG1RSzVycmN5ZVgyUDBtQTlGV1IyMlkwV2dlUUpJeUNjYVl4UWt2?=
 =?utf-8?B?OXdXM3dqTlVNelYyL2M5Qy9sSmZITHB5SlNGKzRIcjVXS0NaTTArREhmd3p3?=
 =?utf-8?B?UDJMTHJ4Q1VLam9yb1Z3WVVyTXlCZUJXNUhxTWlxNUJTRzk2N0U4bnNldUYr?=
 =?utf-8?B?Z0Vpc3pVWVc1Yk9VZHBLMnBJZ1dRYjJROVpoVTdpZEFBbnpzOHFtRlRPSGhx?=
 =?utf-8?B?anFvMGF5dngrNHVUWThXbld5MTBYUkw2NEtpK0g5Yk5VdXFXNjlXdUJ2WU5V?=
 =?utf-8?B?a3hTUFpSUWIyci9nVzlMNm91T1ZwSjMxeURiZDJYMnNsd29HNlkrelZVWTZ0?=
 =?utf-8?B?Y0E9PQ==?=
Content-ID: <23C073344A036B4FA2007ACED7469566@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O1VFVETuYV91OIvj0k9fuwNXq1eKF43UW9AZ4gbHDbe5KnuLNQHHmlI23zkTMeseA2wqQx4QJ4WZLo/ljWv+Cr8g6Nihb47cY9qM5zFWQwgHyivQGQjB67/0UCnUEGSlup61UyKWwJi9n4uJGFD0oSNykdo85puhnhYNpddKHEIbxGXNoP3RylUldU7nr0NMOytCMzCUusDHSa2vJpiUA+Uy0F2s59pffFyUKZWNsjsbNuzwUCA61TjbKcBWMKb3pRSUNaaXUXemjoG+CuhLFTzfoWHql+8KJikNAlgnqAFnV6DKU3WsedmSfO69d1I5LH5iei2bxuH60sD5UJvYwCkd0j/gm2iWurgwiJVWP5Edv/1sFR9rtNGyOM2bzURXuF/oQxm6h3GaLcnyxpXgA5bi+FrQUk8vZqBp43jPAXPTdXkAEKHY3Cp6esA+bvbws7DzoWHP9x1mqJROVo4cPu8fsd9e/mcAEeNqg5x0yz9b8zQfZDQaocTz10lYsh7G13WI6gD55LGL8/SD/m5pyp0E8hCMdht550h3so5QvNxo+DyfvjJkuI947hesEFUAs+QIDL12+Gw4W4Fmp6b1XrEdzWftMEDJtjJQkk1L5jcPOiOsaBbKMxlG8ukb9OBl
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1584.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9859032-bd72-4994-5485-08dc38355eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 08:15:05.3196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THX4+mJOGjjLj+7v3wVzYvvl9zdR/k3eqINvnJ68tuAGs+IvMKnu2xpRn8pbZlOnXA3/NniU46h6e34PrwB7lXKjJ2O9Zi873QahbXTHkH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6185
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 6/7] syscalls/swapon03: Simply this case
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
From: "Yang Xu \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Yang Xu \(Fujitsu\)" <xuyang2018.jy@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

> Hi Yang Xu,
> 
>> By moving swapfile create stage from verify_swaopon and
>> test EPERM error more accurate. Also use glibc wrapper by
>> using swapon/swapoff instead of call syscall number directly
>> because glibc/musl/binoic also support them since long time ago.
> s/binoic/bionic/
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for your nice review. Sorry, when your review v4 patch, I don't 
solve all comment in v5. So I did it in my own ltp fork branch named as 
v5_max_swapfiles[1](such as swapfiles => swap file, snprint return 
value, else branch....).

ps: Only the 6th patch was modified, other patches aren't modified. If 
you see no problem, I plan to merge this patchset today.

[1]https://github.com/xuyang0410/ltp/commits/v5_max_swapfiles/

Best Regards
Yang Xu
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
