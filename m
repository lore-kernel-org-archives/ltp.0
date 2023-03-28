Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E680C76195
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 01:28:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 849CB3CCEFB
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 03:27:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 862BA3CA2FE
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 03:27:46 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ECEF9200A10
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 03:27:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1679966865; x=1711502865;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=wG0y6ibMEkXYgeqff8GZGQtA1aT0sFtyBUmfPnyikms=;
 b=KTZ7TkmL7pKloxZZ3w2ptwyEUsmMadqA4eXfBF/awQBfT5pdIC0ONQv3
 WJB9S5d5+8HtBnFuLxvrJB9lr4OXgdv1LsMIepvJkWwU2u7b3uvI300NV
 pwEJQ1n+T4FNZPSON9Y3KNryGVH2u3nBNI4kDUodAhBekmu/tG3/FQpR3
 R1QkpeAMZydiuH7qVxFfRfPq2GHSgfheu1oXcct9Lm1QLeKwB5d2DGgiv
 5B4zzS8w2gK4AjOH27NYOEJPwjuOSLYvc33xsWV7kcrabqe9/CUA0cG0S
 gXza1LVZfUeZWS6/74FkEH6ae4iJj17h2DclRsWSSTRyQfF2vasyEWsqq A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="80245050"
X-IronPort-AV: E=Sophos;i="5.98,295,1673881200"; d="scan'208";a="80245050"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2023 10:27:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNNj51ymp4EpvTBGZyMMQJ964SdHwbavlicHLbWsAanvb/XwERl1xuzirN8/S7/F4T1TPulqA+WOiCecRyqG9Zlo6MhEWAK2KFcxHJyqyXakdIz3szLiXZrDFwEIlTm1GgjT7R09Upf3fISVYbZd9DktJDueNfkpYJNb8yGtdtHbK2wKOOaW1PzNTRoCY6at4YJPSC32I2NrknTaXUbiFlkMw1L6G2WkScYzGTSEFembhq6N2mV6cedfYFAotkJ8LtF+Chb16v9ZoXQL+90f49WaYNZg+pAcjEevdPifmzEB1bBSB+VDP856H4bwu6C7/aNlExu0P1mHqj8QCKusVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG0y6ibMEkXYgeqff8GZGQtA1aT0sFtyBUmfPnyikms=;
 b=B0tRMulvCZEWmGAF6ejhtK4Tgu4IGPuFrvVHdLDzAEhC/Md11QuuWNqN3to6D9zvJzCUpTxIVdvHdfM4IbMcGjhoUMU+X/7/BllF205a3CH8LrJAEEqasFW6ICzgNcYzfqaZpBe92ZMobrcLb9z/d7VlLdkD3VwR639t91K22L/vtI72+6d+GqML+suQt64s1hPvwQPcKRJNttXbB63MvmYHFi7YHOUNwxKvr2x1PqrX5DUuEVmI2H1X6vuf4dFIh11LqRMZuqsTOVlVnHPmF3Z4oaRipHgD58Y4nWdp3oViCNUpkj8zyqUDPeU6a+2BJ0adUTJUpjvY2mtZsqXpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OS0PR01MB5586.jpnprd01.prod.outlook.com (2603:1096:604:bf::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 01:27:39 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd%5]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 01:27:39 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [RESEND PATCH] runtest/cve: sort by cve number
Thread-Index: AQHZYJc/6fW+G87oGEW+xuLbYoCu068OcAoAgAAGCoCAAPGygA==
Date: Tue, 28 Mar 2023 01:27:39 +0000
Message-ID: <44100779-b2fa-2832-2e66-4e534178ebb1@fujitsu.com>
References: <1679913040-4675-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2cu7sXXyAC=D8pLXqEbFfctdMrafgRMNh5s67vX1MrYLA@mail.gmail.com>
 <20230327110233.GA671310@pevik>
In-Reply-To: <20230327110233.GA671310@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OS0PR01MB5586:EE_
x-ms-office365-filtering-correlation-id: d89d52a7-6361-4857-950f-08db2f2b9e91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i5fmAvydblW1LnOeTCVpAZRzQzzZvw+vXIEnXzfPCsCtn6v3n6bGx8dKhJK0HSfNtxuNpFW2I0z1y95F7Ox1EbAA/DLVhfeN7dviEPDkKiUcM6pLSE+PUEFUuz9LKgrzm+KntSmJCqf3qM3Pntr5bJnkSSMEdyCzwxCHKs0QrF0CqJOpe4pOV15Vu0H0ahFcBFCAQuKTHrT3LemRgNZ96RDOPoUZzuLG5aLHyGT7mFGlYzmVSt5pQvBX5S2/x6lZFZE9bySnnNEOHa0+F9aoOtBGJzYtRudT/uleyB6BdAYwOv2Fw6zYdlg7l0qIieru2hb9LpW1Bf0jMqrtNKkoNwsWWHIBOn1UP+c5eU85xCYhPElgUEsWMEXcbhFZn1cWTX4lHxPLQ2Z4I++b3/7T/KfCdq8H2QMotpdDJBErREGH3tV8ODsqfy1n1YdKemGLwyJX32pxu5FT2nrb305SzPVsK8kzOv8Qht1h+7j7qwIkluCTCQVmpeWJOHnS3conk+rY6FkpLrTwLMNOjYM+OIoz8ZXEXvRKpFRZmhdg/i2dIvDM3KoTIAEOctEJ9yd617vWw7NLm9YuKG2hExXUxjRIg4cjY1OW3uQdNHS1KFUZfDAFY9tf66qbmL/hKtpicpjAn5m9SNuE6BVhXGoUt56x8uu0wDz46LJFrjB0Ul+PtoJl5Fo2efRALGskJGNg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(1590799018)(451199021)(6506007)(186003)(2616005)(6512007)(26005)(31686004)(6486002)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(478600001)(110136005)(71200400001)(316002)(91956017)(8676002)(4326008)(5660300002)(82960400001)(31696002)(38100700002)(122000001)(86362001)(8936002)(2906002)(38070700005)(41300700001)(1580799015)(558084003)(36756003)(85182001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkJxaXF2TDlXTkhseitrTUhxVFRxbEVDMnNzdHNGY2t3eWhwc0pOYW00eUVz?=
 =?utf-8?B?dXIrSFhPOFkrWXJENnVnL2ZwVHEwaWwvL1pHZmFvc05oSUFnSFp4TnhZbVlw?=
 =?utf-8?B?NGxpZDRjT1VaVlhWdVppNVBuUWdjTWhRcXlacjB1bEthMUZ0WENpbXRnUTVT?=
 =?utf-8?B?c2FmbzB2Wkh1RkdRakd2VnEzZHBjbm9FRmExenFNWWJQZFdqWDBURTJaTXIw?=
 =?utf-8?B?V3BVV09Va0U3RGp3ZlJCbVBNcE1HbXVIaEFwdFBZT2tSQ1hTS2tOaVg4aDRM?=
 =?utf-8?B?dFA2c2hyZy9Ha09tWktIQ3NUOWZIc21SNkEwTnVQSm4zcWZoa1JYeVNKdkQ1?=
 =?utf-8?B?TFM1TG1QM3c2c1dsU0tLc2IyQVJXdXhvNEREU3UrMk91RUp0Wk9HQS9DMDFY?=
 =?utf-8?B?d0tKcGNMK3k4QmpMNDE5ejdhb1FNYWtmbFAzYmdneUdrSVhxTXlmWDRSR2RX?=
 =?utf-8?B?RUs4NGZkSithN2NwcXd1RkxaSmhJeDNSc054V1dabmtRSnE4dkVWSTN0Smc3?=
 =?utf-8?B?a01PdDh1UFJTUFl5MEx5VS9JMWNNRXdkVGVZSmhtbUhnaXB0eS92dG56clpo?=
 =?utf-8?B?NEhGVXhwdGEvMk91a0xqeG44VFExMElMeFIxUTZjNEFjNjdiSEQyYjAweUR4?=
 =?utf-8?B?bGs2N0FKTm84TlduaHpsaEZMZG52ZVA5bmQwWDNodEZLWmhqRlhNZDJ3aUVs?=
 =?utf-8?B?dmpBd3gya3ZTdm5BdCtHSlFmZDVSQkVTMyswSGkycEpxdlQzSDNqN3FPQXFl?=
 =?utf-8?B?R3pyb0xkRXdaVTJyd3V5aGkyWkplTXhhVmtaOXdCdmdkRndBeDRPR1ZQQXMw?=
 =?utf-8?B?Z1AvTGtNTmdKUUNOblFoWVdvRjBWbWNxbTBVcHQzemdhQ1FSUU40a3ViSVlB?=
 =?utf-8?B?bk1kMk5MWUplUFV6WCtmOGZXQmpBTm9Id1pFM1NoY3JZdTZDbmhsNzFCZVhi?=
 =?utf-8?B?YlZwckhyYUtlMEgzNy9KUTR1bE9vVlZTZStieVIwb3FuV2ZjUU5oSVFSeURH?=
 =?utf-8?B?eEJDMmlnT1lQMGtic2d6Q21KaDlLOEtwWnVZMjJ1R3BuU1lkRmJVWWg4UUox?=
 =?utf-8?B?cGN2TFlQcGExbXJ3ZEFSeVp2N00vNHlVeEI4UU9YVGU0aWpselhIc1kyd2E2?=
 =?utf-8?B?QStQNzRqZXNVL1ZwM3hCNDU5SVRrdGNMT0Vmc0ZsZ0ZQZ0ZCNTE4Z0FnNFZk?=
 =?utf-8?B?Wk4rU2M3MkFKejhWK0xKNW9VeGRQR292UC9lVEJaUXpZMzJxZm5XNGZPTVB0?=
 =?utf-8?B?OXlHUDAxUGt3bllTakFwaFZwV0VETXZWSGtmajhDQStIaGN2Z3JtU1pFb1E0?=
 =?utf-8?B?dEZBTG1ERXdKb3pMeE55bWprNU5VeU1wREhkWTFNTndTTmNOVWlKeHMzOUc1?=
 =?utf-8?B?QnNmVVJxMDRpdEkxUWk1TVJ5NU1Sbm9VazF6c2QxZGFudFJjVWFDN1UxSFVO?=
 =?utf-8?B?N25saUI0SjVwVjFPRHVJeUhlbEtNQVRIQjJuQXB1OWFNRVRSL2svaHVMdzhh?=
 =?utf-8?B?NXhtWGdyR2dMRlJobEt0YlltRThNcExvbUxsRXVlS1RFVFoyby96NlhOcW5E?=
 =?utf-8?B?cXlNQ1pJRndjeVJYV1NLMm42YXVZQkRFZmloSWtPU3FRWS9ZWTllbHZZVkV2?=
 =?utf-8?B?Mnp6YjkyZWJacWd6QjRqK2NTNXhKRUpqK1VURStoY3orQ2ZEWE9idUw2em1h?=
 =?utf-8?B?UkpoTmZGZGh3a3RzYThTQVlVYWdRZ2hlM2QwUFU1ck5zRENhVGhpVmRuSytJ?=
 =?utf-8?B?ODFDOEZjNWpnRGhSYVEwb1c1VTVzVUtCTHRBbnl6N1NlbjFaOGJXaUpoaTNz?=
 =?utf-8?B?ZmI0Ync3ZlBwSzdCdGxRNkhJOHV6OGFhMzBsTFRPbVBsOHdyRTgyTTlxQUZm?=
 =?utf-8?B?bXhEVm84eFlRRi96WFhxYjBIOForYW1pUXhlZ01SN05tZnY1N1Z4d2xSOXMz?=
 =?utf-8?B?MDZXNG4zLzBWaG03Z210TmN1cE8zWndsclhsbkFSSE9TVUoxWTdYMCthamdY?=
 =?utf-8?B?ZzZhY2NqK3FxSzlhbmJMY0dCYVQzVkpYK3RibXYwckk1Q1pjbVg0QmZlbXlm?=
 =?utf-8?B?aFJXcHFOS3NCQUJoWk9TK1JrNGNnaGFoYlBybGM5N1ZmbTJmcmthejlaeG5z?=
 =?utf-8?B?clV6UktySUZzN0ZpTk9Td25LVk5PWVh6T1BqSXQ4OXdueEs3U3R4RFJCNnlM?=
 =?utf-8?B?dkE9PQ==?=
Content-ID: <6B481E768591614E8836A24287A9F15F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HyxtII2LKCMUNOsszMy9HpFcgn3V1D7kRW1w1TK2BllBvzQ0KhUXxQ54STmpNQFeP1ngGFF9octLMN8sUx3N2ozxQqMZJd644lJOxzITvZ8mFVxE5GokBF4nlhxU1sycDDxKFcF81Hile1EEEWUwpUuOG3qY1zXFBCUiWOs5f1FF0Qy5gb/FMlrmHnxkSwlMm+g+En7WPpm4Xo66Nn66ATumU6oNW4WvM8Y1d1zQpz45fcjQjqrmqWP5FOdHfkRYxBRFIgT/EcArh68Kl2oMij6hC7IMOGb5CkWN3f6Lfd0bbb/urxKx2JsD9cojj167FrsyA8WfUkcyt9IYQIibOoOrGofRoQK9NeF+dk754hyuL7ml7D+JCCSKQI2Vx7dVSscmUfqa/pJubtkNhQS6bCfQoKcKf1AomRLtcXxAalsGEVunUfVgCljdFftN20ARFUAO0gRm3r7jcy9jeu6HXMYNqy8OkOF5BRm9H3rpTsckJC2NkRe6iCcVfp7nUPn4UgmhofPiGMNxxqK4nEdT4+JH9LuyCzt4RtjpX+F3rxlYCwqw0Qrf1D55YdJHdyzAC548zFluFIiLnAxPVKhl/pDr0XD0exDSY8sNtmSkK/n7xvM5zhdj6/ofbY6iMe5cxHgNw4ilYnAc12GTD0dL22j3eDCQCAJQ5k0J5dilHEavbfRdR8wM/HSWjosks0CBsCPG1M0dGvwt9coj+r+UeIAJTfrLW0XWEOZb3C/FVJlKI8BFyh/7FTVO7POg/OlSg6PEOx6Q9/N6GaZ8AGPjw71Xk4xti47v3yXuD77UMnX4kSOgCjj62fMZOtrwWLWY
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89d52a7-6361-4857-950f-08db2f2b9e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 01:27:39.3099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Wn41uGhvLm5YtySi1Z1w92qlj+BntqJktDlv3NpOKBPLy8HGG3H7Z83fUejiXZejZu2DoVKxsez93J7mVKHOw6MjSm227ChxHIAyLZ+DPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5586
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RESEND PATCH] runtest/cve: sort by cve number
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

Hi Li, Petr

Thanks for your review, merged!

Best Regards
Yang Xu
> Hi Xu,
> 
> obviously ok to push.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
