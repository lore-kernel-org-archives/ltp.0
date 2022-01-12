Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7E5C433EF
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 01:53:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E65733C9469
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 02:53:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 140F33C93A2
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 02:53:00 +0100 (CET)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0613F200240
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 02:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641952379; x=1673488379;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=uGRPhbmVvJ4EGSY7QviNPlKyJaA5tmY6YhGJeCx2ebg=;
 b=l1yx5zn0LvyYOnxmqBufcNm9RhBBwLxUeEPaRZ1ezlU5FjQu9nJypl/K
 a0rHYm8HhO+AkhN5srsyjlKbKB4vXaP6qC+Vl+GJPSvQqx9hq9OjKx6eF
 2uW+Q15SFqUDyyWMrwM5QTTUQEiTqGcCay7HDiDwkYMLXBBsDEsWsIXsP
 Zj+6u4dCkn08tBu3O38Fz64RnKRs2AHt5ONGznm816uvc90+zDEhDYoYk
 Yal00nHVz2CS8NAGNb6oCkCuVqup7TSiUjk4lpZFdjG8sAXxR6dwcdekL
 CJdRlk5+F/Ee9q9VCJ1g7C2ctPLJ1b821ovsr7OYtdxoEuFOVx58UfMyi A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="47278083"
X-IronPort-AV: E=Sophos;i="5.88,281,1635174000"; d="scan'208";a="47278083"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2022 10:52:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9776JqpvaB7IWO8MWDV7t+uiX/SX804QoK9Y32CwiT6LODVqr6fpa8z/nqAGQUgKP8v/neTG2AXtYMG/wFSfDuY+UWeO76SRmkqOxozBV5VpxQkFKtdLoqmpGqwu/k6zf66fL2kotB/sSn+FlPzJ4SEuvgM5sr0XfYIH2tsVlUgfPfUN+lrlBj/+sn1MEloOzr53JLfUvY13Wx00BFuGxt6YAmyjditiwn2cTYdB368uweny5r0tg8Ozy959WQJI8t2taBhmbYzgCTx3EGUcg7An+a23wMyzwK2g6kCQw0ukdyOn2l9aos61lAz7X4x1ks+VDLxxfuQ6c/lX8OmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGRPhbmVvJ4EGSY7QviNPlKyJaA5tmY6YhGJeCx2ebg=;
 b=Dj8wglrpxPQukVJs3dBFHXstFoEfK86d0RbDEkqqlmTZ7iTZeGUCZzfWXfeTEV1yqo91BTL7eh7wkFnsdMgbqLBsmYstfx5I88JMklj8E62shWjfLxMdENYMD8UNBoJn0ArP+vNQf6b6U0An8yZVgl3RjRVBRfFc3S/JBjERMUmIUikV0YfZy4147f2Ld7gQh6bGjQuRNHWYJS6R7cpramQJzQ3GddSqPOrWjUSVuso1+Y/opmL1CpPlWdiDaCWJXej5JaZEqYf8jDdv3JGP6MBDqq0S5ks+i+Ko3Nq492yD33cPB0UCZ6l2Y+9lfABes4t7LSxVW68cq7lu8CbDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGRPhbmVvJ4EGSY7QviNPlKyJaA5tmY6YhGJeCx2ebg=;
 b=QJ5LldsFE8JxZGRBHtR3E98y/h0NxgIxOi6oHtoPC/VnLiBp2GnAf3LIdA5c3d5P4nOoVqN7E2FufLkHmlMVfFp5NyXWp60Mo1myMlYCibpW+AHugjKntfSpa3ncDgxjuEUVbc1syePv5hI5iJAkx/Nts39k15/CJTqLWBxsY9M=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB6286.jpnprd01.prod.outlook.com (2603:1096:400:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 01:52:53 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 01:52:53 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v4 5/6] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
Thread-Index: AQHX7/Lm7zfTqdcjzkiV0fTdw8fQBqxX3LqAgAQfnQCAAIVZAIABDg+AgABD9wCAAPrbgA==
Date: Wed, 12 Jan 2022 01:52:53 +0000
Message-ID: <61DE34A9.8010000@fujitsu.com>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639380414-24390-5-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdhhTeot7Z9861B0@yuki> <61DBD6D0.1000104@fujitsu.com>
 <YdxGrO40TwVJmeWG@yuki> <61DD2937.6060609@fujitsu.com>
 <Yd1iOp2I5LrJtJDz@yuki>
In-Reply-To: <Yd1iOp2I5LrJtJDz@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53c520d5-675c-4c6e-4122-08d9d56e3f93
x-ms-traffictypediagnostic: TYCPR01MB6286:EE_
x-microsoft-antispam-prvs: <TYCPR01MB62863219BBC4CD23A5C95DEFFD529@TYCPR01MB6286.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +NyjFuN6l69az5f9qUpRjojZGV8ANTAtObawCM7+jb95+/6LvQ8JvUz1fGtkprhdNWzt9DLvXvn5LRdwhi5rTcm8zo6qZkeU9QemmezrZ46ChZ3ph/YvJ2C/WRSF+0vjQqyk02oCPcwPHUYLmzWGHBAlnpetVrAncQe8PBTZldhTronKEVeFhMKPxl5fVPfB4lr1NFvoXQRBj5A6hvowLT6lmr1iy3z0Q88NAscyn4bt7FZjXMYAO5qXpeBDyFSmR8KKMjytsCar9Tancn/jXOrP+eqmVs63JvRofcoKqGUy8kd5VMFWyOF+3/X7S2uxgsaiwmzI9+CU8m/1G3JWLQNXLYvbytcmdf/hPf1/NK+8F8E3ccuISYP5Pii5rUAlgcLa61Z/pHpa639/m0g/tECIp9UWrNF7mByqCXR1Nj+0PZ/T2RJcgtMr0Mbv7DmTW8tEYDRfaVBwBvujv97+0WI8YRxa4G1a0EYR1ll4+aKGwGzowooP3UsEk3FdqMH56gFGYMYuofOfVj9UWhqlm62wqBJlOSqE0jifdlAerf1VjWug3Ea+HmkeLD8itZeMOkPKoLBEwhTkyEjWjXSCQJde/UtCK3aGIbxQhS7H7cTax/6FoSfKiF+fsIzlD62OPnsEDl2SwWT7Gu0MnYziVuwAHhS2MqVeHloS9sfSpmMZhBe+cOeqgQTG1laGax9eJxDwvhMahfCjzsiySH62ng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(122000001)(83380400001)(316002)(6916009)(82960400001)(38100700002)(26005)(38070700005)(4744005)(6506007)(91956017)(5660300002)(4326008)(186003)(15650500001)(33656002)(86362001)(87266011)(508600001)(8676002)(6486002)(8936002)(76116006)(71200400001)(2906002)(36756003)(64756008)(66446008)(66556008)(66476007)(66946007)(6512007)(85182001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cGVaZjFyRE5nRWtTQXFUcDh5dythMzVjdmdoNUNrUW13QVFrNW9Lbkd6Qk1Z?=
 =?gb2312?B?RUI5TzhqQUxQQTB3RTNva2h4VDUzOXp1MEZpekhzOHZVZit1RmpNdGF5V01S?=
 =?gb2312?B?VWFCcDgxNm43b0RhSHVXOTlyYUxUdTVZejF3NW5iT2JqamtHRWZGQkpoOUZW?=
 =?gb2312?B?bHlrYUs2MUd4UWV4RW0wL0xZV25aWGVVSW9FOVhlNHpaNyszUzZFSGdXYURB?=
 =?gb2312?B?QURrdTRsRDB5MFNRMEp3THBXMHVLUDBQaHg0a2d4VjlJTU9FQlV3QzhueXU4?=
 =?gb2312?B?OG1PRURxSWVtdjFvOFlVMzdiRXlwRGhXREtQSXR5V3M3dWRVOS9lcnRzanhV?=
 =?gb2312?B?NkFBVEY5cFFDVDg0NFg1Q1cyQmFlZTZIR1JxR1ZMVWhDYXJnYm9EOVhSbVk1?=
 =?gb2312?B?cWExM1V3Q1VIMTB0M3duNkFIanNWcEUwZ2d0c1pDZjh5dlhFZGxrOTNOeEN6?=
 =?gb2312?B?endBYmhXaWVvWS9JOGN5QmkxT3dsRkRqeUdtNDZYa0hFSjdLa24xSlNFbURB?=
 =?gb2312?B?bUZzYmM0RUlsVlNnam1XQlJ2b2I5emEyY09NYTVVNEk1VnBlSnpPTi9aUkVn?=
 =?gb2312?B?Q3RCdEZNUEU1RzEyUzJnVU9CdTBodWhpbnBBV3FZMUQ0WFgyM0VRRHd5Q1M1?=
 =?gb2312?B?VkQ1N0k5Qm9rNXVybzRkeU1JVENTb2xRWmZzWVFtdzM4L1JObFdRbzlEODBv?=
 =?gb2312?B?bGxjNkdVYzdNbnVSZEQ4MTlkNkpRQUZraFFsNlhhUFZrVTNrK0hzUDZ3aUMz?=
 =?gb2312?B?S3MvRCtqRm5HYVNyUU1oUnlSNVJINDRHV2x3aXNPcUVGMnd6YllsaEUxYTl0?=
 =?gb2312?B?bGtRWXQvWGk0eE5DaUMzT0dISDh1Z0c0VE1Rb0EraHpnUFo1OVZaWFZMSklV?=
 =?gb2312?B?YVNIRFo3d3FieGdoVXFwbHdZMEdnb24vZ0dQTy9kSVhzMUlwRW9idnhnbFJr?=
 =?gb2312?B?Z0hBSktybStINVBhNlpuSkZ3KzJDcHo1cWhwbzEvQmVWZGFZNzhtejhQTVJu?=
 =?gb2312?B?WUx4MFBJWDlYeFNRNEZ3VGRuTHVDMlJqWlVVS2JDbjdwZWsvdU9VSUNzWGlV?=
 =?gb2312?B?d2ZrYytGNnlJSjZ0ZzFkejVCK0p4NmZvRVFEWDZkQ3RmK01aNm9YRFFROGNN?=
 =?gb2312?B?b1oxYXhQYmFlUDZGczNnNzE2WnRRZlFhMnNNeE4rQld3ZmlHSzdzM1VTa1Vi?=
 =?gb2312?B?MStnZlNLZWk5VDNSZTdySTdvbEdBUWNyZmk4WTR0S0srUFhya1d0RThZMjl4?=
 =?gb2312?B?a0M3ZEs2Z1NNQ3JZbVVrSDNhUXZnaU5nU2owZFRYaWM3SHRSMUpaS2dsN2tV?=
 =?gb2312?B?eG5TbFRPbkpCL25Ud0NFL1ZTOGZWcmxIbGlLclRrNG91TWQrVEdzcGpKK2tx?=
 =?gb2312?B?ZzBqQnFZT0Q0UFZnTkx3T0xPMSt2WjRNbUt5ZHR4OFhNTkY2cjJGVkhWWkVY?=
 =?gb2312?B?Q3RQZmZJek9QV2FNcGtkMG9wMmkvNXJBM2srSTZHdXRaSExGQWhiRzl4NStH?=
 =?gb2312?B?VDYyTExNcXJ3bGd0UHozaVBRdEY0WEFVb2xtZVVqakhUSW9zWkg2N1M3Vy9L?=
 =?gb2312?B?b1g2bkZnUEE3S2JEdE0vZkVVenFXdzRicEsvMHBUYjAzWCswNHZ3SHhpdkNG?=
 =?gb2312?B?QmI5SXZOMkQxTEZWc0ZYc2VRNktYZmpDbkU0ZU5iMmtZQmtUQmR2eWs0dFJl?=
 =?gb2312?B?QlFsYWdYdldCZ0tGNFZUa0x6SmtvbFlPVnFtdjJMM1lSZlowelkvRXdRajFj?=
 =?gb2312?B?UUNnTjdyUklOVlRWK2x2NWZSTFpGOWJhMnpHcXFxK2xYU3BCNXg5OHF5UmxO?=
 =?gb2312?B?ZDhiOHVHNVhGTUsrSEpmazhpdGVjWHM3eG9CdEN6V2lrc0lrdHJRRTNkbjFi?=
 =?gb2312?B?dTdRQU5RRHpPdVB0T29LYXRQbStBNzhidGdvYnR5cWxZaDE2UElZam91ZzBV?=
 =?gb2312?B?OWtvVGxBWWdHcFk1NytQOE1vQ2NLTjhDVDZzU2dlVUVmQWdQSTEvQVlMa2xB?=
 =?gb2312?B?aEtNeFZSYUROUlhDVlhwQUs4cGl2MEVmamdvN1BuVkxLQk5OWkNZaHRZbTd2?=
 =?gb2312?B?U3ZGUzBDM2ZFaFBrQUtqNkpZRlJNUHRQSUFDRFRRaTRoWExsR2wzRTI5am9r?=
 =?gb2312?B?UkVrenl3MGNZeTMvQzRZNmQweVZlTnRXR0dLaWRWREZWNDd2Z0hkL3ZEaDVL?=
 =?gb2312?B?eWJkR1cwYUZ4THBmZlJVRDBjYTMvMDg3eUhrV052QzR3S1YyU2xBZEwrZVRL?=
 =?gb2312?Q?ZUGoHFypUVCoqKKOyfs36ZQWK+IEzF3uvHXigCB0CY=3D?=
Content-ID: <7649DB0A35A3144680A006AD9B44BBA5@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c520d5-675c-4c6e-4122-08d9d56e3f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 01:52:53.8901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJy5IuZ1yd+hW1+czaMFEPCVKCdXxS7qklgEYvP0qEfAtQd9UfPV2IOjY1AGrwFZCWB4IHpojuBpEFQaBN2Ug3LDl2tObaf+bLm0Fn6pS0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6286
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 5/6] syscalls/quotactl09: Test error when quota
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
>>> So we pass a fd that
>>> points to a device and we expect ENOTBLK if tst_variant == 1 and
>>> exp_err == ENOTBLK? That does not sound fine, what do I miss?
>> We skip ENOTBLK error test when tst_variant ==1
>>
>>     	if (tst_variant) {
>>     		if (tc->exp_err == ENOTBLK) {
>>     			tst_res(TCONF, "quotactl_fd() doesn't have this error, skip");
>>     			return;
>>     		}
>>     	}
>
> Ah, that's what I have missed. But still, what happen if we pass fd to a
> regular file to the quotactl_fd()? Shouldn't we test that case too?
Good suggestion.
Yes, AFAIK, the fd point to superblock, every subcmd will check quota 
feature bit or whether enable but return different errno.

I will test Q_QUOTAON with regular file fd because it is the most 
meaningful.

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
