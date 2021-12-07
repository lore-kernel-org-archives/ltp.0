Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE0DC433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 01:20:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 109FE3C2310
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 02:20:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B988E3C0551
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 02:20:33 +0100 (CET)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 00C186009FE
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 02:20:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638840032; x=1670376032;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7HnbWhbwJXWbUf6aUVLUX0yFmWVFnx8Qa8AoH+a6D20=;
 b=h9v74LRSe7KQ1zkFYCuD8orH/ikIppQO6hCbFuav1rQHI7RnwgWreS8a
 VXiYk91ljnAX4yNkCkB0LCCuK23W/nx26t8HBcANUR30KTNjj0c3swBpv
 EI1cmLqGILDCfgnoltLWC9XrQpzfSgwSt1IbSJbIP0XBDI2zjbLwBVpwl
 5T9guVTOjbGvlxDeftmszgn2LPVP0C2QZCihplyWgHLp6iLxSQXNWMIuu
 X8sGCAeVmWmyJIJif1xJQtvZ14d47GRypzVvzgGmOBMc1LwB6Xp6Fjq46
 x5z5MCDINn6VVLCSFSYr90ojLsdNSd/T3DxOZ0pn6jvG4wLuRxhj8eUD7 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="45258605"
X-IronPort-AV: E=Sophos;i="5.87,293,1631545200"; d="scan'208";a="45258605"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2021 10:20:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud3pD1+tTf0YVCaPtcBTsRN1gqr93oLIraG0W0CE9dW7V/m86bTbgmn30bVlS3aYUyvRNQ9dvAlGmF22oqaQns+g2AWJ/QuC4WfNoGpxrcLDIYzpKzfFhSOtDbiVcBeQMnJPvqT9cKMdKJsX0Qtd60Z2hNYg0SJ37/g/OAr8knqs40TIyvZSmBpT9tuDbqYF3pzlZwJYMr8V11VmSorYpixPnnIHDG20LgoRogmLfaPcKuasLUlaXjRMHekjiqV5reqCm/V3q3/+1bt9HKPYL+yC6+uIvlfKjQqp/Oia7WZ4Mn/o0+CoKbVHJh/ZsuKFB7geJ+TXQ37LwfCFJaE9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HnbWhbwJXWbUf6aUVLUX0yFmWVFnx8Qa8AoH+a6D20=;
 b=EywkptgTrGrFvk3Nb71OhrologNgZlJy57n6Kj1zZKUpu9MUlngxMTgHOYTKsOuF1Q45XG4jUdnrYwxSyHkIO2OzeJ/gBIeBtnQzEnsRRk8sWrFxK+fhXPrsXrBB87ubtRQgkiKfZoT6Vng9dPKFKLMaOar19bZAXU35jCf4fy9mA+Z6VPOVS7F9zPSQiERNlzN9BYcn1Ggbpwfx8TwcX5HOLWGN1JjrpYCiclNgqnXh1kPS1XjJHBuE3Vf5x3Imjk04bwPfRVWtTEKmmbpVV84cmVzvF8VtloZGJiPoWJ3ox7/7+DWNtvvZyp7OaxWANf0yuz3p7OVPwaZNtVc6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HnbWhbwJXWbUf6aUVLUX0yFmWVFnx8Qa8AoH+a6D20=;
 b=OoGAosQc496H97HtYX8UR2ZJW8ipue2XAHAAHCyO3SnMDYkXHhk3yRA094nZeBGwltLmZCefp7ZSz4RVP+B6bTFb+iVX7zlJclLeGIoAH15R0T2H2V7PCC7hAh+zrRuAg4AFPiviH9HXsE+etXliz88AJkyKIt0rtG3YpxUuVck=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4571.jpnprd01.prod.outlook.com (2603:1096:404:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 01:20:26 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 01:20:26 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 1/2] lib: add cmd parse handler in needs_cmd
Thread-Index: AQHX5oiKqJXVA4/baEa0i3fiPil8DKwlblOAgADV/AA=
Date: Tue, 7 Dec 2021 01:20:26 +0000
Message-ID: <61AEB6FA.10102@fujitsu.com>
References: <1638345208-2186-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ya4DeVrCa1X8IFjk@yuki>
In-Reply-To: <Ya4DeVrCa1X8IFjk@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f530aa4-51f8-475d-390f-08d9b91fbffe
x-ms-traffictypediagnostic: TY2PR01MB4571:EE_
x-microsoft-antispam-prvs: <TY2PR01MB45717DC02E37D8222CD43470FD6E9@TY2PR01MB4571.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oux4P6t80FhygTDvZv5QJ6Z3BQ1PLJx86bpeVgfdPR0l8kf5MPJ2Gr9cqHIsyKJ4y4q7Oiv21cg1kbKFC+wkwHB6t4kIUylfLa4UymsvP6MAE5McnyompSWM8g7nweJddQkNirGU9iQvPpbNr5j5EpPCmPPD55LXi5nDFSfdkb2g8PAWG9P5s5L/motiQ4+q8p9VcHERIX27b5aA81uU1xXpMPmxwo+sISq0My15soStVJdgKk9nigVeVuGxX/LADghO47sYP3qCwLmTQseGgNzoYPiRqHCSWZf+XD1l6p2lwpvYFKuvqqrEU1lE1/eh4gCQJmjbBWDMgoT4cRjGrhIAYIYNPR/vCFeS4wSJ4YBB1XU2t6g6j/7QBcvez0w+xfAOvaW+yShHeEv/RCUWxKGPg4TkjzU9GIlnfa9dofXLcOxWDU2hszPBP5SsMWoiMCa888a8tIEjxvLR/Qoj6cwz0P+iJ95XcDcgcJ2UVqlasvNizx5c8yzKY1oUF6I+Qsaw9a+zIeOejOTSLQnRWbfeIQeTGfxQTlfHKv/iUNt/yZOJBsfZT5g4ebv0dLqBqeHC1OUWMd1/9tgWJPoMU/LIlxaAfbbk+LrE9kyQ4b8vZDix6ktTZLlzzal1Wu2ZFUwXUkSTJy/CboZ94wwD/dZQ4q3G5fCdwOvlVOjfLFusy+h8Em2eC1+lIotk+5qRoZmygSqModfS2Zz9Raz2WQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(85182001)(82960400001)(38070700005)(2906002)(508600001)(4326008)(6916009)(8676002)(8936002)(76116006)(2616005)(30864003)(38100700002)(33656002)(6512007)(122000001)(186003)(71200400001)(66946007)(6486002)(36756003)(6506007)(83380400001)(86362001)(64756008)(66446008)(66556008)(316002)(26005)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VGlaVDFxMTRWUklMeTV0QzcwL2RuN1pwVzNuME5oU0hmMGFSTzErYnhTenJU?=
 =?gb2312?B?cWdUR2w4c2tuaUxIUlhJdWJDTHpldk4zc0IyUnFaMG50S1pBN2xLQzNiWDE4?=
 =?gb2312?B?OFJJODBySWhkSTZmT0dlTTEwMjJvMGdTR0JmU0huelNmZ0N0L0hZSythNDJ1?=
 =?gb2312?B?OVFsUjJTRTJ6NlhWQWxpZzV5Z081cWlaS0w4VFJiL1lYK1dKTTEvMVMxU1dO?=
 =?gb2312?B?K3lqOGkxYWZMYVZtZWZaL3pXUWNnR3ZQb3RaOFJERnIxaVZQRHVKVUpreUMz?=
 =?gb2312?B?Rnk5b2RHc0FZQU9DK3Q0bzVtYUlQUDJVZFFVNExHVFk1UUV4blBRUTFCWUN6?=
 =?gb2312?B?TVE1MGdvL0VxSVViZG1sNk54dUllMnk1Mk0zWi9EcUsyU0dRelRHVnI0ZVVP?=
 =?gb2312?B?Ry9lYnJER3RHNUtQMmRPdnlNZlgvazMyOGdKWWwvOEI0TFR6WWNNTWkyL0VU?=
 =?gb2312?B?dHdVMVZ3eUd3MzZqVng2TkRQSDdBUzFSUXJkb09BTis5dUVGZXdOTDZ4a2Jn?=
 =?gb2312?B?bGZjbmh2SXFlWXl6SFNEeWRQWmE1NDlra3BSd1lqbGJjOURjdUpOUEE2bXpk?=
 =?gb2312?B?Vkg0bWNWb0pGQUhFcjlNamt5eDRhSmdvQmJaNEd1WXZRcSswMk5aSjBweXVi?=
 =?gb2312?B?eHRDMndVb1AvVTRjV3R0VmYxRkcxZWlHZTlZRXQwTDBjaFhmMG1kempTWHVX?=
 =?gb2312?B?R1lkOC9CRXMxMWpUNkg2dEE5c2p4WlVYSHY2NFoxUDRJQ3VkdVhXcFRSOWpG?=
 =?gb2312?B?K3VkUE1RdXJ6eE1jd2ZUU2taQldRZU5nTkdsZG5wMkVWRzRtS09BYWV4cW8x?=
 =?gb2312?B?azJvTG1NSEovMzVtMlVQZWU3WG90Q1E2QVBSMlRzQU9PbnMzWXBDSElpSTVD?=
 =?gb2312?B?bzRCekxSRWIxbWdEbG80QiswZGpUaS9uQm1vZGYzZ0hka2NSd3NKNzZ0U2hr?=
 =?gb2312?B?ckxybFNZdUhRYmZhdGZ4RklJaU1oSG9VTWJ3VW9pQ2wxVHdvdlovYUcyVVZQ?=
 =?gb2312?B?Z2pLdC9VV3JDOW9SbmFXdFJ1bG1KMk9MUlBQbzVyT3F0aHNjcVZpbUNEeXR5?=
 =?gb2312?B?d3kwNDd4c1hMeDl3NHpQQmh6RktBVmdzaHBuR2RTSTBFcGVtWkVFVEJJS1ln?=
 =?gb2312?B?RzdvT3RabUtTdWNMYnJTcVo1N0NtTDNZMHhqSjhVL1g0Sm5BRlJUQVN1Z3VJ?=
 =?gb2312?B?NHRFTTZhNm55WUExb1J2bFROSVlxNm82eUlTS2V2NTFUeUI1OCtzenlaaWR3?=
 =?gb2312?B?V2xLdWZBUzFqeDhmUG5uMnk5Vm5UbTFxYzJCOEJoY2JwbUVLRXozclNsRXla?=
 =?gb2312?B?V213QVQ5S1EzY09CMzVOTU9FTm9uWEJ1T1Ezb0dsYm9SVkFVYVRCQmVDcWdo?=
 =?gb2312?B?bFZ1MGhVNFlkZ0orV2NOY21yQmIvL1JjSmZzbTdNWS9jYXhORndEQjZkZHFm?=
 =?gb2312?B?VGtMQU9Ca3dFWnQxcEliTElWWWt5Zms3M01qSWpMZlVlYlhBdjBYeG5mYmIr?=
 =?gb2312?B?QWFEYVFSb0ZYQUQwTE8zdWRDT1dGc01IamVxU0s5RzlwQ2Rzby9OVG5TREZL?=
 =?gb2312?B?MVhteGNrSVU0eDhmWEtYVVNzems4OThWMWxjM01rbXNFS1BSLzdSVHhGMitQ?=
 =?gb2312?B?YVUyQnRYOXZ6YVRkaUZ3bEhVSTJqZVdCUzcrM3lrdm5IRk43WUREaXhsYThq?=
 =?gb2312?B?LzRNNWU5ZVN1MnFzbmRSMjNGYy9DZEY4c2YrQnZuakZ4SzJZRHczazJWSDZw?=
 =?gb2312?B?ejRwM3k3dDlkUmlwNXpqMlROd0VzdEs4OW1qYnR0K1VtbkdoUlRKODZUd3Jz?=
 =?gb2312?B?NGc4YzJvWE1iZGEvcXpNc3NWUy8wQUMrY2hkTWNoTTJpU3FmSmp0ODgxc1RH?=
 =?gb2312?B?Z2dja3FIUVV4Vk9KQXVEOGM4T0FEL3V2OWpNRU5Ock5zb2ZZaDRPODh2U3ZL?=
 =?gb2312?B?eG1OVlRIb3hOTjBkOWdPYmh3L3ZNS3V6eW96V0FwOGdMNkM0ZjZwTm9mYzR6?=
 =?gb2312?B?R0wzZDNad1ZINFdtUitmcEdpcjl0dFYrRXMxQmFuU1pKUExSM05ORk4ya1lL?=
 =?gb2312?B?SzdKWURROERKYk1CckZxRUJvM3dsYkQrRzYvaVpVcHo2bTlxQlFjWmNOcnUv?=
 =?gb2312?B?T3JFWWlya3R4Y3FTYmNIVE1kNm4vaDdFd1RMTExTOU9wREVoME1BallWSExy?=
 =?gb2312?B?Ym1SR3BlMFpJV0crb2hGcG1KM3hZRlkrT1d3Z2lVbW5GN2pURHJhR3V0SE5x?=
 =?gb2312?Q?M/i8+dhImydjQlpMOx85JYz2wMXywVSSHSNwqbT1bU=3D?=
Content-ID: <B3CBABC3FF1D174E8B4E5148680E050E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f530aa4-51f8-475d-390f-08d9b91fbffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 01:20:26.4754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KatmFW8qukhxfsTYX/VP215zEWuCqyNCuaqiFMVjmedeetwt7DSc45OFjztpqs5rDvnkcIUAXD2nA+ZG9ydeUyILSGvgLvniuTCu7LWN3u0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4571
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: add cmd parse handler in needs_cmd
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

Hi Cyril
> Hi!
>> Testcase ie statx05 needs mkfs.ext4>= 1.43.0 because of encrypt feature.
>>
>> As Cyril suggested, add cmd parser handler in needs_cmd.
>>
>> The difference logic about from before, we don't report not-found error and think it is
>> cmd version string(need to use tst_version_parser) if tst_get_path fails in tst_test.c.
>>
>> In tst_version_parser function, use strtok_r to split cmd_token,op_token,version_token.
>> It only supports six operations '>=' '<=' '>''<' '==' '!='.
>>
>> Currently, this tst_version_parser only supports mkfs.ext4 command. If you want to support
>> more commands, just add your own .parser and .table_get methond in version_parsers structure.
>>
>> Suggested-by: Cyril Hrubis<chrubis@suse.cz>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   doc/c-test-api.txt                       |  14 +++
>>   include/tst_test.h                       |   1 +
>>   include/tst_version_parser.h             |  15 +++
>>   lib/newlib_tests/.gitignore              |   5 +
>>   lib/newlib_tests/test_version_parser01.c |  25 ++++
>>   lib/newlib_tests/test_version_parser02.c |  24 ++++
>>   lib/newlib_tests/test_version_parser03.c |  24 ++++
>>   lib/newlib_tests/test_version_parser04.c |  24 ++++
>>   lib/newlib_tests/test_version_parser05.c |  24 ++++
>>   lib/tst_test.c                           |   2 +-
>>   lib/tst_version_parser.c                 | 148 +++++++++++++++++++++++
>>   11 files changed, 305 insertions(+), 1 deletion(-)
>>   create mode 100644 include/tst_version_parser.h
>>   create mode 100644 lib/newlib_tests/test_version_parser01.c
>>   create mode 100644 lib/newlib_tests/test_version_parser02.c
>>   create mode 100644 lib/newlib_tests/test_version_parser03.c
>>   create mode 100644 lib/newlib_tests/test_version_parser04.c
>>   create mode 100644 lib/newlib_tests/test_version_parser05.c
>>   create mode 100644 lib/tst_version_parser.c
>>
>> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
>> index 64d0630ce..fde6dce0c 100644
>> --- a/doc/c-test-api.txt
>> +++ b/doc/c-test-api.txt
>> @@ -2013,6 +2013,20 @@ terminated array of strings such as:
>>   },
>>   -------------------------------------------------------------------------------
>>
>> +Also can check required commands version whether is satisfied by using 'needs_cmds',
>> +
>> +[source,c]
>> +-------------------------------------------------------------------------------
>> +.needs_cmds = (const char *const []) {
>> +	"mkfs.ext4>= 1.43.0",
>> +	NULL
>> +},
>> ++-------------------------------------------------------------------------------
>> +
>> +Currently, we only support mkfs.ext4 command. If you want to support more commands,
>> +please fill your own .parser and .table_get method in the version_parsers structure
>> +of lib/tst_version_parser.c.
>> +
>>   1.36 Assert sys or proc file value
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   Using TST_ASSERT_INT/STR(path, val) to assert that integer value or string stored in
>> diff --git a/include/tst_test.h b/include/tst_test.h
>> index c06a4729b..fd3d4cfee 100644
>> --- a/include/tst_test.h
>> +++ b/include/tst_test.h
>> @@ -44,6 +44,7 @@
>>   #include "tst_taint.h"
>>   #include "tst_memutils.h"
>>   #include "tst_arch.h"
>> +#include "tst_version_parser.h"
>
> Since this is internal functionality that does not make sense to be
> exposed to the tests there is no point in exposing this here, we should
> include it in the tst_test.c instead.
>
Ok, will move into tst_test.c.
>>   /*
>>    * Reports testcase result.
>> diff --git a/include/tst_version_parser.h b/include/tst_version_parser.h
>> new file mode 100644
>> index 000000000..145043929
>> --- /dev/null
>> +++ b/include/tst_version_parser.h
>> @@ -0,0 +1,15 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +#ifndef TST_VERSION_PARSER_H__
>> +#define TST_VERSION_PARSER_H__
>> +
>> +/*
>> + * Parse the cmd version requirement in needs_cmds member of tst_test
>> + * structure whether is satisfied.
>> + */
>> +void tst_version_parser(const char *cmd);
>
> This should probably be called tst_cmd_check() or something similar.
OK.
>
>> +#endif /* TST_VERSION_PARSER_H__ */
>> diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
>> index cf467b5a0..ef8694d08 100644
>> --- a/lib/newlib_tests/.gitignore
>> +++ b/lib/newlib_tests/.gitignore
>> @@ -46,4 +46,9 @@ test_macros06
>>   tst_fuzzy_sync01
>>   tst_fuzzy_sync02
>>   tst_fuzzy_sync03
>> +test_version_parser01
>> +test_version_parser02
>> +test_version_parser03
>> +test_version_parser04
>> +test_version_parser05
>>   test_zero_hugepage
>> diff --git a/lib/newlib_tests/test_version_parser01.c b/lib/newlib_tests/test_version_parser01.c
>> new file mode 100644
>> index 000000000..9e1bd3962
>> --- /dev/null
>> +++ b/lib/newlib_tests/test_version_parser01.c
>> @@ -0,0 +1,25 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +#include<stdio.h>
>> +#include "tst_test.h"
>> +
>> +static void do_test(void)
>> +{
>> +	tst_res(TPASS, "Tesing tst_version_parser() functionality OK.");
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = do_test,
>> +	.needs_cmds = (const char *[]) {
>> +		"mkfs.ext4",
>> +		"mkfs.ext4>= 1.43.0",
>> +		"mkfs.ext4<= 2.0.0",
>> +		"mkfs.ext4 != 2.0.0",
>> +		"mkfs.ext4>  1.43.0",
>> +		"mkfs.ext4<  2.0.0",
>> +		NULL
>> +	}
>> +};
>> diff --git a/lib/newlib_tests/test_version_parser02.c b/lib/newlib_tests/test_version_parser02.c
>> new file mode 100644
>> index 000000000..5aedaa28f
>> --- /dev/null
>> +++ b/lib/newlib_tests/test_version_parser02.c
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*
>> + * Test Illegal format by using Illegal cmd.
>> + */
>> +
>> +#include<stdio.h>
>> +#include "tst_test.h"
>> +
>> +static void do_test(void)
>> +{
>> +	tst_res(TFAIL, "Tesing tst_version_parser() functionality bad.");
>                          ^
> 			"Nonexisting command is present!"
>
>
> Or something along these line.
OK.
>
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = do_test,
>> +	.needs_cmds = (const char *[]) {
>> +		"mkfs.ext45>= 1.43.0",
>> +		NULL
>> +	}
>> +};
>> diff --git a/lib/newlib_tests/test_version_parser03.c b/lib/newlib_tests/test_version_parser03.c
>> new file mode 100644
>> index 000000000..8f96e68d2
>> --- /dev/null
>> +++ b/lib/newlib_tests/test_version_parser03.c
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*
>> + * Test Illegal format by using Illegal operation.
>> + */
>> +
>> +#include<stdio.h>
>> +#include "tst_test.h"
>> +
>> +static void do_test(void)
>> +{
>> +	tst_res(TFAIL, "Tesing tst_version_parser() functionality bad.");
>                            ^
> 			  "Wrong operator was evaluated!"
OK.
>
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = do_test,
>> +	.needs_cmds = (const char *[]) {
>> +		"mkfs.ext4 ! 1.43.0",
>> +		NULL
>> +	}
>> +};
>> diff --git a/lib/newlib_tests/test_version_parser04.c b/lib/newlib_tests/test_version_parser04.c
>> new file mode 100644
>> index 000000000..461f673df
>> --- /dev/null
>> +++ b/lib/newlib_tests/test_version_parser04.c
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*
>> + * Test Illegal format by using Illegal version.
>> + */
>> +
>> +#include<stdio.h>
>> +#include "tst_test.h"
>> +
>> +static void do_test(void)
>> +{
>> +	tst_res(TFAIL, "Tesing tst_version_parser() functionality bad.");
>                            ^
> 			  "Incomplete version was parsed!"
OK.
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = do_test,
>> +	.needs_cmds = (const char *[]) {
>> +		"mkfs.ext4>  1.43",
>> +		NULL
>> +	}
>> +};
>> diff --git a/lib/newlib_tests/test_version_parser05.c b/lib/newlib_tests/test_version_parser05.c
>> new file mode 100644
>> index 000000000..1bfe24f73
>> --- /dev/null
>> +++ b/lib/newlib_tests/test_version_parser05.c
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*
>> + * Test non-existed cmd whether still can be detected.
>> + */
>> +
>> +#include<stdio.h>
>> +#include "tst_test.h"
>> +
>> +static void do_test(void)
>> +{
>> +	tst_res(TFAIL, "Tesing tst_version_parser() functionality bad.");
>                          ^
> 			"Nonexisting command is present!"
OK.
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = do_test,
>> +	.needs_cmds = (const char *[]) {
>> +		"mkfs.ext45",
>> +		NULL
>> +	}
>> +};
>> diff --git a/lib/tst_test.c b/lib/tst_test.c
>> index a79275722..a9e95a3d7 100644
>> --- a/lib/tst_test.c
>> +++ b/lib/tst_test.c
>> @@ -992,7 +992,7 @@ static void do_setup(int argc, char *argv[])
>>
>>   		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
>>   			if (tst_get_path(cmd, path, sizeof(path)))
>> -				tst_brk(TCONF, "Couldn't find '%s' in $PATH", cmd);
>> +				tst_version_parser(cmd);
>
> Why do we keep the tst_get_path() here? We can as well get rid of that
> and just call the function and handle the case without the version
> there.
Yes, will use tst_cmd_check directly here.
>
>>   	}
>>
>>   	if (tst_test->needs_drivers) {
>> diff --git a/lib/tst_version_parser.c b/lib/tst_version_parser.c
>> new file mode 100644
>> index 000000000..296e25ea2
>> --- /dev/null
>> +++ b/lib/tst_version_parser.c
>> @@ -0,0 +1,148 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +#include<stdio.h>
>> +#include<string.h>
>> +#include<stdlib.h>
>> +
>> +#define TST_NO_DEFAULT_MAIN
>> +#include "tst_version_parser.h"
>> +#include "tst_test.h"
>> +
>> +static int mkfs_ext4_version_parser(void)
>> +{
>> +	FILE *f;
>> +	int rc, major, minor, patch;
>> +
>> +	f = popen("mkfs.ext4 -V 2>&1", "r");
>> +	if (!f) {
>> +		tst_res(TWARN, "Could not run mkfs.ext4 -V 2>&1 cmd");
>> +		return -1;
>> +	}
>> +	rc = fscanf(f, "mke2fs %d.%d.%d",&major,&minor,&patch);
>> +	pclose(f);
>> +	if (rc != 3) {
>> +		tst_res(TWARN, "Unable to parse mkfs.ext4 version");
>> +		return -1;
>> +	}
>> +
>> +	return major * 10000 +  minor * 100 + patch;
>> +}
>> +
>> +static int mkfs_ext4_version_table_get(char *version)
>> +{
>> +	char *major, *minor, *patch, *next, *str;
>> +	char table_version[100];
>> +
>> +	strcpy(table_version, version);
>> +
>> +	major = strtok_r(table_version, ".",&next);
>> +	minor = strtok_r(NULL, ".",&next);
>> +	patch = strtok_r(NULL, ".",&next);
>> +	str = strtok_r(NULL, ".",&next);
>
> I wonder if we should do a sscanf() here. Note that with the atoi() we
> will pass on strings that have garbage after the numbers such as:
>
> 	"1ab.2c.3dd"
>
> What about:
>
> 	unsigned int maj, min, patch;
> 	int len;
>
> 	if (sscanf(version, "%u.%u.%u %n",&maj,&min,&patch, len) != 3) {
> 		tst_res(TWARN, "Illegal version ...");
> 		return -1;
> 	}
>
> 	if (len != strlen(version)) {
> 		tst_res(TWARN, "Garbage after version");
> 		return -1;
> 	}
>
> 	return maj * 10000 + min * 100 + patch;
Yes, it looks better. I will try.
>
>> +	if (!major || !minor || !patch || str) {
>> +		tst_res(TWARN, "Illegal version(%s), should use format like 1.43.0", version);
>> +		return -1;
>> +	}
>> +
>> +	return atoi(major) * 10000 + atoi(minor) * 100 + atoi(patch);
>> +}
>> +
>> +static struct version_parser {
>> +	const char *cmd;
>> +	int (*parser)(void);
>> +	int (*table_get)(char *version);
>> +} version_parsers[] = {
>> +	{.cmd = "mkfs.ext4", .parser = mkfs_ext4_version_parser, .table_get = mkfs_ext4_version_table_get},
>> +	{},
>> +};
>> +
>> +void tst_version_parser(const char *cmd)
>> +{
>> +	struct version_parser *p;
>> +	char *cmd_token, *op, *version, *next, *str;
>> +	char path[PATH_MAX];
>> +	char parser_cmd[100];
>> +	int ver_parser, ver_get;
>> +	int op_flag = 0;
>> +
>> +	strcpy(parser_cmd, cmd);
>> +
>> +	cmd_token = strtok_r(parser_cmd, " ",&next);
>> +	op = strtok_r(NULL, " ",&next);
>
> Shouldn't we just handle the case where op == NULL as a single command
> here? That would make the code much cleaner.
>
Yes.
> I.e.:
> 	if (tst_get_path(cmd_token, path, sizeof(path)))
> 		tst_brk(TCONF, "Couldn't find '%s' in $PATH", cmd_token);
>
> 	if (!op)
> 		return;
>
>> +	version = strtok_r(NULL, " ",&next);
>> +	str = strtok_r(NULL, " ",&next);
>
>
>
>> +	if (!cmd_token || !op || !version || str)
>> +		tst_brk(TCONF,
>> +			"Illegal fomart(%s), should use format like mkfs.ext4>= 1.43.0", cmd);
>
> Then we can just check the version and str here as:
>
> 	if (!version || str)
> 		tst_brk(TCONF, "Illegal format ...");
>
>> +	if (tst_get_path(cmd_token, path, sizeof(path)))
>> +		tst_brk(TCONF, "Couldn't find '%s' in $PATH", cmd_token);
>> +
>> +	if (!strcmp(op, ">="))
>> +		op_flag = 1;
>> +
>> +	if (!strcmp(op, ">"))
>> +		op_flag = 2;
>> +
>> +	if (!strcmp(op, "<="))
>> +		op_flag = 3;
>> +
>> +	if (!strcmp(op, "<"))
>> +		op_flag = 4;
>> +
>> +	if (!strcmp(op, "=="))
>> +		op_flag = 5;
>> +
>> +	if (!strcmp(op, "!="))
>> +		op_flag = 6;
>> +
>> +	if (!op_flag)
>> +		tst_brk(TCONF, "Invalid op(%s)", op);
>
> This is usually structured as else if (..) in C as:
>
> 	if (!strcmp(op, ">="))
> 		op_flag = ...
> 	else if (!strcmp(op, ">")
> 		op_flag = ...
> 	else ....
Ok.
>
> Also maybe an enum would make the code easier to read as:
>
> enum op {
> 	OP_GE, /*>= */
> 	OP_GT, /*>   */
> 	OP_LE, /*<= */
> 	OP_LT, /*<   */
> 	OP_EQ, /* == */
> 	OP_NE, /* != */
> };
>
It looks better.
> Then we would do:
>
> 	if (!strcmp(op, ">="))
> 		op_flag = OP_GE;
> 	else ...
>
>> +	for (p =&version_parsers[0]; p; p++) {
>> +		if (!strcmp(p->cmd, cmd_token))
>> +			tst_res(TINFO, "Parsing %s version", p->cmd);
>> +			break;
>
> This does not work without curly braces around the blok, right?
Yes,
>
>> +	}
>> +
>> +	if (!p->cmd)
>> +		tst_brk(TBROK, "No version parser for %s implemented!", cmd_token);
>> +
>> +	ver_parser = p->parser();
>> +	if (ver_parser<  0)
>> +		tst_brk(TBROK, "Failed to parse %s version", p->cmd);
>> +
>> +	ver_get = p->table_get(version);
>> +	if (ver_get<  0)
>> +		tst_brk(TBROK, "Failed to get %s version", p->cmd);
>> +
>> +	switch (op_flag) {
>> +	case 1:
>> +		if (ver_parser<  ver_get)
>> +			tst_brk(TCONF, "cmd(%s) expected>= %d, but got %d", cmd, ver_get, ver_parser);
>                                                   ^
> 					"%s required>= %d, but got %d", ...
>
> The version is required in order run the test.
Got it.
>
>> +		break;
>> +	case 2:
>> +		if (ver_parser<= ver_get)
>> +			tst_brk(TCONF, "cmd(%s) expected>  %d, but got %d", cmd, ver_get, ver_parser);
>> +		break;
>> +	case 3:
>> +		if (ver_parser>  ver_get)
>> +			tst_brk(TCONF, "cmd(%s) expected<= %d, but got %d", cmd, ver_get, ver_parser);
>> +		break;
>> +	case 4:
>> +		if (ver_parser>= ver_get)
>> +			tst_brk(TCONF, "cmd(%s) expected<  %d, but got %d", cmd, ver_get, ver_parser);
>> +		break;
>> +	case 5:
>> +		if (ver_parser != ver_get)
>> +			tst_brk(TCONF, "cmd(%s) expected == %d, but got %d", cmd, ver_get, ver_parser);
>> +		break;
>> +	case 6:
>> +		if (ver_parser == ver_get)
>> +			tst_brk(TCONF, "cmd(%s) expected != %d, but got %d", cmd, ver_get, ver_parser);
>> +		break;
>> +	}
>
>
> And the same for the rest of the messages.
Wil change.
>
>> +}
>
> Looks mostly good, minus the minor things I've pointed out.
Thanks for your review, will send a v2 as soon as possible.

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
