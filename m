From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Jun 2019 11:44:22 +0200
Subject: [LTP] [PATCH] [RFC] doc: Clarify what should be cleaned up at test
	end
Message-ID: <20190617094422.15846-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds a short paragraph that writes down previously unwritten rule
for resource cleanup.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Jan Stancek <jstancek@redhat.com>
---
 doc/test-writing-guidelines.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index f1912dc12..21223ba03 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -347,6 +347,14 @@ assigned a valid file descriptor. For most of the things you need to create
 extra flag that is set right after successful initialization though. Consider,
 for example, test setup below.
 
+We also prefer cleaning up resources that would otherwise be released on the
+program exit. There are two main reasons for this decision. Resources such as
+file descriptors and mmaped memory could block umounting a block device in
+cases where the test library has mounted a filesystem for the test temporary
+directory. Not freeing allocated memory would upset static analysis and tools
+such as valgrind and produce false-positives when checking for leaks in the
+libc and other low level libraries.
+
 [source,c]
 -------------------------------------------------------------------------------
 static int fd0, fd1, mount_flag;
-- 
2.19.2

