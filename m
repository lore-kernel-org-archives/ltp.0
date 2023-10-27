Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE19C25B47
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 08:55:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DB573CEB9C
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 10:55:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 820C43CCAB1
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 10:55:33 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A0E41A009A6
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 10:55:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMEdKKoDIfAjM8u4Oo0jGk2mQ6tZoP8HirvuU3H1ObSYaOMU6bmvuDKyIgPfq9Gqqpx/k/ko7DMYv5v1elfPoIKLHR5h2rYiwd7k9pd9nUuWtD/dhrdq6xzSZlyBoAUYuqI65bZDJoovSeEvLnWZjmoycCXsOx9KwyVlI3huukFGTUOaf3b/ttFFyHEI6lmMogmdMRELPFpE43IXKZorzedYnSYSlcbx9My5IMCWnUhi5ln807dBzmTvncvENKTB3et62RH0OY2pM0gyouK4eqcoXX/chwRdnl4mV/dpExeTvGB5lU/3u8cz2qaoTVLMDhh5ORU2azhCxaBn+/XyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mC0Aj0v4t9Adja1F8U7N5dTCgD2uJ5aZfwaEjrwE4M0=;
 b=BLccluNEJ0W0rhzurpJR8FSgQqH4h9Zf1/i5SoTrnYhtYXowe271l4G/q1H/2VgbH09qyXoHgiSCy1TpB43852tuOe7mhFnsYODmhMCY5e88O2W0fbrlxHeBHuzt4rAjJOaEzSiJMBlYOos3OUu6bFtsyBmWIBQJu+GqAyiUxQIZlZds1RMXcPjzrd/8TrgwQf2m0s2u28cL1Uwvg5oJl1S0bZvGoUoGndAuFxXggJr8qD01uzz5FRjaeZxqLZRRM94WKFuCrHP813YQkYisocvP0txXI33JcjJYxuEg2fwevnRThZ7lCOh/TTVLT1AmV14BdOY66NZ3Qj7wjHBYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mC0Aj0v4t9Adja1F8U7N5dTCgD2uJ5aZfwaEjrwE4M0=;
 b=m7Lb3vAy4DoxSM6bN57G+lsjjUPwxlt12AZBB2SCePG8RfwCp3im9+5ELHvMOBqg7BAQrNiEWHFvcQc785yaVLMZ1qs/2GUp4IsbrxxFlu7RsTUUSiT3UHYzOni+GghPkzK+DJQsWZVC/Ad+VwhakerykfePrd37rpSeU3sSOD4yPCY70hAKbke1Rdjo3TBI6POJmUylbHoXnf5oHtkLXYXkxgD/HIacSnIhrM+Z4kztnKOLL4nfcGeZMDHZTp2NElZh8n6vO7/ltSkwBmuOlb8MXTZ2bIChR7x31e99K2qNgUGToyu1UdEknOu37MquSO3jATbt2ZXEIq6Dep3CPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB7957.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Fri, 27 Oct
 2023 08:55:30 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::fe32:e823:6c2a:ec3a]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::fe32:e823:6c2a:ec3a%6]) with mapi id 15.20.6933.011; Fri, 27 Oct 2023
 08:55:29 +0000
Message-ID: <55b7a1e5-698a-4a0f-91c8-c0bb5e6423e1@suse.com>
Date: Fri, 27 Oct 2023 10:55:27 +0200
User-Agent: Mozilla Thunderbird
To: Jan Stancek <jstancek@redhat.com>
References: <272dd7b41f4e1049c7428d2de2ac97814ed900ba.1697705468.git.jstancek@redhat.com>
 <1f088ac0-fac1-40c4-91eb-accf629daaee@suse.com>
 <CAASaF6zYqm+ct9C0unRHZfg0z74xyeSu6hOrXzyKNV1peWZcwg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAASaF6zYqm+ct9C0unRHZfg0z74xyeSu6hOrXzyKNV1peWZcwg@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS8PR04MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c10c36a-87d2-4131-7cfc-08dbd6ca785c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGuCw+x27VfT5UOzdhLCJiGZdXZeG7NgVG3WAiDbB064oCgnKnNCSqW+emYlmT7w1cmp56+OijBHjC5ov+/s75eRCCWRehBzJYk2StIxoqO+iUPNzpSbW72z1qguj+D3/fZKI9Jgavp9x+Y6jleuyPDLvKvRK80OTDKM1JJw2T5PMpspDk1MQYTTj3/yQpydYKKBn1n9fUhtkbeZbEI+0+96AyO8BZj6rPSM6Z/dt5CNrrW/UzHXGQa+efdOiCzHZkx6nWi6D2h9gv4hNk/2keu8RFRs3gzGlTBySryNa0xLW0/uMPfHhmPu5Uf0JSj1ivNHlYl78SbO8PoQY+6n3okHQ7rfopkRkug8CLjM2LVr3aM1Kt1Sm5D0rfZI77UqmcwuboMuOkCvTmzr8CNmBY5MpMxXvdlbgvfCnlwwUGbhsG/cGBRH474GKDcYo4PFQmtYXLMRHj3ERf6adyBWoCrbfpW29CcmsU20dk7JCpMCNkgZ2DzEwBI+K2vqvSUdLKOH0FSUI1yNnHzyxUeI9qRchePX7ylvsh6B1Owkb1dgOGuq6EsaualLTSia5JGTIB1cL1zjYOJTVtm4vKh8V+mk387casp/Lq7/5Jj6PCYhRWAvv2IDKt/Un9WgNmnE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31696002)(41300700001)(2906002)(38100700002)(66556008)(66476007)(66946007)(478600001)(6506007)(6916009)(2616005)(53546011)(6512007)(966005)(83380400001)(6486002)(86362001)(26005)(5660300002)(8676002)(4326008)(36756003)(316002)(44832011)(8936002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWZLQ1RtKytFRlpLZ3h4dlBoeXVHQVJpM1dNSUNZSVl5czVFZktoYzRzdHJj?=
 =?utf-8?B?TnMzYlV5VHhSRFpMbzlGQlVnQXJRYlBmSEdTV3piMEVQTzdjQnp1cU5VWlVU?=
 =?utf-8?B?R1JnZXd6czQ1R1EvcGRkQmdOR3RISUNPVHQ3K2NzY2VYRWM2dXliUC94TUZ3?=
 =?utf-8?B?ZzJ2OVZTNk16bG1pTXRnWnkwR0k1SFVaYmdmZGVpdjBhelhBcFR6OFd2T3Js?=
 =?utf-8?B?RU42L2JxVFlKYzRGNkNxRlVhbUlpUGllZklYN3EzYWh0ZkNQUDVMQm1LQ2Vr?=
 =?utf-8?B?aHhUN0hVZzRreGw4WS9mcUtJVkdVSGg4b0lxSnhhb1dmVmI3YVI1RmxOZEdn?=
 =?utf-8?B?d3RsaTJwSHY2TUs5ZERhb01qWjQ2OWJGcVo2ajdnZnpwcUhnUm9OM2xZT3gx?=
 =?utf-8?B?ZExaT1RWenhNOUJUWFVEdWMwUldtN1VGbisyakUvUlJaMVF3UVNpWTljdTkr?=
 =?utf-8?B?Q0x4VE50ejJDS3dOU0Y5U2dXZVh5c29LaXpZTGc5Y1ExYzg1TTBQeTY4TzVY?=
 =?utf-8?B?aE1jekx2ci96NWNoTTNlUzZvSUVGRDJJelVjRHg1WXd6d2xVeVloelZyQ2lh?=
 =?utf-8?B?NlRFWmVFWk5jbmVSTDh0K3lKaWpZQXoxb0dXQVBtcXJqUy93U2NoRjYzWjVw?=
 =?utf-8?B?NnhFaHJsenRoR2ZHMC9KVmMvNlptNWFOcGVBdHJqWUdieElCdTFMOHhJL2xl?=
 =?utf-8?B?cUoyMDI3Nkh6T3RES2hZUUliVVdhdkt3YUxmMEZjVWdXaUdWMFVLNzQrR092?=
 =?utf-8?B?UmxBaDRWUXBxdW81c01EUEhFcmVMVXdJeE1zMWd1MVNEcTJhcW5pdExLZUhH?=
 =?utf-8?B?UlFwTm5mcXl4c215aW9zWWQwdGFaM2hydG5ZSzJUQThtdUZ6cVZpS05WWUJi?=
 =?utf-8?B?UkN0RFBPYkMycGEyU09UOWYxczdSbUNVMDNYWjBmc3NLbEFxSzlheUdVSGk5?=
 =?utf-8?B?aXQyYXVRYktMUDVudEF1TmxtSWozcmJzTGtqVGRqTVJGcm1qNTBYYVhFOUtI?=
 =?utf-8?B?ajB2VVFnWFMyMGtEVk1wTWl4MlgxRW5UazV5Sk1lb2ZBNUFLeU5NSUNkeWg4?=
 =?utf-8?B?QUxkMnJ3NGNiV3AySUJnMEdWNEJmbGcrZXpKeGFUVTBwa091NUJXd3dOUUxX?=
 =?utf-8?B?K0puMDhVUzk0bG1XSDJSaTFSbjM3d1ZuckdBVkx2SG9XTUllemNUTURyRTJW?=
 =?utf-8?B?SW0zbUNnUmJndEVHWHRrTG9Ca1Y4R1laSnhkc0pHQjcvd25MUEhENWJYdUpZ?=
 =?utf-8?B?V2p0K043S2R1WWNndFczQ3NOejczcHdRZTBHbnYrWElpUERMSDRLNVozaHBF?=
 =?utf-8?B?LzQ1dzJIOHgvR28xVEdTNlFkcTZDVk1PUlQ5bW1pb1Z2Z3NxVFlpRXVPV2Jo?=
 =?utf-8?B?aTRIczF2dGl3ZUdJaTh5cTJzUUprMUd0WU1GNmZOTmJuSnNtMHB0SkZSa20z?=
 =?utf-8?B?c29JQ2lCd0swNWZGSjZ4ekltUTVVVUo5eDFsZk5kTXA4NWtIczNPZk1ITGtv?=
 =?utf-8?B?WU91cVlTOGZKckkzdVVMWXhQY3FQSWJ1dHJEWG9xUWlUNEpORldMQXB3Mk1V?=
 =?utf-8?B?bXV4UWx0RTQxOEdaaEIwYi9nd24vSVVMc2ljVWZTWmtwbVZJeCtlc2xNRkJE?=
 =?utf-8?B?Z3pORUZBcjlTbVRqdDlRNG15ZndRcDR1dC8xeFR6ZnBUK1pRTXdNcDBMRzQx?=
 =?utf-8?B?NWM1dTlqVnd3QkpSbFMwWlFQbVZtQ1EzSGVqTEZ2ek5OOU04eUdHTjd2TjdB?=
 =?utf-8?B?OXdKUGhwK0c0WHB5L1lORXhiL1NmTTNhL3NYN1VuWFVWTnVVVVprbCtnQ3NX?=
 =?utf-8?B?alU4d3Y3cEpyc3lDZzFnZUQyNzJJRkJ6UGNzRWJQbDF2ZnUzYXhnSEZlQ3Ny?=
 =?utf-8?B?SDFrWGhLZWdMOWhRZVpFSlFCaVJyalJJSnYvM3dmVU1UR3pUK3E3aW0xa0V4?=
 =?utf-8?B?N1dVNkQ0VWtKUEwwdmVUYk8zU3RFSmtXZ2JoU1ZOdFB6azlxOWU4SlozeXNV?=
 =?utf-8?B?d0FQcFdOVXhpZGxyZnRVV3pKdytDbjBJQUFaZmd6VWFQRmZJMlRsMFpYRzEz?=
 =?utf-8?B?NkpYTWhoODFWcEhwYk1PbWVibUJqY2VEZHVOaHl1eE9nUnJBc21WSmIrTU82?=
 =?utf-8?B?Tjc2MVdVMmxjcEg0aUFMdTdhSG5FVGpJcEM0QTZzOWFoZGl1dnNWWENBMXli?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c10c36a-87d2-4131-7cfc-08dbd6ca785c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 08:55:29.7750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EQJGo402oL0BWFAUTqHN5YC5X/eBHkFS9+nTaKgh9upBr/3ha/p4/rEcmxo56RdO1dKl4USkNtm1BqWcFyWtFZEMdeBNxhFUBsoUAUnnpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7957
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/process_madvise01: fix smaps scan and
 min_swap_avail
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

SGksCgpPbiAxMC8yNy8yMyAxMDo1MCwgSmFuIFN0YW5jZWsgd3JvdGU6Cj4gT24gVGh1LCBPY3Qg
MTksIDIwMjMgYXQgMTA6NTjigK9BTSBBbmRyZWEgQ2VydmVzYXRvIHZpYSBsdHAKPiA8bHRwQGxp
c3RzLmxpbnV4Lml0PiB3cm90ZToKPj4gSGkhCj4+Cj4+IE9uIDEwLzE5LzIzIDEwOjUxLCBKYW4g
U3RhbmNlayB3cm90ZToKPj4+IHNtYXBzIG1hdGNoaW5nIGNhbiBwcmVtYXR1cmVseSBlbmQsIGJl
Y2F1c2UgdGhlIGNvbXBhcmlzb24gdG8gIlZtRmxhZ3MiCj4+PiBzdHJpbmcgaXMgbm90IGV4YWN0
LiBTbyBkZXBlbmRpbmcgb24gYWRkcmVzcyBvbiBsaW5lLCBpdCBjYW4gYnJlYWsKPj4+IGJlZm9y
ZSBpdCBmaW5kcyBTd2FwIGxpbmUuIFRoaXMgbWFrZXMgdGhlIHRlc3QgZmFpbCBvbiByZWNlbnQg
YWFyY2g2NAo+Pj4ga2VybmVscy4KPj4+Cj4+PiBtaW5fc3dhcF9hdmFpbCBwZXIgZG9jdW1lbnRh
dGlvbiBpcyBpbiBNQiBub3QgS0IuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSmFuIFN0YW5jZWsg
PGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4+PiAtLS0KPj4+ICAgIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvcHJvY2Vzc19tYWR2aXNlL3Byb2Nlc3NfbWFkdmlzZS5oICAgfCAyICstCj4+PiAgICB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Byb2Nlc3NfbWFkdmlzZS9wcm9jZXNzX21hZHZpc2Uw
MS5jIHwgMiArLQo+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
cHJvY2Vzc19tYWR2aXNlL3Byb2Nlc3NfbWFkdmlzZS5oIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9wcm9jZXNzX21hZHZpc2UvcHJvY2Vzc19tYWR2aXNlLmgKPj4+IGluZGV4IGM0NTcwZTUz
MDlkZS4uNWIyMjdhZGEwOTllIDEwMDY0NAo+Pj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9wcm9jZXNzX21hZHZpc2UvcHJvY2Vzc19tYWR2aXNlLmgKPj4+ICsrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvcHJvY2Vzc19tYWR2aXNlL3Byb2Nlc3NfbWFkdmlzZS5oCj4+PiBA
QCAtNTQsNyArNTQsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcmVhZF9hZGRyZXNzX21hcHBpbmco
dW5zaWduZWQgbG9uZyBhZGRyZXNzLCBzdHJ1Y3QgYWRkcl9tYXBwaQo+Pj4gICAgICAgICAgICAg
ICAgaWYgKCFmb3VuZCkKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4+Pgo+
Pj4gLSAgICAgICAgICAgICBpZiAoZm91bmQgJiYgc3RyY21wKGxpbmUsICJWbUZsYWdzIikgPj0g
MCkKPj4+ICsgICAgICAgICAgICAgaWYgKGZvdW5kICYmIHN0cm5jbXAobGluZSwgIlZtRmxhZ3Mi
LCA3KSA9PSAwKQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPj4+Cj4+PiAgICAg
ICAgICAgICAgICBpZiAoc3NjYW5mKGxpbmUsICIlMzFbXjpdOiAlZCIsIGxhYmVsLCAmdmFsdWUp
ID4gMCkgewo+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHJvY2Vz
c19tYWR2aXNlL3Byb2Nlc3NfbWFkdmlzZTAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3Byb2Nlc3NfbWFkdmlzZS9wcm9jZXNzX21hZHZpc2UwMS5jCj4+PiBpbmRleCAzMjJiNGNmNjAz
NTMuLjBmZDNjMWVmNGY4MCAxMDA2NDQKPj4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvcHJvY2Vzc19tYWR2aXNlL3Byb2Nlc3NfbWFkdmlzZTAxLmMKPj4+ICsrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvcHJvY2Vzc19tYWR2aXNlL3Byb2Nlc3NfbWFkdmlzZTAxLmMKPj4+
IEBAIC0xMjMsNyArMTIzLDcgQEAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+Pj4g
ICAgICAgIC5taW5fa3ZlciA9ICI1LjEwIiwKPj4+ICAgICAgICAubmVlZHNfY2hlY2twb2ludHMg
PSAxLAo+Pj4gICAgICAgIC5uZWVkc19yb290ID0gMSwKPj4+IC0gICAgIC5taW5fc3dhcF9hdmFp
bCA9IE1FTV9DSElMRCAvIFRTVF9LQiwKPj4+ICsgICAgIC5taW5fc3dhcF9hdmFpbCA9IE1FTV9D
SElMRCAvIFRTVF9NQiwKPj4+ICAgICAgICAubmVlZHNfa2NvbmZpZ3MgPSAoY29uc3QgY2hhciAq
W10pIHsKPj4+ICAgICAgICAgICAgICAgICJDT05GSUdfU1dBUD15IiwKPj4+ICAgICAgICAgICAg
ICAgIE5VTEwKPj4gVGhhbmtzIGZvciBmaXhpbmcgdGhpcy4KPiBDb3VsZCBJIGFkZCB5b3VyIFJl
dmlld2VkL0Fja2VkLWJ5IHRvIHRoZSBwYXRjaD8KClllcyBwbGVhc2UuCgpBY2tlZC1ieTogQW5k
cmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BtYWlsYm94Lm9yZz4KPgo+PiBBbmRyZWEg
Q2VydmVzYXRvCj4+Cj4+Cj4+IC0tCj4+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+PgpBbmRyZWEgQ2VydmVzYXRvCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
