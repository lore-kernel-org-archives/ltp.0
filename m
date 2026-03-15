Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C54DD58B23
	for <ltp@archiver.kernel.org>; Sun, 15 Mar 2026 13:02:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3044C3E2758
	for <ltp@archiver.kernel.org>; Sun, 15 Mar 2026 14:02:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0287B3C9AE8
 for <ltp@lists.linux.it>; Sun, 15 Mar 2026 14:02:05 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 183031000911
 for <ltp@lists.linux.it>; Sun, 15 Mar 2026 14:02:04 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62FCmAur4022659
 for <ltp@lists.linux.it>; Sun, 15 Mar 2026 13:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=KqxaWrL0RA0Z0uE8uhrS9UWCvwvyEdUqglXWxaLcQ
 1k=; b=LMI11eW7b+NbHZ+9IZ08tESn5exiFX9r9kD1QIjiBQMXLG2cEzFWEbC1l
 atkqyA35/WfAni27/vvtUlFsXln1Ryv8y15opgaCa+ixaUFbYntPTOgtC+psfLud
 fph1noz0gBCIog+v8iSexo++9wgTexyMO+6cYxThICAqHpV2//ifS6LIvrAxwx3/
 iKy9B7rxNU+sLlhHlOAUcKMwMVQhIEJURxixl62KRmkWrwYDpBS87CtR8MykaO6S
 x/uVKoiSlIj7Nq4H2eeh81V2J26wVJ3enS8LCL1SUIRwp754J0G02iEm6nOO+m11
 a8CyIQsffMLpWG3IUmxg51dy7GlxA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybrv53w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 15 Mar 2026 13:02:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62FADVHe032346
 for <ltp@lists.linux.it>; Sun, 15 Mar 2026 13:02:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jh79x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 15 Mar 2026 13:02:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62FD1vuB30474868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 Mar 2026 13:01:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B22362004D;
 Sun, 15 Mar 2026 13:01:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 145C320043;
 Sun, 15 Mar 2026 13:01:57 +0000 (GMT)
Received: from ltcden9-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 15 Mar 2026 13:01:56 +0000 (GMT)
From: Samir <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 15 Mar 2026 13:59:33 +0100
Message-ID: <20260315125934.1291918-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b6adca cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=CCrPxpZSWmOaAvghbwYA:9
X-Proofpoint-ORIG-GUID: N4-X81LaZdVPrlK7VzAsga20nxXioFow
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDEwMCBTYWx0ZWRfX2RRcZL8LbyOm
 MKBmSj6Xvw47lSid+NPzFbcioxQwM1Ig/alHUc0eztAJb+bolQCFwHu444pyKlCfsVuUofpojSO
 LxkKhWB49mAC3sWjVsymvCHOEYv9fCamIFXEsvRt7H0wtHnF5p0g21Qzr6sgjhnJAGIvps8bDbK
 TS/lfPQRJGiDVhCkAp/GgGSTrdtLhFWQ7Rn/OOcXftsQJ7QphXLMUtD5FIP5IPVZsUdYHDj/Z0q
 0CjshWBv90f1elgTwKBw5ZppMzl4YKMSGMuKB6JZLqVqorSZ9Zx3gAQvQGqLmIKCDzQt4YBB+QC
 68q1UVSsCF7c8wzifUINtCyIv12s43eHvHRoQTY85O6eJmiMA5A90PO03sjlsAAa4xiH+Jv+y2T
 R83bovF9XgAtUI+W7QabLET5MElBpPzzUrE8c4fwEoqhPDkWOl/w8t7urtWOAlq1/RzG55CKJNM
 oIrjauffMdRF9eKk+5Q==
X-Proofpoint-GUID: N4-X81LaZdVPrlK7VzAsga20nxXioFow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603150100
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] controllers/cgroup: Skip regression test on cgroup v2
 systems
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
Cc: Samir <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The cgroup_regression_test.sh test2 attempts to mount a cgroup
filesystem and expects a cgroup v1 hierarchy. On systems using
cgroup v2 (unified hierarchy), the test fails with:

TFAIL: Failed to mount cgroup filesystem

because the legacy cgroup v1 mount layout is not available.

Add a check for the presence of /sys/fs/cgroup/cgroup.controllers,
which indicates a cgroup v2 system. If detected, mark the test
as TCONF since the test is only applicable to cgroup v1.

This prevents false failures when running the controllers suite
on systems where cgroup v2 is enabled by default.

Signed-off-by: Samir <samir@linux.ibm.com>
---
 .../kernel/controllers/cgroup/cgroup_regression_test.sh    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 276231fe8..f6deb0d43 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -118,6 +118,13 @@ test2()
 	local val1
 	local val2
 
+	# This test is specific to cgroup v1
+	# Check if system is using cgroup v2
+	if [ -f /sys/fs/cgroup/cgroup.controllers ]; then
+		tst_res TCONF "This test requires cgroup v1, but system is using cgroup v2"
+		return
+	fi
+
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	if [ $? -ne 0 ]; then
 		tst_res TFAIL "Failed to mount cgroup filesystem"
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
