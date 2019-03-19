From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Mar 2019 14:56:47 +0100
Subject: [LTP] [PATCH v3 3/3] syscalls/tgkill03: add new test
In-Reply-To: <1552978181-27748-4-git-send-email-sumit.garg@linaro.org>
References: <1552978181-27748-1-git-send-email-sumit.garg@linaro.org>
 <1552978181-27748-4-git-send-email-sumit.garg@linaro.org>
Message-ID: <20190319135647.GI6204@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've added one more ESRCH case here:

diff --git a/testcases/kernel/syscalls/tgkill/tgkill03.c b/testcases/kernel/syscalls/tgkill/tgkill03.c
index b78e9d95a..f5bbdc5a8 100644
--- a/testcases/kernel/syscalls/tgkill/tgkill03.c
+++ b/testcases/kernel/syscalls/tgkill/tgkill03.c
@@ -76,7 +76,8 @@ static const struct testcase {
        { "Invalid tgid", &invalid_pid, &parent_tid, SIGUSR1, EINVAL },
        { "Invalid tid", &parent_tgid, &invalid_pid, SIGUSR1, EINVAL },
        { "Invalid signal", &parent_tgid, &parent_tid, -1, EINVAL },
-       { "Defunct thread ID", &parent_tgid, &defunct_tid, SIGUSR1, ESRCH },
+       { "Defunct tid", &parent_tgid, &defunct_tid, SIGUSR1, ESRCH },
+       { "Defunct tgid", &defunct_tid, &child_tid, SIGUSR1, ESRCH },
        { "Valid tgkill call", &parent_tgid, &child_tid, SIGUSR1, 0 },
 };


-- 
Cyril Hrubis
chrubis@suse.cz
