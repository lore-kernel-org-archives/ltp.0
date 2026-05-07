Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BE3CD3442
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:40:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8B503E5F5C
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 12:40:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1E133C1B73
 for <ltp@lists.linux.it>; Thu,  7 May 2026 12:40:29 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A07B7200751
 for <ltp@lists.linux.it>; Thu,  7 May 2026 12:40:27 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6478n80T1103525; Thu, 7 May 2026 10:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ITUSRhXmqSCKgKuhm
 Qi+4dDcJTSW57LQYj9lwwILc3I=; b=YOz8xRiGzNN4VvWEA+DYHJF6YTujXqTZ+
 aXfQBY3u5yyQZFiGbVT1I4lI3gIHawcekVxhH0Olvus6LqtoP4SKI0RcM8vOqVzP
 eryxZPJ9aW7WGIo/IweFdyCJU4LKs99c+gRQhwnvZpO4slr1dbYxEdoOcD/E0vwv
 dbLZzDG6kOonbJ9Wsj89Capdx5fKwyFBd5a1ElEuwN0XAGgObgMZ+Qp7rpQfsW8D
 gbW5OCv6g+v0zgu8IHoaqA6nIzfNSvjPjaFktr4uE22VNYBZpwiopjb6Wk/A88Zb
 cvx00XcbDqhYVfWLcP508Z1bowcjSQWPjilKm9BF1vz+ENKmqVeUQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4vqwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2026 10:40:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647AdXvi009721;
 Thu, 7 May 2026 10:40:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgjjuw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2026 10:40:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 647AeNwr41615622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 May 2026 10:40:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74ACB2004B;
 Thu,  7 May 2026 10:40:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E25DE2004D;
 Thu,  7 May 2026 10:40:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.101.71])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 May 2026 10:40:22 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 16:10:18 +0530
Message-Id: <20260507104019.9764-3-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260507104019.9764-1-sachinp@linux.ibm.com>
References: <20260507104019.9764-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEwNSBTYWx0ZWRfX919Au1hOo4SM
 4ciVWOn3LNhFaRpoUBHqGuyoIz/Jyd8wgjF+3UEIdetTYvJBtc3di6Umj6QjpRdRQlt5BbLQt9J
 erSJBlrgsVIzxIBCGDzRC+TAm/Ddq18hkQPfs/3BfFCl/A5BuviH/Cx7rse0lYqStaWuBOh4Jb0
 qTvsELAiFVG95jH2qV5hFwOHPC0i9wh21Pa+k9az5+2zCE2t0RY2aowdVzDCfioSaLJGW8c4jCy
 Qp1kYiXZ4Gz71TNGe4tj82OkiFo5mlD0ufkjTdgpiQHpei3hdv/WfogI9IIl5SzlRN3RGIl5IPT
 BNDD+mOrN29yZn9AyZe3+t/390HHtb+OnbolbbcvQ4cRfD98QY3Ju0ofeErUmamFCORkt2dltI0
 tnNlaJWQUz1ey+YGEkcjTtHkL8/HMWkPWdpdSd9BR7DCeoFP18b4xhoybaVHmgYhMMd1MHjBA1p
 xGibgXOjeCQSuu5yKHg==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fc6c19 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=eR2rzuTUKTB_TkdJYpAA:9
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: eGKeafel8sBPrY82xcm5Sbzulj5sN6Hs
X-Proofpoint-ORIG-GUID: eGKeafel8sBPrY82xcm5Sbzulj5sN6Hs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070105
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] doc: Add CVE catalog to documentation
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

Add a new CVE catalog page that automatically generates a comprehensive
list of all CVE reproducers available in LTP. The catalog extracts CVE
information from test metadata tags and presents them in a table format
with links to corresponding test cases.

Changes:
- Add doc/users/cve_catalog.rst as new documentation page
- Implement generate_cve_catalog() in doc/conf.py to extract CVE tags
  from metadata/ltp.json and generate _static/cve.rst
- Configure autosectionlabel with document prefixes to prevent duplicate
  label warnings when same test names appear in multiple files
- Update doc/Makefile to clean generated _static/cve.rst file
- Add CVE catalog link to main documentation index

The catalog displays CVEs in descending order (newest first) with
cross-references to test cases in the test catalog, making it easy
to find reproducers for specific CVEs.

Closes: https://github.com/linux-test-project/ltp/issues/1254
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V5 changes:
- Rewrite CVE catalog logic to only use ltp.json metadata
- Remove the dependency on runtest/cve file
- v4 link https://lore.kernel.org/ltp/aftwmBUir04jaik4@yuki.lan/T/#t

V4 changes:
- Simplified the CVE table (id, test name)
- Removed individual CVE pages
- v3 link https://lore.kernel.org/ltp/69f0b046.df0a0220.3765a8.f8e4@mx.google.com/T/#u

V3 changes:
- CVEs sorted in descending order
- append test name to CVE id : CVE (Test Name)
- Separate page for CVE catalog
- Link cve testcases to Test catalog entry
- v2 link https://lore.kernel.org/ltp/0df5f75d-eb8f-428e-9888-bb7a90a6b1a4@linux.ibm.com/

V2 changes:
- Replace Fixes tag by Closes
- V1 link https://lore.kernel.org/ltp/20260423105304.59788-1-sachinp@linux.ibm.com/T/#u
---
 doc/Makefile              |  3 +-
 doc/conf.py               | 84 +++++++++++++++++++++++++++++++++++++++
 doc/index.rst             |  4 ++
 doc/users/cve_catalog.rst |  6 +++
 4 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 doc/users/cve_catalog.rst

diff --git a/doc/Makefile b/doc/Makefile
index 3123b1cd7..77a0fafad 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -30,8 +30,7 @@ spelling:
 	$(RUN_VENV); sphinx-build -b spelling -d build/doctree . build/spelling
 
 clean:
-	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
-		${abs_top_builddir}/metadata/ltp.json
+	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst _static/cve.rst syscalls.tbl
 
 distclean: clean
 	rm -rf $(VENV_DIR)
diff --git a/doc/conf.py b/doc/conf.py
index 63d09352e..a63849322 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -30,6 +30,15 @@ extensions = [
     'sphinx.ext.extlinks',
 ]
 
+# Configure autosectionlabel to prefix labels with document name
+# This prevents duplicate labels when same test name appears in multiple files
+autosectionlabel_prefix_document = True
+# Only create labels for sections with unique names
+autosectionlabel_maxdepth = 2
+
+# Suppress duplicate label warnings for kernel-doc generated content
+suppress_warnings = ['autosectionlabel.*']
+
 exclude_patterns = ["html*", '_static*', '.venv*']
 extlinks = {
     'repo': (f'{ltp_repo}/%s', '%s'),
@@ -535,6 +544,80 @@ def generate_test_catalog(_):
     with open(output, 'w+', encoding='utf-8') as new_tests:
         new_tests.write('\n'.join(text))
 
+def generate_cve_catalog(_):
+    """
+    Generate CVE catalog in a single file by extracting CVE tags from
+    metadata/ltp.json. This creates a single _static/cve.rst file with
+    all CVE information and links to test sources.
+    """
+    output = '_static/cve.rst'
+    metadata_file = '../metadata/ltp.json'
+
+    # Load metadata
+    metadata = None
+    try:
+        with open(metadata_file, 'r', encoding='utf-8') as data:
+            metadata = json.load(data)
+    except FileNotFoundError:
+        logger = sphinx.util.logging.getLogger(__name__)
+        msg = f"Can't find metadata file ({metadata_file})"
+        logger.warning(msg)
+        return
+
+    # Extract CVE information from test tags
+    cve_data = {}
+    tests = metadata.get('tests', {})
+
+    for test_name, test_info in tests.items():
+        tags = test_info.get('tags', [])
+        for tag in tags:
+        	if len(tag) >= 2 and tag[0] == 'CVE':
+        		cve_id = tag[1].upper()
+        		# Normalize CVE ID format: ensure it starts with "CVE-"
+        		if not cve_id.startswith('CVE-'):
+        			cve_id = 'CVE-' + cve_id
+        		if cve_id not in cve_data:
+        			cve_data[cve_id] = []
+        		cve_data[cve_id].append(test_name)
+
+    # Generate single CVE catalog file
+    total_cves = len(cve_data)
+    text = [
+        '.. warning::',
+        '    The following CVE catalog has been generated from test',
+        '    metadata and includes all CVE reproducers in LTP.',
+        '',
+        f'LTP includes reproducers for {total_cves} known CVEs.',
+        '',
+        '.. list-table::',
+        '   :header-rows: 1',
+        '   :widths: 40 60',
+        '',
+        '   * - CVE ID',
+        '     - Test Name(s)',
+    ]
+
+    # Add CVEs in descending order (newest first)
+    for cve_id in sorted(cve_data.keys(), reverse=True):
+        test_names = cve_data[cve_id]
+
+        # Create cross-references for all tests
+        test_links = []
+        for test_name in sorted(test_names):
+            test_anchor = f"users/test_catalog:{test_name}"
+            test_link = f":ref:`{test_name} <{test_anchor}>`"
+            test_links.append(test_link)
+
+        # Join multiple tests with commas
+        tests_str = ', '.join(test_links)
+
+        text.extend([
+            f'   * - {cve_id}',
+            f'     - {tests_str}',
+        ])
+
+    with open(output, 'w+', encoding='utf-8') as cve_catalog:
+        cve_catalog.write('\n'.join(text))
 
 def setup(app):
     """
@@ -543,4 +626,5 @@ def setup(app):
     """
     app.add_css_file('custom.css')
     app.connect('builder-inited', generate_syscalls_stats)
+    app.connect('builder-inited', generate_cve_catalog)
     app.connect('builder-inited', generate_test_catalog)
diff --git a/doc/index.rst b/doc/index.rst
index 496a12f80..733495f51 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -12,6 +12,7 @@
    users/testers_guide
    users/supported_systems
    users/stats
+   users/cve_catalog
    users/test_catalog
 
 .. toctree::
@@ -58,6 +59,9 @@ For users
 :doc:`users/stats`
    Some LTP statistics
 
+:doc:`users/cve_catalog`
+   LTP reproducers for known CVEs
+
 :doc:`users/test_catalog`
    The LTP test catalog
 
diff --git a/doc/users/cve_catalog.rst b/doc/users/cve_catalog.rst
new file mode 100644
index 000000000..5a5b9b54a
--- /dev/null
+++ b/doc/users/cve_catalog.rst
@@ -0,0 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+CVE catalog
+===========
+
+.. include:: ../_static/cve.rst
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
