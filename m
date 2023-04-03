Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1711DC7619A
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 01:24:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 616FF3CDD29
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 03:24:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE4983C010A
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 03:24:14 +0200 (CEST)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1656760073E
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 03:24:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1680485053; x=1712021053;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=l8Ya6HU/JA5J/JONFIFof/rvNZl3twbq91B7ExkpFEo=;
 b=bjHOWfg4pVJXtnZZfHCN/8T/V1ogso47PzKUQKRsiaXLpg3j5utU29kl
 gEzW4RuNP2pWFBB2J8lDB7LzVEc+hmxni3PZcV30lM101nQOumoYYx7He
 NYEayr1zF3W42VhLdjyqFqWS8xLrYeVW4uB7uBqMFM0RS4rEEJfV+45EZ
 /Uj2S61D5TGEbkqp0MwhFNiIH0mjUFJhk4bnrcyxYaaOTszrzwc/ANlqv
 xXrk9Yo6YnK50UYuj2za0cDo5nrDk8oFDqUj/QvpJFnahlYlmdbsCB9dO
 83hnkDIY2sdxN+kwDRBAI0gCQdUw+9TRvjatDDL0R+7JOv5UE00DNbsJ/ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="80541031"
X-IronPort-AV: E=Sophos;i="5.98,313,1673881200"; d="scan'208";a="80541031"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2023 10:24:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtNdvI1kzJ2Jl0gmB3FVt8xCoOXL2QHjcLoNx8lUARPVqY76Flbod9mXImPr9kyxi2KhRxJuwXY25ul5MA3O1NznP1JuIcXfJNFCkYx2I93eMswq8tIlAMRpBKrHhMXT+65cqh5R8FRS911nYH9NdsdFkZ6pzCuMSiXS5jVl9clOMQLvhDzrD/f3FLf7MTDuVb3pzW+roVH8FTyFrfvOZdvSbE2CULz15F8VKgS/ajlx7oRM274GMnuNGY1KUpfIIIPcKgWs5bqGmvYlSnzCJvgj1Kw+c03qK0zMZb67F7RcA6sYS9q/CwRuJoWwezDKnmexnBAbQEuRNCsQ9zU7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8Ya6HU/JA5J/JONFIFof/rvNZl3twbq91B7ExkpFEo=;
 b=adCAHVFs/nUCKS63WMytmiGeFdGUYCmGWrZRDnm5MGWkjwYyM9qeTldClriCtQPJpEDarxM6/jiqPOp1n9x1/w/x38/pAht2P1qwtQa6+DIM24hIjh4Y6LSIXzOHxqLG/uqzIkBzG5/lvmI3sLnbzr45FdnhTRvkKoTy2MSSgU7l4VRVI5D8uVCW81f458zuAwo68bJspVhv37BznL8vZUxfr7JgJbgaJQheBFuVnbFK1DU7c+k0c8vclM0ASTO7Xf+Cmmqc4yEyt3qYFpZrixbpVLlQlWlcA7305v6plwcbsZS4wEF6jIFpS7gOefkbBaT4l4GUbI7bS8flHP4UPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8324.jpnprd01.prod.outlook.com (2603:1096:604:180::14)
 by OSZPR01MB9567.jpnprd01.prod.outlook.com (2603:1096:604:1d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 01:24:07 +0000
Received: from OSZPR01MB8324.jpnprd01.prod.outlook.com
 ([fe80::cc6e:635c:2159:4d2]) by OSZPR01MB8324.jpnprd01.prod.outlook.com
 ([fe80::cc6e:635c:2159:4d2%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 01:24:07 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [PATCH 2/3] syscalls/statx10: Add basic test for STATX_DIOALIGN
Thread-Index: AQHZYuDt7kGs9kVmFk61sskzHerwEa8TiLSAgAFSCQCAAG2fgIADh9eA
Date: Mon, 3 Apr 2023 01:24:07 +0000
Message-ID: <7f06d661-cb57-cb8b-481b-cafafa92009b@fujitsu.com>
References: <1680164569-12114-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680164569-12114-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230330164653.GA881@sol.localdomain>
 <a9a441b0-1774-a15c-14ec-b155bfe88152@fujitsu.com>
 <ZCc0gyy9QvGLlUPv@gmail.com>
In-Reply-To: <ZCc0gyy9QvGLlUPv@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8324:EE_|OSZPR01MB9567:EE_
x-ms-office365-filtering-correlation-id: c888f815-600e-416a-993d-08db33e21eba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dpBkYeG2MfLQnpFmQijzGwvyMLHeMgPdTQ8TFJXvMcu2Bigiubime1hGsqQTLdrKTyRXwPm3Qg8MTiI1EVrI30KqBD7jshi79UN9M5/xc6eC2d1+hAgz7gg56YVGn5Nesa4DolP7zQOmjwAUfR1NXRnFLgUIhZ8zy771ZPYKuBZWTOc0MPa+H729+SjmbeJIXpllg4sAM0Bt9/FhnkSGxwpBjVv31C4lkV0jedbn3ElKfqta/1XfNEQ/Z7xUiXs2dSPbjEFSFD3Ft52KKTPdcERRE4LblPY7DxLBCWw7OMo38+8eSurbqcNMINbdwDBhftnswJYDekurLxH/nJngKo03nVo/an9Dul0jrVseInw7PUoKzneTELxZI4wGyLxjKLRmOGtO/ZTK19OYllTUcfDfHAulx6BqDPf5F+jlK8j7Pv7gVruAv6iIlBxrBDbU04qEyyceMnGRJZIOwhGPDjZowNhWD0NF1oMjWivHzG0ayYdipa6H4qPoYsOQgwLCM3hcScqmnMRMJjKdviDRdkqHpKcCIUZqbKkVvBNXctF6D56gc0XtKlGa2uiPUBmnexsNUukXd+MTkX9Q2b/A7zpKXWugeuo0HOtJzzxj5tBvJ4giGg9h24+ZYHbIPun9oQesq/eh6JmFeBORSbLQvsp2IS3XmhBPLd79+yPvClU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSZPR01MB8324.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(1590799018)(1580799015)(91956017)(6916009)(4326008)(8676002)(76116006)(66556008)(66476007)(64756008)(66946007)(66446008)(478600001)(41300700001)(316002)(8936002)(5660300002)(122000001)(82960400001)(38100700002)(186003)(83380400001)(2616005)(71200400001)(6486002)(6512007)(6506007)(26005)(86362001)(31696002)(36756003)(85182001)(2906002)(38070700005)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0ZnS2IzdFY5VmpPOEJKVGZMa242L2xlM3BSd2VrQTlXSFJhSEFIOEpLc1dN?=
 =?utf-8?B?K0pmZHZUUTRrbkd4cEEvRFF0N2V2MERSSEJoU1VWamxlRmVnNklZSTk2aFlX?=
 =?utf-8?B?dm9OSkpwMUJ0WlpCa3o5SVRVL2VhVGJNWmo5VFliU2xLck5tL0RHTDhwd1F6?=
 =?utf-8?B?YlAyQXNkL081b29ITThjVmhNbTdFMkc1WGRyU0o4T0drYkE2YUlGUXlzRkZo?=
 =?utf-8?B?cndKeFk3MGNGSzFEQ0w3dEEvV1ltMTliRVB0bnpRUTdQNXVJUnkxODFzTGNF?=
 =?utf-8?B?M0FYdkVpRUd2ZkdZMjY0bkFCNWYzcWRWNXpsWVYvSjhqQWJhNzgvQ3JzcUJQ?=
 =?utf-8?B?Tld0a3VQTVpiQm5sMkJyQVl5ckF3SUVJdnZxY09nTlhrajZZcHFUOWNTWiti?=
 =?utf-8?B?VzBGeVZYVEFFMnRqc1AzMVJOejAvWWF3UlpjVWtMNDFvOHl0YXdZOGx6R0dP?=
 =?utf-8?B?c2NwMkdPOEpYWWV4RWtnb2szU2pyckdLaEZyT2pPbk1uVFJ5SFJHR2xnZmUy?=
 =?utf-8?B?dkJ4Vit4bmdSSlVYc3o4M05iM0l1dUd3eUlBdXVXZVBaa2c0d0FuZzNwWFJT?=
 =?utf-8?B?cGQ2bDFMZEwzb2NXY0xDeThiWVJlTjFtYzlmQ0U5ZzlPWlRmR0xMR2hqTTE3?=
 =?utf-8?B?YXdNa3U2bWpkRDhpdWNjRVlOTnVqYnBoQklhY2RjQVhKOTZER3MxbllmKzk4?=
 =?utf-8?B?aFZpdlpRYlRzQk1Ud3hkaTlJTDM1aHdOSFZ1SThuVStZbWZjM09NaEs3R3Fn?=
 =?utf-8?B?aEEvNStocmkrZ2ZOUWZBbkt6MXNIdGcrVTg4R0dtMnhUbjlhdW8yQjVNU2RZ?=
 =?utf-8?B?M3RhQ3dYN3ZWSHJUeEV4MmZYZW5aSXFXYzNKQnNKRkNlcktiL3dYbnZEMGF2?=
 =?utf-8?B?bDBmSjV4WDlIZlByMjVzOEV1MXpOUGh0bktWZkxHWEN5V0wxalJOWG4zZXR4?=
 =?utf-8?B?eXoyS1hxZFoweXdNazUvMTFPbk1tYjJkWHpaOTNWaXZ0UFhMSmtFcVNadHlK?=
 =?utf-8?B?Rmt2a1VVMVhVSHJ2OHNEOFJOYXhNV2o4RmJlWmxDK1NCdC8xdk5pSkNhUVI2?=
 =?utf-8?B?MThEaWI1bGw1OXFPeVRqZEdkajhjUEJWdmpxREdORXFlK3lBTjl4akxyN2po?=
 =?utf-8?B?c1FYMCtKbjJOV1dCWDdtcmxTTVJEdC9UYW9qb0NSVCtUL1VOSDhqdkU2TEtL?=
 =?utf-8?B?dDR1VkFJeE0vMzZXUVFPcmdlYnMvMVF5OWZSSENNd1ZmSUZwcWFSWUZCei9j?=
 =?utf-8?B?V2pRaWlKNmYvQ0tZejlBSktTQUd1dERCRVFuTFZSWGRveWZ2VUVaemFFRTMw?=
 =?utf-8?B?d3lzZUZtUi9hVGQyTVlZUytEeHI4UmpWd1oxblhNZFgrc1pNdEw0SGlIYURk?=
 =?utf-8?B?cmUxZDJTMnQ3TEVyWnVYQ2FuMkQ2N0RZK2pXSDJBR2wybFZ0MEduNk00QmxL?=
 =?utf-8?B?K2ZtTEx2cUdNSkhNZ2FVMTRIaUJaaEhpTXRqT296YnJpMEJBZkE3bldNQWVo?=
 =?utf-8?B?OHNRejlKaDdhaWhXS1R5SjVia0JsNTQvcW5RdDBsclN5ZWVVZU1jZVdvR2dC?=
 =?utf-8?B?UERIN1JJRml6QTdyUXdRUTBjRllvSjBZZFh2S2lXQ25MVm9hZXZlWm13bUZa?=
 =?utf-8?B?bHdjTU1xM1ZCYlJHQWwzSlQ2cjlZeUJ0Z2hQN09rMW9qbXRzc25hbU1qa0hB?=
 =?utf-8?B?Uk5NZGw4TERxNkpJUkRrdmI4a2plUklaNjYvRkhoS0xHUUVlTlZuQUtmR0s3?=
 =?utf-8?B?cEsva1VLNWZGTU5mR1l3aTgxUVVPbERMMzVCVWFualhWanh4eTZ6NWF1Kzlt?=
 =?utf-8?B?TXpydGR4NFBNeTlKck0yWURTWHBtT1ltbDc5MHc1c1pxNEFxSGdFNWR1N1I4?=
 =?utf-8?B?RHdUOG55WWpic2xYR3krY1VPay9uc1NxbEFhRU93SkJKdU1CQnFZdnQyYURj?=
 =?utf-8?B?VlhvQTl6b1Q5eWZuanAreFdqYnNMZkQya3ZybWhWM0ZRL3Q0RFFYRk51Q0dG?=
 =?utf-8?B?em1UK1FmQlcvK3RVTzlLWkNsblh1aFNvejdEMU1JRU9OeEhqS0taNk9QcU0w?=
 =?utf-8?B?RlNGZ3MxdTZFcjBaTEVuSnowS2I4aVU5M2x6WEJQRFpPWkllK3k2bklkZ29W?=
 =?utf-8?B?bHc2KzVzenBOT21iQ21KQUoxV25QSFZxSDNia2swb0VJb212UXZVVDFvYVhF?=
 =?utf-8?B?M2c9PQ==?=
Content-ID: <1FC51957AAFB2341A8D498C92C4FECCE@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qdtzyosTq8rw2GOJq3v7LvLreDVklBj3p1eExfuf6/mpksbh/w2I2VZgVwzxN7orw11bYxNvAINdTMNMphN+Cp6nUuyOS+nFWYIxhmZpYw7KUqEBBnSNLc02Aun1fEGxde02OaS7ojoKUEpkqko6srYT4mZdVRCSQ6IMNQVdA4kD8BJ9R9bP+32bKa1bNUXN/qq74JrOl0T7mGpaRi6cd4l48NVUU3UTYOItgAYJTXGkaO5qGZb0XdNzNy97o9enwnILvWOAYIzewUWODZO/qOsgCoi0pWgFrKhAACc/sSWDivyx7RaADjzW3GnjerarTFy0/c2KXmYIcrqG/ddqeNVAHy1WXIBjAADao818RZhzw2K57eFk1pY9qhHOaVs836rczaGSuVse1AwhbUCViloBCdGMd5Y3k5XlyUCWCpi8m39xnpeOFIzoaYB+UwyAnsI/O/v4nm7dyYPzE75wN3/0KD9+365IvZM0WIZk5W629umt4vda4JHCM7vio6NpuPTIrj+iNLxODnJCLIKmK2jXcDvPkzSjZIDnjwWz9XFp/TaRyeufMfZeO0B0V6LhOXWvk7mywjYFsknYP93fS0524WKslNUuafPgRTa3oAhcBdw0Vmy3e9yosvxO1Mrjo2gPmGK60N/+d6DXIgYS9sEsHcocDd1p1mcJKaDXuVlj5P+TuZhWQKf+Oe5KQ4gl8I9xm2oFAUI/8LSEXobgq7M6tl4cjYJT61A/4AdO28sGqDGpeKT8GCXgt/YiChg1pKv1zlTbIlp2l8wXXlwZrl3pN6Au/VWGIf0t5tTo1PU=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8324.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c888f815-600e-416a-993d-08db33e21eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 01:24:07.4007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DLMeR4iNAGLNc14O9eex4+uj5JlBQG/1dwkrYfDWx4A9zZt8IBW/IJ1u2pcnlnRY7mo5MD/thhYh2gyGooWsC5AxfoiPyv3iP0jqozhZXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9567
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/statx10: Add basic test for
 STATX_DIOALIGN
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

Hi Eric

on 2023/04/01 3:29, Eric Biggers wrote:
> On Fri, Mar 31, 2023 at 12:56:47PM +0000, xuyang2018.jy@fujitsu.com wrote:
>>> Thanks for writing a test for STATX_DIOALIGN!
>>>
>>> However, the above code isn't actually a valid test, since stx_dio_mem_align and
>>> stx_dio_offset_align will be 0 if the file doesn't support DIO.  This is
>>> documented in the statx(2) manual page.
>>
>>    I have reported TCONF in setup when fail to open a file with O_DIRECT.
> 
> Unfortunately that does not work either, as the behavior for when direct I/O is
> unsupported is not standardized.  Some filesystems do indeed return -EINVAL for
> open(O_DIRECT).  However, others just treat O_DIRECT as a hint and fall back to
> buffered I/O.  And some filesystems even implement the former behavior for some
> files and the latter behavior for other files...
> 
> Note that this was actually one of the motivations for STATX_DIOALIGN.
> STATX_DIOALIGN tells you whether direct I/O is "really" supported, as opposed to
> being "supported" with a buffered I/O fallback.

Thanks for your explaination. IMO, ext4 and xfs should supported DIO.

I think I can test STATX_DIOALIGN only on ext4 and xfs (xfs can use 
XFS_IOC_DIOINFO ioctl to verify dio alignment information ) instead of 
all filesystem.

What do you think about it?

> 
>>> Filesystems aren't guaranteed to
>>> support DIO, if they do, they aren't guaranteed to support it on all files.
>>
>> In this case, I only test a regular file.
> 
> It is possible that on a single filesystem, direct I/O is supported on some
> regular files but not others.  It is also possible that files on the same
> filesystem have different direct I/O alignment restrictions.
> 
> Likewise, this was part of the motivation for STATX_DIOALIGN.

Understand, If only test ext4 and xfs,  except for regular file, Which 
file type does I should test?  device file, link file...


Best Regards
Yang Xu
> 
> - Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
