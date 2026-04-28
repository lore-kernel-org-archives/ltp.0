Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF36FF885A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 14:37:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D81C3E49FA
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 16:37:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96C393E1A46
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 16:36:24 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AF0C21000478
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 16:36:23 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S5jXsf2981403; Tue, 28 Apr 2026 14:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=o3VumKDUqWdGpdhFf
 Mdfv/ZJz9Z0m1V4Y15QdJH4VO0=; b=ZCdqdbA6+RToU1CTt+dSU6NCF7fV/9uTV
 2lY00y8Iw1IC0a6gHLC18iGrpcO2fxraiPh6Vcep4D4h+xWGMycEf7JGZ3krDvBH
 p1aLGqLbbntKIhKpBABlFrLII2Z3rft1EFUvOSVJS1ERM1Cvz8X5jStQcfqH6Vo+
 5aU/dXB21s0Hhyb7PpcVksnvZCNcnhxbM4mY0gAKUV3SS2e4HTO0zA/GNYgn5rXd
 m4rENhCQaSe6hrV2UOz2doKFiWFtGWVmTMed7+ILIn/B8CD8vmRl8nMAxkWNkCjs
 4ajfAuxgkLAfFySoSg54t4hqGXdZzR/H1GjvVyEvy3+rz/CEhGNqA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb560cy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 14:36:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SENhPR003967;
 Tue, 28 Apr 2026 14:36:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk2408-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 14:36:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SEaIxv25821492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 14:36:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17CC520043;
 Tue, 28 Apr 2026 14:36:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C2DC20040;
 Tue, 28 Apr 2026 14:36:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.64.210])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 14:36:17 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 28 Apr 2026 20:06:14 +0530
Message-Id: <20260428143614.69724-2-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260428143614.69724-1-sachinp@linux.ibm.com>
References: <20260428143614.69724-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f0c5e5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=GcyzOjIWAAAA:8 a=iox4zFpeAAAA:8 a=VnNF1IyMAAAA:8
 a=ZDXDJ1Unu6paE_oJK8MA:9 a=hQL3dl6oAZ8NdCsdz28n:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNSBTYWx0ZWRfXwwX2KUW2/vIW
 bY+AzTazh5q/zvN+3NQmXexH1pmPtWZzI5J5C/cHDk0wD5bcxsXAjRSiNXPkVwjWzkl4l86k8ST
 LHEsA26tw1kKhRDBwOyuFPypoVTTCeIvfBmFtN0ymdq8VL/1JrN8NNxNgnCpGlGRn/P/CF91OYv
 x/OxjOnjjBPEeSgy24tjfFDn4qg+mxv7xnotmlMyOJ+IBMNJXWJj9glx7NXBIrGfInMJnn2xo+I
 59GOxb407AmYUxDoOiA2hrhFm7cAtH3D43IcMtO4su2gmNfnjL3kYFoG2wS6g64q83o3Fnsp8Zc
 XlcRanLDYkOea5ZwPyA2ymDNE1U9BfsQNjUrVq1sBMpZqBQkrdQAFBYhQUfa+y7Gbg9ZdQ0bYXy
 RUAPzP/enz1i5+tyEntK80hRIRZQyB6sd727Al7NLDITuoA86K8BZKHErlTPE1X8O4xFrE4WSwC
 95oivbH0WryL3Yq5Mtw==
X-Proofpoint-GUID: AZr_LPieCbAk4iR6Gg3TFXPaXnzj1dn6
X-Proofpoint-ORIG-GUID: AZr_LPieCbAk4iR6Gg3TFXPaXnzj1dn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280135
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] doc: Rename statistics page to 'Supported
 syscalls'
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Rename the documentation page from 'Statistics' to 'Supported syscalls'
to better reflect its content, which focuses on syscall coverage.

- Renamed doc/users/stats.rst to doc/users/supported_syscalls.rst
- Updated page title and description
- Updated references in doc/index.rst
- Updated spelling exclusion pattern in doc/conf.py
- Renamed function definition from generate_syscalls_stats to
  generate_supported_syscalls
- Updated app.connect() call to use the new function name

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 doc/conf.py                      | 13 +++++++------
 doc/index.rst                    |  6 +++---
 doc/users/stats.rst              |  9 ---------
 doc/users/supported_syscalls.rst |  9 +++++++++
 4 files changed, 19 insertions(+), 18 deletions(-)
 delete mode 100644 doc/users/stats.rst
 create mode 100644 doc/users/supported_syscalls.rst

diff --git a/doc/conf.py b/doc/conf.py
index d692638a0..a4fdf1436 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -55,7 +55,7 @@ manpages_url = 'https://man7.org/linux/man-pages/man{section}/{page}.{section}.h
 
 spelling_lang = "en_US"
 spelling_warning = True
-spelling_exclude_patterns = ['users/stats.rst']
+spelling_exclude_patterns = ['users/supported_syscalls.rst']
 spelling_word_list_filename = "spelling_wordlist"
 
 # -- Options for HTML output -------------------------------------------------
@@ -65,11 +65,12 @@ html_theme = 'sphinx_rtd_theme'
 html_static_path = ['_static']
 
 
-def generate_syscalls_stats(_):
+def generate_supported_syscalls(_):
     """
-    Generate statistics for syscalls. We fetch the syscalls list from the kernel
-    sources, then we compare it with testcases/kernel/syscalls folder and
-    generate a file that is included in the statistics documentation section.
+    Generate supported syscalls documentation. We fetch the syscalls list from
+    the kernel sources, then we compare it with testcases/kernel/syscalls folder
+    and generate a file that is included in the supported syscalls documentation
+    section.
     """
     output = '_static/syscalls.rst'
 
@@ -632,6 +633,6 @@ def setup(app):
     customizations.
     """
     app.add_css_file('custom.css')
-    app.connect('builder-inited', generate_syscalls_stats)
+    app.connect('builder-inited', generate_supported_syscalls)
     app.connect('builder-inited', generate_cve_catalog)
     app.connect('builder-inited', generate_test_catalog)
diff --git a/doc/index.rst b/doc/index.rst
index 733495f51..f80ca4be1 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -11,7 +11,7 @@
    users/setup_tests
    users/testers_guide
    users/supported_systems
-   users/stats
+   users/supported_syscalls
    users/cve_catalog
    users/test_catalog
 
@@ -56,8 +56,8 @@ For users
 :doc:`users/supported_systems`
    A list of supported technologies by the LTP framework
 
-:doc:`users/stats`
-   Some LTP statistics
+:doc:`users/supported_syscalls`
+   Syscalls supported by LTP tests
 
 :doc:`users/cve_catalog`
    LTP reproducers for known CVEs
diff --git a/doc/users/stats.rst b/doc/users/stats.rst
deleted file mode 100644
index 7073442aa..000000000
--- a/doc/users/stats.rst
+++ /dev/null
@@ -1,9 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0-or-later
-
-Statistics
-==========
-
-In this section we collect some statistics related to the current state of
-LTP tests.
-
-.. include:: ../_static/syscalls.rst
diff --git a/doc/users/supported_syscalls.rst b/doc/users/supported_syscalls.rst
new file mode 100644
index 000000000..6914852c6
--- /dev/null
+++ b/doc/users/supported_syscalls.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Supported syscalls
+==================
+
+In this section we collect information about syscalls that are currently
+tested by LTP.
+
+.. include:: ../_static/syscalls.rst
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
