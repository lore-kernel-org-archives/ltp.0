Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891A4C54E58
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 10:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710497526; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=xrDQsI6VAUdqxvHzOlbBvkwdFtXIm+fIZvuZLaBA6Go=;
 b=FMGYFIryRN9mRKKpZWjUdsjmktC27dI8DzN1uxzOZM/KsLV0suivF6H/4NH+rHaIUVFqj
 M7P3zBt5oTHYr97bwj9133X95zKTeE3SWFYWaRlKIhvgCWfe0uGbSyKLLf16VlaQCoLS+4l
 GZC/dlELN+EXgGKdxDmp9nnkU59/PKI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A87C73D0A13
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 11:12:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DE8A3C012D
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 07:44:32 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CEC941BB959C
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 07:44:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2tir/yQuSq2PKm7zIQHR/L/VNx38y9rwQmr+OshkodeQvNztL+k2z59oYYWOB3zJ7kt0ejXxOdwMwL6O349q69TPITYQZi9rA1IJ/cC+R7rqeBx/Wbz3vGD4oKkWLfiWGzgTyd9Fd3ct1MHyO3DhB0xtQ9QnjE/F8h+OHYJgM7Kscxj1NOmiBCiyEaZPfU9gFKApHenuD0V7mQYB8XnZ/bI3vf4l8XLUVY913oYKudChTPyO0f8S5qcGwpfjUD2Pgu6WPBVVygpfLPHDcqSXlAnxpTmD6/OQAduJ4pjZN/+tK9TZT0ONEZq6ErutkciEArQxGbBi9T8e5nRolcsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdRLqw8sWwt6kL3HhxBlW6fLJuBA4f6DclxWe8RpeFs=;
 b=bmJEIlXxub1OxSKFghVqjfN1rn3QR5OpTzK7kFjiyMdZUU4OGMExH0TKh1qUzgMefrywJ4k3ZW67hh3Rl3adNqQVny1sbWuoH9jqyuItXvj7VvsLQENszF5kDXXQls+XkTTm4i8cKk8IcmHyKr0OFRDpqjjl2LGbSqGk+apo3A4BDVNqHmmLqf7dpqonzOOSfe49GmhMtNvXeNPyfalzqXqTxQ4fLxjcEBLa9aacNDtlWIlWK81cMlyIrPsvJOCAQvdSj/GQoDORXXKFFNNlVPdaHOSipkK1iKZ9b01K3IKQA2WyUNZBoOKsjWj8Me0z2RIj5ep3rlnNWx6YwlK5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdRLqw8sWwt6kL3HhxBlW6fLJuBA4f6DclxWe8RpeFs=;
 b=CtUOiMbO2Upjn3ul+tbOrDst4MYDizmVqV06w6ImDk/OQvnPA13obhEC6k9RW5lis8dNaobkgOP2WcHq8uHYoGqc27ivfWZ86ZnEG4uugPqCaj3zINvjXEOmI//+Jst8xCALZGtQcO2lzT6nfMzi6zRHeg2+qE48DwVeW2ESAns=
Received: from BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 06:44:25 +0000
Received: from BL1PR12MB5994.namprd12.prod.outlook.com
 ([fe80::1436:5871:f1bc:4a6f]) by BL1PR12MB5994.namprd12.prod.outlook.com
 ([fe80::1436:5871:f1bc:4a6f%5]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 06:44:25 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: Regarding LTP Version 20230929
Thread-Index: AQHadqQExjnYCF9lIEOk+QAFape46A==
Date: Fri, 15 Mar 2024 06:44:25 +0000
Message-ID: <BL1PR12MB599467E27B4B32A86788E6D1E2282@BL1PR12MB5994.namprd12.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-15T06:44:25.305Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5994:EE_|DS0PR12MB8199:EE_
x-ms-office365-filtering-correlation-id: e0b538f7-f184-4295-a404-08dc44bb5b11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uItJNCc1CafrcfwCXFnwN3t5Y48QJbDzaAdLTbFlVdoxLZDAscc88Fq2N/mPop5wfrdUlTwQlDOXLKrytk+nLIvZNJhss/h6uKyVnfhC6yAqIJZeEgX+IdyoXj5ADHtZHkkCbC/V9dzrhnHAu2VcjwVAnvNPzyF/UFpRei3+sumI2dx+S94pPiZIUYaVrHxhEUcSFKvMKBZGlMXry0kiqXK3+3NaVxTEWx+A0sqW613jhyMaRtx9kbdV0KSasHu6bu2O1QbMy9i75AsAxc91qKqPDPBbWxn1dBkZtMf2OqJgqpU9seo5U/adtyXd7KMqphM7kAJ7ntAeP+MQT0yOVFnKMX6AYWfu7a4mFZTlYxyPk0yX6bJJVkpANiC03UoteaT4NtQpPD7qyf0K1sJ7Ws9DZ5lJOcnBS8+iGgwESkwPjfKflEViWp254DL7YiQo5k53ukOe5wWtI9kv/RWJ21OQbPPmCnBMYwIn5SUHHXAeZdqHqydh1wlEWOui1yEf6Qus2xC6V3MOy/xbzPlrko+eLUwnnhXHgyFf36fMZmeTF2cxEnT0ANnsODOmDYmXqjJ9HhUmZsHetyZaeyJQTtLSeCQMMA97hlMhB5IH6H9P1qY7lWSPmaNyf9ap06ISl5D4m2GyzsiOH3Bq8mGBq4OT1qRgvzaKPVjhE9UvQoTTCVu3RwtsNsKZ+8N3NkJznR3ykbgoZpGfElgbfgnSL2fz4/RkDj8xnth7PkPKWVs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5994.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gCqEHZ0ieDGJzfIoJG2Sp8rz56lOXUF72Hzj4h6+9huwVgNecWoUpgBd0z?=
 =?iso-8859-1?Q?1pQKSaumHVl8rc2gZlN4ArQ9OQnVk3i9tTFegHvkROQDWYUP2eQBkRa2Et?=
 =?iso-8859-1?Q?nyGcC5zNyxRfQOayhNEfi7LNimyBWSI7UWrLylzW6KEG3kh4LL/q76QSOz?=
 =?iso-8859-1?Q?ijv52OUGIw5H+yCemE/WSLE4YFxxvESZr63XQbtY29NzwtwgdF//KtKE57?=
 =?iso-8859-1?Q?YyidI5iG9JLJytA5w6v6l+5cLQe1XJjVzEM6cAZOk1LT9/57w6nKsZG8NN?=
 =?iso-8859-1?Q?TfczH2GeWfTTfPKLM3evMFZ4Pmyttza5IANl+hP4rjKmrQAZmQigYjKmRT?=
 =?iso-8859-1?Q?E/fn4uBQKuCbGdClkGQIUke6FzhzJubvqU+nygPSqYspa6qaAwJA2V1Nqe?=
 =?iso-8859-1?Q?hWQak4kxgbI9H6JFhpm/Pl6ifS3oGqTH9N7qpWSeeOK+4gKdeYivcco94j?=
 =?iso-8859-1?Q?NeZVHp5uPWb3u3q3U/0ethJbYWnnQeklqEiZKgyB4MWibUYr83OSf9NIND?=
 =?iso-8859-1?Q?GiYcapHPiiqwoJEfFVLwpp/HwmBtt/fmbBMdTyG5kELt8tHEQyltwLq4K6?=
 =?iso-8859-1?Q?WWYMMt4jeP1cn/CIqn3/ejkyyw54VwAEJm3Jk5O8wN25B9fwo2E8LB6YqA?=
 =?iso-8859-1?Q?NE9+UyCgnDXoRVOKTrEP0abT6h+WyQX3nCOIlfm2+uBHzYsWdxMhc9HJOm?=
 =?iso-8859-1?Q?STqwsNHYz8v9V/Icydr6yrZdcUzAEIdI6qu4SqrKsRxDJ9TUa+2l5ceKct?=
 =?iso-8859-1?Q?2603DydSca3L0lN/PPfZkazspjtLiaqHVeuDcSkNgZXFSTHCVldEmI8ry+?=
 =?iso-8859-1?Q?y+f6I5r8+V7yo2PAXV6aDGaeCAVDRv2TJicES26TU0P09tOe/97R0CZ9uS?=
 =?iso-8859-1?Q?1dvpPJJlfbGIwm1dfDh82WS0R05Xb5JrZbkxFn8IV3NAqp841on21HY1vE?=
 =?iso-8859-1?Q?cMTpMLA0BpfBkxjymzrtrXCyBSRDWje7/wmbP1P6vOaIxDLnyH43n+PEE7?=
 =?iso-8859-1?Q?rwfpCRbPTgwikctfKJ1hnwkymjSI74JHwlT6CP+h3sZXUtC1avJvkdYQjZ?=
 =?iso-8859-1?Q?77UWhWREepkjBTWf5ZLg4aP4IizrEcf1yIP/IxQnhRA7JqQNZAiNaN1oIO?=
 =?iso-8859-1?Q?1P9WKTFy5EIVDrh7U14o4yF+F5+10iRbBU0TP39m2ItUSEyoXuv1L9yuBO?=
 =?iso-8859-1?Q?HwKhPEviJEr1OQLTgxYrzykfUyOuzwRd/Nx+7IjTOW3tVdLaQNyphzK0sb?=
 =?iso-8859-1?Q?T+T9U0O8pn7Gr4B5jzS5Jr7bNkUEIreBNDJ86tRpXDaBjjqIuk0fk1WRmX?=
 =?iso-8859-1?Q?3m9S9/h1wmdfyJmHAc0agM6WIWX+zR61tDAQ+GQG3g6kUYAtAmpg7QO7+j?=
 =?iso-8859-1?Q?LIQBo+ZWiw25MN+rs9fB+IQUKtxpPu8FfiG1mQbY/hCCjs28KoI1bj+RXj?=
 =?iso-8859-1?Q?EL1QLgfrjn79/5Su5jmOIOdyBcgWCxRsuLh0VZ29gpAkKdgMMqPmTEEIb7?=
 =?iso-8859-1?Q?IghSXw/iAcL1a6ejKQO8RQelVzcfyLtgblTbhO+AH8IFWZwpsPA+I6Ht3Y?=
 =?iso-8859-1?Q?ngSejLA04lg94KumFlg2YrGVVOr6LmbxDz0mwdmAoqAyk6axCbF13bG84i?=
 =?iso-8859-1?Q?tHpc/s1wLNMfM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5994.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b538f7-f184-4295-a404-08dc44bb5b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 06:44:25.6858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yChnjA1brhnSi7mh3u2Ag9mDDfBtrGAJNsXrzkcce0lHOlNd75qD+B87sjEIrau8T2mowBKYpyKpPc3wawAPUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 15 Mar 2024 11:11:45 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] Regarding LTP Version 20230929
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
From: "K N, Santhosh via ltp" <ltp@lists.linux.it>
Reply-To: "K N, Santhosh" <Santhosh.KN@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

[AMD Official Use Only - General]

Hi ,

I am using the latest LTP version 20230929, may I know how much time it will take to complete the full test to get the results.

Regards
Santhosh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
