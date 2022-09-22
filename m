Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E421C6FA82
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 09:07:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1595D3CAD4A
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 11:07:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB8273C91A6
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 11:07:02 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A562910011B9
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 11:06:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1663837620; x=1695373620;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qxTSGAn/MshYYx+acX/jsDl2zDtjnCI4KM6Zde8uL6Q=;
 b=flmw++fDeVfVPErA+NH7VSvWhoNXTeviLSLKYK6i7OAt3MNE6sViBZ1m
 FjH0P+z0DpG2rldbL6GCemAT2iP2E9B0KWN1qbuncCEeDxawnincGtxzF
 T7OtzT9bsbr6YqObmxK5HPxJD0CbzBbCdRXP49slSU02m3NXcU8d6Ei7k
 hxr/5sV5P0dSnuWFGiPTWFWfnKNFDHyBiXDv2N8cqi9wTh0lGN4swBSLO
 X4bBy0yEfIVgqzjL2pHB0BVVO+zA/Q+c1u7SoGSjkcl8xtFXF/AyY8N5x
 NFF6qRpZjUBlO+OrUk3H77KoHKUTYnlKeoQkJ+th2H7/bBfHZT7XRJr7T A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="65952813"
X-IronPort-AV: E=Sophos;i="5.93,335,1654527600"; d="scan'208";a="65952813"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2022 18:06:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS8d3c5b8EKP8wg0aBevw0v3HOYZMFZs1aqMv5lqM8CXj3c9GejjtOVycsUDWwd7H4DUFEZDZtc3FRRBC55bqVqf+StBf3ZKDoStMqj/neA1kS8ClS57LR0dImbjYKE7GtndRW588cHrqNXzG7Ol8qCN4bujCiH+cz4KvS2EolwDa2XXeKHOoIKoyHwo6Mn7G0NNztZMzBGcyOja5Oqgi+xVK8ymrYK2aVNcVR4hmuzyLQB/ReVAnpIaondNAbORGmiceBZzsHySFkRGYguv47fXwEcwxXxpy5dAr8SwvUkkXHUd1mYSqpmsP5KqnrOOduaaFT38EnuAKTh2nmkdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxTSGAn/MshYYx+acX/jsDl2zDtjnCI4KM6Zde8uL6Q=;
 b=asl0scKzdupG2/zhZJjNvqw7mELJxp6c3Sr7IJ+6Dvq/SZKMMiy8m7W26mhX+Ds95KXKE4SOYq1LfTMT7NbzgkiW0oT6Lht1RfOJC4nlXlLqH9EQaScO/u/szuitekXO2cKMYoE2I360M5K892b1G7FNNlyVR7zbaDy52kW9FS514B7w54OaEOyMhvQ+KmlFNU1vYp+kH4mvetlBr9P/nY1X1nf+3MQkGzP6u7ROr+xJ5IqK9ngWKBmiGxPZ5jc1xeqT13zNru1F42PZ9Dl46UyB5VJlRNsqR85L5d4Yx6/og+UG2iV6B7CqV8RMeH5cgPcZzdDf/4P1vPT9aPpHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB8041.jpnprd01.prod.outlook.com (2603:1096:604:1be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 09:06:54 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 09:06:54 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH v4 3/3] syscalls/openat: Add new regression test when
 using open(O_TMPFILE) under umask
Thread-Index: AQHYyAlViPga5eQsB0uSM8Tbg4syU63rMVSAgAAUR/A=
Date: Thu, 22 Sep 2022 09:06:54 +0000
Message-ID: <TY2PR01MB442734C41B2B574CF05B8AE1FD4E9@TY2PR01MB4427.jpnprd01.prod.outlook.com>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1663143142-2283-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YywiZckfyJIk1/Pf@yuki>
In-Reply-To: <YywiZckfyJIk1/Pf@yuki>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NzM5ZTVkM2UtYmJlOC00ODk2LTg5ZGMtOWFlODZlZTZj?=
 =?utf-8?B?NmI0O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wOS0yMlQxMDowNToyN1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OS3PR01MB8041:EE_
x-ms-office365-filtering-correlation-id: b39b012a-b512-4b18-dee4-08da9c79cb60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vO7tSRF/DqW1HIm14HgpV4KmxTeW33wg/IwiAtx+y34hNTcRKlVUTnaktSli0oqn7vav4Gwsv9O6bNtU1zef+sNqMS8+JTa7Bn8oIFdIq3Q9NMGi+iOO8BW3lY1caD30mjcVzszzFsqFCoZSuKfLqLVbJFzJiEfFMuX6hYXQExTwrQfNEcSkI7TflkSNhwnl+692ZL3aywnRu3C7dP/UgvEh73/uVMjz4HXkO4lAdnnhV6ypchwUYZn6P3pd5yfFzsO9pe6hbDNQHUu2+nFkfKR/WMDgSfx6AlWbx3qFpOmw5TVFetNYrhtM1FO06nE60+jcdqf5VrCyHeZJ/co1hIM1PbKuGaSNU/cJwNrSgn5wH9uFQAmrXfJk4LT4P/NbFBFX4Ps44LKxHQ2p7Ss0xu8P8zxIxavq8fjYEpVo4XIw1li75I0z+TBCI4bGWtP48peVJZwlX/aapz5xmrIWAKaAgxocJoGPTEiyD3jRdr/E11azQIzlwWdt5tQeJ+MBdLfmFVPvna/UkX0UzJ6zlVh0Tn01g7nhgDMsR442OF6U37dWDRNZ739b5RP7uvPN+M5m6OvUdLJa54rkZyZl6YjSPMhPnRIQ+2CYdScQED8/Z8VdNRx4/Abe4S9BQvy+xSINl0kTVJj+IKqlp3NNPb0ts77/OZ9s3kFbCwsnxVMzwhGSVWIRfuCdc+Mtz3iSsFvEscEdxu02tbxtaPUUGwexFGfA+wQeMTb5i4T2mIET9xDjKNCHb9AEk6zOlUa6w3SPBXAixiQoefpkmo1oa77il9OZNMb+bLQxZW/nA3U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(1590799012)(451199015)(9686003)(26005)(4326008)(6916009)(54906003)(52536014)(186003)(71200400001)(316002)(2906002)(7696005)(478600001)(85182001)(8676002)(64756008)(66946007)(66476007)(66446008)(76116006)(66556008)(41300700001)(38070700005)(86362001)(6506007)(55016003)(33656002)(1580799009)(4744005)(38100700002)(122000001)(5660300002)(8936002)(82960400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1NISDdUU0dEOE5yTnV6NU4xQ2FUSXFVS1ZMSkoyVXlLUlBseEFVZnFYQlZX?=
 =?utf-8?B?N29hVStvYXdYSUE1SkVURnNQVzFKSVhGcjhPNy9SSW5uTlRBYnhqQXJSb3lV?=
 =?utf-8?B?Q0xPeVNxTmV0V1lkZWRNU2FEWEI1OXVnU3VMTm9oUlF1dUY0RVo1bDFZY0dD?=
 =?utf-8?B?MndzYnVKditnZ3FFT0luTEcyUzJ0NmpsL201RVNnZ3hhcEQzMlJ5ZkY4M0xw?=
 =?utf-8?B?ZWZXM3lXNWk4OFhuOFhCRjFkNy9Jb2hXNk1sOWdSZVBkYUJSODhiSVZ2ZmV2?=
 =?utf-8?B?bExheG9RVzlPUkJQQTBsRDNEZTV6b1FBczBZNXVRbEF0RjVGV2hjTWV3SmFX?=
 =?utf-8?B?MEVBc1JkSGpTVlRPVG1VMlZCaldWckhRSStyZjhGdWJha1puRmFab0ZHTEJI?=
 =?utf-8?B?OVdIRDZpUjNzQ2RiRkl1RjF3d2dzUkgzYXR6ZVRsNUlSazJ5UDl3U1J1eDNn?=
 =?utf-8?B?L1FpRms0VWEvcTgvNlVGK1ZjKy9nWmJUUTZBTE9OenYxMEYzVmFWazFPRDZz?=
 =?utf-8?B?N3VzY0dQczNLUlAwdy9lUXY1Q1hDVDh3bWRTN20xZGx1d2pSN3lPOU1wdkFt?=
 =?utf-8?B?WFIzZUVJOCt3UTdqY3p2TC9iRUNGWVA4RzNqVGljYTkzQ0RkY1hCN1MzTGdo?=
 =?utf-8?B?R2FXcHFaSTQ4YVFtcjJmdG1BYzU3Z09PQStDMVVMYStFRS9SZ0krSWZncVpR?=
 =?utf-8?B?dGF5SXc3NzZWY09obURYcXM5bTc1Z0gvWTlQblYxR2FSUU8wb1B6WllLdmky?=
 =?utf-8?B?eUlDMGVQWGlEMFZsSmFVMHBFSldpT0ZJY2xkbWwyeXIvTTVTUzVaaHJSQ3Vq?=
 =?utf-8?B?d3RjeGxFVURjZnBPU1dEQjhkUnFDUktCb1VTKzBrZjMrNjl0MGlBakM2RUJz?=
 =?utf-8?B?K0lkbTh3NTdtTWtlcVlWUWdkY0p0amZxWFJZR0VMeFFybHBCdStsMFBsMjA2?=
 =?utf-8?B?c05tMWxwOEJNVzdQMGk4WEJDeFJXTG9UV1Q1emNJdkg1YVhIWDRKN3dVMGhQ?=
 =?utf-8?B?NzFSaHQxWm9Ya2dqTXo1amtvWUhaTWQ0MlBXQnhQVjhhK085WXBQalRxM1Aw?=
 =?utf-8?B?VkQyMGtqcXNFT3kxYUgwSC9QdG9mVXZlV1NsMXo1UGJFT3Y0MnJhbEF0M215?=
 =?utf-8?B?eStFcnFRZXIyR1FJSkd0dXJxL3Y2R01XRUYvaU5yWWFHRmpCbVBGdzVUd2c0?=
 =?utf-8?B?Z0NNZ2h2K01WRE5YK042NjJVTUY1Sm1HdW9abno4ZXIxK3YvWjNDTXdUcUZv?=
 =?utf-8?B?KzZVRzZXandjUjBDbTNVRzVnL28yYjdpekphWGR1Y215QTkvb2FMWWtEZk9B?=
 =?utf-8?B?aGlCNjNaNDd1WHUrRG9ua2JXRHJQS0RSYXV5OEIwOXA2NnJseTFGUlFuT3NI?=
 =?utf-8?B?TE1UckN0RUx2a0lSRURrVmlpblFMRCtQNW4zQ2oza0ZXWlBjU2x0NkVoUGNZ?=
 =?utf-8?B?ZVFxMi96MEY0VXpmN1RNNENTM2dHNHRTMmJCMjR5bzFucGpEM0xROGJmRzdm?=
 =?utf-8?B?S0N4azBZKytiRTVJRXZ6M3EyR2hEUzJ5N1prWVlhUE9ndmRPbnFKYnVkRGV6?=
 =?utf-8?B?NTh3NnpJNXFkN1dLeXRJYVZySCtGV25mdkV0TWdha2tDWUZiOEljQjc0QzZM?=
 =?utf-8?B?dUFvV04zMGYvbUNNajRoWGdUU0tIVER2SmhFT0UvZVpvWjczWGR0T0xUeU5V?=
 =?utf-8?B?Q0dDbDMzZjVDcGtBMkN3THZ1RFJqZndUbjA3YlUzMGxiaE1VQko1R1ZySm5m?=
 =?utf-8?B?UTh1YzVZdXpmcGF0d3VVdjhuanJVOTlhMWVWeThkeFF0WlZPNkk5enU5Qngy?=
 =?utf-8?B?UWFTK0pVVjJPb3JDYjdpdlZMZ2hTZTF1dVRpdXBYZmJlVFFtWkJLc0E2cVpj?=
 =?utf-8?B?NlE5TjhOTENBZStiamxaTy8yWURKdVVTT3pnZVpTVWliMXhXQmMxaEVQOFE3?=
 =?utf-8?B?cEdwZU81ejEvRlZ3WkdXN0RZcjc2dGF5M2NZVjdlM0NHUzA3N0FaVmtIVy82?=
 =?utf-8?B?RkFDeVZGRytxOWIzaWpZYlRscHdYOGw1M2hyM3BQNkVHQkVuUkpYNDltU0Fu?=
 =?utf-8?B?TytETG9DK0lKenRVTHVNOTVCcWtoTlh1cjYrcHY2Q2pJWDk5WWZHeWhkdEVw?=
 =?utf-8?B?WEVnMGhrNzMvQVNTWGlIeUFtTHZKL2c0YnZncXR3NlZqTi8xQ2ZZZk9xVHZr?=
 =?utf-8?B?T1E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39b012a-b512-4b18-dee4-08da9c79cb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 09:06:54.2977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5uvSPi7AjTlWPhN83weoAuj9ddGJQXj/drNeZFncnzUDemuPVmY6Cz9lcxKkPNlDJyDdi0ALeuUed0rerTDMoxI2yGTB5sMhmnzdO3ANE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8041
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/3] syscalls/openat: Add new regression test
 when using open(O_TMPFILE) under umask
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
Cc: "brauner@kernel.org" <brauner@kernel.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril

>Hi!
> And this one is probably missing some kernel commit tags too, since the only that that is attached is supposedly in 5.19 but the test still fails.

> I supposed that we should add the 426b4ca2d6a5 to the test tags here as well, right?

Yes, BTW,  I usually use git tag --contains command, so I know this kernel fix is belong to 6.0.

git tag --contains ac6800e27
v6.0-rc1
v6.0-rc2

Best  Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
