Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42B8C43334
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 01:29:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 318303C0775
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 03:29:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C869C3C0775
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 03:29:02 +0200 (CEST)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 26AC1100094B
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 03:29:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657589341; x=1689125341;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=IpINENF8umu82bgpmtlIYXW3QBC+KHE4febrmUD/2TQ=;
 b=jnCHWdqhbdMtZTdKE6fZdhr4J55Avf4zCtB4OSh7lPIneDgo/bj1KBi+
 OIQ4UdrLk/jELJ22JVq1zzHS9uhgvE0Dww3T1touv1qDBPnnyk97eLnyx
 7tPqG69oOoCnkn2kGNj9+jj383ClP2Q9jTGQmL3WiYRjT7u+optPHYZjB
 NBfK31xrnvvVEc1oyiou9UUQ/iW7zV8Ey55axOSC7+yt8IHlA5lmfbMoR
 FSxcl3jnciVeEEEPlzLY/MQkwjVbJ9lvGoTzY9aWBkzrMXhBcuLVT6rOP
 mgQoEuM2gnbOHglmiZl/yz686E+2Kgmbb4VuADP2vLk8ht9cs/ycjVslN w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="60119941"
X-IronPort-AV: E=Sophos;i="5.92,264,1650898800"; d="scan'208";a="60119941"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2022 10:28:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4PsqHIgWk61M6dGFPNwduRTcYBcQYdSzjfygM8nBUrgTNCtjxt5Le1atltAAdfO2KHkRYJ9AebCUMjDAWZB0OODiA1GPekXRx3YjigBYGllk890kdTL9ZC9QD4LSGt9zv2Z+Wq887MkXAA9sxtCd0wq4R5D4UUhLWMbydRVOEThJmJeyE1sEIv4jhKaNBgB6vgHJ6sGaRcyLhB1GEfRGnDGc4pBBT1h3cznRUdaOJUn9NeJy5vWGZjNdNlKOZaCoy9Hr3mrYVz84XK3sOz4VFGkFJGtSsQiPD6982tqmROjuQX2VuUNlgeqJdglyCFGlorZJ0AMS+DotXP5QQip9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpINENF8umu82bgpmtlIYXW3QBC+KHE4febrmUD/2TQ=;
 b=HMlMx02btRuv1ryNwEKC50hum4pXgVqT4U4xt+Rx/zJ9alwSV4FC0giQbQiYXoRCCzJvH5biReueLUriT9ft4jhwVsf0bFtXLHujDXgv8+IKwzVILiaQtuAmvwxDBKpaKyEqD7zpRqf2+TwOAKWWtm+oRJKeVA+L+l/lo1CSTJVMVoBKfJYv602UvN4th0Y4VLF9r/Tbcw5XEy74221ShwjVIMmDiINhF5qF//Tak5RBpClukrklkNPz0knYtvu720bFnINfrPxBkD9ZJlYz4agYaFtMeGOsUmD2izN5SPNHfoG2Sd/EiKrHSO6rw20mYHbR36mD/ZYP6Lk9FhRvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpINENF8umu82bgpmtlIYXW3QBC+KHE4febrmUD/2TQ=;
 b=MyHLmunaqs0E4QgbClY2oIhlDeAe3XhC+69JWSwtxty3z2MPEoytyXfQ9428BQ93ZtvwwFpRHkJBGWYH40j3GGyIETvNbsxEnWMZgIDQ0FyGClIQgR9y0uaU8EtTkIn6X8//JO+m519EymqYh5Z4/2gef5kVulsCQzQUa/6XwrU=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB10089.jpnprd01.prod.outlook.com (2603:1096:604:1e7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Tue, 12 Jul
 2022 01:28:55 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 01:28:54 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH] security/dirtyc0w: fix typo
Thread-Index: AQHYkeZPF3Csev4c8Eivyw7W40Zlv6149vcAgAETq4A=
Date: Tue, 12 Jul 2022 01:28:54 +0000
Message-ID: <f7436f42-0dba-b1b8-9ba3-c6089684784d@fujitsu.com>
References: <1657190760-2272-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87o7xwneq7.fsf@suse.de>
In-Reply-To: <87o7xwneq7.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a831d8a-570a-4f72-0fba-08da63a5e28b
x-ms-traffictypediagnostic: OS3PR01MB10089:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HFFXvUQjwwSsAQ1BF5v4qfEsuewHSpzKJKnfSTQYrukmtqGwNFFTHZuuTZUCm5qOAsT4N7xzbgQYg9otICHkdRPKjCQ3uw87/+TFSLZJaXQCtsEjLn1aKYry4XnnV58AASZEvEZpzTMCbku8qsKWxc49eegAn0eqhBSRFNI4puLxqBi6oJQz8BwevNlyXYQmpaXr5TPEHw/s4gFFtERzErwxs2tFJFCrB4OS3muGdtp15CktQcKy1jDF+z7MVjoopHzIb8WTIRxXjckHEYNGxfbgyUOyVLW5153qpjNF3T6jrKJqiVWGc1YKf0MQNb67DKslabwFmLO6B11UH77wLryIPdjzsWnl9G5ofEBqjhJzG32S2xJ/avTuYkSFFLqzYvDhOjXFJElqygxEcOg41DlB+cKNigZ60+/bXkS8lt7YYWduoXs0wNjXQ5KZ6LrxZh4p2zvaq0IOivPma2x6rk2uNhoH8ERGHqyqYqDSyz3j6KOnjjGVtQe/uwbYRSku9/ujhUBgZdjyjLYV0hfBm/eXmqyiaH0OZnSWBMkf0EYbo4FtlnpvAZUQeeZhWxduTkYRdUmFFOu3yvDZCSiFWIqxmRT1a384APif0pgHxHLa9V+1WkvpHxSO/s3QOvgYlgiyVyJyfQdfgmuLFPouW6wESK8Agc4OIO6SIQGhIdVs/Yq1iL203Dozxvsm+oEmkCbkI7xPlFQFzkgSJU7DJ5KuQ3gefH6PxwgMRONelNOdgSRUMT3upzzWdP8kq9RtyhXtyRpiVtIxaZzma/Kaflr7YHYoVbjiUw5w49f6SMycezLrgwfAJ5hTEqFBSLIIuwfR0TjypoQyvDISwFl7jfqUnrXYeNd0I2Crxgee/+c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(38100700002)(186003)(122000001)(83380400001)(76116006)(31686004)(5660300002)(85182001)(91956017)(71200400001)(36756003)(4326008)(66556008)(316002)(6916009)(82960400001)(66946007)(66476007)(64756008)(8676002)(31696002)(6512007)(15650500001)(86362001)(478600001)(8936002)(41300700001)(2616005)(6486002)(26005)(38070700005)(66446008)(2906002)(6506007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWU5NEtqS0E1M2YrQVVMVjBIOHpwV21ab3I3K0RrUmVTaW1NZWpYcmV2ckNZ?=
 =?utf-8?B?Y0hZdzl4Q1o2M01OZ1pWbkRKSjlUd2RBMWRiVlJBK2pkdUh0TzNKYWdjQ21W?=
 =?utf-8?B?eGhveHRTNWswb1Jvb0pETm1qQVpla1VHZWxDaDIwYnNjcmJ2QzNKYTBTbmk2?=
 =?utf-8?B?ZTc3d1laU3BvS0l4VVY0Y0RnZHRvSFFKbEVZTC9yRDdjNjJ5b2tGa2xlczNO?=
 =?utf-8?B?Umhad0J0YkR4TW9KckxCaVFQanlSZmw4YW5wdUlWcVBnMFBqbEx6MU9MQjE5?=
 =?utf-8?B?TGF0TkNtNERoV1VmdkkzUk9rdjlCbFpkRVYxQWg2Y1pRYUdYN0FNUENGVjM2?=
 =?utf-8?B?dlJacmJFY2RBREJtSERNRGJyU0JyNHpCcnhZZjV6WU00ak00OGVkRVg1NTIr?=
 =?utf-8?B?TjVxYnJWYWsybkVCK2p3REdNcWVwNmNpeVkweU9mZTUzY09ZWWlqaGM1R2FE?=
 =?utf-8?B?WGxHZ0UxQzhYMkE4ZXdnUHRTTnFYbXZ3K09BUlprbVAxL2pYVVRrZjgrZktj?=
 =?utf-8?B?WUdLbnBqTmJQSm5SVkFoU1pnaGdBZGtDdDZnRSt1SjZwbHhwNjlGRWZ1MlJB?=
 =?utf-8?B?QmlWdmFCQmxuRG5hWlk4V0dPbHRPMW5GNVRSVFhRSGVWNHBMYkV1ZE9Jd2ZF?=
 =?utf-8?B?REgvY0VGbEhpTHVmTG5RUkxXdFZoTE80QVRMbUY4SXdKaGZzc3hINS9TREJT?=
 =?utf-8?B?TVRkcnByZTR4ZG9welF1cituUWV5QnQ5NUlrU1RqOEttTGJsNHVYYStmZ2Ra?=
 =?utf-8?B?azFqZXUrWjdMZVltRUMwUElqNmdtekYrK3RRK2N2ci9PeHpqZ280cUNYZENE?=
 =?utf-8?B?TTdHQkFwM2Y2Qy8yQkQ1ay80c29VTVV4SmtRUyszZ0hob2Rsa2lnZzdib1Zv?=
 =?utf-8?B?MzgxdXhhL0ZZMVh3QkJCeDVia2dpb1Njd2lQVlJaN2Z2bjNhaldoemg4M1JX?=
 =?utf-8?B?RWVML1FadDdXM2hsTXkxRGVNeGowWUFaOU5adjY0Z0swMkxyV2FUY1dzV2Za?=
 =?utf-8?B?OG5BdjVLOWthOE9xWUtvdjBWV2VjWWdlQm9ldDhlV1dDUVdlZDgvOEhBcE5j?=
 =?utf-8?B?Q3l3ejZCOEM4c21kYVhLeHhaUHhvdW1XSTF3dzEvMm9TSXVVK1pvOXd4TUdV?=
 =?utf-8?B?WHRCb0lISWhyVnBNMGFxNnpPWlJ5dU9vV2l3Y3NPMnVmMDFQSUZyS2k1QmdI?=
 =?utf-8?B?SkdoNm1STDV4S2pCUkJBOGFGMmtNZys0L1h6UGE3Vm9HNDVja29WNFBzL1Y3?=
 =?utf-8?B?bHoxOWRVM3JzMGVmeWM1Vm1OZHZ6Q254Q0pKcmx5cE04Ykk0V2pnR1p4OERr?=
 =?utf-8?B?Y1hvTHZJR0lpdEoycnpoKy8xQ0pVaVZERkV4K0VwaFE5eEs5dktyRmptWG9M?=
 =?utf-8?B?dUtqa1VTQ2ZiNnVpZTRnTlVNa0wzcE1GVHRGNllpK1ltTGdLdFVnS0NVVStD?=
 =?utf-8?B?dnFqSE1ERWhpamZtd2p3dXpPYXpUTGgrbmk4eTJQV0VxZTZSbWdEUU1JZk5h?=
 =?utf-8?B?N3BMdDNOUjVGWjRhU3BQZm1ZRlBKYk5uNUkxb0FxaDhkalVkdm9OSVVwWjFi?=
 =?utf-8?B?djFnNTd2d3VrcTNabTZTUkRERlRRcDF6L29zamdhQkIrS1RidlRRR1RqSXBm?=
 =?utf-8?B?QWkvcVRZT2p0UFgxVlJENE85T0tDOWFQc1k1U3RheTdEcVBneUVWeWp0aDZt?=
 =?utf-8?B?cHFBYTEzTUluN2pFVGkxSXNYeGMyR1dYbDliZTVXUlJpV2huOEoyS09MWFpM?=
 =?utf-8?B?VEJNWHA5aEN5SDhkU1JRUlVyNEt0MG5OaTBkTkE2MEtpR3VnVEl0SURoNW9u?=
 =?utf-8?B?ZHlrQXJ4dVB4QzRnZnh1ZzRSenBzSmdkY0lzWGRYRXV5Rk9tQjBsdGVyZ2tL?=
 =?utf-8?B?VXkxS3JzQUFwaXk3emE1c2Y2NUh1VjJnWTFFcytqNTVHZzhza05XUnNxYWJr?=
 =?utf-8?B?dEdDdUFHTjRJSW10c0RiTXRUamZ5eTFMblU4alNnNFRLem5rdmUxaWFaUkc0?=
 =?utf-8?B?ZmxhalhMQlpjdWRCcm5TQ3JaVmZRdGZOOUxxQVBrRHlDNllrR3A3MXhoSmVm?=
 =?utf-8?B?NmZUbmJobW1tRDJ2c0dKTHpocHpNcTZydmw1Q3dNdVhNYzhaOWowS0l1dXE5?=
 =?utf-8?B?UEFZNzB3M2REcW5IQUo4K0FUZDBHRHMwNk1EalJQU1hvZHIydW9kT0FoWUI1?=
 =?utf-8?B?NlE9PQ==?=
Content-ID: <E6F6B7D09EBBAB499678F0C87B22FF6F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a831d8a-570a-4f72-0fba-08da63a5e28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 01:28:54.7083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U2fjqlChcSuFk4iAw7ZDLZFhe/OCddCNC8yctz9oBi4Hl7QP61U4M5Gaxd9nQGJQLE5Jyi60Uxnr5Fv0WJoeUhvgof/GSYhLqqwv66PHCqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10089
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] security/dirtyc0w: fix typo
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

Hi Richard
> Hello,
> 
> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
> 
>> s/dirtyc0w/dirtycow/
> 
> I assume it's l33t speak, not a typo. Did the spelling cause a problem?

I don't meet any problem. Just don't understand why here use dirtyc0w. 
Now, I see.


Best Regards
Yang Xu
> 
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   runtest/cve                                                 | 2 +-
>>   runtest/syscalls                                            | 2 +-
>>   testcases/kernel/security/dirtyc0w/.gitignore               | 2 --
>>   testcases/kernel/security/dirtycow/.gitignore               | 2 ++
>>   testcases/kernel/security/{dirtyc0w => dirtycow}/Makefile   | 2 +-
>>   .../security/{dirtyc0w/dirtyc0w.c => dirtycow/dirtycow.c}   | 6 +++---
>>   .../dirtyc0w_child.c => dirtycow/dirtycow_child.c}          | 0
>>   7 files changed, 8 insertions(+), 8 deletions(-)
>>   delete mode 100644 testcases/kernel/security/dirtyc0w/.gitignore
>>   create mode 100644 testcases/kernel/security/dirtycow/.gitignore
>>   rename testcases/kernel/security/{dirtyc0w => dirtycow}/Makefile (86%)
>>   rename testcases/kernel/security/{dirtyc0w/dirtyc0w.c => dirtycow/dirtycow.c} (94%)
>>   rename testcases/kernel/security/{dirtyc0w/dirtyc0w_child.c => dirtycow/dirtycow_child.c} (100%)
>>
>> diff --git a/runtest/cve b/runtest/cve
>> index 9ab6dc282..3727f58c3 100644
>> --- a/runtest/cve
>> +++ b/runtest/cve
>> @@ -9,7 +9,7 @@ cve-2015-7550 keyctl02
>>   cve-2016-4470 keyctl01.sh
>>   cve-2015-3290 cve-2015-3290
>>   cve-2016-4997 setsockopt03
>> -cve-2016-5195 dirtyc0w
>> +cve-2016-5195 dirtycow
>>   cve-2016-7042 cve-2016-7042
>>   cve-2016-7117 cve-2016-7117
>>   cve-2016-8655 setsockopt06
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index efef18136..111ef6f90 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1034,7 +1034,7 @@ process_vm_writev01 process_vm01 -w
>>   process_vm_writev02 process_vm_writev02
>>   
>>   prot_hsymlinks prot_hsymlinks
>> -dirtyc0w dirtyc0w
>> +dirtycow dirtycow
>>   dirtypipe dirtypipe
>>   
>>   pselect01 pselect01
>> diff --git a/testcases/kernel/security/dirtyc0w/.gitignore b/testcases/kernel/security/dirtyc0w/.gitignore
>> deleted file mode 100644
>> index 7700d91a3..000000000
>> --- a/testcases/kernel/security/dirtyc0w/.gitignore
>> +++ /dev/null
>> @@ -1,2 +0,0 @@
>> -dirtyc0w
>> -dirtyc0w_child
>> diff --git a/testcases/kernel/security/dirtycow/.gitignore b/testcases/kernel/security/dirtycow/.gitignore
>> new file mode 100644
>> index 000000000..ad36ce53c
>> --- /dev/null
>> +++ b/testcases/kernel/security/dirtycow/.gitignore
>> @@ -0,0 +1,2 @@
>> +dirtycow
>> +dirtycow_child
>> diff --git a/testcases/kernel/security/dirtyc0w/Makefile b/testcases/kernel/security/dirtycow/Makefile
>> similarity index 86%
>> rename from testcases/kernel/security/dirtyc0w/Makefile
>> rename to testcases/kernel/security/dirtycow/Makefile
>> index bf26d9eb6..07759a0e3 100644
>> --- a/testcases/kernel/security/dirtyc0w/Makefile
>> +++ b/testcases/kernel/security/dirtycow/Makefile
>> @@ -4,5 +4,5 @@
>>   top_srcdir		?= ../../../..
>>   
>>   include $(top_srcdir)/include/mk/testcases.mk
>> -dirtyc0w_child: CFLAGS+=-pthread
>> +dirtycow_child: CFLAGS+=-pthread
>>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtycow/dirtycow.c
>> similarity index 94%
>> rename from testcases/kernel/security/dirtyc0w/dirtyc0w.c
>> rename to testcases/kernel/security/dirtycow/dirtycow.c
>> index 7924285a7..881e376c5 100644
>> --- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
>> +++ b/testcases/kernel/security/dirtycow/dirtycow.c
>> @@ -55,7 +55,7 @@ static void setup(void)
>>   	nobody_gid = pw->pw_gid;
>>   }
>>   
>> -void dirtyc0w_test(void)
>> +void dirtycow_test(void)
>>   {
>>   	int i, fd, pid, fail = 0;
>>   	char c;
>> @@ -70,7 +70,7 @@ void dirtyc0w_test(void)
>>   	if (!pid) {
>>   		SAFE_SETGID(nobody_gid);
>>   		SAFE_SETUID(nobody_uid);
>> -		SAFE_EXECLP("dirtyc0w_child", "dirtyc0w_child", NULL);
>> +		SAFE_EXECLP("dirtycow_child", "dirtycow_child", NULL);
>>   	}
>>   
>>   	TST_CHECKPOINT_WAIT(0);
>> @@ -100,7 +100,7 @@ static struct tst_test test = {
>>   	.forks_child = 1,
>>   	.needs_root = 1,
>>   	.setup = setup,
>> -	.test_all = dirtyc0w_test,
>> +	.test_all = dirtycow_test,
>>   	.tags = (const struct tst_tag[]) {
>>   		{"linux-git", "4ceb5db9757a"},
>>   		{"linux-git", "19be0eaffa3a"},
>> diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c b/testcases/kernel/security/dirtycow/dirtycow_child.c
>> similarity index 100%
>> rename from testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
>> rename to testcases/kernel/security/dirtycow/dirtycow_child.c
>> -- 
>> 2.27.0
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
