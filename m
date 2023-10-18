Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E29CDB474
	for <ltp@archiver.kernel.org>; Wed, 18 Oct 2023 01:49:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A8643CEF6E
	for <ltp@archiver.kernel.org>; Wed, 18 Oct 2023 03:49:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B80E13C8885
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 03:49:38 +0200 (CEST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D9B40600C60
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 03:49:37 +0200 (CEST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39I1QgZe002588
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 18:49:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=PPS06212021; bh=PaVTqmsuQ3RNSOj1bZ
 j5TVXvs7+9Qw/0nSe2bGl2uj8=; b=i4qxCe66XA4NAFO0rLA8AHwQAKiEt72tH6
 P3p+4GQpJpaCwnzBl4zpqzNRHp8KfFTkEyAF1ZC4aMY26lmfLPyCU5EB6kICO6+C
 8T0bRNSeqApccrHafXy55KJqY/Wf4dEO1q9JbfK5OtmVJ0t3jqz1pzgHssgJJ8T2
 wzjltHN1qF+iYSI/av/BlykN7cKJcn8nIotCqIMbcRnN4n3teB21XkcrfO/knmvd
 DY504nx+HbXPpGnEwtLm1ueRVPYoRkyFrSRKK2ymF1OChfhc1DO74jqdNMBDHbbN
 hC0dYqqIQYwCgywiEWrvuv97ExRhq+VM86VhkuC2F69R0V5aMBXg==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tqtgfkfrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 18:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm9gpM4DrqofjSEdKKFREiSVTw01Eqhk4xWG5J0DlwJmasQ3gLVubBgNGki3pUIWrXNl79b8Gb1+M/Cq2VS3AMtDl0Rl0KotFNawAFWnP82N5hQHVnrlUaK+SCmFAPyCp7Go5PYqAwXP3HiDRqYp1kWXuusk+NslH9PP0VCD2hn2zB0iP+wVgNknWdPfZLF9M6mg5scUq0Ncyu8VXe4vmFHUQGffVb6d6SM3feBBYjYusaOtHQfjJz+aa+c3jYsgbhHBwrvuPoP5mDRxs0500xMhsohInQ7S70Gj6WlytiPUhhCNA7rNIkehE0ANhY27up6HnH4HJVbjoDI2EyFVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaVTqmsuQ3RNSOj1bZj5TVXvs7+9Qw/0nSe2bGl2uj8=;
 b=XAhn8g03WvQgb6+mwukD7KDxhwABcx0w6mm4BmDi8dNAO8VP2aENpeClZauKHMYNF5RHIaC+xwYAHpEWd7pfw+BbaqQh4eqhqW5dG8mt8DDkVDMGdx4WL3pUH/fqxtIZHOwq+8d/RV4VD8ubX6cOPNBEfissnU8QcK6PLlQ5cMfU9n239mwF7DLm0Oqn/j7PJhYNsxztHi7mu9K4ZaifjNPXCTdOaVBi6J6IPNur3X0pH6mUzg7nQrvWaWS3/w2kjHB2ItwKqlEUdJfrgBXuAijoP0/a8ZWSGO+hFpBTXF5P1vf4+IiK92WnBziAuVPOm5AU2GOdxzg9IVOFRLexTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by DM4PR11MB6165.namprd11.prod.outlook.com (2603:10b6:8:ae::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Wed, 18 Oct 2023 01:49:32 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9001:a90f:6809:6bf8]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9001:a90f:6809:6bf8%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 01:49:32 +0000
To: ltp@lists.linux.it
Date: Wed, 18 Oct 2023 09:49:15 +0800
Message-Id: <20231018014915.1632280-1-Xin.Wang@windriver.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: TYCP301CA0065.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::10) To CO1PR11MB4979.namprd11.prod.outlook.com
 (2603:10b6:303:99::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4979:EE_|DM4PR11MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 088e6c92-a9c6-4e5c-cc80-08dbcf7c7927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVehIi6CYNzjw+67vPztG5z0a+gbkPlNUwGj0udJXcyR1eB8q75vDg3oJlP8tZdDNIY3Po3UusjQpdnylHILFj3mU8NE1+jbV3KzlbmmtGV/JKeNO+PmwQvidgQGW0rC7hFKFznYdz2YH3bPT/LHnvC1C2Tlanh8EGWrh94KbDZPVLIcJDbTk2OEv1snGVRWjvt+m1BbjXzrQUFyD/lfC2n4z5JI5yszf8AYmXRzws3mmFb+ztHVbQsBYrztgigqSJrjQIIWXDOmgKGRRnMMdKcpqVX1vBqkBQQLQEz55PVw6UPvOAfKkcNxrSxs5nWErfR8IU1FEzb2GVi3ZStJ4OoYEGshqNlTyeTqqX6n0/dPl6JLfSAZoUzRSub2JRTrnakCHdv5QPsHb2Jw/88aUmgAihmZg/EHM5YMIV71UvfohSpyFn98YWhuRPEof+SPlA9DJEqekTZEf2LQexifFFSMPvC+Ifa9aD0o3aU7wNGPvzviWmrMV6URegytvAs7l8Gfa+qo3lPNOqQLtBHjFF/MI5UDtWo3C9zwMMC26Dbhkw/5+6p2YG5Fxz98/N1PkGA0eplhbKyEGsk1Z0vxE5/x+Zyx8pia74Xj0v7ZVtIMHgz8zkItI1vOBXvpKTHF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(396003)(136003)(366004)(39850400004)(376002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(36756003)(5660300002)(8936002)(2906002)(41300700001)(38350700005)(508600001)(66556008)(6666004)(6486002)(4326008)(86362001)(83380400001)(316002)(8676002)(66946007)(2616005)(6506007)(1076003)(6512007)(6916009)(52116002)(107886003)(26005)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c1l+G6uGj9hLokcn5LkM4Bl+GLkW6bA16qCEbc0cixwRnYdwYo9HTonFN8gb?=
 =?us-ascii?Q?OQJFGDHzonbIBnirVrr/VTUHUtO8pZZmwCLeQEvickNTc7xoWunx9l22MEXL?=
 =?us-ascii?Q?ofKM/B1NcZoPFRwDbMqDjYrPjHgPk5IxAWbWpuB/NHm+Pxqjw6Qh4oqMuEso?=
 =?us-ascii?Q?qwHhkMSluQy23OOWVl0IAfnKJUr8AlmwLaevP71tOdKZgNNzjgL+gVBjzo5M?=
 =?us-ascii?Q?0vUeNnEMSyOgaA4my+WSdzn78+RqwFBOt8iTk9h7QegLfrAKP4bi7eZZ25Pw?=
 =?us-ascii?Q?q2WH6dTWU7oXcOzjN3T6oaNZqAKJeFoIWYBHXTCj4uPku+Na/XdYV1L6sKvN?=
 =?us-ascii?Q?zc3H1efpYgKDod/DUUyTr+CZW9cMss0avkA2AJo/u1upd/2/Mcf0uzbOJXhO?=
 =?us-ascii?Q?+8R1a4uw3oPO8a5ZI2kOxEM0ayoIQmkggW2p15xgrG8LNtbG1GJK8LXHYefC?=
 =?us-ascii?Q?Bc5qQgdhL2+aYKbmuWZskIDxJlHjcn/tK89q+BIbC40UYfUqKdM4R92fcBes?=
 =?us-ascii?Q?3a9QJCJhl+2R4xeRo3N8uVhXNa95u/mvvxO2XOyea8jQBO3GpOV00B6fghwH?=
 =?us-ascii?Q?Kf1wzACkqrDrNdbEmfg/h+3qhk3A+Zi8BVRRi3COGgLBxYVkFFx0ch7WlQK4?=
 =?us-ascii?Q?PlI/9FHVO3qHsq4mGvQoHy26ioy9M7JwoqXPTo8M6xP61Ds118FmBxR97A4R?=
 =?us-ascii?Q?ItNfxrsbqxrR/yuHL9LwMby6l7K8I4vRWqn8PiyK0bjITwtmH9zBRK6Ao8eT?=
 =?us-ascii?Q?+7Wkro6NFL4ho8JrjoWIbImkvJ8/oyvorLB7YiMNQiXvkN6X2f77Nl47NIz/?=
 =?us-ascii?Q?h/ABYzCU3YQDTSxF7L8OMKR++ifYA5KBW2rRx+/0o7X8wqLiOaiGtUIGhbUC?=
 =?us-ascii?Q?yhYTJuvVP2IiCkeRchgOIuPz5dkPzb2CtE/qHXunSI1fNK3XWHOeCaDCBREh?=
 =?us-ascii?Q?YDPwGi/hGCNTutVzE/rM9BsFElxhEDQt9D2c8zOqyX/K1eLlkdgw3uqUmmT6?=
 =?us-ascii?Q?j1pgsas0V/ywZ2VPGwu9Sl1I9lqv9gP6SnAUEXpD8LVFOII4fFvn3jkSnFQe?=
 =?us-ascii?Q?AScV+RUkw5OzmVV3vmsHfrjgngF7PrlCWlq5b8Od0GabhHNy2xG/5frpOTMp?=
 =?us-ascii?Q?Iy9hbAQ6aU+Loc60l5uoiiRoxifqV2bWai7ZS9LlIdPLfHN8hAI5hBaGrrvx?=
 =?us-ascii?Q?xyQFUNrNQ1KlJrrLgM+SPf0ztXOP9s3Wg/PeQFBF4ET3rBdBI4Bj8lSKeeqC?=
 =?us-ascii?Q?lOSbVFlLli2ndP+9mMs86llOouI7/HsIb65IPh5118RylDcAoDVQoCz+SrDu?=
 =?us-ascii?Q?0DxDE+4HQ7tK1pH7u9nF1Qc1aMJzM8Jx+3rtSQcscC01jRw4JiDqXfDe24VO?=
 =?us-ascii?Q?RhLYK2XdujvohbOvuCC0s/Nw21gpXNX7m5jhEEtW1Z+ilm5kPYi4WmC+gFZp?=
 =?us-ascii?Q?FMxPl1sT0EKJn0GJp5WYLJ1l9gMLZWCW8u99TtX3KYz5mUS9lznp9epEI6zr?=
 =?us-ascii?Q?2GN18msXlSG/yANFhQPDAZh9J6StbO7dkqYhvfdyf43/MXMzHxoHqGNtTpKG?=
 =?us-ascii?Q?Ln2TZiZAQdpzLdIKGZ9+WM0s6H5ypWog/Pkwj1xj?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088e6c92-a9c6-4e5c-cc80-08dbcf7c7927
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 01:49:32.0741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7N2W4llvcQqNKYNP3I8ttCaccw2hgSfm2bCxg7L6IKWSr9TqJELWxk/95FGOurQ9D3biK6VPgBPtAj1DU1nouA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6165
X-Proofpoint-GUID: CKgeeixEtoREoKjlZOu2CHWFPL2__XEQ
X-Proofpoint-ORIG-GUID: CKgeeixEtoREoKjlZOu2CHWFPL2__XEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_08,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2309180000 definitions=main-2310180014
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] enable fsx-linux.c running on VxWorks user
 space and add measurement of execution time
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

Signed-off-by: Xin Wang <Xin.Wang@windriver.com>
---
 testcases/kernel/fs/fsx-linux/Makefile    |  3 +-
 testcases/kernel/fs/fsx-linux/fsx-linux.c | 53 ++++++++++++++++++++---
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/fs/fsx-linux/Makefile b/testcases/kernel/fs/fsx-linux/Makefile
index 956486b8a..8162da3f9 100644
--- a/testcases/kernel/fs/fsx-linux/Makefile
+++ b/testcases/kernel/fs/fsx-linux/Makefile
@@ -31,4 +31,5 @@ WCFLAGS				+= -w
 
 INSTALL_TARGETS			:= fsxtest*
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index 64c27a0f5..c1b0964f1 100644
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
@@ -59,6 +61,10 @@
 #include <unistd.h>
 #include <stdarg.h>
 #include <errno.h>
+#if !defined(__VXWORKS__)
+#define TST_NO_DEFAULT_MAIN
+#include "tst_timer.h"
+#endif
 
 /*
  *	A log entry is an operation and a bunch of arguments.
@@ -87,6 +93,11 @@ int logcount = 0;		/* total ops */
 #define OP_MAPREAD	5
 #define OP_MAPWRITE	6
 #define OP_SKIPPED	7
+#if defined(__VXWORKS__)
+#define CLOCK_ID CLOCK_MONOTONIC
+#else
+#define CLOCK_ID CLOCK_MONOTONIC_RAW
+#endif
 
 int page_size;
 int page_mask;
@@ -128,6 +139,23 @@ int fsxgoodfd = 0;
 FILE *fsxlogf = NULL;
 int badoff = -1;
 
+#if defined(__VXWORKS__)
+static inline struct timespec
+tst_timespec_diff(struct timespec ts1, struct timespec ts2)
+{
+	struct timespec res;
+
+	if (ts1.tv_nsec < ts2.tv_nsec) {
+		ts1.tv_nsec += 1000000000;
+		ts1.tv_sec -= 1; 
+	}
+	res.tv_sec = ts1.tv_sec - ts2.tv_sec;
+	res.tv_nsec = ts1.tv_nsec - ts2.tv_nsec;
+
+	return res;
+}
+#endif
+
 void vwarnc(int code,const char *fmt, va_list ap)
 {
 	fprintf(stderr, "fsx: ");
@@ -849,7 +877,12 @@ void domapwrite(unsigned offset, unsigned size)
 		gettimeofday(&t, NULL);
 		prt("       %lu.%06lu memcpy done\n", t.tv_sec, t.tv_usec);
 	}
-	if (msync(p, map_size, 0) != 0) {
+#if defined(__VXWORKS__)
+	if (msync(p, map_size, MS_SYNC) != 0)
+#else
+	if (msync(p, map_size, 0) != 0) 
+#endif
+	{
 		prterr("domapwrite: msync");
 		report_failure(203);
 	}
@@ -1115,11 +1148,12 @@ int main(int argc, char **argv)
 	int i, style, ch;
 	char *endp;
 	int dirpath = 0;
-
+	struct timespec time_start, time_end, time_diff;
+	
 	goodfile[0] = 0;
 	logfile[0] = 0;
 
-	page_size = getpagesize();
+	page_size = (int)sysconf(_SC_PAGESIZE);
 	page_mask = page_size - 1;
 
 	setvbuf(stdout, NULL, _IOLBF, 0);	/* line buffered stdout */
@@ -1267,9 +1301,12 @@ int main(int argc, char **argv)
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
@@ -1336,12 +1373,18 @@ int main(int argc, char **argv)
 	} else
 		check_trunc_hack();
 
+	clock_gettime(CLOCK_ID, &time_start);
 	while (numops == -1 || numops--)
 		test();
 
 	close_test_files();
+	clock_gettime(CLOCK_ID, &time_end);
 	prt("All operations completed A-OK!\n");
 
+	time_diff = tst_timespec_diff(time_end, time_start);
+	prt("Elapsed Test Time %lu.%09lu\n",
+        (unsigned long)time_diff.tv_sec, time_diff.tv_nsec);
+
 	if (tf_buf)
 		free(tf_buf);
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
