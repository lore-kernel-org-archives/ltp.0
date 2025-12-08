Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB1FD3ABEF
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 09:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765186742; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ndtgQNWSqX7wmZgPN7gZhq9mKWlarxUt1+uXNOsk44U=;
 b=pRq+YmDDrGVkUY76fNdkPyr4dViTOzNs159wCpOJprpC4+l1JjXJOcKaHQsP2WxUzCky4
 sP1hFgSSXWP+UC66pl0yz2pOKWcyBhClZZkC0r9kF+Wq/ZNMhGhzRK3TIHiwZNswdrLfHWh
 bHjEh9CnNNVFn1cDuNHdWCdyq2g0rEo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03BDE3CF300
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 10:39:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC3A23CF2E9
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 10:38:40 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D3B9A1000361
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 10:38:38 +0100 (CET)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B88LXg62909698; Mon, 8 Dec 2025 09:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Nz4SWCjq/rlm8iJaBvvCvBPGuAfsYhYUoN65AagSx5Q=; b=WlYBMbZArdDCwImU
 h9cv3POCRpKYGxHzgBK8pVBTNRrl8YjUKOOdnEQt/Lz6ARi1cObd3ZQn7ahOt+69
 aMZ+9PiRFrmMJlMAH5LoXsmYMmy/mqhUXX++Ezi0YROGn9uglffq69aJMARAcBOb
 qa8tWYHx7Pn+gLzRoyu3TGJxHGFMxruq4zK7FlE/5tN7zkqkfpkeYFjWhByXLMTt
 o3WOQmTQcLAxM7AUfkvPMqd0kVCMhCBBP9Hpax4BLGUsKIrMR7zQ1aoyv3CMB7r5
 yO210MkhWngbNndLHUMwp6o7RBqWFrXKskiz3VeYK8LEtK/Inj5axap0wyr1uaVS
 zZ5ljQ==
Received: from dm5pr08cu004.outbound.protection.outlook.com
 (mail-dm5pr08cu00403.outbound.protection.outlook.com [40.93.13.99])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avd8e4dh6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 09:38:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjxUbwJskCOOJ1u4xoaies5KEcpYAqnM2ZZGYeLsRZvxc8k6aPHAXlwOrm1kD15gm7vHNLUxtnBYg6nrHQzTpaLOGHmMNFLmmrFMBsnyB6ngYUSjHPvYglTMZflOjgp2PTiqSeO1WK5eJoJbs/itYlgxwDygG8QPVcRdSKbH0TeVNFhUJitDuUAREphoQPPixen1JSZKgkq25RIZnZitVhOI/gueRismkJSorGWe0XhUmF6Ztj2EReptx0lBWjEIUgTF3X0/Hq2DbN6yKzI2lwoMN/Oc1EFeeF3SvHpFRylaOPsYILZi5R3iKimC96BgoLFAfoLY8fj6MQKap9ROWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nz4SWCjq/rlm8iJaBvvCvBPGuAfsYhYUoN65AagSx5Q=;
 b=iZokCAJ6V5G7SCI+nF7f8vn/ZEf5GXwJbEngfWZMgSXrXEtKSemfgGrJtvCcm24OrUmOAOmpCeF8HabUJ2NBfMH+J78Bi2hS3jwdcINaR2KFSo06Fl3ST8BPPr+Acr3X9FWefsluUjaIKmS8XeZP3i4rPdZN6+1LHeDM9PGvyY96Unhk9gtaN8/W7EC9praOkFugsjMYJE/1/83zQ8+h/jDzLGJZRwQte/97ZLBmKZLwq2DoKEW3DPXqgSUBti0xhUM9G8St7OfSjHz4SqbbQ3TScV3vsFdDZ+lLgnvji2BnouPnCO96OZZwkqsPKcPL6XHY/XOa6rzirPUQ6a+aKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA0PR02MB9145.namprd02.prod.outlook.com (2603:10b6:208:43f::22)
 by IA1PR02MB9574.namprd02.prod.outlook.com (2603:10b6:208:3f2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 09:38:31 +0000
Received: from IA0PR02MB9145.namprd02.prod.outlook.com
 ([fe80::8b4f:d89e:ba0:d01]) by IA0PR02MB9145.namprd02.prod.outlook.com
 ([fe80::8b4f:d89e:ba0:d01%7]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 09:38:28 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>, "chrubis@suse.cz"
 <chrubis@suse.cz>, "rbranco@suse.de" <rbranco@suse.de>
Thread-Topic: [PATCH v2] dirtyc0w_shmem: Add minimum kernel version 6.0 check
Thread-Index: AQHcYDMHeYlgW4Coi0OZRnq4VKI1hLURG+LggAZvzAA=
Date: Mon, 8 Dec 2025 09:38:28 +0000
Message-ID: <IA0PR02MB914578F69138FFED02E8F98AF6A2A@IA0PR02MB9145.namprd02.prod.outlook.com>
References: <aRy0-9KIPlRBvnNk@yuki.lan>
 <20251128064808.3865023-1-mananthu@qti.qualcomm.com>
 <IA0PR02MB91459B3A455BB3EC50D43256F6A6A@IA0PR02MB9145.namprd02.prod.outlook.com>
In-Reply-To: <IA0PR02MB91459B3A455BB3EC50D43256F6A6A@IA0PR02MB9145.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9145:EE_|IA1PR02MB9574:EE_
x-ms-office365-filtering-correlation-id: 79458a90-9f88-4fe4-fefe-08de363d8b20
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|13003099007|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BV6o58TU0HIg0Yu/4ibJO6OejypFgajgRv6xJEEx8sjPJHb9McUTg92efDJo?=
 =?us-ascii?Q?GaDVmz3isFJr+JHTg1we/6Z2XLzavcTXzS1t03MhMra/d1ks2IRXewCPo+46?=
 =?us-ascii?Q?y5KMA+jnaXPiUdl8tEYRZ9knFwt3DFUwdWho9xYeCTjYie7s/W7npFasm5IO?=
 =?us-ascii?Q?wW2oKiZeVaSQmnJUCFoGs0dVTdYPPqIwnWeNGwxj9wDM62NZpDshTa0V6MGO?=
 =?us-ascii?Q?oZj2iNAb0Fu5HWGps5/FnPicymNgKILdDxO1mbEosL8f/ZDiFKkVq2d6puLO?=
 =?us-ascii?Q?miS0t9N8Vt28SbBS9P6OTObGUWWWMqfaNbYbIQe7CODIPJVcczYGVqggq77w?=
 =?us-ascii?Q?D7g6PSAvTyogdEViHHeofi56UcK/lddXm7wEpBd/QYEuBeAGckIvwF/FAAwp?=
 =?us-ascii?Q?6q6HWh+KyWy7I0izPIdMaVxcH2b+McCkqIdzPYBEcVBX8iASeS6uQLCrwokk?=
 =?us-ascii?Q?t5QRKxuqx8kjsg3YS2Lpmb3W9swCWcz9xeVMfR4dtU3nnaLlkIpLgveHxJiU?=
 =?us-ascii?Q?K9rV29AoILTGBJVLhivI/s922aHrOe6iqmLYnssEUQnbkApyAOoLOu2l3hru?=
 =?us-ascii?Q?GP3dDzmS/WgpoGCmx2+Ux3+ucJez/j+ZhmG/e74cwqKRJCJUW8vArXMywNXx?=
 =?us-ascii?Q?+1nygeR5XUVLiOmK23/ONzqsMmWP0uQA2gdmurngQ5h03UmHzp6J10oGQHm9?=
 =?us-ascii?Q?bPrgn19IunpAHRXGDDMRAx1bPmU8rM4DWp3eHlnUP2ynChA42WNQAaByi9A1?=
 =?us-ascii?Q?uZsSR0OlAK+tVui/Vc412njXTwXJcYrINII14HLQuUk8NAtv8XuXtHeCLjC1?=
 =?us-ascii?Q?+1uoDgMvwERtCX5jz0d/+Ytzz3pX3SwE43kXuFef5MKrunXPFFRWChzSghWS?=
 =?us-ascii?Q?E32K6QqHCr/2nvUu9WeYd+QAyM4wzfgmPd96TXXKFQi/spY7KdTF6+jus8cu?=
 =?us-ascii?Q?2uC/IX23eMSWkSCry3dvFVhAH0dL22Q95LC81bAbnYubWqynJ2q0YpuXthI7?=
 =?us-ascii?Q?8iPnw37BnMwdwiRw9GYM5xxCHwTgksqnBXnmRRBp3izzEiu1z4seXmP5WVxI?=
 =?us-ascii?Q?WzaKn+oLlonVdCOYGzJ9DJQcglB/IckO7GdvGDHegul00Z8nIuWopFJkVL7Q?=
 =?us-ascii?Q?DwCiKYL8tDqRkcZDKHz3Bse9Lq1n7AvD+vLCKcVYjEYL0WP3B/R6e6eppZ+k?=
 =?us-ascii?Q?0Vysw4z6uoCjEhueDmZ0Qm8pry3aU1RhVLgH9EQAf5iuE1yq9nYqjWj4SSoB?=
 =?us-ascii?Q?Y5GB5AHzM84CQQEVOfnegP4NJrT8fDI1mdkNEhciORi6wpIxPnOrLGMd9+wf?=
 =?us-ascii?Q?MXQ+MC8oXhv3rPUnbP+EU/bQtjOv7u75g/7eWfuwimDfKshsnV2YgtkvRflh?=
 =?us-ascii?Q?2a4lvsaezSasM4zJK6YRTfoMmTx+BUSRPDd3zFm/hbO4ndkIFtcTdgZoNA6B?=
 =?us-ascii?Q?2YRFNtrSCpCtdTJyE/TZwr3/pX/cnsCsvPw5iNRnsh8OZayMciXlbhFSK4r5?=
 =?us-ascii?Q?Yvz89hqnDgoYDrgNCgJlZLYnUPl34Aq9V2ZO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9145.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CN9rIk5+FN1gYY/7ZtWdOQExrlQ0X5eIqz6BGBnHljTDxFvsx4lvu8yx06ku?=
 =?us-ascii?Q?R9/ccMYW9vjWNBCuwuqywY5O76/k/okDjrXKCzhJeiCDSKy81iGUSOklgY9y?=
 =?us-ascii?Q?p/n9NetMvgl3o54qNHstpYzDfSyEOW6S4sAQ36s62VB1i1zK/+9kodM46FUl?=
 =?us-ascii?Q?a1PrfyztwYECzqcPDUV6/DON9naHVLqNT/P11MVHFOdDNZSsa7UbW7wiTBkL?=
 =?us-ascii?Q?LbMxmQI062o/3SFGImrOvlriVtC4gKkTSBm7CKxIM7dqv8Ujn53ytJ9bveiW?=
 =?us-ascii?Q?XC4actkBMqoovCZFuhOrF+YCl1hj0kcy+j098LdONHWQFReoTpidG8atsEQ8?=
 =?us-ascii?Q?/j4nBCdf/LdGFCr8a2zX4AJU+9IElA+d1ZOpFBbS1D6Opi0UBy6IsTlAjcPp?=
 =?us-ascii?Q?+WCXnjjxxF3XRh5GX8cUmsIss3QytErYB3Y/kqwgO7/Ew9uJulRA1sC8W0Dl?=
 =?us-ascii?Q?VT8MyRx+3yPMZ58m0haFULMUcaD8eGRq6GYLNp5Bz2nPu1zna+6WaeJ6HhsE?=
 =?us-ascii?Q?GdhflQwtDu8Go68PP227jqIO8ZF4NRgFzcghD2t2a3NC2BI2Vg6xVbxq+IV+?=
 =?us-ascii?Q?VRLZxwLT9/rkiiNts2SxgZEFLLtsztVK5Ex4hb02/15inA02OE6EuVLnYzQs?=
 =?us-ascii?Q?yVO0omGjQ+0YTZLMHotoYCLSFXYbQeOfkO3bja4TDhZYXA9dBrweJvRF3Snd?=
 =?us-ascii?Q?dAYYQsnlRBmN53OdyzV2AazyshwFgS7D9N+pYxNFlvZr0yw6PnnjL7A8dSnK?=
 =?us-ascii?Q?LzQoBb3H0fRCr13bTz4Q84QDfwZ3W6mfSYK3Z2L5jMwm2+1SN2CMu2n6Ngpr?=
 =?us-ascii?Q?rMn8KaVfzdxIS/CKby7FigfUrUs8f4sXHyDEIUhvgRIOU73KnIBErrBU1JCg?=
 =?us-ascii?Q?qzdIAs9YfVxzWrXVManhttKENxjrrZDvAsAkfvelkimfBGkbGrktHjlRlYRS?=
 =?us-ascii?Q?aW9a2o0LdrYF3qqxuu834cDQ/5+73lhy7SU3kPR1V6W+bFqa9cvlgjy4cu+p?=
 =?us-ascii?Q?wPXE6gracWVyqUGEeNLo8RIBox7E3sxxIACZZ0qrxOk1s9kBx6m7yY3yocSN?=
 =?us-ascii?Q?ubp5E3IeH/dIW16WjZ8bEeXasVOq1PvXo+xtkgpRAKaG1mR065uERgFIMGLp?=
 =?us-ascii?Q?tYWi9DYXMVS+X6YNSFgj31ppnEuyr3oi+RFss6yUyaJZzd16nQQLv19SYvMo?=
 =?us-ascii?Q?ANzpcCz3iO2Qnr9viEQbvDFAYlqJuSBC7q6B+LPTSicZe6iz+n2AAocRgvyy?=
 =?us-ascii?Q?rFa35dqm0ciZdX8jm7XbF1WBtpQCoL/BtSF0ExZ2jgK3TMIXQJDifqVqMJLp?=
 =?us-ascii?Q?UJ9H426PmObzV4rihh4lNxguM1YOV+YnODYAGUDiK3ytVj7JpEkrnTsqXWg0?=
 =?us-ascii?Q?cn3kMEtE/lZPvmIMaaSoSHp5UERXFdN0LutUnK9Z7Vww7CdbrFh0UfPxLGBz?=
 =?us-ascii?Q?6sueBPvMSOn9id0mvnETJfhQQ1y04XXPAAHTIlTL3l0OUT/S7vgBBu40mYyc?=
 =?us-ascii?Q?fM4I/NQ0plFaENs4YZ7LWeqKXoz2uTafMh07wVJdif8DJwA7J3JUuVjOPnlc?=
 =?us-ascii?Q?e7/mSJtkVS31qeOhZOE5lMuB//AaxbFjcFVAt/2i?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RPtV9mt9nVa00ytqvPF8OWEBMlrqsChaX+f3b4mkqdTYEhxFnyYHD0n6LdjQUjC9gwS7KNaP3uTsk+Ai5YWdvbBbRAnYyNziH3M8wmOd3ZNLLtvp9kYCVrmY0vzhhPlfexIC2cnoPOccPUSJ9334LpzPbdIDGgb2g0v3NC8p9X3UYWSJxYeeChkunZgIpon382dDC/iI4Sy+LXK7MfeDpVF9PMGg4l73EJ+I1WvRR49MQjKyerdnICty02i2eucMd4GvmnI/eR6q+bfUwGpYeOiQg/w93UzU1TK0tQQmoDAYSC6Zq0O2lfPTqPTIHohhfbY0TZ1EY9NJKfUAcvt1HbcL+GLVWuQx900vyrnpwOU4LQh0k0HCZixHCtW39RI8c8S8RewPM6SLdEl8uLt+rosBrEFlJwihDI/PTb0WEqRbBNSa2b0D/MR5w1+LNzPBErV/UYB57qI86foggZVbcG31ewVK0ZmUawGtct0tEb5FttM5Q0Sa4J/8s9Fqg+cEnicLI5ONirwL84kpPi/66wjC0ZSdwU/qhYJJzI7IhFIdlnqRy+9OYfpKcL52eYVRcD9n8fGNDQqdbaevzd1aI00FZEAPxzdf+pINy/KYa/TCfU1BkrHrx1zikwcIXAna
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79458a90-9f88-4fe4-fefe-08de363d8b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 09:38:28.8093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gl4hkCh15vGAmcZDs6pnNic7KDNI//RL0UYwiT1POMBPSbvJncTvwwKJwHqWz3DcplAC/DBXjpMabwPi8zOeqGTy53VkDWVz+TP9uxBO42Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9574
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA4MCBTYWx0ZWRfX9C8VQduRp1pR
 B34gOSFbwGAFOD0MuxZ8jjyg0GfkPT9hZW+Eskes5UHk7UwbK5U/MfhWbZtIBgMxF8WKV+iJA/X
 Tv78ISv/tGb3tO5oXHQd4uP0HeoYlpqWLVt2YE0zewbdNSLmo+06ONjH0GBGf5XUovChD9t4x/M
 Ti22awWbNmka+Pjx6mM61cwVhreEywDiCnAi376gSIcwIXteGHzfVZrPnHjgYkrtZYCfl4VEvzg
 ROG3Sr7AoVSS2jfKksIZs0QDl5tttg03PkOVaWsmxYVq6pmN2NPibO3C3LAgbSxFE5egpIcUX10
 6gbeUaEW/zMvzjhYTmwjP5l+L+KfrwmxI1c9trfBzw+Vy2J5FUOZ8NimF3rcWyIQAXv6R+G2Ppc
 B3ouFZJYl9XdGEsgGhqYqSoenBNWrw==
X-Authority-Analysis: v=2.4 cv=BqaQAIX5 c=1 sm=1 tr=0 ts=69369c9c cx=c_pps
 a=lnBElVBKEKT3wjluJUCtwQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=1XWaLZrsAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=lFR0lyDagDS_Z-kbEe0A:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JIBeK_y8YfTRUpViQ0lXH2QxCZs_64Jg
X-Proofpoint-ORIG-GUID: JIBeK_y8YfTRUpViQ0lXH2QxCZs_64Jg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080080
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] dirtyc0w_shmem: Add minimum kernel version 6.0
 check
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
Cc: Wake Liu <wakel@google.com>,
 "Kodanda Rami Reddy V \(Temp\) \(QUIC\)" <quic_kreddyv@quicinc.com>,
 Prasanna Kumar <kprasan@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Team,

Can you help to merge this PR?

https://github.com/linux-test-project/ltp/pull/1274

Thanks,
Madhu


-----Original Message-----
From: Madhu Ananthula (Temp) 
Sent: Thursday, December 4, 2025 12:52 PM
To: ltp@lists.linux.it; 'chrubis@suse.cz' <chrubis@suse.cz>
Cc: Wake Liu <wakel@google.com>; Kodanda Rami Reddy V (Temp) (QUIC) <quic_kreddyv@quicinc.com>; Prasanna Kumar <kprasan@qti.qualcomm.com>
Subject: RE: [PATCH v2] dirtyc0w_shmem: Add minimum kernel version 6.0 check

Hi Team,

Gentle Reminder

Can you help to merge this PR https://github.com/linux-test-project/ltp/pull/1274

Updated the V2 Patch with Review comments.

Thanks,
Madhu

-----Original Message-----
From: Madhu Ananthula (Temp) <mananthu@qti.qualcomm.com> 
Sent: Friday, November 28, 2025 12:18 PM
To: ltp@lists.linux.it
Cc: Wake Liu <wakel@google.com>; Kodanda Rami Reddy V (Temp) (QUIC) <quic_kreddyv@quicinc.com>; Prasanna Kumar <kprasan@qti.qualcomm.com>; Madhu Ananthula (Temp) <mananthu@qti.qualcomm.com>
Subject: [PATCH v2] dirtyc0w_shmem: Add minimum kernel version 6.0 check

The CVE 2022-2590 vulnerability applicable only on kernels 6.0 and above.
Add min_kver = "6.0" to skip the test on older kernels.

Test Module: vts_ltp_test_arm_64
Test Case: cve.cve-2022-2590_64bit#cve.cve-2022-2590_64bit
GBUG: 418679607

Signed-off-by: Madhu Ananthula <mananthu@qti.qualcomm.com>
---
 testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
index 2c7ad00f2..9cf495704 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
@@ -103,6 +103,7 @@ static void cleanup(void)  }
 
 static struct tst_test test = {
+	.min_kver = "6.0",
 	.needs_checkpoints = 1,
 	.child_needs_reinit =1,
 	.forks_child = 1,
--
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
