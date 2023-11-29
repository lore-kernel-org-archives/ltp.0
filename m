Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D78C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 05:43:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1F443CC3F5
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 06:43:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7DB33CB6A1
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:42:52 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4EBDA1A007F2
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1701236571; x=1732772571;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=laOhZjDfIPlEUjnGIf8iC7H6fn80CwJQ7Tr5y6mjsc0=;
 b=BOvkIuVIExPwjaVsrJJAIQYY3qMCI7QetQeoVLGd6xjDVNMCidRH6Eb1
 ySjTV4S6QbrEq7vGmqGTPHrxOTWL1G64hr+ohmMVozq25HylG8J1kQCHB
 8Nin84+4putMiv6LGGk7jwappCvGXdU3p7Ch3qBvXH41pHp5X4LdklOxp
 WtY7dRyjZDM9T6Ho2VTIUuvcT9vbm3e21cik9gukEg+6s5Sn12YvNPDUf
 Ok6PWJ6qw/SFxIabRKTgLYF1zBLuPnptdaHVmaZj9hbjcPTacQbPu1Z+Q
 x4sCtRRbOs9fJ4b21gJABL0eKdrZwtVI+Sy1tYU1f1yL0wU83dk1VKbT8 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="104084865"
X-IronPort-AV: E=Sophos;i="6.04,235,1695654000"; 
 d="scan'208,217";a="104084865"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 14:42:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP6CdkC+DuO/ZgD44cIOmD1ENVLLf+Pc5Afn/EEzaDDM6VH8h7/JOPu2nzErMwRFkeNi9oMcTU9KY8Qsb8Od7i1OHKshVLoCIFf/06LSQYToqMRB8Kz0EN9M+KCndTYqbILSDByjq6YXTx+hLM5AJRQexrjOdZQJ6AyVYXkQzODbJipLZSPx3C8EMN+HIKDfRXI6QKcZzvIfuLi1cFeCA42QZH422H7AWa406+yx7bBM5V6M3lVpuhPbhKdnRJBbmdLt0W31vZoFI56wI/nEOFNyedgFZ2j2ExAIlyvlkVjSioOsAEFf78o7yn/8Z9SdN4V7PWrqGDrr/a/hfVgy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laOhZjDfIPlEUjnGIf8iC7H6fn80CwJQ7Tr5y6mjsc0=;
 b=NN19yquN+WOHwNfyLIpJMlMfECNkduuH0eguiLbvjfcDKC7AbgyBVxInKRX+D/eTS9TbSxIGTNv8idBZ4EG3syMVKIbfTmyjVJdHa2ucaFinJQ7P1WX26gibKlyltLX+rYoWTjNHGNGQ/Z8jZpIgJWrmolkKZ66rwjksagZ5m3t9Bdx/pDExGCtTKkLNLeDl+H++y/jo4OiFrS/NF1wVUkx10Mu1+r4blen80QGH+5MGtNuc8wEYfDYZ+63He2WaESq3kU/3krCudjhkp5MLkQlvC1BJ95okpmEcz3xiKtz8nawfcN+G5+QBvOz60pMMvlRIuEx2jA1YOKzc+O2MGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYWPR01MB10259.jpnprd01.prod.outlook.com (2603:1096:400:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 05:42:44 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4%3]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 05:42:44 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH 1/2] pathconf01: Convert to new API
Thread-Index: AQHaDWku7ih4GiOJPkOt2vokYIPAxrCPWo6AgAATzgCAAYPpCQ==
Date: Wed, 29 Nov 2023 05:42:44 +0000
Message-ID: <OS7PR01MB11839B658F1E55EED43B79FFDFD83A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <20231102080535.63847-1-xuyang2018.jy@fujitsu.com>
 <9bcca18a-42a8-2200-c6c1-0f97b42e11e6@fujitsu.com>
 <17196c76-e767-1353-6725-21d92c3633b8@fujitsu.com>
In-Reply-To: <17196c76-e767-1353-6725-21d92c3633b8@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-29T05:42:43.745Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYWPR01MB10259:EE_
x-ms-office365-filtering-correlation-id: ff049aa3-252d-41b2-b4d8-08dbf09e02b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PySF5qh3NBlehdsCqlNJ//cWjGlWHEzd4fGJoT2Fch2T9lldjJdvwiF7fj1oXxPffJjhZw3HQXU3YpnxjxOJVqW2qWdPA9TdUhjtb7yCGt06XHhoF8kD5tJBI86AtlXCMZb2sFoaN7YNaYGS1d5WjGDhNE467Qn2bXnQa2rXDWqgWz/fjP/pzmgDoyIR90evlXSV4EpnUISEyMcd/ECqDT8Gh2NuP59XvF8E7G7bPghmnIfWZvy94cErK2QFJWN/jU6HnSdQVttjO3ThWFGBq/skjlQJR+5Q3jya2t0m8FUiygNSl1Laq61OkVGC5cCUTCv+L442ZWPLb8zaotucnL+0kmo6AS/1Uwb7Q3nG4C0p2c8QzCYtnFkMDZI29fz1tQVgK2g+H+XveShwzauIdXnmMOa9qCxZeVeiRFfvZDUNm/90FzEgxdhd4fuFwMkKZXz1kJvIl3WND1S2gPppJstOJzE/dmC06Tlo9qx3Pbf+zvrlVYzO7cYqxVCoEUBPX0jQ2TaZdrHyI9lClAcy93gZBfS7fhIR+Tensa/xTFQVMjVa1A/Stlt5JfMM3/Gdn3kYWuos6Ij7MF7tJWZ3wRE4vRrrjY1+FrRXpJejXQMJ9P3SmgdKxkAahNM2D9HHRhv4hi+WBeBKxBd4UCh+Tg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(1590799021)(6506007)(83380400001)(38100700002)(19627405001)(122000001)(82960400001)(55016003)(8936002)(52536014)(8676002)(9686003)(7696005)(71200400001)(5660300002)(110136005)(76116006)(91956017)(66946007)(66446008)(316002)(4744005)(64756008)(66556008)(66476007)(86362001)(478600001)(41300700001)(33656002)(85182001)(38070700009)(2906002)(26005)(1580799018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dHpZTG4xL3UrYnJiZ08wcU9sVi9GaDFINVc3VWp5TnBPeWhEcDk3UHZXWU1R?=
 =?gb2312?B?d0NjNWVlMjVvNE1adnFmL2ExZmcxaXpsbm1hQ3YyQkM5MUs1U1J2RXVhZTdX?=
 =?gb2312?B?bVI3TjVVQ3RGTldQMnpaS1pWd1BnS1hqV05aamlKb1kxcHhQeWp4TjZrL1Zk?=
 =?gb2312?B?NTFyZkduTzVXQURmQUtKek9rako5elVMYU1od3YxeXNSYnlodE94ZGZtK3pq?=
 =?gb2312?B?ZHFqSG5veFpTNlNNemUvZ2JpdTVCMjduODNoNHFEeFZXR1Z4RlJVZmYraXJj?=
 =?gb2312?B?OWM3QVpnZ3ZXSnN5WnFWZktMT2gzTS80QTM0eFNTQkhzU0xkSXFPZkxsd1g1?=
 =?gb2312?B?b0ZKM2x2NjJ1Wk9sdmY5MlNXdFdFemJaRzF5OEd2dTFXNC9aamN5T0wzQWpr?=
 =?gb2312?B?T0Z5Z01BWDZIWGRyNzlKZU0wdnF5T2cyMENhTHRPYmxyRkRPdGo2bWt4Z01j?=
 =?gb2312?B?QS8yNkQ4YkpiN1lsM01PUHgvV3pOYnB2UkoydTRGcmV3K0dVaytRMkJ1azIv?=
 =?gb2312?B?VGxrYmJWSVhnd1pYeURVdmkwY2lrZlZDM3g2Qmw0NG1pTWFqQmNuQ3NoMHBS?=
 =?gb2312?B?REpGdGlrdDlZODY0N3BMTmtsNFo5b2cyZTFlSXQ0RjEvR3U4SjBTdko5QTN5?=
 =?gb2312?B?VUxTbGNESzlxaU5qNE1iNVExblhwQ1hMUTNoUzhiamRjOU1DN1JwMnJabDdw?=
 =?gb2312?B?ZnVNcGZvUWJDOVlnYmU0aWdlWnJQZS9ZWC83d2QreHVzVk5mUzVxdjJmbmJk?=
 =?gb2312?B?MEMxQ0l0cGFpODhZb0Z3OE52anNwYjlTK2lPYTEvOG0rNVMxLzJobGhRNzJ2?=
 =?gb2312?B?STZNUmZOdmRBemdNRXZ6S0ZyaEZWVC9SZm9IcnJZbUttT29QaXhycG5PQ3VT?=
 =?gb2312?B?RXo2bXdYeFlTbmVNakYvRGxCRVVqK0VuTDZLeVJpeG5MMlNkaThnRlhHNFJn?=
 =?gb2312?B?Sytxdlg3SWp0YldieGV1V0Fza3AxUnZtSVFLUStNdlZJSmFsQVVFWmFaV05M?=
 =?gb2312?B?RmRkMjJQUS9pMHdiTTVrSUVCVEJaV0ozellZWWd0NW1Gc1NtZXFBRHFhUzE1?=
 =?gb2312?B?d3BxRE1YV0w2c1ZBRzl4Qm5NdzVoSjUyQ1Awc2JrS2JqcHNnL1U2NHBFSU0x?=
 =?gb2312?B?VVpUR3NSV2U1eWtockpaL2t3c0hTN0N0M3o5bjR1WVlLVVNaejU3ckxvZlBH?=
 =?gb2312?B?dzgzNWpKQU9ZdDlZU0d4TVlzUjVMK0ZWVXQ4bWJ4bTZ0aFprSHk0L0s0MG4y?=
 =?gb2312?B?dE1WVHdKSDU2UXp1ZjBSRHIxaDl2d1A3Qk51RG9xZm51MEd0QzgyRFFQRFVk?=
 =?gb2312?B?ZTNObmwxYnd0b0RFdk9veFpXOGR0ZzRJdkpMYm9vQXJiWTFnaXpWbzlBS2NF?=
 =?gb2312?B?UUdKQlVDUHBkRFp1dUNib3FQZ1FrRkZsVzBEQ0lhV0IwWlErSkZxNDY3OXha?=
 =?gb2312?B?Qk9UZHdHS3RDa0k2dklhNEdkVG5xQjRwaEhlaFV6Qk1qd2xzUnZZQjlkQkZs?=
 =?gb2312?B?cCszVnVBKzc3UW5QNHdBMldmQllCWFprMGdVT3loZDRNOUVFNVBoMWFGZ2p2?=
 =?gb2312?B?VjJUNXlDdUlNSWNxcE5JUXpqQUVqYlVqN3Y4M2ZLeHFwMWZXSHBUTkIwZ0Np?=
 =?gb2312?B?RnYxVmd1eWJRbUZaWWNrRWRrNGFqNjlYUVZ6aEdYZ1V3MXdSWUIwTkR0djJT?=
 =?gb2312?B?ZjhwbS8wY1Axa2tQSjgySG1PUk9WbFlBOEJ4dFJla3dBdjQ4Z3BqWi9ZZDRr?=
 =?gb2312?B?ajJ2anlzRWRvdnM4bHozWWFXV3FqOXdvblJSWG9BR2puMFo1WDJQMjkrNVIw?=
 =?gb2312?B?L1I5aE9GREVGT0xJZ2UrUXcwQjhMRUVSQzZhTEY4REptWmhVU256aExDSGhG?=
 =?gb2312?B?SHFSSkVZUkUzbm1WR1JPNVp1cUtLelg2eDRsN3JUTGw4aVlzOFpaODQyTVBJ?=
 =?gb2312?B?N1U2d3VYbitrL20zMERFZHNxd2MwYk1GY1pCZ0NWNWUwWEltUXBpN04yMFJm?=
 =?gb2312?B?NzAxMVcrcW1nV1RjTSt0UkpmeTExblBiUVVOMm9jK0p6dERhaktPU0p3WU1U?=
 =?gb2312?B?emJsZ1hOMWIyeEtxUzBINUx2SnBGcjNNb0tiRU02M3d2WGxnRWRka3V6bi9Q?=
 =?gb2312?Q?hcn74k/zzZ+1Sha32eJU/3M+t?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KG/YYJg0Moyq9tEMN4iGc2f1Lx6lQ6w/+E+5yRoLBq+IdneFlnVEZnDWhOAeY/QW5Y1G13vPXBHClv5lyeMqyEkvYgiw3oeh78bM14nyGnro3yb7AM07ky4hpUyA4eDdCty6KhyOd6KbBhqs6x9rSrGbD/kgRdA3LoC/3+5I5AyxG9TD78PtrjgRsHXhlkd/Grkkp88ykjDPE8si1GPOj2+opJeAQw89T2A/VcNCNQ2Qdd93wk94hq0kPL0cQEUqCQvV79hlwEPRUDE8Uc6EatUkNAviupfcZNRoPXM5r3KPlse6PqpgLKhlT+z+t5Zq4M8xJim4SBLv3o7WceQwPc/m+h6A/9mnhQa7QC12sj40TBRaKNIf/Jwht+R+yqsQ93ccE4WnLFO5eeW4xvFZlauohvbyigFpNvwQ51hSUXlElbyYAZOan7gDO5m5o9KyN7qpGOrLVSQPgbG50R7nhZJrrjDaaIwEQGUz4hvXP32uRpBZfclK6SdZm4tBBD6FA3CTODs00xRXqBbQPIvR8x1FxtNO4zZR6wd64Sy6IrqM4n1RrbORKLC8v8VlsBXvAxy//MG7KDS47rrVBD7TQOnjx7+z2CvtLMdi5lwMrFDkF96ynV9IIIbgQ1EbrXkAitQq9ZwjoStFcymfNlAml2aV/Sr5bAy/cHthaYTZVy3btp+50fTPgpZv37FmLVydkgsIRcZPbL+gHUf6BxsMuv3a2maKcgRc3gApZGEoaav4zgvwt6ryrcRdCF9RlJ6qWdRP0eEjseCfEaTEmwKWWw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff049aa3-252d-41b2-b4d8-08dbf09e02b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 05:42:44.3676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8aOhi3IEiZrg8MQOm3V1NcUk7i+CWbcPCdZ/DAmr9pFMCaIRNGPK27wLncvloGXXJWLQ/MAEZtm9vg8IaOGWZsFLdxxGyDufJ159QfVw68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10259
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,Xiao Yang

>On 2023/11/28 13:21, Xiao Yang wrote:
>> -/***************************************************************
>> - * cleanup() - performs all ONE TIME cleanup for this test at
>> - *        completion or premature exit.
>> - ***************************************************************/
>>    void cleanup(void)
>Hi Yang

>One more hint:
>static void cleanup(void) is better here.

>Best Regards,
>Xiao Yang

OK. I'll update it.

Best Regards,
Xiao Yang

>>    {
>> -    if (!lflag) {
>> -        tst_rmdir();
>> -        free(path);
>> -    }
>> +    free(path);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
