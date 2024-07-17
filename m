Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18350C3DA60
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721238206; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4Ywta7x3lfu6FewfLmtMviBe6Nykd0R/z2p4jiXwAHs=;
 b=TFZJKRs+mCqOt6ykTjEI+9C6VDfTAhKR0jjCuc0fInWgIXX0/TyYvfkbyr91/PeHdxAWa
 /CU5azqnQdFD82b7Wp7vixgX5T/eAW8Dq5PkEWp6ryzsZ1lUxrqCgPbeDsSu/g96dMablxi
 dCtGAUdSL2jdP2J/i3YwgcFlHnNehDQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A53A3D1AD2
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 19:43:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 878CD3D1AED
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:43:03 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=liam.howlett@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5A23E617630
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:43:01 +0200 (CEST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HHfe4V018276;
 Wed, 17 Jul 2024 17:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 date:from:to:cc:subject:message-id:references:content-type
 :in-reply-to:mime-version; s=corp-2023-11-20; bh=BtQGnGliepslM2U
 2owk6QE/izXoH13T/TH04asra/sY=; b=BcFLr8nt7ljVRK+yNB5SFslwp2MGC54
 NgyWYTbcSXPyLq/7h0R1NGmKSQEp2779yHmmkI3SQtF9YvoKlS5dWmGFcG9HOzKK
 hBG2wGkn+y0tmp1U9u8xvhzUEVxWddOkcUOiSqTVgvncfS8ouS8GXj3F2kWeeZIW
 E9MabvTETMX5BweEAYYTyHlx+mfyQCaYQZ1/otdOVzPGjdwR/VctK4jNcNey8zHo
 zaLz5QVYSyzfY8z/7DjX4lrNIqTl95pUwbzY4eEDCpLeEfQhwHfgg4PQl1s4efje
 VbiQr6smrTRAWiieJKMvxls0f43ihbnzaVeJiunXND5Hpqyp34C1eBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ejjdg032-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 17:42:44 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46HHKm8O039531; Wed, 17 Jul 2024 17:42:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwevbjgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 17:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izjgJsyZoNA0ekoo6kKYzn+kVkesH8LbtdGUM8TLGlrFHmj2eKvNrYHlRpPbDqB+Ee0qJEBsObFm9WoQ5tfVn2imx/r1b3SXzPFxebZ6BT3l2qylhjIie9EkGQUWlefcS2Q2vtT7CowsIY/CkiQlUvLlaxK5RBbGiw+l4ixrMA3qV0gFi/O7btxiql0ZLZEcOKb3nEdoY48TC1eGZCC9Dec4rBfTzxqY9p3Eh6VoFiBYXjuZb0MWscZ8DbYxwpXRQ0K4X+Vf8aoQgk72HO0AqVkJczY8EOPvtCf8p5z898e8eGBJN1hxOpbEK/7pqO22kgkbHt9P90O8q1/sk2i2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtQGnGliepslM2U2owk6QE/izXoH13T/TH04asra/sY=;
 b=ejqfhRfDGOs1H3ftMOS3osKx6SVG6K4HIMo9yPAkOrvhgDWlvtIG7NMndU6XVhok66dL1+ISo+pX6wQ6auMBBiFIRse8/E38yqC6Hud4wOO1Ie7oPxIUH6duH/DWhUKYzGHvn8xSTRWyC453YH61YSn4s9BSwAsQWUiFizFN22fhxGuk1Fghe8Q4IDqiQdHnoPuXTpqadvdOSWChY75qx+9dOTJHUgjs35P4poEiGbbZZov83qfEjq9+LB04U1eDk43ch8xOIzo+jdrtUlu5vcnn9XHPJ0qd4ST90opGSV/QE4/Zh+Q6b6g7g2NZddRjR84eoGPeDexxnBS+3T/gyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtQGnGliepslM2U2owk6QE/izXoH13T/TH04asra/sY=;
 b=mbtM6jQYxQtAW7WXgynJQY9mkVT+tBDCKtwIlKUpu6KjaUDXgQGj6DT+lQetgDqe4z3SuxFL0Emopi8xyX0RD10AJaP4A8QELL/gRPvdpQGcL2yZhRq2LhPnx3+scX9+uKqj12sNOqlP5AJf3r14cYSGg/eaFLiM1CBW/b/kUK0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.33; Wed, 17 Jul
 2024 17:42:40 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 17:42:40 +0000
Date: Wed, 17 Jul 2024 13:42:37 -0400
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <hdmrqvvszg3fmvc6qtmia42y2d7gfpsqrp7totg6pibidyj3rr@eaze3r45vx4f>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-mm@kvack.org, 
 ltp@lists.linux.it, Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 sidhartha.kumar@oracle.com, 
 "Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
 Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <20240710192250.4114783-15-Liam.Howlett@oracle.com>
 <202407162022.5a730c37-oliver.sang@intel.com>
Content-Disposition: inline
In-Reply-To: <202407162022.5a730c37-oliver.sang@intel.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0447.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d77661-1a2c-4742-5310-08dca687dace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QwM/VPxA71AmOgjhc0/d3JZsDrBJHEHnEP5T/rltc24O39DsYuNgXRnE4HOa?=
 =?us-ascii?Q?JHixUcWgwkawYfpUo7l+QqPHQjZzzydNBcYep2XSZb11HFM8RODoyeUrdl4c?=
 =?us-ascii?Q?UJJYjDXK56SCnMIHQ1urme/OtDKzlJ5WLUfoTXNI7vYlDeVycdfcB27wWF3f?=
 =?us-ascii?Q?LFIgb/xIgcH7ALLPXWX+IMOXh0EigvYypoox2qJhr3E07zLNvm0rJOe006Zd?=
 =?us-ascii?Q?zoMoxcH90YZECvBcAStubGktWOGyMJ9Up0g/PigFFCX/P+MWx8eYqyU75Vda?=
 =?us-ascii?Q?SG24SogtvQP86EC3NQ+L/XmIiLcsZg2MXb3inPWOeEzGY4YXpCgLswIJYf1c?=
 =?us-ascii?Q?XZJcVD1hWAqiTRGmBFpm/6nL3QrYbIfPiXz+rhmLt6PNPKnWhr+dmvkn3QKp?=
 =?us-ascii?Q?hhB/6mtrGdpm9Cu2ghAymV+onPSmXI08Gr8Ib32gp0qLiyHXwWSCzm2Sz6wL?=
 =?us-ascii?Q?MWl4dcntyQVKz2Yuxcid1GiC9kNh1CcK6A+t3GFEAUpc/n2fB9sEW/dud1Pr?=
 =?us-ascii?Q?21/WOb2qu33lnn0VngDrHZmGa5HJEhg0I3Msbv9NB3lDavQn6xDyqMHSYS4M?=
 =?us-ascii?Q?CRjNPrUb4CB2tlP+2upute2zAEFip1VpTDdrPHUPTgO2UAgZaXMrUzsfODIk?=
 =?us-ascii?Q?OnZeSWUxuaRH71+pOXlSOB0D+49yMtWoudENfSe8wjbT8sa2RrgGzdTbaZ8O?=
 =?us-ascii?Q?/ySxJN8k4P6b1ViGoqeIFwo2qsooqxSbjaIku0v/eUfdsKbWKTtZD4EL1npo?=
 =?us-ascii?Q?f4VVO2WKea1tXuCS7534omsZN5iyoeFE9RMckBnV+JYs9gFQ+3kVcp6NPtV/?=
 =?us-ascii?Q?wAKWUD6ZPufMG6FICRs/laNJca8yv/2SdbKHbQaF7OOj2qsUW8P7fK9xtGBK?=
 =?us-ascii?Q?KixiVqSdW/lzFQ/hS+BR1CdWwkC2JxLnbcMmcl4DBa24FgnrC3POHii4rd8o?=
 =?us-ascii?Q?aQ2SxAGOS6ZlBQRGcsY6f5noqLCSInOMhUakvgecV7Y6qVa+WQKZkb/eal+y?=
 =?us-ascii?Q?Fe7XmtzKxGc22hoqJcUyjXUkpLJReqGtX/558IQAApOaZLSxyYnlD+Cb+4L3?=
 =?us-ascii?Q?8Jhf5ioeQzMZlX8pu/Onu88pcBzEs6qyNsYg3+HbYCxStf1UqLE1540TTMh8?=
 =?us-ascii?Q?uIeWUXSPe/YX7JsHeefnghDBkYD2VzQ50TQVod9qMbDQq3ifInyum6EPXLzi?=
 =?us-ascii?Q?9mX7KW+pPSDefgYVJU7wHLYuItXZGIg3aV/HsJHrwwjlnSeTv05wavQmQzOl?=
 =?us-ascii?Q?1ftP1X337TJFQ5K4/Su5tr9+TCf5+6/7UhuCfnS8SQFHEAie2vW0Q5eBQUFZ?=
 =?us-ascii?Q?daM4sxNuhLxsOt3GbORxJn5Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR10MB7933.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wX/70oE+t/kWnMXL9Mh2/zArCZH/Twc8NC5/SiLQQHMTeHL3oit/fMlDl4jC?=
 =?us-ascii?Q?+BYzEPTLgY99/i0HBhL8/9IC1awKx7Y3EljZnH41IChYFsi7PpyIyXoIdILR?=
 =?us-ascii?Q?OjXhCecuHIaltvrD5zp7ZLXzwim3i5dnLCHdLWN+SLvYzOC1MpYXZ407Ov+i?=
 =?us-ascii?Q?5TjX+0r9r0rd5UK+q5TMgTfeFVI6VXB8DDkaS1x4rJFZ/md9SebyGDL1Dc7J?=
 =?us-ascii?Q?yFsdVJ/FgqipRst+2gomVzkJU2UT9mBcXG0VP3MhibrIJhiVwMfnoQFL2Vme?=
 =?us-ascii?Q?c7n/w0ZinpNCzgqoGoZYUllwsfhOQQRaht+IGVtO085NZxePNP+XCvqPILPF?=
 =?us-ascii?Q?GuSycoBjqFHyxbppTKYoiL7vvdGko1NaXqmvsCuCkB6zxK2RcvdM2OdQg83G?=
 =?us-ascii?Q?ickzL5EKbuXB46gxE3QMrxX91x24FHO9EYRUDEZqIvSG644OyUFHcn3CaQ9M?=
 =?us-ascii?Q?Dj+eRLwN/I9q2Ld8wpwKEpO2rSuO9Wb/efr+3eeIFMwrv1wM+fbN955Huw+S?=
 =?us-ascii?Q?/fUzdbS7JS2x9rxmzdRgrsf2/BPfVyEf1gwzBcmu54x2XQejXxLcwR48tU9S?=
 =?us-ascii?Q?WUe2r+qIC+To/XEJExjGDMqaiA9wJf+GCgo+3sSyLDG0HgdrRHOIZldY05I+?=
 =?us-ascii?Q?QCd9KzXLjVfQZwmXInrVjeta4K4PNtHCK3VG0Ux8fH37wgLKfObxIjoPUuK2?=
 =?us-ascii?Q?V1iYOBt7XyJyp+DHrbHtvA28KGHlqphOyl+KE1feYuPTN460bBpOXpxpg/qV?=
 =?us-ascii?Q?pAAkJRqkGv/5dwHYyYz4uzWUnnu5q/3H3aaRjp1A10FRDmWkan4zC9dQpwou?=
 =?us-ascii?Q?CiRFaSILjvC/K0NDQsihh2P36ZaYZcpC+g3KOt3OqHm5aepDvMDbKZIymNwt?=
 =?us-ascii?Q?YtnAgUWtfieH7OUnvfYSA6AXGeerbcuo15WwolH5422pr15SodQltabJe2Z+?=
 =?us-ascii?Q?X/2gDxOPlVEaHw9gDdbl5+y70hL81gtUe+WsZlQOaGaKHT3x22+JmibHxZQs?=
 =?us-ascii?Q?QWWw4Bb7IIWIdtw21JjqoHwTIRnopnRBItzBLYePala3QBNyeR3D4FTNC50d?=
 =?us-ascii?Q?5s6ejiZEqjJiRpqFW0CqsN7ghE5zpqWj3EGP2jz9kYLHaPE0VDeem2b3ew+C?=
 =?us-ascii?Q?AO/e0NBKnd1zDGTH02PK0Ep549s8Me2JfD9YsPpql85sGrBD02ILiM9nicQS?=
 =?us-ascii?Q?PNmlCNxe7Vbu1lgiS3an8ch7bOJLR1XlNhk123We433nd/SBblhjfarekKu2?=
 =?us-ascii?Q?P3nn1bcwXJQAT7CqU3i7Z/c4aOeZe9Xg/N0Wfay3kVEXOLofZi3ER31QXA74?=
 =?us-ascii?Q?dNEgxE+guglL2w9yK/LA0pddBs4K2qiu8nv4a7dhxE3iQGne44SmT94x8jZy?=
 =?us-ascii?Q?ptNEnGFpkbk/OC71rfJZjCk8cNWnyKMiWwyasZoQi5Iss+EaB4vuBHUf4+pX?=
 =?us-ascii?Q?S8nXvAov4gaXQXAqcPCkvAweHD/b1RFNMYynToYMTFQ1ZvUOuAwdLFNiHdWf?=
 =?us-ascii?Q?AdyelZlGwN5bvMImwoTbGa+Etzv06Kpc2csT4oqbPII3T7vv3t8KiqO/zvFq?=
 =?us-ascii?Q?kLbCkLA+a2aNm7c1/xZ8j7GoDO4VTQOL16u4r7el?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w1sbJpA0pd5RxmqZm0GHrX117nqqKK4gKfjSVAev53umoe9jNsegcGYepioZdjhE9osjv5OPHdOj4aATU+OqMNip3TIu1El+pJ1h4sRMSycdHEadN0BfkFUkZgC9O4lfZqYYVsw+DPEbfU1baYLCBKaAnZxzmvk4FTwkUidFw5plHjxIUsqMHCdFNdx4wA+CaDwaZLECdWeeW9uJhkglxVE2Ehoz54jeNsyNHgaAeumB+4Wp9Zz/TNb8XvFJrcyvj6dRx9J3FjaE0bBt4iv3YP3Q4CmsXcH9MENHweAcnARNfZFCW1uoU67opOB89qXAeHthD3hZ2/w/mMaFsiXC9rL/17mMqys9xx6vcGvwGaCv6eiFofkP9ERfWxL9Qjt0dKqV/CwooJNslT60tmnM31o6jmBMC9H0AaTga4WQ2jLLiYK2X36ipCl9dxQfwRHG/22oxvgKDa60QC7/PvyPAz7A/qallvcOunXR7akC8NaX3kodd/ltovtZgP5W/4Ddk19ckIQiM7EkPlo9iXykd22YaJTcE1WxOq9Kl/5HxFcSXoX3sisx+yz0k7lsEVbfDRWmSecRY9xZTBopJFdYiT1f5g3qCsg7RNbM0LGTdk8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d77661-1a2c-4742-5310-08dca687dace
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:42:40.3438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ih8A/3sC6uAJW7euj6RMthMAcVRGKh/9ckrv80cfxVc8c37Fp9uTDtwPgvfDEjU9BftPz6IiHJvXGuEJOIdkvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_13,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170134
X-Proofpoint-GUID: 4r4glHjWB63tISUoQSm8PtY8wGh57_s8
X-Proofpoint-ORIG-GUID: 4r4glHjWB63tISUoQSm8PtY8wGh57_s8
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 14/21] mm/mmap: Avoid zeroing vma tree in
 mmap_region()
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
Cc: lkp@intel.com, "Paul E . McKenney" <paulmck@kernel.org>,
 Kees Cook <kees@kernel.org>, Jiri Olsa <olsajiri@gmail.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, oe-lkp@lists.linux.dev,
 Bert Karwatzki <spasswolf@web.de>, Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, sidhartha.kumar@oracle.com,
 ltp@lists.linux.it, Lorenzo Stoakes <lstoakes@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

* kernel test robot <oliver.sang@intel.com> [240716 08:47]:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.hugemmap06.fail" on:

Hello Robot!

Thank you for finding this, it will certainly help me improve my next
revision of my series!

> 
> commit: d793398401db9fb81084bd4fe2f782342201df18 ("[PATCH v4 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()")
> url: https://github.com/intel-lab-lkp/linux/commits/Liam-R-Howlett/mm-mmap-Correctly-position-vma_iterator-in-__split_vma/20240711-075019
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> patch link: https://lore.kernel.org/all/20240710192250.4114783-15-Liam.Howlett@oracle.com/
> patch subject: [PATCH v4 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20240706
> with following parameters:
> 
> 	test: hugetlb/hugemmap06
> 
> 
> 

This is because I am trying to set up a MAP_FIXED huge page before
hugetlb_vm_op_close() is called, which removes the reserved huge pages.

I will address this in v5.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
