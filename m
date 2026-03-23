Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C59AEC01CC
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 11:08:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C8DC3E2299
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 12:08:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1BB53C2756
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 12:08:03 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1231C1A00A3F
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 12:08:02 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MJOLWG196681; Mon, 23 Mar 2026 11:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=bv/IMQ8bf6yewO4zXsualszydaMISMjJQBrVgXHEW
 KM=; b=hNMmEUxvRFtxZ1Z6RTKuk7r9CtC4tkeh5NPHN9LVTtcEmOSW15ns220pG
 TEJ3FInC4lsxf6It3KiLFECPgUpy+YQTXYgsT1IVnvNDJoBU/6S60Gl/Tax1XqM7
 ITJGF0TqmCqXLdEY69wEE6Mn8LvJ5rqt/kb+Rca1nn9yp3JWCHxTOcyT9zAIJv31
 X1NWkoV1hVip5M8VYm97C+E1zsP9Gnhym2hJwYv2l0aqEB3yewwIARj+HHxSPX9K
 nxUTFvMrtHNEPXRldw+8NxXq9uOZkr+38t8brspjhvnaEpq1ZB2QRqSdRCCMX2dt
 p1OMUuQf7umQx1ylj59S59AvOrOHg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kume888-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 11:08:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N8FUZ8012203;
 Mon, 23 Mar 2026 11:07:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vjvvqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 11:07:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62NB7tww46334300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 11:07:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 519EB20043;
 Mon, 23 Mar 2026 11:07:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 725892004D;
 Mon, 23 Mar 2026 11:07:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.186])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 11:07:54 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 23 Mar 2026 16:37:35 +0530
Message-ID: <20260323110735.55473-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RBVeKNT0o8gQBiemjubE7L_9HxpCezSL
X-Proofpoint-ORIG-GUID: RBVeKNT0o8gQBiemjubE7L_9HxpCezSL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MyBTYWx0ZWRfX1KHzXtuJaQDY
 6JAthPxfj7sc9LeP+IWqzHxn2bj4Uy9nLetSyPWYk2f2ckjAbS0D3FcmeVOPOXYqtiLJ4m7K7Tz
 /LLJdCy9oXFJocPCd3v3jvjQLZVbtxgKmI+j4QuThN52LMPlifhMuSdAJ4yKf1ePgLEIJV36LCR
 qm5Hc8A8509xcsJFttBouQEEBPjcK+PYaApq++ifnrMXdtJ412OHDZzSHm663cD4LHtAUbSD8cH
 Q3oMmunk1CM4W3MdyBXodHhdW883M7CeS8sq+St6Bpbo4eWomzpW45YUlC+Vab4Y+Cckf2qSVru
 8Mr6UQ77zO7imHk4kbl94qIO58jgDbzcQJ1uzrEd70M0INLihCZvKY9NMZ1PM8UsSLWNAwuer3S
 SICtQlYSTNzTBkuVNzFKXLznw5koQhzaTBWJh44rRGElXASZjUc9iQcsQyMVuKT3DQnKiXaxRB9
 PiCuvmNtNynxFzqGGPA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c11f10 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=maIFttP_AAAA:8
 a=OmYUYOihiO5dP9xC5AEA:9 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230083
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/ustat: Skip tests on Btrfs using
 .skip_filesystems
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
Cc: disgoel@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The ustat(2) system call is known to fail with EINVAL on Btrfs because
it uses anonymous device IDs for subvolumes, which this legacy syscall
cannot resolve to a physical block device.

Currently, this results in a TFAIL, which causes false negatives in
automated CI environments (e.g., SLES). This patch utilizes the LTP
library's .skip_filesystems mechanism to gracefully skip the tests
(TCONF) when executed on Btrfs.

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
Changelog v1 -> v2:
- Removed manual statfs/tst_brk logic in setup().
- Implemented .skip_filesystems in the tst_test structure for both
  ustat01 and ustat02.

Link to v1:
https://lore.kernel.org/all/20260318082438.50245-1-disgoel@linux.ibm.com/
---
 testcases/kernel/syscalls/ustat/ustat01.c | 4 ++++
 testcases/kernel/syscalls/ustat/ustat02.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
index 161006058..55095191b 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -44,6 +44,10 @@ static void setup(void)
 static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
+	.skip_filesystems = (const char *const[]) {
+                "btrfs",
+                NULL
+        },
 	.tags = (const struct tst_tag[]) {
 		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see "
 			"https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/"
diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index 84becaa1f..82dcfb6b4 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -61,6 +61,10 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.tcnt = ARRAY_SIZE(tc),
+	.skip_filesystems = (const char *const[]) {
+                "btrfs",
+                NULL
+        },
 	.tags = (const struct tst_tag[]) {
 		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see "
 			"https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/"
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
