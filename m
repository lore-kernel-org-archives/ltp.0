Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEEBC4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 02:22:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 000D53CB035
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 04:22:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A31F3C4CCC
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 04:21:56 +0200 (CEST)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 789A31A006E0
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 04:21:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1666059715; x=1697595715;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=gW/jE0vBRNV0H084XoEtzxq8ZMC60Z5cKFKRaFINcTs=;
 b=tTsfrn2yzpr2kzBZ5qfQolOIkpsL1cakhyxNfdVgjjpT0TNUMJw5vcyV
 biW/Wi1cJiFyOdBg4MA7AANlWoQDYKvzHs9t4Lzxk57qq1pH68Rjkl3ae
 LNou7li7x3VdyRpTPB+bFoPmZ68dIh+kgDoGJwXV9zV6aTPmcxrSMuVjB
 l+n1Khb+crxxsZ4rF500RBVMQc5rkKwc/Fy0VqQK15Q02VZ9wi/dwXzh1
 sYdffAjdrlHoqw6TCGQsVrrW70BXuNkMpUNup7Iqi2Gpfilc4q7kSHBr1
 ySzZDxmT2i/uo9TFWtHCF2zobJFeINusZLBqH8S7W3Mys+Ua795mrQNtZ A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="67725139"
X-IronPort-AV: E=Sophos;i="5.95,192,1661785200"; d="scan'208";a="67725139"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2022 11:21:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpyJBUbB02LuT1MuZEP3Oupr/JjQuORxyh4zfa4QiXirqGNj7Br83HXwhjtTEdCc3YmGu0j3XI6MemCHKpFP5zH69WV3lkmmV9VN060NtGoTwjnRg1r+PCiN71Vod01pUtTGTUw+VeW8bj7ULWlSWRz3OMIKOAlgzLO5TTCfAcyrPf0bDrm/xRPgceRE4ZIH2BeHyxZiP22k+O7VpWnHwDvx2kH1U9B1ARW6Op+ULxn+xkF6oSnIEXC496JB4oRuLRMDzHKyhI3d0SkTbbjjo2+jbqpgNa4wPjYuie39b5ZdAeC7X4ihmekIj3y6htwoeP8zKYMHWQSPJxZNa/KxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gW/jE0vBRNV0H084XoEtzxq8ZMC60Z5cKFKRaFINcTs=;
 b=ZgxJriOazOP/xO+03CPfLgOEGKiX7tI1cwR6T8DtkU0i2ne+LmBmTGNLkig35QRllik5NO40xx8jfsq5OWk0bfQOSyiRckdjRZAa4sy679wnvjIbYbnqdMqgtKj9oSPtt3idLCgxT8UYYqN5bbm3ufogvuF1qjxeo1joX6fZ+hCZwbAA2z1PXBORvYpKwYVCOJEd0Om3wDcUjVkC1rYDfTGQePPtvXm6ygT/MUM7Ica5VkamC4OgKZ8VjQ0EBp4wMxh3vO9U3N6yf9KpcKEJ/hmUsE4T1oVSSeOhHpl2NjIqlTfI3Y3vNjg5Y0KXID9MllV/P/YtWr21SgFxRdLKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB10072.jpnprd01.prod.outlook.com (2603:1096:604:1de::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 02:21:50 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 02:21:50 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] cgroup_core01: Add CVE reference
Thread-Index: AQHY4gzzTEgQXyWlTUOj72TQ/GsRYK4TfZqA
Date: Tue, 18 Oct 2022 02:21:50 +0000
Message-ID: <091f0243-2a0a-dde0-09db-9ddbf6032044@fujitsu.com>
References: <20221017094332.26952-1-mdoucha@suse.cz>
In-Reply-To: <20221017094332.26952-1-mdoucha@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OS3PR01MB10072:EE_
x-ms-office365-filtering-correlation-id: 647bcb10-245e-425a-5ae5-08dab0af83e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UOtm11MLs54c9eWqZZdi07mVh6fXIJg6600wpDKCT2iXNpS0IweCO/r4HSlWOJ9n4+BUYFZgcdrlx7JrAgk1eJizVr963B02SwtiHxUPPXHLUb2ph6S4kSNBc9ArLRaeR4OdKJyjEULs+uv5hWhuU+iKaKInHnTZucKez7yPNtcK7T0KOd7eiILvndwBtHEa/OoPnDvk0FN2bJiBx7eh+pccSiGEYb0Pdogq/YB71V0SiANdf+nR4fPamoXbEY5b06IoMeuOFgFw5OBgVIS/zImyqHGwkN7AMWwE8qM3HEMCSSw5Y4FaPFzshN7PG67wygU7FZ8l/pFkwTC6Z47BGLG4fxrBjTpVEvj8lC0J/Z57tjkZdyZR1nftU94TLWn2xMiAkvQZcQZSi9WIE6hQY26qS6eXyELolTWXgRi9Ap0YnuBRE1Nq8EE6uFOKKxxkfMTSSTvm5IMYysOQoHLAys21P0vCzcqkFomrXbf4zx4tI+Qbp0Iy/pv1Wo2yIVmNxTMUPtcwZV+vZzPtM5jk0tRWlKU5KXBSN2oOqSMCqqviH/jEoocFVB717lePAarAuPj8JZu7AWQzUwGmaBRb5HUUWZYdLIEfZMv3awitt4zirVJhLoVHg+Y+xM79YzvITxjYW/QV72HfrB2yKkGcsuC8T5Q+g1yvGB2SW2TanRZ/HuvKMyukFYN133EFt9R2SR+ysIROyNh4LVaXQLI4/WPegJHQU86ktEPYPiaqTSGJd6JyFs0PPxymI55lbukp3/Cx5LzyCI/NL9QdZLFdPB7j9y147S2BbdmBnUvb27irYp037V0y7TqWil5YX26AP+1vmyW4rE3uFo8XrUGFZw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199015)(1590799012)(2906002)(31696002)(85182001)(82960400001)(38100700002)(36756003)(86362001)(38070700005)(122000001)(26005)(110136005)(6506007)(6512007)(316002)(31686004)(478600001)(6486002)(71200400001)(41300700001)(4744005)(5660300002)(8936002)(64756008)(91956017)(186003)(1580799009)(8676002)(2616005)(76116006)(66446008)(66476007)(66556008)(66946007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0J6ZGRuYVZ1Z0F6Q1UvR0o5WmZIVEVYcUNjTC9PUWtjc0J2ZktObnpMZ0pZ?=
 =?utf-8?B?ME41Ym9teWpvMTI3Z2hLT2RuTzBHUTY4MlZDZHc3RG5LL0w2WWpVakE4a3ZM?=
 =?utf-8?B?Qk1WWCtvcFB5THA2VHhqOWlCdHptRE4vZ3IzOWExOFE1a0szdGVvd1JBRG5y?=
 =?utf-8?B?S1RVdXNYa09RODJHUWY0SVVDVEozQ21QYm9MSmhZSHpydmpSQUFxb0V6ai85?=
 =?utf-8?B?b3lGLzk1citHQThBc29SMkdDTmMwcWQ2c2djZzBxVWpmYk8yMkRacWhpeUdK?=
 =?utf-8?B?V2E1Qk5UMlcwMnhhaHI4UFdySjdIU05HNjRCR0hMd0pFMUVBWUdWWUNPc0Qv?=
 =?utf-8?B?aE1heTNDbkM1Rm5LZ3RVMHl0OW9HUXY0Sy9zK1ZsOXR5WnR3L0NCaFhkSWg2?=
 =?utf-8?B?dUM1U0UyMFRmU010TlJwOHVSaGpjSVNlMG1aaDVSZWRPWHJJc3ZVcTF2OVlI?=
 =?utf-8?B?NW5WdjBSb2hlTFpHVWkyNGowQ1o2Sit2cW9VNjltMjZUMDZLcmxoZUU1eUxw?=
 =?utf-8?B?dUtPamlDL3hxTE1TKzdNVlpyY1YwOWpoSHRDVTFkaFp0N05xUkZKZTEyeThy?=
 =?utf-8?B?dXp5TEx6M214eDZyQnZtY2FGZzlOb1gyc2xyS3VLK2NxeW1ieUZXTVVKbEI0?=
 =?utf-8?B?WUpEYlFabVJsKzB1cG1BeXozWFRLaXRuVjdSb2NTeW9QenVPQnNSVWttdTRt?=
 =?utf-8?B?OWVDVlM1dEduSVpITFM3L0RUV0toQm5MaDN6azZaOHdrRm8zSkNEak9ySXRO?=
 =?utf-8?B?YnJSR0g0U1g2Q0cxdkZodm5KbzVibWFFN0NIN3JURmJsUVQ0MEtpaHBHWGFR?=
 =?utf-8?B?YTNCc0VlRlVLQzdMeVpPcGlyY3hvRktqMEM5RitpdDgyWFpMSnRYQU10OGZO?=
 =?utf-8?B?VVZId1NtV0NpakN2NE5ETW56emxTUHdhWjh1U2tkbm9JV3FqZDY0SlNkMXhs?=
 =?utf-8?B?N0tSTG1hbHRScDNSR3RMUm1qNEFSUnorWkd3Qk9WN1NOcENNSEtLMXE4YmNi?=
 =?utf-8?B?dUhCamtwcmN5T2UwWThXOWFtVjdhTHhLWFI3OXl2bjBybVFQenNEVysxeEtr?=
 =?utf-8?B?NWtKa1Bmczg2MkI5VmJtQjh0L3pTNjFlOWZFN3FFellqazhzeEU1ckNnRW55?=
 =?utf-8?B?cUlnMEVPdkplOE5XYXowVDFiSm1RMHMvTGlHQ0c3RkpEV2ZQeHBBd2MxRTVq?=
 =?utf-8?B?QzNxazNVcjJDWWNVWTdOVnE0WW9makFVRGNBMXZyTGdmdUY5SzRHSTMxd2Qr?=
 =?utf-8?B?TWRCUzBSb0d4QmRvWG5zcWZrYWhjSUV5a1oxNVlYNnVvT3A2RldxYXZodHVl?=
 =?utf-8?B?QzdjeVpDTXhDTml2dkpnYVFxL1BVSmFDSUxQWFMwUUliZjRkTWgvaFBLV1ZT?=
 =?utf-8?B?d2hoOUpnR2JUUS9aWE1HYk1KanEvL3ZDNzY1MUQ4aWZnN0Y3S1ZqMW1rRU4r?=
 =?utf-8?B?eXM2a0RtODhhcUpDUUhJWklJWHpxaW5oUS9EQ1hiNWJENVRjaHdJZXIwU2Iw?=
 =?utf-8?B?S1BXWUFKQ3ZjdHN1ZEdZaXNJQVY0QmNhWDBSNXMvbWxwWFNielVWQjROUURk?=
 =?utf-8?B?MUZDYVY4MncxU3N1YVljUVJVNUlxRTVFcERJY01LekpKWHB3MlhYYlMyYW5y?=
 =?utf-8?B?dzFvQ2hUUlVtbnJKaDFIQ3NJMzZJUFNRbS9Cd0V1WUdManBKK2dTL3VuWTFS?=
 =?utf-8?B?U0FVYjRidDV5c2Y0Vi9lb3J1Uzc5aWU2T3JpUTZFZFVFd2JzSUMxMVdtbHVr?=
 =?utf-8?B?Vkovb2ZOSUtQcnVsVnVQK0NhMU1DSGkrRGZKNk9yV2JJRlhaSjNRVEpTMHd5?=
 =?utf-8?B?NGpNR2xRUjVyRHNsWGNRSVhybjB0K1o5alBJajhCNm5ra0dleE5WZlU4c1ZV?=
 =?utf-8?B?K2RwcDJmaWpIQ2VWQlFwWG9zWXBZUnl1cGhSbTdneHUwdlRZclp3WVkwZ1BO?=
 =?utf-8?B?R0dNVzRSZy9XNlNRa2J5QjVGMzNXM1orQU85elo0R1BzNTZTSFM1OHAxTlRR?=
 =?utf-8?B?d3phTVVxMDNOTGIvazM0VVhPbWl2SEVNdGwwZFV0RnJUYW9qKzBPYmQ4ekNX?=
 =?utf-8?B?Z21tSXpBS1lqdHkvcnVia2FRQll5MmtzRlhhRzdERHprT0ZtQWszNCsyY0Js?=
 =?utf-8?B?MUdQSkNnelBqeWFNSFIwS2xjU2EwRWtRQi94Z3d1L0ZjOXZhc3dWZElCZ0pB?=
 =?utf-8?B?K2c9PQ==?=
Content-ID: <AB15A3BAD0CA4F4B88B88880CA429D54@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647bcb10-245e-425a-5ae5-08dab0af83e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 02:21:50.5064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+SZ07b0UOOkA5rb64UvkTkRM0StoLs4mKwe3JSZMu9B2jmkjH9Ig2/IIzLg/ZJ4j89F7nislYbBa5ZkmoEQPhqHfexvRzxUsvE5x4OXnHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10072
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_core01: Add CVE reference
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

Hi Martin

Thanks, merged!

Best Regards
Yang Xu
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>   testcases/kernel/controllers/cgroup/cgroup_core01.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_core01.c b/testcases/kernel/controllers/cgroup/cgroup_core01.c
> index fc60ae5aa..8b6243f7c 100644
> --- a/testcases/kernel/controllers/cgroup/cgroup_core01.c
> +++ b/testcases/kernel/controllers/cgroup/cgroup_core01.c
> @@ -102,6 +102,7 @@ static struct tst_test test = {
>   	.needs_cgroup_ctrls = (const char *const[]){"memory",  NULL},
>   	.tags = (const struct tst_tag[]) {
>   		{"linux-git", "e57457641613"},
> +		{"CVE", "2021-4197"},
>   		{}
>   	},
>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
