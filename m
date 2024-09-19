Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA94CE8D46
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 03:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726717157; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=qycTCfZZu3ocyqfAE8mp5yvRykCdrdCB0UVFTvwphRo=;
 b=BWLD/J2WZoKXHeSm/lbsWVOtvUCmvNMfyHS05j/BS2G0QeONbqrUrOXA5eFXzBPiwkF2i
 DPQFRFyNYGG7uwGH24RsDSorND/QDtQsBKu6a+pFxMmwNk8U4zAQi1bIcdXSrw3zUEpMfJ6
 V8rGadKICsnE4dBBo168yVGHQgmhG6A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B53B33C2F4A
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 05:39:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2D8C3C03AD
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 05:38:55 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.159.88;
 helo=esa8.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0EC2920470B
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 05:38:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1726717134; x=1758253134;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rQ6DGZAlM0WiaebMYvWwX2bLAtpucW5YFW9JUam76vc=;
 b=CsaW+gJKuD8sUuk0inKYJsTU3Xz614fkqHmSf0l8B/8DvjhsYfpyMiF+
 XDknIe5zEDMAW2zM25UbmCABpvVCquGyx16+2J9F4zdPn+fiGd7U8s4hQ
 4nHaGu+hEkqYzii9w5k2exDeVPfSbSfBoJLv3UMooNyZSSMS7hIxcM3tt
 AoCsrEOYWK3Al2mJlZ/0zbIL7Zx9DHy8gm1+ZrO6HNIxyveuPQaAugKvg
 lEWR9KSs4s7vZZvuzLK1DrWZlkz2k34krMRfGh4yWqYJNiOJbiTJcmkJN
 KRDWNUd8hnxswZzQD1J5mcneYyvE3GPtL4thC5TPS2gfi7giRkVGYqmEC g==;
X-CSE-ConnectionGUID: NErRTyO6T/2LV8I9PrT6VA==
X-CSE-MsgGUID: 80tm0TCqQfq5gvFQWDxihw==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="131227562"
X-IronPort-AV: E=Sophos;i="6.10,240,1719846000"; d="scan'208";a="131227562"
Received: from mail-japanwestazlp17011026.outbound.protection.outlook.com
 (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.26])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2024 12:38:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrrUEIu8rtofyimB8346kutQPOkG4FWjJMgiaPgUfjSOhsStybE8UxJ0LXJDwbC1XKbtEuVIrZnXBHJ7b0HaeOcsjKp43ixsKXCZJwwHZRrtlt8vHdtM9f5RhtpL06v+RztoYch/eUhqdDeKm4juDFBLY1uZYJVtk4xSZvQf9PLME4lGyxQ13N1ocDhhF6u27on2ga3J3RX6mdHEG6XYBn9Niw0s6WBpPzHH8PmnGo1Kms4wPpBwbSIoqXu8JYKkveY8rUwNeOJgd2ufPSNETk45WpOBaC+BddZYVp6imnWd1TL/7Milx6JaRTMBTwYrZqp4BVZPlxg1tjMmNmyMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQ6DGZAlM0WiaebMYvWwX2bLAtpucW5YFW9JUam76vc=;
 b=EMLQmv6vuKPYhAK9+/F9Aqi6dINEI7tA0GiHWqZY4Zw+IEvEOcn24MKtfppUuHj13RQyuD+Ab5EGFD2rxMkYjZfSsaZtIMzoKMu9y94HrL01kkbpGp+GPr6eYAs/OZ0/kKxQ0w3tsnhLw9HAewtlJxCNKLhCOf/yDGmKgoRIJEiTGuFqQgqC3GHo8Cf0DMHJM/xczeIvBeN7SdCqIDBGi3i6Y2v0hanZWXY97PgZ2sL7VknKxMMITDUavWcq6hPPfOSHrkS/uV14uR6+sa0RUl67eFEhBRCSgFFKsaqi3wa/OxBLA/aqtPjl4gppKdH0qKtixplGQFn8NLW5VCsNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by OS3PR01MB7158.jpnprd01.prod.outlook.com
 (2603:1096:604:14f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 03:38:49 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%6]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 03:38:48 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] posix/conformance/interfaces/sem_timedwait/2-1:
 add _GNU_SOURCE define
Thread-Index: AQHbA2ZRm04n/jvQlESf9O3e/SgVLLJQzOqAgARLb6CABvlKAIACcaog
Date: Thu, 19 Sep 2024 03:38:48 +0000
Message-ID: <TY3PR01MB12071E5160B84946210EB66FBE8632@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20240910094755.57438-1-maxj.fnst@fujitsu.com>
 <ZuAbaUHY8ZPjN5ey@yuki.lan>
 <TY3PR01MB12071A725A400AA4C08040DBFE8652@TY3PR01MB12071.jpnprd01.prod.outlook.com>
 <ZumPSk0VdqFa5Eqn@yuki.lan>
In-Reply-To: <ZumPSk0VdqFa5Eqn@yuki.lan>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MGMzYTA2ZjgtY2JjNi00MzU2LWIxMTUtNjM4MThjNzA2?=
 =?utf-8?B?OGEyO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA5LTE5VDAzOjM2OjE2WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|OS3PR01MB7158:EE_
x-ms-office365-filtering-correlation-id: a1850271-0fd2-4b7d-cef5-08dcd85c9292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Y0pEY3BQT3haR2xMT3RReEVpWnordzFNQXhRdzVLb1EwMlc2NC9aZTZpOUJ0?=
 =?utf-8?B?YmZWRjJoYVJ5T0U3bzJXeTBTemxvRTVYVzBLZFFxSFhRZE5wb2Q2UHRWQTJJ?=
 =?utf-8?B?RnBPRVdqdTgveUNBZUpSemVOY1hjNEpOUDZTNWtkZ05VcHFWcDBzbVQ2SGFY?=
 =?utf-8?B?UktGc1VicDBySElVK1NsNStUUDdybzBDL25HSEJNcUZrQXNKaXkycmd5cFdU?=
 =?utf-8?B?aFdyRjhaRXk5Y3Q5SFArWWFFNEhlblFXWlZJNzNKSmQ0dEx6Z0tub3Yyam9M?=
 =?utf-8?B?OEN6bTZZVGllL3Q3UzkzckJ3NTVhaGh4anFQR0I4TE5uVzg3ajYrTlp1Q2Zz?=
 =?utf-8?B?N2Z0N3JXRDVQYVpnZzFtekh3YjI2WUlMQ1FsYWpSd3kwTFhiVi9Dd0xDT1lL?=
 =?utf-8?B?REdPTERndktIejVIMFAzbDVHSkZLZ0J6ZFVySDRxV0pYbHAxWjBDSjBtTTdI?=
 =?utf-8?B?QlF5T0UyL3dGZDlaZEJSMkowcThmV2FtZUNOSXhyOGdPZUxOWUVEbjI4d05x?=
 =?utf-8?B?L1lJemFLdkJyVVRhelVkdjFqQjhSMU5EbTBlQm9JbkgrNkdVNklCUG9Oa2Fk?=
 =?utf-8?B?dEt3b1VINGE2a05JN0czTFFwSmtvVFhocTVtWnZPajVHWFhLV0F5L3RmZUI3?=
 =?utf-8?B?ZTlOMW5ab015a0ljYk4rWWpzbStWUnZ4dTd1enQ0K3BzUmgwVWwvd1hDdGVG?=
 =?utf-8?B?QmhORWlMUDJqdXN0Myt5YUZ3NzJya2g2SjVHRUtCUUdWNHYrNTlWMytlOUZ2?=
 =?utf-8?B?TVNnVXhXQy93a1o1cG96U3VaSFZPRlNwSlZlSTZjOUN1cXBON3dsb2pURGNK?=
 =?utf-8?B?dzhJaFp0Q2tKcVJiTXlaamRvQWV0OTZBT0prQVZ1Z0NjR1dEd0lERG5UTmRI?=
 =?utf-8?B?ZTMyMHZ5aWJHS1VoZUpMMGdPTW5wNmtBSTlmZ003Yytha2tqVmpHUmF6bmsx?=
 =?utf-8?B?T2NiVVNmRnkxNXRoWWhmd2VlTlE3Nmk4cXN5WHJOblhFN3pKdTBjSk9XYm5U?=
 =?utf-8?B?bndnUTlXdVF0dnRRV1B1bU95bnNocC9kZ25FNm0xQXVDYzNwWEE1cVE3Y05q?=
 =?utf-8?B?RmFObU81c0dGTzJ6MnFBRVhoRTBEQ2ZqUGNxdVJrSW53R0VOQnNQcC9US3Jk?=
 =?utf-8?B?MjgvbWs5Z2ZwRHdrYzBJVHZTOVdBZUNEWmw2NHRWeUZQZllWUTBFdW5zZVgw?=
 =?utf-8?B?RG1pNisyM3lKeVpORnozc1hUYWdHNURUWFlCQ3V1b0I0VmtYdE9BbTNqL0Nr?=
 =?utf-8?B?RXBYTUplRGVRcnMxOXZRREkxd1VLZUprcmFKalVnb21Zci9hQVMzMzNIMEpU?=
 =?utf-8?B?bWlYUFV6ZzNTaENaZTEvSkNUSC9zdWNTb0tsNFlQNnJ1OHgyNnBma2xFK01j?=
 =?utf-8?B?M1RvaENtZmFMMjZXbHVRZnZLTktvRXVERFZST3I1QW1lUFMxQVZFTXdIcmtV?=
 =?utf-8?B?bFpYUEF1QXNMdFltVVdVQ1pLVmo4NGVjODFFWU5nUFVTdWFkbXRJdW9ZVDFl?=
 =?utf-8?B?Q2xxMkRDTExSaGgwTEJLRklGbTdJcnIrUUpXMDBQbnFYMUxhS2k4RVRjdEFB?=
 =?utf-8?B?WW44NnBsWWRHOG9hVlg1L3FTWWdiMWk3WlBONmlFTWtXQ2NuVmp6VHlkZ2I2?=
 =?utf-8?B?SlJ0c1YrL2t0ZFZKSVN6dkJOcVFvY1pJamR0Wjhra21OQlR3NjcreWtJK0xh?=
 =?utf-8?B?MFpxK2o1VnJlZE5GYWFFRFMvUkFyQnpGZWUwdUxDSFpUUllRRmFZMEdZNHQ2?=
 =?utf-8?B?OFFRZ1o5UklRSjlOR3BMckhPc2cxMmxzUEFLL2VSTmcySTc1QVlWRERFZHp0?=
 =?utf-8?B?dVlKLzRLY0hSbk4ydjFuMDMvd1RuOUFoQjNDZFNnYXF6Qk5reHlLYk9UV05J?=
 =?utf-8?B?V292VEZsdzdWd20xc0lIZHBMcGZTYXRQMzlHTU5YdjE2dkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFlFUlZuV3g0YWhMeEllQ3gvWjc0aFNRTDRibnEvUyt0UnA4a2VYL3VyS0xQ?=
 =?utf-8?B?aldkYWFqZVk1NXB6Tkp2T2hKcWxSUHdyRCt3M3dvYnlwNFl3anNKU2Z2T2dP?=
 =?utf-8?B?aFVFYVAwMVNNTlJKMld1TTdOWUZ3cE4yak9heTVoU2FvZHJIL0FGajhidzJi?=
 =?utf-8?B?dmVTNGdHT2RKNTdpQzVzYkR6Nng3RWw0dmVFYjluUmhxK1ZkTXFHZ1AvZXRs?=
 =?utf-8?B?Qklwakc1OHJ5c0NJVklpdjR1akYyN0Q3RTN0eDM3V1QrNGVoU2lvNWJIRWdx?=
 =?utf-8?B?QTZST1E0bkhkMXgzV1hydXNmaHE3c0Jnd2wwOHg0UlhsKzU4OUFidGwxZHp4?=
 =?utf-8?B?bEdpRzR4THRZNUZnMWRHNnd1ODlKRFUrSzNaOWt6MmtBb2w4NjFZM1cxdDhn?=
 =?utf-8?B?aTdHdUdNZzdoMlh5VkVCRnVlNCtONUQyVm5BTllIcDdmOFk3bk5sK2R4UXRn?=
 =?utf-8?B?aTBIT0YyQVZDN2JhZTlHb1hQNmxYcExtNGd3dDFxeFd5c3NMQzRDNnBDVTZ1?=
 =?utf-8?B?cGliMlhTa2ZFbnZNRTl5STJBdjdlQUxPaUhxSDVrdEJSQ0FLMTJYOGRVMUpR?=
 =?utf-8?B?aDI0YnQzY1hMSWFkR3ROTlFWbUZNeUU1TjB6ZmtuU3I2U2I5YWNRdXlwL1Q1?=
 =?utf-8?B?ZUx3VEF2MFIxRGJXWDVOZ0d0V3hPbml3MkJnaXRCeXZ3N0doaVpod2NLcDRO?=
 =?utf-8?B?dUlNVzRXVmljYXJIRmxtK1orVDV4blhZQ1M5NUtXRm9kV05CMEtsZTcvZkhP?=
 =?utf-8?B?R0FwWnU4cVZXK25GQ1ZXa3oxMCtWNHd4NFk0MnB6VVl4aW50UXk3b1V3T0Nh?=
 =?utf-8?B?c0tXM2VpMHNUdWhadTZHZVR6aEdVODg1REx0NEhRZHFJblhKL3NxUk1OZVdG?=
 =?utf-8?B?RGY5TkloU213dWwrU2txNzRsZDgyVGs1VWdKdm9XZHNHdURJcU1LT1RjQkJI?=
 =?utf-8?B?ODhueHR5SmM5R0txeFJSRVJyT1M1R0ZSL0NIUTBla3U3c2hsWHdmV2k0ckUw?=
 =?utf-8?B?ZG5HUG1ub09aTUgremYrWWpSY21wZkJzZTJzWTlET2pIcnBzRGVsdC9KcXlC?=
 =?utf-8?B?ZzBnV0FKdjU0eVpNTDdlL2tydXVrUFhnc0ZPM254cmNPL3o4KzVPdXpUTFNp?=
 =?utf-8?B?bU1HR295eWQzWi9uV2liaUJjOXRYdFR4Ly9ta09icWVUaUdlVGl6eUY2ZzFG?=
 =?utf-8?B?aHhQdFN4emZLUVRKM0p0bjRqYVlidGpTcFdvejJ5NXJLd2M1YWRtT0l3aXV5?=
 =?utf-8?B?dVpjMWRvc3ZwTURhOFo0OWJhcDFlaXdZdTZWOVB3V1M2NkRmNVJaUThGY1g0?=
 =?utf-8?B?ZVEwZkx6RnpGd2JkU0VPQUZNMkhUaG5ScWdGN0ZSTThUbU9oWFBiYmN1V2VP?=
 =?utf-8?B?cm1LSEVScDh4dTBoWHZ1U1dlRFptZ0JURElSdlcrZnozUUhrcVJvTUxFTFZF?=
 =?utf-8?B?RUNOdTB4NzNZSzBnRWRnU0pWZUIwd1JrQzNDbEswSGt5NUtYMW03TU1MWm5B?=
 =?utf-8?B?aFFkMXpEcFhSb1dEVFBJQlBseGw2RWx2MnRTbVFKVXpYK3hOUUhDdUdzdkVa?=
 =?utf-8?B?enNJNEIvSnBkNnpuQTJ6N2tvbml5Y1FBdEhldmtwMCtIa3JCakNQcTJ2ckJP?=
 =?utf-8?B?cGNLK05xQ0lYaDFTNFBuQTkvS3hnaHZscHBUZ3hsdjdJcmM2S0EyRjZJamhI?=
 =?utf-8?B?NEs0MEJrdjhTZ01USmwwbnZGSkFFZzZwTWtHc09VNU8yUU1FdWF5T1Y4alJW?=
 =?utf-8?B?MFBncjhvRENkSFc2NDNQSFZBRGZMTXBuS0VTYTdibC8yamJvcklJRm1keDR2?=
 =?utf-8?B?UVlMTWdiNC9hTnZFb0V0cjhmSklyYUd1cDZjM3phbDBOcnpXVVdzOXlEZEt3?=
 =?utf-8?B?Q1VpRmRKQ2Z4WUZyczg2MGc1OHpQaHFBZytrS0dKRXFrcGprMENXY3BFQVZm?=
 =?utf-8?B?VVhOU3ZGNlhzUVZiQVJNWGMyalJDTUNFc3h3cXFZRzRLcmM1c0ttZnAwTEVx?=
 =?utf-8?B?RlkwQ2JEV1Jpd25MZCt3N0pVUXYrMVROem5tYmNmdXBDQnZ5dTdnaVRHN0Vn?=
 =?utf-8?B?NWxBVENEQlZaMXNqbDczbUJLNzhCREN6cXhFMFBCY2x0QitJQ2tqTWxibDdD?=
 =?utf-8?Q?l/gsQ3q7NqD36BzO14kYqy1ix?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jW4YAj7Rz2DyJ1ab6wSOzzFPawQ/6lzpoZe2dtXwZx3kiS2soDuK6x8LMO9BbBdLTq19fapnTz764o4LR8tBNFR5dAQEfBYq6RQaieNcR0ezT3noJeWw2O7gA2mgj+E/cRM4Iny47FrCl2F3cY2Y29oTQqyaQ6P68ibR4X7FHlh8rZYichg82kHLLRY+uSEsexwQRJN4Ho916EbFVYY0QkWqQvzam9TzzeIeK47SHf8BoQYk6t+KFKZHQMUIEpsX2ETQYMiSwyjsOHNIaTEFBIQETFRzulIuGvdwkqXta5hD0Yghfe1x5DVn1FTB/KDuEAaKHaPWUTX7eUxUNIu+sSx4dIs3puztDzDUPa3NJGX8lCQfcK0hueeQRPKBe3pFaVRSwIKE2GlpSMOotufYi045z3fHh/h29vDHMmxZlYUkHftC2w3vQbcu+geYev3rq23vFnvDto+hXk/ME/tTWHPvkLR0jHzmAOEGO+kiCvYekKDIb8hK5y+WOYEv7KJHkNHdLWe5cmX5ikfwCmIkSIGeRP2fbK6TGx4czKKwggw7+EEfRDM2m9OzDXjBEd+yOtjYKZ67BOLTJNk36Fs44Lk6DP+jy5KPyEQ2oH/yg9r4QCQ0LkltbDzOPmT6wPzM
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1850271-0fd2-4b7d-cef5-08dcd85c9292
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 03:38:48.7005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ua6DysbMtlHiZye9oI7xpAx1SL92R5UZvvr3ZGMOcJ7bfD/Mu5XS8g/Vcikq728hTqbeZXi0pLHer/o83ZMEjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7158
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] posix/conformance/interfaces/sem_timedwait/2-1:
 add _GNU_SOURCE define
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
From: "Xinjian Ma \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Xinjian Ma \(Fujitsu\)" <maxj.fnst@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDeXJpbCBI
cnViaXMgPGNocnViaXNAc3VzZS5jej4NCj4gU2VudDogMjAyNOW5tDnmnIgxN+aXpSAyMjoxNw0K
PiBUbzogTWEsIFhpbmppYW4v6amsIOaWsOW7uiA8bWF4ai5mbnN0QGZ1aml0c3UuY29tPg0KPiBD
YzogbHRwQGxpc3RzLmxpbnV4Lml0DQo+IFN1YmplY3Q6IFJlOiBbTFRQXSBbUEFUQ0hdIHBvc2l4
L2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvc2VtX3RpbWVkd2FpdC8yLTE6DQo+IGFkZCBfR05VX1NP
VVJDRSBkZWZpbmUNCj4gDQo+IEhpIQ0KPiA+ID4gVGhhdCBkb2VzIG5vdCBzb3VuZCByaWdodCwg
dGhlIG9wZW4gcG9zaXggdGVzdHN1aXRlIG11c3Qgbm90IGRlcGVuZA0KPiA+ID4gb24gYW55dGhp
bmcgR05VIHNwZWNpZmljLg0KPiA+DQo+ID4gSSBzZWUuIFRoYW5rcy4NCj4gPiBCdXQgSSB0ZXN0
ZWQgYm90aCBvbiBGZWRvcmEgYW5kIFVidW50dSwgdGhleSByZXBvcnRlZCB0aGUgc2FtZSBlcnJv
cg0KPiA+IGlmIHVzaW5nIHRoZSBwYXJhbXMgIiAtc3RkPWM5OSAtRF9QT1NJWF9DX1NPVVJDRT0y
MDA4MDlMDQo+ID4gLURfWE9QRU5fU09VUkNFPTcwMCIgZm9yIGdjYy4NCj4gDQo+IFRoYXQgaXMg
Y2VydGFpbmx5IHVuZXhwZWN0ZWQuIEkgbWFuYWdlZCB0byByZXByb2R1Y2UgdGhpcyBvbiBEZWJp
YW4gMTIuDQo+IA0KPiBMb29rcyB0aGF0IG9uIGNlcnRhaW4gc3lzdGVtcyB0aGUgTU1BUF9BTk9O
WU1PVVMgc2VlbXMgdG8gYmUgZ3VhcmRlZA0KPiBieSBfX1VTRV9NSVNDLiBUaGUgX19VU0VfTUlT
QyBpcyBkZWZpbmVkIGluIC91c3IvaW5jbHVkZS9mZWF0dXJlcy5oIGFuZCBzZXQgaWYNCj4gX0RF
RkFVTFRfU09VUkNFIGlzIHNldCB3aGljaCBpcyBzZXQgYnkgX0dOVV9TT1VSQ0UuDQo+IA0KPiBJ
IGRpZCBkb3VibGUgY2hlY2sgdGhlIFBPU0lYIGFuZCBJIHdhcyBwcm9iYWJseSBjb25mdXNpbmcg
TUFQX1BSSVZBVEUgYW5kDQo+IE1BUF9BTk9OWU1PVVMsIHNvcnJ5LiBMb29rcyBsaWtlIE1BUF9B
Tk9OWU1PVVMgaXMgaW5kZWVkIG5vdCBhIHBhcnQgb2YNCj4gUE9TSVguDQo+IA0KPiA+IEhvdyBh
Ym91dCBtYW51YWxseSBkZWZpbmluZyBNQVBfQU5PTllNT1VTIGxpa2UgYmVsb3c/DQo+IA0KPiBE
b2VzIG5vdCBzZWVtIHRvIGJlIGEgZ29vZCBzb2x1dGlvbiBlaXRoZXIsIHRoYXQgd2lsbCB3b3Jr
IG9ubHkgb24gTGludXguIFRoZQ0KPiBvcGVuIHBvc2l4IHRlc3RzdWl0ZSBpcyBzdXBwb3NlZCB0
byBydW4gb24gYW55IFBPU0lYIGNvbXBhdGlibGUgT1MuDQo+IA0KPiBJJ20gYWZyYWlkIHRoYXQg
dGhlIG9ubHkgc29sdXRpb24gd2UgY2FuIHVzZSBpcyB0byBhbGxvY2F0ZSB0aGUgc2hhcmVkIG1l
bW9yeSB2aWENCj4gdGhlIHBvc2l4IHNobS4gVGhhdCBtZWFucyB0byBnZXQgdGhlIGZpbGUgZGVz
Y3JpcHRvciBmb3INCj4gbW1hcCgpIGZyb20gc2htX29wZW4oKSAoZm9sbG93ZWQgYnkgc2htX3Vu
bGluaygpKS4NCg0KVGhhbmsgeW91IGZvciB0aGUgc3VnZ2VzdGlvbi4gSSBzZW50IGEgbmV3IHBh
dGNoLCBQVEFMLg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjQwOTE5MDMyNzI5LjQ1
ODcxMS0xLW1heGouZm5zdEBmdWppdHN1LmNvbS9ULyN1DQoNCkJlc3QgcmVnYXJkcywNCk1hDQo+
IA0KPiAtLQ0KPiBDeXJpbCBIcnViaXMNCj4gY2hydWJpc0BzdXNlLmN6DQoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
