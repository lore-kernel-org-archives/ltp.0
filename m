Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE39FEB64D9
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 10:40:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A6BD3C99AC
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 12:40:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59EDC3C9981
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 12:40:04 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AF8481000658
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 12:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1688467204; x=1720003204;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VsMkV3vQod4s6HDgJ5PKzz0jqeYCYM+/SJqt/GV1/9s=;
 b=xfIkyVPaEneKCWtmRYxBt6M4DNrZ/SYFcTV51FxO8QsXn2zqLUwhdSqq
 asGW6KCy3FPuyYWUXzf6swWVgVYqfeAaQbDIczXrWqjfjhoTkSNWlAqw7
 igWTBoMdEuMljMPfXqk1Bv8feZoX1nkbns3VSBCE0cvUIzY9tzGLJs5Vt
 hlOEbadtQi86rD9u210WU1SFSQKg09p8a5PSph30LGbBP3EULTVG6Crab
 LQ6tmaGbc8WoHgW3DUR/Tc4NowiZL/R05hf3SiWlbuO+FVTbXB359Gmqx
 bqD0YnUFpwMGASCtOYIk3i2eZ3BNrYkuZZsWrRNAHlOwdJHUd3NL4DeL3 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="88705342"
X-IronPort-AV: E=Sophos;i="6.01,180,1684767600"; d="scan'208";a="88705342"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2023 19:40:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIyUdmHM2GYgF8WN+rvdNUhUb8zC/XB2+jv6usEDPxsKJ28X0Ozm6GFb8uFDEht2ED3BlAEliapYK9pPs21SKHGGnstFAkAOkzyC5oWlfw13vI16Ku7DkU6V4IcJ0m5hrwPYTGOJ/yhy8AcbBeBP8jPnI/P6OMDptLZLQK5bcTnxJh4PVyPnABIOSDrrg+4fDiH58nG7msiASfsQccBeHqVtVZQqrCR0OeGPDZYp5udKmehh9VlNmNiRmOrvOVkkCHk4NOq3lusdDrJrW6quRzAn+xKPl7YcJ2qDhHiSvcA+NbTzsFL8F5xKSwpZOq4z0hfeIZ1/RGS+sa9M1dmfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsMkV3vQod4s6HDgJ5PKzz0jqeYCYM+/SJqt/GV1/9s=;
 b=XBUESDlO9WnnGU6hlgIEs/E1Bboinkjjom6uA9kVxOtAXJGEcjYMdU47MI+KRaUO74XahGZWayr8zPAKA7VqvQMgysaAX3QDvDTTklodsJ/kB5lUhFOwFSzmptd7YYlh3JTi9h6dzG75TnULkE5im2Qs0AnlkG9H36NvWPV1DYdEYyv2Ohdb8FcjEIbOBxL2TUEIzAN43InN/VxSwASz6G0VHlXIQbB3730VKSSd4QsREMt+CT6gPXYqHiz6PBdohcp5YAmtQXfJ9ukkUJUCGc5Vm6SZlsHOgWE9MGB4sQVH7BVKpYt5HYFwpg/AGYh7VzfND0Qyrh0bGLbiezBCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by TYBPR01MB5359.jpnprd01.prod.outlook.com (2603:1096:404:801d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:39:58 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::1b2a:85dd:34c2:330a]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::1b2a:85dd:34c2:330a%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:39:58 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 1/2] syscalls/geteuid01: Convert into new api
Thread-Index: AQHZrVfIuI6PzCYH00WLF3g6nELv3K+nc7cAgAH4JCA=
Date: Tue, 4 Jul 2023 10:39:58 +0000
Message-ID: <TYCPR01MB107125C380EC98E8F43FA0821FD2EA@TYCPR01MB10712.jpnprd01.prod.outlook.com>
References: <1688352041-4945-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230703043114.GA363557@pevik>
In-Reply-To: <20230703043114.GA363557@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YTJiYzhlMTgtYTU0NC00NjE3LWI4YWUtY2Y5YzNiYzJk?=
 =?utf-8?B?NDE5O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wNy0wNFQxMDozNTozN1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|TYBPR01MB5359:EE_
x-ms-office365-filtering-correlation-id: 81d7a06e-fc0d-4518-fce8-08db7c7b03a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f+uDI1Mpaws3PMi4mNVuA3WTRMFpXyNFZ/QgijulMjo+L6WXpj2PKlpMjvW5f9a94XLWIaFZ8KGCfPiI9ywFB+7YLys0/lxgorG9XRAf0gsfLp2jl1ion9CMLo4MV+QPQrpIyKX+1xhpv+PH6dtBjyZMlDqsMPswsfBPlaXm7IQO+nwuyPirPmBANsOlGKBpVajEaojg8QeN/To3MR7UTPi9xmxpG7ypQl63B321aehp7b4wufox/SaLauOdqxSa8P5gtyCoMl0TW+WLpVMFxrC//0UEKe4J72cn+Eo3CnZgGOWMfojvOoYh4hKTCAtOgB/ZNiP/SvD6Vo0bz2FHjNiFIpJxezYIhaEtmTGk4a3NMEleI3ew2ppriC0aK6HbX7jyn9RIqmpfckPCrwRu1CVgT+kXRth0HwnuyNMbqnp1pfr8RmC4nTqyzqZB/Og3iq6PrG0craiBRRdzy5EoMpGB82+/Lzinro/9OFv35MyKHJQNQ7jjuwVtTENjGByQ7539M0dA6CDF+v8Kr2pt34R1bwFxC1rafGJbXb8ErlIhKxRX3oMDJr8Vl+zwB2M88yiTbzy9OL3Y/2SftzQhXDdvtsdLJbeq26MgIkCFaju0zNkUr/08obyWzzyigWCi5Qu/GuCoDaN+DdTJ2jk5pw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(1590799018)(451199021)(38070700005)(2906002)(41300700001)(5660300002)(8676002)(8936002)(52536014)(1580799015)(33656002)(85182001)(55016003)(86362001)(186003)(82960400001)(478600001)(26005)(6506007)(71200400001)(9686003)(76116006)(7696005)(122000001)(316002)(6916009)(66446008)(4326008)(66476007)(64756008)(66946007)(66556008)(53546011)(38100700002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enA2elgrdEMvS1cxQTU5clU1azBUNkdWYXZqVDBQcW00UE5vSnF6UlVhRG9q?=
 =?utf-8?B?QktoaXlaSzVIa0FSTlNyVEVxU1ZMdHBKVWh6VVRGci9zcmxidko1L21EcEc1?=
 =?utf-8?B?SlRMM2QxRElpeHphL0tzL2gzYW80QXRSNHNkY2ZrdXpHVWtqK3BOSFRobWhl?=
 =?utf-8?B?OHdpcThBbXdibmljY1d4SlYzNHEwRC9GVHZIZVROWUJCeVJ0TVBXZ1FVeHoy?=
 =?utf-8?B?MFMrTXg5SVBjYjNBN280N3BOYzJJdnQrOHROcXBmQ0RucXJjVU1Nc0Z4SG9D?=
 =?utf-8?B?alozNnlHYVByaEFtdWVhTkhzTVdwWk56WWVmVkJkTnRGNU9RbExQTU5NMzNh?=
 =?utf-8?B?d1FWVnVyWHE1dEJHd2hzVi9jQ0Z2SUlPZ0lMWHlSOUNpaXRFNHB3cTJVQ3NF?=
 =?utf-8?B?a3llZ3huM1FJemJBRUlGbGRXS053SFFsMHdNTlk1d3FIRUpQaE5TQWRacjYz?=
 =?utf-8?B?SitiL0VDUk9BdFgzNFU2Z2txeStlakYyZzB1TVVMZ3ZmQlcybE81OGxxb2sr?=
 =?utf-8?B?UnN4SVdPWTVoYWdpaGtqc25TS3JJb0xKWEVnQXFTay81K2QrVTAwc1Nzb3M5?=
 =?utf-8?B?bVVTSDI3VEdEMlBrbkE2a0ptM3cxNWVQYml4VGpUQmwxWG9wVWdvRjQ3d2lh?=
 =?utf-8?B?WEo2Tzgvd01zejlkMHMxOC8wVmhqMmphUUVRUVVWQlBRK1o1aHVkMXZlZnZY?=
 =?utf-8?B?bGh1eEp5TnpQRmxieEJ6SDBMaDVteWsrSmpqMjk2QUthN0s5dllNemZZSDhy?=
 =?utf-8?B?Z3hsUzJKYVBLQ05HL0ZaQTdrVmRZQVFpaGZacExSSExWNy9SSGZDUUdpUWsr?=
 =?utf-8?B?blY4Tkx1Yjl6di82QVRSZWoxWCtyOHlrUzAxZVNxZm5yMFl2ODlFYjhNOUJK?=
 =?utf-8?B?aHZSZmZWTXBTaVlOY2ExQjVaVDFhaG5KYWdKNmpHWUVHMXhpejdtdmdZTE02?=
 =?utf-8?B?RG1ZdDZneHJzWHN3VGNVSHhrQVJMMkd1YjVJUXlVOFEvU1FuTEZDeVA2dGdV?=
 =?utf-8?B?ZldjYnVhWVVmU0lGaUwzY1Z2UldJbG5tU1RCOFJCdFpMN0NSQ1lYWmowVGpY?=
 =?utf-8?B?TlFOYmJ3NFdKRW8yc24rdDNmTm5uUWE5YVNnbW5rVWJ3L1BwL0UwTUozblNU?=
 =?utf-8?B?d01qRVBHbzFiSW44T2NRd1V5bVV3L0FKamdxUlNDRUtQOW5vTndJZGdYWVE0?=
 =?utf-8?B?WGxQTkcya3lJSTJmMTFzZHQxbVY0TWo0L3V6dzkyMkVLbXVtMEFxMmljVUlC?=
 =?utf-8?B?d1dheml0N2MyVzQxOTZqQWl6Zjlwc0owOFVSWmNCWWdHblFGcUZZZkZ1REpa?=
 =?utf-8?B?bkNDYlMzbVc0N0laTGVyRmlPbUlZQWU3aStsaTRtMWZDYVhIMU8zdDZzbjlx?=
 =?utf-8?B?RGtKSHBaaDdkRlZGdDBIeWk3L09wdXVQOEEyYnQ1aFJOMXRmOGxZcms4Y2tL?=
 =?utf-8?B?NXNGajFwQXBFM3M1bEhGNVVWajZHOTVjZ3pYaVpHaXRZOGJTTHJlNFUxdkRr?=
 =?utf-8?B?Qjhwa1k5b0FIM3RLYkdMNHdTcjFOQm9tM1UzMzRIT3BFWWphT0R0VGhGT2cw?=
 =?utf-8?B?djBYODJ2ajhOU0p2UHh6OXNITnk4SjdyVzRpWHhpVUNkZ083NnU0dUNTa3Bp?=
 =?utf-8?B?M3RuZzBXQkhxT00yOVVxckhlZjl4T1h0MmpVV1VkR0NZcERmSENkd2ZpaTZ3?=
 =?utf-8?B?My9xdkRMcE42emc5WC9MSk5PSzlvVEFTMnlUZlpGbEJHelQ1SzcyLzZaZEEr?=
 =?utf-8?B?TkRaL3g1U0RLZ0JKbk96dVBNRjcrZzJpeVluNWdUcUY4WU5POHVpTmRtd2Qv?=
 =?utf-8?B?VmNoM0Q1SExwTDVsMEdMWWlaL2k0Qno4QnZTSnU0WVhYWXIwU2VYWWQzcGh2?=
 =?utf-8?B?bG4xVHgzaTF4WUV0Sm1GNDNDQkd0NStMZThPYlVBWXNGMmYrVUw2YzVMc0hY?=
 =?utf-8?B?WTRITEFBYlFMcWtiRVd3MjA3RjdUQ2FCYUkxRGhsNFZqSVpEcGdLV1puSi9C?=
 =?utf-8?B?OXZvemUxbDhxRHNFRlRGREsrRzY4dDlNaWZYaWE3NE9LalBZKzhuS0FGZkFp?=
 =?utf-8?B?R3hPcFFDaUJHZzNNYXlGcFRvaU5IcXd1ZThmbnJTZVNQalptVXBHanAyMVU5?=
 =?utf-8?Q?tJ/0FjHruIhDHXNNv9j8BXOiJ?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z/uqQzE3PVSkQdxVNU75rVMvOBW8NnPPWxZV49SHs14pkZvSSVzQhXkU0KNqwNB8mMlfrZBWDly5KywWEwJpkS9Ds8ZleVdkcKlVYyIVIo0yD0Y0BKmPlvwXaatI77BIdAisvurcBZ48ih6UpqsT1VVUI1CB01BF+THwVG5kVSnyBe6Y4o5KgtVDTs9hoTwm/gEFSuM/1E7xfHCrEymu4w8ViIxhh6nSTGzerlTvqCzZh4SIB5ydUPoKJdNYBcD2vuc7b/AKLVpNfz+b+Uqt38HBe1cCOH4LNcKF7wtr2Ek0bHGibCX8rC3VJbXlnmZJyS9fpa6QX40n60kFmX+uQMKLiHCZIUGtJFAbD/+CBNGSa1RdvBX6a8lwHLHrdqVkXqYXtaG05E00tmqnPBTr9x6PdYSMAcZqqx2XrfOZsTtPmly1Uuo5hFDmDM+Ba7e2NgqR7ggbBLRwFwYibgkc3rrTg8oUmXzumCjnoBCcrUzuEsXG0qSf9CkO3/o1QwKtNp2hHC/fZkVaHxD6Kkklgivdal94Nd673/RVI9amFvZykH2nez4h00tdh6C5f4LXwgswQrGWEAz0k9EPZSBPrKvxLWUGM3TakPJAzyIy0dF35HTbUAEFjAchL70nPtfjjOFQ10a9Ovj2V+2BJUqbeRpFZNkjwQZMJSRa4BvG5NOSHs9ZKLhPHV8/D7EL/KLLIfTkUf7qIjnComFNO2f+4UetrCDMRZJ/WmO4p1PeyCz9AE78AeOoTW1K3DYxpWBtYaHMQOyKZK9cd9f2Ui8oFtScj24I6S+mBwInAjS5+ao=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d7a06e-fc0d-4518-fce8-08db7c7b03a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 10:39:58.6580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oxDeib7oez6o13ZFOCCReqqua8ttSt6JiyiCy5HRL8bnBR7/eJGW+GejvsBUcjz5oqCr4Cjq2ZAdV3LoZyP2i//j9P3JHpFKYy1VnruLlQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5359
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/geteuid01: Convert into new api
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwNCg0KVGhhbmtzIGZvciB5b3UgcmV2aWV3LCBtZXJnZWQgd2l0aCB5b3VyIHN1Z2dl
c3Rpb24uDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiANClNlbnQ6IE1vbmRheSwgSnVs
eSAzLCAyMDIzIDEyOjMxIFBNDQpUbzogWHUsIFlhbmcv5b6QIOadqCA8eHV5YW5nMjAxOC5qeUBm
dWppdHN1LmNvbT4NCkNjOiBsdHBAbGlzdHMubGludXguaXQNClN1YmplY3Q6IFJlOiBbTFRQXSBb
UEFUQ0ggMS8yXSBzeXNjYWxscy9nZXRldWlkMDE6IENvbnZlcnQgaW50byBuZXcgYXBpDQoNCkhp
IFh1LA0KDQptYWtlIGNoZWNrLWdldGV1aWQwMSByZXBvcnRzIGEgbG90IG9mIGVycm9ycy4NClNv
bWUgb2YgdGhlbSBhcmUgdG8gY29tcGF0X3RzdF8xNi5oIChtaXNzaW5nIHN0YXRpYyB3b3VsZCBi
ZSBlYXN5IHRvIGFkZCksIG90aGVycyBhcmUgcmVsYXRlZCB0byB0aGlzIGZpbGUuDQoNCj4gIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZXVpZC9nZXRldWlkMDEuYyB8IDg4IA0KPiArKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gKy8vU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAtb25seQ0KZ2V0ZXVpZDAxLmM6MTogV0FSTklORzogTWlzc2luZyBvciBtYWxmb3JtZWQg
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXIgdGFnIGluIGxpbmUgMQ0KDQovLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ICAvKg0KPiAgICogQ29weXJpZ2h0IChjKSAyMDAw
IFNpbGljb24gR3JhcGhpY3MsIEluYy4gIEFsbCBSaWdodHMgUmVzZXJ2ZWQuDQpNYXliZSBhZGRp
bmcgeW91ciBvciBMVFAgbGljZW5zZT8NCg0KLi4uDQo+ICsgKiAgICBBVVRIT1IgICAgICAgICAg
ICA6IFdpbGxpYW0gUm9za2UNCj4gKyAqICAgIENPLVBJTE9UICAgICAgICAgIDogRGF2ZSBGZW5u
ZXINCk1heWJlIGp1c3Q6DQogKiBBdXRob3I6IFdpbGxpYW0gUm9za2UsIERhdmUgRmVubmVyDQoN
Cj4gICAqLw0KDQo+ICAvKg0KVGhpcyBtdXN0IGJlIC8qXCwgb3RoZXJ3aXNlIGl0IHdpbGwgdG8g
YmUgdGFrZW4gYnkgb3VyIHBhcnNlci4NCg0KPiArICogW0Rlc2NyaXB0aW9uXQ0KPiArICoNCj4g
KyAqIENoZWNrIHRoZSBiYXNpYyBmdW5jdGlvbmFsaXR5IG9mIHRoZSBnZXRldWlkKCkgc3lzdGVt
IGNhbGwuDQo+ICAgKi8NCg0KLi4uDQo+ICsJVFNUX0VYUF9QT1NJVElWRShHRVRFVUlEKCksImdl
dGV1aWQiKTsNCmdldGV1aWQwMS5jOjIwOiBFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhh
dCAnLCcgKGN0eDpWeFYpIFRTVF9FWFBfUE9TSVRJVkUoR0VURVVJRCgpLCAiZ2V0ZXVpZCIpOw0K
DQpLaW5kIHJlZ2FyZHMsDQpQZXRyDQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
