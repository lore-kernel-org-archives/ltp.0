Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FAAC3ABC0
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 07:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746604589; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=dkVM+t4Wl/XgKRR6fdO7OA4ji7qn4afqzCpIczk32Y4=;
 b=WtCe4JQ4+CJ5G2oHEDuqTZdYQUvc44hFtdCDfomanBPQGtFf8v/bl3rI5/M4KDpjY7WMn
 klrSq5sdiGT8wljL+3Irfm5lbVVwXsl1TDneBCy7UPglhSTiRT342+TDzhwGeVlR6VVEczJ
 PHNNwtIofWLUC/znY1LvlOiQMOo1SCI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6F733CBD16
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 09:56:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3840C3C01E9
 for <ltp@lists.linux.it>; Wed,  7 May 2025 09:56:07 +0200 (CEST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C8425100060D
 for <ltp@lists.linux.it>; Wed,  7 May 2025 09:56:02 +0200 (CEST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5474wbwk011588;
 Wed, 7 May 2025 00:56:01 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46dee3c2qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 00:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+1lnUroTsL0D5YHV5vAQOolzvuLgoMfXP5Ap+WsdPGFxMXIojhjLSIFWk8dOasMCAPJPol15juJD1Y5whizJhLecTaX8VTomwPO844i42S2QUHbPnM9fRYNIHVdIpBwNkJHi9rku4C76tVp0kDppuVyP1imqpPF3TyFjUc8J7JyB/6QXXDdp7miALpICmhYzizEPR/e4DV2lebjVCwTqKKUyFoOdO1cV/tTQC692oCUbT71QLuG+j0IhhD+hGr/LiBcVhrKJyJcIJDsAW+deX/jHp7t+jPVg/EHk5JD/nQJpfy6M48pcHfF9esF5oR3qXCp4wtSx1ZZUs2ploQlEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rttaCJowfjC5bmrSWAHs1OJ8eQUJaFk7hPzcFZBmsC8=;
 b=q2GCTkKWb8CeJQTswF6+OxQ4tpDYbmZIv0yTgkaIqYkb+ypTPxo0m5cCcTMdXLVkTIXMhQWRu8afVq9oCG6jvL8XYVbuleBcFrN6+kmFAxr+pLjsC8bMjrzhpptnhM1+g6Uzgf5kUiTeMje9adcU5xFToqvmkgovNM9+oPsTx173T9MNLIlUBpEKtyBVtt/cRTmyRaW4hD1/yiCWASXQE44NqKArxus+HocdFpLD7arhg+m4jFFtzURIRYr51L2EKZdLPUQtlafgAfb9YYiBb6NBn4OS5od06upNKITO0IqKFw9PBOQp4w358yKLvxVeRhwyuh0YOmK47K0De5CdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH8PR11MB6928.namprd11.prod.outlook.com (2603:10b6:510:224::12)
 by MN0PR11MB6060.namprd11.prod.outlook.com (2603:10b6:208:378::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 07:55:51 +0000
Received: from PH8PR11MB6928.namprd11.prod.outlook.com
 ([fe80::4f5d:1d96:e74c:2840]) by PH8PR11MB6928.namprd11.prod.outlook.com
 ([fe80::4f5d:1d96:e74c:2840%7]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 07:55:50 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] syscalls/stime: Fix Time Overflow for 2038 Problem
 on 32-bit Systems
Thread-Index: AQHbuaGdB//9E5ypi0SK/KPET77xLrPG1xag
Date: Wed, 7 May 2025 07:55:50 +0000
Message-ID: <PH8PR11MB692833F8C0F42115118525F8B888A@PH8PR11MB6928.namprd11.prod.outlook.com>
References: <20250428073811.133441-1-jiaying.song.cn@windriver.com>
 <725822be-fb0a-4e6c-9497-ef84dbec3412@suse.com>
In-Reply-To: <725822be-fb0a-4e6c-9497-ef84dbec3412@suse.com>
Accept-Language: en-AS, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6928:EE_|MN0PR11MB6060:EE_
x-ms-office365-filtering-correlation-id: ec88e83a-093a-48cc-95c1-08dd8d3c95dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cjI4REFkV2FGaFlDNFVUY1JrSEVKbjZLRWtrNHNXdlBqQ0VPcnphWXNMSldz?=
 =?utf-8?B?RVhoZ0pSZkVnY09sQ0UvcTBHYWNBM05XemUxSTU0Q0JHaXhBemNycGIvWGRx?=
 =?utf-8?B?TTNoaXpLdVB1YlU5VzJaWFFCZkc0bWVzMFhPbHZzdWQ1WWQvQ01lb0lBWDVl?=
 =?utf-8?B?NnBsb1daNVpQaFFaeHVqbFRRTW5oUjlsYnBEb3VpLzh3SGpJS3BuV09jMVVy?=
 =?utf-8?B?UHdPZXNiN3E2NkFkTmtBZWRwc1dIVEh5RFFPNlhOdXhTSkZad1RUWTdxOUpR?=
 =?utf-8?B?SHVrZkx6dnh2bVFUcDVLbUhZRlBqeUFEYjVGeDBkd2FpL0VUWkFLbFhWTldJ?=
 =?utf-8?B?QUNBdnlzTXZPZlg5TnkyTElxYkdlUGdobVRJK2p3Qy8zY0tSMVhIbUo1amJN?=
 =?utf-8?B?RjFYcEpvSmxSYUxxU05FWUxYNXlpU2orUCswYU1wKzVDUk4yWkdiVFZ3VnVS?=
 =?utf-8?B?UmdHTUtRdWw1dlVXRkIxU1lRR0hINmV1TWFyWXBBWk9rQTMyRnpCSUdoQUpS?=
 =?utf-8?B?T2dnVVF3THVKOS83MWw1STF0dC84Y0FhUGtsWGhMelFnTDYwdEhacWo0bTd0?=
 =?utf-8?B?Qi9aOU1HdFJQOGZPaGVhTElFalJlZ2Z3SjFlcDJTd0d0ODloU1QyVC9qczBi?=
 =?utf-8?B?YXRpVHBRTFdHc05zNU9SL2ltRjdTRUxLL0I0L3lwVytFVDV6cmVVMDZhLzRK?=
 =?utf-8?B?VFZnYmZMeFpxU3hsamtrK0liZi9RUW12UDh6Z2RTQ1lZb2xWVFRneEt0RERL?=
 =?utf-8?B?NkVvSnpnUEEzMUhtM3lIRzcrVzRvSXdFdytDeHVBK3gyaVM0U1NpQjdpWTJL?=
 =?utf-8?B?YkxOL09vNEpxREZpRXhpN29GR3BLaHZMRkZaNWxLbFVjNzBiUVZSNXhVR1I4?=
 =?utf-8?B?UGRhQmJzdVJ5emVwb29zL2w1SU1taGJtc0N1OWVIVVdTOEw2RHIzQytaZ2xh?=
 =?utf-8?B?ekpPT1QxcHhQVmI2dkw5d3kyNHVQTWR5b2RRekhhU2FlWG9PdUlVNzB5NGRE?=
 =?utf-8?B?N0crbVY0eXF1bXJJVjZTYmM5Y0NNdkMrV1JpT0FVbHU4UXV0UkJFeExETDNG?=
 =?utf-8?B?SjhBaThlZ1NLNEVBOHVzb25LTVBwb2g3enVTa1hPRmFYR0JFbHBUT1JyNHQ1?=
 =?utf-8?B?c2ZyUmI0TTBoS1BpQi9XUjFabEhPMEhuMVdGT3JoWFRyOHFQeUZ5WVJmRzZN?=
 =?utf-8?B?WTBtK3R0Q0FDcytra2ZqSlZqSUtKTmo5K0MyYkxGRXI5aEpmQXU4VWlIazc1?=
 =?utf-8?B?dDFrNzEwMkVsUmtqd2Roayt1bGtxMFE5WUE1amNibmx3VzkzcHgxMnF2UzBi?=
 =?utf-8?B?TTdZRTIyNFdGakt0WkZlVHpRWmZrbTllTWljcWJQczN0NW41b21SdzVzVmZM?=
 =?utf-8?B?cUQyWjVUS01WcXF2Uy9jcWwyQTdSL0xDYWUxT204ejNhNUExdXhyOTFtZWF4?=
 =?utf-8?B?M25TejdXR1RoOENxN1hZZFI4K0pSNm1DUUliT2hhQlBXWGhWSUVTZ0FZZUEy?=
 =?utf-8?B?WktPRGlCRTEzaHVIUzF3SjV6SjRNNmVqV0lwVlh4cEZaekh5SGZPdS9sYnFZ?=
 =?utf-8?B?bkd3V29YK05POThVeUJyR05KblYydGcrWENOVTJvRXJIdHNFRnNUL0ZxU1BL?=
 =?utf-8?B?QmUzTjRPOHQ4bmZlV3VTKzN0OE1ONDFGWUN0NHNMbFc4UytqcUVIbFAxMER3?=
 =?utf-8?B?QkFUaXkvdCtmTjZlSzdEZDdVZGZiMzNpRUJwVzBjV3U3S2lQNklZbXh3TjFX?=
 =?utf-8?B?akxVVFVFVk96SXBmRS9Zck16V2xtVWFQSUtSRnhnVlhRMzlacUUvbVhld0h1?=
 =?utf-8?B?TWdWTUVldHg0MmwvRzhQOFNUR3h5azhsdzRoeitqZzIva1RkbEdld3NLTkdO?=
 =?utf-8?B?dDVrQW9WNWZmTUY3RG9JTkhXTHpWRE1ZRjIvQ1JGSktJZUVDWjFmaVdkQy83?=
 =?utf-8?B?OVVmMUcxWWpmU05kWFNtYytSMEFzWkladGVTWmNJQU00SmJ3SnEwYVhiS3Uz?=
 =?utf-8?B?VFJBQlNWRUFRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6928.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N29CdDljVEFBSFhmY2V3bUZ5bTMyekZuNUk2RWEvQTc3S1A0S2VRbkdOSmd4?=
 =?utf-8?B?b0gra25raU1GODUzVTU4blcwdzJmWmxsMDA5RjBSYlVkeDE2Zm5uSVV1QXNx?=
 =?utf-8?B?cVdDRnoxdUs3c2tMWWxYVDNtcEVyNTA5Vm1iNng0NnZ1WFNVZXczN1V5VHNY?=
 =?utf-8?B?a2NPeEgwcG9pS1l2Y091bGttK2Q2WGhtenU2Mm9UYjhseVFQd3NmR244NkZ5?=
 =?utf-8?B?M3BKa2huaG1jRHZFRk94U01iSlpRQThrZ3BwR3RZMVBGYUFMV1FkN1Y1QSsz?=
 =?utf-8?B?b09wQzNPRktKZUYzemFxb2dqY3hnSk52eUpCeGJaMzU5bWZTd2FPS1VVbEtI?=
 =?utf-8?B?ZjJhZjlGNHY1NGw3N1dQZy9kdkl5LzVnTjRjekZTQXlRMGdGU1pOb0p3YjhT?=
 =?utf-8?B?aEM2Z2JxN0l4Sk1XSEhiWUNqYVg0VExJRjFiRnFWaEJxdXB2WHRLNk9IQ0Yr?=
 =?utf-8?B?TGgrQzR0RXlmeG1KTjRVRXg1dWovQTBPUGlEZjFLM0tTaWt4eEEvUkQrZEFF?=
 =?utf-8?B?ZzdCYzZtd21Ndk8yU0ZFMnRab0pEc0NUeFRESTJqYjhjdm8zZlVlcmIyakVF?=
 =?utf-8?B?alp3SXlidzJ5T2xlRCtzL2VkM3JWUG0xa3JVRUMxT3RPR3RxcjVCemk5bStN?=
 =?utf-8?B?SkMyanVydVhGdFhHYklSVko2aWFCaGVVdnlybTRMbDA1cTAwYzh2VlV4eUN0?=
 =?utf-8?B?cHRCZDN2R1NtV1EycDZzTGdVa2FKM3dZWERjMFpDNVpVUUZTMml4aFYzL0Rl?=
 =?utf-8?B?eHJ0dGQ5TThSSjhsQ2laUDBPaFpZMHZndDRoZmdZcHM0MzdVVld6aWwvbWtV?=
 =?utf-8?B?ZkpZaFlEQ1c4Z1BscG5Hd1NUbHJjZzJBOUh0RDBUVVVsblcwOEk2Y1JHMWNz?=
 =?utf-8?B?ZVZpSENiTEhQclJMTjd3WGNFcEg2SkN4dXJiWE9aanFFcGxRbkxPclFMOHhY?=
 =?utf-8?B?OEVaMUZva25QM3pMRC9raGxhdW5EVXRNWUg4SHgzL1Z6MCtxVjZTeWVKajFG?=
 =?utf-8?B?SURkdlRVUjhjbkZYZ1NPUVYwSmhDRHZVMm83UU1GK0tqRHlvOVdGU2YvaW9q?=
 =?utf-8?B?WHU3R1ZTMTJ3bHRSMnpEK2xJWVB0bU1hVEpFamt3S0NXUE8vK2hxc0dDZmlD?=
 =?utf-8?B?Sm9RVk9UVXVoWWVLTGgyUkRLemhsejVHNk5sLytFSDJPSDVoMWJadDBCYUIx?=
 =?utf-8?B?aVVGVEttNFZ6OC9IdnR4VllhWmpSWXBoeFVqamZkMjNCMlNEeFg1MU1nTzI3?=
 =?utf-8?B?d0VTSmUvaFA2bldSK0p2emE4MkdJa2NXTUE4UEswRjI3RDRWWjVEZGJCendK?=
 =?utf-8?B?dXFZRG5iNk1TSmwrSnJyWWxwcURDTjZKNlgyMVd4Wmx0R2lGMzFvZjlOSVRk?=
 =?utf-8?B?UHgxLzBmOCtwU2UweEZnZUNSa3FYNnJIV1hiUEYvRmtsNnYzei9rR0I4dXJh?=
 =?utf-8?B?ZW1tSGpMbGFYNU1Qak5HWkJwVHQzaW4vQkxqWWNHUmpNWFVBbXIrTTlrT3B6?=
 =?utf-8?B?cXZjRHNrbFBTY3JHbXNvOTkrb3NIL2lkWjczY2xRdFFRMm5GV3ExaHFubWN4?=
 =?utf-8?B?QURXbXVjTmkvanZjSWNFQ2tudEJ0RGgxZ3dIeW40NVdubVJoUXVlUDFpS3p1?=
 =?utf-8?B?eTZ1elBvMDFpTG1xdVRZcFZiQUlBMHJPM2xhcSt0T2Vpb1JXUUpoWkVJWFZT?=
 =?utf-8?B?MXJQV2xMdFlVMnptcXZtYkQ1dktyckNIWktvSTYxMys3amNBK2RIMStVVGxp?=
 =?utf-8?B?VktEczlCOFk1aTNxQnVDUHlwZHZ3TFllelVIczVlbDM1SVI3ZXZzZWdtSzYw?=
 =?utf-8?B?K3AyQTJjeUt2ZklZL1pWaDBYVGI1V1cyTnhhdkU0NUhmRVVCa0JLNWlkNGxJ?=
 =?utf-8?B?THVCTEtNMXZNbjAzQmdmTXFMeFgzTW1lZksveUo4UlFxQnRqNDl0TnFVbnlW?=
 =?utf-8?B?cXp6UG85MlNIU2tQOUIxWDA5TXBHUkVtb1FXR0Yvb05janV6S1haWTBYUWt6?=
 =?utf-8?B?Wms4NEhCMHhVUTJLZStLc0tGM0JPU3lvZDFpc3Q0c3BTSmhsSzNRVDAzVmtj?=
 =?utf-8?B?STNFUlpXRGdUci9heHJRRm9xclQ5cGpnTjhvaHRnL0xCeTdEbEtHbnVMTHlm?=
 =?utf-8?B?bDdHUHZQMmlhRm1pU1JPNXBUZ0RYZEowZnZIMFFkaXIvRjM2NlBDRDdSOEsv?=
 =?utf-8?B?R0E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6928.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec88e83a-093a-48cc-95c1-08dd8d3c95dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 07:55:50.8077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSPTL29DfZZNrLsbSI1vqnSAm3S7QqYYIzdbBjsEKebwIdW72SP9rjV+uDyRvXG7T+rs6ShkTfzbgIinFahXDkYthjaoJEx9qssbMTOy3Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6060
X-Proofpoint-ORIG-GUID: gCjlNm-bSiG0bvV964eDuWcJJ53JBtCF
X-Authority-Analysis: v=2.4 cv=Pd3/hjhd c=1 sm=1 tr=0 ts=681b1210 cx=c_pps
 a=c8UlD/aNTkVRGuk1JCy5IQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=iox4zFpeAAAA:8 a=t7CeM3EgAAAA:8 a=wvPkM9v7g1_ikmSEda4A:9
 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: gCjlNm-bSiG0bvV964eDuWcJJ53JBtCF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA3MiBTYWx0ZWRfX4lwRKZ1JqjEW
 xLjRYwkz9ey+LQ2hXOo/d6AdB39VZcT2Rfx6xIl+hl3oHPky1RCUvAOkRG1JOAnCWDyQRUXIDfT
 ghxo/JBMAwVRLaULbosgemEcTUFeAfJGgQev3trCDDMC7d2nIXbuQNN/ldhYlFv7v2ehFKPb5zS
 nLWmcJglAC0TTguKA7d17PMIOAKp7T6CctZieqxVQilkd1AGll3n0uw552NpzkZ20OPFpa6i8bu
 eCh6pyJkuBjBI8mKbC6/VubXe+/ekEramkIxqPbwzInb4/MGjTDLHrPNHSUDo+kFTp8f8vDvQZq
 fhq2EJvxRmNRTcOmmH193DfiSbz5/ScQyNerqxW1lR1XLd/SKCKfNzFeJp8eynWdsQhE865h38C
 CmyMP2JkgWnGdD13OFUOm+qK6d8pMVAqOPsAT1a9LvkVFKQGAO2JtecoeSdybxBtaPBuMYR7
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_02,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505070072
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/stime: Fix Time Overflow for 2038
 Problem on 32-bit Systems
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
From: "Song, Jiaying \(CN\) via ltp" <ltp@lists.linux.it>
Reply-To: "Song, Jiaying \(CN\)" <Jiaying.Song.CN@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Dear Andrea Cervesato,

If the goal of stime01 (with tst_variant=2) is specifically to test the settimeofday syscall directly, then my patch is not appropriate.

After further investigation, I found that the failure on 32-bit Y2038 systems is mainly due to the fact that the kernel's syscall implementation:

SYSCALL_DEFINE2(settimeofday, struct __kernel_old_timeval __user *, tv,
                struct timezone __user *, tz)

does not support Y2038, since it relies on __kernel_old_timeval.

So the test case fails for expected reasons. Please feel free to disregard my patch.

Kind regards,
Jiaying.

-----Original Message-----
From: Andrea Cervesato <andrea.cervesato@suse.com> 
Sent: Wednesday, April 30, 2025 3:29 PM
To: Song, Jiaying (CN) <Jiaying.Song.CN@windriver.com>; ltp@lists.linux.it
Cc: Cyril Hrubis <chrubis@suse.cz>; Petr Vorel <pvorel@suse.cz>
Subject: Re: [LTP] [PATCH] syscalls/stime: Fix Time Overflow for 2038 Problem on 32-bit Systems

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and know the content is safe.

Hi!

I noticed that stime01 is equivalent to settimeofday01 when tst_variant=2. So I'm wondering if it makes sense to keep that variant, considering that it creates issues in 32bit systems. In my opinion, we should probably remove the usage of settimeofday inside stime01 and to keep settimeofday01 instead.

@Petr @Cyril WDYT?

Kind regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
