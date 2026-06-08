Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D97CD8C9D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 05:50:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9661C3E2B52
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 07:50:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EEF73C537D
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 07:50:23 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 65132140162D
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 07:50:21 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65775spV2400615
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 05:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Tw2dipxDnW5poag4RbfByF66lHjBVmH4JhT5Wht3q
 3Y=; b=MDdPzsPzZ78yjHjtf2V5bhjwREoRv9OdGQpi32A3Kc/7b3dE4cJ7R3JdL
 6ALhLdhF50d1AMqll1dP+TqeRIcoFHOyKCZkfrfr9MV/bbX6SYoNaNjklU2yPeXB
 Ze0yOCqDhpmEN1fRThfNiADl0TZUzSWsRbNjPpYRju/08yz/JX3bBj910VVMMcHz
 /xk18AZrvSBL0o8qwmPsMrgDQ+/HXAHdHBlq29MIkin4kmHR6KZyvVugsmc/a6w+
 4lvdRtBVBuknu27cXIeayaE98zVKzEDb7wIafn7dcdEGysLWkBU1bUwGa+yNHBbY
 rM15DLSeUi4WTGDNjr9yir+zDzlkg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qdtm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:50:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585ndJV008803
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 05:50:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjkytd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:50:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6585oE5W29753654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 05:50:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FEC320043;
 Mon,  8 Jun 2026 05:50:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEC0F2004B;
 Mon,  8 Jun 2026 05:50:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.59.193])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 05:50:13 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 11:19:55 +0530
Message-ID: <20260608055000.97154-1-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a26581b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=eJIbC9Kyws5KvAAQrnoA:9
X-Proofpoint-GUID: gI91IzeWR-w89lojtPtDAqUmXEEM3SaJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfXzRvxT0TA6wif
 PV+g2scM33ByaxOIruRNPQ13Rqesq+TFcUpG4lDOyY6wIz14IcLUe04nBoXIvI4h9UVaUe9dGVW
 Tg+6bdybSnK4j/y/lUTfPPzExQoUm75G0Tw0nYK+SWguJpzr3ejP1YSEB6mM4WLjiSPqcogflI5
 9DH+qnKlZCqufJf0fNCqVLcZtevKIA6xrTItNPCtQY2n7gA+datPY6rV0MpiczhsVYoI6i2VAnh
 MapmUBus87mzHXtU8ryQjMZZfiVfNM12YRFwHrklYg2N5jJ8ng+y9hFbky1CpDrK/JZY7nYrLFO
 GZ/laxg8XjH3kjJU5RoH0MA7dX5nEb9efAFNdmi30EstmFRo3Y4+WOnvJ4RtL/uCsZB21g7Ve0N
 RfNSBbmHbzKy7kMvFQ8GMoFGm/XXJWKFKJapeet/1L45GSJeGqdDSQ5AIzJBJC/qmmLvJQogrvZ
 1qjK2Sb9DX5lFZSgX+g==
X-Proofpoint-ORIG-GUID: gI91IzeWR-w89lojtPtDAqUmXEEM3SaJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v4 0/5] ftrace: Convert shell tests to C
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

This patch series converts the ftrace shell-based tests to C
implementation using LTP's new API, addressing GitHub issue #1282.

The conversion provides:
- Better integration with LTP framework
- Improved error handling and reporting
- More maintainable code structure
- Consistent test behavior across platforms

Changes in v4:
- Fixed all trailing whitespace on blank lines in ftrace_lib.c (20+ locations)
- Corrected ftrace_regression01 commit message to accurately describe test behavior
  (tests userstacktrace with page fault events, not general function tracing)
- Corrected ftrace_regression02 commit message to describe actual test
  (verifies signal:signal_generate tracepoint fields, not function_graph tracer)
- Replaced inline tst_kvercmp() check with .min_kver = "3.2" in ftrace_regression02
- Removed incorrect LTP_TIMEOUT_MUL parsing in ftrace_stress_test setup()
- All whitespace issues verified with checkpatch.pl

Changes in v3:
- Fixed tst_tmpdir_path() usage by adding .needs_tmpdir = 1 to all tests
- Removed incorrect CVE-2015-8550 tag from ftrace_regression01
- Fixed memory leak in TST_RETRY_FUNC usage by assigning to variable and freeing
- Changed [Algorithm] sections from numbered lists to bullet points (using '-')
- Added root requirement documentation to all test doc comments
- Fixed Makefile LDLIBS placement (moved before generic_leaf_target.mk include)
- Created .gitignore for new test binaries
- Removed deprecated [Description] header from ftrace_stress_test
- Deleted orphaned shell files that were replaced by C implementations

Changes in v2:
- Fixed TST_NO_DEFAULT_MAIN placement in ftrace_lib.c (before includes)
- Removed tst_test.h include from ftrace_lib.h (libraries shouldn't include it)
- Fixed include order in test files (tst_test.h before ftrace_lib.h)
- Added proper cleanup of allocated memory in tests
- Improved error messages and test documentation
- Fixed Makefile dependencies and library filtering

Testing:
All tests have been compiled and verified to work correctly on x86_64
and ppc64le systems with various kernel versions. All whitespace issues
have been verified with checkpatch.pl.

Praveen K Pandey (5):
  ftrace: Add common library for C implementation
  ftrace: Convert ftrace_regression01.sh to C
  ftrace: Convert ftrace_regression02.sh to C
  ftrace: Convert ftrace_stress_test.sh to C
  ftrace: Remove obsolete shell test files

 runtest/tracing                               |   6 +-
 .../kernel/tracing/ftrace_test/.gitignore     |   4 +
 testcases/kernel/tracing/ftrace_test/Makefile |  19 +-
 .../kernel/tracing/ftrace_test/ftrace_lib.c   | 358 ++++++++++++++++++
 .../kernel/tracing/ftrace_test/ftrace_lib.h   | 139 +++++++
 .../kernel/tracing/ftrace_test/ftrace_lib.sh  | 180 ---------
 .../tracing/ftrace_test/ftrace_regression01.c | 128 +++++++
 .../ftrace_test/ftrace_regression01.sh        |  83 ----
 .../tracing/ftrace_test/ftrace_regression02.c | 103 +++++
 .../ftrace_test/ftrace_regression02.sh        |  63 ----
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
 .../tracing/ftrace_test/ftrace_stress_test.c  | 322 ++++++++++++++++
 .../tracing/ftrace_test/ftrace_stress_test.sh | 121 ------
 30 files changed, 1072 insertions(+), 1258 deletions(-)
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
