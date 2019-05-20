From: Sandeep Patil <sspatil@android.com>
Date: Mon, 20 May 2019 12:17:29 +0800
Subject: [LTP] [RFC PATCH 0/1] Fix return value checks for posix apis
Message-ID: <20190520041730.28238-1-sspatil@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is an RFC patch to demonstrate that most of the pthread_* calls
in the open_posix_testsuite seem to be doing the return value checks
incorrectly. Most posix_* apis return positive errno on failure and 0 on
success.

PATCH 1/1 demonstrates the fixes needed for pthread_sigmask/6-1 for
example. This pattern is fairly widespread in open_posix_testsuite.

After going through the documentation in the project, I wasn't sure if I
tested this correctly. After building, I tried the following

$ cd testcases/open_posix_testsuite
$ ./bin/run_tesit.sh conformance/interfaces/pthread_sigmask pthread_sigmask_6-1.run-test

...and that keeps running into test being skipped due to missing file.
(I do have pthread_sigmask_6-1.run-test in place).

So, consider this build tested only for now. I'd love to know how we can
test this and if we are still using the testsuite, then I am happy to
fix rest of the places where its broken.

Sandeep Patil (1):
  open_posix_testsuite/pthread_sigmask: fix return value checks

 .../interfaces/pthread_sigmask/6-1.c          | 69 +++++++++++--------
 1 file changed, 40 insertions(+), 29 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

