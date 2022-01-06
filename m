Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD97C433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 09:53:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADE2E3C73DA
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 10:53:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59AFE3C7B55
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:52:53 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 102DA600C77
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:52:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641462773; x=1672998773;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=AhCOkfWIOKmIHtQUGfVXjoqFS2cZzz9/xDTDgvPTF20=;
 b=G4CRS3cYavEVxmSeuthIiE/5D74QJwR+fAsw+wswxy1kwdhbiuqnepwa
 UpMgeoU4twfmIwEvg7ySdrdVc7GZ/0Ko3nunKKZzMuU8EgBkNqq3aYliC
 D7UjjznYYQRvqUPzplsx7aJNytggHnKxD3pys2NbiIiLvlJFoS1IcARCP
 vT2a1DCbPtWqmU/BP0nVyJZXvujhc/5lXBY65JZpdKygnIQrL14ZDh2Gl
 HGnFS5NyW/Qmfn+rUo4BvWX1UHMAjHpiUjr+PL+gEbhgNESjSvCt4w4gW
 wY1Ly3KBX6TUrPQosfdhSixlF+eReROvspyryiqDlcSv6X0TwJWx6xSpW A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="48085650"
X-IronPort-AV: E=Sophos;i="5.88,266,1635174000"; d="scan'208";a="48085650"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2022 18:52:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7w8OjLt5oPRpnUnVLoC4qjIl9S8Wab85PjIlQrFsK+QgHqNJkK7wqm6B6KnNWFtYqaZTBM055nl+EvY9EYPQbuRzfHLCcmTNTI3+97lcpU/xI3RkQnFCqYjxZ4/5RNkkSVDaVhCkQOFMrxfjc04GEWNd4rhXEC4qCtMqmxH3xMbtVdUbUJ5b6k2vr2h/uMbM1Iz8jnKLA+TuVN3ZzNU/CWUtGDBdAOX8LnkeeMD/epPJ2kFpQD7RVNx03KClWNmPywCokUDmNMOgL1QnEs83I0dptpxsETYwyJR17toY6km1bo/PxbW4y48hxyUQ9qHLwYEGEVvF/di19/YqzJAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhCOkfWIOKmIHtQUGfVXjoqFS2cZzz9/xDTDgvPTF20=;
 b=oA8FGpA6hbtsLYHVc7VTTm/rq3z3meJOYpzxFi4h7uXNyfp7n8/uhUTDb4xVFJcp62LDYgG7lTf3fu0gi2JTZEv/WNuRN81/Zxf0DfO79dY5zZliItVz6AeyhxVNvYv/x2t9piU/nwgPZKZx67vGIc38UG1bveLrUFD74ErSM23x32E4B06I94IGRKJp3JQ+FN/F0QCafm+nYrLRF54vmyHk1D1UKdpPXldSGYoFpB2bzwcbHGAN/3UtaadC/GluTv+8QrJmy44+sPQO/SHGfqC8/yuym9CzfUIY+wUbiHDTGIaOcgM+WeAFGISICLLGm3UhNB4/xF6vO/erpL4eeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhCOkfWIOKmIHtQUGfVXjoqFS2cZzz9/xDTDgvPTF20=;
 b=AxH2OUTi/0xMRaIxOYfCzTQgEziJx1FRfPTmrthY502ZtzmRTLBEhPFV/9TLf9v+dCSuvEiBlbGgJ0Y/E4YNN7O6tpHBWtyfieOLQygTw7JEhail0dKmhPGCggdZKdnF34S0C4Y8NHVTBreBWe+QUMBO7fLQHHlAD/WcpEL/0pE=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6073.jpnprd01.prod.outlook.com (2603:1096:402:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 09:52:47 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 09:52:47 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] LTP Release preparations
Thread-Index: AQHYAihbI6bl5qst40C9CZSflJDnKKxVwjCA
Date: Thu, 6 Jan 2022 09:52:47 +0000
Message-ID: <61D6BC17.4040501@fujitsu.com>
References: <YdWC0f+70TF6Eluk@yuki>
In-Reply-To: <YdWC0f+70TF6Eluk@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1921312f-5d8a-4b4d-8f6c-08d9d0fa4b2d
x-ms-traffictypediagnostic: TYAPR01MB6073:EE_
x-microsoft-antispam-prvs: <TYAPR01MB6073999D83929F0EF20CA8C5FD4C9@TYAPR01MB6073.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EBL0EtlAZQjmSTCx/quE+zEUVdfRR/YC3d/V1NJ2TROxTphnVIpK8WTysryY+w1y6S4ImKkul8/dUrTsIzo9fJ4/0FKG+Ogu/VjM46HUkB9nM0Do9N27KzPA6nIHT+F+hAazRaI1Ahl6cmnYImjZ4nlvk25rdTe8J9anQWO/7lRGs91DNB874RgxLFk00S3YPgr47fs6dIKONzn0uVivmEMd1CQQzeFWqS/iNNeSNxoSiag8reILbshSxn4BwSK9U7aVd5oKZo7uyFKEc21I0nutt2IZ1xfJrIqIhHHIMavF6IC1WgrKJTU53l7H6X1q1qNdz142Y+iaDO+IrWfKEec2kW6ocUnL++O2Lp6+lqFGCAv28Xxhbe0MfKYNlKAKin/kfyu5bEPBepWhUZo/DzJOHbMi6SROeoSdZ90pQTjsou1yM6z0Snb+6LOwlMlbua3bZlsGMCdcg+ldJ1GGUDozEMW38Dfo37ku3rtlAp3LaZUA3CfMpOA5Dp287ck/yyy0GdCar+NR2P4K0IBSScPSqGwPUzNFnIOHfNr6r47FM4Hzr3RMHEtClwA4Ox/Fuk/uBzIijfhNigAoMrMkZZNB3Q2URTRc1KPx/ys3d7DzrEmak2k2cMEloimiwiqa4EHgxm1eXE/q6PaA07RTuOg2KuVBQLm0PbalPhZNTip3gDdxW84WpCezVtE3ygE2FUdvMT50O9Qg6zZ4a92fmIG7cMgsVM0V8R3KXUR6w2FNt577/4xHhhiJBNTtj4qNnwofzgyyJAs2ED5qYgKDAcV9G0FLotpt3AaYE7DHD8I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(4744005)(5660300002)(38070700005)(6916009)(8676002)(71200400001)(66446008)(316002)(66476007)(85182001)(66556008)(64756008)(76116006)(91956017)(66946007)(2906002)(2616005)(122000001)(38100700002)(508600001)(6512007)(6486002)(26005)(4326008)(33656002)(87266011)(6506007)(36756003)(86362001)(82960400001)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q1hFL2hOUVBJY3cwZ3dabEVvK2ROUEZRMU1RaEh6S1crbFNtRW5Kekc4c0ls?=
 =?gb2312?B?RG56UE5KTWxFK0V6blRLRHQ0OVBUbitRM1hmVzJHRk05SVJOZ3VNYUZzN2RC?=
 =?gb2312?B?WWtJZHJuT3UyQXZHVW1QSkg0eXFKM1BlYzEvSmFOZjJ6UU1KYjFZdU16QnZC?=
 =?gb2312?B?TERkby9mZ3JYWHBaUXN0Y1p6U3dsWWgyU2VEeVJ3cnk5UDFTNXRyMC9FdFBD?=
 =?gb2312?B?TVFDOWVhVUJ0QWZxVk9VeitTd2pKU1VyNXBMa2daNndPS0gwalBzQTJCMjJZ?=
 =?gb2312?B?YWUvclZqbzUzU002UUROODVIbk1mNnpCUUEvYmg3ZDhpSXF0aG1FL3lvRUc0?=
 =?gb2312?B?QkJXQ29RQ3ZoeUoxclZnTnhaVGFlMDhPNVlFaVpTQnpOQTA2c2tXMVVNWmt1?=
 =?gb2312?B?RThHRHZlMGpWS3hTSUN2M05KQlRyTmxsRXVRbW50ZG9rbno0emxaR2M5cWNO?=
 =?gb2312?B?SFNkZ3ljZU1EMHovUXl1dVJiaTlBYTJPME5UUkgvS2U1WEpzcFptSHlabkFh?=
 =?gb2312?B?ZGxNVlJpTDVUTWg2ampXQXRRanJ0QjVacXVVbFI1eWZ2WFp2bkRBNUJHREc0?=
 =?gb2312?B?ZzBTWmg1ZGtrRE56Uk5TWEFFbDkrVUNDNkJDR1ZJeUpjc3BjUDMydFAycjg0?=
 =?gb2312?B?QVZkVjdZVkhRaVBZRjRiMFEzcGt5YkNVRWpDaStBUm0zaEZ1eDgxNVNMYVE3?=
 =?gb2312?B?cDNWK3Y5VStTYWxuQXd0ZVQ4UGVxRE5mRjRRSlJUWmZoMnErdC9SOVhmOVdO?=
 =?gb2312?B?UERsRU1vMEJtcVFTQVNZRm16K013Y1MzK1B4U2NJUEdRdHdhSnlUNUROVTI2?=
 =?gb2312?B?SzZCV2hiTXM1MmV5eU5HZzJkV0pJSUxrSzJTOTNXS0lRa1BMV01OVFN6SHBO?=
 =?gb2312?B?cjBjNHhXcEhWVFhqc3JwaG9udFNtUy9idkgyaE02Rk1oOGh1eVQzUm96RzBx?=
 =?gb2312?B?QURkblMyZTVmdkhnTDdJL0EzNVRPNlN5UmhuU0VUbTZkeWFNbGJNRlNKYWEw?=
 =?gb2312?B?Rm92WHloTkpCcFBEb0ZxMkdCaGpSNzZYYk5HNzZYRldlM1RNc1I4MzBVT1R1?=
 =?gb2312?B?RkhBS3hyQVVSdVpkcnM5VjhWSWdwRlFFcHNpc0F0SGZJOThXNGxRS0ZHN0Ix?=
 =?gb2312?B?dnhsU1dYTjZUZlNxd1Z1anFrNjVYSlVlSnl3MGNENUtqbm12OGM5c083cE9v?=
 =?gb2312?B?OE5LWkdDdTY0bExXZEtNazlWK1VCS0hxSFI3Z3ZoZWNoaHRtejE3cVVTeU94?=
 =?gb2312?B?R3dlemlvWVc4eVc1NmFWd2tiK2ZTaGtpM3l4SHFLOGFDYkJYNEdTOWFORHpE?=
 =?gb2312?B?RmYxRVA3YjFpT2ZLYlpkMWZHSzdBRllZNkgyZkM4QllVTkl2d1liVW5ISDRp?=
 =?gb2312?B?UWhscDVXa2o0SmJPdGZ0YTMxdmtQWUJWMWZIa250NTB6OXNzNzRndUxLUUFn?=
 =?gb2312?B?c0hUTitBd1VjWStSQ21lRzRQTnlKZjVUMzRYMThKbmlDUjEvUlZmVmJ4SHZD?=
 =?gb2312?B?VGRsaU9VQXpIeXM4bGI3QmtUdGVub2hLTE5ONFZjTHNDSTF5aGRmZVRwUW55?=
 =?gb2312?B?WmEwL2UzeXR6L2luRFVyVzRDMC81WjA1NUhnK0hzUzF0UExza2xoNUFoTlp6?=
 =?gb2312?B?by9tQTJxUVBYVjZobGp0bzVBeXBGdFBGSUVyL291Q0UzTFRvZDBzS1RFVUxE?=
 =?gb2312?B?a0lKV3dxbXlnYm5hdDIvTHl3bjJJc1h0dGdEbkxRdTZzbEdWMWVjNzE2d042?=
 =?gb2312?B?TXc3MTl1V2lLVytwUHN4bWpRWXFzbDBSRUxwZk5pUXRZY1NIMVJlWGRvTVhY?=
 =?gb2312?B?U0NNcUN0VXhYdER3OHBOMUh4cnFmTHZIUW1WVFEwS2JQb0QzcGJJVVlIL0ZE?=
 =?gb2312?B?dVpUck5JWjdUdTIvTmp6TWhkK0ZlY3NxTkJSTy9VaGZhT0twTUIrdEZGZjNi?=
 =?gb2312?B?aXZzZlY4cDBKTjV6TW1QZ3FyaHRldThITmNHS0pMTDhTMVlZNTZZQU9qMzA4?=
 =?gb2312?B?ZnJZQ1V5Zy9HUFZsbE5STlhMUU5YMWpqUHRLU1hrSGd6a1c5WmdSZkF3aC93?=
 =?gb2312?B?TnBOZEFUZDhqRVNGTHQ3dER6ZXBBemVKcUd3c2tRRG53aXFZN2RIaDh2ZXF4?=
 =?gb2312?B?UGFqYUttM2VYSythUGdFT1JRS2ZTVHh1TG1nOFBNb0w1ZlpNaEJlUkdqNzJL?=
 =?gb2312?B?ZVBwTXlycm1NdTJJQjcwOVREcXJtTit4MjVMdVY2OE9hUFdQZmMwMjl1UUdI?=
 =?gb2312?Q?Sv5QnxWFtly+KgP6kNou4jIxfjJAxaZi5bWYYl+Yt4=3D?=
Content-ID: <E575362FC8820E40A78A1636867FCDCF@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1921312f-5d8a-4b4d-8f6c-08d9d0fa4b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 09:52:47.0845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkuxf3FpkNkq7V2Wia/EBcQ6kxRj8VOc+eS65m79LWf5KFi1YHe/5iunTUasVx/h/1qI3pttEY3+DOQ75yKR94zGE6uuJBjW7LpnSJdeB3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6073
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
> As usuall it's time to start preparing for the next release.
>
> Given the amount patches waiting for the review I guess that we should
> try to get reviewed and merged as much as possible in the next few days.
> I would go for git freeze at 14. 1. as that would give us a week for
> pre-release testing and the release would be, as usuall, finalized
> around the 21. 1. Feel free to reply if you think that the schedulle
> should be different.
>
> Also if there are patches that you think should be merged before the
> release let me know ASAP so we can have a look soon enough.
I think the following two patchsets can be merged before this release.

1) remaining quotactl_fd patchset
2) shell kconfig API patchset

[1]https://patchwork.ozlabs.org/project/ltp/list/?series=276474
[2]https://patchwork.ozlabs.org/project/ltp/list/?series=279588

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
