Return-Path: <SRS0=QfDu=OG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B7C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 06:30:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F9F60F6D
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 06:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92F9F60F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6079C3C897C
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 08:30:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16C123C1D7D
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 08:30:36 +0200 (CEST)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B92E46011E1
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 08:30:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631773834; x=1663309834;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=5kSKoR/v1gQjdt8s2POjpfFAYn4t+ylEnmJT49Riv7Q=;
 b=JHoX+kUy+aUCbAjpx47c/WUuOjmwrt8Pl4TAE4CJ1KVMaoAekmi0SNCa
 6d+TNcZ6eYJU1Xwzr/lf0zfxEjFln4BBjQ8k0Y2NMteNTb+F/QmbddHE0
 vflHgRyA3QBQBm+nuNo0f4S6rhME9RbPYGkw2MFc8hqw5Ktotn7D37aIo
 fG1owcZFCPJ3UtPskzJh+IeQ6KzSBb+UCiq70pDBnhGtVNu9law8GaGqK
 LbCUSFsDAg+alsdyymyRS+9l4Q3cJE5mY6YLmd630VQ6/g72oIHvYcqFk
 HLhJjlIFPnK9VRjwNHm8RluLaiItwcTdsT8dnVQrai/oK/OohT/Ol00y7 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="39178132"
X-IronPort-AV: E=Sophos;i="5.85,297,1624287600"; d="scan'208";a="39178132"
Received: from mail-ty1jpn01lp2055.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.55])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 15:30:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWEyMTiJsOP4NKWRGztyu2cKUQYVuPGSyAYE64QWJYX06OsCg9P4ISmN2kVTIhmV6uNVBwRFe3t1t8q8PPt5CLOy/CHxfy2AAyNTIeqVnSa+/PJOcgnq6/MXzRXFsFbwSUsejsQ5FQQ5gnjBN5pDYBjNuDqrIbeXfmjlteT/0/OKL0kU/Vo/HJ652zsmnfgSr89LKhAVjbOyRnA4hO03Kb6AKfQ09WfqxKGWHWKAkGilAkb2PhsWTqmBRxBlwA2CJeB4/4wniIOuWKDF4ro/fEBRVrXV01uA2ziP9NGnpJLhDr+6jwiHxmEi5VmIKCBmvoNnaAC7CwKpdrlu3BuBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=5kSKoR/v1gQjdt8s2POjpfFAYn4t+ylEnmJT49Riv7Q=;
 b=l//+cmDXpVxDsvqwNkFfrbyuYznmN0aXxh//q/hoFF2Zx4CDz8qoQAGDnuV52zdTMc3pIhWt+iolAso823Lcic/lVG8TUypnRuGrQt8I3POBK8KCxwcvFDoIsNoxqinwxLUZHfqHVEpyrb2GiEPnPezKVSy/b4Y8d6ef12Jg3XOveCE3CQAIlV9CeAknApPWEBFN1c8nupzjdVwIRHKyYQGmL9DvcjQhdecziADKRUGnmXRgwXBi2Gc30prHc8YA/1MRXwHm8vLov9AOHVDIzcZeIoL1DDM2cEuWFZOm5ETFmoRpAH15hP2i9HXOlHAIAgfc+3yVOsKUq6uOKQxBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kSKoR/v1gQjdt8s2POjpfFAYn4t+ylEnmJT49Riv7Q=;
 b=PbJZ0ECvjC7qxrm9PbUURkXv1ytOTNH7IaHcKCC5PHQeN0S/xgT3s4Y9AsNnBZGQkiv0776Gp2rAao3zRpxYcniLEaBdpWqKPyhmLfUR6HAPi8bBiHXOuOIbeWZ7u7s1W1iIde9g9uFtn/jdyiypRESd68fjKF57XTG0cPh96Bk=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3563.jpnprd01.prod.outlook.com (2603:1096:404:d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 06:30:29 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%7]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 06:30:29 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: QI Fuli <fukuri.sai@gmail.com>
Thread-Topic: [LTP] [PATCH v2 1/4] syscalls/dup2/dup201: Convert to new API
Thread-Index: AQHXqkmzuPctALHUNEq0fTAnFtvC5qumNDOA
Date: Thu, 16 Sep 2021 06:30:29 +0000
Message-ID: <6142E499.8020302@fujitsu.com>
References: <20210915155152.8515-1-qi.fuli@fujitsu.com>
 <20210915155152.8515-2-qi.fuli@fujitsu.com>
In-Reply-To: <20210915155152.8515-2-qi.fuli@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a40530cd-ce42-441f-9f8a-08d978db7a29
x-ms-traffictypediagnostic: TY2PR01MB3563:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB3563B145BED8EC4FEC237596FDDC9@TY2PR01MB3563.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5+/RPEuORgDENnkr0mBC4gp0Dqle8IKpqPRAxIoMTDVQnz60HKB35IyrOEU/vmZIwsacmLj03OeblYrQdLDLGVwBteS3OzWliMZ0Yu7bbI/MEtHxUIEmEBXphwdmm8Zz6k/DgT9IKV//HG5KGk8PMWW81fvA7IhINT/J/fb/fsDyDYCRsQiRXhE8apxVon7Rclj2QYBTDaXcaz+3qvKpiBnUEa0vWHNXF5bxVu2gYj6QwP3L2OyCKCtRBGTqNNYIyJD+ItRsimu1uAlnBPGkU4Igx/A9pySNu8/kjO9+zX/te84iYju9sfUQIyyrpp1r/8Ppuvk3K1vARxBin9IlMjMWfxrJwtBy0EUePkM3oNl6qTpFoGDnI4fVQ9gGdVoM6G2kUn4zck1MNo866IPzvnkGuN387ZcHtaHfvIqUn8Fml2aewo9OWy4r9/cJRs/4z1AWhCcFFX/UfUIHSZikwf7RWm2DThJ4QsAP9F9a7ApqQ3wJh01Sz7rOru5pMKnxVoVorqfr3QbrhmozGXUXgZEVz/AtZMSSHmdsjfhUFyB9NwpTsHPm6N9ojzXGgC5xxcjL4OLkseHT52tpWjrXeYxGV/taGFZvpJETMqqL37AepijYy8qw9aeEGdZ3nN8+TEp/ctM+YpcHxl/iCpldi3/IE5Ap7MSjoDY8KWj3icxwSW4WDgm9z5IF/FMTmUGVxRAAdXtm5qrx0SJRA4HKIW+7sGSV/p+fk1xD7dZcwtM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(38070700005)(36756003)(122000001)(186003)(2906002)(85182001)(6512007)(38100700002)(6486002)(107886003)(83380400001)(8676002)(33656002)(8936002)(6506007)(71200400001)(478600001)(5660300002)(87266011)(26005)(66446008)(76116006)(54906003)(4326008)(66946007)(66556008)(316002)(66476007)(91956017)(64756008)(2616005)(6916009)(86362001)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MnFpVVZxQWs3UDh4K1JTVCtybTdrdEk1YWxKMGhhck9tYzg4aCtJN253Z3Ju?=
 =?gb2312?B?bFBQZjViN3lNMFA3RzBmbE5yMU1YNFF1MmcwalZmMGFHYmoyaHdLb1F1OHFH?=
 =?gb2312?B?K0JPaFpjR3RqeUlDWmMwTysxY0lEbU16Qnk2bG8vck9wVXZ4VkYzMVFjaUpO?=
 =?gb2312?B?S012d0laWmw4WDlpVTFkdmtQUXJ4a3dXS3Q1NXRpN3UrMDNMVFJ1d2o2aXRx?=
 =?gb2312?B?WG1qWk0vQU5nZEJrdEVaRkQyMFhwOVB4WGpFeVZZUjZpSys4TlhLS01SQWo3?=
 =?gb2312?B?L1ptNUFnNk1vb2EybjRUVFM1S3RseU9nbjJtOS9ZY0x3VzB4REFWbjJodVBK?=
 =?gb2312?B?ODBvL05rSFhud3pvUENQbEliMXdpMWNLbHJZYkxqaXJyeEFVVXlRaDFqUEtW?=
 =?gb2312?B?cWMrZENhRy9Zc1Z2TlJXc1JLL2xYZytVN1pmSXFMRXhROUYzYThWWUwxMTdl?=
 =?gb2312?B?ZDhwSExRNFJkS0ZaYWsweTdEcTlTeEl2VWoyOFZFNllsVXppWERqenJDKzFV?=
 =?gb2312?B?ZjRtVnIxVEtYWjFoNWcwSmV2N3VUQ3A2WFd0VVF0aXFZM2ZPdlB3SkFTWGZX?=
 =?gb2312?B?V3FaNk94emFvc2lDeURVKzR4VFllVTJ1VjdPbDY1ak80dGFXNlE5bkdQTVll?=
 =?gb2312?B?RGVRMlFrNGFuUVpnVTlvN3YzRVhJODZnMm1KWWVlU1kzNlNQRUJyaXc3Misx?=
 =?gb2312?B?b05rNjQ4VC9IVE1Xa3drN1dHeXoxbnQweDgxUzNRNU1VekNNMlZPV0x5ZDMv?=
 =?gb2312?B?TTNzUk8zOHpHWlg2QU9LU1J5MW04d2FyV3QyY3hVWXhrd3pyQW5iMGwrS3dm?=
 =?gb2312?B?K1V3UFYxTnNYOUdONzIxeDlISHpWTHdJa1d0Z0t3VU8xS2lIUmtXT1AzNEpm?=
 =?gb2312?B?VG5KVk41WktMRzlXNllXV29PTWl5ZklLdDZEWGJxUjdzU0cxQjhEU1d4YnNn?=
 =?gb2312?B?dGtyZGdzZWo0N0RZaEpiYldSOGlhV0plWnJHenF6dCtvREI0cUZWRjBjeEhL?=
 =?gb2312?B?NzdGZ0d4Z0tZVWppZzArV0N5UzBTcVNtNk1kY3RmN0JEK1NXeUVYTllGVUJ4?=
 =?gb2312?B?OWZyVThtK2hFSkltRUJYYUpHZTlabnpGR1lVdEU3TmhLZXRoai9HU1VibzdB?=
 =?gb2312?B?Wm9GRzFXNjB1L3gwb3FBcWUrb3dkQXhvMDgzc0lhT3NmemI2MXl0UkFtODB3?=
 =?gb2312?B?QUhKbFNhb1gxWVNyeS9reXVBV2J5TlRtTHE3ZnZNWHlhMnB0bUhsUzArOTAx?=
 =?gb2312?B?N1prRlFENG9TcXJLeWVvMGsrUkc5Zisrd3BUWU4vZ2VIa1BwRU9XMEQ5OVFU?=
 =?gb2312?B?bllzNlVtYmN5QUVubXBTRWxuUjJuek9kWWs3ZjE4NnhhZjdQWXplRDZab3FH?=
 =?gb2312?B?UmxjT2t2QTcyak1sVmVrek9WcVVMMTdpZ0s1T2VtZ2F0TlFxNTlKaFdocTFz?=
 =?gb2312?B?V0tzbjhGUkdDNTgyZ2ZrellBYTRpYlBuQmUxQ25VMjZMQnd4aWxBNTN4M293?=
 =?gb2312?B?WVFTNFRWcE9YYUNqTWoxSG9kMkFLM3JvNXhGdzFYa3hiVFhLYWNIQkVXckgw?=
 =?gb2312?B?bG94aDFLeENraWhaTld2d0RqVHA0d0tTWVcyK2JERzhOdDB3MnhWVDYzZUtU?=
 =?gb2312?B?Q2VDejhIcmlsV0x0ZUN3MXJpdzBVR051MGt3SXFtMG53R3pnZzUweklMYkN2?=
 =?gb2312?B?blh2aE42L1Q1a0lReDFuUG1ESjE0VUl4S3FEOGZTcTVsaUZMQjlPRmgxNkQv?=
 =?gb2312?B?dG15M25pWFVITVE0MXhmeEFta09scGQ2OGltcjl2VlRSdTJ3eEhOcTB5aFR3?=
 =?gb2312?B?REJSMDFFMTlVTTJieTY4Zz09?=
Content-ID: <B0D5E788D1B6174C95E2FB8B94253F8F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40530cd-ce42-441f-9f8a-08d978db7a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 06:30:29.1667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvRgsRpn3n5puJoiWd6lJLdVZQPMZEM9DQOSVmGr1q2K7a1ZWVAtYMCygoRGMHjSknuDKnGszFD5kPquAk1TN0W8d9C+O/+Id07xjSryflk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3563
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] syscalls/dup2/dup201: Convert to new API
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
Cc: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210916063029.ImIBrwnhHYIYRxr1guuk_9H49Pd5QH6clUaVqDMlebE@z>

Hi Qi

> From: QI Fuli<qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup201.c | 174 +++++-------------------
>   1 file changed, 33 insertions(+), 141 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup201.c b/testcases/kernel/syscalls/dup2/dup201.c
> index 4fa34466a..8e47a2244 100644
> --- a/testcases/kernel/syscalls/dup2/dup201.c
> +++ b/testcases/kernel/syscalls/dup2/dup201.c
> @@ -1,163 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
Remove this empty line.
>   /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Copyright (c) International Business Machines  Corp., 2001
>    */
>
> -/*
> - * NAME
> - *	dup201.c
> - *
> - * DESCRIPTION
> - *	Negative tests for dup2() with bad fd (EBADF)
> - *
> - * ALGORITHM
> - * 	Setup:
> - *	a.	Setup signal handling.
> - *	b.	Pause for SIGUSR1 if option specified.
> - *
> - * 	Test:
> - *	a.	Loop if the proper options are given.
> - *	b.	Loop through the test cases
> - * 	c.	Execute dup2() system call
> - *	d.	Check return code, if system call failed (return=-1), test
> - *		for EBADF.
> - *
> - * 	Cleanup:
> - * 	a.	Print errno log and/or timing stats if options given
> +/*\
> + * [Description]
>    *
> - * USAGE:<for command-line>
> - *  dup201 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> + * Negative tests for dup2() with bad fd (EBADF)
> + * First fd argument is less than 0
> + * First fd argument is getdtablesize()
> + * Second fd argument is less than 0
> + * Second fd argument is getdtablesize()
>    *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *	01/2002 Removed EMFILE test - Paul Larson
I think we should keep this history info.
> - *
> - * RESTRICTIONS
> - * 	NONE
>    */
>
> -#include<sys/types.h>
> -#include<fcntl.h>
>   #include<errno.h>
> -#include<sys/time.h>
> -#include<sys/resource.h>
>   #include<unistd.h>
> -#include<signal.h>
> -#include "test.h"
> -
> -void setup(void);
> -void cleanup(void);
> -
> -char *TCID = "dup201";
> -int TST_TOTAL = 4;
> +#include "tst_test.h"
>
> -int maxfd;
> -int goodfd = 5;
> -int badfd = -1;
> -int mystdout = 0;
> +static int maxfd;
> +static int goodfd = 5;
> +static int badfd = -1;
> +static int mystdout = 0;
"static int mystdout" is enough and don't need to assign.
static int maxfd,mystdout;
>
> -struct test_case_t {
> +static struct tcase {
>   	int *ofd;
>   	int *nfd;
> -	int error;
> -	void (*setupfunc) ();
> -} TC[] = {
> -	/* First fd argument is less than 0 - EBADF */
> -	{&badfd,&goodfd, EBADF, NULL},
> -	    /* First fd argument is getdtablesize() - EBADF */
> -	{&maxfd,&goodfd, EBADF, NULL},
> -	    /* Second fd argument is less than 0 - EBADF */
> -	{&mystdout,&badfd, EBADF, NULL},
> -	    /* Second fd argument is getdtablesize() - EBADF */
> -	{&mystdout,&maxfd, EBADF, NULL},
> +} tcases[] = {
> +	{&badfd,&goodfd},
> +	{&maxfd,&goodfd},
> +	{&mystdout,&badfd},
> +	{&mystdout,&maxfd},
>   };
>
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/* loop through the test cases */
> -
> -		for (i = 0; i<  TST_TOTAL; i++) {
> -
> -			/* call the test case setup routine if necessary */
> -			if (TC[i].setupfunc != NULL)
> -				(*TC[i].setupfunc) ();
> -
> -			TEST(dup2(*TC[i].ofd, *TC[i].nfd));
> -
> -			if (TEST_RETURN != -1) {
> -				tst_resm(TFAIL, "call succeeded unexpectedly");
> -				continue;
> -			}
> -
> -			if (TEST_ERRNO == TC[i].error) {
> -				tst_resm(TPASS,
> -					 "failed as expected - errno = %d : %s",
> -					 TEST_ERRNO, strerror(TEST_ERRNO));
> -			} else {
> -				tst_resm(TFAIL | TTERRNO,
> -					 "failed unexpectedly; "
> -					 "expected %d: %s", TC[i].error,
> -					 strerror(TC[i].error));
> -			}
> -		}
> -	}
> -	cleanup();
> -
> -	tst_exit();
> -}
> -
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void setup(void)
>   {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
>   	/* get some test specific values */
>   	maxfd = getdtablesize();
>   }
>
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *	       completion or premature exit.
> - */
> -void cleanup(void)
> +static void run(unsigned int i)
>   {
> -	tst_rmdir();
> +	struct tcase *tc = tcases + i;
> +
> +	TST_EXP_FAIL2(dup2(*tc->ofd, *tc->nfd), EBADF,
> +			"failed as expected - %s", strerror(EBADF));
Since TST_EXP_FAIL2 macro will print errno number and string automaully.
We don't need to print the duplicated info.
your info:
dup201.c:47: TPASS: failed as expected - Bad file descriptor : EBADF (9)
dup201.c:47: TPASS: failed as expected - Bad file descriptor : EBADF (9)
dup201.c:47: TPASS: failed as expected - Bad file descriptor : EBADF (9)
dup201.c:47: TPASS: failed as expected - Bad file descriptor : EBADF (9)

use    TST_EXP_FAIL2(dup2(*tc->ofd, *tc->nfd), EBADF,
                        "dup2(%d, %d)", *tc->ofd, *tc->nfd);
info as below:
dup201.c:47: TPASS: dup2(-1, 5) : EBADF (9)
dup201.c:47: TPASS: dup2(1024, 5) : EBADF (9)
dup201.c:47: TPASS: dup2(0, -1) : EBADF (9)
dup201.c:47: TPASS: dup2(0, 1024) : EBADF (9)

other than these nits, this patch looks good to me
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu


>   }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
