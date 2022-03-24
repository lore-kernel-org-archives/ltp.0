Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1563C433EF
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 02:23:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58AD63C9803
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 03:23:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 590CE3C9447
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 03:23:44 +0100 (CET)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 361A9200058
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 03:23:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1648088624; x=1679624624;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JJRmhJvl63hgESDhtKEpumZSR2a7LDg9FqmOoE+UkiE=;
 b=NL3o7kkpBxEiX/5dc8JHylcBs0JweKE2U6a3tBKxYTREJJdVCW+ZaeAi
 5dIh8+dODRzmQ9V4CBdlkl6PloEVkj61QwsmWFJaZ7ezdpIDfhVh4hjbR
 lcy3Q4e4wDABiA+kxwrv8YewDi3eiQ6ZiVZUcbhYtzW4XjdQYha2gP1zM
 N4O7KuLg20wRCI+K0FtaiNwpavzsN0G2YHvTD5W9UUY9K5ew8pHW2U5WF
 OBnUZC74X9gM5f/OGnTCzp9HnCtnjOIYTCbSIF2YtseLYt8ITXztk+mTg
 oT1EzDuXqeplV1FnQqI0+dIk+iLIUuJJwQihG3zPjCBGYEN0/aRocbRpx Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="52358864"
X-IronPort-AV: E=Sophos;i="5.90,206,1643641200"; d="scan'208";a="52358864"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2022 11:23:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCChbCduj+skGmWCwPlphZf7nZ/h4+2R7vYb3/8i9FkxQS8n411UKxgLliB6bUSTOJO7G3tQ89Rk1uApHbspuSXGXF9anOhxWSb8sOhzfs9dROFmAoTHUDsBCnsF7QoTYN7MgH/f9KiPPxCv3xKRItxJRstPr7Ga6CDRALWUWWc4UJeuCsyHdQM6zxBYhm8PD+gDaZ3KYwzglPBHp2W8N510jW6KJfT0ST08YXEkPbaaXIsyfW291qu2N+Ro3L7/TAMhJzHBBp/0NgaAiI1boURRKmNo2aI/X20+peyC2lOOdhwCHMrhenFjB2aMFmrZy6dcbY0aNR2jaT92JbkrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJRmhJvl63hgESDhtKEpumZSR2a7LDg9FqmOoE+UkiE=;
 b=WtTMT8wwqcQsq6AN+LIpd4/xnz9Q8Ot3+X4BRKQuLXJ+JF4Wz1EM6eKlLgGG85qSTi8TA8WxBdI0VgTvkJKZbvlZAtaZpuvwY5onlc3iM7Ves5VAswaa6HrI+SCumEfxv/z6zo80Z5iyqnrSYl5mKgIeLJ7ifNfYqlkXVmzpWrNNXB0zeSRTedVB5sqHuu4i1jNpJoFE4mRrC5/Gh2I74Lra3DVcP53B6K8Im7VPKfmEYzB8C1Yj7C38FS90mZYvzlIWuGl9rBgBHqWyUB5BMihGDORcSJDvPm80+O/fpfiuuF9CrPeo57XFGUfwGb5x0CoAh+x5bUevSAWarxTy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJRmhJvl63hgESDhtKEpumZSR2a7LDg9FqmOoE+UkiE=;
 b=IkyNYqD/IE2srm7mORSBOmsbp59BNFdm18WJ6kFWZO+LVknJLeAUdiH+yfjONi7YOmX6OtvdIMX9rsQl7k1ohd8vWxs08aA3pq86fQcKHwgF0AR9SHNjekkhw0dB4M4YJfkQGNXBWISc5CYrFQSUsmOYbDj0Z5Dr5juiTmuKhog=
Received: from OS3PR01MB6134.jpnprd01.prod.outlook.com (2603:1096:604:d0::7)
 by TYCPR01MB9384.jpnprd01.prod.outlook.com (2603:1096:400:194::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 24 Mar
 2022 02:23:38 +0000
Received: from OS3PR01MB6134.jpnprd01.prod.outlook.com
 ([fe80::21f0:c3a3:717c:3ce5]) by OS3PR01MB6134.jpnprd01.prod.outlook.com
 ([fe80::21f0:c3a3:717c:3ce5%3]) with mapi id 15.20.5081.023; Thu, 24 Mar 2022
 02:23:38 +0000
From: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 3/3] syscalls/umount2: Convert to new API and
 use SAFE_ACCESS
Thread-Index: AQHYOpVTWiToRoAc9kuZeFSObrxxN6zNZYeAgABxoYA=
Date: Thu, 24 Mar 2022 02:23:38 +0000
Message-ID: <acce3a91-ecc3-b068-97e8-acb3bccec981@fujitsu.com>
References: <623414B7.6060004@fujitsu.com>
 <1647629747-13405-1-git-send-email-daisl.fnst@fujitsu.com>
 <1647629747-13405-3-git-send-email-daisl.fnst@fujitsu.com>
 <Yjt21XFn+8n78gZ7@pevik>
In-Reply-To: <Yjt21XFn+8n78gZ7@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e0756f9-c4d7-4e96-24a6-08da0d3d4e51
x-ms-traffictypediagnostic: TYCPR01MB9384:EE_
x-microsoft-antispam-prvs: <TYCPR01MB9384A1C5523926477C96E9EF85199@TYCPR01MB9384.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GlyBedA9ucem0hXkj13GjuIB4D2Ymwzcrrz9KipSVabAoXX/iMcZrU3Ig1Y6SunHZaId/wKNk1eS8YZNdCZGwFznZKQwlSSAvW6OJ62emflzc3NYFzvfDi0GOumofcOk1SnbibT7fd9A0GegiwdFUtg8/bS3llqIL4kAJjwZ98vPTtEuKxyBvaf720ar8/LNQT6nIxVU83rTSeUc3Kg4yb+50DQ0w//2usd03POT+r0tPTHHxypa8amnwEsnpYcMpZltt3sgvAsnDcjnwD/shLnRtPH5KFTJBLBRKdTdeDzIGinEcZnmsR4ozwqMLaW0z8KB7bm7evvFL9tkIxkV8gAWr5UEbn7KgDstChw5ZAUggpf6g6CCS9NCLKKXEMp4SOrbsZSl7pTC/buaTEd0P4UbJ0vWMjW6k6c3NESkNeNS1A3pwpXFp9wot9FkIJaOJ/MrMbZHzTc8YKi6dDJTAgMS98qJKnu8bm6FvSM84EIfUx7tOPJ8SFpzGn0yWB01y60BSt6iOwJdwM3XNhdyyZFr+yayFxI0VI7bQ8CXmJkGgfbTAW+c3XHdOM8RxZZZdLxu45tj0VQqVavCWJYeIhAkhSef3y0vr3kj46DzqgMEqIlbaHxmG43Qs0hVHHsox8hPutJhpszC7DgCnlR0R3R7GD6wNWsoqRwz1z2Tip8w0NEcjldKVLgH5nCbpVN0bGAccr60WVpcM/JTy/mCowkzI6NH5XTKxwzZYbmSItGRrEXINbikTRJ3gA3cVrjB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6134.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(82960400001)(122000001)(38070700005)(31696002)(26005)(86362001)(38100700002)(6486002)(4744005)(5660300002)(6506007)(66946007)(66556008)(4326008)(2906002)(316002)(66446008)(66476007)(91956017)(64756008)(76116006)(8676002)(508600001)(8936002)(36756003)(71200400001)(85182001)(2616005)(186003)(6916009)(31686004)(6512007)(54906003)(2004002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OThpdmc1M0VrWnJiM0lScWtVMDY4MktJM0NEa0hYZEJsOTYrMktGTG54NFdq?=
 =?gb2312?B?dWRnNzcycXRHUk9qVE9UZllQZDdnQzVTbmxhZFNxa1ZOMno3bjZmY2RxNDdQ?=
 =?gb2312?B?T3NpYVZsTWQ2M1M2SkdpRWJqY0h0bVdIVVdyaS9qaWsyWjIzcWU4OU1zaXc2?=
 =?gb2312?B?ZUVHVi9yWlBYVUk0MTJadEtPRGd2WVp3cjcwOG9vUVZ3cGdlWFdHZjhIZlgw?=
 =?gb2312?B?NGNGK0VnRGkyUnptamo3Nk50MlNaa3UzbjZvYXB4aHZCeEdNbGU2dHRjKzgw?=
 =?gb2312?B?RjZ0eE5GdG1PdnozeWdSQkdFcDBnOEh4YzBNR3pTb3ptWStLeWllSlMwYkJq?=
 =?gb2312?B?NlR3WE93Nm9tcEpGMzh0eDdweEpwUDBBbUgzMk43N0lZL2ZGOGV6bWc1UFJU?=
 =?gb2312?B?YVRzdHdSNUVTV2FFM09nSWNCNWdFRk1BQmFpZXUvY1Z4dnROYXVpSlFXdHhN?=
 =?gb2312?B?SFpxWHRhMGlhS2lvNmNQRnFKTEpYd1FRYkJubDdTdHlESkhERDI1L0Q5MzRN?=
 =?gb2312?B?MFlvVVlUQ0JMbFJFTVl1RXhxdUJUbUZaRVBRaW9UZk1DbnRkYWZDeHlPSlVV?=
 =?gb2312?B?eDdFaFEzVlgzU1NhNDc2S3R6b3RPRFhWTDRhb3pPZldMcVN2WkN3RkhrT1hi?=
 =?gb2312?B?NndUOEhpK1oxWUViWDUxU3VXMXJkV0JMSnVhKzJLY3BKRkRyYmVBTFJRTEVZ?=
 =?gb2312?B?Rm51bUZSYnVwWXJvTmxORlkreGNGSFpEUEFWTVM3MkFBcXNJUXdOb2ZEb3Y0?=
 =?gb2312?B?Q0NIamNZcDdycWhnSUE3ci9EeitxaUZWNWlVRi90Z29FdFJoekdNWldzekp5?=
 =?gb2312?B?LzArTVR1OGt2bS8rcFFSRXRlQ2xXQ1NvNnlNeDFXaGlRZGNpTW9TM2MwaVpZ?=
 =?gb2312?B?M1RVeGNiK2krSVJ3RW1GSFVIeVVJYlU4cXRmVE1vcTNKWS81WUF0TTUxbWFV?=
 =?gb2312?B?Q21CZFkvSUVZVnB3czRUMjYrcVlHNktBUmJXZXJ5aDZ0NVZua1lSTytoQVZq?=
 =?gb2312?B?T3B2RmdNNExxNCtJY1BJRkJVa2xRNTRDcEVYZkRweGVrU00xallLRkc2WTJn?=
 =?gb2312?B?VDRzekR3MWFQOTlRMnRFN3plYVpvQzZtWG5DSW1aWU5IcEtVMDZXcmhtSE9H?=
 =?gb2312?B?czFGM1IxbmVybmswS25sY2JjcmdBMGM0bnlYL1NwS2hVMWdkV3U3bmxQbTN5?=
 =?gb2312?B?ZG9qODA5L2pnQitBTWdrblRwYUxFTGR5UklPeWM3cjI3amp1eGE2dmZBcFFT?=
 =?gb2312?B?KzllVVJoQk1wTU9KdVM1RWhVYS9KRFFXVW5UZzBjYmtPYU8xQnVIYW9NK0Nv?=
 =?gb2312?B?aDB5MUwrMGd4bjN3VkZQdkJET1dmWTFwWHdTR082NkFCR29ZN0c5bkpOM29l?=
 =?gb2312?B?TnMvU0pNYVFhWEgvaVgyMGxzQ3A2TFZmZm0rci9HbGtlZi9xdzVodWlndHpm?=
 =?gb2312?B?WGdpSUpkVXJLNVJPa0tuWThQSy93ODQyT2EvY2s1eVlmQmdpWC9VclpCdlNM?=
 =?gb2312?B?MGkrUktscHM0Yll1SmVVblA4Z2Y3SkJSUmpPanpCUXl5OURvWVIvQnU4Yldv?=
 =?gb2312?B?Y1ZtcTliYzF6aGY1NGZLMTducEpicnZwbGU0dzNaTEZCWlhmTVJEcUJQczdq?=
 =?gb2312?B?RkdrL1RKRnhIclc5dWZMTHNHN3VNSTY5NG9jcHQ2VjVNYVR1M1ZoTXduOHB0?=
 =?gb2312?B?ZzNKNzdXVlZsQ1FxQjlPeWhMaXE4b1VFVytlQko1N0hGaGZyUWJHc3BDNDdn?=
 =?gb2312?B?MDczcC9iVElxOUVCWHhQMG80NTUyR1NmRTYvSWFqMjRjZkZ1Ynk1ck15YXRD?=
 =?gb2312?B?R2U2MjBZNkVzYUNuK0FrbEw2NlR2dW05S1dteTAwUzI4QXhMQStEc2U1Yko0?=
 =?gb2312?B?aXJ0QTZ3SDYrQWNHVThLaEZIZEM3dmlGMjVOTlJHUmduekU2NlRmWWZqcnZG?=
 =?gb2312?B?UEExNUdqMW9mSmdaYnEycTBzYTM0bEVwQm1GZFo2WXVWNjR2Rng0czU0L3hk?=
 =?gb2312?B?V2hXTUNzaHZnPT0=?=
Content-ID: <AEA72C80ED4E4A40806B319567284647@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6134.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0756f9-c4d7-4e96-24a6-08da0d3d4e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 02:23:38.3672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQfbt0E/58B3LIviYJcsQUnNEl4wrsga29nLb3dS5fw0JPfSQLQMmbQfirpXbbufOjV3qpJcTTECdLOZmq48Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9384
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] syscalls/umount2: Convert to new API and
 use SAFE_ACCESS
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwNCg0K1NogMjAyMi8zLzI0IDM6MzYsIFBldHIgVm9yZWwg0LS1wDoNCj4gSGkgRGFp
LA0KPg0KPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bW91bnQyL3Vtb3VudDIu
aA0KPj4gQEAgLTEsMyArMSw0IEBADQo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAtb3ItbGF0ZXINCj4+ICAgLyoNCj4+ICAgICogQ29weXJpZ2h0IChjKSAyMDE2IEN5cmls
IEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pg0KPj4gICAgKg0KPiBuaXQ6IGlmIHlvdSBhZGQgU1BE
WCAoZ29vZCB0byBkbykgeW91J3JlIHN1cHBvc2VkIHRvIHJlbW92ZSBHUEwgdGV4dA0KPiAoaS5l
LiByZW1vdmU6ICJUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTogeW91IC4uLiIpDQo+DQo+
IENhbiBiZSBkb25lIGJlZm9yZSBtZXJnZS4NCkdvdCBpdC4gSSB3aWxsIHNlbmQgdjQuDQo+IEtp
bmQgcmVnYXJkcywNCj4gUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
