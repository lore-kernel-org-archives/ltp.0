Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA81EC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 03:04:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377F36103B
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 03:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 377F36103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD6DD3C6858
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 05:04:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FE613C0959
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 05:04:34 +0200 (CEST)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0C23F602202
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 05:04:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1635303874; x=1666839874;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=dkQIRSlXUBc2uyaCl2WKa+gvfj5+jFQt4zB6dbwvAeA=;
 b=i6MgykwQCd/q2gfqqYTxchOk6IlsP4OzSQStoWhUppwfR4TA9impjoyD
 xQrFMX9OQmtCljQUgioPDKaqCTou+5zYgr3WY4d1765qsuLTzsIwvcbN+
 GNI76DydTsdzPqESGzN0ErKCSqRqRXvkLGxNRn32TPsMdm2l/q8ApOCPM
 zIw4h4/znDERh0Pr4gMhRBPP9ZjsHPmNJ7flfcevySPmcP788iRyWySDL
 +E53/whgIe8HQgQFj/y3/aK0djZBl45+R0A/ZjjYBc/EOrTFVvu/3DVJb
 b5M307BI05lr/qfKnWnNv4XB0DgjKICTHwpy+ZL8bjTiadJ7kA/QCHeaV A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="42110262"
X-IronPort-AV: E=Sophos;i="5.87,184,1631545200"; d="scan'208";a="42110262"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2021 12:04:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OavFeNGUxr/uIuX5gMUZbY7g/sO+9G2/NrAhwlnyG7wikz5QOJDuK4ryM1Zy+/JI/AqbYcB4Y0jlVXlkPIHe/WyT9P/YMENKXQ2s/BFkH/CjvwWwxalCC+us9urFWiRov6n/82yTYGrvxUHYRpwlrCVidk22Qs/6pzTZzT4qElRuk5mcm+sgB8+cciWEsVs6XPMN5KnS/Dd1uBR8o0FvcMakQydNTf8Xky28H64GcGVaMcDfvKy1cWavvODgHzodV3VUWCQxXbOdE+GeJwGWNQoV8jv0IeoVJgg9fiJ4myY/OEuAGJK3VsTqBAVKM+OYm2cNmTuBOohQNegk2fucPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkQIRSlXUBc2uyaCl2WKa+gvfj5+jFQt4zB6dbwvAeA=;
 b=nl2KTNV0Fm5jqQVJWUinK4qwwd66GggdsFYg22BErlryJaruB8Vc+/NYQM3me4VaLrBv15WZMIRHfNPIKhiGHM9TEAN4vU08nPJVYYYFuM5Jwc2qR7FQzTov+mXMLfCJNXV3E1Ugz4NO7FAAo2jyjaWcGWXXmMsCy0jqyI20Iz/LVDJryOXz4f8ZKnaA5GeMLrcqAs2TZVpj2NusyhAAEPpRngsH1IybnNS0iZ/2FfUSqsXk2QY+drLcxZIj11z1kVaGn6DSPnNfzrOBUnSoEI4ip+CgJ5JQClAPppQSSa0uaDdNBIAd7u+Y4Gc2LemxjF95B8eZps3l0jUs0RoiuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkQIRSlXUBc2uyaCl2WKa+gvfj5+jFQt4zB6dbwvAeA=;
 b=Dg2ntqAHOoTHqT1Df7p4nPviLTxa+NZ9lDtYAfWBxlfrUt9C4pgWQKoN93eyXVpoRNOxSjZDH8bg52W4cALZ4z2eWPH99PfTsKmkmkHDZyS/04ZcP3d6J+GIpZVrzhsN58pMLiBYl1dqjuXWlt80xTpWbhxEuDfnyFkgCO8QaGM=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY1PR01MB1771.jpnprd01.prod.outlook.com (2603:1096:403:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 03:04:28 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 03:04:28 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v1 07/11] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
Thread-Index: AQHXxCIyeGEEgfVIwkWBOyoT3TlYWavlYVMAgADVIYA=
Date: Wed, 27 Oct 2021 03:04:27 +0000
Message-ID: <6178C1BF.8030101@fujitsu.com>
References: <1634562888-5987-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634562888-5987-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YXgO9rqcXS5dh1us@yuki>
In-Reply-To: <YXgO9rqcXS5dh1us@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66268399-8235-4caa-a9e1-08d998f67d3f
x-ms-traffictypediagnostic: TY1PR01MB1771:
x-microsoft-antispam-prvs: <TY1PR01MB177165EF63CDF69EF5AAB1D8FD859@TY1PR01MB1771.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CoAWXJt29mJ+mp57t9Vsof0UDgB6WUTKabvVY6Hf1teJgYvWw12f6JJ0WSiplOLtcT7joABSasoqYkYB7xPdOde1PTnQgP+6nZgGQCol4K/z0y6ZFl+S7PRiQlmUdr34p4j9wITGQvQCqWIFEx5PgMYs560bpp49DNGmvUzzBhe/sEWbQUhEUmuoYp5wnPkxHzoZDucpJ/wF/d+IDDum2Fed39j5v+D8S4tbfNZVkdMNtmYg8L2iN1Gt5kcWjEoTM5BtxbJo2gPGlOEyo8o8p62WHetiDdYTvH2lWNLDbZZTiQwZnNkRc52WKqpMw6LMXa7A8dCMk9S4IAHMnz/zPNZhdqP+q8sxQBQL+d5QHMvPr492tKmpQuo1mMqrJmHcKFJGSpMIFS7og0V1qJ8O/bkvWFuiKA/KWWhEignNRhT7d7HZbgrM3hSTYVfjGB7qxo97bTifvIEIC7hoPk18V2Rwysg09BUwkdtg5J9PodRb5aGKPbOJDcSF9o+6cmcak4LlPJMFZk0addmcUHdCd2pN/j4jh1E6uwHq9eCAq7hCEiBo38/WmCLvEys3UWKYD8s/HJr8izXWadxLn9g8h3LRwCuNPl1PMwMHitLk1Tbepxl/tPd19Ko36OZUNtFEqnAD6oKPpnoOsK27WLN6A5DZdPDIeaBUa5SwC9cb+q6EHJhSOKKb4COVEPSNyVVFHWhmpyw+feE8PM1Y6LiRz320kIoZNLhivtn7XMd4YukNgwiHUYooT8JncnMBmH1lSyGOCQAYcQ4IPbUglW7Da6JwnmUh35fFn02YWuG51+o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(15650500001)(6486002)(38070700005)(8676002)(5660300002)(6916009)(91956017)(122000001)(2616005)(82960400001)(6512007)(186003)(87266011)(86362001)(26005)(36756003)(38100700002)(66476007)(85182001)(6506007)(66946007)(4326008)(71200400001)(8936002)(66556008)(64756008)(508600001)(316002)(76116006)(66446008)(33656002)(83380400001)(966005)(30864003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RDhlY1N5dXg3dXJocXc5N1RnQWJtNnJNVDFKYWwwOFBsNHFHa1lpL1hGeWtl?=
 =?gb2312?B?UVI0UHJZd3B6WjlIRVhSSHl5OStkd0tsRk5RdUlyekkwSTAzM3RZMHNMd08v?=
 =?gb2312?B?NXI5UWM5ZzZqK0J4ZTlVNDJzZTNmdU1GV053RWdoOVJydWx4S3hWVG1qbXY0?=
 =?gb2312?B?T2RJRWo4YmFhT3kzR0pmS2d4NmVEZS9aTnRKb0dXWklueVRlcUpQNmYxMWVL?=
 =?gb2312?B?c2ZHcnhab29qZUxMVHprWlVTWUZ5ZE9nUDc1Q0pMczJCREtQOWtoYmVNR3Fj?=
 =?gb2312?B?TXV2SzBKdFpzWnF1VEVHMnVyNGl4U3VYWkZiRSt4NGFIMXVqTUF3Z2hFckJL?=
 =?gb2312?B?V2tkT210cGpuRE5IL1NMZnBwcU81Uzl2V0NFUG1SVGlaMG0xOHFDMU5USU5p?=
 =?gb2312?B?L2t5Y2tlYnVHczRvOGEyMjV2cVp4R2gvblBiejcxNVJZRnRTRU9KcGh0ZUJV?=
 =?gb2312?B?bE8zNW1wWXplL0VUaWl5MnFXdnpBNzB0RlBKNHVTN1BmeVBaV2c4NnZRQkk2?=
 =?gb2312?B?R1J3NXdudGNkRElXTERGbDNjM0dnRnJrVzBCUG9NNktXWjlWcEdmbXlabFJU?=
 =?gb2312?B?U3ZMRjF0ZzBUNUFidk80bGc0elZTUlFyTXRreHZpMlJqQlpnRkxqUXNJTzdw?=
 =?gb2312?B?VjBGVlFCZ0M4dUl1VTltZHFlMmp4ZmQ0WVlKNHdEeEVxTTFndzNjSHEyQktK?=
 =?gb2312?B?Q3B0bGtkKzlFQm11U1FNOU9uUU1sU1hrVWhnK0N5MlltcEg2bk80WEYxZHdX?=
 =?gb2312?B?RERQV29CMzArd2dCckZYWnhIQnF4Znp3WGtoeXJUV25EYnhmeks1T2RBaG1T?=
 =?gb2312?B?TlRZajczMmd3Q1JuamtIZE0ycXdGMnZoZ1JXcGR3NU12TWpFUUJlc1kzUW9K?=
 =?gb2312?B?YW91WllUdVZOeE9TdFBBdGxhcFo1UmJ2NVM0ZXE4c2ZYV2Vwbncra1ptMVl5?=
 =?gb2312?B?Y1Q0ZWljZEdtWjJIcjZ6WThOV2FicGxHK0lDdmc3Q3pUcS9WZXZHTXQrOFBK?=
 =?gb2312?B?OXpmZEplQWw0VTdFV00ybkVSdmtKcFJIZW1vcXFwTU9PcTZYbmNqbDFPYnk0?=
 =?gb2312?B?VGdZYXRnWC8zMkxUcTcvcHp1K0x0ODFnUFZLOE9GNkUyU1NxNGlWK2ROdkVw?=
 =?gb2312?B?emRIV1EyaDcrNW5uNG9JMG9qSzYvK1BXeXIvOWZOU2k3dHM5Wmx3TjZsOFZx?=
 =?gb2312?B?YTBydVYxS25NSlFEejNwUVB6cEU1SEVVNkNFdlptODFPMXE4SjZFRTRBUytQ?=
 =?gb2312?B?MGtHbktQeXZ5SEJsRFREbU9VdFl5UjdUQUd2NVI0ODVHT0NnTFdXWU4zRTZw?=
 =?gb2312?B?N0J6OFVmKzY2bjNUMzRTQ0lPMUJPWDRmMXk1MzVmOTdiL3VRRGRtSVJ1amZz?=
 =?gb2312?B?VFhFd1p0WHQybWZzYkxGazd6cFY1Z3dTN2U4ZUEzczNhd09sUlpWUE02T1ky?=
 =?gb2312?B?czV1dENRVHpxWEFnTlZtM21oUXM3Mmg3RGs1KzdzMmkxUnovK3MvMERNMGEz?=
 =?gb2312?B?em5ZS0V1MFRPd3NsMnE1dXg3emh0eklNbldJZUxwSVRQKzdqUmU0aEIwMEJC?=
 =?gb2312?B?a1VnYXQyME93YzVhVFNFaFZieG42cVUzK2tQOW9BdHlzSnBHNi95UE9YQWRQ?=
 =?gb2312?B?UE53V3NOZ0ZZY2Q3NlJEY25YbkhJNzhxdTJjSm9OZC9URDBzbytYaVBiTG9t?=
 =?gb2312?B?T0UvL1VtdjRhTGpJUkpHendwcHZrK1pncVhQdSt1UFhUN1lhRnBwVFg3U2xl?=
 =?gb2312?B?enlaZmtyUUl0UjgvOWFCalV0eTV5YVMreEFVM2xyVWI4MDlSVFhINHVzV21z?=
 =?gb2312?B?dU13TWNKMlZxcnJsNzNpT0ZoNWl1eU5ObDB3MmpXK3M1cDlIdU5FdVhWQ3Ju?=
 =?gb2312?B?WXY1eXJ6ejV5SXpoWHRENnE2d1lmZHBTZGt2a0l4ZjZJMHdnSGdzdTNWZXFu?=
 =?gb2312?B?T0p0YlpMcFgzTWoyNm9zeWNyUWEyUzVFbkJuK09UdGtSYWREMDFXWjY5U1NW?=
 =?gb2312?B?cHZIb01TZmxUTHVYdUVRZVQ0WjNOTjZzekgyZzRMRG9BMThrNDcxK0dFNmRY?=
 =?gb2312?B?bUZCZ3hVZ1BuWVFXaVJPbUk3bU9BcHJzMTFkSzBKbEliSXUyOWEvbFMwT1Zv?=
 =?gb2312?B?UkdNVUJLZ0dMY2pFNXpJK3lYU29zS2hqR01QckYyV2ZVdGEvYnNiRFMvZVdV?=
 =?gb2312?B?aUZqdllZR3Y2N3J3VXlQSWFFekZCUFk0OU9mYitwME9CcnhLN000TFl2c0xR?=
 =?gb2312?Q?wo98tYYI8zvJIA2c6ZMSTPf0vCGnKHUDrJr0Kx44ig=3D?=
Content-ID: <A035D8001FD473489B267D99867632F7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66268399-8235-4caa-a9e1-08d998f67d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 03:04:27.8972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wa/oa5Gr8xHZDso7QBOrzGufhVdDAdi+jogrCxqMBSgmL3IEqwQNfli/GzXwTFG6FvBwQqqFc/gowKH1fvC3NzJ2RqJ/smb1bGnIzpQj+Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1771
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 07/11] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
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
> On Mon, Oct 18, 2021 at 09:14:44PM +0800, Yang Xu wrote:
>> It uses two variants(quotactl and quotactl_fd). The difference for quotactl01
>> is that we don't use quotacheck command and quota info hidden in filesystem.
>>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   runtest/syscalls                              |   1 +
>>   testcases/kernel/syscalls/quotactl/.gitignore |   1 +
>>   .../kernel/syscalls/quotactl/quotactl08.c     | 246 ++++++++++++++++++
>>   .../kernel/syscalls/quotactl/quotactl_var.h   |  29 +++
>>   4 files changed, 277 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/quotactl/quotactl08.c
>>   create mode 100644 testcases/kernel/syscalls/quotactl/quotactl_var.h
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index b19316805..cdeb3e142 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1073,6 +1073,7 @@ quotactl04 quotactl04
>>   quotactl05 quotactl05
>>   quotactl06 quotactl06
>>   quotactl07 quotactl07
>> +quotactl08 quotactl08
>>
>>   read01 read01
>>   read02 read02
>> diff --git a/testcases/kernel/syscalls/quotactl/.gitignore b/testcases/kernel/syscalls/quotactl/.gitignore
>> index 8d2ef94d9..dab9b3420 100644
>> --- a/testcases/kernel/syscalls/quotactl/.gitignore
>> +++ b/testcases/kernel/syscalls/quotactl/.gitignore
>> @@ -5,3 +5,4 @@
>>   /quotactl05
>>   /quotactl06
>>   /quotactl07
>> +/quotactl08
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
>> new file mode 100644
>> index 000000000..554a204b1
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
>> @@ -0,0 +1,246 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved
>> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + * This testcase checks the basic flag of quotactl(2) for non-XFS filesystems
>> + * without visible quota files(quota information is stored in hidden system inodes):
>> + *
>> + * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for user.
>> + *
>> + * 2 quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
>> + *    for user.
>> + *
>> + * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
>> + *    for user.
>> + *
>> + * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
>> + *    flag for user.
>> + *
>> + * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
>> + *    flag for user.
>> + *
>> + * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for user.
>> + *
>> + * 7) quotactl(2) succeeds to update quota usages with Q_SYNC flag for user.
>> + *
>> + * 8) quotactl(2) succeeds to get disk quota limit greater than or equal to
>> + *    ID with Q_GETNEXTQUOTA flag for user.
>> + *
>> + * 9) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for user.
>> + *
>> + * 10) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for group.
>> + *
>> + * 11) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
>> + *     for group.
>> + *
>> + * 12) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
>> + *     for group.
>> + *
>> + * 13) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
>> + *     flag for group.
>> + *
>> + * 14) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
>> + *     flag for group.
>> + *
>> + * 15) quotactl(2) succeeds to get quota format with Q_GETFMT flag for group.
>> + *
>> + * 16) quotactl(2) succeeds to update quota usages with Q_SYNC flag for group.
>> + *
>> + * 17) quotactl(2) succeeds to get disk quota limit greater than or equal to
>> + *     ID with Q_GETNEXTQUOTA flag for group.
>> + *
>> + * 18) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for group.
>> + */
>
> The same comments apply for this comment as well.
Ok.
>
>> +#include "config.h"
>
> The config.h should ideally be included in the lapi/quotactl.h instead.
Will move.
>
>> +#include<errno.h>
>> +#include<string.h>
>> +#include<unistd.h>
>> +#include<stdio.h>
>> +#include "tst_test.h"
>> +#include "lapi/quotactl.h"
>
> And this is included in the quotactl_var.h so no need to include it here
> as well.
OK.
>
>> +#include "quotactl_var.h"
>> +
>> +#define MNTPOINT	"mntpoint"
>> +#define TESTFILE	MNTPOINT "/testfile"
>> +
>> +static int32_t fmt_id = QFMT_VFS_V1;
>> +static int test_id, fd = -1;
>> +static struct dqblk set_dq = {
>> +	.dqb_bsoftlimit = 100,
>> +	.dqb_valid = QIF_BLIMITS
>> +};
>> +static struct dqblk res_dq;
>> +
>> +static struct dqinfo set_qf = {
>> +	.dqi_bgrace = 80,
>> +	.dqi_valid = IIF_BGRACE
>> +};
>> +static struct dqinfo res_qf;
>> +static int32_t fmt_buf;
>> +static int getnextquota_nsup;
>> +
>> +static struct if_nextdqblk res_ndq;
>> +
>> +static struct tcase {
>> +	int cmd;
>> +	int *id;
>> +	void *addr;
>> +	void *set_data;
>> +	void *res_data;
>> +	int sz;
>> +	char *des;
>> +	char *tname;
>> +} tcases[] = {
>> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, NULL,
>> +	NULL, NULL, 0, "turn on quota for user",
>> +	"QCMD(Q_QUOTAON, USRQUOTA)"},
>> +
>> +	{QCMD(Q_SETQUOTA, USRQUOTA),&test_id,&set_dq,
>> +	NULL, NULL, 0, "set disk quota limit for user",
>> +	"QCMD(Q_SETQUOTA, USRQUOTA)"},
>> +
>> +	{QCMD(Q_GETQUOTA, USRQUOTA),&test_id,&res_dq,
>> +	&set_dq.dqb_bsoftlimit,&res_dq.dqb_bsoftlimit,
>> +	sizeof(res_dq.dqb_bsoftlimit), "get disk quota limit for user",
>> +	"QCMD(Q_GETQUOTA, USRQUOTA)"},
>> +
>> +	{QCMD(Q_SETINFO, USRQUOTA),&test_id,&set_qf,
>> +	NULL, NULL, 0, "set information about quotafile for user",
>> +	"QCMD(Q_SETINFO, USRQUOTA)"},
>> +
>> +	{QCMD(Q_GETINFO, USRQUOTA),&test_id,&res_qf,
>> +	&set_qf.dqi_bgrace,&res_qf.dqi_bgrace, sizeof(res_qf.dqi_bgrace),
>> +	"get information about quotafile for user",
>> +	"QCMD(Q_GETINFO, USRQUOTA)"},
>> +
>> +	{QCMD(Q_GETFMT, USRQUOTA),&test_id,&fmt_buf,
>> +	&fmt_id,&fmt_buf, sizeof(fmt_buf),
>> +	"get quota format for user",
>> +	"QCMD(Q_GETFMT, USRQUOTA)"},
>> +
>> +	{QCMD(Q_SYNC, USRQUOTA),&test_id,&res_dq,
>> +	NULL, NULL, 0, "update quota usages for user",
>> +	"QCMD(Q_SYNC, USRQUOTA)"},
>> +
>> +	{QCMD(Q_GETNEXTQUOTA, USRQUOTA),&test_id,&res_ndq,
>> +	&test_id,&res_ndq.dqb_id, sizeof(res_ndq.dqb_id),
>> +	"get next disk quota limit for user",
>> +	"QCMD(Q_GETNEXTQUOTA, USRQUOTA)"},
>> +
>> +	{QCMD(Q_QUOTAOFF, USRQUOTA),&test_id, NULL,
>> +	NULL, NULL, 0, "turn off quota for user",
>> +	"QCMD(Q_QUOTAOFF, USRQUOTA)"},
>> +
>> +	{QCMD(Q_QUOTAON, GRPQUOTA),&fmt_id, NULL,
>> +	NULL, NULL, 0, "turn on quota for group",
>> +	"QCMD(Q_QUOTAON, GRPQUOTA)"},
>> +
>> +	{QCMD(Q_SETQUOTA, GRPQUOTA),&test_id,&set_dq,
>> +	NULL, NULL, 0, "set disk quota limit for group",
>> +	"QCMD(Q_SETQUOTA, GRPQUOTA)"},
>> +
>> +	{QCMD(Q_GETQUOTA, GRPQUOTA),&test_id,&res_dq,&set_dq.dqb_bsoftlimit,
>> +	&res_dq.dqb_bsoftlimit, sizeof(res_dq.dqb_bsoftlimit),
>> +	"set disk quota limit for group",
>> +	"QCMD(Q_GETQUOTA, GRPQUOTA)"},
>> +
>> +	{QCMD(Q_SETINFO, GRPQUOTA),&test_id,&set_qf,
>> +	NULL, NULL, 0, "set information about quotafile for group",
>> +	"QCMD(Q_SETINFO, GRPQUOTA)"},
>> +
>> +	{QCMD(Q_GETINFO, GRPQUOTA),&test_id,&res_qf,&set_qf.dqi_bgrace,
>> +	&res_qf.dqi_bgrace, sizeof(res_qf.dqi_bgrace),
>> +	"get information about quotafile for group",
>> +	"QCMD(Q_GETINFO, GRPQUOTA)"},
>> +
>> +	{QCMD(Q_GETFMT, GRPQUOTA),&test_id,&fmt_buf,
>> +	&fmt_id,&fmt_buf, sizeof(fmt_buf), "get quota format for group",
>> +	"QCMD(Q_GETFMT, GRPQUOTA)"},
>> +
>> +	{QCMD(Q_SYNC, GRPQUOTA),&test_id,&res_dq,
>> +	NULL, NULL, 0, "update quota usages for group",
>> +	"QCMD(Q_SYNC, GRPQUOTA)"},
>> +
>> +	{QCMD(Q_GETNEXTQUOTA, GRPQUOTA),&test_id,&res_ndq,
>> +	&test_id,&res_ndq.dqb_id, sizeof(res_ndq.dqb_id),
>> +	"get next disk quota limit for group",
>> +	"QCMD(Q_GETNEXTQUOTA, GRPQUOTA)"},
>> +
>> +	{QCMD(Q_QUOTAOFF, GRPQUOTA),&test_id, NULL,
>> +	NULL, NULL, 0, "turn off quota for group",
>> +	"QCMD(Q_QUOTAOFF, GRPQUOTA)"},
>> +};
>> +
>> +static void setup(void)
>> +{
>> +	quotactl_info();
>> +
>> +	test_id = geteuid();
>
> The test has .needs_root flag set, so as far as I can tell this will
> always return 0, or do I miss something?
Will remove.
>
>> +	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0666);	
>                                                           ^
> 							 Trailing
> 							 whitespace
OK.
>> +	//tst_require_quota_support(tst_device->dev, fmt_id, NULL);
>
> Why do we have this here?

Will remove comment.

Best Regards
Yang Xu
>
>> +	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
>> +		test_id, (void *)&res_ndq));
>> +	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
>> +		getnextquota_nsup = 1;
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (fd>  -1)
>> +		SAFE_CLOSE(fd);
>> +}
>> +
>> +static void verify_quota(unsigned int n)
>> +{
>> +	struct tcase *tc =&tcases[n];
>> +
>> +	res_dq.dqb_bsoftlimit = 0;
>> +	res_qf.dqi_igrace = 0;
>> +	fmt_buf = 0;
>> +	res_ndq.dqb_id = -1;
>> +
>> +	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
>> +	if ((tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA) ||
>> +		tc->cmd == QCMD(Q_GETNEXTQUOTA, GRPQUOTA))&&
>> +		getnextquota_nsup) {
>> +		tst_res(TCONF, "current system doesn't support this cmd");
>> +		return;
>> +	}
>> +	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
>> +	if (TST_RET == -1) {
>> +		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
>> +		return;
>> +	}
>> +
>> +	if (memcmp(tc->res_data, tc->set_data, tc->sz)) {
>> +		tst_res(TFAIL, "quotactl failed to %s", tc->des);
>> +		tst_res_hexd(TINFO, tc->res_data, tc->sz, "retval:   ");
>> +		tst_res_hexd(TINFO, tc->set_data, tc->sz, "expected: ");
>> +		return;
>> +	}
>> +
>> +	tst_res(TPASS, "quotactl succeeded to %s", tc->des);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.needs_root = 1,
>> +	.needs_kconfigs = (const char *[]) {
>> +		"CONFIG_QFMT_V2",
>> +		NULL
>> +	},
>> +	.test = verify_quota,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.mount_device = 1,
>> +	.dev_fs_type = "ext4",
>> +	.dev_fs_opts = (const char *const []){"-O", "quota", NULL},
>> +	.mntpoint = MNTPOINT,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_variants = 2,
>> +};
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl_var.h b/testcases/kernel/syscalls/quotactl/quotactl_var.h
>> new file mode 100644
>> index 000000000..27d57294c
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl_var.h
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +#ifndef LTP_QUOTACTL_VAR_H
>> +#define LTP_QUOTACTL_VAR_H
>> +
>> +#include "lapi/quotactl.h"
>> +
>> +#define TEST_VARIANTS 2
>> +
>> +static int do_quotactl(int fd, int cmd, const char *special, int id, caddr_t addr)
>> +{
>> +	if (tst_variant == 0)
>> +		return quotactl(cmd, special, id, addr);
>> +	return quotactl_fd(fd, cmd, id, addr);
>> +}
>> +
>> +static void quotactl_info(void)
>> +{
>> +	if (tst_variant == 0)
>> +		tst_res(TINFO, "Test quotactl()");
>> +	else
>> +		tst_res(TINFO, "Test quotactl_fd()");
>> +}
>> +#endif /* LTP_QUOTACTL_VAR_H */
>> --
>> 2.23.0
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
