Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EC1C43334
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 13:37:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D765B3CA4DF
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 15:37:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02C9C3CA43B
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 15:36:50 +0200 (CEST)
Received: from GCC02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3gcc02lp2103.outbound.protection.outlook.com [104.47.65.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 298B71400257
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 15:36:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL3hpqUIGGgdTRXiZ/adeS9fSG6OvwJUWDve++c+x7FIzjSK1ialz4s+I6pz/HvsHjOIXJyjsK5LR8KDq4O5To1bW2IeOLTrC/aUG/wE9sJfk+ZkunmHyhomKN5GRobgpMoZkSf5ucvWfVUFdFjO8IkkNNe+LClNwYwVWpRRtgla7xKQXEQKIXpIR/sTvdMAcj0u0pkfZ1StvvzLQ7dwR/IOdRM9Q/EWlwPsAred4PumJmJUnp7xlicC8z0whJTU4BHnOaBvEwru5tkhISqPnCvAd3tan9Q5CGvNJ2kDTLsTQBd/YktV6/KmdUGMip6D1ycBiSdzV3ZIoHseDwZfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ0I55rVbHkny/tVDf6rMHyA+J4oWjNlkcUl/vBYPh4=;
 b=Lm0nKRkWcIvc09kjcMyVgAMrlwYmlCxFiFDrmT7j1ZavpmgZwW1qPir48dPQSgVubN1DyChJs8QPR/8m1rvV+hgJ64Gupt3idZ5H4Z7RToQzMGDMwjV0CcGEtT7xiQFCj125Ukkw8Pjyv2dE65vEpTreQQnjLqhZO7g9OON1cl2lA2IWPFMBsKdtJjiP78GJSysuVi30uJF0q4Wj/xYHfk9cWwGtDiTR1zGAxScwmo8cUhZwSufUeSsyt6A0VkZcx5BV6geTyCKMLC4cXiZzS8Tbyxg1jASeqMxFf5XJ3qgOgXC5LO0/u0DxXwtBYKroY0q+MjcKmEIqO+SRcSUBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nasa.gov; dmarc=pass action=none header.from=nasa.gov;
 dkim=pass header.d=nasa.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.gov; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ0I55rVbHkny/tVDf6rMHyA+J4oWjNlkcUl/vBYPh4=;
 b=allbeWtqM7+ZgfI8xj260AQUBwLSzK4h0sAyNol9MPDoWeUfVCfXnVA5CxSfPW5amTTtZPR7Su5ED9nemBIB3AqZ+rFXamxZPwv+Sd0C8xQg0C9cPKZS0uTrHbjiqJNLWKwkqKzGv1N/z+ANvbqZe/eGqW71sytXRn/9Ce6W3nU=
Received: from PH0PR09MB8537.namprd09.prod.outlook.com (2603:10b6:510:65::9)
 by SA0PR09MB7132.namprd09.prod.outlook.com (2603:10b6:806:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 13:36:45 +0000
Received: from PH0PR09MB8537.namprd09.prod.outlook.com
 ([fe80::68ed:7941:f430:60f0]) by PH0PR09MB8537.namprd09.prod.outlook.com
 ([fe80::68ed:7941:f430:60f0%7]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 13:36:45 +0000
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Thread-Topic: [EXTERNAL] Re: [LTP] Inquiry: Country of Origin for LCOV Version
 1.x
Thread-Index: AQHYks+mtIBkBo8Dm0GSu+41iFudsK10eeDg
Date: Fri, 8 Jul 2022 13:36:44 +0000
Message-ID: <PH0PR09MB85378F84BF1FD5F84C18ACD3D5829@PH0PR09MB8537.namprd09.prod.outlook.com>
References: <PH0PR09MB8537C12911766525158A7828D5BD9@PH0PR09MB8537.namprd09.prod.outlook.com>
 <YsMpmLENCE42TgnA@yuki> <475e984d-fc17-1632-6f1a-9ef2eb9442cd@linux.ibm.com>
In-Reply-To: <475e984d-fc17-1632-6f1a-9ef2eb9442cd@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nasa.gov;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ee36809-1036-4ad7-9288-08da60e6e656
x-ms-traffictypediagnostic: SA0PR09MB7132:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FIlORD4RhtDceyhdbVlqPLhRlTlGYzxzIzciyOiUTNlb4Q2T/Yjm7SvYwdIlBqTZeSg6SUhwJJeC05JEtt/5hafs6XOzVGykWPS9bx1/laZaHwvO9ixU38Gbwx5CSSk6TYk547EpF0P1YCBQvMmSZpJ4LxRunN7AiMKqtncYxLdRmRUTYHNeC/4ECP0raOeyO6HUu/9BErvVAQmCeme/8oNGAOZ8kRsCCGJRUvQwCg1xIfzsI+6HqtsfqFbgCJv7ra0O8o48qJMr2M+QM7J08bIQZHzm1IJADZb5qMtb/NmXeZjzG1WAZ8DoeROtceKeCvplrqTzoOYhL7IN18t19erCsjW1o/k7JHGq/w54fUuu5ASmdsiv/pvsKfPHU7Enxt+2vJRXAGOwYJUfk3V6whRG1OC+JJTPNNsprGOlqFIfohGjZoCkhjQpIwUjt1jTtvlTPL9qdGfcS1ICcW5+DLnXLsh8KhJaLhH2CNhkw+1PXoFWseKSvovryRAF6uJ7w4dLtIlqF8mefJBBW8osP90amzNNiq3sgaaIlLFRtFGJ63WKJ/M5QGH3KWbUlnr6cnyblNHq75LXiQx6NCeejbJYE/kO6+S0c1miszn1Pd125cJLbsk81hgnaCKdyhujL8jQPidp4XLVmWzsOsjaBcxDcgG4rCWVLtVAm2bHalnvurqUy3GSXhPOCCQ4kpsMy+BZGsRivHgrkN19VUIgDwhbbmKLMNPsL8Y3TznrDXIHCT0V2VSxx0ROHP1nAlAHfJm/7DY/QP/LQZFptx+c655UHL9zHo+XWQVNPI3JOeF8KOqw2wMElUs/bvl+/aalB0/iYth0n/9nIyH0f4/bzsNaHn1sxzbk+OW4uMK7XC8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR09MB8537.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(33656002)(2906002)(38100700002)(66574015)(186003)(5660300002)(122000001)(52536014)(55016003)(8936002)(38070700005)(966005)(64756008)(8676002)(66946007)(66556008)(66446008)(76116006)(83380400001)(4326008)(66476007)(86362001)(45080400002)(6916009)(71200400001)(54906003)(53546011)(26005)(498600001)(9686003)(7696005)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RCtwamE1eGRFYVdrN3BUNGZQcTdDWTFRV2V2TEFXdXdCVWZ2RXBaL05uRUlj?=
 =?utf-8?B?L0JpYlg5MVhraDRsZ08zODRxdXRBeUFyM2NrVFhsVFNMenN1Z3ZBMGNmc1g1?=
 =?utf-8?B?Qk0zY1FkNVlWZWdwYkhuQ1U4VW9ZOGZHQ0laaU8vQWhuOEJ1NERIcW9oZW43?=
 =?utf-8?B?S2pGcGluZ0ZCYWlWYlFhdnpMTzRUQ0dlWnhxYm02M3FMNGRaTldQeCt3cHh1?=
 =?utf-8?B?SXJNcENFd3lNTkl0T1N4N2tDZk1GbDJzaU16K2pJVmV0bVNDOTkxSGgzbUhX?=
 =?utf-8?B?MURqQVY5dHlKdGxiWXRCSEdwQnhCcEkwTDdjSTd3bTkyUWpVa2J5cVJMYVVQ?=
 =?utf-8?B?YXdiZmcyNmxGV1hGUUZhaE5WYTZwQTVtOE9XdnBrRkpFd2dwM2RVUHk5SnJF?=
 =?utf-8?B?cHdXUHFJS25YWXFVRlZUK3FzcU9HTFI5MndXWWswYlZMUjc5Q0dkcFZmRnlJ?=
 =?utf-8?B?WWlMVjV4bzE3c2Y5T1VNbVhvL3VHZXVqTkxKK00zU0tNRldnT0tyREFjcTdv?=
 =?utf-8?B?NVNLY2ZXN2N6UWw2cncwMFdSQ0NIVGpGZytidGpPU2Y1czN0QzlKQ2xvYy83?=
 =?utf-8?B?b3c1cUtvc2NIeGhvS0VJSWlrbVN4NkN4M0tHRm1JVm9VSTBnRDgrNVNFK2Jl?=
 =?utf-8?B?TTlaZHdGNFFGSDVIa0VqQkJzdk5MSngyMGpDQ3Q0WkVJczBtTXUvVHNLWUkv?=
 =?utf-8?B?SkdYdEpiN2s4bmRxZUx6Njc1QjhVbjZkQVFpeEtrQzhtL0hFdWVFSDd4dTUy?=
 =?utf-8?B?S1o4Ykpyc25kcVhYTXFZQzZpK1RaQnZJRHUxV2VQWXcxamExVjhOK0NyblN5?=
 =?utf-8?B?cG81T2s3ejFHWHFkcUN4b2hzS3JBVCtBMmVydk5IYTljTmNRc0x6eFlKUFNO?=
 =?utf-8?B?WXBsbTBWenVlanp1UndleW1zbG92eTN4WFZFSVB3cHNKVlVTTEJKNVVoUkxv?=
 =?utf-8?B?Rlcva2ZuRkFxOEgwTlAzbFNnVWRDNjI1dnBUNUVUczhlT1NlbE02aGs3L2wr?=
 =?utf-8?B?WENyNkJrTVdiaUJ4bXRwTTRyWFJjMXZvODRaSXVLNk90QXVkTGQ1dDdPekVJ?=
 =?utf-8?B?dUo3UVIvbUZDQ0VDSk5vcW1KSDBFNG4yUVlsTWFYWDd4enFjeEcrV2NZY1Zu?=
 =?utf-8?B?eFBWdHo1ODBCUFJOamFZNGlFWHpQWS9saUg3bm5sSHFpOW5ra3ZUZ2dZeEVp?=
 =?utf-8?B?b2NxN3Y3NzhYYWJOT0ozQ3RMZ1RYUVo3alFmYkNRRnN6cmI5Q3dLS2NOWVlW?=
 =?utf-8?B?NnYrdWVKQVVIdUk4Ri9mdzNGQ0lCVVkyZmgzaG41TkkyNkhrSlp3bTEvcDgr?=
 =?utf-8?B?UGJONTBQWGxwcWFxOU85M1h0dEFZa245VUgyU2dFUm5RTHZjRDBqaFlua1cx?=
 =?utf-8?B?UkdlMSswZmFaWnhMRXZkSlZ1WUk5V0c0NVpNWllpNGFtWkc3RHRMUTQwQks2?=
 =?utf-8?B?R0Z0dExxUXdBZml5cHFMM2VRWHprVFdHOXQzcVlaR1VhTnBxN1hhZHQyQzFy?=
 =?utf-8?B?TlhLREVCY1ZLOGZHSXhHRlBjVnhaSktON1YzdllqMnZlMkFtdEJKNS9NY243?=
 =?utf-8?B?UDRWaXd6Ykd0Z01VSFpzUXlLTUFSVnFDbEJIdnF0UnNhN3VkVG1GaVZhOVRJ?=
 =?utf-8?B?aDE2U0laa1pWelBzclZ6YUVGcnJ6YmVyRkdBakdXSTJzaG9vdERlc3hGRDhL?=
 =?utf-8?B?cXNMQzdvTzdFZVNkUUJYMFVlM242S3lQYzdBM2JTZ3k3bnliV0p0SjVTYWl3?=
 =?utf-8?B?eTNYMDNEMWFqV2xzQy9yT3pWR240RW1wdGlraVB2SVV2cTZjd24ya3diWVdX?=
 =?utf-8?B?Sm8wc1ZoRnZvcVJJbUtBa21WMnRPeHU5Q3pqd1kwTWdLdkJzUXFSTWlrOUlI?=
 =?utf-8?B?NkpBUllOOEtacEN5anQreHFrSDJIckFoVlgyclVNbTBpM2RWRmFiRHNtWThW?=
 =?utf-8?B?TlZGQXoxN2JXMjJVMklicUZWK0xDazdpYTMrUC9kdUZ2S3RhZXczTmZ0MTRz?=
 =?utf-8?B?d0ZwYXFQVnZzVFBSampQbzJ1OWM3VmZpMDBSQ2Q0MjMzYVRrY1dPWC9PdmZO?=
 =?utf-8?B?cG1naWJidkdmMjQwNDJVVGpWQ3BmVlA4RGQvcGtPTVA3UXVqWjY2ckpqNzUw?=
 =?utf-8?Q?IJBL2IpdasY+k0ZqEheHIu/em?=
MIME-Version: 1.0
X-OriginatorOrg: nasa.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR09MB8537.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee36809-1036-4ad7-9288-08da60e6e656
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 13:36:44.9211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7005d458-45be-48ae-8140-d43da96dd17b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR09MB7132
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [EXTERNAL] Re: Inquiry: Country of Origin for LCOV
 Version 1.x
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
From: "Zhang, Cynthia X. \(GSFC-710.0\)\[TELOPHASE CORP\] via ltp"
 <ltp@lists.linux.it>
Reply-To: "Zhang, Cynthia X. \(GSFC-710.0\)\[TELOPHASE CORP\]"
 <cynthia.x.zhang@nasa.gov>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhhbmsgeW91IGZvciB5b3VyIGhlbHAhDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBQZXRlciBPYmVycGFybGVpdGVyIDxvYmVycGFyQGxpbnV4LmlibS5jb20+IA0KU2VudDog
RnJpZGF5LCBKdWx5IDgsIDIwMjIgOTozNiBBTQ0KVG86IFpoYW5nLCBDeW50aGlhIFguIChHU0ZD
LTcxMC4wKVtURUxPUEhBU0UgQ09SUF0gPGN5bnRoaWEueC56aGFuZ0BuYXNhLmdvdj4NCkNjOiBs
dHBAbGlzdHMubGludXguaXQ7IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pg0KU3ViamVj
dDogW0VYVEVSTkFMXSBSZTogW0xUUF0gSW5xdWlyeTogQ291bnRyeSBvZiBPcmlnaW4gZm9yIExD
T1YgVmVyc2lvbiAxLngNCg0KSGksDQoNCnBsZWFzZSBmaW5kIG15IHJlcGx5IHRvIHlvdXIgcXVl
c3Rpb25zIHJlZ2FyZGluZyBMQ09WIGJlbG93Lg0KDQo+PiBIZWxsbywgbXkgbmFtZSBpc+KAr0N5
bnRoaWHigK9hbmQgSSBhbSBhIFN1cHBseSBDaGFpbiBSaXNrIE1hbmFnZW1lbnQgDQo+PiBBbmFs
eXN0IGF0IE5BU0EuIE5BU0EgaXMgY3VycmVudGx5IGNvbmR1Y3RpbmcgYSBzdXBwbHkgY2hhaW4g
DQo+PiBhc3Nlc3NtZW50IG9mIExDT1YgVmVyc2lvbiAxLnguICBBcyBzdGF0ZWQgaW4gU2VjdGlv
bnMgMjA4IGFuZCA1MTQgb2YgDQo+PiB0aGUgQ29uc29saWRhdGVkIEFwcHJvcHJpYXRpb25zIEFj
dCwgMjAyMiwgUHVibGljIExhdyAxMTctMTAzLCANCj4+IGVuYWN0ZWQgTWFyY2ggMTUsIDIwMjIs
IGEgcmVxdWlyZWQgc3RlcCBvZiBvdXIgcHJvY2VzcyBpcyB0byB2ZXJpZnkgDQo+PiB0aGUgQ291
bnRyeSBvZiBPcmlnaW4gKENvTykgaW5mb3JtYXRpb24gZm9yIHRoZSBwcm9kdWN0IChpLmUuLCB0
aGUgDQo+PiBjb3VudHJ5IHdoZXJlIHRoZSBwcm9kdWN0cyB3ZXJlIGRldmVsb3BlZCwgbWFudWZh
Y3R1cmVkLCBhbmQgDQo+PiBhc3NlbWJsZWQuKSBBcyBMQ09WIFZlcnNpb24gMS54IGlzIG9wZW4g
c291cmNlLCB3ZSB1bmRlcnN0YW5kIHRoYXQgDQo+PiB0aGlzIGlucXVpcnkgaXMgbm90IGRpcmVj
dGx5IGFwcGxpY2FibGUsIGFzIGNvbnRyaWJ1dGlvbnMgbWF5IGJlIG1hZGUgDQo+PiBmcm9tIGlu
ZGl2aWR1YWxzIGZyb20gYXJvdW5kIHRoZSB3b3JsZC4gSW4gdGhpcyBjYXNlLCBOQVNBIGlzIA0K
Pj4gaW50ZXJlc3RlZCBpbiBjb25maXJtaW5nIHRoZSBmb2xsb3dpbmcgaW5mb3JtYXRpb246DQo+
Pg0KPj4gICAxLiAgSXMgdGhlcmUgYW4gb3JnYW5pemF0aW9uIHdoaWNoIHNwb25zb3JzL3B1Ymxp
c2hlcyB0aGUgcHJvamVjdCwNCj4+ICAgICAgIG9yIGEgcHJpbWFyeSBkZXZlbG9wZXIgd2hvIGF1
ZGl0cyB0aGUgY29kZSBmb3IgcG90ZW50aWFsDQo+PiAgICAgICB2dWxuZXJhYmlsaXRpZXMsIGVy
cm9ycywgb3IgbWFsaWNpb3VzIGNvZGU/IFkvTg0KPj4NCj4+ICAgMi4gIERvZXMgTENPViBWZXJz
aW9uIDEueCBoYXZlIGFuIG92ZXJzZWVpbmcgb3JnYW5pemF0aW9uIG9yDQo+PiAgICAgICBpbmRp
dmlkdWFsIGFsb25nIHRoZXNlIGxpbmVzPyBZL04NCg0KSUJNIGlzIHRoZSBtYWluIHNwb25zb3Ig
b2Ygd29yayBvbiB0aGUgdXBzdHJlYW0gTENPViByZXBvc2l0b3J5IFsxXSwgYW5kIEknbSB3b3Jr
aW5nIGFzIG1haW50YWluZXIgb2YgdGhlIExDT1YgY29kZSBiYXNlLiBJbiB0aGlzIHJvbGUgSSBy
ZXZpZXcgY29kZSBjb250cmlidXRpb25zIGZyb20gb3RoZXIgZGV2ZWxvcGVycyBmb3IgYXBwYXJl
bnQgZXJyb3JzLCBhbmQgYWxpZ25tZW50IHdpdGggTENPVuKAmXMgcHJvamVjdCBnb2FscyBbMl0g
YW5kIGNvZGluZyBzdHlsZSBiZWZvcmUgaW5jbHVzaW9uLg0KDQpIb3dldmVyIHRoZXJlIGlzIG5v
IGZvcm1hbCBwcm9jZWR1cmUgZXN0YWJsaXNoZWQgdG8gYXVkaXQgdGhlIGNvZGUgc3BlY2lmaWNh
bGx5IGZvciBwb3RlbnRpYWwgdnVsbmVyYWJpbGl0aWVzIG9yIG1hbGljaW91cyBjb2RlLiBUaGVy
ZWZvcmUgdGhlIGFuc3dlciB0byB0aGVzZSB0d28gcXVlc3Rpb25zIGlzIG5vLg0KDQo+PiAgIDEu
ICBJZiBzbywgcGxlYXNlIHByb3ZpZGUgdGhlIG5hbWUgb2YgdGhlIG9yZ2FuaXphdGlvbiBhbmQg
Y291bnRyeQ0KPj4gICB0aGV5IGFyZSBlc3RhYmxpc2hlZCBpbi4gIElmIHRoZSBpbmZvcm1hdGlv
biBhYm92ZSBpcyB1bmtub3duIG9yDQo+PiAgIGNhbm5vdCBiZSBwcm92aWRlZCwgd2UgcmVxdWVz
dCB0aGF0IHlvdSBwcm92aWRlIHRoZSBjb3VudHJ5IG9yIGxpc3QNCj4+ICAgb2YgY291bnRyaWVz
IHdoZXJlIHRoZSBtYWpvcml0eSBvZiBjb250cmlidXRpb25zIG9yaWdpbmF0ZSBmcm9tIHRvDQo+
PiAgIHNhdGlzZnkgU2VjdGlvbnMgMjA4IGFuZCA1MTQgb2YgdGhlIENvbnNvbGlkYXRlZCBBcHBy
b3ByaWF0aW9ucyBBY3QsDQo+PiAgIDIwMjIsIFB1YmxpYyBMYXcgMTE3LTEwMywgZW5hY3RlZCBN
YXJjaCAxNSwgMjAyMi4NCg0KQXQgdGhlIHRpbWUgb2Ygd3JpdGluZyAoSnVseSAyMDIyKSwgdGhl
IG1ham9yaXR5ICg+OTAlKSBvZiBjb2RlIGFzIG1lYXN1cmVkIGluIGxpbmVzIG9mIGNvZGUgaW4g
dGhlIExDT1YgcmVwb3NpdG9yeSB3YXMgZGV2ZWxvcGVkIGJ5IG15c2VsZiBvbiBiZWhhbGYgb2Yg
4oCcSUJNIERldXRzY2hsYW5kIFJlc2VhcmNoICYgRGV2ZWxvcG1lbnQgR21iSOKAnSB3aGljaCBp
cyBhIEdlcm1hbiBzdWJzaWRpYXJ5IG9mIHRoZSBVUy1iYXNlZCBJQk0gQ29ycG9yYXRpb24uDQoN
CkZ1cnRoZXJtb3JlIHRoZSBMQ09WIGdpdCByZXBvc2l0b3J5IFsxXSBjb250YWlucyBhIHJlY29y
ZCBvZiBhbGwgY29udHJpYnV0aW9ucywgaW5jbHVkaW5nIHRoZSBlLW1haWwgYWRkcmVzcyBvZiBl
YWNoIGNvbnRyaWJ1dG9yLCBidXQgbm8gYXR0cmlidXRpb24gdG8gY291bnRyaWVzIG9mIG9yaWdp
bi4NCg0KDQpSZWdhcmRzLA0KICBQZXRlcg0KDQpbMV0gaHR0cHM6Ly9nY2MwMi5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0aHViLmNvbSUyRmxp
bnV4LXRlc3QtcHJvamVjdCUyRmxjb3YmYW1wO2RhdGE9MDUlN0MwMSU3Q2N5bnRoaWEueC56aGFu
ZyU0MG5hc2EuZ292JTdDNTc2YmE0NmQyNGFlNDI3YzZhY2MwOGRhNjBlNmM3OWIlN0M3MDA1ZDQ1
ODQ1YmU0OGFlODE0MGQ0M2RhOTZkZDE3YiU3QzAlN0MwJTdDNjM3OTI4ODQxNTU1MDcxNDcxJTdD
VW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJ
aUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRh
PVklMkZ3dSUyQlg1SExiR0xxeTZJbmlqWW1PSE9pdDhXQTRQN3IwJTJCR1R0MmRjMmMlM0QmYW1w
O3Jlc2VydmVkPTANClsyXSBodHRwczovL2djYzAyLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXRodWIuY29tJTJGbGludXgtdGVzdC1wcm9qZWN0
JTJGbGNvdiUyRmJsb2IlMkZ2MS4xNiUyRkNPTlRSSUJVVElORyUyM0w1MSZhbXA7ZGF0YT0wNSU3
QzAxJTdDY3ludGhpYS54LnpoYW5nJTQwbmFzYS5nb3YlN0M1NzZiYTQ2ZDI0YWU0MjdjNmFjYzA4
ZGE2MGU2Yzc5YiU3QzcwMDVkNDU4NDViZTQ4YWU4MTQwZDQzZGE5NmRkMTdiJTdDMCU3QzAlN0M2
Mzc5Mjg4NDE1NTUwNzE0NzElN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpB
d01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAw
MCU3QyU3QyU3QyZhbXA7c2RhdGE9UGs1c2VZdTVRUGNZdFJWZzZJbmE0V1RES3JaWFlSVVg1c3Zh
YXQ5OUI4VSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQotLQ0KUGV0ZXIgT2JlcnBhcmxlaXRlcg0KTGlu
dXggb24gSUJNIFogRGV2ZWxvcG1lbnQNCklCTSBEZXV0c2NobGFuZCBSZXNlYXJjaCAmIERldmVs
b3BtZW50IEdtYkgNCg0KVm9yc2l0emVuZGVyIGRlcyBBdWZzaWNodHNyYXRzOiBHcmVnb3IgUGls
bGVuDQpHZXNjaMOkZnRzZsO8aHJ1bmc6IERhdmlkIEZhbGxlcg0KU2l0eiBkZXIgR2VzZWxsc2No
YWZ0OiBCw7ZibGluZ2VuDQpSZWdpc3RlcmdlcmljaHQ6IEFtdHNnZXJpY2h0IFN0dXR0Z2FydCwg
SFJCIDI0MzI5NAkNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
