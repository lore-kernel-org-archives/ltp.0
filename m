Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708CDC021A4
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 10:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739527579; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=r2yM5d57jZ/UP6xbllrU3LPqfmya7l4f6BxJ3hJCBEU=;
 b=WNwFFRE5uYyAUihDzmSKfP9lRR48RKzvrGDo/1VGOcQgm2g7uWk43pkpauRiUOjbXNnDy
 lTAVVqTAQv72iMDPH1AjhKKfC1sKM+cXM9edQ0qwh4E8+s3YffhWmLfs0WuCJ8ZIiUmYyes
 LXH4LANxmnAB/nr1O3iNYk4AShanZH4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EC623C9AEA
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 11:06:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 644043C9A6B
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 14:29:44 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=rhythm.m.mahajan@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 63D7210231DB
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 14:29:42 +0100 (CET)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fcUp015106;
 Thu, 13 Feb 2025 13:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:message-id:mime-version:subject:to; s=
 corp-2023-11-20; bh=StIe2U1jO6Oiu6QMKds6JcCdENUgcBXuUCFWq9Zdv2M=; b=
 RqJT/YMCbVf7z964kxhZaD08pCPMiVu49s42R5BGgrYmH4ILGiFrvSirAX9mwUNR
 862axxjmZ5p7gCFgh9jT5IjGpkX0QIDqvWRASI6idjQIbVllDoFK5a+lBA+XV8Pl
 QIP2Q/iixtAiIozPJqRT+QuvlrFRmZP2fEDKLWIefRYoRz4Nq8FunNzRCqqZ4oIV
 IY8C69BPOOC2SAlLhNr0r2m073KKYmwoCMsf/KHF+DQ4R5CGD6BvJk6VajuX/5GE
 VmHi2m9Zd99ixU5mDdiyBhUpl1Jtn9EP/9D3DX36GDpMc3teWxwsUBL36ZzLzvKV
 nLIunIyYBqGmMNDTlZ5GYQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2hm2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2025 13:29:39 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51DC0cN0012623; Thu, 13 Feb 2025 13:29:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqbpmdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2025 13:29:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6Qyaz5glsllcR0nvK7nar8XHzmL0e5+z8Zw6E++l2y6a06PwMWzWLVzMMpBnbYc9GearqyMr1MdVH/ngo7pZC2v7cINee+AnH85rnJSH6ieOLtaITEuOyvkbo84TckABXhwPVwDZMVQQSjmH9XULJemxcpJK+8ZjoUkZs6/3DicjN23DlpBNnvO1P5rUHbeD8l3vonwqttPK4NJK/cL1NTAoNiXUMSzL/vLPR1GW8MFnCXpchkA2sj8rXYnlRy1znl+LIJEY+Ga6wrr/Kh642YJx51Nl1hjuuWH9ZZJEmzSx94SV7uAjRODjp+Mc6u0XrXYh4zckeFKPCz+pkPvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StIe2U1jO6Oiu6QMKds6JcCdENUgcBXuUCFWq9Zdv2M=;
 b=F8kkz247BpS1ZaDol1nd/+Kz0a/8bkpFCM1nvBRtLEz9Foxj5XJ5TkNkRH/4xWoespoSxfKyiiNx85NUaTqOdw1Oxz7dfLxGTIfHXg8+owu/401Mjyee00U7NC6pfkMIO5OVsSLjsL2bThGe8fXlFHAlgvRIQ3axjC1GDislXv/ecWBkMmOqQi8aCxUjkFmRvK2LEqsVDoXIqe8oHEP9WYZk/oZ5+EtIwulNlvJYlz/i8fOpx0IkDBeq6PgaCm2+GHKcXfN+FM8RABstxLZcEcmUSRE6K0D0JrN1AFAWEFaFcMRHvLfiEVH5JEOGb1NdXi/FiPfDbOhw0TNnS02Ldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StIe2U1jO6Oiu6QMKds6JcCdENUgcBXuUCFWq9Zdv2M=;
 b=lke9hf/wViGr8pmoxgxkLSKgsKqyQLoEGiAf5ZeOkkZVDgleGst2VsGbzGBaZeyjhc1vbaf4YN/NM8hV+NhR6WmZ3dlWlMGm05E0BRMrh+l+GmO8AVuC+hPCJWFXn8lTuQcQ7PEgCY2yhhQlPnW0IVl3wcXdjiLf1Y1Ih265hfc=
Received: from BLAPR10MB5380.namprd10.prod.outlook.com (2603:10b6:208:333::14)
 by PH0PR10MB5872.namprd10.prod.outlook.com (2603:10b6:510:146::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 13:29:35 +0000
Received: from BLAPR10MB5380.namprd10.prod.outlook.com
 ([fe80::ef73:6117:7d5b:3227]) by BLAPR10MB5380.namprd10.prod.outlook.com
 ([fe80::ef73:6117:7d5b:3227%5]) with mapi id 15.20.8445.015; Thu, 13 Feb 2025
 13:29:35 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: fanotify01 test fails on nfsv3& nfsv4
Thread-Index: AQHbfhjii/4a5jDfbEujkblJZpzNZQ==
Date: Thu, 13 Feb 2025 13:29:35 +0000
Message-ID: <BLAPR10MB5380CCF4F8E99589DF0312EBBCFF2@BLAPR10MB5380.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR10MB5380:EE_|PH0PR10MB5872:EE_
x-ms-office365-filtering-correlation-id: ab274012-b918-48ff-1684-08dd4c327519
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?UVdh1RoKnxYsHjXAmDSxuJMoLmIwDOlTfytGr1KiCL5OoIzhS08BncJO7zns?=
 =?us-ascii?Q?GaBfd8xIynu8heg1sJihRInw4QwNKjtS4Ly/hC12aDw7AxKcGrj21hEEe6m2?=
 =?us-ascii?Q?1430O8IfSJgYmmS4e73ehHh7iNpNjVMogj3ihICj7YCKzo5v9Fy4nE68Tpgf?=
 =?us-ascii?Q?kW8A2SZBY8FBruE8aCGtl5AQ4T1Tj3AjQYaTYRjBwL19xZnSj5IVRu5Y623b?=
 =?us-ascii?Q?W5fzRZ6OHNemIc4/rhcH0yI4VPOSmAgSPeUguwZsYQQ8cF/E3NGMzBZZm1Hc?=
 =?us-ascii?Q?mWW+GvSqOTbXTZ0rYlZssL0n311nChplri2pozNzDu95ldwbs2r0R9K/N750?=
 =?us-ascii?Q?ayzNchXAgBbDG2Nc0KGGSR82Kv9yizWFeL+c85JPxQtVJLOfplU+6D2Bjrju?=
 =?us-ascii?Q?q4uyglVnrCs5lwKWJ3NaSTVC0/vE6EzzEGzf7XOEVSqtWInHyBAuSeRMFjNK?=
 =?us-ascii?Q?YqDua2iIdGXCaRefENW5Zu30qkkNyjpGM0k59NCexZaDgPp2A/Kjjmp+rN2A?=
 =?us-ascii?Q?71+sQH8CtURPuWgMiYipYYhiBfZSyZQXf64GQQNqFp6RMpu/FAlhk5xDrrYJ?=
 =?us-ascii?Q?Y0uNdzL5Dx2Gn5eEFLLAcyHeARwTqa282zmUSD341j6WPpvN6O34+ex9h02R?=
 =?us-ascii?Q?6TCrMLL17GwV4aaQPoHAawRIJneE/19Ur1J0k3QH+HHFKfUfOd0B5gRGHpee?=
 =?us-ascii?Q?Sd3aL4oLJlIf6r92WIRZOKUjcg1qAGPq1VJE55V+wKhCrFMhPlO35P2Vc4pj?=
 =?us-ascii?Q?mef/VF7c2IaxFUbGEUG43bGFpyn272a6fLrzzWwO8tRRu9F5x01W1pcqvrYC?=
 =?us-ascii?Q?qfnln83uJ776CZ5KE0m1kHh7cA968wUoX5KtB/AR/YzOIPRkrTyhVRNXvMAC?=
 =?us-ascii?Q?x4sT+LaxL5Ii/pyi7xt6qJ23mTCY8SgNiH7jSMSgZjVjWo4KKkoEoGH9xKmR?=
 =?us-ascii?Q?zgt3dJVIS1Xf8SSBR5gWtU9bZGsGZoxe7bcqKNx2ww/GaRsoKOWptW3HpsrZ?=
 =?us-ascii?Q?lOa3gXV4m4Hi3UQdZ7elnUYVOMU/Wvu/e5ESECYPb7/sC4PWguOk+2UynTLJ?=
 =?us-ascii?Q?GvU5ofSeyQjT/RGaFydqw+oS/ZQke88FWDY0EbCPUrNzSUPkEgrW5tKnAOMN?=
 =?us-ascii?Q?mGoNQHLchkCdRvd04RdvVt7UAiUD1JIb3V5omAetzz4jqZzAcURzV9diSazK?=
 =?us-ascii?Q?km9OdrHISC+hCw7lth6Ejdjaal+aJTGWaong8ZU8ZrzP2mWbdUZ5AYwzsD65?=
 =?us-ascii?Q?G1/8tdFFY5nL5iKqIY5wQGIlK9k5HTgVNzncUGs+Kwgtwp0CGKILts5KFA8e?=
 =?us-ascii?Q?qATMD4CvBpP/A4zZMny2EX1xYNb5E2KCjKZTiAKIG+xlkvkOOOTr6dqkapf7?=
 =?us-ascii?Q?G4D3JxNM1tBo+oLmiRqD9PJmjdrqHFIhAaLwZoRQ8z89cM7Lj/FLYuyJK6T+?=
 =?us-ascii?Q?APNOGt/GlgAAW7KU6HpKtsS+JuOJ1Z00?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5380.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(38070700018)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IRFD4+dWwjJUJgNgPXyChpv+9UYinx0AyY8B6580jPbYvTe+x9RmOZDBUhle?=
 =?us-ascii?Q?TsiuHPhBkjLG/ol87XVLNLn6dfzNPRxW5wylXXyknb3Z+A5sr/BeYLXOu4aB?=
 =?us-ascii?Q?43/iEznvQETyPtUacAuuDVWND0ZD1NIF9jcYz5epQo+Bzj9xRHk0hXWnrddq?=
 =?us-ascii?Q?WeuS/YiZMB3bmdKMlfIu+WFh1f9za7Rz//LvrHIixzXpr+m7cTwqtG4tmvB2?=
 =?us-ascii?Q?RCf94dSZnNzYClpmpDB9jW1Ysl/lIuvd1TLnTAB5nTX0o7HcJ8q8JMUcv1mv?=
 =?us-ascii?Q?2VESYLQRJUuTq6DZrMK+6L/Aq8vnq01z44fRi3uaUYQPwMTxzrBEDkf6WRv4?=
 =?us-ascii?Q?mZ+8tpGAxeVhyb8df1Gdjqu3PfjO5Yt8fMM2IRBe3p9kz8oga8LE5r5vmD9i?=
 =?us-ascii?Q?U3KdBouaTERzYt4sauqxlFTUeJnl3tRfGQA0xs5uUhA6Igun0bejA91T5CZM?=
 =?us-ascii?Q?xR+aBvKkZsR4HRQCgjJQbA61duefeqq9iKl/Ivi+5x5dwiJSHeHQ3rXt8nrl?=
 =?us-ascii?Q?AEvP7zHbh/56CTCCTDCUnOT3CgK7/cXuBxCfwOMpD0XtBPHUD25+8B8ITeAy?=
 =?us-ascii?Q?o9d9p8NZMQo9xKUHYNulXIQROGAJIrs5KllVe8BgN/XGROcjLGA/bdDU9Vrd?=
 =?us-ascii?Q?7Kei/G0Zyv5yD5KLOvNnUuQDzHuK7F+GwnwMZfroHYb8Wdutfu2V3f25AWjC?=
 =?us-ascii?Q?6dhExmZ26e2R/OO/e/Vjzrwwv6+AgTlR/6dFPh+2q9gAHEv4mCsHGlfLvHBf?=
 =?us-ascii?Q?iqfKIvnYbvhyRd+vX6Uo4s5rYPV9LkxCqlTlT5NCo4rg2VwxMfTKwTcsEcjZ?=
 =?us-ascii?Q?GonmBKQ3CJBsjOG63kg1Zdsp9Z3+IFActMhECQ4vVd+QjlahvnYleAPvdXxQ?=
 =?us-ascii?Q?3NDucokUWaVgIFHyBx63kibMlQ8jCTddVmU8mDGqkn7ubwxH54XhhPqKj8Od?=
 =?us-ascii?Q?KBJ4LVbqicSHR00zEV5tF6aqpcoeZY5jCE47U/COQc82ILR++dzU8gnhFwz6?=
 =?us-ascii?Q?JRmWUbiuHSHCGdOiyXDI9S7ApB+owhbfOl7FM/wjbG/8/10CfhKDwkm5cJVA?=
 =?us-ascii?Q?NmUsVhMQ2+1l3Ex9uwqipu2ZAAQNZrbltkPe+S0I2gAzZM4UqH6WkzyyDMDg?=
 =?us-ascii?Q?wi9yHTqSCKDFXqVSDKQ8TSWGpL8WxdtTlZB3aBKLshmjQuCXf0cIZrQcY9Jj?=
 =?us-ascii?Q?ivHx0fhSKDOLCpbn+97j4pXNi6t1wGAmuBmhO9RPoCsr5QA9xMUAdeqNFnYi?=
 =?us-ascii?Q?7whJmaBotFPJ1d/8cgQUwIdn0TKSwKyMNMSGyLCyRN+3QNBvo8mFwSNZoOR5?=
 =?us-ascii?Q?zu4WTblbFGNpU8YugLIido6sAKYaf0PlNGIKaLT8RpiikJflx7DhrJB36+YX?=
 =?us-ascii?Q?NiO42Jnbl3XXgQO0CtCx8eXm8TrOGt4fUHbGkBT9wAg1dv+462TEtTS+VeWr?=
 =?us-ascii?Q?D/qqbqwn47KzhGSM+KoljepNhKFaKxBKi2W8QsmcZln+oOvJAz3AatV7CuXo?=
 =?us-ascii?Q?fU96I7QWqECSCds/dt38eoFDYEvRlo1Irl1c9hmunLa9p0P9llXhIVSOmimM?=
 =?us-ascii?Q?fw4MvmklLlH5JsiwhTZtEWovn3r7DSAWmVBBIKZufw7GY+zUle+D6xv1CMDP?=
 =?us-ascii?Q?z2U+c7fINLPoznxjhpwbUyQ=3D?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ppetL7tV+dr1UsZxgAM52GDOZKC8/6CmH7x8qJbkLNhF+wSjoKPrWRqebYemxuIZSMJBLhOjSb6zkYcS2rZXH22sK4AavwTc58DIjCIzhmNqDZhCcKt7xuHBRCBNcCp56WNgwSfQkLT5kEsNa+8PGbfSeWvRh95eSpDh6W8DoPuaewI2X2ZWYuahBrGJqYoJv2n8mB6ll85+nPRYE7WP9jqxjBtWyHw/vbr/11zIn4EkTWFEEvXUJj0JyJQAuzq2GKCq7p+J+NE7ukaB3m0bb0svv3yfqi2qshxkAsgNdzpO1CvmI+ykvsqEawwbw8fBXzeeJWL2SPAtMNQA0aeZnwxZs3tP42zRA8SlftBdeXJiQNwNilf2W+lNxilRJ8+iQNGPPGvlRELbjaBgXUNX/P8t+TCUwuBLt4IdDxDEQP8Q9n5ALrHCoTW5yvgzqEAy8+qXoWPiQuOkaKnnAjshSYx5yMftBmIr8tGOhNmh6BFpQKniqn2mc1pIWzugbLU3CDozU3RQrrlI0ZXxGODLxOBSd9fbgrnXZe1rnhwtcWkA/o2Tkn1oKbgeAikK60+VqLCZK2f23uqE3cX0abN/m75u3im+vBS4ykGmLau62DI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab274012-b918-48ff-1684-08dd4c327519
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 13:29:35.3079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22hEXK6YC8BU5JXC5kFT8ChTA0DpiHLeg57Dd18A1iiskoqdnCr0hcsokWisTh/qV1HF+udpk2HRGhQBaYYGz598xbRDqVu0Bsoi8WnFq+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130103
X-Proofpoint-GUID: j2jpVu25gzXsmbwgrzMPoPASTIXHbihA
X-Proofpoint-ORIG-GUID: j2jpVu25gzXsmbwgrzMPoPASTIXHbihA
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 14 Feb 2025 11:05:57 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] fanotify01 test fails on nfsv3& nfsv4
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
Cc: "jack@suse.cz" <jack@suse.cz>, Darren Kenny <darren.kenny@oracle.com>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
fanotify01 test fails on nfsv3& nfsv4 for mainline 6.14 kernels.

mkdir /tmpdir
yum install nfs-utils  -y
echo "/media *(rw,no_root_squash,sync)" >/etc/exports
systemctl start nfs-server.service
mount -o rw,nfsvers=3 127.0.0.1:/media /tmpdir

cd /opt/ltp
./runltp -d /tmpdir  -s fanotify01

fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)
fanotify01.c:340: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected ENODEV: EXDEV (18)

We have been seeing this failure since 6.9

The test no longer fails with the revert of the commit
359047c97 fanotify01: Test setting two marks on different filesystems
https://github.com/linux-test-project/ltp/commit/359047c97

Could you please confirm if this is a test case issue or a kernel issue?

Thanks,
Rhythm

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
