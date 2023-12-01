Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C15C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 00:59:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F1EF3CD979
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 01:59:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 670113CA962
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 01:59:17 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E08FF600737
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 01:59:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1G+NjT1hWFEMAktXlEQ1a6/wH3VCEjgM3M3bqSkxmMaCq3xFmtkP8TdlqWZWl0pNE8Nb+LKFhw+HWKwtPvHPVQKhfhsNTSFuBepHv7udDajUWxk5UhbPgOwgXVPMCKYzigNwzsV9vSmXU9B2Df6D7zog5njglwFe29+C8XgR2cNKUNd1r9HGAOs3WONopnYfYyRsyHdGYXI6HIIqARw6pcJCfijKH/Y5pJyDXO69OCTIDRqG87BET0an5hqZjmJv4zt+HB/icQTBLjkj7xKUstFhxD9TlKL40CPmIloH6eWs7b+OCIcx+v2NfBSkzMu1WAgYSzf4VHIvmBGubbR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOjMWY223ykBZOM5WY+pDd1ugJAf+hn59uP4VhBNQBU=;
 b=ClwWaSFdtURbEqzQ/dDY86lmG1tEARy5vB+VvG5RSes6ZWNKDizrHquT9H5NJkeVQRO3cnW3c2nZXS0vKz5UOYD1Me21cS8gVuqACBlRYBeYEo4O1qUxfn0p7Su6un/t8IvHogit0vblWi64VYQ2ZLuwf5Mwf94cNGCbvoTxnVgaE6VVlUfYIS3XsS6yTbxtENBrNp6zREsFRc9H44ks+oj1AV3rk4OTh3nANmgV+IlUOlkjkcmky1mNKAnRFbTtjt/diwMzMUwC4FbC9essISe+DxaKIxZ+IQORp8dvFhigcV2D1JEYrrfM7ALK/dIc6P4tfUsCG5IHVVSIbnSDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOjMWY223ykBZOM5WY+pDd1ugJAf+hn59uP4VhBNQBU=;
 b=VHd0FUroFMFpxR6F22+T7pd+2TpOOdqVEQklrua5SMMIcM3XLtU38HxhpTz4GvkB+dXppSHPhG3maCG1QPX3RxYlVaUe4cnYrNDdYQyiinnQBT9CLCjVqttigY5LXiLEv3oj+++XCprpP0R6+iJiYIvBerJVg72bZlBgxknJQoxA+dezh4629DduJhl0WOY6kXfgEzaORkvLdQPHHtHwasq2l2vFnEIwB6VnJ5c6KUWCO9PAAG+pgd7HYmO7ItYbNyMVog4TLakahzJ3m9/XJHHK+vdBcGict1Df4haJ/MA7P0bXGBAUIFFAVz7tXqwqos/nBLx3jpVpsL2xlCd1RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AS8PR04MB8183.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.15; Fri, 1 Dec
 2023 00:59:15 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 00:59:15 +0000
To: ltp@lists.linux.it
Date: Thu, 30 Nov 2023 19:59:00 -0500
Message-Id: <20231201005902.15630-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230925112245.30701-1-wegao@suse.com>
References: <20230925112245.30701-1-wegao@suse.com>
X-ClientProxiedBy: VI1PR08CA0220.eurprd08.prod.outlook.com
 (2603:10a6:802:15::29) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AS8PR04MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e387d70-1f85-4648-2573-08dbf208bce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsQnp2Z3kUmR5tNpWCh2GXnTxGCpFnn0tgl6b7UePvOXjsUnH2REPZTU1r14WOo3x4YpYzm3pw/HAl3Eo02rSAY+vx+hzPJ3UW7YMsooGskIukY2sW/KJigz5qRDjdC/pTtY9B1ANLgSAGGABFmdUpmc9eCNNVRIf7YSRxiwJii1jIGeNBOWikcxJ6dOD8OECfKyWoJbAwJcaRtCdG6Lm2uBds+s2rYiD9XrwZbsLV+z6yq1bVmLTK8ml8eBFYWfGLUFYa++dP8eUjZiU067v/8GHnSBL+PkWd7Xr41XHv3/B0q22JUtya2BQqwkuoZjAmcZVNZDA0vP0uSP8vCKExpZe3xrWR5HYXw5lzX0uUSNGcAEn/zH8+pnbmTscpURAoXhiz8nkteUxFhgbNSHqKCK0zdW+NWivzs0q+yGROb7DOg3cUjJEIhvfesoZYvm7aHL3eq0nrR/iQ5uF1iWmQTRE3gA1Ug1NZPa0O1wNsPB9tvGut/OwmC4ja5e784zRKn6ekTFQg5D67ubVokuEemBEpPnSvD/eUn3x4eVTZ6OEBXSPlBVwpqPMYIufsM3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(26005)(2616005)(107886003)(1076003)(86362001)(36756003)(38100700002)(5660300002)(4744005)(6512007)(6506007)(6666004)(508600001)(4326008)(66946007)(6916009)(66476007)(66556008)(8676002)(8936002)(316002)(2906002)(41300700001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lKXnDXh6uHlMBdQ0QvftGHIv4YRU9EMPNra9V89EbUXGkDKPJmvJwV/llho9?=
 =?us-ascii?Q?iJoKXuZ1xxLTzpxwqB9TYampgRLplhx75xkPEpbwKCcxPkeYtAVn8DzOVFcw?=
 =?us-ascii?Q?3WNPCslu/ascJHHUNZnzRUVEN7S3T9pREgynx3f05v0/AMhKmiCUvjt3zzkU?=
 =?us-ascii?Q?6/0mG7y2TxBL5ekjWnCJuj+18Y5VTminH9n8MIT0L/8hcLB++DE76zzO8IG6?=
 =?us-ascii?Q?Hg/ceQ4O4kbVPPEkESIvyjbJA6JlIxCBxIDwOsPQtfemmypPFGqSjgojbK/C?=
 =?us-ascii?Q?qXyfKkK2S7lnA7Rgy1HMJm1GCDXX+ajrsnn1IN0w9o6ldMl3tpe2H1Z7YMMl?=
 =?us-ascii?Q?ne94GvIF/bMScBuIwVV18csgg3IDWGHwmJbd59bjFu2i7OhaCecimkc9XFeK?=
 =?us-ascii?Q?593NQdoc32sxUpWv0fBX/Hsl6+ij/Z0s4yMH/pW3Tn3uj36VAKcoRBo+78Gq?=
 =?us-ascii?Q?ihHa+vf2ZFqrFA/WRRDn/JAZGOOZsVOlpjR88C/AssJ2s5PuOXRhJmhArq1n?=
 =?us-ascii?Q?ch6oy5ULqyo0mFHpDAJgk+jiCT7A9Z9fZ1/bRu8FatvWlgga4wjpHyu9T5Mz?=
 =?us-ascii?Q?q9HCeh6/ejVolNfTQIBw4TViLUnmQ123Y3sO9xSh4TRGZYj09X2RmVfxwnay?=
 =?us-ascii?Q?SMyTfpcokyPf0LpWqsmMyWVq419JEZBxcdLQzu7NU8rqs7BIOieYQjKsQBMs?=
 =?us-ascii?Q?7I+HUv39dKDMOxIWDCVM4ObQeklwIj0I2qCFqf7emg8/QNdArg9iIB/u7x3H?=
 =?us-ascii?Q?4hxw+y9GvaNy591Lqub97JOH57DySvz/oFquncLkWE34IBGGuAN9sUKj9hvK?=
 =?us-ascii?Q?IFOb/bNFiQCmYT43kcheJ0dBjf2/cMTe4Xdoz8F5bY8MNQ8O2XFqIkjQQuea?=
 =?us-ascii?Q?AtDurXecpvVIZsZ7xf7VhJkCMDmhYIi92n9JkTy+vcm/cwWlmOWtKBG8Awi6?=
 =?us-ascii?Q?T6sYwu8REQrVUfD0zMcrIXsqbTYkwPLN9k+mWh3ZJ7oOojsCBfgVrple1Xp5?=
 =?us-ascii?Q?D+y9HPfokRPAEjFe6Zy2enePGbROX82Gy36SE8Q7dBPegsEzOoWLeU8qScrs?=
 =?us-ascii?Q?PjyPe//WuNb/VcExegwsF0lz3l5uMRcKA7qZNn1h/w8M57NClGRtAciOLuqq?=
 =?us-ascii?Q?8Sj+u1/d+spVESfCvFabbMdvh/2QIldf4JS5LIL2CAB3+zoNMWPfJa0cJ9tg?=
 =?us-ascii?Q?AaoKICAINVkWmuNr0zizvYJ9rldfXHPTWLK7zlO3QFKiiulHTaBb23nW21cx?=
 =?us-ascii?Q?mv4Y424p5KZtmj6M9mgRHwl4ohzeRnwKIZVAsY0PvWhuBEWL0anWjZOybGzC?=
 =?us-ascii?Q?ucB2aaoyydjMnLQ9Y7k3U/RAR42fRDfYfI+IU+EamZfyXqy2GGEbc78RpRBr?=
 =?us-ascii?Q?LFc5DBefWWjKcfRcx13bHvIGwXmd8f9UIrXunap51zKCZw7Ce36CAIeUFAZA?=
 =?us-ascii?Q?k5psO0Iah3ZfBkXrA8xgKHjbB3Yi4nkesvmFCkUfDVSrgZ0A0wY9vqqx8gG9?=
 =?us-ascii?Q?8IH9dK2PCAd4NLbp+rDYM93y3l4CbVo4okEaWlMfpgRJMF7TA7Ap05RLHtmh?=
 =?us-ascii?Q?904k2Tmudrvql62oZ0A=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e387d70-1f85-4648-2573-08dbf208bce9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:59:14.8898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGa34s5QxpV/5GMfbQHGHlgKhD0MLJmy51hwnBpv5NCu+xCX8Q5XCYu6K15VElaO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8183
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] ptrace: Refactor
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
  ptrace05: Refactor the test using new LTP API
  ptrace06: Refactor the test using new LTP API

 testcases/kernel/syscalls/ptrace/ptrace05.c   | 179 +++-------
 testcases/kernel/syscalls/ptrace/ptrace06.c   | 326 ++++++++++--------
 .../kernel/syscalls/ptrace/ptrace06_child.c   |  16 +
 3 files changed, 252 insertions(+), 269 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace06_child.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
