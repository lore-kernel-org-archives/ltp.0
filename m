Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EA0C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 06:34:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98F713CB4B3
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 07:34:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 655BA3CE5BF
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 07:33:51 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 14C782005EB
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 07:33:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kq83jyv7oCenY5nPY8TB2xPtrVTIYfT51EassDCxvVsYIkElMkfbX8Ev9rrmROb7frHMDWG5uplNBhZcFwUAd1t78cWd92xZ+vNzGyN57bAmp198YAtvY3bRFYnZvBaaRj7x+XoiHPsjJF7PSokUT0OC7ahbrhFcX++UcX0nr2elabGmhZy6xgRVi8+IT6iVfYCDfxc7m5BpbdgiHKwXQ+Gjrbl9MGImd4QcF+mTV2sA8UlT4/2HpQO1Yg9Q/hJX0lRavfrGdBOp0/nEklwDjMkjBkqm+11o3jnmjAIldnWXgyD/d0/ZnU9cxVg6p4cFullD3dqhe4R5hbVzrWmyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOtEBsx8NLssEX/ZFuSLRFHm1HDP/hNxSZNicbbEqlM=;
 b=hCvGUqZb4lH7ap+rDkwd9uR1AePR3lFGOpFEobM55yu5RsmEHBXgRTYDwN/6aTBmhyaSscqiPmLLWDdPIqWlUtNX5g1Ab2mMXt6/eWmOo52qxu+W5C6cMUYArMEWxR0GOcI0vzlfnzRU8Nbz1hufCq95kDl8b3jPQ602AmPJvMN5vmFgkTTR1P0hWaApFMHhRkhk70S6khw8C8AqidUp8MZZJUl/PuOBmoXRIYBqh32h8kY+0dUqmyrWyq20mradOiNNrTkeA0420H+bcdjVLA/WE5Rz+wCsOUOwDADVNpb/qCvcRz4s8SEkH4AgqFnjiOnS9nKYo3yHufyLY6wSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOtEBsx8NLssEX/ZFuSLRFHm1HDP/hNxSZNicbbEqlM=;
 b=YuEHx04vwcNIPKA+w+pW80wOFP8ShMV9MMA4pt+9uuYxpfkNp7+Pn7/S3y+FJpbAI7xGPaO9gOaHjTIt/qnm+FNPt4B6oEuHpukJdZOiIIyrD0L4xosBz2qXQivbtsgV0vWKLZ/8CxgPBu+U5Q/TTCEpZvP9WpAcecpuMKbVSAeXfls0R0iBsxGY3eb+9zKVWORlyghOZ5wU8PLZeZVZDZ/H55+BP/nWiXFeJdsW/hN0+9YI1St4J+LGPeIliQcU9KOqvRyt2KUvmHanMYVH/Gq76oR+qrUlCf+BSu97gm4QfpKqcNMLtmZcoT72azBOkaaDJPCyh4Ps/HmMEk5H5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 06:33:49 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 06:33:49 +0000
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 01:33:11 -0500
Message-Id: <20231214063311.2325-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231214063311.2325-1-wegao@suse.com>
References: <20231210094339.26971-1-wegao@suse.com>
 <20231214063311.2325-1-wegao@suse.com>
X-ClientProxiedBy: TY2PR0101CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::14) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DB9PR04MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0c9fc1-514c-4241-2567-08dbfc6ea1f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/wmdKY1sZEB4GEzgGZ0fJ6q2nbkXGDrseEkHdHTceLGpv6S13ztP8/W/0kytiscpe57eiBWLZcCuNLyP2nEqJyMQIQHkKOYE4yzsNkFg6afuwNSe0bi6gsNuALlpepShLddagu0AFuF4JDeMx7Ff3JnibMsi4VfL6GJulAL+LSAvbx7L0IZ0fc3fnsSEpCZZkaPPvxjWhE6n1QDWUO04eyow4p55q752mkEjni7sYA5ffjRYltY9nvhlSO4Zur3XaKg8o358LpZbTlDIaNT99Q+wqMe4mIueh8+MeZXudyEndQvnwWPJPNk2d1/AAR0+d90d8Nmp8U0oOdGGWGAIGYDmed/MgtHlwRvQUETybVhkvzD73w20HZDsfv3Q7pTw8B5SJARiRAqKwfQ5tJhfpal3QTKvp1xFnIKl5VEZsyFSrdxXk7z5Nx4ctGEczeY/blbhl8S18XF2TkYYpD5ljayzl/QcJHTT8V56sirAlR8ggsZW1R/i77EF62xQqMwJbYO2Xwkyg2ZbT5UfppzkRG0Psj3Re69Tz9Jn8HKGComHZbQ1wfRnz0C8rLg8OPv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(4326008)(8936002)(2906002)(5660300002)(6486002)(6506007)(478600001)(6512007)(6666004)(66476007)(66946007)(66556008)(316002)(6916009)(41300700001)(38100700002)(86362001)(36756003)(83380400001)(2616005)(1076003)(26005)(107886003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6FJ1I1d9z0+ynrwUcnbNBpsr0zvNJ3PPEAj1QYBSiIZiL9ZUe7uZ+zsg3mT1?=
 =?us-ascii?Q?CHbUly/IrxH1B7SA9GC5AOFYIj86/1m7KCzp5/Egsd+k+Dd7ue6TAqEI8cIW?=
 =?us-ascii?Q?ZX2iknPaWejbEHKNA/SGq8m/U3FO+DYUMfIB/ETV3o4rFMNSdidmQ1+pm8wj?=
 =?us-ascii?Q?LzJ+RnS/bEWwyim1TQtiNP00b7AXCHmHw0NE77OAGKzmdimwGxsc16SfObKl?=
 =?us-ascii?Q?3Qj+S9gPaYiYmgavqhzNw9mqzv4hknnAxv/a/L9h5NwqHoopql0u/4zxbrrE?=
 =?us-ascii?Q?+P3evRFrwwC4zBBWyuax0gUQi/HvrPRUbDDlPrrxUcU1qOliJFpmVXsDPOql?=
 =?us-ascii?Q?UAeYUDHP3Q++sn2LRYafBx9yRGaeoqey3zFIBDFGbFGiDkwMDDRu24T3Ap0d?=
 =?us-ascii?Q?hCo+XdO3joaSlmMeDBE9xvRExLyYB33bza3jc9pEQW0MD+wkGr1MlHMUnpIN?=
 =?us-ascii?Q?kp68Pnh9V5Br+8suyn0Bnm6pB2YsrDb+3SBRyfwS0UDiwbPFB6Z6KSrNLBI4?=
 =?us-ascii?Q?cU+ByfSnIEruA7jP3RlL0W2tNLstTLrZqA0C7tsWJ4kMV81Or7OkUwU15CY0?=
 =?us-ascii?Q?Za72Tlasd9VrGyzI4nuBWZOsnKXfiu6hYiBeCcQwQTlF9PpkSEpUzgboOmEf?=
 =?us-ascii?Q?Os/E+/ukbTXDRYM2tvomHL5dN9CzgfCDGzY1kcM3/W07ZpKALS7xP1nmO3JG?=
 =?us-ascii?Q?i77TO+srrJf3UvRAWGe62NRKwQ9qzj6cbM8LlwJ/mDbvYAr2VO4L6cKyS+RG?=
 =?us-ascii?Q?9Kvhzd+jG+L3RA+SBsNEP3MdwVm+lYovF57FZHYqnu+hyn6H8qRBMrqhc/98?=
 =?us-ascii?Q?VOt6/vQ784LZ83kxsT6CyFJavmPX5t+k8pX6hdzGFaoKRO2mK6vPDlx8Ysm3?=
 =?us-ascii?Q?NKVlnIfMMUVWAB6uRCLY1rXlV2bNI38dOC7DjmDVgoDt6yMpFgiABZPajqYe?=
 =?us-ascii?Q?pNq9stlqcjbeO2+I6ZLZEnT969cYTT5R/yxYOy5HSFbBVtdz8N/fUxQ8Kt8m?=
 =?us-ascii?Q?npY7kH6FNvJmpvPa8A4EqQ/uvxldjDHX/5Eh1MZCzV54RbaY9v2kfHM3Uvru?=
 =?us-ascii?Q?bC7sGsNGRZ7kKBXlU+l9i6KzNESZ8zEWYQfj7cPNL/xySnSdZEt7XUuEkMMS?=
 =?us-ascii?Q?0X5b8o7RzLw2qfXJOWDDOx/+GvnTkhcqYIdpdiQuo9gyBxHy4phDrLw0UBNS?=
 =?us-ascii?Q?1jq1jABcjnqqoZexc06+UIY7V+P3yH0Zmgz90r3+WCoH8TioCabQaQQO/avz?=
 =?us-ascii?Q?tNt7AVbrstNBfzxpCIFscehxF2XnzDEhaNET9B93zcsDlrQs5xFuH5OJGfmk?=
 =?us-ascii?Q?BuvSS6FSGCBRUkKYoFY0pinYudnKlRV1IgcmyUf9DpaHE/6OjJA7Aw6Klpdq?=
 =?us-ascii?Q?RonXjHvVprV7dFtAWObXQclMGMR1TMbfIzRgkq8Q4oBxPdnKyLzXLKTX/r2a?=
 =?us-ascii?Q?Di0nGOg6qdl4ibPyaZeYVg/aPoSlArrRPWtMev7pkI05fM4+vJxytd/Kfhqe?=
 =?us-ascii?Q?pxyCa0mQ9wzavO1wVJFPUNamkR+DR6nqFBJMi3uQReUhsOO6TdcO4EFq+EZK?=
 =?us-ascii?Q?XhGhE9voeptJOIhN2Yw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0c9fc1-514c-4241-2567-08dbfc6ea1f9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 06:33:49.7849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tm1RiyNsToNWhGvEa+MPscpqT/6LFh7ZimZ1kcvmkMZV0FUzqALB3y+SeAZo0hRN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8461
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] swapping01.c: Reporting /proc/meminfo during
 test
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

Get clear overview memory status during test is good for debug, such as
get report before the test and also at the moment of the failure.

Also i move init_meminfo() into do_alloc function since do_alloc will be
called twice during test and we need fresh data. This will be a small
improvement for 1b53999.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index fc225e4a6..114456a19 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -79,11 +79,10 @@ static void test_swapping(void)
 	}
 	SAFE_FCLOSE(file);
 
-	init_meminfo();
-
 	switch (pid = SAFE_FORK()) {
 	case 0:
 		do_alloc(0);
+		tst_print_meminfo();
 		do_alloc(1);
 		exit(0);
 	default:
@@ -108,6 +107,8 @@ static void do_alloc(int allow_raise)
 	long mem_count;
 	void *s;
 
+	init_meminfo();
+
 	if (allow_raise == 1)
 		tst_res(TINFO, "available physical memory: %ld MB",
 				mem_available_init / 1024);
@@ -146,6 +147,7 @@ static void check_swapping(void)
 
 	swapped = SAFE_READ_PROC_STATUS(pid, "VmSwap:");
 	if (swapped > mem_over_max) {
+		tst_print_meminfo();
 		kill(pid, SIGCONT);
 		tst_brk(TFAIL, "heavy swapping detected: "
 				"%ld MB swapped.", swapped / 1024);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
