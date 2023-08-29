Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DAEC83F12
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 14:03:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46F173CEF6F
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 16:03:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9802E3C925E
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 16:03:18 +0200 (CEST)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A2B9F60047C
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 16:03:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1693317798; x=1724853798;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tRgEXzJfY39FY8zLdIDBAjQ/pba1e12m66/MxM2A20E=;
 b=nfzSf4GGXaU09DeeRi+b7ij6Rem0HFmT8q0li+hgW5N/9Q9TMIpHw8VS
 Wu7jnRGAGIY9aTXfxrlwHR2+/QqEDOpFLsQ7cn59jNn2qSY+V+Fr6f6fb
 vZ80DMJkgAXAlBx3gVeuJ169VAWnw1eDet7Ks9BxBUyTwtYHJlaywlCJa
 bU5UwEN4+Vr/4fGCMfV07yHTM4arlo9u90/NcdEoFGHwXDZYzcrHo7bR2
 2Bv4Da/6b3m52+dc5X9L8+1KPTTuxhpEJ30tYQXRP/50gGn1D4IZW5Qwf
 795Sl2vNuea5uAJ+SOPDvjga/6LW8AW8m5QcU9yQ6jN9y8W/ivnoiEInF w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="93083692"
X-IronPort-AV: E=Sophos;i="6.02,210,1688396400"; d="scan'208";a="93083692"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2023 23:03:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYg7coxK6cFgL5o+hl3XTi4OjfU6w3jKpzuY/qFly6sALB5h0LIEzoAkw8nLftp7WsjVU7IZZi4NOcySqisIPCx3inxZxp9VhyCBuXnunFMfacVFq5SabZDIfG1FFPQmAn62mY/xASl52KgqNOlKy6HsEaAvyaCmDHUn8UIIk7wK20wuMmHF181f03kYpyM9SIjOCKuwEe7uLo0ZocPpt4+HPXekbV4S7xtlfXQN8IMr+FYcU8c4sQd/sVo09x4kSYYTIusTJtA9bFBxBr02yezKkKo8WqIPtQY2pFeMvL/ZXR50d7pyqzwJCQbrcgcXRlHrxHxX8gjbKxFS0TkNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRgEXzJfY39FY8zLdIDBAjQ/pba1e12m66/MxM2A20E=;
 b=nhndzaXURUt6ksfvsEFcQRMYXFVySWlsNVWnQHThq0v7UAhyAdWnFxgrGN5f+/wNyXJT0iXeiIS0Z80c6AVgv0nkQwKJB+f5LGCEDGMplPUUeWMOMHmTeiRLzRtB93Wog43pkQX/yCui7ZyzF68I8bvQppHlVfI1DIAfE+G9iNdH/DV4bOP+tc+fwobHd7YWOJw6UJWa39k5qi5samgR9CfbusYZ7svn/7H+PpeBhlNZACvl/y8SXhLUuDG7Lz1ZABR6HLwk1W5BSqH5rIeOVp++AYljn3lqa8nFHpE6feLmhwlWlwcy41cgHcVZCnDAFe5UIv1OnkM+tZYxYR/Aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB10723.jpnprd01.prod.outlook.com
 (2603:1096:400:31c::14) by TY1PR01MB10819.jpnprd01.prod.outlook.com
 (2603:1096:400:327::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 14:03:12 +0000
Received: from TY1PR01MB10723.jpnprd01.prod.outlook.com
 ([fe80::322d:8a4:4aa1:e8a5]) by TY1PR01MB10723.jpnprd01.prod.outlook.com
 ([fe80::322d:8a4:4aa1:e8a5%7]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 14:03:12 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Avinesh Kumar <akumar@suse.de>
Thread-Topic: [LTP] [PATCH v2 2/2] hugeshmctl03: Mark struct tcase and several
 functions as static
Thread-Index: AQHZ10hMYLBoyDYSz0G61A14IInIx7AAx2KAgACNIwA=
Date: Tue, 29 Aug 2023 14:03:12 +0000
Message-ID: <2778ef59-6d56-ef5b-8274-81f6a25f4882@fujitsu.com>
References: <1692963336-4007-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1692963336-4007-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <2832137.Oz9D4KcPff@localhost>
In-Reply-To: <2832137.Oz9D4KcPff@localhost>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB10723:EE_|TY1PR01MB10819:EE_
x-ms-office365-filtering-correlation-id: 68196734-62d9-4f37-f141-08dba898aea2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+oLhZDnSFK7o6aAzTPzJ1SzZZUOJwGxhGt/Z9v1xRupKiYQsmFTX85cvwms5fAmD7Xgc7t14eXC4Y3Bx7J20qYKI0bLWQkMfk/Msybw5w09QhBVro2L4dPOt5g7wcAbfvdjDduQ/MhoeOOE8X9QTUmCt3WCvyjv2KHiw09RnhUtLRFS5HYkk+Ex6HR1KgrBCl3HRamywMgvcjrAOZGRYj+q5sLsubyyNhtjSm/CuknwGpKSBQRhJ5EI5/ONs5d+CJWKTVdEuILWYQhNBDOZA3S+p7xHV6qbJ3l7BKl7dtQrgnHEhnPXquAvPsYbPyJYjffE1uXPNnSfbtd1Xi+TmlTu5dZAIVbBGh7ASVNF0MnRVX51N5UK78UwvvRMAcNvwuPg13obNkfTyGt8kgF9+fQL0qtjK/ICuzSWbJiqK9kVuXVY8nBIHJA9/nudClJ8+BxqAN3cKzQqYy5YfTfYmv82FEOc2tFiwb/ZCDeSc3MRXWgGQ/jXLMfWfVrOWGske87G/w1I2qtdW7WoQlZ6jZv0j+XDyG6WqoJf5/rbBjTqtmyaseLFWGWCnUeoHaFeEj6MNjlhRcrMlTGLsUkIkdvVD7yuXjZ6SfobRKcXrIDwflDjsFDc8qp5SwCpBr9EcJanTCww+/NYXG7EKx60kzhDj3MhnF27EyiDsYi5ffE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB10723.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(1590799021)(186009)(451199024)(1800799009)(6512007)(6506007)(71200400001)(6486002)(53546011)(478600001)(83380400001)(2906002)(76116006)(26005)(91956017)(64756008)(66446008)(2616005)(6916009)(316002)(8936002)(66476007)(66946007)(41300700001)(66556008)(5660300002)(8676002)(4326008)(86362001)(36756003)(85182001)(122000001)(82960400001)(38070700005)(38100700002)(31696002)(1580799018)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHBGVTk2VXk2alBwSnplOHM5L0ZCbC9pY3pYYi9pUWpEMlVkcHhxUUdjelh0?=
 =?utf-8?B?bVJyVG94enlzRjFST21HQ0orZ0VzVXZSUGRsUVRMWll5cTV6bFVkZXBxeHJu?=
 =?utf-8?B?NC9zNC9VWlJteTJ5eVgveEwvWHhsYUF0TlNvSDdKcFFpdnFYRG5TWWtud3hw?=
 =?utf-8?B?Sk9KQVFQN1Y1NDVKaG9YSlE5SE12SWluVnNBdmU2M0pjaitMWVYzenNkcW5G?=
 =?utf-8?B?NkU3K0NqTGJuczZyNnBsRGR5cC9VYXVndlNrZklJWmYrVStYVzZ2c0J2NXBy?=
 =?utf-8?B?MkpLZTBPVUdMdGMyYWl0dHA0RFJHaWN2TjBIRm82NnJJMk84MjNiYmpJOWlO?=
 =?utf-8?B?NXlOZm8ybWV6UGlEblZYUG43STh0Yk1NdDhoSGt3akNKc1hmZVV1RXk0Q25N?=
 =?utf-8?B?eXAzcGU5UmViNWNncEpINUI2dHMzeFFVM0VTSUwvMWwySUw4L2pibGFCekZF?=
 =?utf-8?B?Z00vTnJLdVJzRGE0dk5VeUZlTXpCM3RSNVF0UFU0L3dQaktlMnN0aG91clRa?=
 =?utf-8?B?eW0vVk1OajlDRWFvZHR1OUo0TXpKNVJqTS9YRFNwbkdnMGVLYmRVSkNBeWoy?=
 =?utf-8?B?SXBTbTZGS29DNlR5RVNyTjNBQnBtbmE3Nko4SXFENmtPNitOMW1rcUxlQ2Ni?=
 =?utf-8?B?b3o0Szh1NWZheHVrcWRkc2M3ZHFWOTM0VUc1cm9VeDB3M3VIRHlDZXQ3MFlP?=
 =?utf-8?B?Z1FxUFY5VE5QOGFCSnZEZ3dIVzNrMW5WNGx0VmhXLy9oc0FvK0x0UXpHclov?=
 =?utf-8?B?TFo5Y1I0R0UxTUNpaGFwV3I3OU5MSWYzejFET1MzWGsvdzdsc0NrbDltand3?=
 =?utf-8?B?UGkrQnAxYlMzZDR0TVNvRVBhdm85dzlveUhZb3ZNSUpUNFhHZEtBMTNwZE9h?=
 =?utf-8?B?TGlUSGR2T2FtbEJOU0RNR0tHeXVLdUxxU0lsYmpQa2MwSXBlZlJpUGNpaVFZ?=
 =?utf-8?B?N3M2TlhXd3U0R0VJMnYzUVE4ZmI2WG9UaTRqalRYTFRwcUs1SnNXangzNElj?=
 =?utf-8?B?V2I1V0JNdXlHLzJ5Sityenl5dnRiVlErODB6U2wxNjN2eUdOR1JSOFdHWU9l?=
 =?utf-8?B?MGhxQ2xkbHpxMDlpL2Zocnl5M0U3Rk85YXZXS0ZTMkdTQ29oZzhMc215NCs0?=
 =?utf-8?B?MUl6aXNZUG50RnFsMjFtVGVGNkRwYzkzZng5TU92SjI4dm9sbmtyTEFNcjBh?=
 =?utf-8?B?L3NKZ2JNYnpBSkVYc29QL0RoYkxzdGFZYjhUcVQ0bE80QkI0WWRjc1lFRlBz?=
 =?utf-8?B?SXRiUGkyQ1laRHhSbWlhbDIzRWlhRmRRWUs5azJDVlRwempzbmNpcitMWjFl?=
 =?utf-8?B?MEtXOWx5eWI2azlZeWFmR01YVDR3MzNpUjcvdTcwSEtvSG1tK2U4K2p1Rml1?=
 =?utf-8?B?Y0dVZ0Rocm9UUnpSTE1hbTVCSGRhcUpkdHJ2aTdONzhsbHBrOFI4V1RoOUhZ?=
 =?utf-8?B?N0FtZkNUNkFabjdqN1QxTlZIazhUU1Q1bVZJSzIzSzdIYkdObWxMQUFJME9v?=
 =?utf-8?B?ZEhaVFhsWnhLNjhSZjdWdHdMTUh6K1c2Z1VOYys5WllhZ2k0VmxNSG5qM3o0?=
 =?utf-8?B?ZHl0VWtoK1pVWUt5R2FvVmFRUXlkc2llY2lOSFY1WW5kc0t6RWhTN3JZLzJM?=
 =?utf-8?B?bTJyNEVPdXNURVRXaDZSbWVzSjBmdmhWMVRELzRwQzJqOVJ4VFgxQ3RiZkhM?=
 =?utf-8?B?TXM4aEZaZGJnemZZclRKQzgzam85WmhVajdROTFWZTNHUnJTZnZTL1hrNUZ6?=
 =?utf-8?B?eW1NWVlRMEx5T2V0bVdrQUFNV0k2TzdFeEFkdlhnQzhSc1lzY2N1SXJiMERo?=
 =?utf-8?B?Q2w2OExDYnlPK1huSnZrclRHakxSU1NyRVhwTDg3NnJrdllldFYyUDRYSklr?=
 =?utf-8?B?dm1wQUFqNjlUQXJYSlFpdkpEbmsrUitNUm1KRE5BQk1ybXI1L2xUVlFpZnpn?=
 =?utf-8?B?R3dVVXNwcmNOZlFPWk1icTFTWk1acW9iQVdoSGU5N0F0K1pvcGN5bGJFL0Zr?=
 =?utf-8?B?MHpNbnVqa2dHUUxTZlpya0Y0cDBkS2VnK0VOK3ZOSytKckJuTFZVTm9rSEwz?=
 =?utf-8?B?M2o4U3VHZjhQbTBiTWl0WUlFaEVhdktnNDRjUEhHSjZacnllUEwxREV6VlJC?=
 =?utf-8?B?bHpnbmlRblhHVFEreFhYYTBETzY1dFJ3Yk1lZE1jVkpuVXFYcVN2Z280Q2xr?=
 =?utf-8?B?NGc9PQ==?=
Content-ID: <281EB36D74C24D409F37D2DC2EE79402@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NDJcMzfFdHiM2dicGTSFLzd3vFuDXCDNxe1bYk35K/BjgnCmxRwlKl1DdH4PC0QuMl4yIxEjLt7UPcDwKfm1NbecwujZVhvgGV2hio+UHP1gwFjarRG6pYkWkItVHjCuUtZfKhk5i0lTZRpqXWCF5/rYJyNr/pSUpmaSQ9HsW4wzVzjyS/sB8aTY5MuMsCnU+ReHD3eHSfde8hqWX4Eltu+JNJnxxOFa/Wtx1aHfJCrHDcaE6ZoSoqlZrYWQGcCsmS3yWpQwZVoywsF40vpwoSs2ZNt5wJmx65PI5H9ZOnyYqbl4wACU/nlEBh85Duj0H8Q5yOr1wfrGgxU/Njcd218oOL4U3k/sTPk+HBM5mQpcUIZU8XqjtselRglQ6zsaEAeQ0z06wVZj8k3feh1k55nZXsaWYfeTdIbIUCTxqIEUPl9NfwPYtqzhYRqjN53ptfqcUsv3Wi7JlROFQeMREOyk1CUCeKmeqVS4A8uL28ycHnFzz5KCSZpIvumEIl5Reb1veFj/YA1VJa69NTiAwFGf8q8BlGXuh7ewqhGPXVZ+WWcslznwFOZ1/4sYUoRgOKQaL86qFPoV/uZtNujWnR5kAJSjPT89JDDnsZFkzL+AM7kKZnY1jhhXbLxsdXxLRYDDuurn7HN2gCFMA1wxvl+FJK4SMBca9gaEbeg2kqgPByghhU2/srdnlq08EBbANFOfj5qNkHBYanpE0U9exP5tCEj8SvDX4ocQdFmNlCBm9WWJWcU72oF1DzIhCHvhFBxD+7Oel/tHR9BJUS0fnBD3/hW9b6yil59+7bxZMt8=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB10723.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68196734-62d9-4f37-f141-08dba898aea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 14:03:12.1185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hgs+HgtHellAxn4BhvnyeV0MSVMEkCaBWsppj+1U9a7Lk8VpcPwnm6xqjLVVZ8U+TPO5gcP+fD/vyWy3Tgtx+Nu8hQ1J6+iL/uRdE2cLo+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10819
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] hugeshmctl03: Mark struct tcase and
 several functions as static
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

Hi  Avinesh

> Hi Yang,
> 
> Changes looks fine, but I see that there are still make-check warnings for
> both these tests. You may want to fix them also or maybe another commit.
> 
> Reviewed-by: Avinesh Kumar <akumar@suse.de>
> for both the patches.

Thanks for your review, I have sloved make-check warngings and pushed.

ps:Sorry, I miss your review-by tag by accident.

Best Regards
Yang Xu
> 
> On Friday, August 25, 2023 5:05:36 PM IST Yang Xu wrote:
>> To follow LTP conventions.
>>
>> Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
>> b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c index
>> 21ec6bf78..61e9704bb 100644
>> --- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
>> +++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
>> @@ -44,7 +44,7 @@ static struct shmid_ds buf;
>>   static uid_t ltp_uid;
>>   static char *ltp_user = "nobody";
>>
>> -struct tcase {
>> +static struct tcase {
>>   	int *shmid;
>>   	int cmd;
>>   	struct shmid_ds *sbuf;
>> @@ -97,7 +97,7 @@ static void do_child(void)
>>   	}
>>   }
>>
>> -void setup(void)
>> +static void setup(void)
>>   {
>>   	long hpage_size;
>>
>> @@ -118,7 +118,7 @@ void setup(void)
>>   	ltp_uid = getuserid(ltp_user);
>>   }
>>
>> -void cleanup(void)
>> +static void cleanup(void)
>>   {
>>   	rm_shm(shm_id_1);
>>   }
> 
> 
> --
> Regards,
> Avinesh
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
