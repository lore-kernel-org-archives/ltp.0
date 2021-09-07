Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8BFC433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 10:06:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8C5603E7
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 10:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD8C5603E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1F0C3C703D
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 12:06:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B2CD3C2339
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 12:06:39 +0200 (CEST)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA755200C7C
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 12:06:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631009198; x=1662545198;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=C2FFdUOVBtZpd/wlIMpwOLOuDcSV9svsclN0LChbY64=;
 b=SXj75RtNviLMCQRY1hh4ugezbYt0CjYnenZEDflfckNqLSX7hWddP9dK
 aLjfHhS5nZHflPm5SP64J0hwr4Yt3w4K+qLW/cO5/9Kt6d1l9mqKUGako
 GwNJRXK2SKnnWbs71Case0TS4ne0by4IS5wRax5h1kYWkpYUJgALb+P6n
 vt8Aov/x5dwrnj+l3Gn8iYKTE38S6k5J1IjSZ6PRXGbvsOvPkc148paPm
 mdphmVHPl9kC0Yqz5+K7JFP5m8OQSlCdXqkEF4h6yyz57zc5a/OiAL4Gk
 bJWl+vlWYrbe3aYa+m/Q4gIzJ3/lnPi4/3iRHU43IOnKKiCnuw8ITy4JB g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="38644241"
X-IronPort-AV: E=Sophos;i="5.85,274,1624287600"; d="scan'208";a="38644241"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2021 19:06:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c81ggOmVSVSH6x7krjHACtPPK7g3o0puGYg8sS3cFX2Ab5Uhfl5ma9uw3fqSWxwUKFKs42F2eW2yE0KK1yQKoQw/3RfmcLiOLQtgjOOil+aIxnI+Ttq9oab+jtN77VVC99RJZBy9hu6Lku5aM5bWPu22LL3+nCVyCT1o3j/JxjCaG+Cn7+BegTvMzrNcGdEvbKyioDqjPoD6N29yqXVS7JW9TN78o+NEnRcaJbmNaPRNBQ1BgFYctLUe7zK0HeZZ1jPeCfzB41G19wCV3bGjSQNNPT+K9oyXk0vvkXkR9If6xNyWog1nFr02ecZYZDxi7+DqzAe4DP0CRN2/XnVZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=C2FFdUOVBtZpd/wlIMpwOLOuDcSV9svsclN0LChbY64=;
 b=NJxEKlvB/Bi+73KxxKc8s4Ij3JznqtKEhDPYc/OGSyXwf0QS2q13pTtnfoRpEuy4CHG6aTIW+vLyJDHCzcKUxRbwz6+d7uhOnlOCHYOqJCV0Vlj+kQPTEfOOWIa62EJWd9TC3LpsmSxBKlOml75hFXDmmDv8rj94QxfUaev2cHEmcQ6P1ubNb3MrKBHHpDAXlUr7ZtE+/Pgdkq63HzI6JSokerZOudblYXdXXkLceJ3SgkT9cp9snXW3fMP75jWCm9nbFji+WLBDd8NKnM9DNp4X0Cf6zktGD6uo82Rrvq9ZfG9sWIzYSP/PKGy8jMh9gnH4uLZ5KK2X1otUXGOg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2FFdUOVBtZpd/wlIMpwOLOuDcSV9svsclN0LChbY64=;
 b=jsE4lcB8nXHO1H6MLqWSVE4WUP3BePoldZaiqJfiwv7TYi+2xwInQrcrcdpr9S+kprmYBmMUWjklxabuOb0v678RFL8mOWqI9SX36PSwbGTSpWeTNQOOKk7uqZ1VLescWxqa18CIOV9mgDzN75R9aH9qzchyg9qy2xCkwXi2EuI=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB6737.jpnprd01.prod.outlook.com (2603:1096:400:b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 10:06:33 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%6]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 10:06:33 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: QI Fuli <fukuri.sai@gmail.com>
Thread-Topic: [LTP] [PATCH 5/5] syscalls/dup2/dup205: Convert dup205 to the
 new API
Thread-Index: AQHXn/Iddlcty1kbZUeesnkvHcvT+quYYDgA
Date: Tue, 7 Sep 2021 10:06:33 +0000
Message-ID: <613739B2.8020801@fujitsu.com>
References: <20210902115849.72382-1-qi.fuli@fujitsu.com>
 <20210902115849.72382-6-qi.fuli@fujitsu.com>
In-Reply-To: <20210902115849.72382-6-qi.fuli@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a2c958c-e43a-4b4e-5992-08d971e72bcd
x-ms-traffictypediagnostic: TYCPR01MB6737:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB6737A1A85840FD9140E2662FFDD39@TYCPR01MB6737.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JAWyejnLVRoRFb1hgqV/qJIuNTHdmH4FkadJ3xcKISlvX8ZNJALwBA0EFI3dGhOWl+eli38PPw+yQIg0WoIYOP43sRYGTvyrhfkfImmN28dIe2zr5mclFzJ8OTfOv5KQ2SXtkVb3bPUDjxHUAOsRpYs/VgK7wA4PzfSm7CtFZw6d3nnIDLlgzW6TZzUXpIAzh/H4k+ZlnkYQAW2yL+SocaN0YlQqsmfq5MjSAVqyp/a4k1vOTBXTzgZj3gHUEB0huSx856UMrzlN3CHzvSptUYTXkTMPcw0IcvUMrERDstpgTLQ8be1+yrYhvW1MFW5z1wRfVroMtZkrHUWmXdit54jLRjkmag7hKvRQlL6ZhjMRAtIEpTzlo4+HEa2K06SZM/S1ViJENPAqdxqK3EhlQi8LIj+mHI4mXQIb/VVeV3ismqml7zI5DkDi7PbAa7WbSoAHgFeYodHnWpT07kY5Tn4nXoioiT2SQ9hfHLcGMM4A6rqbeaeha7IUqV5w2JdA/EAFl2GBMo5gxeHir8ULPr+EmWYrIyjJmFp0YYeQxHcpjkkIXxuKBBDrCF8Q3SJJ4TP/+LgE9YjIikzlptAhDSMhh8Vkhs+qmgLVF+CozKOn49qIgM3+Y7BlXuoBKMfKzcSxpbaosAcYoZy9R4+VRWLQxYWbYGkJvGe04DXfPYGkTs+DQgwb9ag+k3ahyQx6uENANXJlpgAn2FB/FKKHXP1bkOFkSFmF70aq0twskYI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(122000001)(38100700002)(83380400001)(2616005)(6916009)(2906002)(6512007)(478600001)(26005)(4326008)(107886003)(87266011)(33656002)(186003)(54906003)(316002)(38070700005)(6486002)(5660300002)(85182001)(86362001)(36756003)(66946007)(66476007)(8936002)(66556008)(66446008)(71200400001)(76116006)(8676002)(6506007)(64756008)(91956017)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RDVNT0VBeUt3UnRZY3FIYmNGVlpzRjJncXViUTJMbGNyU3hiSXV1blgvV1Z4?=
 =?gb2312?B?OUdHTE1aM2hSbC8vWEFSSjBydmVQQVNPWnNyT0VMN09nT0JjNWJyNlg5dGhr?=
 =?gb2312?B?d2FMamtINDRyS3RPU1FZa3daNEoxaVBiU3NJcEFBWUVIRkE3cC9JUG1HZFNj?=
 =?gb2312?B?REVYWlhnQXNSdC9VYUxML1FPL2V4RmlxQTBQeGd3T1pFMHhRVmFoTFBLTzRz?=
 =?gb2312?B?SGppN0NybFArUmJ3RjZLc1FEOVlKczJLbVo4L0ZscEcyUXYwdHNtSE8ySzk1?=
 =?gb2312?B?VlppRXlwaDJEYkhsOHltTWphYmVYdEZCNTNYVnQyVGVPdTROWDlEbDV3UkNz?=
 =?gb2312?B?WW13ZFpmOUt0anBTYW1FbkRyR2FESnZhQVVxNC92M0Jpb1pScVJSZWJHSGFt?=
 =?gb2312?B?SjJJYTNuUFlUbVpWUkZyS0ZTbU1PS2U0OFZmVjhuakFmb0RZQTNpUzB1aUcz?=
 =?gb2312?B?TVpZcUxGMkRsd1RiNVgxTWVvN08way9YSFdkTExuMzNSMkllZTVBSlZjZUZl?=
 =?gb2312?B?bkdwZFF4NnpDSTdnRGdrby9rdWpwN2p0OTlaN0h3ZGY5ZG9VRFplNnROVnp5?=
 =?gb2312?B?K2FzSUJWWHVmQ1NNTjNGalJxVFl4TnRDM2dnR3piMy80WUZBRWFlOUNraGtI?=
 =?gb2312?B?S3ZSRWowUjdabXM5MkVUa2pnQXVNcTk3RktZY3R0SUJHOTFqOVVOajVrZlJz?=
 =?gb2312?B?enBNNlhSNzVMQ1hEYUNtYStSR0l6d1N3aW94S0R5cE5lVEJOQXltYndmb3g5?=
 =?gb2312?B?eWdNWklZOW1pK014WmQyMnlXemJSQmJRcVBLeG1mVVJCdWROL1MrNGtqV3hy?=
 =?gb2312?B?MmpWV0VNZzlXZkRmTmd5QjBZc3hwR0YvZzhPU2RWUXdwL2pGWVF0ZDVReUJE?=
 =?gb2312?B?ZU9rY2NQanh3bnVXaU85ZFI4a1BNTWFmWXh2bTVVZzQzRFhlbjQ3SWROZC80?=
 =?gb2312?B?aDF5SDBxQW1obThOaXhURWFYRklmQ1EzalJwSTRWR0VRbWhXM1VrQ1FrVEc2?=
 =?gb2312?B?S2VqUU12cTJyRHMrKzV5OExPbWZKZFg0d2gwRmpEMVdKTVVxMHJjM29QRjhY?=
 =?gb2312?B?T3o2N085NFJxV3dLWVlnMWdBbTJSYVVRTjNCdW1RWDY2TmFsZ3IvYzJpM01P?=
 =?gb2312?B?aTh4OXA1TnNtWTVVYmhPZFlhblRFUE5McTUvQTRzVEFrOW84eGphMXdWaHlC?=
 =?gb2312?B?dG1ZODdoR3NzME5DMXB1VXIwRHg4QXl2R3l0RVdvREVTYVRZblhmNTdISExX?=
 =?gb2312?B?TjVFMVZaQUpPaDZZTzFJQ25DUWVxdlM3ejVvL21EaWcvUzJ6YkF1Y0ZuUEd1?=
 =?gb2312?B?UTB1MVkzTDFSNURhSTU3dWxkTk44c2tLT2R0VEtFTEF4R0QxNEpLUUZob1pm?=
 =?gb2312?B?VWFDZGNqckdJcW5lRWlCRWtZeUExZXNsd0lRWVhJMmhGcWhveCthcE9uU2hQ?=
 =?gb2312?B?ZXRZUmo1UEc2R2pyblN0eWsxMVlNWFY3WjBBeklNZDdhMVNFMFpMN0cvZERm?=
 =?gb2312?B?bStjWmE3TUNDTGlncEpKanNBQXNOV3BVUFdPdEtMUnBmMXdRcTdlV1RXNmly?=
 =?gb2312?B?S3N4emNjOUZOZ3J4QTNKejMyRHJhV3YrQVNhVU9FOUF2MGhQbnM4VkRYc1pO?=
 =?gb2312?B?UG1JYjdrZWNlZTFncGVOUkNRMFJQQXhrNFVpWm5Rekp4cVlLRXhaTUVGeXpB?=
 =?gb2312?B?OUJHOXVKSGh3S2VWQ1pUNHhQdkFuVDZGRUNLeDJBY2hBT1BaTjRFdkdmVVRr?=
 =?gb2312?B?a0h1R2ppRnpiZXplbWxhR2pablZEZXpqSTBLaEY4clc2dFhTU0pKNmxrU3dx?=
 =?gb2312?B?TW9WS0pRdHROSFJYOGxndz09?=
Content-ID: <19E773A5BE69104E8D8C2BBB49434E77@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2c958c-e43a-4b4e-5992-08d971e72bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 10:06:33.4593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9jeE58BWMs1j5OXI5gxU/MpwmPV7gl3vT1ls0sZMoY1GFkqflmPOFHECrwVIskcGTg9H9ZFOjhucfOiJflmAvmEN/i1kMPdFY7oYAOl21Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6737
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] syscalls/dup2/dup205: Convert dup205 to the
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
Cc: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210907100633.xYsDO2TITqJ5TJhS7V0nY9cgfBgTphf6eVJQq2ix9QA@z>

Hi Qi

please use safe_macros and static prefix.

> From: QI Fuli<qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup205.c | 165 +++++++++---------------
>   1 file changed, 62 insertions(+), 103 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
> index 0b324531f..30526fda6 100644
> --- a/testcases/kernel/syscalls/dup2/dup205.c
> +++ b/testcases/kernel/syscalls/dup2/dup205.c
> @@ -1,45 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
>   /*
> + * Copyright (c) International Business Machines  Corp., 2002
>    *
> - *   Copyright (c) International Business Machines  Corp., 2002
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
>    */
>
>   /* Ported from SPIE, section2/iosuite/dup6.c, by Airong Zhang */
I think we need a comment for this test's aim.
It looks like dup205 checks whether hit the error when we just consume 
max open file descriptors. And it is similar as shmget03/msgget03.
>
> -/*======================================================================
> -	=================== TESTPLAN SEGMENT ===================
> ->KEYS:<  dup2()
> ->WHAT:<  Does dup return -1 on the 21st file?
> ->HOW:<  Create up to _NFILE files and check for -1 return on the
> -	<  next attempt
> -	<  Should check NOFILE as well as _NFILE.  19-Jun-84 Dale.
> ->BUGS:<
> -======================================================================*/
> -
> -#include<sys/param.h>
> -#include<sys/types.h>
> -#include<sys/stat.h>
> -#include<errno.h>
> -#include<fcntl.h>
> +#include<stdlib.h>
>   #include<stdio.h>
> -#include<unistd.h>
> -#include "test.h"
> +#include "tst_test.h"
>
> -char *TCID = "dup205";
> -int TST_TOTAL = 1;
>   int *fildes;
>   int min;
>   int local_flag;
> @@ -47,88 +18,76 @@ int local_flag;
>   #define PASSED 1
>   #define FAILED 0
>
local_flag, PASSED,FAILED macro are useless. We can remove them directly.


> -static void setup(void);
> -static void cleanup(void);
> +static void setup(void)
> +{
> +	min = getdtablesize();	/* get number of files allowed open */
> +	fildes = malloc((min + 10) * sizeof(int));
> +	if (fildes == NULL)
> +		tst_brk(TBROK | TERRNO, "malloc error");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fildes != NULL)
> +		free(fildes);
> +}
>
> -int main(int ac, char *av[])
> +static void run(void)
>   {
>   	int ifile;
>   	char pfilname[40];
>   	int serrno;
>
> -	int lc;
> -
>   	ifile = -1;
>
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
>   	local_flag = PASSED;
>
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		sprintf(pfilname, "./dup205.%d\n", getpid());
> -		unlink(pfilname);
> -		serrno = 0;
> -		if ((fildes[0] = creat(pfilname, 0666)) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "creat failed");
> -		else {
> -			fildes[fildes[0]] = fildes[0];
> -			for (ifile = fildes[0] + 1; ifile<  min + 10; ifile++) {
> -				if ((fildes[ifile] = dup2(fildes[ifile - 1],
> -							  ifile)) == -1) {
> -					serrno = errno;
> -					break;
> -				} else {
> -					if (fildes[ifile] != ifile) {
> -						tst_brkm(TFAIL, cleanup,
> -							 "got wrong descriptor "
> -							 "number back (%d != %d)",
> -							 fildes[ifile], ifile);
> -					}
> -				}
> -			}	/* end for */
> -			if (ifile<  min) {
> -				tst_resm(TFAIL, "Not enough files duped");
> -				local_flag = FAILED;
> -			} else if (ifile>  min) {
> -				tst_resm(TFAIL, "Too many files duped");
> -				local_flag = FAILED;
> -			}
> -			if (serrno != EBADF&&  serrno != EMFILE&&
> -			    serrno != EINVAL)

  {
> -				tst_resm(TFAIL, "bad errno on dup2 failure");
> -				local_flag = FAILED;
> +	sprintf(pfilname, "./dup205.%d\n", getpid());
> +	unlink(pfilname);
> +	serrno = 0;
> +
> +	fildes[0] = creat(pfilname, 0666);
> +	if (fildes[0] == -1)
> +		tst_brk(TBROK | TERRNO, "creat failed");
> +	else {
> +		fildes[fildes[0]] = fildes[0];
> +		for (ifile = fildes[0] + 1; ifile<  min + 10; ifile++) {
> +			fildes[ifile] = dup2(fildes[ifile - 1], ifile);
> +			if (fildes[ifile] == -1) {
> +				serrno = errno;
> +				break;
>   			}
We can use test macro, so we don't need serrno variable.
> +			if (fildes[ifile] != ifile)
> +				tst_brk(TFAIL, "got wrong descriptor "
> +					"number back (%d != %d)",
> +					fildes[ifile], ifile);
> +		}	/* end for */
> +		if (ifile<  min) {
> +			tst_res(TFAIL, "Not enough files duped");
> +			local_flag = FAILED;
> +		} else if (ifile>  min) {
> +			tst_res(TFAIL, "Too many files duped");
> +			local_flag = FAILED;
>   		}
> -		unlink(pfilname);
> -		for (ifile = fildes[0]; ifile<  min + 10; ifile++)
> -			close(fildes[ifile]);
> -		if (local_flag == PASSED) {
> -			tst_resm(TPASS, "Test passed.");
> -		} else {
> -			tst_resm(TFAIL, "Test failed.");
> +		if (serrno != EBADF&&  serrno != EMFILE&&
> +			    serrno != EINVAL) {
I don't understand why check three errnos and need a comment here
On my machine, this case fails with EBADF.

Best Regards
Yang Xu
> +			tst_res(TFAIL, "bad errno on dup2 failure");
> +			local_flag = FAILED;
>   		}
> -
>   	}
> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void setup(void)
> -{
> -	tst_tmpdir();
> -
> -	min = getdtablesize();	/* get number of files allowed open */
> -	fildes = malloc((min + 10) * sizeof(int));
> -	if (fildes == NULL)
> -		tst_brkm(TBROK | TERRNO, cleanup, "malloc error");
> +	unlink(pfilname);
> +	for (ifile = fildes[0]; ifile<  min + 10; ifile++)
> +		close(fildes[ifile]);
> +	if (local_flag == PASSED) {
> +		tst_res(TPASS, "Test passed.");
> +	} else {
> +			tst_res(TFAIL, "Test failed.");
> +	}
>   }
>
> -static void cleanup(void)
> -{
> -	if (fildes != NULL)
> -		free(fildes);
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
