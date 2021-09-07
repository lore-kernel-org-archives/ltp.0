Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF355C433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 09:14:31 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB3D61101
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 09:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBB3D61101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 617023C3174
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 11:14:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C23E3C222D
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 11:14:18 +0200 (CEST)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 96846600CFA
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 11:14:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631006058; x=1662542058;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4Cri2pv/GpytaiyK4GzMDY3TWQoGxHZ20OHUVMrL5WM=;
 b=gqA/1+9bR0v80bM4FmJQqq6dE50InHgei0VeoiJpk7FAsd13JkK/ADRY
 mRgdxipkUZOl2na0UYRi/2Dh1Nj578Kw664H3EO1qadxCSfmjnzXV6EhH
 kItUqWIuyMPskt0tpZGH7FLdqszZO+8BkfcLF2OQzGD/6g100/R/pbKyq
 p7gBDDGM1b2NbgfT62NWfXzV4qx/KG+0akZibwXw8QWGAZTTz5r/xCbkS
 pGwV8sxcdLIr22EkEOisvam5jR+cHhqL7kr5cufK8X6Kwv0Egv7L+ZuYK
 KNBkRCc1NPo7J5b6roeKuquTIIL/wHp3k1LWsp/dDb12FCCX2yTTwDaNj A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="38648978"
X-IronPort-AV: E=Sophos;i="5.85,274,1624287600"; d="scan'208";a="38648978"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2021 18:14:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2Z9ZbepCvUJwejb/wluyYwnWDkMGXXic8GtKcjT/sFchYp2Ujn/mrmG8QL5T5z4/hDbFpEwqowecf9tM80kk0BjA60YOl1J/ZHt2vXAQdzhgO5sFeBvLvFguUH/h1HuxD/xaKDO4tf/9/p7T0WxRjQc07ujfWW57DMmhDk+HO1L7mz2c4RHOQqzhst1f8s13QmU/1FnNfSy5/69W8N+D3T6BPcrTRblzScGllQ27VuhPzKo91ydwR8w0vjRtP+z29O1PcxURKlma/01Uls5cbs6plPrs6aLoSCl4eQd2OYyBoIsJhHxqUb8d5TgtwPsMp4v93j8Oe6/esWNJaRy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=4Cri2pv/GpytaiyK4GzMDY3TWQoGxHZ20OHUVMrL5WM=;
 b=N9gcr4q8uH9Wx5LhBXDdQ3t/3Ydw8iJ1fhCYmRsO6I+jUip4endF8gtmNHN920jGNnFV5jZjVr46U4w+vVQr2mHL2zlTrPDPqhT1DF16OS+y42dt/rTDTpxcwvac3gdiYJjhgcHBnyqVU97BHxfV/KNJpiXpIVTmhM0zc15NHVCHfvAJEhJWBJvHHzdEzxJSZC74M4a831cPBvB4lB2k0/Akdtc29+Mt32i1LLbZT/aRQlfCf5upA2IlF/Dwhu6IYP2pG99BDIApQV6NqiVa7hOk/JopRyCslxzezhC8/LLGRuzhzS7bbS10yMGidIvUqA7mdhm/ix/+Nzn8kERKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cri2pv/GpytaiyK4GzMDY3TWQoGxHZ20OHUVMrL5WM=;
 b=Tl2Qf1y8io7rGY7HBG9mlmKPOKCtyntTrhFjWXD7GBOTavLVXaDZKUSetRz8buuIOXf1qZ0YFxxmDcAW/VIDwRUf25EHdubXa/0i6IuWP7Vl7NysCZEgcuXp06wv1qx+y4Sp7GZr82NRo63CAJPE/Fomt6EbCdZq0F+PIXm7yhc=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6282.jpnprd01.prod.outlook.com (2603:1096:402:3f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Tue, 7 Sep
 2021 09:14:12 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%6]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 09:14:12 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: QI Fuli <fukuri.sai@gmail.com>
Thread-Topic: [LTP] [PATCH 2/5] syscalls/dup2/dup202: Convert dup202 to the
 new API
Thread-Index: AQHXn/IE2dyWv4B5KUGElWamHL8ZZquYUZcA
Date: Tue, 7 Sep 2021 09:14:12 +0000
Message-ID: <61372D6C.5020003@fujitsu.com>
References: <20210902115849.72382-1-qi.fuli@fujitsu.com>
 <20210902115849.72382-3-qi.fuli@fujitsu.com>
In-Reply-To: <20210902115849.72382-3-qi.fuli@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3726ed6-c7b0-4063-53ce-08d971dfdb5e
x-ms-traffictypediagnostic: TYAPR01MB6282:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB6282B42EB58CD7BFEAAF5C2CFDD39@TYAPR01MB6282.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rtyh0mjB0BUEDRbsF9lDE/CVpedT3eLYjzfJu6xGKHChpbnML4FiRbe0KLP9JfF33gf62h+kkOyTLLBEIWIeWSIIJPRA1kcpl5mwKbb6GUS3iTjzvcbmuS03uLQnAZH8Db4EOY8XDW433jbdanIx/Z8PanTgTbXNTSq+nRN5ZXVJ3oL1mcJzUoAf7t1OgIQwN93NqxRX5UpqAFrqkf6vtOG7bkI/mBx+5Yg0isKdBhN+GFXxkpGCWp1sEr5wN4KdlMVX4SBIM715hs/v1iBrN37k6mFqDCk3+iUlNsiO++C+n3Q9/aS/u9W4Pkt9MLbxoukfXHEtc4j7k0nlaLe4E6iBD8pidtzWoHxnc2/yJcYcGOlYnekxV4hpXvL2CM1qqxdQ3Vok1ohqxYRxco7VO8gdSwhLvBgJkwPxbqbnsJ0AjqMCj6mQCjS5GLK+fkasfe0jfkaR0Vt1bYsCUH4LUUCqWCcj/jOCYubYFwMMC1WaL420VNKD69IiHLb1RIiYkW/RArBUf5/8ektSlUk7X3eeZrgxa2cWKVONtQEiqGX0ov14DRlVzlbbMk1JQ0UeL14QPXYCH1jaYcFSkV+9Te+KmLneD5dEqQuSZAWMUT4/OKw3v8W1HoqUOoxtO9mRWiY05/R2x7new0T2z6nHJbsM9PmBbCdPxTwxXFClLeERa6R7hR0WgVuuci/9n6+c0Xc0n2LZCtgPHzHlyyJBJSEmB5LZmY00YQVv/XaB6qY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(91956017)(66446008)(64756008)(66556008)(66476007)(2616005)(85182001)(6486002)(66946007)(54906003)(6506007)(2906002)(76116006)(186003)(6512007)(71200400001)(26005)(86362001)(33656002)(478600001)(38100700002)(122000001)(83380400001)(38070700005)(6916009)(87266011)(8936002)(5660300002)(8676002)(4326008)(107886003)(36756003)(316002)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MUowVmxhTXB6Ti8xOGIrRy9DQk9keFg0b2p3dWs3M0kvSmtlUktQWDNNbnN1?=
 =?gb2312?B?L3h3bXZ6ZzNCeW94VkI1WjAxWnZKUHFmYnN0ZmNWcmxhVDNWdFdTbVdxcE84?=
 =?gb2312?B?bTYxaDJpb0t3L25tSFNhWjVmMmlmWUVtMU45TnBjTXZyakVZUXpUMmlnNHZ6?=
 =?gb2312?B?S0NweXA5RFhxcFdwbmE0UU54dkJMYmFsajRONlcvRXZ5c3hFTWlDdDhmbjk2?=
 =?gb2312?B?YlhKWXVRbEZmOE9LS3ZtYXVIYjhkeHg0RWdIQ21QVm1ZZ2FZdWZCWVFYbk9k?=
 =?gb2312?B?TTM3RFN6TFNOSHpOdTBtVVNGbFVWa1NlY2IvN0FQbUxrQ2xVdklOa2wzWGxR?=
 =?gb2312?B?SDRJaVhiWUFHL2R3c2RmallvVVRrVERZWC9nNVl6ZkxuWXVDQVoxSUVkalRy?=
 =?gb2312?B?dlBjaEZSTXdza0NSUjhpSUFrR1hrWHJHcFFwd3Q4MTVpc1ZyWkNGOEh2OVQx?=
 =?gb2312?B?a2crZ084bFpFcExCYjVPRWRubnY2aC9EakhHK0l2UmVaU1dKNVlLKzdjMU9Q?=
 =?gb2312?B?STZJSHQ4RXE4c0Q1SmtrUmpDME5GYUkycU5XNUh6a0QwMlBpVzJvN0wwZHpM?=
 =?gb2312?B?SHZTNmJBNmgwejhvWEZtaStWT0hTSkNTRTZQZS9BVkk0YVM2QlFZaXQwanVw?=
 =?gb2312?B?RWEvK2dDMU8zdXlUZnlmdS9TU1JVQ1lYdXlQaXdMdlJDUlNkUjZJaGlYUXdD?=
 =?gb2312?B?SDRXNlRabW5ZZVVTOEs3YjVvQmJ5T3RSWDAwSDZwb21wSVRjOTBTN3pCZ2JB?=
 =?gb2312?B?Q3dPSmJrbzhpT3ExMVdyMGhsSk5qbmtFY0pxN2RnOGxicHlwdGx3Vm14Zy9y?=
 =?gb2312?B?dXdXNnhBK0RwNlFmOFB3Rkc0eE9yOTNobkxqMjE2RGVjSVJYWGE1Rkt1cDA0?=
 =?gb2312?B?MEllK1JVMEF1RmdoYmNtbUE0czYvWlVoRkQzVmprYjZpRFkxeGJaRVJ4QkMv?=
 =?gb2312?B?YlFmTTI5cUgwb2YvYnJoMnIvTWRqL1NjSEZkbnJ6aWZoS1VndkFmblh1NU9v?=
 =?gb2312?B?TzY0Uk9TRTYrTWhpQ0dnL0tiSW5VK2RoREl5TGpHT25mVVZYWGhtVWVIdEZz?=
 =?gb2312?B?K3dEb3ZvSzdSRXBVcExJNTNSRldOUlQ1SWtONW53V3c1RlRBS0lsREoyRXc1?=
 =?gb2312?B?MlNKeGRXYzNyckx3bXNqVmZaaDJqNlNqdFAreTBBS2FjYTQyNGM5amZNa2ph?=
 =?gb2312?B?Q29oOXhhRkhLM3BwdHJjL3J4ZDhiekhNZ21HTHZmdnN2SkliV1o1VjZaelRO?=
 =?gb2312?B?NFgxOVUvTGJCZnVOTHpQazdYVjAyR09PSlBacWV6OVZ1U213OFd4TmNjVjFp?=
 =?gb2312?B?QVd2Z05HaDNZNEdGdmlCbzVoWWU2WjFmMW5PMG9XUWcxMmVxeHVydHhGVktr?=
 =?gb2312?B?bHFVQUQrVUhtQkYrQjJUY2Z0NjRMbW1MVTZ3MDd1czJZVjEwT3VyTngrRDY0?=
 =?gb2312?B?aG9EYWlVUktjOFNZdStITDdmbVZsdVo5Z1FCejlrSE9jcVhyTXRCRmJ0ZmlZ?=
 =?gb2312?B?bWNaL2Z6bGJ4NTFueFpVckovQlpveWg3WDRtVGJGQWY1bXF3RWhtM29EMWQ0?=
 =?gb2312?B?UW1yQVpXSGFqL1doLzllSVFiLytUMExaa0t3K1htZHRJVi9wcEJRVnpIQVIw?=
 =?gb2312?B?OGN4Q3FmSEdvZ0NZaWNJUGR1SHRhanpqaWNKMWdrRm11ZFJIa1BnSmhOYnU2?=
 =?gb2312?B?Zk1CZEplTkh1UW56ekVJMUpRLzBacFNscU9zL2dXRXZPZE40NldpRUpzSlE2?=
 =?gb2312?B?MFRTeU9wNG96T1JNMDBYTGVCaFJoWFJqcGt6T09uZm5OdnVocW44WG40Ujlo?=
 =?gb2312?B?OUM1TjJnQmtUS3gzR0piUT09?=
Content-ID: <E1B41456154DCF4298C866A9F6428959@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3726ed6-c7b0-4063-53ce-08d971dfdb5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 09:14:12.0518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2Uw4bZtXxQtJQGl/o/MDYGzvYA+K28QprBa4eOwc/erfRqEI7a6Ll7Am5TgP78aO1KFvZGwO8XFs6u1SAXQQAn3dm7zn5aPvwcNSEB47EA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6282
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] syscalls/dup2/dup202: Convert dup202 to the
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
Message-ID: <20210907091412.gCtBc7LJdQnP0LLyby1tWf1w0lluAih04_U1wxHL_lw@z>

Hi Qi
> From: QI Fuli<qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup202.c | 175 +++++++-----------------
>   1 file changed, 48 insertions(+), 127 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup202.c b/testcases/kernel/syscalls/dup2/dup202.c
> index c87769fa9..16f8b2add 100644
> --- a/testcases/kernel/syscalls/dup2/dup202.c
> +++ b/testcases/kernel/syscalls/dup2/dup202.c
> @@ -1,65 +1,22 @@
> -/*
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
> - */
> +// SPDX-License-Identifier: GPL-2.0-or-later
>
>   /*
> - * NAME
> - *	dup202.c
> + * Copyright (c) International Business Machines  Corp., 2001
>    *
> - * DESCRIPTION
> + * DESCRIPTION:
>    *	Is the access mode the same for both file descriptors?
>    *		0: read only ?	"0444"
>    *		1: write only ? "0222"
>    *		2: read/write ? "0666"
>    *
> - * ALGORITHM
> - *	Creat a file with each access mode; dup each file descriptor;
> - *	stat each file descriptor and compare modes of each pair
> - *
> - * USAGE:<for command-line>
> - *  dup202 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -f   : Turn off functionality Testing.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> - *
> - * HISTORY
> + * HISTORY:
>    *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	None
>    */
>
> -#include<sys/types.h>
> -#include<sys/stat.h>
>   #include<errno.h>
> -#include<fcntl.h>
>   #include<stdio.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "dup202";
> -int TST_TOTAL = 3;
> -
> -void setup(void);
> -void cleanup(void);
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>
>   char testfile[40];
>   int fail;
> @@ -68,100 +25,64 @@ int newfd;
>   /* set these to a known index into our local file descriptor table */
>   int duprdo = 10, dupwro = 20, duprdwr = 30;
please use static prefix.
>
> -struct test_case_t {
> +static struct tcase {
>   	int *nfd;
>   	mode_t mode;
> -} TC[] = {
> +} tcases[]= {
>   	/* The first test creat(es) a file with mode 0444 */
These commets are useless because we have said it in the top commet.
> -	{
> -	&duprdo, (S_IRUSR | S_IRGRP | S_IROTH)},
> +	{&duprdo, (S_IRUSR | S_IRGRP | S_IROTH)},
>   	    /* The second test creat(es) a file with mode 0222 */
> -	{
> -	&dupwro, (S_IWUSR | S_IWGRP | S_IWOTH)},
> +	{&dupwro, (S_IWUSR | S_IWGRP | S_IWOTH)},
>   	    /* The third test creat(es) a file with mode 0666 */
> -	{
> -	&duprdwr,
> -		    (S_IRUSR | S_IRGRP | S_IROTH | S_IWUSR | S_IWGRP | S_IWOTH)}
> +	{&duprdwr, (S_IRUSR | S_IRGRP | S_IROTH | S_IWUSR | S_IWGRP | S_IWOTH)},
>   };
>
> -int main(int ac, char **av)
> +void setup(void)
>   {
> -	int lc;
> -	int i, ofd;
> -	struct stat oldbuf, newbuf;
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
> -		for (i = 0; i<  TST_TOTAL; i++) {
> -
> -			if ((ofd = creat(testfile, TC[i].mode)) == -1)
> -				tst_brkm(TBROK | TERRNO, cleanup,
> -					 "creat failed");
> -
> -			TEST(dup2(ofd, *TC[i].nfd));
> -
> -			if (TEST_RETURN == -1) {
> -				tst_resm(TFAIL | TTERRNO,
> -					 "call failed unexpectedly");
> -				continue;
> -			}
> +	(void)umask(0);
umask(0) is enough.
> +	sprintf(testfile, "dup202.%d", getpid());
> +}
>
> -			/* stat the original file */
> -			SAFE_FSTAT(cleanup, ofd,&oldbuf);
> +static void run(unsigned int i)
> +{
> +	int ofd;
> +	struct stat oldbuf, newbuf;
> +	struct tcase *tc = tcases + i;
>
> -			/* stat the duped file */
> -			SAFE_FSTAT(cleanup, *TC[i].nfd,&newbuf);
> +	ofd = creat(testfile, tc->mode);
> +	if (ofd == -1)
> +		tst_brk(TBROK | TERRNO, "creat failed");
>
> -			if (oldbuf.st_mode != newbuf.st_mode)
> -				tst_resm(TFAIL, "original and dup "
> -					 "modes do not match");
> -			else
> -				tst_resm(TPASS, "fstat shows new and "
> -					 "old modes are the same");
> +	TEST(dup2(ofd, *tc->nfd));
>
> -			/* remove the file so that we can use it again */
> -			if (close(*TC[i].nfd) == -1)
> -				perror("close failed");
> -			if (close(ofd) == -1)
> -				perror("close failed");
> -			if (unlink(testfile) == -1)
> -				perror("unlink failed");
> -		}
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "call failed unexpectedly");
> +		return;
>   	}
We can use SAFE_DUP2 here.

Best Regards
Yang Xu
>
> -	cleanup();
> -	tst_exit();
> -}
> -
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup(void)
> -{
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	/* stat the original file */
> +	SAFE_FSTAT(ofd,&oldbuf);
>
> -	TEST_PAUSE;
> +	/* stat the duped file */
> +	SAFE_FSTAT(*tc->nfd,&newbuf);
>
> -	tst_tmpdir();
> +	if (oldbuf.st_mode != newbuf.st_mode)
> +		tst_res(TFAIL, "original and dup modes do not match");
> +	else
> +		tst_res(TPASS, "fstat shows new and old modes are the same");
>
> -	(void)umask(0);
> -
> -	sprintf(testfile, "dup202.%d", getpid());
> +	/* remove the file so that we can use it again */
> +	if (close(*tc->nfd) == -1)
> +		perror("close failed");
> +	if (close(ofd) == -1)
> +		perror("close failed");
> +	if (unlink(testfile) == -1)
> +		perror("unlink failed");
>   }
>
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *	       completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
