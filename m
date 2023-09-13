Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D020BCA5531
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 09:11:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E24053CB2FA
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 11:11:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B9B93CB2C4
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:11:47 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 48FD11401264
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:11:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3Sl1c+b+rLZQJQvttN3jF0ycT+3nlquBm/Jnopy7eLpqmSC9xIeGSRqPTCHi+yOPr8NH3I+hGYiwlgAMQpjYg0bNOpnwK2V3WaqLixDS7+ilwEm2qw3AdjYoBfHfn9s8hFvkcJ07VXFiU97pSd6sW7moi+Beo3msOP4ITcrWIAMQYmoe5DyYq57kvF/GhtGZiUfsE/tslitNg+nUPBrwWUKiTGzFtSN46aK5vP8+D5H8b1W+BY+n/mWgWDmw1VY6FXs0bmcnAcXLYAClBd/BxRqDT7cQW6c2sTU2XGOsnQcLuMt9Yh1Z0qHjWL8NO1NXiyFSS7Qp8FtphXL/tBjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1Vm3D04b0POAyU3uu8XpmfybwgrcxoRs1CTt9tPeGw=;
 b=hQQso/0W99gTxZF0uMhVbYGW3Yp6OgPRWknqb8GXYmGbnf5mdiY4Z5NCvXUJvvzYg6ByFxoCymxcFmYlZDpvr2XWF4wD8eS/4ghxEfWxwfLgGB7d7Vo1m6b+Y/vP2IxlvX60WIn0nkeLUZxPMsfMAegK/ihNeMXeR63C5oeeZ0tAv1OtESLhDjJF6NhG3dCxX4svX+rr661SRV/lww7iAaQvJ9kggdG3ozrj7zcpPy7PZMthyGLAWrS0VtIh4/dfmwooJ4Yc34fPCtk2Ubil5aHzeInueNEYcD10h0MxzAOSxu4T9R2Bl8xAAEzSlwhrXSpFPTaAqSDoKoLq6wqnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1Vm3D04b0POAyU3uu8XpmfybwgrcxoRs1CTt9tPeGw=;
 b=RlceVXTCTQsGqetagyER0jN08WTHuFwZBg0sUP34WvO6FKs9yAx+orDqNEAVtjEf9jOtCOt1TO1HhdWjuTKP612TjIzAAmqBl8hm0RB+48QIRSeGLcugU25b2wfx1N7MBz0a45H3z4VVW0lNO8sPhSrTSEB3hJSzOnzc/VIbYZJVtVcWLO+4G7eSekc5E+bdqIOaHwCZxef7nZWxUr5h1pjy4qYt80frGOBDV6tXAaA3i9DYfLLSN5oMq/Nm2t/7YQfR0KUgN/lEKGUVXdBzOMzXV8YSauxStIZ7WOHyLxvleZ9oTj90dHZYsdPdlZZecNz1Nr7kvlsOhEfGOLpV5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 09:11:44 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 09:11:43 +0000
Message-ID: <d57f969b-2b3c-4835-b9d0-b3b8f6b964e2@suse.com>
Date: Wed, 13 Sep 2023 11:11:42 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Marius Kittler <mkittler@suse.de>, ltp@lists.linux.it
References: <20230912144351.13494-1-mkittler@suse.de>
 <20230912144351.13494-2-mkittler@suse.de>
In-Reply-To: <20230912144351.13494-2-mkittler@suse.de>
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DU2PR04MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa5ce8b-0b58-453f-e2cc-08dbb43972e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/A1ICxwL0g10XdOgZJTYFP4lGWbPSBRpMj6vwcYUs+cevb5QKprgH/XAMUNwZuSIQG8YclQc5mga+72J6Mt24YpkRNWnGsPLWojSgCI3B6b5BXYHOn+awcOSFJmfSuAc5ZIWyRELFjR1XVSeX7qqDNFQ46FOY21zq9U/tqIa+qGqU3E4CYyKGOc2uHXBrELgXTl+R/uSnM7wHTswgztMKUjt0w5e9U+RtQaW/8Z4w5TYDvA3HUJUxCnppk/a2rubSz9/ZCsd5KYeGQ7fuICwRHcBHiYN33JgRDttXuuut52OJ4Gg4DbO4Sf+asqDnpz2KlsPI0Sv54hu129JQml55kBmiCwB3iTq5BydNeFlBx3ekl52j9ssy75hwKXz0NpIZfKx3KWC+0WCncHyEfOCKs1fMHPB7/locK7Mlfyn0stU87GVDXO4GSef9QafClvmVpaQ/IOky1oY6S5E7y/nzV6ya07g799GSpUk0DUvfJ1LWhJtiRmVtQHa10ns6Qmz4oFUnZZbaR7XoU/zGDFkhCjicbcKYqr3JDriqZESqtDqjmg7aI8EkqFBRhmJu7EqREtedZvtK58zz9toj7L34yb253ggwpzQkqFOFPQ/62s0gCb3rX2CZ5XeBqGkbX+sfuREDj8ZR/TTcIKzyZEG+JL9TOZ5EsB4keS8Oshbk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(186009)(1800799009)(451199024)(31686004)(6506007)(6486002)(53546011)(36756003)(86362001)(31696002)(38100700002)(2616005)(26005)(2906002)(6512007)(966005)(478600001)(83380400001)(5660300002)(8936002)(8676002)(316002)(41300700001)(66556008)(44832011)(66946007)(66476007)(81973001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkVzWVdUbUhBU2ZYbWVxM1U4NDhiSmN5NXZ4dm9USUpZUGQzSzhRTEozb3Mw?=
 =?utf-8?B?NEhDc0NwbnZRN1BId0Vhdno3dmZLeEU3aVhnK2k4Y1Q3QzJqblM2SGZZU2p5?=
 =?utf-8?B?RU50QjVZUVRvZmdqNU5BcDRld25TSWZtRkxsSysyd1k5UEVxcnFPVHNNcVFt?=
 =?utf-8?B?Y0I1Sk5XSml6VG11WmxrNnVOWXBFeGxiZU5rZDZRSUx1VmVjQVpsM0FneUpm?=
 =?utf-8?B?MDdsSXVVUnNFZmlMYXpoTjhsOFpCcDBDQXlveVdNb2RybXJWUjhkV08xRnFq?=
 =?utf-8?B?VzlScU51TVV0SEdLYnpLSi9BMWVVQ1RIeGtIcUVidU54bHg5cCtkaVZjRWVG?=
 =?utf-8?B?MmdXTG1PaXgwU0xya2VLWmRWOEdZcUdsWnAwaDJtU3h2U1MvZXZIMGpzdVZj?=
 =?utf-8?B?bHdlbFdFU1h3bHkwdHpFNTFMSElBSnRsVjltRkl0Z00xYTFjdWxMOFYwZ25J?=
 =?utf-8?B?WVhkY3RQbjZOdmM5SzV4YXI3YWg0M09mWXNoa240VnhsVHFJMHhldTI0WmFS?=
 =?utf-8?B?dVBpeG9sOVJoY3FNL2w4MlFqVExpUUhudTZRdW5XeVQwRnBjRkRVbys3em5H?=
 =?utf-8?B?Z1czZGdXc2ZXUmVHRjAwK2FLOFRNYzZMR0IxWm5ZdTc1ODZ2SG5MMGpEQkx1?=
 =?utf-8?B?dldwenp4R2VwTkVBeWN6U2JPWklHUGpqZW1CWUdFQmluYmdqNTdsd3YwZkls?=
 =?utf-8?B?Z1ZkekwvWmdFWllxaHZoem96NTRSY1RyWnRGTGhra0pJTXMrMzg2MTNBdXV4?=
 =?utf-8?B?UWhYMW1JaE84RW9Vd0xSZjhTSkJHN0ZzclAzRVVnVkEwTXhmRUZNRURNOFBl?=
 =?utf-8?B?QkpSOWJnaTBGSGdPSFg4MnFHN25wS3Y4dm9FbGIzaEYxRnFHcXFIOGdrUVhz?=
 =?utf-8?B?TDFoTWh6ZDZwQnNLZENmOUJaN0RqeFlpUnRIRlFLS1hheXl4MWhzaE1RMHZW?=
 =?utf-8?B?QU13MXFBRURYd3puRnR3OGJxTUhNOWhoZGVWK0gwYTlMbE0zcEhVSGNwVUJp?=
 =?utf-8?B?Zm9PbXVGUndGM1ZDbVlNRStZK0ZuZXNCWU9ZK090VEkwYzlFY0pVRFdkeEE0?=
 =?utf-8?B?SlBaaFRxQUh0dFNzZXRsQXZPMytVbUNPMlBDcTVtYW5iY2ZUbkNjM1QvOGVz?=
 =?utf-8?B?TThsbnhZUmptaXJSK1c4ZE5LNFVjdUpqYXB0QU9zUzFJTFBKdkNlQW9IY1dW?=
 =?utf-8?B?OHJiYTNuek1xY1dFdGt3S01oSnJXdjNDSHBqMHJINGVzZkJETlh3aWN6bzZW?=
 =?utf-8?B?SG0zQTB4dW1KYmo1dFdHQ2JWVmdYSmh3TFJEWTZyTWFUV09janhNeXRNcE9n?=
 =?utf-8?B?bkVaS1RNZFBmM05uOWJvYkNHTDVkS2JtbjkrclA0dnA3clpQK1RDZy9BQTRk?=
 =?utf-8?B?OXRqbkw5bU1kQXVLclJYa0Q4SUNFYmR1eWtTdEdFSmZjRld5cy9Ba2tCVSt4?=
 =?utf-8?B?V0VOYUw1Sm9JbUk3TTVlaVNzVTAvTndEZlRiQ3FpUDJ0dlA3UzdDWXIyd2Z4?=
 =?utf-8?B?bFR0ZldJYys2YVRBTkwrbURDcGlKZ05CQnJ3M0VJUlNyZm82UVdwRTFXVTBL?=
 =?utf-8?B?SGFIcW0xTnlTc00wcVd6bFg1WG80YzJJS0p6bGxoNmk1Z05ZZERBLzZBVVRM?=
 =?utf-8?B?R1FJNU53OUFEN3RGSjgzam5oT0VPblpwcW9RVElPQ2JvTXJnTWkwdGR6bk1T?=
 =?utf-8?B?OGpxeWRHb1FmcVptR0pKQTd4VmxrQTZhZ2g0RlorUG4xY1NadDdWcDdML21h?=
 =?utf-8?B?QTFLMWFsT0I1TnJMUnB5UDlacjdxQ1pua1hUclRrck16ejFxR1NyQjladkxm?=
 =?utf-8?B?NHd3SURwRE5oRjl6elRCM011MC9oSzNsM291eU81OWR4aXNkcWJlcXJvUXhN?=
 =?utf-8?B?V254Sk1kNVgrSUkvYW15S3ZWSjc4N2ZaazdnUEN5UVY5ZWJNbjFxMlZFK2pK?=
 =?utf-8?B?RFJKcjNYNXZiRlFsY3BzSUprVFVWd2pLbmJXTU9iVDUyR0pGU3RzRU1qWW55?=
 =?utf-8?B?NWM0OStBckI4OW15WmJjSTRhWW1GdWswRXpIRlNzYUkvZlF6dXNvZTkwN0Jn?=
 =?utf-8?B?VDJwTnBqa3pRQ0QwQ2xkS1Yxc2VJQmNLZUR0dDFoNVp0VHBTM1BRVkxJbmxq?=
 =?utf-8?B?U3p4OVNSS2xKTmlOeHNwc0tHRHlVVm5pMVJOMmVGcTRFVTFxYmJqMVpvcElP?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa5ce8b-0b58-453f-e2cc-08dbb43972e3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 09:11:43.7874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yp8yygAT5u6GlaL0+ttZZPZD7eEdoc5+qOq3lbx7vehj0LAKdcj0iS1AScLagdAN8F5/WAQPa5xDHcTuiBkgds0kMRGuzgbDo77mKhFni7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8599
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] Ensure prio is within valid range in
 `rt-migrate.c`
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

SGkhCgogwqBJIGdlbmVyYWxseSBzdWdnZXN0IHRvIHJlZmFjdG9yIHRlc3QgaW50byBuZXcgQVBJ
IGlmIGEgc3RydWN0dXJhbCAKY2hhbmdlIGlzIG5lZWRlZC4gSGVyZSB3ZSBhcmUgaW4gYSBncmV5
IHpvbmUsIGJlY2F1c2UgdGhlIHRlc3QgaXMgb2xkIAplbm91Z2ggdG8gYmUgcmVmYWN0b3JlZCBh
bmQgcGF0Y2ggaXNuJ3Qgc28gYmlnLiBTdGlsbCwgdGVzdCBpcyBidWdnZWQgCmFuZCB3ZSBuZWVk
IHRvIGZpeCBfYXQgbGVhc3RfIGEgc21hbGwgcG9ydGlvbiBvZiBpdC4KCkkgd291bGQgc3VnZ2Vz
dCB0byB0YWtlIGEgbG9vayBhdCB0aGUgY29kZSBhIGJpdCBjbG9zZXIgYW5kIHRvIGd1ZXNzIGhv
dyAKbXVjaCBlZmZvcnQgd2Ugc2hvdWxkIHB1dCBpbiBvcmRlciB0byByZXdyaXRlIGl0IHdpdGgg
bmV3IEFQSS4gVGhlIHRlc3QgCnNlZW1zIHByZXR0eSBzaW1wbGUsIGlmIHdlIGdldCByaWQgb2Yg
YWxsIHRoZSBvbGQgc3R1ZmYgKG9wdGlvbnMsIHN0ZG91dCAKbWFuYWdlbWVudCkgYXMgd2Ugc3Vw
cG9zZWQgdG8gZG8gYW55d2F5LgoKUmVnYXJkcywKQW5kcmVhCgpPbiA5LzEyLzIzIDE2OjQzLCBN
YXJpdXMgS2l0dGxlciB3cm90ZToKPiAqIEFjY29yZGluZyB0byB0aGUgZG9jdW1lbnRhdGlvbiB0
aGUgdmFsdWUgcGFyYW0tPnNjaGVkX3ByaW9yaXR5Cj4gICAgbXVzdCBsaWUgd2l0aGluIHRoZSBy
YW5nZSBnaXZlbiBieSBzY2hlZF9nZXRfcHJpb3JpdHlfbWluKDIpIGFuZAo+ICAgIHNjaGVkX2dl
dF9wcmlvcml0eV9tYXgoMikuIFRoaXMgY2hhbmdlIGVuc3VyZXMgdGhhdCB0aGlzIGlzIHRoZQo+
ICAgIGNhc2Ugd2l0aG91dCBjb21wbGV0ZWx5IHJlc3RydWN0dXJpbmcgdGhlIHRlc3QgeWV0Lgo+
ICogU2VlIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2lzc3Vlcy84
MTIKPgo+IFNpZ25lZC1vZmYtYnk6IE1hcml1cyBLaXR0bGVyIDxta2l0dGxlckBzdXNlLmRlPgo+
IC0tLQo+ICAgLi4uL3JlYWx0aW1lL2Z1bmMvcnQtbWlncmF0ZS9ydC1taWdyYXRlLmMgICAgIHwg
MjEgKysrKysrKysrKysrKystLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL3JlYWx0aW1lL2Z1
bmMvcnQtbWlncmF0ZS9ydC1taWdyYXRlLmMgYi90ZXN0Y2FzZXMvcmVhbHRpbWUvZnVuYy9ydC1t
aWdyYXRlL3J0LW1pZ3JhdGUuYwo+IGluZGV4IDk3YWI2MDRjNy4uMjU1NGY2M2UyIDEwMDY0NAo+
IC0tLSBhL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5jL3J0LW1pZ3JhdGUvcnQtbWlncmF0ZS5jCj4g
KysrIGIvdGVzdGNhc2VzL3JlYWx0aW1lL2Z1bmMvcnQtbWlncmF0ZS9ydC1taWdyYXRlLmMKPiBA
QCAtNzQsNiArNzQsOSBAQAo+ICAgCj4gICAjZGVmaW5lIFZFUlNJT05fU1RSSU5HICJWIDAuNExU
UCIKPiAgIAo+ICsjZGVmaW5lIENMQU1QKHgsIGxvd2VyLCB1cHBlcikgKE1JTih1cHBlciwgTUFY
KHgsIGxvd2VyKSkpCj4gKyNkZWZpbmUgQ0xBTVBfUFJJTyhwcmlvKSBDTEFNUChwcmlvLCBwcmlv
X21pbiwgcHJpb19tYXgpCj4gKwo+ICAgaW50IG5yX3Rhc2tzOwo+ICAgaW50IGxmZDsKPiAgIAo+
IEBAIC0xMzcsNyArMTQwLDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgbG9uZyBpbnRlcnZhbCA9
IElOVEVSVkFMOwo+ICAgc3RhdGljIHVuc2lnbmVkIGxvbmcgbG9uZyBydW5faW50ZXJ2YWwgPSBS
VU5fSU5URVJWQUw7Cj4gICBzdGF0aWMgdW5zaWduZWQgbG9uZyBsb25nIG1heF9lcnIgPSBNQVhf
RVJSOwo+ICAgc3RhdGljIGludCBucl9ydW5zID0gTlJfUlVOUzsKPiAtc3RhdGljIGludCBwcmlv
X3N0YXJ0ID0gUFJJT19TVEFSVDsKPiArc3RhdGljIGludCBwcmlvX3N0YXJ0ID0gUFJJT19TVEFS
VCwgcHJpb19taW4sIHByaW9fbWF4Owo+ICAgc3RhdGljIGludCBjaGVjayA9IDE7Cj4gICBzdGF0
aWMgaW50IHN0b3A7Cj4gICAKPiBAQCAtMjg0LDggKzI4Nyw4IEBAIHN0YXRpYyB2b2lkIHByaW50
X3Jlc3VsdHModm9pZCkKPiAgIAlwcmludGYoIlBhcmVudCBwaWQ6ICVkXG4iLCBnZXRwaWQoKSk7
Cj4gICAKPiAgIAlmb3IgKHQgPSAwOyB0IDwgbnJfdGFza3M7IHQrKykgewo+IC0JCXByaW50Zigi
IFRhc2sgJWQgKHByaW8gJWQpIChwaWQgJWxkKTpcbiIsIHQsIHQgKyBwcmlvX3N0YXJ0LAo+IC0J
CSAgICAgICB0aHJlYWRfcGlkc1t0XSk7Cj4gKwkJcHJpbnRmKCIgVGFzayAlZCAocHJpbyAlZCkg
KHBpZCAlbGQpOlxuIiwgdCwKPiArCQkJICAgQ0xBTVBfUFJJTyh0ICsgcHJpb19zdGFydCksIHRo
cmVhZF9waWRzW3RdKTsKPiAgIAkJcHJpbnRmKCIgICBNYXg6ICVsbGQgdXNcbiIsIHRhc2tzX21h
eFt0XSk7Cj4gICAJCXByaW50ZigiICAgTWluOiAlbGxkIHVzXG4iLCB0YXNrc19taW5bdF0pOwo+
ICAgCQlwcmludGYoIiAgIFRvdDogJWxsZCB1c1xuIiwgdGFza3NfYXZnW3RdICogbnJfcnVucyk7
Cj4gQEAgLTM5NCw2ICszOTcsMTMgQEAgc3RhdGljIHZvaWQgc3RvcF9sb2coaW50IHNpZykKPiAg
IAo+ICAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQo+ICAgewo+ICsJLyoKPiArCSAq
IERldGVybWluZSB0aGUgdmFsaWQgcHJpb3JpdHkgcmFuZ2U7IHN1YnRyYWN0aW5nIG9uZSBmcm9t
IHRoZQo+ICsJICogbWF4aW11bSB0byByZXNlcnZlIHRoZSBoaWdoZXN0IHByaW8gZm9yIG1haW4g
dGhyZWFkLgo+ICsJICovCj4gKwlwcmlvX21pbiA9IHNjaGVkX2dldF9wcmlvcml0eV9taW4oU0NI
RURfRklGTyk7Cj4gKwlwcmlvX21heCA9IHNjaGVkX2dldF9wcmlvcml0eV9tYXgoU0NIRURfRklG
TykgLSAxOwo+ICsKPiAgIAlpbnQgKnRocmVhZHM7Cj4gICAJbG9uZyBpOwo+ICAgCWludCByZXQ7
Cj4gQEAgLTQ0OCw3ICs0NTgsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCj4g
ICAKPiAgIAlmb3IgKGkgPSAwOyBpIDwgbnJfdGFza3M7IGkrKykgewo+ICAgCQl0aHJlYWRzW2ld
ID0gY3JlYXRlX2ZpZm9fdGhyZWFkKHN0YXJ0X3Rhc2ssICh2b2lkICopaSwKPiAtCQkJCQkJcHJp
b19zdGFydCArIGkpOwo+ICsJCQkJCQlDTEFNUF9QUklPKHByaW9fc3RhcnQgKyBpKSk7Cj4gICAJ
fQo+ICAgCj4gICAJLyoKPiBAQCAtNDYwLDcgKzQ3MCw4IEBAIGludCBtYWluKGludCBhcmdjLCBj
aGFyICoqYXJndikKPiAgIAo+ICAgCS8qIHVwIG91ciBwcmlvIGFib3ZlIGFsbCB0YXNrcyAqLwo+
ICAgCW1lbXNldCgmcGFyYW0sIDAsIHNpemVvZihwYXJhbSkpOwo+IC0JcGFyYW0uc2NoZWRfcHJp
b3JpdHkgPSBucl90YXNrcyArIHByaW9fc3RhcnQ7Cj4gKwlwYXJhbS5zY2hlZF9wcmlvcml0eSA9
IENMQU1QKG5yX3Rhc2tzICsgcHJpb19zdGFydCwgcHJpb19taW4sCj4gKwkJCQkJCQkJIHByaW9f
bWF4ICsgMSk7Cj4gICAJaWYgKHNjaGVkX3NldHNjaGVkdWxlcigwLCBTQ0hFRF9GSUZPLCAmcGFy
YW0pKQo+ICAgCQlkZWJ1ZyhEQkdfV0FSTiwgIldhcm5pbmcsIGNhbid0IHNldCBwcmlvcml0eSBv
ZiBtYWluIHRocmVhZCFcbiIpOwo+ICAgCWludHYudHZfc2VjID0gSU5URVJWQUwgLyBOU19QRVJf
U0VDOwoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
