From: Chunyu Hu <chuhu@redhat.com>
Date: Mon, 18 Apr 2016 16:04:07 +0800
Subject: [LTP] [PATCH V2 0/9] tracing: make ftrace tests to be extended
Message-ID: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
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

Changes from V1:
1. Use ltp lib api.
2. Fix bashism issues.
3. ftrace_regression_test: make the two sub tests as two independent tests.
4. ftrace_stress: Wait for pid after execing a killing of sub test.
5. ftrace_stress: Fix tracing_cpumask test for case nr_cpu > 32.
6. ftrace_stress: Fix set_ftrace_filter test for module filter.
7. ftrace_stress: Fix small issue for trace_options test.

Chunyu Hu (6):
  ftrace_stress: skip unsupported tests
  ftrace_stress: keep the name of testscipt in sync with tracing file
  testcases/lib: Add tst_random decmical integer generator
  ftrace_stress: update the trace_options test
  ftrace_stress: add two new tests
  ftrace_stress: cleanup and use ltp API

Li Wang (3):
  tracing: reorganize ftrace-stress tests to general tests
  tracing/ftrace: add new case for ftrace userstacktrace
  tracing/ftrace: add a new case for signal_generate

