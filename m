Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C232AC433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 09:20:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CACA66103B
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 09:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CACA66103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D51E3C8842
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 11:20:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECA9B3C1D24
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 11:20:19 +0200 (CEST)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 357B32005CE
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 11:20:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631870418; x=1663406418;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=XrP98mF9XfIS0Z6gSCPLU1K8ABJTmAPGJ8o5sgcx15o=;
 b=jJ5BZRL1js3QU6LcbMUMwf5BlsPpa1CfGmEzt39P14bB2/NBZvuRu9+R
 cbeeCz/MX99EGGns098Dbb36V8mzQq/MTaCD5ZFQyfcg0IUe1n3AADn7x
 hv5YqYOkrBCuw4/ef5YuQgKY21SOn+YPjCFuwRzccjP3R68mZCC7e6r94
 s7gQQkuTLSnogwLqQxTDtMc/FB4CiC/FbsOqxmWqKOvdpSEwU+3PytkC4
 2iZc6AZ9XbiYtOsDWmhu77LYhNjunifuaeAZhqzik+w/rB1uhx/SzWZ3b
 4I+8tfe4sGR7+oy5nrifCdJCVf8NnQW7LGfunjaHxyaWzRdsozMJsAprs w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="47575554"
X-IronPort-AV: E=Sophos;i="5.85,300,1624287600"; d="scan'208";a="47575554"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2021 18:20:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJiqyDB5rG6TrA/Us35STRAH56V/fKDDZoYvG7y1T8BYlLITxiYRoqyyBS9z5ky3xlYkk8SztRakLtpsgcY4L0o28h4Obk+2DE77ZA7Ykn6gzDSugMEB+pRs5UAsFzs7v+PzeKcZ53FIbX+kyyWDI2M8FDj4CVjdUQ/XoCBCExF3kUGkKl9zxYqK98rNqr1eFwdgsQVFWz6V+lBiHsk5gDQ3CYin7/1pw28VzXvV/mX52Tez6+vK+OSGCp0JhDH84wUXvT41iG7ty1fxKGpmHyYEfA3R2o/dKhgE00rriDZtmvioc2IIjuhDfgfXpGrTVQzx104MiinOiUsjAisQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=XrP98mF9XfIS0Z6gSCPLU1K8ABJTmAPGJ8o5sgcx15o=;
 b=GXycqnZCrHk3sxSi810nIeRtaj4DYlenPbQ3EuNObWWX+tcoOzV1xMGRLN7zRyRS5Sr1hfTk+A5hYbNtrO2JLDTwYKCmC59YB1y09xCxUsw2FLUMSdVdNKMuPat2imEga3/66mtW5jhogIyze84wEBth9/EdQrEolysDum6uXvWMgsDnnQjngQwDw52Qt23vYvLKYOdvhrGOQatPKphVam2CYP3TNQuSvSCMz7qVO0eZRt41GB67ffwnRvwwKzgb3VY8HlGqG3s/uNM8gdLV1TUyiCaNNvbWLnAqlhT0p2vg0m9YbHw2qrS140Ru4Krq5MWSMrj/3+8GCmCWZvie0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrP98mF9XfIS0Z6gSCPLU1K8ABJTmAPGJ8o5sgcx15o=;
 b=gJGHNyO8JgfWqZnRpa2exLH6K1V42znxRnMS0TwoXm7H2XAay7POCfQH4oLSgbDZcn4Z9skveRS5LK0ykc0Y++kAExroh7M/lhpZeASynjUDRATRcYXY4WKhXd+gBSHRsIqVzgzlMKoqcVk90mtk4aw/IyIff1K3QcgMh3mam+U=
Received: from OSZPR01MB6454.jpnprd01.prod.outlook.com (2603:1096:604:f6::14)
 by OSZPR01MB6456.jpnprd01.prod.outlook.com (2603:1096:604:e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 09:20:12 +0000
Received: from OSZPR01MB6454.jpnprd01.prod.outlook.com
 ([fe80::7186:2899:575a:4e2e]) by OSZPR01MB6454.jpnprd01.prod.outlook.com
 ([fe80::7186:2899:575a:4e2e%9]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 09:20:12 +0000
From: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
To: 'Xiao Yang' <ice_yangxiao@163.com>, QI Fuli <fukuri.sai@gmail.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, "xuyang2018.jy@fujitsu.com"
 <xuyang2018.jy@fujitsu.com>
Thread-Topic: [LTP] [PATCH v3 4/5] syscalls/dup2/dup205: Convert to new API
Thread-Index: AQHXquibpEAUptEiR0iuVg62Z1aHE6un6LCAgAAEQ5A=
Date: Fri, 17 Sep 2021 09:20:12 +0000
Message-ID: <OSZPR01MB64547BE94AEC979C8E0AFF1FF7DD9@OSZPR01MB6454.jpnprd01.prod.outlook.com>
References: <20210916104933.33409-1-qi.fuli@fujitsu.com>
 <20210916104933.33409-5-qi.fuli@fujitsu.com>
 <bcc00ba4-2e7d-8ec3-2856-6cde6d45b587@163.com>
In-Reply-To: <bcc00ba4-2e7d-8ec3-2856-6cde6d45b587@163.com>
Accept-Language: en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjEtMDktMTdUMDg6NTI6?=
 =?utf-8?B?NDZaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1kMGE4ZDFlOC1mY2E5LTQwMTkt?=
 =?utf-8?B?YmJiZi1mYmI3NDkzMTBlMGE7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f053f53-e5c3-474b-40a9-08d979bc5a58
x-ms-traffictypediagnostic: OSZPR01MB6456:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSZPR01MB6456307C6CE6E360342A0B4EF7DD9@OSZPR01MB6456.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywLOPFt62hOQ5+nAcltgMa/0fjl9I9xxN9jv8dtMvbzDD72XfVrPTYglUA0CiTYWjZPYoxxXq9jREQQRlMuPBrR4Gqwqdy+KNU2m3JxMLpjtVeNCwND9MO2Wwd9yk3ylzHjd9Aok3fTRKZuccBnSZangyN+kSnOSGZf5Vg18i1qdD1cEERQ4Eou+x70b6Qt6oEROIrmb3BncifWfhTqhYjQxEGKDlSqTscCvzkeEa+p0x1FB+rnZyzclDNr0SDUzerekxU0gSl6Ha2A1k3MbwJWFHgS0aPY3El2jm7Whk2VNYYQZcL3dYLlODQEHHhgqN1TK6008yhMxsCJcg+T7KeiI0hjwn3Fjcmv0g3Lr051z0ClF3CxX31bAjd9IuL5TphpaQSqn3o1BlyfnHmNDP2XfG0bNpBzvdgNz1ffjEtykTLZLdHAXWMBQFZKaDpx/5Wuop6kfqG5tBF1xER3tsNG0Fty27IoEHsxyyoZZl1vFoOeYiu+on+R6qm5f0U3YiS052U81wMQolXel/SxO7Bo5njpGIRRUHfHTQdDDGsSfVNs91U4B57vSXfXghqS84TufHgxpDekKwVCsXqmj0+WACyPujTNWWOR01+AsInf8orJGd4G6XO+G6XY8xyWHIUPby2ZCemNUcPpTvqhda5IN+26gAhU0B6OubG3zACMPK6kTEgGlSde0uLv6SIvNYZMZ99GtfHTtGrLAI1018o/L3a/RXwoXGsT3mOx3XmA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSZPR01MB6454.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(110136005)(85182001)(186003)(122000001)(316002)(52536014)(38100700002)(6636002)(38070700005)(7696005)(86362001)(478600001)(8676002)(8936002)(66476007)(71200400001)(5660300002)(66946007)(2906002)(53546011)(76116006)(33656002)(6506007)(66446008)(9686003)(26005)(64756008)(66556008)(83380400001)(55016002)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkRCbm1QbDk1aHJvdFlXUzRFdW9SMDBjcU9BWU14ZDdpSVd3cVVkby9rbFVF?=
 =?utf-8?B?ZVliNWJwR3hTS0trOFZyQU5iUGpnc00yNXQvdFBiNnhCWVYvcVBKVGtuT0N3?=
 =?utf-8?B?a1pXTjduZVVpZldIdGxMdlVBeGNPclMzT3hhRFpHQWIvNC9wdnU2NFN1MWNY?=
 =?utf-8?B?R1VzcTYyQzFLSHZHS2RSQWh1QXdDTTFIazJzRDdIM25KS05Yb2ttQitpT2lF?=
 =?utf-8?B?cFB2STV5SmYyS2hpRWEyZ2J1aHZBMzByZnd0c25HdlVBYmVXQlpIVktDWlFr?=
 =?utf-8?B?MEJET1BZUnByZ0h5dURDZHlPbUN3ZnV0UHRpVkVzWEZqZHRESGZWaVNWTE9N?=
 =?utf-8?B?ZE1GeXJROGZYNlpiL0VtUVZMb2ZFaDU1dzdBbDVac2xhdDRsZE9HU0doc3dr?=
 =?utf-8?B?NGsxSGs5UitYZTNocUhFWjFQTDhjM2hhNnAxNzJFNUtMQTY5dEl5WUpIVlZz?=
 =?utf-8?B?cUZnUmdTN2F0bitreXNDZkgveUFtcEpYbThlQmxHc2xaN2hOQnowSkZqYVhK?=
 =?utf-8?B?MStTTEthbEpWWFRDMWQvZm96S1JzUVVKSFB0Tk4xd09jODNlOGtyMVFYTUZZ?=
 =?utf-8?B?cjN0Z3VHQmc5NDYwYXA5RS93N05XSDhXUnJncW5xMXlhVC9IaGZuYmNsWUcv?=
 =?utf-8?B?SlN1SmJWU3daUTFIRm1pYTY3d2RaTmdKQnZxNWxpdHBaenpvaTUyVkNOQWRF?=
 =?utf-8?B?aTh2ZU1MaGtkbThvUWVYaXVhTHZJMUJ5cXQ3ZEZIRmhBa3J5b0RXcEI4MG9s?=
 =?utf-8?B?OTZqdDBlUnZZaVZtT0w4WVpnbkwrMXg0SmIxaGZDSTV2bW8zYWlINytVODZz?=
 =?utf-8?B?Uis1WTBIRStuRkJrQ0ZOeGVMK3AyaXJ4NXAybGtjN3BrMk9ZcDhJZUxjdWcy?=
 =?utf-8?B?L0xxMU1mMkVLRGZCZXdqT2RlYy9ZOVhjNzFFblAza09wOGtFekRlakgzdmRC?=
 =?utf-8?B?MVFmUDRvYVJhZk1sTys3M1VQRjY0cUt6VGlwQjh5ZDVqdW01cDBvelBlemRa?=
 =?utf-8?B?RnZnQTd1bGxBUGtqbS9TaVp1b3U2Q091dnN2WWxsWGZuSWR4dmZEOFBIZWhG?=
 =?utf-8?B?QVQ4bnY1elNhdzdLQlF1T2VQNDJhQy90VW5TdnZGdWhRZ2ZLeWdnbmJTWEIy?=
 =?utf-8?B?TjIxc2Z3c29XT3U2S3FaaWlIZnBIT1dTc3ZLT3l1cDgyc1d3UHFWSHQ1Vm1p?=
 =?utf-8?B?QUg2VVd1UUNHU280eWc5RHV0OG80MWplY29RQlFOUHhEZllFT20wNksxYWs4?=
 =?utf-8?B?a0pSR1g3OXcxTnhDQTZXZFJya1J4dGVxUWU1SXphRi9hV09laWZNaFIxODMv?=
 =?utf-8?B?NWRKMHFMeGk3K0N6aWYrOEdySHU0NGhsbFJ3Y0FidmJwMGtwQlo1RGxOak5I?=
 =?utf-8?B?aEF3OEZNRFR6SGRubUs0ZXhWUGdna1RBdVRLcGZETVZUMmJETGoyZmtaTkNj?=
 =?utf-8?B?cnNnanhoRTJYejNQTXBSUGJGZFVCTEMzeTN6MDdYVVFNWjQ1Yk90ZG0rck84?=
 =?utf-8?B?NGdYVXZJRDE5NmxSSEVjdWt5Z2NnaHowcEpmUjloMkJSVlZEM1ZLS2Qxc2Fi?=
 =?utf-8?B?NlZOV3lWSjJaeVNBR1pXRUxienpoeEdkTzhodDIzV1JoNHVXdUpjcjYzUmxG?=
 =?utf-8?B?ZmZhNE9hcXRRZkV6MlF5R09hSW5XVUk1ZXMxeVZ0eHFIUFNhSitkV1NCc1B1?=
 =?utf-8?B?UkgvazRnNHo1eWd4RnFsYXIyNGRGYjhBN3hYSUN0dTdSODR3MzhTZVZvajJI?=
 =?utf-8?Q?MX7v/dv+bbMjluslWPM5aHutANV3dotOyLTI01Z?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6454.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f053f53-e5c3-474b-40a9-08d979bc5a58
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 09:20:12.4708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5s2K9ECW1CSY7YT+QPtFFGERwWa3m5ve+3fxjpqY2a7Rlm/ru4sX+m0IJJ1N6kB7l7U457DxmoWPp98umPJpMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6456
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/5] syscalls/dup2/dup205: Convert to new API
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
Message-ID: <20210917092012.yaiTq9r58UYMFQuMSqGv0oKDxytZhsm_ne9UehWH0fw@z>

> Subject: Re: [LTP] [PATCH v3 4/5] syscalls/dup2/dup205: Convert to new API
> 
> On 9/16/21 6:49 PM, QI Fuli wrote:
> > From: QI Fuli <qi.fuli@fujitsu.com>
> >
> > Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> > ---
> >   testcases/kernel/syscalls/dup2/dup205.c | 166
> ++++++++----------------
> >   1 file changed, 54 insertions(+), 112 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/dup2/dup205.c
> b/testcases/kernel/syscalls/dup2/dup205.c
> > index 0b324531f..0e2766d53 100644
> > --- a/testcases/kernel/syscalls/dup2/dup205.c
> > +++ b/testcases/kernel/syscalls/dup2/dup205.c
> > @@ -1,134 +1,76 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >   /*
> > + * Copyright (c) International Business Machines  Corp., 2002
> >    *
> > - *   Copyright (c) International Business Machines  Corp., 2002
> > - *
> > - *   This program is free software;  you can redistribute it and/or modify
> > - *   it under the terms of the GNU General Public License as published by
> > - *   the Free Software Foundation; either version 2 of the License, or
> > - *   (at your option) any later version.
> > + */
> > +
> > +/*\
> > + * [Description]
> >    *
> > - *   This program is distributed in the hope that it will be useful,
> > - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> > - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> > - *   the GNU General Public License for more details.
> > + * Negative test for dup2() with max open file descriptors.
> >    *
> > - *   You should have received a copy of the GNU General Public License
> > - *   along with this program;  if not, write to the Free Software
> > - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301
> USA
> >    */
> >
> >   /* Ported from SPIE, section2/iosuite/dup6.c, by Airong Zhang */
> >
> >
> -/*=================================================
> =====================
> > -	=================== TESTPLAN SEGMENT
> ===================
> > ->KEYS:  < dup2()
> > ->WHAT:  < Does dup return -1 on the 21st file?
> > ->HOW:   < Create up to _NFILE files and check for -1 return on the
> > -	< next attempt
> > -	< Should check NOFILE as well as _NFILE.  19-Jun-84 Dale.
> > ->BUGS:  <
> >
> -==================================================
> ====================*/
> > -
> > -#include <sys/param.h>
> > -#include <sys/types.h>
> > -#include <sys/stat.h>
> > -#include <errno.h>
> > -#include <fcntl.h>
> > +#include <stdlib.h>
> >   #include <stdio.h>
> >   #include <unistd.h>
> > -#include "test.h"
> > -
> > -char *TCID = "dup205";
> > -int TST_TOTAL = 1;
> > -int *fildes;
> > -int min;
> > -int local_flag;
> > -
> > -#define PASSED 1
> > -#define FAILED 0
> > -
> > -static void setup(void);
> > -static void cleanup(void);
> > -
> > -int main(int ac, char *av[])
> > -{
> > -	int ifile;
> > -	char pfilname[40];
> > -	int serrno;
> > -
> > -	int lc;
> > -
> > -	ifile = -1;
> > -
> > -	tst_parse_opts(ac, av, NULL, NULL);
> > -
> > -	local_flag = PASSED;
> > +#include "tst_test.h"
> > +#include "tst_safe_macros.h"
> >
> > -	setup();
> > -
> > -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> > -
> > -		sprintf(pfilname, "./dup205.%d\n", getpid());
> > -		unlink(pfilname);
> > -		serrno = 0;
> > -		if ((fildes[0] = creat(pfilname, 0666)) == -1)
> > -			tst_brkm(TBROK | TERRNO, cleanup, "creat failed");
> > -		else {
> > -			fildes[fildes[0]] = fildes[0];
> > -			for (ifile = fildes[0] + 1; ifile < min + 10; ifile++) {
> > -				if ((fildes[ifile] = dup2(fildes[ifile - 1],
> > -							  ifile)) == -1) {
> > -					serrno = errno;
> > -					break;
> > -				} else {
> > -					if (fildes[ifile] != ifile) {
> > -						tst_brkm(TFAIL, cleanup,
> > -							 "got wrong
> descriptor "
> > -							 "number back
> (%d != %d)",
> > -							 fildes[ifile], ifile);
> > -					}
> > -				}
> > -			}	/* end for */
> > -			if (ifile < min) {
> > -				tst_resm(TFAIL, "Not enough files duped");
> > -				local_flag = FAILED;
> > -			} else if (ifile > min) {
> > -				tst_resm(TFAIL, "Too many files duped");
> > -				local_flag = FAILED;
> > -			}
> > -			if (serrno != EBADF && serrno != EMFILE &&
> > -			    serrno != EINVAL) {
> > -				tst_resm(TFAIL, "bad errno on dup2 failure");
> > -				local_flag = FAILED;
> > -			}
> > -		}
> > -		unlink(pfilname);
> > -		for (ifile = fildes[0]; ifile < min + 10; ifile++)
> > -			close(fildes[ifile]);
> > -		if (local_flag == PASSED) {
> > -			tst_resm(TPASS, "Test passed.");
> > -		} else {
> > -			tst_resm(TFAIL, "Test failed.");
> > -		}
> > -
> > -	}
> > -	cleanup();
> > -	tst_exit();
> > -}
> > +static int *fildes;
> > +static int min;
> > +static char pfilname[40];
> >
> >   static void setup(void)
> >   {
> > -	tst_tmpdir();
> > -
> >   	min = getdtablesize();	/* get number of files allowed open */
> > -	fildes = malloc((min + 10) * sizeof(int));
> > -	if (fildes == NULL)
> > -		tst_brkm(TBROK | TERRNO, cleanup, "malloc error");
> > +	fildes = SAFE_MALLOC((min + 10) * sizeof(int));
> > +
> > +	sprintf(pfilname, "./dup205.%d\n", getpid());
> >   }
> >
> >   static void cleanup(void)
> >   {
> >   	if (fildes != NULL)
> >   		free(fildes);
> > -	tst_rmdir();
> >   }
> > +
> > +static void run(void)
> > +{
> > +	int ifile;
> > +
> > +	ifile = -1;
> > +
> > +	fildes[0] = SAFE_CREAT(pfilname, 0666);
> > +	fildes[fildes[0]] = fildes[0];
> > +	for (ifile = fildes[0] + 1; ifile < min + 10; ifile++) {
> > +		TEST(dup2(fildes[ifile - 1], ifile));
> > +		if ((fildes[ifile] = TST_RET) == -1)
> > +			break;
> > +		if (fildes[ifile] != ifile)
> > +			tst_brk(TFAIL, "got wrong descriptor number back "
> > +				"(%d != %d)", fildes[ifile], ifile);
> > +	}	/* end for */
> > +
> > +	if (TST_ERR != EBADF)
> > +		tst_res(TFAIL, "bad errno on dup2 failure");
> 
> Hi Qi,
> 
> Why do you only check EBADF? The old test checks three errno.

Thanks for the comments.
Both Xu and I got the failures with EBADF,
so I think that checking EINVAL and ENFILE is not necessary.
I wonder your opinion.
> 
> > +
> > +	if (ifile < min)
> > +		tst_res(TFAIL, "Not enough files duped");
> > +	else if (ifile > min)
> > +		tst_res(TFAIL, "Too many files duped");
> > +	else
> > +		tst_res(TPASS, "Test passed.");
> > +
> > +	SAFE_CLOSE(fildes[0]);
> 
> Why do you close only fildes[0]?

I did try close all fildes[ifile], and it occurred close(-1).
After talking with Xu, we think that close oldfd is enough.

Best,
QI

> 
> Best Regards,
> 
> Xiao Yang
> 
> > +	SAFE_UNLINK(pfilname);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.needs_tmpdir = 1,
> > +	.test_all = run,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +};


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
