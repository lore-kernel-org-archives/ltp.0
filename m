Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C15C83F1A
	for <ltp@archiver.kernel.org>; Sun, 20 Jul 2025 10:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753007568; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=uGp54KrMIjgWcAJpoEWZTgCBvr5yGtiqAydSTUfAuZg=;
 b=JDjGs2297MHu+dmfAQttR8Ep0OvOtJLovpKYJlq6+70fTGLmcrcI34Tjwh6fAuzdGQhC9
 oTQWLoqhVN8F5r2x4+mvariIMEqt+11vypfgaO2Y/z/t1iOygUfgru/RWENwgKuZI4EV+4L
 xheNCmsFuz5jyKCi+l38I7/QoxSo8is=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF04A3CCAFE
	for <ltp@archiver.kernel.org>; Sun, 20 Jul 2025 12:32:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 713653C9976
 for <ltp@lists.linux.it>; Sun, 20 Jul 2025 12:32:25 +0200 (CEST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 24D676EEEAB
 for <ltp@lists.linux.it>; Sun, 20 Jul 2025 12:32:22 +0200 (CEST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K5cAU8000804;
 Sun, 20 Jul 2025 10:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=A+0SUsMs1oRgKsPcPN
 ZmFEeA3vygAu5HslFlSoU1qws=; b=qPqiC2YvAWpKS0SxTYhlrysBVc0dBvrntx
 d6Esr2/KKUIxaVTGHlhyLD7pJDsmRKWSnMaNSvNo+bEJH81XuJxOBnqXoDva+gD9
 kQPpE6J3aboa0ENSYbuHX+fej5CojaqIXTX8voZdYP3KbPOOaB7nJlUgUthIgoh3
 L5VFOzlo5c0UgSTFzRZyEIp+11kTJa3YMmnmgM6H5Nl2T1ldIrBF18I3L8qWWydO
 tyNRpYBH/WTGI6TD0O0NGTSxnjBjV7cX+s9ZaLHy8uIs1OWCvFdshyU/4/oK0oUQ
 V5PL9srtArUvsOWZ0Mvl/W6E0dkT47U74BLwbW0McOatK25w70qg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hp9630-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Jul 2025 10:32:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56K6tlE1038352; Sun, 20 Jul 2025 10:32:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4801t749x7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Jul 2025 10:32:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldbEqBuczM8wl2sBTp4tB25C04w99JBhrUEidcriowDfJUfu5sIk9knGcOWniZykMLEZrAKfrYLXW+QDATfd7O603YATywjcqWpyZoLsn/EYyW5H00vBertEo8jLl1KwzdHlYOstb6HBV9eWLBr+O57m7CILs6K7fcYJjwqLEvcxAWFJgflfNgrkOdB3ska46Iok/+eCvfottATduiKL7z9ERu2a/+c2dGqWr/+FhYKUn3nTtoZ8CTk4sOesrZ0BNzV3zkPdNzY+g0t4qV9VqEUel2osvN+mW82TnBDZnhsfZuGt1fLheY4fEN3QaZFeNlcTYC2IrtZuwl6q4UdcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+0SUsMs1oRgKsPcPNZmFEeA3vygAu5HslFlSoU1qws=;
 b=y89lHDfv7E1kTdytE5egEiMk/40oCeD0XuqSM441SBJxbWiSDCAXNyMfFhnYMQGCgWacLDvxeinPtlSO7oC1UYMOzA0HMLgpidfkwKEE2RlWeTL3xrI/H2yuxhYug948a7oiAxuSiigl4dlRu/v1XMWJaEs97yEtfBS7GEXdRRfNL+E+55f7l6qjW1YoW2DnGx1SJexx8SgKaDqdmFbs8sF/8XKTghFbixC0Q6+jJ75JHIVohFdt6aZe/FgU0ltl61I/8h3Nq9ic4+OfTddBoMMXpOViEnlGaC7UdRl5WlmyarLujXWrPt62eBBZv8MkFIRM7T9W0fQTXoCNk1jNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+0SUsMs1oRgKsPcPNZmFEeA3vygAu5HslFlSoU1qws=;
 b=Gp2JdsV//wA+PiKbzxxJlsmfOWBzjn+CJ8Ie9cSVVjduh6k+4Si/1mzwuokepFkJKudTX6gNj717tSN/myvP+za59tRDR1wSY4ljGI8TfpzwsVMH/hLMyQ7/xBhc2RHW53amv0x2m8aSxrqBXG8kw0jXV4YhpTqxAwChbZjMS90=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB5831.namprd10.prod.outlook.com (2603:10b6:510:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 10:31:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 10:31:58 +0000
Date: Sun, 20 Jul 2025 11:31:55 +0100
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <10b9bb44-33a2-4138-9d35-c2587b8723a3@lucifer.local>
References: <202507201002.69144b74-lkp@intel.com>
Content-Disposition: inline
In-Reply-To: <202507201002.69144b74-lkp@intel.com>
X-ClientProxiedBy: LO4P123CA0326.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c985c8-bbbf-497d-2c54-08ddc778a7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SqegxWkNn7HljvWbmRHwKUJMJPYMkcKQkbw8SK+WTFrYZ/EmIvtcdjroQOkm?=
 =?us-ascii?Q?rUMfbG7BDvh7wDGyCEuB46FGE3eP/nJSZ+AxBng4ASb4C+PAEoZq4R/JE/5I?=
 =?us-ascii?Q?rj3j4wq+zIxycjsoH+LUuG4WMeCPJzT/DKpp6+j1jB7xS/qRlMwL2ZkJWWMl?=
 =?us-ascii?Q?gbY0KwboOUOsVRupwz2vZEOlbFcjv7InAVuJ5+50IiJNRfZLYtsbpmu0ACAI?=
 =?us-ascii?Q?H+uE6Vg1wRUvaTZ3ObfZULywiA6fUoHnza2hXGE1a/9NsiFuymWo2vJa/CXE?=
 =?us-ascii?Q?VxkDOVzBM7ONv9jsf5Ageq+GzqS/Opg4kBjVSZ4VTtJPqB4KHOrAcP+vYA5+?=
 =?us-ascii?Q?mYZ3iIAGBT93rk+SauCtcc4xlS7szvzQkHg/YBDsQOFoB9nkSrBL8F/aqw/A?=
 =?us-ascii?Q?ybplJltXhnHa/U0pboS+fjvBr2XNdxnUdvcpHvA0u8u/g0QDG4Qc13/7Y4BT?=
 =?us-ascii?Q?baHbpGJ40lCae+Sn0hcAHSyWgWOhl2xtlgeVP4q5jFEnIfscLCEmYi4qIjBp?=
 =?us-ascii?Q?6AABm3eBImUX7T6Asyx4Csa3PY+XYv+qAvW+fqThmaWZnj+zQs94WRfwe1TU?=
 =?us-ascii?Q?j7XLITR1Eln8WTsG0eQY+MMEsbEmOvtbIM4BRnZ9ep5K2vNyPjBy/S/OhKGZ?=
 =?us-ascii?Q?NDLm81eByDV2COL0stw0gyzdf9N+aTHAUl4f03JegsmD27gVTp5okrwrzbDR?=
 =?us-ascii?Q?Gxq/725izVWs+PE59Z80j/47Frfx5QppEUz0YtojVaHM1tHPWHBOaYZ5XjV5?=
 =?us-ascii?Q?1xs9MTmAS31Rgd0LE5IED/6wsofJKXbgfCkHNmVot/LXve7rlADaoyMu2Fzu?=
 =?us-ascii?Q?XC+drpyrdpkq3RGXMvcf0D6XKkaVhvsKFtcLUNrQPZYi775ReMrruTNAMVAt?=
 =?us-ascii?Q?b9/IsbAHnDwEshyAqxmLqhltyeNiUwACgvipnkLLEYgFoKixwtQeUkbrXexG?=
 =?us-ascii?Q?41Vvc0T7Mr7mxLs/ychCTFbWpHGuir9zMzRsuR1LlVOBf8taNVTELmsEBcjM?=
 =?us-ascii?Q?pp9YtPP1yeG+TnxNhYi4EBWEU5cl7yL464dB4Vlm1GMdsHOI2gje/0h2yIyf?=
 =?us-ascii?Q?FhIg3kEYBQQLkqJmqQ4Uapns8vvbf0DXizpaykXHOc43pjnLB9jFX3Vxp4/p?=
 =?us-ascii?Q?9UIzc8/NOHRRFmv2I84AoY6z0m+5Ig2SXaJh7MYa45kvkfGhkka/j2NsCYka?=
 =?us-ascii?Q?S0ccGvJ7128YWVGTZ+v5Np3XVHsR4SEIEpzEuuFhc8P9pi4TtgsIsbI2vVQS?=
 =?us-ascii?Q?69FLX7MzQchwKDxEbXtzwv5BXVnX9Ix4gIB8Qo6vMDU8WFxgxDt1s9jNQ8ew?=
 =?us-ascii?Q?uBU23+SoCdasyKhwtJL5HHAU9ghBxd7hKLsle6CiAGJ1nkThWoB6UJBEcaxb?=
 =?us-ascii?Q?JL8KLc48x7hgnC/YOD3+a+EyoMcM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR10MB8218.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dm0sRCq5L2OeFGTUSD+jeqf6UjwlTgINYgeNX7i2FHziiQskI1QtqX9192Yk?=
 =?us-ascii?Q?WoBYNryPg7rlo+eNkZspPId03Mkz8j8WeKj4jgdNpSmL+wxchKCjBEskQ6Vb?=
 =?us-ascii?Q?B1gUFhqJOqG2pGt0/3M+bCEMIENo6KRZ79xejUlZB9u7EyY2Z4jwVdSKA66g?=
 =?us-ascii?Q?TSmMMBZpgb1yZcw7ZhUJM75uGHlKPQ3lVVTrQVf3Hnw5fHNXLJCfvBl9Im+N?=
 =?us-ascii?Q?MrYY+bVkZhhrl6qnR/kO8JXbeGEKGMxvIeZH4eS1bCQjtYWEPK4UMensrbS1?=
 =?us-ascii?Q?3m+srVQOQzfQ5ml29BQmBpn2086YY31XOnqL8ibMfxL1ErIaSR8LhyoDtD3E?=
 =?us-ascii?Q?UGP+LfF7JTJuXz4fFFC2zLZHEDZZgsO7VMcKuMftTq/do1beQX87zLft+W78?=
 =?us-ascii?Q?NSqyPEsGirgKwvJwidGcYvvtyU5o3U9nzKMuoq493zY5rBRrkZaAr7bSwdFx?=
 =?us-ascii?Q?C1XJw4tXA28Bi3Fvmj5517/WLyq1XJ5OOkNHoqfIHjhp/gzpuTfUO2o1jE7G?=
 =?us-ascii?Q?tVPufpa5Bbx+TyMSkUTDZUu9vLoZFRckgkzXcGGpg/SfGma9Cnd50/mdAxWv?=
 =?us-ascii?Q?R+wNV6xWdvvl395ZLO0oqKn218hGhySThaX6huWDZWtG/fjYKebQ3KnOrMej?=
 =?us-ascii?Q?McqrOfZqAqoww3XMARZgTbz4new8tTThnvxf/M00+L7vLZzeNbXQQcvtOqWH?=
 =?us-ascii?Q?D2D5AhrckaepKJP5+r4xgE5L1WzMnLLQQon3XVhLLaFhT6ipeKHehhZ7E5lM?=
 =?us-ascii?Q?xjQWWEPJsH4bf53jrRkwOT3hAVvbqM3TK14nWkI1kRfDLFSHuhuxZSupNy30?=
 =?us-ascii?Q?UyRBLhr9Nq0Ji7euEpElLAtYURPko8DGUcgDOtvl4scSdD5z7R5xZjbE5wkL?=
 =?us-ascii?Q?aMB3JoMpDjI1SW8O1l8A91JUIJCxrcNEfykt/3wSYECgQ3Ww/DwDq7UV+ZZU?=
 =?us-ascii?Q?y5G2Emd4wZxqbdOWBpVhtxL+jL5aO4FN1YHTdHHK6dkaghkGlciDdNuuv99a?=
 =?us-ascii?Q?fNlhEKP0zInSWRjPg2HfT0OCmTPY5CEvl6laCKWoPo+SqrbPTxMiILWAQV0L?=
 =?us-ascii?Q?THtFQK6AwQ9hYVOopcqelc/F8yY8sEWvnhCNEZ0G3fN0o9A7ZYIO+dJIoOHM?=
 =?us-ascii?Q?9NqS7DDxszH8DJCiuJBvuuLNeTn3eidDcyFvFrycpAill58SMBkqYRXVIQko?=
 =?us-ascii?Q?GMYy2w7rOBFgDWsU+WOzA7mGy4Ey30sD9ijyekwcpaaPH5TYWbEIq+gGUFDx?=
 =?us-ascii?Q?RJRmpzuZ6BUcQaC1i3yq59DYYV1HI7hJ6Rn2jeS9rLOCTzSAIhjf0DMb1P+o?=
 =?us-ascii?Q?U6FLSMCludddrrER6Cz/SrgPe4L8ugcNZLNv5o5tuP/aFKhFySZTjOvkQ64m?=
 =?us-ascii?Q?/hPYyP341mm5HhnC1MTt+r4/S7j6lpH+SWioqs2YTRYyOer2JIgen/m2mlGD?=
 =?us-ascii?Q?ZzZliLN5mzkDnZ6pqdR/m4UC/zw7N3QQFms+MdtvPwmM5Ub5+edenKOgam/P?=
 =?us-ascii?Q?ByNHzP8IRICQBaxFRa3aSDX6uaPQHSe1WQ8iruHYJgTahLuupCmrlMOVs1i/?=
 =?us-ascii?Q?gGikk39jpyMw3Xy8a3mUuTIa5xXS6HM+8wd52xPXX4VbdGWglOZnOt989Y+S?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yOu/865FFwDPnlkN0KxQJ9d93NcWEf8cURBTs4X97afhaEilLvPLSWBCgZ0k7eIbKf9fDWtYtRIegggMt+vknkR+RvRb9pbxFZtdeZeFAoFNFkjDxRFLlVOdgR99MxQLocNVMPnSwary0VUUkbCLBBBEtQjXygFzheReuQYJS1TiFPR6Mq5kKc4ycTLKFIYJ4CDBT7Ooz4MbTiOenovvXQuygAOAiQI2AYo9Y8NcB54okXHRVuYZb7I9T5zgWgqm7LuT2cLjGYbPkLO2JBvu4CnaKnL8NxKTp1Mux0yPvHAJkIEZGpQVhtM7h1VeJ3OxKZSUSCqASmMj8sLJpFXS8tc74ayy1KBtLa24bNeO6/vSlYGsScwoHRuzUN8X0FAnoM7pIgs2x+GgpEv1EM7LJHHZC6cwaMDm2XBX9MOtC+IfezICVmC1qgIit7GJ70LlYYZA+5yQWA0GYcEja663XWbPPAMnStihqrhhOaYcs9fHa9OAQGUVGcZ1y5kH4iTru1RC9DVdnBlWFMd/oQxePGg8QCrcVXIxd/kXZhDGi5syKbAiO/3Xw7Lkj3/RhjeS5tRao4SiOAyq0Pss6KjU4IO/n/T60AHm0q3oP+xxqvU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c985c8-bbbf-497d-2c54-08ddc778a7ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 10:31:58.4628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ea81yY5nLxiNhBc70DFnjLoD7cKQxjjr+cPPcwf56wCMvujrGziylPEu31w9/7GAdiVyN0C9yfM1bslh174V95YDUpxTIaPsUiFInNEqt10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507200100
X-Proofpoint-ORIG-GUID: miuJ-BY9l-olH0vYOjbrMV3O_vJoZ0K6
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=687cc5a7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=i3X5FwGiAAAA:8 a=NEAV23lmAAAA:8
 a=s8l5SLBU6gVuBtEF6kEA:9 a=CjuIK1q_8ugA:10 a=mmqRlSCDY2ywfjPLJ4af:22 cc=ntf
 awl=host:12062
X-Proofpoint-GUID: miuJ-BY9l-olH0vYOjbrMV3O_vJoZ0K6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDEwMCBTYWx0ZWRfX0wYNvn7EispW
 eAVYfvZUvdVJXuZg+JriycnvtUnsN3Vx8Mw4GnawARU/zeIsrdCrmdOyEqrTQOLLxTFOfvCSLLz
 /LmppaybIvuh7uMoUrHx+/V2KiRpbqsEWNuuvTfMIbfTDwKxaqGP8ikE/2tlyv8sAWFKlAaEjAN
 chCfe1wuP0RCNZcv6QxkQKmPTwxO6+DajSEtiyEr/bkkg4PIiPpNLlxBAsUpbwhI66DAdLoLSSz
 o99KsKSmeUyT9MGmHenjA1QsQwySf3/3o38zheUZKdSwI2AuaqyPcK/Zftzimhyi8dh3yCFAqGV
 QVuCKNqhFj7U6SM48MoY+ksgZgYh7aG9+iqOBQpAbCKfrdKi2wKKds7wmiiMs7JxQVk6q3IrcIg
 M4rmY+VEx5vZDeBFGh4bzQcLxX5eCLl7VdYjPzSqNxePvv8lzHnh23DgiWJj399tn4Dd6MyJ
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [mm/mremap] d9339d9c10:
 ltp.mseal01.fail
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
From: Lorenzo Stoakes via ltp <ltp@lists.linux.it>
Reply-To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 lkp@intel.com, Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
 ltp@lists.linux.it, Liam Howlett <liam.howlett@oracle.com>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 oe-lkp@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

TL; DR - there's undocumented mremap() behaviour on shrink that I accidentally
regressed. I will fix this (easy fix), document and add a self-test.

On Sun, Jul 20, 2025 at 04:30:52PM +0800, kernel test robot wrote:
>
>
> Hello,
>
> kernel test robot noticed "ltp.mseal01.fail" on:

OK, so I've looked into this, and it seems there's some undocumented mremap()
shrink behaviour even I wasn't aware of.

In mseal01.c, when you establish the mseal, you do it offset into the mapped VMA:

static void run(unsigned int n)
{
	...

		mem_addr = SAFE_MMAP(NULL, mem_size,
			tc->prot,
			MAP_ANONYMOUS | MAP_PRIVATE,
			-1, 0);

		...

		TST_EXP_PASS(sys_mseal(mem_addr + mem_offset, mem_alignment));
	...
}

This is splitting the originally mapped VMA to insert an mseal()'d region within
it:

	|------------------------|
	|            A           |
	|------------------------|

Becomes:

	 mem_offset
        <---------->
	|----------|---|---------|
	|    B     | C |    D    |
	|----------|---|---------|

You then try to mremap() and shrink B, C, and D in test_mremap_resize():

static void test_mremap_resize(void)
{
	void *new_addr;
	size_t new_size = 2 * mem_alignment;

	new_addr = SAFE_MMAP(NULL, mem_size,
		PROT_READ,
		MAP_ANONYMOUS | MAP_PRIVATE,
		-1, 0);

	TST_EXP_FAIL_PTR_VOID(mremap(mem_addr, mem_size, new_size,
		MREMAP_MAYMOVE | MREMAP_FIXED,
		new_addr),
		EPERM);

	...
}

(Note that in testing, I've found mem_size == 0x8000 and mem_alignment == 0x1000
so this is a shrink, also mem_offset == 0x2000).

So in ALL OTHER CASES you can't span multiple VMAs, let alone with gaps. But on
shrink hey you can!

So the operation becomes:

	           <- unmap this->
	|----------|---|---------|
	|    B     | C |    D    |
	|----------|---|---------|

	< move this>
	|----------|
	|    B     |
	|----------|

Obviously with C mseal()'d the unmap fails and we get the expected -EPERM fail.

The commit bisected to disallows an MREMAP_FIXED that spans multiple VMAs, which
makes the logic consistent with _every other operation_.

The manpage also appears to contradict this behaviour. So it's understandable
this was overlooked.

The fix is quick, will send shortly. It will be folded into existing series so
unfortunately can't apply tags as per below.

Thanks, Lorenzo

>
> commit: d9339d9c10d2452ae4d0087a3127359de6c2ed0e ("mm/mremap: check remap conditions earlier")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master d086c886ceb9f59dea6c3a9dae7eb89e780a20c9]
>
> in testcase: ltp
> version: ltp-x86_64-a5dad8bc3-1_20250712
> with following parameters:
>
> 	disk: 1HDD
> 	fs: xfs
> 	test: syscalls-02/mseal01
>
>
>
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-12
> test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202507201002.69144b74-lkp@intel.com
>
>
> Running tests.......
> <<<test_start>>>
> tag=mseal01 stime=1752886519
> cmdline="mseal01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1999: TINFO: LTP version: 20250530-76-ga5dad8bc3
> tst_test.c:2002: TINFO: Tested kernel: 6.16.0-rc5-00302-gd9339d9c10d2 #1 SMP PREEMPT_DYNAMIC Sat Jul 19 08:39:24 CST 2025 x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_KASAN kernel option detected which might slow the execution
> tst_test.c:1820: TINFO: Overall timeout per run is 0h 10m 00s
> mseal01.c:130: TINFO: Testing mprotect() availability
> mseal01.c:132: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
> mseal01.c:45: TPASS: mprotect(mem_addr, mem_size, PROT_NONE) : EPERM (1)
> mseal01.c:130: TINFO: Testing pkey_mprotect() availability
> mseal01.c:132: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
> ../../../../include/lapi/pkey.h:49: TCONF: pku is not supported on this CPU
> mseal01.c:130: TINFO: Testing madvise() availability
> mseal01.c:132: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
> mseal01.c:70: TPASS: madvise(mem_addr, mem_size, MADV_DONTNEED) : EPERM (1)
> mseal01.c:130: TINFO: Testing munmap() availability from child
> mseal01.c:132: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
> mseal01.c:75: TPASS: munmap(mem_addr, mem_size) : EPERM (1)
> mseal01.c:130: TINFO: Testing mremap() address move/resize
> mseal01.c:132: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
> mseal01.c:88: TFAIL: mremap(mem_addr, mem_size, new_size, MREMAP_MAYMOVE | MREMAP_FIXED, new_addr) expected EPERM: EFAULT (14)
> mseal01.c:130: TINFO: Testing mmap() protection change
> mseal01.c:132: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
> mseal01.c:98: TPASS: mmap(mem_addr, mem_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0) : EPERM (1)
>
> Summary:
> passed   10
> failed   1
> broken   0
> skipped  1
> warnings 0
> incrementing stop
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=0 cstime=1
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20250530-76-ga5dad8bc3
>
>        ###############################################################
>
>             Done executing testcases.
>             LTP Version:  20250530-76-ga5dad8bc3
>        ###############################################################
>
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250720/202507201002.69144b74-lkp@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
