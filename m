Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDA9C4332F
	for <ltp@archiver.kernel.org>; Wed,  8 Nov 2023 10:54:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FED33CE7F4
	for <ltp@archiver.kernel.org>; Wed,  8 Nov 2023 11:54:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 423633CA094
 for <ltp@lists.linux.it>; Wed,  8 Nov 2023 11:54:02 +0100 (CET)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 75E1F602BD4
 for <ltp@lists.linux.it>; Wed,  8 Nov 2023 11:54:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1699440842; x=1730976842;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=pw8hGkMDYAKJJrwTEph8A/kNO5TrP8IY4Sr28nGYw+k=;
 b=AaYQy6S2VFXCyPS+o9JyMffnC4+Htr3aEPrBwxGSrY/HOJCuSNz2OrZ6
 7sKrPOR5OG14MiF0I5Yv43vsvBYGPOA7NffCiprESjwNT8zC+VHYhLm0Y
 P1yc203z1LJ3rJhF2N7fBDegrouHZWw/Q5MITlCYD6RwIezAvLaaCMx6r
 sfJJoV5jOAXufHYFe4Ua4XrWEY9/RJs+rFWgmueUUt+YmadxABybJXmYg
 zg4oTZ1ESojwOdXxCJ7YQKFKCJYqpvH/AzfQqtf3Ai4M6DybXDbrQPpLp
 eK3UMWpDz028qTO3Mz7GHYBERtfSbNtJscttOOpkivuaduRV+I6xDLPqT g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="101926610"
X-IronPort-AV: E=Sophos;i="6.03,286,1694703600"; 
 d="scan'208,217";a="101926610"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2023 19:54:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk+DzFyHLqM4wwT0XmHWlkHg9SgIT69qKD4mgj93JrEMsa3YaM/2O8Ak6oMqIkAyimHdNqY1dYk2LNbIQqbW5s/IEtoC4QbaV2pwWJV9Z8S4yC89ePDFQst4U24xJ+WrHUY+O6c9KCDyGOd4sbiijwKW6TJWk3n4qfa5g2JH/DzOYrkag8CR0CizrOCwWx352uDTARXmf/2Af117JrHP3roDRtbQfu30pOvAcZyczb0tdewcGApRxrNFpaNyaVaKRMoGEK0s3zGX8HoD4OvY5QtBietxwXirtJECluOd+nnVf8tIkZtt++QpeCfSiMpOqR5ivtLMXgt+eMD8eyQRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pw8hGkMDYAKJJrwTEph8A/kNO5TrP8IY4Sr28nGYw+k=;
 b=nG0x8zQezXFE6tiPcp5l9esYyZLmigKg1yy2Ol622GPOOzjtw7UCdAIAUfkncqh2l3AP+iEnoEiAOvkrkBMapkzYGonSKyHTjdLZMgzQNFKC6IN0rmGbQsXVn0dvrydccud1/ipOuP0Nt2nn7JI+dDkhQlWDd1ytGBg6E/A6FtkYSZCht5eKCX3n/RkVtcGsG7V4pqHBC+EWmj7X32ri3Z3qLUg0OywIIjQRtjpblvTQBddVz3b4k92jxoIpITe2VQcuMbrVn14cPcz4zSUHklKcfKFE01YVUZQ8bTi12rN8Z2R2Be/obN9HKLmE62kPRb68Ng4VbOuYZlNcjJtXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11829.jpnprd01.prod.outlook.com (2603:1096:400:400::6)
 by TYCPR01MB7704.jpnprd01.prod.outlook.com (2603:1096:400:181::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 10:53:56 +0000
Received: from TYWPR01MB11829.jpnprd01.prod.outlook.com
 ([fe80::ac5b:bf7a:d029:19f]) by TYWPR01MB11829.jpnprd01.prod.outlook.com
 ([fe80::ac5b:bf7a:d029:19f%7]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 10:53:56 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v3] Refactor and merge symlink04/05 using new LTP API
Thread-Index: AQHaCKrHlq7TEpEDUUy1a6k6Ya2GebBwUeXc
Date: Wed, 8 Nov 2023 10:53:55 +0000
Message-ID: <TYWPR01MB11829CE0E74196649483DDEFEFDA8A@TYWPR01MB11829.jpnprd01.prod.outlook.com>
References: <20231027071236.51779-1-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231027071236.51779-1-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-08T10:53:54.563Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11829:EE_|TYCPR01MB7704:EE_
x-ms-office365-filtering-correlation-id: 503063bd-9333-4000-91f2-08dbe049011e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4egGc+2zxqEXzd79SGSJuL7rhTcaGoDhXkMXfJnIysgARnwPCacTexC8u7VLXU2vXeTIPJQNhM4EQHk3bTr6LpWshDzmvs/RlNDeezxKoNcTip4xfIOcUD99VlUEuQdgzL2/nY+nZAeKAykTA5oHiM0oycHddIVr7PTIWWRkCiYt9DdFX1cKDeVmhtfdHgjcJwPsXZCIHT8M8cKASbcfvyrzzpEpErOiIO+jyNGb42u8xd1f505cqLy/Ge8eBjd3BA8G1jhYHd66pJ865Mf7GWdl443BIRoU0z3nk6ywsI54CWMAPOsVWVLITJYQRhBuJVMkByYdrIwCfYo3D7D5SMIzG9ioVH2+1bCWTYfCAVIP3zhy9KYEpjuQxCvOQ1JxrH+8jZjapAv4MpnZc5rViXbGpqFlKdCB1uASLs0h6h2VgKkthXUcIb7BdwnWFzwDlsy/5okz/8JuGX4N7ktcjbaeZgNhpf8s81qooDYqKGTF3J3RMm4rqFdm4GocNgIQV9fJrY4ihdD+CD/KK4/tpSkJP8eIeSLTsL8LzuFCZCfbuZZBTD50Ex3o1w+ETpBatvHmSn1Nm9Blv/vzp2QlKKGshbUbMHdGgK+a28PN0GrcBWa6tl+RkzMZZ8KyM7Op1N0C3aMByjhmrGLZY7eXJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB11829.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(1590799021)(64100799003)(451199024)(186009)(1800799009)(4744005)(19627405001)(8936002)(8676002)(55016003)(86362001)(5660300002)(83380400001)(33656002)(41300700001)(38100700002)(2906002)(66946007)(82960400001)(6916009)(122000001)(9686003)(1580799018)(52536014)(91956017)(316002)(66476007)(76116006)(66446008)(64756008)(66556008)(6506007)(7696005)(71200400001)(38070700009)(85182001)(26005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WDVmY29CWlVvUmhhUnRiUUtmNlVUQ3Jnb0lSNHJOaVE4WkxacGwvLzRRWDZl?=
 =?gb2312?B?a2ZHbXZTWXJ1RXdHTVVvWVFDbG1qMnA2dEJOU3NtUlprbW9MdnlONTF0dEhN?=
 =?gb2312?B?Q2tOb0Zob2FQZ2VRY1RkMDZzWFlXMnhJN0dCeUJqV2d6TzBpcWk0V3hHV053?=
 =?gb2312?B?WmdmWXY3SWkrRWNBSUV6WVU5bUQ2dmlRL0Z2SVZCZWtQSGEwMkFxVEJGL0Jp?=
 =?gb2312?B?d2RSZm1qL3FMQm5jVHhyc2lmYVIvM1ZxYXRCRGtHbFQyMmtaanR0SGpHSlBx?=
 =?gb2312?B?RGgzdVB3MFArcXpSRlBhbUxGWHNTUnVZeTd5RUJiMG5lNVJjQjdtUDJHNEk2?=
 =?gb2312?B?cXJmSkRsSngzUDJqL2J2Q3dRdlUwV1NOek45VnM4eVpWNHJDVFRGNUhpemw2?=
 =?gb2312?B?RmJldWNHTTlrN1UxS0ZtVWZuMTVTVHF6RTZBNXVnVjBkcEQvNk51VGhPTDBa?=
 =?gb2312?B?aURnWE5zSzg4d1EvYlJSdXZyQi9acS9SekowQ3pLUDFMd3hmVlZtSDcyRkYv?=
 =?gb2312?B?T3cwc0JCMTN6a3JBSmFQU3NGT2QxdW0zMjIrcUMyNUZ6QWp4RnZBZUxxOFhi?=
 =?gb2312?B?YVdYbXZ6R0hQaC90cXpPV25NbFh0L3ZyN0tVc1pnbGZHbjcrNXQyREIvYzdG?=
 =?gb2312?B?elBWaHlOR3BSYzZIY052L3poSS9zK2FVTk15M3VJUVdWT0hJZk92YlMwdWFZ?=
 =?gb2312?B?QU5ZTngzM08xeWo3QmhnYkFjMmhHaGFlQ1N1OW4zbDV1am5VbnExbVM1d0hI?=
 =?gb2312?B?Q2NOdVJUTWltYXZUSkFlOTRjTVVpRVZyVVhNWUF6QnQ1WHA4bTBta3UrYkRN?=
 =?gb2312?B?Mko3MExLK1RVSWhicHdDdmoydEV1QzE3Y2FWTE9sSEUvU3BkUVp3RlFxenJo?=
 =?gb2312?B?bmtza3IzV0NWNGNXU2pXMVI5K05RRmtWMXRVT0tORVZUM05TL1k0bW5KN0xv?=
 =?gb2312?B?YnZ2eWxoZXZvTitGb2xMYUxCOTJRSDFpM3ZDbXoxY0VWT0NOcFlpNGpyMUJy?=
 =?gb2312?B?OHhKOFFHcXpoSkliT3BkWUdxUFEwd2ttL1MvZXN3ZXFZWXk1WVJNdXMzemdp?=
 =?gb2312?B?Nm13cjhqTnhnSXk0WGFFd3JlUUZxMjBHcnJmK2xBd0c2RmhuQkJRWGFRc1Nv?=
 =?gb2312?B?ODJNQUl4cDhxQlVLYlI5NXdkQVNWZnpEaktTei9NcTIyamEwU2l5dzFkUGNX?=
 =?gb2312?B?MWFKNk1zdGdaWEZFOXpsYkxkV2I5a0Exb0MzQnlab2ozcFZ2NVJOZDJnVkRm?=
 =?gb2312?B?MURsR3dGcDl5ZnJBNHhDelBBS3UzOGJPVDFIWWNUTnFIT3JpeGdhZXRMS0lt?=
 =?gb2312?B?bmJpWnJYYmJ0QjVEUGpuWUFYc1NkYU4wdE9tRU5vWllPZG1EZ2tkeDZjN2VN?=
 =?gb2312?B?czdKSkw0MDVxdVdETlBYaVdmRHNnMnFGMTdYWW1sY3BDYUlPS0NPQnlHWWda?=
 =?gb2312?B?Um56QVNTVmhFMVM3SkMvNE5iWkNzd2IvWFBsNyszWkNBSE1ZakJjaHdBOGIz?=
 =?gb2312?B?dzNvb2R5Y0RSbmlJR2Fhd0dOTG1DYVJaL2FISUZjNkNOVnd6QXZva0kvMndZ?=
 =?gb2312?B?ODFuOGtDYWkrd09QNUZuQWdXOG5RV0pqYk42U2U0Q1lSakFHbUpMenpSSW1z?=
 =?gb2312?B?cHNtK0YyaXFPVG54cnNPeUN5RkkrSWE1THlGbit6WWhmb2VvUlFKTkg5V0Zs?=
 =?gb2312?B?NGdkZFVXa0xVdXE0T0ExZ0JkN3ZZM0RVM2lJaTZYQm8xVDlINkFyK1AvenU5?=
 =?gb2312?B?VG4wa0k1VGFPMVE0NkQxVEVZNEE4ZWtlNTV3Mzd5VXBJTlBWemdJNlhGOGhW?=
 =?gb2312?B?UTFmeHFoQkhweGU5b2YzZUxGUlE0MnNXN3VDU3o2QjdPdDFKdzc1RVRLVUNu?=
 =?gb2312?B?aXJqeVVCbUVHNk5YK1VQblZMR3l5RVJsOXVFRlJJQ1FKWkdjRStBNzZzMWY2?=
 =?gb2312?B?US9paGF1NFpjaFpNT2k1OWFablMzcjFPb2p6Y0VhMnVoUktqOTNXUk5uQzdh?=
 =?gb2312?B?LzJvVW9YTHpsdVRrWEl4N0FIb08rR2IyVW1NNW9XbjZvbzgreENZbXhtUzh0?=
 =?gb2312?B?UTYzdXQzMzFvandkTldmMjRmZFVrQ3hadnpOcUgwUDFIdXNWTGNQS2k1TW03?=
 =?gb2312?Q?E3KvsER1w1ztoODIZXu7W9Q7+?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 913lYjbwbttVi3RLlRhpJ/AwfxfR6nqUX5urig4f+ygEwNaHa5t6Z71zQjrGtebo9wzg1qiyCmE0yVefGUie25Yd3HkuptmWmczQp64zRVuw4mn0tyvYB2oPIK0JvvWJm+KJUwZSybOz3PKIjaGsdD8J6yPyYI5tKOroLD6jAXgM+0gNGCaw/Pj73RdB3tw7KLjnDA4+n9OnOTnngcz1F3av/Lca++d8KCHy3eXrAs0INlXPkmBbKINRjzcDHQWSAzWY4r8Dp2AQPcXhMR7Ayz4+YMuImXiiSXdrd5EEHdj7MYsL7luy+6oTOO5btFmk28IwotUZlScLKqq1CjsJx0WGSS+ZOia2QVyfEXrFHg6LZbgoISoHGcTTKnwPiRt3IRz4mgEq4XJ5rxQL+Jn8hMgX4cOal6g42MLARu2yUd+WSEtaAUuQ3nCAFMrDh0fSA9mBVHGkDY//p/osw7zLhsDLUHbTsBTkardf2JT8AD34qwf3Ys1GgxrAJ3oKhSvTUM1WH1KEPTzAVKcVQOV6OL6ZW194wYhZgPRzbPKojgPE4UZl0gjfKbmTUAC708ckVGITWZutJ7bqgI5mfQuJ9bCJ8Gl8AiESFL51G9cVE8MGBAN+Q7jv6rnrzdZQVDSaS+4V7Ipgjh3yVw12dZ3dVAzgSe3VIyNF1JoNKXvx4bbLoaAmHF+mlR/fudbnVwJA6MWIH79OA+IKbavGhSDhxCEY7Et3MW9oKDxRSjPh2uCdczpUdcZxxHYbp8qtdoA/An0tCa+rPgsFCTHk94q/Nw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11829.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503063bd-9333-4000-91f2-08dbe049011e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 10:53:55.8919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wupbQlwbGWwn21sRFwJUbkjE6YDMH+opORgktc9owHxeciEUdTSCeIUF25NpmPmGVWi383k3J8VK/hLdJREVbnJkew77zrqIYqVv//jVJSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7704
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] Refactor and merge symlink04/05 using new LTP
 API
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

Hi

Ping

Best Regards
Yang Xu

>symlink04 and symlink05 has been merged together, testing
>the results of symlink(2) for the existence or non-existence
>of a file

>Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
> runtest/syscalls                              |   1 -
 >testcases/kernel/syscalls/symlink/.gitignore  |   1 -
 >testcases/kernel/syscalls/symlink/symlink04.c | 217 ++++--------------
 >testcases/kernel/syscalls/symlink/symlink05.c | 180 ---------------
 >4 files changed, 48 insertions(+), 351 deletions(-)
 >delete mode 100644 testcases/kernel/syscalls/symlink/symlink05.c


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
