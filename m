Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026CFCD343F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:48:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6161A3E6146
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 12:48:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 573ED3C5A8C
 for <ltp@lists.linux.it>; Thu,  7 May 2026 12:48:22 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 799DC1400071
 for <ltp@lists.linux.it>; Thu,  7 May 2026 12:48:20 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64709wwv2712935; Thu, 7 May 2026 10:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=QwY6zgHnL+bBgVbwgFHUIjvZigY1owVM6ThIG2YCO
 zs=; b=E6wmu3PZY0Rb4C+8Djn+H4s9ZCNSX1GvVFcmgxVglmvj44uThcxeUtSQj
 chrtqdZN3ls79cNsUUE22wCuN0rjSC1bAfQCg7WzxFPE6HKhuDHEYFDZ6/rL6rJD
 7f35Gy3MOwPFYgGGMbqFbWM9QFCjy79+MUrESKoeXXVZL/s2ptC0zo21X0anSwNG
 v7XEqYhAyntfEB8gp4FQUilLV+ADNA/RYiP5xBiTPWgY5A0Kg9BpNd1errvGmvMD
 1ix3gkpCW21iFIR5mqtsXtTazpDD7VfIbbu0U3+si1Ab+MpFIaVXdUxsQcwzeQsl
 j4q6VvqWPof/gUa9SWI2ELBlLWJmw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4vscp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2026 10:48:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647AdcTe009763;
 Thu, 7 May 2026 10:48:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgjmce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2026 10:48:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 647AmG5V28639864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 May 2026 10:48:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBF3D20043;
 Thu,  7 May 2026 10:48:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5390C20040;
 Thu,  7 May 2026 10:48:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.101.71])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 May 2026 10:48:16 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 16:18:14 +0530
Message-Id: <20260507104815.12161-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEwNSBTYWx0ZWRfXwlshEsZmzpkC
 e5gJyJ7xQdRINKpCAIbNOGCRUmx5uSDZTN0ypwJTdFPSWjNOUfVZRkfK/5GxGtlM1ppA1iWDREY
 FmPz1SMjbt6XxvoykkjfGafAU1PAphq0sDYtMTSXFUL03YyDh2Z32YB+/dYM03XUwXTMYdY+bwf
 6d5oqFDbg0rJpIcFYNuEPIvRMQnsiaCLZN/3+UTCmYm4nR4d38zX/IqEd2lmrjORScAAQeWzMDP
 3EulX3V4B/Boeyy9PIqruduidNbJn5LmMJsP66+i4n3CMV/dtwnIXvD7fmpkFS0ucm68JFPrm+e
 +QOAPMHmn1OxQLuqERZR+8s96T7d5Eyi7Gd6VD063d5jSY1AxuyY4kWgBGj0HvJVHm7HCvaGcYh
 Q8jNEFzo1qXIVBOiXEBaQQE1LwAGJkEQfEZB/Vwc2AJSTybsQcD2txJBkdhfoQYn/Thwp/Wwnw8
 u/Lw3NNWI+L+IBRMbHA==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fc6df3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=eR2rzuTUKTB_TkdJYpAA:9
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: TxGkbCOa-bKbVUymakb8lB-c6eHPOMGi
X-Proofpoint-ORIG-GUID: TxGkbCOa-bKbVUymakb8lB-c6eHPOMGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070105
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RESEND][PATCH v5 1/2] doc: Add CVE catalog to documentation
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
 doc/Makefile              |  2 +-
 doc/conf.py               | 84 +++++++++++++++++++++++++++++++++++++++
 doc/index.rst             |  4 ++
 doc/users/cve_catalog.rst |  6 +++
 4 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 doc/users/cve_catalog.rst

diff --git a/doc/Makefile b/doc/Makefile
index 3123b1cd7..1da240530 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -31,7 +31,7 @@ spelling:
 
 clean:
 	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
-		${abs_top_builddir}/metadata/ltp.json
+		_static/cve.rst ${abs_top_builddir}/metadata/ltp.json
 
 distclean: clean
 	rm -rf $(VENV_DIR)
diff --git a/doc/conf.py b/doc/conf.py
index 63d09352e..9b81162c5 100644
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
+            if len(tag) >= 2 and tag[0] == 'CVE':
+                cve_id = tag[1].upper()
+                # Normalize CVE ID format: ensure it starts with "CVE-"
+                if not cve_id.startswith('CVE-'):
+                    cve_id = 'CVE-' + cve_id
+                if cve_id not in cve_data:
+                    cve_data[cve_id] = []
+                cve_data[cve_id].append(test_name)
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
