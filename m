Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B28AC433F5
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 03:06:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09CAC3C59FD
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 04:06:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AB0A3C3041
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 04:06:35 +0100 (CET)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CD02A1000AE9
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 04:06:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638241594; x=1669777594;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=IUZZ9G4Tlu3/Tq91weORVwg5MRjWWfBq2r32N2N7nv8=;
 b=RyAFr/TBpLCSN73XD/uUW/pdZ7KY+08UGYBYmaSK2BS4po4XUDi9GtBT
 RBSo06S/b2dumxKN3J2OkUwDF+RCReh+35inm7R2LmNSGEaxvgpruOoJa
 VI8QKrLLkpHDm2Vh5UbwlIiIGOnL4p4B6gucGXV3t8G6ZHY+qMdCDJojK
 VskO52vp5X5R4l7J5/EWyJ+ZryeOFEm3uiCuqgk9dg/Ch+ytdmfH5Gld7
 b+U23XPtqUgE9wlCXDvc4+DMp9akrPtKhLG1oBMbnbYSs5FXPh10wYst4
 oxoukLpjXdTooIaQTXRLkGT/iwB5yB471ARcZfNmWwMz6E3TGyZGaN/An A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="52906245"
X-IronPort-AV: E=Sophos;i="5.87,275,1631545200"; d="scan'208";a="52906245"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2021 12:06:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmihrPqt9l7eT+9SfE49zRtTV2J3eEnTIKT5w8XoGABZ/J4UDn2GtP5h4CplglDVGV/az+AvXAuk5RB7HzG4o/7NL9ujaLEYT/qln+eCJn7MCDEVJ8p5P3mRvUsyG/ElSowZnbMfEf5UtTsGN4vVW2gkvem7hY4gnqhiVQJEVS5DveJGB4xwysVHy2aEoQNGgdIw19ejhZ5wq3GVD8HQRJI6yBWotxadm1ApUiarRv+TmDBCEg4rpXide1T0B/qwh/zrQ/ObVU5cH3SUyGITeyWWAuVW2hin246aipgyBzNPQiS/5GJfZVFjtnQgPmHsC8tD3jgMXrNskIeZrhcUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUZZ9G4Tlu3/Tq91weORVwg5MRjWWfBq2r32N2N7nv8=;
 b=FiHtRvtpBswpYdZ0nIqZphAaA0TSF5WHKu73CHD4AYIYEE870jSRizVYxqu0gKy7LPjKT0unpoQHc9talgu9TGaLmNjfs06KIj5GFwrlvgoAHxDY8VPYuSvWrsEila+VnUSNbDPDIFbfvyvhp4DMVFsZ4zCRLAgyG1tAforYt4R22G+Rrp4SmS49LZrCElDVxyjzIH4PFtRvAKHthHINoZ097TkLb7ILGGmzX46G0hogrOmYGF3xgrrcVbnTmozVPLbkp54o1Db/206vs0qFNzJWI7N0bhlscrAYtGtj6LcoPbSj718NaVHKjQVCLZ+As2m9NVBmpld1XSjBf0LYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUZZ9G4Tlu3/Tq91weORVwg5MRjWWfBq2r32N2N7nv8=;
 b=G1J336l0Q6ugpA/RtLU7rV5aHTM0+mnD9XTV5NnRFfNYjC9YDR8CRNbC5piNIT7R3rzKX/WehudQBMBE6P892Hjwj81PsaV1mfKOvaP3DC1D2cZ0fqNk5AKHWibnuohL77XhnNs5/Vde5oUbIA/Ava1MlYrqrFMxS2IpDwYu/5o=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6537.jpnprd01.prod.outlook.com (2603:1096:400:95::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 03:06:29 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 03:06:29 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 1/2] syscalls/statx01: Fix compiler warning because
 of PRIu64
Thread-Index: AQHX3R9zr4T/UUS56kqe7uu2ATsMKKwaflgAgAD2CQA=
Date: Tue, 30 Nov 2021 03:06:29 +0000
Message-ID: <61A59548.5080708@fujitsu.com>
References: <1637310522-19620-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YaTG5HJnWN/RPLpX@yuki>
In-Reply-To: <YaTG5HJnWN/RPLpX@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3828ab4-4814-4594-eada-08d9b3ae67eb
x-ms-traffictypediagnostic: TYAPR01MB6537:
x-microsoft-antispam-prvs: <TYAPR01MB65374742DCA83A9027A9B45CFD679@TYAPR01MB6537.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nR3gqS14jPlUijKgKWaDhNOEsSY32f3FX7QeZeIvyyh40UC06n0b1pZ2viTC84eWgxdE5Qh2J1mD7XIds7EoGZ36XZWvlD39Ywai9tKzbifAtV7+YL7dih3GRyW+yMjDiG6R4lKWNwja+g5i+xJUL+uRNMxbWR+DqXjS+A+QHASwhZGJ/VExIenJUXxIz8KuhwPjUIwLEKHM3iTYtPHpoI/gdqpl8/Tys/AwNdbLPofNvczmmHOCRoKYsIsY5b3b0n399wgdbCgcxGvJO4UrNTbaD9cpLF6AuqLELHYTkud12EW6ACrKaJsbAz/TwrY0J2ikpLsTPEl85kXlVH4RYH2o9hJMX1tiwaBhnz9JVIREayUV2oloGmQgNANgU8AgejAx7OVpzTo8flbJ5WlPX2CCMLQSx6JfeFBFiHhcmdKfEfvxh4YTgtjPMNK9tpwcDYgj3UOxiXabRlBWZSI9+nfpD7gdE8pK7BwCdpJ8G0yfQoYgCaMn9ek+PfaihpOpcXKfX7e29+8anMJU2rESq19pAvXMxNEUuDoAYW3Z2posVyYny5tPjsYZYjP5bhFCsz47T9/EvmUpVvQJ2JYD/2T+bMszTkZKWcgmS7Pp0ZSnAc0X3YYKG3fpf7saypvRd48X7qinjspzBw3hBeSxhOZxLHk+5zlWHF8RVJ85iOwlsk9Du2u+304hK5wHSrXwQ6by9ctqH96c5TOEzM1jjw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(8936002)(558084003)(38100700002)(36756003)(64756008)(87266011)(82960400001)(508600001)(91956017)(66946007)(86362001)(33656002)(4326008)(38070700005)(66556008)(66476007)(6486002)(85182001)(76116006)(6916009)(2616005)(66446008)(5660300002)(2906002)(186003)(26005)(6506007)(6512007)(122000001)(8676002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SWZPa00rVnJWc1dvaGU3ZEh4cVUyWmlaV3JGTWtYRHFJZGVmcGczSXRTSTl4?=
 =?gb2312?B?bGZIRmozMEQvVXJVQXJjcHVHQ29KUEFMQldyb2p3bndCcytuaDhhUld0NVBy?=
 =?gb2312?B?TUtoTE5VLzcwQmZ4RGxSWVU0Q1o5eWNBekxoQTZaMjd4NDNiaEQyZ3pObTdH?=
 =?gb2312?B?NEZGendCekdXZFFIMEN2Vmd4amZyNWo5YzM1dDRaVmVOdTFwZkIwZjIzQkpS?=
 =?gb2312?B?WXlZU2lZN2pLbE40N0l0YjM4bVVjQ1JlQXN5b1pFNWo4bHlsRURTdEVDUTV5?=
 =?gb2312?B?RjkwUFNGUTF2MkwvaE1WN2JDeXlCSXVucFJFQkYzQ1lhazlQWXBtVGF6OUp4?=
 =?gb2312?B?Q0JzT3FnbmJtTUhrRk5OV3NTUDNLS01obmR1RHQrazhXUHB2MDJBMktaNXRo?=
 =?gb2312?B?a3RSMC82RVZiU0wvc1BmZEZHWGtaQXd0U0NwSys2aDJsV3Roa1N3Vlcraktv?=
 =?gb2312?B?ekQ5OUhuQWdqcFAwYUJ1TllxTWNqeXR0S1hCdGYvNEJ2RmRsOTBlcTVLa0p5?=
 =?gb2312?B?ZzE4c2h0SzduVEd6YmlpY3FPREZBWHFwYVRMcWt1ZTUvZHFqUjRnazJ3Z2dx?=
 =?gb2312?B?elRTNU5XOGNGbVhWREh1elJ4Z1AvNDhiS283cDg1T1QwSE1XTFRzOUFzWjc4?=
 =?gb2312?B?bFduRDEvVVJFSUVadFc1Y0FULzlvS2d1a2kyNGk1Vzl1TXpXYjJMajdKTm9j?=
 =?gb2312?B?bnUrSTM5TzdhSlNGM2VXVklFeHN6V3VoMWo5aHl3UDk5MzlsRGo5US9xNE5y?=
 =?gb2312?B?TjJRc0RlaDZIMjU4ZWV0enVzTnFydHY2Q3lIdGZVNzA2SVllQzJrbG1vY0tC?=
 =?gb2312?B?RFdVdWc2WjRXVmE1VHRFRVM3VVFzbVZCb2h5cUUrRE1QWjlmY3dPL1lGTHAv?=
 =?gb2312?B?VW1GZXVwOXdRMkM1bm1MazV1bHVKNlRhcjlxdHh3Y3NCSFAyc1ZGRmhGYUg4?=
 =?gb2312?B?d1dJclVNV09KQzRDQ3ZNUHFzMndkeTJoNHVJVndrSnRsV3RJSTNYamlBeGow?=
 =?gb2312?B?VlZxS09rUnI1TE9jOTdiVFowNG10VHVTZDN1aEViQzVvQnY1R3o1SlI4aWtz?=
 =?gb2312?B?RGlENGFVM2gvcFhSU1VWall1eXlzSWp1WkhsYTlIUnJrcnZJTnJlN0xmMUk5?=
 =?gb2312?B?WmpTK2tqYVRtNnhDT1l6Q01YeDZjajMwZkM1ellzaEkzSkJSK0xldGRuOHk2?=
 =?gb2312?B?c1Z1NHhPTHJMeU5uS1RWbDVnOWJybm9yR1RWZEdCZ1hWSldid295NmxUbUJJ?=
 =?gb2312?B?TDVwS21jVUNrWnVkRG9lQVhPakxpU0JwdDMrT1p5b3poQVBzTnhVTDlQajVM?=
 =?gb2312?B?OCs1cjZYQnhtdGZXckRMSUhhaGVPaFNvREs1T20xTGFrSmNta1JiT3F0ajBq?=
 =?gb2312?B?ODdQRkUzdi9CeXFaMzhpZnNJTUI5M2NBb2hMSVFONkM0Q2diWnY0SmE3SzBp?=
 =?gb2312?B?N24yKzQ3SXhYNnV2Um5CUnRMU2Vud3FEclVMalI2UWxlb1o2dlNpT1VTZDJp?=
 =?gb2312?B?dExMNVFXRjNYREhvWXpRTlVNRjVTZGJXeVg2Z2Q1N3AwZ3BZdmVYOVVpbUx5?=
 =?gb2312?B?ejgrcXRhVFBVeVl6cjNaVXFEamVVV01ZSlVCeGVXMVQzeEQ4enBVMnFRTHlB?=
 =?gb2312?B?Qm9HUE9ibzhDMnVBWVBQNGhra0JnM21EY3V4M1lyOG54ZWJwbVBaRFp1QXhE?=
 =?gb2312?B?ekRnd3BBZlVzV0p1VXlmUTRjdzRlRUt4NWVoaUFvbGpBMHRuSHNEb2gxM0FC?=
 =?gb2312?B?ZzgrM3VJdHYvUjVSaUpEd2dHSjBPUHVvci9nR2VHSWIySWpGdzVVdm5QYzJk?=
 =?gb2312?B?WE9QUEM0NUQ2NCt3MVY2ZTgrNytTWE1CM0NXUE5DQUluUklPRXluVzJ1VTVa?=
 =?gb2312?B?TlVjaUNVbmJlMDRkZXRib3FEc29SQ2FqZVpja3RvYnJkMkpaVVMrOTMvalRk?=
 =?gb2312?B?NFRkRk1kbUZhaUhocGxjU1ozd0hIRzR0THVRZkUrK3pBaG5Wb3VpR29ZNEto?=
 =?gb2312?B?QjU1Z05PVnFucUljS0IwS1lWRG1qVzAyYS9CTFlldlNEeTYwZHhBWnZMSHIw?=
 =?gb2312?B?WHJWQjFIeDg3VU8vTXVpV3VBZlFLSlhMWGVIcnZCM3BwQTlqUXVuREdtYS9Y?=
 =?gb2312?B?NWM2RCtFTGp3elBUUFJZbHF1WUJ0REtQQXRvY2dGN3lMc2pwVStGM1hxN3M3?=
 =?gb2312?B?OTRoNGpUNkUzdFRKMFFMUUUrc2FoZC9BdG5JMGJMTjZ4NHR2bVc5NlBFd2dU?=
 =?gb2312?Q?7HPeYSqvZ8uSs24gIxxHrguL8oZS/dq8VttNw1ptmM=3D?=
Content-ID: <B76E41C3AA3347448653488B85531A4A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3828ab4-4814-4594-eada-08d9b3ae67eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 03:06:29.7686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xS00y/GJbv4fje1lvON10w+hYsXpHi2D5bdtt0B03IKo8ao4/FrZLm5JzNOQFuCy0jNekTIXEE0+Dr0oxeiFLx588a1+coK/FJKLRqG0vkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6537
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/statx01: Fix compiler warning
 because of PRIu64
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
> Looks like the __u64 is not going to be compatible in userspace and we
> cannot do better than explicit casts anytime soon.
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
Merged. Thanks for your effort!

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
