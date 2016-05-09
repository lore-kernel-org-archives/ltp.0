From: Chunyu Hu <chuhu@redhat.com>
Date: Mon,  9 May 2016 19:03:29 +0800
Subject: [LTP] [PATCH v3 0/9] tracing: make ftrace tests to be extended
Message-ID: <1462791818-4184-1-git-send-email-chuhu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For the purpose of extending these ftrace cases, We rewrite some of them
to partition testcase into new structure.

 - Reorganize the stress tests to ftrace general test, then that woule
   be easy to introduce new function/regression testcases in the next
   step.
 - Adding two regression testcases as an example, We will roll
   out some more later.
 - Enhance the ftrace-stress test coverage.
 - Do some cleanup and bug fix work.

At last, test PASS all the new testcases on kernel-4.5.0.

Changes in V2 -> V3:
    1. Fix bashism issue in ftrace_stress_test.sh.
    2. ftrace_stress: remove the useless sleep in ftrace_stress_test.sh after wait.
    3. ftrace_stress: remove useless ".test.sh" in some sub cases.
    4. add ftrace_test_init to initiate test env and setup TST_CLEANUP=clean_up.
    5. use tst_exit in ftrace_regression01 and ftrace_regression02, and remove the
       'ignore' in tst_* usage.
    6. simplify test_wait in ftrace_lib.sh.
    7. cleanup the ';' in i=0 and j=0.
    8. tst_random cleanup according to Cyril's advise.

Changes from V1:
    1. Use ltp lib api.
    2. Fix bashism issues.
    3. ftrace_regression_test: make the two sub tests as two independent tests.
    4. ftrace_stress: Wait for pid after execing a killing of sub test.
    5. ftrace_stress: Fix tracing_cpumask test for case nr_cpu > 32.
    6. ftrace_stress: Fix set_ftrace_filter test for module filter.
    7. ftrace_stress: Fix small issue for trace_options test.

Chunyu Hu (6):
  ftrace_stress: skip unsupported tests and early cleanup
  ftrace_stress: keep the name of testscipt in sync with tracing file
  testcases/lib: Add tst_random decmical integer generator
  ftrace_stress: update the trace_options test
  ftrace_stress: add two new tests for ftrace_filter and
    tracing_cpu_mask
  ftrace_stress: cleanup and use ltp API

Li Wang (3):
  tracing: reorganize ftrace-stress tests to general tests
  tracing/ftrace: add new case for ftrace userstacktrace
  tracing/ftrace: add a new case for signal_generate

 doc/test-writing-guidelines.txt                    |  12 +
 runtest/tracing                                    |   2 +
 .../kernel/tracing/ftrace_stress_test/Makefile     |   7 -
 .../ftrace_stress/ftrace_buffer_size.sh            |  45 ----
 .../ftrace_stress/ftrace_current_tracer.sh         |  34 ---
 .../ftrace_stress/ftrace_ftrace_enabled.sh         |  39 ----
 .../ftrace_stress/ftrace_profile_enabled.sh        |  50 -----
 .../ftrace_stress/ftrace_set_event.sh              |  44 ----
 .../ftrace_stress/ftrace_set_ftrace_pid.sh         |  49 -----
 .../ftrace_stress/ftrace_stack_max_size.sh         |  39 ----
 .../ftrace_stress/ftrace_stack_trace.sh            |  46 ----
 .../ftrace_stress/ftrace_trace.sh                  |  27 ---
 .../ftrace_stress/ftrace_trace_clock.sh            |  46 ----
 .../ftrace_stress/ftrace_trace_options.sh          |  42 ----
 .../ftrace_stress/ftrace_trace_pipe.sh             |  52 -----
 .../ftrace_stress/ftrace_trace_stat.sh             |  45 ----
 .../ftrace_stress/ftrace_tracing_enabled.sh        |  39 ----
 .../ftrace_stress/ftrace_tracing_max_latency.sh    |  38 ----
 .../ftrace_stress/ftrace_tracing_on.sh             |  39 ----
 .../ftrace_stress_test/ftrace_stress_test.sh       | 243 ---------------------
 testcases/kernel/tracing/ftrace_test/Makefile      |   7 +
 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh | 183 ++++++++++++++++
 .../tracing/ftrace_test/ftrace_regression01.sh     |  85 +++++++
 .../tracing/ftrace_test/ftrace_regression02.sh     |  66 ++++++
 .../ftrace_stress/ftrace_buffer_size_kb.sh         |  45 ++++
 .../ftrace_stress/ftrace_current_tracer.sh         |  32 +++
 .../ftrace_stress/ftrace_ftrace_enabled.sh         |  38 ++++
 .../ftrace_function_profile_enabled.sh             |  38 ++++
 .../ftrace_test/ftrace_stress/ftrace_set_event.sh  |  46 ++++
 .../ftrace_stress/ftrace_set_ftrace_filter.sh      | 119 ++++++++++
 .../ftrace_stress/ftrace_set_ftrace_pid.sh         |  37 ++++
 .../ftrace_stress/ftrace_stack_max_size.sh         |  27 +++
 .../ftrace_stress/ftrace_stack_trace.sh            |  35 +++
 .../ftrace_test/ftrace_stress/ftrace_trace.sh      |  25 +++
 .../ftrace_stress/ftrace_trace_clock.sh            |  46 ++++
 .../ftrace_stress/ftrace_trace_options.sh          |  58 +++++
 .../ftrace_test/ftrace_stress/ftrace_trace_pipe.sh |  45 ++++
 .../ftrace_test/ftrace_stress/ftrace_trace_stat.sh |  45 ++++
 .../ftrace_stress/ftrace_tracing_cpumask.sh        |  91 ++++++++
 .../ftrace_stress/ftrace_tracing_enabled.sh        |  38 ++++
 .../ftrace_stress/ftrace_tracing_max_latency.sh    |  27 +++
 .../ftrace_test/ftrace_stress/ftrace_tracing_on.sh |  38 ++++
 .../tracing/ftrace_test/ftrace_stress_test.sh      | 122 +++++++++++
 testcases/lib/.gitignore                           |   1 +
 testcases/lib/Makefile                             |   4 +-
 testcases/lib/tst_random.c                         |  93 ++++++++
 46 files changed, 1403 insertions(+), 926 deletions(-)
 delete mode 100644 testcases/kernel/tracing/ftrace_stress_test/Makefile
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_current_tracer.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ftrace_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_profile_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_event.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_max_size.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_trace.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_clock.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_options.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_pipe.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_stat.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_max_latency.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_on.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
 create mode 100644 testcases/kernel/tracing/ftrace_test/Makefile
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
 create mode 100644 testcases/lib/tst_random.c

-- 
1.8.3.1

