From: Vikas Kumar <vikas.kumar2@arm.com>
Date: Thu, 14 May 2020 22:58:30 +0530
Subject: [LTP] [PATCH V4 0/1] syscall: Add io_uring test
Message-ID: <20200514172831.27854-1-vikas.kumar2@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

	Added Linux asynchronous I/O API Test for io_uring_setup(),
	io_uring_register() and io_uring_enter(). This test intend to 
	check basic io_uring api operation.
	
	io_uring_setup() creates submission queue and completion queue
	to perform subsequent operations on the io_uring instance.
	io_uring_register() registers user buffers to kernel for long term usese.
	io_uring_enter() initiate and finish I/O using the shared sq and cq queue.

---

Signed-off-by: Vikas Kumar <vikas.kumar2@arm.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Cc: Petr Vorel <pvorel@suse.cz>

---

Vikas Kumar (1):
  syscall: Add io_uring test

 testcases/kernel/syscalls/io_uring/Makefile   |   8 +
 .../kernel/syscalls/io_uring/io_uring01.c     | 191 ++++++++++++++++++
 2 files changed, 199 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_uring/Makefile
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring01.c

-- 
2.17.1

