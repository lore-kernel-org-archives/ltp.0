Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C8BC32771
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 10:10:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E7973CA1EF
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 12:10:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CA073C98BF
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 12:10:23 +0200 (CEST)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 38CE4600076
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 12:10:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660903823; x=1692439823;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=rZ3Tr13JeS/PTZLtACB6iJ3DPNaKd2fwbbzJ+QEf52Y=;
 b=BxkGaJ9tfHxRVQWDQmyRXMSjk53WLgfMw2TruqacoAWIqs1LQN51QtcB
 dKcYcFWNeDTUvOr/ZzPkvmspdWedVJSn18ZSfvpUQF2Eu8Pps+bjK4D93
 3Ph0rYXKMfDwGDiCkK5nAxkxIDHy+mdEX2XBcvQ5Y5cAnwS3xkFCD6HMa
 s8yS1iGS0MO22F0zpTbwJNsvWbVPd12M8v+L0kcP9Hu+Mjt267owgTVi1
 0b9r0J+FDR86EmL4tLmoGHOhkuZF9hX5O4l6od2idcxfxTHtD6iB1MOM8
 9J7LcnAiG6KozvEK9f80UwCrj0fIVZ9uQCcpCIlkPO/4gelOTbG1sB8+5 w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="71235746"
X-IronPort-AV: E=Sophos;i="5.93,247,1654527600"; d="scan'208";a="71235746"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2022 19:10:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcGh17bnpgz0fvJu4YlhH0QtLoFBAQOyqowCnfHjzeDUOWFJ/NNL/BNsYSDyidESBjrNm/UZpMUgcRowoaC7vKKJgmn5hD5hNxZur/ngLdZ3+nYjJFlSWnFs8TLTAfXSQJ5zelY28TFe1rI/U1H7yrQhbwhRUZtXkvcFOm0Y7yNzhG+cU3/rvtVnLxZkbLcVE+QsBQvE1A4RK9nYSLIBvNwusIDpNr/+CqdyIAJ7lvaT+9CHmNwoYiFxMjbO65FkEiyR5M4j58T5F2T8MGtVezlboaBQS6BXea6dApr/Bsv6ONAum0D2q+M5UmUiyU+uPAAwqDHeK8f6Wes4Y0c99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZ3Tr13JeS/PTZLtACB6iJ3DPNaKd2fwbbzJ+QEf52Y=;
 b=mQEHJESdnx1H1vDvWPclwa8aQRNpS9Orhn1arVlp/63dR77PcsnWnNKmHpeKo/s81PT3v2M+sLVj0Cgbn3spFgyrw4i3KEgeXOWjZaRzL5yjjq+53XZdYWJI4/QfyjPFnNG5EX6VOWmfl13iB+6cY/irD0VOZg2u6m0+bO6DvTPHFQXGhPU2ev+kcm9T0SQQJmgVxbSMq+JWfAK7mO8bx0rRYe0DC2H7ul+GCRExeMU38fITnC7yXzSRilt2eBYxqooFAzB29Xns5MQeSjnjATZxs4MfSj3bfUB0KKRkyEwjLcVHAe2vMg0xqGlYf3a4LBKPvk4P2El2H+7sS0DCFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB4113.jpnprd01.prod.outlook.com (2603:1096:604:31::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 10:10:18 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Fri, 19 Aug 2022
 10:10:17 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH 1/1] statx04: Remove kernel comments in docparse
Thread-Index: AQHYs6sbVtcKUuJd90ucFfHvyztCDq22D0YAgAACLIA=
Date: Fri, 19 Aug 2022 10:10:17 +0000
Message-ID: <269bbc89-2a89-9eac-e4f9-69b66a862a23@fujitsu.com>
References: <20220819090704.17219-1-pvorel@suse.cz>
 <950bbc2f-1af9-581b-c7a2-e6d39fc276ec@fujitsu.com>
In-Reply-To: <950bbc2f-1af9-581b-c7a2-e6d39fc276ec@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9815c9fc-be10-4401-19c8-08da81cb0473
x-ms-traffictypediagnostic: OSAPR01MB4113:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LPcoNrx8hOuuHwBT/vX9i2NFGlcZx2KhCokkTrSTkq8J0E+8whki+K8j9Zja77M4xP35Q7KFF22rzijSbGtXyeaEBvIYpKVHweW6cG3TGk95yTA2tF+X5fJE/uae2cQBwCcexxZs7YrUGLZP5x96DuO162yjsaT1swJwcaWPBmGDc4/45m9Kt/lC9m/3fiQLb+nhfHWqIZVqQZVSkBLZCMA/Ly0YZp6FB7mh/ovKb2ae3jpJWGwF5ysRIbIoPFZ6Tpl6WNPpjMry7uxi0HMOy7vmhCtZUmA3MsLUJEXRuyA+WEzHB1lx25zR0iEqPWnGM4W6MDG7Lo+dK0QSvwSc+O5cnbN94rdTkU0KuTqWfCU6bfgVWX3uFprRT0Zd8DR6iHKuStwZTDtUTywXq9EFPkRl/yDMHpKF6LXt3UD2bf/VyUUyQjcuDg/U0pe1L7o1NWVDkVQQTkVNaF1Rc382j16TUd2MFa5enBPkWTtn/Bgr8fx8YPPL26igu6hUmtJmGII+b+BmQHpiD1rfleJ7Kt3l7y4NBNOmexwpRXTm2YUR5hG6E6iWrssIIqkLej9xKj+f4Ug29EeTthpgGgxru+FIjfFKCizyZf47RMJZmuiHs8FLhu0oKtbFcnWnt3s3CknrbVCEgaZJnVFn+ZNkqnGG/Df42KclK1UE1C2sNmSEKm+5dbUEBuyWiuU7LlfD2UemQFeJbVawWNLhoX+BgSpKzsmCfF48JvOCKCSLcV1xZOZiSci+zwPrC4OOW8HPACmfueMebWBWwy2jwzmSDVa+vP0ZeA/rzknyG3Aaj2Gnlurohjq5o5IYXoteQLOLMcXSxW1Neh4pT3e9TqUI0WBE5z43jxU5oAoVjLEqEp0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(6486002)(66946007)(66556008)(76116006)(91956017)(64756008)(85182001)(38100700002)(36756003)(110136005)(66446008)(8676002)(66476007)(122000001)(82960400001)(31686004)(31696002)(86362001)(38070700005)(1580799003)(83380400001)(26005)(6512007)(966005)(6506007)(71200400001)(478600001)(41300700001)(316002)(2906002)(186003)(2616005)(8936002)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3hIajg3ZGNHa05nVjBLeXNpS0U1STY5ZlZBWDAvMUUzR0kvNFVIR3pmOGQ5?=
 =?utf-8?B?cjVqeDVFWW1XZWZpakdFYUU5NUZISXNNakt4L0NkblY0UzUyVnVRQkYwYTJY?=
 =?utf-8?B?TFpmS1creitYKzVIbmM0R1pTc0NDZEcyM2tGb2REeDZRNXpJcjlZdTl6REor?=
 =?utf-8?B?U3JsU0NrRDNjWmlnQzZwUUhQVWNNai9mWW9EblVucG9mb29zN00yM08yVU1l?=
 =?utf-8?B?UzRCWGFWcERoUnNmYUtxdzhUS0lvNkU3Q1FPS1NTWEZ5WUFNdzVVWTZMR3R5?=
 =?utf-8?B?RFN3TU5pRFpQUE9IYW9vM2Z5cEh0b2RCbTN0Sk0rVTQ1cEdOeHFHRFNCOHlL?=
 =?utf-8?B?RDYyQWN2ZU9sN0NnV3o1YklIWW1kUyt2UDQ5cUdOTFkySE51aTREVjFYYnB1?=
 =?utf-8?B?R09jRGpoWFBSeDRVRURNQ0JtbTd2VWsyOFdTL2RkMlNiOVRhUEFsZ0g0ZGFj?=
 =?utf-8?B?M01WTXVTNVNZWms1M1pwS0FMc2ZuVStZRmxhRDkrR3M1bnJqVlBuL1JUOGsr?=
 =?utf-8?B?MDZXYkRIV1lwTlFJajV0K0hNczM4TmlxYTR3T0ZTdFg5Z2t3VlZ5OHRHZWxj?=
 =?utf-8?B?QXB3aEZkSlFwSEdnNGVVSGduNjB6S1d3Y3JXOG5MOWsrcTZIdE9venoxdGV1?=
 =?utf-8?B?VkRKa1ZSMHFtQldLQ25JQ0NtYmlMeUg1amhWZTRKUWgreUh1ZDQ1clhNL0pt?=
 =?utf-8?B?WDFLVC83Y3JSb21GVFpxRkN3L20rSlpDZkZucU5QeUVMY2d2Q0pmVGMwMU1F?=
 =?utf-8?B?dE54WUkxUFJFa05LR1dCbUwyRTNBLzArSm9SWlFBRldvMFNZdXpZYWJhT1Zr?=
 =?utf-8?B?dXIweWFFb09nSXVjS0piYWJDeGZ1VXFmSHJONUpqVHRtZVFtdGowc3owMlo3?=
 =?utf-8?B?Z2JsdGNBZUZKaE1KU2dvejFhTFZRUlM4SnpvdUNSYzFWQmNUUFpaWHc2SkJx?=
 =?utf-8?B?OTdoK3Q1WitCai80TUR6cXBjc3hUMUpWemVDVnQyVWowRzdXc2J0bG9hb2Zh?=
 =?utf-8?B?a2JoUWVvb1pGR1BuWHRZYlo2YmIvYi8yTklNZ0tMOXVaeWNKV1NnS3UyZmpv?=
 =?utf-8?B?ZXNnS0JmNHRzQ3pSVGpWMTFPSDRrN1FZNXV2bzJCN3d0bHBkYkdqRDYzcmFh?=
 =?utf-8?B?Qlh0T2dLZEdwWmJUUzdyNWNXYmtrM0d3eGZub2VLN3piZnJUWEYraFdHd1pu?=
 =?utf-8?B?Q2Z2cFlvRnpWR1ZUYmxXR25UaUozeFB0L2ZvK0pIbG5WdEFCYkVHSTVoci9E?=
 =?utf-8?B?ODFIcXg1WGd2cXB0ZmxSLzRpK2lxZldjWVErMlBEcDgxRnJXZHlVNkk5MHoy?=
 =?utf-8?B?dm1sVFhvby8rMXY1NjNvYVh5ZG1kZy9yeEdUdXRhanJpRVFBdkxNaHZmQVhh?=
 =?utf-8?B?YlRWNXNIUVVvMTcrS3krdWZGV0NjWVR5bU1iY2JoL092anRERU1kY1ZsMTJu?=
 =?utf-8?B?eFJkSE1IVkduclViME9sRWZ2UmhEdmF2UjVPV1I4dU84UTNGaWx5ZFptVkoy?=
 =?utf-8?B?NnUxWGZWZXRmdE5LTEcra3FJUHY0KytDTUFaWUk1TEhoaG1VTHRqdnZqWHVx?=
 =?utf-8?B?SHM3RVFXZ1FEL05sdWptdlBhNUJwSUQydTMvV0M0QVlBcVc3NklIQldpNzBs?=
 =?utf-8?B?ZEVmaUNlWkw1aUQycUwvakU5akd3NSszdUlFKzFNMnVMblFab3FUcmxZajhp?=
 =?utf-8?B?U0ZoV0VMenc1WTVNQzQzZWpCVU1ZT3I3d0ZPVWJuSFpPMXlCOGIvdkVjRndV?=
 =?utf-8?B?dHhIRC9LbFF4b2REYVNRRmk4bTU2ZFEvUm5adWFOVWRvTmtwSjVaRGV6SzMr?=
 =?utf-8?B?dkFmTXNoTUlQRDJ5UFRxOG5zNmxjYmpzN0h5cjdJbjNzZVJnWUl3MFJoRFEz?=
 =?utf-8?B?bkJ3Z1ZjZU9FaTFtVHJyakFXYkdDd0dWM2VXTW1pSWcyZGhHRjlwVlFQUWhG?=
 =?utf-8?B?Nzk5TzN1a3l0cW9EQkExQlRsNm5XdjMwSUpKMW1Pd2JDTENTOGtMNVhvbGVr?=
 =?utf-8?B?V00vMmJIR2JiMVBSdlFlVEpaV2pFMHRZUXlHbnpzVS84T2Z1cjFia3g3WVlM?=
 =?utf-8?B?dWJEdHcwTjQ5bHV2emhuOUZhQUhtSmc4NE1jdjMwRFNjM2Z5ckYyM0dqbUYw?=
 =?utf-8?B?dEkrOEllWHY0Q3pQb0ZQV01KNHJPSFIrMU1ORlRueDQ1cmVIV01zR3E2eTVL?=
 =?utf-8?B?emc9PQ==?=
Content-ID: <E6B5BA672086554292C9544AFDC0DB44@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hY5gEFITL7ryIo5kthZKuffx9fdsGB4AWZ9iALBodvtk2wIi5ZkFE/6R2KLXA57Avn6S/2IC87sTBF3IGwPqCE89kk7ANM/CeMH00qvLrZbI+3lWJ8lHj4B+oh1qiMc3BWgU3eQbUi6N+xoXsjICXOirpev1BtzvNHxnSe16Zes0d/J7zH1tcWb9hTP0Mzvv6d/m1pVbCarvUOhWAkfU/kO3i1oUbhwz5Ah2/ABKrAmnA6VwpK4JneJG/6CLPuigE5H6Lcb2U3cXr2wANroGYvUHMZ0wTDUForxsrHXNrqm56dwPs87FlNlpRjWj6E0TPTEeV/s0jKr5ujsjJJ3w4c7frm7AWS/QhBvs4dfcsStsdpDyQr+k953F1a6UGXGaDIWApE9YBLGkQ7oJzaJN916heu1Ta+NYvf9AyFGCEhNLUKXfByDlMaLIZBzj/I6f5AHcAOWfHM1uePSp1lV2I2TKVrvaNvWzt9aHXdhXvMUA+WJxebCUasZ0v5mmo8IMG4QsSAq2xTOCWgjD8UyvQHYlgdBCc5lwHLnqRZfI5Yho8WFbCLDLBCPrCsX9WYk+Z57C8O2b3776DjBNAZfqkVdE7+8ShS7ZZ0uWyvhmNZ+7Ct4dy/Jdg0q4TycUjECRtLIUQi/Q5QZamX6pw6ob8hOnSlFLN8Sq9ZpKS6YwbJ+7jbwrXeHtFCt4y1pNJY4EPrfhOG14o9mi15Wcbm/Glik9p0uhbIQP3e4Vl/uNKRBwbQYTW9S8S6SeKrvurD5c
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9815c9fc-be10-4401-19c8-08da81cb0473
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 10:10:17.9030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBamJLrUf/npWa/3FqgqgCWWa4OzsLzALn3ZF2/qC1V4t/XHXTX3CcczKi8SAGufw1tEN0R8ninnprmgEyahc1V4Vu3rYeSuDeeklV1suRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4113
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] statx04: Remove kernel comments in docparse
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

Hi Petr

On my owner metadata.html, I don't see  commit title(I guess network 
problem)


Tag	Info
linux-git  93bc420ed41d

linux-git 99652ea56a41

linux-git  04a87e347282

linux-git 5f955f26f3d4

linux-git e408e695f5f1

So for me, If remove kernel commit in description, then I only see
useless commit id number, unless I go to search them in kernel org.

I prefer to keep these kernel commit comment.

Best Regards
Yang Xu

> 
> Hi Petr
> 
> Oh, I see commit title in metadata that I don't see it before.
> 
> Tag	   Info
> linux-git 93bc420ed41d ("ext2: support statx syscall")
> 
> linux-git 99652ea56a41 ("ext4: Add statx support")
> 
> linux-git 04a87e347282 ("Btrfs: add statx support")
> 
> linux-git 5f955f26f3d4 ("xfs: report crtime and attribute flags to statx")
> 
> 
> But user that doesn't use metadata(miss this usage or miss dependent
> package ie rubygem-asciidoctor), then they only see some numbers in tag
> but know nothing.
> 
> IMO, it is not clear like min_kever.
> 
> Best Regards
> Yang Xu
>> They are defined in .tags, having in docparse results into poor
>> formating in metadata.{html,pdf}.
>>
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> ---
>> Hi Li,
>>
>> I've done cleanup like this in the past, but sending a patch just to
>> make consensus about it. If we prefer to have git commits like this in
>> the code (i.e. if being in .tags is not enough), they should be in
>> normal comments /* ... */ so that they aren't in docparse.
>>
>> IMHO docparse can mention some commit if wanted to add some description,
>> but just as 5f955f26f3d4 or 5f955f26f3d4 ("xfs: report crtime and
>> attribute flags to statx") if the commit subject is a description
>> itself.
>>
>> http://linux-test-project.github.io/metadata/metadata.stable.html#statx04
>>
>> Kind regards,
>> Petr
>>
>>    testcases/kernel/syscalls/statx/statx04.c | 35 +----------------------
>>    1 file changed, 1 insertion(+), 34 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
>> index 98f9a6315..6c562b3d7 100644
>> --- a/testcases/kernel/syscalls/statx/statx04.c
>> +++ b/testcases/kernel/syscalls/statx/statx04.c
>> @@ -14,41 +14,8 @@
>>     * - STATX_ATTR_NODUMP: File is not a candidate for backup when a backup
>>     *                        program such as dump(8) is run.
>>     *
>> - * xfs filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
>> + * XFS filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
>>     * three other flags.
>> - *
>> - * ext2, ext4, btrfs, xfs and tmpfs support statx syscall since the following commit
>> - *
>> - *  commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
>> - *  Author: yangerkun <yangerkun@huawei.com>
>> - *  Date:   Mon Feb 18 09:07:02 2019 +0800
>> - *
>> - *  ext2: support statx syscall
>> - *
>> - *  commit 99652ea56a4186bc5bf8a3721c5353f41b35ebcb
>> - *  Author: David Howells <dhowells@redhat.com>
>> - *  Date:   Fri Mar 31 18:31:56 2017 +0100
>> - *
>> - *  ext4: Add statx support
>> - *
>> - *  commit 04a87e3472828f769a93655d7c64a27573bdbc2c
>> - *  Author: Yonghong Song <yhs@fb.com>
>> - *  Date:   Fri May 12 15:07:43 2017 -0700
>> - *
>> - *  Btrfs: add statx support
>> - *
>> - *  commit 5f955f26f3d42d04aba65590a32eb70eedb7f37d
>> - *  Author: Darrick J. Wong <darrick.wong@oracle.com>
>> - *  Date:   Fri Mar 31 18:32:03 2017 +0100
>> - *
>> - *  xfs: report crtime and attribute flags to statx
>> - *
>> - *  commit e408e695f5f1f60d784913afc45ff2c387a5aeb8
>> - *  Author: Theodore Ts'o <tytso@mit.edu>
>> - *  Date:   Thu Jul 14 21:59:12 2022 -0400
>> - *
>> - *  mm/shmem: support FS_IOC_[SG]ETFLAGS in tmpfs
>> - *
>>     */
>>    
>>    #define _GNU_SOURCE
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
