Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A02C46CA1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 12:57:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C10C3CE4EF
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 14:57:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD0393CA8CE
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 14:56:55 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0D0516006DD
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 14:56:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkUtc4fVVBjktSCDYMDlzdNE31aoxdrjodFU8XZQP2tubb0eN/WrNBjp6BQL+mPnWPC+9rVbWu2mXNhyWVlEnrQfpBWVpB2neUKppm6Kn7D+tzuq3EYTcTBT136N93VZEmpP0BZ0RjOljprPwUwzRcYfewqPMVASPjPF5sXDQv0drUJ7QZXPREfdX1N0gRsCg5zPsZEhExdhwzRkSJWs9HIPjd3MbQsDoBYGTgb0+Cv6gnitTdjbtKXxkTTSPyoH/nL+T5+iT4E11T0h0v8z6y8wADXQ8RwsY4Fy9VUaI2q/ITdH6KzCeBH8dma5EKZV/0C4xq72sP4fETkJT1Sysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX1woJb6J6KLH/llLq76d+tqCqUIDZXlD6/xa3OrDR4=;
 b=b002axdL39wfCr8MJd0SLNxdfyfr5FxJ39FbI63pEuSrO9ApSrZu7GRvjHJAQCwbnxMoiixze0dDAhgc44O9KnGaxt5zcO+BGWlk/rohvqWDsNMSthABob3C8P+vQF6WihLogkb28oI0NnQRI53sC53yYvPFMdX8gC4i6P3qIn5DIE6tVmI5eKuPEtLfbsCPG1mQBKFsQ7QfCn2tbokORs3nREzl6DxJ3Ux8BNoRGUlimRIhgFMeoEzxj+ziTpclRjui8/ECjBIhVAJ8P7j4DDDGTdRAfxU992oyGk8aaJeXgYhWZMQ1ke3/4KAufP2+mvZMncQQF5Cuh69utahDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX1woJb6J6KLH/llLq76d+tqCqUIDZXlD6/xa3OrDR4=;
 b=seAPXpAJaKw72sTQA9UKKMCFTERUUIuQlMP8JF7B2mDwPAVZzw9DZapfIZOGhSgSnNWeVYHpO/YsbZIsYx27z+sg90j0s2u0+oN3nJhu4w8QFYuZ0/LWWRBwnLkP2XaGPvMLdxdFVV9VzBaXOsmuntE3NoOV14AgMqXbSaEAREMKoi/W8mFDPXkocETaLF5Z9FJ2FvMHdal68ukmc8tXNgWADIwXfZuWiyn7wxVpiTty4u2j0IItB2cNckDebQUxgIfEVyKjF6BFGc5PLBJ+UahdY5XXr9Puf0HGPth1xFq0X8ULm9ctA6QpCiBvVILpbyPFASlzhMpz9zViRNKPsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS1PR04MB9455.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 12:56:52 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 12:56:51 +0000
Message-ID: <343b5e14-c12f-4321-8b50-842d6b458ad9@suse.com>
Date: Mon, 18 Sep 2023 14:56:49 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20230915114503.30942-1-mkittler@suse.de>
 <d67de760-ba11-4b28-9959-5ba0ebb1771a@suse.com>
 <8272498.T7Z3S40VBb@linux-9lzf>
In-Reply-To: <8272498.T7Z3S40VBb@linux-9lzf>
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS1PR04MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb66975-f905-4a29-a3ae-08dbb846ba51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3l5XN5ypdi7uXSfIVXsbs8PycbbWBmszz9G/mCHDRE8IXJzOJ8TfcmZKA30CyGG0p2deTl8s1hYrNrKDpKnaC5sLn6EHhUms2YdyFZVXBTO3/MkzhSbY2QrhyjAhTTXsGVvA+vkWt/EU94vZUR65ktdfCa+DKSHcCz+elX3bhcuO+B02/ryBjYbCErljYwxE0LIzh8p5t4DirHX9DZLu99pUJMXtA5gIQa2UUCTE9mPwjaRFjZsZ3j8ikKZEYkUUyHoxKO+xSJt4OOVFPSmuvO8MrRyHmC3VrE048mcibYnr9pcmY2DJgHgcxrDWoLp4qTHBbrwZcdlCWWDq4rRY038R5+MIxpjWi/5CxRQ22Z6NNlB4W2UAKtLIx/eOERmsYMklNYtOgc+21fM9Jzqz050Ww/okYOlwAJGLp4FoBnJM9xEnJBHM2X0icmg0mj0gBsJ9YTDUL1DudhYXDaFGkMtOet82NBkvvOUYkWwYn2WputoJiaWeO5GglKpLDAyM5Uqe3klL0XZRWqT8aCqN1og/KZNnD9YhWHDud0W7PDIjwWjZLqHWCh4yNtdTbeF6FnxSwNRp8L2X56i88LWUlSl3dTcJeDsW/qHIk4FqkT40HhaxDXpDIXxLMztt6907fPRgCx0MvMZi3SsUFDqxLQrukM4Jx5PIkJ42/A03wY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(1800799009)(186009)(451199024)(53546011)(6486002)(6506007)(6512007)(83380400001)(478600001)(26005)(2616005)(2906002)(44832011)(66476007)(66556008)(66946007)(316002)(6916009)(8936002)(8676002)(5660300002)(41300700001)(86362001)(31696002)(36756003)(38100700002)(31686004)(81973001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUFjTlZ3Zk1TOE9QSS9lSHphNzZWR0tLS29XOFhzNy9tUkMxVkpVYmV2TGtz?=
 =?utf-8?B?QktOdUovUVB0bEZYQy9IZHVENS90ZHBKUHptU1B4RnVNVGZObFZGWW9hZUpR?=
 =?utf-8?B?Tm5lYmJhb0tuTVNoZTFRTXlrWUdkYUJaa0ZYNTQ3b1BxNXBMdGg5NG14ZGg3?=
 =?utf-8?B?Zit3NE9CYkR2ZFJoRUVnKy9jaHNTQVZXdy8zNlYzYktOQ3g2bW8vSWNXRk8x?=
 =?utf-8?B?RVAzUzhlOFIwYW16ZUtwUFlKRS9iYzBUOHZLT3IzS0t3Z000VUw4VEtQNTRQ?=
 =?utf-8?B?VEY4SmpnaFpIK3pxMVMrT1NVdERyZVVNVnNhbFk5UkdGZGZJYXpRYXphWklB?=
 =?utf-8?B?dDdqTzJLNVo1NGZOcUlGVWN6NEJJSGNsM1dtY2NzZWt3YVBkS2ZxMENRNkF6?=
 =?utf-8?B?ZXRmQVFBN0hWRzM2MDJUVVA5dmpuY01jZGkyNWh6dENxSUd4VWg4MXZ6R2sw?=
 =?utf-8?B?ejM4dE0vUWpQdmptM2FoVUtvT25vdVZoUXZ2M2FwNWZHQTN2MmJKZzFOQjZN?=
 =?utf-8?B?ZU5MWDh5dkJNaVo4WkV3d2s4QWxpUzBpWnNvWllOT0VBd1VabElFenlxS2hW?=
 =?utf-8?B?Z3RhbDhxcGhsMlVkUG03Q3RJaE5hUDBabnhMZFRNaGFGQUw3Y3ZCK25nRy9u?=
 =?utf-8?B?bnJUbzM3YjZOYk9qcFFrRHpKdW9LbFRPT3RpclhzMThtQkZ2enpEVnZYVWEr?=
 =?utf-8?B?SzEvK2FMaFZQZXp4c0pWOUhCSysxRmg1NEJia1RRNXdzeGRTblVIMlg4M3R1?=
 =?utf-8?B?MzhWNmhiWThKTFVDdkt4bFc4NStkV1FLVkJYNXRKWk9MM0JIdEtzcTQyb0Rl?=
 =?utf-8?B?ZjBkcG9BUjZQU24vYU5rS05Ib0p2Y0FVQmZCTGU2eWhwd3FhbzlMS1ZPWk9k?=
 =?utf-8?B?ODFFVXhKRVY0SXo2QVVWL091YmFldC93ZXJWbzZqdmtLR1RScFA3UnlMaWxl?=
 =?utf-8?B?STFiY0Y2M1B5SVFITElwNXlzYm5hdnFEcFBKcnBsd3lDdGlUdHlVdmUyRk95?=
 =?utf-8?B?VmlIQ3J4c0xSTUZvSWN2T0hONE8yeUdIOVZFTXhXVHVFWE5IY0dpU1U3dWg2?=
 =?utf-8?B?dUJvbkhaUURwVTAra0F5dnJhQ3ZnVmgveVIrUWlWQ3VINHZyM2RRS2lka1E3?=
 =?utf-8?B?REwveEd4TDJvREdURkNYNkcyK200V0RxcS8valNadWVUZE5WVVZiVFdMSDlN?=
 =?utf-8?B?cFJqcU8wOEZXeTRsUkpvYS9ZUlE2Y2I2NjZrZHdIeHRuZmcvNVR3VkIyOW5M?=
 =?utf-8?B?a1Q4T2E4aklRTVdobmxPUzFDQlVoU3hJUHpXNUt6N2pSVzJsSUtGSDFOZDZO?=
 =?utf-8?B?c0hFMGR3eVpvd2JxTnJrR1ZBY0JKQ3hVZmRSdkFPQlEyZXFCZ2pTQ1hwaitB?=
 =?utf-8?B?cG1IV2J2RUl5cVE3UmVIb24vMjFzSSszOUdMMUlESXFqeUpEWUU3RWxsbVo0?=
 =?utf-8?B?V2J1VUp6dm9aVDhITk8rcFhYRmNZQlZxVEk3YUNhWXA4U1JuNHc0WGR3Y3U2?=
 =?utf-8?B?Z05peEJnUEFxNmxNVU56T2pVMnk4Z1N4ZTNwTWNtQmVrL2tSOVRSS05OWmFL?=
 =?utf-8?B?cWxPcmZqUU5BUU1ZQnVJbHJ5Q0FENng4Z0p1QVEyRmtLSEhSdmlMZC8waXVs?=
 =?utf-8?B?Ry9xTHB6MjZEUDM1ZENVRU9sNWFkcWlEeWw1WmlUOGY4d1lWY1pPR2o3bnFJ?=
 =?utf-8?B?TE9QWGp0c2JlUFptMlpZM3B2eUI1QXZoK01xcmlISUZINmpmeGJuNnl2VUNm?=
 =?utf-8?B?SUJEWmloQ1BYd1AwZzdoMjJzZFhPM2ZjNmw1cHhJa3c0VGNETDQ1TkFPTEM2?=
 =?utf-8?B?MWtoRUF6c0ZJUnZOQXc4akZVK0I3VVAvYXNaamVic0kzaldNMm5Wbm43NTRZ?=
 =?utf-8?B?SkV5YVZsSGdTa1Z2cnZTdHhQbGl4QkY0SERzK0xoM2VyYzVRY3gzeSt6WnJF?=
 =?utf-8?B?UHQ0eFl3UDNMblQwL3JiNHhERWhYMlN2YnF0QitkMDI1cDRyT1FXZjJpeCtI?=
 =?utf-8?B?bVZmUU15TjRxdnN2dis5TEtHR0tmMndtSmxrQ202TERSL2Y4bmx2TXEweDVH?=
 =?utf-8?B?MFJwSzlkbzdVY042YkNBQnh6NGdnemg1Qk1Oc04wVzRZbzRTS3hLNFdyMGpJ?=
 =?utf-8?B?WG85NXVMMVh4OWZNSWx0ZStHVS84YXduVWcralNTb1Y5ZjdxK0ZYd0Fna2FT?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb66975-f905-4a29-a3ae-08dbb846ba51
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:56:51.7950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1sZunlLrGbOdYsCc2t32Y9ELG49weGZ5OKvUR1cwp096W18a12YGn+6trKSwu6rhS3s2XrwIlplxua31aAw5ZPrAGlDwMzhsnmpe5czOmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9455
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Port `getxattr01.c` to new test API
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

SGkhCgpPbiA5LzE4LzIzIDE0OjUwLCBNYXJpdXMgS2l0dGxlciB3cm90ZToKPiBBbSBGcmVpdGFn
LCAxNS4gU2VwdGVtYmVyIDIwMjMsIDE2OjEwOjExIENFU1Qgc2NocmllYiBBbmRyZWEgQ2VydmVz
YXRvIHZpYQo+IGx0cDoKPj4+ICsKPj4+ICsJLyogY3JlYXRlIHRlc3QgZmlsZSBhbmQgc2V0IHhh
dHRyICovCj4+PiArCXN0cnVjdCB0ZXN0X2Nhc2UgKnRjID0gJnRjYXNlc1tpXTsKPj4+ICsJc25w
cmludGYodGMtPmZuYW1lLCBCVUZTSVosICJnZXR4YXR0cjAxdGVzdGZpbGUtJXUiLCBpKTsKPj4+
ICsJaW50IGZkID0gU0FGRV9DUkVBVCh0Yy0+Zm5hbWUsIDA2NDQpOwo+Pj4gKwlTQUZFX0NMT1NF
KGZkKTsKPj4+ICsJVEVTVChzZXR4YXR0cih0Yy0+Zm5hbWUsIFhBVFRSX1RFU1RfS0VZLCBYQVRU
Ul9URVNUX1ZBTFVFLAo+Pj4gKwkJCQkgIHN0cmxlbihYQVRUUl9URVNUX1ZBTFVFKSwKPiBYQVRU
Ul9DUkVBVEUpKTsKPj4gSGVyZSB5b3UgY2FuIHVzZSBUU1RfRVhQX1BBU1MgaW5zdGVhZCBvZiBU
RVNUCj4+Cj4gSSB3b3VsZG4ndCBrbm93IGhvdy4gSWYgdGhpcyBmdW5jdGlvbiBmYWlscyB3aXRo
IEVOT1RTVVAgc3BlY2lmaWNhbGx5LCB0aGVuIHRoZQo+IHJlc3VsdCBzaG91bGQgYmUgVENPTkYu
IEkgZG9uJ3QgdGhpbmsgdXNpbmcgVFNUX0VYUF9QQVNTIGFsbG93cyB0aGF0Lgo+IEFkZGl0aW9u
YWxseSwgaWYgdGhpcyBmdW5jdGlvbiBmYWlscyB0aGUgcmVtYWluaW5nIHRlc3RzIGZvciB0aGlz
IGl0ZXJhdGlvbgo+IHNob3VsZCBiZSBza2lwcGVkLgo+Cj4+PiArCj4+PiArCS8qIHJlYWQgeGF0
dHIgYmFjayAqLwo+Pj4gKwlURVNUKGdldHhhdHRyKHRjLT5mbmFtZSwgdGMtPmtleSwgdGMtPnZh
bHVlLCB0Yy0+c2l6ZSkpOwo+Pj4gKwlpZiAoVFNUX0VSUiA9PSB0Yy0+ZXhwX2Vycikgewo+Pj4g
KwkJdHN0X3JlcyhUUEFTUyB8IFRURVJSTk8sICJleHBlY3RlZCBnZXR4YXR0cigpIHJldHVybgo+
IGNvZGUiKTsKPj4+ICsJfSBlbHNlIHsKPj4+ICsJCXRzdF9yZXMoVEZBSUwgfCBUVEVSUk5PLCAi
dW5leHBlY3RlZCBnZXR4YXR0cigpCj4gcmV0dXJuIGNvZGUiCj4+PiArCQkJCSIgLSBleHBlY3Rl
ZCBlcnJubyAlZCIsIHRjLQo+PiBleHBfZXJyKTsKPj4+ICAgIAl9Cj4+IEFsc28gaGVyZSB5b3Ug
Y2FuIHVzZSBUU1RfRVhQX1BBU1MgaW5zdGVhZCBvZiBURVNUCj4gQWxzbyBoZXJlIEkgd291bGRu
J3Qga25vdyBob3cgdGhhdCBpcyBwb3NzaWJsZS4gVGhlcmUgYXJlIHRlc3QgY2FzZXMgd2hlcmUg
YW4KPiBlcnJvciBpcyBhY3R1YWxseSBleHBlY3RlZC4KCklmIGFuIGVycm9yIGlzIGV4cGVjdGVk
IHlvdSBjYW4gdXNlIFRTVF9FWFBfRkFJTCwgYnV0IHllcywgdGFraW5nIGEgCmNsb3NlciBsb29r
IGF0IHRoZSBjb2RlLAp0aGlzIGNhc2UgaXMgYSBiaXQgbW9yZSBzcGVjaWZpYyBhbmQgVEVTVCBj
YW4gYmUgdXNlZC4KCj4KPj4+IC0JdHN0X2Jya20oVENPTkYsIE5VTEwsICI8c3lzL3hhdHRyLmg+
IGRvZXMgbm90IGV4aXN0LiIpOwo+Pj4gKyNpZmRlZiBIQVZFX1NZU19YQVRUUl9ICj4+PiArCWNo
YXIgKmN3ZCA9IFNBRkVfR0VUQ1dEKE5VTEwsIDApOwo+Pj4gKwl3b3JrZGlyID0gU0FGRV9NQUxM
T0Moc3RybGVuKGN3ZCkgKyBzdHJsZW4oTU5UUE9JTlQpICsgMik7Cj4+PiArCXNwcmludGYod29y
a2RpciwgIiVzLyVzIiwgY3dkLCBNTlRQT0lOVCk7Cj4+PiArCWZyZWUoY3dkKTsKPj4gSGVyZSB5
b3UgY2FuIGp1c3QgU0FGRV9UT1VDSCB0aGUgZmlsZSBpZiB5b3UgYWltIHRvIGNyZWF0ZSBvbmUu
Cj4+Cj4gVXNpbmcgU0FGRV9UT1VDSCgpIG1ha2VzIHNlbnNlIGJ1dCBJIGd1ZXNzIHRoZSBmaWxl
IGNyZWF0aW9uIG5lZWRzIHRvIGJlIGluCj4gcnVuKCkgYmVjYXVzZSBhIGZpbGUgbmVlZHMgdG8g
YmUgY3JlYXRlZCBwZXIgbW91bnQuIEFkZGl0aW9uYWxseSwgb25lIHRoZW4gaGFkCj4gdG8gY3Jl
YXRlIGEgbG9vcCBmb3IgYWxsIHRlc3QgY2FzZXMuCj4KPj4gSW4geW91ciBjYXNlLCB0byB1bmRl
cnN0YW5kIExUUCBBUEkgYSBiaXQgYmV0dGVyLCBJIHdvdWxkIHRha2UKPj4gZnhnZXRhdHRyMDEg
YXMgcmVmZXJlbmNlLCBtb3JlIG9yIGxlc3MuCj4gVGhhdCB0ZXN0IHNlZW1zIHZlcnkgc2ltaWxh
ciwgaW5kZWVkLiBEbyB5b3Ugd2FudCBtZSB0byBmb2xsb3cgc29tZSBwYXR0ZXJucwo+IGZyb20g
dGhlcmUgc3BlY2lmaWNhbGx5PyBOb3RlIHRoYXQgdGhpcyB0ZXN0IGFsc28gdXNlcyBqdXN0ICJU
RVNUKOKApikiIHNpbWlsYXJseQo+IHRvIG15IGNvZGUuCj4KPiBJdCBkb2VzIGEgc2ltcGxpZmlj
YXRpb24gYnkgdXNpbmcgU0FGRV9GU0VUWEFUVFIgYW5kIGhlcmUgSSBjb3VsZCB1c2UKPiBTQUZF
X1NFVFhBVFRSLiBIb3dldmVyLCB0aGVuIHdlIHdvdWxkIGxvc2UgdGhlIEVOT1RTVVAgY2FzZSB3
aGljaCBJJ20gbm90IHN1cmUKPiB3ZSB3YW50L3Nob3VsZCBsb3NlIChlc3BlY2lhbGx5IHNpbmNl
IEknbSBtYWlubHkgcG9ydGluZy9yZWZhY3RvcmluZyBpdCBtaWdodAo+IG5vdCBiZSBkZXNpcmFi
bGUgdG8gcmVtb3ZlIGJlaGF2aW9yIGF0IHRoZSBzYW1lIHRpbWUpLgo+Cj4KPgpZb3UgY2FuIHVz
ZSBmeGdldGF0dHIwMSBhcyByZWZlcmVuY2UuCkJld2FyZSBvZiAibWFrZSBjaGVjayIgYmVmb3Jl
IHNlbmRpbmcgdGhlIHBhdGNoLgoKQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
