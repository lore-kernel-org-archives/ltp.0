From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 17 Mar 2020 13:52:46 +0800
Subject: [LTP] 
 =?utf-8?b?562U5aSNOiAgW1BBVENIXSBwdGhyZWFkX2NvbmRfaW5pdC9z?=
 =?utf-8?q?-c=2Ec=3A_Add_the_lose_ifndef_line?=
In-Reply-To: <C3CD0DF8AD11A84CB25A1426DE537C61E590FAF6@dggeml524-mbx.china.huawei.com>
References: <1584327515-74727-1-git-send-email-zou_wei@huawei.com>
 <8eec82a7-f9eb-1002-ee86-71b94a55bdf4@cn.fujitsu.com>
 <b9c6b8c9-987b-fc71-4a5c-0844ea63d7ff@cn.fujitsu.com>
 <C3CD0DF8AD11A84CB25A1426DE537C61E590FAF6@dggeml524-mbx.china.huawei.com>
Message-ID: <5E7065AE.8080900@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/3/17 11:06, Zouwei (Samuel) wrote:
> Hi Xu
>
> Thanks for your answers and reviews.
>
> When I used the open-posix testsuite, I modified multiple files before compiling successfully.
>
> It is hoped that in future LTP release versions, open-posix can be automatically enabled and can be successfully compiled without modification.
Hi Zou,

You can send some patches to fix them directly.

Thanks,
Xiao Yang
>
> BTW, The files I modified are as follows:
> ltp/testcases/Makefile
> @@ -30,9 +30,9 @@ include $(top_srcdir)/include/mk/env_pre.mk
>   #    run).
>   FILTER_OUT_DIRS                := kdump
>
> -ifneq ($(WITH_OPEN_POSIX_TESTSUITE),yes)
> -FILTER_OUT_DIRS                += open_posix_testsuite
> -endif
>
>   ifneq ($(WITH_REALTIME_TESTSUITE),yes)
>   FILTER_OUT_DIRS                += realtime
>
> ltp/testcases/open_posix_testsuite/LDFLAGS
> @@ -0,0 +1 @@
> +-lpthread -lrt -lm
>
> ltp/testcases/open_posix_testsuite/functional/Makefile
> @@ -5,7 +5,7 @@
>   #
>
>   all clean install test:
> -	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
> +	@for dir in `find . -name *Makefile | egrep -v '^./Makefile' | sed -e 's,/Makefile$$,,g'`; do \
>   		$(MAKE) -C $$dir $@;						   \
>   	done
>
> ltp/testcases/open_posix_testsuite/scripts/locate-test
> @@ -92,7 +92,8 @@ runnable)
>   	# waltz down the tools directory and try and build t0 (which doesn't
>   	# make sense as it's a tool, not a test). Better criterion needs to
>   	# be established for this file.
> -	find "$WHERE/conformance" "$WHERE/stress" -type f -name '*[0-9].c' -o -name '[0-9]*-[0-9]*.sh' | grep -v buildonly | grep -v '^./tools'
> +	find "$WHERE/conformance" "$WHERE/stress" -type f -name '*[0-9a-z].c' -o -name '[0-9]*-[0-9]*.sh' | grep -v buildonly | grep -v '^./tools' | grep -v 'testfrmw.c$'
>   	find "$WHERE/functional" -type f -name '*.c'
>   	;;
>   test-tools)
>
> ltp/testcases/open_posix_testsuite/stress/Makefile
> @@ -5,7 +5,7 @@
>   #
>
>   all clean install test:
> -	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
> +	@for dir in `find . -name *Makefile | egrep -v '^./Makefile' | sed -e 's,/Makefile$$,,g'`; do \
>   		$(MAKE) -C $$dir $@;						  \
>   	done
>
> Best Regards
> Zou Wei
> -----????-----
> ???: Yang Xu [mailto:xuyang2018.jy@cn.fujitsu.com]
> ????: 2020?3?17? 10:08
> ???: Zouwei (Samuel)<zou_wei@huawei.com>
> ??: ltp@lists.linux.it
> ??: Re: [LTP] [PATCH] pthread_cond_init/s-c.c: Add the lose ifndef line
>
> Hi Zou
>
> Even this case does't compile or run on ltp default envrionment, I think it is a framework problem about ltp openposix. This fix is obviously correct and simple.
>
> Reviewed-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>
> Someone who merging this patch can add fixes tag.
>
>    Fixes: 310c9eb6e ("Remove explicit #define's for `_POSIX_C_SOURCE` and
> `_XOPEN_SOURCE`")
>
> Best Regards
> Yang Xu
>
>> Hi Zou
>>
>> It was introduced by commit 310c9eb6e6("Remove explicit #define's for
>> `_POSIX_C_SOURCE` and `_XOPEN_SOURCE`").
>>
>> IMO, we can remove this WITHOUT_XOPEN macro directly because we have
>> setted -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 in
>> ltp/testcases/open_posix_testsuite/CFLAGS.
>>
>> Best Regards
>> Yang Xu
>>> pthread_cond_init/s-c.c testcase lose a #ifndef line, fix it
>>>
>>> Reported-by: Zou Wei<zou_wei@huawei.com>
>>> Signed-off-by: Zou Wei<zou_wei@huawei.com>
>>> ---
>>>
>>> testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.c
>>> | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git
>>> a/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c
>>> .c
>>> b/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c
>>> .c
>>>
>>> index 6a5c70a..8d18484 100644
>>> ---
>>> a/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c
>>> .c
>>> +++
>>> b/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c
>>> .c
>>> @@ -80,6 +80,7 @@
>>>    /***********************************    Test case
>>> *****************************************/
>>>
>>> /********************************************************************
>>> ************************/
>>>
>>> +#ifndef WITHOUT_XOPEN
>>>    typedef struct _teststruct {
>>>        pthread_cond_t cnd[10 * SCALABILITY_FACTOR];
>>>        pthread_condattr_t ca[4];
>>> --
>>> 2.6.2
>>>
>>>
>>
>>
>>
>
>
>



