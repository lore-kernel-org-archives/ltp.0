Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ABBC433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 05:59:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B23673CA2E2
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 06:59:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 505F63CA081
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 06:59:22 +0100 (CET)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8A9691A00A34
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 06:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646114362; x=1677650362;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=er15Arcz3w5YZGMWoGjBUMB+MK5Hbbpn6cqtIvyUqI0=;
 b=HWFOqHk+aBt81Ikz6LwrKjVTMxDFvJKG07BBSIJfm8cWSpKhdBzcqqgH
 50ehbVA191MoW5VOMqe71+efkPhalMx62Lle3NjxuXFpcEvEE0b2bOw+E
 +lGBi3eHvF1nD5AuCFwoxuj4eoaOr2tDORqEjxYovLByzK3XFRIWRxky7
 nhXmREu1gOx6iJs/zcp20GWtkCCFlH/pnpapvum8UMP1DYvcgnHHB+B8C
 1qKyjFXippKyVTyJT2/iIadQIxIjMgxxHpfJ+56clSfPP1OhhDu9wmENs
 6bJ8S/1qD3yL1KCLgkcOmIu6pEGDUnn9L6nTjsWli5gkt4fJLmemC4tSh w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="50713845"
X-IronPort-AV: E=Sophos;i="5.90,145,1643641200"; d="scan'208";a="50713845"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2022 14:59:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiZaOr1JBO07pddL245dtjQrD9UmQjnrTGhqlmVPy3DlepIWuPZy5fmcUpd6/sdpVBpH0KE6/HyMfIHoYGyzfTj87yctNWdDwdBlbg5RcQMa6juo3omGJ5MHVfyba2wZMzhhI9kh2s9DtQF82M1KisPIHPI1rWp328VLj8OWX+68Q/5bqkbgqLemFJA4Qez65s9NfINya9mFN0UN08rZSd7+M9kEJumkJaWg5ku0D0Sfx4w077izO4RYNXpZ22lE9Gw7sg6hiAtOTddhE814KD8EsjryZfd9jMTbhIAueqnY6uYe86ntX8ReIqhX7NYMe9nOFu8JH1gk18J4TgGvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er15Arcz3w5YZGMWoGjBUMB+MK5Hbbpn6cqtIvyUqI0=;
 b=CYn3sYngPe3raxut6Kg4vqAX3YQj7TnWyqTtpRjqb3Uh+x1PME6H36dYWQCEo4qTVSo8POApFd2ow4Ut8YtyvRmW2bAI9qZ4+1+mneJ34Kk2YPvvDsRs07FmXGFafJ6NN2WLqh0BDB7+a/lMQBoB0uvfE+AI5LA7WN/hlpdgA4lybsoa6avuNyAo2gUBlIjU2+VOe42BtDOCANRG7BuGGN1TTmNbdhnCJAs4rq/t1kk9eNrppGew8lx8st42lV9KPYQyf79yRQQvSFVk6NjruVDg/Ez/EEV8s4VMVQTNjF5EwteB3cd4kg+3ziHIP+OJkk9SPtfeEXy0kSqq+a4yXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er15Arcz3w5YZGMWoGjBUMB+MK5Hbbpn6cqtIvyUqI0=;
 b=d5c2Jr59O4HNQUs7/uZM2IpSgY8XYaOWS9ltGDx1bLVMFpSzWmJnb6kcnonor7RWdfp0XLutJS/csyYRnpfVrxCKu9XkhUSocAWk8zRzA3RLLM1QMkBtRq+I8JH/876Qf+o6/sqe+YkCXnHmo36v2BGn/vwvj+o47S+xx4Et+Ds=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB8272.jpnprd01.prod.outlook.com (2603:1096:604:1a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 05:59:15 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::38aa:3980:b578:98b2]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::38aa:3980:b578:98b2%5]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 05:59:15 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 3/7] lib/tst_safe_pidfd: Add SAFE_PIDFD_OPEN
 macro
Thread-Index: AQHYJ8f9VyVJC3ucM0Wh+P9Sj/iB7KyhIu2AgAEsgICAAiJkAIAFobcA
Date: Tue, 1 Mar 2022 05:59:15 +0000
Message-ID: <621DB650.2020606@fujitsu.com>
References: <1645519272-2733-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645519272-2733-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YhY2fZlfhv++XkMh@yuki> <62173291.3040704@fujitsu.com>
 <Yhj86k9U46vmGnm9@yuki>
In-Reply-To: <Yhj86k9U46vmGnm9@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e54068fa-6f29-4f60-f0e1-08d9fb489e13
x-ms-traffictypediagnostic: OS3PR01MB8272:EE_
x-microsoft-antispam-prvs: <OS3PR01MB82727A406233C0CAB358C509FD029@OS3PR01MB8272.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6SXBnwSrypRFAngGKytFgftey86wG+u3dQsXI0JKlwxD6Z2tl6QCJI6HipHasCT15V9JJMmcsipCMOKNmW2lfcaWX0zLsiPlKUQejKMLWOZM5UIIFU4qGqLE4LekOEPchwjRUnuY5JF7gYR3nEggkd7NEbDDVwZp5XMmuTRa8f4YBJ3m469bo3fDkvSJV3hmfbqnfRyUbLb4YhpUk2uW4VMWLudqhkp9UAxV/N72BKEKf6QMyhNBRhjckkYmtiq2MMmDtZtH0+pg3xpwIp3X8s+67v/BejKn2hL2nXUVsP5r8ID1qV61IJkhoNwsi0PBV9o/fsO/U/7Y0pQeR0zPZZRpFNeaak2JrKLfULWwwu6GdO7MjZgaLaQw2k618WHgA7T/bW1fG6mI4WowxZvZ/p+e/RPoTa//dT0JONirRIK2r12NnwUm+GrAyBwB4sijWWmkbjAA4Y7bsAlZUQ5LqNhIkbN7OPZYdmPnI9yfXWMDF0vQNnyiPP9tbtmzlMsrieGHeKHd0T9lwJMcWRPvWDNDgOs8HTVz4fQ/pjiIVYP4zFdwEwBFydkT0VUzcind/Gf6ECIUBUXcuhLIfD/5T6Dfe47TljeMhJ0DJ6z9oJ02z6dtctu92X0FffhgW/8E3KMfQ8dtrpfuDxdOEEsEkBIiFoTGddSNFx495Rpo0p4xt6rtLRN0/9NtJ/RG3Nq+MiN/vlnSdkRIuBCmjdVgQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(91956017)(76116006)(36756003)(66946007)(2906002)(2616005)(66556008)(110136005)(26005)(66476007)(8676002)(508600001)(82960400001)(4326008)(64756008)(66446008)(6486002)(5660300002)(8936002)(85182001)(4744005)(71200400001)(186003)(316002)(38100700002)(87266011)(6512007)(6506007)(33656002)(86362001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?blZ1MXM4UU1hMFUyVDRzQjFDNVREZDdha1V3bTN4YThaNUFCbVRDc0FpcGRG?=
 =?gb2312?B?WW1BVkxKVDFFTDNQcTdtNTZHM042dTV2VGNlL0dGZ0k5SE81Qmw2OUg1TkFr?=
 =?gb2312?B?VUJCcGw5c1RZOTk3VDU1RUhneldCK3JqMkR5UUJoZEVyVXNwRXU1dTN2QnN1?=
 =?gb2312?B?Qko2ektFYkdVdHVRR0Q1ZENmNUZLQ2JDSEc3NEdVU3FYYWlJT0xGQUk2clpa?=
 =?gb2312?B?WldndWdoQWZoTjR0TDlaWGFycmR4THRMRVc4cEdEeW1LSmhoYkNuSVREWkJq?=
 =?gb2312?B?dnVXTTh6TnNkTjZJVTFSVDBhdW4wYTVrZGRocUNJU05HNDF1MVNCTVh0TVdy?=
 =?gb2312?B?dVAvQmd1ZXR5d0dhWDBNaVhqcU1teXdPMDh5Y1lvRVdLanNHSEprTjBkU3Ri?=
 =?gb2312?B?U2crL2pCV05memFUVEpyYms1ZHpVSnNaMC85YWNDemM3bzJmZG1MWGp2bG5F?=
 =?gb2312?B?aGFZS1dlTldSNEx1MnJrMk1nRkNGME1JaUx4bjlQeFJ4bnhsTENxaDkxaFNQ?=
 =?gb2312?B?SnRxTTVpNWpRT2NtRk9wT2NlUE0wR3ZpNTZwenEyWTdXSkY4bmJZTkhOdHVN?=
 =?gb2312?B?aklsT1VwKzByNDdnOEIzaU5KblY1aEVZc1QzS3RvWnE2aE84MVh6YlNtVlFu?=
 =?gb2312?B?THNacjAzWm1wODc5RUtCaUU0MFJiWkNnK0lyQmdOYk9KU1Bld0xrL2VzbnJt?=
 =?gb2312?B?amJHNk50WEMvdDZaWWpydFVmYng1ajRtNkRocmYzUGY4TXNIRFhWanBtOXNp?=
 =?gb2312?B?TmpzeFdDRnZtSXdUT1pTd3V3OC9TUm5lVFVKb01iZkk3UzVidlRwUytZbXRk?=
 =?gb2312?B?N2JtR05qVTRCdm1JNXMvQWVoTFk3Mk9VcUJQZTRJejNWdWlKU1dQMWhqWUlU?=
 =?gb2312?B?ZS9QZnRtNis0RTFjZTZCeXNnZndPNXdzdU9RcVVMekwzdHVrM3hRWTU5WURV?=
 =?gb2312?B?VkdhalVPdExvQlljVmVnMG5lbXlrdFpmc3krd0RpbkVCbld0QU9id0lzekth?=
 =?gb2312?B?UWtad2VIY0wyLzY5c3QxazNQTGtMUWlDdjR4UlJRLzdGMUxvWkxGcFBoN3B5?=
 =?gb2312?B?RzllaUlEcVF4WENqRUpJNURrZTdwT0JaNGVzc2ZiZjM2S255NDFjQmJZQy9y?=
 =?gb2312?B?L0c4QytxUlJzMTQrYzNRVEtrS0p0eXdNQkl0YUxtSjJOSGdVTXE1MzUwR211?=
 =?gb2312?B?UTduMmErR0ZuMjB1WTkxNjBrUGVmWnl0NXNFeGxaV1RDcnltUmpTNnVIUDJZ?=
 =?gb2312?B?WEhPbmpLMitKQWNXRUV6OHdySk5RUy9iNERtRlIzOUg0TlM4Tm9NQ1pYNVdY?=
 =?gb2312?B?M2Mra2ltejA5Y2dEcU9STFozaEZZNFlabSt5OUxyNlYyUEQydUdpTmp4SjlL?=
 =?gb2312?B?VjBTS1RhdUFrdklRRzhYeVRrOGQ5eE9obmM0cUV2aDIxaVNTaFN6TlZPZGtQ?=
 =?gb2312?B?eXdUdGVSMTh6ZHhuV2Q2emVoVzdaL3dKTUJYUUx0SnNibm9EZWJEazJhajlp?=
 =?gb2312?B?ajFuSXlUSHprNW8xQXcza0FRaGx2R2RwcmtLTDRlWGZ4eVNDNUdyQyt5MFZq?=
 =?gb2312?B?ZjIrWG4yWHpEbHZrS2h2WGtXR1VVTkgweGdObVJEOWl3YXUzRDYxOWM5RTc0?=
 =?gb2312?B?R2JqMmg4ZXllNUxnOXRzZjFhYlNWOU9TVHQyL1dMT1IrVFU0UGFaczRCNFcr?=
 =?gb2312?B?b2hjMFc3QzkxNjVnMUJFdWYyN002M0ZONXU3V0JuWHQ0MDFZYm5ySFpKUkJZ?=
 =?gb2312?B?TUhRdDVoYmRiTkh0ejJ5YytIZ3NpWUVYeTdQeVF5TENPL2JqLzcyd2NkK2RS?=
 =?gb2312?B?cEZyVXdQamptQ2pvdi9LbzVuMDE3WDNPZ1Fzaml3VEdsb2kxdzBSKzZTU3FR?=
 =?gb2312?B?MWR0NGxQREh6RnkxbWJCbXo2QUFFT0o3RHN2UXlkZ0tpMk9JWDJ1Q2FHcU44?=
 =?gb2312?B?RTNMK2xYYmt2ZjNFb0FsUzlZRWprTVlKTk5BaGUrUEVucklyNnJ5a1hoQWlm?=
 =?gb2312?B?S0IxcWdlVFI2YmFTSnN0amlKVWFXaDc1Ym9Fc2phUU1TU2F3aDRoMUU4bHJU?=
 =?gb2312?B?S1k3UzkyTUZLZHFUOXlENjdQLzVwVC9RaVkxeFBlcVV2REVvUkRVcFd1KzFU?=
 =?gb2312?B?cmp5QVVjRWF0aldwR29ia0xWbXVuWWRWWEdwVTVLVWh1S05GcXcwT3VlUi9s?=
 =?gb2312?B?aEVBYjhiNXl3bkVMOWllcE9YdEpZL2k0YkFENTR0RHNkZExJUnMzNCtzQ2Jy?=
 =?gb2312?Q?xGh2SdH+ZJyOmlA0h0XR3WwQ4MbyaPBlzRjNn2RB1c=3D?=
Content-ID: <5390A90515C5784C8990BD37581F14A2@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54068fa-6f29-4f60-f0e1-08d9fb489e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 05:59:15.7334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HiFop1yhy7bbM+oXeoc3fCsk0J/FxgiRXdObxxK46d3Q9Zc6GM3cN8x1yXLprmDsXYLxOgo4TClGfh/Fj3/7Uyo30olmbOGPybhuAOXOxsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8272
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/7] lib/tst_safe_pidfd: Add SAFE_PIDFD_OPEN
 macro
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

Hi Cyril,Petr

I merged this patchset, thanks for your review.

Best Regards
Yang Xu
> Hi!
>> Just avoid a big tst_safe_macros.h like tst_safe_sysv_ipc.h does.
>> Also the pidfd related syscalls seems no libc wrapper.
>>
>> Based on the above two points, I started a new header. Also if you want
>> to merge it into tst_safe_macros.h, I will do(I don't have objection to
>> add this into tst_safe_macros.h ).
>
> I would have just added the definitions to the tst_safe_macros.h, but
> it's not a big deal.
>
> Otherwise the actuall code looks good, with the header merged to tst_safe_macros.h:
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
