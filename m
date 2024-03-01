Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D72C5478C
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 06:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709275561; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=DIpD/tsrFJSQfUJuMSsvbAl3rijzAZjDrADbeUsWMjk=;
 b=aFvXkFz5zXSqdNTRAKmCD8D+3C1MKAwV1lJr2cGKf2dTQEpvfXW7COS3xtfabzIgPBvQX
 SfahGR3N0GDdvaa8GaaOVzjS9g+YBE0Tgoqs5PDw6avcWUURnuvAmLbRAGWBRIfl4yAQgyx
 7m6m1w7tA4Tbf2kH3R9oWtnFQsWJvLI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC7293CED10
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 07:46:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BFBF3C99D4
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 07:45:39 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.159.76;
 helo=esa5.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E1F471401230
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 07:45:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1709275538; x=1740811538;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=Tr0Vx+5hoiYcBEy+th/xtxeDTPMY2U2sTCWc2m/fmKc=;
 b=gUXj2zj+8uiCvamIHxsoICCxxzzsFnL5E+XLL4/6y/TnfuK/fWJYhrqm
 ETUaY9xyEh9KptZxfV1LBwsC7YkNGrNS61GeCn8Vt92HW1DvrHL4GFsgg
 boX6ndvpcWlZ254BS9G36Lc7Qn+pyH+k9QXsZ/FNx08OS+v+IMTugkIyb
 KGYBWPaiLT+0BAu2LnJeu9y3COIn63OQQ8bEs6ne4a+NYmq99Mc8DSU+B
 KDg0PK+T+6UwTLNWcYCnjIHyHHAuIPCR2GDUAsrYyzsDryiqOD7u08Xwj
 rMjTybhx3k03lQeD6dZaY2e3LfM1tYpL+V7xpLFKxOFX5KLHBEzy/RYHA Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="113027979"
X-IronPort-AV: E=Sophos;i="6.06,195,1705330800"; d="scan'208";a="113027979"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2024 15:45:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnXcrvSpQWa2tKfIxSFRYZ0R3yzHtSCW7WpPJcjtSqUetLkAng88tjCjNX3uSvaUIhdCaaETKUTl0dX8UUNW2PF0qEPRPCYeALmkO+FjXuXvMbT/8N9j6AZYdlmLUmWOQiPiZFX65+uIeHHDtxAobn18oceEFcJrXVAJz1cmaPrLoEGQAZu6wFQPCq2CxXLefW0UWkjRcT76JNQu6ZyVZi4U/FmFyAhQpQCJNM5Y7eWg8vtSl9uXlE0XiYWRJLfsBgaUYO74DxOnJEMM2ICFd15VH8qOS/IfgtsBsCwhQvBGG9KYs6Ge91Z7VitNB9q3QyHeO0h184waziS78b5+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tr0Vx+5hoiYcBEy+th/xtxeDTPMY2U2sTCWc2m/fmKc=;
 b=RU55GnECyO9tqRZ1KACwXymm91wldGI5LKNS/wze1wm9RW+cueSfa5GHxWgnAI0T6XXFaNfDr32Mp/0a1OSruOwit8LK6AB29ARzbG2G3gYEs3q5n8B9I+XfOwR0JrvTFwrOlZvKF3H+lO3D6zdjz2KFr0IX6991o6kVSJHe28lfX36OyV3RxSaidOa/KqvqVbQ4d7LlJnRRniNcVDHTeJ8QowhOX9BaB/GPhHMXxd8pd6JFauzAq/YFoceW30wHW6ilB2WOKboa0J/QJWNKn/IBLuxjiNDUAWU2bdeYnpkO7DCFmN7Ql36BLFnCx6LKIAWujSKlWFxJ60zKDpIhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (2603:1096:403:2::22)
 by TYWPR01MB11733.jpnprd01.prod.outlook.com (2603:1096:400:3fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 06:45:30 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::4e0f:c728:1baa:591e]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::4e0f:c728:1baa:591e%3]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 06:45:30 +0000
To: Wei Gao <wegao@suse.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v1] libswap.c: Improve caculate swap dev number
Thread-Index: AQHaa6GinuAWcWsixU2vBtGOEeZdZbEicNQA
Date: Fri, 1 Mar 2024 06:45:30 +0000
Message-ID: <5681819a-2a3a-4c47-a1f1-3f9f49c994d9@fujitsu.com>
References: <20240301062716.3023-1-wegao@suse.com>
In-Reply-To: <20240301062716.3023-1-wegao@suse.com>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1578:EE_|TYWPR01MB11733:EE_
x-ms-office365-filtering-correlation-id: 54d86653-9978-490e-6f85-08dc39bb2fba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r8/OfsltBte9eN8QjAqoBcbBOQS9Y7OcB6if82v+slgllpEsZMp6mBgQpr6MTHiM5Z0MW8S0bLflHtGdjWl625XkSien6qzLZzO69wWzEpwltMYi9t08Xi7wph9D6BTO0UomxUDsstT0W13d2DTkaY3nj+H40WXhVD2sJVkQcRtcl8lLaLRaj9+FMMJr6HH4Cgf13cSMjLJsEVIoblr/MMtsSuqSx3qb36OxMs5DCMvyNraFm1DKAJMZxYntp5lpovy3Qgc5T4GfGHc6LchIJhDzfeKZQMTMPFCsM+LTn5taYp4XL/qzfQEQhwdDruCzgAr8T+Gm7Jhmg78NnyO5zTSOGajhE9zihtsep6zel+Fmoq7EjSjEAArmkgYQl94GiNSLOdZf6Z3Hh4mUlGmNGnNW1Cz2gTC0yH9ednVGSUHxX0PoiPML66h7AlBAcid4sTbkIqpkd2AU77/Wh/5OYmpxbP1wP6cOjnSeJ3I7SV37iE7kNdrK8eay5098rKsXhsUpWjVgamoxgRfocqEBmlZ+V9ndh0U5SlbBUm+KlXytx5BS1/4YAWyL8uaBDiLiLjkxCc6vABjTbYLmYxIuKZ5rfCJvdpTvYEF+F0Gy2wBnK3Sv9oGd6GM1YEfCDSkBYwBnSLdHa6d8a/2pmfdfR+IzdVcqTMjE6gNtPtUriKcl/CJ6U8La+ZAbw0ZiTQG+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1578.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1580799018)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTB4bk5tY3FmMWlzcVllMEN3ZC95cmRvR1kvZzAwdlUvY0p5ZW9tWGRlQXp0?=
 =?utf-8?B?SWwwcjk4a2ZHa0Y5bHZnczdYRWJYbk05aHVxWTVMQUJrNDZFcVprQUZDVTVq?=
 =?utf-8?B?YUhEMDZNM21teHkxdGZuR3ZDUHRaeXc5VG11MlI2cVRjQkpzSHlOZE92bi85?=
 =?utf-8?B?NkE2cC8yLzQ1bHU1MjZSaFNxdmlQYThHL3o2dE9ielFHaUhOWTRVU0dZb0d2?=
 =?utf-8?B?a1dxVTd5QTdxcnluYUJCL09BQzJvWWFIWExlZmd1RVFBeFVCcXB0NnA4akFi?=
 =?utf-8?B?allRTXAxZVdsZ0NYT0ZyS3NZY2loSTkybjhjSzhQaFNGRW5RdUNxY0xNQVI3?=
 =?utf-8?B?N2xmRkhMWWxtMFlNSkF6V3hmVUV6TkxPNjkrb2RJVkRzL2EralFvWFMxMG9x?=
 =?utf-8?B?WHovckN0UGJ4S2g1ZTQwMHN0TFZINHlZSFgwY1pVMFllS0laUWZzL3NVWFZE?=
 =?utf-8?B?ek9FVTNSVks3T2x0R1l0S3EyTEFzWG1xeGpMWURxVXB0Qk0vRFcrR2ZBTVRL?=
 =?utf-8?B?ZTMrdWRMQ29DY2xSckpENVRsRUZHVHN4Z2RkWUttRkZhZWxPRklJbkNHU0FV?=
 =?utf-8?B?RnFOVHJKSktOa1ZqZXN6WnhDd3N2ZmI1TGFybWJGY0svT1B1cHZxZWRGL0s2?=
 =?utf-8?B?bEtiS21sT0s4UjRwUUI5aTlKY28vYVhZVWQyS2dYT3hZYU1zR3MrZ2QraG1S?=
 =?utf-8?B?V05sR1FGNGFWS0RJRldaMy9vaVdVb1pnS2lvQ0Rlai8zcGFZR0IwVkN0V3hm?=
 =?utf-8?B?UGIyTWErdCtDVSs4bVpGbWY1MVZSbTVDZElobjVyWmM1ZTRHNWcyaGVtNzIx?=
 =?utf-8?B?dmpwUTZOaVlpNDhRU0VWTS9PT2NLM0NORDRmelJPTm9QVkJtNUhwYWFLbUh3?=
 =?utf-8?B?cUIvdVQyZ0t0YzBzbFFraEVNZDlwNWhsZmtacy9JNysyQXUyZDVGTEtFZlRn?=
 =?utf-8?B?cnRFTGJZeVJSeFpBeHlGL3ZrZnRNejB3MjNJZ3N0czBsNzcxZmN5QWZ6TEIz?=
 =?utf-8?B?QzFRTFVDK2s5OVByTXZDdFIxM3ByQ0NnalpBMHJTQjJ6NmFwRjVJaUNMMGg2?=
 =?utf-8?B?T2k0RlgxWHJxK1dKMkVkbnRJSjZibmZTMk03MmVxZzZXRHBCNWxvQXNoWnhR?=
 =?utf-8?B?ZmRSbTNUazVGcTJhZ3JXQVQ1dkZuYnY2VGIzU1FGSTI2M1RXbFRkZktvdEdw?=
 =?utf-8?B?R04yVUw4ZEtxaFJCNkhhdmFMeVZ5aW1jREhRQjl5cjBuU2NIM3hQWlRkYTJo?=
 =?utf-8?B?WE9OYm5CS0xYZ3NlMngvMjZ0VFZOeVBvOUhJT0NnQ1h3MXJaS3ZOQ3IvKzBB?=
 =?utf-8?B?TnhSUlp4SURBRTFjY2RaSENmODhqTXpUc0tWa1lsc1ZRdXg3Nk1nbVJDK3dX?=
 =?utf-8?B?MVpjVXVORDliSzZaOGNhdFBOaFVNSDlWOFBESEJvUzRjN21JSXlkbTU4UHlh?=
 =?utf-8?B?SG9rL1dwTExBRlp0aWNMUWJhU2o0Z0hGMlVFeXBqTGVGeWVwbERLL3U5T0xk?=
 =?utf-8?B?RTNvVy9pcVZIVGgzTUZrdWk5Vm0ybDhvUENmK0kyYUpxZ2JvUHJTWitobmFH?=
 =?utf-8?B?Y2ZOSURUU0lsRG1LYlU3dm1hREhqNXM4bElQTUZsZTBHSnBvY3BJVUwzazFL?=
 =?utf-8?B?dVp3YTZzOVZLMExPR2E3TmdtejZCYjI2ZGc5KzVrRUw0WkJQRnBkK3hmUFd4?=
 =?utf-8?B?KzQ0dC9KZk41M0E4Mi9yN1lNc3Z1aHkzcjJwSFFsTHBXTnUwMnFmb3pWUHFz?=
 =?utf-8?B?dlU4cDBSdVVHYW1UZUtuYjUxa0lZb05OSFp5aWJiVkxLQjMvc0UxYWx6SHZT?=
 =?utf-8?B?QldIUDkrWjNodGg1Ui81VTZWSHJpTktUMnJZM1JZL1hEVlZNdHJWNVRhMFF4?=
 =?utf-8?B?U0h1bjJPRHBnR0N2akxNM20zTExDeGhic2c0NDRsd29NQ01Rc1h4S3F6M2c5?=
 =?utf-8?B?MVZSUGdGRmFQSmxRTW83a1VrRzJRS0VSSndWVFBId05aYzN2T3A5dDhmdlh0?=
 =?utf-8?B?cFRDVis1TU5iL3RUMWxrdlVDOHhNSEV4Y21tanpDbzZIOFhDS0JkNkw0bzNx?=
 =?utf-8?B?c3FwTHNGWnJRUWhnVEgwNll2S1JmOHdHeW9ta2pSZCtnWHB3cHRoVDdmZVlk?=
 =?utf-8?B?MnRwQlpkNGR5M01xQ1ZyRmo2ZTM0OUFhU0JHNXJFUThIcndnOWZKblpJS0sw?=
 =?utf-8?B?RHc9PQ==?=
Content-ID: <F2B93866D006A24ABAA85CE078F43F35@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8j2kqbAw2I7EOD3PgBmMlEnP+BTSBX0uWu/aA7gr897rHLX80UR3JpunP2PQcSGneEL2z6bHdpQb2Td0vTQB9jeLok0SE4nT52Gi0BO+igmfq59JFn29zNR6oEc5PZq3rmx8GJyd6rh648gjLmBWgLSMcqqVMhI1JeYvH7p97P5uLaUrNVquueu9+OcyR2VC0S44NrYocoUzOFDnQays63c8YbE80K8iTHIm72NKiK1/0coFfFKFO/751fOkRiEjYuptLVTZMRbNXfeRLdLFLyFUNBhOGzvY0Iue9U08n84UjYYU7QOBDS/bcXBBV4y4Pn/eRAP+8zkpcOpWFuJWD/L8vWD59E9rnsgkFWfbSRuoTVphehFX2rqfoUg/YBGkHgZvcrsoRSgzLEsfL203jamAy6lm8mZUdXIKyYSUHJfQgopJGSO2VIuduIY+3K9QV+GEZaSfCgWw08AFkC+iOh1sQRp1M+IZ0tqV17rA0TfdJ+9lL2ziX+kGJBvxc5xukLEDesodyYSaFGJ1fkYdM/TuROslBZBE990T+FH6KFhJ9OPrlXoxLdR/RiHmkGRzv0f2DbD0aPiqmknTU23FlJY3ktD1ySo/AjmZoqeyivF7UzbkPJfg3KDTqixpK4cI
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1578.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d86653-9978-490e-6f85-08dc39bb2fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 06:45:30.1543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3ZM3xSw/w0m+llltuzG69S0wNm04z4QCRaLFcmiUFBLyZTYmeUfg3JyjZWxDIXp+u6mkQNR5M6mnNDvLNsNTVh79uGSQHYLmnOr8zEuz1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11733
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] libswap.c: Improve caculate swap dev number
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
From: "Yang Xu \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Yang Xu \(Fujitsu\)" <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi  Wei

> I encounter a dead loop on following code in our test on ppc64 machine:
> while ((c = fgetc(fp)) != EOF)
> 
> I think "/proc/swaps" is not normal file and can not get EOF in some situation,
> so i use fgets a line and caculate swap dev number.
> 
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   libs/libltpswap/libswap.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> index c8cbb8ea1..6924066b7 100644
> --- a/libs/libltpswap/libswap.c
> +++ b/libs/libltpswap/libswap.c
> @@ -13,6 +13,7 @@
>   
>   #define TST_NO_DEFAULT_MAIN
>   #define DEFAULT_MAX_SWAPFILE 32
> +#define MAX_LINE_LEN 256
>   
>   #include "tst_test.h"
>   #include "libswap.h"
> @@ -274,16 +275,17 @@ int tst_max_swapfiles(void)
>   int tst_count_swaps(void)
>   {
>   	FILE *fp;
> -	int used = -1;
> -	char c;
> +	int used = 0;
>   
>   	fp = SAFE_FOPEN("/proc/swaps", "r");
>   	if (fp == NULL)
>   		return -1;
>   
> -	while ((c = fgetc(fp)) != EOF) {
> -		if (c == '\n')
> +	char line[MAX_LINE_LEN];
> +	while (fgets(line, MAX_LINE_LEN, fp) != NULL) {
> +		if (strstr(line, "/dev/") != NULL) {
>   			used++;
> +		}
>   	}

You are not the  first person to meet this deadloop problem, Petr also 
met this[1] in my v4 patch..

But I don't think it related to /proc/swapfiles, I doubot libc wrapper 
for fgetc problem on ppc64 machine.

Can you try fgetc problem by using fgetc api in ipc library[2]? Then we 
can  know the right reason whether is /proc/swaps or getc problem.

If so, I think we can change this as my v2 way[3].

[1]https://patchwork.ozlabs.org/project/ltp/patch/20240220074218.13487-3-xuyang2018.jy@fujitsu.com/

[2]https://github.com/linux-test-project/ltp/blob/master/libs/libltpnewipc/libnewipc.c#L58

[3]https://patchwork.ozlabs.org/project/ltp/patch/20231222050006.148845-2-xuyang2018.jy@fujitsu.com/

Best Regards
Yang Xu
>   
>   	SAFE_FCLOSE(fp);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
