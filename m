Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EC9C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 00:59:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74A993C9A70
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 02:59:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7471D3C9674
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 02:59:08 +0200 (CEST)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AB8ED600424
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 02:59:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1658365147; x=1689901147;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=knWQUqWCTeErLDj9bEt2+IYUGKibAcZgEFtz5z+DWZI=;
 b=aD1bTHgCd5PiA44zQ8dsKSVBsQWH1i+zKv13hZkuOxJ4n/F+U9FeQGEP
 kNJ5lXDzEkfg0mEAtSReh72lLFl8ZGHwVnYvxdwDSS3QCmKqITX+Cb6ud
 pQi9EZ3xK7cXcFmPrXm6JbP7uIFxn8zkBBNPavIWUN1qRheBAZxAu2jcm
 Oz9FEs0/bzC3qPVCwNqME4djlZMhM1earVQfPzWkGKACLJiI7WEvY5d5D
 jKXOJ3c7GgMhhkBgBneG9ynCRvUO3jZzDStXjf02yhpPiGPbM5g/CxKnn
 UASwdQfi8UHCMQMV1yk2u2waPFg5k71EMxjl7Ju6nByzZcZ/8MH5FvNXZ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="60872287"
X-IronPort-AV: E=Sophos;i="5.92,287,1650898800"; d="scan'208";a="60872287"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2022 09:59:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuzuo933qV6yX66UVPfgC9mbcO3Vjfpa4T1fe+0DAN0wez540JbOrYueYr8DK8Vqg0Czsr1UjSCpqMkacskz+tV8BiAS298tn3vQgF7OxgdU5mkqjFB5ukIDHljLo+vf4LfvlcsZDCwf0o7Fk6VcXVV6iyQ5+clk5FoZ7FCW40JytlazX3/20Ee+qfynxmVC0CfEUSg253imTtAnuhhhAbT4sLEgd6LNEZaBO4fwmfiWlWD0d0OgvPF8w031vPOLNxqGJUqMTNvfv12MlSQ6Iyprn3ARtB1BPLEhPW/K27UCv9u9qC4fmpjaI6T+uC7sY14owOuV7Z8HByrz1NtJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knWQUqWCTeErLDj9bEt2+IYUGKibAcZgEFtz5z+DWZI=;
 b=A52r0OkaGyLgWJGcKwcwnJ5Yr5mDf8HcJtq3FahauoVDDpQjbJzNTOGnhgNkmYA6o97xIPLoXwwDCvfHD5q2xPASBzek60DZxHCGzG2tMuQ0CSMPuKUvHOkJfL4lZ0n0gybdN9Tz1niSEKgs61zGEUpZh4xAYEsjGImy5C3lv8xpG5RuPBMaDMISTrWjRWLZO0XZAucNrIRX5SoZVeAevWnLrKXR1S2ZsEJVrX0KQwjaDkKe4x7gjLRu0D6FDFWj0e+58Isoc/m0m6Q3sdj0qCJckeSbXNyHrN2rmpn00nE2mGOcTlGm9SBqJfakYB91L01lpz7X6emnVaJYkwaqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB5167.jpnprd01.prod.outlook.com (2603:1096:404:12d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 00:59:02 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78%5]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 00:59:02 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: Do we have some simple way to get the current cgroup.procs path?
Thread-Index: AdiXT1u4fxhXw+J5TcO+wfpeq4Xq6QAHJHSAAMVgfwAAAf7QAACHCAMA
Date: Thu, 21 Jul 2022 00:59:02 +0000
Message-ID: <435ce78f-df1b-782d-75f2-2794a5b23f90@fujitsu.com>
References: <TY2PR01MB442719179C60B4DB6D275B5CFD889@TY2PR01MB4427.jpnprd01.prod.outlook.com>
 <CAEemH2fMfQYhfaV5_LeZCxfkCY=FKCqXc+SrZzQLVjzTf4yf8g@mail.gmail.com>
 <8e16d91c-8307-8ea4-bde7-28ef093c1205@fujitsu.com> <87tu7eivrm.fsf@suse.de>
In-Reply-To: <87tu7eivrm.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f554f2e-eb72-4f00-4b0a-08da6ab433e7
x-ms-traffictypediagnostic: TYAPR01MB5167:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mrClkNkD1rroGw8ztx+dQpn6U4ucC2JXZYdvlgTYEUbaLD/Dv5eVG4J1+zeWaAht/WMXAIgfzWtEg5Y8nW699av5bqsTp9rqutvXOCGnF4SX/cMq92M0aQI7jC8zJDZoUeiOyRbWneoSesqLvElsJMHqmED92Maa0vbTkjHaMyKPgiBtIfqkyG02We6//cnta1bjD/zGqtmsBYgvpbZ7CzWTdv4I4mrocjjYCuPYXvPZlD3FXdKMu8X37qzb2qit+PlugvyMQvO11m/OycrgiUCBVZmd4TlxdYwyF6P9VhuEplc/i77dFEWCvIp3+owi0WuZh9N7wdEDCqjJsvaSFBR1ojKQjiXoFLMeqU+FoFIugUwIPitmEMeVrrLZvp23FY99ZLqsLPAPPlvPQgBBGYukNO1os04hNXdONe7Cp270iAnTXEYdDVUa2T0sBs/jP8L3Qqh0WbDIybw9RcRwzGHt48m7S+JuZZrigeXGzH8gaF+ZH3ApF6AlO3TxGeITsuYaTslbCdc8y9Kg+xVgQdgSkWOtm7V/rP2eydA6JndNc7YtQkl6vQPr5dojGtUV6e+9qFCZVRBvhEgkalxt2nqbx9DCaCTaxnMmmPwv9fP+RgX0nRGCHk0T4En8EGkNR8kxkw9Trw6isSKLDUZBVOb826bBCjU0Z1fvtAh8Rr0cZ5U7ULwx02S36dQ1l1v4FD3LHcltxT5O/9J57wAEvShEYV1CVNGd4NNYszr/JeI4j+oSadZiKL4waBT4V9GOP5dooGcxC6UwVdEod/zpqkf6Sv6CeckNTwsqz+wJppqms+m84vy8d+dOEA8BThhMbw3/csVKEUT5ZeyXQANWEpxrlkk2/pyd3Kdoor+ScLd3dlkNb7Lr9Sjjs/My6/2kqJi5vR+oFIYKdxm1diNFExuTGg9t0bWOH0omFn9pTcA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(966005)(71200400001)(6486002)(53546011)(83380400001)(41300700001)(478600001)(2906002)(8936002)(5660300002)(6506007)(54906003)(85182001)(316002)(31696002)(31686004)(38100700002)(36756003)(38070700005)(2616005)(6916009)(86362001)(82960400001)(4326008)(8676002)(66556008)(186003)(66446008)(66946007)(66476007)(26005)(64756008)(6512007)(122000001)(91956017)(76116006)(43043002)(15583001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEVRVER1MkVWOTZmR3djL1hDMWl6MXhKeVZMdkxxeGNvYmJibDF6NGZPN1FQ?=
 =?utf-8?B?ek8xSy9xWXE2RFczYkJNMWYxdlQ3V20zc3cyVUpxZkEvbHQrNjNKRDg5cG1n?=
 =?utf-8?B?T0R6NmVwTXdzMWZicTBoZDE3VzJ2a2R1emowQjA2UjFXYWIxUTI4RzFQZEJu?=
 =?utf-8?B?NGVQY3BKNStYYXBubFdJeFhLeXFxNFg5WkM5UStiZks5aEZkTWxKNGNjRFgz?=
 =?utf-8?B?NkhtSlVOL2dhYW1pdnpTODRYS2M1aFI0WjNGa0EyME15dy9GMFBJS2VpaHZQ?=
 =?utf-8?B?MENBZHUzWjJudU5LQlVWejNLYTN6YmNzQktyQ0hqbWRpRFF6K1kxNlo5bzll?=
 =?utf-8?B?c1pianN1YUttdnJ6MEhPWTRSQzlqbFNXSUVNN1F3dzlQMHRDQlY0T2prSXh3?=
 =?utf-8?B?M0ZtSmFkeTRKSmlHdCtFWXRUMFNGY3VoZmFZMDB1bmZtbHl1K0YzY0NjMW8w?=
 =?utf-8?B?MlQrWWVYVG9td1JVZ0ZKY0M2SGxkVFNkK2I1TXpCZnB3Q2haSTh1MkRYZkt0?=
 =?utf-8?B?R1pYaVJCWW5mV3NZWUZMS1h1VjZGazNNZWlKZTJTMUkzRW1xUnhZYURZaHMr?=
 =?utf-8?B?bzIvdDE5WlRMTlFtWmtYK3FibXdIbGtaaWR5cTdqaStDRVkwb09iaEVSOElP?=
 =?utf-8?B?dzlnOE44TXErQVFMRlFSU3ZCQm94UTFBVXNaVTgwYk95TWp2WkRpc1dTZ3F3?=
 =?utf-8?B?aTlYSnlSaG80eFZFNGlYTzhIc3JPbDFHZDE5UGxUdGNHbHl4Sm5IYkRyWlFv?=
 =?utf-8?B?QnVyU3g0ejJsZkNuOGc4aElRQlh6WHhESThWYXV6M05aZE1xdkY4ZUs5RVl4?=
 =?utf-8?B?aEFlUlVGL1JNMWF4cFV1YmpLYlN0b2h5b2QrN2dzVEs2TmJFZ3RUUk8rN2hC?=
 =?utf-8?B?U3VKVHdYdVJmWW9EajBWU1VPOWNnRlZoTXNlOEtFSXVKY0VlQmhvOXdkYktP?=
 =?utf-8?B?WkdKb1ZJTWJDMCt6NWY3alZsdHprMVNUZ09WaThRZHRRRnBrN2w1VURZRGhz?=
 =?utf-8?B?M0hMM29tdmwvTzRrdVNHMm9ncmpsZG5Qc0Y4VWczOUZEZ201YTF6THVjSUdE?=
 =?utf-8?B?UzhlTWwxcUs5NnZpNzJRa1ozdUszS0ljTXk3ZWZ2R0RzdmticWlaK3BoT0NW?=
 =?utf-8?B?ZnM1RndFSW1qWWFqMThpQzMvM3lsQlNnTzU3czJ4OEI1Y0NScUNvL3RoZENH?=
 =?utf-8?B?c09qUmIwd0ZTRlJkSEhFQzNtemVnQjdady9kYUdEYm1ZQ1drY3Z2c0lSOHF0?=
 =?utf-8?B?Mktianl5T0FNUXh2NWRTWEFpRlNCQnJXSmxMRGtxNDVZc1ZRNWo5L2lMVzdG?=
 =?utf-8?B?N2pMelJHdDZUUWl2NVhGeTdYaEJ4clluckYzeWp3VlE3L00zRU1KczdHRjVq?=
 =?utf-8?B?K2RPazNmSHNHbi9xM0Jmc1FmMWo1bHIvUGc0U1RmSmZ6SC9ucUhMQUJCVGM3?=
 =?utf-8?B?a1pQdTE5eXVkMXVWRVVUT0szWW03UWZ3Lzg5ZXJvQm5UaDNHSFc0RFhKNHlk?=
 =?utf-8?B?UjFaWk5IVzZOSkpwWklBK0xUSUJJNlNOTUZSYUhJYjc4RERWNkNCVnpzQ1N4?=
 =?utf-8?B?ZlN0cUU1NFZieDFob2N6Q1Arekl1YTFPZGxJSmtTbUNYVWc0Z0ZiRHptcTZX?=
 =?utf-8?B?VzJLOTJ1TUxFZHFWWldOV2ZUWFdMd040U0tZelI4dVBkQ2JkdDZCVkpUWUg0?=
 =?utf-8?B?dlVMdkQ0OHliamM4c0JidGVZTTIyYjFHNlZ4NHlLUnFOTmh5akZOQUM0Mzdu?=
 =?utf-8?B?NS82TVF4cVpjaUlWU3VHRVFzejRLYWJlb0lLdG1DU3crbjRXamVXbmMxd3JH?=
 =?utf-8?B?eTR1YmU3WjFyUEpLVGtSelpLbVZFNDBTSE5tU29wQkhPd3RzeUhTNW5qdDVk?=
 =?utf-8?B?UEZlZjd3RW03NkJkYzdVQTM2Z0o0QUs1cFFRaFFjRCtKRENHWHpyM0liRTJw?=
 =?utf-8?B?eHYvWkpobnczNkRGTG1tN05FRUJ6SlF4ZHI1RVl4ZDlzTzA3aE9IWFB1U1dC?=
 =?utf-8?B?U2ZzV2I2T0NxS2dtRkNGS1E3UERWMzJzU01iZnRIS0hrVWdMTFhpcDVLdHhZ?=
 =?utf-8?B?MHFFR0x2K2YxVjJLeFUvT0NZdkdEL29jMEtISWVyNGl0VjBJV2pWQTdOemVT?=
 =?utf-8?B?NFJ6UDl6YnNHQmtwL0JDZUxlUm5ISFpVWkswVkNTSzAyam5nQnVRN2YzNVpZ?=
 =?utf-8?B?ZVE9PQ==?=
Content-ID: <00B1B40AC8707E42BB36B16D2039321F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f554f2e-eb72-4f00-4b0a-08da6ab433e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 00:59:02.3175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+unOpGjumZCTWHSGKBDvIHMT7OJ+rg2on7F2oZWBw0snXm7fi6MTmobqUElGc/KYeWKBHxXDcquOie6DD/ZDQ6EUWkYjSI5UMJTV0Wbq0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5167
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Do we have some simple way to get the current
 cgroup.procs path?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgIFJpY2hhcmQNCj4gSGVsbG8sDQo+IA0KPiAieHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbSIg
PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+IHdyaXRlczoNCj4gDQo+PiBIaSBMaQ0KPj4+IEhp
IFh1LA0KPj4+DQo+Pj4gT24gVGh1LCBKdWwgMTQsIDIwMjIgYXQgMjowMiBQTSB4dXlhbmcyMDE4
Lmp5QGZ1aml0c3UuY29tDQo+Pj4gPG1haWx0bzp4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPiA8
eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbQ0KPj4+IDxtYWlsdG86eHV5YW5nMjAxOC5qeUBmdWpp
dHN1LmNvbT4+IHdyb3RlOg0KPj4+DQo+Pj4gICAgICBIaSBSaWNoYXJkLCBMSQ0KPj4+DQo+Pj4g
ICAgICBJIGFtIHdyaXR0aW5nIGEgc2ltcGxlIHJlZ3Jlc3Npb24gdGVzdFsxXXRoYXQgcmVmZXIg
dG8ga2VybmVsDQo+Pj4gICAgICBzZWxmdGVzdCBjZ3JvdXAgdGVzdF9jb3JlWzJdLiBJIG1heSBu
YW1lIGl0IGFzIG1lbWNvbnRyb2wwNS5jLg0KPj4+DQo+Pj4gICAgICBJdCB0ZXN0cyBjZ3JvdXAg
bWlncmF0aW9uIHBlcm1pc3Npb24gY2hlY2sgc2hvdWxkIGJlIHBlcmZvcm1lZCBiYXNlZA0KPj4+
ICAgICAgb24gdGhlIGNyZWRlbnRpYWxzIGF0IHRoZSB0aW1lIG9mIG9wZW4gaW5zdGVhZCBvZiB3
cml0ZS4NCj4+Pg0KPj4+ICAgICAgSSBoYXZlIHVzZWQgbHRwIGNncm91cCBmcmFtZXdvcmssIGJ1
dCBsdHAgY2dyb3VwIG9ubHkgdXNlDQo+Pj4gICAgICBTQUZFX0NHUk9VUF9QUklOVEYgdG8gd3Jp
dGUgdmFsdWUuDQo+Pj4NCj4+PiAgICAgIEhvdyBjYW4gZ2V0IHRoZSBjZ3JvdXAgcm9vdF9kaXIg
bHRwX2RpciBwYXRoPyBTbyBJIGNhbiBvcGVuIHRoaXMgZmQNCj4+PiAgICAgIGFuZCBjaGFuZ2Uv
c2F2ZSBlZmZlY3RpdmUgdWlkIGJldHdlZW4gb3BlbiBhbmQgd3JpdGU/DQo+Pj4NCj4+PiBOb3Qg
c3VyZSBpZiBJIGZ1bGx5IHVuZGVyc3RhbmQgeW91ciByZXF1aXJlbWVudHMuDQo+Pj4gQ2FuIHdl
IGFjaGlldmXCoHRoaXMgdGVzdCBieSBjcmVhdGluZyBhIHR3by1sYXllcsKgc3ViZGlyZWN0b3J5
Pw0KPj4NCj4+IEkgdGhpbmsgeWVzLg0KPiANCj4gSSB0aGluayB5b3UgbXVzdCBoYXZlIG11bHRp
cGxlIGxheWVycy4gT3RoZXJ3aXNlIHlvdSBjb3VsZCBicmVhayBvdGhlcg0KPiB0ZXN0cyBydW5u
aW5nIGluIHBhcmFsbGVsLg0KPiANCj4+DQo+Pj4NCj4+PiBEb2VzIG9ubHkgdGhlIHJvb3QvbHRw
X2RpciBtYW5kYXRvcnkgZm9yIGNvbXBsZXRpbmfCoHlvdXIgdGVzdD8NCj4+DQo+PiBJdCBhbHNv
IG5lZWQgZ2V0dGlkIHN1YmRpcmVjdG9yeSBhbmQgY2dyb3VwIG5hbWUuDQo+IA0KPiBZb3UgY291
bGQgY3JlYXRlIGFuIGFjY2Vzc29yIGZ1bmN0aW9uIGluIHRoZSBsaWJyYXJ5IHRvIGdldCBkaXJf
ZmQgZnJvbQ0KPiBjZ3JvdXBfZGlyLg0KPiANCj4gVGhpcyBpcyBjb21wbGljYXRlZCBieSBWMSBD
R3Mgd2hlcmUgYSB0c3RfY2dfZ3JvdXAgY2FuIGhhdmUgbXVsdGlwbGUNCj4gc3RydWN0IGNncm91
cF9kaXIncy4gVGhpcyBpc24ndCBhIHByb2JsZW0gZm9yIHNlbGZ0ZXN0cyBiZWNhdXNlIHRoZXkN
Cj4gb25seSBzdXBwb3J0IFYyLCBidXQgaXQgd291bGQgYmUgbmljZSB0byBtYWtlIGFzIG1hbnkg
dGVzdHMgYXMgcG9zc2libGUNCj4gd29yayB3aXRoIFYxLg0KPiANCg0KWWVzLCB0aGlzIGJ1ZyBl
eGlzdHMgb24gYm90aCB2MSBhbmQgdjIuDQoNCj4gVGhlIGVhc2llc3Qgc29sdXRpb24gSSBjYW4g
dGhpbmsgb2YgaXMgdG8gd3JpdGUgYSBsaWJyYXJ5IGZ1bmN0aW9uIGxpa2UNCj4gU0FGRV9DR19H
Uk9VUF9FQUNIX0RJUih2b2lkICgqY29uc3QgZm5fcHRyKShpbnQgZGlyX2ZkKSkgd2hpY2ggdGFr
ZXMgYQ0KPiBjb25zdCBmdW5jdGlvbiBwb2ludGVyIGFuZCBleGVjdXRlcyBpdCB3aXRoIHRoZSBG
RCBvZiBlYWNoDQo+IGRpcmVjdG9yeS4gVGhlbiB5b3UgY2FuIHVzZSB0aGUgaW50ZXJuYWwgZm9y
X2VhY2hfZGlyIG1hY3JvIGxpa2UNCj4gU0FGRV9DR1JPVVBfUFJJTlRGLg0KPiANCg0KVGhhbmtz
LCBJIHdpbGwgdHJ5IHRoaXMuDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KPj4+IElmIHllcywg
SSB0aGluayB0c3RfY2dfcHJpbnRfY29uZmlnKCkgbWF5YmUgZml0cyB5b3VyIHB1cnBvc2UsDQo+
Pj4gYnV0IHRoYXQgd291bGQgbmVlZCBhZGRpdGlvbmFsIGZ1bmN0aW9uIGhlbHAgZXh0cmFjdGlu
ZyB0aGF0Lg0KPj4+DQo+Pj4gVGFrZSBhIHJlZmVyZW5jZSB0byBzZWUgaG93IEx1a2UgZ2V0cyB0
aGUgcm9vdCBwYXRoIChpbiBzaGVsbCk6DQo+Pj4gaHR0cHM6Ly9saXN0cy5saW51eC5pdC9waXBl
cm1haWwvbHRwLzIwMjItQXByaWwvMDI4NzcyLmh0bWwNCj4+PiA8aHR0cHM6Ly9saXN0cy5saW51
eC5pdC9waXBlcm1haWwvbHRwLzIwMjItQXByaWwvMDI4NzcyLmh0bWw+DQo+Pg0KPj4gVGhhbmtz
LCBJIHByZWZlciB0byB1c2UgYyBhcGkgYW5kIHdpbGwgdGhpbmsgYWJvdXQgaXQgY29udGludWVs
eS4NCj4+DQo+PiBCZXN0IFJlZ2FyZHMNCj4+IFlhbmcgWHUNCj4+Pg0KPj4+DQo+Pj4gLS0gDQo+
Pj4gUmVnYXJkcywNCj4+PiBMaSBXYW5nDQo+IA0KPiAKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
