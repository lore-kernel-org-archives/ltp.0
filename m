Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88594C3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 08:44:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD3F73CE77C
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 09:44:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96B253C88E3
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 09:43:55 +0100 (CET)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5728660083F
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 09:43:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1704271434; x=1735807434;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mExZ05ZbY7l0MxFFu7ToPak+ct763QYWHv/kc5M9YEg=;
 b=lujAXDwUI9K003mFIvAEuCoZ7GatR6qg6cw2hMXrWiBr5umgarQQ7ian
 uqpBTlroJGcIy0gTpkTQGV4GdfoijlfcRqru4Z3rpi33CuwaomTD5AqmD
 hXYJ5gT3Jt07F6RPDjhH092evVAGFh4i4OJEQ9NNphynMFHcu3/umWDZU
 v3KZA4HVVHaNj6IjQp4dDzbQW6w6LS42k3D5kjCfBIuvKTH939AZLJn3N
 RbRadCSZnde3dVp0t0hxuZcWmsAfsDJyQg0XgQWaceD59QX9OfGZgwsps
 Wqp4FxckuHbfGi/mbOwKRDOrMQuEBrRnaXmt6CTuS1C/uTUMv+4AinpO6 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="107353240"
X-IronPort-AV: E=Sophos;i="6.04,327,1695654000"; d="scan'208";a="107353240"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 17:43:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnAFuS6u2uBW+RZbJ1sPTeZKMHLe+3sYEYfQOMdsF5GguuX/6ab2TiUdjfJSvFP+lUY+cJhupcQ74O/fLWm+xGnsVZ/LGUqzUBtsFbAVQuTVtj8T4io21R2E5y6xIQDLAwXNUdDUd1Nz6IbegX4jQslqg+fEI0YMWLDw2h/cSY1SvEolTwvArV+2h3Ndm49PzwGJT5CXbWU2CxOLO0FPlJW139PqnixVJV6ZFe7HmWenb0/ZsCyZyHuzP4IT9bFWDsRlrY2o9RW3jCBLWsjlIoegdsoht6SqYNXCSBGbToRkyxA+tOKZsnZZy7EUpx217t1iz1/5cZBwvw2bu+bMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mExZ05ZbY7l0MxFFu7ToPak+ct763QYWHv/kc5M9YEg=;
 b=LXwDnRZUFsz6vhfEpFgBE3iVEK4a9l8bGc4EVW7bxtmfNmP3Bu/r5YMYIliEM+tp4uFHx9DXHc0DzwFBuEOouYp4qmyVGyC5KmqZSQ0lXMfS3Ekn4TIBU6En2UwRq/sku5ffXWQ9rT7p3NKJr2tyILR04PHP0kt7Foxj9IlAXUA8aO/iwkHUagQAUzUvr7WS+6i8Fp4bgRTCiVTCVAjhv+Q1zcV6dl0QBef6dqMUYl05OaLLbd08zmW7P3jnBYEUkfDZXDL8e3dfB4e+Elt2edZcLUqF6HT8IVTxjQB+uyPgrDRfvVr/tK3KD6+gSPebQeEX8fue+VCxLyogr/RHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYWPR01MB8576.jpnprd01.prod.outlook.com (2603:1096:400:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 08:43:48 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6f9:cd05:b0e5:6601]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6f9:cd05:b0e5:6601%7]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 08:43:48 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "chrubis@suse.cz" <chrubis@suse.cz>
Thread-Topic: [LTP] LTP Release preparations
Thread-Index: AQHaPXqtlpG0+qi3tkmSPvjPNWvMn7DHxvAA
Date: Wed, 3 Jan 2024 08:43:48 +0000
Message-ID: <2fae91e1-f03b-4bdc-bf3f-8dc228d763ff@fujitsu.com>
References: <ZZQHPkwg-W2R1ejJ@yuki>
In-Reply-To: <ZZQHPkwg-W2R1ejJ@yuki>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYWPR01MB8576:EE_
x-ms-office365-filtering-correlation-id: 9cf64255-09d3-4718-d0d9-08dc0c381a9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ioNVK+XsB/TQXdirDX4afvV/OGY56dlsJY5ktx8EzH0rMwUz0T6C6qTQoRnfBl/x3H2Ql+4/FsE6qebk2SgxXuLwTVyEXtOu9oCjgqd5/PKXWjzXhKGOgoHhuo9b4LAEwjAgiQkTFljzz5xZe0aJ4Wt1FIFXnwF0HIc50S+DaNZD+6671TFUmzlPpoRcrT67JzS1HictIqjpj+jGOdX0IgDHH667YK19G1N6Loe8sGCyjL+oMrn4+t40iXHQ7QgOIHC/qW/M+rFEbui2COOMunRCl6q4mOrqzh41ol9qVY0f5s7XcS/0H52ichff6G1b/+7bT0swRhU2vngY6kwbZqzKEeuFNPApC6WYmAUG5u9bZGjtDxcxfDkWD2r0ET+3kCJ4iA+Kohw0IeiTPd25FXicD8Lq5plJ7PrCL4aQgaZWcK89Iqc5GPEfts5dKwo8rvmymYfUVpxWHNeDQV8FCH7TTUEbavp9WlJnaCxwhxTzMHv+xBuLMng/6c36oimoPZOH3ORlPwCAOx4FmEhZ/GSHW0IpnsHoOtcfDQeQ4YhAtLM5hW7UqpLhuf4eYbQNJOB35oa8Vnv+WFxPTJ0LNeJH/Iv9rq+Zt0CLClwNbubDxSfWM/2n7MZ1v60xUeNnfHTj74t2wq6JQxQLn7JQTeqXU+r9ZXsdxHoYsA0wZMM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(64100799003)(1590799021)(186009)(1800799012)(451199024)(66946007)(64756008)(66476007)(66446008)(76116006)(66556008)(6486002)(4326008)(91956017)(316002)(6916009)(8676002)(8936002)(26005)(2616005)(83380400001)(966005)(71200400001)(6506007)(6512007)(478600001)(5660300002)(41300700001)(2906002)(38070700009)(85182001)(36756003)(1580799018)(38100700002)(122000001)(82960400001)(86362001)(31696002)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUlyek94WExCZXZaekRPN2dPcXVaWExLR0txRE1JamNVSDlOUHIzWXZGcWZY?=
 =?utf-8?B?eHdERlNSdEprZ3ZjeGR5VUx5TkV5TDhSSEVjTEt4amorL2FmMzVVMnJqaEVH?=
 =?utf-8?B?NEpaMThwRmNCdEZ0bUpPenJ6cmxjREVPL21nSGxaNEN4UGhiWEI0UFMxZ0VC?=
 =?utf-8?B?UGZoZEo5cGRsZW5pQUhZYm9OamlLZ0t6MFZ4WjlnSWZWcW4yREpHQkQzUjla?=
 =?utf-8?B?OWdKZ2RyWkR5ei9RcVVJeEZSWHY1NWx1T0RsVUxzYzJ5OFdHbExJcXM4SFV1?=
 =?utf-8?B?ci8rRHRaTDlOcDFyZ25MWTVSeG5UbmFWRVc4STZoRzhGMk9CYWN6UTgyWTZI?=
 =?utf-8?B?bFFPZlQ2ZUFvckpNTDgzQVlQaHFFeG1zV1FXNnp4VmkvSHJIY2hKY3dFdzhF?=
 =?utf-8?B?WGJkd0RkM29WZ2ZIaU9GWUl4THUrUnN2ZkZiRGRFM1c4MmpsTnZETDZKKzBv?=
 =?utf-8?B?Mlg3eHZMbHBqZXM4a3N3d3JlcCs3cXZrbkxuWUMyZWF2ZzY0NGt3UDh3T2Iy?=
 =?utf-8?B?TjA5Qm5nOG5LRjRJZmdxblZmbDBsbVMrQWxOR1Era3RzWmk3WnE4MzNqSjYr?=
 =?utf-8?B?R0srMC9TaEhHY3FOdVRWcXhUWWZuY1ZiT0F4Qm1nWUdvTTFVTzJSa053OER2?=
 =?utf-8?B?Z2VSZzdsMURMYnoxRHMwK1hKVEdwT2JDVk40U1lRRFBnUXpOMkhhSitxV3hz?=
 =?utf-8?B?NFlHc0RzNEZMQU1hamRIUlJaUTRWWEFJeUZVRTVWTjFuSEoyUGdqOG5pVHdv?=
 =?utf-8?B?R290QTEzOVVkVkkrWHRmd1d3SGFaRkxXeEYvRTVienZDTDF0RFFvVnZuL0xG?=
 =?utf-8?B?bGlDK2V4a20yWVZLNlJVdG5jRi9sSTRSU056UkdCeS9ZRDFiVmpCeW1EUS9y?=
 =?utf-8?B?L213SjFzNXMxUkp3OGtBak9ROURPdGs3M0w0Qkw3bTdIVklhZmRJUXpDYncz?=
 =?utf-8?B?RHJOdE1oeGZPUzRSZkE2VTRESjBDTjBUcnJ0bDN5cEJFa0tsS21wM1JnK20v?=
 =?utf-8?B?eWIvRVBwL3h3ZlpRNnZZN3dja2gzRHg3OHJYRGJURGFSU3I5bGxmdU1WUE9R?=
 =?utf-8?B?ZVBzMFFzdUl4dGdXUDdrUEhnVEY2a21aZDNjZDdjOE1lYWJ2NGUwQzg4Yzg0?=
 =?utf-8?B?eHRVT01nV1R5TkdTNUpySXpUZW4rVm1uc1JzaWx0aUx2cUllWXBFWVVuekF5?=
 =?utf-8?B?YWhObUxrUWVXM2h3eUF6MmNIdjU3TFhobmJhTEx2L1lsQWpINmlEa1BVbE16?=
 =?utf-8?B?VDlyK29sci82MU9KL1JKQjU2dTZEbkttSzBSTnVLd2h1a1RzTVd6UTZra1Ji?=
 =?utf-8?B?ODZrU0E2Z0QyOFlHTmlRQVdWRzVNalprc2w5dlQ3d0ozQ2hLaHhqaENpTFB4?=
 =?utf-8?B?ZElGakxrNVZCQlNxNlVtdHB2WFkyekt3MHROa3hoRnZ1THpQalRXOEtxb1l3?=
 =?utf-8?B?amtiNi9vZTY1aEc3My9aVmxhTFhZbExOdzJSaXpnR0M2RUVjaUg0SCtBdmpF?=
 =?utf-8?B?MEl4TG1oZ0dnMytmSE1xb1NEcDJpZ2N2R1RMRzE0L1BUSE50eXNFTlcwdjN3?=
 =?utf-8?B?UWtYYnk2MWRndkpvVm5VOFQwT0VWaXFKUWEvVjVOTEVTNktzMnkrRnpLWkM5?=
 =?utf-8?B?UjBONk1QT1FtbDEzUGljc0hHTEFtVEhNeUEzM3VsY3lyRFk4c2lvVGc2Y2Iz?=
 =?utf-8?B?ZWh6YzN4UTJKeXBaclRIV3pIQm0rUGJ2OFU1bFlxU2F6RXNERk9WcUhVTS8z?=
 =?utf-8?B?TzRVTXVkUzl1TDV6cEpjdHR3OTFTZXU0V21hMXRENmlXbHpXOWF5enBHSEJw?=
 =?utf-8?B?ekgvZlg1VTNLZXZaNnZVVEZmeW5jWC9nUFNpd3psYzF3MGN0QkVJRFl0QjlO?=
 =?utf-8?B?S2FPbVJnVzh4Z3JaeEYxOEtnK3hGMDZuU3VpZDFXYjdVNDlOR0R6TERsN1BL?=
 =?utf-8?B?eG1qNWdydStzOWsvU3B6S0hzRFZFV3dCMTZLclk4Mzlab2R0L2YwTWRGUCt6?=
 =?utf-8?B?UjdhRnVoY1VVa1N5NWtaRHF6WGNUU0dnWHdWN21PWCtnUEJhVW0xbW9mbjNP?=
 =?utf-8?B?NW9ZWnNXb1AwdC90MTVmMU5QTVVXd0p2QTJqTkU4dTZVdFZKM1FFUzdZMFdG?=
 =?utf-8?B?ZjlkUjY3MnpEamRXbDdSM0N3cjV2OUNBR1FLTGd0ZGhadExEQmZPc1F4ZmZQ?=
 =?utf-8?B?VGc9PQ==?=
Content-ID: <1560838F0B54E5488AAAB3E7E9635F6A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W8wwPdOHivBxUpCpVHMZORlhc7ESHRAweOzqL4fIwd6e7xd3CMP3GQkDYoXBD3lQ/9cRhrsGSAXS1zjKc3S6UllLU6+QIM9zwc9e7OQ54K4g0m87WdM4yXv7AGTLZ4b0kyGZCIlwE3WMSF+PAzUvlt1pKJebRbldD9EZ6ION14FJq2XieciIwADIDDt5R8bqOnGe3d2niP60CcV2l5t/GGvVM9bMunU9RLpM4rVXTEOBUpY34ezmsvlZa+FdODeYBCITdRdSM6Mt9tmfJm1rpjb7ic5QxMWf2EGQRKCFF5CxirQTsF7rW2TbFcNPDPjBoWxNxvHTffIr2v3mv7L0qW4VtOejwYaejywUxHb7ut1IU40vyMObGKoqM1pe7CNDREQjXsOxQh58HYIJn8LdD0nVNp9haloDZIT+0ssdxuykznFnlp0BLncZZYUzW6Y6FVPNjebn7uRv2az+gqndaiGYj88oxwhfkU559nUa1mXVYowj5lMV6+gkN4MVlVQlfe63b5UobfIdTcHf7khXzUhPEja0g7/IFaV80kon55nNyOh1KhB12FLt6s6OZgQP/V/l/hEg2weXVJGm5hwaiilv92dFwZR6AB2pf1Ss++qQSRujxJmcHdb6bmpZ1FyK
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf64255-09d3-4718-d0d9-08dc0c381a9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 08:43:48.3320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0Vv4DRJ0z5E6btk2wPdmbKquLjSO0sq29YqUZWrEPgyquG+IbOnP7sLiJY5ZHkVO4MlyAV3A8TdLtHFVg0bsD3WQuxsRpoxlsQd6+XUYvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8576
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsIGFsbCwNCg0KDQo+IEhpIQ0KPiBGaXJzdGx5IGhhcHB5IG5ldyB5ZWFyIHRvIGV2
ZXJ5b25lLg0KPiANCj4gU2Vjb25kbHkgYXMgdXN1YWxseSB3ZSBhcmUgc3VwcG9zZWQgdG8gcHJv
ZHVjZSBhIHJlbGVhc2UgYXQgdGhlIGVuZCBvZg0KPiB0aGUgbW9udGguIEkgd2lsbCBzdGFydCBi
eSBnb2luZyBvdmVyIHBhdGNod29yayB0aGlzIHdlZWsgYW5kIHRyeSB0bw0KPiByZXZpZXcgYW5k
IG1lcmdlIGFzIG11Y2ggYXMgcG9zc2libGUuIEdpdmVuIHRoYXQgaXQncyB0aGUgc3RhcnQgb2Yg
dGhlDQo+IEphbnVhcnkgd2UgaGF2ZSBhYm91dCB0d28gd2Vla3MgZm9yIHRoaXMgYmVmb3JlIHdl
IGhhdmUgdG8gZGVjbGFyZSBhIGdpdA0KPiBmcmVlemUgYW5kIHN0YXJ0IHByZS1yZWxlYXNlIHRl
c3RpbmcuIERvZXMgdGhhdCBzb3VuZCBmaW5lIHRvIGV2ZXJ5b25lPw0KPiANCj4gSWYgeW91IGhh
dmUgYW55IHBhdGNoZXMgdGhhdCBzaG91bGQgYmUgcmV2aWV3ZWQgYmVmb3JlIHRoZSByZWxlYXNl
LA0KPiBwbGVhc2UgbGV0IG1lIGtub3cuDQo+IA0KSSB3b3VsZCBsaWtlIHRvIGhhdmUgdGhpcyBw
YXRjaHNldCBtZXJnZWQgYmVmb3JlIHRoZSByZWxlYXNlOg0KDQpsaWJsdHBzd2FwOiBBZGQgZ2V0
X21heHN3YXBmaWxlcyBhcGkNCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9s
dHAvbGlzdC8/c2VyaWVzPTM4NzgxNA0KDQpCZXN0IFJlZ2FyZHPvvIwNCllhbmcgWHUNCg0KPiBJ
IGRvIGhhdmUgb25lIHBhdGNoIHRoaXMgdGltZSwgcGxlYXNlIGhhdmUgYSBsb29rIGlmIHlvdSBo
YXZlIHRpbWU6DQo+IA0KPiBodHRwOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9sdHAv
cGF0Y2gvMjAyMzEwMzExMjUxMTQuNTg3OS0xLWNocnViaXNAc3VzZS5jei8NCj4gDQo+IEkgd291
bGQgbGlrZSB0byBmaW5pc2ggdGhlIHRzdF9mZCBpdGVyYXRvciBwYXRjaHNldCBpZiBwb3NzaWJs
ZSwgYnV0DQo+IGRlcGVuZGluZyBvbiB0aGUgYW1vdW50IG9mIHBhdGNoZXMgdGhhdCBJIHdpbGwg
aGF2ZSB0byByZXZpZXcgSSBtYXkgbm90DQo+IG1ha2UgaXQuDQo+IAoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
