Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3218C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 02:06:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1235D3CBCDC
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 03:06:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36D9B3CBC7E
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 03:06:15 +0100 (CET)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 85BC1648425
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 03:06:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1671156375; x=1702692375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gqwG50DZEfp0YXrUrLZ4CcBXbkPeo56at49XC734LvA=;
 b=sf6zkc+XU4iJWJvxceMTbRPVDWs9e3x6jlzKTs+IbhdUgPrDO+c1Pgia
 +c8AxZsPGXoU94LjXHfkoXMAJmPM//m7eAWbY3pVKMU/P2maUPRaruqXf
 tSCg66kcegpeaNz9iqFFw/clvwXp51mZtzdVCNniFzYaG/QD8f36vtrT3
 O862oxoU+zjOzMi9O2rYHNTb4GSM3QfYC8woCLXpxfBrpFHdDXRrZuztR
 NemDN8bgN5yyqive04PCxT2HsHGs5sCaK5qS1sMiw3kfUxz36LbWsXQpY
 3Bq9yNEXfjepZtf94mSWILV0A+MXlToHkwSal56RnwspNjT4NWNijC0VS A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="72670583"
X-IronPort-AV: E=Sophos;i="5.96,248,1665414000"; d="scan'208";a="72670583"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2022 11:06:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoIZSS41LRj95JhjtaESL3P9K1ET42S7XT8ubdL/E0uEeoFZLK7it8lb4rx4hR90Amj22rVrhmGDGUz4EtFJckQKQo1+WPktO1zB/ek1EkK8fk4w6/dykTERk0IhH9WVYrnOtX5yv62DUrzfjXfMgpkaQzRajLQLJvbmqvf5GszNpXsD01uo3B1hlyXjPb8kFDxtHcLqDiHcVE2bbtYZ6ZtKqN2iLOBuzrDoTSK8tU8FTYYxaFbIlDh3EqbSYv9A2uKpSHQ4tIpypJBxy6xtn1xfAxTQFVZ3GtuxD2ih8J6RAjz8KJrgCVD5rM6WMXntZ4xdHSQJwt7q39Yr7eZJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqwG50DZEfp0YXrUrLZ4CcBXbkPeo56at49XC734LvA=;
 b=W84ZsOPbY7JiHAzXOGRJalOhT92qQ5hInvu3eK83WL17zirfLoa0GZZ+EjET5f69Z82y9Mwzh2z2+hcBnZdcno2Pd3gZYGNqtz85FvH/bXsazJPgQ1TfgdHQ0jqQEbPSyEXm0mkb/HWOZgRsqdYpjUCS65XD7TtOx6A4DFlTaLxMpGn4I5toLzGElftLOrYTsZPPkU8Q9TQQoNwA62ePDZsLhpCS7DDK1prkP0Pq/pVnefUmcuNUwewDsbRU0RPzmW4R/50uiEJTRVaqX8O+GNQGXqgag3i1tgSnIUNaWu13o/zefzxBpFqwvr4oYP6T1KGb0eKCtZwDjF9WKDM80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OS3PR01MB10010.jpnprd01.prod.outlook.com (2603:1096:604:1e7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 02:06:09 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%6]) with mapi id 15.20.5924.015; Fri, 16 Dec 2022
 02:06:09 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH] syscalls/setresuid04: Use SETRESUID instead of
 SAFE_SETRESUID to check 16bit syscall
Thread-Index: AQHZEDfYj2jEZWLTmE2v5nDJdcoLLq5uyp6AgAEMAoA=
Date: Fri, 16 Dec 2022 02:06:09 +0000
Message-ID: <4325e743-b779-3489-69cd-cfdedcef71ba@fujitsu.com>
References: <1671079666-15971-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87len8q5yn.fsf@suse.de>
In-Reply-To: <87len8q5yn.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OS3PR01MB10010:EE_
x-ms-office365-filtering-correlation-id: ac648047-c2a6-411c-db7a-08dadf0a1991
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fxqXpTnuescm99VM47SlCL/MjWRRnhPOxAueNrlm047oJSY0aIZm/dSg9Kx5678NiJizlarO63qbznseBDz61oDBdbab3hbyu6Z1957LwFNL0yrH/F58D2bj2/O2B1+nrKk33Qc1n8gh2YNLrcEHAbdkT9HhiH6niY8IA4C0VNlUK7uh7H73Z5jn1nCeYcA6Ehjc2wFMzvf/Oh8cnOqOl6u1Oe6rzCeDTrmYltYXhiQTDEI4Konq11hRhsDznzxBrNKlc+EX9jj4CjddD9Aoidb2RDVQHqQ43xlQIuA4slDL5UJ2m5KR4R2xym7E0X0nnEvN2fPXmdRnXIjm7xcE9JB2ty5nQdmYLguQTZtL2zT3D6IM+zuvkkhSxZ3mp2ac4GGmYwz6gbHgA+sMvgbo2/QxQDUe8hvry/aZ6l1bYtK/rYAbN88yhmRWVMt7mwXzkHP6eAwttM/CIeRFiF81WOSMc8EqBlyNgF6Ws8A6AMrxGHgvqDCQJO6LkuqB6AtwjdQ1JMJ1/hRP+0LD4/E/hPzqL9H5LsqwmPwiy8B0jcM2Z9E3EmJ0qJpnnv3vrJbVCd55n5aGMU2/h8FOVUhz6MjHi0DPKLY0uCjqxsw8M4zwauYBgDoGCna02zeg59Du5kVBT95WQwYmyfuQXIbFzbBo3GL90cP9E20MccSPfR0+FHwk5ZYV+iOkxGz1/Uq2pLsfzqqkXHTQyYMvaFOXE6uM/U4e3MzVjDywa95uRq2KaZKpwY8awecSzcMy+vF4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(1590799012)(451199015)(86362001)(71200400001)(66556008)(66946007)(31696002)(26005)(76116006)(66476007)(6512007)(186003)(8676002)(91956017)(41300700001)(6486002)(4326008)(2616005)(478600001)(6916009)(6506007)(316002)(122000001)(38100700002)(38070700005)(82960400001)(8936002)(83380400001)(5660300002)(1580799009)(66446008)(2906002)(64756008)(31686004)(85182001)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0p1WTMrZ2dHbm8rbXNLeG01ZmxQSW5zSkNqZUZ4QnVoN2lNUVY5aDJLZmY3?=
 =?utf-8?B?VXUrUkpVWXlOSXBGbjVUTWdpU1h5ZVBKRzZKcTROUjZrRUNCV1NodkR3a3U3?=
 =?utf-8?B?S0gxT3BDdG1wUldnUkowM1VCUUZTNkY4bWtRVWtXamJCWjdXK0pJL2pNaHRk?=
 =?utf-8?B?UmdlNkNIZm1teGRaR1MxMTFOM0RaNCtNOGZvSEJxNm5qMzd3MWx4YTBLSXhy?=
 =?utf-8?B?Tmxka3Y0Yno4U2FYS1VHUmVENnpadk80VmFiY0xCa0hFM3Y3WjJad2Y4eG5K?=
 =?utf-8?B?bVYyRFJMODZrMGprZyt4YlhhbXFXSlJldVpmd1dEZU9mMU52cWFPUlEyNlJ3?=
 =?utf-8?B?ODNJNjFGc21VVjk3K0o0TTBOZWtVYlB0U2hHTFR6b1YzdjBnKy9OOTlFdVlR?=
 =?utf-8?B?Mm02M2Q4bHNwWU13aStUU1JCbW9tNHowdldoRHRuYjBiempnM1NwaGhOVXdz?=
 =?utf-8?B?NFUzWkNqcWFwd1cxVm5KS2FRT1kvT1FoWXlnQUVlRVpLdzNrQVAvZkoyWTdR?=
 =?utf-8?B?ZDZSZGdZa3JmckdVNmVpQy9DcG84WUowek1QUWUvMm4xT3RZN2oyT2FYZ1dE?=
 =?utf-8?B?Njk1eEZDbDM0T0hpblU2RlYyL0JPMlpLdjlQVzFQc1ljQ2NGS3paZEJvV2dJ?=
 =?utf-8?B?VkZxV1pjMmtlY20zTDVHYWI1dUI4ckJpbWJrNUZIV1BNMldiRTR0cG4ySFRp?=
 =?utf-8?B?VTVFdnFoQ2xQUXVLM3NQL0RHTGo4Uzh4dDI5NHU3a1hFbk0zc3pzaU1sb2JQ?=
 =?utf-8?B?QmNkRmwxdkJrTnpjTG5tY3ZjdU1tWlliS1RnYXViZVNwbDZiWnM0QkZ0QXNE?=
 =?utf-8?B?dXdJZXBJMVhSb1JROHJXa1ozOGN5YWxOQ3FWSEtRSHU5ZUhMMEp6VSs4dGF3?=
 =?utf-8?B?dHFqMkpWZmgwbk12a2JNZmhDcGkxLzg5ZG8ya0Jxa2gzU0hDWVBvTjdFWXQy?=
 =?utf-8?B?UEdFUTdVWVBJK1dra0lQRTVlTGlEc0lka04vLzdHTkYyY0Rld2VoT2prWjY0?=
 =?utf-8?B?WktaUC9IRjJ1R2ZqS2ZvZEUrWVNhaVkxc0hXczdIRGVhZHFVb1d0UUl1RXln?=
 =?utf-8?B?NjNYWlFaQ09TUlJkYmFVaDFQQXUyay94QXl4NlYyOEFrS0VubUI0eGhXc2FS?=
 =?utf-8?B?MXdLV01zWkpybXJNWkRPYnhwY3RpN2lYNUtJOFA5d01VSkdHRGx0U0tnV3k2?=
 =?utf-8?B?M1pQVkRFeWdSc2N3TTZpOHZoMktsYmsxMzY3SkJJMHFKZWxER0FtYm52bTl5?=
 =?utf-8?B?MTdsWU1BNlB4ZmRNNUF6dHRuNjdqMm9pWi9BWTJvSitxUFFmcDdGdjY3UEhZ?=
 =?utf-8?B?UUtXemplbjBuVXUza3BtU3NGSW1ZR0JOblM4U0VYWWRNTnRyL2tZTXY5VS9o?=
 =?utf-8?B?ZWs2MThURm43OXpFZXdLMlduUkRLSzdmZy9vejdYSTgzMFllMGJYNDU2eVhF?=
 =?utf-8?B?bkdKQUhvNlZVeUxVWk1LSy9IdWk0UVhCUjYzRmF1L2NTTmI3NzJYWjRrVW5n?=
 =?utf-8?B?MUlVQmg0MkRjaW9pMWVVQkk0eWZ5N1dhcmNWRnladmpJUWpyUnZKUzBmTUEw?=
 =?utf-8?B?Z3orcWFGdWxpYVYxd1B0S2ZSSUZPSWovNkI2V0p2SXZKV2xBbHpqVjFmb1g3?=
 =?utf-8?B?TnpjOUpiWWFqNXF4TWZoclZNeERtVms1RWlPQzFDNU1Xbm1JQlBFa0V1QVFD?=
 =?utf-8?B?T0ZNNXRnZmV4MXdnYWRSam1ad0d1azBIbmozSHVkaHZPVm5qYU9QSzVpekVh?=
 =?utf-8?B?UzNiL3djYUhWaTJNZnZOS201cEJPeG1mdVlZV0FzcFRvYXZEWGxDT2E4clIy?=
 =?utf-8?B?dnlNc3FyNWEvNExEb0xXTVlDc1VIVDl2OVBaSnBvYmV6MzE1cWNzMEpLM25q?=
 =?utf-8?B?VXhLTjUrNHp6UENKd1BpdVFhUGswdXoyOHZuS0R3NHBIaHFhb2JxcU5kODJR?=
 =?utf-8?B?Z1d2L3g5b09ybUJvQlczUTBIckJud0NnN0UzMjBGYW0wQmIreUI4bUFHZ253?=
 =?utf-8?B?TkFjZldWN0JSbCtsQUdQR2VRaGpESDJpOUR6UnMza0Evc1pzOW9tOEpVK0Vv?=
 =?utf-8?B?V3dYclJ5WHdaMXpYUGZQSFhkZVp6NXkwQWJRRGRJQThTd1BOK1VTVFlHbFNF?=
 =?utf-8?B?MVJmbDEyZ0ZsUFZNQzdzbDlmYkRlNmFRVDhPZ3RZNStjNm5qV0c3OVVucW81?=
 =?utf-8?B?Nmc9PQ==?=
Content-ID: <F3CAEC9939AEFC4696158BE11CD58071@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac648047-c2a6-411c-db7a-08dadf0a1991
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 02:06:09.7377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWZzDhJKvfc2nhouRtWDdIWHyhHenkeH3GWeKGdjvtw2ARx4amS6RlHxvKstetvYpjefZ5EtQDwSKiO/AHe33UXMJDkiWemYZCHzzx9Bc5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10010
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setresuid04: Use SETRESUID instead of
 SAFE_SETRESUID to check 16bit syscall
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
> 
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Thanks, merged.

Best Regards
Yang Xu
> 
>> ---
>>   testcases/kernel/syscalls/setresuid/setresuid04.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/setresuid/setresuid04.c b/testcases/kernel/syscalls/setresuid/setresuid04.c
>> index 833aee91d..57b290f37 100644
>> --- a/testcases/kernel/syscalls/setresuid/setresuid04.c
>> +++ b/testcases/kernel/syscalls/setresuid/setresuid04.c
>> @@ -40,7 +40,7 @@ static void run(void)
>>   	pid_t pid;
>>   	int status;
>>   
>> -	SAFE_SETRESUID(-1, ltpuser->pw_uid, -1);
>> +	TST_EXP_PASS_SILENT(SETRESUID(-1, ltpuser->pw_uid, -1));
>>   	TST_EXP_FAIL2(open(TEMP_FILE, O_RDWR), EACCES);
>>   
>>   	pid = SAFE_FORK();
>> @@ -52,7 +52,7 @@ static void run(void)
>>   	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
>>   		tst_res(TFAIL, "child process exited with status: %d", status);
>>   
>> -	SAFE_SETRESUID(-1, 0, -1);
>> +	TST_EXP_PASS_SILENT(SETRESUID(-1, 0, -1));
>>   	TST_EXP_FD(open(TEMP_FILE, O_RDWR));
>>   	SAFE_CLOSE(TST_RET);
>>   }
>> -- 
>> 2.27.0
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
