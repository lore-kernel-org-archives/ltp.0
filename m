Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FFEEB64D7
	for <ltp@archiver.kernel.org>; Mon, 26 Jun 2023 09:14:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6393D3C99BE
	for <ltp@archiver.kernel.org>; Mon, 26 Jun 2023 11:14:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09E003C99B3
 for <ltp@lists.linux.it>; Mon, 26 Jun 2023 11:14:31 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 31FEF1A007AA
 for <ltp@lists.linux.it>; Mon, 26 Jun 2023 11:14:26 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 35Q9EGdY024804;
 Mon, 26 Jun 2023 17:14:16 +0800 (+08)
 (envelope-from dylan@andestech.com)
Received: from ATCPCS31.andestech.com (10.0.1.89) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 26 Jun 2023
 17:14:18 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (104.47.110.43)
 by mail.andestech.com (10.0.1.89) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Mon, 26 Jun 2023 17:14:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGIIiwFK3uHj49RY8T9K9xsaUg5pPX7fhFQp4GSwB4KlbthkDq5oLCJbDrlziWonn1qU8zr5ocZ8RnEwnohb/J3cZ55Quy4In2smumLi+OKG/bXHWMP/n4FXf8JYnmq/DN2e6T9POOkBdpthhhOhnlAgYHk+DX+sEMtJHO2L2ii1rYMJKGKbnxu7ckeAZb1YZUZIjk2Qmyb9QuN1CdfnkR9Ib9ICWJVlLQBzfXxKCVFjyg7J0JVt1yGxnaHTFwke/WRRd1g4ZYp+BS8bLBDOsWnWmciC8Ka3+li7Uz18+/qcopRIGjkAbUq31JF4MzJTltci3Wt0qz8aQdzFhBVAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64Jc3v7FHHrGHYjSevQm9OEq46l2KJG0HKC0JFJnVHA=;
 b=LycLB7r0PFf956QU2T9bspdeCHvV28t8RqRfCgM7jfM0ZnGRKOze36ryM3l+L3a1nyAVyPmGBvKegmbJk5F/J6hBCP3SLJUVGnMhPa3IGrFpWqxVM+J97Vjk9qskK6pQpr8VvCPj+wZTcu0PUYetV7rhA7yXt2PKpU+tapoaTs9AmS5GYInRvch2rKg9fl+BPk5cMPdLGaP7xUmAmnwkNKH/zx8rOmK9CPHjDqsW2RVpVmt9z3abP75vbhf1LLh8nUTZoYdWM5FLdwZsaiIfhmcl3QS2bNZHmd8Nao/9Kuf2E2W3mWs0mIxLHnZdAGoZfi5RCYqy1Q/kCLDG7udCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
Received: from SEZPR03MB6619.apcprd03.prod.outlook.com (2603:1096:101:7a::6)
 by SI2PR03MB6760.apcprd03.prod.outlook.com (2603:1096:4:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.45; Mon, 26 Jun
 2023 09:14:09 +0000
Received: from SEZPR03MB6619.apcprd03.prod.outlook.com
 ([fe80::c31:ed2d:6d62:4819]) by SEZPR03MB6619.apcprd03.prod.outlook.com
 ([fe80::c31:ed2d:6d62:4819%7]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 09:14:09 +0000
From: =?utf-8?B?RHlsYW4gRGFpLVJvbmcgSmhvbmco6Y2+5bKx6J6NKQ==?=
 <dylan@andestech.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc variant
Thread-Index: AQHZn21QOxrsesyk1Ea83vN6QBN5mK+cuAaAgAAjH4A=
Date: Mon, 26 Jun 2023 09:14:09 +0000
Message-ID: <SEZPR03MB661985D8F0DA3BA80B71F13DAC26A@SEZPR03MB6619.apcprd03.prod.outlook.com>
References: <20230615093933.3185297-1-dylan@andestech.com>
 <CAEemH2e-PPPNHNX6_3Kj86hh3z-5o2i4XxD2GP-+Fh4Pe=B3TA@mail.gmail.com>
In-Reply-To: <CAEemH2e-PPPNHNX6_3Kj86hh3z-5o2i4XxD2GP-+Fh4Pe=B3TA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6619:EE_|SI2PR03MB6760:EE_
x-ms-office365-filtering-correlation-id: 9384c7e9-0bb4-41b5-dd06-08db7625b2e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xmi6SUQNqOoj+0OHddRSLVyo5HS0FscpW0kq6PazdF9wevxByhP8UFqE6iVsp27IZclkwB0xPF7rtDuIecz3Cehhbjd5aKeT+sQJ0o7EkIDKBS2rWk67ExCBYOzwFKN66sgtJ2/i820krSucKXewc2oqVyfM78RpACeL9OWuR3YVpMWmktCKGUrbwbCdddXPSvJ99T/xuz+b5xtphn56zXf4pNtgw8y4vfpLaZxdltCzhep9vihhzVW7D8cAR5HdJPZJpZQ/cGVB4Mr5VvMV0LQW5lx/witrgVZtZ27s7LETvtDCXKkAeWtnAblYiIpetsw7+nMGImnbCLsNcoJzhk2mHmU9iOsnxqb+WCaYQ9G7QOieFsMetTcPXxAHQiDjgi1gop2GHk7iIbxFyINZlgqyYL6Qg549AUsxwtLWOTI0ZbxPpwzF563sYyAjaMi4K2sZqwkxqXY4RdOJiKXXsy5wtTQ2GSDQQw8TKy+OSku2ahcPmYkzJc+pJ+I8NlYuE8I6aZapdGcoQip4FtsJGTlG0eYiO+16XMyTebem1HLK1x8z+Jitm9g2aPzAccxxQU05NlnGdiZCtqmishe10wGWPQdFgF25JeHcjCKUSMcJnqX0yG1ZZvH0b3yLg2jiWv0tdUtZV5ZM5DWOZfb3NEJzXZA6BfpaxDaPeu2vb/G5gxGtM9c0lI6HHqSiUM3w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB6619.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39840400004)(396003)(366004)(451199021)(85182001)(52536014)(2906002)(5660300002)(33656002)(8936002)(38070700005)(64756008)(166002)(55016003)(66556008)(66446008)(86362001)(8676002)(316002)(66476007)(76116006)(4326008)(6916009)(38100700002)(122000001)(66946007)(41300700001)(53546011)(966005)(26005)(9686003)(6506007)(186003)(54906003)(7696005)(478600001)(71200400001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U292V2h4L1BhQkoxY2hqWjh5Rm1OYlFOUG04TGt6aVg2bm9JM2JENGVjUmJC?=
 =?utf-8?B?eUw2NjJEakI1MFVWRzl4eTJVT0d3TFRTdEY2KzJrMmpsNHgvWTljRmZnQUg5?=
 =?utf-8?B?Z3ltai9WT2FxOHlJRUxZQXNFS203T0tZOWFhVU12bmV2UkQ2d3kxWlVwODd2?=
 =?utf-8?B?TTg2RVdOWko0ald1NGR6RnFnZS8rQWx3QTFxSFgzc2lHeXk5RFduam9rSTg2?=
 =?utf-8?B?cTR4bE9aRU1YcEMvWDltSEZqU0FlTFdHc0s1dWlSNWs2MFJCTlg1WHRPRzhh?=
 =?utf-8?B?SWlQcDNJK1l5OHNtMEVOa3JTS050UW5nV0VsamVwczZHSlIySHRGY05SbzRu?=
 =?utf-8?B?bUgrc3hQc1Y0czBEb2lZYVo3R0JkMmRnMWdQZHdYMC9PS2JHMmRDeE9YOEE4?=
 =?utf-8?B?S0FnL1VDODA0S3BLTjA3UDY4Uml0eVZid1dPSzE2MldqRnRJb2E2V3ZKNVN5?=
 =?utf-8?B?dEJiUFZnZzkzQTY1VHNCN1Vzc3BWYVZBRDE4aFJod25MeUk2eUdMNWxaOEpG?=
 =?utf-8?B?UjAyRi8wUmIrazNob2RVL3hldXFWbTBobVhVQS8xdXA2eVQvSEI0V0dNRU1s?=
 =?utf-8?B?b0NJb2NUeWUxQ1JZNDZlRloxV2RkcDJGenZtb01vSzhRL21QTkRhSkl3TTRx?=
 =?utf-8?B?VzdNSWdlbUtXbjVNTm1jMnZXbGY2NnZ0bi9wYmJxMVF1TW04cVdXTmJjMU5o?=
 =?utf-8?B?UkpNb3BPQTV3ZEt1NjBBU1lXeUVkVndvZGNwdWhKS25XSENPTzMzMDZNcGNt?=
 =?utf-8?B?alZRT3gxVGkrT3lDVmRjMlJGbG5HeFRrWXRGb2ZkWWFaOCs5M2RHbXBJNENH?=
 =?utf-8?B?SDZJQmxhWVJHQmlwV0FLWThLbmlsQ21vamVDcmtBc0d2TERGMThldlFFUitk?=
 =?utf-8?B?ZklRdzNzYzFqQ3l1RnRYQUZwNGR5akI5SzFUYU1uK3JjT1N5RHRQMmtSeW1I?=
 =?utf-8?B?YXNzL004WVJWT1k1c2dVY1JvWUNPRGlQeE14TklYM2ZJSk5oSzJNTTNDdUZs?=
 =?utf-8?B?b2swTlBWOFU5YWZ1QWFQTDZWSUx1L1Y2ZGh2WnZ2cmFIWVZWckw1VXhDUjl0?=
 =?utf-8?B?YXlaVDNvMjBuUTAzWUNjS3dTOXhaUmpMZDE0bVpUcjZpd1hEYnFZM2pZSWFa?=
 =?utf-8?B?Q0JnWW9rSjJlVmtxT2o1RkZEeXB2cTBPVGU1UDZxNnErRy9mOHBSRFNlaTRn?=
 =?utf-8?B?K0xDTnlBMEFHWWF4dzJSc3ZlcExoT2VqaHdSa1pKdFc1eHBCR1UyK1JMQ1Jm?=
 =?utf-8?B?dWo0bnJXVVFiZG1sTjZ4ZTFma3kyWERZcW1xbG1CWldFM1hMZ1hrMS9YQitI?=
 =?utf-8?B?NmJGSkNhSWk0UDAra2x5Um5QL21HazM4RC94c3FmYjJTMnU2cGtNK2E5K1Ex?=
 =?utf-8?B?MnhwSE16ejNxdjVLQnhtUjh1TVU5TG9RS0RWdE5La2RtRm91eEp4OGUxUHAv?=
 =?utf-8?B?MWNSUjlMV2ZSb3NERVlzVDVQU3dLQkRoQ0p0ZkdDdkNWbjMvTkVva3R1cVhR?=
 =?utf-8?B?QktQdzhRMEF2Uld0SXRlSnE3Z3RJeWQxU2VvNFFWbVRmbHRST0JnU0pLSWxQ?=
 =?utf-8?B?N0RkMFdoRGRaamVzcGcvUlp5WlRERzEwbWZ2cTF5WnlScC8rUk93cEpTTmpj?=
 =?utf-8?B?MURSc0pTRVlaaTJaTkpsaS9PaVdocW52M0NXT3pVS2lIYS81NzhxTmRlcXRV?=
 =?utf-8?B?VUxlSVRPK1NaamR0MUxjMCs5N2U0VDNLSjh2MVM2dzJRU2xZZmRMUVJJV1A5?=
 =?utf-8?B?cjFkUnlmNGpvTld0VE1CNnZRdzVlSXc5Wmd6NkVxZ3dyeWxPajZMck9tVFdQ?=
 =?utf-8?B?V1AzaUl1WG8vWlFTbjJDbDZTNnJWS2Y0RG9mWWc0OC9aWFFNMFAvUjJqQ1lk?=
 =?utf-8?B?UkZQNDhMMERHL3Vha1kzU0hEd3hKVGlQUnpxL3U3dEF0YWp2UzlFbk4rWDV6?=
 =?utf-8?B?Z2Rodm5OMTIyalJtNTc3QTJRdkNlNFNnQ2NOblk4c21rZldZZWFReWIwdzQv?=
 =?utf-8?B?WFZJRDh6K2ZVZnd2eUUvQmtYeTVqbXZMNHdFN3RnQVorb1BwU0NpMzlsalJG?=
 =?utf-8?B?WldPSElHMW1IWC9DUmR2bzh5NVFvZFh2UUFqbUdrM0JSOG9mOU5HbFZVQTFF?=
 =?utf-8?Q?VRoA=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6619.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9384c7e9-0bb4-41b5-dd06-08db7625b2e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 09:14:09.0189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLvT4WdgbbQMbvLxyuSULozMEzApgEffR477+Wef86TRMXC1WkySp98UCr17T7ICG2as4jpc66SDeTzbFtvD1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6760
X-OriginatorOrg: andestech.com
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 35Q9EGdY024804
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc
 variant
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
Cc: =?utf-8?B?TWluYSBIdWktTWluIENob3Uo5ZGo5oWn5pWPKQ==?=
 <minachou@andestech.com>,
 =?utf-8?B?VGltIFNoaWgtVGluZyBPdVlhbmco5q2Q6Zm95aOr5bqtKQ==?=
 <tim609@andestech.com>, "x5710999x@gmail.com" <x5710999x@gmail.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGkgV2FuZywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpQbGVhc2UgaWdub3JlIG15
IGVtYWlsIEkganVzdCByZXBsaWVkIHRvIHlvdSwgSSBmb3Jnb3QgdG8gY2xpY2sg4oCccmVwbHkg
YWxs4oCdLg0KUGxlYXNlIGNvbnNpZGVyIHRoaXMgZW1haWwgdGhlIHByaW1hcnkgZW1haWwuDQoN
CkZyb206IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPg0KU2VudDogTW9uZGF5LCBKdW5lIDI2
LCAyMDIzIDI6NTcgUE0NClRvOiBEeWxhbiBEYWktUm9uZyBKaG9uZyjpjb7lsrHono0pIDxkeWxh
bkBhbmRlc3RlY2guY29tPg0KQ2M6IGx0cEBsaXN0cy5saW51eC5pdDsgTWluYSBIdWktTWluIENo
b3Uo5ZGo5oWn5pWPKSA8bWluYWNob3VAYW5kZXN0ZWNoLmNvbT47IFRpbSBTaGloLVRpbmcgT3VZ
YW5nKOatkOmZveWjq+W6rSkgPHRpbTYwOUBhbmRlc3RlY2guY29tPjsgeDU3MTA5OTl4QGdtYWls
LmNvbTsgQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+DQpTdWJqZWN0OiBSZTogW0xUUF0g
W1BBVENIXSBodWdlc2htY3RsMDI6IFNraXBwZWQgRUZBVUxUIHRlc3RzIGZvciBsaWJjIHZhcmlh
bnQNCg0KDQoNCk9uIFRodSwgSnVuIDE1LCAyMDIzIGF0IDU6NDDigK9QTSBEeWxhbiBKaG9uZyA8
ZHlsYW5AYW5kZXN0ZWNoLmNvbTxtYWlsdG86ZHlsYW5AYW5kZXN0ZWNoLmNvbT4+IHdyb3RlOg0K
V2hlbiB0ZXN0aW5nIGh1Z2VzaG1jdGwwMiB1bmRlciB0aGUgMzJiaXQgYXJjaGl0ZWN0dXJlLCBh
IHNlZ21lbnRhdGlvbiBmYXVsdA0Kd2lsbCBvY2N1ci4gVGhpcyBwYXRjaCB3aWxsIHNraXAgRUZB
VUxUIHRlc3RzIGZvciBsaWJjIHZhcmlhbnQuDQoNCkh1Z2VzaG1jdGwwMiB3aWxsIGludGVudGlv
bmFsbHkgcGFzcyAiKHN0cnVjdCBzaG1pZF9kcyAqKS0xIiB0byBzaG1jdGwoKSwgYnV0DQpnbGli
YyB3aWxsIHBlcmZvcm0gYW4gYWRkaXRpb25hbCBjb252ZXJzaW9uIGZ1bmN0aW9uIHdoZW4gdGhl
IGFyY2hpdGVjdHVyZSBpcw0KMzJiaXQsIHdoaWNoIHdpbGwgdHJ5IHRvIGNvcHkgYWxsIGl0ZW1z
IGluIChzdHJ1Y3Qgc2htaWRfZHMgKikgdG8gYW5vdGhlcg0Kc3RydWN0dXJlWyoxXS4gSW4gdGhl
IHByb2Nlc3Mgb2YgY29weWluZywgaXQgaXMgbmVjZXNzYXJ5IHRvIGRlcmVmZXJlbmNlDQoiKHN0
cnVjdCBzaG1pZF9kcyAqKS0xIiwgcmVzdWx0aW5nIGluIHNlZ21lbnRhdGlvbiBmYXVsdC4NCg0K
VGhlIExUUCBhbHNvIGhhcyBzaW1pbGFyIHByb2JsZW1zIGJlZm9yZSwgdGhpcyBwYXRjaCBpcyBy
ZWZlcmVuY2UgZnJvbSB0aGUNCnNobWN0bDAzIHBhdGNoWyoyXS4NCg0KWyoxXTogaHR0cHM6Ly9n
aXRodWIuY29tL2JtaW5vci9nbGliYy9ibG9iL21hc3Rlci9zeXNkZXBzL3VuaXgvc3lzdi9saW51
eC9zaG1jdGwuYyNMMzcNClsqMl06IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2pl
Y3QvbHRwL2NvbW1pdC9hNWE4MGFhODQ4NWE3Y2IwMTdmOTZhYmE4ZDdiNWVhNzlmMWJhNGQ0DQoN
ClNpZ25lZC1vZmYtYnk6IER5bGFuIEpob25nIDxkeWxhbkBhbmRlc3RlY2guY29tPG1haWx0bzpk
eWxhbkBhbmRlc3RlY2guY29tPj4NCi0tLQ0KIC4uLi9tZW0vaHVnZXRsYi9odWdlc2htY3RsL2h1
Z2VzaG1jdGwwMi5jICAgICB8IDM1ICsrKysrKysrKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdl
ZCwgMzQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htY3RsL2h1Z2VzaG1jdGwwMi5jIGIvdGVzdGNh
c2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htY3RsL2h1Z2VzaG1jdGwwMi5jDQppbmRleCAw
YmM5ZmZkNzQuLmU5YzJlOWZjOCAxMDA2NDQNCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1
Z2V0bGIvaHVnZXNobWN0bC9odWdlc2htY3RsMDIuYw0KKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vaHVnZXRsYi9odWdlc2htY3RsL2h1Z2VzaG1jdGwwMi5jDQpAQCAtMjcsNiArMjcsNyBAQA0K
ICNpbmNsdWRlIDxwd2QuaD4NCiAjaW5jbHVkZSA8bGltaXRzLmg+DQogI2luY2x1ZGUgImh1Z2V0
bGIuaCINCisjaW5jbHVkZSAibGFwaS9zeXNjYWxscy5oIg0KDQogc3RhdGljIHNpemVfdCBzaG1f
c2l6ZTsNCiBzdGF0aWMgaW50IHNobV9pZF8xID0gLTE7DQpAQCAtNTAsOSArNTEsMzcgQEAgc3Ry
dWN0IHRjYXNlIHsNCiAgICAgICAgeyZzaG1faWRfMiwgLTEsICZidWYsIEVJTlZBTH0sDQogfTsN
Cg0KK3N0YXRpYyBpbnQgbGliY19zaG1jdGwoaW50IHNobWlkLCBpbnQgY21kLCB2b2lkICpidWYp
DQorew0KKyAgICAgICByZXR1cm4gc2htY3RsKHNobWlkLCBjbWQsIGJ1Zik7DQorfQ0KKw0KK3N0
YXRpYyBpbnQgc3lzX3NobWN0bChpbnQgc2htaWQsIGludCBjbWQsIHZvaWQgKmJ1ZikNCit7DQor
ICAgICAgIHJldHVybiB0c3Rfc3lzY2FsbChfX05SX3NobWN0bCwgc2htaWQsIGNtZCwgYnVmKTsN
Cit9DQorDQorc3RhdGljIHN0cnVjdCB0ZXN0X3ZhcmlhbnRzDQorew0KKyAgICAgICBpbnQgKCpz
aG1jdGwpKGludCBzaG1pZCwgaW50IGNtZCwgdm9pZCAqYnVmKTsNCisgICAgICAgY2hhciAqZGVz
YzsNCit9IHZhcmlhbnRzW10gPSB7DQorICAgICAgIHsgLnNobWN0bCA9IGxpYmNfc2htY3RsLCAu
ZGVzYyA9ICJsaWJjIHNobWN0bCgpIn0sDQorI2lmIChfX05SX3NobWN0bCAhPSBfX0xUUF9fTlJf
SU5WQUxJRF9TWVNDQUxMKQ0KKyAgICAgICB7IC5zaG1jdGwgPSBzeXNfc2htY3RsLCAgLmRlc2Mg
PSAiX19OUl9zaG1jdGwgc3lzY2FsbCJ9LA0KKyNlbmRpZg0KK307DQorDQogc3RhdGljIHZvaWQg
dGVzdF9odWdlc2htY3RsKHVuc2lnbmVkIGludCBpKQ0KIHsNCi0gICAgICAgVEVTVChzaG1jdGwo
Kih0Y2FzZXNbaV0uc2htaWQpLCB0Y2FzZXNbaV0uY21kLCB0Y2FzZXNbaV0uc2J1ZikpOw0KKyAg
ICAgICBzdHJ1Y3QgdGVzdF92YXJpYW50cyAqdHYgPSAmdmFyaWFudHNbdHN0X3ZhcmlhbnRdOw0K
Kw0KKyAgICAgICBpZiAodGNhc2VzW2ldLmVycm9yID09IEVGQVVMVCAmJiB0di0+c2htY3RsID09
IGxpYmNfc2htY3RsKSB7DQoNCllvdSBwb2ludGVkIHRoZSBzZWdtZW50IGZhdWx0IG9ubHkgZXhp
c3RzIG9uIDMyYml0IHdoZW4gdXNlDQpsaWJjIHdyYXBwZXIsIGJ1dCB0aGlzIGNvbmRpdGlvbiBz
a2lwcyBmb3IgYm90aCA2NGFuZDMyIGJpdHMsDQppc24ndCBpdD8NCg0KSSBndWVzcyB0aGUgc3Ry
aWN0IGNvbmRpdGlvbiBzaG91bGQgYmUgYXMgYmVsb3c/DQoNCiAgICBpZiAodGNhc2VzW2ldLmVy
cm9yID09IEVGQVVMVCAmJiB0di0+c2htY3RsID09IGxpYmNfc2htY3RsICYmIHRzdF9rZXJuZWxf
Yml0cygpID09IDMyKSB7DQogICAgLi4uDQogICAgfQ0KDQoNCkluZGVlZCwgdGhpcyBvbmx5IGhh
cHBlbnMgb24gMzItYml0IGFyY2hpdGVjdHVyZXMsIHNvIHRoZSBjb25kaXRpb24geW91IGFkZGVk
IGlzIG5vIHByb2JsZW0uDQpCdXQgaW4gb3RoZXIgTFRQIHRlc3QgY2FzZXMsIHRoaXMgY29uZGl0
aW9uIGlzIG5vdCBjb25zaWRlcmVkIG9uIGJvdGggMzIvNjQgYml0Lg0KRm9yIGV4YW1wbGU6DQog
ICAgLSBtc2djdGwwNDogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAv
YmxvYi9tYXN0ZXIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvbXNnY3RsL21zZ2N0bDA0
LmMjTDc0DQogICAgLSBzZW1jdGwwNDogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJv
amVjdC9sdHAvYmxvYi9tYXN0ZXIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvc2VtY3Rs
L3NlbWN0bDAzLmMjTDc4DQogICAgLSBzY2hlZF9ycl9nZXRfaW50ZXJ2YWwwMy5jOiBodHRwczov
L2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9ibG9iL21hc3Rlci90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL3NjaGVkX3JyX2dldF9pbnRlcnZhbC9zY2hlZF9ycl9nZXRfaW50ZXJ2
YWwwMy5jI0w3MQ0KDQpOb3Qgc3VyZSBpZiB0aGUgb3JpZ2luYWwgZGV2ZWxvcGVycyBkaWRuJ3Qg
dGhpbmsgb2YgdGhpcyBvciBMVFAganVzdCB3YW50ZWQgdG8gaWdub3JlIHRoaXMgY29uZGl0aW9u
Lg0KRG8geW91IHRoaW5rIHRoZSBjb25kaXRpb24gbmVlZHMgdG8gYmUgbW9kaWZpZWQgdG8gb25s
eSBpZ25vcmUgMzIgYml0cywgb3IgZGVzaWduZWQgdG8gYmUgdGhlIHNhbWUgYXMgdGhlIG90aGVy
IExUUCB0ZXN0IGNhc2VzIHNvIHRoYXQgMzIvNjQgYml0cyBhcmUgaWdub3JlZD8NCg0KVGhhbmtz
LA0KRHlsYW4NCg0KKyAgICAgICAgICAgICAgIHRzdF9yZXMoVENPTkYsICJFRkFVTFQgaXMgc2tp
cHBlZCBmb3IgbGliYyB2YXJpYW50Iik7DQorICAgICAgICAgICAgICAgcmV0dXJuOw0KKyAgICAg
ICB9DQorDQorICAgICAgIFRFU1QodHYtPnNobWN0bCgqKHRjYXNlc1tpXS5zaG1pZCksIHRjYXNl
c1tpXS5jbWQsIHRjYXNlc1tpXS5zYnVmKSk7DQogICAgICAgIGlmIChUU1RfUkVUICE9IC0xKSB7
DQogICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCwgInNobWN0bCBzdWNjZWVkZWQgdW5leHBl
Y3RlZGx5Iik7DQogICAgICAgICAgICAgICAgcmV0dXJuOw0KQEAgLTcwLDggKzk5LDExIEBAIHN0
YXRpYyB2b2lkIHRlc3RfaHVnZXNobWN0bCh1bnNpZ25lZCBpbnQgaSkNCg0KIHN0YXRpYyB2b2lk
IHNldHVwKHZvaWQpDQogew0KKyAgICAgICBzdHJ1Y3QgdGVzdF92YXJpYW50cyAqdHYgPSAmdmFy
aWFudHNbdHN0X3ZhcmlhbnRdOw0KICAgICAgICBsb25nIGhwYWdlX3NpemU7DQoNCisgICAgICAg
dHN0X3JlcyhUSU5GTywgIlRlc3RpbmcgdmFyaWFudDogJXMiLCB0di0+ZGVzYyk7DQorDQogICAg
ICAgIGlmICh0c3RfaHVnZXBhZ2VzID09IDApDQogICAgICAgICAgICAgICAgdHN0X2JyayhUQ09O
RiwgIk5vIGVub3VnaCBodWdlcGFnZXMgZm9yIHRlc3RpbmcuIik7DQoNCkBAIC0xMDEsNiArMTMz
LDcgQEAgc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQ0KDQogc3RhdGljIHN0cnVjdCB0c3RfdGVz
dCB0ZXN0ID0gew0KICAgICAgICAudGVzdCA9IHRlc3RfaHVnZXNobWN0bCwNCisgICAgICAgLnRl
c3RfdmFyaWFudHMgPSBBUlJBWV9TSVpFKHZhcmlhbnRzKSwNCiAgICAgICAgLnRjbnQgPSBBUlJB
WV9TSVpFKHRjYXNlcyksDQogICAgICAgIC5uZWVkc19yb290ID0gMSwNCiAgICAgICAgLm5lZWRz
X3RtcGRpciA9IDEsDQotLQ0KMi4zNC4xDQoNCg0KLS0NCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cA0KDQoNCi0tDQpSZWdhcmRzLA0KTGkgV2Fu
Zw0KQ09ORklERU5USUFMSVRZIE5PVElDRToNCg0KVGhpcyBlLW1haWwgKGFuZCBpdHMgYXR0YWNo
bWVudHMpIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBhbmQgbGVnYWxseSBwcml2aWxlZ2VkIGlu
Zm9ybWF0aW9uIG9yIGluZm9ybWF0aW9uIHByb3RlY3RlZCBmcm9tIGRpc2Nsb3N1cmUuIElmIHlv
dSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHlvdSBhcmUgaGVyZWJ5IG5vdGlmaWVk
IHRoYXQgYW55IGRpc2Nsb3N1cmUsIGNvcHlpbmcsIGRpc3RyaWJ1dGlvbiwgb3IgdXNlIG9mIHRo
ZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElu
IHRoaXMgY2FzZSwgcGxlYXNlIGltbWVkaWF0ZWx5IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJldHVy
biBlLW1haWwsIGRlbGV0ZSB0aGUgbWVzc2FnZSAoYW5kIGFueSBhY2NvbXBhbnlpbmcgZG9jdW1l
bnRzKSBhbmQgZGVzdHJveSBhbGwgcHJpbnRlZCBoYXJkIGNvcGllcy4gVGhhbmsgeW91IGZvciB5
b3VyIGNvb3BlcmF0aW9uLg0KDQpDb3B5cmlnaHQgQU5ERVMgVEVDSE5PTE9HWSBDT1JQT1JBVElP
TiAtIEFsbCBSaWdodHMgUmVzZXJ2ZWQuDQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
