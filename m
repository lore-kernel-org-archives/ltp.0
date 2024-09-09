Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A27FECE579
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 14:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725890442; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=eWEptWJ7AAUgI6al2eTqFAqjsKi1yHBRMECSZ92bIBE=;
 b=iGLwvtwutod5tz7QG5s2w8wI6W6fCBHEKGMot8Nvm3MAfDt7KvzVoYuAGY775BoMOHtVV
 MT1wECh1Vzz7hFmePKdb7XAHUW0tdrDhCBrZGcEFCSG9s51Td3qa6Azjr22yZCPvk25M+tS
 n/627qApRZYOevhhdmq2+SqQeXMaxt0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23B6A3C1893
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 16:00:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CE893C0FC2
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 16:00:21 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=liam.howlett@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 178461A01078
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 16:00:19 +0200 (CEST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489DfXQs016865;
 Mon, 9 Sep 2024 14:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 date:from:to:cc:subject:message-id:references:content-type
 :in-reply-to:mime-version; s=corp-2023-11-20; bh=D3/32+S22fWO79e
 aRKij1fykKRfFBLx0NMCppoSNd0Y=; b=S5nBde8cl+UajwQiZqmhe0Rcp2jj54P
 PZ019LL8cwxqbMqvr/wZRk9yTw4t2nANnBpdZe9akIfZX33Wbv6af+HvPLxQMMtW
 F5PzwCBBTsF019MI/AZZFPKpluA3mM6Kt/x7X9m5FUKBFimTZOsPHtdhcvCKnsG+
 /uSdyCN5CcXXxvNpf5F4p9ZzATrNpCPWBKpu3fw+2WSzSP41Kk3OusX5ZmaInzym
 hMEPTFQ3uta8UcNfslnOP3Dpubzn4796kclf/EpUGNKvBIbjnoDyOoqAv6f0bKM2
 bZSU3FWUFeLjEPVMwAw71cPcibUxe/ENWSCY6pjY5rI9mSqkL+cvyEQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gd8cu139-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Sep 2024 14:00:09 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 489CNkhi004192; Mon, 9 Sep 2024 14:00:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd977mrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Sep 2024 14:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNY3W6MVPmIpeaQu79L4di/ds/WNsOClr3nanG9LEweMv/EBfkKSwrmyvDdgViZsdlefBhT8jODgxr2f6i8ddOWATuzQDSAFwKVw24SHfwYSalfrfPlkij+zO1xdjEBmGZol23YReMiF304UVace6yMUnmZGL24QxUi/FVBYmQBWzPAnoTlIC5dGzBD5m0BZ6wMG3y32hiuSIxfntW2TorInu9XMd7/E7UzsEmKWBZ+txnti4JHjbtufuLGIh2uvJBjHMzVD5CxREwTxHa63QQtDrTdx6DD8RwdQJZFJbYrd6uScgThgg+YT82xS6NYxvN6HbgJHVWVN1sbS6YL6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3/32+S22fWO79eaRKij1fykKRfFBLx0NMCppoSNd0Y=;
 b=VdaUpj7Qh6+QzHLKmVl8hvnWsubgSLOGHpx077aDnB3/RfkIw76RsptYua48ESLX65O6vZswKsAEpez7nnTggd6oukToG6l8FAV8N/5VV0OlZP5DweDDXXKZKnaTlPzMmvdIPC48AFfxgE5IkspyWBH7MwOVr9KU9rc8VE6OwxozMMk3lvbHffjCe+i+fL45yQkezMW6eleqOOJPLj3Z1B8wx2KZHKRPUHu+Ncr/NZ91aRQufTXdeyCnvsanb5LzrtYAJ/Npe3gPKl3UhzfRNogw4eMGDwX9NJFkQsuG1HNjJTUZhu4Jpn3jru4t0C4zqoDxxULvfWE6Njh1qDCIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3/32+S22fWO79eaRKij1fykKRfFBLx0NMCppoSNd0Y=;
 b=dASFkRm2d2kzcNjlUiSePewxIDmIT+y8kLLUfpWchjFQEq9ll6hk93Qb/2RXzXIIy39TEwlv8CbcwyS3kPZmAMSr5CVkPhSwEzCTTsOdMoPvU/veAJpZ+eBXs37+r4Js85T653UMyFiqnbjlJt78VW+cCBGq9SsrAR+PwgbdvdY=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by CY5PR10MB6096.namprd10.prod.outlook.com (2603:10b6:930:37::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.14; Mon, 9 Sep
 2024 14:00:05 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Mon, 9 Sep 2024
 14:00:05 +0000
Date: Mon, 9 Sep 2024 10:00:02 -0400
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Message-ID: <adu5bbfqfurbe5tbzguhsmdgpp66guiq5akavjwfk4w37q4pwv@pd6lsmbzi3b7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Xiao Yang <ice_yangxiao@163.com>,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, ltp@lists.linux.it, oliver.sang@intel.com, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
References: <20240909050226.2053-1-ice_yangxiao@163.com>
 <9a899c60-cb88-4991-8c5f-3fb14c8a09b8@lucifer.local>
Content-Disposition: inline
In-Reply-To: <9a899c60-cb88-4991-8c5f-3fb14c8a09b8@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::12) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|CY5PR10MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 8989c4e0-c589-4b64-cdfd-08dcd0d7b4a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0ud8sJKmGOGZHxWi6ZEb4kmczaXyonAIILet2rDHJsa0ZWLb7cDy85I0P40B?=
 =?us-ascii?Q?XLJCAam+68nSU8aBwhsuibJuXH6QrWMpKsSVxrlAN5Q+wNBxSQMR7hRpdm/L?=
 =?us-ascii?Q?FAUlN+Z1NYw0YUUle5ftfsUtSXlsUbkOTL9NiLuYO5vbWIJnN0lyxtfQMLlK?=
 =?us-ascii?Q?tJ+hfhmbSMzpKGUzADHNON2p70RQxkS6MjAMWnfQjhyf7vFjm4IXdJV+EF8O?=
 =?us-ascii?Q?OQxDSxnsB5nKBbbAPCIkgxykVTEpovq76cEA4mlumbg6LNitY8yh++C8HqOR?=
 =?us-ascii?Q?4GnecTGfaFTcSpOFJThiz8uG3/BdG/Gpgge6pBgQVUtww6terwI45tL3Hc+y?=
 =?us-ascii?Q?gNLwY+yUsnt/9NihNx09b4LrARwgiU4XAMxFyiMgaLhWoW3XF67kbxplgrgf?=
 =?us-ascii?Q?pvScCo1v1FC9LGVzDbkhMLPZp2ueNi8P2pn+5S0vewZ2LOfH/ZvH5zjP8gK2?=
 =?us-ascii?Q?DhXiCP1EWNmNEiRUQQDd61KiU2iiuUMUAVXd1JCs1gQ3kGD60BnGSyHWCrR7?=
 =?us-ascii?Q?mTeq4p/z4/WpPvBb0XGJRX1d67Omr91SF9MoGzdAWHB05kA0hW+zmzUK+bmb?=
 =?us-ascii?Q?guLZ2hlMkehvTXmEQpTSqO7I0VK1lTxX4HyBa2aooJbyqXyKoPznUyCha53g?=
 =?us-ascii?Q?tV+C6V6f4ApjzfTH0Lx32x3vzD1ngSoNRXPeddqiKlRyDTvlNRmWE5wcCDkX?=
 =?us-ascii?Q?LdMSNJqcW37SQ1nkV5WGb77u7ieGp7FogEfM4ap8xFncAKPLIF8pRpTqV4DU?=
 =?us-ascii?Q?ldi8+LuEAdRL7o27ANnvvR1l5HERmBGzLkjTTAA7ULq75piyOTpAaufRKdkk?=
 =?us-ascii?Q?FVcKeGzJf4MSDqN3ZPrh+uc2hMQKadfvYFUxpnRWlL1tGvSBhnk8qUYSI2Dv?=
 =?us-ascii?Q?VmAsUqlMqJaJRye+7c2mbEjUWm2Cpy04jxieeSTWY6iwJ0yg2ot+NNW1VEpq?=
 =?us-ascii?Q?S9qGYc4D7UICgXEuKmPFJqcbsddM0Xc8jNggHbQeJfkXurmFh2yfMByzwBtu?=
 =?us-ascii?Q?Rz86FjalKhtReep4JOv4OqURzfiHYA9MzViKIBqssGpCzrSyUJD9SDrVS1Mm?=
 =?us-ascii?Q?QPtAg/zH+7WWha0dOPV9wpzxCc5a7Kf3pFgtjoMqR2u6o8CRU69EvxytsHSl?=
 =?us-ascii?Q?b70G5IKG7EoFivTwiG0c0CHKrUgg9e7TPwsKgrb0CsYUoGyrYQqbTivjuNI5?=
 =?us-ascii?Q?DxOCKf1ztJhH4lb75fQFDE4OBuQAo2wQqH8E2tRQnL87LN02ccRBFCJWsHRw?=
 =?us-ascii?Q?IULWOavZqk4N1P3/x0gJOD64kkdIepQQ7i5gkY4YslC1w99nbcUL0LAQcuIp?=
 =?us-ascii?Q?J1fobw5I77kyjEDHBUjISC+hQHPUcYE83KcbLNXDFJgGc+v2Hp7Kc52dbreC?=
 =?us-ascii?Q?sXJXXs4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR10MB7943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kBCNl8TJvQMctqBr5VktYXMgiam+MRPeU3lZtBOikVttOM0Q75QdgsoFY6yn?=
 =?us-ascii?Q?EDIdioLIiSoskfNmB8RYnHUNeKweBJWuuL5b5WDtWk+fVBe7oLAYZ+Rya7qF?=
 =?us-ascii?Q?H1GprC4zoP2m4teiwyaZjSYgGMXDiuhB28BsKJJloj/h0xyIQBLDQSzgYefT?=
 =?us-ascii?Q?uwF3/Mv+ZNSOgdpUpwrCc250y9AIs9yzoY0rPVArysV4YUTcf8fopMA9/p0B?=
 =?us-ascii?Q?5VD7CvmtFLUCdJBQbcpop++c/GlW8hr+7JPqcvu22Je9nD5p78N1QKzJYqn4?=
 =?us-ascii?Q?umGSWW8D432xWOXlyh1SyN2ofvcwniO6uDy/e5ltXIBPEWn6I5rJfYSoMmIc?=
 =?us-ascii?Q?2RuYxAOl/+KQ+mjHgFa6A9y5sz6k387niNgtSdHqq2U6joJqgJ+S/9lFn8Zy?=
 =?us-ascii?Q?GPHRHc4a/3WC/W6NXtE2ro+dhIBGAEuTV2nrEe5BcS4SnOXQJRp8F95PRP5j?=
 =?us-ascii?Q?iin2cj3vbxiR3j7H3mjx/iRiKpMaQ//Whb8G+gDekospxakv67CDi8eaaX7E?=
 =?us-ascii?Q?J2c5nzCinWQE8PtJUV1C5O81Daf7vmdhsh1DUpqa505fegIOYl1Wk/IiU0UM?=
 =?us-ascii?Q?pm7lYIP4/nSzSKCSfn4YT2tB8hIibY52aXvjhXAmrEUjxcApPhO6IIFRJ8Ew?=
 =?us-ascii?Q?xW5KFfny7tWZr1ih22jjyzNcRKQuI6EJZYxvilvzN6GB7OY6n2lmzZt7p+IL?=
 =?us-ascii?Q?2x1G4/Korht8mU9w9eZWeQOUEt6Y9qrD6rs4WE/FSv/k/CAS+emZIzVLXMq0?=
 =?us-ascii?Q?NCQCxQnkLKQFyn2MHfciSMANbOj1EuCeZLnkX/m+0XPEgqPYRH//2YFIz/0n?=
 =?us-ascii?Q?qtRukBndsZijxXXSoK5EZeCOBYREkA5yosPrJgvt18bhg7goY4uZe1SmlSvl?=
 =?us-ascii?Q?JtKcYxBUW2y4VgQkpjm+1oS+rwPDJzmsdxRIfcROkLCM4yoD3DM5tmG/bk6x?=
 =?us-ascii?Q?jj/OOdnPhMCH+BbrtcVRcVmfyl7zA9as90eA6dk2fdFrcRAesyl9X3zlGvGd?=
 =?us-ascii?Q?rrhZ8Da8ZvBMcSYZj/2OQk+HMfUrz323yo75+sQpctIfAsU+BCz2d6XgJavQ?=
 =?us-ascii?Q?T7dLBSPqPezcPNmVTxCU+85Ceq0hg8stauU5uqnai2ebN5loLmQXUEugoLmu?=
 =?us-ascii?Q?6pJJN5p7nhNLLMt2cFXvFGSjSp1IXP4jWFh4QiwtWv1PKd9yovK1xPNjRbw/?=
 =?us-ascii?Q?+bAkq3hDuamy1UGmRMYpPttQG68ChHh0ZNKV8vY+2Zp4WPqahQ1mhU/c4YuE?=
 =?us-ascii?Q?K9/pnu+mATPw8EQ5V2cd6Hun07F+sU+0kso9o15bwRD8DPmjpTuF6Gi7wItn?=
 =?us-ascii?Q?1aalPPZXbdXdxl8okf/9Ug7ta0ggA6gz99GiP9HrgT+xYjn2nNKpDz99Qv+C?=
 =?us-ascii?Q?Ml84zTfT382qQN49VmCXH4ngQoX7qkSJGmp2CGc6WXmdm+mZIePIUmbaODQt?=
 =?us-ascii?Q?MS7ycefdUo0u7VsnTmt4pWIRMtUZRptUMpZu61yCe4FmKO/DFwsDlhGTZ3ki?=
 =?us-ascii?Q?NS4pLc4Lmju1h8aSlnX/+AsnXFUUzxL4iINlBWIHEU9VaHTxbcwu/08eNKyn?=
 =?us-ascii?Q?eL95o3jrPZJx3Pe4JpeRY0g95fLWustCAIGHvgfK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +S+35pPgrJ4/yEQIHj92R8JtgC61ncXdllk1hxx6T+puboZ6b3yhUXuPMXJupizW3c45BJNvZEd1wcLmrhUax9ROrPhxvw9XHK9ScJuDCptKXYXPKNX9D9rb9zj2jRKG0F12MJF9MJxAjF60yZq5+bq3tN9DpqscM5W1XlcguD0EyGZPHUGIpEqKnle/SbipXi5j7Uud1JpOnvFu2qmwBAy6twNyNXKJgxMT4cvNKuGwipzGm8rNz8XGbL+Iks9/x9L2ZwwmeoEL/RgV4CxTc+4hfUXJ159Yqbl7GIIsuN2TKQlUJL9LxgbsGWzP3R2oUtS9P+GEmUE+TsxVgP9QYTn6WYeZJxA/s5tjt1nvOyhcd3bdErs21hqTvjHssve5cnWAKCOeP1MgV/XQLobE+tBX0zW44F/NGgP9WkDijo58fST5IYqYrcvOk6AZaVommYmZ5klV8KCVuy3G+N7DId1leBAEhG3JBa9DBbmw5wYoTAQ8KhDSEEkP06lwggmh5mVQ1RmY6RADgIY2UDhXQG3bQH2Eq9oqam3irvcpZihpdhXCTJV25qLMMoFeAEVsXKNTokDUYxa+gf1iw1YmIHDMmGXUqSD69XuhPPFmuw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8989c4e0-c589-4b64-cdfd-08dcd0d7b4a9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 14:00:04.9281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrd7S/XW9cgr1bdtoReInRA+zNni2XNfAe4qrqbrmZN2Ii56/Anyq1gKFGQj5Yc7OeSG2eOhpt1Othz4ojjEzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_06,2024-09-09_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409090112
X-Proofpoint-ORIG-GUID: nrx0JiWMG5-WdtyfbABIKxzhujWJlshY
X-Proofpoint-GUID: nrx0JiWMG5-WdtyfbABIKxzhujWJlshY
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, oliver.sang@intel.com,
 Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240909 05:09]:
> On Mon, Sep 09, 2024 at 02:02:26PM GMT, Xiao Yang wrote:
> > __split_vma() and mas_store_gfp() returns several types of errno on
> > failure so don't ignore them in vms_gather_munmap_vmas(). For example,
> > __split_vma() returns -EINVAL when an unaligned huge page is unmapped.
> > This issue is reproduced by ltp memfd_create03 test.
> 
> Thanks for this! :)
> 
> Though pedantic note - please ensure to check scripts/get_maintainer.pl and cc-
> the reviewers and maintainer, the maintainer being Andrew and the
> reviewers being me, Liam and Vlastimil.
> 
> The maintainer is especially important as it's Andrew who'll take the patch
> ;)
> 
> I've cc'd them here :)
> 
> >
> > Fixes: 6898c9039bc8 ("mm/vma: extract the gathering of vmas from do_vmi_align_munmap()")

This fixes line will mean nothing in the long run, but Andrew can use it
to identify the target to squash things.

If this patch is merged and not squshed, you will create more work for
stable and get emails asking what commit it fixes.

> > Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202409081536.d283a0fb-oliver.sang@intel.com
> > ---
> >  mm/vma.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 8d1686fc8d5a..3feeea9a8c3d 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -1200,7 +1200,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  			goto start_split_failed;
> >  		}
> >
> > -		if (__split_vma(vms->vmi, vms->vma, vms->start, 1))
> > +		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
> > +		if (error)
> >  			goto start_split_failed;
> 
> We'd probably want to stop assigning error = ENOMEM and just leave it
> uninitialised if we're always going to assign it rather than filter.
> 
> You'd want to make sure that you caught any case that relies on it being
> pre-assigned though.
> 
> >  	}
> >  	vms->prev = vma_prev(vms->vmi);
> > @@ -1220,12 +1221,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  		}
> >  		/* Does it split the end? */
> >  		if (next->vm_end > vms->end) {
> > -			if (__split_vma(vms->vmi, next, vms->end, 0))
> > +			error = __split_vma(vms->vmi, next, vms->end, 0);
> > +			if (error)
> >  				goto end_split_failed;
> 
> Related to point above, In this and above, you are now resetting error to 0
> should this succeed while some later code might rely on this not being the
> case.
> 
> Basically I'd prefer us, if Liam is cool with it, to just not initialise
> error and assign when an error actually occurs.
> 
> But we filtered for a reason, need to figure out if that is still
> needed...
> m
> >  		}
> >  		vma_start_write(next);
> >  		mas_set(mas_detach, vms->vma_count++);
> > -		if (mas_store_gfp(mas_detach, next, GFP_KERNEL))
> > +		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
> > +		if (error)
> >  			goto munmap_gather_failed;
> >
> >  		vma_mark_detached(next, true);
> > --
> > 2.46.0
> >
> 
> I'm in general in favour of what this patch does (modulo the points about
> not initialising error and checking that we don't rely on it being
> initialised above), but it very much need's Liam's input.
> 
> If Liam is cool with it, I'll add tags, but let's hold off on this until we
> have confirmation from him.

We should probably drop the assignment all together.

Thanks,
Liam


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
