Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB892C25B0E
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 02:23:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E2AA3C9808
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 04:23:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFC8E3C91D2
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 04:23:35 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D47521A00641
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 04:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660703016; x=1692239016;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=B4iUZuX9g0P88zq9kqRp7yTAyW6MVFnGpbzlvzc/B1c=;
 b=mFlNDbuPqAHC8I4oaWITcdO/NeM49m1VH3KjmdDG5ZrxbiAY/Amw9uMe
 N/5dK+jN6ktD1Q44ZFGD/b1J6IaRPdp10Q2Xd7NlAkS8f4b3hZ80bdLWe
 kyh2SyuGxRif0JvvqRb86RjWNr5BcNjLR24RopDqPxB1iMyqHEpr4eFVY
 GyzwDmBpEI45mw0LlzkNcniqGaeOWyhsNGPN5tmm3904YipoBXBV9dfIr
 kW7ZqxIPR2Otcs1zPhFtD7MotabCba2bBH8UtObgaxwl10La+/8nsmi7p
 EG9VilxNHpMsHwp/m5gjRpAr3EIqOhNCG7KWX77BiBRXpz1gGRFfTg4Jn A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="62775918"
X-IronPort-AV: E=Sophos;i="5.93,242,1654527600"; d="scan'208";a="62775918"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2022 11:23:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVUVD0PumwBMLFsnc5zA6FNAne0+dmt2yjp8uR2dil4L77VCaCzqNQ0usJsPC5h447xxqUFyidg5mxtPtDIE9oMY/3J6hQQHUxP35z0UkEuiTezEF472hVaofcwiunxcGThv60K3uMum5Kk2Ys6ws6btzrLsgygiE9VvNuGXtmEESFCyh2yQigF38yWjyefzG6eQB6tG4UFGdEOyZuMweNlGyWHYcQSiGuBgLQCaf1kYqiGoLZMCs3gqQjYMzEkAsaQjAbtvAEViWijxSbmH1EX3TP9ZH7AjlDjlpF3RwKz2j6o6pbY34o2ItxtIfO7WNy+UeHIeiKLLBkvNZQcsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4iUZuX9g0P88zq9kqRp7yTAyW6MVFnGpbzlvzc/B1c=;
 b=oKleHxswITpZh0292zLb7vqbEnB0PwYhpvNIvHbq0A6UGOpp1o4aynq3UuMAJqKGlT5CCPRaUJeMbYEusig7nqdD4p6Xo8l1wErhiAcixavQ1yQY80RDPFo9+p7hAYQLL9nUDiDI4jlg9EuilqBXbnnSmonViAVfH+P2g04icJwzxIe02yvroCeRuhxXH1YzXvi7bCwGxZQlAeFuVikx5aiZFVqKnWoy2oC4JSoWX0nusLmx1rm/Ka2eQ/3LPAdoHMnViUyTVSWr5tCncHbPB7iVfED1TIn1TbZAmltdk41QrVI5yd/kVthkNzSPTGaijkkmORFFtCALycXKCCHryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB5075.jpnprd01.prod.outlook.com (2603:1096:604:6e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 02:23:28 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Wed, 17 Aug 2022
 02:23:28 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v3 0/2] mount03: Convert to new API
Thread-Index: AQHYrYpdivkAy4rXlU+UH1tz7IrvUK2vgeuAgAAG24CAABXngIAACF8AgAApqACAADhFAIAA8NUAgAB3tgCAABPsAIAA8SYA
Date: Wed, 17 Aug 2022 02:23:27 +0000
Message-ID: <f929bae9-dc39-c793-1ea7-bc95f86d48ef@fujitsu.com>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com> <YvnqZfyByO42kAX9@pevik>
 <1e791bd1-2661-95b0-1f0b-e3ca82b6524f@fujitsu.com> <YvoDyrIGa3/BsqI3@pevik>
 <f11fc30d-d875-0d60-6807-7bfa9998f21b@fujitsu.com> <YvpV8Iz+zVAhwvRv@pevik>
 <f7c6df02-3c39-ead8-2bbd-8cc26d36ff7f@fujitsu.com> <YvuEYiIq23D6/zw6@pevik>
 <YvuVGOql4gIG4yju@pevik>
In-Reply-To: <YvuVGOql4gIG4yju@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fabfce80-3534-4d4f-9133-08da7ff77874
x-ms-traffictypediagnostic: OSAPR01MB5075:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 09Xf1ybL2zmUo/pskInE2SUJ7FuyHs6pD/os/JwkI5I21tP8fOWtcx3Q621C/W7i9wyezksSwhfG2Q8RCjPv7D1UykgJY8Ke/ZOx7NJjq1ec5OAYeU+4A3O/bXlMOIFH/BTce70sLmInOsG9/5JZ/+C3cVOwbaKrq7jIVKGJukzWOVCK9xk2WCYkH+xorlKXbiQIE/Ov9IjTIuIGyy5ClRpms83Mv5XnzYUZyuFkDPE0GiZatkG9IVNjVXT+A2ShIOY5pCZabatGU4mfMvsEWPlA53V/K0IlyqfbEtcP/9zpVeu6fTKRLJnQoD7w5qkMhMSUYbURddsQGGkDXE8qH3oc69CVhfzbm/kq3kmed96W380jRxnhwh54vCSG3tq/93Zq/XPEyTeAfzlRo/RcM/a8t02XXCZj8S4VC2heWAgV6Cwy7kbm9VXRSQzrAnpyfVF50iTjZaCZv1gsb13ED997qEqpg16FAD7S9Ialid7Ui73Rc1KvcuYAqSOFBqt2utPe4N0y+gdIK6oB0X0B/tNFA6s+xaq2oI70krZ/Wiz0Yrwn/PI2WkWVhv2ET+XfZ+3oEyj5DpqHQQo4T62OeuDEXbCo1jRLc0LSata5Fu1A3Sm/wIs/ec+a9XJ2D6DfPQQfILO6BrNdyvKSwJu9FInwckM4D21jp+sWpHf1fVNOWXT0LTljx2hgfVszeTj14+CMPwHIJGfbMgGbFfCYJJfzXRALPIiiN3B4pRi/C1PB/RE6yhpI2aNwKZFhUZTSvTs1CXQS57ZsUBu2x98g+OKp4FQ38mRMF+39QdgvH2lgsm5RBBHgM2spJ225oxCVD2NREw68/7tCDGoYdpWld+cO9s4ks3Rfla5KHgUzgBHC9HBi0jw8Dzkqe030+eVfGvoybykucO12nnjHw0kLGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(71200400001)(966005)(41300700001)(4744005)(316002)(478600001)(1580799003)(38100700002)(6486002)(110136005)(66946007)(5660300002)(8676002)(66446008)(66476007)(8936002)(66556008)(76116006)(64756008)(91956017)(26005)(2906002)(38070700005)(85182001)(31696002)(36756003)(31686004)(122000001)(186003)(86362001)(6506007)(82960400001)(2616005)(6512007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dG5IbVc2R1BvekNSQ3dQMytaZDgyK1grcEN6ZlNBdkJVb3dRUUtIdWJxNTBk?=
 =?utf-8?B?dzFSdnUxeWVJTEJkUmN5K1hPQktURm96YmpqMjhMbWhVVUNnMkNaSWRmenhl?=
 =?utf-8?B?bUR6amlLWXZlOHpyTVROZU1IbVFJNGJHL2xGam81cktzWlpvRGZLSFZXL2hJ?=
 =?utf-8?B?ZmJOMFEzdjdadEhWdTE2Q0gzMnhseGJFWFBqUVhzS2loa1VyVWZVSjRyMG5t?=
 =?utf-8?B?RTJaSlozcW1helljanFYSGxVM2o3ZnhVWG1tZDNyNGhNdGlJRlZTZmxTMk81?=
 =?utf-8?B?bkpSMllXRGtWK1VoenJMeW5yWXl4NmtVL1JvYUc0TEM2MWRkNjNyME81em1q?=
 =?utf-8?B?VFRtUTl5bWZ6YWxCYmdCTWdtc0trSW1YZStFSE9menFaYWhFYVQ3dXhsWjRO?=
 =?utf-8?B?c3RoWWRCTHBSZGluWm90L1ZlMzhRVVJha3hWbndRRGdaZFhxYjgySDRRU1A4?=
 =?utf-8?B?bDdQdDdMcCs2MTVrNDBwK0RQSGUvYW5mS2pBeDJCTkViUDg4UDAvMGRQb2xh?=
 =?utf-8?B?ckRMbHVMRHdDOU04RU05KzkvLytnQnprdWE0SUFTRjFvNFBSa0tTVjBOb3Y2?=
 =?utf-8?B?cUlNb2lJci81c2kycmFBc3lIK3Q3NjZScTdGeDBnem1MRnE4NlM4NDhIeGov?=
 =?utf-8?B?bHZhNHZ5SWlybDIxa1IyMmN2TVlmbjc4dTNnNmJvUnZqU3Y5NksvdDNKMWJB?=
 =?utf-8?B?MGNWMTdNWjcySGFMR3A5QnZtZHhuY3M4WmRjWkNrck9hOC9IQWY5Z3BXbGdl?=
 =?utf-8?B?dEtuYmFEbnhaaE4vRFpyc0JrTk10NmRYc2I3RFhkdWF4UC9iSi92NDhQRWFQ?=
 =?utf-8?B?SnpWRXk4Y0ZoM1VLMS83NXdLODgxMS8ycWtvN0ZrUE9vTlFYeFJkY2U2NHdt?=
 =?utf-8?B?ZkJSc1d4RDM0YVAyS1R5aVVLS3hsYUMweWtKNWJGd1l0THlwR2xiVEtiOUlZ?=
 =?utf-8?B?a1RWSVFsU2FQeGR3WVMrdFpzRDh5ZklFNy9HMkdiQmpUR0VLa1JSN1pIRkpY?=
 =?utf-8?B?SWllR2ZzT01yd0ZiempwTWtPU3NINFRRUDNmL0FGZ2ZaZEd0VlJCYVdGL3Vu?=
 =?utf-8?B?UzhkSDFsa20va3FnWXRRQ2xocjN0VThZYWVHVXcyQitqenhVN2xVeWdiUERa?=
 =?utf-8?B?SkdTOVAvNS80ckRETjV1d010WnJKM1VmTm9oODN6RU5hQi9KUlhhemMzY0tn?=
 =?utf-8?B?c25RSTNOYXBMNlZIVFFMdE51NWRBYXZSU0FBNjNoV0t3MFBzQ3N5T1Riblhm?=
 =?utf-8?B?NEtKRFRaRFBaTkpHSHlySCt4aTkzRGllMUthU2d5bEErVHAxclJyTGZwalhD?=
 =?utf-8?B?b1IzQ3QzbEJqdk4wR2RtakV3K0hyRDlFVEFWdHIwVTRETkY0VnplWHlqa1Vy?=
 =?utf-8?B?a0taRlVIL2JiZDhkSkhwOFJ0dHZ0WTBUdDN3bEIxS0hpd01ZSW5qKzlsOU1i?=
 =?utf-8?B?aTYyZHE1VVJwRmROamdSMmpzSU9CSEtXYk9kazFqWHY2N1VRUzk0SXZEOG1J?=
 =?utf-8?B?VW1Famx6bnE2ZEhUQ0k1Y3NXTmd6OXdMeTJFMUhJNXp3c1pRU3R6SWhGblVq?=
 =?utf-8?B?eXAvYzNJK2dsa1FYUXF0MExmQk9jb1N3VkFVUGppVHZvSHNldFBJWkJnVWx2?=
 =?utf-8?B?ajNEZXdLd3hzT3dra0ZEeklFOVUzOCsxU1NWTlI2ckZXQ1RTQWdIMHdDREJo?=
 =?utf-8?B?SnBPUU00aW5mRUZodXNEZ3BLSW5UQkw1RmJBY1FpM3VNa0RBL2JpWnVOWjA2?=
 =?utf-8?B?bE8xaHZCendxYm9sZ0lCaWVRQ0hPMWZTRU1MNzY2SGwyUTlUdCtvOWQxMExM?=
 =?utf-8?B?cTBucXNadzg2ZkNGS1NJMitGQzAxR21GWDlaSVpQbzFRSW5zTWE3RGw3WEp5?=
 =?utf-8?B?dllidjlNaThRVHl3alhBcE9xVzBwTlhISlRGZVEwcUxKRkg2VnhDN0hSUGgx?=
 =?utf-8?B?aWc3ejllN1ppc2pCeS8rOTRvUStnWHRhK3NOMG1XU1BLamRseDdTRVZ5bTcv?=
 =?utf-8?B?eE0yeHNMMVE0aWNMQnQrQ1YxNnpPa3p5dzFzNDM5b0FsRHh4Q1UyaVJJK1pr?=
 =?utf-8?B?VHBRVjNKTnNtem1KamdsR0F3ekZlV2drVWFZaUdIT3AvaGtIL1haUnR3Ykpr?=
 =?utf-8?B?S1pTcTlIempvbWYyWlRLbzNXd1Y4T1lKa0Y1aSs0bFBSMHVKbzVudjU0ZVVV?=
 =?utf-8?B?ZUE9PQ==?=
Content-ID: <EE93C59A8C4E9143AEFFF833E200400D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1mN3vpMQUflhCSUPHhx3V4yc+tfldcyxenZuLe2jmYx1PWLCztUZD54zUYsaoCz1OY2nvqRv42Nc0KDCXoD9FB8oKgCMGM4enuR495Q78Pa/g2kRVO8j25RF12sKXEzBQmOn7kPDq4Dz0Le/gITGPkqsZOb1fVfK9kDRel4V8hMQ1VB+KXoNGF9Ndt3LH1cJO5QwlhOQ2EpASIPPp0HRM0SpxxejlxJm9QaXrxF6b5lkkt8ttZAiQ34YpyN5G16bsCN0y03XX3XhcmGtreLk4E8jOzH7UVmmbAZMQQbikfECi2UGIwGPAZlhFhU0FijGIg6pklOBW7oCXquyIMhObsXgxQ1zsh0luanEZqeO2cvz/DoefqqY0NrtPfz1ZBGqAbanKRbOuLLVct/tPg8FmgyDfhdrwrUvoAfmWQ18YslQBx5TisNnA66OS5AejS0TqO10cgQZD0L0vQZRkehoagexhVYy3BL3N4ZJPeZmVqXzcpa64CAx59K8VhlFeuA++Au/yg9GDg3eRi+3jImSk73qpkCwxvZ6Qz61/wsAFbxvHiEUh9w90on0YJdcRlR1nP/wBqGRqvYDm2Uhgb+VdtDHmqF2mJaAukZYdaAChmvZs2JH6ULvVM+bQ800aEeVeFebLxG+YsRJ9p1rSE9bAmSybzPufNbNoTRWyOjkuTT4yE8BaobCgg+5fNGAnwxtkrOiODJYgZizXuy6uqkjrR5TpVU8E5cJrA+QI7aiwI8HqUwQzsqdwvGLXn/vguH3w9dsrbhcrZuwGof5gM7GtDXiLVlpT6Be1CDAjKKTHPw=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabfce80-3534-4d4f-9133-08da7ff77874
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 02:23:28.0276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Sd54//AgW+KfcD3Z5Cr9BSrg/zaGBN7Rc8Oz+jzH/f+9XeOMN6Va/W7aGbxqW8cgDEotHgv1MPrhonZ3CtOJAqXyThGZZhhYEcgqAG7NpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5075
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hi Petr

> Hi Xu,
> 
>> ...
>>>> +++ testcases/kernel/syscalls/mount/mount03.c
>> ...
>>>>    #define FILE_MODE	0644
>>>>    #define SUID_MODE	0511
>> Good catch, SUID_MODE must be 04511.
> 
> BTW reading https://lore.kernel.org/ltp/e043db5b-91cd-3e26-d6cd-32189c91518c@fujitsu.com/
> do you suggest to use
> #define SUID_MODE	0511 | S_ISUID
> 
> instead of this?
> #define SUID_MODE	04511

Yes,

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
