Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4103C4332F
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 01:57:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13FA33CCA29
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 02:57:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3F5E3CCA04
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 02:57:21 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 79CE32003B1
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 02:57:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1669255040; x=1700791040;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+bP4XsrePiqw+WwJYzcJDPS0R7V81o2KKRe+OoD01Jw=;
 b=EqSN8H8iip5RA4aDIuE0hYMkvuPl0RP0owdc4rcG9kMIMP/jHyJ0hveH
 U3b+jGjbxfDe8rv+D3ouEDe7Z3dq/iZNClq0OwmBqQfKxD2sBnL+h3UIF
 MA6hmmbgjZMhE56ElXohEll3Bvkr4YbWr/vcCj8Lr3U96xDPG6gH/tJSh
 xFdj83q5oWWU4uIxCmg2DehGvhMXtdqUzfhNmRC277XNOOalkHDhY6ZFX
 0wD+c1gDxz9xKiFx3I858BuAMGCHsh55/TcCcDVyqsAjRWIkvWvdx8ya1
 VW7Poq2R2ytrVwcf85eLnruJxaS3KzsddGPc/mOzg1UKyF1g9EmUTk2oy Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="72672289"
X-IronPort-AV: E=Sophos;i="5.96,189,1665414000"; d="scan'208";a="72672289"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2022 10:57:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgO8XXBZWUPc93rJLnlMbfpRWp57USqXp6WxhsUm/RxGlmKCRPqvJlpS5j7IrmXsFXiDgTF52J6O0jAuMBahR7xGYHKYodNw+RDdCjUOiXCE5gxZ8PW1gVdQNTliwv+XgKu5GRZO/AmgUYDW7Lgfkb42Ywx+t/aEIZWJ+9g+cUB0LqyF8qwaqNoKBoplOnZzQ1WFLEcePhF5hWOVXmuxC09RJNJKTF8t8pyFst1/b33GqGqDBTD50pUjgzrs4l3rbbwM+/+K/3wDlrD5KFKnPQj701IkS+SpSK0R1yaQmrnELhCAchoublRRCLE/AlmUuOh/Lr22zxzHdvlO2qLGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bP4XsrePiqw+WwJYzcJDPS0R7V81o2KKRe+OoD01Jw=;
 b=CBMZAjaeIH/sKehCjWpK3p/hWzzCiYdhAyOt2+0lGd7/axa0XclrfkDaJ3bEcqVvpPyuJXkJBApie13t3WaFHSSSnZ0tOD8TL0EjctKFKwVbSY59IzmLr2aLEr4Dv3Evgzm/CpWoplQ2Rt20mhW6FetIcbXr5iy+flO3dNzgraqzS/T4y6C2xmh8WNU87zAqwNhZBaSEN7dh122u/2O4ixmIqB7qfitCM5+/i1kZ4SuesBaNuUCAclYpNPMwDbUlg1XBqRlMgA2s1Hh2rxuUSP+4vzWUhtqmlI2+F569E0WE5J/MI1YdJSx1ddsuyUOFneLvdxI2OX+mNjxCgnfSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYWPR01MB8824.jpnprd01.prod.outlook.com (2603:1096:400:16e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 01:57:12 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5%6]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 01:57:12 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [RFC PATCH 1/1] Remove fs-bench
Thread-Index: AQHY/zK3gNh5wOCg7EWziajQQGFoL65NYs6A
Date: Thu, 24 Nov 2022 01:57:12 +0000
Message-ID: <1e7586a2-db5d-52c8-b250-376d2ba8eed3@fujitsu.com>
References: <20221123115546.786-1-pvorel@suse.cz>
In-Reply-To: <20221123115546.786-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYWPR01MB8824:EE_
x-ms-office365-filtering-correlation-id: 2d234348-dc2e-498f-e03d-08dacdbf3436
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oUISgfzHBNTnD9QLTsJ7OWsodYzSMoy8HgENsuHSn62veIK8CdWtpXCDi/ZuOSORNZfyHhHRGelxUpavvr1IuT70WmPCBZH+JiLdOUPsKxOFRexEef42BOWzZfWX9mjQCKcKEVYEhUad2nqBQ64L0ar3iTS1KeDJj1y0M/yRKcigiEXGM9VfugA0ojumJF2IEPLCbsnHngccVF4hIUwdZNolWHh14s5xfi5V7e78rL+qIthqhiYO/P2ICeQg5pdGvW66Rx/NdJsi+ObNAGUtZfUIRWo54HeRmwO5Mm0Ms2eNLEc8g8jKrNgxxawfYGt7VVuCWjOzBTBXlEnejmP3PQp/zzceoTXL+UTejrLLjfkdMxgRNUG7z1nw+onkAit+pHA8tiNYGTdNcA4os6Bpdgf68OOjRExQUeFj23eoZucRNG2SsRJWLo4yKnHvjcl71aC1orIMJba7KYgRF/9FskUTFwZG1crshObWy/zjYT+lYG25c17L6jyHEkUrrtt398p6Egt7Zf/pZViY03vK0ENpgUDtHu6iUcnhVUsC3APzN2WkuGXW3Dbvwiv5XJ0HBs4mLrvrmr7X4FwWD7MhbejS+vXWBWCUR3xLcVb00victJKu/MnOSSQBb+MamG5NqAbnHWMuGDtsAvRy6HmsFo+mC+TLEmnFFKtRDas26739h+K4/6D7zXRcycTM7IEnlG0Jzf2zHRtjdfOX9NNRlhyQ7nqWOD87XhyvFUMw/e96wSnHTWizgFYY+r2Z9/SRGNn45WfwMbqQManBSg8w09M2J++0Dr2kEytVpbFYBd4IXMOCWEmChF1UraZSMJz0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(1590799012)(451199015)(478600001)(8936002)(110136005)(5660300002)(54906003)(38100700002)(41300700001)(36756003)(85182001)(71200400001)(966005)(6486002)(83380400001)(2616005)(66946007)(86362001)(66556008)(82960400001)(91956017)(31696002)(4326008)(8676002)(76116006)(64756008)(66446008)(66476007)(6506007)(2906002)(31686004)(122000001)(26005)(6512007)(30864003)(186003)(38070700005)(1580799009)(316002)(2004002)(45980500001)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R05TNDRVRVpISzhQNU9tSFBYdzU1dit6UGNlaEJ2THVhQ2FaRXhRTVREblN3?=
 =?utf-8?B?UStKcVRqMnhJMW5rWHVDS1hheVdpcVBrSHNrRXRrV2FZV29rWjdNdDBjTmpu?=
 =?utf-8?B?bFhkV25Sa2tsZnZXOE82dmJQSVhrNmlzV1VWME1EaU5VMVpKWjFtSmxTTUpH?=
 =?utf-8?B?OXY5ZDJEdFdnSlZNajMraFh3MVVZVVB0Qk02Nk1TdTA3am9rWFEvL3FscG9o?=
 =?utf-8?B?bEJ6Vy8zRUZzemVDbVF6UVZzckV5WTFOVkhnWHE4UE9EaGoxMVAwQ09sNDBF?=
 =?utf-8?B?L21icGFyZHF1TUtYVE40OVY2YnZ2RUI5Mm5mVklKSmJMdlZIQ0xNSmZnZGMr?=
 =?utf-8?B?NDdpTE1BSHZiZ2VNMGV2YmdST0xTT1EzVXRVeWNiczNvdmw4M1hzOVc0OG1W?=
 =?utf-8?B?anlPNWtiV1dLTFpBVklEYTNpaGQraGVJb2U3OEtqTk9NQjhkeEI0M3ZwSjF1?=
 =?utf-8?B?REFJSVcza3ZFSnJmb2N2SThQaW5hbnRrT0FqZEJrRDB1a016aVU3YVJUOFdI?=
 =?utf-8?B?cHJQOS9zUW1FaHNjbWU0ODhEdUd3aS8xYnl2anZhMVBWRHJrVHB3Z25rcGhL?=
 =?utf-8?B?dnFrdm9yUzN5RFlJckI4dmRTNzVCSXdQK2k2SEp0VGlGS3hSbGtuVUJzU3Z1?=
 =?utf-8?B?cWhsWGwvaVhmUHdaZVo3T3R4SEExdUg3M3IrZEx2d1V0NTJOU3NMWCttSFly?=
 =?utf-8?B?N055QTNuMVkvNVhwVmE1Y01JeTZJVldTVDhUL1AvK1lKYzl1WVh3NDZRZUky?=
 =?utf-8?B?V3Flc0o0S2VxSm1vd2JmWmFqbDZrVjZMMmMxU2JlL29ySUZiZVBjcitJVWw3?=
 =?utf-8?B?djFTazFyR3VYcUtESnRVQlB2Y2xlNlFRTG9jcW1UcnN3THkzT2lPS1hpa1Fa?=
 =?utf-8?B?cGdqbWNLQVVlTkJWSnlxNks5blQrLzNkRGpadTRVWlRkYXdtMktGK1ZMUmxF?=
 =?utf-8?B?Y0VVaG53UXNGSlpmYkwvOHNNYkdkYlZ5UjYwVTVHWUJRQjFuYzQ5N09ZK1VE?=
 =?utf-8?B?Q3J6L0FBakc5L0VsNWRBZG5KM0s1Q0F4ZlBvS0RkME9XeGV1ZGZLbkxtalEv?=
 =?utf-8?B?SEZ2ZDhaaERjT2JvN04xNnU4VTIzUEJtaXBpWkVHUlZOUTF4ell2YVh3WnY1?=
 =?utf-8?B?QXErL2hNaGdXLzdNMmNmdEkzTzB2OTBtTjJubUVQMEZFeHhUMXNVVjkyUC9Z?=
 =?utf-8?B?V1BRbGZIYmtBV2I3RHQ3dkJGWS9hTUg2SjFGK3pHaXp4S0xxU01tWTR2NTVv?=
 =?utf-8?B?bmo2RzVneFhyVlhHd3dkbTRDc1ZRb00zZXdYS2RWMHhuUnd4cjFIK1VpTXFT?=
 =?utf-8?B?MmpLSXpOR29JK3FLODZmeTVNRFdPQ1lsM09SdmMwc2RKN3NoS0dXVHhyN2Zo?=
 =?utf-8?B?QUdZbUQ3Wk9ZcmtJS3F1RjV6ams5cXlyczNrVjRKaEtJeWZZbVpPRkh5dnVV?=
 =?utf-8?B?Z29wTS9VOWRuc0J2L2w5UDJyYnMvdTltdFRzd2JhVTZrdmh4N0xzaXJZWWdk?=
 =?utf-8?B?a3ZnU1hSMVkyVWFDZTNnMzVaM1lDcUNHdGtGQmJWMmR4eFhkODRHNWQwV1Za?=
 =?utf-8?B?akdVOEwyNGpCbWdxZ3FZZXdjOWw3Z05QaTd6Rlo2NFFrcmdYY1lQcXVRRkxY?=
 =?utf-8?B?cnJPTmxlMFg4Rm5nOGVQRnRzaVd5SUpKVFpBYjJoMzg5clgvb1UxSE5xZnhs?=
 =?utf-8?B?ZkdvenhLb3doL1ZXeDdVdmxNNjJ0OS9YVHFDc3U4bDA3cXlCRTBEUWVIdXdH?=
 =?utf-8?B?Y2VPYXVqU0tVbHhIeHFGZWRtYSsvdXp0Qk9YaDBzR0hXTmVKUzlPZ2FCWHRP?=
 =?utf-8?B?cE1xT0tySUxHVFpMMmdhZ3dSdTU0RForSlAxL3hNbjVOSzlOanR3ZnRPWmRB?=
 =?utf-8?B?WjNDVER1VFl6OGFyNnVGcVk0UnJ5RHJzbjg1MzQ4UU5NdVluNEJtbDJnR0o3?=
 =?utf-8?B?UElJcysySVdyWXBZdjhzVmxQRUtBS1JIc2VtcWNqWVljT1o3OG1EeXc0SUtC?=
 =?utf-8?B?UnQ4MTlQdUo3RjVOc0p3ajdNdENYdUF6cm1VZVVNVktHWUZGUlpQUWQxemFx?=
 =?utf-8?B?SlQwT0tFTjlBQzlpTytNYUhLVm9sL0hidmh1cVRWMGJXcXprMjVFVWxFVjRJ?=
 =?utf-8?B?RHlRRkxJNWpwUStKai81c2s4K01PSlpSN1AvT2xDKzZES1VSS2U1L093WS9Y?=
 =?utf-8?B?M1E9PQ==?=
Content-ID: <6E2C65386B91CE47AB47A1EFCD6C3FC1@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /CX95nhCAc+A3JpfXXyM7M0uSJdd8LHUkaYwReIie63b5B4cthtDFaiql7QIjTSdem1vh4x/eayLtZjtHYuM4isqFzHuOQOtSc3vs0bWze+aB8T1SaO4XPDDTs+cO0NjIGI1NIj/pEhBeAkEeEJQEFBZlSK0MaQKj4YZBgL+WJgJELa4/Rzgbp/kcM6p0aUa64BMeNmNZrYTUgNCXVz1N+VP6WGwneKJeU/oet5XNI0EZPovYzrvvvB6+dTKOtc5LUjtEVdHsF77eGu8weLDs4vkhz99/7kNeOjIUeqYC5ahXw3kq+PtcKD99GTK6AWiN8nfhHPluzSwoplD8Zx6UXeUslu5q3xr1faoehPByrvk2CzbesFusEHMIc3GLKdk8VNnOHBXasNDA6KCmu1IJH36/O8+tSi70gHGxzHXl599wnIJVeV8Zaow7tnEeYVee5dhPkk8y2Qksdq/x0iVsa4QCbRabxBK49gsntQgsoXrvMocF4xj2i1+Tvw9rY7Rq7V4VN6Vu4AlU5+LRc//5fz4+sA0SZXc/i36R4WeDsmPZnLL7wdSYhwUoajA+140B85BFAhES823xBze1DA8fHUapPIvnpMhghChK7wdUeXxtHr3PSzY1sVhYWlo5vQ45PpS76ITGYzxYZUvpLJtYhLzMkC0yZ9W3ENo7Bs82mg/Lg9xV0ngzQVkoyZ+hmWtgmvv/HH1HSuX6X2VOJUHNmEoWBVG0wEeKPlwYZfR73WLI7wo6Rx9/xy8O6uffArvpF8a0u1fnM0Z8rTDosUZMMVJwBDqXRYMKhm6kSmHYTf0SRNOiaD8pCO/sA8mzTiQAAlusLq4Er5mzjKVXOtVRw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d234348-dc2e-498f-e03d-08dacdbf3436
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 01:57:12.4009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzfnjqLmbxryUmytpqPmfCigmX7CIFcPf2qgvvJ6Nb0hYGQhmAFbZ14t3IuHUJ/hiVhjK6wSEsWXVSErh5NfAWwKvfl/boFSop46urX3NYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8824
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] Remove fs-bench
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

> fs-bench is horribly broken and there does not seem to be a lot of value
> in keeping it.

I never use it, so
Acked-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
> 
> Closes: https://github.com/linux-test-project/ltp/issues/994
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/kernel/fs/fs-bench/.gitignore       |   3 -
>   testcases/kernel/fs/fs-bench/Makefile         |  41 ------
>   testcases/kernel/fs/fs-bench/README           |  45 ------
>   testcases/kernel/fs/fs-bench/boxmuler.c       |  28 ----
>   testcases/kernel/fs/fs-bench/create-files.c   | 119 ---------------
>   testcases/kernel/fs/fs-bench/fs-bench-test.sh |  50 -------
>   .../kernel/fs/fs-bench/fs-bench-test2.sh      |  63 --------
>   testcases/kernel/fs/fs-bench/modaltr.sh       | 124 ----------------
>   .../fs/fs-bench/random-access-del-create.c    | 136 ------------------
>   testcases/kernel/fs/fs-bench/random-access.c  |  92 ------------
>   .../kernel/fs/fs-bench/random-del-create.c    | 134 -----------------
>   11 files changed, 835 deletions(-)
>   delete mode 100644 testcases/kernel/fs/fs-bench/.gitignore
>   delete mode 100644 testcases/kernel/fs/fs-bench/Makefile
>   delete mode 100644 testcases/kernel/fs/fs-bench/README
>   delete mode 100644 testcases/kernel/fs/fs-bench/boxmuler.c
>   delete mode 100644 testcases/kernel/fs/fs-bench/create-files.c
>   delete mode 100755 testcases/kernel/fs/fs-bench/fs-bench-test.sh
>   delete mode 100755 testcases/kernel/fs/fs-bench/fs-bench-test2.sh
>   delete mode 100755 testcases/kernel/fs/fs-bench/modaltr.sh
>   delete mode 100644 testcases/kernel/fs/fs-bench/random-access-del-create.c
>   delete mode 100644 testcases/kernel/fs/fs-bench/random-access.c
>   delete mode 100644 testcases/kernel/fs/fs-bench/random-del-create.c
> 
> diff --git a/testcases/kernel/fs/fs-bench/.gitignore b/testcases/kernel/fs/fs-bench/.gitignore
> deleted file mode 100644
> index 5824a4002..000000000
> --- a/testcases/kernel/fs/fs-bench/.gitignore
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -/create-files
> -/random-access
> -/random-access-del-create
> diff --git a/testcases/kernel/fs/fs-bench/Makefile b/testcases/kernel/fs/fs-bench/Makefile
> deleted file mode 100644
> index bc570f7eb..000000000
> --- a/testcases/kernel/fs/fs-bench/Makefile
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -#
> -#    kernel/fs/fs-bench testcases Makefile.
> -#
> -#    Copyright (C) 2009, Cisco Systems Inc.
> -#
> -#    This program is free software; you can redistribute it and/or modify
> -#    it under the terms of the GNU General Public License as published by
> -#    the Free Software Foundation; either version 2 of the License, or
> -#    (at your option) any later version.
> -#
> -#    This program is distributed in the hope that it will be useful,
> -#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#    GNU General Public License for more details.
> -#
> -#    You should have received a copy of the GNU General Public License along
> -#    with this program; if not, write to the Free Software Foundation, Inc.,
> -#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> -#
> -# Ngie Cooper, July 2009
> -#
> -
> -top_srcdir			?= ../../../..
> -
> -include $(top_srcdir)/include/mk/env_pre.mk
> -
> -INSTALL_TARGETS			:= modaltr.sh fs-bench-test.sh fs-bench-test2.sh
> -
> -LDLIBS				+= -lm
> -
> -create-files: boxmuler.o create-files.o
> -
> -random-access-del-create: boxmuler.o random-access-del-create.o
> -
> -MAKE_TARGETS			:= create-files random-access\
> -				   random-access-del-create
> -
> -dist: clean
> -	(cd $(abs_srcdir); tar zcvf fs-bench.tar.gz $(abs_srcdir))
> -
> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/fs/fs-bench/README b/testcases/kernel/fs/fs-bench/README
> deleted file mode 100644
> index 20d49a951..000000000
> --- a/testcases/kernel/fs/fs-bench/README
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -Programs for File system stress test.
> -
> -All of programs are distributed under GPL 2 license
> -by Hironobu SUZUKI <hironobu@h2np.net>
> -
> -HOW TO TEST
> -------------
> -
> -1: Type "make"
> -
> -	# cd
> -	# tar zxvf fs-bench.tar.gz
> -	# cd fs-bench
> -	# make
> -
> -2: Change directory to terget file system and do-it!
> -	(I always use one-HDD/one-partition for fs stress test.)
> -
> -	# mount -t jfs /dev/hdc1 /jfs
> -	# cd /jfs
> -	# ~/fs-bench/test.sh 2>&1 | tee ~/fs-bench/jfs-test
> -
> -
> -NOTE
> ------
> -
> -The size of files that are created for stress test is not fixed.  The
> -file size are determined by probabilistic algorithm, box-muler
> -algorithm.
> -
> -number
> -of files
> -  ^
> -  |       ****
> -  |      *    *
> -  |     *      *
> -  |    *        *
> -  |  **          **
> -  |**              **
> -  +-------------------> file size
> -  min               max
> -
> -
> -------
> -$Id: README,v 1.1 2004/11/18 20:23:05 robbiew Exp $
> diff --git a/testcases/kernel/fs/fs-bench/boxmuler.c b/testcases/kernel/fs/fs-bench/boxmuler.c
> deleted file mode 100644
> index e923a1617..000000000
> --- a/testcases/kernel/fs/fs-bench/boxmuler.c
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -#include <math.h>
> -#include <stdlib.h>
> -
> -#define M_2PI (M_PI*2)
> -
> -int box_muler(int min, int max)
> -{
> -	double u1, u2, z;
> -	int i;
> -	int ave;
> -	int range;
> -	int ZZ;
> -	if (min >= max) {
> -		return (-1);
> -	}
> -	range = max - min;
> -	ave = range / 2;
> -	for (i = 0; i < 10; i++) {
> -		u1 = ((double)(random() % 1000000)) / 1000000;
> -		u2 = ((double)(random() % 1000000)) / 1000000;
> -		z = sqrt(-2.0 * log(u1)) * cos(M_2PI * u2);
> -		ZZ = min + (ave + (z * (ave / 4)));
> -		if (ZZ >= min && ZZ < max) {
> -			return (ZZ);
> -		}
> -	}
> -	return (-1);
> -}
> diff --git a/testcases/kernel/fs/fs-bench/create-files.c b/testcases/kernel/fs/fs-bench/create-files.c
> deleted file mode 100644
> index c6cba6f69..000000000
> --- a/testcases/kernel/fs/fs-bench/create-files.c
> +++ /dev/null
> @@ -1,119 +0,0 @@
> -/* create.c (GPL)*/
> -/* Hironobu SUZUKI <hironobu@h2np.net> */
> -#include <stdio.h>
> -#include <sys/stat.h>
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <time.h>
> -#include <stdlib.h>
> -
> -#define MAXN 4096
> -
> -#define MAXFSIZE 1024 * 192
> -
> -char wbuf[MAXFSIZE];
> -static int filecount = 0;
> -
> -void makedir(char *dir1);
> -void changedir(char *dir);
> -void create_file(char *filename);
> -
> -extern int box_muler(int, int);
> -
> -int startc = 0;
> -int main(int ac, char *av[])
> -{
> -	int i = 0;
> -	int j = 0;
> -	int k = 0;
> -	int l = 0;
> -	char dir1[MAXN];
> -	char dir2[MAXN];
> -	char dir3[MAXN];
> -	char filename[MAXN];
> -	time_t t;
> -	int maxfiles = 0xFFFFFF;
> -	int createfiles = 0;
> -
> -	if (ac > 1) {
> -		sscanf(av[1], "%x", &maxfiles);
> -		if (maxfiles == 0) {
> -			printf("maxfile argument error (0 value)\n");
> -			exit(1);
> -		}
> -	}
> -	time(&t);
> -	srandom((unsigned int)getpid() ^
> -		(((unsigned int)t << 16) | (unsigned int)t >> 16));
> -	printf("Create files\n");
> -	for (i = 0; i < 0xFF; i++) {
> -		sprintf(dir1, "%2.2x", i);
> -		makedir(dir1);
> -		changedir(dir1);
> -		for (j = 0; j < 0xFF; j++) {
> -			sprintf(dir2, "%2.2x", j);
> -			makedir(dir2);
> -			changedir(dir2);
> -			for (k = 0; k < 0xFF; k++) {
> -				sprintf(dir3, "%2.2x", k);
> -				makedir(dir3);
> -				changedir(dir3);
> -				for (l = 0; l < 0xFF; l++) {
> -					sprintf(filename, "%s%s%s%2.2x", dir1,
> -						dir2, dir3, l);
> -					create_file(filename);
> -					if (maxfiles < createfiles++) {
> -						goto end;
> -					}
> -				}
> -				changedir("../");
> -			}
> -			changedir("../");
> -		}
> -		changedir("../");
> -	}
> -end:
> -	fprintf(stderr, "\nTotal create files: %d\n", filecount);
> -	printf("Done\n");
> -	return 0;
> -}
> -
> -int showchar[] = { 124, 47, 45, 92, 124, 47, 45, 92 };
> -
> -void makedir(char *dir1)
> -{
> -	if (mkdir(dir1, S_IRWXU) < 0) {
> -		perror(dir1);
> -		exit(1);
> -	}
> -}
> -
> -void changedir(char *dir)
> -{
> -	if (chdir(dir) < 0) {
> -		perror(dir);
> -		exit(1);
> -	}
> -}
> -
> -void create_file(char *filename)
> -{
> -	int fd;
> -	int randomsize;
> -	if ((fd = creat(filename, S_IRWXU)) < 0) {
> -		fprintf(stderr, "\nTotal create files: %d\n", filecount);
> -		perror(filename);
> -		exit(1);
> -	}
> -	if ((randomsize = box_muler(0, MAXFSIZE)) < 0) {
> -		randomsize = MAXFSIZE;
> -	}
> -	if (write(fd, wbuf, randomsize) < 0) {
> -		fprintf(stderr, "\nTotal create files: %d\n", filecount);
> -		perror(filename);
> -		exit(1);
> -	}
> -	filecount++;
> -	close(fd);
> -}
> diff --git a/testcases/kernel/fs/fs-bench/fs-bench-test.sh b/testcases/kernel/fs/fs-bench/fs-bench-test.sh
> deleted file mode 100755
> index c2ca767f0..000000000
> --- a/testcases/kernel/fs/fs-bench/fs-bench-test.sh
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -#! /bin/bash
> -
> -echo "## Start Test"
> -date
> -if [ -d ./00 ] ; then
> -    echo -n "Clear old files..."
> -    /bin/rm -fr ./00 >& /dev/null
> -    echo "done"
> -fi
> -STARTT=`date +%s`
> -echo $STARTT
> -echo ""
> -echo "## Create files "
> -time ~/fs-bench/cr
> -
> -echo ""
> -echo "## tar all "
> -MAXFILE=`tar cBf - 00 | tar tvBf - 2>&1 | tail -n 1 | awk '{print $6;}'| awk -F'/' '{print $4;}'`
> -
> -echo ""
> -echo "## Change owner"
> -time chown -R $USER  ./00
> -
> -echo ""
> -echo "## random access"
> -time ~/fs-bench/ra  $MAXFILE
> -
> -echo ""
> -echo "## Change mode "
> -time chmod -R go+rw  ./00
> -
> -echo ""
> -echo "## Random delete and create"
> -time ~/fs-bench/radc  $MAXFILE
> -
> -echo ""
> -echo "## Change mode again"
> -time chmod -R go-rw  ./00
> -
> -echo ""
> -echo "## Remove all files and directories"
> -time /bin/rm -fr ./00
> -echo ""
> -echo "## Finish test"
> -ENDT=`date +%s`
> -echo $ENDT
> -date
> -
> -echo -n 'TOTAL(seconds): '
> -expr $ENDT - $STARTT
> diff --git a/testcases/kernel/fs/fs-bench/fs-bench-test2.sh b/testcases/kernel/fs/fs-bench/fs-bench-test2.sh
> deleted file mode 100755
> index 25c67afe0..000000000
> --- a/testcases/kernel/fs/fs-bench/fs-bench-test2.sh
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -#! /bin/bash
> -
> -echo "## Start Test"
> -date
> -date +%s
> -if [ -d ./00 ] ; then
> -/bin/rm -fr ./00 >& /dev/null
> -fi
> -STARTT=`date +%s`
> -echo $STARTT
> -
> -echo ""
> -echo "## Create files "
> -time ~/fs-bench/cr
> -
> -echo ""
> -echo "## tar all "
> -MAXFILE=`tar cBf - 00 | tar tvBf - 2>&1 | tail -n 1 | awk '{print $6;}'| awk -F'/' '{print $4;}'`
> -HALFFILE=`echo "obase=F;ibase=F;$MAXFILE/2" | bc`
> -
> -echo ""
> -echo "## Remove all files and directories"
> -/bin/rm -fr ./00 >& /dev/null
> -
> -echo ""
> -echo "## Create half files"
> -echo create half files
> -time ~/fs-bench/cr  $HALFFILE
> -
> -echo ""
> -echo "## Change owner"
> -time chown -R $USER  ./00
> -
> -echo ""
> -echo "## random access"
> -time ~/fs-bench/ra  $HALFFILE
> -
> -
> -echo ""
> -echo "## Change mode "
> -time chmod -R go+rw  ./00
> -
> -echo ""
> -echo "## Random delete and create"
> -time ~/fs-bench/radc  $HALFFILE
> -
> -echo ""
> -echo "## Change mode again"
> -time chmod -R go-rw  ./00
> -
> -echo ""
> -echo "## Remove all files and directories"
> -time /bin/rm -fr ./00
> -
> -echo ""
> -echo "## Finish test"
> -date
> -ENDT=`date +%s`
> -echo $ENDT
> -echo -n 'TOTAL(seconds): '
> -expr $ENDT - $STARTT
> -
> -
> diff --git a/testcases/kernel/fs/fs-bench/modaltr.sh b/testcases/kernel/fs/fs-bench/modaltr.sh
> deleted file mode 100755
> index e44c17f13..000000000
> --- a/testcases/kernel/fs/fs-bench/modaltr.sh
> +++ /dev/null
> @@ -1,124 +0,0 @@
> -#!/bin/sh
> -#To run this script the following is necessary
> -# 1.kernel should mtd support as module.
> -# 2.kernel should hsve jffs2 support as module.
> -# 3.kernel should have loopback device support .
> -# 4.you should have fs-bench utility (http://h2np.net/tools/fs-bench-0.2.tar.gz)
> -# 5.results will be copied to /tmp/log and /tmp/log1 files
> -
> -#DESCRIPTION: This testscript creates a jffs2 file system type and tests the filesystem test
> -#and places the log in the log directory.The file system test actually creates a tree of large
> -#directories and performs the delete and random delete operations as per the filesystem stress
> -#algorithim and gives a report of real time ,user time,system time taken to perform the file
> -#operations.
> -
> -#script created  G.BANU PRAKASH (mailto:prakash.banu@wipro.com).
> -#
> -#   This program is free software;  you can redistribute it and/or modify
> -#   it under the terms of the GNU General Public License as published by
> -#   the Free Software Foundation; either version 2 of the License, or
> -#   (at your option) any later version.
> -#
> -#   This program is distributed in the hope that it will be useful,
> -#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> -#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> -#   the GNU General Public License for more details.
> -#
> -#   You should have received a copy of the GNU General Public License
> -#   along with this program;  if not, write to the Free Software
> -#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> -#
> -
> -MTD_RAM=mtdram
> -MTD_BLOCK=mtdblock
> -JFFS2=jffs2
> -LOOP=loop
> -MTD_BLKDEVS=mtd_blkdevs
> -ZLIB_DEFLATE=zlib_deflate
> -ZLIB_INFLATE=zlib_inflate
> -MTD_CORE=mtdcore
> -MOUNT_DIR=/mnt
> -LOG_DIR=/tmp/log
> -LOG_DIR1=/tmp/log1
> -HOME_DIR=/home
> -BLOCK_DIR=/dev/mtdblock
> -export PATH=$PATH:/sbin
> -	if [ $(id -ru) -ne 0 ];
> -then
> -	echo "must be root to run this"
> -	exit
> -fi
> -
> -
> -
> -lsmod |grep $MTD_RAM
> -
> -	if [ $? -ne 0 ];
> -then
> -	echo "inserting mtd ram and its dependencies"
> -fi
> -modprobe $MTD_RAM  total_size=32768 erase_size=256
> -	if [ $? -ne 0 ];
> -then
> -	echo "check wheather MTD -mtdram is been compiled in the kernel"
> -fi
> -lsmod |grep $MTD_BLOCK
> -	if [ $? -ne 0 ]; then
> -	echo "inserting mtdblock  and its dependencies"
> -fi
> -modprobe $MTD_BLOCK
> -	if [ $? -ne 0 ]; then
> -	echo "check wheather mtdblock is been compiled in the kernel"
> -fi
> -
> -lsmod |grep $JFFS2
> -	if [ $? -ne 0 ]; then
> -	echo "inserting jffs2  and its dependencies"
> -fi
> -modprobe $JFFS2
> -	if [ $? -ne 0 ]; then
> -	echo "check wheather jffs2 is been compiled in the kernel"
> -fi
> -
> -lsmod |grep $LOOP
> -	if [ $? -ne 0 ]; then
> -	echo "inserting loopback device module"
> -fi
> -modprobe $LOOP
> -	if [ $? -ne 0 ]; then
> -	echo "check wheather loopback device option is been compiled in the kernel"
> -fi
> -mkdir -p $BLOCK_DIR
> -mknod $BLOCK_DIR/0 b 31 0 >/dev/null 2>&1
> -mount -t jffs2 $BLOCK_DIR/0 $MOUNT_DIR
> -mount|grep $JFFS2
> -	if [ $? -eq 0 ]; then
> - echo "jffs2 mounted sucessfully"
> -	else
> - echo "mount unsucessfull"
> -fi
> -cd $MOUNT_DIR
> -echo "This is will take long time "
> -./test.sh    >log 2>&1
> -./test2.sh    >log1 2>&1
> -
> -mv log   $LOG_DIR
> -mv log1  $LOG_DIR1
> -cd $HOME_DIR
> -
> -
> -#cleanup
> -echo "unmounting $MOUNT_DIR "
> -umount $MOUNT_DIR
> -echo "removing the modules inserted"
> -rmmod  $MTD_BLOCK
> -rmmod  $MTD_BLKDEVS
> -rmmod  $LOOP
> -rmmod  $JFFS2
> -rmmod  $ZLIB_DEFLATE
> -rmmod  $ZLIB_INFLATE
> -rmmod  $MTD_RAM
> -rmmod  $MTD_CORE
> -rm -rf /dev/mtdblock
> -echo "TEST COMPLETE"
> -echo "RESULTS LOGGED IN FILE  /tmp/log and /tmp/log1  "
> diff --git a/testcases/kernel/fs/fs-bench/random-access-del-create.c b/testcases/kernel/fs/fs-bench/random-access-del-create.c
> deleted file mode 100644
> index 1878fd78b..000000000
> --- a/testcases/kernel/fs/fs-bench/random-access-del-create.c
> +++ /dev/null
> @@ -1,136 +0,0 @@
> -/* random-del-create.c (GPL)*/
> -/* Hironobu SUZUKI <hironobu@h2np.net> */
> -
> -#include <stdio.h>
> -#include <sys/stat.h>
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <time.h>
> -#include <stdlib.h>
> -#define FAIL 0
> -#define SUCCESS 1
> -
> -#define MAXNUM 0x100000
> -
> -#define  MAXERROR 1024
> -
> -extern int box_muler(int, int);
> -extern void create_or_delete(char *);
> -
> -int delete_file(char *filename);
> -int create_file(char *filename);
> -
> -int cfilecount = 0;
> -int dfilecount = 0;
> -int errorcount = 0;
> -
> -int main(int ac, char **av)
> -{
> -	int r;
> -	char fname[1024];
> -	time_t t;
> -	int i;
> -	int m;
> -
> -	if (ac != 2) {
> -		printf("%s hex-style-filename \n", av[0]);
> -		printf("ex) %s 00022300\n", av[0]);
> -		exit(1);
> -	}
> -	sscanf(av[1], "%x", &m);
> -	if (m < 1 || m > MAXNUM) {
> -		printf("out of size %d\n", m);
> -		exit(1);
> -	}
> -
> -	time(&t);
> -	srandom((unsigned int)getpid() ^
> -		(((unsigned int)t << 16) | (unsigned int)t >> 16));
> -
> -	/* 00/00/00/00 */
> -	for (i = 0; i < m; i++) {
> -		r = random() % m;
> -		sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
> -			((r >> 16) & 0xFF),
> -			((r >> 8) & 0xFF),
> -			((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r & 0xFF));
> -		create_or_delete(fname);
> -	}
> -	fprintf(stderr, "Total create files: %d\n", cfilecount);
> -	fprintf(stderr, "Total delete files: %d\n", dfilecount);
> -	fprintf(stderr, "Total error       : %d\n", errorcount);
> -	exit(0);
> -}
> -
> -#define MAXFSIZE (192*1024)
> -#define AVEFSIZE (MAXFSIZE/2)
> -#define POOLDISKSPACE (AVEFSIZE*128)
> -
> -static int disk_space_pool = 0;
> -void create_or_delete(char *fname)
> -{
> -	int r;
> -
> -	r = (random() & 1);
> -	if (r && disk_space_pool > POOLDISKSPACE) {
> -		/* create */
> -		create_file(fname);
> -	} else {
> -		delete_file(fname);
> -	}
> -	if ((errorcount > dfilecount || errorcount > cfilecount)
> -	    && (errorcount > MAXERROR)) {
> -		fprintf(stderr, "too much error -- stop\n");
> -		fprintf(stderr, "Total create files: %d\n", cfilecount);
> -		fprintf(stderr, "Total delete files: %d\n", dfilecount);
> -		fprintf(stderr, "Total error       : %d\n", errorcount);
> -		exit(1);
> -	}
> -}
> -
> -int create_file(char *filename)
> -{
> -	int fd;
> -	int randomsize;
> -	char wbuf[MAXFSIZE];
> -	if ((fd = creat(filename, S_IRWXU)) < 0) {
> -		errorcount++;
> -		return (-1);
> -	}
> -	if ((randomsize = box_muler(0, MAXFSIZE)) < 0) {
> -		randomsize = MAXFSIZE;
> -	}
> -	if (write(fd, wbuf, randomsize) < 0) {
> -		errorcount++;
> -		close(fd);
> -		return (-1);
> -	}
> -	cfilecount++;
> -	disk_space_pool -= randomsize;
> -	close(fd);
> -
> -	return 0;
> -}
> -
> -#include <sys/stat.h>
> -#include <unistd.h>
> -
> -int delete_file(char *filename)
> -{
> -	struct stat buf;
> -	int st;
> -	st = stat(filename, &buf);
> -	if (st < 0) {
> -		errorcount++;
> -		return (-1);
> -	}
> -	disk_space_pool += buf.st_size;
> -	if (unlink(filename) < 0) {
> -		errorcount++;
> -		return (-1);
> -	}
> -	dfilecount++;
> -
> -	return 0;
> -}
> diff --git a/testcases/kernel/fs/fs-bench/random-access.c b/testcases/kernel/fs/fs-bench/random-access.c
> deleted file mode 100644
> index c2f32b86e..000000000
> --- a/testcases/kernel/fs/fs-bench/random-access.c
> +++ /dev/null
> @@ -1,92 +0,0 @@
> -/* random-access.c (GPL)*/
> -/* Hironobu SUZUKI <hironobu@h2np.net> */
> -#include <stdio.h>
> -#include <errno.h>
> -#include <sys/stat.h>
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <time.h>
> -#include <stdlib.h>
> -#define FAIL 0
> -#define SUCCESS 1
> -
> -static int openlog[2] = { 0, 0 };
> -
> -#define MAXNUM 0x100000
> -
> -void open_read_close(char *fname);
> -
> -int nullfd;
> -
> -int main(int ac, char **av)
> -{
> -	int r;
> -	char fname[1024];
> -	time_t t;
> -	int i;
> -	int m;
> -
> -	if (ac != 2) {
> -		printf("%s hex-style-filename \n", av[0]);
> -		printf("ex) %s 00022300\n", av[0]);
> -		exit(1);
> -	}
> -	sscanf(av[1], "%x", &m);
> -	if (m < 1 || m > MAXNUM) {
> -		printf("out of size %d\n", m);
> -		exit(1);
> -	}
> -
> -	time(&t);
> -	srandom((unsigned int)getpid() ^
> -		(((unsigned int)t << 16) | (unsigned int)t >> 16));
> -
> -	if ((nullfd = open("/dev/null", O_WRONLY)) < 0) {
> -		perror("/dev/null");
> -		exit(1);
> -	}
> -
> -	/* 00/00/00/00 */
> -	for (i = 0; i < m; i++) {
> -		r = random() % m;
> -		sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
> -			((r >> 16) & 0xFF),
> -			((r >> 8) & 0xFF),
> -			((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r & 0xFF));
> -		open_read_close(fname);
> -	}
> -	close(nullfd);
> -	printf("Success:\t%d\nFail:\t%d\n", openlog[SUCCESS], openlog[FAIL]);
> -	exit(0);
> -}
> -
> -#define BUFS 8192
> -void open_read_close(char *fname)
> -{
> -	int fd;
> -	char buf[BUFS];
> -	int c;
> -
> -	if ((fd = open(fname, O_RDONLY)) < 0) {
> -		openlog[FAIL]++;
> -		close(fd);
> -		return;
> -	}
> -	openlog[SUCCESS]++;
> -	while ((c = read(fd, buf, BUFS)) > 0) {
> -		if (write(nullfd, buf, c) < 0) {
> -			perror("/dev/null");
> -			printf("Opened\t %d\nUnopend:\t%d\n", openlog[SUCCESS],
> -			       openlog[FAIL]);
> -			exit(1);
> -		}
> -	}
> -	if (c < 0) {
> -		perror(fname);
> -		printf("Opened\t %d\nUnopend:\t%d\n", openlog[SUCCESS],
> -		       openlog[FAIL]);
> -		exit(1);
> -	}
> -	close(fd);
> -}
> diff --git a/testcases/kernel/fs/fs-bench/random-del-create.c b/testcases/kernel/fs/fs-bench/random-del-create.c
> deleted file mode 100644
> index 345031f28..000000000
> --- a/testcases/kernel/fs/fs-bench/random-del-create.c
> +++ /dev/null
> @@ -1,134 +0,0 @@
> -/* random-del-create.c (GPL)*/
> -/* Hironobu SUZUKI <hironobu@h2np.net> */
> -
> -#include <stdio.h>
> -#include <sys/stat.h>
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <time.h>
> -#include <stdlib.h>
> -#define FAIL 0
> -#define SUCCESS 1
> -
> -static int openlog[2] = { 0, 0 };
> -
> -#define MAXNUM 0x100000
> -
> -#define  MAXERROR 1024
> -
> -extern int box_muler(int, int);
> -extern void create_or_delete(char *);
> -
> -int cfilecount = 0;
> -int dfilecount = 0;
> -int errorcount = 0;
> -
> -int main(int ac, char **av)
> -{
> -	int r;
> -	char fname[1024];
> -	time_t t;
> -	int i;
> -	int m;
> -
> -	if (ac != 2) {
> -		printf("%s hex-style-filename \n", av[0]);
> -		printf("ex) %s 00022300\n", av[0]);
> -		exit(1);
> -	}
> -	sscanf(av[1], "%x", &m);
> -	if (m < 1 || m > MAXNUM) {
> -		printf("out of size %d\n", m);
> -		exit(1);
> -	}
> -
> -	time(&t);
> -	srandom((unsigned int)getpid() ^
> -		(((unsigned int)t << 16) | (unsigned int)t >> 16));
> -
> -	/* 00/00/00/00 */
> -	for (i = 0; i < m; i++) {
> -		r = random() % m;
> -		sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
> -			((r >> 16) & 0xFF),
> -			((r >> 8) & 0xFF),
> -			((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r & 0xFF));
> -		create_or_delete(fname);
> -	}
> -	fprintf(stderr, "Total create files: %d\n", cfilecount);
> -	fprintf(stderr, "Total delete files: %d\n", dfilecount);
> -	fprintf(stderr, "Total error       : %d\n", errorcount);
> -	exit(0);
> -}
> -
> -#define MAXFSIZE (192*1024)
> -#define AVEFSIZE (MAXFSIZE/2)
> -#define POOLDISKSPACE (AVEFSIZE*128)
> -
> -static int disk_space_pool = 0;
> -void create_or_delete(char *fname)
> -{
> -	int r;
> -	int fsize;
> -
> -	r = (random() & 1);
> -	if (r && disk_space_pool > POOLDISKSPACE) {
> -		/* create */
> -		create_file(fname);
> -	} else {
> -		delete_file(fname);
> -	}
> -	if ((errorcount > dfilecount || errorcount > cfilecount)
> -	    && (errorcount > MAXERROR)) {
> -		fprintf(stderr, "too much error -- stop\n");
> -		fprintf(stderr, "Total create files: %d\n", cfilecount);
> -		fprintf(stderr, "Total delete files: %d\n", dfilecount);
> -		fprintf(stderr, "Total error       : %d\n", errorcount);
> -		exit(1);
> -	}
> -}
> -
> -int create_file(char *filename)
> -{
> -	int fd;
> -	int randomsize;
> -	char wbuf[MAXFSIZE];
> -	if ((fd = creat(filename, S_IRWXU)) < 0) {
> -		errorcount++;
> -		return (-1);
> -	}
> -	if ((randomsize = box_muler(0, MAXFSIZE)) < 0) {
> -		randomsize = MAXFSIZE;
> -	}
> -	if (write(fd, wbuf, randomsize) < 0) {
> -		errorcount++;
> -		close(fd);
> -		return (-1);
> -	}
> -	cfilecount++;
> -	disk_space_pool -= randomsize;
> -	close(fd);
> -	return 0;
> -}
> -
> -#include <sys/stat.h>
> -#include <unistd.h>
> -
> -int delete_file(char *filename)
> -{
> -	struct stat buf;
> -	int st;
> -	st = stat(filename, &buf);
> -	if (st < 0) {
> -		errorcount++;
> -		return (-1);
> -	}
> -	disk_space_pool += buf.st_size;
> -	if (unlink(filename) < 0) {
> -		errorcount++;
> -		return (-1);
> -	}
> -	dfilecount++;
> -	return 0;
> -}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
