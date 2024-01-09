Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79033C46CD2
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 07:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1704783638; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=4A5EGNKIEO629jUDWgVMTHxc6KEL+4LgDQ/rxiMOwRQ=;
 b=UHuvvNePWRGy5CQm/RqRdEQJ1LalrOdU+BdtDvG6KgFXbqZqpUeXzQmpFeLLnXH0zMg3o
 +4S7F5e8OFfgl4fNj4cko3+nt6aKomiNwWXk5A2LmUJ9XU8qA+ws/wxLgU9SwS07X8OvKPJ
 ry/sh26gXDuBWbXMKmCF0KmE7nMJWNs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C77803CD1A9
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 08:00:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EFEC3CD18C
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 07:59:30 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D9AEA60081A
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 07:59:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gakMUFoiR3CBBzQnsaBTlo+vDaq4FhofqM6ZEfmwEFSEmIFPYGdjjdp857oubAowJyFrEHabERLkRBxShwTjMehll3x37k3oGXMgHLxe2wSvboWji/wov7l9YT5yUb2shMHVDEXWm6a4/uqYX/c4ow+RaZ1WnPsGCX5ra8R/atunO/PQ7m659lt7K5IlFPslfXpBnibSwC35KbGHzBa1n+StfxgTB2Tz+or0xKrkDRCeAIgrele7nxBA4LiYhCd/mooM8HybC+NubIZ21SEioFdpUMWJHfIIUpchHSyNLGSF88x2b+IkEFft2PxRHMEFzLjFvMeSk9EqCYTNDZGXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDWI8Fb9T74yY8Z6qKHCfqWy5WjDHNXTClFD6+dVgEM=;
 b=ZdVl7Q5uuWIjvBvBnHrgdmf+DjavF1xVr1hOIpSnMCu8bCuEmNVbuMjjCbcskQH5pJicHNSt6DnvspZ+Rcxxkp1GqzQ83fS3LMfBimmXEudZDaFnz0j6nUcU3PxzvWepDS6bRgZZzlXxs3jlOEFLS+OezX78RGpS4YMXeUAVE9Ryfr63hPe8pXBASkXK0GNR3lwLNV/ACeS4BK3d2aI3NkXAffdkdEYnwgOEo702+K9Lvd/b9hZetHbrSJyhkcmbmAOUlIXRbyxrlR/gKqgerF7/5ELCQR7ECdv1W3O19BKwlC+s/BGcXVxIfI7s+2z6JcgmIs9h9gah8Z/b/WaxXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDWI8Fb9T74yY8Z6qKHCfqWy5WjDHNXTClFD6+dVgEM=;
 b=rcZJSMFp0gWNnn2XdEjtkrGK3pEiyrYXOBH/SyAozfRlEzfdSzmSaL9tLrX5aYblqAomUqI0C2PtNBe9Gclr9ELWH8FvGSoiArKoiDhc8eZSx0gjprstPwW5johEP379bt9h/X53QHkUxkgAgWYdLdRY194yilnRZqhLO9tN728FqnmbQ/RPAObpYEMDOWizJtJWvNEb0Fwkt1OZ5XYvK02osN/wSbHW8TEUCFYma8pKlNe/qQj4v0UJyKzPoCpXABd1nxALS+GZ0mpDmSmuk7pgBYd+ct8O8xEuyu9X8uIQmA3Itxbg5qlk5MlsDhBR4TRYRhpgvEdlObi+d+G+Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 06:59:28 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 06:59:28 +0000
To: ltp@lists.linux.it
Date: Tue,  9 Jan 2024 01:59:04 -0500
Message-Id: <20240109065904.18117-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240109065904.18117-1-wegao@suse.com>
References: <20231025083706.13767-1-wegao@suse.com>
 <20240109065904.18117-1-wegao@suse.com>
X-ClientProxiedBy: TYCP301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::15) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f97e65-70ac-46c3-1a02-08dc10e085ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0f7lJ7GztJ6AprGDnHC7IH0UMWgI77SWsTXx86IjwBQ/PYGMaJAYmo8YKLC3aRjbxF7crVEg/6pnHZwYJJ0WcGOJh1oHZtQBHSIPQH1ivr5KZl4ozO7mSf5tXUEw3msXSc+jOV/IwEGHEhFX2YovnyTR9j1Wh1fkR3V5sSEfW6Qv+7kL7kTQ+1AYSBogoobmEdRW0JbC5TRsswGZyfK7hFbgY/GVVN3yNJFCvryKUyot9neLDwQgWfTAkGkgXTOL5BKJkkkQ68M5iHXOhVyxBZnJfVjp9f6EMvbOnXsRDk9J2CcF/J+kduh898n1r8WKTfXJF1Y//wn6lMEANbOJhuPuzwXHygkwb3cLhGIexbALf908MT5OyEuJ/ixNQhuZ1+80Td0LAWeYdNRSaa3+qWVgXdnriH1PZgoSFWSt/1uThP8KaNG19FeDyZGIJdg5yh8qydfdeNGq0/+SBSXAwKGvedbEn9lKFzNlKu6/y+rQaxuNAaS7CWIHGngOLOujiDkLMnpNmJdK+Jdxia9A8a1jKvpb/PUa9bXPbO99J2Mpn+TZAmPuxD0DE6m1Wz5W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4744005)(5660300002)(478600001)(6666004)(6486002)(107886003)(2616005)(86362001)(6506007)(6512007)(8676002)(8936002)(41300700001)(316002)(36756003)(66946007)(66556008)(66476007)(6916009)(38100700002)(83380400001)(1076003)(26005)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?konH4g6e9cKNYXWn4SziTRQQXf/2Iq9CFvEG9yfHVNj3taNvpl+fBU0PHcYK?=
 =?us-ascii?Q?rKiKUHjfNBT23op5m8wDx8sitt0f6htCd+Vm2UEZWjP8DzJApsLmuokAcPvZ?=
 =?us-ascii?Q?Mgums+MzXOD29oBHcmvmugTWkt6q5tye5Qzv0aBzt4MOJhvFCFyN0oiut1kF?=
 =?us-ascii?Q?P2qaN0Tzv7226aTIQTsMFw0Z/p9JJH9tllo4rhYhIA1cqkiUTUQoOTDe8YG0?=
 =?us-ascii?Q?yYUNt58galee1I04QQJJVbNXfvVfq1Dw1Xx/C26u3FPVV+kEsYE8FFqQgyWX?=
 =?us-ascii?Q?Z1QdxTVxe5TS8i5BM089Y6vlvp+Fn/taLWeaUmMZH4o0C2NdLcJW4dZBn7iD?=
 =?us-ascii?Q?NkzRg43x9tENu4z9qBjBreCJpZbJ2M3VeQPtCFVqaOkvo9vXV+KhTHo0Cona?=
 =?us-ascii?Q?M1IhWnfLrl3A7q4mTdWeIhFIVgYa1ShsnGzyQqP/vqNAkDIkEe5cWqIZ8pNY?=
 =?us-ascii?Q?P0hEOLO8i36m9kgu+G1VdeZxsq6KW9LrlFcCX1RlPw96nLMv6o14e8bjB+vG?=
 =?us-ascii?Q?gxf8er8WWrLZ+waDULF8oTWQg8BSGDmEq5+LbUqUsmxsqQQVn/jkTKNhvwnD?=
 =?us-ascii?Q?aU5ZJ53J8UXfS2+eldESvLsUEjQo6l6Fh/iqFlTQAVoYj8144bzehiQ0u1yh?=
 =?us-ascii?Q?nORhNQn3DDYKNr3EepTzON1TQDh9tg6lgp4wbxV8F+2FJoIbWsEhSIQRtrid?=
 =?us-ascii?Q?uegqTkXMlVbLIBrEkZSazGbmSAYsrHIa0+8Aly74YB5XrqaHvoYg1CPJbf0S?=
 =?us-ascii?Q?s3Anta0kIGFzBTGQZKhOb6+yQBjgfgARgh4WuOaB0N67roFMNlF+9aYGH3b0?=
 =?us-ascii?Q?d3ReOuRCo2+bsPw0ON+qUEE+vWcQusYvh702jSPckH9UnubcfW5RZCy9JA9E?=
 =?us-ascii?Q?kH2yR1ghNyFWjcMLYLPAOlTRNfkgg+NQtBWFL44WJwJiBcQjYlUkSnWy4rj9?=
 =?us-ascii?Q?ACYqHbVlesRWCrWIHJlPXAkW59a2nmeIHAI8nmzSYjKMHYBHwR7gzfudx+Ze?=
 =?us-ascii?Q?AzPVu6FvqB0Al2NTd6HFJuORbyFoIs1kP6xn4BYwPK1UMMnOAUaNVDgWe9/v?=
 =?us-ascii?Q?5gg2ABD8hQYMymGIl7y/DbIs+URaKKEl6agnBvNOpcwa3yNd+dB/cy9LkMV4?=
 =?us-ascii?Q?M0f6gFl/8IVKNwCQjR9ztZj2mMSQ37c0uftodKl2SuNKzzmEr5Bbotz76viK?=
 =?us-ascii?Q?gqJDimwAw0kN8xIlVE9vpZHqigyZYnPvFgXamux5O/aSA3Q6HSI4RlIkx5q4?=
 =?us-ascii?Q?0RV4bmGp6Jv3fHc+pja6WGSucBTqIDaY1WePp7+8q5SehTxGFbC3Kbr8evxx?=
 =?us-ascii?Q?99vI8bFa3nrGJHIVYYCuv8qbQTyAbOy2Rxbvbi8XDRphkDyZ7afWFlOnPyqd?=
 =?us-ascii?Q?4GUYsakgUe3CbrbHpJi2O9vpK4JmKiVzhLaE8fv/giEwsN0zTg+BrPByR+7e?=
 =?us-ascii?Q?NfhqZiglGGKdxm0k8mcnMoh3XUs4nhO60aguP0u/7VAqV8bvh6XxnLnuiPaZ?=
 =?us-ascii?Q?LWLZ6Cnay6eZSEJJukKKo+3bDmrLbGKZxDqtGgeTNFZw54VKG8WMg0HA5kn2?=
 =?us-ascii?Q?nCgbsjsm6xo99yBHdkQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f97e65-70ac-46c3-1a02-08dc10e085ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 06:59:28.6288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HdhWzrcxrl/Z9w3y3N/+Ds2ycqzXjQhTjfTJ8q/ERxk3I/rSY77vPxuxTI1HywQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] execl01.c: set stack to unlimited
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/execl/execl01.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/execl/execl01.c b/testcases/kernel/syscalls/execl/execl01.c
index 9268d4976..dfefd1fa8 100644
--- a/testcases/kernel/syscalls/execl/execl01.c
+++ b/testcases/kernel/syscalls/execl/execl01.c
@@ -35,4 +35,8 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.child_needs_reinit = 1,
 	.test_all = verify_execl,
+	.ulimit = (const struct tst_ulimit_val[]) {
+		{RLIMIT_STACK, RLIM_INFINITY},
+		{}
+	},
 };
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
