Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA92FC6FA82
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 01:55:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7D8D3CADE6
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 03:55:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A1F43C1B85
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 03:55:35 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BC6951400752
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 03:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1664157334; x=1695693334;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=R1QHmVSIJfTy9V7pkFoQJ/oICeO4xs3KgOt05+XTCYM=;
 b=IBhJw8imycyxaVQ+HbDZ4eqMJ1U914r7ZiZ/W9d82UusEVHst1+goEBw
 Ph/dbbGYhXJ6qexD2XV+50V9AyJeUzxAnlnW3T/BLhbzlVHiZZ5s+CwW9
 8SEu99vrgOEhhPwD8yG/u6EhimzSlW1dGxgKASL048RSFHoeTb3x1JHxX
 0vfm8m5mKWdY/nue2YzzsIm4nX3sGtQ9dAbC5e7omIfafLr1T0Cmjsr0O
 GZFl0bjwCRN5KGF/bBgrMTYZlJS22NnBi0zJNBy0jsSQgrgCd/G5tcrOd
 B/K8Z8B93hhXWhIrt0mkmCeTmXdrTZJnnb90ojEQsfeaWqgZVuk1AMyLb g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="65881924"
X-IronPort-AV: E=Sophos;i="5.93,345,1654527600"; d="scan'208";a="65881924"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2022 10:55:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMUKAygA76fVk5tycYuXAw1I4n9GtlxHTko7mPiMQnQ7rK2Nv0dV51q6Vem+6fkqpPxCdbs/Xp0UrEVC3WmQ89nZLNluzMsnvmh6++4xJdl/wVrhKsMRc+N+buP/SAKCMx+3u8iiTPzZstNllJmgFyXzRuLnVTLROgSM2Z03Ssy0NfTNWAxywFbcSoIS5mTGBbabR3+x/zaMaW6Hn6KPU8pB5YoCDj2Rp0mddxi+xANWxyFy9J80tVkeH6ecP43HuLm9Vh7iGEHRs+gHrTQcIHEnolFTOs/3kw5xQzuuk8fhTazZclzLkDAFqDUJmoOw3Bkar14XFER/MJe8HgI9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1QHmVSIJfTy9V7pkFoQJ/oICeO4xs3KgOt05+XTCYM=;
 b=IWjHnDvd1lzwYT51XRlF4qRGNnNNqXRX9Tl8eHzQlhd9TTH0Qp2xjM0OAzfR/szqEoAFi5J6jME6VHNpbBFAl8wDNeVVXF0ok4cY6V8BB62WVsPEZX2kw5FKmhLrGII6D5C3jpfpG+f7n2VaUzg74MPrp1nCmC2sXgHTCdX5oS6GJEB5rtAp7nawR7BhR1h9MPBW/oBmCzLHFRNR2v8vRMd8jkDBbY4VKtV6qNdrCFAaWXL2cL2/oeow1FUeHUZmlXKkWM9MaetYQzFYLQq0H41XIh4Q/kgKrhN0uzVTeVrF14ampyHg37hfLDgNBNhA6cxCsnv4ksv/0IzrOhFa0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB7985.jpnprd01.prod.outlook.com (2603:1096:604:1b9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 01:55:28 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 01:55:28 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Christian Brauner <brauner@kernel.org>, Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH v4 3/3] syscalls/openat: Add new regression test when
 using open(O_TMPFILE) under umask
Thread-Index: AQHYyAlViPga5eQsB0uSM8Tbg4syU63rMVSAgAAUR/D///V0gIABoySAgAQ44IA=
Date: Mon, 26 Sep 2022 01:55:27 +0000
Message-ID: <1a7955bb-5c22-4746-eaf5-597c00c4064c@fujitsu.com>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1663143142-2283-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YywiZckfyJIk1/Pf@yuki>
 <TY2PR01MB442734C41B2B574CF05B8AE1FD4E9@TY2PR01MB4427.jpnprd01.prod.outlook.com>
 <Yywqj0orkajkDZt5@rei> <20220923102753.4vu6id33obfi34qa@wittgenstein>
In-Reply-To: <20220923102753.4vu6id33obfi34qa@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OSZPR01MB7985:EE_
x-ms-office365-filtering-correlation-id: 42b6b6c7-e59d-4802-f607-08da9f622f92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YrNcngPxzAHg9pQsvZt3hCgkUR9ziTFNnOb75qGBqVwB6P+mWf+IdCeY7PkBnHzqQPKniiiSAuNK+mIZtPFF/DEyNf7m9a52x3u8us/kwbGh3CsJMprMCFHrvcQ4f/ff145vXPP5erPacdKiGBCX4MMKweQlih+y9DEJReHIxDx52mst3Gt072cQT7XyATvDL1EUa6Dm5/6iYkNXp0c5touYNlVKf5tBfGwsTTfoOt00XHoBBaZzC/zOfEdu1gbXH66AVa4Gsj7RIhSSP/iLp9Avp1CtB29YexAXCrfmcQL/Ot066BMuKQzprIUpMO8j7iiA37OAnPTiLmqwlzrXmDswZnlpscSak3X+MJle4rIf5+O6sTtcsHtVQbs/s61Afr8pwAgUEGkdJtI+v/U03u0V6ubDDa0f8LgvuitatDUHEoWC9wVMPmJ1Hg1RaY8W6bJycObiKQbL57sBx2OT8EbVW5uFfy90dAFhNa8Jqb+IPUEoPCr+DcfeHGnpa/VLiVqnPEKRDLRhyE1B3RZBlMW39/RlTdeJwp2RumaGPK45kkhc0ne97ov2K924x8GuPa9Q7lkEx21HP7lstE5Qe0ipqoxYURuSZMAvdtTn1TKS2r0eTBmipvMl1SPtPCAFTg8LAyn12uFyUE3bGiPtmzF3pjxzEZLtbaVi+teZL2c5ebRyI1AZ6bNUN8aNKFPhT7AkqxUyxJXAKgdG1qA17zHPfAW0L3LogI5q2qE5cRt+4Y/+0zU5GIfeDT71AFxpPpNnq9a0yU9hgG43sI+lWtdBzb60uLbBXF1PSytRDu1kyQvCtrzEuI71ylhlHdRnLzISELBpNh5fuMoN38R3PXVQg55QLXSw4XoSc1TQk1ztYqZ6pEFe7Njms9ydU9mpSVvr+YWMhdTLB4lGL8Fx9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199015)(1590799012)(82960400001)(31696002)(86362001)(38100700002)(85182001)(36756003)(31686004)(122000001)(38070700005)(2906002)(186003)(2616005)(6512007)(5660300002)(26005)(6486002)(966005)(41300700001)(478600001)(71200400001)(6506007)(83380400001)(1580799009)(110136005)(316002)(76116006)(64756008)(91956017)(8676002)(4326008)(66446008)(8936002)(66946007)(66556008)(66476007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVVNdDd6Y3lHVWdqckMvU0lzaFdlZUt2S0Z5MlljemxGamhIcU82SHBJcWpH?=
 =?utf-8?B?NEc0VjRzNUpOR2NhVzZlVzZhNlk1am1JWVNhbVJFQ1J3Z3ppZWRCTUtFZlVE?=
 =?utf-8?B?M1Y3Z3dsWW5ac0EyMTl4M3NobWJWK2Eybm5hcGFNcGRuWDlzRDl3TlRzRFpO?=
 =?utf-8?B?QXg1a3Y2b1ZvQnRBdHEwS2RlZ3N0TEEwREczbXk5RG5BaEk2UWNYdFQ3bm9n?=
 =?utf-8?B?TDFncFQwWHQzZ2RJNmJCd0owcjdpQzRvLzNVSG50SExIeEY3clRXaHRGejZv?=
 =?utf-8?B?dytwSEhZZUxITlRKdTloVlcyRThpdkpLbERtdkpIKzVXZDJRRGRSQk9tbGwr?=
 =?utf-8?B?RmlzTjEvcUtQTUNwQW9FSDhkUVdsU0JLcDVpbjBDSW8yalg1cGMxZVBiU1pY?=
 =?utf-8?B?VXpxNkVISzVzQjZ1TDczSDJPU3hWNm5QV1c0SVovYW5vZm8wZU5HUThvV3NG?=
 =?utf-8?B?NkQrMFRrWGVuK3ZwRzNqTWdrYmRhWHJYSkNLN1lrUkR4bXZtMnNCeksxQS9D?=
 =?utf-8?B?bTVIQ3NXakl1YnlqQ29wU1JqUTZCZUpaVGtoR1Bwd2NqSWx3K0pISVFQTWpU?=
 =?utf-8?B?aTVGTlgxRmk3YzdjdjNxSWMwMUhGU1paUk9ZRHVvdTlqa0pYNzA1UFhicXEy?=
 =?utf-8?B?bzdSN3MzUmg3Z29wVmVmUHhnWEx1ZGY0QS9LMVZJcUJ6RGw0YjJ6b0JKRkg2?=
 =?utf-8?B?dVdkY2h0dFNCMmsvZTVyQ0o1dnNqdWw0ZWxMNVNTTk5LOVRTM0V1UU1UNWkx?=
 =?utf-8?B?MEpBei9oaVpsSldBT0tmd0NrT2p6QlRPOWtFblJnZ2g3aHNPY0U1Z214T21E?=
 =?utf-8?B?cWtQUFdHNU9TOWpMZXJ0NkRkR3YzaWhyQ0xJVXJzeG9lWEVrR0htVGdWUkRP?=
 =?utf-8?B?UzdEd2pWSGpZYXRZTVVCNDNUV0RHNU1RdXEwZmhubjUrQ0ZOZlVHUXpjUUM1?=
 =?utf-8?B?d2ZpeHFvRTlZRnNpYTYxV29UYjNNSkNYK2FUQmtCeGxZVU5iNnErSjZtZEpB?=
 =?utf-8?B?Nk84NjhHT2M1VzlZVDg3N3lGOGtMaEhLZW1oRi94bk54aG1tUnlHblNRUTVJ?=
 =?utf-8?B?TmNLYlkweGVTNTNZZXJFOVVXOVROZUtockd3V0JyN0JlSnJIYnBwZHZaSlZT?=
 =?utf-8?B?S01ib1BiczNTUUczeXJxM0I2dVJHSWhEOFd4U1BHekNFMVhtc1dOQ3Z3VGs5?=
 =?utf-8?B?cXVPNUtZVVNqUUJGUndUU1JiR2FlMjZPMGs0djdwZjJLRVZKM3QvRm10ZGRE?=
 =?utf-8?B?WllqZnZLYlJJQm4vLzV4VEVSTlBTUkc0NlpuRTJDb1Vlek1EZnd2aEl0S0Vq?=
 =?utf-8?B?VjZjUlM2eTFBc2Z4UU1rbEdqZVNoQWJtM3FIQXJDdkFwNm82ZE9wT1dLNndM?=
 =?utf-8?B?bDlhMWJFbW9yREwvMFFDQnhZWG1yQW1kZUZwUk0vSS9TNHl4OGE2SEd0OUtF?=
 =?utf-8?B?K2NGYXh1REFiTjhzQnZDeUJVK2pxc1R2cDd6WnpaNkUrdVNVcW5oazloTWhH?=
 =?utf-8?B?RkpET0pRU0FoTkx3UXVJelBHT3lKUUJNbUxlUmpLcVNWaFExbXF2QXpWOGdQ?=
 =?utf-8?B?MmZ1VTFTQmoxK2d0d2dSWXkyZEJWYUhyVFlDU2tEMWxtZzZWR3B5ZGlBK1pW?=
 =?utf-8?B?TXNVU05qL0VnVG5TdUJHaGc2bDR5NEZTaGswdmdCM1ZuZnd2YzlDUU5oZCtC?=
 =?utf-8?B?Sk9WZC9WTTFhalZRV1hIZVVHRzRLQnVnenhXVXhtQXpnQ09tY0lVblJrampR?=
 =?utf-8?B?THBNVWVLa21OK0tFMDV2UStwdmR0WW1JN3pRekJFanFpTUpNRUE5NC9PalJo?=
 =?utf-8?B?V3o4bGVzaVFOWW9qS2hRbzdzOXloMm5MTlE5VDhmRm1UMHNWdkZIckZFajU3?=
 =?utf-8?B?VEdMYkgvaXpvTEh1Q3hzdlV4SU1MUnhFWGlqZnlHRjhnWVBmRUFSK3dPaEJG?=
 =?utf-8?B?UnZMK1pabTE1Wi9yTjFaVnh1a3VzSk5zWjNpU0xzSXNrVnZYQmVBMU1yVXVy?=
 =?utf-8?B?TkpUZEVGL09ldURyZ3VOMFRqUGZFZXVJTndQTWcrRHh0RFAyWXdSR2t6OHFU?=
 =?utf-8?B?ZGlkU2NLQXJ2emhOUE9MYXpRRFpyWU9Ga1BHUXVJaWZCM0Z5SHoyWCs2SzhR?=
 =?utf-8?B?cm5SMGZhNzZ0QkpISnczd2tkWmFZeXIrQnUyWlB3TTB2d0NGZHErRDNQWG1J?=
 =?utf-8?B?SkE9PQ==?=
Content-ID: <3C019B47EE68454CA1FA7B6C40A05965@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b6b6c7-e59d-4802-f607-08da9f622f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 01:55:27.9493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPPoQDnhuRFZUiigRv7JRyLK7pFLmtUXgI3Y6n0rZS9vwL+DWUHPdarzZ9d5dc/lf317BEf2c6ismjz+dZEpK9kt62Lkoz6vRhC7AU6td1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7985
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/3] syscalls/openat: Add new regression test
 when using open(O_TMPFILE) under umask
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

Hi Christian

> On Thu, Sep 22, 2022 at 11:27:43AM +0200, Cyril Hrubis wrote:
>> Hi!
>>>> And this one is probably missing some kernel commit tags too, since the only that that is attached is supposedly in 5.19 but the test still fails.
>>>
>>>> I supposed that we should add the 426b4ca2d6a5 to the test tags here as well, right?
>>>
>>> Yes, BTW,  I usually use git tag --contains command, so I know this kernel fix is belong to 6.0.
>>>
>>> git tag --contains ac6800e27
>>> v6.0-rc1
>>> v6.0-rc2
>>
>> Now I'm confused, if I do git describe ac6800e27 it says that it's a
>> second commit on the top of 5.19-rc7. So shouldn't the the git tag
>> --contains report 5.19-rc8 and newer? What do I miss?
> 
> So, ac6800e279a2 ("fs: Add missing umask strip in vfs_tmpfile") has been
> backported to kernels since before the dawn of time. But the the all the
> pieces that move setgid handling out of individual filesystems and into
> the vfs proper are only >= v6.0-rc1.

I search the commit mesage in the following url,but not find c6800e279a2 
commit

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?h=v5.19

@Cyril
I guess git describe ac6800e2 will serach the commit id because it is 
merge request"Merge tag 'fs.setgid.v6.0' of 
git://git.kernel.org/pub/scm/linux/kerne/git/brauner/linux"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=426b4ca2d6a5

then it will serach brauner linux fs.setgid. branch
see the following url
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=fs.setgid

so git describe ac6800e27 it says that it's a second commit on the top 
of 5.19-rc7.


Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
