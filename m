Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1539FC4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 06:33:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0399F3CB8EA
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 07:33:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F2533CB491
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 07:33:35 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D99C760080A
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 07:33:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ0wlOR9ci2VrfiBVfFfRl3G+1R+aR6f7suTGB32Yy1n8MnW9NquGlB441z29aq/NJvS5G+Di67TR7JpIWQZ/b7E2i7PLGeN/s9ZRs/f1z2OVlItWqavsRXMtvL7CZ2r5ngtBkp9NMMEIGbysG10ccWHLWOqQ2cztsKzn4ZYaIR3k2zYZIkDrm3zw1ATBKkzm93GuouH0MnEjXpg8yusLT9G6PiKywsa/OOSu+Nwn4mev8KlvYe1C5PHoUpPJRTLKKoRLzZmhgAIM1ApJ+foTyfrjcNXhvsiIjJIcjmKW9+9TjoaD3F/ryJtl2Zli7+M1dwgADjtuIW56zPzM4aY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1RMJKBCvmHtg9EVfAXGnoVPNCoIOz9PPuiB6D8G+9M=;
 b=hFcfn1izlYFKPPI6F6Dlq+TuGpJ/bLWRyCE26rDEdG7rpB6R8eRtNhuL3ReAbptmAro8owWiowifvz+PWQR+W4MLUIzWPTJEM911Fyb4sv3XPzALhIXpIH6Qggn0taT+IidBcVHWu8CLhNSRiH3Osf0nuAi2VWEgs8bDmMtEse4X50BwdvJdflceEFCwmSG/ILy6Yk7T2UdyreYOwWDApWbJrHkBOObr1hrT8BKUwNR7Vvn/KJNloLsvvOrZ2nrT643vSPeTrtY43iTO1D+bwVOSx7pgm4fnsyARZi/LAIhv9DcH+YvgLGOrZCVfDRCtr7r6DEWWIRnOuqlFm5f00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1RMJKBCvmHtg9EVfAXGnoVPNCoIOz9PPuiB6D8G+9M=;
 b=r+/wMblOOKq7EmQAwfPNmDw5GCvVmo1gMJq34eURKqRZsER5Wjfy1aa3ofXCbLxgdlbRKzlfzrDqcCuX5LXnqAc2pdmfN1c2PO4i/QbQfjALwe9WMHcokpLIlnaRSijoUpdVq/JyFQRTG89EM6eVKF0nOLPCFFYzd6PF3bHiUSmPvScs2XD+CeeIb6LMZG8Ssfw7RxeoFv4pTGT3/AkI7G5Z4yEgFjzny2PaxleGkxryXBg0goToEI/qx9KqMhlHwQa0afaXPypCyZGlWLROGkI0bHfN9N9f0BjXSUlz/VXd9bRrWtefCHLcmjadIi9Id5VgdEfPA1es/UACBldmlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 06:33:32 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 06:33:31 +0000
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 01:33:09 -0500
Message-Id: <20231214063311.2325-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231210094339.26971-1-wegao@suse.com>
References: <20231210094339.26971-1-wegao@suse.com>
X-ClientProxiedBy: TY2PR0101CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::28) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DB9PR04MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb41aa5-d9e9-42f1-0e2d-08dbfc6e9748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pY9ei7qNkVJjhfMWD8sYYIhoVVDXyfJK9Zu3j+E1XWT+cmjrVI+Yy4QXYtZVD7J7X6utg8fiVlxCF4e+gv73pqcaiITRzjoiLKCzWtonyK5zcDLhaCEQXxe8vBBOMQZ0XaYj0KPQjSTNu7U38FIH18ylE98CEG9L/BZXkE+P3VQ+LMgBj4S7KsZRvRGIo5iK98x0jmWmIHILKGYXlNv3FZvRcxTcOyIufX94pnmbFSkNNfZRhJBgS2shUb+ItRAEZ1nrzf4OCY7/xPYL9nH+aKNawk1dvPHF174+lcIk5NURn61iXG/eEh+I8jV/M7qdOhhYk8eGoqAlwpLDKSU1WTxobfR+1S0sz0Q/omhVclHwchenslb4xtEwpGYUD5IpscoGgmUuCvgyxnqXJmRUNZqoI6PIseH2n2hH32KJ0/2nukmaXYK8ZrdKHdpE/1l7RxDgAxtQKHKtcltKjNQBcP1rAcQoq1txA8QERMtw6VWbvM/n0Xv655LDsBUb/2owa/3wnqQ1bQlLuwE7X5Cp1YtoX0u7RJU36LpoK5zKA/lJrVmnS7O1H7j3fXalRD/S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(4326008)(8936002)(4744005)(2906002)(5660300002)(6486002)(6506007)(478600001)(6512007)(6666004)(66476007)(66946007)(66556008)(316002)(6916009)(41300700001)(38100700002)(86362001)(36756003)(83380400001)(2616005)(1076003)(26005)(107886003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jmJQPfHJb+PYUYfy7uMqK9Uu2r2aHB5zOH8DSMUeWzPMSD1D6v0TF8UcdXy5?=
 =?us-ascii?Q?6/jRn++hsqbfoDVIjceCT7SDUIj4c/ce6x3jdSTAf4gWHqDNsDMFbv9BxhW1?=
 =?us-ascii?Q?hQmCOz89mRQR1fv7lKL7XW4/KGnVa9xUeCEFscS2jRzHS/KrL+Va01Kq6mCN?=
 =?us-ascii?Q?i812zrVNQCv5nwdfxeDMoXGZkCSMrUz2LWIeM25I2MWJzycrlx/aTTdAqP6S?=
 =?us-ascii?Q?SsV5HOUSJiPy0v/OXKvIDJWWycG1i/JEcRniN/3/Xz4y7kGfO5G3jYUHQllA?=
 =?us-ascii?Q?Ixivo3my/29qfte5kQ9lH/PiHHCKMqTAxllBRQAWZqENHRgSPwzeNeH83A3/?=
 =?us-ascii?Q?hdpif7EQK3Kyf4cNqhwqU6v94CUDi1qpLCINBAlfXDhGpvMn62O0ef8dAT9N?=
 =?us-ascii?Q?3d3IkNCEFcdmmVTwrBpfio18QkMaAljUxD4tf2itT4/0+hgjp2rCo1G+qhzt?=
 =?us-ascii?Q?vsLUKXlwzEGqMpOvrtZ/dhT1NIFX7u+dbKo1tI3xi7n46Xrz5AhnY4aU3Qo7?=
 =?us-ascii?Q?SdJIviaSt1y+RhNGqQbeJHOty00NuUOyVp2UpQN5nh623j6wUnsPv9njEviC?=
 =?us-ascii?Q?UJeiErkoacOl7a70Uv9uaitSrAInOU5HXpQoYyBMj4PeQBnqI0UFUQsvNNni?=
 =?us-ascii?Q?quvIaw9NSzBsUT5CVIKDpmup45qXze05Z4aDd7oDZS1jqfqP1zylh5zDgGWm?=
 =?us-ascii?Q?NDQ/rneQpg2cpoz7XhPLUtgWPvF725erY8zd11H+LJQoGFZIZgrNzhvzR6P4?=
 =?us-ascii?Q?/SPLn5GYPa+ZrIMj2sgzMejh1eU11ZSqpQf4spiP0+FBnro1cEGJVaJ+LLAf?=
 =?us-ascii?Q?Bayi1BFrjeB5+0mubnmgd9ds+F2pGfFgTf1F3UeVJgjepzwfVIOJErqSxlDr?=
 =?us-ascii?Q?yXtyvlogrlhYf8aXg77aqbvEV85FPjjSz69dMsPHcXAqwxpO1+thiXSsvK+6?=
 =?us-ascii?Q?Oo6qxOxRYd3m40i8oYgNR9x7LgWbN6MMWXY0/pMhFr9M65tijg/g2YYHt3sO?=
 =?us-ascii?Q?FHJbOsUV6Og71a+WfSkl4IkEJtYSoS8GGFwm0ORQP5u5co3ofLg+cmVy5yY6?=
 =?us-ascii?Q?RgD5W9GfBOaFwpP/JUMZI+xcU+PcIE/8KZSUKkeZgbKQo/kDNo7M4V4XGEM2?=
 =?us-ascii?Q?Kz88H34HK17/mi+hisFnBKW/eqz5bcN6RO68HV3fLxKOecKipc2x4CzGYst8?=
 =?us-ascii?Q?6WSv3C3WF4x6xsska7PeChNA2JNXWNjBZXwIxN9UCcdNIJ0MjVmcCh829QcK?=
 =?us-ascii?Q?EgaJqEt4DIJKxJkjhff/y94LXlHdCoDx0Vhor9g2OvFukR3regzPK41+yI4w?=
 =?us-ascii?Q?ax+CSugg7qBDGkCbnW+iSTbd82jtTJyYEzQzRRDInkgCSBSZBAZDKrwYJx/Q?=
 =?us-ascii?Q?uVs7zai5aDCLLRVqKHZvnHwn2tLvWaIp1BaYH522RL+sFdzdbx0/y2PGF2pk?=
 =?us-ascii?Q?B3OPV2o6+8DVP2br9aFnh8strBbw4HGRRnimC2MvfR0K1O/CQqSGKpmrVve/?=
 =?us-ascii?Q?wDkOIfnpp2CZSWzoLd0VizlG967X+Vcq//9tdBjb88K2Dz+J9Dd665OqlAuh?=
 =?us-ascii?Q?yhzM+EIzHMI9o3YzEcg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb41aa5-d9e9-42f1-0e2d-08dbfc6e9748
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 06:33:31.8943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DieyGxRNwo2kIcXz8Y44AKJMynnKlXIKhjKxFVGapbwhK2Qy/woOqrGuutA2CfqQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8461
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Add tst_print_meminfo function in swapping01
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  tst_memutils.c: Add tst_print_meminfo function
  swapping01.c: Reporting /proc/meminfo during test

 include/tst_memutils.h                     |  6 ++++++
 include/tst_safe_macros.h                  |  2 ++
 lib/safe_macros.c                          | 16 ++++++++++++++++
 lib/tst_memutils.c                         |  5 +++++
 testcases/kernel/mem/swapping/swapping01.c |  6 ++++--
 5 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
