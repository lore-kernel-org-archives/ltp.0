Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0B7CD8C85
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 04:17:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97F003E6FE7
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 06:17:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BB663C2180
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 06:16:45 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A3E0C1001162
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 06:16:44 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658IvnpY2323666; Tue, 9 Jun 2026 04:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=p/p5t/PeuMPyO4FRO8PAoE1xym+UuAdFhrmssmvde
 20=; b=PQ7umhprVYucA/2QnFzEDqYDDCFFbu1GOzAKEbuU7wzpAlyta6/o2SpdP
 QNOwO35EgSm38/hjetcgD1PqWRh9Mty5AEwtTdxhZqp9e/GtunqQg2q8ms0H4D1e
 qSqZueyaDhZUBDhyfLbdiaenOQPUEFKNxI+YjVhwuy3eZv2sTjKOHlQ/L/7zopy0
 MYBHYzcuEHkqQLbVmzxel/QDhvOWbEhMxpuk8k5VtSv5jQNQXG8LTra5a+MIOeSq
 AxlqW3Sl1XSn/fv/KLZGe5LUF/mnN0zU5gb59oyxhgRtZHorobTBYiaQIKebFpmi
 y/IOiAp46MOGczL5AJPkPJbAAtnaQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhtda9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 04:16:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659453JI000411;
 Tue, 9 Jun 2026 04:16:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych08ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 04:16:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6594Gc8t30998914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 04:16:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15CB02004B;
 Tue,  9 Jun 2026 04:16:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0471720040;
 Tue,  9 Jun 2026 04:16:37 +0000 (GMT)
Received: from dhcp-9-123-11-179.bl1-in.ibm.com (unknown [9.123.11.179])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2026 04:16:36 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  9 Jun 2026 09:46:27 +0530
Message-ID: <20260609041632.74427-1-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAzNCBTYWx0ZWRfX/4zhMUSTAqNa
 zsyd9xuDGXbOapQpwdSvOjAh63Shn2NI24zY4n1MmqmbUsTaDEJFGJ+KvFedjqhD8Ht64ugF0WP
 BTOFRq00S7lwlOI6PKC9YMeqv9oHL/ZXz/llyTJa4LvRY3Z2hNGBIMFeXTm0p9IQuYFoyNNQPcF
 aFxY5acDJgBDvqJsJSLxYheO8mpsjMCNU6ZePoWPwDFNWvxggLrb31lqTZjQ5kvvP1T/ymL9ThD
 I+uBztS2Uu5EfQZXDnXWUvbhXS8XmlUrCl9LDYyy3MU5/I+fYYxHiw1/RJE2284isOeaqaw2Iql
 gwZQ6tzaAaAzRLy5JoXoCTveZi/kQkrUlQpfy18q2DtD6lDUeaC2gMvbn50DAdp/8jhsUEFvJGa
 5JlK/wlQqihrIKR1+DZ55fWEvvGxYDimQsDXiOzCC0Qo6o5KBpy1EbZNuD4Z8Lg1ZawXUB2awcY
 AItRUW1eUobFNCNgQaA==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a2793aa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=-bpxaYo2Baj21x8QjJEA:9
X-Proofpoint-ORIG-GUID: pm6ehenU_jE5gzFjO1yKKRV2nxw3qlBg
X-Proofpoint-GUID: pm6ehenU_jE5gzFjO1yKKRV2nxw3qlBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090034
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/5] ftrace: Convert shell tests to C
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

Changes in v6:
- ftrace_lib.c:
  * Removed C++ style comment
  * Removed unused variable 'ret' in ftrace_set_tracer()
  * Added NULL check for strdup() in ftrace_restore_settings()
  * Added Suggested-by tag for Cyril Hrubis who provided the
    refactoring suggestions implemented in v5
- ftrace_regression01.c:
  * Fixed commit message to accurately describe the test
    (tests for kernel panic with userstacktrace, not "all tracers")
  * Removed incorrect .min_kver reference from commit message
- ftrace_regression02.c:
  * Fixed commit message to correctly state .min_kver = "3.2"
- ftrace_stress_test.c:
  * Fixed pthread_join() being called twice (undefined behavior)
    by resetting thread_count to 0 in stop_stress_tests()
  * Reset stop_testing and thread_count at start of run_test()
    to support multiple iterations (-i N)
  * Simplified cleanup() to avoid redundant stop_testing assignment
- Makefile changes:
  * Moved to patch 1 to maintain bisectability - each commit
    in the series now builds independently

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
- Bisectable commit history

Testing:
- Compiled successfully on x86_64 and ppc64le
- All tests pass on systems with ftrace support
- Proper cleanup verified (settings restored after test)
- Multiple iterations tested (-i N flag)

Praveen K Pandey (5):
  ftrace: Add common library for C implementation
  ftrace: Convert ftrace_regression01.sh to C
  ftrace: Convert ftrace_regression02.sh to C
  ftrace: Convert ftrace_stress_test.sh to C
  ftrace: Remove obsolete shell test files

 runtest/tracing                               |   6 +-
 .../kernel/tracing/ftrace_test/.gitignore     |   4 +
 testcases/kernel/tracing/ftrace_test/Makefile |  19 +-
 .../kernel/tracing/ftrace_test/ftrace_lib.c   | 374 ++++++++++++++++++
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
 .../tracing/ftrace_test/ftrace_stress_test.c  | 328 +++++++++++++++
 ./tracing/ftrace_test/ftrace_stress_test.sh | 121 ------
 30 files changed, 1086 insertions(+), 1256 deletions(-)
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
