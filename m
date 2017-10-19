From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 19 Oct 2017 14:09:26 +0800
Subject: [LTP] [PATCH v2] syscalls/keyctl06: Accept two kinds of return
	values for the time being
In-Reply-To: <20171018171912.GA126485@gmail.com>
References: <20171018171912.GA126485@gmail.com>
Message-ID: <1508393366-13754-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The documented behavior of keyctl_read() is to return the full count
which is the size of buffer required.

After commit e645016abc80, keyctl_read() changs the behavior and returns
the short count which is the size of data read into buffer.

This issue is introduced by commit e645016abc80, and needs to be fixed.

For now we just accept both return values, and will accept only the full
return value as soon as the fix patch has been applied.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/keyctl/keyctl06.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl06.c b/testcases/kernel/syscalls/keyctl/keyctl06.c
index 8873431..0de70d2 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl06.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl06.c
@@ -55,7 +55,8 @@ static void do_test(void)
 	if (key_ids[0] != key_id_1 && key_ids[0] != key_id_2)
 		tst_brk(TBROK, "KEYCTL_READ didn't return correct key ID");
 
-	if (TEST_RETURN != sizeof(key_serial_t)) {
+	if (TEST_RETURN != sizeof(key_serial_t) &&
+	    TEST_RETURN != sizeof(key_ids)) {
 		tst_brk(TBROK, "KEYCTL_READ returned %ld but expected %zu",
 			TEST_RETURN, sizeof(key_serial_t));
 	}
-- 
1.8.3.1



