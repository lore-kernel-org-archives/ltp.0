Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1253DC433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 08:30:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C1623C9EFF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 09:30:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF8D83C9B4B
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 09:30:20 +0100 (CET)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7FDFD140134D
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 09:30:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1644568219; x=1676104219;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vcPAV5iEUkvhm2z5syR0Iy1Dey+mYP+UsVrOseY3I40=;
 b=ciHQKA7dcmGw375froCbkIYnVpAjtW9v4BI+ftHX3Mrxmsug7tjl5Yhu
 yxEAUpfVys5c76XpYwsQ8TBG56ZwBnjbnD3fX4gZzp9lRIgMf/tHpzVnI
 gWhYmhSa1IMPfX8LAA2ccvMlOSn1UF+Pt44e0n7OL0CUepuLW3qVX/Kcd
 JpEfKNvEXUHX6ujNI9uDkwegC/R/pif/kva5s2zi5mgnF6VfpS18jZKeN
 RKWg60K8HyvriScxTorLipge9CI1SDzAhuHbIjWrIuc8U7gekFgRvfBre
 YqaueZHWVq+D4HBcaPp3+OluTvhfmWc2Matd2ww8DCYIlCwGxgP9+910y w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="49560835"
X-IronPort-AV: E=Sophos;i="5.88,360,1635174000"; d="scan'208";a="49560835"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2022 17:30:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQheSE9M+XS6jPBTTiI3VmyPgX4i8BLcKQbI4ixzEieBnpUo3UEK6Qq0JjTZeeXbx+ozs9P4kqBZP7AyFi0jyOuPIl369TA3DkC8Pa0AW0t9ZeN9kGPkyqNog5AOabCsVO6b4f8yRimd/AZet3Cz0D+tNclOcH/Ef9CgShaiLbvT5mxdicg5gi9QGblIKqv6Gi6jCdiwf/3NqMZeCJn4BiWnjXEBzZdjfWRCIa0lHr0YXC3Tm6qCKHQd94+MOjh6XnCte1vkwpbLo9YcqjkWuE6y9sWu0trXvCxX11XP5hDl+78JrCD63YkzyUY/DF1t7OuBNFNvDzDT8utcHTGf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcPAV5iEUkvhm2z5syR0Iy1Dey+mYP+UsVrOseY3I40=;
 b=nNQ/6z6XwtGxt6Uh1ZkqM4TRMsW/PYh6HAGAuxng8Vp24stkIrmYGB9231vgfELVLT4psPtfmi4a3YPBj3K+IE4U8PVdOD3TgUckWIB7lg0OGHPm9JVmGOUP/95gOQg6OexO8T/V35k2qiGKRJuvH5w3Am9CAIjeijUKSL+aWrTqnH5pYp4ES6T8s8QmIMwMKL8eo758GaDe7Brs11xE/0OKpPC5QqCDqguk093A+kSJchsoOFAUcZ8PA3s7X87mL39WjUbJMnDCbP6UnEfg8IMY8cnbiOjXEWcYvWsy5kUp2hfAcQfghDL7UP9T71DANZ8pm38z0khGt62R9xI6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcPAV5iEUkvhm2z5syR0Iy1Dey+mYP+UsVrOseY3I40=;
 b=QJE5IHj5GtZ0KRj83wCN1BI7H64FT+gWRHCggq/yO7yGlj77LL85I5SJ+XLvLi3iTiXSjyFOuWnKHJAPsRntv2fZAYVkaoIf/khqLcakBc9QOHN/1CbsxVx2raVfvMVg2jjyvN7AxKMvjMZc41zkJd2o+qZ1ZpxrhOWMawD0Nb4=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB2314.jpnprd01.prod.outlook.com (2603:1096:404:10::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 08:30:14 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 08:30:14 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Thread-Topic: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported by
 kernel
Thread-Index: AQHYHoN8lwkj+CqUFEe7M3E8hlXtvqyM9MYAgACN64CAAAvQAIAAaHgAgAAPYYA=
Date: Fri, 11 Feb 2022 08:30:13 +0000
Message-ID: <62061EC1.2040206@fujitsu.com>
References: <20220210133812.13368-1-bogdan.lezhepekov@suse.com>
 <YgU5QvQnzmcCgKq7@yuki>
 <CAEemH2c71jsd5VDZ05pCEGJMHtdxK2_T2MXaK5P73qttBd-gLQ@mail.gmail.com>
 <6205BA38.7070903@fujitsu.com>
 <VI1PR04MB49587421680CE7C6AA8599CD93309@VI1PR04MB4958.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB49587421680CE7C6AA8599CD93309@VI1PR04MB4958.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68bc5e8b-57e8-4616-eab1-08d9ed38b9c0
x-ms-traffictypediagnostic: TY2PR01MB2314:EE_
x-microsoft-antispam-prvs: <TY2PR01MB23146D8B9E8369B37D81EC6FFD309@TY2PR01MB2314.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QjBP6Wiy3AIAW/qYHZvzrhTuKufpnya8Ky34X0+jouRt2LjdjaDjXVXUWMClRnYaAWPh1PrjLQuz5Skw568C4nd/H9ca4TZXjTD1N7uq2Hr9l5KFr7ngg5iTIykOuZGIO3hOpE2XVlpqhrBjioFAuWea95bfsszSVP+H2JWs2J7OIZbaianrjBvLP+D32iFJ+89+X/gxmdpIgWU4Td180KMWXKi0XbVuPytus7MhhJ34dFGFxiEHitAk/WL1i/KOkVeHBOwUpFvxoPwAhKTIhVhgYULH5yVRRxJRnB0f25WOR29pP7puAKycXHep0+DF5op3409YtdlrJq/uhpqO8CIBkmhtff/npiTNWwd5Vnh2MpJ4u288IRuyYUGyWRsHolVkLMvY3SIXkdpPgh9QTihEwg5UHFq05lVHxhNlUhDVA7TZt3tU2E4PzXeTdosD9FuDCNhRIBde51q83qTMQOi9X7dCFGi3jqHMOFrnlQ3ShmHmwc/9rqILGyRMPcEmBgsVYiKKFA1n9Nffvn4mcl3rseu1luruo9Zeo1lHb8XL+K0fAYQPrbbcHET8bx4BwXJemKdPc/bmcZWFrK2yIoMXNkyWL2ur7fubRIQrTrI+OYX125Qi0liDVuFyqokMncXdcUHLXDzknj4x8TCZsHlKrsAub1UI8xNMMbrURBkQriWTGtPKcbCub7xIldy3fx10haZtlia57WFzm/cKG2kFXFu1Y1KPiMfFBuzeMmRcoPL8LrDX0vXKsstuHkwwc9ixuIGvQ/CECBnNiruN/EnA9FGzbb/BLx6MhZ94d78=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(76116006)(36756003)(54906003)(8676002)(38100700002)(66476007)(66556008)(4326008)(8936002)(122000001)(316002)(66946007)(6916009)(85182001)(82960400001)(966005)(26005)(91956017)(6512007)(186003)(2616005)(5660300002)(64756008)(508600001)(6486002)(38070700005)(66446008)(33656002)(86362001)(53546011)(2906002)(71200400001)(6506007)(87266011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aVZueGxxbjc0anFINjRQT2NPV3dmMnNFejRGdHhkYlk5aTlyOTJDdHorVFJZ?=
 =?gb2312?B?QVVjY0tFWVlQUmJJaGQ2SWFIOGR2NEpqRm02VWsySmdjenpZOHdGYlZJZVZ1?=
 =?gb2312?B?TWZYMTdPcUZSQWU5SnFrWUl5d3hXU01pKzBFQit4TlpuSDhwSnJvNFpvVmJu?=
 =?gb2312?B?eW8xQlhjUUtTUU5qWXFmdlZTU0ZHZVVJeG1nMDMxa2Fwbk1WcTJkNmRBQkEr?=
 =?gb2312?B?MitNY0RLODJhK0U1ZmNjYURpUFVNUFFOdVFxYmIrT1lQV2t2M0x5M3NiSk9h?=
 =?gb2312?B?cHpvUitIaDBVY2RwMHV0dXVVY05IbTRQaXV6NktqdUpkZ1M0MkdZZUdMNkt3?=
 =?gb2312?B?emdWR2ZHM1pydUVoUndyOHBWM1VUaWcyZ2xHdmV5cGZkcXlwY1Biemx0Y1Zh?=
 =?gb2312?B?dmdGQmVLLy9qSHAxd0dvd2JDejUrTnl2VWNpS0tVQzF6ZVFJeVB5NVB5aVpE?=
 =?gb2312?B?dldqamRyTHY1ZEp6Nm1YN3RYUW9GbDRVeGx3OGFXOU1QM0NiNWVaNE5pbk5u?=
 =?gb2312?B?aUczQWE4TUlxOGp0dER0cTh3TVFQMW9WbDJ5VkdTWjlOMHgwTDhPa2NGU2Uz?=
 =?gb2312?B?NEE4NjJrUDdnL2c4MzBhKzVDQW1tQTIzRmgwdWdYaVBtL1Z4bURSU00xY2FF?=
 =?gb2312?B?bHhYY3Rnc1FOVkNEdEFBZ3ZyMVo1Uk1jSlBMUjJPMEZxMmluNWwwZEdTNW4r?=
 =?gb2312?B?VXhtUWZzSE5PQVFzNzlUcW8yR2dWWTIrb1Y3SFZTWTlpbjVkVXdsN0hxREFr?=
 =?gb2312?B?VmhBYjk2TURxMWxmSWt5bk1ZT01GTHYvZThGTVhJYlE5aGJsSVJOVTVjN1hF?=
 =?gb2312?B?NXJoZmR5ZEZGTUZydlVkUDF6R3dwc3BVd0lReElNNFJLRHVqR0dHc0dOeUk2?=
 =?gb2312?B?SzNkdGRQWmJhMUhMbEI5b0pNNEhHOEF1cWNGK1VSa1d5aDA3RUlTTUNtbTFX?=
 =?gb2312?B?L3lIR2l5dkYxMUcyUDd1OVhsbEExNkNhM0hlbVJxQ0U3YkxkYWszMlAzQ2dO?=
 =?gb2312?B?bUZJRm5EOHZIREU0RWJFTE9XQy9kMjN0V1RYaTRrNDliVTNxREpSRTFqQ1Bl?=
 =?gb2312?B?TnRUckxDcGdwR1JIUk9yT3ZnZGNKRC9LbVR3YnFGTHhHa21sQ3FEMlFXcUtR?=
 =?gb2312?B?eDdWK3dBOTJpWmdZZ01SKzhUZm0zVm5FTzhqQXRReDNtUHlWNHF2TTdHQmFs?=
 =?gb2312?B?aVVaazVhNUo2V1kwN0NFeFlpWlBRakNzZHc2aXhwQ0l1NTh6R1hzQlY1Yzdu?=
 =?gb2312?B?cDdFWDBPOUtPUVJ1Zy9ZdkNNWCs1YzZMeDNtSExCUXhHK0M0M1dKV3FDSXE2?=
 =?gb2312?B?cisvM1c2bFBMNjNZSG5nYTFrQ3BWMG5odTl0alB3TlpRVFV0UDBNRXlDaWdu?=
 =?gb2312?B?cS9jVkZGRUdZb1c3cDYzQ1YxT0Z6UWFvR2hkenZRR2FwWEJjdGFtbmhTRFQ0?=
 =?gb2312?B?M3BkNktuYUxYdit6THV4NDNiT1VicWkzcXZucE5tMzMvSnNlOVFzangwb2NZ?=
 =?gb2312?B?Qmk0QzVUZ3VHOTRFMWZkYVR3Ny9teTNtWENsMlM0TG9CdEZvT01IWURzUkIz?=
 =?gb2312?B?TXJZSzRqRTI1VkM2UDdpNUI1bjRXR2V2M2R3MEJmSWZNeFNRcUlseDVmeHlR?=
 =?gb2312?B?UmVMVHhvQ2tyTnNDWDlaZXVpUElXSHBZU1BpV3FqREV5UjhQZ2xEbVcvVjFW?=
 =?gb2312?B?VTQ5MnBGeXRwRTVGS3NDWkhzRHJNRkNyYjR2TU5lL1p2Rld2ZnRTR0dGbXJx?=
 =?gb2312?B?RHNvVS9GRm1CUmtTTGo5cFg3bjgyRmFwYXFVZjZBcXZBYUF5Tmk0bU42dEJR?=
 =?gb2312?B?VFVhMXJHclZPeDN2cVdZSFZKOTRoYS80Q0toTms1VUtmM2JKNldVS1BrYnc4?=
 =?gb2312?B?MWpRaVZ3SExUajZoQThSRWtIcnFBV1l1WjNLM3pEVFJnWk4wazRORGNxT0lX?=
 =?gb2312?B?R1NSYWtrZlpwNXFaQnlHSVlncE1HNEVjbmp3MEk3dmlsZnNxaEVnVjlZc1Nv?=
 =?gb2312?B?WCtvTHI1ZVpvSGN0cGkyaURNd3NMUy9yN0E2Vy9ZcTBWTkRjSTg1Vk1jOHNr?=
 =?gb2312?B?R0tqNFFtTWdDN09wd1NBWHhUdUw2UnNYTlYyMkJraWg0eThaRmV3YkdLcWdW?=
 =?gb2312?B?NDZ1clNIY3ZxTnUwdjQ2YzNVbGxVMkdzRzBHRjd3Y0FlUWREUUVybWQ2ak1Q?=
 =?gb2312?B?UmhVVUlYZGxXV2dGNXFiMS9xWDlvNWx6RDFWaFVVQzdMbFdrcU9NSzl4UTd1?=
 =?gb2312?Q?dlVsIpDaifdg8OsEIjFJgOPOcD64WK0GTBP7WncpYQ=3D?=
Content-ID: <BD4F820A86B3F54FB24EE9EE8FBA7B77@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bc5e8b-57e8-4616-eab1-08d9ed38b9c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 08:30:13.9077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQFkFOIS8Hzg4zFS3u+dsKlDnG6dSSPujEPQnY5YVr0nATZl2ouy1lPy2GIjICuJ+LDkSecJ2Q452BmWhLmkSGO3MNxGRluf4NCRbrBz+9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2314
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported by
 kernel
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Bogdan
> Hi all,
>
> I didn't go for CONFIG_SWAP just because wanted to be aligned with
> syscalls/swapon/swapon03.c and to not multiply patterns.
>
> If you see CONFIG_SWAP more beneficial for docparser, I can make another
> patch.
>
> Should I?
IMO, yes, but let's listen voice from other maintainers.
@Petr,@Cyril

Best Regards
Yang Xu
>
> Cheers,
> Bogdan
> ------------------------------------------------------------------------
> *From:* ltp <ltp-bounces+bogdan.lezhepekov=suse.com@lists.linux.it> on
> behalf of xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
> *Sent:* Friday, February 11, 2022 3:21
> *To:* Li Wang <liwang@redhat.com>
> *Cc:* LTP List <ltp@lists.linux.it>
> *Subject:* Re: [LTP] [PATCH v1] mem/swapping01: Make sure swap is
> supported by kernel
> Hi Li
>>
>>
>>  On Fri, Feb 11, 2022 at 12:09 AM Cyril Hrubis <chrubis@suse.cz
>>  <mailto:chrubis@suse.cz>> wrote:
>>
>>  Hi!
>>  Applied, thanks.
>>
>>  I guess that the SAFE_OPEN() caused TBROK on machines without
>>  CONFIG_SWAP, right?
>>
>>
>>  If so, why not go fix with .needs_config for "CONFIG_SWAP=y" ?
> +1, it is also friendly to docparse.
>
> ps: I never listen user complaint for the lack of CONFIG_PORC, so only
> using .needs_config for "CONFIG_SWAP=y" can work well.
>
> Best Regards
> Yang Xu
>>
>>  --
>>  Regards,
>>  Li Wang
>>
>>
>>
>>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
