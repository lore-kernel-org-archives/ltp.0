From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 20 May 2020 10:02:53 +0800
Subject: [LTP] [PATCH] lib/tst_test.c: Take account of
 tst_brk(TCONF)/tst_brk(TFAIL) in summary output
In-Reply-To: <20200519143450.GF16008@yuki.lan>
References: <20200518054335.12017-1-yangx.jy@cn.fujitsu.com>
 <20200519143450.GF16008@yuki.lan>
Message-ID: <5EC48FCD.9050600@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/5/19 22:34, Cyril Hrubis wrote:
> Hi!
>>   lib/tst_test.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/tst_test.c b/lib/tst_test.c
>> index 0e58060e0..b28521a67 100644
>> --- a/lib/tst_test.c
>> +++ b/lib/tst_test.c
>> @@ -316,6 +316,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
>>                  const char *fmt, va_list va)
>>   {
>>   	print_result(file, lineno, ttype, fmt, va);
>> +	update_results(TTYPE_RESULT(ttype));
>>
>>   	/*
>>   	 * The getpid implementation in some C library versions may cause cloned
>
> Good catch, but I guess that we should also remove the update_result()
> call from the run_tcases_per_fs() after this.
Hi Cyril,

Agreed.  I missed redundant update_result() in run_tcases_per_fs() after 
this change.

>
> And it also makes sense to call the function as a first thing in the
> tst_res_/tst_brk_ function, which simplifies the code flow.

It is actually simpler but it changes the original logic of tst_cvres() 
called by tst_brk(TBROK) in cleanup().
Before change, tst_cvres() changes TBROK to TWARN and then saves TWARN 
into summary output:
----------------------------------
e.g. Add some debug code in preadv01:
[root@Fedora-30 preadv]# ./preadv01
tst_buffers.c:55: INFO: Test is using guarded buffers
tst_test.c:1244: INFO: Timeout per run is 0h 05m 00s
preadv01.c:80: PASS: Preadv(2) read 64 bytes successfully with content 
'a' expectedly
preadv01.c:80: PASS: Preadv(2) read 64 bytes successfully with content 
'a' expectedly
preadv01.c:80: PASS: Preadv(2) read 32 bytes successfully with content 
'b' expectedly
preadv01.c:99: WARN: test

Summary:
passed   3
failed   0
skipped  0
warnings 1
----------------------------------
After change, tst_cvres() changes TBROK to TWARN but doesn't save TWARN 
into summary output:
----------------------------------
e.g. Add some debug code in preadv01:
[root@Fedora-30 preadv]# ./preadv01
tst_buffers.c:55: INFO: Test is using guarded buffers
tst_test.c:1245: INFO: Timeout per run is 0h 05m 00s
preadv01.c:80: PASS: Preadv(2) read 64 bytes successfully with content 
'a' expectedly
preadv01.c:80: PASS: Preadv(2) read 64 bytes successfully with content 
'a' expectedly
preadv01.c:80: PASS: Preadv(2) read 32 bytes successfully with content 
'b' expectedly
preadv01.c:99: WARN: test

Summary:
passed   3
failed   0
skipped  0
warnings 0
----------------------------------

I perfer to add a update_results() in tst_vbrk_(), do you think so?

Best Regards,
Xiao Yang
>
> So I guess that we want something like this (not tested):
>
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 0e58060e0..9d0ef672d 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -278,8 +278,6 @@ void tst_vres_(const char *file, const int lineno, int ttype,
>                  const char *fmt, va_list va)
>   {
>          print_result(file, lineno, ttype, fmt, va);
> -
> -       update_results(TTYPE_RESULT(ttype));
>   }
>
>   void tst_vbrk_(const char *file, const int lineno, int ttype,
> @@ -297,7 +295,6 @@ static void tst_cvres(const char *file, const int lineno, int ttype,
>          }
>
>          print_result(file, lineno, ttype, fmt, va);
> -       update_results(TTYPE_RESULT(ttype));
>   }
>
>   static void do_test_cleanup(void)
> @@ -337,6 +334,8 @@ void tst_res_(const char *file, const int lineno, int ttype,
>   {
>          va_list va;
>
> +       update_results(TTYPE_RESULT(ttype));
> +
>          va_start(va, fmt);
>          tst_vres_(file, lineno, ttype, fmt, va);
>          va_end(va);
> @@ -347,6 +346,8 @@ void tst_brk_(const char *file, const int lineno, int ttype,
>   {
>          va_list va;
>
> +       update_results(TTYPE_RESULT(ttype));
> +
>          va_start(va, fmt);
>          tst_brk_handler(file, lineno, ttype, fmt, va);
>          va_end(va);
> @@ -1316,10 +1317,8 @@ static int run_tcases_per_fs(void)
>                          mntpoint_mounted = 0;
>                  }
>
> -               if (ret == TCONF) {
> -                       update_results(ret);
> +               if (ret == TCONF)
>                          continue;
> -               }
>
>                  if (ret == 0)
>                          continue;
>
>



