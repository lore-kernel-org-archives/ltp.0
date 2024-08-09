Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AA6C52D71
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 08:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723193583; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=AfBgvw0KRLndrLiMvIPl7MITCX2DOv8hzzt0fMr55FI=;
 b=ElU3cDswV/aPyev0rHtwK78vpgPiNZNEOjSmRYJyfdmQDJp2Tm/YGeaeFlIAf9ERSTYk+
 kMfDrP/NASR8T8k+7mC5HbuBB5LkXN7tckRRle5qnGW9R46mbXbB+h8jYjq1EODwP5YVf/i
 1ACBWL+B3dNzhwtSH3lQCLOgzKs6N2c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 131413D20C2
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 10:53:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA4F53D0D14
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 10:52:39 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.159.247;
 helo=esa10.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2ABEF1A0435B
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 10:52:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1723193558; x=1754729558;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Vx7yYZXv1Tv0/zeTnJpRfyyRvvb6tKAdXy77vInjG4U=;
 b=SAsuuRhy14ijlKro+YxEgz/c6ws0jArJoW2wXmPwJbdZ00zUhNvL4d92
 qKUmpPZs8jMT/UPf53Osi0mw8flf7MojTaRnpnhlgXt0727zMp4LwamRX
 DN3YltsiDMzEB+bBUHpCwIbqoxolwZs8L5TcnXMLjTlazUodgmqSbCc3w
 XM+8MUW3x2Ys5mI0aNvFOUqj7/zqSXtmNjtWIxay6/ui5QX6tBoAsvcb2
 RADf5DK4gF5aPqJTf8BHyYoEqh+O7KlyFQH+tlN87WBO7mwS0OldZeotl
 hZm+3JxxUaxg9nXBhsmdmMd8UCoOh+ZHJ8G2cD5o/0RMbR/ycjrlDBTfh Q==;
X-CSE-ConnectionGUID: nzW3x/peRLiOzaLZlhWXsg==
X-CSE-MsgGUID: egIRTIoZRaGZYAfA9eDjqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="127782489"
X-IronPort-AV: E=Sophos;i="6.09,275,1716217200"; d="scan'208";a="127782489"
Received: from mail-japanwestazlp17010002.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.2])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2024 17:52:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8PxSD7eCiiGh3GMKoV1pBoJo9tldHG2gI8z+OxB2DRpmyUvkWADYqoznHeFZ6zyPASI5O4EYN5J4O+Ldz5AoJ18TfO29QVIU68ply73gDIDpBJoWcLxeK/4dzlzBxq3XWkBkaTNsqQzjTpspPUCbDLxalV6Jy9dd9MnU3DURNXEYKnwLnDhsENSUh1bzHJr4o0U3Jl/h8WGf3lEXO9wwvVJjT0Pxl7Z6CXE0qC5Ibi+Mt9fpMbHggmE3yy+ppzlQieVFem1wNeITBRXU/HtXy76c43/QvMjjwyz+KJyTcF5vJ2ivr1QwEgGs/uuwkUjM5qWxAjtbtA87BevbaKnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vx7yYZXv1Tv0/zeTnJpRfyyRvvb6tKAdXy77vInjG4U=;
 b=uVy26yGHYoj3J5cAHjeGZ7m15wHDhvmXgjUTqhE/o/6S3QasvzN0SPPdAlvp5VyDZq6FILhm+HlK7SYt2MuHzbpESdMSv9pAQxzrCl/s2dgprYH23pnKxul9CpPSjizY8h8BhHKfirycsJt2Ntk3xE3GsWjmKbM4XG5NY+tQb5OgFB4y0KEStEOwi+bSLLxqAQFwVk4O6YBgcV8JGYYf2j9h/L3CpO00jcxijBNwRziF22d/YI8Y/4nsGGdMXYa5/u52qVi4mhG8d4AJjhuINYiy6NnJTzunh1PMnmcnt7lq1sePwDt51l/FWRBGKmM7pzxEESjwiZUcqGH+/rWgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by TYYPR01MB6926.jpnprd01.prod.outlook.com
 (2603:1096:400:d5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 08:52:32 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%5]) with mapi id 15.20.7849.013; Fri, 9 Aug 2024
 08:52:32 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v2] cgroup_fj_common.sh: Do not disable systemd related
 cgroup subsystems
Thread-Index: AQHa6i3aQaYCy08AX0WEd7St9QTpbbIenJuAgAAAeTA=
Date: Fri, 9 Aug 2024 08:52:32 +0000
Message-ID: <TY3PR01MB120713856F5B63EA95B6376C8E8BA2@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20240809073010.793324-1-maxj.fnst@fujitsu.com>
 <20240809084527.GA337675@pevik>
In-Reply-To: <20240809084527.GA337675@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ODA4ZjhjNzAtMmRhNC00YTg0LTlkZDUtODcwMmM3Yjhi?=
 =?utf-8?B?OTljO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA4LTA5VDA4OjUyOjAyWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|TYYPR01MB6926:EE_
x-ms-office365-filtering-correlation-id: a630ecb7-9fde-4efc-bea5-08dcb8509b42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?RWM3eFh0d0xCcHlqZUJGZ3lUZklQNk8zRHUxMkZETlZvUkdZdWpwL3NkSVE4?=
 =?utf-8?B?VEpBTjllL24wRklFSUZuZ0V6czBlc3lXVkl6SFJZYUswa09xdS9jRmFhejU1?=
 =?utf-8?B?UU8rSEJjdWxYWmppZ0JDT1ZoK3Z6NzhKRkFoTEd0RkFvM2JaVE5MVS9STXNT?=
 =?utf-8?B?Q3lkY1ZGUi9oTzJkVzh2dUMyWXpGL1FwNDFyOUpyY3dURHV1QlVpeVptaWdK?=
 =?utf-8?B?bjRFUDRydGtvMXFiT2lDWDdYZ3gxbU41MjZhclpXc0hGOWFyaU9JSUMxcGlN?=
 =?utf-8?B?RzF3M3RiTEhCQVoyRXdscDIvSHNTMW1rUTkzTnltNTJqbWtyV29HYlBGSXdk?=
 =?utf-8?B?a2V3WVFwVjhTU04ySTJkZzJBTHR5cjA1a0s4NGVSVDlFenJKdHlPbHpXa0pG?=
 =?utf-8?B?UW9aT1VETDVyK0ZHb2lVSjVxb1M0eTJtWWRDR3dQaXQ2VHA3Y3FYVlBQbmNm?=
 =?utf-8?B?S1cyRXVmUjkrZ2RYQ3NNMlk5MmlaNk82VUpxZktGWGMrSXlSdnB1UmF1SUhU?=
 =?utf-8?B?MWsvWEJ6aG92bzRYb1o5aUdlckdBRjhSdUVVMWVITlRteUFtVlpVdmVsTEU3?=
 =?utf-8?B?QlhJREpTWitoZTVVNk56Y0lycmhFTkJTazdVc3hJUDl6RGdGbUZaNC9DeEtr?=
 =?utf-8?B?OFg1SUdtUjJBcHRXNnBvMWJ1U0pZbkR1bmdZVzJuaTlNalNoTnBwQWtqYmli?=
 =?utf-8?B?YVJTbUpFeE9HTENvemM1S05BanNDYW1sWFhMdFZockFKVDZydkRoZkFvU29I?=
 =?utf-8?B?WnRqMUtjUnptQjlCMUxqeGFJVXNQMXA5bVFBb05lSENYaXFkVElUcHJhN0NB?=
 =?utf-8?B?YThIeVZHZjJlVXNXSTNiZmcvd1p6M1czQW00K1ROZzljdVM5anFSSmJIR3py?=
 =?utf-8?B?N3pwU2dSLzh1SU03K3BQekM2aGVMRitmdW42Nk1vaDRSUjNKYXZIeW1RTjZH?=
 =?utf-8?B?eW9sQnAvSnRNR2d4OTVrdnhrcUI2NGt1WWMzNGdNUGcxTW9sbDNFalNJajA4?=
 =?utf-8?B?aGNLWXFWR3VVNjdFQnJ0V0dWSFp3bDEvNkNabkQxSEYyZnNVajJwNDVsRkNC?=
 =?utf-8?B?VUdydWgzOTZ2Ky9BbGZyZEY2eWRldE5pUU9CbGttdGhvVkRJTmNQT2hERlVj?=
 =?utf-8?B?NXc2cG4zVWJnSWRCZVlXRiszSzZXcnBRWkpiZFdOb0pUR1BicEtudU1jb3kw?=
 =?utf-8?B?SThwTHVVdHRhNnMxRjZTSXY2L3g0emlMNk1Sekd3VzBKcm9BREkxbkJ1eG9a?=
 =?utf-8?B?SUEyU1dlNjJGdHhUNXdTUUxhQWtUR2RFeE1tODh4Ull0b1dkZnA1TXVOTUhE?=
 =?utf-8?B?YnkwUWFzbEtGZjlkZkMyNldRNHgySGpobWZUSnIxdnR5RitWNlQ2bE9WeEJ0?=
 =?utf-8?B?YXRBWFJ2Unl6SjNoK1dPTSs4M2tpS2tvemFxQklXamNwL3h1eHhQczdYQnlu?=
 =?utf-8?B?dnJUQW9vVWFFQ2tHTUR3RE5KU0lQYVRRK0NSWE1jRlhPSXZ4Sm1SQktjdCtw?=
 =?utf-8?B?UngwL3VvcHJaaEozRUQ5MS9mNUZLbVJlczJrdmNkeXBTaFNmem1DZEVoT2dT?=
 =?utf-8?B?SkVFSGpXRm4yejJWak5CNUIxU0ZGb1VZdjRWeDc3Slp2UCtUOUF0MzRSNFFM?=
 =?utf-8?B?Wm9FMnpzZnhGSXFOd0NScWxITHJQUVNoemZHUzFtanhqaHZ6QmVhS3kzRWRi?=
 =?utf-8?B?UnBBWFB0bzhVSkJOMXBMbnZ6NjR0SFVadjNiZEVzSEFlZTRUZ0xkblpQUUFh?=
 =?utf-8?B?TDlsYWo5ZC9GTVJPUVRmcmJuQTdZRlFQQjJiZmJ6SGp5U1dLOEFwZWZ6M3dn?=
 =?utf-8?B?OG9PMWwxQ04vSXVaMUtPM3FXcmhFa3VuN3k5dU5WL2k3aGt5Q01vZ2NyQklk?=
 =?utf-8?B?ckpuOEpaMTA4RHA4Qy9FSW4vdmlKL3hQMG9RSVlQZ2JXektYdFUwaVJ2eVM4?=
 =?utf-8?Q?5wy5mcrIRjw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dURZSFFpZjBvZlB4K0R0b2wzS3VidHJ1UFBxR3V4bnFrQ29GdHpSUkllRWZh?=
 =?utf-8?B?NGVZN3BTMm95S24vZGdpOFdjZEtjMVE0Tm15Wjl5c0wvcEpRallwVlhjcGRQ?=
 =?utf-8?B?VURXNlBHOE1xdkFieWxQU0ZHVW9aazBVSUdMQXVWQTNNSFVFbGd6Y3RlekE2?=
 =?utf-8?B?dk0weE90NEZFUE1aa0REQTZHcmZvOUdvaFMwUEx4T2Nad3FranJVY2Q0Z3Zw?=
 =?utf-8?B?a2NLSjlHMEF0Z0VEbmlyL0Z4UDEzaWJldU1CaGEzVTFoUXRnS0c5Ulp3RGpF?=
 =?utf-8?B?QUZjZEhqTHVBNmFsS0FUQnQvcTBkd2NFYmN1SUlIempibW9WdC9wU2gxR3p2?=
 =?utf-8?B?QWFmTnVRcHhueFliZEV5T2UvRjNJWnRqR3V2MGhObG56K2lJRVl3RmFIV09u?=
 =?utf-8?B?QnpKdzNQbmRtSmNZV25UakYrdTdSVjNVeEZaYVlGaE43bWxrYmRIdmVPeE9I?=
 =?utf-8?B?WGRWVFZMU01SeUdnWFVFeDFuMmo0ZkNHa3BDWUM3UnFrNllCa1E3R0FLRHlz?=
 =?utf-8?B?d3lFSnFnOG15djliS0pxdXJwa1J4akxSaWdKbE00T3JGQjFjajdUNkVBdzYw?=
 =?utf-8?B?U2dFK1RBemh0QXhkcTllekowdDV5WkJ0U1JoS25nTEhEb1JyU1lNU21SalJy?=
 =?utf-8?B?U21rbE5rVXRLcmxuYjZXamdyVGg2RjZpSnFWR3gvY05wOXpiNUFRS054NnJp?=
 =?utf-8?B?bVFHSG9GL2FwV1RsaU12Mm9XMTQ3Q1podmNnL29YeFJldGJiK0Vrd01WRjVR?=
 =?utf-8?B?ZHZvT3NNaHcwenF2REJEZytkMEpkMUl5RGF4Qko2R2c4dXZMMDVUd1dUWDRt?=
 =?utf-8?B?bUVzQ2dBY21uU2pnaWJaMEg4VTlndUUvN0hCMTA2bXhteVEyQTI0OXUyTmpK?=
 =?utf-8?B?d1dIVzNzNmVHbFZJa0dzQ2cyaHRWYXZaL0JzaEZpSlFpUW5EV0FhZzZ1R1Vq?=
 =?utf-8?B?WnhCUGhqSmVIMHZ6ZThkbGZmbkNUY3N5QnNmT1h5SWxaWHkrSDhSaVZhNzRw?=
 =?utf-8?B?NWtGdWVGblNBOHVMRGlEcEJzMDgwR3BoUGpZM3JlbW4wVEVCcDcwU1B3WXZk?=
 =?utf-8?B?RUY5RmZsY1ZKOVo3VGVjWFlTQld5Qnp6RXU5WFF3QWxEWGw2VGJiZUtQL2Fw?=
 =?utf-8?B?empUWU9qUHVrNUpKWm9PQkRJdjRja3RQWWRHTTZ2ZGZZWExZOFRFU1YrQWpo?=
 =?utf-8?B?ekdzVTdMcGVieGI3SFpNb3ZOTzdGcDU4azhLZzU4WUpGVU1WdU9PSWhnVVB2?=
 =?utf-8?B?VmlIN2k2am5HRkNKNTEzVDJKVnJxU1cwQVpqZURsZHhhY3hCZU1KVkxaZVJD?=
 =?utf-8?B?ZG1KTnpra2p4eHNKSllucTV1MitFVFkxZ2thczVmMVNrTzM3d2Nvb2p3eFhO?=
 =?utf-8?B?QURBaStYbGdocy9xWjFqTVJ4L1BCMG1RenFUeUdIUk85WTYrZ1RUbGRhL0ZM?=
 =?utf-8?B?dGJjczNoaWx2dkFtWXJYNU5VbFU2eEFVcHVvWWFhK0o2TnZ1eTFqQ1Y4OUds?=
 =?utf-8?B?bW0rekRvSHVlQVRCQjRuY0tiZzZJbzlUcVhuQlRVZDhSaTFYczJWcFNIeHBU?=
 =?utf-8?B?NzhsRVErSnBVSnREY3lBOC9BUU5KcG5GOUxVZlZCVmVJMDNxZjRldVI4c0lh?=
 =?utf-8?B?Y1RmRWdvZ3dkYVA3anFXWDBFWU00cGkvaGdmeW9MOWdFa1ZwNUp0VEhkbDFw?=
 =?utf-8?B?ZFU1NkpSalo2Y2I5NjJyWlRuRXdtbTN6SUYrMm9yMTRteHNzT2hBRmFLL1dY?=
 =?utf-8?B?OVlQMUR1OGhOeld5ZWZnQ04zOEQ3bDd4TEdZZXJmVEZlZ0JmN3MzWmZOdEw1?=
 =?utf-8?B?VVY1V2lRM3hrWmpNM0dQMDFTeC9FVHJIV0tOcFp0ZnE5eWRNeXVnOXByVmkv?=
 =?utf-8?B?WnNtSk5VeHFwZ1JOWTNxd0thSEtSZGduK0xGaEZHYXVsS01kTXJ5RElzTUVG?=
 =?utf-8?B?UUJEaFRhNGhFMkJYWFZMQXZOUldlN28yUURXSTVLVytPb1FIMmJ5Z1k2YTlh?=
 =?utf-8?B?SkJzT3VwMTJnWXFHK3B6MisyY0x2WUNoMzNnY2tRa0F4LzduNitLaVNYWlFZ?=
 =?utf-8?B?YUYyUm1iSWNhS0VRZU5rVVZWUE5zRmVmSnFTMmV3dW5uTitIWDhEM0pvMjJT?=
 =?utf-8?Q?4PmAfxxnucm7TNN4rMewoXLFq?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bX9202qaQcRKxkbFdAj9GpU+z4R/vjAooRpG09PqkoO9ORQZMjWistpxDtSddmPwRl2LxxsRzL0Xg4pNR/eeWartjKcaGZR4HdOjzcc2G/7+x4VbPThbhvinpb0TTaTmaXyqx4xMFXMhiIyRH+YTC+TUoyk+Lo7HFFgt+iEYZ6m1w8NhGURNsvC2L7DmY/4Kd1uce34pnIqRzwiRWjZAQfd/NQI4ZlMjdTFzZrJ1ugPka3jf5NkotlGVSUdnqMPS6UqZNQTSmyPfovTpKkzO+gbxM2AOcXde1axjoGgNMEHRWSKIl15DHsV5hb3wgBP1ohfcM3eDtF4DYzB8+twSoIiu1K4IYsQi/dVYMxn5vArVCgktkkfbUnLLv1jQ10bODYN670JLBMLD9N7QiJYuzNH2D/ARzf9zszQf3iDXxQTN3msu5VSvoGPgdPBufSMXEQTLQh2wsx3RJSc2piJP2G9WgiM+8RdH4Qm5Lb6222UgTcyUJxNqG5mY0B50fSv0NykgX/CZaf/OStqe94VhVR7aTWWfg2kb/AjM+1We1V1im2RWdj7Yv2jJJGfRwi6KxPxKefYlMvUi+Qi/VXYwwZcDFiUUsFULaa5+YfJ9Y35DwdUPIsCjkSpdxfkB96od
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a630ecb7-9fde-4efc-bea5-08dcb8509b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:52:32.0987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqr2Jia2qr/JXr6YcqJj3zYVjYNrhKQoGkchpU+KarKxUL7QSyoF7MoPU/vtdDPkA47LpV15SKPUTvxMuhzZIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6926
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cgroup_fj_common.sh: Do not disable systemd
 related cgroup subsystems
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
From: "Xinjian Ma \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Xinjian Ma \(Fujitsu\)" <maxj.fnst@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Ma,
> 
> > The cpu, io, memory, and pids subsystems under the root cgroup cannot
> > be disabled because they are used for systemd. Currently, the test of
> > cpu and memory subsystems in cgroup_fj_function.sh and
> > cgroup_fj_stress.sh will report the error
> > "echo: write error: device or resource busy".
> 
> Could you please share a bit of info on which system it fails. Do you use cgroup
> v1?

Hi Petr

It fails on Fedora 37 which uses cgroupv2.
cgroupv1 won't trigger this failure.

> 
> Kind regards,
> Petr
> 
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> > ---
> >  .../kernel/controllers/cgroup_fj/cgroup_fj_common.sh      | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> > diff --git
> > a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > index e866641ba..153d351d7 100755
> > --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > @@ -77,7 +77,13 @@ common_cleanup()
> 
> >      cgroup_cleanup
> 
> > -    [ "$cgroup_version" = "2" ] && ROD echo "-$subsystem" \>
> "/sys/fs/cgroup/cgroup.subtree_control"
> > +    if [ "$cgroup_version" = "2" ]; then
> > +        case "$subsystem" in
> > +        cpu|io|memory|pids)
> > +            :;;
> > +        *) ROD echo "-$subsystem" \>
> "/sys/fs/cgroup/cgroup.subtree_control";;
> > +        esac
> > +    fi
> >  }
> 
> >  . cgroup_lib.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
