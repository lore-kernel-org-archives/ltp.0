Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02156C77B7A
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 01:16:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7361E3CEFB8
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 03:16:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12A353CB92C
 for <ltp@lists.linux.it>; Thu, 25 May 2023 03:16:44 +0200 (CEST)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 97155600990
 for <ltp@lists.linux.it>; Thu, 25 May 2023 03:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684977404; x=1716513404;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=WX9ryiMVo16pgDOXAiCjd+WoS1+vAmzr6B4SgYtZ4A8=;
 b=oF4v2CTHlmAqdL48573+WvSAV2YzWxmuR9lsp+SG5NO7kkrNdLIuyVuO
 kUmVf9ZGnK5WtzMKpZzNdZ+qJJ3uOq3kA3Tl4q4jfen4NhqEgehOfK6aB
 eB6mkAO3E+h+vCumFFqBJqPEu+CficK5hSUwTbBe7m8P8g+hvPMINzz8f
 2km5uduhwxf5Dje+lOODqep0Od8ta3mExGR2mDEQlN87KDA/PaoN2/T4l
 0CH2Gcsks1vCv2qOYk6mrPI8L6Sh1l4Mcmbd3/hfFjR/p3YEQf+mV60Me
 V/jsRRXZMWUsD8CHBm4gSPL143YTGJk8Gb6JrwB6HJhqvutvmem/zg9hL w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="85428302"
X-IronPort-AV: E=Sophos;i="6.00,190,1681138800"; d="scan'208";a="85428302"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 10:16:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMa2/VZ6+5vj0/KxvjlgpKNLDHy9sMpe4mQ+iJkG/NWet5xbbM3IASgE3IDTaDAC8MnPjNEzLJlBXonJ9FQlBIEwNlOFj6xvirG7c6jYSEhB9ICT33sfPDxFLSCne8bvzl5Zw6OlU/qsFwlxik0adNBgB3k+mre7dtE7rfkTwiaF5ugj12APgOzd7ZQShRzpviQkAM74g6WaeMBo1ZQL8jEaw3E3N64HfCXj0BFRo3+gNeO7gTNX6KxnpSMHUuM+vKEvKyvAeUyxvgtJhVOb5No0aydVxaGK2ul0yK6L3S93FAeWl5+EDoSr0E15mAJP8sOZv+7SVZd/wQFiI28jfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX9ryiMVo16pgDOXAiCjd+WoS1+vAmzr6B4SgYtZ4A8=;
 b=E8fTMu6lmYBE7YCOrh+IUoH151EXYq6I/BDsetK9FRgz6UGEhN5PajvGyK2Lhg2w0xEBa+tCUQAHhJCJrNcywAxgezyLzYe3iIqdE2Y8xF0eAgiZoehdMIvRZ08fSNd7Sn1210MyTfStL+qj5wFszgAaexd7PSflopNmrNUIImQBSrCRE+O057lIM3B8viVDBIQgIoLyBQKJpV2jPplOfN+Px35XU1okiq98CbpamVeYgw6awoggINz9XONUAy7aCNwhpvY+XHpe0je0DtOitPzf+HvuDvgy/JdWBiZaR+hvPzpKZ8OeBNg3iMYLJpLraWyp2WLrnVY2HtKVDEPP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10731.jpnprd01.prod.outlook.com (2603:1096:400:297::6)
 by OS3PR01MB10297.jpnprd01.prod.outlook.com (2603:1096:604:1df::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 01:16:37 +0000
Received: from TYCPR01MB10731.jpnprd01.prod.outlook.com
 ([fe80::2a3f:7761:f2a8:6978]) by TYCPR01MB10731.jpnprd01.prod.outlook.com
 ([fe80::2a3f:7761:f2a8:6978%3]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 01:16:36 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, Jeff Layton <jlayton@kernel.org>
Thread-Topic: [LTP] [PATCH] syscalls/statx06: use a fine-grained timestamp for
 the second time fetch
Thread-Index: AQHZiXxwKvEB8nl7G0yt1lrE0eduG69hUlIAgAAOP4CAB8TTAIAAF8AAgAAmUwCAANanAA==
Date: Thu, 25 May 2023 01:16:36 +0000
Message-ID: <b3eb4e95-b7b0-71d6-2929-e9321e1cbabe@fujitsu.com>
References: <20230518113216.126233-1-jlayton@kernel.org>
 <68340cb2-87e1-ff17-2db8-5610beba761b@fujitsu.com>
 <c6c0ae90df044b883ed65ba1896db8b51dfa70d4.camel@kernel.org>
 <ZG3O0Oe2zlezT0ew@yuki>
 <b35f343590352d0c669a017428e815e54e49a9ca.camel@kernel.org>
 <20230524122818.GA691716@pevik>
In-Reply-To: <20230524122818.GA691716@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10731:EE_|OS3PR01MB10297:EE_
x-ms-office365-filtering-correlation-id: 6039c6d0-8711-4871-dd86-08db5cbdaf6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lksMkPtcUgafd9Syos3wD9TBMIRpB2uRJOD+lhhNl4URq4oPI3gkS9iV5ggru73L7H0S948brOrJh7paUoTOU4ZpAqxNRfDetO2XIGpjOrVMyhjvIOJMMLNuU0r9o4eUt2uDALsCBvzPVFMmsiZJPDK/mMQO9zuepLwCNC8eSpBjspymYuLxMrpvUJPE/Ykkv0pse1lSN4Ml495hqmYBB4EGMHNqMw+J3lb0CwM+i5NFyHFndrjv6M3XIwfOKbeK8/3QNXlEIqJbUB/Y4dgKWvT7kfDXUfHfWOcp6wtOKU7JVX264qEzCMkDJ9VFVK2KGoK8K8oDaIT0kViN7MfcHd1fRIlnq7D32vS5WqHKG8T+T5kaxkhQ1JEnRU+6dLd9nGnGx4VA/t1/rHB0XykQjcGly+X4Y9wEpp+UXysw7Q8AHQLLGPG8yIpfLxDpy75T9LDxN9txcj8H2dRX9g3XIwp2G6FAtLptIKh5WI5KFBQol1H8GeYwF2bHLzBILxjmNxg5v7tmSRmtSqCyRk4nagwRnq+K68aUjCdEtCKmgNj9VlypxcjPqOp9gr12vdFQHGQlFbejMucnH2SxShvMTkRGeJj5vu2rN/CeViQw2dLOKKebY4WhGNew5RS+X/PJbvoMu3Tr2VilqM3BAR/RdI+R/iJYLuqf2LaMhDC0cl4WLB2cRC/PYLpTd+qyEpUJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10731.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(1590799018)(41300700001)(6486002)(38070700005)(26005)(186003)(4744005)(6512007)(2906002)(6506007)(31696002)(2616005)(86362001)(122000001)(82960400001)(38100700002)(8676002)(5660300002)(36756003)(85182001)(8936002)(91956017)(76116006)(66946007)(66446008)(64756008)(66476007)(4326008)(66556008)(54906003)(31686004)(110136005)(478600001)(316002)(71200400001)(1580799015)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1hyVmZjUExWYmdYOFpYYVE3UXZHOHlnWjF3UUJvOE9qUkxKMzQrcDZLWnhx?=
 =?utf-8?B?UGVleXRJZmJPWUQrci84Ynl3SHh2Z2I1d3lTMlNlL0NCUkw0enlJN2VlcVhI?=
 =?utf-8?B?VUN5WE8wYkNGYnRvYnVhOHYwN1plRnVVSmUwVkpXbllLUEZzMUJ3K25tSEl4?=
 =?utf-8?B?Q1JzWkxBSGFQalhQRk9qaHRIeWt3MnJDQncwTXhpZGtlL24xbVVDNTZzMWl1?=
 =?utf-8?B?TXRnakZwMnI5ZGQ2NmV0cTdzVTVOSFZYSXJzRXRWbTFleCttejM1VVhTR2RG?=
 =?utf-8?B?Ry9lNUhocllXVy8xZlgrUnk1eVROZkxSR2lVaXZXZ2M3QVFmYWs4dFVCaEM3?=
 =?utf-8?B?VHFsUnRqRmxXSHplY01DMEJXbUtoUGxBWWlTd3o2S1k0cFp2azVXZ1lZSU0z?=
 =?utf-8?B?NXlWTERXRFpNMmJCck9UTUtZc1J0MVhlMjdsUmFTVU1uNzRJVnk2NDZubVQ0?=
 =?utf-8?B?ZEIwWEE2cVY5K1dTbjBqNlFkMGRUTzlLbVNuKzIvektBRDVsZHR5OEJiTmJX?=
 =?utf-8?B?ckJWbk82RXdiRE1YcWNNd2xCeW5qc2xQNmFMdWtYTEJ0Q1IrN25YVXZDZkxT?=
 =?utf-8?B?VEZ3blpvQ05aS0pUVkMvVythMzRvSW96L2pYams0MFhKSDBwVXVjcVFBMVIy?=
 =?utf-8?B?dmZLT3R2SWdXUG94a1ZTMW1DTFpwMmljRDlkdG9DOFBYd0xsUVF4T3ZrTUYr?=
 =?utf-8?B?VFBNZXZqRDdJS0g5MlBMTDV0WHhYcDJ6aWlRV3dodFh1eXRScGNkMzhKelZs?=
 =?utf-8?B?Q2ttdXo3SGd5MEpRdlMwV0RnZTh0OS9UMkpPWHpZSkVvSWJTRjNqMWthbzFt?=
 =?utf-8?B?eURYTXBiQ015QVIveTZpeDVFOWxQNmg4dXhGVnozRWhocVh4S1dSQ0hrNCtZ?=
 =?utf-8?B?Z1h1aFZETys4VDRmMXV5c2drNUpzeUJnVWhmYTkyUmF4Q0Y5VXNObjVEWGpE?=
 =?utf-8?B?MkNyTTdxenlPSmw5aVY2OXQ0aXhXcHBzeGZFc3VUZUEweDNteDlYSGMvWit4?=
 =?utf-8?B?SDQzeGVLMUNJQWF6cExPblQ5dFdZVEpiejJucXZwVW5aZVZCOWdVNnFqMjNk?=
 =?utf-8?B?MFFtb1JEZUI2bHRneXM3aERKK0VLZ3NKRisxQy90S28xNVdBKzJQWGJudUFB?=
 =?utf-8?B?cVpNRTU1ckY4TVRyQnBPVi94a3F5NFNuN05pMldHWFhxUi82NzRxYnlZelBx?=
 =?utf-8?B?QWZiSDNmVnRScTYzb3BCbEJNN1BwZ2prTHhXdzlUWlpyU0dxdG9mN0lQK3hV?=
 =?utf-8?B?MjZSMmxUYVozOUh1SGxCNXRGOGM3YW9qV0pFakF3UjR4YktUNEoyd09PdzhT?=
 =?utf-8?B?SW5BeWxySDNIYTZycEJKVkpxdzVJUnU0bEd2WENLZ2k5VW1vWXd0QXlkNlBr?=
 =?utf-8?B?UFFVQjlnRzZOK25ZSG5NSkpFSDNNWlQvMUJPNGpwL09KTW1zbzBmaktHNFVt?=
 =?utf-8?B?aFFwM29XNDR5VlE2Tm9jUE9BbmlaRWgwVDRaZUszOWdsVHVLYzBVWXg5Y1R2?=
 =?utf-8?B?MzgxZ2N2SDBoK24rcXVxVDcveHkvYWJ6QzJGU3plRDhnWEdWRE1hT29yRUVv?=
 =?utf-8?B?UUYyZWNGVExJZlY1UFpVZ0pXQWU5Si9ISjVXTFR1WS9kYlFMR3FQMUJSNWVJ?=
 =?utf-8?B?V0duRzhLak04a2FvOEk3ekF2S2dFcHNUTmRLaTlBRW9JeTFOZVc4Ui9Db2Qr?=
 =?utf-8?B?MERJM2ViMFJwVXlZQUpNT29qS1dvM080c3Fzb1VxejU4b3cvM0tKeWRxczRU?=
 =?utf-8?B?NU15a0owTEV5d0IvekNIR3lFWVZYalpDZ0Z2V04weWs5K2t4UWl3WTR1bm03?=
 =?utf-8?B?ME9FMHlUQ25MbXo5WnoycUIwZHNMU2FYbmpGNDN1OUNHTkl3b3J3V2w1MjdT?=
 =?utf-8?B?T2FoaTgyV2YvMloycnhOWlpyU1dlT2NoVVJFd0U3NHBrVjRkRnEzNWdqY1o5?=
 =?utf-8?B?N0dQNWE0cVRJTm9GS0R2dEZlR014UDlsQXVHN2RLM3BhM3JONi9xUWtacDBk?=
 =?utf-8?B?WUt1KzFKRzZTUDhMalV4UDRibE5aWERFdDVRczQ4ZUdvcDMxSUFRbllSeVBT?=
 =?utf-8?B?Njc3SWpTUHBKeVQ5Wll6U0c2REFzMEpDQVUxZTE1SEloL1ZiNkpmY3VJRXJY?=
 =?utf-8?B?SGNGSDBraXl1dUFmNU5VajlabkF0ZTRFdkV0aThXam9xT3VndkxxcXh6V2hD?=
 =?utf-8?B?Nmc9PQ==?=
Content-ID: <4EBFBF8089EBD84BBE926975672AB1B5@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6FphwIqTb6VZJz0yIpl4l6zKQwNNux9VT6iFOJpzAcv7cKYp51N+K3G6inzHrwzfwyZKL6nrAXqFpnYG2Vh4xvUgL9OFR+FrXipMwiZA9tVV49ePBRN1EGVkZyL/OqYM/UHzAyesyj/JoNclg42LVEinrYhi69y3JzQCZtV7lCoYYPhLGARHSvxsSZCyGhsLXjhF7WWmK1sv3f+8MnJwn0Gi8xzmh7JSrjsAWDTnhLW9gQwxn9E7AmnIP0N2y99zgNDn/uT/egM9zhaZXUHDT+jPNb42MSoR60ZRuQGtfhIDA8Ed9UR4tYRMYJfZ+zgq/oxHPAcVuVMipi08lKj3n5m+PBYH+wTZci2qRWKFPzLkV8v/QxDbZHGSznj/yWbPQ+issaJ1o+uB+UWyjsxHbOB+sTNkpXohpkRWWpuuYIHSjiqray4kVswws8UE2sdLFJMnDakzPNaJaTo/IpIbALn4/mVSw1qJCl6Tsy93VNDC9ln0+WDaf1AzQrx5smHOQsi+Hjn33yMbInmFzMn84J0f/HNMMyqY+wr51PooCZs7spiIouV2zMakXiNCIUvM2MFXH44FiylF62rlKj3N3+L2bstKi8tDJiRcHrkMOfSpU3aFNHQ0jn0esvnELB8b9KNPv6sYAbZR+UV8oDXGqhUUfz8hG7axb18Lin8zWUCePunnVC8jhSE4emGOnF8Pl2jCso6lvyCHcIAdfGGHIRVeRRHpn4MoxdQfNCLkxsyibkm5JkilLtYf/YGa+qSLVlzzlm3/i0qt0hLdb3Dor/EBGdPS90uooqgpr6GL038hXSfMU7IbMDeuv531Hvpa
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10731.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6039c6d0-8711-4871-dd86-08db5cbdaf6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 01:16:36.4346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luLJof5NKkdIxW/mk9OOdzdFu+gHHZhZpLTpfCcq436jh/WfjFTK4n7gBnV8h+6aXmffS9qbML37npILZwgGx9P0Jh2c9sJDUFpdfMZrly8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10297
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx06: use a fine-grained timestamp
 for the second time fetch
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

> Hi all,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
>> Thanks, and yes. This should be safe to apply now even if the kernel
>> patch series never goes in.
> 
> I'd be ok to merge this now. Xu, please let me know if you're against.

This patch is right, so please merged.

Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
