Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C187D1037E
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 05:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764136110; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=b47wYxA5q5bh1syBlWs4Y0vW648SF3ktgFTGSEVdZ6U=;
 b=PaP845tsgM3R+5PoGX3SnyWfD2ZShtig44RLh3gYiXNDdN0/+WQw8kIMerngLWt9JO31Z
 PRLJhvPEWbkrYzm7bPXuIAIfFve8irSsO5pPqTiQXlBjUiPqBnU+t239ApYCa0lDdNrQHwa
 J7kHrIkxdcIsprL2QsyzWhVKoqnye20=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2ED663CF142
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 06:48:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F12F3CE07D
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 06:48:07 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 130706008BC
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 06:48:05 +0100 (CET)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5APIk5bV2659016
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 05:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:message-id:mime-version:subject:to; s=
 qcppdkim1; bh=2XtSo4LI87oMQZksy+cd0xDb17H2R+P5WoUPr0Cf6Go=; b=P7
 D4Dti1G84W2EZSKhpJuxlS0bl/zH4qMcC4xBtKI0Hg6LwavCAm/c3NyUqUrTootW
 ro8M4r1wko5vL+mUGqTOEIcuc0ljRdjWOOL1ggGEOLFTKrM2MO4bKJkHGxd7RZfA
 r6sleA4Rpz/q1L3z0RMF6TE9YMeZ6Th9GW2HuNuNGx/A6Z7FvhI4hyj+B+29+yLR
 AghEXGAmybd273W+9ATZVAzf+RDzdh3/19dGqOAJX36sqgmQrtHF/vfWdarpvt/j
 YB7bOo7YtdNrxjPlAeaOlMHOGgGG9A8N43nY6YawVeajkhiPm/K5ceLRJH4RAVRA
 tR97bDoR9r4k8MAbhckg==
Received: from sj0pr08cu001.outbound.protection.outlook.com
 (mail-sj0pr08cu00106.outbound.protection.outlook.com [40.93.1.78])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ana9xawen-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 05:48:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRdQn8Up+zMgU7WebnJTyXd7uYhdcnd2nng4cHlukUfk0tCARBswAQP87zmF/cNvyXx5S4zPKq89SLbjlv4tePI1hUkVQaXR4K9w/q+FXx7l9H/JqxEkfG66ZNj1Cqe4LLhEg5suSPGvAvwF9/5S5s2+oABh6WGJVa162HM8eghR/jLnstcME3CFatuILGdbdy68L15tT1rmISmfQ0iKIg98PmC4fTjRsffdyHA9l7vfXEzr4LQiqercvgv6n/q1bgE6uqAb9A5bSh2bugNVWmdebVCUr1EYSrNtx8mD17WgIscP325DVCmnJ7qy5DrIyfCSR34wxPddaex/gdybGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XtSo4LI87oMQZksy+cd0xDb17H2R+P5WoUPr0Cf6Go=;
 b=a/wLl8igv4w9PUZzJSC+Q9rmlmYn3XsYUUmhL1XSyXpaDueKXbm8AqfQNvAdQfWJf3cQ2YV108joLVwWPdNIVMFaDfJKf3hvwNZJk4iXyGUCMVS519npzPbnefz89N7Ea4ouf4mN1sjy0qF9LvN8HzdscUnHatF4R66dO8aAa9SnF2j1zTtEdPnThiv0j6F8Hxm3J5URg41a5BysAuaB+vKegnXUL7LreU8Fvl8TfGHR0WVb8+BGKLs0u1PNNlH1x1RaYJJ8Ic2Xl7Zjb7IotQPD0dKfqNQ5DzBnpkT9R2UisDFuKi+sBOd25e+rJ9TH/li9O74JdTzxOJES6xYGmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA0PR02MB9145.namprd02.prod.outlook.com (2603:10b6:208:43f::22)
 by SA1PR02MB8351.namprd02.prod.outlook.com (2603:10b6:806:1e6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 05:48:01 +0000
Received: from IA0PR02MB9145.namprd02.prod.outlook.com
 ([fe80::8b4f:d89e:ba0:d01]) by IA0PR02MB9145.namprd02.prod.outlook.com
 ([fe80::8b4f:d89e:ba0:d01%7]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 05:48:00 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] PR Review
 https://github.com/linux-test-project/ltp/pull/1274
Thread-Index: AdxemDgERwTEQ8RWQqa6yyB7w5LOPA==
Date: Wed, 26 Nov 2025 05:48:00 +0000
Message-ID: <IA0PR02MB91457D8BAAACCA7C1F02A0EAF6DEA@IA0PR02MB9145.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9145:EE_|SA1PR02MB8351:EE_
x-ms-office365-filtering-correlation-id: 6392b730-8903-4c1c-4bcf-08de2caf5c11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rjjWWHIyWXcocUecQU6aHX6njdquoK+kGQzgRAxgVoaoBW7QLQdyxtpFQSz5?=
 =?us-ascii?Q?5FdeMpJyQuSHY9OTDWvy0WawdHdjxugxpUWIo5+RqSQLQm87co2tQPlxYe5h?=
 =?us-ascii?Q?nZBA6v3xebBID010ZV4KueZcRVcYaYaz9H7oo2slb+U+1rssTn9R2TzaleRy?=
 =?us-ascii?Q?zQqMhwZnLPL6FkSegiSXb7QizH0eV1d6c/2+SQ8BgPY3heBycgJD7gXrEMnr?=
 =?us-ascii?Q?Dv5+gvxetP/mYZ7aVXcbrY0adBS9E/iDa/ZX5JPmngb1l8ylPC00EExXBDt6?=
 =?us-ascii?Q?1+5pm4CiYIvBKy6wNDHoQJ+LmSN8d/+FVvUnjZx8BAOdQvPaxeFYvi781bmI?=
 =?us-ascii?Q?Aq9Z+brEScs5VcL8SHbRgrzyMU7Edjg8voJWxUHUx7AMHbeScyKhYwOcJmJ8?=
 =?us-ascii?Q?OHi5XjqqBat0Mq+GPofuoBqfDTsybpzco3v1ZtNcffiT+7D7jKMdwCFAY65M?=
 =?us-ascii?Q?rA2IF4+ppjai+bya/KY+4Wy99D9OgU8RB6Z3zql49YHtp4EKDX4ymFACT1LE?=
 =?us-ascii?Q?qFyG6QjW1ZhKGi59VJdFI75/OgpTColfMtzzFrWdhQ2zPh499ZuW2vMnRpmX?=
 =?us-ascii?Q?GsFHYtZ3/ll7/FkLBDlOVYeTAP3xl9Ya8nnhe6s/POGdSiFpGqRgvaC0ZGm0?=
 =?us-ascii?Q?oKOVCOEHqXfRXcznUOgFeLtJ3GakKDxTOqc1u6foh9VUa57xDOpRHzWGUdw7?=
 =?us-ascii?Q?FvfXpau7SnjaWwYM6Rc58ivAAZ+lUBnD/lC9wYRww4zbakiL/2nROj42y4sJ?=
 =?us-ascii?Q?+ZuSvcCb34tPIkKasAGjAwDga6MYe4rxsbB2kqnHsNidKp5sAdA8l7BselSi?=
 =?us-ascii?Q?ZIztJbAfXiz7xFu+D1AUhDH/nMMriCIzhA3E4QkDmmxmcO3ANchLImOECKwR?=
 =?us-ascii?Q?Mbn89IOPVPxsyHgiabQifAuLtySqWXrDJtfAb6eYjwj7ZGEfxzcTqdrsr7R6?=
 =?us-ascii?Q?TfDBP2pbaRCLwsZI1zcWJLxu3wuspNn/Dm74/oAbP5jYkeqZH25vpzWdKyux?=
 =?us-ascii?Q?FtOHzCgT8zQNUkSUBvDtKd+69ex7+CCUU2l5pn9vQNyUh+pL2e/rRxE+/5Vm?=
 =?us-ascii?Q?1aMVlvA1Sexrr1QTSH0AuvgpyD4OfVdhrxryI2tZm1W5ROcVWG1AiSbBmU8h?=
 =?us-ascii?Q?YofX8uZNAoPy4kMJqqyidPa2PVMtPbtTvwsAb6R5n/zjOzJ8LR8qaKz81MFO?=
 =?us-ascii?Q?YGb5sAsDKQFhWIL4Q+uAQSXchGf8UAGnx7+NvOORUu1Xwv8zJuQydBTgOSVB?=
 =?us-ascii?Q?qhwnhY+JDN2v7+xxO5R7UXvrdB1ThxVMBSvXSwwOS6/5LoP1GYf4SjBWLkh/?=
 =?us-ascii?Q?Hhj7YDVDK76yIInpk2zGiAPHGg+e8CpSx4NEM6FIwVRipAiY/P2cpC/5jD4C?=
 =?us-ascii?Q?YbxMUrtB3akXXUt8qS02Jhb9PB4HUBQR6u68t5Z2rAgJ6jCuJsuWMcw3PfxQ?=
 =?us-ascii?Q?3i8BuM6qsNgyNGEmeGcBaPtOHGurmwo4twZ3skDOPaX5fjjRtJviemY2RDV9?=
 =?us-ascii?Q?V41QJrIWMg7qdcMrZbBK2Fl2NoAvbALlFskr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9145.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KIuCjo7LDezc6/wlD1bgL2r93NIETt2XYvzNdEGdF6BzGqTfRdRa8Zuk+H9W?=
 =?us-ascii?Q?FFLqMKVTXi2fuaV2CD5rvRxV2XhE38Mo0Fn9bYUadZeIjv+Q0dvBILK3OUgX?=
 =?us-ascii?Q?UHf6qCb3xYlm7FUZMlKIR4nWug7VwisHc53+NT+tc3ETlbXE8/nw21NU+e7W?=
 =?us-ascii?Q?PaOrMIDeUExKYerVRJV51bFKQ0Qtw8Zl4oiGr3ICrwOG2fPhYZwZbWQmJoLy?=
 =?us-ascii?Q?6xOQXj9OVS/c0mrv8f1t/DpkKDm0MTlhPqjToxWG8xja0K8doHYm/HNswkXk?=
 =?us-ascii?Q?ORw3vGzvn1110OjOx1jBObx8AMuMkYP+b1i/H2UoNILTzaUG/U/P6YI5jykf?=
 =?us-ascii?Q?hpKDwoYHcIOJyxqmDbr6cDICfMI9norXNCW02xoVihmx5PiQix671YABVZ1I?=
 =?us-ascii?Q?fBGOgqC5rxwLLeBaniaV7D6fQHrfZF0r5/mrOU1sNyHwUtDgA1tOC2g4HqPo?=
 =?us-ascii?Q?p97iR8JoFbDTam4EOhbYh2NHUti2RuVjRBM9n/oKHYYErcyQh28ClDx0kvil?=
 =?us-ascii?Q?MDXosK1EXmoMRec13nxnd5TM+fiNnZ9vkbkv5uxv65fgVMS7Da91syUMQC12?=
 =?us-ascii?Q?G14M/kdNpR/wUJeeOWZbcEoYh2rWL+7vpbi64eakxXvGnYcvTi+fCUJ1MD9B?=
 =?us-ascii?Q?SecURlTcf3FrUxV6+ScId4TRp2GFNd56sangRzIHTHylkpM0RPIjXx/LknvI?=
 =?us-ascii?Q?1wWOw0tIlUrmt2zmz3cO5bG57mnQIAhVDOwP20ucF3WqeJcLzXG8N6URDKCi?=
 =?us-ascii?Q?nqRhQH3xJaJe176RS/KqiqAb1yDPxQ3wodd06h/jd7LqucxCna/WM1PHkuvi?=
 =?us-ascii?Q?0H4kNwncgzRqp/4iY1lrC0Ah0Ze2cTSteqH0Q5aEt6IQ/0/T4RH9I4h12610?=
 =?us-ascii?Q?vfT1C7e54VqJRQCdf9LleakwVHZvNlbmyPUVuC3AvcpapyOOTCXC9awiu0t8?=
 =?us-ascii?Q?K+FdKJfbQbq96/VAU11CaPMY/Nm6LM6pd4D1En9uEYAvOdWMAk9sWqtbc+oV?=
 =?us-ascii?Q?0qyOiAgO0bH4q+TJQi45KHtNTBhVsoF5d/xlEGPvy9VosFA5xVyAA0dukb/s?=
 =?us-ascii?Q?KLO9U06GByI8DfWwHLWPucok2cg6MvBZdgNS0LeGhJXtqgaFPr3ZT8pbOc8L?=
 =?us-ascii?Q?bQbWJlvcKTcaxkDcgPXvbMj7SfazfKe2vmNUlMzGqv+X3bvTl118uxvxlxYD?=
 =?us-ascii?Q?jGgM5t4vmNJW1av8LvkY0Xsbekm6YtFnlz8Oya7VIrsnD3igV+z+6qq0c1QE?=
 =?us-ascii?Q?+8+FQhUOsCXLfJwW7Qj61jezcAQa6G/g1/QTsHBRgXckDRzMjLPTlj0k8IYy?=
 =?us-ascii?Q?kVs6hIShzh+qsxg4HqkLJB+6RShlgzmYPZaba0GgDXladdgaP8fD1HukDCHo?=
 =?us-ascii?Q?BpiNVUA7THmDkpS+VF7bjQKRkJnZxH/RFuXaqHDk1gI1w44C9VLErNc/rGEm?=
 =?us-ascii?Q?kvDQve7MVOjUu1D6+AiAvl2T/XDfyelQYVf9HbhPnAor9AIQS/4htvdjAFZ3?=
 =?us-ascii?Q?tmqMkJD6r12IF1ja4nK+XHxV0jgh+tBftxIX16KJdit2iW7LbFEf4hv5Th0O?=
 =?us-ascii?Q?X3S28vfhebDhsReA/mJIizvlzVII5OL+2yvtyUEY?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Js9309dKaKTVt1KJMIiSII+thKwlXPtQQYZjNGIrN/2D664JY9LfOa/Nk2uEwoDwUWhCZuX0cNvBOnGoRwj6aYh5Xa6pbEKKe/xD6wt2KpftzCjD5uJxeU8VjRgmLxvjMwVF+qXrRhoGIzZbnfRbNxvof7eNlp+/Ry+ZATWQwyeJqmQrJZfdrurJtpK6kiz7dYDaBtl2y7WJ6QQcMYRjyn+QzpAJQP2UaJnU9YCAUylA/a4nspNxwArsybQBsaP7O4XMgLtzjt2P/5opEO0xxUFEX1GWS2mClr1msyuoo7tOiTSnMC9inrsNWt5dHCBhcEu+PDTWNtC9tmi9503uy/kuslItTNA7KV/XrJAXW72tb/eLBWRyrLXpyWtsY9n5/0vMHPLB9cYrfNXvTq0477MQnXd9zG32C8BBeRWpZ5AeiNsZl7Qa+TIFA4/bOjfd7LT1GWlAgU7EEFzWHx2gnNCInTWKsF5cdhcK1DPuxstZfAoNj5iRfgsBBVp/msCLcWmlJy17IuE6z5bwHeMgeYPaad+X1L+ZI6WqSNSafDkvPvMaBNy1Y8ckqA/AXDOfTVqK5m+ToPjAdbp0oOtWzifUgxAsNSRxbEMH0JWbdK5IHSfOC2U+wGPJ7nXk+5bi
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6392b730-8903-4c1c-4bcf-08de2caf5c11
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 05:48:00.8536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLIXHs82V11kwc126S6dYnNtscNlZ9macF90e6EOg2A1QT8Zc9yqJxwTKsYhyZAJtVrbnSMdxstoi0MIbz2OR1PGxRCj9b/pfw/FYG0nrXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8351
X-Proofpoint-GUID: jmDfm_k9_8jHfmHw_IHhTA67vFPpOI3w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA0NSBTYWx0ZWRfXxr0pwDwyNbLP
 A+BCT0jW98F+2cNIzONH7Jlaq4va4WILKAcklPxQdU1Rt5s7XF+rEZvNUUJSy4/L/WCc5XDBUW2
 q5NbUOF1NPGc64kc6k+LVzq9xniGs0ErYLiu9OvmH3o2D5iFUYqr4N53wbiJvfUL3PV/7revrdv
 3Z6Kx5POTP6Oe4hiCb5rCTejX65K5a2zq0Na/njA/36Qwh7wsqCgvrg7bpDb0HI89xjc4ZlfKig
 h8a76q0EEzlKujAwz0+VkbEp8JZsR7W21LHzB5ek3h6CsG32CYRXNKAIF1DLGysBYbXh+hZA4KA
 TefEXZjDwPbcn5mvkUPp2bYIp2tYfJ6VKE7ue/k9wJ1ot9zDM24bGKS0qlQbbXirK4hwHdzVFvp
 da0ufxq7IW6wqutGVCaflp1eSDqfXQ==
X-Authority-Analysis: v=2.4 cv=Sfj6t/Ru c=1 sm=1 tr=0 ts=69269493 cx=c_pps
 a=l9cCpZ6fIogKje1+qubiRw==:117 a=NEAV23lmAAAA:8
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=EabcjzCCzl8A:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=o48m-KWDLkU6v6NroU4A:9 a=CjuIK1q_8ugA:10
 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=LWmWCm1LZTexa4xkZQQA:9 a=gKO2Hq4RSVkA:10
 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
X-Proofpoint-ORIG-GUID: jmDfm_k9_8jHfmHw_IHhTA67vFPpOI3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 spamscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511260045
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] PR Review https://github.com/linux-test-project/ltp/pull/1274
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
From: "Madhu Ananthula \(Temp\) via ltp" <ltp@lists.linux.it>
Reply-To: "Madhu Ananthula \(Temp\)" <mananthu@qti.qualcomm.com>
Cc: Jay Kim <joeunkim@qti.qualcomm.com>,
 "inm.auto.kernel" <inm.auto.kernel@qti.qualcomm.com>,
 "Kodanda Rami Reddy V \(Temp\)" <kreddyv@qti.qualcomm.com>,
 Prasanna Kumar <kprasan@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Team,

Please help to review this pull request dirtyc0w_shmem: Ignore cve-2022-2590_64bit CVE for Kernel versions below 5.16+ by mananthu929 * Pull Request #1274 * linux-test-project/ltp<https://github.com/linux-test-project/ltp/pull/1274>

Thanks,
Madhu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
