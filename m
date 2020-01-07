From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jan 2020 13:02:24 +0100
Subject: [LTP] [PATCH 1/2] syscalls/capget01: Cleanup & convert to new
 library
In-Reply-To: <1576049159-14014-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1576049159-14014-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200107120224.GA26408@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with following changes:

diff --git a/testcases/kernel/syscalls/capget/capget01.c b/testcases/kernel/syscalls/capget/capget01.c
index 743e307c5..bc8bd7ce7 100644
--- a/testcases/kernel/syscalls/capget/capget01.c
+++ b/testcases/kernel/syscalls/capget/capget01.c
@@ -31,18 +31,18 @@ static void verify_capget(unsigned int n)
                .pid = pid,
        };
 
-       struct __user_cap_data_struct data;
+       struct __user_cap_data_struct data[2];
 
        tst_res(TINFO, "%s", tc->message);
 
-       TEST(tst_syscall(__NR_capget, &hdr, &data));
+       TEST(tst_syscall(__NR_capget, &hdr, data));
        if (TST_RET == 0)
                tst_res(TPASS, "capget() returned %ld", TST_RET);
        else
                tst_res(TFAIL | TTERRNO, "Test Failed, capget() returned %ld",
                                TST_RET);
 
-       if (data.effective & 1 << CAP_NET_RAW)
+       if (data[0].effective & 1 << CAP_NET_RAW)
                tst_res(TFAIL, "capget() gets CAP_NET_RAW unexpectedly in pE");
        else
                tst_res(TPASS, "capget() doesn't get CAP_NET_RAW as expected in PE");


The version 2 and 3 are 64 bit capabilities, hence we have to pass array of cap_struct_data instead.

Otherwise this is a nice improvement on the testcase, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
