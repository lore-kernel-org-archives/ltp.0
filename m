Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA458C00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 07:41:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A1D43C9728
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 09:41:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 987883C01CC
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 09:41:35 +0200 (CEST)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B1D9C200773
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 09:41:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660549294; x=1692085294;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TIxeXdY1qCz0w0WwYYIplCb82y98ZKAD0vKZBmgfvko=;
 b=ZAK5SqSUO1/LmRmMN7aKHpy6XME8+iHVhwXoQWvZCL242S9CYaRuqW7+
 WQ0Izq8zhMByn2dXbTQGh8mwJVOrLzyyxd+1+DvrW5AiMr5O9lp/4j0kN
 ft2H4s7DC/OdDdDHP5aPAP4I/vzXnX5ud9mXlcKtoHp4UEiSfIqrParLM
 tyHzc1PtIr0UgT2v0rJ22PJWRWbBk0gowwMOFrlQV43FL7H/x3BQ4Jyin
 zemj4gwSixSYokm2XlirKJRioOzJfA2oGPBofDu+WUdMh5NMXjs2cdpBQ
 aepC7FEaXDQOtRaRdctMfGStTr5ljjrbK5hf5bXu4eIzK5MW3hzb96J3f Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="70996603"
X-IronPort-AV: E=Sophos;i="5.93,237,1654527600"; d="scan'208";a="70996603"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2022 16:41:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYXB0JmwbuKIUMY9rxcnyX46N3roj2UxysYpg84/wC8krWDScNM9WdtCq/vOW4rtDhbzx/qwgNtuV07aG3VQ1Pr07kR4kKmqtBtp2LYwyViFMcwi9QwdKfEV4ncyVb8n9k2mSz9HASzg8ZWzvS8xGHtv1QHZR7nTpQtxelofR0tVLA9xou7rMog85w50YXfndNZGYKcO1cUCJ6LTV46w0TModpnNYGcJmhlJCCggLCECGz2Jta2KAQtmpViaTr4yjxEOZCoySq6ah8CNaPC5GvbttWi//sYST5e9QQAmpnYLxIxnGJqPXQxiBcElske7mjebHIzSbO6J+T0epfwYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIxeXdY1qCz0w0WwYYIplCb82y98ZKAD0vKZBmgfvko=;
 b=GvWU+PzR3hv8RlGub/+Ag0aUllW61HrVUprGrmR29TcHZc4YnduShvrV6DvOq0gSxWc1qX6FRgBSOeMMTcnt7khAIgk9rA1Sqkjz80yTNgEGcLjxf+SeUcQyBUlLtmYtWlHF5C17eDcyG+QanU44pXLwQawrHygFnNQNP4VsuGG23U5+ijg5FHm3Zz/rPnEdE45dKy0rUQttHOSzIAj68GYMMEykY/LzNHbVpR3lejxKQtOX0tRsRir5UbfTgeeSwcLHnn6edYReuJ2Onyc6UMsDByebGq0b2Qy3z4McgOEET4INRjljqso5Xb4ouubt9qAm9zm1PHv4fcJmsYhcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB4954.jpnprd01.prod.outlook.com (2603:1096:404:117::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 15 Aug
 2022 07:41:27 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 07:41:27 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v2 2/2] syscalls/openat: Add new regression test when
 using open(O_TMPFILE) under umask
Thread-Index: AQHYpuAZG5FwgMg6rkOOHaINEbboH62e6yiAgBDM6wA=
Date: Mon, 15 Aug 2022 07:41:26 +0000
Message-ID: <e0dc38e7-ea7e-106c-7796-3981ab90a1d0@fujitsu.com>
References: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1659497063-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <c266e389-c6f4-502f-523d-6d51fbf3ed58@suse.cz>
In-Reply-To: <c266e389-c6f4-502f-523d-6d51fbf3ed58@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41926b89-213e-4d18-b2c4-08da7e918f94
x-ms-traffictypediagnostic: TY2PR01MB4954:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y7OBG98+qemQ+uj6juCr27/v4nUH1hF+NIEesScFyr+/1ODx5LpUe0q0I2bAYqzkveJAdWC1NDAFoo9cE7eWQy4aG5QW1AJ7YPuqZT+58DYfpm0c00KNPa7VEAIAHX6rx1241T1wjerOCQymOAP7fzvC6Wa3CDw82FPX46NUfLR895hLKdG1WgIS+LAQhj09nrDN5VOZjy6S6lbGc+KFSvChldyZjVRNw5To2tZjnGyxhNT95FF4TqBv9iGDB6/qF12yrVlUQydONH6TOG/IEwpFJjq97G+7A/jYyO30l05BFEFO4OXyFQOKInVZDQtv+Rcg3NjO1D01S1zzS5UuZOOv1KVyDwP+ReAXp1vwkNBqKf/wLP8TBbZNpsiz1TcMHAjDQZ1BQuM6mnqdkNe/ZFP0QirK0iag5MfxQlPfrRr3EkkI5VO9IAeIIPQUSvkeckh3y746VA59rCxtIT29IcaeIRz+PpC4EGqm/OTAbha9bemihGTwcr8qow8gNYfEgxSQOpLvrtR78le3AVGNN9vN/nYpRcfWBBHvqbzB63rTIaIblOn/dG5TxHE2C359F8OAwGAexLw/hwx8a81sTHnJNjBTpihyssuJNjMeSBc5nzw2nsf0tsHk6T7iosWo7HhdLbN8XTco/JeW3Zw4ZQpl/Z/GOmGYNPJeMHCbI+mXprf2rx9Oy70q9eg0DAUhIoJmq3t2nTCMl2vQsyorId1TlsGsa5XDSu5ff7t0jkCAbQO8rRBZfmtzMiMN9XDQty994I9Oq4tgUnyNxH8581fRjVgm7gZurNmObsuNxs50MFJlaKxCPWqk98wghRoneq9QKgwgZoWixSMhajgSC06lyDU1eHlGMIkYqghSgqAkWNprrlkmRUthopy7xz+u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(38070700005)(2906002)(26005)(66556008)(38100700002)(66476007)(66946007)(82960400001)(86362001)(64756008)(66446008)(6512007)(110136005)(31696002)(6506007)(91956017)(54906003)(478600001)(6486002)(8676002)(1580799003)(76116006)(41300700001)(122000001)(71200400001)(186003)(2616005)(8936002)(83380400001)(316002)(4326008)(31686004)(85182001)(36756003)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGgwKy94SFdxM3ZNVTloYkxZbEJneG40MngvNWlMTVF5MEh5OWFwK1BrZHJp?=
 =?utf-8?B?U0Z2WHBGOFRYMHM3azhJNzNsS2pXa2YrSzZNTVh2MGQyanhvUjgvaGVrUVV2?=
 =?utf-8?B?emI4NFBTSFE2ZkRaMGZqMG1pNzk4Zk5FL0N3ci9tTlpRUzdBZlVTeFhmVWRm?=
 =?utf-8?B?WG9ISjQwblBKUTlqN2Q3eXE0TjJhdnJTSUtTZnIrNitVdEkrd0hJNjhLQ1Np?=
 =?utf-8?B?MFh1Z0pJd1NieHZKaXlFOUxXUzBiWW84UUxiZTlxNktEU2lCRXlzTjZ3aUZF?=
 =?utf-8?B?MjFRT3I5TEZNNXFVUndXTG5VUnl0anVaUit3K2FaNVV5ZkF5a2JmZ2xTTFJ6?=
 =?utf-8?B?WC92cU1QYjJkMnZMWmxIUHNOWHhINlp3TnhNNlJHSXlqM0hoMkVIOExMOTZ5?=
 =?utf-8?B?dm9lSlZJVVRSTlBsc3I3dDZibnFQWmdiU0huM1RPZVRVQ0xwa0NGZUNIL1pl?=
 =?utf-8?B?MEhuVDFsWFc4S2l6MFU4T0lkb2NSNnpMSmt4MTFVeUxRSWV6ZEdSbDBhNHg3?=
 =?utf-8?B?a2Z1L0szL1NwV1hzcitvQjJoS2JLQXRCd0lwWjBMWUdyYTdrOVZyVVF2ZlVl?=
 =?utf-8?B?Vjh3MFdoRnI0VVphbE5yUy9FYVkxakZyZjRvanlWMWFYVXdSNnl4Vk9Nak8y?=
 =?utf-8?B?ZGMzSUVZd0gyRW1SZ0JwYVlIVytFOUs1cmZrYW5JNEREK3kzdWs0K3dBY3J1?=
 =?utf-8?B?YVlScGwyVjdoRzhmYWlMZjE4NDVqd1NVcTZyQnJzN1pQaU42eE9RNjRGMSti?=
 =?utf-8?B?dUk3ak55NzNHclp2ZHoyQ3FKVlpEQUxzTVpUbWlFbVcxaGVheXd6aVpvc2M3?=
 =?utf-8?B?UnpRQUZ2SzBYTXF4WTNUNHVKYnRPNUU4NU5EMmlCVEJwc3MxYk56QUZIZzh5?=
 =?utf-8?B?MEhMbm9sQkJmd00vaWovZCt1QTRWd2lVbWtlRXIrL2RlSGs5TFlvRmMzdm9B?=
 =?utf-8?B?V3FoZXRRSlNxSHhrNWhhZjZOUjVTM3QwWXNvZWRLRWljaHg3bGdoUXB0WHhX?=
 =?utf-8?B?Nk5kV25RMkFJZDVsT3FDblo3ZlZ2VzlhL1loMVcvdWFCV3dtWXpaOUg5djZD?=
 =?utf-8?B?S0ZJQWNEbE5OZitOSk9hNUhsME9SdnR4QVc4V2FicHlyVWFIS3pvUzVwUkZv?=
 =?utf-8?B?QVE3YlVjTTVtTmwvSEVVYWlVMUJQL0Z5c3FkT2VObDVPUzIzMWNNM3FJUGha?=
 =?utf-8?B?Rnc0c1lzVzdJNTk5VnB2T2VpR3BoYnZkKzFlSjNLelBpdnZ3T1hyM1UzZnJW?=
 =?utf-8?B?TXBLY3NBYmFPdHBlY2M0ZzMxN2NkWlR6a2pwWnpwUGVXTXc1MU5aZHBKVEFO?=
 =?utf-8?B?Q2J6TDI2RGJSWWh0UVQ5alcwR0puVk5xbmY4RkVlNERyZ2FKbGFEMDE2QVc2?=
 =?utf-8?B?NW9heU5pUlowTXV5a1diTHphbmI3UU1zS0h1eko5dVJnUU0vTGo2SDNzR2V5?=
 =?utf-8?B?eFNuSE1EQ1pTMnFNS1R3VXRqdndHL2Y5MHV0M2t0OHYxb2NHdXZ1dm5vQi9v?=
 =?utf-8?B?czYrR3N5WDlqcVllTDdpU2h6VjA0bXZPTWg5TzEyRFJWT0cwWHIzdjltVkM0?=
 =?utf-8?B?M2FWeS9XMWJGY0xJeXdRMSs0ek1xcm81TnVMVzRWM29VbDNsY3hXSXFkOW1H?=
 =?utf-8?B?YnNtdGJ3NTdPd3BNNHJReGp5UDYvVXQ2TlhZV2dwcjRhcW93SDZybFFZMGYz?=
 =?utf-8?B?QVBIeUhHNlY4RCtrRG9GSmZydVphS0VsWExjakNLaTJ0cGdkOFJjTlpjQlQv?=
 =?utf-8?B?cmlqcFR3c1pZNmh3V2pQVHZONi9qWSsrZmQ3VG1ZbnY5OW9xYWhHNSs3ZGha?=
 =?utf-8?B?d1ByTUdCSHZmTTNDNXRNWnJ5VTY0bXBiM2gzalpzRytFZUU4ODJyb3IrSzFY?=
 =?utf-8?B?VjRuNmNGNm1rbEJZUW8vRUVyRWVKS2t4YXZIMTZWaHBGbnlQQlM2ZnA2bHc5?=
 =?utf-8?B?S2pLNlRSNFVmVlZhb1IrNnpRZGRKdTNaUjJySWRpSUlzUFFmUGRTTm52TGtT?=
 =?utf-8?B?OGRuek94cnEzd0JyUjAwQ2kwRzhnRnJ2ejM3OUJ0dGwwaTJpbWVpbGt3STdy?=
 =?utf-8?B?S2lqblNQeTljcTA3Z2dieXdkS1h4RmxaS2s3OXlXRGtwOEdDRmFLM3hGeGxE?=
 =?utf-8?B?U2dKVGVma1N2RVdPZUZKQ1ZzazYvaFh2Zm05cVBBN0dILzM3NmJVdWJCeVln?=
 =?utf-8?B?ekE9PQ==?=
Content-ID: <272EE72F8274BB4399B656B659613330@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41926b89-213e-4d18-b2c4-08da7e918f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 07:41:27.0122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZJaqwrLLHo6hRiqrAF7jF5tyk8ep0ZfofMi1lPgot7Jm/GebcFsRrOUU16yX6QgH5IVcFjlrWcf9XobZhQ954UwgPz5qkZ3ImMRlndCmNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4954
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/openat: Add new regression test
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
Cc: "brauner@kernel.org" <brauner@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin

> Hi,
> 
> On 03. 08. 22 5:24, Yang Xu wrote:
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>> v1-v2:
>> no change
>>   runtest/syscalls                            |   2 +-
>>   testcases/kernel/syscalls/openat/.gitignore |   1 +
>>   testcases/kernel/syscalls/openat/openat04.c | 194 ++++++++++++++++++++
>>   3 files changed, 196 insertions(+), 1 deletion(-)
>>   create mode 100644 testcases/kernel/syscalls/openat/openat04.c
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 3847e8af2..448b5613c 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -920,10 +920,10 @@ open12 open12
>>   open13 open13
>>   open14 open14
>>   
>> -#openat test cases
>>   openat01 openat01
>>   openat02 openat02
>>   openat03 openat03
>> +openat04 openat04
>>   
>>   openat201 openat201
>>   openat202 openat202
>> diff --git a/testcases/kernel/syscalls/openat/.gitignore b/testcases/kernel/syscalls/openat/.gitignore
>> index 2928dae22..2d15872ab 100644
>> --- a/testcases/kernel/syscalls/openat/.gitignore
>> +++ b/testcases/kernel/syscalls/openat/.gitignore
>> @@ -2,3 +2,4 @@
>>   /openat02
>>   /openat02_child
>>   /openat03
>> +/openat04
>> diff --git a/testcases/kernel/syscalls/openat/openat04.c b/testcases/kernel/syscalls/openat/openat04.c
>> new file mode 100644
>> index 000000000..323d9a971
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/openat/openat04.c
>> @@ -0,0 +1,194 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Check setgid strip logic whether works correctly when creating tmpfile under
>> + * filesystem without posix acl supported(by using noacl mount option). Test it
>> + * with umask S_IXGRP and also check file mode whether has filtered S_IXGRP.
>> + *
>> + * Fixed in:
>> + *
>> + *  commit ac6800e279a22b28f4fc21439843025a0d5bf03e
>> + *  Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + *  Date:   Thu July 14 14:11:26 2022 +0800
>> + *
>> + *  fs: Add missing umask strip in vfs_tmpfile
>> + *
>> + * The most code is pasted form creat09.c.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <stdlib.h>
>> +#include <sys/types.h>
>> +#include <pwd.h>
>> +#include <sys/mount.h>
>> +#include <fcntl.h>
>> +#include <unistd.h>
>> +#include <stdio.h>
>> +#include "tst_test.h"
>> +#include "tst_uid.h"
>> +#include "tst_safe_file_at.h"
>> +
>> +#define MODE_RWX        0777
>> +#define MODE_SGID       (S_ISGID|0777)
>> +#define MNTPOINT	"mntpoint"
>> +#define WORKDIR		MNTPOINT "/testdir"
>> +#define OPEN_FILE	"open.tmp"
>> +
>> +static gid_t free_gid;
>> +static int tmpfile_fd = -1, dir_fd = -1, mount_flag;
>> +static struct passwd *ltpuser;
>> +
>> +static void do_mount(const char *source, const char *target,
>> +	const char *filesystemtype, unsigned long mountflags,
>> +	const void *data)
>> +{
>> +	TEST(mount(source, target, filesystemtype, mountflags, data));
>> +
>> +	if (TST_RET == -1 && TST_ERR == EINVAL)
>> +		tst_brk(TCONF, "Kernel does not support noacl feature");
>> +
>> +	if (TST_RET == -1) {
>> +		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
>> +			source, target, filesystemtype, mountflags, data);
>> +	}
>> +
> 
> The tst_brk() calls above and below are identical. You can either remove
> the one above, or change the error message to "Invalid return value" below.

Oh, yes, will change the error message to "Invalid return value".
> 
>> +	if (TST_RET) {
>> +		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
>> +			source, target, filesystemtype, mountflags, data);
>> +	}
>> +
>> +	mount_flag = 1;
>> +}
>> +
>> +static void open_tmpfile_supported(int dirfd)
>> +{
>> +	TEST(openat(dirfd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID));
>> +
>> +	if (TST_RET == -1) {
>> +		if (errno == ENOTSUP)
>> +			tst_brk(TCONF, "fs doesn't support O_TMPFILE");
>> +		else
>> +			tst_brk(TBROK | TTERRNO, "open(%d, O_TMPFILE) failed", dirfd);
>> +	}
> 
> What if openat() returns some other negative value?

Will add it for invalid return value.
> 
>> +
>> +	SAFE_CLOSE(TST_RET);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	struct stat buf;
>> +
>> +	ltpuser = SAFE_GETPWNAM("nobody");
>> +
>> +	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "noacl");
>> +
>> +	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)ltpuser->pw_uid,
>> +		(int)ltpuser->pw_gid);
>> +	free_gid = tst_get_free_gid(ltpuser->pw_gid);
>> +
>> +	/* Create directories and set permissions */
>> +	SAFE_MKDIR(WORKDIR, MODE_RWX);
>> +	dir_fd = SAFE_OPEN(WORKDIR, O_RDONLY, O_DIRECTORY);
>> +	open_tmpfile_supported(dir_fd);
>> +
>> +	SAFE_CHOWN(WORKDIR, ltpuser->pw_uid, free_gid);
>> +	SAFE_CHMOD(WORKDIR, MODE_SGID);
>> +	SAFE_STAT(WORKDIR, &buf);
>> +
>> +	if (!(buf.st_mode & S_ISGID))
>> +		tst_brk(TBROK, "%s: Setgid bit not set", WORKDIR);
>> +
>> +	if (buf.st_gid != free_gid) {
>> +		tst_brk(TBROK, "%s: Incorrect group, %u != %u", WORKDIR,
>> +			buf.st_gid, free_gid);
>> +	}
>> +}
>> +
>> +static void file_test(int dfd, const char *path, int flags)
>> +{
>> +	struct stat buf;
>> +
>> +	TST_EXP_PASS_SILENT(fstatat(dfd, path, &buf, flags));
>> +	if (!TST_PASS) {
>> +		tst_res(TFAIL, "fstat failed");
>> +		return;
>> +	}
>> +
>> +	if (buf.st_gid != free_gid) {
>> +		tst_res(TFAIL, "%s: Incorrect group, %u != %u", path,
>> +			buf.st_gid, free_gid);
>> +	} else {
>> +		tst_res(TPASS, "%s: Owned by correct group", path);
>> +	}
>> +
>> +	if (buf.st_mode & S_ISGID)
>> +		tst_res(TFAIL, "%s: Setgid bit is set", path);
>> +	else
>> +		tst_res(TPASS, "%s: Setgid bit not set", path);
>> +
>> +	if (buf.st_mode & S_IXGRP)
>> +		tst_res(TFAIL, "%s: S_IXGRP bit is set", path);
>> +	else
>> +		tst_res(TPASS, "%s: S_IXGRP bit is not set", path);
>> +}
>> +
>> +static void run(void)
>> +{
>> +	int pid;
>> +	char path[PATH_MAX];
>> +
>> +	pid = SAFE_FORK();
> 
> You don't need to fork() here. Just change EUID/GID at the end of
> setup() like in creat09 and then change EUID back at the beginning of
> cleanup().

Yes.

Best Regards
Yang Xu

> 
>> +	if (pid == 0) {
>> +		  /* Switch user */
>> +		SAFE_SETGID(ltpuser->pw_gid);
>> +		SAFE_SETREUID(-1, ltpuser->pw_uid);
>> +
>> +		umask(S_IXGRP);
>> +		tmpfile_fd = SAFE_OPENAT(dir_fd, ".", O_TMPFILE | O_RDWR, MODE_SGID);
>> +		snprintf(path, PATH_MAX, "/proc/self/fd/%d", tmpfile_fd);
>> +		SAFE_LINKAT(AT_FDCWD, path, dir_fd, OPEN_FILE, AT_SYMLINK_FOLLOW);
>> +		file_test(dir_fd, OPEN_FILE, 0);
>> +		SAFE_CLOSE(tmpfile_fd);
>> +		/* Cleanup between loops */
>> +		tst_purge_dir(WORKDIR);
>> +	}
>> +
>> +	tst_reap_children();
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (tmpfile_fd >= 0)
>> +		SAFE_CLOSE(tmpfile_fd);
>> +	if (dir_fd >= 0)
>> +		SAFE_CLOSE(dir_fd);
>> +	if (mount_flag && tst_umount(MNTPOINT))
>> +		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.all_filesystems = 1,
>> +	.format_device = 1,
>> +	.mntpoint = MNTPOINT,
>> +	.skip_filesystems = (const char*[]) {
>> +		"exfat",
>> +		"ntfs",
>> +		"vfat",
>> +		NULL
>> +	},
>> +	.tags = (const struct tst_tag[]) {
>> +		{"linux-git", "ac6800e279a2"},
>> +		{}
>> +	},
>> +};
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
