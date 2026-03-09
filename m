Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEE4EF3717
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 17:22:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 474D03DE5F2
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 18:22:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D47CA3DEAE5
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 18:21:45 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 147E4600859
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 18:21:44 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629EC9T41342364; Mon, 9 Mar 2026 17:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6qUYEDCzXO2x79sJO
 UKsyjlRmepmqS4bg+Rjzb2XlPU=; b=FVkyDM7dZ431iSXD5Z/TRVHvHutek+9ER
 ClgQ6zGmvPUvnCqS7343ofnxsmmyR9nthVMhaOT0605ga7FbRfm2x4cGqB+KYidn
 g+gM0LGab2WIVca/zHCbOgQx9ddmDR7hZVmYDUuPGfrNVlvLYq3WutKn9xDaJoj4
 nLEHJS0XAUIlX7tpblvZ4pjy1oFcSxxZWqfGWwAHpZ5ZIDeTxxpS3w/xF/qZt7vo
 UZhcwfqrrY3QY6FG02/yYVu5ZZ+Fb86sl+zG3MVl8scafNa2r1h3Qyn7ymPUpsHf
 /K9C+6vfjUHpQm4THx8GpkrX2hBTKPsVlm6+r1dAXEM5FdQkj+MKw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvm7pwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 17:21:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629Dd6iV029850;
 Mon, 9 Mar 2026 17:21:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6ujh6n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 17:21:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 629HLdRi43450802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 17:21:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3742920043;
 Mon,  9 Mar 2026 17:21:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D34F420040;
 Mon,  9 Mar 2026 17:21:38 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.87.155.142]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 17:21:38 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Mon,  9 Mar 2026 18:20:57 +0100
Message-ID: <20260309172057.272946-4-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309172057.272946-1-japo@linux.ibm.com>
References: <20260309172057.272946-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BygiNug3vsEhEMxpUTCOKNK56m2ODCCk
X-Proofpoint-ORIG-GUID: BygiNug3vsEhEMxpUTCOKNK56m2ODCCk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE1MyBTYWx0ZWRfX8oZQIAb4LILG
 MtTHht1sYHsvEAYaB5wLAFwVm3fTfdcEj3VwNYp0/Or9T4GnU3MsT55tT6Dj/ZkNs0iFfz/uLUD
 Z4BfSiPCCUkrpgFCAUhu0yivn4nRvEKHPNZiePsfDwwL6qk2mqzCkekkD+RoJ9xfnAAzFAfwzzc
 2HpdbRg2tMpBthnbRKfSiNMb9/13xR+kDuUzTWlr3Gr2EJTgHZ18CA0DrJU1dIE+bOsjPPxT4Zu
 AYoUFs599BiJWXbw1wSFOS6QMEefRWJn99YSKIGykGHrduR8OQ9W01S5Z4vIyU5m5lCHrQIX/WK
 cOK1I/TZt72n8rms7J6zmbZ2v3sW5YKDL2PFljtj1Yy3CQcIA0qgPJNEA82of/8eO0gDR3y2/ps
 i9/7OOhYeZ+QJYP9dnDGi0zxMOmH7kg7kegj5LBzhZ5Zl3yZ99f8V2olbNzeLotw3dgzMFTq3FL
 wZmi219KJiWdheOrLTA==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69af01a6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=znzk5KmSAAAA:8 a=VnNF1IyMAAAA:8
 a=g7BrdTIJrStfstmviRwA:9 a=lVJ2Zv5zgJvBeU6Kyhb9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090153
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/3] editorconfig: add consistent formatting rules
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
 .editorconfig | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 000000000000..ee9f49516e53
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# EditorConfig configuration for LTP
+# https://editorconfig.org/
+
+root = true
+
+[*]
+charset = utf-8
+end_of_line = lf
+insert_final_newline = true
+trim_trailing_whitespace = true
+
+# C/Assembly source files, headers, and Makefiles use tabs
+[*.{c,h,mk,S,sh,awk}]
+indent_style = tab
+indent_size = 8
+
+[{Makefile,Makefile.*}]
+indent_style = tab
+indent_size = 8
+
+# Python and Perl scripts use spaces
+[*.{py,pl}]
+indent_style = space
+indent_size = 4
+
+# Documentation files
+[*.{rst,md}]
+indent_style = space
+indent_size = 3
+
+# JSON files
+[*.json]
+indent_style = space
+indent_size = 4
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
