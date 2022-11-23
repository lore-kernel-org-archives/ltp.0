Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D466AC433FE
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 05:38:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F1E13CC9FB
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 06:38:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF7893CC9D4
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 06:38:26 +0100 (CET)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E8EA600067
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 06:38:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1669181906; x=1700717906;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8smPOZviJSaKl3ENCku/QGER4F5MWTQduXOp4n6pGxE=;
 b=f1zqH+GwvAjVr3WDHaoCzRWzNHu2Ofp9FJsH8xpCLt8DtrC1uS/0bV8+
 gMH3Gjscn+dhMoS4j1Gekzg9KK/0XnmnrlTOXdAOt708MUEwYL8ua1rtE
 57g/6HYApba3CoHNmYzloRBFGyibXB91lmm/NfXkarqQ2E6dwzx/D+mHq
 JuMdZBD6h7DnHi36R4hzVq6xjog6x2pECb7qWuth+ghvteQ2DAuMlAkDD
 BjYhp42Z1msSlXFftOkBI38hquRSw9h2yR1HlHUhrMS9FLqRTqhuuI5T0
 3Z6ZuxNxW00HFLWp3l+YWrLeHBxBqTygxS4WWt6/S3HtxWn4ep4RQIUH6 w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="70698437"
X-IronPort-AV: E=Sophos;i="5.96,186,1665414000"; d="scan'208";a="70698437"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2022 14:38:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQrYmOtYYl+AD7pgJ1FIWjcpCw5fWnVaE+1yNvvKTzEwFIl44LjOOhhPrtwAVjECSIBj9JW9it3/xFiVwKpHif7XKMJr1GnNhLV19LrInrP9mfMqlj181amsYsBnTZ1NzH+21zfHyCMXvphU2nqOjIcifg4Ok2ct1uZB+XVLUYsc07St6oXLvPlHidd1oI8z8Ipld4gWl1EUPK3oYvuVF+pIKjpUy3DuwBiekzFXFVm/oF9u4pyuE4LaNvOkq2RobckqLkD03pwcrzmAUreXtIbsapQIPJYW5jbQsp3RCyN8ZtW7oRVmj6nsZArlxIuRVfokfzqKYwsqeQZ8H+1jDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8smPOZviJSaKl3ENCku/QGER4F5MWTQduXOp4n6pGxE=;
 b=c5XKArW5PKSNxhED8LkRlaubcFdxhPGk9SIAR0Savg40Seeqv1Wq6r1cM8h/ImGGL+u2C2aw2+AQwiTG6Fg1O3/y2w4X2WWL4yvpjOJusXKjMDP5wZZLN9q6VlAXUaSZm8x2zIYuaUEetgTy4upKD4kC4ZYEWy3qhfXwQaXkjZfdqv6WK6kYg09og2WIcqSw06sYuDou1NPwbTUVAJxj4D64QuOsOlMbHQBwL2I5d23ot2N2KolNLq8LjGoGm1c2+c0mFKuQtuOyrE0JEcPvMWiTC5QICpmVOQz5ReU1QnxWlcnYy6U9ICUVfFJvBzoIEilSwJ4zkZS/aImuCFp7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYCPR01MB9892.jpnprd01.prod.outlook.com (2603:1096:400:20e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 05:38:19 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5%6]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 05:38:19 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: He Zhe <zhe.he@windriver.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v3] syscalls/prctl04: Fix false positive report when
 SECCOMP_MODE_FILTER is not supported
Thread-Index: AQHY/koeuMep6QKnJkOD79eDGBLTY65MEBIA
Date: Wed, 23 Nov 2022 05:38:19 +0000
Message-ID: <9ab63923-591d-f6ac-ffc1-d70ed179415a@fujitsu.com>
References: <20221122081142.2433326-1-zhe.he@windriver.com>
In-Reply-To: <20221122081142.2433326-1-zhe.he@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYCPR01MB9892:EE_
x-ms-office365-filtering-correlation-id: 5acee8d2-4609-4012-6c22-08dacd14ed87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8RvnbKvqYRk/YxpAC3+D+kLFAfEJq/OJwq4+q0nglQGIPk4lngPMSXbnYI5qr0c9eFi+DPk0CtsvCbTjWtFkSbwNheW+jprRyoAjkHwdsudOIUOctTDQ7xwCsQi63LqQ5dGM0PSgSCpGCqQHZTznVh7ZhfcTWv3vkhOR9iN0predefyMMlbL/09e9/jU6nphV5U4DXOXJzbCocJDuQVDGi8mZBM1BhW85YOgsnSt+Cgyzi1epO05A35PT1C0rZHI+7iYQHzx0TsZ8/dxrYhkgilQHxbGeYSg8BrpZ20Of+aQR6RYReRZALNOkKKyxhrwyGOxizyPzrl6HJuPRqlcqCM+5xMcgIVcQHhogC9Z+x6z+LsXzIKHJlhxS/CjL48Z25DnaU4bnDfBYOfAS3ew13KUK+RygcNfvXpQNfkPC3sGiuoNcPF/wN6YhDAVwQbtxIGReuctzvnYxcmSoYQ6YLzyuO98JQfxz6o7Jp7g5ddw6Kc335Z92gqhbqnhr2NrmkcagCIuzaTOwMFV0H8W/DFoCjhvE1hD/I54QZfmcG1+ka5UUXQ2XYXviQgwqlz4Nnd8Oqxra+p0FAmijpjEOGbKx5L9JciQrlV9THVEha5XokuxVh3d3WywjQKdHzvJTnWi2JVUNP+LNN+s4Nghght5PLmp96z1Npr5TX5rIauEaLX1VCK1CWbR8KCaoHHWMZus/pqjgI42DR0fJtikYcx+6w6+vAaxvGEUYv/tJ9MBMo+cpHDvdVxfr53T8xJwWT9eV7oZj4ogo7dH1APCxn9gM4FqH9M5GUtv6TiJJuA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(1590799012)(1580799009)(85182001)(31686004)(36756003)(31696002)(122000001)(86362001)(26005)(38100700002)(82960400001)(38070700005)(2616005)(186003)(2906002)(6512007)(83380400001)(110136005)(8936002)(5660300002)(6486002)(478600001)(6506007)(71200400001)(66556008)(966005)(41300700001)(66476007)(8676002)(316002)(76116006)(66946007)(64756008)(4326008)(66446008)(91956017)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDJUOXRxVjd2aDI0RGRtV2NRSHMvOUNvZldPT1p1QmNZT1JlT0RYWFRtMzh2?=
 =?utf-8?B?bkFZTFA0RDVNeWJDaktVM3AvMUpRanp3amJVamIyT3lrV3NOWno0YnA4ZUZk?=
 =?utf-8?B?OFY1bXp1cWQ4WkxrRHUwQ2lpelJVMjQwdlEvVzB2cG8waWI3cnVsZVRyMC9j?=
 =?utf-8?B?OHZWdmZxWjF1RmF1UzA5K0pBSGxibFRMRGpqY3R2K1hRNGVzVjlTYTAvU2s3?=
 =?utf-8?B?S01JaWpmMEd4cWc5blo3V0U1T3JJSVdqbVQ5WXhpZFJrR1hGamZ6NVFhSkhu?=
 =?utf-8?B?YmlqTUN2eStaS1Y1Y0ZMdUMya2RYRVhhUVczRFUrTWxHWFRxWFNXN2NFRi8v?=
 =?utf-8?B?UzEwWTZrOXRyVFV1cktrTU9SbGtSRE05UTlGZitSNXN4bnB4bWJpSjBnV0th?=
 =?utf-8?B?ZTZIT00zUFE3eGlyQXJCN1hxQ3NGWWQ1M1FXVHNtSlB2WllZVlVKLzBvNlJL?=
 =?utf-8?B?dlM4YWEzOHhRVVVpd09MYkQveVRTVU9RWXB4SFVWWDE1aUNydGlJOTRCaWtm?=
 =?utf-8?B?OVN3WW8yZDFCa2czV0VRRFB6R1U0TkJPa29LV3BVdG9HWVJwMEJJa0ZaZ3Fo?=
 =?utf-8?B?KzVFU3lnKzUyTDltM1NPTCtnVG5LTGRmdlVCazNlbGR6UTEzZDBKM3ErbU5W?=
 =?utf-8?B?Y1Z6Y280d3pMcHg4R3ZQZXdtWUdrb3JmL1l5NnRQeVhxSUVRNEx3N1FKY2xu?=
 =?utf-8?B?Y2NBQjUxd0VJekVkckd2dk15RzFwR1poT3pPczJEUHBkbWpXTzRQUitLYVUr?=
 =?utf-8?B?OUNxeUl1emg5ZElwbDZtbkxUcUhkV0pWRSs4aExFMHdRWGVhVERjUEZzSW9L?=
 =?utf-8?B?YW84WTBpOHFLQ2g2UmpCSloxZGpDbkMvVUtoMjhHMVdQTW1kTjFySHNvdlp5?=
 =?utf-8?B?aWkvR3ZNZm5xcDZ2NndmUDBRY0UvL1hqSTZMY2RsU2JWTkdZVExEcVU1Rktz?=
 =?utf-8?B?WXc0alU1QmIvY0ZGY05nMGxud3JXMlU2YVFiUG9GUC8rRXYxQ1hDYW9KeE9t?=
 =?utf-8?B?YWpZNTM3K29JTUFQTy84c0ZVZHZVd2FrTUVQVkVxQm9qVE14OFphMGs1ZVpU?=
 =?utf-8?B?T2o2bTRiUDhYcmg5SXB3V00vWmE4cmNPK09tRkxhbzExVEtUcFFjanhnN2xB?=
 =?utf-8?B?eHNYWEkvUndqMkdHekgvdWUzYWtXdFQxV3dSM3J6dG8waExEUUpTdS95WFB6?=
 =?utf-8?B?NEV3SG0zYmR6UGduL1ZoYis4L2RiZEMydFM2RkVQck04Y2w3aWM5c29QOXVQ?=
 =?utf-8?B?TXh3TXYrNGh5blhpRVQ0TmZrbnNadnFTbVUyelM5dHVUMm9pWFBUb3lGOWRD?=
 =?utf-8?B?QUtoZ0ZDdnJiY0JKSmcyY2M5QXZSQVFKazQ3TXlaYzN3aDdQdjJKdStxUUxI?=
 =?utf-8?B?NE5ocitFc0taNEJIL2NWSFBSWlp1RVR3M0VkU3BNVFh1cXFncEQrOEVTTVNo?=
 =?utf-8?B?RzJ0TFJPMVVTZXFoRHdacmt6QnBjNWVqU0J3aHlsa1JkV2lQYXFZM2wvMWNY?=
 =?utf-8?B?SDFaMjV4MmlBUE5nZUFXQWRkeC85ZUg2cmo2Rzc3NTdldC91T25pNEduSlFp?=
 =?utf-8?B?V1NENmswVDJBeEgzNkJYdTVuQzBwTzRLV3dLNUxhU1hEV3ZLWFdhTE9ybitQ?=
 =?utf-8?B?UTFVemwwYlZyWU5pWDQ1WUh5V0VzYnpMY3YrNHNaa1lpeXdGY2hxNGlYdVpl?=
 =?utf-8?B?SldoMlJlYzhDeDNNUTZFTUk2ZEZQQ25WSGZ4WTZMS24xeCtzVTZCaUtYL1h0?=
 =?utf-8?B?U0MxSzdxd1JEbXBqdmV1UVBLTGhodEJrb3JobGVkY1pZR2wzL0plNXllWGJ0?=
 =?utf-8?B?aVJFVjdodjM1VGdlLzJxUVV6RFpXd3hRZk1nZkNDMnM3MXNuSmJ1RVJJb3Rm?=
 =?utf-8?B?SGx5eTBpYXBCc1F0azVRT3IzR3ZreUUvZHBWc0hJdEdldWxCYnk3QzJPQkVu?=
 =?utf-8?B?WEd5bW1xQkpvUXU5YlczaDZYTG1XbDM4WjdYVjduMW1lSEQ1SDhwUklRYVh6?=
 =?utf-8?B?Y2tjcytSOVJ6d0hMemVQUFdKRUxXYzhqU3haOXB3VmhVdk5GWUhUb3VUWVJJ?=
 =?utf-8?B?VjkvUjNDenpFOGFEN3pnc3FnYUFJN1hqZ1ZPZXVPUGFVQlFyOUdvaHBlNlNT?=
 =?utf-8?B?ckVGclM2M0tLVEZUR2xjRFlIVktQRVFXZldZSFZPendpaDh1SWVvbk95dGlh?=
 =?utf-8?B?R3c9PQ==?=
Content-ID: <CF5C07B24741114C8D09DE1C52CA06F9@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bgF8joJnsw5w1DkggCO2LeX+ygvBi3+jtXb1g3CpkIlEFb2smfBoa7ny2coOfsuZVafbQr6y1jO2DLFyuQimZvIUAamVGMHne8AM2NdDvWFw24a8IH1dkqnE7RAVEMntWuaUhDtFRRqe8kFg9zfY/chQmCatm0zD6dkwpElTYzqr9EyaQJD12nfZwgQJSlxSURlQUpHTt8Jr4OlQQqEcgRl7Edeoxj6zcSE8wrzmnlA+ZgCbZ+ZqI9Zk1FByB27dWjs83iE12C3/o5sfl3QgBnrT13HWo4RmCF4uEIVYY7vLSyLGrtmnnNcnysmFZ+n5n3zK5Fii/27We8lg710dMYVPIkk3DKGRMIpLBqCghrIvJFhH3gF/mkcj7KL8s0Spf076QYOt7Ud+/Y3GLJCLQAkydadUbhhmGVAPDvW/nSzz2+L0TbyPSZeEhQGp1+MyiKCT+e9T2HFgQlcxLcHCZgMHEwLtqKgmLLSOh8PoHRxaDf/5450DMWaixif/S4xQDDwhQOYprrJjMUgMf8dwOFKhyvV/0qAcgKBrehyQ+Jk+dEm0ottf4AaDZqtisH1Tq3M1I6MGs2Uv30/StbNqarHMwP+PE1GcYseRuLYU5X1Ej6d2d4tfF3Vy7aTz0YRuRHHdZiv6ulpMEgcsoWmfcNbRx0r0ddXVN7GngTjkAIzkGA2pZprRFBDeoejC6NGKwGub9iCWicJ/3Z0f153MjecEy+FjqfpHGcH4JsKCdHojj18jioYRBdAkgEW42zgRgvuc47o228+17R1TNtEfuh7l/DorHEzG6pv24dd1LO4FJyaIDUGhqyyw3QJRlwcXJd+fSXmOXl8Is6kvEUNofQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acee8d2-4609-4012-6c22-08dacd14ed87
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 05:38:19.3836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nk+CxBb5a7A8Hgv6ksBUNI5bTnkD6mU5d+7IhLih16GRzfbYwVt9oUmfhu079nxmDrGyV5fCdatZpny/4Kr7W2pRNEwc5uWqjttfbw99h7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9892
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/prctl04: Fix false positive report
 when SECCOMP_MODE_FILTER is not supported
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

Hi He

> The child process really should not receive the expected siganl, SIGSYS, when
> kernel doesn't support SECCOMP_MODE_FILTER.
I still feel confused, so which subtestcase has problem since we have do 
check whether support SECCOMP_MODE_FILTER in check_filter_mode.
> 
> This patch tests if SECCOMP_MODE_FILTER is supported in setup and adds a
> variable to record it.
> 
> Before this patch:
> root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
> tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
> ---- snip ----
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:204: TFAIL: SECCOMP_MODE_FILTER permits exit() unexpectedly
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> 
> After this patch:
> root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
> tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
> ---- snip ----
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER


The line 154 and 204 is refer to origin case[1], so do you use the 
lastest ltp?

[1] 
https://github.com/linux-test-project/ltp/commit/3ddc217d7b466f16782c257e29e18b251969edec#diff-6ae2f0e9ae152457424103cc20b7885e242f33f58b2e543b7941671f418d9485R154

Best Regards
Yang Xu
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v2: Add a variable to record the support status instead of exit(1)
> v3: Move mode_filter_not_supported check a bit upper to save a prctl call
> 
>   testcases/kernel/syscalls/prctl/prctl04.c | 30 +++++++++++++++++------
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
> index b9f4c2a10..d3de4b0d6 100644
> --- a/testcases/kernel/syscalls/prctl/prctl04.c
> +++ b/testcases/kernel/syscalls/prctl/prctl04.c
> @@ -93,6 +93,9 @@ static struct tcase {
>   	"SECCOMP_MODE_FILTER doesn't permit exit()"}
>   };
>   
> +
> +static int mode_filter_not_supported;
> +
>   static void check_filter_mode_inherit(void)
>   {
>   	int childpid;
> @@ -154,16 +157,17 @@ static void check_filter_mode(int val)
>   {
>   	int fd;
>   
> +	if (mode_filter_not_supported == 1) {
> +		tst_res(TCONF, "kernel doesn't support SECCOMP_MODE_FILTER");
> +		return;
> +	}
> +
>   	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0666);
>   
>   	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &strict));
>   	if (TST_RET == -1) {
> -		if (TST_ERR == EINVAL)
> -			tst_res(TCONF,
> -				"kernel doesn't support SECCOMP_MODE_FILTER");
> -		else
> -			tst_res(TFAIL | TERRNO,
> -				"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
> +		tst_res(TFAIL | TERRNO,
> +			"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
>   		return;
>   	}
>   
> @@ -208,7 +212,7 @@ static void verify_prctl(unsigned int n)
>   			return;
>   		}
>   
> -		if (tc->pass_flag == 2)
> +		if (mode_filter_not_supported == 0 && tc->pass_flag == 2)
>   			tst_res(TFAIL,
>   				"SECCOMP_MODE_FILTER permits exit() unexpectedly");
>   	}
> @@ -218,7 +222,17 @@ static void setup(void)
>   {
>   	TEST(prctl(PR_GET_SECCOMP));
>   	if (TST_RET == 0) {
> -		tst_res(TINFO, "kernel support PR_GET/SET_SECCOMP");
> +		tst_res(TINFO, "kernel supports PR_GET/SET_SECCOMP");
> +
> +		TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, NULL));
> +		if (TST_RET == -1)
> +			if (TST_ERR == EINVAL) {
> +				mode_filter_not_supported = 1;
> +				return;
> +			}
> +
> +		tst_res(TINFO, "kernel supports SECCOMP_MODE_FILTER");
> +
>   		return;
>   	}
>   

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
