Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E13ECAAD2
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 08:48:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20AD23CA477
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 10:47:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 547333CA03B
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 10:47:48 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140078.outbound.protection.outlook.com [40.107.14.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AE7FA100023E
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 10:47:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akrV0kx1hXF+BHZhn8f/PeCItShGxd7VCZyZKHw+bDCeQ9y0ly/lWzZxGto8em8Ueu3T2c46H430maeU8i2mDnNVdVinBKnjp83akrAOnrX0uNjeby8CP9/IQpejQIJczUdeJDk6tNMSrI7J3J00AQJ8vvduoE/BvAwnEG9tNY8cButZ0zeydS8TNCGDjzkvlw0bGB5/5W9WTNLEhb7ll32LKVjgw4dkJ/8y0mz7SXVDiBb2MWqWIdPkEj3wOjNsYNYV9OhDei/UF0spZ+dgUhE5btZUBM5SWcbgMyL76/R2+gozk9r9+awjY7NJiplDj5YXWc0yyksPIyHwqHwIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkxJGpx6S+Tbck77aatfotPKoVLmJGD98VrjshFq/vI=;
 b=nnGc+uQbUD1rVPq+hzzI6zLjl2ne44n7nerbgu6PsfrfEnDBm/HIoHjYwhtd2vLBKmEyGaxq1fLjn1K4JnIMnvYCOKCqVtja5rEMYMveJvpf/Xlz94b/tZ/vTQmzT3lwzazBsY1IPdFL8ZAEW2Z9i4pYK2eh6kEVvM80Opi2xF/+I9zDn5vRFpfsK7jVG0MepuJjTkCe8zx5ZssXwj4tbiUz3/yf6pBLJgj5EJX3kGK6BtLg9WcMdkCx8EOjkiT/O3cioFDRYuI/xSRfAjugXLsa+jG/p9wuzRo21u9BD1rZEI0FvLHTm8Q49wNWEQgWwHsixovHX1X6Y5zxz7SFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkxJGpx6S+Tbck77aatfotPKoVLmJGD98VrjshFq/vI=;
 b=reGvvotrqQOMQzbuWSPeKaXAVd39l5WRyuoqpkswtAl+T9ETY0qDiH8ZufbVM92rEsRckbMEcsb5oLj2A5hdFteYQWlsiKCPWfAQIGCPbEcB70LsulNVwM0SYrBLYXi2AIwVoYzwaQulPxigfoCqcUKXzBskgWRB/pBBuSke2/PxaOmeC7JPvo4YUyRzBiXsxsK5sQe1SyeoRNDgfNLu86JPFTLFV+THZl5cC68Zs+bT4TIj8V95Ngektg2jvcbZIEv2cwFLKt4+RffmUzRvgU9Uzy6usYkBEMWvCDxzDcaupW6MIQh0GE2iVbhoMLZ0y12T9jPJ0e7AWbbwwObnHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM0PR0402MB3923.eurprd04.prod.outlook.com (2603:10a6:208:e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 08:47:45 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b%5]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 08:47:45 +0000
Message-ID: <a369a07d-9401-0437-2647-9a5f1737b732@suse.com>
Date: Fri, 26 Aug 2022 10:46:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: ltp@lists.linux.it
References: <20220824124017.14286-1-andrea.cervesato@suse.com>
 <87bks71nwg.fsf@suse.de> <d64a2ccf-ee24-d4cf-17a7-bd32556a9570@suse.com>
In-Reply-To: <d64a2ccf-ee24-d4cf-17a7-bd32556a9570@suse.com>
X-ClientProxiedBy: AS9PR06CA0603.eurprd06.prod.outlook.com
 (2603:10a6:20b:46e::12) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70bef1a6-8258-4137-fb56-08da873fa569
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3923:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ct2XDvKVb0HSPXLgqaL7J5sY8cPbPt5Em0rB56OlBJd4krR/wqfm3y0Tu+kZkFzRlnqurQwkbI/0AkQ9i6Ex5wlvhvZZHxTEiTzo51SdxnFrh0jm+ZqN25SR81AGYJEtbtL7N0ZMlR8/C9+9hoTLcBI7UhUtQSr24Km4+bG0lHl6SBz49e70XmmOXxTvBwL7jOugLkbAqerrn7i4NkYnufmXpHZaX71vvuhIMfrQpUWeWgRDNOyFhuJAkcElH8keFnlZD6TlnvOr10rzaQQjMFiCTLnqhY0eiS+65M8T6S3rRCiM4kCILnbWAjZX+eO7U5iTMQ0iQjHqq1Bjwyv2qAQ05iqKpYp5ZLo+NhirHcN2azvdF+/qGj92N0bzTfRRZEP4hnzkJCPK4QbAhWYXZDLHRHVFF+EJG3vKsaDxVsmW1XjKhTfNADn/zBVy+gDrbdTxn9H+T8/dUYXLDqV2uge/r7O+8Z/9Gnkzuh24SmEUfWEh4Ygd5lu91XSBjiHp0k8r2ZUhyoPKnhWiKITwqfCK6zfwHj/gg4weyXK5ewR7dSGzMBMN4XJWdsxZSp1k1ygm9Sm1K7PhR3JcA6t465QvoqcxB1pWwz0IQeap2nUEyRE6xJzs16FagZ/+lP3PYO1aVPQodIoFfEeXLjKQ7hJSPGRH96YBA3jYQuST0uDt7Ezya0bY7eQNClsM+yteaYkp7mPjZXSYIS8Mgxz3aJ/F/CENo3BwWscr5w8niuM/vbc22ZuW/l1fUDZy0ZC8Q+oNKvnR+cy5W1x/s8nPDBQ15/k/Hg/77jQFvH2jo8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(396003)(376002)(366004)(346002)(39860400002)(136003)(26005)(31696002)(86362001)(5660300002)(6506007)(44832011)(6512007)(66556008)(8936002)(66946007)(66476007)(53546011)(36756003)(6666004)(8676002)(478600001)(2906002)(41300700001)(6486002)(316002)(6916009)(38100700002)(31686004)(2616005)(186003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNPclJrRXhxbFpiTjV4d1ZuRkVjdGswTUt2V1pCT0lNUDIvQjJKbGJPellz?=
 =?utf-8?B?V1VRc0JaenVUZUc0dFphUmVhQXlrdFd3RWhDTGV1YTZyZ3hkQ2ZJSGxDTmdO?=
 =?utf-8?B?Q0xMdXBYMmNYOUMrL3JKRFFXZHNYMlhrNmlnRGVrTmxma3g2VFQ2bDlaMEJD?=
 =?utf-8?B?aTJuajFFRFppOFpVNC91aG9LT2N1cUVMVFpZbzVQUEVxdDJwbENYVGlBWTRC?=
 =?utf-8?B?UUFNaVd4b3kyUFNVYkdwWXhnUXZGYmpuN1RKVFQvRk85WnJ4djRqTzZaeVo2?=
 =?utf-8?B?ejNUSjdlZGVCTGhOR3BYNjBrWWNOcUZySm45UFVBckNxNHF6SlRCbk1tWjNw?=
 =?utf-8?B?L3k1dHNERjdqMm9XZDNSNWVLcUdJbFRwTWg4TXRNVGFTVldFTTRVRHZMcmlV?=
 =?utf-8?B?b2UwUW5KY3JWVGFTNnl5SFFtRUJscnJaM3FpZitKbEt2bml6K1ZWNW93amQ4?=
 =?utf-8?B?dEt6eEI5WjNSMGYzWFpYL2x0cVVWR1k1SWhoblhNL2FpYnZpVkhGOVBUWGxp?=
 =?utf-8?B?bWhGRCtwSFF0K1VlVGE5VFBBVW5XSHY3Z3BMYk1pVVk4QlY1M1lJVTdXNHlX?=
 =?utf-8?B?NU1Jb3E5ZWJlNmRQRFl1QU9FZnFPQ0xnNnZhOURpUzd0bkZUdzl0QzVHVTA0?=
 =?utf-8?B?TlJhMGtzQ1VNanlxamt0ODVDb25mUWp4a3dFQkd2aTZUdHFFNGxhSVhLVGN1?=
 =?utf-8?B?V1oxTmlFZ1Nwb2xVQ0E0RW5TQWtZRUFUYnVtbHRaazE3Z1dyOU9QNkRqemcy?=
 =?utf-8?B?WUNMbzRLaUtJQ1ZtdGxFb0VGcmwvWnRjWXB3MTJLVWZFY2NFY1lOSDZoRURR?=
 =?utf-8?B?bmFnQlV4UXZHdHhWek4zQmxETFBiRkcxWWxBWmg4MHhLNmQ0ZDRYM1JWbTF2?=
 =?utf-8?B?QVFjdGRMKzl2SU5lbWEzb0RURVdiYzEzNXZOYTR0ZlN6YThFNi9JZHR0MENP?=
 =?utf-8?B?OTJRYzBoWHZCa25PVS93RkpzN1hCRGdlN1VzaUlKRVRXZ2VrY2NRdERST1Jq?=
 =?utf-8?B?dmZ6byswWEhWNEk0VjlmUUxoR2YvRnJlUkd2Sk5vb3d1N2ZrQjNockhKUDJy?=
 =?utf-8?B?RGNEb09pVlJHVWlqSUZWSm53TjA4eVFMd3BVZ1RYR2lVNzEyVWRNY1hSY3dM?=
 =?utf-8?B?U2c2djlHa09zM3RvMU9DN3R2YndyWFROTXVnUDNGN3BqbW4vam1tUlVSd2Ir?=
 =?utf-8?B?UGNMdUpmeFhPazN5YzByeHhES2orUGhEalZ3bkNac3Ayc1U0dzZTYndoOStT?=
 =?utf-8?B?UUN2RDZNTnRQeFFpcWpLOENqT0loM09yOFhkMi9nQVkyaFlLMlR4TFAxNDU1?=
 =?utf-8?B?TTBkcml2bzBZTitWVFpVNUdVcTNsdFpQRTkraElralVCYTVMZk5aVjFRT0FS?=
 =?utf-8?B?UzZmdXRiNGtoaVc5eEI1K1FCdmZ2aCtNQ1FVUG51enQwU2xDYmV6bG5LbnBm?=
 =?utf-8?B?Q1E4cUdrT1NnamM0S2N4UC91ZVkrZUZ5MlNlWU9iUmVYZTNrWWFFaGtxQVdt?=
 =?utf-8?B?T05YTCtqVEFVRTdKYUVEK242RnAyRDRMNS8vUTNNMjQ2UGs2aEwvZFNKMVdu?=
 =?utf-8?B?akJpZzV1RWNXUFcxVFFsUjlKdlNKOTQ4eUdaOGxaSTQ3QU5UeEkzZ3I2L1RW?=
 =?utf-8?B?MS9NcStlemFQY2w4UFJJRzd2eE5MSG5sMTVIMGVDQzJSaDZrRW5mMjlqK2FU?=
 =?utf-8?B?eTJvc3dpaEhZNmhGaXo3K3VwTVNMMktxMG5vd3hZUlZpVExrSVd4QjhuT2Zn?=
 =?utf-8?B?RCtpbHNHZElyMzluV1dtMmxmZG5IMFFGYVNKVXoweFgyejMwZ2pWcmd0T1Ix?=
 =?utf-8?B?YklpYTJrbUFnaEpPdy8yY2hjRm9CekdQSzJYOTZjWllGS2xzTThSTFZQeTlE?=
 =?utf-8?B?STQ3Wkhzc3FlNUhKZDhkczR5RE4wUkEwUHdxYXNSNjk5UzFmdlY5WVhmRkdY?=
 =?utf-8?B?a3ZJbkFBSnJmZlJpZkJxcU13LzFvWXFrMk9hbGJoTkpySm8zUmd3TmZCM2dU?=
 =?utf-8?B?dFoyRVhERWJvWjlpaFJTbytQNTRaR0tMYTJXYjJXbTcwalVrdlRGeGYxNzZ6?=
 =?utf-8?B?THc2NEZTQjJ1Q0RHdngxMC9XNllHZWtpUWdaaEQ4T1B0aWhqUkwvMlp5RmND?=
 =?utf-8?B?VEdGK2N6UkxDWVBxdjk3M3plTkM5c3pmYjl0VTVtTWhwU01yU2ptT0JLZTdy?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bef1a6-8258-4137-fb56-08da873fa569
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 08:47:45.5003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEf5iPkdkLlFeddo8tPEBbi4BymrizPEfkbEm+iHRED/41fe5k+fA+Qr0e+BvHWd6CeSDkhU9zuOEvdmC9M2lMMs3N4UR3BhOk852RaN3lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3923
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite process_vm01 test using new LTP API
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

T24gOC8yNi8yMiAxMDo0MCwgQW5kcmVhIENlcnZlc2F0byB2aWEgbHRwIHdyb3RlOgo+IEhpIQo+
Cj4gT24gOC8yNi8yMiAwOTowNCwgUmljaGFyZCBQYWxldGhvcnBlIHdyb3RlOgo+PiBIZWxsbywK
Pj4KPj4gQW5kcmVhIENlcnZlc2F0byB2aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+IHdyaXRl
czoKPj4KPj4+IC1zdGF0aWMgdm9pZCBjbWFfdGVzdF9pbnZhbGlkX3Blcm0odm9pZCkKPj4+ICtz
dGF0aWMgdm9pZCB0ZXN0X2ludmFsaWRfcGVybSh2b2lkKQo+Pj4gwqAgewo+Pj4gwqDCoMKgwqDC
oCBjaGFyIG5vYm9keV91aWRbXSA9ICJub2JvZHkiOwo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgcGFz
c3dkICpsdHB1c2VyOwo+Pj4gLcKgwqDCoCBpbnQgc3RhdHVzOwo+Pj4gwqDCoMKgwqDCoCBzdHJ1
Y3QgcHJvY2Vzc192bV9wYXJhbXMgKnBhcmFtczsKPj4+IMKgwqDCoMKgwqAgcGlkX3QgY2hpbGRf
cGlkOwo+Pj4gwqDCoMKgwqDCoCBwaWRfdCBwYXJlbnRfcGlkOwo+Pj4gLcKgwqDCoCBpbnQgcmV0
ID0gMDsKPj4+ICvCoMKgwqAgaW50IHN0YXR1czsKPj4+ICsKPj4+ICvCoMKgwqAgdHN0X3JlcyhU
SU5GTywgIlRlc3RpbmcgaW52YWxpZCBwZXJtaXNzaW9ucyBvbiBnaXZlbiBQSUQiKTsKPj4+IMKg
IC3CoMKgwqAgdHN0X3Jlc20oVElORk8sICJ0ZXN0X2ludmFsaWRfcGVybSIpOwo+Pj4gwqDCoMKg
wqDCoCBwYXJlbnRfcGlkID0gZ2V0cGlkKCk7Cj4+PiAtwqDCoMKgIGNoaWxkX3BpZCA9IGZvcmso
KTsKPj4+IC3CoMKgwqAgc3dpdGNoIChjaGlsZF9waWQpIHsKPj4+IC3CoMKgwqAgY2FzZSAtMToK
Pj4+IC3CoMKgwqDCoMKgwqDCoCB0c3RfYnJrbShUQlJPSyB8IFRFUlJOTywgY2xlYW51cCwgImZv
cmsiKTsKPj4+IC3CoMKgwqDCoMKgwqDCoCBicmVhazsKPj4+IC3CoMKgwqAgY2FzZSAwOgo+Pj4g
LcKgwqDCoMKgwqDCoMKgIGx0cHVzZXIgPSBnZXRwd25hbShub2JvZHlfdWlkKTsKPj4+IC3CoMKg
wqDCoMKgwqDCoCBpZiAobHRwdXNlciA9PSBOVUxMKQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdHN0X2Jya20oVEJST0sgfCBURVJSTk8sIE5VTEwsICJnZXRwd25hbSBmYWlsZWQiKTsKPj4+
IC3CoMKgwqDCoMKgwqDCoCBTQUZFX1NFVFVJRChOVUxMLCBsdHB1c2VyLT5wd191aWQpOwo+Pj4g
LQo+Pj4gLcKgwqDCoMKgwqDCoMKgIHBhcmFtcyA9IGNtYV9hbGxvY19zYW5lX3BhcmFtcygpOwo+
Pj4gK8KgwqDCoCBjaGlsZF9waWQgPSBTQUZFX0ZPUksoKTsKPj4+ICvCoMKgwqAgaWYgKCFjaGls
ZF9waWQpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBsdHB1c2VyID0gU0FGRV9HRVRQV05BTShub2Jv
ZHlfdWlkKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBTQUZFX1NFVFVJRChsdHB1c2VyLT5wd191aWQp
Owo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHBhcmFtcyA9IGFsbG9jX3BhcmFtcygpOwo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgIHBhcmFtcy0+cGlkID0gcGFyZW50X3BpZDsKPj4+IC3CoMKgwqDC
oMKgwqDCoCBjbWFfdGVzdF9wYXJhbXMocGFyYW1zKTsKPj4+IC3CoMKgwqDCoMKgwqDCoCByZXQg
fD0gY21hX2NoZWNrX3JldCgtMSwgVEVTVF9SRVRVUk4pOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIHJl
dCB8PSBjbWFfY2hlY2tfZXJybm8oRVBFUk0pOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIGNtYV9mcmVl
X3BhcmFtcyhwYXJhbXMpOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIGV4aXQocmV0KTsKPj4+IC3CoMKg
wqAgZGVmYXVsdDoKPj4+IC3CoMKgwqDCoMKgwqDCoCBTQUZFX1dBSVRQSUQoY2xlYW51cCwgY2hp
bGRfcGlkLCAmc3RhdHVzLCAwKTsKPj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoIVdJRkVYSVRFRChz
dGF0dXMpIHx8IFdFWElUU1RBVFVTKHN0YXR1cykgIT0gMCkKPj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHRzdF9yZXNtKFRGQUlMLCAiY2hpbGQgcmV0dXJucyAlZCIsIHN0YXR1cyk7Cj4+PiAr
wqDCoMKgwqDCoMKgwqAgdGVzdF9wYXJhbXMocGFyYW1zKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBU
U1RfRVhQX0VRX0xJKFRTVF9SRVQsIC0xKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBjaGVja19lcnJu
byhFUEVSTSk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgZnJlZV9wYXJhbXMocGFyYW1zKTsKPj4+ICvC
oMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+PiDCoMKgwqDCoMKgIH0KPj4+ICsKPj4+ICvCoMKgwqAg
U0FGRV9XQUlUUElEKGNoaWxkX3BpZCwgJnN0YXR1cywgMCk7Cj4+IFdlIHdhbnQgdG8gdXNlIHRz
dF9yZWFwX2NoaWxkcmVuKCkgaGVyZSB3aGljaCB3aWxsIGNoZWNrIHRoZSBleGl0Cj4+IHN0YXR1
cy4KPj4KPj4gSW4gZmFjdCwgaWYgU0FGRV9XQUlUUElEIGlzIHJlbW92ZWQgYWx0b2dldGhlciB0
aGVuIHRoZSBleGl0IHN0YXR1cyB3aWxsCj4+IGJlIGNoZWNrZWQgYXV0b21hdGljYWxseSBhdCB0
aGUgZW5kIG9mIHRoZSB0ZXN0IHdoZW4gdGhlIGxpYiBjYWxscwo+PiByZWFwX2NoaWxkcmVuLgo+
Pgo+PiBPdGhlcndpc2UgTEdUTSEKPj4KPiBJc24ndCB0c3RfcmVhcF9jaGlsZHJlYWQoKSBhbHJl
YWR5IGNhbGxlZCBhdCB0aGUgZW5kIG9mIHRoZSB0ZXN0X2FsbCAKPiBmdW5jdGlvbj8gKHRzdF90
ZXN0LmM6MTM1NCkKPgo+IEFuZHJlYQo+Cj4KVGhlIHJlYXNvbiB3aHkgSSdtIHVzaW5nIFNBRkVf
V0FJVFBJRCBoZXJlIGlzIHRoYXQgdGhlcmUgYXJlIG1hbnkgb3RoZXIgCnRlc3QgZnVuY3Rpb25z
IGFuZCB3aGVuIHRlc3RfaW52YWxpZF9wZXJtIGlzIGNhbGxlZCB3aXRob3V0IGl0LCB0aGUgCnRz
dF9yZXMgbWVzc2FnZXMgbWlnaHQgY29tZSBvdXQgYXN5bmNocm9ub3VzbHkgd2l0aCB0aGUgb3Ro
ZXIgdGVzdHMgCm1lc3NhZ2VzLgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
