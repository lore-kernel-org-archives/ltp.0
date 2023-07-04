Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAB6EB64D9
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 10:40:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C9A83C99BB
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 12:40:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEB193C9981
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 12:40:44 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 123A61A00143
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 12:40:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1688467244; x=1720003244;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EpSTRkLvbVQNOeOeasIvltgf6uCiL8T0fdQIUPpgjEc=;
 b=iX+hCPT3AER558RReK4L3cI5hujvIIKB+oeohsXX7JvsDXyN8B2eFHln
 t0IANbcNLhIT1pEVvEKDymrmkKP9IeQ+K7S++4AsN5a1zeXwYNxIxJMcn
 ivvmbKKqW5gucwTr+qTxpojcKnZlz97IKzDtdEO2twdW+sfs5pB/7I19M
 MUZdkoMzC7Bb1ztzQNUGYYeKPiEJl5c/I6OBsBPvUkDYlbkMs57U8r+LR
 jAD0gDN7SCoQV9bwA3xM8fPYLk4dCp1f4LBib6rDx3AFjiBX+LOvoRs6/
 8T9Eg40MBVlqi4hRZlcEVh7kX7L3p0hknheljBkphIoo1L1FUbzM275/q Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="88705396"
X-IronPort-AV: E=Sophos;i="6.01,180,1684767600"; d="scan'208";a="88705396"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2023 19:40:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDb8awZJ5GMTv8NXmXSuvUSZ7Scxm5s3jF8+Amrzhx/N1JK5yVCDQCysJdpSIbnCx+9zBPEHP89VWfiLfxVkOXPdWxZKiucB0JjBVzf3N+CH43llzUGni9IRJ9KhEy/dKiJqLuHLNBUWwHX79okkmJicK5BYIyjNSOmlJ4Jbjhppig3HeZejEGB+sOHtKWwd8KTNyneEZ1JtSl0RMvz8FlFvNzFteXJm15lwjlLNj5J1z0GOvtk53KFbJUgo+F0vwVnZPtufW8/kwMh4X+g70jLYWqzP1Q7Jrcm8Lp45sbWl7V6dZ5Ge6iXVRrh9uGekAGExXCTMAxIJHdAiRsta3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpSTRkLvbVQNOeOeasIvltgf6uCiL8T0fdQIUPpgjEc=;
 b=jElz1dpmwvpT4iefGfZr1kRpvH1UB2OAMiqV6dtTNOO0CYklJzhk8fd5QaNgMugXgqCNtNKsfncCyMyARP4un+ifVDH9oulE0a0yu7p/10mJyTFEIG1Es9DIhguiKcth9ootZK3xiWHCusQCA9QPgGZ2IaXi7GppPMz2BiAcopPepY6KhpgBUe8X3rV11xNrh/tCt6cDqZJwiPBS1UavEog7ReKliwuXGCY20h9gC2qd/CohGPuw5AVl0w+tDcMk1sYod+Ox05WQPKMTcTIsvvDcIckhvdj77PWmRdUDARMdo7Jq9VwIIj/wuf/9cFu/VLWwXatQ7/ZOUjTfwjjECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by TYBPR01MB5359.jpnprd01.prod.outlook.com (2603:1096:404:801d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:40:39 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::1b2a:85dd:34c2:330a]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::1b2a:85dd:34c2:330a%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:40:39 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/2] syscalls/geteuid02: Convert into new api
Thread-Index: AQHZrVfMk/GSwb+iPE+MeS5/eZjC66+nexiAgAHyARA=
Date: Tue, 4 Jul 2023 10:40:39 +0000
Message-ID: <TYCPR01MB107129547DEF5965C53A01E9CFD2EA@TYCPR01MB10712.jpnprd01.prod.outlook.com>
References: <1688352041-4945-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1688352041-4945-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230703045739.GB363557@pevik>
In-Reply-To: <20230703045739.GB363557@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MzU0ZWY1MmYtZWYyMC00M2ViLTg0YmItNjQzMTY0YWIx?=
 =?utf-8?B?ZjIwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wNy0wNFQxMDo0MDowNFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|TYBPR01MB5359:EE_
x-ms-office365-filtering-correlation-id: 97964de9-9b3a-4a58-8bb9-08db7c7b1bdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hJpb5sEGFLCbMDgGWaUde8s2RMrDgLYkBBpgUl2LKGiqpF4OqcmaYddzbDq8bJH1acICoABw/vsqgZYLG9zfWhXGQGqwBcorsg0TX8iApZ+MQUwK+nJyNmyfFyxi0UC7mx6+bmUCiWmYewwtdCL/MmvLt353hcbc6Dtzb3NqX20iLQp8fcTuPMcaF/77cXgSQOvHi0NaQFHOHlqdxaNPjnd9dvrFN8bHtCKRwWDOGGwW3z0S9aflK71gPA9Q5RfAcpeCuZVRWk6gLtFHpXn1UjHGzXacfqwnr7zLAFmNCKIb32kMJI3KwCojP/5CnwFu4ChbB/tIqEmZCI4MGawJmuAq7EpU3THhMVMDWssuvDmJYeivpOcL1JEvx9WeRhWAM4rz/f2DXo2w+fWaGbuiXjXNjaF+LiIZWedEAS3WKkAzOqzbL7HOvWuUAukE537HldIb9+rIVvLYF/Ml/tFUrySagiq4Kv/urZ08z5fWvvjjuuwOISx1623BjloUqAOmtyjggDxBV5OMMkRD48iUfWyGkp0OQEm033IJjGOFjIIf52JFj9cNoBW3RX0NojbJYIVgHGcpEnkDzVi0CrSPkKwR+bTQImyrgtVpggCHgBu9iAzVDQ5H6TGQP3H+5dTxJ01Q6dVYr4awLM/v4AnVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(1590799018)(451199021)(38070700005)(2906002)(41300700001)(5660300002)(8676002)(8936002)(52536014)(1580799015)(33656002)(85182001)(55016003)(86362001)(186003)(82960400001)(478600001)(26005)(6506007)(71200400001)(9686003)(76116006)(7696005)(122000001)(316002)(6916009)(66446008)(4326008)(66476007)(64756008)(66946007)(66556008)(53546011)(38100700002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aU5OeG05OFE2dUVadmxtb2RiRU5HZFVNa3A0MjNkTFdkekt2K2VqZzQ5Ry94?=
 =?utf-8?B?MXpYcXpRQ2RJLzRJRlRteG16bmdha2pzWFFmWDB4eTlZUlpuY3hVTGJXWmRN?=
 =?utf-8?B?STFFQlhyN0wwZzFadVFtTnVWeWkxblZ6Z2E4UitodFZaaFN6ZE9ueFdRZS9w?=
 =?utf-8?B?UHc5SDVPaFpUUFVzWWlyRXoyZ0U0eUR5cUtmWTdPb3EwNUFyM0hDby94cVdI?=
 =?utf-8?B?RXluRHJ3ekxsTUNRZmZJTmpVemE2amNEMmNZK2hTSW9Vb21VVFByOHRoUW83?=
 =?utf-8?B?Wk1mN0IzNVNFc3N4aXVMUlk4WldvT0tSM0dDYzliTkNRNmNvbGtreWpnRlhX?=
 =?utf-8?B?UHFhSUlPN3pQYW9LdFBpTkJTeE53M2hEOUp4ZG90YmF1dEQrK3pOTzFPK005?=
 =?utf-8?B?QWpZM3ZRMCtJbVpvWWFBR2F5bW1TTEVBbkxzMHBPdk5oeEM3ZTdUdmNmWkw0?=
 =?utf-8?B?ajBVQnc2ZmRzYTc2SFZyNW9BU2VzVnQvd0dTQ2ZlTzdlSEoxUzNaMnAybGx2?=
 =?utf-8?B?YTZqRjdhWE5hNXVNa01ranhLdERsSS9RVlptZDFNZXJmbVg2ZjlDR1VKRTA0?=
 =?utf-8?B?aHVXbG4rQkp5ckhGaHRua1RNSXgzSGhHY0ZoSEM4akh3ZWVrc1U5N1IvWW5x?=
 =?utf-8?B?eFd6REdJTlR6SGtKbjlVemIybXlyMUpxa1AyQWNsMTZqYVdFV3NWbklUSWNj?=
 =?utf-8?B?S2E0NDlrM054VHZZMm1wYlpJOGVXdHkwNU9EcUZkNGxFcWVHK1hMNmhMYjd4?=
 =?utf-8?B?RjI1cGx0TzZXL1hzSEJBTFEvWjQ4NDdseFlwSnV5dEJrdXd0VVRVZHg0R3U2?=
 =?utf-8?B?NVBubE5XV0gzSms3aXFlQWFqNWxpanN1azlFdXM3bGFtcjhtUzVsTS9ZMEtp?=
 =?utf-8?B?UmZzQnVLZWU3Mncrb096bkZ6RkNaUElCOE5uT0NjUE5yTkV3L1RUVkxGZi9E?=
 =?utf-8?B?THFIMnB6eVoyLzFwNXZkUFFWUW5SL0w0SEsvTkNqK2FmdlUyUmNYOXZqbU9w?=
 =?utf-8?B?cUtCTWE3dlBsMnFOQ3djVnlPNklpZDFPU1FUdlJxcENqWDU3M3I0S1RkV1Zu?=
 =?utf-8?B?SWhZcHk5WmxiUWt0L2w3VGRBLzg2d1czUUhZT2xrUEV5WnkyMW5DbGllSWx1?=
 =?utf-8?B?cUxCaFhlKzBHSVV1SktDUVF4ODIyS1ZRTjUrUndqdWhyN01KcFVLNmZuMUxI?=
 =?utf-8?B?R1c4emFuQTVCaU9qejZhVXdKWkVOeFR6dDZuVGhieG9OL0FDdUcrR2h5SDJj?=
 =?utf-8?B?YUVUazNLeTVGQW0yWFpPb3o3ZlgvVENIVHladFp2L3lrNm5jN3hGeldPYXZx?=
 =?utf-8?B?NG1PeDlscVVHK0wvV0hRc2lhVjVNRlAxaVJRVWhldkpiOVhtbDYwUDNTUlhG?=
 =?utf-8?B?K1JOVDhMYkdPMWR3UDdDTnVvU3ViaEowUXlTT0xmQ1dyM29neGc4KzYwcCtr?=
 =?utf-8?B?YmtqRWdpWDJkZjlJV0ZoRCtGTzNZYmhIcy9QRnhxbytZNS8yUzV5SlVsdEs3?=
 =?utf-8?B?TmxiU05nYWI4SDZQYk94ZHZGQXVmTmRFd29OYVRhWnRnc2VQWFBHUU1LZ3Zv?=
 =?utf-8?B?ZmR1MTNWeU8yWDlzT3BINFdkZlZqZklmVENmT3RFNUh1cmM5dHI3ZHhCd3dm?=
 =?utf-8?B?R1NkY2orVkRlYkRIWURkbHk5c2ZoZU9ieHlqdmY5R05EUzRya0o1VzVzV05H?=
 =?utf-8?B?dGJ3RVNvSktUaXhHWngzOEtidXRQQ3FVb0tGSzBQMXl3R08ycTNPbVFFTGx4?=
 =?utf-8?B?ckMxOVphdEY2Y2JHM0hPcFN4UmVPdi9LeDk1bkF4d1dXbzJ6Wnd6WjhZRlVV?=
 =?utf-8?B?SGpJK2F3NkhubDllLzhaWHo2NWRNL3k4WXV4K2MyZFAwWlZ6MkpZOUZtcDY1?=
 =?utf-8?B?S0FWdXMwbTlPM0I5anFvMjFOSkwwSi94SjkxbTJzOFZOSnFSTVZ5OWJOYUpG?=
 =?utf-8?B?aWEwUVd4Z2ZZdlkwS2xQa2wxdXZVY0k3b0NPK1RGNDN4VkF6cWxxamUzYnkz?=
 =?utf-8?B?NEE2ZzgvUjlBU3lsK2llRXNyQ0ZtZUhuT2x1UWVjRktoMVRaaGNCSitUZkRT?=
 =?utf-8?B?SUpZVFdJanlPTkQ3S1R2VkdxUm1KY0lEUGFtbFFodW04L0plNk0rUWY1R3px?=
 =?utf-8?Q?D2lOY75HCK/B37oxZPIrj5xyc?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZL/Eg5wW/QjUlS6aC0lUjLiJTEOhmCAYmi+8iVTOpUbiqK0MU/gCPwEuhFcS1iJswKcM4qjh//UqG8ms9JqKH29SP2JV2a/UGB36DkUVLOVbA6q+5ncfUeUBAtEKCkluFTiZaxKCioeDqXU6ISxaplFa5f9lVbJoeZT4lEr1VHUnqLILXE3AAOCLmeDatFHbNPgv36+FWgXL1d0sxUwukX9vfmDvNs20ADH3MQq3VGkxx6WIhG2dYGWALTjlIXAgFjH4RS56TEw/ItnOfe1YaHZamDlGJEIFivVo+IodzsK6GeGR54GrA46zSbpEOdGO+1y18DBw/kXzJ911tVKDB7O2n1W0G98k5wy4Jse+N+1SO8WNefbsmUQO9BrJvQ3cLx0uH8RrMy+jqqfR4UjBLyEQPKD77IECfFqxTHOrxca4p3yP3JgJVWGst8uRb3U+gHivyuojrtqPwW3eHbvxCoPUfxpZod/1o0ssVDo1XdkmAv5QXm+Vv52XctMfxBSCwh1Opvhawi00ZMQZybkUgrveZAIlWxyC5kUoHz6XUE0eBE0TjpaDFJdVCDl4WqPiedsUsaZHuMn+a2CVNKJUziv9TvPNU22ymL+MyfMdC1s0s3whGHV1Kk9iXQUxvkJqbkD9a5Yg8yysr9lX5UDDi7mkU7V8n+RyiF3Z8o9Xichr3S07jRpcoKx4vbAHo/RIXr62tu2PwAYeRoD2+vCZit8bW3wSWbQzV4sf6tx63vP/bz7rku6gBMTmuVIkDqRyuwhzIBvQerAJG8wX1Qud55jIuuwZ2G7GKeTDXuFNuTw=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97964de9-9b3a-4a58-8bb9-08db7c7b1bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 10:40:39.2824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQ+F28uq3Hv6gwgSGt38raK9JmFi2QYMi8XOA86G5i1k1FYrnb45UENaqik5VTY4YT+j4XjwbVNj6WSWf+xa9y4wrFf4nhCFpyhTqhlitMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5359
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/geteuid02: Convert into new api
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwNCg0KVGhhbmtzIGZvciB5b3UgcmV2aWV3LCBtZXJnZWQgd2l0aCB5b3VyIHN1Z2dl
c3Rpb24uDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiANClNlbnQ6IE1vbmRheSwgSnVs
eSAzLCAyMDIzIDEyOjU4IFBNDQpUbzogWHUsIFlhbmcv5b6QIOadqCA8eHV5YW5nMjAxOC5qeUBm
dWppdHN1LmNvbT4NCkNjOiBsdHBAbGlzdHMubGludXguaXQNClN1YmplY3Q6IFJlOiBbTFRQXSBb
UEFUQ0ggMi8yXSBzeXNjYWxscy9nZXRldWlkMDI6IENvbnZlcnQgaW50byBuZXcgYXBpDQoNCkhp
IFh1LA0KDQphZ2Fpbiwgd3JvbmcgZm9ybWF0dGluZzoNCmdldGV1aWQwMi5jOjE6IFdBUk5JTkc6
IE1pc3Npbmcgb3IgbWFsZm9ybWVkIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyIHRhZyBpbiBsaW5l
IDENCmdldGV1aWQwMi5jOjIwOiBFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcg
KGN0eDpWeFYpDQpnZXRldWlkMDIuYzoyMjogRVJST1I6IHNwYWNlIHJlcXVpcmVkIGJlZm9yZSB0
aGUgb3BlbiBwYXJlbnRoZXNpcyAnKCcNCmdldGV1aWQwMi5jOjI1OiBFUlJPUjogc3BhY2UgcmVx
dWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpDQpnZXRldWlkMDIuYzoyNTogRVJST1I6IHNw
YWNlIHJlcXVpcmVkIGFmdGVyIHRoYXQgJywnIChjdHg6VnhPKQ0KZ2V0ZXVpZDAyLmM6MjU6IEVS
Uk9SOiBzcGFjZSByZXF1aXJlZCBiZWZvcmUgdGhhdCAnJicgKGN0eDpPeFYpDQpnZXRldWlkMDIu
YzoyNTogRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIHRoYXQgJywnIChjdHg6VnhPKQ0KZ2V0
ZXVpZDAyLmM6MjU6IEVSUk9SOiBzcGFjZSByZXF1aXJlZCBiZWZvcmUgdGhhdCAnJicgKGN0eDpP
eFYpDQpnZXRldWlkMDIuYzoyNTogRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIHRoYXQgJywn
IChjdHg6VnhPKQ0KZ2V0ZXVpZDAyLmM6MjU6IEVSUk9SOiBzcGFjZSByZXF1aXJlZCBiZWZvcmUg
dGhhdCAnJicgKGN0eDpPeFYpDQpnZXRldWlkMDIuYzoyNTogRVJST1I6IHNwYWNlIHJlcXVpcmVk
IGFmdGVyIHRoYXQgJywnIChjdHg6VnhPKQ0KZ2V0ZXVpZDAyLmM6MjU6IEVSUk9SOiBzcGFjZSBy
ZXF1aXJlZCBiZWZvcmUgdGhhdCAnJicgKGN0eDpPeFYpDQpnZXRldWlkMDIuYzoyNzogRVJST1I6
IHNwYWNlIHJlcXVpcmVkIGJlZm9yZSB0aGUgb3BlbiBicmFjZSAneycNCmdldGV1aWQwMi5jOjI3
OiBFUlJPUjogc3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJw0K
Z2V0ZXVpZDAyLmM6MzA6IEVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4
OlZ4VikNCmdldGV1aWQwMi5jOjMxOiBFUlJPUjogc3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBv
cGVuIGJyYWNlICd7Jw0KZ2V0ZXVpZDAyLmM6MzE6IEVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRl
ciB0aGF0IGNsb3NlIGJyYWNlICd9Jw0KZ2V0ZXVpZDAyLmM6MzM6IEVSUk9SOiBzcGFjZSByZXF1
aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikNCg0KLi4uDQo+IC0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZ2V0ZXVpZC9nZXRldWlkMDIuYw0KLi4uDQo+ICsvKg0KKyBBZ2FpbjoN
Cg0KLypcDQogKiBbRGVzY3JpcHRpb25dDQoNCj4gKyAqW0Rlc2NyaXB0aW9uXQ0KPiArICoNCj4g
KyAqIENoZWNrIHRoYXQgZ2V0ZXVpZCgpIHJldHVybiB2YWx1ZSBtYXRjaGVzIHZhbHVlIGZyb20g
L3Byb2Mvc2VsZi9zdGF0dXMuDQo+ICsgKi8NCg0KPiArCVRTVF9FWFBfUE9TSVRJVkUoR0VURVVJ
RCgpLCJnZXRldWlkIik7DQoNCi4uLg0KPiArCWlmKFRTVF9SRVQgIT0gdWlkWzFdKXsNCj4gKwkJ
dHN0X3JlcyhURkFJTCwNCj4gKwkJCSJnZXRldWlkKCkgcmV0ICVsZCAhPSAvcHJvYy9zZWxmL3N0
YXR1cyBFdWlkOiAlbGQiLA0KPiArCQkJVFNUX1JFVCx1aWRbMV0pOw0KPiArCX1lbHNlew0KPiAr
CQl0c3RfcmVzKFRQQVNTLA0KPiArCQkJImdldGV1aWQoKSByZXQgPT0gL3Byb2Mvc2VsZi9zdGF0
dXMgRXVpZDogJWxkIix1aWRbMV0pOw0KQmVzaWRlcyBtaXNzaW5nIHNwYWNlIGFyb3VuZCBicmFj
a2V0cyAocmVwb3J0ZWQgYnkgbWFrZSBjaGVjaykgdGhpcyBjb3VsZCBiZSBzaW1wbGlmaWVkIGJ5
IHNvbWUgb2Ygb3VyIG1hY3JvczoNCg0KCVRTVF9FWFBfRVhQUihUU1RfUkVUID09IHVpZFsxXSwN
CgkJCQkgImdldGV1aWQoKSByZXQgJWxkICE9IC9wcm9jL3NlbGYvc3RhdHVzIEVVSUQ6ICVsZCIs
DQoJCQkJIFRTVF9SRVQsIHVpZFsxXSk7DQoNCktpbmQgcmVnYXJkcywNClBldHINCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
