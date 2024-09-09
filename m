Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708E6CE7AB0
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 07:51:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECEF63C1032
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 09:51:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 189333C088E
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 06:42:47 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=nirjhar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 876E66010E9
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 06:42:45 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4887Ylhu018957;
 Mon, 9 Sep 2024 04:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=nHTe0zhAps6/U
 FeDz0mY08hiknxFVig0ppwzVdUvYl0=; b=UQ+0o/Zs4g2kKIkI6wCf226XYJi+o
 XVuoEVXF6IccWcM+UE0E9qKgCyHGVJ1rb07uVEUJE0iUuD6S8Y0fH7nTlLCZ6/N4
 CVhtw/vpNta3HX4BF7esn6LRNF9iwPnz8SMy+zHpbUMdYDlzqOwKXTu4MCFA+wSd
 LVhwwYmOu8d1jiPtLYHz1qnyhk+kcssVBoM6Y2m/xieRTEAg6E/O1yh29hMtYHN4
 CVqppqX/WZV0VRnXJfdKwf3Kd5NOlXvC3N+BQ0YcQMeD39VgzkqxlzqkK9x21Eqz
 0ov4eK8CpaWY+Bc2lsipPdHIi8MD1sJMSt/iIM7s22cisLvhVyojFkQMw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegwfrn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 04:42:43 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4894ggF6010392;
 Mon, 9 Sep 2024 04:42:42 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegwfrn8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 04:42:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4894HgWG013458;
 Mon, 9 Sep 2024 04:42:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3ckvfkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 04:42:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4894gdrt54329698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Sep 2024 04:42:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FD1420043;
 Mon,  9 Sep 2024 04:42:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3DE620040;
 Mon,  9 Sep 2024 04:42:37 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.in.ibm.com (unknown
 [9.109.247.80]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Sep 2024 04:42:37 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  9 Sep 2024 10:12:34 +0530
Message-ID: <5488fdbd9f26f1826fb083cfdbc357ac9ca954a4.1725601646.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1725601646.git.nirjhar@linux.ibm.com>
References: <cover.1725601646.git.nirjhar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BhNpB8lzZiirKPdW3lkEYoW2Hdikj91v
X-Proofpoint-ORIG-GUID: yh4I3dyeCeD4sSi4Oq01CCII4Hnk3Jcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_10,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090034
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 09 Sep 2024 09:50:32 +0200
Subject: [LTP] [PATCH v1 1/1] syscalls/<delete, init,
 finit>_module: Rename /proc/dummy to module specific path name
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Tests in syscalls/delete_module/, syscalls/init_module and syscalls/finit_module use kernel
modules all of which create a /proc/dummy node. When these tests run in parralel, there appears
to be a situation where these tests simulatenously tries to create /proc/dummy node. This generates
a kernel warning "proc_dir_entry '/proc/dummy' already registered".
This patch renames the /proc/dummy node to module specific name in order to avoid the conflict.

Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
---
 testcases/kernel/syscalls/delete_module/dummy_del_mod.c     | 6 ++++--
 testcases/kernel/syscalls/delete_module/dummy_del_mod_dep.c | 6 ++++--
 testcases/kernel/syscalls/finit_module/finit_module.c       | 6 ++++--
 testcases/kernel/syscalls/init_module/init_module.c         | 6 ++++--
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/delete_module/dummy_del_mod.c b/testcases/kernel/syscalls/delete_module/dummy_del_mod.c
index 0ca7bea37..4257bb504 100644
--- a/testcases/kernel/syscalls/delete_module/dummy_del_mod.c
+++ b/testcases/kernel/syscalls/delete_module/dummy_del_mod.c
@@ -14,6 +14,8 @@
 #include <linux/proc_fs.h>
 #include <linux/kernel.h>
 
+#define DIRNAME "dummy_delmod"
+
 /* Dummy function called by dependent module */
 int dummy_func_test(void)
 {
@@ -25,13 +27,13 @@ static int __init dummy_init(void)
 {
 	struct proc_dir_entry *proc_dummy;
 
-	proc_dummy = proc_mkdir("dummy", 0);
+	proc_dummy = proc_mkdir(DIRNAME, 0);
 	return 0;
 }
 
 static void __exit dummy_exit(void)
 {
-	remove_proc_entry("dummy", 0);
+	remove_proc_entry(DIRNAME, 0);
 }
 
 module_init(dummy_init);
diff --git a/testcases/kernel/syscalls/delete_module/dummy_del_mod_dep.c b/testcases/kernel/syscalls/delete_module/dummy_del_mod_dep.c
index 85b327911..8c891cf49 100644
--- a/testcases/kernel/syscalls/delete_module/dummy_del_mod_dep.c
+++ b/testcases/kernel/syscalls/delete_module/dummy_del_mod_dep.c
@@ -16,20 +16,22 @@
 #include <linux/proc_fs.h>
 #include <linux/kernel.h>
 
+#define DIRNAME "dummy_dep"
+
 extern int dummy_func_test(void);
 
 static int __init dummy_init(void)
 {
 	struct proc_dir_entry *proc_dummy;
 
-	proc_dummy = proc_mkdir("dummy_dep", 0);
+	proc_dummy = proc_mkdir(DIRNAME, 0);
 	dummy_func_test();
 	return 0;
 }
 
 static void __exit dummy_exit(void)
 {
-	remove_proc_entry("dummy_dep", 0);
+	remove_proc_entry(DIRNAME, 0);
 }
 
 module_init(dummy_init);
diff --git a/testcases/kernel/syscalls/finit_module/finit_module.c b/testcases/kernel/syscalls/finit_module/finit_module.c
index 78d03b899..a7b1e43c5 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module.c
@@ -13,6 +13,8 @@
 #include <linux/proc_fs.h>
 #include <linux/kernel.h>
 
+#define DIRNAME "dummy_finit"
+
 static char status[20];
 module_param_string(status, status, 20, 0444);
 
@@ -23,14 +25,14 @@ static int dummy_init(void)
 	if (!strcmp(status, "invalid"))
 		return -EINVAL;
 
-	proc_dummy = proc_mkdir("dummy", 0);
+	proc_dummy = proc_mkdir(DIRNAME, 0);
 	return 0;
 }
 module_init(dummy_init);
 
 static void dummy_exit(void)
 {
-	remove_proc_entry("dummy", 0);
+	remove_proc_entry(DIRNAME, 0);
 }
 module_exit(dummy_exit);
 
diff --git a/testcases/kernel/syscalls/init_module/init_module.c b/testcases/kernel/syscalls/init_module/init_module.c
index 78d03b899..f14cd80b6 100644
--- a/testcases/kernel/syscalls/init_module/init_module.c
+++ b/testcases/kernel/syscalls/init_module/init_module.c
@@ -13,6 +13,8 @@
 #include <linux/proc_fs.h>
 #include <linux/kernel.h>
 
+#define DIRNAME "dummy_init"
+
 static char status[20];
 module_param_string(status, status, 20, 0444);
 
@@ -23,14 +25,14 @@ static int dummy_init(void)
 	if (!strcmp(status, "invalid"))
 		return -EINVAL;
 
-	proc_dummy = proc_mkdir("dummy", 0);
+	proc_dummy = proc_mkdir(DIRNAME, 0);
 	return 0;
 }
 module_init(dummy_init);
 
 static void dummy_exit(void)
 {
-	remove_proc_entry("dummy", 0);
+	remove_proc_entry(DIRNAME, 0);
 }
 module_exit(dummy_exit);
 
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
