Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F80C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 05:26:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 883003CD0ED
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 06:26:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BF8A3CB436
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:26:08 +0100 (CET)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 805E5600629
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:26:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1701235568; x=1732771568;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=OeCjeqhmWM1usglJ4trTSS3eXGWGBrg5APf/lqU/ShU=;
 b=IV7Hc2oKCvzs5or7YZetejryLIES1C1P0Yc0ZJuAXzeXipot+kb23iIc
 kxaByqM7NuWM8eU6z6UiQBNUdld2Kb52cd2eYp22KERuw4QGXD9Ldgkro
 ErX0iHqS9Fm431SYhCNz+To9TgdEEjhhNI4kujo7Lu1IxD7Z1xaYh9bSC
 afYyULrUxPWLIYd5spnbCcP3eMzvqVUFoVu+L/KUSSsAbvTANu+/14IJK
 LYsd6ot1yGlWhMFoCYsW9ZG3BsqKgRqjI7ujHFZEUnciiUqO4lFZdQAwL
 kQ39WeS8xsib7/6/tdxuJDgt2FxuudSp4st3y7acfbVWCYsIfx4ooq3fC g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="15003050"
X-IronPort-AV: E=Sophos;i="6.04,235,1695654000"; d="scan'208,217";a="15003050"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 14:26:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvouUtF33/3IfomQ9K7IsAleN0JcLahwV9VAn4hQXvYQliuVqQi0QUuwdCw6IRm+YpT6U/92uNVI8QeGKEH57Mj+9vUGtd5ZAnZctNBYrGKlKZXiCG0/iE0nH7Dvwu8oEbfGJYcFmYkKrKrhelv7JucYmON29XGLTzZyPdw/+cOmTWtqAQeddfOruxmLrzpIrEFGrUN1FO9LiyMo8pquxaqNEfXRqYG0+Eu7D1NGVcNzqc2wA87gtztWbTbAuzcb8iGDU7k+OG7Cne1qCFGmTcLyEdjccFyFMAGPhnAgXsSdcxQPi0feq48PbgcIXBeLLDfLxedmnlL5EcIvNDASTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeCjeqhmWM1usglJ4trTSS3eXGWGBrg5APf/lqU/ShU=;
 b=nTG5TrdGvGbztII8OgdNTEQsoE6DaKf470u70g2F2lLmcSDvWT3c7ZDA2rtu7nhbJ9t/g/cjg2cB9ixwuADdu9mKdIwwCK1mHnYXY/2ZLFXIiVi94FogdJnK8VZfwyZ9v5LuBJSihBJAVJYqMbLGT6M23yxNxfNnG4F+q5LQEwsQTsS1skW+ZgbfXFzZta6ra4KWUELGowJL1TVKq6425m7PNuN3/7yGtdTP+EhNTy6aE4aRzv9hbvAcpdDTRQfj6e12FjrXPqPvRfLdNHbVkc0Xvv45NcHuHAl4WjkGQqoLXIKZRxlMWEtnyBKvMN0xgvoYN9W2hfBO+S8inbIycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by OS0PR01MB5921.jpnprd01.prod.outlook.com (2603:1096:604:ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 05:26:00 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4%3]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 05:26:00 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] swapon02: Simplify code, add copyright, modify
 docparse
Thread-Index: AQHaAlggSd/vck6ELUmBAWPIwy5hALCPg1WAgAF9+ao=
Date: Wed, 29 Nov 2023 05:26:00 +0000
Message-ID: <OS7PR01MB11839EA08F6601F8F4EE88A0FFD83A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <1697698029-31949-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <f4ef2685-0ea6-7b35-d6e3-b4d3088600af@fujitsu.com>
In-Reply-To: <f4ef2685-0ea6-7b35-d6e3-b4d3088600af@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-29T05:26:00.186Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|OS0PR01MB5921:EE_
x-ms-office365-filtering-correlation-id: d5e8f102-025e-450e-6035-08dbf09bac88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I1GgV57MELyAZV7qtfsfnv13LMaT7GnAjLtZ+UZrLVt5LS5W1/wG+ry2cpKKN6ZB0791qebEZFm2EQi+48hQMV9PtmaVTfLICf/OI2pIO9D1FZ96tfZnc1kokPMjrY/LzID0nlbVnSc/CPmzDykysgAn2htuJmWCxHrxoWw69/UxK7WqQyffT8BUgRlLmqtUX7bbPWZaZbOJTDkiuLrC7VcP3KfQOSmGzv3af4eWy4DA1A4rodVTxs2kFdxbRU6yMpedvuvKHR9RJHpHaqpUga0x15nPc1iTqSpp+XUdJWgMClGdACoUbY6XT9K1xBEstvLl2cJNTGd5BqaOhGs7FlTdqIQzYY9TFOtxDACJv4ZY8fJ6F9P8+XNVjyK5EwMGr/Mu4dct5rTP+hvumkH5saW6Zv1htE04JNBbWZbsBl2Ex3IVoZ1GoJZvGbguijfcz/NnfDNu5hL7m6ged9nvs4uSrz5Z2Q9CZ9E3ujt4GxgYqPl4fDHWaUSe2UNZ3XHN932tXZ1wV+pdgc6Yy9a2XFYoVvxIV8B4AdA+aDqCOKGr9wDwgzif2vLcdbToL58y5MTWrUnnSxUyaQ1vHA6axByJTdtFf/ia0ztQOdlyvohaPgw4vgT6fI3zjG/6a/bAYK/smP3qXJAVY8cyVD9MuQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(1590799021)(451199024)(186009)(64100799003)(1800799012)(1580799018)(83380400001)(38100700002)(86362001)(85182001)(33656002)(38070700009)(82960400001)(122000001)(64756008)(66946007)(66556008)(66476007)(110136005)(76116006)(8676002)(52536014)(8936002)(55016003)(5660300002)(2906002)(19627405001)(91956017)(316002)(41300700001)(6506007)(7696005)(66446008)(9686003)(26005)(478600001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VjdYMDRnK25FNVEwaDJEa2E2N0xqOWUxU3JrV05nUUFKQm1MVzRKTnB1eEdJ?=
 =?gb2312?B?dGRYeCtYdEMrNTFHRURHd1FRbW5vVmlKM1NnTDZ5RWYxSm5uanlVWDJXTVBO?=
 =?gb2312?B?azlQTnk3NHFSaHNPbnNDS2RQOURDUVFvYnB2ZjVZb2MrcExycXpSeEU1VG41?=
 =?gb2312?B?QTMxVWdWTExrektXeS9lR0JYMVJNd29kTDdLbGYvVEVhQkVzU0ZMS1BHY2Vt?=
 =?gb2312?B?WkJ0eFY1R09PaWhqZzRSK3EzcCtlRllHd3NrYmg3RitFSitUQjFXWmw0N2RY?=
 =?gb2312?B?WHI3UlppMUcwK1YxUFVTcWdoY1BPQjdEU2ZFNmM2L3NpZmdSRExVSVNPSlZa?=
 =?gb2312?B?TGdacDJVZ2NXOFJSQXZITHpJMjgzRVdGR0ZNcXVuOXVhQ2V6RXQ0TktvSExK?=
 =?gb2312?B?bHN1QzZ4Znc2QWlXOXhZcHpJQ3BOZHMwYXhtQS84SmErai85SlAwQ21rR3dZ?=
 =?gb2312?B?Y2VFOWxYNlZOcUZNcUJIdmQwQWNYMmdMQXdtc3U2cjFvU2VEdzlkcjJESEtZ?=
 =?gb2312?B?UHFiQ0dWWjdkUy9DZUZIQzZNVEUrV3l2ZXRwTFhlK1NqbjJNT3l0MWNjRTVR?=
 =?gb2312?B?NE8vdi95eHdrVm5XTFB3QThBTHl5Ykh5M3RaaXJSMmxQb2VOcHZ1QllnT1JM?=
 =?gb2312?B?bFN0dUN5RWdoRGx5T1dTNi9RY2ppcDhYQjJ3R3N3SzhFWlZLbzZUU2p4MHdE?=
 =?gb2312?B?NEpVU2xkVER5Q3dRRG5kTzJhdkVQUlB3MElEVSt3NWpDUVN5T0p3WEw4aE0z?=
 =?gb2312?B?OTE1S0srdUJZdldLT3BDdG1lUldjZlc4SjBUb0JmNEExSk8wNFRVempwZ2hU?=
 =?gb2312?B?NUljQzN3cm1jVDl2NmNMaWJmWkpqc2tuWEZLdkVvYnNkZytNT2RRdmkyMUNu?=
 =?gb2312?B?OXl2MzAwMWhkVGE3TEYyZVB4aWttZGZiSnUxUkFqVnQ1RkhJOEpBdTIrRDVY?=
 =?gb2312?B?eC9Da28zL1dUc0oxMVVVak1MRnU0Vkd3dmdnT1dFSUlyRXV2TVQ5RUsvWEZn?=
 =?gb2312?B?eDBDYngyaCtGd0NEdzlWNnlLQUZVUm9TcnlTVE5QUmZqWUFaNWhlWXVGUEJS?=
 =?gb2312?B?MGJ2WHhiV002VFR2TEdDdE1Yb2dpamllb2kvMlNKbG5OMlZzSGZlZGRnQlky?=
 =?gb2312?B?ZDBPb1VJQ0RUcUN2bE9wTUM4c1pMNHdZTi9oYVF5dC9oVDdXZjdBb1d0ZDNM?=
 =?gb2312?B?b2c3NTFjWWVuaGdoS3VQWTduRWxPb2Z3NXJXOXIyQm53bXNLczlHNDFxZGc3?=
 =?gb2312?B?WjZDY2k3aW1nTGVZTDdKTDRvTDI3WXdqQ1FsbzV3ZEtOYy9zeUp6RCtZRlZ6?=
 =?gb2312?B?UUdBTkVMaFo1dXI3YmtQQi85bHppL2p2ZWhjWUdoV1FQcTV5UTFWbUJjRUdz?=
 =?gb2312?B?ekNMQThGYkU4R2xLL1o3ZE53ZUErZlJNRlN0d1pFUWRMU0hzSXhhUWtxYzMx?=
 =?gb2312?B?TFFQd0VEWVlqeUU0VVR2akZaSkJ5SDYwMkdZQUNwZmRwNlBPMkxnRFkrRGRz?=
 =?gb2312?B?TDJtOXBHUTZrSndBdVRudGY4dS9lU3dtKzJGSEsyUXlDL0ZRbVB2dUZtT2Fp?=
 =?gb2312?B?MmZyU3BKVWhPZThqb1NxWElmdklaOUN2TVJodFRYUVVBaTZIVVRUc2paL2o3?=
 =?gb2312?B?MEw4S3d1SlRGRGhrSmxFQ3BzUmVkNnEydlR4UlY3TDJKZ0t5bXlBOFdDRThC?=
 =?gb2312?B?SVV5RkdVUnFmZzZCQ0R0NkxPUEdNUmR0T2hJeFVkOWszM3BTbCt5WkV4TnZx?=
 =?gb2312?B?M2hFZkJuNlNEeHZJbm5XeHZMSVpZcEV2cjg4ajV3amtwMXZDZjVDbGt3U2ww?=
 =?gb2312?B?V3F6cXNBQXVIdmlXRHIzWEtpSlExWGZPcjZIMExDQlQ0eGxGUmxyWWpETHlN?=
 =?gb2312?B?Vll0VFRzS1hsUFdFanNXajd0eXJNWXBBbDhLWm5TWUxOclRyQXpSRDM3UzFz?=
 =?gb2312?B?aksveGFPOWQ2MDMveW5wanAzSGxrWGRQQXZxTWo2UmhWY3M2OFVFVDU5Y3VX?=
 =?gb2312?B?c1l5TFAwVHdjNXhCVnBYRHd3dkZLSjRnbld6Z0tSQzdkS2NzNGZMMXA5V2hS?=
 =?gb2312?B?Vkw4R1IxRk51bTZiZ1c4UU1kUVArUUVxUkgyYUllUnpzZ1JXZUFJUEgvTTE0?=
 =?gb2312?Q?AcOjzkR+qyrZ2EvCeHKOmaxcY?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vDjA1NhXzVW0L6rZ/5lTKoxRmsWWQUGaxFwrBtBZrwH6DohAzwMQnaO+loONx0vGM6NCTF6nLcJODOfk9984+WZ22sB9Y5K4qWlpHBdAdv3h4nwy3NEcDXfn4de1KymU3HbEjuHl0d4coAnOcEkx1dZoEQyF8WD/xGmH2VNaHu59OomaF0rair8auPxbLXD7AmpIMA2cJp6rTqs1Zc+sTGdwhNl0JL6ZDqtJEPqQdlmLAbQC6OT3AAlQtLd+cffYRJdarLKfsUSGhR27rRjDuwYcBW5DOhHp8H02e4b24QNblmtOCyGULbFXIdqSWU5PCmTk3L/s2cUSzTdhmWg/R4q8Qxa6kx7q+64PI3SLlEv5QQ/ChI/9vSsAI+TFo9OQvVMCBHEly+uFVuX/I/QQactoY5/LAftwcQhkEnPP5NgbpE8a+yAsmMQfLiqqmZu7kJGFqHiiQ5zYluSj/nJjvchJ3TAChnh4ak1FL6PE1BQcG+VuQjQqxO1UJm/f8i2SjOhDf9aHLpau5lwuPI6oNaybYfTzQamFY66hRbf9r2HiY3GPzqIABzAAhxcf6UwZCn2VDbNdwPmIrzlUAoeh2AtwpdHLpEkXOxB2RLZ/yxWm82l9m0I8guH4+fTGrF3TM/30XPGsaXjSj0vBI3xxLrKBU7UdEr94LvnA2qaG42WMW7yYrUvPBlv6ehm4YSeNDsCU8KBKj7V034tWL4xaO7j9TuD3pSEh/K9NUcI4bVGNVaOV2G/UKT19GeFlNg4wu2qgRQ2RoZ2TUtsiMUkHtg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e8f102-025e-450e-6035-08dbf09bac88
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 05:26:00.8257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94j2MSByHgMZ6AJ1ntXgLgFzu1Gpk4RpOM35TBhoYxwibsChOjf7NAcc3PUupNJnm8Ye+znkYENwIXLOFfV5P1FSP4Eq5yYFO5mXQFYeKPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5921
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] swapon02: Simplify code, add copyright,
 modify docparse
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

Hi, Xiao Yang

>On 2023/10/19 14:47, Yang Xu wrote:
>> Simplify permission-related test code, making structures look simpler
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/swapon/swapon02.c | 57 +++++++--------------
>>   1 file changed, 18 insertions(+), 39 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
>> index d34c17a80..2c9e39986 100644
>> --- a/testcases/kernel/syscalls/swapon/swapon02.c
>> +++ b/testcases/kernel/syscalls/swapon/swapon02.c
>> @@ -1,17 +1,17 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>> -
>>   /*
>>    * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
>> + * Copyright (c) Linux Test Project, 2003-2023
>>    */
>>
>>   /*\
>>    * [Description]
>>    *
>>    * This test case checks whether swapon(2) system call returns
>> - *  1. ENOENT when the path does not exist
>> - *  2. EINVAL when the path exists but is invalid
>> - *  3. EPERM when user is not a superuser
>> - *  4. EBUSY when the specified path is already being used as a swap area
>> + * - ENOENT when the path does not exist.
>> + * - EINVAL when the path exists but is invalid.
>> + * - EPERM when user is not a superuser.
>> + * - EBUSY when the specified path is already being used as a swap area.
>>    */
>>
>>   #include <errno.h>
>> @@ -21,36 +21,20 @@
>>   #include "lapi/syscalls.h"
>>   #include "libswap.h"
>>
>> -static void setup01(void);
>> -static void cleanup01(void);
>> -
...
>> -
>>   static void setup(void)
>>   {
>>        struct passwd *nobody;
>> @@ -79,24 +63,19 @@ void cleanup(void)

>Hi Yang

>It looks good to me. one minor hint:
>static void cleanup() should be better.
>Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

>Best Regards,
>Xiao Yang

OK. I'll modify it.

Best Regards,
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
