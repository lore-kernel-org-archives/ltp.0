Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C82FC77B7F
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 06:26:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D917B3CB690
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 08:26:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4608B3CB26A
 for <ltp@lists.linux.it>; Fri, 19 May 2023 08:26:27 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 64C861000CED
 for <ltp@lists.linux.it>; Fri, 19 May 2023 08:26:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684477588; x=1716013588;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=hQdHqEEMirKTlzostckGJgjGRpasyPML0902Dk4+dKg=;
 b=JUjkAWdGeM71sQjc+3dUej+KEsCOGBhKgEL2LysABkIjBLrXMYj896Df
 MILyBX/9OEO8lUD5eao7930Xt34aGoAaTcknp2vYdtulr40Zaoo1N3bQn
 uehKKpUe9buhqEqoi8l5O8swxl1bCRo5wAOVMPpjz6o5hUJ2xhgW1Ky5N
 r/BDp3HJnfEufJhSLdd/wdsfCQY31ij04mXZMRNayguUq23bzNoyj4Gqs
 de/w9m66g7yM6OqguE2VM0hnj6moQHkLJRAcsMZ30nBlG+vK7l87cwKkK
 7lFQO0oLjEwP8jMjv9qexEL6w3VY1YqS46lsvBO61UjXrTVOG7BaiAd2Y w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="84687747"
X-IronPort-AV: E=Sophos;i="6.00,175,1681138800"; d="scan'208";a="84687747"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 15:26:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0YxJOzV90n1wCK7C5W6Axllp6CaOTDNCQq5wQydIhDMFzVHkcrt5K4xFAMi8lNiZYtkdAofFvMSrPQZnXMLHBCTcVMS9jPPsdLCgy30wkE6LxowGRuff60YL6uKZWIaP1H1qNeqnzpgsYr/FoKtAMJ1MxqufcVZTVNw75sUPz3+b5WqAMKPelMRbqlWKbeUo8gDN+wqlNMKt4QFgqDk3sHSHNyyC6QkRaXqgfiEUvWQS1r8XA/juoJXYpaHyqJ2O/9gSZz1dLx9QOnJoYqSqJqL6rQPARbqL6gGOxvj71R5KzXy8Kr0pqAcjdvQV4hvTYuXsp8DGY9C5abRZNIA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQdHqEEMirKTlzostckGJgjGRpasyPML0902Dk4+dKg=;
 b=AMdN93gSaPO8Zuchp6uucLWMPBcez4Z1vZllMsMNM82+V+P3Ymp8H7HdImUIcleTy4AVUbLwUbAdQtuJz8tttVoMRPeEHksVc9JU5XjnH0DeYbkOMY2Qel5Pf/r0W9XfIismmhPRzl8w9cmHoGgv/H8rejosik/MRJcWT0EoBivr7CeuIiNmKAvkD02Z4R9y8tl7wliTCbHAcj0OF4tA3nBt3DWU9FJH54u6h/ENKsprw+gqfGGyRds8nu1iPaC+pZHfGUg1wOobhF5WqnaLpDuLDoES8rUBGw2/g3ys45gG3eVAT2gLFyuSwL+NB/9uMGgn5mnK1w2fP9Dem6VQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TY3PR01MB12024.jpnprd01.prod.outlook.com (2603:1096:400:3dc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 06:26:22 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 06:26:22 +0000
From: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v6 2/6] lapi/stat.h: Add STATX_DIOALIGN related
 definition
Thread-Index: AQHZhvyNTXA4YakoCUuGFr9S9ScLKa9fkQeAgAGWp4A=
Date: Fri, 19 May 2023 06:26:22 +0000
Message-ID: <33871b58-c338-3099-30b4-310cffcca1d3@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1684134680-6190-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <7ac7fa23-99f2-69ce-a0cb-25387682f046@fujitsu.com>
In-Reply-To: <7ac7fa23-99f2-69ce-a0cb-25387682f046@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|TY3PR01MB12024:EE_
x-ms-office365-filtering-correlation-id: 07cff7ec-8ac5-4cce-c3af-08db5831f707
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9CkSxUYs6PoSnLgqi2oDG+f34OYS48Jj1LI4yEAq7vCIkR8NtjvNlAVHs7K90fqPv/M5zdolsLP1kYu95VUWEq2WNJKhv62RsMQTa+NlURADR2rPuOCDIzCx1aNnJ7bZiibUgCFQ2WPwYvqjtFaLSJE2ig65/4By7vi4VULpdasB7nKk0ODg3/GvRsNgqbvweKpUsmTg3DCPaDR0+S6LNSIfR7IzSVsvJ9vH86C89ZJx9cPgj2kff2qfek/hWPc0dQg/fCX1b4MjQs2kw8LiB1EFTtiHyI/ANGSM/1SouzroYdIvNlLEi0HpDVgaiyvWQF2rpfTId3O9srJtf2+62eu0VOaY7MACMH8MEg4/6/cesZ5/Aki3tINQaX9pJkdiNHW/9Vcnk6jqCL25snMRRvsk/oZ6cK00SFYaVVxLTiLmTtyPv9GPJ4JgJc9ixFQ1AAoWN9SGxZXRinbkEiFZfpUqU3//4BTstfVkVHSs3Q2A/Scb0CX3Xz1zeES2TtCd5vhyq4pB5haZEP5ZaRxRhUZM45Mi6XtH8ESMpj7gcHsifU1I6HkyoX8EPQ8kvMugJylqShxCb240RjE4Y2JnxfzFfxyzrFLn+chnVrkmGZ1ukr/NT7iILX0Vr2NSHWWNyrBPisj44FmJLZpRf8+fIQB22Abj/A5DPU7uY8foxWWyx9tdBjKPF/VVkYXddlC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB9499.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(1590799018)(1580799015)(31686004)(36756003)(122000001)(82960400001)(85182001)(8676002)(8936002)(5660300002)(316002)(41300700001)(38070700005)(38100700002)(31696002)(86362001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(83380400001)(91956017)(6512007)(6506007)(26005)(53546011)(2906002)(186003)(2616005)(478600001)(71200400001)(6486002)(110136005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek0xcnQ5K3VDYjRFOUo2MjhuU2tROVBnSVM1Mkp4UlQ1T1M2ZkxvZUVkYXpY?=
 =?utf-8?B?OU0xOHdqTjAwMlY0SVpTbUpoL2wyK2piZUFTS0E1bkJSUXQ1N2hxVWhoTGI4?=
 =?utf-8?B?azJqWWZVYm1neTJvU0ZrQWh3UXVZZzRrYmFzVjNUZFN6eUpTN2VvaVl5d3A3?=
 =?utf-8?B?a21xNTk4Z2duZUdObXh3ZHF5TmRLMGF6di9tRjhhL2dhRDJWUlRyRUZJZjVp?=
 =?utf-8?B?aFZYTHhQUkJkbHA2ZEkxWStTMnA2U0c3d1B6dWd3NWowbnkzRjJXYnVMc1Qr?=
 =?utf-8?B?NEpTK1hZQ3RjQ3EyMGxuSnd6NjQyN294cXJUdkxaZzlTRXYrZ29CMXdwNjlq?=
 =?utf-8?B?MjRxV1VPZDQwQS9lRyt4RHJCSEhTZ2VQcFM2ZkgvNkVKczlweGxZeURFNkJx?=
 =?utf-8?B?Sis3QkUxcnBoNkE1YnFncU53S2dmQlFoYzh4NXVwWVpBSXoxZXVtVGFmUVlz?=
 =?utf-8?B?czZMYVo2MXBSaTVQWGIrT09PNEdnSTVibzNXMHBqbjFMbXdCalVkZ1dZTWlm?=
 =?utf-8?B?WlNNRklKUDNHRy90a3NDUlFyaXd4YVdBWXg5RUtVY2JGOWRySEo2ZjMvWWw1?=
 =?utf-8?B?N2ViS2tIRGc4N2cwV251ZUl6Y3lBQjVkQXd1NzVCWHpPbWppU0tDUUVPL3Fx?=
 =?utf-8?B?ZzFWditOWDh2MkJSRVBFQzk5SGFSVmlLSjA5U3ZhWkI0OFZES2JDYkRTZWtK?=
 =?utf-8?B?aFpPSjZKNE9Xa0RaMkwvcHJWYzc4cmVCN2dUTk1qd0FGSE04OEhwVUVGTkls?=
 =?utf-8?B?c3RSQ2xFcmFaZStFYnM4amVsQzF0b2J2UDQyNDc4ekJDSnE5Sm9vZGYxdDVj?=
 =?utf-8?B?QnNjbEdFQlJzZ1J0R1ludFN6UWZCbmRhQjNHRldNNGlUY3p6cWxnRTVlWThE?=
 =?utf-8?B?ZmIzSjAweGZpYmQrelVnS2VKSURHYURRSXNMT1hyY2FxSDJ4MTBGQmZTUXli?=
 =?utf-8?B?S25DWjZZQTVldzJoZDgrVlBoak0zUnA0cElYbHhGbEJiNmNIYng3MW1mTEI4?=
 =?utf-8?B?MkNVbDlsbUtKMVpTOUx6c0pnWjBTTVVOdjh5SHlEVXlBRk1KLzJ5MWlnSmxR?=
 =?utf-8?B?RlRsUk5HUE96Tjl0dXQwNmd0SThRMDBiM0hwdk9mbkVnS1EweDQxMC93bGc5?=
 =?utf-8?B?bmpsOXpxNCtXalBPUTB1d29TRnlPZW12QXRpT1FyTlhDOEIzNVgyRW1lbG0y?=
 =?utf-8?B?YjV0MnFScFpPeHk3OG9FTEhrMXoxdTN4WG44Y043Umh1NnJjZE5BV1NYcUxS?=
 =?utf-8?B?YTlXZ3c0enVwd083TnF6TG1sNFc1R2N2ditwQVBMQkw3djNxQklQQTIxZ3lL?=
 =?utf-8?B?b3RzOWRFWGxxUVdHdkVGM2ZhRkliT0FTRFNaTXBHVFF5YTE1R3FUZEZhTnJH?=
 =?utf-8?B?STdJSG4wVThvYWc4bmRWODhXTloyMWlDSnFDSFV3VkFYQm51UFZDalA2STRN?=
 =?utf-8?B?LzBFWXR6OGFacE5nMXN2MEhwYm5YNXF2RHZmU1U2SG9zYWozblFSNnl0clRQ?=
 =?utf-8?B?RGpCVGlST283YTJ0MDQ1cUZ6VVNsTy9IVGVNcG5XYjVTNVBpNlY3aGVBZUo3?=
 =?utf-8?B?OVhVNXp1Z043ZldkOUZubmpNbHNFaUgwTXFSOGhEUVR2aktwVEhidCs5L0tw?=
 =?utf-8?B?SlhlVlovc0pEUVM2M01GdC91Vllxa1VsM2g0RHZ0TFNkTm9WaWpXZUVQRzBv?=
 =?utf-8?B?VENhQXNSQkFKTnMzV2FlbmM5ZmZVa202d0Ira2hvbGxUNWtFQUdreXBEQzkx?=
 =?utf-8?B?c0tjbDNBZDdFakVXVnNGeG5kT1J5d1lEdzZPTUU1Q29CdDZhNW04RTQySmNr?=
 =?utf-8?B?WlladDVyQWhvSmZPbkYxTmtuREQ4NmtyY2RQZkFQczBma0RDMFQyejJBVFo4?=
 =?utf-8?B?c205T05hcndBaTlML1dTNEx3TENVZk1oc1hsczF3cU13eXlyRjFkMTNob25k?=
 =?utf-8?B?L1NKZU00bTJFcU4yaFFFTC96RktNTE1tOFQ3NEFqV0dYVHhUVkd3MHRHOGZH?=
 =?utf-8?B?VzdxNjNraVhkVWQ3MGRhNThrczU3dFY1dHA5Z0YyUldZRkQ5M1VvbUFxcUV2?=
 =?utf-8?B?NER1T2Z2dEhZbG9jekFjTkNlTnBZSkMzQWxiY2ZySWllMWNBcXJ2eS9BcThB?=
 =?utf-8?B?M3NjekZUdk1kTVcyWTdYSmNycDhvTnovVzd2dEFLY2hxNVBoS1E3NC9hSjVp?=
 =?utf-8?B?dlE9PQ==?=
Content-ID: <9A1C0938F770C04780300A8C4274AE91@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: frx2ptuX8w5c/noPnOPrNfYEt1Zu5VFloG8CMNxHj3HTu0u9nu7ktpZUAlFDAMwMbecGfUnrJoJu46xpoGQ2qsfl5PviC+O2p6/n0tOyzluuxe+OIsOUkuh2tzhnNDaFHN2uuUGdDRZMPqSLSFtK3gwWPVQn87gVT7GDHggBzt8wjD6B23PpQxGg/rxLL7/8CFvi2k9+7vkyTuPTQFU8dCiC48aoBZTn/qBqBsk3inUG0BsnZPU/LFt8YXPUw5Gll4DGO3BjcXecsHaoN8TuJ7ek2hk3dBw1l16gX2VWnxb/BcWcrVe9EfZHdSxmT17jsEaOz8aZ4beOR0ZP3HfGAgLWguWDWp7mwhraCEL256xVPhiW0XqJFfZ+xCS7gxHos8eDwE1Ij8L3WXXadmhNKEKI9lFR2W1v8kCB9XGOrka3USnHmRTWoU/3Ygj5p9vUnT3eSfHUpfe691J3zW79ahOoZ7xMIPgxPAsdvZ4l8JYuACgQOChRtNQD/G6IcSuTlST9P/P8z38eLIPeQzMFyeWs9V6XetPNNrxs/wEe59lhKS346n4GN0iIrLPHV0phb/UGDI1mMjazhtDcnylgBHgs2PcFFaXkse2Ab1WS14YQV6yE83G7cdwR5lbfs5/sEatjxeDehshBamv8+SNe7YNXRnwRE9mvT1zKY82VGZ7pHDsYaW9j40PD7UWu+gEIz47rrLI0vOcDzUWjs5npBZ4EytEHrPEIFGIwTkEz7AOBNNIgUdAKmdbsjgbKjBBMCOQuTZFZSJ6w8PVfyk33xQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cff7ec-8ac5-4cce-c3af-08db5831f707
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 06:26:22.3764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2JtbiAQTZLlkikoHTKM7ojDiRyG8SXz2ktEGYDJNFS8c/x11UmtjJU1GulpCnk6F2OlUVkmYZ5zwp9c3qLl+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12024
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/6] lapi/stat.h: Add STATX_DIOALIGN related
 definition
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

On 2023/5/18 14:10, Xiao Yang (Fujitsu) wrote:
> Hi Xu
> 
> LGTM.
> Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>
> 
> Best Regards,
> Xiao Yang
> 
> On 2023/5/15 15:11, Yang Xu wrote:
>> Also add missing stx_mnt_id.
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>    include/lapi/stat.h | 10 +++++++++-
>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
>> index 590ccd111..6ed4b6637 100644
>> --- a/include/lapi/stat.h
>> +++ b/include/lapi/stat.h
>> @@ -97,7 +97,11 @@ struct statx {
>>    	uint32_t	stx_dev_major;
>>    	uint32_t	stx_dev_minor;
>>    	/* 0x90 */
>> -	uint64_t	__spare2[14];
>> +	uint64_t	stx_mnt_id;
>> +	uint32_t	stx_dio_mem_align;
>> +	uint32_t	stx_dio_offset_align;
>> +	/* 0xa0 */
>> +	uint64_t	__spare3[12];
Hi Xu,

After looking into the logic of statx10 and statx11, I think it's 
unnecessary to add these new members into struct statx.

Best Regards,
Xiao Yang

>>    	/* 0x100 */
>>    };
>>    #endif
>> @@ -180,6 +184,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>>    # define STATX_MNT_ID		0x00001000U
>>    #endif
>>    
>> +#ifndef STATX_DIOALIGN
>> +# define STATX_DIOALIGN		0x00002000U
>> +#endif
>> +
>>    #ifndef STATX_ALL
>>    # define STATX_ALL		0x00000fffU
>>    #endif
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
