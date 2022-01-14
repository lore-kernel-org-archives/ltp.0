Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF55C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 02:27:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13E123C954A
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 03:27:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 187DE3C57BA
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 03:27:31 +0100 (CET)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0BEC0601103
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 03:27:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1642127250; x=1673663250;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7OUQwnC+7IKxgV5Dihup22VEdIu29LeOEvGMY0RT/Zo=;
 b=gt6ZARob3SB5FJbudQux4HT/LhBGQqjLEX3GbyJdEmzoFbVIk9+qdNYW
 jos+C+jqy3YlcWo+ptVYCVUacytc/4ny3MlwH4bf8vGiMXsBbF9gAhvAm
 HJOAsCXc163+bzOcDOR28QdByvqBaxt4R4HGxWZb05uxmUa3Pk1+7m/w+
 +4M9nx0w8VsNei4kqsMhXNlTdXK/GuUmAvQUtm10iuZLjvo827ClXM9eo
 Z91gwPDvAJK1wMSIAl8+eWPccbhi0tzm7YUiHUy/Rzs/aUBVSN3b2/ZWz
 RYf44h8y8xGzuWrdJKiITK+5Jo+ZvWYWpv4Qwq9e2SmS/pxSGgzs7lYfz Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="47680454"
X-IronPort-AV: E=Sophos;i="5.88,287,1635174000"; d="scan'208";a="47680454"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 11:27:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJe1ARahaReKrSQjfrBoeM38bIw/d9jwDwFwWDSHH67GHDQ/hmIliVORISwLeOOecCqT2yLZT7MHOowk9fbCLyWJiRzYKDa+jIPRlkp65n0WocHHmzzY1TrmM/bY45mSF5QFFyhnR6DufHO793xynv4/sRECNGjC4WjFJS08MKh9e4UWsa+IVEpcBz3+Wq74BU5KW0h0OxUmQikAHBW2ADO8p/JDcmUU3ahRhZ6OXzde9Jbwt7Jt9FPFY2cp1ThMGzaB9ByzZm4f7UM7GcuZNb//mOjy0ZDhL1bMQgF/Sg5dT18aDWMcg20XDJH1GkUMFVN4DcGNOEGdFXrwUw2h3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OUQwnC+7IKxgV5Dihup22VEdIu29LeOEvGMY0RT/Zo=;
 b=Y12WLu8pavnRkneeep1zHKETRsRuAaY4FtaJNq+anerlktyUHoRkevh/WbmuVZIKpujzk7PsIG0ciu46y284KqmxY4qwXvRL1Bv5CNAvkwVN1tqfaW/IZDHvXMXPojDGWyI8320wgq3rbVteiMLc6iZezSPtbM4xviHLfE/ABsY3c5laOLpqpF0ykotny3bmQ1Fm9fnAnyGwCVvwIGHzrs4FRndQDTsIrlHROQpQbFFqjx6Iz9yhXW5VLGf2MwpA+bd5r1WzSNNj8wvghd//SfJI0SRjtfN0oENNz3GokBmVE2DaXaI/qYsGu9dYbGs5RgvPKEI16Ve3B1gvYLSAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OUQwnC+7IKxgV5Dihup22VEdIu29LeOEvGMY0RT/Zo=;
 b=ceRyG9GDJFwU85dh52leBRmK05OcNpYGha0MJlcut7KNSMQqvWUMwCQtODWq9gbzw/x7YUWls3FspSxPyMV14vd9wpxsxQ1Rg1+UTNyYYQay6DUd+vyRei7IP6MEmIAQOjHRBWqdYs7Lt9PI+kfaH1NX4MCHlYEpZmVeJyM2hVo=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB3930.jpnprd01.prod.outlook.com (2603:1096:404:d4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 02:27:23 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%4]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 02:27:23 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v6 1/3] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
Thread-Index: AQHYB4i4ZbpdnLiKGk6ngv/U6/789qxhAwAAgADKtYA=
Date: Fri, 14 Jan 2022 02:27:23 +0000
Message-ID: <61E0DFC1.6060407@fujitsu.com>
References: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeA1toicLOoqmwyv@yuki>
In-Reply-To: <YeA1toicLOoqmwyv@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46c52745-d76f-48a7-9c2f-08d9d7056622
x-ms-traffictypediagnostic: TY2PR01MB3930:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3930554D3E66BCEAC64C6DA9FD549@TY2PR01MB3930.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FMRKjwSzr6ic8AxM4eR/aXn/LikjMCUHCVRMYN9o7auzwQvXAucoea7wW9fWpZrIpzXFvSKJV+jznKr1dC09Gu+hbBlUucuRL93IA+TJZQQ0WV95ds0NIc8Tf+xDiH7HHGqGzriyHfOzqhFe7GGBBUioisc9O+WwHx1bLj1bOmWtMTQayrIBwR+n6G+pY3dkNm/EaPbKK5VXQzlYc3s7ZLavZ81UfSDOdUCTdkZpCdYPffjiyZgBkyqu1zmFUr3zyybEndMFM5awsP9cxEB+FEHBK3/qf3KdgFAhAHFvBs4Zdbb1n+K+cwjwlgfZQj4gjRuBNCD4ZCz8EHHkpPDAvhmmCw6NTzZ+9OakO5mJvO9xbJgnQptgRzng9Gi4LXzIg0i8P75O1ju6LHKnpvJlAHsKPtImJhININzMn7AylEVCAdQPNz+CZWLabGXWyTsSFfByn9l1HFCN1qOo5jwIa0lOhkCUuFZvMrtJki5x4QGtqF4JLHMsPATFQ931Uj+K2LlT6VkYk08Zy4rSdl8j7qPPtuGhPLuQKctIN7mQJPBk8hU7t+iK8OxT5zMiHqzKLO+jIFeHHgodxVCSmqNY4Iz7HbXtwqN7Xc8CDwa+pLuxUJReWsNQXPWjEUUD1ghceveP0V2mONJvQiaxcyCBFBNqgAgL/CxCSF93jVvRS0XhY2ggqkZ6RE3MLZgNP1VrP0XAxK64kPxoTtFhezlBoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(5660300002)(66556008)(6506007)(33656002)(66446008)(64756008)(76116006)(85182001)(2906002)(38100700002)(4326008)(8936002)(6916009)(8676002)(86362001)(316002)(15650500001)(66946007)(91956017)(82960400001)(6512007)(36756003)(508600001)(122000001)(38070700005)(2616005)(71200400001)(26005)(6486002)(186003)(83380400001)(87266011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bjJKWk43MGw5UVR2OVBWSENSUm1Zdk1WOVczRkl6NlZjNnZWclU1K1RsT3BF?=
 =?gb2312?B?dFgvbkh3b2FGa1FueVFYa3dTUEVwOCtVNk43MEZHWlJWcll5cFVFYVpxQmE3?=
 =?gb2312?B?MU1ueGZhNHZrOWoxSVhQL3VZdFhOeTVOcWRrbVVuY1hSY3c0cU1JbkVKZ2ZK?=
 =?gb2312?B?QXZiNHd1dE1Zdkw3ekk4TjlXYlJpQWZjckJsNmQvU3JnWWNGckp2QkhkOXgv?=
 =?gb2312?B?QURuY2ZEaUtlSmJBbHZSVEVHUE1pWUxlUGRmYkFQb2NXVlYzV281UkE5Yit5?=
 =?gb2312?B?K0dSY0ltWFRwK2F0NFJqYThSYmFYM1JuWFJ4Q0ZiZVUzZ0ZYamJqb2hqNlVF?=
 =?gb2312?B?QTB5NXFaWmlqazFDN21GREMvS0I0NndQc25rSU1BUEQ3aFlRK0RNOGNDdHll?=
 =?gb2312?B?ZnUxeTMzMmFXaG52N0hMbER0aEN4bkJQN3VjSkZsWjgzblJhSEwwYUNLakN0?=
 =?gb2312?B?Sk1qWTB6alNWRmRZd3RZckIvQ1lHNWdDemQzREFyMnFYZkNid2xsQW5UMXJF?=
 =?gb2312?B?L1U4elZ2YWNYUVRjaGw3UVBlOU9WK3NmQTVwMFdwLzVPVjk1Z0ViWm03T1Bq?=
 =?gb2312?B?OEs2OXBFV255UnI3bkw5Z0xSenZaU1ZMZE81QkVmZ2V5QTBFWjZtTHI5Nm1n?=
 =?gb2312?B?a2VFQVAvZU0vQkFtSDF4M2t2Rmd4d0tIMWYyc3IzZ2M5M1g4SjJZSi9Ea2Rv?=
 =?gb2312?B?NHBieUZySG5FMWhoRHdoRXV0RGNieVJZUTNramZJVHpZV2pndEVwaEJ2aFZJ?=
 =?gb2312?B?V0FGcHYxQmxIM3FncHkrbGtGZHluZllweEJiNWlPakFCb1hqRHE4MHVXRnBR?=
 =?gb2312?B?SmxIR0tnbjlnVVlkSTNnaXRuRU12ZmxuYzNXVHhvWkVGK1BDOWR4Y1A2Y3JL?=
 =?gb2312?B?dDU5NjMxWUNpbVhPbFlpd3BWUkdGR2U0NkE4d0R0bkF0eGtCVVR4bnc4TzVj?=
 =?gb2312?B?STl2emhOdHQyTVNuc05wR1ViRWgvSWZEUWtqTzFFWlo3NFhVRzc5Y2xpYVl0?=
 =?gb2312?B?akVQckdHU3QyRTRJZzErS2QwTGZtN29LdzV2d1JKbzVWSTBtV1cxWUdndHA1?=
 =?gb2312?B?b3g1Qml4eGFvMmZ1SUVyK1FOUEttNWNjaHZKbG9KNVoxS3BwSWpZZmZzdWtM?=
 =?gb2312?B?OWhDaE8zUW1SMGc2OG1ldmZ0M2lFSWswZ21NanNjb0M2bmtyRjdTVVF4bksz?=
 =?gb2312?B?aldLZS9rZGwvV1NydzZJaDZRSTgwMU5UenluSVhSc1hnQVB3cnVEZkg2bzBZ?=
 =?gb2312?B?MmlHRFRWQlNWeDJZUW82anBvWWpVMEJnbWMyUG9SR3JxRTF1Y2tkeWdINkZN?=
 =?gb2312?B?SFZvVThhME1CTjM0Q3ppaDdmU0l0Mk1XYzZHWmlQdkF1clZmaUNBeVJwYmtN?=
 =?gb2312?B?bkVLTnBoclJQZHVWR2pwdXJmN2JCYmQvL0w3SUF3NW8zaStrTVdwcDJTQThX?=
 =?gb2312?B?T043enJURUlycnIzOE1aV3ZybjRCNWoxcko3R1ZTWC9NTGVNN28vU1Y5ckE2?=
 =?gb2312?B?eGpLMStWUXBXZmRoREQ5dkQ2eDBxc1YxUTJYYlQ5U1JHVXhtbFNtV0grRWlk?=
 =?gb2312?B?RzZiSFJXS2hGb1ptM2VTajQzdkxWNUdtSUNiM3dsWW9TT0xUODZ1VkNIUjFG?=
 =?gb2312?B?OHJ6b3QyYkRxRkxrNHZvNDdTQU1IbVJoREt4a1BCUnlWMmtHaG1WRjVxSUJH?=
 =?gb2312?B?cTVlblMyT1J2cTRBWWNrQXlnNUhCMkU2dm5aVUMwZVhvKzZWenpGVWc2VVJh?=
 =?gb2312?B?a0JOODlUMk9wb3dZQlkvVHN3YmxtelljKzYySG41RFhZZWdzZGZmRlBIRVdT?=
 =?gb2312?B?UDIrYmxMKy9oTnVCS01rY0Z5aExBVEloTThNUFRJVm9ocmxYQldwUWlPZGhD?=
 =?gb2312?B?cHRlU0VMY2xZWUFMWW5RYzdDMHFsNXlVK3ZLdXg5aHBkUzhqTHNyc3R4UE0x?=
 =?gb2312?B?ZDh5c0dxYXZCSUMvVzN6T1FJNWsrNnNXVGxST0dQWmllcVRUSEpBVDNMVDRB?=
 =?gb2312?B?aHBURmxCOFRERSt4TXNUQXdteFRRaGMxdHB6VDd4RWZSWE11Vm41Mmp6Z2pk?=
 =?gb2312?B?VTByTmVLTVQxSnZjQmN5WnZoTXFBK3llL3FaUmlmZ1AvSWRsN2dYZ0IyZklz?=
 =?gb2312?B?VWJiZE16VGllS1BTNEg4NVI5Wk5Gd2puMHRUT1ZKK3IrQUtHS3hyeXlib1lS?=
 =?gb2312?B?RkMrS1BZeFJrcFVXR0ZXVUxyMjZXeHcxMFF1QWZpQnRwYmQrTE1UaXJqQzBD?=
 =?gb2312?Q?sGyRFxesOXur/X6HxhIjASFpHL9+xDiCj1eSBOVoQE=3D?=
Content-ID: <E9FE71BD8A632B49AE7FC83E7EFCF0DA@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c52745-d76f-48a7-9c2f-08d9d7056622
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 02:27:23.7207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yacvo7MCIXSz4tzCLnafQUNLZjZFPlBmMb6uTIu+t7FiXkCQb1DxaDjaHjx4Qgj/VJTbIMeFiigxpy+qLpHheBxgP/fpYY0m+TvmL419+Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3930
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
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
>> +/*\
>> + * [Description]
>> + *
>> + * Tests basic error handling of the quotactl syscall without visible quota files
>> + * (use quotactl and quotactl_fd syscall):
>> + *
>> + * - EFAULT when addr or special is invalid
>> + * - EINVAL when cmd or type is invalid
>> + * - ENOTBLK when special is not a block device
>> + * - ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the range
>> + *   allowed by the quota format
>> + * - EPERM when the caller lacked the required privilege (CAP_SYS_ADMIN) for the
>> + *   specified operation
>> + * - EINVAL when cmd is Q_QUOTAON, but the fd refers to a regular file(doesn't
>> + *   under this moutpoint)
>> + *
>> + * Minimum e2fsprogs version required is 1.43.
>> + */
>> +
>> +#include<errno.h>
>> +#include<sys/quota.h>
>> +#include "tst_test.h"
>> +#include "tst_capability.h"
>> +#include "quotactl_syscall_var.h"
>> +
>> +#define OPTION_INVALID 999
>> +
>> +static int32_t fmt_id = QFMT_VFS_V1;
>> +static int test_id, mount_flag;
>> +static int getnextquota_nsup, external_fd = -1;
>> +
>> +static struct if_nextdqblk res_ndq;
>> +
>> +static struct dqblk set_dqmax = {
>> +	.dqb_bsoftlimit = 0x7fffffffffffffffLL,  /* 2^63-1 */
>> +	.dqb_valid = QIF_BLIMITS
>> +};
>> +
>> +static struct tst_cap dropadmin = {
>> +	.action = TST_CAP_DROP,
>> +	.id = CAP_SYS_ADMIN,
>> +	.name = "CAP_SYS_ADMIN",
>> +};
>> +
>> +static struct tst_cap needadmin = {
>> +	.action = TST_CAP_REQ,
>> +	.id = CAP_SYS_ADMIN,
>> +	.name = "CAP_SYS_ADMIN",
>> +};
>> +
>> +static struct tcase {
>> +	int cmd;
>> +	int *id;
>> +	void *addr;
>> +	int exp_err;
>> +	int on_flag;
>> +	int use_external_fd;
>> +	char *des;
>> +} tcases[] = {
>> +	{QCMD(Q_SETQUOTA, USRQUOTA),&fmt_id, NULL, EFAULT, 1, 0,
>> +	"EFAULT when addr or special is invalid"},
>> +
>> +	{QCMD(OPTION_INVALID, USRQUOTA),&fmt_id, NULL, EINVAL, 0, 0,
>> +	"EINVAL when cmd or type is invalid"},
>> +
>> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, NULL, ENOTBLK, 0, 0,
>> +	"ENOTBLK when special is not a block device"},
>> +
>> +	{QCMD(Q_SETQUOTA, USRQUOTA),&test_id,&set_dqmax, ERANGE, 1, 0,
>> +	"ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the range"},
>> +
>> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, NULL, EPERM, 0, 0,
>> +	"EPERM when the caller lacked the required privilege for specified operations"},
>> +
>> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, NULL, EINVAL, 0, 1,
>> +	"EINVAL when cmd is Q_QUOTAON, but the fd refers to a regular file(doesn't under "
>> +	"this mountpoint)"}
>> +};
>> +
>> +static void verify_quotactl(unsigned int n)
>> +{
>> +	struct tcase *tc =&tcases[n];
>> +	int quota_on = 0;
>> +	int drop_flag = 0;
>> +
>> +	tst_res(TINFO, "Testing %s", tc->des);
>> +	if (tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA)&&  getnextquota_nsup) {
>> +		tst_res(TCONF, "current system doesn't support Q_GETNEXTQUOTA");
>> +		return;
>> +	}
>> +
>> +	if (tc->on_flag) {
>> +		TST_EXP_PASS_SILENT(do_quotactl(fd, QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
>> +			fmt_id, NULL), "do_quotactl(QCMD(Q_QUOTAON, USRQUOTA))");
>> +		if (!TST_PASS)
>> +			return;
>> +		quota_on = 1;
>> +	}
>> +
>> +	if (tc->exp_err == EPERM) {
>> +		tst_cap_action(&dropadmin);
>> +		drop_flag = 1;
>> +	}
>> +
>> +	if (tst_variant) {
>> +		if (tc->exp_err == ENOTBLK) {
>> +			tst_res(TCONF, "quotactl_fd() doesn't have this error, skip");
>> +			return;
>> +		}
>> +	} else {
>> +		if (tc->use_external_fd) {
>> +			tst_res(TCONF, "quotactl() doesn't use fd, skip");
>> +			return;
>> +		}
>> +	}
>> +	if (tc->exp_err == ENOTBLK)
>> +		TST_EXP_FAIL(do_quotactl(fd, tc->cmd, "/dev/null", *tc->id, tc->addr),
>> +			ENOTBLK, "do_quotactl()");
>> +	else
>> +		TST_EXP_FAIL(do_quotactl(tc->use_external_fd ? external_fd : fd, tc->cmd,
>> +			tst_device->dev, *tc->id, tc->addr), tc->exp_err, "do_quotactl()");
>> +
>> +	if (quota_on) {
>> +		TST_EXP_PASS_SILENT(do_quotactl(fd, QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
>> +			fmt_id, NULL), "do_quotactl(QCMD(Q_QUOTAOFF, USRQUOTA)");
>> +		if (!TST_PASS)
>> +			return;
>> +		quota_on = 0;
>
> There is no need to clear this flag.
Yes, good catch, will also remove this in quotactl06.c.
>
>> +	}
>> +
>> +	if (drop_flag) {
>> +		tst_cap_action(&needadmin);
>> +		drop_flag = 0;
>
> And this flag.
>
>> +	}
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	unsigned int i;
>> +	const char *const fs_opts[] = { "-O quota", NULL};
>> +
>> +	quotactl_info();
>> +	external_fd = SAFE_CREAT("testfile", O_RDONLY);
>> +
>> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
>> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>
> Why don't we pass the fs_opts in tst_test instead and use .mount_device = 1?
The code is pasted from quotactl06.c there use 
tst_require_quota_support. Here we don't use it, so we can use 
.mount_device directly.

Best Regards
Yang Xu
>
> Should be as easy as:
>
> static struct tst_test test = {
> 	...
> 	.dev_fs_opts = (const char *const []){"-O quota", NULL},
> 	.mount_device = 1,
> 	...
> };
>
> Or is there a reason why this wouldn't work?
>
>
> With the changes outlined in the other email and the minor issues I've
> pointed out here fixed:
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>

>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
