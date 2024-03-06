Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224BEC54E49
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 01:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709688769; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=BqZtUDvGInhrp6w0vKo0Zxljvi4srRNsfcon0Ky7VfI=;
 b=HYe3U6VllNtYKNT0t1LKD4vFeE4wfmQIo+lhAZlr6syjaxoD6YhvNgbErWBwyrLFYlEbm
 JEJQP2/mtt6DGEmll7qjuVw//p5Hjy3yvbaHC9KrE854rw6uADFmEjYKW5XeFCUYKXqXsvG
 MIokmxhIT8rW34odal5J0ADQLKPlI2w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51B963CC53D
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 02:32:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 882213CC53D
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 02:32:26 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.151.212;
 helo=esa3.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 373EA200A1F
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 02:32:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1709688745; x=1741224745;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=74Hv1VmDkbQGU3UOWx3GPINYx45K/MrEtRybHkW0750=;
 b=gj0BcsbO/keG8D3r0pS0meUwdnEBmPSlYRD5HFnqg2F+9fdiPy92lgIJ
 J3uNUhf5Ckut31ZzT99vhqAyiupLh93eCiRrd9b2GOeLwsmkVRBVDyDYb
 b47tI5a4b8yvqozPlEgB9YI7Afts7rykrdn01HmSKwlWht/cjHywMLhRc
 WaqkYrw0Jn4yFbJy1wzjtkKnJsF83AIyP0Q0TcrLLn+h/V/++ro+uXkbO
 ndcIy65HvaDK67KrCGwzHi6RxVfUHLcEEFjDCKe6aFE3eNA/ckGO0jxP5
 H+pM64phV1/eG2tNVs8uUEf97qcFZsrpPDLkZQdVOZDFCW4NfgdVGNqIL w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="24262733"
X-IronPort-AV: E=Sophos;i="6.06,207,1705330800"; d="scan'208";a="24262733"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 10:32:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSS7m+uzlyESLJS1+OwJPvs9T+7QgLlWr5pcz0aZOLuoskVfxoB4R2u4vw8wMnaPnMsPL0P0LMV+GyRkAohw2CY37HR0c8F8JC3n+p6hTcRdpKgpzVgF9teMH31sb3IaDeAXd3aXhJ0jUWuHIiHZVTUJhsETTMPkGwPNvqQ99bsgWsTejYWXy5EgGGOwLvF8GOcQsKHhQY2h+lJzOeqWeV/Ju67zCKhb1zHx2lOYN/R99diAxS74+qvxaVWcKkux3nIzaPRWI2p+PdSpXuDD/ZDBZzZoipyKSeQSJsFuhAswE6QmvGINVLJ6AoMA8LNeXrLt/+49+Vt+pcd2jmIxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74Hv1VmDkbQGU3UOWx3GPINYx45K/MrEtRybHkW0750=;
 b=iGpYj6svn/4wngFeAacIlYW2yyIqX6cSfwFP8qZd9KL9yBqubcatrak0XW3DjuwMwdzULJ1198wxKwUzpIze6xKuDnL9TW3PUkOOx7tmbyanxDrxcNSWqJC/PO0i8rS2+9qLumS1OSwWE6W88Oh5Ig+yyyodEkW0GaZf4aIMUzMEpvKGyjQJ2y3jSk2uuveiaPAZM1vnNsSsPB7BDF21CnB1c9xadJEfRrr0mbcKBHV9G4JRnqO/esP8Pd+exWBTTyfqufhrhujBvw+lFA+HEuTg+36NX8ltgOsIKizouYvo0mePP+Lvl98T45rEN7YemxChdO6oHKQaUeYGmZtwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYXPR01MB1584.jpnprd01.prod.outlook.com (2603:1096:403:d::21)
 by TYCPR01MB6158.jpnprd01.prod.outlook.com (2603:1096:400:4a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 01:32:15 +0000
Received: from TYXPR01MB1584.jpnprd01.prod.outlook.com
 ([fe80::c9eb:72b8:f662:c9fd]) by TYXPR01MB1584.jpnprd01.prod.outlook.com
 ([fe80::c9eb:72b8:f662:c9fd%6]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 01:32:15 +0000
To: Petr Vorel <pvorel@suse.cz>, Wei Gao <wegao@suse.com>
Thread-Topic: [PATCH v2] libswap.c: Improve calculate swap dev number
Thread-Index: AQHabwb5t0IKBnzey0W7Nn+BIuBNmbEpo1WAgABK14A=
Date: Wed, 6 Mar 2024 01:32:15 +0000
Message-ID: <b2525dbc-a863-477e-9499-82b8f3ad71a7@fujitsu.com>
References: <20240301062716.3023-1-wegao@suse.com>
 <20240305141057.8754-1-wegao@suse.com> <20240305210421.GA44833@pevik>
In-Reply-To: <20240305210421.GA44833@pevik>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1584:EE_|TYCPR01MB6158:EE_
x-ms-office365-filtering-correlation-id: 923b64e6-5025-4b0b-0b57-08dc3d7d4102
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nzk+TOXUY9LFfw4RmhzrE29cX3MOup4RO1kQwdrMUE2DPPP4GLKwyBX5zPlQHpLLlkz7R1B6SmnifrCie4cpeWtldGf5dciragd+OtJAURyGdwkf/+7hr79/amaGpl8SdsU/WW7jcAbssLfEORg/ZxTFAbtLFBUGRrYUU9Xq6m4AI7RVyHBndWLtNOf2WcsXhwXtniNKT8H4Xw73I6aaiGxbAGF8bEQWb6NgJ8bQ/doaa1Ovk/5uKrC+TKe2JLFYEzLQPs70OPxUN70iZGEBPjTTxVjkml8SdhfhJ4JGoRq0vPvF0hWMx/myebZ+5fJJT+2fP1iCMgNUqTdFBF2W2OqWJkEurc2yb+jKKqs6mX/aBmMJDb6tOAkGGK2ReiyPpngKNmII/lvdPiwRh0rLq2UXxF4GKkBGYyPd1JOFRtglZfAKCl061mP8oAEi6a+2VibXmWPtFHIcvMkTNZQzpHSQtMxsT8jXVqWe7LD4igJmLW79JHHH6B9mJHTl8/Fv6x22/X8AE1Ba98qcNHlKYUbDbSIGHtDWGDykR5rfK4YT5c7XcK1Xq7IR2UsFde1vd5ZEUGEGNE5KmulQSWD6E+dfnWBvac7FpjgkT+4jU3AWOZGuw32ZPYg3UDHyNGx9OmlzCXXm9WEHWYOEQIiZLXrQcQaNmpcMzs9Nnvhf/ZAAI+EEH+3AxzQOyqpGJ74Z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYXPR01MB1584.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1580799018)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkJoTUY3NGxqMVBVTU1TVHhPZUtJbHdBdnFuczVWK3dJZHhtQnc4QzNSVUND?=
 =?utf-8?B?L0NrZXhEQTYwcmxjQTEwZlRMYmx2dHNhKzlpTFNrUWxHNjJxRVlETUc0UnBQ?=
 =?utf-8?B?UzlYcEx2U0Q2WFBuUjQ2NHJnSXBNamtRQW5KTHJVNTcrOTQ4dDZXQlFaRklu?=
 =?utf-8?B?ZXQ0WHJ4dlF5QVB1MTBUMFcwaERFa3R2eDl0dWlwOXZiVmR0MFJxeEJBTWFL?=
 =?utf-8?B?akl5ZlNsTFRpMm1PTTArSVZXUUNXbEwxOUNGdWlnTFBOak1xRzFXcGxhem1M?=
 =?utf-8?B?VjdVVG90OUV4Y05sNlV3U0tWd2p5bVFrZmpwTFIzRjZuY1FrSkVLTTVJMnZo?=
 =?utf-8?B?OUttQ3lBQUhOdW9ITUxNMHFXa0RDMGQ4cVdHbTVMaFpoR004M0FMYldHR2c0?=
 =?utf-8?B?VXFqQ0h1d0k1bmJaRENnV0JnaWtJTUNSVXF3R1RFbFI1L3d6UUpGYktxMGRZ?=
 =?utf-8?B?VXNWaDV0MFhuZW5xNEs2RDM5Z0RENTZ1YTFxUzhGdDBuOGlYYjhZTHliZnNx?=
 =?utf-8?B?THQvd3lVeW5vaXpCd1A5L1hkL20yN0sxVFlNdWpBeVZzTk5xSHVlY1QyWnNJ?=
 =?utf-8?B?emdsV3NJeVRqQzRScWZZb3J3VitkTk5IMDRwTnRnN1FkU0VxS0ZqaGQrVGdO?=
 =?utf-8?B?aVRpK21kamhrVmJEbUlkeUJsRFVPYkp4Z1IzbGNOQ2JReTdEL1ZjVyt2YVNw?=
 =?utf-8?B?emN1eXRUNkdOZ3hRWXU2dElHdWRPZ0xIaGJVMlE4Yk1kdjQzU2p2TGxTd2NC?=
 =?utf-8?B?M29pRjZQZHJ3a2MzM3docTlpSWFQQlFycFhOWThsSEZOcE81MDhoTEJlR1gx?=
 =?utf-8?B?di9TbVNtZ2lUbGRvU2VLYkNGQy92bFJvaWgyckJEZW5MM2RPNTZRMmFmbVpZ?=
 =?utf-8?B?WWRFWmIxMThaa01USWczNU9EM2ZFZ0RFNzJsczJUUXBuYW9ETDhPTnpvWjN5?=
 =?utf-8?B?bUVUa1lhQnhDS3ZWZ1BDQmk5cWJwbkxwcjVRUFB2azJXNWdXbVdwVktiU0JJ?=
 =?utf-8?B?WXJ6MXhiaktndWxuMnM1RlNBYm15a3dNQlU0b2tPYThVekMyVEMzY2pPTlJ4?=
 =?utf-8?B?T01ZVEFzMUZ3YXZqYXFxTmZpVlR1TG1wTUFxQkNyTXdhb04zM1ozQUtwUkJ4?=
 =?utf-8?B?d25kandqQldJc0szOTFwSWFmTll2U3M2bVdzMVRwemRnMy9HVEZFY0FQU3RX?=
 =?utf-8?B?MDYvSm42SjlYN0RiYTloN2U5OG9GZ2dzMHcxbDhLSm83dlE3b0szVmhSMk5q?=
 =?utf-8?B?Tjh3SndJVU9kSkd6WldJUTFKQXhJaFh2bW5NNmh4UmhZZ3pqZ2kraUZtdW12?=
 =?utf-8?B?U3IvVk96cWVJY2tPV244eE50Uk8vSWsxOXBKeTdWOU5sNlozV09KcVhyS0lN?=
 =?utf-8?B?VkQ0UVg4VVZTZEFSVjd5ejZqZlI0S1Z1dE12NHJDTm53R2RqQ0MxaDZQNmpF?=
 =?utf-8?B?NktmVHpTb0FFVnBvc0tSRVNNSVhkRE02Uis1QzBReUFrSDlzdTAwQlAxZ1Y4?=
 =?utf-8?B?aDNnRnRRNkVCYldYZUl1TS9ZVUhxeENjeXFaS2NhbFpBYXJ0RVJiVGdZR29V?=
 =?utf-8?B?TGVLMG1nVWM0SENaSmU1bHZqZVI4RDNKM1VFL1d4QmJ1VG9DUEQ0K21wbVNz?=
 =?utf-8?B?UkN0MndaY2RHdFBWMFBZSnVhZC8wTHBQcDA4cVlwRGJTZlJxZWoxME9kTmF6?=
 =?utf-8?B?WmttMlVYRGNCb2ZvUTR3d3NzT3V2R2Q3WmpmajdrcmJRRVZPbEg4L0RMdCtT?=
 =?utf-8?B?akkrVUFtQkFKSlNFa29jcHZoUmlHUFZVUmlpbkFYckRJdGI2aDBKVE5WbmJo?=
 =?utf-8?B?Z1pURCtqdCsvY1RoTmhXM0hjWENjNHdrN1Noc0hhU0NkdktkNEZZSktkU25M?=
 =?utf-8?B?ckNmYU05ajhlc0k3M2RvOXdRSUZRV3lLcnNIVkZsMmdDVmFqK09XWXIzTXhN?=
 =?utf-8?B?NmVWOHFOZEVBSlc3MUlzRkl3bVdHUExaaXpqSUFyZWlmWjl4TDZKNTNBU1VN?=
 =?utf-8?B?TEh6Qk5BK2NNTjNvcUJLM1pwRDJuR2tmejQ3MWQxcFZySXZyYklJZ1BLK2Zm?=
 =?utf-8?B?RC9ESE5HRjI1TmxQb0t1SmtXRHp1OWNVZWc1SnVpUkNicERHdGJQUFlsQzhR?=
 =?utf-8?B?SHZOQkkwYkpnSDllWm1JWmE3aDZ3WWNJS1FxOW5rUkdhU0ZmdHFaQ2xXM1ZH?=
 =?utf-8?B?alE9PQ==?=
Content-ID: <58BDC02EE809994EBD9DE76433218C3D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nC6nWwTPGh5CiDOR2QFScXyp6Mkqdl/WW5SLHnMHzAwrY4YovB2nRnnn+GrRki4zF3NVduXL7sIhgPcFIUxDwDtIFOIouYexgczsE/gLtI5zxoUXl4wigWKBP1RvQEXT5bDgvZvv4OvMmf12rBlEGFWX+Y9pH0CqfFVKwHPjcbTu0JCsrKKJnx71CWntRrP0X3URNSNfruqZiaMN3ZcajdQ2UvfJHtdI20/mpHrmXb/FwRL3X294JXTiPfXb7AQkrqgs/2etLZKAWUiPR0gIcPTpRbnmiN8HTwz9USZ1/CN4qyHMvtoCiQ91iyBcjIr5Ob5fuO+6VUHmaS2Ukb8XX/wvuphO7AQMDyxPvQfx8lxfpYIvyLTiPpqze/GJiq3SBM/3svennb2IDw9GA5R9MHZl2mkgvb+bk20C9NsnOuODRJKWqqvvia6gVqW+24r8Ylkzu4ByFr9McSbcqCqZGAgr2Zxcn1hqD9y+nX1qmoy8bJiMTJhvHnmvScO0ayKODLqMa63uF3k9wXqhmwcHDo4PN2wQ1Ydex8zd6KvGVQp0Za2CtQUylbzhoi6jZJOamwhON8SI9+JgWCO0jubl5WJTqk2LDQfN6ADPKARj/FU3vxaLa/oi8H3/cz+gQvJo
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1584.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923b64e6-5025-4b0b-0b57-08dc3d7d4102
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 01:32:15.0283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZLl9f/welfepoe0N94gcyqkMy161LRyKD8x/buQxsLcOrhUfYYWMIw5tSlYMsl6M9d3rnqgqUZoH/CoKpx6tIWTGE8D7S5gZDevKhKXgWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6158
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] libswap.c: Improve calculate swap dev number
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr, all,


> Hi Wei, all,
> 
> thanks, merged!
> 
> FYI swapon03 with this patch still fails on SLES 12-SP5 (4.12 based kernel):
> 
> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> swapon03.c:55: TFAIL: swapon(filename, 0) failed: EPERM (1)
> swapon03.c:55: TFAIL: swapon(filename, 0) failed: EPERM (1)
> 
> But that's likely fails even without the patch (going to verify older SLES
> releases).
> 
> Kind regards,
> Petr

I guess SLES 12-SP5 has backported some patch that modified kernel 
constant MAX_SWAPFILES value[1]. But ltp doesn't add fallback for SLES 
like I did for RHEL9.

I think you can paste your kernel code(include/linux/swap.h), then you 
or we can figure out what cause this failure.

[1]https://github.com/linux-test-project/ltp/commit/c1b8c011e447088b08787462e0c2ed50cd8c43f3

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
