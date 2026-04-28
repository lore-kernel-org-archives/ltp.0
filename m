Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D16FF8868
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 14:36:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 866C53E49FB
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 16:36:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 222193E1A46
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 16:36:23 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D7BC31400773
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 16:36:22 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SCUuB9872522; Tue, 28 Apr 2026 14:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=wQn/hA07RV6ozX6ptF+Ko2UPeMakO9BLsK/6RlSj2
 0s=; b=LhiwK/E6lurrCAhfQdeD9MuqLDae5ElwluMLc2OUrUFBeZKUU5plPxatL
 tRNPdU63vXLDsRPpSKRPugDhntlN/gHE9cXMIafOfw000Ado4+GyPABIWUwDLuuF
 ogjcISahhfC1kEq+gUWFFDl5gSVBEuBafBv4nOAi/1XSHV5NlvO1NXEbdxCzwuk9
 RfV25V9EXAzH8RnKvS/XtSAWvlDDNo0tveBTHbplPlsDiW7fpQSYgdty5WroIgVh
 nWVPCra1Zhhc+jjyzO1enjIF+aUkFVKmiBEebcpvVmATuubg+4nF7zNBH4EC/qIF
 JCLg9AZbn+dnZ9su/ZdvtM42v2Eow==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r60ds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 14:36:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SENhKs001900;
 Tue, 28 Apr 2026 14:36:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9eha15a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 14:36:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SEaHQj48234896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 14:36:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1368E20043;
 Tue, 28 Apr 2026 14:36:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 416E520040;
 Tue, 28 Apr 2026 14:36:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.64.210])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 14:36:16 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 28 Apr 2026 20:06:13 +0530
Message-Id: <20260428143614.69724-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XtAY6kHpdD3V8G3tUlTIXJEy3_5Q28UR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNSBTYWx0ZWRfXxecJR/5+tKaV
 3r4B5kmHoJG6m/pgSLvrHauLke0Sqse2O/Ipy95McHnZ+sO/7fNfJSu+ldE1UemBvuxx6qsjtEK
 yyS2uva902z33HTwOoJY0mtzwmDy7VcHEs7x7nWrm5iufu1qVMcnmtBxr5ZOr5+WNipWTwRcn1j
 KyHVMHb0ntGL0Yp8z9Wj2zrghgjtXqWCQW4/q6urgoI5zO0ovZ3eBTwJ5whvL2RtqdJRUQ6pqE/
 SaTuUKwxVOJHvmzJhbePN5fuyMm/P5fC4fVXcIKMGcKI4JKhpX67nitmL1ht/KSgfr4qCZ3ohry
 9R0aAFWsnigAAwDCqybx8D2hwxyuXaj49da+05PGUfjqZe5pl9+iG1YpN6SXNSSyHUa9oPaekvS
 Gl9hWDNYA7d4sNTB9N56cFwztKxolU8+cQTNBSSUtrtGZWIOJYaZGE0sOMsJ9z4L/WxEBcCHsAF
 Wp97vcb5vT8YCBVi0Vg==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f0c5e4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=eR2rzuTUKTB_TkdJYpAA:9
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: XtAY6kHpdD3V8G3tUlTIXJEy3_5Q28UR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280135
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] doc: generate CVE catalog documentation
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

Add a Sphinx builder hook to parse runtest/cve and generate a
comprehensive CVE catalog in a single documentation file.

The implementation:
- Parses runtest/cve to extract CVE IDs, test names, and options
- Generates a single CVE catalog file (_static/cve.rst) containing:
  * Total CVE count
  * All CVEs sorted in descending order (newest first)
  * Table of CVEs:
    - CVE ID
    - Test name (Cross-references to test catalog entries)
- Integrates CVE catalog into main documentation index

Closes: https://github.com/linux-test-project/ltp/issues/1254
Cc: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
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
 doc/conf.py               | 91 +++++++++++++++++++++++++++++++++++++++
 doc/index.rst             |  4 ++
 doc/users/cve_catalog.rst |  6 +++
 4 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 doc/users/cve_catalog.rst

diff --git a/doc/Makefile b/doc/Makefile
index 3123b1cd7..e99cbe666 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -30,7 +30,7 @@ spelling:
 	$(RUN_VENV); sphinx-build -b spelling -d build/doctree . build/spelling
 
 clean:
-	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
+	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst _static/cve.rst syscalls.tbl \
 		${abs_top_builddir}/metadata/ltp.json
 
 distclean: clean
diff --git a/doc/conf.py b/doc/conf.py
index 63d09352e..d692638a0 100644
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
@@ -535,6 +544,87 @@ def generate_test_catalog(_):
     with open(output, 'w+', encoding='utf-8') as new_tests:
         new_tests.write('\n'.join(text))
 
+def generate_cve_catalog(_):
+    """
+    Generate CVE catalog in a single file. Parse runtest/cve file and
+    generate documentation with links to CVE databases and test sources.
+    Similar to test_catalog, creates a single _static/cve.rst file with
+    all CVE information.
+    """
+    output = '_static/cve.rst'
+    runtest_cve = '../runtest/cve'
+    metadata_file = '../metadata/ltp.json'
+
+    # Load metadata to check which tests exist in the catalog
+    metadata = None
+    try:
+        with open(metadata_file, 'r', encoding='utf-8') as data:
+            metadata = json.load(data)
+    except FileNotFoundError:
+        logger = sphinx.util.logging.getLogger(__name__)
+        msg = f"Can't find metadata file ({metadata_file})"
+        logger.warning(msg)
+
+    # Parse runtest/cve file
+    cve_data = {}
+
+    try:
+        with open(runtest_cve, 'r', encoding='utf-8') as f:
+            for line in f:
+                line = line.strip()
+                if not line or line.startswith('#'):
+                    continue
+
+                parts = line.split(None, 2)
+                if len(parts) >= 2:
+                    cve_id = parts[0].upper()
+                    test_name = parts[1]
+
+                    cve_data[cve_id] = {
+                        'cve_id': cve_id,
+                        'test_name': test_name,
+                    }
+    except FileNotFoundError:
+        logger = sphinx.util.logging.getLogger(__name__)
+        msg = f"Can't find runtest/cve file ({runtest_cve})"
+        logger.warning(msg)
+        return
+
+    # Generate single CVE catalog file
+    total_cves = len(cve_data)
+    text = [
+        '.. warning::',
+        '    The following CVE catalog has been generated from the',
+        '    runtest/cve file and includes all CVE reproducers in LTP.',
+        '',
+        f'LTP includes reproducers for {total_cves} known CVEs.',
+        '',
+        '.. list-table::',
+        '   :header-rows: 1',
+        '   :widths: 40 60',
+        '',
+        '   * - CVE ID',
+        '     - Test Name',
+    ]
+
+    # Add CVEs in descending order (newest first)
+    for cve_id, cve_info in sorted(cve_data.items(), reverse=True):
+        test_name = cve_info["test_name"]
+
+        # Only create cross-reference if test exists in metadata
+        if metadata and test_name in metadata.get('tests', {}):
+            test_anchor = f"users/test_catalog:{test_name}"
+            test_link = f":ref:`{test_name} <{test_anchor}>`"
+        else:
+            test_link = f"``{test_name}``"
+
+        text.extend([
+            f'   * - {cve_id}',
+            f'     - {test_link}',
+        ])
+
+    with open(output, 'w+', encoding='utf-8') as cve_catalog:
+        cve_catalog.write('\n'.join(text))
 
 def setup(app):
     """
@@ -543,4 +633,5 @@ def setup(app):
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
