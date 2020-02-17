From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 17 Feb 2020 15:16:06 +0100
Subject: [LTP] [PATCH v2 1/3] Redesign TST_RETRY_FUNC()
In-Reply-To: <CAEemH2dEco268yqDyDjX25FPs3V7wTBija4HiMrf8nr0W7qVQQ@mail.gmail.com>
References: <20200207112236.16462-1-mdoucha@suse.cz>
 <CAEemH2dEco268yqDyDjX25FPs3V7wTBija4HiMrf8nr0W7qVQQ@mail.gmail.com>
Message-ID: <0090dabb-76fa-ea3d-2f96-4c4e50146bba@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2/8/20 7:35 AM, Li Wang wrote:
> 1. We need to update the doc/test-writing-guidelines.txt?too.

Right. I'll resubmit in a moment.

> 2. Maybe better to let the shell version is consistent with this new?

That doesn't make much sense. Shell programs and functions have much
simpler call conventions than C functions. If you really need to test a
more complex result than a single return value in shell, writing a
wrapper function is much easier than writing a validator function.

In C, it's the other way around. Writing a wrapper function would often
be a ton of work compared to writing a simple retval validator macro.

> 3. I remember there were discussions to support enabling infinite loop
> in?TST_RETRY_FUNC, but not sure if it is possible to add in this patch,
> or we can do that after your patch merged.
> http://lists.linux.it/pipermail/ltp/2019-October/013896.html

I'll leave that to someone else. Though I'd say that timeout of
(1ULL<<40) should be infinite enough for everybody. All we need to do is
change tst_delay_ and tst_max_delay_ type to unsigned long long.

>     ...
>     ? ? ? ? sprintf(defunct_tid_path, "/proc/%d/task/%d", getpid(),
>     defunct_tid);
>     -? ? ? ?TST_RETRY_FN_EXP_BACKOFF(access(defunct_tid_path, R_OK), -1,
>     15);
>     +? ? ? ?ret = TST_RETRY_FN_EXP_BACKOFF(access(defunct_tid_path, R_OK),
>     +? ? ? ? ? ? ? ?CHECK_ENOENT, 15);
> 
> 
> The test total timeout is set to 20 seconds, here reserve 15 seconds is
> too much for the macro looping because doing exponential backoff in
> 15secs(1us+2us+4us+..) actually larger than the 20secs. So I suggest
> raising the tst_test.timeout?at the same time or set a smaller value to
> MAX_DELAY.

Actually, this entire retry loop will never take longer than 17 seconds.
The last single delay will be at most 8.4 seconds (2^23 microseconds)
long and the total combined delay before that will also take 8.4
seconds. The next delay would be 16.8 seconds which is too much so the
loop will end. The main test function takes only a few milliseconds so
there's no problem even in the worst case scenario.

I can change the delay to 9 seconds if you want. It'll make no
difference in practice but the code will be less confusing to humans.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
