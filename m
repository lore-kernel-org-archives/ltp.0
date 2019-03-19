From: Matthias Maennich <maennich@google.com>
Date: Tue, 19 Mar 2019 18:41:34 +0000
Subject: [LTP] [PATCH v4 0/3] rt_sigpending02: reuse code from sigpending02
In-Reply-To: <20190308163832.212631-1-maennich@google.com>
References: <20190308163832.212631-1-maennich@google.com>
Message-ID: <20190319184137.8357-1-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reusing the code from sigpending for rt_sigpending is a patch I sent in
earlier. Based on that this adds a new test case for both syscalls to test the
more common use of sigpending.

v3 -> v4:
 - address review comments

v2 -> v3:
 - fix comment style
 - use LTP_ATTRIBUTE_UNUSED

Matthias Maennich (3):
  rt_sigpending02: reuse code from sigpending02
  sigpending/rt_sigpending: add basic test
  sigpending: improve portability by using tst_get_bad_addr()

 .../kernel/syscalls/rt_sigpending/Makefile    |   8 ++
 .../syscalls/rt_sigpending/rt_sigpending02.c  |  48 --------
 testcases/kernel/syscalls/sigpending/Makefile |   2 +
 .../kernel/syscalls/sigpending/sigpending02.c | 116 ++++++++++++++++--
 4 files changed, 119 insertions(+), 55 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/rt_sigpending/rt_sigpending02.c

-- 
2.21.0.225.g810b269d1ac-goog

