Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E1BC433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 08:16:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 458593C909D
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 09:16:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 106A93C0596
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 09:16:39 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D157F200BDC
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 09:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641456999; x=1672992999;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=BtwnOIChO4f0Y4q5kJAhDmAcBxQAQjmFtPJWgImWPqU=;
 b=G4XZLqn6eGEHUrpdT+BHfYVWnfqYZWbipXdO4S3z7H5omLGAavpgOGRG
 ZauR6wN/8A72vS2MlDyftWc9se3GrwteptbdsWmmKITNHCn/Up4gCy7Rb
 Axioi4RQJopEH09ZGIUPlElDcr21Sknh5jWEYQU6/Vp8FEDRhiJzjxNBp
 PY1nxnmbjIDWwQNuggqiRq2w2e2VbC9IcUpj0p9FcQNK2qoQmu15B0G2g
 M2fXNxEL7KbitE0DoQqtgP+3ASmcNO8o2uRXaXvsvhc/gi0KPf7MoUGh6
 vIJhVFGaPf3eyCes2YV0Y4FdIEuNJWMXvIJ2hBVu3izJp8UedegS717MJ Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="47114922"
X-IronPort-AV: E=Sophos;i="5.88,266,1635174000"; d="scan'208";a="47114922"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2022 17:16:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd5UU47kjLCUVUUBoaLvicLgarQqEuQ7sTIcs6buyCT6e01/5zHWUhdgZ8Pj51PDOLpZ7bB8z4fjwETB0IoVd6MGnNYwLAtynknI5Z8mVciNxmnl6nM6XGZNR4wsGdj6jxiMMXMB/a4B0x4DSOeODNWC+/dcFExfgtU3nk/oZMlv9OudW+hgNvJ3gClMOeHaTdZBdlc8EZxv4vVwVhkHNSyWFg9fyO3kZEEijXPFW24NGV+dmf8FfiEomSnrwqcJkxSiqVjrAvfpOJ99ssnwSSzunLyS1/P+IiCpYhoygcp2AGQNB7Jx1Lrn8+oRPgzhDZKHydzsZmUglKrOcU1ldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtwnOIChO4f0Y4q5kJAhDmAcBxQAQjmFtPJWgImWPqU=;
 b=dz9QahYLMpAGsG2Zcd+X2J/yXfvzwM0nfmX5ToKAXKuu4+WDyRUXlWTVEiXX5pFng3IsU/z1QkLWimQ68Fi8fYL3s6xF9R6tnf7qaxlXroWljVuG7tKC8hy6O+Vz/6m/f4GTETGaT4pO7gjCjPmCZrH/XM1mmvnUAxTKmwyeBXIMrcKcQHd9F4aBj6jr6ZybyvXYoFNzSGhJ8+/gIRCS4KJDpaNLxPaCQSUDKlOywV8AewfEUl+mClgudcUlyII5OlnkoI+93mm5Hd2hh2S8+014vSGLwY5h4/tqUrW4C2DsjgoHirgtYb2gLNP7yWwa1PEtZCixbyvvE4eil48vng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtwnOIChO4f0Y4q5kJAhDmAcBxQAQjmFtPJWgImWPqU=;
 b=PbQ+vgWGDC07Vj6s2pkT2ibn1tYt3NW/cer4Au2I9ge9vO/jCtO1gcIE9iEqe1IV5paqhfZJUUZOv+c1smmAF+Tf0i+EmGTxElKnsQ5oLBqci/5yFwc6fBxbrr6WA62Zkow4odBx52MkPcn+rl2W+1QWr9Ags63jlUOUKLHbCnY=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB5755.jpnprd01.prod.outlook.com (2603:1096:404:8054::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 6 Jan
 2022 08:16:32 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 08:16:32 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1 2/3] shell: add kconfig parse api
Thread-Index: AQHYAThOqIvUm+MPjk2RIXi6fN05TaxSs0UAgAFSgYCAAHpoAIABAs2AgAAmMQA=
Date: Thu, 6 Jan 2022 08:16:32 +0000
Message-ID: <61D6A588.8060609@fujitsu.com>
References: <1641279439-2421-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641279439-2421-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdQpwpbyGGNKx84z@pevik> <61D545B7.7020003@fujitsu.com>
 <YdWsZpTjnBLszubC@pevik> <61D6857F.9060802@fujitsu.com>
In-Reply-To: <61D6857F.9060802@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e89d133-3ea2-447d-dfe1-08d9d0ecd90e
x-ms-traffictypediagnostic: TYAPR01MB5755:EE_
x-microsoft-antispam-prvs: <TYAPR01MB57559F0D81AA71332993659FFD4C9@TYAPR01MB5755.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ojPEtG8VX6bctI5S++DdyxGY4R1YxF5zVFWYJDfUWqd2js2bI0usojcc8Cx9u8MGewFKX7fNyvKaBowWZt8wJhtPjIbZXO2AsYdTq3MvYf+whog/DeGx4irqczqYgJ4ZM9WKp4Oklyv4uSrerMt58M+V1jR4uTYITUIXqHrAmOVp7te58an0rjGT2HdrKRqEt6aED3/NoxiNGAw6NERkFSy+8beF66EaVfE7KabolI0KNjVo7+aYe4O7jO0wYGCJ8K3sQPjR79z9u2shc8Y+GPcq0W/TUqOtecN8MXoWZRf0vZv826exaqx2GJZvqP6FCzDj72AQO4IQsQH8Suq2GqGdhILCUZgcwUmTbVH6rqFBv6oAzwkcRDVPydz8d/paqu3/hY4K0HI2fYF/E8yFZBMs7o1/nnjXkY/SwGQAQkuVd6qUFS0nWyN6wZ0jU+LUgKKIMDYfKqSOej3poPVQId/nL5+/3sFMsN9WQJxvSVEHbME4wm3wM6ZTyY+//I9o5vFuKbZyT5xx+rv7Ba0bHbNnmOdWreuZnjWMSG3V/SU6uAKpxKsmbFAXWQhSNQNkG734s04/MqZNSBUlb703jwmqdBFzRHeXbTxYBJwjsdoto5BuEUV/Js8ap+66CYIv5LvCvEnxYdynvLi+NBV3XJruB1hQJrJas4N+Hd97QnGJHAuO1wdhb5aWoJk3h1D+dbyM4GmygLcfq72yQ49++4DdjNLbujNigwbV8zQyxlb9oi6aXHVvGwBtlpcSSnOscgFRV9Hq9oeBySx8nrDHBnfOB9BD62wWbyGML+xq5z8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(2906002)(87266011)(6506007)(6916009)(8676002)(33656002)(8936002)(38100700002)(966005)(508600001)(83380400001)(6512007)(122000001)(5660300002)(26005)(82960400001)(186003)(91956017)(4326008)(71200400001)(316002)(6486002)(2616005)(76116006)(85182001)(36756003)(38070700005)(66946007)(66446008)(64756008)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L3BJV1dvK3E1cnJTdDJhdHhaZmh6L2IyMU1YUlBTREczTmc3K1F2SVJoOXB1?=
 =?gb2312?B?Z0hKYjZrd1p0V0RJaEZ1R1RPWUJzUHRvdmM0cVZkWnprdzlnNFBBQi9mNFlF?=
 =?gb2312?B?dFhkU1o5aWNkNzFRSmhCV2JGUFY5NXJoU2pqbjJMVzNVSEw2akZwNkRtdkVj?=
 =?gb2312?B?bGRnOWxxWVhYanBaalZ6cTJlaUNoUFFGdk9LOWZ6QzI3eVBaQmxQK0JRM3NB?=
 =?gb2312?B?Zm4yUHQ4MkJReWtieDRLbjcvUXYyNGM4ZVMvam5FQVJMMHVwMTBpMnBBLysy?=
 =?gb2312?B?dDBibFBOOTN3SjVBemhaTHFIWE8yZUEvT1RERTJPOGN0Q2dhYUpRWVk3aUlP?=
 =?gb2312?B?WUZRVmFCdGZXU0FNaFdvVndTcGd3dmdvaUI5Qm1FeStnUXh5czZjb09IL1lQ?=
 =?gb2312?B?cHhHN3hIazNONzRiNkNVcWE0RlFIYVoyblRxRkJIa2RDOTg1ZDJGM21Wd2ls?=
 =?gb2312?B?eTlzL3NPV0JhU20zWWlWR01CeFEvQllWcWd4TEMvc3VDbzZzV1lBSUU4bFlQ?=
 =?gb2312?B?dTlRYkx1OW5PN1ZybThqVHU0NktENXA2MmJCaktzenowOHo3elN1VzZaY3Ew?=
 =?gb2312?B?KzE4RU5tZzFZRGx1ekxRSVhnQkpLaVZhQWYydWRraEtQSy8yY0xLcXMrRGpw?=
 =?gb2312?B?d0JvblpQLzFaQjcwMm9wZDhUY2Z4Mm9yZ3JzUHI1a0FUMk1lSGlRZ2N6MEFB?=
 =?gb2312?B?SVNpOEhnVkdWWklPZlQ3R3JzTHhOai9uNWdreFg1dkhtTFI3ZHJRQi85RnVI?=
 =?gb2312?B?NzlTTjllRUtUR2I0M2RZZlJOMmFkSDdmdXZYcW0zbHdRY0xuZG5tSlgza1NI?=
 =?gb2312?B?ZkczYXFlQ2RJZUFnYjlYY25lbnl3WXI5azJNT1dxR2JLWjZBWHZRU0RpZFlX?=
 =?gb2312?B?TG90bFF6Z1NieVV1VVUyWlYrbnF6M3QzRURGOFZ0SFoyeWhMSEYyVDBUS0FQ?=
 =?gb2312?B?YVoyT3dPWkhHYmY1ZCsxSTM5blZkQ1drV0FkcDU1ekNLWkt0SGZ5dElLa3Fj?=
 =?gb2312?B?VGNTU3ljd0kxWDE3WHpHb01TTlU2WHkwZ1FOZlMxK0E5bXp0ZjZWa1dqMUNx?=
 =?gb2312?B?QzJid2pRcWd4MlRPTnVJd05MSm9IU3M3cCtrL1lzc2FhMmVvVEprWlYyTnJl?=
 =?gb2312?B?ajBvaGVOL1Jvc2JLeEpuVExrVmVhTk1WN2s1MDM0RkJvMzRtU3B0QnhpZk90?=
 =?gb2312?B?alA1RCtzV0dhcksyTlA0Mk9FcUljMUE5UmRWMG1sWThnckd1ZXYrVnBSQm53?=
 =?gb2312?B?b3htVVpOczFqWEhYVForR2cvRVVIS1E2U0NCUDZ5NXNJY1dBeUJkNmJOT2M2?=
 =?gb2312?B?N2RyQ1gvUG1pMlYwQ21MeEw1ZXdxNEFGeTBrazBFOVlSZWp6aUFySXlGQ3g2?=
 =?gb2312?B?T3VFUWtjeW5mY0kveGJSblZMZDA5L05LMHZsTjNIY0NRSldTbWxDSEFNcE5W?=
 =?gb2312?B?VGx5U2FFbWZLMnFFK2owdjJpeGVCUjhwdVQ3ajR0TUs1d3FucjZSakRWNGx5?=
 =?gb2312?B?L21IelJKMEVOYVh2QVYxWDROeDBkUVZZblMya2xsQnpNM0dLdjRPT2pXdVJB?=
 =?gb2312?B?N1JuZDNEd3lCcEUyNDBFZ2NoVUFXQjJUam9PS2gvSWU5ZXVudDBxekVjbzhN?=
 =?gb2312?B?Y24rN1FYdldDd1R5L0Y4Q2hrNmtvT0JpNmJXWXVsRllHOFEzWUF2NDAxZ01m?=
 =?gb2312?B?VDJTQytjWW5kc3hIbkRhK1dORzBMUGVEM2ZHcmtuODBYTHRvVmptL3dkQnRR?=
 =?gb2312?B?ZTFhcXdXWEhLMTNvKzVMMzR3c3ZNSHIyYnRJQjRleFFKR0xyYkNKRjREQ1Zr?=
 =?gb2312?B?Q2hLVE1wNU1Sem1PSzVOK3V4OE5OK2RhSHYyd2N3WVVkVEdzNmMrWSt2eitx?=
 =?gb2312?B?anNwN1lMRHdvUk5ZSDNCUnk3SncvK2wxbXBmbFA1MktZL3BlRmlCakxwNCt2?=
 =?gb2312?B?UW5BNGIrQWo0cmFQL01GODZ4dGI3Y3MyTTd6OEZOVmVpL0Rpbll3VEpYSGpn?=
 =?gb2312?B?NTlSWExSZjUrT1k1Zk9HV0s2ZS9nSDdmY0RISGNuK2ZMZnR5dHY5SXR4dkpO?=
 =?gb2312?B?Um5Vb1hnMzQzZ1N4UXpzY2liQWFLdmxob01EbEk4N2hJSUFQeXdSMEhmWW51?=
 =?gb2312?B?SGw1TkZDMnZxTUlPd2ptaU1yaStUaUVRWmpWZVEzTmNEYjE2aWZPb3lSaU9H?=
 =?gb2312?B?UTFHditPTXI5dXpLand6K3RtQ2preGFxcmtDRkgzOW5UY1ZKcnNCdG9CUEl4?=
 =?gb2312?Q?7iwV03ONISKcOTRm5eSLyqHA7LmugOrasonmgyFobg=3D?=
Content-ID: <C7ADE20A0F81984791E6966127FBA848@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e89d133-3ea2-447d-dfe1-08d9d0ecd90e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 08:16:32.1501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSPQVVEjDnIFPnykL82nTl64hMf5ajucn8ohJB7TKBK1MOfxfAtR5Q+BlraQ7hOGqPynrpn/SnrB7S2tUJ9ARZcSLsFdxBYfhHXkvVPMEos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5755
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] shell: add kconfig parse api
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

>>>>> +
>>>>> +Now, we support the length of kconfig list is 10.
>>>> Why 10? Cyril suggested that in PR, where he suggested to use separated
>>>> variables:
>>>> https://github.com/linux-test-project/ltp/issues/891#issuecomment-989712350
>>
>>>> But for string used like array there is no performance limitation, thus I'd use
>>>> something like 50 or 100. Because for certain IMA tests there are at least 6
>>>> kconfig requirements, thus>    10 could be hit.
>>> If case needs more than 10 kconfigs, we can use&   ie
>>> "CONFIG_EX4_FS&   CONFIG_XFS_FS&   CONFIG_QUOTAL_FS, CONFIG_PROC_FS..."
>> Sure. I just meant there is no reason to put low number and then workaround it.
 From my understanding, we split kconfig list for kconfig1,2... variables.

Then I need to call tst_check_kconfigs with pass fixed number paremeters 
one ie 10). code ie
tst_check_kconfigs $kconfig1 $kconfig2 $kconfig3 $kconfig4 $kconfig5 
$kconfig6\
$kconfig7 $kconfig8 $kconfig9 $kconfig10

So do you have simple code to replace them or you just want to increase 
the number to 20?

ps: In fact, I am not good at writting shell script. So if wrong or have 
better way, please tell me.

Best Regards
Yang Xu

>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
