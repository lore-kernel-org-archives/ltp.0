Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCCFC433F5
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 06:51:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80F463C9517
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 07:51:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9C6A3C8979
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 07:51:43 +0100 (CET)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5A969140076E
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 07:51:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1642056703; x=1673592703;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SuibG9v43LMlh7Kj2At0qiTBwRPstcAF3mgq7Vd70Es=;
 b=sfI95W5YDNTVF4Rym7hQf+EZ2NsgffSUKqthuogzDMgE8NBmLsSdyyB1
 Q5sf4gaULU+DMvixNprakkRsWGV5B8HRiyiKJQ1mezGEsYJyTmJI/y29j
 Uj7RNIZu4ETw6selxP69aM71bOhf+cwDGQTqGo5Rhb3RNOMPiFaNX9Wre
 7L7l7D1H0XIimDvDU5IuMZnOj3vcF9sdur/9WvgXJNsbAPJveTQb6FMlv
 Ihm/GE5DhLWadbG0NY6Y4yztZ/ju9bnB7S16bYrcU5yhJONl+SWQs4a0D
 fjao4vVk4PNXKhJ9lPoUVhgwMivMzlgiX7qafHxUopmSvN1e4Nm8FTAfm A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="47553090"
X-IronPort-AV: E=Sophos;i="5.88,284,1635174000"; d="scan'208";a="47553090"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2022 15:51:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNxtENd5wyO+cwXpj8l5VfNLuNP6nKK/wh1zwWYG4Aig409bOSoE8YhYxaJZJB/Wac+Jrk9BlCRFS8xAIctXqsGgC9Ep5PY2ksz3SvYTIk/0EM7Bm6/8meKVICyJTGGMGkTmQ7rBTzgcUga5fe9MlCa8b0Tar94VHorCLj70t2kKRvHKF06wMDsyp1gPjH6S6oH5I0dWb49JY+utgFOgH5wNwDTbeDYnTd2mu/lRuO5nQVjt+MqiCpih3ZFfQ07hgo6kmJMbOiHKiNHXB9QjYrfSEPXGmKJE28cEgEtKxr9F7MxcxBRSnZozcwaf0D+o2DFbdG4sErVAZOwqburZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuibG9v43LMlh7Kj2At0qiTBwRPstcAF3mgq7Vd70Es=;
 b=KOkSFUyYQAdSznW6JLL6RNC8V23OB2MbqX7oWF1Qx3h6koA03D/MJD6QwJ1A+nzP4q+sPcANkSwEOoybJiItKwc+vJyTAMaBoMQIil4QJa/nb9ZhmL1VS8XUFxxRGA820MNVIcGY448ZVPv1mn2xsg1SIwxOSypZeUekBZvxCUM6n50Q2NmjqpIOaMzI3e7qsvXSQydx5PXiJMYQ563ZayEeJBLauKNwV3qEU0RwXkxakCGz8dthsZx03QWNd/tSMeYI4+kKr4Ug3fxnrP8v3AVh38fUH+Mi8DhahFU3pzJtunYHDPRIRIjEe/8gEfFH9muowk+VxkMN1oayZNhgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuibG9v43LMlh7Kj2At0qiTBwRPstcAF3mgq7Vd70Es=;
 b=AkXx6i+GdOk/reF1bvKIWZRf/109RdJUSkMYuLZ7AIK4M6I4CHB4B6NgoWrYFswXEKZBDB4MVTSiShYZsaOsABiTvL7y86qugZrCqzNUpHP4CszAGfdHrWfIzsL2XftQeUj+7M69QVh6rEghiy9e8SAKXm5im/uzlIIVaDvcbPY=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB3326.jpnprd01.prod.outlook.com (2603:1096:404:cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 06:51:37 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%4]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 06:51:37 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH v6 1/3] syscalls/quotactl09: Test error when quota info
 hidden in filesystem
Thread-Index: AQHYB4i4ZbpdnLiKGk6ngv/U6/789qxfG9mAgAAHqQCAAWGwAA==
Date: Thu, 13 Jan 2022 06:51:37 +0000
Message-ID: <61DFCC2E.9040808@fujitsu.com>
References: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <61DE9D0F.60008@fujitsu.com> <Yd6jfBkDVWnTYQCm@yuki>
In-Reply-To: <Yd6jfBkDVWnTYQCm@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33dd912d-0519-499b-32a4-08d9d6612548
x-ms-traffictypediagnostic: TYAPR01MB3326:EE_
x-microsoft-antispam-prvs: <TYAPR01MB332628CF26F7A3077581EBE3FD539@TYAPR01MB3326.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQwsHg4N/eMLlsBVPG88wOJeEV8vKc7tXa/HslMwb27HH6JjN1qHQwtHWgWXC1QhMeTyS3onXrJ/SL7UinrY8jU+aNFy9MwjxWlhPa6iFPUnOk6xvx++fZpg25tkaxtPrVGCQspIUwhvyzxWam5HpAFb+0SYaZGnJDyinGhiiyaSBg0l/ZrVE1TBgwZ32zhj0dCNNsZbgQ45lUrMMY+bXYENPn9SxdOblEQqhO4dzcPCea6N4cmWdvmC6Hd+PCYCRn60ywHrtIP/rDmGvVlrXpvxjZNxiulsidA8d6JD4nWG/ikbpWApyT5YXHEjnnQxjTFeMQSZYtA5d7TbYVm+DZI7M+UFLK2SPnE/KDU7YaCJCYVjKpckjhsx87EWDHTgzySpmqm80nFaOom1cwy1kVSOTv2M7yd0IZC2QDnOg3PY52Y3pCm1vxDfoCfYMdzTDrp64v1EwM+QVJSJVl01FlwOA9pmVzt8iTNX53utgdhCsa8L/xwDvoapin6/AiOdFikSMHDJvxZ+Vh4Udgj2P5dkHLt0d4I338hfKqU55JhZoKj3ZTBL/JDUxVHmuIcY9ACKCqCL/ZNL/X3iggxKIPy3Ex8HJXCzSvshD6dTpfSH8JP3WWVktem5AzIbgOIU9Lprpnjh5fIdIq2eNjcZ64FvUsdFSZKO+Ti+zpeK3p0ghrf7oOoBdWta0LQApa/SSIPrzooMZ1+cEQvPkTHWow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(2906002)(15650500001)(66476007)(36756003)(66946007)(91956017)(66446008)(76116006)(66556008)(64756008)(8676002)(33656002)(558084003)(508600001)(83380400001)(82960400001)(6506007)(38070700005)(122000001)(71200400001)(38100700002)(8936002)(86362001)(6512007)(316002)(6486002)(186003)(85182001)(2616005)(87266011)(6916009)(26005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QWZGaGt6Vkx6TnhjanVwTUxsbnlrbE9UdWRJMngxT3lwRFM5ZnlDdTIyUWJ4?=
 =?gb2312?B?M2FuRDlQa1gwWjRPNUVMTm5CakFmd3Y4NzdXV21aeFVrRTcvS2VOM1VOQTlD?=
 =?gb2312?B?K3Q5clJlcmZZMW14V2FPYkJtUVBaMDVMLzhudHRndmNoUW1GcFBXZ1BCbXh2?=
 =?gb2312?B?U3NYNUR0ZDRsSFhnZVJnRVdkcjNIV3RiY3FDZFYxUGdacE1Rcm8rWWE0a1RP?=
 =?gb2312?B?UHdlS0ZTdm5ITGE2dEhxeWJwQXVJNjcyMldLR0NXNkVqbkhBb05iLy9qSCs0?=
 =?gb2312?B?OGFrb1FrS0FqOXo1bUhveTdVS2tiQXJYRU1qSGwyNXM2b0V0eGhpZmtCV3hl?=
 =?gb2312?B?N0dhQTBVajNpSG9mckFNc1hiR0tjRlNsK09odGhTSHBXY0U0bGlrUWRCd1RJ?=
 =?gb2312?B?Y01DcHRld2ljUDVXQWVvUndjbm5ENlhzZE1JQU5uSnYvVWpFZG9PZ1RqbUtS?=
 =?gb2312?B?L05wRGU2dEJidzFWTGJZZHJuU2hCUVR2dmRhWHhkblhPSUE3YUtMVzh2a2dZ?=
 =?gb2312?B?QnRabkRPVTVLeGE3LzEzSUxoak1GTXdRVmE1UExibXhOV2ZYclVGVnJ1YUd1?=
 =?gb2312?B?VC82aHlxV0pzVlZpR0NlVmkrN0MwZkFjK211ZFpzczRhMEN0MytLa21JNEhz?=
 =?gb2312?B?RG84Mno0N2F2NXFEUEJ2Y2cvTzNpOWN0K1kzRE16aWpFOUtHMHBnamNBTXYy?=
 =?gb2312?B?Q1RtQmZzZjliNmxVTExSRXY0TXpNQ245RkYzSUlaOTdZNVkyc0owUW9CV1Z0?=
 =?gb2312?B?byt5L1BGekxQQ2VRMDA5ZGN1dmlsbWQ4ZTdLSHAwaDVCaTJ2c0hsd0FkaHFW?=
 =?gb2312?B?Sk5xeG9UM09oMnVtQ0FaRC9tcUJkWVV5VkZOTUNxTHdjc1RJWG1nWlhQN1ly?=
 =?gb2312?B?L0JBRDhoMVZhZmdwWkNWU1lPSko4dkp1SHZoOEVTNVZLUmtYNzB0TVZPcEZX?=
 =?gb2312?B?YkFySEdwYnJZdlM1enFraXI0dnNUNC84QmRhY0VLVzdTcm9XWHJ4K2FSS3FS?=
 =?gb2312?B?NUh6MTZ1QW5TZVZ5YmpBRmY4S2VTNGJNRm1rSUpsMjhPRVJOTlRBNDNvcDM5?=
 =?gb2312?B?SnVLV0N1ejhTQjFKb0loQVlSQXV4MUxhaXIzQ2dxOU82WUZ3RWFpcFZlU1NZ?=
 =?gb2312?B?emMzemRJbXhqTEkrOUZ5dE1JR21Mb3Y3M1N0MGFpbkNMYUtLNWgyZFlqbnZJ?=
 =?gb2312?B?RWUyWmEyMjk5a2tMUGlydUoyUUlUMlpFVXJLL2tYQ21VM0tSNEtOdk5DUmM2?=
 =?gb2312?B?LzFjSk9mMFQ3bkJXd3pQd3RndEIvRENEY2VHTlRqVDRERHlEdDd3bDJmYU5J?=
 =?gb2312?B?b2hMRG44T3JCalJ2SnY2SU1McmhzU3NnYUhnZjM5OEs1ekhXT3BCckNOZFd0?=
 =?gb2312?B?dS9Ba2ozUnhZS21ZUGh6ZytuYndJSm9IYlRRdjNZN1JVT1VuL0l6VjJWT3Jz?=
 =?gb2312?B?MVhsK3pIa1F1SEFaZVVsQUIxMHoyMkxiWXo2WHJaZytLaGE2WHd6cUdLODVW?=
 =?gb2312?B?dkhVTlRVUEhNTFNFaDNkMkhGRTRBSmthYVc3ZzlTbGtSRlphVzcyYmNrN3V1?=
 =?gb2312?B?UGJyWFdtVVZqNVA5ZTBERXgzbnpSZEs3bzhEbnpDdnJhTXBEem45d2VUSXFO?=
 =?gb2312?B?Y2FJd05LUzlCcFF4bk44Y2w2bHhPaUtxYmJnQmVhR0RnK1NJcjVlRWtxb1dl?=
 =?gb2312?B?WjdFRVRaKzQwaktIbzRCdE1SQVpqRk41S29TOXBJUjdqcjFlVGZ4UWc1djU5?=
 =?gb2312?B?ZW1nbHdGWjZlV0dTMStFUll2UGZoWUNkQWt2MGFlTVh3UU90MXBkQkZSYU5S?=
 =?gb2312?B?d0VTTXlLNEVlWmVMZXNScm11Rnk4T0NMbFhiUmxOUHl2bVBhMFFOMHZmdjkv?=
 =?gb2312?B?MFlFQzcxZVh5dk9RdzVxMXNlbzh0NCtLSmJCeUJtM1N3Sm85dUpVT253VWJs?=
 =?gb2312?B?YjFNTGtwazdkc29uM0xicmFCTU9ydEV1WVloQm85NHJKbWpSd2VuK05rQnZM?=
 =?gb2312?B?TGtSYmJyMUhOZUkwNGlSZlhhbTQ3L25JNXlyUEl6QWtOR3haempyVDJNK0oy?=
 =?gb2312?B?VXJHT1dHeTF0N3FZUUpxVW1PdVF2Ynpac1Y1OENrSDBDeUk4MVozL3l6aUpB?=
 =?gb2312?B?RDkvZnJzVUVZUXU3SkZZZlRqbDYrenlTdzdoSW1VYzBHbVpMRUM4QVBiUGFM?=
 =?gb2312?B?aExEUzVjZUhoR3FxWmIycFdSbXd2eTNBZERqUEppQmFJTW1rVXRSYkVrdVQ4?=
 =?gb2312?Q?MA9hmiOGNdalsZrK3Xy6RPjEeGqT6Utg6YUVobaJYg=3D?=
Content-ID: <4D75B62DB89DE24D9A0CE547323C6BFD@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dd912d-0519-499b-32a4-08d9d6612548
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 06:51:37.4827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9UPiYIulNYiCCQPHdVLV/2j3evM/RsN6WSPczNH4XbTnfo5t6Khdka8yl1pomurueIq+aSrh0wxZVSmgF8GSPdKwZjFrGZXbP6/FYYFOD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3326
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril
> Hi!
>> How about this patch after this change?
>
> Looks reasonable.
So do you have some comments for other two quotactl patches? or add RVB tag?

ps: I want to make them merged in ltp before this release.

Best Regargds
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
