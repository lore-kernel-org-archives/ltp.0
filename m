Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45B2C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 09:34:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E447C3C927A
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 10:34:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 054923C0B90
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 10:33:58 +0100 (CET)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5389F100136F
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 10:33:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1640165638; x=1671701638;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FGgimT82v3/7REb8qAw5y7fBaKiAB8G8IYJwu24pBaA=;
 b=MWbIiYIRgaMqOoKsvs5hyo04fTnl52AnP0cufsILDDJMIBqbmHDegCti
 olluqToTEVOUHLM6rNc/F6OYc2Wgmi2fkthkxdxxe5uea0ZUPUy6H63nT
 lYGsaSlWL0d/gCsMBbr5cH9eiGGWpsip1FLC95B8NMlA5zSOLi8LLrQmW
 VwU7j1bOKx/OUqxivGBNqiVFzbfs6VM/GVJ/dMwfOSPJPtzCjxGSKIypO
 h/hsmLH+N51kBDLBLOsy9MhDd+BN4EO+Up4tc1M5nRoUv3yLQwKcl6hmb
 WvFEy2qtg8/2htw0j+DANiM/idhusJJ3S7NWyIfIAVUCTsnTHjTQ20LCS w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="46586276"
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000"; d="scan'208";a="46586276"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2021 18:33:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ez85T+UrE+ePu3Vsd9B8qTVTjMGW2DY7JcImY1PwoxEs+JF0jSu/7bdV6tZSEQVwO5E8ZUSOxZ01jYoKSOzh8ZJe8lOv2RxeSgmlblcKdLS8zbdjufg/wNHvY/hM/dkpMaIgHMhe8rNFFkEDNupHSx9QGwXdw6/A/5PUPj96yIWcMEpfkZrgdv9lBrlu/9qFLqj8dZM1eT9Y1e/AaGjlY7i9UIgO5Qn/FotL+F6eH4TU0pxdbh4aH9d2AfXKoLPw+0dNzNmgke0SlsGBHGQqnSbusaG4gXyHRIRNBr05WCaTKSECIDFAbYzMJbYNQexqCHXhKdEy++OZ6J30ulKZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGgimT82v3/7REb8qAw5y7fBaKiAB8G8IYJwu24pBaA=;
 b=H0E3TsLQfOl+AARZm4zvfN1BhhI03/qdstfTa9qfwc8Ah1BJywJkyV9Pt9VN0KSTig0wFPTnHgITPQPbc5VodVQSTA4FtiKVWJLw4J+M6uhkqjhyUc+LaFoPo0vYAENrHPR2fqWMttVbWcjbqKCMIyxWHJHrxkskdZa5Akl7Nrk/v6nudjACfLk6IA/Ifb3RJKUUddx4q5IebvAeqdYPYsO64exu3MAec2rsKBYNCuJBmBsKQ24ohHr30V0eGrKu0mH0XH8u2AS2fsDc1Pgm6VyhovkRrGY5Rl6cKvnERRSFZd7PId6ws8qfJAIsweIqUZgbcedb1cq3mdBdAkaCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGgimT82v3/7REb8qAw5y7fBaKiAB8G8IYJwu24pBaA=;
 b=Dn6QW7iAHJs10TzZK+OXKop6A684/qDRuUpB75tLvT4KLHmXGJDf9Xh/Vd0huVciFD0UtCIU8v7krc5EEhEHNFhtkaz0qYW/YgVbpDIy3rzrhm8ZSdMWm8P1sXbaQJlopdDZVk+lxs1+kOPmxK1yoMJxRYsNFDhpbUhErxHNfXg=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY1PR01MB1770.jpnprd01.prod.outlook.com (2603:1096:403:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Wed, 22 Dec
 2021 09:33:52 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%8]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 09:33:52 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v5 4/4] zram/zram01.sh: replacing data stored in
 this disk with allocated for this disk
Thread-Index: AQHX9W40nQa467DKIkaQve8+nb3fJaw7M6kAgAEDlgCAAGrzgIABoROA
Date: Wed, 22 Dec 2021 09:33:52 +0000
Message-ID: <61C2F10F.9000901@fujitsu.com>
References: <1639983142-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639983142-2247-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <YcBfuCPg1ENZHvud@pevik> <61C1397A.1070904@fujitsu.com>
 <YcGTMcan0r2NOcR9@pevik>
In-Reply-To: <YcGTMcan0r2NOcR9@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 798535ab-d099-4352-239c-08d9c52e2a8f
x-ms-traffictypediagnostic: TY1PR01MB1770:EE_
x-microsoft-antispam-prvs: <TY1PR01MB17703CF0C0AB98C863AF2CDAFD7D9@TY1PR01MB1770.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tyYmQfiCnYqIMgUh+DLLXrcustN+lEUEn14pofSpJFjxzmyce5AIq6NL5HRLX7WRrbQQOImkWFtftjhaOWPoez0k+wexmDNSkAxZ9ppYXHP6IuW/Q7SEgDC7c/DNs5OnIvr1QlU6JnmSPHlxvORRbLBKF2MlyMA37gCiFJNrwuoI6lBeyfndxWnFwX0ntJTq6ulPdj7ZNyepaJGx6CSHFgQGqt6aYL9LEYiCZ2r2anlyBMpOoG4xEhaCb7cSBpdctoawaiNb5tDMOMj6TSlRp5jAX8YNoeEiV/nCHKiVQ8dnsCzAR/GWrYxRV5VlgDIest6fSqo5EfvcVqvfmgSuMGoeo1nhOsIKecyfOyZffH6Ou4U2qxAcf8uKxd5kjRJyKtZC07Oh0q1OvjRokKYe8VPw7L6H81XaiQchd/fbXVaRcxd2qa2/+13U6ie4zKHv8P9k8KhUZO5RiKAfLlxiC7YnloMX4KlojnBdJbc3eXm2D+R9fLnyDcpU4fO3zXK/8LaORw5p0coEr/Uzt9VxdNKNFV5UKmuivZcx12U8FKAQVTKRJZUzCx7zbvdpMsTo/62sWocNsBvaa1USyAKGu02X7Y2J5qm0Ivjr0Hv+rl/0IszW1sjgVgCOyY9IJ/KFLkPJBLu/fRCG4U+DN38QQ4g0MyOYGGPlAjSgne8tQTV7+W1g1M+oGN8bvOSeNu8uYD9wQsQu21EZhekFZQWMhApZcAKwvGVatFS48L+s8tQUUCP2DfBqce3cH9PHKfgnZUtxaqPt2/wpfOS2tjoIOzxNALtdmSDzM8zSOXvdDtY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(66446008)(64756008)(8936002)(87266011)(6486002)(83380400001)(2906002)(38070700005)(85182001)(33656002)(4326008)(91956017)(6916009)(66946007)(76116006)(66476007)(5660300002)(66556008)(316002)(6506007)(6512007)(38100700002)(71200400001)(508600001)(8676002)(82960400001)(2616005)(26005)(966005)(36756003)(186003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bGE3a1lvcFlMOVlFZW5RdW9teDBaSkx1bHpoQS9lRHhSalNwOFMzWEM4cWxK?=
 =?gb2312?B?dVZibDZPY1ZOb1gyT1k5QTlVWUdsdlFSTFkwUFFRS05FSC8yYkdpdkFMeUtW?=
 =?gb2312?B?UkwzTjNJRU1UYjVXYzYzYXVzVGc2allvKzVtQnA5Y3ZUb2JOVkYwZTNiLzR2?=
 =?gb2312?B?SXVaYnZBRUJzY3kyTmNzZ0Y1eU9nTEk5eFAraEE5ZFFXd01DTmxucUMxUC9B?=
 =?gb2312?B?ZVNBS09JWDVIT284ZjkwekJvdUVFbU5sUlZkcC9jUEZaWXM0dVl0Y1JXOGsx?=
 =?gb2312?B?YUtCRklQU2Z5UHZQME9lRjVWUXZUVUJGejY2N3ZaRTdYZFVWUDZmaVJHYmFh?=
 =?gb2312?B?STZZbk5XZUd5TVBhcTRPZmI5bmUwMjZDbkxKQWp4UnozMDhBaDNodjJZcDZ3?=
 =?gb2312?B?M0QycHVZTkhQM1BIZnF6dWkwZU8zYzdXeWlvN3hwMkJRNC90dWVvRWNXR243?=
 =?gb2312?B?a0tLblFvOFdvYXFjSG55YjVRRjZnenNDNzBNS0I3TXhPNitMbEh6WWJCNEZB?=
 =?gb2312?B?QmNKMXFHRnIvRDhxUHExR2puOWgyeklXd3Q5TVJYLzU2eE42Tk0rVlh0NUIx?=
 =?gb2312?B?Y0JlR1ExQkdoM0pIZGQzK3dNWTBLcEdXb0ttbTA1NnFXZHRBRkxqc2dWWGV2?=
 =?gb2312?B?TmpwTnU0aTJsVVdzN29lTGxiNkFVU01tbWR0WTRueUg1ODN4YnlTME13QklJ?=
 =?gb2312?B?aTEwbkhXNnRRUDZsWlJPNWlNNVlIeHl1TE5EQjhvZmNHY0ZLMzZ0RFQ4SUxq?=
 =?gb2312?B?Y2UwVGs2M0NYK2FGS0hmMXR5N1U0TCtqS0lxNzhYRUJKOGhMdDhHSXBiYW82?=
 =?gb2312?B?Tnd2WlJsc0FQUjZDbFBnaGlrdjRjdTdaT3RwMGYvaFNZRExWanFSM3ZNSkNs?=
 =?gb2312?B?SE10T1B4TllIdnBZYUo0TENIa0E3bGFVdUlvNnFqU0k2alVxa1JyZEgrektp?=
 =?gb2312?B?Z2VnM3RBUG50YkdEK0FkSFZLdkxPU3RrY09ST1dwVXJsbjYwU1MyQ0pIMUd4?=
 =?gb2312?B?ZE5RbEx2SVhWY2dQN1BzdDR3V0gzcXJjZ0VvS3lpcnpsUDdxeVpvUDlkRDd3?=
 =?gb2312?B?cFFua2M3SGx4ZDFtbE5zQW14cU4wSDlIT09semRpeEJGelVyb3FrbzY3M0dm?=
 =?gb2312?B?SWdxWUYwdHJhRmgzR2w5ci9iN2tjNEVCUm9xN3J1ZFVDa0Q0VTNicHVESERm?=
 =?gb2312?B?cyszTU1NSXlKeWVBUUpERmlqNjcyT0czUVJ4eEVTY0syWTRnV1ZFUW1hV05r?=
 =?gb2312?B?QkxGejdlNnlibnF1TTlPT1N1Q0tGUzBHTEJTTm9MNTQ1N3hRdWF1dTRtUmMy?=
 =?gb2312?B?VUxmMzBDdkhPaU1kMHd1cWxpRkxOOHlNVlBDRnQ4S0JQWmFOMWNNY2xpRG9C?=
 =?gb2312?B?Y05EMGpZZ2dWa3NLK0NtNTBSb0hIaldJUHUvc0YwUzNmajlzdGhuaktCdU52?=
 =?gb2312?B?M3VOYTJhTkRIUTVNUElUTWpyVlRFVzlpenhYcEZCOUhMMzNrRFNzb0pJRC9a?=
 =?gb2312?B?N1RBRlBEQ3drSThLVjBxek9RVmt2UmNZbE9TRnk4cDVEVXIzK3hRcVE0bVhE?=
 =?gb2312?B?c2xKWVVCRE5JSWxmeXBnL2JBZjJPSmtmMkk4Vkg3ZTBLaUFaZW9QT3d1UC82?=
 =?gb2312?B?VDhXbVdqQVlqbjNEL1hPUWxlT3RvN2hoS3RVQVl1YTY5MzdxcEFKc21GdDVS?=
 =?gb2312?B?Rll4NnRaL0lPaGdYTDJqVlM2Wm9MM2R1NkZMZXdzc2Z6b1lhMFF5alk5V1ZH?=
 =?gb2312?B?MEEwc0p0MjR3dmk5NWZMcGJMMWRoaFMzVVlJSDNWT3N4YnRoak52Q3R6NHhU?=
 =?gb2312?B?UWEvVlBGQWFVaW5VdWlTME84L2VWQlQwN215bUxDT2JJS1BEOHVzbVRtQXV5?=
 =?gb2312?B?Ry9kUG44cWZPRXdGV3JEb0Z2Y2tsSERoZEpyU0JKblFPOTVSUmNTcXZtUmRa?=
 =?gb2312?B?TnRuN2VjZ3hBSVZxNXBkMmxCV3FKV1RaMDZIaVlFUWdaYVhES0RZUlpIMFpH?=
 =?gb2312?B?NGJJQWMzMTQ1d0RmZ1ZVRy9qb21wYnBpNDg2cmNVbER5eFMyVWVzNVQ3L1pO?=
 =?gb2312?B?UkF4VDY3YU5IL3loSDJXRmUvM3VjMHR3TytpaE1pSjBlc0VMeVJ2c05NRVdP?=
 =?gb2312?B?ZXBtZnlDcW5UNEQ0L2wveExrNGJzbllBY0V4TWp4aGtLNXVQSHFrYVFDNVVF?=
 =?gb2312?B?eFExVWl4TFBUN2pGR3NtWEpiamZ3dEZ2K1ZiclhmUHV6OTBISUJiaStnanBl?=
 =?gb2312?Q?4eDlY2iD//0wEbTzKg3y5Se5B73Xn9vllZ7GeK+WOI=3D?=
Content-ID: <360857A17451CC45AB35CAED30BDB5A4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798535ab-d099-4352-239c-08d9c52e2a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 09:33:52.1980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HADNS77N0QDpeLanLt3Y8nG3WRapvKYXgrA+I8su6/sUiw5MXUwJt4BhUsT2WCJLdxoTbxO/MivyUzz0weX/SBZ+JSsK7/1A/AhKsJJP/AQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1770
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/4] zram/zram01.sh: replacing data stored in
 this disk with allocated for this disk
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

Thanks for your review, I have pushed this patchset.
Also adding some debuginfo in zram03.c like you do in zram_lib.sh.

ps: I have sent a patchset in kernel selftest to update zram case a week 
ago, but doesn't get any reponse...
https://patchwork.kernel.org/project/linux-kselftest/list/?series=595877

Best Regards
Yang Xu
> Hi Xu,
>
>> Hi Petr
>>>> Before ltp commit 4372f7a2156 ("Fix compression ratio calculation in zram01")[1], we
>>> nit: we can drop [1]
>>>> used free -m changes to calculate the compression ratio.
>
>>>> After the above patch, we used compr_data_size to calculate. kernel documentation[2] has
>>> nit: I'd add link to the doc also in this commit message.
>> I don't see the link on your ltp fork:
>> https://github.com/pevik/ltp/tree/yang_xu/zram-swap.v5.fixes
> I haven't fixed it there, I pushed it to verify there is no build failure.
>
>> I have tried this branch and these change seems fine.
> Yes, code should have my suggestions.
>
>> I guess I don't need to send a v6 patch and you can merge it directly(by
>> removing [1][2] linke and adding fixes tag ). Is it right?
> Ah, sure, go ahead and merge. I'm sorry to pick on details.
>
>> ps: I want to add a fixes tag for pointing to commit 4372f7a2156 ("Fix
>> compression ratio calculation in zram01").
> +1, thanks!
>
> Kind regards,
> Petr
>
>> Best Regards
>> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
