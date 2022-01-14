Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00951C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 03:58:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C2F93C9564
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 04:58:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 038CA3C93BC
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 04:58:17 +0100 (CET)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A743E1A011D6
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 04:58:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1642132697; x=1673668697;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=W1n5i8T4XTaHJoj2Ge1mBUUWHK7XvI4XR9SQu3KCG7k=;
 b=juppyiWmpjPNuO1/S3QnNT2qtmEsJX/arZq9ZjOqTZ3xgy86kweGpmw1
 7nttPSOND9MSNHFdzXGfS9cr5JVGN/duIATbmryU+vIvjBwmcT6d1WdVs
 OXneYjkSECHwm2dFACmMdCeXBW3dp1ushyO+oGWBAimFRjCUlqx9Lg8YP
 JsVaLoSaW3clWYjQWLDaKNslq3CMrlOWAmlG6Nu5G44k52RyPQWBY5v4j
 dW84Zvps4odyA/o+XLmPAiWYLMMT0lFSf+wVMhXDvsh/2/HT7xekiDFOR
 Vbuy83PW0xNvi5zcPI6YECe+X4tcDthwhRXcrrWdsgNXYPe6n8Ea0/eqG g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="55885189"
X-IronPort-AV: E=Sophos;i="5.88,287,1635174000"; d="scan'208";a="55885189"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 12:58:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuRmVM2dPwZscAuRBLY7Rn5FMCh3G9dU05JJ+zVHgETp8SOxrCU23QnDmdkZOHCrFnm5Odx2gn9rf/HECaMvwpibh9ToLLqnWqOyQat75uGUUbAKpdO+xK7k1pqUirVEPWjUE6ZIIgL+7pIJ/QB7Hm4xYz83ihN+knhu8lCycmxji2HusznOAq2LUi8BCLM1S3RHHaTr02zJu3RyPEzRXm1bZ7Q8uecbC4j8kzehAPExf+1ccfo9Mx7KeaIdOjPD7MCLnB87z5yW2oh2pEySKKYXmJJ+voKWPWXkdUwSrGu9g6IRfQBOO2z4cGCkiebYCaBSMRhVtxQ9y7l3TyYRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1n5i8T4XTaHJoj2Ge1mBUUWHK7XvI4XR9SQu3KCG7k=;
 b=Gc9LdMt43uomn9TvBhKKItmk28UFy3OzQhlHjfHfVV9CVN7GtgRyG7PtYVUKdPQOdGTDvoKt8g7RHaCFiRazzBlFehj81avLlzRRFZH9Y4tD3XQ3hG3UBnD+H0voiejyDBhUsnSYWD6q/cQIH2SJVxVBjrQuu+UcCV8cfFifpkUc7KYrffPZzZk7J/TJ46LegKs3OgB4hsj+lcIUnFvcfAqQMT3HqsrP3yX+qbUVazJZJdIk2OoOl8ZmLbhZN7pgi4Lkcd1VygD8Idc6o2U6fcsQOi74QDv08ubtkhYiny09vpjZhV7e7Vj+/dnHfavg7e4VuDulRI39J0QDQU5U9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1n5i8T4XTaHJoj2Ge1mBUUWHK7XvI4XR9SQu3KCG7k=;
 b=d6/tDIGPd47crqHTNObz723hK89aMyUsAYH+faHWX+Dbqq10iM4jjW9XFyUvcZomWMF+b6iIugidjOrEIcZFK0LYu1QoYmD1vUEh3QYU1TQkTPCBLAeo/GC5mLtwytgH4t6P8nQhAQWgFgnXtiSLxYUwV1rwMl9kGkM+CAykP0U=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB3487.jpnprd01.prod.outlook.com (2603:1096:404:ca::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 03:58:10 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%4]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 03:58:10 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v6 3/3] syscalls/quotactl: Make use of
 TST_EXP_PASS_SILENT and TST_EXP_FAIL
Thread-Index: AQHYB4jAQUW/+hdKG0uSpegQrIF+ZKxhCVSAgADdv4A=
Date: Fri, 14 Jan 2022 03:58:10 +0000
Message-ID: <61E0F509.3090506@fujitsu.com>
References: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641973691-22981-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeA7BQvnZ12c/QjT@yuki>
In-Reply-To: <YeA7BQvnZ12c/QjT@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70709d7a-7efb-4d2b-3f60-08d9d71214d9
x-ms-traffictypediagnostic: TYAPR01MB3487:EE_
x-microsoft-antispam-prvs: <TYAPR01MB3487E3F8CC83F4BCDC80BB56FD549@TYAPR01MB3487.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d3p3rti6qEpA+vEITppd9TQ1j9HVY7AkHdEn7Hb2b5zFea7mXgHQTIQsNFbamrKs/oiF3lc2Wdq4R9MgTqyh+cJR0P793FdNkoxFsjQTZoiP1ltezoK88tXH4FK3TEX88vXmWvLHpMzF9E0Q9LfdyQw7TmuNO+vdB4d+L/gk4u+CK3/mHtuapc+bd2yIiWmUjvIYNVCAZvyOGogjuqZCRL1/WgQRUVN/eNCF9KR0ViJN+4Gpp0TTrR6O6Z3hW/heeMAJ2tPP+kbflzFbEgarDzQkEw6QAVEbH7wlZhexvDHcqzFoJMYM72sdlOg3E+L7YKOqMtfbEcGM2Yttuq11XGEyjnNkF45qIVD10JBVmQ0t4lnR/AHGBiKgrOBuhWxhZM56iVFA8FxNieH2lPNj3lTjSG+fatt0v2o4ITouQSTyVhuvvAZTZw/b8X+FPtXjS1N+p2zAZvzaz6qhWCcuVCppR5xM7z4jAHZ1FQSjNyJv2KErJvUiCQvfwQbgYSOclvqposcva6Fml5aaHV8QOe28AAkc8fJJJUFn8G6avFGmFHMe1OFJhvd9E+Zeg/+gI5GazKm7lDtuTbhqoOwCJQNydYsJ8drR1qIG2ond/E8PFaG0hbd+ZZ9920yQ8vGJsqtk6LEqL64WzVtcO76ZzmnxzVSSF6HxNQpRDUgVbOhmmgi6JyVlfYmi2iN69beGlwuVYFy17gKKFphBsGAEfRt1AT0Y9r5JMlZwv8a/A8PU15fOaSR9W74YNIgT9UWe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(64756008)(71200400001)(2616005)(66476007)(66556008)(82960400001)(83380400001)(86362001)(6512007)(66946007)(91956017)(6486002)(76116006)(316002)(38070700005)(8676002)(6916009)(508600001)(15650500001)(186003)(2906002)(6506007)(8936002)(4326008)(122000001)(36756003)(38100700002)(26005)(85182001)(5660300002)(33656002)(87266011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OGp4R1l5TWtpVWpIWnE3OFljVmtHZWdEQmFheTk1SllDczl4K3lIT2hnckFr?=
 =?gb2312?B?RHJvNTQrWVV0ODRKRFNYUHdudDVuZ3U4MXJQL3pDb3RkTTVIS2labGtvR2FM?=
 =?gb2312?B?Vytla2tpQWhtbi9kb2FMTjczOVpmUGRSVk9lbzROOVRUTVdPaTJ5aU9mSlhE?=
 =?gb2312?B?R01EbzRtMHVFODMyUlRobmo4MGh3RUxrWGhNckdBam41dElhdDZwd3NOK1RB?=
 =?gb2312?B?ZS9iVDdhRlRQdEtLcld5RXRreHBkMjhkNk56U3gvMEliRVBBWW44ZEZyMmFn?=
 =?gb2312?B?VTNDMW0wamF2QTdDMkdFSlcxRldTa3h5Uk9obDhzbVVsQkM4WFpHZFc0K2p3?=
 =?gb2312?B?TXEyQjBqSVQ1amFHakhoaENxYWMwR1Y4TW1aK0JnZkFvb1MvU3Vjb1diSGFE?=
 =?gb2312?B?aVo1MUU1MnBraGJGQmZOdE44dG9uWk41OVdqb3BNQ1ErMXNBL2dRRnp3bGdz?=
 =?gb2312?B?b3BVeXFsWlV1MHZublVCSXBHWko2d0hoNFA4aVVQRWlDRnJhUzNIMzdhM29u?=
 =?gb2312?B?amNJcyt1SVkrNFU2Y3V3cVladlJDZ3VFUE5GQ0dJcmk2QldpZXhMNHJmaTd6?=
 =?gb2312?B?cjNGS2x3c0ZVQ21BM1FKK0gwQmZURXhZOXdqYmM2ZVpWRjlUZ2pCeFNXQ1Yv?=
 =?gb2312?B?OVNmbm41cjhoTU03VEZUUTl0N2pJTUN1amVScm1KcHhCZXpVc0lMTjQreUth?=
 =?gb2312?B?KzBQcUdCYXM0dnFhVXJURnpvR3k0Z2FPYUFsYXdLMWtXOVZmWW9Pa2taWGdo?=
 =?gb2312?B?NHdQZExNQVdLRWhabnowcUF4dC9UR2RJQk9XWHd3M3VXZjNkbFVIVWx5NFh3?=
 =?gb2312?B?NHY4Z3p5WERKL0JWa0ZpZ2RxbjI5UG9xZVEwQmNYZXdQaVVPL1l6QTdiVENt?=
 =?gb2312?B?dE5TRmdGdktnRkN1TVJNZzluQlpXNXQ2QjhZSVYraXM0RnBGSnc1SU1EWUFX?=
 =?gb2312?B?N0EyU1dxR3EzZC9CcTlHRFhBSUtrNGtJdVphUHB1TDAzZlZud3ZvbkRiandz?=
 =?gb2312?B?UWg2bGdQTklTVXByVU5uL1J0YjJFTldrcTVqZ2lLL3hlRG0xcVVUb0h6dG9U?=
 =?gb2312?B?TVZWK25ycCtqcGdDUlA4bFVVcTFrU0MwMGozTTh6djlYZXRKektpN2I3NTE0?=
 =?gb2312?B?b2lzZ0t6RjdCaTA3MjJqWWl3OEVBVEFDZjlqRmN3VENhNDkxTUp5b0N3U3di?=
 =?gb2312?B?Z1dGTExWSHdTTzM4VG0wVmoySkMyZkJCb2tpa0lMSjJtUVp3bWxHUmErUW4x?=
 =?gb2312?B?dDRTdlkzcVFQSTdJN0E1ZVk4RkZjMkM5Mlo3bzhvR0tSTVRSNVdkamVoWC9Y?=
 =?gb2312?B?Y1VDQjk0N1RiVHV0MDlkTHFRa1NKVndKejlpa25iSHJGWVZxOXJnbmRDdmxT?=
 =?gb2312?B?bkZyUWpwc2graC8wUkpVNWRIelE0eFk2VXBTN1k0TngyU28rRC9LRkllV3Ja?=
 =?gb2312?B?clJHRDNqSjNhcE5FcEdESHU0aVN5OU1SeW5lcThudkRqQ0F5czVDNVVoMElu?=
 =?gb2312?B?dlppc3pWY2RuRjJTMytmWEdHMjFzbDRKQkZWaHMwb2ZObjlob2hOVVNzTjNu?=
 =?gb2312?B?dUVVNGVzNUZ3VERveDcrYkdIRzROYkdSeU0ybkhXUnlpM2FJaUE3ZUo1ZitQ?=
 =?gb2312?B?UXdLM3N5eVlXaTBjZ1RlK2p1a0ZSaTN3SXZtdDBrUGtKa2JremxkcC9iajg0?=
 =?gb2312?B?WHA0eExBc2RSYW10aEpzTU9RRVBMSEpmNlRIVXVwZHU5T0ZzalQ2RHNtbWRv?=
 =?gb2312?B?bW1WU1h4ZkhrRGZKRzVBRWIrZnVuZ3B6S1NjY0QwMWpBbWZuZzQ0ZXd6Y0pZ?=
 =?gb2312?B?YmNyRVUvRFdKdXVEemxabXo2MnR3YVVOeE8wTXlETkJ0YmtCLy9qSWdEMGJ1?=
 =?gb2312?B?a3pEdXpDdDlxc1RSdU1LWTF2aXBuNWVnTVVlV3IrclFyUDBFVThrQXQyUzA5?=
 =?gb2312?B?QmVFSEZuNGl1WjZ4SWFUV3hiYXA5eTFCMWczMC9OVUJlejh0M0FWMDZxU3F0?=
 =?gb2312?B?bGpmb1h5cFVKQkM3amFPMXZId2pHVU9LT25hU2xleFI3YUlHd2loWFc5V0dr?=
 =?gb2312?B?aVc3VDFmZmJtd3RBVlBQRXE2Qk8zZXlFQytrVEQzT3MyZlU3VE04UjJVUEk2?=
 =?gb2312?B?WTMwdWgzajhOTjI0VGhsTUNOdmN3cTROOS9CYjVvWnB4dUhVVlFsdjJaT0RQ?=
 =?gb2312?B?WVM2V0tUYVFmZE5wWWQyWEg0SWtTcWYvMGlaeDN0N0VKNUQyRVcxamdjOG8v?=
 =?gb2312?Q?bWum6yqdbe414tDtZYInIGYMalFsFXwnhZ8J8IUPi0=3D?=
Content-ID: <4C9DFD661E8E1F4B9E62BC268C6E8954@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70709d7a-7efb-4d2b-3f60-08d9d71214d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 03:58:10.8332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06s42VvlWjcbd5Os2akjbCvcOg3V8d5DBUv9EQyCrhJRSDFmS5xln6mkuoZcJ7DF+sKcLYcRWl6LOyYM4mbLkE7xLl/2dRRtABB0Mqk5lPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3487
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 3/3] syscalls/quotactl: Make use of
 TST_EXP_PASS_SILENT and TST_EXP_FAIL
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
> Hi!
>>   } tcases[] = {
>> -	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, testdir1, EACCES, 0},
>> -	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, testdir2, ENOENT, 0},
>> -	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, usrpath, EBUSY, 1},
>> -	{QCMD(Q_SETQUOTA, USRQUOTA),&fmt_id, NULL, EFAULT, 1},
>> -	{QCMD(OPTION_INVALID, USRQUOTA),&fmt_id, usrpath, EINVAL, 0},
>> -	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, usrpath, ENOTBLK, 0},
>> -	{QCMD(Q_SETQUOTA, USRQUOTA),&test_id,&set_dq, ESRCH, 0},
>> -	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_invalid, usrpath, ESRCH, 0},
>> -	{QCMD(Q_GETNEXTQUOTA, USRQUOTA),&test_invalid, usrpath, ESRCH, 0},
>> -	{QCMD(Q_SETQUOTA, USRQUOTA),&test_id,&set_dqmax, ERANGE, 1},
>> -	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, usrpath, EPERM, 0},
>> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, testdir1, EACCES, 0,
>> +	"EACCES when cmd is Q_QUOTAON and addr existed but not a regular file"},
>> +
>> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, testdir2, ENOENT, 0,
>> +	"ENOENT when the file specified by special or addr does not exist"},
>> +
>> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, usrpath, EBUSY, 1,
>> +	"EBUSY when cmd is Q_QUOTAON and another Q_QUOTAON had already been performed"},
>> +
>> +	{QCMD(Q_SETQUOTA, USRQUOTA),&fmt_id, NULL, EFAULT, 1,
>> +	"EFAULT when addr or special is invalid"},
>> +
>> +	{QCMD(OPTION_INVALID, USRQUOTA),&fmt_id, usrpath, EINVAL, 0,
>> +	"EINVAL when cmd or type is invalid"},
>> +
>> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, usrpath, ENOTBLK, 0,
>> +	"ENOTBLK when special is not a block device"},
>> +
>> +	{QCMD(Q_SETQUOTA, USRQUOTA),&test_id,&set_dq, ESRCH, 0,
>> +	"ESRCH when no disk quota is found for the indicated user and quotas "
>> +	"have not been turned on for this fs"},
>> +
>> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_invalid, usrpath, ESRCH, 0,
>> +	"ESRCH when cmd is Q_QUOTAON, but the quota format was not found"},
>> +
>> +	{QCMD(Q_GETNEXTQUOTA, USRQUOTA),&test_invalid, usrpath, ESRCH, 0,
>> +	"ESRCH when cmd is Q_GETNEXTQUOTA, but there is no ID greater than or "
>> +	"equal to id that has an active quota"},
>> +
>> +	{QCMD(Q_SETQUOTA, USRQUOTA),&test_id,&set_dqmax, ERANGE, 1,
>> +	"ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of "
>> +	"the range allowed by the quota format"},
>> +
>> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, usrpath, EPERM, 0,
>> +	"EPERM when the caller lacked the required privilege (CAP_SYS_ADMIN) "
>> +	"for the specified operation"},
>
> These descriptions could be a bit shorter and still have the same amount
> of information, for instance the last one could be shortened to just:
>
> "EPERM when caller lacks required privilege (CAP_SYS_ADMIN)"
>
> or
>
> "ESRCH for Q_GETNEXTQUOTA but the id was last one"
>
> or
>
> "ESRCH for Q_GETNEXTQUOTA but no quota found for the user or quotas are off"
>
> Ideally all the messages should fit into a single line less than 80
> characters...
>
>
> Other than that this is a nice cleanup, with the messages shortened:
Thanks for your review, I have modified these and then pushed this patchset.

Best Regards
Yang Xu
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
