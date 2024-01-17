Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02923C47DA2
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1705495983; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=BkmGKJd9cdppBz9OYU/shiPrwHYL9QjF9OdTpxiEez0=;
 b=gqvkYY0G4El+lc9wc49XjrORhfh++5fdmm/2po04A3keg6/ina2ZrGlJQydLhLk32EVpU
 4pSHmOV9XiuQAUKED8/HL4X3bqTkv3xrmvolGXS4b1R2t8w4Ox+6oJCs8FXs0UcKUn6u77w
 oOY8AiXS4ogpiDugYjSwS2/E3+m2VNM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26FED3CC9F0
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 13:53:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AEAA3CC966
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 13:52:40 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 476E914044D9
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 13:52:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hos96rTfE91sOwolJ8ynFT+ShINOqADfsd3pG5T7vHzTdUE1ybYsND+EYWmi6r1dTggYWg7KDLT1UXEjCN++Slh2NBVzniGaLlyv+1PnsbmsjTUSR20n6obxuFOW0VXIJc0UmUe93wP+ig2RhUHQZ06YFqMdwoohiZYgu7yKD6MIfw99Ya3OWn4I8j+Sdj5KKWJwyv8OwBdUc1aSFkwWTGzyspyTSEPVXa34nHntt+qJeweZeN5NRBJCCwbchk+dTnJzZk/mXrZpPt3+lOShKDpB5OhdRwTQOsf1NYtR16r/TtbTeOjdaKowV313NhnZX1ctDfnnjykXkrjmfEnzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZQ7vaX02BXcwNAkSrFD78bUNEnkyCh8Bw9v7DFH+IU=;
 b=FUZzA9njilI19JGNTyKJcq2cqHBd4qJGdT8cZ3HWV5Y/goimkqp8+UsTyDZWCwyrq60c0+DUpYlNols1rLK7DyjYPbZawSbodPjoJQ1dds6aXkvdckg4fqHBgHI+c8XybsWhpAiSSkg36W2ZrJstZ7EqomF+jviWThkH+wl0Tlk30Ey0sWw+6jjHL+Uvqw6Rs1mhMWHTBaFq/SaYf1gadVWRcK1hk6hR8BM7w2yj4Vphi+kBZcVKbOKBdEXli0L4Z81tbeIJAgRz7dQiogi2+SYuwD3Rr//YLfw9EtU4UW+1Z6ba2bG8E3QQNSnlPldFLa8cDH3DDnobILQQveBlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZQ7vaX02BXcwNAkSrFD78bUNEnkyCh8Bw9v7DFH+IU=;
 b=3aq0dVl/zVs3/OK5QPh3ZA5mYtbD6KYotsq0drRm4Sz5tTOB8fpy2ou+AJRn1a88oCHALE0uwkF7vrG75Sif2GNAhu46ajsHF2UC7+F8ablM0vF/e4f9Q03oHS6PHbpdEofwTkkCm9V9cjy3MhsNV6YblPQpK2XP733hIt7oVc1KzQV/QebzktlWupdu5BBt67k5GVPqJ8XT2nHFQ77ho3EDToLfTwtnTWLXDK6o5jTtZFkkdk5JPjGv/H3cFHsupHTS9NpOxjtVaDc8ELFLI5uK+jBo9ADY0WJMnJdk7egcerkaA1ZTnC3QTnycp0PZTuABRzJBoh9YtmbRaLsaoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AS1PR04MB9382.eurprd04.prod.outlook.com (2603:10a6:20b:4da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 12:52:37 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 12:52:36 +0000
To: ltp@lists.linux.it
Date: Wed, 17 Jan 2024 07:52:25 -0500
Message-Id: <20240117125227.24700-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240117080446.9663-1-wegao@suse.com>
References: <20240117080446.9663-1-wegao@suse.com>
X-ClientProxiedBy: TY2PR06CA0048.apcprd06.prod.outlook.com
 (2603:1096:404:2e::36) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AS1PR04MB9382:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d82c9ba-23e8-4bac-30d5-08dc175b2e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpTl2+WqHDg0WUJxE1nm9/I1mX8sxyXHtmIbliOmiUuPpIdOYnu9w++68p9GBoaaswMxdfpRYjZ0RIqltN+V2ldvBTSDJ2/v8C1kQWcMAAazeEAw2lFH9SPqnoAYnsx0DJH76Pkw+FUMmUxsIl1Zjy/0yjtAeiPgfUumcO41N+eOWbKA7A8MpAaQFSftmFP1L0CzWgybvaCn6TiB6CpXLwIR2iIYgX6KK9pcLMoXUnJ3Pdqn7OqSiS4ckkH+oV/l9NJtDS0SWvD9pggoDfG6zx0kI2SGW67BAddlaKAQAjQ31Q8y8HvFHo7aNMl1D+Kras7eOH4sB1JOo9fWLDPTpzmlryTrX+i1QYx+acSTRS7Sov3yRixsebEnj/J2R3XvV0k4E0qbpVmpDdbfXqrG1zFESemQqijOS8EdQuj1/eRoAzfbftSp5ySFw6wiEYgAYz+yPKDa6T7KNz/hwf5keOmUrrVb2I0EGVlikJPgPSTCVChUI3431O3RiWm/Vr1b7iVbGCcrMygGEfwdgx5ZZ3XjzJX5dac9rFtY+ncpaXknxdJaJEoZToLWf4WfKQHm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(376002)(346002)(366004)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(107886003)(6512007)(83380400001)(86362001)(36756003)(8676002)(8936002)(4326008)(5660300002)(1076003)(6506007)(2616005)(38100700002)(66946007)(66556008)(66476007)(316002)(2906002)(6916009)(41300700001)(4744005)(478600001)(6666004)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qTJSO/Zb88JYfBEfEv815zHdBmYuPHhYMxl1r9an7Qabr/3zs/Lu122w3GJ/?=
 =?us-ascii?Q?a0oVyQ99Do1duJDwFhoGFLSI9Lu/LQBH3E69xy93FUOcESq7+ZsnmXO+xflM?=
 =?us-ascii?Q?Ia41IyIX8r2kd9CmbUseXX+7tcgYbbDMzZ1aMn8Fjfi+b0PL7XbAb0Lkn9NQ?=
 =?us-ascii?Q?AUYVR3pJke9BAbxAVIw1S9fG314ZaSr0uucq7wjUVEf50/f+jJ3y07djs/q8?=
 =?us-ascii?Q?KwNx2S8Bw2D2UubY+yfsF3gtgIJJ03R1tvV8wX1J+FJV+3KB9enHgBlk4bln?=
 =?us-ascii?Q?FlFpjsQ0PQuuze9e/w4B/coed8xbLqRE6SbXWWNKake6xlCvMwV5zRSg0U0Z?=
 =?us-ascii?Q?B3IapX8kW13PxSN3NKj1o6tomNBRYe5CFCg9VwWBVF8vMn8pnTbvsu6lq43W?=
 =?us-ascii?Q?tYgjWPVondkXGYzXEufFfcll5lmTaehrz+EsSvqD45MdoFPBa7bcgYMTlUoF?=
 =?us-ascii?Q?uZd3bUvQqC0IspDXy0FjSsq7YZPTEl7FsPXHv9S134r0vlUPfAuVy+xrniA/?=
 =?us-ascii?Q?KmZmSiTdt2TXVmmOqPXSOJQDfVTHq2zM8HFFfcyueCZJLczRBisQrVOr8l5S?=
 =?us-ascii?Q?8QO3zsn8pUgMGB38S64Y+LmSTqzCiCiymTscG7717h+wR1S/XbF0sWXSr1Zg?=
 =?us-ascii?Q?YuND2dMP9mlJGm9G3x04A6uzlFdg9hDQrsqw88iiNBFaW8LkDyDObaZDhEyW?=
 =?us-ascii?Q?qZivYu77VQOc8xjbJFfJcoIZtKBsRGNR2f9plbVTSorZXsIGjcwIEa/Rb3bp?=
 =?us-ascii?Q?JbPfxeJR9QHHJI0bB2XGlBWWTiJ5kNc3TL6e32+MCR2MOpvotNWrwNUvKztn?=
 =?us-ascii?Q?hNS0zqHel/mlL4lBOYYShWsnEvrNbbwEUNvQHEnvLHzzblZsWjkvhjLNvlWv?=
 =?us-ascii?Q?qBTzVbuZKk8VAZdIFMj45W0ALm1PC4RL8FYk1FvSLPmG9J8g53t3EVPSF7FJ?=
 =?us-ascii?Q?iCzGTwVYgJ6/LcpYZi31Ziby6vr75IghZcYjn6IJyMfQXvsNXlvYTcmk/DmF?=
 =?us-ascii?Q?kpsHQv5fFCcwJKZuXaW/B9SBTDmNfIOU0Z0UIYVTNNtC+FAAgol9h5eI3o6b?=
 =?us-ascii?Q?bbO4jqVzV/T+Aq633OK2BTje6uVubpHfpZ5ZLYi608FxcPDSfcSeL3k3Cbpq?=
 =?us-ascii?Q?A9JM0+KMkBArm5sEZ44mESM883+/hO/I/NaM4fxgafTf+kn3hs1X83s6CXIW?=
 =?us-ascii?Q?aokIWhkD4r/7OWwzsDaPyCyOg4VUdE+X7OsIVyoAV1EMCRSFedk3eFeW3u0c?=
 =?us-ascii?Q?x/kquz0pOxP+/R+Q+i1m4zysZc9TXDAhBs6J5tzdq8jQ2eNb7XxTQdz1IMY6?=
 =?us-ascii?Q?su0Sk+owGnHKQ7IZRY0nf1JE07fWnigzOBa7taOW++QXqlXimAQPLQhkiER8?=
 =?us-ascii?Q?MkcOSiO596Ono6YjH9iGHPyz+At+ncPHkjrcAI+kjEEGVgHc8bAqMzeibM6l?=
 =?us-ascii?Q?uFQ1GAgS+rtO/S8Vu1ywr3Luedg2K1DkLzXFpNK5fIODizNeIUrCaczMhzYM?=
 =?us-ascii?Q?egxGF/8LvY/tMXK0ayjqFjH9N8qb4HRPPXc/XhjbE8yzmHfI/US7u0pVdS86?=
 =?us-ascii?Q?EaQulswWZU95QN+04tw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d82c9ba-23e8-4bac-30d5-08dc175b2e4d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 12:52:36.7621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlvd+KJF/oavSONLomcVHcuIviT+Z5YmBbU1E+Ah8bZy+k0kdC2lcranv7XIJfY9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9382
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] lib: TST_EXP_FAIL_PTR
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
  lib: TST_EXP_FAIL_PTR
  getcwd01: Implement .test_variants

 include/tst_test_macros.h                   | 41 +++++++++++
 lib/newlib_tests/.gitignore                 |  1 +
 lib/newlib_tests/test_macros07.c            | 44 ++++++++++++
 testcases/kernel/syscalls/getcwd/getcwd01.c | 80 +++++++++++++++------
 4 files changed, 146 insertions(+), 20 deletions(-)
 create mode 100644 lib/newlib_tests/test_macros07.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
