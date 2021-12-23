Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1ACC433EF
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 03:03:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E86FB3C9272
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 04:03:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5584F3C8CB9
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 04:03:26 +0100 (CET)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 22BBD14012BD
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 04:03:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1640228605; x=1671764605;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=knVg4ivyqtLWUhYDvyUN+a67c3TEx/875QxjGWAa26s=;
 b=F75J9FRaAWjshUhiQ6C1IyU9fvfADrZ80vnAeTRmTnm5iUJ7HHQz7i4J
 HdWI9wisAxY9nd+ZKwFOZ6VubtKjPuooidaa4dgzLSFapvs3cfSs9Xc1g
 HqkGzucUv/GQniVdB92owPUCtCMArnwKA7HvqBjdfv+/IjW01BqWZuk/C
 f7J009mD0ABe3ycgDMorOuK1k+aCEgYlYH9RFsJQwz52pZkzsFcyL+tIQ
 Yo1FKxTM8s1loU9vO/Y955T8ZXbGYqtb3NGlELjGq12gTnMsBUvt8/5JJ
 6IWA2S1Esuzam1q7waOPQZF0vZ9mbAi+OKee0/JrefdzDcvqMMVE9eZKo A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="54744469"
X-IronPort-AV: E=Sophos;i="5.88,228,1635174000"; d="scan'208";a="54744469"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2021 12:03:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8Dcm0ki/YKK9T7R/3JHNPQdBsO0+ida1Vcwhrm4Fz2TJBFKHn0MezU7sdYTrTJSYIkp/48r7kcOI1NHRSgKIkwbmdd0kcw/UMRdrCJHIXQba7MGuLk8r8kZiNL0J3iMDMW6gcLTN6H4ItoyMBxEU6nwT3xUgQN5/V0oCbxEPM5eBfXZGuvx95xNCiPrFyNpyPoP58GFQDl55X9liqObBMo2qaZg5cbjzuqg3bwHluDvN827xmymTkKFgORjYlaekRzOB4wl5nIrqT/XVjhvsi4QS6uLuvcAgE4GE6R5rwqXKcr9EfoNTcvfv/H6Wt+RSQ1u4QCBkafeRG/L7aiHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knVg4ivyqtLWUhYDvyUN+a67c3TEx/875QxjGWAa26s=;
 b=j2QHznRL3gWna5XIkhXZGLUt3RNAKM9++Y2kvwElswG2BJu36syFf7d1FTAsLgmC+0FKHbCFDIkeZpl0feM5ftMifT+hs1SqatCKKjL4Wx0Jz2lrxfY/0hJS41vHMRgInW7XRwC8X2CTTAcOPgPrAQYfQaEPAAQFyEblV6+RIo7KhMZRbEc28SvaM3pVLYW38dSJCFwkEcYL/uxx6mIWwUImVhtvnVbGNdOjZ03bIoNAqQAasiiSn50EmAl6m3z//8s4mVwG17e1zFG4lGbZOPSub/Bh8/TLWC2zvT6sglMX6vN9cSX5+/oj0v9Q2J/mVrASaq3zA6lT2eCH4+GVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knVg4ivyqtLWUhYDvyUN+a67c3TEx/875QxjGWAa26s=;
 b=BNkeeZWxVhen/y7c9No0tM9th2zLAlQtzbPM46J3Dzl6NjuyzjDI6S4ACr99Pgl9jzWmnW8zjTvhqONnoj9XQgSpt9u+zVirsbgv3aJm/p/rQh3OKhCty/oXtE9dwnKOaHGEjaRx9KRJbjrIt8Zs5s6WJ38IlM+84OPop6av9KY=
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com (2603:1096:604:100::7)
 by OSAPR01MB3972.jpnprd01.prod.outlook.com (2603:1096:604:5f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Thu, 23 Dec
 2021 03:03:19 +0000
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::bc41:b2e4:2c49:8be3]) by OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::bc41:b2e4:2c49:8be3%8]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 03:03:19 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v3] lib: Do not fail a test if oom score cannot be
 adjusted.
Thread-Index: AQHX96ela2zSgnVXnUuMykHss01aTqw/ZAqA
Date: Thu, 23 Dec 2021 03:03:19 +0000
Message-ID: <61C3E707.9040805@fujitsu.com>
References: <CAEemH2di0818vNoByrpUeEfZi-T58fNMg131=HZFeF2W6Be0Ng@mail.gmail.com>
 <20211223024841.801160-1-liwang@redhat.com>
In-Reply-To: <20211223024841.801160-1-liwang@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8eb784b9-ba9e-4007-51af-08d9c5c0c5e7
x-ms-traffictypediagnostic: OSAPR01MB3972:EE_
x-microsoft-antispam-prvs: <OSAPR01MB39727B205749428445FAD79BFD7E9@OSAPR01MB3972.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uFaZeFMk89yoQUlwZq9saTEZkUpzLP7qTmoIGn7nDDTcrJEx9qmo8f7G6+TsagOoBsNYFMTLf6I0Wxs3Gl5qQP0H5hgEKfABiEz+HW4shesuYWhHHuirv9f68tBqwRKVSQIqrpnULPPyr35UkgDrTF6yPHsYV0qtgX8pTrazPhLhlHzUcabSZkkJPxWMD1/Mdej+9tliZ7zzPahceo4OsEUNQZatg2rgpoxVnfWOJznJ0tbKSGiRn05bHPyfdo0BYR03NdkZmZaVVa6E2e8pdNuHAprXuhNK6CQgy/yK0yO83yKjzb3sbX1IZoxRTiQvieUqJOkmhQ3FDXu9+cognHLjrBZjIsfxbwHbKVqRe8VBWt9ThkrWdWVCQrdZUiuceIazk5BwP7AM2zZCRFxwwRpVBgr6eac98C+M/9TzcIs65W3DkPczxeLv7QDJJZ5Qp9K0CUo6Fb0LkfnkNIHciS4wnuGx0P4QVzdyQTQ0fJ6fHRU5nr/likfM6QTpiVP6UsnqTGfo+3qBho5MeghH606z+DUGNi+zrJBWmaAdcE9TDjioPVSD130A+m37DnN76MWj1JSNPrra6Gc6YX6lzoddiriiD8Uv+pUldGbjudsXdFBOvvaPGwLVZfr8FMLCr3zEvuyvhczlSoTnt1B0vnbt50kwL85dhkmEjCqO7mGO14E1JQO2dxwmwNErdGGVCK89rPFl66HfxKHj0AVYTeSbAteCAzC4+KUXTNnUP0V1WXaVHkohm0qIvdxmVhflF7C+8hOZH9sI4kUYLqy49eqW+xFBJRfqV3L8Ih8mcaw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6535.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(87266011)(508600001)(82960400001)(6512007)(2906002)(8936002)(6916009)(66476007)(316002)(64756008)(8676002)(66446008)(66556008)(122000001)(2616005)(26005)(76116006)(38100700002)(83380400001)(91956017)(6506007)(4744005)(66946007)(5660300002)(33656002)(186003)(36756003)(4326008)(71200400001)(38070700005)(6486002)(86362001)(85182001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SEhsdTRGeUVlamhwaTVOV0NjQU5nWEVOeWlEQVREa2RpNFdrY21xYmFJM1Iv?=
 =?gb2312?B?NnB4T0NuUktJU1h2V1BadThvRTdETUs0d2krSWZDNmxDMGU4N1k0ODlPdmxo?=
 =?gb2312?B?RW5hcFBxQmNFUVpEamVVeVRtU3psbitmTFZlc1dZTzRmY3Y2Mm92NTEyV25J?=
 =?gb2312?B?SythMGdBTFF5eVpIWUdTbXZXd1RtbzlnR2V4bXlrWVVmNVA2MnBCZEhpZ2Er?=
 =?gb2312?B?S0RZVmxFbGE0MFFHZGNnREtwMUp1VmpIMlJUdituY3R0ekJSZUZER2lrRkFY?=
 =?gb2312?B?QmJ4UWZseTVCZGkyMERMRGtNUEw0eXlmSUxNV2xULzU0WHJ1YlI2dm1pQjNn?=
 =?gb2312?B?Tm1NYUNBMlZ4SzFmREdXbnJleVlUNlZJY0dyVXp4WXlUTjhWMmNHbGdyWU9Z?=
 =?gb2312?B?ZDgxU0xjbFlGdVkwMXdMZW03K2h6eWhFVkdjeTlYS3lhcklMNUM4MU41U1Bk?=
 =?gb2312?B?TnNzcjFJdkVXNnR0b3liT216K3V6eWlyell1bkpkdytIa0l4T3NqektLSzdL?=
 =?gb2312?B?OWNZR3dNSE85TnRYdTRRdU5vNEIzR0Y4MlJxYlJja3ZmWnc3RHA5MjF6Y2VF?=
 =?gb2312?B?dkh5eFJicVV5WkZkVkt6K25VY2NYSXREVTl0SG0ydkVNdnMvYjd2NWljelI2?=
 =?gb2312?B?Z3hBYjJtTXFERmpReERJSmFyWHU5V1RMSWxlV1htZStveml6elNqWDlIYnE0?=
 =?gb2312?B?N3JyRGdtZzk1QXNLcUh1SVJDMDFpUXUySUdjcWFUNC9JbXcrN05IclZVcExE?=
 =?gb2312?B?WEFWYVpON3hQTU11S2I1bjRsaE9IT3pLL1Y1L2tTcWt5bnRxSHJ5akxWckRC?=
 =?gb2312?B?elM3ZnJWL09Zckt1UkRmeFlZL1lTS05qZ3lVQ2JSV2tvUjMzWnIwQy9yeUw3?=
 =?gb2312?B?Tk5VY3F3R0kwSW9CRXVFRWZ3S3p1c0hvWUpueUh5T2R2MldCeWlRN2NVOXF6?=
 =?gb2312?B?emZQYjNnU0FZcDdLSURQanBzaUVCU3RmNVJsbFdPcmN4OG5DVFNNWDJzRlVG?=
 =?gb2312?B?eUxmamJZa29VZGZkem1aSng0TXJ6aGJ0VEo0NGg3cFk5RCtuanNiU24zN016?=
 =?gb2312?B?THZ3TUY4ek1SVzZnS011UWkxQjZrUDJWRDEwMjFjbFR0d3AwUk9mZWNXVlph?=
 =?gb2312?B?ZmdZVFpnM0R3NjBGL3htek84eWVzRWp2aDY3THE1WFhTdjN0YzFuTDhJUHZo?=
 =?gb2312?B?cUdlTEh6bk5sTXlGalhCZHpBS0FHdytZV04yMGlmdkdOVVg3M2dxanNxbjAr?=
 =?gb2312?B?SDZENVhNYThCY3l3cG45Z2VkaS9oc0pud2VvSlJpK3JPeU0yRU9NWWp3RHh1?=
 =?gb2312?B?ZU1Zd1hTS3ZETVpWbWhQYzlndnVoZ3NGVHNzTW5TRzdwNHAwU3kxUG9aczJw?=
 =?gb2312?B?cXlnalRzVmxSSmlwYS84cnpROEF1V092cnVyK1ZEcis3d0RYWVNtS3NLM3RT?=
 =?gb2312?B?R2l6NVU4OExQWWRQejhkMDBZUkNiYXBVU1NIOW1lSi9GOGZWTkZsMmJyVHNG?=
 =?gb2312?B?MXNSSWttSGxRQzVXbXZ4VUJhanBsblJxdFNraURPb3poWW1OM3hMZDA0VFlm?=
 =?gb2312?B?K3dTWGh5dFZWVk9JYkZCTEphL3kvT1Q4WjM2cFVxR3l2Vys0eTBtNU9xUHEv?=
 =?gb2312?B?U1VSdkZiVnIwRUgrQnBSS0pQSXhhM2owaUZQQzBob1k2SWpHaWRFOFFqMzEr?=
 =?gb2312?B?N0Fiam04dHAzTW82MHFrekp1U2JiWnhaWmd3VmNkQmIrTTE2SkQzT2NYRk5r?=
 =?gb2312?B?VzFTSTF4MVdQbmlaZjhacnlBN1lvbkdrT2xDc1UyYlFzTjhoanpJOEZiUzB1?=
 =?gb2312?B?bzAranU2LzJnUW02N3UrbUoyQXRoZHkxR0I2clBkL0ozaDFrREcrY09ZVFZq?=
 =?gb2312?B?alVWQUtNMEI3a2JwOWJGN3kvS2pGQmEwL25aUFNLM1FhaVM2akR4Yy9VUGRV?=
 =?gb2312?B?QmZ1dGdyWWlFODU4aEVZaFJuV1FZM1lwVlpDcWpvdno1VExFdmNTUk1OVVdm?=
 =?gb2312?B?ak5SdGpUOC85aHMrYkVMMHlISlN3QmJjUHl1Vi9jSURIMzN4WFN2ZlJEYmxz?=
 =?gb2312?B?djI3Smc5bGxJRzBFNVF2amVweWNFRFBJc1E5dFZrbm5DNlp0RmJDcnlpMlNW?=
 =?gb2312?B?dHFBWGkycXp1MjlySzJMTGlQdjVCRDlUUWpkMGRRYit3cTBGTWZwclV4Q1l0?=
 =?gb2312?B?amRpSFMxZVdXaFR3a2IveW12cWFtUlo4VFZ0SFl3aGc3eGhsMWdHWFF6T2ZF?=
 =?gb2312?Q?ZmHtYHL19A93bbwuQ2MKQdIrxB3BhS+xm47nsam9us=3D?=
Content-ID: <40568F26C33B0D41BA51F53543CF8327@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6535.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb784b9-ba9e-4007-51af-08d9c5c0c5e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 03:03:19.3831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NEgYpHucysAFtUQ7q72F9RW6nhb6SDsahq5TTBhEf3QZibSOqpGzGWTgBikaxoe6NSkCjC2s5Tzpoqzfmm6dKzqjpubOwBIHIcyTVjtdAbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3972
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] lib: Do not fail a test if oom score cannot be
 adjusted.
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

Hi Li
> From: Petr Vorel<pvorel@suse.cz>
>
> Setting value<  0 in/proc/<pid>/oom_score_adj requires CAP_SYS_RESOURCE.
> However setting the library process score is a best effort operation,
> so let's skip it silently when the user is not privileged to do so.
>
> Fixes: 8a0827766d ("lib: add functions to adjust oom score")
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> Signed-off-by: Cyril Hrubis<chrubis@suse.cz>
> Signed-off-by: Li Wang<liwang@redhat.com>
Now, LGTM,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

ps: ubuntun:groxy fails because of other thing..., it is another problem.

Best Regards
Yang Xu
> ---
>
> Notes:
>      v2 -->  v3
>      	* drop the useless CAP_SYS_ADMIN
>      	* add some new commments
>      CI job:https://github.com/wangli5665/ltp/actions/runs/1613852940
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
