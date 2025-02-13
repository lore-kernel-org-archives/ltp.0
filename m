Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53230C02198
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 10:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739527624; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+v2Jlw4Fcdvz5RLxelnyeuH9y2vUGkhGmKfzS/RdYKQ=;
 b=E4py2GjGG9cnxZGlCoIzHeF8k8J43g++NCMsSPv+awfyCeLMboxH/TVScnRVp0B6/vpWe
 +ssWjlrDf9GQ2bc7QxAMczQQujua9JHK3mzDMgfIqq50w4UIzAuLpg/Riwl8bGvuNaogwh2
 UmonsSppNRHcEZ3lMglH7HtetheIoJ4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFD1C3C9AF3
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 11:07:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 576043C1DC3
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 16:01:26 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=rhythm.m.mahajan@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4D0CE142AA52
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 16:01:23 +0100 (CET)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fhMP022452;
 Thu, 13 Feb 2025 15:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2023-11-20; bh=XdcbkpqSH00NxHvB7C
 YxXwPiK6iqf2j+QDOnpzjzT3Y=; b=m3gPkvzmtCbJW94iSmD7rZq0oEuGKGVmul
 v9dsxJTpVWcK9uz1YwQgDp9vwDoVmUPcBaVpOKHXtGa1OWt/tTNnG0iyzLW004FA
 vIazFpCz6j63si233uwmj5f0yeic7OKGFJqWBBbvcMXhzF6cySGS+2kwShIugpqx
 yEs32giHPpCwb+p5/DeplKZBzApIdMHbQTmXXbd7IEq3jDOfWoNw3EZecn4FKd2u
 vSeGWHZS19P/K96qzr+gxnMs0eTwn1mWOxO7v1JDXoAFRMdmm6r1rdisR8x6a8Yp
 DFpECM2GbinPkxGTM/XwSXEc+w3j6nATIrZifMGJYhB6jDmKgXzA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s41re7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2025 15:01:21 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51DEOhKC025134; Thu, 13 Feb 2025 15:01:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqjbpa1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2025 15:01:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMBEOJlMN7yvsWrtEuHBtV2JLvNrlnkXwMJlgMqMn+EC/ykw4nBCRS2i4qsbhmOyx0XItPZJIZfcQ/I3LgQ1QNN9Jyoyr+3WOq+yd9MhfpNLImy4r5tc61DUU0r2gj5Nz91oGuYI97pyQr0cVVuMKC3QlcZrrTRPnD45pu2adUODkEm+sOsnQyLLdxzIYtDpZ/j1bvXJg1bNvIsgyfptw1huuhEp1zITqSyFQbJsR3iqHkAE2dXKIkS2623g53CyeXXZDlb1Vw2AkWRW0TleTv/lpKRCbQoyWE0pmqjHAAXsotHnBV/5rd4zYuDc5x4CtfJCP77HSDvXnTJWOiNooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdcbkpqSH00NxHvB7CYxXwPiK6iqf2j+QDOnpzjzT3Y=;
 b=RJFHsULZXIv2osQRJitXlitGNtO3lf3fSqmatUUTSANU/qJksw1YCH+tSiDxpRDKqHnGcR+OAlJk+yrrjOhdWus+/C9rgYnaHHcwRM7t7O6PklkKqCrlUwXbluYbAenmXVRrKYQ8eOZR/TIaij9BOGewIqvm1rz94RjUUTf2qT5gRgmDm27hs6kIm7NLLbPvYWZJvileD/Ya6cjrrPAEMtMDhyDWJCKY/3/aVPwUP0iFaOtNZpy7Pxp2BHPTgEr4NA0oZzpBQrsNTqukqlit2/Vcr65O0sIQ8OnTE9Yo7JIOtJ8KHR+X0tMGHTBYf3oO73AjE1MRtOv2lJt8IpuiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdcbkpqSH00NxHvB7CYxXwPiK6iqf2j+QDOnpzjzT3Y=;
 b=QRrvuGvNh8QiYPeKWx4YCTV/4ZycXNrpivWQUhzdTsNuCzZPwT38QKez70Y2wr2AUjQYgugsMdj5hZjYGrCPzvajbwIDoFvFdqKKqz74NOJeduaY3X4rV3QjJ0xo8Rbsmbtvsucqvz1zv/NxGPlkgyVpkv49nxxx+6xW0/cTAMQ=
Received: from BLAPR10MB5380.namprd10.prod.outlook.com (2603:10b6:208:333::14)
 by PH0PR10MB5627.namprd10.prod.outlook.com (2603:10b6:510:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 15:01:12 +0000
Received: from BLAPR10MB5380.namprd10.prod.outlook.com
 ([fe80::ef73:6117:7d5b:3227]) by BLAPR10MB5380.namprd10.prod.outlook.com
 ([fe80::ef73:6117:7d5b:3227%5]) with mapi id 15.20.8445.015; Thu, 13 Feb 2025
 15:01:12 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] fcntl27 and fcntl27_64 tests fail on nfsv3& nfsv4 for
 mainline 6.14 kernels
Thread-Index: AQHbfiFWNsfx/yDYjEaTGAeekwdZP7NFq9kA
Date: Thu, 13 Feb 2025 15:01:12 +0000
Message-ID: <40043b19-65a9-47b1-a759-4f1478d3faba@oracle.com>
References: <BLAPR10MB53806691A64D8003A5D0FD5CBCFF2@BLAPR10MB5380.namprd10.prod.outlook.com>
In-Reply-To: <BLAPR10MB53806691A64D8003A5D0FD5CBCFF2@BLAPR10MB5380.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BLAPR10MB5380.namprd10.prod.outlook.com
 (15.20.8445.012)
x-ms-reactions: allow
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR10MB5380:EE_|PH0PR10MB5627:EE_
x-ms-office365-filtering-correlation-id: a31f9991-d797-4728-0d47-08dd4c3f41ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FLXF7UhBB8JSlQKA5oDnkQDBB/1FVJ1YTLVqy4LvdZHZqIMKjFHZVZdheptV?=
 =?us-ascii?Q?/KzYl/EHS0K2OsmvgFOy1s3ZMV95t/iRUnKJ7ctKXZPpSOOW2Cl7XmqbhYXQ?=
 =?us-ascii?Q?cq0CIBdI+49YXeHiE8O9zLOx8x9viLvHISjAU2cWGD3Zvv9z7au9Ky9ruQgL?=
 =?us-ascii?Q?MtNxhv1vpeuX5tNW9D8l7drzO7Z3VFEUSO76towZKHA0pk6J1rE69Jof4pC5?=
 =?us-ascii?Q?6Gbal4SyglFGeDhA7XxaTapzMp/eYPhLM2TiCyuM7WhJvsgPItpFasVZZX1Q?=
 =?us-ascii?Q?Zz/t9y/lPHcPl09Gwl4kDxqcEhZMnTxIyoFQ/OhPLn/peHDRYvsPSM9xK4Z6?=
 =?us-ascii?Q?eURF+tMwb30cV61tkFMOJRpmZZAzcn2yVDR5QemMWhx33VYwsTEBZY+/v08m?=
 =?us-ascii?Q?N+0WXf3YFQG9wJ6kSJELj35gy4sZnxY0ZlZzK0wTZpKwkNQOcW0iOvF0DreT?=
 =?us-ascii?Q?mxjmEP8W/02UfoFZEHgDdKuyYTOyLJs86Xv8hDDNfSYoG4+2jv1Z6WgNCbqh?=
 =?us-ascii?Q?BEBfovPEq+svf8xtoPv18CEH5IEEpgSSN7/dC3ILw7vb1IIYZHxhJ/6oqbls?=
 =?us-ascii?Q?0FX1q+8rpkbuP/Iz9VGBkNBcdfxTtzCuw6rGkoVTJIOZhhZBE+yPj5d+QoGP?=
 =?us-ascii?Q?gm2Jnf7TNCSHQUc50WZbJH8SMwcxPfJBtJWtglbaDJANRbE434h/nmEDZf6D?=
 =?us-ascii?Q?JYXxXoc6NB3qBQZ0CXY7xsGrfKW8Cdfw3bN4uPl2syQ980/SQhdql3sQPxN8?=
 =?us-ascii?Q?OW9+C1q1c4VaEpNEOcQxLa0uJ87QkOQcXr6cqHEhTQ10tFuyEeuwCywuwM3P?=
 =?us-ascii?Q?9sEFJA2+CqcRlIxKtKE6O63UwqGRe9dyq3u71b2cmiAoOGVLAODNN+3Vqt4S?=
 =?us-ascii?Q?OvSIVR+eozsKIqyZe6ncfMCzKZOeQjX64/xPfYYUy9zHDo6y+WH2nxEc9K7x?=
 =?us-ascii?Q?v9npPUBqLdCmC7O7MIjtDv9rkdxlHo5Nxo7KzgxdhQ7h375vxYCG6oArqwWs?=
 =?us-ascii?Q?nQuRZZPT1VKEqaJg2IKh0EM6bRK250meYcz3uXZD4TA9pEERBPrjIFQcaGDV?=
 =?us-ascii?Q?WswROxjHmuyBvwjr0QCJsB71eFJNT/7Jw6o3+amdZMhR2E19xxVYSh+UDCyl?=
 =?us-ascii?Q?5YsIbZAP9D+1OotuesDbiZ1wDvHcxklTtM2gcyBj+i3N+truTiDgslad434r?=
 =?us-ascii?Q?OTCbfpdAuD7uJROz0o3Edo3t3pgXiXvBhS6dem6Bn1kG1P0HNwGIETWkolew?=
 =?us-ascii?Q?Z5WE47HHKdoUoxfx/vJ9oL2kWj5/VVVYoaqL9JKNGthKPxraIot31VKilC+1?=
 =?us-ascii?Q?C7pL4fowBx7fWk1QhL/+G/tljeYsa3Z1TletyhsRzWL5ZItTyynJ/dMab1XU?=
 =?us-ascii?Q?+txn1QTvgHHDwPu+hIM2NHwG0zHPFMCl5KM9hVo8eDuIDnFGmw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5380.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700018)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q8/L1MS9HLRJn5IlN/Yo+aOTdIRhFRPLQcCXFnGVQzpBtgClBjEWHW3nuc2H?=
 =?us-ascii?Q?fn6J67XbDLMYeIWDX0QETmDQEnT9GqiNKTD6Cqrs1MTjzBTcV8/zq4vV6NiQ?=
 =?us-ascii?Q?1i4CKUTo9WQJJNct6L56StJCLUtV8hxBrSu1FpNYm2+xJtHnCtu5oakrKLvx?=
 =?us-ascii?Q?e257ctAlwkuvsmy3EfXEupNBTo5oFOEEUnReRfGs49bn6BzLWA5vMxKacXJs?=
 =?us-ascii?Q?2Vzpzbx2IqDeiYLaGvNXjlrtAzdzxrV5F0fPbZaM3rwM/ybtivSItV2fLWmp?=
 =?us-ascii?Q?F88Gkq7DTujLUx7Rthz2ikbSGQtXEvtQWQzxu1oAxcHmT1a3PxNT+HJjB7ck?=
 =?us-ascii?Q?ggdAU2cz2Ib9tglB2yNfaimJVY50qoyV23YBx/iv4IJaj7LK4VqycDFBKX25?=
 =?us-ascii?Q?gmPowXrh1FL75CF5DAXGsVcyy2wOyCbIUBRWgbQF9l6SVs4NpQHSwj8wQo5N?=
 =?us-ascii?Q?uYqSJ9cOYWVrsNyde0RVlsXO8S/jZh3O0gQAA3y73Uspz1zk9Ydltqwurm4/?=
 =?us-ascii?Q?iBGqCG6UIWcm3LIQNmVo2CIL4fQs0xJ+aqQknAerhmqSqw8ndBk5SJSyEgV/?=
 =?us-ascii?Q?AMLVyNif+ytYY7EgovV7tyn20MDP+AV0ftRQ1vJv/B+Z+jxWLgU82YEXm+AL?=
 =?us-ascii?Q?GTXV5TDUu7VeR4ICpcRDI6dP+O1EDlQrBTJljZBjEG09XLAveV6VzfdXh4+j?=
 =?us-ascii?Q?YVUWmuqCujkGRrSf4v6Tbr5ICSK5X1lY4sdIoryNFtSSV9OhC2Q+ZGx9teIP?=
 =?us-ascii?Q?7sDZyK+0pTFhgSeOuqPaxwlwX0CEvjt4VTjdTLnHfEfh1DEVnyybXWl6YTMA?=
 =?us-ascii?Q?0Mf5i8PBpi6Eq6UnxhRE2fqylCSJQNehOwCi6QZWcO78BrwFia+gO39WWS3S?=
 =?us-ascii?Q?rwapPTndI53giv3XYJF8T4qyM0ZznGv7P96iwbNxD9TooJhLmkWy9WBwqak7?=
 =?us-ascii?Q?NyHqGROvjx6BBSnFrxcgsOiLTsW0d3Pb+Bz/5eD53a0hXtIhVyqETyKDzJYz?=
 =?us-ascii?Q?lXbUaHMOXYjgCAga0whiatsBCxV5oh5KCq1YHSvzpJlZg+p0T+Eh7uKbgzdh?=
 =?us-ascii?Q?dCjs1CCob+f/2lvfHhOs9xj28k6sT1/9FBdK9bughVtMepgXyMrIhW1sGwVO?=
 =?us-ascii?Q?qaRN6CVHvFgXDokBIPRBwhzWduTmw6VMBxTOimKyAP9o5xQgwHDDpaWWTx0S?=
 =?us-ascii?Q?pUazyb/8C9iRw8RERYgWNSj9bm8W0JkscyDfyNM3CsG24begA+ECoh3q4Ja8?=
 =?us-ascii?Q?F0FRLz9N7iisnnsd/PEAN4/LvxMpBz86l8YfLYmEgNHLsmMJ9DLs/tgc/7ZE?=
 =?us-ascii?Q?44//dHz2vyV4NNjfb5a2NhqzwTlwvw+4RCdDnsVukMK13emnBExFX3Pit+Zx?=
 =?us-ascii?Q?YQ0HECrNOYbk9kgIMhic3AenOQwyTDAgt6Mc5saBhGgpltLsKCMJPv8uc4Dw?=
 =?us-ascii?Q?M64W4YDW+zAOolrNOXfq6ItcVCif0mYuOH2mfLqN/1/wyVhseHGu27jW6jgt?=
 =?us-ascii?Q?yojA4ypX1HyitsX/ZVx+V27SmB19pppN1UnzUD2tMokBxK4SqclAc78a02lr?=
 =?us-ascii?Q?8IXpQeB9ajSMzhh1gI0lYe2f15NxuoF1CWO7SUMnwTO/O7d/+lqHWdbOAFIa?=
 =?us-ascii?Q?YpvwnbVGLGYXn/78vUM6mmE=3D?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eiYKZkOWwDT8Tj+T73lU/I87B7qDSqFIhZtVWGy+yLcQHlxOZwHZXWV348RkMkqrAp4r3Jdu4rYBRMu52pWz2YV2XMyXeekklgp7IVST14twgzx5NIUGnLnJfHN2v+PKlt0ocxr4W79SyRYPyLimLr6Ob7uZrEI0eVCUm0sU6+JFuhdMf4V6pLb+Sco2325UUQdgi7K9tD/11vMLGX4Lj61441o2boHX7HcHBsQpK4Zr/cvx33j3Hys5aqUFPyJm9R/e5UvNqCahK8VYteoKAVJ+cie5S6HKBbxoim8JhGblYnhii/jjh6T8M+WKs4HfCggVmKyVsyf19f/hbOKTjKUhUyrEegjgWwN3WTEJhZUyZRf2z++IvQbVaOlD2QeIqbq5mR0acCtmVK98vzZ6YsbkF/xJWV15/sdUsf2yK0dSHzJxKE/JzhnSvjWFHq5lKCKrqQFg0EWVZYCrFAxR63ls9SHM58bWb/B7YqRi+6Xe0Sav9KMPxioWYstV5L5pJHEvahLH2R/j8fxPNP2m3O7BStS7b3DmTuWoxyPmWIwX8A+cJJLzJM6fIgqDFGgnVW7bBEW4p6ur4htLMyf7ggypjg5wY4Bg/TFWQsVogGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31f9991-d797-4728-0d47-08dd4c3f41ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 15:01:12.4711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylq+YujdMl+WeFBv2R/xjxqxM4FvVGzZgKQnoy84pp0/FUs1OvqscgNidP/zF3FxKXHarSjicFEf4ngfoIANXvhJo1gyJrfTZXCpnTQnRm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130112
X-Proofpoint-GUID: 83FnGiqPzBm5J6jt6KLvEVfnM-flh84m
X-Proofpoint-ORIG-GUID: 83FnGiqPzBm5J6jt6KLvEVfnM-flh84m
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 14 Feb 2025 11:05:57 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] fcntl27 and fcntl27_64 tests fail on nfsv3& nfsv4 for
 mainline 6.14 kernels
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
From: Rhythm Mahajan via ltp <ltp@lists.linux.it>
Reply-To: Rhythm Mahajan <rhythm.m.mahajan@oracle.com>
Cc: Darren Kenny <darren.kenny@oracle.com>,
 "andrea.manzini@suse.com" <andrea.manzini@suse.com>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Adding relevant people

On 13/02/25 7:54 pm, Rhythm Mahajan wrote:
> Hi,
>
> fcntl27 and fcntl27_64 tests fail on nfsv3& nfsv4 for mainline 6.14 kernels.
>
> mkdir /tmpdir
>
> yum install nfs-utils  -y
>
> echo "/media *(rw,no_root_squash,sync)" >/etc/exports
>
> systemctl start nfs-server.service
>
> mount -o rw,nfsvers=3 127.0.0.1:/media /tmpdir
>
> cd /opt/ltp
>
> ./runltp -d /tmpdir  -s fcntl27
>
> ./runltp -d /tmpdir  -s fcntl27_64
>
> fcntl27.c:39: TFAIL: fcntl(fd, F_SETLEASE, F_RDLCK) expected EAGAIN/EWOULDBLOCK:
> EINVAL (22)
>
> fcntl27.c:39: TFAIL: fcntl(fd, F_SETLEASE, F_RDLCK) expected EAGAIN/EWOULDBLOCK:
> EINVAL (22)
>
> fcntl27.c:39: TFAIL: fcntl(fd, F_SETLEASE, F_RDLCK) expected EAGAIN/EWOULDBLOCK:
> EINVAL (22)
>
> fcntl27.c:39: TFAIL: fcntl(fd, F_SETLEASE, F_RDLCK) expected EAGAIN/EWOULDBLOCK:
> EINVAL (22)
>
> We have been seeing this failure since 6.9
>
> The test no longer fails with the revert of the commit
>
> cce93d3a3 Refactor with new API and merge fcntl27 + fcntl28
>
> https://github.com/linux-test-project/ltp/commit/cce93d3a3 <https://github.com/
> linux-test-project/ltp/commit/cce93d3a3>
>
> Could you please confirm if this is a test case issue or a kernel issue?
>
> Thanks,
>
> Rhythm
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
