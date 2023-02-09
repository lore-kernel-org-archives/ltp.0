Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CD0C61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 11:26:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76A553CC09F
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 12:26:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C52C3C95EB
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 12:26:29 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7ACC260008D
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 12:26:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu8Z0fL14krvosW7ixU0ZFp33C/RXORFWhhXOfno6lrHOYNJsOcU0UTmMzOQfTTK6R15IL8kMpIS0tLotsyNgzNBBRfHvbDVWO9LmRgtwFMlOAM6fXUCRd98n6/dPZjuWgkuTyDevEhHQA84JSR+RVEJ5uXiDCwR167+1l5i5Y63h0CF9U+c5zjQoLAO/D2SJIkMj9Gygall/UJvYLXXLIuQ3C8/ocDPK6A/Iv87kg4kfYfbYBy3Fc8doSxSU59Nz9op6vFiVR95Y9ypWTbBoS2mhqry8SEu67oxVdj7iQSm3E0ZJl/qADmWrmTSZG3GR3vU+jKhggzBlbMhkzuYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSU2p3hMfxgjYHhd/uVf7b0+buOHmei9Ed2qURd2NCg=;
 b=JW5nUQxbP+gjfgjfN5AOf0TMSUKZXtaetQeuEtsE+1m1OVHds3lR03JQQ3yUPOQ5X9HRveK8038d9FEHtj6Tv73MuFu+PTMdBAanE6DBzMeR5asAZ02SMxdsOulGwfDgol1Voqjb4daT5SzmUu0AAhUehpDtLQNzl0X0Kdh97fMeYuhfolsth1SoZ20atO9CxjhftFnyKhjIe//KsywuUJezaaaVnaHh9v+z9Vn4VYBfawGyJRmmbneyXc8VpQ2Pz8vIU1fSXYVPaLlGaCPb/6U8kEvDtbaHR2e7zRpEI0x9jNEhJu3EKQCqQVP4qY1BjIOBlJhQvQmWq5CTb4KXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSU2p3hMfxgjYHhd/uVf7b0+buOHmei9Ed2qURd2NCg=;
 b=OHcj1VHwq7CZtZ2G2MPZ3nvMYCpE6AsnGz7uj2RZcloxN7FgTNhiUjWq7r2ZrMl0IBespIIii3asTV4qx5t7IGaABd/vFhKpcdKvjFMCUmTcuGUech4iayczR11IGblMGT2twe3RZS8BrPTnoDcL/7/ImySkROu8tNb1oXEyWFH8lJup0c0mpBpxEe3BXuKZ0mNb1vcQE6EBaBoCGQy6VJ4zmefFE7czKQE6Xj+SFw2QW43cJw5/WJ+Q8mSNtIN9wDm0b4fB1M+SGXwQU3QhoQBO/Qhh+AQj6cYDIaNXikXDKST8GlqyktTDqqfYZnXgBjWP4IK1K469+rhhdaswPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DU2PR04MB9209.eurprd04.prod.outlook.com (2603:10a6:10:2f8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Thu, 9 Feb
 2023 11:26:26 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6%5]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 11:26:26 +0000
Message-ID: <2d9a6f7b-6408-3d13-2da7-e2e0c90f5e1f@suse.com>
Date: Thu, 9 Feb 2023 12:24:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: ltp@lists.linux.it
References: <20230209090307.491586-1-pifang@redhat.com> <Y+TTxcCMpoa8umhj@yuki>
In-Reply-To: <Y+TTxcCMpoa8umhj@yuki>
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DU2PR04MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 66432a53-2e83-4581-e119-08db0a907b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SkD1jiQqKLrPjGbTZA+yOQ29jUTPtz/Pd5AzYjFX99y+751U/Od7tOkIt1vhmVMwzgINDX6X534Z5XaJCXJzEKmjIz/FleU2AI75MFvtxqsbNdMhWHGCxTa8Bg8dcglImjFFPzTmYj7RCGqgwaGkJVmfJEV9xrdOYBOviycB1tJr7n7uP4K/jVDPeIOkXEjQ6hr8daVkaLaz2pPiznm2+zSGgVoWNQgSk58p1oPgKgGwWOMaWsKTWpkIq5ijnIChrZWjUnCR6S+w9IIF2Zz2V8cmZytRETLzcv+jwi+o+J4LMfLQ9PtACKakhJSM90WYSDn4k2tuXOC0L1oRteFAPOtgeQG9K0Y3nUkDTehd1u8fLTYRx7OOpXFW62JmG1EPjd+QRQrk1e0+GmJFAx6QNbior5TZY6e+sWverBqaoT+C6suyOAxZ0Y6iRX/Ip90KYqFjQF91URDNVzQht2MLPO1fJGry0/VZD60Q32HYAWFXpDXF4CzWHJJCYFi1Sdl9sQq6kAGGqyhv6bMcrL6CMIsnbVnqhePBfngSYjtTnQyL6hfHFjeOtGW5+RJ4jAgfo/GrZlr0Kg+pBB561QpFQYM7H4QlPHDgF3ocCKn6r2nkPHklKza/XxiKv1SALHnFTwTNvOuZ/Ie1A3AsHrPhE3uVIWQCcFQI8iFC6QzEfoInx4aX0SfCvVgQwdQSQsCz0s0nZKZeSNJJ+WEv5wpa0KSgiEXzHlY8WIXns1PAoXK6XWLI/341fJXQ3gQ02G3MngLFLS0blin6jF4hFPc8TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199018)(2616005)(478600001)(6916009)(41300700001)(5660300002)(8936002)(44832011)(26005)(6506007)(186003)(6512007)(53546011)(36756003)(66946007)(83380400001)(8676002)(66556008)(66476007)(2906002)(31686004)(38100700002)(31696002)(6486002)(966005)(316002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFNpM3UySzF4VEtscW5GMElhdWNHVjVjOUF4am9RdENkL0RaY0ZOQkRIQ0RG?=
 =?utf-8?B?VDNtSlBVQUhEMDdOZnUrRTRYQVhRVmJiMzRtZ0lUUTRNVi9OWm8wdmhMWmtU?=
 =?utf-8?B?STVzcnhSUkMvZDU1ZUo5UDA2UVhxdVRtRHQyUFladHQwMmNIMFYvQkxzVmg1?=
 =?utf-8?B?aitIM2dUM0pHbnFrMTdFZ2RkWEc3cEU3dGsvRXBmTW5sSXRCK3ZTZ3dEdDJM?=
 =?utf-8?B?SjFuOGh5T1prbk8xNkp2b0RYRktiRythczA0NnBwNVBYLzRBZEQzYkJ6eVN1?=
 =?utf-8?B?dkh3Q2RnRVlnblJBR3Myb2I1YW1SbjROdnZ3VU5WeXN6MUYrbURiMVBOdmw3?=
 =?utf-8?B?TllaeUhBa2lCOWVsUlBReHoyK3dNMTc3NHZTN2VKMzFGQk5USk4ycU8wOVJT?=
 =?utf-8?B?RnRZTWFIRUdXOFNSTmtHZmxTdTZqUUFSWnhKUmRoOUZVZmZpekRiTFlWekFu?=
 =?utf-8?B?dVhPUnhndTE2ZytudVV3Skw0K2VXTGc4SElhUTRlUXY2S0l3RURXbjNvTTJ0?=
 =?utf-8?B?UlBtaFNUQlBBS0FSakNLN24rREhmVlBEVlZJcFpwU0dxbXVuQlBrei90WWVY?=
 =?utf-8?B?elNGU1p3ekpLaElpUkxzbjNnS2cyZS9GK3BhNkhPZTRpb1dpR09uZ0ZUL3Jj?=
 =?utf-8?B?SVVmdm5FdXhycDZRS1o1RjAyMTJ4amd6ZzZmR0JNZjMrOFZOVkFSSFlKQWY3?=
 =?utf-8?B?Vmh5TlFQNFRNWk1CdTRHRWJMRUdLd3BLUmZRQWg1L1VwbkJpZEJQR2Ixd2Jx?=
 =?utf-8?B?bWRHbHNCbGRmcENqSGJIWlJrbTVKVmE4aGltajYybUloV3RpMEUzVlVZeEtK?=
 =?utf-8?B?SUwvc3R1YTNEcGc4a0RsYmxPZUtMRlo2ZFVReDBkeE00NS9pQmRITGlsSnBL?=
 =?utf-8?B?UkxVajY3NUdMeEJiZVB0Szl3NjJza3RLZ1ZtalN5Ulo0SDhOeGxrL0p0dzhw?=
 =?utf-8?B?NzllckQ2TzBFZVhQTklNZmNJL2tYOEFHdkpqL2FDN1RRaS9tNzVzb2ZpNi9D?=
 =?utf-8?B?ODU3ZHJTajVFSlVVZS9wemVuYmRmNXdwM3dNUGYrbHU3WHdoYmNIdGVXUkph?=
 =?utf-8?B?MWxaSWtkSFNtazZWYmEvd1llMEJmRFN3MmV5VGVGMkZoR3JqNThHNUdsQ3kx?=
 =?utf-8?B?aUh1Mnl4WWVZdmYwVXRYVzNqSDlZRmNxZDd3ei8wY0xwVmc0Y01SODhYT24z?=
 =?utf-8?B?ZzVyR3VobUhMOTRqUlFPN3R1cG9WR2pHbGRXcG0rQzd3b05nR28vdW9abTBX?=
 =?utf-8?B?K2I1RjBta0RUbjBPdmdOSlQzUE5Odld6SHU5SFd3c2l3bkVESUVOK2pwS2Jk?=
 =?utf-8?B?Qlg5TjNyTGlIN2dJTCtIcTZQV1c3aVhWWGdzUXlaU1lucHloT1hFSDZKVlh4?=
 =?utf-8?B?ZUZuOHFYZHdydWd2R09ZWHpwVWJmYzNIK1gyNXo1UFl4RGJMUkJwdlJoWHcw?=
 =?utf-8?B?YzVzYTZlL2FZb3FJWGkvTFJ1S0lYYjhrcXU5eW84clZ4TW1hZFJQZEhmUG1T?=
 =?utf-8?B?SVpkWFN1NWFoYmRLR1lGWlQ1NFh1WURaUitpVnZWK0VmREh5dVBNUnpMbmti?=
 =?utf-8?B?a2NhOGpQNndsMU5sSkc0RWFNeHhXY3lOQ3FjUEFreVR0cGIvZlJEYXlBU0N6?=
 =?utf-8?B?eXV3cWJvajV2WjdJMkpIZWpDSmdKWXZZalgvR1pLZS94Tm4wdXBJcm9admtB?=
 =?utf-8?B?dWg2N25MOWR5SW1vNWFlbWVxR2FuV0hWYmhQTkgxY0RIUEdLRzFrbWRZQmRY?=
 =?utf-8?B?M1Fna1d5RkFWTm5NMnQxQTk0aVc4bGUrenNXMnBteENWdWVNV1k0am9NRnh4?=
 =?utf-8?B?U2wxWVlVWUZSbEhCUnB2Y3pRd0ZZczVmd0sreWFuUHZOVmdUWWlBdjVHUkhU?=
 =?utf-8?B?Z1J3STQ2cDB0emxudEl4TGFVUHNiaE5oWUczbERUR1RjZlFDMUUzNkFoM0VS?=
 =?utf-8?B?dmRoVWxpSllGTDdhcEVVSXU3a3FwRUdlcjBnM0JOY09vTVRhS2x5S1dBQ3A3?=
 =?utf-8?B?UFdnMVpST2ZUUk01QnIzVDhSdDR1QStUUXpHc0gxbkd0SjlZZjRlSXFIdXFh?=
 =?utf-8?B?eWMxcjNCdE9oYnNVMnppc3F5VW9FcDU4TGRmMnl6MUVER0FUNENPL2lSMXpU?=
 =?utf-8?B?SVJoUWlLVFc1WnI1MVJDeWRBWFFsVnhpVDlvYkhjVVkwdEVrNVczeFRJMGJF?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66432a53-2e83-4581-e119-08db0a907b42
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 11:26:26.4168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTqfxAn83RDz1Jak89Xa5nvE84JsiESJWTcooWbQFgaFo/a5d8of3IW9K4HmAdmhS68GU4wUliSpMxNEtoG3/cdwXr8KWs1oCZN6y89PQQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9209
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] aiocp: Filter out O_DIRECT before read
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

SGksCgpPbiAyLzkvMjMgMTI6MDYsIEN5cmlsIEhydWJpcyB3cm90ZToKPiBIaSEKPj4gV2hlbiBh
aW9jcCBleGVjdXRlZCB3aXRoIC1mIERJUkVDVCB3aWxsIGZhaWwuCj4+Cj4+IDw8PHRlc3Rfc3Rh
cnQ+Pj4KPj4gdGFnPUFEMDQ5IHN0aW1lPTE2NzU1MjA4MjQKPj4gY21kbGluZT0iYWlvY3AgLWIg
OGsgLW4gOCAtZiBESVJFQ1QiCj4+IGNvbnRhY3RzPSIiCj4+IGFuYWx5c2lzPWV4aXQKPj4gPDw8
dGVzdF9vdXRwdXQ+Pj4KPj4gdHN0X3Rlc3QuYzoxNTYwOiBUSU5GTzogVGltZW91dCBwZXIgcnVu
IGlzIDBoIDMwbSAzMHMKPj4gYWlvY3AuYzoyMTE6IFRJTkZPOiBNYXhpbXVtIEFJTyBibG9ja3M6
IDY1NTM2Cj4+IHRzdF9kZXZpY2UuYzo1ODU6IFRJTkZPOiBVc2UgdWV2ZW50IHN0cmF0ZWd5Cj4+
IGFpb2NwLmM6MjUwOiBUSU5GTzogRmlsbCBzcmNmaWxlLmJpbiB3aXRoIHJhbmRvbSBkYXRhCj4+
IGFpb2NwLmM6Mjc5OiBUSU5GTzogQ29weSBzcmNmaWxlLmJpbiAtPiBkc3RmaWxlLmJpbgo+PiBh
aW9jcC5jOjI5MTogVElORk86IENvbXBhcmluZyBzcmNmaWxlLmJpbiB3aXRoIGRzdGZpbGUuYmlu
Cj4+IGFpb2NwLmM6MzA2OiBUQlJPSzogcmVhZCgzLDB4N2ZmY2Q3NDNhYmUwLDQwOTYpIGZhaWxl
ZCwgcmV0dXJuZWQgLTE6IEVJTlZBTCAoMjIpCj4+IC4uLgo+Pgo+PiBzeXNjYWxsIHJlYWQgbWFu
dWFsIEVSUk9SIHNlY3Rpb24gc2FpZCB0aGF0Ogo+PiBFSU5WQUwgZmQgIGlzICBhdHRhY2hlZCB0
byBhbiBvYmplY3Qgd2hpY2ggaXMgdW5zdWl0YWJsZSBmb3IgcmVhZGluZzsKPj4gb3IgdGhlIGZp
bGUgd2FzIG9wZW5lZCB3aXRoIHRoZSBPX0RJUkVDVCBmbGFnLCBhbmQgZWl0aGVyIHRoZSBhZGRy
ZXNzCj4+IHNwZWNpZmllZCBpbiBidWYsIHRoZSB2YWx1ZSBzcGVjaWZpZWQgaW4gIGNvdW50LCBv
ciB0aGUgZmlsZSBvZmZzZXQgaXMKPj4gbm90IHN1aXRhYmx5IGFsaWduZWQuCj4+Cj4+IFdlIG5l
ZWQgZmlsdGVyIG91dCBPX0RJUkVDVCBmbGFnIGJlZm9yZSByZWFkLgo+IFRoaXMgaXMgbm90IHZl
cnkgZ29vZCBjaGFuZ2Vsb2csIEkgaGFkIHRvIGxvb2sgY2xvc2VseSBhdCB0aGUgc291cmNlIHRv
Cj4gZmlndXJlIG91dCB3aHkgd2UgbWF5IG5lZWQgdGhpcy4KPgo+IEJldHRlciBkZXNjcmlwdGlv
biBzaG91bGQgc2F5IHRoYXQgdGhlIGNvZGUgd2hpY2ggY2hlY2tzIHRoYXQgdGhlIGRhdGEKPiBo
YXMgYmVlbiB3cml0dGVuIGNvcnJlY3RseSBkb2VzIG5vdCB1c2UgYWxpZ25lZCBidWZmZXJzLCB3
aGljaCBtYXkgY2F1c2UKPiBhIGZhaWx1cmUgbGlrZSB0aGUgb25lIGFib3ZlLgo+Cj4+IFNpZ25l
ZC1vZmYtYnk6IFBpbmcgRmFuZyA8cGlmYW5nQHJlZGhhdC5jb20+Cj4+IC0tLQo+PiAgIHRlc3Rj
YXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW9jcC5jIHwgNCArKy0tCj4+ICAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW9jcC5jIGIvdGVzdGNhc2VzL2tlcm5l
bC9pby9sdHAtYWlvZGlvL2Fpb2NwLmMKPj4gaW5kZXggYmMwZTIwOWIyLi5lNDI1MmQ2NDEgMTAw
NjQ0Cj4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW9jcC5jCj4+ICsr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW9jcC5jCj4+IEBAIC0yOTcsOCAr
Mjk3LDggQEAgc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4+ICAgCQlyZXR1cm47Cj4+ICAgCX0KPj4g
ICAKPj4gLQlzcmNmZCA9IFNBRkVfT1BFTihzcmNuYW1lLCBzcmNmbGFncyB8IE9fUkRPTkxZLCAw
NjY2KTsKPj4gLQlkc3RmZCA9IFNBRkVfT1BFTihkc3RuYW1lLCBzcmNmbGFncyB8IE9fUkRPTkxZ
LCAwNjY2KTsKPj4gKwlzcmNmZCA9IFNBRkVfT1BFTihzcmNuYW1lLCAoc3JjZmxhZ3MgJiB+T19E
SVJFQ1QpIHwgT19SRE9OTFksIDA2NjYpOwo+PiArCWRzdGZkID0gU0FGRV9PUEVOKGRzdG5hbWUs
IChzcmNmbGFncyAmIH5PX0RJUkVDVCkgfCBPX1JET05MWSwgMDY2Nik7Cj4gSSBndWVzcyB0aGF0
IHdlIGNhbiBhcyB3ZWxsIGp1c3QgcmVtb3ZlIHRoZSBzcmNmbGFncyBhbmQga2VlcCBqdXN0IHRo
ZQo+IE9fUkRPTkxZIHNpbmNlIHRoZSBzcmNmbGFncyBhcmUgYnkgZGVmaW5pdGlvbiBlaXRoZXIg
T19SRE9OTFkgb3IKPiBPX0RJUkVDVCB8IE9fUkRPTkxZLgo+Cj4gSSBzdXBwb3NlIHRoYXQgdXNp
bmcgc2NyZmxhZ3MgYW5kIGRzdGZsYWdzIGZvciBhbnl0aGluZyBlbHNlIHRoYW4gdGhlCj4gZmls
ZWRlc2NyaXB0b3JzIHBhc3NlZCB0byB0aGUgYXN5bmNfcnVuKCkgaXMgYWN0dWFsbHkgYSBtaXN0
YWtlLgo+CkkgYWdyZWUgd2l0aCB0aGlzLiBQcm9iYWJseSB3ZSBvbmx5IG5lZWQ6CgogwqDCoCDC
oHNyY2ZkID0gU0FGRV9PUEVOKHNyY25hbWUsIE9fUkRPTkxZLCAwNjY2KTsKIMKgwqAgwqBkc3Rm
ZCA9IFNBRkVfT1BFTihkc3RuYW1lLCBPX1JET05MWSwgMDY2Nik7Cgo+PiAgIAlyZWFkcyA9IGhv
d21hbnkoZmlsZXNpemUsIGJ1ZmZzaXplKTsKPj4gICAKPj4gLS0gCj4+IDIuMzEuMQo+Pgo+Pgo+
PiAtLSAKPj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCgpSZWdhcmRzLApBbmRyZWEgQ2VydmVzYXRvCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
