Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933BEC47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1706018677; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Wh3MgCfEy6VXyNx0hiy10PuTW6F+mt1MsChezeNskkU=;
 b=BIJjPOWhDBuIiVnR1RWibfsV9b2JB6nQcZ7kgXmwDnGSbDZp1MkeEZevfblAXzWzNnNZD
 E8gboBoUF73DdziBjLtxpHRwxOO/Kw21GXPsfkDt+fAC/dYz3KkkVvbZV4NglsqJHz4rrKQ
 Vw9CFIV8daQ34GczrEhqMx26Gcv+83U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D51793CE212
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 15:04:37 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3F053CE205
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 15:04:16 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 21A071400060
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 15:04:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtJ5N5MspsDZ16f8SeaxHn/0wLm2ygFp7N3y71o/VGMmC5Rq/beL9gRa33aP9yL01zELvBVbiQAYhwddpF6p5G03sCZ5oxMmj8U88NGHidcGr5AqXD1VxaqhC8mCjBGtRH3a0BwXZPcPy4su2rU+kyBx13gGQoKDTYLD3LmwSO9RCaJlty76pD7QOkxL06Jq9wYr5mvwTsPv1lqAjNZmY6ksBroTaOql2EpvCmw1jA3BSuTQlZHGe6EklWFEShvwYv654a4EicVNMkwcsR3FXsYxPtUrSt3CCzTYFcMfsf3IJSTxHJ9qhX/jduUWOWEA1fu4jwIVDjDd2Sb2ukgaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkA+wmpESBrfsyX+8CgrZM25hFbx/55YB1SLzKWLcKU=;
 b=ZToYDxTaR5f3iJk1EXE6jj+xeWCdS/DezNLHrzhn7t/o5mz3gANqhFWxdT1YUMFFxbCD5oLjUZ2N8z0sUB3AnhlQMmfMIsR2kGzs0NbAW9I5YxkzFdtvpLIba1B+elcFbS73uFytVNGGsau3vGmPXE1cc4xzL0vxgq0PcTLjfwo0ta09og1WhNF0EhvO3vyYbp1iTPKbVPDyoEQK8ZCqPvXMhpJZySzyEFODU4+g2z9pRmjQXadYLJwbUvPnKbKle4s8fDk8JeVOB8S7iDddYFJZOGtql1byvdrxOV8rWl3+2sztuXCslUwupeDYTqRsTiByuhEjQIMxvKvsbCFaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkA+wmpESBrfsyX+8CgrZM25hFbx/55YB1SLzKWLcKU=;
 b=VKlS9rkdixGP8YN0NgC3L3QbOD8ttX4j/m85JcHUIR75w6Wjss+NTQ4LtmIwuttuhm/PE+O7jef+ChU2+ifnFkMb6CfaY/KpHyg5HGIlBmGQgIH8lZjdmdBauQasf0gb+mzuGJLx5UvrokjVNksAkNmF5UnAhQzVRFxaYS3TlXKf1yTa3girmmuw0vlbPfLnOTP3IStEUXdV5Ep4ItGn6ZYdxZowWtEqBjXec4hTqY9YyTvlbq68syTVwqAA8wgTZmb9bgJYBl/X7U8QgoIBgdeNyDIOLfhs79EhxlKQiUErVKAXq88NVwjrKhpqXboAgh+CuD5WNcKyumwy1qL8wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AM8PR04MB7299.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 14:04:13 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 14:04:13 +0000
To: ltp@lists.linux.it
Date: Tue, 23 Jan 2024 09:04:04 -0500
Message-Id: <20240123140404.15481-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231230082641.15781-1-wegao@suse.com>
References: <20231230082641.15781-1-wegao@suse.com>
X-ClientProxiedBy: TY2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:404:56::26) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AM8PR04MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d027a88-c4ed-4e93-9622-08dc1c1c2d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbqYK5PyV9o7e2JHLSndUQoM74AgwMEAkt4TwRwmpkJmFuh8Fa4uEZuMGklM74fKgZ3HYufNZiWtU8cc4NSRzyLf44gSUnGMzlJzBt6ztLLqo0HBuIQ26a2t26P/lgj/m3LIkA9g8b6oTbzLgXc5cms+BfQLxoiquzEP/qd14mlbGruZfAE9a6ZWFQVOnR03e5rxyrjb2dktiL+wEZuXKmBS493OGCF9uyNQKuKnICI0+9Ls3XTFeObx5a686ioQsX/Ov4ot7zSzzCHoFLu//txXSnBeXQV/+slH3Y8ABwbnBXVG8rT7qWZce5r8oqnN9axGarV8f+5A8ENYy2JZJtQr9evf8oTjprEeYYmXaew8EDPqNmlGBPNmc9iicsRkPpK8dPVcjRmEZujwXVliURayW3uYVZ/lwaa2Z9ozmJjeC1wgc4gIUqYeF3GjLIhLYzRZtHR5dsxP+eXiTYB/NkdjXMZYFBohaVmDlosIsH1eZdrbHShOLwty+1tAlKeR4U6nymniLqSTcwAgpHNwtJR1Q075cUCcwXdAqSh9hZEcId2oA9OYy/bdFkR4h8lN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39850400004)(346002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6916009)(2616005)(1076003)(5660300002)(66946007)(66476007)(107886003)(66556008)(316002)(26005)(6486002)(6512007)(6506007)(6666004)(478600001)(83380400001)(4326008)(2906002)(36756003)(86362001)(38100700002)(41300700001)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?daCnTxgwFgCgPipZ2sjSygUb8WwPLWhwapGghMpJvOhhL6NBPWkTo+PbNzdY?=
 =?us-ascii?Q?KU26ZJDZG/BaBhb6PTxs6Vda3nHpd46wLK3LbnM2W+kF5PVhwKriI9rV+ZjC?=
 =?us-ascii?Q?C4oN+/5vR/Rp6yOT2+RhA/RkdgIi4SE01gbsL6JWQAjs4oJoipRC69FJ3G6C?=
 =?us-ascii?Q?UBLw2rnXNqAJWvPmSrnvQtbmfMm/mhTYFipZp9XsV1Py3Z97uyrhybh4gGKK?=
 =?us-ascii?Q?ManQfNkfYlZGlhZRXasUr4amXva2wpwOd38l0TjUD9urAPffQhZOD9BJr0Iz?=
 =?us-ascii?Q?7/6ujbocgbDq05cJSylkqBx+MhFMHXxznIk0ThYUb2LpoAUkL2AFLKGqX1Ja?=
 =?us-ascii?Q?zEnmPEbLK2EkfiunoATaLjY8Zgy/4J8x3J/uzu626YSq7d7iGQtcCD4ggaO5?=
 =?us-ascii?Q?Zln8BHDNubTzhsuwyIZVcbOkCcx5x+ifHQbUmuALnRL2U7mvt3AWS4jqRSLD?=
 =?us-ascii?Q?dVxkAtY5+d8ExrH/sZb3gFWwHWL4P7MKa/90yO1vw8V5msH1M2gP2ckKZmVo?=
 =?us-ascii?Q?jQJWCDhj0YNUy05QmqWcpuEbrpNOKeir6nRi+24Czy9mYsp1kQc5/H5Jy/7v?=
 =?us-ascii?Q?bx41SA+5QOjOdTMonzCuN6Ou6fBNwaX+ntM1y8Ld30H7yrpJBq7PfMq9fX6F?=
 =?us-ascii?Q?46OlGN0+tXm9UgP6rjZL65DlHXHRe62kQRF2JdsO1bpwCpBw+Dy0zwIwaCHy?=
 =?us-ascii?Q?Q3uu/PLjw8XyBHheB2b4OUzvqyf4Luiar/vKkVobJtazOJTmf/AF5qHH+i64?=
 =?us-ascii?Q?LPMFcpK+ibA2wPJ+MAFSNnl7CQcLfPsWXH7QpBXS/vtujCMTxk2mN6MS2CIA?=
 =?us-ascii?Q?ZAsJpKYY23vTrXtXqOZCigqPlIuVhzoPPV/9czR8Ab/+PZ5YMgX8lGKyVdwS?=
 =?us-ascii?Q?1spqL/+EYJplHTOCgg58p8O7aTGcsr65cPZ2D4dBOGICAp8VrhF8HlrIVspe?=
 =?us-ascii?Q?J4DyFOSlrgkfjR0kbnGeK/ssLBh8El08VHT0oAX4mzxqRlyBVAFaYk7UVW2c?=
 =?us-ascii?Q?NY1A/f0fBXiZMyjEd+gaoZtOj5Ci60216DcDIBX+cYme30FFWtwfLYc0Otsu?=
 =?us-ascii?Q?eU5iHDR7eNbkWQhXUPYqYLYroGtFmjzwCphHi50ZJJkm/BY57kEmadjp1dab?=
 =?us-ascii?Q?WY3ydVSXMRn/5izXleGpLAfzeRSHJ/UuZ8OEJeSI8i5dmiTovIktSXhpa37E?=
 =?us-ascii?Q?l8eTWItffgrlE7RdMz+M/kZ23BJuqOZF8n3xTDkQwqKURFryyapZJHUGpHmG?=
 =?us-ascii?Q?zxA4DcrY8CPjBFv8WbK3tGvzDjwOks+NwqzfX9qJQNKtjagDFGNe95rUhlL1?=
 =?us-ascii?Q?9c8cORhWZGs9Y7v/XOBGTX7iPVqCT1T/25VCSvPCLx619bQiJD4XlT9ma8lm?=
 =?us-ascii?Q?ugRb+Hsz1owzLrNE0fZry5mIFF4KSG4I/jP7+6e1pVXjL5/Yp3nfF2Yt5jCS?=
 =?us-ascii?Q?bvgJu2H/T/b0sVIMTmAqoBeesrXwxbg2zZ5TFB4aZuRwGp14GAopCE/PMNs0?=
 =?us-ascii?Q?LcSK/Kyw7t4d0pjBlfQUgfvhMEV9iDNv2wfvaTfWeWr0KhsJOza8FmV01its?=
 =?us-ascii?Q?o2SJGjXYNbxeHLdZ1FjZ6YoFOP6GoR/UwK0uWRav?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d027a88-c4ed-4e93-9622-08dc1c1c2d64
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:04:12.9139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh5Rf+/d17v/2oUgo9Dgm9XiBKyvMLTVae63mQpbBuf1FG6PBd1OjvPUcilqS7F/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7299
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add more check points for Review Checklist doc
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
 doc/Maintainer-Patch-Review-Checklist.asciidoc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/doc/Maintainer-Patch-Review-Checklist.asciidoc b/doc/Maintainer-Patch-Review-Checklist.asciidoc
index 452de0d49..e5dd624b1 100644
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
@@ -30,10 +31,12 @@ The following are examples and may not be appropriate for all tests.
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
+* Preview in your fork when change doc such as C-Test-API.asciidoc
 
 ## How to find subtle errors
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
