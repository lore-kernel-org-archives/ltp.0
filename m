Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8613CD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 13:26:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25D4A3E5F8D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 15:26:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B46453E4E74
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 15:25:50 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BCCDB600284
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 15:25:49 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586oI8S2688319; Mon, 8 Jun 2026 13:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Yyokmb6ztSSZnoPCHkHjSgkzPyp78Z8QFMNZg3ctH
 OA=; b=iZEHkkYeGKdRIXgSvsTxbiJgQ2AOhNwGvrq2B9l+pVq/ClaAaUSlh1aYh
 BPdenyy1S9QfdDPFjRRJr1DhV8Tt04CwwJLxVRDtFu1Ht4zBhT6vK8R2WnCtJ+LZ
 EbANFI1xJ+2eYGub5nyezRSj3XY1Vkku8ieRLmRxH28JoMUQOm8HVg48KA3dOZmX
 8GascHWrxzqVhEn9YJDLQAblE6YcocLK47hmdoI4ZCJA40+0SxKnrDeXGxKTwkJs
 cEy7FW5B8sw0WuScLo5mzEnph7/fMOu53swpWYA0c8AeLThfajOk8sUm8V6eygkS
 f1Q+OZSu2t3cJ35dSG757bYnHVkeg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydyf9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 13:25:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658DJdVJ004985;
 Mon, 8 Jun 2026 13:25:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vwjtq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 13:25:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 658DPhvr60227904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 13:25:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5623C20043;
 Mon,  8 Jun 2026 13:25:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8093A20040;
 Mon,  8 Jun 2026 13:25:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.59.193])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 13:25:42 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 18:55:21 +0530
Message-ID: <20260608132526.42325-1-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX0WtrrbbUvII/
 Sz7aAeGvc29f3CRSr3V/CWuai7yrv1CK2Pw1IKbsnC7xzxFkUWZKQotGdPU8MRzlrgBX+hm2yJF
 zERZ8Eh9N95qhLS1SnH3DRvfqDed9iRmnFCXP6HvBxYN/kOdaMfHJlSJzmXoeV1ykysTPNWr/Va
 VDGEZ//RaBHwTEDd7w++9tSSwn2388LPgOZvdv9D/gLx5I+QRrgm52BO25NtIL56hfaneSTtncj
 qzep3PIVzP/9VTPtqQmKToP6H7fvS2xn1p0tTssCpVsD3ggKtEiE9rGEdLRa7//pGyzxafw9Y1a
 IAajsvpsRXkYBIGQXbp+fMwh/loeJHrXIIYP93lyPknSLLfglqRsLXtBQPt2JQloo4OcSBf2MZT
 b32y43tTWwbFSHy72ZKKTwuD4Gz4e/xPoWPqS8OLPSwyVCoAkre/bM9yJPaONRXAndb10GQH91P
 t61wDwxboDeuSW62s9Q==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a26c2db cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=eJIbC9Kyws5KvAAQrnoA:9
X-Proofpoint-GUID: cSWa-BtlwjWaqYOIwbYTVZGJfvsOAViR
X-Proofpoint-ORIG-GUID: cSWa-BtlwjWaqYOIwbYTVZGJfvsOAViR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080124
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/5] ftrace: Convert shell tests to C
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

This patch series converts the ftrace shell-based tests to C using
the new LTP test API. This addresses issue #1282 and provides better
error handling, maintainability, and integration with LTP's modern
test infrastructure.

Changes in v5:
- ftrace_lib.c: Major refactoring based on review feedback
  * Removed static variable initialization to 0/NULL (C standard)
  * Removed obvious comments for cleaner code
  * Replaced manual debugfs mount check with tst_is_mounted()
  * Used SAFE_ASPRINTF() for all path construction
  * Used SAFE_FILE_PRINTF() in ftrace_set_tracer()
  * Simplified ftrace_get_available_tracers() to read line by line
  * Added proper error checking for strdup() calls
- ftrace_lib.h: Cleaned up API
  * Fixed kernel-doc comment format (use - instead of ())
  * Removed low-level implementation details from header
- ftrace_regression01.c/ftrace_regression02.c:
  * Removed deprecated [Description] header line
- ftrace_stress_test.c:
  * Fixed use-after-free: join threads before ftrace_cleanup()

Changes in v4:
- Fixed trailing whitespace issues
- Corrected commit message format and content
- Replaced tst_kvercmp() with .min_kver = "2.6.29"
- Removed LTP_TIMEOUT_MUL parsing (handled by framework)
- Updated documentation to reflect root requirement

Changes in v3:
- Fixed tst_tmpdir_path() usage in ftrace_lib.c
- Removed CVE tag from test documentation
- Fixed memory leaks in ftrace_get_available_tracers()
- Changed Algorithm sections to bullet points
- Added root requirement to test documentation
- Fixed Makefile to include ftrace_lib.o in LDLIBS
- Created .gitignore for compiled binaries
- Removed deprecated tst_reinit.h include
- Deleted orphaned shell test files

Changes in v2:
- Moved TST_NO_DEFAULT_MAIN before includes
- Fixed include order (tst_test.h before tst_safe_*.h)
- Removed tst_reinit() calls (not needed with new API)
- Fixed test structure initialization
- Improved error messages

The conversion provides:
- Better error handling using LTP's SAFE_* macros
- Proper resource cleanup and state restoration
- Modern LTP test API usage
- Improved code maintainability
- Type safety and compile-time checks

Testing:
- Compiled successfully on x86_64 and ppc64le
- All tests pass on systems with ftrace support
- Proper cleanup verified (settings restored after test)

Praveen K Pandey (5):
  ftrace: Add common library for C implementation
  ftrace: Convert ftrace_regression01.sh to C
  ftrace: Convert ftrace_regression02.sh to C
  ftrace: Convert ftrace_stress_test.sh to C
  ftrace: Remove obsolete shell test files

 runtest/tracing                               |   6 +-
 .../kernel/tracing/ftrace_test/.gitignore     |   4 +
 testcases/kernel/tracing/ftrace_test/Makefile |  19 +-
 .../kernel/tracing/ftrace_test/ftrace_lib.c   | 371 ++++++++++++++++++
 .../kernel/tracing/ftrace_test/ftrace_lib.h   | 136 +++++++
 .../kernel/tracing/ftrace_test/ftrace_lib.sh  | 180 ---------
 .../tracing/ftrace_test/ftrace_regression01.c | 126 ++++++
 .../ftrace_test/ftrace_regression01.sh        |  83 ----
 .../tracing/ftrace_test/ftrace_regression02.c | 101 +++++
 .../ftrace_test/ftrace_regression02.sh        |  63 ---
 .../ftrace_stress/ftrace_buffer_size_kb.sh    |  45 ---
 .../ftrace_stress/ftrace_current_tracer.sh    |  32 --
 .../ftrace_stress/ftrace_ftrace_enabled.sh    |  38 --
 .../ftrace_function_profile_enabled.sh        |  38 --
 .../ftrace_stress/ftrace_set_event.sh         |  46 ---
 .../ftrace_stress/ftrace_set_ftrace_filter.sh | 119 ------
 .../ftrace_stress/ftrace_set_ftrace_pid.sh    |  37 --
 .../ftrace_stress/ftrace_stack_max_size.sh    |  27 --
 .../ftrace_stress/ftrace_stack_trace.sh       |  35 --
 .../ftrace_test/ftrace_stress/ftrace_trace.sh |  25 --
 .../ftrace_stress/ftrace_trace_clock.sh       |  27 --
 .../ftrace_stress/ftrace_trace_options.sh     |  58 ---
 .../ftrace_stress/ftrace_trace_pipe.sh        |  45 ---
 .../ftrace_stress/ftrace_trace_stat.sh        |  38 --
 .../ftrace_stress/ftrace_tracing_cpumask.sh   |  91 -----
 .../ftrace_stress/ftrace_tracing_enabled.sh   |  38 --
 .../ftrace_tracing_max_latency.sh             |  27 --
 .../ftrace_stress/ftrace_tracing_on.sh        |  38 --
 .../tracing/ftrace_test/ftrace_stress_test.c  | 325 +++++++++++++++
 .../tracing/ftrace_test/ftrace_stress_test.sh | 121 ------
 30 files changed, 1083 insertions(+), 1256 deletions(-)
 create mode 100644 testcases/kernel/tracing/ftrace_test/.gitignore
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_lib.c
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_lib.h
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh

-- 
2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
