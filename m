From: Li Wang <liwang@redhat.com>
Date: Fri,  4 Mar 2016 16:24:49 +0800
Subject: [LTP] [PATCH RFC 0/9] tracing: make ftrace tests to be extended
Message-ID: <1457079898-9449-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For the purpose of extending these ftrace cases, We rewrite some of them to
partition testcase into new structure.

 1, Reorganize the stress tests to ftrace general test, then that woule be
    easy to introduce new function/regression testcases in the next step.

 2, Adding two regression testcases as an example, We will roll out some more later.

 3, Enhance the ftrace-stress test coverage.

 4, Do some cleanup and bug fix work.

At last, test PASS all the new testcases on kernel-4.4.0.

Chunyu Hu (4):
  ftrace_stress: skip unsupported tests
  ftrace_stress: keep the name of testscipt in sync with tracing file
  ftrace_stress: update the trace_options test
  ftrace_stress: add two new tests

Li Wang (5):
  ftrace_stress: remove the useless file ftrace_get_page_size.c
  tracing[1]: reorganize ftrace-stress tests to general tests
  tracing[2]: reorganize ftrace stress tests to general tests
  ftrace_regression: add new case to ftrace_regression/ dir
  ftrace_regression: add a new testcase

-- 
1.8.3.1

