Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEC6C3DA6F
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 11:31:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83BA13CC412
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 13:31:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34AAF3C8930
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 13:31:22 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 329AA1A00362
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 13:31:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1692963081; x=1724499081;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=sSG3iWv4zyK6VaAtInpi6Uwc8mPriPe3dwjfTT7Cl5w=;
 b=eI8+y9LZGbtqz8SagjRp8g9vO9jAjUAWEtkU+CeArUZjJtHs2mkZxvec
 IMB5DUPRwlReDbjUhA2jq0Jq8BUG62a6J5X74o4Pv6UYG1cYglxKlnmdP
 iHSV9SA484Lc8FlUgD2sWAGKzz2/a/cABD1qtbKEJss86ye5WKRwAUvp2
 wstdnJnj6JqdM+PFPxask9hgozp40tADB8HZZ98ipTs3KrmQcgIvTPZ5d
 BOygLZK9C+JafDohDEGORj5bDhOJ9vf1627IIan6Ni6rT1HZuapkaGedX
 7rSWt9RGTD+ZxByQPBmlCzWUjHFmCzpbj+NoYnNhNVgC5e1AVDkRCBTDy Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="93034564"
X-IronPort-AV: E=Sophos;i="6.02,195,1688396400"; d="scan'208";a="93034564"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2023 20:31:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnxbLJmrDDzKDmJ5lCc0QomFqU/D/Mof0Flw4E/+cD6VsWYGlMhBSlWsL2f44Kpoqa5EpniP4NsqIJbNsOE18g/Jght5c/VuyVRJnsrhDxQ+wikGbtgKTWhcNAIQP+TuUDW1iT4K5iWkueedjlf7rjaU+5KSjCMD5aXDJxPWK1CuFJ93KIGEq+eumysPmajyn/JUdm28Yj4jg5RbZQprmtQulS8P0Wa8dsn+2fxcvlpXxX+2TrskBTZrVftofkkUqj0kTtjiBAl4nVcVEzF1BEOdj/4yX0tCw1FnQY5E3oiX1HqsecDfPiKiaOccLackmahR1ZMFgRCYXJizqddaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSG3iWv4zyK6VaAtInpi6Uwc8mPriPe3dwjfTT7Cl5w=;
 b=bU6y+I414aOaFMmeIqawGIFdxTuYML4RM35Wv5I4IcwRd9whUIg06j27ibjN8KR/eWAKCkTmHkk0qRs3euqh+jw88ccszu2dcSCdmcRHj56NJuLPP5gL8L4AtWvC4B9wcq2xvs3lwGTaZnMqfwCoohIqYbdMjh8uZ0Xcylf/lHl6hqfKqdWxDK+sTLE+HpSmSQFk11VyonE1JXbKpfnpU5qEw33dhUOdTAYtXTYQkmzCC+g/zfLz4Zqv3mWJG3lRHiWeHY7DKSpu5BIKKCCsrIaRwDKf3n4ev/8ME1VEon7O5CnZtQ+y8QQ1dPA3J46ZXdEKTL6iBpYAI+FFq/vLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB10723.jpnprd01.prod.outlook.com
 (2603:1096:400:31c::14) by OSZPR01MB8324.jpnprd01.prod.outlook.com
 (2603:1096:604:180::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 11:31:15 +0000
Received: from TY1PR01MB10723.jpnprd01.prod.outlook.com
 ([fe80::322d:8a4:4aa1:e8a5]) by TY1PR01MB10723.jpnprd01.prod.outlook.com
 ([fe80::322d:8a4:4aa1:e8a5%7]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 11:31:15 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH 2/2] hugeshmctl03: Mark struct tcase as static
Thread-Index: AQHZ1nu6F9hMZ4FiQk6cDxkSqLgklK/6umgAgAAn7wA=
Date: Fri, 25 Aug 2023 11:31:15 +0000
Message-ID: <00172a69-b5d1-2ba2-1d3e-f5f1c206694e@fujitsu.com>
References: <1692875480-22494-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1692875480-22494-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <5e20821e-ae06-4727-b13d-35d17e4099b4@fujitsu.com>
In-Reply-To: <5e20821e-ae06-4727-b13d-35d17e4099b4@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB10723:EE_|OSZPR01MB8324:EE_
x-ms-office365-filtering-correlation-id: 262b434d-3d98-4e67-cfb7-08dba55ecb31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m7iCL9VKwoKp0g3F7LfDJFf9bWD3lnfYpnEqbMqocrJ9QtR28Jnh64p6yHjy/9CwcJM1YrGVam3vdqUicE9H5sLtQ23dVQEhr26jmpdV1GrlHc9D8v/bS/maHtrEisOtucqFtvHhQhio20jy0/G3EWCWtjlA7M/taiVSZo+q2tlRT2OdI9YwQ0StzEl9W+QhE8OTfYr4L0Ao2Cx1IcqctyReiORX9or2Ok6rQkqsLFTIZ5uNkg1OaIUaW64FM2diu438xhrrcvijEXnP/sGbUGoXn3/So98hmNGOGXhpVPUHuFazOLZbrcHTakvgUZyR8KSjiG3IVsl0lmRaKOJ8dCZqxLxkFLxVGF9aYaT6ZCWdv8M0uzgJo0uMzHmx/dsE15c0yJqC0ZgK70iPwmxAUMlYI5pN2c4uVG41u8Y9wn6KyfHYnDJfXfyVHp8aqafQ48t4Xwpx8GM8raXkv5ggHo9VBI6V8u0vmLStrmFNvtBGM61/o9G+KXhoMk/Y1OHyWOTdGp5rKf0zawfE3PEMzcS+x+I6Uj/Fr45O4f0zt5icCNEB9Yr/X0BEiL4k8NDHbQcdAS1hoCCCCXRMqVNL6quvLmN0ukvg7uYFOUMVbBHcil1opU8q4h1iFbTpFBq8C9/K5Jn5+wKnJfEBlNoKayx4jbHtdbhYSt/tQdCfNmGmL6+dy+RQs/P4oqO/xDed
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB10723.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199024)(1590799021)(1800799009)(186009)(82960400001)(122000001)(38100700002)(38070700005)(1580799018)(8676002)(8936002)(85182001)(64756008)(31696002)(41300700001)(6486002)(6506007)(53546011)(316002)(91956017)(36756003)(66446008)(66476007)(66556008)(110136005)(66946007)(76116006)(86362001)(71200400001)(6512007)(26005)(478600001)(83380400001)(31686004)(2906002)(2616005)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXljMk15V2xnc2dyR0xFblJMejdKMmMyR1lBcDFVYXR6YS9qZ1FaZFlrbnFT?=
 =?utf-8?B?dG1pT0FDQVR4blVhMjB2QW5qajJTTW12T1EyZVhsZ1FJVkZjYzBBRGVuSTlU?=
 =?utf-8?B?Nm9vWkVML0h4OSt3dkN4bk96YUFxWGN5d3dkRDhWeU01QjQ2bytpSjNST3gr?=
 =?utf-8?B?TWxtSzlaWVlyZnAzRVNjOG1zcjNqb0ZCVG12bTZ1aU13MFFZL3lvNXFuckhw?=
 =?utf-8?B?V3RwclpWUEFQejBpWHYvdWgyQVg1TzduZTdzdVkzV1drYWpjbXd2c3hKcm9i?=
 =?utf-8?B?RXUyaUF6dENFUzBxLzVxZllnNVgwcjgwZTY5RUtFRmFkUHRqWFRxRjBXd3dD?=
 =?utf-8?B?QTJCNjhmRUlMeFRRKzF5RkJCano3YXRhM0I2eDFEaitnM210eWwzMTZzWmVx?=
 =?utf-8?B?ZXpEbjlwam1XU3VRbGlyNEp2L2R4TnBWUnFtYVpWZlNuNEFCVVVUMW40K1ls?=
 =?utf-8?B?QSt0MkF4bWJ1SzUxVWh6VitiM1kyakpBYzFjd2lqeVJjZTZTZTJ1T3BQczRk?=
 =?utf-8?B?d1BQTytDdTVJNUxFbjI0TDBCWURUUW81djNaQWZIcTB4VWw0TWRPYk1aVXFj?=
 =?utf-8?B?T3VNUHlyU2c3aSs2SXFjQjdQS2ZKRURILzZSUmM1eXdnMEl0UDBQYUJaSFMz?=
 =?utf-8?B?ZE4xWGlSaGx6TnVLMU5MT3NFdEV1dmV3UE0xWkhLd0tqTnhtTi8xKzJaNWVT?=
 =?utf-8?B?VFB4UWxHc1lhTkd4Rkg5ZXFyL2dxZ3ZGV1BGUUc2ZzNaRERsTGQyMnpMOFpZ?=
 =?utf-8?B?a1VqQ1hqS3BNcDllV0szZThkQXZXaE1NZmZJck1YL2RDT255d3pTUmxLcEU3?=
 =?utf-8?B?bzcxUzcxMm9ZVmE0K3cvb3I2MDU3dEg1SVR3UFJNZXlKSy9MWDBYbEdISVFh?=
 =?utf-8?B?SW1VVkhVbHJWb0F6QStaWkk4TCtjZzdnVllkNFdnbC80VVJQQXBEeDFDU0xj?=
 =?utf-8?B?VnJHUjRnSnRqQ3N2M29Wd1RaYlZzRzVWeWUrNlZJK3gzR0p1czc0RG9RL0ZP?=
 =?utf-8?B?R0NuY0cvRTdJeEswQXlwVHU3OFh1Q0hQMnB0WVl1RmxCUjBXN1N5V3YrVHRR?=
 =?utf-8?B?OGFDVWVXeWdpbFpEaHl2cXZ5MnMwZGxuU2cvSGdPVmtFcnBHdmZwaldhbWFR?=
 =?utf-8?B?anRTYlowajlnS1pzajRTL2FPeXNvS0Rwdm5UMEduTnlZNjlTQlpUVDR4SDF0?=
 =?utf-8?B?anRkRlpUbmJOTDhZTmd4WVVFZnJLdnRWdlc5TDBCVG1ZdENISHRNbFQwRldm?=
 =?utf-8?B?SXY4dlE2dTZHWlVPSk1pbTBXRnI0cEQxVWs3cWdocnpmYi92M3JwUEpiWmVX?=
 =?utf-8?B?Y2xhcFZid1hBS3NRVm5KeTJJOXlQVG5mdkxsUGJ6K0FQVXJDem44TWRBNzFo?=
 =?utf-8?B?Y004T3ZmcGxENjJQVC92RXBKRmRqdTJOakdnNXg3Qjh4K0E3VS9NQ1l1MEYw?=
 =?utf-8?B?YkhrNlhjYWFZdmgyMkhHeGg1OXVqUmFCc01hSk95WDNFbzNkaTJERTRCbTA4?=
 =?utf-8?B?KzNQeWxDbUxEcFowYlF2LzA3OC94d3o2QWdWaEhzVEZ5enljUEowVnhXaVI0?=
 =?utf-8?B?bzBuSXJrMWplV05Zai9paDY4eElJT3JSZ1ZJeXJ5dlhLM0RYZmZuSzF5S1py?=
 =?utf-8?B?Wi8wT1ZQbm9jc1pZeHUyVCtZaysvQ241RmxkY3JEVERSZlhIQzQvYktGK3dq?=
 =?utf-8?B?VU9rSHB1dnU1b0Y1aHNUNVFlTkw0SVU0ZktIa1d6dXh2WEsyMkJjL0lZajdG?=
 =?utf-8?B?NkxQRDZXTnBPUi91ZEluSGo2MUhId1JSTENBTnlTT25HUFdMMlU1dENuWG1W?=
 =?utf-8?B?c2twbmNhQ0thY091endkYTBPOG90b1VNdEhPNG1sOTQyV3ZueGZtUXJ4a0pm?=
 =?utf-8?B?NUwxVjNjUkxrN0g4OVN3cXFYVFZyTEtSVTRlSGtPTjk0V2RCeGRQalBlY1Ay?=
 =?utf-8?B?QndIdy9DNkE4S2ExVDlJa2ZSNVNESjJ3TEdhNUMrSlZsdUNPdlgrOWEzem5I?=
 =?utf-8?B?VXlRRkNoRUpaMUwyZTg1eVpCSnR3MDBJbGlDdmh1SEgyQmh6UUJwSitteWZK?=
 =?utf-8?B?bXhzbitlZm0yUGFqZHJka2k3UGk3L2dwWDYvMmRMeFpJdnp3ZXROamt6Tlp2?=
 =?utf-8?B?NlBwaldqa3ZOMy9ObUNSMkNjWVY2ang5SFFGNjg2ZW43aVFBaXBpVHc2TjVx?=
 =?utf-8?B?VEE9PQ==?=
Content-ID: <000274E2E339524DBA326137BA46FB30@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xrDwFrhSNFR+6gfAQ/GCU6/f59rssoqOBTsi+3Ek5ld58/tZM5Z16cJTzISw5MfZvywRA0dAciQuhHDnJEftJgMqzkdhq2xf0iS0z2Ephwm6AMeeaxRx4rmnWluHoDp0IoHRgGEE7AhZLC7ej5/iCLtSFXClBkjAq4Mep0daxUpvXPA02dtW/Lod1nBW98VHXD4bXz0M0z+T7PNkxj3VFCOJuH0vaVDjA/veHWicN4Y08v6jwUCuapAhusSRjh/vbAMDhSkuH0qMiDWTAp76m4iLBDCOwKQI0/j708sniENMzbV2r9gt2lDixiTmfwrSMuUR9XWOjutQTbAyF5ESiua9sLlSpueutXDlgc6NJ8OfCz1dUz975gmCPIsScMp7/qhWG6sSkDaExUrfGbhpTo+zbeiK3O0L6Nt3krDfATWa2W83J4/lR9nNt487SmCMGGgR2t6/J+yRoyGNEgA4qU/jNTd9VgR/BaxGzTtIOif4f6CNkYKY2V+ej8sFAQTqfiqvY+ToS5EWc3h9aJ7njhxW2l8x1Jjh7Y3Y3tfJy+r6tgRJQ+mk1GhxZ3xYPdF55jQYRdyc6UkkJK2HaZWDT9OtD9Ey9dlklyKODql/ysxxrn86hS/5QjCA6sgIcMIvkIiybIrQmQwe28afI0lb84BJqdYrJ+rJYv1QJjf9bcgCx7Zl3eqpi4tFc+ar4A0QXrWrpQzgHuBG4WmDoWDhsJKGEXEdVf9MJIEExNC2edTsigWEJtgfy3yygB4fuO/MMuGutQ7bnEiIoxyE5vGlxg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB10723.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262b434d-3d98-4e67-cfb7-08dba55ecb31
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 11:31:15.7549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZ736lDCu5LKw6SQQ2gVjd447SNryfpNo9ARM3rCQ+9pJkHBTj3QZOtOT8LUh5E56194TqfIgaA/cLqG7HobP/C4P8+TnMrZTEQyPYE5Bnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8324
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] hugeshmctl03: Mark struct tcase as static
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQpIaSwgWGlhbyBZYW5nDQo+IEhpIFh1LA0KPg0KPiBUaGUgc2FtZSBjb21tZW50IGFzIEkgc2Fp
ZCBvbiBodWdlc2htY3RsMDEuDQo+IFJldmlld2VkLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1
aml0c3UuY29tPg0KPg0KPiBCZXN0IFJlZ2FyZHMsDQo+IFhpYW8gWWFuZw0KPg0KDQpvay5JJ2xs
IGNvcnJlY3QgdGhlIHN1YmplY3QuDQoNCkJlc3QgUmVnYXJkcywNCllhbmcgWHUNCg0KDQo+IE9u
IDIwMjMvOC8yNCAxOToxMSwgWWFuZyBYdSB3cm90ZToNCj4+IFRvIGZvbGxvdyBMVFAgY29udmVu
dGlvbnMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdSA8eHV5YW5nMjAxOC5qeUBmdWpp
dHN1LmNvbT4NCj4+IC0tLQ0KPj4gwqAgdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdl
c2htY3RsL2h1Z2VzaG1jdGwwMy5jIHwgNiArKystLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobWN0bC9odWdlc2htY3RsMDMuYyANCj4+IGIv
dGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htY3RsL2h1Z2VzaG1jdGwwMy5jDQo+
PiBpbmRleCAyMWVjNmJmNzguLjYxZTk3MDRiYiAxMDA2NDQNCj4+IC0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobWN0bC9odWdlc2htY3RsMDMuYw0KPj4gKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htY3RsL2h1Z2VzaG1jdGwwMy5jDQo+PiBA
QCAtNDQsNyArNDQsNyBAQCBzdGF0aWMgc3RydWN0IHNobWlkX2RzIGJ1ZjsNCj4+IMKgIHN0YXRp
YyB1aWRfdCBsdHBfdWlkOw0KPj4gwqAgc3RhdGljIGNoYXIgKmx0cF91c2VyID0gIm5vYm9keSI7
DQo+PiDCoCAtc3RydWN0IHRjYXNlIHsNCj4+ICtzdGF0aWMgc3RydWN0IHRjYXNlIHsNCj4+IMKg
wqDCoMKgwqAgaW50ICpzaG1pZDsNCj4+IMKgwqDCoMKgwqAgaW50IGNtZDsNCj4+IMKgwqDCoMKg
wqAgc3RydWN0IHNobWlkX2RzICpzYnVmOw0KPj4gQEAgLTk3LDcgKzk3LDcgQEAgc3RhdGljIHZv
aWQgZG9fY2hpbGQodm9pZCkNCj4+IMKgwqDCoMKgwqAgfQ0KPj4gwqAgfQ0KPj4gwqAgLXZvaWQg
c2V0dXAodm9pZCkNCj4+ICtzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQ0KPj4gwqAgew0KPj4gwqDC
oMKgwqDCoCBsb25nIGhwYWdlX3NpemU7DQo+PiDCoCBAQCAtMTE4LDcgKzExOCw3IEBAIHZvaWQg
c2V0dXAodm9pZCkNCj4+IMKgwqDCoMKgwqAgbHRwX3VpZCA9IGdldHVzZXJpZChsdHBfdXNlcik7
DQo+PiDCoCB9DQo+PiDCoCAtdm9pZCBjbGVhbnVwKHZvaWQpDQo+PiArc3RhdGljIHZvaWQgY2xl
YW51cCh2b2lkKQ0KPj4gwqAgew0KPj4gwqDCoMKgwqDCoCBybV9zaG0oc2htX2lkXzEpOw0KPj4g
wqAgfQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
