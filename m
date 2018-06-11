From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Jun 2018 14:36:07 +0200
Subject: [LTP] [PATCH] [RFC] README.md: Add shortcut to running a single test
Message-ID: <20180611123607.19390-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a shortcut to compiling and running a single test, which is
something that I've been asked for a few times.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 README.md | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/README.md b/README.md
index ffa769d73..6c2d203b7 100644
--- a/README.md
+++ b/README.md
@@ -42,6 +42,49 @@ $ git clone https://github.com/linux-test-project/ltp.git
 $ cd ltp
 $ make autotools
 $ ./configure
+```
+
+Now you can continue either with compiling and running a single test or with
+compling and installing the whole testsuite.
+
+Shortcut to running a single test
+---------------------------------
+
+If you need to execute a single test you actually does not need to compile
+whole LTP, if you want to run a syscall testcase following should work.
+
+```
+$ cd testcases/kernel/syscalls/foo
+$ make
+$ PATH=$PATH:$PWD ./foo01
+```
+
+Shell testcases are a bit more complicated since these need a path to a shell
+library as well as to compiled binary helpers, but generally following should
+work.
+
+```
+$ cd testcases/lib
+$ make
+$ cd ../commands/foo
+$ PATH=$PATH:$PWD:$PWD/../../lib/ ./foo01.sh
+```
+
+Open Posix Testsuite has it's own build system which needs Makefiles to be
+generated first, then compilation should work in subdirectories as well.
+
+```
+$ cd testcases/open_posix_testsuite/
+$ make generate-makefiles
+$ cd conformance/interfaces/foo
+$ make
+$ ./foo_1-1.run-test
+```
+
+Copiling and installing all testcases
+-------------------------------------
+
+```
 $ make
 $ make install
 ```
-- 
2.13.6

