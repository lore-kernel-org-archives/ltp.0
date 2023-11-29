Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF618C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 05:36:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 067B13CD792
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 06:36:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29A933CB604
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:36:46 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A886C60064F
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:36:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1701236205; x=1732772205;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=wEcpH7SI6Z6fm8Fgb996ZliNdfbGAtyZBG9zup93SbE=;
 b=bcXu6OAyV0NjedxfHK+ULXCsiwI04uFbGrKkLTEpm2s+NieTEcgkrTkr
 Pcd7kA4w5RJb7OkyILTujXR/0b9uszXCu9swlWCXdqe3rZ71tV3CjJDc2
 fBexHrQ6gcdDwAD09/H5C67iw3x3p5Zxp7Iokdo3biwQrOHlB2/LnS3Ga
 PKRvuB156SI7AaOXUWFPaSEddKUrnr8eo3US2r9FWuHgE5HQfncaqtULJ
 BvoVbB8mdeTusczs4DZcPVacR5I5h3/7THuWxXIhngAYTC9uSzB6RcfPG
 xVgK7M6aj+xJT0XjgtQAdtwGhIwG7YUc9Bn+fxSHzPgisNAHtgNSHM8yT w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="103877025"
X-IronPort-AV: E=Sophos;i="6.04,235,1695654000"; 
 d="scan'208,217";a="103877025"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 14:36:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSyibVF9YCX1WJKj7f8Gx1OH6JowKLX3BUIa6ZS8Dc0Yx2ksBtMlgJxtc6Mim4K0Wtsfjm8/Pfqh2D9wQJ3JXgVh2+QKubV+Vad4UoGaawO7yQ8uUJxNIrlu3RF6bWDA7zANM7eGw8eoIbHXNWejCc+HV0IJ9IJyLZ139ILTQML7sIERmQlestAmxCWHMzhdbSaQdAlzZaCfuEunY8zthUUynZr0kKnrM3AmrtMde/EgvwIAS3DJ7DQP+c4OLPtf6YtZkDSappZIgEqBCS1MN4VtJ9Ejq2ZFRQ92gZHQXswyN8mvuG9D8nXFNqX6D0hYqBBuTJHsd/eb93L3LXcOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEcpH7SI6Z6fm8Fgb996ZliNdfbGAtyZBG9zup93SbE=;
 b=HTBD/q8IuQ1vN5ZWRHf/m8T6Xii9gv8fINtMfz8esM/iRef7c9Th1+ezV19e80+gnVyxGTYm3qbgzu2HpyponKBXkJ1AP2o/+/G5hdIxkQM5PAr4tMjvW14Znmbwne4iuTkjodzjFrVPYJt8m+8ln/fFxBjLGROI9nOO0C9bavUO4aUJ0oeQKwLG3MzF+HoDx8W5KqWpbxNG193KWmHgdDOJVQtKWIP6+Jn85GqcseOhISikD5Uu4ayRXPaoYOuTacEC2hqV9Q5hXxyeaOT8CbdcjHzp91bgzBT7zQTWwVpeJPjNPE+7dzl8FhLfaNt99M587TbZyGDPpczX4wWeuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYCPR01MB8392.jpnprd01.prod.outlook.com (2603:1096:400:150::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 05:36:40 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4%3]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 05:36:40 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH 1/2] pathconf01: Convert to new API
Thread-Index: AQHaDWku7ih4GiOJPkOt2vokYIPAxrCPWo6AgAGU/9g=
Date: Wed, 29 Nov 2023 05:36:40 +0000
Message-ID: <OS7PR01MB11839237D06184F642DD1AC25FD83A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <20231102080535.63847-1-xuyang2018.jy@fujitsu.com>
 <9bcca18a-42a8-2200-c6c1-0f97b42e11e6@fujitsu.com>
In-Reply-To: <9bcca18a-42a8-2200-c6c1-0f97b42e11e6@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-29T05:36:39.726Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYCPR01MB8392:EE_
x-ms-office365-filtering-correlation-id: c2e45a12-abff-4627-13ad-08dbf09d29bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73Z9BTtIT2H+38EZo7lpqZLtDrKGW861EV7QlmoTxP4paoGmNC8FRMjiKSErBSF2YTGatzIkJMrOeZ1F1jLBTc3Gc6Kv+CGhk7U5t8hfX2vYqNnE3zSuKClrq3VzS66auT9z9Kh8nTrXBPs0TVwQViWub8zairMvj27MZ+ed66DoDr/mKIUvqOb7xEiS4M04l3ZYIgVptThvP14KvsV4VqDT0Lwjec8GuGcdUJPxQJJwKzAOCKKNAk7RbUCnvyt+Pj+vx8jOyh3/qLEOKBA+cNeM8apIbP3EsZXh2wr++cXxO1Bfxp7afzQR8c/H92PnB6ySpegWYzXOX1nqdPPaLqpiqekVdiS47Wi8Y5U/JuVNBS37HrkqlDo+n3VapTs1A0k8WfiCMDRKgQyWxXk4FkImB/4viQDfaO0TnEImWM1j1Nu9341GjuQCI1vhQWZOv3pbejlpSvblQW3xiDK8qVOuBCuqzT7U1Q13GPotFjYlZYFXbmsptEFRCWxPe6+ULE5fYrpiamjM0kee9FSK3wZSxJ5DiOnBPcrwpanV+iQP/YIEQxszQOKR9tezTJ8xpjEn6eVu72azdATCq5sNGtFOO+ExstMsiqWR1f+QeVKq6ViAL1lj+ZxLHg9IQJt2hRDFtdPu5DiNEoG1OaMjig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(1590799021)(186009)(1800799012)(451199024)(64100799003)(8676002)(5660300002)(52536014)(8936002)(66476007)(66946007)(66556008)(66446008)(64756008)(316002)(91956017)(110136005)(76116006)(41300700001)(9686003)(71200400001)(6506007)(19627405001)(55016003)(7696005)(478600001)(26005)(2906002)(1580799018)(38100700002)(86362001)(82960400001)(122000001)(38070700009)(33656002)(85182001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YldJbDh5NW56WTA2UlpHNWx2NnBnVTRNSDNJbUZUZ2J6V2JqWjNtQkQ5VXVt?=
 =?gb2312?B?akYyWjJEWXVqTFVyYnJCVmRZKzliK29FWGhINWl6WVVxTE9QZi9lK2xZRUd0?=
 =?gb2312?B?L1IwUmo4QjUrcVN3eXVMKzNIOHdCRE9xY2Q2cHhpdDJlQ1pNOCtlMm1OY0wr?=
 =?gb2312?B?QTFEZEk2RWpQSUxsL2dGeHlNYlVXWXd4Rys5SVBiNVFJcmdxUGgzWG80QnZD?=
 =?gb2312?B?SmtpRUwvSiszMnllcjFrU1JYTzErbXVFRm40SUowV2kxT09QQk5qMTVlVUUy?=
 =?gb2312?B?cWVFWTN5WjNuc1pyK0paMVJwNkFWYUh4eEIrZzVyVVhIOXpwZXRQYWJmcU9L?=
 =?gb2312?B?dnVBa05UeTArMWhJNXdUcmxESXZ6UU5iQU8xR2V3YldGZFZ3UXlpRDVBa2ZN?=
 =?gb2312?B?c25lOWRid3BLUUhBbWIxY0E0TXpxWFVtNkhRR3AvR0lEalplNEo1SVJQNzk4?=
 =?gb2312?B?MktjdC9FYlh1dUw1YzI4WUZTZkdDbVNuY2xLUWVtNUJ1dTJoa1QzaEpoTjNu?=
 =?gb2312?B?UWRvVlJVMGJiWW5OMmh4Z1hMYzZVQ0U0OXRGRkhkVkJCWlAvMmlJaWZEbDg4?=
 =?gb2312?B?MFZwaTdxV1hwaFo0amZIdCttRUVuenplMGRMZnNiRjFRcTNTTFpSYnlBMXRO?=
 =?gb2312?B?bXg0UXp3dWV2NVhIZXdXdG5yUUdncmIwVTNiT1U3UWU2K0IxTTZQTTZqc0E1?=
 =?gb2312?B?K0dRNTlmT0N1ZzJYdWd6RmgybVU5b2xWRk1ad01HUUw2eVBUL0FPYWpHVmV2?=
 =?gb2312?B?UlVCTTlpRG5ETUJUZXY5ZVdXTFFVZm5WSmpOTGowT0V1cXVFb3JzK3VicUl1?=
 =?gb2312?B?Mkh2VmJxR3dTdlZDSzRNVHZuOGYwOE82NFZYWEpsUEtPaUdXOENlUS9ScEZv?=
 =?gb2312?B?TGtlOWFyeDJaV05vZmdLdDdKQmtWZUVpYWlFQlNUc1MzdWx5U3hXNFdjaDJT?=
 =?gb2312?B?VW5ydXoxdGlzSFkyRkxnc3VkQkNwMVNqU1BhL3FGMzBoMmptaWpGQVp0TTMw?=
 =?gb2312?B?K2ZnWDEyTG5yTjZod3V0dnp6NXVaR21rNktRb1drblZ3d3Ntd1JYMEd3YnVJ?=
 =?gb2312?B?WUIvRmQ2VWp1ekZLT0dZK1dibDVwK2RzOGV2QmNKV3ZHNExYYURkZ1V3bTE0?=
 =?gb2312?B?aHVTNFlqQnpuRjlWRGswZ0thVUFlYk4zNHRDU2Q5TnpKaTdrNXk3cytING5h?=
 =?gb2312?B?MjdicHNVc1JieEN5VlViaHZPaGtzcElEeVhtNTRPZHpjU2NoMzRaU2FRc2VB?=
 =?gb2312?B?TDgyWlgvcGQxSGZTRHdMczJobTg4M1lDYXlzcklKZGQrUmVmNkJYV1N6Nm9n?=
 =?gb2312?B?cVlMTEI0b2UydThNZTJFMWNMbGtMQm41bzZZT0YwcUt4Y2d2TCtTMEFwTzZM?=
 =?gb2312?B?WklkeG5PRGZJU2c5R0I5M2tuMWQ1L3ZObFBRbTdFcGd4NW5oYlVucnBXQVg3?=
 =?gb2312?B?TTgxMVNtSFQyYU1uaEFUSHRSVU0raDkybUtBMU5pUUp5Snl5NkF2cHpzUUY1?=
 =?gb2312?B?QURMYUREbVFQK2NkZDRtSkloRGZTREU0YmN0QUczaWV0dEd4Yk9RWTJMbU45?=
 =?gb2312?B?TmFwdHFtMVV0cm9HcW5DV21wK2w5aG9EdUltWnlRdFZZUnJobXhwUW9hY0lJ?=
 =?gb2312?B?NnltNmRlcjFzbCtpMUo1MElGWlFaWlB0Y2x0ZkU4RGxEQ3JDdUttMEdlU1dL?=
 =?gb2312?B?bTFlSm9oeS9uN0RmbXlxK0hrMVRHblNKdU5LQk5KeDVMNGpRQ1llWE96NjZh?=
 =?gb2312?B?OCtGUzBDNE5mUkJFT0RnSjhHRmgyQzVScVRKa1ZIMzBHZUtnc3FBRUFwcVZB?=
 =?gb2312?B?UlRaMyt5ckI5TXZ2cytUb3FqR3piWnNvekdGYXd6cFV5SEo1ZUZBb2dKbitI?=
 =?gb2312?B?ZnBOMHlnM25TRjc5SGhDVFU4TUo4RWNwcngrNmcya0lLaTNRK0l5bzZLVzJW?=
 =?gb2312?B?NGtWYnc4Y1F0OXhiclhtUWdLVWs2L0ZDd2hNOGlNdGVFcXN6d3dodkVWSEp0?=
 =?gb2312?B?WlF4OURlYkJ3WlNvUWduR0EySWIzV0IxSVZBNVJSSWFWUzRKdVJwaVVmZEVF?=
 =?gb2312?B?MkFsblU0cnZ5b0p0cXB2SUdIT1F5WnhGVXFSMEVWTnpuMXpNYTd2dXpXaDFQ?=
 =?gb2312?Q?1djxK0vQ0gUTdfUeAjvjs6HcI?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pi1uI7gFrGwKEZfEFQYyeiMyCaOwmqK6n+4kCOD/vUXTbuGjYoqyyoZvVRhW9B+7LG0M6q5n2v8V+55BGjsvkrSVPRYXW630a6/FvVCgA3OFcWbrrTVGXIp3L718Z6DLBp6wGxD3Tbuv3R2CwlkC/Hbt1ajRbIOe8c6r4VmVTYcacNAHH0LGs2e9CgFYavRE7PdwFmZFy8tG5aJiGQjlD4lTOfsANDFAXEX+bUNoZLAoD/QMBdu+gfPYW7c275VdEHp9hfFjpTwAhj1mj7uh2UCBzJJmD5aYUezoI9d1/bzyTAKo5rIwr2/5ui9r0mjlisd6PpTVtIVzO7pBhmIyOHPb0b/Jm74fO+gtTUbSbPX+SGV5jJVX3N7F8pVSIRsQw/1iarm0Y/IF7TIqgKiFG3unp0izuqs7vbydjk0sd8vlPhMQsraFLZOt+WrZOtg0UJGnDEsDpqGA0wK9L3halIc63cHoYqUIK7iAgbqJ1aH0kuaROq4V6dVDQn+FP1LG/cfnuFycU7km8Imeb6LGXMkoD+TA5eLb7bl+mgKfmUSTw5JX09pdUABQzxqO8afKg68Tqs40RZDjY37BNT7DV6vsA2dP3r6VryH7bTDtDRFMo9nQE2V6oL3x0tG4HXJJ4bUtG4fWWUvNDR2wJEOyhcEbC9upd5/D/zBIPhZYuDgEoGUEaMrpkaoeN5v0o0q0XiN9PbMlXhNeiNPkj3IZQaZrKQVoYLN7YHKkDayMdoai4NyTNHost8tQ2UHEspS16CAo9SkFJaUhRlDvcOJMQA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e45a12-abff-4627-13ad-08dbf09d29bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 05:36:40.3622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Devt4C2qKtkr3M4NfQKc4J+dG1aR7uK72U89T+DX3fPnJHpoAdpcZT4tFVaS2QvzbK0Ht+0NawDuhsIA6ipygBa+kT7SZiDo5sTC+a6TDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8392
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
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

>On 2023/11/2 16:05, Yang Xu wrote:
...
>> -struct pathconf_args {
>> -     char *define_tag;
>> +static struct tcase {
>> +     char *name;
>>        int value;
>> -} args[] = {
>> -     {
>> -     "_PC_LINK_MAX", _PC_LINK_MAX}, {
>> -     "_PC_NAME_MAX", _PC_NAME_MAX}, {
>> -     "_PC_PATH_MAX", _PC_PATH_MAX}, {
>> -     "_PC_PIPE_BUF", _PC_PIPE_BUF}, {
>> -     "_PC_CHOWN_RESTRICTED", _PC_CHOWN_RESTRICTED}, {
>> -     "_PC_NO_TRUNC", _PC_NO_TRUNC}, {
>> -     NULL, 0}
>> +} tcases[] = {
>> +     {"_PC_LINK_MAX", _PC_LINK_MAX},
>> +     {"_PC_NAME_MAX", _PC_NAME_MAX},
>> +     {"_PC_PATH_MAX", _PC_PATH_MAX},
>> +     {"_PC_PIPE_BUF", _PC_PIPE_BUF},
>> +     {"_PC_CHOWN_RESTRICTED", _PC_CHOWN_RESTRICTED},
>> +     {"_PC_NO_TRUNC", _PC_NO_TRUNC},
>> +     {NULL, 0},
>Hi Yang,

>What is the purpose of the last entry? IMO, it is equal to the first
>entry. Other than that, it looks good to me.
>Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

>Best Regards,
>Xiao Yang
...

The last entry doesn't  make any sense, I'll remove it in v2 patch.

Best Regards,
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
