Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D6DC77B61
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 09:12:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBECD3CBA8A
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 11:12:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BA363CB2CD
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 11:12:32 +0200 (CEST)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D9955140075E
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 11:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1682673152; x=1714209152;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=xDfd5Ab8RgBoeKJc2+bYAR50PFoBZ84XYbzvA1QBL1c=;
 b=S5db/cAeDR2syf9lP0aAor1Qb2I84UTOaKMKBzrc+UM8HIq6LO5f8vJ7
 0LE4sja1aNJj3PAPH03LGXYvfiWSLE81/vMqNYR/pQ7aRCBCBnRNbX/5K
 K8y5MRxM/4DImaug1qwM5kOVSRz20VzkO0cPaXWgMmnEAxqpSuRG7M/ik
 s9+4PlkxorcpzEJHhoTGMCLad5GjcpVphPJZkK1+ADxsqN0xCXeNKYgw4
 Y4xmxjq8fe2JjMGRo+1iKqP4J+rPFueHSDYJtGbA7U0YNuJ3UpWB0Kg8T
 xVD8Iz5ztAvrYxEgL5MtaPr2dniSO9QwpvWkfbv3VOadGwMsBHI0+lrfx A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="82838197"
X-IronPort-AV: E=Sophos;i="5.99,234,1677510000"; d="scan'208";a="82838197"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2023 18:12:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTkn3joO0MiXvEcVPPAUtf47LKpzrP/9+OWTp6nTcD8ryM4k8cd6QMf+QQ8TkDNHBdGLT4FPxX6TG3+kivV+5Bm0DKGsDpi7PtsiqWM2ujIL8lvVhI19E5L3Na5R58k+C9IfjZFnA0G1+GSlIWZAbCVei/KgU9TqKxlIRz1TCzTp/KAL4n8m9DABN4XFTOWTmAwwylTqnEKYo1TVol0F/2eWcBMYUdDpuXrE/01qLRln8ZQN4GCivt2cVASVcQN694nFZKN+fKm/9+YHnQbj4kTLL8z840wj+sxZSWdHrFRFiWkmxtj6uwF/iTBVZIcJP0gK0T3FsxpcrYd714TQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDfd5Ab8RgBoeKJc2+bYAR50PFoBZ84XYbzvA1QBL1c=;
 b=DtNx/x/jm0ixjNXqNwUL5rqscL1gD3tdso/1jILgUlhhv1W7L/0ThmSGZYztvpuCjUdBz4kSAWNbe/LpFsKrAp8CiZJd56ixnHomeaSRqD0otM3qOvssthOWCPU27CQ5xxXk8jioCzsSropbniwPGCfFy0CdlUV5JK1LTm1qRCbBrpQugP1UcZ74g+TKKg47fE1IsB14xNERvNWqKIwt8Pcqjs6vUDy50AYayGjTcS7BWJ7n+FN2YvRidkhbca4gJS6sWcqIHP6wLzp90v/7in/nGki3Ib9Xnjj7FV0YXJfWkA5JcPtL+n6tCNA4copN/hxc+M37y6tSCTXtC1sTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 09:12:27 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 09:12:27 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] LTP release preparations
Thread-Index: AQHZeCAzk9nV0mTq20ajlmyUy370Na9ActgA
Date: Fri, 28 Apr 2023 09:12:27 +0000
Message-ID: <903b9fe6-6fa3-ca22-a0f8-ff97ffac9338@fujitsu.com>
References: <ZEjsKC6ESB1+mM0H@rei>
In-Reply-To: <ZEjsKC6ESB1+mM0H@rei>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TY3PR01MB9889:EE_
x-ms-office365-filtering-correlation-id: 8ef074eb-abe3-4606-da08-08db47c8b002
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HXpTjZsM55CEYFjIJT7BCKlfj+2BbQZFcylw4OQ2eL2Q9tOG53aJ6KeZriQePS4rKCdAeJ/mA/zEYvReK0qwU8jmqO32w2TnM05wrKWf6Xp4NCLWKQ89hMSFqbOVEzvYABPxQeyNXtTJ64/vRErg0ZZ91IEX/Hmo/2+vwbVE3r2HGUwexBrsSAW+Pb2O2e9Um9TCfNhukCaK5pgSo+fSn/yzHCBIizKNibEAdu5226RlrC5rIdEllDE+MyaGQCqeSVvF814WLa3sCAsXVeJeScmNCLY7Q9OmT9v/9ZmHTsPNOgZHcycqyoNmp+c+tVZJqdooeP1nlqDUFGhm8Zz9joEtm0nS0VO7hO5YpHEeJ/Q/DbqTSB3eYCq8nWcFeNHv5UdoHthm7gDibzYl3RhXga618rVpLm3g5mAQ/m6SfBXuGbNHW6cNztB/qR+T5mKYYl3Egopl6O9OA3vRs8jfMts5XY0LnPJmIE09LQ4lPfCxLkW/4ePjV9EI6RJ/BeOf+UIPyzj48DpLzORies+kYQjpc8k3n9TYslcUxe/eLr7lfLMW/Uu5rH9vMoG4lGVCufnXWSIq6a59rnCRpRRt8tvlwSpPxSc1l/WdiAolBWUp3dujA7cx+eWYIckjL/toJO+vn3aRcZMB7+HWxIYlYTFqOn+aFYwfq4tc3ReivL/lN8qwRk3ICt6E/Vq2q9EV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199021)(1590799018)(1580799015)(110136005)(478600001)(5660300002)(8676002)(8936002)(36756003)(85182001)(4744005)(2906002)(38070700005)(86362001)(31696002)(38100700002)(64756008)(66476007)(66946007)(76116006)(66446008)(66556008)(316002)(82960400001)(41300700001)(122000001)(6512007)(186003)(26005)(6506007)(31686004)(83380400001)(91956017)(2616005)(6486002)(71200400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmhqUXBJVVVGejJJcE03UVI1cENhekNvR2VDdUZTSU53VDFWQnpaZXZnU3dC?=
 =?utf-8?B?aUtRc3B6RmlGWnIxVjcyakFWWm5lcE5GdnBSZnQ2cDRpRDBiMjJqdjZETGp2?=
 =?utf-8?B?dXVIaFd5RkUzWXRsUnlrOFBTbTc3MTFUZXBtK09HRUNRUk9JMklOa1ZmdGd5?=
 =?utf-8?B?OG1URVVGRlMydVZnZXdvQVBqcFozMFB2YitlQ0c5bzI3cmJZM0dJYlJFenlr?=
 =?utf-8?B?ZmZ4YjJNMFNjMzg2bXNIY2I0dEg5Q201QUhxTnFoVVFHUm5zN216Zk9oNCty?=
 =?utf-8?B?dVZHdmEvdWpMdkZKaXhkTVdCSC9KeS9EUElueU1yQXhabmptYjlKRFN0UllF?=
 =?utf-8?B?cVZhSjJINkJMN295aGg5aks2ZXlCallQdVRKMUE3NE02VWJCUStaVEJhMWJm?=
 =?utf-8?B?VkRzWWJQQ1hlVUJ2SnZabmlKMDIzbVBsMVFlc3RrcUNPL010d0xleWhoV1M5?=
 =?utf-8?B?SmVHREZCRU5GQnNwb21Cd3JSRkRYS1o2aG11OG5ZaExrYXZnbndvZTFQMjB3?=
 =?utf-8?B?eHFzL3d4TDFObVcxc0hoV0tDK3E3NnNGdEgxTkNQYnJIdERDSHlDKzM3aDk0?=
 =?utf-8?B?WkYzWnJUNHJvUW90WEVTSlovdHpQVWoxcEhCcDRDazkwN0JHUXFzdkUvQ0FC?=
 =?utf-8?B?Qm10WGd1WGxlVWIyRzZNaURHY3pGdVZZNTZPWjZiY2Z6emJ6dVo0aTNnOGZC?=
 =?utf-8?B?cjdrUDI0NlJETTVvZEhaVWV4MDhxRm0vY0ZsQ3VBZ0hiQ1E0eFI5eHMvSCsz?=
 =?utf-8?B?ZW16TEFQVjNOcEp1RHNpb1VQaHprTE1INTBXNDBWKzhQVHMxYnIxT2JJUTZ0?=
 =?utf-8?B?cTQvQzNsaHZjUEpXM0FGSGtOVUdrQ2VyejdFc0ZXSUNHdk5FSnlyT1praGw5?=
 =?utf-8?B?OWkydDlvSXJTTGJLR2ZmeSt4Wm1KejNiZWN3T3oxUzd1bTVPbmZyT0dXZXpr?=
 =?utf-8?B?cW03ZXpUN3poUzN2RVRacVd5c25BTlcwRGtVY2ZjdDdKekQrc3h1cDlScXlF?=
 =?utf-8?B?S3RBS2IvQ01TTFIyc0tpMER6bHZ3aDlzZ3pPWWh6L1orTDJhSUtvS0hSak9j?=
 =?utf-8?B?QUEvZ2ZzMFBhb0s3RWdFSTNKOG1ZazV2WFd1RXdaNnBRQ09qMlFxRzVUckNP?=
 =?utf-8?B?VDdyWUFkcVFzeStnYnNPTmxrSEFxcjU1dEYzVWpFaFVPcDRNTk1pamZoeTc4?=
 =?utf-8?B?QThKcHJDQlo4L3orUEhFb1VmWlBDcS96cXVBLy9xZ05QV0VXd3IzYW9sa0tE?=
 =?utf-8?B?bTBCRUt4UmNyN2drU3ZXaWxlWmFSVnVVbWJDZTNkU09Fb3NienRpS3hyek94?=
 =?utf-8?B?aUxBSFZiQnE3MDdpK000Y28wNTAzY2s1TUd2Qm9LajVkdmFla1BrcTMzMmhT?=
 =?utf-8?B?dWlyblpFbzZSVHlSNzdHSG5XL2I0eVVZdnVRUkhodTNOTUFHbkJoUGtKTDho?=
 =?utf-8?B?OHNoNnMzM2F2Z3B3Q2VaQXZIOHdNcXJxNzVVbElJRmJkV1RxdFJrbEo4ME5k?=
 =?utf-8?B?VGYzNkFQNDlKZ2RoNTQyS1NjU3h6OXdacnNpQ20wVXFXNStmdWVVNXBaY2Nm?=
 =?utf-8?B?bUZJTmxsS2M1UWN6ZTJKaVA2R2VBc1owTmpSS0RKQ2tLSlVzMnVWQTkwNlRN?=
 =?utf-8?B?ZGREZUFEUUZVWFlYdTFzTHNTdjJ4bm14cFA1YzB6bDQySUtCMnpXdmpvWjRq?=
 =?utf-8?B?N1hGSnI2dEQxNVhlM2NzN0dCRlllM3VpbDhRZUNVYUU3ZENDdW03c2JpeHBC?=
 =?utf-8?B?aGRGb3o4R1kyRFhNUjJWdkRIT1BON0o4R0d0bEQzUjBRVHVGNEtJSm5kL0Qr?=
 =?utf-8?B?M1BEV3BtY240aXcydUdXZlVuUEdvWFNLTjlMa0N0MjlYcmZjdjFvc24rQjEw?=
 =?utf-8?B?V1Y0c2dVTVB4NWkxN0p6NUM4T0d2UVl1MjMyZTlaOERsNzU1TkVseGVTN3ZD?=
 =?utf-8?B?TVR6UjNMdys1eGU2RVljUnRtUTV2b3puSWo3dWpYamJ3bzBhM09GUkpBb0tJ?=
 =?utf-8?B?MkdFNDNvSEVLVG9GRWpnNmpnWUEvelp4MFlqa3dYdEVEYzVFYUJ3d3dWVmxo?=
 =?utf-8?B?QkR2Z1VwVTFJcW96dzk2NVJsTHN2dG9LZVNrdnpYdkJPWFJveVNiSUVyYW9J?=
 =?utf-8?B?dmZOTGlHVGovQ2R1T0FnbnNXV3JheWxBNmRuaU9xTlJISWJ1UVFzYlpyZlN6?=
 =?utf-8?B?K1E9PQ==?=
Content-ID: <0C7ECCF7F9296849B23D8167F2B888E3@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i2fKMQ70Zec9Q89jeqF/ukIQOLcn0XvO5wJJyFZnjZiENeC4Mth1/EABtGa91+qtwhmKQgXiZexK7CzhzfENgje/dMs3mda3kt+eQmKNFc9r/DLNz1o/hB2YS+QvTAXm/wpdZYVmlHTO32OLqe+4Wtc5HDxTK5JaXTzKUxD0poIVaWrgm7GFsRrbDJj1qsncHlzFYEdyQXPhhLKTnv/R+Pgo6OGefIuq1ZHW/do9+JehGqwllc7avkeEpxChBIcZfzeuIDKIfKYo7wgG20HJAMZdUfkgfxYQ7UjbZCvB2wcrlhf+uYKEUENqp8eN2AD55CcUbRFD9PKyxW59r+P6HXi3Rs10Us8Dqqf1qowhQAfUrIntqX6+L9Qd8QgF2jqvSY5B76TKq9K9wfGZxDhZd5GPQX2efZgLIw76JQlSFg9LzlqA1aq7CyS2YHC54u3PqBDgv1ul+iIiC02i25kmIXhEhr5sW5CSzLH54uk7+2Py224KPBsygxoU2Q5PoUci9ThYUaPvD4IXD17in4EjyjiGTWpEk9aYVA/JlPVM0IpFN5Yl/kcVXg07bxHcW8S+RE2EJJIvjwkZ1L0jKSpVmsOoz9cBMSeUani7xxxCdHBYHc1TGb52GrPhv7s7uV0qHIgGpFvbfU+vUPjsEjsHPfb84RkSRPKS/1xXA8izzNZMZcUqkhCEotzURR8+ja/WYw0qD7vSljr7U//DS/SweLK8MVdx/zTfhn5N1kdWpGpZBAA7nOoAb/lqpCn+Vx/XMQdyEquqVOVFMbOMn26eeQiwxXwtBzrq8zkYDk4TsTw=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef074eb-abe3-4606-da08-08db47c8b002
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 09:12:27.4570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7HGvDjcrMcT2sqQnp8ap/lZ8oZXWIyTqSgdzeVp7qGV6krqsdf9nLet7rXO2x7F12g/VvgbJ5uJuUprU7SWAb01BmjlpW28zccOz108K8R0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril

> Hi!
> I would like to start with LTP pre-release preparations a bit sooner
> than usuall, since quite a lot of things have accumulated in May, e.g.
> there is a SUSE Labs conference right in the middle of the month.
> 
> I would like to start with reviewe of patches that should go in now,
> freeze the git somewhere at the end of the first week of May and aim for
> a release somewhere in the middle of the month. Does that sound Ok to
> everyone?
> 
> Either way if you have patches that should land in the upcomming
> release, please point them out now, so that we have a chance to review
> them.

I prefer to include my STATX_DIO_ALIGN and mlock cleanup patchset before 
release.

Bes Regards
Yang Xu
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
