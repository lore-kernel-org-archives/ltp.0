Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69334C3DA4A
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 08:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723624111; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rgeDWk3a65gUFVPujMzL8MrIn1UO4NWZLEfCyJFwXWw=;
 b=dkPIAcTAsrBN4yVSX/egDWSLKHOUCqhLqYpgNeToRSEZcjpyUOkEYGWQo+QaYrdTssqE5
 jY0NLXhqVnfb1ANh8VXW2hu4pzMK9tuVPAXt7Or+RCnViTOSN/ntxA+flzCPKjRYZh0Kqib
 hc+qp7rfhsIg91I2g6LbXW8IQVhRHbs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D19873D2125
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 10:28:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 092773CFBBE
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 10:28:08 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=calum.mackay@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3F272600FA2
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 10:28:06 +0200 (CEST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E6MXCT024469;
 Wed, 14 Aug 2024 08:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=corp-2023-11-20; bh=O0c7Isr6PYlv3Q
 syXdnBO2eacgOpUqs7haw54vP9PY0=; b=CCZP2+/wOeTT+cG8P2/13VBBYKLgTq
 yNZNsyht7hzQrQPuPimtWY/HLGcegglyS8ShiFGBpN7pfzmmrL+kAa1t9SyJ6m17
 0GaVHLMMHozaYbVH9nPMJ0YChgnikz1tEC3LzGzaQGUCxDmhEz8ca2nUUdRBxZzT
 z0V6J6zyqhratmKj9p8sfPRfzqbBGxdbwEsSgmq8LJ9wCgqIiYjDw1d2BEvm0F4Z
 IoZX1EyZLSiYgg8YGEHdI6Od0WSUEmKripCgl0+0WT9m5VJpAkwDQ+Q48k+tOoYm
 Bjaiz27wR6hQzVkSPRbHkQ8V5e7dPU/tj+Yndeo/qJnQDAdprffDOHTw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxt0yt1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Aug 2024 08:28:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47E87xrL017619; Wed, 14 Aug 2024 08:27:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxnak1nm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Aug 2024 08:27:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQuL2RHCbi4RCn77g+H6iez1rveKyed1IK8ZDcWNa7kE301Tng13Zy/LkRyYQFmB5qRkhha7uCv+FptOLBcp0XMTH/Aye6F03UXQgrztbE2/gi99PIgW+dvfUoWEhpHWvO0oO1dAAFzloOpYTnAUPemvIBPs6cOoM+EOzljPH4o7E2pE14oGmiFoI7ov4xfCS7Of/59xApwcxF9zXRjr2wQaMzxY3Yt4/mdxRvjjfXknbU/0bSuudl9A6B84HDhc/zbkc/jqjVmZ9SCGY7AFdl4aJLRlnLQqEIWi6iWfYEcfxTndKcOJERxw9z+5EQBIY2/r5gXYV8WanVsQLBVXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0c7Isr6PYlv3QsyXdnBO2eacgOpUqs7haw54vP9PY0=;
 b=aTJledA1M6Hl/p8BooiHwfW007r52/a9+LBQzDYyGDxVVc30VuVQPEC5OP7LgULQVKgMsWRpGDj/wC/c6kDj7cmHK+U++ak2K2hRJIlCRIMBgPsdpLYQQ8rWDpInyzPZrHFAXODY3CTeS4hQ832b3IePkzNKIj4aWdEDGy5wCNvbc5J8wn8UYG0bR/wi7mNmeGSYu/QC19Ea1JmdQqw56Q2NPUmwrM3Z5Vy/cnfOr1NGsvsIO/esCdawiwFdY4XyQ6D15WS9uni/FJzGyaWCvqZG1s0g7d/XIGf4CpC7xLNOd9NwjGv2emKaMENFIyYxBCpnHP4jo68pz2O5oyuyVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0c7Isr6PYlv3QsyXdnBO2eacgOpUqs7haw54vP9PY0=;
 b=IakQUfsFvgYmZACteF/2kyL/+uJTGrldeSpNMZBWGYU0cHzY5Fv8eC25kJgr1uOaLbw9Ym8LZTjRytG6wPGly1znjowra5IXQLWzkR49PYD7HmN2NldtK2RdSjj6ROdTRPvUb76VEqmv266VdzRZmTy7wPyTR+UcEXac1yBzTFk=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BLAPR10MB4964.namprd10.prod.outlook.com (2603:10b6:208:30c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 08:27:56 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 08:27:56 +0000
To: Petr Vorel <pvorel@suse.cz>, "cel@kernel.org" <cel@kernel.org>
Thread-Topic: [PATCH 6.6.y 00/12] Backport "make svc_stat per-net instead of
 global"
Thread-Index: AQHa7h4dHg1ZsEtEqECx5ROWkdecp7ImahNZ
Date: Wed, 14 Aug 2024 08:27:56 +0000
Message-ID: <BN0PR10MB5143EDD71EF92A181D4255A0E7872@BN0PR10MB5143.namprd10.prod.outlook.com>
References: <20240812223604.32592-1-cel@kernel.org>
 <20240814074559.GA209695@pevik>
In-Reply-To: <20240814074559.GA209695@pevik>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5143:EE_|BLAPR10MB4964:EE_
x-ms-office365-filtering-correlation-id: cc5a9c01-bf88-44fe-6371-08dcbc3aff9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: ItfS3DTdlZNjx76XmE69f1slj1tRRoGXF4Hc5AtXyOp6bDHKw5oGD+rj9cld2yZ7LDzwXFpwcusM+ywv36Ne1OZNV5iR/VrpIkVF7w0YG3GSvBfXjEMf5RILn11IdAfgBxZs8yvqy/nJwyn1aAVwKB7haRxI9oShbQ/8Mkcdc1eUxCLb4ztice6Yw80oDGBKzoJZW3jhsXN5W+rrlt9iM+yLt43xvhun6Tfdj/3ucuZU/i8mwT2oGJ1u4zbDTlPmdpYUv1Z75zKzm66tKVhccCB3f3EoU31TT+Zt1j2eNUlBZEECL0DplDR+xhg6hZoeOYpR/HePR7DMEVOHrI6AXMSeMYABJWfqh3QKaa0rUMPRd+2JZ6CrlGzAuggEcwNSsa8RDUtIw3m/HaalIbnX0eRt7VvBQO3Ls3tmtdTBOloxyPTHxKBpIy+GNAlESmWptK9Xt0MaNDNFdi+PUQQpJEqg9UuJ2I//yCIN+wh3WHb6mnqZ5SqIaCf06aKyGek57KclXDicwDDoA2hKJH/Nx16zzxiy/HidwcR+uMmj2LO+dyWeqafkyyUFbRsPfYpvW5FanI/oDVCbwRsbDjefbqOPkhh+hdEBdnyax1p5JOux5c//oEpjQeIi0B+/iFSH0ilZMpk/DGsusxRGXOaT6/jAmy2Zfr3SOsExklDty8t3TKvmGRUhVku6sHT/ruA3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5143.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SnuLef6lXP8CTDRTs8HyZIxdEf0GR6bCxEQ2i0VRfBdwWTDCh5Wr2fp79E+K?=
 =?us-ascii?Q?25N1swIZ0Ln2I8tf/Set/F23uaOxkoSz/e1nlqgdFZ5FQPQfkRTZzPPZVxWE?=
 =?us-ascii?Q?KTfAHKJPMpGXoGP8szDpfBQM/nt5pYPYtTY35rmq232waoQuDPTEOKvCRHKV?=
 =?us-ascii?Q?9Wp/KFmVUgm8oM+ptMPcibKzsmehHCe4vekDlFMaG3cZc8b8oNq8jFLGTcMJ?=
 =?us-ascii?Q?+GKMqIpvp4Dn2QfNFYZBaQr3qRr2KZquzPrfsBLlxxtCGTe/MSoTIl7C12fJ?=
 =?us-ascii?Q?He4RzBXibiGVNxNnjI41psSSZ8BXpjU/PU3xpRGybryNKLi3yz+pVrXfxRSI?=
 =?us-ascii?Q?LNvlhdGqOJarnmHJNvelKU9TVAkkP6syOzx53h9JTwbPpOs5FL50XEMyonyO?=
 =?us-ascii?Q?RNY2rxTCdhyuEL8aCMAccgfZVSnBIzRSBqd6lYnUsUxH3qvNDXiT9YMcx1ja?=
 =?us-ascii?Q?vtpN0gaoPhgR+f88IZ1f0BNtyMH+jSeTim6FAkZ45gE71kR4QOP9fVaZSJ7f?=
 =?us-ascii?Q?jygOz28N0hhoUaWHqS1oJClJk0Fj4oTA5yUb2/SeSJst2pG3zCd1PlAoMZ+U?=
 =?us-ascii?Q?hK4u6/tSjSepB7kiC3iaA1echbRK5BNfZN1JkwLlC3ZNREUAgGJYIQWNH0PV?=
 =?us-ascii?Q?leoy/dm93P3zTZR6O1s+A//Sl2s1whE86kH3nmDrCJICOn1BHMZSIyHHXLgX?=
 =?us-ascii?Q?s8hizGp/duAJCT29xycbEnmv2VRDDB60d0Pw72M8zjpbPi49wh8J/G2ep3LQ?=
 =?us-ascii?Q?uqEsF6faVszblem7ZFaJS85tGP2sz4hrQw6A6H5MkhrrmreXaIrrkgrgqFun?=
 =?us-ascii?Q?+Zc/Hpu5PSQEuPZoKNFNnYCmVvqwObJ45xLHchx+XHu94NYl6/aDRHoNlZqp?=
 =?us-ascii?Q?0TMMsJRveSxn3sQXrxVSGZXkbIctVjPowIH9pHwepkQ5RvLKt5PQDGmIyU5A?=
 =?us-ascii?Q?IkdS/tnhZeYaVfBELJpuRQPIhdkv5zIgKRW87dhFgOXaaaVmMty30lSl5Y55?=
 =?us-ascii?Q?3UHUdxpOOhH1JZxbaNGGU/vkkjkEPmrULb0t03sWaD38TzV0j57Myc2MtUfA?=
 =?us-ascii?Q?bT6Ptl4c1tQTg+1s8BSsRUQJmGgf1+AKa0g4EilinGpEOBhD6KmCauVNox0i?=
 =?us-ascii?Q?Xe5FlnvER9TxysnCRGh8tQILRHjhvOPIY6hph9w2rsCFVXFAFz9jW/6VcbcH?=
 =?us-ascii?Q?F1rWxigJPRjMpXwKXNjhqEDAWyHMCrC6Ia8oyixJiHmFFw+itU1E5KZftate?=
 =?us-ascii?Q?g7eJC+HfVnUhPvaqw84A7Km6JxRikDD4CW71Dg4pNgZbMyOAeqlMrEX5I0z7?=
 =?us-ascii?Q?Pz0oPWdy26kMOKFzHfsdKEm04aifoGbtyN7GXQAbLuVLc0tpZy7u492mnEWx?=
 =?us-ascii?Q?FrV8oVmSootaTvL+lZFiFEzl7krIi1zdjQkmpmh2QyBVRFrMhI8cLnn9hpSa?=
 =?us-ascii?Q?hXu4IjiZOqALbRrTUTNo5agUsFsnjWThjpiTYQu8cvErG5GIKnE85tGei3ox?=
 =?us-ascii?Q?o9Zb8q9DFfN2dhafZdGjn4QO/iwdqy5ULiCSq/TsvCJ8okfDr7cpHgbwTvVF?=
 =?us-ascii?Q?0rEtDeDV9zFuDQMEaM8/s4cQNBVjUDiUDxHokVsjdceqdcY9Rjcw5tdxrM2n?=
 =?us-ascii?Q?PA=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NxiLxfyvbZtefBhicBnD+KfIOw/6/1jT48XQzUJnTrNciZeQ9QpN77dOutZ8I9f7HpJ72YW5R3JHvoB8ZE6KQb3Tm5r6f+jzCtg4Pp6UTY4SnzV/ROpoK3c6wA7acFV9MvRkhkebrhY4wcHhJbyZ8201903ZKjb1RTqNAiYDBs8dqxdBpVvLZnsSBv9cvODD4ndlVoTrbz330AihsyUoOkm4ULxgR6SNKg521fHWF7HDEjNphuhPrN5WuMLwwnS0jTeQlS7AfCQRsNdBfxxmRFwFv+OZ05QWtjAuseW4D30Esmr+uh0YdopTEJ/TzaKfGPO8WMPW0VDXf8itHCmHSb9ktDQC1A+SjjmQZDNVH/Xk9wJXcctpk7upO5vUXUJUiqae55d4eqw74sJGaIzhOEAZjdJUkeG0Rq/9MkrTYy/146XIBH5ctnr36xw05D9+uIz1x3J10G9ImIbb4mNqWwT2wXJ+izytUNPJPo9a5rFB7++XiYgYebHX/rNPq5FyuoruXPBOfSSTZoVkuBD0o6GxmynyxY/ed91qGrTqdw6HhOQiN9PItOQi9PxOVuEB18bQPxjXhp33RL6/TQybuOeHuSkyiS8x0yAPLtTZGiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5a9c01-bf88-44fe-6371-08dcbc3aff9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 08:27:56.2107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynforl54LwaL3pXuXhZwJDOh4ycxgSvmUwBO6IQNllmCVGPKpoV+8gQjE44egYPCew1Tkpk9p6X5AN2XsYH1cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_05,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140057
X-Proofpoint-GUID: JSQUb-FfgPmpqO6583vhgEU0V0ymEadO
X-Proofpoint-ORIG-GUID: JSQUb-FfgPmpqO6583vhgEU0V0ymEadO
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 6.6.y 00/12] Backport "make svc_stat per-net
 instead of global"
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
From: Calum Mackay via ltp <ltp@lists.linux.it>
Reply-To: Calum Mackay <calum.mackay@oracle.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 Sherry Yang <sherry.yang@oracle.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Chuck Lever III <chuck.lever@oracle.com>,
 "kernel-team@fb.com" <kernel-team@fb.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

There are two sets of changes here, for NFS client, and NFS server.

The NFS client changes have already been backported from v6.9 all the way to v5.4.

Here, Chuck is discussing the NFS server changes (and others), which were not backported from v6.9 (actually, a few were, but only to v6.8).

Thanks,
Calum.

Sent from Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: Petr Vorel <pvorel@suse.cz>
Sent: Wednesday, August 14, 2024 8:45:59 AM
To: cel@kernel.org <cel@kernel.org>
Cc: stable@vger.kernel.org <stable@vger.kernel.org>; linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>; Sherry Yang <sherry.yang@oracle.com>; Calum Mackay <calum.mackay@oracle.com>; kernel-team@fb.com <kernel-team@fb.com>; Chuck Lever III <chuck.lever@oracle.com>; Cyril Hrubis <chrubis@suse.cz>; ltp@lists.linux.it <ltp@lists.linux.it>
Subject: Re: [PATCH 6.6.y 00/12] Backport "make svc_stat per-net instead of global"

Hi Chuck,

> Following up on:

> https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/

> Here is a backport series targeting origin/linux-6.6.y that closes
> the information leak described in the above thread. It passes basic
> NFSD regression testing.


Thank you for handling this! The link above mentions that it was already
backported to 5.4 and indeed I see at least d47151b79e322 ("nfs: expose
/proc/net/sunrpc/nfs in net namespaces") is backported in 5.4, 5.10, 5.15, 6.1.
And you're now preparing 6.6. Thus we can expect the behavior changed from
5.4 kernels.

I wonder if we consider this as a fix, thus expect any kernel newer than 5.4
should backport all these 12 patches.

Or, whether we should relax and just check if version is higher than the one
which got it in stable/LTS (e.g. >= 5.4.276 || >= 5.10.217 ...). The question is
also if enterprise distros will take this patchset.

BTW We have in LTP functionality which points as a hint to kernel fixes. But
it's usually a single commit. I might need to list all.

Kind regards,
Petr

> Review comments welcome.

> Chuck Lever (2):
>   NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
>   NFSD: Fix frame size warning in svc_export_parse()

> Josef Bacik (10):
>   sunrpc: don't change ->sv_stats if it doesn't exist
>   nfsd: stop setting ->pg_stats for unused stats
>   sunrpc: pass in the sv_stats struct through svc_create_pooled
>   sunrpc: remove ->pg_stats from svc_program
>   sunrpc: use the struct net as the svc proc private
>   nfsd: rename NFSD_NET_* to NFSD_STATS_*
>   nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
>   nfsd: make all of the nfsd stats per-network namespace
>   nfsd: remove nfsd_stats, make th_cnt a global counter
>   nfsd: make svc_stat per-network namespace instead of global

>  fs/lockd/svc.c             |  3 --
>  fs/nfs/callback.c          |  3 --
>  fs/nfsd/cache.h            |  2 -
>  fs/nfsd/export.c           | 32 ++++++++++----
>  fs/nfsd/export.h           |  4 +-
>  fs/nfsd/netns.h            | 25 +++++++++--
>  fs/nfsd/nfs4proc.c         |  6 +--
>  fs/nfsd/nfs4state.c        |  3 +-
>  fs/nfsd/nfscache.c         | 40 ++++-------------
>  fs/nfsd/nfsctl.c           | 16 +++----
>  fs/nfsd/nfsd.h             |  1 +
>  fs/nfsd/nfsfh.c            |  3 +-
>  fs/nfsd/nfssvc.c           | 14 +++---
>  fs/nfsd/stats.c            | 54 ++++++++++-------------
>  fs/nfsd/stats.h            | 88 ++++++++++++++------------------------
>  fs/nfsd/vfs.c              |  6 ++-
>  include/linux/sunrpc/svc.h |  5 ++-
>  net/sunrpc/stats.c         |  2 +-
>  net/sunrpc/svc.c           | 39 +++++++++++------
>  19 files changed, 163 insertions(+), 183 deletions(-)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
