Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAF7C19F2C
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 08:06:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E1FC3C7DBB
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 10:06:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 237B53C5DC4
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 10:06:14 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A2F2660034B
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 10:06:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1659513974; x=1691049974;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yWaBxnC6Y6F++gworF00L7SoY/mCoc+VDnhGBGLEa64=;
 b=ccGXfmiWhqWL86KAVPXSyniN60Kogq3yLLUvQV2QZOaC3re/FWYPHUNe
 7TwvqKehwsqSMsoPJQVmlMY8b1UPliraoIiekQ0hI8VUEjBJqXwfU0n3i
 2Gq4QpRqaN7i4edCjo6b82cwOFnjF19Rn3OC1aLzXPpCwN+whT+Z7I+Co
 v+r5fzHZX90o8WRef9tRg1v60K4w9f8m7ScPUs25QmM7BfyE7lSWLu5Bv
 JGmMqBk+7cVuq+lI9jCvzggGu7elNng6DxPR14WF6CDpqh5JgSvcN3hbK
 aIFP3GiT8EZSgmdZ9BSO6ZXW2P0Nc0oF6fYFEXDIuprZNSICAcJ7GBWGw g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="62101891"
X-IronPort-AV: E=Sophos;i="5.93,213,1654527600"; d="scan'208";a="62101891"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2022 17:06:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRA4WaloWBPzTmeeTEBrArS5KUHf38XPRas5HuVv/Ujry2SBq0UNODsp7iHKnp2UZ25Boe1asej9IMe2g/+cMP9qWjUZfRFu6p6iwauFC3tjU801c01UBcIPwNRMxygGQ5pkynsSVBKgAR9Y1Cb2ZSh+XCrLbGhB9IHzd3fSpCS4nKMSiI9J8PfzdeUmVblCWHwCOxSAJxfYHMrP2yjUFUNzajo3XxibOAZaRl29I8Ugfe5BJ3zSGymKNgv0PNXHpo/DQVYWyEKkUQz2fvjJirfJ5HSpCzBoCEj+zsQDVDXku1Al7d5Pr9vWhL2j3zH07He7e4UCgkqogv4QeUvu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWaBxnC6Y6F++gworF00L7SoY/mCoc+VDnhGBGLEa64=;
 b=JSt3gCbBcVLG8xmKrCH7QActA319DSzr2lXTzAZn/OrAv1fypmFnQgDN2QrvKLschz42TQOC+4LmPqOvcl3aDW3aHqbCI//2sxc5X/l+Mnr4aHvYqaeeixH6fgbkO4vCfAZ3Cuj0K6pd3uVRCKHyLlcU1GqSLFFpAwE68xQkqTtFUphnbeRE56GSMDW1X6dAUvDfV7/joyOpEvHDDE1IMn5gxK1fyNEdxHh1OwwsiKsUoorKqJ3tt0HnFzysy+WXMGghqEB6hlnXYxiQWlkA5cnYIfqD8BUulT4gmLJWm40lU28y8uEUzaqs+4SSxu9S/4iZT7ulLvH+cGcldECe/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB8638.jpnprd01.prod.outlook.com (2603:1096:400:13d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Wed, 3 Aug
 2022 08:06:07 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78%5]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 08:06:07 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Christian Brauner <brauner@kernel.org>
Thread-Topic: [PATCH v2 1/2] syscalls/creat09: Add umask test condition
Thread-Index: AQHYpuAXDvOrRQccxU+lf3eG04Mnpa2czX2AgAAVf4A=
Date: Wed, 3 Aug 2022 08:06:07 +0000
Message-ID: <d6c27b7d-cb02-aa1f-4044-f05966382e6d@fujitsu.com>
References: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220803074955.z7okyvrwqxkatxf6@wittgenstein>
In-Reply-To: <20220803074955.z7okyvrwqxkatxf6@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c8acc51-fa9e-4232-eac8-08da7527051c
x-ms-traffictypediagnostic: TYWPR01MB8638:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uO18fVmXoC7Z/DoApB0eUINSMlluGl9Kjt1ncBZG1ReSWVpcRbMqrM25aPb6JMBFZ2qBRrpxTE/31uKcbDI4FwIzNIaTbMK9KFEOTt1yLD5eFRo3BK0qZS0LFLJmp+TWM7QNev3VuzK0Jy9GRlAjLyEcOqM0nr/L408PpX2KEI3z7/OLE/I50ydw2F6mRirpYR+xXYwZOkdRClgmYYz7ikUDcnchisiGFChCRkhBKeARrzDtR9kdwk7NqQ65N7I72Rf8uS8eU/PPC1xCJr+WzLbeAe/96QBw5t56+Ip7ZHABP4pGptK2JCs2Fgs3KJ7eJQT4L6Sw5zkx3ad/eqWWeyiGihkiYfOYBBVGRE+K7qZKVrB4lenhWunRx3poNhAP5UqzM9AgT0AYbbCRYaSycNRKtbGGE2Qc10ADVDNceQVLhI4sWRUTfh4tjX0OVgiJqbUXC9mW9mgVJIqnmWxNVbU1RUW+ckkiscSNxkYPmSYbcwMIJdYpN/vNKbanOx5OgBBN9r0N7N64KreUGG+iMI6s+5LBx9XIWh8Cz7eDUruDgQmk50w0ZiWt4aiXuwzyPmvZ2D3ITxlFFUNLIfuv/vc8OrFy1r/DOP4n6FEwjRzKBSZoPxcqFEgvlcsbPsstoGHivwOFEYZAKf+N4k+0uUIytJMZ1qyGJOTGSmEMMgMbK0BbW5GcvVMl3EfFT6uqNFi7rsEuK+6NvU9ofk8q4rFeP7S2DKD3iXf3nWROIJbEhxCdiZghUu+skcb/NOuqBWXDGmzQorNCCVawAhl/gimpVJD8ts+R5PBL0i5gQAatIaU2d44GHlUpc+mYmWEnHKXqvP90jRKBhrcZMK/57N/9IzxIFQiYG1NxJQBPVq/m69F/P+JdZDy/O97WU6oEtnyr+H1kmSaQpcaTZkrsnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(6916009)(26005)(6512007)(54906003)(31696002)(6506007)(86362001)(71200400001)(41300700001)(316002)(478600001)(6486002)(38070700005)(122000001)(38100700002)(82960400001)(66556008)(91956017)(2616005)(186003)(2906002)(66946007)(83380400001)(8676002)(76116006)(64756008)(36756003)(66476007)(66446008)(4326008)(31686004)(5660300002)(85182001)(8936002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWFwMFlNb2NrOURrN3VnVlBPcGg2bmtmSFJWWDFoUUJ4TGhSd1UxS3IzUjdI?=
 =?utf-8?B?dVNqWjhsV25YNGRMRXhmVmI0b25IWlhjbnprNTltVXdCc0ZNZlhERmZ3bGQ1?=
 =?utf-8?B?ZDIxRGtxY1VmQXljZ3h3TTNWVWN1NklXTVVRRi84ZkptSU9MNURhQlhGU2pn?=
 =?utf-8?B?MXMvY01VNjhFUzVSVE52ZGZaQXdMOTljUk83bjYvTjdkSHRnYkNURmxEQmFF?=
 =?utf-8?B?SGhkM3BOdXFTOEZRa2xXNFdwTmRrRmEyMk91TWhHL2VtVFVDWGlEd0UxWDE2?=
 =?utf-8?B?NEc1eXRyc2xSOEovV0JZbFZFMndpZGFWODBsQWtobVdQMkJaenpPS2doYXAy?=
 =?utf-8?B?ME9RVTY1eVlLUmtDMWQ3VVd6Mlp2bHRCUEJMdzZyR2RzcWxBVVFncjBqek83?=
 =?utf-8?B?dWRDc29iTkEwSTRSeXNCRWlTN09pb0h1TFl1QkovbTB0dER1dnZSU2c3Mnh2?=
 =?utf-8?B?b1NKYjR0R2ljSHJXRytRWjQwdzJBZEw2OC9KVHU0bkNkdFpQT1hrMTJ5SEtl?=
 =?utf-8?B?L3F2OGFZMUxZRlo5akZxQzBwY0lSNHgvVEZIQTcxaWYxaCtBdU50dWNwN0Qx?=
 =?utf-8?B?WnRhbUI1RTFtMERoRlU4L1JNSTVtWloxaldGUHY0QTZnMmhKbW5VWmYveHRq?=
 =?utf-8?B?U3FjYUlXVDVBdC9IdE5Uc21jWEhGL2xWNlBvY3Bybis2Nkg2T0FNS1N6VGli?=
 =?utf-8?B?RllHZUVBc1lSZ1hWQS93MkNzZVFINHE3bG5hV216NGcwZmluemNnRTRxcjZQ?=
 =?utf-8?B?L2MzeDN4NS9zb29yWm5nOEZoUkNkV1JrQmhZdnlIUE5kd1VpVFdMQXRIcEZL?=
 =?utf-8?B?bHVCcEUydk03T044QWxmSE9VRHRCaExLZHlDNllkWW9iTmw5NmN1VWZ1ZFRz?=
 =?utf-8?B?UUdyYTAwNkFCSXI2RTBEc1lvUUxwVVRNRzhFSFVFSUhnZ2E0cHNKWjE1dzFP?=
 =?utf-8?B?bEtqcGF2bmVsQ2xwVkhVR2FHZ1VEMW5Yd1ozZk1SWjROWXJtWGJ3dXBzNWJt?=
 =?utf-8?B?UXFGSmdRU1lqQ3hkb2RnY0lMOEJWaTlGOVhjQTVTU1c4L095SFN6OEV3WE55?=
 =?utf-8?B?WndQMm10YzljaVJhQnFWOURXL2RhMlRMdU4zRmU3V0tVdk9Yam1CUGx5QjVX?=
 =?utf-8?B?U2RCNDhJSlByVldWVHZjYmhKTEFldTlnVjZFS2RsdW8zT2RyMy9QWDdwdmhp?=
 =?utf-8?B?RW9rTkVWMUM0Y0xpbjMycmNraDU0NENnS3duWVJKZVplbVM4cU43NG5WMHBN?=
 =?utf-8?B?MkNQUEJ0OFQzZ29kRzVPVjJKVjlJUFBsZWp3YWZOc3N5MnhiVzFvSng5TFZM?=
 =?utf-8?B?d3N2TWMrVUJMQTlFanlwMm9KbmRCZU9HcWl4ZEl3aElJbzFiUTVsalRlRElv?=
 =?utf-8?B?UWJiZkR5M1FUL0EvaXNVK0VoUTNPUkZmdUdRdWRpT3BCY1hHTFBDckZ4N2JV?=
 =?utf-8?B?VWxFRkh3RU1wcWJJUGpKeWlqQ2ZUd0ZraW80Z2QyRkc0WHovV3NmSGdIWjhS?=
 =?utf-8?B?aWttZXhiWGZzYjZ0Nzg4QnpURzh2bXpoVGE2NkZOaW1sVmM3d253R3pnak8v?=
 =?utf-8?B?Q1FvTm10YmZnN2VleWRZQldoUXlnQnNhOHRaT2RCQ0NXN2tCL3FHYnRaWnRK?=
 =?utf-8?B?cWd5dG41MjZjMEpTVTRnRkwxWW1kUnViMEpwWHhWTDRINHNUczZXbmJ3aXJx?=
 =?utf-8?B?WWdQeDVRNExUbnhPM0lnQlFNdWltTGdTenR0TnpCUGEveXFEZVV2WGtycUd0?=
 =?utf-8?B?K1RMRzZLSHQvbHZBYlVFRlh4TDhMU0FZcnR4Ti8xOUREdlVDRDhjWEsybUts?=
 =?utf-8?B?bHR0ZmhUTFpTdjlqV2pzdFdzVm9jVDNhem1uTXZMOTNnTGt0SGRaSmIrdGt6?=
 =?utf-8?B?b1lhTzB2R0c2aGM1TzhuN3M0Vlo2M2JDMDZVMjBFaUtuMUlsbm5pU0M1U2NB?=
 =?utf-8?B?c2hzclZOK0RPaWxPd1NyeTVoS0xJV2N6SFpPR1VtUGJwcjgrRW50SHpLR3Bh?=
 =?utf-8?B?OTZGU2lqZXIrYjFhalkvU2p2Q3JuT1cwVDJBR29ETHpKajVGSm16Mjg2ZW14?=
 =?utf-8?B?US8yWTFyUVBFVnVlTUlBY3N3aW9VOGJSV2NmaWExeXB0MUNDZXdzSkF5ald5?=
 =?utf-8?B?aE40TFYyaXRBbnJXYXpFOXFoaVYvYlh4OGQzL3F1VTFFLzRpOXJkS3NaUnkr?=
 =?utf-8?B?NVE9PQ==?=
Content-ID: <B9BB0AF97ACE944299BDD0BB48B5CA37@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8acc51-fa9e-4232-eac8-08da7527051c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 08:06:07.5833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8Zj5yeK5jlAZCbDskrJWQxOvkBPV2NKYQtp5coFEnd1TxHwNNGNXA7dNeLc87UcqgX9FM8s+WZSmjmAINi/JI3TFPGwzf/+HvzwOjU9J1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8638
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/creat09: Add umask test condition
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
Cc: "martin.doucha@suse.com" <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "sforshee@kernel.org" <sforshee@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


on 2022/08/03 15:49, Christian Brauner wrote:
> On Wed, Aug 03, 2022 at 11:24:22AM +0800, Yang Xu wrote:
>> A kernel patch set that fix setgid strip logic under umask(S_IXGRP) found by
>> this case has been merged into linux-next branch[1].
>>
>> I will add acl and umask test[2] in xfstests because there is more suitable
>> to do this.
>>
>> Here I just only add umask test condition simply.
>>
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220802&id=1639a49ccdce
>> [2]https://patchwork.kernel.org/project/fstests/list/?series=662984
>>
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> 
> Fyi, I have this Thursday and Friday off which is why I haven't sent the
> pull request for setgid changes to Linus yet. I only sent the ones that
> I thought were less likely to cause regressions. I don't want to send a
> PR and then not be around to respond to issues. So I will send the
> setgid PR on Tuesday or Wednesday next week. Just a heads up!

Glad to know this. Thanks!

Best Regards
Yang Xu
> 
> Christian

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
