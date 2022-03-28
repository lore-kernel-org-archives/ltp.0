Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F32C433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 05:30:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 110693C9875
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 07:30:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C144C3C14A1
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 07:30:28 +0200 (CEST)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B9F0560007C
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 07:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1648445427; x=1679981427;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rlSTBl5hPFJfx4wOLWzuDqPco4GZafpc2F04l+BFsYU=;
 b=yfLgUgwyXcElBfsjkT/Rz3IQjynnJ0G+W0h10RSn0aG78UaOXzQBrZ4z
 XJ8iUk3yYJ8EQiyj1for36E7EtjsdG9m6yDZDdAaW5M6p/qh4gnDG6Ii/
 2VEM/plssj36sEauNdAf6FQtX5/Mb8GLZVQD7x8aV3fFOXAqk67HTsiom
 3dhxIRA0ei7vFS38JOhp4tkErAfTVfGOzKrxtchdWPQ/wcjFtcapbdRIP
 eyF53G6sqVvhbBm151IwBxOyXMiBi637LpjL7A2hXQ/qtmqeo0QBheNAm
 hC1d7Y+/yLMzLMRrePYg3EQYsMTeQf+qDi1hPZl/U82hGGFJTEkQn/rxu w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="52307157"
X-IronPort-AV: E=Sophos;i="5.90,216,1643641200"; d="scan'208";a="52307157"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 14:30:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSnC6yXs0aT/ZsUQUVPRQNbxWO8lTrvZHNt47R+rGT9JylEchc7SLTfrRQtYHPZAtMPtwMnhgx9dihIfXE50lc3xco1/CJgpRq7m5ZSTm8CIbYdM1BKa7WJQNWo+B37IZ+IlwBXSnzmW4NqPd3tcloP+duXnGOOJdBwepC136u2qrUBEhlTXPanTghGJLHRAPKmKe3YzLthGjH8R5QOTrYEnJCcugJt12BI8jMBzBbL7+hTyE6jHY8qmHcgH02zvKgDuEkIEUKf5/qLHH7T8Fpj60vvlNFZQByDObzS5GWnk3LOxNBFuJw8AcKKe+uDm+/+tDGArxXeLpatCn/W7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlSTBl5hPFJfx4wOLWzuDqPco4GZafpc2F04l+BFsYU=;
 b=QpyO4IocbaGTneQ1WOl1Vza5pJyyEPSGsLpzUR7JTqDHisozooFCXtCSTlrwT8/b6mOcn/NC1sPdbOA+eLL9NXcNeK/V8sCeKMvgVpXKPvrhgTY8bFfj6P1zjiJ58Bu9QYV1PdfqzAVEbJ/ljx5HloXcT+PGROQJAv0EwdOuBKF3u2okFxEDnb21ZpFAgu+WcqHxE1lLGegXl/uFhzggMXJQroFrp8YTBjLyxCKdkdnZ6DRqeTPR+ujF/EdpApUHP+1xzb6huwC9opOOPmsV5zD6uynVDp5fjcbBsd5WNT0xwjIjj1Ljij5+E73TITf7ohw6e7dtd8AIkHkoA/7YmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlSTBl5hPFJfx4wOLWzuDqPco4GZafpc2F04l+BFsYU=;
 b=nT6Svv3rdSglW3KdjmUV51LXuErRpPXE5Dp1Xkg8+6QkBj7Mnpa5jGNMkg5y4MWlm22b6V6uINDUOg1rtpjR3ZGWedU39+401PguoCv0gDJZ7ZghxYDreGuerjAjGQgT2HdelIN7Q+9dMWisfwj3x6a0LItH9jhU6Y18EcEmyTM=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY1PR01MB1708.jpnprd01.prod.outlook.com (2603:1096:403:5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 05:30:21 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 05:30:21 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/umount2_02: remove useless TST_ERR
 assignment
Thread-Index: AQHYQCoHUv+ay45uFEiYJMbqSHxzpqzP4jgAgARnfYA=
Date: Mon, 28 Mar 2022 05:30:20 +0000
Message-ID: <62414819.2010802@fujitsu.com>
References: <1648243376-5306-1-git-send-email-daisl.fnst@fujitsu.com>
 <Yj2WSuxQ583m3uQG@pevik>
In-Reply-To: <Yj2WSuxQ583m3uQG@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e06d32eb-d313-449d-dd92-08da107c0d4a
x-ms-traffictypediagnostic: TY1PR01MB1708:EE_
x-microsoft-antispam-prvs: <TY1PR01MB17083A3110FE4E9B99B76E62FD1D9@TY1PR01MB1708.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mrXy9lOOJWiPGXLlCcvvgO3S0MCKjYTGuiS3KVBOFzMcJxH2Bu5jmjvvluwNAKUlzfyelUsLiTY7EbWGK8OdYdhg2fUbMzkFfzETlZjmTuSVe0bc0UX0AfhcajSklBh1C6W4Pz1VZaXIAKfNcfLfn0NwD4l6u1dLsriVf1ps9T3O5lt1Ql7ex5mKY3Se17Y3wylqfHXOQJHfcpMBAUYtMAKTkOKdEj6V/IyAzvJo0rgv6j5Fe66uUuc/FB08B9EaKVA6eL10MWnd0lZLIntreLr2P5rqmSthY6TQwJcV6Ur7fs+Lr6l35jYoPYr+ahP+fYvSz+lIN8tNDXL9IJ3mt8pJq6uXzTr1jwkVhc9GZLAkJI2j6NFUmThL2jr4jC8I7LSLPUpeSl1eDNfMJ9ZzR0LQ3tJ06K6sek73qLN7Bbpd4z7jS1XVwQJkbQ4UCoo8vZAMnxn5/utGbeUkvgI31cEwtsUQ/HhP5jkR7mB1zA53VyoSBwRQ3g8npXe+rLDk4AeyY+XtZpq7p7c5PAGfnI7QsbX/gs20U0Xo6vei6gGKbJjmPPVmNg3cKxxIaMLzIqhr9vjxhxn4SCO2N5aIy4csWoeE49ZBwYfZaKfslDRSXKwtWGBw475N6wY/sEwEabTZb5jSlPRyjdl93SW4FnIkG9S6dSTb6O92lA21W0R0nuLagLXspINePdbcUI0XFmHBibUBY7cPdbQT4WpZ1ZB2L6nQl2E1ItN5JHMHuZ0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(38100700002)(8676002)(76116006)(91956017)(66556008)(38070700005)(5660300002)(36756003)(86362001)(82960400001)(122000001)(4744005)(8936002)(66446008)(83380400001)(64756008)(66946007)(66476007)(2906002)(26005)(87266011)(2616005)(186003)(6512007)(6506007)(316002)(508600001)(6486002)(6916009)(71200400001)(54906003)(85182001)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OGNPZXZCSXFURnRmVHloT3kwekZCTmw4VWswUGhPZFRPblhuN1M1MmFYK3Zr?=
 =?gb2312?B?VktBZmlVOUc5LzIrQURaM3dUdmo5WFBKanhkOGE1Q1k2SkVRTHp1L2NkYzJo?=
 =?gb2312?B?RjNkaVRhUHMvYWhyelBpZ3VjcE1IdktieVZzLzNmcys3dWUyVndjMkZrOFUx?=
 =?gb2312?B?NngvV20rSFUxM1g4dGFPeEZ0MW5ERmI1UXY5ZkRnRDJuZmdFN0E3SnZUMTgv?=
 =?gb2312?B?VTZqdFdRM293ZHhmV2hPeWtHYWM4VnFPQm9WZlJRdkpBTnVQZFd0REt6aHZS?=
 =?gb2312?B?SFZSc2wwR2xtTkQrZGsrNkN1Z0ROc2tZZlNTQjBIaUQrUG1zNm1kUnpwc2Z0?=
 =?gb2312?B?VjFUUEJIVTBIM3lxNmlPYU1SS1hNdW1XNDdma2ZpRGd4bGdBWDArWnM1QURr?=
 =?gb2312?B?UjQwM21mS1RVNy9BUlJ1UUVTQ2o1TzhNS3AwNC9sQzIvTXNFT0o5WTk1TmQv?=
 =?gb2312?B?eU0wUS94YzBvV2xDcnY5YjZtbDQvSmdNN0ZKWjlTWUVkRWlQVFJsWEx1blZ5?=
 =?gb2312?B?RHVsemh1MXVPOUxEbGVxWTFmNkpHdCtoMjZrU2NLQ3hsbWhtanlEMFBoWVZn?=
 =?gb2312?B?a2tVYkxJYjFBeWpNdDlQdEJWRzg0NjN2ODg4anoxQ0dvUVkyV0VtZlVzMS83?=
 =?gb2312?B?bVczRDJVUjlmYjJFS0E3bXgzWlVkbVR6L2Q0ZlhtNVdXbmZURk1URFFoN0lY?=
 =?gb2312?B?RnJZTm5XeWNIVFZHbXpHdHI1dGdnZ2dITXFXTXNqY0JzbVRTMjRqU1dPNXhh?=
 =?gb2312?B?S0U1aFlsZGp6aERHS2U4SlpXQUNLbkJJK2hEejlNaFJxdlBkdnNobGxtelcv?=
 =?gb2312?B?Ym52Unc0QnYwKzZkcUYyUnVOZWlyODlMN1Z6RUJWaE9oNE4vVDZmL1M4bW0r?=
 =?gb2312?B?YzRETENtd0R6M1hNaW5BRE5ITmZBcm5hTUpscmg2WURvS0lJc1ZEUWtPSU5Y?=
 =?gb2312?B?b1lseU4xb3NuMnlHZ2hCTVM3bGlHN29tRm9BNlRsSHNLZlJTMmlqaHhHbkVW?=
 =?gb2312?B?d052ZnUrckZqR3orUTd0Z1Z5TEVWUkZuMkFpSXdIeGo5VjUrUFBPdlQ0TzRn?=
 =?gb2312?B?QUZBRklYM1dXTUtvam55KzNEUHgwcU9hdi81Wm5iQ2Rpb2o5REQ2K2grMTU0?=
 =?gb2312?B?N0drZEU0akZad0NabGZXTGZReFBjUlN6WWJ1aitDV3pnZVBLSkNETldlRjdK?=
 =?gb2312?B?RFoyUWZLdFdENnp5VGZ4SURkazMxQ1kzK1NwVnp1WElMSUNqeFBpR0Y2QmdR?=
 =?gb2312?B?d1dKWlJpemMyMWVLMjlsRmRpZnVSdVhkb3k5N3JHOTFOS0VHZTA0eFVIZGw2?=
 =?gb2312?B?QVVRWGkvb20ySVJQUG5MaFZGUjNiRlV6NXVaU21PZ0t0cHdOR3BYOEJycERP?=
 =?gb2312?B?ZWJ5R2pNMkNaRkZybjhzaVFCUFBidWF6ekJCa0ZkYVpzQ21CaXJBVWwzTTZQ?=
 =?gb2312?B?TnFtdi80L003cWNoaTNzZ3k0b3lzak14bDN4cWl5UHhqTmtBTUVxT0RNOVo5?=
 =?gb2312?B?TUJGalBMbXA1QzJTcnRhK0NuNFhlemJNNm1jZDBtTzRuUE51WjdzcVQ4dlIr?=
 =?gb2312?B?L3dZWGdaREUrNUpaaDlUMWdJZldhbklwWUFmTHFzWlVCZzlqNU9zWjAyTWJK?=
 =?gb2312?B?UkZlN0tJVENlNHZrWlVWOVVSOVozRzE0VkpVbmk2K0Fqc1RUUFk4WndLcFMr?=
 =?gb2312?B?YkhncUFTOGdhQ283UHJQT1VyOTk1QnRDLzRXQXlyY3AvNWhNbzZaZ0lucjRQ?=
 =?gb2312?B?dW1JamFiQ293ZUlKRVJ3UEV5WC9yaStna3F0M0tkTFhoUkJFUFFOVlhCMno2?=
 =?gb2312?B?VDFDRXZPN2FKTzZxRFdpcGNCdFZrSHZ4VEt0VVIxYnB5ZWtKbDAxWnMrVk5C?=
 =?gb2312?B?MUNFaG1FakRVUUpUanYzUXpscmRmYjBoUzVHbFdNK3pKNDdTTDhsT1FEOVpv?=
 =?gb2312?B?TFJ4WUFvZ0d4SzR6UUl4a0hJVzd6NkdnczkzamxSVk5XUHRCb0xTalZqa1Nx?=
 =?gb2312?B?YlpyTHpJN1lXRjFUZGVzUURWZ1pMcVVDdEZDSmJDbFNTZjJjS3FGZkQ5UFls?=
 =?gb2312?B?ZzdtQTgvTjFlN1VsaDZsVXlwSDNPeWdjM2RjWStHVk9GVlYxMWVBSjA5Tll4?=
 =?gb2312?B?OWt4SytZUXN6czd1ZHo1ZTg1UFJrRjhsSVh3RHBNR2VIYVB5WVhJTzBKdEhk?=
 =?gb2312?B?UFkxOVY3MWJ5R3cxZnZaeHE5dXhGNFZrZTFGTlBYZ1dueEpJUFE1M3Jzc3ky?=
 =?gb2312?B?NU9YL25ORXo2ZzQ2SnNXTU0vZ0dnbkVhSGsycFpBUUZHRFdObmVVQkpBZTQ1?=
 =?gb2312?B?VEdsMHN0T2xHd1AwcmdaSy8yd1dLWUxFWEkzZVBpclBhaXdSU0ZCVkhXRHox?=
 =?gb2312?Q?hw0kQEcSe4L1oQQETrvKCpHtKT0UdDQTOj80l?=
Content-ID: <044220262AD1AE41ABD90E467801F3D4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06d32eb-d313-449d-dd92-08da107c0d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 05:30:20.9783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUGptL4xXer3AtaieQgspeQWmdN1k38OhaYI/C0LWYBkCPhRZboC5AL2+1IkfDpsC0MKdZoI5Wgb2DNOE+WIP9/lExBwJWkDgHTrfKnbDXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1708
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/umount2_02: remove useless TST_ERR
 assignment
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

Hi Petr,Dai
> Hi Dai,
>
>> Signed-off-by: Dai Shili<daisl.fnst@fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/umount2/umount2_02.c | 1 -
>>   1 file changed, 1 deletion(-)
>
>> diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
>> index 4c3b30e..d1aed11 100644
>> --- a/testcases/kernel/syscalls/umount2/umount2_02.c
>> +++ b/testcases/kernel/syscalls/umount2/umount2_02.c
>> @@ -69,7 +69,6 @@ static int umount2_retry(const char *target, int flags)
>>   	tst_res(TWARN, "Failed to umount('%s', %i) after 50 retries",
>>   		target, flags);
>
>> -	TST_ERR = EBUSY;
>
> Not sure if the for loop in umount2_retry() could overwrite the original errno.
IMO,  in this wrapper, we don't need to use TEST macro and we can use 
umount2 directly.

Best Regards
Yang Xu
>
> Kind regards,
> Petr
>
>>   	return -1;
>>   }
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
