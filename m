Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2943C433F5
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 09:45:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E0423C8FBA
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 10:45:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4B123C8E31
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 10:45:46 +0100 (CET)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 258856025C3
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 10:45:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639734346; x=1671270346;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ccHwdinvlQ8dn1JEnrb9Mb+h/d1dJrfYYytSIIqY++Q=;
 b=lyh8OLqmdTKgf25ESiTZTPsyvJVl1aWougS73GOP+rOBOuqIxvHuevHq
 NWwgfIEZRAmJ+n2heMxXSmtgK/DpDlaKGgsHMBjcBF1V3CCjVlJnENqIo
 SoQhlVS0GfW2sXWmUNtpsxedtYEbkb4SWIJW/9LeVDEsA8/E8xuL43EUt
 OhBNWq6ylqRmvxem6hfzvoDucwfDTlxK5v7NgQiA4tbkmgxVw8oGRDGEx
 anaMpqiI8X7cfzT/qXOf/Yu8U9MzofECv7O9im7s/Eeqa4/6Sx8N9NyUf
 OcylpSlfmacuPXriWnyGkZOCZncipnrZTeXA6HyroFXi8V0ajbwDFDTqw g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="46188013"
X-IronPort-AV: E=Sophos;i="5.88,213,1635174000"; d="scan'208";a="46188013"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 18:45:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGzhRVIBI/7GjB60vbiDqlEuevX5dNTqrBy+Ki0W4hLcERGVe6z5MJRH6I9kQrWuCMJjesQ/vCj77QRMSgKILFMyw5NdPtRPKEnzUceqNwCatiTFLmpmDh1wm3pfOXlYvk/atffgu1+jdJ1b5CVO9p9IEFiVmkDubAeLPg1RgGozsY1SJ8qg28DrXVM6XTwHtp4QOfNCzC9X2f8xY8f30plmxTiOY9gV/qOsss2gImfFZgjT8hxb/VskrSpr2mMWgB2QMTpxV9ONds3EaPcwZZNIrlbmBAq9Z/YP9vOK+KDhDoF3rO40v4XfX8fM/QHS71M3pNn4l+E6ew5HNYncfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccHwdinvlQ8dn1JEnrb9Mb+h/d1dJrfYYytSIIqY++Q=;
 b=H0YgfkyPlzfrABvtCVkYYOXrNX10r7e8yJYb64MCD9IQeMJSlMfAKHZmYTrceH5lRzqgHDAOlTd2nv8XhdlapLWFA69uATcmjOGmJfL/7kCkyCf7J07O75cUoJ7DauypgNC2N5oQhxvC+l2R4CU5mCkuFGYFJP8LKC4wihl5+R6Q/j+sM6iejwwgNAvNU/TcpzDT4YuhsRJ5St5ZLC62Dgb40dotL94shadXj4foT72NftUinkQvib4guZ6hgd+VvceosllDTqy2+tKhrDqMGFKsZPuhT0AbAOhWnTGPs4dBjvj23xdv7lz/ZlMDs6CsvUZU9Y4OfzXYiPKJrRno1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccHwdinvlQ8dn1JEnrb9Mb+h/d1dJrfYYytSIIqY++Q=;
 b=TYN5fiW5v0ApVUO8DceEGaQntSkrLj2zKn7HQWokQb7gxyzTdx8wsP0RoK6J6crsjerMl3RTqcst92BfXnSleMmNiosTxD5WD+wdDXi9UpcK6r0PBY12hfT//3dSxRwBMq9H95VC+db25Od1AIsR7g0KkQURHjdubymVngL5Pmo=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB6671.jpnprd01.prod.outlook.com (2603:1096:400:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 17 Dec
 2021 09:45:41 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 09:45:41 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v4 4/4] zram/zram01.sh: Use mem_used_total field
 instead of compr_data_size field
Thread-Index: AQHX8YRVnqpEYOS5UUOIgBA7aJkc4aw2YoOAgAAQLwA=
Date: Fri, 17 Dec 2021 09:45:41 +0000
Message-ID: <61BC5C4A.8060502@fujitsu.com>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639552849-2251-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbxOtyzYsbgZ578D@pevik>
In-Reply-To: <YbxOtyzYsbgZ578D@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7e4eb35-5264-4074-73a5-08d9c141fd4a
x-ms-traffictypediagnostic: TYCPR01MB6671:EE_
x-microsoft-antispam-prvs: <TYCPR01MB6671B75F978115E4A064D9EEFD789@TYCPR01MB6671.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: znauOKqauOTEPvvE7mtSYkJvMTDeypNeWudBMmdNGLRa4EhpYfPgSMxixrMcBJaDaNZgqGzoiWT3I+IlvIy0J+3Kfs1RPXrCJ6ur6u9MQFLGItLbrPBYraK+QyIg4psKZmc+0Q0GcrW9DsTQoNUJrWjkKF+dLqNS7HwRJ12/vU/c7E19GZlewhTyphB+nWzFxQTeXjUlQJFPElxC0t1MB9K1/yOYW6qt1R40H60BJMNmBBfcy5p9gaVrUY1RwnWR8z3vTZr5ciqkVNcBkA2oz2s688aIQ8SpsVO5bCB4vCty3/VgyDJbcBa4pe6yCBBG4m9AlRFHPWFvlhq+vkI3c7ZP8/QFIBh0JUTsVVtqgnAF/8IBhY0FyakvCvqx59RDmOBHldjKWXeP97kmKhZt/rUaK6SaD1nfzEryJHv8ZkBo9gtZ8S1qtNN8BYbo0rOkey2MhIAHcCjoP34NO2Q0jIzKwSrkP2lPU00FOmlkzYoBZVNljlXtn1d/ocS50Q+/EF64p4tVI/r/D9ywFKr7ZdLdIfzFZXbrq1gb41CNossNe3IspQnb9JqnmZJ9yDFQSxvXECs/cS1iCJXRNN+nvzrekqekCSYAdbjjJ0RFtmo36X0p7mzDKRaRex/SyKp3kZqfqayBfOzYca4kkZHfhok7+VIe8okege7Qa1DPkaJvTSRRuSheeWQhJxY8Q4bzsSSK/w1kHEBso6odatCWnw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(40140700001)(54906003)(76116006)(86362001)(4326008)(36756003)(6506007)(26005)(71200400001)(85182001)(66476007)(66946007)(6512007)(64756008)(87266011)(316002)(91956017)(6486002)(2906002)(38070700005)(508600001)(6916009)(38100700002)(5660300002)(66446008)(122000001)(8676002)(33656002)(2616005)(8936002)(186003)(82960400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OC92bUJ3OVRxU2o0MmdhbnZvQVRxeEhOV0VvSytMRzZUWWVxRGxzQ04xVnI1?=
 =?gb2312?B?aDhIWXdscTRXektqS3FsKzZoakNycVJ6SjRVOHJBWWJyZGhDZ3diaUc5MTQv?=
 =?gb2312?B?VUNWcXJoVXdIMTJaS0JPajBVcUZmZG1kSDAxNjlqTjAwZFdJZjA0bkxtTGE3?=
 =?gb2312?B?QWxUTXFodElrVWNhVmVvVkpXUFc3NjRSaFhZK2VnQk9Bb1RSeG82eTNOZVdW?=
 =?gb2312?B?ZUtEZ090WWJtMG1FeVUyKzBsVmVleHlXRXJCdHFjV2NQa0F2R0lCN1IzakdO?=
 =?gb2312?B?Q1JrK2lDWUlMV21Pa1V6b0Y2Q1NjTURIRW8vUEZoRklOMmlTQWhBeXV4OXVZ?=
 =?gb2312?B?ME12eUdxNVc2QXZUSzNuZ2NrcGtvVmxFcnBEQlRGMlJLendDaVdnZWNsSFQr?=
 =?gb2312?B?bDBzam9xNGl5RUt4NmlEZjdqMlRFMlVkUG9pSUYzZUJIV243VUtBb042ZWhr?=
 =?gb2312?B?MjZsZFptM0FZamNWaVJUZ05wM3FHbTY4c0duVkc2d25JakpDNUlrZHFYMm56?=
 =?gb2312?B?QlFGUTBuK0NTR1J5VGVmY3dkeWcyMmgzd2xVb2pSeVdHRHJwMVdCanBNbHhW?=
 =?gb2312?B?NzQzWVVrNXJGQUdGS2hsT0tSMjBGS09PQ3ArNGo3UFhYVVpWaktXSlFZbWFr?=
 =?gb2312?B?cWY1Y2hlR0xqN3Rwck5SbEJjQXBJb2dVZy9yLzA3Wkt1MnlDQXhLOXdkaGwr?=
 =?gb2312?B?enRvWnN1bjZWa1hoSW1mVHVwZGxPYWc4cU9KRGJDbGRJZEhURGJDVW5INngr?=
 =?gb2312?B?VHlBc1NMczNxYU85REI3Y0pTbW9vTWFKZG0yOTB2aW9GYi95WURYcGlkdGZi?=
 =?gb2312?B?dHROUzRJNEZBU3JNTHBCeFpZY2pBcDBuMU4yYU05ZHcrUUdRTkluN1VmZ2Qv?=
 =?gb2312?B?cjFqTVZycEg3NEZHY2V2UTNQbUIvL01KRC81Tm9EUlNqc1M0RWVLNENkY3JU?=
 =?gb2312?B?akNwdEt5SnA2dGxUamxiR2dsYm1wY0FHR0x0UEhVREpMY3VYMnMxTlFlTDFN?=
 =?gb2312?B?RUdIb2l3SWcxaDlaRjhSc0FLR2IyNTNETUxOMmdBZjk1aEp1MjVxWUdKZkc3?=
 =?gb2312?B?T1R6d3UyNFZZbUlob3NWeEg4OWZWTW9LZ1dOM3g5TndCanQ5algzWXNMbVFm?=
 =?gb2312?B?elcrWlNxR2tHQkUrVzViVVNwdGFEVDBLaG52akwxMzdiLzZhSXpmazRYQjRi?=
 =?gb2312?B?ZEJzNkhrQmtwMjZ5UjB2VUowVlpQZzFQS0Q4dmZXUnlOdlVEczBFWnQ4RTBn?=
 =?gb2312?B?eENheXJBN0MwUTY2SjUyamYrZWtObWdwZlF4NnN3RWdUMUZlUk9XNVpxblZK?=
 =?gb2312?B?MmFHWUxXT00zZUtVZy91bjV3d0YyZDZ6L1l3bWo3ZVcxRDRNRlhVR0hrNFZB?=
 =?gb2312?B?NGs0OUQ3NE9qT1NEZUl0SFpyWVdPTnRHckp3VGlTRG53eE5OMWdNbkU4NE1q?=
 =?gb2312?B?Q04xVkh6QWpOa3gvQ3hjNEorZ01ENGIzZkY2UXBFcGRxck5pOFEzblk2VFJX?=
 =?gb2312?B?N01pQnptT1lZWTlDK1E0UE1wTUtlV3FLc3FPK01ZR2k3bzVPVlQ4VEczQTlW?=
 =?gb2312?B?ZkZobTZxczhvZXhyV1hVNjZkQ0tIWk8xV0doYjJtVDBRWm1lYjNuSkp5cFZ4?=
 =?gb2312?B?WTZ6OXNyNkhicFlQUm9LcDl2bUpyNGlHa3R1UWtENUx3QWxGQklQc2NXMTl3?=
 =?gb2312?B?MmpVRU1vSzdkaE0ranJjQTNSL0loMngvK01BS1NYbXJ3Vjl4T0NvTWp1cHdz?=
 =?gb2312?B?S3VDM0wycE96ejBScnNiK3NnNHkvaS9kTmJBSkF0TDk0NVBHcHRNVVJuRW96?=
 =?gb2312?B?V2VlK2t4QytDTG8zNHZSTmJaYzZneFZLL25OczcvZ3JVNTZkTTRUWllOdy9o?=
 =?gb2312?B?UkFTalF4Mk81OGxROTFtNyswZVpNT2VKRE45SlJGSFJBZmVUVzV5eFZLMms0?=
 =?gb2312?B?cWhFK0ZWb0lYSXRTNkVUbGdRN3MvWFZQQTlCQjNhU3hlRi9ManFwMSsxK3hV?=
 =?gb2312?B?SGtLc1RVZzJuVElnRjZGNnAxTWRrUXVkNjYveWpXTlBYL2RYNnZxOGJ0SHA0?=
 =?gb2312?B?VWwySGtZVVFwQnYvblZUN3ZYWHc2NFkwTzdwYldoemRvLzI0REI2TVRYd0dZ?=
 =?gb2312?B?SURUc2p6MVBvVVIxaVRzbGh1V28rb3dHajhjSTJLSFFRU0JjUUxQclVteVdp?=
 =?gb2312?B?dDdSdWpIc2Y5d0pzeHhUNzNKYTRYK1Q4aTRpQjA0dERaMjB2cXhCNVFUOWxL?=
 =?gb2312?Q?33Z1T9y/jfABnZSSqEhgYAIIIlQwGg6CTBbEttIKtA=3D?=
Content-ID: <84653317C095BE4287DC8D9FA4A60E6E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e4eb35-5264-4074-73a5-08d9c141fd4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 09:45:41.5070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtoCibMC2oHrJn8i0Y+EIb/gbUk3I/0LPPFyl0MAVWS7OARg+bYr2Rh8XCQ5c8R4Vgbvrt6zRKHjrxemcYGoqzk83rLjtubIyozqwzS08O0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6671
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] zram/zram01.sh: Use mem_used_total field
 instead of compr_data_size field
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr
> Hi,
>
> [ Cc Martin ]
>
>> Before ltp commit 4372f7a2156 ("Fix compression ratio calculation in zram01")[1], we
>> used free -m changes to calculate the compression ratio.
>
>> After the above patch, we used compr_data_size to calculate. kernel documentation[2] has
>> the following info:
>> orig_data_size: uncompressed size of data stored in this disk.
>> compr_data_size: compressed size of data stored in this disk
>> mem_used_total: the amount of memory allocated for this disk
>
>> We should calculate the compression ratio by used disk size divided into used mem size.
>> It can also avoid the situation that division by 0 as below:
>> zram01 7 TINFO: filling zram4 (it can take long time)
>> zram01 7 TPASS: zram4 was filled with '25568' KB
>> zram01 7 TINFO: compr_size 0
>>   /opt/ltp/testcases/bin/zram01.sh: line 131: 100 * 1024 * 25568 / 0: division by 0 (error token is "0")
>
> Thank you for addressing this issue. replacing "data *stored* in this disk" with
> "*allocated* for this disk" could help (although looking at kernel code
> mm_stat_show(), I would not be sure).
Sound reasonable.

Will send a v5 next week and wait some time to listen more advise from 
others for this patchset.

Best Regards
Yang Xu
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
