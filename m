Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66096EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 17:04:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B2863CE10D
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 19:04:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D09CC3CB044
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 19:04:23 +0200 (CEST)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazon11012010.outbound.protection.outlook.com
 [40.93.200.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1AC902002C1
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 19:04:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgUcC7/aEq7DyHg78TKw46LEGaLG3/JmBagkBCc2VrdN5DoyyuFetYLdi9yEwR7JfbppC6i09QhchszxDxhEE7Q4T87JjQW6+oCuwLPyEPdhNgsjrB0fZB6JBUYnQM5JlZofNtY70yY4eCT3f38kDRHwJ3qLzxEOYRbTpAHX5fup9/xFrf/MdV5EZ1kbTOOVjY+Xz7OUJircEwdWaBm6gH90OrNwSmFPf0FHzJshTlk7VhRQNkFCJN/2fv1LDnW8WB+jXwFQgSkD6LNw5acRF4YBqD8hkTmyCloqoxRK4M61O5EXRPcdO1cPi5cNpi6++yiUij4LuPZ8JzJ1/ndP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52brRIrXOkhSKq/GLznWv0xflqQR06Mp+yomeD6cQao=;
 b=IQ+kU1B9UcUorYaALcU5brzULke4OxQvm/wu0kbbONTtBU3Wb8er7RjGfNGVkDUYtn5JJr87FdbL7sRahZIW121FLBsurR0zXcdmqSlbyV0UoK6ubFr/HwNqpyHkpcE+1BnKF/nQwfhmojhuAejLFhlbKov6VfoN3nfSa1GStLNRI8XuWhSyt2tJw7Mmj3A3WeAtcAFSiRHdgYwRC/C6sArFzb2jR4XqEZLG9bmd0GfR4ocKvmjouDK/vOvp+CcE2K9a0VR/eebSc+V0CZ2nl4YlTGDJiONYmwEI5sK00TYDcSDhlTuGWS7SKA3QiXT9/zGki7L04B+kiUF2cuIQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52brRIrXOkhSKq/GLznWv0xflqQR06Mp+yomeD6cQao=;
 b=D2Jat1fclu7ctwWXMF+OMM0M5tKYDx/DyC/gZgxu/1qLit9cxuixpvoX134ZJOBAl9Pw+XOrFU/b7wITqCZEzgDk5p+Tm6S1rcfAi7TOy35436zH4UEaaAy9VGS/5VcE16KeGvud2vZSR8YtsNZFHEKG/tNG/rGVwTn5tfj9Kgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from DM6PR05MB5418.namprd05.prod.outlook.com (2603:10b6:5:5d::31) by
 PH0PR05MB7829.namprd05.prod.outlook.com (2603:10b6:510:48::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.36; Tue, 20 Jun 2023 17:04:04 +0000
Received: from DM6PR05MB5418.namprd05.prod.outlook.com
 ([fe80::e933:485f:bd5b:a090]) by DM6PR05MB5418.namprd05.prod.outlook.com
 ([fe80::e933:485f:bd5b:a090%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 17:04:04 +0000
To: ltp@lists.linux.it, kashwindayan@vmware.com, akaher@vmware.com,
 tkundu@vmware.com, vsirnapalli@vmware.com
Date: Tue, 20 Jun 2023 22:33:54 +0530
Message-Id: <1687280634-5906-1-git-send-email-kashwindayan@vmware.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To DM6PR05MB5418.namprd05.prod.outlook.com
 (2603:10b6:5:5d::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR05MB5418:EE_|PH0PR05MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: dc762b9a-4d8a-4b6d-b69a-08db71b05a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+uRxC5iLvNyY7YEow87df4hs/h12zJRdnd2ZdNwFkFDgO3yqJO6XbtrOBARmvgb1EJZIvC2+k4UM36l9jQr5psL/vYJ/wWLOZwC0yIvierZU9U2RJu486DGLpOTKUUrjXMRuLP/ncUXVyrRPTPWh74vlO19Pyvgv5R50ciJWK/Tx9LCONjEcw3t9HaMLbMrwslRadzP4BWkxDSKYTl+plX9VV6A7t8pB0bZ8zwhB4FluYA5Y3GHXp22oezOJQy9wQW/ZAfTM0WV0W0RxK2+EP57mlm9cxMQJ6yPGgcMitZRkUafw5WStZdWoexA5NoIu4fIagQCblaLuY4Xej5gFEd16UjgcRZ84TFGuTTfT7Fv/Xpv6H8DvC+pAjnQmDmiopqD8rkaKNBu4Z2bnVs2ndwC9+yPm4A68cBQ8aglw3yfcXmKr3uxZDUsY5TKO6kfmuyLjFyK3F+45FMoirzGY1z5UExJJw5gc+YKx5yk9+eepWYtEqbVDOFkzwQGVEX0kaUEtSDrU6ospOiguRJgR0+2KrA8vInBk/pX1UypZ2tJj9R2w78D/OsN6HXKIuVnuFtP6/quPY30nf1mx55KlTldTua4u4v0AfPk6u0QYQSqwptbKSC8t8eBq6q8gUFfNYCwobggMZdRBPSl4Kye/4PyRaXCXiLdqnWgSI2XhsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR05MB5418.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(2906002)(316002)(5660300002)(8936002)(6636002)(41300700001)(8676002)(66476007)(66556008)(66946007)(478600001)(6666004)(52116002)(6486002)(6512007)(6506007)(186003)(2616005)(26005)(36756003)(38100700002)(86362001)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nC8ItzgGGx7hQnheHCTlJlMH508i/BVoBDdd151wb1IznigxKtHn8T49SP8p?=
 =?us-ascii?Q?gheoknp/I9fquE9nH9T2wDbUa8/vPHdZDsz7abLvgROEIn/dGP5Au+OviXrP?=
 =?us-ascii?Q?4Vs737U6vYEH90gpj1O4AxMd0kJE4K9ool91Jx2g33rR5ArazdYP4Iuznz2+?=
 =?us-ascii?Q?GZTgClObXXjxkkqYtsGWgOYUimD9INvwRpMSHHLdR6+FHgfQbB2XNPcvvW24?=
 =?us-ascii?Q?jDk4NpmgRICUp/2wTtRJYIuO9zX5rZqPy4uqlJnK3nUb8CQGZ6qbqzEYyzNJ?=
 =?us-ascii?Q?LO1yAKV4OeCA44SxAPWbT4V6vb0YPbWG3xJ0kbwSJfD+7NmSAR+oj/cXVU7F?=
 =?us-ascii?Q?+dkJ7fr9HmL3pFBD4Cf4LcAvy8QIk2Z6qNHlRtRUBayewnDTUjF1GfMPW+I0?=
 =?us-ascii?Q?LZ00/qFZ07PD+Y7csMvWdhBrJdkYohN6nwZJihMexrBJlwSQALx5f5hRCSdi?=
 =?us-ascii?Q?WFVKdT9kH3KU75JQ8x03CHxVox2i4OWJgSf28gGdP4AcauLMHvQukER6pYf5?=
 =?us-ascii?Q?8dV88+hiHxTSnUGMCsUwB853K9oEj+RXJwpbDSREPZ7m2z68N9gVEWO6UAcl?=
 =?us-ascii?Q?a9hASaMKOPw35O3A3ToOJUEfvgBv6TcY47QxoHKC9EUV0mtGkVoGMZbJiQ+R?=
 =?us-ascii?Q?qcri2a0vlpy5bNSTAPCLZxrOKWqXb01Ol0TRxpvV5Al52ZwE1gNsNPOq1Seg?=
 =?us-ascii?Q?8+K6EBlBTBda8Y1miBC93ncxAGEKgaERY6O+DE6+7FMk6wxuDBKLAxRz2n+J?=
 =?us-ascii?Q?LzN/P1d5xjvdhqFHMezsQGBq4LIWGMBfPkVB3FoEkFSrQcDvrwyNgYodZPVJ?=
 =?us-ascii?Q?VwD0QQCGV/55jFwpmMpeTZ2R6JdliMVhFFZt3DXOjKIoMQn/tpVHwJaxI02H?=
 =?us-ascii?Q?XXQOZDp9/nzh1S2r6K6vUOf+Mj3t872yjQgVvLmAE0pIZ1D+ImwsCCWeK6VG?=
 =?us-ascii?Q?Ox6iVToGxtS1++Wetd/3B6fTzjvFc7C6FGXLDgVVOuTWOkOqwTgfcuRTVoi8?=
 =?us-ascii?Q?qyT3SHtYEB/U3tS6+OfHoWpP2UV0IreIf5+X7F1UoF+slYjNhiUZoGxKae+0?=
 =?us-ascii?Q?Mx5NsOXXCLSHSaXchucyDMj2ueKyrJ2gN0BGKNhE1r78BLwx5q9YPQ3oCiIv?=
 =?us-ascii?Q?zWvtMZjJCBzdNWqsfPp9nbX00tNk435Ys46FZWh0xAyXc+nu3jvW2VMak9cI?=
 =?us-ascii?Q?1auiMAPGbH5Mwkr9U+HFzl1e5FKsJ7mxrYe0nX5gPPjHM/X7n4mXW+MOgKb9?=
 =?us-ascii?Q?FY5aQZjEEg+8N5R2lkUcN9dJJmtpORqeuR7eU8QskQK+GCF+gJ+J7woh7zyT?=
 =?us-ascii?Q?hqTgf5svc6UEMYl3yajtgH55CpBVWZHua+YXc5wh3ub4Z7dv2BfxGj1qxRES?=
 =?us-ascii?Q?u/HduFn6jwx5+mma3cO637DUrLZz2g2cpm0jDc3/hQhccBBkOBZJGXcwZEAK?=
 =?us-ascii?Q?PUBXcJLJDyY0saujl+T/PltRRASUtg2GKYTI4WHcU4O1xaRR5i4P1z1MR4dt?=
 =?us-ascii?Q?q5pRrPLs2uGNGPoGbG7KpRanHWDVKJh1zY76GbdqR3vnEtofLsCKhIaQHq2e?=
 =?us-ascii?Q?f02KrIukREn/VOdjeQ0gDASiwIo2e5iOZNC7KhN6?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc762b9a-4d8a-4b6d-b69a-08db71b05a08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB5418.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:04:04.4023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glD5VdDrAbC+oYqqSIKFy58IbO1cvFzYCdVrsJDc33HQ+eU/99BcJPyTpvBhFoZza2NRj0Ds7yiYdw4YRilORw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB7829
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sctp_big_chunk: Do not use md5 hmac algo if fips is
 enabled
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
From: Ashwin Dayanand Kamat via ltp <ltp@lists.linux.it>
Reply-To: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

MD5 is not FIPS compliant. But still md5 is used as the default algorithm for sctp
even when fips is enabled. Due to this, sctp_big_chunk testcase is failing because listen()
system call in setup_server() is failing in fips environment.

Fix is to not use md5 algorithm while setting up server.
Instead use sha1 as algorithm if it's supported or else set it to none.

Signed-Off by: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
---
 testcases/network/sctp/sctp_big_chunk.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
index a6a326ea2..267f1cb45 100644
--- a/testcases/network/sctp/sctp_big_chunk.c
+++ b/testcases/network/sctp/sctp_big_chunk.c
@@ -133,11 +133,15 @@ static void setup_client(void)
 }
 
 static const char mtu_path[] = "/sys/class/net/lo/mtu";
+static const char hmac_algo_path[] = "/proc/sys/net/sctp/cookie_hmac_alg";
 static const unsigned int max_mtu = 65535;
 static unsigned int mtu;
 
 static void setup(void)
 {
+	char hmac_algo[CHAR_MAX];
+	int fips_enabled = tst_fips_enabled();
+
 	if (tst_parse_int(addr_param, &addr_num, 1, INT_MAX))
 		tst_brk(TBROK, "wrong address number '%s'", addr_param);
 
@@ -146,8 +150,18 @@ static void setup(void)
 	if (mtu < max_mtu)
 		tst_brk(TCONF, "Test needs that 'lo' MTU has %d", max_mtu);
 
+	SAFE_FILE_SCANF(hmac_algo_path, "%s", hmac_algo);
+
+	if (fips_enabled) {
+		if (!system("grep hmac\\(sha1\\) /proc/crypto"))
+			SAFE_FILE_PRINTF(hmac_algo_path, "%s", "sha1");
+		else
+			SAFE_FILE_PRINTF(hmac_algo_path, "%s", "none");
+	}
+
 	setup_server();
 	setup_client();
+	SAFE_FILE_PRINTF(hmac_algo_path, "%s", hmac_algo);
 }
 
 static void run(void)
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
