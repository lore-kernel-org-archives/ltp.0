Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6F8C4332F
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 14:22:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 172943CAF90
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 15:22:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8B273C0321
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 15:21:56 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140075.outbound.protection.outlook.com [40.107.14.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A9A4B1000A49
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 15:21:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCaf5z25hTgkYsj1a3lUQoj8dbIXq+6+wL05hk5JR3wJ6PWYlKml/TJbtKj0lJJun14SujzVJwI9Q/7niuRslJ++88YRMZWTE6Wo9tc1UEgcGU1YcB5EgvDNof3+QlemLvjDgRlHB8oNA+x0ruuxkeM/gKcf9UfRGcyb3s3RCLPXHa944Wt53b1+BCT70SEsvSroxl3NDovmn7Bz/EbivDKNPy+SMKAYPQro6L0vIhNZd9qikY8pKXvioJw/Z2Yoj2Glkqj9XQ3ay2gnMBoXPpqo0GaAK9xs3ENH/nOaaUWrfa0NA0osBwLtq/UM/EOHEyUWhkBqwZN/xrCUMDvRJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06SF7TtQ3sMrGtfhgHIQ5zk4yz+a08jH8EqwgYos3Xc=;
 b=UP/aC7sTwWfR+ZHnPF1VLZgAT826z048X9aLMnh1q5iiExc6HVGLUz56iPBppR4g1PwLIiQAhJ9j1y7O0qOWzMGudUNb8+WUm6LKJo3qMYIXVNEp17YLVsXFtPlyUWMfFUE/boG+yST9Hl/sIoQkEgj6CFkC5tWjwRZD4nQwivcOvhEASKJ6eggCSZwaTLob5lkKeOVpYBq4G16aFRmfM+hANm6ei72CfRsIIIkoUp9hDURX9a/VQt7TMBYp9fhPzvyB0pkP3F4WvPXMiIbAKZTWzB0jKEe+68HLeA3GQuX7Pi48wFme60ok4jCY+wJb2WZkfKawBwvJNKTUpfcwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06SF7TtQ3sMrGtfhgHIQ5zk4yz+a08jH8EqwgYos3Xc=;
 b=mBqpHdZ3RUl0tV45O0IrJRuO8ggrKT3Jj1ZvXvAbhTo4iipxXog7lhk36P5sVyBGptP5qsYONKCx9gV99RjOH5/wdSK5KW7uJl+Sew01eToU4JUJklCEcI0CG7kbZeimQVItvLDsTgXF4h2D7hbzUNKEu9SVhmZiCJxkqOMH1DqF7wvKuxHKJCzDhEdcl7eFrUT/Yw0cB69JXBwb5SFmOtTKJNSNiWD+5lzKAbJU5vX+FNiGnQt/+j5Kci6uBz3WBzfZiW3Nf4477a9So10uMQGqAoNUW2BWEHRQgWCUJ3n0DF+by7sawCW3in+DubwxctZI0mFSjDLjieyi+YtvJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM8PR04MB8001.eurprd04.prod.outlook.com (2603:10a6:20b:24f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 14:21:53 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257%5]) with mapi id 15.20.5769.019; Fri, 4 Nov 2022
 14:21:53 +0000
Message-ID: <6597b3e7-2f24-6d6d-e0f9-976251518e21@suse.com>
Date: Fri, 4 Nov 2022 15:20:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20221104092411.5446-1-andrea.cervesato@suse.com>
 <c9a2c8ce-9dfb-a001-fa93-10a669c0e228@suse.cz>
Content-Language: en-US
In-Reply-To: <c9a2c8ce-9dfb-a001-fa93-10a669c0e228@suse.cz>
X-ClientProxiedBy: AS9P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:532::16) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM8PR04MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: b2338c35-6b8c-453b-09b2-08dabe6feba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pml//GRJgupbwQAk+jD2p7RRSTXfR0eZMUYTwVPKvythb0sKvmT+Z3qe1QS0EDnmbmtm+rbkaBU30PNAY6UeUShdh9K4uDmMUeU9c4HLeTboqnM1Nu6kBBqnyFtq+8pPgHAVD2zenuVIcngsukFgYhF8ygJBsiVcbjQR2JrK7I+L7igji/8GEKKEsw3O/zQjtZ4Sg1Qs1Yqvcz7huDuZoIPX35PE9ztxKwBU1vZLNoskPAD9kr+KX1D7GoRJ0Zj17wBp+k4NPy+EVyqhQsI8oI9iaqinq+dCyXxv9je7aUm9E0pBIFfVx1bCGXVjB5TD14v1OQuWkrYpJQQZkisA3E7molvlOZ6k0mB4dmTmHMdvb1fih9zMkIj21TANsscKs4PmU8Nyg69UqGwK+YsDZ4JG2qBUkQwd29UNaHWDkzx13B0myFQBOIZre6UvVcKE3YzGIiqE/6XznCOnM4LoY3u7L+qvvgW7NaNobgauHQogPzMPv+tF3mLjghlC2M51LHTGbxREQtMFY3iiFuYFT2/IUHN22iivD9b7Z6lUv2dmM4goW379pi5NTtIbeFJcxjvxm0TdN0ONOu0lmiIozx7wTNi5wI7ChJEnrmWgbM085AqKKmbx1LyGuMKPP/1MDf7d6dGm4V8RPv8XLVc0LxcVjaKw+ejtT7ooT9rZNb/QCR/8FDOfpDJpZB5Iw9cbT4QwBV/cTQMkCpGbkSkwjnr1Vx5MhWQzvW4HapUlPlpKMNGRmHWdIzqS4ez+x40I8lRTerYT/pLvaGebZT8j0oWJX+Sd2yfGXbyxwxgMcYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(6506007)(31686004)(26005)(6512007)(6666004)(53546011)(5660300002)(478600001)(44832011)(186003)(83380400001)(2616005)(8676002)(36756003)(66946007)(38100700002)(316002)(6486002)(2906002)(8936002)(66556008)(66476007)(31696002)(41300700001)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTRvUWtJUmVxNkFjc2hwaU5GQVZ3ZFgwZE95SzNSVHRvU2JNMWFEWWdPaG5u?=
 =?utf-8?B?RmZOazdGUXlHV1pPaURCZ0dNWW5qZk9tS1lKdWNLTTZ3YzBVbFEyUmZJZ1Vt?=
 =?utf-8?B?WnZuNGJtN0hCMEpmRWlxdzFVaHdiZXdPN2VCV3BLTzR3aEtVc0RFc0JaQUlv?=
 =?utf-8?B?UFNyYUtQeU0wc1R2TFVMSE44V05QTnI2cjJjdW9lbTQrVG51bjgrRHp3QXVY?=
 =?utf-8?B?cEpENkVlNmFGWFh5N0RSZU5pSmRjOXJNYURIc0MxT1RWQVdwU0ppMTh3Qklq?=
 =?utf-8?B?QkpFb1FIZytseUdYWGk5WC8za3lPdnpKWURJOFVBUUk4di9Cb3ZISEwvOG8v?=
 =?utf-8?B?andCOEtsbUhmMWhEVCtwVHpSdWFla0xPU3lpUFJPWmtoVmlrMkZIMWUreXhk?=
 =?utf-8?B?VllkVVRKNGV6N2FxUHUrOTlMNzhpZy9GNldJT2tpZHR1MVZranVCeW5GT1dF?=
 =?utf-8?B?c0VYLy9qR3IyYWJlWWlpSTdPOTFNUjIrQXczazhVN0dTMlFucXNDdjBMRWVO?=
 =?utf-8?B?eXJtRWhRWXNGaEtBMXFrbGxMWkNPR1lPOXhlWEl1MnRaQ2h4WjFOejM1dkdC?=
 =?utf-8?B?enBSOTUyWGFtay9IcVlFNUx3T1A1Rk95aXRHMThkcTJ3aE1sY0ppU2s4dFlK?=
 =?utf-8?B?VTkyTDRMaUlxNlRyR3psUHlhNkIydFRWdzRmOENrZUhhMm1Lb3MrdTFqTU0w?=
 =?utf-8?B?UFAyL3pUOFVRSFYrVmlGdFlHKzd6Z1VST1U0WkxldThyeFpTb0ZCcHhsaEw5?=
 =?utf-8?B?MC8zMS9EK2NUZExsM0ZJQmJMTWt5ckdFWjhIYU04K04zZ0Y5OEs2c001dkcr?=
 =?utf-8?B?NTdIQXVlTmlZTCtVaHVMREc3TEZCWk9ZTElsWWlWTkFCakVlQWZRanZydUxp?=
 =?utf-8?B?a2NQNXREZ1RYZDJPc0YrM1NwM2NUejNOdk11UTJSR2NQUzh2RmVIa3FvaGJM?=
 =?utf-8?B?KzREZWkrM1NVWHhkOUxtRGtCQTRNZmJ3QVJEQ2ZEc016LytSNmJqYUhYWFgx?=
 =?utf-8?B?d0M3QW91aXFhWlhZdVdQTnNVTCtqUmYzWWo0NlZUck1IYTk3YTJXTzMrblNH?=
 =?utf-8?B?ODgveE52dVBTd3NrTnJzMXl3dzhTc2dTc2M1NVRIMXVpd2ZNaStqTVlQY2Vn?=
 =?utf-8?B?M2kwMHVWSHZBMzhqWm02UXFYc3IwQzU2UzFUdVdkQVZLNWN6RCs0dUYxdkF5?=
 =?utf-8?B?SGp6am1zemUrZlphSTQ5T3Z1RlBmajhFVjhiMm5iVWNhSS9FWU56UVF5SHlG?=
 =?utf-8?B?YWJhR1cvd256WFc3RlhjeTYyMUswSzB3T25uMHk5VHBsZjFYRGdWaWl1U2x2?=
 =?utf-8?B?UDZhcU5obFNNSUMyOVBuNi80czQzbzZwZjRhL2ZuVWlGS1AxN1pocHJvRzFr?=
 =?utf-8?B?UENyOFFJRlFZUlBHYTViVTFVeDBZbXFsV0ZWUFpEU2pEelhWL1VEZzBjODNQ?=
 =?utf-8?B?V242RHZ6RFQ5c0lJMW03ajZSZWlkZUxTMjZmeWNsREZEUFErM3hJbzZwVUs5?=
 =?utf-8?B?SXlKYVpuRmRKTDF3V0Y1dVJoWEJ3V2VCVGo3Sy9QNWxmS0Jpd0d6WW1Vdy9a?=
 =?utf-8?B?WUpiWmZ1YXFiWW9BbXBYbTNrVEp4N1d4bTFlbUpCZmR2OGdrc1hjK2Z0Uzds?=
 =?utf-8?B?em9MclRlcWM1TTRtbWl5YUhreTlkb2k3WHpzZ2hSa0o2K3hIMUxUZ3FCclFC?=
 =?utf-8?B?MnhNT3M2OThzTk1kUFpaNCtLQkVXY1NidC8xc1pxRW16ZDBaS3h0dlBvc1JK?=
 =?utf-8?B?RGNzYmlvRDRQN0N0MDJKMUJ4TUs3UkVYYVE5ZFBaV2JQZXZVbnhDVXFWYm1D?=
 =?utf-8?B?cFlHdnh6MVp1anZxSDFkbUtkSmlzZzU0RWpBSVl3eVFrV2NMK2ZPdFBKREds?=
 =?utf-8?B?UnFQQk8xWXhZZHAxM3pzcElKdG5OTC9wNktFWW1uSk0zNUY0SE05bEtYRGRi?=
 =?utf-8?B?Ym5JTWoxdllGejRvRTVYdGJOTlNScDBQR1Z0cVdONnY3MW9jQm1VeWtTOHAz?=
 =?utf-8?B?bFBrdDBKZmdmblIvVlhVdlVnMnJiWmpwelpoZ1JucnVTVUJaOTI0MjgwWENu?=
 =?utf-8?B?dXVEb2MzbktwN0JnandxaXpEQW1zdkZkSWFiY3lWSHVaTnFvc1c1ZUZwVGMx?=
 =?utf-8?B?NUlMdHNMVXB0cWZJOFJyd3R1RnZyNkpYdVlEVnVSV25mYmY0UEtyNnA0NEVU?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2338c35-6b8c-453b-09b2-08dabe6feba5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 14:21:53.2488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGVNnj137Ylfarpq6TCUysTOxdKz/W+ePbwJrAgNC1mdkVHfwtAI9VfyCWzuLfTyWTnX63DkIc291lKko0l1GEXqbW++YbWgChPxMky7924=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8001
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Correctly handle user time in setitimer01
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

SGkhCgpPbiAxMS80LzIyIDEzOjQ2LCBNYXJ0aW4gRG91Y2hhIHdyb3RlOgo+IEhpLAo+IHN1Z2dl
c3Rpb24gYmVsb3cuCj4KPiBPbiAwNC4gMTEuIDIyIDEwOjI0LCBBbmRyZWEgQ2VydmVzYXRvIHZp
YSBsdHAgd3JvdGU6Cj4+IFNpbmNlIElUSU1FUl9WSVJUVUFMIGFuZCBJVElNRVJfUFJPRiBhcmUg
Y291bnRpbmcgZG93biBpbiB1c2VyIHRpbWUsIHdlCj4+IG5lZWQgdG8gdGFrZSBpbiBjb25zaWRl
cmF0aW9uIENMT0NLX01PTk9UT05JQ19DT0FSU0UgcmVzb2x1dGlvbi4gVGhpcyBpcwo+PiByZXF1
ZXN0ZWQgYnkgdGhlIHN5c2NhbGwsIHNpbmNlIGl0J3MgY29uc2lkZXJpbmcgY29udGV4dCBzd2l0
Y2ggZnJvbQo+PiB1c2VyIHRvIGtlcm5lbCBtb2RlIGJ5IHVzaW5nIGEgaGlnaGVyIGNsb2NrIHJl
c29sdXRpb24uCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5j
ZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4+IC0tLQo+PiDCoCAuLi4va2VybmVsL3N5c2NhbGxzL3NldGl0
aW1lci9zZXRpdGltZXIwMS5jwqDCoCB8IDU0ICsrKysrKysrKysrLS0tLS0tLS0KPj4gwqAgMSBm
aWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRpdGltZXIvc2V0aXRpbWVyMDEu
YyAKPj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldGl0aW1lci9zZXRpdGltZXIwMS5j
Cj4+IGluZGV4IGViNjJmMDJjNi4uNWZjYWU1M2U4IDEwMDY0NAo+PiAtLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL3NldGl0aW1lci9zZXRpdGltZXIwMS5jCj4+ICsrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvc2V0aXRpbWVyL3NldGl0aW1lcjAxLmMKPj4gQEAgLTgsOSArOCwx
NiBAQAo+PiDCoCAvKlwKPj4gwqDCoCAqIFtEZXNjcmlwdGlvbl0KPj4gwqDCoCAqCj4+IC0gKiBT
cGF3biBhIGNoaWxkIGFuZCB2ZXJpZnkgdGhhdCBzZXRpdGltZXIoKSBzeXNjYWxsIHBhc3Nlcywg
YW5kIGl0IAo+PiBlbmRzIHVwCj4+ICsgKiBTcGF3biBhIGNoaWxkLCB2ZXJpZnkgdGhhdCBzZXRp
dGltZXIoKSBzeXNjYWxsIHBhc3NlcyBhbmQgaXQgZW5kcyB1cAo+PiDCoMKgICogY291bnRpbmcg
aW5zaWRlIGV4cGVjdGVkIGJvdW5kYXJpZXMuIFRoZW4gdmVyaWZ5IGZyb20gdGhlIHBhcmVudCAK
Pj4gdGhhdCBvdXIKPj4gwqDCoCAqIHN5c2NhbGwgc2VudCB0aGUgY29ycmVjdCBzaWduYWwgdG8g
dGhlIGNoaWxkLgo+PiArICoKPj4gKyAqIEJvdW5kYXJpZXMgYXJlIGNob29zZW4gYWNjb3JkaW5n
bHkgd2l0aCBzeXN0ZW0gY2xvY2suIEluIAo+PiBwYXJ0aWN1bGFyLCB3aGVuCj4+ICsgKiB0aW1l
ciBjb3VudHMgZG93biBpbiByZWFsIHRpbWUsIENMT0NLX01PTk9UT05JQyByZXNvbHV0aW9uIGhh
cyAKPj4gdGFrZW4gaW50bwo+PiArICogYWNjb3VudCBhcyBvdXIgdGltZSBzdGVwLiBXaGVuIHRp
bWVyIGNvdW50cyBkb3duIGluIHVzZXIgdGltZSwKPj4gKyAqIENMT0NLX01PTk9UT05JQ19DT0FS
U0UgaXMgdXNlZC4gVGhlIHJlYXNvbiBpcyB0aGF0IAo+PiBDTE9DS19NT05PVE9OSUNfQ09BUlNF
Cj4+ICsgKiBpcyBvdXIgc3lzdGVtIHJlc29sdXRpb24gaW4gdXNlciBzcGFjZSwgc2luY2UgaXQn
cyB0YWtpbmcgaW4gCj4+IGNvbnNpZGVyYXRpb24KPj4gKyAqIGNvbnRleHQgc3dpdGNoZXMgZnJv
bSB1c2VyIHRvIGtlcm5lbCBzcGFjZS4KPj4gwqDCoCAqLwo+PiDCoCDCoCAjaW5jbHVkZSA8dGlt
ZS5oPgo+PiBAQCAtMjIsNyArMjksNiBAQAo+PiDCoCAjaW5jbHVkZSAidHN0X3NhZmVfY2xvY2tz
LmgiCj4+IMKgIMKgIHN0YXRpYyBzdHJ1Y3QgaXRpbWVydmFsICp2YWx1ZSwgKm92YWx1ZTsKPj4g
LXN0YXRpYyB1bnNpZ25lZCBsb25nIHRpbWVfc3RlcDsKPj4gwqAgwqAgc3RhdGljIHN0cnVjdCB0
Y2FzZSB7Cj4+IMKgwqDCoMKgwqAgaW50IHdoaWNoOwo+PiBAQCAtNTUsOSArNjEsMzEgQEAgc3Rh
dGljIHZvaWQgc2V0X3NldGl0aW1lcl92YWx1ZShpbnQgdXNlYywgaW50IG9fdXNlYykKPj4gwqAg
c3RhdGljIHZvaWQgdmVyaWZ5X3NldGl0aW1lcih1bnNpZ25lZCBpbnQgaSkKPj4gwqAgewo+PiDC
oMKgwqDCoMKgIHBpZF90IHBpZDsKPj4gLcKgwqDCoCBpbnQgc3RhdHVzOwo+PiAtwqDCoMKgIGlu
dCB1c2VjID0gMyAqIHRpbWVfc3RlcDsKPj4gK8KgwqDCoCBzdHJ1Y3QgdGltZXNwZWMgcmVzOwo+
PiDCoMKgwqDCoMKgIHN0cnVjdCB0Y2FzZSAqdGMgPSAmdGNhc2VzW2ldOwo+PiArwqDCoMKgIGlu
dCBzdGF0dXMsIHVzZWMsIHRpbWVfc3RlcCwgZXJyb3I7Cj4+ICsKPj4gK8KgwqDCoCBpZiAodGMt
PndoaWNoID09IElUSU1FUl9SRUFMKQo+PiArwqDCoMKgwqDCoMKgwqAgU0FGRV9DTE9DS19HRVRS
RVMoQ0xPQ0tfTU9OT1RPTklDLCAmcmVzKTsKPj4gK8KgwqDCoCBlbHNlCj4+ICvCoMKgwqDCoMKg
wqDCoCBTQUZFX0NMT0NLX0dFVFJFUyhDTE9DS19NT05PVE9OSUNfQ09BUlNFLCAmcmVzKTsKPj4g
Kwo+PiArwqDCoMKgIHRpbWVfc3RlcCA9IHJlcy50dl9uc2VjIC8gMTAwMDsKPj4gK8KgwqDCoCBl
cnJvciA9IHRpbWVfc3RlcDsKPj4gKwo+PiArwqDCoMKgIGlmICh0aW1lX3N0ZXAgPD0gMCkgewo+
PiArwqDCoMKgwqDCoMKgwqAgdGltZV9zdGVwID0gMTAwMDsKPj4gK8KgwqDCoMKgwqDCoMKgIGVy
cm9yID0gMDsKPj4gK8KgwqDCoCB9Cj4KPiBUaGlzIGFwcHJvYWNoIGxvb2tzIGxpa2UgaXQnbGwg
bGVhZCB0byBzb21lIGJhZCBlZGdlIGNhc2VzIHdoZW4KPiAwIDwgdGltZV9zdGVwIDwgMTAwMC4g
SXQnZCBiZSBiZXR0ZXIgdG8ga2VlcCB0aGUgb3JpZ2luYWwgdGltZV9zdGVwIAo+IGRldGVjdGlv
biBhbmQgaW5pdGlhbGl6ZSAiZXJyb3IiIHZhcmlhYmxlIGxpa2UgdGhpcyAoYW5kIGFsc28gcmVu
YW1lIAo+IGl0IHRvICJtYXJnaW4iKToKPgo+IGludCBqaWZmeTsKPgo+IHZlcmlmeV9zZXRpdGlt
ZXIoKQo+IHsKPiDCoMKgwqDCoC4uLgo+IMKgwqDCoMKgbWFyZ2luID0gKHRjLT53aGljaCA9PSBJ
VElNRVJfUkVBTCkgPyAwIDogamlmZnk7CkhlcmUgd2UgY2FuJ3QgdGFrZSBpbiBjb25zaWRlcmF0
aW9uIENMT0NLX01PTk9UT05JQ19DT0FSU0UgcmVzb2x1dGlvbiBieSAKZGVmYXVsdCwgYmVjYXVz
ZSBvbiBJVElNRVJfUkVBTCB3ZSBhcmUgaGF2aW5nIGEgY2xvY2sgcmVzb2x1dGlvbiBnaXZlbiAK
YnkgQ0xPQ0tfTU9OT1RPTklDLiBBbmQgdW5mb3J0dW5hdGVseSB3ZSBhcmUgbm90IHN1cmUgaXQn
cyB1bmRlciB0aGUgCm1pbGxpc2Vjb25kIHJlc29sdXRpb24gYWxsIHRoZSB0aW1lcywgd2hpY2gg
bWVhbnMgbWFyZ2luID4gMC4gRm9yIHRoaXMgCnJlYXNvbiwgaW4gdGhlIHBhdGNoIHdlIGFyZSBm
ZXRjaGluZyBjbG9jayByZXNvbHV0aW9uIGluIGEgZGlmZmVyZW50IAp3YXksIGFjY29yZGluZyB3
aXRoIHRoZSBjb3VudGVyIHRpbWVyLiBXZSBjYW4gZmV0Y2ggZGlmZmVyZW50IApyZXNvbHV0aW9u
cyBmcm9tIHNldHVwIHRobyBhbmQgdXNpbmcgaW5zaWRlIHRoZSB0ZXN0IGNvZGUuCj4gwqDCoMKg
wqAuLi4KPiB9Cj4KPiBzZXR1cCgpCj4gewo+IMKgwqDCoMKgLi4uCj4gwqDCoMKgwqBTQUZFX0NM
T0NLX0dFVFJFUyhDTE9DS19NT05PVE9OSUNfQ09BUlNFLCAmcmVzKTsKPiDCoMKgwqDCoGppZmZ5
ID0gKHJlcy50dl9uc2VjICsgOTk5KSAvIDEwMDA7Cj4gwqDCoMKgwqAuLi4KPiB9Cj4KPj4gKwo+
PiArwqDCoMKgIHVzZWMgPSAzICogdGltZV9zdGVwOwo+PiArCj4+ICvCoMKgwqAgdHN0X3JlcyhU
SU5GTywgImNsb2NrIHJlc29sdXRpb246ICVsdW5zLCAiCj4+ICvCoMKgwqDCoMKgwqDCoCAidGlt
ZSBzdGVwOiAlaXVzLCAiCj4+ICvCoMKgwqDCoMKgwqDCoCAiY291bnRlciB0aW1lOiAlaXVzIiwK
Pj4gK8KgwqDCoMKgwqDCoMKgIHJlcy50dl9uc2VjLAo+PiArwqDCoMKgwqDCoMKgwqAgdGltZV9z
dGVwLAo+PiArwqDCoMKgwqDCoMKgwqAgdXNlYyk7Cj4+IMKgIMKgwqDCoMKgwqAgcGlkID0gU0FG
RV9GT1JLKCk7Cj4+IMKgIEBAIC03Niw3ICsxMDQsNyBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlfc2V0
aXRpbWVyKHVuc2lnbmVkIGludCBpKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvdmFs
dWUtPml0X3ZhbHVlLnR2X3NlYywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3ZhbHVl
LT5pdF92YWx1ZS50dl91c2VjKTsKPj4gwqAgLcKgwqDCoMKgwqDCoMKgIGlmIChvdmFsdWUtPml0
X3ZhbHVlLnR2X3NlYyAhPSAwIHx8IAo+PiBvdmFsdWUtPml0X3ZhbHVlLnR2X3VzZWMgPiB1c2Vj
KQo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKG92YWx1ZS0+aXRfdmFsdWUudHZfc2VjICE9IDAgfHwg
b3ZhbHVlLT5pdF92YWx1ZS50dl91c2VjIAo+PiA+IHVzZWMgKyBlcnJvcikKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdHN0X3JlcyhURkFJTCwgIkVuZGluZyBjb3VudGVycyBhcmUgb3V0
IG9mIHJhbmdlIik7Cj4+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgKDs7KQo+PiBAQCAtOTEs
MjYgKzExOSwxMCBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlfc2V0aXRpbWVyKHVuc2lnbmVkIGludCBp
KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdHN0X3JlcyhURkFJTCwgIkNoaWxkOiAlcyIsIHRzdF9z
dHJzdGF0dXMoc3RhdHVzKSk7Cj4+IMKgIH0KPj4gwqAgLXN0YXRpYyB2b2lkIHNldHVwKHZvaWQp
Cj4+IC17Cj4+IC3CoMKgwqAgc3RydWN0IHRpbWVzcGVjIHJlczsKPj4gLQo+PiAtwqDCoMKgIFNB
RkVfQ0xPQ0tfR0VUUkVTKENMT0NLX01PTk9UT05JQywgJnJlcyk7Cj4+IC0KPj4gLcKgwqDCoCB0
aW1lX3N0ZXAgPSByZXMudHZfbnNlYyAvIDEwMDA7Cj4+IC3CoMKgwqAgaWYgKHRpbWVfc3RlcCA8
IDEwMDAwKQo+PiAtwqDCoMKgwqDCoMKgwqAgdGltZV9zdGVwID0gMTAwMDA7Cj4+IC0KPj4gLcKg
wqDCoCB0c3RfcmVzKFRJTkZPLCAiY2xvY2sgcmVzb2x1dGlvbjogJWx1bnMsIHRpbWUgc3RlcDog
JWx1dXMiLAo+PiAtwqDCoMKgwqDCoMKgwqAgcmVzLnR2X25zZWMsCj4+IC3CoMKgwqDCoMKgwqDC
oCB0aW1lX3N0ZXApOwo+PiAtfQo+PiAtCj4+IMKgIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVz
dCA9IHsKPj4gwqDCoMKgwqDCoCAudGNudCA9IEFSUkFZX1NJWkUodGNhc2VzKSwKPj4gwqDCoMKg
wqDCoCAuZm9ya3NfY2hpbGQgPSAxLAo+PiDCoMKgwqDCoMKgIC50ZXN0ID0gdmVyaWZ5X3NldGl0
aW1lciwKPj4gLcKgwqDCoCAuc2V0dXAgPSBzZXR1cCwKPj4gwqDCoMKgwqDCoCAuYnVmcyA9IChz
dHJ1Y3QgdHN0X2J1ZmZlcnNbXSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgeyZ2YWx1ZSzCoCAu
c2l6ZSA9IHNpemVvZihzdHJ1Y3QgaXRpbWVydmFsKX0sCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB7
Jm92YWx1ZSwgLnNpemUgPSBzaXplb2Yoc3RydWN0IGl0aW1lcnZhbCl9LAo+CkFuZHJlYQoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
