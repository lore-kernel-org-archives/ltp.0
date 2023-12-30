Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC70C46CD2
	for <ltp@archiver.kernel.org>; Sat, 30 Dec 2023 08:27:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 673CE3CEA13
	for <ltp@archiver.kernel.org>; Sat, 30 Dec 2023 09:27:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81E5C3C94B8
 for <ltp@lists.linux.it>; Sat, 30 Dec 2023 09:26:55 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 267F81A00E71
 for <ltp@lists.linux.it>; Sat, 30 Dec 2023 09:26:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGUG25ev57nvtixqtvN3jbb2Qh27SmypVQg8z67fw8xnDzydCaL1R/ONfE7omHeYDvP2yneTJPlEVZTL/GkRP9stST2ydNmSV7Is8ezp2MIfk21jL1ktLeZNaChMicqjyeha8TDisnO0FGB5ntiRBb2+/oFWIlrGN+dqK7Dx1SjzdPUCyPeYLi0An+/Pf6Y+hE78j8tUtf4Mv5nITX0Felts0WjbocptMoehZNRUd+efdv3EcuUyP8sFFmZi1/J5SKE+5Sr4MOqtc1z4MWBN8zqiuymbdLCcjulwwGE/LS/t8plwneDzvi5G11yCfTRL6qGd7yK7A6FfqnlOFWe5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m714aFs5sQ/4/g3j4IK6x4/pq7Bd8lqJCDt66Lx+6vM=;
 b=KflSOaFtUWjWjgHueGetNlWJONsQLL0hHjx6x8sYkHfyfmXOBPTZ2HO5gJjtWDPZUV5hrrS5qC5Z0qDWcX1EMtKo6GnV15TJ8hJEV8gg05RMXJ/xmR5XC4b5ze907myNWswpccPwr9TyeRa89z9EBofv8mgwneykNcWOpcxDi3556asLU1KZOv2DJ57S5jDCy0XSGCE5s0dsGRh+4VxeQUtqSTIbj7bIlA0BIWzUI+U2tIKn2ACwG+AGoeHkfw4iM93NE15SDj4a+FnKEZ9L85g8w9ZeH+P+LPYHJFoWX8tIgPWYRqtbv5dv8kbVEw2RhFTb5GfZN+aO+X+t91vj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m714aFs5sQ/4/g3j4IK6x4/pq7Bd8lqJCDt66Lx+6vM=;
 b=eCOvHpEZUr87u6u+OPywRkQmaTRnnvSN/93L2liYsZ3K8T+63/yhIGCVgzp9lPMDF+Okse9kG2BXUyx0KYHgArWh86Yph049bel/AICTLP38AgB2jrsP3SRhhhrymKaGZdL/NIz5HQTQ2m/W6LgWvCHxMU0zS4zMttyo6Wbh9g/fXbh66TVAyzuMJZ3DbrWPnJ0FIwRKDckd3QFPROGd1kAyfaRK7x77Zti7eTeE+aNsG0r2AM1X2qJGPAlCD6pKm1E9IPJmp96cgXHmTJWqcmAt/7thYkTfcN4LJZWu17RmUGl1S7FUmCiCOZQXzKtl1UjfUOUFyhKCSF6E7r8jEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sat, 30 Dec
 2023 08:26:52 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7135.022; Sat, 30 Dec 2023
 08:26:52 +0000
To: ltp@lists.linux.it
Date: Sat, 30 Dec 2023 03:26:41 -0500
Message-Id: <20231230082641.15781-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
X-ClientProxiedBy: TYCPR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::10) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: 03504013-4969-4e77-c0d2-08dc0911131f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aD+1E3zORSUpxu5HAbTKX8d1uGd9PWORgA9H9O7cnbuylZZkM4faJQYLryTi8rwyEb7sIm2S9fTWPhzd0yoe18BbJypN5hAxMcRvc94j94YUPnk5ikpvOrY6z7J/FNbtP5hQjbnVzip305KVIUvp5bzK4nn29oGx9Mhi1U8FYg3J90H0S3XU9xTywtAaUt1SKl4QwNwqUuDAPlz+3CsvJNFV/zFNBo0in3sDbw7Xy/lfahla5pc/GDDVWMdev2N7OGdMaBe8uF2GapYRM5Q40h8urJK/UgtGfVbs9PA7uRGdq/Jgh1mXRreYmtBfYqhl7iN1+k2eyPgnzrvIwzUyivzEkp198Tj3USkj6ORrBfzcfXMUOOYRhb5RMTEfICsxnGo4ZLRfgelVuzAc1ibMuPFQwS912qUtd5N1cbGgvvaTG6LXKriHoLpTgggRwvwpwLWmzGeBnmnccUaOJrcNGuBvGG+QBMc0W8d4L2d8nAdpBSjjNz2CUyninCZCgfyYNCk182NecLN8ZXLIQMgM/zfeEnDstnY+w7OgAwLJ2Y39h1YlZ40EcvXmpmjvhBXh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(39850400004)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(36756003)(41300700001)(86362001)(38100700002)(2616005)(107886003)(1076003)(26005)(83380400001)(6666004)(6512007)(6506007)(478600001)(6486002)(316002)(66556008)(66476007)(6916009)(66946007)(2906002)(4326008)(5660300002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0vrU4026fRaIKZVu/H1JwEIOmeyvwf0/jBfVNFfn2G1abB+voUcmhgW3RwL2?=
 =?us-ascii?Q?Wu6MDzPRuy6rOA0s+goU0xOwo7qs4LaT2Cv+J/5dv3Q/Odms7gSl+/H1RqF8?=
 =?us-ascii?Q?ePVg7VQOEq5JrmD65ZFsTjZMZcczEo5Bm9abJY+spN2wWBcXGHn8nYkqKLa+?=
 =?us-ascii?Q?eD1Zbiufn5bYBYOPg8CRf/SMy3wAHWX+gvlhpsFXmDcDzvXU/dXBC+/XDogW?=
 =?us-ascii?Q?4S/qN9vo8jXeuwF79wOJeQfvBPKHuaEdzfYwltOtbPDExMo1jsBiyhevID0k?=
 =?us-ascii?Q?5D36GETCDap4pe5z0n60mzc8aE6NRZsZi33NE21uGYNoQLzagBWox8A6Bx5O?=
 =?us-ascii?Q?3bEuP59FtyOpgcZ5FolTl6QJdnbSIDn98yI77WDHEkABKmhViqB8vbwJCCfd?=
 =?us-ascii?Q?Afwx2ahqj4hoR8Oj2bRYxSgAEYJnZC4Ol7jLceLiIHz2Q7v1Jr0UJedqWm65?=
 =?us-ascii?Q?N4wH8vLCuP7vxqtwRgAmJFLf5nYeOoMW/mb32eUJ1D4gdwHsAwAmjiCexOG0?=
 =?us-ascii?Q?k8x+I9M5y9QHH3aa2vMmYSJrDGO8TwEwQT/rcp+aqlwh0LwOhn6KMI/oGFyp?=
 =?us-ascii?Q?k41tNmf5xLRw7yDTeUlpUFSGJrMmMw7j2TGeIuG0BxWagofmMG77MvR2z3zd?=
 =?us-ascii?Q?KFWYDtTmGNpZkl2PGqhyBm6hSstbGU9FdL3zHyWwqlu6Pv4shUmK56uU7TcE?=
 =?us-ascii?Q?YxJJdpUVhyZ6RrReIAw+R5WxFSoZ+FGB1+1pxHLYMvgERC2Tibn8ntO1Ej1h?=
 =?us-ascii?Q?dlrotYwXitq/Cly2mb8kNn61uemO5wz+bX/oTippM4iwZ3dLhp3ADesFu8sO?=
 =?us-ascii?Q?ZayC5e73YdVxE0Joj0VeRSQ5myFjfJ5zaJ8/hn292J/MKa/L03Rz7uzgUFWh?=
 =?us-ascii?Q?U6O3+fA4vpUzmgAgtWzxxNmcBJU1ZZLxX0w0GW6MP/2DHsSFahHi2N7YVO3/?=
 =?us-ascii?Q?iyHCx7+jwOD48/8T70M7nxCwHaQ7UnvZTuxXXoT1iVmG0gIeADZsCe2WeK3Z?=
 =?us-ascii?Q?/cUeOLBM6+eg8nvAB5XQGTmFMxyqHRhCU5eTd1oC7We1biEvIqEyzRH4YKqs?=
 =?us-ascii?Q?wS7SKiGVtx4EG06wBYZeViCpKhsBUNDkkUP5NanAY6TIIr7aZ6bGccwXS579?=
 =?us-ascii?Q?PDoBvbhKfySRWhRbKS7Liy3OkM9Q2Mo4N/nkCOotgDzmxysWzhJCSnP9Q9Jp?=
 =?us-ascii?Q?Vm9ycYuW4GxBYA6PO4IZYRPyrDgOZZ3oKPXlr3oNAeTL+YW+hIskJ/Ee5tUe?=
 =?us-ascii?Q?aGHCy63tO/HBCoyjWoC9VxmcdCS6j9t/5hXAvdYrytI/x082hR9yqTbP/4Hq?=
 =?us-ascii?Q?l1HkumjAlQpXK8nj0W+A8KhZxZjZ7lpF4JWZGIF8yHO0UrmUjT38gL4yOLTY?=
 =?us-ascii?Q?A4GAPjuJC+s/1ndFKIsLl1L54xwuT7l+iLmlDHGINg30a92AMypHmWfu9YQ8?=
 =?us-ascii?Q?eobgtuRp7Y4P0Vbi7hMYgqzj3awzJc7hmHRB1ScQ5HZygGWMqpiuZfifc/oY?=
 =?us-ascii?Q?q7+3scYD0OoTRmzZPIgdQGltnj6fSo4ySiH/OViql+hSQU8IXAEJUhhDAmqx?=
 =?us-ascii?Q?HZ+UrBNLgMesOJbm4Gw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03504013-4969-4e77-c0d2-08dc0911131f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 08:26:52.0885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jS606zxxiI/CVzpKT3/mP7zER1ObDVXpAHgpPX6K/+Uin/jhgAXvce9/LE9Exe2s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add more check points for Review Checklist doc
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
 doc/Maintainer-Patch-Review-Checklist.asciidoc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/Maintainer-Patch-Review-Checklist.asciidoc b/doc/Maintainer-Patch-Review-Checklist.asciidoc
index 452de0d49..8bc3468a0 100644
--- a/doc/Maintainer-Patch-Review-Checklist.asciidoc
+++ b/doc/Maintainer-Patch-Review-Checklist.asciidoc
@@ -22,6 +22,7 @@ The following are examples and may not be appropriate for all tests.
   - Use sanitizers e.g. undefined behaviour, address.
   - Compile on non-x86
   - Compile on x86 with -m32
+  - Test patches on GitHub Actions will covers various architectures
 * Use `make check`
 * Run effected tests in a VM
   - Use single vCPU
@@ -30,10 +31,11 @@ The following are examples and may not be appropriate for all tests.
 * Run effected tests on an embedded device
 * Run effected tests on non-x86 machine in general
 * Run reproducers on a kernel where the bug is present
-* Run tests with "-i0"
+* Run tests with "-i0" and "-in"
 * Compare usage of system calls with man page descriptions
-* Compare usage of system calls with kernel code
+* Compare usage of system calls with kernel code or commit message
 * Search the LTP library for existing helper functions
+* Check doc formatting e.g. cd metadata && make && chromium ../docparse/*.html
 
 ## How to find subtle errors
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
