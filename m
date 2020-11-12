From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Nov 2020 11:17:26 +0100
Subject: [LTP] [PATCH v2 2/2] syscalls/uname02: Convert to new API and
 cleanup
In-Reply-To: <20201112012613.1426897-1-yangx.jy@cn.fujitsu.com>
References: <20201111145733.GC16874@yuki.lan>
 <20201112012613.1426897-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20201112101726.GA11365@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

I've added a check for the invalid return value and got rid of the cast
since void* does not need it.

diff --git a/testcases/kernel/syscalls/uname/uname02.c b/testcases/kernel/syscalls/uname/uname02.c
index 09c26939e..1903dae24 100644
--- a/testcases/kernel/syscalls/uname/uname02.c
+++ b/testcases/kernel/syscalls/uname/uname02.c
@@ -16,12 +16,17 @@ static void *bad_addr;

 static void verify_uname(void)
 {
-       TEST(uname((struct utsname *)bad_addr));
+       TEST(uname(bad_addr));
        if (TST_RET == 0) {
                tst_res(TFAIL, "uname() succeed when failure expected");
                return;
        }

+       if (TST_RET != -1) {
+               tst_res(TFAIL, "Invalid uname() return value %ld", TST_RET);
+               return;
+       }
+
        if (TST_ERR == EFAULT)
                tst_res(TPASS, "uname() got EFAULT as expected");
        else


-- 
Cyril Hrubis
chrubis@suse.cz
