Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E6AEE4993
	for <ltp@archiver.kernel.org>; Tue, 22 Aug 2023 09:51:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83C083CC728
	for <ltp@archiver.kernel.org>; Tue, 22 Aug 2023 11:51:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44C2D3CC6D4
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 11:50:54 +0200 (CEST)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 74017600878
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 11:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1692697853; x=1724233853;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bwIdqjRWvLtSqNoX0b2OXfZPEAZYQnOIlTKZ5ScAjIk=;
 b=XaptKws26oi9R0g94fFTnYlncpNrn3ncl8MEfLWxxobgLaTeN1GVFMYn
 BuyCkGi5RDUzA1z63M9cJpXLLcqS74Zj+jALsm9r4I8Kw3XCGHhTQ9jhr
 GuCCy7mmgS1JukhvnthGse4UuuvDzUFHchawEj3/14o1myK53RRmKWwal
 4axgCgnwbtkg3BmNZ18YU1D7lJCZBda7VZ247+EtIp6RL8s6zQ60FulWW
 sN+su4+BULtISq7f1zWllgiEy+U5i7GFvjOMWwT4r0Cll2BR9yNEd+TMs
 /kGaqmQprh9P8vnLFLIzEkYwOdU8a05uVXnGvyIdsema784+gX2i6P3LF g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="92499807"
X-IronPort-AV: E=Sophos;i="6.01,192,1684767600"; d="scan'208";a="92499807"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 18:50:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3fBvaCv1g8H6oBwAGULP/ur0TJwJeT1B+piypDFJJE5QIhcsNhNQKFF6u15unWfDV41AsCjFwBo+4rUKuDkpfqGYg5B8xrzb85T54vSwucpVa5WP7unLdeTQxs4sQfKh2PUh9p/mcXszmmsDl8W7msYnACn1XeP31G9MnieaRETPDaecRhwQzIfTys3Mov6cBxWr1qYwcQZMFPyzs5bKTwYbG0HZ/zfQK2aC/PwnfrkCTX14elnp+zFkD+v5tI4NZNeUEJscC4AJlZNGz0y77vErU98GtqEnHrik8KO0HEvdmpuSLL+zjBuehFngvzP9IxIC3N6yX+rA4LTuFqm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwIdqjRWvLtSqNoX0b2OXfZPEAZYQnOIlTKZ5ScAjIk=;
 b=P13/KlZAK7seWdOYrZHQN+3XrveEG1+njCehRhk4uu9ZY1owpv1ZXat17X7V3Dhwtz/RtSzksEOT21z1cJxEdQJBlmbnzf0qRGb7yeGXrcIQYHPRByGJOXSZoouMUvDSuL9phoO7+O2AP3C5fBDpZmJUMFiglWCAVKI6uAjs9Ca0c8C/zSYx6/sL0BntujIA+/oUT/LNYwcvDeKC42D45JudyRQr8QQ+wDyWsWW+BIlgeXzT1G8v0SeoajmrVBEqWTfsf6zRI/sEZvRHNPDaGaizAthmYp381ShgBiGZqvwGDRqtPzulX5tolwxK1lwihV6pE7abOvyV+OC7G+RPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by TYCPR01MB11606.jpnprd01.prod.outlook.com (2603:1096:400:378::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Tue, 22 Aug
 2023 09:50:48 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::3776:b0fb:c837:7c84]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::3776:b0fb:c837:7c84%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 09:50:48 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 1/2] syscalls/faccessat201: Add new testcase
Thread-Index: AQHZx1J5rubceNCG9k2O3QJGDTifVK/jpm4AgAFhkoCAESWbgA==
Date: Tue, 22 Aug 2023 09:50:48 +0000
Message-ID: <1c08fe8a-7ef9-976e-ceb5-f240c80f7629@fujitsu.com>
References: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1691208482-5464-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZNT6GkZ05CrGk5pV@yuki> <ZNYis5uAp5BRlZ9h@yuki>
In-Reply-To: <ZNYis5uAp5BRlZ9h@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|TYCPR01MB11606:EE_
x-ms-office365-filtering-correlation-id: 594dd969-7870-4521-44d9-08dba2f5439c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C9Ha+s2oqcFBKy9mrLVte55R0U8ANAhHb/QSspImuM6q7eeYYZKOzkERbkAU2iBcp5ehX7UP7zs/WB0aMhstudYmc0LKaMhkVA43CrydCXhx3MyqONP46+pTWjxXY03sZGqLQf2XRe3qrKL1H+neOcQ+D4Fj3EjJVxmuAr7g0h6KdUgJMpTWBd/uQbtyXM9Emqzmj+1TlDPbC8nq1ZbshY/8Cd8hPFklugGeXfcCrSfFqr1DhnxSYzUwXGeWQUpkrr+cJAsWMZmGAzDaEzwRrDJqlDjGRXBfK64+z4exPLofTlrvuCr4pAZnoPiBJjHoyclKyKlT5eKkP3z3DrYxDmtPVDsk4//RGDcxBrJ/nL0JZooaEyIQ7qH3q2zooJZJsqosjsPWhLHCOykvVUGicyk+qwRo9Q7Lqra9ArS+evQE2K5wSP6Z+KmIerOGuody0l6dyel7i202vql1S/tZjAD+6L2Lo2F2M6wvM2PpMltSEetD6D5UeqOzXBm5Y0c/DIY24HRzl66b5gI3W4SQ1T+Nf6HDEP4DXUCyuSbAQASCVLO0q6Wo23Zo7flmBSF2q2sLHkENDjx1FJ0C0xHZtCJkI/441nv3rHbcS+6cP/9MW6CglsUgKCWsL3UNP2CFXZg/LNdYnyx3SM5xtxOP3FZoB8mLZEdWEGBkdvieaYyNn0t6qyUZBvWJncexc8Zb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(1590799021)(1800799009)(186009)(451199024)(1580799018)(122000001)(38070700005)(38100700002)(71200400001)(86362001)(31696002)(478600001)(82960400001)(6486002)(26005)(2616005)(6512007)(6506007)(41300700001)(85182001)(66946007)(66556008)(66446008)(76116006)(91956017)(2906002)(64756008)(36756003)(6916009)(316002)(66476007)(31686004)(8936002)(4326008)(5660300002)(8676002)(4744005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFJ5QjJBUGMvRE5FSEdpcFZRNGQrRkp2anN6TWlCZyt6VGgyUzR5R1lRbEVY?=
 =?utf-8?B?SFJ0YVF0S3p1TnZpbkdkaU5JTUl1bzVJL1pFUzFBcUxoY1U4SzRtWTk4U3JL?=
 =?utf-8?B?UGJLNXJLWUd0UkpxZDdkSDJHaVFoOUNNT0hMbGZsdUllUFNDOHoxZ0dRc2JU?=
 =?utf-8?B?akd0dTYvbnRUMmtyS2VMZWx3Y3M4MVdQSWJaaEM5bjZQT2YxQktFUFdDOXlC?=
 =?utf-8?B?UytpcFA5YytMQ0lhYkUxTWxGSHZWTHptQmVNMjhQN2JSZkxTcVlmT2xMMW5r?=
 =?utf-8?B?VERldEZuNHVKaVhsN1ViN3hEeHVGT01XL1Q1QjAxYTM5d21KcUpjWDFUTFBO?=
 =?utf-8?B?TmVaZGRObE5xd2w4K3ViQllHanBNY2tnNk5WdWtNSUhGRlRkVTR0dVBHUjE4?=
 =?utf-8?B?ZU9sNGp0MlBkYVhkU2E5NGhWZWlmMm8xbUhBWXJ0RkxTaGNBOVRhK1dOQ1hF?=
 =?utf-8?B?TklESUFBS3d6NXpBRDkwaFQ1N2NTTGVLSENQa2l5OGNFN0IwRXhpL1BsVkNz?=
 =?utf-8?B?UVppUFFPb0JTVGtZek1Ycm9mc2M5VmdJTjJJVFV4dlFycHI5NU41QlNNUjRz?=
 =?utf-8?B?MEVndzRrZDZ5WVl4eXY4MVo0clZuYit0dGJtdGo4SkxxbkU2OHgwTWxvQWVP?=
 =?utf-8?B?TTNVeG9zSFpuSktjdCtmQysraTZ2NjBFeEh3Z0VnQjZ4aUhSdFJiWGF4TFFn?=
 =?utf-8?B?a0diREVhZGlYZnlaaExhVkxwZTdBZzFFU0o3Y2daOEpVL1hrTzRJL1kzKy9q?=
 =?utf-8?B?RThablFqWGgrS1FFME9kYmlKczBSbm9CeStManpqVjlzR1BtSGMrTHYxZXJa?=
 =?utf-8?B?R21aRjU5ZVBlckVvaDJUVnlXZ0YyZm1NN0FSeTFkdFNUc0lUYTlQeUp0c29q?=
 =?utf-8?B?YVA0QXdYUHJOMnJlMVZ1Qm4ya1VSQmtTWUk4RzhNcms3d3pmbTFDNFUxNzhu?=
 =?utf-8?B?WGlRTVh4V1JPWVFKdzY5eUxWQW1wVGQzYWZRdDhDZ3V4dCtLNEtWczRQeGxu?=
 =?utf-8?B?dDdwTWd5N1FEd3NTZEhNOUFsMHNPejkrRHd6LzEzdHFwemNSanFKNFh0NEN5?=
 =?utf-8?B?Zm9qbHAxeFJTdUttdFRJN1NhT0pZVkltOXlxbXcyaUp0SW5nYzhYY0wxNlJ5?=
 =?utf-8?B?ZkQyR2JrVXBvbzhKWExZdnhUSzczcXZsSExlVCsrbXlsMkxCMlVmbUhmbnlY?=
 =?utf-8?B?RnNHQU0yWW83TDZlbkMyd1RCdXVDcUZsaFcvMW5yK2hMbCtNSU9wOW1aa3Ey?=
 =?utf-8?B?UWtxUFhHaFBLNVYvNkFnV0VKblozOXk5dThhVnQvdTI4RkJoaU5kQnF3bzBY?=
 =?utf-8?B?czB6Vk9vWUQ0Wkd1QTFVZ0JOTjlRUE1RT0I3N0xNcWMzMFVzNDJDR0k0dDUx?=
 =?utf-8?B?N1V2NmtFYzErYTV6ZkVCbi9zR1h4L2hNaldXOHNGaFE4RVczNVoyQ2x4a1A5?=
 =?utf-8?B?dnVEbzRCa1J3a2lQTlp4bWZMenlETytVYmtSd3F0OExVZGFPV3FRekwyNTQz?=
 =?utf-8?B?eVYvdXpLYVZEVXFRbWdLb0tGVXdOd01GWFZUMnpuRWowS3orZndocnY2S1g2?=
 =?utf-8?B?YklsMFJ4MGtSYmtMVWkyYUpxN1R4dGMxcWR4eUVlYVRNRDU4Qm5VM2VUcTBX?=
 =?utf-8?B?Zi95WGhYdFdyZ1NxSStIeWFRSVZhTWEyU2Y0OXI0UGJhd3Z1RWJLSHBtVmZy?=
 =?utf-8?B?M2p5TUt4V3IxNDVBWjNWTUlaRjFDMlh3QUFWUG55czROdVdIL2pHSXl4VzhX?=
 =?utf-8?B?bHQyMUJTT0xBd3VVSU1FMzVyS1BiL0hCZlRWQmdsVit3c2ZyYVZFekJtU0Ra?=
 =?utf-8?B?YjQ1anlickZVRDVhVUs3aEtKN0w5ZXlKcllRUHB4T0x0eTd3VFltekhxZm9r?=
 =?utf-8?B?cGRZaHI2TERVVFVRZ0VmeStoaXhZcU9Od1BkNVRqbjBsYXIxSERHY2EvM29U?=
 =?utf-8?B?aWt0bmFEbWh3VEFsUVBOOUtWNFk3K3NRLy8yU3hGT09vamR1ZmZyRERpeDdt?=
 =?utf-8?B?UWtJZFpwSUNKVWpaSGl6OWRqZmM2WHdTdVlla1JGaWwyYTQ1YXVQQWgwRUYv?=
 =?utf-8?B?MjYvZDB0YWx6Ui8vRll6d0VhR2ZzUHg0bnF2b3Bjd0tZVEdwcno1dmpHT2xz?=
 =?utf-8?B?Rm9lY3VLTHJiY3pRYlBla0FmY0VxdDBLcnMrTXk3UFQ0cjhVcGk3YjZTT2FN?=
 =?utf-8?B?Qnc9PQ==?=
Content-ID: <9882CA397EF18D4EA5AC3FF44ADCC1AD@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DcA3EpzVNMX21aYLpjEfApk4b7zFE8MD7PNpZh6WzPeuthbltlvM6wh5ilSJcfe3QE5X54oetmbBjsgj3CyuCQgrsiD3r3OCq/aidZjUl0s05TnGUQ/pfS6oXWEDfkKWr98A+FO3S/0j5BvDfz9XYaEBaaDcoDU5Ephz0+3J5uT+w5t8KmKafdK3cGs271qmhvN29UjmS+1IWqzEKPzWglhEmTcD/LEHefZRILsWca8R1HU51cmnkNa3r2oDO21VJbRBqRofFnw6kRqxdHaNM1Q9+EQXLsn0+camRdxHqNAI5/+RafJQvXXtM1tgFDB5epEoPJNVmhmF/hXclDV4g1OM63b/GzwkTcbIIiXnQ4M6IrW6M6hHI7VqWel0YjbMGHCjBMGnfFvNmM6uhMp2yfjllE+5rdEsfWFnPG90YGQdObUAniDtL0vMset/1II7q+UvHrkMrGtKSM8O39XyGlYZc9CYQQPRJD2iKtt8c9cCmR4B1W3GR/qlDq1qaJw7GPDzCU32YLu1+pLsadzozQRlTRB39lf3tepTW5uxt4Ev2te5LXrmgXzlq4GQBb9bQQiHAoHs1WSAnREM1M/1oThfxUL5l6rwwtJ+sUkXFbtSYDXEfEWHvdsmT8NkeReDgSLUCP7iHPkojnhrzrcaQfZ8BLDLkkSpx/ZSAO18i6d5QV5h7GrRyDKKBDLO39RqUEJhn6mHUvG1Fd0R68ArHknxiNk2r3SCfZYM2ubeMq39vH+nDR7QO+NBnXYL8pHfSeVFxyRu3TvvXYnQ5ASBbwlXLExrdaTsAWrTuV7shk4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594dd969-7870-4521-44d9-08dba2f5439c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 09:50:48.7701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /B5PWl31+DFV9PPW+Ck0c5f5ybvnjig9xfRaAuAk9W+rHRLcyMhgtu+4HV16mvcy3/n20XtLkwqzkQSDWRVfespy6gcuEh3pfhYeQEluqWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11606
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/faccessat201: Add new testcase
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


Hi Cyril
> Hi!
>> Why do we allocate anything here when we replace the pointers in the
>> test setup anyways?
>>
>> If anything it would make sense to allocate the buffers in the test
>> setup instead of using static strings there. Also filepath[x] way less
>> readable than actually giving the variables proper names such as
>> abs_path.
> And it turns out that tst_strdup() was already there, however I've send
> a patch to add .str member to the tst_buffers structure as well as
> tst_aprintf(). The usage should be clear from the few tests I've
> converted to use the new API.

I see, I will use these in the v2 version.Thank you for your suggestion.


Best Regards

Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
