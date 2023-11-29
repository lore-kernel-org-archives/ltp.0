Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCA3C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 05:57:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF6F03CD964
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 06:57:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A84F43CC265
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:57:40 +0100 (CET)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 885451000A3C
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:57:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1701237459; x=1732773459;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=mm9jmH6oq65xJQJSyk3CRQcyjUgtU/A8qbbkYfLoZCQ=;
 b=CLFSMVBvSCtQ+ROfndv0Ea90BQJdMZuGA2ZfhoDYoT5HS2qFLuRVA70A
 P1pFTBz1soi5Haa8Uho+gspnQVXK8CtxRCaxyd6SR1VD4sWlDX5JEJjt8
 70DYi27mQsNYHMvzG3x1umX+7BbNNeu4CTPcTUmJ5uXGd0j2L/oGHMgUk
 bQPU1ONRsmDArY2XUFCe3ZWpl3KXtoY7N4mj4qWuRtZDcVELsdRs38y8o
 5c/zu6tyQMfjWZCmXmlqOtUZkwx77LTXwMNnhB8sC9xWHcPCu6jRGkAi2
 6jFAbPiQD3pYfuBMWj/hNDJLsEkae8JVLFd1N2pbsfGX0Uac8dbcaWSdm w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="103990006"
X-IronPort-AV: E=Sophos;i="6.04,235,1695654000"; 
 d="scan'208,217";a="103990006"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 14:57:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpqqvgPAIrHw/NUHQfUe171UboeTl41LjGjDjj7rCm7EGcByu6pEoN8DH/FIN1zd6sBV5N3g7fmDEDYq7/BtE+XcajA8aXDEa0ZFetV5id6Deazmng3uy9TBN+fvHFvrldhQKWC4ANvXcvGnYwXvo5YMRPkHJXwmyBHSE8RU6w73TsveSaTSyRSxxCKL/aq7TcotbuCa+UV7ZiLugz/QMQs3ZtiEWhKWg52HhldfgsYynp5LISkpvmdP5pNVTaZxweUOYznxIpjmLMQDuhncjG5AywTvCozhkvhofQd9+Z0l+mSpjAwGfR37EkS0/K12DktV0L30vlieLsilR1xsNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mm9jmH6oq65xJQJSyk3CRQcyjUgtU/A8qbbkYfLoZCQ=;
 b=IJkwk2qbi9bFDSXUeFq1YahVZ7OcBSPww6rtE0D0uhJZQV/tQ8TVK+XR0eE+3tj2FHwAe1M/etpqaAXsTPDpLVVD/TLfSYBPwN0l7IvKu5uxFYjto3lxjeGFMVoHaEQbBD7/6BW5p1xrEv7yYKgzxMV6QZGzvm/dmRDKN9q167WwOLYIk/tbQzHw15cqhKx1yuVeiWGW6hUh+roz6cfKRTPj+mGSx86+BbrENW6YxBsbOgpIk/7WndFb2w2Uf2+p8lQlgI2ZsUPUuN7nWF1wo0MUPMpNeh2Khc9fHYBW4wqRKyQjoEwHtWb2arpMHPvIdKfvf9e8d9+Ege7KhXLLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYVPR01MB10687.jpnprd01.prod.outlook.com (2603:1096:400:298::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 05:57:32 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4%3]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 05:57:32 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>, Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 1/2] pathconf01: Convert to new API
Thread-Index: AQHaDWku7ih4GiOJPkOt2vokYIPAxrCPWo6AgACMUgCAAQwdrA==
Date: Wed, 29 Nov 2023 05:57:32 +0000
Message-ID: <OS7PR01MB11839A8B0802224B435F8A499FD83A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <20231102080535.63847-1-xuyang2018.jy@fujitsu.com>
 <9bcca18a-42a8-2200-c6c1-0f97b42e11e6@fujitsu.com>
 <20231128134320.GA401671@pevik>
In-Reply-To: <20231128134320.GA401671@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-29T05:57:31.695Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYVPR01MB10687:EE_
x-ms-office365-filtering-correlation-id: 1d39c0d5-9ec0-442d-4c58-08dbf0a01403
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5fl+YbVL7VM7uZFVVTtT0t9Y7LvdzldNX+mj03r/wm9H2wRBLzFpmWIvC8z3j7fR6gX/I619KuTKlAZtx0tIzfD7IgY1euuABko1YmXVeceGdiK4Z5MyV0GvWSctc8gEHRr7Kv1YW8Zg5O+xqS/J9J06RK92ZnqXeBbFrQYUDHkBsw4huatGydWn937kWUEgSi5sBrzA+bRq+6dltO6hm7eUYsvYj9uO8hzNmwwR5JiIiZDk+MGiEOb+n6ARwVV3KwO1kf0mNAlN60ccqitW/cSlRV8KGYCTkEImTSyBW/ckxVX75hbSkCwFaLzPrcyJUeqtYOgu8Oq2cR0B9bnH9oNrBb9zMaGi1D5X7RPTtMQ+jfdfnX1psNGKfznK+RB0izv8Q83XJiCwcODlLng/8Ck9s86aWcKJzafsydB2ySzZTMLwchZsZgWaG2bPJpRKnbpgQxK1rRJ3TIbFPdV73bo5t7jFeaxSbqIr0OE89Y4YZwXkM0TcJTCfhyndhyEA0RQ3INYPuNpsXa7odTs3EEaSshEyQxy3XoA5tXkBQJD4uS7ZSg7YCv/d3SX1ojsL0MNhrZ/rGnbIdtt188yX0+J3fuUlGWlvCbAZ61hKP2jv+3VadSz82HvUD9+yyB6owX6LXXGUdONaB4rF/gwfvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(230922051799003)(1590799021)(1800799012)(451199024)(186009)(64100799003)(19627405001)(21615005)(1015004)(55016003)(52536014)(5660300002)(4326008)(8936002)(8676002)(41300700001)(2906002)(64756008)(316002)(1580799018)(66556008)(66446008)(66476007)(66946007)(76116006)(91956017)(110136005)(9686003)(122000001)(478600001)(38070700009)(7696005)(6506007)(26005)(85182001)(71200400001)(33656002)(83380400001)(166002)(82960400001)(86362001)(38100700002)(53546011)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cnZtRXlqa2R3endJZC8yZXFZazZyY2lkRmpndU91UU9xWlgwS0E4ZXppbi9P?=
 =?gb2312?B?Q0pLejc0NzkzOUYzT0JjMm5oYjBJZkhlYjVBb1VhOGhabW1FdkhibjBJMkxr?=
 =?gb2312?B?eWwwZ0RXcy9EZDA3UFhXeTc3UXhXRWRMTDd2cEhVdDJiamEwUTY5ZHF4c3Zq?=
 =?gb2312?B?elRQdXpLcTNHdThBVk91bHpHL1lySEZTU0ZGM1krMGZLRWVvTDE0OWFWOW40?=
 =?gb2312?B?eGRxUFgvb0ROS0hzOEg2TEo1dGFsTlhUNmtDYllsZ3NWdmNwL01BTGorVG9Z?=
 =?gb2312?B?V0xrc0JZWURYL1BvU0JqMERiNk95K0tUejdOU3g4OXRpczIwL3NIY3JJMHdw?=
 =?gb2312?B?QTVmYmc0cEJSZFZXMjhZM2VtbTlPVis3Ujl6NytNZDhoMGxnemMrSVpzb3hq?=
 =?gb2312?B?VVQzMUdkN0U3dmJUVUFxT1hyOE10OEpPVlQ1R2habG1DU21Lc2FMaS9icFMv?=
 =?gb2312?B?ZTA3WDQ5cy9KS2YwUWdkVG5kdXlpd05ubmZMYVFwRjhIdnBlSlhrMCs5dnNh?=
 =?gb2312?B?Rm9xT2htU0c2VCtrU2lzVlJzYlhjNDBNWE4wT2hPYUI2aitFRE91alQrQ05l?=
 =?gb2312?B?eXV4WThnSUtsVE5aQ2FSVWxMZXNnMG5mbFRBUWIxaXpuaHZYUGM2R0VPSmpm?=
 =?gb2312?B?SHpXNUJ4YkJJTXBjdHJLdWl5dFNGaXhSS3EwUDI1WHJ3WmRkcnJvaXBiZzFM?=
 =?gb2312?B?UnRSTUpyTmdmWnFvU3hHd3oxTE5IeE1sVkxIeGhySmZrVzBGTGJGaWhjNWZG?=
 =?gb2312?B?QXY1QmptNjlvdXVsTko2QTkzOHRaMWRrRU92SzZ6eldzWG5GY0orUVNkc1Vw?=
 =?gb2312?B?eTBoM2l3NmhmczFkVTVjNFNzS2w3ejJ2ZGdjdDVwRG8zU2VpbmFWaE1kajFi?=
 =?gb2312?B?Wkt6TmlhMERxNFZqRk5TcmVibko2eVNLUGtKWW1Yc2VzNmh3SG5zRCs0WTln?=
 =?gb2312?B?ZnpEajdkQXhsSmFwNHNTNXRhN2NyUkJQV0FXelVvUkZ6VUZuNVA0eElhaGpL?=
 =?gb2312?B?dmtEUll5dE04ZUxkb1F1TkZ1Q1k5NTgzc0JFZWJKMU1wa3JoamRNOFIzdEFH?=
 =?gb2312?B?RWQvSzVWMFhqblVWZkwxOUE2Qi8yVi83SEhvRUs2QU1jTVFKR0lTZDlCTDFv?=
 =?gb2312?B?aFY5emdJUU1URUQvTklxQ251OWdpZmtTQXpyMnlpdG5qLzZrZWpaR3NIdFNq?=
 =?gb2312?B?T2psaVZra09NZUdWT29rOEZBWGllT0N0MVNNRWQwTHp4RTNFMnFFdk45MVpv?=
 =?gb2312?B?bTlnQXh1d2Rlc0ZZY01UbGY5ZDA5TU1jRW54M2JVU2ZLMmNYTm5NRmhUdHA4?=
 =?gb2312?B?Z0djcVpjOHM4UUpNRkhlN0Y2Q3VRa291dnRvKzJIY0V2dXk2aDFRSUlYaWQw?=
 =?gb2312?B?OGZDMVlXSVY0RFhFZWY1MWttQkhkZUFFYzlJQ3p6WWdyVTNKUUV2OUxYaWJB?=
 =?gb2312?B?UlZVZ2hNN0hPYnJmYnhsdkwrL2wrYURoK1AxMlU2VXFac0xROGdsbHk1VE1U?=
 =?gb2312?B?dmdwNElkZTNzUFh0RlQvQzFTT0M1ZWZFTTVMbklYQTRhclUvYTRPNnJBalBZ?=
 =?gb2312?B?UkZDQ3NSTXZFSzlWeE1JZi85YVhSZW8xWUhid2ZTQTFZZTNaUjRybW1MTWNC?=
 =?gb2312?B?MS9WYUxWMjRHbXk5bWkwdzc3WTg0Yk8zMVhUQmZ0eG5aVGF4eVE1aGRLM2lR?=
 =?gb2312?B?NnNnY0p2YjBOQ2NNcXpzM3dUM2wxeG01cUZqeHoySVQvUVpqbjVLbzNZZ1hI?=
 =?gb2312?B?S1d0WW55Qnh2ZHNoQmEwNXYydnA5aHJpY0ZWYmZZSytGNjlPQithNFp2ZDdR?=
 =?gb2312?B?RGFnNXlwd0xaTWk1VVZyYTdxdi93c0w5SmVFNFdXbTNHYktSeVNGS2FaelVU?=
 =?gb2312?B?SE5Wek5pVDdmbjVjY2ZyQ2VpZzlCak04VXZWbVgwb2Nqc3VyekxyakNDb2tV?=
 =?gb2312?B?TEQvTnkvWUcyRDhDVHZHKzJQeWxHZjdIbzFNRXdOWThiN2h5My9sUjliTVQ0?=
 =?gb2312?B?L0Q3TzJPZGRUb0k3Zmd6K3RraHRPUytpR1NGUlFKNEJoeEdnYTl1MFEraDNT?=
 =?gb2312?B?bk1yenFNZXZ0S2kzOVFJRUlBUnlUQlNaTHovbGk1b2NnQXdKZmVMNzFwQkgx?=
 =?gb2312?Q?ErxDorzbboay4oHYYw+OhBQCM?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j4WAhWBvoF2Ls98GuvawQcU5TGyhbazssPQy5vLzrHU6DVMKCLvUEI+J5eyTp0i8DL7eIrYo+SVzGkA/JK71fkodEbCLQ3D+LPrl+SqIzYJ0phKleAUm0tIZ5el0RjGv6ELZufiLxGCEuo8jj67kXYrXjjS8//1/WrGomXKOTbhtNaiX8pFBMUBhjmkyDD4NHf8PLXtUadcPWrW6GnLrmlRdXQxAtb2WDa6Hhm17YHc2YtwfdiUuN35WIaaqQ2YrhYu0CW41E+/U00DaZphKdWaDJy2tpx/Rjs1nT0UdF54lciGXdqpN9DBn4X6vNhxIpq9Ru/3JOMOKSskkEuiYM2sxFtE1sB1/OCndNWWs4QLdw+iRUjHRTPPEGmun/82taT6ywq7lTkARrQHmvJGjdjLsDoXTvvD3kYJq8zHryxlRYykRsSmqd2cTOofhOYW+1bQ30GrVi6H0GkWDhtnjaoWxwC07Qi8tP9tAn+eJei05FyXUBPjMDFeDDxp/pPlR01nEDaU+U5F7R6nwCKlCY8Ajw5HoiJQJVfl1Meii5GdmZKYW2D3MJ9pGWzvfl+wD3AmEdDHhb0AXwxl3ZSBpHeCztpdZh1svoJc8FgmX07NsMeiicE3NkeT5ed75rhRj5hXVr6NqcknkfNwAttNi5WvmjEvW+vzuhNX8WNCNg3JH0E1btqOZ+Ms9TXOYmPK/MSbGJyY9MzATGQnq6QBmKNrsvdEg+NVhJXt6X3s/mDAsX5o/3mAGZqbTH881VuRl5kXX8+zm1dhuGwjoynG3xP9J9B3tJf0/YviF3Lacd7w=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d39c0d5-9ec0-442d-4c58-08dbf0a01403
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 05:57:32.3707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: au13IrFGY/WHm70E2WNNDRd+dUFv81I9Jmi3ePYZPfO0RvxDKDqxnTLxYqiHREutij934u4/PKYs1qpTUT+G442/nLCDwE8sIm1ShwplkOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10687
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] pathconf01: Convert to new API
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

Hi

>Hi,

>> On 2023/11/2 16:05, Yang Xu wrote:
>> > * Simplify code and description
>> > * Use TST_macros

>> > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> > ---
>> >   .../kernel/syscalls/pathconf/pathconf01.c     | 251 +++---------------
>> >   1 file changed, 33 insertions(+), 218 deletions(-)

>> > diff --git a/testcases/kernel/syscalls/pathconf/pathconf01.c b/testcases/kernel/syscalls/pathconf/pathconf01.c
>> > index 362bae94f..9b8b99d48 100644
>> > --- a/testcases/kernel/syscalls/pathconf/pathconf01.c
>> > +++ b/testcases/kernel/syscalls/pathconf/pathconf01.c
>> > @@ -1,237 +1,52 @@
>> > +// SPDX-License-Identifier: GPL-2.0-or-later
>Unfortunately GPL-2.0-only

>> >   /*
>> >    * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>> > - *
>> > - * This program is free software; you can redistribute it and/or modify it
>> > - * under the terms of version 2 of the GNU General Public License as
>> > - * published by the Free Software Foundation.
>Because there is no "at any later version".

Yes,you are right.

...
>> > -   {
>> > -   "_PC_LINK_MAX", _PC_LINK_MAX}, {
>> > -   "_PC_NAME_MAX", _PC_NAME_MAX}, {
>> > -   "_PC_PATH_MAX", _PC_PATH_MAX}, {
>> > -   "_PC_PIPE_BUF", _PC_PIPE_BUF}, {
>> > -   "_PC_CHOWN_RESTRICTED", _PC_CHOWN_RESTRICTED}, {
>> > -   "_PC_NO_TRUNC", _PC_NO_TRUNC}, {
>> > -   NULL, 0}
>> > +} tcases[] = {
>> > +   {"_PC_LINK_MAX", _PC_LINK_MAX},

>Please use this:
>#define NAME_DESC(x) x, #x

>} tcases[] = {
>        { NAME_DESC(_PC_NAME_MAX) },
>        { NAME_DESC(_PC_PATH_MAX) },
>        ...

OK. I'll modify it.

>> > +   {"_PC_NAME_MAX", _PC_NAME_MAX},
>> > +   {"_PC_PATH_MAX", _PC_PATH_MAX},
>> > +   {"_PC_PIPE_BUF", _PC_PIPE_BUF},
>> > +   {"_PC_CHOWN_RESTRICTED", _PC_CHOWN_RESTRICTED},
>> > +   {"_PC_NO_TRUNC", _PC_NO_TRUNC},
>> > +   {NULL, 0},
>> Hi Yang,

>> What is the purpose of the last entry? IMO, it is equal to the first entry.
>> Other than that, it looks good to me.
>Very good question, I wonder as well.

The last entry really doesn't make any sense, I'll remove it.

>BTW there are many of others:
>https://www.gnu.org/software/libc/manual/html_node/Pathconf.html

I tried to add some macros and found that I had overlooked a judgment condition:

"If name corresponds to a maximum or minimum limit, and that
limit is indeterminate, -1 is returned and errno is not
changed.  (To distinguish an indeterminate limit from an
error, set errno to zero before the call, and then check
whether errno is nonzero when -1 is returned.)"

That seems to be very important in this case.

Best Regards,
Yang Xu

>Kind regards,
>Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
