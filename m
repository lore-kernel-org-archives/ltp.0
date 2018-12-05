From: Li Wang <liwang@redhat.com>
Date: Wed, 5 Dec 2018 14:34:07 +0800
Subject: [LTP] [PATCH 2/2] lib: build check parameters for tst_brk()
In-Reply-To: <20181204173542.GD30799@dell5510>
References: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
 <d3ce5d3247f7f09cfabd288b40893bb631fb190f.1541710635.git.jstancek@redhat.com>
 <5BE4E95E.4000303@cn.fujitsu.com>
 <1582215982.71956713.1541786229415.JavaMail.zimbra@redhat.com>
 <20181204173542.GD30799@dell5510>
Message-ID: <CAEemH2cD71UjUJ-b3HeTyf58JSUCcb+iCo9Om9Vez=L7UYwKmg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Dec 5, 2018 at 1:35 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Jan,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> > > Perhaps, we could add some hints about the invalid ttype.
> > > e.g. "tst_brk(): invalid type, please use TBROK/TCONF/TFAIL"
>
> > Do you have suggestion how to achieve that?
>
> > There's an __attribute__(error), but it's supported only from gcc 4.3 as I recall.
> Do you mean __attribute__ format?
>
> > Alternative would be link time failure, with a symbol name suggesting what went wrong.
> Not sure, how exactly you want to do it, but seems to be more portable than
> requiring specific gcc version (although 4.3 is very old and __attribute__
> format is supported by clang as well).

I took an rough look at the kernel method, maybe we can achieve that
conditionally?

--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -65,4 +65,23 @@
        ERET;                                                           \
 })

+#define GCC_VERSION (__GNUC__ * 10000          \
+                    + __GNUC_MINOR__ * 100     \
+                    + __GNUC_PATCHLEVEL__)
+
+#if GCC_VERSION >= 40300
+# define BUILD_BUG_ON_MSG(cond, msg) \
+       compiletime_assert(!(cond), msg, tst_brk_detect_)
+# define compiletime_assert(condition, msg, funcname_)         \
+       do {                                                    \
+               void funcname_(void) __attribute__((error(msg)));  \
+               if (!(condition))                               \
+                       funcname_();                            \
+       } while (0)
+#else
+# define BUILD_BUG_ON_MSG(cond, msg) BUILD_BUG_ON(cond)
+# define BUILD_BUG_ON(cond) \
+       do { ((void)sizeof(char[1 - 2 * !!(cond)])); } while (0)
+#endif
+
 #endif /* TST_COMMON_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 2ebf746..03f3789 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -69,8 +69,12 @@ void tst_brk_(const char *file, const int lineno, int ttype,
               const char *fmt, ...)
               __attribute__ ((format (printf, 4, 5)));

-#define tst_brk(ttype, arg_fmt, ...) \
-       tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
+#define tst_brk(ttype, arg_fmt, ...)
         \
+       ({
         \
+               BUILD_BUG_ON_MSG(!((ttype) & (TBROK | TCONF | TFAIL)), \
+                               "tst_brk(): invalid type, please use
TBROK/TCONF/TFAIL"); \
+               tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt),
##__VA_ARGS__);\
+       })

 /* flush stderr and stdout */
 void tst_flush(void);

-- 
Regards,
Li Wang
