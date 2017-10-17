From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 17 Oct 2017 20:53:12 +0800
Subject: [LTP] [PATCH] syscalls/keyctl06: Print TFAIL if keyring_read()
	returns wrong size
Message-ID: <1508244792-10109-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

According to keyctl06's message, the mentioned bug is introduced
by the following patch which is merged into kernel since v3.13:
'b2a4df200d57 ("KEYS: Expand the capacity of a keyring")'

However, we still got the following output before v3.13:
 tst_test.c:958: INFO: Timeout per run is 0h 05m 00s
 keyctl06.c:60: BROK: KEYCTL_READ returned 8 but expected 4

In old kernels, the output exposed that keyring_read() could not
return the size of data read into buffer, because it just returned
the size of a keyring.  So i think this issue should be targeted
as TFAIL.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/keyctl/keyctl06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl06.c b/testcases/kernel/syscalls/keyctl/keyctl06.c
index 8873431..bf30fb6 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl06.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl06.c
@@ -56,7 +56,7 @@ static void do_test(void)
 		tst_brk(TBROK, "KEYCTL_READ didn't return correct key ID");
 
 	if (TEST_RETURN != sizeof(key_serial_t)) {
-		tst_brk(TBROK, "KEYCTL_READ returned %ld but expected %zu",
+		tst_brk(TFAIL, "KEYCTL_READ returned %ld but expected %zu",
 			TEST_RETURN, sizeof(key_serial_t));
 	}
 
-- 
1.8.3.1



