Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BE4C10DC1
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 09:46:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D022D3CC303
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 10:46:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BF363CC241
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 10:46:44 +0100 (CET)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8927E600C77
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 10:46:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1701683200; x=1733219200;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bQD1QgZlqJ7Tn+ltKl/O85shozJrMPBtJNoUWjT3itI=;
 b=jAkPdI/fNxM8jBzzO19TLPgqeFEfLE+Zry1/KtmPQKnuW3wL6sbxYe6F
 sloZT0/QYWBPP3JCKFckVwbDzuF4M3EodNrCUFOV9tPYAK9LkBdNvyjiv
 uE5xvAqVoz6QfWkpXIa10YKB6A7dHid68PvNOf8AAWESFzo3ph/285okk
 IUaoW9+wmMC6Sme2HNjl1qB/gMpmoTHrAcYqCvEAR91lbLdqfnDJvIaBl
 3vZOmbhWheJmfJ8RKPRKF0OEd6rDtcQHEBhN1V1nLaNFP8CCtgjpEgNTM
 91bh+WVQqSYHoUDg9oEWfMsxis2VVi6G0950+uHewU7eNWV+cZOOZYDH4 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="104094247"
X-IronPort-AV: E=Sophos;i="6.04,249,1695654000"; d="scan'208";a="104094247"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 18:46:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4FzvNwnA075rBEatUV4SL0cqZyX7qDGayJ5pr7OcfnuG+U6MtY/NCchPNUoDBmmPh1It2mFml8W7sGOhsaWq212dVWsW+BHaf7YRMpqDbiMwboYUfrWpzlN66OOFJXU0OPx5EaR7gg8t8inlaol1S5SfvM/CPIup7FRWpNYqnD/oZB14armgZknnoLUOUWRQuXbnVyXDW/SxRqcwT11sR0rCjUd5O8IG7W98K7u/8Ppmsyc1+pklKTf3Z0ctoQNYw2Z+kW8J3NZJsau0qSu9yfYDNAZnQuf2LEYHg5VNf1AZZLz3jv+k7L7RnJ7TmN6J2685Ym55g7RsWQaNEHRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQD1QgZlqJ7Tn+ltKl/O85shozJrMPBtJNoUWjT3itI=;
 b=PlR6Xf3L2oiZy4dS1KVIbfeLA+79bgjYThUs/YrglcV8M5tC0AyaDLD/YZkQm2bMiC350PlrM6m0fMtlrESwXLLmTMw4B34Oh7jBl3ZwvL4zf2dZuwKMAKQrW14ODlEGWYf8bNoOnPg76NPZSPikdigGhrzco0xOX3S++oa3QKsCtvXfxe4u9ILyfsi03fQuD2ibBmLztdOkoNGmKez22EghNIvjddRtqN4UsQ7uSAG6vSJ3pmGcZwmG7huQ/ZyQgAnpFRZWPjD5wzI+Eu++Q/bK2Km9Ak0U92zXMXui2tZS3NNS0gV15guiFuNaFNq5QjRV4CurJf5EJZHwE9mLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYCPR01MB10925.jpnprd01.prod.outlook.com (2603:1096:400:3ab::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 09:46:37 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4%3]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 09:46:37 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: Kernel support has changed
Thread-Index: AQHaJpUnD628frhuaU+ccQDiFIYWHbCY3//g
Date: Mon, 4 Dec 2023 09:46:37 +0000
Message-ID: <OS7PR01MB118397B799E37E48F86A47A26FD86A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <20231204093449.GA18186@pevik>
In-Reply-To: <20231204093449.GA18186@pevik>
Accept-Language: zh-CN, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9N2IwNTBlMWUtNWZhZS00M2UyLWE4YjEtN2FmMjU1Njk2?=
 =?utf-8?B?ZmZhO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjMtMTItMDRUMDk6NDU6MTRaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYCPR01MB10925:EE_
x-ms-office365-filtering-correlation-id: 206fa3a0-9d61-4802-d4ca-08dbf4ade8b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Ayc8o9cnZ/n0zaEBwrcMnnLg27JsosG9UNTv92pAfmLxakHJgCrHJ4bNOTfZuzyUSfMTFKg4qd4yLvIFSFn970lgGvGc+ChLd68UwO/JP/AwUTP02AJRl4ji1rBcJq5o/vC/3Hk6ay3MlAfsaaqGG5yOiWTmzSWv0qcqTcvNS3ZruFlWtcEVLkiwMhpRqEhfenKkhf+Ez+3lV8LJ5JNBB4Y+9So1Jnv/SIF3WA1CCEcr+JxLrsjEPs+esIut2vV4vT5C7G1n+Q99nYahEMnuhY1m8X/5RyOyUlS/1aTmu+CEg5gUvb7joM2U3vHU7rg28EgAP/dsa4aHzK/ArFjJXu1JT9u+MZPkND6/SWWq7pHWP68tfDcbmjN8467tteXJHipWNvFd0KQXN3O6cRYyuFXgSdx3lyOT6hdqLIxm4NDMHIT9eiBlqvv747ngGAiPdVCoB07rb0j0FnHLomVn2tbc7jzcI2grkwOzZb3EljzFKbtbHIhzQOMK5YplOspYxXAHx3SXT2RVksWSlab2UkM8j1XCXPeg7Pu5uPDVFxGXq6KCnTT9MXRb4HkD96vlwODkTDzv1F3kXIBdlsf/Y3fR8I95RZkev9toI5Lf878p1gLkpgPIEWYPGKDBR19xHIlwFCOiqhlcLaxYL39BQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(186009)(1590799021)(451199024)(1800799012)(64100799003)(71200400001)(55016003)(53546011)(6506007)(7696005)(122000001)(38100700002)(64756008)(66556008)(66476007)(66446008)(76116006)(6916009)(66946007)(316002)(9686003)(26005)(3480700007)(82960400001)(478600001)(83380400001)(966005)(8676002)(4326008)(8936002)(86362001)(52536014)(5660300002)(4744005)(2906002)(4001150100001)(41300700001)(1580799018)(85182001)(38070700009)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2JqN2lXd0pyaTR6ZklQcnVyT3kvcHFGMHg3S3VCbzlNK2JFM0ZycS9PY2xU?=
 =?utf-8?B?SzNZNDN2QTVyaGNrdXJGUG1BMTg1RDZ1MHhqeUJiZ05mNUppYlZiU3oraEs3?=
 =?utf-8?B?UEN4SjV5bkJvNXZ4czdXY3g3b1JYZlJxNEJzdXJURWsraGZGbUdtVFFJU294?=
 =?utf-8?B?VWFodGV4amkxdC9kQzZGWjk4Q2ZBbVFmZXdmdTVvNmVZSjBrTHNIbzBES3k4?=
 =?utf-8?B?WnZDRGwzNEt5RkhseGFDcWorazNiLzlYRWZmK2ViS21KeVhsSlFOM0ZQdnJM?=
 =?utf-8?B?TXIyVklRdVhUbG4wcWp2T0JTYjk3aVVyN004RGdSa3FCWHYvRlZwa1laMXZk?=
 =?utf-8?B?bStFeUM2bm5Qd2J5cytkOU1nNUs3S0hCUzNORXBIb09GZmQ4SHErUG9PRW1i?=
 =?utf-8?B?WUJZT3pHSHRmdlNpQUowVXd0TnhJckNMREhmM2xtR25jb05EQzhiMGpuSmw4?=
 =?utf-8?B?Qm10Q1h5NlYxeXpjMWc4YUY4ZlhOOGhlSjROQTh6SzJZNjVoelF1L1hmQkZY?=
 =?utf-8?B?ODFrY2ZvYitvNDhCdnIwQ0JKUmlXbmxuMnBKWkdqYjQxMGV5RHpaSzBLOG9q?=
 =?utf-8?B?L2djSjJjR2J0aE05V1JjZ1c2K2t6OTRYM2xnTkx1bW1uWmQ5a0NWckg3OEF1?=
 =?utf-8?B?cFNKQmExUHgwM2tJQjJ2MHVaeUJUd3MvOVd5QWRWamFybU1JMDhuclEreE1I?=
 =?utf-8?B?STh0VGdZcWs5LzdOTFkxYXdjdjlqOVNqRTE2b3VkTDVJOHI0QnRtYUx4OXRu?=
 =?utf-8?B?ZEtBclg2Q2g1TEUzeTJKVU0wSThjRVc0ZHArYWltMks2S0J6SEhyWENCQjRv?=
 =?utf-8?B?bnFsTGJKcTl3OGJwY09EUnNZSjVJbndMNzR2OVFqWlM3NzVCdmJNemt3ODYz?=
 =?utf-8?B?cXlMNkJqdXR2Z1pXQmpqQXg4MXBPaG9wRnpYTEJrY2huUXMrVWE3aW5QOE5s?=
 =?utf-8?B?QU12K0gyQ3VpN0EwVlZ0bzE1MFR1c2VDcmZnV3h2T0ZNUllQdUR3TEtlcTNO?=
 =?utf-8?B?Q0t1Y3A3dVM5QldTVm1Na3p2RFFxcUdDeWdabUh1VWVraUx3RmJ6bCtIcUJT?=
 =?utf-8?B?NDdWSFQ2YU1MOEZVd0poUWlpTXZIa3BhZTVPZ0dTcUIwQURFMFY2OTVrdW5S?=
 =?utf-8?B?dGdHZjl1NmdMaDEyME55SG1SSjZ0VVgzR1RvNXM4eFZaeWd1RkNyaGZwaHBL?=
 =?utf-8?B?WE1tcHgxU1Brcmp5WUxZZjRYZXZaSVZ1TlZjVVNzU0k3UEtGOEhxcHkrNTE3?=
 =?utf-8?B?L29CTU5oZkwzbnpQM3N6cHV6T1FyQ1h4eDV2SEpQWXRJTlRRM1owYysvYS9R?=
 =?utf-8?B?V29WQU5EMUk2TTJYUjdYNThpU2VEOUVMN1BzRTUwRVduTWZWUzd5RDhwTTRZ?=
 =?utf-8?B?ZFIzVnlWbG5hQk9tbzZXUWM3TDhOZHBFeEpHR2VQM2pwN2Y1VEc5SE1uanlB?=
 =?utf-8?B?QVIzMGpycU9pZHdzWU1aemNHNExGZ1BMRmdvMkIzSEYwK3NQMmp3L29TZlFM?=
 =?utf-8?B?Y0p1VS9iK2ZkQ292c0VEZEdmZnowV0VtRGMwVlE1U0xrc3U5VnRQZk4zSFRs?=
 =?utf-8?B?YXRBNDJVam1EVWxDZHFraXNlaENXMW1aeWd5UkdGeE8yNHQ3azhTYWg1RmxC?=
 =?utf-8?B?V0xlcVluaXFySnVMY3gzN2pRWm5CYUt0YmxpRVdVdEtUQkEza2cyR01aU1lI?=
 =?utf-8?B?QmZaQnUvNDRZTzlsakZ5WENWbXFKM1B5ajBJVFEzekNzUFhBOWVvcjVkdU9Z?=
 =?utf-8?B?UU1EQUF0VU1weDZIdmY4TnN5MWNnY2lreGxOZllhMmJ3SDZKVlFiRENlcy9L?=
 =?utf-8?B?OWFvWEJ1TVJHdktQNXNzSjZNQUFiLzBDUHFFNjBPYmNWYmtWUXY3UEFqY1Br?=
 =?utf-8?B?YlVjRFFCb2tJQXl6YjJSNHhlWUl2RnQ0SEJmMk4wRzBxdkxjdExTZUtaZVRI?=
 =?utf-8?B?ZTNzS2JrNnpmd2JRSytDZlNrM2w5T21MR21lMmgxOWFIVGRLa2d2V2o4ZUZE?=
 =?utf-8?B?TmlFU3Y2TVIwQ2lReVVpbEM4NzJKZmQvU2tqVUZxUWFsWXBmVzg0bDQ3ejI3?=
 =?utf-8?B?OGJXWkczbnREaldDZG5ydkVqMnZpN3lDL1RiSERtRmx1Vmo2dTFVM0tpSmNm?=
 =?utf-8?Q?4souZZgZ4wH2dO3TTvtlkM17f?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qX9CeX7QgyrZjNLBShBD7Pshe5QA24wmh+VHvirDHbv2auhMPg72TdSgs+7GrZjHWTPUZXtCPz/sRuARGUAJgkmttOIPleckeOwWAyJjXANMRC4DGgKCgrF0ucAl0jieO//JqTHVXucND3Be81Lh+MMcWkn2LNAdTPXGiUGEYsE7sjJyV1Zi7dt1MQ6Ep1uVN0Eff3XX6Gsx+DR34cFnmuwdY6YKPn+MxxNVJfcWBZi7Hvq397b2nSZJtXrb+yi7J3AhmRRZk6bOFsuWf+H/4vhnAEGZ7XIpgPzaPMiTDHl4hDgImMZb542rbtKNdFC6zr+XSLZishWMjV1R9KFVuvIJB2aU5xZWc6Wz+fSvx0CTQyDb/KjkfOqPay5GUrJY0WeUcM22XJsqxrKMhDIeEwJWustA9HtxLqi6eik4HG4Q9tZTnCqK397WBKlG4HWBVCTtWO68pzpcxFQMIsikszNCkQ8Af6A2T0eGFCyA7xdSnUJP0cRtJGwcFTMpUVIQdfCplVohKjJ3Em5WoNYQU24PYIvpvqr9E4b6aADZLlE6nxxcHHu+NiCedKiKI8TnAcekY4FxPL2mG9f65sex2fLA4iadPKzZOn/LSNWuNuz7QISy++n79b+m42cJA0CQzvWTY3WTIZD6r15+gNkITywSwLfS2aXBRoUcvHsa9w+mMJkUwsSH7f6fvQ05FauNlIvkSyPmGl5a3ertAYkaadF+F5Y0icnjZ0JzIvpPcLMctshMmf3UYVseQjrvXD7hz1DyeeK/D/v/u/g4FQmZFW8KW7LfWlVSUsl4caLV4C0=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206fa3a0-9d61-4802-d4ca-08dbf4ade8b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 09:46:37.3370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hsMaYDNds4dVCX3btjlEFBArpEJDolUqci5oVZ/kwDXPrOioQVftHucDrow8fIHd0YVScQ9iHSxPOiKwtS59CAmII0jQrXK7HZfmre6Ads=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10925
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Kernel support has changed
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0cg0KDQpUaGFua3MgZm9yIHlvdXIgbWVudGlvbi4NCg0KQmVzdCBSZWdhcmRzDQpZYW5n
IFh1DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQZXRyIFZvcmVsIDxwdm9y
ZWxAc3VzZS5jej4gDQpTZW50OiBNb25kYXksIERlY2VtYmVyIDQsIDIwMjMgNTozNSBQTQ0KVG86
IFh1LCBZYW5nL+W+kCDmnaggPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQpDYzogbHRwQGxp
c3RzLmxpbnV4Lml0DQpTdWJqZWN0OiBLZXJuZWwgc3VwcG9ydCBoYXMgY2hhbmdlZA0KDQpIaSBZ
YW5nIFh1LA0KDQpMb29raW5nIGludG8geW91ciBjb21taXQ6DQoNCmNvbW1pdCBjM2U5MGFlOTc5
NGZlZmE1ZGFlZGYzZDM5Njk3ZjljNDk4NTQ3MWJjDQpBdXRob3I6IFlhbmcgWHUgPHh1eWFuZzIw
MTguanlAZnVqaXRzdS5jb20+DQpEYXRlOiAgIDIwMjMtMTEtMzAgMjE6MTU6MDQgLTA1MDANCg0K
ICAgIHN3YXBvbi9zd2Fwb25vZmYuaDogUmVtb3ZlIG9sZCBrZXJuZWwgdmVyc2lvbiBzd2l0Y2gN
Cg0KICAgIFNpbmNlIHRoZSBvbGRlc3Qgc3VwcG9ydCBrZXJuZWwgdmVyc2lvbiBpcyAzLjEwLCB3
ZSBjYW4NCiAgICByZW1vdmUgdGhlc2Ugc3dpdGNoIGRpcmVjdGx5Lg0KDQogICAgU2lnbmVkLW9m
Zi1ieTogWWFuZyBYdSA8eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4NCg0KPT4gRllJIHRoZSBv
bGRlc3Qga2VybmVsIGhhcyByZWNlbnRseSBjaGFuZ2VkIHRvIDQuNC4NCg0KaHR0cHM6Ly9naXRo
dWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvd2lraS9TdXBwb3J0ZWQta2VybmVsLC1saWJj
LC10b29sY2hhaW4tdmVyc2lvbnMNCg0KS2luZCByZWdhcmRzLA0KUGV0cg0KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
