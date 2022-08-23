Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B56C00140
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 07:43:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5748C3CA3DC
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 09:43:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCC233C9882
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 21:23:21 +0200 (CEST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B733360075A
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 21:23:18 +0200 (CEST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NJESOH015200;
 Tue, 23 Aug 2022 19:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=l89nL3X1q0k4Pw6ewLymU+9dF+oYOLPh5Y630HMze5M=;
 b=uZ48Vud+5omoyjyevBQlJ7uNWGyqosDi4lb8o3ZH3Y9H9aTPxzsl+BzBkdoINqh9k+I2
 Sz+OGr7+88K6VnYxSIsT18eTlZf7kEqpDWfkn0u0XKKknd0/oxTZ48cYuv+wie3snRKf
 LWtftAJEJqePEBV36SXIRiL61ruI8D9hjSfofmabYTVRuM9c1QvhZLDL2xfCht1awAL6
 jweT/VkwVoIfJN6yZgwA5IWIlTSQ8krFXRl5NDAUVWzP6x40A2SUHV3UUtuLcKdChdMW
 ZnoLdRCX9HnulrSu+PzAs0gvd/GZFoh1PhOpNK+lNFdJDPxICxmukZd4CUDKPKOqvNoL 4g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4e8c39sq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Aug 2022 19:23:15 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27NHY421018235; Tue, 23 Aug 2022 19:23:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3j3mjes0yt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Aug 2022 19:23:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5XKPYJydRzSPlOhZMICxH8fAXjX2iR+S0Sx1lFMg4wXH30N3tC2hGMof5myP45wZDPZpiyBkuMNmuPBffryktdhBCG8QsVpCr7+TuUxdcySSIqyjA0uKZbgAneN1mx6oaD1rpp4iM5BJDi6b8W9PRL7pUSyHm3wQdMsTMfd51KVS/SdO9odUsiIIn8uRmaxuVLNyrtQFpfu7WbnqkpxHgOS7XbNf/LUxVcJRq2CfqtjXObYQPyoSBoH0nMofuT2qaPLAOTTnz0vc2PMdmJYActGEnbi81H7vKj8B6MoZTqDtLLKGiADbNzUm9UnezYutOC3q/9bR2/veZ5u/diyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l89nL3X1q0k4Pw6ewLymU+9dF+oYOLPh5Y630HMze5M=;
 b=R6OvWierbC51F0FO5O7NQhFDxzzXU2SKOgFutnAH/W+XqH12qNgZrfJ0PA3AsPtvPQ1abaW/v2Oa5M1UPcSP/y1z1krqlBvK0eKXScq618IhNOiBjas4Abq8d684JHV0NnO3hiTtIOeMrN4J+oC9H7MxgsANtRmHE3BpDb57jBGLRWq6tOssNZO8Mszj9FmjWIEcPvRBuYyUmjkvAKTUbVdqgbKuRXykVnXeiRsPDfTioECRpvWFXBgK5PaEuOv7QHKQVah9C7ewbVxnjTwPP30aKLAWGj/gW6dUB0vQgub9PBfXYhyt66Q+hLbrXzRI3P9FFH6fBccknk6i96mLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l89nL3X1q0k4Pw6ewLymU+9dF+oYOLPh5Y630HMze5M=;
 b=co7/SRxzYLdczNmQIa9h2asswAntKjWlrWpKy/dVWYk/acl4t3IAMGjK92EYm3KSvjMFairlDh98d6+/6R2gejylteobnSPMS6oM/Icon9Z4Da8fTRfSug7pFsVj9VhYb41j2DqFWXpFvUZnWFDziyKEvPUyLSmIvP0qjLjJtjg=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SN6PR10MB2800.namprd10.prod.outlook.com (2603:10b6:805:db::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 19:23:12 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 19:23:12 +0000
Message-ID: <b7f4c1f8-8736-c2e8-4750-dda3768b94e1@oracle.com>
Date: Tue, 23 Aug 2022 14:23:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To: ltp@lists.linux.it, "Chang S. Bae" <chang.seok.bae@intel.com>
From: Eric DeVolder <eric.devolder@oracle.com>
X-ClientProxiedBy: SA1PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::6) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ada5c342-2a4f-4b58-cf57-08da853ceb8f
X-MS-TrafficTypeDiagnostic: SN6PR10MB2800:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKgx7/cGsgY1QPjZ/5xNOMtrE3L4ZH3YSgYTkKs20o1Qc4oGeUoHryXTUYSlYbJKbsP6COIfdVZ7DJrZ1tdmsu+60wJij7VXKDhx6RnnwWcfm14FFTRu+YbKoGJYXxlPCymsaxtIrrdZ20i4YQcLqBC0xvZVHqeE6zp6UxMx/XL4rW72niQbPTtAn9pNmPpRFn0p2K6er7Ivx4cdjE6xV7dHX4RoP04of6DIiU6kSvvW3y59InRDrS2I79Tae9fB8f9/UNF5Kq/4gfq+fSbYZJkG3RrdRSU+r13vRJ3xWatXxf9zy2ifM/AFjkdV4bMDWxESrpLPyHvh+9FGr1huNjZwrtWr+mtcIiDSkITp9uk0M1sOrkRt4Jdrlq7OxXjSy1kcXNdabRIqXF/38JrI+FIe1sxqFN/a9EhbuJfEQ1SGeMkqdZY+s0MKKKAMJikiswhRNdmwHtmQp5shD/Vif1z1TkNxpHGdQAuK+RJyocmXLE9YIApFd47gmRin/9UrRolFstir6DbijMQl801EE6mKBcdUrf1ZGPkL2WS1caP1QIt37ixtn/vT/CYTU5vAOz03pbavEzhGHrfDvLXfIXILVajemJBZZn3k7cY6lJ4DKpd6r8LnsoX4D9s5+jomfSuPHV03BSTDw9wEtr8FS+eO4wBByTEa2rU1hatT0EckaYtM0MVTjDcOFd9HrsNRUbylxwmQUuPj5vbeZW2O1p0JhjTr63N1NrfwTU9sJTf5zxbMTS87XeN3vUYNS/2wN+gciadFenYBGaYDsu8t+hO0/tkGCigj/m3pfzf0v9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB4531.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(136003)(396003)(39860400002)(346002)(376002)(366004)(8676002)(66556008)(66476007)(66946007)(6916009)(316002)(36756003)(5660300002)(107886003)(54906003)(31686004)(4326008)(6666004)(8936002)(41300700001)(6506007)(4001150100001)(83380400001)(2906002)(6512007)(186003)(6486002)(478600001)(2616005)(86362001)(31696002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjEwVHRUNlh1azBqR3htc0ZROVI4cjFiYnpUaThIaXpZMXdGeHlLTHI2Q3gx?=
 =?utf-8?B?amczbmRCcUlpRGtzVU0yT3owcHhtQ25GVjI4V05oRzR5bm9EelA0MGJLQ3Iz?=
 =?utf-8?B?VWVSWTBkR3BTYTQ3N004TjMwTFRnTVF6UmJOY21oalhhNUtXZmR0ZVc2aHFW?=
 =?utf-8?B?TStxb3A5SHhlOThoU3JGR2c3UzlqSUtQTjhyNzQ3Y2kxcW1zYUlmeDVBNExw?=
 =?utf-8?B?VWF0QjRISHlCekgzR000MkRhUm1nK2JjQmFabndRWkRIUVlqdEhwMkNlWldy?=
 =?utf-8?B?dGJ5ajJxS2Z1R0dEeTB1MDFRTjU0S250ZWRrbnFMVTk5ZC9kbFJoc2FhQXFz?=
 =?utf-8?B?N01YR0pwL0lJNHphNHk3dENyMEtFMVJwZloyVUZpWVpndDVhU2sxRWpCa2pQ?=
 =?utf-8?B?ZUo0T3RYaGlTRzY2UmpEZWNYclBZTnhSMnZRWjdieXlqVHdFSnZ4ZzBhWkNG?=
 =?utf-8?B?Wnd1NEhwTXU1WWl3ay95KzdHUldkeHdld05SR20zYjUvMXJiTlVYaHhiSVpW?=
 =?utf-8?B?Wm9qUmtyOVBjbHllcWdOcUtBRHVJblcvQUZjSXdDQk1ya1NiU1l1TjBHcUVH?=
 =?utf-8?B?bTBHVVh6VW5qakY3RTZVamxNY1F3b0E1c1BycHpaTUxjQlgwQ0M3a0trZmxo?=
 =?utf-8?B?cjZtWXViaXYwRzU4ZVQxVlROeUFQcWYyaFhtVzVzejVFRFpuWUNLdlVneEs0?=
 =?utf-8?B?dVlWOFY0dHlMN0cycUdpUUg2YitHT1VSb3FRd1U2K2M1SHhZMGJNS0ViT3hs?=
 =?utf-8?B?UzRpSkh2S2hjNzc3VmN3R201bVRFbFFTSXNXU1VjVWZTTjhqNUx1U3E0WmlD?=
 =?utf-8?B?M1FQS1U1V3I0M01HdjVOOU8vUVZWTGpyTmFTdHpWZ2luclVHdS9Pdkw4Nkp1?=
 =?utf-8?B?c2xrVXNXYy9VRnBLRm5wczVSMVFOaHlvUG9SVXd0a0R4NXlGWEN4dm95SUNR?=
 =?utf-8?B?ZDJuOEtHR3g2UTJnT3B4ejIrczZLUnhleGVnazBzc1EreVcxM05xbDdxaSs0?=
 =?utf-8?B?VlZkRHRkQTVCWnpkSVdkK3U0V1hJaUV0TGxXVm9laGFOQXVuUDBzU2t4ZW5m?=
 =?utf-8?B?a2haWCs3RGpla3AvekduRTRyaGJrWnhVeGE5Ni9ydVdnZnJ0RnBRZjZTTUdz?=
 =?utf-8?B?MUVqWWZ4eG9waG4vcDcwNzZLRUdUT29iTm1LcmN5SHVTOTMveTJFL0tZaXFp?=
 =?utf-8?B?WjFHR2tDbnNJTnVDamxITjdEWDJSYjFyR3EvZUIwbU9ZTURudHYrZTFBS2Iz?=
 =?utf-8?B?TDBLeFZKSkRsTGZIb1BwWm1wY09RVnRwNUVIanBIaFcvQkJBVmVLNjBiWUth?=
 =?utf-8?B?bTFqcWpQVXl2dVIrWXJxYWRYT2xFVG9GVW1KUGN5bFZYUWVRZTB1K2l2cHh4?=
 =?utf-8?B?bXF4WGJqbG44b0ZyV0g5ak1KRkZoUXIwVjNNVVlIK3BOV2JKSGRYb2hUR09a?=
 =?utf-8?B?NEJ5NVpITzhQNTk5aEVETjJIQWt4TkR3WmsrdGNVN1NXODhpUWJUVWU5MWds?=
 =?utf-8?B?SzBWZVpESG5RdXBmcnA4MmVkZENlaGI0QzNxbXF6U2VoSlNrVEVHWVVST1FP?=
 =?utf-8?B?cjRlbllzN1lCcmVkOHh2dzJCTjZMdHFITjRncndIVy91T0hrZm1YZFNjQ1pD?=
 =?utf-8?B?SXJIam40dzZiUE82ZndSQlYxSWxmOGNKVHVOZ0luT3M4NENPOTZnSGdYQmF3?=
 =?utf-8?B?KzBRek9vQzFXcW5LL0JXaWV6N09XVG5XWHgya1NsM2RjNEprOU5KNDFRai9x?=
 =?utf-8?B?cU14enpBSnRKNmZ2SEFVNTg3QVgrOWJ3ZUs5S2k0VkJqMTg2OXlqdzNFOHh0?=
 =?utf-8?B?Sm9aVm5PRTZ3Q2xWck5zWnpTRTBoSGhBYWhnaXhiTEtaazZjVDhJNG9hTG1W?=
 =?utf-8?B?dGtnc3BNRXdEN1dxY2hxWkVyQ1QyR1I5aXJIUlhmSjVxZkFibnZ1ZktUVWZI?=
 =?utf-8?B?Qk5lZE5xOXpNQzJHQmxLYVhwWUFuUnBUK2F4TGdyMlprenpqanhiNmhXditw?=
 =?utf-8?B?aFg2cVdmNFo2M00yZUJsZ2UyNzlNZjVlS1doTTBUWlUxRXBQU2hySnpneTM5?=
 =?utf-8?B?TjBNLzZnZDJZSEkzcVpGTTh2b250eWlCTzJwZmgzUC8yR1p5RHlRcElXU29K?=
 =?utf-8?B?eTMvdGFTTGc0RHZXbkhOOUFiUFRvTHlRM25kMVYwODFibmNQOHdSa1NBZEFH?=
 =?utf-8?Q?sZv+5Icv5t5TGyVwFqmxbw4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada5c342-2a4f-4b58-cf57-08da853ceb8f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 19:23:12.4666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2g4yx7uJ1bez8QHyJfeNE/bvktc2fQgISv+eVM+yfPDj6YuD5NX4nqJ4jAJKx3HNHanM5FOTZlXvWgvLLQqV+Bu+42mkv6KUzfmvzsVjnBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_07,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230073
X-Proofpoint-GUID: 07imYeNRdifPUc0nSZw8mdAREK8_nyxU
X-Proofpoint-ORIG-GUID: 07imYeNRdifPUc0nSZw8mdAREK8_nyxU
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 24 Aug 2022 09:43:29 +0200
Subject: [LTP] ptrace07 regression w/ Intel Sapphire Rapids
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
Cc: lisa vaz <lisa.vaz@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

While working on an Intel Sapphire Rapids machine and a recent
upstream kernel, we have discovered that the LTP test ptrace07 fails.

With kernel v6.0.0-rc1, on a non-Sapphire Rapids machine, the test
passes:

  # PATH=$PATH:$PWD ./ptrace07
  tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
  ptrace07.c:139: TINFO: PTRACE_SETREGSET with reserved bits failed with EINVAL
  ptrace07.c:162: TINFO: test child 7762 exited, retcode: 0
  ptrace07.c:175: TPASS: wasn't able to set invalid FPU state

  Summary:
  passed   1
  failed   0
  broken   0
  skipped  0
  warnings 0

With the same kernel on a Sapphire Rapids machine, the test fails:

  # PATH=$PATH:$PWD ./ptrace07
  tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
  ptrace07.c:143: TBROK: PTRACE_SETREGSET failed with unexpected error: EFAULT (14)
  tst_test.c:1571: TINFO: Killed the leftover descendant processes

  Summary:
  passed   0
  failed   0
  broken   1
  skipped  0
  warnings 0

I have bisected and determined that the failure point occurs at the
following commit:

  Chang S. Bae <chang.seok.bae@intel.com> 2021-10-21
  2308ee57 x86/fpu/amx: Enable the AMX feature in 64-bit mode

This commits simply turns-on support for AMX; in reality however, the
issue lies elsewhere. In fact, instrumentation reveals that the test
fails in ptrace07.c:do_test() here:

         if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
                 return -ENODEV;

         /*
          * A whole standard-format XSAVE buffer is needed:
          */
         if (pos != 0 || count != fpu_user_cfg.max_size)
                 return -EFAULT;

The test passes the X86_FEATURE_XSAVE check, but then fails at the
buffer check with EFAULT.

The value for pos is 0, the value for count is 4096, and the value for
fpu_user_cfg.max_size is 11008. This check fails due to count !=
max_size.

This appears to be an issue with the ptrace07 test; specifically the
userspace-supplied buffer needs to be, according to the code comment
above, the whole standard-format XSAVE buffer, which is 11008 bytes,
in this situation.

I've edited ltp/testcases/kernel/syscalls/ptrace/ptrace07.c,
do_test(), as such:

  --- a/testcases/kernel/syscalls/ptrace/ptrace07.c
  +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
  @@ -83,7 +83,7 @@ static void do_test(void)
          int i;
          int num_cpus = tst_ncpus();
          pid_t pid;
  -       uint64_t xstate[512];
  +       uint64_t xstate[1376];
          struct iovec iov = { .iov_base = xstate, .iov_len = sizeof(xstate) };
          int status;
          bool okay;

The value 512 yields the 4096 byte buffer observed originally. The
1376 yields the max_size of 11008. When I run the ptrace07 test this
way, the test now passes!

This problem has existed about a year but its existence only on
Sapphire Rapids machines likely explains why it has gone undetected.

Chang Bae has corroborated these findings. Furthermore he suggests the
test should reference the CPUID leaf EAX=0xd,ECX=0x0 as EBX will
indicate the XSAVE buffer size.

Regards,
eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
