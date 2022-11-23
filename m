Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FC0C4332F
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 11:16:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5AFF3CCA05
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 12:16:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE5603C00D1
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 12:16:14 +0100 (CET)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CD791140026A
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 12:16:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1669202174; x=1700738174;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=M5XozoHIBp+BpKexD6u+zIwg42DbINKNs/VxQlEjTlQ=;
 b=eAEU4/O+zHtd/wyot+6q+6BKSkTw8aBXS8ATF0MUpw6Gq4BCL25PDC0c
 WSqQdKFmRFh5B9eDHGjbVPDSN71fCLt9VPx1YgWWHJeI9g/Fe6UXwKfqE
 qtVDBT4JZiOjhFBqfHIT4nUakSq26NLBf+STCdjHsUVS+FY9NxCywSL2c
 8rBgycLR1ow/rVGZJPeaMYafpVs15NqR2CrPgTMaJXLoRoScfEZCoU0hT
 4+VmhzxB9E93v4FZaD6M2vecryctjJfgUs5BkVuNWW78ekriYkuOSkBP6
 AaeRgN3iLIvNzejRJTabxEK9Hx3Acr4SljoNLpc6LM3yUiZufG3rx+Q5I Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="70760423"
X-IronPort-AV: E=Sophos;i="5.96,187,1665414000"; d="scan'208";a="70760423"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2022 20:16:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdSClXOJhVGRH5A26CuWpKcUhgXfbsnqTUyM1Il+khnPH/+/481suqt1e+vvu0UMdqcubyU0UmbboABLiPx7D5y3abhXBQ85evrENMsUDXLJ3ygPUbMQuLGOovVnnPB3uLCXduAe2RHmsFbf858gpKV2XCbbIEiujm/iGv4jAPkFsKarJeLpkxEOnXjIuua4C6s8rjpg7zJ7JcKReBlREHIihyFZhOWnfypYdcPHzF83idCkb3UwT9WkUxp9GQQSIgBUrgXiWLejdI29J88loL1A4FRx3ACqPRtz0wQgU6pw/c7+t212KUIYihTNsKJBgCaV53J4Z5hRUNmtX1ynew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5XozoHIBp+BpKexD6u+zIwg42DbINKNs/VxQlEjTlQ=;
 b=nmLlZK/YYCKKpxvWew++QDVl17P8MbgJTyb/PK12IDypoYJ719EMcvquemLZnYgtMDe1Eg2Oa5ipQEWNgWE6qPa89z4kp2ZJscL7Hdpr666w4+CIbztE9zFwHUZH9SIHSaPuAGzvbgd7nTZDWFtlLHFjWVYsYiWLoGp/sN4NODr6b+LalaXGx2f8LobgY7SeUgSD8c2lk6AEH2aUbEpd/edc1dRoAUDl4VJ5Ciad5CIuPS0YOphCOjch+th4Vc+AJA7OBElx69UMUQe8AEsY0Uwkh852RK3bzQXdd3xSsgILsE/JixduP9gLPdQWgCc/qD8IyTTjIg6CYH4krLqNsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OS3PR01MB9832.jpnprd01.prod.outlook.com (2603:1096:604:1ea::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Wed, 23 Nov
 2022 11:16:07 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5%6]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 11:16:07 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: He Zhe <zhe.he@windriver.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v3] syscalls/prctl04: Fix false positive report
 when SECCOMP_MODE_FILTER is not supported
Thread-Index: AQHY/koeuMep6QKnJkOD79eDGBLTY65MEBIAgAAKvICAADkxgIAAGnWA
Date: Wed, 23 Nov 2022 11:16:07 +0000
Message-ID: <2fbf3f1d-1d9f-6331-35e4-b5f42e303ef4@fujitsu.com>
References: <20221122081142.2433326-1-zhe.he@windriver.com>
 <9ab63923-591d-f6ac-ffc1-d70ed179415a@fujitsu.com>
 <564adcee-1f16-00ce-02e6-f8d64688d869@fujitsu.com>
 <1e8d5914-ccf9-e309-27e2-e9644b58f4b5@windriver.com>
In-Reply-To: <1e8d5914-ccf9-e309-27e2-e9644b58f4b5@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OS3PR01MB9832:EE_
x-ms-office365-filtering-correlation-id: c7c1b3d3-c864-4943-589d-08dacd441e70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TWBBTCkx8Qw9YUvI6mQKWeF68FPUpgB0Phx7Mg4FNxcr1rLUCD1CNLhsUZXhNnmefDQljkMjInGH1xmwjfKv1i/gjApywpW9LSsqha393tl0B7RoKOVw6wbp7Ojf+9OH+78Svw9T+4zwQysi3HBrUaO57a0cLiTkKSaDIc9lgLcEsI8f+nWv1CxovHHNaVu7VTftSvjdl2QxNYWRjbvxNTPlSRZ4nkpowC9IBSkZC6w8hFySIuSAMsTEBY/IcTp/Zc4qLWI0hDPrUU/y+Iuuo+tSsXraG5yNIkfJjyX6TOiy3knT2yWPuvV1oXEOehtDOaX/apZx/I0DU20Qt9OTZ76bNB5mV/0lBhzC5x+Da5/lqgbUGIM7xzp4y5mPBRfCn+8dcBZGVqmTwU8wWjinRo/l0OVHlcnuRuAD/HvPGno5NurLdt7+n8AN71avkXvrOGSgNNN+omOyiHLCGp/WMr4wQiieNlHCLO6oAI+LKhsDzUPE0aBsU/CPwRewGF+NQ8WtRN5TL9sCMKM+Bgc+P8gRUH/S7jNIoLX6M0paiiOBLA3YdhaZZF/4k0c9B2STlNaxT9zDCeB04q1Grl9N4PqukccHYa2MkjVGBmYlS/gMmQ2nYWWUoORPllib6k8WdYoWfEvY4u0VEmQ1oQIqL2xsb5ayleMipxVOotgwteGE8NXXbBsWLF3VUF8ZvEiLWkGaZ6nbXJxWtuuVwR1LM3+1tnyIGMbjteK4uhJoX0cZpecBkGJBUK9S6/ylh5Gqqdk4iCT6gGUGBXRVQst6WEv6265nFmaWuaNy90lad8yU8P8um4KkRwe5xNy8NjKTHGsv0/omW4OpQvINz3R7lw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(1590799012)(451199015)(5660300002)(85182001)(2616005)(8936002)(186003)(36756003)(316002)(26005)(8676002)(41300700001)(38070700005)(6512007)(76116006)(66946007)(66556008)(66446008)(64756008)(66476007)(91956017)(38100700002)(82960400001)(86362001)(122000001)(2906002)(83380400001)(31696002)(6506007)(478600001)(1580799009)(6486002)(966005)(71200400001)(110136005)(53546011)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEIyb09UbDZNOHl2ZmtDaVIwQWx3bzI2Z1FvaEpydWl0NENVaUhWSk5jWTRR?=
 =?utf-8?B?bzZ2L25uaUVaL1pLSE8vbHVBMGdVbjc0TnYrZnpwQnpPUVl4UDZkUHF0MFBD?=
 =?utf-8?B?SG0ySXkrd0M1d0dBWWtlelhjWXJYclJzUkQydFNkWkFiZzhmdjQ1Ris5TSsx?=
 =?utf-8?B?YllMRGlBNDZNSGlJZHl6Zm9rbFc5cGVZWTBEYXNncG9OR2RLZUFRNndKdTV6?=
 =?utf-8?B?aVVNd0ZGREhoNFNmR09pWlZERHROYWZsR2loazYwMEgwL3NjbEI1eDYyTDcw?=
 =?utf-8?B?SldrNUNGUVE1MUs4Y0x6Sm80cnYzU01KQksyQzdpRjNIaWZEQjNDNnZvZGJ2?=
 =?utf-8?B?b3hETEs3WUt3NkczQTBWSkVWQTBnSWtLeitESjYvVDhhcTRHODJmQnRQQm5M?=
 =?utf-8?B?dUVCL0ZmbE5WSTcrendvdzRLZnRRUHptbjUxajAxYys1WE1uT1QvaDJnaGtP?=
 =?utf-8?B?TmcxSjZ5elBEQnZuS0wwWkJzMHZlWWFYOUlXZmh5WlUwaHNBYWw5L3JWcy9B?=
 =?utf-8?B?blNKRUJ4T2ZwRE1FUStQSTVSRkEwWU1XUWdDMUhRT0lPam1oWGdZR0paa2Np?=
 =?utf-8?B?QUNJL3hsTCs3TzRVeWJ3bVgvaFlCVXY1UmE3QWJadkJpdDRrMkN6UlFMNFk4?=
 =?utf-8?B?N3NuYkM1Q1VISTlKSHBBM3J2aTVFMDE4aWpXY1BENC92V3czSGsxcmUwVURW?=
 =?utf-8?B?NlVEMkZLVTNobWVqZWtWTVRwb0NkeEY2UFl6VDd0MGl1MVFkTkRkNXVwUlJQ?=
 =?utf-8?B?NjV0Y2FNMDdXdko1cytUNXI3MkdQRWllM1VHd3p2OEZuODVscFF3NjJHcVRi?=
 =?utf-8?B?UmpKMFk1MTVrYldrcWNNOFlUZHU2WGJuRzhvRWo3VFBGNEJQdjZjRHhjdEV0?=
 =?utf-8?B?YksybE1ZNjROSXJsdXVDc3RPYi8vU09zQmp3MjRHR1lYVDNHT0ZSUkY5emxF?=
 =?utf-8?B?MUcyM3pzUHM3a3htbUsxVk9XdURUcWtudEJ1UDNSa0liSDltdlp6VEdodDYx?=
 =?utf-8?B?L3Zxb2Q0aXA0RHduem1OWURjZlV4TGQzZVFwYWRNTmtMT3poQm12alVtL1NQ?=
 =?utf-8?B?RUhvS0pHeFFkRzNDL3NxbVdpc3AxaGRLVzFsVTdZSDRaZ29hUk1sU0Z3enVE?=
 =?utf-8?B?VGxrZ0JMUGRScFhnT3BrSlVwbHlSS2FpWW1QQktkc1VMTk9WSWxqeFUyTjdz?=
 =?utf-8?B?OUZSQXYrMnBWTUJiYWZoeURXZGhHUG1BRVZnakhJUDZjOCtnVitBcVptUGo0?=
 =?utf-8?B?U2RuM3FPT3hjSFdBUWUvcHZxcXEvWC9XcEhEdnd6ZmJhZW9vVHJYQ0dNSnZL?=
 =?utf-8?B?b0Y0T1Fuak16UUQ3K2g5TlJyKy9QQ0diVVN3YXRhYXJJcGtVeVJaUXU0Mm1m?=
 =?utf-8?B?S1QwTU1Ed1RmRXpwRjlXV25uMmw2UDY5T2xONUZwVHczMjMvdjJOTkQ4dUV0?=
 =?utf-8?B?MG1Ib3VqemxhSisxSmNLOW5YcDhNS3hYem02STYxTnBreEQ4T1cwMHR3VDNr?=
 =?utf-8?B?TFZ3YTA5MWI3Ni92TG1KdTRVYjNRKytRcnhVdWhyOE1xOXdjV3hGWEE3NEk5?=
 =?utf-8?B?SmRHTDd6dDRiS3R2amx3Q3BNL1BIOUtsTEFVZTV1aW5aRVFtRzhDbXRmL2w3?=
 =?utf-8?B?cWhaTXZsbGdIaWl3RXNsVmVBYkdoNVNhNjdGM3h4bmlSWUdQZkhZa1d3TTZB?=
 =?utf-8?B?RUYyeE52bWRtWDhROU5JSmtHSHFWUzhNb1hWb0JsN0NPbnNTUUJWR3RSYzFX?=
 =?utf-8?B?NTlFZEZOMk5QWnJObm1jaEM4V0dwNnRLeVdaUnR6a0tTZFM4K2JXYUxneG5i?=
 =?utf-8?B?RUpsS3JjYkw0bE5mWHpyd0NXblBKVXVlY3ZObC9VRVF1N21DUlhBVTdycXA2?=
 =?utf-8?B?QlJSaTNYRndxOXlGdmdRR1FJcDFvdmY1MGhaZ3dUN0QwY1BYeWpVZWVVQzZh?=
 =?utf-8?B?NkdkNitTOTdFRWhLdVdLaXNqa01zWTUvTzRkS0FTQ0FYeXMxdCt5ZElBdXFh?=
 =?utf-8?B?OHpMeUREb0pMMFRIaHZManErbVRYY1A1WVIrNVUzdmx5b0ZZSnA3bjVucVE4?=
 =?utf-8?B?UU5PR3l0N2dha3JjVXB4STFOYUx0ZTRpRFlBSG53NVNWZEEwUktpaVVQV1Va?=
 =?utf-8?B?NittcHF4d2lHV0hsNmpocEhzQmx0Q3YyWWNXOXpjbzkrbmdLcENsVjhrOFFu?=
 =?utf-8?B?TVE9PQ==?=
Content-ID: <B380C3A3D4759A499789040242806BD8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xIrZuqHxw11Bb9dA2neo89TW5uBeo3v1/DHMbC7R2EEdAhueWG1PGZ0xcbWfj0/KTDWOLhg4L0CqPcUTlj9CQXiqt+IK+iTDwqCzdK4xTnJnXtE6ISM62KoYQ/U9P10Kr3p9mWf9RH0rj9mXfjHKpCmEg2XVB1r1h5Un9zXk1OP9Eu4mQrL0buZdmH6k+nbEDxuL3TbUmlHgX+f7rayYmV78UvvI5VIQQRLki5+PRjD1JXXuE1JA9L2exqWIKuRTFTMxx3zLuOlI1hqOr2ca1lSOfxpj4bswZfuKvPLrEKTJwJ2GLIMbCdtC6iWzBcySXd6xssVWp6mP8jq3HLqduE2vExmrwhchaN4xIP+CMsd3no7hmFHxIDj4Y3Qwxdw1+44gIrCSwjj/MRslSW/dmRq0k7JMjq28zQ6OMCyhsk29X7qIeEgYhYkiDDCed8yR4P3hTHrdniOnO2wUYc0K/xfT2Y9ncoqRta16Jn+ZuT5F9g9xcg+vHUsM5qC2DaTlZsG+u0byb0uK30DfLBXH/y3LlXTOfdE4TnqC9c2kB78bU9QpAn/tZYmV+XSVqp7iZifbZWG7vKMVRJFqkdWCNp5dZwr5gBzQ+9NEzUuDmPmUnyhuD5EhULppmxBsBFxqxUF/2YiysMIo/4hDGlIXBJobw3Ys2rDWJwy2uewaoGEWwy812GF4lcD1m2QllNGmbRLUXRhItnKZXtiYwsMtOAe4ePGe/UOAV+tEL/mv8QP/u2giXLGmeij0NIksw9dDSNPGUYnWGEGKN+kYY8sxHgG6EDmZmYHx9Uj7v7x6dxlHoLU0hHaOKA9ydZYSRD96
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c1b3d3-c864-4943-589d-08dacd441e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 11:16:07.8183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHs9LBOhHATpwqksIORcc6yQwKsXl6ZehOWpebIzPvEYZtpsqLpYM/su6uk3Sj5rcmdrxIvhPTm2ca+GgT2rGOw9dmYbzGBbnnWf/7fW9vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9832
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/prctl04: Fix false positive report
 when SECCOMP_MODE_FILTER is not supported
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

Hi He
> 
> 
> On 11/23/22 14:17, xuyang2018.jy@fujitsu.com wrote:
>> Hi he
>>> Hi He
>>>
>>>> The child process really should not receive the expected siganl, SIGSYS, when
>>>> kernel doesn't support SECCOMP_MODE_FILTER.
>>> I still feel confused, so which subtestcase has problem since we have do
>>> check whether support SECCOMP_MODE_FILTER in check_filter_mode.
>>
>> It seems kernel without CONFIG_SECCOMP doesn't report errror when set
>> filter, so the previous check doesn't work.
> 
> kernel does report EINVAL as we can see 4 lines of "doesn't support",
> corresponding to 4 filter cases, in the commit log. But later verify_prctl
> doesn't realize it's not supported and gives a FAIL for not receiving the
> related signal. So we add mode_filter_not_supported to inform it.

yes.
> 
>>
>>>> This patch tests if SECCOMP_MODE_FILTER is supported in setup and adds a
>>>> variable to record it.
>>>>
>>>> Before this patch:
>>>> root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
>>>> tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
>>>> ---- snip ----
>>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>>> prctl04.c:204: TFAIL: SECCOMP_MODE_FILTER permits exit() unexpectedly
>>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>>>
>>>> After this patch:
>>>> root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
>>>> tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
>>>> ---- snip ----
>>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>>
>>> The line 154 and 204 is refer to origin case[1], so do you use the
>>> lastest ltp?
>>>
>>> [1]
>>> https://github.com/linux-test-project/ltp/commit/3ddc217d7b466f16782c257e29e18b251969edec#diff-6ae2f0e9ae152457424103cc20b7885e242f33f58b2e543b7941671f418d9485R154
>>>
>>> Best Regards
>>> Yang Xu
>>>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>>>> ---
>>>> v2: Add a variable to record the support status instead of exit(1)
>>>> v3: Move mode_filter_not_supported check a bit upper to save a prctl call
>>>>
>>>>     testcases/kernel/syscalls/prctl/prctl04.c | 30 +++++++++++++++++------
>>>>     1 file changed, 22 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
>>>> index b9f4c2a10..d3de4b0d6 100644
>>>> --- a/testcases/kernel/syscalls/prctl/prctl04.c
>>>> +++ b/testcases/kernel/syscalls/prctl/prctl04.c
>>>> @@ -93,6 +93,9 @@ static struct tcase {
>>>>     	"SECCOMP_MODE_FILTER doesn't permit exit()"}
>>>>     };
>>>>     
>>>> +
>>>> +static int mode_filter_not_supported;
>>>> +
>>>>     static void check_filter_mode_inherit(void)
>>>>     {
>>>>     	int childpid;
>>>> @@ -154,16 +157,17 @@ static void check_filter_mode(int val)
>>>>     {
>>>>     	int fd;
>>>>     
>>>> +	if (mode_filter_not_supported == 1) {
>>>> +		tst_res(TCONF, "kernel doesn't support SECCOMP_MODE_FILTER");
>>>> +		return;
>>>> +	}
>>>> +
>>>>     	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0666);
>>>>     
>>>>     	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &strict));
>>>>     	if (TST_RET == -1) {
>>>> -		if (TST_ERR == EINVAL)
>>>> -			tst_res(TCONF,
>>>> -				"kernel doesn't support SECCOMP_MODE_FILTER");
>>>> -		else
>>>> -			tst_res(TFAIL | TERRNO,
>>>> -				"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
>>>> +		tst_res(TFAIL | TERRNO,
>>>> +			"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
>>>>     		return;
>>>>     	}
>>>>     
>>>> @@ -208,7 +212,7 @@ static void verify_prctl(unsigned int n)
>>>>     			return;
>>>>     		}
>>>>     
>>>> -		if (tc->pass_flag == 2)
>>>> +		if (mode_filter_not_supported == 0 && tc->pass_flag == 2)
>> I prefer to use "tc->pass_flag == 2 && mode_filter_not_supported ==
>> 0"because only one case's pass_flag value is 2, so we don't need to run
>> the latter to many times when kernel without CONFIG_SECCOMP_FILTER.
> 
> I'm OK with this.
> 
>>
>>
>> with commit message fix and this fix,
> 
> What does "commit message fix" mean please?

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/prctl/prctl04.c#L154

Your commit message log use wrong line number,  prctl04.c line154 
doesn't print not supported info. Please use lastest ltp code to run.

Best Regards
Yang Xu
> 
> 
> Regards,
> Zhe
> 
>>
>> Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>
>>
>> ps:BTW, I think split this case into two cases by checking strict mode
>> and filter_mode is more clear ie prctl04_1.c prctl04_2.c, so we can add
>> these kernel checks by using tst_test struct's need_kconfig member.
>>
>> Best Regards
>> Yang Xu
>>>>     			tst_res(TFAIL,
>>>>     				"SECCOMP_MODE_FILTER permits exit() unexpectedly");
>>>>     	}
>>>> @@ -218,7 +222,17 @@ static void setup(void)
>>>>     {
>>>>     	TEST(prctl(PR_GET_SECCOMP));
>>>>     	if (TST_RET == 0) {
>>>> -		tst_res(TINFO, "kernel support PR_GET/SET_SECCOMP");
>>>> +		tst_res(TINFO, "kernel supports PR_GET/SET_SECCOMP");
>>>> +
>>>> +		TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, NULL));
>>>> +		if (TST_RET == -1)
>>>> +			if (TST_ERR == EINVAL) {
>>>> +				mode_filter_not_supported = 1;
>>>> +				return;
>>>> +			}
>>>> +
>>>> +		tst_res(TINFO, "kernel supports SECCOMP_MODE_FILTER");
>>>> +
>>>>     		return;
>>>>     	}
>>>>     
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
