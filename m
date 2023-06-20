Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF716EB64D8
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 10:26:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA1463CC4A8
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 12:26:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D55FE3CA9E1
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 11:24:27 +0200 (CEST)
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3DC2D10009DB
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 11:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1687253066; x=1718789066;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=pAPrOl0jL7zG2WVA/KF2bjpzN0shSCn/jgNNf6EO3Zw=;
 b=e/pvfOLXWNMSFc0bApAdkqAz26Fymr1+vgZM7JKRM43os5ld5uskBBHk
 m+mS8rl53oOkBw77u3dPn4WM/9ycKSCl6R5nAkXpl7e8f0FQWk5IDLxXP
 nd0O5gF9s7jYLPB4SFgX6rMabCAMV39Fpkm/NVPuVsl5t7LVTstX+/Ie5
 hWBQx3UTPg3dO4x72U029e0QqgOc2s+N+qLwwZaohC+HmdhpOO416SKm0
 7pvC0smgXJSbAIyolVTJZtwxJ8G3DToEdhZEP/XYMXoa9eme96x8MKlWC
 SJ5qsrp5TUH4Obz8vl1fpuASNRujcbSwSQla91QHN9HGgTewe9bVQsgyd g==;
X-IronPort-AV: E=Sophos;i="6.00,256,1681142400"; d="scan'208";a="341084399"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2023 17:24:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BktYrpz40aCIDEgA3KBK8f5tC9xSZnRiH9Ybl8CUagpBYLeV55XnMaXaVK3LuhefRdJM2qoNv8wab6gWlAXJzw3tWzSpqRQEqvygeOoX1UG+iZ/3APjwPXjBo+iuPbJ3BwsPWx+hsJ1vdPNYP0aUAmMq/oCzVI47ZJbKAyuHv/OPD1TN85/jCk1UCWX0eRASfORNXksw2NY0m+QXr7qqId8ZqGbCTl9jWWNt3fF6IRQ0WZLoGX1UxNztCOOdWMeKPo4FGlrYRv7qOrRVMdFFDziGic2MemAJ47kcyqGi0cLJFfvq9t1d5DT9/wb7WKPuerDiZ6FuOPdo9WcvzaPHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAPrOl0jL7zG2WVA/KF2bjpzN0shSCn/jgNNf6EO3Zw=;
 b=WPDNAukV9ppRTBH2jyPBig5qEFtG8mDWBDVPIhA4RExnEgQAX/+3w5+WlWLLwRzz0Vj2qAjWlp1PmjlaTi5ayYPJImFQAQ0K8/vZBxPnDEJzxaiEBly1EWqnes9RSr2aucmQFVWS3EcaMGsZ6hAg8jclCywjdivy45V1FmH1P4oht3uDLpoyp98Q2c6N2sPmBY0xO+QeyhQHX259J5Wa1QeEUBsvbMy3NnWsfnGygw1pecSTrGm4vEcoF31hbLPTNgUl5heDBCpFdLjebu8WIhQkgdW76r47lRLVZsWLlySNN4FB5t1Pd4ZSwHmA8ze/J88SRmzEu3urdimvGRtWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAPrOl0jL7zG2WVA/KF2bjpzN0shSCn/jgNNf6EO3Zw=;
 b=J8RpAHAYpSXmJERqTa2CR/iD0DiHqwNyuzjKo51+cH6nvFxgOjp1UlP0xUK3IOIFdj/sPedjM2fvPvsRDqqmNeioH/Q2YISommuaDBIFz3OQHNI6j89ZvmYE+ODev2XBX6D3b4ePY9amA/3wq2tTO2Jc7ejoIouNZ1P3jwGKoWw=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MN2PR04MB7117.namprd04.prod.outlook.com (2603:10b6:208:1ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:24:17 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:24:17 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 0/2] Improve ioprio tests
Thread-Index: AQHZo1d78K9JAcUirE+IhralZe8ql6+TaTOAgAACFoA=
Date: Tue, 20 Jun 2023 09:24:17 +0000
Message-ID: <ZJFwQRo8dOZICQJ+@x1-carbon>
References: <20230605044131.798383-1-dlemoal@kernel.org>
 <20230620091316.GB275381@pevik> <ZJFugRCzFlZYL934@x1-carbon>
In-Reply-To: <ZJFugRCzFlZYL934@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MN2PR04MB7117:EE_
x-ms-office365-filtering-correlation-id: a37b7f3f-e347-4499-ce98-08db71701f03
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8oOLARCG4IJMqPiupmGZF+k+ktiZSMCseEtTHtWGqaNxgg7r6zxGy+SC8g3rTZjfWgjmME4BBH4U3OnK6tIjzaRv26zVTnQM8umhQahjo6klDgm5+7+YU3zLD101VHka6KW+NccdJ506Ijg0/vD7X+5SGo771EwRI4/BFIePQo57ls987A60uVp7WT1nQlFFWUCa8lvB4cG/6EKm9d1k8nQH+i7fmZvpJLqytAhqiQSb/nWRA6c3+eQ2MJ35lV0PndPdni0zyvM0TyWKXbXZz1YzKF2eOWmKnx+526X8GrSHjtsMkbgVzM6Sl2d1KG3rYhcsxmF9edbzxUYB4JG+CBHz+ge8/8gZnxFnGNqoX4bdCubc2xKrhEo0AXBql5EYlqHm7acyjPBHiJ0YOg1Bz3oEtPZt7qaf3W9tNvTEkmsNgI4LG7Da9eFJiIB2qu4ZzkNYKglbrp9YMKLX3scEdvhFvETnGa7kZL6P7sXS9ZAH/GPatqOO9nb+uFtq/KWRT6T8b/csbm1a9V3b0fjQbCUOb2WcfGgI1Hte+n5nMDVi5db+H6daGykZ28HmJ/HiCkxIlwOBpI9Nv3zkCF0ZPWLUABKRHyt7KqI+g0CKoPphmm6jH/QrGbeZ3aKiLfq1TSYwQr/X87Y5/2DSF3f9nh0yqSycHyXkoyqNzFilS7I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(9686003)(8936002)(41300700001)(8676002)(33716001)(478600001)(38100700002)(122000001)(71200400001)(82960400001)(83380400001)(6512007)(26005)(186003)(6506007)(966005)(6486002)(38070700005)(54906003)(86362001)(316002)(4326008)(91956017)(66446008)(76116006)(6916009)(66476007)(66946007)(64756008)(66556008)(5660300002)(2906002)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+4QL0ZiUv0Xd8/yBSQHKGec+9fsN197V0D9vR1Uv+XoL5HhcwnRdtsb9ACg6?=
 =?us-ascii?Q?Z2V985gvBxABxfDmAGjmD4k/53koEgpQ4VGBgDj3FNrLKmwe6aG4Os0F2nB8?=
 =?us-ascii?Q?ozUz6yC90oC3YOSvjQOjtf6IzKEy1scimDH1g0rQhO7wgUaxYFFHICo3OMBH?=
 =?us-ascii?Q?CMLifwK1Fl3t98/areh/2VS4hEdKJLEtJxEe8Uh8Xf8wqC0ZeFG115SIGbah?=
 =?us-ascii?Q?rqZHUFYNmsQI9zjKRN1n7PBckbhJhP3KjJ/QLhOEwm0oGpxSAVEazKCCzh45?=
 =?us-ascii?Q?3drsegtnljSi51EUSjyiHLEUvoqYIEzPi4VJg3b5IrgmlHym/MSP4fEPmhqm?=
 =?us-ascii?Q?EWHsJ+efozs33OFuGcN9y8t19p6bZ8qzcIxo1Nh7EO+dK0nuYIKc5Lg5majm?=
 =?us-ascii?Q?6pDbsozlX6Paydx92Uo+T8nrxBolqIb+1tKLW4yqXNnZS4esQGj/ECx83b0g?=
 =?us-ascii?Q?5XS++KTHl4MUM1/It+tnlAgwieA7C44x+Sv9RdxnfQkzmQ3JUYttpQaivXHM?=
 =?us-ascii?Q?DqlM7JqEaateJOJeIu3zDXDYRX/IujQT1303vX9jG/EXdNKoKDgyH90EP1fA?=
 =?us-ascii?Q?uOdiFRVt5VdEGGWsfmYYnR3ob8spf+k4i+V1ZQmyo7ErlXgIMm8lVutez0i0?=
 =?us-ascii?Q?aaas/UoI3wFDZUU2H8Y8BT5UIjdR9L8BmV/eQXVXBPFqBZpdwD/Qzz5LWSEN?=
 =?us-ascii?Q?C+SZR4tesAykSVKxaudZw9yutEar9xQQbNXRpD0QHFVzNdkMhYa6wybF94j/?=
 =?us-ascii?Q?7+SdzIzEHXNknc0ZLIH9AKHqhdRB0tUqvgSOY44FHNHZx1PT+MtfWBnQNXdC?=
 =?us-ascii?Q?mWFHAVbFybaicaaS0GH3pE+b6cflx2lbnaHutf7o3ZZy7Qn6DcgehePGTShr?=
 =?us-ascii?Q?XD5ZOC2x0eUsbS2tWCscgWQwyY0mOQruF4B0Msy/P6DpdQmqq6Mgt81H3jyj?=
 =?us-ascii?Q?AFULGZ7cw/rAZ5mXqU1IQ65z9mUatOGTiYdQAvifHZscUhfEdgwS6VwsG3KF?=
 =?us-ascii?Q?9WQZIz8XH9/qykOwW+xPVaj+emwk26UwTRT7hWWI5+1i5PmhHMPXMKrIyfD4?=
 =?us-ascii?Q?pCHMUr6Yppp6QeJ9l76zVZK213OicjLLsNVKlKHihhiUcSVPXxEDYP9MOpoB?=
 =?us-ascii?Q?wsXpO1NmTqtdH+DR87WxLLLWem76sDUW5/qONSw9cMczTNPpy4uHCbS1wIoH?=
 =?us-ascii?Q?U8FDpBrcUPdSqz6gV7DXZRthqFVAfeu6FpkdfCkOa/sL/5vgmL2zgRNg+6dJ?=
 =?us-ascii?Q?Ds3WwszQHviAWGwYPDK1BCI6RmYJTbDAqr264zOUzdkD2EWsPhRlC9f7xJCx?=
 =?us-ascii?Q?UDpSJ80rhz/EpVwL+mfbHQw+uf4VL23d7Yee2xF1yHj7ljIAZZGO3VAb/4Z8?=
 =?us-ascii?Q?Btd3x0h1a8L6SUo/l4X15MNCy4kBbaIZiEMiEl3/dH/uxLpcGfBGinySjuzm?=
 =?us-ascii?Q?EXn8soxJJTHfKtRbDWuu33UajuNzKDaQaoYR5cUPvQSmBDrohHA3m+JQfZku?=
 =?us-ascii?Q?sfSIUDJgZaGUM85QaRGZmg1BvriS/ToPKeBrBHOx1mkKEM0TUmZCjS2CVP0O?=
 =?us-ascii?Q?jbgjd80cqXzNbWUYxEb61XwL5405Ne0jrP00M19chlg2fGzkhsLsbBUxASYO?=
 =?us-ascii?Q?bQ=3D=3D?=
Content-ID: <42ADE0F5FC37D540A4C7C5D3CBFF5855@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ose4rDMRux2tTeszsPPlgD1mfTAeLky5MriVJlm4RmZ3y/1hdCiVLG9HgTPUNmRIDpuecZdwA8/9TLZhBL7f8fz+tapTvgXsRFLaQcjjNx+fghjsJEHTmp1gJTBQfkf3cn/7H6CDF9Q0wCuvkFL2JF4XSoZyeazbkIrzp6zMvNeW4h3jGzRfsuxUs53WwldlTC9MzfSzKNRvE7P2INLbIH7mQklqEHJPpScJZJH91P7+lfsbB41eb2VaXRt/Qkefc2UVquWO59xVmAEMHx2IIG0Y2FHUGcqTEJlitTc2fHvJhwiVZWhYMuBHtF3SPIAiPHV7/u6lL1IE/QvnGn4sbT69xHzZSQGyrDCfXt357bfF3O4VQu9tRMwzLeB4w7lBvVys+E68JKMMzaB/e7GpZQkLmSoIVNfrLBA7N3JNJNCfHOIDpOJOhSFdEMUx7PTUz8B8hQaEzjv71B3FzVmarsPRpCnv17N0i8lbghnsw1+SPWrj6Vd5naD7Wqbx8DTjkYDCpXE0oTM94O79Z28mvO+axPu8U23/xicI6KUCsPnzO8vN1Y2QiNz86kbK1Mdn3/pFE/om+6E/qFnoDm/WfvLkIbuNWvKMe4RUoj0UmJx8NBkXO7ATCg25zA7aS53OUgGiEV0TPUVbeZccQOQZ1RjMCxYkvNVtS5GkTt/eCq/K1HYEXspO+V2fiB36hnKKIwEX/b5d1b0MDGS8hwisbYzX5Z1N8B/DV+gRCwqK8fnZqGQLMC3MklOl8r/BvFRvRJ8Q7mWhNYNFDqbzItw3YWQuXq415MJ+qVlBX7sPL/mcLl95MwEpA6Qow38txj8QdIcNMJAB5QvoCVmOmPNF2DpXXW0+TkEwGzrM/GB0F+M=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37b7f3f-e347-4499-ce98-08db71701f03
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 09:24:17.3401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPRt7YwsvZfu+5In2yOOXwdfmguWv5VUIRixRwCcAtq839Ul36IStN5JCCAtalC8LLZyo7abzNn73wVx2Eb0IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7117
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 20 Jun 2023 12:26:29 +0200
Subject: Re: [LTP] [PATCH 0/2] Improve ioprio tests
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
From: Niklas Cassel via ltp <ltp@lists.linux.it>
Reply-To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 20, 2023 at 11:16:49AM +0200, Niklas Cassel wrote:
> On Tue, Jun 20, 2023 at 11:13:16AM +0200, Petr Vorel wrote:
> > Hi Damien,
> > 
> > > The ioprio syscall tests rely on ltp internal definitions of the
> > > IOPRIO_XXX() macro defining priority classes and levels. With changes
> > > to the ioprio API to support command duration limits, these internal
> > > definitions are incomplete, causing test case ioprio_set03 to fail.
> > 
> > > Avoid this issue by having the iprio tests use the kernel header file
> > > definitions if that header exists. This enables additional checks in
> > > the header file [1] which restores the expected results with test
> > > ioprio_set03.
> > 
> > > [1] https://lore.kernel.org/linux-block/20230530061307.525644-1-dlemoal@kernel.org/
> > 
> > > Note: a review of this patch on the kernel block mailing list would be
> > > very appreciated.
> > 
> > I haven't found this patchset on https://lore.kernel.org/linux-block/,
> > did you send it there?
> 
> Hello Petr,
> 
> The patch series for LTP can be found here:
> https://lore.kernel.org/ltp/20230608005315.3703446-1-dlemoal@kernel.org/T/#t
> 
> I just checked LTP master, and it hasn't been applied by the
> LTP maintainers yet.
> 
> 
> Kind regards,
> Niklas

Oh, and in case you were referring to the prerequisite kernel patch,
it is already in linux-next:

https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=staging&id=01584c1e233740519d0e11aa20daa323d26bf598

So right now we are just waiting for the LTP patch series to get picked up.


Kind regards,
Niklas

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
