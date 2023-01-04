Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E6CC4708D
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 04:59:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86F023CE0BB
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 05:59:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6EB93C2953
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 05:59:10 +0100 (CET)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 38BD21A0036B
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 05:59:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1672808350; x=1704344350;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=NCFqI1UVLQO80JSV/lM7nFyXE100nBWVT8E4Wq9MdNk=;
 b=Iqq5DlUDuHv5Q3N1yD0nIqM3phtijxPawCm8K5gMbuyTQCiTrbEbjXUO
 6svsHwzHTUXUkVqbBGImFJj0yVYoZG6br8QIvvoTEPrX+rshbpVBrfuTH
 nv4MHag0qgufhjUhtpy2zzjP/A55CYTTY0goFZbH9gJR90B2tGrbTXDku
 Psuqf5iwXGNGkyW4Do/XOaAXwy+UVeeIEKW88ghEHJ+kWfwRyHF691jFY
 Z3+iaju098lKbfUsEkvMpsGWORO/KBQ1jN/kna7M51rNjb6tqPINN94OF
 k95adHce/5i74GapTPjMqioTEeyIvsUYYHESWRZECgs1ojoYXmtRCehaO Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="73833220"
X-IronPort-AV: E=Sophos;i="5.96,297,1665414000"; d="scan'208";a="73833220"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2023 13:59:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhZ2/7EMD4KAFd9FStBJ+KiPhwUOi94IXaSkY0HX7lNofTn5obukC0hKd34TihW735AoA6V1/HYncVGcmZvfFfQ6T1gL3fm05E8uPVVEr1dK8x6Zg0gaYy+DNCob3GYG0rLbnHaoyvAX7o+TZj8kABR4l8qYM8fqj40x9kA1Gdie+aHp9Fy/UVYmhYBOjD4jDw9rb0GHZTpkpfiQJ+iUDSsMcBd0PEAUw2p0FcbxJ82ETkALRG8TDkuC5jVUK+m794S5RQlRgUkH6hv1vqVqltiVYJqRUDNWm+AHb22ufWyjk2kJqXkv36iBpNc+hIk88s5SfOeA77YPkU4kj+9msw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCFqI1UVLQO80JSV/lM7nFyXE100nBWVT8E4Wq9MdNk=;
 b=VbR9tt+6LBwLAVJa/rUMVch7aAeOM14KT5azcSnDb+P1fC/+M8tUmVmZ+7xXHirg91Gtm6xi8auoYO8zkpDETwARaYSkbc/VOFqwsQrMrLqfV6H3PBOEdgpiF0nm5LLnvVw1J8OJDQpzf2PugN9V/Vhn6D59QCPwaBoJATNeWW6QmUJNsz+yphIjR1bFblCq0tCtAJv58qpF7thi3ko5MquHoOlrq2QPqDIoPFSljCSTKld2brwy0ehfOvVfmaEO+bs34nV4NgvpRNpOngMnixZmyP8+fAlgJ7HXse84dpOH7530Pn/8lyJ4gfAyAFf+Sfv/ZNt0n4K5eAPSBx5Yig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OSZPR01MB8275.jpnprd01.prod.outlook.com (2603:1096:604:182::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 04:59:04 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 04:59:04 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH 1/3] shell: Remove old kernel version check below
 3.10
Thread-Index: AQHZGcv5/MLYrMMoeEGuFUDAjeBWT66K5/gAgAIifQCAAMV/AA==
Date: Wed, 4 Jan 2023 04:59:04 +0000
Message-ID: <3f29c705-e803-919f-3e36-6802f7f6879a@fujitsu.com>
References: <1672132813-26636-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y7KlxBSIvN3q576G@pevik> <Y7RwMvU1+QUPbz59@pevik>
In-Reply-To: <Y7RwMvU1+QUPbz59@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OSZPR01MB8275:EE_
x-ms-office365-filtering-correlation-id: b7afe6c8-452a-46c1-f4b8-08daee1066f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N1Ly6rpaQDMGgMGRaz9S9q59IkEkNgSOoeSNFDhhHnPDRdblYNjfJkex6EukImq8iCi/Ojyx3ZG4Rxa5TUGnHZRLdms7758fAKIVCo/jw5zV1BNHNuIn/UXhBkKZdupXJgiG6ykrDGjnQurxV1am6ZgBjyU5RLmd6j96fZCauo2GfGTvM99MaF7QBfLXCgOiTIu7ZMlgD6x7/qFZEFD/GhLf+zalE3TcLiN4gjmJo1P6A5kKR4UdCtP7XUgxqtTGQEmN/clTM6cHGYkRTpMDTSCio+iIvPJxoL+uVPcTNtfWLti/LMSfp9n05VwZ9ivF9DMKaSPbdUBoOHcp7n1SXoxu5YuGPSX2DSXUk/yvche+i3PrJ/p9DMqw4cNaOBRZbfXxLJzanzjSYfbmZd73PRR+BnMy+UuxYxRS0+ZFzBMi8UmNfIfSBm9cNtNgY4bzWCalTOq2GyzsVROpL9bkflmpZk5nHXgJ4nFUnEXeRgWk8+CZ7c28nmWB8A71rIWpK9TrzSSKAcvbLnbXyO+HgjLgqKgrlxuWSOwaLV3vLacgW46CjJ6ggmbdmw0g3OBMTMZtB94L/eWeUIxPNraWvXP0jQrfuLfrXL4q7RGN76DNVfI7IumoCkghd8Mxd6vT7sSnn74Ev3iz0Qn6G889dvefkij8Ruj67J4EVoKBLiS0kUsWckcMvXvVNlZ3CBwIGe83qN8SEC9FvGRd698v5F8nAnv9i/9Qf8zKFE4cI79ujhHjzk5QlO4TgQHBI4ZCKY0xAsyxfVNEP1rnP6GbgA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(1590799012)(451199015)(6512007)(26005)(186003)(71200400001)(91956017)(31686004)(2616005)(6506007)(6486002)(478600001)(110136005)(66446008)(66556008)(66946007)(8676002)(76116006)(8936002)(41300700001)(64756008)(66476007)(4744005)(5660300002)(2906002)(38100700002)(122000001)(82960400001)(38070700005)(1580799009)(31696002)(86362001)(316002)(85182001)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1lvQlJsMUhFbHdINlI5VHNaTHJuaG1NUWJ6R2psREM5VlBIQUFWZ2c4M3Jr?=
 =?utf-8?B?YllEK0hvOWtxbnhFT1dDNm5MekM4Mlh3dDdCRmxhMzJrMVZ4dzFJd28xWi9S?=
 =?utf-8?B?YlJhS1dHOERQUWpGcEpVUVg1ZUdJcGtaQkJMZktMWFNLcFhIS1kvQ2xRWXNi?=
 =?utf-8?B?MmZ2S2hJWkNoRlN6M3lZWXFxUnlUSWRaK0x0M2JYdXVJUG90WlllVWd4S3ZW?=
 =?utf-8?B?YU0yN2NObzc1ZTFPeHRwTU9sNXh6T0hyMU5CeUpwM0FBUlF3NFV6eXVxZVNV?=
 =?utf-8?B?U1ZsMWh4ZXlCREVnVS9PcHNvSVUyM2t2ckVYa2VsZ0JhSExvWTdSVGFTaWhS?=
 =?utf-8?B?aDRjaDAxbUZmNkVKM0tma1RnTUhiU0E1TVZyZGE1QVNGM05rMk9ZR2tpOCtH?=
 =?utf-8?B?Mm1MR2MvRGJ5R2lvMk1JdmVIaHZCbFhWSkZGSzBlb3UveFVwRTlFcGtpaElQ?=
 =?utf-8?B?ckFpbC9YZ2o3KzJ5U3AvV0dyVWowK3FvQzVIY0dVakpwRlZwclBaV0x4Yi96?=
 =?utf-8?B?NEsrNy96NGtERlFEV2huK290elRWVVpPa3FPeW0yRUtHeFBkTXViaWJXL2k5?=
 =?utf-8?B?dWk4RDNSMm5IdXZCbWorQzU2OG01Vm1QOTdnWXFTL280clNKWlRCOVR3NGtw?=
 =?utf-8?B?a1Mxdm1HVHpDM2QxUWZlZzRrVXZqOXpUc2FQUlhEbTRKeWxNcnhqZUhuSGI4?=
 =?utf-8?B?M0I5RGdhdG11cE1iQk4xbUNJSzUzYXYwVC9RNXhGcTB1QkdGWlRzc1pYY3VE?=
 =?utf-8?B?NCtPTml3YkhVbHVQbStpd0Q1bWtqdHZIb25QRzFQbTNRUWpBYVF0WjU2VStj?=
 =?utf-8?B?ellNY2pTY1dKZnFrVW1FS2llWUxyYjd2OEM1SDgwV3NDUDhYRENLVjhicVgx?=
 =?utf-8?B?azEzeDZBM2lmZFFNTTRPenNqS214UDdnQlkwbld3RUVTK2FjRDRmaHV6bWtQ?=
 =?utf-8?B?ZTRUUFZCcjU3RDMrMkQ5L3BVdWMreTNIbGFDUVE4c2xmMFhXcldYQ0UyeGw3?=
 =?utf-8?B?aC9taVM3dmhQcFdpL2JidVdmTU93dlE5SFgrK2Rlam5sL3ppUEt0MmRKSC9O?=
 =?utf-8?B?aHg0ZGhZdTR6N2w5UWFjdzFoeUNrSTQvUUNjUTg0eHhKbDRlZ1pNZUVSQ0NU?=
 =?utf-8?B?ZWc3bjBxeXNWbWkyc2ZIQVpFaFlqRnoyUkd5MjNIM0ErSCtVNEpLOFdQb2k5?=
 =?utf-8?B?ZU9kK3kzcnFlS2YvYjdNcHY2ZzNFSnJaT3IvMWNqZW9qdFpwTTlrZmpJeWhB?=
 =?utf-8?B?dUFOMjBzcVFnUlEyTWFkYXFrdVJvbDlPNHNoM00vZHlRaGFqbnVLTEwyTFJy?=
 =?utf-8?B?OFF0USs4c1ZrUVlpbExBNzdLeW9kR0RkTlIxUjN0bUdHeXRPZXR1cU1jclhF?=
 =?utf-8?B?dGlTNXdvVDdPcVZ5OGFsNGJUczhodUJqOXN3V01TSVp3RDZwd3o5a2R3bi9M?=
 =?utf-8?B?QStjeVZPZlNSOWtlOGx6enhwS2dLN25zZzJ1VHJzU0tNL1BVYyswVWJaVjVL?=
 =?utf-8?B?WFRoODJKZ09sVHBNMFF4ckZTRTdWM3VZbzlNZ2NEQXYzWG1xQmVYSHNXNVlV?=
 =?utf-8?B?UHpScjZ1WU5pZmtGV3p5d1F6SXA5T2RHeWdpbm53dzBwQlA5RWZzbFdtanlz?=
 =?utf-8?B?QVprT203eW92NllPZ0M2RWhobnFiazJaT013VmJxTDg2UFRnNUpjVEVvZHln?=
 =?utf-8?B?TWdHRWI1dzMwVE1jcXlnekZ0MUZXdjkxeUZkajVEYVlMWXhqUG41QVFzdW5o?=
 =?utf-8?B?NUpVR2RlWldyUmNSU0VQaDk2Q3dzRktmY3RCdGFBYlkwcXRmLys3YTJ4ekM1?=
 =?utf-8?B?OUQrM1ZobEFpTkt0cDJFeWcwTFpvUlpudjdONW5jWDMvTDFaRHZ2YmxuY1dz?=
 =?utf-8?B?VTVRT3hyVFF3VUdPT3RjNFRCdzBwNVQyT3hlV0UyZDduWkE2ejBIblhrK05a?=
 =?utf-8?B?VFlTVy9XWTdtaTFmZFVhdkxHN0JHSE02L2hHbFZtcEppRGVTd3V3MUVwVmNw?=
 =?utf-8?B?bXNLU0NQM3BOREtjNU9zQ1p6ZU5idk5DdkJNcW1mZ2pwWGhRMG9KWVlBMUx0?=
 =?utf-8?B?ajg2dXh1anF5eGh4Q0dMRTFudC9FQVYzaGtwNnlvNXlleGd3dGJDZXJQdG0r?=
 =?utf-8?B?Y1pjMTllNHc5R1I4NGhoQkxsWDZlQUEyVkpuM054emRZRnJvOHU1QWljN2Vr?=
 =?utf-8?B?L2c9PQ==?=
Content-ID: <BE915826B7A3B646B587829D898FA77D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ii6NAUwxleaCdrUuDy9UN+EjHE0dGEAWb2PWNL0zXA0K68G2tFvpXIqBxvthP6ZxL8NtyvA2g/NEuaxh3LwXTChggxLZTwLna70d6C3ijJgybFOY3TNb+8DqhXE77sKo4qrh0aQtKS/ni47TRT3Pe/OJSLhA+YwYF0dvTlK+CgeIB9hWlNAvnlQxtrIvLKdgXrnD9npK3mB3BwUHy3Vja+eic3FSpgdh/Y/phTOHcYhlCMD5p4oXFniyDily6UYgvYVyoFeehjU4oHoFw6+O8xqK3EtChRpQxhr6x7/BpnUS2tj9a8PvuEUxaDwI2hJmFPfACOydPYUtGjrMux6Nh0PVygDT8fJ3yzOAmt6DHZswP2slrNvqZpZ9XP9b6xsiCvQxUiYEcqjIxDtQFBsMTPl2MkM0g7meVEgmuAitEWkRpnk4NnAaitVRQljMQ9OoQhnuUrHiI9cnAgcgCQuAmkJ0wbAQ5O9oEy8O0Qdl0SblPnoXEXp1J0tRzB/PK6q6exkCraU/XBnnjTFi+5JwrrEq5fNUQ8teZtv7YNSwOiQc6kOs6s7T1nw8bZxnXAq2X5pgb/VCeUvqySRFU+FzjPs082l0+j1V78TFLl5nKl3pDOVJOd0hzYuZPHr4xrFy1v6aqDHPPdBk3K+owILweshMnn8wXUP5Q3mgx2w/bVhDuGaINF4D4B948oRxJSwsgHLxVdxstdMvdJdJ9oNifLw+sxnj8GyNUJASq4LquvC/u+rCPCQ66C0ghbBpsXUDsnnJGI+q46fKOptm8QqTZ3JREuav6mX/+fvXaD2J/xg=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7afe6c8-452a-46c1-f4b8-08daee1066f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 04:59:04.0472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmRqAhc0UgT163Wzot9jS8vSqqSGAdHf10jjCMrb73xpA0TKmGti3quA/4al3LSQ7eETPgnX/BM27l1hsG7t2C5NjXnSUl33XpMdGyL7oCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8275
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] shell: Remove old kernel version check below
 3.10
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

Hi Petr

> Hi Xu,
> 
> ...
>> This evaluates to FLAG_PREFIX=
>> => please remove the variable as it's always empty
> 
>>>   		/bin/echo "$FLAGS_SET" | while read -r FLAG_LINE ; do
>>>   			/bin/echo -n "$FLAG_LINE" \
>>>   				| awk -v prf="$FLAG_PREFIX" -F " |:" \
>> change to:
>>    				| awk -v prf= -F " |:" \
> 
> FYI I suggested:
>   
>>    				| awk -v prf= -F " |:" \
> 
> But you added: prf=-F (no space between =), which broke cleanup.

Yes, sorry for this.
> 
> Fixed in af98698067.
> 
> And yes, prf variable is not needed at all, I'll try to find time to cleanup
> dynamic_debug01.sh.

Thanks for your fix.

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
>> NOTE: I'm going to cleanup the test after you merge (/bin/echo + variables).
> 
>> With these changes:
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
>> Kind regards,
>> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
