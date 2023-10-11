Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F127CD98E7
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 02:28:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03B6D3C88F6
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 04:28:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32C743C88F6
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 04:28:36 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2CB54600816
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 04:28:33 +0200 (CEST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39B2LVlp010147
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 02:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=PPS06212021; bh=h10MGZdxi3yxl4wFJJ
 UzVR/HiLjZTZeCFUX5AQN4SP8=; b=SG8r9qMpv0d9zyi8tYtJLWmvNMj1c+cH4Z
 QKOmNHqWctw7H0Fbn1UdZdLzhrvjWNK//v6p8WX0XwjXbmQHkUJLfgtZGLEUBvRH
 T1NcZixKXvh4SFz3aui95p5GGfXAhKRxMupdDbSJItyj465a3htZCHO2HC2g+YUu
 TaoNNUd5glv+JKYJD9GBuFVFAGwxwhI/bGvxabv8LS4EPhVnCYukYnLpwOcEikLa
 +Efa0bW9UupQ8ofVa6zzcaEyAIvM+vyH49SPE2u+oEcLMSBpV1c9tQc+U/97NDCg
 KbpdoAndqsBtiLMvT67GH6vyV7chffbiySUMbJJv0PYamiYaJYJQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tnht881au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 02:28:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2DUFYlMSYH8Fm8HEZt5qE22DNvkPkvX5NdsUEkeOlKukO3OC7PtcIjDYV/glG2RaJoqR6sEyN5EHhkY0kUIGuz/A6wYLSy7IMgvpzmL8Iu0lSiSqxkCxOvVMXwQPo/W3fT+MtpP8tA1bspI35dUS0bXdoiGj8OEfysMh39xnsu6SavC4NjE5T/smgXAmrFK7Xk/UJO+pHkTZ6GaDfyfiFScIDUWVVj3AMK0tn42ANZI4RqLU9b3CkUrywF7izeqr4atpesjdEk/UBb5DtL9RLd2mUY7vXA2VVrF1yy/Xs3iLs5TPuczmZMFGICUfzbKBWAehAQwBWVEZHW/aNxPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h10MGZdxi3yxl4wFJJUzVR/HiLjZTZeCFUX5AQN4SP8=;
 b=IS7LJz0Vca03qBNopCwS862IkWH1BX+DIiiRqNzpAGiMXr0V2oE4NFM6RHzXBbLX24A3zQHouM0GkFeNp+TRul8VtetZUZFMrY15EmM1fg6xU0rbU35zURSXTuz0GzQxR5gg/EvK5bAVTfAZyXZS4plaOLZzlzRM/9Zkcm4bORydfW+xvqiyGhLFycoPpsphawaRiHe6r7dX9erfOOUNpzwiHBLA8RZhK7UGGiABW4fcYf9J8dXYgBQG5u8fAoytNZQtvOpxckCkkk1QX66dfH+F7ynhHKwW0K4MvMsOb82qV8dx0Z51yHtJkKP5qaf+lBBGnH8UXnSrYx2p76Z+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA2PR11MB4987.namprd11.prod.outlook.com (2603:10b6:806:113::24)
 by CH3PR11MB8154.namprd11.prod.outlook.com (2603:10b6:610:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 02:28:27 +0000
Received: from SA2PR11MB4987.namprd11.prod.outlook.com
 ([fe80::e9a2:eca8:8f41:7aa]) by SA2PR11MB4987.namprd11.prod.outlook.com
 ([fe80::e9a2:eca8:8f41:7aa%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 02:28:27 +0000
To: ltp@lists.linux.it
Date: Wed, 11 Oct 2023 10:27:46 +0800
Message-Id: <20231011022746.1530031-1-Xin.Wang@windriver.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: TYCPR01CA0006.jpnprd01.prod.outlook.com (2603:1096:405::18)
 To SA2PR11MB4987.namprd11.prod.outlook.com
 (2603:10b6:806:113::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4987:EE_|CH3PR11MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: f54619c8-76e4-4f42-d6ed-08dbca01c04a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HD9/fOznJITBoZAQAfe7YizJaOGUxsqCCB+9hCv1vMKeiiYHUeCNcvTq8S1ZvhD6n5E5dQyhylCOWEIiEZrXqmIjmQoP1pNREhJ8ZroY6+XzZcJ4R/9/YDahKsrwdmiI9i1KyRRNY8KJeCeIkRhXhfxg6pdqJINE6dKK8tKZBZnBRJUB6OwuM0ksGOFRYP4lrnjg7dtfNyQk2A3TedkO8+S0Hgn390YsHea3mz1b849bBGyhXHGzPBOd8JLyEHU+KNzt+jf/ws0fUw75mUHDW21vxsJGjrJyDk/z/dzFkjeWpgocCEYHTA+DALZfMIJvXac5aH0JGZKZdbOG9pkWkBT5+jq1FW8h/tG5/CWnEIW5eSJb2solJaUvhBCghG8iaGIrUNvUefyND1QU0NBvZNxrjZogmIGJOhD1N6EGf4uNepdNh0SwynIVxeXvDJV243iSsmvDAA8d04IT7bshALdjHh64MwpGdyp6HkemavYS26+VxPXTWJ8GlxeWYTAZqx9kXYM+7E3GXHRa8iFhg1M07x/pgw1KLcmED6fROBFxja7it1zxkbwwXWZR/XMIvWastFl/l6dfen8+WndDfcW9/LdK7S92i4FedXKzy3tBUtv0lgc20H4xDMaFcGDP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR11MB4987.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(366004)(396003)(39850400004)(376002)(136003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(107886003)(52116002)(6512007)(1076003)(36756003)(6506007)(86362001)(2616005)(38100700002)(38350700002)(26005)(8676002)(2906002)(83380400001)(6486002)(6666004)(478600001)(316002)(41300700001)(6916009)(4326008)(66556008)(5660300002)(8936002)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rYJqayVhmX5AGo4irdCj9xJ8px+68r8aQx2efXi1ivyr7TgSSge7xOTQVe28?=
 =?us-ascii?Q?D2p2of3Uhvdq3iO3rOm4XZJ9QaUn3gpnwbnGWPIXqmzxVTqxz4W6FBYxBBrS?=
 =?us-ascii?Q?QO4Y473vQDnWEgr2WCvslyiGm55qPupHRwMej88eRq4tHkMei4/dsrkm2n8Q?=
 =?us-ascii?Q?+rkoFMvB6F1WuWOmHf2LKdsRTfNe9eXz0yRIhCRCnX8wJBB3LLsPUoAsxLsE?=
 =?us-ascii?Q?CPxBYmcpjc08m2B1AoXq8whzC9MqPxAAKT4kJMfDdN011p6rkuppkfYj4WAk?=
 =?us-ascii?Q?eNV6YmCWI4j4kmJ9E3qnMiaT40DHo1WtB4YVWX9LwPgr9iv29D8k0dz8/n67?=
 =?us-ascii?Q?XX7p2gTKZl8/awEsSEL9lX1JXgpcxkgNJ/e/IUgXliIuqUdbI3h+J9UApwHh?=
 =?us-ascii?Q?njbqPhqYXtr4kBU5qAjItrCAABOFb8cp8iXS2Tz1ZMkKu1S5WrQOSGUN7a/G?=
 =?us-ascii?Q?fMgIkK/P3wR7ZucLsjXhhicaM1k0KxP/1eQ3BhrJ/udN57t5Yi7gwI+2JYmg?=
 =?us-ascii?Q?71lN7QN2o5nbXlHeR0o6yqlIeF1C5Db4Hmt9DfnQ/SN2qPun1B7Y3aTN25yB?=
 =?us-ascii?Q?0SjuMWh2+rbczsHwYsi8ZaQoI55n+S17qbCYinMhviyamJWbJv+//3VMseeY?=
 =?us-ascii?Q?AhAeQ4LVPaQtFRyFKzCjtgdS8lgApLmb6NR6C44FKvZnkxyo+tVYq3A86HhN?=
 =?us-ascii?Q?QlfaZQNCa/QLHnDS95go9zRGi8OSTrb6WOez/YfzFT2byEMTnVxwgZ6AZv1j?=
 =?us-ascii?Q?1xhdcLi6fPmf7JGwnmifPynFJYARrPXDcf87rlZ5fESHbMM84jeH3w55Afkq?=
 =?us-ascii?Q?JsfIt1BYNpWXGwPpM4/O5Qjsguxbq7J3tQq1wMuwISeyu7fL+LPsqlc06F88?=
 =?us-ascii?Q?vvax3kEdGHNKexdlj6w2F/It7FJsoL8FzK+TSAEaeXyUmYuQT5mKIWNdES+a?=
 =?us-ascii?Q?I7uBqwqBebYTtiSECF2MpJ8Pm1mWSf/En+Y8hjCBX2vbTU9XHNFLBwkptLXF?=
 =?us-ascii?Q?pL9FdoIDJPx542KWIEOXoDkGCqxOSn7RtllBkuDIgawzUHzf77yJ9IfTMtYo?=
 =?us-ascii?Q?4JyMXTvSLDltZAYrf6grlm6rPTq1pLDr9ZTgO4nOCVMbHITsyFXDhwBFh3E5?=
 =?us-ascii?Q?Ac+WpFXvzYRKJXZ1p2LZQhIFKSy5UanferIILTveR9mYczngSPHck1tmsdq/?=
 =?us-ascii?Q?7XcnAfjEOVdm2Z/dQ1N6dDs2wlsXnjhhOalbi48197EfoxQo4SzmFkCcUVrF?=
 =?us-ascii?Q?ildrYUvdbQFOd5ZAiIiWV/gshH+s/8J97dlQRcpCAAJBax7auXHloPv5yOoq?=
 =?us-ascii?Q?FMRNN3RGclHAW2UvQA/UrHKAKgWYCJjtC480ObzoRjtLdhp/CIMmLwCR70di?=
 =?us-ascii?Q?utPPAEht7hQjt/tBecvyPGdUQ4j7mGMXwV5zPiJ/9xo4X3+HvZZ9aKCt9JQf?=
 =?us-ascii?Q?VG0dxDORFyk+J9S70hIvx3M3wcYpJG9LlzMU6O5E5yb982JoEwgdkyWMzo9v?=
 =?us-ascii?Q?WItHJ/v05Irl45JdQJJfU1U4h0jYAIITz8aloi4P4gvsB0xiQQOlVs8PDsqc?=
 =?us-ascii?Q?78seCIbKsrXYna17pqLDDZ54Ah4FCECLEPm+59v6?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54619c8-76e4-4f42-d6ed-08dbca01c04a
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 02:28:27.5226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENE7dbGwWkOhdp98f4lOYPYAubyJLudq/gJGgQFLLd6+LxucQ04I5ZLoH06PrYrE0WHETcGSDK+fWy5+lDWJOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8154
X-Proofpoint-GUID: itL8YeqFJ5lv6UlQQKleLHt6Tlt6xWG3
X-Proofpoint-ORIG-GUID: itL8YeqFJ5lv6UlQQKleLHt6Tlt6xWG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_19,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2309180000 definitions=main-2310110021
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] This commit enable fsx-linux.c running on VxWorks
 user space and add measurement of execution time
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
