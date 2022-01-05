Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B25C433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 07:15:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A2DB3C9237
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 08:15:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9999D3C9097
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 08:15:38 +0100 (CET)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 89D6E1400B97
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 08:15:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641366938; x=1672902938;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QyctihoVj5hqj82/vA42hd0roo1+9EJywfPGSAEEEAU=;
 b=hWpNs/q0Ffr7DOazKRS8semN8/tIBa7w7TZNgfiOV8Zn1QeYG1hWZfTm
 rNb2IBOlq6VEf5PlEvwaWMth/eCSro0+Ec3+JECRMp3gQJqDnjakYTNcR
 R/dnh2hQRhUAjwiTS+WZ9pxVzgO8nzscMnbCfk/bJAFncnlutxg/rTTDg
 PrOKCEl8rTBiLxuLyu4yTiVy8ey4LbTNyiaNcEuaFvuMGsFdiEZcKoYbD
 2THTNJyXhvbfZ7TsTbUtA4PWtCeFcWt8dCIayP3klLu8D89TNYNcZqX3V
 h1Km5L7a/+vMfPKCP53+iuE4NjRitL63rA/Zg5AaUPjXpc4fPGSUf5GvH Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="46994565"
X-IronPort-AV: E=Sophos;i="5.88,262,1635174000"; d="scan'208";a="46994565"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 16:15:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6xnjqHjXMtBGud0cy2CsjdsarUIF8Mpe9BkPUCKm0bLEXlzjl4qOkcvRegNd0p9M2cyZMXlTBsGcrG5ZMooRipFJKGDsfH91ZZCR/8o7ZshHRCpgC0mVkGr481mLeoOibylfKNerHUaDuvniRd/7EAZ2eUKpEuI/pvwnWJ9zdGg0L3kc1z6n3+hISGwDX+A4hfh27bbxFZQj4OBRdnRruqpjavp9H0a4uOCyVoveYn/vrX5gZDDvNbORrJE7njHK0yF1c35FpxLCbDbevCJIMN/VFeJIQT9pWpuSF39Bdm6SCuaeulqeO/RHCNaw58lG8l3FckbOgGUavQx6ScTvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyctihoVj5hqj82/vA42hd0roo1+9EJywfPGSAEEEAU=;
 b=eScO7zSZDR0BNbsqIij1/xoa27pAKhJQtHp1II3XUidnQ9Go2Pg71K978WkxKzThULjkmsBJUmDl7yBH/3fXVpMRUycTsgE4gn0LY63Rr4xQbFGI/l9ggdXyeOmC7mVOiGPnYtIf7NU0DrTROkPKpG06gWRcBtvMo2GFZDQI3g40OkrBrr8K5bHOdP0WIb5B4tmTV8KihrkvhAFtp9qCvK2C160ByEbWkjTsNLz8kUucpRY0nDZVXQym0pVtJVL7xRPer1VSFOfYn1raxq2f4Q8ndoyQDsITvflVhfjIl369H1xCkn8tU+9jSS8eY6JbrKDmmZq/Q3rqby+a7eQ4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyctihoVj5hqj82/vA42hd0roo1+9EJywfPGSAEEEAU=;
 b=Tdode0jh2bFMP/NUvUJME8yNor4wTQi47Zjtlv84Y6UtmCYPCZHGNCRN4ed+oyUmx4VPHRcSBPW7akoh9NZvqR+QiwuMFvCao4SKSPi4UAEk+9ma8JdIuNaAkbLAri8KYWEEa/1cjhdU9z4Mhs0ONHG7+U0o3LBnKtRhTR2r3Mw=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4202.jpnprd01.prod.outlook.com (2603:1096:404:d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 07:15:30 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 07:15:30 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1 2/3] shell: add kconfig parse api
Thread-Index: AQHYAThOqIvUm+MPjk2RIXi6fN05TaxSs0UAgAFSgYA=
Date: Wed, 5 Jan 2022 07:15:30 +0000
Message-ID: <61D545B7.7020003@fujitsu.com>
References: <1641279439-2421-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641279439-2421-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdQpwpbyGGNKx84z@pevik>
In-Reply-To: <YdQpwpbyGGNKx84z@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db717c27-772c-4dbd-fcf8-08d9d01b2838
x-ms-traffictypediagnostic: TY2PR01MB4202:EE_
x-microsoft-antispam-prvs: <TY2PR01MB4202CABC00AE8E98E0A1CF85FD4B9@TY2PR01MB4202.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y/+Z4cT8P68Z7irDZS5UUwxxRr99kTTCdMFp/jFQS4Q/8Ndav55xCTyi4fS5iQYo7qhLPO3YBYoI7HVySnuN+aEyII0RtZTJqqbW4FAquDXF3AXH5czSbT5VPjnH5Gut6CBaCAHthrbIg9D+vrg28fSfCQJ2bZ4XGE9TkhByQe6QTfYJgRNZPIeyGN6FOBgZBwJZmj1in3bEzHUqbWGUQ4WqmPmwI99ns7H6JGu1b0tX0D3kIheSF55uRxiIWsXFqDZ8WcKshJsWfVWOBvQb9xUQnXYF+1xGIjxMCAqJtcbJ/iplESB3oInKzOPynzASj+uFQW4w1eHhH3zwWkvqv1Mb8hS0o8nLJ2GWyyJQJAADfb998IGM+OIQ6ElaCxFBootacSH5C8/tFeMNifaIrDIpkxHOfIBwInZV+zsFJ0jkK5j+mvWzhhShHQBYlGUUcs33ZFE9ZedWX6lmM5ejoJKNHUmRCSgge7qdPfxephqCWjp6+UF1T9puRF5Rlg05VzMTxwjw+gfmI+h9/00ancrHy5oPYakju6dwDUeXliN/0dsq/7hqeUWnwchnH6TFcgzO9gFd7IZ1OXWYiAyJiTKp3IjJ2W8kgVFFfypN/CgVW391FMvxX77gwbguV7Il8I30h8HObO7ezoUJlNEZ/gqHQM3LWUO9yU3gEBcJw17B+P3FWwp2+doxIzeiYPto85LnsY01BShy9Ws123UT19x97wi58hkUycUEW6ksJbo0aBm6g6PU+T3TxjP29kc2htz8a/zbmD8FojxFMMmZ5Ea0pAzSs39gkLFtxxCtW7E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(71200400001)(508600001)(966005)(8676002)(66556008)(8936002)(2906002)(86362001)(64756008)(91956017)(38100700002)(66446008)(66946007)(33656002)(122000001)(6486002)(82960400001)(76116006)(316002)(87266011)(2616005)(26005)(4326008)(6512007)(6916009)(83380400001)(186003)(5660300002)(54906003)(85182001)(36756003)(30864003)(6506007)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?N05RQ0xPMnRmQjdBWmlVeU1RUGxsQnRLM3FqbmJuVmlSSEJLRWZETUxJMm5M?=
 =?gb2312?B?Qzd5TXVqcjAwdUhGd3RKazRZZVFON3lKZ05XMHNWeUZmeWR3RjMyRmlnRmww?=
 =?gb2312?B?Sy9NRHl4UVhHRXdLUm1sVnptdVc1UjVKTjAwVnpoaGZBNVd6VW0wWWlFLzNs?=
 =?gb2312?B?eG1iZ0pjRlRrd0hHRmc4VlFieUFWRjJzeDlHaFBwRFBaQmh0c2JRYWxlcVBB?=
 =?gb2312?B?NVdLelp2aUw1dDZjeDRJWk03eWRPemg0WXp2R1Y3Vm16Rm95ckJSS1pkdlhi?=
 =?gb2312?B?dVZZczBzWmtxMnNoU1gwUXdLQWdUeXBrb2xtS3BQZTQ2b01mbGZiUWxTbktL?=
 =?gb2312?B?TXNwQVNwM29uT3FJSFFOMVRXelVtanBEYS9uYkR0OVRIODJ1c3p0TE8wTGRx?=
 =?gb2312?B?RG9pTVB0Z250UEhEYW9HcHlhSWdEVnRhWll6MEd6eFpDMmNwOWs4dVM0eHB1?=
 =?gb2312?B?OWhJQ2hOWS9UVWYwUzVYYllISCtMNnpLS3Y0b2NZd2Voa3RTaGpsaFNUaDJF?=
 =?gb2312?B?Smg4dWw4MCtxd1E2em5hclltQTE4WExlUUt2ZTNwQ21lckdNRHZpWU1KaElW?=
 =?gb2312?B?anVHRVY4OVVocHVRYzhkak92SUNZSXZvYUpOdUZmWko2QWp5bDc2ZTFYNm9l?=
 =?gb2312?B?bUNPb1BJMlJiVmRWZDZmUnI5cHg3U2UvbGx5dm5oUlJGUHZNRk5qTFFIUGh6?=
 =?gb2312?B?d1NjbWZ6dEkxTHN1enJST2Vwb3hPMmhPdUFOb0s0YURHVGEwbVgyeU1PeFJx?=
 =?gb2312?B?bkd3N3lETEp2cXIrdVI2YzRUYVBHMG5CT0IwTkFua1ZLemgxaGUvYWxudElB?=
 =?gb2312?B?Wm03WmFPZHJOb3J0MU9mYWY4ZGMrTWhvMHJPNHlLYlZFS2l1ZG02ckF0MFhT?=
 =?gb2312?B?SUhTeS9PZE5hd25BWHBoSnBOZW5sdytnUEVlcE5KRnhkNGE4Z2hSUS9EOXIw?=
 =?gb2312?B?T2V4R09WMmx2VkhpYnlpdm5YamYreUdiaFhWaitZZ0dmUTBpUk9Ia1UvY1Vy?=
 =?gb2312?B?ZlVHem1KZ1Z5MDRoNWVPL0gzcDRXU0I3RFF5VTNOY1NMSVl1eVJkTERzOXFF?=
 =?gb2312?B?b2wrbTJ5WXFYQnBwYzI1TnBxeUxjZmVPazRtVXVNRlphdCsxQy82STBSSnho?=
 =?gb2312?B?VkF5Y3ZpK2t4aTcrOW5oNkZscGRnNk5DTGwvZTlBRnJSWnRXaDV0eFFrNGZa?=
 =?gb2312?B?ZUkwOHhhek5wMlpPRjJsV0RDWlJ5NFdKaURYZEZSK0lpbk5MK1VTcjFma2FD?=
 =?gb2312?B?Nk1ISGRrZ1lzQ0cvMUt1RnRZS3JqejI2TDB1QUZKYUFYbHU2M21iRzFrV1ly?=
 =?gb2312?B?VXF6TDREY21RSnVJd09YVG9oZSsyS2xCL2pRR1NJR25rNWNhczhrY2t4VUUr?=
 =?gb2312?B?ei84SWpUR0czdzlLdU9WNTk2ZnlGcVBLQTlCQTdvMEVaaXQ0VlAvK2s2aDFk?=
 =?gb2312?B?Tkk5SXJ5SkljYS9QelZaK0NSWkFFbzluQ0JtUTZLYUVTOTBZc3drZmh5YTBq?=
 =?gb2312?B?TlF5WlVaSHpsZ25makw2NWNIeXEyZEtBb1huOTBlK0MyeVpxeUNUZEgyZkxJ?=
 =?gb2312?B?QUQ2dm5yQUk0dUZnWnpOQXFZcjFHMEVwSTZVNEhzb2hFd1dLKy9rM2hqZThH?=
 =?gb2312?B?SmVmZnJUYTJEWHZDTi9HbXlsMVo3YXNyMXVFYkgvYXZnQzloZm1lLzBlQUZD?=
 =?gb2312?B?K0h0S1dFT0JyQVlhazlZRUtnZG9RYUJkUFVYYlh6eW12a3pWR0R6YXlyaGpx?=
 =?gb2312?B?YkJYRnlCTUk2c2FCaTRCOGRCTTIyYkFDWGRiWG1OdDN0VnZSOVhpN3RndlJP?=
 =?gb2312?B?YTI3YklLSExFaStzNTlGWHpxUHc5aEloRyt4aDJqd0p5bGpGVlpSQ01yS25N?=
 =?gb2312?B?bGhjMElrWFZKSWRwWEdCMWtKL3BtOTFyejJaY3hkK1EwTFdERnAwQUE1R3Zo?=
 =?gb2312?B?ODZUWGduaGlxKzhCS1RWZXlBY0dkZnpNcWdvUGZGU0Y5SGZMWU0yUDlza1lB?=
 =?gb2312?B?ZU1HWXBacjRKR2MwaHpCN1FZdUoxUmJLQzRZekZjQlNCRVNkQU9LYkpvbnhF?=
 =?gb2312?B?R0taYm43RXdlTXNUam1vcFk5Nno1Wjg2WGZhWStOSUJ2cjFHVEFjK2wvWStM?=
 =?gb2312?B?TXhxQ0xZZ1g3LzRKRkViOUM2ZUgrdUVORlBPN1Jia3B2bEJ6K0dXcndrTk5B?=
 =?gb2312?B?QUZVWkxibkdMSWFiODZJV3NaYzYwVWdGK1FVN2tyRHFUeC93NWFsYlRmQ1Rl?=
 =?gb2312?Q?IlBVyYiD9S58cGy6NXBDyKWDPWZ+KLG7485588EgQg=3D?=
Content-ID: <4CBE54F2F283D44CAA09FE6101F57A65@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db717c27-772c-4dbd-fcf8-08d9d01b2838
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 07:15:30.6396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7r/10kdlfy9LhYeiTb1T9qCntJnjM/dDE4aiRSp6vzxzi/nFk4Mj9KqFJGkoN6Eair7vzOE7k/tH4WT3m2KHS/8pZ2MzI4QDJyDDHWYJdDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4202
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] shell: add kconfig parse api
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

Hi Petr
> Hi Xu,
>
>> Use tst_check_kconfigs command to call tst_kconfig_check function in internal.
>> It introduces three variables in tst_test.sh
>> TST_NEEDS_KCONFIGS
>> TST_NEEDS_KCONFIG_IFS (default value is comma)
>> TST_TCONF_IF_KCONFIG (default value is 1, 0 means to use TWRAN and case continue)
>
>> Also, we can use tst_check_kconfigs in your shell case if you want to skip subtest
>> case instead the whole test.
>
>> ps:Don't use array in tst_require_kconfigs because dash doesn't support shell array.
> IFS instead of array is has been used since tst_test.sh creation, maybe we can
> omit this info.
Now, I know. Will remove this info.
>
>> Fixes:#891
>> Suggested-by: Petr Vorel<pvorel@suse.cz>
>> Suggested-by: Cyril Hrubis<chrubis@suse.cz>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>
>> +++ b/doc/shell-test-api.txt
>> @@ -193,22 +193,23 @@ simply by setting right '$TST_NEEDS_FOO'.
>
>>   [options="header"]
>>   |=============================================================================
>> -| Variable name      | Action done
>> -| 'TST_NEEDS_ROOT'   | Exit the test with 'TCONF' unless executed under root.
>> -|                    | Alternatively the 'tst_require_root' command can be used.
>> -| 'TST_NEEDS_TMPDIR' | Create test temporary directory and cd into it.
>> -| 'TST_NEEDS_DEVICE' | Prepare test temporary device, the path to testing
>> -                       device is stored in '$TST_DEVICE' variable.
>> -                       The option implies 'TST_NEEDS_TMPDIR'.
>> -| 'TST_NEEDS_CMDS'   | String with command names that has to be present for
>> -                       the test (see below).
>> -| 'TST_NEEDS_MODULE' | Test module name needed for the test (see below).
>> -| 'TST_NEEDS_DRIVERS'| Checks kernel drivers support for the test.
>> -| 'TST_TIMEOUT'      | Maximum timeout set for the test in sec. Must be int>= 1,
>> -                       or -1 (special value to disable timeout), default is 300.
>> -                       Variable is meant be set in tests, not by user.
>> -                       It's an equivalent of `tst_test.timeout` in C, can be set
>> -                       via 'tst_set_timeout(timeout)' after test has started.
>> +| Variable name       | Action done
>> +| 'TST_NEEDS_ROOT'    | Exit the test with 'TCONF' unless executed under root.
>> +|                     | Alternatively the 'tst_require_root' command can be used.
>> +| 'TST_NEEDS_TMPDIR'  | Create test temporary directory and cd into it.
>> +| 'TST_NEEDS_DEVICE'  | Prepare test temporary device, the path to testing
>> +                        device is stored in '$TST_DEVICE' variable.
>> +                        The option implies 'TST_NEEDS_TMPDIR'.
>> +| 'TST_NEEDS_CMDS'    | String with command names that has to be present for
>> +                        the test (see below).
>> +| 'TST_NEEDS_MODULE'  | Test module name needed for the test (see below).
>> +| 'TST_NEEDS_DRIVERS' | Checks kernel drivers support for the test.
>> +| 'TST_NEEDS_KCONFIGS'| Checks kernel kconfigs support for the test (see below).
> +1 for adding TST_NEEDS_KCONFIG_IFS, it's needed e.g. for: CONFIG_LSM="integrity,apparmor"
> Could you please mention TST_NEEDS_KCONFIG_IFS and TST_TCONF_IF_KCONFIG here in docs?
of course.
>
>> +| 'TST_TIMEOUT'       | Maximum timeout set for the test in sec. Must be int>= 1,
>> +                        or -1 (special value to disable timeout), default is 300.
>> +                        Variable is meant be set in tests, not by user.
>> +                        It's an equivalent of `tst_test.timeout` in C, can be set
>> +                        via 'tst_set_timeout(timeout)' after test has started.
>>   |=============================================================================
>
>>   [options="header"]
>> @@ -742,3 +743,27 @@ TST_NEEDS_CHECKPOINTS=1
>>   Since both the implementations are compatible, it's also possible to start
>>   a child binary process from a shell test and synchronize with it. This process
>>   must have checkpoints initialized by calling 'tst_reinit()'.
>> +
>> +1.7 Parsing kernel .config
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The shell library provides an implementation of the kconfig parsing interface
>> +compatible with the C version.
>> +
>> +It's possible to pass kernel kconfig list for tst_require_kconfigs api with
> nit: s/api/API/ (it's an abbreviation). Also before merge please update git commit message.
>
>> +'$TST_NEEDS_KCONFIGS'.
>> +Optional '$TST_NEEDS_KCONFIG_IFS' is used for splitting, default value is comma.
>> +Optional '$TST_TCONF_IF_KCONFIG' is used for deciding how to exit the test if kernel
>> +.config doesn't meet test's requirement, default value is 1(TCONF). Otherwise, just
> I wonder if we need TST_TCONF_IF_KCONFIG functionality in the test or if it's an
> user request (i.e. user like variable LTP_TCONF_IF_KCONFIG doc/user-guide.txt).
> Because I'm not sure whether test would need it, but I can imagine user want to
> have test running even kernel config is not available (e.g. embedded platforms).
> Or maybe we need both user variable and test variable.
Oh, I misunderstand the usage.

I should use TST_TCONF_IF_KCONFIG for non-found kconfig file instead of 
non-found kconfig list.

I think one variable is enough.

>
> Also not sure about TST_TCONF_IF_KCONFIG name, IMHO "IF" should be replaced to
> something which describes what it does.
Thinking a good name isn't a easy thing.

how about TCONF_IF_NO_KCONFIG?

>
> Also this patchset is about syncing C API functionality with shell API. But you
> introduce TST_TCONF_IF_KCONFIG only for shell. Shouldn't it be functionality for
> both parts?
Yes, code maybe as below:

void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len)
+static char kconfig_flag;
+
+int tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len)
  {
         char line[128];
         unsigned int vars_found = 0;
+       const char *flag = getenv("TWARN_IF_NO_KCONFIG");
+
+       if (flag && !strcmp(flag,"y"))
+               kconfig_flag = 'y';

         FILE *fp = open_kconfig();
-       if (!fp)
+       if (!fp) {
+               if (kconfig_flag == 'y') {
+                       tst_res(TWARN, "Cannot parse kernel .config");
+                       return 1;
+               }
                 tst_brk(TBROK, "Cannot parse kernel .config");
-
+       }
         while (fgets(line, sizeof(line), fp)) {
                 if (kconfig_parse_line(line, vars, vars_len))
                         vars_found++;
@@ -198,6 +210,7 @@ void tst_kconfig_read(struct tst_kconfig_var vars[], 
size_t vars_len)

  exit:
         close_kconfig(fp);
+       return 0;
  }

  static size_t array_len(const char *const kconfigs[])
@@ -504,7 +517,9 @@ int tst_kconfig_check(const char *const kconfigs[])

         var_cnt = populate_vars(exprs, expr_cnt, vars);

-       tst_kconfig_read(vars, var_cnt);
+       ret = tst_kconfig_read(vars, var_cnt);
+       if (ret)
+               return kconfig_flag == 'y' ? 0 : 1;



>
> More notes about this variable also below.
>
> BTW github actions have probably kernel config on expected place, which means
> that most of the new tests TCONF, but tst_check_kconfig05.sh TFAIL.
I guess we can export the  KCONFIG_PATH to solve this problem. But I 
don't know the expected place on github actions.
>
> tst_rhost_run 1 TCONF: veth(null)      0  TWARN  :  /__w/ltp/ltp/lib/tst_kernel.c:110: expected file /lib/modules/5.11.0-1022-azure/modules.dep does not exist or not a file
> 320
> (null)      0  TWARN  :  /__w/ltp/ltp/lib/tst_kernel.c:110: expected file /lib/modules/5.11.0-1022-azure/modules.builtin does not exist or not a file driver not available
>
>> +use TWRAN and continue to run test.
>> +
>> +Now, we support the length of kconfig list is 10.
> Why 10? Cyril suggested that in PR, where he suggested to use separated
> variables:
> https://github.com/linux-test-project/ltp/issues/891#issuecomment-989712350
>
> But for string used like array there is no performance limitation, thus I'd use
> something like 50 or 100. Because for certain IMA tests there are at least 6
> kconfig requirements, thus>  10 could be hit.
If case needs more than 10 kconfigs, we can use & ie
"CONFIG_EX4_FS & CONFIG_XFS_FS & CONFIG_QUOTAL_FS, CONFIG_PROC_FS..."
>
> ...
>> diff --git a/lib/newlib_tests/shell/tst_check_kconfig01.sh b/lib/newlib_tests/shell/tst_check_kconfig01.sh
>> new file mode 100755
>> index 000000000..dc09b6092
>> --- /dev/null
>> +++ b/lib/newlib_tests/shell/tst_check_kconfig01.sh
>> @@ -0,0 +1,26 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
>> +
>> +TST_TESTFUNC=do_test
>> +TST_NEEDS_CMDS="tst_check_kconfigs"
>> +TST_NEEDS_KCONFIGS="CONFIG_GENERIC_IRQ_PROBE=y,
>> +CONFIG_GENERIC_IRQ_SHOW=y,
>> +CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y,
>> +CONFIG_GENERIC_PENDING_IRQ=y,
>> +CONFIG_GENERIC_IRQ_MIGRATION=y,
>> +CONFIG_IRQ_DOMAIN=y,
>> +CONFIG_IRQ_DOMAIN_HIERARCHY=y,
>> +CONFIG_GENERIC_MSI_IRQ=y,
>> +CONFIG_GENERIC_MSI_IRQ_DOMAIN=y,
>> +CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y,
>> +CONFIG_GENERIC_IRQ_RESERVATION_MODE=y"
>> +
>> +. tst_test.sh
>> +
>> +do_test()
>> +{
>> +	tst_res TFAIL "Kconfig api only supports 10 kernel kconfigs!"
> s/api/API
OK
>
> ...
>> +++ b/lib/newlib_tests/shell/tst_check_kconfig05.sh
>> @@ -0,0 +1,26 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
>> +
>> +TST_TESTFUNC=do_test
>> +TST_NEEDS_CMDS="tst_check_kconfigs"
>> +. tst_test.sh
>> +
>> +do_test()
>> +{
>> +	tst_check_kconfigs "CONFIG_EXT4_FS"
>> +	if [ $? -eq 0 ]; then
>> +		tst_res TPASS "kernel .config has CONFIG_EXT4_fs."
> nit: I'd also remove dot at the end (we don't use it in tests).
OK
>
>> +	else
>> +		tst_res TFAIL "kerenl .config doesn't have CONFIG_EXT4_FS."
> s/kerenl/kernel/
Sorry.
>> +	fi
>> +
>> +	tst_check_kconfigs "CONFIG_EXT4"
>> +	if [ $? -eq 0 ]; then
>> +		tst_res TFAIL "kernel .config has CONFIG_EXT4."
>> +	else
>> +		tst_res TPASS "kernel .config doesn't have CONFIG_EXT4."
>> +	fi
>> +}
>> +
>> +tst_run
>> diff --git a/lib/newlib_tests/shell/tst_check_kconfig06.sh b/lib/newlib_tests/shell/tst_check_kconfig06.sh
>> new file mode 100755
>> index 000000000..6a6d68fd7
>> --- /dev/null
>> +++ b/lib/newlib_tests/shell/tst_check_kconfig06.sh
>> @@ -0,0 +1,17 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
>> +
>> +TST_TESTFUNC=do_test
>> +TST_NEEDS_CMDS="tst_check_kconfigs"
>> +TST_NEEDS_KCONFIGS="CONFIG_EXT4"
>> +TST_TCONF_IF_KCONFIG=0
> IMHO in shell is better to have empty value for "false", not zero.
> Also, we use it that way for shell variables.
>
OK
> But that would mean you'd have to allow to be empty, i.e. use : instead of :-:
> +TST_TCONF_IF_KCONFIG="${TST_TCONF_IF_KCONFIG:-1}"
> -TST_TCONF_IF_KCONFIG="${TST_TCONF_IF_KCONFIG:1}"
>
> But maybe it'd be better to have variable which is off by default (thus variable
> with reverse meaning).
OK
>
> ...
>> +++ b/testcases/lib/tst_check_kconfigs.c
>> @@ -0,0 +1,17 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/* Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.*/
>> +
>> +#include<stdio.h>
>> +#include "tst_kconfig.h"
>> +
>> +int main(int argc, const char *argv[])
>> +{
>> +	if (argc<  2) {
>> +		fprintf(stderr, "Please provide kernel kconfig list\n");
>> +		return 1;
>> +	}
>> +
>> +	if (tst_kconfig_check(argv+1))
>> +		return 1;
> nit: I'd add space here (readability).
>> +	return 0;
>> +}
>> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
>> index 2556b28f5..c8134692e 100644
> ...
>
>> --- a/testcases/lib/tst_test.sh
>> +	tst_check_kconfigs $kconfig1 $kconfig2 $kconfig3 $kconfig4 $kconfig5 $kconfig6\
>> +			$kconfig7 $kconfig8 $kconfig9 $kconfig10
>> +	if [ $? -ne 0 ]; then
>> +		if [ $TST_TCONF_IF_KCONFIG -eq 1 ]; then
>> +			tst_brk TCONF "kconfig not available"
>
>> +		else
>> +			tst_res TWARN "kconfig not available"
> This is quite strong: either test "fails" due TWARN non-zero exit code or it's
> skipped. I'd prefer to have user variable for systems which are properly
> configured (user will make sure all kconfig options are set), but it's just
> missing kconfig due system configuration.
I plan to fix the variable usage for non-found kconfig path/file instead 
of kconfig list.

Best Regards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
