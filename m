Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D70C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 12:27:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED1533CD931
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 13:27:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74DA63CD3B8
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 13:27:15 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E883C1B61FEB
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 13:27:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIPVTURZnKaa8UhgPr+LdHM90zG90xzCkUng/XN1IGo7xPmT0J+4oPVbNH85qMpCOhvqLOiNog8y2liqTbYrQ1SEuyLwYgEjXlyTPQacvsRx5GcDknDWVSCEtXPa5DK9OyYstG6nI6byyLW+CmY6kxFCblUFwcsUNHTp+WWXbKEzc+Ix9fP+L0QBpUacgsj95uNmrgpEl9oYmuKyg1YCDCrkWN4WbHblM0X0RDia/3+AZI4TkWLNaOPV0KV2lUV0ha95EKQ8cl3eqswcYQKgIUuINPooS6lfRkauIjCdU6T7TtN2XLNyiY0HBquHnECTgZwhren+MRxO5P2w6klA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kX4La7zzeNbv4Eaa7DU3hjMjzideXgPJ23ruxLpdR8A=;
 b=BtORpsOQ8E9ANshHJPB4cUE2vKMgIBpnnoCM/VWOds/wIZ4H+/YIMIsK5L+pb/tWItjXmAddkRm0ISrRPkgTE8anKSB2qmXVSIsFrGmV7hLrZF0oXvuFjrm2bb/y8rBRmZMfcJZO/xm8pNi6vxKYCIA01gNd3fhHmDSvyyprtrE66Q6ymmTYvL5HIyNH8RicJsdfa5opQ6paZbSgU9um6UWvcp8qrLc3ox/Uj9vtrKZFEva0DbB9BZmdw6D8IYDMER6e0x0IUQbcWba9/yGT/VJjRMehvSoaSpgGPkr3uAl4DTUY4lyXm1WDlRJEx7kUJkCjpvNIEGbN8/ENzSuZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kX4La7zzeNbv4Eaa7DU3hjMjzideXgPJ23ruxLpdR8A=;
 b=ah5PwaVWPrwCOxBj3Rvb3YB4lB0bpOQCQFDrrF1vKD+4M2yhKIltkof+3raR3qorpBceHB+nurRddnU3OK+SW1LkpYpp3SZYxKDtYH1Xrgfq9YqIHa8l/8FUlKVIAdaHWz0K1z9p93iJJCR7SVImWz34I5F8fpjxzp+YbS3CNXuwvIXQzG1v4MdIwLrAdbZbrInx2e+VgS5FlJ7WImZ/mXH4LEKQVOyPa0pFeAW3MMmdzTOdlpmiiw/f9pS+6rsfxnxqChl1IHkpORy2uBOHNQl1xKo/OBNkp8h0a3fZsCXf/IPyE+ucb9Nyc/qmgF1XBgWemo8AeQN/iyJqiXKwQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB7526.eurprd04.prod.outlook.com (2603:10a6:20b:299::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Fri, 1 Dec
 2023 12:27:13 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c%5]) with mapi id 15.20.7068.016; Fri, 1 Dec 2023
 12:27:13 +0000
Message-ID: <90333e17-2f02-475d-9db1-716128e4973f@suse.com>
Date: Fri, 1 Dec 2023 13:27:11 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Li Wang <liwang@redhat.com>
References: <29d08b1d-13c7-4236-a2d5-0d7d1a0ea942@suse.com>
 <CAEemH2fJ+HS4pjw75uLE91XM5Ju8z9+pjeNevjwWb9WBSJ28Zw@mail.gmail.com>
 <20231201120809.GA2779521@pevik>
In-Reply-To: <20231201120809.GA2779521@pevik>
X-ClientProxiedBy: FR4P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::14) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS8PR04MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: f925ac83-b6d0-4852-f858-08dbf268d899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIW+0lVk2i8y6NzuZc82p5KwDFvlWwuR7TP9mY7JDdzLCTD2Ql64K/yfqqiRTPihbKWVUnubExE5lrWgyO6MiaxFenrdxDm7J5Qr7AQldIyu9ocnqbSSMMsxk35BjkepWo/2gcKrHhlhFYcu1Ya+ex8yYURiZZ7Y3+P/p3zas2r8YAN1qBAH75944qOTGj1w6xPQtVV94jd+L9BneZJtW0qMg3BHmbHhNmBK48YSiKA+fd0nYV1tHMQPcp6ap+kLwyCVIXLhTCVk3o2Lr9Stvg1k166O6yM3aP6vJjg9IJ221angpBsykni9YlYXC1U4E/Wxk+/atus4WfrcqDVPG4NkOJvPDV0fLarJJSPqjxRLDZRnsSZ1nCYlZeNPICx37Ywr9KHfKmgn+IjWbWr08MIRdhgrMBEsFa535HuBjuc/55kBwe0mYvAPfEP+OuM6cusByB+cHcklYENRxDxCNOjXFoCsSTKif2CWIbZ3QPhX5pz7WgYVfx29Qlnm8wdfNU2M5PGtkQ/A1tGDPLRzuLGhZMzLv/jCzYfk+RvF6ImhvrxnRswYnjV/f/b0gFS6hmDEPRcVz4eFmKTsV55Xi4dE3rciJPvOORl/ZcDrfG2hSgeVSY1HHBT75nGIWy+3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(83380400001)(26005)(2616005)(53546011)(6512007)(6506007)(38100700002)(6486002)(508600001)(966005)(2906002)(4326008)(66946007)(66476007)(66556008)(8936002)(8676002)(110136005)(44832011)(86362001)(5660300002)(31696002)(316002)(4744005)(41300700001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVpzbjZSYVQyK2t2WnlrSnFTR1N5UFF0bkcyTElySjJwTDg2QXc3WnIvNHhh?=
 =?utf-8?B?TUJISWdpanc2dHZ3VG5ZNzJRVWEwZkdSWm1IUnB3UmpNbzRXZU9XZ0R0WmV5?=
 =?utf-8?B?bm5hRXpoQ0VYTUkwbmtGdXFNMmtGc3NQd01FRlVxTlJxVFRaOThCYWwrYmk3?=
 =?utf-8?B?YjNzK3NrZzV6ZEpqNitrYncyekhPU3lIZFl4VVgrc09IbTNkVHp6bytGQysv?=
 =?utf-8?B?NXR5OWEvN1A4SERTWjZlRmVxbDdhbkovZW01WG9GRnRCUEJ6T0ZwWXdrL0Vs?=
 =?utf-8?B?YkNSVkF5UkxDSDdkZVhQVzZrVU9LWUVVUHh6dkNabmhEVmtxWnNEZ24xWTVI?=
 =?utf-8?B?a3I2Y25qR0tEUk52Y3g3a0VVQWY0OWFXd205bnpEVUtKNnNyWEJJdWdLekt4?=
 =?utf-8?B?TFAyejkvam9MREhKRUFNMU1KTHdKb3lBY0JFa2VVTTBDbENyWDQ5dVZCc1hj?=
 =?utf-8?B?R1poaVJWVVpQc3RGVTNTZDlwZW5LRGR4dmRzbHMrNDROVG8yYTNQQkJud05j?=
 =?utf-8?B?QlFObTlGczVSU2d2ckp5R0tEL0VkZm9oc2VFekVQeDJKTUtSdjRpTmNIS2FO?=
 =?utf-8?B?aHZoR2NxVjZOZUxVYnZTYWc3eDdNWWhtREdNUStHc2lud3VrTURMZmZ0NVMw?=
 =?utf-8?B?M2Y1Vm1ZREhvcnp1UVpNOWppM1BIdFpTemhzclA1TDlENGZKOE9lS2xHUHBa?=
 =?utf-8?B?RVBBanF0Y3duQmZaWWxRaW5oRDhva3g3QS9ra0J5SEU5bTdHNTRaMWZLTTBT?=
 =?utf-8?B?b2R3RnRKZ1FVUHlsZWkxSFdGbDZ6cEFYMVJnVmltdWptVFFMV05HN3BqWno1?=
 =?utf-8?B?WnJKbUJNc3VjYUlUcjdMTjJqc0ZjaVNEWDFvcUpqR0pjT1l6bGNxczRRNlo2?=
 =?utf-8?B?RGNvVE94V010Z1NTdW1kWTNoQTNlRFlrSFZ1Ui9adS9GcWFYdndwamN4V3o2?=
 =?utf-8?B?TlR5TmE2dzFVeUdrK3U3S2orVkJRTG5NN2hvQUdtNmZSZmhpaWJZQ3FkNjJT?=
 =?utf-8?B?L0luSjNld1JpakJHUHVsbTI0RmdMUDFuSEpHbTk1dWh0a2k2TS85QjJDYWNC?=
 =?utf-8?B?K3RYWWtNOEtxY1BVNG5DUnk2VGdZeGlOZ3ZhSUwrRzVDdmJMTk1pb2M2NVdR?=
 =?utf-8?B?V1RJVUE4aXZhMHJhWTdZZWNUWnYxOXRGT3d2aEtwRVhVOHYyckFNdmh0MGtq?=
 =?utf-8?B?V01vajY2YkJaeURSd0ZCbllWanBibVYrOVBKMWhRTkdiV21hajc1UHZKMzd2?=
 =?utf-8?B?MjlkUDlKZ2dDbzFCalVodFRtbXptQ0wyMUVFWEZEZHMwd2NUUk1wOVRJeTF2?=
 =?utf-8?B?cERpRzFTVzFUVmdaZzVaNWxubHB5VHRWUHhGZjdSZS91MG9FTGpKZlBXQmla?=
 =?utf-8?B?SWovc3UybXZZSzJpblowbFNmUUoxNWZkbVdCYTlZMWRCUWMvTjBqeXlzWHhv?=
 =?utf-8?B?UzhVQnRsenlxSFN4UVhaanYwQ0ZVWlNZenRwcitJYlNnMzU5VXl2a3pUR2dr?=
 =?utf-8?B?K28zMVhNS09aWTZlemM0RmYwQm14M2tDQW0xNzdYdFQwY1haQ2h3NHFlMytj?=
 =?utf-8?B?SWJlNGlNdm5ZTXlySzdxQ1N4UldhRVNQL1BQVFdZdHQ5ZEp4YzdsVlljUzNK?=
 =?utf-8?B?TkdSL0ZOYlRWTTFjOUtHYzJQTVNKSGFjUVJibVYydm81WlpRZWFLeVQwazc5?=
 =?utf-8?B?Ynl6Y2M3Nzh0K01aRkg1Tkl5TGlEc2IwV1BSaEpuWURmcWxOUzhscFRkZkxF?=
 =?utf-8?B?VS9CN2thSS9PMVpsWDZtQmpWUVFtRjllcmQvZkdERHZIRWw0YkpPcEJ4eVY5?=
 =?utf-8?B?eS9kYWZRQWFyRGNzaGdIbm90Ylg0TytCa2lGOHNtSDZyRjcvTVlyaHN2M3ls?=
 =?utf-8?B?RTU2UUlaTVBoblFwUGpxTDFMdWI5dE1CZHlLTWlKOFl6SW5NQWc4QnptR0M4?=
 =?utf-8?B?anA1bXJOMk5EYU9JUXJHQy9MMzUreEhtMnB1ajdkbFpDbkw1aUk1WnU4RHRT?=
 =?utf-8?B?MFpOcnF3cGhXaDBISm1DNHZaUi9uN3JPQUdwZmxOZXRNRlpOVVIvYURPRkZ3?=
 =?utf-8?B?U3pSei9PVkd5Y01pcWRodXdLUlRnRk9wejR0NmViNk5qM1l1ckpPQyt3VXAy?=
 =?utf-8?B?cUI2V3pTMGtmUk9XOGZkSWNhY3JtTjNQUHhQdWdMVzlRTTFBUGw4WVhZR3hr?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f925ac83-b6d0-4852-f858-08dbf268d899
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 12:27:12.9546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Zq1+nOr353CwkekVXiqymwPvG2k3UNpI8torX1aI/KGsTo4tF5Uz2BP1PSCBnx1T9vHcP6rDdKkbhF0CMkjUNv0pP1bes6aN/hQb+jtqC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7526
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 6th of November 09:00 UTC
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiAxMi8xLzIzIDEzOjA4LCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhpIExpLCBBbmRyZWEs
IGFsbCwKPgo+PiBIaSBBbmRyZWEsCj4+IE9uIEZyaSwgRGVjIDEsIDIwMjMgYXQgNzoyNeKAr1BN
IEFuZHJlYSBDZXJ2ZXNhdG8gdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0Pgo+PiB3cm90ZToK
Pj4+IEhlbGxvLAo+Pj4gdGhpcyBpcyBhIGZyaWVuZGx5IHJlbWluZGVyIGZvciB0aGUgTFRQIG1h
aWxpbmcgbGlzdCBhYm91dCBtb250aGx5IG1lZXRpbmcuCj4+PiBBcyBwcmV2aW91c2x5IGRpc2N1
c3NlZC4KPj4+IFRpbWUgYW5kIGRhdGU6IEZpcnN0IFdlZG5lc2RheSBlYWNoIG1vbnRoIGF0IDA5
OjAwIFVUQy4KPj4+IFBsYXRmb3JtOiBodHRwczovL21lZXQuaml0LnNpL2xpbnV4LXRlc3QtcHJv
amVjdAo+Cj4+IERvIHdlIHBsYW4gdG8gc3dpdGNoIHRvIEdvb2dsZSBtZWV0PyBhbmQgd2lsbCB3
ZSBoYXZlIGEgdmlkZW8gcmVjb3JkaW5nIG9mCj4+IHRoYXQ/Cj4gR29vZCBwb2ludCwgV2Ugc2hv
dWxkIGRvLgpZZXMsIGdvb2QgcG9pbnQuIEkgd291bGQgc3VnZ2VzdCB0byBrZWVwIEppdHNpIGZv
ciB0aGlzIHRpbWUsIHNpbmNlIHdlIAphcmUgcmVhbGx5IGNsb3NlIHRvIHRoZSBtZWV0aW5nIGFu
ZAp3ZSBzdGlsbCBuZWVkIHRvIGV4cGVyaW1lbnQgd2l0aCBHb29nbGUgbWVldC4KCldoYXQgZG8g
eW91IHRoaW5rPwoKPj4gSSdtIGFmcmFpZCB0aGlzIHRpbWUgSSBoYXZlIHRvIGJlIGFic2VudCAo
c2luY2Ugbm8gbGFwdG9wIG9uIG15IHRyYXZlbGluZykuCj4gSSdtIHNvcnJ5LCBidXQgdW5kZXJz
dGFuZC4gSGF2ZSBzYWZlIHRyYXZlbGxpbmcuCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4+
IFRoYW5rcyBhIGxvdCBmb3IgYXJyYW5naW5nIHRoaXMuCgpBbmRyZWEKCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
