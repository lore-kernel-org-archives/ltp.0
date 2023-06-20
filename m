Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D49EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 12:32:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 831B83CC48E
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 14:31:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E041A3CC4C7
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:31:35 +0200 (CEST)
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A268E10009DA
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1687264294; x=1718800294;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Eoe62iQGwNoZeoI4+T6jt/uorKocuuO3HKH0oGdkc1E=;
 b=bc0WyFRUG5yZk+xF4ZYB8vo3krX0AcpKEO7g5wSQyau+cr70Na1wCi2S
 yKImm4Nf1mJMHb65egf0UMbGqfUhhkEkPaQB1aVaVCpec+i4ecuiXVHF4
 vPzglnyDDGNE79kDxWzVF6sPqhlTWKdsLEgSTdugVdo7G7FmlANHUwPH6
 +hkEXhkd15FV69CiMFpVfWa/HnLZKRjuHP7Nj0dyNDe60xX68DV3Rs8ho
 GsriVpjDK8HNWP9DX2OO9yUJ9D93LrsU19YXp3STF+kOmY6Ngn8mUPCdy
 Ncw+5A9zzy7EBFW/OraBKAJe+QniIDQB1vSaFHobbIV8OHFGd3dePoNjG Q==;
X-IronPort-AV: E=Sophos;i="6.00,257,1681142400"; d="scan'208";a="347923010"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2023 20:31:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6VZLlPQdRVS3a83QWa35Jz+PLFTHlYUmkDlxLUF33Z4JduiXC9jp2DRkJ6fJkw1eZFTaIhKKA5KJ/qGkXpA3MoU2BBwp/r+bOBbFEkE9eRTSFz/gW6N/RaVDzM+DV+XxqJ9Le/I9UEJQu/HkHci1DrV9jkLy9lCge42z1nngjDB6tMvbuasih6zOWsWeZNG891OLgOrjTMzCipcNIv5J2N3f3vBalhNh3j9is64d4qprC8G71HBBKYUdu4F2N9aGj7JYLYgW9a98t47zEt9pbzSZYeLTnRhEzBSzD2ve/x56NpYObVzljC4s+BgBG6t/mYSdkcEkMDf3HGHIUOAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eoe62iQGwNoZeoI4+T6jt/uorKocuuO3HKH0oGdkc1E=;
 b=N+Hme9SsnYPJhyTQdX6Z1XntWA7HmPUdzBnAKvJBBxe5Mp4lmodiExuqI/gd3hxz3qdOtGK6TBf60W0IslC5LgJ+APbW0PEvtFkcdhBG9lL4m6RjvLkk7c0AXB+HEjJGXYpAsy7fywMxosQYaSpKzUJJo+0B1vW9dZMwpOoJ6tNn/Wospww1FD8oU8ifO713PdSCqVUgWkkz8VScbKbxv58jv58dddaLAlIhHqpPWZUnM0VifXask3ODFlTFHfA5sqbOstvUzj9FkJQ23gvYbl+94NeplwapwMuZ1kMI9eBYvUUD/SZo/iDPb5kmbCPHQXGKnRRvSuKvMWTshmDK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eoe62iQGwNoZeoI4+T6jt/uorKocuuO3HKH0oGdkc1E=;
 b=iktB2hZYv+uv+61tHbWXUAo9tLwskyEQBCQos9vzSgKTvlgsi6nz3uLGOS5HOY/nEljazG95fGqfPn5klgMusmaxWbNMrT9ywIRXrq5a76l/6LC9oM7LWRx+oeJrQvXGyuVbjIw2YpZRuuc9VpO9gMqx2ePb/Q4CLDl6thMcVWA=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MN2PR04MB6877.namprd04.prod.outlook.com (2603:10b6:208:1ea::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 12:31:30 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 12:31:29 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH 2/3] ioprio: Add docparse markers
Thread-Index: AQHZo28KuxyoZVYtoU61KHlxyuf8Ca+Tn2YA
Date: Tue, 20 Jun 2023 12:31:29 +0000
Message-ID: <ZJGcIHRb3Vuxznhu@x1-carbon>
References: <20230620120159.320052-1-pvorel@suse.cz>
 <20230620120159.320052-3-pvorel@suse.cz>
In-Reply-To: <20230620120159.320052-3-pvorel@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MN2PR04MB6877:EE_
x-ms-office365-filtering-correlation-id: 201a023d-af79-40f5-75ce-08db718a45e3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YV7MYqHDZpPAusiw1dojHKbLbscIIVpS9Zft9kbBeHTScwcgA1vQKQ6rrqzb6h1t9dtpnjd4bevTwyrAsvtL67zBniitwH519ggy6i3ZanS8PJgkv5ugCaMYXEzqSD7qmGLqkuDDlpWvxIIL4Js51I6PxJIa3qKl/1/xAAMLFrOC6Q0aP4CiXQvhAvrU0SqJhzEQeOdLRoZ+l8I2NT27NQ7uDSCzvoTnjtwOfOixdlsZn7C5lyHSYGzwgWc555QI5KziwSpbf32CCgkhE8h6SR4EN+pkSnFjJ8HIdJGFGx9oXhH3RZx33AOgBob8pdiF6Fl53tk5r+e4zU+XP3D2k9dPC7KkTgBgpiFsZOeDKFYhfJpRClWaCXJRUs6H3hrsMilrjZf2F23SK9bQt/j1WvcUqc76+HsIJx0JCsT0dKsc6MrvdgTBlCykgTU5/WNyhbbK0UyvDA+xpYgSouxmD/lGxM/YE8PWJE7hXC2Q9tcHQNsfCBKhdtLEpmolhlSIXcD90ZDRK6auHhrt2Ryf2cBEm9Zi99aASejFLEDMPZEtkE+WUtQskPuvEpw6tJ4FM5K8koDlbQUxPECzeboJBDydPiIrXHfdLjBC9yKTy48k2vjnhX1byP8qQPTsLSkB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(6486002)(478600001)(71200400001)(54906003)(6506007)(6512007)(26005)(186003)(9686003)(2906002)(5660300002)(33716001)(558084003)(38100700002)(122000001)(76116006)(91956017)(66946007)(82960400001)(4326008)(316002)(8936002)(8676002)(41300700001)(86362001)(66476007)(6916009)(64756008)(66556008)(66446008)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?px2Vc+gUxAySN220DUGbgmZDlAIkUs9NY2/g16rPDEFLveMQ8GUqSn8+I0RI?=
 =?us-ascii?Q?+NekOP1R0tcL4VM2GjbDlNfpbC8q2NMUmEzz4CyCRn7i4ZT//RRx+d6s/Vnk?=
 =?us-ascii?Q?0FojjFZjDzkUWL+A/fTVxKAa6SMaAp/+JizqjD6rxZPOXF7w4Kz2mTsOslyK?=
 =?us-ascii?Q?NvQsW1I2ZDrqTtcItMh7uCEwtzLSG9O4K4LN04h41MUey47pbIQGPJ0UtC6h?=
 =?us-ascii?Q?hmbjZ5cp5njlD869oLJrs0jOFHyrB7mDlJjiIVPh5ceD/7lTyhNE7cMiCtsi?=
 =?us-ascii?Q?INMDCrdHQeVMBdR4vNVEA6D0H4u9qbe589EbsmSC0aYUNCwzKtARfZ3c8Tus?=
 =?us-ascii?Q?3w+m1wGLwvIALoVG4CEgd4l6pm8qR2y4DZX5YCJUtTkfzJS88d4MWClu0kpH?=
 =?us-ascii?Q?iwqnVDTBqQNWbuId2D7dbMb5ILhaicfml/G8nNbuhjFU+hk+Cca5yb6/tVdf?=
 =?us-ascii?Q?19MWgiRiEU3p3gYmRASXrNr+19Mz5MC86QzqL0BcppRjM5ZJceOVyOyWCfGD?=
 =?us-ascii?Q?2+TmbmcVjyZvlB+J5z7pfqYw1VydP1jrSKnvGedCFIiOEqygM9opZsEVwQaL?=
 =?us-ascii?Q?q3uuwQoVVOYoYNi/YQO7a9toStLAqVlfTs7gVq+9p2GPg7qfq+bPeeVy3WbJ?=
 =?us-ascii?Q?8UVRUfjGAy/+EtGydt5Rf/lDC/t99WjSbb8GVFje6AiFzcykwR5m9034yg2h?=
 =?us-ascii?Q?xvektA7b5WC17cdEudoRebSs0rGYX47vTPjgSTTtIdkpJmfEggnNNb7Wq7c7?=
 =?us-ascii?Q?TIVpuyI6dTriYaNvL0LPjnCUyKXx78JFhXedm++oMca6m4Y2s+CNtIlgNq5J?=
 =?us-ascii?Q?G0QL/1GtAyn9T3OpNDj7oqjQxyBDop1WoHzKetleHpzetpYiT7YyM1ypSeiC?=
 =?us-ascii?Q?kaVw/RHCHmK1yyQBJacay3dyuWBgloqHsiGDWp22L+rKcgDmAwBXKFJZZu3o?=
 =?us-ascii?Q?N3TIKKuST8XEEkXM6TQle6rjq6d7PgAbrNr6trw/4hoPDXzZMCXKMAT9B7k6?=
 =?us-ascii?Q?Lxke1F2v/G9Utg9b/4WOtUrZXj3TZw3ZK7q8IJdHX2gvRrT1VJb9/fLbeG9p?=
 =?us-ascii?Q?Qh9eRxDuU70srIFrvoxP5tsT2/HNTfgr+DqHCJNlwWy+B8dfIjrQnb6AoJ8B?=
 =?us-ascii?Q?HS3rbCnzqamr+Of0/oUP2XRbE5dSvvxZrot4Vb+dWrj4+aRUUaY/klhhixHb?=
 =?us-ascii?Q?bCN87/wtFHqZ4c5/o2u4iB41XbZWAmS89YI2W+tadgzwiTN/s6a/MkfrhnO+?=
 =?us-ascii?Q?Q4xQ3G3iLl5RcBvL7/J0xW+IRbMJX8TU7ANHuqQsffEE4ATgjDqu5D03kNCH?=
 =?us-ascii?Q?LES9TZ9DGPO92rfHWd360EhHHptL8AuAVYtEMey1NAeFaJ4gOEj8Ugf3aHem?=
 =?us-ascii?Q?XPdjApDnCqMt2kO2baCTp4EHod97cefoc0WSfZjdsDkO4xdNEhn97CwLSDm5?=
 =?us-ascii?Q?Ag8ECqzG4UieJNr+XocNAHVgC9pk5fKH8kzqKncaVX3p3L8LGG6M73EY0xqD?=
 =?us-ascii?Q?X9mO31x/oHVdVnhUqUYKl0d5OGHuLo5nqoXk4eWXIKGsfMgc1nuN7Y9p4KmH?=
 =?us-ascii?Q?ktQkb92tkoo0LBgM154iRhROAqyzX9WPNxXKcTjEGnF+bFK5Iz4WvKAQ2lZg?=
 =?us-ascii?Q?Hg=3D=3D?=
Content-ID: <AA45800CD4728D44B53F97075F145533@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fal18WK/t54mrK41DWNQnRFehrLB/ZCenzajPTBSQHMzI7bL5JZJdudIWJMpsA8z+xfwUTw+Ffpm1hLxmSD2QNaUXX+T2HIzjuuwwiQ3cQksWLiT4/efVGgDdEtpZzCVeyarSEaihIGQYMbyZacfcNx3RaMKpDvKGjUMSrsVzQcc63wqcyuEi4nzsVmbOu1W/ChbDztlXugh1iFF6SuHG99w5HKo4Kci3qCoL3ERqfooXLI4lrtW6GFZea31gIA5OzxU+6Lsd51jRpeYeEFUZENpOvp7ayLWB+iE9e4sU76VJz0PS3b+GVeG7m8x3K7d9umax0eIbmWkL+aF9hDVr5XEySXUhvQ7lgOSUdHyxwtqZ+49Qjbfmhy0PzfdCCq69vlM7oOQq77eZGJCMlY/+9PsRJ+7WAc5/mOOpgvjx9jLltxWQrjA7LOCbosnEiiEIVSEoxQbox+z9G+xBUfSyOxXyRKKD07WDCxBswhrd3QxwYsp14OyCL3kSDv+5KVXF9tLpGgypmqKyPSFspwNlIdC/Lm28PKnnSXGIub2HwZJDzjKosmd3mp+sP08UONRBx/QqMlPFKjs2gFL4VcEzgogIn8GSroQdZG08HosFKb5KIMWdU2YaFpoKddNkdDmIL6LAp7lLIU2FybWJAAZUiKuXuw/w4w8eQRK0Dx2YrW8ShZ89VMHIl11GlPhWl/vByDRPQTwUN7cPZZhvr09XDgxfCvxD5Em1fTo7+xpauKjPGfXISOzni9bg6N1fqvcYlOXb77oHWNMrHCyVe0Ul/rkvp+ur+1O+j445wK73PkBTrR+Ran2lQixcW5NJ161zr2IT3nFKwMrzZypU14HZ/ctdA0oN0hNxNFhtFlN8HU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201a023d-af79-40f5-75ce-08db718a45e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 12:31:29.4659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqExICFUz21RErKMdVDa0NBXM3D8Krg5Xf24B4Jwv8XWIjQcZFIMMcmhWhIIJ5ktucg829zdycsmbtQ25KWxjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6877
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] ioprio: Add docparse markers
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
From: Niklas Cassel via ltp <ltp@lists.linux.it>
Reply-To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 20, 2023 at 02:01:58PM +0200, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
