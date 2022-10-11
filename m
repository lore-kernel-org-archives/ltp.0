Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2ADC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 09:19:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63A673CAEAA
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 11:19:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CF783CAE81
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:19:39 +0200 (CEST)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8F6911A0098C
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1665479978; x=1697015978;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mJIkmmJ+DRaz3nBmJU3XSN0nPX8a2uIMadmI+GnlO4c=;
 b=RwxZuIMxrd47an086Eu+TZen9OQ4VEh+Lx983p9kZ55wiDcQXJw3scbt
 zwpHfHzdwNEaHV+FqcZ1+IYbOHTSJPFsEL9dwNKbt3+5TPnEHjFIns2ls
 1fhu5jEFGSEzvC7nzgP294zN+Gpzy3LCKFBPHtNMzLqeDRNyYG7fMx4dT
 XQZDB0F+QijciH70n3kVJA3NoHMcGdHHdehen0L0CRGpUQiOpHmE9orfk
 gZ/35AR7Yucwoj828F+DJ0vJxl6WP2q7mb6j46GxJKPABGQPf5QlzePy4
 G3PT8ltLEWnf+yE27pht3nHM8SmxUNPjd/vZiULGJSSMd8KobrtiVgFFR A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="67144476"
X-IronPort-AV: E=Sophos;i="5.95,176,1661785200"; d="scan'208";a="67144476"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2022 18:19:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUzze1fREgWC0drHG6e8rQ43qDewALO1oc9lF+lnflRcEEiL1/4oOGMOsH7ulfT/bPHWYwDtCJ4LNw6PlX2MsFIyugSGABfe88duRgSdCHiJjrbra12fsqS2JZ+c/cmu3/0tLCsTE5S5OPoSoenxldagFXocsj0PCmrYRinbS1khwghl0PNRKqW1v7Q9CkXs8W3RvzwaNmh2KLZ16VuaBL65cLZDUw75c4Xqnzr5H7KTiNT8LlvOgKTr2Sv2PD5A1dxf6iK7W3rdNKJ8nnqbpf5sKj+mm95Yd9ZBxrbXie/W8brNWJ3nJVhK5l+MxkHJgVy92U40FSIS2+d/SWXWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJIkmmJ+DRaz3nBmJU3XSN0nPX8a2uIMadmI+GnlO4c=;
 b=ecbKrCztxGDl3sP4Ng6Kf+6hEdM04SjHtc5k+eLBOIDrLGrFgFbQVVcUQbnK5K7W3z3l/UG4Ptjb9s8LNkU52xIkATWHI8pRVB0IZdqmBC0qH+MyTl5RI0fnukJr7bmZj1jfqOs0Hi5Ho19q1f0K/NGkSyix/TTl9cQCBEKJ3aEUaMJQCaV1srAgeimbOyPDosYNqmE47sjI82f3OZrm/YRL0nGqIibg1H/vY8TLGC11m395nQlwA0ZCP2pNnRXnUTasRig8vym35rC6mjIPAsxmJ5nMBlB+jy1+/5BftOxjdQH4DXj4x4oc0BCRFMJFfsqMa7AxjIbFuLrY3yH4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYBPR01MB5390.jpnprd01.prod.outlook.com (2603:1096:404:801c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 09:19:34 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 09:19:33 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [PATCH v2] syscalls/prctl10: Add basic test for PR_SET/GET_TSC
Thread-Index: AQHY3TGcgMthCOzBKkeSYQs7/GoiFq4IznyAgAAiYoD///FYgIAABV+AgAAUI4A=
Date: Tue, 11 Oct 2022 09:19:33 +0000
Message-ID: <40ec15ce-43d4-7757-ee3a-710d42df5905@fujitsu.com>
References: <87a663als4.fsf@suse.de>
 <1665469442-2051-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87wn9692zk.fsf@suse.de> <e797b6d1-c42e-46df-df5f-d1e96470ed1b@fujitsu.com>
 <87o7ui923l.fsf@suse.de> <87k056914y.fsf@suse.de>
In-Reply-To: <87k056914y.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|TYBPR01MB5390:EE_
x-ms-office365-filtering-correlation-id: 9caad17f-5642-4715-3fb7-08daab69b5ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fo0Sao61PKeTY5f2S3UlFJesrI2EjQWITWtID9IY/2VL5/WKv2NizLDaVfw1LwFBPHkujSmtrlKFEyxL8T+vTtA6lD8mGMVA4C5aTJdo7rp65jW1jsKHw9ndXreExhq10YDiDGV305D/1Y8KnhTAeV9fmcpUxCb9LPc0FubtVHbT2Y8ucug6lyy2DijO0MuvxV0Xx1edGwa4FIy7i5wZsl4k9OcwDRGgq+Xa/dl63lXDjDqm5H7J9ZTQFRoNv1kBuPaKyGkw8BTZuV9MEo+7HanVKBUc7kOu3wsIjBp8m2+tiOzI08J68AcobsFgn4TBm1fctdehXa4AVGBJd/HA9U3Eh6eX88NY8mIazTGlUH4utPM2q2blL8v6z2mEzQQjqWKrNfD3hj858D2uMOIwjWekTNpXNOIvuXW6/l1ZFh/bIRkcNDXWfSnLc6ebYr+WtIK4jpXBQDPgJjmK9UYnws9MiarMM2lK94CBIWz/SYM++cNGI4oDz33ijV017yUmBt0buzTEDxzHtbjhjvtuS/XfRFa9MfJbE6C6iq3FO9vuNw4v+YbHxKvdYWqmAhqKc2QWovS2KljpkjehnsZR/8N/rlerHcmzm4aHhzk75HhpUSoM168BwOS22cSVPOGEdLP2dqltRj6myJSKFMjoyG6kBKmwU4GaUL8ic6p/8gEfGaR/jnYD2DzmcFmOlvEQBnxtyb9XVT0cnCoo/1D+W38A22yEMhaKsjIyKlMxc/KQ6cQxfM1alSZ+TUA5W6yfDdh+PXLDQrS6OcJuKJ+hybJ30I64s1xVG7CI0twEx/ZSnx/Qh+xwtmGL28sUt4YTOK0lppLLIoC8Cbnhhv/Rqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199015)(1590799012)(2616005)(38100700002)(122000001)(31696002)(86362001)(558084003)(36756003)(85182001)(82960400001)(38070700005)(316002)(6486002)(71200400001)(478600001)(8936002)(5660300002)(66556008)(91956017)(66446008)(64756008)(8676002)(6916009)(2906002)(41300700001)(66946007)(76116006)(66476007)(4326008)(26005)(6506007)(186003)(1580799009)(6512007)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3laUmFlVURZd2FmK2RWKytlNVZuMlNiNmRrdXZ3V2haUlM2STREc2pCeGY0?=
 =?utf-8?B?T0syS29iRWt2eVY2VEZ1YUVLcFZ2SURRZWpkNTlOQWhRaHhEdlVvZUM2WUx3?=
 =?utf-8?B?V2gwKzJmRGdDY2MxeWtYeDFXdEVIdE9vbmlpamdPcnZQVTNyV3BGZE5Xak50?=
 =?utf-8?B?SU52NXVWZkMvemhLTUg1M0RlYUk3aE0vVWY0cnFBdEZSUW5LT0V6MERTUXRW?=
 =?utf-8?B?TER6bFBuSm9wL0dvUXExaVcvZE11RVBWOW9WNVp3VnpTL2R0aVFIYkl4a2pj?=
 =?utf-8?B?RWc2cWJ6U2VZZjZyOVhCM0lWR0NjY2M1cUM0L0JJK0tpekNkUGdxaFhHS2JE?=
 =?utf-8?B?ZmxjcTNId1UrQTJXREJaM0crTmRWYjBVSi8yUmpZeEw5UlRwNXZZYWhJRkor?=
 =?utf-8?B?bEZMS0JKajNOU2hsbVZYdkpSeldjQWtKdzU5U1NvWG9kZDVWckt2NmdSU2Jj?=
 =?utf-8?B?QWJ6V3RtczJ0NVZTc29STldkTWJmZmtZaWpoWUZJQ1U4L3phZkgycUF5WStM?=
 =?utf-8?B?QWQyZkJDOVBZMitBMVJmV0tNYkMzNDVmZVp4VmxFU2VCeTZjbVJCa2o4Vlk2?=
 =?utf-8?B?dXZaUnpjZXM2WmtGQ2FXMENNRjhsVnU4OGZvbUNzcVRVWENGWmNYb1lWcDBZ?=
 =?utf-8?B?eGtwRHN5c25UTDZEd1NXckJydC9RN214THUveC9tejIvc2ZGb05oMFVBamVo?=
 =?utf-8?B?SG41d2lINXl2NGNJTG04KytDc3puK0szWStHYWdsSnJMRkp1NkRJN3hsNXI2?=
 =?utf-8?B?bHl1N0syVzZmenI5dU16b1duMHBXVGJFWjJXTUlJVG1IbUtoNUpWZ0NFVXN1?=
 =?utf-8?B?Wm10cDdyTmZ4bnZKL09uU2FxOVF6alo1d01iMjJRdHBBYXZtQkpxZ1MyWUpO?=
 =?utf-8?B?R0EzditHeVZNbS9YbmhPd2FDMENkbTg3bUZ6dzh1bkZHQ0c2bjBWdkdzZ0kr?=
 =?utf-8?B?S3Jwdkt0T2w0MHNzdE16aWFnVmhMVGFsVWtPQ2JuZkI1QTVjS3gyNVQxeTJT?=
 =?utf-8?B?dE15L1I5cDdqa2FkSFdUN0xoMFFCRm4zMkdTWmRQdGtWTDZocXVNUlozQ2lQ?=
 =?utf-8?B?bi9WL08xY2REL0Vnc3FLN3dsT2JwY2RLMWJoLzRnMmN3NElYaktNdk1CeGRp?=
 =?utf-8?B?SmtTSjN2WmwrR2c1dDRrTHpTTXplaHlFWlZYY0F1Umt5cGJvMnlSZkZqaUh0?=
 =?utf-8?B?ci9SS1U5VGZibHN1bndqVGY4R0lVN3U0UW41c2MxMDdrSWc5eWpWRksyeG5o?=
 =?utf-8?B?NURWMXVoSTc2VVFlZVBORWUxNUdkV2lIVmlMZzFMU0hSZklidFowUkVjSmJx?=
 =?utf-8?B?d3lqYXE5Z1RMMUtPQnQ0WjcrQ3RyUkhNdzlNMWFLRFhhaUtRakIvVG94ZUpo?=
 =?utf-8?B?QmtoTkNCRFRuQ0JQbWZ3Mk55S25vY3RkWjVZbTNvaGJWbFcxbHFHejF2SFZN?=
 =?utf-8?B?RG5KcTdGaWwvdlQvRmNObVB0K2FQUlZOSEdwRC9JOHdXeVZWdmVxUnpRdGQ1?=
 =?utf-8?B?d3N6aVRsdit6eUpQT3QwQ1FhRDh2RlEwcnQvMEZtdzJVYWdsMlVycUs5Q0d5?=
 =?utf-8?B?Mi9pWHNQNVRwWTRRQmdzZVlTNnl5eXlnZi9SMldMdDMyZnByRG4ycVloYnZP?=
 =?utf-8?B?VVJXeXozQmdDUWw4MHVVaFU0QlJyOWpPQk1KaUQ3RUtpdVJ4TnBOdTE5YTRn?=
 =?utf-8?B?Y3dyNWtkdit3NzlVekNOby9oVUpvK3lvaEVLbkQ3RDhNc21YS093TlRPUGFn?=
 =?utf-8?B?OE9CM3dIeWNtSno1WkRIaE1XRHVmeHc4U2UrWEZzY0RuNEQvUDl1Y2hrVXBG?=
 =?utf-8?B?YjBBbWlVaTNqZStyUnBlcHZhaWIwM2dJS1F0Y3hIMFZSNzFoOFBURnNVYnZV?=
 =?utf-8?B?cWNqTkozYlk0YkJlQ3MyTUJwS1lVRFF2K1hRVTl3RTh2VUZUTFJZZlZhMTJB?=
 =?utf-8?B?aW1TYlg2N0hwL2ZPYVF3M3lmNDQyejBiS2EyQlREZHNSYXhsNTRCVnloZklN?=
 =?utf-8?B?cTFNcWJ5bCttbnhwaWtTUnd3MEVFS1F0S1YyZWxNTVJ1ZDNiYmFNcEhRTWZv?=
 =?utf-8?B?cjA0a2p6elY2VzRJd1I3NFVHSzMrTjRMVWltVmZ6cDZCdHNBV1g5RFFRTEJ5?=
 =?utf-8?B?Ny8rWUtpZWw0Rms0TSsyaE4xdnV2QTRWdlFqWDFyTzFURnI5d09jU1BPWXFu?=
 =?utf-8?B?WlE9PQ==?=
Content-ID: <6A73ED1D3DEB5F42A917D26EDA41B915@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caad17f-5642-4715-3fb7-08daab69b5ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 09:19:33.7796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9oSZ2zva2HD7AMuO5c66qzjK5mQwkveRoaDC0rfosFZgrzgqUogC2uPw5PKJmcAUOU8TkSgug8vscerpGdOP0zwFa2CkoNuhH8BEER9e6Po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5390
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/prctl10: Add basic test for
 PR_SET/GET_TSC
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

Hi Richard

> 
> Hi,
> 
> Merged also with a preprocessor statement wrapping the asm so that it is
> not compiled on non-x86 arches.

Nice catch, thanks for your review!

Best Regards
Yang Xu
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
