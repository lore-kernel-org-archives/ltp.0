From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon,  5 Jun 2017 10:48:09 -0700
Subject: [LTP] [PATCH 0/2] ltp: update add_key tests for nonempty NULL
	payload fix
Message-ID: <20170605174811.95267-1-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

These two patches remove the existing add_key02 test, which is having its
behavior changed, and replaces it with the more thorough add_key03 test which
specifically tests the "NULL payload with nonzero length" case, which was
subject to a kernel bug causing a NULL dereference with some key types.

(The reason I'm not simply changing the add_key02 test is that I don't want it
to appear as a regression on old kernels.  I'm not sure exactly how this kind of
thing is typically handled in LTP, though.)

Eric Biggers (2):
  syscalls/add_key02: remove test
  syscalls/add_key03: add test for NULL payload with nonzero length

 runtest/syscalls                              |   2 +-
 testcases/kernel/syscalls/.gitignore          |   2 +-
 testcases/kernel/syscalls/add_key/add_key02.c |  74 ------------------
 testcases/kernel/syscalls/add_key/add_key03.c | 104 ++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 76 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/add_key/add_key02.c
 create mode 100644 testcases/kernel/syscalls/add_key/add_key03.c

-- 
2.13.0.506.g27d5fe0cd-goog

