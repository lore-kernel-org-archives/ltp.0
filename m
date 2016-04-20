From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 20 Apr 2016 17:23:19 +0800
Subject: [LTP] [PATCH 3/3] syscalls/rt_sigqueueinfo01: Fix warnings by
	removing unused variables
In-Reply-To: <1461144199-29361-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1461144199-29361-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1461144199-29361-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
index 066d315..60757dd 100644
--- a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
@@ -68,7 +68,7 @@ void setup(void)
 	tst_tmpdir();
 }
 
-int main(int ac, char **av)
+int main(void)
 {
 	int status;
 	pid_t pid;
-- 
1.8.3.1



