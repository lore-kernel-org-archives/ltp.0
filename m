From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 28 May 2021 20:25:49 +0200
Subject: [LTP] [PATCH] doc: Modernize test-writing-guidelines
Message-ID: <20210528182549.14347-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/test-writing-guidelines.txt | 80 ++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 27 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 437239b97..e29ee4f6d 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1,9 +1,9 @@
 LTP Test Writing Guidelines
 ===========================
 
-This document describes LTP guidelines and LTP test interface and is intended
-for anybody who want to write or modify a LTP testcase. It's not a definitive
-guide and it's not, by any means, a substitute for common sense.
+This document describes LTP guidelines and is intended for anybody who want to
+write or modify a LTP testcase. It's not a definitive guide and it's not, by
+any means, a substitute for common sense.
 
 NOTE: See also
       https://github.com/linux-test-project/ltp/wiki/C-Test-API[C Test API],
@@ -105,14 +105,33 @@ were drifting slowly apart which yielded into API misuses and hard to find
 bugs. Remember there is only one thing worse than no documentation, wrong
 documentation.
 
-Generally everybody should write code that is obvious (which unfortunately
-isn't always possible). If there is a code that needs to be commented keep it
-short and to the point. Never ever comment the obvious.
+Ideally everybody should write code that is obvious, which unfortunately
+isn't always possible. But here are some tips:
 
-In case of LTP testcases it's customary to add a paragraph with highlevel test
-description somewhere at the beginning of the file (usually right under the GPL
-header). This helps other people to understand the overall goal of the test
-before they dive into the technical details.
+* First of all I will repeat *Keep things simple*
+
+* Keep function and variable names short but descriptive, choosing a good name
+  for an API function is very difficuilt task; do not underestimate it
+
+* Keep functions reasonably short and focused on a single task
+
+* Be consistent
+
+* Avoid deep nesting
+
+* DRY
+
+If there is a code that requires to be commented keep it short and to the
+point. These comments should explain *why* and not *how* thigs are done.
+
+Never ever comment the obvious.
+
+In case of LTP testcases it's customary to add a comment with an asciidoc
+formatted paragraph with highlevel test description at the beginning of the
+file right under the GPL SPDX header. This helps other people to understand
+the overall goal of the test before they dive into the technical details. It's
+also exported into generated documentation hence it should mostly explain what
+is tested and why.
 
 1.5 Backwards compatibility
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -124,20 +143,27 @@ toolchain supplied by the manufacturer.
 
 Therefore LTP test for more current features should be able to cope with older
 systems. It should at least compile fine and if it's not appropriate for the
-configuration it should return 'TCONF' (see test interface description below).
+configuration it should return 'TCONF'.
 
 There are several types of checks we use:
 
 The *configure script* is usually used to detect availability of a function
-declarations in system headers. It's used to disable tests at compile time.
-
-We also have runtime kernel version detection that can be used to disable
-tests at runtime.
+declarations in system headers. It's used to disable tests at compile time or
+to enable fallback definitions.
 
 Checking the *errno* value is another type of runtime check. Most of the
 syscalls returns either 'EINVAL' or 'ENOSYS' when syscall was not implemented
 or was disabled upon kernel compilation.
 
+LTP has kernel version detection that can be used to disable tests at runtime,
+unfortunatelly kernel version does not always corresponds to a well defined
+feature set as distributions tend to backport hundreds of patches while the
+kernel version stays the same. Use with caution.
+
+Lately we added kernel '.config' parser, a test can define a boolean
+expression of kernel config variables that has to be satisfied in order for a
+test to run. This is mostly used for kernel namespaces at the moment.
+
 Sometimes it also makes sense to define a few macros instead of creating
 configure test. One example are Linux specific POSIX clock ids in
 'include/lapi/posix_clocks.h'.
@@ -145,15 +171,14 @@ configure test. One example are Linux specific POSIX clock ids in
 1.6 Dealing with messed up legacy code
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-LTP contains a lot of old and messy code and we are cleaning it up as fast as
-we can but despite the efforts there is still a lot. If you start modifying
-old or a messed up testcase and your changes are more complicated than simple
-typo fixes you should do a cleanup first (in a separate patch). It's easier to
-review the changes if you separate the formatting fixes from the changes that
-affects the test behavior.
+LTP still contains a lot of old and messy code and we are cleaning it up as
+fast as we can but despite the decade of efforts there is still a lot. If you
+start modifying old or a messy testcase and your changes are more complicated
+than simple typo fixes you should convert the test into a new library first.
 
-The same goes for moving files. If you need a rename or move file do it in a
-separate patch.
+It's also much easier to review the changes if you split them into a smaller
+logical groups. The same goes for moving files. If you need a rename or move
+file do it in a separate patch.
 
 1.7 License
 ~~~~~~~~~~~
@@ -176,10 +201,11 @@ stdout and reports overall success/failure via the exit value.
 
 Tests are generally placed under the 'testcases/' directory. Everything that
 is a syscall or (slightly confusingly) libc syscall wrapper goes under
-'testcases/kernel/syscalls/'. Then there is 'testcases/open_posix_testsuite'
-which is a well maintained fork of the upstream project that has been dead
-since 2005 and also a number of directories with tests for more specific
-features.
+'testcases/kernel/syscalls/'.
+
+Then there is 'testcases/open_posix_testsuite' which is a well maintained fork
+of the upstream project that has been dead since 2005 and also a number of
+directories with tests for more specific features.
 
 2.1.1 Runtest Files
 ^^^^^^^^^^^^^^^^^^^
-- 
2.26.3

