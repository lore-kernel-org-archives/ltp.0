Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE4CC433F5
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 04:29:57 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A326113E
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 04:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99A326113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 163833C78DE
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 06:29:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D53BB3C185C
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 06:29:41 +0200 (CEST)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4AE392003B8
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 06:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631852980; x=1663388980;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WxDza4K/jcP4pRkN9uvcJCN7j/uAtZFWIYJhQRnMDyw=;
 b=GUsW1dxlP42GvP131a7Rdr/3L/E86Pq01RFBrj8i+yxR+3TtukmH0HPr
 DQr30vqie0htH2yIz57i1Y6mlncM2wVCy35gk8WVnNjE0hBLmGK7PmAfS
 CRVCQ8NBIgXX/wCF/z2BrGDMMuL9hRatQFrRcGtjK8z5CYELRfLKaoO9f
 TGDAdHeHCdzzd4GEr7XRmx4qAb6RR3V/sKB8QUov0twwVzuIKhyDFNHwA
 x/eC0m1mofqmo2PjIjOrXKFlNpV2lWaJCQVfZYQ0Lm2DtvGvH0n8jTIoA
 dPB294jTvUuMD7WLcKTnZTz6LXEMQxynYc7PscQcnebiejNu1oYJwfzcK g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="47475149"
X-IronPort-AV: E=Sophos;i="5.85,300,1624287600"; d="scan'208";a="47475149"
Received: from mail-os2jpn01lp2056.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.56])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2021 13:29:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5w2Ekl8/0UupPMTqAp47PWqwXxtNhlxecNwKDTzlwjG/P45DN1sYwpRDqFqOA3fajBwaDH4PzAwc0bI12WZlu9VSk5ui44Eh878y+nEFiG/sZ/JT8yTOTN19fGybw/xL582058nFFUChbXINrXeLdMvnjuctN24a24lpZNQUcPIKGFRGBmqV5SJSVxoWvJtEA/D16z5irDPITop1quV0V5lWTq6ZgC6V1xMuu4zRUReDA+SyAdUYfiUHnQZ6JKeV4sjbMOMv1S4X6MVDgOSJBrUeR4+Dqcs2RECAEXg1BDDkxxBlAYaawDyovGNmS6ItxgOJxGEDXaBnAeMFqD2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=WxDza4K/jcP4pRkN9uvcJCN7j/uAtZFWIYJhQRnMDyw=;
 b=jp9koRzwD+Nml9pVJSbUhdI4YrkmnumrKrUFz68PHzkaa30oovb1VnCODU/H3T/KwOZx2pfd3ii2v60iAF4vIncujoPg/qg2pVfitt1MKYtPNAApmomu2pIPfMbNaQJimXlnnQoNr5+JdVIgqRZx6Kc7YOaEjCFSDMelAJRp7cE55MiCMzLQE/9swHGzIwYuK2fTJ4AceEq6nnh7ijSZoLWGNdBKBw8z5jiupnO6zXUqDANo4uXxT2EMH52UrVdveJB5VnbZWahE/8GE1DBet0BWx9ZA+xS/roiacfCNMV0lL5otklwTvEK95oElvW3+gwZO/pLnMJVpyLpaV34ELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxDza4K/jcP4pRkN9uvcJCN7j/uAtZFWIYJhQRnMDyw=;
 b=abeMIcA0/+x4QLFPoKS42qbfPDkxetHCcynZBWOZzgSXBFFUUOP3EUZhYr5YF3tG2M6qU2qbJlGaPZkzHanfb0o5wV1GI+dBTkzHxu8HHZCKbyxVIUwWeInKC7rx5/m2AZfmmz2RskSkKYtKu+5LeGXDWsMEB61BUIOMkyq8S+U=
Received: from OSZPR01MB6454.jpnprd01.prod.outlook.com (2603:1096:604:f6::14)
 by OSAPR01MB4065.jpnprd01.prod.outlook.com (2603:1096:604:5e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 04:29:34 +0000
Received: from OSZPR01MB6454.jpnprd01.prod.outlook.com
 ([fe80::7186:2899:575a:4e2e]) by OSZPR01MB6454.jpnprd01.prod.outlook.com
 ([fe80::7186:2899:575a:4e2e%9]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 04:29:34 +0000
From: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>, QI Fuli
 <fukuri.sai@gmail.com>
Thread-Topic: [LTP] [PATCH v3 5/5] syscalls/dup2: rename dup205 to dup204
Thread-Index: AQHXquigMypKUeZ9o02+NohGA+czAKunkDgAgAASLBA=
Date: Fri, 17 Sep 2021 04:29:34 +0000
Message-ID: <OSZPR01MB6454365236CCEC704143CB55F7DD9@OSZPR01MB6454.jpnprd01.prod.outlook.com>
References: <20210916104933.33409-1-qi.fuli@fujitsu.com>
 <20210916104933.33409-6-qi.fuli@fujitsu.com> <614409AA.6080809@fujitsu.com>
In-Reply-To: <614409AA.6080809@fujitsu.com>
Accept-Language: en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjEtMDktMTdUMDQ6MjU6?=
 =?utf-8?B?NTVaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1jZDJkMmE5Ni0wNzZmLTQ2ZTYt?=
 =?utf-8?B?YWIxYi1kODc4MWM5Zjc4MmM7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc56caf8-92c1-43d4-1fb1-08d97993c051
x-ms-traffictypediagnostic: OSAPR01MB4065:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB40653AA5A7852F8B1159DE4EF7DD9@OSAPR01MB4065.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:221;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dFXtxQkAWt3C5jJCYA/dSDPya/p7l0yy03bINioRzf9O4JxnT+Uoc7A6KIwdLdDP5IHsdc/8yE6knj+WPMp31SJbHlLjC4qpFK8MBaa1TzIcid9B9wPU+c/LTPgPPOC0MNNVJ9HkBTTYukj24r6rXPgod6tP5dnrgBCReXOkBAWgT+kyJu2UZvck4XM0qvFn4b9PscFeZKhWi4X1n0Jz872tzfv4BSnJ56JmHFppew591BK2Lts2F6qYcJGLE5oBtZ8Yo+amJcqpqm4hjBrWzSioo48sPxnF4IsNU4DtUCJqHOEfw8dFEID6c22Nn3Voh3oSwXB6lODysO58eAcll0B+ahmSN6o99o7QFL3PeeROxujgVD1LtRPgD2K+yUXSaPh42l2UWfp2DcCmBgaDhqb6fRPjqZXraPMY8YgbdB0vlhWXF6vHVYL9taperSmGApDLtl2p0MOxHBTVkMwi3HysDauCSpa6hbF/kvK5yXTqaevxMugcG99InzrLwJVtYpD9RsbFK4dxzrhJ525qwpKlikseAYt1zSbe7o6tckkj98JflHgezjmrTBTH10hcrCIQIwAYNqLeWG4Q2e24pee7hr0Od7yJObvw0UWWtxuG1+6I6GGbcXTYILJr+HkkFA7FruB8TbVXlvaxViNv2nOzDHKBcLFVYoknQDWBE6oGqU6AM8r7az/VEQLAAT57BxbQJ570TM6x2GJM4LUwiw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSZPR01MB6454.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(478600001)(4744005)(38100700002)(8936002)(26005)(33656002)(55016002)(5660300002)(76116006)(85182001)(9686003)(122000001)(4326008)(66446008)(66556008)(7696005)(186003)(8676002)(71200400001)(83380400001)(86362001)(316002)(6506007)(38070700005)(2906002)(52536014)(64756008)(110136005)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE1zOWFnVGRUSWwyZ29ObE1zRGh0ZFBGNE55MUtqSUhIckFCTWJIRE5HLzlW?=
 =?utf-8?B?NW5jdmIxSDcvdXJ6WjVzY3BoMkF5NGNGcW1KTHNJRzFuREFGZzFodUxFWk9s?=
 =?utf-8?B?UDVoakdSQ1R4cDVDdDN2WGhUY2NWZFJJUjAveHFZQmNTcjFLUkRVeGU1MnJv?=
 =?utf-8?B?SUpGdGVVVXdNN00zTHBjMU95Vm9WRmp0VmJNZ1JYZ2lXS0xNMkRCdUY2VDlw?=
 =?utf-8?B?cHE5SWhJSFYzai9xMnRUTG9GVHFLdExyWExVUGZlTUJnT2JPK0dqU2drMVFu?=
 =?utf-8?B?MFd5dFZtMlNjdDBCYXNxN09kMFJWdlIrSGxrbnVNRys5ZHlsSFRzdlYwdlRZ?=
 =?utf-8?B?QWxjT2dLTmYxQkJITUdGaXAxS0N4eTFIVllLMzY1dVVnd0twaXoxaGt3NlQr?=
 =?utf-8?B?WkI4ZGQwNFZDaHBjRHdWVjhyZ3dYZjlPWHVucm5NcFh6Y2Q0N0VNRXJwU1JI?=
 =?utf-8?B?bHhyeTlocWNZSHpuUEF1cHJIM294alFoR1QxcFd3eTNtTUJyT215WG1YVE96?=
 =?utf-8?B?MlBhbzZaRWNGbVkxZTlLekhCcGF1b2pzaTJsTWVGMUVnRjlHbU03MGtjVHkv?=
 =?utf-8?B?Q0wwRkwyWEZydnVKbGI0VjUza2xSb1VCb0N3ZytQWEtZLytIVFRlRHp6cDZT?=
 =?utf-8?B?VE1jK3IxdFVJa21sekptSGpFQm1sOW41dGt2VXNwZTQ5SFRoU0loc0xPZktr?=
 =?utf-8?B?VTNjSHUzRDdvQ1UxWjA5TFVQaEJraXZ2L2FSclFZcWt3WTRWV01lTjJ1ZWFE?=
 =?utf-8?B?ZUFmeFB1by9zcVd3dVhzMWI4dndhNkZrc1NxSDZuYzF6Nk9LcjUrZSt4bHlD?=
 =?utf-8?B?bG9TaDZsRXB1QzBIeXNyTldBaWUzY2dDWmhkbFZLbEgzdllJV3ZnTTg3YVlL?=
 =?utf-8?B?Q0J1bFUwUkhBVnlwZW9hOGphOCttbDN5WEo0bGlISHMxU3NVMjA0UHc3UkVY?=
 =?utf-8?B?Z1hZdTNJOUZBSEU4ck00VFB1Q2gydFByRFdWM2ZWZ2UvaVQ2WUE3RTRTTGRh?=
 =?utf-8?B?MXhWQnRJRWpiTm9VSEcxZmFHcTd0THhFb2NsZHVkeS95UnpkNE5PYzlyYjVa?=
 =?utf-8?B?UkQ2SlhmaXU2VkxSRHh6M2xvM000VW5XQUZQVHRsVEdlWE1MUnoweU1KZHJO?=
 =?utf-8?B?OHUwazRWbU9wVnIrNFY2WVJpb0hiQzhSMDBoTkVDUGZJNk5MZko3TjQxRjVR?=
 =?utf-8?B?ZnVWdnB5ZlJLUHRJYVNrMXR3Q2pYVW5kTzdkQ1ZlZk9qNVRORmp3S3NYTzY5?=
 =?utf-8?B?Y3B1TFdMSkEwY1ZzRXlKUVFxYXB6dkNhV3RlUGZZaDV6dDBBcGdKNDVhVWd1?=
 =?utf-8?B?T3NjdFpDaGRKUEpIRWlCSnRjMFIvbHhyemxPQkFWcVYvRGNyZXVhMlQ4elk2?=
 =?utf-8?B?ZjBobXFORzdZb2tnYm1oMUhLMUVIT0M0Y0pEMnpqYW9OcXlTUkVMZHRsYkIr?=
 =?utf-8?B?aVNNbXZGcXF4MTFnWTdxOUxSSFd0VDNhR0Jqd1V4czhFKzV3eXFscnJ1Z3Fp?=
 =?utf-8?B?T3g1NWYwdkJPcjFWdFR6ZFk2U0ZRc2p1OGJiL2tKUlkxVlgya0l4cnowYllJ?=
 =?utf-8?B?N1NDQ3dUd1U1ZTRrQXZPSGpEZVhlWTR4ZEVuNWMxYUVjNndVVmd6dHFZWnUr?=
 =?utf-8?B?Z3BsYW1Db2ZpRk9pSFVVRG5kY2dRUkd3NlBOalMwK25FWjVpZ1hhVXJUS3lN?=
 =?utf-8?B?SWVtS1h4VnoxUDk0MDVwVUlHY3UySlBiZUN5ZzIvWVhiTDFmNWN0d04zSE5q?=
 =?utf-8?Q?4NVG6Ql1AEDBrOqjVc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6454.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc56caf8-92c1-43d4-1fb1-08d97993c051
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 04:29:34.2704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUA7IGNUIh8GEfVab2aUohLOzZQ6ZmPTluoGK2ntMUSBZe6aZbP2h0PtsAU/BOlttOHqvxPODcpRavmowEQZjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4065
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/5] syscalls/dup2: rename dup205 to dup204
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
Message-ID: <20210917042934.LS60hANM8GYHspbJvwMbRh-nz7MdVXE0kKP79y9BrGo@z>

> Subject: Re: [LTP] [PATCH v3 5/5] syscalls/dup2: rename dup205 to dup204
> 
> Hi Qi
> 
> > From: QI Fuli<qi.fuli@fujitsu.com>
> >
> > Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> > ---
> >   testcases/kernel/syscalls/dup2/{dup205.c =>  dup204.c} | 0
> >   1 file changed, 0 insertions(+), 0 deletions(-)
> >   rename testcases/kernel/syscalls/dup2/{dup205.c =>  dup204.c} (100%)
> You miss .gitnore and runtest/syscalls. We also need to remove dup205 tag in
> them.
> 
> No need v4. Maintainer Will remove them when merging this patchset.
> 
> Other than some nits(useless comments, empty line, whitespace), this patchset
> looks good to me.
> 
> Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> 
> Best Regards
> Yang Xu
> 

Thank you very much.

Best,
QI

> >
> > diff --git a/testcases/kernel/syscalls/dup2/dup205.c
> > b/testcases/kernel/syscalls/dup2/dup204.c
> > similarity index 100%
> > rename from testcases/kernel/syscalls/dup2/dup205.c
> > rename to testcases/kernel/syscalls/dup2/dup204.c

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
