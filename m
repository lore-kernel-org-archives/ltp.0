Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E45C433F5
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 03:29:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D01D33C958F
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 04:29:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 370F83C575C
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 04:29:29 +0100 (CET)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4DCA4200C97
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 04:29:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1642130967; x=1673666967;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CQdFLiff131c/cfXai0GJSyegsno1jzNK1/SExgoA24=;
 b=F638kwrXqsqtr4OAEIbPYo028MCh068HTxwof+L/2Tq6ZttEWAjxqfCN
 f1VVxDIUoMPM346/c8uXbiUTiR5YDLo7THo41G1/CjJOqWdRwy3i8pQEa
 e51wryPn1fv4krCef0nar4oyTXtN6VtoPZY67w9xcnWg6lBAf6ojOYGWD
 gNJpbjIQrHh1m7K2K1qcBXWS2D1aoPu/LLNBsF0u+WfcbFk5LM3RjuuIZ
 1F0Q31NkWO7cgURUhOqMVr6JD1eEtrtA0BeDjPWCwchH4Q466lsqrJXH/
 nVTbRa6nJSVXxJUslYox/0z1sJJzeYg1NZlWEIIpVYIjt5GUL5zVo2oTF w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="47594496"
X-IronPort-AV: E=Sophos;i="5.88,287,1635174000"; d="scan'208";a="47594496"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 12:29:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frLxjx5pdOdhZzGjBh+3IrIVhtPAvVAQexraUEcT3WGm/KmfK8T2DG/8m+/d49V8bRcIzNsp22dfkyJ87adKf5m0CbQNwgT8iDxWRbY1TLqg6j7syVU/mqqXGiklYTQluE7LrU3On31tr94dU+1oXKy+TpjvHuhSmpTx1Be9Ep6+2s5FmZQ1fF+nct8JWo8mzyg/2K/QDbEO5yAU6i0F5VjmLb1mmNNy93RIciPggwpb0MSgENyLiOHydnPhfskBXXQweOXNUmcc5yNsiGkxbueVwgxJ6GVu+wvnMj4WGF1BYDpqGyT9doS5wsbuc9JN1Fq/HOGYdqZLrGy+stsxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQdFLiff131c/cfXai0GJSyegsno1jzNK1/SExgoA24=;
 b=GsWotFDQYKgYRtguUWweIag0YC1yMvSGTWwkG0Bd0IeB9H4PTPv0taSRXLbH2DZeOFIOdUHhsnWxR6IZB6ozHnfJGyo7XHaeY0b/s0jkRjkLwYNbS4LAkFziQMe/03BVoIE7cn8lft5IoEg9O6t8ecL0jUDtibU19HM78yfl4TIPeV+xs5c8Aw04fy/J3z6PDc50Oka3WFQswxWrq0vaoTUMVixrwcxXuVvRqEeK6OvcOUlSClzvTnbUR6WE3YNyjJs7TbS4rzQhzq+zgRGU7O5OfBe39fV86j4cOeUt7FuUrEEiSC/5Es6JpK4Zowc2eiCiW23MAOZ6vQ7DgfN5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQdFLiff131c/cfXai0GJSyegsno1jzNK1/SExgoA24=;
 b=HUQN5V/bGTVeRQ1o+t+qBb6eFKUPo5a/K834kOSXK97sTYAvRX3QTeyHOn9E9uZf2FHmcsEkJqgKCrPoK/Vggqjkf18rOPp9/WkPmUBszPXOvNu44a/8X2QBLJi/wIbv1A538D9fyCG2+6+5KjD2RjLyvIy8EC+SaYRJSVRbV6E=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB3327.jpnprd01.prod.outlook.com (2603:1096:404:cb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 03:29:21 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%4]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 03:29:21 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v6 2/3] syscalls/quotactl07: Refactor this case
Thread-Index: AQHYB4i2YRsUs9eyQUeFctB/m7G61Kxg/ZWAgADhcoA=
Date: Fri, 14 Jan 2022 03:29:21 +0000
Message-ID: <61E0EE49.7010802@fujitsu.com>
References: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641973691-22981-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeAxK/IMvCIb0Sp7@yuki>
In-Reply-To: <YeAxK/IMvCIb0Sp7@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1742a1f9-dcb2-4099-54fc-08d9d70e0e03
x-ms-traffictypediagnostic: TYAPR01MB3327:EE_
x-microsoft-antispam-prvs: <TYAPR01MB3327F9EA7E31D50EFDD8F455FD549@TYAPR01MB3327.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /yYqvOSeY8rklWAekJQmH1yByIkQO43hn7kE9mdffMfHEk9WYB9920zIvZcN9csZMqlyydBzWeNo59Dut4RnL+zvYMWzoXpWpZCW3Tt19mDdXOFSFkV3qXbyyiSGCrvUrtn7bC2iRdjkct0rw/a4zr9OW9yHFpJNo/9hICC4a388WdDUSI8/ZaZMIHFdjRWx6vT1A4n8zE7cIw4g00NdKyEErtMm1ckwjH+p5MgJyzk/R99e0xJw9M7O87jL1/TQF/2AheYjyGcEn71gX4SKF5IC8Bp4r6dWKnUwM1NnUcD3TKYXlldhNTG+lx99ru4GMr+c40OYcsqQDd4XQOHrx1yapCXxzWEcbuOJwRVGyo23Veh8O4gzoie5I9j2uSidgNmxnWMRxCbM3m8UxVlcD9l32oDjx30gPdR1MrK86ta94OeVXpXKdJkxA1lM42OjnK8/fU3YaA0L4q4/0jYDGdOz+sC04Yfpw15O0agEQsyHg6Q74567tpK22wU0a0abdVqUKMdturE6aehLnkuyQXwIN6w4smEpqvLEPDO3wXWfRYq5rsP6K/sLgoQ3/mVlLk1ExjZ0hMcRzGTKMgc3iIdSIiimOTWHjh2SoMxeT+0UnfSSas4pORKp9/5nA+JhsHdQ0Y/SFL4Wm1noasqpaFl5GtI/uWIonaOVt5z7+Jr+t/AGh9Aitg4uRIaOtYX2Gj3aCYRgjReOjVV2cJLFPA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(8676002)(82960400001)(66946007)(2616005)(83380400001)(4326008)(26005)(8936002)(6512007)(38100700002)(91956017)(6486002)(76116006)(87266011)(5660300002)(186003)(316002)(15650500001)(71200400001)(36756003)(85182001)(6506007)(33656002)(6916009)(66556008)(508600001)(66446008)(64756008)(122000001)(2906002)(38070700005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RGRkTjdLeWtYdkcyRU03Rlh3TW5KTzNxKzNGcFR2eGVDd3pIdG02THhGQnBM?=
 =?gb2312?B?ci9yeXJMdG0zRnZ2b0FXV3hqN0xFQzhvcDRIbUMyYmhGeURkM1EweWZHeElj?=
 =?gb2312?B?QVhJVlRTYzRUQ29YQ3ZsbEx0d2dUbnRrK2piZ2cwcFljbkRTY0tIZmp0bWJC?=
 =?gb2312?B?S203RTR4S2lJdUlzSFJTMDlOdnAvU3NvUVBjOFEySUtRS0RmVmMrL1RDTzVl?=
 =?gb2312?B?bXFLc21vNldXWFF2RGk0TUdQSFRQWUNqRS9nRlliZnhJTmNFdzlQSThwczZH?=
 =?gb2312?B?Wnpib0pobmY4M0MyNCtIV0N4R3FYY3NYYUZNbHArUml1THZpYjJzSHkzRktY?=
 =?gb2312?B?MzZNQzd1aFZXSTdaRmlIQmZjWEFtSDZtVzFBYk5JNGY3L21sdkJqbkFyYWwz?=
 =?gb2312?B?aEkwd0p0SCtyWU1OSy9ZditocnFROEI4dEg4Z3IyL0ozSFIzM2dpR083K0Ew?=
 =?gb2312?B?NGo5L3NvQThjYlB4cS9qMlJlbjB4VGhaemxlSi9ZNWN5WWZENGl5YmkrSUVr?=
 =?gb2312?B?bW1XaWowWi9OWEdqR3RENHJXWmdqbGt6bVptRWU5blN6N0xaRjAzL1VnUCtD?=
 =?gb2312?B?U1B0clBua1lZRVV3UGJObHFEVWJlbXBGeElNNnRwRkhTODNqS2oySmtRMWZp?=
 =?gb2312?B?SGtqVTFhblNJck9DYWJpSTkwMzBybVhDVU5uclM4VitRQzhSWTNZWmV1b0o1?=
 =?gb2312?B?WmJUQk1wT3R2RTdYY0JHYWRHUWxaYzFSZWhTVXczSWgyK0dTdGdXNXcxSzNn?=
 =?gb2312?B?WC9Yc0NaL3hkMUphcEl5Yk5QUTdCZE5nWUcrK0w2Y05zcGg2bFdUZmV6NC9v?=
 =?gb2312?B?eUdxTlhsakZCQ0dYZ1Y4a2JLTTIzNFB4cDNxazNZVENwZ0VITkV3R2xBS2dy?=
 =?gb2312?B?dFQxa2Ezemx2UXNmWWFNTndaWFd3TGM0Z1A2QWNROHdXUGR0VVQxaVhoQ2tm?=
 =?gb2312?B?eURvQVNMME5LRVZWTnhVbVVSTEN5cm05R0ZJOE5USzhIMnRJQUlSck1wWTJT?=
 =?gb2312?B?d2hYWG9UZDhYL0xzZml0RHViSXNuWnNSOTJ6RXI3UlZUM0JtTGpLQVpmaEhq?=
 =?gb2312?B?K0xPY0FRR2hCNHRWUWx4Sm8xbW4yYzhHdUpLaE0relhqMjZnQmplaDlnaXJ3?=
 =?gb2312?B?RGZscUpUY2lzdUNvL1BUc0taOWlRcXUyamYvMVFJODNScUt0bFhNVnhETklX?=
 =?gb2312?B?RUxrWVRDTWJUUGFqQzNOR3ErZkY4SjJMYytPL3FocDJkaWRLY3VsVkd2WFhG?=
 =?gb2312?B?MGRDWS9tQ29CUW41SFRSZWg3dUc3aEZsRVQ4ZmdZUEdKOGp5OVZiU2pDdlJI?=
 =?gb2312?B?R3dGVTYxUzJJU2RBbEFOU3Biazl6TE9EaHI5SjBWT3RBVU0vSklSYis4eE8z?=
 =?gb2312?B?d3hZeFpXVHg3WE9BbG5qb0RWYXZlMG1xZ21VOFliUTNLOVM0UVFWbzltWDhN?=
 =?gb2312?B?LzFtYTVCT29Kbm1wd2VvWGpZT2ZPRDRUdGpmM0UreHUwM1JiU2FYOTZkZkRj?=
 =?gb2312?B?aXo2K0J6djRheFFVMGxRYnlrNndORXdrQy81Ykl5VTZDcmVnVDF1M0prRmV3?=
 =?gb2312?B?RzY0RVRKQ2tIV1dpK3kyZkdzaTVxbzFQQzNPcnhYaUNBSzFhb2ZkZE9weXRu?=
 =?gb2312?B?QW4xdit0YTQzS2NwdXlrcHBrcytGSy9DMEZ5NDNmdDFSWCtnRTNUWTJLYldV?=
 =?gb2312?B?S3V5NHB1d0tZZnFzQ1kwUHJ1YThsZWJmQmtjVHppQjdkSXJVZWlPTEloVTdN?=
 =?gb2312?B?cVN5WTJacjExdE9ENGErL1JTOWpBcWp5MXBaRDBDU3c4N0xJVFFIL08yYW1O?=
 =?gb2312?B?d2R6OHZmNE5Xd3VMeTk0VlRDaTFYNmZ0UXJxOGVCZkRJdnBRclNWb1c2RXFV?=
 =?gb2312?B?NWFvR2NwNFAyc3AydkVxUW5KWFRJbk1pNFJTRU9ZR2JoQk9iMkNlYXQzZVB1?=
 =?gb2312?B?L1JheTU0Q1JuK1FjVTUyaUNuZzcyWG1NZHp3OEY1eW5UaUk1R1BRTlg4akFm?=
 =?gb2312?B?aGRQZ1hrY0N1TTBWZEN1b2J1Z2hFNzlJRUo3dnJycFg0SERPcGpQc0VBUzB6?=
 =?gb2312?B?dUtnSkh1Y21KQkh2L1UrMVRBUzZMZUh1OGUwclZIeXlSUllRdFpTM01Ia1p0?=
 =?gb2312?B?ZkszRnhEUHBoWHIyQU0xdXNkOGEwZnIzY2haZjZsZldjWS9URVJpdmdoL2tG?=
 =?gb2312?B?WkdkckZrYlF3Um55SnJNaHlpZWdiWE1EYzZNZmpHZGx2K3VEZkhCRTRlckla?=
 =?gb2312?Q?MKwvrKGM8hhkAYilgox+zn2zz5fVLzn/55C4o9Q5BU=3D?=
Content-ID: <61EABCC3CE8C2C408654C0FAF0FE1956@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1742a1f9-dcb2-4099-54fc-08d9d70e0e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 03:29:21.3780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxf7mR9ebm+kPV2nyKdXezX7zBd9nJPbMupCi9S0qk/NzbLB1TRdLxDmfrWmfn5E9VDX/U/wpRyrVe4nlgRjU3/NY7YXQCrHcjAEBwxLu6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3327
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/3] syscalls/quotactl07: Refactor this case
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
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
>> index 2992a6112..2427ef682 100644
>> --- a/testcases/kernel/syscalls/quotactl/quotactl07.c
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
>> @@ -7,7 +7,9 @@
>>   /*\
>>    * [Description]
>>    *
>> - * This is a regresstion test for kernel commit 3dd4d40b4208
>> + * This is not only a functional test but also a error test for Q_XQUOTARM.
>> + *
>> + * It is a regresstion test for kernel commit 3dd4d40b4208
>>    * ("xfs: Sanity check flags of Q_XQUOTARM call").
>>    */
>>
>> @@ -15,51 +17,71 @@
>>   #include<unistd.h>
>>   #include<stdio.h>
>>   #include<sys/quota.h>
>> +#include<sys/statvfs.h>
>>   #include "tst_test.h"
>> -#include "lapi/quotactl.h"
>> +#include "quotactl_syscall_var.h"
>>
>>   #ifdef HAVE_XFS_XQM_H
>>   # include<xfs/xqm.h>
>>
>> -#define MNTPOINT    "mntpoint"
>> -
>> -static uint32_t qflag_acct = XFS_QUOTA_UDQ_ACCT;
>> -static unsigned int valid_type = XFS_USER_QUOTA;
>>   /* Include a valid quota type to avoid other EINVAL error */
>>   static unsigned int invalid_type = XFS_GROUP_QUOTA<<  1 | XFS_USER_QUOTA;
>> +static unsigned int valid_type = XFS_USER_QUOTA;
>> +static int mount_flag;
>>
>>   static void verify_quota(void)
>>   {
>> -	TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0, (void *)&invalid_type));
>> -	if (TST_ERR == EINVAL)
>> -		tst_res(TPASS, "Q_XQUOTARM has quota type check");
>> +	struct statfs before, after;
>> +
>> +	SAFE_STATFS(MNTPOINT,&before);
>> +	TST_EXP_PASS(do_quotactl(fd, QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0,
>> +			(void *)&valid_type), "do_quotactl(Q_XQUOTARM,valid_type)");
>> +	SAFE_STATFS(MNTPOINT,&after);
>> +	if (before.f_bavail<= after.f_bavail)
>> +		tst_res(TPASS, "Q_XQUOTARM to free space, delta(%lu)", after.f_bavail - before.f_bavail);
>>   	else
>> -		tst_res(TFAIL, "Q_XQUOTARM doesn't have quota type check");
>> +		tst_res(TFAIL, "Q_XQUOTARM to free space, delta(-%lu)", before.f_bavail - after.f_bavail);
>> +
>> +	TST_EXP_FAIL(do_quotactl(fd, QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0,
>> +			(void *)&invalid_type), EINVAL, "do_quotactl(Q_XQUOTARM, invalid_type)");
>>   }
>>
>>   static void setup(void)
>>   {
>> -	TEST(quotactl(QCMD(Q_XQUOTAOFF, USRQUOTA), tst_device->dev, 0, (void *)&qflag_acct));
>> -	if (TST_RET == -1)
>> -		tst_brk(TBROK | TTERRNO, "quotactl with Q_XQUOTAOFF failed");
>> +	quotactl_info();
>> +
>> +	/* ensure superblock has quota data, but not running */
>> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "usrquota");
>> +	mount_flag = 1;
>> +	SAFE_UMOUNT(MNTPOINT);
>> +	mount_flag = 0;
>> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "noquota");
>> +	mount_flag = 1;
>
> Maybe just SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "remount, noquota") ?
>
> If we can remount the device without umounting it the code would be a
> bit shorter.
>
It seems use MS_REMOUNT flag doesn't work well, the quota feature is 
still on and will report EINVAL error when using Q_XQUOTARM syscall.

Also, send a email to xfs maintainer to prove whether  it is a expected 
behaviour.

ps: I will merge this first, then I will add a comment to clarify this 
when I know the reason for xfs maintainer.

Best Regards
Yang Xu
> Anyways looks good to me:
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
