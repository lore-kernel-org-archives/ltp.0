Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BD5ECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 00:38:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EB893CAC05
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 02:38:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FBE03C95EE
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 02:37:49 +0200 (CEST)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 81DB91A01462
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 02:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1663202268; x=1694738268;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8Vo3QYCw0EGBhovy6gK7Z+xI+jnFb7mB09MloI2KqJE=;
 b=FKt20HmVfnxsK6wTHCyvUQd4u91yvFcap5xxHARPXtNeR8b5nFjOShsQ
 YS6zC+Kv4cDfYZOrW8OOZMetjiNKaoezXUpaIzt+HEztpc6if0DxUUGiS
 0ao6ruLFTFyA1n8PaqJ0rD3kTN5G/OKakzbrrjLNwcCfeKwMh9bE/Wjap
 NDCPtiy7BbYa216xonpvtLuNbifkpmZlIlE7EzznUIueh9tvIgb6zHKFC
 otjm8PiToKi3xv2+pclVVoDhm4wcuDODCbuAGHpgi6dIIpomtTEc0KVS2
 X2nLsr0rx0s52Mvl7YJoRNARBVTJXes5jx/6WBV5SLBAIsL7Nfkk9mhQ1 Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="65546065"
X-IronPort-AV: E=Sophos;i="5.93,316,1654527600"; d="scan'208";a="65546065"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2022 09:37:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFMjW6oEhWuNAJrAS0gokgeXUVcu09hMBYnzcJ61rsMH2aDlY6AzSSgHSfOKKMKglahD7gPmkMNZTmwZhwpgx70w4Bl/dDXw5LsxEZ8m6karNfu5+z/d75OVnhNo7MCRq0HerQ7ikY6Fwk7WAnM+RWu5gDtj8M+7SpQKnSfqhUvAMd511bVqzxTJSbzo/uXOd9ZA86GCEbOJYxMOfTlOgh9bvZQg/Ss5USBVobqqbjIgOj8prMpNxR2E1xDIjRlPr35FIh5CiVcFg7s2lCtXixDrWAM7HSHXU8q0XUAHwNV4y/c5CrVtF78bx9IR8vVwe9E+MEDqPveQRVyxONSBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Vo3QYCw0EGBhovy6gK7Z+xI+jnFb7mB09MloI2KqJE=;
 b=CKddZ0o5iS8TZYTqdqY24Kwr9+I9pAXo++Vy5h7FqSFcOlwL83FRalZKyzPr/o6KfwwzjO5YbPYTEWIGaU/ydNR4TqUqUojy1ZcEEuiyy6ypfhb26535mg7N2iqlQxmCbr+qNhORlRD/5ydqztkyO/plhkH6ljv92KMmp5nYFJHTPsucz3uo0MsQXiW6JRaEPpprr78BpQYhr6TlMX46OzdIeXQHuiAMVztlxtirkC951Vci2kZnFSyRRu9SfP/MAVK8wMkD+jfyhzPlHum5orHZuRaEh4vyo0ykLTL78mKuBaOPlW+Exfmn8uLCzvQQfhRIs0t+q79sumS8rRSMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY1PR01MB10848.jpnprd01.prod.outlook.com (2603:1096:400:324::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Thu, 15 Sep
 2022 00:37:33 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 00:37:33 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH v4 1/3] syscalls/creat09: Add umask test condition
Thread-Index: AQHYyAlTrUVCU8c+IUqnRmjYm3bjvK3eyhwAgADtgIA=
Date: Thu, 15 Sep 2022 00:37:33 +0000
Message-ID: <bd50a9da-0b32-2318-31ec-67a78155cc25@fujitsu.com>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YyG61JHO7iDAfJ1N@yuki>
In-Reply-To: <YyG61JHO7iDAfJ1N@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|TY1PR01MB10848:EE_
x-ms-office365-filtering-correlation-id: 6326bd7a-9b60-482a-b2c1-08da96b27aea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x0C2p1v/DLNndTdRAoDF/NSGymgspRv7FzN5q1de5XeyCi5b4Zyfq5vJzhfx4/IBxIaTWFa5avJ8qR26a9gAcEesgOPgP85wldodPkNzgshoJj1v8MAgH4Hy/N0VdieWLTRqXu3iy8+W70LQu5LqGATXQyC64j32ynkrXZHfFgWd3dxgpxX8HRmHIRtS7ehk60CfXg6+yo9AQbdAD9w5VVgrdNjwGUXuFBBmp2T5zA4g/uF2XFWGQZkJ60+jlLtzsUvb3cesstk7xztC4iLRbML0b9hbRoQQ4ircQKGzIlcnutW9GfHw11lfQ3GfHGT2lc+mhel/8ZK0PkT8W4jETYXnthvLE8pPQIPSAHkEQ2wroJh0X0e5cGZJlQ2q5lPUw5NYeR7EoULot2MNGMA/2yYmv6QYcIed51X/FTjcKlZ6zeis0gSMGZZz0npetiDprPDvlp0cGgkBsW4SG3syqOlPC+tI2MiZxARjXsZYTOw96B0iEpWB94fKsAbmd1IXag1hmzrPXOhTe7c5li9wu4aaJDiCtwScYw+sU4MKF29Bgq9QYti7T1Ju3C8CiBJ/Uifm2eNBSEQ5mVd9jUBHuvFHNwZntRZaoV8XZWrwSGTR57UTYBNSX/d7WvJGMNpy4ZRTfEYKv1pZAr8XsH2lTnNxCf0emtKShpd8wLDlE6hJ6TMwHc9YHxUoSoLNyN9Wx+7bv2fqt0oQ81cJj1kpTm47fgX9Nt2T5ZssGGrFosPkitSGTO/S3DJ93m7rCo4LdM2OZKSSwYHmyw7bHdwyLylYeuu24NuCtx0DEjBqQkVJMlOzFiPFj3rVYEbG+XLY2sruWT9vakksaTKpBq1Crg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(1590799012)(451199015)(31686004)(4326008)(8676002)(6916009)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(91956017)(6506007)(122000001)(54906003)(71200400001)(8936002)(2616005)(82960400001)(2906002)(186003)(5660300002)(1580799009)(83380400001)(85182001)(36756003)(6512007)(38100700002)(38070700005)(41300700001)(6486002)(26005)(478600001)(316002)(31696002)(86362001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eS83ZDJKNzBJWHhOSWVMSGxSdzV3OVRsQkpNalpiRHlWbEVlbWZ2eHB6UGhz?=
 =?utf-8?B?cGhrbW42VTFJb2xadHZkSUlBNXd5bUZmL1dYTGtqZ01oMWsvL3ZPVktZVUZs?=
 =?utf-8?B?QU44bURJREVGQkFwVGwrK1pJUytPOW0yc21SYVhTQjVNaW5MalhZUm84Qmdr?=
 =?utf-8?B?ZW4xL09ZVk1IYmF4dWhxaExMYS9GRlJhUE83WFFXWmN3aHQ3eG1GeitqMUNI?=
 =?utf-8?B?Rjk2UWFBT0FQdy9OMTdjYWJkR2JUOURoVVpKSG1jWGloaW85cUYrM0MvTmZ6?=
 =?utf-8?B?ME5LTk5hN3Y2OHhLM0NnV3Z0c0hMU0ZSTFV2cTVDU0c1L1pTZmdXSzlNU0s3?=
 =?utf-8?B?UG9NekpTcFVCbnhxZURkUFJwOEtlWG5nd0dwQmd3MDlpYjJsNCtibi81eEx3?=
 =?utf-8?B?M2JjUmRLeWFRYkJGd1pwKzZ0ZmxSczQ3TUZncWozVkhNaUFiUTM5OU96UWR6?=
 =?utf-8?B?eExXZEFObGpPaGh4Ym5FTktUaGhMM1VDaHQxcWtMUTZJTDBFVGVJRk9SVklp?=
 =?utf-8?B?a0JGT1JtYi9EUFA0QjU4TDY1V2VHNVhuY0U4ZVB6RHFEd09qSHh0cmVMblNl?=
 =?utf-8?B?QzUwdks0cE1mWGFtWHV4V3Q4WkVHeGFmTkdNUUF1eGVadGZIMEJmSmlPdWhV?=
 =?utf-8?B?ZjB2dTVXUm5FYWNURVo5R0ovSzU2T2NOdG5OcDRTM3YrTG52NWtST3Ava1d2?=
 =?utf-8?B?K2pFZFhMbFg1WVVNZmtZVSthT1RJYno2VjJXUm1xYmVucGNaR3hPcmdZRGQz?=
 =?utf-8?B?U0Q3dEc2U1ZGQXNOMGFKQXcvWG1ySml1SktpbG4wdkZRWXFsNVc2UGVzNXN3?=
 =?utf-8?B?OTZnQkI2cDZzdGNHUEE2dnk3ZGQvUklnT1dwRUM0UkZud2VwTGlxUmtpUEdC?=
 =?utf-8?B?cm1XWTVWNWhlVW9lSVN4QTk0aHM1YzEwMzlzOWk2b1BtUXY2YWU2NVB2STRQ?=
 =?utf-8?B?QXhScnR5MytMcjdjeXRhTTJZa3ZsRnJPeEdZb3g1dTlNVXpqVGJ5aGl1LzBE?=
 =?utf-8?B?WTFTL0hoNkozRHpJcittUzBVNXJDbUdqZE5GeUlJQWkzdTBwTjFBcW5GS0k5?=
 =?utf-8?B?Z2JYNzFGUVFJY1BWVVpCZ09yS3VDT2VLNFBCd0E3bFJmdTk4VzAzT1l6UUw2?=
 =?utf-8?B?QkpYcEV5MW8yYTdOZG1PbGcrMFN1N3FLT1VYRjZ3YWsvMlRHVHQvZXJjZnBz?=
 =?utf-8?B?Q0lyV2JnWnBPR3BsZ1RWZ0J6TTFqWjJlam5uMWdFbDZWOTc2SXZqUnBPbjJB?=
 =?utf-8?B?WmxVdGdPMEV5WDV4TXA5dHA1Z2ZmWDlycElUbEdZUmc4Z3MvR04yMGVoZ1B3?=
 =?utf-8?B?Ny9EUFhQMjlVeXVTaVRnZjVxVHpob0Zzek1BZWhidTBVSWZLbHltUHIxeXdB?=
 =?utf-8?B?Rjh0L2tNdzFhMTdjQStPTFZlSVZtRTNvSjhmdlF6SU1IUW1zaGU0QVF3WnMz?=
 =?utf-8?B?SFlVK0FiMEc0M3ZIWnVXb1p5WGZMRXVPVzhjTFNydHFwQTFDMEFGTWYwTHdC?=
 =?utf-8?B?OXpzaXR6QnlKc0pnRnEzUGROVHJXbnZvNzBLSkNrdWJzbGFkVHdSVXFPcHJU?=
 =?utf-8?B?RzN2d1hNWFZIeG5ZRDRBanBvQmpMOGN0OUUyL3Vya3VtbDdvRE04Qkk2blF2?=
 =?utf-8?B?ck10TXFjY1FJcFNnV3RDVnJ4T0pmRzNPVUcxanBHVjFMSjZhWmgzbWNUVTJ2?=
 =?utf-8?B?QWVITVhVMVFHdGNhTXJDNlp0WC8vTkorK3FNVmIxMWJaRmQ2b1hTSk9zY3VE?=
 =?utf-8?B?bENKYnQ3VFJheWcyVE9mQlduTDU5bXJwM2VKZUVjRVpkSVZha0ZpUTB1Ykg0?=
 =?utf-8?B?VVZ3MmNaQ1pqVFZPa2xjNUIyTzNHREQ2V3lONlE5b3dvdXRjVDZTTEJ4L0l3?=
 =?utf-8?B?RVMveEpmQWN2b1BwclhEM2ZmNzA3ZFJtcmtpY3JTemNUbzNqaEZIVDZBUnlH?=
 =?utf-8?B?bHJwM0hQazBhRUpEeTRLdXc4cTZBNG40Ris0YzVaZHB4dVIvcStvWmsxTGFB?=
 =?utf-8?B?a2Z4Y1BPWnQzWkkvbFVkb2paTy83KytGdVJnOFp6OGtTTG1PdS93aEEwQjlr?=
 =?utf-8?B?OEVvT0VhMkhFcW9QZmhjdlVIMnhQMmg2Z3lHUlpBNWs0QVNEZWt2L1UrWkdr?=
 =?utf-8?B?MUJ5Yk91eU16U2pJbUdid1VHak9HbGZ3SGxSc2JpRHhhSzlMMnZVRWhHWVM4?=
 =?utf-8?B?cXc9PQ==?=
Content-ID: <25F14CCE91111F45AB407A5B9AFDC7FF@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6326bd7a-9b60-482a-b2c1-08da96b27aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 00:37:33.6268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +gL014C0fiR1uneOw51LP/yXmckLM/7j1djablPtdL9O6X8WmuMqKQA5YOIrekz7ShqmUz/VJoJtGh1bVkYtm84KqOAKNY/KkIt9khzTSDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10848
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] syscalls/creat09: Add umask test condition
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
>> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
>> index bed7bddb0..d583cceca 100644
>> --- a/testcases/kernel/syscalls/creat/creat09.c
>> +++ b/testcases/kernel/syscalls/creat/creat09.c
>> @@ -28,6 +28,16 @@
>>    *  Date:   Fri Jan 22 16:48:18 2021 -0800
>>    *
>>    *  xfs: fix up non-directory creation in SGID directories
>> + *
>> + * When use acl or umask, it still has bug.
>> + *
>> + * Fixed in:
>> + *
>> + *  commit 1639a49ccdce58ea248841ed9b23babcce6dbb0b
>> + *  Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + *  Date:   Thu July 14 14:11:27 2022 +0800
>> + *
>> + *  fs: move S_ISGID stripping into the vfs_*() helpers
>>    */
>>   
>>   #include <stdlib.h>
>> @@ -47,6 +57,14 @@
>>   static gid_t free_gid;
>>   static int fd = -1;
>>   
>> +static struct tcase {
>> +	const char *msg;
>> +	int mask;
>> +} tcases[] = {
>> +	{"under umask(0) situation", 0},
>> +	{"under umask(S_IXGRP) situation", S_IXGRP}
>> +};
>> +
>>   static void setup(void)
>>   {
>>   	struct stat buf;
>> @@ -94,8 +112,14 @@ static void file_test(const char *name)
>>   		tst_res(TPASS, "%s: Setgid bit not set", name);
>>   }
>>   
>> -static void run(void)
>> +static void run(unsigned int n)
>>   {
>> +	struct tcase *tc = &tcases[n];
>> +
>> +	umask(tc->mask);
>> +	tst_res(TINFO, "Testing setgid behaviour when creating file %s",
>> +			tc->msg);
> 
> This can be shorter and more to the point, something as:
> 
> 	tst_res(TINFO, "File created with %s", tc->msg);
> 
> And the msg could be just "umask(0)" and "umask(S_IXGRP)".
> 
> 
> Otherwise it's fine and I can fix the messages before applying if you
> want.

Yes.  Please apply it with fix the messages. Thanks.


Best Regards
Yang Xu
> 
>>   	fd = SAFE_CREAT(CREAT_FILE, MODE_SGID);
>>   	SAFE_CLOSE(fd);
>>   	file_test(CREAT_FILE);
>> @@ -115,13 +139,14 @@ static void cleanup(void)
>>   }
>>   
>>   static struct tst_test test = {
>> -	.test_all = run,
>> +	.test = run,
>>   	.setup = setup,
>>   	.cleanup = cleanup,
>>   	.needs_root = 1,
>>   	.all_filesystems = 1,
>>   	.mount_device = 1,
>>   	.mntpoint = MNTPOINT,
>> +	.tcnt = ARRAY_SIZE(tcases),
>>   	.skip_filesystems = (const char*[]) {
>>   		"exfat",
>>   		"ntfs",
>> @@ -132,6 +157,7 @@ static struct tst_test test = {
>>   		{"linux-git", "0fa3ecd87848"},
>>   		{"CVE", "2018-13405"},
>>   		{"linux-git", "01ea173e103e"},
>> +		{"linux-git", "1639a49ccdce"},
>>   		{}
>>   	},
>>   };
>> -- 
>> 2.23.0
>>
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
