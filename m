Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A41C0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 07:59:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B9E43CCBAF
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 09:59:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E6803CBE8F
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 09:59:42 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 49CD620005A
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 09:59:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfXgOL+zvSZA7x84sn0Us/+1GyBDfxM11FHAyPVe+lxH4iEFVNW9ChVBfRz9/bpLkXHbFr7flWWnSW7WYcaC0IA6WcBUTSgcN5oi1J3gJjqKh17+BASLBLgG2HrHex2c3laxVIeER+M4PSqTOoy5NY16MQKwbR47TmWbzXEVET+Fy9mU1qBI/ao49wmBFREpIUJwuXdRRHUiB+Y9KhiGrp11xy0CS7vpPpwsywK7BLEW047Ri4z4Jg3F9/gv881EgU34pczffpEQceyhrrXj0lUqF6kcRbz3vG0yBYu44LRXnCnHMEoFmVdm84HQOo+pbXBHz3PN670hEJ0Vn9+r9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3vzDodaArFrCvsffx1koPvwWsudahh1Bwi4MLHXmoY=;
 b=GtAkSxPIfDNTie5EtWVoaSgMUHpguqKKR2pWgIOAK6OILLkOxW33p+GDDy7RiNkpix9FPN6VUvjrTdDq5fE4LyGUJvzH2ODobW/HRovqKjquFdwmWDaa8+GBXPT1rFiUVZrzvvRw13F0LWXSSrRohtQt0WbVII7sCbDXUutv6lBvb4vpOoSy2b2vYPFSU4QHKmstOmudO76bum0FVXqXm1lChZ7CdSKLlXZHAldHQ33e4PlgX9vXO594Lx3PqXbYk8uEeq4NhHE+pQ33manpO8tHy0RMhKcG0sl17WNLsU8gkTcgZ/1zfvD+codZ14gP0IW/0Mdw0gRe87Fnt4j5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3vzDodaArFrCvsffx1koPvwWsudahh1Bwi4MLHXmoY=;
 b=KQFOdPDOa3cO2jJHWKgtb/Z4u/vC60vr6rKH9tg7G1w16JS7F8+CCtpBFUT4OnYHFzanTA6kVdroZjhKzUa7jKTkAep/goGUWTtDMTx3HLc8m4+r4V3wsJYxk+WcrKsQjrqNLDptJ3Lk3RTdo7gA2FBRxT8uo/9UC0wh604EjliAEEP5+5NM3XfGBsrghxIxFCg36shagkGzcmJTkNBNQqxpWSatN3f9UURdEVtgG4eMyqFIKYEJbHFwn3BN4m1aKwZ3aAIQ2i0XvQm08PJ7z3R5xPSIrTlyTQFfGQnHXFD8ODVLaj9nRWBSGK5181ZdXxbDCThjjcNZmSEFOAOdpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 07:59:38 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::fe32:e823:6c2a:ec3a]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::fe32:e823:6c2a:ec3a%6]) with mapi id 15.20.6933.011; Wed, 25 Oct 2023
 07:59:38 +0000
Message-ID: <4a52b7ad-5cf6-43ff-86e1-b02b2cd143a0@suse.com>
Date: Wed, 25 Oct 2023 09:59:36 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20231018014832.1632063-1-Xin.Wang@windriver.com>
 <CO1PR11MB4979DDFD87F04B88FE28AB7B95DEA@CO1PR11MB4979.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB4979DDFD87F04B88FE28AB7B95DEA@CO1PR11MB4979.namprd11.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::15) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|GV1PR04MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: fff8f65b-572f-4ef1-4efb-08dbd5305603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlQ8bJtTElzisk+Ndt1QjwCCc8W0b+RSybGDI7W0ktXpTKEt6VuCUMuscXICp7W0Zjm6jGKKmPGY1uOB4ZBrNNmF/RDFaWwMWvzn0RDgLu5cQAPoNd4lFM36wGPomwUm7PlrteemU5cRmD+0mHpb/Xw/S0Ud5gKB91XzJ6EG0QfUhAhSu/RGfeI12k/GhYy97RoHgnoi0BIFvvt6xILSfw0GFhRC2iM5qDYN+SBGTfoxCviBZCpCHtynpmXxmtkFLbYPgkQXdMHRna4MPs4O/pBD4kCLuGjR6fn429UB1T4M5BHq/waMNqO6GL0t2km94sBphxKyM4Bej3oDgWzFvR3ABZ/Cpe+a9f/WVEAWPkKifSHAueFcPUMVkCfvs2IS/ZiO0ybt+9ereMwacn2raE9x4s5Tf4GN31I3RzrPLAYfbOS9RcV8VuTfIuldyaqQ547pSp0LBS8Ojc/OQNj51W0mTrPi5/k7fq6UXHcaiEsMaXdob6zxWYB30E5/jJpeNKflqM2kwTvTIOvZPUKbAcA54f2O6tArlaBQui2tVlyPU7gb32km2IZ0RVU14cQG7Hl1dyzk5sPfb75dYPXB65N9VXnELbnPzgoHGFy1mXuLzGC3qZjqoDzKcTu4fYy/+U0JXa8XV6YrGFVfNX0Ieg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(39860400002)(396003)(136003)(376002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6916009)(31686004)(2906002)(5660300002)(8676002)(8936002)(44832011)(36756003)(66476007)(41300700001)(66556008)(86362001)(6506007)(66946007)(478600001)(6486002)(6512007)(31696002)(2616005)(26005)(316002)(53546011)(38100700002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJBTTJ4Mzh6NGVFUjFmSEh0bVlZUGd1UHkwOER6OUZlRHBEV1NHK2RyL3di?=
 =?utf-8?B?NlRLSlhKL055YVJXL2NiU0c2ZTBmV3h1cS9FbmRWWTdjcnhVb3R3WUMrTU5r?=
 =?utf-8?B?bm5aM0E2V0s5L3VxdzFZMEFBdk41OGovRzdBRkxGM0pNRzQxa2FPTVkrbEVh?=
 =?utf-8?B?aXNoVXpzWmVLdWRSSk5iUGJwM2hVRUdubVJTb0FxQ0xWMXNXUUNkSzJjNGxm?=
 =?utf-8?B?Yjl3SmlTSGVJSUNMcnZGa09SUjUxTmdlYXc2VUpORi96VVFtRFJQb1hWYWlD?=
 =?utf-8?B?WWs0S0NEQ3l3TFZkTmNMYlI1QUFhZlRoN29uTmFEWmRYNE5nZ0VibTZBWCty?=
 =?utf-8?B?bzVCcEhEZUhtWFJFcThmSFdKWjJlS0ZsVWNFZUZVbVYraFh5ZnBjeGtmR0xX?=
 =?utf-8?B?U2cyeW1HaVcrLzVOM0xlQjdFSXpkRWMrR2VQaE1SOXhMMlhibzBrN0k0MWRN?=
 =?utf-8?B?VFc2OTI3ekNBT2NZNUh4VzQ0MWNuN093NFVZNmwzTWVjemE0cFlpYTlLVkdN?=
 =?utf-8?B?d3RPTXgyWm5udkJhT3RoUkNEQTlBbm9lOVdsTWNCeTBqcWt6MUsxaEVzWUxR?=
 =?utf-8?B?Zms2bUJZemU0QlgwRS9mZjFRdjgrZG5TTXFGV29ZNFlDVUtPaUVUMDFoN3Bl?=
 =?utf-8?B?cFZPZG04Y1lDVUdwL0hKN2dQbzhPYWszTm93ZDd0NStnc2NDdTdNVHhZOHg4?=
 =?utf-8?B?SGZvUUE1UCs5ZFBQeGNHODRRTVNzc09pUFc0L0tQK3YzUmQ1SHBUSE8xbnQr?=
 =?utf-8?B?SmNvYUFQUHdyLzlIL1l3WmNmempsMXd2RENqWERaYkswMFk5eExhQ0hSL3JX?=
 =?utf-8?B?cXllMk9uVWl0YlJjSURDSFkvbHdLN2xjQ0pVVmg4WHNlcHJFdkVhaGNOVWo2?=
 =?utf-8?B?bnVDVHZRT1F1am1rNkk5ZFkvSDlucVdmSCt1WFZ0T2ZHaDdiNzEvZzRBTkZQ?=
 =?utf-8?B?RGk3RHVKRnJYUVF2NTFGQ01tYWNicWxXb095UnlIVFFnZjlXWWdvcFBGaVFq?=
 =?utf-8?B?cVFGNGM5YTZCV2N5ZzZXeENyWmpCeDkzV1JpYitjL2dVZ2NlYzJMb0VGM1JX?=
 =?utf-8?B?OGtqWjB6RWt2TjlreXc2ejlTWWlLSThDR2NrbVZ1NEgvamNJU0FMdnBjR3F3?=
 =?utf-8?B?dSs4Ry9iaDF6RzlWZ2xuT2ZiZ0VPdUVFYzVZNWhoT3NJRDlodHN2MlRKYVNu?=
 =?utf-8?B?RDA2ZVZjS2dlZkNPbHYxOHpNaXdFYU5Zakt1Z3ZuUU02cC9VSVREeXFhRjho?=
 =?utf-8?B?ZXVvOUIzeVVoZFIzUFFEM1NOVHpTRCtWMVpKS0RVcFBjdU1kdzRoNXF1eTdy?=
 =?utf-8?B?V0srOExJOS95VDk2SDRiZldyZ2d3RHRJSCtCOGZXVVlUTGl2ZkhocG5tcGc2?=
 =?utf-8?B?REpaemtucGZqUmpIejk0c3o0TUFlWWdVSVE3dVpsenJhYVVqOVRXbVRXbDdt?=
 =?utf-8?B?NHhIVndPS1ZVdTduVXh6d2FReUdYdlh5M0t4WGZ3ZkZic1B5cWJIWDkvLzJp?=
 =?utf-8?B?bXJwSmtpR2dYS2tmRnFISjdScmkzWkZiaWN1YTdYTVBVeWROL0FGNTI2dENT?=
 =?utf-8?B?NnF5T2puNksydHVqc2RURTFITFdQcTRsWU51c2NiTnQ5RkN2Yk1pdUdYSGMz?=
 =?utf-8?B?RlJneTdnQ24rQkQwTkg2ZklDZDk5NEs5OE11akNJN3NtdS9oc2dNN2J1OFg5?=
 =?utf-8?B?YXg3bm10cjNOalk4QnVUazUxbXVjaU81TmtQVkFZNytQTTB0ZFZnaExCQUxm?=
 =?utf-8?B?VkoxMzBoajlSMWY3YjJRNzh3NHFQYnN5ZXo5RG94UTRSOFRRZDNmNDdrZEJy?=
 =?utf-8?B?YTVwVHc4Q2hzbXYvR0w4bjBNenhCT0NTeUp4QzI5SXlZQ3c3ZFVFSElSWUIw?=
 =?utf-8?B?cDJjQndwbjZWdndvdFhpN013bnh1MkVPeEJqT1ZWY3lPQ0NGcHBvaTZ2dC9p?=
 =?utf-8?B?cTJzY0lTa05WT1dLVDJxdXV3aUk3U2lhczJGTUZrcU1uNDNiTElDNU1GbGs3?=
 =?utf-8?B?WnUwVHU5MEptZkpOZkdyYTd0OUZ5bE1ObUdNKzJmR2VYVktiUTJGRXUrWmF4?=
 =?utf-8?B?MEpzQ25rTk1PZjVYeUlxY1R2dVVpcmhBeG9sUm9scW5kaDh4NUlocHJod3lL?=
 =?utf-8?B?aXRsaU9TVDlLRVFIejJwUUNuRmJXb0FXRE1nODVzWXp4RnlDbkNzaXQvaHJ1?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff8f65b-572f-4ef1-4efb-08dbd5305603
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:59:38.3275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glSCI9KqZBT68VChlCe8Py2Sn0n0K/y9cvDOAE+L1yU5hLZEP7P6vPboYEtHG0jyuLZ1Vtlz3DeIraNXI1mJsRxWSt0V4jx9LukkMG8IZos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9183
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/1] enable fsx-linux.c running on VxWorks user
 space and add measurement of execution time
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgWGluLAoKT24gMTAvMjUvMjMgMDM6MzIsIFdhbmcsIFhpbiB2aWEgbHRwIHdyb3RlOgo+IEhl
bGxvLAo+PiBIaSwKPj4gQ291bGQgSSBwcm92aWRlIHRoZSBwYXRjaCBiZWZvcmUgZnN4LWxpbnV4
IHJld3JpdHRlbiBzaW5jZSB0aGUgcmV3cml0ZSBzdGlsbCBuZWVkCj4+IGEgZmV3IG1vbnRocz8g
VGhlbiBWeFdvcmtzIHVzZXJzIGNvdWxkIGdldCBhIHNwZWNpZmljIHZlcnNpb24gb2YgZnN4LWxp
bnV4IGZvcgo+PiB0ZXN0aW5nLgo+PiBBZnRlciBmc3gtbGludXguYyBpcyByZXdyaXR0ZW4sIEkg
d2lsbCBzZW5kIGEgbmV3IHN1cHBvcnQgcGF0Y2ggZm9yIFZ4V29ya3MuIEl0Cj4+IG1heSBhbHNv
IHRha2Ugc29tZSB0aW1lIGJlY2F1c2UgVnhXb3JrcyBkb2VzbuKAmXQgc3VwcG9ydCBidWlsZGlu
ZyBMVFAgQVBJCj4+IGxpYnJhcnkgbm93Lgo+PiBQbGVhc2UgY29uc2lkZXIgdGhpcyB3YXkgYW5k
IHJldmlldyBteSBwYXRjaC4gVGhhbmtzLgo+Pgo+PiBSZWdhcmRzLAo+PiBYaW4KPj4KPj4gWGlu
IFdhbmcgKDEpOgo+PiAgICBlbmFibGUgZnN4LWxpbnV4LmMgcnVubmluZyBvbiBWeFdvcmtzIHVz
ZXIgc3BhY2UgYW5kIGFkZCBtZWFzdXJlbWVudAo+PiAgICAgIG9mIGV4ZWN1dGlvbiB0aW1lCj4+
Cj4+ICAgdGVzdGNhc2VzL2tlcm5lbC9mcy9mc3gtbGludXgvTWFrZWZpbGUgICAgfCAgMyArLQo+
PiAgIHRlc3RjYXNlcy9rZXJuZWwvZnMvZnN4LWxpbnV4L2ZzeC1saW51eC5jIHwgNTMgKysrKysr
KysrKysrKysrKysrKystLS0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pCj4+Cj4+IC0tCj4gQW55IGNvbW1lbnRzIGZvciB0aGlzIHBhdGNoPwo+
Cj4gUmVnYXJkcywKPiBYaW4KPgo+PiAyLjM0LjEKPgpBcyBzYWlkIGluIG15IHByZXZpb3VzIGVt
YWlsLCB5b3UgY291bGQgcHJvdmlkZSB0aGUgcGF0Y2ggZm9yIGZzeC1saW51eCAKYmVmb3JlIHRo
ZSByZXdyaXRlLApzaW5jZSBtb250aHMgYXJlIGEgd2F5IHRvbyBsb25nIHBlcmlvZCBvZiB0aW1l
IHRvIHN0YXJ0IHdpdGggc3VjaCBhIApzbWFsbCBjaGFuZ2UuIEkgd2lsbCB0YWtlCmludG8gYWNj
b3VudCBhbHNvIHlvdXIgbW9kaWZpY2F0aW9ucywgc28gdGhlIG5leHQgcmV3cml0ZSBzaG91bGQg
c3VwcG9ydCAKYWxzbyBWeFdvcmtzLgoKUmVnYXJkcywKQW5kcmVhIENlcnZlc2F0bwoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
