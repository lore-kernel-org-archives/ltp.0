From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Fri, 19 Mar 2021 08:44:33 +0000
Subject: [LTP] [PATCH] syscalls/semctl09: Skip libc test if SEM_STAT_ANY
 not defined
In-Reply-To: <YFRgzbKPtVBK/l5d@pevik>
References: <20210318162409.9871-1-mdoucha@suse.cz> <YFOcOJP4innlbIk4@pevik>
 <920d81b2-567a-4e28-58f7-b27151b1cad7@163.com> <YFRgzbKPtVBK/l5d@pevik>
Message-ID: <60546464.1090002@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
> Hi Xu,
>
>>>> +	if (tst_variant == 1)
>>>> +		tst_brk(TCONF, "libc does not support semctl(SEM_STAT_ANY)");
>>>> +#endif
>>> Although I understand why you want to quit only tests with root
>>> (only these fail), it's a bit confusing to test with user nobody
>>> and then quit the same testing with root.
>
>> I don't get this.  Martin only wants to skip libc test when undefined and it
>> doesn't matter which user we use.
>
> if (tst_variant == 1)
> 	tst_brk(TCONF, "libc does not support semctl(SEM_STAT_ANY)");
>
> means:
>
> # /semctl09
> tst_test.c:1289: TINFO: Timeout per run is 0h 05m 00s
> semctl09.c:76: TINFO: Test SYS_semctl syscall
> semctl09.c:141: TINFO: Test SEM_STAT_ANY with nobody user
> semctl09.c:163: TPASS: SEM_INFO returned valid index 19 to semid 19
> semctl09.c:173: TPASS: Counted used = 1
> semctl09.c:121: TPASS: semset_cnt = 1
> semctl09.c:128: TPASS: sen_cnt = 2
> semctl09.c:141: TINFO: Test SEM_STAT_ANY with root user
> semctl09.c:163: TPASS: SEM_INFO returned valid index 19 to semid 19
> semctl09.c:173: TPASS: Counted used = 1
> semctl09.c:121: TPASS: semset_cnt = 1
> semctl09.c:128: TPASS: sen_cnt = 2
> tst_test.c:1289: TINFO: Timeout per run is 0h 05m 00s
> semctl09.c:191: TCONF: libc does not support semctl(SEM_STAT_ANY)
>
> i.e. run first test with user nobody and skip the second.
> It's a bit confusing to test anything with SEM_STAT_ANY and then state
> TCONF: libc does not support semctl(SEM_STAT_ANY) :)
Thanks. I got it.
I guess we can move this check into test_info as below:

--- a/testcases/kernel/syscalls/ipc/semctl/semctl09.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
@@ -77,6 +77,9 @@ static void test_info(void)
         break;
         case 1:
                 tst_res(TINFO, "Test libc semctl()");
+#ifndef HAVE_DECL_SEM_STAT_ANY
+               tst_brk(TCONF, "libc does not support 
semctl(SEM_STAT_ANY)");
+#endif
         break;

Then output as below:
# ./semctl09
tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
semctl09.c:76: TINFO: Test SYS_semctl syscall
semctl09.c:144: TINFO: Test SEM_STAT_ANY with nobody user
semctl09.c:167: TPASS: SEM_INFO returned valid index 34 to semid 34
semctl09.c:176: TPASS: Counted used = 1
semctl09.c:124: TPASS: semset_cnt = 1
semctl09.c:131: TPASS: sen_cnt = 2
semctl09.c:144: TINFO: Test SEM_STAT_ANY with root user
semctl09.c:167: TPASS: SEM_INFO returned valid index 34 to semid 34
semctl09.c:176: TPASS: Counted used = 1
semctl09.c:124: TPASS: semset_cnt = 1
semctl09.c:131: TPASS: sen_cnt = 2
tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
semctl09.c:79: TINFO: Test libc semctl()
semctl09.c:81: TCONF: libc does not support semctl(SEM_STAT_ANY)


>
> Kind regards,
> Petr
>
