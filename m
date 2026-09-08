Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF29C79F99
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 16:56:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 882693E94B0
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 18:56:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39B6E3E94A6
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 18:55:06 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C9E9B6008FB
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 18:55:04 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1frY1228027; Tue, 8 Sep 2026 16:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=0uDc1jFbpCuryTtCokgccCm0Cj2faoaMLNIGUm3y7
 vA=; b=UdA6rJxNPbUweDDC56GjAZZIdZtitWqNBfpJxV6u5NUgViWtTMSqmycey
 M9A6HO62pbnAuC6LbbiMRgiwQno6hOU/SpGhi6hFcRnpXH0+F0A0/2uUgowGfh0j
 JOPNgENX+wLhJx4LmXHoqoBOoTYIJvrk2KCl+a/QfuYfWyc44ijzZyhlQJd6h3U9
 NHRNVpCdX1lF4/JMj7azYP/9Vgi4FgnmD378xTq9MbvmiairdhEhaGOOEXrl9MoE
 BPyyVX8etIidIFn0soY8KobpWwO6mSrzfVG1f5+ESQ9IhYvOV32fxMszNDn2+2g/
 hjgeHU1UFCCsxCxnQU/LyuKz2fhcA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkrkx2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 16:55:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GfEgo027382;
 Tue, 8 Sep 2026 16:55:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdjw6x0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 16:55:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 688GsuE747513946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Sep 2026 16:54:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6A1A2004B;
 Tue,  8 Sep 2026 16:54:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0B7C20040;
 Tue,  8 Sep 2026 16:54:56 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ehn-de.ibm.com (unknown
 [9.224.74.129]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Sep 2026 16:54:56 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  8 Sep 2026 18:54:27 +0200
Message-ID: <20260908165430.251897-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX28hjN95FY1Ly
 kgCWsegYPUTvaMqrn8wSB99T07WOGR0vuWKFVyCK+OcDS7jsc6ZZOBuGyA6wNaLyITdgcVYRnzW
 6HYrq2xRk1Ks75oOJjkF8oUD04RDeyk=
X-Proofpoint-ORIG-GUID: DYUdV_iAW8W8bP42WLxPlNBZFZBlJYxl
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6aa03de6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=-UpwcQOxWNG_FBFHVQUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX8ahIfQ+JyE3B
 L3yEjKfXf9tD9Wj625sI2CsWwLms3Hd4JQP06D6BKNIGi5aWESXFJa8fnggBw1XWp0JFU3NHBaR
 T3tvZ2nM7mcnYDHJUnu6EdNjVNJzNJwHngEASP957/rlwN06JIxqvOXk4HTcjbNJeYwAqUM8qJT
 iZapp3D9qwX9uB3I2ST9FGbd/Xu9Ei4R0E3Q2Om3iBASl/iptZMyPlBkWQdHg9CfxTw3nnmwho+
 /PUjf8upvgmXgREogTKrBBzwOuL3dFK9G+681na1mGylBInRVyBQFws6O69B0j7k7nt0/oC1Vfe
 Fu4mrTtTLfwcJ25lLmiAeqIOkGcNKLfyHOF92TdI1xoR4kdPxaOOr31nLVI1Kz0UXliLLs3u+Yk
 2VHpKCY6TYwlgHRGgVXNo9kuF8kiZ1Rc//1j+9i5kAEFw1HWDw0KNryr4iWs/5iEsBu6kqcGXMc
 bGz8wBTKFqhqKlLz/pg==
X-Proofpoint-GUID: DYUdV_iAW8W8bP42WLxPlNBZFZBlJYxl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/3] Handle FORCE_PTRACE in thp04 and add ptrace
 coverage
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

thp04 is a CVE-2017-1000405 regression test. If direct
/proc/self/mem writes are blocked by CONFIG_PROC_MEM_FORCE_PTRACE=y,
the CVE cannot be triggered and thp04 should report TCONF.

Add separate ptrace tests for the CONFIG_PROC_MEM_FORCE_PTRACE behavior
instead:

- ptrace12 checks that writing to /proc/self/mem is rejected with EIO.
- ptrace13 checks that a parent can write to a traced child's memory via
  /proc/pid/mem.

Both ptrace tests use read-only mappings, so the writes require
FOLL_FORCE and exercise the CONFIG_PROC_MEM_FORCE_PTRACE enforcement.

Tested on s390x with CONFIG_PROC_MEM_FORCE_PTRACE=y:

- thp04: TCONF (direct /proc/self/mem writes blocked)
- ptrace12: TPASS
- ptrace13: TPASS, 100 iterations

Follow-up to the previous thp04 ptrace mode discussion:
https://lore.kernel.org/all/20260709175927.268677-1-japo@linux.ibm.com/

Changes in v6:
- thp04: probe /proc/self/mem on a separate anonymous mapping to avoid
  COW-polluting the huge zero page before the race test starts
- thp04/ptrace12/ptrace13: fix SPLIT_STRING checkpatch warnings
- ptrace12/ptrace13: move runtest entries before the pwrite blank line
- ptrace13: skip raise(SIGSTOP) on last iteration so child exits via exit(0)

Changes in v5:
- thp04: use != -1 instead of >= 0 for fd validity checks in thp_cleanup()
- thp04: cast TST_RET to (ssize_t) before comparing with sizeof()
- ptrace12: use != -1 instead of >= 0 for memfd validity check in cleanup()
- ptrace12: cast TST_RET to (ssize_t) before comparing with sizeof()
- ptrace13: fix race between PTRACE_INTERRUPT and child's first raise(SIGSTOP);
  replace PTRACE_INTERRUPT with an explicit initial raise(SIGSTOP) in the child
- ptrace13: cast TST_RET to (ssize_t) before comparing with sizeof()
- ptrace13: remove redundant #include "tst_checkpoint.h" (already in tst_test.h)
- ptrace13: update doc-comment to reflect the new stop flow

Changes in v4:
- thp04: prove the /proc/self/mem probe changes memory before running the race
- thp04: tighten direct-write result handling and document blocked-write behavior
- ptrace12: gate the test on CONFIG_PROC_MEM_FORCE_PTRACE=y
- ptrace12: treat successful /proc/self/mem writes as TFAIL under the required config
- ptrace13: use a tracer-controlled PTRACE_INTERRUPT initial stop
- ptrace13: fix the iteration diagnostic and clean up wait-status handling
- ptrace13: use PTRACE_KILL for normal termination

v5: https://lore.kernel.org/all/20260908111332.150323-1-japo@linux.ibm.com/
v4: https://lore.kernel.org/all/20260722135926.359462-1-japo@linux.ibm.com/
v3: https://lore.kernel.org/all/20260721202452.315581-1-japo@linux.ibm.com/
v2: https://lore.kernel.org/all/20260716095004.92793-1-japo@linux.ibm.com/
v1: https://lore.kernel.org/all/20260714150631.250972-1-japo@linux.ibm.com/

Jan Polensky (3):
  thp04: group runtime state and skip when /proc/self/mem writes are
    blocked
  ptrace: add test for /proc/self/mem write rejection
  ptrace: add test for /proc/pid/mem writes under ptrace

 runtest/syscalls                            |   2 +
 testcases/kernel/mem/thp/thp04.c            | 172 ++++++++++-----
 testcases/kernel/syscalls/ptrace/.gitignore |   2 +
 testcases/kernel/syscalls/ptrace/ptrace12.c |  95 +++++++++
 testcases/kernel/syscalls/ptrace/ptrace13.c | 220 ++++++++++++++++++++
 5 files changed, 439 insertions(+), 52 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace12.c
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace13.c


base-commit: 352f9134942933efcfa608b87ae814db603b3228
--
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
