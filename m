From: Matthias Maennich <maennich@google.com>
Date: Tue, 19 Mar 2019 11:31:51 +0000
Subject: [LTP] [PATCH v3 0/2] new test cases for sigpending / rt_sigpending
In-Reply-To: <20190308163832.212631-1-maennich@google.com>
References: <20190308163832.212631-1-maennich@google.com>
Message-ID: <20190319113153.13436-1-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Reusing the code from sigpending for rt_sigpending is a patch I sent in
earlier. Based on that this adds a new test case for both syscalls to test the
more common use of sigpending.

v2 -> v3:
 - fix comment style
 - use LTP_ATTRIBUTE_UNUSED

Cheers,
Matthias

Matthias Maennich (2):
  rt_sigpending02: reuse code from sigpending02
  sigpending/rt_sigpending: add basic test

 .../kernel/syscalls/rt_sigpending/Makefile    |   8 ++
 .../syscalls/rt_sigpending/rt_sigpending02.c  |  48 --------
 testcases/kernel/syscalls/sigpending/Makefile |   2 +
 .../kernel/syscalls/sigpending/sigpending02.c | 113 +++++++++++++++++-
 4 files changed, 117 insertions(+), 54 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/rt_sigpending/rt_sigpending02.c

-- 
2.21.0.225.g810b269d1ac-goog

