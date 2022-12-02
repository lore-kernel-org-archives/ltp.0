Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B88C4332F
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 02:30:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDC203CC4B8
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 03:30:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A99D3CC4B2
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 03:30:46 +0100 (CET)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A2962145F177
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 03:30:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1669948246; x=1701484246;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=6vXdrQaEFdteroRHdQ4ceLJbxTQb+UkGb164tglZ7+Y=;
 b=QSDvKZOUaWPsufCVOQqMex5rNBwGErpGs2plWB57nIvkCVPZYnJUUb5d
 2VeX6APTU9Qzedka2UcoK8HZLws8RnLX5SAVIxDGU2h/cyUL3NQDVUXL6
 5zHEneTFB3gdAtq3LsX7bOuTux2uaNY5nZWntrMIqwwN2svT9dQorISxq
 eEGp/GCuVCIJlaKnPNWvpJnwzgfK5h5MjuVZOY2lWN5nAxnI8e9bIxHo2
 QjZz5+mzZZFZkWvqocJgvPKlqVJeNkQjwK2HwZIfhxDWU2vXJBbNHU+sK
 8Skr4pHbTKNeJaZ9zOmiWvb60lBlsZjCHktEDxqePEbNyVRpQ7HvSLkTB A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="71351563"
X-IronPort-AV: E=Sophos;i="5.96,210,1665414000"; d="scan'208";a="71351563"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2022 11:30:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=appMyh/VphRenlI1XD/NSLnYfa5m1CT06A1s/VQz6wakrYhgXWRtngBdZTrXgcy9YHVif1oyNEvXnTHdz6bJ71FRzWea3FFiQkbYOJf6WuGPjtDSxURpixPta8yyLCnwqyzZkqPsmX1ChGXp/w3U0w6HHfsYcjRxz4YZr/tM1Hibcdn/tljmi8/TdxDg9HE/Kkgiarw2suEc5boWNtdB+QlvzsFSeaVCoXuBE1/GwWoVHVNfg2SjY5114KyGj4TbXfLH33f1i1Q20r54Wdrow6DtdtC+j1RJet1IsIpHfbbm+Q7pLeXTHfWGEWv/vfXGsD52U35i+hBZNzbDSsp5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vXdrQaEFdteroRHdQ4ceLJbxTQb+UkGb164tglZ7+Y=;
 b=mwTRnF+w28kzozcNcbIVKmtM1SdLckbqG3gHjSBmzu13Od8inKP7DQP08Y9cIASWrmNySdXToXW7InRGNagltiEZqM/PbN8HDq+JJzSPKmwZ639BN2kAN/b+JObxs/sD2EwUM64L7iO3u71rFg35ZSbrrxob6TQVChASilTjb8owyn/eaRE1bsZ58Um2MTpAFi8D4fKKpdsUd4ccGcC4wUf5gvSQPi1WWMOXU3hmAyahe6viqZFjnpb1m5Fu7pnurdWAPsIuzs2SarK6xQAlyLtMlAoTyh2fP0s8TSj+i8PQlbuRfNTGmdRZDoVjCu0xmbp1rOTHsrF2bhXD5WDzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OSZPR01MB8123.jpnprd01.prod.outlook.com (2603:1096:604:165::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 02:30:37 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%7]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 02:30:37 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>, Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v1 1/2] include/lapi/sched.h: move
 namespaces_constants.h's constant into here
Thread-Index: AQHZA7UViHoM/+lEqk6P51ExQRSM4K5Y0ZGAgAEkIYA=
Date: Fri, 2 Dec 2022 02:30:36 +0000
Message-ID: <c792d219-b220-a300-3e88-5fdb6b311b52@fujitsu.com>
References: <1669704060-5635-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87pmd3igk3.fsf@suse.de>
In-Reply-To: <87pmd3igk3.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OSZPR01MB8123:EE_
x-ms-office365-filtering-correlation-id: 0358a5b1-e216-42a3-700f-08dad40d3245
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xlkBaDpS4kxtkch0nL0FHqv+ka8YvblHvDsIovD+CdjgszSKtJDvDzTgDENWfj4nLbAFwjgMysyJnwdr5jaaNofeXfgZ6+oEoRyVzruq6oQGCkNic/QcUiUTkWsgIIamZZiz5IaPcUrLOMZ476o336QBEI+r2OnciCKhxniodXawJnYx3jVIBklZhbBa87Uqn7MS8ekxyI0Kt7ac0gtHiWjkx3CGoN5CBxOdeyLSMy+gecMJ8MKsPpAWKa42p07FQuY52noAMoHGciV6hLrtazJFFV/JOXwdik8DZoEe4ENphJzCK0VFTNIFuUYdy567CzgMElAmQXmBl9AvJtYpVE4Xx5VeHbFlLO2r9dph6/46fCmbQdheiFThBli5bQr48eWkif97uepClpRQq2n5O5bz+kukHhUrxPoUZY/KsL8w5AG2wZIYkux9F5w55gAeJgv9zzhZlq33NjJmrGP7mFhgtJrbb4cr1ur2MPS3RT8TC0gW7B29DukIZWYZJT+9hEmWE04I5NRvpnNYVA29pK4E8PRotTOHjPELU0iAT/ehLDUO7+QcB3jfCDbG0g8D4VxlnKQHGR83upEqbZwISFpGrY/P/KiHae70ycCcxfCIHsmLuP0rJ8E+2P4HmAkxQjHJOZ0thcdCoESDevrmwl6IIMNqtaiSi4tt1AxJreBL3ldcPsjqS3hRpQRvjARuk9Npk//yuh5D6dn8Xa88ZIzrTArrpSHrDtXFvInIxTN0sdIdRzSD7ccaxAHvWqSh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(1590799012)(38070700005)(36756003)(2906002)(85182001)(4326008)(86362001)(71200400001)(478600001)(6486002)(31696002)(5660300002)(66476007)(110136005)(6506007)(66946007)(30864003)(8936002)(26005)(64756008)(8676002)(66556008)(66446008)(91956017)(316002)(41300700001)(122000001)(83380400001)(38100700002)(6512007)(2616005)(76116006)(31686004)(1580799009)(186003)(82960400001)(45980500001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anV4cEVmMkN4VDBaNkNsSEZxTWIwZW1TWm12eTdyZElCcHdueVN3V2c0MnpB?=
 =?utf-8?B?ZTRFZnpKVFNlSVppWTUwM0J0Yk1VWk5BZXZWZ2M1eUR4akwxeC9jaW0yWC9G?=
 =?utf-8?B?ZGZKY0wvdlh4L2VnU2JuU25NaVJQZGZWSnNXK3ZsSnFNVmJldGlIRE9tRHhP?=
 =?utf-8?B?UHd2N0VqVjZFSzIxQWgxTXlHK25SZjE2Nm9qZGZ6amJSbUxhME13Q1BLdjFo?=
 =?utf-8?B?SkEzbVNUZVNmbCsyN05iTlNEQ3BXVThmaGZWVXNZRmpwQVlyc3hKVUJESEJH?=
 =?utf-8?B?ZUVNZTNCNzBRSXR6cVNBMFBLT0dzNzBmV3ZtcWZwSFlEeER6ZDJNSHAxaElr?=
 =?utf-8?B?OEJpWEJHVmRMa2Y2VkVWVy85aC9jckdqMHI4MThxNXErZmFKT3ZCNmlXT1Zv?=
 =?utf-8?B?QUVDbTduR3FCNi83RnZCcyt6bDBZdHdyTmVabU5XQUhZUGw5NWcrSHBkRlNr?=
 =?utf-8?B?bEtsc2diV0xNRVd4RnRwQys1K3NKRlBCSXY0cWJPWnY5MEtpTGlaaHBpM2RB?=
 =?utf-8?B?SFVMS0xEV0hLRHFIZGVVUWNSb0trb0c4NkRITHFGd1dBSjZRYVBGOHE2ditQ?=
 =?utf-8?B?bWpTSVFRcERmWUxhWGd3Z2dNemxRNkJZb0lXVFpsUE9mY1RZK05paDdJY0ZD?=
 =?utf-8?B?Z2ZzTXEraEZ1ckhwY1hRbDNNSE5Od3ptR3k5SWQvSDV3NWl6enVXblZ1WHov?=
 =?utf-8?B?aTRWMUd2VGRCb0ZGcnpPM3B4SEtWVzBCeUg2eTBhZ3REeFRxclhtWE1GMkVP?=
 =?utf-8?B?UFZJb2lPZjVnR3FDeTR3dnlweXVPK1FGWUJ3Y0NGUXhmaUhqZEkrZ3VNc1FY?=
 =?utf-8?B?a2NpTUkrOXF4c29hUCttM1h2Y2d6R2liU2RHSXpZZWNiQU5mUkJTVm9KYTlX?=
 =?utf-8?B?NStRTFJiSWJmR2VEQ1ZzbnNld1BYMmg5SFB3bnM2cDFxdFQrL1hsbFpoTWY1?=
 =?utf-8?B?dUdRUndXR2RaRWpsbmdabmY4YS9adnlTTTBvTjNDWjhmcUNGaDlMdHFsa1lB?=
 =?utf-8?B?bzY5UW9yd2pSdy83a1RiRHZ4Q3JRQTBUTWlhOHlzYWdQQW5wYXhDUVVoWC8v?=
 =?utf-8?B?UVpCYU5YRWpaMG5yQlQ4LzNZb2JncDl6NXRMQmFjaWFnTTk5dWw2a2Zwdi9z?=
 =?utf-8?B?eFhGVWN6MVlZZkhMY2tNb0d6c0lvaTVVaUU5QXR1ZDd6Qm02TG5yQ2NSeWlP?=
 =?utf-8?B?UnlvYUwwcUZJa2V3Qkdtdk5zTVQxMlVzcFFoRXJOQlFWUDBkZXA1SXpDaEZQ?=
 =?utf-8?B?SDAvZlV4ZDBVY09sY2czbXErK3Aya3FhWmo3bUdjaEtGSHNjOGlDUUQ0VzhK?=
 =?utf-8?B?TVlmUWVJU0NaODhyc1p3ekpJZmRyMHZuTFpQWkZQSm82dC9mYlJMOEMveHRr?=
 =?utf-8?B?TWYrSStkYnN1MzMzdHVIakZ0YUtIa1d4RTc3bU13S1JjTHFNQ05LcDRqdmU3?=
 =?utf-8?B?V2lPajBjSHFUOFlvaEZyRTRXcEgwem5lTmI1QmI3VEdBSU9OSjNtalloNU5B?=
 =?utf-8?B?bFZkRmpqbUkzUVpiWjRVUkFweGl2MXpsQS9SR05LY3NYd1Ezamt3SUk1eUVo?=
 =?utf-8?B?Z3JEWlByZG9kMDRHazhNeGZubjlFQUUrQm5TU2kyaXBsVUdWS1BzM3pMaEox?=
 =?utf-8?B?L0hLakxYcXdEN0M4YWRJOHRzR0pxOGFxbXltWDBSSXFuTU41MTd6dENCbzd6?=
 =?utf-8?B?VEZYQkI1YUZWdUp5NVVwZ2ExQ2s1bS9NYjdvU0FnSWx0QWxTSVZEREN6Wjlk?=
 =?utf-8?B?WTRkUkowaXA0K1E1amI3L25YN0VsYldnTjU2ZWx4Y1R5YU9iNlEzY0FvQXhL?=
 =?utf-8?B?Sm1ZRktDWDlSQ1ZQd1l5dmloREVFMFBVbG53NGNCT3ZQYmwwZi9YTmF3MDZM?=
 =?utf-8?B?T2t3M0R6ejNJTmF5dWpPVkdGcGovRFQ0QStQc1l4YnN6OEhsc1VsUmpxYmJI?=
 =?utf-8?B?bUlWNE55UFJQdS9wd0xjTW13QjFqV3NSSlpYYzdNUjZNd1lDVm9BNlROaDNr?=
 =?utf-8?B?dmtYOG0wTk11NWxwdzlFR1JpRUdXV0MrZ2JnZ1h6OXV6UnpOS3IzS09aNlhz?=
 =?utf-8?B?eVI0c2M1b2UxUHcxbWMrZDFURUt3WC9FTjArTG9zTm0xNURrWC9WQXJtTGIv?=
 =?utf-8?B?MC9LTEFPU3lJNmwwMzNGUFQ5Q2NOOUFILzE1WDZBV0dxWWYzazZ1WUppWGdE?=
 =?utf-8?B?WWc9PQ==?=
Content-ID: <C35D1A76C43F3C44AFE64CA3B95BF188@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7OBUTFzn8qYtvRyfccPOS9eOzYzGWN/laXF5+6yUajCmiVaaDjlm6ZqECGgnfzEAZBArdW9/WiM4s2sejPB4gTHWR0wIEbf/fiu1w20jtzoNF4O5wAbd868O1JCU0iVMU/JHMhW8kivjjOdiN7uekQ8ccQH9URHwYCdZHh0Q+3J01AqNm3thxEY+kFUTOSN9IqlNuBgpbQwVvm042LIOmLXpvWuXw16ev9pltu+RxJhX7sdVHt2ZP4D/Vzpq5tZw8PDmz8yh0eIcxcdjFPti2qhLRsJ9QP4WXtqvHdzMilW76w5pJwQMZHFZak+AH4M9YtsuQigceJVGZ1t7Z5ITLrNkeBlXzfcecJz1X/oXsUhJOVA9HW4k6y9eOlIfUSETKChwbm1OhTsPt9xIAk7J2iZnZkSOBOlHoFij0UkYwQkQdL4CYIacSSCQZl4ogfiPxtGvp5kxor+1J3CuMevMny1LYlG0rEHcMlqRBdz6f3r8nc+kwLkB+tY5BDP1ewHXQ19yEG/i+IjJgs2TCYqPedMyyx7HSC88mMuqEe8nhhwnCxXLlrctohyOWfmgI2xU3P9kLcKpIU0ThBh4idBxKFqets/gwioOPGnD1d1/A9o9fv74ENHwYEQPZ0mbCNKLZCTwN8S9zGwIu0gXx3VGctiIWirtEX5CSbgsNMoBn38fQXcUn/6VhoBfoQKHImjIQnB20b+l622C/iityq8cg4+LIZ+bAFdYSmw9AMf5UQ51WoJxqq1xAh5OJVm3HkSPIB3jGd6QcqRGZrzcG6G8xNA4r5p0VXOkK3Ra4BewzkZhw4c01BCbD0v+2iVSlePf
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0358a5b1-e216-42a3-700f-08dad40d3245
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 02:30:36.9265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ih+mRMaKZ2bjFLj8Ji4kOvFXkiVPbuqY6LHJXai3mHb4Dzm5DojWAtPAAbfGdO5Upw0OXn9UHhpIIkl0HD160m02NqE4npkRN4t8Cm7YW4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8123
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] include/lapi/sched.h: move
 namespaces_constants.h's constant into here
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

Hi Li, Richard


Thanks for your review, merged this patchset!

Best Regards
Yang Xu
> 
> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
> 
>> Kernel header doesn't have this namespaces_constants.h header file and
>> it can be moved into lapi/sched. Also, lapi/clone.h have some duplicated
>> CLONE_* constants, they should be moved into here too.
> 
> Good.
> 
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> 
> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
> 
>> ---
>>   include/lapi/namespaces_constants.h           | 34 ---------------
>>   include/lapi/sched.h                          | 41 +++++++++++++++++--
>>   lib/tst_net.c                                 |  2 +-
>>   testcases/cve/cve-2017-16939.c                |  2 +-
>>   testcases/cve/icmp_rate_limit01.c             |  2 +-
>>   .../kernel/containers/libclone/libclone.h     |  3 +-
>>   testcases/kernel/containers/mountns/mountns.h |  2 +-
>>   .../kernel/containers/netns/netns_netlink.c   |  3 +-
>>   testcases/kernel/containers/pidns/pidns01.c   |  2 +-
>>   testcases/kernel/containers/pidns/pidns02.c   |  2 +-
>>   testcases/kernel/containers/pidns/pidns03.c   |  2 +-
>>   testcases/kernel/containers/pidns/pidns12.c   |  2 +-
>>   testcases/kernel/containers/pidns/pidns20.c   |  2 +-
>>   testcases/kernel/containers/pidns/pidns32.c   |  2 +-
>>   testcases/kernel/containers/share/ns_common.h |  2 +-
>>   testcases/kernel/containers/share/ns_create.c |  3 +-
>>   testcases/kernel/containers/share/ns_exec.c   |  3 +-
>>   testcases/kernel/containers/sysvipc/common.h  |  2 +-
>>   testcases/kernel/containers/timens/timens01.c |  2 +-
>>   testcases/kernel/containers/userns/common.h   |  2 +-
>>   .../kernel/controllers/cgroup/cgroup_core02.c |  3 +-
>>   .../syscalls/clock_gettime/clock_gettime03.c  |  2 +-
>>   .../clock_nanosleep/clock_nanosleep03.c       |  2 +-
>>   testcases/kernel/syscalls/clone/clone09.c     |  3 +-
>>   .../kernel/syscalls/fanotify/fanotify17.c     |  3 +-
>>   .../kernel/syscalls/getxattr/getxattr05.c     |  3 +-
>>   testcases/kernel/syscalls/ioctl/ioctl_ns01.c  |  3 +-
>>   testcases/kernel/syscalls/ioctl/ioctl_ns05.c  |  3 +-
>>   testcases/kernel/syscalls/ioctl/ioctl_ns06.c  |  3 +-
>>   testcases/kernel/syscalls/setns/setns.h       |  2 +-
>>   testcases/kernel/syscalls/sysinfo/sysinfo03.c |  2 +-
>>   testcases/kernel/syscalls/timerfd/timerfd04.c |  2 +-
>>   32 files changed, 67 insertions(+), 79 deletions(-)
>>   delete mode 100644 include/lapi/namespaces_constants.h
>>
>> diff --git a/include/lapi/namespaces_constants.h b/include/lapi/namespaces_constants.h
>> deleted file mode 100644
>> index e34b0d6a8..000000000
>> --- a/include/lapi/namespaces_constants.h
>> +++ /dev/null
>> @@ -1,34 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0-or-later
>> -/*
>> - * Copyright (c) 2015 Red Hat, Inc.
>> - */
>> -
>> -#ifndef LAPI_NAMESPACES_CONSTANTS_H__
>> -#define LAPI_NAMESPACES_CONSTANTS_H__
>> -
>> -#ifndef CLONE_NEWIPC
>> -#  define CLONE_NEWIPC	0x08000000
>> -#endif
>> -#ifndef CLONE_NEWNS
>> -#  define CLONE_NEWNS	0x00020000
>> -#endif
>> -#ifndef CLONE_NEWNET
>> -#  define CLONE_NEWNET	0x40000000
>> -#endif
>> -#ifndef CLONE_NEWPID
>> -#  define CLONE_NEWPID	0x20000000
>> -#endif
>> -#ifndef CLONE_NEWUSER
>> -#  define CLONE_NEWUSER	0x10000000
>> -#endif
>> -#ifndef CLONE_NEWCGROUP
>> -#  define CLONE_NEWCGROUP 0x02000000
>> -#endif
>> -#ifndef CLONE_NEWUTS
>> -#  define CLONE_NEWUTS	0x04000000
>> -#endif
>> -#ifndef CLONE_NEWTIME
>> -#  define CLONE_NEWTIME 0x00000080
>> -#endif
>> -
>> -#endif /* LAPI_NAMESPACES_CONSTANTS_H__ */
>> diff --git a/include/lapi/sched.h b/include/lapi/sched.h
>> index 226d3109a..3b0b4be31 100644
>> --- a/include/lapi/sched.h
>> +++ b/include/lapi/sched.h
>> @@ -8,6 +8,7 @@
>>   #define LAPI_SCHED_H__
>>   
>>   #include <sched.h>
>> +#include <unistd.h>
>>   #include <stdint.h>
>>   #include <inttypes.h>
>>   #include "lapi/syscalls.h"
>> @@ -47,19 +48,51 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
>>   #endif
>>   
>>   #ifndef CLONE_VM
>> -# define CLONE_VM   0x00000100
>> +# define CLONE_VM	0x00000100
>>   #endif
>>   
>>   #ifndef CLONE_FS
>> -# define CLONE_FS   0x00000200
>> +# define CLONE_FS	0x00000200
>> +#endif
>> +
>> +#ifndef CLONE_NEWNS
>> +# define CLONE_NEWNS	0x00020000
>>   #endif
>>   
>>   #ifndef CLONE_SYSVSEM
>> -# define CLONE_SYSVSEM   0x00040000
>> +# define CLONE_SYSVSEM	0x00040000
>> +#endif
>> +
>> +#ifndef CLONE_NEWCGROUP
>> +# define CLONE_NEWCGROUP	0x02000000
>> +#endif
>> +
>> +#ifndef CLONE_NEWUTS
>> +# define CLONE_NEWUTS		0x04000000
>> +#endif
>> +
>> +#ifndef CLONE_NEWIPC
>> +#  define CLONE_NEWIPC		0x08000000
>> +#endif
>> +
>> +#ifndef CLONE_NEWUSER
>> +#  define CLONE_NEWUSER		0x10000000
>> +#endif
>> +
>> +#ifndef CLONE_NEWPID
>> +#  define CLONE_NEWPID		0x20000000
>> +#endif
>> +
>> +#ifndef CLONE_NEWNET
>> +# define CLONE_NEWNET		0x40000000
>>   #endif
>>   
>>   #ifndef CLONE_IO
>> -# define CLONE_IO        0x80000000
>> +# define CLONE_IO		0x80000000
>> +#endif
>> +
>> +#ifndef CLONE_NEWTIME
>> +# define CLONE_NEWTIME		0x00000080
>>   #endif
>>   
>>   #endif /* LAPI_SCHED_H__ */
>> diff --git a/lib/tst_net.c b/lib/tst_net.c
>> index 61fc0ea76..a97e25b11 100644
>> --- a/lib/tst_net.c
>> +++ b/lib/tst_net.c
>> @@ -14,7 +14,7 @@
>>   #include "tst_test.h"
>>   #include "tst_net.h"
>>   #include "tst_private.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   void tst_print_svar(const char *name, const char *val)
>>   {
>> diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.c
>> index eb5400c0c..e41fb274a 100644
>> --- a/testcases/cve/cve-2017-16939.c
>> +++ b/testcases/cve/cve-2017-16939.c
>> @@ -25,7 +25,7 @@
>>   #include "tst_res_flags.h"
>>   #include "tst_safe_macros.h"
>>   #include "tst_safe_net.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define BUFSIZE 2048
>>   
>> diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
>> index 7a51aa0a4..8ee50a276 100644
>> --- a/testcases/cve/icmp_rate_limit01.c
>> +++ b/testcases/cve/icmp_rate_limit01.c
>> @@ -34,7 +34,7 @@
>>   #include "lapi/if_addr.h"
>>   #include "tst_test.h"
>>   #include "tst_netdevice.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define DSTNET 0xfa444e00 /* 250.68.78.0 */
>>   #define SRCNET 0xfa444e40 /* 250.68.78.64 */
>> diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/kernel/containers/libclone/libclone.h
>> index b8740f1bc..e92fdca02 100644
>> --- a/testcases/kernel/containers/libclone/libclone.h
>> +++ b/testcases/kernel/containers/libclone/libclone.h
>> @@ -19,7 +19,6 @@
>>   
>>   #include <stdio.h>
>>   #include <stdlib.h>
>> -#include <sched.h>
>>   #include <unistd.h>
>>   #include <string.h>
>>   #include <errno.h>
>> @@ -28,7 +27,7 @@
>>   #include <signal.h>
>>   #include "lapi/syscalls.h"
>>   #include "test.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define T_UNSHARE 0
>>   #define T_CLONE 1
>> diff --git a/testcases/kernel/containers/mountns/mountns.h b/testcases/kernel/containers/mountns/mountns.h
>> index 76b37b477..615f1a058 100644
>> --- a/testcases/kernel/containers/mountns/mountns.h
>> +++ b/testcases/kernel/containers/mountns/mountns.h
>> @@ -8,7 +8,7 @@
>>   #define COMMON_H
>>   
>>   #include "tst_test.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define DIRA "LTP_DIR_A"
>>   #define DIRB "LTP_DIR_B"
>> diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
>> index 6f60ff94e..e8df616e2 100644
>> --- a/testcases/kernel/containers/netns/netns_netlink.c
>> +++ b/testcases/kernel/containers/netns/netns_netlink.c
>> @@ -33,11 +33,10 @@
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <errno.h>
>> -#include <sched.h>
>>   
>>   #include "tst_test.h"
>>   #include "tst_safe_macros.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define MAX_TRIES 1000
>>   
>> diff --git a/testcases/kernel/containers/pidns/pidns01.c b/testcases/kernel/containers/pidns/pidns01.c
>> index eba4b806b..5080b6fad 100644
>> --- a/testcases/kernel/containers/pidns/pidns01.c
>> +++ b/testcases/kernel/containers/pidns/pidns01.c
>> @@ -15,7 +15,7 @@
>>    */
>>   
>>   #include "tst_test.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>>   {
>> diff --git a/testcases/kernel/containers/pidns/pidns02.c b/testcases/kernel/containers/pidns/pidns02.c
>> index 9f3a46526..b8913d3f6 100644
>> --- a/testcases/kernel/containers/pidns/pidns02.c
>> +++ b/testcases/kernel/containers/pidns/pidns02.c
>> @@ -14,7 +14,7 @@
>>    */
>>   
>>   #include "tst_test.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>>   {
>> diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
>> index b9b38b5d9..122ba7891 100644
>> --- a/testcases/kernel/containers/pidns/pidns03.c
>> +++ b/testcases/kernel/containers/pidns/pidns03.c
>> @@ -13,7 +13,7 @@
>>   
>>   #include <sys/mount.h>
>>   #include "tst_test.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define PROCDIR "proc"
>>   
>> diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
>> index 0e6b17142..fb1ec90ca 100644
>> --- a/testcases/kernel/containers/pidns/pidns12.c
>> +++ b/testcases/kernel/containers/pidns/pidns12.c
>> @@ -16,7 +16,7 @@
>>   #define _GNU_SOURCE 1
>>   #include <signal.h>
>>   #include "tst_test.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   static volatile pid_t sig_pid = -1;
>>   
>> diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
>> index f1e239dde..9f369699a 100644
>> --- a/testcases/kernel/containers/pidns/pidns20.c
>> +++ b/testcases/kernel/containers/pidns/pidns20.c
>> @@ -15,7 +15,7 @@
>>   #define _GNU_SOURCE 1
>>   #include <signal.h>
>>   #include "tst_test.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   static volatile int signals;
>>   static volatile int last_signo;
>> diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
>> index 333e1fcad..3f7df788e 100644
>> --- a/testcases/kernel/containers/pidns/pidns32.c
>> +++ b/testcases/kernel/containers/pidns/pidns32.c
>> @@ -15,7 +15,7 @@
>>   
>>   #include <sys/mman.h>
>>   #include "tst_test.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define MAXNEST 32
>>   
>> diff --git a/testcases/kernel/containers/share/ns_common.h b/testcases/kernel/containers/share/ns_common.h
>> index 69e51ce71..0f85aceb4 100644
>> --- a/testcases/kernel/containers/share/ns_common.h
>> +++ b/testcases/kernel/containers/share/ns_common.h
>> @@ -17,7 +17,7 @@
>>   #ifndef __NS_COMMON_H__
>>   #define __NS_COMMON_H__
>>   #include <sched.h>
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define PROC_PATH "/proc"
>>   #define NS_TOTAL 6
>> diff --git a/testcases/kernel/containers/share/ns_create.c b/testcases/kernel/containers/share/ns_create.c
>> index d4259f38b..3f09e71e0 100644
>> --- a/testcases/kernel/containers/share/ns_create.c
>> +++ b/testcases/kernel/containers/share/ns_create.c
>> @@ -24,7 +24,6 @@
>>    */
>>   
>>   #define _GNU_SOURCE
>> -#include <sched.h>
>>   #include <sys/syscall.h>
>>   #include <sys/types.h>
>>   #include <sys/stat.h>
>> @@ -32,7 +31,7 @@
>>   #include <string.h>
>>   #include <errno.h>
>>   #include "test.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   #include "ns_common.h"
>>   
>>   char *TCID = "ns_create";
>> diff --git a/testcases/kernel/containers/share/ns_exec.c b/testcases/kernel/containers/share/ns_exec.c
>> index c492165f0..4abd1063b 100644
>> --- a/testcases/kernel/containers/share/ns_exec.c
>> +++ b/testcases/kernel/containers/share/ns_exec.c
>> @@ -21,7 +21,6 @@
>>    */
>>   
>>   #define _GNU_SOURCE
>> -#include <sched.h>
>>   #include <sys/syscall.h>
>>   #include <sys/types.h>
>>   #include <sys/wait.h>
>> @@ -31,7 +30,7 @@
>>   #include <errno.h>
>>   #include "test.h"
>>   #include "lapi/syscalls.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   #include "ns_common.h"
>>   
>>   char *TCID = "ns_exec";
>> diff --git a/testcases/kernel/containers/sysvipc/common.h b/testcases/kernel/containers/sysvipc/common.h
>> index 258d355d7..9b0fc16e9 100644
>> --- a/testcases/kernel/containers/sysvipc/common.h
>> +++ b/testcases/kernel/containers/sysvipc/common.h
>> @@ -11,7 +11,7 @@
>>   #include <stdlib.h>
>>   #include "tst_test.h"
>>   #include "lapi/syscalls.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   enum {
>>   	T_CLONE,
>> diff --git a/testcases/kernel/containers/timens/timens01.c b/testcases/kernel/containers/timens/timens01.c
>> index 3f6235ec3..3621b3446 100644
>> --- a/testcases/kernel/containers/timens/timens01.c
>> +++ b/testcases/kernel/containers/timens/timens01.c
>> @@ -15,9 +15,9 @@
>>    */
>>   
>>   #define _GNU_SOURCE
>> -#include "lapi/namespaces_constants.h"
>>   #include "lapi/posix_clocks.h"
>>   #include "tst_test.h"
>> +#include "lapi/sched.h"
>>   
>>   static struct tcase {
>>   	const char *desc;
>> diff --git a/testcases/kernel/containers/userns/common.h b/testcases/kernel/containers/userns/common.h
>> index d3bdcc53f..635d0f190 100644
>> --- a/testcases/kernel/containers/userns/common.h
>> +++ b/testcases/kernel/containers/userns/common.h
>> @@ -8,7 +8,7 @@
>>   #define COMMON_H
>>   
>>   #include "tst_test.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define UID_MAP 0
>>   #define GID_MAP 1
>> diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcases/kernel/controllers/cgroup/cgroup_core02.c
>> index e6d599b36..1872a7dff 100644
>> --- a/testcases/kernel/controllers/cgroup/cgroup_core02.c
>> +++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
>> @@ -24,14 +24,13 @@
>>    */
>>   
>>   #define _GNU_SOURCE
>> -#include <sched.h>
>>   #include <stdlib.h>
>>   #include <stdio.h>
>>   #include <sys/types.h>
>>   #include <pwd.h>
>>   #include "tst_test.h"
>>   #include "tst_safe_file_at.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   static struct tst_cg_group *cg_child_a, *cg_child_b;
>>   static uid_t nobody_uid;
>> diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
>> index f185977d3..b02d22a14 100644
>> --- a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
>> +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
>> @@ -18,7 +18,7 @@
>>   #include "time64_variants.h"
>>   #include "tst_safe_clocks.h"
>>   #include "tst_timer.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   static struct tcase {
>>   	int clk_id;
>> diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
>> index 5bd91fa61..dfc522278 100644
>> --- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
>> +++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
>> @@ -18,7 +18,7 @@
>>   #include "time64_variants.h"
>>   #include "tst_safe_clocks.h"
>>   #include "tst_timer.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define OFFSET_S 10
>>   #define SLEEP_US 100000
>> diff --git a/testcases/kernel/syscalls/clone/clone09.c b/testcases/kernel/syscalls/clone/clone09.c
>> index e9e584564..e4691f513 100644
>> --- a/testcases/kernel/syscalls/clone/clone09.c
>> +++ b/testcases/kernel/syscalls/clone/clone09.c
>> @@ -4,14 +4,13 @@
>>    */
>>   
>>   #define _GNU_SOURCE
>> -#include <sched.h>
>>   #include <stdlib.h>
>>   #include <errno.h>
>>   
>>   #include "tst_test.h"
>>   #include "clone_platform.h"
>>   #include "lapi/syscalls.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   static void *child_stack;
>>   static int sysctl_net = -1;
>> diff --git a/testcases/kernel/syscalls/fanotify/fanotify17.c b/testcases/kernel/syscalls/fanotify/fanotify17.c
>> index 7d74b2540..3ecb31b6e 100644
>> --- a/testcases/kernel/syscalls/fanotify/fanotify17.c
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify17.c
>> @@ -20,11 +20,10 @@
>>   #include <errno.h>
>>   #include <unistd.h>
>>   #include <sys/types.h>
>> -#include <sched.h>
>>   #include <stdlib.h>
>>   
>>   #include "tst_test.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #ifdef HAVE_SYS_FANOTIFY_H
>>   #include "fanotify.h"
>> diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
>> index 3e73cc567..28eb4cbcf 100644
>> --- a/testcases/kernel/syscalls/getxattr/getxattr05.c
>> +++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
>> @@ -20,7 +20,6 @@
>>   #include <errno.h>
>>   #include <unistd.h>
>>   #include <sys/types.h>
>> -#include <sched.h>
>>   #include <stdlib.h>
>>   
>>   #ifdef HAVE_SYS_XATTR_H
>> @@ -32,7 +31,7 @@
>>   #endif
>>   
>>   #include "tst_test.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #if defined(HAVE_SYS_XATTR_H) && defined(HAVE_LIBACL)
>>   
>> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
>> index 95be877dc..06c81ba1b 100644
>> --- a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
>> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
>> @@ -19,11 +19,10 @@
>>   #define _GNU_SOURCE
>>   
>>   #include <errno.h>
>> -#include <sched.h>
>>   #include <stdlib.h>
>>   #include "tst_test.h"
>>   #include "lapi/ioctl_ns.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define STACK_SIZE (1024 * 1024)
>>   
>> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
>> index ae2f9da51..36e41c468 100644
>> --- a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
>> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
>> @@ -18,11 +18,10 @@
>>   
>>   #include <errno.h>
>>   #include <stdio.h>
>> -#include <sched.h>
>>   #include <stdlib.h>
>>   #include "tst_test.h"
>>   #include "lapi/ioctl_ns.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define STACK_SIZE (1024 * 1024)
>>   
>> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
>> index 393ba1437..45fc01ce7 100644
>> --- a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
>> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
>> @@ -19,11 +19,10 @@
>>   
>>   #include <errno.h>
>>   #include <stdio.h>
>> -#include <sched.h>
>>   #include <stdlib.h>
>>   #include "tst_test.h"
>>   #include "lapi/ioctl_ns.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define STACK_SIZE (1024 * 1024)
>>   
>> diff --git a/testcases/kernel/syscalls/setns/setns.h b/testcases/kernel/syscalls/setns/setns.h
>> index 46beef17f..45c759917 100644
>> --- a/testcases/kernel/syscalls/setns/setns.h
>> +++ b/testcases/kernel/syscalls/setns/setns.h
>> @@ -4,7 +4,7 @@
>>    */
>>   
>>   #include <stdio.h>
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define NS_MAX 5
>>   static int ns_types[NS_MAX];
>> diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo03.c b/testcases/kernel/syscalls/sysinfo/sysinfo03.c
>> index af7cb6421..6b8f0aef7 100644
>> --- a/testcases/kernel/syscalls/sysinfo/sysinfo03.c
>> +++ b/testcases/kernel/syscalls/sysinfo/sysinfo03.c
>> @@ -14,9 +14,9 @@
>>    */
>>   
>>   #include <sys/sysinfo.h>
>> -#include "lapi/namespaces_constants.h"
>>   #include "lapi/posix_clocks.h"
>>   #include "tst_test.h"
>> +#include "lapi/sched.h"
>>   
>>   static int offsets[] = {
>>   	10,
>> diff --git a/testcases/kernel/syscalls/timerfd/timerfd04.c b/testcases/kernel/syscalls/timerfd/timerfd04.c
>> index eb7f98d5b..b24b4874e 100644
>> --- a/testcases/kernel/syscalls/timerfd/timerfd04.c
>> +++ b/testcases/kernel/syscalls/timerfd/timerfd04.c
>> @@ -19,7 +19,7 @@
>>   #include "tst_safe_clocks.h"
>>   #include "tst_safe_timerfd.h"
>>   #include "tst_timer.h"
>> -#include "lapi/namespaces_constants.h"
>> +#include "lapi/sched.h"
>>   
>>   #define SLEEP_US 40000
>>   
>> -- 
>> 2.23.0
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
