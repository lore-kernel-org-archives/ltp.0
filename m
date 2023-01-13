Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CAEC54EBD
	for <ltp@archiver.kernel.org>; Fri, 13 Jan 2023 10:05:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 292043CB520
	for <ltp@archiver.kernel.org>; Fri, 13 Jan 2023 11:05:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E324B3CB514
 for <ltp@lists.linux.it>; Fri, 13 Jan 2023 11:04:53 +0100 (CET)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on2042.outbound.protection.outlook.com [40.107.15.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0CC936013BC
 for <ltp@lists.linux.it>; Fri, 13 Jan 2023 11:04:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bET/VOQieSYI1GcvgbgSdiPWuUC3oOhmf7ib9IMp1x9ScLkUcizdO3cN/qkBGzeV8PLIitmo6RgpVMjCLD5rtRUIY/iw2MQoxPud0Nyh7WnVCdWdSmvfUFVBvwYGEC8QlGkyDDwRQTT5AbppyP5skoKkTA6NNczM6GcB2bmdT1HzOWRfja0Cs8VJth7Z0MSLMDcOeV8ndEJFw1JwjVpqBWf/BePlSllDXlZJ26q+fMzoesRc9iIZS634sf8rLY/AExW13G1UnBBC4FTsEPhRLj5/C5nAWMFcMc5fqyIdSLXUZg+1ytnJMz4pdDsSAhyct70F4SKKXLarWSkBDuYuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIoRM9DIxO3B6V3gyCCzbI1cmpC13LDvnIgKED6XazI=;
 b=oek75zONb5w4sfG3ucyfjXo4JKjr40vctDtoDa2d1OK4mp4hccH6jZRMtEQOhw7c3bk8LULULjh/82beIRprAzBgEctkgyaftgXPN8V46govhWfEU4OQLO6UdZaouX4IVeGrzHu9v5RunEYyG0cbgag9Vzs4d0XaKhLzKrA8OeS1SkpVcYnsKVOTimhkKR6wioJ57jfCEI5IfXK9dIQTwhlzIt5w7SqQ8Tj+BRAaFdP10jvWttbzW0xW9QS2zpFfQKxsKkUyubs+Dn2pNiK/VK6xfVAhlrG76UueVehLJDCqRhG2QfCnbPEXCdQYFVf9c1BDUsEjukXiJ3HNLi10yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIoRM9DIxO3B6V3gyCCzbI1cmpC13LDvnIgKED6XazI=;
 b=cLv3WzLw0/NxcRc5scFuqWXOfUsouxuOPCd45nHgQ8QMQfr3aNkBX54ITE/RhSNWJ1HraFVbp8+RxqNOayjK6j+6SMXEfpa3Gq+E714fq9biHJ73LTC6g4BgQ2HfWzux8J+wuwRVZM7BJ19gjxzR9hnHcOC635avLx2y7si+z0sdhxMtWfmrGZ0BO65n+lXLGzbsvMUArzmmhlNgzJSkq33wg9EPqxg80cYIYXfFA66WV9PFPeX6+CpmHc9b9CT6OKZ+6dZSw1IzBi2Zw7sVIdKGKlr4f3nrQN2EoiFP14ZYhkIq6ACXxZ+nPpeJCajmMsaf0k46GsRlH8HN5bB+eQ==
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14)
 by PAXPR04MB9668.eurprd04.prod.outlook.com (2603:10a6:102:243::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 10:04:51 +0000
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::ebc2:b66c:891e:4c1c]) by AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::ebc2:b66c:891e:4c1c%9]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 10:04:51 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1] Fix coding style issue
Thread-Index: AQHZJkOJueV0py5sQUmBZPAGi9Ij6K6cH8IAgAAAgYA=
Date: Fri, 13 Jan 2023 10:04:51 +0000
Message-ID: <AS4PR04MB9433ED27AEBA5604979B75DEDEC29@AS4PR04MB9433.eurprd04.prod.outlook.com>
References: <20230111181826.9395-1-wegao@suse.com> <Y8EsNEfmo0lQkiTF@pevik>
In-Reply-To: <Y8EsNEfmo0lQkiTF@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9433:EE_|PAXPR04MB9668:EE_
x-ms-office365-filtering-correlation-id: 2c7282cb-ef93-491f-f69f-08daf54d9c8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GxvJje5g7KcrRw8BoOr0O+k1YvYGxQGtnHUsywklyE7AovTBw6e/4eEwnlX+5wTwaQ3XK4FlFBcxe5qiZ9FUOEBzXKUSMiOrtV54bEdPCFjBqcMZ9zltofvBlO3DZs+T1KYyNMKdXbMi+VbwcmjKv2w7em65uKrZOzOHiJv7hMneTsVkJUT4pNY7ZFHGGd3D7ysZfPGpQUECoaS9Per/IZySdUzFDFlNsFsM1WyrVUUYkF8yo3BAkhGN5RwNZSsg8Gw4IytGr+Ji3Ni5qVuGtxm/7z1ekWANSvCWAx7XQjULpUx++34JrDhitaPzFO8nG7RfwVfH9K5rcBKtUzscgoLYLgOw70U8phN2wWwscdUba64Q7FSVzW48i8a6+Ub00FVvzIllz8j6o2bpZLWMeQbIIKmOj7CWV7JceX21Vc8xy9wa8qSc0N/YjE9RN5rWFRDjXfT0ATOYRA1gtgvLhtW8F8hCb6YcS1kCZfjQpdidcR361pECx8JWVLaIVoH+3EtJGwGD0+CFI2ANjupEDmXC5CQ73/6iU3lk/++n7dnD4pGVHpJWqhNiL37j1WRN19H7wj7PLqLd10ytYlfi7/ck3snjEDofK+sgBp888L2r9tOaOey/S4u++yKGn8Yjl6fHhAF0+cSXTGEkVByL5PEZ0xJjVBe51hpY+97U/VrZAxb3WMu4mcl6hzS1o5Tk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9433.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(33656002)(6916009)(38100700002)(41300700001)(122000001)(76116006)(8676002)(86362001)(4326008)(38070700005)(64756008)(66946007)(66476007)(66556008)(55016003)(316002)(83380400001)(26005)(8936002)(9686003)(66446008)(52536014)(4744005)(2906002)(5660300002)(478600001)(186003)(53546011)(71200400001)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wgXvYJJVyfT2+W3K6YQMfFlBoGP2UOZJfTl7fue2qz3ZGv+kAQ1mWfC+Bgob?=
 =?us-ascii?Q?U/0DWfeudGqhduV/oLnvWHpTdOjl0Wz5z/c9anagbIyK45BvhlBl1jJypsd2?=
 =?us-ascii?Q?I+0SCFC5R9vzMsE7PikXCGcAfcBbkVkbBhcc8z4JJU+NDZ+jDaf5FajLTmcx?=
 =?us-ascii?Q?Iyqz0v53ZBfptsPASawvFC955U9c0J8HDhy6aJUmGZ270DYaqGyyuo65eeYf?=
 =?us-ascii?Q?OMkS1bmQAuJvnutsX8dSV5cjwCUswsleATILXyiEYsML5sDMW3AdV83wdYOz?=
 =?us-ascii?Q?ZxAGFbMLXMkeLXf1yNoFx7ERnk8Vv9WKHfBEkthysq7WmxdGQ0WMcg413Ltj?=
 =?us-ascii?Q?TkJZMcMywKM8xWw+7ZD9Y9LpiDlGMtgRXMmf/9jI2dUInM+dx+jYeEaoUOT/?=
 =?us-ascii?Q?DRThBExcRCyLgmAJtQZiTwvrC1k7ezP7uCjOf3qY/8v+rk+80Bl2Kvm0hoFG?=
 =?us-ascii?Q?4cJiV9DfK5Xjm/l2AxrMnavrzZz8+QCwtHhRSpDJusDuXPYvECwMkuxZvuI7?=
 =?us-ascii?Q?XFSFazHzBldV+jwCw6akQtiF580GxmUPHYzSp962BRV9F7OIRewxFTQsg4W7?=
 =?us-ascii?Q?RUC3lJuACrvNtzdCs6AhvbrZKVUbq1BS1T+wkl3ArtNWrV8p7PKLBAtf3UIn?=
 =?us-ascii?Q?qQqPC2FYLURWf+T3AO7sS7TONABMeMNRWfLQT6i7qOJeNp9c3/FcGBd1Of6i?=
 =?us-ascii?Q?nX2yqFeelC3hKenH7qcVEOJ6DhEOkvB4HuNIhQa7YVy/WSt5S5Yh9FGjKOFj?=
 =?us-ascii?Q?ChTpTMbTkuJpF3qw0VjQLUYJjpFYT0d4xn2h/bMaMLe9G3U3lgvvsuTBF/pI?=
 =?us-ascii?Q?8eOyOYkwLoibwRPSl0CJgWSpF2qHP23JDGhhHk3GMJPVKgDDM/xbSvBZz9m2?=
 =?us-ascii?Q?8KVJnx4pzLQpuC42rZszIhDiB5OaCixQyyztPkFzbLE2odSOVJPv0jLwHvjE?=
 =?us-ascii?Q?puaJG+zgaSnpIUG/iMnwXQGTWzgn4fODSMh0CbSuRcM9bAXiwJl9AwqZeNfo?=
 =?us-ascii?Q?cqsxAxnTqCmb1V3jvpjNl/vDJGr6ARGWXl2oe0rvmiFV+PkGgU8bYxRODKnh?=
 =?us-ascii?Q?ylICc2IJkXLjIY/x/M/pldRP1MpIQnRvWtd7nTTm+V2+5Tl9sqUYQxMVLtSl?=
 =?us-ascii?Q?8JWFN/Dp+ztIymbjGwktsdEv5GvqX0e8KJFH5DPXWgnMJrKx8oIAw+U+dMrc?=
 =?us-ascii?Q?je+CQYUUyb88Jy6wABo8vy8yICR+OwmkD2v4Q77JRIggOP6QCrkL2PWyaBB6?=
 =?us-ascii?Q?YMk/2qnly/5MQTHCoFD8UHzXyWcz4KgSQcaBDdgap/K54AmRGFzwhcNKA7o+?=
 =?us-ascii?Q?uq2ENn7uAkT/hMQzshh5SPEiFKEks+I3TWrN2O19uOHaPniiS6umTjJ5Uc5W?=
 =?us-ascii?Q?7In7txiXv25tqV4pwEs6hCIbxD2fEJqUOn503oS1/D6vy6sBiTAR8nCSqQHq?=
 =?us-ascii?Q?lZZQKUxTji7YwEAhI+mGepS9HQpcmYO4FRf4Y6re4q4y/ChIM6Y0skQki2yJ?=
 =?us-ascii?Q?Stib1a6Sbf/2qmeIBNnMUfTNM51+QB7JKXKHlSnJLfT5L7JVNFvyTflDdxoA?=
 =?us-ascii?Q?XyUwb2l4wyiCHXjwqfw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9433.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7282cb-ef93-491f-f69f-08daf54d9c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 10:04:51.3557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muF4JFZv3myaShFbNbb+O1wbUH84Y8t/yGDrx9C4BDQYSphPg2wJrwvavgFr7gpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9668
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix coding style issue
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

Thanks a lot : )

Regards
Gao Wei

-----Original Message-----
From: Petr Vorel <pvorel@suse.cz> 
Sent: 13 January 2023 18:02
To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v1] Fix coding style issue

Hi Wei,

...
>  	if (tc->use_overlay && !ovl_mounted) {
>  		tst_res(TCONF,
> -		        "overlayfs is not configured in this kernel.");
> +		"overlayfs is not configured in this kernel.");
This was short enough to put it on the single line.
I also removed the dot at the end and merged.

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
