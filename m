Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A426C433F5
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 01:27:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7ACB23C950D
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 02:27:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3F233C58DA
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 02:27:23 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0EF072009D0
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 02:27:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1643074042; x=1674610042;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QIVpEH3GwODTnE1FwHqxXSt216hta6xF133hpsAcaqg=;
 b=AazC/c1u+TR/1PTYgiShhLT1ApMz4UF4IC9z+urnDgF5gp7GKbGiFKgH
 I8YnUpR3JcY3XfjZywxC/oou7PEjjDCD1Ifb+z3WVGLsKgeYbtThTWaDz
 CtU/3D0qDKfDcT9TrgioeTuNAfYlMk7zxmaaw+llKxOMAVReiXKP+CFhq
 YbjXNS+Gnmu+N9CTItyUIsMQkLJbl1HUUwVh3nnaSw5znnR+xcLgk58n+
 portsFMjZ5FsmogKcMNte0q1DSwcBtpA3Z9p4amNUGE9/StvLiVRQokdf
 7s/8xDio3VfpCS9N/ZgeutcVaF/Oqo99yd53OBp9uuhvaE1VBNpyQlIYp g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="48276898"
X-IronPort-AV: E=Sophos;i="5.88,313,1635174000"; d="scan'208";a="48276898"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2022 10:27:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcMxqmmBb0OMytzGp6dfy80coeGZpz9Tykq2V3uocSDLs4fOVpfDIs71WMFR8aCKF8Zs6LXIH34rPEwf3MvXcyLxr0Gm8AdXtMF3IVY4MJ7XuRL5lU7jXIST0ZuaOYx+JNC+ODjl9RKiiVKiOiUnj+jiFe3rQbLkmAKuhVXex3f74oLoGVJyK0IyYXKyV9c1y3pqv1bqsgqPZizSHyMNfVf70Ebt7mOYYcRnZLZ4ng0VaWt+4SqJbmgQWdnaJpWVW6ipaKNKE0goD2HniBOggxNEPmg+W0H7hNXVL7j42YOA/A6ZlvbIXafvCusQhPXEB83aWWtDZ2uW7aQ7+eOmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIVpEH3GwODTnE1FwHqxXSt216hta6xF133hpsAcaqg=;
 b=Hfbc7/YV9m+SJqrNgP1kr7tVMfeaGjuIKz+ltumOIDgIa9tOKQGbUrdKzZqEseOhVrYd+KkdRFgBMIqSip+rxkzpAr7gy8brQPlCoSozZNrZOxEnW3iNUkdVMDnAwHZ1zOIqKiId//piMEeL/p/1Y8DlU91ACs8oFlQYqXonksubFJj5/GYU4OD1DOjVsopR91H05c9tNFycseQDMUW4WeUNC77k8cNte+KpMT9MniC7uyLWBgCDsWJFA8dSVPHapCruJDmlOFUGEahchyzs5IzQM9ipJ1xX2JC2j5oi98JqAWstybs6sP6q8XSuGZnkevpzSxnaVJSN4M2jZVuCxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIVpEH3GwODTnE1FwHqxXSt216hta6xF133hpsAcaqg=;
 b=cmIExM8a8WcNmWfkfK7g2UxiRtaXzjRkSXjKr9ZDS2lOZeAQYJEuTHdu783gh4rKVIFmK1PRHEHwshDxdh3Hh54sAeS7DRgR26d8gSeG4H6q/EChwUcW3fZZu+5R8+kjKWmEK2XeTCFN2b+PopazBWgb9USjafCpp+CD/7TYP6U=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSYPR01MB5416.jpnprd01.prod.outlook.com (2603:1096:604:81::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 01:27:16 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%5]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 01:27:16 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 1/1] m4: Fix warnings
Thread-Index: AQHX7A1WNYswYxFMLkSONkR1aD2tA6wp6l4AgEim5wCAAKwtAA==
Date: Tue, 25 Jan 2022 01:27:16 +0000
Message-ID: <61EF521A.2070908@fujitsu.com>
References: <20211208082625.26324-1-pvorel@suse.cz>
 <61B1CFC8.6060305@fujitsu.com> <Ye7BrHTbkLRtVwhF@yuki>
In-Reply-To: <Ye7BrHTbkLRtVwhF@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06171edc-5021-4e1e-bd27-08d9dfa1d260
x-ms-traffictypediagnostic: OSYPR01MB5416:EE_
x-microsoft-antispam-prvs: <OSYPR01MB5416A30DA478D173F6584729FD5F9@OSYPR01MB5416.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bj+SLlZDKArq7ugnJTZmkE/vcJFAZf+3T9qGtby+tB8KN2jh0cnDQUMOOFz8brJy1fH/b9hPcmq18grZxUGPlXbjee+reH4pL+tgY8v16ZHUhZM/zKZp2G7R+bdgzwXvj3sFUfWVOwKWX+UbD0OqCv2nSLCj30n/06TZ1YU5g2OU6kysJNoloB43i1QWE8Bc+gfRYHgQw7rHJPE9h/9/8nPxATlaDhyAltVW84T6e93SuqOHt80tnJEPuwKHzRTkzZvNAOQRWgSvHz9uEoLv9IkrBcUWrua755vkuNc7XI+6BbjFDedg0OEvZLgg1uM+PwgGwp0VesK6oYo29t1JVMsRVlHTzp904EjSgfBbmwaqSmIpqwdSYy3gft5tsYn8Mq+2ZI730o1jQaGGIUgw0lSPpdsGMK4UpY7Wk9xdJSqe5Tm+ca6K8EK0WiaY4EkXRsuCdyN5UyUDJx3cUVbP+zbsxpLERmXRV0GImx+y7BKNGSPycWHv8Gn8isqk2G30Ptv1F83AAstOYc8hGU1nxMbzOLujkYZPKMweAppqU8NgCSGytuak6gZzNv//xbdgMesjpFRP1bYka33lYQzrVxa7s0EpBezXNVPa+ioyGop+DJFLKk6JFaYN4gCYUJPG+EmVQmL/sNEDwu2Clsi9OLm6nRyUb7UAFl1TCytidHiijkWBdJPYEu7a+ATTQH7ZnwW5M5uduX6ItAXUhIDpRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(186003)(8936002)(122000001)(54906003)(36756003)(71200400001)(38070700005)(82960400001)(76116006)(26005)(316002)(4326008)(508600001)(4744005)(66556008)(2616005)(86362001)(33656002)(38100700002)(87266011)(8676002)(6486002)(6916009)(6512007)(85182001)(5660300002)(91956017)(64756008)(2906002)(66476007)(66446008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?U2FzYzEyTi9kOTByZEV2V1d4RXE0OTEvakpWR0x2bmZ4Z1R0UFlpNVRiYXQ2?=
 =?gb2312?B?SmVFVlNNNU1UUWNLbVhqUTcxR0hRTDk3R25IVzVvWU12ZUVXUWhHK1d4N09p?=
 =?gb2312?B?M3VVeThaVFNRUWNYUkxqOG9ZN0o2MmMveGpxbk94cUIzZlIrbXJaT09VTG9S?=
 =?gb2312?B?dU1iM0tnWWdDdkFSSFJwRW8waWd2azdMdDdBYzltTFl4WXcxNVNubG1oVE9x?=
 =?gb2312?B?M2hwNkNzT0R5SExYNzVKekVubS9vMkpuY1d6Q1JyU0h4NTY3eUkyTlZDeXJs?=
 =?gb2312?B?LzlheE1VR2dYL0RzeEJXUE14a1dHR0hQODRMT0tmUHFnUGJPK0IzV2NFTWpx?=
 =?gb2312?B?cVlSMW84YVRmYzRNQlRQK01zMGlwVzZPUWJMRnh1SlM0b1pXZGJsQWdXLzZq?=
 =?gb2312?B?M2hWWXAxa05PTkVjcHRCUW9kQjFpeGVrd0dINDJVYmFaeUdlUS9lb2hUYjht?=
 =?gb2312?B?VDRLbDFRM25pL3A1MERRK2NXbTdCeldBZ1BvU0JQTWRXdUU4WDlpQXdUdm9F?=
 =?gb2312?B?Ym5jRGtUYlByV3QyaHFvQ0FRcmRYWTdqSENXNTExMEhmeEdHc0syOUprOEFZ?=
 =?gb2312?B?UDFCUHB1NDNxVEltZ0d3WURiRFRBckhXYmNHT0s3ajdBNkcyRVVLZmNMOWZL?=
 =?gb2312?B?NE5UL0VCNmNqakpRWDcvRFZFcFBEbmluanJvRkRDSDdHZnpWa3YzelF3Unp4?=
 =?gb2312?B?ak9sL1JiRE50K2RpOHdrb0ZSMkhlYlFJWk43QzJ5WUN3bHA3V3RmUUFYUTls?=
 =?gb2312?B?RVNraE80SmxNTmRjcnJ5YThLemNwZGVQTHM2UllHL2hkWnhsZ3VJRVZCak8w?=
 =?gb2312?B?VUhLRW9SbFpIZDN4U29nUTZ0UDZBMjVJKzAvNWc3dCttMHR1T0NuUW9uYk5t?=
 =?gb2312?B?b094dHBFOHVyZEIway9iaDlGdkkyc0d3QkVENlZDR1R4U3cvYmNTQjQrd2VB?=
 =?gb2312?B?eEE3N2xvYTBxS1RKMnl0OGNiQy84Z3VFdGpGaWgzZjYvcG9rd04wSHNOUGpN?=
 =?gb2312?B?NzV1V09RZ2tVRXk5YlFKQ1F5SnY1aUFyVnpuWXRXUTdYZWRia2loVkZlT0dG?=
 =?gb2312?B?U0ZpSUQzazVTWmY2WDgydklPc0VVTVlpRGVveUxNS0FhTjhQV1BTbkl6Q3p6?=
 =?gb2312?B?enI1RW9IOE85NmdHQk9tTHdzcUhqdGFhd0JSV0RoK3hiTTFhV1R1QWFmeGI1?=
 =?gb2312?B?VVZNMEtMSUpKUTRRL3VhZ2NveklUNDlKeExOV3krRkxnVnlsVTg1dW5QbWwx?=
 =?gb2312?B?Ty90SUxld29paE1MMmdnR2pRRXpEY1F2anRQVWNtM21qTFVhbUZBSFFjVTZz?=
 =?gb2312?B?VjlIaWZ6bGIwY3NIUCtGSG92Nk1KNlpUc1hzYkVKVmQ2SWhaNXlEaU1qUkJr?=
 =?gb2312?B?bGlURUp5bVpMa0dLWXRuUC96RUx6UmFSeUxZZVBtWmNpeWZJa1A3WHBLSEtZ?=
 =?gb2312?B?ajRIVktlYjJ6aUVvM3puRS9kSmlxY0N5OVZRYTBFMWVjQXlvV0NtYUg5azlE?=
 =?gb2312?B?QmFOZ0JseFR0TllvcllnMVRmT2w2VUYrdlkrZGg2UUgwQ0NyOUpxZmMrUlJU?=
 =?gb2312?B?UVhKRTJnSkdKVnFRQ3hzTHNzUS9Ga3VlYkR3cXVhcE1qNGZiaEtKSGNMdDRy?=
 =?gb2312?B?MjNHVDlBS0orTVRXelI1WXlKNmJvd1BWNnVFaWdBV01ROU0xMHg4SkNUM2hB?=
 =?gb2312?B?SS81b3NHNjcwc2pxS29NV3pwaHhwRS8rVXZpeFN5OTVYUHFvd1ROSGhUdWxL?=
 =?gb2312?B?UVpDeXd6dFl0Q3ozbm9NeUc0MnZPMGtrWHM1aVdHODVYSmdhVlVzMnV2NWox?=
 =?gb2312?B?R3IvckgxbllLNmJKUmllQytQcVlqdE8xaDFzbXV0WkExa2Z2VytHeHI0NGNl?=
 =?gb2312?B?WkxSY3QwTVNUR1pzRCtXcmJIZTVwSitJb1ZUV1BoSjRSWlI1MVhKdkxZMWNa?=
 =?gb2312?B?Rm80ZDEzelBQNS9mZ3BTNEppNDVBTGlyRGZnWFVobEZUY0VlSEMwZTNWdC9y?=
 =?gb2312?B?USthbld5WUFmZXFMMDBJUDNOd2tsaWhtbHFqdzF3WVkwZis3dlhKa05rdHRr?=
 =?gb2312?B?NHNqVnNRSkhZWlowMWx2VllhcmpuZk10MXRCSVpzNEFjdWRBZWQ5L25wQk9D?=
 =?gb2312?B?QitESzMzRXhkS0I5YURxa0wya3d4K1NUb2RmekJmb2ZKaGRmRWNXRlpEeUtQ?=
 =?gb2312?B?R2poN2ZrdTkzVjVLMU52RWk4U0dnMzJqTFhZM1N4Z3BSOWFPMTk0aTkzQWRK?=
 =?gb2312?Q?nbZu0KIe0tdsh6cEQCCBujHBMA9s4jzx+zK9BNt5xk=3D?=
Content-ID: <620A378172FB2C40BC0527EE3A1FA70B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06171edc-5021-4e1e-bd27-08d9dfa1d260
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 01:27:16.0982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JzyTKAY5MqduN23LucPUt7GIJcK5VNZvlPw1Q2mPuhvGZJ+1CqPIRm8KFqc7WhsM7iXhPnJXwgU8o77W0cNKJGayc86EgVtrktaT3dEchM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5416
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] m4: Fix warnings
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
>>> * s/AC_PROG_LEX/AC_PROG_LEX(yywrap)
>>> yywrap argument introduced in 46f384f8 ("Revert to 2.69-compatible
>>> behavior in AC_PROG_LEX (#110346)") from 2.70, but using is is
>>> compatible on older releases (tested on 2.63).
>
> Just looked at what the lex is needed for and it's ltp-scanner.c in pan/
> and the ltp-scanner does not seem to be used in any of the scripts we
> have, so maybe we can just remove it.
AFAIK, I don't see anyone use this ltp-scanner.c. So removing it is safe.

Best Regards
Yang Xu
>
>
> Or is there anyone out there who needs ltp-scanner binary?
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
