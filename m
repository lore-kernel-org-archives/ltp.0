From: laniel_francis@privacyrequired.com <laniel_francis@privacyrequired.com>
Date: Thu,  9 Apr 2020 23:12:54 +0200
Subject: [LTP] Add new test for pipe2 with/without O_NONBLOCK mode
In-Reply-To: <67fdc846a8cd8616c9eb13cf89463b9d637e6849>
References: <67fdc846a8cd8616c9eb13cf89463b9d637e6849>
Message-ID: <20200409211255.1357-1-laniel_francis@privacyrequired.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi.


I added a new test file (pipe2_03.c) to test pipe2 system call with and without
O_NONBLOCK enabled.
This test uses the macro SAFE_PIPE2 that I added, this macro is just the
equivalent of SAFE_PIPE for pipe2.

I do not know if it is correct to do that but at the end of the test function we
need to set the pipe in the same state as it was at the end of setup function:
1. Set the O_NONBLOCK flag to the pipe.
2. Read the pipe to empty it.
3. We do not set its size to default because we do not care of it.
If we do not do that, there will be problem when this test is run multiple time
(this problem was found when running ./pipe2_03 -i 10).

The diff --stat output is the following:
 include/old/safe_macros.h                  |   3 +++
 include/tst_safe_macros.h                  |   6 ++++++
 lib/safe_macros.c                          |  15 ++++++++++++++
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/pipe2/.gitignore |   1 +
 testcases/kernel/syscalls/pipe2/pipe2_03.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 161 insertions(+)


Best regards.

