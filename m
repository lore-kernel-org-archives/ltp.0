Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C6DCA0EDC
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 18:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725041640; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4EkmqwwlZbNiQuEe3Bd1HAIc9El8gjQoEtszRycP4go=;
 b=o4BmCEMwJqxZJERdTkp4yrgFgL3mopHc8DMui0eulwBQeZedklLJ5y5A/KSJsbszcSk84
 cBPj1g4zRCaR6xNxhfnpds4dsNe4KudNTRqMbkhsxrJsKHsxUA5a/lGqjPLC1i/TmgyiIoc
 9pZJY2gDZ3+syW1qfv64U1n+9wBjGjo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E78773D289A
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 20:14:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA5F03D1D6B
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 20:13:39 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 331EA617633
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 20:13:36 +0200 (CEST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UI0jgD013025;
 Fri, 30 Aug 2024 18:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 date:from:to:cc:subject:message-id:references:content-type
 :in-reply-to:mime-version; s=corp-2023-11-20; bh=NNMFPX5rO+4TspR
 lsDRXM3nPouPVOrV2XYzfUntTJ+k=; b=iwUSI4FQ2PstMRKkZnDq+y9C5fUbfId
 9+ruSw6aagwJsZojYiI9CNM63/4qC+FBGFbYejoct5AbkcZHPPEBho6P60O/3rfG
 7Da1B/oB22ag5/GmiAM5HPJPz0sbcAIls0nxwG76X15+Fi1s+iqj0LvpvleSWDbG
 dAAQeD1PtnRnk7pviN2xska/Vr+tQGeqaBy6Tbj4tRkgbAT5E064FaOVfvDWuiya
 OnhqRY+nPegWiNYgEGb5YmYf5QM39g0ha8TDFi4tqwMw0RgLsWeVEhZptdsYLW39
 tlZKVn3g4Oap9OaLJWHQeZrx5QGI5HzHpxLM/3FF4mHAKggP34BSAHw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bgf78c2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 18:13:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47UHCuHN034715; Fri, 30 Aug 2024 18:11:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4189sxqdj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 18:11:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESpj/1p8gGexAyALxaEKo7luOvDu/WR7NswnNncDF+0uh9BhyBJcAXJBqAjqQLOQaDOPtiTMPb/uLQkMMG8mqIChrnMXMpMlinMF4dW8mO0GBNU+pYR1RrGHFsjU+cn7VkFEetg1B56Aosq5+bBU9SPryeUCNbatJUqwHjKmYiZjPmP3XhcBR9xJVh+vrFC7EuvPhonTaslWteoPZLDo0AiwIsfz6eA6EFcMSuCGhJHCD+52PcSIu5DLK2WKWyNERIiX1e5IUbLF2Wff0xrM2CTbWuai6zFtM7Spjy8qnbYsvqTj1IDJNwXrVb/bd99G2KEE+eEsMcA1Dgn1DPJhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNMFPX5rO+4TspRlsDRXM3nPouPVOrV2XYzfUntTJ+k=;
 b=pEe9YLuFreo1aA1NmDdpn2FBbiMuyHOmINhTTrdv4TdP/K1unkkzubWFckKfzGo4ung6q5SxeD36Tdup+vi1Zzi6IJG33wSBQ1W34rFxkt7101OxAlyWL21GH5GV9ufgvEQoP4P/sTw2V/e50+KXNiWu1Lco9rkipc954E5Qpfv1+Sq1uT+J6dZuRG7lumDm2s934Yg0FxtU/Otp5gGLDwxmuyTsqIer3pR3pU35xu5kDVCgnag2E3nNDtezMkzO73L3BEokAnb/alkOlvqkYZQv4hmRVyKKx6Q5vPjxl9udkofNsRDSJmiKuGtXbmOBWTIEns4q6K/zlNpsDa2hkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNMFPX5rO+4TspRlsDRXM3nPouPVOrV2XYzfUntTJ+k=;
 b=D5DRtnISIBsNgqPOrSROeYGoHs+QzQUFcoPPw/W5AOcANN5R9pW0/ZVsySPWiGCieiJokvtqOliqo1LmeH3w9alCjF9XUocC2QaFMBJP7k5zhNs5NoA1OtClzwWOlWBNmlS1YbDdvMobojmO9Q1uPkyjxI+DRSbPLfh01/Xp6Hs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6695.namprd10.prod.outlook.com (2603:10b6:8:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 18:10:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Fri, 30 Aug 2024
 18:10:57 +0000
Date: Fri, 30 Aug 2024 14:10:54 -0400
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZtILLtHSahuwDiZq@tissot.1015granger.net>
References: <20240830141453.28379-1-mdoucha@suse.cz>
 <20240830141453.28379-2-mdoucha@suse.cz>
Content-Disposition: inline
In-Reply-To: <20240830141453.28379-2-mdoucha@suse.cz>
X-ClientProxiedBy: CH2PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:59::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: d977b1f8-7668-42c7-2e94-08dcc91f1888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MMLfONfqT0CP6C+844bS63ifUveCUu0lYTBhg6s7QmhSf2oQB+PfEx1JxlSC?=
 =?us-ascii?Q?tq3Dfl8oarGW0CbB27kOGyj3qHCwQ6OirGwR9NFbTzgkykVgx3hk4lPO3UxP?=
 =?us-ascii?Q?xq8m6TiR9CsVNOn5EDCiUAdOKC3xqj5YE8KSufcat4yx22Dbk6+iUbxCW0HR?=
 =?us-ascii?Q?RHim21mPHggEX10bCjFQnMgR8WNsJsiyFUFa/QXVVGUBWaz5sE2JorHYxFZW?=
 =?us-ascii?Q?rzMgx1O543vNmVAKWsZmc3WEfEkJP5q3CF5WKi9qVFmJ3ZYSCWKt3U7DvXyw?=
 =?us-ascii?Q?nl1Chx2FBCu/bWdMubUGTRheVy7+LTswGy2e2syyNr+DZX8vNMaOdxXxA3a2?=
 =?us-ascii?Q?3FcOIsvp4/YEku+Td0JTIJNMLFezeVVFm6NG/vgeQrYwIpRnzf+vVJNQgbNX?=
 =?us-ascii?Q?iGHL7oNxKKvtdZiELJyHQQY7/Abo4pcL6XhDasCofOucV73C7DlJnjBnEsZX?=
 =?us-ascii?Q?uRlRcPcn/279YWeu3Cj/dOWCrSCGrH4WoDuZvxP9PlrzmPA2M/pkFc63GvJP?=
 =?us-ascii?Q?hQ/1EL2fWuNDZmO6HeRvs0h5pkCDPi3Wz34/MYx2tGaFtfyawteq81YwANjg?=
 =?us-ascii?Q?wU07poFvrXRG6bpm7lgSr81ojALcAVWUhJKdJCC9/ja6WMEDH/RtcvWEsK+P?=
 =?us-ascii?Q?RZE9OrN5meSdLSLPnBsiwGTnkK87gEKVvfd4qXYy50S2xinkgcNmjaElsIG2?=
 =?us-ascii?Q?I9EK2imJlqoyzTurq9OxjUKXIQe+URlPVPAryg9+QGN/EDozpRw7YSkc3Z39?=
 =?us-ascii?Q?63Yfbr633QMP04BRzJcYyCu1RRV48uyzpEfJ19UAj9A7DoE391BoXcl3sC7g?=
 =?us-ascii?Q?Ivzljmk/uzjHTaRMlXaAM1I9vLUSpAjoAfzKnT6sZzM+cThtxQXQvaXntz6T?=
 =?us-ascii?Q?2oQeYd6Vc6sQEk+hqweSnrW3Hcdqq28ObigHXSMM4Yj+zWTYf081A8fOgwWU?=
 =?us-ascii?Q?oe3FJ8eRKKALOJ6nCBBHCUgNGr5P17Z2RYku1P+TtIFpKMoO3vHCV7hs//ys?=
 =?us-ascii?Q?VVR2BznkCJxIgIWbL89tHKF5HYx7M23YE2HsZaSmTXBfJVDAl1u5dyQ/tlGZ?=
 =?us-ascii?Q?l+BIwAUe4BhRythRqxzf9o0AHZ0vJf7qYQSqxB2gOU3WV1HNpOcdE+EwWFf5?=
 =?us-ascii?Q?NVn6YRqdt0fgor3VbTKgIoscgb/Sf2aajPA0dxt2g2zGaxKApgZRcGEDYv0O?=
 =?us-ascii?Q?SLrx654sMhmq/QSeI18rZyo7KOexsvAFmhQsj14aTeH6ux38f+NwoqnUyCai?=
 =?us-ascii?Q?tiNYnOC+AeW+1Hvaj/IxTaIGvhemOocqQMpWxVoQ+uGzNMw0gj60AS2QE1s3?=
 =?us-ascii?Q?D8m6cIZnvPYmPDs+G6fg3lA+GzBL8jE4DYh8GuVm3S+pPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ss3MYoQHPHCEjlqiQ5+BaY5cz0TZza4EXq25U/N0OgDvs6pawO38UqKWvKTn?=
 =?us-ascii?Q?M24ZhiRViaVLbdIy58KxvdQt8/DdD0nEUXSun4kEqh5CAIrU8NdrfvbZHqVY?=
 =?us-ascii?Q?EMyROb9L5Wwg0GHPsn2F8VNa2lraENi2ET/VVTxNLFyALJcoQduGafEMoc9W?=
 =?us-ascii?Q?qTQ4BBBaH0WeuT66D8y48K4J4TK51vlX2T9K9oRTKpcevMSsujIK8DBZuQRI?=
 =?us-ascii?Q?iZuw0vi+MDQilSeEbWf4hOI+A3RSQA/j8dKgp9XnT1LaILeLGMj28gKga69k?=
 =?us-ascii?Q?vM3uzz2YQ0WNTjzkuJ63gAgy4vyIlRm3VOvc80NuhNLpApWB+yyUO57sYNL7?=
 =?us-ascii?Q?Nt2jSouo2Y2OJie5AlivzWchVlYQ/E0l4mFWi/zuZIcWCZ6tCek1+Im2bsCo?=
 =?us-ascii?Q?I74AOMGlKOaQRj2vtwxtywis+RSUmFJbpznYTPgmIDbhU+uftpojTJD3LZDR?=
 =?us-ascii?Q?5MHS2TKDu3Q9GzgIlchFyXAhH8tTg9Lw5wE3hkU2RJCHpGcIo7INBvj1o7IW?=
 =?us-ascii?Q?R1nj3jk786Kfhaw/Aw84Ogx297tXor1PnFYOmVxm1E4bT0uqmhfBvXojmaT9?=
 =?us-ascii?Q?Nui1eVxorNdiyU0lGJMxA0n/AiRe7FaYygr2n2VhOtkmyCbNsHhdotJRXgxp?=
 =?us-ascii?Q?v5Ihjn4lnEen2wbmvoG6L4exzQGavlwHXbrnYi+WDRK/X9JtXR/hchiypRUq?=
 =?us-ascii?Q?kdsW9WdvGbysOV3gW5WSyocFHE0c8umR6VMSRfBKbMFWxSg6NFilpaT/fYJ9?=
 =?us-ascii?Q?o7veCf6zegtJjL6g+hCBHH4ja20zIhNkJet43KkRKq0K0ZbMkGV7wh3+oGaO?=
 =?us-ascii?Q?y1UoDqTfitLohcsRLx0BBIepAUSbpBIhuMQsOJxhxFRc2ubqfFDrkr4G3cWi?=
 =?us-ascii?Q?42B0RHxF+UyDuMX1KnVSsKzZlHsaQFVvr4qCx16YjoB1h9cUzcPnbLBBsJCs?=
 =?us-ascii?Q?PqlcPufW/NOEC91WaiIhkrlq+2/GZh3nrrFa4EYqRmEs6PAlb3i1eLzK7YeD?=
 =?us-ascii?Q?vzBr54SHPZYuPEKTMKMeKxuIeLBEGkNBjjgnYyNHC+gUQDOUOBVctDZMEbR8?=
 =?us-ascii?Q?SxeYSCZL8X6avuuVJ/xj459auOlMjwK8aqNjEinpi+lsulJa9AEHUjLGwQhI?=
 =?us-ascii?Q?u+0SBEVaIC0gt19r9c2tSO87f+77HktnbvMN4VJkTg+TyqvkMov/QeqW4W9s?=
 =?us-ascii?Q?A0s4nJLIlof3syS25gaxyj7TWwb3HoNj9Ry9n0rSUcKjBAS+TtjV9QrU6Gb1?=
 =?us-ascii?Q?0Fp40WK7x9Uju3G9H4GM9kPjd7hfWOd9FRgBWIsnlzVx42vIH/Tc/OFT6iOT?=
 =?us-ascii?Q?UNBMgY0OmefsI8cAnNUAlk9E29pk++rIbzvW7WrdscGwFVvlpBtw5lNVw/45?=
 =?us-ascii?Q?kX6Xkn4sS310GdEK720TSyXFNXnjv1h2uZ/fPTXgcgC9ZDcw0G41M0YlwupD?=
 =?us-ascii?Q?X6bkqWoYj1KPP1AQQpF+JvtVbV9xz4G7tTss3A6CmgZwrL2y+N4s+ZzOzD6w?=
 =?us-ascii?Q?hpp4ah9Wx8bWCB5BMseiykcFycEKL7MbYK9Le8JRQVG0s/vzUq+R5faz2dp0?=
 =?us-ascii?Q?8dDxS95NGbKCf3ejrD9YiTnkbUd1CeGNpTCyccAMH23ImG+y9j9qOi4c55z8?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lmqFcASPt7l5Nut9AqSSXSImtm210mB322Y80OSsjVU/eLVZi6cZoqFkhE33mmHmZIbrJBe2Rwdy8PuvdVSgtiiZwAsrxtz1f0JsbKVMGpEZOg9IYszJ1aR3bOUs0Qw0mMrOL47uHdoFrKXsuOKdRfIj7rtORsZT1jvDm4iwmFGb85X27tHIEQHienJ4saGFkIxPmVKk5e+5MzlPyrzuIRLrwa5golmNg3gpZBfz6LnwZOWleSwFHIP/tQDx+Yc6sLyjpPkYjyqH692VFIOELpInh0w5MXWhe8VHo9CL+4teIXFNaTNJoRbJCbLjwfDgXMbjXsUZTvZOFl8a/7Bu1Aq9KWpCZvM33kJH44W3hjlbJnnw1hdRw45ZFlgqhrKWeKFj6GrIXN7DKecRB8VIUtuNc0lJtmcFeP9w8HuEh84LJrnErJFKMTASHj3hGFPaWxQpRSN5Z5qr4NFfrctf8GKsYZc/VifZDqiRGtPblaNpNnBjAgG3hSIEBJS7aXWvKBFclggawxXGp22yjJ/4Z8iLkv1zFzRcpbxsK5Bdt8k1MGlAjzB6tFz1tL1rW3mqU4esgBTA9P0exvZ4hRhHJ1IejQB9+EogQ8pNXahij5E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d977b1f8-7668-42c7-2e94-08dcc91f1888
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:10:57.5526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfRBqBF83xZkOnBmV/hd9ilgcxKmVqv+pOXHmDTiC+lEHhV+f+GQJ9kKh6w5CZFLf5qVd+DWMiV2ECpXrtVVyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300138
X-Proofpoint-GUID: QU-dX9FMo-fII6D_GKsXTywd17puEIbC
X-Proofpoint-ORIG-GUID: QU-dX9FMo-fII6D_GKsXTywd17puEIbC
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] nfsstat01: Check that RPC stats don't leak
 between net namespaces
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
Cc: NeilBrown <neilb@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Aug 30, 2024 at 04:13:40PM +0200, Martin Doucha wrote:
> When the NFS server and client run on the same host in different net
> namespaces, check that RPC calls from the client namespace don't
> change RPC statistics in the root namespace.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> I've initially tried to test both NFS and RPC client stats but it appears
> that NFS client stats are still shared across all namespaces. Only RPC
> client stats are separate for each net namespace. The kernel patchset[1]
> which introduced per-NS stats confirms that only RPC stats have been changed.

I believe that is correct, Josef changed only RPC counters. Which
counters did you expect also would be containerized, exactly?
Perhaps this issue should be raised on linux-nfs@vger, it could be
considered to be another information leak.


> If NFS client stats should be separate for each namespace as well, let
> me know and I'll return the second set of NS checks in patch v2.
> 
> Tested on kernel v5.14 with Neil's backports.
> 
> [1] https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/
> 
>  testcases/network/nfs/nfsstat01/nfsstat01.sh | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> index 8d7202cf3..3379c4d46 100755
> --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> @@ -22,6 +22,7 @@ get_calls()
>  	local name=$1
>  	local field=$2
>  	local nfs_f=$3
> +	local netns=${4:-rhost}
>  	local type="lhost"
>  	local calls opt
>  
> @@ -30,7 +31,8 @@ get_calls()
>  
>  	if tst_net_use_netns; then
>  		# In netns setup, rhost is the client
> -		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && type="rhost"
> +		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && \
> +			type="$netns"
>  	else
>  		[ "$nfs_f" != "nfs" ] && type="rhost"
>  	fi
> @@ -64,13 +66,14 @@ get_calls()
>  do_test()
>  {
>  	local client_calls server_calls new_server_calls new_client_calls
> -	local client_field server_field
> +	local client_field server_field root_calls new_root_calls
>  	local client_v=$VERSION server_v=$VERSION
>  
>  	tst_res TINFO "checking RPC calls for server/client"
>  
>  	server_calls="$(get_calls rpc 2 nfsd)"
>  	client_calls="$(get_calls rpc 2 nfs)"
> +	root_calls="$(get_calls rpc 2 nfs lhost)"
>  
>  	tst_res TINFO "calls $server_calls/$client_calls"
>  
> @@ -79,6 +82,7 @@ do_test()
>  
>  	new_server_calls="$(get_calls rpc 2 nfsd)"
>  	new_client_calls="$(get_calls rpc 2 nfs)"
> +	new_root_calls="$(get_calls rpc 2 nfs lhost)"
>  	tst_res TINFO "new calls $new_server_calls/$new_client_calls"
>  
>  	if [ "$new_server_calls" -le "$server_calls" ]; then
> @@ -93,6 +97,16 @@ do_test()
>  		tst_res TPASS "client RPC calls increased"
>  	fi
>  
> +	if [ $NS_STAT_RHOST -ne 0 ]; then
> +		tst_res TINFO "Root NS client RPC calls: $root_calls => $new_root_calls"
> +
> +		if [ $root_calls -ne $new_root_calls ]; then
> +			tst_res TFAIL "RPC stats leaked between net namespaces"
> +		else
> +			tst_res TPASS "RPC stats stay within net namespaces"
> +		fi
> +	fi
> +
>  	tst_res TINFO "checking NFS calls for server/client"
>  	case $VERSION in
>  	2) client_field=13 server_field=13
> -- 
> 2.46.0
> 

-- 
Chuck Lever

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
