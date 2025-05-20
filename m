Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056E4C3DA6D
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 15:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747755451; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7dBqYI3P/Pis+veTBKSV7PIUXmmdZYSMVMgDAVOlOfs=;
 b=fjawKHt3jqKaGgdTlFXt4eXdUkS+bAflqiS8mLfC5KJthSfVZC/PO3CJxTakmjbzwQsfY
 DRMZBU+1eCrCzBOMjXLmnJQIOy+l1ItzMEfGR8X4+8gv4T+mMRQ2+SlLma7kOknGDYeViFg
 Keqt7oaqa41vQLJOsyvXHa498hKYRAw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B7323CC757
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 17:37:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C69233CC6F9
 for <ltp@lists.linux.it>; Tue, 20 May 2025 17:37:09 +0200 (CEST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C8030140BB6B
 for <ltp@lists.linux.it>; Tue, 20 May 2025 17:37:07 +0200 (CEST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDresq023682;
 Tue, 20 May 2025 15:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=zLgngKXn9J47QbiuPZ/jxdOxQiHqLUZzZZJQ2W6pQHM=; b=
 EcraVAjZi3lywu9AXlWazZ4pftiuynEowridZUJil/x9yRzwKokuxHmRyFnJIn2H
 smTlGtsuKu1OtTJDP7n3XG6b4axF/UxmAH7/rJJ0aChtkzwjx14sPqWc1fv6SNMt
 AKv/OVD6G9yAlAkm3lgPJjoIvpX74jVHRifOybqJMABGM+64sIMu6uV/3PpLoyI+
 GsNvCQI5HKXpFCd4Vx4gJeJdQOF8d3K43FJ4CyBX4mkeQE2I9mdPM6+huausc3vo
 nt6HsaIp22lztjs/sjPWS7uPzy7PYCZ0+57kpKFNlaJlNeBe2c5NN8+azLVvf1x7
 IlOKLkUny0eO2DQQ6SX5Bw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ru11racf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 15:37:02 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KFUKRm002494; Tue, 20 May 2025 15:36:59 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw7xs8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 15:36:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHLtPYssu4Hoa722c/hQXnPGkrjgxSV+iypQwNyuY31Bth/KVCTA/z/B0H/9d6IE8EyrMJa6TaPUrsF/W4y57fTjp1P2jM+5uNoA8ekunW1AhZCmOCEOsdqMBvJR52j4af+Udi1fJCHtBUsSVJzA1Frk373msHaDmmTxzXLJ/+DeeWFEkWZJ2BX53X5wL+vmc7UAUlrvr1cFqQx0jIuORje3LsIOOCCad76cXi28vAhuRb5zx9v+DxyHVct5x/nkL/vA3fb1ztCTm0BM0tGbIo99xgDD/Hb59KB5WRh5n4466i9pA7LjJZ7WtfdBbmgztjEhuaGEW49DZDsjxGTYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLgngKXn9J47QbiuPZ/jxdOxQiHqLUZzZZJQ2W6pQHM=;
 b=x/8D4aUYUDi9snPEh/0FXALLY3HHWZAKLxO8VtXZqYHWpjt7lPk1vanPvgkFjzrKNOxTRkrg8iDJB47W8WwK9JF9YqxGu8xoGcgXmz8TENfxQTzty06hVsMKbmwBbk697Lj70YVjDNAPjT3o6bndQiuNeH7a9SqfoHiBryI9fAV57KLkMDC5E8HcD5AsyXGlpUus++mtjcaxkjPbc18oMekZa1d/JwILhACCi9pj1cctezXJYfUlJyM8ZEK2gFpxphZMtSdxDphrXvR5UPiVA0AUVFfkSEzd2BG4YL6zWhuQDA0n2fMx9tFLzRBfswqQ9gSTlKj0Jy6Rdwr80iF7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLgngKXn9J47QbiuPZ/jxdOxQiHqLUZzZZJQ2W6pQHM=;
 b=dwW9S4qLvnIY8WBxxhdn+cIBgoPKckPqEbOrrkKgQHdg8Q2nvztBmu2LjjovBxODMHW18vqsriskz4ewFqnXn3igZVR8RQf4sz3RigsfEGEJPPYsVMosJ0YO+iBXCC7yLAHFUpEbO+IqXqOZN0rCF8hO9djDX2UELalo5gVZeOw=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SJ0PR10MB4528.namprd10.prod.outlook.com (2603:10b6:a03:2d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 15:36:56 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8699.024; Tue, 20 May 2025
 15:36:56 +0000
Message-ID: <3689f24f-70d9-4a47-8b05-90b9efd15eef@oracle.com>
Date: Tue, 20 May 2025 11:36:54 -0400
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>
References: <5964b0f9-e422-46b9-bab1-04e699e2f5f6@oracle.com>
 <CAEemH2e7+2o=rM3sCoDVXgepjWessmtX9FOgHa15Ue7uFLwUSg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2e7+2o=rM3sCoDVXgepjWessmtX9FOgHa15Ue7uFLwUSg@mail.gmail.com>
X-ClientProxiedBy: CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::10) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SJ0PR10MB4528:EE_
X-MS-Office365-Filtering-Correlation-Id: a6347d27-d206-4344-8110-08dd97b4270f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWpBandrL2M1U1pWdEUvYWpzVHRQbXJJbDI0Vlo1R0FMUGlIMlBGalB6ZU42?=
 =?utf-8?B?c2VsQnR2aUxOMXdpQS90VDVIcmZQdEgzRXk4ams0RndybHBCU3VuQ1hHdGxs?=
 =?utf-8?B?RUpMS1RUaVNJWnFia2E3NzdkMld1VjVxSllTaUV2SDNUVmE0ZzNMOWl4M3JV?=
 =?utf-8?B?cVM1T28rUzhGQXg4cDVDS1NSaU9JQUp5dVR3VHlsblVObDNwcldOVzh1c1l1?=
 =?utf-8?B?bVU2VWRleU4zZEM5VkdwUXpBQlRPWXBxaWN1blVud1RRTE83bGRNMStZRGwv?=
 =?utf-8?B?OVhnL1N5WHpFa2Z5YzZqamUzOVFjWHBiMVpCd0h6c28wWC9tcWc5V2xTNFoy?=
 =?utf-8?B?aWpJY3dSbENoM2FSZTArblVJRkdmZGhySk1GSW9aZUd6STVLcHF4MTNJRnR6?=
 =?utf-8?B?aUhFcnA1bDNMYU04MS9VSUhKSEpwQXcyQzdhZzV6RHMvWDVmbTBwNHVOY09i?=
 =?utf-8?B?bjZMY3IreTMvaGpUbTN3eE9UanhCdUtqY21YSzJRY2lYTjBNYU1LcTd5bStM?=
 =?utf-8?B?WHpMSmRJUjZrSFlJRWwrZVpYeVhQbWFLRitqZ05pK3lWSG1jTEZFa3M5ZFZH?=
 =?utf-8?B?Q3pZMkVGNzRsQnRRcHZzNm5LUWRFL1hDV281UzdNN3BzSE1DS3NLVFdiUlRZ?=
 =?utf-8?B?OGZhVXd1WE81WG0vLzBwc3JnYnZxZEdHSkhnUHo0Q3YxZnlDa1EycXlRcnA3?=
 =?utf-8?B?dHh2UzcwREYrekErZ3JOb1gvK3dZZUtyWTdzeGU2aXkzZFROWTdDTTlvY3FK?=
 =?utf-8?B?Rjk2Wkpqc3hrWEN5aW5ObnpYeTNpUEk1K1l6S1FGVzZJcXVjeTg4QmNTdGds?=
 =?utf-8?B?aHJDWkZUaU1OM2xvZnEwVitDZlJXS2FQejZzdm02SnhSVGVYb3lmaFlXZmRm?=
 =?utf-8?B?Mm1WK3dlVDF6L09NMDFiNjZLUEorbzd0c1pySWtuNTBtWEFpU3puYnFJRHhP?=
 =?utf-8?B?SWt2ako4Z0tmZWlDOU5oaDVKdWNCcFNNODBCWG9zRXlIazdOcUJOR2dsYi9M?=
 =?utf-8?B?ekpJbTVMdTV1aE54RkpPWFVnNUp3MEx0eFk5WGZ5SmNMQXdFRTMzY3NIemc3?=
 =?utf-8?B?RnNLMDN3VHJJYmdZUjBPdjhISklRNzNuNVExdCs1a2FyOWxXWk5NZWZJWHlM?=
 =?utf-8?B?d0drbHF1ZmhGVnlnWXZid0tWY1pyT25uMHZHYW5Gc3FMTURtN3lWd1hiai9a?=
 =?utf-8?B?RHZvVXNibHNQUGNvQ2cyUXdPZzYyVWlrcGtZWUcvcmJCT0lhaTRjWFZlNmVP?=
 =?utf-8?B?WlpNRFYrNDA3cytIZlBOOWRidWowdVhEaFBsZU85WXdNSXRzbEJyUzVuUWNI?=
 =?utf-8?B?aVM5SzZiem5ubm93aDR0Q0Rxanh4azRhdmg0TTc4OW5TVmx2TlJlTy9jKzlr?=
 =?utf-8?B?Slh2S3YrV1hvdTJOdkxnRDNCeFBzdFB4cmdOK1BxQzBiN1oxK3p0NVpaQm15?=
 =?utf-8?B?cVNhQkc3a255eFhETjVsd2psT0NoL0Jmckdob3AxR3hub0NEZVplejhlVWJu?=
 =?utf-8?B?WnNRRkNNZ2p6Q3lXZTd0STJITVFRTTZKU1dpTXNESm1VOGJOdUdiUFNvcDhX?=
 =?utf-8?B?UGJoUXFSQ05NK3Q1dk1Dc3VMZWtHcnh3d0lGU1A2SVBXQWhicEUxaEFETmtm?=
 =?utf-8?B?eEQwWitKOUZIdUZXL3ZGYWUwbzVhcFJ1eGprd0dKTmtoRVN5OXhBL0xmZFpm?=
 =?utf-8?B?cXFkSjk3MjU2clhTRHppRHZsUndKMDhnWHI0cThsVDNnamlhdmxzRzNQQVVC?=
 =?utf-8?B?ODlRU3JsTUVFSk5FazgxNWIyUndFUCtIS0NDTnVMemtYVWEramtGU243VDJz?=
 =?utf-8?B?TXFhc2EraUNZd3dtVmI4QUZlcW85SEpDT1FCbnpVOEVnVDlscCtHblpNb0hX?=
 =?utf-8?B?OW5GQWlXZ2llRGZEVXMzOHh1ZHErVDlXUW9vT2VnMllrREVjclE3dW5xdGlZ?=
 =?utf-8?Q?N+6f4fonbsY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5134.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emx3dVRsN0ZoV2ZUREZLMUxIam1ueDVPQ2JlbDljaWdSTHpZZWs4T0ZQTDRv?=
 =?utf-8?B?QUN4Z21sNzc5bGhlQmYzbHJKTHRmVHArRGZYTWhZMDhKajRvRDY0NzI3WThY?=
 =?utf-8?B?S0pZdUNBOExJSlNjcmhPNEpnVEl2NmhJTGh5ODVodVBjN0ozTjNXcmg4OTVa?=
 =?utf-8?B?Wnk4U2J5d1lqdlM2YU53SENlbnBIYy9QUHFEUytkb1hXWlZIVE12ejUrYjBW?=
 =?utf-8?B?RWxoZGxTY1EwVTRuWXpVcFExdGIvb0FGTXB3TkNKTzRDbUZYK3Z1THlJM0lS?=
 =?utf-8?B?OTRHcGU4dEZTUlgxeVdPb3g5cjRXUXZYK09DWnpmclhqRDREVkx6ZU5HS2Zx?=
 =?utf-8?B?N3ZFNDdxbUxtMkVPYzh1WHcxQ0NDY0JVQXNwUFJHcE5XaGF6U1VDQy9BNUxn?=
 =?utf-8?B?a2lVRjQxMlJxZnRiMGxmZmJ1WEdGK1pPdnErZlpMbUVrVVUzazJjYTRqME5w?=
 =?utf-8?B?RFBZK04xOHRYTzVkUGdoNk9mN1N2N2hDUzZQQ0JkTForeTFucnExQVBxazJN?=
 =?utf-8?B?UGxEODBBeWRKQ3pzc0RRbTk5VW1wMlQ4UmV1bmRGUHdTQWhhdzZmNDlhS2FZ?=
 =?utf-8?B?NVIxdWQvZHAxWHpsS21sNW9jRmFqRVVmVURtRWRPYjdOMWd0d3RYTGF2VEtj?=
 =?utf-8?B?SjBEWWVkNjQ4Wm5HaTh6bTcrQjFDRkNTS1NDZ0wza2NLK0VwTW5ybGQ4M1BM?=
 =?utf-8?B?NVd5K2cvK0gvT0JwZzdObmg0S3d4NjRDM3QycDFKTUhGQnJCby9jYndvRkd0?=
 =?utf-8?B?MTY3RmVPVnd3R283RytlN2NVUzR6WVArUElDKzUva1Rnajl5OFJmR3d2ZzhD?=
 =?utf-8?B?VTkrOU9ZS0hiM3JNcnVxSTg4TWlUUjFveEdvTWx2cTlIMVFqT2IreUdZM2R6?=
 =?utf-8?B?dFpxWHFTSXJiTTZyc09OVTkxTnAwNURIcmp3bDZZbHRpTWJQcWZNOUF0d3Nm?=
 =?utf-8?B?c05SWWEzYUhRYzlQS1R3dXVNNXZoQUpCQnFjSkJ3b3FzSWFiVzJjVW5DSXhS?=
 =?utf-8?B?emx5eVFBa3dRY29lS2VjeThSVTZNQ2V2SWVUUDllVktMSmdBemxkdis3ZkR5?=
 =?utf-8?B?NnQydWNnTXpndnVXT3VxK1d5bzkrR0x6ZU96L1pjZWdKUVAvSlVxYzFnOTJE?=
 =?utf-8?B?U3BxMWRlcFhxMU5ZeEI0NXkrdi83aTVPSDJnWkg0UjJTMnR1R0RoUWJMZnBR?=
 =?utf-8?B?MXBOSFZYR2EzcC9palhzaFVZVWp0TVVVcWlpazZrSS8vYWlCdjFHaHJhQW5K?=
 =?utf-8?B?QUlKa2dCUDZXMElzU0g2djNub1JUSWZRZXRNMEtQNk1HU3IzTkk4U0lDeWk5?=
 =?utf-8?B?SVlMeHdoWnlxYk1rWFFiUXhjaThubzBlU3NhSHduK1lXK1VvZ1g1djZ5dStq?=
 =?utf-8?B?emt4RUFqNFN0alRqSFA2cWZEYkFqUEJkZ2R6S3FQUkZ4WFBiajFpeVZBT1Rs?=
 =?utf-8?B?RkhVb1N6SVlNWExDT0ZIUXV0VmoyOEd0MzZ4cFBQK1BJc09sTC9UdGdHNWc5?=
 =?utf-8?B?TFRqQnFteFc3U2FQMmJIQVAwS0VXQTNWQlYxVDdheWRpMHN6VVM3NlJ5Q2U5?=
 =?utf-8?B?cG9BZ0tSQWVGRjRReTBncWNQK0RKTXVWQXRyOWx0UTZrZkc0bG55VHFQR2po?=
 =?utf-8?B?M3BOYWtXdzNKSk9FM1N3Z1krUzBmVkpmaXN0MUdSL0VmbzYvdURWckthMHgw?=
 =?utf-8?B?WENRZWhnUUtqdjkwK3BjbE0rSUlPWEFLRy9NakJEQ2tiRG10T3F4QWJDWEFH?=
 =?utf-8?B?anBKQzkxWXJXSWtLVHQ5NWV2QnFDdzJBUFZ0S0QwbXcrQi93clRqcjBxUndV?=
 =?utf-8?B?RnF6SUlEMERuMU9FNlM4TVBYa1ZsVVVBV0dwRzNlZ3A0Q3phS045ZmRTVExm?=
 =?utf-8?B?QU44Q2dFZ21aamFBTkpHeHdUY1VpVVZWaURLejZxemVYcTh0VFlPcFRtaGxT?=
 =?utf-8?B?THlhSzZDeitaUkdLc1dCRTJzRnVrWU95K1R2WUd2R1VXeUJYTUFMeEZpSWNv?=
 =?utf-8?B?Q2ZWRVViSWlab0I4U0s4aXlmdElTb1FjaENCU1NGYWwzNDFTQm51cGU3cmhv?=
 =?utf-8?B?ZTZ5UDhFczgvWXBXOWRmd0FXY2tOcHlwZmh4WVVsRzkveEVRb2NyNFZSZEU5?=
 =?utf-8?B?Nmd0djBYTW8wMm84UTBOY2VGMmVxTTBGTVloVnpIU0Y0TWYrYmZFVEJ3N0Vh?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J/UFad1wgeI9aAUhvul7hVw86297d+rfAx1Yx5yrc4dzm6MpwIW4jBGSl3yua7QeTgiXsWqqjKeEZDu3wFANYdDdL/0Le7xDrrLaAcI6TWfueam1M3qmi19wBVVtMBlCx8lLPSMvmkUe060KxxW8pBq3A9Up5HwHi+K7MVXBFnOVqdx6M3MP5SWTrqVSNj3uvnZDXvSrisj/rEQxgsnDgIsjGwEf8mvwtFfUPg48ZhKnfAU3+f09STlsbU3P468zHbYwDXtA8dYswN/Mq1+BPs3WcG5fXKYLDqUnNrfw8c5EFauuc7nMxFXXHlmlsY35MYmafnUgQrRfPTln1ymkHIJEZ6LGukSBDks6ugHnHvYYAHtX0DhU25RX3rS0mSqMp7gWs2tMfuP+/2Q1MHIS2UysUPXAyuyP2u9WOY8jcy1xXnmwxF/+6i2dZ41QLmjctB/HPpyypoVuWCHFxbwWo3uZa9JxlfCwZjKaiUrp1XLIb/4qghuaCjOPKK4zhAkAwNYrN0drjFL5zhy5EPnYOMoUExSzyaMU8ButNxNIIKHwSUoGzxrrmvRCOMwPs4XMC93i15IfHP9gHKBHTeHywdXjEMSJRmwynBKbu/mGNL0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6347d27-d206-4344-8110-08dd97b4270f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:36:56.3076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAmaW6/P30uja624A+XmMrTtDBwP7QCkuuqJX18xM2wGp74H+CeP5Z3SJUXHnfJ1dq0MWq7LDjLwup0GnBbY0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4528
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200127
X-Authority-Analysis: v=2.4 cv=RbGQC0tv c=1 sm=1 tr=0 ts=682ca1a0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8
 a=8zEQWmsUa0Q2uV5PKV4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EvFUhVFu1lyMcvCB2gJhDUfbOpoa5vYz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyOCBTYWx0ZWRfX3AhzFIa768ar
 z6EQOeLCVtxeZRFLNk2mMVBdlYephU/OPaEvjTfoRWLM4C5fHHw7VrmHfJvqMxVWI3/AJ8hGiUu
 ZHOZTwEQnv/kQttq4Q5dQypJ3Ul1js3c70x8r7yRKFmZ/6z0/aEEoevbfOjACFvIw3u9oC46hH+
 UOSxYGfy/As3+/fle3Cev6f8JAbJY/mXTzHa4n+iARk8MZ3I8bbqCifkdOP+CT4Ae2uqnWFVNe0
 XU9MylB81bi1VJlhouM/KORseWBSzhAVQ1IDzA0zqelkto1CZ3nf3SKUrG3Wz/8aV+CesViElxq
 wAOhtvV5F1772+GdrqP7QL1g9Fd5cOQW80mEjdzFq2za9W+4bPO3WSWe5qRu/LNZO77pZBpWiH2
 QSBeHtDJWh9pB5iaY0VmejT+YDxJBO5Tm0W8/QCAdPlrmjd9fNogxSRI6GmEMZRs11K2R0bd
X-Proofpoint-GUID: EvFUhVFu1lyMcvCB2gJhDUfbOpoa5vYz
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] latest ltp not building on RHEL 9.6 ?
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
From: Chuck Lever via ltp <ltp@lists.linux.it>
Reply-To: Chuck Lever <chuck.lever@oracle.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gNS8xOS8yNSA4OjM4IFBNLCBMaSBXYW5nIHdyb3RlOgo+IE9uIFR1ZSwgTWF5IDIwLCAyMDI1
IGF0IDI6NDDigK9BTSBDaHVjayBMZXZlciB2aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+IHdy
b3RlOgo+Pgo+PiBIaSAtCj4+Cj4+IE15IGRhaWx5IENJIGJ1aWxkcyBsdHAgYW5kIHJ1bnMgaXQg
YWdhaW5zdCBteSBuZnNkLXRlc3RpbmcgYnJhbmNoLgo+PiBGb3IgdGhlIHBhc3Qgd2VlayBvciBz
bywgdGhlIGx0cCBidWlsZCBmYWlscyB3aXRoOgo+Pgo+PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20g
Y3ZlLTIwMTctMTY5MzkuYzoyODoKPj4gLi4vLi4vaW5jbHVkZS9sYXBpL3NjaGVkLmg6MTg6ODog
ZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhzdHJ1Y3Qgc2NoZWRfYXR0cuKAmQo+PiAgICAxOCB8
IHN0cnVjdCBzY2hlZF9hdHRyIHsKPj4gICAgICAgfCAgICAgICAgXn5+fn5+fn5+fgo+PiBJbiBm
aWxlIGluY2x1ZGVkIGZyb20gL3Vzci9pbmNsdWRlL2JpdHMvc2NoZWQuaDo2MCwKPj4gICAgICAg
ICAgICAgICAgICBmcm9tIC91c3IvaW5jbHVkZS9zY2hlZC5oOjQzLAo+PiAgICAgICAgICAgICAg
ICAgIGZyb20gLi4vLi4vaW5jbHVkZS9sYXBpL3NjaGVkLmg6MTAsCj4+ICAgICAgICAgICAgICAg
ICAgZnJvbSBjdmUtMjAxNy0xNjkzOS5jOjI4Ogo+PiAvdXNyL2luY2x1ZGUvbGludXgvc2NoZWQv
dHlwZXMuaDoxMDI6ODogbm90ZTogb3JpZ2luYWxseSBkZWZpbmVkIGhlcmUKPj4gICAxMDIgfCBz
dHJ1Y3Qgc2NoZWRfYXR0ciB7Cj4+ICAgICAgIHwgICAgICAgIF5+fn5+fn5+fn4KPj4KPj4gVGhl
IHRlc3QgcnVubmVyIGlzIGEgUkhFTCA5LjYgZ3Vlc3QuIEkgZG9uJ3Qgc2VlIGFueSByZWNlbnQg
Y2hhbmdlcyB0bwo+PiBsdHAgaW4gdGhpcyBhcmVhLCBzbyBwZXJoYXBzIDkuNiBtb2RpZmllZCAv
dXNyL2luY2x1ZGUvbGludXgvc2NoZWQuaCA/Cj4gCj4gSSBzYXcgdGhhdCBMVFAgaGFzIGFscmVh
ZHkgaGFuZGxlIHRoYXQgY29uZmxpY3QgaW4gbGFwaSBoZWFkZXIgZmlsZSwgaW4gY29tbWl0Cj4g
aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvY29tbWl0L2M0ODcwMGQ4
Y2RiZTZkMGQ3OGZkYTZlNmNjNjU4OTcyNDY0YjVjY2QKPiAKPiBDYW4geW91IHByb3ZpZGUgdGhl
IHZlcnNpb24gb2YgeW91ciBrZXJuZWwtaGVhZGVyIGFuZCBnbGliYz8KPiAKPiBlLmcuCj4gJCBy
cG0gLXFmIC91c3IvaW5jbHVkZS9saW51eC9zY2hlZC90eXBlcy5oCj4gCj4gJCBycG0gLXFmIC91
c3IvaW5jbHVkZS9iaXRzL3NjaGVkLmgKPiAKPiAKCkJ1aWxkaW5nIG9uIGEgc3RvY2sgOS42IGtl
cm5lbCBmYWlscyB0aGUgc2FtZSB3YXk6CgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gY3ZlLTIwMTct
MTY5MzkuYzoyODoKLi4vLi4vaW5jbHVkZS9sYXBpL3NjaGVkLmg6MTg6ODogZXJyb3I6IHJlZGVm
aW5pdGlvbiBvZiDigJhzdHJ1Y3Qgc2NoZWRfYXR0cuKAmQogICAxOCB8IHN0cnVjdCBzY2hlZF9h
dHRyIHsKICAgICAgfCAgICAgICAgXn5+fn5+fn5+fgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3Vz
ci9pbmNsdWRlL2JpdHMvc2NoZWQuaDo2MCwKICAgICAgICAgICAgICAgICBmcm9tIC91c3IvaW5j
bHVkZS9zY2hlZC5oOjQzLAogICAgICAgICAgICAgICAgIGZyb20gLi4vLi4vaW5jbHVkZS9sYXBp
L3NjaGVkLmg6MTAsCiAgICAgICAgICAgICAgICAgZnJvbSBjdmUtMjAxNy0xNjkzOS5jOjI4Ogov
dXNyL2luY2x1ZGUvbGludXgvc2NoZWQvdHlwZXMuaDoxMDI6ODogbm90ZTogb3JpZ2luYWxseSBk
ZWZpbmVkIGhlcmUKICAxMDIgfCBzdHJ1Y3Qgc2NoZWRfYXR0ciB7CiAgICAgIHwgICAgICAgIF5+
fn5+fn5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGN2ZS0yMDE3LTE2OTM5LmM6Mjg6Ci4uLy4u
L2luY2x1ZGUvbGFwaS9zY2hlZC5oOjM2OjE5OiBlcnJvcjogY29uZmxpY3RpbmcgdHlwZXMgZm9y
CuKAmHNjaGVkX3NldGF0dHLigJk7IGhhdmUg4oCYaW50KHBpZF90LCAgY29uc3Qgc3RydWN0IHNj
aGVkX2F0dHIgKiwgdW5zaWduZWQKaW50KeKAmSB7YWthIOKAmGludChpbnQsICBjb25zdCBzdHJ1
Y3Qgc2NoZWRfYXR0ciAqLCB1bnNpZ25lZCBpbnQp4oCZfQogICAzNiB8IHN0YXRpYyBpbmxpbmUg
aW50IHNjaGVkX3NldGF0dHIocGlkX3QgcGlkLCBjb25zdCBzdHJ1Y3QKc2NoZWRfYXR0ciAqYXR0
ciwKICAgICAgfCAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+CkluIGZpbGUgaW5jbHVk
ZWQgZnJvbSAvdXNyL2luY2x1ZGUvc2NoZWQuaDo0MywKICAgICAgICAgICAgICAgICBmcm9tIC4u
Ly4uL2luY2x1ZGUvbGFwaS9zY2hlZC5oOjEwLAogICAgICAgICAgICAgICAgIGZyb20gY3ZlLTIw
MTctMTY5MzkuYzoyODoKL3Vzci9pbmNsdWRlL2JpdHMvc2NoZWQuaDoxNDE6NTogbm90ZTogcHJl
dmlvdXMgZGVjbGFyYXRpb24gb2YK4oCYc2NoZWRfc2V0YXR0cuKAmSB3aXRoIHR5cGUg4oCYaW50
KHBpZF90LCAgc3RydWN0IHNjaGVkX2F0dHIgKiwgdW5zaWduZWQKaW50KeKAmSB7YWthIOKAmGlu
dChpbnQsICBzdHJ1Y3Qgc2NoZWRfYXR0ciAqLCB1bnNpZ25lZCBpbnQp4oCZfQogIDE0MSB8IGlu
dCBzY2hlZF9zZXRhdHRyIChwaWRfdCB0aWQsIHN0cnVjdCBzY2hlZF9hdHRyICphdHRyLCB1bnNp
Z25lZAppbnQgZmxhZ3MpCiAgICAgIHwgICAgIF5+fn5+fn5+fn5+fn4KSW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIGN2ZS0yMDE3LTE2OTM5LmM6Mjg6Ci4uLy4uL2luY2x1ZGUvbGFwaS9zY2hlZC5oOjQy
OjE5OiBlcnJvcjogY29uZmxpY3RpbmcgdHlwZXMgZm9yCuKAmHNjaGVkX2dldGF0dHLigJk7IGhh
dmUg4oCYaW50KHBpZF90LCAgc3RydWN0IHNjaGVkX2F0dHIgKiwgdW5zaWduZWQgaW50LAp1bnNp
Z25lZCBpbnQp4oCZIHtha2Eg4oCYaW50KGludCwgIHN0cnVjdCBzY2hlZF9hdHRyICosIHVuc2ln
bmVkIGludCwKdW5zaWduZWQgaW50KeKAmX0KICAgNDIgfCBzdGF0aWMgaW5saW5lIGludCBzY2hl
ZF9nZXRhdHRyKHBpZF90IHBpZCwgc3RydWN0IHNjaGVkX2F0dHIgKmF0dHIsCiAgICAgIHwgICAg
ICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3Vzci9p
bmNsdWRlL3NjaGVkLmg6NDMsCiAgICAgICAgICAgICAgICAgZnJvbSAuLi8uLi9pbmNsdWRlL2xh
cGkvc2NoZWQuaDoxMCwKICAgICAgICAgICAgICAgICBmcm9tIGN2ZS0yMDE3LTE2OTM5LmM6Mjg6
Ci91c3IvaW5jbHVkZS9iaXRzL3NjaGVkLmg6MTQ2OjU6IG5vdGU6IHByZXZpb3VzIGRlY2xhcmF0
aW9uIG9mCuKAmHNjaGVkX2dldGF0dHLigJkgd2l0aCB0eXBlIOKAmGludChwaWRfdCwgIHN0cnVj
dCBzY2hlZF9hdHRyICosIHVuc2lnbmVkCmludCwgIHVuc2lnbmVkIGludCnigJkge2FrYSDigJhp
bnQoaW50LCAgc3RydWN0IHNjaGVkX2F0dHIgKiwgdW5zaWduZWQgaW50LAp1bnNpZ25lZCBpbnQp
4oCZfQogIDE0NiB8IGludCBzY2hlZF9nZXRhdHRyIChwaWRfdCB0aWQsIHN0cnVjdCBzY2hlZF9h
dHRyICphdHRyLCB1bnNpZ25lZAppbnQgc2l6ZSwKICAgICAgfCAgICAgXn5+fn5+fn5+fn5+fgpn
bWFrZVsyXTogKioqIFsuLi8uLi9pbmNsdWRlL21rL3J1bGVzLm1rOjQ1OiBjdmUtMjAxNy0xNjkz
OV0gRXJyb3IgMQpnbWFrZVsyXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4K
Z21ha2VbMV06ICoqKiBbLi4vaW5jbHVkZS9tay9nZW5lcmljX3RydW5rX3RhcmdldC5pbmM6MTA4
OiBhbGxdIEVycm9yIDIKZ21ha2U6ICoqKiBbTWFrZWZpbGU6ODU6IHRlc3RjYXNlcy1hbGxdIEVy
cm9yIDIKZ21ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCgoKKHRoZSBz
Y2hlZF97c2V0LGdldH1hdHRyIGZhaWx1cmVzIGFsc28gb2NjdXJyZWQgYmVmb3JlLCBJIGluY2x1
ZGVkIGp1c3QKdGhlIGZpcnN0IGVycm9yIGluIHRoZSBpbml0aWFsIHJlcG9ydCBmb3IgYnJldml0
eSkuCgotLSAKQ2h1Y2sgTGV2ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
