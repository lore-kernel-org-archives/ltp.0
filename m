Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B304AC32772
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 09:56:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A62EE3CA1EF
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 11:55:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A9533C95ED
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:55:46 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 83157680E48
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:55:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1661248544; x=1692784544;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Xbyye28g6FdYMKO63Pn/1uOutzrw7fzXpx1o7Bu2JQg=;
 b=RmQABulaqGX+DZQ4BDMRGeGLa6mjuHqxwDYXkRAGOtV1Dj1QMxBvNJ0s
 GzPhZeWBmKPJ+Mdr+vT3AGxr7EHGB/FVjAVdESMrIvP5/FiAOtIX2qGdL
 Jz+bjVDHmjrjjsqnaSxRfY82qZoYBDZx+EaSYKPamBgBMYZ4wb/XVZl3q
 AsZDeaY0d45rdM0Uy213uSwNl/5Ghf0R7i2dGpCRVWoY8Cs/2gpzhgEl6
 /liI2L4T7PAm9KlqWwUbFH06siPvmUI1yR2Hcitzs6LVU2liUbH43yhEk
 qU+xvivPvpLwuFT3hcHrYSjMbPw2OcLqzVwKcVFYm8+R4sUeWN2wXEW1v Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="63382590"
X-IronPort-AV: E=Sophos;i="5.93,257,1654527600"; d="scan'208";a="63382590"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2022 18:55:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD4aWK4c37M12yBuvClq3ZGLLg863Kih/dfHC27+4YN2f+tKlSU1pKvYf3Jb3z9AjtnwlVGX53SLVcb7LPCFqUS75Hi7T9eKcTcmGQ8q8WzUdLFfPnVVV9aaYU2na9DrGWPFOEcCAIfMK15zf7dwQpR0KB8hnP74BdHsxNLkyuBucKOtFYHk3wmVhc69dnO2JcvVXCNoQeW4GWM/VNj/AYnY/zxjJKJRqfW9wrojnk722umy7WaMm67hFm4JS7hxzitxSvMIstPLxiJohlMPOSWsohovSgp074/9/QzzDJAF7rgyAQiXiX2GIKK8y/IKqoEx4vTwhEXdYw5RYjMsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbyye28g6FdYMKO63Pn/1uOutzrw7fzXpx1o7Bu2JQg=;
 b=cbNTwO2ovnToxfu4Js3TVZu56xw/yV/bZ/HNIPOSYur5nQIFa2Mn9ZBfC5JcTvU3LuigAQiO8TxCW1pxajjqCmqAl/RYw6j+FZ2O4KjDQ1//tlbR+UkaBHaZeB5GUSxFl1v/DPWXl+YUeCvqE+skm+0ruf1Kf3tyUpm7czsVGfvBK08luCFh8lZcbFkbmGjYmiryoeVWUEHE9ZQm7CwspNapgbqVbqPvB9r4hQesy4aI1rQ58l8smjKkgml40c+ZNVuTQ/Pxud6z4Ghj1ffitxSCXPv5E2/Rrrwgu1+gqA8wyrrVOG8Lc/j536HHSnmrRKEAQBwguVipyzJ55oWIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB4834.jpnprd01.prod.outlook.com (2603:1096:604:6d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 09:55:38 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 09:55:38 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH v1 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
Thread-Index: AQHYpxonL8L7qQ3YBUegaqa46E0RxK2einQAgBKoWYCAABCKAIADMgqA////OICAB80GgIAALjmA
Date: Tue, 23 Aug 2022 09:55:38 +0000
Message-ID: <79b4f07b-95cd-d4c5-d494-7226bcedcb0f@fujitsu.com>
References: <1659521981-2241-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1659521981-2241-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <87zggks3pe.fsf@suse.de> <031f32b2-70fd-8b6d-e2ec-f1d3d1bdcaa5@fujitsu.com>
 <87fshwlh5t.fsf@suse.de> <dd62e1fa-0b53-e45a-83fc-21a7a2105419@fujitsu.com>
 <87edxdkfq8.fsf@suse.de> <9cf50109-5c06-08ee-6de5-36456ad1a757@fujitsu.com>
In-Reply-To: <9cf50109-5c06-08ee-6de5-36456ad1a757@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9f27050-c235-4096-1f6c-08da84eda1f7
x-ms-traffictypediagnostic: OSAPR01MB4834:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qqQB/JaecWVh3O3xqJ7lztDKjU2r+tgd1yqyTtoPDDfVvLW5X8/gVnHaWAt5yrPBLr0k5IBU0/8GIi5LJgG/2DSeQn6TiTgFEw5aoj19JS++ZLQH6DGhMQlUh9AZi91AJBFoZIMZvcJs7mP9+9eTDNlelOuNf8wV1BiLtfqjSVrriVDKsPW3cB8ianvQopbeKifM8gDSHvQW0z6joizfRLD1MQzn1xcB1VRBCEBW+HiLmMy4qoCkr/SImV1o0DKF69lEb6aq0TzASInfPrGX7pjGqbBX7UhPexulcMhnbYLmVEt4mBVX2rzv8u0OJyVgPz3VEJY1Z5I/GImpM2l1RZ0mr+Ko0hdk/j2J/n97/eHp//insa7ZUV4jf1162WEpFJwviUH117qmkgRiWiZkNBMm5qDpG370COzBAIP9j24YpMmmiskajUoJ1ZfHa0O/cwUJCpBQSiTUgsIxHD0feMn4h8h44ljyhTH5z0p85Mynqfy/IgcFCbGdm0xMPV/DDMTRkrSQ1F/RTMhstMet4335Evqzmj834bHmsla2y5ppf/Q+DNKXHL/j+n+46aaWXRdHdNClogcYhdIrmU+qN3m9R4/UT7H8wK01C+yU0an5SrLOxLXlrtt0QVt5d1lUtROwbiPzQMXYRHUARl/mxJw4YZ8i7uQUmUEs3iCnoLuK4nQuGqYAwwzXwJvLioxeacQulk3MusgdSj39U/5AwCLGlMKmWVmbsHyvxPpHvA+O6Y1tpwlE92Ib/H4er3CwTNT+JKzN5wiJ9LzT46MMBJhAo18faUIBJyDqVMBs08bS/OO4JK19zRL9vtiggvuKkuMGyvOD7fviA1kLbqZNdhCfMmIeFEEIJ47tIRAYSBE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(1590799006)(71200400001)(6506007)(6486002)(41300700001)(478600001)(83380400001)(186003)(26005)(6512007)(1580799003)(2906002)(5660300002)(2616005)(8936002)(316002)(6916009)(91956017)(4326008)(66556008)(8676002)(66446008)(64756008)(66946007)(86362001)(38100700002)(122000001)(31696002)(38070700005)(66476007)(31686004)(82960400001)(85182001)(36756003)(76116006)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWc4U3dPeGdkMTB5bXNKSUNFYlRnenVqSlE5eXNHeFRzVHp4ZmM3Q3FXSjV0?=
 =?utf-8?B?YjdnVW1nWkNDdTQ5QUxWTlJmWjlLbDNIOXVUVlUwYXBVZERkMWtaYlBveVEy?=
 =?utf-8?B?V0dITXFNSnBBVFBkaFRzWGZqUGNiMWxpL1RzR285OHFJVHJZU3cxZWljTXJ4?=
 =?utf-8?B?ZFE3am5Dcy9BSjN4K2hQdFFyWXoxa3lpRWlqbWh5UEV0WWtSWmJkQ3ZaM2lv?=
 =?utf-8?B?Z1hqY2pnZDJvaWJZaVVpc3JnNjc1MVp4cHpaRW02WkpVSlJIQ2ZkRnArSWRK?=
 =?utf-8?B?ZTZaZEp3WGtodlNLZittNTE5VTdGOXl3bFZtL0lVQ0M1NTBPSWppQjl5UHhC?=
 =?utf-8?B?czRpUE5WUG0rKy85Vnd2Wk1SUGxNQjd2VzZKeHRmZmxQa3VtS3dyRGM0akpY?=
 =?utf-8?B?KzE5ZzArV0JUMGpYRStFcHZDMUFvbkF5MDF4a3hHZVV0TWtuQW5teVNkVEN0?=
 =?utf-8?B?MWxFYko2YTMzY3VnR2ZDVC9zL1BjQyswSnJIT3ZWb3M0bUErZGlWNGQrTGk0?=
 =?utf-8?B?RENlNEgvU3dWVDM3UTg1Wnp0M0VNVHo3ZG4xY1J6dm9kZnVTaGhId2JLTHRh?=
 =?utf-8?B?RFIzWWR1QkEwbDJDaEVYVE1iMGdJMW8wM2VKUkdkSVo1ZldvMy8zSFh1UGdN?=
 =?utf-8?B?dUg1cmJPTnBWZXppYnhhVDIvTFF0VFJsQXBkNDRLWVVFZ0pwcS9HT3RESGdM?=
 =?utf-8?B?clZzRmw4bVdOR3JXcjFmbTBZalc1YWdxSVdBOTJWWDNqNDBnenpiZ3hqNnE0?=
 =?utf-8?B?akpHbk9rMUdqTVR6cTBCZ25NUWdTMGY3R3VobitEWjB1OVloeDVqdkpSKy9y?=
 =?utf-8?B?VnViRjRmdkF0ZE9FNWJBV3FCWGNPbDJHTE5WSmNSK2tSVFJ3UVYvaTRCTUx5?=
 =?utf-8?B?dGhLUmJ5aG1Nazl3Z2pXS2ZVcm02MlA3N0JJeXFBR2VSQ3lndnM2cVNaNXRD?=
 =?utf-8?B?Y3dHU3c3b0VpYzgxcTBsWisxMHFEUGE4Y1c2U29NZWpzTUZOaTdUa2RlWlpv?=
 =?utf-8?B?T1JBU2JNekMwZTRJK1dMQ0NvaUY1d2o2MFZRYUE5ODZVK1dYM2lPQ25IK01G?=
 =?utf-8?B?ZE0rbWN0MWR3RXhNVDVEd1VuaXFKWlVrWUt4QVk5VENrYTNFNEFjcDUyYkVt?=
 =?utf-8?B?MytHMW94YUcybHF6WXEvLzZUb0tqZW5ISHJ4V25qMU9pSWJ4WDVBcm5BZWtO?=
 =?utf-8?B?NGN6Wk16MXNKcVlFdzJtakQ4cEVVSkFYajVhdkZYRTMyV1pXUTc5eWczSXZL?=
 =?utf-8?B?bjlGMVJmSFVad2VGbFJXaStQa0pGdXBjRTZsZTU2MTJaaFUyWGpDTzlJaUtr?=
 =?utf-8?B?STBVRm5pS3hPbGZXM1lFYU1ZZ1ZaVlhuWHFFSndGNGQyNFl5NUpyaHNDWFh2?=
 =?utf-8?B?cHpUZFNzK0JEb0lDMTdFYzVvMmFPZEZSa2tjU1o0TjhvRm5HNGJMcE84RFEx?=
 =?utf-8?B?UUg1andKYWVMZ1A2dmhIc2NlSW1hK1ZjZ3RrQm0wckF2MWNIWlZ4Wkh5NVo0?=
 =?utf-8?B?N2pQNVhEa3kyRDRSRkhVRjY4eHdjYjJJSFp1L1kyam5FQXM5SzZtbUMvTHNq?=
 =?utf-8?B?NnVVVG1sRGczSy84eUQzUy9yWldRNUV1MndmSU9XclZjaVZCMnlQZWhUS0dk?=
 =?utf-8?B?TWFYVTlpRzBncWVDT2dtUFUySTFqTjEyZ2xPN0ZFRm5zUXp6MEVRRnRXSitP?=
 =?utf-8?B?THU1OXZMS1NyckFzeGtsdDlUWWxqSTRDRkFBOWFmdWxNUE9sN29vUm1tN2da?=
 =?utf-8?B?aHlmem1FMTZsUVBRZkZhait2TS9UcWpvbW9raGNHN2t0V3BJNFZxVEkydTlX?=
 =?utf-8?B?aElWemh4T0Z2V3RSMDF5eGZHc2FmUUxMNk9CcndpcEEwdDVFaEJKaTVIc1RY?=
 =?utf-8?B?VDFEaFVxaWczYVc4Qk9HQXNMQ1FkZENWOFhpYlN1STNma0d1dkwrUUFFM3JR?=
 =?utf-8?B?N2M3aVpUZlBIc1FUUjd0VmIwOHl2WHE4N2x0TTFDM1VDaStWZjV6K2JYMXdq?=
 =?utf-8?B?ZTlRYnpTQ1N6NGNlZkJIYlovVjFDMnZhRC81ODMxbGsyL3JYbWpYZk9JRmt0?=
 =?utf-8?B?czVLRG5RRHJJSXJEVStlTEhVQ1hzT0FIQnptdm4veHdGNGh5V05HdmNUSEg0?=
 =?utf-8?B?dlN6RHBvWU11TnNsNHUvOE1mZVlhZFhsSzlrUmlvNGtqOHJCMkpuTXhGbk5K?=
 =?utf-8?B?QXc9PQ==?=
Content-ID: <CCFF47B2BEBDD147899A75A837B93C73@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f27050-c235-4096-1f6c-08da84eda1f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 09:55:38.5164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fxQXhI1fEXJt8hW98jVwZJzY0QKP9LJ/Eep1jcoA6Tn3x2LktiMbMMN46Ux08lWVHVo2kngn1QMEoN+pNC7ruZti9jkSz2A2c4J2ufI4I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4834
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
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

> Hi Richard
> 
>> Hello,
>>
>> OK, I see the new patches. However I just realised these tests are part
>> of test_cgcore. These are not related to memcontrol. They should go in
>> controllers/cgroup/core01.c.
>>
>> Let's start at the beginning and look at the original selftest.
>>
>> static int test_cgcore_lesser_euid_open(const char *root)
>> {
>> 	const uid_t test_euid = 65534;	/* usually nobody, any !root is fine */
>> 	int ret = KSFT_FAIL;
>> 	char *cg_test_a = NULL, *cg_test_b = NULL;
>> 	char *cg_test_a_procs = NULL, *cg_test_b_procs = NULL;
>> 	int cg_test_b_procs_fd = -1;
>> 	uid_t saved_uid;
>>
>> 	cg_test_a = cg_name(root, "cg_test_a");
>> 	cg_test_b = cg_name(root, "cg_test_b");
>>
>> 	if (!cg_test_a || !cg_test_b)
>> 		goto cleanup;
>>
>> 	cg_test_a_procs = cg_name(cg_test_a, "cgroup.procs");
>> 	cg_test_b_procs = cg_name(cg_test_b, "cgroup.procs");
>>
>> 	if (!cg_test_a_procs || !cg_test_b_procs)
>> 		goto cleanup;
>>
>> 	if (cg_create(cg_test_a) || cg_create(cg_test_b))
>> 		goto cleanup;
>>
>> So we create two subgroups this translates to
>>
>> cg_child_a = tst_cg_group_mk(tst_cg, 'a');
>> cg_child_b = tst_cg_group_mk(tst_cg, 'b');
>>
>>
>> 	if (cg_enter_current(cg_test_a))
>> 		goto cleanup;
>>
>> This writes "0" to the cgroup.procs file which I guess is a shortcut for
>> writing the current processes PID. We have to be careful here incase
>> this behaviour is different on V1. Probably this translates to
>>
>> SAFE_CG_PRINT(cg_child_a, "cgroup.procs", "0");
>>
>> It's not clear why the current PID is moved to this CG. It may be to
>> ensure we have permission to move to a sibling CGroup and to eliminate
>> other possible reasons for getting EACCES later on.
> 
> Yes, it's not clear.

Will follow kernel selftest style, use child_a and child_b two test cgroups.

> 
> But from kernel commit[1], it just check open fd's perms instead of
> current. So I don't use a and b two cgroup .  Also, it indeed fail on
> unfixed kernel  by using only one a cgrpup.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1756d7994
> 
>>
>> 	if (chown(cg_test_a_procs, test_euid, -1) ||
>> 	    chown(cg_test_b_procs, test_euid, -1))
>> 		goto cleanup;
>>
>> Then the procs files are chowned to nobody. I see no reason this
>> function can not be implemented in the same way safe_cg_printf is. We
>> don't need to check which controller the file belongs to, just chown all
>> of them.
>>
>> 	saved_uid = geteuid();
>> 	if (seteuid(test_euid))
>> 		goto cleanup;
> 
> Yes, we can chown all cgroup procs files ie SAFE_CG_PRINTF did.
> 
>>
>> Then the current procs effective uid is changed. We need to make sure to
>> set this back before doing cleanup (or fork like you did originally).
>>
>> 	cg_test_b_procs_fd = open(cg_test_b_procs, O_RDWR);
>>
>> 	if (seteuid(saved_uid))
>> 		goto cleanup;
>>
>> Then the file is opened and the euid set back
>>
>> 	if (cg_test_b_procs_fd < 0)
>> 		goto cleanup;
>>
>> 	if (write(cg_test_b_procs_fd, "0", 1) >= 0 || errno != EACCES)
>> 		goto cleanup;
>>
>> Then we try to move to CG B and expect to get EACCES (because of the
>> permissions present when opening the file).
>>
>> 	ret = KSFT_PASS;
>> ...
>>
>>
>> Probably we want to run this test on any controllers which are
>> available. Currently the API doesn't support that. We need some way of
>> specifying that the test will use any available controllers in
>> tst_cg_require and/or tst_test.
> 
> I will move this case into cgroup/cg_core01.c, kernel selftest seems use
> memory controller, I guess we can also use memory controller because it
> is most common.
>>
>> Then we need to handle setting the euid between open and writing which
>> stops us from using safe_cg_printf.
>>
>> Probably the API shouldn't try to handle stuff this wierd. Instead we
>> can create a function like
>>
>> int n = tst_cg_group_dirfds(int *dirfds)
>>
>> which copies tst_cgroup_group.dirs[i].dir_fd into dirfds (which can be
>> statically allocated in the test code if we export CTRLS_MAX).
>>
>> Then we can do
>>
>> seteuid(nobody);
>>
>> for (i = 0; i < n; i++) {
>>       procfds[i] = openat(dirfds[i], "cgroup.procs")
>> }
>>
>> seteuid(saved_euid);
>>
>> for (i = 0; i < n; i++) {
>>       ret = write(procfds[i], "0", 1);
>>       if (ret >= 0)
>>          tst_res(TFAIL...)
>>       ...
>>
>>       close(procfds[i]);
>> }
>>
>> and whatever else is required by tests which are doing something unusual
>> with the CG hierarchy.
> 
> OK. Will  try.
> 

After some try, I think may use the old way ie safe_cg_printf but store 
the fd array and return arry size is more clear. Please see my RFC-V3 patch.

Best Regards
Yang Xu
> Best Regards
> Yang Xu
>>
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
