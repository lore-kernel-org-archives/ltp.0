Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACCACD8C85
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 19:58:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECC493E5FCC
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 21:58:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 501783E23C4
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 21:58:41 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1F2536002CC
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 21:58:38 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65631TC92074606
 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 19:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=DSRYqiStjRdx2zv/a3RszYY3JBJvhLEiseP7LFmgI
 sU=; b=CJLXBvf7WrD7Xggg22VQO2AAY1URL6QAjXJWRR4av7df6uC78Da8lBJ5l
 DeiDLn9GZhbekzKnTDdUuEWz0bGEb/2X8tfknbqy3NIqJn8knNqbVzrpzAqs6jgS
 Fj/g7l9i65ROr5k+XB+kXxTGL4aOu4F+1yfyRlW0Ndo69rrmW+b4KXCuUfDlXaAz
 40iEhPp4OnmVlFaIJt51sj0tIs53iWpe2RHrzJ7hriFqdQorTFH4FFhEulUml+jx
 MVtFzbRfl0OUt6e1hLhZ+riwWDHPN9yj0PaS8hy4lWgwLp6roX3CmeQ+kgS95bKn
 3QsMUJTYCQaowy2R0fBir4L3yqZXg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb951y68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 19:58:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 656JnaCe028777
 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 19:58:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyxgeb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 19:58:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 656JwWvq56623492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Jun 2026 19:58:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FA9320049;
 Sat,  6 Jun 2026 19:58:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAAB720040;
 Sat,  6 Jun 2026 19:58:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.127.204])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Jun 2026 19:58:31 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  7 Jun 2026 01:28:13 +0530
Message-ID: <20260606195818.95400-1-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a247bed cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=RmiRHZcbX2QtkFt7TYQA:9
X-Proofpoint-ORIG-GUID: nYipA09_SoekiWabxrfuKbryHmfmyBWj
X-Proofpoint-GUID: nYipA09_SoekiWabxrfuKbryHmfmyBWj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDIwMSBTYWx0ZWRfXxpGyjsOVesiz
 vtDalgpyYNrQNs7fdY29Qyo6K/cpACAYRyS9rrxpxD/L1vR3OCBDwo0ZFteNd4o7pfiPMUSMZ2u
 HLJwtqJt7tDT2Yw5Qxw079Buu5ZeyLJsu/aDgZRKFwzmj/1os5kvB5FDsQ2xdczkjZiGE5zdtDG
 tw6ROXqTwq3TgNsSErI4o2KTyP+paTG0iV54i1uWTWGrBPqlrcA1HNC9O2ElljVDMfJyTf+hO+v
 HALlFmovhPuKEqPjFaoC/73Y2U+I77JyeLXXsu8OITknwc/1htKQoSsf2Sna6WG9IomEOgD5q3p
 o26ZllTwsCpIema/Q7gSHJv5myTLBnF272eMJQKypGqjZsuYH83x2Vdpbb/hLUND20Yf8nllC3z
 lWLjFvh1iuYFrQdvFOaLES2JGRBpKsuMkf6mJ1hwWKPRe4W4SVZpm41eE4bJmzrr3+KIjJVjeaR
 d8fqdQjxRQfKeKlw28A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060201
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v2 0/5] ftrace: Convert shell tests to C
 implementation
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

This patch series converts ftrace shell-based tests to C implementation
to address GitHub issue #1282. The conversion provides better
maintainability, performance, and integration with LTP's C test
framework.

Changes in v2:
- Fixed compilation issues identified during testing
- Added TST_NO_DEFAULT_MAIN to ftrace_lib.c to prevent multiple main() definitions
- Changed tst_get_tmpdir() to tst_tmpdir_path() (correct LTP API)
- Removed tst_test.h from ftrace_lib.h (library headers shouldn't include it)
- Added tst_test.h includes to all test files
- Replaced SAFE_FPRINTF with SAFE_FILE_PRINTF in ftrace_regression01.c
- Removed unused variable in ftrace_stress_test.c
- Changed max_runtime to timeout in ftrace_stress_test.c
- Removed deprecated [Description] headers from test files
- Replaced usleep() with TST_RETRY_FUNC() to comply with LTP Ground Rule 2
- Fixed Makefile: moved dependency rules after generic_leaf_target.mk include
- Added FILTER_OUT_MAKE_TARGETS for library object
- Changed to per-target LDLIBS for pthread linking
- Removed unnecessary INSTALL_TARGETS
- Updated runtest/tracing to use C binaries
- Removed invalid "Fixes: #1282" tags from all commits
- All patches now have proper Signed-off-by tags

Summary of changes:
- Patch 1: Add common ftrace library (ftrace_lib.c/h)
- Patch 2: Convert ftrace_regression01.sh to C
- Patch 3: Convert ftrace_regression02.sh to C  
- Patch 4: Convert 18 ftrace_stress/*.sh scripts to single C implementation
- Patch 5: Remove obsolete shell scripts

Key improvements:
- Multi-threaded stress testing using pthread
- Proper LTP API usage (TST_RETRY_FUNC, SAFE_* macros)
- Better error handling and resource management
- Reduced code duplication through shared library
- Compliance with LTP coding standards and ground rules

Testing:
- All tests compile successfully without warnings
- Tests run correctly and produce expected results (PASS/TCONF)
- Verified on Power architecture (ppc64le)

Praveen K Pandey (5):
  ftrace: Add common library for C implementation
  ftrace: Add C implementation of ftrace_regression01
  ftrace: Add C implementation of ftrace_regression02
  ftrace: Add C implementation of ftrace_stress_test and update build
  ftrace: Remove obsolete shell scripts from ftrace_stress folder

 runtest/tracing                                   |   6 +-
 testcases/kernel/tracing/ftrace_test/Makefile     |  19 +-
 .../kernel/tracing/ftrace_test/ftrace_lib.c       | 352 +++++++++++++++++++++
 .../kernel/tracing/ftrace_test/ftrace_lib.h       | 140 ++++++++
 .../tracing/ftrace_test/ftrace_regression01.c     | 124 +++++++
 .../tracing/ftrace_test/ftrace_regression02.c     |  99 ++++++
 .../tracing/ftrace_test/ftrace_stress_test.c      | 320 ++++++++++++++++++
 .../ftrace_stress/ftrace_buffer_size_kb.sh        |  44 ---
 .../ftrace_stress/ftrace_current_tracer.sh        |  44 ---
 .../ftrace_stress/ftrace_ftrace_enabled.sh        |  44 ---
 .../ftrace_function_profile_enabled.sh             |  44 ---
 .../ftrace_test/ftrace_stress/ftrace_set_event.sh |  44 ---
 .../ftrace_stress/ftrace_set_ftrace_filter.sh     |  44 ---
 .../ftrace_stress/ftrace_set_ftrace_pid.sh        |  44 ---
 .../ftrace_stress/ftrace_stack_max_size.sh        |  44 ---
 .../ftrace_stress/ftrace_stack_trace.sh           |  44 ---
 .../ftrace_test/ftrace_stress/ftrace_trace.sh     |  44 ---
 .../ftrace_stress/ftrace_trace_clock.sh           |  44 ---
 .../ftrace_stress/ftrace_trace_options.sh         |  44 ---
 .../ftrace_stress/ftrace_trace_pipe.sh            |  44 ---
 .../ftrace_stress/ftrace_trace_stat.sh            |  44 ---
 .../ftrace_stress/ftrace_tracing_cpumask.sh       |  44 ---
 .../ftrace_stress/ftrace_tracing_enabled.sh       |  44 ---
 .../ftrace_stress/ftrace_tracing_max_latency.sh   |  44 ---
 .../ftrace_stress/ftrace_tracing_on.sh            |  44 ---
 25 files changed, 1053 insertions(+), 809 deletions(-)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_lib.c
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_lib.h
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c
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

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
