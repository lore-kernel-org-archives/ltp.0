Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC96EC4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 02:31:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 644F53CBE87
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 03:31:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11B213C32DD
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 03:31:31 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D39E71A006A0
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 03:31:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1670898691; x=1702434691;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/lhLjrXB8n/dVmW3nUZPpXA9E8NqhJn2BmbnnBwaglE=;
 b=ZUpgeK8iJaq1484Q8zgPkBHOS9R1qCNfD7ktXSakZwGDOzvMoFXfPflH
 eCS2zLZAY8cEOmu92RzQi32ONoTFALFTwZrQKg9wEewyHIvgQ2Y87RmTy
 uUIcItsrQ/gf2qrL6WHv2OB5IHsp9uaoqH4dZYVQ9f+OrnvGOeRaMawHx
 fsfuSjIaoM2dhpQNsNhTAgiU+vF8s+B/ak9/yaNDxD4uh4Q9wF+KRQt7f
 GGliVcbDVXomZWOm6O7zX6hiHFGVrVgI6lyapd6Xi2lRIdtuuM/w/TzR5
 lCz0NBwyyz0eBUw1Nc7EUJfumOc5Geha9AF7GV8KKQtxSdJPlYz3mqXcK g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="74247828"
X-IronPort-AV: E=Sophos;i="5.96,240,1665414000"; d="scan'208";a="74247828"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2022 11:31:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FApzhIUz+Pk3RodH2OyK8pYOTPkhKKsRQMBrE/cyxZVWNOw1gLPI44SyAqBKSiCV4SJcTti/bBxjC9AH1zUb/MtyHM6hQorHB5ZIwNoSEXoxGIqfi1wdHwTxrdiuJuTGPQeYiit6jEz+jAdhzPFC0s8i8wz+rjoFBwB1a+SE9Z/seAxXUPNYzpTeYFi42nrwXQHMewDuMPrmWXNEww5XpDWSi9OEkSTruTrYICeGDt8L8ntVIzbWl+LKUMpwyWKXsGoIRBytxbC0dmV4HeEUjszEQz4TL/wcjIveoyHPaFri8C+re9jyDe5omrGF7YOxVeH912mYZLm9DoJKMM89ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lhLjrXB8n/dVmW3nUZPpXA9E8NqhJn2BmbnnBwaglE=;
 b=h2DsGSWaoufqFp5m/s6+MCTBE/gOV1rkCvz6jIa6/PJHx38bGG+6W2eksK65PeNDihlSr5cOD5JRls5HR6pesizDZU05shBWq85ehtvx6MMUkQQqhJE8782RjV7EdNCSq0INMSe/kX8Aat9wEKADTyQRUCUQism1YHQ1XSrabcNZjyu8W5FeM9XqFuifLTzcSHnh2uFnMuS1vw0mX0TzjRT1vQOsnsocRURM84fGDinWVcpjh2YqpBNkNxyn2XTa0Q4FzGThMBr7Ml37GKLSKmGYURXFjdcaM5zSyVo+LHsb3NQq481V5YPpBHepl7kM8D3u7GDq5+s+ZTyWkimq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OSZPR01MB8846.jpnprd01.prod.outlook.com (2603:1096:604:158::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 02:31:24 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 02:31:24 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Jan Stancek <jstancek@redhat.com>, Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1 1/4] lib/tst_kvercmp: Remove old distnames
Thread-Index: AQHZDhYNQlQrgTPXd0SqHAD1TBgbAK5qYR0AgAATUwCAALZ8AA==
Date: Tue, 13 Dec 2022 02:31:24 +0000
Message-ID: <b4b93a47-d106-3a65-939d-230fee359f13@fujitsu.com>
References: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y5dJDFk5DpAhTKDV@pevik>
 <CAASaF6wrx+0bkVa2_sSViOYHE25O08GbW_Jy2MQBfWKuJWtZkw@mail.gmail.com>
In-Reply-To: <CAASaF6wrx+0bkVa2_sSViOYHE25O08GbW_Jy2MQBfWKuJWtZkw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OSZPR01MB8846:EE_
x-ms-office365-filtering-correlation-id: 8b39dc14-b69a-43fe-8b05-08dadcb22123
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQU/59wMgzWJYGxrcLCLzyd9h8qsrA1NbcON/i0ST567LiJrqTc58z0Tn4j/HX4VXkEejT4W2tcaSdTPcxKHYaN7leDCizNkCG9/HYxJhf9eZchfjyNC0m+MDRiwGYpk1UFfBoxZQ+V/4x8cE1ZKtxUbCO/ZXSOLJzchGrE5i1lyY6dn7z7wwQ0uuuV/GOYSzMjZgnot612D/fnC/V/Sn8pkcSpNjJWTQW41RDonJTG5tIvOQLhqFrPSWyhsgklLRqdcnJ0DqXPJVZKetLL2AiKyFEhCcW2q3vFANP1eTKU95+g6h8XKld8IL6hzhd/aosCGcLmmQaaVPSp+lVNWf3xRlVu8OB+GbAkOA32fQexQy/LCxh/flcnELqaEyrXKC3pqc6WNei6v/TAnMfxqI9EalCHAVYAPzDPlwyCx/EZtnjgYo8RaSHFOUFYkGacO+s6BXkA9JCEl4lSxAxYbl3FCL4DMfFEceLZyOvqFw8lba+C3eGegZcxE57z+ofMgDZ9oo1Gk1M/9+C+7ym84AvfvrK2h/PQcHAeoSo1EF7QWx2YWiOApE2OEeS/Gpb5NEzA2vzRkjQppQH0GhBztzlTGq44rZ6mHaGF1SeHFjSTDzQNiublViyAhXGcTkdpkEOfEAQChqesdGplBoaMEGH67VGJ0itZdXfKlQPls2UxClVacS/ZOYQGpBmLYYlG8k65wIuo/LjP51xjxVHh6+c34VrOEUT60AESVVjLMbxkP128u0jTJUfUiaFxBmTc34vhh2F93Nb72OuYLuw5pwg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(1590799012)(451199015)(26005)(6512007)(6506007)(2616005)(186003)(53546011)(2906002)(478600001)(71200400001)(36756003)(85182001)(107886003)(82960400001)(38070700005)(38100700002)(86362001)(31696002)(122000001)(83380400001)(41300700001)(1580799009)(316002)(91956017)(8676002)(4326008)(66476007)(6486002)(66446008)(64756008)(66946007)(66556008)(76116006)(5660300002)(54906003)(4744005)(8936002)(31686004)(110136005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXRLSnJHdW41ZDlBZWw2NzlOUDBaMWVSUzd1TUlPV0R4SGwwT0hLU3d1em5L?=
 =?utf-8?B?ZU5ycjBmZHptb2NZaGphamhBcCtxWkFNUW1HR0YxUklOOUxONTVYRU1aMGk5?=
 =?utf-8?B?SzVrVURsWCs0UVgrTlVZK2NjYUpEVk9uejQ5VEFja2pvUWZNUFVHV1ZpSDdM?=
 =?utf-8?B?SW5JNkdTdjN6dE9MbXNiV3pFWVlSTzdOUUZpR3FWMjZnZXdSU2ZqTUo3dEt5?=
 =?utf-8?B?cGhLVnAxSEVnTnN1Q2lCTUFuamc0SmxCTzd0MnVReVlOV0ZxbmJMNUlpTlBF?=
 =?utf-8?B?WU1lT2dRK2JMZzJXQ3JoVXZ6YzdIYmxEUVVJQzVKZkZ3WE8vRnhIWXJQT1Zw?=
 =?utf-8?B?OU9kc1FmOGU2Rmxlamh0VndXdDJHNXhwcU16MjlvN0JlMGVaa1hMRldaY2Z6?=
 =?utf-8?B?RjMwa0I0d2kxelNBMHdEdzd1dzh0Z2xCais2cTVESzZiZXk0Q2w3MnNBTHFx?=
 =?utf-8?B?dHN6blZQTy9RYlUvLzRPWStBdFBoOVhxN0t2bk9tK3Z4b1NlZG10YjUyQ005?=
 =?utf-8?B?SGxkM3dWclpYM2ZPWktXY1VEV2dBYWM2OVJDNHF3NFhYMFdTMFltSm96L2xo?=
 =?utf-8?B?NlZVYkNZOVVHZU96MitXbDQwQ2ZJNHBpOGpxZUZMT1I4RFpZbWRvTkhPcDZu?=
 =?utf-8?B?MUdTRGNnNkg4K0Q0UVJPNVJOek9SeVRseXBHK3p2Y0tiTEQyejJXZzNtaTVI?=
 =?utf-8?B?QnNHa0oyQTIyQmFWSndGRTA3SDJEcHhSOTl3b1dXOUoySUF6bDA5amVHclZ5?=
 =?utf-8?B?dG8zbUlaSzZ5VUVJNVorV0dYTWdPZHZVVDBBZEZhMVdTYVE5NFdNaEpPclpV?=
 =?utf-8?B?VFRMNjVGK0czWkNST3B5Mms4M2NTeFhsMFdSdHZyM0t2OHdISjFwZmtIRnFm?=
 =?utf-8?B?WHRWNEZJeG9TaHhpYTcxemZoby9CRXlXMVBINE5tdG5lWHU3MGtoYVYrQXEr?=
 =?utf-8?B?Rkg5ZGREQWE3RTZtQVZkeEtLZEQ4UmhINHFOTExSZVFsR2hJdkR6QjcxVUMx?=
 =?utf-8?B?c3FZRCtza0xxMEhBWm5UZEhOaVdzd01kYUJIT1BIYXVQNWhLcmNZUXNrbFMv?=
 =?utf-8?B?OW1paTlLVHFIR3cwL21ZZHRtMHEzQzZIYTFVaHVQNisxdUliSDRFWjQ2dUZj?=
 =?utf-8?B?WmROeFdHNDhWcjFocGpPMWxFbGtlZWREeDdCSFB5ZFp0TWU4QzlmTjZxR1o5?=
 =?utf-8?B?eFJ5dTZjZFYvekZrR294Z2k3WVcyS2xDOWdNNnQrUzRHeHYvaTZZdkh4VTVJ?=
 =?utf-8?B?b2F0bUZ6eXV3dXBPUE5PWDN2TVZER1dxMHg3azdGZHVIZmJvN1pNQ0w0QlBU?=
 =?utf-8?B?K2VndFYrM2NuOFBwV3hOYW1LTkFFckU3UFBWd0MrNk8vc05oVWwvN3pmaVQy?=
 =?utf-8?B?aGtPWWtWbnI3Z2tqWlBLaXJUV3F3ZjdlYmMrZm4wc0N1eGF2RUFSSlE0UDV1?=
 =?utf-8?B?T3dkSER1NkcyTGhscEVMVUxzRUdMdEFJWmRaeUxjMU0xejZSQUZLMzV3UkxY?=
 =?utf-8?B?MEdOWkRFdGVxS1FWYnRLcEErWXI0aVFuTzdaaHRWZnVMVmVPd1laN2dYaVAw?=
 =?utf-8?B?cFZwWEpHWDhaTmhxbUhsVE02WWNwMCtTQmxESW1qcDZXYVhNUWppcS9vUzFh?=
 =?utf-8?B?ak5DMERFaHpBMFp1Y08rTTZhQkxtSTVicXVlakI0VUFlU1RFd2RUOFd1WFJ3?=
 =?utf-8?B?eHp0SDdGd290QUhhUXRiWWxvZDdzQ1lnUWd2aGdqWFNGa2tiRlJFWjhEY3E0?=
 =?utf-8?B?YU5GWkkyWE1aRTR0T25oTFUwbTgvVUxMMjI2UzAyVHkvVFhRNHFBQ09CbFhU?=
 =?utf-8?B?UENLaDBzYVVFbHZEbmRqZlNic2NRZklCWnVuaytqdVNVeGE1Y2RYaTRoUHJB?=
 =?utf-8?B?emR6cU5FU0JiSVUrWGZmZFBTckR5VmNxZTV0OC8yM29TYy95RDFGL0pDRVVX?=
 =?utf-8?B?MHdxRlh5eW41ajBvTzkyWENZVEJHOENTdXhtNkNxb0VMQ0xOMWNsSUxnNitK?=
 =?utf-8?B?cWxXREdCUUFlTm02dk5iN1IxZ2R5Y2lMYnVjWXdBdkp6MlFVZUwrSnJYa3Z3?=
 =?utf-8?B?SXR1S2NjNGZpVnZuRkxYMzJBT2pxSk1FbjZabjAwTW9BN2xNa2Fud0tuenQ0?=
 =?utf-8?B?OG5FRERuTmo0OVp5L1NjWEZZS3ViMGgvUG4rUjdsWmpJZnlUT3VPeXhvRzdp?=
 =?utf-8?B?ZGc9PQ==?=
Content-ID: <363227BB9F46CB44BA34D7CB18D4F101@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b39dc14-b69a-43fe-8b05-08dadcb22123
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 02:31:24.3988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MjNylhZ2Ojjwcq+w5ANDSprPfVo6XI3y5r3raiYvTfT+hm9fikGCMDdtM57NGPedZDUGrattwfGBbl29bUp0XVhX6eXupQ1uy1FLLurqIBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8846
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/4] lib/tst_kvercmp: Remove old distnames
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
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan, Petr

> On Mon, Dec 12, 2022 at 4:30 PM Petr Vorel <pvorel@suse.cz> wrote:
>>
>> Hi,
>>
>>> Our travis-ci has dropped or never used them, they are useless.
>>> So delete.
>> They were here before CI. They were meant for using by tests
>> (no CI related at all).
> 
> Right, it's not just CI. RHEL5 is EOL, presumably Oracle as well, so
> those likely won't be missed.
> RHEL6 has 2 more years - Isn't this removal going to break tst_kvercmp2()?

I have removed tst_kvercmp2 usage for RHEL6 in 
testcases/kernel/syscalls/inotify/inotify04.c and 
../kernel/tracing/dynamic_debug/dynamic_debug01.sh, so it should not 
break tst_kvercmp2.

Also, the current lastest ltp can't ensure that can be compile 
successfully on rhel6 because of lack of ci, so I think we don't need to
still maintain the old version check.  If people want to use old kernel 
ie RHEL6, why not use the old ltp release?

ps: @Jan, if you want to keep RHEL6, I will keep it. But two more years, 
we still need to drop it.


Best Regards
Yang Xu
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
