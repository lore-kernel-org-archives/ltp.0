Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6348C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 01:49:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E4B73C9DB7
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 02:49:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D0833C9800
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 02:49:36 +0100 (CET)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 869E92009A5
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 02:49:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1644457775; x=1675993775;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ThBZ5CLJIzAHqOX6EEf8eFeWfS2/0uo0921sjtymtEg=;
 b=lO0nEMV8+sQxXlza+6+XH2/+htyg/vfxA+9w8E0uNVp/ZkXl0i0eWMI0
 SpERff1Audatr6HblDJkpmk9q8fBCpFYyapSkRpt29W7w7VEaQ03quJgS
 YGy9x+QPduD3BLaey1S6XRAIzoX4EPt84BlYoJPwqWFRq85k+7YnHFoNt
 adbA2r+Z43kYW2spqBfvLN71BdyBBh2m1WcYwTLHd2CRu3lz1MfvmXABM
 Vu8bKIh5+vWpKFYQo8QSIfYGVaSmeKaFdLFD1+6oHFKjODo5nhdOuucjT
 SEiNHyTB9hyf8e3+tTAjNfoQuEc/tHSupLswW3VtewjpL1YIWFfBdBIzj Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="57693277"
X-IronPort-AV: E=Sophos;i="5.88,357,1635174000"; d="scan'208";a="57693277"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 10:49:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0edOD/Fg0WjWnCSXO/Lf5mD9AOmh3DLSPJEI1ZFHd2LOidMvzvnWUNIC4/KN4bg+/z4AcaF0h+TVyBE3bvkdM4J3oGjeqeUAZ1q6A7fHr2BO5oNjdK00aONIVrIo6PwsgJBXFlK2shtpGCoYEIYUGHeHHH2NN/EOfE39vLZGsS0+k6dRO9UwdR/Exzov988Q2m/sMAybGhGDrcdUurzACMuOnsTUcN1sQPIfpUeZ2TnXtV+t8kkpGxhkE+LOF2LNK5cr4xXbQnxe3KR/qIzrIqSozH83weuDR0xAV8D6Y5kx/JslNEQ/xQVhPpMz7GzMQ03+Q8QSbzvv4ra1SnPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThBZ5CLJIzAHqOX6EEf8eFeWfS2/0uo0921sjtymtEg=;
 b=PstUaNPH/5d0R61yz9Rww0T7hzlnRbQIFomJtYMb7J8sXQBrg0NBo01lnK6IZPCg8Wi7NMvgF6pIaBEwuYMH8/mglJ9saYtUympP0dh9ETZYAbR37/xqMotecq2Vp8toPZd0O7zpL4JxrI7x1RpgrP2Cl3/YtH/ewFfVhmAJ9V6+EZ5q4h4/SGvh5O9I/qLizeSN4hGSDAltC/GuIhXbSLHV+bNzv6rkwxaJyqq7YugNdUWNZRxy8vhXkDGeypbk++G0WH9Y+pClSU1J7Iw8x7BA7QwlcN1s0lg2LpT1W0MGPfq7oRgR8XceHSzA6xpQP7cptaFFz39UbQ3OrkOzzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThBZ5CLJIzAHqOX6EEf8eFeWfS2/0uo0921sjtymtEg=;
 b=EUqmPwdUAKanTUTX9ISGZYeYyJfzWWz+ThnmKDv8Lw60Epp4vPc4Uvkj86KvHJwgg3GjuN4CYIub9kheKUJM7BhK/EaTFio64TxqN3RYGOKlNkD8hpwKOh0qP848Xa5PZVPtzfbqbuJkvjzpXo/QoWQP2BZUNJFLvn6ukFOUJMc=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB8344.jpnprd01.prod.outlook.com (2603:1096:400:151::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 01:49:29 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 01:49:29 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 2/2] syscalls/pidfd_open04: Add new test with
 PIDFD_NONBLOCK flag
Thread-Index: AQHYHZlfYfOL98Po4UyQmSs5Gykrb6yLPAuAgADJ1QA=
Date: Thu, 10 Feb 2022 01:49:29 +0000
Message-ID: <62046F52.7000403@fujitsu.com>
References: <1644399738-2155-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1644399738-2155-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YgPGA4oTD65hw69t@rei>
In-Reply-To: <YgPGA4oTD65hw69t@rei>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3b95773-275e-4f7a-6ad5-08d9ec3793ab
x-ms-traffictypediagnostic: TYCPR01MB8344:EE_
x-microsoft-antispam-prvs: <TYCPR01MB8344DA32110B67CBE634D100FD2F9@TYCPR01MB8344.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:277;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9600FogsOQl0U4KCMDgBwadzGWjPTTHqy6+HMR+4HMlPD+YhebzjNMwZliAIlz9kJH9OqlqwH99VQj0luXNXU/P+vOkRpRUTbHBQUutZ+7Nm6u+B4b0VzGLXBgGNZhiYIugTuhYoKzOV7PYOhgADLjHFnD64IUHdlhoK6mHfPTFyXgRI1Dr0jtvy8yosgdqGRcrBQQPRaQUZkUn45Wu99NcARgbGkQMX1cIs1BBU1VpRTzJcq82cd3RmJOOYlHXTbbpL3vpe1AibzGm/DsrrXLSBcweaHh3KCxXwK11V/sWpTJ3HpVwAW7KUm9cil16SJ/8oOi3dNLyx2mAZxo54u5bAlz357KHkhMCsfkP9yslC739S330kYEXwDvsByWSOiQPYXwmWYcOZje2BBwflbF5ppHpdPpHexRZxTUa2yCL7d4KyHCYsXcU7sXrupts+XwjKwKMCk9oYfBVSHtAjdCkVUOMTwU5z+kea89ix1TRY/3ftdcuNgAw/drltbRRgn3/+4yfh+mRutOPHDTBzIuej6d95Jzdo9sag3mcod3PddOQxgo3zXaB7ZNxwAMxg1JUCHT0+Gc+kzIZmMxp7cOrfJojh2R537koU68f97cdBGbicuib83hcpNEA56nsoSrXvU1Qv3DF1CUIYBTtmG38FVAr9KY2UZqhUQRMC69awSzaOcB4TNrJ0YkDtEplDTwUv7z55nb8DoYaYMRscg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(38070700005)(8936002)(5660300002)(4326008)(8676002)(66476007)(64756008)(66446008)(66556008)(6486002)(82960400001)(36756003)(508600001)(76116006)(85182001)(83380400001)(6512007)(91956017)(71200400001)(38100700002)(2906002)(2616005)(87266011)(26005)(186003)(33656002)(6916009)(122000001)(316002)(6506007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TVh2aXc2OUZrWjBPNGtqckJGTjBIN3ZzRzNXWUZ4VVJqa1ZCckhRWWVmUHVY?=
 =?gb2312?B?L0wxQXNpdG16VU1sUk5mNHdqc0FqK1I3a0QvTXg0N2hDaDRiZXFIWGx4MFpo?=
 =?gb2312?B?MVNKQW9CZXlaTEEwUVp5a0ZNWTg5VmtQSEJVQ0lpb2FYL2wySWx6Y1ZtMG1N?=
 =?gb2312?B?VG96dGtZQWNoOThLV2FnVzFNZGpzZXF5dEM0SWM0dkFOM1N4R3VqM2d1VS9I?=
 =?gb2312?B?c09JTjBLVytxWTJXVVlNalcydXNrRDNzZEZuZkluTjhtR0RBeXdhMjlLOHVk?=
 =?gb2312?B?MENzdDhCQnZQaEVwOVEyYllnZmJsVGluOVo5SjhZUG1TUTlxMklyUFBlczJv?=
 =?gb2312?B?ak5JaTg5NUNXMGtlSDZrVGt6TFZXOVNqK2FReGdMWC9kUHFPNGt5em44bS9v?=
 =?gb2312?B?M0sxRUE1RnFVZFM2Ym1DRU55ODNtQjdyc0ZUKzdDMzFKSXdNR0dTUDZDZ0xy?=
 =?gb2312?B?WUZSaC91d0xpbFc4YkptZ1I3Y0Q0WjlOeVNzN1cyZkFEMzJWeEZ1TGlDYUsw?=
 =?gb2312?B?KzhpaEdvS1BMVjZOS0hUSlZXeEx3aE9KU05EMjlJdWR0dGl5QkZMYUJKbU50?=
 =?gb2312?B?dEpENkh5RVVhWi9NU3VQV0c3bFhJMGdWcTBQMm1KUVZjdmlGYWJVWFFIU0xw?=
 =?gb2312?B?QlUvZDdLclFxYjFrUTNvajVFSURheXBwRzE2Y1JSdDBNYzFWOWFVVEV2Y2ly?=
 =?gb2312?B?WU85cDdQNlVDdmY5cnZ6TXhPb1dHQnFKUXM3OVVmNm9zRjgrciszNmxlSDFx?=
 =?gb2312?B?aHI4bkRZcVg5em1LOE9HWHB2alRQY2lVZDVNQUw3MTQ0RU1wOVJacWlscllD?=
 =?gb2312?B?Z2U2bUIrL0NhamkxUVhuc3JGNEVCMHAycTZMbDl2bFRDVS9iUHdhOGdoMThF?=
 =?gb2312?B?aDNvc3NoZ3hoMGVaN0xtUXhlaFBDL2dSa0kvMEVJZVJ1MkNpR1lseHBLUmpB?=
 =?gb2312?B?TDR2QUVXd0tkREdMUEx3Tk9VMC8yV0M1S0xqdFlQZTFrdnFzNDEveEgxYmFo?=
 =?gb2312?B?MjBQQzZ1djFCT3c0ZnpsVFlRZ09pa0tiRitSeTdYQ2FmcFJVeHdTcGE3MW9i?=
 =?gb2312?B?OERmNVJBMEVJNDVoMmYxeDlwMDBINXU0Z3E3NDlyTWJzaHovbEFKS3VWZ09t?=
 =?gb2312?B?Z0tjY2gySUxjcU9NeDNLR1R4ajNZUHJPUUZhd3pYWlRHWTVUcEdDZXdma2xZ?=
 =?gb2312?B?ZGI3MU5LbXNtYWsvcHlHdmNMTDhuRjQwNXErTGtBSHkvYjl5UndWMzhmNWdU?=
 =?gb2312?B?b2NLcHY0cStSd0tNdUFzYW9GN1RiNnZEQit2dnM4ZldzTU1PQTFhZnNEaGxx?=
 =?gb2312?B?aUlHVlAxNjRBcmRNdlRSYlo5S0lTb3BmVWVRWjZ2NWIvenp0aElLMjZ6OU1B?=
 =?gb2312?B?T1U2d2VKOEkrTTJrMnlhQWRqcEhBckdQcWJFRDNmTUJaZmc3dE8yUTFoZ0lZ?=
 =?gb2312?B?TENHV2ZMS1VFdDdIeXlRUDdWRHlEajQ5R2VmRHZqNDBHaVpRQXVEZXE3NEZG?=
 =?gb2312?B?bS83Q1M0aUhXSkhzWUdaUTBYN1dqeGtZNmRpeStTcFl3VmtpenFhZzYxbGJh?=
 =?gb2312?B?QzBzVUp5UlFZSmJvMG8rbW1Ccld4WVg4ZG5ad011Sko0YUxCTkRlUDFyK1Ay?=
 =?gb2312?B?Rit3WDdjTFJWQ0hYOWNKNHhIVGwzMEpWMTVZOU1RenNlNHlsbXNqR2Ixa21k?=
 =?gb2312?B?bkZOWmNUSWxJT0s3UzVyNlpoQzRTNHloSFpjcms2Q1VuS0pWbVZJZk1wTk9N?=
 =?gb2312?B?VWx6ZFg5ZnplU3JCOENJNi83Q1FkUHJPTzdHYnJxUlpXb2RVMjF5RWZYdlFs?=
 =?gb2312?B?S2QyY3k1TEYyQ3dkRm5YcWRRMEdlYnVxT1RXNGVJT2V5LzUxTHVjNTBKemZu?=
 =?gb2312?B?V2E2Y2NYMTgxMFFRYTJKK2V6VlNnNkZ0NUEzT0lQQTlZdmkyL1hxeWlFVkcw?=
 =?gb2312?B?dm43bXlwMUMyd1lLQzgvWDdRS3d1dDlwVFZ2Y0JkMGVVS09JUHJmN1R6amdO?=
 =?gb2312?B?T21BbTVtK3F6b3RhcnVCL1k0K0h2TUhQSHJoamF3ay9oWFNDRXNsSVkxWUlz?=
 =?gb2312?B?MzNzQUdLZ2RFNlVpaU5JdFpaS1kwVjRZbWdZSE5aTWlrZ0krRFgvU25yclZa?=
 =?gb2312?B?dG9PVVFQUUNUZXZkd1lFMG5WOStRVXpBSzg1MUcvOTU2MXJmdysrVFBvNU5G?=
 =?gb2312?B?dDFVMjVyMUNvYzVtWUFOTUZBQzkzYW96T0FPZHg2YWIrNy9kYUcxYWxwQmtZ?=
 =?gb2312?Q?AeKiDytmIX+VjjruniorCsTLMbWGuCe/Wvd2o1wbEs=3D?=
Content-ID: <6251FA788F5D794FAEFF439ED9053090@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b95773-275e-4f7a-6ad5-08d9ec3793ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 01:49:29.3695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eMBACDdcvhdCxeSVhht7MTehv25CtyiiVDk1APk6W83M82tKA1z+LC2lcpsVg61Re7tuPWBXynlfgWoLyXqglTYdvlKdd3Vw1xF0zvGmvXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8344
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/pidfd_open04: Add new test with
 PIDFD_NONBLOCK flag
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
>> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
>> new file mode 100644
>> index 000000000..436351f23
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Verify that the PIDFD_NONBLOCK flag works with pidfd_open() and
>> + * that waitid() with a non-blocking pidfd returns EAGAIN.
>> + */
>> +
>> +#include<unistd.h>
>> +#include<fcntl.h>
>> +#include<sys/wait.h>
>> +#include "tst_test.h"
>> +#include "lapi/pidfd_open.h"
>> +
>> +#ifndef PIDFD_NONBLOCK
>> +#define PIDFD_NONBLOCK O_NONBLOCK
>> +#endif
>> +
>> +#ifndef P_PIDFD
>> +#define P_PIDFD  3
>> +#endif
>> +
>> +static void run(void)
>> +{
>> +	int flag, pid, pidfd;
>> +	siginfo_t info;
>> +
>> +	pid = SAFE_FORK();
>> +	if (!pid)
>> +		pause();
>> +
>> +	TST_EXP_PID_SILENT(pidfd_open(pid, PIDFD_NONBLOCK),
>> +				"pidfd_open(%d,  PIDFD_NONBLOCK)", pid);
>
> Here as well FD_SILENT();
Yes.
>
>> +	pidfd = TST_RET;
>> +	flag = fcntl(pidfd, F_GETFL);
>> +	if (flag == -1)
>> +		tst_brk(TFAIL | TERRNO, "fcntl(F_GETFL) failed");
>> +
>> +	if (!(flag&  O_NONBLOCK))
>> +		tst_brk(TFAIL, "pidfd_open(%d, O_NONBLOCK) didn't set O_NONBLOCK flag", pid);
>> +
>> +	tst_res(TPASS, "pidfd_open(%d, O_NONBLOCK) sets O_NONBLOCK flag", pid);
>> +
>> +	TST_EXP_FAIL(waitid(P_PIDFD, pidfd,&info, WEXITED), EAGAIN,
>> +			"waitid(P_PIDFD,...,WEXITED)");
>> +
>> +	SAFE_KILL(pid, SIGTERM);
>> +	SAFE_WAIT(NULL);
>> +	SAFE_CLOSE(pidfd);
>
> I guess that we can also test that the waitid() succeds now, right?
Yes, we can use TST_RETRY_FUNC(waitid(P_PIDFD, pidfd, &info, WEXITED), 
TST_RETVAL_EQ0) in here.

Best Regards
Yang Xu
>
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	pidfd_open_supported();
>> +
>> +	TEST(pidfd_open(getpid(), PIDFD_NONBLOCK));
>> +	if (TST_RET == -1) {
>> +		if (TST_ERR == EINVAL) {
>> +			tst_brk(TCONF, "PIDFD_NONBLOCK was supported since linux 5.10");
>> +			return;
>> +		}
>> +		tst_brk(TFAIL | TTERRNO,
>> +			"pidfd_open(getpid(),PIDFD_NONBLOCK) failed unexpectedly");
>> +	}
>> +}
>> +
>> +static struct tst_test test = {
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.setup = setup,
>> +	.test_all = run,
>> +};
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
