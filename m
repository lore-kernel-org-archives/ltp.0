Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31A0C54EE9
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 08:54:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A3373CAD29
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 10:54:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89CA83CACE2
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 10:53:54 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D7E7A1000B55
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 10:53:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqeVWy7cDd4vycFW5usE0tIRLJ2nm9Sr5lX2mnx6yiU4MkEGtX0mt8WWnnpUomyPZysbJXFsbZ5dD7/1JCfHHV2v4nVF8vfs8uoBN0bPMGnblwi6dJxH28ihANGENCLzGOiGPkW44gQ4RHDzXlGgTman8h+15QS7tg99FzISxIPb0RqXLi6VkLCXLP835/Xh9rfvbXsHGCvDrEpU7zTBcYypvKUibUh5yq7BUhySSp7AFz95pR9ru6+LKBgsrVfootHqXbON6urFBGOHGA+P/h/9Tgi9y/G9XSbH2Bmo4U1oBQ5iVhIgwahcDK5+y+dGCz1hetE2p5mPh03oC2b+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iwj27F3vgLQBJPYjvp27IZjZVnL7TCTtCgNQsXKvawE=;
 b=cIwQ4CxiPDXeJQZrM/itiAnZ2xtmudoQIhrqzdak5B7m5CkyEfMJGCwXeWNdKrumW8y0/GICvagcxDzDwULFLAu4mtbcbW9reUXjQOkOzKpbnlo9zfGkxsaOHUXIM2kUbvAeuPwLM+JIYG4l/P37QZE0dx7sXs2truoChvT22q1+ZkhdJq7a8lx6LmkEitnQmk63EHAFE83CEilMHLcOW2dwkJKsaJeasVOVbmuqYgC0GfNjFLZTaNLtLczR1H1tFY/AsVbGeGuDNoTo3dR40h6w84aFTjA1Cz1LR9ws+aVmwHF3aNLSLTA4rUMMgKDrNqDPdqNFtOkR5r2pc8VENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwj27F3vgLQBJPYjvp27IZjZVnL7TCTtCgNQsXKvawE=;
 b=aiJx9JZbwerUd25qt45alAaVB7nfICpHJiK3GhiTG8224hpsUsICXCM9hZFpU2y5MYJmiSJwdhEQzmwVN4M+7+OX6XZ8UnUr4HfqZvVcZTjQ8eCwmHBcyrVsC2w2Il5eRp+Uc8ECRhlx7KHhZLaj0KVKDxZkB6CXvHvjkCFOuITZdE/6Iw/DGIJr06sJmltQxg0uKV7lP9PIuXChUIU3AglQmvCIZ62Pn3ifvxvOsaWCk+el/gsnAPm646SgL3mBTy4Sd/9AjQUH0/4SAeaFluH/5Hzk87TgsLV/EyrfhZB5nepEuqKmaiUg8/pLAES29G/HhESc2FmfnlavwV/hDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 08:53:52 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::41c2:c368:6f78:7518]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::41c2:c368:6f78:7518%8]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 08:53:52 +0000
Message-ID: <429c8473-2040-fd45-3b14-0462464857cd@suse.com>
Date: Tue, 20 Sep 2022 10:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Jan Stancek <jstancek@redhat.com>
References: <6bac7035adc2cfc8ab3800fe1d2d03223ec57ff5.1663662348.git.jstancek@redhat.com>
In-Reply-To: <6bac7035adc2cfc8ab3800fe1d2d03223ec57ff5.1663662348.git.jstancek@redhat.com>
X-ClientProxiedBy: FR2P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::15) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|VE1PR04MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 59eaa840-e63b-4b56-733a-08da9ae5a443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHfiXvDVSwBYKbph+d5W6pheCqxhlNqi2vPhlDaCz2xVGvUbh/ljxPxLrew1zQZaDwtqcp+mP4Il50WwzBJU6bkDfcPlEe8zgDWJ2Y5e/RgGA8S0hOJS8Y0gYiHNUX4sxaPbBSS2XAd7riTeFS6tj6WIfYL3Qz5kH0laXeW+ZQuW+FqGHDQYRpDAqgmVq+GQGfL6vJ7Ud6B6g5xlaxS7vtQHPcxYpdIgs1zI+0+ZsfcZ0fdH0F3d45DzrKRpJIeH3p+lasi8vLlKnSg8gcwySXDMi2Y8gEvjgZf2Kf74ee5WO/sPYXU4VqtAG7R0rZs3aWyxylqOjomOfNxl5TTVPZsXj+P3dFfFRIiuFhxYXjd84FAQ0q0nJivQqNn/N/fO1J3OnvgElGSqEU4+D/v39Y/G+cjPEnbqpJ85YWd6w0CJCz261dVIi23zKHNZT4FxnpbMs3Q0fvPTra4KFD5n8VI2Xk6xuNT5TkfwM1flxSbludGD1JQXLfr4lQhZ5ClKPAiN38qTspH2gxoJKjaLYnmh+kJRKGx9+cCM68dMMNdTIXomR7AN6wCqY+Rze0Y/ttFF1nNzg9HuMS9TmhvUqaCVLZCKWhy1vpBCt1DK2cW30PooSb9PwJdLGro/Rvxu7oHaae91j9YXhz4/cbRMfuvkFg0aOC8ewLeq0Vc6Yr8oSF8NmikZ5AymFcq2LAUXnuPaTMFWVvf/a4XmSRsvo/YtKzfR8nGD6Q5EexWS1bvGDrMSnEkCBVI2OGKfVt0e7IJL/dqa8N1HBW0DPtGJTtbURvmNDgzFb2iy7FbzpBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199015)(31686004)(38100700002)(6512007)(26005)(6666004)(6506007)(8676002)(4326008)(44832011)(2906002)(2616005)(41300700001)(53546011)(186003)(5660300002)(36756003)(478600001)(86362001)(8936002)(31696002)(316002)(66556008)(66946007)(66476007)(6916009)(83380400001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEdDRWowdlNlNE9qN01QdHJoYmZaZXdVdDVVZDIrQ1lpR1VOcDYyTzF4akdl?=
 =?utf-8?B?MnBXbHhaWjV5cUhUeXV6dVZEbGRmWVlwYXlmZFNlZW05MGpKOTBPSCtvZi91?=
 =?utf-8?B?aFVpNDNtZ2pnSzBiTFU1YmlHNWxBMU9LNDdnNHVtRlNsTm4yOVRtRGNoK3RF?=
 =?utf-8?B?SmJpUTJMVEFockdwd3VPTGxBZitDMkRMS3NSeEVzM1VDNm8vWWFxeThmdytL?=
 =?utf-8?B?SHZmMnFZeUFmUDdGZXhsZnM2a0NYMjBZbVVPa3Q0aWJiWnFMM3JIVDdLYXkz?=
 =?utf-8?B?dTJYZnFQSkR6V0ozZlYxRUo0c1RnV291a1FLK2grYXVGbXFycCtHQ2lnVXRm?=
 =?utf-8?B?S0NWcHY1d0NzVFJNVndTVmhNS0Q5V252dE5uLzd5Q3o5VWRhU0dwTGdQUUd1?=
 =?utf-8?B?RUoxWlIxNUdidlFkLzJtdFRZNGFZcnJ1ZkpnUzUwR1h2N093NS9WUHBleC9H?=
 =?utf-8?B?SWVwODU5c2ZvZXJVMUFWOGdOL292cktHaTRRZW1NcGN2KzJjS2ErV2hYRDBj?=
 =?utf-8?B?d1BWYjJTUzg5RDNLOXVzRmljMUxGMUYyc3JocnNYMUYwV3R5MlhtcHFMaUEx?=
 =?utf-8?B?djN3YmxJWlpEUWNVbnI1MnZZRlFBSkp4YjNiR1NSMVZWa3czNmdvOFN3bWFh?=
 =?utf-8?B?ZFEzbUt2NHRmYTZkakRqejdGWGEwQWpPclBHU2JMK0JUWXpZcUM1cWhZMGll?=
 =?utf-8?B?ZjRyd1h3ZWxwRHBhN3NVaWFkdEpFU1htS1d2QlJsOHZJcGk1TWpSZWRtUlVF?=
 =?utf-8?B?enkwR0NYZno4QTN2T1duY0hJblRJVzVacDJreFMya3lTWjZ1YU56YUdQVzgw?=
 =?utf-8?B?Y1Njc0pyeGVWeCtjMXpVQ0g4QXJpeHlzd3YyUWVXZE9jc3pGcHFNamd0Z3JM?=
 =?utf-8?B?aVpvWDhvVWFiczM2dEgyQ0lLL1ZtMnhvR0pPRXc1VzRSU0VCMFZKN2Mxbk5M?=
 =?utf-8?B?V0NSd3FrcHBKdVE0ZC9KSzQyajg3NkFEbFVPcUdUWHNSbWR3VTJEK1RYckRW?=
 =?utf-8?B?aHRIV1hPOTQ5aTlIRnJZS0k3UG9qYXhZS0wydGtxdjRwRGRoOGZoWFp0aC94?=
 =?utf-8?B?R2FJVWdvNWduZTNHQVYvbGZkaW4yMVhWZXpoZ0k0aHlWMVNGVWQ1QU9sbVd4?=
 =?utf-8?B?ZzY4amxFSWdRUWdlRy9FckZhdGFiV0pSSzFuYllBUjZEVWdjZlI5U2o1M2N1?=
 =?utf-8?B?MnIxNmZXRi8wWjh4U2JEMUZ1R1JnTDRVSjRTNUNRYjJOdEpZaXg3ZUxRNmVQ?=
 =?utf-8?B?UWpNK2xYSitvYnE4d0VaZHBEWnJxa1lsTlU5YUxuMnNjelQvTmlqd2pNa2hu?=
 =?utf-8?B?RnJCaXRFYmRnOGYvUHpmQklPRGpqMVdSbmYyejdPMG44VWIxd3lEVitxR3U1?=
 =?utf-8?B?aEpsdEhuUk0vMXF5VWtlSmpqRDNIekR4Rkh5Z1FSOVNKYUdIV1ZUOXdqc3JM?=
 =?utf-8?B?MHJtR2wzOUZSUHZYNDE0N0kvNnZiZzJweGxGZHhhdHFTZTA1cjlHblY4b0Za?=
 =?utf-8?B?a3BEekVSdGxHV0d4S0E3bWYxTXNxcmlZbjEvYzZ3ZXQ1VEtqcmZrT3pabFBU?=
 =?utf-8?B?ZzIrU3MvWWNBYjgxcno2TllPYjh2c0dJUE1kdXdMMkloa21xQ2FMWUJ4TGpD?=
 =?utf-8?B?SmFsVFd4eGVKY09YZnJYL1FFcEwxcy9oQkxQQUZ0WHNmSVpoUHB1UE8zekxj?=
 =?utf-8?B?d2hJK2J0RjNDOU84VTBndmpkK3RpOENyN1MzR1VTNnRzM1lZOFhnU1drNkNx?=
 =?utf-8?B?dUY5WGthV1FFYm91c01oMDVTd205WTdJRmZCTFlrTDZZSHhCcXlUVkQ1QU9T?=
 =?utf-8?B?N1RJYUlYT2JQQkRYMDVlc0l4aSsrdnRGYmdHWTFCdUdhcSthT3F3cGZjejR3?=
 =?utf-8?B?djNMTXphOWhXK2tGNThtUVdZS1NDUVlwNkQ0ZWRlT0xpbWJWejYxN3VDbndR?=
 =?utf-8?B?dmFBaHdqOFQ5eTA1ZDJQcmU3R3hPeEJnK2t4dnpWbXFQZktRZHE0cTNkaDJu?=
 =?utf-8?B?TUxCYTJaM3gvOC8ybnZxeDBDWFdnKzIxUzdkekJrY0pUUEJMRUF5MVA3bFl2?=
 =?utf-8?B?MU5QRWwxZ0JGd2IrS0Jib3Q0eS9POGwrWkRSVURpL1V2ZHBCcHByM2ZzWU5F?=
 =?utf-8?Q?H5k8Xar462HSbgxv2hUbI73w9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eaa840-e63b-4b56-733a-08da9ae5a443
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 08:53:52.2449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVmkHAeP4GydCaxU6SPBPOBY2bO9MBVyBtYvEdZvsUX+FcF8bLGW7CppRoxfzvgZryWs7oWcajGHCghzOG2O2ZCiOlT67Q78LdboEgJ/aaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7374
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/futex_waitv02: replace
 TST_THREAD_STATE_WAIT with repeated wake
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

SGkhCgpPbiA5LzIwLzIyIDEwOjI4LCBKYW4gU3RhbmNlayB3cm90ZToKPiBTYW1lIHBhdGNoIGFz
IGZvciBmdXRleF93YWl0djAzLiBUU1RfVEhSRUFEX1NUQVRFX1dBSVQgaXNuJ3QgcmVsaWFibGUg
dG8KPiB0ZWxsIHRoYXQgaXQncyBzYWZlIHRvIGNhbGwgZnV0ZXhfd2FrZSgpLiBmdXRleF93YWtl
KCkgY2FuIGJlIGNhbGxlZAo+IHByZW1hdHVyZWx5IGFuZCByZXR1cm4gMCwgd2hpY2ggbGVhdmVz
IG90aGVyIHRocmVhZCB0aW1pbmcgb3V0Lgo+Cj4gUmVwbGFjZSBpdCB3aXRoIHJlcGVhdGVkIGZ1
dGV4X3dha2UoKSB1bnRpbCBpdCBmYWlscyBvciB3YWtlcyBhdCBsZWFzdCAxIHdhaXRlci4KPiBB
bHNvIGV4dGVuZCB0aW1lb3V0IHRvIDUgc2Vjb25kcyB0byBhdm9pZCBmYWxzZSBwb3NpdGl2ZXMg
ZnJvbSBzeXN0ZW1zIHdpdGgKPiBoaWdoIHN0ZWFsIHRpbWUgKGUuZy4gb3ZlcmxvYWRlZCBzMzkw
eCBob3N0KS4KPgo+IFNpZ25lZC1vZmYtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQu
Y29tPgo+IC0tLQo+ICAgLi4uL2tlcm5lbC9zeXNjYWxscy9mdXRleC9mdXRleF93YWl0djAyLmMg
ICAgIHwgMjYgKysrKysrKysrLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2Vy
dGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZnV0ZXgvZnV0ZXhfd2FpdHYwMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9mdXRleC9mdXRleF93YWl0djAyLmMKPiBpbmRleCAwYTBlMmI2MjA3NWMuLjAwY2YwOTYw
ODA4YSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Z1dGV4L2Z1dGV4
X3dhaXR2MDIuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnV0ZXgvZnV0ZXhf
d2FpdHYwMi5jCj4gQEAgLTUwLDE5ICs1MCwyMCBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+
ICAgCX0KPiAgIH0KPiAgIAo+IC1zdGF0aWMgdm9pZCAqdGhyZWFkZWQodm9pZCAqYXJnKQo+ICtz
dGF0aWMgdm9pZCAqdGhyZWFkZWQoTFRQX0FUVFJJQlVURV9VTlVTRUQgdm9pZCAqYXJnKQo+ICAg
ewo+ICAgCXN0cnVjdCBmdXRleF90ZXN0X3ZhcmlhbnRzIHR2ID0gZnV0ZXhfdmFyaWFudCgpOwo+
IC0JaW50IHRpZCA9ICooaW50ICopYXJnOwo+ICAgCj4gLQlUU1RfVEhSRUFEX1NUQVRFX1dBSVQo
dGlkLCAnUycsIDApOwo+IC0KPiAtCVRFU1QoZnV0ZXhfd2FrZSh0di5mbnR5cGUsICh2b2lkICop
KHVpbnRwdHJfdCl3YWl0dltudW1mdXRleCAtIDFdLnVhZGRyLAo+ICsJZG8gewo+ICsJCVRFU1Qo
ZnV0ZXhfd2FrZSh0di5mbnR5cGUsCj4gKwkJCSh2b2lkICopKHVpbnRwdHJfdCl3YWl0dltudW1m
dXRleCAtIDFdLnVhZGRyLAo+ICAgCQkJMSwgRlVURVhfUFJJVkFURV9GTEFHKSk7Cj4gLQlpZiAo
VFNUX1JFVCA8IDApIHsKPiAtCQl0c3RfYnJrKFRCUk9LIHwgVFRFUlJOTywKPiAtCQkJImZ1dGV4
X3dha2UgcHJpdmF0ZSByZXR1cm5lZDogJWxkIiwgVFNUX1JFVCk7Cj4gLQl9Cj4gKwkJaWYgKFRT
VF9SRVQgPCAwKSB7Cj4gKwkJCXRzdF9icmsoVEJST0sgfCBUVEVSUk5PLAo+ICsJCQkJImZ1dGV4
X3dha2UgcHJpdmF0ZSByZXR1cm5lZDogJWxkIiwgVFNUX1JFVCk7Cj4gKwkJfQo+ICsJCXVzbGVl
cCgxMDAwKTsKPiArCX0gd2hpbGUgKFRTVF9SRVQgPCAxKTsKPiAgIAoKV2h5IG5vdCB1c2luZyBU
U1RfUkVUUllfRlVOQyBtYWNybyBpbnN0ZWFkPwoKIMKgwqDCoCBUU1RfUkVUUllfRlVOQyhmdXRl
eF93YWtlKHR2LmZudHlwZSwgKHZvaWQgCiopKHVpbnRwdHJfdCl3YWl0dltudW1mdXRleCAtIDFd
LnVhZGRyLCAxLCBGVVRFWF9QUklWQVRFX0ZMQUcpLCAKVFNUX1JFVFZBTF9HRTApOwoKPiAgIAly
ZXR1cm4gTlVMTDsKPiAgIH0KPiBAQCAtNzAsMTYgKzcxLDEzIEBAIHN0YXRpYyB2b2lkICp0aHJl
YWRlZCh2b2lkICphcmcpCj4gICBzdGF0aWMgdm9pZCBydW4odm9pZCkKPiAgIHsKPiAgIAlzdHJ1
Y3QgdGltZXNwZWMgdG87Cj4gLQlpbnQgdGlkOwo+ICAgCXB0aHJlYWRfdCB0Owo+ICAgCj4gLQl0
aWQgPSB0c3Rfc3lzY2FsbChfX05SX2dldHRpZCk7Cj4gLQo+IC0JU0FGRV9QVEhSRUFEX0NSRUFU
RSgmdCwgTlVMTCwgdGhyZWFkZWQsICh2b2lkICopJnRpZCk7Cj4gKwlTQUZFX1BUSFJFQURfQ1JF
QVRFKCZ0LCBOVUxMLCB0aHJlYWRlZCwgTlVMTCk7Cj4gICAKPiAgIAkvKiBzZXR0aW5nIGFic29s
dXRlIHRpbWVvdXQgZm9yIGZ1dGV4MiAqLwo+ICAgCVNBRkVfQ0xPQ0tfR0VUVElNRShDTE9DS19N
T05PVE9OSUMsICZ0byk7Cj4gLQl0by50dl9zZWMrKzsKPiArCXRvLnR2X3NlYyArPSA1Owo+ICAg
Cj4gICAJVEVTVChmdXRleF93YWl0dih3YWl0diwgbnVtZnV0ZXgsIDAsICZ0bywgQ0xPQ0tfTU9O
T1RPTklDKSk7Cj4gICAJaWYgKFRTVF9SRVQgPCAwKSB7CgotLQpSZWdhcmRzLApBbmRyZWEgQ2Vy
dmVzYXRvCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
