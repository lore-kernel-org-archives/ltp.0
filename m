Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1000C4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 06:39:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAA8E3CB049
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 08:39:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EFF23C1BC0
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 08:39:41 +0200 (CEST)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B0C086008DE
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 08:39:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1666075182; x=1697611182;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=909aFkvdkLJuDySC+j6206a8Ijaj4qQ6kLwKljtGQpk=;
 b=cHKrH3dFZ9YcuAJtGP6XiFTG7S9wTPEULS+a+vM8Jnmo1+LOcKLZLQiO
 x/vpaDBMKGz9EnFwPmdTyBTs5w8bDZr22g8BA/iZHAKP/qhTtb4uFAHMX
 1ifC/3B1QfsqW5x4z7e6kV3L+RBXXPS4sHQtEV0OV0+mspF9DjDOwpdac
 qanZ7sqqvRXgyj531wVmBF+pWcABCQNdFQ2ZFFI8JegnBZQUvGKrJ+EPE
 DboPbdhHfsxih6eHdo9319f4FkCXmYaRlY5pfTd5dTK1w+cgcxBGLLN+T
 gvCLiUkjuDJCZZxXTZDubAEN/c5OObb9AJCOOMPqEFQTfpYxrvD1Y9Fs/ Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="67529827"
X-IronPort-AV: E=Sophos;i="5.95,193,1661785200"; d="scan'208";a="67529827"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2022 15:39:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIL6ETzC3rZw0Nhitcyg3BopXZnhKO5jVgP1VLm/STJT4cYJr0Gh40WCIRV9kKGyZwElg0kxUeqIy5XAwq2hSvoH55/gP5qGnH2TfpzDmEJ9MFVsZhBo3izmIy35suqMjbEW2dy74GvZLALg+6WTlwPPiAjTzEcSuvDKlzOspqpI1eJhWSmA8Xg3TXR8/KUDCmFLZ06mztqX9dHVWZuq35YE0D1Tqu8M629+4EUC19wMXoYN/rkxlDRryxUQTYU3/UdURSF4CDFyOt9ziMvr0t7ec/1axvevUcCiGA8swELKcK29pTU1m8zhkaLYELJB+9qpG6daJXOpwORya+xbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=909aFkvdkLJuDySC+j6206a8Ijaj4qQ6kLwKljtGQpk=;
 b=LnQmSzTR2tSxLZ+8Rg2mWoVQjOUQgt6xfnMJM/wug1Pt3R16Q/UP0puYxDntLL7o/3mXwcXoYGAQ7pFLTJ+1dCsWLSyWfL470jdZcuZhJ6FdppEY6kO6W/ctJXz5R25Bk5keShZ+/Xl4egYvGKFnEdNRjOUemSjy1YngorxkougFmRoOpsI0UufkINoWJioZOqz1xQe6Xyid02u6ct57QShUd1x6R/eb+0L7X5MkS2xJCI6nJVTgNlfgL6KxUYo19d9swUNYny3jnM6ZafOJHqy2us2NazRiFMTs7OrVLZfBFn38RaNhbg8YTu/zKnGx4uoCG8BBSKo2CNjXcGkHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 06:39:34 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 06:39:34 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>, "liaohj.jy@fujitsu.com"
 <liaohj.jy@fujitsu.com>
Thread-Topic: [LTP] [PATCH] syscalls/fork01:Convert into new api
Thread-Index: AQHYyKGYJM0nrGSpAU++Pi+bIplfPa4SsPkAgAFHbwA=
Date: Tue, 18 Oct 2022 06:39:34 +0000
Message-ID: <667dc5ef-1e19-fcb3-64cd-38eee906e98d@fujitsu.com>
References: <1663204902-4185-1-git-send-email-liaohj.jy@fujitsu.com>
 <87h702oce4.fsf@suse.de>
In-Reply-To: <87h702oce4.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OS0PR01MB5747:EE_
x-ms-office365-filtering-correlation-id: e3782d02-d8b5-4c73-403a-08dab0d3854f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TbSnrWkiUmNBJTODY3hCzweio3BThsHNqWgYTPSbhVgvQWKGEtFaMWrAEmb7J4qViBOfqI1MB6syED5ptOVYLTgE4nJuVxuIMuH1c1ZgzwnA6nqpCphJaIM5Z5yK7s9HqCgOd3vs+FDFOmT+wCzq+DcRWV7JnTEvldcV/DB0Crcf7aaaJxjA+m0hR08wgUujA7oSNgpis6GXRNpaKDOoNl9tcvDrvH2JXsZ0L5CT2LatB2Y1iTNqZFjUtddKF7q60g2k+bvL3MsbXslPuTwgAJgMjyNtKT/NK2rMoQapOZe0uXweXpU4EObaDvJuvRT5i0nPki4ja3LyP1kahkktNAWqF+lZMshYkSuB8L9lRNhOLvg+9sDhJL8D1TVLzA9v6ZVlrdvN7MLaggKSiSf+TXaBYaO8tUS9oCAo9RoWh6A8l1jUWL3DHJkVW037j7oxUQ1hVf8cxBbFbDS+Up7yNw4fqA1WIsKSFgioZyPNkggg2kg6uwKGVOgoYjiQjhwsbZONXsp8CXYNdqWnKoVLEvFbX5u9KKXDs2dDZzA3bPh+a4kRfhQUMIfiggO7kywpqVLGs44Cez++UoLibx6jFlboYqWWDHCZFGrIKhJbKh/xfbaWvX0HB7QASTXZhd4L4HCtE6tGoXhaoWkKmMw2YSSWGAOR1NwiuZocqKxwReDEhS6D9ZFMVgd3qAO5huHhJTJtxDguU1ZLFf6tAMz1gTicaCch+xkEtGrbdhuG827MoCv553SP0PXcUdRgnjh3UX9G5xjkIYAPXmsg6eFJCsx6TgOEmELS0nN+iV/oHtGSzBFgOeNDMKZ2j0O6LPlq4FEwBw5TtOJSMuJbVMuzwgAmK5OD5hOYZsCq/Gp5RlRku4/wCqof+790hLFr9uA6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(1590799012)(451199015)(6486002)(71200400001)(2616005)(186003)(38070700005)(83380400001)(41300700001)(86362001)(31696002)(82960400001)(122000001)(38100700002)(5660300002)(2906002)(4326008)(8676002)(64756008)(6512007)(478600001)(110136005)(26005)(966005)(6506007)(316002)(66556008)(66476007)(66946007)(76116006)(8936002)(91956017)(66446008)(6636002)(31686004)(36756003)(85182001)(1580799009)(2004002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3IvMzk5c3BjNFgxUHhiNkNCdGVDblVRYVJYdis1ZXlqanA2dVJLSVM1YkZn?=
 =?utf-8?B?M1ZlQjhuYmFnR3JJMnBMOXlGS1Y3MzUwQ2tmNUo5WjF4TTdDalJFTDZhalZi?=
 =?utf-8?B?UnJOQldzeXVJUnBsVVFqamZaazVqc2IxRWVpeWJJeUpDak5aakVicENZNCtn?=
 =?utf-8?B?KzdWaXdadTE3TlBEYXlraWtsa2F4QVI1NzlLKzc5WHFvc3ZBQWFpT1Z0Tnl0?=
 =?utf-8?B?SlFZWVpSTU12Tk1iRVNWWEhXdDlLbFV4MFA3MGxaYWJUVXJibUtUYU5CVExy?=
 =?utf-8?B?RHk1cW80VWkwemRDSHBaNXRuUFhJeVgwMzJ5cmlPaElLVjN2YjlmaFY4T3cz?=
 =?utf-8?B?MFNKMTlqdUREVm1nQlFoN2RVdnBWTWFCRmV0ZnJSZkJiWXhHUUx1dW12bjhv?=
 =?utf-8?B?bzRra1Z2ZTZIQVpxd1dlSDA0bzR3UnlEMjNlZ3FmTGNmK1N1ejVsNjVDMDJF?=
 =?utf-8?B?dHVad2tuS3p1RFNnVVQwYklnbTRid3dzTG1BT0pkaXE0R0x2ZnVEb2JrSHR2?=
 =?utf-8?B?MzRybHJLM1E0NDd1SlZuS291WTNzVG5xS0hENFpoUXdOOXgweG82TUw5eFcz?=
 =?utf-8?B?bU5mWkxkalVreHN6UVovYnc2c2ZFMXFVSWN2TkY0Y2lGeFpNWE5WZXQzOXRK?=
 =?utf-8?B?Q3NLN0ZnbmpaYkJZaWJpL2hkY1YvTmdSWVFKMWdidEFRWmNSWVMwY3pTNUd0?=
 =?utf-8?B?U1o1Y3RLN2NESWFxaWJKcGVwK2dqT3lROFpYNWhvd3hINk5DaGtPNlljWFJK?=
 =?utf-8?B?RlRiUW82Y3ZBRlFmU0ZpUXVqWEk0UmFvVUVGdVlUZ2ZVczRBVmswREoyZjBP?=
 =?utf-8?B?VlRNU1dJZENFT3UzTGF1K3d6Z2JoeUhETFc4RXBKOFBsNVpiWWsxODJvZEVm?=
 =?utf-8?B?dEZjdG9UWll3TC9KRkcySDhPeCsvUXUxT05Wdmg2SkU0ZW8xVEpNOG55Z2t0?=
 =?utf-8?B?NmIvWVpKQ0dLZ2poeXRPUkt6VWp2Y013NDI3ZU5hSjZWUjRIYjBkcjZGWDRB?=
 =?utf-8?B?QThYSkh1VkI5ajdYTXhPbWhnaHhBNTMzSDZkWUw2dzhVWjMzNW43NWpkMGZ2?=
 =?utf-8?B?UzZ1bUVSWVJZMzZLYkFBc2s1NVB5ckJaaU1HdjVIUzBJbmUzcHdDV0poSDQ2?=
 =?utf-8?B?aDUwTWR3RDJibHlWdExleHpQajB5bWZiM3pDbDN4b1dqSmVuRTZiajlTSDRu?=
 =?utf-8?B?TGtOT3hIL05Jc1VReDF6M1l2SEcrZW1FbFM3MnRvTTAzUU1WSkdzUXpGNnZj?=
 =?utf-8?B?eVZya2orZW9HeTYyTDROdUxHNDhUSnNndWFqeDRhTXM5T09vVFlTaGRLL2lB?=
 =?utf-8?B?YWlocEo3Mk9EZU9ROEdDOHhVUm0yZzduY2xqYkhLRldFUXg2N3pZM3Z4cHdR?=
 =?utf-8?B?SlgyMWc5K0dlTklETzhMRFd5TEFKVDNpWXVkRXFKbW5Lb3NQV1VPUVcrZFdU?=
 =?utf-8?B?cWovT2xwNlgzaTB5aWxGVnFHS1g4d0luUzhzNWU0a0kvdDBBSE9pa0p1cXJn?=
 =?utf-8?B?aitMbnZXQnBEUEdmMFBmZEV0RkxIQ29BMmVzOEZhbVpaUWVDT05IVUJQcXNt?=
 =?utf-8?B?YWk0VkNQWkNIR29nb0ZzM3c4ckVjc2lBUnpxYm41OHIwSm5SZ0hsTERCSG80?=
 =?utf-8?B?d3psY2pSWmlTaysrdjc1VEtYWVhrcTZwazVUL3Z2NW1KMzhnanp5OG1lUGJE?=
 =?utf-8?B?U0twNzN2RWYwb05NajdvYTR2UFY4NSs4L0poTzdaNnZMeFp2RXljRi92Wk51?=
 =?utf-8?B?WXU4S0Q2UHdiTkpadG1SVVN6Z2E1VDBSOFMvcUhYMWVVbk5wMExqSDhCQmhL?=
 =?utf-8?B?TWdBU2lIT1NlVjJrZXR3QVNSVWpKSVZPYllWeTZKNm9uekVrR0YyMExud0dT?=
 =?utf-8?B?U3RoSkxoV0Nkd3l2aVA1Nkt1bktLeWo0b3pqZlkrazQ3RUNjWmJOM2l4QzNI?=
 =?utf-8?B?WDBSRWRSM1pCbWxiVjFrYnVjUWhtQmR0NktYaFlmVTJTVm1ERUpOWGw2dU10?=
 =?utf-8?B?MTFTYXo4VzhHci9CU0dYNzErNldhSC9ZYS9aVktCWmJSRy95Q3RtZGM3NFNv?=
 =?utf-8?B?SUM5OHB6cUdmSFU2R1MvL1NuMVJlTis3QmRDL2V2TzBYSkdaRzVydDRVcCtz?=
 =?utf-8?B?QXorVVhheHlCaUJMN0E1ckduT0ZCSjJKc2k2RWZNMkZ5VHlDSUYrUFNGTWw2?=
 =?utf-8?B?ZVE9PQ==?=
Content-ID: <E3E960DD44B10743B2B2A64A42CE8290@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3782d02-d8b5-4c73-403a-08dab0d3854f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 06:39:34.6873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmjJDQNMJ3ZSd7qjUZrlP/MVE2IxQWHuCnz4tuNhzOZslVZPJ4tFtS/CUt65lYOYNr//Y0DQSYh95szYuaHl1KSNYJrn3ADjskvEarlf7ZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fork01:Convert into new api
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

Hi Richard

Since Liao has did other work,  I will continue to do these cleanup works.

> Hello,
> 
> Liao Huangjie <liaohj.jy@fujitsu.com> writes:
> 
>> From: Huangjie Liao <liaohj.jy@fujitsu.com>
>>
>> Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/fork/fork01.c | 253 ++++++------------------
>>   1 file changed, 55 insertions(+), 198 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/fork/fork01.c b/testcases/kernel/syscalls/fork/fork01.c
>> index 00d7c45c4..8ba712805 100644
>> --- a/testcases/kernel/syscalls/fork/fork01.c
>> +++ b/testcases/kernel/syscalls/fork/fork01.c
>> @@ -1,91 +1,17 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>>    * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>> + * Author: Kathy Olmsted
>> + * Co-Pilot: Steve Shaw
>> + */
>> +
>> +/*\
>> + *[Description]
>>    *
>> - * This program is free software; you can redistribute it and/or modify it
>> - * under the terms of version 2 of the GNU General Public License as
>> - * published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it would be useful, but
>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> - *
>> - * Further, this software is distributed without any warranty that it is
>> - * free of the rightful claim of any third person regarding infringement
>> - * or the like.  Any license provided herein, whether implied or
>> - * otherwise, applies only to this software file.  Patent licenses, if
>> - * any, provided herein do not apply to combinations of this program with
>> - * other software, or any other product whatsoever.
>> - *
>> - * You should have received a copy of the GNU General Public License along
>> - * with this program; if not, write the Free Software Foundation, Inc.,
>> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> - *
>> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
>> - * Mountain View, CA  94043, or:
>> - *
>> - * http://www.sgi.com
>> - *
>> - * For further information regarding this notice, see:
>> - *
>> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
>> - *
>> - *
>> - *    OS Test - Silicon Graphics, Inc.
>> - *    TEST IDENTIFIER	: fork01
>> - *    EXECUTED BY	: anyone
>> - *    TEST TITLE	: Basic test for fork(2)
>> - *    PARENT DOCUMENT	: frktds02
>> - *    TEST CASE TOTAL	: 2
>> - *    WALL CLOCK TIME	: 1
>> - *    CPU TYPES		: ALL
>> - *    AUTHOR		: Kathy Olmsted
>> - *    CO-PILOT		: Steve Shaw
>> - *    DATE STARTED	: 06/17/92
>> - *    INITIAL RELEASE	: UNICOS 7.0
>> - *    TEST CASES
>> - *	1.) fork returns without error
>> - *	2.) fork returns the pid of the child
>> - *    INPUT SPECIFICATIONS
>> - *	The standard options for system call tests are accepted.
>> - *	(See the parse_opts(3) man page).
>> - *    OUTPUT SPECIFICATIONS
>> - *    DURATION
>> - *	Terminates - with frequency and infinite modes.
>> - *    SIGNALS
>> - *	Uses SIGUSR1 to pause before test if option set.
>> - *	(See the parse_opts(3) man page).
>> - *    RESOURCES
>> - *	None
>> - *    ENVIRONMENTAL NEEDS
>> - *      No run-time environmental needs.
>> - *    SPECIAL PROCEDURAL REQUIREMENTS
>> - *	None
>> - *    INTERCASE DEPENDENCIES
>> - *	None
>> - *    DETAILED DESCRIPTION
>> - *	Setup:
>> - *	Setup signal handling.
>> - *	  Pause for SIGUSR1 if option specified.
>> - *	Test:
>> - *	 Loop if the proper options are given.
>> - *        fork()
>> - *	  Check return code, if system call failed (return=-1)
>> - *		Log the errno and Issue a FAIL message.
>> - *	  Otherwise, Issue a PASS message.
>> - *        CHILD:
>> - *           determine PID
>> - *           write to PID to a file and close the file
>> - *           exit
>> - *        PARENT:
>> - *           wait for child to exit
>> - *           read child PID from file
>> - *           compare child PID to fork() return code and report
>> - *           results
>> - *
>> - *	  Cleanup:
>> - *           Print errno log and/or timing stats if options given
>> + * This case tests fork()'s basic function.
> 
> The original descrption had more info than this. In particular:
> 
>> - *	1.) fork returns without error
>> - *	2.) fork returns the pid of the child

Ok, will keep it.
> 
> 
>>    */
>>   
>> +#define _GNU_SOURCE
>>   #include <errno.h>
>>   #include <string.h>
>>   #include <signal.h>
>> @@ -93,142 +19,73 @@
>>   #include <stdlib.h>
>>   #include <sys/types.h>
>>   #include <sys/wait.h>
>> -#include "test.h"
>> +#include <unistd.h>
>> +#include <stdio.h>
>> +#include "tst_test.h"
>>   
>>   #define	KIDEXIT	42
>> -static void setup();
>> -static void cleanup();
>> -
>>   #define LINE_SZ	20
>>   #define FILENAME "childpid"
>>   
>> -char *TCID = "fork01";
>> -int TST_TOTAL = 2;
>> +static char buf[LINE_SZ];
> 
> This doesn't need to be a global var. In fact we don't need it at all
> (see below).
> 
>>   
>> -/*
>> - * child_pid - the child side of the test
>> - *             determine the PID and write to a file
>> - */
>> -static void child_pid(void)
>> +static void do_child(void)
>>   {
>> +	int fd;
>>   
>> -	int fildes;
>> -	char tmp_line[LINE_SZ];
>> -
>> -	fildes = creat(FILENAME, 0700);
>> -	sprintf(tmp_line, "%d\n", getpid());
>> -	write(fildes, tmp_line, LINE_SZ);
>> -	close(fildes);
>> -
>> +	fd = creat(FILENAME, 0700);
>> +	sprintf(buf, "%d\n", getpid());
>> +	SAFE_WRITE(1, fd, buf, LINE_SZ);
>> +	SAFE_CLOSE(fd);
>>   }
> 
> This whole function can be replaced with SAFE_FILE_PRINTF i.e
> SAFE_FILE_PRINTF(FILENAME, "%d", getpid());
> 

Yes.

>>   
>> -/*
>> - * parent_pid - the parent side of the test
>> - *              read the value determined by the child
>> - *              compare and report results
>> - */
>> -static void parent_pid(void)
>> +static void check_child_pid(int pid)
>>   {
>> +	int fd;
>> +	pid_t child_pid;
>>   
>> -	int fildes;
>> -	char tmp_line[LINE_SZ];
>> -	pid_t child_id;
>> +	fd = SAFE_OPEN(FILENAME, O_RDWR);
>> +	SAFE_READ(1, fd, buf, LINE_SZ);
> 
> This can be replaced with SAFE_FILE_SCANF(FILENAME, "%d", &child_pid);

Yes.
> 
>>   
>> -	fildes = open(FILENAME, O_RDWR);
>> -	if (fildes == -1) {
>> -		tst_brkm(TBROK, cleanup,
>> -			 "parent open failed. errno: %d (%s)\n",
>> -			 errno, strerror(errno));
>> +	child_pid = atoi(buf);
>> +	if (child_pid != pid) {
>> +		tst_res(TFAIL, "child reported a pid of %d. parent received %d from fork()",
>> +				child_pid, pid);
> 
> This can be replaced with TST_EXP_EQ_LI(child_pid, pid).

Will do.
> 
>>   	} else {
>> -		if (read(fildes, tmp_line, LINE_SZ) == 0) {
>> -			tst_brkm(TBROK, cleanup,
>> -				 "fork(): parent failed to read PID from file errno: %d (%s)",
>> -				 errno, strerror(errno));
>> -		} else {
>> -			child_id = atoi(tmp_line);
>> -			if (TEST_RETURN != child_id) {
>> -				tst_resm(TFAIL,
>> -					 "child reported a pid of %d. parent received %ld from fork()",
>> -					 child_id, TEST_RETURN);
>> -			} else {
>> -				tst_resm(TPASS,
>> -					 "child pid and fork() return agree: %d",
>> -					 child_id);
>> -			}
>> -		}
>> -		close(fildes);
>> -	}
>> -}
>> -
>> -int main(int ac, char **av)
>> -{
>> -	int lc;
>> -	int fails;
>> -	int kid_status, wait_status;
>> -
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	setup();
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -		tst_count = 0;
>> -		fails = 0;
>> -
>> -		TEST(fork());
>> -		if (TEST_RETURN == -1) {
>> -			tst_resm(TFAIL, "fork() Failed, errno=%d : %s",
>> -				 TEST_ERRNO, strerror(TEST_ERRNO));
>> -			tst_resm(TBROK, "unable to continue");
>> -		}
>> -		if (TEST_RETURN == 0) {
>> -			/* child */
>> -			child_pid();
>> -			exit(KIDEXIT);
>> -		} else {
>> -			/* parent */
>> -			tst_resm(TPASS, "fork() returned %ld",
>> -				 TEST_RETURN);
>> -			/* wait for the child to complete */
>> -			wait_status = waitpid(TEST_RETURN, &kid_status, 0);
>> -
>> -			if (wait_status == TEST_RETURN) {
>> -				if (kid_status != KIDEXIT << 8) {
>> -					tst_resm(TBROK,
>> -						 "incorrect child status returned on wait(): %d",
>> -						 kid_status);
>> -					fails++;
>> -				}
>> -			} else {
>> -				tst_resm(TBROK,
>> -					 "wait() for child status failed with %d errno: %d : %s",
>> -					 wait_status, errno,
>> -					 strerror(errno));
>> -				fails++;
>> -			}
>> -			if (fails == 0) {
>> -				/* verification tests */
>> -				parent_pid();
>> -			}
>> -		}		/* TEST_RETURN */
>> +		tst_res(TPASS, "child pid and fork() return agree: %d", pid);
>>   	}
>>   
>> -	cleanup();
>> -	tst_exit();
>> +	SAFE_CLOSE(fd);
>>   }
>>   
>> -static void setup(void)
>> +static void verify_fork(void)
>>   {
>> +	int kid_status, term_pid, pid;
>>   
>> -	tst_sig(FORK, DEF_HANDLER, cleanup);
>> -
>> -	TEST_PAUSE;
>> -
>> -	tst_tmpdir();
>> -}
>> +	pid = SAFE_FORK();
>> +	if (!pid) {
>> +		do_child();
>> +		exit(KIDEXIT);
>> +	}
>>   
>> -static void cleanup(void)
>> -{
>> +	term_pid = SAFE_WAITPID(pid, &kid_status, 0);
>> +	if (term_pid == pid) {
>> +		if (kid_status != KIDEXIT << 8)
>> +			tst_res(TFAIL, "incorrect child status returned %d", kid_status);
>> +		else
>> +			tst_res(TPASS, "correct child status returned
>> %d", kid_status);
> 
> The original test is not strictly correct. We should check if the child
> exited with WIFEXITED and use the WEXITSTATUS macro to get the exit
> status.

OK.
> 
>>   
>> -	tst_rmdir();
>> +		check_child_pid(pid);
>> +	} else {
>> +		tst_res(TFAIL, "waitpid() returns %d instead of  expected pid %d", term_pid, pid);
>> +	}
>>   
>> +	tst_reap_children();
>>   }
>> +
>> +static struct tst_test test = {
>> +	.needs_tmpdir = 1,
>> +	.needs_root = 1,
> 
> It doesn't need root.
Yes.

Best Regards
Yang Xu
> 
>> +	.forks_child = 1,
>> +	.test_all = verify_fork,
>> +};
>> -- 
>> 2.27.0
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
