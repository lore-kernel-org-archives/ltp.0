Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859D4C433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 08:41:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E0113CAE8E
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 10:41:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3AAC3C3030
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 10:40:50 +0200 (CEST)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 39A5610009F4
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 10:40:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1665477648; x=1697013648;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=5QY232TGt/FPrezkuQKp8GO4r3tD/HN4Gw8iz+fRxto=;
 b=e3Qbzoy8smoa8FzYaR4CRovg+9WONCOvQ8cAnObXB/4SWhUAhf0ZAILx
 nczi40H378MpSVqEhChaiRKQl8ZX2uKQMrml4Nw3ZdKM0ftNR4FFPR9JQ
 bVgltfMtYaHm1fwI38o8rOe89nOeZuRPPI5JDx0iVijBvAkmUyPB3bZh/
 6lxq8AQQPpXLIEmY17JPtC6t1yCRxnGBNegqImIds7SIaEByZ5gMDjbNn
 64PhDYQ+ngctKlcq9bCue5maLV+PQcligzkFXq4Qds4uME89LUtW2TjsL
 UI2wFnCa7h87IUtCP5HW4E2iT+gurmrXTBcCl6T62wQpN+m0drs6FifRi A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="67392304"
X-IronPort-AV: E=Sophos;i="5.95,175,1661785200"; d="scan'208";a="67392304"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2022 17:40:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/auCWEqpsSpGNjcij7F03nqZ851z2bmF/3VXqpBd7eA5Cl5eJGnI4t41DLEJIpF4wDjF/SLR0KDHBT5Yoear3qNynbFFUwS3VlFSQe9A4jEUhpJJ2WCs31I7rMGNE+0OWL4tR9dA/s+gYC+++t3WTkJkLSYZPIicgzsyz2Ox5I1LBBmRFodNrBhFMlz83xQcVbi1ppn2IQi1G/LQNcXrl0gSYGSqGtAvVjyrD3VNdP5KGFD4gSMLbiERsEpZB4qOXCIRhnWKZr0JcfNHyj8xehflBiNk0bjBJXn2ZD1788DHL7Q4MPe8l6rNuwlHDmAXdfCuyz2jltLtE8+WYJbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QY232TGt/FPrezkuQKp8GO4r3tD/HN4Gw8iz+fRxto=;
 b=BXWSRypj2h/M2Mt6DDCGQkwutu7i0lGzJ97IyKDjtUW97+cz7Jh9F+NKk47YYJKwce/8GPEJpms9GLRwL3+alcWhphEGIJafYyty4qwqaC0iI8WmXZDdX9KE3UKOGu97fn9dSL8SYb9LnEkt5mJ2f8SxxZxAFTOqnA0lS15QcqnshJafjJ6p230vJ5Y02bsaNeR3/E53KnfsxmPo6audWrfTI6ynHKmmL+Btc+t+KoRcfuAnv7DNohMTmtOK5w3DqEK9WSh4dnxPQsbX49l1q26ADKOfiyZi5pUpbDwRgtHqBoinkjsThQ+Vc2FMNw8dJoU7SnsFoFHQ9Hy9ebP1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB9815.jpnprd01.prod.outlook.com (2603:1096:400:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 08:40:44 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 08:40:44 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [PATCH v2] syscalls/prctl10: Add basic test for PR_SET/GET_TSC
Thread-Index: AQHY3TGcgMthCOzBKkeSYQs7/GoiFq4IznyAgAAiYoA=
Date: Tue, 11 Oct 2022 08:40:44 +0000
Message-ID: <e797b6d1-c42e-46df-df5f-d1e96470ed1b@fujitsu.com>
References: <87a663als4.fsf@suse.de>
 <1665469442-2051-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87wn9692zk.fsf@suse.de>
In-Reply-To: <87wn9692zk.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|TYCPR01MB9815:EE_
x-ms-office365-filtering-correlation-id: a8098c51-01d7-44ac-0452-08daab644951
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/LY3nUDVUcOBGogfsiRGtw2EBrAeNPXmwROQXYOsLk34fwsUuJ4CPPIpfA/iHz5OK7dPB+Lx4nCOnvEtakFRVZolscUJdqd6OqWkFnIPcdY6u8gI6hNeNcJZLRMfUe/FC+wt8T7zTmLzyxwvoXOCyqUs+x+156N7fjW9fxlBaAUk7ZwxpKKfjhZvW4tYVLiCLJe9B/IxHPwxA0OV2NHyij9Od0yc2FGKFhY5jS+UKpPTBDq+QrCkJjPCagkMMDfY5UM3m6P5gyO85YgajEn34IrzDqrJRxw4ilSMXdgJ0JAcESEY9hSqTlP6Ou3w8HWOqTG4PZ/MEunOM+FyaPtd8g0JfzTb7iKgRCzHs3FF8ac0YPJwXBL4jGnzEHIhe2ctEEBObgT72CWPiE94vraYt4PUaItKofQ3DZvA16GQcpoi2vJEIBm/Q/tgDdRWqTHobodij0rwy+m770l7Eau92g7C+aw008u2s7MIDbGXBgOPUmF5HJTMqckCC+GYPk7TjuJEExAVakzYobyq0zXYkZKcnXs1G+/r8qVcWzsRUAg6Y2WlZ54jjng4XHBKlSja9bq3CPT+kB8/dbSQdQ6ogs8ADafRy8+WeDWZhUJrjJQ3xxepLtZOCPc/t3gwkTezsvQH76hr6zNYmagDQER5B2mwbJl+79Pot86oNtpUL5C/qhZmjf0JkhSKmuX1QwJPd4BaVzbsZoaPGopQqNOvio2tjXJSFtx1fffWEj3siabkEPzpngmLPvdYOClTG8fP9lzWT0vyAxIowlPkcGRioRXZKjIPPaayrv3APvshJORmUc9x1lFlgLSjwlTE7DCbDf024MnTz+aRkN0uBGcWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(1590799012)(186003)(6512007)(31696002)(36756003)(26005)(6916009)(86362001)(85182001)(41300700001)(5660300002)(91956017)(316002)(8936002)(76116006)(66476007)(71200400001)(478600001)(66446008)(8676002)(66946007)(64756008)(4326008)(38070700005)(6486002)(38100700002)(66556008)(83380400001)(122000001)(2616005)(82960400001)(6506007)(1580799009)(31686004)(2906002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmlUL1JnZzQ2c0lLanNhallISWJPWkpjSTVsZnNFWUVjbGcwOUVSQVlLdlAz?=
 =?utf-8?B?YlZIOEk5V2c5ZWtPQmZXbC83aGpMTlF2b1FhWVBvYmx4am1CTE0wNW5QSTVo?=
 =?utf-8?B?VzF6UE1ET2Q3RTZ6eVJ3K09kc1JlQ2l6dWZaTHFZbkZHM2UrZ0gyaW9yVVpj?=
 =?utf-8?B?ZjZLc2NnRDlQek5QcFhrVUFNWEpHdGxXa3pkUDFaRFJBZFpKSGZ0NE41N1Fs?=
 =?utf-8?B?VXhoREQxN0dJSlBJZEQzYllqUlo2THd3M3hwR3ZUeTJBT3lHYSsxZzRGeHVJ?=
 =?utf-8?B?UXBxcTJBektUU3Z4VWlLWDFPNkZOZ1l4U2FhU3NVVXNTOXhvL0lzckVMT25v?=
 =?utf-8?B?RHI5S3l1TC9TU2ROL2xjeS84YjFTRkpJT2pONi8rWC9wV3h0QS8vbG0vclJN?=
 =?utf-8?B?N3laWTRMVXNJdk42Zy9kM2NCYTN5bnZ0RloxcmdQdHI3dW52ODc0WDU4SmNj?=
 =?utf-8?B?UTUzdVNqa1Q0bko3Q0FhR1p5b1hZNmpxY0trWGs1VDNKNHp1UlVJeXNXNEFB?=
 =?utf-8?B?K0JubFRGNllMcURNN2g2MFgyZHNuc003cHpQTDhIaGxhdzl4Zkk0dlBxME12?=
 =?utf-8?B?VTlPNFA5Q01hYTl1eENDRDhVdWNoSkV0OElxK2ZiRk1wOEtCTUJrZXUxOGFN?=
 =?utf-8?B?QlpFb2xDZXd3VTNJZ1FVamxpNGhmMTNoeS9wREZHejY5NGJ1Yjkvb1ZESk9t?=
 =?utf-8?B?Sk9yWnhlYytySCs3eERDQTFpM2RJZStRK2pTeHZuVWVBRzh6NE1LVm9ZQ1dG?=
 =?utf-8?B?RjREZU5kQk5rMndUcFA3dlZJcFk2M3JOc2pReUNubzI5SVlLWHd3Zmtzc0Fk?=
 =?utf-8?B?czFCZ0V1YlRQbEFPU3FUZVZpaU5VZnJzNGtrTGREYnFnRXM2WXlWWXBjOUlG?=
 =?utf-8?B?enBZRTd2UVFQVXlzMm05Ri9ObERKQ01MRjAxcGpJYzl3bExQTS9HWU5mRkxT?=
 =?utf-8?B?RThualpnUnN1Z1pmN0tmTjVuZ04zeGY3czZDcEh3cFZpd09FdFZGeDQ1Ykha?=
 =?utf-8?B?N25PRzVrOG0rVXhwTjd6V2pzMSs5Y3I5Y3FYczFKOFFTa3hZUSswM0JXYkQ2?=
 =?utf-8?B?TUV3cm5rd1hMNkxoQnpKR1UwcWNZVVVNVXA5Y2RpRDk4Nzd3VDhORXJodXFk?=
 =?utf-8?B?eW5qZmE0RUZpbjBCSHkwTGg3akhMaWtaeGxLRGpkNHJZcUlCS2RFUXhPazhK?=
 =?utf-8?B?UmM1cGZVdDVIb043NHBSckd5SzVtc3MyWTVFai9tVVF0aGZXbHc3bFJPREZV?=
 =?utf-8?B?Z3A2RmdneU5nbnk4UEZZb2xURFMzS3UrZVkrNEN3SHhMZlEyakVPcDUwMDRR?=
 =?utf-8?B?d2t1cytWYkhUSXVIdTZQRlc0dGIvcmZSSTRxQXJzT1Y3Y2MxMEw5Wkg1VHFn?=
 =?utf-8?B?R0hMa291aXNTaVozTWQ2b1V1WnBSNmh5VFBYRUxLTS9Lc0xCdWFzQjJ0c3N4?=
 =?utf-8?B?UE9zNkI3QnROZGN2ZFlCYkNSOWJCMVBoZ1RQT1FOdDR6WThWUHkrZXBMQU9x?=
 =?utf-8?B?M1YvVVpRSWl4Z3d2N0pDa3hDUGtscWdpSkM3dDBCdFdjb2xWWjlLR2JoTTd0?=
 =?utf-8?B?S1RYQWF1RWpjb0pHcnYrZE9hK1dMb0lCSHZDMjFrM052alUrc1FUVE9XTDBT?=
 =?utf-8?B?SlVuNHpEMDYwK0JETFVDR0gwUDZ3Y0hId2hGUkVDMHVIRk4reUorMnA4YTYw?=
 =?utf-8?B?WXFyV3psS3NSWnpnM2JKbzl5cHlVYjdtR1NiZTFWMEZvYXg3cmlUV2lqRHNk?=
 =?utf-8?B?YTJidHYrcFozZ0JhZk1CZ3J3dDdLNWxtczZkNzA2dXJZVWR5R3B0OWVLMmJ5?=
 =?utf-8?B?UnU4RjhFWGp1U0FPRlNiMWVHYWdpNE0xcjNwQ2JlWllxWGV6aXc1TnRGcUdi?=
 =?utf-8?B?dXppQkhRWk1JWkxCUjJZOC93WlhsVXVpWmxyKy9qRmxXL2M2TlRJdjNJa2d4?=
 =?utf-8?B?cTI5bkdIcWx6eEg4N1A0dVVvdWl6UENSeFU1azdRYzZqbFVZUHp6eE0xdVFZ?=
 =?utf-8?B?UnFTVDFlMmtuSzQvaURzWmI4MUd0RXdDQ3BQTFYrVEgwUmhrTGVNWVlZaVpx?=
 =?utf-8?B?TjBmNWpMcGV5VktJSEJqSDMxSm5kT0trSUhHY2VMUW12SFVJVmkxMThSSU02?=
 =?utf-8?B?dVJpcllVK1ZCZUV0VkkwVVEzRFFBUnBmOHA5WDF6MlgxTEVwUVVLMjJ5blkx?=
 =?utf-8?B?aUE9PQ==?=
Content-ID: <1FA4349DFE14EE4EA44F4884C833D914@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8098c51-01d7-44ac-0452-08daab644951
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 08:40:44.0847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aMFBYm4YGR8ZJlScK+QoberooCgYJoPl01A1+QoHQ944A3RdFozJKfVQpK1ftgjH9GH1Loba/ZnA0NbGb5Sd9IbxX6UwII6K1DKkwL98pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9815
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/prctl10: Add basic test for
 PR_SET/GET_TSC
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


> Hello,
> 
> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   include/lapi/prctl.h                       |   7 ++
>>   runtest/syscalls                           |   1 +
>>   testcases/kernel/syscalls/prctl/.gitignore |   1 +
>>   testcases/kernel/syscalls/prctl/prctl10.c  | 108 +++++++++++++++++++++
>>   4 files changed, 117 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/prctl/prctl10.c
>>
>> diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
>> index fa5922231..8d3ef5c32 100644
>> --- a/include/lapi/prctl.h
>> +++ b/include/lapi/prctl.h
>> @@ -19,6 +19,13 @@
>>   # define PR_SET_SECCOMP  22
>>   #endif
>>   
>> +#ifndef PR_SET_TSC
>> +# define PR_GET_TSC 25
>> +# define PR_SET_TSC 26
>> +# define PR_TSC_ENABLE  1
>> +# define PR_TSC_SIGSEGV 2
>> +#endif
>> +
>>   #ifndef PR_SET_TIMERSLACK
>>   # define PR_SET_TIMERSLACK 29
>>   # define PR_GET_TIMERSLACK 30
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 61a7b7677..51de0a614 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1004,6 +1004,7 @@ prctl06 prctl06
>>   prctl07 prctl07
>>   prctl08 prctl08
>>   prctl09 prctl09
>> +prctl10 prctl10
>>   
>>   pread01 pread01
>>   pread01_64 pread01_64
>> diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
>> index 0f2c9b194..50ee4bf60 100644
>> --- a/testcases/kernel/syscalls/prctl/.gitignore
>> +++ b/testcases/kernel/syscalls/prctl/.gitignore
>> @@ -8,3 +8,4 @@
>>   /prctl07
>>   /prctl08
>>   /prctl09
>> +/prctl10
>> diff --git a/testcases/kernel/syscalls/prctl/prctl10.c b/testcases/kernel/syscalls/prctl/prctl10.c
>> new file mode 100644
>> index 000000000..01307ecd7
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/prctl/prctl10.c
>> @@ -0,0 +1,108 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Basic test to test behaviour of PR_GET_TSC and PR_SET_TSC.
>> + *
>> + * Set the state of the flag determining whether the timestamp counter can
>> + * be read by the process.
>> + *
>> + * - Pass PR_TSC_ENABLE to arg2 to allow it to be read.
>> + * - Pass PR_TSC_SIGSEGV to arg2 to generate a SIGSEGV when read.
>> + */
>> +
>> +#include <sys/prctl.h>
>> +#include <string.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include "tst_test.h"
>> +#include "lapi/prctl.h"
>> +
>> +#define TCASE_ENTRY(tsc_read_stat) { .name = #tsc_read_stat, .read_stat = tsc_read_stat}
>> +
>> +static const char * const tsc_read_stat_names[] = {
>> +	[0] = "[not set]",
>> +	[PR_TSC_ENABLE] = "PR_TSC_ENABLE",
>> +	[PR_TSC_SIGSEGV] = "PR_TSC_SIGSEGV",
>> +};
>> +
>> +static struct tcase {
>> +	char *name;
>> +	int read_stat;
>> +} tcases[] = {
>> +	TCASE_ENTRY(PR_TSC_ENABLE),
>> +	TCASE_ENTRY(PR_TSC_SIGSEGV)
>> +};
>> +
>> +static uint64_t rdtsc(void)
>> +{
>> +	uint32_t lo, hi;
>> +	/* We cannot use "=A", since this would use %rax on x86_64 */
>> +	__asm__ __volatile__ ("rdtsc" : "=a" (lo), "=d" (hi));
>> +	return (uint64_t)hi << 32 | lo;
>> +}
>> +
>> +
>> +static int expected_status(int status, int exp_status)
>> +{
>> +	if (!exp_status && WIFEXITED(status))
>> +		return 0;
>> +
>> +	if (exp_status && WIFSIGNALED(status) && WTERMSIG(status) == exp_status)
>> +		return 0;
>> +
>> +	return 1;
>> +}
>> +
>> +static void verify_prctl(unsigned int n)
>> +{
>> +	struct tcase *tc = &tcases[n];
>> +	unsigned long long time1, time2;
>> +	int tsc_val = 0, pid, status;
>> +
>> +	pid = SAFE_FORK();
>> +	if (!pid) {
>> +		TST_EXP_PASS_SILENT(prctl(PR_SET_TSC, tc->read_stat));
>> +		TST_EXP_PASS_SILENT(prctl(PR_GET_TSC, &tsc_val));
>> +		if (tsc_val == tc->read_stat)
>> +			tst_res(TPASS, "current state is %s(%d)",
>> +					tc->name, tc->read_stat);
>> +		else
>> +			tst_res(TFAIL, "current state is %s(%d), expect %s(%d)",
>> +					tsc_read_stat_names[tsc_val],
>> +					tsc_val, tc->name, tc->read_stat);
>> +
>> +		time1 = rdtsc();
>> +		time2 = rdtsc();
>> +		if (time2 > time1)
>> +			tst_res(TPASS, "rdtsc works correctly, %lld ->%lld",
>> +				time1, time2);
>> +		else
>> +			tst_res(TFAIL, "rdtsc works incorrectly, %lld ->%lld",
>> +				time1, time2);
>> +		exit(0);
>> +	}
>> +	SAFE_WAITPID(pid, &status, 0);
>> +
>> +	if (expected_status(status, tc->read_stat == PR_TSC_SIGSEGV ? SIGSEGV : 0))
>> +		tst_res(TFAIL, "Test %s failed", tc->name);
>> +	else
>> +		tst_res(TPASS, "Test %s succeeded", tc->name);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.needs_root = 1,
> 
> Why did you add this?

Oh, yes, I should drop this.

So, should I send a v3 or you or other maintainers merge it by deleting it?

Best Regards
Yang Xu
> 
> It doesn't require root, but it could be denied with seccomp or an
> LSM. In some cases having root won't help (e.g. in a container). If
> you want to handle scenarios like these, then it would be better to
> check the return status of prctl.
> 
>> +	.forks_child = 1,
>> +	.test = verify_prctl,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.supported_archs = (const char *const []) {
>> +		"x86",
>> +		"x86_64",
>> +		NULL
>> +	},
>> +};
> 
> Otherwise LGTM.
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
