Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC29FC4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 02:35:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD58E3CF2EE
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 03:35:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EB213CE988
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 03:35:02 +0100 (CET)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DC9361400422
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 03:34:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1698978900; x=1730514900;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=02hvT7Bf02kVjX1dzADS6d6EuKOhWS22N3pfhlA2ndc=;
 b=FTFJIXXhZb51a/uuEcKDF+foecaN93Gwb6s4doq2l7O+Ft5STKN/WOfe
 IpgvLk9hLlkxSPFc0SkkQUvojbKRDwRmahtrE2lvTUn4nCjcZYT8acTX+
 9uGRLGyP7t0KjISjNuBtNeZxJXUI0Jhq9/PZ2eli6eyD0s7F/CRpjae4F
 ruG4mDiELmelmb7cfiI4+Zs6SHH4vQXBoI/9fIe7hEHrRsWFVq2yUY6Ew
 2H4xaBJOGYUmzcFdvaQBt5TCetv+4phcCzHlGzkuQLxpSiSzuH1MWt0g4
 WpIgLzWzzNgocfO/fAraP5daVOuE8yDiPUqtoJnGWwitNy15UNirdh4P3 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="101685538"
X-IronPort-AV: E=Sophos;i="6.03,272,1694703600"; 
 d="scan'208,217";a="101685538"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2023 11:34:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TThE/XYXTDO+4+mKUQWDZNJknS4+xjIdv5fKp7gpccD/DHTEuGOeiL4M+DKULMykRUOlEn5Sqtf0ACuwUBl6arEo5ZPYWEkcrMoC+exhv4fjlhtWEqw/VIt6A/ZnIsm9b+zXKSpI38l112W9olV5nunY8tu7Jc4xAVy0MIkOnvy+tAhElyWoQi/64WU2ZdINDJ2xY8DhP5+a7YMYqzADuZ6i4htZWx7lJ8kkSAjnxek29Rhc4kU3dzxkj+m5Nq/36Mfc0kHM7EQszF0JYMZJegzpKEF/KmGXA/ZathXuhn1mj2kttMUtP5lAGuHERHukvzS+OXcr6NZ1NO9nAL9qZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02hvT7Bf02kVjX1dzADS6d6EuKOhWS22N3pfhlA2ndc=;
 b=DA8vRnTX9B4/zaw2CZNvMJD1o10vw7tlxqTvmOPwADhh9fOHEzcLBh69XJHS/TPzh0hXpv2E4y+vg5luJvykTMO/SLDgVEZ1jWnUXPfwBBJcCx3ag8Mlq/T0XKEQChpdWwvdWm9gJNmj721bJBIZEwxj4jhBDvQGGcsLB4IYwYhDl8Fd0471/3gjj1XKjOpKgDz4oWiBncG7UwojjR7S7wa9wjPGmDBRqPGTEfuk2lFaAgoDDoMcFxTuwA39e7tWQER3/xKMx8ZvTIaX1K7JgOP2jUp1tlxKnsKf7ohxuRiLxpORtWojupRESUjXPSUZjDgz9dZLc7Y0toJRY5mOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by OS7PR01MB11485.jpnprd01.prod.outlook.com (2603:1096:604:240::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 02:34:53 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::112e:4422:96a6:9fb2]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::112e:4422:96a6:9fb2%7]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 02:34:53 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v2 1/2] syscalls/fchmodat01: Convert to new API
Thread-Index: AQHaAjfPH3m7ROZsrE2i7pCXCrEXSbBQcZCAgBeGWfE=
Date: Fri, 3 Nov 2023 02:34:52 +0000
Message-ID: <OS7PR01MB11839901569EEBC01B8704EA0FDA5A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <1697684152-29747-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2czTb6KvzC7_M8_O-BEsPtbrU7hM-yuW1dZWdpJUJLPng@mail.gmail.com>
In-Reply-To: <CAEemH2czTb6KvzC7_M8_O-BEsPtbrU7hM-yuW1dZWdpJUJLPng@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-03T02:34:50.557Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|OS7PR01MB11485:EE_
x-ms-office365-filtering-correlation-id: 7416e235-ab03-4797-c68d-08dbdc1575a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5xclZZAVe2yzhSw1s2RMRqk1Bts5cctJegSD6fwwESa5J0xBu5W+W39GXyY6DL7qQwWMeRlYlq1PyWA5Cc3F4xfSS505VHBlnZ8h64JdrK59HVGwctfirTB0JFAOleR+XeKRkJQ6A7XnBNNOVC9VPuE7kSoj6aL5f4Rzj7Yy06S9xvU1huW79m/iWrVaPGmyOkYE2LIl2eqB9xnbrnagkFYau9Vz9/OHnBbWB64MMaj4P/GeMe/hDoIn+tunsgfGsKfPnS85VQ47/ETkSi9sCcmcNnLCHwcLDdZJAHM/s5KHiVrCgahJzLlyUZaavXl3C5tZkRw2VKkIzShsas9Emp2ZDiKuH+oHUE2yDwQrKiEuwxPBQNq48UPIhKp0ypA0p69Jb4rDz6RVbpAtjlTZEVbYvJueIT8LSsdhG4s9hkQwvyr6Bq0hQLJfzzS55utYw9qNxstNolKsB496sQKxOkS2TZMSIuQaPZJLiI4y0UV5pFp3Eaeorp/ocp8wUWknVce4TIK2OLelLWdjMoWnoa+YNx+S6vJapyuSh3vtaXwNYk5rET22YCpfMp3e79NNUjakOCFZsVFbLFf6Pg9oqPqsB2AS6ZdOdkqRXFBDZQMCFXrcDzuu9JAnwVTEv3v/S7RDA5RSv+JTIJ+Fyq3ByA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(1590799021)(1800799009)(186009)(64100799003)(6916009)(316002)(86362001)(66476007)(38070700009)(2906002)(1580799018)(64756008)(26005)(76116006)(66556008)(66946007)(9686003)(91956017)(52536014)(85182001)(41300700001)(478600001)(7696005)(122000001)(19627405001)(38100700002)(66446008)(6506007)(8936002)(71200400001)(55016003)(4326008)(33656002)(82960400001)(224303003)(558084003)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q1ZyS0NMZ0hSa2I0TTVXNjBFV1BwS1R1cTQ1Q2ZLcHgvUWRSMWR3eDlod1RD?=
 =?gb2312?B?Tm1wQnlQck9EYjZlaFZuZUpyK2lEazhUT0JOai8xU1RLZGNtVGZYOEhwaUpn?=
 =?gb2312?B?Z3U0azV4elY5RVJrN25QY09McVZabVVTSjdsY0Q5SkVIckdudGs5bHE1ZEFG?=
 =?gb2312?B?RytGT2ducDVDblFnTkFqZFBrMzVPY2pSaHhuZHdlUXI5UXVvT2hpVG5PVVFp?=
 =?gb2312?B?bDFLT0xVV2lFSXdNVU9WZzVFVDQ3dWEzeVJPbm5YUWdRYUd0TUtDYk13Yjgv?=
 =?gb2312?B?UXRyc2tLSHlNSWxpNlJnNjVLU1JUSlkySFRaT3ltZDluc2ROMDhZWG94cUVH?=
 =?gb2312?B?NjNqcFJXam5IbmkrSWlHL0lBcU9RblgvNWRFOG83UlFBd3lCSEJyRktNWXJx?=
 =?gb2312?B?SXBhYy9VdHVuTEcvOG1WU1RZemtpbHlzWkM1Q2hZL200bC9RWms4N29iZUtp?=
 =?gb2312?B?eFpwcXEyRlIrRVBNVnZWTDBiNW56YzNRaFNiYndGUkdYRWFRS1lGdGl3bkJC?=
 =?gb2312?B?RWVJWXFhVzlJVmFuSE1obEpITTV3bmh0U2tNY3VIdHhkZjRTWm9UZ3VCUXVQ?=
 =?gb2312?B?WUFZTkE5SlhGZ0FKVytZd1JyVk5JcVBJT1kxTzQvaEJwMTAwck9XaE5hT2ZP?=
 =?gb2312?B?Q1BnZmtwL2M4N1JPeFIyUzJTbXhiK2xXemxRUEN2bTdqR1hzOWJOaklFNW83?=
 =?gb2312?B?TENrK3lzTTZ6d3dXMlhZNFhYU0hOYWxPRTFxOWE2OEFOeGRTV2hCOWxrQjVj?=
 =?gb2312?B?ajhrdTZyek1jUUd4dkxTNkY1RVhkSzJQZVFmRVppVGF6QmVJN2hETGs1UjVM?=
 =?gb2312?B?UStYVXJ0UkZsL0R2OGhiVTV0M2lQOHdHU1ZNMGk1anpFVHBnS2xnSUdWQjQ1?=
 =?gb2312?B?a3ZJMlZJQWNQYnVTWFRLL2hTcnJOUGJKYVY5Z3kxNjBtM3d3YVFiNmwvWUVh?=
 =?gb2312?B?dkkyMlpLeWRHU2h0WkF6UWU4a2QxalRPZmZ6M2I2d3dUem9rOEFWRUREbFZE?=
 =?gb2312?B?STNYdG1kZG80eE0xYjRkOTAvenN1alRYUHJWOUlnWkhCQjFuUlRnV09qWENQ?=
 =?gb2312?B?SjRHQkZEWUR4dzZpcktWTzFiL3BtOGNGUStGSXVITDZXMDhMczRkQUdZSnFL?=
 =?gb2312?B?aWZSZ3laTmNwaXFvQUk4b1F6anFlK3g2VlYzdTJMejd1by9haEJaVEhkY0dh?=
 =?gb2312?B?V0FoMmI4VjRVMGNoNW9KcGhNaXd2aCttenJjc3dOUUJ2RVdTU0cyZjN6Z1VV?=
 =?gb2312?B?eG4zd0tYZGh1azg4ZURPcEwzNWFwTUlvV3pvQXJ6Mmc5cSsyUjgxQnVsbWVV?=
 =?gb2312?B?UW9CWkNsZ1FOSEpMalJOVUVnU0lvRzFZYy9NTE1zOUdubmZRd200K2s4VE4y?=
 =?gb2312?B?cW9BeDJjZUhtZzNycEsyVk1Qc2hHd0ErUDBQZ0NZYXdUcGkzS1ROVzNCV1Bk?=
 =?gb2312?B?aGxVTjd1MUVjVUJERG5HaVZsSmc4VG83TlBKRnJpRHY4dXIvVWFpV2lXNmNz?=
 =?gb2312?B?Z0tVS1V6NEFWc0JNOEk0VzRiTGVhTWwrOU5LdXh3UlVBUWZ6MStCZ0UrMDlq?=
 =?gb2312?B?UXl1d1V3dzlCaTFJVHV5cHhueHlQN1l4WXdnK0trVDVSYm5KdWNtYzlPT25L?=
 =?gb2312?B?U0k1RWlXL1dkZDA1c0lMcWJPdHpJWkJxa1FSRXJMUlRQMlRKQ2p6MzFUK2Uz?=
 =?gb2312?B?RWw1VG5rWm82K2Q3VFN2MHp0c0tnamFTSE5FbXdiVktYMFh2eFZmVkQzSkdo?=
 =?gb2312?B?YmhwVVc4T3FMd0tMSHBmVmtuMkpsRnRWMm9TUTJRTm9iZzhFeTcrVWJWcFk3?=
 =?gb2312?B?STVLNTd2c21nZ1VZN1FPU1pzSjFLUVFjVkRmcjFJLzdxcFdDeEN3WnJ5ZDJ1?=
 =?gb2312?B?M3pVb1RHRU9QbnBDNXNyeWx6VXp6U1RJaTF4MHR1Z1RqNFROTGhPU1J6WEhR?=
 =?gb2312?B?RkNTMDhVVjVJdzM0dC9uR0xlY1cvWTh6aTY3K1dYOFB5N1pyN0tOMG1SVlFi?=
 =?gb2312?B?RVFPOUtzQ1g1dmw4NFJ5R0VqaHl5ZkdLVWl3a0tRT0Myb3ZHNTUrbHd3cDVu?=
 =?gb2312?B?QnRkR1lRQlpoeTFXSkJGcytuMHNNMHNMMGxyYnRnUUczU0R1dzdYOVJSSkdR?=
 =?gb2312?Q?S+kS7+sn8vrkTnL5o5lO+xyG+?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7BBQClzKmcouB4Nn6Kp1kazY6iXxQmQUbU6oUG367q8wea7f6AUuCmc499ZEPyXYuXtpgIgmrhs81PDV0nvTa5pdC6zHameGp+s/KRD3nmfyhfIUvE2HaFBbBp4dM7qwFt8BSWJdMK1Z3YkK+SBiq7rEeiEFzkp5FKoJgXLVnIuKJP5qGAWitLcQ76Nt+HRjiBVQQ8NcEv0DwJPR1q1+ge0FufYUppGpxiTo5ofj5akii/+dsOqfkXzae16kYYglEQGHFVwraPu68pacACiTUHhsfBIrT830TdFg+lMC/5/K3LSN+6BgEudqsodza7I5VU5PIwaB4VHizjDVY/xmKkMt1UQ/nNrqM1y5sFcX0B0e7p3FS8/oBOoA2EJe1OWxUqlQjS73J+p2TYlb8cOQHzSnbuiCIuFvYVNoDgvBfzi0XJCq1ZrA1cC9b75sxC+/7ueS3nkxgZNTaLnwCR2h3w8HZ0IHUA70uEkY4SHkDo4UB47+GZLRuc/NISMjFjJYra5gskb6xTwbYwNigIgDP2vyVE/2LK2kkZ9yJ7DST3PWbojW+pqLb28PtmXEETsolha+mGWK8bTdEAFdTU1OI6xsA/Jp4db7HHRaq9Gn7LCmShverHdxaWXSu01PoThD7aeVi1XggnbPYf1xOnlgGE8oERI3LRTj2gq3jDTzSmt4zx3whYrrxLJa01901sabiwsuDh9e552CIfL9DvUpTVMi1WhWTVqJvH+cJzPoGq9lO9LkgReoxHAZOgYSXxoAb0quWz2UAXedBF1HMrL3ge6nMdTBsQzLrn61FROrqzE=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7416e235-ab03-4797-c68d-08dbdc1575a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 02:34:52.8842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SqDKIWVyde0KMYJRUBqaJ9FShNniBUCGT8MpbGr0pVZE/8LuRJdUwfb944r9d2uxJwqLXreOpRky8n56JiGB4MAOgqMESxz/3BCiH89jUAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11485
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] =?gb2312?b?u9i4tDogIFtQQVRDSCB2MiAxLzJdIHN5c2NhbGxzL2Zj?=
 =?gb2312?b?aG1vZGF0MDE6IENvbnZlcnQgdG8gbmV3IEFQSQ==?=
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

Hi Li,

Thanks for your review, merged!

Best Regards
Yang Xu


>Reviewed-by: Li Wang <liwang@redhat.com<mailto:liwang@redhat.com>>

>--
>Regards,
>Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
