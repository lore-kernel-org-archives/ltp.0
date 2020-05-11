From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 11 May 2020 12:19:29 +0530
Subject: [LTP] [PATCH V2 15/17] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <CAK8P3a1x+uK_WgVn9O8LVcLoZH=oJ_jQcePwcwzqpyhewApX9w@mail.gmail.com>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <8a675726b6e553e740016390c774bce19efc5a12.1588911607.git.viresh.kumar@linaro.org>
 <CAK8P3a1x+uK_WgVn9O8LVcLoZH=oJ_jQcePwcwzqpyhewApX9w@mail.gmail.com>
Message-ID: <20200511064929.pa4lydt2vfryl7ve@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08-05-20, 09:18, Arnd Bergmann wrote:
> It feels like this is more complicated than it need to be. The line
> 
> semtimedop = sys_semtimedop, .type = TST_KERN_OLD_TIMESPEC, .desc =
> "semtimedop: syscall with kernel spec32"},
> 
> should apply to any kernel that has "__NR_semtimedop !=
> __LTP__NR_INVALID_SYSCALL",
> regardless of any other macros set, and then you don't need the separate line
> 
> { .semtimedop = sys_semtimedop, .type = TST_KERN_TIMESPEC, .desc =
> "semtimedop: syscall with kernel spec64"},
> 
> which is not what the ABI is meant to be anyway (sys_semtimedop takes
> a __kernel_old_timespec,
> not a __kernel_timespec).
> 
> Similarly, the line
> 
>  { .semop = semop, .type = TST_LIBC_TIMESPEC, .desc = "semop: vDSO or syscall"},
> 
> should apply to both 32 and 64 bit machines

This is how I modified this and all other time64 tests, I hope this looks fine now ?

diff --git a/testcases/kernel/syscalls/ipc/semop/semop.h b/testcases/kernel/syscalls/ipc/semop/semop.h
index 8d1245b65ec0..8647fa686bd3 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop.h
+++ b/testcases/kernel/syscalls/ipc/semop/semop.h
@@ -26,17 +26,13 @@ struct test_variants {
        char *desc;
 } variants[] = {
        { .semop = semop, .type = TST_LIBC_TIMESPEC, .desc = "semop: vDSO or syscall"},
-#if defined(TST_ABI32)
-       { .semtimedop = sys_semtimedop, .type = TST_LIBC_TIMESPEC, .desc = "semtimedop: syscall with libc spec"},
-       { .semtimedop = sys_semtimedop, .type = TST_KERN_OLD_TIMESPEC, .desc = "semtimedop: syscall with kernel spec32"},
-#endif
 
-#if defined(TST_ABI64)
-       { .semtimedop = sys_semtimedop, .type = TST_KERN_TIMESPEC, .desc = "semtimedop: syscall with kernel spec64"},
+#if (__NR_semtimedop != __LTP__NR_INVALID_SYSCALL)
+       { .semtimedop = sys_semtimedop, .type = TST_KERN_OLD_TIMESPEC, .desc = "semtimedop: syscall with old kernel spec"},
 #endif
 
 #if (__NR_semtimedop_time64 != __LTP__NR_INVALID_SYSCALL)
-       { .semtimedop = sys_semtimedop_time64, .type = TST_KERN_TIMESPEC, .desc = "semtimedop: syscall time64 with kernel spec64"},
+       { .semtimedop = sys_semtimedop_time64, .type = TST_KERN_TIMESPEC, .desc = "semtimedop: syscall time64 with kernel spec"},
 #endif
 };

-- 
viresh
