From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Jan 2018 14:06:05 +0100
Subject: [LTP] [RFC] [PATCH] fs/doio: Increase the MAX_FNAME_LENGTH
Message-ID: <20180123130605.7702-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As per request in:

https://github.com/linux-test-project/ltp/issues/234

This commit increases the limit on file path so that the test works with
slightly longer paths as well.

Note that we compose absolute path in the parse_opts() in the iogen.c
which is blindly copied into an array of size of MAX_FNAME_LENGTH which
obviously crashes if PWD + filename lenght were longer than 128 bytes.

BEWARE: apparenlty these structures are piped from genio to doio when
        rwtest is invoked and because of theat all the structures that
	use MAX_FNAME_LENGHT must fit into PIPE_BUF. The PIPE_BUF is
	4k on Linux, hence we can bump the max path size safely to 4000
	bytes.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/fs/doio/doio.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/doio/doio.h b/testcases/kernel/fs/doio/doio.h
index 28c4feb42..27f601eef 100644
--- a/testcases/kernel/fs/doio/doio.h
+++ b/testcases/kernel/fs/doio/doio.h
@@ -129,7 +129,15 @@
  *		This is an allowed assumption in C.
  */
 
-#define MAX_FNAME_LENGTH    128
+/*
+ * All the structures below _MUST_ fit into PIPE_BUF in size otherwise
+ * piping the genio to doio will result in data corruption and failure.
+ *
+ * For Linux where the PIPE_BUF is 4k we can safely bump the maximal filename
+ * lenght to 4000 which leavs 96 bytes for the rest of the structure members,
+ * which should be more than enough.
+ */
+#define MAX_FNAME_LENGTH    4000
 
 struct read_req {
     char    r_file[MAX_FNAME_LENGTH];
-- 
2.13.6

