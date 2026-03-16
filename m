Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A45DF506CA
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 13:03:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7A943E5680
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 14:03:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FD3C3E1CCE
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 14:03:30 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D7A37200908
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 14:03:29 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62G93Vwe3176840; Mon, 16 Mar 2026 13:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=QYBKWU0eM1Ee2X8bi/DHIxSyGivohG0F/LcAPX0BW
 nY=; b=RZE0ADYJ9JsprsE2HfddYSwS2YdLjGpU9kQLTilo9d5XjHSEajQ2M5rjH
 6ER313KVFYp9kNSZgDzZwpf00pS4zGtT3TSuvU23rvxkEALPAq9W5zflFVLefBuo
 KBpGcMIJmsEKIC533+5YiZgDj4k1yPsW8xVo6NKobdOZjcShomVZi3siOfxT1V8F
 +kEIhY2rP4iI39OAxYsMyZQbRHbe+JNPSeS4Su/bPo8R4kmxkdXj/TY/sG+rcdIN
 8WvzC8Zj9LjmswUWpd1VDqGPusroH/dzfTbFSG3RtoZd7f44K10hsSrijywuKYfX
 wzMmP4AMFT88vE/HU4+A3/104TohA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cqmyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 13:03:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GBIJ9a028459;
 Mon, 16 Mar 2026 13:03:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq14nf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 13:03:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62GD3P7f53608924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2026 13:03:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52C9420043;
 Mon, 16 Mar 2026 13:03:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B39120040;
 Mon, 16 Mar 2026 13:03:25 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.83.233]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Mar 2026 13:03:24 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Mon, 16 Mar 2026 14:03:20 +0100
Message-ID: <20260316130320.138328-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b7ff9f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=g7BrdTIJrStfstmviRwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NyBTYWx0ZWRfX3VQFd5gFyNmi
 jDGZRmuo4goWJE2AkcHA1R+GrN0Yg3hbLa4b/U309JYHpu1ldg7Vt9PIIgJkIPU9r9ib3OQjgiB
 5CAC6/H0cH6WDZhyqO9om9SAYgn3JPB2VRaWDKlBtOJss3UhPXD98W+Bp9WnMKrsQroaY9GYa0k
 vvXgyevXpCOOeyMlNTOZVoQjqwvNZv5gBn/ZFWFRUYaVmEihLsuj3LX1D3bImn5WcR8qx7dveGm
 hYlZTqMWn3NnISOxcrZzhvsB0g9UKtOrWlOG2NdUqGU0pXt6DambP/J66kCPD988eTxenljLdM6
 1Aqx0glIkC5pcKUUsFVTF7nDuTiWa0g+12MWWhAdnfaKFwHJC57CPGFrrvtrx+rW+rGWODh+5jw
 w8edfT8FUypvCrFNQtCLW5pK92Zj4JYIxxtJvNPO/1BYTn7qhq6Xwsw2xaowVD+mrm0aWrKM+qs
 Xyw0nZSN+8x626/MapQ==
X-Proofpoint-GUID: LYu54bOr40fpZ84q-h5SUjCEuxnmr5lU
X-Proofpoint-ORIG-GUID: LYu54bOr40fpZ84q-h5SUjCEuxnmr5lU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160097
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] editorconfig: add consistent formatting rules
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

Changes since v1 (thanks Petr):
- License identifier: GPL-2.0 -> GPL-2.0-or-later
- Drop awk
- Treat Python/Perl special files
- indent_size=4 for *.{c,h,S,sh} and ver_linux
- Fix indent_size for .rst/.md to 4

 .editorconfig | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 000000000000..ee67666d49c4
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,39 @@
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
+
+# C/Assembly source files, headers, and shell files use tabs
+[{*.{c,h,S,sh},ver_linux}]
+indent_style = tab
+indent_size = 4
+
+[{Makefile,Makefile.*,*.{mk.in,mk}}]
+indent_style = tab
+indent_size = 8
+
+# Python and Perl: default to tabs (most test files use tabs, checkpatch.pl which we modify)
+[*.{py,pl}]
+indent_style = tab
+indent_size = 8
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
