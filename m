Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0F5C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 07:23:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C6CA3CD95C
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 08:23:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7096E3CC2FA
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 08:23:12 +0100 (CET)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 62A111400BE7
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 08:23:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1701242591; x=1732778591;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=r9lkEBK+9rABOnaivt2uoc75hlV7w7kaE5e2sbcKNfk=;
 b=FkLpJJhHF5Twvj0gzOPc8m47qB/0BIHlGSopKoQF2UtR8bIwOqFH5d/I
 b4a1PLHd0SxYgv+q+cZBBYTGiIYbsRFFSyT1nH7XbSp4fYnn1WgqoWUaU
 W1uGS8x6Xj7jD1wO8osUJiYzRtsNL2VZIdDhcaAwaoi1UnYwW8EB0ZnW/
 9QaIr8KbyYsOP4218eUsafqws0AFL+wobsBh6ZOODbFXgzBJgNKiJMWZ2
 kh1ZCFhOI+rMhmMG93/7GJrHUZN9YrOiUkAbnRBWPDJknWBV4ZUYLwMqB
 dZ9EOu4ucd3wQEuX2fbmCu3PhQ8y0S1XL/M7wdQFHekx/fG97+jeuoIsh w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="104206494"
X-IronPort-AV: E=Sophos;i="6.04,235,1695654000"; 
 d="scan'208,217";a="104206494"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 16:23:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ag8mVoFabTnCSwuhx0kPrdmk9WmcmPB2iwi3hyrzMP4UMCVr2ap+ntpyO1TVvo2bMpWA+MIUyPCTThiI6QqM/NVx55t74Fv1KHPExIQVzWXBQPEA4+fbsPNi7UD/LSEr50it3Zer6LqhcPUdGiC2xnmoFklRUIzyt3xtlCQ3rCZVJD6PvbLf1idbCkURGDnChD69oswAtknL+iUQ2YdV7de2pn4P+SXdO/4l5Bpm72MwBVaIvfW2OO3MdCrBh6o2GeiXNe8VeyZgXU4TVgd12AaLzB5X5iRqVaQa59Z0RIZb+pl5BfKnwxzOAiLuZ1xBvLfiiE3MYhBQFwkHndqFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9lkEBK+9rABOnaivt2uoc75hlV7w7kaE5e2sbcKNfk=;
 b=GScZ8zMHxcIcanTsP/g3SgdsZ2vwRWV2K/T4uqs2d2ksk12slacb41SqjFgsrLPV+g7twWe1pJwKuqtEL3+/OyfOA3p1KSl+mJZHpPVweao7VX6bJN6M5OLD5MZrAL6uOga2kkNKXtvUlGpuqcpDoLZRIbGkCYZNhBxDrh1MbSpM3szcAFaWEtCItHKftQ9s17svuupNjUhtPalwZwG7KgisxP9K0seWDEdO11SaZB4/zFRojXVnKggjtdyGsiNFRKs/X8RTNALOEMoSYgnjLh2/GxqdptxXTIEPwY7hqiTTz0R2PSzRfwn/Z0MFOSS9BpckPzVmhy1WS0+0l6mEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYWPR01MB9886.jpnprd01.prod.outlook.com (2603:1096:400:236::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 07:23:04 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4%3]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 07:23:04 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH 1/3] syscalls/fchownat01: Convert to new API
Thread-Index: AQHZ+zqjwRv3r5TiikKNjIWkGVHkTLCPj0UAgAGjPfI=
Date: Wed, 29 Nov 2023 07:23:04 +0000
Message-ID: <OS7PR01MB1183928A79B0CC1F684C972B7FD83A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <1696915709-6304-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <33f133ac-09c9-755b-8ba9-d09f7ea0a611@fujitsu.com>
In-Reply-To: <33f133ac-09c9-755b-8ba9-d09f7ea0a611@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-29T07:23:04.100Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYWPR01MB9886:EE_
x-ms-office365-filtering-correlation-id: 67dc16b6-6f74-4c84-9bf7-08dbf0ac071c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 12n5RIJxfFWBOisPT86f+Y1wIkFK70/7dpa6/ES4lCZtUVWCOG8EC2ah8cHm72+5jJMX41MSgSifkaNjFZUIrok3K/QwvlzLdnNEgUUew1CsQmQjwU7Xb5311dlziN2GYVPlYVgeWS0CxL6ZlIxX/yvLodZJQfqk+NbBzIlFB2MiQEAeN9dmiuEyjZowhydK+qHa/xBPdvCnHlr5XO7Fhn81e4b4V7aU1ky5s+31PCnvnloN3V/c92UtC/5zr0D25HKsZWi9eTZVMTDD/YyfxcVgLgUw5V5Waw97i94hdND4FScR0rXCJuTPpV1wX0X0gwkRyFMkIdvyhOEvfWbmiWkiq6Dfb+ThDWP8zJM784nAr1czBbtfddeFwtnvyaaz5mx8NnXgerjMd/JX8ubW+rgKDm5lphrx+nAorg0SUeANf+NiHeKy6WvbD3YoXvIg7J/DgY5mzGxlXk1QbFo33Ag7RdgiEraM7bgi0k6s4uOk6HlK6dVPTR9JHxFVgJBNy+HZuFrwZMWQuGRLN8VYcWhBxlzRlr29IumAXl8+96SenYMHVAhl9LZwUqJuaTo5w9Y3biaxhyvE79eu/91DzaMQ/s7FBUyTv0Du9JsXTLnOOS1gmkM98jUfK9gaEuYWiShd050pC2tBnvjBLooEOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1590799021)(451199024)(1800799012)(186009)(86362001)(64756008)(5660300002)(316002)(66556008)(76116006)(66446008)(66476007)(66946007)(91956017)(110136005)(8936002)(8676002)(52536014)(41300700001)(1580799018)(85182001)(4744005)(33656002)(2906002)(55016003)(38100700002)(82960400001)(122000001)(83380400001)(9686003)(19627405001)(26005)(478600001)(7696005)(38070700009)(71200400001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WUErcjZvMEpnVi9yS2taTEFkTEdlUG5zOWhqejgxeHlYNzUzVDdEaFVIb2ho?=
 =?gb2312?B?V3o1anlKTkhzdTYzZ1VON1JHRGRSTkZEQjQ0NmxlMWp3Z2xrMCtBWUxrbjlm?=
 =?gb2312?B?aHhNTXlSQURiS2ZOOENMQVlnU2pWOXBSV2FzckxjVGl0R2wvMGFZNXY2cVMr?=
 =?gb2312?B?bExWTklYVGNXQVMzODBidzQxWklVUlZIUUlOKzZIWmhBQ09OZmRHWGc3V01I?=
 =?gb2312?B?RmdyMzdkbkxQWXpRN01XbUJLYXVXd0JsaWNSNEo5ekExT1NuZFlrdnFGeXlx?=
 =?gb2312?B?SHFyVzhxQ2dEbDY1RWMrdDhCQmhtVTRYcWQ0eTNucnM4WFd6NHNacHFwQk5a?=
 =?gb2312?B?eXhYV1NETWRYWnZSU3BWU01URm0vdGJlMFBYU0t4ZnpwaVpXNWNITlJCZW0r?=
 =?gb2312?B?Y3ZWODJuTDJkLzAwdHVMTVpESDZpd2tXOEVlN2lIZCtLK1phQVhxYmZFNWZx?=
 =?gb2312?B?Zk9kazA0MzZzVkNaeGxEYXl1SnJSZG1EanB1V2N6Nk53QjM1NEQwM1ZwT0Vq?=
 =?gb2312?B?eGliV1JYc3hGZjZpcEhCUW8wRGtGMWZrSlF6cy9laDYvVTVIYTQ2bHMrUy81?=
 =?gb2312?B?cWVVa0NCdFNCdXlDNm1iVTA2TFIvMHVoNXhoTHliQUtRNzNnOHhmL054MEZI?=
 =?gb2312?B?VnRERnhvbmNnczRvZHFnbWo0VXNNZjRLTEg0Mm1FWGFvZEliMStEenVmOWZy?=
 =?gb2312?B?YmxBcC9wUVZQV3lJU05GbG1ZaVZUTEJSYldLdGMrczg0VFZRbWU0Z3ZUSGN0?=
 =?gb2312?B?MDlDUUhuMGllYlEzMHBDVmUrZ2JxSmpxS1BHUjF0TkVtaFRDWkxaUTlTODh5?=
 =?gb2312?B?TnJDWmd0SHFuWHFSbkVlcVBnMG5YNjJ4clBDYVJOQWVrckhUK0V6WVRvSmND?=
 =?gb2312?B?V0VsbnBrNU1RbXRUVWRqdzRlUzFDT2xnVXlQdnhOSDdNY2M2M2dwbTU0RGxD?=
 =?gb2312?B?SXE0Q0RoWGV0cys3WFdsR2xEbm5hM1FBVWJTOXNmcGVBb2x1YTlrZ2tvdnNP?=
 =?gb2312?B?WjJKVDVKOWF1UGRZcjJCYVIveW52Qk1nS3VsODJKN0RsRFlaR05sTFlpM0Ny?=
 =?gb2312?B?bTI1cFdsTmEyV2p6cXdUYkc1YTJTcFJwSTNkSzRrVWd2OGowdUhhRlg2VXRm?=
 =?gb2312?B?MTE0dmVFUjN5Q1lkVGl4MjhJZ0Vhb1Y2anVheW9lajRrSXFqeDdYTXFMYytP?=
 =?gb2312?B?Q3RQTEJIYUZEUzVSK21mcVBQMmFmWDNraGpvTVRGcm1IODN4NmxaNjNRamcr?=
 =?gb2312?B?YnhNdGFKLzQ1bUZ6dlhGZEErdGdXai9uZnMrUTR6RE9GSmxnZmxSM1VrN3B5?=
 =?gb2312?B?NFcya29hcmR1c08vUHkxYlh6NW9RbXZKR1gxV0VaZC8rMmkzWkRhcUpxQkly?=
 =?gb2312?B?MXZBQ2piK1VpSXN1QWVpeEJOalNObFIvRy8zUGl4aW9aWUZJRUpEMmxiUUpr?=
 =?gb2312?B?TDN6TEdCT0w1aFFsV0NXUFpIVFB4RmxTS3hvQ1JvUXpzaUpyeEJQN2pqOUR4?=
 =?gb2312?B?NmhBc3FLcGx5YlVsbit6UzYrZStidU1nNU44RUxFbm14cDFiN3hHNk5aSGdE?=
 =?gb2312?B?eUlCSmhTTU93eThkTGhzaThHb1RQMHRPZk13d1hQWGI5Z0dXQ1A1L00vUnZ5?=
 =?gb2312?B?YU94N0NJZklBTVBIR0dmbWxCRzEyNDlycVgzSVp1U1p5Q2pseUdyNFN6K0Uz?=
 =?gb2312?B?WDFnQXJqNW5ZODJJS200NTBROFdSU2U3T2tzVkdmWUJXS3dHQmpGNFhoOVdz?=
 =?gb2312?B?MW12NUZvVmd5OVd6eWNkS2duZXBjTEt5aXVQRXJsRWtLTFhBVkp5K2NLZ0Q1?=
 =?gb2312?B?NlhRODNqV0JodDZwZEI4cFMvTDl5U3gxZ1Rrc05OM0pucFBpM2s4WVhFa1ZR?=
 =?gb2312?B?c0dScHNFcjlJZEMrSFN5NzRhVlpwSER4TzdoSDNyemQyYUpJKzFoenR2UWg5?=
 =?gb2312?B?c2lPTGxYK2ZWcVRWdHA4aWpJcmlOc1pjN0dPWXd1T08raXRrclZRN0FzY2xN?=
 =?gb2312?B?cW5LYWw2bWVuaUVqdFJuQ1o3RW9nUmxUWHRudDUrZ3d1NW03SVcxaHVYS3BE?=
 =?gb2312?B?UG9PUGFLUklndkhkMnFQU0pkQTV6ZUs0eHAxUml5NU1JSW5Zc1VQa3RSdGxi?=
 =?gb2312?Q?ogxqCBth9SHjV18UEzVLM9AMv?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gu++Xo14Gtx5U8jJsZpiNqz/gR5bBpH4LEC63/lTKewIIjZ6hcejMqKLO3waxLJvT4ir1Ij+6PMfnOmlcxb1Byj9Qne30sJpjk03FlSvlwrcIJBaURA23oGFH2XMMhz3ETR/uAf94TiQFA41zqrYuGlLfEH4sX20Wrg8moYnOJk2hjZoijt+b9hyAaMNMnszlJOb68D3t+tDfnddZyRXJCjoJGfw5vTTDxmwURHMkRnfAzJLtJeOj4deX3XDHh/M1oHpILXvsAgK99I29LSkENOkj7HeVAKZNDedZV4dEtrpfkSBrZn+qjXD4A0fwrizsN0exADO7R7JdXiviqVeOu3SbWrg8cg4p6k9RB3d0snFffYD78fXCZdXHNkSTsyoi9EHthCK7hmYo5a95o01K5QwDrDe2rlQRDQ9K3Qi5wRuppdmt7LfBMeZrayugzVIu+/1N3Q+cHqKBeyp+AaJsnsQDwupHwd5vl3NnGPEUEsQOTkuXXYj/B1XvyHGwOTFXHHjyrVb3HJLohEG4UBuaNQhguJsQFbhEmvVJt79smxpDIjHYtGMYyjn7EbQAPnb37Ljyl3vyu9Yp3nzovnUCZPh9F7qK2jH0B0ggwBKXn+vumJAI7RnQ4Pi4IWpYnbGwekY0ubjZdnbViNVR4LuKjqQ8NCeVfiOsJqi+tEh9fL4zaKLtekTK2tWtna0wSwsrtphsJDZPlIFcomhQnJcm3pjOWIPNutxcYKN6Tzz6KnCjqmRlZqPuqb4EvaMZClfnWOTCZAqCspSwElaNtgF2g==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dc16b6-6f74-4c84-9bf7-08dbf0ac071c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 07:23:04.6906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+TBhCmWNYffrQjYdTv9p0BO7bSl35L+BAWkXX2gX7Xi796F9eeEk1Lh3ZMqo0oRvInJ53ctk9iGw1CeTD1FIPcfFoEDMAN/NoZ/bfnbCe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9886
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/3] syscalls/fchownat01: Convert to new API
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

>Hi Yang

>Please rebase the patch set. Thanks.

>Best Regards,
>Xiao Yang

OK.

Best Regards,
Yang Xu

>On 2023/10/10 13:28, Yang Xu wrote:
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   .../kernel/syscalls/fchownat/fchownat01.c     | 155 ++++++------------
>>   1 file changed, 54 insertions(+), 101 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
>> index 3b29f1e75..7bed555e7 100644
>> --- a/testcases/kernel/syscalls/fchownat/fchownat01.c
>> +++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
>> @@ -1,134 +1,87 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - *   Copyright (c) International Business Machines  Corp., 2006
>> - *   AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
>> + * Copyright (c) International Business Machines  Corp., 2006
>> + * Copyright (c) Linux Test Project, 2003-2023
>> + * Author: Yi Yang <yyangcdl@cn.ibm.com>
>> + */
>> +
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
