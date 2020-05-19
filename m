From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 May 2020 16:34:50 +0200
Subject: [LTP] [PATCH] lib/tst_test.c: Take account of
 tst_brk(TCONF)/tst_brk(TFAIL) in summary output
In-Reply-To: <20200518054335.12017-1-yangx.jy@cn.fujitsu.com>
References: <20200518054335.12017-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20200519143450.GF16008@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  lib/tst_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 0e58060e0..b28521a67 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -316,6 +316,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
>                 const char *fmt, va_list va)
>  {
>  	print_result(file, lineno, ttype, fmt, va);
> +	update_results(TTYPE_RESULT(ttype));
>  
>  	/*
>  	 * The getpid implementation in some C library versions may cause cloned

Good catch, but I guess that we should also remove the update_result()
call from the run_tcases_per_fs() after this.

And it also makes sense to call the function as a first thing in the
tst_res_/tst_brk_ function, which simplifies the code flow.

So I guess that we want something like this (not tested):

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 0e58060e0..9d0ef672d 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -278,8 +278,6 @@ void tst_vres_(const char *file, const int lineno, int ttype,
                const char *fmt, va_list va)
 {
        print_result(file, lineno, ttype, fmt, va);
-
-       update_results(TTYPE_RESULT(ttype));
 }
 
 void tst_vbrk_(const char *file, const int lineno, int ttype,
@@ -297,7 +295,6 @@ static void tst_cvres(const char *file, const int lineno, int ttype,
        }
 
        print_result(file, lineno, ttype, fmt, va);
-       update_results(TTYPE_RESULT(ttype));
 }
 
 static void do_test_cleanup(void)
@@ -337,6 +334,8 @@ void tst_res_(const char *file, const int lineno, int ttype,
 {
        va_list va;
 
+       update_results(TTYPE_RESULT(ttype));
+
        va_start(va, fmt);
        tst_vres_(file, lineno, ttype, fmt, va);
        va_end(va);
@@ -347,6 +346,8 @@ void tst_brk_(const char *file, const int lineno, int ttype,
 {
        va_list va;
 
+       update_results(TTYPE_RESULT(ttype));
+
        va_start(va, fmt);
        tst_brk_handler(file, lineno, ttype, fmt, va);
        va_end(va);
@@ -1316,10 +1317,8 @@ static int run_tcases_per_fs(void)
                        mntpoint_mounted = 0;
                }
 
-               if (ret == TCONF) {
-                       update_results(ret);
+               if (ret == TCONF)
                        continue;
-               }
 
                if (ret == 0)
                        continue;


-- 
Cyril Hrubis
chrubis@suse.cz
