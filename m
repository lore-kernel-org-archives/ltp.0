Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9372AC433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 01:12:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD47F3C94F2
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 02:12:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DE153C217A
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 02:12:10 +0100 (CET)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C7D071400BFD
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 02:12:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647565930; x=1679101930;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1MkxP9FDyyytNVvrs1w2eeSEkvbGMVQ5POeiifoic1c=;
 b=fZZfkUnlRRTBKNWLYPc/v7Qt7L6Vcp8GO2Qg0AuOltlCcaaOYRC3md8Z
 LjQspnsQXf5SETvPMJy9eVRDSpMS0VbDapdrjfxJTxD0HRTBDU188n/0P
 AgtBiwUsKAHMBSKbAQ93bPQduZ1awiAmRhqHBGwj0gDlu4tnxrCpc5s/5
 Daqz/4x3cfq+qWrUMw7SxCv8HA67hAeXP3W0l2YXqEuwvIPFpGiPoD4Ts
 r5wzDewJdahBehc4HJkCn+wFwoN9z9/oSFOU7B82jWvRHnNf4Ey0vo5WT
 +0WYeT5Y32w6RJ51b7Y7PtilPS9flfgCs8XXJy2I/W82Ygsb75W4OILX4 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="51974225"
X-IronPort-AV: E=Sophos;i="5.90,190,1643641200"; d="scan'208";a="51974225"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 10:12:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPlEZ4AoOCuMv0OXingm3OL8PRcFlOLTxeGditzcV9zbkyhMuUVFh+zzz3JIwvV/GhksA9AcNaaYhY9oI4E8zaBanVLFUHGMlKAPqy4sSAuNX0aYPcJCncX74K0+xKmp/+VCM8KOvlCaUkj88ofjvwfSwry+e+LI73F0h2BKreW72uOaH/N/ArPJAWCUcMcsgHmkTdnpDDK/9ilT5SDvknz3dSEnYVinCNh1xgA47izTS3bbbmxL6CZSd1Se7KUrT/SxS4l6q3NAqRiOgrnRBI+dUahfPKzlHx1KE2Qu1nuUSk6bamGWMxFG8oZnzt4tYlSza2qQIlSF0kpx4WQdww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MkxP9FDyyytNVvrs1w2eeSEkvbGMVQ5POeiifoic1c=;
 b=PhQ4FlGf58BhUwtBAgq/LXD36Oa04Q5ioDe6/SY+SJXK3KaSgZ8E3LPiYWS3KxJUlOMtpL7ZN2wxl1rOfFDkVytsMK/IuDaRlVUZee4rZwChi2IE8jjluA7vwek4Rh1I9Z/ropbeLLqZAAwOr4OMN1WKKNUXp7HqsKeRDIqgajgGzw3o+XAu+MkTVKzVDIjk9fJ2uSfeBrhNNV/oYkPsIgwRNnCRTJtY68s2QN7rp79gib/nOoEaVuTyPTckmrKU+KyjxGDBfQFBCq0ThqoZIEZ+ImgamclAJhYW1rnWQQJe3XPk5MdopcAxhX4rX07En2dGE4bM1KL5r28k1FhFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MkxP9FDyyytNVvrs1w2eeSEkvbGMVQ5POeiifoic1c=;
 b=gD7yVmLW3r9B/vPkL4+QG0oiGWvsd+dq/8cw7yxBftyhPDrv9LouZrhVJUZ1WEftFzEFSR8Kj9G+8BmEmYmbeMGYmGAfi+VmvIWjazfpGZgRYsvXgyLl8/WOP9FzynJKZ0SFeZ/C8JjI+ESpQCEvL9edBCDGsmaMk0YAg3LuB5Q=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB5070.jpnprd01.prod.outlook.com (2603:1096:404:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 01:12:04 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 01:12:03 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH 1/2] syscalls/quotactl04: Use correct min_kver version
 check
Thread-Index: AQHYOPjlULIQ9rjnQ0qfAtOlnnZw+6zDe2sAgAAeT4CAAL7igA==
Date: Fri, 18 Mar 2022 01:12:03 +0000
Message-ID: <6233DC8F.4040800@fujitsu.com>
References: <1647401546-2898-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <cd942f2c-27db-c174-570a-cd2fd836bfe4@suse.cz> <YjM8b0hcQBrxRzjw@pevik>
In-Reply-To: <YjM8b0hcQBrxRzjw@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e56e044f-538b-4845-be86-08da087c4fff
x-ms-traffictypediagnostic: TYAPR01MB5070:EE_
x-microsoft-antispam-prvs: <TYAPR01MB50706A6C4C6A73FD9005C3D7FD139@TYAPR01MB5070.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zuCYpyL6S83mwVjl3LO1fkjMHX6M17KHJKagWTiaOubZEyEM9jSwm65KLXW/zYzv9bgEfo3y0lxD1K6lv4a0I+6KbqQVckFyDJxmDyhHrjwywiv+LFenn8U66SZr0ay/AnGrECCNS4rm+7k5Ji2s0AaD1KFVGGxH8a81XZSQ0oFmCxAgTyVyyllyqcGEOppXTNrz7Gh6sfAuuzXoROKWaLyaLFac4H89kgqtrHJpkJMt7AKD1ddGPy84b19zz/9oARJwYqXwzvewzpmYpcn0c/l9UfH6Sbp5pqaX/VO+9yrhl8MBdBP17Fjd/+ZIJ5E7V8/1e6dkRVbJPIQ29vQX0gc4vBdLM5BzNVeUCEGCML9WNp2Ap/GNB4MalrnA9GFE4QzDfTyipsGt+5QSscO+nM1caTgRElpEFli85cbuJNnAuNJ5frCC/kwJbxo8G0hMia4Kdxw7I+eEj2jpIj1bJFX8xXU81YNz50PF0nwyRMeyTBQxH8XGAto9QZmL7Htjep5OsiSvlIE26XK1YgPcpTDXX9xqoYEqo7Cx3PqYvL4rm1w6Sx0+ZzJvKvAEqifK1DObSBwUigwDPKiIn9smXwm3b93Sqqlv9cKJ/g27RTXOk5gWABVsDa/B4SYpXLYGzBsvNj4udJR5IT7F3oTytwF2jLB1IJSYXHOR6OqjWQR3/EWcan2rOFE21nnBa7niRyLjXtqSmlLmfAbrBeK3Tw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(71200400001)(2906002)(82960400001)(86362001)(5660300002)(6512007)(36756003)(6486002)(38070700005)(33656002)(508600001)(85182001)(66946007)(54906003)(26005)(8676002)(66556008)(66476007)(66446008)(64756008)(6916009)(122000001)(8936002)(186003)(4744005)(2616005)(38100700002)(87266011)(6506007)(91956017)(4326008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L2Y1Sk5Da0Y2cmVycWMxdGtIeUd1TVl2YkZWSjBqdTQxUndkWTBlOXlDSTRO?=
 =?gb2312?B?WXN2alNVcjRzKzVCd09YbmV2SEFHekx5SXJMZldIbFFoZTBiRlVhS3Iwd2Vo?=
 =?gb2312?B?R3FBcXo5WlhFTTE1T1VvK1ZiTVN6Y3pLaDNwbTNBS2x2bVdoU1RnZUFZNXh6?=
 =?gb2312?B?b3BFZ2xBUUw0Z2ZmcWI4ZXE2R3g3aG1Xdkd4N2xtK2VOcmU4UTB3Y1pNNllR?=
 =?gb2312?B?dFh1eEF0WkxzbkxOODJqVStLN3lyLzlpWkc0V1ZMQ1hIalBFWUh3NkF2SjRI?=
 =?gb2312?B?VFhZcjZCekpCU3MxVWVZQU5RVDk4ekkveHJOWHZIaXhPQ1VXZHF4bUNCKzJL?=
 =?gb2312?B?TFhrSEhpdWlrMTU1TmVndTFFYnIvVHhIeUplVnlTcmY2aXp1dzhvTEJxQ1dH?=
 =?gb2312?B?S3hXS0RWM0ZzL3F0VW5OWlhBN1hRLzhCbVM0cFRhQVhWbXZpL2dvaEZIS2lR?=
 =?gb2312?B?SFhEakFlWXVJVFZKQmpQc09pVTcvMmdMd3E0NkQxa0NVWU1nbkpmSGNBVkZF?=
 =?gb2312?B?akpLSTA0ZXlYUWcycWQ2NXVWYnZsd3c5SXo4S3ZnRCtaalZkZ21GY3ZkZFlq?=
 =?gb2312?B?SHRHVFFURFlldWZLZ0NqK2dub2I3aWlPQnBmTnRRWktkdUxJMURScUgvZktY?=
 =?gb2312?B?Vy9wRFR4NTlOaHg2SVE4dDA3K0Q0V2FBVDZGTTBkQVo5YUtoOGtIUjQ2QzFO?=
 =?gb2312?B?cUdQbEdVdDFwSHFIYkp6Z0N1SVdSSWg2eTdRQ3JJRkMxQzgwN2dFVWRlaGVX?=
 =?gb2312?B?aUttdktiK0dmWUVsU25pakxlbmI5YW5GREM0akhkMVlBS2t6UG52MFpQTnhi?=
 =?gb2312?B?ZlllWFlzRHdBZTZyMDJscjZXMUppSnZPQVlnZG1aeEZqbGV3ekJsQUU2Ymd5?=
 =?gb2312?B?dlNBMldpMFhEeG1PeEM5U2ZhMTZQaXJHaU04WHVkb2Q3SlhLVks4ZmpnYXc5?=
 =?gb2312?B?aVR4WWptVVRmUG5OVFhhaUdBSll0RlZzcVBmUS9IMzhTL2RERUJPdXFOSFR1?=
 =?gb2312?B?SlB6UERGdXJRVjJVdmRjcGV0Mm94WnFCSWhodzNhdHp1eklFYUp2N1RCUG1J?=
 =?gb2312?B?ci9Lamd6WWFaVHkrTjM5R3d3WGRVY2VqcEdrbHpldURCeUlBVjNycWlKRUxo?=
 =?gb2312?B?SVBGTG51SGQwVFpDTWcrVUp4YW0yTzA3NG1SdDFjMGtuSFBDY2x6NUlkOFAv?=
 =?gb2312?B?MThocXB5eHpIZ3BVcHFoOTZlem1JdUtHeTFmaUJ4aFFvSDkzUlRCSFg2R0d2?=
 =?gb2312?B?bUgxUG40ZEhZTzF6UEZYcmhQUmQybE9JUWp5cE9FQUs3dHFqOU5iNm5hY3lB?=
 =?gb2312?B?K0N5Y2s0SUh3OGMyOXJQamh1WU1RbWFWMUIvNzJYRUxOcDRsVmRMbVNKdSt6?=
 =?gb2312?B?L3R6ZnJXS2VxQ2lPbnFaY1hwM2NWL1NnMDgrYTg4Ri9yZFV0MkFKbHZWRDVl?=
 =?gb2312?B?bFRtTmFHaVhPVzlhYjdwZTh3eXlteG04d3NIS1BhUDlmbnVCMjJyNkc1MVlV?=
 =?gb2312?B?TXBudzI4WWhjd0t6ckpWK2NlZmJydXE2MUJObnA5UUtUQzc0VURoNEd3b2d4?=
 =?gb2312?B?R21Md0Njb0JtYUh0dnp5c3NQd2krZjB1REd0Mm5haVVlVS83YVhKOHBJakNV?=
 =?gb2312?B?NytjUHlsMElwVVpqRk80N09BWHdKa25FSE1ZU2JNYkFOMDBQTmtoWVdCTTNY?=
 =?gb2312?B?M2N4N0pkNU1nZ3VLYW1mZDNTZ1kzYUdUSzhrUFFwS082YThYalBpbEV1UUZR?=
 =?gb2312?B?YmttTjlwWW5XOTZaczBuY25WMFdzY0JadkFkVi84cHh5bmRqbUg2RGNXaU9G?=
 =?gb2312?B?OGcxZWh2Nk1yaWV5cUNzL2s0U1FKQ28vYi9ud0hqU0poYi9Vc1FMbDVtZkNR?=
 =?gb2312?B?L1VpcGxreUNmRVVuZWNUTmQvQXVuUURZK0YvVGlOQzIzSk9Ld2RmSTh6ckFR?=
 =?gb2312?B?bjFONFQzWmdjTmhtNURJVVR1VzBwQTE5dFpFanlDT0I5ME8xOVhqckdHMUtk?=
 =?gb2312?Q?sbnnLENYVkYusjOxfk1o1aHzX1a7MY=3D?=
Content-ID: <F6E0F0C80BD539488FE59BACD5687426@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56e044f-538b-4845-be86-08da087c4fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 01:12:03.6224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uX5frbcRJLJnzURQDgHqFgztE1+radM+rH3eqXqJNLtqEGsY6iCF9IIObxgdSzi4FEUybN59LMBe6H1XTM/ZeWSPGT3sUfsEXhONRrtY3Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5070
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/quotactl04: Use correct min_kver
 version check
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

Hi Petr, Martin
>> Hi,
>> this should have been sent as two separate patches but otherwise:
> Well, these are 2 actions, but I treated it as somehow atomic (the check is
> needed only after fixing .min_kver). I don't have strong opinion whether merged
> separated or as single commit.
Yes, that is why I add these two actions in a single patch.

Best Regards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
