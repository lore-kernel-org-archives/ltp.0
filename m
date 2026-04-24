Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A97FE5219
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 12:19:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01A973E5355
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 14:19:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2652F3E1AA2
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 14:18:54 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 29493600682
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 14:18:52 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OBAvVq3292261; Fri, 24 Apr 2026 12:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=3+XjxaFBXHmBStI+WwtRBvHkBQczpo6x11Xox3dWu
 QM=; b=EGbrvxR3kzMZFvh7K26yIZJTNONVesrVOBWTQKjvnHfYh3lujYqqeNtD+
 86THR6cGTEi7IbRb1UShQjRH7Ycjb0uz1MGGQtzblMoXqXXinBFzPFkqYeoyqLaX
 ZYstTspMU74b1gYOKB45n3IIzRirfvSbwgQt9MHeTMUnxCcl0nB5DJmuQOMUnGzG
 F8X3y4MVmCRb0rCk7vYZJAX1sfMpbds6JaAiW9bAv5PT1+/5oLuCT8/6Xg76xVOv
 F3ZwMI8Jy78Ms+/4eb5Gh3dKqe2p7Za20SKQk2w8nH4o0L9OlbVTsQ9xBI0cJ09Z
 cd72rnz3gltDL/fI+j/cUdqA/4VMg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrn3ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 12:18:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OC5QoO013046;
 Fri, 24 Apr 2026 12:18:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky2qa6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 12:18:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63OCIm0129819210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2026 12:18:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39D1F2004B;
 Fri, 24 Apr 2026 12:18:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4187B20043;
 Fri, 24 Apr 2026 12:18:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.65.190])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Apr 2026 12:18:47 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 24 Apr 2026 17:48:44 +0530
Message-Id: <20260424121845.10914-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ipmTv_r38_-V-K2ZhPM0fYyWhtX4fRan
X-Proofpoint-ORIG-GUID: ipmTv_r38_-V-K2ZhPM0fYyWhtX4fRan
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExOCBTYWx0ZWRfX/6UmtWbArkry
 8BFSCCdWufOrdyo2488h922D9GszscH/6JdCCKaBNo73MR9VwD6cdJqjzJ35lY264iyNK9zGPZe
 NozKw9fVNRB0XhS7s3xUmz3ojimAsibWVUGvlhCcOyfoGYjmGpyWVCVpjaBF3+0eFVLzcNMeBH/
 5dk36LES9cNTZPtuIVSe7X42TQMfHzoQjlqo2rZDpn1uLDP5fVFOeQ5qa543prshrDlY0powZg3
 IMszzO+xfo7nXafhi6n2CV/tH7AC6Zq1FWpPXBH1umXbz2I/T/59+bAr2Lwsz8ZQRwXAYnpQCoK
 iajUwg/Da/BPg1Rs6gfT4cgprGf8U7UAHUodvm9EqcHVrFzLvFGPiLUyFnioNZsrZa8hZEZ6Rrl
 n5WHGQFt6uKYpVUK7PaO02LKJB5TNvHZ/QUebIEA9r/CV25WeHsyg777+YDtLE5IL/+QLWk4Mog
 2BvKyaQ1JN656FUTEvQ==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69eb5faa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sMBj6sIwAAAA:8 a=iox4zFpeAAAA:8 a=vWoT6DuTJhGiA10ru-4A:9
 a=r1Yu_BK-E59k74aI3Q9G:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240118
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] doc: generate CVE catalog documentation
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
- Generates a single CVE catalog file (_static/cves.rst) containing:
  * Total CVE count
  * All CVEs sorted in descending order (newest first)
  * For each CVE:
    - Links to CVE MITRE database
    - Cross-references to test catalog entries
    - Test command details and options
    - Vulnerability description
- Integrates CVE catalog into main documentation index

Closes: https://github.com/linux-test-project/ltp/issues/1254
Cc: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
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
 doc/Makefile              |   2 +-
 doc/conf.py               | 127 ++++++++++++++++++++++++++++++++++++++
 doc/index.rst             |   4 ++
 doc/users/cve_catalog.rst |   6 ++
 4 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 doc/users/cve_catalog.rst

diff --git a/doc/Makefile b/doc/Makefile
index 3123b1cd7..baa228022 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -30,7 +30,7 @@ spelling:
 	$(RUN_VENV); sphinx-build -b spelling -d build/doctree . build/spelling
 
 clean:
-	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
+	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst _static/cves.rst syscalls.tbl \
 		${abs_top_builddir}/metadata/ltp.json
 
 distclean: clean
diff --git a/doc/conf.py b/doc/conf.py
index 63d09352e..6d470d0d0 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -30,6 +30,16 @@ extensions = [
     'sphinx.ext.extlinks',
 ]
 
+# Configure autosectionlabel to prefix labels with document name
+# This prevents duplicate labels when same test name appears in multiple files
+# Required for CVE catalog cross-references to work
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
@@ -535,6 +545,122 @@ def generate_test_catalog(_):
     with open(output, 'w+', encoding='utf-8') as new_tests:
         new_tests.write('\n'.join(text))
 
+def generate_cve_catalog(_):
+    """
+    Generate CVE catalog in a single file. Parse runtest/cve file and
+    generate documentation with links to CVE databases and test sources.
+    Similar to test_catalog, creates a single _static/cves.rst file with
+    all CVE information.
+    """
+    output = '_static/cves.rst'
+    runtest_cve = '../runtest/cve'
+
+    # Parse runtest/cve file
+    cve_data = {}
+    cve_pattern = re.compile(r'^(cve-(\d{4})-\d+)\s+(\S+)(?:\s+(.*))?$')
+
+    try:
+        with open(runtest_cve, 'r', encoding='utf-8') as f:
+            for line in f:
+                line = line.strip()
+                if not line or line.startswith('#'):
+                    continue
+
+                match = cve_pattern.match(line)
+                if match:
+                    cve_id = match.group(1).upper()
+                    year = match.group(2)
+                    test_name = match.group(3)
+                    options = match.group(4) if match.group(4) else ''
+
+                    cve_data[cve_id] = {
+                        'cve_id': cve_id,
+                        'year': year,
+                        'test_name': test_name,
+                        'options': options,
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
+        f'LTP includes reproducers for {total_cves} known CVEs. These '
+        'tests help verify',
+        'that systems are patched against known vulnerabilities.',
+        '',
+    ]
+
+    # Load metadata to check which tests have documentation
+    metadata = None
+    metadata_file = '../metadata/ltp.json'
+    try:
+        with open(metadata_file, 'r', encoding='utf-8') as data:
+            metadata = json.load(data)
+    except FileNotFoundError:
+        pass
+
+    # Add CVEs in descending order (newest first)
+    for cve_id, cve_info in sorted(cve_data.items(), reverse=True):
+        cve_url = f"https://cve.mitre.org/cgi-bin/cvename.cgi?name={cve_id}"
+        test_name = cve_info["test_name"]
+
+        # Only create cross-reference if test exists in metadata
+        if metadata and test_name in metadata.get('tests', {}):
+            # Create anchor using the correct document path prefix
+            test_anchor = f"users/test_catalog:{test_name}"
+            test_link = f":ref:`{test_name} <{test_anchor}>`"
+        else:
+            # If test not in metadata, just use plain text formatting
+            test_link = f"``{test_name}``"
+
+        # Create section header with CVE ID and test name
+        section_title = f'{cve_id} ({test_name})'
+        text.extend([
+            section_title,
+            len(section_title) * '-',
+            '',
+            f'**CVE Reference:** `{cve_id} <{cve_url}>`_',
+            '',
+            f'**Test Name:** {test_link}',
+            '',
+        ])
+
+        if cve_info['options']:
+            text.extend([
+                f'**Test Options:** ``{cve_info["options"]}``',
+                '',
+            ])
+
+        # Build test command on a single line to avoid RST formatting issues
+        test_cmd = f'``{test_name}'
+        if cve_info['options']:
+            test_cmd += f' {cve_info["options"]}'
+        test_cmd += '``'
+
+        text.extend([
+            f'This test reproduces the vulnerability described in {cve_id}.',
+            'The test verifies that the system is properly patched against',
+            'this known security vulnerability.',
+            '',
+            f'* **CVE Year:** {cve_info["year"]}',
+            f'* **Test Command:** {test_cmd}',
+            '',
+            '.. raw:: html',
+            '',
+            '    <hr>',
+            '',
+        ])
+
+    with open(output, 'w+', encoding='utf-8') as cve_catalog:
+        cve_catalog.write('\n'.join(text))
 
 def setup(app):
     """
@@ -543,4 +669,5 @@ def setup(app):
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
index 000000000..f109f01d0
--- /dev/null
+++ b/doc/users/cve_catalog.rst
@@ -0,0 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+CVE Catalog
+===========
+
+.. include:: ../_static/cves.rst
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
