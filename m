From: Li Wang <liwang@redhat.com>
Date: Wed, 1 Nov 2017 10:47:21 +0800
Subject: [LTP] [PATCH v2] ltp: remove .tid from test struct
In-Reply-To: <20171031172950.GA30431@rei.lan>
References: <20171025100631.9218-1-liwang@redhat.com>
 <20171031172950.GA30431@rei.lan>
Message-ID: <CAEemH2fJVftwMi=QHRhv33PX2pGhd+3V6MWzk=NvdayVUMFNvQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 1, 2017 at 1:29 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
>> index 9562005..ed9c73c 100644
>> --- a/include/tst_safe_macros.h
>> +++ b/include/tst_safe_macros.h
>> @@ -406,7 +406,7 @@ static inline sighandler_t safe_signal(const char *file, const int lineno,
>>  #define SAFE_EXECL(file, arg, ...) do {                              \
>>         execl((file), (arg), ##__VA_ARGS__);                  \
>>         tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,          \
>> -                "execlp(%s, %s, ...) failed", file, arg);    \
>> +                "execl(%s, %s, ...) failed", file, arg);     \
>>         } while (0)
>
> This should be now really send in a separate patch, since the rest of
> the patchset is not a simple typo anymore.

Sure.

>
>> diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
>> index cd4ebca..fc6cbf1 100644
>> --- a/lib/tst_timer_test.c
>> +++ b/lib/tst_timer_test.c
>> @@ -455,14 +455,13 @@ static void parse_timer_opts(void)
>>       }
>>  }
>>
>> -struct tst_test *tst_timer_test_setup(struct tst_test *timer_test)
>> +struct tst_test *tst_timer_test_setup(const char *tid, struct tst_test *timer_test)
>>  {
>> +     scall = tid;
>>       setup = timer_test->setup;
>>       cleanup = timer_test->cleanup;
>> -     scall = timer_test->tid;
>>       sample = timer_test->sample;
>>
>> -     timer_test->tid = NULL;
>>       timer_test->setup = timer_setup;
>>       timer_test->cleanup = timer_cleanup;
>>       timer_test->test = timer_test_fn;
>
> I guess that I would rather see the syscall name to be set in the test
> structure rather than using the test file name for the timer testcases.

Sounds good. That will be more precise in the printed LTP messages.
The '.scall' (syscall name) should be set in real tests by manual then.

>
> So what about passing it in the test structure as an newly added scall
> string pointer?

Sure. Patch V3 is coming...

>
> Otherwise the rest of the patchset is fine.
>
> --
> Cyril Hrubis
> chrubis@suse.cz



-- 
Li Wang
liwang@redhat.com
