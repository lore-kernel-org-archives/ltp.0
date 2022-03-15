Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D17EC433F5
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 01:27:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7612B3CA7C6
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 02:27:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 894D13C4EDD
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 02:27:31 +0100 (CET)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4D6686009FA
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 02:27:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647307650; x=1678843650;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gc3actJ/Z9LeqM1vxM4jk4siPC1/n6hxTVRH2OWBw1U=;
 b=yExVx5K1ca8tH2U1Ic3nU+Fi6IIeqXsDjwa66T+qRmzPHaniqGoLr5n4
 UREK5IsGE1to17z8W98Epe0Ks6ooBo74mL7CPJKI2j4wQdsxBYQOBzd2L
 XE3u9sKycwCjSg+ylrjpetfvb3sR55TRW0CtSfvC/yzXWzqBAyqY7g+tH
 hItLf0iouU6YhKVmyOHtJLIfS0FCd5J9ld/v9nvDGT3zfd7Gq1UyYmqyM
 j/pVCJxRijPHQlWDpc0EicOX0XDLi2acJLdhipTxzVdzO4Kb1MerS75TY
 rnaPQwqr0E2XuoDY+/3Akt0e7tz48SGsmJ8+dz0FzvD0DzqEXBGRBLp6w g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="51848314"
X-IronPort-AV: E=Sophos;i="5.90,182,1643641200"; d="scan'208";a="51848314"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 10:27:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLUsjWZHt7D4fCnTjSN2H+Ahygx2QwD0KvujM5lJtN/ZLI9gOjIQ4mLqdAhEXzVgX12xRSToEq/MXtEda45XTvtUAz2scXwkMCqZJOfeAisofNP91ZLTC1Ey0fmg3TDY1EJZ9xMAgHOKSaNqn27girCxnxFVkrFor3r4YF6+V8B38FH6IizKdXYUiyfP3JOh9BWFq9FHJjZoTlEWH/kaEAkMk0n8vJiCUelUv/NSIsrU1Bn7i8vzhSBs/NTU2YUlepgXvg8lH9afH8z7cUBCkkULp1o6q1OSxnXQLFPDNztiod9kqHQQxCM9e608BOECG2emRmI/4S9D2hAkMjbSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc3actJ/Z9LeqM1vxM4jk4siPC1/n6hxTVRH2OWBw1U=;
 b=dv8S9n3rU22//qF9MWp59L2wrMi0ULyCCEcf3LH4bilWApos+Kk5QaRq9q9nwbzsrMAR6gWwtJdinSwC9FIKqrz+pw0wH57wHdsOF5NbYu0LDm+MLmHA5411SXzaPCV3Uy71LlKzZLCLLLCn8Xby+8/cVdnS9PYUQ/3z5pQdoiggPXqElRyT4uNz+nRWNH+Fe3so3UIaABDUsenq2d9p2wy17ndN/eFqFHaq3qGrNIu5p7o7z5fQM82QM2m+tfLwPV2+S3MJqN+dp3d7LSBK55UKPBKwZx8/6PCzwzhrKLBnyLLRZ6OSbjXlOX3qyhH+54UUYLmhTtrnWqRtyDc2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc3actJ/Z9LeqM1vxM4jk4siPC1/n6hxTVRH2OWBw1U=;
 b=AOhGLPu5rcTM5aQubErxck8qAPmpE0WzBQJzs7PUNqIyHUXPKAhap4sX+tNXjvc/JNlM55h65Yz0zE95eKneyoxopMxrZh/oCaRnaZA9ls+ChZSY97Lz5UoX9oo3HK+z6FC4onSh8mbBTUjhN3v3t07BG44u+K3wJ1j7Xs10Pc4=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB4125.jpnprd01.prod.outlook.com (2603:1096:404:c4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Tue, 15 Mar
 2022 01:27:24 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 01:27:24 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH 1/1] quotactl: Check for missing quota_v2 module
Thread-Index: AQHYN6PUsntQNXYrD0ugd2TDll9RDKy+30CAgADJVAA=
Date: Tue, 15 Mar 2022 01:27:24 +0000
Message-ID: <622FEBAA.2020706@fujitsu.com>
References: <20220314130248.22869-1-pvorel@suse.cz> <Yi9Cx1DTJi3nxxUd@pevik>
In-Reply-To: <Yi9Cx1DTJi3nxxUd@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6070e1a7-cb26-4721-c3ad-08da0622f577
x-ms-traffictypediagnostic: TYAPR01MB4125:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4125026CC5F9D5195C5BD08BFD109@TYAPR01MB4125.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EpjoMVKU/9A/KQcxunNZMqGBbwKqnleTlx78I9GLgGo8P3OdjfqKR4YeXeNOtT8scWxIGF8qiIGnMqzBWhnzDmtCKyMnl3DhNGtp3drmG+oIho+pVP0Lk1sZX99ZZwGaEQAznny4atySB90BcaJg4HPXkoeIC6yeEoT9msyQVu64QC/DAgd4wwyX0wTzf+Yamv5ocTFBzn2Jw8U5PULhLFT/Xs2KGL1C1S15EXMoUrrdoObC4/cOQ0dwDcV/d5guxPHkhNzJ1dBv3lyeo5hYkVjU4vR1eZUiYDdsJuILi5J7ZqW+MEb8XYhC9bIYJyYpsTyG0dS22pZ+ez611/v8ns40V6EYMRZKuJc6SuRaXFDEqaTdhdLXOf/fqE5/TwKbxOt3L5ybYWjE9ZDxH2gUMkwU0h1ClAJbQZ2OVCT+3bfgEfBpUB3uos1VF/ICe7s7MHyeZuH88Ry1qTBFPJVuSuIJLmaL3rzcPwi+PXZqzxA+5Bc2kiL4ZGTpYcvvgv84TRGPemp0FP77Qb30Z2I5jYjS2Fcqi+Lne82vOEyH00b1kCKoLet6O/yeGW6woMq2SYxwFA3gyvt6Fgsm12Guh7LMatskTp8zntPoOJ5/baRQLCvByWOE1QVMYqqjR9moNY9JYiKPPh7xKTutuqoP0h1gvBLWkRwVMUhaPGhf7YzPpmQmfvHCTYRl0pHUTVoyasX2scA4g0h1n8KZjGTRIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(85182001)(316002)(36756003)(8676002)(4326008)(91956017)(2906002)(6916009)(15650500001)(76116006)(54906003)(66946007)(66556008)(66476007)(66446008)(64756008)(87266011)(71200400001)(33656002)(6486002)(6506007)(6512007)(8936002)(5660300002)(4744005)(508600001)(26005)(38070700005)(186003)(2616005)(83380400001)(86362001)(122000001)(38100700002)(82960400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MU9iYlpPVnBKYWhzZWswUU12Y1ZSRUphcmJMQXY5YjcvMDh4bDNUd3loZEdl?=
 =?gb2312?B?UzEvV0pycGhWMXpDTXBzVEwrbGNmS2cyUFpLb0NzOTE2bXZ3V1R1V25BT2Rk?=
 =?gb2312?B?bG5SelpwZjRFbWtGMkd4dzR0YTFiOEJIazdHYytBY1YyWExhcFQzd3hmb0pJ?=
 =?gb2312?B?R0RKVjVScGJ2TXhRZW12Q1hjZlp3aWpHR2NteWNwbzM3Smw5dG5LbEMvUjd0?=
 =?gb2312?B?N1U2VVFwZVhhSHBHQ1k3TmFzMmpXZ2k4amJDN1YyaElkdzJkbGI3N0R3THhT?=
 =?gb2312?B?Zkh3Ky9jdHlzMFZ5VmlhVG1xV0ttWFhla3F0M2s3UDBlVStvQnhIZGtlcTV3?=
 =?gb2312?B?MUltck1talZTTkJSaXJvcC93UUVEc1dvWjhhcndna3VpSWkxTVR2ZGhldkJV?=
 =?gb2312?B?ZkxHWWRCT0MrUXkydThoczR3TThrVFp6SjVWR0g3cFJnUEVSSGxTVUpBWXZH?=
 =?gb2312?B?Y0VmY3k5dGU0bFNuUUlSSkxiZDNNZEJWMlpEbmt5UGhQckFGb1VLMmc0eGNU?=
 =?gb2312?B?aDg5aDNSaDhLQ1pXVyt0YmxtR2pOYTZta1ErVi9MMFN3dDJGR0xkaEFYWm5k?=
 =?gb2312?B?Ni9xbnlIWm9IQVdWSUxCUkdBMFpqL0ZWNUJVYUVtV3VzY2pPOWIwYnVqdTBj?=
 =?gb2312?B?TkZBWW1UY2cyRXhQaGFIUTRYbUd3Mzh4WTlNMUQ5bDlucVMzZHVjVURnTkh0?=
 =?gb2312?B?WjZobithNlc4eHhKZlVoSURjdWN4a044RmhyNDlZWUNpcTNsTGNrcisvcjBE?=
 =?gb2312?B?azg4RWQwRU5OeVlQODd1TFFmZ3RhaDcxSVpSb0pScHQ0UzdmNlBXemM1SXNX?=
 =?gb2312?B?ZVJvZk4xUGpkREFFYjBNUDZoalUwRWRGUHFVbjVrMFQ4SkpGOFB4RWh2RzlP?=
 =?gb2312?B?NEVrcU9EZENEcTFCUkpqdmdkS0ZTdFROd3dKYkcrWjE0WDgvZXVPWDI2NGpv?=
 =?gb2312?B?SVFsSEZSMUxVdXJnakVzOTNSS29RcWtuL3pnVnE5OHpRRUd4ZXVmNFpxbHZj?=
 =?gb2312?B?WkVCbDZqZGVMU3dmSG5FSGpRNCttZ3lMdW5tQy8rcWhYc29oNGw3ejVOczBE?=
 =?gb2312?B?RWpGeHptQUNxRXJLNXJITWJvbVBWZmJtQ1VPYVIweHU1cjl1elFsQjM0TGRZ?=
 =?gb2312?B?Zlc1Tm51WXdCZ3BrU1pCUWNoTnNscFp2UTVUdzAwc0FkSml2elJEbHdHdXJx?=
 =?gb2312?B?bkxOZGo4Zy9MNHNFWG42d2V5NGM5K1ZnaVBQS2hleW0zanF3Y00vTHBxdDcy?=
 =?gb2312?B?cytHbDhYUVlXMmx5TlVMcGxDUzBjV3FmQjlRT1EyTnJpbk1VSjdUWmFvZ2xM?=
 =?gb2312?B?QVhmYmloNE5LMGtKcnlEL3pyVFpVb2VXZVZPOVlVTWlRTkdtd2JJbHp6a0Jy?=
 =?gb2312?B?a2pKQUpwYVkxeThDZ1c1NEk3Y3RPL3I5ODJtclNYVk9DZW1kN2RkWXc3WlJp?=
 =?gb2312?B?RmQ1Uktjd3ptOTJZWTJFanFMd2FTa21sU1JkVlRyOEZqQ0RMcG5KMURrNGVE?=
 =?gb2312?B?RjNDMkpReUhWcXFtVEZWa0h6THdzdDZOWitnUDR1dDNxNXlvSXBDVDEzMVpY?=
 =?gb2312?B?UDJaOGVBRFdJWjlpWDNocWxZeG51SVlHQmlBNmJQOENLOG50RjNTMXdaa1Br?=
 =?gb2312?B?VElLL2xackZVRGdIWmVKdVZta01KK2NiN09QYlNseFpNc21NVytXeGxjOTUr?=
 =?gb2312?B?bW4zSDFqMEJxbU1pMWZtYkhnVWE0Z3RwdlMyYWVuMVNBNXNJN3pZTVRXeHZW?=
 =?gb2312?B?QURlVVdBZEdxVmoxMm9TbXMvSnczem5NLzhWOEkwM3FMdStrbWF6Q1BOWWZp?=
 =?gb2312?B?enYzNjZmWUJXalZlSFdIL1FIbWF3N3d2ZHhWMkRnaDRTcFB6Q25sRXp3dDNr?=
 =?gb2312?B?RThNeUZvdFR4aXFJVHpZNG9Ga21US3BpQnhYb01KV1UvakFENjBqRXBTZzI2?=
 =?gb2312?B?eFV2RWdadm9zV0M4eWt2R3B0K0wvYUFGckJNTFFHckxaclQ0VGhST0lRMGhQ?=
 =?gb2312?Q?I1ZNmBfMq3qR4FjImYqT1on9oeksK8=3D?=
Content-ID: <D63659795174004AA37FF3084443F7DD@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6070e1a7-cb26-4721-c3ad-08da0622f577
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 01:27:24.2955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BICrGahuvhHva0uI2/QULBcec0cRsj69sOpo/LAz3gGyOAbwj/MC06IJIuRB93CJYKHk+nPd8qiP9ibirUQ4SIPDVMbuzL9iegmKcmniaY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4125
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] quotactl: Check for missing quota_v2 module
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
> Hi Martin, Xu,
>
> I wonder whether quotactl04 still needs check for ESRCH search in do_mount()
> implemented by Martin in 4aab31e4c7 ("syscalls/quotactl: Skip tests if FS quota
> is not supported"), because that could be caught by CONFIG_QFMT_V2 and now
> quota_v2, right?
I think it is right.
>
> It uses fs_opts[] = {"-I 256", "-O quota,project", NULL} parameters for mkfs,
> thus it is probably needed.
If we format ext4 filesystem with quota feature, then the quota 
information will hidden in filesystem instead of visible file by using 
quotacheck.

But this feature needs mkfs > 1.43.0.

I guess we can remove do_mount by using SAFE_MOUNT like quotactl08 did.

Best Regards
Yang Xu

But shouldn't it be used also in quotactl08, which
> also uses fs_opts[] = { "-O quota", NULL} ?
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
