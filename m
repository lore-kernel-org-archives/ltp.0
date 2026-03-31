Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906A510F92F2
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 20:00:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BFF53E5B8F
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 22:00:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BCA03CEDD3
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 22:00:34 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2516D10005DB
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 22:00:33 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VGvgu8033664; Tue, 31 Mar 2026 20:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=yLXsSPWQH9uTtrTPJaFMwAVIs/NlXjHfLbKZnotHv
 KE=; b=BdU/tVlspEHFdY7zw8Nt7Rfa28Zi6AbeJWxKoAJsHhxmX5zCtjp2RdoNz
 wGyDYY88ceasNXbowh5dZe2/OeNOI9mZiibsfW/ewZXxGtS2thLTlpR9+xzr3fgR
 5FA8m5gaZnpy5w7a4uyuULX5Bqz+DtBDRkFjrBc6kIwve3svEyMfO40kuuyFDuWl
 I6vAc59fUdHN3GwqlgTk4diwA8NW89VXjddNLm9iTFfUx58zgXnzdGKkHwsD2W9f
 x+mJL1xCN1m0wEa66366HefSL/rFtYkrwklxqq7VKm+rKuFNymJk1YN9HoILHqcw
 1swzS9gKNBX+P2iuP7jRrqk2LEgGg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgmtn5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 20:00:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VJDtu7021696;
 Tue, 31 Mar 2026 20:00:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasjw62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 20:00:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62VK0TsS53477862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2026 20:00:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB9DB20040;
 Tue, 31 Mar 2026 20:00:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A55020043;
 Tue, 31 Mar 2026 20:00:29 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.25.34]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 31 Mar 2026 20:00:29 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Tue, 31 Mar 2026 22:00:26 +0200
Message-ID: <20260331200026.244979-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE5MSBTYWx0ZWRfX/M22OeQ6i3Vj
 UrM1xIbOWfFzFIG6h6zveHXJBAz5fTiB3V4i4GP7gkN45Ml2zTVmWW+OAJ74SFFHCCPHuvjsgXp
 t2RIXRe8Is5tc1pPKLud0gzSCX4wkP7lQU9gvTIsxh3A3TpaD8MJwzE//lsZNf6KKU36MpCw0UH
 tyqMPNhq6pFaFATAMvFExk6rcxK7uU9Vn9yrgpzo3CtFqKmjtoPKu2hd8GEblW9j3OFy0J5NXs3
 Cy+NzBv2zfaA71cLoTV6ZfE7RzE2VZODvhReE0My/oFM/ML7GdTWdMWVJTCRLQZJ/cUpTomHIUF
 q6uc9tajZ1TM/u0es3cw8fKDyutlNaRF9Q76N031ycCDf0R/5RMyBgxBp+6gHy1MjbYppP8sK4e
 qmj6ey9G2Qv8ToA46+GlFLHBsJNSElPy0xb0mRWb+64/fUYamqfDhnZOqp0RO26jlTWErudmiXN
 neEPc0Av3eHcy0SNhvA==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cc27e0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=PrBdSwF5dtqSrjgAXA4A:9
X-Proofpoint-GUID: bwp9fpi85ox6BwRIw1Iqdb_Tkhj7QHxf
X-Proofpoint-ORIG-GUID: bwp9fpi85ox6BwRIw1Iqdb_Tkhj7QHxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310191
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/1] editorconfig: add consistent formatting rules
 for LTP
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Introduce .editorconfig to keep indentation and whitespace consistent across
editors, preventing accidental reformatting and noisy diffs.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---

Changes since v2:
- Use kernel-style tabs for C/ASM/shell. (Thanks Andrea, Petr)
- Split Python/Perl indentation: *.py uses 4 spaces; *.pl keeps tabs.
  (Thanks Andrea)

Changes since v1 (thanks Petr):
- License identifier: GPL-2.0 -> GPL-2.0-or-later
- Drop awk
- Treat Python/Perl special files
- indent_size=4 for *.{c,h,S,sh} and ver_linux
- Fix indent_size for .rst/.md to 4

 .editorconfig | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 000000000000..b09145a3332f
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+root = true
+
+# Default for all files
+[*]
+charset = utf-8
+end_of_line = lf
+insert_final_newline = true
+trim_trailing_whitespace = true
+tab_width = 8
+
+# C/Assembly source files, headers, and shell files use tabs
+[{*.{c,h,S,sh},ver_linux}]
+indent_style = tab
+indent_size = tab
+
+[{Makefile,Makefile.*,*.{mk.in,mk}}]
+indent_style = tab
+indent_size = tab
+
+[*.py]
+indent_style = space
+indent_size  = 4
+
+[*.pl]
+indent_style = tab
+indent_size = tab
+
+# Exceptions use spaces: Python (Sphinx, scripts), Perl (checkbashisms.pl vendored)
+[{doc/conf.py,scripts/*.py,scripts/checkbashisms.pl}]
+indent_style = space
+indent_size = 4
+
+# Documentation files
+[*.{rst,md}]
+indent_style = space
+indent_size = 4
+
+# JSON files
+[*.json]
+indent_style = space
+indent_size = 4
--
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
