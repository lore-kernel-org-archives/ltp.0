From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Nov 2020 15:54:41 +0100
Subject: [LTP] [PATCH 1/2] syscalls/uname{01,
 03}: Convert to new API and cleanup
In-Reply-To: <20201106065014.1118435-1-yangx.jy@cn.fujitsu.com>
References: <20201106065014.1118435-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20201111145441.GB16874@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with diff:

diff --git a/testcases/kernel/syscalls/uname/uname01.c b/testcases/kernel/syscalls/uname/uname01.c
index 37722947f..bd3b05303 100644
--- a/testcases/kernel/syscalls/uname/uname01.c
+++ b/testcases/kernel/syscalls/uname/uname01.c
@@ -24,6 +24,12 @@ static void verify_uname(void)
                return;
        }
 
+       if (TST_RET != 0) {
+               tst_res(TFAIL | TTERRNO,
+                       "uname() returned invalid value %ld", TST_RET);
+               return;
+       }
+
        if (strcmp(un.sysname, "Linux")) {
                tst_res(TFAIL, "sysname is not Linux");
                return;


Also I guess that we can check the hostname against gethostname(), but that can
be added in follow up patch, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
