Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28BAF99362
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 10:53:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 527363E2638
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 12:53:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B87573E1BFB
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:53:12 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D30331A00606
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:53:11 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N7ZLN53944060
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=3M2iZi+B+QpNOh/tACKvPtPZHwTXCB8BmqsSRbS6L
 L0=; b=sxpixwq29zUUQ7nR2UYUvl28ExeOuavRwsqbiRYhlZdqKiBMzgeV4uMnL
 zm9wT2mQpPZ94AsEzMj5OoIrvdlehdIGH0NvRRbYBfzmMdRrHLq4Pkto3rXhYrpk
 cT/AESKVxuVRudKZlSRAHAdDyk+QPjbOX8ENXWQjUTLLa6sCvBZirA0WspkChkAF
 wdg3H8YBPWd/xAx8ejv05S2I3kF7wxurMthFWkfdbb9fUVSAHCa8ADGqlfXwB/Gf
 mBrlDDqLtXXcDtNnMMnnJ91sfD1lfe7/Hphn2C3c9P8gdl5mrEbX4ZZdiq6Ruee+
 8T6p7kE+RbV+TTpXcNepunQFK5Wrw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3qnf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:53:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NAZOCj023301
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:53:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxx8xg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:53:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NAr6oS53608804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:53:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE65A20040
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:53:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B5DE20043
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:53:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.121.104])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:53:06 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 16:23:04 +0530
Message-Id: <20260423105304.59788-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DDRL1-yT__oAXYRROBhU3vXWBMERPKTe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNyBTYWx0ZWRfXw05oFIT8S39r
 11f4+UpW8XnDWN/uykg4dvFO4Q27GCm3344CccBMWHOLpMEeKi8HNmF8W5iAAQLMjdcbaHZLeVO
 rmEVaiTaWfT2ewZm9YnVXQIw9mi4wvwKJ0iJh4F213BmLyiWQFfwETKKVn9Jc1B61iPCFnraSAN
 6hkW2ycl4a9t9KZMx+t4J7n7hRG3snXAA1shHzldc9JJ7oa58p5clo/hLWBiCUGtoQaY7SdV0fm
 9JbyhA8sQONBbtW1y7WtQ7QOAtxJrxw2uSpGUFqMZ79GJukuZ03l0TkC+vK29ICNULLY+KamS25
 MsZtUReG1KI85FbD2TmU5XFCJ1KJx+0xlPMCQ3jUIbfN4KO283VHwtTGUItXZ7UuuSUcd4J8Wys
 UhNJWrzVhTohCRNQkW0yfMbLN2YJSg5xn6yPZPQy92pRCiWl4qjW3SZcER57gb3BTUr7Adrvt9C
 NwOxjpDXyY/8QrmGZEA==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69e9fa15 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8 a=sMBj6sIwAAAA:8 a=VnNF1IyMAAAA:8
 a=y665gLzbWme0uMTbBJUA:9 a=r1Yu_BK-E59k74aI3Q9G:22
X-Proofpoint-ORIG-GUID: DDRL1-yT__oAXYRROBhU3vXWBMERPKTe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230107
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc: generate CVE reproducer statistics
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

Add a Sphinx builder hook to parse runtest/cve, collect CVE
reproducer metadata, and generate a documentation page with
per-year counts and links to CVE entries and test sources.

Also include the generated CVE reproducer statistics page from
doc/users/stats.rst.

Fixes: https://github.com/linux-test-project/ltp/issues/1254
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 doc/conf.py         | 169 ++++++++++++++++++++++++++++++++++++++++++++
 doc/users/stats.rst |   2 +
 2 files changed, 171 insertions(+)

diff --git a/doc/conf.py b/doc/conf.py
index 63d09352e..19e744d79 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -535,6 +535,174 @@ def generate_test_catalog(_):
     with open(output, 'w+', encoding='utf-8') as new_tests:
         new_tests.write('\n'.join(text))
 
+def generate_cve_stats(_):
+    """
+    Generate statistics for CVE reproducers. Parse runtest/cve file,
+    scan testcases directories, and generate documentation with links
+    to CVE databases and test sources.
+    """
+    output = '_static/cve_reproducers.rst'
+    runtest_cve = '../runtest/cve'
+
+    text = [
+        'CVE Reproducers\n',
+        '---------------\n\n',
+        'LTP includes reproducers for known CVEs. These tests help verify\n',
+        'that systems are patched against known vulnerabilities.\n\n',
+    ]
+
+    # Parse runtest/cve file
+    cve_data = {}
+    cve_pattern = re.compile(r'^(cve-(\d{4})-\d+)\s+(\S+)(?:\s+(.*))?$')
+
+    try:
+        with open(runtest_cve, 'r', encoding='utf-8') as f:
+            for line in f:
+                line = line.strip()
+                # Skip comments and empty lines
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
+                        'source_path': None,
+                        'description': ''
+                    }
+    except FileNotFoundError:
+        logger = sphinx.util.logging.getLogger(__name__)
+        msg = f"Can't find runtest/cve file ({runtest_cve})"
+        logger.warning(msg)
+
+        with open(output, 'w+', encoding='utf-8') as stats:
+            stats.write(f".. warning::\n\n    {msg}")
+        return
+
+    # Scan for CVE test source files
+    testcases_dirs = [
+        '../testcases/cve',
+        '../testcases/kernel/syscalls',
+        '../testcases/kernel/mem',
+        '../testcases/kernel/pty',
+    ]
+
+    # Build a mapping of all potential source files
+    # Key: base filename without extension, Value: full path
+    source_files = {}
+    for base_dir in testcases_dirs:
+        if not os.path.exists(base_dir):
+            continue
+
+        for dirpath, _, files in os.walk(base_dir):
+            for filename in files:
+                if filename.endswith('.c') or filename.endswith('.sh'):
+                    # Store base name without extension
+                    base_name = filename.rsplit('.', 1)[0]
+                    rel_path = os.path.join(
+                        dirpath.replace('../', ''),
+                        filename
+                    )
+                    source_files[base_name] = rel_path
+
+    # Match CVE entries with source files
+    for cve_id, cve_info in cve_data.items():
+        test_name = cve_info['test_name']
+        source_path = None
+
+        if test_name in source_files:
+            source_path = source_files[test_name]
+        elif cve_id.lower() in source_files:
+            source_path = source_files[cve_id.lower()]
+
+        if source_path:
+            cve_info['source_path'] = source_path
+
+            try:
+                src_file = os.path.join('..', source_path)
+                with open(src_file, 'r', encoding='utf-8') as src:
+                    in_comment = False
+                    desc_lines = []
+                    for line in src:
+                        line = line.strip()
+                        if line.startswith('/*\\'):
+                            in_comment = True
+                            continue
+                        if in_comment:
+                            if line.endswith('*/'):
+                                break
+                            if line.startswith('*'):
+                                desc_line = line[1:].strip()
+                                if desc_line:
+                                    desc_lines.append(desc_line)
+
+                    if desc_lines:
+                        # Use first non-empty line as description
+                        cve_info['description'] = desc_lines[0]
+            except (IOError, UnicodeDecodeError):
+                pass
+
+    # Generate statistics
+    total_cves = len(cve_data)
+    cves_by_year = {}
+    for cve_info in cve_data.values():
+        year = cve_info['year']
+        cves_by_year[year] = cves_by_year.get(year, 0) + 1
+
+    text.append(f'* **Total CVEs tested:** {total_cves}\n')
+    text.append('* **CVEs by year:**\n\n')
+
+    for year in sorted(cves_by_year.keys()):
+        text.append(f'  * {year}: {cves_by_year[year]} CVEs\n')
+
+    text.append('\n')
+
+    # Generate CVE table
+    text.extend([
+        'CVE List\n',
+        '~~~~~~~~\n\n',
+        '.. list-table::\n',
+        '   :header-rows: 1\n',
+        '   :widths: 20 25 10 45\n\n',
+        '   * - CVE ID\n',
+        '     - Test Name\n',
+        '     - Year\n',
+        '     - Description\n',
+    ])
+
+    # Sort CVEs by ID (chronologically)
+    for cve_id in sorted(cve_data.keys()):
+        cve_info = cve_data[cve_id]
+
+        cve_url = f"https://cve.mitre.org/cgi-bin/cvename.cgi?name={cve_id}"
+        cve_link = f"`{cve_id} <{cve_url}>`_"
+
+        if cve_info['source_path']:
+            test_url = f"{ltp_repo_base_url}/{cve_info['source_path']}"
+            test_link = f"`{cve_info['test_name']} <{test_url}>`__"
+        else:
+            test_link = cve_info['test_name']
+
+        description = cve_info['description'] if cve_info['description'] else 'CVE reproducer test'
+
+        text.extend([
+            f"   * - {cve_link}\n",
+            f"     - {test_link}\n",
+            f"     - {cve_info['year']}\n",
+            f"     - {description}\n",
+        ])
+
+    with open(output, 'w+', encoding='utf-8') as stats:
+        stats.writelines(text)
+
 
 def setup(app):
     """
@@ -543,4 +711,5 @@ def setup(app):
     """
     app.add_css_file('custom.css')
     app.connect('builder-inited', generate_syscalls_stats)
+    app.connect('builder-inited', generate_cve_stats)
     app.connect('builder-inited', generate_test_catalog)
diff --git a/doc/users/stats.rst b/doc/users/stats.rst
index 7073442aa..9ecf806bb 100644
--- a/doc/users/stats.rst
+++ b/doc/users/stats.rst
@@ -7,3 +7,5 @@ In this section we collect some statistics related to the current state of
 LTP tests.
 
 .. include:: ../_static/syscalls.rst
+
+.. include:: ../_static/cve_reproducers.rst
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
