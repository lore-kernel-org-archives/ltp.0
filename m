From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 12 Oct 2017 13:42:23 -0700
Subject: [LTP] [PATCH v2 0/4] ltp: add tests for some recently-fixed
	keyrings bugs
Message-ID: <20171012204227.116510-1-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Add tests to LTP for a few more longstanding bugs which were recently
fixed in the kernel keyrings API.

Changed since v1:

    - Updated add_key03 to find an unused user by searching the passwd
      database, which allowed simplifying the test.

    - Added CVE number for keyctl07.

Eric Biggers (4):
  lapi/keyctl.h: add a few missing definitions
  syscalls/keyctl06: new test for keyring_read() buffer overrun
  syscalls/keyctl07: new test for oops when reading negative key
  syscalls/add_key03: new test for forging user keyrings

 include/lapi/keyctl.h                         | 20 ++++++
 runtest/cve                                   |  1 +
 runtest/syscalls                              |  3 +
 testcases/kernel/syscalls/.gitignore          |  3 +
 testcases/kernel/syscalls/add_key/add_key03.c | 98 +++++++++++++++++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl06.c   | 68 +++++++++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl07.c   | 89 ++++++++++++++++++++++++
 7 files changed, 282 insertions(+)
 create mode 100644 testcases/kernel/syscalls/add_key/add_key03.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl06.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl07.c

-- 
2.15.0.rc0.271.g36b669edcc-goog

