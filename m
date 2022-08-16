Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30E3C2BB41
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 09:57:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B37C03C9886
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 11:57:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62BE53C97B2
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 11:57:17 +0200 (CEST)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B194E600149
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 11:57:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660643836; x=1692179836;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RmmluThP113kSSJHleYMbNH+ypjkhOJN3RNWybVUP84=;
 b=NrDjTjBw5mpCLKuJL2vQ7Rz+Zb8WH3ppAQ23jQctUGRW0cpvShAkOxAg
 Y8lNjsXePnq2hOs7a5NTV02nOhg5AZjXKrgKNEubiFNvTIH7g06qd1DmY
 6bnTYG2vPLvc7qwoXb85dSygV9DRnidTmxynXLa1PQZsLvxW0zsA0FbSW
 NZ/MqkEEu2QS3mEzRvkn0Mj1vJs9y4HUJhYs09W/J0/HuhqIzWRZ+Zph7
 DNLTqIPlnXY4Ag2+waZKJYXsg90VTkcHGk3BkChcJHiFjOfDn/AuIQ1j3
 2zaZPE8E4CPeTEOVhsiArKs4HzlLSG9W4u69cFazHhNqA3TiPQkz90JAE g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="62782049"
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600"; d="scan'208";a="62782049"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2022 18:57:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chCccy0PGF1TL9uU1B4d6IPOXA5x0VJnqHi3F32j24gJOa8bYyl7mckbzYn3su1yqhqz8E1zDQrntWvuOUN2HPPPTVgeh06OESOUHg9KVxdTNh8rLtCt8b5gnD+mRydc1TwfNeNKHhvGnLD1PytL0E4qbMSu05YFnNzbWjIhDIi549wenp54FoIdhlFM7FufhZR8DqYvrjgVtboRHPgjQhI4m8wKHuMOMyEcSPfmV2G631vfm1QNkBamw74lc46S1xjhBIHmT2PmpmpiW0+Trks0ihK5jo3Uy7anENw0NmmWg3eIWs5uG74J/vlfxSSyQXuio4vkPzkHbm/K4B1suw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmmluThP113kSSJHleYMbNH+ypjkhOJN3RNWybVUP84=;
 b=dZDEgNpJuoZquuuGP1h8WcXwMwotnByXqbx7iivY6kYvSxYsi/nNEBU1ivAkjpFKXJ9kKxDU1r3jUkKaXC5omCfFmeeMIl0iHvvgbOxShkssS9/mIB4tudx1UtD19SmYLktCJYG5HciT+jYueTnBl8dqZq2mvD7dLSEenm+IyVPRM+Fd7tsoNjajXxdwO/YOmYFUDWqBWyP/6E8NNrp6NuUnalBvlHTJygDnM5Ddf0kUouM2Z/H5qCg6X6FjVBXr/Kc22va/TmDAvRSlpvxxNnTZ3APa3JwsgB2Yx/wH/0Kl8/ooIid0VCOmevxLhSR5VByOIQ+pry2nc+EpK/1RFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB2059.jpnprd01.prod.outlook.com (2603:1096:404:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 16 Aug
 2022 09:57:11 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 09:57:11 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v3 0/2] mount03: Convert to new API
Thread-Index: AQHYrYpdivkAy4rXlU+UH1tz7IrvUK2vgeuAgAAG24CAAYDvgIAAOGMAgAAB3ICAAB8QAA==
Date: Tue, 16 Aug 2022 09:57:11 +0000
Message-ID: <70476626-2c7a-fcd6-4cf4-de7cbd572f99@fujitsu.com>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com> <YvnqZfyByO42kAX9@pevik>
 <09a4ff13-eaf1-6a97-f868-893c56ac6b4c@fujitsu.com> <YvtcmjNXd1P18V1g@yuki>
 <YvteKeEbQ9aSLwnm@pevik>
In-Reply-To: <YvteKeEbQ9aSLwnm@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48524b82-b21c-4e6c-5e41-08da7f6db036
x-ms-traffictypediagnostic: TY2PR01MB2059:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bf8tj7jrAp6+XiAPI9CtYuaX6Y+LiMz2R5A3wNytk8rAS3buj7jTLFd42nCrvQgqao+7PICJxRmhFbcPwwYQKBatDdChP95jvOPtgCzKkc4qQnY+uiKPlxlVczjHz2t7tMBsN68zsBMleE3lk6+EyAnNTg0FYIX+txoSmrameuU+h33qHPPpwPAshSWyeqIO4yA6aqOEL03/MSH1/X1Keympdc3O7lWZTZbCVXBOLVdO3R01a2S3IWP06yg8GsCtVUGASL9fnVNwbqw+Q8l89yEW96vbQJrCnbXd21tmEfCge/nO6FmWxtI35mI9SIDZ5zLwHWwuabyGO3WoEkpQZ4CcKjUMzlO7DWZitaR6CA38c8uHXSTzeO9XG7uKj3djJoJu5WoZlfSnbhb9LCHW7tM8LE5X33Z5AZOAjrB+crbIrIKu9ZSNPwL7ZcsDKTGbSsOBt6m612F8u7Oguop73mHVMlUUgxAz8eZtgyevurPhFBHJ0fEhj+DRqWcMpKhCGTweeFktW9hyvNhETZLrfmKhSgJe8wxPrK3kvYZCEpVAurHIPJKehHkvSle9hhewdq06bvq9uacVRPAAClQg6ay/K7HEI+Zs0aKhT+O2q+6FE/BrvWkX/TzrOaqd8lJGTA6gcKOf0MY0sPzaPQSWSaGTTV+wO3EkQ/yBNSq4dsC2mcSkZkSVUKQAEJ+caisIufRfSw6Gsoxqjhh83Rtktl7ehWGyZ6iY6AndUJEYJpOwYXbZvjk1oUf75OlGpWuohN9Oz+Mi/gQyTI3k+fH1fWc+KuLs7FHP6VSSHVWbR/7YJHUDiEqii7ShX05uZjW3dhPoy7CHYCXIvF/6DBRXVitRZp3wxSc2IS8KrbjmuAo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(26005)(478600001)(6506007)(6512007)(6486002)(4744005)(8676002)(66556008)(64756008)(41300700001)(66446008)(66476007)(2906002)(71200400001)(31686004)(85182001)(1580799003)(36756003)(110136005)(31696002)(86362001)(316002)(82960400001)(2616005)(38070700005)(38100700002)(186003)(5660300002)(76116006)(4326008)(91956017)(8936002)(66946007)(122000001)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWpmTVFUam1BQkxTNzhidkxPSll3YnJqSjYrOEFiZWZ0OExJVjhJYUlrOVBm?=
 =?utf-8?B?UlovNUdacTF1bTRuZGZXbG1TQmdhQVJSQnZvL2VXNUFGVjN0YVpvdlVXK1BB?=
 =?utf-8?B?d0hSamRQZW9zdWlsdGtSWDlXdGhubUNHY2kvd3k2UXJhK1dyR0xIRXVlcWRF?=
 =?utf-8?B?V3F4WDFOdzZsbG85NGE5NUVucHdRcWhlK0hZdXZGUXFnZWM1ZzlUbEhlM2lY?=
 =?utf-8?B?WFZFcnV5MWxGSWYxeVU3UnZKU254TjdtZnRMUGJBejQvNUJmaEdhVWdMb1Rx?=
 =?utf-8?B?cUZmcGtSN2JWYW1PVFBPMXBRMWhCUmNGSFRZcTJXVFRUclA5cjdmeGtFdUxV?=
 =?utf-8?B?Y251T3JDUjBIRUxxQkt5bkQ2cFN5SGR5MG1GQmp2eThWR2RyUGwwSTgzUGJH?=
 =?utf-8?B?anRXOEtjbnJjNnZzeFY1MTk1bGxsWkU0STI4eUNsVy81Z2pwdUJHeCtFRjlI?=
 =?utf-8?B?NzdmWmdDTldpM05jSUJPQlFTTVM0QmxTb2xlRUZUNGtYMlBwTEZHSzZhY2F1?=
 =?utf-8?B?dTdsSFExcGtiTnpuS2tTZFV5SHVUSFJycURtbmNMN1l4OU45QkRUZTJzeVgw?=
 =?utf-8?B?RkJQbGw1MlRWM2VhYm9Tbm1MVkF5QUJWTHVKRm9RRUZ5VC83N2J0emVtemZP?=
 =?utf-8?B?V2JFNVdPQTlTN2dZUkdSNE1UcGJldUdTL3JrVDRiWDdxUmZFTFNJWUhtTzVH?=
 =?utf-8?B?S2t2L21WOS90VGNhUERHbHdMWG9LbUZCeEN5cjJmYm41Z24wU09YcVdtS29C?=
 =?utf-8?B?RHlSd1VKRTM1RXZsSHdYT3BDY3h5em91cDhtM3JlSE1jbC95WlV4bWFlSmNn?=
 =?utf-8?B?VmNHd0F3UEVKelRTZEhrS0RidEN4R0dJVmVEVnZBejV6ZVY5cHhUZ1EraTYx?=
 =?utf-8?B?THo1a0JaTFlRU0UzcXdhZ3pJZW9lVWdSK0hXSWhOcnNadWgvZ1JyV1l4dlVt?=
 =?utf-8?B?NExLdDBjUkcrd3hrek1GTWF6bUtFUklleklUanJTeTBPQkJzVW50MHFiTURL?=
 =?utf-8?B?c2YzSVB2TitzWTZwL3hkaFA4TDVPY0RUazI5eTIrQkk4N05tQ0VIUnRPaURv?=
 =?utf-8?B?SFFvTW9nQzl3Ky9TSk4wSlBIMXRmN0pjZ3lFdWtTV3FEQTdQdTJwWHJCdG1m?=
 =?utf-8?B?eUFGOGJMVnBncWJidE5IWmpyMCtsN2hwNHB0dWhFVUpaY2Z4QzZnTk8zdEtU?=
 =?utf-8?B?T0txT3dRZ2JQV2pLN3lhRFZLenM0WmNTcEZqVU4wVkJCUFBPUm1vL296QVBW?=
 =?utf-8?B?eDJXeVZHWkJMeDZoYkViencwOE04aWhLUnVGd0VpVENWcjZLN1U1TFlPdFUx?=
 =?utf-8?B?cDNTeDdCcXdGblpvS3UrZkJjaUZZa1NLeG5ZQTZ3a29TYXFsNDA1YUQ1SDZR?=
 =?utf-8?B?YXNkQ3JyY0M5Wlk2d3lWZWJGZ3FRUFNDSW5BS3RCTnFsbFp0Rm5ONytxN01Q?=
 =?utf-8?B?US9IVE1tdTd0WVlpQkorT1lRVys3YitiWGVYS3dqem05bUlzblRWWjRyZEVG?=
 =?utf-8?B?ZU1kU1cvdjc5azVHbTB6NDZJZWYzWXhxeGRhYi8xRHFaVTl3cG1iNDJzNzc4?=
 =?utf-8?B?Y1hleWR6ZFFFdkh2L2EvWUJ3aFFoR0s0RllmRDhKbWg1OXI2dk4ySGlQR2xy?=
 =?utf-8?B?WFVreW5WZmxvZmlkbDRTemo0SDFMWk9wOEUwc1JoR3owUVhyMzBmZXpaQk5C?=
 =?utf-8?B?Z0sxUnhSNlh2RlZnVFF2NytxQ1Nid1puM1d5ZEIxRnN3dDVnSHZlVE9mQVBa?=
 =?utf-8?B?T1V2eXg5MlAxajl4aGh3NmZQYjJNbGZjbUljQkt4RWNoenlCcmhBSmdzSVJ3?=
 =?utf-8?B?akdCZ2Fzanlnb0RQckpTbUFOUXB5K1R5SEQzRDl0N1NSM2JtVkhmWDU4VEdK?=
 =?utf-8?B?U0tUTmUyMFA3d3FFRHYyZld2TWtsbkxoV2xEb0E5MEFCVnZRVVU4c2hWajBI?=
 =?utf-8?B?TzI3RkMwLzlSOTZEZ0tvZVZRdUkxSjIxcWxhMUVMamIyR1ZGeFE1aFZZbE1a?=
 =?utf-8?B?TTlZdzFTeWFKcnVTMEdaWHY5eXZkVkpleVY5Y01OSHBWMDY1N2RiN3lxMXVI?=
 =?utf-8?B?OHNVNkx5V0ZBZDhVNzBDMFZLd1NLYVNjMXJqQXJFNk42Tmx0cTRQYWk0UWtq?=
 =?utf-8?B?TG8vcW9JYmpYdDF4dTBSeVhxaDgwUVoyZ2tWazM0b1dRZFpCdmRYazBaNHh5?=
 =?utf-8?B?MFE9PQ==?=
Content-ID: <3F5D1F43FFEABE4DB3A93FC31E5CEE51@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e0YbPVbXy5Oj6mvGnGuTe5F/QLtyEH0j6Mh/J+hCJdiRoH/vMIwqA2x7TmyJyuYU+dq+iNqbkIIr8PBNtvxbaRjMN3UXQlUvNrgzi+mUK/HGooDUg6fp9sbuf6aAq23dUDyLIVhVZ6J11OXKc48vkgN4Vm3bxAOixdfytoWdwH3kRoSIR/XVDFIWJGl6fkicZjMwkW7O0EKiyqtBSieIKvFE8AnfA1kyt7BIiF/q57bk0O4uIgFkUKCZ94NLKoExHh7b6TljfmyTb6OqK1Sv1meCIrvMGJIRXZeAOXMbiASTIhZ1bxQRtzVukvuN4+Ea4+JCHyFa+Q6dwoEgB4vfndjG8NmylA53yUZwj5sSCqDvjn5PJo7/7M97b83+8ZuVNJxHf81p07j+g6TH8AMPvIWPCPbjq6h3mPYKg7soKwXzFzQSp3cQCrXuydXcgJesRIhHqY480CRrwsZ2tyKzhaBWyU3HXxurV+7pWSKrMZgGvHLH2AFXFQBAVrG92up5f8Rgxw6YWQmHHu5I6J3ApcltM1rEA2uwSMt7VDssVc8tpleztjErVeyoVQ8rZEMgwawenkwCvclGUwTngdoCNid8B9kupLAUr92i6LnpKXh6xcuRw59Hu9pTTdB3mRLOaGs+klt6Wa1xd7E7VjYbA4O8CWQEKHYcoDZTZqY2KRaCcgQOPcL+hrD1Rnl0Eg5ygQInFl+ncR7itxR4KP4M2Pj11Si+S6k8nmfc6txz1uVfPX1FjkK1Ht8aiilkEn/IyvutXRA136aK16q0kdViAVJMZCyBRuC7Bu35N4JZflo=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48524b82-b21c-4e6c-5e41-08da7f6db036
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 09:57:11.0706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcB34Walhje+CnR9UNHgTmsTpjtjaUImg1PNNajLgbh3qMek4tokTtRhVjNaDzeLyQSuvNBEWaQtXyX66g+u+pYkQr5qME4L5rUUVUN0G+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2059
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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

Hi >> Hi!
>>> So I think you should use  SAFE_SETREUID(nobody_uid, nobody_uid);
>>> and then use code as below:
> 
>>> 	if (WIFEXITED(status)) {
>>> 		switch (WEXITSTATUS(status)) {
>>> 		case EXIT_FAILURE:
>>> 			tst_res(TPASS, "%s passed", TESTBIN);
>>> 			return;
>>> 		case EXIT_SUCCESS:
>>> 			tst_res(TFAIL, "%s failed", TESTBIN);
>>> 			return;
>>> 		default:
>>> 		case TBROK:
>>> 			break;
>>> 		}
>>> 	}
> 
>> Can we please stop propagating test success/failure via the exit value?
> 
>> The problem have been solved years ago by the new test library, the
>> child just need to call tst_reinit() and tst_res() will work directly
>> from the child as well. See execlp01.c for example how that works.
> 
> Ah, thanks! I should have read C API docs once more (it's in "1.8 Doing the test
> in the child process").

OK. It is time for me to read C api doc again.

Best Regards
Yang Xu

  At this point there are so many changes => I'll post v4
> and cleanup the child as well.
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
