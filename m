Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D060FC433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 02:54:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2268161002
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 02:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2268161002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96B863C68E5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 04:54:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AE093C63A2
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 04:54:37 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5C5EB10016F4
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 04:54:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1635303276; x=1666839276;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=UZ6+1lmnAbeHV5ktVW0+Q5rrumPXM3nQlF0lBY8SIpQ=;
 b=raUdwNHyV9lMV4ZmRwSOfKdzXx5e/6G1BJbp0o2HNIYAkSYO0mFZPXro
 iV4xE9zfLi0b+Z0lpxYEtmYFYOaJ+Zcco2zcUqL/WfF7za978CmHApWq+
 rvBb5T9q2Jf/b9naerMg1LX9pUGzPmSZJ8fDHGA+83yWgu6G46l+zBD3h
 0UfG5Ts/ic1jyAmCf7ShubbwlVKctC3nOScUfyoFAVwueANSTtYikg4Ct
 mFzXYiJoxGT9w26PKDIjDRVSKJMRL4bT0POeqYgZWT+W9XSx0XcGuxmZp
 D497AbfP401JCE2AKMreJF/wyKbBmxbH+9SyPkcHKQRuT8Q5fKq1osSSx g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="50191197"
X-IronPort-AV: E=Sophos;i="5.87,184,1631545200"; d="scan'208";a="50191197"
Received: from mail-os2jpn01lp2052.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.52])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2021 11:54:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUcbwlWkZpLTsuwNqAQmWNKR/IojBZWUQSIRncFg/jQqzHk+MNL3TVGgXDR9e7+wMZ4XG6XiAZEUN5dnQ8GlOjRXWT0Fgf8QAcoMMntqIXYOfdLX3hJGEB8wqpS13rEFhYnejuzrpmWtNk7eZfjtpxemqPOr35XLpAvfzzq7oX1z6SwefG9MS8neWKZOwUx9CoGvEnnXz7JkRoCJD1l4XjT6zqHymDcpf3605mX2NF1yH/otSmEzkFQhr/4iybtKw1hhEPfNPTVE23nnlgqbIy3TDQVaSvIrCQq6O/JClLD/li3T+eBcPO5gUoOlQbCb7BUTpenmUKXGre4N9gtpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZ6+1lmnAbeHV5ktVW0+Q5rrumPXM3nQlF0lBY8SIpQ=;
 b=mHkoZzA77oxBo0UL+bJn5fDJ70w1KagBSBhIEMQliKgSMRo9eFhSnVCae+dZN9/eIZfHLUxPvatRp2mFYcBd/0zlbjv3CbWgcXGcxkcWLhS5aXEZ7OPJVvHMKgOBreaYX0KJ9kG6h1jn27DWAQaIQiCwwuI1EBTLSXfDB497eLDQ4MPvA77PfjWy/ae94C/F7/TpVQIypawsYgJQnTDfOZ7Q7RzDnt/G2hw/Wf5X4/tKb3fI9tj5Kq/PjAlh0nMXNgZ7wUfbFU9/8+e1Gy5Gc3q4W6uoNuChEKMkg7NYE5occ4Uu9Ek8ko2FfTSg6kkvIla/7CkkTqVpWvQsrNseAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZ6+1lmnAbeHV5ktVW0+Q5rrumPXM3nQlF0lBY8SIpQ=;
 b=mCrYkPRrpWr86SQD0t96z0u6GehnrN3jx62r5IsYytMPFmz30vKAcXRspu+p/zutyFe5yuF3314+VC6M6ZyfPNtBkfJKLHSXRTMOiSCYvodgwP1Gi9dgHSbIRKHlHzEU1YsM+5J7UbkeKjYoc+sDTcE679T5M/XrYLjuZv1j99Y=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6538.jpnprd01.prod.outlook.com (2603:1096:400:a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 02:54:30 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 02:54:30 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v1 04/11] syscalls/quotactl[3, 5, 7]: Add docparse
 formatting
Thread-Index: AQHXynJmLhQoQ169aUuVMcsZZoCHbKvmJwuA
Date: Wed, 27 Oct 2021 02:54:30 +0000
Message-ID: <6178BF69.4040202@fujitsu.com>
References: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634562591-5830-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <YXgLHulsUiCRQmXE@yuki>
In-Reply-To: <YXgLHulsUiCRQmXE@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37721047-2ab4-4633-bc54-08d998f518e2
x-ms-traffictypediagnostic: TYAPR01MB6538:
x-microsoft-antispam-prvs: <TYAPR01MB6538D426AAF4069BBA63EA2BFD859@TYAPR01MB6538.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9/fcfKZ9j78lo7EkMEMPojeF/4qJmbtWRgC03e9k2lQHCaaE3oEXZ1YmO6Hsf825dNC6/hgmhGFb35aYNQ7MZb2j4gVbLB8xz1cgf3Cy1Gxz7T6l8g9ErSY75H7IzcYcFe3toSRHBA1HaPhQRzfnnqwJaoNccjtFh+1iFbB+gxcaQEfb6RsvYvRPG2NSj/N4e0y1vtjYGJjPJ5LyVBvwpqb2+pSmEd77/FLcZsbn1Ag5neel7brCj6uTguwT5DqUTmOg4JtxRuRa+arKAzBrqUSgGwyUJW7IlueHqfLnP8UtJPitqELuUqJlKnSSanAyHM8sdsBRK4zw9Ah0rRsmsJsx0RsZ8meVvxE2UQqeCaOji+TFqcHbinmsXN71pScxN0jTBGgChfC2P1Yo/tbgbjsbuIm9jdpYDoWhnVXSa0cOdxVLMmpsT7NEP5sQB5YYj4VfmGeS49UxHGJ4fb/RY/iHZvaIMCM3cAJctSlvkx7A982mJcXM/Ce7TulgAVxkSY8ftr/52FHBhY2hmsfq955dKto785vsqLHwLSvnPCjUFapPo0h7Sv8tOFEwxULUJqQCOzVaFG0Bq+S4VYqJY3OwPAuvWK8nWjq5rDg7IGipYrWDSoToo4PSxSfuz0e+UbQZ+UOJRMDFlXY8ZCyxgQXMvLhozlDK7Ih+ne343mq//smpEHk9qzW/8KwRPae49bmalMvaZ2S06KvGR17VPh4YrNCPrgkTs0jP6uzWKdwzG9Yq6NOQvtw/I7Z0/O6ooD+yTKoFBOSE8ZasyUnTprgJn3WRQDJsjIqzgQDGeBA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(2906002)(71200400001)(26005)(38100700002)(38070700005)(8676002)(2616005)(186003)(508600001)(6486002)(966005)(87266011)(6506007)(82960400001)(316002)(66476007)(15650500001)(6916009)(36756003)(85182001)(64756008)(6512007)(86362001)(66556008)(66446008)(66946007)(33656002)(91956017)(5660300002)(76116006)(83380400001)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RFVWQnFKRFYxNVhKUXNqMi9sajRubEpGdHNZT1pXTkdKS09IcUN2QmdvcGtq?=
 =?gb2312?B?N284SEN6OFIyZ2prTGRoZkFtMldyd1B2Y0ZZWmJmSTZnYXlWcW1VZ2o3WlpI?=
 =?gb2312?B?amJKN3lXMUxIc1N5N0RqNnp5Zi9XeHVtMEplWklZeFB2Y3pOVFNNMm5NNE1V?=
 =?gb2312?B?czQ3QlN4aHEvL0xPSUh5K0RrSXBHWDloamlXRzlQWERlbktCRXFnb0QrNXVp?=
 =?gb2312?B?SmwzRDA0dnJVUjNhNFllR0pPK1UzTTRORlZhV1htM0s0T3hMMUtVd0hNNlNT?=
 =?gb2312?B?MS93Q0czb1A4R3FDR21DbnlRVkVMZFpmNkhJd3U1L29KQUk5ZHlDcXV4WkFp?=
 =?gb2312?B?c1BZTFoxK3ZsaWJQSURUaVRZNTNIVWNNM2MvN21NN2JnUEFRT3h3R0kwcThV?=
 =?gb2312?B?TFFodjQzOGZTZWFwOUhkTHNpRU5ZR1FtbEFKdjJ6QzB6RG8yTjdsdlVHa3Vi?=
 =?gb2312?B?c3FZS3BpWGxxbHhzN1NNaTE4NGZzc3pSWm9wSGc1bmMrb2I3SDJ2QlAwaG1C?=
 =?gb2312?B?QytTcGcrend2anZZQng1aDYwRUVYUkM0Y09XM1FjQTRTUFlmWHcvN0VVdFd2?=
 =?gb2312?B?dlhnMHJZUForblVGVVRIeHlwUkZDWHR1L2JiTjUzUFgrRHQ4MHZXQzlaN0xI?=
 =?gb2312?B?bEdpZnlLUUVXaFBxSXNFY2liMFYrSTVJaTNnZGtxZUdDclFCemE1aHFaOTkv?=
 =?gb2312?B?MkZEL2pHaHRpWlpVbnpKdm1iTk11SkZwaU12ZU55ZGdRZ2JwSEF0dXhUL2w3?=
 =?gb2312?B?WktXME84UC9ic0tMZGFKTEFtMjVqbnlGV2RWRXJDR2xiR01qUzBwM3NZVTFt?=
 =?gb2312?B?RkZFN2dyeWhjdTV3YW5PNWVVb2RvYmR4cmxGY1dmRGRTN0FGa3NILytmSm1I?=
 =?gb2312?B?UEdxZEo2RGNiTXhUK2U4eUR1UXJQNzQ1TE5LMnlmNDRuSEF6dXd0YTFqV1hR?=
 =?gb2312?B?NGFET3dHc255MlVHdnFKLzdXak5MOTZBUTVleXk2TlVMbnFLZWt6RHU4MXhP?=
 =?gb2312?B?ODZCQ3FqMkcvYXp2bFIxTDRwOWlVL2dHdzBoOWpHek1yeVp6MzhCb1VxbUhE?=
 =?gb2312?B?YXdob3Q1WC9Qd2NveVNja3l5cjVoMFY0RDJaRGNvcjFYUjF6bkJYa0hJSWNW?=
 =?gb2312?B?UVlNd1hjeFIraGlsWlFQd2Y5b1M0V2c3V09xYW1ROEoxb2ZlK2J6SEUvM2Fo?=
 =?gb2312?B?Rm1xZHJDT2dMUGhoUGg2Q2g0VEpUK1NRSGtFMGVIZDgxVHhQeERpdjNqNTRX?=
 =?gb2312?B?Qmp6YWZlVXdOWTZZbFdkaGJMTDJ4cDB3SmxkMlZveWgzTXFUN3VOa1JVY0lJ?=
 =?gb2312?B?MEpaSDZNM0FrTkdKYzJ2SjdlK3krZDI3RnVRZ1diL2c5ek0rY1hRaHF0UDJK?=
 =?gb2312?B?WlVlc3RVMEZaWm5Gci93eE1FRGVYVFhYVEtiTXBJWUdMY3hIVlFBUXEwVTc5?=
 =?gb2312?B?d0M3RjBoSS9XZG5taCtTNm5lNzVXTStyTXZmZlBtdnZUTEVIdENuZk9OWnpN?=
 =?gb2312?B?QWhRZWdGZUs3eWJuTE5LVDJYR012Y3VlZ1pzS2xQTmoxSFRNKzFhZ1J0VjFv?=
 =?gb2312?B?K2xlU2M5MWpuTlJrWVRWYWhXd2tMR0dydHJnOGNWck5IdDF1R2N6MUR4OFR5?=
 =?gb2312?B?UmJvRWpQdWpkNVg1TkZNR3YraEZTTjE5N3MxZ0R6N1YyTU9IUkI5VHArbUNT?=
 =?gb2312?B?NXdBZ2htT3k5MmxwYzczVm8vYnNETjhiM0VhQ2N5Ky9OQmFZZFlhRlR1K3Yv?=
 =?gb2312?B?WjVQeUMrN2FDT3dmN0FtZVJzM20ycmE0em8rMlA0aDdrSDZTVnZCdXdsb3hC?=
 =?gb2312?B?T3lMTVNCNkY1VTROaFpnWWRhbSs5Tm1XKy9hcGdRRW9TZ24vM05VNUwwN1Np?=
 =?gb2312?B?Z3ZiaFdzT0J1dk5SNURlclVrNVJlVTV1NktNOUh3bVgvMkdBM2xMUVhPQWhZ?=
 =?gb2312?B?SUxtYmFBREZvVTNQUXZYdXluTzliWnFxV2hqMmRUT094eXcxUzNyNThDQmwv?=
 =?gb2312?B?NG5vUEVja3RLZXArV1VwYXV6NC9YbUhNaGxjb3hMOG5ObEd4YjNlZ3FCdFRn?=
 =?gb2312?B?MGVwbTFDM2p6ZmoveC8xekVJaTQxQVl2aWJ0elY0WDJrOFQyNW1IOWRLVXQx?=
 =?gb2312?B?RFNCUmVCUnJJQXRYejhoelNIa3U3Uk0rVFZKTUVJc0Zmc1k1ZUhSbEZpekZu?=
 =?gb2312?B?WDhQekhoYVYvNS9nb213dGZZZlRoOFI0SU1iUnVJWnBLL1JOWlZ3UVpzbkVV?=
 =?gb2312?Q?dZoPPNq3PzS+3mpnduXLJ4wgLwavxbltab6LziDc3U=3D?=
Content-ID: <0F42DBE77297CF4C950BA11449638D22@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37721047-2ab4-4633-bc54-08d998f518e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 02:54:30.0801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uikQqKmaH2GTLCoW58wjNqsflsnqPj1MwkiXGxxfhwimPa+MksmxKJsm5d3LdKapDokD/Yt31lOYZjOwt9K7UBJcNUjJtYO0BgOf/tCSI7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6538
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 04/11] syscalls/quotactl[3, 5,
 7]: Add docparse formatting
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
>> -/*
>> - * Test Name: quotactl03
>> +/*\
>> + * [Description]
>>    *
>> - * Description:
>>    * quotactl(2) with XGETNEXTQUOTA looks for the next active quota for an user
>>    * equal or higher to a given ID, in this test the ID is specified to a value
>>    * close to UINT_MAX(max value of unsigned int). When reaching the upper limit
>> @@ -16,11 +15,11 @@
>>    *
>>    * This kernel bug of xfs has been fixed in:
>>    *
>> - * commit 657bdfb7f5e68ca5e2ed009ab473c429b0d6af85
>> - * Author: Eric Sandeen<sandeen@redhat.com>
>> - * Date:   Tue Jan 17 11:43:38 2017 -0800
>> + *  commit 657bdfb7f5e68ca5e2ed009ab473c429b0d6af85
>> + *  Author: Eric Sandeen<sandeen@redhat.com>
>> + *  Date:   Tue Jan 17 11:43:38 2017 -0800
>>    *
>> - *     xfs: don't wrap ID in xfs_dq_get_next_id
>> + *  xfs: don't wrap ID in xfs_dq_get_next_id
>
> The commit hash of this fix should also go into the tags in the tst_test
> structure.
Oh, yes.
>
>>    */
>>
>>   #define _GNU_SOURCE
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
>> index e811e47a4..fbc7f5924 100644
>> --- a/testcases/kernel/syscalls/quotactl/quotactl05.c
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
>> @@ -2,19 +2,28 @@
>>   /*
>>    * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>>    * Author: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * This testcase checks basic flags of quotactl(2) for project on an XFS filesystem:
>>    *
>> - * This testcase checks basic flags of quotactl(2) for project on an XFS file
>> - * system:
>>    * 1) quotactl(2) succeeds to turn off xfs quota and get xfs quota off status
>>    *    for project.
>> + *
>>    * 2) quotactl(2) succeeds to turn on xfs quota and get xfs quota on status
>>    *    for project.
>> + *
>>    * 3) quotactl(2) succeeds to set and use Q_XGETQUOTA to get xfs disk quota
>>    *    limits for project.
>> + *
>>    * 4) quotactl(2) succeeds to set and use Q_XGETNEXTQUOTA to get xfs disk
>>    *    quota limits Cgreater than or equal to ID for project.
>> + *
>>    * 5) quotactl(2) succeeds to turn off xfs quota and get xfs quota off statv
>>    *    for project.
>> + *
>>    * 6) quotactl(2) succeeds to turn on xfs quota and get xfs quota on statv
>>    *    for project.
>>    */
>
> Here as well, the list should be fixed to render as a list.
Will do.
>
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
>> index db477589b..a55416f0e 100644
>> --- a/testcases/kernel/syscalls/quotactl/quotactl07.c
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
>> @@ -2,6 +2,10 @@
>>   /*
>>    * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>>    * Author: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>>    *
>>    * This is a regresstion test for kernel commit 3dd4d40b4208
>>    * ("xfs: Sanity check flags of Q_XQUOTARM call").
>> --
>> 2.23.0
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
