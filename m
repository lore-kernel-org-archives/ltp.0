Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0296E6FE49
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 07:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725868253; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GdGu9gFyq1eyTPYGig9iZMlkJmuUuk9KwRB2qKXSYHk=;
 b=Qz+r0K6aitaWXM8X8s6xYySInzB3PEVX3/ZKbSbXjf1AbH2kRz/v2DDUIjgpv1b9hCuS6
 99w8rU254bzUA95a/PguFJEf6McQ5fbTw71ihonC21ybdLlT4O8OKX3UiU9cajl6lKORjwn
 m1qldfpkUYA92l08HYp9pL6Io7qGsgA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB30B3C102C
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 09:50:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 781A63C0978
 for <ltp@lists.linux.it>; Sun,  8 Sep 2024 15:51:39 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=lorenzo.stoakes@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9E3341A00812
 for <ltp@lists.linux.it>; Sun,  8 Sep 2024 15:51:37 +0200 (CEST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48873Lap018259;
 Sun, 8 Sep 2024 13:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 date:from:to:cc:subject:message-id:references:content-type
 :in-reply-to:mime-version; s=corp-2023-11-20; bh=1OACtHhAB7OSZSF
 +O9C+aRhJnmRG9/ii7sjHPD5L0Eo=; b=izS0/NfFGfbumAjxK49xOTD2DFBbkVD
 AIZxE+T8hX/9QElSkSzWbDX5Ky8Cv1yFWtHO53cI5Q4XcLvnQ29el6OCqMO7eRwb
 4FaZiZ+RFgn7hqZU03xe+FTK/l8KCvrnrR3LvHWwCDLKH2RdRtlc7WPMHLCR/ix6
 ivnumE3L4uW90H2hS6Y4rVvPlM9b0M0OIqFfUMlPnK4HMlXrNHSSdw4qMj4cqXlD
 TvobG84TG9rIhGZ9PC+xRBAyqhCVqiPhmAHnlyoSNPKx6egeDo3hnzwUyhAz01sj
 eZx3V9LgViZxXwwiPwNnBM9mnRjHg2VRwRNNHVTphabkQ2yDdFozPbQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevchbcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 08 Sep 2024 13:51:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 488AXMjt000308; Sun, 8 Sep 2024 13:51:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd97n05a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 08 Sep 2024 13:51:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfSZA/HcPwLEqWpbyPwZWV+/30zbk6rTXYPiLoCsF8q68dEBj1ze9EmRB1uOFwju9iUGWWVATBNziJIMNXgjrsqh5l+1sNXVBo7RoK7CDgQwB0xLBXzmhRyX3WDyojwm4ymnp0bfu6AhpxTUOxJn8874jUe/FUmazDbbNOf12VDh+5X0Lo106DQqnFjM2LP/y+3LjuwT+RtX3pkEGniKrad3eWJgFEGtYYATw56gH4gsM/UaU0T5cuJZLx6naLZ0FyhfRtcIZ5Mems+R+EyHm6IXsdkUVO83VjbW/hD+ba52akbSEh9K4ndRlRWOkEzX9FRahBNr3Q6DgIqrM0JF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OACtHhAB7OSZSF+O9C+aRhJnmRG9/ii7sjHPD5L0Eo=;
 b=gwGD7ks7gmqehD4FoI6X5KUI7OR1gBsAHfjgMpwRCIwTmGuL+ty8dPC2e/x7EZIMyVj+8uzO3aCCqNDQbdbD98ECYMk3AlIg59QibHYT7E9amCMDdtubMvmpxhH+5DSF8Bfobl1fDHjyjYhQljBWyfBLH+VZVkUFgt4sQ3Xd4k/1zilD7asG9acBTntYb+8VRVDrwq3+IAaR7EtnFM5xjyPQQDS2lX0KxZ9MgNxXaoTPF6mD4Ep4L+wmurdS58fSDvli+bX8PmlWeV+PNATix8G1G1O2Og5YysCjfboOe1ZskpMSZk5IpCQegUSmAXypokyIV2agm5PfPIF63t22MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OACtHhAB7OSZSF+O9C+aRhJnmRG9/ii7sjHPD5L0Eo=;
 b=lI2sXPmoALe42sVTpv2WtrLEXBthi8BjkUMt9mavbrBDTKpxdo/n3hE7gNAgqOk/Hzxcr8Gu5VKnWU18QTp9Bxe3dpKORDZ1f6/Zpyi3lSaoAof6h+FsgoKyG3lIMh0x/3nvwyzcuV+FIRZlgDUZUyKC1B8MlLjRNDwuc3QQHLY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB6879.namprd10.prod.outlook.com (2603:10b6:208:421::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Sun, 8 Sep
 2024 13:51:10 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7939.016; Sun, 8 Sep 2024
 13:51:09 +0000
Date: Sun, 8 Sep 2024 14:51:04 +0100
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <97fa18b0-51d7-4c7e-9d86-54def7aa1478@lucifer.local>
References: <202409081536.d283a0fb-oliver.sang@intel.com>
Content-Disposition: inline
In-Reply-To: <202409081536.d283a0fb-oliver.sang@intel.com>
X-ClientProxiedBy: LO4P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e68e2f4-5710-4854-2b77-08dcd00d4b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PCr1lJod7CJbS37VQvbPhA7is2C1NKVIgiI8CuKgdbejaZ8P6BEx5cb26icL?=
 =?us-ascii?Q?dqtKM+yJ4l4WgLQy2bED4ld4irapL6k0ORytTJ2pFeynukIBkUvi5xrMSaqw?=
 =?us-ascii?Q?tcZj6ECfKsFe5AcGP2/+hTuCwnHuo7M4FYZcqxX57z2KMlwndLNG05MAYkyp?=
 =?us-ascii?Q?fCJMpSEQryg7gtRWlmljv8VifliMAMHTIfPQtSMy/D8q9SKqI9SoYjjOuadA?=
 =?us-ascii?Q?TyoSN3uhc23pAw8r4CjLssTqEBoTSKvGnrDM9IDthY2uQ+reFoRXlE57BACg?=
 =?us-ascii?Q?7xVHSS1UzumO0TK4QRIMHVqHHxfALGALjE2PZRkwSd4j+5IdaQgDKB36A1eo?=
 =?us-ascii?Q?7U3QFrielgmjfH9Ag/J9uPDLIYwlGggMnlRVuZj0NiBB1jlFlhn6Lk4NIj7U?=
 =?us-ascii?Q?PjfivK9Vy0GdTpAMKAS5AJcbQwhNFEjgAivNl8w/jEU02O2W4Yi0CsZ7fh/y?=
 =?us-ascii?Q?hxEtPTDGxurXfjgP3YD77kQXYJUOiC7RhkMXsSW5mZNCfbQAtGh9CgibZvCp?=
 =?us-ascii?Q?OFX1hypUmNbctOCYMhRQG/talttNvD+S+NmVD3F6IIZjN73mAfdFYkfwe8E5?=
 =?us-ascii?Q?Dm+5+cvnPGjHFnWAMPEu7knW90FmpSM26xhu21LpO3TNilxc8hAvEI8Q4apY?=
 =?us-ascii?Q?Bs1z/nYqX5KihhL+7Bao0p/kRBD9aB1PTNaNXO2FK/+X1dtO6OcctGOZ2mkd?=
 =?us-ascii?Q?IOiuBNH4jGaU+BQJNg/7JH8AieG/PW2GZVVk0tvsNR+YSN6/liKHZad/hlPb?=
 =?us-ascii?Q?JEX/yTjs+NkcGOJXEYWMJhaM1OPE7a51mcBQj9+S6cCay+2K3tCxgA3+g3Gg?=
 =?us-ascii?Q?XJRVshNy3HbLYaCE7iDN27HrCj2CNc+zugEqsX1VN/awLuoRoC51F8XRj53h?=
 =?us-ascii?Q?tgub547ex45KSSU7KK23bTL2N8zYQoS391Xa4JN/W31zPxRFS1x21neA9hW+?=
 =?us-ascii?Q?qVQzE20UfAw0Z6PhjXzw+T4ZLG7oLg/YjFhqO8v4czCvqsmmCVJCbiFiSZ2J?=
 =?us-ascii?Q?2tj3ias7EoEu4/1K+7g0gQENpkSup5SiyvMJqmXHeNOSWLHbywjB2WfpGSm+?=
 =?us-ascii?Q?vo/bG/YLM6ntU7BX9IHsUK8DyZvUwmRPYRPRcmUTqqAF311BvVjzeuHKNB6I?=
 =?us-ascii?Q?Q6dPu6LSm70GgHVle2gTUtBHsxs3TnuNTq75yuEzmxkcT5xqRk+E8/IxUshE?=
 =?us-ascii?Q?fa6tG6utQoD1P7jxE/Sk7FFv3qicqwqskoVTGuJJbXCMH100Z25+HiRiYa+h?=
 =?us-ascii?Q?HYe/tCpH76NANzGGdtoL7RiVwrfjum90kd/bbamXgdaHMJ3WaJMncC9d8Hfp?=
 =?us-ascii?Q?IjjQXiBcoxeh3S4mNCzyO58Ymxj2QV40SFZ9RKjrZdO1LkH5HE6l3J+t9SmU?=
 =?us-ascii?Q?k00qDi8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5613.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wKG2wZ8UYrUHndcEcK4DeotnfOzq+ENonU6XzJzbdxML7vfquP8+oZKwwFuE?=
 =?us-ascii?Q?2odRTd0Z4LOqgVDSkK/gvbjFrJYOzO2btnv+AKYqbV4URpCPh9jD9Msrcmap?=
 =?us-ascii?Q?sAPdk0FD1gvFVjwxprQJtQWuT0ohCek01telxaUF4HUWq0NM7TRpZ4FZaLO+?=
 =?us-ascii?Q?uM/mDYJ8eodCpIUkqMkgUFSyidZgOE+kj0U7Z+eHuWHnNc3TfgQqxAnIgLuI?=
 =?us-ascii?Q?1/n+zkxT/OenQlwUOuBvX2W+kCv6VYw3Nk04YNqADGOO6WA1VBEGu6zg6s1G?=
 =?us-ascii?Q?d3RrFkE2KowmasLdwDOMxZo23/DZpXtE9dKfzZxgZfoZSsEq0NJ4x7au8FBm?=
 =?us-ascii?Q?hhxrF1qU6IPPLrbM0BIUb1P/UOpIk+18QEkr8Sgqd/MgsZpSQuk1Ys9hY9Sn?=
 =?us-ascii?Q?Qzg3k3yOIug2SeZpP8d+jUrxcX1xa77ca6BTACbc3tgNpyqEXIVLQkfw0mP8?=
 =?us-ascii?Q?iciAn4mk08b5JFAabxXzrPtHmm3yvj2PK/2skvL1LD4Zaz4uNVp9xjknuGBj?=
 =?us-ascii?Q?/U8z75wbu6op2DVmZpyEUU4yuZr37JTQ22LtwxOcU17L8s+hgreb94+xfVnd?=
 =?us-ascii?Q?hbEhF2Dm66SzdzM9GP0lsT2vlp5wbYTddfNFSrvtA/430X7CwW7TD7p/A5yf?=
 =?us-ascii?Q?lkmv3GA8f40BgSRaI+pfjldT5S7V4+q9XKZ0c4RbP9A//x/XmZIPRR8+G5KK?=
 =?us-ascii?Q?4faNytKFk8Ywv0G0HBdIzecSEa8YS32GwbAUuMXxWY8kzOPMBA1NUE639Uqr?=
 =?us-ascii?Q?HQp85iiyg38tCGPiuMGdJpbxMXydBcKTW9/9zMaSuX0AGeELslKTUIpHaiQO?=
 =?us-ascii?Q?gVNJYnnqlSLsmypp4gJNxZcxK2dxyWnIEGKM6pGxukaTQZcvO3rrKzluP/UK?=
 =?us-ascii?Q?dUuAxpGmZ6KG8OhRByY+l2445XOIwpN1Ebojjg0wbDyxEu+9YZIhw8xS532K?=
 =?us-ascii?Q?M6X5YH0BCUKRmUsRIkOo2/0/07+zuP+eAm57ZDR6nRGMq1tcMn7eH7ZDS1mt?=
 =?us-ascii?Q?64AQ72YBDyncIkqn/sPRfO8OAsPYLz53H2soYcGCmwzc5TN6yEm+OsdkZ1vW?=
 =?us-ascii?Q?NRO0nc0CoRWPA1aCiyN+uVG0TmmhTdxucKZw4tyOgA5xujirH5XjYPF9eKBO?=
 =?us-ascii?Q?hniH47ALz5ZRT+m89c98lQgGUuok75VA/3Foml4RYfTmlG4/+4fFOx3Hjjy8?=
 =?us-ascii?Q?1YsLCdAKihPbLtD8S8s6nxM8AcORIouPDECuDuKoDksgKOShATduo0kPpIRg?=
 =?us-ascii?Q?K7WzBMt+XGDXprA8IWejdi0LS0HxH2P5VYrPhYyBe6RgI3CxmeDFBivdyMpp?=
 =?us-ascii?Q?HdvE/VtQ7KHeOE4zU9uCf2xYiVl+JgrUpMJwaWavRATR0CGR0XZbfRIgTlBW?=
 =?us-ascii?Q?6XJqrD1LB5tNOwKz0lKsy0VOA4COhcOn+E3BebjUHJmPK1Bukexgk/cSdKPd?=
 =?us-ascii?Q?wm8KgZwGnDILVPNURcmAJQi5mbvDgUedZ4gMal8gCnM0hxA+Pf3K6xtK1CML?=
 =?us-ascii?Q?io6KWMQ4aYr+mlwkT3QlPDfchypIX/RNrJBUys71GkbrpToXIEwKx2gBdh2/?=
 =?us-ascii?Q?u4j7u+Aj8C4f1BX/GMKTTbPHXWTU5p9fR21/oL7bd2TV6ondGm7Djn3yJnVb?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o0BwsKJ+5vP1GZiAC+nnRYcmIQGRPBB+vTYAIFQGPC37CBg5qwoWk30yE67gnL9QbfX7OqH5XOmgvePeN1UJ0WFfVF73fv8B2jl9C+2zAATGwBLKWHCJxVThwlRIf36ar2MlBnYfUO4HfU/7HckeylzGx+AH853OTlrs2QgEdOwxyqUlEgQtFQyh7yVQBN9/i/mXxoJWjVB4BbNSvhupD0xDVBd7SrlUCyIiI2wiUaIRzjaPwtiSuLMoMyTKAmNVC3I7b7/wlluSkxS2dOkjsHv9BDnFPIgObaHTKJKHQrXQCnVBr7YgN2GPvFThq0AqHbK9Fz0fiMrKR5YFfQfNExToduHltu3mYYcx1rSOd9tW7K7eptNeKK1Vm+1MECFhHvWJXFHpLKWGdwcvazRGQBgAKWbfFrQH2Ua976kHBu6UIGqT2mf2vQpEet0M07hoBEmTjvaw0ahhHuYlf1T9KSClKFmLhjfSY7JBtiVaIDrvpPBlYEgpDpEw4u0cvQh7VGDxIO7Dv0ykIp1qX0XyJYGG76mGmQvdIHugG9P1H0cfNwsX3Fd+JpAZ8RLyuoQMaszcB8BP5Gl8Bss0VQ3XBtpEN6Kg5hwXtjICviFhNFQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e68e2f4-5710-4854-2b77-08dcd00d4b68
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2024 13:51:09.8894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwJLt4R0HTgpqDV1FU6HWsmOKI1BdhBLLLTRMUPAUs9MO6KRpxTS/PG0bycC0vQHwMVcSdN1nVsrtnqfuFSRSPX63cp/z+WnvDo/NEzadoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_04,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409080116
X-Proofpoint-ORIG-GUID: mkYchnaTdiFcIKwXXUblzPvE9vEy5z8K
X-Proofpoint-GUID: mkYchnaTdiFcIKwXXUblzPvE9vEy5z8K
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 09 Sep 2024 09:50:32 +0200
Subject: Re: [LTP] [linux-next:master] [mm/vma] 6898c9039b:
 ltp.memfd_create03.fail
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
Cc: Matthew Wilcox <willy@infradead.org>, lkp@intel.com,
 "Paul E. McKenney" <paulmck@kernel.org>, Jeff Xu <jeffxu@chromium.org>,
 Kees Cook <kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 ltp@lists.linux.it, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Mark Brown <broonie@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Bert Karwatzki <spasswolf@web.de>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <olsajiri@gmail.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lstoakes@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sun, Sep 08, 2024 at 09:15:45PM GMT, kernel test robot wrote:
>
>
> Hello,
>
> kernel test robot noticed "ltp.memfd_create03.fail" on:

Hi,

Thanks for the report.

This looks _probably_ to be a problem in the test rather than the kernel.

An munmap() is failing (as expected by the test) to unmap invalid sizes
from a hugetlb allocation.

It expects EINVAL:

			if (errno == EINVAL) {
				tst_res(TINFO,
					"munmap(%p, %dkB) failed as expected",
					mem, i/1024);

But is instead receiving ENOMEM.

This is because we rearrange how we perform unmaps.

In both cases we are failing when we go ahead and attempt a split via
__split_vma(), which invokes vm_ops->may_split() which is equal to
hugetlb_vm_op_split() which returns EINVAL.

The difference is that original implementation, in do_vmi_align_munmap() we
do:

		error = __split_vma(vmi, vma, start, 1);
		if (error)
			goto start_split_failed;

Which forwards the EINVAL.

Now in vms_gather_munmap_vmas(), we do:

	int error = -ENOMEM;

	...

		if (__split_vma(vms->vmi, vms->vma, vms->start, 1))
			goto start_split_failed;

So we filter the error code to ENOMEM.

Liam - could you confirm if this needs an actual change in the kernel? If
not the test should be changed.

Test fix is obviously as simple as:

			if (errno == EINVAL || error == ENOMEM) {
				...

Cheers, Lorenzo

>
> commit: 6898c9039bc8e3027ae0fcd0f05fc2b82ccc8be0 ("mm/vma: extract the gathering of vmas from do_vmi_align_munmap()")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master 9aaeb87ce1e966169a57f53a02ba05b30880ffb8]
>
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20240831
> with following parameters:
>
> 	disk: 1HDD
> 	fs: btrfs
> 	test: syscalls-03/memfd_create03
>
>
>
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202409081536.d283a0fb-oliver.sang@intel.com
>
>
>
> Running tests.......
> <<<test_start>>>
> tag=memfd_create03 stime=1725647495
> cmdline="memfd_create03"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_hugepage.c:84: TINFO: 1 hugepage(s) reserved
> tst_test.c:1809: TINFO: LTP version: 20240524-209-g9a6f3896f
> tst_test.c:1813: TINFO: Tested kernel: 6.11.0-rc6-00249-g6898c9039bc8 #1 SMP PREEMPT_DYNAMIC Thu Sep  5 20:53:00 CST 2024 x86_64
> tst_test.c:1652: TINFO: Timeout per run is 0h 02m 30s
> memfd_create03.c:171: TINFO: --TESTING WRITE CALL IN HUGEPAGES--
> memfd_create03.c:176: TINFO: memfd_create() succeeded
> memfd_create03.c:70: TPASS: write(4, "LTP", 3) failed as expected
>
> memfd_create03.c:171: TINFO: --TESTING PAGE SIZE OF CREATED FILE--
> memfd_create03.c:176: TINFO: memfd_create() succeeded
> memfd_create03.c:43: TINFO: mmap((nil), 2097152, 2, 2, 4, 0) succeeded
> memfd_create03.c:96: TFAIL: munmap(0x7f9b26c00000, 512kB) failed unexpectedly: ENOMEM (12)
> memfd_create03.c:171: TINFO: --TESTING HUGEPAGE ALLOCATION LIMIT--
> memfd_create03.c:176: TINFO: memfd_create() succeeded
> memfd_create03.c:39: TBROK: mmap((nil),0,PROT_WRITE(2),2,4,0) failed: EINVAL (22)
>
> Summary:
> passed   1
> failed   1
> broken   1
> skipped  0
> warnings 0
> incrementing stop
> <<<execution_status>>>
> initiation_status="ok"
> duration=2 termination_type=exited termination_id=3 corefile=no
> cutime=0 cstime=187
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20240524-209-g9a6f3896f
>
>        ###############################################################
>
>             Done executing testcases.
>             LTP Version:  20240524-209-g9a6f3896f
>        ###############################################################
>
> -------------------------------------------
> INFO: runltp script is deprecated, try kirk
> https://github.com/linux-test-project/kirk
> -------------------------------------------
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240908/202409081536.d283a0fb-oliver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
