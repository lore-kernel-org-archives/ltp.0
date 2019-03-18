From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Mar 2019 15:22:06 +0100
Subject: [LTP] [PATCH v2] Test ioctl syscall for NS_GET_* requests
In-Reply-To: <20190311072537.22080-1-fedebonfi95@gmail.com>
References: <20190304161602.GB15696@rei>
 <20190311072537.22080-1-fedebonfi95@gmail.com>
Message-ID: <20190318142206.GA18993@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks Cyril for your review. I hope this one is better, also I could't use 
> SAFE_IOCTL because compilations fails this way:
> 
> ioctl_ns06.c: In function 'run':
> ioctl_ns06.c:46:13: error: void value not ignored as it ought to be
>    parent_fd = SAFE_IOCTL(child_fd, NS_GET_PARENT);
>              ^
> <builtin>: recipe for target 'ioctl_ns06' failed
> make: *** [ioctl_ns06] Error 1
> 
> I need the return value since it's the process pid. Am I doing somthing wrong
> with this safe call?

There is actually a bug in the macro, this patch should fix it:

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index b63e7493a..04aedb39a 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -221,7 +221,7 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid);
        ({int tst_ret_ = ioctl(fd, request, ##__VA_ARGS__);  \
          tst_ret_ < 0 ?                                     \
           tst_brk(TBROK | TERRNO,                           \
-                   "ioctl(%i,%s,...) failed", fd, #request) \
+                   "ioctl(%i,%s,...) failed", fd, #request), 0 \
         : tst_ret_;})

I will send a patch fixing that.

-- 
Cyril Hrubis
chrubis@suse.cz
