Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1B2C4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 07:20:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21C203CB050
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 09:19:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48A793CA06D
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 09:19:49 +0200 (CEST)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6DE62600802
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 09:19:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1666077588; x=1697613588;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JQ2HDkORxpOhqhV1FuKC41xnDS9wrVA6Q+jH2DKUOF0=;
 b=b6RoZ/SRGbyj6ptAQK9zkqnOQzNCaML7ymrZN5HY0q80xOh/+g3DSkyR
 4iA5J++7sKIONmSfzZCr/vLbzNNe1KuWrQ4A2NFzKmxgSts4XA/mUWTtn
 YHelcPpntzD/tHmNQDF/6d7wr9qRCwOSWlGnXarUfAYHheGXmruV6d8Zu
 8zhWJEySyhApN9aQ3LSsLn9dSsi5z3P6Nut3oWYI4j6XYful9W2QhdXI7
 7hxn9yNELNj3s9wrtlVcAVzDVgOVhjqGtSLLNFHm9mqDNQ+b9otDaSTJX
 r2Hy+m0DvfuhQSfH6UYRSgPtrFtca7EbQJTWD0X35QScZlXFdjFjPQeBm A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="75856514"
X-IronPort-AV: E=Sophos;i="5.95,193,1661785200"; d="scan'208";a="75856514"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2022 16:19:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLtyiy3Mlj8fCSjgHvVvnd89EFjzcZdFynuRbV9WGw9AwgH1p5ieINEgUOewaQx8eqqy5kXCV2ATU8lQip2HHQ9WXAM9ebsYBbqc6e+eSkm3GIPT4wH01T+gaKVgKSGKMvlzrYq2kwMV6dM6ML7X4rr3LL/yi1SKNdcYpVBaqL3F72c6Pygary3dUgIw0kCLtf3ulJYe2C1HL33/6NzcLwOP8WNYVKQyEg6Tuh3pNywZTlx0YEn1IzoGRI1tkvFg3JOp5A6AsFPL62FF2dLT7YygK7FTYDFViFMuOFVozDwRr3e+U0MGcHNJ0hd9MXi3eokCveml19LIijYt9uiTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ2HDkORxpOhqhV1FuKC41xnDS9wrVA6Q+jH2DKUOF0=;
 b=iEj6OGm/Ak+Xjv/2XRhWZcoY/PpAxcW+GYRCSDwjbXCmE9fG7178QYqsw5ESrWF7LgqPLBp5qZVW3K+2m+GKYbfgUcvbqa7PxnI60JJ0TNySWXs3GErrMczhQJ090+pNyRvb8Y0302UFanXClKoU7WvSzGUIat24NXA3saw91C/E3smhc5ZK2iF7z8nOeKgLLLR23IeXTEdJgvXtFSzpgC0pKJ5xsiuhzQIlHaJF4G9nE/97pesIbkjcEJnYLwxLvhQeCyH+mqW7fuWb6l74WznuNhH7H5i95OuCbbK59cBcEhStu0qPYcjysPk8pW8O6eE0ihip3IpXTOyIW8uytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB10389.jpnprd01.prod.outlook.com (2603:1096:604:1fa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 07:19:43 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 07:19:42 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v4 1/1] mount03: Convert to new API
Thread-Index: AQHYtj9y+F1qJUpJGk2excUnb5K47K27JqOAgFkBxIA=
Date: Tue, 18 Oct 2022 07:19:42 +0000
Message-ID: <7cd60563-e0a4-d51e-3339-5f79b10c2044@fujitsu.com>
References: <20220822155413.24814-1-pvorel@suse.cz> <YwO3qbIO32hvryjw@pevik>
In-Reply-To: <YwO3qbIO32hvryjw@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OS3PR01MB10389:EE_
x-ms-office365-filtering-correlation-id: fc5051a9-b1fb-4693-51b0-08dab0d9209e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 60U66hILJuV9GPWss43QFcaZB4HTFlQD9KimS1aY2+gMflH3QmoloUiGcOM/Pg07BVJIKTOwntw8Rv8jS9dsPjIX3ZkP4OziBYExh5fz9pglLIjJwh0Z4yu/9uu5Mv2hhHZI7dJxtQlxxuRGVZyBHhJRTr9TlMEcfAWRNK0YNBjaPfGAW3gHn6Q1qmlSrYEE56oKWkjZOxTvZA3moP43TlQSP21x7sKsAyHRhR6cKWwvihou+CDYVbdbGTdBa9v847L9c5g4t4CGzou4tN2PWVow3H94Ep0vVuRMISd9G2KX95zmicg2rX47mQCakyZea+RFupA5SaL9XbN6AJ57UVkW+QRSAe7axRejKmA5UZrX114kwQSIuPQj9LfRUIW+X30HrtE+QN0OMQshg+mbrzCfWmg65xXKIY8vPZw+u7IYIbjtCrFWtLMM3mNbjdyc1Uq3FTWfFYsyTCW91yYvMe2Ci4pN/SSF6XkDnoGNPlrasCellgEKTcXqInYHFkop6RtF2kruT75TuVds/VYXnRash9RkFdOUmbiR94E9i00CrcoZPpnBx+2XFXqZpgxvF/0qY4B9omKbD/CfU0UnTYuXO4Nt+TTYcHk8gQhP2Mhlc97qMtJMfb92deHlDxkGQNsstZRVtOETJZ0W19T5r1pEVxs6hRNvNPTMiY9AijZnBv9coxh5IzjNLOWnH+azI6hsgkOglA9fKV/vVIkHBWDpyntCFNH1i5bExXfjbshFtohk/VhtUfNqSa7wTic2FWWWNO4UUy+xbPp3VO7d4XR49tRjs/0e9JpSx5IGYp6Nyhy0r6+zQtJHI7cc7MjlVD7+UAoB8/B1Oa+RmHPhGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(1590799012)(83380400001)(31696002)(38070700005)(86362001)(38100700002)(82960400001)(122000001)(8936002)(5660300002)(110136005)(66556008)(41300700001)(66446008)(8676002)(66946007)(91956017)(2906002)(76116006)(66476007)(6506007)(186003)(2616005)(26005)(54906003)(64756008)(6486002)(6512007)(316002)(478600001)(4326008)(71200400001)(36756003)(1580799009)(85182001)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1hBanlyVFN4UGFidk1vQ0o2MnhkZitrVC9MNEU4VU16M3FuTllJN1Q1dUky?=
 =?utf-8?B?QTJiRjNXbWVwU25OS1RHLy93bzZnWXZ5dlN5L0FzM2hOaUZNc014TFAwQmE1?=
 =?utf-8?B?N0N3Y2gxbEg0L1h0NHE3TXl2NlJ3djM3aVBHSUdDMDUydVZhWlBKR3dZK0FI?=
 =?utf-8?B?R3UwZWRYSTROWTVHajExZlRFckdWZHQwTjBLbUNQczU4dERUcmhxNkdmSnov?=
 =?utf-8?B?cHNkNmlwcGFTQ29lY0ZqZk1VajhUOE1EVm9xZituWk56aFF1TE1SOXM4d2VY?=
 =?utf-8?B?eFZhK1ZmRGJZVVBMaDhRTDgrdW9JbWdLc1o1RzlwZFY5TFdSNThndFVEbVhm?=
 =?utf-8?B?K3BDeHEweHlZZnBwenZyTC9tRkxzNDhNNXlLOVNFbHUrVWdnWFlsUzIzMTQv?=
 =?utf-8?B?TEdTanZoVEsra0w4RDg3QUIzeVRrZHN5WGl4WEdvbk8zWVFhME0vR0lQY3RR?=
 =?utf-8?B?R0V4RWJ3TUxMbWNQaXE0R2VRazZabDEvTFRNTFhXUG1VYmU0R2Nab3ZVQjQy?=
 =?utf-8?B?cmxwQW9zZzM5SjVaZUxHdFlNeVB4dDkvSkdWT1BhUlBjQmRGNUlFZ3YwWG9L?=
 =?utf-8?B?ek9Td2p6RjFLTDFocFo4dmM3WEtNeUd4RFB6b3kvbnN2NGROSXdTMDBzaUpm?=
 =?utf-8?B?dkRjY1dRSXBRMVgxOGFRZmg1RkxoRU16aTFkT29oU29ac3RJTmFxSjdJRVZt?=
 =?utf-8?B?Y0ZLT2R6WWNoYjlMTVI1cDA2ajhuY21DVTFnL0ZYZFVYWmNPV0dEUXVHOSs5?=
 =?utf-8?B?RHhsWkxmVjdpTFh5dnhSV1ZQNXZjWlB5WHFFUmN3SmpObTdLclQ0Q2NEYUJD?=
 =?utf-8?B?Nk91NkxzaXZNQUY3SnRHRGhZS3NodkY4NlM5YnppdCtqb0RvUHg2dzhWY0Qw?=
 =?utf-8?B?cUhZNUhrc0xCRGExZGEzWXFLRjZXeTFxd2Erby9mQWpXRk5yVkdpUlFwWkVz?=
 =?utf-8?B?L3M4ZWU1YnhrQm5YQ0NlUC9pRWZFeGdLeXRhYzdIM0tUbUZuVnIvOW5IUDlh?=
 =?utf-8?B?UHBIdlNvZ0VIUk4xcEpCT0w3enc0c1UzRUs1bzJnWXdRUHVvdTh0VzE1MThK?=
 =?utf-8?B?NFdJTW5VTFhUN1NiZUtjZDR5QVZNbm1GU1VsVjdtakJHbGVMbVFnMnAwUFpv?=
 =?utf-8?B?YXpKTEpSNjJMU2ZZbFFYMEtyNnI2MzNQcFJRakNKd0JDQ1BRbHFNbHFxRit6?=
 =?utf-8?B?UG5kOWNvVU83UmJmV00yTTliOHFxOUpzMm1iN2FoYk1vZlpGSVcxS21ZcG9S?=
 =?utf-8?B?aXpFYWdwYlJCTXJtNjJzUXFVMWpEN3RSTnc2b29yMUxRaFJEWEJxY05nWWFj?=
 =?utf-8?B?ZjRlZEUyeFVqSXdPZ0JkZTV0TStoU3pGaUpVRFZjbWdCN2U0cDlTdDd2TFov?=
 =?utf-8?B?YU80cUY0YU1JczQ1RFY2YzZHQldvVkd1VmNUUlowNDBnU2VERDB0OEQ4YzFp?=
 =?utf-8?B?eWJHTWZzb25aUm1ZMXBsdTM3TWhHRWRSSS9abzZDeFpkSkcrTTFBV2FEUHBx?=
 =?utf-8?B?ZUNHZXZlOU4xTE4zVW5paWVSYk1CaWxWUVBFZjVJcFprQVAyS0RSNWluOGlN?=
 =?utf-8?B?dlBVSmpDMEFib3dLWUU0emRTMit4ZmV5Y2ExRlNVUTFiNWdVdUc3cFlzUVlj?=
 =?utf-8?B?ZjR1RS8xemFQWTZpNVY5cU1FazRPNWhFblVQQWZ2UTBmdGxEb3BMMktMb3V4?=
 =?utf-8?B?ZzhzYXcvTGYrYzBFMlNCSzNiL2JPanpxdWVKTDBDbVhLME1nNVhoVVBpdjhY?=
 =?utf-8?B?eHE1MXREV0Z3bzEzeTZLd3daRy9wK3MrdHJRd1JYc3ZPSzhoQ3Z2cnRMLzlL?=
 =?utf-8?B?MG9HWW1saUwxWG9ySE55dTRrRXdSV1I4eklPU1BNQkhIdTcrRyt0OW5qdkVa?=
 =?utf-8?B?V0RVcjZ3d3RvaS9LRnQvRVJCT3Y1aDQ5b29qVkh2S3F1OU9tNnpFTUhPaWpT?=
 =?utf-8?B?RTZocTRMQk5JSmVMYTRVaDljZ2w5cko3OEwralFsTngrNWpFQ0FSbjdTZDdz?=
 =?utf-8?B?cVRTQVhyUTdRNlpIRTc3MHNvV0c5UlUzblN3UHFVU0kwOVZMdXdyN3FpTG5H?=
 =?utf-8?B?ODFWYklvTXdCdXcycXhrbFhvcW9idlh4UUFJcHozN1hOR0I5NEpiaEpPcFBN?=
 =?utf-8?B?dHVrQjRLVFN4ZVcvR250QVRxeTRkWDBtS0wydFNlTHZrdTZyQUdLbWRwK1hq?=
 =?utf-8?B?Q2c9PQ==?=
Content-ID: <AB9DF14417256E48A2632A6CDB9ACA4B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5051a9-b1fb-4693-51b0-08dab0d9209e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 07:19:42.7828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q38Bx4LQVvaYZGrH3PTvxliU7P4F5jSCXDugd5hXETHeTZBM5FYO7wNHxQRsxC/7+q311YSbgmsxai+djENa41CG4KMW2Lf6MpG7g16YhJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10389
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] mount03: Convert to new API
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

> Hi all,
> 
> when running in loop, I sometimes still get error:
> 
> i=0; while true; do i=$((i+1)); echo "== $i =="; ./mount03  || break; done
> ...
> === 100 ===
> ...
> tst_device.c:434: TINFO: No device is mounted at mntpoint
> tst_test.c:1599: TINFO: Testing on ext4
> tst_test.c:1065: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> mount03.c:150: TINFO: Testing flag MS_RDONLY
> mount03.c:48: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
> mount03.c:150: TINFO: Testing flag MS_NODEV
> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
> mount03.c:150: TINFO: Testing flag MS_NOEXEC
> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
> mount03.c:150: TINFO: Testing flag MS_RDONLY
> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
> mount03.c:150: TINFO: Testing flag MS_NOSUID
> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
> mount03.c:150: TINFO: Testing flag MS_NOATIME
> mount03.c:111: TPASS: st.st_atime == atime (1661183501)
> ...
> Summary:
> passed   32
> failed   4
> broken   0
> skipped  0
> warnings 0
> 
> Any idea what can be wrong?

Even I test 100 times as your script on my primary machine instead of 
vm,  I still can't hit this problem.

Maybe filesystem based on loop has been corrupted?  Now, the info isn't 
enough. Does dmesg provide some useful log?

IMO, we can merge this patch firstly, then we can listen whether other 
people also meet this problem. What do you think about it?


Best Regards
Yang Xu
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
