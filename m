From: Matthias Maennich <maennich@google.com>
Date: Tue, 12 Feb 2019 16:12:34 +0000
Subject: [LTP] [PATCH v2 0/2] sigpending / rt_sigpending
In-Reply-To: <20190207155153.41816-1-maennich@google.com>
References: <20190207155153.41816-1-maennich@google.com>
Message-ID: <20190212161236.74385-1-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Split the `sigpending` test case into rt_sigpending and sigpending, both
bypassing any syscall wrappers.

Obviously these tests are currently only testing a rare corner case and
more thorough testing is needed to cover both of the syscalls. That work
is to be done in a later commit.

Matthias Maennich (2):
  sigpending: use direct syscall
  rt_sigpending: add rt_sigpending02 test case

 runtest/syscalls                              |  1 +
 .../kernel/syscalls/rt_sigpending/.gitignore  |  1 +
 .../kernel/syscalls/rt_sigpending/Makefile    | 23 +++++++++
 .../syscalls/rt_sigpending/rt_sigpending02.c  | 48 +++++++++++++++++++
 .../kernel/syscalls/sigpending/sigpending02.c |  3 +-
 5 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/rt_sigpending/.gitignore
 create mode 100644 testcases/kernel/syscalls/rt_sigpending/Makefile
 create mode 100644 testcases/kernel/syscalls/rt_sigpending/rt_sigpending02.c

-- 
2.20.1.791.gb4d0f1c61a-goog

