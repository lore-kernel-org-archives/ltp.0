From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Mon, 30 Aug 2021 14:35:31 +0800
Subject: [LTP] [PATCH] tst_test_macros.h: Add TST_EXP_VAL macro
In-Reply-To: <CAEemH2eVmWa-D+joV6E1F8RwYvrao-GK+jjU-+g6kyQOhhOSXg@mail.gmail.com>
References: <20210827023042.26143-1-zhanglianjie@uniontech.com>
 <CAEemH2eVmWa-D+joV6E1F8RwYvrao-GK+jjU-+g6kyQOhhOSXg@mail.gmail.com>
Message-ID: <0bbec91d-0224-0e3a-7c24-f61b591f7782@uniontech.com>+8CB652FAC992B520
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

For example, it is necessary to determine whether TST_RET and child_pid 
are equal :

TST_EXP_POSITIVE(ltp_clone(SIGCHLD, child_fn, NULL, CHILD_STACK_SIZE, 
 

               child_stack));

TST_EXP_PASS(!(TST_RET == child_pid), "pid(%d)", child_pid);

Can be changed to:

TST_EXP_VAL(TST_RET, child_pid);



On 2021-08-27 17:27, Li Wang wrote:
> Hi Lianjie,
> 
> Some queries:
> 
> Do we have test scenarios?for making use of these macros?
> 
> And can you write a test to verify the macros you added at the same time?
> (just like what we had done in test_macros0*.c)
> 
> Btw, you should keep the code indent consistent with the original.
> (especially for backlash \)
I will resubmit and add a test_macros0*.c.
> 
> 
> On Fri, Aug 27, 2021 at 10:31 AM zhanglianjie 
> <zhanglianjie@uniontech.com <mailto:zhanglianjie@uniontech.com>> wrote:
> 
>     Add TST_EXP_VAL to determine whether the return value
>     is equal to the given value.
> 
>     Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com
>     <mailto:zhanglianjie@uniontech.com>>
> 
>     diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
>     index 50598aa15..d23455362 100644
>     --- a/include/tst_test_macros.h
>     +++ b/include/tst_test_macros.h
>     @@ -132,6 +132,34 @@ extern void *TST_RET_PTR;
>      ? ? ? ? ? ? ? ? ? ? ? ? TST_MSG_(TPASS, " passed", #SCALL,
>     ##__VA_ARGS__);? ? ?\
>      ? ? ? ? } while (0)                                               
>      ? ? ? ? ? ? \
> 
>     +
>     +#define TST_EXP_VAL_SILENT_(SCALL, SSCALL, VAL, ...)               
>      ? ? \
>     +? ? ? ?do {                                                       
>      ? ? ? ? \
>     +? ? ? ? ? ? ? ?TEST(SCALL);                                       
>      ? ? ? ? ? ? \
>     +                                                                   
>      ? ? \
>     +? ? ? ? ? ? ? ?TST_PASS = 0;                                       
>      ? ? ? ? ? ?\
>     +                                                                   
>      ? ? \
>     +? ? ? ? ? ? ? ?if (TST_RET != VAL) {                               
>      ? ? ? ? ? ?\
>     +? ? ? ? ? ? ? ? ? ? ? ?TST_MSGP_(TFAIL | TTERRNO, " retval not
>     %ld",? ? ? ? ? ? ? ?\
>     +? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(long )VAL, SSCALL,
>     ##__VA_ARGS__);? ? ? ? ? ? ? ?\
>     +? ? ? ? ? ? ? ? ? ? ? ?break;                                     
>      ? ? ? ? ? ? ? ? \
>     +? ? ? ? ? ? ? ?}                                                   
>      ? ? ? ? ? ?\
>     +                                                                   
>      ? ? \
>     +? ? ? ? ? ? ? ?TST_PASS = 1;                                       
>      ? ? ? ? ? ?\
>     +                                                                   
>      ? ? \
>     +? ? ? ?} while (0)
>     +
>     +#define TST_EXP_VAL_SILENT(SCALL, VAL, ...)
>     TST_EXP_VAL_SILENT_(SCALL, #SCALL, VAL, ##__VA_ARGS__)
>     +
>     +#define TST_EXP_VAL(SCALL, VAL, ...)                               
>      ? ? \
>     +? ? ? ?do {                                                       
>      ? ? ? ? \
>     +? ? ? ? ? ? ? ?TST_EXP_VAL_SILENT(SCALL, VAL, ##__VA_ARGS__);     
>      ? ? ? ? ? ? \
>     +                                                                   
>      ? ? \
>     +? ? ? ? ? ? ? ?if (TST_PASS)                                       
>      ? ? ? ? ? ?\
>     +? ? ? ? ? ? ? ? ? ? ? ?TST_MSG_(TPASS, " passed", #SCALL,
>     ##__VA_ARGS__);? ? ? ? ? \
>     +                                                                   
>      ? ? \
>     +? ? ? ?} while(0)
>     +
>      ?#define TST_EXP_FAIL_(PASS_COND, SCALL, SSCALL, ERRNO, ...)       
>      ? ? ? ? ? ? \
>      ? ? ? ? do {                                                       
>      ? ? ? ? ? ?\
>      ? ? ? ? ? ? ? ? TEST(SCALL);                                       
>      ? ? ? ? ? ?\
>     --
>     2.20.1
> 
> 
> 
> 
>     -- 
>     Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> 
> 
> -- 
> Regards,
> Li Wang

-- 
Regards,
Zhang Lianjie


