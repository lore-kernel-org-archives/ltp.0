Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E874BC27C55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 15:51:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 775283D0B52
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 17:51:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76F1C3C0326
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 17:51:34 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=sony.com (client-ip=185.132.183.11;
 helo=mx07-001d1705.pphosted.com; envelope-from=tim.bird@sony.com;
 receiver=lists.linux.it)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com
 [185.132.183.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7FBFA600749
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 17:51:31 +0200 (CEST)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AFHJMe029578;
 Mon, 10 Jun 2024 15:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=S1; bh=ngSO8E0
 7esjyy4C4Fu/YMSKqPqQP5mn49xHfE7t1+SQ=; b=Tve1GbRuBVLMhHr74S4garJ
 k2EULMVD1Vtt2SCxS2pSXU3vrVdrVXml7BpqZYgPnbjuHk32GkKA0aqC3nv9NtpT
 8xclavxmm74Ab7UPiUwAze/EaZXfkB2COz1ch/jG84wMa37txyVma2TyoXAeOvau
 EMDaXhstgAyY10PRK6EORXQPlwJJaHo4LAdRDY2SpuZneIt1eBwPO503sj+55FpK
 diKbq6FBA3MNG2In+sUtyKjaEXzCWye7B+sbOKLdyTITl5RHhmSbqzSdX+0FKNJg
 Q+0rlLn7ilG6uNIs0FtlL/G/1Ji3V4V48I0pF6GDfCwVpBF+haKxZhnO1cAMSQw=
 =
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ymtersks7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jun 2024 15:51:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXWHcJPohpL32ILvYZ0k8hrakN2GExG/Sn7iPkqtJgOrvXBiZCUl+ZshxQDfuFttWPO8rZ53Ff3/A1Y8j9qdujwXOsjAEazmJs48ffKvWDvZ1lNHkUZkIhSGSgH8ODWbpSr+tlidwPtyp783avrjFQp9LniApk5sdSWTzpEgNPJq499wmeUgfNS5DM3wmj6CgpFjgl4fbN/pR6f6pomxAJm+5oI4SQ/fv5VEgnOLqDlSXrdE15b+xJv0rXGy2k2RGPNIaeyNNQcbpXJVtzqCZ2peopAFxHO3zpaPQhUW7hz2DO+HemKfnef/kikvUX/dblN4EQ233cMfJJbW4ZK6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DBpSUJZ1YK+vz0Mi0SmrEpEV9+G+BUCgspviPnCorE=;
 b=LXyK3vlOWBTYRi7XvdSvvkACQI6LfPWli/SXpg8GFH8jr7LlOjvHLJPUrPVvykp8e9y1nsBoVdFpfTD/3nzWueaRDzCDb6ZpKDIYedgpNEVMCB8pVpWVXm1C5goc0upuA/+XIaorJEm8+XzUpoqliPswKHaJyPlanhBCJXKb4oy5aGUOUw8qjdjcL2N4lmOuj1lk6400+ZYwtx4XZkrR3hkTIxMtSqsDIEjjY7/E8R6qMabSXKgT08n8i/jUZ3H933MDXhMjEp41O4awqBvIzRU9AlxfZeloVMBDM3PurAy7+MIZvXtmSsVUdOBxwFPSCL+qqLyGpsHXmyE6oEM+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by CO1PR13MB4886.namprd13.prod.outlook.com (2603:10b6:303:f5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17; Mon, 10 Jun
 2024 15:51:22 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6%5]) with mapi id 15.20.7677.014; Mon, 10 Jun 2024
 15:51:22 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate, add info
 about kirk
Thread-Index: AQHauOZtg6jLCnSkL020MsAFSFbsVLG8YjUAgAAPWQCAAAZtAIAAB7gAgAAG7gCAAAkugIAAOHwwgAP1SQCAAGlEwA==
Date: Mon, 10 Jun 2024 15:51:21 +0000
Message-ID: <SA3PR13MB63722C60AE789DABBCB3A311FDC62@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
 <ZmM25L0EmJufsS-f@yuki>
 <ee1e4c128c12200d6f55f2afe34a44cd110c33e2.camel@linuxfoundation.org>
 <ZmNEW_Q20Cf7hnUr@yuki>
 <SA3PR13MB637235EB7D225D1D68AA2CCEFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <ZmbFyjuXndeXCLp8@rei>
In-Reply-To: <ZmbFyjuXndeXCLp8@rei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|CO1PR13MB4886:EE_
x-ms-office365-filtering-correlation-id: b6ec2803-d78c-4b7f-3522-08dc89652d10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?8aISrGeaYYoEIBIrSmuUy5coHk015nDBrWPW+RQM8ep/0npYRf6kQz79IMTS?=
 =?us-ascii?Q?CYzwiy9ixychM1SEGJLwcTdLvD18ulUaAnK8ilq3sMyf9/Clf4bptNIo0ABh?=
 =?us-ascii?Q?deOE0xyIwPByDSNQ99B4tmzoGJUa/iXKkAPL51EIkDb4SMzbSa+rvRC0sNSV?=
 =?us-ascii?Q?YhWEkjoMBfEgK9wo5PDKJh4/bg1QHims+JFXwdHJ9HjoF+QNPp6UUdipqWR7?=
 =?us-ascii?Q?uILZAomLkrvpNlZTRYm2lutx6zlUMw4ChFiSmhH5fQBstUw8jy2cncRdgu2y?=
 =?us-ascii?Q?EvpyoArlWYTf0052E7e2Eu54v277DdAMTcslIMMZu/zI6pue4YB8Abj6v6s/?=
 =?us-ascii?Q?fxdVFOu8Sfu8q8F+clHgKDSGfZDEliokxXoZYkXgwsVLTQ3nO9nHConV420X?=
 =?us-ascii?Q?RuDG0gENMb60ugvhc+lyn2YNXIW6KyVe6k9P62wG7yh5pEvfY2fwfFg8/wQO?=
 =?us-ascii?Q?VRhTKGq8prE3cQcMGMxDZdi40HieBmc1MYdEg0kcU0w6o9sNZtbYbMFQlxm3?=
 =?us-ascii?Q?aMlQXsGPWpkcsoOpSlTAVZU5+bxMhDhIR/G1wqKe/diplT3enCxm5j5paEzb?=
 =?us-ascii?Q?NxCLae/ReFaxyFtHy0/gj3st+Bk6u5uMNjphuyYZOnhBfP3qMX1w93R3Pe7C?=
 =?us-ascii?Q?WOOYIs2Cw2SkjX3z8fKrmTegRfb4A3XASoYF61QfJ7BbFe+I+Oznc/LHFQ6r?=
 =?us-ascii?Q?T3HT1IimftdJKbmveC378Xq4o3sfOlLAj4wMLSrHLNjyx578HMcBQSk9grOg?=
 =?us-ascii?Q?sFUF+Aq7hwiLa1r0PKdO456A3Y2Nc8qHxYq4rYXxRwZNK1picvHHlEiGXrqI?=
 =?us-ascii?Q?t4M09lsmhijqveyAbyuvMWD/zazbt7+c74s0ebSKGEgV/sWBFcc7VkFI46Cw?=
 =?us-ascii?Q?H62CWFcnZIJhrWmJ4Z2p3s6JTC+jCeLVdAeTFu3W8S8kB/1H9hnXxcIqk9h2?=
 =?us-ascii?Q?ZxE0E4cD5JFAfXr96EqZALSF8dlI89+UDz3N8tRJ7Y/KCM14L/DL6Q0zHcTP?=
 =?us-ascii?Q?4RsFFVlaoB/q4uNK7a5VMyooCq2fZS1o37r0xEz7st9sTHuyENSna+Ms2c58?=
 =?us-ascii?Q?NO4JJi+B1pWrGH1V7CzsyY2oaUxLhG522N+nVMhKdY/j8kRycVIVE/wPr+rj?=
 =?us-ascii?Q?NJEtdkx45xT1NLeUgKrNZkRvWfaUCz23aaZWjEk15mJQQRJtWuzNXUlEoMpF?=
 =?us-ascii?Q?bYvx/wM0iZmVMkS7vLM+mpdwNkRYDTvmLOTPOOdOxgsq+QeLY8FKCUTDsAvz?=
 =?us-ascii?Q?Wz7a7FGHObUMNXrvnSHCPmi9mSGfdEFRgcaMZxBFp8qYkfAw4kBMP3Od95cD?=
 =?us-ascii?Q?lQ6TyM45yUeagm5Twzt/WxXW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR13MB6372.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?94geNXdyAWRnVkzLTZDaUvRbKNggrnrN9kFAigFjikEhBhCKmjLgrk3xF3F+?=
 =?us-ascii?Q?Ef0HF64lMfJiP/sgwFlyospBOXUOCs6kiii1l8XGjU2G5aamCYRu9ZirMis8?=
 =?us-ascii?Q?nsPegQXQ13GotLq98O0ikNCJBFkPzwtO2DaXKNk+S76Ecyw9/Nhcbs633NAh?=
 =?us-ascii?Q?J7MdI7FPRPWlHoc1RGi75YFYYqStflIeW0kDvfnbPPmwvLhF/AZhhr5G+ia3?=
 =?us-ascii?Q?ljNcGhrykz2ZbeqnSt9M7pXtFsW4KwVZAmqYTLjCcvCYGMpPD4OaDJDu7F0c?=
 =?us-ascii?Q?3ec5c/57WNFKcyt1tEJs0vR9HssQiKuW+8fZTIvSIE/w7yYgH8JPO3HqEPTa?=
 =?us-ascii?Q?+dVuvTGdHRcF+xFbHLSoayb2YoXgZaFwlBunkZ7i21klSUmqcItLZL6qTKCV?=
 =?us-ascii?Q?HajdxdumS2r6DltjJw/0PgGnUXf75eSgX5+gljqJZCkcdMS6V3304Fdwc7VN?=
 =?us-ascii?Q?1IvDlhOmhi4qVw41YZ63FE1gvi349wVwr1G1M7IMXksB47/g/F6fToTcbKPy?=
 =?us-ascii?Q?qRJVSgcICmfjuJgON7Zw2KLFhf7xrqlbQhzrglBaYU4ctBuezYtBffCfoRSd?=
 =?us-ascii?Q?mGMbr37CQqYuCc31YFvf7AJ59pwNKkE811rVR5nScGFMiQBDBRu+oeHB+WWk?=
 =?us-ascii?Q?1rzUS8ujuD/6xd9gnO/jUHtaBABVW48h1+eiIQgmaSZJ/HcO05+VLeV2M+Uc?=
 =?us-ascii?Q?p4CGHVeDyl0sk66Rdi9kkA1rGcXNWN46TvRLybyunLkpWI3U7MOwy9SPbCO1?=
 =?us-ascii?Q?1tNj+YWoEw/vsKQrGa2eTTkJidbL5P9RemMm1PttfEtATdOsG8+2FNnuEhTp?=
 =?us-ascii?Q?cwOqzMDy3n4gwSWZaKSH+ial0MlYfxWP8D7rC2OaZJVRshocWggfOWkX32hE?=
 =?us-ascii?Q?kg6/2+9A/j5gQP2ypfCwuuRM7QAspuUGbMY5FtzsEisKsoXXiO97pUNf7EGQ?=
 =?us-ascii?Q?4KzY5G45FCoC2bqUsPn62+1iH+yXU4wzpTOvYE97yiVzU4E3RoR6sY5q5dkU?=
 =?us-ascii?Q?LsElFrmDWluGVQavmWSAo7eOw32at6sWHrC1Eif8++GJvOlJtr6tPcb58VVy?=
 =?us-ascii?Q?q93gdg5LGKCvWEnA+waZhNrHjOyyR45TC8MrtP3vZ4FeQYiuqXMxuwzF27aA?=
 =?us-ascii?Q?T+Z3OPOp0WI8UZ3xxpVvUTjuP00Fe44I+Rb9stQZLF4je3EQEU0D31Fl0mkr?=
 =?us-ascii?Q?tgS4dUJ2VMOQOtHrthGPqcp84VH7KakhQujhImdDAt69R/iMUUbWIYBLS72L?=
 =?us-ascii?Q?vPedlKFDpOZEM4pmAn5G1scNTmE+eIjODwB+VjMEXRWSZCg3qpm2hGRN/IrP?=
 =?us-ascii?Q?UMDcCxXp/ejDnxETAfUUQ4rhVTmthIVnQUApLW5gNpXaLqDcEwwGanzDgIGJ?=
 =?us-ascii?Q?N16iYtwuEtCR7d4+AGqM3FRBrA7M+yGKdmlOMXsNj8fxzyEj1J5ueJNSpAhO?=
 =?us-ascii?Q?rWrvDsgtvll4MJDNRwzYK9q68L4awiAs2VjjnOL5H3F9bzgGreg1jLe0Olhl?=
 =?us-ascii?Q?+WSP+LU+xYILdbAVf8EAz07U+r/7IRFYPCD6oQ1kkg4sn2wduN85pu22F/EQ?=
 =?us-ascii?Q?5vr8y5asFrnk4r0O0WU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i6Ul7A2nUbe+Zlzx/n8gvHHZBJcgnJ7e6QUfS2oFUIkis6WdPg3EjWzPvYojqv47tnT1cAsQuVQovXFHWFcXXZrHP7rFzalOQPcVySOSoXKiyaLAej6VN+tkrJyz9wlFpyBr5++9Liw3OoNxcbmmHFvdqX5toaevd9tmjA/IOrmRtCzRsnkD8iT1jKkHIqQ6ETmHEwXhuqoGxQiS9upCmEl9Es0ZAu1YDHg2LxB9e8tSIJvbUQLzTEtkIq23FKMyXEEOuYdV31DFERR+2wNT4+PCVbQHSmGMEhFm6W1wPy4Ad4YM7DQQtx+DHfhD27vOyu863bJXkTIzDeYWlBUaTYFUBaM7viXRD/SHNg5NJWyHhqFPkT84jRR0dZNUEvF/prIpaXbttwgqwOdtBkKO+CUqVaUn9ZbmZbfDjn9X1gEl9yGw/moLkeBKXo/7xyFccZAOTe29dRfbq/lamCwu8iL23yDQinvoG0pMkZCvMVQgz3ri/j99c+jUYK6rI3wZSMFxm8ek7WnoZALCQ2X4/1NE4jF926w0d1nwymsKkf0M9dGGz9KhaQS42aXXbexZxtBr8tskFQ3wWgenneDJq/TmjVDgj5jmZ+IsAMueV4N15GUzaKPPmWJe/Yfu3eUc
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ec2803-d78c-4b7f-3522-08dc89652d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 15:51:21.9853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8m17xJXEeTIuNbZVR/v4inEXWtLbmzazwZu97O7oFO8BP9iUro496OPSdP+4FhUY8Wuxow6JVU+Na4UI1k87g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4886
X-Proofpoint-ORIG-GUID: WCKWzcZ6nPSiDu30HyT8c4J21sKZhHOf
X-Proofpoint-GUID: WCKWzcZ6nPSiDu30HyT8c4J21sKZhHOf
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Sony-Outbound-GUID: WCKWzcZ6nPSiDu30HyT8c4J21sKZhHOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_03,2024-06-10_01,2024-05-17_01
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



> -----Original Message-----
> From: automated-testing@lists.yoctoproject.org <automated-testing@lists.yoctoproject.org> On Behalf Of Cyril Hrubis
> Hi!
> > I don't think it's that simple.
> >
> > Currently, Fuego users can choose to either:
> > 1. run a suite of tests (specified in the runtest file) using runltp executing on the target
> 
> And this is something that I think is a suboptimal solution. If the run
> crashes in the middle you can't easily continue with the rest of the
> tests after the system under test has been rebooted. So the desing
> decision for kirk was that the complete state of the testsuite execution
> is being kept on the machine that drives the testing.

I agree with this.  That problem is actually why I developed the second
solution, and another Fuego developer added skiplist support to runltp,
several years ago.

> I did a talk at SUSE Labs conference when I tried to explain when we are
> heading and it was recorded, unfortunately it wasn't uploaded to youtube
> yet, I will post the link here once it's there.
> 
> The bottom line question is how much code from us can be reused in your
> environment and this is something we have to figure out.
> 
> > 2. run an individual test, not using runltp.
> >
> > In the first case, since some of the suites have a large number of tests,
> > there are options in Fuego to convert the results into spreadsheet files
> > or PDF reports.  But this is based on the multi-test output from runltp.
> >
> > Does kirk provide the same output formats and output options as runltp?
> 
> We decided to go for JSON format for generic the test results for kirk.
> 
> However given that we store the results in python data structures
> internally, it's easy to write an exporter for a format you want and
> produce that directly. We can add CSV exporter for spreadsheets in 100
> lines of python.

Indeed, JSON should be easier to handle.  It would still require refactoring
as we currently split the runltp output into different files.  It would likely
end up simplifying things, though.

> 
> The JSON exported looks like this:
> 
> https://github.com/linux-test-project/kirk/blob/master/libkirk/export.py
> 
> > If runltp is eventually removed, I'll have to come up with a solution
> > for executing suites of tests on the target, and making sure the output
> > is the same as runltp (or modifying the report generation code to handle
> > a new output).
> 
> The second one is preferable.
Understood.

> 
> > Fuego supports multiple "transport" layers.  ssh, serial console,
> > and adb transfers are supported, as well as a few weird transports
> > (such as ssh to a controller board that then transfers over serial).
> > I wouldn't request kirk to support these oddball transport mechanisms,
> > but if it had support for mapping it's communication mechanisms
> > onto these, or supporting some pluggable mechanism for transferring
> > files and executing programs (collecting stdout, stderr and return code),
> > that might be useful.
> 
> That is actually the end goal. The ltx is designed to marshal messages
> over a byte oriented connection, the supported commands at the moment
> can execute binaries, transfer files, etc. We intend to use it over
> virtio and physical serial ports as well. So the idea is that once ltx
> is started on the system uder test kirk connect to that instance to
> drive the testing. It's not production ready yet, and that is something
> that I have on my TODO.

In that case, would kirk or python be required on the target?
I presume that ltx runs on the target, and that is it a native app?
What are its dependencies?

> 
> > > > > We do have the ltx binary, which is the small dispatcher supposed to run
> > > > > on the VM. And in an ideal world we would have a python library that
> > > > > talks to it on the other end, as a part of kirk, that could be reused
> > > > > separately. And the same for building lists of test to execute, ideally
> > > > > we would have a python library that would export a simple interface so
> > > > > that everyone could integrate the blocks that they really need into
> > > > > their solution.
> > > >
> > > > Automated testing is a hard problem to solve generically and even if
> > > > you do manage that, this all looks like a lot of work even just to
> > > > reproduce what works today :/.
> > >
> > > Indeed. However I stil think that there are reusable parts that may be
> > > worth putting together.
> >
> > Possibly.  I tried for a few years to integrate Fuego and KernelCI,
> > but their architectures were too different, and I eventually gave up.
> > Now that KernelCI is changing, I've thought about going back
> > and seeing if I could transfer anything between the projects.
> >
> > Usually, you have to write some kind of mapping layer, and the mappings
> > turn out to be harder than expected, due to assumptions baked in to
> > the architecture.
> 
> That's what I'm hoping to avoid to keep things in a simple modules, but
> I guess that we will run into a lot of implementation details that will
> make things hard or even impossible...

Quite likely, I think.  It *is* difficult to make modular pieces that can
be used by different CI systems, but I continue to have hope. :-)

Just the fact that you are discussing this on this list is forward progress
from where we were 10 years ago.  So thank you for keeping us informed
with what's going on with LTP.
 -- Tim


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
