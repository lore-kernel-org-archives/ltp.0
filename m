Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A807BCD98E6
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 02:54:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC5CA3CD80D
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 04:54:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 951613C88F6
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 04:54:18 +0200 (CEST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E2F801000488
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 04:54:15 +0200 (CEST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39B2aTVu031151
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 19:54:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=PPS06212021; bh=X9ezZMAsD7Kq/n/ymx
 VXyrTZqhrzMYjzS/OFI89LC8o=; b=RrT5SXyc439uiZjLFs/dzfBipTaS2msvT8
 +BGTYwj7TeK9BzClkH3C/oX1KlH1G7JXLww9Kic9cQsWS1p2pKF4Jtm/tZNYTQ0k
 846t70nEK2FF6KCh9b3ofFcHbkvuu05vP8vOHVw9JNNvaJ/zzMbpepUJJbVtjwBt
 ned6LXOdh9Y37zaXpC8ds0pR+sK/DMF48cAHB19331yojlo2D2HL+5v0f05nb86t
 bTfhad87zsuX3nfLawFe1EXLaxF2GkZJhZtwD7/TNgNXW8EI+L93dRbvQMdidpGD
 5+ShASTadkJDvY9HEVb8K/ZTOB6iI1pP1J6Xv31RWq8DAIScRn8w==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tnhq4r22w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 19:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHxYwnRkoO9aCFbS2TonCLUUv/p/cwYEJ3nc5dSvz7gMWViEktkHVAUAOXFWmZfD7hKQVRBxD5Emk+QS0uEZikvXNmqnumTdHjjU1ALdosyCJtHgxM4Wn62xIiiBd6kdHkXxt1oyGkUEITpgKLUkgQijsM78PzE0goVeteCqEMCsmju2vGLOcvFeac/U1eJdOunGftMovar8dU9sy+dthvJOwI14Rrmnok9Jh6j3f88wNqZjVDfhJk++R31r+Uzjh+1Y6NcKDol/GdpFuWjoRPklSaMbyHKr9uTCQMXeENVaWO+d8D6NrLlgz8Sm2wAMCvfl6MLQXahLhGzUtxcWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9ezZMAsD7Kq/n/ymxVXyrTZqhrzMYjzS/OFI89LC8o=;
 b=BcR4HLaSQV2h8YsP7VOSC7OEB4vl8VXtCs7RPBICVZz7ZZY2PQr8qYzJP2qda9YZWnc2CdosJfb1qLmS6RiRyvVkwK4v86orM9xeVM370AIQa2Gtbbj9T+y3oXyGsyJkAw7QaLVA5/8OVYIC4Ou0976FgddLZLwAdXUNAyqvLX2sW6kWA4oYQOkfugzrLI0fLti5HIiM8Z/RJjv6r5f6DwJRDMdXJpK8s8jvJs4PfJOM28B9wHNFqY5DG1tjJJS3xJYQ4eOjEjLF/Z08PeZ+VulQPL3QspXKTlB87lgqfywhKB7OrN4MjNQ4cwzx5AqZWl+bCV0ANkRejwWB0CW0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by CO1PR11MB4962.namprd11.prod.outlook.com (2603:10b6:303:99::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 11 Oct
 2023 02:54:11 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9001:a90f:6809:6bf8]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9001:a90f:6809:6bf8%6]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 02:54:11 +0000
To: ltp@lists.linux.it
Date: Wed, 11 Oct 2023 10:53:23 +0800
Message-Id: <20231011025323.1558560-1-Xin.Wang@windriver.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To CO1PR11MB4979.namprd11.prod.outlook.com
 (2603:10b6:303:99::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4979:EE_|CO1PR11MB4962:EE_
X-MS-Office365-Filtering-Correlation-Id: 949405f5-24a2-40c7-92ce-08dbca055850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpIc2tBH54qQf3PXbetGhqflWgtdQQ/qpAhVE0Z+SaPZIHoEJcze9XaDu0GhLWm9/ySLAG13dOhYBcEzjL2KjXWmvWLbqZWoBU398FbvzzujgEAURkcyEbQ1brlMVW3RKlzWA0fzdMyJ32dX+4jGz996blugZ4+LWO1lQZZk0tSgk9jL+POcdtZxS4WX0Yjb02CdaMEtew9xfm6uB13tX5vMlItfejDc4wi3pAnmskVXQ83mFThfmDpD8ldeCehK2I0JysObTuNLB0OfWplJHn56NFzk5aw2lexNOJPeQnSVekkaCoWbsxNfIsYog7i//w7CISJLsZ13v5JqLDMSgr3m8wjuIFChOJoUl2UhKTIr1HpSP8GBugswIRqd1OuQq2i/Tc8xDFGGHslnXF7Bj11M6pqBITq3u2kYAynm/q+RpANzABRjYEt/lagY8aeLLwcVvoF4T1Ujl3+Ar8v4NFnO8sjs+XJeRn22Rkha5HgVYlxPgPiS+1gf7M3UyciR9MMsR+FcN0dE/1wN4JzZZAQTqzFgYPRHOPV8l8uP26K8g0yjX8MYeY57rqB/itj2Phg5cuVTBCXjTGRr5j5sELwGiV9mPgtohOROceSQyhMZ+hG15mm9HizLWsVqD+Hq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(136003)(396003)(346002)(376002)(39850400004)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(26005)(107886003)(1076003)(6916009)(66476007)(66556008)(66946007)(6486002)(86362001)(36756003)(83380400001)(478600001)(6512007)(6506007)(2616005)(6666004)(52116002)(38100700002)(5660300002)(38350700002)(2906002)(41300700001)(8676002)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3oOXzDr1N0kb0ccooMEMJj9zsxxsGqxJ4Wqn63EupF0srsFeRiD7jAwSmYMO?=
 =?us-ascii?Q?TM+jezBZkk1t/Q8zhr9kZaJYSwcaH3WLNCn2byCtBUzaXkQg5rty4oobUe3e?=
 =?us-ascii?Q?vfXbKjpQ0ezU2Vy1pIP58clHZf/1UnPbMKV/+lSb5DQK1DHZN+z50GckD+mY?=
 =?us-ascii?Q?ODx00HY0sGnrFCBdin5IETlWyaXBRXXfKsZLK+Qi4YWMVCvgzqAzuUTfTNKH?=
 =?us-ascii?Q?BCuwhoKJ8xtIfst5wdS++cgMpDMGlQSG0YF2aIN0MsRFtSwa1j7wfWzOpoCk?=
 =?us-ascii?Q?8ao0Wzi8zE6ncXdc3FcOhtqYyitJe4gvD6cXj/duXJ6amvbgr6cJXWIO2nKA?=
 =?us-ascii?Q?xmwNKbgvV0n/wpLYu1Z1dwjhxl6WQd2dVuf3cYkvHCs1liqXeF5uJmFC3M/U?=
 =?us-ascii?Q?0Q8wO0PgFOtCLTOYvPxBv9Ct6Wj8XeIRAQnwD/fYftYaIuC3l8Bk0MppImxa?=
 =?us-ascii?Q?3SZnWLAtsop2AEQiKwGVMMAZcUqHpHQYfEFWMNoB6QwdYcIVF/VIARravya/?=
 =?us-ascii?Q?Gl/cU3rjdpB9zxJJkh9qwm+N4m+vVn5KuYX8A1Y02/HQCM810tneK1VrzOSj?=
 =?us-ascii?Q?jxWJ+2lAgayLWGL2/foAD77waKmfiage4is1fBAJGIOTv3IdEGZ/GZks/uaV?=
 =?us-ascii?Q?Nw/LjNVEGj2mOgtO2Yc6GWSUCz231/VQNBvzhwe52stpSpK3ojwRQRPEQQad?=
 =?us-ascii?Q?GnfQIep9+7UdYF6tGO7oQT7x28dc6uSzVf36V/VZ6ty3zbJVNwr2l7YuzZoA?=
 =?us-ascii?Q?rSahSTMG3/Mw4f/9+y2CzqFN+F7xHKnrETm1nwx2Mo447NFDwXS/ltMbsMw9?=
 =?us-ascii?Q?JoxRl6yoYtb9vfGLKUkM+vWLSDccPEpinyOEsTA38sPP5eW8MXNwgaAxNShL?=
 =?us-ascii?Q?ilxfrlK6vZfDLzG6R4dHWHzqRPINPSMdYxh439iWqBxDQb8m8JJaG290nlqD?=
 =?us-ascii?Q?4o4J5wMpqGTR3r6IBlrwTN7oaNHJ0e08qAe8/njCXeXSbb3zmtqYCznkLdq2?=
 =?us-ascii?Q?lV7m4yaHgI4xlP6FyQuPs9jqI2+VXR/Bcr32f5K8GeHCPWbWavQ5S1M/YVLO?=
 =?us-ascii?Q?7Sit7lxRNBgoobMkUJAI5t+dKl+Y18YSmnvWiR88Hq6Gg/FzAf76WQhj4qt7?=
 =?us-ascii?Q?8jWRojfB5Nz3n5JC7FNLnG1KlBntalqzbZCWQxfYHshmz4SJaDnXdAe5jjF1?=
 =?us-ascii?Q?HKBfOMWj6aO2cDjZRbpIZCU8ohd/S7R6P8XS1aQxQ9PextR0RcH3mImLuwHp?=
 =?us-ascii?Q?0Cddk3pDAPwKnyj3eh8WXttUGgrMIM6aZ25G0Iuup/hjEuntRW+cxbzdq2Y5?=
 =?us-ascii?Q?iO2yh8DQUAgzScJ8ESgXldkgJ9fHQ+llVxhyR2DhMwjB1OyiNzyF61NfUeSn?=
 =?us-ascii?Q?M8rerawy2b99Mcpk3pTYkjsDU/CjF53ixdU9aoNRgUmJi3SmXLoIghjMmLgx?=
 =?us-ascii?Q?PCIYdOrQnxdhf7Eo0eA8HJYhCrYKd+7dMCgU0WRqqmPkXxFzyNydG46PT/A0?=
 =?us-ascii?Q?WrhVhW7HaVdQNu3fzb4nrScLyHG1Ni+9YkuelHt3yzHADyLHq+KbPJRKPHiu?=
 =?us-ascii?Q?QY3CxXFcZbKmR/kutB1RsoKd7vt1gi3L8WNXClHk?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949405f5-24a2-40c7-92ce-08dbca055850
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 02:54:11.1933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zz8SFqtYAdnSHJnN6xOji/OEer371r+dHjzmuiWfLvXm8g+M4KrK3zIx4QtX33JLEGDT6SwBpHo6v+phetKJGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4962
X-Proofpoint-GUID: PQShEQ_biA58cQAZqMtqOKS1sW4inCRP
X-Proofpoint-ORIG-GUID: PQShEQ_biA58cQAZqMtqOKS1sW4inCRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_19,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=950 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310110024
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] enable fsx-linux.c running on VxWorks user space and
 add measurement of execution time
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
From: Xin Wang via ltp <ltp@lists.linux.it>
Reply-To: Xin Wang <Xin.Wang@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,
I come from Wind River. We and our customers used fsx-linux for file system testing on VxWorks user space and total execution time also received more attention in the testing.
So I upstream the change of VxWorks compatibility parts on this patch, wish to enlarge the test support of fsx-linux.
There is a point need to explain, because current VxWorks doesn't support CLOCK_MONOTONIC_RAW , CLOCK_MONOTONIC is still used by VxWorks when calling clock_gettime. 
When CLOCK_MONOTONIC_RAW is support by VxWorks in the future, this part will be removed.

Test log:
[fsx-linux]$ PATH=$PATH:$PWD ./fsx-linux -N 20000 /tmp/test/test.ini

truncating to largest ever: 0x13e76

truncating to largest ever: 0x2e52c

truncating to largest ever: 0x3c2c2

truncating to largest ever: 0x3f15f

truncating to largest ever: 0x3fcb9

truncating to largest ever: 0x3fe96

truncating to largest ever: 0x3ff9d

All operations completed A-OK!

Elapsed Test Time 1.366451681

Signed-off-by: Xin.Wang@windriver.com
---
 testcases/kernel/fs/fsx-linux/fsx-linux.c | 44 ++++++++++++++++++++---
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index 64c27a0f5..2064fac16 100644
--- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
+++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
@@ -39,8 +39,10 @@
 
 #include <sys/types.h>
 #include <sys/stat.h>
-#if defined(_UWIN) || defined(__linux__)
+#if defined(_UWIN) || defined(__linux__) || defined(__VXWORKS__)
+#if !defined(__VXWORKS__)
 #include <sys/param.h>
+#endif
 #include <limits.h>
 #include <time.h>
 #include <string.h>
@@ -849,7 +851,12 @@ void domapwrite(unsigned offset, unsigned size)
 		gettimeofday(&t, NULL);
 		prt("       %lu.%06lu memcpy done\n", t.tv_sec, t.tv_usec);
 	}
-	if (msync(p, map_size, 0) != 0) {
+#ifdef MS_SYNC
+	if (msync(p, map_size, MS_SYNC) != 0)
+#else
+	if (msync(p, map_size, 0) != 0) 
+#endif
+	{
 		prterr("domapwrite: msync");
 		report_failure(203);
 	}
@@ -1115,11 +1122,16 @@ int main(int argc, char **argv)
 	int i, style, ch;
 	char *endp;
 	int dirpath = 0;
-
+	struct timespec time_start, time_end, time_diff;
+	
 	goodfile[0] = 0;
 	logfile[0] = 0;
 
+#if defined(__VXWORKS__)
+	page_size = (int)sysconf(_SC_PAGESIZE);
+#else
 	page_size = getpagesize();
+#endif
 	page_mask = page_size - 1;
 
 	setvbuf(stdout, NULL, _IOLBF, 0);	/* line buffered stdout */
@@ -1267,9 +1279,12 @@ int main(int argc, char **argv)
 	signal(SIGUSR1, cleanup);
 	signal(SIGUSR2, cleanup);
 
+#if defined(__VXWORKS__)
+	srand(seed);
+#else
 	initstate(seed, state, 256);
 	setstate(state);
-
+#endif
 	open_test_files(argv, argc);
 
 	strncat(goodfile, dirpath ? basename(fname) : fname, 256);
@@ -1336,12 +1351,33 @@ int main(int argc, char **argv)
 	} else
 		check_trunc_hack();
 
+#if defined(__VXWORKS__)
+	clock_gettime(CLOCK_MONOTONIC, &time_start);
+#else
+	clock_gettime(CLOCK_MONOTONIC_RAW, &time_start);
+#endif
+
 	while (numops == -1 || numops--)
 		test();
 
 	close_test_files();
+#if defined(__VXWORKS__)
+	clock_gettime(CLOCK_MONOTONIC, &time_end);
+#else
+	clock_gettime(CLOCK_MONOTONIC_RAW, &time_end);
+#endif
+
 	prt("All operations completed A-OK!\n");
 
+	if (time_end.tv_nsec < time_start.tv_nsec) {
+		time_end.tv_nsec += 1000000000;
+		time_end.tv_sec -= 1; 
+	}
+	time_diff.tv_sec = time_end.tv_sec - time_start.tv_sec;
+	time_diff.tv_nsec = time_end.tv_nsec - time_start.tv_nsec;
+	prt("Elapsed Test Time %lu.%09lu\n",
+        (unsigned long)time_diff.tv_sec, time_diff.tv_nsec);
+	
 	if (tf_buf)
 		free(tf_buf);
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
