Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A7BC433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 06:51:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 688253C01CF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 07:51:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AD953C0162
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 07:51:29 +0100 (CET)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7CC21601462
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 07:51:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646895089; x=1678431089;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=6gyahLw0yUS52AG49MKtu9jkTDs51oKgWIwk8SeCxcU=;
 b=RKsZnR2M8DgkHGtV+Nq85iHo8e9gZfIrlGawbijv0HGkOoifnXbbjhbh
 VCzGCx66XPWC0+iFPdKFFyGQkFvczX9FEWjejBelZmRjoU53kH8yHYY0K
 JJH+eoHvGcDqZwm9nUf/y2dyT056/ckoryNu9VzUjk+pRWQrCQxHgbw3s
 o71bg/4DiL77NgoalNSBAYz7/S6HjIX13qtU28lYvBYZtsctuU6fPCR2S
 gDgNg5yNF3UrKhfFM5E+RVBukFfVzlaBegemh5tJMb7ucIRL+GfEJPH4E
 cOQmnmC/QRhwTWdUr6+mPdRpgGl7KzyWt+bPQ0MdlP4GMvnE8XSn9CelP A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="59680423"
X-IronPort-AV: E=Sophos;i="5.90,169,1643641200"; d="scan'208";a="59680423"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 15:50:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQNPPZ6E0Qxy1t1UfVKwOfqoLeL6RRxxrvuXZbgGcL+BDBnFFouqfi2JbdYTkB1eVaC7y+S4JimnufJWlaz0+WGjyrIdPPTwqcgExryYEEAjgXqRZ4AFDhay2E1Y4g4Ly4/d/8Wc1VjByp5dJfmY+yRYqo+ARgbHQtrfwuf/zDV46j1YOpZLCO8BjN6zUHkg+42HXyeTN63n887yuwUdGOgV2hTjfDEEPxjfZ7ap5EkC5j/B2ItYJpbUhnt4rvb9gTgGOXUlzbNpcYRzOENjbxwQR5xb+UXlie9D02O3TL5v+Za1olRe1jhqm6DtCH80QR3CtFwJxdpIaliMzroPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gyahLw0yUS52AG49MKtu9jkTDs51oKgWIwk8SeCxcU=;
 b=HS2bRV33mwRG8rpGKAYJmD66eQ5Kq51azNIbrE6wozOnvh/UvGksAjtAWVMFh9IeLaX13kEW+dZ+FiLavb9qFh4Ry3L29Qqfh000HjPGC1fL1sk2zMhtq2iUly/URFzGkzHrZ7fTzX7XLs6Lie6uJr0NznHT+eiFoEKlVer6vMqTFBUERHUh8PM2sXoGdcRCqmN0+y55fvLGf0A/2sFARuriMTtQ4pn4AU/vc5L5xTiDmGa0IEqTcqroOOdCDMpvwTpPKSspN+4PtBJMq0phmVjPGPJn9zEE74qZOBaA1aGPD0oyKDpVvDh9y+tAAcq67j86JQTDkw85e55pzqy5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gyahLw0yUS52AG49MKtu9jkTDs51oKgWIwk8SeCxcU=;
 b=rBvRlo/+t6n9CdRmRUPHUxjliOqG1nksw/5mbhovfkNQIli8lcNRyY8DJbWpTX1skvJM26bCCq1tMz6FS0F7grQFJKNmLtklA5LsPrV10cbADNqbkAVDZCdAqIJ7qMLvTSOoYsPPX98gv30ZbSJM8RC8/KCTMJcppnPqt7T9TEU=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB1604.jpnprd01.prod.outlook.com (2603:1096:603:31::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 06:50:34 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 06:50:33 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [LTP] [PATCH v2] quotactl06: Fix tmpdir cleanup if setup() exits
 early
Thread-Index: AQHYL7WvBjX6PCVdhEOs617mForjkKyvDuYAgAkoMYA=
Date: Thu, 10 Mar 2022 06:50:33 +0000
Message-ID: <62299FEB.30502@fujitsu.com>
References: <20220304105034.22083-1-mdoucha@suse.cz>
 <6221F178.2020404@fujitsu.com>
In-Reply-To: <6221F178.2020404@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 425df37e-ec98-4fe4-a707-08da0262465e
x-ms-traffictypediagnostic: OSAPR01MB1604:EE_
x-microsoft-antispam-prvs: <OSAPR01MB160435A49F42AA5716D84D20FD0B9@OSAPR01MB1604.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7qV7l14kWI5fQVlQzGmZHIHwEJV9knIHj1fM8ANuFLiPBP8tokZRaYxWBXcKQv8tX983nLAutzpNdioCxSOabydaPpTS+HYsC1aPqBTHk/ShQVEVryVXXeMgxu42KisvukcxtC6XokBNrenyGSUbYvALT4zl0xLP4uZRljGt93ulMehjUqidrVSuvQrfHzkzvxmRJzMBGCmpGhs6vmw62ZZMZYpKogbRgwFkGagb0BP1NxblYIb8t8mZ9HNPv0I2gg7qhjTTKB/7q2Jgq5bDeE1Lr8r0VROaesXd3P472ZEFgG7xSQ4Op1K5PSFTn6J/ESImEnXlNBx4YNBJyAiaxwlm8+X8c38WTY2h+MtPx75DbXi5bVLLWxLUbZcXtNkdR91IAx054YeqvIO9P5emQPqPSgoEDYBJi4AZ0Lg5VAQJ6GOdVtthuBLpduQAHZVmspiEGDRHH2Ost8tfloTMHL/hOpa9onCfqgyvDpYapj3dhxx1446E12q35tCRhg0fK9Ss/79pQcTeUI6kY5yvBDXGxgVNPGb6KGYrbbF8N6WOTPs/T3quSivVxF8eBdtabtmMPYRrLsd58ZRqxKuCM9oK4Bm/mX3Hfchnl0SBlrUZXEQ4Xn/rPRUGleXiVs8jpzmrJKsW42Bsa4cyhC7uQvTGFLZb9Ng3h2779JsLAjvWRLkyl4ZVX6WHNHD3RGGiXtCXfpBe85QAxFAhEMu34A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(15650500001)(36756003)(4326008)(8676002)(6486002)(85182001)(66446008)(66946007)(6506007)(6512007)(76116006)(2906002)(66476007)(66556008)(64756008)(38070700005)(91956017)(83380400001)(122000001)(86362001)(186003)(2616005)(26005)(5660300002)(38100700002)(8936002)(33656002)(6916009)(71200400001)(82960400001)(508600001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?d1NLbVVxYkJJVjhWeVQ4aGFMd2JVcGZjbzQrQS84NHFyanFtZ3RHbVRLMDN4?=
 =?gb2312?B?YnBhMEJFMjQ4SHpTT3NyYytQU3o0UmM0bSs2NWNSd21DeGMwU0V3NmE5ZHVM?=
 =?gb2312?B?MDRpQldza0NLNkhWRjgyQ3gxZU5Wa082dTd6MnRTbmFueTFmcXdrbHZnMXpo?=
 =?gb2312?B?bGMxVG0xNEZDZXM0ZUhEWVJoUW9tTkhJZXhML3V4LzdTekRnZnA1YlBnZVcr?=
 =?gb2312?B?cTBJd0U5dWVXLzRLbngvOUNLK2NvMXJHUXdoWFB6dzU5UWVzZjJ5MDN0bzk5?=
 =?gb2312?B?THVxQVNjM3cyV2ZzVU5JNHpUaXMzazFKeWNGNC9tYWtDcW9JZURPQ1lCUUE4?=
 =?gb2312?B?Q1ZOTkNGVE1NcXQ2TTZPa1Q2WW5HbEF4SFpEWGNRdWtoSW1kdXNJcjFSOHNt?=
 =?gb2312?B?Q0Z1S1dvRTR0QklSMDgwd3YvQjh2d3h5Si9vYWh1R0kzcUpBWjFvalF6ejNj?=
 =?gb2312?B?VmhBVUs2WithcFd2Qnhxd3ozVTBiMjhqaEVLdmtuMElNbmhETlYrVnZCS0RR?=
 =?gb2312?B?RjJmdDZOSWJsWHZnQ1ZwZFZXSFJkY2VqYnVueGJWZk01YU5RUytBb1NXZzlP?=
 =?gb2312?B?b1N6MzVxdm1rK1BiSGRES0J0RFBhOC8wRU11N1FHMXNGYWVhWlJaQUorWlhq?=
 =?gb2312?B?RkY1L0ZVU0hQL3M3Q04yTlE5MkVVTHQ3NjFNOHRLS1JSaTRpY3hFbVN4b3Vk?=
 =?gb2312?B?RG5WTDhDRGQ0TjFQVFVVaHFOTUVxSEFDWTdENzBRem1Jb3ZnOWYrTTl4all1?=
 =?gb2312?B?TnFCblYwb0FGYVh5Q1hncE9IZTBXd3BSY2ZoQmx0Wngrb282dTJDL09BbTFC?=
 =?gb2312?B?VVJVaHZaYmlPL1BoS1ZwamtpeWtsNC9RWFQ2SGRteHVDMnJlaTdiYWdQemlV?=
 =?gb2312?B?b1BMYkV1ZXZHU29xY0NDZUxueHFFUHFlcW5wMGw4RDRnanFoNjFGbDhTaVo0?=
 =?gb2312?B?WXdqcGFXSmZPRVNVMGNIRFowYVYzU29qNVJzNmlZb1B4dGNUeGY3Wlp3alpH?=
 =?gb2312?B?TUJWUWkyNEdpL3l3NWtCV09rZlY4SHcxLzNuNXhKUEl2WDh6Z2Z1dGltTVFp?=
 =?gb2312?B?VmgvOFZ3TkMxdXN3MUtjZ1YwV0RvYU5Gck5OL1k4bTJGYkNQS0pWQ1Bpakd0?=
 =?gb2312?B?c1ZzRDcreDJKM3paTXFSaXdtbDlFYU5oOE42TVEvT2dVTGowNEZkTytOUGlK?=
 =?gb2312?B?Z0k2TFRGRXM4dThoVWZ0WngvMUxnNWh0T25tNXcvOW5TVVFtajJOeEZmQkRy?=
 =?gb2312?B?RDZmNmVqQUtTR0RTMWJhVUkyRU5YbUFNSkdYbWdpb0hVb2t1bmp6ZDZkSmlE?=
 =?gb2312?B?NTlKWnpDdmxwKy95UWtuZ3JERmNKTVNtTWIxK2tpV1dUb0VhNS9ZckM0cWhP?=
 =?gb2312?B?M0krTFhSNE5yL3dlWjgvSVhxZGRQcmloRmNXcndqUHA2dTFVN1dsNWFvNDRT?=
 =?gb2312?B?b0ptRVZzZUxHSHMzc1ZLdERwNHRGaTcvNm9WSmMxUUV0bWZCK1Nkb0NUZmpB?=
 =?gb2312?B?eTZIZWhhV3dZblNONzNKZk5tUnZYbzh4L3RibzZUZlVic1hNY3pIM1FjZ2JY?=
 =?gb2312?B?OTk3MTV0bEpGR3Byd3p3Z2xIbE1abGxqaGczb2U3UzdsZFpOZWR5VE9jMnRF?=
 =?gb2312?B?dFFJVEYxakJKak1tMUUzOG9kbExkSHlJTUZGMXFJcHlCanhWUWhVUmZRanc5?=
 =?gb2312?B?TlNNMlBHTnFnczdQeEFxd2FZZG94WUFTbDZXQURoSEtSYUxBNEozbStWVTIr?=
 =?gb2312?B?UlRBRGNPR0VTdDFhd0JPenhDMCtqVElOd2pDY1pUdUVQS2dZOS9RMzZKM1RG?=
 =?gb2312?B?OVBYV3dhKzhEZjlISVo5Y2Q0aDQwZVZxZFhMMFlHeElYdC9LeXk3WkhrSlRr?=
 =?gb2312?B?WlZ5S3d1MVZPS2FlcjA1MngvZW1zcUgvbFF5dXpOWjFlejhTSmJhVXRGYjdK?=
 =?gb2312?B?ODl1a3pHT3pZMTRvQytsUnF0Zi81RG4weE0rV2kyUTc1VG1xZk10KzF5MGRj?=
 =?gb2312?Q?oyfnKX8RYbZG9z9mP9DiiQsojYX9bk=3D?=
Content-ID: <E314C62DD866D24CAE6A977F9E05353A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425df37e-ec98-4fe4-a707-08da0262465e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 06:50:33.5286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nqsRrdKQStJuP8s/m5k19l6ylrXYetht9ODrQO5jpsbjhiluChDSkU8siW+Dw1b+s3ApVs96nNBlZGJEy6FpG2jrMZHONlphDcNnPyQRLNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1604
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] quotactl06: Fix tmpdir cleanup if setup()
 exits early
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

Hi Martin

Merged this patchset, thanks.

Best Regards
Yang Xu
> Hi Martin
>
> Looks good to me,
> Reviewed-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>
> Best Regards
> Yang Xu
>> When setup() exits with TCONF before USRPATH or TESTDIR1 get created,
>> cleanup() will trigger TWARN when it tries to delete them. Check whether
>> the file and directory exists before removing them.
>>
>> Signed-off-by: Martin Doucha<mdoucha@suse.cz>
>> ---
>>
>> Changes since v1:
>> - Also check whether USRPATH exists before deleting it
>>
>>    testcases/kernel/syscalls/quotactl/quotactl06.c | 7 +++++--
>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
>> index 8e9a17393..87715237f 100644
>> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
>> @@ -206,8 +206,11 @@ static void setup(void)
>>
>>    static void cleanup(void)
>>    {
>> -	SAFE_UNLINK(USRPATH);
>> -	SAFE_RMDIR(TESTDIR1);
>> +	if (!access(USRPATH, F_OK))
>> +		SAFE_UNLINK(USRPATH);
>> +
>> +	if (!access(TESTDIR1, F_OK))
>> +		SAFE_RMDIR(TESTDIR1);
>>    }
>>
>>    static struct tst_test test = {
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
