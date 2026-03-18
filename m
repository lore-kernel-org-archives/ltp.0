Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9685C103E17A
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 14:11:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 337793E608C
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 15:11:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7EB73D0343
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 09:25:06 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CFC7D600D4A
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 09:25:05 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62I4Exri2776227
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 08:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=yYl/Xkr0FqbApvhxpllIEy041E1loHPjIKS/FshKk
 jQ=; b=agV2JSTGO+PyphGXeOoXUdn2JZKgOy1Y9V+DxQDk//hmJdiG1sz8b2Jyj
 QkJnJNMuhK6QLJuFdPrndenpL74/JEScYYqzyaHV4henfkrpkMuiCxfsTwv8j9NK
 5+eq8eTRg+ld8wYJPW5oFdYB3OmlgXgCwGABcaoXXwMbk7e+sLu5AKeu9vd9BNVy
 uiPdI4a+t8gx8yu5u+UG2QkzRHjI3TbEZlN4SzyMdQLJJ5o5/U0gSq76awy63CzW
 lL5VPLxITVIOe2PVWtUmWO7WtEzujb7V3YodoK63W7XlE1DncvhDDrYePzWlJVSs
 oRJvj6hcKPj2+dytBaW3KwrbrVhLA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs8w7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 08:25:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I4hqcJ015746
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 08:25:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nd3n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 08:25:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62I8Ow9g30212528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2026 08:24:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F3EF2004B;
 Wed, 18 Mar 2026 08:24:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75A9720043;
 Wed, 18 Mar 2026 08:24:57 +0000 (GMT)
Received: from macbookpro.bl1-in.ibm.com (unknown [9.123.4.214])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Mar 2026 08:24:57 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 18 Mar 2026 13:54:38 +0530
Message-ID: <20260318082438.50245-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69ba615f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=lJQxSSZAEziOSCmnKaAA:9
X-Proofpoint-ORIG-GUID: 8VxNlGbjYD-MQy7bS0kGUo6wqXBPr9z0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2OSBTYWx0ZWRfXz9AIkkkotGDc
 DgynkXo9ZM7rKifUYOtOQG7PqnLRYtB9DuWxARqdJKYcxhm806b1LeIQv2a9jjRgFkhxFmzmEzn
 rwWtk95JQxEBPWdzXUeEljQstYyA1AE9F59Ia5R6dUnqwZvGtglybgfMqQyVdDkAgv0nornzlyf
 nFKODBthFgeDCL6DUsuA8PZly8KahnvSWoPIxm2NhDCbD68Vh6ca6x9Gszrdw55zL5zGo4F8N4h
 /rmbpgW+VRgu8jIdz0NcUv77wP8QZgdcjQ0FjjhlHmboxvkke4xOCGpYwEWE3ADFpu9DPCgSLRX
 yXzlA+IU4YeLk40hpSZ/xWO6haXcRU/NGkwQKKWMWlB8SQaoZoLbDf7svgxNaoY1NGTopvUIHHB
 8N3IYM4J/Qc9Kfxisd9t/Qa6XNxEFv0gzzkvzCst73iJXG6HiCt2y3rxxlc2C9bGBnWWxGyXsaA
 Wd4TtV9wQM7fzwt4zIg==
X-Proofpoint-GUID: 8VxNlGbjYD-MQy7bS0kGUo6wqXBPr9z0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180069
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:10:54 +0100
Subject: [LTP] [PATCH] syscalls/ustat: Skip tests on Btrfs using TCONF
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
Cc: disgoel@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The ustat(2) system call is known to fail with EINVAL on Btrfs because
it uses anonymous device IDs for subvolumes, which the legacy syscall
cannot resolve to a physical block device.

Currently, this results in a TFAIL, which causes false negatives in
automated CI environments (e.g., SLES). This patch adds dynamic
filesystem detection in setup() and uses tst_brk(TCONF, ...) to
gracefully skip the test on Btrfs.

Changes:
  - Added sys/vfs.h for statfs support.
  - Implemented Btrfs magic number detection in setup().
  - Used tst_brk(TCONF, ...) to skip the test if Btrfs is detected.

Verified on:
  - SLES (Btrfs): Result is now TCONF (Skipped)
  - RHEL (XFS): Result remains TPASS

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
 testcases/kernel/syscalls/ustat/ustat01.c | 8 +++++++-
 testcases/kernel/syscalls/ustat/ustat02.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
index 161006058..07ee2faf7 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -13,6 +13,7 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/vfs.h>
 
 #include "lapi/syscalls.h"
 #include "lapi/ustat.h"
@@ -34,11 +35,16 @@ void run(void)
 static void setup(void)
 {
 	struct stat buf;
+	struct statfs fs_buf;
 
 	/* Find a valid device number */
 	SAFE_STAT("/", &buf);
-
 	dev_num = buf.st_dev;
+
+	statfs("/", &fs_buf);
+	if (fs_buf.f_type == 0x9123683E) {
+		tst_brk(TCONF, "%s", test.tags[0].value);
+	}
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index 84becaa1f..789ef57fc 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/vfs.h>
 
 #include "lapi/syscalls.h"
 #include "lapi/ustat.h"
@@ -50,11 +51,16 @@ void run(unsigned int test)
 static void setup(void)
 {
 	struct stat buf;
+	struct statfs fs_buf;
 
 	/* Find a valid device number */
 	SAFE_STAT("/", &buf);
-
 	root_dev = buf.st_dev;
+
+	statfs("/", &fs_buf);
+	if (fs_buf.f_type == 0x9123683E) {
+		tst_brk(TCONF, "%s", test.tags[0].value);
+	}
 }
 
 static struct tst_test test = {
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
