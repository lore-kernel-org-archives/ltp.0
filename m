From: Enji Cooper <yaneurabeya@gmail.com>
Date: Mon, 16 Mar 2020 18:13:14 -0700
Subject: [LTP] [PATCH] pthread_cond_init/s-c.c: Add the lose ifndef line
In-Reply-To: <7017e8bc-616b-0958-b82e-852604c06a3b@cn.fujitsu.com>
References: <1584327515-74727-1-git-send-email-zou_wei@huawei.com>
 <8eec82a7-f9eb-1002-ee86-71b94a55bdf4@cn.fujitsu.com>
 <7017e8bc-616b-0958-b82e-852604c06a3b@cn.fujitsu.com>
Message-ID: <F8D00AA0-47E2-4636-9A07-77B474C47003@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,
	I?ll have to look back, but this might have been the original set of items which never compiled/built cleanly.
	I think it?s time to go back to a more sane gmake-based build framework. My goal in making things work with POSIX make was noble for the time but it seems incredibly unnecessary now and I think it?s overcomplicating things.
Thanks!
-Enji

> On Mar 16, 2020, at 12:53 AM, Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:
> 
> Hi Cyril
> 
> On my environment, when I test openposix, this case missed run and complie because locate-test has filter rules called by open_posix_testsuite/scripts/generate-makefiles.sh.  filter rules as below:
> 
> runnable)
>        find "$WHERE/conformance" "$WHERE/stress" -type f -name '*[0-9].c' -o -name '[0-9]*-[0-9]*.sh' | grep -v buildonly | grep -v '^./tools'
>        find "$WHERE/functional" -type f -name '*.c'
> 
> I have a question why we leave it here if they are no meaningful. If
> it was meaningful, why we filter this case? I see the history, but found no thing.
> 
> @Enji, you often change openposix code, can you give me some advise?
> 
> Best Regards
> Yang Xu
> 
>> Hi Zou
>> It was introduced by commit 310c9eb6e6("Remove explicit #define's for `_POSIX_C_SOURCE` and `_XOPEN_SOURCE`").
>> IMO, we can remove this WITHOUT_XOPEN macro directly because we have setted -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 in ltp/testcases/open_posix_testsuite/CFLAGS.
>> Best Regards
>> Yang Xu
>>> pthread_cond_init/s-c.c testcase lose a #ifndef line, fix it
>>> 
>>> Reported-by: Zou Wei <zou_wei@huawei.com>
>>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
>>> ---
>>>  testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>> 
>>> diff --git a/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.c b/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.c 
>>> index 6a5c70a..8d18484 100644
>>> --- a/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.c
>>> +++ b/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.c
>>> @@ -80,6 +80,7 @@
>>>   /***********************************    Test case   *****************************************/
>>>  /********************************************************************************************/ 
>>> +#ifndef WITHOUT_XOPEN
>>>   typedef struct _teststruct {
>>>       pthread_cond_t cnd[10 * SCALABILITY_FACTOR];
>>>       pthread_condattr_t ca[4];
>>> -- 
>>> 2.6.2
>>> 
>>> 
> 
> 

