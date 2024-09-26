Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1771BCDE006
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727358133; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=96TM0hG0gsSSsT9vg7r1scEjY0g03ce1tg1Bjzx33xU=;
 b=NWi3H2dPcQ84owgkcfXN6FeYkbHMxMnoezqg3/vqOksDkvXJcHb5XSj8BEcS3zPOtFjnm
 wvk4qw2Cd1Y+W3SzZtRrD9AiVlBNnIcZGgB8LsTcS6VIx4VvcsKDg5Oar+itMRoEquJWBcO
 P+ZDXSKTM+BS56YmdRtnRxnwz2ydgzk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FB3D3C4EEC
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 15:42:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23F913C078E
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 15:41:52 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 23A651001F50
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 15:41:50 +0200 (CEST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QAfC2o020012;
 Thu, 26 Sep 2024 13:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 date:from:to:cc:subject:message-id:references:content-type
 :in-reply-to:mime-version; s=corp-2023-11-20; bh=O2a2ykGsnT5d8xt
 n16tI9mA8yCaa3YsxjySuHi4zRjg=; b=PzvdamaFnBhHz2aco3sdE/0yMuHmYuy
 oxslpdh65vuN9FSm8MWc6NqOIQgRnohkDg982eQK5EAI+lmZBDMCrjHWn93B3ofY
 2K+mPZ1hcnahp7FsSdsFfiYQ7NDS69z23B6R7+D6Qv0WE0V7L4eqYUoZfZxv4yuV
 DJyJvqY5dps+c24yMwzDQo/NW5zX8q1u207eBxgbnhuaIDP8rP76RmlSGDpH/J+E
 zTZJNIATqeBppg5aQsvWcF4PwgKRfEcZAcOfyfRFKEy6yeI6AZU7AzujMfy5sS6v
 P6Uyo0dCThoBBatnpH4no+5o7xr7dM2QFL1GdLhYtjUxsHskb2DaoTw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smjdajtg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2024 13:41:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48QD7V9s033000; Thu, 26 Sep 2024 13:41:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41smkjev1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2024 13:41:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0MhHLXMIBZI7uEh5xADPd6nDQ24+aTtkKIqelCiqYeDuOlTSFJAsGd3WDj20J30H73L0djh5daU9KVYOzHU1mc2Cq/7qo9Qh59qkqTRuQHh8LcFLAK2Wpu5qMBchcdxeBnDD4Bl7pw2kl1j0Ppr1eLxZGbtgk3Up5TDMaOJoCNl2fodOfFTxi0RL3Eun0XHpSGAjpAMaaxsJUGXnqZ+goMkhDTVHnFLbr60LyaGU8vdRZplAlzvQX/1wFpkgQDXpfd0IZ7nqEpsuqqGBBRKP672MKKSy9sLea+AwtJoQpB6lnkMFB7xhWT/g+243J+Z8yEs+QFaheJJoAdV/HNfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2a2ykGsnT5d8xtn16tI9mA8yCaa3YsxjySuHi4zRjg=;
 b=BQgR0Zpa6agFof67zB49Xy1MA/DEJz4Yvj3N4on+nYn/+oX66NiTRufRhKrro7FZ6/UbddZyqHgyP/7mMnGdTRCaiDyEWJomrj2zghnRXqILWFmvZiQMGylqowHivIFQ937QqosGhJxPZzHhvSysNE6Ws9xQrFfq64VueGGxsTFcPPbjFD7st9Wx9VPL0zUku/3VWNl4O/WRGP0Q6RNUabJ9vAMEEfXhUOWFvVyhNkFIesCbFD/8IDrK+wt3+aVVU0qcraCavh+cBvYIiif6KjPbk5HjICw/3YZ3Zj8qKbI9jfKYiYAWy5ISD7jZykNuL3UOdq4ZNq8x03Tp8/x/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2a2ykGsnT5d8xtn16tI9mA8yCaa3YsxjySuHi4zRjg=;
 b=dvoSeVLi4NsB6UwBhhqZeZCXmVzcJ5NJkUco1UWL5xz89S5eocJy0Bsu23vcPeSQ386AC5SgJvl3ZDn6OVVZlmr/b1a2eNNCw8P8LZj+muKv+lxQJk1AgKrq1NduaL29lc2E4H0P22fwVR/eTcxTtG8V4xA6RD5NVOt34f1eQqs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6061.namprd10.prod.outlook.com (2603:10b6:8:b5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.10; Thu, 26 Sep 2024 13:41:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.005; Thu, 26 Sep 2024
 13:41:44 +0000
Date: Thu, 26 Sep 2024 09:41:41 -0400
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <ZvVklazV8ZF4xE1k@tissot.1015granger.net>
References: <20240926041358.951923-1-maxj.fnst@fujitsu.com>
Content-Disposition: inline
In-Reply-To: <20240926041358.951923-1-maxj.fnst@fujitsu.com>
X-ClientProxiedBy: CH0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: e21c4990-c156-4da6-12b7-08dcde30f574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sFVYGv9ULEhq98CZLx91u8EY8BCto+ZOwk3w4DbNJ0I4WWSOcoLjISWRVQf8?=
 =?us-ascii?Q?Pl3e2o8T9W4+WinYlCoZ5ebLWBARrBl3/9LoxSTpD4uBLWGl7pwoJTX7SnES?=
 =?us-ascii?Q?Pu4FWUDdakY/ft+qGZQHfSAIvcr7U0qs9z6HDhLhz+0vJWXEaV4exhSj2rqy?=
 =?us-ascii?Q?pG3GL3dW169OFbMG9qu3ndL22iLFMMP0iUp3qs8ukGs4YmMuYhyI77ghvDox?=
 =?us-ascii?Q?t476EPRc4VziIO6d93HuX3IOo4MbmtMtBCMNuYDvqT/0QjFolJU/ZwLySjhh?=
 =?us-ascii?Q?kqJ078xOk9c8YQoK9fyzpEWuu1RRjRajdCbYD5tuTiQ2WjFWO4Z7mDLU9yFb?=
 =?us-ascii?Q?Jc5be9TzKaxtEFNembP9zHoSczPFrg40zC2hOX8X4GwdTVNnhxwOs6wZqZWb?=
 =?us-ascii?Q?Ps3qFST74lEAcHw2ES6Xtj/CNYcHlyBXhE0/gj8kyXIH4F2cGgSEXgJy+R1o?=
 =?us-ascii?Q?Xi6F7eaRc8wnsAPLRfh/0vV/EWYF4vJ1mla8A/4CacUrzk8ax8Y0qe4bqAz8?=
 =?us-ascii?Q?9jvfPeWxLLlg/gJ5rk5n6YnvEZ07N91i3pM/iKSeTZJXY0A1kzqlLj08OCCs?=
 =?us-ascii?Q?iA6aJy9x3sW3xGBe+UXXe2JrZVVAc4IDeLeAQT2S/7VuVayJVuESAIwd2LvM?=
 =?us-ascii?Q?8s9w4zUXG/NkW3xrvkapGFzZ9IAFH39z8G67ajdr4NsxVrBazlX+i0V6JvG9?=
 =?us-ascii?Q?XsV5r2glz48az7QNoe8CvKoykiJpBmHLmAmF3TGsYoDESrCK+gxyAkepu3Yc?=
 =?us-ascii?Q?gQyQrRMWpWXUEkdMqcCHZbVCkyuP1Fl7IwrJVQE4ZYbISNl6qjAzMyrOmtC/?=
 =?us-ascii?Q?nOggQElmS1pXNY3n7ePPjDILhDSQnYtDvNKcW6ez8Selv9a8BmfwMw0GO65Z?=
 =?us-ascii?Q?TvY0I13fg1cs01OlWK9wwyA5eaRwjsjh315ickwci4YWkQ9qNcdkXfBjcSnH?=
 =?us-ascii?Q?jx/E6wuuCHwsM2qCsnJHjhMcSe89qCDC7D8iTAsHTWlOhuYrxIC6LbphH7jl?=
 =?us-ascii?Q?FWin2itLK3dznZfNcXDpKbk+Z/VD9olBf/cEx0MGfX9Gqt8WMrOhJCbNH9AP?=
 =?us-ascii?Q?B2p66qT8hc7nfGJI88RY0z11iBrv3t9TBCvEuaawtE9hqxqUtwrWzbzqAzls?=
 =?us-ascii?Q?Usf2wGQdHtV4ImlzUAn3NioNm/rYat92VxUDsuEkjNpVTs8o/fZSWjYADsRf?=
 =?us-ascii?Q?21XvDwrORcOd/0JSV3mcTyE9JQr73LhtGPpuVGk2APgG9hQn/sFIVQXqPGq2?=
 =?us-ascii?Q?QtKScN6w+k6Vulkk5fznV4Worz2jYIP8dU3s7Sno0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IB3zYV5BFy/tNmWfaz+aXKjh16FhHNYrlIMbDD94IF1VFZD7fen9IYdCqFeQ?=
 =?us-ascii?Q?ybXlZczwaACLJuYrcHo9X9uflfBhonP1b8sEFohm1IIqhj78fO8vhpcyf0O2?=
 =?us-ascii?Q?v8wNtwaGAUfidBA6I6uYxiRGcxyMgFjwZQckYGvhuwlxrrx9Dxl2PXNhycoK?=
 =?us-ascii?Q?hTqnzdLxR++ChfxXaVwYvrci3UclzCHiM6foDMfDmsLe1lJDWSdiFcEtcCC0?=
 =?us-ascii?Q?/9pIRMpDyMARbQEs/Imil9j4jK/8u5d/7x5QtWJV54e3vN7AqVDtA2rYZA06?=
 =?us-ascii?Q?2HadtPDCmcGu7/o8nkYhzSgVc5Nl9tK0BhkF1AkXES+pNAI2l/klUuqFB80r?=
 =?us-ascii?Q?os/FcZarfM6Mu0uS0bqrfk8JH3Aa8AL0JCPj9bOG/JlcDkIMX7Kgq10Un3Kn?=
 =?us-ascii?Q?hFWZWBGlpzTSD6/Rn2p23YbhMdTs5whTtV8ydwlm/Eldwg+oaoIPwKmtm8HK?=
 =?us-ascii?Q?mz0B9rteJpLfYvroLiHV7oWSQWOVqK7s7TVmzt1SahnYkACTXUMVp22fQupF?=
 =?us-ascii?Q?KFlwJLvXMyRGd/m23ooIZgorSnZ3mu/viZ1denCR5aWntUzfbwwpHXNZOkjP?=
 =?us-ascii?Q?WsHZ3oKUMVH8zJCeLvsvhWeUbcJMHy/Cjbmh1W34xlu9kkAPxOm5pSf2yACR?=
 =?us-ascii?Q?J2mBLSJz+5Nzdwg6zcmekxX+62X8ag8fbJCy7dazSt59Plcg/XUYGmT4v0Fk?=
 =?us-ascii?Q?HZlUQDU1y6wwLEn7R2XqMUFS5FOvYZOkYFo/gHiU7rE96gF+39snTOEqrtJZ?=
 =?us-ascii?Q?gPmxYMFBD8t+JEMs6cLf6skZBLdQM3vDvjlVG9HZ4YcSp9zpciky+mWpmUlU?=
 =?us-ascii?Q?giRAw/bMEppZ9n6p0TM9lyWgvaOm8OdYyWNUaTsGg/32eJhA/ReiG7uoARGb?=
 =?us-ascii?Q?K64fiM1WMhKNHj8fLDIPIP8XWct1MKAMwEyszgwuGFvt4mUbmd7AxXrT+mw6?=
 =?us-ascii?Q?ZuG6wWVYdXO/UQclSESSkX1dyCkCm+M1cHDSQfpZ267D6xcLCWlcAPOpMIxk?=
 =?us-ascii?Q?dYhs0+7xFUKWjCL+XLXQ92ASbyUBk5SLib97ckwkY/3nDHieIX1ZCPKKKaqQ?=
 =?us-ascii?Q?f7qBO427Gd8BUb1/cky7v0shf+BOIYvwgyTaVwC9L5i/z35LLoNCPeYkrHgJ?=
 =?us-ascii?Q?e0tzm4T9e3CTrP4+JhezPgHj9ez7UboGevUVBV19UY776Sakmp6cimTn9S4z?=
 =?us-ascii?Q?biIafPAmDAX/lTBkHi+EW5YwyfQgN00R8od8BQinoOjnpaxUCHVoGMZc49uS?=
 =?us-ascii?Q?u9/nkI2paXv8wO6h7lLBneaGOj03QJhoH3M9U3jJtlw/cMLDdt/I27U0zHF8?=
 =?us-ascii?Q?NFeh+jmwbD6QXDyOEM/FE7A2MWBq2I4CnNZZuA2eQucGeiCHv9fbox6QRN5H?=
 =?us-ascii?Q?xkiiUtW89m0UkB0UnAduzAZDtGxOhMk1iReIy7Ulh5rgP2Wx/fH+SfwY/HNZ?=
 =?us-ascii?Q?V1+EvbMx9khjlPVg7Xe1J2+HJ8BKZPYV0Zq0HupOM6Nxbcm8XZS7ivmz+CUd?=
 =?us-ascii?Q?E+DgfBEGHEe1GaiqosWuLhPTQBvlEapCtbLdaPw3gDRUiFAaHh01+w7KJT3b?=
 =?us-ascii?Q?1d8n/+RTC6hs3yYewSU8oFIBORQqyRW+5OahyDpS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xApqKgfzDtGZ97XLY0+5ohFIxjJtwvzUMc1r88+zetbGIeuJKu/Mg8VfCmPwuJxaDN2VSpzMLd7kfRN4P5qtxvfugdFwohQlFtoA+b/OMTrqY5ZPdat6QrlAxQAb6F49u1vdO5WIkQK2bHmjYTbFYWyFWTkJZi20+1Rnwc2pgSK2RN07WhiKTcbZA2C2i48UQmDZrNPFxyMzjmwz4mEUP2fK6AkqwOP6Q/7D6ro+4k/dT4SQGeic5k2PttKE9VjL15GorOirN9M/8WCFEmNgQE+6hwLaEQye9st84NjEPSs0hU83Q2d9bEbLe9Duh1vGtbH4HCRIWUZwy358cMrK8BqAOD19eDOsFQ/aK8g3teM7bH6G/DS4Wn8o36j5Q0OJmWlmHD+uPusB5+oVc9T1NTx8La30/fV5IqNEdFCTwQlt69xMqm78mcgUt8ZilPjI4yq679LpQlOxTSPVzqOaxFitKePLSl8H5jxX0+pU8PkbonYfOJU39+lOHw/AtnRw0jR5fEIBwlq2wk+f6QokwC+fd6tmR7ldJ3gRU0bS6DAOsHBLmWudBxpOtEyjUaTxqYFcN5/7ELnZNZeyKTYeKpFhUuP6z7WnezyEyy5sKbI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21c4990-c156-4da6-12b7-08dcde30f574
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 13:41:43.9473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1vFO+I9l2hufLo2UoVhDlrmAEd13vU/3FpjIhfSZ5c5xvYsvVlUY7KSZMlp91JDvsMsqi33zQ6PvelCGQ9F1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409260094
X-Proofpoint-ORIG-GUID: KQVKSgUNKx5KcTHntzadPva6G1lxGpXn
X-Proofpoint-GUID: KQVKSgUNKx5KcTHntzadPva6G1lxGpXn
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tirpc_clnt_destroy: Determine the return value of
 clnt_create()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Sep 26, 2024 at 12:13:58PM +0800, Ma Xinjian wrote:
> Determine the return value of clnt_create() to avoid segmentation fault
> when executing clnt_destroy() when the return value of create is NULL.
> 
> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>  .../tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c
> index 939ff3e4a..bb9a47503 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c
> @@ -58,6 +58,13 @@ int main(int argn, char *argc[])
>  	//first create client
>  	clnt = clnt_create(argc[1], progNum, VERSNUM, nettype);
>  
> +	if (clnt == NULL) {
> +		clnt_pcreateerror("err");
> +		printf("%d\n", rpc_createerr.cf_stat);
> +
> +		return 1;
> +	}
> +
>  	//then call destroy macro
>  	clnt_destroy(clnt);
>  
> -- 
> 2.42.0
> 

That's the basic idea. And then apply the same fix to other tests
that call the clnt_create(3) APIs.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
