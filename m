Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F02C001B0
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 14:56:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D92D83CDDE8
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 16:56:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 813723C99AE
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 16:56:26 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A58D060035B
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 16:56:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1689605786; x=1721141786;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zJOjRtpziPPdO7ZXv9w22kCmA7Fzda/BD39FJI93ymM=;
 b=SDdsDeaOTnvm30pevgzgwILeJgvLc31+2ZEO1EIuhacWVZCb3zLZn3Bh
 Pb2DVd3LSJYsnL5hjUH9ENoCWQzfgk4b79Elo2gORMjZ68ufhc7K8juN/
 VqrfBvpQ3C5ywe8kZVM8RTQN05opa0YfRod3F1VZA4KSmUCDwon3z1oV1
 Z3o0bj2Qz7S+JYTmCTmQuiiq5cFLHKMGaI7lpl3MtCxvluEZgf2rRiLRf
 wHUo0JjoXzJliyDuRL7ND1AUf9lDQ4AgqOMBmdlg9xxC4S8VAZuHTSMgd
 qbUtzMkQi0fwW7j6Sv6ad/VHv+K0Wm0Ye34Jp5Ww/ICiyi1jeKkllB6kI A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="90010770"
X-IronPort-AV: E=Sophos;i="6.01,211,1684767600"; d="scan'208";a="90010770"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2023 23:56:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKfGvreM7D6EGglpYqRm2+JFp+Op0pXF2PWO5ZZKhNCBcB0lp1eU/YvYLpVN/z6xUjgOE2290Ji2LB4TYOLAimJouHZL8wkFS1nFQEcqjwyWdESouP6+iSeXOvlrLW8oh5omwO9zoZw7GfeWVvclFR6RvIVqtluPDQDQAdhxSRwgyRTkhvD0ywYxzuNQ1A+0wQ+ZiYrkwpwy97ApCtBeKOzB7XqZaRdjkjpHhM1fEnrXLo1btfixnCQDV5l77aNxlZD4k30s65ZNvoIvUPiamwA7uT+SFTiIoDJg6JoNrz8OX0o3rHta6cZ5oSM/rjgk/i+i9Rtl4Yur1azz5wr/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJOjRtpziPPdO7ZXv9w22kCmA7Fzda/BD39FJI93ymM=;
 b=Hc3G2XiealT2FTzxXZ4beqsl8RBLpPs1n8hKd6hpdKlZW24JAk81tFjKM9FOtjqWsStRYaAcGRWlpSthL+Igaduu/mIhmYlOz6GdCXL3KFb7x6go49FdTEpZp8j1pAF5WJtF3jbNVxlSk8gjlv29ld3s1atxn1KxvXKBGfD85ypw91ayXT9KsDIQERUk35POApwbxyCd0fNfGU0xbfihIr6+nzMF/HlPxCeFATQZR87DD9FuH7TUBIEgkYpFyv5oC6itqz+gcpD3Xx3JEEQoJ1GF2kqyQ/fcQUo+bNfPEPXX1PX+o3daWoGpWdGkWrXnMqMLmkfOoGHuAFFjie2cqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by TYCPR01MB9321.jpnprd01.prod.outlook.com (2603:1096:400:196::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Mon, 17 Jul
 2023 14:56:20 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::cab0:8eee:f77c:2d5a]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::cab0:8eee:f77c:2d5a%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 14:56:20 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v2 1/2] syscalls/geteuid01: Convert into new api
Thread-Index: AQHZr/F5qu3p7UEG5Uq+yDXvq9x5O6+zCdoAgAsT8QA=
Date: Mon, 17 Jul 2023 14:56:19 +0000
Message-ID: <934a1afb-c157-326f-21f1-776563373f13@fujitsu.com>
References: <1688637954-17765-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230710134604.GA645484@pevik>
In-Reply-To: <20230710134604.GA645484@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|TYCPR01MB9321:EE_
x-ms-office365-filtering-correlation-id: 22955133-5c1b-4f34-b381-08db86d5fb00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P1y4pLgtYndrfeWO8v4M0fb5R+xSG92w50irfDdQoPkV5aZvmAmJKQDb9hZnnkb6KgcRIplsVYUEnBcJYLkAxMqs+LGz8VAsdR8HXeSDrVlO/DhRuLzuIKom/B6Vt7LKyRXTpP+A7jx1IotsDWsHA28gY7fXiD3PaWg8Hs4x/HlqE3/Hs9DYPzTKyIK5WglHi65msTjsZJEqgck7GiBAseoNXn1TkYyXDfE3eUqKImpH7TgISG6f/ufB+RfTme6T804oZaWAw7Y3cJjXouxsY4+yF8WHHVSMMRNsbjtgYh34NCEaP4tw8MbEUKwrh5FAFze9oZWf7kg39AtiSYXCcSYN/duSVsSz/DaJixvTiv4k3fukKSgMjY+ZZxRC12imXY0SOf/7EjJ5wrxTA0z7l5nMWCZimRSLKgP3eUiW+e1xeZS98MLQ9cyeH/B0OmdlVXGWjE6nMa3HigU+RmYlwd2AvK2N+gIDqO0I9jt64qCyVtHuBLHi46en51psOp4YQDf2X5mAhsBT8Xbz6YGWQqfRYvuWfnycFNcvMUjztlK5CygujUzeWq4FDxBWNTSUN+jhllEPITPOips1LSbXwm17OpGGWJmPtVNucx8N9LqO56FYozx/XGoq/12EoH3CBLUnPFTLTw8xSj1IT2C2Q5VY7HZLdgAbIazZchkuW+c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(1590799018)(451199021)(6486002)(8936002)(71200400001)(82960400001)(1580799015)(122000001)(316002)(4744005)(8676002)(85182001)(5660300002)(36756003)(2906002)(38070700005)(86362001)(4326008)(6916009)(66476007)(64756008)(91956017)(66946007)(66446008)(66556008)(76116006)(38100700002)(41300700001)(6506007)(26005)(478600001)(31696002)(31686004)(186003)(2616005)(6512007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUIvUFV0T2UybzEzMjMxZ0xiK29CazZUY2hYVmRZVWw2RC93WmlvU245Kzh5?=
 =?utf-8?B?KzdLYmY0Q1hKSnliNjFiQjNUdTV2bTNhVC96RFpWOXgxVlhrK2RxREpGRnJM?=
 =?utf-8?B?cGJBODlaS3IvTVBqenVuSktpM054SzRSNnh0NXFwSEFHcG55UWpjR3NDUEhG?=
 =?utf-8?B?Q1pXRE1VbnNwTDF1NzZqa2FjNTlwWmg2Y1NoekxuektWQ3hjUkdyK1FJSE41?=
 =?utf-8?B?b1RVdjVqOGxTMllKSjlPSktIWXA3VlNRQXZ0OU5UR2ZNMkM3STNqcWp1TUwr?=
 =?utf-8?B?YTNqRkZIemVHMkZPaWFvK2JwTXJXUWJ0L2RHNFpxcEJEbnBoL3pzZ29vT0Q4?=
 =?utf-8?B?bVVBcjI0ZFhFenVVTHBaZUgzZWQ0akNjcHFwenQ3SGlnUlZ5TlZlSlZOdTdo?=
 =?utf-8?B?a1RVNjdOU29wUGI0Y1hFRmU5TG5lV01BWGV0MzhDVlJxQXJSYnNkY3dtdlU3?=
 =?utf-8?B?Qkx6a0ZDWHQ2bDdPSm5vRVErUXppcGk2T0lNNXVlOUY2Z0kvcUlPbkFXZVor?=
 =?utf-8?B?UExrQlczemFuY3RrVkVscC9YRDVUZEFSN1lnNjlJdGhDVm5qaWhmZXNFYlpa?=
 =?utf-8?B?eVBmUXY4bkg2RmE2YVVQVU5YN0JyOG92WHVsMGNVcnBWWEZyVGs2RTV6cTN5?=
 =?utf-8?B?ZVN5MlU2ck04dDM2NFFiSDRFV2VMUCtRQTlLUFU4S0FZdUpBT0M3MUllWUlS?=
 =?utf-8?B?VkZXSFZxWUhLTGM4SURyc1dTM2RGQTZKOE1TaSsrSHVzTVhHMFJoRldWc3FI?=
 =?utf-8?B?YTVNVWprcnFVemRwcWtLMHp3MkpacUFmZUZuMDdYa1ljb3FjS2x4dEZoS3Qx?=
 =?utf-8?B?YUpHQmRXZzZOV1l0N1VqT2UxWXh5T2dGQXhOMzVNUmEvYlZWaHV0VmdVaFlS?=
 =?utf-8?B?VmhSQ2tLTXRLaGVjR05PZ3BoVWRzcjJnU1hlWXB3RSt5VmhuZE9jdTZ4YVc2?=
 =?utf-8?B?NjRzK3JValVhOWNiU3pySy8rVTZKQ1NTVFdCZFNDNmlRRzdrZzQ5ZWVFUjFP?=
 =?utf-8?B?OVNhQysvQVBRZThZTTV0Yi9jL29mZHlEdy9DcFEvSTBqbllqZTNkQngzdlV6?=
 =?utf-8?B?MGJtczEyTCtVbVVaRDRRWGg0aW4rY1RWTUxhRG5YZ0VpVVdoekVJeWtmejdq?=
 =?utf-8?B?ZE5NUmN5c2pzTnhjTlFxVmRnSkt5bTlIZmFQeC9pbFNPRlc0Qkc2aTlzM0Zr?=
 =?utf-8?B?ZkFjM1hhNXFZenZOYUhKMHh5N3N5SHdoVkJtMzZXZmNzazFGZDRHcU1kWU42?=
 =?utf-8?B?NVN2UUxqRFZablVaTDFzZW9UV0h5bkJERytTb2NBQ2taRUEyVGpYMDJnamh1?=
 =?utf-8?B?UGVPMzJ5ejQ5enZLdGZnZHI3dWNNR2NybFJGb1IvMmxrem9TS1A1YVhkVzIr?=
 =?utf-8?B?NmllZFYrbEdrM2N5RjZITXFXeFgzbk44ekFydGJadEpGdk9wR0k3dHNmN3c4?=
 =?utf-8?B?cU9wOUlHNjRKaktObnZUY1lqa0FnYzN2NWJFQWJWTGpTY0NJRy9TUW1mcUpM?=
 =?utf-8?B?YnF5d241TDdwSmcrWFVVT09ZOHhVK1hVM0FISjdETENyam1ZRU1aSDI0OG1r?=
 =?utf-8?B?cG5rNVVRMS9VR1pXN1hyU1JFZkdFS3RQMm9KTVR4S1h0blVESkFMWXUxazlK?=
 =?utf-8?B?NlRGR2NwSXpDOGcvcTZiOXRyazFlVXRRNHF3QlBVdVd6T1ZRZVlxUFRnalFF?=
 =?utf-8?B?d3B0d1k5L1R2S3ErYzZDVEQrcFRBcmNTUzhQdUs4K2ZOb3J6QjBmTDFyN2Fn?=
 =?utf-8?B?QTNQV0t1aWIrM2lodGxkWXZnZEZXOFptYWdqaDl2NTlCdWU2T2dXeVUzSExN?=
 =?utf-8?B?eWxUNlJNbkl6eWdtTm9mSEkyTHlydTdreFkwWkhGM2RuVi9jOEFEdFg2YUl5?=
 =?utf-8?B?YjArb0xYVUNWVldXQ1oxZWg2RFRiaVRwRTN4cHhIZUY0T2pyd010ZTJvM25H?=
 =?utf-8?B?Z0YzNHlvZzNqN1ZYWE1DeGRYOWl5SmRnRC80Z2ZxdkRIeXFhRlU4dU1oVzhZ?=
 =?utf-8?B?bGFYakNHOER2LzE2dlJ1ZTk3VmVNcklBOFNCRFp6eVJCVzZGOVdkK1c3Mndx?=
 =?utf-8?B?aFZnRFlmODM4TzZnQjRtZkdDWFVnZm1rQnRmNUorT1RzRHJRdHVjM0FYMGtV?=
 =?utf-8?B?UlZPbXBTdXZ3Y1lWY1B2azRQbUUwS0k0aDhZbHcrMnZiMEVPdnZFK1VTdjlq?=
 =?utf-8?B?Z3c9PQ==?=
Content-ID: <848DB8A0094B9B40B59020DD0381F989@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p/wcILuh1royDvl95fcUURDyGCMs0sol3gJXJn2IRaI454R2TyE5LyshKCLir6U+N3r6UPEZeb76L8CtIDWgdBOUiRxBWmeNE1P68pomwaEBzHOFy1Zr4PefBR01CJSacACOPx7XtngicchTqVUfB2kw7VOwhqp/eTrC6jlX9FFQBhhh19cxui2rNqdMnYXCJ0nlP2IRc8YknqPnC4D9htSY7bs8y3C3u2Z+pAx/N6Ohd3eVcrxxlEKg7YCRpKfGl92fLXtOiw9SvaDl3/AXwQEaWmMobZOkMM2gTSOf3UHhSz/T2t59/I9AqjNiS6/+hs/xuoyoLdQwiQ9nTDBn3Zdv47Pe+40o0pbmhBTW6qNIfa+3WgxGDx9Mod7pczH3RwLebG7mz43H0qGP+0XLaj459iehoSahdFONqN3S+JJuvIKOezwKXlBAPt2sOl3y2nzFy20XzRxFchVQjVWDD7e9yyeG8YNpmZXuszzwMkD1RzDMJEHbiNucI/wMovaDIaKLlSjDX6a0nq2J362e89AhTizjHN4lHRlaLUfuhaxogNNnraPT4nPgpsMPMudei0c2eedlwDc+wjf7m+FYFwCxviiw2tzmrxndjp4JqyXYiD1FsZOK3w9+FxHFfHQd9Fg5r+RjnPz7tsZj609q9QoO5TSV2Q1t2xF40eXsJZhhetpfhmGA8zkm53dONyPoFQ9VulIrgesutZOnvrUGViZ6oX1ls1m9hZye5LJKFBoDGoqprhm3fOfVXqwBgME198UnLX2ZWLlrr+MV1OFfJXNWUxopduR0Hf6Kbetm2LU=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22955133-5c1b-4f34-b381-08db86d5fb00
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 14:56:20.0255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYYXXOvz5YNoElglZFedl+SRMRGc4shTN5XuicWTFVIgdqiyCs9eVzjEJUUJyaBRxLLOez9QgYk3EVaTQE99mEN1iWk/a5k3zjBHsriizGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9321
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/geteuid01: Convert into new api
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

Hi Petr

> Hi Xu,
> 
>> + * Copyright (c) Linux Test Project, 2003-2023
>> + * AUTHOR: William Roske, Dave Fenne
> Very very nit: s/AUTHOR/Author/
> 
> Also, in the subject in both commits: s/api/API/
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for your review.

I merged this patch set and modified getuid01 to origin gpl-2.0-only.

But  It seems all of uid/gid case miss to use COMPAT_TST_16_H:= 1 in 
Makefile except syscalls/setuid.

I search the history, it seems related to  a bugfix[1] when 
touch/modify/create fiel in syscall/utils.

[1]https://github.com/linux-test-project/ltp/commit/631d16671d876524588320ee71fd23fe22750307

Best Regards
Yang Xu
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
