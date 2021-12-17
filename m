Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3109C433F5
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 07:04:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FCF63C902A
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 08:04:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69B993C58B0
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 08:04:45 +0100 (CET)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AA09B14060CB
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 08:04:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639724685; x=1671260685;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eMG1V/5hT8BnKmR8QDcrHlmAZPZut7ubSX8oc4qckLk=;
 b=OwY2Sfvn5iBPNrz+3Ev3VSHDfbXOxUNSNcd02/TLoizasoHQrNDNIhbk
 N1J2RXG+rLQaOEQR1bf7K/6W35QhDxQYCm56XZT+9FBGPyjcBCRVj/qoi
 XmIU8bNLSO9LbtDjYx4U8yivzj8Y5N1f6w5WdpBu/IuF5NzMjlHwgQzZo
 5EbsoHehO0Pjkq+JtgGqqJtJU/f32gyDMmoHo9YvxDItrRvf2E+/mHdi2
 ge3OJRzvOnQvFi8K0m4FjjgAsf+XLcBHO+8Mjcj0W8fM+SJlnpcbaEvfH
 1h/vj/FUCfVUFtwH7WSwswzgl3HAkzB9MJb/JBASqEcaXobV1dBSzSfDe g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="46095269"
X-IronPort-AV: E=Sophos;i="5.88,213,1635174000"; d="scan'208";a="46095269"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 16:04:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hstmmPWsqm2HaXRax2Ocwm08Q2d5jJuChdfRexIv9U6HFVqVyxCj/GDS3YXE/mI8NCOE4UmrrdgyaVgKWAuL7xUdUeHIQmpcy0SST/cr4XeMtRofWOWh3Uo1DPaVG8bzYHsDuYommCBR8OfCg8f/Xo/B33H5nGinKKA6BtDjqwL5K4I63nh5hLiISjuPXSLO/ZtcGBF8XD/cCbK3z+ExCWmElJFoxW7RrRJdad6/kOrFS2HUM2Y63mUC5vZJ0XqEnapG4RCP8eDeH740VMGHfgYOdgHd3Lwh77NjinSCXJhKS8HelWrq/mSfD2gKKOU8n9SOMLug2R79e1qgyyF8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMG1V/5hT8BnKmR8QDcrHlmAZPZut7ubSX8oc4qckLk=;
 b=lB2GuEGYCh2wNGQ6BRWHNl6LvN4Sr1QgWOf3Sppg1eUCOuBkn6j3em6/KWNvHbi4AfYw0AQ6vj3N+m2W3dpolFXNpexko7LOepVTcKNCd0UTTlGFzzUhy+we80SSu3hLsm/F55NMJqGYYTxD8AlTWsZNe9gNdhcKtZM73eUBsK/ZO6sANfuVbpLZ81zrix5czKdjqaUeRHc0O8f/PgLjO01nYX3pmzcsQlyUAXLN2CKDIQNuWrcPQHnK8bTmuAF2N2DmLBLbzVhI5OSq2ugnm1H6my5cYJnGL6jP80m0M0IQSBEyXbj2N8Lc9enxaro/cty10ifiYKgBDXIYHz/88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMG1V/5hT8BnKmR8QDcrHlmAZPZut7ubSX8oc4qckLk=;
 b=Dsj9APRZFlSf7CQkiolmg3z1pAxpCoblpgfLUq2e2xAMYKnnADpYRTjAyJ+Vs1Qhym8LXoDHeTbfmJ8r9epVBibWuv3EU1lzQigKUmV5g/EWdB6P4QzpNl3KRqLQlNFaDWqWJLuj0uOfAQrhA1Icpmpa/IiWJUtQWXj489pu1gY=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB4493.jpnprd01.prod.outlook.com (2603:1096:404:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Fri, 17 Dec
 2021 07:04:37 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 07:04:37 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v4 1/4] swapping01: skip test if zram-swap is being
 used
Thread-Index: AQHX8YRL59MZ1mvRkkekxmqkUNXkg6w2RL2AgAAA84A=
Date: Fri, 17 Dec 2021 07:04:37 +0000
Message-ID: <61BC3689.8030105@fujitsu.com>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ybw1vY8Mnr3sQXYo@pevik>
In-Reply-To: <Ybw1vY8Mnr3sQXYo@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0bd4dfc-db12-4005-5af2-08d9c12b7d17
x-ms-traffictypediagnostic: TYAPR01MB4493:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4493328256F267A719909779FD789@TYAPR01MB4493.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ysd8i5Y/I4U701c3a78SWflGfDlEOGnflH1eeH3iBd0Brgbw1UAouTxXhzHsmy05nLTJ73PCO4c6p+dMTGE7QRsVc12+/0sEPy87e/dgNOAN4MgCEwbCtRFAUQwoRzbDDtL073vXLeVdrwFNrMZ6FpG9F9azXf2E7llk7ysHDlKRrjhPE9zHMHE5D+m82O2NxwPQjXfxZmHJEQYGYkrFVUf/7dSaz2hhj35+SVu2M5V3L9LszjGYBSmUz4at0BoQcikmJTS5ohH1R3sjarRwkwpLpUyrkbLei+ExBqaTiqO/IP5gVPfjxrku2Y05XzIJM2CxsEhSW9DZSGFP54rGcZLL8x10k7VaHI+C+THl/PcYf+Qsjl0KX/hmMdw2fnIwFDtZ1J+0d5bHJqROnM2TZek336pzFl+8HcQDslmyE0jwIdFp5Vk3S3lP/B2JzCPva9pKISYRpAF3R2kkPbjOu3hj7eUWIaCtoZacvhYvoyBf/7/NPjx94oSSMp94wo4otq/MFnlwxDxikdnILgGoEXQ0Kv3elhDaGpzoIkvHMUXLijjORXYt281fjxTLH8mNKMk4qdik+FtOh4UwknEAZSxaK1AvZJkX38j6D7N8gZvzmiPWh1mGPBrW8hopy8Z9a/aQGAYeEUQYV02/numlHhtPlLDo0U0uRSnsazyh1VhwoJuopIde3L/oPX5fc0mpOzZ1SdimwI8GeoczyaFYaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(2616005)(38070700005)(87266011)(66446008)(66946007)(66476007)(6486002)(85182001)(36756003)(91956017)(64756008)(5660300002)(71200400001)(38100700002)(4744005)(33656002)(6916009)(2906002)(66556008)(4326008)(316002)(508600001)(26005)(8676002)(82960400001)(6512007)(8936002)(86362001)(6506007)(122000001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NkRGOXY5c05mazJod1V5ZS8vampONk1KZXVKOUhDRk1nbUhOYXNySXBSOTlO?=
 =?gb2312?B?L0xYSjhiTmtNNmdRQVlVYUNnSHNoUFMxTDVpSjM3ZHZpRXlnSEg1VEdMelUr?=
 =?gb2312?B?akZYU0Fmb2ZwbTUyUGZkSS9qeTRHa21Wb1F6QjdJRllMR0djY2l1SkwzSitq?=
 =?gb2312?B?WXJJcy9lN3lVTmE4Ym84cFd1b0l6N24yUG1ScVMzQ2JCdW8xMUQ3WjVlQXFB?=
 =?gb2312?B?YkhMZkpWSTlXSWlWZmdlWGxhSllaV28vS1QxTGRSWE1qTkFPQ1J5Tk03ODBK?=
 =?gb2312?B?MTJVcnM2RDJlMWd1Y01TeDFGZkRZUk5uNG5rbFJkTUpnTnZzV1JaZ3phcnFk?=
 =?gb2312?B?Y3NWTmNqR3hnc05pYktsWm12bnBpTXhrWGFFNE4zWlBmS0FiZGpaQlVibjlJ?=
 =?gb2312?B?aFloN2MvNW1OcDRLVFVPeVhmV0I1Rm9oaUUzZGZNUk9lNzZVTlVxejllRSto?=
 =?gb2312?B?YS9ReUkvYVlrUWR2bDRuNWlOYnc1TGlHNWxnUlY4bG1NSEo3U1I1Zms2VUsz?=
 =?gb2312?B?RndnUUN6aC9KNHNHY1NZQk96ckNRQmVJbnl0MVkzZ0lqdDdpdGVSVXBWSm4z?=
 =?gb2312?B?UUtCcXQvNnI1dDRpc3BkVmNORnBBTXA0QlpzOCtFbjIyL084QjYrLzRMcWxH?=
 =?gb2312?B?YWlVTEFKSSs4cDRNUUkzMElGMTRzTk5jV0JNSzMrWjlqWkljWlFxOHJzR2Z4?=
 =?gb2312?B?WlcxRVVYU1JLME45d1RsNWwySGhvanA4U2w0dnFma2psTTQzdi9PRUZvV3Nr?=
 =?gb2312?B?UEpwRzZ1N3lSNm05OFhsbmJkT2dQTjRMU0FubjFLZXcyNjJxd0lGUWNDNHox?=
 =?gb2312?B?Skc5Z290RHNHeVdCNWF0OVJTbklKZ1NBYWtwMzh0ZnlGRW90VjdKeEdHdFFq?=
 =?gb2312?B?dm52REdBM3IxS3lEeE9DTHpVR29ZS3Rtbllkd2hqZUtaQ1N3SXhsVkZyV1hG?=
 =?gb2312?B?QXNac0dPdFJsQXdtUmVIWk1nNVA0elBNeFJvWGNqL096Q0ExOTA5QjhNQWFQ?=
 =?gb2312?B?N0FrMTBjbTlWMVl2TXM3TzVPQzNsQzY4Y3JkR1BpdnVzcjlMdVVrRlRRY09o?=
 =?gb2312?B?NzZ4RFh0a0FCMWdVUHVlcytyUlV3QnJwMkdjbThPRlJqOUNsQmh1L0ttTFg5?=
 =?gb2312?B?c2NwQ3hmYWhjVS8vWThRVXZ6SFk2VmR2eHFFUWV5K0xCc1hRQlRuTkNhUXVJ?=
 =?gb2312?B?cmFkV2dDbm5SZXoyc2tUdWwzQysyTUlPbFhqZ1ZmWWdRdEpvb3NwN2hyWU9t?=
 =?gb2312?B?STRVRXJudzJCUnlKbjZXVlZMbGxrdGVqUDd1VzlnZlQyZU1ESXdSWXV3Q2Uy?=
 =?gb2312?B?eWJDTnYvbGx2RlFVdG9ZOTNYSHJVMXo2MkFVVnBUTE5teStnMmU3NExsQmhw?=
 =?gb2312?B?Z3lxM3VUcEw2Y3ZvM0ZKRno0cWRodGlDTmNETlhPbmxOUHpnRFJrckhKbWJJ?=
 =?gb2312?B?M2J6T0FxK0hCTkJvTlY0blJwZHo4cHFZL0pRaDE1Tmp1MGh6bXpaZDNFTXg5?=
 =?gb2312?B?R2FBSWc5QThkNFV4V21CdklIa0twN3JWZXY2YnN5TGJETDZhOTFkZ29iSGtl?=
 =?gb2312?B?cEo4MitWL3hyTmJoaTc0YkJVaW16Witpa1N3ak9md25zN2c3MHNkR2FOUUdI?=
 =?gb2312?B?RmpYWGhtOVFYQ2tGNnA2bWFLQlp5VC9xeUhFMW55NEVLeEdvdHpIMnNLQlZM?=
 =?gb2312?B?VkZzV2p5TnJUTjArVGJxWEJBNCt6ODFpY2tUVGFCQ1RlUisxSVZEazEwM3lU?=
 =?gb2312?B?WjFUNmpTWE1LVHRLemg5N3k4aGx4dXFkZ0hrY1M4RFY1QWZEckQ2blFpb0hU?=
 =?gb2312?B?d2l5UStXMzhWYU9jd1o2emV1SGpmeDBNM09xeDQ0Q2VodWRMWEhvMWl6UDR4?=
 =?gb2312?B?NVEvK05DSjFlM3h5SHNiMnVON2dFYWo3blFXNFlHVkszbmsvUzdZR01TamFU?=
 =?gb2312?B?NHZsK1NHeHlLRXdiQTA1M2hLcWhLdkZhaGZZeTMxZThOYWhRc1lzS3c5VERW?=
 =?gb2312?B?aU5zQ1p1bEhOYjhnQUVkWjZiK0pHU3BkRlNiaXV5alBvNnFOWW5XaUQzZ2s0?=
 =?gb2312?B?dExnOXozMzZ2bmNIUWNWelgyT3RSYlUySkNpMXY0QlhXL3hiNEZBMmpIZkpQ?=
 =?gb2312?B?MU9EVkdUMlJxTVFJQ09vS3dkenA0Z25HcHNnSjE5dlZoem0zZVFTdTQrQmgz?=
 =?gb2312?B?Vk5taXBZQmFweHFLOHEvVkROMEdjUkNsYnVuZm1tcE15NGl4cHp4alEzQ1F1?=
 =?gb2312?Q?4W14EslYr2bb4i/3kNKEU2FGghKhAsLTHjwnJYt/48=3D?=
Content-ID: <6508BCFE8A55DA4FA169C64CABAD3B82@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bd4dfc-db12-4005-5af2-08d9c12b7d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 07:04:37.5445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WUeU5hZGrPZR+PtJMLvzVpVO3xeIPdBFRcQ/ZlGfU4U5oxaVEv5iNjJb3NG1ja90d7wEwigqWCYTTsWYUOY01DeOwpfWV28bWPau7TXfZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4493
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/4] swapping01: skip test if zram-swap is
 being used
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
>> For the swapping test we attempt to allocate 130% of the available RAM and
>> we make sure that the overflow would fit the swap, but as long as swap is
>> backed by RAM this obviously false. So skip it if zram-swap is being used.
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
> Could you please fix this before merge?
> swapping01.c:84: ERROR: switch and case should be at the same indent
Thanks for your review, of course,  Will fix this when merge.

Best Regards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
