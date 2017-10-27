From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 27 Oct 2017 17:00:23 +0800
Subject: [LTP] [PATCH v3] syscalls/keyctl06: Fix return value
In-Reply-To: <20171018171912.GA126485@gmail.com>
References: <20171018171912.GA126485@gmail.com>
Message-ID: <1509094823-5455-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If the user-supplied buffer is too small, the documented behavior of
keyctl_read() is to return the full count which is the size of buffer
required.  However, commit e645016abc80 ("KEYS: fix writing past end
of user-supplied buffer in keyring_read()") changs the behavior and
returns the short count which is the size of data read into buffer.

This issue was introduced by commit e645016abc80, and will be fixed by
the following patch:
http://www.spinics.net/lists/keyrings/msg03183.html

We should return the full count rather than the short count.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/keyctl/keyctl06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl06.c b/testcases/kernel/syscalls/keyctl/keyctl06.c
index 8873431..c1b8d77 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl06.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl06.c
@@ -55,7 +55,7 @@ static void do_test(void)
 	if (key_ids[0] != key_id_1 && key_ids[0] != key_id_2)
 		tst_brk(TBROK, "KEYCTL_READ didn't return correct key ID");
 
-	if (TEST_RETURN != sizeof(key_serial_t)) {
+	if (TEST_RETURN != sizeof(key_ids)) {
 		tst_brk(TBROK, "KEYCTL_READ returned %ld but expected %zu",
 			TEST_RETURN, sizeof(key_serial_t));
 	}
-- 
1.8.3.1



