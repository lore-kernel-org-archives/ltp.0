Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F87FC4332F
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 05:03:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 094563C1BEA
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 06:03:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9A2A3C1BEA
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 06:03:33 +0100 (CET)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AB23114001EB
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 06:03:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1672808613; x=1704344613;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=9KXU2b6tqgcNTOFYH1oyxO61yyc6Zhst6rWhyuS+O2E=;
 b=o3/RMngdWfD0XxA0z7ZKMX/DKQR8K/6+20LhnCmb3AbsKAUDAthaognH
 XC7k7mJf3rttdu5/P8KdUK61CAZLetu0bhEEDcliEaEYHkb1JMCAkCDI0
 RBA/+Iiqfd33GQ8q1+UNyxRTiWtVdrmfBjGDnMQjobga62oIGReAR0kyR
 RlzDp3K277K0MHsKyEJ0YlUAY7ax/w7L7Zfol1g0vtjWEAxYBbibkqeJi
 KBOU4wP2sVcJSnkx9ecEHl9kt4mHAZ0nRlookKEUO+MkSkQ45HZ8XeonT
 kDgPPIFO8otx3pBbfsAoIEnVXPyliOeant9UGtmsYh0pvNYb/Smk31mBB g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="81573762"
X-IronPort-AV: E=Sophos;i="5.96,297,1665414000"; d="scan'208";a="81573762"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2023 14:03:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAOdKCeozO7gjx5X0lxO2doUWr/pZ8fPub8plGHKxVLdyDngFh4GkQw9JCgnpOzta62nkGLuJlyr35+GVpf9sCBBPGB6YXWyw29Nw6+mVWzzovFusIFccPOykLRAW+OFov+UAmqu05uMVnVoei6Cn3txX+glAWeAHUJhmY9CKDB2Wn35Yi1awD4o+hrCYoOeAcG2O+krHQ1eBeOBsipUsv+SikuHE9XHHLkJk6Vm/d8550xNCYhsxAhQIFOcwxSTi6t3vDTQD8KRbU2IpEntauEmP5qK2Kp3BK2eeL3RigYhw3ORtSkkMemWOvItQIPAhI52ltZdaQAsOIdcZ5t/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KXU2b6tqgcNTOFYH1oyxO61yyc6Zhst6rWhyuS+O2E=;
 b=WpBEc+fKwQs/5DvnzcCgZ2ZpYDHhYQ/nJQsAGy9rqj/w38fWQKceakVHSOQE50obQs4vdQyL3Vem5hXZ6dMDA+0r32ZfGHZ8t/+RlHyDLl/f74aBQj699TH1VrlrCWgs1DOHCnjs7gj0pCD+yt4whpTHKsMnN8incIsXw6IuuWtJ+MNBR5WA2LTmAySwj0+pUyDUF8dQGhT928cnHsobK478Kd2+nLuZsTemw1AzgQ7rfy3iPAvFFuLs0q1NfU3CaKJzxQwVefKDY1sDYtZbSOaHVMzAc5OrTw4di/QP1S+EOYwkCL31mrP0Ca1ml+7o/NsEAxD/GF17GkxJVTQhPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYWPR01MB9987.jpnprd01.prod.outlook.com (2603:1096:400:1e3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 05:03:27 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 05:03:27 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH 0/3] doc: tst_kvercmp2 related fixes
Thread-Index: AQHZH5v1gzRjAhAua0SHXqriBHoVla6NxYmA
Date: Wed, 4 Jan 2023 05:03:27 +0000
Message-ID: <b60b9597-ebe9-ee82-122a-92582ccc3024@fujitsu.com>
References: <20230103175059.16328-1-pvorel@suse.cz>
In-Reply-To: <20230103175059.16328-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYWPR01MB9987:EE_
x-ms-office365-filtering-correlation-id: 00400df4-e292-4f00-9268-08daee110421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s8WbjNpDEsUN+axxRjdUflPLR+G+eBnEZxnqHvNskKo/NPet2/V6bgYZhhxrTpLdqiD23mN9Oqcod/uGO7ZejB1OtG//cl8El9NGNUZS3KkroP+6EGMXsvFVBkzsKbjBLdvyWJKjqd38fcf28/cvoVcu8LZxJxV7njMrmvKcZ6ahHzTLjh5HYZySRAJRyoowcnh0qmM0pA3h7Z1YZCqukLamqnp1Kp5v+b0CBef3pQ9lge/Zvc6yWNVvRGiMKu+mLdDNjf7rZfo2eIVfl9hh+UcFOQ+whFaXN+tSZL3H+Leiz2jm0fKf7/dVVVVvQ42Etc+D+aW9KWVRnGDUTptnONUL14/IDoM+Bi/PccvQar/eSC8a7S8O5qdtcU/bPunyhFxcNbqS2zYEpJb2+LPyPKQPyclnIgtQZ1xsMmmw3lk/2A3Ot+G1ZTdcGtvL8q8meoj1v8BXBb/fV2g2AK35TqG9bOqTm4EU847iM9SHntkgFTYAFsDu9DP70kmg1uxHGfV33E4bwZb1s2o3HI6iqONUrABS7sgFHzA37HIrUkM62UK516opmaEkCbViSRvXb2JsnWE/A6M/Ize2RBlCOfg+mNq+145oObxaDDKmivdwoobwzUlzxsPaToRfos7ZOpW31RyOf8tMl3kQ76Qe93VjmYbbTgvvLDGjYQapiiQyEx+TlEA3wp4hTcwE+EGGShnD7jLqLOfvl4IaCDpO/FvpZmwYeezN9mncWHbXJaGZEYlz/8D4a9azkhdISeU1ZF3qzByPiDF4ZYkahHLUIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(1590799012)(451199015)(83380400001)(2616005)(6512007)(186003)(26005)(6506007)(31696002)(86362001)(38070700005)(85182001)(36756003)(82960400001)(122000001)(38100700002)(41300700001)(8676002)(5660300002)(2906002)(4744005)(8936002)(6486002)(1580799009)(316002)(66556008)(478600001)(71200400001)(31686004)(76116006)(66946007)(66476007)(110136005)(91956017)(64756008)(66446008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEpWQ1NBSUdCcndnWXF6d1F0ZmRDaWNZTWNLMDJsNENMaldVZ3g4WVBHRUxs?=
 =?utf-8?B?ZjB2cVdscDJOUy9lRzlPVW1PN1BTWElqQmI3aERUV1pqZUh3SE5aNHdVTWxi?=
 =?utf-8?B?Nkx2dDZjUHV0a2dvSUh2MGZvanZQakx2TVFoNXFmRytnMGQ1SlFYMHZhWnR6?=
 =?utf-8?B?T2VxZG5WT21OTngwSGxnK3RrYXRpbFFyTGxxVkdkRmZId00wdXRyY25DM3hY?=
 =?utf-8?B?bERRRm9IS0FLRjJGamR6alFHd21pdzhLTEt3dmdtZFVpTTBBVWE0SkZhYlkw?=
 =?utf-8?B?aGg2SzhoK3YrZ3dLRkVDczA0Rm5yeW9mTnBYbnluejZQNlM0VUd1bFlBWXM4?=
 =?utf-8?B?STZOMThNaCt1bitlQW5McTlJY3RPYjBOOVpvbDRaTzlheXZibmt5WDl5SXFF?=
 =?utf-8?B?WWhHYit5aUpncE1YS05hTHFTMmcyUEFZUlZjNGp0eHNWbWRRSzFTREVlc0Mr?=
 =?utf-8?B?V1lSRUN5N0s5YkdLUHpOOVNtVzZ6U0N5MzB0bCtXSkZQai9EQ2VoMW45OGNK?=
 =?utf-8?B?dEJoK3dYME1PVElYUDl3eDJYVllqNHFzY0lDUHZkTDd1SWxCNSt6emVoK1E3?=
 =?utf-8?B?YVFOYzFQM2M3QjNkZGRWeFp3MUp2c0MvMkJXUXRseGRkM1FlOFVWeDFsTzgw?=
 =?utf-8?B?RGdCbTBzb3FOMWJnekFtVERmZ1RQUUFJSGptMUZKSmYyTHNKVFNqRE1iZmZQ?=
 =?utf-8?B?WGNYQnJYbWUyMEkvSmVSYzU3VmRBMGJOU2Z3MGQxZGhlb3FLTHZITXR2aTdN?=
 =?utf-8?B?Y01IeHJmK3dTQ3lUcG1kcHlUQzhYd2Y1ZHBxS2d2NmtwM1N0L2svUWlUQWtY?=
 =?utf-8?B?RjhHNWhFNjdTRXh4VGphcWQzSWMzTkF5ejB2a1A0VUhkUzdobEJnbUhtbTlP?=
 =?utf-8?B?R2FaeEdqeXpFYTNpeWdVenJySG1aYnNseG5pZHQvdkdLME1zVTBTTVA3aHlr?=
 =?utf-8?B?SlhYb0UxZjZMaGRENWprd2toWkVRc3p5ejZrcVQrVFBkU3o3Wnplcm82TUE0?=
 =?utf-8?B?R21hbnpPRUNRbXR0OTdrTFJXSzlrYXIvOVV2bHpyREVoVk03ZEkyKzZJbnJV?=
 =?utf-8?B?eEJVNEZZWllBaXlwc1FIZXRkN1MydnpnNXVTRWJvK2tyaGFaU3MyR0hVWjNT?=
 =?utf-8?B?MUdUZWVBbWFiNHdXdTNqZ1NZakdmcXk2aWlaUnBxVGQ3bWxVbGc2V0I1clZ1?=
 =?utf-8?B?MzhSRzZjeFA2TEN4RlNiMmo1dHlWc2k4Zm0yd00ydXBCbmxmTnVzSXJScDJI?=
 =?utf-8?B?azNJOTFTR1BqdGFmVW5BR0ZrVVhWWlRMY3VaZnpXakRONzlTeTlQTUpSNzBp?=
 =?utf-8?B?dm9WdlJBM09DdHBCdkxYVm8rcm9XdWdQWkVkT0lFTVZYZVdJTFc3YTIxb2lv?=
 =?utf-8?B?Vm8zZnU4aWdPd2RyankxRlE2S3ZZaVJ2d0VwOWF4UXh2OXRhTHdJREZWRzNG?=
 =?utf-8?B?RXg1ZzcyQmdVZUU3eXlhZStIUU1mZ0Z1QTR4Ymwwdm43WkFHM2U1MzdscTZs?=
 =?utf-8?B?SWtKa2x5ZmswOWxIZUJPUTBYVk85WVg3eldWNjBsN1NSbXc5Rko3STB3YVJQ?=
 =?utf-8?B?ZzBDWWZkanJlTUU5NFhodnpVWlFvWU5zYnN0V3cwZ3RuL2xZRUJiK085TzlY?=
 =?utf-8?B?NWUyVzJOTWdLb0VxK1hSMHpBWUlFcFc1MEZLcGd3dWllRkNCS1NQQWFoZFNr?=
 =?utf-8?B?bFlTa3NWWjRpSlR1dHF0NU02ZHlTbFQ4Sm5MdGZ5VmJ6TUk1cVBhU0lJVWh2?=
 =?utf-8?B?U1F0ZnVvODFxZmpSZzZnTnYxRkpGRE1XV05LaXpLQ3Q0NGo4c2k1UHJqU041?=
 =?utf-8?B?aXhJUzhhbFNHWUxxaG1XS1Y0c1BBUTVWOE5IZ1cwUkZGUHhRaHh3ZUgyZ0dO?=
 =?utf-8?B?WWJheGdMWkV4OUQvdXRmTmNNR0x1TnRMQVYybVF0ckpTRFgvajVUUFNjZVlk?=
 =?utf-8?B?c2hpNFBXNG5MWW9OOVd4VUhWbTUwVnp6bzJqK2tFN3g1eFBxVjFxRU10ZnNa?=
 =?utf-8?B?bUxxNkpNOEl6TmpBaHVRWGErZ2NYcGcrblcvUWx2M1FmMzBFOHpSR2xKOEVk?=
 =?utf-8?B?MEpROHF0VkgwSFd3R0Y2UGVFTXF2NEF6U0ZZbkNNWWVucnZyOVBpTk9GR0U3?=
 =?utf-8?B?K3k5c3kxNWp3a2Vuenh1bUFTTlNUVW1iOWFLbmFIL0NVWXJka0ZVWlZWYW9n?=
 =?utf-8?B?U3c9PQ==?=
Content-ID: <F47B6A35E92A7E40B05FBAED6D6DFD95@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lh9SCdQoKEd1VBeKM5O2kL2jevpSLVs5gHOOK3qHWigwi266uEWdTLv6lL5K8e2RAg3Vp5nnLS25Mnd3cH8SwPo5QAaIfa3QLFPH0ibQbOqfXMC5PonUdSyg1rOHH0XxwdcL5IrqeUUbp7bwmDGZ2ARCq2jvVV1WqpU//yDt/3R0cKs9y9SuXcU/rQ7xBq2Ox5yTXCRMQkZhghbU02z6aIgp79nrPRL4nVtAJ6vVOJb7N7/+KoH/JPYxYzpPxFeyaIEyiWyFg1HS85xlqjldOkbBgPwDgVhixsJKr7nRLtpxiUi3avEXi3paefhPPQUY+ffpox9URZy5zLTShOSfI4yGRmM86vC6qSzHLdGWtzN2fc5CdUdx9KPg26stQ2zZk+4uXqVXU2cpVMatgD4A+7ou2wHhsS+C8dl4Ju/2k8sYAVYzfhXLmhGsxPkAG7gz3mwlCDyGJ7U49KgHHPH883lIYCFM7N8MLaLzSm6b/LscWhKhN/w3Vt80PeRIOJ1LOef25Kd9pl33JdNiEfbxsnMM6IrINdI/kuoe3E+exiFBXyAa2OS9KEV53jmcakUwyOid5+9il0szP/ywfZGWDA3ZftKNe+jYSWwvIptakZfhF8eQh+8kXNuL67+xaIEweJCdWH5TcIBrA/bBvnX0u/1REptdj1TYB7xxpuRFDe2M6WG6D3rLGkS2BpBSvTIukS3wr49lUpnOhnzybV04l1kkdjrnKCnTFJ+p+nmE8h9HO44SsGKW/6ztUlM4egwGWuExIXbCmwytC80UNk52+EHUDB5Zag0WgZidhZ5uw1I=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00400df4-e292-4f00-9268-08daee110421
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 05:03:27.7197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWMP3JQjyiWCkOm/u/ernpAvzIA+pm8FNaKA5e99mYq+LOMlpBeaqbRC21VGeck4DyNgNzgh+86lEcEv8I7ML1aeKKRHGpg/Kj9Jue4U+gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9987
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] doc: tst_kvercmp2 related fixes
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

For this patchset, you can add

Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu

> Petr Vorel (3):
>    doc/c-test-api.txt: Update tst_kvercmp{2,}() use
>    doc/shell-test-api.txt: Improve tst_kvcmp doc
>    doc/API: Link to minimal supported kernel version
> 
>   doc/c-test-api.txt     | 20 ++++++++++++++++++--
>   doc/shell-test-api.txt | 13 +++++++++++++
>   2 files changed, 31 insertions(+), 2 deletions(-)
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
