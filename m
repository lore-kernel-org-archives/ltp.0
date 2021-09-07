Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF506C433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 09:32:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224BD60F25
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 09:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 224BD60F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 785823C706D
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 11:32:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 498BC3C2590
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 02:43:02 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EAEFC20035F
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 02:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1630975381; x=1662511381;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=0mcpylGB/RII/YDkuc8TlpUYIUMlDon0VcM/PmNqzXM=;
 b=aZgZWJJonUTwZJDF/M/ny/0f944a3Dv575vzYMS12+VXoDHsWW3LM6zx
 5ODkwf6GC0/mWYjfX0BFc3za8A9wjS3lr3n2tYSYHhlrPDeYOS6FQ6QQ3
 kEwI/UUXBy6QwW+V23H+92A70kDcn77KG/bdb09hA/l+Vqb3rIEzLtRYx
 QEnxJzHzE3xoTVLzFkQNbZCXe4bqz+FKXAE0zc2XPprhMxUW9x3OtagP3
 NZ77ONr6vQKgUP3N36r5ElDFtzHqD1PBynYlsbwWdP7zwZtBrS6WN2RWD
 yQdrRKCuI2dQMPQGJTySqzJ8q70A5x9/7NRHpMcLk1tKwfJh6JAxfi18e A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="46591463"
X-IronPort-AV: E=Sophos;i="5.85,273,1624287600"; d="scan'208";a="46591463"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2021 09:42:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO64EzjHawMnPSf62sfPCFZ1YqfeESCD0X/BBWe1hJvIRrf7Usb+VY69WbN8t+O5Pm9lkrzZeVlXM0Hgn/tK0lCvOAUDlfmE2ko/zWWhOUD6c0xiBso1r8cIn+CIq9VZcajRwcvv4LtwIg0XKMt0LSpW/VTeMHuEC7dTMe9lc1DQg8X9/S1ZGG6eIx/ABZBSOGibbVwfNFeuidLUJNfMTKew1VgoXFR17Tdfzu7jDJMx/V75SIIul8hwZIAPKAP7wnnSQEEOTS1KTthCo3ZYnqASJ5gTHSgi/6vDmbacfPS+D9v6jTdTW0Y87HfPCct2WkRyrsWpKFj4DsIxpn9pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=WGb67jr+/lphZ8gjfpA3rVk4C9thVi9eVgMoxdEzbKM=;
 b=dD3rVVpZ+zWw7wCfV78egRM3YL00jDNBEZOiJ6eNhWe7Gy9eYwVfJgFRQEcTWt+k+pvU9r/l6MIW436XCeYjNiajOqcLQISagCVW0kRWzoAkGSrtHTGVTXHNzXQwBQCZ6hNuDZ84pI+DFImPm4ja/u08xqxPM6+eXM8u/WoeZqTXn03WelC/lSaLbDdnXRkfdmAHhZcSwe4VnubCWtaXT70j6TEwLVEitgjZQLNN1FFOpgHZitroreO7Mi1UEGu6qy8Mo9dJftejBYrV2xlcq1WfniUbF+odkahMCpSnAY5V/winvSgiBTANXeXNxDse+LK409mtbRAq+tHRjIxULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGb67jr+/lphZ8gjfpA3rVk4C9thVi9eVgMoxdEzbKM=;
 b=lR7gvAkAxZnCTJQ6vPpsbBSr8Y2w9PbBXCTuvFDOjcA4A6yY9kZZdIfmjRqH0UKVG0DlamaPCerCH02cFYspoiJP3oHAXoRYk4ap/aCokqOLbH0/dJnoS5I7KJBe9Q8/L3tAI/Ktb1MNZZ0Vb4RUvMjL7gieUtXKZkMDRcD6CyM=
Received: from TYCPR01MB6461.jpnprd01.prod.outlook.com (2603:1096:400:7b::10)
 by TYCPR01MB5757.jpnprd01.prod.outlook.com (2603:1096:400:46::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Tue, 7 Sep
 2021 00:42:55 +0000
Received: from TYCPR01MB6461.jpnprd01.prod.outlook.com
 ([fe80::a91d:f519:509:56f8]) by TYCPR01MB6461.jpnprd01.prod.outlook.com
 ([fe80::a91d:f519:509:56f8%9]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 00:42:55 +0000
From: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
To: 'Xiao Yang' <ice_yangxiao@163.com>, QI Fuli <fukuri.sai@gmail.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH 1/5] syscalls/dup2/dup201: Convert dup201 to the
 new API
Thread-Index: AQHXn/HyJHN7r5yhc0eLCzjmbE8CbKuWw2OAgAD+8pA=
Date: Tue, 7 Sep 2021 00:42:55 +0000
Message-ID: <TYCPR01MB64618BBB4BF106FAF853652EF7D39@TYCPR01MB6461.jpnprd01.prod.outlook.com>
References: <20210902115849.72382-1-qi.fuli@fujitsu.com>
 <20210902115849.72382-2-qi.fuli@fujitsu.com>
 <169c8ba3-fbc3-f628-f5cc-b157d4aada85@163.com>
In-Reply-To: <169c8ba3-fbc3-f628-f5cc-b157d4aada85@163.com>
Accept-Language: en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-09-07T00:41:36Z; 
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=6d29f209-4053-4e3f-85af-c51dbaa9889c;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8f266b2-785d-4076-b368-08d971986e96
x-ms-traffictypediagnostic: TYCPR01MB5757:
x-microsoft-antispam-prvs: <TYCPR01MB5757B849701E6697765B011CF7D39@TYCPR01MB5757.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ifZQiJ39eCmsbo/q73qaF657LDsMb0CQhREgbCOYRWyA8zxJ4gCl4V1ZhUxZY1kp8ausieLAM9TBD7qG0s2c6gndSWlge8DN3d0lxXAtEp07at9Jy9AaaB+QKyMv6GJ4XRrM7ad75JDRbv6NU75m5vqql7SJQrABFTmuKN5uBS8mEHNjFX9diaNRsyY7iTy58M2EMt9vqUddyCvWX5p+3sSm9TLWHX1REmqOCQ3d0FpUzzGByn1mBnFHI8m3tkVdhDlojbod4B+J9vN4Y6YgVTyGtTwsTGyrIcIz6MNGkL0j8kb0wjB7GcdYZ6LJSxOY+f2B2QKFyln1ipRvqQA2HMAk8bED1CHb+Up/upUt0C9LzrAF1fbjtdu/NPaMecUnc2Ytq4sYSIZC3gL/Z5I8jI2u0FYIy/YWkBlxNxvmyMzsdmpmkV/nLK+mXdMkRBd1DAl4qMU21a1KzViVDTH2fgUfgonjBtQeFD4MHTB0DCfUOBZCn91PIyqRBtzakeGvGoe8akGQxQU8kINQ/u9REMX9DHCQ3l8inh20UmCXPvNVJFsLOvkRs7UluzAoZxx0zwtxgDOSMSHX0KDZk3pepFCigCQvVw3p7Y52YMhTc4gXkgVrym/FBKDjva0GpZfJzPNVu6b334JV3kRqWe0IIlwrdmXa28LGKLIKqE3v4Vh3VS44JId8QMobdJyKt4UpsUkLJT8kuUJRtmJ8hJyLXHv2ch+0OBfEImCx3SuaPjE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6461.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(110136005)(122000001)(9686003)(83380400001)(8676002)(38100700002)(26005)(2906002)(478600001)(5660300002)(186003)(66556008)(66476007)(316002)(66946007)(86362001)(66446008)(64756008)(38070700005)(85182001)(52536014)(33656002)(6506007)(7696005)(55016002)(53546011)(76116006)(8936002)(71200400001)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WnZ6SC8vTnFqZ2F3VFVIaFMzVmc0TmdjM0c3c05JLzNYeVgraDZFVEN2?=
 =?iso-2022-jp?B?aVhxaml3SUJxdmEvdzJManJMZ3p3TG5ia2Myb3ZRVTE3T2ZURTN4blJa?=
 =?iso-2022-jp?B?MVY5VnMrM3d5a0RTQ3JtZUt4ajVlVVlkdVlROTRoTkNHRVByZCtpM2hO?=
 =?iso-2022-jp?B?REdNVzVWS0JFQ2Nldy9wWVo2Rkc1Mi9mQ3JOWDVPTVEvLzhaVXBmYmdT?=
 =?iso-2022-jp?B?eHl4VTRqc21NcVU4VWQvQnArKzdObzJxYnhuQW5ERWtuSWwyTGc1WGVR?=
 =?iso-2022-jp?B?REtqZ3VQM0tBazhaVTQyV0hUV1FZZVhNZ1gvZ0FDWjhaeDJnZnRSRURw?=
 =?iso-2022-jp?B?NGUzdGc2a2ErVldKcURQZGw0RE5YQlhGMWx1djJDNHFkbko3NjVRMWdP?=
 =?iso-2022-jp?B?TkFETHAzbDcvYnIyaTkxMmJ0VnJqdGx0dzJLdDZ2TEtSWlpzdGlaTDNC?=
 =?iso-2022-jp?B?cm5VV2dKemd2cTJPYm44cGRNS0NRMWRQbzhZYjg0VGxhWWlPQUVVV3VY?=
 =?iso-2022-jp?B?bmVzYW1xd2JjVU1VdTRWRjZoUkdHdDVDckVWSjF5SjZXSnBzSERyczhm?=
 =?iso-2022-jp?B?dEQvL2h1SGE0QkdJanBlUnJVLzliSUtrUUJXV0xRSmJ0NFV0bWNTL2tQ?=
 =?iso-2022-jp?B?eUZnekhRRFR4OEhrazRQZ0hweXZjeXdieVhEWEhxQ0t1VWo3ZVd5Mk1Z?=
 =?iso-2022-jp?B?UGEwWVVTVmtLdEFTRTFuUVJpOCtwcmR3N0c0anROZVFXZXlPNXo2S0lE?=
 =?iso-2022-jp?B?NE1wZVczRzNxRnhyQXRUZWxpNzkvQi9rVFZpY1BDbWVjWjBHQk9HOVVy?=
 =?iso-2022-jp?B?ZHlidnQ3OWE5VSs4Tk9DcFJRelhlai9Hb0M1SnE4TGtKYUVRVHhhcllr?=
 =?iso-2022-jp?B?UXdaZHdrZWVxM2Vub2lkWXE4SHhQTnh4RzdnOWx2ZEM2S3ZBZ1Q3VEJ1?=
 =?iso-2022-jp?B?aVBtYm5kb0NHMlB2YytLSGx5NjA5cGFKZFdEckdDcTRpRjRWRks4Vjhs?=
 =?iso-2022-jp?B?Z2hGV2I2ZFR3YVJZOFF4YlpEa0JMemF1a1lYTGZtRGN3YUVLTHA4V0Vk?=
 =?iso-2022-jp?B?dWxHTWVVODUvZUdtNmhmdmVBYnNIQ2krZFAzaTJ0VExDRG9QNkthdlFv?=
 =?iso-2022-jp?B?SElHNTVQeS9nMGJZdE5acDV4aUQvaFRNZGphUWVCZGxtRWxHVXl1a0xt?=
 =?iso-2022-jp?B?dzM1cm9ZQy8wL05aY0JadTM4eWd0U0hQRU1vMUpYZVdOYktBTWlQVVpT?=
 =?iso-2022-jp?B?R1ZnL29xVWw3dzNzS2Jya043b3BhZDlRMnY5Sm1mbWRWK0g5N1RhNjl0?=
 =?iso-2022-jp?B?cDhyUklDUjNvRStBaUJwQXRPL1hzcnYvNEdlWGJZd0MzM2g3eHBsMWZ1?=
 =?iso-2022-jp?B?MGFYVS8yRElyYzRMRmx0YVlQOHByMVBxb1BCY3JiVlQxZlJFeDVMWWJj?=
 =?iso-2022-jp?B?dXRpdmNpaWFaR09wWlVsaXRVbHgyUnZsUm1UNEJFbjZ6Y3RZUkI1Y0Y1?=
 =?iso-2022-jp?B?T0U2MmxmRWZBZEdDcTFIdEh1NXkzM3JJRHZxd2dtUm14NVlZVXZuNUg5?=
 =?iso-2022-jp?B?bkxIa1BpcWNGemlQRXlnMXhBVE1jN3laZWVnaGZiN2h1b2lTcVpNaTBi?=
 =?iso-2022-jp?B?b0x5SzdCelRHNEFKdEw5MGdVb25yRm1yMnFiYnA4S1ZzL3hJZHIvTkNF?=
 =?iso-2022-jp?B?U1N5VFZGejJ2VUR1ZjB3UTExT2sxM0d1QVBtbTlTc2FFTmtmWmNpQ21E?=
 =?iso-2022-jp?B?S0pVb1FITjBRZUxveTFZMnpwdHNJa01ZbEc0SkZqaEViZ0U0ZWIwM0c4?=
 =?iso-2022-jp?B?NmVBZ1N6K2REWTY3dkd4MnMxdXQxMTdRQk9MR1ErVXoyNGRQbVpzK0Vz?=
 =?iso-2022-jp?B?RmNqVHBXU3Z4TnhwMjlwdG1TV1NrPQ==?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6461.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f266b2-785d-4076-b368-08d971986e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 00:42:55.2699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qpfSUvoaMfkQxMu3zjDHpVgAVMOudg4X+Og/4Mi1Hf8D8peZzP09H2j6x7y3edrF2+DZiRGNeLZDp712+NtZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5757
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 07 Sep 2021 11:31:53 +0200
Subject: Re: [LTP] [PATCH 1/5] syscalls/dup2/dup201: Convert dup201 to the
 new API
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
Message-ID: <20210907004255.WZa6HuLH-VDENVkyz2C_sNeIc88CDknLZ6XM-FT0fBk@z>

> Subject: Re: [LTP] [PATCH 1/5] syscalls/dup2/dup201: Convert dup201 to the
> new API
> 
> On 9/2/21 7:58 PM, QI Fuli wrote:
> > From: QI Fuli <qi.fuli@fujitsu.com>
> >
> > Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> > ---
> >   testcases/kernel/syscalls/dup2/dup201.c | 161 +++++-------------------
> >   1 file changed, 34 insertions(+), 127 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/dup2/dup201.c
> b/testcases/kernel/syscalls/dup2/dup201.c
> > index 4fa34466a..231c262bf 100644
> > --- a/testcases/kernel/syscalls/dup2/dup201.c
> > +++ b/testcases/kernel/syscalls/dup2/dup201.c
> > @@ -1,87 +1,30 @@
> > -/*
> > - *
> > - *   Copyright (c) International Business Machines  Corp., 2001
> > - *
> > - *   This program is free software;  you can redistribute it and/or modify
> > - *   it under the terms of the GNU General Public License as published by
> > - *   the Free Software Foundation; either version 2 of the License, or
> > - *   (at your option) any later version.
> > - *
> > - *   This program is distributed in the hope that it will be useful,
> > - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> > - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> > - *   the GNU General Public License for more details.
> > - *
> > - *   You should have received a copy of the GNU General Public License
> > - *   along with this program;  if not, write to the Free Software
> > - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301
> USA
> > - */
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >
> >   /*
> > - * NAME
> > - *	dup201.c
> > + * Copyright (c) International Business Machines  Corp., 2001
> >    *
> > - * DESCRIPTION
> > + * DESCRIPTION:
> >    *	Negative tests for dup2() with bad fd (EBADF)
> >    *
> > - * ALGORITHM
> > - * 	Setup:
> > - *	a.	Setup signal handling.
> > - *	b.	Pause for SIGUSR1 if option specified.
> > - *
> > - * 	Test:
> > - *	a.	Loop if the proper options are given.
> > - *	b.	Loop through the test cases
> > - * 	c.	Execute dup2() system call
> > - *	d.	Check return code, if system call failed (return=-1), test
> > - *		for EBADF.
> > - *
> > - * 	Cleanup:
> > - * 	a.	Print errno log and/or timing stats if options given
> > - *
> > - * USAGE:  <for command-line>
> > - *  dup201 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> > - *     where,  -c n : Run n copies concurrently.
> > - *             -e   : Turn on errno logging.
> > - *             -i n : Execute test n times.
> > - *             -I x : Execute test for x seconds.
> > - *             -P x : Pause for x seconds between iterations.
> > - *             -t   : Turn on syscall timing.
> > - *
> > - * HISTORY
> > - *	07/2001 Ported by Wayne Boyer
> > - *	01/2002 Removed EMFILE test - Paul Larson
> > - *
> > - * RESTRICTIONS
> > - * 	NONE
> > + * HISTORY:
> > + * 	07/2001 Ported by Wayne Boyer
> > + * 	01/2002 Removed EMFILE test - Paul Larson
> >    */
> >
> > -#include <sys/types.h>
> > -#include <fcntl.h>
> >   #include <errno.h>
> > -#include <sys/time.h>
> > -#include <sys/resource.h>
> > -#include <unistd.h>
> 
> Hi Qi,
> 
> Please keep <unistd.h> for dup2() and getdtablesize().
> 
> > -#include <signal.h>
> > -#include "test.h"
> > -
> > -void setup(void);
> > -void cleanup(void);
> > -
> > -char *TCID = "dup201";
> > -int TST_TOTAL = 4;
> > +#include "tst_test.h"
> >
> >   int maxfd;
> >   int goodfd = 5;
> >   int badfd = -1;
> >   int mystdout = 0;
> Please add static prefix.
> >
> > -struct test_case_t {
> > +static struct tcase {
> >   	int *ofd;
> >   	int *nfd;
> >   	int error;
> >   	void (*setupfunc) ();
> > -} TC[] = {
> > +} tcases[] = {
> >   	/* First fd argument is less than 0 - EBADF */
> >   	{&badfd, &goodfd, EBADF, NULL},
> >   	    /* First fd argument is getdtablesize() - EBADF */
> > @@ -92,72 +35,36 @@ struct test_case_t {
> >   	{&mystdout, &maxfd, EBADF, NULL},
> >   };
> >
> > -int main(int ac, char **av)
> > -{
> > -	int lc;
> > -	int i;
> > -
> > -	tst_parse_opts(ac, av, NULL, NULL);
> > -
> > -	setup();
> > -
> > -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> > -
> > -		tst_count = 0;
> > -
> > -		/* loop through the test cases */
> > -
> > -		for (i = 0; i < TST_TOTAL; i++) {
> > -
> > -			/* call the test case setup routine if necessary */
> > -			if (TC[i].setupfunc != NULL)
> > -				(*TC[i].setupfunc) ();
> > -
> > -			TEST(dup2(*TC[i].ofd, *TC[i].nfd));
> > -
> > -			if (TEST_RETURN != -1) {
> > -				tst_resm(TFAIL, "call succeeded
> unexpectedly");
> > -				continue;
> > -			}
> > -
> > -			if (TEST_ERRNO == TC[i].error) {
> > -				tst_resm(TPASS,
> > -					 "failed as expected - errno
> = %d : %s",
> > -					 TEST_ERRNO,
> strerror(TEST_ERRNO));
> > -			} else {
> > -				tst_resm(TFAIL | TTERRNO,
> > -					 "failed unexpectedly; "
> > -					 "expected %d: %s", TC[i].error,
> > -					 strerror(TC[i].error));
> > -			}
> > -		}
> > -	}
> > -	cleanup();
> > -
> > -	tst_exit();
> > -}
> > -
> > -/*
> > - * setup() - performs all ONE TIME setup for this test.
> > - */
> >   void setup(void)
> >   {
> Please add static prefix.
> > -
> > -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> > -
> > -	TEST_PAUSE;
> > -
> > -	tst_tmpdir();
> > -
> >   	/* get some test specific values */
> >   	maxfd = getdtablesize();
> >   }
> >
> > -/*
> > - * cleanup() - performs all ONE TIME cleanup for this test at
> > - *	       completion or premature exit.
> > - */
> > -void cleanup(void)
> > +static void run(unsigned int i)
> >   {
> > -	tst_rmdir();
> > +	struct tcase *tc = tcases + i;
> > +
> > +	if (tc->setupfunc)
> > +		tc->setupfunc();
> 
> tc->setupfunc always NULL so you can remove it directly.
> 
> > +
> > +	TEST(dup2(*tc->ofd, *tc->nfd));
> > +
> > +	if (TST_RET == -1) {
> > +		if (TST_ERR == tc->error)
> > +			tst_res(TPASS, "failed as expected - errno = %d : %s",
> > +				TST_ERR, strerror(TST_ERR));
> > +		else
> > +			tst_res(TFAIL | TTERRNO, "failed unexpectedly; "
> > +				"expected %d: %s", tc->error,
> > +				strerror(tc->error));
> > +	} else
> > +		tst_res(TFAIL, "call succeeded unexpectedly");
> It is simpler to call TST_EXP_FAIL2() here.
> >   }
> > +
> > +static struct tst_test test = {
> > +	.needs_tmpdir = 1,
> 
> It seems that we don't need any temp file.
> 
> Best Regards,
> 
> Xiao Yang
> 
> > +	.tcnt = ARRAY_SIZE(tcases),
> > +	.test = run,
> > +	.setup = setup,
> > +};

Thank you for the comments.
I will make a v2 patch.

Qi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
