Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A656FC05027
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 12:19:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 932F13CBF6D
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 13:19:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 154EE3C1D84
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 13:19:13 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5DA8E600281
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 13:19:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NacYDRCCnbbyz1KqNOHi6lZ/VXowY8MViHnyfgT7lbrBNVlLAlwUemqJhou9zrNHSZ86ExelSI9XjDDd3J15aFNtdK01HKXCIhoCP3mD5jGc8vBRwDGumw8Gzn8lBkPCqvr/hiQXvw9tYRzEsvP7peTMrxUSDdBNMXHr+tvKttHkYvxdofBX6URST6OswpClAjt+GWVm/v4qoDzDOBCCOityskkWl01XwmoWCppJcw1bPNoKSXOBEgvCjL5y+5AMqR8xg8aZIxlH5tazhmkPYAZhbbhqI8yhLsxN5VTICk2VoFwqHwDVzW11EFZlDGoihwdMZlkPFnmQ5In9aoaENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNedNUEZP+NIYo3/1MXjXDwCbFMsPVibvn6CbxfeWGA=;
 b=BGm+tH28nkGsURfjSHUCFrPNrG8PI0AN43HIYkM+5p7wcmhKLF2yHYXegnx2Zbo3zriRWcaLbSbAb2taFHYrvZW6owaJJ85U7EMb9abPaFQ/Ra3KnMjZDAkprsUJF2UiQGhRpEX2e7ZMacP5VbykF3x/+7ONTGj1C1f1iZh8g8GqhERf/z906t4CBhtM9ejw4YxYqhfkDFNkLdfc0YVEqH4vqQP+tV/sX0hJcLz+IZGk5ELdbNIqSvmwDVGIDYLkKZc1rv1fRUKRAXqeblA/DxVWvXfTFX5tA8pInxqlVisiLTTHhcCCGRqcNC3iOc33XrYGA3x9eHPFNrt+HNB2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNedNUEZP+NIYo3/1MXjXDwCbFMsPVibvn6CbxfeWGA=;
 b=ZLRjcYa+xNiv/q7BZBIJEEVVRNAkEf1i4KKbjUsvPhq7sSD96HlpO/RZSF8l4V/1RCi2k32yW00oPo7SabyVpfyG3aIbx0oLKufOCy2OqfyBGtQoAU09gDjAE+QpLB3Reqs9Zd6Bm3iJqFHM8uwEcwuXhXjHTfHVHoW3hbwlG2NlC5q9wPnTThqh11HBdHnjVd5tkHmBMygGOzIpsZqqGxMBpgl4cdQd1niPDNeJgzGJl/I3t1/MWn6s6vjFs+P/NMNmAdYXWl8az2fV3HS7MUJZgJJ8wwDjUPO5/jGxLQdW8zGa1wqMQ3r/wCIQGBJQhsRSJSPJZ5PnnshwX5h18Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 12:19:09 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca%6]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 12:19:09 +0000
Message-ID: <9e6a10c2-a312-c926-f935-2b12838a3369@suse.com>
Date: Tue, 14 Feb 2023 13:17:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20230208091120.9994-1-andrea.cervesato@suse.com>
 <Y+ZDlj7gSCgdWFC1@yuki> <5be1311a-6057-5362-93f6-ee623279e79e@suse.com>
 <87r0uso9xc.fsf@suse.de>
In-Reply-To: <87r0uso9xc.fsf@suse.de>
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM7PR04MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce76b80-5049-46a9-e7f2-08db0e85ac7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UxfsGq17aVYPrvrtpmj905GwvkEqT27UZ8ur5GSz8+LaAvBxj/hLSmtp+Wu+oICI6wqyOQq2APHjm2+rLwqw01MG0CNYF2fyG7SlcAU5AvtYsn8lTvrhQqXEjU1LlN/dVMylry9RCHHViGadfXuJxvYRr+VfnFg5cLTAF09u5QvGHts6rcoNe2vrFYULaqzgnO4nxfqW+A5pg3yXSccfOfatU/kKW/nNwZ9f2XaHemqYTBYUQuaJyjYf+/GyVZ98PNB8aYvl7ZCcOeC/KGPI+Z6o7pxTFkjOXnGpQYPFEDjgg9JyEdWoB5TdKWYPNt7T7XZk42/B7383wS8rwuh22CgIQsKpWNApBWidQOgeGLKUWSUe4up6j9b1OgpVp7LVmRs337rHRBtCYf0TkPgoF8pvbIzHfsxFa+tRgSmytl8id29vFRjwHgFeKs2TapQUojP8URa7YA+vQXKhoma2nyDxE3rBce2Eqk7Na2SC3t+EOoOXLVf9SpOfOjw1D0oJYXBTHKhBxByVofEp1NNzHHkdPe6HYZslk6cigKyiXHIpZnizUxc+oyWda6w5qV7bB3LRZH4fo80nVsjDGEv2OM7npTmdYoFpLiFwDkViLveWuqPRumFtHTLzT+mSoEzwqSG9gvMYZHGAHyDOT8vggASG1KajYDA13LJFlh/Mn9wN74WHOqi0tFsTH/3Gz0mLisCUWquRnMeWREf3LbkLJ8S/F7xGl6N+WyUZ1M/+BA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(136003)(366004)(396003)(346002)(39850400004)(376002)(451199018)(31696002)(86362001)(36756003)(38100700002)(66556008)(4326008)(5660300002)(41300700001)(44832011)(66476007)(8936002)(66946007)(8676002)(6916009)(316002)(2906002)(2616005)(83380400001)(478600001)(186003)(6512007)(53546011)(6506007)(33964004)(6486002)(6666004)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZNZFZBV3JsbkdFeVE5ZnJiUTJMTnVvTFNoelpBU0U0TWgwaTZBWks0b1RN?=
 =?utf-8?B?NU5hQncvVGI3YjF3b1dzbXZvRUhtUkw3b1ErdmtacktTb2IzSEJQeHYrUkpy?=
 =?utf-8?B?emlXTTczZWZ3Y3BpSTV1VmM4dW9wQVlVQ2JKS0RRTnZmYkJkUWZFc1hHZEtj?=
 =?utf-8?B?UG9BeUJlVVFTK2JrQUJFRkZ1Z3RtOHUwUURoZDZiUHFTNXFVRVkxbE9YdjM2?=
 =?utf-8?B?VVpISWxHN081L0w3a0dNY25zMFFmVGF0dHlvMjhtcC9TMzdIa3VFMjdZK09k?=
 =?utf-8?B?bVkxRjNPb24wOTNGcjcyeTVqekVWSTM5a05KTmpoZzU2a2dlVVlKcTJJY0pV?=
 =?utf-8?B?M0R2bzZOb3RoUlZsRXF1OGtxTk44SmpKZDBZamVTUitoZkZXRXM1dTROMkxa?=
 =?utf-8?B?b1huZXNRbzN4RjN3dzRpOWZGL0RKdm9icDYvQ0wxTENEdERuZU4xVDlYeWtP?=
 =?utf-8?B?U21kRTFMdGtwSkNRSWZwMmlQTlk0ZVpqMFpnR3Y3c2g4ZHlpS1Y1RU1RY1ZI?=
 =?utf-8?B?ZHo5dGx4T0g5eDB6QkZFV2U4dU52WkJkWC8ramcxeHRqRCtDbEV5aEs4clJq?=
 =?utf-8?B?L2t1MEtWano0aUdudWtITHBsaTFhaCtHaEhiT1VsbUdaSkFkYTNSZiszdU05?=
 =?utf-8?B?OWpaTGRlRnNiSW5yaGw4MGlTUFdrd2hzdklLRHVtcGh5Zks1clUrTnFHOXlW?=
 =?utf-8?B?MU96TnJIWVkwVG9TQWoyMjF5dGlSWGlJSjA1ZGFXcHFkY2lWQ2xlOE96clM1?=
 =?utf-8?B?TXlvTVMxd2J2TktRaUhTa0JYemdwRU52YklIOU1FRmMwZXI1dTk3ZE5IcHNW?=
 =?utf-8?B?bzkxTFgwc2ZYK1ZpRnp6d2NKSXJqWGt0NHoxdjRZckZCYk0vR0dCWVdjRUQ2?=
 =?utf-8?B?ZW1yMHoyS2F0SGVLVHlGbURXTWhRQ3pCVmdPTTNLTkQ0alpWbGMzckIyS2g0?=
 =?utf-8?B?MFM2ZTkwblBUbEZkT2JOM3ZUQ3MvSTJYTFBnMXgxdHRqbm5td09RSXdzVmVH?=
 =?utf-8?B?MHFtVUkzR3J2dHhaUld4bEFJNG4zSEVXWDd1RlBYaStrV0dSdGVrZkx3dmRU?=
 =?utf-8?B?ZzJKT2RTQUQ0cUFQTDlIUUJBL2dYOG8zbjcvTjd2MEp4eGRPcEdQUWxJMEJE?=
 =?utf-8?B?eSt1UC9ITmRUMHlKNDJFQWxyc3pYa2VWaW9VdWd0dWFHc0Y4Qm9ZbHlUZ3ZK?=
 =?utf-8?B?bldzS0xkN014UkxZTlBPZzRuWTFrSlF2OFJ3MXI3cW9IWkdYWm9iRytrbVhp?=
 =?utf-8?B?YXU4TGIzdXA4NXVtMXQwa2hwaCtNUlZIdnZ0RmlzV09pUmZ0RUZOYVI0cnpU?=
 =?utf-8?B?Vm93dHJIZStaMFovdUVtaDdZQjlHWWtDQUtna0RXb2JGWGJwZHNpS280Tkxq?=
 =?utf-8?B?cGNlUDdCeStYQUkxYkV6dXVqZyszd1ZCR2dFNHI1cFA3ZnlSZDZSSmxVZi9a?=
 =?utf-8?B?UThBbnpKRWFXSkh4Um9WMEMzSllUUFg3VlhJMFZUSXdsY2hVZ2lMekxISEtl?=
 =?utf-8?B?RDRuYys5Z3J3ZENQaVNjcE5LbW8zOFZGRGVSc1o3aTR5ZTNYYzJZWW1CVlUw?=
 =?utf-8?B?b1R5a1BjT1VyUkw3aTBDelB5Y3JFdU8xUVY0S2FPUHlpcHUvUExoU3VnRzNk?=
 =?utf-8?B?aUZka3g0L251UnQyT1M2eFNvd0hBdFdVbVJxeFI5eGQxbmFPVnk2eVVudWpQ?=
 =?utf-8?B?WUVKNUthZll3bnEvVTdjTzh0RzNhS050aUNjVEZweWY2M2Y2VnlpNmdxaXM4?=
 =?utf-8?B?a2hUQUU1ZWVGcDdUK3FaQjZJMXhMdDBIeEhoNWhhdnFpNjlKWGVLclE2ald3?=
 =?utf-8?B?U0RDZTRNbmRXVlV1d3MzbjJxMTNOUFJ2bXpEdkFLazVtdDFoUVpEd2VSaWRG?=
 =?utf-8?B?NlVMZXJ2OFBkbHVzcURqSFpVL3NrWXpWNVo0NWs1bGdVSlVyb3dsbU8xZEdy?=
 =?utf-8?B?WUtnZkpDaU1NR2lkeVhVbnFVTkFBRmUxa0V4b0Y1TVVsTitLR2x6K3QyckU0?=
 =?utf-8?B?WFJsQ3Z0NWFORnNNZlZaRVpjQm9iZURnM1pyaitaWVlibk43RnkxUElnSTh0?=
 =?utf-8?B?bVpGL2NMNGJ2bWpZQmdEL2pJK3I1MW02cUJTdmoxSUJHZlJpZ2poK2hQZ2hT?=
 =?utf-8?B?dXpkY0JIOWU0SEFNdnZrVHZwR2JhaWo4NWlMa3c3ajVQQ04vbWthK3JuWHVz?=
 =?utf-8?B?QzNXb3JtR0ZlcS9aQWpOVDNiRDBxYlhNTWM0S1ZjWTcrakJlb2dRMWU3M0kz?=
 =?utf-8?B?M3FRRmFSaTNVYXBuQzBtN0svUGFnPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce76b80-5049-46a9-e7f2-08db0e85ac7a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 12:19:09.1794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +P7gnLph3CRO69zn0fy7ZQzcecgJEaroJ1jQ6KuZ28jfT5VY8+Jox3WVNGoa7WlZnympmSk+0q9zXdrixLYEPrmMTMbU3I0w9W/Wvjhx35M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] Refactor pidns30 test using new LTP API
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

SGksCgpiZXdhcmUgdGhhdCBub3cgZ2NjIHJhaXNlcyBhIHdhcm5pbmc6CgogICAgcGlkbnMzMS5j
OiBJbiBmdW5jdGlvbiDigJhydW7igJk6CiAgICBwaWRuczMxLmM6NzI6Njogd2FybmluZzogdW51
c2VkIHZhcmlhYmxlIOKAmHN0YXR1c+KAmSBbLVd1bnVzZWQtdmFyaWFibGVdCiAgICAgwqAgaW50
IHN0YXR1czsKICAgICDCoMKgwqDCoMKgIF5+fn5+fgoKQW5kcmVhCgpPbiAyLzE0LzIzIDEwOjQ3
LCBSaWNoYXJkIFBhbGV0aG9ycGUgd3JvdGU6Cj4gSGVsbG8sCj4KPiBNZXJnZWQsIHRoYW5rcyEK
Pgo+IEFuZHJlYSBDZXJ2ZXNhdG8gdmlhIGx0cDxsdHBAbGlzdHMubGludXguaXQ+ICB3cml0ZXM6
Cj4KPj4gSGksCj4+Cj4+IE9uIDIvMTAvMjMgMTQ6MTYsIEN5cmlsIEhydWJpcyB3cm90ZToKPj4+
IEhpIQo+Pj4+ICtzdGF0aWMgdm9pZCBydW4odm9pZCkKPj4+PiAgICB7Cj4+Pj4gLQlpbnQgc3Rh
dHVzOwo+Pj4+IC0JY2hhciBidWZbNV07Cj4+Pj4gLQlwaWRfdCBjcGlkOwo+Pj4+ICsJY29uc3Qg
c3RydWN0IHRzdF9jbG9uZV9hcmdzIGFyZ3MgPSB7IENMT05FX05FV1BJRCwgU0lHQ0hMRCB9Owo+
Pj4+ICAgIC0Jc2V0dXAoKTsKPj4+PiArCXJlbW92ZV9tcXVldWUobXFkKTsKPj4+PiArCXJlY2Vp
dmVkID0gMDsKPj4+IEkgd29uZGVyIGlmIHdlIHJlYWxseSBuZWVkIHRvIGNsZWFyIHRoZSBmbGFn
IGhlcmUsIGFzIGZhciBhcyBJIGNhbiBzZWUKPj4+IHdlIG9ubHkgbW9kaWZ5IHRoYXQgdmFyaWFi
bGUgaW4gdGhlIGNoaWxkIHByb2Nlc3MgYW5kIHRoYXQgc2hvdWxkbid0Cj4+PiBwcm9wYWdhdGUg
dG8gcGFyZW50LCB1bmxlc3Mgd2UgcGFzcyBDTE9ORV9WTSBvZiBjb3Vyc2UuCj4+IEZsYWcgcmVz
ZXQgaGFzIGJlZW4gYWRkZWQgdG8gYmUgMTAwJSBzdXJlIHdlIGFyZSByZWNlaXZpbmcgdGhlIHNp
Z25hbAo+PiBvbiAtaSA+IDEuCj4+PiBPdGhlciB0aGFuIHRoaXMgaXQgbG9va3MgcmVhbGx5IGdv
b2Q6Cj4+Pgo+Pj4gUmV2aWV3ZWQtYnk6IEN5cmlsIEhydWJpczxjaHJ1YmlzQHN1c2UuY3o+Cj4+
Pgo+PiBBbmRyZWEKPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
