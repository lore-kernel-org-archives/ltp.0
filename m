From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Jun 2020 16:24:55 +0200
Subject: [LTP] [PATCH 1/2] syscalls/pidfd_open01.c: Add check for
 close-on-exec flag
In-Reply-To: <20200505032803.s6axol3sfyyzl6ag@vireshk-i7>
References: <20200430085742.1663-1-yangx.jy@cn.fujitsu.com>
 <20200504050937.oassdcfg4x5zh4nm@vireshk-i7>
 <e666a91d-1ffd-0f5f-131e-966ff763b14e@163.com>
 <20200505032803.s6axol3sfyyzl6ag@vireshk-i7>
Message-ID: <20200612142455.GA2310@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > > +
> > > > +	pidfd = pidfd_open(getpid(), 0);
> > > > +	if (pidfd == -1)
> > > > +		tst_brk(TFAIL | TERRNO, "pidfd_open(getpid(), 0) failed");
> > > This could have been written as:
> > >          TEST(pidfd = pidfd_open(getpid(), 0));
> > 
> > Why do you want to keep TEST()? I don't think it is necessary:
> > 
> > 1) pidfd and TERRNO are enough to check return value and errno.
> > 
> > 2) It is OK for testcase to not use TEST().
> 
> As far as I have understood, that is the preferred way of doing it
> from LTP maintainers.
> 
> Over that it was already there, why remove it now ? Just fix the
> problems you are trying to fix and that should be good.

I do not care that much if the test uses the macro or not, but you should
really keep changes separate from the removal of the kernel minimal version.

Also I guess that we can supress the warning by a cast in the SAFE_FCNTL()
macro so that we can pass long there.

This should do:

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index c39d8768b..c153f163c 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -215,14 +215,14 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid);
        ({int tst_ret_ = ioctl(fd, request, ##__VA_ARGS__);  \
          tst_ret_ < 0 ?                                     \
           tst_brk(TBROK | TERRNO,                           \
-                   "ioctl(%i,%s,...) failed", fd, #request), 0 \
+                   "ioctl(%i,%s,...) failed", (int)fd, #request), 0 \
         : tst_ret_;})
 
 #define SAFE_FCNTL(fd, cmd, ...)                            \
        ({int tst_ret_ = fcntl(fd, cmd, ##__VA_ARGS__);     \
          tst_ret_ == -1 ?                                  \
           tst_brk(TBROK | TERRNO,                          \
-                   "fcntl(%i,%s,...) failed", fd, #cmd), 0 \
+                   "fcntl(%i,%s,...) failed", (int)fd, #cmd), 0 \
         : tst_ret_;})


-- 
Cyril Hrubis
chrubis@suse.cz
