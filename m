Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5C3C433EF
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 06:43:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C12123C90DA
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 07:43:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F1D93C19DF
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 07:43:27 +0100 (CET)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AC1C9600710
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 07:43:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647240207; x=1678776207;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zdpVajQzlU0iMOyJHjGsOgnvudDStXwBITmE0O9bqhY=;
 b=l1ytzZtev0PzJCsLRLxgRo8SRovpoRbmKAWy7nKOde043HqaBkZfUMG1
 FEjzTm44uN5/1oqguu4ljG2uX0wz5h8m7fQs6ix6YpVC62oLQ9Lrcr8Xs
 QXxdg5z6a1zZutmv6u9YBocQu+8DKlU04yxjUFjdjABMNyLi04u1LljUt
 a1SUgdtUMBegMwLzT2GQmv0bLSGmM5BtrmXhtxTOWyBEL96augXb6E5Cf
 uhaJ9YQckNj27LJ06cpERwrtEggtCuYy3rnAACsEjH+qdSLohjJTHdgf9
 takbo1iRilgiPJsDZsD2/DQ2qZ5mwWL4tEzg9SxwX64OOdNS9GAS4282x w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="51481077"
X-IronPort-AV: E=Sophos;i="5.90,179,1643641200"; d="scan'208";a="51481077"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 15:43:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ua3iDwFhxj45ds7HjoW0zScHAW4pgdfbE4AGT1zp4lK9/qX/t+1foQza03ll1YQ6u+8hDVQ3cy9Gbl/rhVYpzZXL7HslSLoWPdwx337X5L7DjDFsqYt8NiB5S45eKXonfeXoJwmwX2z8Jfqx3OpXvXcdrpM4Fl/7M3iQCiss8B+vai40F1uCqa4Am/E3YVM+yMbKfz0bqixsyzfH2XmXrehVHQYGoRrTK+TbEPZyDSmRKDYrFirPYXLI2a4KjdbglqgkiNJiTnXBf1sr7EkjNUPRCnZ+548JKSRrXN5jKMtHu9/LxW+ueotWDWnfYqsXpGXHtZibB+7Z2O2q3+Padw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdpVajQzlU0iMOyJHjGsOgnvudDStXwBITmE0O9bqhY=;
 b=D4xNc3Qbq0OVGyswpHSKwqu0Nx0YvSRFMP8zRSiAkEMUW0YmQSsKFAM3MFRP07hPJlbsZLoIxlbpWB4vm2L8L0AflbHQ3B1XPVOlRRGmAKfeGuAPSTZNDxAjGkouwNp7T16TDZzkT5dmyVIRLsJxWpXa6DYiWn2n3Zn+OgqZyJ8VFUQuFJ9EmSjn39yilm/xBheUDxEcS1cjtGEpO1RVyFm4awiupm5OB7AGex/Pr9ZdPUFUPDFjIbqdlO9mAVrXtmismvJIZKyp/882yYVmctn1e+U1W2+tcbmjGjT37fJXMYuQ5OCZylO1hcN6F4I7UwePQdOo1q2o02MQHgAcbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdpVajQzlU0iMOyJHjGsOgnvudDStXwBITmE0O9bqhY=;
 b=oAM4vaYCpkoAozOg5lKppZ/zIapTcGJXro/jA05xHvZ5E5Am83fUjGbrwUDzI92M33Xh3Z8mMrLkn+CZqVlsFwt2wrkcz+STJzExSzWykqMburmlbgQHPeF8/8HbQTZ10L6/rJOsKcdKyWFuK5rWjeMO1ZP+kbbTAJrG74m4k18=
Received: from OSAPR01MB4419.jpnprd01.prod.outlook.com (2603:1096:604:62::18)
 by OSAPR01MB3140.jpnprd01.prod.outlook.com (2603:1096:604:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 06:43:21 +0000
Received: from OSAPR01MB4419.jpnprd01.prod.outlook.com
 ([fe80::cd9c:a0e4:ad72:5e65]) by OSAPR01MB4419.jpnprd01.prod.outlook.com
 ([fe80::cd9c:a0e4:ad72:5e65%7]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 06:43:20 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Thread-Topic: [LTP] [PATCH 2/2] Make use of SAFE_ACCESS
Thread-Index: AQHYN1wctZdRaAN+YEWL2gHAT6Qv8qy+bxIA
Date: Mon, 14 Mar 2022 06:43:20 +0000
Message-ID: <622EE434.4000400@fujitsu.com>
References: <1647278899-29461-1-git-send-email-daisl.fnst@fujitsu.com>
 <1647278899-29461-2-git-send-email-daisl.fnst@fujitsu.com>
In-Reply-To: <1647278899-29461-2-git-send-email-daisl.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31f05dcc-d884-473f-c859-08da0585ee12
x-ms-traffictypediagnostic: OSAPR01MB3140:EE_
x-microsoft-antispam-prvs: <OSAPR01MB3140033F6ACCE3899EF01F23FD0F9@OSAPR01MB3140.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZQZWev77pek8GBZvoO+eyzYJsYr+G0ZcyywgaYAf3yVw9CkNXQPiQps/SSitONEjmBkXKbdxrWhfsah6NDluqbj6HO6XDOf1V5rSj67gWIBVdQo9Hu8Kdo9wz1VeKonPlNL1gO9lnbPMl3T94vwMOC8p+OLSITn6apRvNAPPWQo9i4pixPjRrrbZM36WG5p5ev6cdBH3DJ6GTIDYMKIKyoApJQFYThldMXVv31+llr9ErCoau1gfqluHXZ3plS05Fx7LO6klH2XoyHz0L1D5lX8klTKu/w66W0ZGL1nGYL0gyCtTovLbUGAiiflqapHl4Y7cnm0uXoq6unVauuiT2J3AOhYNsG5yl0sMsHEHhdJnl5xLpck/xdOJeCqhJBAnCWHmvvL+68K1iPOugbqrOuKcRMSJBMirW3I/KJ95s/0mCwfWgB2OAKcPGA0R/j6Zs0WW42O6qhjmoKRKQrPCnfTJ2jPugWaLm9fJ9uFOws54VTJuTn9W4WDCs5hDhF1GqhPUfQ38oFCzCvkZfWzhC6PS0noj+XsDxjoTnI/TwpkVQKG8sNCnn91ngc726Cj7cXWwPnAxqqD13K0rNI8QWFkW2tAnDJ4DyiwW2yqOamv9O6Ag0OXn75QZRDjMZtBcJO/xtwReY1a/F6+u3umiHs/0aRri4vaYCo8jWZzn0Ahj2Ca+t+8fLydVuEya3qdy7er7LfIklV28LcpexFJusQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSAPR01MB4419.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(87266011)(6512007)(2906002)(33656002)(26005)(82960400001)(6506007)(83380400001)(186003)(66476007)(6862004)(6486002)(8676002)(66556008)(66446008)(4326008)(64756008)(38070700005)(5660300002)(66946007)(37006003)(316002)(86362001)(6636002)(122000001)(91956017)(76116006)(508600001)(8936002)(85182001)(36756003)(38100700002)(71200400001)(2616005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NVd4bU80TDJwMFZPdnFtOTlZbzVsa1NQbG1TL3podDlISFdvMytpcmE2c21K?=
 =?gb2312?B?WWRoUll5MFQzU0F2azVZZ1NjVTRFVTYrL3l0TG1wd0xrQTZYREE1a2I1VVJs?=
 =?gb2312?B?SXF3djg5ek5ndlBaT3dnWXg1ekR4LzhwZ01PcldiR3k1dzhtS0J1b3lBUldw?=
 =?gb2312?B?VDBlYmxiYUJSa3V5NUd0NkZMamp0OElJWW9pSU1EZ000WUQzN2pmaERZbmM4?=
 =?gb2312?B?bGtnU1N2UWdscG9IUmNlU0RGUDBQNEhKOWErTTlCU3N0ZlUrMEFKTUxGV0F1?=
 =?gb2312?B?L2VEcDMwcHIrQzJXUEo0YWxNV0ZaTFp3aFVTdE95VUxKMEI2Q1BXK21hSGFD?=
 =?gb2312?B?bnBqbVprVWI1NUlMZWhEekV4Tzk3dG0xMCttN2JxUERjeTVMWFdRSXpQT0ZM?=
 =?gb2312?B?UG1lRStrRDFTdXBaYVRlSWtxak9DRExnd0h3QWE1cFJDTmNtQzJlT3dVRTlx?=
 =?gb2312?B?TWUzeUhaMHltNGpXeG9hMGF5YVRielFKTkJHVXU2Qlkzb2NmQ3EyVzFKRG5G?=
 =?gb2312?B?YlZyN2FOT2JWZjVGTnFSemdLMS8zVlNLcGJLSWZLa0oyT29wMHB5L2doTENI?=
 =?gb2312?B?U3JmdHRRclZQbWM1TExuZ2Mzbk9lUS94aWZtT3c3dGthclBUVzdKME9yczQr?=
 =?gb2312?B?ZHMwUFg0eW41cVdHV2VXcDFRdE1qSG1hdm51TmFpcWE4WVIrZXdJcW0wYldi?=
 =?gb2312?B?TTlHOHFrRjh0QjVZalljc3hZdmNqVjFWMlZqc0l2aTF3R1ZnZmVGdHg3dEdM?=
 =?gb2312?B?RnpyWXFkUFowMEo1SGFQMnRuYys4VE8zVjhuVElraGRTa3hDZ2tXbzNDVENq?=
 =?gb2312?B?YW1NQVd4WXZvalpIdFQzY0tjWU4rbHpHUVNhL1Y4V0dnUGw5WW45RkVEdW94?=
 =?gb2312?B?emZXTUk4Z2tINlJwWlBqNERRL0d4eHN3cWxHWmlkYTY3cDJoQVBzT1hVZzVB?=
 =?gb2312?B?NHovbkhLNmhDcHA3aFkvY3FSTmdFNzN5MkNSWFdzRXRDekdIK1o1L2sveFBC?=
 =?gb2312?B?ajlmMit5UG1POUM0VHYxSzVSM29YdFIwYmNIaUtjSzRlbXQ2SWlMNXkzVkF0?=
 =?gb2312?B?OTJGcUNkVDZqYnVzNnJaV1B0UVJza29YSU4xTEVkd3B6TU45V1BWUHBkY3RZ?=
 =?gb2312?B?WVdrMmdRK1dBV055eUxrQVJqL1RoSEJLNzFUT2psZmhtOEFyaVBoNkdmZkp1?=
 =?gb2312?B?UFRYRTNMTmgxb240a1ozVVUybHVHdUl5cG11WWgwdnhnN1NEUFhhOWVQOTRt?=
 =?gb2312?B?NWc2YXlVK0MyK3dmZVJlRForVno5MitrUEFwVDVsVnR1eS84blEwQnFaQm9q?=
 =?gb2312?B?RC9mVURVT0l6UzNuUmdscE1TeGVsZExhaDBFSHBXUzRRWUtEZXBsSnNkWVV4?=
 =?gb2312?B?SllTQ2pEMXU1WWxUYllDcWVuWWFVYW9USVNTa2pMSmpKWlV6NjhFYWJyZWZq?=
 =?gb2312?B?MWV6RkZ6Q0lGT2NteHRTcTFxZXE2VTJxTnQyTFVLQkNsNFFhZStjbE5ZRzh0?=
 =?gb2312?B?Tk9DUGVNV0N4KzVEQWVkWTh1Zll2MU1XczZDa083bEw1a0hTeFpHcHdoQTRk?=
 =?gb2312?B?M2hiN01vclA4UmZDYTRiQnREcHZEaFluRlBUSTBIL3E5ZnBDZkNrWXpSeDI0?=
 =?gb2312?B?UHBvc3RGRjFHVkFWK05DWFY4WTNtcEttK2ZxVjlqZkpCclhXUWpnRHF5QmFs?=
 =?gb2312?B?TkNaVkNEWGRERGVOZ2xKcTV3MzBJM1A4UWJuc3orQUxoVlhWWnJTajkvWkV4?=
 =?gb2312?B?Y2NzRVloSkhUM3FJSVdqZHMvYk9YVEdEdmN4NnFKeTgrZytSbVExdGdxWUJs?=
 =?gb2312?B?bG9TTjRTc2FHZ0dJY3BLZXVYQUVFYnJTYm9XeGdzVFJyZnJ2cUp4VThqYnlO?=
 =?gb2312?B?UlVnWEx0c0RnUzRYeWdialBEdTUzRVJEOFEzdzFmd0htaGIvcWlWZnVIVXVk?=
 =?gb2312?B?bkJSR29YaklsTVFRYTBHZGUwWXZldk85TzU4WEZUM1ZDTXpSam1sanBXaGUz?=
 =?gb2312?Q?Jb7VddxCA/fZNrnCoBFYzFKgahGcS8=3D?=
Content-ID: <3CE74B93B5306542BE461E75B01AFC16@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4419.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f05dcc-d884-473f-c859-08da0585ee12
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 06:43:20.7156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAJB9zTxKiBdAUo0f8xpLiHny92O0lRR51sYcZViF0UUEbtY7Ix4c1TzoRHCgF99Mf8RRqYBWi6oOC314O2eYKYGmxYVKGb2VoNLJ+maEqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3140
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Make use of SAFE_ACCESS
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

Hi Dai

Since only umount2_02 uses old ltp api, I think we can convert it into 
ltp new api. Then we can just add this safe_macro to tst_safe_macro.c 
instead of safe_macro.c.

Best Regards
Yang Xu
> Signed-off-by: Dai Shili<daisl.fnst@fujitsu.com>
> ---
>   testcases/kernel/mem/tunable/max_map_count.c    | 4 +---
>   testcases/kernel/syscalls/fanotify/fanotify17.c | 3 +--
>   testcases/kernel/syscalls/getxattr/getxattr05.c | 3 +--
>   testcases/kernel/syscalls/madvise/madvise08.c   | 3 +--
>   testcases/kernel/syscalls/quotactl/quotactl01.c | 6 ++----
>   testcases/kernel/syscalls/quotactl/quotactl06.c | 3 +--
>   testcases/kernel/syscalls/umount2/umount2_02.c  | 6 ++----
>   7 files changed, 9 insertions(+), 19 deletions(-)
>
> diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
> index a4c3dbf..caf8972 100644
> --- a/testcases/kernel/mem/tunable/max_map_count.c
> +++ b/testcases/kernel/mem/tunable/max_map_count.c
> @@ -58,9 +58,7 @@ static long old_overcommit = -1;
>
>   static void setup(void)
>   {
> -	if (access(PATH_SYSVM "max_map_count", F_OK) != 0)
> -		tst_brk(TBROK | TERRNO,
> -			 "Can't support to test max_map_count");
> +	SAFE_ACCESS(PATH_SYSVM "max_map_count", F_OK);
>
>   	old_max_map_count = get_sys_tune("max_map_count");
>   	old_overcommit = get_sys_tune("overcommit_memory");
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify17.c b/testcases/kernel/syscalls/fanotify/fanotify17.c
> index 35beb53..7d74b25 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify17.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify17.c
> @@ -159,8 +159,7 @@ static void do_unshare(int map_root)
>   		 * uid_map file should exist since Linux 3.8 because
>   		 * it is available on Linux 3.5
>   		 */
> -		if (access(UID_MAP, F_OK))
> -			tst_brk(TBROK, "file %s didn't exist", UID_MAP);
> +		SAFE_ACCESS(UID_MAP, F_OK);
>
>   		SAFE_FILE_PRINTF(UID_MAP, "%d %d %d", 0, 0, 1);
>   	}
> diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
> index c0d339f..3e73cc5 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr05.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
> @@ -100,8 +100,7 @@ static void do_unshare(int map_root)
>   		/* uid_map file should exist since Linux 3.8 because
>   		 * it is available on Linux 3.5
>   		 */
> -		if (access(UID_MAP, F_OK))
> -			tst_brk(TBROK, "file %s didn't exist", UID_MAP);
> +		SAFE_ACCESS(UID_MAP, F_OK);
>
>   		SAFE_FILE_PRINTF(UID_MAP, "%d %d %d", 0, 0, 1);
>   	}
> diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
> index 30f3604..10549f4 100644
> --- a/testcases/kernel/syscalls/madvise/madvise08.c
> +++ b/testcases/kernel/syscalls/madvise/madvise08.c
> @@ -110,8 +110,7 @@ static int find_sequence(int pid)
>
>   	snprintf(dumpname, 256, "dump-%d", pid);
>   	tst_res(TINFO, "Dump file should be %s", dumpname);
> -	if (access(dumpname, F_OK))
> -		tst_brk(TBROK | TERRNO, "Dump file was not found.");
> +	SAFE_ACCESS(dumpname, F_OK);
>
>   	dfd = SAFE_OPEN(dumpname, O_RDONLY);
>
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
> index 561e503..3382d7b 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
> @@ -160,11 +160,9 @@ static void setup(void)
>   	SAFE_CMD(cmd, NULL, NULL);
>   	fmt_id = var->fmt_id;
>
> -	if (access(USRPATH, F_OK) == -1)
> -		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
> +	SAFE_ACCESS(USRPATH, F_OK);
>
> -	if (access(GRPPATH, F_OK) == -1)
> -		tst_brk(TFAIL | TERRNO, "group quotafile didn't exist");
> +	SAFE_ACCESS(GRPPATH, F_OK);
>
>   	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
>
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
> index 8771523..839c6ed 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
> @@ -186,8 +186,7 @@ static void setup(void)
>   	/* vfsv0 block limit 2^42, vfsv1 block limit 2^63 - 1 */
>   	set_dqmax.dqb_bsoftlimit = tst_variant ? 0x20000000000000 : 0x100000000;
>
> -	if (access(USRPATH, F_OK) == -1)
> -		tst_brk(TBROK | TERRNO, "user quotafile didn't exist");
> +	SAFE_ACCESS(USRPATH, F_OK);
>
>   	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
>
> diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
> index 7d558fa..9dad4d5 100644
> --- a/testcases/kernel/syscalls/umount2/umount2_02.c
> +++ b/testcases/kernel/syscalls/umount2/umount2_02.c
> @@ -128,10 +128,8 @@ static void setup(void)
>   static void test_umount2(int i)
>   {
>   	/* a new access removes the expired mark of the mount point */
> -	if (test_cases[i].do_access) {
> -		if (access(MNTPOINT, F_OK) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "access(2) failed");
> -	}
> +	if (test_cases[i].do_access)
> +		SAFE_ACCESS(cleanup, MNTPOINT, F_OK);
>
>   	TEST(umount2_retry(MNTPOINT, test_cases[i].flag));
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
