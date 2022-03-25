Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD0AC433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 03:00:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 771603C5A8A
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 04:00:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C6EC3C189A
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 04:00:42 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6BC912005CA
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 04:00:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1648177240; x=1679713240;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RertSNITDqR7T/3btAq6++6vYlE4vP6rOJ4JkhjKYgE=;
 b=B2/jH4NdrhmXODHcf/DuPR+yHDCBaaQurGyzIJ6pSufMU3ercIRfQtjm
 FeYs63zONnN+/Lo3t6WWljLvA4YGsfb7khU/iEmf9hNfpZ1QJd8BiDLEY
 LoRk2fE2hKzsEApkdE40GCqz9DZTSuHSyKShXpwJVbxcQVJ2DpFG9pdpH
 pfH1JgXZmaQmb11fPznHKjPEyEjROTXCeJWaqegDRpM8oiYRVK3CRHRr0
 i5n3E5qmVuHWeupP2BkeacafwVrUrza4Gmaba3uoPVnc/0YL5R44M+MW3
 QxZNvC5y1CMyVy0z7y9FttcvEl4Fa+8iJlolx5Fsxl9rEQSRSK6zvDBrp g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="52483268"
X-IronPort-AV: E=Sophos;i="5.90,209,1643641200"; d="scan'208";a="52483268"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2022 12:00:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCtIUgu/Pn7jHBBCsJz9QwSLgo5bxkh+VGV3nje6Wk8inN8+A0950kSOgYHsicNaGuPaiGdnBtd5nOSz3IdPzcu9PkIWDtm2EEus3a/BISgEjXlasBizE9MQ0ZSymOXx7NetyyDEFohDJtXZQEJnzsC/08zk4Bjbsramu7oefkinNfc8l7aZ8Vk5aTPjwjKIZMeR3VjgnIWwAYaGtgEpZDvGpBvPyJ0tkWWUvIWygwjNIyH2i0fiCDnKrLPuaJ1gc613AqkeMNC1pszyRSJM6X3i9NQ0UV0y9DGgHZUH0dJLua2ePMyHNiBL7qiHk7OvhQm8DceF4Tb+p77nBkM8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RertSNITDqR7T/3btAq6++6vYlE4vP6rOJ4JkhjKYgE=;
 b=Uqtv4ygfKRA7V8mhkYqcxiDy0Y2mp2PdajE/zu/vq22E+jj9RvsxAwB8R3ltG13k9Hpwg22OyW41nX2TAeMODJW3rZbVTnZ5EtPXF6GaEwBOOWVfScf27+zXET6A7WuF1eIw9sRvdGItCWEUBLNq8aJ9OT5WPMQ2k2iqlN+/hvZLSgJ6bxx6+lDvHhdLBPHLUg/gQ30/Efgu8cQ4oYmQDMZZbnAqj4fVoz0aPT/xHuaUVz75ZurH3LihWK+B8PH1bgeL4yTRj6187KanSol4lnFOH01wiL7ypmThY+UFfgZRIxXFWnHL9ERsxiGUeO2aNq8i6eotTFVoPRJPdX8/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RertSNITDqR7T/3btAq6++6vYlE4vP6rOJ4JkhjKYgE=;
 b=YlzR1hhy8ChWXpC0/+f7hUawMdcX+a00i3ZkOnYm+HFNayu+hQg72weilfU39jZUg83hTikDYEPIbx+ego+Q9YaimQjrypIwnLHrCQhGizbGDeJtWwKltURJ1fffOwDPxrG5O0O4bDPjY2YwDg1I6jGGHMRATgjvLrtB/5OXjV4=
Received: from OS3PR01MB6134.jpnprd01.prod.outlook.com (2603:1096:604:d0::7)
 by OS0PR01MB5860.jpnprd01.prod.outlook.com (2603:1096:604:bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 03:00:33 +0000
Received: from OS3PR01MB6134.jpnprd01.prod.outlook.com
 ([fe80::21f0:c3a3:717c:3ce5]) by OS3PR01MB6134.jpnprd01.prod.outlook.com
 ([fe80::21f0:c3a3:717c:3ce5%4]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 03:00:33 +0000
From: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v4] syscalls/umount2: Convert to new API and use
 SAFE_ACCESS
Thread-Index: AQHYPzBBWFA72XdZ1kGuB0kYT9tvpKzOQAoAgAEqkAA=
Date: Fri, 25 Mar 2022 03:00:33 +0000
Message-ID: <7a4a5b7b-0aae-3007-dd07-e8a1f23888d8@fujitsu.com>
References: <Yjt21XFn+8n78gZ7@pevik>
 <1648136116-22026-1-git-send-email-daisl.fnst@fujitsu.com>
 <Yjw13F9Tc2m8Hz6k@pevik>
In-Reply-To: <Yjw13F9Tc2m8Hz6k@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f91cc442-b1af-4eed-d044-08da0e0ba0fa
x-ms-traffictypediagnostic: OS0PR01MB5860:EE_
x-microsoft-antispam-prvs: <OS0PR01MB58607366B0A7A5E0E34A3A8A851A9@OS0PR01MB5860.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: krmDf5oY3Ky6lF+ZLA/jkXWyccG86LxavaV0RoyoZuUlCEqusvV6sviraTLdNhUJP1yIflbUHC85h0Gz8eMCQyUZcRQ5/tuN4Zqu6Ldh0dhaTx3z6vBMnXnEh4f/Du13v1LR4F/y6+Y2aut9b6OupXJEA3eKiYtVCrWWdh105po6c4mJjuRSA1GXy83jRFzTwU8PJC4cvNpPakX+cFZLp/5CtvmoHxW/gX8CLbZkp7sv+E5xMCY2o4FNymLj8gvMdxNUeuGqr4PQgjRCxAMVbHNZYSa7rObyyjwfXrszeo4EjiiptHrf4yuwswz1f6WasEiPLU+tTgKgaT+RwUI6R7Ia73LVjTdI/XXg3DJXjSV1Fg9TVFODeoRI+oo/hYCkfRtF97cXE5SPNbDYg3mYghKKj2OVMRwNhHzLG/PCrvCKhxP4cv5yGoeISDHvPaE/Gl2NKQ7yqurYvsBEYnpdOe0+STzHkvolWmoYtR0yD2IXEQDRlJ/sQZ+YE69gnv5NUX1VKS5mw4uYMlVx7YAw9TbzGEG6kJZcV6xoKgRTvRh8xswXkI4VKTXLpXyyXxiWRpXF/zUHE3AVrAruRobOHty2fqVR6Q4NYv1olqQ6xk5pvNpuERbfe0pBwStra5vMegGWeZqjohMttXKcdRq7uMs7ehcufns5oBSAwWzLoZndvW07SUy0fRx4nUSFXkum9Zin1hvGD5iE5//FhyGPkd0L4K3vIgBJprsT9NUaV5gTTDePV09pRVlLcMcE7XfXm8gw9BDVHld4ZDQFhtHXqn2SA4cFrD++XJdIyBXZnlEZ4jgqdHTtQBZ2cXepaROnEG/qvVJxNUBea5UoAsYi/4i2CQ4pHekesVkdi5iTbh4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6134.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(36756003)(85182001)(83380400001)(31686004)(5660300002)(82960400001)(8936002)(66446008)(66946007)(2906002)(64756008)(91956017)(76116006)(4326008)(66556008)(66476007)(71200400001)(6486002)(26005)(86362001)(316002)(54906003)(2616005)(8676002)(31696002)(186003)(966005)(6506007)(6512007)(6916009)(508600001)(122000001)(38100700002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RmwxalU1MXM4dW11U2ZPTmJqRWlSUkpsTnFWL1pYbXpSQ3IrTGl0SXZ4Skwv?=
 =?gb2312?B?OThiWkZQK1k1c0VUMGovclZMWE5SYjRRRy9pSGFiVHA2YUFPTml5L0VXdGYy?=
 =?gb2312?B?MG5GakJWamxaQm43YXFNaisrQnhNZitiaHFvbnVuTHlpNTYveWg1V2F2T0FE?=
 =?gb2312?B?bTUvMTdTL291UlI5KzhTZjIwNDZXS2pXOWU4M2c1NUE3Ky9mZHg4L3lwdVBl?=
 =?gb2312?B?V1RlV1VVSVpjeU1LdlVxY0paRzFwYkxlY016OXhobTFTS0hZY0Y0dS81OSsv?=
 =?gb2312?B?TGRPTG9ISlhBdi9qNUFUVnlEVXF3T3NVYVYwTnFHcFB6V01TcFp1ZVlLSkRk?=
 =?gb2312?B?RjdXN2xTN1dSSHRtUitWRzBJczRxTEs3Sjg4aTl2N0R3QWUzTWljUktmYjhv?=
 =?gb2312?B?YnNZeDBzbmZqbVlDcllPMjdCNXRlTVpHaHNoMjZySXpZU2VwSUFHVmxjbm84?=
 =?gb2312?B?RlVrMDBJNTRyMGc1V3BIanZXamkyOFZqR3E4eDE1dUJJVnRXckFQUDRSZVRO?=
 =?gb2312?B?MTVpY2RKdXkvZ3JwRkZVUEFBd0M5c25SY0d4emhSNXl5REhTWkRHdmVaV3dU?=
 =?gb2312?B?R3owMS9CcHIyVzc4RlpoblI1KzYrcjVBSEVjWk13NENlWkZKVW1IaFErN3I4?=
 =?gb2312?B?aFY3OFlkbHlhZUR5RzJMWlZMSDJJdjZ5eXlrNWE3L0NmdWFGQjNtM2RRN3pQ?=
 =?gb2312?B?VnZKTHlpQ2xxSkNIUnlwMllrVGtmUUZ2QUtCSHV1a2s4R3BUSFRJVllzV2hl?=
 =?gb2312?B?amRIdERVKzdWdmtqL0NYQ0l2VWV6K0dXemdqNWl2OWJnTCtjUUFkVm1FWVNq?=
 =?gb2312?B?YUpucVVsbnUwL2YvYlVRdmtqVmpzbTdZcXBidFJXaCthYWpRdGRScUVrT1Mr?=
 =?gb2312?B?b1dZcFU3NWduNGpMenVuNlYrbXR4bTE2TGc2cUo5bk5jdVV0L0trVkdSTnJq?=
 =?gb2312?B?ZkdHL3pGYXF3L3VpMXVMTHdYQ0tLV0hJOTdNYzd2Q1NPQWZrOXJ2NWlBeDE0?=
 =?gb2312?B?ZDdnUjVZb1d6eFFqRk40QjJMV3RQUVVVVHlCdmhqRGJpbFV4aVlYU25uVG5B?=
 =?gb2312?B?bUVhRHpaTlE1UW1nR2ZENjFoS0pYeHo1L3pCSlpkMVhGT2NVVXN4SXBqU2Zl?=
 =?gb2312?B?SWt0SitObnVydkpDRFB6bjF0S2pBY2pRdUpyNVQyL2NUOExPK3NXOHYvbHRW?=
 =?gb2312?B?MDdyWEFIODZodDZTeTRxcnNJR3pnMGZFNm50cTdPQ3pkclQ1NHYzS0V6YUlK?=
 =?gb2312?B?MWQvZDRzTzYzUVoyd3JrTnE2eGVvMThCYTd5a1NHTzErODV2ZVZYN2RuUWpL?=
 =?gb2312?B?ZTFuS0NSdzlwOWhUSWJ2amRMMmN5VTJsMnRnT2hFMWh4UFcyQkw3SHBFSDhm?=
 =?gb2312?B?L1hPUm9rUUE0cm81MnBMR0lEWHJxUGV1WFpTSDhKZXIwbWJZYTBoOTg0Tm9J?=
 =?gb2312?B?cEovODcrRE9PRGQ2S1JwV2c5cnRmV1BRcElROStycTluNUJSUGJsdmdMK0RQ?=
 =?gb2312?B?RWtYN0k3LzhuSGRmRkxCTDk2UzdYcjBxeVN4dTN1Vm10MnlTTUlKUFJDQVNC?=
 =?gb2312?B?VXNlRHVueFRKdy9RZVRRcTFmNEErT1E4aUdOeis3TVNXZW13c1lyRXh4eXRL?=
 =?gb2312?B?UUlvM1J5aEVyR1FSMVk3NFBtaGVLaFRpRnR1WnVRT0JsZU1aN1BINURLcklu?=
 =?gb2312?B?d2tYWWVLVnU2K3I1dTQrMytiLzY0R2tKOFIrYzh6TklQVVJoRW9na0M2TDRE?=
 =?gb2312?B?M1RMSk9xeGUrcGdvZ0g3K2diOVNvL1lDeDR0bXkxRFNmZDZ6SXhjc01QNVA4?=
 =?gb2312?B?eVdyTXYyMW0ramdmdS9YRm1KS2lGRi9KYVhlQ3NXdHo4OVdPR0NCUXdMdTlm?=
 =?gb2312?B?QzF6REp1b1JwcEhIRkk4SGNybE9VWEhVWW9yTTVTZGl5ak52cC9zaUgwK2pI?=
 =?gb2312?B?aDhnbUk0Y1Y1Y3hqZ251MG4zN0wrSXJSR29IR0NrZVhQZHlMdHY1bWdVczY3?=
 =?gb2312?B?dFB5ZlhROFlDaWJYOXdiS0NQMnhmUzUyWFIyenRJcCtnSlNINUhXTWRSMmNn?=
 =?gb2312?B?WmFOY3hjWXJha1ZyZVRlQldEME8rYlhjeWhYcGxkQ1N0aUdJTHhlaVpiMkFl?=
 =?gb2312?B?K3pPUnRVUU9SbGZSTG92cTJqOUF2d2dBUnRqUEpFUlBGUEdIMzA2UGhyNGIr?=
 =?gb2312?B?cTVNZlJKVTYxQXFtcTBxem5FNGNFVVlId2J3cGdORUlDSytFZXBSb1FZbmlm?=
 =?gb2312?B?cVFHd3FSb0tHM0s4T1hLM1A4WkxHVUtGeG9tVWs1R0VyaGpkdm1Ia21zTmNq?=
 =?gb2312?B?dTgxdlNkYXdHU3NKK0tQMXh2dWZSeFlNWGZjWjA5RjVCYnpKQkpqSS9oY3hR?=
 =?gb2312?Q?IhCQSGDtCnp0BHvE=3D?=
Content-ID: <91EACCB30A637746B152ED190B36E001@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6134.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91cc442-b1af-4eed-d044-08da0e0ba0fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 03:00:33.3942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ns8v6hrQ3m0Sat0o+EabhU7JPuh1LrX/Wo8yM7/jMYhctcP2D1/ltJaHG3XNSIICoZXI8qI4iiJH1TSiZlNXsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5860
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/umount2: Convert to new API and use
 SAFE_ACCESS
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwNCg0KVGhhbmtzIGZvciByZXZpZXcsIEkgd2lsbCBzZW5kIHY1IGxhdGVyLg0KDQrU
2iAyMDIyLzMvMjQgMTc6MTEsIFBldHIgVm9yZWwg0LS1wDoNCj4gSGkgRGFpLA0KPg0KPiBXZSdy
ZSBuZWFybHkgdGhlcmUsIElNSE8gMiBtaW5vciBjaGFuZ2VzIGFyZSByZXF1aXJlZC4NCj4NCj4g
bml0OiB5b3UgY2FuIGhlbHAgcmV2aWV3ZXJzIHRvIGxpc3QgY2hhbmdlbG9nIGZyb20gcHJldmlv
dXMgdmVyc2lvbiAoZm9yIHlvdXINCj4gbmV4dCBwYXRjaGVzKSwgc2VlOg0KPg0KPiBodHRwczov
L3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbHRwL3BhdGNoLzIwMjIwMzI0MDIyNDU1LjI0
NTMwMC0xLXpoYW9nb25neWlAaHVhd2VpLmNvbS8NCj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJz
Lm9yZy9wcm9qZWN0L2x0cC9jb3Zlci8yMDIxMTEwMzEyMDIzMy4yMDcyOC0xLWNocnViaXNAc3Vz
ZS5jei8NCj4NCj4+IDEuIHVzZSBUU1RfRVhQX0ZBSUwgYW5kIFRTVF9FWFBfUEFTUyBtYWNybw0K
Pj4gMi4gdXNlIFNBRkUgbWFjcm8NCj4+IDMuIHNpbXBsaWZ5IHZlcmlmeSBvcGVyYXRpb25zDQo+
PiA0LiBtZXJnZSB1bW91bnQyXzAzIHRvIHVtb3VudDJfMDINCj4gdmVyeSBuaXQ6IG1vcmUgaW1w
b3J0YW50IHRoYXQgInVzZSBTQUZFIG1hY3JvIiAodGhhdCdzIG9uZSBvZiB0aGUgbWFpbiByZWFz
b25zDQo+IHdoeSB3ZSB1c2UgbmV3IEFQSSkgaXMgdG8gbWVudGlvbiB0aGUgcmVhc29uIHdoeSB0
byBtZXJnZSB0ZXN0cy4NCj4NCj4gLi4uDQo+PiArLypcDQo+PiArICogW0Rlc2NyaXB0aW9uXQ0K
Pj4gKyAqDQo+PiAgICAqICBUZXN0IGZvciBmZWF0dXJlIE1OVF9FWFBJUkUgb2YgdW1vdW50Migp
Lg0KPiBUaGlzIG11c3QgYmU6DQo+ICAgICogVGVzdCBmb3IgZmVhdHVyZSBNTlRfRVhQSVJFIG9m
IHVtb3VudDIoKS4NCj4gZXh0cmEgc3BhY2UgYWZ0ZXIgJyogJyBsZWFkcyB0ZXh0IHRvIGJlIGZv
cm1hdHRlZCBhcyA8cHJlPiBvciA8Y29kZT4uDQo+DQo+PiAtICogICJNYXJrIHRoZSBtb3VudCBw
b2ludCBhcyBleHBpcmVkLklmIGEgbW91bnQgcG9pbnQgaXMgbm90IGN1cnJlbnRseQ0KPj4gLSAq
ICAgaW4gdXNlLCB0aGVuIGFuIGluaXRpYWwgY2FsbCB0byB1bW91bnQyKCkgd2l0aCB0aGlzIGZs
YWcgZmFpbHMgd2l0aA0KPj4gLSAqICAgdGhlIGVycm9yIEVBR0FJTiwgYnV0IG1hcmtzIHRoZSBt
b3VudCBwb2ludCBhcyBleHBpcmVkLiBUaGUgbW91bnQNCj4+IC0gKiAgIHBvaW50IHJlbWFpbnMg
ZXhwaXJlZCBhcyBsb25nIGFzIGl0IGlzbid0IGFjY2Vzc2VkIGJ5IGFueSBwcm9jZXNzLg0KPj4g
LSAqICAgQSBzZWNvbmQgdW1vdW50MigpIGNhbGwgc3BlY2lmeWluZyBNTlRfRVhQSVJFIHVubW91
bnRzIGFuIGV4cGlyZWQNCj4+IC0gKiAgIG1vdW50IHBvaW50LiBUaGlzIGZsYWcgY2Fubm90IGJl
IHNwZWNpZmllZCB3aXRoIGVpdGhlciBNTlRfRk9SQ0Ugb3INCj4+IC0gKiAgIE1OVF9ERVRBQ0gu
IChmYWlscyB3aXRoIHRoZSBlcnJvciBFSU5WQUwpIg0KPj4gKyAqDQo+PiArICogLSBFSU5WQUwg
d2hlbiBmbGFnIGlzIHNwZWNpZmllZCB3aXRoIGVpdGhlciBNTlRfRk9SQ0Ugb3IgTU5UX0RFVEFD
SA0KPj4gKyAqIC0gRUFHQUlOIHdoZW4gaW5pdGlhbCBjYWxsIHRvIHVtb3VudDIoMikgd2l0aCBN
TlRfRVhQSVJFDQo+PiArICogLSBFQUdBSU4gd2hlbiB1bW91bnQyKDIpIHdpdGggTU5UX0VYUElS
RSBhZnRlciBhY2Nlc3MoMikNCj4+ICsgKiAtIHN1Y2NlZWQgd2hlbiBzZWNvbmQgY2FsbCB0byB1
bW91bnQyKDIpIHdpdGggTU5UX0VYUElSRQ0KPj4gKyAqDQo+PiArICogIFRlc3QgZm9yIGZlYXR1
cmUgVU1PVU5UX05PRk9MTE9XIG9mIHVtb3VudDIoKS4NCj4gQW5kIGhlcmUgYXMgd2VsbDoNCj4g
KiBUZXN0IGZvciBmZWF0dXJlIFVNT1VOVF9OT0ZPTExPVyBvZiB1bW91bnQyKCkuDQo+DQo+IHJ1
biBtYWtlIGluIG1ldGFkYXRhLyBhbmQgdGhlbiBjaGVjayBkb2NwYXJzZS9tZXRhZGF0YS5odG1s
DQo+IChvciBkb2NwYXJzZS9tZXRhZGF0YS5wZGYpLg0KPg0KPiAoMXN0IHRoaW5nIHRvIGNoYW5n
ZSkNCj4NCj4+ICsgKg0KPj4gKyAqIC0gRUlOVkFMIHdoZW4gdGFyZ2V0IGlzIGEgc3ltYm9saWMg
bGluaw0KPj4gKyAqIC0gc3VjY2VlZCB3aGVuIHRhcmdldCBpcyBhIG1vdW50IHBvaW50DQo+PiAg
ICAqLw0KPj4gLSNpbmNsdWRlIDxlcnJuby5oPg0KPj4gICAjaW5jbHVkZSA8c3lzL21vdW50Lmg+
DQo+PiAtDQo+PiAtI2luY2x1ZGUgInRlc3QuaCINCj4+IC0jaW5jbHVkZSAic2FmZV9tYWNyb3Mu
aCINCj4+ICAgI2luY2x1ZGUgImxhcGkvbW91bnQuaCINCj4+IC0NCj4+ICsjaW5jbHVkZSAidHN0
X3Rlc3QuaCINCj4+ICAgI2luY2x1ZGUgInVtb3VudDIuaCINCj4gdW1vdW50Mi5oIGlzIG5vdyB1
c2VkIG9ubHkgaW4gdGhpcyB0ZXN0LiBQbGVhc2UgcHV0IHRoZSBjb250ZW50IGludG8gdGhlIHRl
c3QNCj4gYW5kIGRlbGV0ZSB0aGUgZmlsZSAoMm5kIGNoYW5nZSB0byBkbykuDQo+DQo+IC4uLg0K
Pj4gK30gdGNhc2VzW10gPSB7DQo+PiArCXtNTlRQT0lOVCwgTU5UX0VYUElSRSB8IE1OVF9GT1JD
RSwgRUlOVkFMLCAwLA0KPj4gKwkJInVtb3VudDIoKSB3aXRoIE1OVF9FWFBJUkUgfCBNTlRfRk9S
Q0UgZXhwZWN0ZWQgRUlOVkFMIn0sDQo+IG5pdDogSSB3YXMgdGhpbmtpbmcgYWJvdXQgdXNpbmcg
bWFjcm8gdG8gbm90IHJlcGVhdCB0byBmbGFnIGFuZCBleHBfZXJybm8sDQo+IChzb21ldGhpbmcg
c2ltaWxhciB0byBQT0xJQ1lfREVTQ19URVhUKHgsIHkpIGluDQo+IHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvbWJpbmQvbWJpbmQwMS5jKSwgYnV0IGFzIGRlc2NyaXB0aW9uIHZhcmllcyBhIGxv
dCBpdCdzDQo+IHByb2JhYmx5IGJldHRlciB0byBrZWVwIGl0IGFzIGlzICh1bmxlc3MgeW91IHJl
cGhyYXNlIGl0KS4NCj4NCj4gLi4uDQo+DQo+PiArCXtTWU1MSU5LLCBVTU9VTlRfTk9GT0xMT1cs
IEVJTlZBTCwgMCwNCj4+ICsJCSJ1bW91bnQyKCdzeW1saW5rJywgVU1PVU5UX05PRk9MTE9XKSBl
eHBlY3RlZCBFSU5WQUwifSwNCj4gLi4uDQo+PiArCXtNTlRQT0lOVCwgVU1PVU5UX05PRk9MTE9X
LCAwLCAwLA0KPj4gKwkJInVtb3VudDIoJ21udHBvaW50JywgVU1PVU5UX05PRk9MTE9XKSBleHBl
Y3RlZCBzdWNjZXNzIn0sDQo+PiArfTsNCj4gLi4uDQo+PiArCWlmICh0Yy0+ZG9fYWNjZXNzKQ0K
Pj4gKwkJU0FGRV9BQ0NFU1MoTU5UUE9JTlQsIEZfT0spOw0KPj4gLQlpZiAoVEVTVF9FUlJOTyAh
PSB0ZXN0X2Nhc2VzW2ldLmV4cF9lcnJubykgew0KPj4gLQkJdHN0X3Jlc20oVEZBSUwgfCBUVEVS
Uk5PLCAiJXMgZmFpbGVkIHVuZXhwZWN0ZWRseSIsDQo+PiAtCQkJIHRlc3RfY2FzZXNbaV0uZGVz
Yyk7DQo+PiAtCQlyZXR1cm47DQo+PiArCWlmICh0Yy0+ZXhwX2Vycm5vKSB7DQo+PiArCQlUU1Rf
RVhQX0ZBSUwodW1vdW50Ml9yZXRyeSh0Yy0+bW50cG9pbnQsIHRjLT5mbGFnKSwgdGMtPmV4cF9l
cnJubywNCj4+ICsJCQkidW1vdW50Ml9yZXRyeSglcywgJWQpIiwgdGMtPm1udHBvaW50LCB0Yy0+
ZmxhZyk7DQo+PiArCQlpZiAoIVRTVF9QQVNTKQ0KPj4gKwkJCW1vdW50X2ZsYWcgPSAwOw0KPj4g
Kwl9IGVsc2Ugew0KPj4gKwkJVFNUX0VYUF9QQVNTKHVtb3VudDJfcmV0cnkodGMtPm1udHBvaW50
LCB0Yy0+ZmxhZyksDQo+PiArCQkJInVtb3VudDJfcmV0cnkoJXMsICVkKSIsIHRjLT5tbnRwb2lu
dCwgdGMtPmZsYWcpOw0KPj4gKwkJaWYgKFRTVF9QQVNTKQ0KPj4gKwkJCW1vdW50X2ZsYWcgPSAw
Ow0KPj4gICAJfQ0KPiBuaXQ6IHRoaXMgd291bGQgYmUgbW9yZSBjb21wYWN0Og0KPg0KPiAJaWYg
KHRjLT5leHBfZXJybm8pDQo+IAkJVFNUX0VYUF9GQUlMKHVtb3VudDJfcmV0cnkodGMtPm1udHBv
aW50LCB0Yy0+ZmxhZyksIHRjLT5leHBfZXJybm8sDQo+IAkJCSJ1bW91bnQyX3JldHJ5KCVzLCAl
ZCkiLCB0Yy0+bW50cG9pbnQsIHRjLT5mbGFnKTsNCj4gCWVsc2UNCj4gCQlUU1RfRVhQX1BBU1Mo
dW1vdW50Ml9yZXRyeSh0Yy0+bW50cG9pbnQsIHRjLT5mbGFnKSwNCj4gCQkJInVtb3VudDJfcmV0
cnkoJXMsICVkKSIsIHRjLT5tbnRwb2ludCwgdGMtPmZsYWcpOw0KPg0KPiAJaWYgKCEhdGMtPmV4
cF9lcnJubyBeICEhVFNUX1BBU1MpDQo+IAkJbW91bnRfZmxhZyA9IDA7DQo+DQo+IEtpbmQgcmVn
YXJkcywNCj4gUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
