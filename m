Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200A5C87FD4
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 19:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724960154; h=to : date :
 message-id : content-id : mime-version : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=BRdTplK9Z9br28eeTWcTkP6qf5kCoiso8m0xcxT2/sE=;
 b=INfmKt348g5LHumI5odoEdBKn/Y7sBApiVSV4ibHmxOvlGJUSlroHqL39knvYEORTSLPd
 HD4K+/x/1dAs4HEOSGpRnurYXPSeBe8U2bu9pDmk+GetVQkRuA302KEH6T3FSWxnDz7m3qW
 4M8lJ82FhPrXOkg+rCmGDHnfr/fJrbI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C394E3D2818
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 21:35:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C1853D2808
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 21:35:32 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F3D0C60117F
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 21:35:28 +0200 (CEST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TIXkNx015106
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 19:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:content-type:content-id
 :content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=j
 68yrGTGoUqwfvbWyYop3RFaU0Sfb/eXeaMKPINsvVI=; b=SDuLaN6YQgW342OHA
 I3jWQfP0eOjOKW8ht4ROinHTtCnuvnRgx+PQx3EojfThix6+ArZde19dWhjhHPR/
 DX6d/897xoEFP8ICskQqkowAOOCQkqPk2Un61WgwCbEm33MXFuEsne+GbIFclHRX
 1vVR0rru2s3IyaB00xjYfwP33eH9MiwFunBNnCx9VEWU5WXvhdPc+bK6Ym0jdmoB
 Rfbug0vNfQCkOcvUZq3hPhkUq9iW9/2OZQHBbUqdRz2kU5MzaErgQ4gw+FFziP/a
 7cqzH0z1CKNk7I9hzauxFOg0pWYm+HTIBkFMEW3BgNqeN3lpBnwLQTaE45Pn8Xh+
 YKWVA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pup59uk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 19:35:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47TIIE8d009936
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 19:35:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41894r61m4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 19:35:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4lzh0BJG22SqhPigzAt+BnwgPz+VJar3wuMXGEyxhNBbXoYAmbXA+O9q+8cdfESNaEKFlocbR7gvJeOfGQoiP/t4FmU2DNttWLfmlOC1zffq2fIXGZjqEjWe6dKOyxXUNMnqK78gapWaJpPCTnk3u/i/tzA+Iw32Z0KDKNFCDE1FhcHwqUuX3MXKHUVdxrWdH0D++PMTY3GR1gyLOjPudy45uZU9IdBjXfx0BxDakR1WWmGzCWUvXkg5FvzPxXwT3+pFw2BYdL3//ru8qdaBGqXbXi5ntC46h3SxbvPuMm3ZUiv5any7EWregWS48j/oYX0CBdljmvUA342jHI00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j68yrGTGoUqwfvbWyYop3RFaU0Sfb/eXeaMKPINsvVI=;
 b=Ig080Zopvf6o+HJeFwWqhkefuzueLxC+3veZ4Em7RnVAP7hFJnf7Sn0V3XZFbwHhtrYJLlt/GflSrTNfWAKnME+9eNMqOx7JwqTbHgVe+xfHeAe5mC7MA/X60KeAl+AxxKkTLxIA7FESG7TVI54b/eC4aPtQgR/znGwoGLsAVUY/PNNuPC2wNzcVLnRe0vbU+rvsXf5A9Z3hwfp6X/uMIY2DKoLTzV+X/iWyEYeFYN4Zpn9BySUQxY686qo2WeZZ5t/HM82evb4J+tPvsAqZG18gs8hHPj8pvx7vGwO3EfetS6H+LWPuz2yQ79Ezc4AlqMiGtt5D0wfSd85TGVLyqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j68yrGTGoUqwfvbWyYop3RFaU0Sfb/eXeaMKPINsvVI=;
 b=Uzw0h6gxsrNaGZob0LctCKEbZs4xYfN5zPiTf6ixIT9qtNk2gT9j9AKwKseZRV6pFHVxM6bachdc6Cjw0I4Th1ApJOvnmGveX/lq02rCOR8NrVbjk84xMgkyK6miQl/W1oPBgSK4sJBjRn8N5baqaDUSSqvVWWBmn/FsFX+5nhg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5910.namprd10.prod.outlook.com (2603:10b6:208:3d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Thu, 29 Aug
 2024 19:35:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 19:35:19 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: TI-RPC test failures; network configuration related?
Thread-Index: AQHa+kqUwHC9Nu16i0Wh/dCilVxUmQ==
Date: Thu, 29 Aug 2024 19:35:18 +0000
Message-ID: <662B8BF1-099A-4CD0-94AB-267BE738130F@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN0PR10MB5910:EE_
x-ms-office365-filtering-correlation-id: 49c289fb-7190-425c-5c57-08dcc861b72b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?s4Q/eKLSmvxo/LATuJs43ozO6fFG+VHphWc3tvKqKpLFjjnM3EYNOarXnMVx?=
 =?us-ascii?Q?iwI/0FxB2EHZdfT8it4i7eqJ5xGUYcvE6eb2TJ8uEb7TvTmJ3L2ZAuCu56YY?=
 =?us-ascii?Q?KAgwnvsgOfiNwhs2hVVKK1aMInEffIFIdnRqgMZkWu7Fx4Bik0aOnL70rAI8?=
 =?us-ascii?Q?+JzNsbjFtqorF3XOq1zixqXXA1/NJCWnwu2+4WujIyhpL4TvvGjgVpqkLHCc?=
 =?us-ascii?Q?lhAKhcSL8/aI/3VHhhM9rbF++Dm1JIOkTNKr0Ag92VXxdr00kSxhdvUuxsEk?=
 =?us-ascii?Q?X4YFSfnHJ4qQsHyMs9rgrJSvHrNyg1SwEx14rG4ZHXgFe66E4avUCx/PjTXt?=
 =?us-ascii?Q?2TzFiVwkjOcH898jD7XxZ1LyGmP54VZsdiK0ZvP40z5IGOXg4LxZBU0vayd7?=
 =?us-ascii?Q?vNgrdjNLUqCVDgqNORmZimyckl+yugIKR24J0DSyvdYIKSAqyfezxmEN4NRY?=
 =?us-ascii?Q?jvYumTCV3u+yD5GB88tOoHx/NN7YCsW5I7faM6v6WJVSYgwAAqUN6bMtTJxl?=
 =?us-ascii?Q?ECOHiUjuv024R9XiPIeko1XKDDMZkT+ON3bcHZAFIr1wp2z+ksh6GjYJDaXi?=
 =?us-ascii?Q?D+Kc83cfU7tJ22DSx/avjltYJrg1VlBT8sGwmagJFPJG2aH16c96bTSbepwL?=
 =?us-ascii?Q?Ec8RT0vuoyVLAwPyN9be762i5NQc+VAIB8EjmwNKy3OMSnUmhdiNSMHbaj0T?=
 =?us-ascii?Q?yw8v28rV+i1x7htnUo7/54t+es5o2eBxeMj1bDB0p6sq0CR/iemc7UUADQ53?=
 =?us-ascii?Q?nANFL0fP3eT/LVxTb5B5Zl6hE68BAiiYUfFjjhtYPRz5o6KSgtkig6K8xQju?=
 =?us-ascii?Q?WvuhVOjghnJ8PUT4bKQlgsONC/jiY+PTxkfHd/9FMGxfXFy5ghAXhdwOr3vu?=
 =?us-ascii?Q?lOsuZ0fZ2/NAakUm4wNIVP3WQRVAg6CHMMTTsjxtf3yjjwudRs/bFwgVhBrw?=
 =?us-ascii?Q?KHqB0O6/9etEUP6BRpiYuoki/DTJw2ZdOpsvd6BjLoRoukg8Ao+F/UFlRDoV?=
 =?us-ascii?Q?gH+1vMp/5hm1uQboBFR+hr5b5FCqViXUzSK+KYcKNpmrWx27Qk7bbwuqzIvF?=
 =?us-ascii?Q?ibHzkeD4J4uTG9ynMdF4OteKhyN7nwF4O1y2bxo2T0A6pvTmKLq5uZQW7qXf?=
 =?us-ascii?Q?FzXn37AsD+a439tFMuKR9Ba5/ubhro92q5wl1CFTx4HumMkhPULOKeaEmQsi?=
 =?us-ascii?Q?zpqj8QqQ0rueOqIqewn9fhPgWC7WJzJZ7u7FuK8BPfQ5iaTH+JOzigwKGu05?=
 =?us-ascii?Q?dRpHvdH6fT04T3N5NxmtBFuzStEC6BL3S+j9JYvBmvMQ/1ts1rJE5BcaXtjT?=
 =?us-ascii?Q?O4QCaY0o7UTutApDo3WyGMkSWFPoVtJGD3J/w8+xoCgGwH5WDj12818cuCqc?=
 =?us-ascii?Q?wFrSKhdeNuek87ek4rIagmL7dWKLDiTLylSIrAyxiIi0KrZuCg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uR2veoyJC92txKBiXn1S3Yqbd45I/GJLh3dOPWia4ezOBt6RHBa8dOxaQedx?=
 =?us-ascii?Q?4aWZd0dfEf4Hrt5IuN0sv5CeJJKylhCAkz8nKW2XrxKAbL/PRf7hQTr5Us7L?=
 =?us-ascii?Q?MI0nGMD8XXgR+BfiHFzGrRvRbuQ8LsxIJsNS4uNpgeGPHzjTtx7swWOO+f5d?=
 =?us-ascii?Q?BwLm/Vz5rbaMzZqnpPGpFUJ3p6vYrriT0QVrs4YVx0psxO5O5DUMlZ+zZi3z?=
 =?us-ascii?Q?QZKu9VLZvdHz4P68axZQD1h3A4Zi67vUJIV1u+RBIKLHHIJltmzhbpZmCa+/?=
 =?us-ascii?Q?rEvOwYrQuZwCypOAfc5FuRPb2c8D/kBNtITeB3TbKhjQA0+C0qmTQJJOgT0X?=
 =?us-ascii?Q?jQQSllPZY2hyPgVcRDME2kOGjjCEmp1kmWvH6MZRX0UlnEkXtAlj8Ip3xBMb?=
 =?us-ascii?Q?prOMdtRzKqKCj2k345xd4c9QPyYJLiP0o+382EtGmlNc1AXYNdunQezY1UYu?=
 =?us-ascii?Q?eDfMAjO6k3A9vkle8cFjK7/GstjjU1FacIBMpDrItdHiXCuWIKebuHvTAbEm?=
 =?us-ascii?Q?7hRBtVKcSSXVNIcYhhJ9w1IGzjAD5IqT1qW20uod5dm/N3KnVtBrRamAykds?=
 =?us-ascii?Q?dMMEWnWH2ibsau96KS+xklTaScnEwKcKrP4w6nGI3VUXKlLCioWI4o44iyXN?=
 =?us-ascii?Q?6uH58MgsjPJTRsCrOO2ohDYdO5N6UsYWFq2lh1ODlD7QTmBOujq8hjpgVoiF?=
 =?us-ascii?Q?aqIQlclbyan0I4HzWYvX058Z5zaasw++xwXaLy4ALc+K2pHJLfBqKWRaLUl8?=
 =?us-ascii?Q?rh7sJt2BDHCqkLLBOw8X80yMdWl7bHYpZni/Z2Bgf8h2N0A38bIFfBvH1aET?=
 =?us-ascii?Q?/6qID/yLEWxw1eXufKh8cgvRl4NK1jUyTPVfp/lvBZV3fhYaisnpQGx3LNjp?=
 =?us-ascii?Q?SaNrObGKLFFHmSAgGlUM8ZAdhl156AjUy0M9+cyIlNKSkBnXmXupvEcsE8ht?=
 =?us-ascii?Q?mdnNme8iFLqT83H4M1bbLK2wjerzWPqhjTpeKw+RM6gTG6sYEY0t5o6cHqGy?=
 =?us-ascii?Q?hakYj2ZBXQrTqZV5ZdNJFR3dkVeufm9rqtZ2Jpqna0vGFXZQyM8dE5RYmkFG?=
 =?us-ascii?Q?B4Rfhgm5bcO8TN0E0z5Sq7apEbKgjIRGFpmf1ZI9nPgtkVcCstHAzxAgj1OU?=
 =?us-ascii?Q?LxNq5BbhRuw1ns/ca+Rgp6q3QfKMvrP/EYwe/33sg1jbJ2GvOLf64zffn/YL?=
 =?us-ascii?Q?ZvlpzbV3qzc6cBSz34END/lwMYz8CE+unwXXB6sigiAgmRqjy0UHgo1MQOB8?=
 =?us-ascii?Q?xrC/iQTTG/pSZ+Ski+YgAAvo62s70mlJNqoibWTP3hzqgIY/LG9udnAJBc5F?=
 =?us-ascii?Q?dxQAx836jb+jOrfrd8hdCylyVjzhGjsCaFOOuTPNVLmI81ZNFTdh5wixPZht?=
 =?us-ascii?Q?yAVzOkYEVw1+NoZR9HlAuO+q8TJ9saJkdeyCw/fT+Nkk+0MqpMp/RwuO6znF?=
 =?us-ascii?Q?7x+ooe3WJe3S+8jSwSR6Y7SpYWlaXww17FuCemcTP6wRYr2/TdyY30J1xf1H?=
 =?us-ascii?Q?eqJ/g4JmCwjgfKyWOllohoECVm5pv8L0DTWML3c9urR/LSHOPsFmx4DZnShv?=
 =?us-ascii?Q?Xchgfm27oKffw8S0XRvuoxvFKEGa3+u1Zl96U9u+r104r4uabzO43Rqrqzw3?=
 =?us-ascii?Q?gA=3D=3D?=
Content-ID: <3F06BF2EED5F6C458798156D7C9F5D7E@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rfr3Jv2Y4mC4RnAhmytl5JkNWdcL2yBhXg57WQuEoecCNDuXAN5E3gZGtTbEURjsS5HPCi5HMiwNbBRIgn7AVz4MG4BVTQjygA5yUbqh2wetCjoUsQzaJPZHniRqKFh+2huSMiu9Zw7oYlVXfdpEcdCYUHOalXJyblJICdf2EUCaKyAo7VuNvqFS7T0gPDLBr2266cOCdQsyyWEJgSMAHZeHAEKBo0BCVR6tkx60wxh/HeG0WMQTG9i1npMZVO0qjHEKQbWlxHNE84iPXRu4VDlrnincTi/i/Ni0y9+MKhUaQVe+fKDcOhw/oJDc8qae6pU6ouSr57cDQuMSKVJAw+1CfmUR9I01e/h7RZxo0+Hgjvajq8kXN7jZyYpEnDRccsqqkdTpG6kT6PgPzYSs1IgWYRYq6rbIeuU14kyj12y2yNGAdAAHHNTCzRSS5YvNu00+RbV3J1BjEdbxwHb6ms4QYKshA9FhiflB46DkDP9V81oc+8/yEscsJ9S6NpjmlA+VLCubrVPqHyormRJYXhcdXjvQk4If+nrZROfbtvPfTLYuhkqe/2CkBishRltiQ3fYc5AqthCVdbVcF6xX+6eySsRC2MkK5wjhjQ5+fyw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c289fb-7190-425c-5c57-08dcc861b72b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 19:35:18.9822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoiVNj5MnlGt5Fvajm4MiccDdA11lb/WMcxPrJ7Q24LqTjczbSXOgSalGs64hKU2d3P8j8WNRoTaEXbHusJWHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290138
X-Proofpoint-ORIG-GUID: 6_EgBy6hZMgCxmZJWZUlf2CWpBELirMb
X-Proofpoint-GUID: 6_EgBy6hZMgCxmZJWZUlf2CWpBELirMb
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] TI-RPC test failures; network configuration related?
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
From: Chuck Lever III via ltp <ltp@lists.linux.it>
Reply-To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

For a while now my nightly "runltp -f net.tirpc_tests" have
thrown a bunch of failures but I haven't had time to look
into it until now. Without modification, about half of the
client test programs segfault.

Here's a sample test failure. I instrumented the
tirpc_clnt_destroy test case and the rpc_tests.sh script as
shown below, but I still don't understand why clnt_create(3t)
is failing.

Seems to occur on all recent versions of Fedora with stock
kernels or custom-built kernels.


[root@cel-tirpc ltp]# testcases/bin/rpc_test.sh -s tirpc_svc_2 -c tirpc_clnt_destroy
rpc_test 1 TINFO: Running: rpc_test.sh -s tirpc_svc_2 -c tirpc_clnt_destroy
rpc_test 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
rpc_test 1 TINFO: add local addr 10.0.0.2/24
rpc_test 1 TINFO: add local addr fd00:1:1:1::2/64
rpc_test 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
rpc_test 1 TINFO: add remote addr 10.0.0.1/24
rpc_test 1 TINFO: add remote addr fd00:1:1:1::1/64
rpc_test 1 TINFO: Network config (local -- remote):
rpc_test 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
rpc_test 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
rpc_test 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
rpc_test 1 TINFO: timeout per run is 0h 5m 0s
rpc_test 1 TINFO: check registered RPC with rpcinfo
rpc_test 1 TINFO: registered RPC:
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100024    1   udp  46925  status
    100024    1   tcp  60195  status
    100005    1   udp  20048  mountd
    100005    1   tcp  20048  mountd
    100005    2   udp  20048  mountd
    100005    2   tcp  20048  mountd
    100005    3   udp  20048  mountd
    100005    3   tcp  20048  mountd
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100227    3   tcp   2049  nfs_acl
    100003    3   udp   2049  nfs
    100227    3   udp   2049  nfs_acl
    100021    1   udp  33304  nlockmgr
    100021    3   udp  33304  nlockmgr
    100021    4   udp  33304  nlockmgr
    100021    1   tcp  42895  nlockmgr
    100021    3   tcp  42895  nlockmgr
    100021    4   tcp  42895  nlockmgr
        10    1   udp  59751

# Note above: the test RPC program (536875000) does not
# appear in the rpcinfo output. That makes me suspect
# the network namespace configuration on this guest is
# somehow incorrect.

rpc_test 1 TINFO: using libtirpc: yes
traceroute to 10.0.0.2 (10.0.0.2), 30 hops max, 60 byte packets
 1  cel-tirpc (10.0.0.2)  0.501 ms  0.438 ms  0.392 ms
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
0.0.0.0         192.168.122.1   0.0.0.0         UG        0 0          0 enp1s0
10.0.0.0        0.0.0.0         255.255.255.0   U         0 0          0 ltp_ns_veth2
192.168.122.0   0.0.0.0         255.255.255.0   U         0 0          0 enp1s0
rpc_test 1 TFAIL: tirpc_clnt_destroy 10.0.0.2 536875000 failed unexpectedly

# I changed tirpc_clnt_destroy to display the following
# information instead of segfaulting. clnt_create()
# returns NULL and sets the library's rpc_createerr.

rpc_createerr.cf_stat=12
error: No route to host
2
rpc_test 2 TINFO: SELinux enabled in enforcing mode, this may affect test results
rpc_test 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=1 (requires super/root)
rpc_test 2 TINFO: install seinfo to find used SELinux profiles
rpc_test 2 TINFO: loaded SELinux profiles: none

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0

--
Chuck Lever



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
