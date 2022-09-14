Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD16ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 05:49:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E6CC3CABE1
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 07:49:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12E4F3CA900
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 07:49:16 +0200 (CEST)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 19719601D0E
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 07:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1663134554; x=1694670554;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=2w4XZyznrrEgAVa4y9a72Rd+9bUJVL2+WshhDfZ7uPU=;
 b=EgWrX1nmHTH1wD6jc7sEZP4+sEGdpUnVibBwIMEyrDMVvVse5kyqK3R7
 QwwaX+aigPg7FVon8A3qMmS6bdlaBUV2tgxUleNcw55Oci4qViQ2qZig8
 16cdNGeYuhcsb9PN9WrONDok8X0K91kQfJXhV5Rpa7D0U3OO7F2DwenQG
 p5Q5M+9anUcKHhXVl4gfqqwx0uQiW9S0fyvwPM4Sl4BA4Acr+oVrWpAXi
 70o4VcKljKHpZR8m6drPlFZZj3El2u9nm5e/qc7T/TvfW7qvRQzIGkQiP
 4pyaKyCvh4z53XJaorkgWxWO6AXXZ5BedXT5d/QRK6dM3yGmG7zgti/HL w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="65042428"
X-IronPort-AV: E=Sophos;i="5.93,313,1654527600"; d="scan'208";a="65042428"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2022 14:49:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKSRwhq9bAxOCX8j5ZOTQvsFYnxO+taBT0WaHe0RC0R1lMvb8UexlwW7X486+s9JAaQ7YIL69lvjiGVpPydKDGWB6jONOLbphwBE3gt6tQEAH5bVCVcbSWaYJRHaztAB2I5fboB5MMVQxq9NKNncS2atgf5zYYVdIOzupUA0yW2KvZi9+TAawSfGMQPTVHYNSrDVntyizCxA81KglCCUF828sKLTC3BKFtdQ4GJy+BBp+R4W8NgIGYV+VKaB0kP3BzOdhrF7amW0OU0JyJJ5FXjXW5xNDx47A0ri+Ec1m6V481GfyhG9bjHPTon3sKcqUm8/KK6cW3pVgp3g7oSb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w4XZyznrrEgAVa4y9a72Rd+9bUJVL2+WshhDfZ7uPU=;
 b=Eo1cEl+gBBKUDZZeLQ4v6DwakAQcvN+RewyJufU5q3TtdCfO50UFzUYP2zhAnhHrwhGCKMFhSdzicFBDIPtndj6sJg3HkgnxJJW3cUIc4l7IHv3lGJdeXMLjGHbn28EdA8XJtmycbzi/aZyWoyKOqBnoYtnPqN0RstOhjiBHbmbGW8sExOaPIkRSSDTvs+qb7fnYqqY0IuoK9APtF2t/zH1Xf3xjD9Nnc0l0T56HGfKwi2462uz9KPRCfu9Rxw0FW0XSPgeoNbuC1GBmvLd9yHasRH+wXrFP1A6sOFgVRsnFl29n43VQI9HelKSO5+WYomGuozGDEd5m4xEOhZcyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY3PR01MB10236.jpnprd01.prod.outlook.com (2603:1096:400:1da::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:49:08 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8%5]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 05:49:08 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v3 2/2] syscalls/openat: Add new regression test
 when using open(O_TMPFILE) under umask
Thread-Index: AQHYsIC9C/1bZJ6Qz0CEwNYjtTvTs63dat+AgAFAhQA=
Date: Wed, 14 Sep 2022 05:49:08 +0000
Message-ID: <7478857d-b46d-2146-5cd9-8631f7909aa2@fujitsu.com>
References: <c266e389-c6f4-502f-523d-6d51fbf3ed58@suse.cz>
 <1660555627-2269-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1660555627-2269-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YyBstRuPEtZNp887@yuki>
In-Reply-To: <YyBstRuPEtZNp887@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|TY3PR01MB10236:EE_
x-ms-office365-filtering-correlation-id: f69705d4-d3b6-4e4d-5ca8-08da9614d799
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMS8Nj1RBTcXy0G9YI7rkIobUf/1E8gJds+SgDdQznGsb+g5znThCNdwIZaTbRMxEOs/159tR2iq/+mCA+y5qSNvjBll8bufY+ouSOT9E1jiU3aqivqUJdobLy7bvmVfPsgND3WCzmxmxS//cDT2lKhce6RL/wgIMF8BuvQCj3e8Uhd28Bu48BZ02GR3I9OoshjPa30EeXiFf+IeVCy82AIJ3l61nppZdfjj5uza3ovsFHcRHX09Et+ZRT5nMbNe3T8WxMojI0o8fXw2n1S4dyBiv3EDJFdagQ0kl4SAcvSWQO7IETvKMTeOUYrlmsJqNcLeul1yPuD0bPM1BlOENWzCxppdyXWWaOVPSofaXSsegqrr+mAYYpfvy8u1OWlX4YJvAiHLPsHHZk1reptdKl46S/oS/cUB9aHdbDrR3NdtOPAJXXe/M6K69EZvju8vel3G8PM+LCh4GwWu5PcfPHoAVM8VtHGtRL4EgTfWFpty1CfCMWfgJFSyqLIWw+oPntqMl/6lCW+ND3VZHMihTv3UcVoRAJhv93xMVSIQsS1wCLrjQxnxiyHFX1lsYeGNsGHpqAW5tArGpmS8aM8t9fQpPrv6clRo2Kl3jOTeY5gsOzeSaTTFI5VKw20tiArCfP/H6vNJxlzhRvxCacZpt1VN6wv0fht0hnrm80aAxA0UVlA3Fg/6TO9UoNQPn8/oN7fVQi6u767jG8x0HpGmNviVGWJ962657tIF5dlo9XWqd+ThSKgKF/BZ0c0zuu23Q4BiCCl3+Iu+PqPyegkR63invEDrsFBXxfT2xP5CZU6uyETi5oCpp/Mq5FNLB0wQfdB2MujqisS5HPWHrCww73EeEFv1nPRDoCWfniYL35E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(1590799012)(451199015)(2906002)(66556008)(38070700005)(36756003)(478600001)(31686004)(316002)(41300700001)(85182001)(66476007)(5660300002)(76116006)(6486002)(6506007)(966005)(66946007)(31696002)(2616005)(122000001)(8936002)(38100700002)(83380400001)(71200400001)(8676002)(186003)(82960400001)(91956017)(54906003)(26005)(6512007)(86362001)(66446008)(64756008)(4326008)(6916009)(1580799009)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWI1MU5WM090My84NWxUMEtMZ2ZNZTVMelJYblIxZmt4dVFBWTlpcGc5SlBn?=
 =?utf-8?B?b1FvN1ZoRVpIWFBGVHpLQXlEYmdraW1Mbm1VY09hZ3QyUXJOemJBUVlNTFIx?=
 =?utf-8?B?WWMwMjJpWnBVcUNHMUlUNElhSWhnc3BSMmpKZ21oclBKYnZialBseDhjL3RG?=
 =?utf-8?B?UEFTWlMyanUxSEF4bnZLSFp5aVdqandXRHo0Tkp4VW1mcUZwck8wRllsUHJQ?=
 =?utf-8?B?NnlXYXBrWFYrei9DMktJYS80YnhvV2lhMlN3Und5enZobmErVjhBVkd1M1Bk?=
 =?utf-8?B?NE5yZzVnbFZnazV3R2NBT085Tmo0cVdrVlIwOUhQbURuaVhMeG9HTERkTTlC?=
 =?utf-8?B?dWdJYWdUaW5qY2w2UDA4eUJsd2FRdXNyaEw0MkdUaXloblZNbmZCTDJiQ3Bz?=
 =?utf-8?B?bDlMTDBreHpsTGg5WE9pN2F0bzhOTjFTVEUwWE5PM3VmZzNjV0F3SXozM25z?=
 =?utf-8?B?d1NmQ3RQRHdIcGE0bkc5bHpqWWJ5UU1TNzhZemE4VHRIZjVDYXFpMmdveEpw?=
 =?utf-8?B?K2h3b2pBbjd2WHorWmtrUU53UXE3SGtHNHdSbFQ3YWJSUFVrakpVZGMwWnA1?=
 =?utf-8?B?RFg2ZC91NzhwUlZZTG02NzAxNkZSNWxXNkczVUxsNTZFaHFtUkgwYk5qeDFr?=
 =?utf-8?B?NzByNnpRV205WHVnQVhLSUphQ2VXNnM3SWFrQmVldzR2YkZhN2VtWnRWaXB6?=
 =?utf-8?B?c3hDaE42eU9LTjBaUDJpa0dMV2dPaWt2Vk1CSklBejlMbmRvVU1RakpRRDUv?=
 =?utf-8?B?allpSFZPZFYyZExLMjJITG5XVU84bWVDSlNaQW10dERvcXFBSUFHSTdPbnZr?=
 =?utf-8?B?ZEY1RjRFaVlKRUF3WTZhZjVYY090TlRsQ2tTbTdpRHJnVHBRY1pFRlJpOUl4?=
 =?utf-8?B?MkdoOWNWbVBlUTM4NDQzNXVjbHF3MnNEdVZoM1JmSWUvWjlZTTVXS2hjTkpD?=
 =?utf-8?B?MGpQZW82cytoTzNuTWJNSi9FVzhpUU5YNmo0VU9VVTQ1NUhZTHNGWldOOEZh?=
 =?utf-8?B?MnpTa0xnMlRsb0dWMXFKTXU2WDdZUW1pZ0luR1BQK2FFcjgvVFQ5QVdXd1V2?=
 =?utf-8?B?WUY5d2ZPcjFGU0h0d3BsTGlscDd1Mll5dkphL1JlS3RjRytyY3hRMkE0VHo4?=
 =?utf-8?B?YXEySmR2UFRUai9JZnVHSGd1UGlaMDdVMUVNdkhVeGVvaE91b3JIb1lqVlEr?=
 =?utf-8?B?VXpTVnZXb0wrWDJHUVdyUmRVTWhmZkR5VittelFieHN3cXI2UVV5aStpakEy?=
 =?utf-8?B?OW9jdkJZNzhtL3czVVF1R1VwcDUreDZEbFRGSFpKamJWaW5MVkFVdVZnc3I3?=
 =?utf-8?B?RkQyZGlCV2N5T2taQXRwSzMxVllqaGhRTFVzVFBqSERDVCtLSGttbkh2dWJD?=
 =?utf-8?B?WTJVaXoyMkZzTVpTUTVxWG5iYnlESFRENEJ1Y3pta1F0OU9iTGdrT0VYOWJH?=
 =?utf-8?B?V3Jzajg1dCt0UXJ4dm5EWmVUaE1XVWhSam4renJtV2srS3A4Tnl5RFlwTmcr?=
 =?utf-8?B?L3N6YldmdUpqQmprOTNlMDJHNWZqMEYvcHlEV3BPMGpKRkJ3dzJtMFBuVnZU?=
 =?utf-8?B?Q0RWZHE4a1d6R0NzQStJS0R0QnVJSXJ1ZDNZUnRFVVBlOS9IdUc0aWtnb2lt?=
 =?utf-8?B?UUJOem0yU1dudkFiWkVoeXRscGRxYTg5djBtQWpxczlqWU1tM004Z0dZYnhr?=
 =?utf-8?B?MmNvWjkybG44TDQ4M2lONmJJUlA2amVXeEZoZGp6azIvS1VjN1hZK1kwRE1D?=
 =?utf-8?B?bnQrUGhLQkpISHp5cWV0bDd3ZDdkcjVEVVZjUHhEZzI2R0c5MElPaUhXV1dj?=
 =?utf-8?B?VmFzWm5YTE5GcDNEeGh0VjhPcVp1V2Q4bksrWS9lRjFkTnppaitQSlpwU2ho?=
 =?utf-8?B?b043aDVFRGwrdjdXT3BORlhtTnZsczdnRmxKQzNXcDZtM3Job0YrU0lFOTZJ?=
 =?utf-8?B?eE5jOUEwdnNtQm5JRWlGQi85MndneGg0M1NGMElWZGdLY3dQMUZ5RGtIQ2xM?=
 =?utf-8?B?dCtuRzhXM0RmeGM5SGFaRWxzUHByVTB5STRtOStoZDVxRUxCUlZXL3pQRFlP?=
 =?utf-8?B?UEMySTdqeUdUOVZLdi84TjdiWkY0RlJoTGVYMzNRMHV1K1dBbDZOU2RHeUVU?=
 =?utf-8?B?d09LTUJJZHFqTW8wY0hDTXAxb1pHKzdPVnhBMkRWd2FENUp6ZjFVYVhxUmdX?=
 =?utf-8?B?ckE9PQ==?=
Content-ID: <0DBEC68A6B36844E9AF0CC48AE4BB5A1@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69705d4-d3b6-4e4d-5ca8-08da9614d799
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 05:49:08.6698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdI8F3216Mz1kF40eS4BsCFgY7EmyfuWBCCE1ajeSbzjZ3ariNQa8ylY86K9N12Lk6Aqk9Vpn6soIRhjetP9/jnTQK0DXQJpNI84f8nAW20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10236
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] syscalls/openat: Add new regression test
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


> Hi!
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
>                             ^
> 			   POSIX ACL
> 
> Both of these are acronyms and should be spelled with uppercase.

Yes.
> 
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
>> +	} else if (TST_RET) {
> 
> There is no need for else if we do tst_brk() in the previous if ()

Yes.

> 
>> +		tst_brk(TBROK, "Invalid return value %ld", TST_RET);
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
>                                                        ^
> 						      openat
>> +	} else if (TST_RET < 0) {
> 
> Here as well.
> 
>> +		tst_brk(TBROK, "Invalid return value %ld", TST_RET);
>                                         ^
> 				       openat()

Yes, Will add.

>> +	}
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
>> +
>> +	/* Switch user */
>> +	SAFE_SETGID(ltpuser->pw_gid);
>> +	SAFE_SETREUID(-1, ltpuser->pw_uid);
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
> 
> If nothing else this part is really ugly, it's a misuse of the
> TST_EXP_PASS_SILENT() macro and you even print the TFAIL message
> manually for the second time.
> 
> This should really be replaced with SAFE_FSTATAT() after a patch that
> adds SAFE_FSTATAT() to the test library.

Will add this SAFE macro.
> 
>> +	if (buf.st_gid != free_gid) {
>> +		tst_res(TFAIL, "%s: Incorrect group, %u != %u", path,
>> +			buf.st_gid, free_gid);
>> +	} else {
>> +		tst_res(TPASS, "%s: Owned by correct group", path);
>> +	}
> 
> TST_EXP_EQ_LI(buf.st_gid, free_gid);

Yes.

Best Regards
Yang Xu
> 
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
>> +	char path[PATH_MAX];
>> +
>> +	umask(S_IXGRP);
>> +	tmpfile_fd = SAFE_OPENAT(dir_fd, ".", O_TMPFILE | O_RDWR, MODE_SGID);
>> +	snprintf(path, PATH_MAX, "/proc/self/fd/%d", tmpfile_fd);
>> +	SAFE_LINKAT(AT_FDCWD, path, dir_fd, OPEN_FILE, AT_SYMLINK_FOLLOW);
>> +	file_test(dir_fd, OPEN_FILE, 0);
>> +	SAFE_CLOSE(tmpfile_fd);
>> +	/* Cleanup between loops */
>> +	tst_purge_dir(WORKDIR);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	SAFE_SETREUID(-1, 0);
>> +
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
>> -- 
>> 2.23.0
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
