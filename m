Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146E6C3271E
	for <ltp@archiver.kernel.org>; Fri,  5 Jul 2024 19:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720208900; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=JYg1QQJ7gAOZdA5hfFUGkXIO8F6i2lrMdCEZG/DOtIA=;
 b=SkX5Crq6xTQDY8AcuLjVlAKJIpSXG5Pgl2yKRJ9bRxNqPe5a+2pXfcuw8Q16xCh4dOuPB
 Dq1pIFLdmTK6c2v8SlVWpkoKTd14V080zOtJ8l3WHQkQDa1/7dLLIxgAGbcBq8JlnK5DGBL
 yNXQUJH5xiXlyM+9vapeUS1aZ1WjE5g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD3BC3D3C66
	for <ltp@archiver.kernel.org>; Fri,  5 Jul 2024 21:48:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACC003D1199
 for <ltp@lists.linux.it>; Fri,  5 Jul 2024 21:47:57 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=gulam.mohamed@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 55BBE1A00691
 for <ltp@lists.linux.it>; Fri,  5 Jul 2024 21:47:53 +0200 (CEST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMe5k013563
 for <ltp@lists.linux.it>; Fri, 5 Jul 2024 19:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:subject:date:message-id:content-type:mime-version; s=
 corp-2023-11-20; bh=OocWc7j/cLe4m3QKM21VJxnhSbX3Uhn03MmzqjTPvSk=; b=
 UwdO+g6of8JTDLyFgtH/BXB5WzkMUripv/P+7xybGIZHf09e8OFEFobvT84cQcla
 Eyo3VH6xozb/IoWyXIjJeU8t+Ti1ejO1CXHfxYybIWbobvNn/Q6dHFPili+K9O+a
 46Iz9dEMrnsc1K8q5BCSKhYStEnuMDVSj/kuTLQJQwwnxrAzf7xJyp6Aj/UPWh8s
 8gonIR2HnQnldNU20ddYQ0GHYN1hy9LL8VjAYbbmucngdH73TiXHjMhFdjsunHn+
 YeQHZA/rVKP4RiK1zBCeD/6LoVdF8TFYsgo7GZopb0bwgxgw94EPcZdahrK0Xaxy
 V0qgVVM2pyGd0vl6hWXm1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296b4gwh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Fri, 05 Jul 2024 19:47:50 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 465JHBao023459
 for <ltp@lists.linux.it>; Fri, 5 Jul 2024 19:47:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 404n12n7ns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Fri, 05 Jul 2024 19:47:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1wIeaOtq74NVeIY241d5Bp/+AUcRqPM9p6PFcNavYlKuquvvA175LywbwscpzXQEoVuLxtzaynQkPY7QzCWcc6B9N++LUXuBO8qQKiFFp9ywSZJltMGJ1ZPnIwaaYBcHQ7enY2hqfaq39oFRqEwPJRKES/Ra7qZxPBT3/b1HLqE7Kf9DTUvFs7meOWl/1gc/Urz1Yu+VZxPVwQRNZRLFMXQ6j3egvN8kUPgjOX0fHlWVIphyCOmvPAeE4yVYTv7DtWJT27kEk5vfobkyXNhmuuHh22Lwy2cBdjTp2xstl/ZBRIVEBYL9XVuBnvIno5vf5D+uSNM+hs4N0Ib55n02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OocWc7j/cLe4m3QKM21VJxnhSbX3Uhn03MmzqjTPvSk=;
 b=SYSuQVxJXil7B7P9pZimymUxlHjMtM+fpp+CjEbGHACMXxZ4YiSYqxHRTS5q+X9OTX2Ry1gwMefBabSpYxWoy0c1ayU7y9sAViiKcyrp6yHUUhMK9B5zUGug9OXUhI5IMq/OKA+ogQpZANZ4PfCxohRkZpluR/NmsI8o0cHVQ7oSv1oBliMFHP4cTYxygpkTQdXajFZFsHDVNXQU+QSWAbmXgpOQ/bWTm6Wv9mWabEe5q6/o59DHmiPkrtmdLZ+RzXmdDnWw6zUnOL0mVwPG2wmTmPVBaQYpxjyMax2RyKHw02CsZu8podFKjWheoxkYFvW7FPTjKa+gZQ4QHeUxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OocWc7j/cLe4m3QKM21VJxnhSbX3Uhn03MmzqjTPvSk=;
 b=goXsmnHxU/3CCZ0oaMT9/PF6xJF3HfBIKhJyC7IXH+S+8fYI72n7KSvrELKUliKQ304OeW7+xiE8khkLf8ta92IYe7fSRqCL5COzx0IwZ+bUZF91gWgUpqbnBneDKx+l+VXNx3fHkAOS9zwIT6mHr0iWuDpN0y6foZqhvmR3AZw=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by DS7PR10MB5007.namprd10.prod.outlook.com (2603:10b6:5:3ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 19:47:47 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 19:47:46 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: Request for Modification of test cases
Thread-Index: AdrPE+E5zP1T61RgRZ2SWJGBqXDPgQ==
Date: Fri, 5 Jul 2024 19:47:46 +0000
Message-ID: <IA1PR10MB724059C5A7A69CE2A4AF257698DF2@IA1PR10MB7240.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|DS7PR10MB5007:EE_
x-ms-office365-filtering-correlation-id: 2be12473-438e-4210-3601-08dc9d2b582e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Jg0d5TNXrtVeshW3APehdPinX6VjJ1cYPkaFkv0rWiGiroosmnnokFvD4N8Y?=
 =?us-ascii?Q?GBLXpgSH3oS1gOv7BARRkB3YbnuLLnKGLGpcMISkPx8bMT8eTZyQorCgKTfM?=
 =?us-ascii?Q?dkb/rzr3B1VT43bs4UncWNgGLWEIhAMQjverKsMvBYjKceha4/bt0MywdK67?=
 =?us-ascii?Q?x5IVbT4aegi+Au46lLxBZFO5FXnnFuYQQAhvLy/7jRpMdV1b3g0xh8fH9SPM?=
 =?us-ascii?Q?0qI+FmFFPXxivZc8io5LU33KI9KdtFeTsnJoIw9C/TDIHOm4HsrkmBgM5NAq?=
 =?us-ascii?Q?a1KYW3zv9CnAwclMvOvK4eyJeacR8MgVplKmnv9g/BpqB6eqyx5TM+d5Ygz5?=
 =?us-ascii?Q?F0X7KeZAK3PVcVnw3kWcpQyK2JBlxMqBNkYC+dR6PxRb+HhpSxVspwenq6M1?=
 =?us-ascii?Q?aXxVOg3cSxvb50xIDVCpI+w5j6XRtkiBiPCMn5lOW9kLnqkk1dNtoe5ByGnb?=
 =?us-ascii?Q?MB/v1v8qduJ1HfB2aPB3R17n1iCMkCUc57x/r6dMY+uqnkU38fg6z4lH2HLT?=
 =?us-ascii?Q?viwyIFw6JQjlF3+Ru2iNcNxZuRq4EF1NT4HH3e9+4c32X1Czd2XvbC7BUhvE?=
 =?us-ascii?Q?mYfwtjBhxjsNeQqozmvdJIcAMpFasVqsOq1HX1FUKuLJtTKGEygTPsZBlMaQ?=
 =?us-ascii?Q?0q2ir0XrGYuc10S9iIPnN0+bh7NaQrzM8Y9GrI9YbPDohQJ+ZQeUqoEt27Rc?=
 =?us-ascii?Q?0u39sfzoVIpGMX4V72G72WdNZ6/OZ5eBCEVOFmd9p1RJO6CzjsoBwiqxkCwj?=
 =?us-ascii?Q?gwlG/DCGL1LGRAacFWMq2QVEOKz2BcJOenSjGKsIr8Q/hhklcxHdlNcdnmHK?=
 =?us-ascii?Q?cJyUanKSgWkEvucNqZGMTsGFmqf+kL1SAlw/YQMpKD6MQDJZrmAJzL4U7Lrq?=
 =?us-ascii?Q?Q8tFCXj9xF4UvzDCrxcm7XruvMAiGzBGuReULKuxHUzAPZh2ZdIzFcZEKFlt?=
 =?us-ascii?Q?iFcok5JYf9QKhDiya8z77WfCKPALhrQ6GrLcgud0h+ZQk+rXfs+t+s5NAng8?=
 =?us-ascii?Q?bm05zsEC/0anmtQVmx9h8TOES+nKbPzwd9kiejwLSYP7WQv3hy/ZEq5rnX14?=
 =?us-ascii?Q?3vBVHPx/QIg2qFDren1mmxDPg03uraYOg4V8kwdokUGAZ1/+KLLVX6kTCD0Y?=
 =?us-ascii?Q?Fp0Um3JaBGKI4fPVEFvNACYSQ+jg4Ix9ytFKaNTguM72CcTGr9oC3le0pn0R?=
 =?us-ascii?Q?MrowCuBOVnhkP/1knGgq8zV0TfEyOBS4DqQd8eiQ00aF+6/X4rFoU/IkJp+R?=
 =?us-ascii?Q?QUH0hz36boL3Cnp2CmfBxoW36IcNdIJ5sDKKgJ5DJPi2v9hWemRxG1dTKGSP?=
 =?us-ascii?Q?A6DLh56gxEEh16MU/zjQuuHJyjqusZFD8k0XtXI1wX6QxdXSk7istBOTLs+w?=
 =?us-ascii?Q?U+WZHowG8ygWL6Q4PEZ1+NWkgd5+6q2LND74vdVgmgneGAc4Aw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7240.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7RTYwKNgG9E8e9uvG2PQft3dHGTIWXyKacKzfvfIkJJiru1ynueuUzjZ+3th?=
 =?us-ascii?Q?FWiwcHZHvV0P6PL26cM2J0+DYPlQPd2pJerU5ovn9vgQZilK8D5UwaFMx4EO?=
 =?us-ascii?Q?a5ddCUYgwPTyG7gOaqB4iiryV94uIvtLxBNSqT5AwggSxgznrdiZ31X8POZI?=
 =?us-ascii?Q?vWz0/N+Diygi7VDP8iRABS+ejudi8Dyx+s11vb/5SZ83cRwnsvM8Er94AvBU?=
 =?us-ascii?Q?gTMvUth54K5AsSpfA7ymsM5CMXWcSijUXnNHqS9doAmcEPwnHiVhN4+cgpzl?=
 =?us-ascii?Q?wxv3kredxsww8OLtHFzYog1GvfgGQwgNEAaYl8iYCMaMPkIp61psa6CV2Yy3?=
 =?us-ascii?Q?FyF1FWVNvZKTXPbaPKUMUZ5RaEhJ81/E1J+s3zUbuBi3mmYykz1RFg3z1Yf+?=
 =?us-ascii?Q?YJGcO9UH7ZhPsXVA64deWxWmvpxBdTADtd8H0F8reZbubfv1IoQv1sY5e1NW?=
 =?us-ascii?Q?LL978/RB4Ot+d0KQz7uuA7XEH24RhDn6QFGeOQrDZuOQwdyITg74ER6qInW0?=
 =?us-ascii?Q?JMyQ1kjY4ZgqFA7foVxlBk6FgrjP07q2vL/ji/TkbiUkhUFqVyEf16dlcVyE?=
 =?us-ascii?Q?//hQTjK/VEuIxgfGZSTnToRiCiAg18tgbvTFYwRMZrnT71vkchfjTN/Y3Cb+?=
 =?us-ascii?Q?yGEcO3iYJFMdv7LVHxZuJVrbSQhG4yFSMXOrSGV0qT/9YVbmxsOkLV2P/NtR?=
 =?us-ascii?Q?zRp92dgc9ymhUeKXBZ6Tx/plPxEgjazHTEUlqTUv/0v+ns8T1vUKs0zbh43t?=
 =?us-ascii?Q?HmxLGI0+IK/BbDk8p/A9ODT4MEkPr6wcQqDY3odVbR9vVr/OcyhpkpnjCCDW?=
 =?us-ascii?Q?eVMvTk15ZyJqq1NG+bUYum3egKVuDtssW2z2BRtSG3O3jguCkh5kAIigeKQK?=
 =?us-ascii?Q?RMSYc8pwlmJjCSYhuwYdxBIbsVed8N23JHLJlkYTvuDiSvgJdThJFzhLnhPm?=
 =?us-ascii?Q?gY0JhJ81cTNq7dN7ha7ocXHUDySCUDlVapfLkPmGMsPM2xynchxkHQWDYZ8N?=
 =?us-ascii?Q?7tGM0cCuIJbdQIjrCRbKa5UAA6U1xdmnCzqwIIAVL8+uA04ax9Lx1+fzTY5w?=
 =?us-ascii?Q?6Jii0CFUGPGCgy6kcW99Sth76X5/EZtASHM8A5cvwdHACtCRyGU8MUA2TXHJ?=
 =?us-ascii?Q?TGsYer0wyGgCCDbSTwwjW+mD3AROddoD2rO1GSOqf7iGpVaTj1yNtN/B8mN1?=
 =?us-ascii?Q?rBQ0ZuS7nXEsLf6UWhBzUOHlqCAsqsQMA2XARnlbkVVzuul+qnc9DtvSyanO?=
 =?us-ascii?Q?Wo+/iIWRUEllz1vTdBMDhoNxCBh2x6J8UQrMbJHHD6li+uNBzT9BTlPT0yq8?=
 =?us-ascii?Q?x8CoXQWQAJRZgBAj0FJDm0eCr9M90WP1tfIsIgFnu7gQs3rFjwI7uF+J0s9D?=
 =?us-ascii?Q?tWX0O6M1Iw89Nw4d9pPNd8zm4Q7ZqPSgpGB8UgZxu8TA+rQc6petu/xsLCPJ?=
 =?us-ascii?Q?WoX/YqB/ODiDc0NQZ4TLjAolD0A5UsCvQHgkjiUlPBLYfeW1nBMwoEWd0fKn?=
 =?us-ascii?Q?nr2WQemxHPc/IlQZwytRdv9sKTB+UW9Mgj4SXj/RdxFTdFuvyR2ZVHo+VLL5?=
 =?us-ascii?Q?oMUwDUrrX19L8LQw9jlZ5UephthfYDPOyGa7Ty0l?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yw4126NGS/R+dL3xq70R9lJ1hgnjdrevJTyYIi9Z/foBIlqAGXw1D2INRV7Y6ir06L4/Aggv+JjTOD2kPB4v96z+R6GraEv2UWj6A0ZjQDXZ3VN71//votfyHBTJWYCVOv+9BaKMitKi4bu4pGYfD1SoL3FkP9sHgezeNPvYVmGVH3cEzHnARlrJ7EMTaJojZI3+CXtkfI5X5mDcWmuXtQDsUyorI62yWMSxjkxndwQCvS72WILzLd4s0TN4oBCmvtqtnhxHXpZLAiv0atHpnO/5Y8l4iWYKTVxWYlNlWRRBofkq3+7MkVx/wigQfJcnHPLFW1iJBYwd8nzeHm6PUmi6x2yyQ6Jkb5RyinAQNyIl1iYMbftBMsH74xm7VRvbfoxu/K65zRKBuZ2KjZy9lKklT8HpEc/5PWoE8aMdJ14kDHLUOXrRSoVYMgGHynG26ILRo29p2FbkGERVY2jop4Gptbh6j3CNkdqPxmTeHlwxM+hO+dGvA+pMme6HTEBTDoMV6rjNfPDh2zNJKUkn9//KeiOlI4zFpahTDm9bRKEk/deZ/ipb1cJX5lgjt7SocFcpfv1m9UzPJ5b3nK0lrm0MJ38x/TvJR574nHnZ8x0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be12473-438e-4210-3601-08dc9d2b582e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 19:47:46.7777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPOVdHMnwa9/FpzachzB5IfiebdEjdqG1gOeTqnUTtT8vnd1Hkxwi1lzKbLvvV9zbYB+fKrJ92umxBeHAv6XGBYwQqpu547/Ci5hW4X+osE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5007
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_14,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050144
X-Proofpoint-GUID: 3SVOeCbvWRFTVWuLZH7ffH5kvpTcHBrm
X-Proofpoint-ORIG-GUID: 3SVOeCbvWRFTVWuLZH7ffH5kvpTcHBrm
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] Request for Modification of test cases
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
From: Gulam Mohamed via ltp <ltp@lists.linux.it>
Reply-To: Gulam Mohamed <gulam.mohamed@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Team,

    This is regarding the change in kernel behavior about the way the loop device is detached.

              Current behavior
              -----------------------
              When the LOOP_CLR_FD ioctl command is sent to detach the loop device, the earlier behavior was that the loop     device used to be detached at that instance itself if there was a single opener only. If
               there were multiple openers of the loop device, the behavior was to defer the detach operation at the last close of the device.

              New behavior
              ------------------
              As per the new behavior, irrespective of whether there are any openers of the loop device or not, the detach operation is deferred to the last close of the device. This was done to address an issue, due
              to race coditions, recently we had in kernel.

              With the new kernel behavior in place, some of the LTP test cases in "testcases/kernel/syscalls/ioctl/" are failing as the device is closed at the end of the test and the test cases are expecting for the
               results which can occur after the device is detached. Some of the test cases which are failing are:

              1. ioctl04, ioctl05, ioctl06, ioctl07, ioctl09
              2. ioctl_loop01, ioctl_loop02, ioctl_loop03, ioctl_loop04, ioctl_loop05, ioctl_loop06, ioctl_loop07

              The main root cause of the most of the test failures, is the function "tst_detach_device_by_fd()" where the function is expecting error ENXIO which is returned only after the device is detached. But
              detach, as per new behavior, happens only after the last close (i.e after this function is returned), the test will fail with following error:

              "ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long"

              Similarly, some other test cases are expecting results which are returned after the detach operation, but as the detach did not happen, unexpected values are returned resulting in the test failure.

              So, can LTP maintainers team change the impacted test cases to accommodate the new behavior of kernel for the detach operation of the loop device?

Regards,
Gulam Mohamed.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
