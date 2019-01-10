From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 10 Jan 2019 10:50:52 +0100
Subject: [LTP] [PATCH] Check recvmmsg exists before entering fuzzy loop
In-Reply-To: <CAEemH2cRO5PytjrqvFjCnUji+XQ7KeaXua+DDzxOT7Eu3+Wd2A@mail.gmail.com>
References: <20190109120129.GA19502@rei>
 <20190109133205.31061-1-rpalethorpe@suse.com>
 <CAEemH2cRO5PytjrqvFjCnUji+XQ7KeaXua+DDzxOT7Eu3+Wd2A@mail.gmail.com>
Message-ID: <871s5kn8n7.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
>> Avoid thread B entering infinite loop if recvmmsg doesn't exist causing
>> tst_brk to be called and thread A to make an ungraceful exit.
>>
>> A more general fix can be added to tst_fuzzy_sync as well, but will take
>> longer to develop.
>
> Yes, now we just add a syscall checking in setup() as a workaround,
> for the fzsync library issue we could take more time to find a best
> solution after this new LTP releasing.
>
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> Reported-by: Li Wang <liwang@redhat.com>
>> ---
>>  testcases/cve/cve-2016-7117.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
>> index 6290af077..effab083d 100644
>> --- a/testcases/cve/cve-2016-7117.c
>> +++ b/testcases/cve/cve-2016-7117.c
>> @@ -99,6 +99,10 @@ static void setup(void)
>>  {
>>         fzsync_pair.min_samples = 10000;
>>
>> +       tst_syscall(__NR_recvmmsg);
>
> maybe adding with useless parameters?
>   tst_syscall(__NR_recvmmsg, 0 ,0, 0, 0, 0);

I'm not sure it is necessary, but it is probably safer, so I will change
it.

>
>> +       if (errno == ENOSYS)
>> +               tst_brk(TCONF, "recvmmsg not supported");
>
> Seems errno check is not necessary here, the macro tst_syscall() has
> already defined with tst_brk(TCONF,) calling when errno is ENOSYS.
>
> FYI:
>
> #define tst_syscall(NR, ...) ({ \\
>         int tst_ret; \\
>         if (NR == __LTP__NR_INVALID_SYSCALL) { \\
>                 errno = ENOSYS; \\
>                 tst_ret = -1; \\
>         } else { \\
>                 tst_ret = syscall(NR, ##__VA_ARGS__); \\
>         } \\

Ah I misread the if statement, thanks.

>         if (tst_ret == -1 && errno == ENOSYS) { \\
>                 tst_brk(TCONF, "syscall(%d) " #NR " not supported", NR); \\
>         } \\
>         tst_ret; \\
> })
>
>> +
>>         tst_fzsync_pair_init(&fzsync_pair);
>>  }
>
>>
>> --
>> 2.19.1
>>


--
Thank you,
Richard.
