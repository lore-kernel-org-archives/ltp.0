Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007A3C7618E
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 01:36:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AE353CE4D0
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 03:36:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6EF73CBB54
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 03:36:38 +0200 (CEST)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3CA041A00981
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 03:36:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1682559397; x=1714095397;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rlB4szLWB1NWY0UFBqIu4mA28Tc9kaQPDo92Vc8kBb0=;
 b=FtObZbj8FdSgeTMaQJRcbIYFSu3Gc8PtluFg+Fu3UkKImYrH9RIqtpLc
 ArksgdsMb7ARNDmN66clFiDS6oI2BoLyeCTM4ruaK++YuLh2M0I//XF/n
 i39iIm8fmhYSSPwRtZ3BvUUccQFkwuMvFA8AvjdRydX5bgxC/2AjcZjO2
 l4KdXa4J27nYE8ioLvejOyVSIldbSPzHgugGmECz/TXIq1m5LOXdpkhxi
 RY+nRER90Odmn5jcv30yUSQL+y5mYa+lHezJBxQX2XktpTpELTjA0Pd0i
 SLBGN/Hapyb4ctQB5ZjNDmHzU2qL44sbTLkzVf07a+ksczhfpK3CUHDVO g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="82780204"
X-IronPort-AV: E=Sophos;i="5.99,229,1677510000"; d="scan'208";a="82780204"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2023 10:36:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFprDFSs9OuXAdcovAccUBIC57YJzcppwbk9vjNFw4w85MfpBZhT5QtKU5CB15foxhte9nYzONqQkiwDEGKTRPAYpD2qTGG0KBksllFq1cF6w/fwGw4Nlqixdv7IKcTZreadCE+mrfbC4AFqiVofM7oxRD/osZQw350pFO7vaRvWPKx1lE55wsopYSY2fTfmAq1M410TUS1kRlwJKVPs/QBIBYhpPXWHC9rM9Lvn+lDGt5+YLMO6cb8BXA6wlOBEQFCH7PNqZiUMq28RufrjrpW+ohgx4VXE50sU/s8m2w2jxxs2KTgL9Bm8U4FtSCTqz8iHWHVJgsvrKEpvqJGFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlB4szLWB1NWY0UFBqIu4mA28Tc9kaQPDo92Vc8kBb0=;
 b=JgTjp6YyeAJrKi/q6RYV0fCnMonQtYubcX7lub0mttGz0mRKbC5jaXFTWLPyexv3YVaTQeoKvonkwkP9o2DROzZrGvEfHrDFWx3EfvscEt3OHSduN5456m12W1IU7m1UmIwVLr+oJlC/xy+Va/oVel1UZ8WqVHWNoWeXUYdDwnVNBiqZXDCMVFzBvmL+2gHkDAcEg5XB9hKpCpWBsmZACc6yh5vqxIpi8qGLaPERxnCiuifPJ8A5Z0viNxn31LaRKkKGe/M/pTCxsHoPkow9Fds8mpAkwI1c7YEwSBqcBzPWtmi3XImlFYiMJkqUCKwWW1kApNyhKQ1tfO+0icxMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYWPR01MB10855.jpnprd01.prod.outlook.com (2603:1096:400:2a9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 01:36:31 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 01:36:31 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [PATCH v4 1/4] lapi/stat.h: Add STATX_DIOALIGN related definition
Thread-Index: AQHZaEpcdeofFkKwMEuwFIbOhJ4BQK8+Q0kAgAA9gwA=
Date: Thu, 27 Apr 2023 01:36:31 +0000
Message-ID: <898b8822-251c-818b-f182-eb11ece2eeb2@fujitsu.com>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230426215620.GB58528@sol.localdomain>
In-Reply-To: <20230426215620.GB58528@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYWPR01MB10855:EE_
x-ms-office365-filtering-correlation-id: 4a5e150e-d95b-417d-6696-08db46bfd438
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5P1ZMz3QUxsxELAC+j6rvPvnFd7a1maU7/I0xNo1jhBLNyTUNpcXjF9k7BFpArJ7pTqMD/eRUiBTPdUrfGySzTy2/7yX93N9/Kx0qrX5V2YErqTcPK47QLjDtV8hTmHMVVTKQGIUCFRSg5LW4bFUawY0lWkg21K/95bqOAuObxcSV8CN1+kmw5WUWqCBfF1IjRDEIGb9zL9VHG5eqlsCX5bZVRXqrYXZC4OH/Vnmt11BW6GdEzKh7L+FzH3Un5StWbENupjp02iKCxw41ID2/Wr6oRro2iOFgH3RNCcm+/aY+V6LvJRGgwy8MOl6EmunxT6v9MQrNmRle/92aYwHlhNaUjpMhvyAlo3oY5O63T4CLgXV0i+sq1EGOmKEoP//yeBVV7gdw7VZJoLIGNIOfEyHgbh3peJ6pFa+WqjcR10rtcJS3Oy0OLfBoqkqfoWInv898UlpRYHyr4T4/MhwolOjo1FE+EQ3nmPgvUo8DsVuqhlG84F2EG9Hq6UllqHHUqFeVpOBuhVzQWH0KGScTVakAfGky1t/ELMHbWBPzmNHrHfd3JqcDX1QDja4DJ2X3hc6LPc++dGyKgBlH4L5ex1fwqNPBJMd1YV2NXRkVJ4ZJBt+pmSJR/w1YtuwFGNxJC1v84ZG/ss58MmRU9TK5+vb3Kob9tRUD4y4QAZQh//LAef+cEJn+74fhStGgS9y0kBSyM/wt4mG4sUR9fkvIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199021)(1590799018)(85182001)(5660300002)(91956017)(2906002)(122000001)(6486002)(2616005)(71200400001)(478600001)(31686004)(316002)(8936002)(6506007)(6512007)(41300700001)(66946007)(38070700005)(8676002)(26005)(86362001)(6916009)(66556008)(186003)(4326008)(66476007)(76116006)(66446008)(64756008)(1580799015)(83380400001)(31696002)(38100700002)(36756003)(82960400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmRFR1hVT29VbUtsTUNRdndLbjB4bnkvcTZwMElmd3I1VUpvTlZOZFB5eWtp?=
 =?utf-8?B?dE5Lc0IxVUtIVVd5NEUyeVVsTFVGMVd3NWtSZ0RLNERQNi80Mm0yWnp1cDV1?=
 =?utf-8?B?UDg4WTJxYlNqVkVaZlNsUnhqV2JlSm9aMW1OMnlNZ2pVVHlEMHVZeGJHMUV3?=
 =?utf-8?B?dDBNL0xFdytaRlA0OXRTd3QrcVRrcGJ4ekZJTWllNWZhajJISXFaUm8wRXo4?=
 =?utf-8?B?alNPRGZnSEszV1BZaE1EYk5IQTcwMDZUZ2Zrc0N5N2NJTTFpamZocnU2U2Rp?=
 =?utf-8?B?clJlM2RySE8wbGpKaVpoZE1qSEk3bGVXcFc4WG9tREV4THgxU05jcG5lTEtX?=
 =?utf-8?B?QUJyMUswRUxnSTQxZXZ2TUpoWXJKazNPby83SlM3RVdiam5CTCtSVG5SRlhH?=
 =?utf-8?B?bEVDSnYvWGg3Ry94ZTBQdCtnMkdOQUZaU1hvL1NqUUFTMXdNM0xOK0ZSdTJC?=
 =?utf-8?B?SlhKem1ic21XcmZJYU1iZFF6WEUxTmhSblZZTjEwQTM1cDRJelY5Yy96Mkk3?=
 =?utf-8?B?R2lkdzNUcWZTTzYwRlV0QzJGWlh2RUdGUHpKUDZXK215VVlLOXk1ai9TQVYr?=
 =?utf-8?B?VHVESlRnWStHQktlSHpnMW8wcjZaRU8zMVc4VUJvU2V0eDB5bUVaRHR3THF3?=
 =?utf-8?B?N0kxWVVjUjdLZGM2d1BrMnhuZnJqOXI4OGw3MGxyN2hyZkwwODlZYUR5UnZl?=
 =?utf-8?B?RHQ2OUh2MUwrMnlUZXRQVmI5RTBYcDBJNXcwY055bVg0bll1MnN0dVRqMzk3?=
 =?utf-8?B?d0V4NXNKWXJ1VDlmSy8rM011eHB3dm9QZUxSY3RPUE92ZVl6Wm84cU55UWFk?=
 =?utf-8?B?MXZVVVBYSTBtT1FrU3hHSVAxVXQvNjhQajRPTUVZbmNneFlpREgzTjhucWs2?=
 =?utf-8?B?NEJYM0RSbjlhVzhGcmFIb0V3T0x5OVBCVWE0ZjlBR2pGa0tENWg2QWFFZllo?=
 =?utf-8?B?WVlwWjVrZkExUk9OODM4N0p0eFJ6U0pCYkhmRmhjeHJPWFRSOWUzUjlCaE5l?=
 =?utf-8?B?aUgwMHpKRGt5RXJkcTkvMGJvMTA0dVNuZjJrVG5EZXJ2K3pUaGN2amlJSXZG?=
 =?utf-8?B?MkJGTk4rMDE1a3p3bzU2TGM3eUNTNjRDRTBJVzVUbDVSbm9FbDl2c1k0MnIv?=
 =?utf-8?B?TWFHeXhMdGhCWWczY2hwYUljMHRVM2hEQ1dBZGptZDZaVEx4cUZlMStmWm8w?=
 =?utf-8?B?UUVyUFZ1REVHNTNjSnREbFQzUGN0RHdTZGhlNWpwMk15Zm5mN3E3WDUwNTRS?=
 =?utf-8?B?aXZBQXhnN3RUU3pOTDBPNlBpbG5xbW1RTy9UMmR6cWlnTlJ2QTA3djloTFFz?=
 =?utf-8?B?UUIwdS9McEVLY05JcS9NQ3RtZUxFRjZmNjRzRE9pN3ZFVzh6K1VNR3YxQWd2?=
 =?utf-8?B?ZWluQndqeWxMWiswOXJlM0xqTUJ2QUYvYXJLQkh6VmxlQlJ3K0hINi9mb3dw?=
 =?utf-8?B?c1FtU2pSTzZTM3M1K0VDM1oyNUNuQ2Iwc0lVTVBtSmVpUFI4SW8yNjBta1Fm?=
 =?utf-8?B?UnZZdFM5OVZZU3ZSeW1VbCt5RkhOUDVVQUQzSzFxUHFjc1E3RjZMbHFyR0VH?=
 =?utf-8?B?bStNUGFWYTRUQTlFR0ZLRmVoMENnckZ0T01ldVFldHZWWHFodktMSzFIa2Z6?=
 =?utf-8?B?cVhVeERPVGx0N3FsYk9PUm9IQ0UzWnpYTDNwL3JXTW8wUGhzN0pnQXJGbUxL?=
 =?utf-8?B?ZWF5UkExaHRKc0VkUnNlQjhLT0x6eUlET2wxbHJNQXhWYWdHSjA3ZHZYMURw?=
 =?utf-8?B?VjV1c0xOVW5lVjIxK0hEb25odUFBUzJsd3Q1THlXTmVUcTBhZFlYMkVrUmpB?=
 =?utf-8?B?ZDJaZlFONHpOeFkwck41VFVMWWRtRkJVV3dKVFJEcDkrQ1Z6ZEJBbzRPaXZn?=
 =?utf-8?B?NDRHb0NoQm93NEdGM2g0U3RaTUpXUjJvYW1rT1MxKzRkRE9SeHdwUk5rUWRi?=
 =?utf-8?B?bG5sRkg3clRRd3RleXZXeVhFajZGTjFCV3hmVDFIZGNmRFRHbm9WbS9DYjdq?=
 =?utf-8?B?a2UwdGNPTEJiSUxDWVdOTXRzcXFGK3oxNzBqZWloNjJQbkNBV3R3TU1ZeHhU?=
 =?utf-8?B?V0ViNnFJZ1Y4K09KYlBMNzI1L0g2cGRKc1NoZFF6a2JkR0J3QUU3WmF4MWlw?=
 =?utf-8?B?aklOaEdqMDVkenU0WnNxenJDMkttUXdCRktzbUZGdGdiSXZzVzJheW1jWEMr?=
 =?utf-8?B?Y1E9PQ==?=
Content-ID: <8704609F6DC3824E9CF2D96B873F1EEF@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PUrk9wJIIeJIlyZZQgdDEdYyqsbmF7fGG/hbuRM1TRU8jf0N4DRuABkGyrDL0Ua4OiG+GfD07eSuYNkqxM40iz2KGdelfSu2KGX+4fheIBE9mtQ8kG5C9mVpSDLLLCFt+CSskZIr81YeWdrYMpQOpNK3rPcCotSOrWiWi/3fJ6wrO0qNG+cJjFx6AkfnzNH6oFA9t5G/m+KoiD+FvG2zQcqMnhRTYo74IAF/CQzIbup+SuBVORGEMk4urTqUwkEAciZorArsMg+sqC6owhr9O8QkmrJFF6dMVo8kAgpo+Oh1cxXiXaEdcsYvwktudR/b7Z8sTOLGqJ8mFTB+LVQNcIYW+eEajlm+s+2PgdB+YO3lzAIF5+knCxpUxTc0tDjQaXi5vG2f5uN4IHpRr27OjLUtnRCiYk5SdjrcIa8Ih1fxvnJyKjMxiezUWashPfZ2xm6W/9+uDoV1EuGIZ/XVwrRaxDP9sEgn3Ubc3wlX7EtvhmkzxE6MBT1bwGyv+0FY64NYbw4uuBHVz15jng4fbk7zeorAoUm8Bg7zhlRMKjzgGCM9ybSjXiVMJ5IXYujTbpcmr/XdSDOs0H20mFL8MIQopTNMt2Nb5tOhvnQmoZeyYwG7+9XU02rvBqxfNCMJWJe6aJtOVxvcaYZpjDC08uw7FbvyhkrvEyC93APOKaxTDpwTpY65Y1GjW2rdPCXKU/vmtEIzH+1FHqJt+ZGh4YcDbww7ZBnLR+LGpwp3Vs1ugdGmLlbGm2MUbdK2eZ7LIlXl/L/5Hl+C1f0In9GA3LxVgr2o7kw2k0Fr8RHee+g=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5e150e-d95b-417d-6696-08db46bfd438
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 01:36:31.5944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tvXUxIfFvQSNBP0ks3Eziv/uk2oYOVsZX4Ime9lPALFABSi0kd2anwSmjV2YyhklGLKpbcKbDnjQ1TR58t5+Qakzz9zKCT3dk9OLU/3+KyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10855
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/4] lapi/stat.h: Add STATX_DIOALIGN related
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



on 2023/04/27 5:56, Eric Biggers wrote:
> On Thu, Apr 06, 2023 at 01:40:19PM +0800, Yang Xu wrote:
>> Also add missing stx_mnt_id.
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   include/lapi/stat.h | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
>> index ce1f2b678..c2db8a589 100644
>> --- a/include/lapi/stat.h
>> +++ b/include/lapi/stat.h
>> @@ -97,7 +97,11 @@ struct statx {
>>   	uint32_t	stx_dev_major;
>>   	uint32_t	stx_dev_minor;
>>   	/* 0x90 */
>> -	uint64_t	__spare2[14];
>> +	uint64_t	stx_mnt_id;
>> +	uint32_t	stx_dio_mem_align;
>> +	uint32_t	stx_dio_offset_align;
>> +	/* 0xa0 */
>> +	uint64_t	__spare1[12];
>>   	/* 0x100 */
>>   };
> 
> Not like it matters, but the kernel header has __spare3, not __spare1.

Yes, I know this.

Sorry, I don't explain this reason for using _spare1[12] in commit message.

Looks the history of this struct in the kernel header.

Since kernel commit a528d35e ("statx: Add a system call to make enhanced 
file info available")[1], it introduced 
__spare0[1],__spare1[1],__spare2[14].


Then in kernel commit 3209f68 ("statx: Include a mask for stx_attributes 
in struct statx")[2], it uses stx_attributes_mask to replace __spare1[1],
so it leaves a gap.


After kernel commit fa2fcf4f1 ("statx: add mount ID")[3], it uses 
stx_mnit_id and _spare2 , _spare3[12] to replace _spare2[14].

Finally, in kernel commit 825cf206 ("statx: add direct I/O alignment 
information")[4], use  stx_dio_mem_align and stx_dio_offset_align to 
replace _spare2. It also leaves a gap.

That is why I use __spare1[12] instead of _spare3[12].


[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/uapi/linux/stat.h?id=a528d35e8b
[2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/uapi/linux/stat.h?id=3209f68b
[3]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/uapi/linux/stat.h?id=fa2fcf4f
[4]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/uapi/linux/stat.h?id=825cf206

Best Regards
Yang Xu

> 
> - Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
