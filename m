Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1720ECAAA3
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 03:02:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F0253CA47E
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 05:02:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD57A3C1BC0
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 05:02:14 +0200 (CEST)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E55601A00703
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 05:02:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1661482933; x=1693018933;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=66+Le+jrO8rsUK3KnTlS2ZTK+iNIBYIHgq4y9miUZDI=;
 b=zHogCZhEo4xbmpvNzJZ7dXFmjzcuKpcBo9e4SQZjq7LQkJbJcNyly80F
 I8yQphAbUSqtVmKNBdNWNlfgX868v9Wwyv7xE67ALJEF5x0OgoTdbRb0u
 3j+7fV9e1ZR3NOFvfY/uV4dH24bd9B988mrMRXmMiS/nUPfIpm1QLxSJY
 uF20EYgpwIW6crv9G4zC2cgEMavp63oAJPp2wjo7BYmkoAVC2J6d+6iAH
 vUd5Bu7VFu5C2pLnFvwWi2z3rYIItVat+4VYvkFQBUAp5zRvVHUP9FN0F
 0e1d16Hu6c86P9L+5elL0vIggkt1TktfIY/qc2yniRk2x3l4iQILBqVdW g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="71664070"
X-IronPort-AV: E=Sophos;i="5.93,264,1654527600"; d="scan'208";a="71664070"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2022 12:02:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEfSfEoFXqnIQkxpVwzbVelW+9pfon1AjY/Zz86w7U5n2q2MlqsL/l81pjIV4YX+2hDJKh4qa7AxuiyWkpM8Wke8uZbE7aD5RX9zZ6UbxLqjCE2he5QO6+SQ5tGf3HZbdFsGjnlURZPWD428k7vmJ1+P3893edVCJ+HOVTO9K+PDQA6Df/QCo/3htfiDjEBPEMUWJVpJ//iEfUe66FT96H2L11txt8GYVZXDF1+azIB3ZXb1oyyqkE4/RsrJnM3uVqJka9oZqJtKNOlQ5kbdAivu9ipuVOcFzV7tBbq2OR88LGRArsmqBE7KKfuNBPUDSMiHVViQISfJzpaDZ6hQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66+Le+jrO8rsUK3KnTlS2ZTK+iNIBYIHgq4y9miUZDI=;
 b=LAwbhKW1LE/87erDTzvGFzC5L7/3LDXiDlMkm/nog+/1SHatep33dp9s1DizevVqngsn0vcUQ/4AlrkegT03RwmZE/6TaA+zAeX2xqI2WdRJ0Ac6fRK2l5DiGwVcaTLzoqliLN347d/JE0nerlWGJIqZDlUJALjkpsRqQvjnkj3SOezjjZyOuJ97Ls5FyUvGh2uQ9aKbNSwETCtzKoFTTqt7qa0tjOZ21AeFyMt/WWF0dikY5JpcGE89Hc25hvDRR6r8qgfEo0q/ndqFYLwFl4W4BsOTuwKhMMPAB7sWwrbNWxYR/SUdcVLnfEwrUVdW3d1GX9jCxG9fbAbo2lbvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB3662.jpnprd01.prod.outlook.com (2603:1096:404:c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Fri, 26 Aug
 2022 03:02:08 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5546.022; Fri, 26 Aug 2022
 03:02:08 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Avinesh Kumar <akumar@suse.de>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] statx04: skip test on ntfs filesystem
Thread-Index: AQHYt5Dpt1wUqZn+j0C6Rea+CXBH2a3AkkyA
Date: Fri, 26 Aug 2022 03:02:08 +0000
Message-ID: <bf8c64a5-1427-9b63-f5ae-9a3fc4cd11d7@fujitsu.com>
References: <20220824080947.9414-1-akumar@suse.de>
In-Reply-To: <20220824080947.9414-1-akumar@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b46b6fd-c8b1-44e0-97dd-08da870f5d35
x-ms-traffictypediagnostic: TYAPR01MB3662:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vsa3kygV0I92vK9rEinb8tuuPhAHntyIxo1WXrgKP3YYiOBpbsdyDIH5jlPZxS/n8JuDOi7mLrli5ptrzxcCMHBU0p6XvqOSiYtuDr12p+bdBhERM5exSaQqlc3bWsLHZ0Axg5lbFMCOKWQZ2tiPdarUzzwNPwlg5KreihC/ggh/fum1F3My7L5a/I3z81ca9EWUA+LhN3LF8qK/KB8WL9aoRkQazVNVFG37p6gccxbhiMUiTBx32QCLDOYw2hJlRmjOAzlZwTXTPdJNFdF0ygYckcPmFp8xlfmIgZg1hk/BwZt4ktP0TsNNCgWk9Yixp2OnZIUX7tnnoDSfjt67cw0XiKbFLEYZLPX8FgZ21XCgSEPpkVYQTG1i7IkkhZYXlC1q7uRC1fPopyL6qigR29VMny9O93GV86KERf+IpT/P7055P7hKjN5rahgNaRehR6MDP4C09BjIf4tu9ap4VOGH0z6Mmgq6hgOgGY7Dw5DXSjaa7FfT+CVa0k6tr3cvat80NgmXynePnefJ0tOJiKtUB1C40CMTLhXfp7brbcGNFhuqfzWSYvJYIxFoeBz+uZCg2zJ758FSGbGKobwv1jCWRhD+SpohzkpSpODrnvY5HnRXJa4tuEQ4E6YvbJjfvUtVFqDQaJPH+mPoaFI8bvK9As62T+8iDUURp8+rbbDVCO8Wtsns8IK3hV0lQyXgCNhwNWu3xqCVLRPn4caR+HuBN0VAQmUGV3RGDTPLIobxnSg+q2m6CbhwNuzE2fW5BcqqQEoW/+kyrL2hm4BHGCREzmNSkNY5PYUE4ceCvAo6FRaIPh7oNlOSj0U0rz3YHqClzhFP/R3eHLjhCbetig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(1590799006)(36756003)(4744005)(8936002)(6506007)(5660300002)(2616005)(26005)(83380400001)(31686004)(186003)(85182001)(6486002)(1580799003)(41300700001)(6512007)(478600001)(71200400001)(38100700002)(66476007)(64756008)(66556008)(8676002)(2906002)(31696002)(66946007)(122000001)(76116006)(38070700005)(66446008)(316002)(86362001)(91956017)(82960400001)(110136005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXNRbUxGcjdxNEhWeDdZNjI5ZzZjVjZsSjM4amZOb0xLT0RUU2Y4OTFobVdW?=
 =?utf-8?B?SVBXSi84MnMyVnhsNGFxeW1xRitSOVo5WndiVi9FWVRwZWVBNXBJeHI2WHNK?=
 =?utf-8?B?NEdVYk9hL3JlOTRiY05CNTJOM2xYaUZDcWtuRmFnUncwVzRhTE11YW02MGJ1?=
 =?utf-8?B?LzhQNDl6U0kvTldzSUdHc25rTDhGUktXc2E2UEN5YnIzM3hzUWhUWS9GblFO?=
 =?utf-8?B?aG1NSGwvWHFiM1ZkVnVQVFo0Ti9vSGRMdkhsc2k3eldiUzlqMGx1SUNoRWY0?=
 =?utf-8?B?ZGgyWTB3SnpRczVzamdxR2VMWmhrQXQreHRKeTFkWWZzQ3pSRlFRM2xjVU04?=
 =?utf-8?B?UmlRbWlwT3krNFpDN3hKOER0RTBpK2RsNGd0MWFzVi9NK3o5VzZjM1NQMFps?=
 =?utf-8?B?Q2ZXRGVkaDlJMFkwWE1EYzNjdDJzUTZWdjlINDJGR0pWS0hFNFpNNzZZeVp5?=
 =?utf-8?B?akRwOTdwa0h2aWlocm12VERKYkpIZWlXUkY5QkplWHRUckRORDVXT0trNUQw?=
 =?utf-8?B?N2VRcmNkamRTWkJuM0pxcDN2WHN6S2JFbzVEem5yNTh4MlppOEFBRHN5L3p3?=
 =?utf-8?B?QWdqRWVvYk9mRXQwS1pNaGUyYzQ4c2JDeGxvZVpFUjJIamlLMGZFazk5bGwr?=
 =?utf-8?B?S0JxZnpIejlOa01aRkxZTEFMZ2pBS1BuVERUNjcxcXRrcVNKQlR1b2hCVGJR?=
 =?utf-8?B?dEFMVEwxRktRQkR2eC9GdE55YmRacTN2Qm1pUHFlNlk2UmozOTk5NWQ3VytW?=
 =?utf-8?B?bG1WMUxwYmM1NjMxeVBRdExjSGhzOFJEb2VJMXcvUWlyNENKVzlmYXdMOVlV?=
 =?utf-8?B?b0diWkNkb0tpVFNRZnJ1YVk4TTNETXdHZTNrckhQZ25ZcEltNXhXVlVKQzZm?=
 =?utf-8?B?bjBOOTJYWHpBOTVwWkhBTlVDZWg4ZmxXTHBoYms2REZPVU4rbmRXUkQyQXUv?=
 =?utf-8?B?OExEclRmME52bjVyTHhoYTVrMFV3YkVhWTdUYlorVGtxQmhUVlFsSkFORmN1?=
 =?utf-8?B?RFdVZGZtZ2JMTVNKeGFVTGhZOXllQ05XMTBBQ1Q0S3ZmMTBqcUdYa1pJRnpW?=
 =?utf-8?B?M0Q2TXQzUTZuVUp1d2NoTCsvV3RKbTBGZHdXYWpXTzhoMkFlQVhqeHBvOTNo?=
 =?utf-8?B?eHp4UkxwRmtQdm04NWpobWtRaTh2NmJwb29KMHloNHlwYzcvTyt2aDIwUlBF?=
 =?utf-8?B?K2Z0OFFtQWVnSnhURnRGODFlbWpYNkt6TVhoY2hKWDBKSUlQUWFKaHQ0Mkxn?=
 =?utf-8?B?RnNGL29BN1BmazFzWVRzdHhtWHVxUUJaRlZQbGhZbU5MMEMzSjJDZ0lvemVI?=
 =?utf-8?B?a3BKODZzSmw3MzU3Yk5rSjR0OFE5VzBwY241MFZyVWMvcjNRZUgvVDI1bmQ4?=
 =?utf-8?B?WENLSDdxamd0c0FjNUc4dXRTZzJKUVVBYmRNaTYzY1VQRlYyOUJhSTNBN1ds?=
 =?utf-8?B?MWhrUFZrdUlkemNaaU1rcWFPYjFTTGRLNVZsbmVnQnY1VkhUQU1VcTJHaDR0?=
 =?utf-8?B?Y09PdEQ2cExxZml1RGp5NVhlbXNhcXRSVWt3UU1JWGJXSEJVRjhyWDVJTGNC?=
 =?utf-8?B?YXp4ZXVaanowSmpPdWdsWjJZRURCWFBhYVlwRDJqemhWTWpTa3NtbVBPdTkv?=
 =?utf-8?B?Z05UZURUL3VMai9VRUZ2UWxYajl4Zkw3RHJXeGVMOFVNTW4yYXUxeUNYUHo4?=
 =?utf-8?B?Wmx2VVU3RlpGNWZINElOeEFWTFJIN3hKQ0dKTi9WbjhvQnF5Qnd1ZlNGQXg2?=
 =?utf-8?B?NS94d1NMUEpZbDdiNEdjUm43TDdaOWtGMS9YMU4xZEk1Q29yUkZCZXVuazlo?=
 =?utf-8?B?YjFkbVBCcjJjQ01WY0I5WDdvQmliM05pYncwMU1LVFphY1RLdVdvT3gycFNx?=
 =?utf-8?B?Ti9TdVpzZHZ1aHNORkVncEdFV1NPQUp3cEozWHMrYk1LSDcxRTczOFl6bS9I?=
 =?utf-8?B?UlhNT0x0OGFvZG5ud3ZLVEpIay9yNWlEbndiclNnUHBLcjI2cGFtRWJCbWV5?=
 =?utf-8?B?ZFFBR0ZOOFhuMjVzOFFUNlR1SUJPVVZXYysxKzlzQVRjeGZzcHA5QytZY1NL?=
 =?utf-8?B?WnNRZjNVYjl5T1BqUUJ2clprY2twSG1STTVTdHU5MUNyL3ZldVEzVTBKaHBz?=
 =?utf-8?B?RkpTcDlDQU5aVFNQYnNpTWJlYjFlWkJxRnJLMlkyNm5zT0VaaS9DcGZIN1J1?=
 =?utf-8?B?UEE9PQ==?=
Content-ID: <5F88153141F24D44BE52F86DE49C5463@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b46b6fd-c8b1-44e0-97dd-08da870f5d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 03:02:08.3930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0Lfv0ZfJ14pTVZlnJXaZnPyEe0CRtgpmfPch0dU9ASWgthZO+PbEmSP7KyZcVXW8KhXlOE3X65FuGB7u27MAL+R+7xIP//oTDpyu6Aekko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3662
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statx04: skip test on ntfs filesystem
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh

I just want to know whether this patch was verified by pragat22
or you?

ps: I don't have environment to test this.

Best Regards
Yang Xu
> Fixes: #956
> 
> Reported-by: pragat220
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>   testcases/kernel/syscalls/statx/statx04.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
> index 98f9a6315..3923b7f8e 100644
> --- a/testcases/kernel/syscalls/statx/statx04.c
> +++ b/testcases/kernel/syscalls/statx/statx04.c
> @@ -132,6 +132,7 @@ static struct tst_test test = {
>   	.min_kver = "4.11",
>   	.skip_filesystems = (const char *const[]) {
>   		"fuse",
> +		"ntfs",
>   		NULL
>   	},
>   	.tags = (const struct tst_tag[]) {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
