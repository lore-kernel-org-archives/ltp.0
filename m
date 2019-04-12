From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Apr 2019 16:33:19 +0200
Subject: [LTP] [PATCH v5] Test ioctl syscall for NS_GET_* requests
In-Reply-To: <20190411192534.30525-1-fedebonfi95@gmail.com>
References: <20190403152245.GC26464@rei.lan>
 <20190411192534.30525-1-fedebonfi95@gmail.com>
Message-ID: <20190412143318.GA29856@haruka.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> About the unshare call, I removed it entirely since placing it in the setup() caused: 
> 
> ioctl_ns05.c:35: BROK: fork() failed: ENOMEM
> 
> This seems to originate from the fact that unsharing in setup didn't make the testing framework reap forked processes correctly, since every forked test run after the setup thinks to have pid 0. So when it checks if the pid is different from the initial pid (also 0) it finds them equal. This is of course as I understood the problem, and being a beginner with the framework I'm not entirely sure.
> 
> To solve the issue I did what I was doing in ioctl_ns06.c (ex number 7), directly calling clone() and not unshare() and then fork().
> 
> Let me know if you like this solution, and thanks again

Applied with a minor change, thanks.

The comment in ioctl_ns05.c was speaking about unshare so I changed it to:

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
index 5d89c03b0..add6980bb 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
@@ -6,10 +6,9 @@
 /*
  * Test ioctl_ns with NS_GET_PARENT request.
  *
- * After the call to unshare with the CLONE_NEWPID flag,
- * next new child is created in a new pid namespace. That's checked by
- * comparing its /proc/self/ns/pid symlink and the parent's one.
- * Also child thinks its pid is 1.
+ * Child cloned with the CLONE_NEWPID flag is created in a new pid namespace.
+ * That's checked by comparing its /proc/self/ns/pid symlink and the parent's
+ * one. Also child thinks its pid is 1.
  *
  */
 #define _GNU_SOURCE


-- 
Cyril Hrubis
chrubis@suse.cz
