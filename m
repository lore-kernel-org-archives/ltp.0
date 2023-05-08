Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED82C77B7C
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 02:33:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80C2E3C030F
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 04:33:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B87C13C0238
 for <ltp@lists.linux.it>; Mon,  8 May 2023 04:32:55 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ED2CB1A002CE
 for <ltp@lists.linux.it>; Mon,  8 May 2023 04:32:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1683513173; x=1715049173;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bXPiYwPYqmDE+7Ft8uzTW/RLOUamTZH7AnVJCTYhtNw=;
 b=b2EyZJf9VVbcuPHlevMbmdWM+UOY5foiukoqiZ/MFxwAW/me7ujBx26C
 NNX9C11UdFJqh7sMS6P3BJ+S1Uhn0cG2eL2PMB6Mg+9BJLZfxD88PGnah
 gcb1FSKfTk/lAEStSrrOty3UPICLA4I94oXJNXlwRHiRvaVnDdYjfLOsg
 +kYcJzmSyFy7bkCHaVXRjdckY83RYiOSKiEr98NTZHivUQjESByRCdI4Z
 3Zu/RPRihToW6G8petggVgSXnjUTf86d+AkcXkuC2uyx5CmNMVTb+2r2M
 9BoHwcPpM7FgYlY+b8zMP+4bkWt/ERxHMa31qPFhjE9nXWxnbfsPRoUQi g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="83872787"
X-IronPort-AV: E=Sophos;i="5.99,258,1677510000"; d="scan'208";a="83872787"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2023 11:32:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+2n6ERvPSyFapaqoVsUrrbM2qBsVv1CxHl6kBwihQgb1cNROe4G6qiFAxV3Vun6AvFzv03Z9Aux06JgJoE+uOwlnls8xLqiM+BxTtMVlXzJ4P8+TddcGALlCy9bJuaPyz0dMKLJDh2n9F87M3zj5tS+LhRPt6DDDKc6KqbJwygIg1rwgEWaXa5f6+Tn8/cAVks4AWogUzqv/zJPmeuc4I3K9ly97WV8gQc14g36TmKgO+JBvrNH+kwHuCxkv+2LSZcDQh+CPlUHUvtm5smOTlTmAfvBXMkqdJqJUJqtNYquiIEdK/Kjnb4WKzV2sTEc9GDZKh0LS63mi+XO8FP8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXPiYwPYqmDE+7Ft8uzTW/RLOUamTZH7AnVJCTYhtNw=;
 b=CTD4d2Eo5GqJceXCOg9gxnuVcwqndumj+OkszkKgC7MdukbFsdDcAuY20IhiPRCJFj5aUs0RyEgPhAkvDNczQRslPNTJ6AxuEZtc/NvlrmtHi7wkLSrXjwdhiIBl9carXn5hz76cEdQHn3aa3HXihbuAVqBAazRAu4mw1bAkrnC365sGY3vJyUhZCtYJTNVF8j41c9eTJMVEoaYEGdN3YM2DTuwT9fpv1H3x5jhFGVV2k7XaQ9dWUBYIHwvAoL1qM6ae+jLjpbahL+keroCO2twDG1mtjW4J+2hy23l0jGvekU7/6h0+rV1wmdIwVocY1ZNE8vUG8878MsIzOA6TgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by OS0PR01MB6180.jpnprd01.prod.outlook.com (2603:1096:604:cf::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 02:32:48 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 02:32:48 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: =?utf-8?B?W0xUUF0gW1BBVENIIHYyIDEvMl0gc3lzY2FsbHMvbWxvY2swM++8mlJlbW92?=
 =?utf-8?Q?e_meaningless_case?=
Thread-Index: AQHZeMtq1eaA8PCBc0ePTd50b7Nx4K9G6qMAgAjOhQA=
Date: Mon, 8 May 2023 02:32:48 +0000
Message-ID: <c69a496f-4974-55c1-abb6-38b0e24f79b2@fujitsu.com>
References: <1827762.iFF2E32hkL@localhost>
 <1682574265-12953-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZFD8FLGhxZOeRHJT@yuki>
In-Reply-To: <ZFD8FLGhxZOeRHJT@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|OS0PR01MB6180:EE_
x-ms-office365-filtering-correlation-id: 4f71827c-c616-4656-6b2a-08db4f6c8367
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JxeZ5w09F1NCz2S6OIg8PdSsyDCdPewBSvmcrQjbJd7iYQybmyHkC6iDXvx1MtVBCJX5wogzbNwjXoBaigEi989Adk250zof06dW0PL79aIVR7gWwTsxX7ZXBySKzNU8+wlWEYUPCWq+8Hd+2h/dsDnkZ/JHPTarG5g9KlTrhz0GjTmMN7DDFP4cUBygcV36/Pc3k7LVTUQJcx8yiVor9bUY4KLXQEUPmvafpxa3U+oLO6DBNxUw/tWdVlXR1CunkvLx+PqJpytMHYq6KEgyj4eJRum28s1ZhV5KFJaIH1KHKnhvg0hnGVzzgwOvbZpTXZMmYulqe9YbtfIX06wSfNIdX4+iT2IjO5SYZk0U5dtRbB6RHm2uFcpRIm2NZwA+jrNko5j4jqaClLgrw52+ZOricTLa7w+YQPXurE3TneJPJBfQjlXb9wJO6XXQGiHVa1UTj9LPpC0fJb/T6cGNJlWn/iVGw1DEKTFfr0PVIKOnh5jNBCECCB5Kf1WFDScgqVF6vL8u3Kdre84A4K085CYt5HZ1prugwQa7ZShFEOMmFd8zqLoJYTmERLentzEhLv/dEYSjVBxO6/jxM31kx+XXX4y9zEjFzI7gY43W/vGSKIgGZImJIzR1OtU7xfIXtmguIJSWgFxXSLLbCsQEpq1XBgoprz4h6REh/jyizgE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(1590799018)(6506007)(6512007)(26005)(6486002)(966005)(85182001)(36756003)(2616005)(122000001)(38100700002)(31696002)(86362001)(38070700005)(82960400001)(186003)(6916009)(64756008)(5660300002)(66446008)(4326008)(66476007)(66946007)(66556008)(4744005)(2906002)(478600001)(8936002)(31686004)(91956017)(76116006)(41300700001)(1580799015)(71200400001)(316002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlBQcTZLUE5SaHhBRE9ib0RHR0JsSDljZDZhS2NRblcwN0ZiVE5WR1Z6Tkhv?=
 =?utf-8?B?UVBWRHRhcStQYnhaZjQ3bC9XUWJBWUFCZmgxMzR5M0g2M0ExTUFCZ0JKMkYv?=
 =?utf-8?B?bk1pRktPU1E4TUY0QUdJRDJUUzhUZDJGZ1ZHY0htbmRWUWFNSEZKT1R1ZnZ3?=
 =?utf-8?B?S2lON0FCNTBLbE01eFBWMDRvaGdxTE1XL3hPNkd3M0NXazlVWUQ5NWtnb2dq?=
 =?utf-8?B?RzJCbitRcDRSZlNNdGdkQThBWjAwaEUwdmJXQ3VpWjN5UG5iUTVOT3lma3c2?=
 =?utf-8?B?Q21LZG14VkVUcEkyMk9yMXRpS2tWVEE4UFM2NUV2OUZOMjRQZUFwR25BcjUy?=
 =?utf-8?B?SUpOdHFydmNqZnFzbjVBeTQvSWdSTmlwRnk0R2dJdlY0Z1dYYUFjaFMxcGNH?=
 =?utf-8?B?VjF4QzBZNjdBRGxOaWJ2SFJ0UjNaT2pheUM5UG0vVmEvRW1Fc1lYZmlvTW1H?=
 =?utf-8?B?Mjl6OVMzQmRGcDY0SjRSdjNMSTZkandYdkdkOFhGY1pMcE1rRzI5eDZlSFVw?=
 =?utf-8?B?eVZPZi9uZUtFdmo5UnR4M3htWFJIeFlJc01yYkxtWTQ2UXdMZVRDcXRwbjVK?=
 =?utf-8?B?a0VkVVhML2orUWxWUHBUOUV6MU1MS2I1STlwd2Njd1JkbmRCOGRGTFBUaHpl?=
 =?utf-8?B?ajhWWFJZVXFpUlJnNTdzVEh6MDhhVUdSK2N6YUJ0OURtUzFUOGtobE9LY1Rn?=
 =?utf-8?B?Zk1aYVlZUWJXcUxqSURYbkhpdTE1bVVlV1JpWkFMY0dGZnB2ZXZ4MEo0QnVm?=
 =?utf-8?B?MVA0QnFwQVFtQVVnWUxYZXJaTW50SHFReitQUElDN1dZaklnV2VVclRQVkVl?=
 =?utf-8?B?V2w5NTBnYnI2eEtPU1gwRXQvVndGcFZWVmNkaWxVTmhaT0QvRHptckhaS1lY?=
 =?utf-8?B?ZStWVllSVkhKQ3Jvemt6T25mN2dIcS8wTE1hQ3lBalhSdzRMQ1pmcWEyeEJJ?=
 =?utf-8?B?a1kzUDJtTURBOTg0WW1BNGoxUUhVRFhMcVFqOUdQb3dWU3N0YW9wSEJ1b3JQ?=
 =?utf-8?B?Wmp1R1hwSGYyQUhHSS9rd05za01PbnlBUW16YkY2SW90dkQxRmRQbjJiMXcr?=
 =?utf-8?B?dmRQTFduN0w1cUdmM09vTTNHcEFab1JObUlPTEtjZ3ZZZ21LN0R3RWdpSCt2?=
 =?utf-8?B?MEZLTVBHYlBKVDRjSmpWSUk2RFJiNnpxaXBRbU9WWmNVS1E5NGRkK3VYdFNi?=
 =?utf-8?B?MzJCeEhOWnhPaE9BbWlrTVp2MVhYYkNKNkRnM2ViRmhUWC9KZ2Y3ZW1oRFUw?=
 =?utf-8?B?SSs4UlR4Y1RqYUdEdURnL1phWEc0SjROcjl2azNqbTJMYmtoc0tiY1VTT2FT?=
 =?utf-8?B?YW1XcWJnNTJxZXlNamRIcFo3SzRYYitlbkVxUkNXemYrbVcvM053S1dXejVE?=
 =?utf-8?B?TUJiUUl4N2xPUGZSc1ZhSXNFczFaZDhnTElZTUZ5NFdDMGpZSm9kWk5EZmE1?=
 =?utf-8?B?Qk0vdTR1MCt5R1g5c0FTdlFRdG4wTDBVczVsZW1ocGY4M2V6aWljeTlUZW41?=
 =?utf-8?B?ZlN4MmRXUDl0QVcxRE5mK1VqbVRrL3A1WnJqY2hXUTVMdXRucXQ0aGRoci93?=
 =?utf-8?B?bUhaOVd1UEZDSnhEN0xJenlhSkpNZW9LN09UZVFXdWFaODlpdTBSeDZXMzVZ?=
 =?utf-8?B?MjIwMEQ1djlQM3RqL0cvMmp4NTZ4bGRGYkRMSzlVRjNFVmtLaVZNa1NWM1ZJ?=
 =?utf-8?B?THIxeHZwOVEzeHdYRDR5am42QXUrR2JKNUt6cGdhb1VJYWx6UElEQzh5MnR5?=
 =?utf-8?B?QWdhNFBwamhkaGJEQ0FEWHV3Qk9UWkM5RUE1V012MFg1cVpPVllwWm5Cck5i?=
 =?utf-8?B?U3lOSzJQZ0RIT1dDUDIxb2lUNXhONmdLZ1M2UkNtRGVVK1d6L1dESDJVaW84?=
 =?utf-8?B?cSs3ZUw5ajNmaXJ2REV6N1NMREpFMXFOMnBrUHZsU1JxdmpWeW5NSHUyQ1cz?=
 =?utf-8?B?emhsWS9ib1ROWDRQaU1RN0MwQk9wcWorcDFpS3pNSlc4a0pHSC80dVE3OXRL?=
 =?utf-8?B?R2hraWduR21NR241M2tSVXpST0ZYVDAvK3E4eWxsTjVLaGliTHEwYy9HcGhK?=
 =?utf-8?B?RDV5MWtBaURjR1ZRTmYvR1FTMjdPaWF5bkZXQ2x2WWhPdXNqQVBBZGJvR2Z1?=
 =?utf-8?B?R0xYUXh1aTNUQ2tWM2E0cTdRcGJFbnZJU2RLQXpqYllES1BOR3gyNDZTKzlF?=
 =?utf-8?B?YXc9PQ==?=
Content-ID: <302E436312DDA04AB36E37769DFCF9F4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jX2wlne92iNlWOqYVeGlYYg2kdVezfj083s/8Z03NQF9yl++0cHDeaZPz+1WuiMWFD8h6WY6xVJETtP0IzO8RCy5FO0F2L8IFjSZS9o7IWQAxR6eW9Hzs5qesUwhdHLiIn3pdAMSQEk1Cos7zjg1JMLs9tz708RWw0zx4UexH5e6ZbBBSKv2fyb1OTbH55VSSA+KEuDRcn00v+AzBUY6dvzIEr6P16RBhshfwIJfRvq5SDgdlq5Irvipy3SQSFhCaUbfpN+qXEvEyw7ALLQlKwY+YRHHl6DoBsCY9XNy6VsoWmprGaqnqVnXlWRpawPN6PpzLd5SgD/NhAmfj5SaEIHS52HZ0frGNq+1uGTbVW3XmI4U6EHAlJ8gRjxMl+fqXkPSZhWkuk3eMGptmQkADAsFTOLd48plEPYzL0vCILz8YE+Lvd15fFN/LTByYVidmFzIQmtHLaS/KA4MBzeWc59+yzYjnUlQMsuq8k1jdVwnE1xfaN7AyktkjgaBeCH4qMkgZkpxFd2Ej7CMlXGPDhWkhbl443zsaORJNlGIyCjLy5r6KKdby4KqRyxca0qV1mtNsNJYsNNzG861D7yw2p4uF0eCWfuWJQginCY24IZ8Hk/rJdgUV9eRVLj3ofAGM4Kao9658hbADMV4hn5mLQWFhmi3ix9gzQ6GX1t0kUBVuNowWUDAlA6QrqknSCeux+TEK/GbcftNdScDrAm7p8saj8DUSVT1Dm00XbZz+B46z1CqT6UTc7f2k7xmOPMmEHMnlDG0ZsvLpnrNN/EM0Sbr0G6sRmngHQBSTH0QRi8=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f71827c-c616-4656-6b2a-08db4f6c8367
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 02:32:48.2602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdaNOfYB5GMD/i7DXRhFqUsxi7OYqQrE2sdGY6x2iJlAuLV1mNRtfulatn0WKLHHQ3O4HH7bKVJp8uwjh/bd3oc4oWvSukZLR7w7dfe7QfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6180
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 
 =?utf-8?q?=5BPATCH_v2_1/2=5D_syscalls/mlock03=EF=BC=9ARemo?=
 =?utf-8?q?ve_meaningless_case?=
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
> This test seems to be a regression test for:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=643426

Yes, it is  only a regression test just for RHEL5.6 and it seems a 
backport bug.

I donwload a kernel-2.6.18-238.el5.src.rpm and search for 643426, then
found 
linux-2.6-mm-backport-upstream-stack-guard-page-proc-reporting.patch. 
The upstream 39aa3cb fix this bug.

I will add a url for this case and send a v3.

ps: To avoid this bug exists on distribution kernel or upstream kernel 
again, I think we should keep this old case.

Best Regards
Yang Xu
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
