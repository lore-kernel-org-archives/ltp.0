From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  3 Jun 2021 13:42:08 +0200
Subject: [LTP] [PATCH v2] doc: Modernize test-writing-guidelines
Message-ID: <20210603114208.8152-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---

v2: Shuffle the content around to make the document better organized.

 doc/test-writing-guidelines.txt | 199 ++++++++++++++++++++------------
 1 file changed, 127 insertions(+), 72 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 437239b97..ae8b2082f 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1,37 +1,105 @@
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
       https://github.com/linux-test-project/ltp/wiki/Shell-Test-API[Shell Test API],
       https://github.com/linux-test-project/ltp/wiki/LTP-Library-API-Writing-Guidelines[LTP Library API Writing Guidelines].
 
-1. General Rules
-----------------
+1. Guide to clean and understandable code
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-1.1 Simplicity
-~~~~~~~~~~~~~~
+For testcases it's required that the source code is as easy to follow as
+possible. When a test starts to fail the failure has to be analyzed, clean
+test codebase makes this task much easier and quicker.
+
+Here are some hints on how to write clean and understandable code, a few of
+these points are further discussed below:
+
+* First of all *Keep things simple*
+
+* Keep function and variable names short but descriptive
+
+* Keep functions reasonably short and focused on a single task
+
+* Do not overcomment
+
+* Be consistent
+
+* Avoid deep nesting
+
+* DRY
+
+
+1.1 Keep things simple
+~~~~~~~~~~~~~~~~~~~~~~
 
 For all it's worth keep the testcases simple or better as simple as possible.
+
 The kernel and libc are tricky beasts and the complexity imposed by their
 interfaces is quite high. Concentrate on the interface you want to test and
-follow the UNIX philosophy. It's a good idea to make the test as
-self-contained as possible too (it should not depend on tools or libraries
-that are not widely available).
+follow the UNIX philosophy.
+
+It's a good idea to make the test as self-contained as possible too, ideally
+tests should not depend on tools or libraries that are not widely available.
 
 Do not reinvent the wheel!
 
 * Use LTP standard interface
+
 * Do not add custom PASS/FAIL reporting functions
-* Do not write Makefiles from scratch,
-  use LTP build system instead, etc.
 
-1.2 Code duplication
-~~~~~~~~~~~~~~~~~~~~
+* Do not write Makefiles from scratch, use LTP build system instead
+
+* Etc.
+
+
+1.2 Keep functions and variable names short
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Choosing a good name for an API functions or even variables is a difficult
+task do not underestimate it.
+
+There are a couple of customary names for different things that help people to
+understand code, for example:
+
+* For loop variables are usually named with a single letter 'i', 'j', ...
+
+* File descriptors 'fd' or 'fd_foo'.
+
+* Number of bytes stored in file are usually named as 'size' or 'len'
+
+* Etc.
+
+1.3 Do not overcomment
+~~~~~~~~~~~~~~~~~~~~~~
+
+Comments can sometimes save you day but they can easily do more harm than
+good. There has been several cases where comments and actual implementation
+drifted slowly apart which yielded into API misuses and hard to find bugs.
+Remember there is only one thing worse than no documentation, wrong
+documentation.
+
+Ideally everybody should write code that is obvious, which unfortunately isn't
+always possible. If there is a code that requires to be commented keep it
+short and to the point. These comments should explain *why* and not *how*
+things are done.
+
+Never ever comment the obvious.
+
+In case of LTP testcases it's customary to add an asciidoc formatted comment
+paragraph with highlevel test description at the beginning of the file right
+under the GPL SPDX header. This helps other people to understand the overall
+goal of the test before they dive into the technical details. It's also
+exported into generated documentation hence it should mostly explain what is
+tested.
+
+1.4 DRY (Code duplication)
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Copy & paste is a good servant but very poor master. If you are about to copy a
 large part of the code from one testcase to another, think what would happen if
@@ -42,11 +110,11 @@ The same goes for short but complicated parts, whenever you are about to copy &
 paste a syscall wrapper that packs arguments accordingly to machine
 architecture or similarly complicated code, put it into a header instead.
 
-1.3 Coding style
-~~~~~~~~~~~~~~~~
+2 Coding style
+~~~~~~~~~~~~~~
 
-1.3.1 C coding style
-^^^^^^^^^^^^^^^^^^^^
+2.1 C coding style
+^^^^^^^^^^^^^^^^^^
 
 LTP adopted Linux kernel coding style. If you aren't familiar with its rules
 locate 'linux/Documentation/CodingStyle' in the kernel sources and read it,
@@ -55,13 +123,13 @@ it's a well written introduction.
 There is also
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl[checkpatch.pl]
 script from kernel git tree which can be used to check your patches before the
-submission.  Please use reasonably recent one.
+submission. Please use reasonably recent one.
 
 NOTE: If checkpatch.pl does not report any problems, the code still may be wrong
       as the tool only looks for common mistakes.
 
-1.3.2 Shell coding style
-^^^^^^^^^^^^^^^^^^^^^^^^
+2.2 Shell coding style
+^^^^^^^^^^^^^^^^^^^^^^
 
 When writing testcases in shell write in *portable shell* only, it's a good
 idea to try to run the test using alternative shell (alternative to bash, for
@@ -96,26 +164,9 @@ Here are some common sense style rules for shell
 
 * Be consistent
 
-1.4 Commenting code
-~~~~~~~~~~~~~~~~~~~
 
-Comments can sometimes save you day but they can easily do more harm than
-good. There has been several cases where comments and actual implementation
-were drifting slowly apart which yielded into API misuses and hard to find
-bugs. Remember there is only one thing worse than no documentation, wrong
-documentation.
-
-Generally everybody should write code that is obvious (which unfortunately
-isn't always possible). If there is a code that needs to be commented keep it
-short and to the point. Never ever comment the obvious.
-
-In case of LTP testcases it's customary to add a paragraph with highlevel test
-description somewhere at the beginning of the file (usually right under the GPL
-header). This helps other people to understand the overall goal of the test
-before they dive into the technical details.
-
-1.5 Backwards compatibility
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+3 Backwards compatibility
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 LTP test should be as backward compatible as possible. Think of an enterprise
 distributions with long term support (more than five years since the initial
@@ -124,50 +175,53 @@ toolchain supplied by the manufacturer.
 
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
+unfortunately kernel version does not always corresponds to a well defined
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
 
-1.6 Dealing with messed up legacy code
+3.1 Dealing with messed up legacy code
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
 
-1.7 License
-~~~~~~~~~~~
+4 License
+~~~~~~~~~
 
 Code contributed to LTP should be licensed under GPLv2+ (GNU GPL version 2 or
 any later version).
 
 Use `SPDX-License-Identifier: GPL-2.0-or-later`
 
-2. Writing a testcase
----------------------
-
-2.1 LTP Structure
-~~~~~~~~~~~~~~~~~
+5 LTP Structure
+~~~~~~~~~~~~~~~
 
 The structure of LTP is quite simple. Each test is a binary written either in
 portable shell or C. The test gets a configuration via environment variables
@@ -176,12 +230,13 @@ stdout and reports overall success/failure via the exit value.
 
 Tests are generally placed under the 'testcases/' directory. Everything that
 is a syscall or (slightly confusingly) libc syscall wrapper goes under
-'testcases/kernel/syscalls/'. Then there is 'testcases/open_posix_testsuite'
-which is a well maintained fork of the upstream project that has been dead
-since 2005 and also a number of directories with tests for more specific
-features.
+'testcases/kernel/syscalls/'.
+
+Then there is 'testcases/open_posix_testsuite/' which is a well maintained fork
+of the upstream project that has been dead since 2005 and also a number of
+directories with tests for more specific features.
 
-2.1.1 Runtest Files
+5.1 Runtest Files
 ^^^^^^^^^^^^^^^^^^^
 
 The list of tests to be executed is stored in runtest files under the
@@ -197,8 +252,8 @@ IMPORTANT: The runtest files should have one entry per a test. Creating a
            wrapper that runs all your tests and adding it as a single test
            into runtest file is strongly discouraged.
 
-2.1.2 Datafiles
-^^^^^^^^^^^^^^^
+5.2 Datafiles
+^^^^^^^^^^^^^
 
 If your test needs datafiles to work, these should be put into a subdirectory
 named 'datafiles' and installed into the 'testcases/data/$TCID' directory (to
@@ -228,8 +283,8 @@ The path is constructed according to these rules:
 
 See 'testcases/commands/file/' for example.
 
-2.1.3 Subexecutables
-^^^^^^^^^^^^^^^^^^^^
+5.3 Subexecutables
+^^^^^^^^^^^^^^^^^^
 
 If you test needs to execute a binary, place it in the same directory as the
 testcase and name the file starting with '${test_binary_name}_'.  Once the
@@ -239,7 +294,7 @@ binaries is added to the '$PATH' and you can execute it just by its name.
 TIP: If you need to execute such test from the LTP tree, you can add path to
      current directory to '$PATH' manually with: 'PATH="$PATH:$PWD" ./foo01'.
 
-3. Test Contribution Checklist
+6 Test Contribution Checklist
 ------------------------------
 
 NOTE: See also
@@ -252,7 +307,7 @@ NOTE: See also
 4. Test binaries are added into corresponding '.gitignore' files
 5. Patches apply over the latest git
 
-3.1 About .gitignore files
+6.1 About .gitignore files
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 There are numerous '.gitignore' files in the LTP tree. Usually there is a
-- 
2.26.3

