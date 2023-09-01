Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C75CA0FE1
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 11:46:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CAFA3CBDC1
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 13:46:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C45183CBB96
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 13:46:15 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BFD636014F0
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 13:46:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVdDId/0QnWGbYdslAskh2Y9AZ6X46FAsyGoN1n7QNPxSozuBh2S7al9CRV6wKyzT/txC8wbjEAdkfdFyn6Aeqb7SXg1h6p8YYiXgAFbNAX686iLwM29YxcolA5Q8Alxr7d16lzTbmO3UTQFdUQaA2KMU8oKkqpTK18oe6quurM7iAW12RS6G5udE1Q7boNWfMo2kNz0B73lxRgusRJzYjQS++m0wf0p1rs7Uofre9jGXqIdgTgVEU0njox+rFLIW1ME8LMiuU6SAUB34+dszUsnYGlN1Z1pOebqpCJf578PVJqZv5u8CpfzXqSh2o395/jdDS0YrtXfGPqKtMqYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zfqkbIME26yHGfPVNp+YRDTzoAj5lmFEMfztDAZ8F8=;
 b=Zb2MrtERq21v2eRfx92s0Avn3gp+QTQQzKFjxsxTG80qZYIFpFAzYY7nIaOB7o7POGcVwgadnGrILneCyFZnaGUVSgUYvf7FRTWyI+NN0WDeFo621ynvHrmw290TXnMxHDxs8wd3Y6fKoMUUfaOt995ZhsV9e8nEluJJyjDD0W0ajz86XdHJs4Nuw/ccHmTzYFwXlsG9IQgfZacs4uAh/x2H+o/9Js0epUN58y/M6eXxLVI5hNWJ6TD7IbBgQUl/5ozUI1/S72FnMAKvHEKQZtCH8RkmiXxWgbsVbbTu4ZbntOPNGvwiCFbS/zgLKIEocYBX84gGATicuzbdyNSDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zfqkbIME26yHGfPVNp+YRDTzoAj5lmFEMfztDAZ8F8=;
 b=ev2y4Do9se6kPAePEYJcqxrcb1c4tAGUml+DQBzVCnLZTEwWhe2+dxU5SoAbUK3kaRz0F/OBOkBP1S+YjkEd3CwsYqhy/ARmAV4drahqktAr5RBl2Rw0YneZVmygcHKK/ZsQ85UoYPVXUKrvv4TOszKRIow9WSFwIwxF3ErW9F9q9kUbWnj/2oEYhg/lIupBRTnd5I40OnDkmz6cS43cP3ccKHzJZcWCJ6RZE1uEXAZuYJ50LTpJdLa+F7UHRP0bUNENWisVt8K2R9IAEhQXeG3UHkLnIRoIp15//Xoey+4waDajyh5W0ICzgYfOuPrGZ0kiKhvQQf/Z1gEyEmh9AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM7PR04MB6918.eurprd04.prod.outlook.com (2603:10a6:20b:10c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Fri, 1 Sep
 2023 11:46:13 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6678.031; Fri, 1 Sep 2023
 11:46:13 +0000
Message-ID: <ace7a77a-f187-45ed-91e5-c19b8d240a39@suse.com>
Date: Fri, 1 Sep 2023 13:46:08 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230831104242.27156-1-andrea.cervesato@suse.de>
 <20230831104242.27156-2-andrea.cervesato@suse.de> <ZPCWWXXHG-oEB5qO@yuki>
In-Reply-To: <ZPCWWXXHG-oEB5qO@yuki>
X-ClientProxiedBy: FR2P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::13) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM7PR04MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8bfcf4-09bb-4773-2b16-08dbaae10ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dz9yrmSP17vSP1tleQsCSQccWB0d9dvno5NNH33Yu8NGB7rcpBd7zERY2vyLuu9Vm2A/ONFlmR7jLlG+/Ihahn3sT6VAHlyjOZOy7R3MV7NaW1qwdE7vaUGAfv+A/y7kwzVKi6+FLRuo/4TIFgnrZrTil2Bdw8sZdW9izshWTbsryNr8h826NXaZVjJenwMYMHFeR07TG2l8O8ic4+aeiYhbdJv9JHIB7AuKg0AsGuuQPpplQd4Fywf2kQJboPk9+y9u3pFL4Ia5ADzt7cT9y/XoJIEyhbt6Jb7fvC+KTokEi30qtZZTiSFXT3LegDEcjiBERpyfBdHyC7Cc0XdxRxf2yipnZDn0EB/0rizEtn+2r6mpisAaiaNNACzCUdLFuFvuC+qAB7IYLhctOyr6ZCBCNewpOPxkPeAAR2vRsAtVPLusUttmqu6mypeTx2p+TJntVQ59g48jYf+qwRqNuWlax1WxKRecYbYf/UuIjdUWZTUBUkxFly5l7Vz2LdtItxGkNLKNb4oeTRpCWUBNbeG2lYSzubo238Hwx1iys9IUHsJS88qsFirrc1jcLKMYU7g/euSfZPN9QDl2xmrVN3Tzy41ogJlJr624sP55N946IbEjmyhGFTz6+pgFwT14WJQ7EMKu+cou9nMZYspUtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(346002)(39850400004)(366004)(1800799009)(451199024)(186009)(31686004)(6666004)(6486002)(6506007)(6512007)(36756003)(38100700002)(31696002)(86362001)(2906002)(2616005)(26005)(966005)(53546011)(83380400001)(110136005)(8676002)(66946007)(8936002)(4326008)(5660300002)(41300700001)(44832011)(66556008)(66476007)(316002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEQrZlJ0VmJwdm5OK3BHY2VSbFRreGF2cGM2MUZUb2N4WWZRc2FOTGFlQTlh?=
 =?utf-8?B?Z2MxRkNZZUJmVVRhZlV4Zys0SjczNlA1RGx0WW44TFRMdm5Cd3J3K1plODNC?=
 =?utf-8?B?YmFNL2VhdTRDMnY2WjJsWE5GRnc3bWZLUFU4bUhaQ0xvV0NVWThNMzFUSVNr?=
 =?utf-8?B?UEJFZ2pqbHArOXVKM0h0V0tIZ3FtZTh2RHFHa3NhdGc5bkVjQmg4MStGY1d2?=
 =?utf-8?B?Mjk4S29BaUhld2FmdTFST1lrSUNPWGkwM3UzWlBDVUZOK2ZtQlc4U3E0aytt?=
 =?utf-8?B?U1hWbUFHVlBCUktLWllta095R2JoUWZKWm9IbjRmN04vQ0RoY2lGZ3RrNnlF?=
 =?utf-8?B?NWJMM3NMWkRIWFVrTlp0bytaTWppMUF5Y0NzVkdMbHM4OHZ1elkxaUJndkl0?=
 =?utf-8?B?Z1Y0dzJZak1KUkNKS2o5NFhxT0xOOHRWd0FQWU1Ya2pRbUVFT0QxZnZRRDV1?=
 =?utf-8?B?ZWpQRDNhZi9qVXNvSkR6SFdXRTdsT1IvVW5RQlo1L0lvWVUzY3licXBuWWRk?=
 =?utf-8?B?T1V6MEZHVXpTUkdnL3R2NDJYU0JnKzVCL05VT1kvQU5vRzc2ZkM0YkxpdTNu?=
 =?utf-8?B?WGtzTkpLS20vTW1DeFBEc0RSNTJBR1NScG5Kb29EaUVUTDZ2dzhYZjBZaExC?=
 =?utf-8?B?RHhoOFlPVERZZVRHTnArY01hb3RMSTRlc25pUmVRcHBYNEpVaUJxRWdhT3hL?=
 =?utf-8?B?ajVmdHpjMmIrNkdWTHZuVEVmYTlhNEdubzM5ZUVPUEQwUlRhcnhLMkt6d3ZZ?=
 =?utf-8?B?WnVTNkNZYzJmeHh6MjBtaVIvNlVLWkQ5UkZwNFllOEtGZGI2TjdwbUFZNy95?=
 =?utf-8?B?MjhXL0NXSHluc3Qrb01NMjZMVDQ4cVdXZGtERFZxaWRHUWV0RVBWVU5PakYz?=
 =?utf-8?B?ZmlMdW9LSTVOQW9Mdnd1a2E0alo1dXBPUllzUWZFTGlZa3JQcDhZRTZJZnl6?=
 =?utf-8?B?dER5K0gxME9qeHVROHpCR2VGa0Ezd25WM3RKSW5KQmFUS1pydCthRmUyNWVP?=
 =?utf-8?B?MDZ0c0FMekhMY2JxcXBGVmZLaWxvRktyb0ZNRVdPdVVnZXZwN0xRd09MK2Fq?=
 =?utf-8?B?Sk9DeG1KZzB4Qm0vMGE0WWpnd1ljVmMwcHR3b1ZSVHdRU1Z6MGI1dlZFNG1s?=
 =?utf-8?B?MXFId1k4MHJwRVI4aW9qVGRLcDhLL2wxQ2ZnbEpyVjFURmc2VTF3T3BwYlY3?=
 =?utf-8?B?aFNWbkQ4c3RKS0hOMUVzYS8wZFQxZzdwKzdnRGJQNmJ6K1dZS3dZdmo2eDVo?=
 =?utf-8?B?TzZORVptQURMaGsxTXVpRk5tMVNGR0tMMjFpMTBSdmNLOEdTWkdQc3hJUzE1?=
 =?utf-8?B?ZFlFY0dIN3YxaDkrTGlGT1dScThDVkYrTVVrcHV0NVQ4UkdnaVI4QUtRbXcw?=
 =?utf-8?B?V2pWa2R3NHpUZy9SV2ZQZktJbmdNZXJPWFlUM0ZKbjkwS3lkNFpDai9OUGdS?=
 =?utf-8?B?N1VjQnpqSmtjQXpjOEpvOGZHYkhaWG0wTmt0UnRjRURWQW9zb3hPejkrTlpo?=
 =?utf-8?B?amZQMEc3dnpsbHpyYjEvOFVTQzE0WnFQc01VMEl5MExhTHVWUzYrS1hUc3hF?=
 =?utf-8?B?OVNDSStlNjZxay8wajNhMUlHZXl3dktTaXRaUGl1UVZVVmp4V2FUQlVoTjcz?=
 =?utf-8?B?SkxiZmkrWkdIMGpwcjZ4ZlZ6NlpwK29hN3ZoZEtPSXNZdmVSTkc2amFBcmRF?=
 =?utf-8?B?ekVHY3Y4Qys1ckhqYWdqcDJRbS8vNzgwK2hTaFNSZWIvcHVBZ3QrZjZRdjZ2?=
 =?utf-8?B?WS9mUkxCczVYTVhBZnozRjcvNkZXRVo5YzlJdjNVQkZZOEhjY3E1dUgyL0Vn?=
 =?utf-8?B?MnNwSklyTUIvTXVZTmcwd2d4V1o2ZlJBVWdiNXBpeXVxcUY0RjRFalN5dElm?=
 =?utf-8?B?aHp1MWxUMnlHTlVwczdlWGgzS2pjaFkvOXUyM0dvdUVEU3I5V296a2dDOWVz?=
 =?utf-8?B?SWdIdG50MnIybWpPRWZLWWR0eENUK1kxVVB5aWlOTTBVdXhWM2pnMTVsSGtV?=
 =?utf-8?B?U0s3QWhtQlRQUGEvNlJEdTNXY3dXVklFaER5Z2RVSDJvWGhHaUlzYzhEckZm?=
 =?utf-8?B?eUtMWmVCM2EwbUF1b2F0QUdPWnFZamVrTGhScExIWDl5dElYdWtmZjB4bmFq?=
 =?utf-8?B?Z1RsTUJmbzI5c05kbTgzcUZZdXFTTE5xa09qaDBqK0Q2WEJyRlJrMElPYzE4?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8bfcf4-09bb-4773-2b16-08dbaae10ae6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 11:46:13.1828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8cCHnnw7obGNockIpiNspl/zC435M9iMqsvuyqSU2WPuZRuHGaLAx7BbBtrahyPlJvFW+1kFMWupfFsDWNXEXbOVhr73Uwyfc9jMsXw84w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6918
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] Refactor getegid01 using new LTP API
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiA4LzMxLzIzIDE1OjMyLCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gSGkhCj4+ICsJZ2lk
X3QgZ2lkOwo+PiArCWdpZF90IHN0X2dpZCwgc3RfZWdpZDsKPj4gICAKPj4gLQkJaWYgKFRFU1Rf
UkVUVVJOID09IC0xKSB7Cj4+IC0JCQl0c3RfcmVzbShURkFJTCB8IFRURVJSTk8sICJnZXRlZ2lk
IGZhaWxlZCIpOwo+PiAtCQkJY29udGludWU7CS8qIG5leHQgbG9vcCBmb3IgTVRLRVJORUwgKi8K
Pj4gLQkJfQo+PiArCVNBRkVfRklMRV9MSU5FU19TQ0FORigiL3Byb2Mvc2VsZi9zdGF0dXMiLCAi
R2lkOiAlZCAlZCIsICZzdF9naWQsICZzdF9lZ2lkKTsKPiBIaW50OiBZb3UgY2FuIHVzZSBhc3Np
Z25tZW50IHN1cHByZXNpb24gJyonIGluIG9yZGVyIHRvIGdldCByaWQgb2YgdGhlCj4gICAgICAg
IGR1bW15IHN0X2dpZCB2YXJpYWJsZS4KPgo+PiAtCQl0c3RfcmVzbShUUEFTUywgImdldGVnaWQg
cmV0dXJuZWQgJWxkIiwgVEVTVF9SRVRVUk4pOwo+PiAtCX0KPj4gLQo+PiAtCWNsZWFudXAoKTsK
Pj4gLQl0c3RfZXhpdCgpOwo+PiAtfQo+PiAtCj4+IC1zdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+
PiAtewo+PiAtCXRzdF9zaWcoTk9GT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7Cj4+IC0JVEVT
VF9QQVVTRTsKPj4gKwlHSUQxNl9DSEVDSygoZ2lkID0gR0VURUdJRCgpKSwgImdldGVnaWQiKTsK
PiBBbmQgdGhpcyBkb2VzIG5vdCB3b3JrIGF0IGFsbC4KPgo+IFRoZSBHSUQxNl9DSEVDSygpIGlz
IGZvciB0aGUgY2FzZSB3aGVyZSB3ZSBoYXZlIEdJRCB0aGF0IGlzIDMyYml0IGFuZCB3ZQo+IHdh
bnQgdG8gY2hlY2sgaWYgdGhlIHZhbHVlIGZpdHMgaW50byAxNmJpdC4gSW4gdGhpcyBjYXNlIHdl
IGdldCAxNmJpdAo+IHZhbHVlIGZyb20gdGhlIHN5Y2FsbCwgc28gdGhlIGNoZWNrIHdpbGwgYWx3
YXlzIGJlIHRydWUuCj4KPiBBbHNvIHRoZSBjaGVjayBvbmx5IHJldHVybnMgdmFsdWUsIHdoaWNo
IHdlIGluZ29yZSBoZXJlLCBzbyB0aGlzIGlzbid0Cj4gZG9pbmcgYW55dGhpbmcgYXQgYWxsLgo+
Cj4gV2hhdCB3ZSBuZWVkIHRvIGRvIGluc3RlYWQgaXMgdG8gY2hlY2sgdGhlIGdpZCBmcm9tIC9w
cm9jLyB0aGF0IGlzIDMyYml0Cj4gaWYgaXQgZml0cyBpbnRvIDE2Yml0IChpbiB0aGUgY2FzZSBv
ZiB0aGUgMTZiaXQgc3lzY2FsbCkgYW5kIHNraXAgdGhlCj4gY29tcGFyc2lvbiBiZWxvdy4KPgo+
PiArCVRTVF9FWFBfRVFfTEkoZ2lkLCBzdF9lZ2lkKTsKPiBTbyB0aGUgY29kZSBoZXJlIHNob3Vs
ZCByZWFsbHkgZG86Cj4KPiAJaWYgKEdJRDE2X0NIRUNLKHN0X2VnaWQpKQo+IAkJVFNUX0VYUF9F
UV9MSShnaWQsIHN0X2VnaWQpOwo+IAllbHNlCj4gCQl0c3RfcmVzKFRQQVNTLCAiZ2V0Z2lkKCkg
cGFzc2VkIik7CgpNbW1oLCB0aGlzIHdvdWxkIG1ha2Ugc2Vuc2UgaWYgR0lEMTZfQ0hFQ0sgb25s
eSBjaGVja2VkIGZvciAxNmJpdCAKY29tcGF0aWJpbGl0eSwgYmVjYXVzZSBhdCB0aGUgbW9tZW50
IGl0J3Mgd2F5IGRpZmZlcmVudDoKCgojZGVmaW5lIEdJRDE2X0NIRUNLKGdpZCwgc3lzX25hbWUs
IGNsZWFudXApIFwKaWYgKCFHSURfU0laRV9DSEVDSyhnaWQpKSB7IFwKIMKgwqAgwqB0c3RfYnJr
bShUQlJPSywgY2xlYW51cCwgXAogwqDCoCDCoMKgwqDCoCAiZ2lkICVkIG9mICVzIGlzIHRvbyBs
YXJnZSBmb3IgdGVzdGluZyAxNi1iaXQgdmVyc2lvbiAiIFwKIMKgwqAgwqDCoMKgwqAgIm9mICVz
KCkiLCBnaWQsICNnaWQsICNzeXNfbmFtZSk7IFwKfQoKQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8K
Cj4gV2hpY2ggc2tpcHMgdGhlIGNoZWNrIG9uIDE2Yml0IHN5c2NhbGwgaW4gdGhlIGNhc2UgdGhh
dCB0aGUgR0lECj4gb3ZlcmZsb3dzIDE2Yml0LCBob3dldmVyIHdlIHN0aWxsIGhhdmUgdG8gcmVw
b3J0IGF0IGxlYXN0IHNpbmdsZSBUUEFTUwo+IG90aGVyd2lzZSB0aGUgdGVzdCB3aWxsIGJlIGZh
aWxlZCBieSB0aGUgdGVzdCBsaWJyYXJ5Lgo+Cj4+ICAgfQo+PiAgIAo+PiAtc3RhdGljIHZvaWQg
Y2xlYW51cCh2b2lkKQo+PiAtewo+PiAtfQo+PiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0
ID0gewo+PiArCS50ZXN0X2FsbCA9IHJ1biwKPj4gK307Cj4+IC0tIAo+PiAyLjM1LjMKPj4KPj4K
Pj4gLS0gCj4+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAoKQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
