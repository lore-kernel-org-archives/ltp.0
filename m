Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8111C433EF
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 03:05:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66E973C6B66
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 04:05:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B55853C315F
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 04:05:13 +0100 (CET)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 920751A01188
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 04:05:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638932711; x=1670468711;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TwlB8roAOA8Ve7hWM9Hgm4XSDea1zql0nfQyjlEAKuI=;
 b=AM/JCiu+WrfLKel39dADHeA+4UrAY/waQL8y/IXrAPHU4dWEaF4imjHI
 O89BvPhovH2yRV14lpgFtlFHd6KgL8DF220qO9QqecZ1Uqq153bSi7zfq
 CtTocOyt3xhl1tlfBETIHBQ024NE7jYBIeCvB3I+fvX4wiU1yEmPl5s8n
 H/red2dqycbXP+PR8SuQPwyQPPEgKgyNNSmXYcK3vFe7qxWEX+OM85ztx
 ILaq9+Z5A0ldhKuU8KHaYpbXN7vUu7qgJ2jLZKOA/mFNwoLUZbLq31PBl
 YpIUwZz1Ztpy2Pe1rakuC75I1ezB/qZ/c6DYcW1in4kc4pjpHOpHEBUuw w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="53615203"
X-IronPort-AV: E=Sophos;i="5.87,296,1631545200"; d="scan'208";a="53615203"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 12:05:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWs8UbYLqcfO2QGXucqjo+7FIGOq3p69oy5ZA/VRK8aDUt3y6g5yJ4hiMI6wkFufRgYTzoKVQxGRKtdJYw3A33G5KVzEQ30mc069Tkj143JeZ28TrrIaSan9xssCAS+WwDy0OcgioPAzEjzu8YnNsQk50p8JqagKI58lkYGA/HW88mx+9Ysy7uB/ZCog5sQWYaT0QKAXbGL/NkFrSjZJxZm5SvXP5gnRZ2qH+Uu5HSkLmq3SuayDEpv+kWWwll03Dp44P0a0anyNifae4BmRrQXoKklbzEMVz1ffvHWyl1utphKVQcCg5tVqR0WmsZ1nJ7g+1wBAzGs3GYmtdp6CDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwlB8roAOA8Ve7hWM9Hgm4XSDea1zql0nfQyjlEAKuI=;
 b=JLkgDKfdITsKr8CFL7iHrLtXBWy6jjeWB9MKmGtgyUZ8vLqpQBMgwKQH9yqVvKRP6PDceLIcBRWH9am65BQL7dd6qfzpgWDaTjQ3NTLoGtdr5NMEgMXPLvSUR8i3oNArlT0O+Cimi3/N8BnqiB1R/8LFaKIWQXIm4COSHirqb0SLHJUiuhStLrhvxKsj+S2TKFg+F6GwN527AmPa17E/qikmr1SEQn49F+A1BMys91Ev8a9SezvG9/E1QfBvZye0H15KWBZ/vB09Tp8g6NHgzJ5mLpW89nzb0ki2AisTwimbxEjwtseOGqoFPuDmqL6+RpwLaScuPpxR4T3A4d1hFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwlB8roAOA8Ve7hWM9Hgm4XSDea1zql0nfQyjlEAKuI=;
 b=K1u4tF0d0UhKd+ITUZxw18FMi0MsSkomLzramzVXlXWPOGULwUG0960nDq4UTp9N/THxElY8u0rD1JxAKotEwEb5ssBSHqdVbnFRWEVioUai4gnwqU2WM6c85Cb3kZXZZl15Bo8YOM1QGhVpSlM4W2qnEI9X9u7h3JpVg9SwuK4=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4362.jpnprd01.prod.outlook.com (2603:1096:404:110::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 03:05:06 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4755.023; Wed, 8 Dec 2021
 03:05:06 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 1/2] library: add cmd check handler in needs_cmds
Thread-Index: AQHX60GRG9Vl8t/LukKX02Uk2EwPi6wm2oMAgAEP8YA=
Date: Wed, 8 Dec 2021 03:05:06 +0000
Message-ID: <61B02105.7080900@fujitsu.com>
References: <Ya4DeVrCa1X8IFjk@yuki>
 <1638864483-2446-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ya885sQsH3wftoeb@yuki>
In-Reply-To: <Ya885sQsH3wftoeb@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 669587c0-0e58-483d-12a7-08d9b9f78997
x-ms-traffictypediagnostic: TY2PR01MB4362:EE_
x-microsoft-antispam-prvs: <TY2PR01MB4362AE3AB213C313294E380BFD6F9@TY2PR01MB4362.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ASO7ri0bZDml4GDGQqMbqbTZjYOqs/Xn6Yt96Sxo7cY8/v5WW8eO0gS7hM9rpbdX7u4XYFJ6z1t1997vzRzX16jZ0jNYIX2DwLXYQXvy1+kWuOGXXKHHn6aP8O9HhLuSgFxz67psa6HG8ELVBaIiHAT1bfVlJLoxeK/8A4MnEPeLaEqdVYxTfvbtrPEU5rwgQvALoWw3NO3FQfO+sXJDjOzlwPLOhYwFCNoTJUdmDuefdPfGTXuUSbkXGTzbCTAcjpNXVtUjLtlQi3t4byBzVmpCQ5KwMMgyrmMUiYRxFtUUiNrOrNvy38wZX/tFq4VYuR70tfBrvcc1JgHFAqkD0wT7RdQZWpbEv/I7hhm6uUOUqHK5NX4ZgnIqd7yoUxUZTL6Sc+Z6farffQoFik13Watguirynej3h9k6vI/OScRcQSMovAbvLyqAUjTzLmXeztrf+Hc+O/nZxtykFUh5zKJ2k4ANXOsvvOx4K0ncRhW40p9qyQHkfws4kIljl1MzdpnvvJxzxLVlyDWuKLzMb6t0elo0VJrIXcYwrd+Ry9MAfpCbOhdNdK4MeyowjaL8wiOJ2neYo1oDHI55SwTUwfelhP5p8c8uoURNLebr/0tM8A8MSizBzMx5T4QgLZdDHfXVlvf8GWnpV5tPMHEL9cJBGU7qr/wpmQHspCHnClZo9ZD5XvCu+tLh5SlY3GtoCUNaDWP/LwpjuL8rhoP48Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(87266011)(5660300002)(508600001)(86362001)(71200400001)(122000001)(8676002)(2906002)(6486002)(6512007)(8936002)(26005)(6506007)(6916009)(33656002)(85182001)(2616005)(4326008)(76116006)(91956017)(66476007)(66946007)(66556008)(66446008)(64756008)(316002)(36756003)(38070700005)(38100700002)(82960400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?M2srcUVCWU80bEtYUWo4QlRrY2F1YjdkQWVrNnNrYXNRMWJobXZnK1NCaTlu?=
 =?gb2312?B?VW5hdXF2SUI1SGpGRzBTOXdjemVoMDdCNERwL2U1My9WbVBNQWRFUEx6WFcv?=
 =?gb2312?B?RXVXTWdId25aSHVPTlBza3RIV1o2VzlmSGNFazhIeXhxRnU0MlNCaXI5T0pQ?=
 =?gb2312?B?TlBsN0FQUDlUeW5LZzJNZy9Fdml1ME45U0RmOExWWVFiYlNsOXdPODZwSER5?=
 =?gb2312?B?KzkwQ0RFTkZ2cmhsV3V5TzNNK0dZajdNakljeDBRZGdDTytHQTA1RHk3TnpS?=
 =?gb2312?B?WE81NUhzL1YrV2tPS0hTdDFodmdmYWd2ckppaXQ0dnF5c2lZaFhPTmNLV1RL?=
 =?gb2312?B?SmZQM3I2TVJlOHpMU1pFbms4eGxkMm8zK0tvdG1oVlhZMU0yNVRoUWhIWm1W?=
 =?gb2312?B?MXUyS1BtRjRnOWtJTkMySzFidEZWeU5BS1JCUXdBdjl5a054Y0JYend1djRZ?=
 =?gb2312?B?TjVWN2FiL2o4Mnd2WGhMVUIwanBKYW9zeGdBTVVDR3cwK0xwWDZmeFZpZWFt?=
 =?gb2312?B?YWQ3aERld0JFS0hnMFRIcWI1WnhSRndiS3RPaVdielYwUVpaSUpEdDNNREpS?=
 =?gb2312?B?dG51cFpPYzh0SkFYZlNLd2laVkpOa04wSWt6eFZEVFJkMTV2ZC9rMFlxTXhj?=
 =?gb2312?B?bmJNUHMzVTNXNXZXeEEwbTRTclhDSGl5RVQ2eWtFRHU1STJGMlhpWjlyT2ky?=
 =?gb2312?B?R3VlSTc4YVpWREtjL1orbCtsT1VXQnZTK1Y3UFBvV1BJbldDaVlKaUtqRjY1?=
 =?gb2312?B?RnlrZDFpMDJyRkF6aGwwUnNDbDhWYW94NzFyRkZpRnYwdkw5enFpMFZZWWhz?=
 =?gb2312?B?b3Qwd1crVVRpanlrV0VYRlRqNnRGR1VmU1QwTHRNK0pid0RFelNaZHBlaTd0?=
 =?gb2312?B?TFNwVHgzc25mTmtWeW51NlJmTGV4dlZpWFZMbEgwTnY5MEEvYUpaNDBKR0F4?=
 =?gb2312?B?aUVpdFAvQUxyVHFjNmpmYTBNY2JUc1ZreXdQVXVSQkwzV0hYWXBJTDBObHpI?=
 =?gb2312?B?S1pQTW9ZUXI2ZjhlcThzeFFnWGpBcXliM244dVlFRVNYclRwcm81U3QvbjZK?=
 =?gb2312?B?M3NtbjlnMnpJemFqVENrVndqMFBqbFhZNEdsTEJMeE5UZDVNTm52SUpnNTFU?=
 =?gb2312?B?b2NYMk8wOERvZUphOStBeVdaL0I2ekcvcVRXRGltaFBxMFFESHhUb3VudktW?=
 =?gb2312?B?S0prQzd6b3FNZDRzRWdwNEQ3SE9Fd0ZWMFhaYWh3d1hWdEFyZU9HMmlkTkVN?=
 =?gb2312?B?VC9pWm5TTFE4clpvQVQ4N1JxKzhpeGhqaWs3YnZDc0hLUFJoL3RoT1FFQksx?=
 =?gb2312?B?Z3ZWT1BidVNXSlRsbW1HRmVoNFZTeE5MOGx3ZXNLOE5Kc09taktiUHRCelFq?=
 =?gb2312?B?TU1TRkYyVGVaT3c1WkxHQnlSSjFhdCtyVUJadkl0ZEx6ZmdNSG9pd3ZVWm1J?=
 =?gb2312?B?UFdJNkgwWVBBOHcyWkYxTmdGdmlhbGtjRVdRQUYxTytWSUxRalpaalJiT05H?=
 =?gb2312?B?ZDBrT3Zreit4YktsK2RpVzJHL1pSSkNWeGZmWEpTMzJpd05DK1pGSXBhQXIr?=
 =?gb2312?B?TjdKSDZnS2I1aWxGN3ZLYnpoM2x5RTJsVmZsMldOeURaN0lBT21GOFJYZUNT?=
 =?gb2312?B?UG9XTVNYSTJqODR1M3VMQlZDU3dvcjMvV05md3FMZVFhL1UwUnVUai96OS9E?=
 =?gb2312?B?TUJkNUhsZ1d3bEpIaldnYThJVU1SM0VZNDVkSzNIeU9ZWHlQNXdVODFheEUr?=
 =?gb2312?B?cHVwUEI5Yyt4WStCWDdjQ1JLOEtzdDhpWkZiZllmK0dWTkxEemYrYktQeUUy?=
 =?gb2312?B?WWNWcGhIOUZmbDJxa3U3aTdpNkpzNytZTjFGMkNYcHBxSnpqSG5JNHFTZjJE?=
 =?gb2312?B?SXJVYjgzUUZ0SldraCtPb2IwbGFLc2NpSWNUaDZlN0dNbGVXd3U2MXJnSGVo?=
 =?gb2312?B?WGM2K1FzWE9qWVRCQUdwNUFJMGVKelhjdHdMRGVrQTA5Zmtxc05jM0wvYmc2?=
 =?gb2312?B?Y0xYc0ZaQUhyaHNZWjhMdDJrMHpkMXlpSXVvQkNMQ2psYVhleVZERXlxL3NL?=
 =?gb2312?B?K1YzQjFRZWxMeXduVzN4NXRmTzhPQ3Awd0UzTjJHSGgwYlNmeEVTN1J2a3M1?=
 =?gb2312?B?Yng5b1JqVGF2R2dadHpXOGVEYkhZWGJHZVNQNEZmK1ZUczQ0ZDl6UkJlU2d1?=
 =?gb2312?B?eGxkRlc4dkZsLzY4QWJUcXFPSnpvNjFWSlpSYThRaGRYcTJmMDhpOXFnR3ll?=
 =?gb2312?Q?BnM5esyrTfNXRxkh0Nr8Eoo1oXxq1j3ArGxXlYmHks=3D?=
Content-ID: <20D868E1C379AA4F8EB24D648A959261@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669587c0-0e58-483d-12a7-08d9b9f78997
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 03:05:06.4970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CygRevAK7G97NUkcQNQziY5wmBOquNdb36SSFmuSNiFhqgjRi/G9d0Evl2XeDzfB8k8FwUZAnYbfBx++5zDfXtK6NnWc/GK0VShcIl2t4Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4362
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] library: add cmd check handler in
 needs_cmds
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
>> diff --git a/lib/tst_test.c b/lib/tst_test.c
>> index a79275722..7cca209ab 100644
>> --- a/lib/tst_test.c
>> +++ b/lib/tst_test.c
>
> I would rather put the version parsing code to a different source file
> than tst_test.c just because the tst_test.c is long enough already. What
> I did suggest for v1 is that the entry point function i.e.
> tst_check_cmd() now wouldn't get exported as a prototype to the tests by
> being defined in a header included in the tst_test.h header.
>
> We already have include/tst_private.h that is expected to be used for
> function prototypes that are not supposed to be available to the test
> code.
>
Now, I understand. so I can just move tst_check_cmd declaration into 
tst_private.h and then tst_test.c included it.

But the source code should move into where, it has two choices:
1) like v1, move a new lib source file ie tst_version_parser.c
2) since it is related to cmd, we can move it into lib/tst_cmd.c


I prefer to use 2nd way. What do you think about this?

Best Regards
Yang Xu
> Other than this the code looks good.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
