Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E69C46CD2
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 00:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1706143685; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=29g33oLl1iyrR0Q9S+/2IOzdSz5+cSw34Pk+xiIBA7M=;
 b=XCs9nqmjFlf2q6zsDCbpDuymQe4ACh6ArVx9R73sMmknU5Xp0qCfyttgqO377b9cAGKNz
 HN0FN9qOuXyP6qtVcV1y+QeMJMsGeV76wPdCHpFjCnj/MVd0o/KwhJqRly2dHtWMVNYqHUc
 ELhqPxpzqAaBbh45ZMzlF6+YzF4TrOE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 845A93CECA2
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 01:48:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F7AD3CAC7B
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 01:47:43 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AF9FA6011AE
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 01:47:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0unxgj+8Jxaf4rXRa5BEZzAaVNWSk1LimkjYdCj8R5FwsGzgjVnDM9hqhHzpgmxPKaBrYnCJ8mJZWPyXBBoRFyxxJg1Gpd+dTe8kbkqEdu4Vxt9JDmreC/3vKpMb8IPAW8W7Zq55RX1VSE3LFXq1YUQMpbpB6JOgxEOEvv2dz5uEqtX0zriF3CAewjUBx/IltYLb4eim0XHo4rRy5gpXNq7LAAXfDVz+koBgGg4ssjp728/keSbMJP4Z1IA36wgoJBf5IL0VWgwb8GLW92tc5qx2IchheG0pP1FXMd8ZSfhuZiuYqdwkAbgA40bk1BIVt5skHGW2i1e7UX7Hd2d1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljW3lYI6eSWaxAHZUw1PNuZtB7Hbrfh7fKPvWUkFEIg=;
 b=lnVmfbPAh5W64uqVmppwAJJ26qTVA3RrIN7qIaO/EnlldClN64n6bUt5bwoA+TNF7zrskqwlZn57WH3iMjceVNOabCy03+rWPD/mg4KIlm/F2ElIOwQPCx4U7Prr30O0zWr0yhuYmlMf0VzcoQwTwKaF7yIJIxbyE2dEgC+SPFgKQZrbVskkYupAVfC0L6oHVIM9NaW8ZCs/fdnJxb/L/TXOxk4AMDNMlHRrIjzSOWaBUvTMY8F+fFlR4eH+Cm+cV+v4LYTfajDOA1UXP1wyu2Tx1njHL90XAdY/CmtMC42LyOmLO1QlGoR5csJpJcYDvfLyG+458ohIryWaXuQNNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljW3lYI6eSWaxAHZUw1PNuZtB7Hbrfh7fKPvWUkFEIg=;
 b=uKI23gnFSIc0EB76LYAADlhdHOIg9P5evucN25WbKJzdPQm8gbEdOavH8YIaij1isqwmvIsmG8uxmNicDqhJoGJCgDYe1kzNgfVYQqQebbKVY5XSBs7B89ZMyTtLypxJquM7wnJprzCcatQ3P0JSrPDPwt4It3xc3stprm6oOTSDZPgIYrVPHGFOnYgYo84p6ymL8Biiutfl0SjAa2mJdEfTsN0GgCRX+ZNtipPuPG7/N8Ttm1Ahf2mUH+RLoNmgdJ+N0q9OYegtqnuIj9gDnq1k+iia9QfWvr/sGfKkmFnBf+8dr7o/o3P1XbofXF6R4VRKCjZByDnp+xSZglYH9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PAXPR04MB8191.eurprd04.prod.outlook.com (2603:10a6:102:1c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 00:47:40 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74%4]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 00:47:40 +0000
To: ltp@lists.linux.it
Date: Wed, 24 Jan 2024 19:47:32 -0500
Message-Id: <20240125004732.9549-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
X-ClientProxiedBy: TYCP301CA0012.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::10) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|PAXPR04MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2aaab5-6aa0-49af-c54d-08dc1d3f3bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKt8wlg/2auuEyifcmOBke8uJwJKvZpu3u9JFOviriZuD6/Hl4H5GpD3lxfESbaPTQlYnx/j4z2QFUoIa8t3qG8dhoC3QDand7W7YcitJBVPyQ4P5Sybo28wF57AP1m0mZc7kl4TOPpzTqZelIP9q7CZ6rV4xI3CH0V/k6lklZhbRhSLtHF838wl22vUnCwEWPdOKp8qko2GCJ8nb9Obnpxz/6duUsokLhaoaKTB2zLUOrWOnl9ps4snnrLuZ2q9K64CYjNvJBptZQ5fVvw/8ikVEmAx7YYAGRA+VDpoXpkoDIOi5IgHTWR5eyuL1oj1j7R7b97Y41hfcany8UfUVDJaKX0UZQepp6Ka+Ikr1tajtczTeBTiChTi3EsyuEHe1Blhi6Eqd0AC6Bf1bXXQ1y3lwkM608EbkIWfgQojLsQUr82DGmf2EZPJXvZ+IrwrCTsz6BsB5ORrbEiKOXbSLhaHWu1KDjHvH1fxNzr2nglZdAygJotKaD+Kp6kIbC9mbyrB4YPNIt7LfPLS7p1CyXCp3zY0vY1VsPbGLLwEEQ/2B++8Dc9FsjqCRQ11ATJm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(39850400004)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(107886003)(36756003)(86362001)(8676002)(8936002)(4326008)(5660300002)(26005)(2616005)(1076003)(38100700002)(316002)(66556008)(66476007)(6916009)(66946007)(4744005)(2906002)(41300700001)(6506007)(6666004)(6512007)(478600001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OWXL6BXeFcUd0U/XgsXw0Oxq5C1+04ERKhP55EgT2TcZVZ5tZsd0aVb+iqOo?=
 =?us-ascii?Q?eetnnfeD0hgtPuBwLS699Y4GleQ3jBd7D8J20BUrSrv2fowmNK861fB7mZ9c?=
 =?us-ascii?Q?eIFEDftMWJL31HrKlQ7pcfPQhyc1hmdtAZU3dpOMs7nPcyIWZu+Cibt7/dkE?=
 =?us-ascii?Q?kkwVu8wkNZD5aN/mBtyC+Iq/ira+g3u7owTGelsGma9MMRQn271rubFRhh3H?=
 =?us-ascii?Q?DlFD0Sx9Py10c2zijiu07XfZA5qDErT+r6VVRVSqJXhdwo1vKVF/nNpyhN+O?=
 =?us-ascii?Q?L5ay9X75JtxXWogGfG/qRzPX1vb4KkF4OfqymHD21zL7lYYtdgC/s37LHuEt?=
 =?us-ascii?Q?LAqMcbuIJxex1gI3SWwooBNocXgQ31uEYCxDIkE4BZ3hPycgXUgtpXeVcI50?=
 =?us-ascii?Q?37y2pWEgncH0cKUHURo46jnyY8SILYjqfR5klM0bp78/SiKdGWN6S9EPkoau?=
 =?us-ascii?Q?AT+QBkACupvWlAdkm/QEOnqD4D+MU+zZkYXAGx5dDL7z6d0dxm/AvBXqh155?=
 =?us-ascii?Q?+OtkaMnvNQDbM8qOueYF/i7b7M4d+jmA2nmeSVwJwn8LtxNuveKG5JUQnzF2?=
 =?us-ascii?Q?l+YwFa9QdeKZ3sOo3mjcB8+7g25xUN7lVCkXEqmxXpD4vNckI0rqgQhgU4vf?=
 =?us-ascii?Q?juVAqlJ02WF3IreSj7FYUEjvG2XRbca0P9oxfIL5KdeFS4IIR7+yvDjpYekq?=
 =?us-ascii?Q?fvhu1i3kS9/U2NUW5ViiEWVZ+NQWLDCZ4Mf4aC3E5uTGamYSYyfkf/qd5vD0?=
 =?us-ascii?Q?HhJ/kV199r3sDI2LJMk9jGj51Qiwbu8nuf7sm19d8bkgeOF+gCm4nRBZ79G0?=
 =?us-ascii?Q?qj5gCEtNL+YW8mZPNSOfspO+loWHtii6ggU0krfsqj3Eusa5+M1jqzV9aFrj?=
 =?us-ascii?Q?oN4/Q8TSCc+41IBIfTccUTi3+NsOyO/OSwCq3B5LMa+wE2/+D1UuDoEbzMeW?=
 =?us-ascii?Q?GJ1m6nUE6aSffz1vYYQRvQgsAP/iEWPgXPlOWZ2tJ+LNOnNecNTCy78t94pV?=
 =?us-ascii?Q?4OhoEezty4r6opW3Ytqyo2oWAqDQ6w1Z0jEqZfkm9EZPesvw/8y7xw178DNJ?=
 =?us-ascii?Q?Zgsw8qK262TjifphraJuzXztNmHQVHfW0uOt3lJKtIQiOU/cNfZxisWbBOVK?=
 =?us-ascii?Q?bEybn3d1uS8JRFBOPJyafeSLwmLd/6YnMQFv7gEXrKCD/eVXfNgy0AEWCeQy?=
 =?us-ascii?Q?R0nAiaH6SVsDzZvrtOqiRVxqfa+j4uLnK99BV/hLze/ceaxAL4lgUbW71vZd?=
 =?us-ascii?Q?4hAPjFRmhaIGClXocZsjs0wc/7oRFP8Z4xLOzgVsl4C9DPZIWGZ/CCGyR01h?=
 =?us-ascii?Q?2EH0331q2U8OHdE9BSYOOUF+/Hq7rtX5/7GTnrDlHLXEw20dUl/DN/CQvvgW?=
 =?us-ascii?Q?IOLLDS7adj7y/f557olzWGZ3megLgtDl4gPZxkvj4qlRMz5A5BWy1G/wjNt5?=
 =?us-ascii?Q?JPtR0k6zFb3Abs2b/PtUygHxrg5T7P6kJZzpwZURAgLl++Uyp0lZ8TLY/Qp0?=
 =?us-ascii?Q?fZYGS1gKDlh5+avrma1Aa5en9Lku2ZgwUoM7SdJx75ao5fPuC/M1lvmJ84Ri?=
 =?us-ascii?Q?FpouAgPXwRWUrRC0D2o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2aaab5-6aa0-49af-c54d-08dc1d3f3bbc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 00:47:40.3862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76MUYl2mThk2qlMeHYAxvxEw0IkiiXXxgN7Q7Z8NpWCD6OmCSlG9gz0OxrO9JHB0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8191
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] fs_fill: Increase test loop device size to 1GB
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

On PPC64 the page size is 64K and this causes trouble on btrfs
filesystems of small size(LTP currently use 300M), the threads
could compete for a very small number of pages/blocks to actually
write the data. So Increase minimal device size to 1G avoid the
corner case.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/fs/fs_fill/fs_fill.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
index 2ecd8e2ad..325e83643 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -123,6 +123,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.max_runtime = 60,
 	.needs_root = 1,
+	.dev_min_size = 1024,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
