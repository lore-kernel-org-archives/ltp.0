Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AEEC4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 10:01:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 586BF3CBDC3
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 11:01:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B3133CBD7D
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 11:01:03 +0100 (CET)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 89EAB600803
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 11:00:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1670925658; x=1702461658;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eG/MkZazsXBRkKboX+Q9Bhcx6JMAgYQ6nIHusnDkCYg=;
 b=g2BaIGGHUmeIb95rH2xzBLWzUofmWxIuoOs9x8CgpODPqQmc3SBrqXo5
 1Lz47SxGCYrF1lMOi4eFqkDmPiGHKlVrJHGXApbjSHgOlM2mCd6Atb8UD
 q2wgK11wkH+zaYnxiQjMmHrb7veVNEFEzb5c7xbXRNIOz/cplt+Pimhku
 ZFX/3qO3d80G866Ox0dSYoKWmISbylShNdJVVL6ABbMIyyA+uWup9Rfgw
 vJ+EucH8+D328VEwJbhGqrOkkW0WWzSx30ir+2PtFPo6e1ur/05K9Vnds
 sriAfmRJYWPMVIMWDYMY4mQdq01CcAvExBpjWQn6HChVylB2QBJAJoyi/ Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="72525348"
X-IronPort-AV: E=Sophos;i="5.96,241,1665414000"; d="scan'208";a="72525348"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2022 19:00:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhSilchLMFuC/PPPnIUb4DM/jWY3WLdZMzlRA/8QWKnaHimQyk4lVxBiPYkXIljNUF2s3ScpbSEroW2KvmPz9RgggKj2umXS8TyIOHfd8D3WtdEs2tmIKBlutkrQMBb+bx4DJZeWQPTFbFEOtMQKDpWMYucLJr+51vofXdDo7IfLS5rcoL5KiK1lfYm4Bj1FOzYNHedy9f9IGWEH/tULxxMN3cVkt0hZ8xAl4VEpnQgOSn/EJ6MpII0y6wdtQrcUc/SEn60Btya6r7NmOuweeAsJ2NG5sqsd1RqCtl3X6DU9+7kGm9OQasVHY5Zy/83+CAZrb5/FV0bBzCfPIaPhLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eG/MkZazsXBRkKboX+Q9Bhcx6JMAgYQ6nIHusnDkCYg=;
 b=k7IUVWLBt/ElchEy0XZuvok0SOwPtvWdbHK0fJOR4kqebyGjPAG4XXJ1V7TGpSQ416b4APFghmgxb4L6MvSxoLFF+Zwo4vg1CbTtmw229hFPE1+cwZJMr6xlUFhaZeddH4k/qXyRiDCttNuCosaESqNzdmF9LHhL75ErEUANzMu/emWiQkOLGKBd8CSXaH1jIMds6DnTNOZWg15HdWvU4Q++6ATmBuNR5GwIpbE+xUzppszREGaP1G1HsHiDx5cWHLKLHRubYmidAm+/xKImYINlvCql4WyJqn6MbY7oelq/Dho6m2Ozi+lGtOjUTP7Zq56enSTQxR5jZfoyREIT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYYPR01MB8095.jpnprd01.prod.outlook.com (2603:1096:400:110::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 10:00:48 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 10:00:48 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, Richard Palethorpe <rpalethorpe@suse.com>
Thread-Topic: [LTP] [PATCH v2] getcpu01: Reinstate node_id test
Thread-Index: AQHZDteKqgoe4R3vjEqwgsGV/TtP665rk68AgAATRoA=
Date: Tue, 13 Dec 2022 10:00:48 +0000
Message-ID: <e0488665-e68e-455d-6ee6-8709b5f57599@fujitsu.com>
References: <20221213094427.32743-1-rpalethorpe@suse.com>
 <Y5hLfAN7NCvsKmNk@pevik>
In-Reply-To: <Y5hLfAN7NCvsKmNk@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYYPR01MB8095:EE_
x-ms-office365-filtering-correlation-id: c56b5acc-ff65-4c09-1ae4-08dadcf0e8cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nQRTedpjkMgLdwVlLfLLq6kWZFS6ApLi0IdOVKM+uaG/wkpETa+m1wzUGf5LinvkT7TgtO7juealaj4aFV0aqm+4tqsl0ar5lPkd9yR0thP037Mv84pT5EqZhYvKyyO7HGaDIYa0n1Kj35lHKvw05iQMP4Elqi12mkGzMjUhWD+kssdXNUjM1zpmV+L82ABdcQZD6+XHgiIe3AQoB7CnDPTxdpCKBsVscmEViX5nLyMjCEthTKsCqN8EjoNZmR/0+cbLlhKXks956dwY87m5QU+hgDkcIAmXTjOY8Q1u/oKfu3VUIJMWoj8c+IgPbljhGMOvlO00MIwYoOra/u4zoJNHNuMyrgqX8R/PeSf84fA95GchtW3C/nlsi/5McxAg9kHnU8OnF74ArxrlYPEveir/4A6nlf50X2owyzYE6jmqbxZVnWpM+AcLNex47LHHS42j2duZnHyJho/KPoAR3uOxxMcIiYcQy8ldLq71h/bTa9v09JIK9zNltAWvMEAA3xEBNOMI230jkpgurB8P+CipQDcj5x71dGqcJTjpLhD/LJ3PxkJGqhC8FzOELgVY+73t7PCQyhrcYx8Jg7/e96/fEft0x8TUJsjTgS+B1YwKoaGIXdrF51V7nuimiNgscfek4MpHgA2stAv1fMxvbCApZWsQUetc2rWWafxnOe7XW7wjXaCJysD29RoXXSYJz7Bl9vUBhsWoI0UFBuZYIe8vt9LpSuHWyQKl8fMptoylKaAJnc+kf6B+7bh98ZUM7kHbL6TgsFoyXHzTpHSB3avFZ7W5u/9+bYuKL6wAxw/QTNztlc+k7mvnkt7Quw3r
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(1590799012)(82960400001)(86362001)(31696002)(83380400001)(110136005)(6506007)(6486002)(6512007)(186003)(26005)(478600001)(41300700001)(71200400001)(8936002)(5660300002)(91956017)(2906002)(2616005)(66446008)(64756008)(38100700002)(38070700005)(8676002)(66946007)(122000001)(66476007)(31686004)(4326008)(76116006)(66556008)(316002)(36756003)(85182001)(1580799009)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG1WKytlS3FnK0kwU1B0djFoV04wMThZb1ZSVXQxWkRsT0VsbHEwQ0pvenc0?=
 =?utf-8?B?ZWNNT1JUMzhHZWU5STVJOXdDZVQ3aGg4dXFYWC9oM1UxVENNN0JWYTlTdnJC?=
 =?utf-8?B?MmZVZkhJRVZpTjJnU0NoU3B2SFRENkNCdmE1TjJUTk44blpQYlRiNnZFeVFL?=
 =?utf-8?B?Um9VUXN3aE9PUUxLTE8yMkFqNy91MFRTN1NpMkRHZkdDY3lIcDZ1WlpIWDN0?=
 =?utf-8?B?cSswYzF6MHJMWVhWcVFhYndOVlZlUm13R2dUazBZMUdCc0lXK3d5NmY1cXFP?=
 =?utf-8?B?c0U0c0RJanRjUTk3Tk1HVTNONUt3Y01OdXV6M2x0RDE5SW9qZVdyVkFoNVpK?=
 =?utf-8?B?c0RzUU9BTEROTXh1VFFDV20vbG5PVklKSlQzUmU3L0lwTEI2Z2s2Q1BydkdD?=
 =?utf-8?B?NS84WFloV0pYSkhjKzBCb0o3N1UrcFlCbTRZVVkvbUtiTEdmb3lPRWlXTmVL?=
 =?utf-8?B?UXpoU0MvaXF2d3hGQStSdkFqNGtjcStWazVDV1F4L3Awek1kNlVWelgvS1pt?=
 =?utf-8?B?TlpxSXo1K3VVbWFlNW5ub201Q0dMTnNmNE9JQ3J2Y0gwQlhSeHkwRmxqMFZs?=
 =?utf-8?B?ekVXZUppUktwYU9pbThBcjgzNmhGc0txdVNYd1dGZVExZ0VpRmc5c05EYXpC?=
 =?utf-8?B?VlFRQnM0cjloZjV4ZVpGdmd5V01HdlRuR0MzN2ttdnhteHkxRzFKNUVFZE9o?=
 =?utf-8?B?T1pyTk9JcU9HVGZZNTYydGtBdzl2b0tVNnZ6dXJYN052dmhjY1lnZUlKdk9j?=
 =?utf-8?B?OXNJMSthYXFqbFBCdXcwdmw3aFE5eHBGTU1GT0NGMkh3TEpJOElTclBYbjZX?=
 =?utf-8?B?a05ObmJrZTJIYlUrSjlaZFZDSlZGRUhVRks4ZVZSWm9JQ1diN3k2RnJYbmk5?=
 =?utf-8?B?YVpNbUhqSXMrOEcwYVB0MGhWemNFM0tGakZOZk94c1padEdyQitUYnMrcElx?=
 =?utf-8?B?VjB0Qm1WQ3lvOUJNYnVZd0RDcy9pbHFPSTVtR2x0SHh3by93RXUrcUhyZzFl?=
 =?utf-8?B?Y3QyQlZvSWlFeU9XSG1MejdZekp2QU5KdkROenF3YkZOYXJhcUNGYlh3aE1h?=
 =?utf-8?B?YUJGWmx4SFZzb3VISVplZkk2ZXpWYnBPT1ZzcVB2UkxvNkszUUh3cCtWT1kz?=
 =?utf-8?B?TjdmdmpqWGlaSFZtMkp5Tm9mL21MQU9CMGdZQ0tMaDZOM25DaG9qd3N6czJW?=
 =?utf-8?B?VVFxQ1V3THZOWnppSWtHdlgxek1WYzdUOUdmS2JUNi82bDNnUXVURmtrbEw2?=
 =?utf-8?B?RkFjNFZ5NlJLbDFYSFJ6ZmpBRHVNcTFFVmx4d1FQSnlRYi9IZ3ltc2lna0hM?=
 =?utf-8?B?cjV6M1k2RUVqZGNrVkJUVE94YnJMdXlvQlpNK0pJd0dxcEtuMGJvdlhNM2hs?=
 =?utf-8?B?MExJYmRFVEQ2VExxQUtjcDQzaldrVVdVVTVtNzc0aytXT2JnNnRNeXJ6SElX?=
 =?utf-8?B?T3dvdExlYXVmVEd6aDVXQlZpYXRleGtpTGxNak1VbVlES3RRQ1FlblhQcFZi?=
 =?utf-8?B?L3dVTnQzME9Rbk1QbnhLVHVieDFuZGcvTkNxemtuY0xXZmQ5QnpERFNqYkNx?=
 =?utf-8?B?dG9jWXpGVHl1aVRQNUVZaVBQbzROSS9HWFpaZXRnQW1yQzBjbVJQcHJnTTN1?=
 =?utf-8?B?cklNeC9WUTg5NWdMQkpvZGFaY0xreUNqWG92MU1zQjZBdTYra3B1MkR0SGlM?=
 =?utf-8?B?US8rcSs2S3hYN2R6VmpjMnBUU1Q2eUZDWEtpTi9LNGEzalU0TWd3RWoxWmQr?=
 =?utf-8?B?V05oOFhNSCtpZThmR29jUGRFSFNWNzczOG9hWjlLbDNZZkI4MGdSRThTak9Q?=
 =?utf-8?B?dmVSSjdPUnZ6L2lBZXFsc0xRaWdxSVNRTmRHUXhHYlFoK1U0REJLTjdyT0Nx?=
 =?utf-8?B?T2lRV1FiZzNSL1hYcHZmZ1oxZFdjeTZ2YjQvcXhnMFJSL0MwN0NQaEUxbnN5?=
 =?utf-8?B?emRoYkNxMmhYTEp4Y25IRDdzU1FTRzFNZDJjWGt4cFZkYXI2aWNjSGpmaUZq?=
 =?utf-8?B?SEx4dTBNeHhYdFJUdWdMMnhzak1uRW1GV1pFd0ppbkxlQUI0QVVCemJhczhB?=
 =?utf-8?B?SjZnUzAwcGFXd1FHVlBjZ2pFRDI4eGY2K0dGTW52RzRaNDZGNGNnd28zY3hp?=
 =?utf-8?B?dGNLNzNBYzZUK2Y5ZXZBZlJkV0QrOFQ3d3FhYUZWb1hYdVM1MGdGSmVEa3Bi?=
 =?utf-8?B?a2c9PQ==?=
Content-ID: <FD2AB123F12CD445A59A2E118E931C4B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56b5acc-ff65-4c09-1ae4-08dadcf0e8cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 10:00:48.1986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1mFx2VQZJ1Wq/bCKtfDzivp1ojYZ1CXUhnh1bR/7dymndrFbvvD6mSgqqFt0iHxuB0K/tvx2XZH8ZPyZoF3qYrFFJ0M5Zo8bLFGtr5AvZ3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8095
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcpu01: Reinstate node_id test
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

Hi Petr

> Hi Xu,
> 
>> Presently the node_id is only checked on i386 and it is broken. The
>> sched_getcpu call was substituted for getcpu when
>> available. sched_getcpu does not have the node_id parameter, it's not
>> the same thing as getcpu.
> 
>> Also we can check the node_id on any platform which has NUMA. Which
>> includes more than just x86.
> 
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> Cc: Cyril Hrubis <chrubis@suse.cz>
>> ---
> 
>> V2:
>> * Removed all the ifdefs
>> * Use libc getcpu when available
>> * Remove kernel version check
> 
>>   configure.ac                                |  1 +
>>   include/lapi/sched.h                        |  7 +++++
>>   testcases/kernel/syscalls/getcpu/getcpu01.c | 35 ++-------------------
>>   3 files changed, 11 insertions(+), 32 deletions(-)
> 
>> diff --git a/configure.ac b/configure.ac
>> index e9b15c7f7..1ab7cc60d 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -101,6 +101,7 @@ AC_CHECK_FUNCS_ONCE([ \
>>       fstatat \
>>       getauxval \
>>       getcontext \
>> +    getcpu \
>>       getdents \
>>       getdents64 \
>>       io_pgetevents \
>> diff --git a/include/lapi/sched.h b/include/lapi/sched.h
>> index 1d22a9d7e..1065665d1 100644
>> --- a/include/lapi/sched.h
>> +++ b/include/lapi/sched.h
>> @@ -70,6 +70,13 @@ static inline void clone3_supported_by_kernel(void)
>>   	}
>>   }
> 
>> +#ifndef HAVE_GETCPU
>> +static inline int getcpu(unsigned *cpu, unsigned *node)
>> +{
>> +	return tst_syscall(__NR_getcpu, cpu, node, NULL);
>> +}
>> +#endif
>> +
>>   #ifndef SCHED_DEADLINE
>>   # define SCHED_DEADLINE	6
>>   #endif
>> diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
>> index fcc273e29..f6fcc4fc1 100644
>> --- a/testcases/kernel/syscalls/getcpu/getcpu01.c
>> +++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
>> @@ -11,26 +11,12 @@
>>   #define _GNU_SOURCE
>>   #include <dirent.h>
>>   #include <errno.h>
>> -#include <sched.h>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <sys/types.h>
>> -#include "lapi/syscalls.h"
>> -#include "lapi/cpuset.h"
>>   #include "tst_test.h"
>> -#include "config.h"
>> -
>> -static inline int get_cpu(unsigned *cpu_id,
>> -			  unsigned *node_id LTP_ATTRIBUTE_UNUSED,
>> -			  void *cache_struct LTP_ATTRIBUTE_UNUSED)
>> -{
>> -#ifndef HAVE_SCHED_GETCPU
>> -	return tst_syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
>> -#else
>> -	*cpu_id = sched_getcpu();
>> -#endif
>> -	return 0;
>> -}
>> +#include "lapi/cpuset.h"
>> +#include "lapi/sched.h"
> 
>>   static unsigned int max_cpuid(size_t size, cpu_set_t * set)
>>   {
>> @@ -78,7 +64,6 @@ realloc:
>>   	return cpu_max;
>>   }
> 
>> -#ifdef __i386__
>>   static unsigned int get_nodeid(unsigned int cpu_id)
>>   {
>>   	DIR *directory_parent, *directory_node;
>> @@ -119,33 +104,26 @@ static unsigned int get_nodeid(unsigned int cpu_id)
>>   	}
>>   	return node_id;
>>   }
>> -#endif
> 
>>   static void run(void)
>>   {
>>   	unsigned int cpu_id, node_id = 0;
>>   	unsigned int cpu_set;
>> -#ifdef __i386__
>>   	unsigned int node_set;
>> -#endif
> 
>>   	cpu_set = set_cpu_affinity();
>> -#ifdef __i386__
>>   	node_set = get_nodeid(cpu_set);
>> -#endif
> 
>> -	TEST(get_cpu(&cpu_id, &node_id, NULL));
>> +	TEST(getcpu(&cpu_id, &node_id));
>>   	if (TST_RET == 0) {
>>   		if (cpu_id != cpu_set)
>>   			tst_res(TFAIL, "getcpu() returned wrong value"
>>   				" expected cpuid:%d, returned value cpuid: %d",
>>   				cpu_set, cpu_id);
>> -#ifdef __i386__
>>   		else if (node_id != node_set)
>>   			tst_res(TFAIL, "getcpu() returned wrong value"
>>   				" expected  node id:%d returned  node id:%d",
>>   				node_set, node_id);
>> -#endif
>>   		else
>>   			tst_res(TPASS, "getcpu() returned proper"
>>   				" cpuid:%d, node id:%d", cpu_id,
>> @@ -156,13 +134,6 @@ static void run(void)
>>   	}
>>   }
> 
> FYI Richie is touching the same code, one of you will need to rebase.
> IMHO it's better to remove this in dedicated patchset (i.e. in Xu).

Even I will limit the kernel version check to 3.0 in my patchset because 
we don't reach the same target to 3.10, so let me rebase.

ps: If we reach the same target to 3.10, then we can remove remain old 
version check in the future.

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
>> -static void setup(void)
>> -{
>> -	if (tst_kvercmp(2, 6, 20) < 0)
>> -		tst_brk(TCONF, "kernel >= 2.6.20 required");
>> -}
>> -
>>   static struct tst_test test = {
>>   	.test_all = run,
>> -	.setup = setup,
>>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
