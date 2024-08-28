Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A9FC636EE
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 20:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724875282; h=to : date :
 message-id : content-id : mime-version : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6wcN48n5CyA+GDsrLTCfNqIGgQmIOFI74WbJw8Tu3X0=;
 b=M8lVMSArxWUJU0DS+SxlRyoWOWSfZ8xSuGZxW2g8Zoht5MCmIaYUQcZPAj0FbxvSfiRqV
 Yg6n0oO/gT4e7B8DP09YN56gXpSZrsNnHIEpnDJd+FEac1K4NO+W+wqOB90SmSOLvQR32rJ
 ChCBAv4CLEWULF/TdPsaCEdKp7eNz0s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DADFA3D27B8
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 22:01:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8342D3D06B7
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 22:01:01 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1009110009AC
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 22:00:59 +0200 (CEST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJXVtj008248
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 20:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:content-type:content-id
 :content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=H
 Y3roalJDEQ5r1lnipm9hlap13DbYoK59JlHYBIzSf4=; b=iiH0XBMZwYFxcRO6v
 rk/Qjv00/0VYiSfL/Nt+aYNRN+XS8gWZ9RCrW8rwDcioqssP2CrkMfILohm1QzNo
 dqWWXNb4GqRugiKS7W05WWQc6WcTP+y8fr6808J1W7qM9ILmBCkMdKOaU6mlodfT
 cizbRzORzEgPkCXNDUFG/Q4wZJQV4brVDbxZchjwRCejQucma3yn8wowE7ct4CiA
 NERxmejnnkPKqmtyMVAzOp1z1dOoOssv2p009IzbnupxpqwPH/u6gc+Mm+/xeXiA
 LYCqnPzNSeU4IvgftPZv90k8Jafj7mUFn+W9ph6eeMfIkKyr1ANDX5NpaIp3G/vY
 7cIOw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pwv2727-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 20:00:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47SJ5FRG036491
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 20:00:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4189jm9yrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 20:00:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrINzbJDiUsmDbQkAo41sxgzN+Rfmt8JEKtKqFOQiBu2iHlWSowvw3Ga7Ck4G8+Kwrj7cMMiVpcyEI0gj2ga+Si9+ciVEYm5y35Ynh5RqC+tv6GHMgs9pCcAtZW+GRhX9dj8xMkFcYLFU0P9C8XS7RMezLC7b6l5K0i7WhcxKuJAc5LYJ5MaBmMoZRQEJSMcNYyF17hgDqntFnX2qVRI9APRk9OfAqayqSglqlBtIHpKaheCVo5F4G7k9BBlmZRZwWHVNuxb990FkwqAubQnHjelndzOcfWASeOoN4h40Z/8IMuP/T/JGooQTXltYmC//8zwot+B2zUjjQ3m/8rzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HY3roalJDEQ5r1lnipm9hlap13DbYoK59JlHYBIzSf4=;
 b=Z7waRG8zbTfx8H+nSHcWpqS4dswJ/XciaBMCtzlA1NT1hyrQc9JO70Q5sv/JhwAMwORQ42bKklrT0OklXDbi05EyqVha33NTnSjb28hi4VE0tJEpQJeUuwcz4rZ6RfoALYsNaWQhoO0azvfNX9LI1V9ZGy6ZLJsY8XbwMjFfNVhxBCUaPG6ppa66z0m8YGzWjwCtcx41Pk5W9po0D9HYCjTy96ozwWLxWPGBY102sfuqgiUtnb9I/BxmXQoByNWt07XDG5JTq+nsKxkGmYpuK/Qdumm4MSrn8mOeWjd7RRrddS4prhrHqUuCKaDr3k9X3vwpqJuUXQcoJLoVQVRtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HY3roalJDEQ5r1lnipm9hlap13DbYoK59JlHYBIzSf4=;
 b=WJwb9GPUTzUrN9q+DmkuyHNNNO3a/AJawrpHS40bgDc+r4Cecn9qf7kmRxVOO254E9CnsoVmuhtJZCwxNLqzaSS2oMb3LX/fPsLocOPe1xhBSF/+6PkWxmoW7pMxk8cO7hSF6ufluxSRCHMqYq/NTuOmq1opyT0d2a1bi7jXoyE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Wed, 28 Aug
 2024 20:00:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Wed, 28 Aug 2024
 20:00:55 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: ltp build broken on Fedora 40?
Thread-Index: AQHa+YT9EKh4tnj5t0CamT2/mHNZzg==
Date: Wed, 28 Aug 2024 20:00:55 +0000
Message-ID: <5295D578-7B15-4613-A1FA-41A425E992FA@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6634:EE_
x-ms-office365-filtering-correlation-id: 703b1a8f-0fea-4316-ba67-08dcc79c2072
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?P0p7AXTITZThE7XNlU1bs5yYFzrBSrIpOH2DWl3YgoMUT0gyEM6k1lLFxrwn?=
 =?us-ascii?Q?hqUQ4fHUuQqtjWMYeRpKbMAo6uQ6QA8HVJmwcE0ehgFZh69k4zyF+q0VFazE?=
 =?us-ascii?Q?N4i3CW79k4fX3927z4j9Ww5btvcwXk5mya88nCAL6P8ckjnQHLcriuHEQXDs?=
 =?us-ascii?Q?4fPSJRALMFow3GIFVekiB1f7phCEbKqJ4LLmmRvJRUOtBlDi1Pt8NVs5bwlZ?=
 =?us-ascii?Q?dALnyR6NAIQw8wSkaJsK3pUnoNDHA4VvryB+y5H+ACRzyE2vLzihFyaq/cMu?=
 =?us-ascii?Q?beg5jIHDVRIOgND2TX1Lg95J6Vx7Es+E0TXMv5lpehafJ4rzvIy4+Wqztn0i?=
 =?us-ascii?Q?Jp7tBHJeGa8kf4F7ukhyH0zyxNPGErj3S6HtyOc0SPZafV9qhuiplL4u/Ioz?=
 =?us-ascii?Q?YwGAYDDtnnN3wJvnFVnV39acI2c7axxm5LdpH4868O2R7N+X908v2EYnGg4F?=
 =?us-ascii?Q?CqWPB3nxaKf9BDiOXnDmgyyG60mFlrSl3rSPAxvFaf50khAsLc2laehj+umB?=
 =?us-ascii?Q?/dDgKujgupOVOIT8PgJmzqaWqpnsYyOFWKs2lg+MXXx+ZllQG2XXih5hYsAi?=
 =?us-ascii?Q?/JdYBo2CxvDBvMYQhYUJtVmY6O6e/29Ppz0hRr0hwGjwXf2ckzDCsxALKyk8?=
 =?us-ascii?Q?dFU9nNIgdkQlkyMn2oioSeAp82gJNt8frcxDMo7oPC7vURsqxWx3j/RQnQL4?=
 =?us-ascii?Q?vPHPXDK/vn5cp2MkGiSHK7QhQlJ1HC+gXnd4E4w1Gt1R1HGhlrTJDWy3mCsF?=
 =?us-ascii?Q?BwojgRKJabQ0k5K+69m9lrBie4OuH7uPGB2n10vxQ8964rLju972ladlOKAb?=
 =?us-ascii?Q?yADb6npsTXx0bRwQEhgsRlIYyTvfz0S2wfxyapXlv3OhURbcvvU1001ae9tf?=
 =?us-ascii?Q?ZIZMS4sRWpkMHzQjXnFW+yjr2gIy1ikvsZA+Y4ry+RHT6624+a7e6g8NDpXV?=
 =?us-ascii?Q?xiHIkP1g7+A6HTAEflLKyM0usidB+OH8cBDJLA2v4GZwBBIHamdu5qTyJ3lT?=
 =?us-ascii?Q?g2TkG/wGMbfUXrrzMlAbWnTgxyGKqWCIcZYnjuoEnEPfVw4zxM4JWgqFukGx?=
 =?us-ascii?Q?oMkcNB6k8hDD4c3qAE37CoF74NneV6h1uKaZ6dYLPghqysJXjSg5R+YiFDoG?=
 =?us-ascii?Q?mQzgELh/ZR1t/hYVMNT2UQTOc2qNCxU26Ydx1rZj3Be03gNapCw47ELuHg3S?=
 =?us-ascii?Q?fXPkOak4kdoUUfI5DpCUYOgtXHYNZzGIIjHloGJc1PizoNyyhkQjaxO+3Wmt?=
 =?us-ascii?Q?FtNjTVEFuX8rUebbbMeLU4MTcXpU5xzR19dboFJpGzkX9iWGvEeWKprPeriN?=
 =?us-ascii?Q?OUo8lq+xrV8RCHPfRlJAdYEbIKN5CwhgmRr8IS+6BiCQgYBuVm1iMDjTPojs?=
 =?us-ascii?Q?ZygNdtWzFBtjtwIcgpS/DcPqi2oM0YqsArGNLOWjsxitEsViWA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yAGmVmsAcEsx3gKzm7l+Wpiw2D5MwLWpAkR3NeuvhvMmf61F8w0awWFVxEBp?=
 =?us-ascii?Q?H0D88VYt14osNR7yazdYdA36RQ5tme7ai3oAIy4Mqc/UYkdXkaHGKja+UfN7?=
 =?us-ascii?Q?dIMYg/cnGtk60Uy/f3MjlSioLRGoaUluKx2IpNrfH2/CfKGVoWIh/prdoJXA?=
 =?us-ascii?Q?1ZnDbF+UuKfbLHf4OxsabZ9WQq5dFciVlCVm5asAMJEBvtfb6Sj4hY9Yp/Mv?=
 =?us-ascii?Q?E5LRBUawtyXUO32SZ0M93yTUa6lSzawqtuS6+GDCrTVUKaeKOvucLdzcAIhf?=
 =?us-ascii?Q?FW0qVZVQGt0vPFf60p9sKICyaaBzggyNoGmJU7IsJXc3bOZ90jV5W7RGYy3+?=
 =?us-ascii?Q?AMzWRfFfkrK+mAKMYRYfOzLbWbIAOXCBTnCFSJH3GH8OLLkG/IKP0mNxSXri?=
 =?us-ascii?Q?srSIR7HRKylRqCyZDm9P7Fj3dTnyPhp+z+pm3TFpq5AJ40JpWra49DenGc7y?=
 =?us-ascii?Q?sCcjl5oKtY2UX7IYXBeYz2W57tYFFON/6eBu35HsQQBzxSppMO1Ev8oWOMtk?=
 =?us-ascii?Q?vUGsOeV+fK1u/6zBlc1nGxlINUbHZSU9HlkmIosKa9t3DIPWt7XpjeKLnN85?=
 =?us-ascii?Q?Voj5o9rXrUt9LdviZg5Sx1/unse/hk3Z8YVH5LB/eUZ7E7lqhDrb9HSsfAdm?=
 =?us-ascii?Q?FN/A+hRsnT3TVFTVix3+18wWXMTkHGU/Ett+AHlANOxYSXtNi8BQ9YEw/HrE?=
 =?us-ascii?Q?UjIq8NuokqblfqXQ5a39vsid2hCnYclDuG8UDIncZ/2GpcRKjd3zisNbbMRV?=
 =?us-ascii?Q?BJ3KwX8ZTMpw2uDEO0akdz8ka/jVh0DittYe231Xw9KLpkOGXW23SeUvLHzm?=
 =?us-ascii?Q?LDf5FT55ly4Pa/cuS9iQl7tuTaOEp9imwJ5DElH1rOormfAjA22zWvBsi7pB?=
 =?us-ascii?Q?HQIFiJ1gr9wf4nfEqbfSchzFMTTG4boRi6r7qqsXOPCQpBjpGPMXZlVgp7i4?=
 =?us-ascii?Q?DGjARmh63cE3Ydr8ehwCkGyNSrtxLE6+eCpZB0Q3nrKYEhKnmGeaCOQt4Mas?=
 =?us-ascii?Q?sPm2Dwbq8Mb5kx7r8KIHQfXpsmQdmMgDhkFYCfBMBwG0Mv8CAa2rXyLASarH?=
 =?us-ascii?Q?nfjnZAk2lkhkDzxkCZUIOeG0+TvQNg7k1Mt7vOWaWirqLahY+kYBxSM/3RtR?=
 =?us-ascii?Q?Guc2YOAAEsh9BMrpCWMJiriicJxLv8f4sNqNla5kisDZJoXgkKwjPa04R8ZS?=
 =?us-ascii?Q?oKcd9KZljo/PRYX0UytlAKL4skhKLHTxqgrfTMqP5eQu+ecSm4+Z8oFPDUC+?=
 =?us-ascii?Q?CGRQMygwoJQi2IFkgLTqFJbvjn38Pz4ERHiQsgp/T2CsdDHsFuQN0lUTA48g?=
 =?us-ascii?Q?YJdQ6Sgib/JII/iVFZmLxDeZyH7OVRHY/6QBV62SxZKPSovxuCc1LKkxfk/O?=
 =?us-ascii?Q?KQlEcO7jK9+9wDwXEtlOj5eVd0Ar0d7EkfLa32cNK1glbRvGWxVU01Ru3P4o?=
 =?us-ascii?Q?fZCJGWLMvkzlAgPF7rq6xIwrcan2LHLzuYSc9eP1r9Q2AwICCrqzPDatY2ym?=
 =?us-ascii?Q?4TankhErCANmbJ883tx7k7bVWKRMO1Wx7M4szKGb0XvGPxJdHF9bEu7oryDa?=
 =?us-ascii?Q?C0Ididh4X1vtrEYw+43b8z7M2OKzVRCv8bRzOIwj+RUssI1QAGK7HsjjHnAx?=
 =?us-ascii?Q?wQ=3D=3D?=
Content-ID: <EF4CD514DD6085498FF529372C82C7D3@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cpu14UQ21lbfsX5NlTY/u2NK8ttnkTV08al3nRvDIMEN84cTmt5picBRG9+WbYThCWautR6Ui5pPoKqWPru/ala8WW/JGX36fUDCbkGMgyVKphNypfD/rDWGeuA15/6z+qqIIKO/zM5opPJlJwcMv7V9j77KUoci8FGd8qBzj7G5vYksQ4iDQDl6eFCgpFRS3HotRhCEuPj9r/L1QMVRVZ6hdSTF6KNQoktNmr4arIN59Tf8zx5YuQgMlveHy7PGYGYOcrRSSs0xok3OmBPfjhhOT9E9D4CLnrZlpp+/RzO12Cr693836bOLl8lkETkFW8ChE90VnR2IXb5PIqSQ2sXFjK7cjWU0lLPagEApxAJRnJdzyvwPaRCtlVYNUccbvnwszoyXcZR3CP8+LppFnZVS76qS21FX7/JHlHdAQfvKbLpmpwoPhcwlQuxXFIpNZzcnZv/oZm1XD3BC0gjBjEd2S8RTui9IZP65ev2PJvUIdd0x9DTPKHF5vDHgaqumuOezUxkZA+6z41cefHcQ9gUlOku23pj4GXym/p2qXwqAtLqDoz+HsnsVcISi6FNlTsXXKavznNSuPQUFQLT5zIOPAX0MNMbFQKC26lNhLGo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703b1a8f-0fea-4316-ba67-08dcc79c2072
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 20:00:55.2932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0DEv51lclNbNCuvMI/IrG0790nInkMz2Prfd+9R/vFwq1zPY/oo0IJhHC045wG4zh1f3uATPW4hUVXDK9xIL9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=497 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280145
X-Proofpoint-GUID: PPUCWK3b0ITUWNCL3_MeBRZ8iBPUgbq7
X-Proofpoint-ORIG-GUID: PPUCWK3b0ITUWNCL3_MeBRZ8iBPUgbq7
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] ltp build broken on Fedora 40?
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

Hi-

I'm finding that ltp 20240524 does not build on Fedora 40 due
to a missing header:

ltp/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:46:10: fatal error: linux/genhd.h: No such file or directory
   46 | #include <linux/genhd.h>
      |          ^~~~~~~~~~~~~~~
compilation terminated.

However the ltp build works on Fedora 39. I'm not sure why
because I cannot find a linux/genhd.h on that system.

--
Chuck Lever



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
