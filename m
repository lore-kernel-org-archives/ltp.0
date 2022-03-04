Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C257DC433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 11:00:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C8553CA36E
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 12:00:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 092D03CA2BC
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 12:00:40 +0100 (CET)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 33AEC1400077
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 12:00:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646391640; x=1677927640;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vJouKoNu5ERNhjryj1i5pBnxD1HHgninIcCGo4ypeEE=;
 b=b/YgN+3B1nCCPVX4FAlCVjmidPF/pQ2mLJ4M9o8jx+Aho/j+meLM2pcD
 nxZqU8mNYuI+IoDrYxx1icueo8aH4oH6TYxC7tT12mHmTaD5nZDaiaRR2
 vT1i1H3gSGiHGmOLDzAzRQMgY3mfU6WXJxSnc5O2Og0Jd2IOfjYge6b41
 rkWvo1U7HF8m6c2/ky2NKKET7DO1g6qvQ6jV3sYHD81fON1II1rXjv9fA
 9gAIOltvZgFGvkYzCCppgicX4uKrAkdbouVV5henZhMx+ormLDBOYrIJT
 8xcAiTJLiuACq7lsU08M9TLhBtVR/VuykwToxhPqV+5KPiYKJOltb1Q/K g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="51342909"
X-IronPort-AV: E=Sophos;i="5.90,154,1643641200"; d="scan'208";a="51342909"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 20:00:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c61rJtyijeST7mofnlA+2TQbQ6RrtzSs89d7sTGpH5X9g7Cnd5peZ/tKdFjJBK1ON3WvMdHBIipw2iut+vSwol3cO0hKKTyUn6mahPGhxVNrPhGIAAzDPCXksWDgZUmoOtMkOJRAqt/LUBDkbafJ75eYjQQLTxOzl9Gq1+m6N+cOhYhkrrt82AAlNBiCehbjrC+DzbX++G5MOl6pp76hsiIzlyUX4bkyapZeSndmisMuS0KI/XywpABq3hrv8juk34vXMPh9Bd0Eh9YwPo/8X0sWdUSabFZKkBremeo3pQuDoVa7tBFDEODeoub6HYm3bnj6MRuxIihChxorpoP5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJouKoNu5ERNhjryj1i5pBnxD1HHgninIcCGo4ypeEE=;
 b=kwWYUZPVuZ1xmjXun90sUsDEHPDN0u/2bR++NXWvVSSP3fEzVOpQo7Zl4vC94as0vo8J0UA4ZflL67F22L4WpNdbyoR7k7xodEI4q0Dc7VQnvXf6njDXIB/pGEiga3QschUco3/yVrU9N1czNKu7vhSbqHGCiVhBo3qvqLjC7JtZnHTOnlyWaMwRUNqdVeaj3mCXZMpdd+ryJ0qPCc4LvFDG7jXpDyxAxOaJHKhRQ6Mf0rnlLaZInfoXydSbd9ErpuyJaTm6zw90WzRM4MBcEi/UfhFD0QRXQhMsWDYr0ps0VXae0Ya/YDtBEBtFsZ0cPzRbXwFMBI4cvdoZ+ldPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJouKoNu5ERNhjryj1i5pBnxD1HHgninIcCGo4ypeEE=;
 b=Ko3Qq82mgOSwHoKKbaKcFDNTVO/JCVJVmnn8QFoojiNENCAVuPhlNPVdbVIB8zuIezYyLwTUofTVcy2g7Rw2cYDKGrNNxvQWQp1aKFpWrGQw639d+RciZGr0gCoxPo53mJfhXIpv5hQxu7IOrH7oYJw8gaOLAG6zNArbP8udqYw=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB5935.jpnprd01.prod.outlook.com (2603:1096:400:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 11:00:35 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 11:00:34 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [PATCH v2] quotactl06: Fix tmpdir cleanup if setup() exits early
Thread-Index: AQHYL7WvBjX6PCVdhEOs617mForjkKyvDuYA
Date: Fri, 4 Mar 2022 11:00:34 +0000
Message-ID: <6221F178.2020404@fujitsu.com>
References: <20220304105034.22083-1-mdoucha@suse.cz>
In-Reply-To: <20220304105034.22083-1-mdoucha@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 757fc043-5814-4b08-623d-08d9fdce353b
x-ms-traffictypediagnostic: TYCPR01MB5935:EE_
x-microsoft-antispam-prvs: <TYCPR01MB593514067EC52009BE5C842EFD059@TYCPR01MB5935.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1MGUyVg7XpgfFAUwSVI3hDb8dgZEd4U43z8OUSKQzepnH0gSUFCHdOwbHsAu4k59XIzKxgCWocPMbL/8Ipu6Nm8xpUY1FDRqRxpktz6rAys2pWzFj7vfetGMPdZrCRzWwUWLjLRFl81LRRMUHR/16MVOQoEcmGZAb9uSwl/x6S2l7ixotdAZutgPItUvkevbNQjHB0BhDGann6Tkp8qPk7yRmYnL4b1gaL7CJpIO0raiwx18TOP3yE0Le87CZ/asjRzuM55/mfNYRGeGrJ2UUf+5JV0LVbWUbzNv+hYmGFLwXdI8Eld+YwdM8huqN5KZ5nl3wk2X16gGVOBoDvDGbFj48LsCqVeZT8weIXT3bQM+8qDA0yQDe+TvqHU2m+Hdk5XCWL+JPhGIXcG5smbZdV2lOlNw9j+y/YYi65SQO6KGGimn/uGQSsP5uQlyDVDMcxb8rlybUjqmazdookYtg0I22saOLQZfMcR/7HbjAaMIzOQAAMtl5lKw3Hx1NW4HY3DwoeiheOzUX69VgbFDuCwb3eklCeuZPpDCVExtgShhalOtZguJ37abi1M1z+p6JRBcVPBrD9DDDJ7aOEtPGA14qoix1j7HPD4JptCXG0sXhfgbDyYKqPuJxs7hDmTgpQyKdq7ZRuT4Sk0JGVuuitIvsceviBaqceQ7rsnW9WrmqsYXpVL8PEY2fKSvYubMwYLhIldTIhUEyxeEBxhjMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66476007)(316002)(15650500001)(26005)(186003)(33656002)(6916009)(64756008)(66446008)(4326008)(91956017)(66556008)(8676002)(76116006)(83380400001)(508600001)(86362001)(38070700005)(2906002)(122000001)(5660300002)(71200400001)(38100700002)(6486002)(8936002)(82960400001)(36756003)(6506007)(87266011)(6512007)(2616005)(85182001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eVpWc0UzZ0ZpMmlKMmJwa090WlFQcGx3VVI2R3dES3ozd3RwNGhjc1RoUTV3?=
 =?gb2312?B?T3R6cFVDSDNmN0gyUW81Ri9IUEs0RjlOb3cydU1QOElCOE5ITktoM3p6bTBZ?=
 =?gb2312?B?Z1FRV3BqVThaSGJXV09ReE42dmFLN1hZSmtsNXZzbTQyRjQ4ZXp1V2xySmdv?=
 =?gb2312?B?bjFuSDdscEg1ZWRVVGk2MHI2SVg2c0NyNHdkSzV5VWN5SlRJRnF1Wi9qKzRi?=
 =?gb2312?B?NEhSYmYzSkdDVGR0YlVsTWdEcUVkSUF3bGdmTEFnL1BnTmZZakFkY005VFIz?=
 =?gb2312?B?MVBvQzhNL3NxbEJOQkprcXhhS21OOXphMExyY0xmY1RENmo3WDRsWFJwdmJn?=
 =?gb2312?B?eXcyQ2tOUWxaeTdwbUVucmJGZnVEU1FBV3ZNU0hVdHVMM25aMG9mN0JuL2h0?=
 =?gb2312?B?cVVHdHB2UzdOU1phRTVCMTQrRXY5cnZOQzd0c0MweEpuWDN4bFZDN3dRSXRM?=
 =?gb2312?B?NEVhYzFLKzN4WFo1VnVMWEFzeFhBdVFGNVZPM3NZZ3FKYnBKOUozZHgyRi9n?=
 =?gb2312?B?RDMrQW5saGFPdkpialRVQkthQjhuK2cxVk85WjIrWGY2K2NKamdXaGpKYmVT?=
 =?gb2312?B?OTFwRUtZckQxTk15TUM0ZFkwN2xhUWY4M3B2YjN6aWpmczU3eHV4RDBFazdS?=
 =?gb2312?B?VFNrSjA0bkdpd1RuVTUzcnkzaWI5aUhpTUM3VFB3cFhFQm42dGNwUDVVNUhG?=
 =?gb2312?B?aVZNSTVXcVEwem5MZEwwWVE3OXoyVWVvSElBU0ZsUCsxdTZSSVZ0WEprVHhE?=
 =?gb2312?B?c20vNklKYUd2K1N5UnNNdTQ2MDVoVW1idlpwek5McEJudjBNcTM1YUZkcG1M?=
 =?gb2312?B?RzdQc0VlemNwT29rb2dxTHlBRWdPRXErQmRLYVdmQURxQ2tEb1FVcjlDVWlL?=
 =?gb2312?B?MjZSY3dNK0p5ajMwM0ZGdVd4dkxtQkNEQzZTUmJKUm4yYlhMbjhLLzdrQ1pj?=
 =?gb2312?B?S3NkWDVXTE9jN3hSZnFycHdpb0VqeU5BWnhLMmVzZ0VtN2p4enU5THU2Nzhj?=
 =?gb2312?B?VyszVmpsWTBhdjFBTTA4L3JSVjJIRDhLRnB2UWh6Yk9yR0Z0dUJSZ1Zhblpm?=
 =?gb2312?B?TXFoVktXRHd5TVp4RnVrU0pjMnQ4TEZvOWx3M2tQOHdTWXk3ZXZlTGRXcE0x?=
 =?gb2312?B?NGpnbHBWdGNUaitPUC9pSENsWHd0RkFGNnRkUnJMUnMzbGlCK0c5clJDeDEv?=
 =?gb2312?B?eXQ4QXlyL0ZVN25URVFXNUlqN1hmTDg4NXpnSzFBVVVNRG4yTnBQNStQODA3?=
 =?gb2312?B?Ui84MWR3azNHOGFCYlBVU3hscW9MS1lTbXlTdndSQVdjU1NnTUdUaVowZTFI?=
 =?gb2312?B?QmQxN1RTcWRjYW1YYmRoN2theEV6eC83WXR6NHFscHBSSC82b2Q1UW1QWXgz?=
 =?gb2312?B?QnZiblllOWJLM0JiZUN3SFZXSWg2dUhBbjVZR3Z3NUJ5elY2dGlIYWpJMk1a?=
 =?gb2312?B?eHhCeVUxOW11OTVOVHJxa1dkTGZtUm9OSHpvdmNvQ3NldTZxblVjcEJQVE1L?=
 =?gb2312?B?N1FnT2I5bUtYNzZkQUFsRmhVZGovSzdWbFJhUXZwQTdVOVYxMWhBMStaelVa?=
 =?gb2312?B?bEFyWjQzeWFhNUZ1elVCY1duOWh1QTFCbnRYcTg2Z09XYlhsbXJvWkxoT1Bv?=
 =?gb2312?B?Tm1haktsUldVWDZrMDY4NUU1dTIxVUhQNmphcnAvMmVZTUpPSmk1SmZ0aEcr?=
 =?gb2312?B?cEpDN2xMOGRxdkRMVGRDTkFRbm83SEd2bCtQbnU5aGp2UXpveFN0SUFBanVU?=
 =?gb2312?B?S2VDbENCTGs1N04waHlTZm1WZzJiTzl5WGVmVmZYYjd6V0dOUzBpTWUzSE5n?=
 =?gb2312?B?bkkrckZhQjlxU3EwQmFzNkhlU3VKVE5Edkk2MHNMNXF5ZG1RR2lnZGo0T2tI?=
 =?gb2312?B?VldYeFdUN2VXVlkxekFxUkRDQlVsdXJ1UC9MTy9Kb0tuRFo2N0d1MVErZXR5?=
 =?gb2312?B?WHI3UWV0R1pNWW1uWDcvZmNqSHFQNDFIUmQxckc1US85MkgxTHo4TWVCZ2xl?=
 =?gb2312?B?YU13U3Z3RFlLWnk3a0RpVnVnVmZuN0ZjY2dQV2JGcncrZU1raGtNLzdpWGlh?=
 =?gb2312?B?RjBYOGF6YlVkaUhPWHJ6K3d1YnpTMExTQkNDZVVpRThad0NRMXhVNGp5Ymxz?=
 =?gb2312?B?NzBnUk5la0JxWXRLNmZRSUxwOFI4TGhKVW9wZ3NpdDdLUDA3TS95YVdTQnRD?=
 =?gb2312?B?OG9xenVZUmRSMDNkT1hqeXhTWWJZYjJkT1ZiUUVKdWFzRVN2ZzRaVkZNcE42?=
 =?gb2312?Q?1BPIeCjk5rMsxqAV1qkofWG6MaHsjkA7TcxdRky57E=3D?=
Content-ID: <C7B3F3AC5858CB4CBDE985D59FD339E6@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757fc043-5814-4b08-623d-08d9fdce353b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 11:00:34.6404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNvQM0qFMUe9ojzJOU9p9ANdB7CHp8B88Z+8rnBiGbVoNJDvSaszR3jFk5NuN/jd5HtfvUFB7FXawF8q0QQPOpwg1g9Oz4WR5/+TBk/MHHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5935
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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

Looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
> When setup() exits with TCONF before USRPATH or TESTDIR1 get created,
> cleanup() will trigger TWARN when it tries to delete them. Check whether
> the file and directory exists before removing them.
> 
> Signed-off-by: Martin Doucha<mdoucha@suse.cz>
> ---
> 
> Changes since v1:
> - Also check whether USRPATH exists before deleting it
> 
>   testcases/kernel/syscalls/quotactl/quotactl06.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
> index 8e9a17393..87715237f 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
> @@ -206,8 +206,11 @@ static void setup(void)
> 
>   static void cleanup(void)
>   {
> -	SAFE_UNLINK(USRPATH);
> -	SAFE_RMDIR(TESTDIR1);
> +	if (!access(USRPATH, F_OK))
> +		SAFE_UNLINK(USRPATH);
> +
> +	if (!access(TESTDIR1, F_OK))
> +		SAFE_RMDIR(TESTDIR1);
>   }
> 
>   static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
