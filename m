From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 19 Sep 2017 09:42:44 +0800
Subject: [LTP] [PATCH v2] syscalls/clone09.c: add kernel version check
In-Reply-To: <20170720121717.GG32092@rei>
References: <20170720121717.GG32092@rei>
Message-ID: <1505785364-22465-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) On all kernels which support CONFIG_NET_NS, clone(2) only could return
   EINVAL due to disabled CONFIG_NET_NS instead of unknown flags.  Please
   see the following kernel code in net/core/net_namespace.c:
   --------------------------------------------------------------------
   struct net *copy_net_ns(unsigned long flags, struct net *old_net)
   ...
        #ifndef CONFIG_NET_NS
                return ERR_PTR(-EINVAL);
        #endif
   --------------------------------------------------------------------

   The support is introduced in kernel:
   '9dd776b ("[NET]: Add network namespace clone & unshare support.")'

2) Usually, a syscall flags should always include a check of the following
   form in its implementation:
   ---------------------------------
   if (flags & ~(FL_XXX | FL_YYY))
        return -EINVAL;
   ---------------------------------

   This check could verify unknown flags, but clone(2) does not have the
   check and just returns 0, this issue has been around for several years,
   and it is hardly to be fixed since doing so would break existing applications.

   Please see the following URL for detailed information:
   https://lwn.net/Articles/588444/

   It is hard to make out whether CLONE_NEWNET is supported or not by
   returned value and errno.

   According to above reasons and clone()'s manpage, i think we should
   add kernel version check to skip this case on an old kernel and update
   description about EINVAL.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/clone/clone09.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/clone/clone09.c b/testcases/kernel/syscalls/clone/clone09.c
index 1528be4..a6ebdd7 100644
--- a/testcases/kernel/syscalls/clone/clone09.c
+++ b/testcases/kernel/syscalls/clone/clone09.c
@@ -57,7 +57,7 @@ static long clone_child(void)
 	TEST(ltp_clone(flags, newnet, NULL, CHILD_STACK_SIZE, child_stack));
 
 	if (TEST_RETURN == -1 && TEST_ERRNO == EINVAL)
-		tst_brk(TCONF, "CLONE_NEWNET not supported, CONFIG_NET_NS?");
+		tst_brk(TCONF, "CONFIG_NET_NS was disabled");
 
 	if (TEST_RETURN == -1)
 		tst_brk(TBROK | TTERRNO, "clone(CLONE_NEWNET) failed");
@@ -100,4 +100,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.min_kver = "2.6.24",
 };
-- 
1.8.3.1



