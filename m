Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D7DEB64DC
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 10:42:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE86F3CEB7B
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 12:42:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54E9F3C2DC8
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 12:42:30 +0200 (CEST)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9E7092001CB
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 12:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1689590550; x=1721126550;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=5aH/Cx/MFBNTnj/07iSfTteQSAkzv+iwaSbj2y3etaE=;
 b=j+/ihxAd0b790jdEijL791TNB/kemPfZhY+Hsk1SMHSZC9mjBMoP4mfn
 0TaFbxFR23daRmDQPGtaAJKiFvE3FUdD15H74pxcqukyYFo+3/grlFJ32
 93IyFuxkK5iKir5cj8MAdG4kQ+CELv3sSvpWiZvhmHO0hUgP3Gby89Q0J
 zMCQ2oGcOD05FfaSHdHkOqJnihs8LuE9qW7Kc2jMSiwECnMyyKvWoEeWv
 pr0ZTUOEXb36V6PEnYRhDGVvbnx8RxdCQUK23Ykfr9ZGujLeM3GPTURLs
 o4xs3oOx76/Etc0OQrRooSskodswoCEIj1FrEHGZgQ4+kPB9jKVrW6OYm Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="89908912"
X-IronPort-AV: E=Sophos;i="5.98,286,1673881200"; d="scan'208";a="89908912"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2023 19:42:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcURvbw3w0OxBQVJVpTAhWF16fWwSAmnigRmxNsvdTysEyZ99Vv8viGTDcN2BqzmLcb38lFD7UgdQ9c0nK7skcI1HMD0xr6CVWWCxWBFJDZmyZBm/fEpH6HoUJlp0OCc17Jg46KdqepnLhfTWQjOIY0+K+kn2jp7dIilq2f9Ul2gT8JuQHUIO7nNeZJ8qr4KMpXUXfPhMps21Vb2Wt3K6GI31/LAghlvWwku9fLZH9jpa3sT75tIZ8CGYh+OKyZpBp+QbiagV2MjEaVIsD9635QK0/BZ+votvA9gGMKtllOGoPkVV5iM4jAz45gD8M5BTC4+EW5iNShePkmuCkO7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aH/Cx/MFBNTnj/07iSfTteQSAkzv+iwaSbj2y3etaE=;
 b=YJKRE8PlTNxyHTyjU/F9rD8wvgq7E3DIJ75R1c6m9zl3BqstlYhfoNMAhKXSGvBSrAyVJo1pQ3Rso9OJIRmMI+1DxaX3ew64MEcYbayTrbhfsHjU6ak6g3KUcLLbXOdO//C/3oVqyUF3GMb5FWnbxLZgmRLj7lWY9C3N7ojEExmZbfZS/5PSuo9H65j75agmAP53UGZOrfHC0n807ZX83FvA+IoWjtmepsbI5kucVxxHMmAfCKs6odD8CemjABMmmzPT0IcYrct0UNSvCAz0zKUWi961vsxGTLU0pN+6slj9CuT04IbCienE0hHN4DlJHcm55pB/i0s8qwmkpMtoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by OS0PR01MB6148.jpnprd01.prod.outlook.com (2603:1096:604:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 10:42:24 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::cab0:8eee:f77c:2d5a]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::cab0:8eee:f77c:2d5a%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 10:42:24 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2 2/2] syscalls/geteuid02: Convert into new api
Thread-Index: AQHZr/F769iwEuzPuEWcz3Amv2DFx6+uA28AgAdmVACACG0VAA==
Date: Mon, 17 Jul 2023 10:42:23 +0000
Message-ID: <4ede938a-64f1-33aa-f4ba-5c88dade0371@fujitsu.com>
References: <1688637954-17765-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1688637954-17765-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230707090148.GC571797@pevik>
 <11e524a2-c775-b68e-aa05-29b50fe6e38b@fujitsu.com>
In-Reply-To: <11e524a2-c775-b68e-aa05-29b50fe6e38b@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|OS0PR01MB6148:EE_
x-ms-office365-filtering-correlation-id: 01743602-7c6f-423b-91ce-08db86b2819d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AFAR31YBWbVIAI6RXwlfDb9BM2/j3+gr7Sl6HzyC7UYzJLHwlN1w9Q7JnCgZF4t0x+vcCmdFY8mFSVaUbSKttLwDwRZlnZHbWPPe4IXd4CiQ1/goA6z/xfCHU9JI1AFfz9/5vDP3xVutlS5G6x+RjhbG4Syu9jMQij96Sfj3+VpU2RJWb74QnxV/Qr1w2tfEkc30z1pii+sP7Fs6X6me2QlhmxT+HBaHWulrqJeLIncimNK+W08iVfKUcIcZO8iaV41IayvDYNbrPJAPdmAFR/SXN37G1lltg7H/RL7/SVv1PxsqbMC+DLbhA4Wv0GmKEx5UnSF+IszKQzEkVOBhzkSeoSaSmpMLEkx45uVA5CDTpc1UQfN+Fu42YSsqcttLcsCWLsIyMBuV0E0UFVw+c8K4dPRqbSZLQY5lgX+Gp7Rugfd8EYQia+VaUC1xfn7Hvl8bn8U4mmpTOXg1KkV18QGH41VE+cuJMbvgeJ7yBH9UKpczzR2VAZYTWsDUyM3OYM0ZbjFbwwcJ1ORjwgwFVf0yMw9SO41k3FFlQwFQhKayVNo3QbgVcp0hFarvGQFlaIEzLLYprPaydY75O55yEEMfe+MxCjqswHj0TuD6G8CfimFjlh7m36GancGOuRORNH8E1kZvuZmtGMOWuBwfybALZADW7vyxfctDGoRb24U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(1590799018)(451199021)(83380400001)(38100700002)(38070700005)(31696002)(86362001)(82960400001)(31686004)(122000001)(316002)(6916009)(8676002)(2906002)(8936002)(41300700001)(5660300002)(4326008)(66556008)(66476007)(66946007)(76116006)(66446008)(64756008)(91956017)(478600001)(6512007)(71200400001)(6486002)(36756003)(966005)(85182001)(2616005)(1580799015)(26005)(186003)(6506007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTlOeHpBL2FoaldKdkhNeDh5SVVBSGVnWUZoaHBKNTFmVWQxWjErL1hmTjRR?=
 =?utf-8?B?L1J0cEhRK2pNajZuR1gzdFBmUlVtbWNibXJ0ZkRQMjFqY25zaGh1UEhsTjQ1?=
 =?utf-8?B?TzErcEJORGlUWVgzRVMzbm9nTlorNGRCbkhZd1ZIK2ZvRVhhRFVtMnlMbnll?=
 =?utf-8?B?S1JXblBtOGxkTkhqbFgrQVVweGhRTytGSnd0d3UxRU9iYVBHYXlXRXFtV2w0?=
 =?utf-8?B?VTFLZkpuYmJidVJoN2tVL1BENkZHRmpoUlBmZlpKWlgzakZFVVFmaTczcGk5?=
 =?utf-8?B?U1BmOU8xd3lpcHZUOW9sb1NQVURyelRHSFVPZkxNSnBYRjBCb1phMkl4aE8z?=
 =?utf-8?B?NG81M0NLYjVya0Y3OVRuTm1ycXEzU09MWForVFB4NTljQkhlaGlwT3pyaFlH?=
 =?utf-8?B?cTZaVTF6VldKM000SXJKWUlFL3pJSWR6Wjc5UWdNZEZpTy9QWGVUMGxJQXpT?=
 =?utf-8?B?SkJGWjdaVmtXenBEclFrVXBWbXZFVnV6QkdkbElIZG5Ed1Z5QnE4WU9pRlJ5?=
 =?utf-8?B?SmtraWFpVjJuTXZ1RFNTTnFyeVVuQ0FqTmg3cGpXaU14K1ZEdS9XSWRCRURC?=
 =?utf-8?B?TkpBVDh4L2VXVzA1NitXeTFNYy85ajRQYnd2cU1NUlBaK2p0M2w5aDZIWktC?=
 =?utf-8?B?REFnWFhxQVVDbXpHZjRqc2dQWFJGL2NJN2REcWNveTFhcnZjelRxYTBrbHVS?=
 =?utf-8?B?SGh3ZWFZcGM0RVFnM21IRXhpVGRTNUpoMmhXQVBRWHVMNVVwUDlEUnhWaDhJ?=
 =?utf-8?B?S3JCZ09aNDU3WHh1Y0tHNFFMU3ZYMUx6SWt6QmxMSFFhNGJtRmFtUGlrTUIz?=
 =?utf-8?B?KzdyVGlUOEdGdC9jZHlqbDFDZnlOTVRHS1JkcEdkcjVvNUdFZkFJa0g2bWUw?=
 =?utf-8?B?cytRN21LQmh2aUw0djlzcDF4U1BXSVArc3h4ZGxSUGk1K3ZJVW15RnIzdEY1?=
 =?utf-8?B?VW1xZnE2TUl3enJlNjJxV3NGbWluZk1LMzdCZ1ZqQ013ZEhDY3RwWjg5cjRG?=
 =?utf-8?B?eW01NWRLZFdjRE4wQ0tEYUJ1NkVrWEhmWU9CN013Uk1zRDFQWW83UURvWXI1?=
 =?utf-8?B?Y3RvOFpjNlY4a041RExEYTBHbFZPWFJUN05tbS93MG1IVktpOGtUYmNHWWM0?=
 =?utf-8?B?TlBxNHlNZFhic2pZRDJNN0NzUUpXQTJTSHpmVVVReTNXMlZvUm9mOTVJVU9p?=
 =?utf-8?B?aW13RThLYnIreUp3SnRMWEgvTThmUkNWb0U3QkNETTNablNaa3FxVEFXaDRU?=
 =?utf-8?B?dnBtTDl4MFpuVjFxTkpYVUU1UFNMM0RaTjJMQ215eHBBa3Z6MWZMbzRPRjhR?=
 =?utf-8?B?NHp4UmtER0NuclpNSlhDTGx2UkZUVGNLTlRnbnY2eDBVY0pwL0hZNUN0Z2Nw?=
 =?utf-8?B?Mlg4ditHdVVIWmM0WjlwR28zSE1BVXBQbS8wYjRHZC9tc3JJR3NOdE1ucmR6?=
 =?utf-8?B?c1NnTHRTLzFRa3pXV3dHSTg1N0tydHA0d29GUDdKeHJlc0xKcXJicTR1VVFv?=
 =?utf-8?B?VHU3VFAzS2dUMW14ZDZwc1krc083N2c3S0wzS016b2habjBNaXNaVjczYXZR?=
 =?utf-8?B?czIzcFdjdG8rdm41alZsTllSTC9QNExRaUxGSldpRHAwMU9JalhzNTNzbGJ4?=
 =?utf-8?B?Y05Kd0VNb01TUlhibFVVQnlSUFJiTGNqNm9IazFLYXl1RFprcUYrT3FNdHA0?=
 =?utf-8?B?eit5KyszQjdGL2JIWDliTy9YT3hoZk5PL3ZQMTYvL2VQcFJPZ1FVTW5HcUNN?=
 =?utf-8?B?VEVMOUlHR3FFRURYRlpmcldwN0tTa1NzaUFVdWhBZ3l4cmF3R0kxT2I3MkNy?=
 =?utf-8?B?a25SZ0RJaVJGQXNUWUI3Y1F1MTkrdytlend4eWlpN2RPaUp4R1dFbi9sM2pL?=
 =?utf-8?B?dXdKdEZaMk15WlprMkI1OXRLTjZNdmNtYzB1VGtIQ0VtQURtMWtySkxxdjdY?=
 =?utf-8?B?MytFaDBxOEY3M3RCL0N3Yk1EZHZ1ZkhZdlY5RGtTSnp4b3ZKVk1oQlFlU1I1?=
 =?utf-8?B?UjZHaTYxbWdvNTBldExkNFdQMmJvaDRINVpEbExXblZoU0FINjdETjFTV0dr?=
 =?utf-8?B?QVlLalZvY3RtalNwd3FIRTR3dEI0WElicWtubXpHVlZXTnB4dW9tZ0l4Z3pO?=
 =?utf-8?B?MkxEbWQ2RFYybEVIYmdod1pnRFAyQTBHZGl0dlVRNXpnL0xCZ1dQWHJXNnd2?=
 =?utf-8?B?Wnc9PQ==?=
Content-ID: <BDF89CC8EA51F940BBB38F932355BE02@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S74BZusLUF1WCbB7cOQUoEpknWGBF9hOGhmqdfNEF/7p5uh3xjc6Z22YZG0KQ8y4drtkyOgLhvCJGM2n/3nHpnugpp5p5cPELAW4PzRAEkAetlFMXbeMLtBCecKzuYFMZVEwiYx6leYxr/PCl0hMB9/d3HF8NSNQxLU0vxZdhBLN6+s3RGtjuwR3xNJhXRaa9NOvAzJ+XPfbuBqIzx2OdwTne0jjMXQ351xxtAHHKCFIaPUArjTLA3TqzRq9s1MPcCrLBxN/mnndrTyTWm9tN6z57/C8mP50jiqdAwy9hAH2UE1A9xm4NvaabS0uoIZeX1wtYcmzOMd52qoX1bJWJliQZxTvahQuCbaQR7RSL/5BzaJ+Iekeg8QtcGLh+xNt09Cme+XJYT+l1THH6YF4Q6MdMLFfOn1gqKn7fCx8XCVxRV8OC16IZb6Vz0SwriuMm+jddRfEt4FeFgzH0sV5m3hhTb/GwWlxwXkUX83J4HeejorC89xg9JICyF3HnP3vz0zRVUqKlnwI9c1jx2igVa5VcbTDb8HUyXuYIBsCMCJBWZuZ/ym8CTC3IU6f6gSguLucqY/MUQ7W3Zvho2gChSNGS9OcziSvCxIu3Do6UI8KyDMc6BP4cbxTkc579Vl+3EXSIWs+zo9KbBqEFldcuGoJ0mfZ178DP1WQRZ8gHqZCweG2TiHb2PUqp/UgiSin0UMSpgCEYSSA/DYGqBnrOYvguIF0uWDADBLHqwjXtjvlZ7HNkVgF2PqadNZ3ZolzcVKkPwYSeN4DZI/aFJY49jSznNnpdf6PzmG/iUAK6o4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01743602-7c6f-423b-91ce-08db86b2819d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 10:42:23.9828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Sx8tRnr81GbXjk45zrsI2kSthoFEnx7DefCskEsn8iClciwAdCU1JccYtcH7jgrd3A8zGSpE7fYoBx0Av7Cop1qzzUO8t20UGB2t9TS6eU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6148
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/geteuid02: Convert into new api
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

Hi Petr,

Kindly ping,

This case references getuid03,
the URL for providing modification suggestions is as follows:
https://patchwork.ozlabs.org/project/ltp/patch/20211109085745.21531-2-tangmeng@uniontech.com/

Best Regards
Yang Xu

> Hi Petr,
> 
>> Hi Xu,
>>
>>> -		if (pwent == NULL)
>>> -			tst_resm(TFAIL | TERRNO, "getpwuid failed");
>>> -
>>> -		UID16_CHECK(pwent->pw_uid, geteuid, cleanup);
>> Don't we need to use UID16_CHECK()? In the new API version from
>> compat_tst_16.h
>>
>   >
> Previously, the EUID was obtained from the return value of getpwuid()
> and compared with the return value of geteuid() to check for a match.
> This approach seemed more like a test of getpwuid() rather than testing
> geteuid() itself.
> 
> EUID is stored in /proc/self/status, and we can directly obtain it for
> comparison with the return from geteuid().
> 
> Best Regards
> Yang Xu
> 
>> Kind regards,
>> Petr
>>
>>> -		if (pwent->pw_uid != TEST_RETURN)
>>> -			tst_resm(TFAIL, "getpwuid value, %d, "
>>> -				 "does not match geteuid "
>>> -				 "value, %ld", pwent->pw_uid,
>>> -				 TEST_RETURN);
>>> -		else
>>> -			tst_resm(TPASS, "values from geteuid "
>>> -				 "and getpwuid match");
>>> -	}
>> ...
>>> +	TST_EXP_EXPR(TST_RET == uid[1],
>>> +		     "geteuid() ret %ld == /proc/self/status EUID: %ld",
>>> +		     TST_RET, uid[1]);
>>>    }
>>
>>> +static struct tst_test test = {
>>> +	.test_all = verify_geteuid,
>>> +};
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
