Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68268ECE57A
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725976555; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ZcpvwWcoaRaQ/aG2sSur2OLtTfSVh0J0AlLkkGIT3BU=;
 b=VspSPYYjeUZec6ljQn+5hON9PV5JyjHcM3G7VSQY6+T1InqUr0arbNL62pJBCF2oTfqdQ
 5bodYryJ+DHJ01r5c///MEa//C1cekul1xS0PCdUQbbdUU5vQZufuW7evzwoB0otRKZb0CI
 RaoatyCU28vqekQutkTSwMXfcoGxF3A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D84B33C1ADE
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 15:55:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 195773C1AD3
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 15:55:34 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=liam.howlett@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 084FA600468
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 15:55:29 +0200 (CEST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48ABMXAb019070;
 Tue, 10 Sep 2024 13:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 date:from:to:cc:subject:message-id:references:content-type
 :in-reply-to:mime-version; s=corp-2023-11-20; bh=7Hb/azyMWjuGYEy
 2U4SAAPGXkCfMVoIKC52mE/scncE=; b=FgIaHcDyIPn3JryFQAuSqAtYeKm0Jk1
 7mFUyP4fj6pm+o8MLd5m/YKqAHvV1IQjHEFRlRgo2dVv8H1S8ILNUSX1c1VTFb3k
 kAXehR2gLk2jfBapv7fdmc56/6xw4PErIuOR4GNI2aB5lUeoXcmlxG/7+6QUQCVH
 gQQu3GNYx8r8MmysA5M69++7oatUkuSzpV12tDLVMqOZj8L85epqVxVxuPpFOc1T
 0WuI025Nw8jes/nHuKLxU6RmXsT7tlHcivjoe1r0YWTMTU1PkCMvBOLF1IRQpiJM
 zGZTdqPmiORGOS53O/YSAINUeKdIH3q+lEtFAmT03ryNbxZBSqQaMqw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9nj11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 13:55:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48ADQerC032461; Tue, 10 Sep 2024 13:55:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd9evcp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 13:55:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vF+M4XJlt6uVAl7EAYDAzD22CnSRqAZgp8nk3g/d0WEbaNs8EQDeoCFEdsMzQjobndCbW2UWRe6f1/cw6KetMV3sNGGaYPgD1BLtFm6V+hWU7a/BlOvvImZ8S//KaKxCQVtxrqgD6xa9/J0lkBCdj5onX788LEtDvIb4JB1nisQpMbJXCaHrwacoyWIzyeUMGQ4T42TeLiI3ooaJWaEh1nIUX5gsTv2DVAAoR/clZmT8oBI4UkxXwWgN+a96TosMsqNFJOJJxG3ttv6TwfX/4XYdTt/FUr+RnPeOti5Gde/K/9U2pg2vaDGRP4E13Zq/WOri0L5dL1b7DtKZtFW+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Hb/azyMWjuGYEy2U4SAAPGXkCfMVoIKC52mE/scncE=;
 b=H8q7p3lmPpGw5FQtoOQ7m4ewtaVVTk3+TxEp4lb9YZp60OA5h6lrfY5Tv0LSNaQBli/FEerM4u+b95XqoK1gcbz6AcXJNzdf+FjzRFBHvzvE5fmyT1OP5S44EOYFjGDDSl/cjX4iE4X8+DQTY3p+Y359GZqf7OfNaJpUuzh12apz5e88szRYPzp/yYp/1GzJieMxCH/l2sTdkVjHjcINvSn4Qcv8cH/GAA7MvfXOPc5i850rvwWquRMLYZGG8euxdUCB0/X9OTOousi8iTJiyOeZHh4XXtFDC64mShtjB9sRYl8T92SMdrpD+E7zPSAxdyaFecP5l6Fj/Uey7uY52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Hb/azyMWjuGYEy2U4SAAPGXkCfMVoIKC52mE/scncE=;
 b=Gqp97Y6P405vMErS16PWDNKWtPpieGxRNeBuzXmTzTorfYjVFkmSbKcit0csjDS8/+OR5e31gxChNBdT+kfrLuqvE1umX0ocR9qC1G9Jo+Jk602pManjEyn/5heya3m1ssY6bzXYBjCkLd+UcHd+d5uL0O7kmkCbwMvoYRVDQR8=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by BN0PR10MB5079.namprd10.prod.outlook.com (2603:10b6:408:128::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 13:55:10 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Tue, 10 Sep 2024
 13:55:10 +0000
Date: Tue, 10 Sep 2024 09:55:08 -0400
To: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <bfwh67n7cztablduizthnipozy7fagsrsb33vqawv3s3bh53vo@ygxo2rzsomlc>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 Xiao Yang <ice_yangxiao@163.com>, 
 linux-mm@kvack.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
 linux-kernel@vger.kernel.org, ltp@lists.linux.it, oliver.sang@intel.com
References: <20240909050226.2053-1-ice_yangxiao@163.com>
 <d30bf8ee-6edc-4bea-adba-8d54ba520b6c@stanley.mountain>
Content-Disposition: inline
In-Reply-To: <d30bf8ee-6edc-4bea-adba-8d54ba520b6c@stanley.mountain>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::9) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|BN0PR10MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae1eac6-274f-4dac-ead7-08dcd1a02f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LEqk2B8e9KBPsG7MzTKckIuTV0miV0zGWqAibEJiogVWoFnydbSZO2GYX4WQ?=
 =?us-ascii?Q?kmr0NUBuKUqmVUarqzwEbV2PhlRUt9f5bD38DZkd3YGNEfrBcohO41JZfc9g?=
 =?us-ascii?Q?HgkCCBGemQgwuETAkaDm+B5eLK+bSTEkpzqcLU2VgFK2Zt8dAJ45JsaqrHGg?=
 =?us-ascii?Q?/sA2Geyddo4DKOBlTkUhISCiiuBdVMvFYZ5U0thhc+Fdsc5oYhg5P1+FfQRJ?=
 =?us-ascii?Q?WSrwJnms+1+xA7hIlbDAdoTcyJOa9MoDDzgVdi1TRDt6yWHURrBju+oJMXLD?=
 =?us-ascii?Q?F0sdT3QGTiO2b3Rg7Ja3iIE2rxNenb0vSCpPlvGZk2jjX8f0xuxQvMEBbTv3?=
 =?us-ascii?Q?u+aVuqvxCzxAu5qAFuYXSVpCoQClmVPILu4rbvx18T45fRZ9ZFu1vqTb0nJO?=
 =?us-ascii?Q?ZfAiFLZhJ4P4iWhceW6AIBPUILuqNUi7ljo+nKjQZN2F0xFH8aPw8H79bTll?=
 =?us-ascii?Q?ksNOSdfg0LxmC1J63RQnCOvg+Q6jHB8KA3oo7U5DHPUq6Sfwc1Kp4Pp91+CK?=
 =?us-ascii?Q?hWXnnJhV1bnVWlVVwIcMze7yKFr2aMiKgTM0G2z/2hE5J0XPUcvt9ODANGTq?=
 =?us-ascii?Q?XqD5ZSpP//zHir4Lc39zaR4M04N0MqqIza/FynvnA88KvLBhjqkf8xcFBoLN?=
 =?us-ascii?Q?E0lV9B2Tl7O/yUnCU/8dYUG7nBjGENpzeZxn5Cd18nMurO0New3vKfBwtcZJ?=
 =?us-ascii?Q?mziLCv5dt/KPDu9bBbM4qCmAoNBTZ4mI1IGSNWDQcwvBxLvHwTC+remuN3uO?=
 =?us-ascii?Q?Fp1oQC9eB5VZMTzUMVy/O8XEDaSskr1kT1tfza/eiQ3qeUXK0FgVGXVkCVIA?=
 =?us-ascii?Q?gB+tOyCVVa9I24KnimLtINV/zR51P3yIQYQiTBkuuf3f80pLylom6nVRnLbo?=
 =?us-ascii?Q?4Emc7xfilyBXPz13OOqES2C5qFo+wa9/wKiX86tfgIyduU3HorXeaV4ANZDA?=
 =?us-ascii?Q?Et7KyrxGYW/Z2fqvL5nZrdlh2D9/5UvkIYT3HYy8jF6SXMIlfs6Qx32adRjO?=
 =?us-ascii?Q?UpnqD+JkscEcK9RZGmmte0nBTOR4nWuJmE5stN6mtYt573M8qNdQ9qShePK2?=
 =?us-ascii?Q?Lse5Gub06px9oD7ulDHywkvNCUuTojPNhzJYFTaYaG7B6N2rrRT43CHsqf6f?=
 =?us-ascii?Q?/RMtDEaeIqx5q5a4BvIA0wzhO5K7sBU13KsOpBo2YumB69s7ou5TtnM0SRtt?=
 =?us-ascii?Q?JS6NpQHyMCAhnqiDe9sI9pTZZpSHhX2t8TzxSnWKXKRBDy3Bf98X+KF76My+?=
 =?us-ascii?Q?QIZUtqc2dK1Ke2zcpzwHxJNY+TFYbMLPGkmMWdwVGHFEH5b+VAqMWq2FWoot?=
 =?us-ascii?Q?czo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR10MB7943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jN1sacM20FLZ1Ouj5bFKEINDWt9tIZ9YVue0sEPAsdp0WZY2MFt8qjmgeHEe?=
 =?us-ascii?Q?knLj6cZfuxGdvsNJw+EbugXaFjevZ15KC0GWGVRqMc3AJR35KWMiIxmxKG5E?=
 =?us-ascii?Q?IGhoKsBxHTdMCf2s2q83d9FLh67Y0+2ACtcyXMfnNSBEOGTBUTK+ev6xbz+B?=
 =?us-ascii?Q?6c1eebJvSlxpmsrfiXIaDCdxsqymlZe6+ZhS4coU/BTZk8SzfuHHYHj47KJL?=
 =?us-ascii?Q?10bKdf6pMBatEZwgvbcp60qnvJswTd4QXu/oozvgWEHNJ21V9SuuGFXGKDjv?=
 =?us-ascii?Q?FOIJATJGnvQKVSFx92vyZP1GMsthrTRa9sCCC9mVOYGgsJqKxjVKC6CzBuU5?=
 =?us-ascii?Q?vA+03APmnEf6EM+E32ZWRv1TXRIwe6n6t6YovcLbc0hpQqqPv3jrJcCYiHgv?=
 =?us-ascii?Q?6sGo2mAO551yoze1Qu/B69FzoOumpuOpz7Nuc3tCCVKQ1r7W31t09ARZn8mb?=
 =?us-ascii?Q?8aVlH1HsDxOds0M6aRuqjSqoRbRp1niXSz7FyWKiJY1gwLrAmR/zgurySof1?=
 =?us-ascii?Q?jkYNBlWpHW09d/XcacNBI+C/xcsJa86z73s7LucZIQKtu2R30IBYW8hl8PRM?=
 =?us-ascii?Q?RMHhPqKEsXa5OC0wvb1zG+5emyc11P/CCM09uW48SRpyqXfRGVY/CuQPurxR?=
 =?us-ascii?Q?2yhHA+iYxh7zY/DxEm5R37AEX7hjp7sLq9gVBUf4KbjGRXf2bdSh1BuUBiFT?=
 =?us-ascii?Q?C3V8vLkKiBWuvU/N3mdRYm0nZaKC3wOOPOa/+BiHovO16yiDeGt48T8IdnF8?=
 =?us-ascii?Q?u/6kGPHqwzYOwfUy8Szw9AN2FfaSqXOMfEQdDljue0zR559WPwklglB5jmfe?=
 =?us-ascii?Q?mbuQe0kLC5k1xrUmCxAqWC83GivK1FQ/rW9/XpG2JaCB0OqQ5vA+m6lYQiKl?=
 =?us-ascii?Q?Wm5m5/EwTOeDpVrDIX7Eo7YoKSGiclAnxjAmetaAttN4Wpsn25Wbz6KMmaH/?=
 =?us-ascii?Q?SZXdp9440OOLTfcwAJH4d6GjSeSI1/FbLan2wTzr1mEUxb99MsNMEryK8GjE?=
 =?us-ascii?Q?xoQ3uG5gjoKCMmh3TZjedmQqM1XA9Xp+7a41U8MGSNRaG3FTjGvPdDclsEwO?=
 =?us-ascii?Q?8UeRdkV5l4lc2gbumV+pDPuxd8/BmsqKkk/X+nthDvYjy2lZJQ3J+tqzkqGT?=
 =?us-ascii?Q?G3vEe5Z/x49IQ1NRk1cOA2mjqvwAFhRsWXBMzAow47rMj25+Qfnkti7SrXfT?=
 =?us-ascii?Q?3LJap6gsSmwUxl1mFV0lp7OytXDJlHn6ChmdSy7qP8ZgTay0rw/3lvKOv3Da?=
 =?us-ascii?Q?Uts6+ycPw5Xn35+3Rs3WU9B5pUklOTmglPidsiltuhpeGMUzvO9GF0PZ63IT?=
 =?us-ascii?Q?C658O8RRY1gJNrfsTkF+0sXS5ET5xOgGIKyXyVkKNhnrnyaqv2xi351zygzT?=
 =?us-ascii?Q?Xwp62ZwjwkbyEgmFe+Lw+uT8WjNSM4/LZC/85AnuVldYuWafiUcF9tWjrzHP?=
 =?us-ascii?Q?Anp1tOgbkwrOBU7umxbU1LhJai0GFExrM+3IfIJ67QZkBxVj4uNflv1hs/Vz?=
 =?us-ascii?Q?aKZ3Di/8dDDBKYziwuiJHROpGl2Xxb7JNrbOipy98iNDxslqcPDGYOLIYtJX?=
 =?us-ascii?Q?6vP5vUagBig8F0dp8EJqpa+RqU2QEf9MgYKeAA3b?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vr8vHc4J64DmYKpWi3n7JBmAq8HbTSMNPRa9zT4ZhL8W+Wgex19rc6lBv+F5Z7K4jbICU9enn4jQTnV6khz3USay5odhXt/nOnDwmnUnk0p1OiFdtx3uZ88Fy+A9sNPnLz50Njs0CCj5yayLCXRWi2fPXFrATXoNgjpJIzqXvySLMxWCn36FpoB0tYA9RNvCP4igw4HWWDMsd4b5Jj1IGYV2E10yGx5L3omskmCr3ywvusgJ4N2R6VoTAeergAGlVMyqWT3sObgLg7dxWXCI2D1YTGtzKt8pFhYiHevlC3cTPl7kzOFB8Pwe6IvQVj3zpH1qXVFey3NCnEKAhF7Z8tTnkmRLMbL2TnHll55bhHLL5A2S5prKMS5Bam7vN0GF/M5d3ndjKW1/uHZoQFKgEOc1bCFECBEcS3c2eKDfvCGvEaojq12JK1Rl1qvtR1NJr7bHU1aP53eisbTCrx1YA+qnoltwGEeiAfkzkfozran4idFsWZvjiedFNaSuO9u516wosILmTMLkQ4pPIa58f1LdNOfbqDyf3I44/uHajqWoeq1mLf1P+5EJffUZsrbrpEn/tV2Z3q8TPBELHHMqJcvqr7SGecnRtEMueqtDO5g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae1eac6-274f-4dac-ead7-08dcd1a02f9b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:55:10.5316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LI93XLlvBLtzCG5wU7/M01KE5bvHgAIPl+V9yCimGDPi/45EJOlMsrF0JUcmX93/ilOwvHhpa5arH1jW1KAHPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100102
X-Proofpoint-ORIG-GUID: ug2f2BqdqthTsTNuQXHo9kL7raxVkk2i
X-Proofpoint-GUID: ug2f2BqdqthTsTNuQXHo9kL7raxVkk2i
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mm/vma: Return the exact errno for __split_vma()
 and mas_store_gfp()
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
From: "Liam R. Howlett via ltp" <ltp@lists.linux.it>
Reply-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: oe-kbuild@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 oliver.sang@intel.com, oe-kbuild-all@lists.linux.dev, ltp@lists.linux.it,
 lkp@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

* Dan Carpenter <dan.carpenter@linaro.org> [240910 09:37]:
> Hi Xiao,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Xiao-Yang/mm-vma-Return-the-exact-errno-for-__split_vma-and-mas_store_gfp/20240909-130325
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240909050226.2053-1-ice_yangxiao%40163.com
> patch subject: [PATCH] mm/vma: Return the exact errno for __split_vma() and mas_store_gfp()
> config: x86_64-randconfig-161-20240910 (https://download.01.org/0day-ci/archive/20240910/202409102026.LOh8J1Lh-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202409102026.LOh8J1Lh-lkp@intel.com/
> 
> smatch warnings:
> mm/vma.c:1263 vms_gather_munmap_vmas() warn: missing error code 'error'
> 
> vim +/error +1263 mm/vma.c
> 
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1166  /*
> dba14840905f9e Liam R. Howlett 2024-08-30  1167   * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
> 6898c9039bc8e3 Liam R. Howlett 2024-08-30  1168   * for removal at a later date.  Handles splitting first and last if necessary
> 6898c9039bc8e3 Liam R. Howlett 2024-08-30  1169   * and marking the vmas as isolated.
> 6898c9039bc8e3 Liam R. Howlett 2024-08-30  1170   *
> dba14840905f9e Liam R. Howlett 2024-08-30  1171   * @vms: The vma munmap struct
> 6898c9039bc8e3 Liam R. Howlett 2024-08-30  1172   * @mas_detach: The maple state tracking the detached tree
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1173   *
> 6898c9039bc8e3 Liam R. Howlett 2024-08-30  1174   * Return: 0 on success, -EPERM on mseal vmas, -ENOMEM otherwise
> 
> This comment needs to be updated.
> 
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1175   */
> 9014b230d88d7f Liam R. Howlett 2024-08-30  1176  int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> dba14840905f9e Liam R. Howlett 2024-08-30  1177  		struct ma_state *mas_detach)
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1178  {
> 01cf21e9e11957 Liam R. Howlett 2024-08-30  1179  	struct vm_area_struct *next = NULL;
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1180  	int error = -ENOMEM;
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1181  
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1182  	/*
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1183  	 * If we need to split any vma, do it now to save pain later.
> 20831cd6f814ea Liam R. Howlett 2024-08-30  1184  	 * Does it split the first one?
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1185  	 */
> dba14840905f9e Liam R. Howlett 2024-08-30  1186  	if (vms->start > vms->vma->vm_start) {
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1187  
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1188  		/*
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1189  		 * Make sure that map_count on return from munmap() will
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1190  		 * not exceed its limit; but let map_count go just above
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1191  		 * its limit temporarily, to help free resources as expected.
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1192  		 */
> dba14840905f9e Liam R. Howlett 2024-08-30  1193  		if (vms->end < vms->vma->vm_end &&
> 63fc66f5b6b18f Liam R. Howlett 2024-08-30  1194  		    vms->vma->vm_mm->map_count >= sysctl_max_map_count)
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1195  			goto map_count_exceeded;
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1196  
> df2a7df9a9aa32 Pedro Falcato   2024-08-17  1197  		/* Don't bother splitting the VMA if we can't unmap it anyway */
> dba14840905f9e Liam R. Howlett 2024-08-30  1198  		if (!can_modify_vma(vms->vma)) {
> df2a7df9a9aa32 Pedro Falcato   2024-08-17  1199  			error = -EPERM;
> df2a7df9a9aa32 Pedro Falcato   2024-08-17  1200  			goto start_split_failed;
> df2a7df9a9aa32 Pedro Falcato   2024-08-17  1201  		}
> df2a7df9a9aa32 Pedro Falcato   2024-08-17  1202  
> 013545e1b9bca0 Xiao Yang       2024-09-09  1203  		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
> 013545e1b9bca0 Xiao Yang       2024-09-09  1204  		if (error)
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1205  			goto start_split_failed;
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1206  	}
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1207  	vms->prev = vma_prev(vms->vmi);
> 9c3ebeda8fb5a8 Liam R. Howlett 2024-08-30  1208  	if (vms->prev)
> 9c3ebeda8fb5a8 Liam R. Howlett 2024-08-30  1209  		vms->unmap_start = vms->prev->vm_end;
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1210  
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1211  	/*
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1212  	 * Detach a range of VMAs from the mm. Using next as a temp variable as
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1213  	 * it is always overwritten.
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1214  	 */
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1215  	for_each_vma_range(*(vms->vmi), next, vms->end) {
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1216  		long nrpages;
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1217  
> df2a7df9a9aa32 Pedro Falcato   2024-08-17  1218  		if (!can_modify_vma(next)) {
> df2a7df9a9aa32 Pedro Falcato   2024-08-17  1219  			error = -EPERM;
> df2a7df9a9aa32 Pedro Falcato   2024-08-17  1220  			goto modify_vma_failed;
> df2a7df9a9aa32 Pedro Falcato   2024-08-17  1221  		}
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1222  		/* Does it split the end? */
> dba14840905f9e Liam R. Howlett 2024-08-30  1223  		if (next->vm_end > vms->end) {
> 013545e1b9bca0 Xiao Yang       2024-09-09  1224  			error = __split_vma(vms->vmi, next, vms->end, 0);
> 013545e1b9bca0 Xiao Yang       2024-09-09  1225  			if (error)
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1226  				goto end_split_failed;
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1227  		}
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1228  		vma_start_write(next);
> dba14840905f9e Liam R. Howlett 2024-08-30  1229  		mas_set(mas_detach, vms->vma_count++);
> 013545e1b9bca0 Xiao Yang       2024-09-09  1230  		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
> 013545e1b9bca0 Xiao Yang       2024-09-09  1231  		if (error)
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1232  			goto munmap_gather_failed;
> 6898c9039bc8e3 Liam R. Howlett 2024-08-30  1233  
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1234  		vma_mark_detached(next, true);
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1235  		nrpages = vma_pages(next);
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1236  
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1237  		vms->nr_pages += nrpages;
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1238  		if (next->vm_flags & VM_LOCKED)
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1239  			vms->locked_vm += nrpages;
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1240  
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1241  		if (next->vm_flags & VM_ACCOUNT)
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1242  			vms->nr_accounted += nrpages;
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1243  
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1244  		if (is_exec_mapping(next->vm_flags))
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1245  			vms->exec_vm += nrpages;
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1246  		else if (is_stack_mapping(next->vm_flags))
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1247  			vms->stack_vm += nrpages;
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1248  		else if (is_data_mapping(next->vm_flags))
> 17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1249  			vms->data_vm += nrpages;
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1250  
> dba14840905f9e Liam R. Howlett 2024-08-30  1251  		if (unlikely(vms->uf)) {
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1252  			/*
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1253  			 * If userfaultfd_unmap_prep returns an error the vmas
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1254  			 * will remain split, but userland will get a
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1255  			 * highly unexpected error anyway. This is no
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1256  			 * different than the case where the first of the two
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1257  			 * __split_vma fails, but we don't undo the first
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1258  			 * split, despite we could. This is unlikely enough
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1259  			 * failure that it's not worth optimizing it for.
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1260  			 */
> dba14840905f9e Liam R. Howlett 2024-08-30  1261  			if (userfaultfd_unmap_prep(next, vms->start, vms->end,
> dba14840905f9e Liam R. Howlett 2024-08-30  1262  						   vms->uf))
> 49b1b8d6f68310 Lorenzo Stoakes 2024-07-29 @1263  				goto userfaultfd_error;
> 
> Needs an "error = -ENOMEM;" here.  I haven't reviewed this function outside of
> what the zero day bot puts into this email.

Thanks Dan.  This is already addressed in v2 [1].

[1]. https://lore.kernel.org/all/20240909125621.1994-1-ice_yangxiao@163.com/

Regards,
Liam

...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
