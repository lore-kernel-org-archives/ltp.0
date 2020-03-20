From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Mar 2020 13:04:29 +0100
Subject: [LTP] [PATCH] syscalls/fspick: Call fsconfig with
 FSCONFIG_CMD_RECONFIGURE
In-Reply-To: <b392569b582f264927f2fea65bf14a89c03faaa5.1584679961.git.viresh.kumar@linaro.org>
References: <b392569b582f264927f2fea65bf14a89c03faaa5.1584679961.git.viresh.kumar@linaro.org>
Message-ID: <20200320120429.GA31021@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> Make sure mountpoint is reconfigured after all the recent changes by
> calling fsconfig() with FSCONFIG_CMD_RECONFIGURE.

Thanks, merged.

BTW how about print flag on failure? (just to improve readability, although
there are line numbers so not required).

Kind regards,
Petr

diff --git testcases/kernel/syscalls/fspick/fspick01.c testcases/kernel/syscalls/fspick/fspick01.c
index b5a35bf61..c84723805 100644
--- testcases/kernel/syscalls/fspick/fspick01.c
+++ testcases/kernel/syscalls/fspick/fspick01.c
@@ -33,19 +33,19 @@ static void run(unsigned int n)
 
 	TEST(fsconfig(fspick_fd, FSCONFIG_SET_STRING, "sync", "false", 0));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
 		goto out;
 	}
 
 	TEST(fsconfig(fspick_fd, FSCONFIG_SET_FLAG, "ro", NULL, 0));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_FLAG) failed");
 		goto out;
 	}
 
 	TEST(fsconfig(fspick_fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_RECONFIGURE) failed");
 		goto out;
 	}
 
