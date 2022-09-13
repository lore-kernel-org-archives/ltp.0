Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA808C6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 08:19:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3B0F3CAAF7
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 10:19:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11EFB3C8CC0
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 10:19:41 +0200 (CEST)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B095C6012DF
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 10:19:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1663057179; x=1694593179;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=bHXkISnGcEwKoGSoCzrSJOwaJ7/eXXtxD1RX1IAfTjc=;
 b=tfNokWKj8uzrh4G85UjZIb0A/SvdjFEwq0yZwc5lmyrHOf/GBpKM3eWY
 bujbSwdNxVdUMcUdRoV19CC7tIACbob1F7IoNSUrgU+iYzDDuDdCnTgBL
 EJ2K7vVzMHisZ9S/7yj2/zfSK2NkpJE/DZ53HlXJ/ucpW0xcCcFNcHQUo
 hoVgDTiHasJqbD1gJP1UkaUv0oz+vwlf9u5Pi2ggmu6+aCIldgIkO1VJj
 8VQl8V8fZ0UIvzbuz+cBVhHIu+93ZgEVGavlxRtOOU7BoGZ17dEvZL/6P
 LotrkWdWjTb2ydRPxVOhvHm+JyvU885Vhs8KdiFn/Yr+6FjXgjRVtJ/w2 A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="65141718"
X-IronPort-AV: E=Sophos;i="5.93,312,1654527600"; d="scan'208";a="65141718"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2022 17:19:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhBMxGGOGdV4MJk5EaKG1A8jTTyWO1w8tv2j9NlFStIbT44k3+4/QAVjOT0IsjTIcvnmfXV6wz41/jF4xrGn67eAQ4SYvJlRFO9aGXBr58fCx2Sjv+zg3QsHzWvGSD6IcinbyWjGzOeznd9d2kvqSTZYcG1keFilnBM4nvpR/u4Yd5SR+1tJKgdcOYgRQ4gDRPV9Advip2peLnlm1zoXP3elei9b0qkgLZH57LedAHn/dS19X1wgMfpCDSJFfOvVOEgG8i/t7APARvSJvZvSV4w5xO44EpirClFfHZ9Kce+/2ejAkUbDK+HHc3ev/SeCWzg4+RYKGoogN9CK1l40fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHXkISnGcEwKoGSoCzrSJOwaJ7/eXXtxD1RX1IAfTjc=;
 b=I/Zb7Jhq8PhVBdVW3jbtj6xP2PB34Q1Pc1i9wotNLccTCRiAvM2KPLTWBVGZvHT+VZaltQZEsErFGJJ1c5A0IqJdEb0syFVTr1b8t26Oh0y32PkBipsLSqVIRgflqnScSnGlF13C7Nw3WYgQttKhKV5k4QlxIcffb7bUNOJFYx1KMRYYN0VhUQfCLz0aR5Cil049sXB2ucKSho8g/bDnC+sqpA/luOEU0WK6wNnJZuT8VSlmvqhzrJpuMeHptxC8gdOrSogMrfWIoUXhvcGQ76tB5VBjWBLORC6VEXGDMjgKIjdg970tiGnHp48ZbNRr384VKXn+2D/ouXIC/QkVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB10073.jpnprd01.prod.outlook.com (2603:1096:604:1e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 08:19:32 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 08:19:32 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>, LTP List <ltp@lists.linux.it>
Thread-Topic: [LTP] September LTP release
Thread-Index: AQHYxCjT4JkdvJbfdEu0u1CyPW6e+a3dG8OA
Date: Tue, 13 Sep 2022 08:19:32 +0000
Message-ID: <3880769c-49e0-6158-c480-634632fb3c76@fujitsu.com>
References: <Yxr+EpKTnKQbKXTb@yuki>
In-Reply-To: <Yxr+EpKTnKQbKXTb@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OS3PR01MB10073:EE_
x-ms-office365-filtering-correlation-id: 7a29b1c5-dab7-480e-f5eb-08da9560af99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S8QifI4ZA/3bEitxgA+q/4G1hBEUwSLhkCCkNLDUFyqUo9UlJXuJSuOq8rcY5BH/cXcq8lKuxLO9DGTLIB1jGgudLv7EOeurJ4U8NFU2pCAOUuNCNUmv5xR+ELEPQGoGm9R7u82R7mzIzOlXbvr/vhI5GwugFRPNWoBRYK3omQyuwzxCkY9hYKLd4N+KIGrF6+eNQSLr4S+Q0c+qtn20W4sJuNesDJwQksO4BNWK2xdD3dJr20ajTghA0ruJ9BRw3n61KUgv8hWBB4KuiJo+VpOhZgPmp8MkoJ6mDBGb9wsBPuPKrheJILHGEaS8tZ0nTXuI/sEIA5VK1ApJApXGGkPSIitzV9bUcOWY7nd+mzB2zgZiUJ9JPHk3BhE22zAKm/ILwjMtSGGeruGmY73tQWInnxr56wyj7ifqGKvim/Ev78gv9UWj4B8h6SpE9/8JYkjgUjt3ippsI1xX2K42z9jWzp+xPM9zp+sWCmhbivI7jHRdSJE0peZWuZ/WWu52mYnJBZKHEYBrnXyEcVEvaqczEa7tZQgCj9mvGnQ0jooGopjCtsBQf9u7HJxnAUxu7zEw9s6bJt3xeAoWFW5PZc3Potz2vG3RBz1uzIc3WSUlNdS4wzSGTo2NjjJo1IpxiB11yx+NgjMamG/3iWFK77r5FmMDD9B2rPFPdJbULLgSwL6Eo2Snhob3IP9RSK+/nqyEORLyJ0Vj/ZTZD7GdnqyVGfej/yK6GRAxvBYPWgf0yxzSleLI6yZSmQ+QmWsGZfn/p+Y3VQFRPnJ2i0U3PZDO1zVPdhWbSUv+UOn3gSSgpuCirf+VIUODsimKfh7jNmry9l65ajLnKpcqP2s7PA8ZywJ5lgLD/1MJFMdlhqk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(1590799012)(451199015)(316002)(66556008)(2906002)(1580799009)(26005)(41300700001)(6486002)(66476007)(64756008)(76116006)(31696002)(71200400001)(6506007)(186003)(2616005)(6512007)(86362001)(110136005)(38100700002)(122000001)(8676002)(83380400001)(66446008)(478600001)(8936002)(85182001)(31686004)(36756003)(5660300002)(91956017)(4744005)(38070700005)(82960400001)(66946007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3hDdzVoTFNVUitJYnZHL2lKMkpuYWF2YUF1alRTVldkRDBBRFdWQW1kM1dL?=
 =?utf-8?B?OGoyMHhHNzVZS2ExT1JjUlUxNUx5VkVzdjRyblNiR0RWSzE2aURjNVNlSkhv?=
 =?utf-8?B?bnJsWGg0Q05tS2FWZDZiUm5Pd3FsS0czYUhETW1XbVp6NEtlMTdZVnoyM3p6?=
 =?utf-8?B?bytXekFTSDd5ZS9XRjdIenhadGsrWmFUWHpYcjFRREhMZTVER3phdExXT0FB?=
 =?utf-8?B?ZXcxZGZob0lNNXBtNzRhUW0xRmpUOVk0QjVmNkJXSm0wbVNMa1Y5Qi9ER3Ro?=
 =?utf-8?B?b3pYQW1TVndMU0t3bUhKblZxS3dnaGcxdGMzUFlwUCtWZkRMRDlzL2loZjFG?=
 =?utf-8?B?eVlnMlFWMjc0QXE3cFQ3eEhEcGZ4MVBEMk8vOHhtb2dDNFMrNmtNVFVERk5B?=
 =?utf-8?B?TVpFY2JJT044Y2FreUk0N2c3WTVoSEMwQ3BVR3RVd01KbUxJSE1FU2dhb05a?=
 =?utf-8?B?Z2JIczhkZnU5elhGMytDb0c3Y0RCazVwRy9GZExqMzRDYVlmbk5oSmlIVXBx?=
 =?utf-8?B?Z3ZuYzRLT2NlMjkweHFXekkxdCtoNWhEWUZUM2tZaTdjNmh2dkloc2p4bHpO?=
 =?utf-8?B?YVdjMU91VTFvblVBNDBzdUJHdFR2WlBKaEtaZ015MXB2NnIyYmdoZTZCYTE1?=
 =?utf-8?B?b3BXU1VWakZ5UnNlM0ZwWFluZUVVOVdTV2xhR0Iva0VaelVLdTV3ODBPMHcw?=
 =?utf-8?B?RGhjTkpEZmRldUZseTB4MG1jMW1BTVJ0TFBob04vRGxqSnhENDAwdGNnVmVV?=
 =?utf-8?B?Ykx0bDlENWgwWW41cFJ3OHdueXNvcXZrazIwc0x2eS9rR1FjN1liYXVlNG9U?=
 =?utf-8?B?OGdHQjlLQk10WFJrU2pBOHpIT3BLVUVnTndBUm1HMDJUSU9IaHlhcUhRMkdo?=
 =?utf-8?B?czFFc1lHMWQrMUxuemJnVFg5bW53TVFveXRXMjhvcCs2aDFGN29ib3FNUnJn?=
 =?utf-8?B?SXkrWmxreGJVajh5a2x5OXBXRjR4a3lDQjZKRXl1S1YvNUI4ZXFtYm5kVlN4?=
 =?utf-8?B?M3c1cU8vL2xkaUJEK3pLeEdpS2N0VWhHVFh1TkhyNEc4RjdTN1lVb3ZBall2?=
 =?utf-8?B?WUJLQXcrYmdlQ2haMjlNaW94TW1Kb1BLUXh0NkhtNGN5U3B4YXFPeXpsb0Zk?=
 =?utf-8?B?WnZ2TnNUM0F6MG9BbHVZcW9hL0toWnowa1ovMmVDRld5dnpsOVU2d0ZFYmFP?=
 =?utf-8?B?K0Z4TEFxWSs3by93VEVGUXErdUgvMHZsWGxIMDdWYmcyTHA4VUJLWHJvRUZR?=
 =?utf-8?B?dnVlYnF1bzV3QnUrUll5T2h3dVJteEVaSkpLVmFCcFE1Qm9yYzlra3ExTXRV?=
 =?utf-8?B?OUliZnNnb0lZMzY0dm5DQmFnWlFOQi9IRjM1NHhLci9FZHlYd2xjWVFUdCto?=
 =?utf-8?B?Mml4Y1I4WGd0OTNPN0ZCU0tmcWFvbHV2ZlBmZEwyYzRmSWRqT21HTUVoNDNa?=
 =?utf-8?B?UzRKUUNXZXdaNTBOUFpqWmEyQ2RyaTc5RVdQeHlSdzJvZ28rNmgzUEM4K2Nn?=
 =?utf-8?B?Z0FQMWJOKzJqOU40cTJNSUNobXVLWEtsbkdZbU1nVlcvbGNRWGJKaHM5TXZu?=
 =?utf-8?B?TnNaTXo1Z3MzR2szSU0rZk5yakhkSXp4aGZpUXZCeDNtYU1kcExYUStzRGZo?=
 =?utf-8?B?anlnbDJhaDlRNUhkZ1A0c2lwVzl4V3AwaG5uT09CREdYeVMyRDFJMHlFWGR4?=
 =?utf-8?B?RkZnbURwVWR4V0Q2OHJjTzk3VENWOFFwYU9yeWN1ZllyTjBXUTVibHV2eitq?=
 =?utf-8?B?RHkvemljZlR2WVJhWUhLSUVydVo3UWdlaVNpT1BxV3p4MVBTU0J4aS9tT2ND?=
 =?utf-8?B?NlQ1Z2dqci9jYUdFZDdpcktTUUNmbWpRa0FKc1BxRHg1Mkw0SVFNRkRUQktQ?=
 =?utf-8?B?MWpVb0lEMEp5ZU5LTWJVY1d4VkxyMEVpT3ZuR3doOW1mR3p0Q3FWc3ZMZmhr?=
 =?utf-8?B?T0Z4YTZBWlUxUWhoNXUzK3htY3dSMGhIQ21uUDBLWjBHZjFzdzBaR0c0TDFj?=
 =?utf-8?B?OEJHR2RnQmJ5VzV3em5xM1JSVzZ1YW9TYWtEZklZYjZvdzRudStsb2cweE9K?=
 =?utf-8?B?b0RBVGFRUDFzTEhWSGNjaFhVRUtvbmpIdHdSZm5NdzY1b0o3RCtyL2ZJeTBC?=
 =?utf-8?B?M1d3OE82R3Z2QUxhSWxBZkJyUmo2VTBvUGQyL1d1SWkrUG9DMG5hNTBXeld4?=
 =?utf-8?B?R1E9PQ==?=
Content-ID: <F8D15823C5B79F499EB55687A8B1E009@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a29b1c5-dab7-480e-f5eb-08da9560af99
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 08:19:32.1848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ArVD07NDAp2cj2Bv2BiMmVYFRCdkZw1z4wBjmFJ992GzuJ+ELe8tBEBo6wb3i2afj/pwPRsMeqyBUyl8ykcxjVulCXcxOt6jDZ1tx7hldSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10073
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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
> It's time to start working on LTP September relelase.
> 
> First of all I'm thinking of increasing the bus factor for LTP so if
> there is anyone who wants to drive the release process instead of me
> please sign up ASAP. I will of course review patches and help with the
> release, but it would nice if someone else tried to do all the little
> things for release as sending emails, deciding what should go to release
> after freeze, preparing release notes, uploading tarballs on github,
> etc.
> 
> And in order not to delay things further, please start pointing out
> patches that should go in before the release. I guess Martin runtime
> fixes should go in. Anything else?

How about merging the setgid fixes part[1]? Also include PR_SET_TSC part[2].

[1]https://patchwork.ozlabs.org/project/ltp/list/?series=313791
[2]https://patchwork.ozlabs.org/project/ltp/patch/1657106160-2126-1-git-send-email-xuyang2018.jy@fujitsu.com/

Best Regards
Yang Xu
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
