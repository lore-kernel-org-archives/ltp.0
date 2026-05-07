Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1121FCD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:49:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97E993E24C9
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 12:48:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA3893C5A8C
 for <ltp@lists.linux.it>; Thu,  7 May 2026 12:48:22 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1C25910000E7
 for <ltp@lists.linux.it>; Thu,  7 May 2026 12:48:21 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646M8ICD2062528; Thu, 7 May 2026 10:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0VYuoujk68WrfyK0K
 mf6BHTvpVaUiA968H0sRg0C90k=; b=PQNv0xT/b+7kxsngmiXlrc7D8A4k+R8OR
 LkzOM5Xtad+WDd7dqAKq8v0nQYS790leH2vdn7cwDZfn+x9Z4G9a8xnm5NjvBbZK
 12qskNpgm+IxX7qldmbRkn8PafRfXuP9lmblmoQGiE8ynOfK3skh4cmsWWwd0CNo
 XPX0cePuSMgU18ZEQKgU80Posk0n4oj0YVVefBbgd3F54krcY4slmKBEJva8I6Y3
 ujeBPp9soJ8HmR26Lyl6F85rXy0r5SW0qiK3gJUBE15EYy0wEcdbK1ucOl5TfpAL
 +/dyc/f/iXSEC2C5fcm7Z15/BDy8xh4dPBWvaHGNOBmja6G+RXKzQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6mrvv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2026 10:48:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647A9Xw1027854;
 Thu, 7 May 2026 10:48:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3harns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2026 10:48:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 647AmHA450987426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 May 2026 10:48:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C027D20043;
 Thu,  7 May 2026 10:48:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 376EE20040;
 Thu,  7 May 2026 10:48:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.101.71])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 May 2026 10:48:17 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 16:18:15 +0530
Message-Id: <20260507104815.12161-2-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260507104815.12161-1-sachinp@linux.ibm.com>
References: <20260507104815.12161-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fc6df4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=GcyzOjIWAAAA:8 a=iox4zFpeAAAA:8 a=VnNF1IyMAAAA:8
 a=ZDXDJ1Unu6paE_oJK8MA:9 a=hQL3dl6oAZ8NdCsdz28n:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: HEvtl1w2tKWjhmNpQnL63N-JuF1H_Mtr
X-Proofpoint-GUID: HEvtl1w2tKWjhmNpQnL63N-JuF1H_Mtr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEwNSBTYWx0ZWRfX0UUXjD9PtSpF
 vwADepkSIsZGimLmBY/ykmPa3OSK4AnMy4qfUhrY3NDHaoSD7rUorh5aT68RmSeBuyAh7+4ZTab
 zf/oEELs77AWjtcFGcOehJ5ZFXFJ3RtsfcUKFNLYQJ+5qww9bw32UCe1cqjYjD0pRqFtMuzSiYt
 OPh11l9N3Iz1xbj+6dd7/Yg4y+sBzbCkHL5Zn3l67RlTdE7sZneViR8FyH5RIbbLL4APbHZBK2F
 RQCY+FMkBbOp0tGXSvsgtGKOWaSmJ6adC6c/7aKncEUZAv42cdwsmjK+T5e8BNthEZ6v4eQ6gDm
 m+ntbJ8ljG3dGvsuG0ocun6HtdovQO1cVCtyl5GEd+kYBjGsNMaY2UwlW/pV0ObsbPstO/bdi8g
 rH2we2TCzdUZt4jdQP2SS/bdKFvlpaNzaKJRmk7EPRYPlu6dQJ/r5NgyTk1z4dMajhpWVbYmj3B
 ROjKd4IxxaN/RIPMOIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070105
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RESEND][PATCH 2/2] doc: Rename statistics page to 'Supported
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
index 9b81162c5..013f3d940 100644
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
+    Generate supported syscalls documentation. We fetch the syscalls list
+    from the kernel sources, then we compare it with testcases/kernel/syscalls
+    folder and generate a file that is included in the supported syscalls
+    documentation section.
     """
     output = '_static/syscalls.rst'
 
@@ -625,6 +626,6 @@ def setup(app):
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
