From: laniel_francis@privacyrequired.com <laniel_francis@privacyrequired.com>
Date: Wed,  8 Apr 2020 23:16:59 +0200
Subject: [LTP] Add new test for pipe2 with/without O_NONBLOCK mode
In-Reply-To: <208a947b-a64a-0962-b3de-0756f1cc1c92@cn.fujitsu.com>
References: <208a947b-a64a-0962-b3de-0756f1cc1c92@cn.fujitsu.com>
Message-ID: <20200408211700.7958-1-laniel_francis@privacyrequired.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


I added a new test file (pipe2_03.c) to test pipe2 system call with and without
O_NONBLOCK enabled.
This test uses the macro SAFE_PIPE2 that I added, this macro is just the
equivalent of SAFE_PIPE for pipe2.

The diff --stat output is the following:
include/safe_macros_fn.h                   |   3 +++
include/tst_safe_macros.h                  |   3 +++
lib/safe_macros.c                          |  15 ++++++++++++++
testcases/kernel/syscalls/pipe2/.gitignore |   1 +
testcases/kernel/syscalls/pipe2/pipe2_03.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
5 files changed, 152 insertions(+)


Best regards.
