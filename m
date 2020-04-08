From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed,  8 Apr 2020 11:06:35 +0200
Subject: [LTP] [PATCH 2/2] add_key05: Correct formatting
In-Reply-To: <20200408090635.4686-1-rpalethorpe@suse.com>
References: <20200408090635.4686-1-rpalethorpe@suse.com>
Message-ID: <20200408090635.4686-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use checkpatch.pl

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/add_key/add_key05.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
index 5691b8579..d83339048 100644
--- a/testcases/kernel/syscalls/add_key/add_key05.c
+++ b/testcases/kernel/syscalls/add_key/add_key05.c
@@ -118,8 +118,8 @@ static void verify_max_btyes(void)
 	plen = max_bytes - used_bytes - delta - strlen("test_xxx") - 1;
 	TEST(add_key("user", "test_max", buf, plen, KEY_SPEC_THREAD_KEYRING));
 	if (TST_RET == -1) {
-		 tst_res(TFAIL | TTERRNO, "add_key(test_max) failed unexpectedly");
-		 return;
+		tst_res(TFAIL | TTERRNO, "add_key(test_max) failed unexpectedly");
+		return;
 	}
 
 	tst_res(TPASS, "add_key(test_max) succeeded as expected");
-- 
2.24.0

