Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A93AC433EF
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 08:43:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B42073C9A5D
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 10:43:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BE233C04C3
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 10:43:25 +0200 (CEST)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 745A41A00113
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 10:43:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657097004; x=1688633004;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hIRsJWw25y5+t6a5ve59SNnpDNsQrDEnWHEto1GB1BM=;
 b=X7xAssPSV6rsCVCK1Jd90biVnTogBNJwZrBvinj0BZbkCW4e/a9pMdzA
 5lu3aKDlpF39FrTMJVRtdKxJEckAxaCMZvkdVCxsSrrQPvNoav6/l6jHw
 ygpAGSBnJm31TgA6TM3by18C3U3i4A5Omd8cO9aLSroCKkQ/+dkJr8W8E
 iRaO58YlaKY3ia8vTiL6oxiUWFIUzgAyRwJnXK/Mx7kLr3wU+CxBci00X
 THCV0tSrrqkT5wiWyOYvfocWaOm02EM2qe547C6SWjlgmaZl36Poj4z+l
 yg3YsIiLE1Ir4BxCmWS/orK4nCN31TZTyT6fufc7N/i9EPcoYyEG1yBTe w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="68005859"
X-IronPort-AV: E=Sophos;i="5.92,249,1650898800"; d="scan'208";a="68005859"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2022 17:43:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R77udmluMbUKHsPXWkQQm2ZrGAKmf4R9kNOyusSXXdF5Bu3l876aKY+UtZ2J2Hxb40uNlQPLB/mxtyrCl69QIrqA1G3nLL+QPe5iPiEltrwdzQC4MaUK2V02sSuGXnuenpuHlLfWUAXeWFskdFL3j33RHA7/GAE3rPF0DhMWuG49PwiS+N1PeD7tO5NzUdvROVs4uHFFmbAan7RRdxUucjeEypMlWXylgobkxOmgx7n8HZiVisccclFm4UzSefCXiPUmElm/WMo3Nto7WmiBWc7mUiVxAYir4wbrQFJucDzGgkVGxTANvjvtrGuYBABKZgqqNpwk0mRjW38xV8CpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIRsJWw25y5+t6a5ve59SNnpDNsQrDEnWHEto1GB1BM=;
 b=lkvufMvLn/LiOo3Iw8sLSfUaxXIV9pMUWPuC9AmJdlD3botXxeFD45sdwI18x/DiPSRWaQyn6wa8V9iDwcwCDaht80yOHJrH43Xr/PkpMvGMquOpeRcxlLNak4XQwolEgqVW++TnrXY5fNp6pcjZLaf+lZMxmoqW4qTguUPoLde/PmUffJ4Zoft8vqTRQjPQnUPq5B88OnkWmghQPULmlPqYxwOJy7ODt8SWqlhTCWJlNBDRDsKaikdCaa6f8XSe2VSTuAYJicgcrBf5clgEB+zP78fByV5cIaehF5iJHJaPQc6lF7YRRbwtoCyXyryGw0OYNI9u/K8L297xj3sY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIRsJWw25y5+t6a5ve59SNnpDNsQrDEnWHEto1GB1BM=;
 b=hdr+uq91tGh44dApcDXbFgFetDHFRIGIyOE9XCrYRczusHIwTnU0rDRNnGIzhJfubUyZDZ8mybp+sYRjkz3RQyBgS40jdclQnkM0QRTWh0vg44czde2+UCCYFbmowQim+WYgeGZNOfizJwhCdcSUlbfiEwZ8qknbNl+GR6Wj5gA=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB3620.jpnprd01.prod.outlook.com (2603:1096:604:30::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 08:43:19 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 08:43:18 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Thread-Topic: [PATCH v3] Fix mountns01/02/03/04 final umounts using more
 peculiar dir names
Thread-Index: AQHYhhkxPHDNdEpWokyM2Ummwaqs5a1xLbQA
Date: Wed, 6 Jul 2022 08:43:18 +0000
Message-ID: <62C5596E.6010608@fujitsu.com>
References: <20220622091919.19468-1-cristian.marussi@arm.com>
In-Reply-To: <20220622091919.19468-1-cristian.marussi@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 358adf60-b3c7-4b1f-5025-08da5f2b9386
x-ms-traffictypediagnostic: OSAPR01MB3620:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TUyr27rVCwDeZoZ4mIW06OPVvTbgOfiIi441ENaUv2EzsDMbqK7u4APEOYu01WgYo1MBTBHcCCaZ2NLcS7MWkqfro49rOEpN1t+6aQSlsjDiyTx91hT5RvLHzzfNPxmd5+IAOLJ+2/MSRehCw/hljXuR+jg6fdO69t2N5T63xoqHa9lXkEtYrn1SaEXpJo+DZh9HNe6wVIUXw2iiFofTQlA/sTSBJ6CgAiNlSnC2knm7qZxMah7SxhdEtcHWiRl1pBeYgRY4MOQnPIkQTTewlAkj1BGk58m1xoeFe0aBZ4QANCEX26mRw6VvxuxJq/xbTSnpLCrFgXQw4oVjTedxkHCYhyi2ST5NSjVLSu1fVbqfThkzQ4VyCUmBKRTvlVVO6wVXcxI/oZJXZrSaP+35uz7sFa/t/QD3P5Hu1wjJZIoLUggjcG7FIBKhTYrB3uA6O/QNfKrv1YVH2fHHM4Pc1T28Z0lHMB9TbrKL/K2+Y7h3KHDrnv2sQE2UhSJYi6URfPjsnIIlOPJ4GzvgFKtUBVgsbmGloyAI6oLjMl4rqZPl8RlWo+CwGWWrQta4IeoGwpTUFVsHjSy+4QgGjONmafAvnz7vfrtyJOTcnLFBMpH7ORDccqVlE0y7Gecmo4nCh2bZucMHXfsZgNdpVFkjjgyI4jL4dkN3ZAyXRmWhj3OTScFUT4u6a4v3HXCaNe4Z5NhZchS/l0zEsYsZRKJJm4pqcFVr6dMa498NeoN+OwRSMZAELvyKuElFjtHyIanRWEWf949BwLlddcrdQnWztMxqyJ6LOl7QIQMMPf7ukZlV1nKB0hOyWItEsMGcnx7Y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(478600001)(38100700002)(6486002)(71200400001)(186003)(4270600006)(2616005)(2906002)(558084003)(19618925003)(6506007)(41300700001)(87266011)(85182001)(36756003)(33656002)(66556008)(54906003)(6916009)(122000001)(316002)(8936002)(5660300002)(86362001)(38070700005)(82960400001)(6512007)(26005)(4326008)(66946007)(66476007)(66446008)(64756008)(76116006)(8676002)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SUFtL2hZYjlWd3d6U3lYZEdQb01vY1lYckkwVWFrR1I3V3o0cG5ldnNISnFo?=
 =?gb2312?B?c3V6Mlc0MVk1RjRNT3hqaVl1Nm9wQzVkNlRjY2sxWFBjbTh5bXFQSFI1TUpn?=
 =?gb2312?B?a1JKTFRRZmJoK2lDTFRKd2JLNWIrUVAycDFWMmNaZVpMMWx4Sk1KWndEOU9H?=
 =?gb2312?B?ZjNwNUI4WFhkUXRmT01uQVFBTHZwRkxYRWs2UVdZaGh3eUwxUEZ2ZElBbkRu?=
 =?gb2312?B?b1VMdXBqdlBzc1hzbHVFS2FIdmdRSDhQSnpmc0dPYkVXYnM5cHhJOVdET1kr?=
 =?gb2312?B?Y1ZUbHlKK1pOck9Nb1RlYStCR0VDeUkrNStjZSszZ1gvODhFb3YrRk1sUVQr?=
 =?gb2312?B?RzhFdUFTYjRxRlI4dG9PK0wvRDlMU1cwbSs3UkZNcUhkaWJFaUFsaktCZG9o?=
 =?gb2312?B?dzY3WndkT2ZuaWNhbW1wN29xcDhyQ2RCM201MVB3Vkd1azFSOW5NSlVoY2RC?=
 =?gb2312?B?RU5NcDFUemZDWkhLTllKNytVajJJV25QM1QxMlV0aEZlZk1rbnRFQjZJT2Jm?=
 =?gb2312?B?QzdGNFpxWVNHQ21EREpWZWJCNFphTFI3clNyWGtMQjNCNXdjRWFoYTJoRUU0?=
 =?gb2312?B?QXBDR0Z6NGg0MWtPaDk4ODBtcXNYdzd3TmJXTmlVOE14Y1BNZDY5NE5vVjVh?=
 =?gb2312?B?bWZ3QkVZbnZTWE94b2NXZFpHVEk1amI1eXNXTitCQnFBREs2eEFRVUtKTFh5?=
 =?gb2312?B?c3piWWMvRGxjVHg0YmZlUWdsbnpzRnA2NFhTSmhGc2ZIb3pta1dxVVM2bHNw?=
 =?gb2312?B?L1FMQ0tTMzNlcFFjb2ZCc3A1YWxJOXdLUFkyY0Y2cHRHUlFTN3ZVaWJJYVVa?=
 =?gb2312?B?bGpWZGE1d1czUnhuRGgraXBCNldhWDYzQXE1cEpvcUJrZGJVOUN4UFkxam1P?=
 =?gb2312?B?Zmx2RnJEbG9aTTFYbDdKM3YyRzd0OFAyYTBpVTJhVjA5YzZFcEwvK2VFbGJ5?=
 =?gb2312?B?OEZ5K0R5YUExUy9Gek5rU2xsSEtDTU5aVlFHOGswRCt5cWZTT0VlUUVpdzla?=
 =?gb2312?B?OTlDbzBzcDIyenFMNFFUVFE5ZVFQdWllb0o5Szgra2lkNVpqOC9mMS9UcUFB?=
 =?gb2312?B?Ni9RYVZGd216c2h3aFJlRTdxb3Q5bVkvUlhpdjYxR3YwZUJnUy9WTEsyNEQr?=
 =?gb2312?B?WGZNc2JZcW1ONldHNXA4MzdUdkVCSkVrTk5wQS9CSW5wUkEvTFE3d1BBSVFn?=
 =?gb2312?B?WTBxR08rOHU0bng5d0t4ay9TNnJtbERZU2dvY0g2MllFN0ljWjFiQktQMjVu?=
 =?gb2312?B?ekxrdUFrY1cvdDVFUS9ENTM0RFJsVWNHZVgzd3ZsMFVRSWpKUjZMUzRVWUN5?=
 =?gb2312?B?bzhhSDArM0RKNnV3U3lTSHRkdlo2ZFNkaGlsaHFUVGRjYU9NOHVJUktxU1Ur?=
 =?gb2312?B?RGU1OGlrY3FTdC90MkRPbGZ3WHdEVzZnU3F5bW1xZVBwUUlQNmFmMUlEUzZk?=
 =?gb2312?B?dExia3NPcFdyTytwQTFtN0pVOUlIdWxLZkxLT0J4K21vRXI1Z1JyOTRrS2Ux?=
 =?gb2312?B?UnBQYnRKaUlPVVBmUlhjMFJvOWxEUHBoMWtha3BWNFhIRWw1TU1GUUx5aEt0?=
 =?gb2312?B?eDhkZENLNzJkWVFKTmw0Nmp0TTJIRGJlUHljWlFPTXgvbWpJeTJScHBxQmRI?=
 =?gb2312?B?UVpJZ2Vhb0ZkV2U4eExWRHR5Qnhpa21NWmJyYmYzSzczOEVROEN6TWFwZmta?=
 =?gb2312?B?clVsVTNFRTJpbXJTV3Q4NUJyS0gwZzBERnhod3N0KzMvVUtkelA4d2phK0lW?=
 =?gb2312?B?TjlxOXkyOWJMU2sxWkU2Y2luczQ1NXFZbVlsMXgzS3BYb1hJU3QxcXAzaVM2?=
 =?gb2312?B?NWZUbTQwdzl1akVJTmUraHY4VFhaUDgyRHpSM0kwRUlTeFJ4ZzJOcEVIYWM0?=
 =?gb2312?B?d3JSeFRndGRRUnFhc2l2Q0lsT0NJdHFnTDU3K2tyLzBaVkZrRENtTk1YRnJo?=
 =?gb2312?B?elZ2K3VjNUxFckxSc3RxcXJETHFuUU9TMTZmZ1M3bTRYSEtFUDczMUdVUmgv?=
 =?gb2312?B?K0I5SEdoTkpQeWhKNFdWaC9PcmM3ZDNLOTlUcG1MRFo0UGFMQjVHa2pRODY4?=
 =?gb2312?B?NUt4OG9Ja0xCOHZxMHVWZEk0VTk3NjRQeURlaFBSSXVsc3pTU1FNUURzdlVj?=
 =?gb2312?B?M3lQbWpoMU9DT0lQaFV3KyttdVd6c2V5OWlwVTNPRVAzODlVOGhxL0dmaCta?=
 =?gb2312?B?NlE9PQ==?=
Content-ID: <F403CE16C9A80A428FCE92788381E119@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358adf60-b3c7-4b1f-5025-08da5f2b9386
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 08:43:18.9475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rtKALwNOp2pzO+ac4jFnAbzmP4GEXAbY4+Q6IbFK47I82Bq0MCGLOUCKbHIEumDtsqIKmld0zmCAgj/iSyX6YshweQ1r9IibeDUfJ56dryo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3620
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Fix mountns01/02/03/04 final umounts using
 more peculiar dir names
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

Hi Cristian

Thanks for this patch, merged!

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
