Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD06C46CD2
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 02:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1705976459; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=tRR+O7IquFi+UgAZ4M8sESCLajZ3R29hdifTyJ5T+0w=;
 b=mSNcvRITFOkvxY/pZE2EWJCK/IquJh2gZsq22QzIaI+HG3j/4tBe0WjVFtIJQlc0AWzHS
 hSuD77vWDduD5oLTzunYXUHWboPyOu3MPNaw8yx0j3SgUe0Y2IkidgEpcfzD5JhQ4BWUKa2
 a190DZLB9rWIrNfofGQMgotZ3IVAoAw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9CED3CFBB6
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 03:20:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAFE73CE3AF
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 03:19:56 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2A5791000D53
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 03:19:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAcwmOtY2QJ/fsFmcSwa3zxtcvRZqfdutZgovWIFe30D7ToY7LwGJan+8UCyh07ZFRp4E9uEkEtSvTfCpNewDklCnQyl+Oa5bawtNobyrNfhIVslj9nxlwX2Jnm52RHnVJ7yZXEw2Tl+Cg8+j2WWfn48D7pJHk2E/yArdA3C2hRKiiHNMkVFwu6OCOldyT8GKpLwnJOVAuaoEB8iseeQPPXmq96khKhzyX1ZdMs6EXyYLzGm5EwmdgPxUzf02x2/OgqoCPSTyFcp9Pc1Eh9OnL8ErZTKNTIcukOt7zoiC64H1qhNfNkz9aw9MWIn5hDOwM842mktRO+T/tIdYg0C2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/V56DrBwYEntjPM0qSFwED1nQYhUI2GNkxlOMYOIHM=;
 b=LCZL44UrNJo7l/52jRc9eT+ORyaPkWYDHFSDO64RuyO7ziZJN7OYYUUDKhMvWqVhXL71sv7OUmEjJZ5Alb3Pi9VleHI/gk4B5sT/HXEtrHIo6dUcBXPRa46xVQSs1O3mSiuFKtuDToFJoXY7A7uH97asPF3a+yLAedJe+OUnBdW7WmBYEggglg52LkWGYVQZmvGEQzoTY2GvNjdc4iF4d+QRgxtxxOcbV7aZFypFm1oHpn+NEJSyRm5JGv+HjTpufjcXeE6amVwau/W1QgY120dYuKULCuIN2DP8TG+tGRIhOZYaBKwCkLLGxkMRlB6cL0qRHhmun9VkxOzkuoGAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/V56DrBwYEntjPM0qSFwED1nQYhUI2GNkxlOMYOIHM=;
 b=eIL3YHZRTPDZv6sAIawg25kLKqUsYrmh2sMt69SuEa4XxpX7/Rh5PAmYUyZC6JOWBLLfA99OXt94eSstDc1XHzwvApF4BttCt8e+gx7TI4UbE7y7Y8aqgVoU26g90NZqN+QSPz5dxGRfVy8/TMyFifcowTcOSWf9Sqcd9fXQXVVHRu+vgIQKlsd7PdOkeb5Xa1DmgK2NDgz/Q4KVDVVlEU5e0k42mZGkxATGDdZdDmc7X4OQy877FZLrfm6fVeFMWssJIObv6aUnPCABW+Kv1GWGeWT6++acOFEac1Zx7afnpwLv6MKbDgdeWSXz2MVbFawqV5Tmj37q0WMFpcUX0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DB9PR04MB8108.eurprd04.prod.outlook.com (2603:10a6:10:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 02:19:55 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 02:19:55 +0000
To: ltp@lists.linux.it
Date: Mon, 22 Jan 2024 21:19:28 -0500
Message-Id: <20240123021928.9721-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123021928.9721-1-wegao@suse.com>
References: <20240109065904.18117-1-wegao@suse.com>
 <20240123021928.9721-1-wegao@suse.com>
X-ClientProxiedBy: TYWPR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::20) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DB9PR04MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: c54782b3-8b6f-4398-9258-08dc1bb9c9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8dY1arweYW8eP9dM7vaNY3omAFB5v5qZhVrUfnPBJ9kjTUFpAyWEtXuE1w0UTh5KqHWTaF47pGvikkxu2HPDLPL0EG28uG6qoFSq32gA4AAe/wXOH8Pqj/d6vyWPo4UlEQmbqPELDlRqeDv+wtR0wIeFMcuxdJ4p6AOWPq8mzefC1cyQxWZCy7Ap01qr7QFlpro1tKdQiDxLzqFRYai0SX5tIlGLGp8ChzCUAwXBGZMd8azDk+belsntwVrkU15j2tBtmpeCXxcDMQ6IfPVAg2pTLuDyvbB5nMd80DHS3iEXTIyI0sITkdSf3krJEuVU1WpqFQmeOzz7fcHncfQB7948xGjAcmlt9vHR4IEydZlEzECfLr7hNdeeoX8Nud4FTnAb83ZbOlJxeDwzkDAVFrPRePQpnoyYmj7bcI3Z27xs3/XcK02plI2cwNYqC/Eyx+GDI89QTgZn7j1l8NFV2PhUJSPemkAdHefcBx1ALZf559JcNmnYUYuYBzBlL+rtJr9c+UD71BrbRZsPzRIAaaFq7IjZlSWQrqcne53bXsP5iW10jyJJZ9P2TYDU+xnF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(39850400004)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4326008)(83380400001)(8936002)(8676002)(38100700002)(86362001)(41300700001)(36756003)(2906002)(4744005)(5660300002)(6512007)(1076003)(2616005)(6916009)(316002)(66946007)(66556008)(54906003)(66476007)(478600001)(6666004)(6486002)(6506007)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ZDFnztxTNBLCVqnxhZOdh62n4RKvoFCUa0z7V5c3DM2KSrcYGVwZxkkHaKS?=
 =?us-ascii?Q?Kb3XsHtYZOM9c4bp+eMNdhHDWgx2SF+OScq9dACMelFAmnmn1CscWswNjkAw?=
 =?us-ascii?Q?+xv0ps0HfVMCkcER2DwBLPmaeUaqXWBPlaugToJ8Kn1ap2tY5kLSjY4bTpCF?=
 =?us-ascii?Q?M4Fkk/LH1C143kNLyoK83K5ze/JIhtg54MvI6TyCy6sdsPbG4CyUgtbe09Pm?=
 =?us-ascii?Q?EN8nohNXaP4zlKmsGAGLH0b4Bx2VaskdcWbN/tOZz7jhstgf6fgL+YwdQSC6?=
 =?us-ascii?Q?WGz/AQPEntfsaj4AGmdABtUS83DPOS1jI8PUbLtjQnif4IiGCPOL1UBExRFL?=
 =?us-ascii?Q?0zfaexyYLTrt9aM9LOIGa6PxM9YZOya4uaRJyJod/UGwMVLJmBN1LZbXsHjK?=
 =?us-ascii?Q?SQzFRQMy15OO4XIOLNqZCjKMTkOuU9VxgZv8oLQkXDlHJqEVWfXGDH+bsqSx?=
 =?us-ascii?Q?p6n57FRp5bg+e4tdvvNwChBVK7C/5fEjZ41GRPSynJ1TvJBwrDykyhmTT6OL?=
 =?us-ascii?Q?eoVmWxoavrs6BgXApSf3/X3UjM/JGO/HfP843MP5tFwhti5WUUH7qATErYJ7?=
 =?us-ascii?Q?cbOymBsm9vP1KbbMlvOERSsakbOhNIssEHsbXFCYeEyADF67oaj+txalptc4?=
 =?us-ascii?Q?o29Nkz7gjTsxgqn+rWuTFHEzZxEF5L6r96JtCMhUAwSMZo09h+vn3IloBVq+?=
 =?us-ascii?Q?2dfFm9vbE7r4kR2cu8hLlKxvw70faL5+2/ECF+S+NHVTkR+JuTXkzdK1iJkB?=
 =?us-ascii?Q?GWd+fJ/KTvJxLyqkgdoVrEuG7SlPzKq9EI3wIjLwUgIZnIC3kt3vGBf+p3C3?=
 =?us-ascii?Q?DmzptIvv6TiXdjgKMT9VebkMocrfaqKeLQCBO/NjlK/G6Lrr2N8qqJzmlVoi?=
 =?us-ascii?Q?nugJjdLYCS/kAvRbJVmLUUvuW3Y6Bh+rjn1XsQmMfwcSdFMo83+LhdotyjV5?=
 =?us-ascii?Q?HDKITLC13Xj4RFPH4M2rqb7tR36PGJFmS4oxU1nQM8SP0bFr1IilmQ9I+kea?=
 =?us-ascii?Q?COFPT+h6zrslIWcKSKh2wXOw9qP1vKQK3zV1ABop9qwzLE74d6XPai/d4d+g?=
 =?us-ascii?Q?2fLwNAsModL2mi1dwULbMxn38azYBROZvWD3vJ0v8/+woA6Uvk6son76w/+B?=
 =?us-ascii?Q?QlhcIYk7gUepibi/7tX5FIcAiDCRnqSIg/dTn6m7Vw8X2o8gfTEesEFGcTiQ?=
 =?us-ascii?Q?77RjBFrWrgbzHB5J7YgfXgDy+/Zr6RsBMk+1oQCFw+iF+lTMCMJUI2PVwih/?=
 =?us-ascii?Q?nx5tZYuJJdGpj50LFoxx/TLOje6MbnOWaH8fB+Uhnk9D612DYPwUAGCvrZJV?=
 =?us-ascii?Q?3M5NtpKCV62JbQPOtS9Fc0Xg2Khes92kfYPu2jGZqDj8IiZrlbjdhDTcc8ZL?=
 =?us-ascii?Q?vd/W7+hd7BdYJ4KbDUf0dkTv9dzdOySVnfqidEu7UHTqa5K5NNzZCJos8YKj?=
 =?us-ascii?Q?wXEUHNBF/sJIa52ahttxnL5g2CX/I+iE+9VuwmNnJNGKnrQxu9YEYU8N6Y7H?=
 =?us-ascii?Q?t6crgv20rALOETUpYTZH8FX79zr1RM351dJXINd+y/rvkmZKczniTOFJWuVp?=
 =?us-ascii?Q?sJVUypczhz3thU7OlqU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54782b3-8b6f-4398-9258-08dc1bb9c9f1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 02:19:55.1641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vdoh18WvfNFaaMn+Yk1NCoThPzZeL6PTpZDWJGHlvqV3iQGp1XhZlsqcQcZj35Yn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8108
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] execl01.c: set stack to unlimited
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
