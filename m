From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:02:58 +0100
Subject: [LTP] [PATCH 05/19] remove duplicate const in mremap05.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-6-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/syscalls/mremap/mremap05.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap05.c b/testcases/kernel/syscalls/mremap/mremap05.c
index d7e4e63e7..5e8cda5d7 100644
--- a/testcases/kernel/syscalls/mremap/mremap05.c
+++ b/testcases/kernel/syscalls/mremap/mremap05.c
@@ -53,7 +53,7 @@ struct test_case_t {
 	size_t old_size;	/* in pages */
 	size_t new_size;	/* in pages */
 	int flags;
-	const const char *msg;
+	const char *msg;
 	void *exp_ret;
 	int exp_errno;
 	char *ret;
-- 
2.13.6

