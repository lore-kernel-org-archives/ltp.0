Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36618C43334
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 03:57:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A1983CA557
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 05:57:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83BE33CA4A5
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 05:56:51 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 467B82003A9
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 05:56:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657511810; x=1689047810;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=fhX1XhSunKE2Uc5Ju1y0OekbYZkuJ411GrQdby+yqjw=;
 b=rjZ3Ftl3RsL+BhzbnCSHAMVPVKrU6y6S3oUZ0SlyCeYAcwhyzHBHWzEh
 MMJBrH3pm1dLejTJMcFrkhKXrajOz9Gdq464DnwthldWIzCPCURfBJXMg
 i4qgDipi8ZE2qTsNWYEpZ9lqxh07NNmCSfCNEFVwsylQV9TzZSxpVRqu7
 E5Qa2xcMwGcKCKiq75n38ey5NR8OGnrKlWEhkLvKOTfnxStzoY28qV8Oy
 pnuE9axdAC2UUhelVQaqsklDY4N7r0QXg1YMcKy3QsE9agcSCoCnG7DoU
 GS9EXFZGfKbs2Ay9Tx0DAD2CT2WJjBGFxdwQazUox9qLbhR8bYWl1MwJ6 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="60194785"
X-IronPort-AV: E=Sophos;i="5.92,262,1650898800"; d="scan'208";a="60194785"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2022 12:56:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XitufVRH3riDz9f3InJLQQ8asGrsrxsqNP6UiLN7xsoVV/9yY8DMDZeiIL1/7FJU5pTyJx73ruDKh7Q1zFxANBf00CUSjfaYOT+mI373GHvqFadx+bMs9jstKIf8RgGOM79E3haOdfnyyb9PrUB/RJgcbSd16YyfO9B/B2NsrA8Ayybp/s4kEUtAGxsMNlTl9xBXush6XApahf4lfjR5cZ60o6fVb3CUZew0G3eyqLMS3CqLapjwfsidxg7b3quA4jLaXIQX3LKUnh1F1CHsDoB28GTCZ3f56AdH+H+tiArMEKKhXNCAJT9RKFo7soyY46IVr5o3PoelP6DfobzqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhX1XhSunKE2Uc5Ju1y0OekbYZkuJ411GrQdby+yqjw=;
 b=M+veJEf49yNQu9fMEvm1nhkVZDz8qmRa8kCEswznLZepIlWsrFgHP6uh5Q8zqKFeHKPbMa0PSeoTyNvyIOPmjIwtRJ9GJgv3tL64vCi6viYqLe2H1G5x1UzI8jqorKmoAQgH4wCmz4nszZzhinXvHMTlkxDzHFo+m8qwbgEStjjpP3PuyHPDRd1pTSIPxweFCCVbzt4KlHG4k954A0Sq2ycNJ75WwsHC6r9+TuyvU2PGSJ3YPOiz59hA2bLxlRigto0xo+XkHmx8do1qyn80/bjHdOUulV4JNPboKhbJ6AgsaW2AU4xbIUjaiXn4A8QRQJFSfjqP3H6qqRE+j8AOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhX1XhSunKE2Uc5Ju1y0OekbYZkuJ411GrQdby+yqjw=;
 b=WrP8xEuWIywWQ4cXpPkyGaS2aB52xZJvrRku2RFwvzDisztkeUgJVzJy6dZukd375U4O81ZskgQuVp64B6x38QfwgnXSA+poUaGF7iyne7QAh0NvFsqr12TKZvoW6sMd5Ch3SL7MvPMvV0avDX05iNvrIMZkdPw0jRZoJOySWbc=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB6790.jpnprd01.prod.outlook.com (2603:1096:604:115::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 03:56:43 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 03:56:43 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Christian Brauner <brauner@kernel.org>, Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [RFC PATCH 1/1] creat09: Fix on more restrictive umask
Thread-Index: AQHYN9eJWCFPwI5fE0G2efRMRz6TPa1x2XsAgAIOyQCAAViLAIAEFOeA
Date: Mon, 11 Jul 2022 03:56:42 +0000
Message-ID: <ac43aa6e-5c1e-c453-dcfa-1db1770e1971@fujitsu.com>
References: <20220314191234.12382-1-pvorel@suse.cz>
 <62C5663C.2060009@fujitsu.com> <YscgIvZauxbArm7i@pevik>
 <20220708143728.r655waixwr3x7xtg@wittgenstein>
In-Reply-To: <20220708143728.r655waixwr3x7xtg@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 741633f0-dfdb-4c8a-9180-08da62f15e03
x-ms-traffictypediagnostic: OS3PR01MB6790:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mIX1EB72sLWw/XbqDfvy8YUaJ03bxbn8U42OHMSb0FTyJikLYLfaBMhRjT4sY/sSiFsWdezyukCJ+ctJ520krbLytR3sCjTj0QlQ2Zr3jN4WfEcd+0qD8jv7vkTpP58XmDmmkKpBSlYl/H4WuDigzfjRIBVrC0f/ry4/x2xYwFnQxnOABqy3b5iWKhSp61Vi02hzOR9TitZw5kK8G2Lv1aTVrbStnVOUKjNdoEt7W7kciZ8NvT9Ze+IXQ+vlLDgOBtNeRF0Q69dENDiZ0+vKoinI1oQULcqQnxullNQEncwno0P2s17r/WuRyBcz7tTwRNELCo9yhbHyP+2kLgp1ZcbRa0DaNebjzf49ecKPVDPmD55p8CQ93mom2XBPpLICivDByUpjbAX7igHmvFA3HJbzalyMP6X67M0w3k+sKRosIrEUjNxt/hcld3+7RHiw/1hSi8qsKjQ7EyTO/ggxp81kW3eo9zXLuw6bjI8KJipyLUYcFMahG4U4W6Nx/Xwo4eDBn+5ww7DdkHJpvkbfvg2QFaVW3f1IIAJn0sMdSdLHcILIDJ6cjDEbPnCCsnKPssGVkZHKEoP3TAhA05tBMAsxv4mY99Cq2mSTfn4TXaYH2qgVw/zEH+TGHH+6UeWYBTJp2wO8FuNPzfqnFGjfuO6/3+SX8h40vM0bplzNJsHxzAzr21BZqI3lT1KzjgXiQRCxM02hctQl9L20LIwDqSG/AXyGhMYb7nD6yte9oyOD9nmmPnxGhiZG/Sp+ZFqFVAW/d7rMsVQvjylGOSJiXp58wMYsLwYu7AyN5GwMQDcD8DCNzY0EqoJi91UAbydLgtCXYJXGVbItwUKePnM22z/rd5eYX8kti4+l+gnMx48=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(6506007)(316002)(71200400001)(38070700005)(41300700001)(83380400001)(4326008)(38100700002)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6512007)(82960400001)(91956017)(31686004)(26005)(186003)(4744005)(6486002)(478600001)(2906002)(86362001)(31696002)(122000001)(2616005)(110136005)(5660300002)(85182001)(36756003)(54906003)(8936002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlJNNXU0REtxU2oxUU9jVC9POUVtcGdMdWV1NGtVY0cxOXNTV045a0RJQURr?=
 =?utf-8?B?d0pwYlN1ZHU4eEJRWldZTU5aSzlOdEVuMzI0WDhRdWFOYUcrNnFTdzI1Q2NH?=
 =?utf-8?B?a25SRmdROUFlMUcydFRaZElPbVZUbHBOeEZ0VmJESllsamRWRTJpUlJaNTY1?=
 =?utf-8?B?Yk8zWW1DcTJ2aDFQa01mZDNOU0wvYmJubU8zeGYxZS9qRnd5ZmJsQWZmMjFO?=
 =?utf-8?B?SWdhUGFMUEV1bmRyajZPdXo5a0lObTE2T1NHZlJVVWJCQ0ljdUZnNGYraXZi?=
 =?utf-8?B?N3Qrbmgzc0JtZU5Vdnd3NXRDUUtZeTRLWEJUT1lmL21xQnlqNlRIOFdzZk1z?=
 =?utf-8?B?N3ZUVmNpM3lhMU9QRHVKaWtKNFFFUzFBaVc3VEJkUWcrSXJaV24xZnlkSUxU?=
 =?utf-8?B?TG5ocjhPYXUxVkg0MEJMazBKcnlKTHNSbTJqdFJVUzBWdzI2dHNWVlNGVUJy?=
 =?utf-8?B?S3N0bDVJcTV0UmFTaHFtOWZsaHQ0ME9NTkNodGlYc0ppMzg0Z0tQQnJ0Ujln?=
 =?utf-8?B?SmIvZnBmTmlBNjNEY2ozdVBKTEY2aUE0dU5xbHFrSnR2T1h6WVh6UHJOZWYz?=
 =?utf-8?B?ZUcxYThaaHVKQkwzMDZ3aDFKL3FLQmVNb0VMcjh2Tm9ENHY4RFlJRTRIdDhv?=
 =?utf-8?B?Tnk0cEkrK2N4NEc2SHJFOWdGODVxQ2NQWXdOTjdpVFFtdHhQSHpJWlBrc2xy?=
 =?utf-8?B?UmQ3U0RVR1ZKTy9sZjlpa2JzU2pDWEhkQ05PTVRWQ2xuSkp3UkwycDBNdER0?=
 =?utf-8?B?TzcrSS9seFNJdEU5MUNVT2JGNy9LWkFKdnFLa1N3aHBEUlpmZDZOSFQwZEND?=
 =?utf-8?B?dmIwTnFkbUpDUUhiMllNRTU4ZDFxOGFveWkwTDloMWNLT3Y1NThZK0d2Nnhy?=
 =?utf-8?B?V2hYZFptTThXRjBYL3NJZHhjaFRrVjhZYmRIb2pNZlRsWnFucGZmclZRakJO?=
 =?utf-8?B?b3Y1eHh5Mk9SUmwwb1NRYXhrSlMvZEFTSmJSb0hFRDNKbWMxR1dMUVhra1Q1?=
 =?utf-8?B?YmlIT2hwME1VYXJDN0lnOEhpUGNQUjZ2cTlSVjloUitjdk54Z09rcXJWaUxK?=
 =?utf-8?B?VnhmUFI5bENSVkcvd1JDV3czYUlNNDlCRnF6d29PaGFpZStDS05rYlM3eWVp?=
 =?utf-8?B?TTdKMlFBSndzeXZ4NVh0RjVZN2xIazNoMkJ1a1JHUnJ3c1lTNEQ3WmUwMTgr?=
 =?utf-8?B?MyttOGF0UDBGdW5md2YrN0tQa2RyMTZ6cDdKektpYk1jMzJZQ2o2S3pLRXA4?=
 =?utf-8?B?ZzdWeCtocExqa0NlSzhIckh0RHFWbDFteUE4VWhHSzhFdTE0cG1nZGJJbXJi?=
 =?utf-8?B?Sm12RnM2K3FxMUhWL1g4aWZXVGRyUnZJM0YyRm5MNXRBNjlxVXBEa0UvVkJ2?=
 =?utf-8?B?U2VBK1pDWFdqNWpXTUFyM1ZHcU1zS1o4UXFmOWJneUo1bzh6ZjlSMWZjRU1p?=
 =?utf-8?B?T3RtSUR4ejBRTVJUL3FkeitPVVJKTEZ2NllKT2JUOGF1NlVNS0lvS1lIVHdq?=
 =?utf-8?B?TlpkMms0cUhNY01YU3BMMVhBS1U0bC9neXJKMENyMEdWS1NBVGpVdVg2Y2RJ?=
 =?utf-8?B?cmJxd3MvYXlLZWppU3lQWE5tWFVUSTRlc2xaMWw4aUNtME91ZzdpV2E2NWNC?=
 =?utf-8?B?czlMcnRlK0JQQUJMa1Q3LzEzQ2p6bE5PMTkwZmpsd2g2dHdsd2ZQZHdGZllQ?=
 =?utf-8?B?aS9xd1VmeXYzdFZXMTNhalEwR2xBcVNYV3BlWS9oakxBdzVuemtsTXN4K1l2?=
 =?utf-8?B?YmdMOEFDaTZNUkU3d2pMK0xUUDRWejdGN0VmVERKVnZWRVpwd0pQbjVHMXpN?=
 =?utf-8?B?L2wvT0c4eGp2b1A3TEp5UC9PTFdkNjM2cUxSOHpLczBtVitPZzk0S1VqV1Jr?=
 =?utf-8?B?eFpHb3ArL2Zyd0xYSzQrSVU2RVZHbndIUWdiaXRrUmtSWkVtWmpkSmx4ZGxP?=
 =?utf-8?B?MkJ5ZWRBQkxSQmFUVDZoeGxSWFFUTmVTVFZVamg5L2RhY2pSTnVNdkRiNmR3?=
 =?utf-8?B?WGZMRjNpR1JxcHFqQ3pVTlRtOTJGdzhSc2tJTWZoTlpKTDlwUWd1RUlqcVJw?=
 =?utf-8?B?OGEySFAxUmFrSDFWdEhsOHJzWEdBdlRoR29EZFAyUkQvM1U2REJZbzRWZHBF?=
 =?utf-8?B?OE1MQzdvY1pqSGZsdDVBZDhkZHQvbVg2SXE3cU5DTWVGWUExV1dWLzRCN0VZ?=
 =?utf-8?B?a2c9PQ==?=
Content-ID: <DAD683C058B9854F8C095CC99B714E8F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741633f0-dfdb-4c8a-9180-08da62f15e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 03:56:42.9654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ro41U3hFIqE6TqlUjB1/i5dqcua9J5k+iif84dX/S7VZ8EiHD2ZPd8DPk5ofKFOQjoVEc+jeCaPkrjG+ph/P1O5LGp7FsPtahlAz45AdvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6790
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] creat09: Fix on more restrictive umask
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

on 2022/07/08 22:37, Christian Brauner wrote:
> On Thu, Jul 07, 2022 at 08:04:18PM +0200, Petr Vorel wrote:
>> Hi Xu,
>>
>>> Hi Petr
>>
>>> Share some process with you...
>>
>>> I have rejected this patch and a kernel patchset[1] is plan to fix this
>>> but doesn't merged to upstream kernel due to none continue to review
>>> this(It is about one month since v9...)
>>
>>> TBH, this case only tests simple creat file with open but miss
>>> open with O_TMPFILE[2]
>>> mknodat[3]
>>
>>> setgid strip logic is not only affected by umask but also include acl
>>> operations[4].
>>
>> Thanks a lot for an update.
>> Al, Christian, Amir, could you please have look on v9?
> 
> Afaict, I reviewed v9 and left comments and had pointed out things that
> needed to be changed. So I'd wait for v10 (I'm on vacation next week
> though.).

Oh, I missed that email and will think how to move logic into vfs_* as 
you suggested.

Best Regards
Yang Xu

> 
> Christian

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
