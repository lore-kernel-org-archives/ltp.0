From: Chunyu Hu <chuhu@redhat.com>
Date: Wed, 11 May 2016 19:36:22 +0800
Subject: [LTP] [PATCH V3-2 0/9] tracing: make ftrace tests to be extended
Message-ID: <1462966591-3895-1-git-send-email-chuhu@redhat.com>
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
    1. Fix bashism issue in ftrace_stress_test.sh and tracing_cpu_mask.sh
    2. ftrace_stress: remove the useless sleep in ftrace_stress_test.sh after wait.
    3. ftrace_stress: remove useless ".test.sh" in some sub cases.
    4. add ftrace_test_init to initiate test env and setup TST_CLEANUP=clean_up.
    5. use tst_exit in ftrace_regression01 and ftrace_regression02, and remove the
       'ignore' in tst_* usage.
    6. simplify test_wait in ftrace_lib.sh.
    7. cleanup the ';' in i=0 and j=0.
    8. tst_random cleanup according to Cyril's advise.

Changes from V1 -> V2:
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

