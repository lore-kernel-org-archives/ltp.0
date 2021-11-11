Return-Path: <SRS0=2GLJ=P6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A42BC433F5
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 02:52:51 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CFD61872
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 02:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63CFD61872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25D393C60CA
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 03:52:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B38E63C093E
 for <ltp@lists.linux.it>; Thu, 11 Nov 2021 03:52:37 +0100 (CET)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 012FF1400258
 for <ltp@lists.linux.it>; Thu, 11 Nov 2021 03:52:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1636599157; x=1668135157;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9MDbuFPQ2m1C9pkfkziv/2jBejDAM9CqOvghGLyHR5o=;
 b=aNDnnbAqdzK+jQaIuCIA0jzzOjt/Qb29wIVnUKIYomABSPEH5CzDH9sj
 JrIo7niwn26LdIz41MhTu7wOndQZxZ8jyAE+ysMUnUu8/aIDUDx0pqgVk
 cL3cryOcwGyTFgPO9X8WY/J+wYSf+vX+MrNzIHfXdAT0GxqgvuCImykBE
 zMczy0MqQo5azpiYEujbauaGDAQYHtbusCF61gVoU8vdUvjuyOODb7aJy
 xku9SqEGBAOHsvZa7v7TebBUrg6MDOmueKedEXN+OrctN7RhugVSQwSbT
 17EudmWiMXkpQQgfi+b/yg75ryOwvZk37eJar0dEETimiVSxD+11HV8tq Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="51576482"
X-IronPort-AV: E=Sophos;i="5.87,225,1631545200"; d="scan'208";a="51576482"
Received: from mail-ty1jpn01lp2058.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.58])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2021 11:52:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kb62YJLqah6IXS3n4Dl7ZLufJ036WAEURFPUNhM58SFpgaVe2ez7ZINizbMfPVOxRmJ3t8mNSgpvAotmRLnqnKyOoTww7LNAP0tF8bM76DvHkDOPtjA0l53pzD4ch+X+JMfWYkzFY+WyjmaUQqsdvv7g1VjXfCgFVmxKkv/TjMllfLFNmXvM6Ol8QDYHpAqhapM2lL8anSbI1nQRgWti3zEFlOBdIKSuEOjdrMBuiZ9Tfu3Ki37ISNEsRB6n/03fIcDiRHgzvLLbi7v0FMCsvbO7zrPmXMN2knEK+8rAcadbFStGBv6fF3sE3MaWK5tl9usNocZZHhfgFyF4dEdA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MDbuFPQ2m1C9pkfkziv/2jBejDAM9CqOvghGLyHR5o=;
 b=bg8QdRY1rXwR7v9nJYR1zlh8CsaMQYICO8qnbuYl5oNHP8ZBCwSrvx0NFOEkv6sYv/SwAIzuQqfhot9lfOD5cofTz2q8aE5A/YjnB7yYlnKCR6OFRpJGiAv4nNhF/1Lp4spL3cNwvk1IOLEQPb50Dunqg6kgLkJcladyg+LrYA2Xbze8IY/558MEfj9Vc+ocsf9oOnLaNSh0fr2bhEvvMXmRxwEPHmWmguCnBl0nViKu7KBRpdxdvGyYu4SYHD0rhPElgK/7Z7S/3/bEJkwD2YyLonhksfyZwG610jAg66kTGgKisltwv5KeOrMa3OofNPDGDQkdl+NmAqGSQcnt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MDbuFPQ2m1C9pkfkziv/2jBejDAM9CqOvghGLyHR5o=;
 b=Ert0ez9wO3URwgRVLBCBVySA7+FAx//Ups6HTI4WHmqE6Z8bjHqep0Z2kKpnVMITQ/foswliuXnOogI9ECSncg3jmZQN74MEPIYEII8B2q1m/PdEg3wpYIeKXP1dBX6o/ksE8LMuuUuC9ZUF3ybGNCm+wi0R+hAjM8hYOZkhMTw=
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com (2603:1096:604:100::7)
 by OSAPR01MB4689.jpnprd01.prod.outlook.com (2603:1096:604:60::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 11 Nov
 2021 02:52:29 +0000
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::5850:1d20:8712:7420]) by OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::5850:1d20:8712:7420%9]) with mapi id 15.20.4690.018; Thu, 11 Nov 2021
 02:52:29 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v3 04/12] syscalls/quotactl:Add docparse formatting
Thread-Index: AQHX1Vf+bQ0Hso/OjUamny2FsDf0tqv85vKAgAC8wYA=
Date: Thu, 11 Nov 2021 02:52:29 +0000
Message-ID: <618C8579.9030707@fujitsu.com>
References: <1636455161-8278-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1636455161-8278-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <YYvnIyyxb+8eOQ6p@yuki>
In-Reply-To: <YYvnIyyxb+8eOQ6p@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5619bc73-8615-43c7-2315-08d9a4be4d64
x-ms-traffictypediagnostic: OSAPR01MB4689:
x-microsoft-antispam-prvs: <OSAPR01MB46891B4A216380F419A7D8A8FD949@OSAPR01MB4689.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xWHkC5IBr6G2ppMrZtwO85pCcqYC1oFI67nueVvRJuc/KGFQRLjKgbeU8WaBP8+lO0eQaKZT0stMExV/JRLZWSRKvNBhG/KLF6oFNduafBcesHwoszEpYrOnYfWSnUln+X1ua5jTRxcz4BJw4pkBuKZPAE5/Z1wDaaoYRxo08ecJHXAEFoKmWtRZQ+XAo66HnbigXeLbbcINbcYyq8Kj63rQHAJQHtzrXf2TXgZamsCyzngi6VuORxWHIkHkmia0ClRpkYBpNftExQ0ClXSOvc1UwkEjUCq7VQXvAW1JIYHb3heVCStZAPG0s3alAKbzHDNIGv/G/+RnkFFrqJ/fZFDmb/yoEyAhvBd+yGIi3aTAAjzMAY6iCAwMAayR69NY/dLu7cz8Qg1VYPQbxG8+1PrqQfhMSwhoSXxqptVJqNJsJdpwTy6gp0Nn7nmgy+D7ICZU3wvxVL2I1l9oseCfret2xKvoi3bWexDeugHzGqhHxFMrHfpeBHx/HbEWNMBJ0QdKGI7jlZuDWBzJ00AqFdHXCHNmVh+WxERkb3CHFEthgzBbhc2QuWIYeJqixP42mW2Hiq+U7MpiXqIEGvgJQPsyvIPOn7SRIcfxFu7WEZfiGWWl8s/lMKJKh6noVhsWc0Yh+uOxy4Dp9XOOgXiz/A7QdKSpXK4Lb4KCg/sJncZ9pBv0f5PEx3wNJkeESuL8KlTLmKZ9ZorTPK+rNYiTLw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6535.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(558084003)(66476007)(33656002)(64756008)(6486002)(6916009)(36756003)(8936002)(85182001)(4326008)(508600001)(2906002)(6512007)(86362001)(82960400001)(66556008)(91956017)(76116006)(38070700005)(5660300002)(316002)(71200400001)(122000001)(186003)(8676002)(66946007)(66446008)(6506007)(87266011)(38100700002)(2616005)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?R0wyc244WGszRTdKSFNnSkl4RWcxdTN0VU0xaVNoK1hxK3A0VE1Lbmg3bzhQ?=
 =?gb2312?B?MVZCSlBWQW1sbFlKRTFGdUNnaUZCcTZ2UkMxa3BMT2lSam03b2Z3aEdRNGZa?=
 =?gb2312?B?NTZTUHFtL3V4YlVXaTRCY0U3SEdIQjYxWXdVMk9HQ3BCYXB4K0lmTWp1cFdu?=
 =?gb2312?B?cEVkcnJTRGgrRTVyaFo0T3JuZDkrU3ZFbVgyNnFpaWtGb05iMG0xdjhQTTlx?=
 =?gb2312?B?ODF0TU1teDZueGt6MGxWQU5tRVFEeExHZXhpYnU2Y3ROVWZNUWFvalpIMWxQ?=
 =?gb2312?B?RUFWRFdkTG5waEU5ZnJ5dk8yczd5WWgwSUlRTE44WFJHYllydkw4azV4TXJw?=
 =?gb2312?B?cnBqcHNuYWtuNWQvbkNOcVYyWUpLRW81Z1FsaXRiSzdRWmpPcU1Ob2tqS0Yv?=
 =?gb2312?B?ak54NE81NFFQZGVadWVyTnEwZ2FOejk2Vk96cHVaTEtEV3hJNlQrVmk1M1BU?=
 =?gb2312?B?eHpnU1ZtNFhBRWt0ckJPMU9WK203MUw4YUZRRmJRaXQrTWlsVmxDblFibWJF?=
 =?gb2312?B?c24ySkY5b2NxMDFsbjY5VXJlc3IwSmZvVHQzbVBUZnVuRC9FQWZUNGVWZTdH?=
 =?gb2312?B?Vkg4V2ZBQzJjMm5xakpJUVdITjRDWTErcy80K1VFL3UwaVZvYTBsdGFnZDJO?=
 =?gb2312?B?bjBmQnFGazZ1a1VDZ09Wd2E0Q1c5elVxeWJjci81WC9zMEtWek02K2s1aEti?=
 =?gb2312?B?MWc5U0Y3YVg4ZklmMStyekoxeWZablI5cWZQL3kyMWRJMUlaN2t5cE9oY3NL?=
 =?gb2312?B?dWZEYWNwZkZUcXZMd2N5b1Bkc1QwZ2ZYWEd0c01IMG5aNFl3OEIxeFlRb2hB?=
 =?gb2312?B?NGR4a2JEUm9nalAxVm5kT1BmMlFyUjYzVllnUU9xSHFuYzR5b3JaSG4zWTRa?=
 =?gb2312?B?NFV0TkJ2OGJiaG9abnc4b3c1bUFGQ2NjeXFZTGErOTJwbFBjL1k2MW95ZW1O?=
 =?gb2312?B?bGJ2VWhXWmc2dStPdUR1bStXcGk0blZaVkIyNG80Nzc5YlBSUWtISytnUEp1?=
 =?gb2312?B?cnRHOVBua3h4VEFxSklVYXBNdi83UGhONHU5cXdxaDNIZUsya09jVG0yZE51?=
 =?gb2312?B?RGpManBPRlZaejJhSzJ4ZTVTeHlSaDc1dm92ei9QeE1yK2hON2F6TEtxWSts?=
 =?gb2312?B?T3pKbVZhVzUrekUwcnJDbkZWTmhxM0JIcFliMXpCaGdqcjBqY3hLZDRMV1Fx?=
 =?gb2312?B?M2RQYUlmSFFaaG9jdEdTWnRpR0pmL0hQNHVGZ2tYUXEreDVUOFJzRXNuSEkr?=
 =?gb2312?B?aGZrMk1EU2hjNW1IcUhEcmF0UG96LzlGWHYwd0tLWFJvZFFWQjNxcmw0QTVP?=
 =?gb2312?B?OEI4QUdYZ0htUmc3ZHlZZVFyaVlUd2RjVGk5dGE1Vk5QekhlbDFqQ2pyakEr?=
 =?gb2312?B?YXV1eHBFUDIxY1Z2SHJ5MnVqc0lLZU5tbnlETWwxZUJQM1ppdjZEZjBIcHhl?=
 =?gb2312?B?S2ZjM09iRkZ1bGZUMTh6UGZOTGtVOFN5dEQ3MzZrQXpSbUgvV1Q3UFdhQURt?=
 =?gb2312?B?YzZDTGFCL0sxVGt1ZVA0OFZ5TXphalFvcDhTdWFHRnQwRVJIdGYzYnptaTR0?=
 =?gb2312?B?bWFCVm8vbVRBTmpKYVdoYjVxZ05oaFV4ZU1PR281dUxBTkxUTlpVYjZ4WElX?=
 =?gb2312?B?eVhPcmR2d3Mra2NiVEN6R0Zhd1d5NlBKWjRsMlk5d3RtZzlLSzhqcm1uUzVL?=
 =?gb2312?B?K0ZHQXdIZDRMemlNYlVPNE85N2NhaEJ6TkpPUlE3U1pyVlZTTGZnL3VmR09S?=
 =?gb2312?B?dUo0TElSY0RHQm0rckdqbDc0WlhIaGViTWxnSnU2N0tsYXFISVdLb3ZnVk9j?=
 =?gb2312?B?N2RwZmZCZUZ1M09WY3Z0R1RNOEg5UVQ2UHliT1cxWUhRUWxRZlJqR2xDWHl5?=
 =?gb2312?B?K2k2MnM0UFJDTGs2emFvckhQbGpDbkNYeUFEV3hWMHpoU3Q5cXFHV2lhQ2NV?=
 =?gb2312?B?WFpta0NoN29UWUxLQXlPbDNHZDcrZGVHS3RSVlV4TlJsUTZkcFlSR3FwN2Vp?=
 =?gb2312?B?Nlk0eEswazB1WnU3L3B4WkNoMVcxVVlCRCtCYUc0Z1YxNC9uZ2Y3aWgwN2ZE?=
 =?gb2312?B?bGJaeVZEdytCNGtVL1R5VG1lamVvTXNFYVBzaFFtdnZQMEc5SzAyKzNoWU1E?=
 =?gb2312?B?MnhIM2lGODkxOGhRWHhnTTB1VTJqejc5ZHV2a25mRnZzRmxyWC96cFlSSTlE?=
 =?gb2312?B?K1k2NnppUTBjL2dWODlGbk1JOHVCcDlaYTJKMHVBaGVrRU44aW4rRkNGaENy?=
 =?gb2312?Q?HGhyH9P4CczBXi7zp9ymFIC5Y5R0oSAxL5xWOak4Zs=3D?=
Content-ID: <CABC58C2BD598649B43E707800B59B28@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6535.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5619bc73-8615-43c7-2315-08d9a4be4d64
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 02:52:29.7839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVpH1dh8UL3T9pruKUzFYbOkmKkmeKWoNPB6XUn32zjop96xgmNRCgFtG4Ioc5IsQGcIySMP5hOfJ7hhQ5TNd3pMipDE/MV2rhIgrtjlfgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4689
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 04/12] syscalls/quotactl:Add docparse formatting
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
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>
I have merged the first 6 patches.

Thanks for your review.

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
